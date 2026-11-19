<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Calendar" %>
<%@page import="java.util.Date" %>
<%@page import="net.sasianet.ADLMARGIN.*" %>
<%
	ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods();
	String m_jsp_client_url = m_sn_methods.jsp_client_url;
	
		//***************  ADDED BY KANISHKA ON 26/12/2012  *********************//
	
		Object done = (String)session.getValue("logon.isDone");  // marker object
		if (done == null) {
			response.sendRedirect("login.jsp");
			return;
			}
	
	//*************** ADDED BY KANISHKA ON 26/12/2012 [END]  *********************//
	Calendar calendar = Calendar.getInstance();
	
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
			
			var iframe_html_string_1 = '<iframe id = "IFRAME_DRILL_DOWN_1" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Drill Down"></iframe>';		
			var iframe_html_string_2 = '<iframe id = "IFRAME_DRILL_DOWN_2" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Drill Down"></iframe>';		
			var m_sysdate = '<%=system_day+"-"+system_month+"-"+system_year%>';
			var m_sysdate_dd = m_sysdate.substring(0, 2);
			var m_sysdate_mm = m_sysdate.substring(3, 5);
			var m_sysdate_yy = m_sysdate.substring(6, 10); 
			$(document).ready(function() {
					//init_fancybox();
					initDrillDownDialog();
					m_grid_height = ($(window).height() - 310);
					//bind_events();
					//loadGridAvailabilityReport();
				});
			
			
			function fn_veiwall(){
				fnCancel();
				loadGridAvailabilityReport();
			}	
			
			function loadGridAvailabilityReport() {
				
				//var m_client_code= document.getElementById("txt_client_code").value;
				//var m_client_manager= document.getElementById("TXT_CLIENT_MANAGER").value;
				var m_port= document.getElementById("txt_facility_number").value;
				//var m_broker_code= document.getElementById("txt_broker_code").value;	 	
				//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"BrokerBulkPaymentsFirstSign?chksql=bulk_save_increase_availability&port="+m_port+"&client_code="+m_client_code+"&client_manager="+m_client_manager+"&broker_code="+m_broker_code+"";
				//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"increase_availability?chksql=get_increase_availability_summary&port="+m_port+"";		CHANGE BY WARUAN 2012-09-28
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"increase_availability?chksql=get_increase_availability_summary_ent&port="+m_port+"";
				jQuery('#TABLE_CLIENT_AVAILABILITY_INCREASE').GridUnload();
				jQuery('#TABLE_CLIENT_AVAILABILITY_INCREASE').jqGrid({
						url: m_url,
						//loadonce: 1,
						datatype: 'json',
						colNames: ['','System','Recommended'],
						colModel: [
							{name: 'Summery',             index: 'Summery',   		jsonmap: 'Summery',         sortable: false, align: 'left',   width: 180, resizable: false,    unformat: unformatData },//formatter: cellFomatterPaymentsColumn_1,
							{name: 'System',              index: 'System',   	    jsonmap: 'System', 	        sortable: false, align: 'right',  width: 100, resizable: false,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_1,
							{name: 'Recommended',         index: 'Recommended',  	jsonmap: 'Recommended', 	sortable: false, align: 'right' , width: 100, resizable: false,  unformat: unformatData}
						],//Voucher
						mtype: 'GET',
						rownumbers: false,
						rowNum: -1,
						gridview: true,
						height: 'auto',
						hidegrid: false,
						toolbar: [false, 'top'],
						caption: 'Availability Report',
						footerrow: true,
                        userDataOnFooter: true,
						onCellSelect: jq_grid_click_event_avail_summary,				
						jsonReader: {repeatitems: false},
						gridComplete: function() {
							
							loadGridCompanyValuation();
							
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
							var rec_count=$("#TABLE_CLIENT_AVAILABILITY_INCREASE").jqGrid('getGridParam',"records");
							document.Form1.hid_count.value=rec_count;
						}
					});
			}
			
			function loadGridCompanyValuation() {
				
				// var m_client_code= document.getElementById("txt_client_code").value;
				//var m_client_manager= document.getElementById("TXT_CLIENT_MANAGER").value;
				var m_port= document.getElementById("txt_facility_number").value;
				//var m_broker_code= document.getElementById("txt_broker_code").value;		
				
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"increase_availability?chksql=get_increase_availability_company_valuation&port="+m_port+"";		
				
				jQuery('#TABLE_CLIENT_COMPANY_VALUATION').GridUnload();
				jQuery('#TABLE_CLIENT_COMPANY_VALUATION').jqGrid({
						url: m_url,
						//loadonce: 1,
						datatype: 'json',
						colNames: ['Security Code','Security Name','Rating','Security %','Market Price',
							'No of shares','Allowable %','Company Valuation','Recommended %','Adjusted Company Valuation','Enhanced Availability',
							'This Payment','This Period','Permanent','Comment'],
						colModel: [
							{name: 'Security_Code',       index: 'Security_Code', 	jsonmap: 'Security_Code',         sortable: false, align: 'left',   width: 100, resizable: false,    unformat: unformatData ,formatter:cellFomatterSecurity_Code},//formatter: cellFomatterPaymentsColumn_1,
							{name: 'Security_Name',       index: 'Security_Name',   jsonmap: 'Security_Name', 	      sortable: false, align: 'right',  width: 100, resizable: true,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_1,
							{name: 'Rating',              index: 'Rating',  	    jsonmap: 'Rating',           	  sortable: false, align: 'right' , width: 100, resizable: false,  unformat: unformatData},
							{name: 'Security_Per',        index: 'Security_Per',    jsonmap: 'Security_Per',          sortable: false, align: 'right' , width: 100, resizable: false,  unformat: unformatData},
							{name: 'Market_Price',        index: 'Market_Price',    jsonmap: 'Market_Price',          sortable: false, align: 'right' , width: 100, resizable: false,  unformat: unformatData},
							{name: 'No_of_shares',        index: 'No_of_shares',    jsonmap: 'No_of_shares',          sortable: false, align: 'right' , width: 100, resizable: false,  unformat: unformatData},
							{name: 'Allowable_Per',       index: 'Allowable_Per',   jsonmap: 'Allowable_Per',         sortable: false, align: 'right' , width: 100, resizable: false,  unformat: unformatData},
							{name: 'Company_Valuation',   index: 'Company_Valuation',jsonmap: 'Company_Valuation',    sortable: false, align: 'right' , width: 120, resizable: false,  unformat: unformatData},
							{name: 'Recommended_Per',     index: 'Recommended_Per', jsonmap: 'Recommended_Per',    	  sortable: false, align: 'right' , width: 120, resizable: false,  unformat: unformatData, formatter:cellFomatterRecommended_Per},
							{name: 'Adjusted_Company_Val',index: 'Adjusted_Company_Val',  jsonmap: 'Adjusted_Company_Val', sortable: false, align: 'right' , width: 130, resizable: false,  unformat: unformatData,  formatter:cellFomatterAdjusted_Company_Val},
							{name: 'Enhanced_Availability',index: 'Enhanced_Availability',jsonmap: 'Enhanced_Availability',sortable: false, align: 'right' , width: 130, resizable: false,  unformat: unformatData,  formatter:cellFomatterEnhanced_Availability},
							{name: 'This_Payment',        index: 'This_Payment',    jsonmap: 'This_Payment',      	  sortable: false, align: 'right' , width: 100, resizable: false,  unformat: unformatData,  formatter:cellFormatterThisPayment  },
							{name: 'This_Period',         index: 'This_Period',     jsonmap: 'This_Period',        	  sortable: false, align: 'right' , width: 150, resizable: false,  unformat: unformatData,  formatter:cellFormatterThisPeriod},
							{name: 'Permanent',           index: 'Permanent',  	    jsonmap: 'Permanent',             sortable: false, align: 'right' , width: 100, resizable: false,  unformat: unformatData,  formatter:cellFormatterPermanent},
							{name: 'Comment',             index: 'Comment',  	    jsonmap: 'Comment',           	  sortable: false, align: 'right' , width: 100, resizable: false,  unformat: unformatData,  formatter:cellFormatterComment}
						],//Voucher
						mtype: 'GET',
						rownumbers: false,
						rowNum: -1,
						gridview: true,
						height: 'auto',
						hidegrid: false,
						toolbar: [false, 'top'],
						caption: 'Company Valuation',
						//onCellSelect: jq_grid_click_event_CompanyValuation,				
						jsonReader: {repeatitems: false},
						gridComplete: function() {
							
							//jq_grid_load_complete_CompanyValuation('TABLE_CLIENT_COMPANY_VALUATION');
							loadgridconcentration_adj();
							
							
						},
						loadComplete : function(){
							var rec_count=$("#TABLE_CLIENT_COMPANY_VALUATION").jqGrid('getGridParam',"records");
							 document.Form1.hid_count_tbl_com_val.value=rec_count;
						}
					});
			}
			
			function loadgridconcentration_adj() {
				
				// var m_client_code= document.getElementById("txt_client_code").value;
				//var m_client_manager= document.getElementById("TXT_CLIENT_MANAGER").value;
				var m_port= document.getElementById("txt_facility_number").value;
				//var m_broker_code= document.getElementById("txt_broker_code").value;		
				
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"increase_availability?chksql=get_increase_availability_concentration_adj&port="+m_port+"";		
				
				jQuery('#TABLE_CLIENT_CONCENTRATION_ADJ').GridUnload();
				jQuery('#TABLE_CLIENT_CONCENTRATION_ADJ').jqGrid({
						url: m_url,
						//loadonce: 1,
						datatype: 'json',
						colNames: ['Security Code','Security Name','Rating','Security %',/*'Market Price',
							'No of shares','Allowable %',*/'Company Valuation','Concentration','Valuation','Recommended %','Adjusted Company Valuation','Enhanced Availability',
							'This Payment','This Period','Permanent','Comment'],
						colModel: [
							{name: 'Security_Code',       index: 'Security_Code', 	jsonmap: 'Security_Code',         sortable: false, align: 'left',   width: 100, resizable: false,  unformat: unformatData ,formatter:cellFomatterSecurity_Code},//formatter: cellFomatterPaymentsColumn_1,
							{name: 'Security_Name',       index: 'Security_Name',   jsonmap: 'Security_Name', 	      sortable: false, align: 'right',  width: 100, resizable: true,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_1,
							{name: 'Rating',              index: 'Rating',  	    jsonmap: 'Rating',           	  sortable: false, align: 'right' , width: 100, resizable: false,  unformat: unformatData},
							{name: 'Security_Per',        index: 'Security_Per',    jsonmap: 'Security_Per',          sortable: false, align: 'right' , width: 100, resizable: false,  unformat: unformatData},
							
							//{name: 'Market_Price',        index: 'Market_Price',    jsonmap: 'Market_Price',          sortable: false, align: 'right' , width: 100, resizable: false,  unformat: unformatData},
							//{name: 'No_of_shares',        index: 'No_of_shares',    jsonmap: 'No_of_shares',          sortable: false, align: 'right' , width: 100, resizable: false,  unformat: unformatData},
							//{name: 'Allowable_Per',       index: 'Allowable_Per',   jsonmap: 'Allowable_Per',         sortable: false, align: 'right' , width: 100, resizable: false,  unformat: unformatData},
							{name: 'Company_Valuation',   index: 'Company_Valuation',jsonmap: 'Company_Valuation',    sortable: false, align: 'right' , width: 120, resizable: false,  unformat: unformatData},
							{name: 'Concentration',       index: 'Concentration',   jsonmap: 'Concentration',         sortable: false, align: 'right' , width: 100, resizable: false,  unformat: unformatData},
							{name: 'Valuation',           index: 'Valuation',       jsonmap: 'Valuation',             sortable: false, align: 'right' , width: 100, resizable: false,  unformat: unformatData},
							
							{name: 'Recommended_Per',     index: 'Recommended_Per', jsonmap: 'Recommended_Per',    	  sortable: false, align: 'right' , width: 120, resizable: false,  unformat: unformatData, formatter:cellFomatterRecommended_Per},
							{name: 'Adjusted_Company_Val',index: 'Adjusted_Company_Val',  jsonmap: 'Adjusted_Company_Val', sortable: false, align: 'right' , width: 130, resizable: false,  unformat: unformatData,  formatter:cellFomatterAdjusted_Company_Val},
							{name: 'Enhanced_Availability',index: 'Enhanced_Availability',jsonmap: 'Enhanced_Availability',sortable: false, align: 'right' , width: 130, resizable: false,  unformat: unformatData,  formatter:cellFomatterEnhanced_Availability},
							{name: 'This_Payment',        index: 'This_Payment',    jsonmap: 'This_Payment',      	  sortable: false, align: 'right' , width: 100, resizable: false,  unformat: unformatData,  formatter:cellFormatterThisPayment  },
							{name: 'This_Period',         index: 'This_Period',     jsonmap: 'This_Period',        	  sortable: false, align: 'right' , width: 150, resizable: false,  unformat: unformatData,  formatter:cellFormatterThisPeriod},
							{name: 'Permanent',           index: 'Permanent',  	    jsonmap: 'Permanent',             sortable: false, align: 'right' , width: 100, resizable: false,  unformat: unformatData,  formatter:cellFormatterPermanent},
							{name: 'Comment',             index: 'Comment',  	    jsonmap: 'Comment',           	  sortable: false, align: 'right' , width: 100, resizable: false,  unformat: unformatData,  formatter:cellFormatterComment}
						],//Voucher
						mtype: 'GET',
						rownumbers: false,
						rowNum: -1,
						gridview: true,
						height: 'auto',
						hidegrid: false,
						toolbar: [false, 'top'],
						caption: 'Concentration Adjustment',
						//onCellSelect: jq_grid_click_event_CompanyValuation,				
						jsonReader: {repeatitems: false},
						gridComplete: function() {
							
							jq_grid_load_complete_CompanyValuation('TABLE_CLIENT_COMPANY_VALUATION');
							jq_grid_load_complete_concentration_adj('TABLE_CLIENT_CONCENTRATION_ADJ');
						    loadGridReceiptsAppove();	 					
							
						},
						loadComplete : function(){
							var rec_count=$("#TABLE_CLIENT_CONCENTRATION_ADJ").jqGrid('getGridParam',"records");
							 document.Form1.hid_count_tbl_con_adj.value=rec_count;
						}
					});
			}
			
		 function loadGridReceiptsAppove() {
            
		   var m_client_code    = '';//document.getElementById("txt_client_code").value;
		   var m_client_manager = '';//document.getElementById("TXT_CLIENT_MANAGER").value;
		   var m_port           = document.getElementById("txt_facility_number").value;
		   var m_broker_code    = '';//document.getElementById("txt_broker_code").value;		
		   var m_to_date      =  '<%=system_day+"-"+system_month+"-"+system_year%>';//document.getElementById("TXT_TODATE").value+"-"+document.getElementById("TXT_TOMONTH").value+"-"+document.getElementById("TXT_TOYEAR").value;			
               m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"increase_availability?chksql=receipt_level3&port="+m_port+"&client_code="+m_client_code+"&client_manager="+m_client_manager+"&broker_code="+m_broker_code+"&to_date="+m_to_date;
					
					
										
					jQuery('#TABLE_CLIENT_RECEIPTS').GridUnload();
					jQuery('#TABLE_CLIENT_RECEIPTS').jqGrid({
                    url: m_url,
                   //loadonce: 1,
                   datatype: 'json',
                   colNames: [/*'Broker','Facility Number','Client Name',*/'Due Date','Due Amount','Settled Amount' ,' Expected Amount' ,/*'Availability','Total Payable',*/' Settlement Amount','Enhanced Availability'/*,'Mode', 'Company Bank Account', 'Comments',' Settlement Mode', 'Spot Margin (%)','Spot Margin (Market)'*/,'This_Payment'],
                   colModel: [
						//{name: 'View',                  index: 'View',   		jsonmap: 'View',                        sortable: false, align: 'center', width: 90,  resizable: false,     unformat: unformatData, formatter:cellFomatterReceiptView},//formatter: cellFomatterReceiptsColumn_1,
						//{name: 'Broker',                 index: 'Broker',   		    jsonmap: 'Broker',              sortable: false, align: 'center', width: 90,  resizable: false,     unformat: unformatData, formatter:cellFomatterBroker     },//formatter: cellFomatterReceiptsColumn_1,
						//{name: 'Broker_Name',            index: 'Broker_Name',   	    jsonmap: 'Broker_Name', 	    sortable: false, align: 'Left',   width: 100, resizable: true,      unformat: unformatData                                   },//formatter: cellFomatterReceiptsColumn_1,
						//{name: 'Facility_No',            index: 'Facility_No',   	    jsonmap: 'Facility_No', 	    sortable: false, align: 'Left',   width: 100, resizable: true,      unformat: unformatData, formatter:cellFomatterFacilityNo                                    },//formatter: cellFomatterReceiptsColumn_1,
						//{name: 'Client_Name',            index: 'Client_Name',   	    jsonmap: 'Client_Name', 	    sortable: false, align: 'Left',   width: 100, resizable: true,      unformat: unformatData                                   },//formatter: cellFomatterReceiptsColumn_1,
						{name: 'Due_Date',               index: 'Due_Date',  	        jsonmap: 'Due_Date', 	        sortable: false, align: 'cenete', width: 100, resizable: false,     unformat: unformatData, formatter:cellFomatterDueDate    },
						{name: 'Due_Amount',             index: 'Due_Amount',  	        jsonmap: 'Due_Amount',hidden:true, sortable: false, align: 'right' , width: 100, resizable: false,     unformat: unformatData                                   },//formatter:cellFomatterGroupRec 
						{name: 'Settled_Amount',         index: 'Settled_Amount',    	jsonmap: 'Settled_Amount', 	    sortable: false, align: 'right',  width: 110, resizable: false,     unformat: unformatData                                   },//formatter: cellFomatterReceiptsColumn_2,
						{name: 'Balance_Amount',         index: 'Balance_Amount',   	jsonmap: 'Balance_Amount',  	sortable: false, align: 'right',  width: 110, resizable: false,     unformat: unformatData,  formatter:cellFomatterbalanceAmount                                   },//formatter: cellFomatterGroupRec,
						//{name: 'Availability',           index: 'Availability',   	    jsonmap: 'Availability',  	    sortable: false, align: 'right',  width: 100, resizable: false,     unformat: unformatData, formatter:cellFomatterNumberAvailability     },//formatter: cellFomatterGroupRec,
						//{name: 'Total_Payable',          index: 'Total_Payable',     	jsonmap: 'Total_Payable',    	sortable: false, align: 'right',  width: 100, resizable: false,     unformat: unformatData                                   },//formatter: cellFomatterReceiptsColumn_6,
						{name: 'Settl_Amount',           index: 'Settl_Amount',     	jsonmap: 'Settl_Amount',    	sortable: false, align: 'right',  width: 120, resizable: false,     unformat: unformatData, formatter:cellFomatterGroupRec   },//formatter: cellFomatterNetRec,
						{name: 'Enhanced_Availability',  index: 'Enhanced_Availability',jsonmap: 'Enhanced_Availability',sortable: false, align: 'right' , width: 130, resizable: false,  unformat: unformatData,  formatter:cellFomatterEnhanced_Availability},
						//{name: 'Mode',                   index: 'Mode',             	jsonmap: 'Mode',  			    sortable: false, align: 'center', width: 80,  resizable: false,     unformat: unformatData, formatter:cellFomatterRecMode    },//formatter: cellFomatterReceiptsColumn_7, 
						//{name: 'Company_Bank_Account',   index: 'Company_Bank_Account', jsonmap: 'Company_Bank_Account',sortable: false, align: 'center', width: 130, resizable: false,     unformat: unformatData, formatter:cellFomatterRecCompanyAccNo },//formatter: cellFomatterReceiptsColumn_8,
						//{name: 'Comments',               index: 'Comments',            	jsonmap: 'Comments', 			sortable: false, align: 'center', width: 120, resizable: false,     unformat: unformatData, formatter:cellFomatterRecComment },//formatter: cellFomatterReceiptsColumn_9,
						//{name: 'Rec_Type',               index: 'Rec_Type',            	jsonmap: 'Rec_Type',  		    sortable: false, align: 'center', width: 120, resizable: false,     unformat: unformatData, formatter:cellFomatterRecEntMode, hidden:true },//formatter: cellFomatterReceiptsColumn_7, 
						//{name: 'Spot_Margin',            index: 'Spot_Margin',      	jsonmap: 'Spot_Margin',  		sortable: false, align: 'right',  width: 120, resizable: false,     unformat: unformatData, formatter:cellFomatterNumber     },//formatter: cellFomatterReceiptsColumn_7, 
						//{name: 'Market_Margin',          index: 'Market_Margin',       	jsonmap: 'Market_Margin',  		sortable: false, align: 'right',  width: 120, resizable: false,     unformat: unformatData, formatter:cellFomatterNumber     },//formatter: cellFomatterReceiptsColumn_7, 
						{name: 'This_Payment',             index: 'This_Payment',           	    jsonmap: 'This_Payment', 			    sortable: false, align: 'center', width: 80,  resizable: false,     unformat: unformatData, formatter:cellFormatterThisPayment }
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
                   caption: 'Broker Receipts - by Client - Detail',
				   jsonReader: {repeatitems: false},
				 //  onCellSelect: jq_grid_click_event_broker_pay,			
                   gridComplete: function() {
						                        
                    		 calculate_due_receipt('TABLE_CLIENT_RECEIPTS');				
						
					},
					loadComplete : function(){
                        var rec_count=$("#TABLE_CLIENT_RECEIPTS").jqGrid('getGridParam',"records");
                        document.Form1.hid_count_tbl_due_rec.value=rec_count;
					}
               });
           }
			
			function initDrillDownDialog(){
				$('#DIV_DRILL_DOWN_1').dialog({ 
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
				
				/*$('#DIV_DRILL_DOWN_3').dialog({
                   bgiframe: true,
                   autoOpen: false,
                   modal: false,
                   height: 500,
                   width: getW
               });*/
				
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
			
			function jq_grid_click_event_avail_summary(rowid, iCol, cellcontent) {
				
				
				var m_selected_row = jQuery('#TABLE_CLIENT_AVAILABILITY_INCREASE').jqGrid('getRowData', rowid);
				var m_broker_code  = m_selected_row.Beneficiary;
				var m_facility_no  = m_selected_row.Fasility_Number;
				var m_payment_no   = m_selected_row.Payment_No;
				var m_settl_mode   = m_selected_row.Settl_Mode;	
				if (iCol == 0) {
					
					if(rowid==2){
						loadGridCompanyValuation();
					}
					if(rowid==3){
					   loadgridconcentration_adj();
					}
					if(rowid==4){
					   loadGridReceiptsAppove();
					}
					
					
				}	
				
			}
			
			function jq_grid_load_complete_CompanyValuation(obj) {
				
				calculate_Adjusted_Company_Val(obj);
				
			}function jq_grid_load_complete_concentration_adj(obj) {
				
				calculate_concentration_adj(obj);//calculate_Adjusted_Company_Val();
				
			}
			
			function cellFomatterPayBeneficiary (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='m_broker_code_"+row_id+"' name='m_broker_code_"+row_id+"' value='"+cellvalue+"'  /></span>";
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
				var link ="<input type='checkbox' id='save_status_"+rowid+"'  name='save_status_"+rowid+"' value='Y'  onclick =guaran('"+rowid+"');check_amount('"+rowid+"');    onchange=guaran('"+rowid+"');check_amount('"+rowid+"')  />"; 
				return link;
			}
			function checkBoxFmatterPaySignature (cellvalue, options, rowObject){
				var rowid=options['rowId'];
				var link ="<input type='checkbox' id='signature_"+rowid+"'  name='signature_"+rowid+"' value='on'  onclick =validateSig('"+rowid+"');     />"; 
				return link;
			}
			function checkBoxFmatterPayReject (cellvalue, options, rowObject){
				var rowid=options['rowId'];
				var link ="<input type='checkbox' id='reject_"+rowid+"'  name='reject_"+rowid+"' value='on'  onclick =validateRej('"+rowid+"');    />"; 
				return link;
			}
			function checkBoxFmatterVoucher(cellvalue, options, rowObject){
				var rowid=options['rowId'];
				var link ="<input type='button' id='view_"+rowid+"'  name='view_"+rowid+"' value='View'  onclick =view_voucher('"+rowid+"');    />"; 
				return link;		
				
			}
			
			
			function cellFomatterPayMode(cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var texts = "<span><select name='Hid_Sett_type_"+row_id+"'  ><OPTION VALUE='CHEQUE' SELECTED>PAY ORDER</OPTION><OPTION VALUE='BANK_TRANF'>BANK_TRANF</OPTION></select></span>";
				return texts;
			}	
			
			function unformatData(cellvalue, options, cellobject) {
				return cellvalue;
			}
			
			function view_voucher(val){
				
				var m_selected_row = jQuery('#TABLE_CLIENT_AVAILABILITY_INCREASE').jqGrid('getRowData', val);
				var m_broker_code  = m_selected_row.Beneficiary;
				var m_facility_no  = m_selected_row.Fasility_Number;
				var m_payment_no   = m_selected_row.Payment_No;
				var m_settl_mode   = m_selected_row.Settl_Mode;
				var m_mode         = m_selected_row.Mode;
				
				if ($('#DIV_DRILL_DOWN_2').dialog('isOpen')) {
					$('#DIV_DRILL_DOWN_2').dialog('close');
				}
				$('#IFRAME_DRILL_DOWN_2').attr('src', '');
				$('#IFRAME_DRILL_DOWN_2').remove();
				$('#DIV_DRILL_DOWN_2').html(iframe_html_string_2);
				$('#DIV_DRILL_DOWN_2').dialog('option', 'title', 'Drill Down');
				$('#IFRAME_DRILL_DOWN_2').attr('src', "<%= m_jsp_client_url %>"+"/payment_voucher_view.jsp?chksql=availability_rpt&payment_no="+m_payment_no+"&facility_no="+m_facility_no+"&mode="+m_mode+"&settl_mode="+m_settl_mode+""); 
				$('#DIV_DRILL_DOWN_2').dialog('open');
				
			}
			
			function validateRej(val){
				var str_signature_object_name='signature_'+val;
				document.forms[0].elements[str_signature_object_name].checked = false;
			}
			function validateSig(val){
				var str_signature_object_name='reject_'+val;
				document.forms[0].elements[str_signature_object_name].checked = false;
			}	
			
			//**************************	
			
			function cellFomatterSecurity_Code(cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var m_subgrid_type = options['gid'];
				var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='TXT_SECURITY_CODE_"+m_subgrid_type+"_"+row_id+"' name='TXT_SECURITY_CODE_"+m_subgrid_type+"_"+row_id+"'  value='"+cellvalue+"'  /></span>";
				return texts;
			} 
			
			function cellFomatterRecommended_Per(cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var m_subgrid_type = options['gid'];
				
				if(m_subgrid_type=='TABLE_CLIENT_COMPANY_VALUATION'){
				var texts = "<span><input type='text' align='right' style ='text-align: right;'  id='TXT_RECOMMENDED_RER_"+m_subgrid_type+"_"+row_id+"' name='TXT_RECOMMENDED_RER_"+m_subgrid_type+"_"+row_id+"' value='"+cellvalue+"' onchange=calculate_Adjusted_Company_Val(\'"+m_subgrid_type+"\'); /></span>";
				}else if(m_subgrid_type=='TABLE_CLIENT_CONCENTRATION_ADJ'){
				var texts = "<span><input type='text' align='right' style ='text-align: right;'  id='TXT_RECOMMENDED_RER_"+m_subgrid_type+"_"+row_id+"' name='TXT_RECOMMENDED_RER_"+m_subgrid_type+"_"+row_id+"' value='"+cellvalue+"' onchange=calculate_concentration_adj(\'"+m_subgrid_type+"\'); /></span>";
				}
				
				
				return texts;
			}
			function cellFomatterAdjusted_Company_Val(cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var m_subgrid_type = options['gid'];
				if(cellvalue!=undefined){
					var texts = "<span id='span_adjusted_company_val_"+m_subgrid_type+"_"+row_id+"'>"+cellvalue+"</span><input type='hidden' align='left' style ='text-align: left;'  id='adjusted_company_val_"+m_subgrid_type+"_"+row_id+"' name='adjusted_company_val_"+row_id+"' value='"+cellvalue+"'/>";
					return texts;
				}else{
					var texts = "<span id='span_adjusted_company_val_"+m_subgrid_type+"_"+row_id+"'>0</span><input type='hidden' align='left' style ='text-align: left;'  id='adjusted_company_val_"+m_subgrid_type+"_"+row_id+"' name='adjusted_company_val_"+row_id+"' value='0'/>";
					return texts;
				}
			}
			
			function cellFomatterEnhanced_Availability(cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var m_subgrid_type = options['gid'];
				if(cellvalue!=undefined){
					var texts = "<span id='span_TXT_ENHANCED_AVAILABILITY_VAL_"+m_subgrid_type+"_"+row_id+"'>"+cellvalue+"</span><input type='hidden' align='left' style ='text-align: left;'  id='TXT_ENHANCED_AVAILABILITY_VAL_"+m_subgrid_type+"_"+row_id+"' name='TXT_ENHANCED_AVAILABILITY_VAL_"+m_subgrid_type+"_"+row_id+"' value='"+unformat_noobject(cellvalue)+"'/>";
					return texts;
				}else{
					var texts = "<span id='span_TXT_ENHANCED_AVAILABILITY_VAL_"+m_subgrid_type+"_"+row_id+"'>0</span><input type='hidden' align='left' style ='text-align: left;'  id='TXT_ENHANCED_AVAILABILITY_VAL_"+m_subgrid_type+"_"+row_id+"' name='TXT_ENHANCED_AVAILABILITY_VAL_"+m_subgrid_type+"_"+row_id+"' value='0'/>";
					return texts;
				}	
			}	
			
			function cellFormatterThisPayment(cellvalue, options, rowObject) {
				var rowid =options['rowId'];
				if(rowid!=''){
				var m_subgrid_type = options['gid'];
				if (cellvalue == 'N') {
					cellvalue = '<div align="center"><input type = "checkbox" id = "TXT_THIS_PAYMENT_' + m_subgrid_type + '_' + rowid + '" name = "TXT_THIS_PAYMENT_' + m_subgrid_type + '_' + rowid + '" onclick = "checkThisPayment(this, \'' + m_subgrid_type + '\', ' + rowid + ');" value = "Y" /></div>';
				}
				else if (cellvalue == 'Y') {
					cellvalue = '<div align="center"><input type = "checkbox" id = "TXT_THIS_PAYMENT_' + m_subgrid_type + '_' + rowid + '" name = "TXT_THIS_PAYMENT_' + m_subgrid_type + '_' + rowid + '" onclick = "checkThisPayment(this, \'' + m_subgrid_type + '\', ' + rowid + ');" value = "Y" checked = "checked" /></div>';
				}
				return cellvalue;
				}else{
				return '&nbsp;';
				}
			}
			function cellFormatterThisPeriod(cellvalue, options, rowObject) {
				var rowid  =options['rowId'];
				var m_subgrid_type = options['gid'];	
				if (cellvalue == 'N') {
					cellvalue = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' +
						'<input type = "checkbox" id = "TXT_THIS_PERIOD_' + m_subgrid_type + '_' + rowid + '" name = "TXT_THIS_PERIOD_' + m_subgrid_type + '_' + rowid + '" onclick = "checkThisPeriod(this, \'' + m_subgrid_type + '\', ' + rowid + ');" style = "vertical-align: text-top;" value = "Y" />' +
						'&nbsp;&nbsp;' + 
						'<input class = "txt_input5" type = "text" name = "TXT_THIS_PERIOD_DATE_DD_' + m_subgrid_type + '_' + rowid + '" id = "TXT_THIS_PERIOD_DATE_DD_' + m_subgrid_type + '_' + rowid + '" maxlength = "2" size = "2" value = "' + m_sysdate_dd + '" onblur = "checkMonthLength1(document.Form1.elements[\'TXT_THIS_PERIOD_DATE_DD_' + m_subgrid_type + '_' + rowid + '\'], document.Form1.elements[\'TXT_THIS_PERIOD_DATE_MM_' + m_subgrid_type + '_' + rowid + '\'], document.Form1.elements[\'TXT_THIS_PERIOD_DATE_YY_' + m_subgrid_type + '_' + rowid + '\'], document.Form1.elements[\'TXT_THIS_PERIOD_DATE_' + m_subgrid_type + '_' + rowid + '\'], \'D\', \'N\', m_sysdate, \'no past\');" disabled = "disabled" /> ' + 
						'<input class = "txt_input5" type = "text" name = "TXT_THIS_PERIOD_DATE_MM_' + m_subgrid_type + '_' + rowid + '" id = "TXT_THIS_PERIOD_DATE_MM_' + m_subgrid_type + '_' + rowid + '"maxlength = "2" size = "2" value = "' + m_sysdate_mm + '" onblur = "checkMonthLength1(document.Form1.elements[\'TXT_THIS_PERIOD_DATE_DD_' + m_subgrid_type + '_' + rowid + '\'], document.Form1.elements[\'TXT_THIS_PERIOD_DATE_MM_' + m_subgrid_type + '_' + rowid + '\'], document.Form1.elements[\'TXT_THIS_PERIOD_DATE_YY_' + m_subgrid_type + '_' + rowid + '\'], document.Form1.elements[\'TXT_THIS_PERIOD_DATE_' + m_subgrid_type + '_' + rowid + '\'], \'M\', \'N\', m_sysdate, \'no past\');" disabled = "disabled" /> ' + 
						'<input class = "txt_input5" type = "text" name = "TXT_THIS_PERIOD_DATE_YY_' + m_subgrid_type + '_' + rowid + '" id = "TXT_THIS_PERIOD_DATE_YY_' + m_subgrid_type + '_' + rowid + '"maxlength = "4" size = "4" value = "' + m_sysdate_yy + '" onblur = "checkMonthLength1(document.Form1.elements[\'TXT_THIS_PERIOD_DATE_DD_' + m_subgrid_type + '_' + rowid + '\'], document.Form1.elements[\'TXT_THIS_PERIOD_DATE_MM_' + m_subgrid_type + '_' + rowid + '\'], document.Form1.elements[\'TXT_THIS_PERIOD_DATE_YY_' + m_subgrid_type + '_' + rowid + '\'], document.Form1.elements[\'TXT_THIS_PERIOD_DATE_' + m_subgrid_type + '_' + rowid + '\'], \'Y\', \'N\', m_sysdate, \'no past\');" disabled = "disabled" /> ' + 
						'<input type = "hidden" name = "TXT_THIS_PERIOD_DATE_' + m_subgrid_type + '_' + rowid + '" id = "TXT_THIS_PERIOD_DATE_' + m_subgrid_type + '_' + rowid + '" value = "' + m_sysdate + '" /> '
				}
				else {
					cellvalue = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;' +
						'<input type = "checkbox" id = "TXT_THIS_PERIOD_' + m_subgrid_type + '_' + rowid + '" name = "TXT_THIS_PERIOD_' + m_subgrid_type + '_' + rowid + '" onclick = "checkThisPeriod(this, \'' + m_subgrid_type + '\', ' + rowid + ');" style = "vertical-align: text-top;" value = "Y" checked = "checked" />' +
						'&nbsp;&nbsp;' + 
						'<input class = "txt_input5" type = "text" name = "TXT_THIS_PERIOD_DATE_DD_' + m_subgrid_type + '_' + rowid + '" id = "TXT_THIS_PERIOD_DATE_DD_' + m_subgrid_type + '_' + rowid + '" maxlength = "2" size = "2" value = "' + cellvalue.substring(0, 2) + '" onblur = "checkMonthLength1(document.Form1.elements[\'TXT_THIS_PERIOD_DATE_DD_' + m_subgrid_type + '_' + rowid + '\'], document.Form1.elements[\'TXT_THIS_PERIOD_DATE_MM_' + m_subgrid_type + '_' + rowid + '\'], document.Form1.elements[\'TXT_THIS_PERIOD_DATE_YY_' + m_subgrid_type + '_' + rowid + '\'], document.Form1.elements[\'TXT_THIS_PERIOD_DATE_' + m_subgrid_type + '_' + rowid + '\'], \'D\', \'N\', m_sysdate, \'no past\');" /> ' + 
					'<input class = "txt_input5" type = "text" name = "TXT_THIS_PERIOD_DATE_MM_' + m_subgrid_type + '_' + rowid + '" id = "TXT_THIS_PERIOD_DATE_MM_' + m_subgrid_type + '_' + rowid + '"maxlength = "2" size = "2" value = "' + cellvalue.substring(3, 5) + '" onblur = "checkMonthLength1(document.Form1.elements[\'TXT_THIS_PERIOD_DATE_DD_' + m_subgrid_type + '_' + rowid + '\'], document.Form1.elements[\'TXT_THIS_PERIOD_DATE_MM_' + m_subgrid_type + '_' + rowid + '\'], document.Form1.elements[\'TXT_THIS_PERIOD_DATE_YY_' + m_subgrid_type + '_' + rowid + '\'], document.Form1.elements[\'TXT_THIS_PERIOD_DATE_' + m_subgrid_type + '_' + rowid + '\'], \'M\', \'N\', m_sysdate, \'no past\');" /> ' + 
					'<input class = "txt_input5" type = "text" name = "TXT_THIS_PERIOD_DATE_YY_' + m_subgrid_type + '_' + rowid + '" id = "TXT_THIS_PERIOD_DATE_YY_' + m_subgrid_type + '_' + rowid + '"maxlength = "4" size = "4" value = "' + cellvalue.substring(6, 10) + '" onblur = "checkMonthLength1(document.Form1.elements[\'TXT_THIS_PERIOD_DATE_DD_' + m_subgrid_type + '_' + rowid + '\'], document.Form1.elements[\'TXT_THIS_PERIOD_DATE_MM_' + m_subgrid_type + '_' + rowid + '\'], document.Form1.elements[\'TXT_THIS_PERIOD_DATE_YY_' + m_subgrid_type + '_' + rowid + '\'], document.Form1.elements[\'TXT_THIS_PERIOD_DATE_' + m_subgrid_type + '_' + rowid + '\'], \'Y\', \'N\', m_sysdate, \'no past\');" /> ' + 
					'<input type = "hidden" name = "TXT_THIS_PERIOD_DATE_' + m_subgrid_type + '_' + rowid + '" id = "TXT_THIS_PERIOD_DATE_' + m_subgrid_type + '_' + rowid + '" value = "' + cellvalue + '" /> '
				}
				return cellvalue;
			}
			function cellFormatterPermanent(cellvalue, options, rowObject) {
				var rowid  = options['rowId'];
				var m_subgrid_type = options['gid'];	
				if (cellvalue == 'N') {
					cellvalue = '<div align="center"><input type = "checkbox" id = "TXT_PERMANENT_' + m_subgrid_type + '_' + rowid + '" name = "TXT_PERMANENT_' + m_subgrid_type + '_' + rowid + '" onclick = "checkPermanent(this, \'' + m_subgrid_type + '\', ' + rowid + ');" value = "Y" /></div>';
				}
				else if (cellvalue == 'Y') {
					cellvalue = '<div align="center"><input type = "checkbox" id = "TXT_PERMANENT_' + m_subgrid_type + '_' + rowid + '" name = "TXT_PERMANENT_' + m_subgrid_type + '_' + rowid + '" onclick = "checkPermanent(this, \'' + m_subgrid_type + '\', ' + rowid + ');" value = "Y" checked = "checked" /></div>';
				}
				return cellvalue;
			}
			function cellFormatterComment(cellvalue, options, rowObject) {
				var rowid = options['rowId'];
				var m_subgrid_type = options['gid'];	
				if (cellvalue == undefined) {
					cellvalue = '<input class = "txt_input" type = "text" id = "TXT_COMMENT_' + m_subgrid_type + '_' + rowid + '" name = "TXT_COMMENT_' + m_subgrid_type + '_' + rowid + '" style = "width: 240px;" onblur = "strTrim(this);" value = "" />';
				}
				else {
					cellvalue = '<input class = "txt_input" type = "text" id = "TXT_COMMENT_' + m_subgrid_type + '_' + rowid + '" name = "TXT_COMMENT_' + m_subgrid_type + '_' + rowid + '" style = "width: 240px;" onblur = "strTrim(this);" value = "' + cellvalue + '" />';
				}
				return cellvalue;
			}	
			
			
			function checkThisPayment(m_object, m_subgrid_type, m_rowid) {
				
				$('#TXT_THIS_PERIOD_' + m_subgrid_type + '_' + m_rowid).attr('checked', false);
				$('#TXT_PERMANENT_' + m_subgrid_type + '_' + m_rowid).attr('checked', false);
				$('#TXT_THIS_PERIOD_DATE_' + m_subgrid_type + '_' + m_rowid).val(m_sysdate);
				$('#TXT_THIS_PERIOD_DATE_DD_' + m_subgrid_type + '_' + m_rowid).val(m_sysdate_dd);
				$('#TXT_THIS_PERIOD_DATE_MM_' + m_subgrid_type + '_' + m_rowid).val(m_sysdate_mm);
				$('#TXT_THIS_PERIOD_DATE_YY_' + m_subgrid_type + '_' + m_rowid).val(m_sysdate_yy);
				$('#TXT_THIS_PERIOD_DATE_DD_' + m_subgrid_type + '_' + m_rowid).attr('disabled', true);
				$('#TXT_THIS_PERIOD_DATE_MM_' + m_subgrid_type + '_' + m_rowid).attr('disabled', true);
				$('#TXT_THIS_PERIOD_DATE_YY_' + m_subgrid_type + '_' + m_rowid).attr('disabled', true);
				removeCal('TXT_THIS_PERIOD_DATE_' + m_subgrid_type + '_' + m_rowid)
				$('#TXT_RECOMMENDED_AMOUNT_' + m_subgrid_type + '_' + m_rowid).attr('disabled', false);	
				
				calculate_Adjusted_Company_Val('TABLE_CLIENT_COMPANY_VALUATION');
				calculate_concentration_adj('TABLE_CLIENT_CONCENTRATION_ADJ');
				calculate_due_receipt('TABLE_CLIENT_RECEIPTS');
				
			}
			function checkThisPeriod(m_object, m_subgrid_type, m_rowid) {
				
				$('#TXT_THIS_PAYMENT_' + m_subgrid_type + '_' + m_rowid).attr('checked', false);
				$('#TXT_PERMANENT_' + m_subgrid_type + '_' + m_rowid).attr('checked', false);
				$('#TXT_THIS_PERIOD_DATE_' + m_subgrid_type + '_' + m_rowid).val(m_sysdate);
				$('#TXT_THIS_PERIOD_DATE_DD_' + m_subgrid_type + '_' + m_rowid).val(m_sysdate_dd);
				$('#TXT_THIS_PERIOD_DATE_MM_' + m_subgrid_type + '_' + m_rowid).val(m_sysdate_mm);
				$('#TXT_THIS_PERIOD_DATE_YY_' + m_subgrid_type + '_' + m_rowid).val(m_sysdate_yy);
				$('#TXT_THIS_PERIOD_DATE_DD_' + m_subgrid_type + '_' + m_rowid).attr('disabled', true);
				$('#TXT_THIS_PERIOD_DATE_MM_' + m_subgrid_type + '_' + m_rowid).attr('disabled', true);
				$('#TXT_THIS_PERIOD_DATE_YY_' + m_subgrid_type + '_' + m_rowid).attr('disabled', true);
				initCal('TXT_THIS_PERIOD_DATE_' + m_subgrid_type + '_' + m_rowid);
				$('#TXT_RECOMMENDED_AMOUNT_' + m_subgrid_type + '_' + m_rowid).attr('disabled', false); 
				
				calculate_Adjusted_Company_Val('TABLE_CLIENT_COMPANY_VALUATION');
				calculate_concentration_adj('TABLE_CLIENT_CONCENTRATION_ADJ');
				calculate_due_receipt('TABLE_CLIENT_RECEIPTS');
			}
			function checkPermanent(m_object, m_subgrid_type, m_rowid) {
				
				$('#TXT_THIS_PERIOD_' + m_subgrid_type + '_' + m_rowid).attr('checked', false);
				$('#TXT_THIS_PAYMENT_' + m_subgrid_type + '_' + m_rowid).attr('checked', false);
				$('#TXT_THIS_PERIOD_DATE_' + m_subgrid_type + '_' + m_rowid).val(m_sysdate);
				$('#TXT_THIS_PERIOD_DATE_DD_' + m_subgrid_type + '_' + m_rowid).val(m_sysdate_dd);
				$('#TXT_THIS_PERIOD_DATE_MM_' + m_subgrid_type + '_' + m_rowid).val(m_sysdate_mm);
				$('#TXT_THIS_PERIOD_DATE_YY_' + m_subgrid_type + '_' + m_rowid).val(m_sysdate_yy);
				$('#TXT_THIS_PERIOD_DATE_DD_' + m_subgrid_type + '_' + m_rowid).attr('disabled', true);
				$('#TXT_THIS_PERIOD_DATE_MM_' + m_subgrid_type + '_' + m_rowid).attr('disabled', true);
				$('#TXT_THIS_PERIOD_DATE_YY_' + m_subgrid_type + '_' + m_rowid).attr('disabled', true);
				removeCal('TXT_THIS_PERIOD_DATE_' + m_subgrid_type + '_' + m_rowid)
				$('#TXT_RECOMMENDED_AMOUNT_' + m_subgrid_type + '_' + m_rowid).attr('disabled', false);
				
				calculate_Adjusted_Company_Val('TABLE_CLIENT_COMPANY_VALUATION');
				calculate_concentration_adj('TABLE_CLIENT_CONCENTRATION_ADJ');
				calculate_due_receipt('TABLE_CLIENT_RECEIPTS');
			}
			
			function calculate_Adjusted_Company_Val(m_subgrid_type){
				var m_tot_avail_company_value  = 0;
				var m_detail_grid_no_of_rows   = $('#TABLE_CLIENT_COMPANY_VALUATION').jqGrid('getGridParam',"records");
				
				for(j = 1 ; j < m_detail_grid_no_of_rows; j ++){
					
					var row_id=j;//options['rowId'];
					//alert(document.getElementById('TXT_THIS_PAYMENT_' + m_subgrid_type + '_' + row_id).checked);
					
					var obj_adjusted_company_val="adjusted_company_val_"+m_subgrid_type+"_"+j;
					var span_adjusted_company_val="span_adjusted_company_val_"+m_subgrid_type+"_"+j;
					
					var obj_enhanced_availability_val="TXT_ENHANCED_AVAILABILITY_VAL_"+m_subgrid_type+"_"+j;
					var span_enhanced_availability_val="span_TXT_ENHANCED_AVAILABILITY_VAL_"+m_subgrid_type+"_"+j;
					
					var m_selected_row    = jQuery('#TABLE_CLIENT_COMPANY_VALUATION').jqGrid('getRowData', row_id);
				    var m_market_price    = unformat_noobject(m_selected_row.Market_Price);
					var m_no_of_shares    = unformat_noobject(m_selected_row.No_of_shares);
					var m_recommended_per = document.getElementById("TXT_RECOMMENDED_RER_"+m_subgrid_type+"_"+j).value;
					
					
					if(	document.getElementById('TXT_THIS_PAYMENT_' + m_subgrid_type + '_' + row_id).checked == true || document.getElementById('TXT_THIS_PERIOD_' + m_subgrid_type + '_' + row_id).checked == true   || document.getElementById('TXT_PERMANENT_' + m_subgrid_type + '_' + row_id).checked == true){
											
					
					var m_adjusted_company_val =m_market_price*m_no_of_shares*m_recommended_per/100;//	*m_recommended_per
					var m_company_valuation = unformat_noobject(m_selected_row.Company_Valuation)
											
					document.getElementById(obj_adjusted_company_val).value  = m_adjusted_company_val;
					document.getElementById(span_adjusted_company_val).innerHTML = format_noobject(m_adjusted_company_val);
					document.getElementById(obj_enhanced_availability_val).value  = m_adjusted_company_val-m_company_valuation;
					document.getElementById(span_enhanced_availability_val).innerHTML = format_noobject(m_adjusted_company_val-m_company_valuation);
					m_tot_avail_company_value +=m_adjusted_company_val-m_company_valuation;
					
					var  col_company_valuation = 4;
	

					
					jQuery("#TABLE_CLIENT_CONCENTRATION_ADJ").jqGrid('setCell',j, col_company_valuation, format_noobject(m_adjusted_company_val));	
					 }else{
							 var m_allowable_per = m_selected_row.Allowable_Per; 
							 var m_adjusted_company_val =m_market_price*m_no_of_shares*m_allowable_per/100;//	*m_recommended_per
					         var m_company_valuation = unformat_noobject(m_selected_row.Company_Valuation)
				             document.getElementById(obj_adjusted_company_val).value  = m_adjusted_company_val;
					         document.getElementById(span_adjusted_company_val).innerHTML = format_noobject(m_adjusted_company_val);
							 document.getElementById(obj_enhanced_availability_val).value  = 0;
					         document.getElementById(span_enhanced_availability_val).innerHTML = 0;
						jQuery("#TABLE_CLIENT_CONCENTRATION_ADJ").jqGrid('setCell',j, col_company_valuation, format_noobject(m_adjusted_company_val));	
			       	 }
				}
				
				
				jQuery("#TABLE_CLIENT_AVAILABILITY_INCREASE").jqGrid('setCell', 2, 2, format_noobject(m_tot_avail_company_value));
				
				
				calculate_concentration_adj('TABLE_CLIENT_CONCENTRATION_ADJ');
			}	
			
			function calculate_concentration_adj(m_subgrid_type){
			var tot_concenrration_adj = 0;
				
			var m_detail_grid_no_of_rows   = $('#TABLE_CLIENT_CONCENTRATION_ADJ').jqGrid('getGridParam',"records");
			
				for(j = 1 ; j < m_detail_grid_no_of_rows; j ++){
			    var row_id=j;
				
				var m_selected_row     = jQuery('#TABLE_CLIENT_CONCENTRATION_ADJ').jqGrid('getRowData', row_id);	
				var m_company_valuation     = unformat_noobject(m_selected_row.Company_Valuation);
				var m_concentration         = unformat_noobject(m_selected_row.Concentration);	
				var m_recommended_per       = unformat_noobject(document.getElementById("TXT_RECOMMENDED_RER_"+m_subgrid_type+"_"+j).value);//unformat_noobject(m_selected_row.Recommended_Per);		
				var m_col_valuation	              = 6;
				var m_col_adj_company_valuation	  = 8;
				var m_col_enhanced_availability	  = 9;		
				jQuery("#TABLE_CLIENT_CONCENTRATION_ADJ").jqGrid('setCell',j, m_col_valuation, format_noobject(m_company_valuation*m_concentration/100));
				jQuery("#TABLE_CLIENT_CONCENTRATION_ADJ").jqGrid('setCell',j, m_col_adj_company_valuation, format_noobject(m_company_valuation*m_recommended_per/100));	
				if(	document.getElementById('TXT_THIS_PAYMENT_' + m_subgrid_type + '_' + row_id).checked == true || document.getElementById('TXT_THIS_PERIOD_' + m_subgrid_type + '_' + row_id).checked == true   || document.getElementById('TXT_PERMANENT_' + m_subgrid_type + '_' + row_id).checked == true){
					jQuery("#TABLE_CLIENT_CONCENTRATION_ADJ").jqGrid('setCell',j, m_col_enhanced_availability, format_noobject(m_company_valuation*m_recommended_per/100-m_company_valuation*m_concentration/100));
					tot_concenrration_adj += m_company_valuation*m_recommended_per/100-m_company_valuation*m_concentration/100;
				
				}else{
				  
					jQuery("#TABLE_CLIENT_CONCENTRATION_ADJ").jqGrid('setCell',j, m_col_valuation, format_noobject(m_company_valuation*m_concentration/100));
				    jQuery("#TABLE_CLIENT_CONCENTRATION_ADJ").jqGrid('setCell',j, m_col_adj_company_valuation, format_noobject(m_company_valuation*m_concentration/100));
				    jQuery("#TABLE_CLIENT_CONCENTRATION_ADJ").jqGrid('setCell',j, m_col_enhanced_availability, format_noobject("0"));
					tot_concenrration_adj += 0;
				}
			}	
				
				
				
			jQuery("#TABLE_CLIENT_AVAILABILITY_INCREASE").jqGrid('setCell',3, 2, format_noobject(tot_concenrration_adj));
			cal_footer_val_avail_rpt_summarry();		
			}
			
			function calculate_due_receipt(m_subgrid_type){
				var tot_m_enhanced_availability = 0; 
			    var m_detail_grid_no_of_rows    = $('#TABLE_CLIENT_RECEIPTS').jqGrid('getGridParam',"records");
			
				for(j = 1 ; j < m_detail_grid_no_of_rows; j ++){
				 var row_id=j;
				 var m_selected_row      = jQuery('#TABLE_CLIENT_RECEIPTS').jqGrid('getRowData', row_id);
				 var m_expected_amount   = unformat_noobject(m_selected_row.Settl_Amount);
				 var m_settlement_amount = document.getElementById("TXT_GROUP_AMOUNT_"+m_subgrid_type+"_"+j).value ;
				
				 var m_col_enhanced_availability  = 6;
				 var m_enhanced_availability	  = m_settlement_amount - m_expected_amount;	
					if(	document.getElementById('TXT_THIS_PAYMENT_' + m_subgrid_type + '_' + row_id).checked == true){ 
					tot_m_enhanced_availability += m_enhanced_availability;	
				     jQuery("#TABLE_CLIENT_RECEIPTS").jqGrid('setCell',j, m_col_enhanced_availability, format_noobject(m_enhanced_availability));
					 }else{
				  
				  jQuery("#TABLE_CLIENT_RECEIPTS").jqGrid('setCell',j, m_col_enhanced_availability, 0);
				  }	
				}
				
			    jQuery("#TABLE_CLIENT_AVAILABILITY_INCREASE").jqGrid('setCell',4, 2, format_noobject(tot_m_enhanced_availability));
			    cal_footer_val_avail_rpt_summarry();
			}
			
			function cal_footer_val_avail_rpt_summarry(){
			var m_tot_system = 0;
			var m_tot_recommended = 0;
				
			var m_detail_grid_no_of_rows    = $('#TABLE_CLIENT_AVAILABILITY_INCREASE').jqGrid('getGridParam',"records");	
			for(j = 1 ; j < m_detail_grid_no_of_rows; j ++){
			 var row_id=j;
			 var m_selected_row      = jQuery('#TABLE_CLIENT_AVAILABILITY_INCREASE').jqGrid('getRowData', row_id);
				 m_tot_system        += parseFloat(unformat_noobject(m_selected_row.System));
			     m_tot_recommended   = parseFloat(m_tot_recommended) + parseFloat(unformat_noobject(m_selected_row.Recommended) );	
				
			}
				
		var data = new Array();
       data['Summery']     = 'Adjusted Availability';
       data['System']      = format_noobject(m_tot_system);
       data['Recommended'] = format_noobject(m_tot_recommended);
       
      jQuery("#TABLE_CLIENT_AVAILABILITY_INCREASE").jqGrid('footerData','set',data,false); 
			
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
			function removeCal(m_id) {
				$('#' + m_id).datepicker('destroy');
			}	
			
			function dateSelectFunc(dateText, inst) {
				var splitResult                 = dateText.split('-');
				var instance_id                 = inst.id;
				var instance_id_label           = instance_id.substring(0, 20);
				var instance_id_subgrid_type    = instance_id.substring(21, instance_id.lastIndexOf('_'));
				var instance_id_rowid           = instance_id.substring(instance_id.lastIndexOf('_') + 1);
				var hidden_id                   = instance_id_label + '_' + instance_id_subgrid_type + '_' + instance_id_rowid;
				var textbox_day_id              = instance_id_label + '_DD_' + instance_id_subgrid_type + '_' + instance_id_rowid;
				var textbox_month_id            = instance_id_label + '_MM_' + instance_id_subgrid_type + '_' + instance_id_rowid;
				var textbox_year_id             = instance_id_label + '_YY_' + instance_id_subgrid_type + '_' + instance_id_rowid;
				var sysdate_object = new Date(m_sysdate_yy, m_sysdate_mm - 1, m_sysdate_dd);
				var new_date_object = new Date(splitResult[2], splitResult[1] - 1, splitResult[0]);
				if (instance_id_label == 'TXT_THIS_PERIOD_DATE') {
					if (new_date_object < sysdate_object) {
						alert('Date cannot be in the past.');
						$('#' + hidden_id).val(m_sysdate);
						$('#' + textbox_day_id).val(m_sysdate_dd);
						$('#' + textbox_month_id).val(m_sysdate_mm);
						$('#' + textbox_year_id).val(m_sysdate_yy);
						$('#' + textbox_day_id).select();
					}
					else {
						$('#' + textbox_day_id).val(splitResult[0]);
						$('#' + textbox_month_id).val(splitResult[1]);
						$('#' + textbox_year_id).val(splitResult[2]);
					}
				}
			}	
						
	   function cellFomatterDueDate (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
			          var m_subgrid_type = options['gid'];
                      var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='TXT_DUE_DATE_"+m_subgrid_type+"_"+row_id+"' name='TXT_DUE_DATE_"+m_subgrid_type+"_"+row_id+"' value='"+unformat_noobject(cellvalue)+"'  /></span>";
                         //texts = texts + "<span><input type='hidden' align='right' style ='text-align: right;'  id='hid_to_date_"+row_id+"' name='hid_to_date_"+row_id+"' value='"+unformat_noobject(cellvalue)+"'  /></span>";
			         return texts;
                 }	
		function	cellFomatterbalanceAmount (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
			         var m_subgrid_type = options['gid'];
                    if(row_id!=''){
			         var texts = "<span><input type='text' align='right' style ='text-align: right;'  id='TXT_BALANCE_AMOUNT_"+m_subgrid_type+"_"+row_id+"' name='TXT_BALANCE_AMOUNT_"+m_subgrid_type+"_"+row_id+"' value='"+unformat_noobject(cellvalue)+"'  /></span>";
                     return texts;
					}else{
					return '&nbsp;';
					}	
			}
		function cellFomatterGroupRec (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
			         var m_subgrid_type = options['gid'];
                    if(row_id!=''){
			         var texts = "<span><input type='text' align='right' style ='text-align: right;'  id='TXT_GROUP_AMOUNT_"+m_subgrid_type+"_"+row_id+"' name='TXT_GROUP_AMOUNT_"+m_subgrid_type+"_"+row_id+"' value='"+unformat_noobject(cellvalue)+"' onchange=calculate_due_receipt(\'"+m_subgrid_type+"\');  /></span>";
                     return texts;
					}else{
					return '&nbsp;';
					}	
			}
			
			
			//******************************	
			function fnCancel(){
				document.getElementById("DIV_CLIENT_AVAILABILITY").innerHTML ="<table id = 'TABLE_CLIENT_AVAILABILITY_INCREASE'></table><div id = 'DIV_PAGER_TABLE_CLIENT_AVAILABILITY_INCREASE'></div>";
				document.getElementById("txt_client_code").value="";
				document.getElementById("TXT_CLIENT_MANAGER").value="";
				document.getElementById("txt_facility_number").value="";
				document.getElementById("txt_broker_code").value="";
				
				document.getElementById("txt_facility_number_name").value="";
				document.getElementById("TXT_CLIENT_MANAGER_NAME").value="";
				document.getElementById("txt_facility_number").value="";
				document.getElementById("txt_broker_full_name").value=""; 
				loadGridAvailabilityReport();
			}
			
			function fnSave(){
				document.Form1.Hid_scr_name.value="save_increase_availability";
				document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"save_increase_availability";
				 for (var i = 0; i < document.Form1.elements.length; i++) {
                           document.Form1.elements[i].disabled = false;
                       }
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
				myObject[1]=null;
				myObject[2]=null;
				myObject[3]=aForm.txt_client_code;
				myObject[4]=aForm.txt_client_full_name;
				
				
				var myObject_value=new Array(); //passing values set to this object
				myObject_value[0]=aForm.txt_facility_number.value;
				myObject_value[1]=aForm.txt_facility_number.value;//aForm.oLastName2.value;
				myObject_value[2]=null;
				myObject_value[3]=null;
				myObject_value[4]=null;
				myObject_value[5]=null;
				
				var myObject_type=new Array(); //passing values data type
				myObject_type[0]="StringL";
				myObject_type[1]="StringL";
				myObject_type[2]=null;
				myObject_type[3]=null;
				myObject_type[4]=null;
				myObject_type[5]=null;
				
				var qid='123';
				var hid='2';
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
						url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&hid='+hid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
						dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
						height:400,// 500,
						width: 600,//900,
						title: 'SasiNet Frame Work',
						scrollable: true,
						onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  if(returnedValue!=null){loadGridAvailabilityReport();}} //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
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
		</script>
		
	</head>
	
	<body class="body & txt-body">
		<form name="Form1" id="Form1" >
			<input type = "hidden" id = "Hid_scr_name" name = "Hid_scr_name" Value="save_increase_availability" />
			<input type = "hidden" id = "hid_count" name = "hid_count" />
			<input type = "hidden" id = "hid_count_tbl_com_val" name = "hid_count_tbl_com_val" value="0"/>
			<input type = "hidden" id = "hid_count_tbl_con_adj" name = "hid_count_tbl_con_adj" value="0"/>
			<input type = "hidden" id = "hid_count_tbl_due_rec" name = "hid_count_tbl_due_rec" value="0"/>
			<div>		
				<table class="table" border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td colspan="2">
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
						</td>
					</tr>
					
					<tr>
						<td >
							<div stype='width:800px'>
								<table width="100%" bgcolor="darkblue">
									<tr>
										
										<td width="4%">
											<input class="mainbut" type="button" name="save_but" value="Save" onclick="fnSave();" />
										</td>
										<td width="4%">
											<input class="mainbut" type="button" name="calcel_but" value="Cancel" onclick="fnCancel()" />
										</td>
										<td width="4%">
											<input class="mainbut" type="button" name="Exit_but" value="Exit" onclick="top.frames[1].location.href='low.jsp'" />
										</td>
										<TD WIDTH="*%"> &nbsp; </TD>
										
										<td width="50%" class="hh1" align="right"><b>Increase Availability</b></td>
										<td width="4%">
											<input class="mainbut" type="button" name="save_but" value="Save" onclick="fnSave();" />
										</td>
										<td width="4%">
											<input class="mainbut" type="button" name="calcel_but" value="Cancel" onclick="fnCancel()" />
										</td>
										<td width="4%">
											<input class="mainbut" type="button" name="Exit_but" value="Exit" onclick="top.frames[1].location.href='low.jsp'" />
										</td>
										
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
								
								<!--	
								<tr>
								<td style = "width: 200px;"><div id = "DIV_TXT_CLIENT_MANAGER">Client Manager Code</div></td>
								<td><input class = "txt_input" type = "text" id = "TXT_CLIENT_MANAGER" name = "TXT_CLIENT_MANAGER" maxlength = "15" style = "width: 125px;" />
								</td>
								<td style = "width: 60px;">
								<input class = "but_input" type = "button" id = "BUT_HELP_CLIENT_MANAGER_MAIN" name = "BUT_HELP_CLIENT_MANAGER_MAIN" value = "..." onclick="client_manager_code_help(0);" />
								<td style = "width: 120px;">
								<input class = "but_input" type = "button" id = "BUT_VIEW_ALL" name = "BUT_VIEW_ALL" value = "View All" style = "width: 80px;" onclick="fn_veiwall()"/>
								</td>
								<td style = "width: 200px;"><div id = "DIV_TXT_CLIENT_MANAGER_NAME">Client Manager Name</div></td>
								<td>
								<input class = "txt_input" type = "text" id = "TXT_CLIENT_MANAGER_NAME" name = "TXT_CLIENT_MANAGER_NAME" style = "width: 250px;" disabled = "disabled" />
								</td>
								</tr>
								-->
								
								
								
								<tr>
									<td style = "width: 200px;"><div id = "div_txt_facility_number">Facility Number</div></td>
									<td><input class = "txt_input" type = "text" id = "txt_facility_number" name = "txt_facility_number" maxlength = "15" style = "width: 125px;" onchange="facility_number_help(0);"/>
									</td>
									<td style = "width: 60px;">
										<input class = "but_input" type = "button" id = "BUT_HELP_FACILITY_NUMBER" name = "BUT_HELP_FACILITY_NUMBER" value = "..." onclick="facility_number_help(0);" onchange="facility_number_help(0);"   />
										<a id = "help_update_client_manager" style = "text-decoration: none; cursor: text;" class = "fancylink iframe" href = ""> </a>
										<td style = "width: 120px;">
											
										</td>
										<td style = "width: 200px;"><div id = "txt_facility_number_name">Facility Number</div></td>
										<td>
											<input class = "txt_input" type = "text" id = "txt_facility_number_name" name = "txt_facility_number_name" style = "width: 250px;" disabled = "disabled" />
										</td>
									</tr>
									<tr>
										<td style = "width: 200px;"><div id = "div_txt_client_code">Client Code</div></td>
										<td><input class = "txt_input" type = "text" id = "txt_client_code" name = "txt_client_code" maxlength = "250" style = "width: 125px;" /></td>
										<td style = "width: 60px;"><!--<input class = "but_input" type = "button" id = "but_help_client_code_main" name = "but_help_client_code_main" value = "..."  onclick="client_code_help(0)"/>-->
										</td>
										<td style = "width: 120px;"></td>
										<td style = "width: 200px;"><div id = "div_txt_client_full_name">Client Full Name</div></td>
										<td><input class = "txt_input" type = "text" id = "txt_client_full_name" name = "txt_client_full_name" style = "width: 250px;" disabled = "disabled" /></td>
									</tr>
									<!--  <tr>
									<td style = "width: 200px;"><div id = "div_txt_broker_code">Broker Code</div></td>
									<td><input class = "txt_input" type = "text" id = "txt_broker_code" name = "txt_broker_code" maxlength = "15" style = "width: 125px;" />
									</td>
									<td style = "width: 60px;">
									<input class = "but_input" type = "button" id = "BUT_HELP_CLIENT_MANAGER_MAIN" name = "BUT_HELP_CLIENT_MANAGER_MAIN" value = "..." onclick="broker_code_help(0);" />
									
									<td style = "width: 120px;">
									<input class = "but_input" type = "button" id = "BUT_SEARCH" name = "BUT_SEARCH" value = "Search" style = "width: 80px;" onclick="loadGridAvailabilityReport();"/>
									</td>
									<td style = "width: 200px;"><div id = "txt_broker_full_name">Broker Full Name</div></td>
									<td>
									<input class = "txt_input" type = "text" id = "txt_broker_full_name" name = "txt_broker_full_name" style = "width: 250px;" disabled = "disabled" />
									</td>
									</tr> -->                              
									
								</table>	
								
								
								
								
								<BR>	
								
								<div id = "DIV_CLIENT_AVAILABILITY">
									<table id = "TABLE_CLIENT_AVAILABILITY_INCREASE"></table>
									<div id = "DIV_PAGER_TABLE_CLIENT_AVAILABILITY_INCREASE"></div>
									
								</div>
								
								<BR>
								
								
								
								<div id = "DIV_CLIENT_COMPANY_VALUATION">
									<table id = "TABLE_CLIENT_COMPANY_VALUATION"></table>
									<div id = "DIV_PAGER_TABLE_COMPANY_VALUATION"></div>
									
								</div>
								<BR>
								<div id = "DIV_CLIENT_CONCENTRATION_ADJ">
									<table id = "TABLE_CLIENT_CONCENTRATION_ADJ"></table>
									<div id = "DIV_PAGER_TABLE_CONCENTRATION_ADJ"></div>
									
								</div>	
							  		<BR>	
				
	                             <div id = "DIV_CLIENT_RECEIPTS">
                                     <table id = "TABLE_CLIENT_RECEIPTS"></table>
                                     <div id = "DIV_PAGER_TABLE_CLIENT_RECEIPTS"></div>
                                 </div>	
								
								<div id = "DIV_DRILL_DOWN_1" title = "">
									<iframe id = "IFRAME_DRILL_DOWN_1" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Invoice Drill Down">
									</iframe>
								</div>					
								<div id = "DIV_DRILL_DOWN_2" title = "">
									<iframe id = "IFRAME_DRILL_DOWN_2" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Invoice Drill Down">
									</iframe>
								</div>										
								
								
								
							</form>		
							
						</body>		
					</html>
					
