<%@page import="net.sasianet.ADLMARGIN.*" %>
<%	
	ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
	String m_jsp_client_url=m_sn_methods.jsp_client_url;
	
	//***************  ADDED BY KANISHKA ON 26/12/2012  *********************//
	
		Object done = (String)session.getValue("logon.isDone");  // marker object
		if (done == null) {
			response.sendRedirect("login.jsp");
			return;
			}
	
	//*************** ADDED BY KANISHKA ON 26/12/2012 [END]  *********************//
	

	out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
	out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/redmond/jquery-ui.css' TYPE=\"text/css\">");
	
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
	out.println("<script language1.2 = \"JavaScript\" src = \""+m_jsp_client_url+"/user_rights_data_gateway.js \"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/js/i18n/grid.locale-en.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/js/jquery.jqGrid.min.js\"></script>");
	out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\""+m_jsp_client_url+"/css/ui.jqgrid.css\" />");
	
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
	<HEAD>
		<TITLE>System Administration - User Lending Limit Master</TITLE>
		<!-- 
		<script type="text/javascript" src='http://www.netfac.lk/SNET/jquery/fancybox/jquery-1.4.1.min.js'></script>
		<script type="text/javascript" src='http://www.netfac.lk/SNET/jquery/fancybox/jquery.fancybox-1.3.0.pack.js'></script>
		<script language1.2 = "JavaScript" src = "http://www.netfac.lk/user_rights_data_gateway.js"></script>
		<link rel="stylesheet" href='http://www.netfac.lk/SNET/jquery/fancybox/jquery.fancybox-1.3.0.css'type='text/css' media="screen">
		<link rel="stylesheet" type="text/css" media="screen" href='http://www.netfac.lk/SNET/jquery/grid/themes/redmond/jquery-ui-1.7.1.custom.css' />
		<link rel="stylesheet" type="text/css" media="screen" href='http://www.netfac.lk/SNET/jquery/grid/themes/ui.jqgrid.css' />
		<script src='http://www.netfac.lk/SNET/jquery/grid/js/i18n/grid.locale-en.js' type="text/javascript"></script>
		
		<script src='http://www.netfac.lk/SNET/jquery/grid/js/jquery.jqGrid.min.js' type="text/javascript"></script>
		<link REL='STYLESHEET' HREF='http://www.netfac.lk/SNET/css/Asset_Financing_System.css' TYPE="text/css">
		-->
	</HEAD>
	<script type='text/javascript'>
			var m_sav_msg='';
			var m_xml_status="";
			var pro_id="";
			var g_sql_validations_type= 0;
			
			function loadGrid()
			{
				jQuery("#lending_limit_data").GridUnload("#lending_limit_data");
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=USER_LENDING_LIMIT&USER_ID="+document.Form1.TXT_USER_NAME.value;
				//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=m_get_grid";	
					jQuery("#lending_limit_data").jqGrid(
						{
							scroll: true,
							url:m_url,
							loadonce:1,
							datatype: "xml",
							colNames:['Product Code', 'Hidden Product Code2', 'Hidden Product Code',  'Product Name', 'Maximum Limit', 'Hidden Maximum Limit'],
							colModel:[ {name:'PRODUCT_CODE',index:'PRODUCT_CODE', width:130, align:"left",formatter:addProductFmatter},
								{name:'HID2_PRODUCT_CODE',index:'HID2_PRODUCT_CODE', width:130, hidden: true, align:"left",formatter:cellFomatterGetRow},
								{name:'HID_PRODUCT_CODE',index:'HID_PRODUCT_CODE', width:130, hidden: true, align:"left",formatter:cellFomatterHiddenProduct},
								{name:'PRODUCT_DESC',index:'PRODUCT_DESC', width:180, align:"left"},
								{name:'SCORE_LIMIT',index:'SCORE_LIMIT', width:120, align:"center",sortable:false,formatter:cellFomatterLendingLimitText,unformat:unformatNum},
								{name:'HID_SCORE_LIMIT',index:'HID_SCORE_LIMIT', width:120, align:"center",sortable:false,hidden: true}],
							mtype: "GET",
							rownumbers:true,
							rowNum:-1,
							gridview: true,
							sortname: 'PRODUCT_CODE',
							sortorder: 'desc',
							height: 'auto',
							loadComplete : loadCount,
							caption: 'User Lending Limit Details', 
							gridComplete: loadGrid_3
						}
					);
			}
			function loadGrid_3() {
				//m_url = 'http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_MAS_sql_validations?chksql=USER_LENDING_LIMIT_OTHER&USER_ID=' + $('[name=\'hid_user\']').val();
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=USER_LENDING_LIMIT_OTHER&USER_ID="+document.Form1.TXT_USER_NAME.value;
				jQuery('#other_limit_data').jqGrid({
						scroll      :   true,
						url         :   m_url,
						loadonce    :   1,
						datatype    :   'xml',
						colNames    :   [
							'Limit Name',
							'Amount'
						],
						colModel    :   [
							{   name: 'LIMIT_NAME',     index: 'LIMIT_NAME',    width: 270,     align: 'center',    sortable: false,    formatter: cellFomatterOtherLimitsName,     unformat: unformatNum   },
							{   name: 'AMOUNT',         index: 'AMOUNT',        width: 120,     align: 'center',    sortable: false,    formatter: cellFomatterOtherLimitsAmount,   unformat: unformatNum   }
						],
						mtype       :   'GET',
						rownumbers  :   true,
						rowNum      :   -1,
						gridview    :   true,
						height      :   'auto',
						loadComplete :  loadCount2,
						caption     :   'Other Lending Limit Details' 
					});
			}
			function cellFomatterOtherLimitsName(cellvalue, options, rowObject) {
				var m_count = rowObject.getAttribute('id');
				if (cellvalue == 'PAYMENT_LIMIT') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Payment Aprroval Limit</div>';
				}
				if (cellvalue == 'PAYMENT_ABOVE_AVAIL') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Payment Above Availability Limit</div>';
				}
				if (cellvalue == 'PAYMENT_ABOVE_LIMIT') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Payment Above Credit Limit</div>';
				}
				if (cellvalue == 'PAYMENT_SIG_1_LIMIT') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Payment 1st Signature Limit</div>';
				}
				if (cellvalue == 'PAYMENT_SIG_2_LIMIT') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Payment 2nd Signature Limit</div>';
				}
				if (cellvalue == 'INV_ADJ_LIMIT') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Invoice Adjustment Limit</div>';
				}
				if (cellvalue == 'CLI_ADJ_LIMIT') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Client Adjustment Limit</div>';
				}
				if (cellvalue == 'INV_TRN_LIMIT') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Invoice Transfer Limit</div>';
				}
				if (cellvalue == 'INV_REASSIGN_LIMIT') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Invoice Reassignment Limit</div>';
				}
				if (cellvalue == 'INV_RE_CANCEL_LIMIT') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Invoice Reassignment Cancellation Limit</div>';
				}
				if (cellvalue == 'RECEIPT_TRN_LIMIT') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Receipt Transfer Limit</div>';
				}
				if (cellvalue == 'INV_DATE_ADJ_LIMIT') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Invoice Date Adjustment Approval Limit</div>';
				}
				if (cellvalue == 'CREDIT_PERIOD_LIMIT') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Credit/Grace Period Approval Limit</div>';
				}
				if (cellvalue == 'INV_DUE_DATE_LIMIT') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Invoice Due Dates Approval Limit</div>';
				}
				if (cellvalue == 'RECE_CASH_ADJ_LIMIT') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Receipt Cash Adjustment Approval Limit</div>';
				}
				if (cellvalue == 'NON_CASH_ADJ_LIMIT') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Factors Non Cash Adjustment Approval Limit</div>';
				}
				if (cellvalue == 'RETURN_CH_REAS_LIMIT') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Return Cheque Reassignments Approval Limit</div>';
				}
				if (cellvalue == 'INV_CANCEL_LIMIT') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Invoice Cancellation Approval Limit</div>';
				}
				if (cellvalue == 'INV_NO_LIMIT') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Invoice Number Adjustment Approval Limit</div>';
				}
				if (cellvalue == 'DISPUTE_LIMIT_LIMIT') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Add/Remove Disputes Approval Limit</div>';
				}
				if (cellvalue == 'INV_APPROVAL') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Invoice Approval Limit</div>';
				}
				if (cellvalue == 'INV_CONFIRM') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Invoice Confirmation Limit</div>';
				}
				if (cellvalue == 'CHQ_CONFIRM') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">Cheque Confirmation Limit</div>';
				}
				if (cellvalue == 'CAM_INV_APP') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">CAM Invoice Approval Limit</div>';
				}
				if (cellvalue == 'CAM_PAYMENT_APP') {
					cellvalue = '' +
						'<input type = "hidden" id = "TXT_LIMIT_CODE_'+m_count+'" name = "TXT_LIMIT_CODE_'+m_count+'" value = "' + cellvalue + '" />' +
						'<div style = "width: 250px; text-align: left;">CAM Payment Approval Limit</div>';
				}
				return cellvalue;
			}
			function cellFomatterOtherLimitsAmount(cellvalue, options, rowObject) {
				var m_count = rowObject.getAttribute('id');
				cellvalue = format_noobject0(cellvalue, 2);
				cellvalue = '<input class = "txt_input" type = "text" id = "TXT_OTHER_LIMIT_'+m_count+'" name = "TXT_OTHER_LIMIT_'+m_count+'" value = "' + cellvalue + '" maxlength = "24" style = "width: 110px; text-align: right;" onBlur = "validateNumber(this, 0, 9999999999999999.99, 2, \'number\');" />'
					return cellvalue;
			}
			function loadCount2(){
				var rec_count=$("#other_limit_data").jqGrid('getGridParam',"records");
				document.Form1.hid_other_limits_row_count.value=rec_count;
			}
			function loadGrid_4() {
				//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=USER_LENDING_LIMIT&USER_ID="+document.Form1.hid_user.value;
				m_url = servlet_client_url+":"+client_t3_port+"/"+client_name+"FA_MAS_sql_validations?chksql=USER_LENDING_LIMIT_PAYMENT_SIGNATORY_CLASS&USER_ID=" +document.Form1.TXT_USER_NAME.value;
				jQuery('#payment_signature_limit_data').jqGrid({
						url         :   m_url,
						loadonce    :   1,
						datatype    :   'xml',
						colNames    :   [
							'Signatory Class Code',
							'Description'
						],
						colModel    :   [
							{   name: 'CLASS_CODE',         index: 'CLASS_CODE',            width: 200,     align: 'left',    sortable: false,    formatter: cellFomatterSignatoryCode,           unformat: unformatNum   },
							{   name: 'CLASS_DESCRIPTION',  index: 'CLASS_DESCRIPTION',     width: 250,     align: 'left',    sortable: false,    formatter: cellFomatterSignatoryDescription,    unformat: unformatNum   }
						],
						mtype       :   'GET',
						rownumbers  :   true,
						rowNum      :   -1,
						gridview    :   true,
						height      :   'auto',
						gridComplete:   function () {
							init_fancybox();
							$('#TXT_SIGNATORY_CLASS_CODE').blur(function (event) {
									if ($(event.target).val().length > 0) {;
										strTrim(event.target);
										g_sql_validations_type = 1;
										m_url = 'http://www.netfac.lk:8080/myserver/servlet/NETFAC_AF_MAS_sql_validations1?chksql=m_prime_chk_NETFAC_AF_MAS_SIGNATORY_CLASS_CODE&signatory_class_code=' + $(event.target).val() + '&sql_query_type=EDIT';
										load_interface(m_url, 'XML');
									}
									else {
										$('#div_signatory_class_description').empty();
									}
								});
						},
						caption     :   'Signatory Class'
					});
			}
			function cellFomatterSignatoryCode(cellvalue, options, rowObject) {
				if ((cellvalue == undefined) || (cellvalue == 'null')) {
					cellvalue = '';
				}
				cellvalue = '' +
					'<input class = "txt_input" type = "text" id = "TXT_SIGNATORY_CLASS_CODE" name = "TXT_SIGNATORY_CLASS_CODE" maxlength = "15" value = "' + cellvalue + '" style = "width: 150px;" />' +
					'<input class = "but_input" type = "button" name = "BUT_HELP_SIGNATORY" value = "..." onclick = "help_update_signatory(\'help_update_signatory\');" />' +
					'<a onclick = "help_update_signatory(\'help_update_signatory\');" style = "text-decoration: none; cursor: text;" id = "help_update_signatory" class = "fancylink iframe" href = ""> </a>' +
					'';
				return cellvalue;
			}
			function cellFomatterSignatoryDescription(cellvalue, options, rowObject) {
				if ((cellvalue == undefined) || (cellvalue == 'null')) {
					cellvalue = '';
				}
				cellvalue = '<div id = "div_signatory_class_description">' + cellvalue + '</div>';
				return cellvalue;
			}
			function help_update_signatory(link_id) {
				if (!isOpen){
					isOpen = true;
					document.Form1.hid_help_type.value = '2';
					m_sql = 'm_help_TXT_SIGNATORY_CLASS_CODE_sql';
					m_criteria = document.Form1.TXT_SIGNATORY_CLASS_CODE.value + '@' + 'Y@';
					HelpBox('1', '10', '0', link_id);
				}
			}
			function get_vector(data_vec) {
				if (g_sql_validations_type == 1) {
					if (data_vec.length > 0) {
						$('#TXT_SIGNATORY_CLASS_CODE').val(data_vec[0]);
						$('#div_signatory_class_description').text(data_vec[1]);
					}
					else {
						help_update_signatory('help_update_signatory');
					}
				}
			}
			function load_rights(){
				check_user_rights('NETFAC_FA_MAS_User_Lending_Limit','NETFACALL','SNET');
			}
			
			function loadCount(){
				var rec_count=$("#lending_limit_data").jqGrid('getGridParam',"records");
				document.Form1.hid_row_count.value=rec_count;
				document.Form1.hid_grid_row_count.value=rec_count;
			}
			function cellFomatterLendingLimitText (cellvalue, options, rowObject){
				if (m_xml_status=="arr"){
					var grid_count = document.Form1.hid_grid_row_count.value;
					var texts = "<input class='txt_input' type='text' id='TXT_LENDING_LIMIT_"+grid_count+"' name='TXT_LENDING_LIMIT_"+grid_count+"' value='0.00' style='width:100px; text-align:right' maxlength='24'  onblur='validateNumber(this, 0, 9999999999999999.99, 2,\"number\");' />";
				}
				else{
					var row_id=rowObject.getAttribute('id');
					var texts = "<input class='txt_input' type='text' id='TXT_LENDING_LIMIT_"+pro_id+"' name='TXT_LENDING_LIMIT_"+pro_id+"' value='"+cellvalue+"' style='width:100px; text-align:right' maxlength='24'  onblur='validateNumber(this, 0, 9999999999999999.99, 2,\"number\");' />";
				}
				return texts;
			}
			function addProductFmatter (cellvalue, options, rowObject)
			{
				if (m_xml_status=="arr"){;
					return cellvalue;
				}
				chk="CHK_APP_PRODUCT_"+cellvalue;
				document.Form1.elements[chk].checked=true;
				return cellvalue;
			}
			function cellFomatterHiddenProduct(cellvalue, options, rowObject){
				if (m_xml_status=="arr"){
					var grid_count = document.Form1.hid_grid_row_count.value;
					var texts = "<input type='HIDDEN' id='HID_PRODUCT_CODE_"+grid_count+"' name='HID_PRODUCT_CODE_"+grid_count+"' value='"+cellvalue+"' style='width:150' maxlength='200' />";
				}
				else{
					var row_id=rowObject.getAttribute('id');
					var texts = "<input type='HIDDEN' id='HID_PRODUCT_CODE_"+pro_id+"' name='HID_PRODUCT_CODE_"+pro_id+"' value='"+cellvalue+"' style='width:150' maxlength='200' />";
				}
				return texts;
			}
			function cellFomatterGetRow (cellvalue, options, rowObject){
				if (m_xml_status!="arr"){
					pro_id=cellvalue;
				}
			}
			function unformatNum ( cellvalue, options, cellobject)
			{
				return cellvalue;
			}
			function loadGrid_2(){
				jQuery("#product_detail_data").GridUnload("#product_detail_data");
				//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=USER_LENDING_LIMIT&USER_ID="+document.Form1.hid_user.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=PRODUCT_LENDING_LIMIT&USER_ID="+document.Form1.TXT_USER_NAME.value;
					jQuery("#product_detail_data").jqGrid(
						{
							scroll: true,
							url:m_url,
							datatype: "xml",
							colNames:['Product Code', 'Hidden Product Code', 'Product Name',  'Applicable'],
							colModel:[ {name:'FA_PRODUCT_CODE',index:'FA_PRODUCT_CODE', width:130, align:"left"},
								{name:'HID_FA_PRODUCT_CODE',index:'HID_FA_PRODUCT_CODE', width:130, hidden: true, align:"left"},
								{name:'FA_PRODUCT_DESC',index:'FA_PRODUCT_DESC', width:180, align:"left"},
								{name:'APPROVE',index:'APPROVE', width:80, align:"center",sortable:false,formatter:cellFomatterApprove2}],
							mtype: "GET",
							rownumbers:true,
							rowNum:100,
							gridview: true,
							sortname: 'FA_PRODUCT_CODE',
							sortorder: 'desc',
							height: 'auto',
							caption: 'Product Details',
							gridComplete: loadGrid
						}
					);
			}
			function cellFomatterApprove2 (cellvalue, options, rowObject){
				var row_id=rowObject.getAttribute('id');
				var checkbox ='<input type="checkbox" onclick="add_to_user_limits(\''+cellvalue+'\')" value="'+cellvalue+'" name="CHK_APP_PRODUCT_'+cellvalue+'"  id="CHK_APP_PRODUCT_'+cellvalue+'">'; 
				return checkbox;
			}
			function add_to_user_limits(row) {
				m_xml_status="arr";
				chk="CHK_APP_PRODUCT_"+row;
				var ret = jQuery("#product_detail_data").jqGrid('getRowData',row);
				if(document.Form1.elements[chk].checked==false){
					delete_from_user_limit_grid(document.Form1.elements[chk].value) 
				}
				if(document.Form1.elements[chk].checked==true){
					add_to_user_limit_grid(document.Form1.elements[chk].value,ret.FA_PRODUCT_DESC)
				}
			}
			function add_to_user_limit_grid(product,description) {
				var value_arr = new Array();
				value_arr['PRODUCT_CODE'] = product;
				value_arr['PRODUCT_DESC'] = description;
				value_arr['HID_PRODUCT_CODE'] = product;
				document.Form1.hid_grid_row_count.value = parseInt(document.Form1.hid_grid_row_count.value)+1;
				//alert('xxx'+'product'+product+'value_arr'+value_arr);
				var suc=jQuery("#lending_limit_data").jqGrid('addRowData',product,value_arr);
				
			}
			function delete_from_user_limit_grid(product) {
				document.Form1.hid_grid_row_count.value = parseInt(document.Form1.hid_grid_row_count.value)-1;
				jQuery("#lending_limit_data").jqGrid('delRowData',product);
			}
			function validate(){	
				for(k=1;k<=document.Form1.hid_row_count.value;k++){
					if(document.Form1.elements["CHK_APP_"+k].checked==true){
						return true;
					}
				}
			}
			function validate_data(){
				if(document.Form1.TXT_USER_NAME.value=="" ){  
					alert('Please enter a username.');
					return false;
				}
				else{
					return true;
				}
			}
			function set_grid_to_hidden() {
				var rec_count=$("#lending_limit_data").jqGrid('getGridParam',"records");
				document.Form1.hid_row_count.value=rec_count;
				var ids = jQuery("#lending_limit_data").jqGrid('getDataIDs')
				var ids2 = ["test"];
				var ids3 = ids2.concat(ids);
				for (var i = 1; i <= ids3.length; i++) {
					var content = '<input type="hidden" name="TXT_PRO_ID_'+i+'" value="'+ids3[i]+'">'
					document.getElementById('hid_screen').innerHTML=document.getElementById('hid_screen').innerHTML+content
				}
			}
			function before_submit()
		    { 
				//get_display_msg();
				if(validate_data()){
					if(confirm("Are you sure you want to "+m_sav_msg+" ?")){ 
						for (var i=0; i < document.Form1.elements.length; i++ ) {
							document.Form1.elements[i].disabled=false;
						}
						if(validate_data()){
							document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"FA_MAS_Save_User_Lending_Limit";
							document.Form1.submit();
						}
					}
				}
			} 
	
			function save_window(){	
				before_submit();
			}
			function load_help_msg() {
				m_help_message = "m_help_msg_NETFAC_FA_MAS_USER_LENDING_LIMIT";
				HelpBox_msg(m_help_message);
			}
			function HelpBox_msg(m_help_message) {
				popupwin = window.showModalDialog(servlet_client_url+":"+client_t3_port+"/"+client_name+"AF_MAS_Help_Msg_Servlet?class_in="+client_name+"FA_MAS_Help_Msg_select"+
					"&help_message_in="+m_help_message);
			}
			function load_roll_value(m_val){
				document.getElementById('help_box').innerHTML="  System Administration - User Lending Limit Master- "+m_val;
			}
			function load_roll_out_value(){
				document.getElementById('help_box').innerHTML="  System Administration - User Lending Limit Master- "+document.Form1.hid_status.value;
			}
			function load_screen_status(m_val){
				if(m_val=="NEW"){
					new_window();
				}
				else if(m_val=="HELP"){
					load_help_msg();
				}
				document.Form1.SCREEN_NAME.value=m_val;
				if(m_val=="NEW"){
					document.Form1.hid_status.value="New";
				}
				else if(m_val=="EDIT"){
					document.Form1.hid_status.value="Edit";
				}
				else if(m_val=="DACT"){
					document.Form1.hid_status.value="Deactivate";
				}
				else if(m_val=="RACT"){
					document.Form1.hid_status.value="Reactivate";
				}
				else{
					document.Form1.hid_status.value="";
				}
			}
			/* commented out 2011-10-12
			function get_display_msg(){
				if(document.Form1.SCREEN_NAME.value=="NEW"){
					m_sav_msg="Save";
				}
				else if(document.Form1.SCREEN_NAME.value=="EDIT"){
					m_sav_msg="Modify";
				}
				else if(document.Form1.SCREEN_NAME.value=="DACT"){
					m_sav_msg="Deactivate";
				}
				else if(document.Form1.SCREEN_NAME.value=="RACT"){
					m_sav_msg="Reactivate";
				}
				else{
					m_sav_msg="";
				}
			}
			function MyDialog(){
				this.valout   = new Array(10);
			}
		    end 2011-10-12
		  */
			/*
			$(document).ready(function() { 
					//init_fancybox();
				});
			*/

			
		
		function clearAll()
		{
			top.frames[1].location.href = jsp_client_url + "/User_Lending_Limit.jsp";
		}
		
		
		function exit()
		{
			top.frames[1].location.href = jsp_client_url + "/low.jsp";
		}	
		
		
		function exuser_help(m_strat)
		{
			
			var aForm;    //  aForm =oForm.elements;
			aForm =  document.getElementById('Form1');
			/*  var myObject = new Object();
			myObject.firstName = aForm.oFirstName.value;
			myObject.lastName = aForm.oLastName.value;
			*/
			
			var myObject=new Array(); //return values set to this object
			myObject[0]=aForm.TXT_USER_NAME; //2011-09-27
			//myObject[1]=aForm.Text_loc_desc;;
			myObject[1]=null;
			myObject[2]=null;
			myObject[3]=null;
			myObject[4]=null;
			
			var myObject_value=new Array(); //passing values set to this object
			//myObject_value[0]=aForm.TXT_UNAME.value; //2011-09-27
			myObject_value[0]=aForm.TXT_USER_NAME.value; //2011-09-27
			myObject_value[1]=null;//aForm.Text_loc_code.value;
			myObject_value[2]=null;
			myObject_value[3]=null;
			myObject_value[4]=null;
			
			
			var myObject_type=new Array(); //passing values data type
			//myObject_type[0]="StringL";
			myObject_type[0]="StringL";
			//myObject_type[1]="StringL";
			myObject_type[1]=null;
			myObject_type[2]=null;
			myObject_type[3]=null;
			myObject_type[4]=null;
			
	
			var qid=73;

			title_name='Users';
			var url = 'popup.jsp';
			var close_fun='user_help_close';			
			var json_text = JSON.stringify(myObject_value, null,0);
			var json_obj_type_text=JSON.stringify(myObject_type, null,0);
			var fn_name=arguments.callee.name;
				if(fn_name==undefined)
				{
					re = /^function\s+([^(]+)/;
       				fn_name=re.exec(arguments.callee.toString())[1];
				}
				$.showModalDialog({
					url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
					dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
					height:400,// 500,
					width: 500,//900,
					title: 'SasiNet Frame Work',
					scrollable: true,
					onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); 
						if(returnedValue != null){
							//
							//aForm.TXT_USER_NAME.focus();
							m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=PRODUCT_LENDING_LIMIT&USER_ID="+document.Form1.TXT_USER_NAME.value;
							loadGrid_2();
						}
						if(returnedValue == null){
							user_help_close();
						} 
					} //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
		}

		
		function user_help_close()
		{
			document.Form1.reset();	
		}
		
	</script>
	<BODY class='body & txt-body' leftmargin='0' topmargin='0' marginwidth='0' > <!-- load_lock(),load_rights() -->
		<FORM NAME='Form1' id='Form1' method='post'>
			<input  type='hidden' value='NEW' name='SCREEN_NAME'> 
			<INPUT TYPE='Hidden' NAME='hid_help_type' VALUE="">
			<INPUT TYPE='Hidden' NAME='hid_status' VALUE="New">
			<INPUT TYPE='Hidden' NAME='hid_display_client' VALUE="99">
			<INPUT TYPE='Hidden' NAME='product_count' VALUE="0">
			<INPUT TYPE='Hidden' NAME='hid_user' VALUE="">
			<INPUT TYPE='Hidden' NAME='hid_row_count' VALUE="">
			<INPUT TYPE='Hidden' NAME='hid_grid_row_count' VALUE=0>
			<INPUT TYPE='Hidden' NAME='hid_other_limits_row_count' VALUE=0>
			
					<table width='100%' class=table border='0' cellspacing='0' cellpadding='0'>
					<tr>
					<td width='8' valign='top'></td>
					<td  valign='top'> <!-- class='border_wht' --> 
						
						
								<table class='table' align='center' width="99%" border="0" cellpadding="0" cellspacing="0" >
								<tr>
									<td height='7'></td>
								</tr>
								<tr height="30">		
									<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
									<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Administration - System Maintenance</B></td>
									<td width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>
								</tr>
								</table>
						
								<table class='table' align='center' width="99%" border="0" cellpadding="2" cellspacing="0" >
								<tr>
								<td width="33%" class="hh1"  align="right" >
									<B> </B>
								</td>	
								<td width="6%">
									<input type="button" value="Save" onclick="before_submit()" class="mainbut">	
								</td>	
								<td width="6%">
									<input type="button" value="Cancel" onclick="clearAll()" class="mainbut">	
								</td>	
								<td width="6%">
									<input type="button" value="Exit" onclick="exit()" class="mainbut">	
								</td>
								<td width="*%" class="hh1"  align="right" >
									<B>User Lending Limit</B>
								</td>	
								</tr>
								</table>	
						
						
						
						
						
								<table class='table' width='100%' border='0' cellspacing='0' cellpadding='0' height='100%'>
							    <tr> 
								     <td height='1'></td>
							    </tr>
							    <tr>
								<td>
									<table class='table' border='0' cellpadding='0' cellspacing='0' height='100%' width='100%'>   
									<tr>
									<td class='pdn_txtpos' height='150' valign='top'>
									<br ><br/>
												<table align='center' width='100%' class='table'>
													<tr>
														<td width='10%' ><DIV id='DIV_TXT_USER_NAME'  class=div_input>Username *</DIV></td>	
														<td width='*%' ><input class='txt_input' type='text' name='TXT_USER_NAME' maxlength='10' size='10'  style='width:180px;' onblur="exuser_help(0)">
															<input class='but_input' type='button' name='BUT_HELP_MAIN_1' value="Help" onClick="exuser_help(0)"></td>
														<!-- <td width='*%'></td> -->
													</tr>
												</table>
									<br><br/>
									<div>
												<table align='center' width='100%' class='table'>
													<tr>
														<td valign="top" width='50%'>
															<table id="product_detail_data"></table>
														</td>
														<td valign="top" width='*%'>
															<table id="lending_limit_data"></table>
														</td>
													</tr>
												</table>	
									</div>
									<br />
									<div>
												<table align='center' width='100%' class='table'>
													<tr>
														<td valign="top" width='50%'>
															
															<table id="other_limit_data"></table>
														</td>
														<td valign="top" width='*%'>
															<table id="payment_signature_limit_data"></table>
														</td>
													</tr>
												</table>
									</div>
									<div id="hid_screen">
									</div>
									</td>
									</tr>
									</table>	
								</td>
								</tr>
								</table>
					</td>
					</tr>
					</table>	
		
	</form>
	<SCRIPT language1.2='JavaScript' src='validate.js'></SCRIPT>
	<!--  <SCRIPT language1.2='JavaScript' src='factoring_drill_down.js'></SCRIPT> -->
	 <SCRIPT language1.2='JavaScript' src='ajax_data_gateway.js'></SCRIPT> 
</body>
		</html>
		
	</html>
	
	
	
	
