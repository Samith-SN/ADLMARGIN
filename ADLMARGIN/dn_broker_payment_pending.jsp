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
		var iframe_html_string = '<iframe id = "IFRAME_DRILL_DOWN" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Drill Down"></iframe>';
		var iframe_html_string_2 = '<iframe id = "IFRAME_DRILL_DOWN_2" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Drill Down"></iframe>';		
		
			
			$(document).ready(function() {
					// init_fancybox();
					//initDrillDownDialog()
					//call_frame();	
					m_grid_height = ($(window).height() - 200);
					m_grid_width = ($(window).width() - 0);
					initCal('VAL_TXT_DATE');		
					//bind_events();
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
               var m_last_index_of_underscore = instance_id.lastIndexOf('_');
               var first_part = instance_id.substr(0, m_last_index_of_underscore + 1);
               var second_part = instance_id.substr(m_last_index_of_underscore + 1);
               if (instance_id == "VAL_TXT_DATE") {
                   document.Form1.TXT_TODATE.value = splitResult[0];
                   document.Form1.TXT_TOMONTH.value = splitResult[1];
                   document.Form1.TXT_TOYEAR.value = splitResult[2];
                   document.Form1.TXT_TOYEAR.focus();
               }
          
              
           }
		//$(document).ready(function() {
		
			//loadGridPaymentsAppove();
			
			// });
		
		function fn_veiwall(){
			fnCancel();
			loadGridPaymentsAppove();
		}	
			
		function loadGridPaymentsAppove() {
            
		   var m_client_code    = document.getElementById("txt_client_code").value;
		   var m_client_manager = document.getElementById("TXT_CLIENT_MANAGER").value;
		   var m_port           = document.getElementById("txt_facility_number").value;
		   var m_broker_code    = document.getElementById("txt_broker_code").value;		
		   var m_from_date      = document.getElementById("TXT_TODATE").value+"-"+document.getElementById("TXT_TOMONTH").value+"-"+document.getElementById("TXT_TOYEAR").value;			
               m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"BrokerPaymentsLeve1?chksql=payment_level3&port="+m_port+"&client_code="+m_client_code+"&client_manager="+m_client_manager+"&broker_code="+m_broker_code+"&from_date="+m_from_date;
					
					
					jQuery('#TABLE_CLIENT_PAYMENT_SIGNATURE').GridUnload();
					jQuery('#TABLE_CLIENT_PAYMENT_SIGNATURE').jqGrid({
                    url: m_url,
                   //loadonce: 1,
                   datatype: 'json',
                   colNames: ['Broker','Facility Number','Client Name','Due Date','Due Amount','Settled Amount' ,' Balance Payable' ,'Availability','Total Receivable',' Settlement Amount','Mode', 'Company Bank Account', 'Comments',' Settlement Mode', 'Spot Margin (%)','Spot Margin (Market)','Save'],
                   colModel: [
						//{name: 'View',                  index: 'View',   		jsonmap: 'View',                        sortable: false, align: 'center', width: 90,  resizable: false,     unformat: unformatData, formatter:cellFomatterPaymentView},//formatter: cellFomatterPaymentsColumn_1,
						{name: 'Broker',                 index: 'Broker',   		    jsonmap: 'Broker',              sortable: false, align: 'center', width: 90,  resizable: false,     unformat: unformatData, formatter:cellFomatterBroker     },//formatter: cellFomatterPaymentsColumn_1,
						//{name: 'Broker_Name',            index: 'Broker_Name',   	    jsonmap: 'Broker_Name', 	    sortable: false, align: 'Left',   width: 100, resizable: true,      unformat: unformatData                                   },//formatter: cellFomatterPaymentsColumn_1,
						{name: 'Facility_No',            index: 'Facility_No',   	    jsonmap: 'Facility_No', 	    sortable: false, align: 'Left',   width: 100, resizable: true,      unformat: unformatData, formatter:cellFomatterFacilityNo                                    },//formatter: cellFomatterPaymentsColumn_1,
						{name: 'Client_Name',            index: 'Client_Name',   	    jsonmap: 'Client_Name', 	    sortable: false, align: 'Left',   width: 100, resizable: true,      unformat: unformatData                                   },//formatter: cellFomatterPaymentsColumn_1,
						{name: 'Due_Date',               index: 'Due_Date',  	        jsonmap: 'Due_Date', 	        sortable: false, align: 'cenete' , width: 100, resizable: false,    unformat: unformatData, formatter:cellFomatterDueDate     },
						{name: 'Due_Amount',             index: 'Due_Amount',  	        jsonmap: 'Due_Amount', 	        sortable: false, align: 'right' , width: 100, resizable: false,     unformat: unformatData                                  },//formatter:cellFomatterGroupPay 
						{name: 'Settled_Amount',         index: 'Settled_Amount',    	jsonmap: 'Settled_Amount', 	    sortable: false, align: 'right',  width: 110, resizable: false,     unformat: unformatData                                   },//formatter: cellFomatterPaymentsColumn_2,
						{name: 'Balance_Amount',         index: 'Balance_Amount',   	jsonmap: 'Balance_Amount',  	sortable: false, align: 'right',  width: 100, resizable: false,     unformat: unformatData },//formatter: cellFomatterGroupPay,
						{name: 'Availability',           index: 'Availability',   	    jsonmap: 'Availability',  	    sortable: false, align: 'right',  width: 100, resizable: false,     unformat: unformatData ,  formatter:cellFomatterNumberAvailability, hidden:true },//formatter: cellFomatterGroupPay,
						{name: 'Total_Receivable',       index: 'Total_Receivable',   	jsonmap: 'Total_Receivable',  	sortable: false, align: 'right',  width: 100,  resizable: false,    unformat: unformatData                                   },//formatter: cellFomatterPaymentsColumn_6,
						{name: 'Settl_Amount',           index: 'Settl_Amount',     	jsonmap: 'Settl_Amount',    	sortable: false, align: 'right',  width: 140,  resizable: false,    unformat: unformatData, formatter:cellFomatterGroupPay     },//formatter: cellFomatterNetPay,
						{name: 'Mode',                   index: 'Mode',             	jsonmap: 'Mode',  			    sortable: false, align: 'center', width: 80,  resizable: false,     unformat: unformatData, formatter:cellFomatterPayMode    },//formatter: cellFomatterPaymentsColumn_7, 
						{name: 'Company_Bank_Account',   index: 'Company_Bank_Account', jsonmap: 'Company_Bank_Account',sortable: false, align: 'center', width: 110, resizable: false,     unformat: unformatData, formatter:cellFomatterPayCompanyAccNo },//formatter: cellFomatterPaymentsColumn_8,
						{name: 'Comments',               index: 'Comments',            	jsonmap: 'Comments', 			sortable: false, align: 'center', width: 120,  resizable: false,    unformat: unformatData, formatter:cellFomatterPayComment },//formatter: cellFomatterPaymentsColumn_9,
						{name: 'Pay_Type',               index: 'Pay_Type',            	jsonmap: 'Pay_Type',  			    sortable: false, align: 'center', width: 120,  resizable: false,    unformat: unformatData, formatter:cellFomatterPayEntMode, hidden:true },//formatter: cellFomatterPaymentsColumn_7, 
						{name: 'Spot_Margin',            index: 'Spot_Margin',      	jsonmap: 'Spot_Margin',  			    sortable: false, align: 'right', width: 120,  resizable: false,    unformat: unformatData,  formatter:cellFomatterNumber },//formatter: cellFomatterPaymentsColumn_7, 
						{name: 'Market_Margin',          index: 'Market_Margin',       	jsonmap: 'Market_Margin',  			    sortable: false, align: 'right', width: 120,  resizable: false,    unformat: unformatData,  formatter:cellFomatterNumber },//formatter: cellFomatterPaymentsColumn_7, 
						{name: 'Save',                   index: 'Save',           	    jsonmap: 'Save', 			    sortable: false, align: 'center', width: 80,  resizable: false,     unformat: unformatData, formatter:checkBoxFmatterPaySave },
						],
                   mtype: 'GET',
                   rownumbers: true,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
                   toolbar: [false, 'top'],
                   caption: 'Broker Payments - by Client - Detail',
				   jsonReader: {repeatitems: false},
				   footerrow: true,
                   userDataOnFooter: true,			
				   onCellSelect: jq_grid_click_event_broker_pay,			
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
                          
                          
                        
                        
                         //  $('#DIV_NET_AVAILABILITY').text(format_noobject0($('#HID_FINAL_AVAILABILITY').val(), 2, null, 'BRACKETS'));
                           //init_fancybox();
                           //initCal('TXT_VALUE_DATE_' + '1');
                          /* if ((document.Form1.hid_payments_count_new.value == '0') && (m_onload_add_payment_flag == false)) {
                              // addPaymentItem();
                              // m_onload_add_payment_flag = true;
							}*/
                           //get_exchange_rate();
						
						
					},
					loadComplete : function(){
                        var rec_count=$("#TABLE_CLIENT_PAYMENT_SIGNATURE").jqGrid('getGridParam',"records");
                        document.Form1.hid_count.value=rec_count;
					}
               });
           }
			
			function jq_grid_click_event_broker_pay(rowid, iCol, cellcontent) {
					
			
			 var m_selected_row = jQuery('#TABLE_CLIENT_PAYMENT_SIGNATURE').jqGrid('getRowData', rowid);
			 var m_broker_code  = m_selected_row.Broker;
				
              /* if (iCol == 4) {
                
				var m_to_date = document.Form1.TXT_TODATE.value;
				var m_to_month = document.Form1.TXT_TOMONTH.value;
				var m_to_year = document.Form1.TXT_TOYEAR.value;
				var  m_url=jsp_client_url+"dn_broker_payment_drill_down.jsp?broker_code="+m_broker_code+"&to_date="+m_to_date+"&to_month="+m_to_month+"&to_year="+m_to_year;
				
					
				  window.open(m_url,'broker_payment_drill_down', 'left = 0, top = 0, toolbar = 0, location = 0, directories = 0, status = 0, menuBar = 0, scrollBars = 1, resizable = 1, width = ' + screen.availWidth + ', height = ' + screen.availWidth);
					
                   }
				*/
		/*	if (iCol == 5) {
                
				var m_to_date = document.Form1.TXT_TODATE.value;
				var m_to_month = document.Form1.TXT_TOMONTH.value;
				var m_to_year = document.Form1.TXT_TOYEAR.value;
				var  m_url=jsp_client_url+"dn_broker_payment_drill_down.jsp?broker_code="+m_broker_code+"&to_date="+m_to_date+"&to_month="+m_to_month+"&to_year="+m_to_year;
				
					
				  window.open(m_url,'broker_payment_drill_down', 'left = 0, top = 0, toolbar = 0, location = 0, directories = 0, status = 0, menuBar = 0, scrollBars = 1, resizable = 1, width = ' + screen.availWidth + ', height = ' + screen.availWidth);
					
			}*/
			
				
									
		}
		  function cellFomatterPayBeneficiary (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='m_broker_code_"+row_id+"' name='m_broker_code_"+row_id+"' value='"+cellvalue+"'  /></span>";
                     return texts;
                     } 
			
			 function cellFomatterPaymentNo (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='PAYMENTNO"+row_id+"' name='PAYMENTNO"+row_id+"' value='"+cellvalue+"'  /></span>";
                     return texts;
                     } 
			
		function cellFomatterFacilityNo (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='hid_facility_no_"+row_id+"' name='hid_facility_no_"+row_id+"' value='"+unformat_noobject(cellvalue)+"'  /></span>";
                     return texts;
                     }	
			
	   function cellFomatterDueDate (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     if(row_id!=''){
			         var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='hid_from_date_"+row_id+"' name='hid_from_date_"+row_id+"' value='"+unformat_noobject(cellvalue)+"'  /></span>";
                         texts = texts + "<span><input type='hidden' align='right' style ='text-align: right;'  id='hid_to_date_"+row_id+"' name='hid_to_date_"+row_id+"' value='"+unformat_noobject(cellvalue)+"'  /></span>";
			         return texts;
						}else{
						return '&nbsp;'; 
						}
                     }	
			
		function cellFomatterGroupPay (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     if(row_id!=''){
			         var texts = "<span><input type='text' align='right' style ='text-align: right;'  id='hid_group_amount_"+row_id+"' name='hid_group_amount_"+row_id+"' value='"+unformat_noobject(cellvalue)+"'  /></span>";
                     return texts;
					  }else{
					  return '&nbsp;';	
					}
                  }
		function cellFomatterNetPay (cellvalue, options, rowObject){
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
	      function checkBoxFmatterPaySave (cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='checkbox' id='save_status_"+rowid+"'  name='save_status_"+rowid+"' value='on'   onclick =chk_net_payment('"+rowid+"');  />";  <!--onclick =guaran('"+rowid+"');check_amount('"+rowid+"');  onchange=guaran('"+rowid+"');check_amount('"+rowid+"') -->
              return link;
		  }
			
			function cellFomatterPaymentView (cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='button' id='view_"+rowid+"'  name='view_"+rowid+"' value='View'  onclick =pay_view('"+rowid+"');     />"; 
              return link;
		  }
		
		 function pay_view(row_id){
			
		 }
			
		
		function chk_net_payment(row_id){
			
			var m_selected_row      = jQuery('#TABLE_CLIENT_PAYMENT_SIGNATURE').jqGrid('getRowData', row_id);
           // var m_Net_Amount        =  m_selected_row.Net_Amount;
            var m_sett_amount_id    = 'hid_sett_type_'+row_id;
			var m_group_net_mode_id = 'hid_group_net_mode_'+row_id;
		    var mm_save_status      = 'save_status_'+row_id;
			
			
			if(document.getElementById(m_sett_amount_id).value=='N/A'){
			alert('Please select Payment Mode.');
			document.getElementById(mm_save_status).checked=false;	
			}else if(document.getElementById(m_group_net_mode_id).value=='N/A') {
			alert('Please select  Settlement Mode.');
			document.getElementById(mm_save_status).checked=false;		
			}/*else if(m_Net_Amount<0 && document.getElementById(m_group_net_mode_id).value=='NET' ){
			    alert('Net Payment can not be negative..!');
				document.getElementById(mm_save_status).checked=false;	
			}*/else if(document.getElementById('hid_group_amount_'+row_id).value<0) {
			alert('Payment can not be negative..!');
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
		function cellFomatterNumberAvailability(cellvalue, options, rowObject) {
          
			   cellvalue = format_noobject00(cellvalue, 2, null, 'BRACKETS');
               cellvalue = '<div style = "cursor: default;">' + cellvalue + '</div>';
               return cellvalue;
					
			
           }	
		 function cellFomatterPayComment(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span><input type='text' align='left' style ='text-align: left;'  id='comment_"+row_id+"' name='comment_"+row_id+"' value=''/></span>";
                     return texts;
          }
			
		 function cellFomatterPayEntMode(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     //var texts = "<span><select name='hid_group_net_mode_"+row_id+"'  ><OPTION VALUE='GROUP' SELECTED>Gross Payments</OPTION><OPTION VALUE='NET'>Net Settlements</OPTION></select></span>";
				     if(row_id!=''){
				     var texts = "<span><select name='hid_group_net_mode_"+row_id+"' id='hid_group_net_mode_"+row_id+"'   ><OPTION VALUE='INV' SELECTED>Individual Payments</OPTION></select></span>";
				     return texts;
					 }else{
					 return '&nbsp;';	
					 }		
				
          }		
		 function cellFomatterPayMode(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
				     var texts = "";
				if(row_id!=''){
				    if(cellvalue=='CHEQUE'){
                     texts = "<span><select name='hid_sett_type_"+row_id+"'   id='hid_sett_type_"+row_id+"' ><OPTION VALUE='CHEQUE' SELECTED>CHEQUE</OPTION><OPTION VALUE='PAY_ORDER'>PAY ORDER</OPTION><OPTION VALUE='BANK_TRANF'>BANK TRANF</OPTION></select></span>";
					}else if(cellvalue=='PAY_ORDER'){
					  texts = "<span><select name='hid_sett_type_"+row_id+"'  id='hid_sett_type_"+row_id+"'   ><OPTION VALUE='CHEQUE' >CHEQUE</OPTION><OPTION VALUE='PAY_ORDER' SELECTED >PAY ORDER</OPTION><OPTION VALUE='BANK_TRANF'>BANK TRANF</OPTION></select></span>";
					}else if(cellvalue=='BANK_TRANF'){
					  texts = "<span><select name='hid_sett_type_"+row_id+"'  id='hid_sett_type_"+row_id+"'  ><OPTION VALUE='CHEQUE'>CHEQUE</OPTION><OPTION VALUE='PAY_ORDER'>PAY ORDER</OPTION><OPTION VALUE='BANK_TRANF' SELECTED >BANK TRANF</OPTION></select></span>";
					}else{
					  texts = "<span><select name='hid_sett_type_"+row_id+"'  id='hid_sett_type_"+row_id+"'  ><OPTION VALUE='N/A' >N/A</OPTION><OPTION VALUE='CHEQUE' >CHEQUE</OPTION><OPTION VALUE='PAY_ORDER'>PAY ORDER</OPTION><OPTION VALUE='BANK_TRANF'>BANK TRANF</OPTION></select></span>";
					}
				
				      return texts;
				}else{
				 return '&nbsp;';
				}	
					
          }	
			
		function showPurchaseDrill2(transaction_date){		
	                     if ($('#DIV_DRILL_DOWN_2').dialog('isOpen')) {
                             $('#DIV_DRILL_DOWN_2').dialog('close');
                           }
                           $('#IFRAME_DRILL_DOWN_2').attr('src', '');
                           $('#IFRAME_DRILL_DOWN_2').remove();
                           $('#DIV_DRILL_DOWN_2').html(iframe_html_string_2);
                           $('#DIV_DRILL_DOWN_2').dialog('option', 'title', 'Drill Down');
                           
                           $('#IFRAME_DRILL_DOWN_2').attr('src', jsp_client_url+"/dn_parchase_drildown_2.jsp?chksql=parchase_details_settle_date_2&facility_no=000941&start_date=" + transaction_date + "&end_date=" + transaction_date);
                           $('#DIV_DRILL_DOWN_2').dialog('open');	
       }
			
		function cellFomatterPayCompanyAccNo(cellvalue, options, rowObject){
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
			document.getElementById("DIV_PAYMENT_SIGNATURE").innerHTML ="<table id = 'TABLE_CLIENT_PAYMENT_SIGNATURE'></table><div id = 'DIV_PAGER_TABLE_CLIENT_PAYMENT_SIGNATURE'></div>";
          document.getElementById("txt_client_code").value="";
		  document.getElementById("TXT_CLIENT_MANAGER").value="";
		  document.getElementById("txt_facility_number").value="";
		  document.getElementById("txt_broker_code").value="";
		
		  document.getElementById("txt_facility_number_name").value="";
		  document.getElementById("TXT_CLIENT_MANAGER_NAME").value="";
		  document.getElementById("txt_facility_number").value="";
		  document.getElementById("txt_broker_full_name").value=""; 
		  loadGridPaymentsAppove();
			}
			
		function fnSave(){
			            document.Form1.Hid_scr_name.value="payment_level_3";
						document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_payments_level3";
						document.Form1.submit();
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
	myObject[1]=aForm.txt_facility_number_name;
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
    
    <body class="body & txt-body"  ><!-- onload="display_dat();"-->
        <form name="Form1" id="Form1" method="post" >
			 <input type = "hidden" id = "Hid_scr_name" name = "Hid_scr_name" Value="payment_first_sig" />
			 <input type = "hidden" id = "hid_count" name = "hid_count" />
		     <div>
                <table class="table" align="center" border="0" cellpadding="0" cellspacing="0" width="99%">
                    <tr>
                        <td height="7"></td>
                    </tr>
                    
                    <tr height="30">
                        <td width="13px" style="background-image: url('<%= m_jsp_client_url %>/images/l1.gif'); background-repeat: no repeat;" id="hi1"></td>
                        <td style="background-image: url('<%= m_jsp_client_url %>/images/l3.gif'); background-repeat: repeat;" id="hi2" align="left"><b>Margin Trading - Settlement Management</b></td>
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
                    <td width="50%" class="hh1" align="right"><b>Broker Payments</b></td>
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
				
				
			<table border = "0">
				
				
				<tr>
						<td style = "width: 200px;"><div id = "DIV_TXT_CLIENT_MANAGER">Date</div></td>
						<td>
						       <INPUT TYPE="Text" NAME="TXT_TODATE"  ID="TXT_TODATE"  VALUE="<%=request.getParameter("to_date").toUpperCase()%>"  SIZE=3 MAXLENGTH=2 class="txt_input5" >
						       <INPUT TYPE="Text" NAME="TXT_TOMONTH" ID="TXT_TOMONTH" VALUE="<%=request.getParameter("to_month").toUpperCase()%>"   SIZE=3 MAXLENGTH=2 class="txt_input5" >
						       <INPUT TYPE="Text" NAME="TXT_TOYEAR"  ID="TXT_TOYEAR"  VALUE="<%=request.getParameter("to_year").toUpperCase()%>"  SIZE=4 MAXLENGTH=4 class="txt_input5" ONBLUR="chkstartdate(document.Form1.TXT_TODATE,document.Form1.TXT_TOMONTH,document.Form1.TXT_TOYEAR);checksettlementdate(document.Form1.TXT_TODATE,document.Form1.TXT_TOMONTH,document.Form1.TXT_TOYEAR);"  >
						    
					      </td>
						<td style = "width: 60px;">
						 <INPUT TYPE = "HIDDEN" NAME = "VAL_TXT_DATE" ID = "VAL_TXT_DATE" />
						 </td>
						<td style = "width: 120px;">
						
						<input class = "but_input" type = "button" id = "BUT_VIEW_ALL" name = "BUT_VIEW_ALL" value = "View All" style = "width: 80px;" onclick="fn_veiwall()"/>
					</td>
						<td style = "width: 200px;">
						  </td>
						   <td>
						</td>
					</tr>
					
					<tr>
                          <td style = "width: 200px;"><div id = "DIV_TXT_CLIENT_MANAGER">Client Manager Code</div></td>
						       <td><input class = "txt_input" type = "text" id = "TXT_CLIENT_MANAGER" name = "TXT_CLIENT_MANAGER" maxlength = "15" style = "width: 125px;" value="<%=request.getParameter("client_manager").toUpperCase()%>" />
                                  </td>
                                      <td style = "width: 60px;">
                                         <input class = "but_input" type = "button" id = "BUT_HELP_CLIENT_MANAGER_MAIN" name = "BUT_HELP_CLIENT_MANAGER_MAIN" value = "..." onclick="client_manager_code_help(0);" />
                                             <td style = "width: 120px;">
                                            
                                        </td>
                                    <td style = "width: 200px;"><div id = "DIV_TXT_CLIENT_MANAGER_NAME">Client Manager Name</div></td>
                                <td>
                             <input class = "txt_input" type = "text" id = "TXT_CLIENT_MANAGER_NAME" name = "TXT_CLIENT_MANAGER_NAME" style = "width: 250px;" disabled = "disabled" />
                          </td>
                      </tr>
					
					
					<tr>
                         <td style = "width: 200px;"><div id = "div_txt_client_code">Client Code</div></td>
                              <td><input class = "txt_input" type = "text" id = "txt_client_code" name = "txt_client_code" maxlength = "250" style = "width: 125px;" value="<%=request.getParameter("client_code").toUpperCase()%>"  /></td>
                                  <td style = "width: 60px;"><input class = "but_input" type = "button" id = "but_help_client_code_main" name = "but_help_client_code_main" value = "..."  onclick="client_code_help(0)"/>
                                       </td>
                                       <td style = "width: 120px;"></td>
                               <td style = "width: 200px;"><div id = "div_txt_client_full_name">Client Full Name</div></td>
                           <td><input class = "txt_input" type = "text" id = "txt_client_full_name" name = "txt_client_full_name" style = "width: 250px;" disabled = "disabled" /></td>
                     </tr>
					  
					<tr>
                          <td style = "width: 200px;"><div id = "div_txt_facility_number">Facility Number</div></td>
						       <td><input class = "txt_input" type = "text" id = "txt_facility_number" name = "txt_facility_number" VALUE="<%=request.getParameter("facility_no").toUpperCase()%>"  maxlength = "15" style = "width: 125px;" VALUE="<%=request.getParameter("facility_no").toUpperCase()%>" />
                                  </td>
                                      <td style = "width: 60px;">
                                         <input class = "but_input" type = "button" id = "BUT_HELP_FACILITY_NUMBER" name = "BUT_HELP_FACILITY_NUMBER" value = "..." onclick="facility_number_help(0);"  />
                                             <a id = "help_update_client_manager" style = "text-decoration: none; cursor: text;" class = "fancylink iframe" href = ""> </a>
                                              <td style = "width: 120px;">
                                           
                                        </td>
                                    <td style = "width: 200px;"><div id = "txt_facility_number_name">Facility Number</div></td>
                                <td>
                             <input class = "txt_input" type = "text" id = "txt_facility_number_name" name = "txt_facility_number_name" style = "width: 250px;" disabled = "disabled" />
                          </td>
                      </tr>
					
                    <tr>
                          <td style = "width: 200px;"><div id = "div_txt_broker_code">Broker Code</div></td>
						       <td><input class = "txt_input" type = "text" id = "txt_broker_code" name = "txt_broker_code" maxlength = "15" style = "width: 125px;" value="<%=request.getParameter("broker_code").toUpperCase()%>"/>
                                  </td>
                                      <td style = "width: 60px;">
                                         <input class = "but_input" type = "button" id = "BUT_HELP_CLIENT_MANAGER_MAIN" name = "BUT_HELP_CLIENT_MANAGER_MAIN" value = "..." onclick="broker_code_help(0);" />
                                             
                                              <td style = "width: 120px;">
                                          <input class = "but_input" type = "button" id = "BUT_SEARCH" name = "BUT_SEARCH" value = "Search" style = "width: 80px;" onclick="loadGridPaymentsAppove();"/>
                                        </td>
                                    <td style = "width: 200px;"><div id = "txt_broker_full_name">Broker Full Name</div></td>
                                <td>
                             <input class = "txt_input" type = "text" id = "txt_broker_full_name" name = "txt_broker_full_name" style = "width: 250px;" disabled = "disabled" />
                          </td>
                      </tr>                               
                                                 
               </table>	
							
			
				
				
			<BR>	
				
	  <div id = "DIV_PAYMENT_SIGNATURE">
                     <table id = "TABLE_CLIENT_PAYMENT_SIGNATURE"></table>
                      <div id = "DIV_PAGER_TABLE_CLIENT_PAYMENT_SIGNATURE"></div>

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
	