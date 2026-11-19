<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Calendar" %>
<%@page import="java.util.Date" %>
<%@page import="net.sasianet.ADLMARGIN.*" %>
<%
	ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
	String m_jsp_client_url = m_sn_methods.jsp_client_url;

	
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
			
			var Ckack_2 = "2";
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
					//	loadGridPaymentsSummary();
				});
			function fn_veiwall(){
				fnCancel();
				//loadGridPaymentsAppove();
				loadGridPaymentsSummary();	
			}	
			
			
			//-------------------
			function display_dat(){ 
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=get_dat";
				load_interface(m_url,'XML',false);
				
				m_size= data_vec.length;
				if(m_size>0){	
					document.Form1.TXT_DATE_FROM.value=data_vec[0].substring(0,2);
					document.Form1.TXT_MONTH_FROM.value=data_vec[0].substring(3,5);
					document.Form1.TXT_YEAR_FROM.value=data_vec[0].substring(6,10);
					document.Form1.TXT_DATE_TO.value=data_vec[0].substring(0,2);
					document.Form1.TXT_MONTH_TO.value=data_vec[0].substring(3,5);
					document.Form1.TXT_YEAR_TO.value=data_vec[0].substring(6,10);
				}
				
			}	
			//-------------------	
			
			
			function loadGridPaymentsSummary() {
				
				var m_client_code= document.getElementById("txt_client_code").value;
				var m_client_manager= document.getElementById("TXT_CLIENT_MANAGER").value;
				var m_port= document.getElementById("txt_facility_number").value;
				//   var m_broker_code= document.getElementById("txt_broker_code").value;
				var m_broker_code= 0;	
				var m_trn_type= document.getElementById("TXT_CLIENT_TYPE").value;
				
				jQuery('#TABLE_CLIENT_PAYMENT_SUMMARY').GridUnload();
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Client_Corporate_Action?chksql=client_corp_action&port="+m_port+"&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&trn_type="+m_trn_type+"&client_code="+m_client_code+"&client_manager="+m_client_manager+"&broker_code="+m_broker_code+"";
				//alert(document.Form1.TXT_DATE_FROM.value);	
				//	alert(m_url);	
				//	window.open(m_url);	
				
				jQuery('#TABLE_CLIENT_PAYMENT_SUMMARY').jqGrid({
						url: m_url,
						loadonce: 1,
						datatype: 'json',
						colNames: ['Ref No','Trans Type','Stock Code','Corporate Action Date','Shares on Split Date' ,'Ratio1','Ratio2','No of Shares','Facility Code','Client Name','Comments'],	
						colModel: [
							{name: 'ACTI_REF_NO',             index: 'ACTI_REF_NO',   		jsonmap: 'ACTI_REF_NO',         sortable: true, 					align: 'left', width: 90, resizable: false,  		unformat: unformatData ,formatter:cellFomatterPaymentNo},//formatter: cellFomatterPaymentsColumn_1,
							{name: 'ACTIVITY',         	 	 index: 'ACTIVITY',   			jsonmap: 'ACTIVITY', 	    	sortable: true,  					align: 'left', width: 60, resizable: false,   	unformat: unformatData ,formatter:cellFomatterfacilityNo},//formatter: cellFomatterPaymentsColumn_1,
							{name: 'SECURITY_CODE',          index: 'SECURITY_CODE',   		jsonmap: 'SECURITY_CODE', 	    sortable: true,  					align: 'left', width: 80, resizable: false,   	unformat: unformatData ,formatter:cellFomatterPFNAME},//formatter: cellFomatterPaymentsColumn_1,
							{name: 'XC_DATE',        	 	 index: 'XC_DATE',  			jsonmap: 'XC_DATE', 			sortable: true,  					align: 'left' , width: 90, resizable: false,  	unformat: unformatData ,formatter:cellFomatterReceiptType},
							{name: 'ELIGIBLE_SHARE',         index: 'ELIGIBLE_SHARE',      	jsonmap: 'ELIGIBLE_SHARE', 		sortable: true,  					align: 'right', width: 120, resizable: true,   	 	unformat: unformatData ,formatter:cellFomatterDescription,sorttype: 'float'},//formatter: cellFomatterPaymentsColumn_2,
							{name: 'RATIO1',            	 index: 'RATIO1',      			jsonmap: 'RATIO1', 				sortable: true,  					align: 'left',  width:40, resizable: false,   	unformat: unformatData ,formatter:cellFomatterBank,       sorttype: 'float'},//formatter: cellFomatterPaymentsColumn_5,
							{name: 'RATIO2',         	 	 index: 'RATIO2',   			jsonmap: 'RATIO2',  			sortable: true, 					align: 'left',  width:40, resizable: false,  		unformat: unformatData ,formatter:cellFomatterBranchCode, sorttype: 'float'},//formatter: cellFomatterPaymentsColumn_6_0,
							{name: 'OBTAIN_SHARE',         	 index: 'OBTAIN_SHARE',   		jsonmap: 'OBTAIN_SHARE',  		sortable: true, 					align: 'right',  width: 80, resizable: false,  		unformat: unformatData ,formatter:cellFomatterchequeNo,   sorttype: 'float'},//formatter: cellFomatterPaymentsColumn_6_0,
							{name: 'FACILITY_NO',         	 index: 'FACILITY_NO',   		jsonmap: 'FACILITY_NO',  		sortable: true, 					align: 'left',  width: 100, resizable: false,  	unformat: unformatData ,formatter:cellFomatterAmount},//formatter: cellFomatterPaymentsColumn_6_0,
							{name: 'CLIENT_NAME',         	 index: 'CLIENT_NAME',   		jsonmap: 'CLIENT_NAME',  		sortable: true, 					align: 'left',  width: 130, resizable: false,  		unformat: unformatData ,formatter:cellFomatterclient},//formatter: cellFomatterPaymentsColumn_6_0,
							{name: 'COMMENTS',             	 index: 'COMMENTS',       		jsonmap: 'COMMENTS',  			sortable: false,					align: 'left',  width: 100, resizable: false,   	unformat: unformatData ,formatter:cellFomatterAmount},//formatter: cellFomatterPaymentsColumn_6,
							
							
						],
						mtype: 'GET',
						rownumbers: true,
						rowNum: -1,
						gridview: true,
						height: 'auto',
						hidegrid: false,
						toolbar: [false, 'top'],
						//   sortname: 'ACTI_REF_NO',
						//   sortorder: 'DESC',	
						caption: 'Client Corporate Action',
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
							
							
						},
						loadComplete : function(){
							var rec_count=$("#TABLE_CLIENT_PAYMENT_SUMMARY").jqGrid('getGridParam',"records");
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
			
			
			
			function initDrillDownDialog(){
				$('#DIV_DRILL_DOWN_1').dialog({ 
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
			
			function pay_detail_view(row_id,app_st){
				
				
				
			}
			
			function jq_grid_click_event_broker_pay(rowid, iCol, cellcontent) {
				
				
				var m_selected_row = jQuery('#TABLE_CLIENT_PAYMENT_SUMMARY').jqGrid('getRowData', rowid);
				var m_broker_code  = m_selected_row.Beneficiary;
				var m_facility_no  = m_selected_row.Facility_Number;
				var m_payment_no   = m_selected_row.Payment_No;
				var m_settl_mode   = m_selected_row.Settl_Mode;
				
				if (iCol == 11) {
					
					
					
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
			//-----------------------------------**
			function cellFomatterfacilityNo (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='facilityNo"+row_id+"' name='facilityNo"+row_id+"' value='"+cellvalue+"'  /></span>";
				return texts;
			} 
			function cellFomatterPFNAME (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='PFNAME"+row_id+"' name='PFNAME"+row_id+"' value='"+cellvalue+"'  /></span>";
				return texts;
			} 
			function cellFomatterReceiptType (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='ReceiptType"+row_id+"' name='ReceiptType"+row_id+"' value='"+cellvalue+"'  /></span>";
				return texts;
			} 
			function cellFomatterDescription (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='Description"+row_id+"' name='Description"+row_id+"' value='"+cellvalue+"'  /></span>";
				return texts;
			} 
			function cellFomatterBank (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='Bank"+row_id+"' name='Bank"+row_id+"' value='"+cellvalue+"'  /></span>";
				return texts;
			} 
			function cellFomatterBranchCode (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='BranchCode"+row_id+"' name='BranchCode"+row_id+"' value='"+cellvalue+"'  /></span>";
				return texts;
			} 
			function cellFomatterchequeNo (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='chequeNo"+row_id+"' name='chequeNo"+row_id+"' value='"+cellvalue+"'  /></span>";
				return texts;
			} 
			function cellFomatterAmount (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='Amount"+row_id+"' name='Amount"+row_id+"' value='"+cellvalue+"'  /></span>";
				return texts;
			} 
			
			function cellFomatterclient (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='Amount"+row_id+"' name='Amount"+row_id+"' value='"+cellvalue+"'  /></span>";
				return texts;
			} 
			
			//-----------------------------------**
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
				document.Form1.hid_count2.value = 1;
				document.forms[0].elements[str_approve_object_name].checked = false;
			}
			function validateApprove(val){
				var str_approve_object_name='reject_'+val;
				document.Form1.hid_count2.value = 1;
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
				
				document.Form1.TXT_CLIENT.value="";
				document.Form1.TXT_DATE_FROM.value="";
				document.Form1.TXT_MONTH_FROM.value="";
				document.Form1.TXT_YEAR_FROM.value="";
				document.Form1.TXT_DATE_TO.value="";
				document.Form1.TXT_MONTH_TO.value="";
				document.Form1.TXT_YEAR_TO.value="";
				
				
			}
			
			function	fnSave(){
				document.Form1.target="";		
				document.Form1.Hid_scr_name.value="deposit_slip";
				document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"Deposit_Slip_confirmation";
				document.Form1.submit();
			}
			//Added prabash--------------------*
			function	view_Report(){
				//alert(document.Form1.hid_count2.value);
				if(document.Form1.hid_count2.value == 0){
					
					alert('Please select the records to View');
				}
				else{
					document.Form1.Hid_scr_name.value="deposit_slip";
					//	document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"deposit_report_data";
					document.Form1.target="_blank";		
					document.Form1.action='<%=m_jsp_client_url%>/dn_Deposit_Slip_report.jsp';
					document.Form1.submit();
				}
			}
			//-------------------------*
			
			
			//-------------pra---**
			//--------------------------------------------------------------	
			
			$(document).ready
			(
				
				function() 
				{
					//initDialog();
					initCal('TXT_START_DATE');
					initCal('TXT_END_DATE');
					initDialogPOPup();
				}
			);
			
			
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
				if (instance_id == "TXT_START_DATE") {
					document.Form1.TXT_DATE_FROM.value = splitResult[0];
					document.Form1.TXT_MONTH_FROM.value = splitResult[1];
					document.Form1.TXT_YEAR_FROM.value = splitResult[2];
					document.Form1.TXT_YEAR_FROM.focus();
					
					
				}
				
				
				else if (instance_id == "TXT_END_DATE") {
					document.Form1.TXT_DATE_TO.value = splitResult[0];
					document.Form1.TXT_MONTH_TO.value = splitResult[1];
					document.Form1.TXT_YEAR_TO.value = splitResult[2];
					document.Form1.TXT_YEAR_TO.focus();
				}
				
			}
			
			function show_drill(url) 
			{
				//window.open(url);
				if ($("#DIV_DAILY_MARG_ACTIVITY").dialog("isOpen")) 
				{
					$("#DIV_DAILY_MARG_ACTIVITY").dialog("close");
				}
				
				$("#DIV_DAILY_MARG_ACTIVITY").empty();
				$("#DIV_DAILY_MARG_ACTIVITY").html('<iframe id ="DIV_DAILY_MARG_IFRAME_ACTIVITY" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Daily Margin Trading Activity">');
				
				
				$("#DIV_DAILY_MARG_ACTIVITY").dialog("option", "title", "Detail ");
				$("#DIV_DAILY_MARG_IFRAME_ACTIVITY").attr("src",url);
				$("#DIV_DAILY_MARG_ACTIVITY").dialog("open");
				return false;
			}
			//--------------------------------------------------------------
			
			
			
			
			
			function initDialogPOPup()
			{
				
				$("#DIV_DAILY_MARG_ACTIVITY").dialog(
					
					{
						
						bgiframe: true,
						autoOpen: false,
						//modal: false,
						modal: true, //to disable the back ground	
						height: 500,
						width: getW,
						close: function() 
						{
							
						}
					}
				);
			}
			
			function getW() 
			{
				var w = 0;
				if (window.document.innerWidth > w) 
				{
					w = window.document.innerWidth;
				}
				if (window.document.documentElement.clientWidth > w) 
				{
					w = window.document.documentElement.clientWidth;
				}
				return (w - 100);
			}
			//----------------------------------------------------
			function close_iframe(iframe_id)
			{
				$(iframe_id).dialog("close"); 
				
			}
			//-------------------**
			
			
			
			
			function facility_number_help(m_strat)
			{
				var aForm;    //  aForm =oForm.elements;
				aForm =  document.getElementById('Form1');
				
				
				var myObject=new Array(); //return values set to this object
				myObject[0]=aForm.txt_facility_number;
				myObject[1]=aForm.txt_facility_number_name;
				myObject[2]=null;
				myObject[3]=null;
				myObject[4]=null;
				
				var myObject_value=new Array(); //passing values set to this object
				myObject_value[0]=aForm.txt_facility_number.value;
				myObject_value[1]=aForm.txt_facility_number_name.value;//aForm.oLastName2.value;
				myObject_value[2]=aForm.txt_client_code.value;
				myObject_value[3]=null;
				myObject_value[4]=null;
				
				
				var myObject_type=new Array(); //passing values data type
				myObject_type[0]="StringL";
				myObject_type[1]="StringL";
				myObject_type[2]="StringL";
				myObject_type[3]=null;
				myObject_type[4]=null;
				
				var qid='135';
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
				
				
				var myObject=new Array(); //return values set to this object
				myObject[0]=aForm.TXT_CLIENT_MANAGER;
				myObject[1]=null;
				myObject[2]=aForm.TXT_CLIENT_MANAGER_NAME;
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
				
				var qid='27';
				
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
	
	<body class="body & txt-body" onload="display_dat()" >
		<form name="Form1" id="Form1" method="post" >
			<input type = "hidden" id = "Hid_scr_name" name = "Hid_scr_name" Value="deposit_slip" />
			<input type = "hidden" id = "redirect_url" name = "redirect_url" Value="WD_Client_Corporate_Action.jsp" />
			<input type = "hidden" id = "hid_count" name = "hid_count" />
			<input type = "hidden" id = "hid_count2" name = "hid_count2" />
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
										<td style="background-image: url('<%= m_jsp_client_url %>/images/l3.gif'); background-repeat: repeat;" id="hi2" align="left"><b>Margin Trading - Corporate Action</b></td>
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
										
										<!--         <td width="4%">
										<input class="mainbut" type="button" name="save_but" value="Save" onclick="fnSave();" />
										</td> -->
										<td width="4%">
											<input class="mainbut" type="button" name="calcel_but" value="Cancel" onclick="fnCancel()" />
										</td>
										
										<td width="4%">
											<input class="mainbut" type="button" name="Exit_but" value="Exit" onclick="top.frames[1].location.href='low.jsp'" />
										</td>
										<TD WIDTH="*%"> &nbsp; </TD>
										
										<td width="50%" class="hh1" align="right"><b>Client Corporate Action</b></td>
										<!--  <td width="4%">
										<input class="mainbut" type="button" name="save_but" value="Save" onclick="fnSave();" />
										</td> -->
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
								
								
								<TR>
									
									<TD  style = "width: 150px;">From Date</TD>  
									
									<TD><INPUT TYPE="Text" NAME="TXT_DATE_FROM"  ID="TXT_DATE_FROM"   SIZE="3"  class="txt_input5" MAXLENGTH="2"> 
										<INPUT 	   TYPE="Text" NAME="TXT_MONTH_FROM" ID="TXT_MONTH_FROM"  SIZE="3" class="txt_input5" MAXLENGTH="2">
										<INPUT 	   TYPE="Text" NAME="TXT_YEAR_FROM"  ID="TXT_YEAR_FROM"   SIZE="5"  class="txt_input5" MAXLENGTH="4" ONBLUR="chkstartdate(document.Form1.TXT_DATE_FROM,document.Form1.TXT_MONTH_FROM,document.Form1.TXT_YEAR_FROM)">
										<input type = "hidden" name = "TXT_START_DATE" id = "TXT_START_DATE" />
									</TD>
									<td style = "width: 60px;">
										<TD style = "width: 10px;">   To Date</TD>
										
										<TD style = "width: 250px;" ><INPUT TYPE="Text" NAME="TXT_DATE_TO"  ID="TXT_DATE_TO"   SIZE ="3"  class="txt_input5" MAXLENGTH="2">
											<INPUT 	   TYPE="Text" NAME="TXT_MONTH_TO" ID="TXT_MONTH_TO"  SIZE ="3"  class="txt_input5" MAXLENGTH="2">
											<INPUT 	   TYPE="Text" NAME="TXT_YEAR_TO"  ID="TXT_YEAR_TO"   SIZE ="5"  class="txt_input5" MAXLENGTH="4" ONBLUR="chkstartdate(document.Form1.TXT_DATE_TO,document.Form1.TXT_MONTH_TO,document.Form1.TXT_YEAR_TO);ChkValidity(document.Form1.TXT_DATE_TO,document.Form1.TXT_MONTH_TO,document.Form1.TXT_YEAR_TO,document.Form1.TXT_DATE_FROM,document.Form1.TXT_MONTH_FROM,document.Form1.TXT_YEAR_FROM);">
											<input type = "hidden" name = "TXT_END_DATE" id = "TXT_END_DATE" />
											
										</td>	
										
										
									</TR>			
									
									
									
									
									
									
									<tr>
										<td  style="width: 150px;"><div id = "DIV_TXT_CLIENT_MANAGER">Security Code</div></td>
										<td><input class = "txt_input" type = "text" id = "TXT_CLIENT_MANAGER" name = "TXT_CLIENT_MANAGER" maxlength = "15" style = "width: 150px;" />
										</td>
										<td style = "width: 60px;">
											<input class = "but_input" type = "button" id = "BUT_HELP_CLIENT_MANAGER_MAIN" name = "BUT_HELP_CLIENT_MANAGER_MAIN" value = "..." onclick="client_manager_code_help(0);" />
											<td style = "width: 120px;">
												<!--    <input class = "but_input" type = "button" id = "BUT_VIEW_ALL" name = "BUT_VIEW_ALL" value = "View All" style = "width: 80px;" onclick="fn_veiwall()"/>-->
											</td>
											<td style = "width: 250px;"><div id = "DIV_TXT_CLIENT_MANAGER_NAME">Security Name</div></td>
											<td>
												<input class = "txt_input" type = "text" id = "TXT_CLIENT_MANAGER_NAME" name = "TXT_CLIENT_MANAGER_NAME" style = "width: 250px;" disabled = "disabled" />
											</td>
										</tr>
										
										<tr>
											<td style="width: 150px;">Transaction Type</td>
											<td>
												<select class="txt_input" name="TXT_CLIENT_TYPE" id="TXT_CLIENT_TYPE" style="width: 125px ;">
													<option value="ALL" selected="selected">All</option>
													<option value="BONUS">BONUS</option>				
													<option value="SPLIT">SPLIT</option>
													<option value="AMALGAMATION">AMALGAMATION</option>
													<option value="RIGHTS">RIGHTS</option>
													<option value="WARRANT">WARRANT</option>
												</select>				
											</td>				
											<td style = "width: 60px;"> </td>
											<td style = "width: 120px;"> </td>
											<td><input  type = "text"  name = "bbbbb" maxlength = "15" style="visibility:hidden"  /></td>				
										</tr>				
										
										<tr>
											<td style = "width: 150px;"><div id = "div_txt_client_code">Client Code</div></td>
											<td><input class = "txt_input" type = "text" id = "txt_client_code" name = "txt_client_code" maxlength = "250" style = "width: 125px;" /></td>
											<td style = "width: 60px;"><input class = "but_input" type = "button" id = "but_help_client_code_main" name = "but_help_client_code_main" value = "..."  onclick="client_code_help(0)"/>
											</td>
											<td style = "width: 120px;"></td>
											
											<td style = "width: 250px;"><div id = "div_txt_client_full_name">Client Full Name</div></td>
											<td><input class = "txt_input" type = "text" id = "txt_client_full_name" name = "txt_client_full_name" style = "width:250px;" disabled = "disabled" /></td>
										</tr>
										
										<tr>
											<td style = "width: 150px;"><div id = "div_txt_facility_number">Facility Number</div></td>
											<td><input class = "txt_input" type = "text" id = "txt_facility_number" name = "txt_facility_number" maxlength = "15" style = "width: 125px;" />
											</td>
											<td style = "width: 60px;">
												<input class = "but_input" type = "button" id = "BUT_HELP_FACILITY_NUMBER" name = "BUT_HELP_FACILITY_NUMBER" value = "..." onclick="facility_number_help(0);"  />
												<a id = "help_update_client_manager" style = "text-decoration: none; cursor: text;" class = "fancylink iframe" href = ""> </a>
												<td style = "width: 10px;">
													<input class = "but_input" type = "button" id = "BUT_SEARCH" name = "BUT_SEARCH" value = "Search" style = "width: 80px;" onclick="loadGridPaymentsSummary();"/>
												</td>
												<td style = "width: 250px;"><div id = "txt_facility_number_name">Facility Name</div></td>
												<td>
													<input class = "txt_input" type = "text" id = "txt_facility_number_name" name = "txt_facility_number_name" style = "width: 250px;" disabled = "disabled" />
												</td>
											</tr>
											
											<!--       <tr>
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
											
											
											
											<tr>
											<td style = "width: 200px;"><div id = "div_txt_broker_code">View Report</div></td>
											<td style = "width: 60px;">
											<input class = "but_input" type = "button" id = "view" name = "view" value = "..." onclick="view_Report();" />
											</tr>            					
											
											-->					
											
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
							
