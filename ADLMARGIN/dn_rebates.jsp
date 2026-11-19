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
	
		<link rel="stylesheet" type="text/css" href="<%= m_jsp_client_url %>/css/redmond/jquery-ui.css" />
		<link rel="stylesheet" type="text/css" href="<%= m_jsp_client_url %>/css/ui.jqgrid.css" />
			
		<link rel="stylesheet" type="text/css" href="<%= m_jsp_client_url %>/css/Asset_Financing_System.css" />
		
		
		<script type="text/javascript">
			
			$(document).ready(function() {
					m_grid_height = ($(window).height() - 310);
				});
			
			$(document).ready(function() {
					m_grid_height = ($(window).height() - 200);
					m_grid_width = ($(window).width() - 0);
					initCal('VAL_TXT_DATE');
					initCal('VAL_TXT_FROMDATE'); 		
				});
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
				if (instance_id == "VAL_TXT_FROMDATE") {
					document.Form1.TXT_FROMDATE.value = splitResult[0];
					document.Form1.TXT_FROMMONTH.value = splitResult[1];
					document.Form1.TXT_FROMYEAR.value = splitResult[2];
					document.Form1.TXT_FROMYEAR.focus();
				}
				
				
			}
			//$(document).ready(function() {
			
			//loadGridReceiptsAppove();
			
			// });
			
			function fn_veiwall(){
				fnCancel();
				loadGridReceiptsAppove();
				document.getElementById('save_but').disabled=false;	
				
				
			}	
			
			function loadGridReceiptsAppove() {
				
				var m_client_code    = document.getElementById("txt_client_code").value;
				var m_client_manager = document.getElementById("TXT_CLIENT_MANAGER").value;
				var m_port           = document.getElementById("txt_facility_number").value;
				var m_broker_code    = document.getElementById("txt_broker_code").value;
		        var m_security_code  = document.getElementById("txt_security_code").value;
				var m_to_date      = document.getElementById("TXT_TODATE").value+"-"+document.getElementById("TXT_TOMONTH").value+"-"+document.getElementById("TXT_TOYEAR").value;
				var m_from_date      = document.getElementById("TXT_FROMDATE").value+"-"+document.getElementById("TXT_FROMMONTH").value+"-"+document.getElementById("TXT_FROMYEAR").value;			
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fval_rebates?chksql=getRebateGridDate&port="+m_port+"&client_code="+m_client_code+"&client_manager="+m_client_manager+"&broker_code="+m_broker_code+"&from_date="+m_from_date+"&to_date="+m_to_date+"&security_code="+m_security_code;
				
				
				jQuery('#TABLE_REBATE_MAIN').GridUnload();
				jQuery('#TABLE_REBATE_MAIN').jqGrid({
						url: m_url,
						//loadonce: 1,
						datatype: 'json',
						colNames: ['Deal No','Prior Deal No','Borrower Facility Number','Lender Facility Number','Effective Value Date' ,'Maturity Date','New Maturity Date','Tenor','New Tenor','Markup', 'New Markup', 'Settlement Amount', 'Accr. Settlement Amount',
							      'Settled Amount','Rebate Tenor','Rebate Amount','Int_Rate_Base_Code','Save'],
						colModel: [
							{name: 'Deal_No',                index: 'Deal_No',   		    jsonmap: 'Deal_No',               sortable: false, align: 'center',   width: 90,  resizable: false,     unformat: unformatData ,   formatter:cellFomatterDealNo },
							{name: 'Prior_Deal_No',          index: 'Prior_Deal_No',   	    jsonmap: 'Prior_Deal_No', 	      sortable: false, align: 'center',   width: 100, resizable: true,      unformat: unformatData },
							{name: 'Borr_Portfolio_Code',    index: 'Borr_Portfolio_Code',  jsonmap: 'Borr_Portfolio_Code',   sortable: false, align: 'center',   width: 150, resizable: true,      unformat: unformatData,   formatter:cellFomatterBorrFacility                                 },
							{name: 'Lend_Portfolio_Code',    index: 'Lend_Portfolio_Code',  jsonmap: 'Lend_Portfolio_Code',   sortable: false, align: 'center',   width: 150, resizable: false,      unformat: unformatData,formatter:cellFomatterLendFacility,   hidden:true     }, 
							{name: 'Eff_Valdate',            index: 'Eff_Valdate',  	    jsonmap: 'Eff_Valdate', 	      sortable: false, align: 'center' ,  width: 130, resizable: false,     unformat: unformatData                                   },
							{name: 'Maturity_Date',          index: 'Maturity_Date',        jsonmap: 'Maturity_Date', 	      sortable: false, align: 'center',   width: 130, resizable: false,     unformat: unformatData   },
							{name: 'New_Maturity_Date',      index: 'New_Maturity_Date', 	jsonmap: 'New_Maturity_Date',  	  sortable: false, align: 'center',   width: 120, resizable: false,     unformat: unformatData, formatter:cellFomatterRebateDate, hidden:false },
							{name: 'Tenor',                  index: 'Tenor',             	jsonmap: 'Tenor',  			      sortable: false, align: 'right',    width: 60,  resizable: false,     unformat: unformatData   },
							{name: 'New_Tenor',              index: 'New_Tenor',          	jsonmap: 'New_Tenor',  		      sortable: false, align: 'right',    width: 60, resizable: false,     unformat: unformatData,  hidden:false },
							{name: 'Yeild',                  index: 'Yeild',                jsonmap: 'Yeild',                 sortable: false, align: 'right',    width: 70, resizable: false,     unformat: unformatData    },
							{name: 'New_Yield',              index: 'New_Yield',           jsonmap: 'New_Yield',  		      sortable: false, align: 'right',    width: 70, resizable: false,     unformat: unformatData,  formatter:cellFomatterNew_Yield,  hidden:false },
							{name: 'Leg1_Value',             index: 'Leg1_Value',           jsonmap: 'Leg1_Value', 			  sortable: false, align: 'right',    width: 120, resizable: false,     unformat: unformatData, },
							{name: 'Leg2_Value',             index: 'Leg2_Value',         	jsonmap: 'Leg2_Value',  		  sortable: false, align: 'right',    width: 140, resizable: false,     unformat: unformatData,  hidden:false },
										
							{name: 'New_Leg2_Value',          index: 'New_Leg2_Value',     	jsonmap: 'New_Leg2_Value',  	  sortable: false, align: 'right',    width: 120, resizable: false,     unformat: unformatData,  hidden:false },
													
							{name: 'Rebate_Tenor',             index: 'Rebate_Tenor',       jsonmap: 'Rebate_Tenor',  		  sortable: false, align: 'right',    width: 80, resizable: false,     unformat: unformatData,  formatter:cellFomatterRebateTenor,  hidden:false },
							{name: 'Rebate_Amount',            index: 'Rebate_Amount',      jsonmap: 'Rebate_Amount',  		  sortable: false, align: 'right',    width: 120, resizable: false,     unformat: unformatData,  formatter:cellFomatterRebateAmout, hidden:false },
							{name: 'Int_Rate_Base_Code',       index: 'Int_Rate_Base_Code', jsonmap: 'Int_Rate_Base_Code',    sortable: false, align: 'center',   width: 120, resizable: false,     unformat: unformatData, hidden:true },
														
							{name: 'Save',                   index: 'Save',           	    jsonmap: 'Save', 			     sortable: false, align: 'center',    width: 70,  resizable: false,     unformat: unformatData, formatter:checkBoxFmatterRecSave }
						],
						mtype: 'GET',
						rownumbers: true,
						rowNum: -1,
						gridview: true,
						height: 'auto',
						hidegrid: false,
						toolbar: [false, 'top'],
						caption: 'Rebate',
						jsonReader: {repeatitems: false},
						onCellSelect: jq_grid_click_event_broker_rec,			
						gridComplete: function() {
							
							/*$('#jqgh_ACTUAL_PAYMENTS_COLUMN_1').css('cursor', 'default');
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_2').css('cursor', 'default');
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_5').css('cursor', 'default');
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_6_0').css('cursor', 'default');
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_6').css('cursor', 'default');
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_7').css('cursor', 'default');
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_8').css('cursor', 'default');
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_9').css('cursor', 'default');
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_9_1').css('cursor', 'default');
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_10').css('cursor', 'default');
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_11').css('cursor', 'default');*/
							
							
						},
						loadComplete : function(){
							var rec_count=$("#TABLE_REBATE_MAIN").jqGrid('getGridParam',"records");
							document.Form1.hid_count.value=rec_count;
						}
					});
				document.getElementById('save_but').disabled=false;	  		
			}
			
			function jq_grid_click_event_broker_rec(rowid, iCol, cellcontent) {
				
				 
				var m_selected_row = jQuery('#TABLE_REBATE_MAIN').jqGrid('getRowData', rowid);
				var m_broker_code  = m_selected_row.Broker;
				
				if (iCol == 3) {
					
					var m_to_date  = document.Form1.TXT_TODATE.value;
					var m_to_month = document.Form1.TXT_TOMONTH.value;
					var m_to_year  = document.Form1.TXT_TOYEAR.value;
					var  m_url     = jsp_client_url+"dn_broker_receipts_drill_down.jsp?broker_code="+m_broker_code+"&to_date="+m_to_date+"&to_month="+m_to_month+"&to_year="+m_to_year;
					
					
					window.open(m_url,'broker_receipt_drill_down', 'left = 0, top = 0, toolbar = 0, location = 0, directories = 0, status = 0, menuBar = 0, scrollBars = 1, resizable = 1, width = ' + screen.availWidth + ', height = ' + screen.availWidth);
					
				}
				if (iCol == 4) {
					var m_facility_no  = document.getElementById("txt_facility_number").value; //m_selected_row.Facility_No;
					var m_to_date      = document.Form1.TXT_TODATE.value;
					var m_to_month     = document.Form1.TXT_TOMONTH.value;
					var m_to_year      = document.Form1.TXT_TOYEAR.value;
					var  m_url         = jsp_client_url+"dn_broker_receipts_pending.jsp?broker_code="+m_broker_code+"&to_date="+m_to_date+"&to_month="+m_to_month+"&to_year="+m_to_year+"&facility_no="+m_facility_no;
					
					
					window.open(m_url,'broker_receipt_drill_down', 'left = 0, top = 0, toolbar = 0, location = 0, directories = 0, status = 0, menuBar = 0, scrollBars = 1, resizable = 1, width = ' + screen.availWidth + ', height = ' + screen.availWidth);
					
				}
				
				
				
				
				
			}

			
			function cellFomatterSettleAmt (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				if(row_id!=''){
					var texts = "<span><input class='txt_input' type='text' style ='text-align: right;'  id='hid_settled_amount_"+row_id+"' name='hid_settled_amount_"+row_id+"' disabled value='"+cellvalue+"'  /></span>";
					return texts;
				}else{
					return '&nbsp;';
				}	
				
			}
			
			function cellFomatterDealNo(cellvalue, options, rowObject){
				var row_id  = options['rowId'];
				var texts   = "<span>"+cellvalue+"<input class='txt_input' type='hidden'  style ='text-align: right;'  id='deal_no_"+row_id+"' name='deal_no_"+row_id+"' value='"+cellvalue+"'  /></span>";
				return texts;
			} 
			
			function cellFomatterBorrFacility (cellvalue, options, rowObject){
				var row_id = options['rowId'];
				var texts  = "<span>"+cellvalue+"<input class='txt_input' type='hidden'  style ='text-align: right;'  id='facility_borr_"+row_id+"' name='facility_borr_"+row_id+"' value='"+cellvalue+"'  /></span>";
				return texts;
			}
			function cellFomatterLendFacility (cellvalue, options, rowObject){
				var row_id = options['rowId'];
				var texts  = "<span>"+cellvalue+"<input class='txt_input' type='hidden'  style ='text-align: right;'  id='facility_lend_"+row_id+"' name='facility_lend_"+row_id+"' value='"+cellvalue+"'  /></span>";
				return texts;
			}
			
			function cellFomatterRebateDate (cellvalue, options, rowObject){
				var row_id = options['rowId'];
				var texts  = "<span>"+cellvalue+"<input class='txt_input' type='hidden'  style ='text-align: right;'  id='rebate_date_"+row_id+"' name='rebate_date_"+row_id+"' value='"+cellvalue+"'  /></span>";
				return texts;
			} 
			
			function cellFomatterNew_Yield (cellvalue, options, rowObject){
				var row_id = options['rowId'];
				var texts  = "<span>"+cellvalue+"<input class='txt_input' type='hidden'  style ='text-align: right;'  id='new_yield_"+row_id+"' name='new_yield_"+row_id+"' value='"+cellvalue+"'  /></span>";
				return texts;
			} 
			function cellFomatterRebateTenor(cellvalue, options, rowObject){
				var row_id = options['rowId'];
				var texts  = "<span>"+cellvalue+"<input class='txt_input' type='hidden'  style ='text-align: right;'  id='rebate_tenor_"+row_id+"' name='rebate_tenor_"+row_id+"' value='"+cellvalue+"'  /></span>";
				return texts;
			}
			
			function cellFomatterRebateAmout (cellvalue, options, rowObject){
				var row_id = options['rowId'];
				var texts  = "<span><input class='txt_input' type='text'  style ='text-align: right;'  id='rebate_amount_"+row_id+"' name='rebate_amount_"+row_id+"' value='"+cellvalue+"'  /></span>";
				return texts;
			} 
			
			function cellFomatterNumberPointer(cellvalue, options, rowObject) {
				cellvalue = format_noobject00(cellvalue, 2, null, 'BRACKETS');
				cellvalue = '<div style = "cursor: pointer;">' + cellvalue + '</div>';
				return cellvalue;
			}
			
			function cellFomatterGroupRec (cellvalue, options, rowObject){
				var row_id = options['rowId'];
				
				var texts = "<span>"+format_noobject00(cellvalue, 2, null, 'BRACKETS')+"<input type='hidden'  style ='text-align: right;'  id='hid_group_amount_"+row_id+"' name='hid_group_amount_"+row_id+"' value='"+unformat_noobject(cellvalue)+"'  /></span>";
				return texts;
			}
			function cellFomatterNetRec (cellvalue, options, rowObject){
				var row_id = options['rowId'];
				var texts = "<span>"+format_noobject00(cellvalue, 2, null, 'BRACKETS')+"<input type='hidden'  style ='text-align: right;'  id='hid_net_amount_"+row_id+"' name='hid_net_amount_"+row_id+"' value='"+unformat_noobject(cellvalue)+"'  /></span>";
				return texts;
			}	
			
			function cellFomatterBroker (cellvalue, options, rowObject){
				var row_id = options['rowId'];
				var texts = "<span>"+cellvalue+"<input type='hidden'  style ='text-align: right;'  id='broker"+row_id+"' name='broker"+row_id+"' value='"+cellvalue+"'  /></span>";
				return texts;
			}
			function cellFomatterPaySettDate(cellvalue, options, rowObject){
				var row_id = options['rowId'];
				var texts = "<span>"+cellvalue+"<input type='hidden'  style ='text-align: right;'  id='m_trndate_"+row_id+"' name='m_trndate_"+row_id+"' value='"+cellvalue+"'  /></span>";
				return texts;
			} 	
			function cellFomatterPayClient(cellvalue, options, rowObject){
				var row_id = options['rowId'];
				var texts  = "<span>"+cellvalue+"<input type='hidden'  style ='text-align: right;'  id='m_client_code_"+row_id+"' name='m_client_code_"+row_id+"' value='"+cellvalue+"'  /></span>";
				return texts;
			} 	
			function cellFomatterSetlAmount (cellvalue, options, rowObject){
				var row_id = options['rowId'];
				var texts  = "<span><input type='text'  style ='text-align: right;'  id='m_sett_amount_"+row_id+"' name='m_sett_amount_"+row_id+"' value='"+cellvalue+"' onchange=check_amount('"+row_id+"')  onblur=guaran('"+row_id+"');check_amount('"+row_id+"')  /><input type='hidden' name='m_amount_"+row_id+"' value='"+cellvalue+"'/></span>";
				return texts;
			}
			function checkBoxFmatterRecSave (cellvalue, options, rowObject){
				var rowid = options['rowId'];
				var link  = "<input type='checkbox' class='txt_input' id='save_status_"+rowid+"'  name='save_status_"+rowid+"' value='on'     />"; //onclick =chk_net_payment('"+rowid+"'); <!--onclick =guaran('"+rowid+"');check_amount('"+rowid+"');  onchange=guaran('"+rowid+"');check_amount('"+rowid+"') -->
				return link;
			}
			
			function cellFomatterReceiptView (cellvalue, options, rowObject){
				var rowid = options['rowId'];
				var link  = "<input type='button' id='view_"+rowid+"'  name='view_"+rowid+"' value='View'  onclick =pay_view('"+rowid+"');     />"; 
				return link;
			}
			
			function chk_net_payment(row_id){
				
				var m_selected_row      = jQuery('#TABLE_REBATE_MAIN').jqGrid('getRowData', row_id);
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
				}
				
				
			}
			
			function pay_view(row_id){
				
			}
			
			function checkBoxFmatterPaySignature(cellvalue, options, rowObject){
				var rowid = options['rowId'];
				var link  = "<input type='checkbox' id='signature_"+rowid+"'  name='signature_"+rowid+"' value='on'  onclick =validateSig('"+rowid+"');     />"; 
				return link;
			}
			function checkBoxFmatterPayReject (cellvalue, options, rowObject){
				var rowid = options['rowId'];
				var link  = "<input type='checkbox' id='reject_"+rowid+"'  name='reject_"+rowid+"' value='on'  onclick =validateRej('"+rowid+"');    />"; 
				return link;
			}
			function cellFomatterRecComment(cellvalue, options, rowObject){
				var row_id = options['rowId'];
				var texts  = "<span><input class='txt_input' type='text' align='left' style ='text-align: left;'  id='comment_"+row_id+"' name='comment_"+row_id+"' value=''/></span>";
				return texts;
			}
			
			function cellFomatterRecEntMode(cellvalue, options, rowObject){
				var row_id = options['rowId'];
				var texts  ="";     
				
				if(cellvalue=='GROUP'){         
					texts  = "<span><select name='hid_group_net_mode_"+row_id+"' id='hid_group_net_mode_"+row_id+"'   ><OPTION VALUE='GROUP' SELECTED>Gross Receipts</OPTION><OPTION VALUE='NET'>Net Settlements</OPTION></select></span>";
				}else if(cellvalue=='NET'){
					texts  = "<span><select name='hid_group_net_mode_"+row_id+"' id='hid_group_net_mode_"+row_id+"'   ><OPTION VALUE='GROUP' >Gross Receipts</OPTION><OPTION VALUE='NET SELECTED'>Net Settlements</OPTION></select></span>";	
				}else{
					texts  = "<span><select name='hid_group_net_mode_"+row_id+"' id='hid_group_net_mode_"+row_id+"'  ><OPTION VALUE='N/A' SELECTED>N/A</OPTION><OPTION VALUE='GROUP' >Gross Receipts</OPTION><OPTION VALUE='NET'>Net Settlements</OPTION></select></span>";	
				}
				
				return texts;
			}		
			function cellFomatterRecMode(cellvalue, options, rowObject){
				
				
				var row_id=options['rowId'];
				var texts = "";
				if(cellvalue=='CHEQUE'){
					texts = "<span><select class='txt_input' name='hid_sett_type_"+row_id+"' id='hid_sett_type_"+row_id+"' ><OPTION VALUE='CHEQUE' SELECTED>CHEQUE</OPTION><OPTION VALUE='PAY_ORDER'>PAY ORDER</OPTION><OPTION VALUE='BANK_TRANF'>BANK TRANF</OPTION></select></span>";
				}else if(cellvalue=='PAY_ORDER'){
					texts = "<span><select class='txt_input' name='hid_sett_type_"+row_id+"' id='hid_sett_type_"+row_id+"' ><OPTION VALUE='CHEQUE' >CHEQUE</OPTION><OPTION VALUE='PAY_ORDER' SELECTED >PAY ORDER</OPTION><OPTION VALUE='BANK_TRANF'>BANK TRANF</OPTION></select></span>";
				}else if(cellvalue=='BANK_TRANF'){
					texts = "<span><select class='txt_input' name='hid_sett_type_"+row_id+"' id='hid_sett_type_"+row_id+"'  ><OPTION VALUE='CHEQUE'>CHEQUE</OPTION><OPTION VALUE='PAY_ORDER'>PAY ORDER</OPTION><OPTION VALUE='BANK_TRANF' SELECTED >BANK TRANF</OPTION></select></span>";
				}else{
					texts = "<span><select class='txt_input' name='hid_sett_type_"+row_id+"' id='hid_sett_type_"+row_id+"'  ><OPTION VALUE='CHEQUE' SELECTED>CHEQUE</OPTION><OPTION VALUE='PAY_ORDER'>PAY ORDER</OPTION><OPTION VALUE='BANK_TRANF'>BANK TRANF</OPTION></select></span>";
				}
				
				return texts;
				
				
			}	
			/*
			function get_broker_settlement_mode(broker_code,objname) {
                                                             
                                $.ajax({
                                    url: servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Broker?&chksql=get_settlement_option&client_code=' + broker_code,
                                    type: 'GET',
                                    dataType: 'xml',
                                    success: function(xml) {
                                        
                                        $(xml).find('client').each(function() {
                                            
                                            $(this).find('client_settle_option').each(function() {
                                                
                                                var id = $(this).attr('id');
                                               // alert($(this).find('settle_mode').text());
                                                $('#'+objname+'').val($(this).find('settle_mode').text());
                                               // $('#PAYMENT_TYPE').val($(this).find('payment_type').text());
                                                                                      
                                            });
                                            // handle_null();
                                         });
                                    }
                                });
                                             
            }*/
			
			/*function get_broker_payment_mode(broker_code,objname) {
                                                             
                                $.ajax({
                                    url: servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Broker?&chksql=get_settlement_option&client_code=' + broker_code,
                                    type: 'GET',
                                    dataType: 'xml',
                                    success: function(xml) {
                                        
                                        $(xml).find('client').each(function() {
                                            
                                            $(this).find('client_settle_option').each(function() {
                                                
                                                var id = $(this).attr('id');
                                               // alert($(this).find('settle_mode').text());
                                               // $('#SETTLE_MODE').val($(this).find('settle_mode').text());
                                                $('#'+objname+'').val($(this).find('payment_type').text());
                                                                                      
                                            });
                                            // handle_null();
                                         });
                                    }
                                });
                                             
            }*/
			
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
				var texts = "<span><select class='txt_input' style='width:130'name=' account_no_"+row_id+"'  ><%=m_banks%></select></span>";
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
				document.getElementById("DIV_CLIENT_RECEIPT").innerHTML ="<table id = 'TABLE_REBATE_MAIN'></table><div id = 'DIV_PAGER_TABLE_REBATE_MAIN'></div>";
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
				
				//var no_of_rows = jQuery("#TABLE_JQ_GRID").getDataIDs().length;
				var no_of_rows=$("#TABLE_REBATE_MAIN").jqGrid('getGridParam',"records");
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
					
					if(  document.Form1.elements[i].type == 'text'){
					 document.Form1.elements[i].value = unformat_noobject(document.Form1.elements[i].value); 
					}
					 
					
					
				}
				
				if(chk_confirmed_deal()){
					
					//document.Form1.Hid_scr_name.value="receipts_level_1";
					document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"fsavrebates";
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
			
			function view_security_help(m_strat){
			//val=(document.Form1.SCR_TYPE.selectedIndex);
							
				
     				var aForm;    //  aForm =oForm.elements;
     				aForm =  document.getElementById('Form1');
	
	
 					var myObject=new Array(); //return values set to this object
 					myObject[0]=aForm.txt_security_code;
					myObject[1]=aForm.txt_security_full_name;
 					myObject[2]=null;
  
 					var myObject_value=new Array(); //passing values set to this object
 					myObject_value[0]=aForm.txt_security_code.value;
					myObject_value[1]=aForm.txt_security_code.value;
 	
 
 
 					var myObject_type=new Array(); //passing values data type
 					myObject_type[0]="StringL";
 					myObject_type[1]="StringL";
 		
 	
 
 					var qid='15';
    				title_name='Help';
 					var url = 'popup.jsp';
					var close_fun='close_portP_help';			
 					var json_text = JSON.stringify(myObject_value, null,0);
 					var json_obj_type_text=JSON.stringify(myObject_type, null,0);
 					var fn_name=arguments.callee.name;
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
					
					document.Form1.TXT_FROMDATE.value  = data_vec[0].substring(0,2);
					document.Form1.TXT_FROMMONTH.value = data_vec[0].substring(3,5);
					document.Form1.TXT_FROMYEAR.value  = data_vec[0].substring(6,10);
				}
				else{
				}
				
				
				
			}
			
			function chk_screen(){
				document.Form1.BUT_VIEW_ALL.disabled=true;
				document.Form1.BUT_SEARCH.disabled=true;		
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=get_pay_screen_status";	
				load_interface(m_url,'XML',false);
				
				m_size = data_vec.length;
				
				if(m_size>0){
					if(data_vec[0]>0){
						
						if(confirm(data_vec[1] +'  is proceeding with the payment!!!! do you want to clear the data  and go ahead??')){
							
							m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=payment_clear";	
							load_interface(m_url,'XML',false);
							document.Form1.BUT_VIEW_ALL.disabled=false;
							document.Form1.BUT_SEARCH.disabled=false;	
							
						}else{
							top.frames[1].location.href='low.jsp';
						}
						
					}
					
				}else{
					document.Form1.BUT_VIEW_ALL.disabled=false;
					document.Form1.BUT_SEARCH.disabled=false;	
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
	
	<body class="body & txt-body" onload="display_dat();"> <!--chk_screen();-->
		<form name="Form1" id="Form1" >
			<input type = "hidden" id = "SCR_NAME" name = "SCR_NAME" Value="REBATEGRID" />
			<input type = "hidden" id = "hid_count" name = "hid_count" />
			<div>
				<table class="table" align="center" border="0" cellpadding="0" cellspacing="0" width="99%">
					<tr>
						<td height="7"></td>
					</tr>
					
					<tr height="30">
						<td width="13px" style="background-image: url('<%= m_jsp_client_url %>/images/l1.gif'); background-repeat: no repeat;" id="hi1"></td>
						<td style="background-image: url('<%= m_jsp_client_url %>/images/l3.gif'); background-repeat: repeat;" id="hi2" align="left"><b>Margin Trading - Data Entry</b></td>
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
						
						<td width="4%">
							<input class="mainbut" type="button" name="save_but" id="save_but" value="Save" onclick="fnSave();"  />
						</td>
						<td width="4%">
							<input class="mainbut" type="button" name="calcel_but" value="Cancel" onclick="fnCancel()" />
						</td>
						<td width="4%">
							<input class="mainbut" type="button" name="Exit_but" value="Exit" onclick="top.frames[1].location.href='low.jsp'" />
						</td>
						<TD WIDTH="*%"> &nbsp; </TD>
						
						<td width="50%" class="hh1" align="right"><b>Rebate</b></td>
						<td width="4%">
							<input class="mainbut" type="button" name="save_but" id="save_but" value="Save" onclick="fnSave();"  />
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
					<td style = "width: 200px;"><div id = "DIV_TXT_CLIENT_MANAGER">From Date</div></td>
					<td>
						<INPUT TYPE="Text" NAME="TXT_FROMDATE"  ID="TXT_FROMDATE"    SIZE=3 MAXLENGTH=2 class="txt_input5" >
						<INPUT TYPE="Text" NAME="TXT_FROMMONTH" ID="TXT_FROMMONTH"   SIZE=3 MAXLENGTH=2 class="txt_input5" >
						<INPUT TYPE="Text" NAME="TXT_FROMYEAR"  ID="TXT_FROMYEAR"    SIZE=4 MAXLENGTH=4 class="txt_input5" ONBLUR="chkstartdate(document.Form1.TXT_FROMDATE,document.Form1.TXT_FROMMONTH,document.Form1.TXT_FROMYEAR);checksettlementdate(document.Form1.TXT_FROMDATE,document.Form1.TXT_FROMMONTH,document.Form1.TXT_FROMYEAR);"  >
						
					</td>
					<td style = "width: 60px;">
						<INPUT TYPE = "HIDDEN" NAME = "VAL_TXT_FROMDATE" ID = "VAL_TXT_FROMDATE" />
					</td>
					<td style = "width: 120px;">
						
						<!--<input class = "but_input" type = "button" id = "BUT_VIEW_ALL" name = "BUT_VIEW_ALL" value = "View All" style = "width: 80px;" onclick="fn_veiwall()"/>-->
					</td>
					<td style = "width: 200px;"> To Date 
					</td>
					   
					<td>
                        <INPUT TYPE="Text" NAME="TXT_TODATE"  ID="TXT_TODATE"    SIZE=3 MAXLENGTH=2 class="txt_input5" >
						<INPUT TYPE="Text" NAME="TXT_TOMONTH" ID="TXT_TOMONTH"   SIZE=3 MAXLENGTH=2 class="txt_input5" >
						<INPUT TYPE="Text" NAME="TXT_TOYEAR"  ID="TXT_TOYEAR"    SIZE=4 MAXLENGTH=4 class="txt_input5" ONBLUR="chkstartdate(document.Form1.TXT_TODATE,document.Form1.TXT_TOMONTH,document.Form1.TXT_TOYEAR);checksettlementdate(document.Form1.TXT_TODATE,document.Form1.TXT_TOMONTH,document.Form1.TXT_TOYEAR);"  >
						<INPUT TYPE = "HIDDEN" NAME = "VAL_TXT_DATE" ID = "VAL_TXT_DATE" />						
					</td>
				</tr>
				
				<tr>
					<td style = "width: 200px;"><div id = "DIV_TXT_CLIENT_MANAGER">Client Manager Code</div></td>
					<td><input class = "txt_input" type = "text" id = "TXT_CLIENT_MANAGER" name = "TXT_CLIENT_MANAGER" maxlength = "15" style = "width: 125px;" />
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
									
								</td>
								<td style = "width: 200px;"><div id = "txt_broker_full_name">Broker Full Name</div></td>
								<td>
									<input class = "txt_input" type = "text" id = "txt_broker_full_name" name = "txt_broker_full_name" style = "width: 250px;" disabled = "disabled" />
								</td>
							</tr> 
							
								<tr>
							<td style = "width: 200px;"><div id = "div_txt_security_code">Security Code</div></td>
							<td><input class = "txt_input" type = "text" id = "txt_security_code" name = "txt_security_code" maxlength = "15" style = "width: 125px;" />
							</td>
							<td style = "width: 60px;">
								<input class = "but_input" type = "button" id = "BUT_HELP_SECURITY_MAIN" name = "BUT_HELP_SECURITY_MAIN" value = "..." onclick="view_security_help(0);" />
								
								<td style = "width: 120px;">
									<input class = "but_input" type = "button" id = "BUT_SEARCH" name = "BUT_SEARCH" value = "Search" style = "width: 80px;" onclick="loadGridReceiptsAppove();"/>
								</td>
								<td style = "width: 200px;"><div id = "txt_security_full_name">Security Name</div></td>
								<td>
									<input class = "txt_input" type = "text" id = "txt_security_full_name" name = "txt_security_full_name" style = "width: 250px;" disabled = "disabled" />
								</td>
							</tr>
							
						</table>	
						
						
						
						
						<BR>	
						
						<div id = "DIV_CLIENT_RECEIPT">
							<table id = "TABLE_REBATE_MAIN"></table>
							<div id = "DIV_PAGER_TABLE_REBATE_MAIN"></div>
							
						</div>
						
						
					</form>		
					
				</body>		
			</html>
			
