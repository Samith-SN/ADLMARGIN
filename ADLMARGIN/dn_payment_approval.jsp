        <%@page import="java.text.SimpleDateFormat" %>
        <%@page import="java.util.Calendar" %>
        <%@page import="java.util.Date" %>
        <%@page import="net.sasianet.ADLMARGIN.*" %>
<%
            ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session); //kanishka
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
			 $(document).ready(function() {
               //init_fancybox();
               //initDrillDownDialog()
               m_grid_height = ($(window).height() - 310);
               //bind_events();
           });
			
		$(document).ready(function() {
		    initDrillDownDialog();
			//loadGridPaymentsAppove();
			loadGridPaymentsSummary();
			 });
			function fn_veiwall(){
			fnCancel();
			//loadGridPaymentsAppove();
			loadGridPaymentsSummary();	
		}	
		
				
		 function loadGridPaymentsSummary() {
				
		   var m_client_code= document.getElementById("txt_client_code").value;
		   var m_client_manager= document.getElementById("TXT_CLIENT_MANAGER").value;
		   var m_port= document.getElementById("txt_facility_number").value;
		   var m_broker_code= document.getElementById("txt_broker_code").value;
					
               jQuery('#TABLE_CLIENT_PAYMENT_SUMMARY').GridUnload();
               m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"BrokerBulkPaymentsApproveVal?chksql=bulk_payment_approve_summary&port="+m_port+"&client_code="+m_client_code+"&client_manager="+m_client_manager+"&broker_code="+m_broker_code+"";
					jQuery('#TABLE_CLIENT_PAYMENT_SUMMARY').jqGrid({
                   url: m_url,
                   //loadonce: 1,
                   datatype: 'json',
                   colNames: ['Save Order No','Client Manager','Facility Number','Client Name' ,'Beneficiary','Payment Amount',
						/*'Value Date','Transation Date','Mode', 'Company Bank Account','Settlement Mode' ,*/
						/*'Comments',*/'Approve','Reject','Payment_Category'
						/*'Spot Margin%'*/],
                   colModel: [
						{name: 'Payment_No',             index: 'Payment_No',   		jsonmap: 'Payment_No',          sortable: false, align: 'center', width: 90, resizable: false,    unformat: unformatData ,formatter:cellFomatterPaymentNo},//formatter: cellFomatterPaymentsColumn_1,
						{name: 'Client_Manager',         index: 'Client_Manager',   	jsonmap: 'Client_Manager', 	    sortable: false, align: 'center', width: 80, resizable: false,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_1,
						{name: 'Facility_Number',        index: 'Facility_Number',  	jsonmap: 'Facility_Number', 	sortable: false, align: 'center' , width: 90, resizable: false,  unformat: unformatData},
						{name: 'Client_Name',            index: 'Client_Name',      	jsonmap: 'Client_Name', 		sortable: false, align: 'left', width: 80, resizable: true,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_2,
						{name: 'Beneficiary',            index: 'Beneficiary',      	jsonmap: 'Beneficiary', 		sortable: false, align: 'center',  width: 80, resizable: false,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_5,
						{name: 'Payment_Amount',         index: 'Payment_Amount',   	jsonmap: 'Payment_Amount',  	sortable: false, align: 'right',  width: 100, resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_6_0,
						/*
						{name: 'Value_Date',             index: 'Value_Date',       	jsonmap: 'Value_Date',  		sortable: false, align: 'right',  width: 60, resizable: false,   unformat: unformatData },//formatter: cellFomatterPaymentsColumn_6,
						{name: 'Tran_Date',              index: 'Tran_Date',       		jsonmap: 'Tran_Date',    		sortable: false, align: 'right',  width: 100, resizable: false,   unformat: unformatData },//formatter: cellFomatterPaymentsColumn_6,
						{name: 'Mode',                   index: 'Mode',             	jsonmap: 'Mode',  			    sortable: false, align: 'center', width: 80,  resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_7, 
						{name: 'Company_Bank_Account',   index: 'Company_Bank_Account', jsonmap: 'Company_Bank_Account',sortable: false, align: 'center', width: 140, resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_8,
						{name: 'Settl_Mode',             index: 'Settl_Mode',           jsonmap: 'Settl_Mode',          sortable: false, align: 'center', width: 120,  resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_7, 
						{name: 'Comments',               index: 'Comments',            	jsonmap: 'Comments', 			sortable: false, align: 'center', width: 100,  resizable: false,  unformat: unformatData,   formatter:cellFomatterPayComment},//formatter: cellFomatterPaymentsColumn_9,
						*/{name: 'Approve',              index: 'Approve',           	jsonmap: 'Approve', 			sortable: false, align: 'center', width: 50, resizable: false,   unformat: unformatData,  formatter:checkBoxFmatterPayApprove},
						{name: 'Reject',                 index: 'Reject',   			jsonmap: 'Reject', 			    sortable: false, align: 'center', width: 50, resizable: false,   unformat: unformatData,  formatter:checkBoxFmatterPayReject},
						{name: 'Payment_Category',       index: 'Payment_Category',     jsonmap: 'Payment_Category',    sortable: false, align: 'center', width: 50, resizable: false,   unformat: unformatData,  hidden:true}
						//{name: 'Spot_Margin',            index: 'Spot_Margin',   		jsonmap: 'Spot_Margin', 	    sortable: false, align: 'right', width: 80, resizable: false,   unformat: unformatData}
					],
                   mtype: 'GET',
                   rownumbers: true,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
                   toolbar: [false, 'top'],
                   caption: 'Client Payments',
				   jsonReader: {repeatitems: false},
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
                        var rec_count=$("#TABLE_CLIENT_PAYMENT_SUMMARY").jqGrid('getGridParam',"records");
                        document.Form1.hid_count.value=rec_count;
					}
               });
           }
				
				
				
		 function loadGridPaymentsAppove() {
				
		   var m_client_code= document.getElementById("txt_client_code").value;
		   var m_client_manager= document.getElementById("TXT_CLIENT_MANAGER").value;
		   var m_port= document.getElementById("txt_facility_number").value;
		   var m_broker_code= document.getElementById("txt_broker_code").value;
					
               jQuery('#TABLE_CLIENT_PAYMENT_APPROVE').GridUnload();
               m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"BrokerBulkPaymentsHighApproveVal?chksql=bulk_payment_approve&port="+m_port+"&client_code="+m_client_code+"&client_manager="+m_client_manager+"&broker_code="+m_broker_code+"";
				
				jQuery('#TABLE_CLIENT_PAYMENT_APPROVE').jqGrid({
                   url: m_url,
                   //loadonce: 1,
                   datatype: 'json',
                   colNames: ['Payment No','Client Manager','Facility Number','Client Name' ,'Beneficiary','Payment Amount','Value Date','Transation Date','Mode', 'Company Bank Account','Settlement Mode' ,'Comments','Approve','Reject','Spot Margin%'],
                   colModel: [
						{name: 'Payment_No',             index: 'Payment_No',   		jsonmap: 'Payment_No',          sortable: false, align: 'center', width: 90, resizable: false,    unformat: unformatData ,formatter:cellFomatterPaymentNo},//formatter: cellFomatterPaymentsColumn_1,
						{name: 'Client_Manager',         index: 'Client_Manager',   	jsonmap: 'Client_Manager', 	    sortable: false, align: 'center', width: 80, resizable: false,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_1,
						{name: 'Facility_Number',        index: 'Facility_Number',  	jsonmap: 'Facility_Number', 	sortable: false, align: 'center' , width: 90, resizable: false,  unformat: unformatData},
						{name: 'Client_Name',            index: 'Client_Name',      	jsonmap: 'Client_Name', 		sortable: false, align: 'left', width: 80, resizable: true,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_2,
						{name: 'Beneficiary',            index: 'Beneficiary',      	jsonmap: 'Beneficiary', 		sortable: false, align: 'center',  width: 80, resizable: false,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_5,
						{name: 'Payment_Amount',         index: 'Payment_Amount',   	jsonmap: 'Payment_Amount',  	sortable: false, align: 'right',  width: 100, resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_6_0,
						{name: 'Value_Date',             index: 'Value_Date',       	jsonmap: 'Value_Date',  		sortable: false, align: 'right',  width: 60, resizable: false,   unformat: unformatData },//formatter: cellFomatterPaymentsColumn_6,
						{name: 'Tran_Date',              index: 'Tran_Date',       		jsonmap: 'Tran_Date',    		sortable: false, align: 'right',  width: 100, resizable: false,   unformat: unformatData },//formatter: cellFomatterPaymentsColumn_6,
						{name: 'Mode',                   index: 'Mode',             	jsonmap: 'Mode',  			    sortable: false, align: 'center', width: 80,  resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_7, 
						{name: 'Company_Bank_Account',   index: 'Company_Bank_Account', jsonmap: 'Company_Bank_Account',sortable: false, align: 'center', width: 140, resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_8,
						{name: 'Settl_Mode',             index: 'Settl_Mode',           jsonmap: 'Settl_Mode',          sortable: false, align: 'center', width: 120,  resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_7, 
						{name: 'Comments',               index: 'Comments',            	jsonmap: 'Comments', 			sortable: false, align: 'center', width: 100,  resizable: false,  unformat: unformatData,   formatter:cellFomatterPayComment},//formatter: cellFomatterPaymentsColumn_9,
						{name: 'Approve',                index: 'Approve',           	jsonmap: 'Approve', 			sortable: false, align: 'center', width: 50, resizable: false,   unformat: unformatData,  formatter:checkBoxFmatterPayApprove},
						{name: 'Reject',                 index: 'Reject',   			jsonmap: 'Reject', 			    sortable: false, align: 'center', width: 50, resizable: false,   unformat: unformatData,  formatter:checkBoxFmatterPayReject},
						{name: 'Spot_Margin',            index: 'Spot_Margin',   		jsonmap: 'Spot_Margin', 	    sortable: false, align: 'right', width: 80, resizable: false,   unformat: unformatData}
					],
                   mtype: 'GET',
                   rownumbers: true,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
                   toolbar: [false, 'top'],
                   caption: 'Client Payments',
				   jsonReader: {repeatitems: false},
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
                        var rec_count=$("#TABLE_CLIENT_PAYMENT_APPROVE").jqGrid('getGridParam',"records");
                        document.Form1.hid_count.value=rec_count;
					}
               });
           }
		
		function detail_approve_all_enable(row_no){
					
			var m_detail_grid_no_of_rows   = $('#tb_pen_'+row_no).jqGrid('getGridParam',"records");
			var m_aprove_summary_flag = document.getElementById('approve_'+row_no).checked;	
			if(m_aprove_summary_flag){
				for(j = 1 ; j < m_detail_grid_no_of_rows; j ++){
				 var mm_approve     = 'approvetb_pen_'+row_no+'_x_'+j;
				
				 document.getElementById(mm_approve).checked=true;	
				}
			}else{
							for(j = 1 ; j < m_detail_grid_no_of_rows; j ++){
				 var mm_approve     = 'approvetb_pen_'+row_no+'_x_'+j;
				
				 document.getElementById(mm_approve).checked=false;	
				}
			}
			
			
		}	
		
			function detail_reject_all_enable(row_no){
					
			var m_detail_grid_no_of_rows   = $('#tb_pen_'+row_no).jqGrid('getGridParam',"records");
			var m_reject_summary_flag = document.getElementById('reject_'+row_no).checked;	
				
			if(m_reject_summary_flag){
				
				for(j = 1 ; j < m_detail_grid_no_of_rows; j ++){
				 var mm_reject     = 'rejecttb_pen_'+row_no+'_x_'+j;
				
				 document.getElementById(mm_reject).checked=true;	
				}
				
			}else{
				for(j = 1 ; j < m_detail_grid_no_of_rows; j ++){
				 var mm_reject     = 'rejecttb_pen_'+row_no+'_x_'+j;
				 document.getElementById(mm_reject).checked=false;	
				}
			}
			
			
		}
			
			
		 function loadGridPaymentsDetail(row_no,app_st) {
			
		  if(document.getElementById("DIV_CLIENT_PAYMENT_DETAIL"+row_no)!=null){
			
			  document.getElementById("DIV_CLIENT_PAYMENT_DETAIL"+row_no).innerHTML='';
			  $("#DIV_CLIENT_PAYMENT_DETAIL"+row_no).remove();
			}
			
			// document.getElementById("DIV_PAYMENT_PENDING").innerHTML =document.getElementById("DIV_PAYMENT_PENDING").innerHTML+
			$("#DIV_PAYMENT_APPROVE_DETAIL").append("<div id = 'DIV_CLIENT_PAYMENT_DETAIL"+row_no+"'><table id = 'tb_pen_"+row_no+"'></table><div id = 'DIV_PAGER_tb_pen_"+row_no+"'></DIV><input type = 'hidden' id = 'hid_count_x"+row_no+"' name = 'hid_count_x"+row_no+"' /><BR></DIV>");
		
		
		   var m_selected_row      = jQuery('#TABLE_CLIENT_PAYMENT_SUMMARY').jqGrid('getRowData', row_no);
                  	
				
		   var m_client_code = '';//document.getElementById("txt_client_code").value;
		   var m_client_manager = '';//document.getElementById("TXT_CLIENT_MANAGER").value;
		   var m_port        = m_selected_row.Facility_Number;//document.getElementById("txt_facility_number").value;
		   var m_broker_code =  m_selected_row.Beneficiary;//document.getElementById("txt_broker_code").value;
		   var m_caption ='Client Payment - '+ m_selected_row.Payment_No+' - ' +m_broker_code+' - '+	m_port;	
		   var m_save_order_no  = m_selected_row.Payment_No;
				
               jQuery('#tb_pen_'+row_no).GridUnload();
               m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"BrokerBulkPaymentsApproveVal?chksql=bulk_payment_approve&port="+m_port+"&client_code="+m_client_code+"&client_manager="+m_client_manager+"&broker_code="+m_broker_code+"&save_order_no="+m_save_order_no+"";
				
				jQuery('#tb_pen_'+row_no).jqGrid({
                   url: m_url,
                   //loadonce: 1,
                   datatype: 'json',
                   colNames: ['Payment No','Client Manager','Facility Number','Client Name' ,'Beneficiary','Payment Amount','Value Date','Transation Date','Mode', 'Company Bank Account','Settlement Mode' ,'Comments','Approve','Reject','Spot Margin%'],
                   colModel: [
						{name: 'Payment_No',             index: 'Payment_No',   		jsonmap: 'Payment_No',          sortable: false, align: 'center', width: 90, resizable: false,    unformat: unformatData ,formatter:cellFomatter_x_PaymentNo},//formatter: cellFomatterPaymentsColumn_1,
						{name: 'Client_Manager',         index: 'Client_Manager',   	jsonmap: 'Client_Manager', 	    sortable: false, align: 'center', width: 80, resizable: false,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_1,
						{name: 'Facility_Number',        index: 'Facility_Number',  	jsonmap: 'Facility_Number', 	sortable: false, align: 'center' , width: 90, resizable: false,  unformat: unformatData},
						{name: 'Client_Name',            index: 'Client_Name',      	jsonmap: 'Client_Name', 		sortable: false, align: 'left', width: 80, resizable: true,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_2,
						{name: 'Beneficiary',            index: 'Beneficiary',      	jsonmap: 'Beneficiary', 		sortable: false, align: 'center',  width: 80, resizable: false,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_5,
						{name: 'Payment_Amount',         index: 'Payment_Amount',   	jsonmap: 'Payment_Amount',  	sortable: false, align: 'right',  width: 100, resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_6_0,
						{name: 'Value_Date',             index: 'Value_Date',       	jsonmap: 'Value_Date',  		sortable: false, align: 'right',  width: 60, resizable: false,   unformat: unformatData },//formatter: cellFomatterPaymentsColumn_6,
						{name: 'Tran_Date',              index: 'Tran_Date',       		jsonmap: 'Tran_Date',    		sortable: false, align: 'right',  width: 100, resizable: false,   unformat: unformatData },//formatter: cellFomatterPaymentsColumn_6,
						{name: 'Mode',                   index: 'Mode',             	jsonmap: 'Mode',  			    sortable: false, align: 'center', width: 80,  resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_7, 
						{name: 'Company_Bank_Account',   index: 'Company_Bank_Account', jsonmap: 'Company_Bank_Account',sortable: false, align: 'center', width: 140, resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_8,
						{name: 'Settl_Mode',             index: 'Settl_Mode',           jsonmap: 'Settl_Mode',          sortable: false, align: 'center', width: 120,  resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_7, 
						{name: 'Comments',               index: 'Comments',            	jsonmap: 'Comments', 			sortable: false, align: 'center', width: 100,  resizable: false,  unformat: unformatData,   formatter:cellFomatter_x_PayComment},//formatter: cellFomatterPaymentsColumn_9,
						{name: 'Approve',                index: 'Approve',           	jsonmap: 'Approve', 			sortable: false, align: 'center', width: 50, resizable: false,   unformat: unformatData,  formatter:checkBoxFmatter_x_PayApprove},
						{name: 'Reject',                 index: 'Reject',   			jsonmap: 'Reject', 			    sortable: false, align: 'center', width: 50, resizable: false,   unformat: unformatData,  formatter:checkBoxFmatter_x_PayReject},
						{name: 'Spot_Margin',            index: 'Spot_Margin',   		jsonmap: 'Spot_Margin', 	    sortable: false, align: 'right', width: 80, resizable: false,   unformat: unformatData}
					],
                   mtype: 'GET',
                   rownumbers: true,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
                   toolbar: [false, 'top'],
                   caption: m_caption,
				   jsonReader: {repeatitems: false},
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
                          
                       						
						if(app_st=='APPROVE'){
					       detail_approve_all_enable(row_no);	
						}
						else if(app_st=='REJECT'){
					       detail_reject_all_enable(row_no);	
						}
					},
					loadComplete : function(){
                        var rec_count=$('#tb_pen_'+row_no).jqGrid('getGridParam',"records");
                        document.getElementById('hid_count_x'+row_no).value = rec_count;
					}
               });
           }
			
			
		 function loadGridRebatePaymentsDetail(row_no,app_st) {
			
		  if(document.getElementById("DIV_CLIENT_PAYMENT_DETAIL"+row_no)!=null){
			
			  document.getElementById("DIV_CLIENT_PAYMENT_DETAIL"+row_no).innerHTML='';
			  $("#DIV_CLIENT_PAYMENT_DETAIL"+row_no).remove();
			}
			
			// document.getElementById("DIV_PAYMENT_PENDING").innerHTML =document.getElementById("DIV_PAYMENT_PENDING").innerHTML+
			$("#DIV_PAYMENT_APPROVE_DETAIL").append("<div id = 'DIV_CLIENT_PAYMENT_DETAIL"+row_no+"'><table id = 'tb_pen_"+row_no+"'></table><div id = 'DIV_PAGER_tb_pen_"+row_no+"'></DIV><input type = 'hidden' id = 'hid_count_x"+row_no+"' name = 'hid_count_x"+row_no+"' /><BR></DIV>");
		
		
		   var m_selected_row      = jQuery('#TABLE_CLIENT_PAYMENT_SUMMARY').jqGrid('getRowData', row_no);
                  	
				
		   var m_client_code = '';//document.getElementById("txt_client_code").value;
		   var m_client_manager = '';//document.getElementById("TXT_CLIENT_MANAGER").value;
		   var m_port        = m_selected_row.Facility_Number;//document.getElementById("txt_facility_number").value;
		   var m_broker_code =  m_selected_row.Beneficiary;//document.getElementById("txt_broker_code").value;
		   var m_caption ='Client Payment - '+ m_selected_row.Payment_No+' - ' +m_broker_code+' - '+	m_port;	
		   var m_save_order_no  = m_selected_row.Payment_No;
				
               jQuery('#tb_pen_'+row_no).GridUnload();
               m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"BrokerBulkPaymentsApproveVal?chksql=rebate_payment_approve&port="+m_port+"&client_code="+m_client_code+"&client_manager="+m_client_manager+"&broker_code="+m_broker_code+"&save_order_no="+m_save_order_no+"";
			 // window.open(m_url);	
				jQuery('#tb_pen_'+row_no).jqGrid({
                   url: m_url,
                   //loadonce: 1,
                   datatype: 'json',
                   colNames: ['Payment No','Client Manager','Facility Number','Client Name' ,'Beneficiary','Payment Amount','Value Date','Transation Date','Mode', 'Company Bank Account','Settlement Mode' ,'Comments','Approve','Reject','Spot Margin%'],
                   colModel: [
						{name: 'Payment_No',             index: 'Payment_No',   		jsonmap: 'Payment_No',          sortable: false, align: 'center', width: 90, resizable: false,    unformat: unformatData ,formatter:cellFomatter_x_PaymentNo},//formatter: cellFomatterPaymentsColumn_1,
						{name: 'Client_Manager',         index: 'Client_Manager',   	jsonmap: 'Client_Manager', 	    sortable: false, align: 'center', width: 80, resizable: false,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_1,
						{name: 'Facility_Number',        index: 'Facility_Number',  	jsonmap: 'Facility_Number', 	sortable: false, align: 'center' , width: 90, resizable: false,  unformat: unformatData},
						{name: 'Client_Name',            index: 'Client_Name',      	jsonmap: 'Client_Name', 		sortable: false, align: 'left', width: 80, resizable: true,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_2,
						{name: 'Beneficiary',            index: 'Beneficiary',      	jsonmap: 'Beneficiary', 		sortable: false, align: 'center',  width: 80, resizable: false,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_5,
						{name: 'Payment_Amount',         index: 'Payment_Amount',   	jsonmap: 'Payment_Amount',  	sortable: false, align: 'right',  width: 100, resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_6_0,
						{name: 'Value_Date',             index: 'Value_Date',       	jsonmap: 'Value_Date',  		sortable: false, align: 'right',  width: 60, resizable: false,   unformat: unformatData },//formatter: cellFomatterPaymentsColumn_6,
						{name: 'Tran_Date',              index: 'Tran_Date',       		jsonmap: 'Tran_Date',    		sortable: false, align: 'right',  width: 100, resizable: false,   unformat: unformatData },//formatter: cellFomatterPaymentsColumn_6,
						{name: 'Mode',                   index: 'Mode',             	jsonmap: 'Mode',  			    sortable: false, align: 'center', width: 80,  resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_7, 
						{name: 'Company_Bank_Account',   index: 'Company_Bank_Account', jsonmap: 'Company_Bank_Account',sortable: false, align: 'center', width: 140, resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_8,
						{name: 'Settl_Mode',             index: 'Settl_Mode',           jsonmap: 'Settl_Mode',          sortable: false, align: 'center', width: 120,  resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_7, 
						{name: 'Comments',               index: 'Comments',            	jsonmap: 'Comments', 			sortable: false, align: 'center', width: 100,  resizable: false,  unformat: unformatData,   formatter:cellFomatter_x_PayComment},//formatter: cellFomatterPaymentsColumn_9,
						{name: 'Approve',                index: 'Approve',           	jsonmap: 'Approve', 			sortable: false, align: 'center', width: 50, resizable: false,   unformat: unformatData,  formatter:checkBoxFmatter_x_PayApprove},
						{name: 'Reject',                 index: 'Reject',   			jsonmap: 'Reject', 			    sortable: false, align: 'center', width: 50, resizable: false,   unformat: unformatData,  formatter:checkBoxFmatter_x_PayReject},
						{name: 'Spot_Margin',            index: 'Spot_Margin',   		jsonmap: 'Spot_Margin', 	    sortable: false, align: 'right', width: 80, resizable: false,   unformat: unformatData}
					],
                   mtype: 'GET',
                   rownumbers: true,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
                   toolbar: [false, 'top'],
                   caption: m_caption,
				   jsonReader: {repeatitems: false},
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
                          
                       						
						if(app_st=='APPROVE'){
					       detail_approve_all_enable(row_no);	
						}
						else if(app_st=='REJECT'){
					       detail_reject_all_enable(row_no);	
						}
					},
					loadComplete : function(){
                        var rec_count=$('#tb_pen_'+row_no).jqGrid('getGridParam',"records");
                        document.getElementById('hid_count_x'+row_no).value = rec_count;
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
					
			 /*      $('#DIV_DRILL_DOWN_2').dialog({
                   bgiframe: true,
                   autoOpen: false,
                   modal: false,
                   height: 500,
                   width: getW
               });	
			$('#DIV_DRILL_DOWN_3').dialog({
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
		
		function pay_detail_view(row_id,app_st){
		 
		//  fnDiable();	
		//  document.getElementById('DIV_PAYMENT_SIGNATURE').style.display = 'none'
		//  document.getElementById('save_but').style.display = 'none';
		//  document.getElementById('add_but').style.display = 'inline';	
		  var m_selected_row      = jQuery('#TABLE_CLIENT_PAYMENT_SUMMARY').jqGrid('getRowData', row_id);
		  var m_payment_category             = m_selected_row.Payment_Category;
			//alert(m_payment_category);
			if(m_payment_category=='BROKER_PAYMENT'){
		         loadGridPaymentsDetail(row_id,app_st);
			}else if(m_payment_category=='REBATE_PAYMENT'){
			     loadGridRebatePaymentsDetail(row_id,app_st);
			}
			
		 
		}
			
			function jq_grid_click_event_broker_pay(rowid, iCol, cellcontent) {
					
			
			 var m_selected_row = jQuery('#TABLE_CLIENT_PAYMENT_APPROVE').jqGrid('getRowData', rowid);
			 var m_broker_code  = m_selected_row.Beneficiary;
			 var m_facility_no  = m_selected_row.Facility_Number;
			 var m_payment_no   = m_selected_row.Payment_No;
			 var m_settl_mode   = m_selected_row.Settl_Mode;
				
              if (iCol == 11) {
                
				/*var m_to_date = document.Form1.TXT_TODATE.value;
				var m_to_month = document.Form1.TXT_TOMONTH.value;
				var m_to_year = document.Form1.TXT_TOYEAR.value;
				var  m_url=jsp_client_url+"dn_broker_payment_drill_down.jsp?broker_code="+m_broker_code+"&to_date="+m_to_date+"&to_month="+m_to_month+"&to_year="+m_to_year;
						
				  window.open(m_url,'broker_payment_drill_down', 'left = 0, top = 0, toolbar = 0, location = 0, directories = 0, status = 0, menuBar = 0, scrollBars = 1, resizable = 1, width = ' + screen.availWidth + ', height = ' + screen.availWidth);
					*/
					
				if(m_settl_mode=='GROSS' || m_settl_mode=='NET' ){
                           if ($('#DIV_DRILL_DOWN_1').dialog('isOpen')) {
                               $('#DIV_DRILL_DOWN_1').dialog('close');
                           }
                           $('#IFRAME_DRILL_DOWN_1').attr('src', '');
                           $('#IFRAME_DRILL_DOWN_1').remove();
                           $('#DIV_DRILL_DOWN_1').html(iframe_html_string_1);
                           $('#DIV_DRILL_DOWN_1').dialog('option', 'title', 'Drill Down');
                           $('#IFRAME_DRILL_DOWN_1').attr('src', "<%= m_jsp_client_url %>"+"/dn_group_net_payments_drilldown_approve.jsp?chksql=group_net_payment&payment_no="+m_payment_no+"");  
                           $('#DIV_DRILL_DOWN_1').dialog('open'); 
										
				}     			
			
			}	
									
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
		 function cellFomatter_x_PaymentNo (cellvalue, options, rowObject){
                     var row_id  = options['rowId'];
				     var grid_id = options['gid'];	
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='PAYMENTNO"+grid_id+"_x_"+row_id+"' name='PAYMENTNO"+grid_id+"_x_"+row_id+"' value='"+cellvalue+"'  /></span>";
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
			function checkBoxFmatterPayApprove (cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='checkbox' id='approve_"+rowid+"'  name='approve_"+rowid+"' value='on'  onclick =validateApprove('"+rowid+"');pay_detail_view('"+rowid+"','APPROVE');     />"; 
              return link;
		  }
			function checkBoxFmatter_x_PayApprove (cellvalue, options, rowObject){
              var rowid   = options['rowId'];
			  var grid_id = options['gid'];	
	          var link ="<input type='checkbox' id='approve"+grid_id+"_x_"+rowid+"'   name='approve"+grid_id+"_x_"+rowid+"'  value='on'  onclick =validateApprove('"+rowid+"');     />"; 
              return link;
		  }
			function checkBoxFmatterPayReject (cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='checkbox' id='reject_"+rowid+"'  name='reject_"+rowid+"' value='on'  onclick =validateRej('"+rowid+"');pay_detail_view('"+rowid+"','REJECT');    />"; 
              return link;
		  }
		function checkBoxFmatter_x_PayReject (cellvalue, options, rowObject){
              var rowid=options['rowId'];
			   var grid_id = options['gid'];	
	          var link ="<input type='checkbox' id='reject"+grid_id+"_x_"+rowid+"'  name='reject"+grid_id+"_x_"+rowid+"' value='on'  onclick =validateRej('"+rowid+"');pay_detail_view('"+rowid+"','REJECT');    />"; 
              return link;
		  }	
		
		 /*	function checkBoxFmatterPayApprove (cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='checkbox' id='approve_"+rowid+"'  name='approve_"+rowid+"' value='on'  onclick =validateApprove('"+rowid+"');     />"; 
              return link;
		  }
			function checkBoxFmatterPayReject (cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='checkbox' id='reject_"+rowid+"'  name='reject_"+rowid+"' value='on'  onclick =validateRej('"+rowid+"');    />"; 
              return link;
			}	*/
			
		 function cellFomatterPayComment(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
				     var grid_id = options['gid'];	
                     var texts = "<span><input type='text' align='left' style ='text-align: left;'  id='comment_"+row_id+"' name='comment_"+row_id+"' value=''/></span>";
                     return texts;
          }
		function cellFomatter_x_PayComment(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
				     var grid_id = options['gid'];	
                     var texts = "<span><input type='text' align='left' style ='text-align: left;'  id='comment"+grid_id+"_x_"+row_id+"' name='comment"+grid_id+"_x_"+row_id+"' value=''/></span>";
                     return texts;
          }
		 function cellFomatterPayMode(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span><select name='Hid_Sett_type_"+row_id+"'  ><OPTION VALUE='CHEQUE' SELECTED>PAY ORDER</OPTION><OPTION VALUE='BANK_TRANF'>BANK_TRANF</OPTION></select></span>";
				     return texts;
          }	
			
		  function unformatData(cellvalue, options, cellobject) {
               return cellvalue;
           }
			
         function validateRej(val){
			var str_approve_object_name='approve_'+val;
			document.forms[0].elements[str_approve_object_name].checked = false;
			}
	    function validateApprove(val){
			var str_approve_object_name='reject_'+val;
			document.forms[0].elements[str_approve_object_name].checked = false;
			}	
			
			
		function fnCancel(){
			document.getElementById("DIV_PAYMENT_APPROVE").innerHTML ="<table id = 'TABLE_CLIENT_PAYMENT_APPROVE'></table><div id = 'DIV_PAGER_TABLE_CLIENT_PAYMENT_APPROVE'></div>";
          document.getElementById("txt_client_code").value="";
		  document.getElementById("TXT_CLIENT_MANAGER").value="";
		  document.getElementById("txt_facility_number").value="";
		  document.getElementById("txt_broker_code").value="";
		
		  document.getElementById("txt_facility_number_name").value="";
		  document.getElementById("TXT_CLIENT_MANAGER_NAME").value="";
		  document.getElementById("txt_facility_number").value="";
		  document.getElementById("txt_broker_full_name").value=""; 
			//loadGridPaymentsAppove();
			}
			
		function	fnSave(){
			
			//	alert('ssssss');
				//-------added by prabash on 15-05-2013-----------**

				var m_main_maxentries   = Form1.hid_count.value;
			//	alert(m_main_maxentries);
				for(i = 1 ; i <= m_main_maxentries; i ++){
					var m_maxentries =$('#tb_pen_'+i).jqGrid('getGridParam',"records");
						for(j = 1 ; j <= m_maxentries; j ++){
						var buy_sett_date=$('#tb_pen_'+j).jqGrid('getGridParam',"Tran_Date");
					
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buy_sett_date="+buy_sett_date+"&chksql=chk_buy_sett_date_check"; //chk_buy_sett_date
					load_interface(m_url,'XML',false);
					m_size = data_vec.length;
				
					document.Form1.HID_BUY_SETT_DATE.value=data_vec[0];
				
				if(document.Form1.HID_BUY_SETT_DATE.value=="YES"){
				//	alert("Value Date is not greater than Last Day End Routine Date, Please Re-Enter the Value Date !.");
					alert("Value Date is not greater than Last Day End Routine Date or daily margin trading date , Please Re-Enter the Value Date !.");	
					dayobj.value=" ";	monthobj.value=" ";yearobj.value=" ";dayobj.focus();
				}
				else{
				
				document.Form1.Hid_scr_name.value="payment_approve";
				document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_payments_confirmation";
				document.Form1.submit();
				}		
					
				}
				}	
			
				//--------**
				
				
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
	
		</script>
 	
 </head>
    
    <body class="body & txt-body">
        <form name="Form1" id="Form1" >
			 <input type = "hidden" id = "Hid_scr_name" name = "Hid_scr_name" Value="payment_approve" />
			 <input type = "hidden" id = "Hid_scr_name" name = "redirect_url" Value="dn_payment_higher_approval.jsp" />
			 <input type = "hidden" id = "hid_count" name = "hid_count" />
				<INPUT TYPE="Hidden" NAME="HID_BUY_SETT_DATE" VALUE="" >
		     <div>
                <table class="table" align="center" border="0" cellpadding="0" cellspacing="0" width="99%">
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

                    <td width="50%" class="hh1" align="right"><b>Payment Approval</b></td>
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
					
					
					<tr>
                         <td style = "width: 200px;"><div id = "div_txt_client_code">Client Code</div></td>
                              <td><input class = "txt_input" type = "text" id = "txt_client_code" name = "txt_client_code" maxlength = "250" style = "width: 125px;" /></td>
                                  <td style = "width: 60px;"><input class = "but_input" type = "button" id = "but_help_client_code_main" name = "but_help_client_code_main" value = "..."  onclick="client_code_help(0)"/>
                                       </td>
                                       <td style = "width: 120px;"></td>
                               <td style = "width: 200px;"><div id = "div_txt_client_full_name">Client Full Name</div></td>
                           <td><input class = "txt_input" type = "text" id = "txt_client_full_name" name = "txt_client_full_name" style = "width: 250px;" disabled = "disabled" /></td>
                     </tr>
					  
					<tr>
                          <td style = "width: 200px;"><div id = "div_txt_facility_number">Facility Number</div></td>
						       <td><input class = "txt_input" type = "text" id = "txt_facility_number" name = "txt_facility_number" maxlength = "15" style = "width: 125px;" />
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
						       <td><input class = "txt_input" type = "text" id = "txt_broker_code" name = "txt_broker_code" maxlength = "15" style = "width: 125px;" />
                                  </td>
                                      <td style = "width: 60px;">
                                         <input class = "but_input" type = "button" id = "BUT_HELP_CLIENT_MANAGER_MAIN" name = "BUT_HELP_CLIENT_MANAGER_MAIN" value = "..." onclick="broker_code_help(0);" />
                                             
                                              <td style = "width: 120px;">
                                           <input class = "but_input" type = "button" id = "BUT_SEARCH" name = "BUT_SEARCH" value = "Search" style = "width: 80px;" onclick="loadGridPaymentsSummary();"/>
                                        </td>
                                    <td style = "width: 200px;"><div id = "txt_broker_full_name">Broker Full Name</div></td>
                                <td>
                             <input class = "txt_input" type = "text" id = "txt_broker_full_name" name = "txt_broker_full_name" style = "width: 250px;" disabled = "disabled" />
                          </td>
                      </tr>                               
                                                 
               </table>	
				
				
				
			<BR>	
				
	  <div id = "DIV_PAYMENT_APPROVE">
                     <table id = "TABLE_CLIENT_PAYMENT_APPROVE"></table>
                      <div id = "DIV_PAGER_TABLE_CLIENT_PAYMENT_APPROVE"></div>

       </div>
	
	   <div id = "DIV_PAYMENT_APPROVE_SUMMARY">
				 <table id = "TABLE_CLIENT_PAYMENT_SUMMARY"></table>
                   <div id = "DIV_PAGER_TABLE_CLIENT_PAYMENT_SUMMARY"></div>							
	   </div>
		<BR>
	    <div id = "DIV_PAYMENT_APPROVE_DETAIL">
				 <table id = "TABLE_CLIENT_PAYMENT_DETAIL"></table>
                   <div id = "DIV_PAGER_TABLE_CLIENT_PAYMENT_DETAIL"></div>							
	    </div>								
										
		 <div id = "DIV_DRILL_DOWN_1" title = "">
               <iframe id = "IFRAME_DRILL_DOWN_1" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Invoice Drill Down">
        	  </iframe>
        </div>
						
        </form>		
			
 </body>		
</html>
	
