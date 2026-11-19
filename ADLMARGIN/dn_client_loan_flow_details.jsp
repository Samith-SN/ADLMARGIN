        <%@page import="java.text.SimpleDateFormat" %>
        <%@page import="java.util.Calendar" %>
        <%@page import="java.util.Date" %>
        <%@page import="net.sasianet.ADLMARGIN.*" %>
        <%@page import="java.sql.*" %>
<%
            session = request.getSession(true);
	        ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
	
		//***************  ADDED BY KANISHKA ON 26/12/2012  *********************//
	
		Object done = (String)session.getValue("logon.isDone");  // marker object
		if (done == null) {
			response.sendRedirect("login.jsp");
			return;
			}
	
	//*************** ADDED BY KANISHKA ON 26/12/2012 [END]  *********************//
	
	        Connection conn = m_sn_methods.met_user_validate(session);
			Statement stmt = conn.createStatement ();
	        Statement stmt2 = conn.createStatement ();
             Calendar calendar = Calendar.getInstance();
            
	        String m_jsp_client_url = m_sn_methods.jsp_client_url;
            String m_schema_name    = m_sn_methods.schema_name.trim();
	
            String system_day   = Integer.toString(calendar.get(Calendar.DATE));
            String system_month = Integer.toString(calendar.get(Calendar.MONTH) + 1);
            String system_year  = Integer.toString(calendar.get(Calendar.YEAR));
            
            if (calendar.get(Calendar.DATE) < 10) {
                system_day = "0" + calendar.get(Calendar.DATE);
            }
            if (calendar.get(Calendar.MONTH) + 1 < 10) {
                system_month = "0" + (calendar.get(Calendar.MONTH) + 1);
            }
	
	    String m_branch ="";
	    ResultSet rs2 = stmt2.executeQuery ("SELECT A.BRANCH_CODE "+
					"FROM   "+m_schema_name+".DN_REF_BANK A "+
					"WHERE  ACTIVE_STATUS='Y' ORDER BY A.BRANCH_CODE  ");
						
				boolean more2 = rs2.next();
			   
				
				while (more2) {
					m_branch = m_branch+"<option value='"+rs2.getString(1)+"'>"+rs2.getString(1)+"";
					more2 = rs2.next();
				}
	
		String m_facility_no =request.getParameter("facility_no");
	    String m_deal_no =request.getParameter("deal_no");
	    String m_deal_no_original =request.getParameter("deal_no_original");

        %>
<html>
    <head>
	<title>Margin Trading</title>	
	 <script type="text/javascript" src="<%= m_jsp_client_url %>/js/jquery.min.js"></script>
        <script type="text/javascript" src="<%= m_jsp_client_url %>/js/jquery-ui.min.js"></script>
        <script type="text/javascript" src="<%= m_jsp_client_url %>/js/json2.js"></script> 
        <script type="text/javascript" src="<%= m_jsp_client_url %>/js/popup.js"></script>
        <script type="text/javascript" src="<%= m_jsp_client_url %>/SNET/jquery/grid/4.1/js/i18n/grid.locale-en.js"></script>
        <script type="text/javascript" src="<%= m_jsp_client_url %>/SNET/jquery/grid/4.1/js/jquery.jqGrid.min.js"></script>
        <script type="text/javascript" src="validate_v1.js"></script>
        <script type="text/javascript" src="ajax_data_gateway.js"></script> 
        
        <link rel="stylesheet" type="text/css" href="<%= m_jsp_client_url %>/css/Asset_Financing_System.css" />
        <link rel="stylesheet" type="text/css" href="<%= m_jsp_client_url %>/css/redmond/jquery-ui.css" />
        <link rel="stylesheet" type="text/css" href="<%= m_jsp_client_url %>/css/ui.jqgrid.css" />

		
	    <script type="text/javascript">
			
			var m_sysdate_dd =  '<%=request.getParameter("to_date")%>';
			var m_sysdate_mm =  '<%=request.getParameter("to_month")%>';
			var m_sysdate_yy =  '<%=request.getParameter("to_year")%>';
			
		    var m_sysdate = '<%=request.getParameter("to_date")+"-"+request.getParameter("to_month")+"-"+request.getParameter("to_year")%>';
			var iframe_html_string = '<iframe id = "IFRAME_DRILL_DOWN" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Drill Down"></iframe>';
		    var iframe_html_string_2 = '<iframe id = "IFRAME_DRILL_DOWN_2" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Drill Down"></iframe>';		
		           
			
			
			$(document).ready(function() {
					// init_fancybox();
					//initDrillDownDialog()
					//call_frame();	
				    m_grid_height = ($(window).height() - 310);
					m_grid_height = ($(window).height() - 200);
					m_grid_width = ($(window).width() - 0);
					initCal('VAL_TXT_DATE');
					//loadGridReceiptsAppove();
					//initDrillDownDialog();
					//bind_events();
					loadGridLoanSummary();
					loadGridLoanSchedule();
					loadGridloanSettleReceipt();
				});
			
				function initDrillDownDialog(){
				$('#DIV_DRILL_DOWN').dialog({
						bgiframe: true,
						autoOpen: false,
						modal: false,
						height: 500,
						width: getW
					});
				$('#DIV_DRILL_DOWN_2').dialog({
						bgiframe: true,
						autoOpen: false,
						modal: false,
						height: 500,
						width: getW
					});
			    }	
			function getW() {
				var w = 0;
				if (window.document.innerWidth > w) {
					w = window.document.innerWidth;
				}
				if (window.document.documentElement.clientWidth > w) {
					w = window.document.documentElement.clientWidth;
				}
				return (w - 100);
			} 
			
			function initCal(m_id) {
				$('#' + m_id).datepicker({
						dateFormat: 'dd-mm-yy',
						duration: 'fast',
						yearRange: '1920:2050',
						showOn: 'button',
						buttonImage: '<%=m_jsp_client_url%>/SNET/images/calendar.gif',
						buttonImageOnly: true,
						changeMonth: true,
						changeYear: true,
						onSelect: function(dateText, inst) {
							dateSelectFunc(dateText,inst);
						}
					});
			}
			
			function dateSelectFunc(dateText, inst) {
               var splitResult = dateText.split('-');
               var instance_id = inst.id;
				
			   var instance_id_label           = instance_id.substring(0, 16);
			   var instance_id_subgrid_type    = instance_id.substring(17, instance_id.lastIndexOf('_'));
			   var instance_id_rowid           = instance_id.substring(instance_id.lastIndexOf('_') + 1);
				
               var m_last_index_of_underscore = instance_id.lastIndexOf('_');
		       var first_part = instance_id.substr(0, m_last_index_of_underscore + 1);
               var second_part = instance_id.substr(m_last_index_of_underscore + 1);
				
			   var textbox_day_id              = instance_id_label + '_DD_' + instance_id_subgrid_type + '_' + instance_id_rowid;
			   var textbox_month_id            = instance_id_label + '_MM_' + instance_id_subgrid_type + '_' + instance_id_rowid;
			   var textbox_year_id             = instance_id_label + '_YY_' + instance_id_subgrid_type + '_' + instance_id_rowid;
				
			   var sysdate_object = new Date(m_sysdate_yy, m_sysdate_mm - 1, m_sysdate_dd);
			   var new_date_object = new Date(splitResult[2], splitResult[1] - 1, splitResult[0]);	
			
				
               if (instance_id == "VAL_TXT_DATE") {
                   document.Form1.TXT_TODATE.value = splitResult[0];
                   document.Form1.TXT_TOMONTH.value = splitResult[1];
                   document.Form1.TXT_TOYEAR.value = splitResult[2];
                   document.Form1.TXT_TOYEAR.focus();
               }
          
              if (instance_id_label == 'TXT_BANKING_DATE') {
				if (new_date_object < sysdate_object) {
				       alert('Date cannot be in the past.');
						$('#' + hidden_id).val(m_sysdate);
						$('#' + textbox_day_id).val(m_sysdate_dd);
						$('#' + textbox_month_id).val(m_sysdate_mm);
						$('#' + textbox_year_id).val(m_sysdate_yy);
						$('#' + textbox_day_id).select();	
				}else{	
				   $('#' + textbox_day_id).val(splitResult[0]);
				   $('#' + textbox_month_id).val(splitResult[1]);
				   $('#' + textbox_year_id).val(splitResult[2]);	
					
				}	
			   }
				
			if (instance_id_label == 'TXT_REALIZA_DATE') {
				if (new_date_object < sysdate_object) {
				       alert('Date cannot be in the past.');
						$('#' + hidden_id).val(m_sysdate);
						$('#' + textbox_day_id).val(m_sysdate_dd);
						$('#' + textbox_month_id).val(m_sysdate_mm);
						$('#' + textbox_year_id).val(m_sysdate_yy);
						$('#' + textbox_day_id).select();	
				}else{	
				   $('#' + textbox_day_id).val(splitResult[0]);
				   $('#' + textbox_month_id).val(splitResult[1]);
				   $('#' + textbox_year_id).val(splitResult[2]);	
			      }	
				
				}	
				
				
           }
		//$(document).ready(function() {
		
			//loadGridReceiptsAppove();
			
			// });
		
		function fn_veiwall(){
			fnCancel();
			loadGridReceiptsAppove();
		}	
			
		function loadGridLoanSummary() {
          
				
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"loan_detail?chksql=loan_summery_rpt&facility_no=<%=m_facility_no%>&deal_no=<%=m_deal_no%>&deal_no_original=<%=m_deal_no_original%>";	
			jQuery('#TABLE_CLIENT_LOAN_SUMMARY').jqGrid({
                   url: m_url,
                   loadonce: 1,
                   datatype: 'json',
                   colNames: [
                       '',
                       ''
                   ],
                   colModel: [
						{name: 'SUMMARY_COL_1',        index: 'SUMMARY_COL_1',     sortable: false,    align: 'left',     width: 200,     resizable: false,		jsonmap: 'label'},
						{name: 'SUMMARY_COL_2',        index: 'SUMMARY_COL_2',     sortable: false,    align: 'left',    width:  85,     resizable: false,		jsonmap: 'value' }//,formatter: cellFomattersummercol2, unformat: unformatData2
                   ],
                   // rowNum:10, 
					//rowList:[10,20,30],
				   mtype: 'GET',
                   rownumbers: false,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
				   //onCellSelect: jq_grid_click_event_sales_ledger,
                   caption: '<div id = "DIV_CLIENT_PAYMENT_REPORT_CAPTION" style = "width: 150px; text-align: center; font-size: 12px;">Resale Agreement Summary</div>',
					jsonReader: {
						repeatitems: false
					}
              
                  
                  
               });
			}
			
			function loadGridLoanSchedule() {
				
				
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"loan_detail?chksql=loan_schedule_rpt&facility_no=<%=m_facility_no%>&deal_no=<%=m_deal_no%>&deal_no_original=<%=m_deal_no_original%>";
				
				//jQuery('#DIV_CLIENT_LOAN_SCHEDULE').GridUnload();
				jQuery('#TABLE_CLIENT_LOAN_SCHEDULE').jqGrid({
						url: m_url,
						//loadonce: 1,
						datatype: 'json',
						colNames: ['Due Date','Due Amount','Frequency'],
						colModel: [
							{name: 'due_date',            index: 'due_date',   		jsonmap: 'due_date',        sortable: false, align: 'center',   width: 90,  resizable: false,     unformat: unformatData },
							{name: 'due_amount',         index: 'due_amount',   	jsonmap: 'due_amount', 	    sortable: false, align: 'right',   width: 100, resizable: true,      unformat: unformatData },
							{name: 'freq_no',            index: 'freq_no',   	    jsonmap: 'freq_no', 	    sortable: false, align: 'right',   width: 120, resizable: true,      unformat: unformatData   }
							],
						mtype: 'GET',
						rownumbers: true,
						rowNum: -1,
						gridview: true,
						height: 'auto',
						hidegrid: false,
						toolbar: [false, 'top'],
						footerrow: true,
						userDataOnFooter: true,
				        caption: 'Expect Payments Flow',
						jsonReader: {repeatitems: false},
						//onCellSelect: jq_grid_click_event_broker_rec,			
						gridComplete: function() {
																
							
						},
						loadComplete : function(){
							
						}
					});
				
			}
			
			function loadGridloanSettleReceipt() {
					
		  
					
               jQuery('#TABLE_CLIENT_SETTL_RECEIPT').GridUnload();
               m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"loan_detail?chksql=bulk_receipt_approve&facility_no=<%=m_facility_no%>&deal_no=<%=m_deal_no%>&deal_no_original=<%=m_deal_no_original%>";
					jQuery('#TABLE_CLIENT_SETTL_RECEIPT').jqGrid({
                   url: m_url,
                   //loadonce: 1,
                   datatype: 'json',
                   colNames: ['Receipt No','Broker','Client Manager','Facility Number','Client Name' ,'Receipt Amount','Value Date','Transation Date','Mode', 'Company Bank Account', 'Cheque No.','Branch Code','Banking Date','Realizattion Date','Settlement Mode','Comments'],
                   colModel: [
						{name: 'Receipt_No',             index: 'Receipt_No',   		jsonmap: 'Receipt_No',          sortable: false, align: 'center', width: 90,   resizable: false,  unformat: unformatData ,formatter:cellFomatterReceiptNo},//formatter: cellFomatterReceiptsColumn_1,
						{name: 'Broker',                 index: 'Broker',      	        jsonmap: 'Broker', 		        sortable: false, align: 'center', width: 50,   resizable: false,  unformat: unformatData},//formatter: cellFomatterReceiptsColumn_5,
						{name: 'Client_Manager',         index: 'Client_Manager',   	jsonmap: 'Client_Manager', 	    sortable: false, align: 'center', width: 90,   resizable: false,  unformat: unformatData},//formatter: cellFomatterReceiptsColumn_1,
						{name: 'Fasility_Number',        index: 'Fasility_Number',  	jsonmap: 'Fasility_Number', 	sortable: false, align: 'center', width: 80,   resizable: false,  unformat: unformatData},
						{name: 'Client_Name',            index: 'Client_Name',      	jsonmap: 'Client_Name', 		sortable: false, align: 'left',   width: 80,   resizable: true,   unformat: unformatData},//formatter: cellFomatterReceiptsColumn_2,
						
						{name: 'Receipt_Amount',         index: 'Receipt_Amount',   	jsonmap: 'Receipt_Amount',  	sortable: false, align: 'right',  width: 100,  resizable: false,  unformat: unformatData },//formatter: cellFomatterReceiptsColumn_6_0,
						{name: 'Value_Date',             index: 'Value_Date',       	jsonmap: 'Value_Date',  		sortable: false, align: 'right',  width: 60,   resizable: false,  unformat: unformatData },//formatter: cellFomatterReceiptsColumn_6,
						{name: 'Tran_Date',              index: 'Tran_Date',       		jsonmap: 'Tran_Date',    		sortable: false, align: 'right',  width: 60,   resizable: false,  unformat: unformatData },//formatter: cellFomatterReceiptsColumn_6,
						{name: 'Mode',                   index: 'Mode',             	jsonmap: 'Mode',  			    sortable: false, align: 'center', width: 80,   resizable: false,  unformat: unformatData },//formatter: cellFomatterReceiptsColumn_7, 
						{name: 'Company_Bank_Account',   index: 'Company_Bank_Account', jsonmap: 'Company_Bank_Account',sortable: false, align: 'center', width: 130,  resizable: false,  unformat: unformatData },//formatter: cellFomatterReceiptsColumn_8,
						
						{name: 'Cheque_Number',          index: 'Cheque_Number',        jsonmap: 'Cheque_Number',       sortable: false, align: 'center', width: 70,   resizable: false,  unformat: unformatData },
						{name: 'Branch_Code',            index: 'Branch_Code',          jsonmap: 'Branch_Code',         sortable: false, align: 'center', width: 70,   resizable: false,  unformat: unformatData },
						{name: 'Banking_Date',           index: 'Banking_Date',         jsonmap: 'Banking_Date',        sortable: false, align: 'center', width: 100,  resizable: false,  unformat: unformatData  },
						{name: 'Realizattion_Date',      index: 'Realizattion_Date',    jsonmap: 'Realizattion_Date',   sortable: false, align: 'center', width: 100,  resizable: false,  unformat: unformatData },
												
						{name: 'Settl_Mode',             index: 'Settl_Mode',           jsonmap: 'Settl_Mode',          sortable: false, align: 'center', width: 120,  resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_7, 
						{name: 'Comments',               index: 'Comments',            	jsonmap: 'Comments', 			sortable: false, align: 'center', width: 75,   resizable: false,  unformat: unformatData}//formatter: cellFomatterReceiptsColumn_9,
		                  ],
                   mtype: 'GET',
                   rownumbers: true,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
                   toolbar: [false, 'top'],
                   caption: 'Client Receipts',
				   footerrow: true,
				   userDataOnFooter: true,
				   jsonReader: {repeatitems: false},
                   gridComplete: function() {
				                    
                   	
					},
					loadComplete : function(){
                        
					}
               });
           }
			
			 function loadGridReceiptsAppove() {
            
		   var m_client_code    = document.getElementById("txt_client_code").value;
		   var m_client_manager = document.getElementById("TXT_CLIENT_MANAGER").value;
		   var m_port           = document.getElementById("txt_facility_number").value;
		   var m_broker_code    = document.getElementById("txt_broker_code").value;		
		   var m_to_date      = document.getElementById("TXT_TODATE").value+"-"+document.getElementById("TXT_TOMONTH").value+"-"+document.getElementById("TXT_TOYEAR").value;			
               m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"BrokerReceiptsLeve1?chksql=receipt_level2&port="+m_port+"&client_code="+m_client_code+"&client_manager="+m_client_manager+"&broker_code="+m_broker_code+"&to_date="+m_to_date;
					
					
					jQuery('#TABLE_CLIENT_RECEIPTS').GridUnload();
					jQuery('#TABLE_CLIENT_RECEIPTS').jqGrid({
                    url: m_url,
                   //loadonce: 1,
                   datatype: 'json',
                   colNames: ['Broker','Facility Number','Client Name','Due Receipts','Pending Receipts' ,'Total Receivable','Total Payable','Net Amount','Availability','Settlement of Due','Mode', 'Company Bank Account','Cheque No.','Branch Code','Banking Date','Realizattion Date', 'Comments',' Settlement Mode', 'Actual Margin (%)','Actual Margin (Market)','Save'],
                   colModel: [
						//{name: 'View',                  index: 'View',   		jsonmap: 'View',                        sortable: false, align: 'center', width: 90,  resizable: false,     unformat: unformatData, formatter:cellFomatterReceiptView},//formatter: cellFomatterReceiptsColumn_1,
						{name: 'Broker',                 index: 'Broker',   		    jsonmap: 'Broker',              sortable: false, align: 'center', width: 90,  resizable: false,     unformat: unformatData, formatter:cellFomatterBroker     },//formatter: cellFomatterReceiptsColumn_1,
						//{name: 'Broker_Name',            index: 'Broker_Name',   	    jsonmap: 'Broker_Name', 	    sortable: false, align: 'Left',   width: 100, resizable: true,      unformat: unformatData                                   },//formatter: cellFomatterReceiptsColumn_1,
						{name: 'Facility_No',            index: 'Facility_No',   	    jsonmap: 'Facility_No', 	    sortable: false, align: 'Left',   width: 100, resizable: true,      unformat: unformatData, formatter:cellFomatterFacilityNo },//formatter: cellFomatterReceiptsColumn_1,
						{name: 'Client_Name',            index: 'Client_Name',   	    jsonmap: 'Client_Name', 	    sortable: false, align: 'Left',   width: 100, resizable: true,      unformat: unformatData                                   },//formatter: cellFomatterReceiptsColumn_1,
						{name: 'Due_Receipts',           index: 'Due_Receipts',  	    jsonmap: 'Due_Receipts', 	    sortable: false, align: 'right' , width: 100, resizable: false,     unformat: unformatData, formatter:cellFomatterGroupRec                                    },
						{name: 'Pending_Receipts',       index: 'Pending_Receipts',    	jsonmap: 'Pending_Receipts', 	sortable: false, align: 'right',  width: 110, resizable: false,     unformat: unformatData, formatter:cellFomatterNumberPointer                                  },//formatter: cellFomatterReceiptsColumn_2,
						{name: 'Total_Receivable',       index: 'Total_Receivable',   	jsonmap: 'Total_Receivable',  	sortable: false, align: 'right',  width: 100, resizable: false,     unformat: unformatData },//formatter: cellFomatterGroupRec,
						{name: 'Total_Payable',          index: 'Total_Payable',     	jsonmap: 'Total_Payable',  	    sortable: false, align: 'right',  width: 100, resizable: false,     unformat: unformatData                                   },//formatter: cellFomatterReceiptsColumn_6,
						{name: 'Net_Amount',             index: 'Net_Amount',     		jsonmap: 'Net_Amount',    		sortable: false, align: 'right',  width: 100, resizable: false,     unformat: unformatData, formatter:cellFomatterNetRec     },//formatter: cellFomatterReceiptsColumn_6,
						{name: 'Availability',           index: 'Availability',        	jsonmap: 'Availability',  	    sortable: false, align: 'right',  width: 80,  resizable: false,     unformat: unformatData,  formatter:cellFomatterNumberAvailability },//formatter: cellFomatterReceiptsColumn_7, 
						{name: 'Settlement_of_Due',      index: 'Settlement_of_Due',    jsonmap: 'Due_Receipts',        sortable: false, align: 'center', width: 140, resizable: false,     unformat: unformatData, formatter:cellFomatterSettleOfDue  },//formatter: cellFomatterReceiptsColumn_7, 
						{name: 'Mode',                   index: 'Mode',             	jsonmap: 'Mode',  			    sortable: false, align: 'center', width: 80,  resizable: false,     unformat: unformatData, formatter:cellFomatterRecMode    },//formatter: cellFomatterReceiptsColumn_7, 
						{name: 'Company_Bank_Account',   index: 'Company_Bank_Account', jsonmap: 'Company_Bank_Account',sortable: false, align: 'center', width: 140, resizable: false,     unformat: unformatData, formatter:cellFomatterRecCompanyAccNo },//formatter: cellFomatterReceiptsColumn_8,
						
						{name: 'Cheque_Number',          index: 'Cheque_Number',          jsonmap: 'Cheque_Number',       sortable: false, align: 'center', width: 70, resizable: false,      unformat: unformatData, formatter:cellFomatterChequeNumber },
						{name: 'Branch_Code',            index: 'Branch_Code',          jsonmap: 'Branch_Code',         sortable: false, align: 'center', width: 70, resizable: false,      unformat: unformatData, formatter:cellFomatterBranchCode  },
						{name: 'Banking_Date',           index: 'Banking_Date',         jsonmap: 'Banking_Date',        sortable: false, align: 'center', width: 200, resizable: false,     unformat: unformatData, formatter:cellFomatterBankingDate  },
						{name: 'Realizattion_Date',      index: 'Realizattion_Date',    jsonmap: 'Realizattion_Date',   sortable: false, align: 'center', width: 160, resizable: false,     unformat: unformatData, formatter:cellFomatterRealizattionDate  },
						
						
						{name: 'Comments',               index: 'Comments',            	jsonmap: 'Comments', 			sortable: false, align: 'center', width: 120, resizable: false,     unformat: unformatData, formatter:cellFomatterRecComment },//formatter: cellFomatterReceiptsColumn_9,
						{name: 'Pay_Type',               index: 'Pay_Type',             jsonmap: 'Pay_Type',  			sortable: false, align: 'Cenete', width: 120, resizable: false,     unformat: unformatData, formatter:cellFomatterRecEntMode },//formatter: cellFomatterReceiptsColumn_7, 
						{name: 'Spot_Margin',             index: 'Spot_Margin',      	jsonmap: 'Spot_Margin',  		sortable: false, align: 'right',  width: 120, resizable: false,     unformat: unformatData,  formatter:cellFomatterNumber },//formatter: cellFomatterReceiptsColumn_7, 
						{name: 'Market_Margin',          index: 'Market_Margin',       	jsonmap: 'Market_Margin',  		sortable: false, align: 'right',  width: 120, resizable: false,     unformat: unformatData,  formatter:cellFomatterNumber },//formatter: cellFomatterReceiptsColumn_7, 
						{name: 'Save',                   index: 'Save',           	    jsonmap: 'Save', 			    sortable: false, align: 'center', width: 80,  resizable: false,     unformat: unformatData, formatter:checkBoxFmatterRecSave },
						],
                   mtype: 'GET',
                   rownumbers: true,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
                   toolbar: [false, 'top'],
                   caption: 'Broker Receipts - by Client',
				   jsonReader: {repeatitems: false},
				   footerrow: true,
                   userDataOnFooter: true,				
				   onCellSelect: jq_grid_click_event_broker_rec,			
                   gridComplete: function() {
						 
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_1').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_2').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_5').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_6_0').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_6').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_7').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_8').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_9').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_9_1').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_10').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_11').css('cursor', 'default');
                         
                      					
						
					},
					loadComplete : function(){
                        var rec_count=$("#TABLE_CLIENT_RECEIPTS").jqGrid('getGridParam',"records");
                        document.Form1.hid_count.value=rec_count;
						
						for(i=0;i<=rec_count;i++){
						initCal('TXT_BANKING_DATE_TABLE_CLIENT_RECEIPTS_'+i);
						initCal('TXT_REALIZA_DATE_TABLE_CLIENT_RECEIPTS_'+i);	
							
						}
						
					}
               });
           }
			
			function jq_grid_click_event_broker_rec(rowid, iCol, cellcontent) {
					
			
			 var m_selected_row = jQuery('#TABLE_CLIENT_RECEIPTS').jqGrid('getRowData', rowid);
			 var m_broker_code  = m_selected_row.Broker;
			 var m_facility_no  = m_selected_row.Facility_No;
              
			 var m_due_date	    = document.Form1.TXT_TODATE.value+"-"+document.Form1.TXT_TOMONTH.value+"-"+document.Form1.TXT_TOYEAR.value;
		
				
			if (iCol == 4) {
				
			var  m_url=jsp_client_url+"dn_sale_drildown_2.jsp?chksql=sale_details_settle_date_2&facility_no="+m_facility_no+"&start_date="+m_due_date+"&end_date="+m_due_date+"";
			     if ($('#DIV_DRILL_DOWN').dialog('isOpen')) {
						$('#DIV_DRILL_DOWN').dialog('close');
					}
					$('#IFRAME_DRILL_DOWN').attr('src', '');
					$('#IFRAME_DRILL_DOWN').remove();
					$('#DIV_DRILL_DOWN').html(iframe_html_string);
					$('#DIV_DRILL_DOWN').dialog('option', 'title', 'Drill Down');
					$('#IFRAME_DRILL_DOWN').attr('src', m_url);
					$('#DIV_DRILL_DOWN').dialog('open');	
				
			}	
				
				
				/* if (iCol == 4) {
                
				var m_to_date = document.Form1.TXT_TODATE.value;
				var m_to_month = document.Form1.TXT_TOMONTH.value;
				var m_to_year = document.Form1.TXT_TOYEAR.value;
				var  m_url=jsp_client_url+"dn_broker_payment_drill_down.jsp?broker_code="+m_broker_code+"&to_date="+m_to_date+"&to_month="+m_to_month+"&to_year="+m_to_year;
				
					
				  window.open(m_url,'broker_payment_drill_down', 'left = 0, top = 0, toolbar = 0, location = 0, directories = 0, status = 0, menuBar = 0, scrollBars = 1, resizable = 1, width = ' + screen.availWidth + ', height = ' + screen.availWidth);
					
                   }
				*/
			/*
			if (iCol == 5) {
                
				var m_to_date = document.Form1.TXT_TODATE.value;
				var m_to_month = document.Form1.TXT_TOMONTH.value;
				var m_to_year = document.Form1.TXT_TOYEAR.value;
				var  m_url=jsp_client_url+"dn_broker_receipts_pending.jsp?broker_code="+m_broker_code+"&to_date="+m_to_date+"&to_month="+m_to_month+"&to_year="+m_to_year+"&facility_no="+m_facility_no;
				
					
				  window.open(m_url,'broker_receipt_drill_down', 'left = 0, top = 0, toolbar = 0, location = 0, directories = 0, status = 0, menuBar = 0, scrollBars = 1, resizable = 1, width = ' + screen.availWidth + ', height = ' + screen.availWidth);
					
			}*/
			
				
									
		}
		  function cellFomatterPayBeneficiary (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='m_broker_code_"+row_id+"' name='m_broker_code_"+row_id+"' value='"+cellvalue+"'  /></span>";
                     return texts;
                     } 
			
			 function cellFomatterReceiptNo (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='PAYMENTNO"+row_id+"' name='PAYMENTNO"+row_id+"' value='"+cellvalue+"'  /></span>";
                     return texts;
                     } 
		function cellFomatterFacilityNo (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='hid_facility_no_"+row_id+"' name='hid_facility_no_"+row_id+"' value='"+unformat_noobject(cellvalue)+"'  /></span>";
                     return texts;
                     }		
		function cellFomatterGroupRec (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = cellvalue;//edit by waruna
			       // var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='hid_group_amount_"+row_id+"' name='hid_group_amount_"+row_id+"' value='"+unformat_noobject(cellvalue)+"'  /></span>";
                     return texts;
                     }
		
			
		function cellFomatterNumberAvailability(cellvalue, options, rowObject) {
          
			   cellvalue = format_noobject00(cellvalue, 2, null, 'BRACKETS');
               cellvalue = '<div style = "cursor: default;">' + cellvalue + '</div>';
               return cellvalue;
					
			
           }
			
		function cellFomatterNumber(cellvalue, options, rowObject) {
            var row_id=options['rowId'];  
			if(row_id!=''){
			   cellvalue = format_noobject00(cellvalue, 2, null, 'BRACKETS');
               cellvalue = '<div style = "cursor: default;">' + cellvalue + '</div>';
               return cellvalue;
				}else{
				return '&nbsp;';
				}		
           }
			
		function cellFomatterNumberPointer(cellvalue, options, rowObject) {
               cellvalue = format_noobject00(cellvalue, 2, null, 'BRACKETS');
               cellvalue = '<div style = "cursor: pointer;">' + cellvalue + '</div>';
               return cellvalue;
           }	
		function cellFomatterNetRec (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='hid_net_amount_"+row_id+"' name='hid_net_amount_"+row_id+"' value='"+unformat_noobject(cellvalue)+"'  /></span>";
                     return texts;
                     }	
				
		function cellFomatterBroker (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='broker"+row_id+"' name='broker"+row_id+"' value='"+cellvalue+"'  /></span>";
                     return texts;
                     }
		  function cellFomatterPaySettDate(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='m_trndate_"+row_id+"' name='m_trndate_"+row_id+"' value='"+cellvalue+"'  /></span>";
                     return texts;
                     } 	
		function cellFomatterPayClient(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='m_client_code_"+row_id+"' name='m_client_code_"+row_id+"' value='"+cellvalue+"'  /></span>";
                     return texts;
                     } 	
		 function cellFomatterSetlAmount (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span><input type='text' align='right' style ='text-align: right;'  id='m_sett_amount_"+row_id+"' name='m_sett_amount_"+row_id+"' value='"+cellvalue+"' onchange=check_amount('"+row_id+"')  onblur=guaran('"+row_id+"');check_amount('"+row_id+"')  /><input type='hidden' name='m_amount_"+row_id+"' value='"+cellvalue+"'/></span>";
                     return texts;
                     }
	      function checkBoxFmatterRecSave (cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='checkbox' id='save_status_"+rowid+"'  name='save_status_"+rowid+"' value='on'  onclick =chk_net_payment('"+rowid+"');   />";  <!--onclick =guaran('"+rowid+"');check_amount('"+rowid+"');  onchange=guaran('"+rowid+"');check_amount('"+rowid+"') -->
              return link;
		  }
			
			function cellFomatterReceiptView (cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='button' id='view_"+rowid+"'  name='view_"+rowid+"' value='View'  onclick =pay_view('"+rowid+"');     />"; 
              return link;
		  }
		
		 function pay_view(row_id){
			
		 }
		
		function chk_net_payment(row_id){
			
			var m_selected_row      = jQuery('#TABLE_CLIENT_RECEIPTS').jqGrid('getRowData', row_id);
            var m_Net_Amount        =  m_selected_row.Net_Amount;
            var m_sett_amount_id    = 'hid_sett_type_'+row_id;
			var m_group_net_mode_id = 'hid_group_net_mode_'+row_id;
		    var mm_save_status      = 'save_status_'+row_id;
			
			
			if(document.getElementById(m_sett_amount_id).value=='N/A'){
			alert('Please select Receipt Mode.');
			document.getElementById(mm_save_status).checked=false;	
			}else if(document.getElementById(m_group_net_mode_id).value=='N/A') {
			alert('Please select  Settlement Mode.');
			document.getElementById(mm_save_status).checked=false;		
			}else if(m_Net_Amount<0 && document.getElementById(m_group_net_mode_id).value=='NET' ){
			    alert('Net Receipt can not be negative..!');
				document.getElementById(mm_save_status).checked=false;	
			}else if(document.getElementById('hid_group_amount_'+row_id).value<0) {
			alert('Receipt can not be negative..!');
			document.getElementById(mm_save_status).checked=false;		
			}
			
			
			
			
		 }	
			
			function checkBoxFmatterPaySignature(cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='checkbox' id='signature_"+rowid+"'  name='signature_"+rowid+"' value='on'  onclick =validateSig('"+rowid+"');     />"; 
              return link;
		  }
			function checkBoxFmatterPayReject (cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='checkbox' id='reject_"+rowid+"'  name='reject_"+rowid+"' value='on'  onclick =validateRej('"+rowid+"');    />"; 
              return link;
		  }
		 function cellFomatterRecComment(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span><input type='text' align='left' style ='text-align: left;'  id='comment_"+row_id+"' name='comment_"+row_id+"' value=''/></span>";
                     return texts;
          }
			
		 function cellFomatterRecEntMode(cellvalue, options, rowObject){
                      var row_id = options['rowId'];
                      var texts  ="";     
				if(row_id!=''){
				     if(cellvalue=='GROUP'){         
				     texts  = "<span><select name='hid_group_net_mode_"+row_id+"' id='hid_group_net_mode_"+row_id+"' ><OPTION VALUE='GROUP' SELECTED>Gross Receipts</OPTION><OPTION VALUE='NET'>Net Settlements</OPTION></select></span>";
					 }else if(cellvalue=='NET'){
					 texts  = "<span><select name='hid_group_net_mode_"+row_id+"'  id='hid_group_net_mode_"+row_id+"'><OPTION VALUE='GROUP' >Gross Receipts</OPTION><OPTION VALUE='NET SELECTED'>Net Settlements</OPTION></select></span>";	
					 }else{
					 texts  = "<span><select name='hid_group_net_mode_"+row_id+"'  id='hid_group_net_mode_"+row_id+"'><OPTION VALUE='N/A' SELECTED>N/A</OPTION><OPTION VALUE='GROUP' >Gross Receipts</OPTION><OPTION VALUE='NET'>Net Settlements</OPTION></select></span>";	
						}
				}else{
				texts = '&nbsp;';
				}
				return texts;
          }		
		 function cellFomatterRecMode(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
				     var texts = "";
				   if(row_id!=''){
				    if(cellvalue=='CHEQUE'){
                     texts = "<span><select name='hid_sett_type_"+row_id+"' id='hid_sett_type_"+row_id+"'  ><OPTION VALUE='CHEQUE' SELECTED>CHEQUE</OPTION><OPTION VALUE='PAY_ORDER'>PAY ORDER</OPTION><OPTION VALUE='BANK_TRANF'>BANK TRANF</OPTION></select></span>";
					}else if(cellvalue=='PAY_ORDER'){
					  texts = "<span><select name='hid_sett_type_"+row_id+"' id='hid_sett_type_"+row_id+"' ><OPTION VALUE='CHEQUE' >CHEQUE</OPTION><OPTION VALUE='PAY_ORDER' SELECTED >PAY ORDER</OPTION><OPTION VALUE='BANK_TRANF'>BANK TRANF</OPTION></select></span>";
					}else if(cellvalue=='BANK_TRANF'){
					  texts = "<span><select name='hid_sett_type_"+row_id+"' id='hid_sett_type_"+row_id+"' ><OPTION VALUE='CHEQUE'>CHEQUE</OPTION><OPTION VALUE='PAY_ORDER'>PAY ORDER</OPTION><OPTION VALUE='BANK_TRANF' SELECTED >BANK TRANF</OPTION></select></span>";
					}else{
					  texts = "<span><select name='hid_sett_type_"+row_id+"' id='hid_sett_type_"+row_id+"'  ><OPTION VALUE='N/A' >N/A</OPTION><OPTION VALUE='CHEQUE' >CHEQUE</OPTION><OPTION VALUE='PAY_ORDER'>PAY ORDER</OPTION><OPTION VALUE='BANK_TRANF'>BANK TRANF</OPTION></select></span>";
					}
				}else{
				texts = '&nbsp;';
				}
				      return texts;
          }	
		
		function cellFomatterSettleOfDue (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span><input type='text' align='right' style ='text-align: right;'  id='hid_group_amount_"+row_id+"' name='hid_group_amount_"+row_id+"' value='"+unformat_noobject(cellvalue)+"'  /></span>";
                     return texts;
                     }	
			
		function cellFomatterRecCompanyAccNo(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
			
			<% 
			
			ResultSet rs = stmt.executeQuery ("SELECT BRANCH_CODE||'/'||ACC_NO,BRANCH_CODE||'@'||ACC_NO "+
					"FROM   "+m_schema_name+".DN_REF_LICENCEE_SETTLEMENT "+
					"WHERE  ACTIVE_STATUS='Y' ");
				
				boolean more1 = rs.next();
			    String m_banks="";
				while (more1) {
					m_banks = m_banks+"<option value='"+rs.getString(2)+"'>"+rs.getString(1)+"";
					more1 = rs.next();
				}
			%>
                     var texts = "<span><select name='account_no_"+row_id+"'  ><%=m_banks%></select></span>";
				     return texts;
          }	
			
		 function cellFomatterChequeNumber (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                    if(row_id!=''){
			         var texts = "<span><input type='text' align='right' style ='text-align: right;'  id='m_cheque_number_"+row_id+"' name='m_cheque_number_"+row_id+"' size='6' value=''  /></span>";
                     return texts;
					}else{
					return '&nbsp;';
					}	
						
            }
			
		function cellFomatterBankingDate (cellvalue, options, rowObject){
               var row_id         = options['rowId'];
		       var m_subgrid_type = options['gid'];	 
		
                    if(row_id!=''){
			       
						
					cellvalue = '&nbsp;' +
						'<input class = "txt_input5" type = "text" name = "TXT_BANKING_DATE_DD_' + m_subgrid_type + '_' + row_id + '" id = "TXT_BANKING_DATE_DD_' + m_subgrid_type + '_' + row_id + '" maxlength = "2" size = "2" value = "' + m_sysdate_dd + '" onblur = "checkMonthLength1(document.Form1.elements[\'TXT_BANKING_DATE_DD_' + m_subgrid_type + '_' + row_id + '\'], document.Form1.elements[\'TXT_BANKING_DATE_MM_' + m_subgrid_type + '_' + row_id + '\'], document.Form1.elements[\'TXT_BANKING_DATE_YY_' + m_subgrid_type + '_' + row_id + '\'], document.Form1.elements[\'TXT_BANKING_DATE_' + m_subgrid_type + '_' + row_id + '\'], \'D\', \'N\', m_sysdate, \'no past\');" disabled = "disabled" /> ' + 
						'<input class = "txt_input5" type = "text" name = "TXT_BANKING_DATE_MM_' + m_subgrid_type + '_' + row_id + '" id = "TXT_BANKING_DATE_MM_' + m_subgrid_type + '_' + row_id + '"maxlength = "2" size = "2" value = "' + m_sysdate_mm + '" onblur = "checkMonthLength1(document.Form1.elements[\'TXT_BANKING_DATE_DD_' + m_subgrid_type + '_' + row_id + '\'], document.Form1.elements[\'TXT_BANKING_DATE_MM_' + m_subgrid_type + '_' + row_id + '\'], document.Form1.elements[\'TXT_BANKING_DATE_YY_' + m_subgrid_type + '_' + row_id + '\'], document.Form1.elements[\'TXT_BANKING_DATE_' + m_subgrid_type + '_' + row_id + '\'], \'M\', \'N\', m_sysdate, \'no past\');" disabled = "disabled" /> ' + 
						'<input class = "txt_input5" type = "text" name = "TXT_BANKING_DATE_YY_' + m_subgrid_type + '_' + row_id + '" id = "TXT_BANKING_DATE_YY_' + m_subgrid_type + '_' + row_id + '"maxlength = "4" size = "4" value = "' + m_sysdate_yy + '" onblur = "checkMonthLength1(document.Form1.elements[\'TXT_BANKING_DATE_DD_' + m_subgrid_type + '_' + row_id + '\'], document.Form1.elements[\'TXT_BANKING_DATE_MM_' + m_subgrid_type + '_' + row_id + '\'], document.Form1.elements[\'TXT_BANKING_DATE_YY_' + m_subgrid_type + '_' + row_id + '\'], document.Form1.elements[\'TXT_BANKING_DATE_' + m_subgrid_type + '_' + row_id + '\'], \'Y\', \'N\', m_sysdate, \'no past\');" disabled = "disabled" /> ' + 
						'<input type = "hidden" name = "TXT_BANKING_DATE_' + m_subgrid_type + '_' + row_id + '" id = "TXT_BANKING_DATE_' + m_subgrid_type + '_' + row_id + '" value = "' + m_sysdate + '" /> ';
			     	
				//initCal('TXT_BANKING_DATE_' + m_subgrid_type + '_' + row_id);
				return cellvalue;
						
						
						
						
					}else{
					return '&nbsp;';
					}	
						
        }
			
	function cellFomatterRealizattionDate (cellvalue, options, rowObject){
                   
			   var row_id         = options['rowId'];
		       var m_subgrid_type = options['gid'];	 
		
                    if(row_id!=''){
			       
						
					cellvalue = '&nbsp;' +
						'<input class = "txt_input5" type = "text" name = "TXT_REALIZA_DATE_DD_' + m_subgrid_type + '_' + row_id + '" id = "TXT_REALIZA_DATE_DD_' + m_subgrid_type + '_' + row_id + '" maxlength = "2" size = "2" value = "' + m_sysdate_dd + '" onblur = "checkMonthLength1(document.Form1.elements[\'TXT_REALIZA_DATE_DD_' + m_subgrid_type + '_' + row_id + '\'], document.Form1.elements[\'TXT_REALIZA_DATE_MM_' + m_subgrid_type + '_' + row_id + '\'], document.Form1.elements[\'TXT_REALIZA_DATE_YY_' + m_subgrid_type + '_' + row_id + '\'], document.Form1.elements[\'TXT_REALIZA_DATE_' + m_subgrid_type + '_' + row_id + '\'], \'D\', \'N\', m_sysdate, \'no past\');" disabled = "disabled" /> ' + 
						'<input class = "txt_input5" type = "text" name = "TXT_REALIZA_DATE_MM_' + m_subgrid_type + '_' + row_id + '" id = "TXT_REALIZA_DATE_MM_' + m_subgrid_type + '_' + row_id + '"maxlength = "2" size = "2" value = "' + m_sysdate_mm + '" onblur = "checkMonthLength1(document.Form1.elements[\'TXT_REALIZA_DATE_DD_' + m_subgrid_type + '_' + row_id + '\'], document.Form1.elements[\'TXT_REALIZA_DATE_MM_' + m_subgrid_type + '_' + row_id + '\'], document.Form1.elements[\'TXT_REALIZA_DATE_YY_' + m_subgrid_type + '_' + row_id + '\'], document.Form1.elements[\'TXT_REALIZA_DATE_' + m_subgrid_type + '_' + row_id + '\'], \'M\', \'N\', m_sysdate, \'no past\');"  disabled = "disabled" /> ' + 
						'<input class = "txt_input5" type = "text" name = "TXT_REALIZA_DATE_YY_' + m_subgrid_type + '_' + row_id + '" id = "TXT_REALIZA_DATE_YY_' + m_subgrid_type + '_' + row_id + '"maxlength = "4" size = "4" value = "' + m_sysdate_yy + '" onblur = "checkMonthLength1(document.Form1.elements[\'TXT_REALIZA_DATE_DD_' + m_subgrid_type + '_' + row_id + '\'], document.Form1.elements[\'TXT_REALIZA_DATE_MM_' + m_subgrid_type + '_' + row_id + '\'], document.Form1.elements[\'TXT_REALIZA_DATE_YY_' + m_subgrid_type + '_' + row_id + '\'], document.Form1.elements[\'TXT_REALIZA_DATE_' + m_subgrid_type + '_' + row_id + '\'], \'Y\', \'N\', m_sysdate, \'no past\');"  disabled = "disabled" /> ' + 
						'<input type = "hidden" name = "TXT_REALIZA_DATE_' + m_subgrid_type + '_' + row_id + '" id = "TXT_REALIZA_DATE_' + m_subgrid_type + '_' + row_id + '" value = "' + m_sysdate + '" /> ';
			     	
				//initCal('TXT_REALIZA_DATE_' + m_subgrid_type + '_' + row_id);
				return cellvalue;
						
						
						
						
					}else{
					return '&nbsp;';
					}
		
        }	
			
		function cellFomatterBranchCode(cellvalue, options, rowObject){
        var row_id=options['rowId'];
			
				 
                     var texts = "<span><select name='bank_branch_code_"+row_id+"' ><%=m_branch%></select></span>";
				     return texts;
          }	
			
		  function unformatData(cellvalue, options, cellobject) {
               return cellvalue;
           }
			
         function validateRej(val){
			var str_signature_object_name='signature_'+val;
			document.forms[0].elements[str_signature_object_name].checked = false;
			}
	    function validateSig(val){
			var str_signature_object_name='reject_'+val;
			document.forms[0].elements[str_signature_object_name].checked = false;
			}	
			
			
		function fnCancel(){
			document.getElementById("DIV_CLIENT_RECEIPTS").innerHTML ="<table id = 'TABLE_CLIENT_RECEIPTS'></table><div id = 'DIV_PAGER_TABLE_CLIENT_PAYMENT_SIGNATURE'></div>";
          document.getElementById("txt_client_code").value="";
		  document.getElementById("TXT_CLIENT_MANAGER").value="";
		  document.getElementById("txt_facility_number").value="";
		  document.getElementById("txt_broker_code").value="";
		
		  document.getElementById("txt_facility_number_name").value="";
		  document.getElementById("TXT_CLIENT_MANAGER_NAME").value="";
		  document.getElementById("txt_facility_number").value="";
		  document.getElementById("txt_broker_full_name").value=""; 
		  loadGridReceiptsAppove();
			}
			
		function chk_confirmed_deal() {
			
			
			//var no_of_rows=$("#TABLE_CLIENT_RECEIPTS").jqGrid('getGridParam',"records");
			 var no_of_rows=$("#TABLE_CLIENT_RECEIPTS").jqGrid('getGridParam',"records");
			document.Form1.hid_count.value = no_of_rows;
			
			flag = false;
			
			for(var r=1;r<document.Form1.hid_count.value;r++){
				
			
				if(eval("document.Form1.save_status_"+r+".checked")) {
				
					flag = true ;					 
					
				}
				
				
			}	
			
			return flag;
		}
			
		function fnSave(){
			
			for (var i=0; i < document.Form1.elements.length; i++ ) {
					document.Form1.elements[i].disabled=false;
				}
			
			if(chk_confirmed_deal()){
			            document.Form1.Hid_scr_name.value="receipts_level_2";
						document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_receipts_level2";
						document.Form1.submit();
			
			    }else{
				alert('No records to save');
			   }
			}
			
			function facility_number_help(m_strat)
			{
     var aForm;    //  aForm =oForm.elements;
     aForm =  document.getElementById('Form1');
	 /*  var myObject = new Object();
   	 myObject.firstName = aForm.oFirstName.value;
   	 myObject.lastName = aForm.oLastName.value;
		*/
	
 	var myObject=new Array(); //return values set to this object
 	myObject[0]=aForm.txt_facility_number;
	myObject[1]=null;
 	myObject[2]=null;
 	myObject[3]=null;
 	myObject[4]=null;
  
 	var myObject_value=new Array(); //passing values set to this object
 	myObject_value[0]=aForm.txt_facility_number.value;
 	myObject_value[1]=aForm.txt_facility_number.value;//aForm.oLastName2.value;
 	myObject_value[2]=null;
 	myObject_value[3]=null;
 	myObject_value[4]=null;
 
 
 	var myObject_type=new Array(); //passing values data type
 	myObject_type[0]="StringL";
 	myObject_type[1]="StringL";
 	myObject_type[2]=null;
 	myObject_type[3]=null;
 	myObject_type[4]=null;
 
 	var qid='1';
    title_name='Help';
 	var url = 'popup.jsp';
	var close_fun='close_portP_help';			
 	var json_text = JSON.stringify(myObject_value, null,0);
 	var json_obj_type_text=JSON.stringify(myObject_type, null,0);
 	var fn_name=arguments.callee.name;
		if(fn_name==undefined){
		re = /^function\s+([^(]+)/;
        fn_name=re.exec(arguments.callee.toString())[1];
		}		
	//JSON.parse(str) 
	//alert(json_text);
       	$.showModalDialog({
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400,// 500,
		 width: 600,//900,
		 title: 'SasiNet Frame Work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
	}
			
			
	function broker_code_help(m_strat)
			{
     var aForm;    //  aForm =oForm.elements;
     aForm =  document.getElementById('Form1');
	 /*  var myObject = new Object();
   	 myObject.firstName = aForm.oFirstName.value;
   	 myObject.lastName = aForm.oLastName.value;
		*/
	
 	var myObject=new Array(); //return values set to this object
 	myObject[0]=aForm.txt_broker_code;
	myObject[1]=aForm.txt_broker_full_name;
 	myObject[2]=null;
 	myObject[3]=null;
 	myObject[4]=null;
  
 	var myObject_value=new Array(); //passing values set to this object
 	myObject_value[0]=aForm.txt_broker_code.value;
 	myObject_value[1]=null;//aForm.oLastName2.value;
 	myObject_value[2]=null;
 	myObject_value[3]=null;
 	myObject_value[4]=null;
 
 
 	var myObject_type=new Array(); //passing values data type
 	myObject_type[0]="StringL";
 	myObject_type[1]=null;
 	myObject_type[2]=null;
 	myObject_type[3]=null;
 	myObject_type[4]=null;
 
 	var qid='80';
    title_name='Help';
 	var url = 'popup.jsp';
	var close_fun='close_portP_help';			
 	var json_text = JSON.stringify(myObject_value, null,0);
 	var json_obj_type_text=JSON.stringify(myObject_type, null,0);
 	var fn_name=arguments.callee.name;
		if(fn_name==undefined){
		re = /^function\s+([^(]+)/;
        fn_name=re.exec(arguments.callee.toString())[1];
		}		
	//JSON.parse(str) 
	//alert(json_text);
       	$.showModalDialog({
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400,// 500,
		 width: 600,//900,
		 title: 'SasiNet Frame Work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
	}
				
		
	function client_code_help(m_strat)
			{
     var aForm;    //  aForm =oForm.elements;
     aForm =  document.getElementById('Form1');
	 /*  var myObject = new Object();
   	 myObject.firstName = aForm.oFirstName.value;
   	 myObject.lastName = aForm.oLastName.value;
		*/
	
 	var myObject=new Array(); //return values set to this object
 	myObject[0]=aForm.txt_client_code;
	myObject[1]=aForm.txt_client_full_name;
 	myObject[2]=null;
 	myObject[3]=null;
 	myObject[4]=null;
  
 	var myObject_value=new Array(); //passing values set to this object
 	myObject_value[0]=aForm.txt_client_code.value;
 	myObject_value[1]=aForm.txt_client_code.value;//aForm.oLastName2.value;
 	myObject_value[2]=null;
 	myObject_value[3]=null;
 	myObject_value[4]=null;
 
 
 	var myObject_type=new Array(); //passing values data type
 	myObject_type[0]="StringL";
 	myObject_type[1]="StringL";
 	myObject_type[2]=null;
 	myObject_type[3]=null;
 	myObject_type[4]=null;
 
 	var qid='79';
    title_name='Help';
 	var url = 'popup.jsp';
	var close_fun='close_portP_help';			
 	var json_text = JSON.stringify(myObject_value, null,0);
 	var json_obj_type_text=JSON.stringify(myObject_type, null,0);
 	var fn_name=arguments.callee.name;
		if(fn_name==undefined){
		re = /^function\s+([^(]+)/;
        fn_name=re.exec(arguments.callee.toString())[1];
		}		
	//JSON.parse(str) 
	//alert(json_text);
       	$.showModalDialog({
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400,// 500,
		 width: 600,//900,
		 title: 'SasiNet Frame Work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
	}		
		
	function client_manager_code_help(m_strat)
			{
     var aForm;    //  aForm =oForm.elements;
     aForm =  document.getElementById('Form1');
	 /*  var myObject = new Object();
   	 myObject.firstName = aForm.oFirstName.value;
   	 myObject.lastName = aForm.oLastName.value;
		*/
	
 	var myObject=new Array(); //return values set to this object
 	myObject[0]=aForm.TXT_CLIENT_MANAGER;
	myObject[1]=aForm.TXT_CLIENT_MANAGER_NAME;
 	myObject[2]=null;
 	myObject[3]=null;
 	myObject[4]=null;
  
 	var myObject_value=new Array(); //passing values set to this object
 	myObject_value[0]=aForm.TXT_CLIENT_MANAGER.value;
 	myObject_value[1]=null;//aForm.oLastName2.value;
 	myObject_value[2]=null;
 	myObject_value[3]=null;
 	myObject_value[4]=null;
 
 
 	var myObject_type=new Array(); //passing values data type
 	myObject_type[0]="StringL";
 	myObject_type[1]=null;
 	myObject_type[2]=null;
 	myObject_type[3]=null;
 	myObject_type[4]=null;
 
 	var qid='78';
    title_name='Help';
 	var url = 'popup.jsp';
	var close_fun='close_portP_help';			
 	var json_text = JSON.stringify(myObject_value, null,0);
 	var json_obj_type_text=JSON.stringify(myObject_type, null,0);
 	var fn_name=arguments.callee.name;
		if(fn_name==undefined){
		re = /^function\s+([^(]+)/;
        fn_name=re.exec(arguments.callee.toString())[1];
		}		
	//JSON.parse(str) 
	//alert(json_text);
       	$.showModalDialog({
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400,// 500,
		 width: 600,//900,
		 title: 'SasiNet Frame Work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
	}	
			
			
			function display_dat(){
		//	alert( data_vec.length);	
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=get_mgt_date";
			//window.open(m_url);
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
			
			if(m_size>0){	
				/*document.Form1.TXT_DATE.value= top.frames[0].document.applets[0].outvec_value.elementAt(0).substring(0,2);
				document.Form1.TXT_MONTH.value= top.frames[0].document.applets[0].outvec_value.elementAt(0).substring(3,5);
				document.Form1.TXT_YEAR.value= top.frames[0].document.applets[0].outvec_value.elementAt(0).substring(6,10);
				*/
				document.Form1.TXT_TODATE.value  = data_vec[0].substring(0,2);
				document.Form1.TXT_TOMONTH.value = data_vec[0].substring(3,5);
				document.Form1.TXT_TOYEAR.value  = data_vec[0].substring(6,10);
			}
			else{
			}
		
			
		
		}
			
			
 function checksettlementdate(dayobj,monthobj,yearobj) {
      		
		    buy_sett_date=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buy_sett_date="+buy_sett_date+"&chksql=chk_buy_sett_date_22";//CHAGE BY WARUNA 2011-02-14
		    load_interface(m_url,'XML',false);
		  
			m_size= data_vec.length;

   //alert(m_size+'***'+data_vec[0]);
				
   	if(data_vec[0]=='YES'){
   
			    alert(" Date is not greater than Last Day End Routine Date, Please Re-Enter  Date !.");
		 		dayobj.value=" ";	monthobj.value=" ";yearobj.value=" ";dayobj.focus();
     		}
    }
	
	function chkstartdate(dayobj,monthobj,yearobj) { //thamali
		    checkMonthLength(dayobj,monthobj,yearobj);		
		}
		
		</script>
 	
 </head>
    
    <body class="body & txt-body" ><!-- onload="display_dat();"-->
        <form name="Form1" id="Form1" >
			 <input type = "hidden" id = "Hid_scr_name" name = "Hid_scr_name" Value="payment_first_sig" />
			 <input type = "hidden" id = "hid_count" name = "hid_count" />
		     <div>
                <table class="table" align="center" border="0" cellpadding="0" cellspacing="0" width="99%">
                    <tr>
                        <td height="7"></td>
                    </tr>
                    
                    <tr height="30">
                        <td width="13px" style="background-image: url('<%= m_jsp_client_url %>/images/l1.gif'); background-repeat: no repeat;" id="hi1"></td>
                        <td style="background-image: url('<%= m_jsp_client_url %>/images/l3.gif'); background-repeat: repeat;" id="hi2" align="left"><b>Margin Trading - Resale Agreement</b></td>
                        <td width="13px" style="background-image: url('<%= m_jsp_client_url %>/images/l2.gif'); background-repeat: no repeat;"  id="hi3"></td>
                    </tr>
                </table>
					
					
            </div>	
				
			<div>		
				
				<table class="table" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td height="1"></td>
                </tr>
            </table>
					
			</div>	
				
            <div>
            <table width="100%" bgcolor="darkblue">
                <tr>
                    <td width="6%">
                       <!-- <input class="mainbut" type="button" name="Add" value="Add" onclick="display_rec_opt(ADD);" />-->
                    </td>
                    <td width="6%">
                       <!--  <input class="mainbut" type="button" name="MOD" value="Modify" onclick="display_rec_opt(MOD);" />-->
                    </td>
                    <td width="6%">
                        <!-- <input class="mainbut" type="button" name="DEL" value="Delete" onclick="display_rec_opt(DEL);" />-->
                    </td>
                    <td width="6%"></td>
                    
                    <td width="6%">
                        <input class="mainbut" type="button" name="save_but" value="Save" onclick="fnSave();" />
                    </td>
                    <td width="6%">
                        <input class="mainbut" type="button" name="calcel_but" value="Cancel" onclick="fnCancel();" />
                    </td>
                    <td width="6%">
                        <input class="mainbut" type="button" name="Exit_but" value="Exit" onclick="window.close();" />
                    </td>
                    <td width="6%">
                       <!-- <input class="mainbut" type="button" name="report_but" value="Enquiry" onclick="obtain_report_before();" />-->
                    </td>
                    <td width="50%" class="hh1" align="right"><b>Broker Receipts</b></td>
                </tr>
            </table>
			</div>
			<DIV>	
            <table width="100%">
                <tr height="25px;"></tr>
            </table>
            <hr />
				
            <table width="100%">
                <tr height="25px;"></tr>
            </table>
             <br /> 
		    </DIV>	
			
				
				
			<BR>	
				
	  <div id = "DIV_CLIENT_RECEIPTS">
                     <table id = "TABLE_CLIENT_RECEIPTS"></table>
                      <div id = "DIV_PAGER_TABLE_CLIENT_RECEIPTS"></div>

       </div>
		<BR>	
	    <div id = "DIV_CLIENT_LOAN_SUMMARY">
                     <table id = "TABLE_CLIENT_LOAN_SUMMARY"></table>
        <div id = "DIV_PAGER_TABLE_CLIENT_LOAN_SUMMARY"></div>
        </div>				
		<BR>
       <div id = "DIV_CLIENT_LOAN_SCHEDULE">
                     <table id = "TABLE_CLIENT_LOAN_SCHEDULE"></table>
        <div id = "DIV_PAGER_TABLE_CLIENT_LOAN_SCHEDULE"></div>
        </div>		
				<BR>
       <div id = "DIV_CLIENT_SETTL_RECEIPT">
                     <table id = "TABLE_CLIENT_SETTL_RECEIPT"></table>
        <div id = "DIV_PAGER_TABLE_CLIENT_SETTL_RECEIPT"></div>
        </div>		
			
	  <div id = "DIV_DRILL_DOWN" title = "">
							<iframe id = "IFRAME_DRILL_DOWN" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Invoice Drill Down">
							</iframe>
		</div>				
		<div id = "DIV_DRILL_DOWN_2" title = "">
							<iframe id = "IFRAME_DRILL_DOWN_2" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Invoice Drill Down">
							</iframe>
		</div>						
						
        </form>		
			
 </body>		
</html>
	