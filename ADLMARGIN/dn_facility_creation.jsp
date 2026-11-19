<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Calendar" %>
<%@page import="java.util.Date" %>
<%@page import="net.sasianet.ADLMARGIN.*" %>

<%!
	
	
	ADLMARGIN_MGT_conn_methods m_sn_methods;
	
	Connection connection;
	Statement statement;
	ResultSet resultSet;
	String sql;
	
	String jsp_client_url;
	String client_name;
	String schema_name;
	
	String sysdate;
	
	StringBuffer business_entities;
	StringBuffer address_types;
	StringBuffer ownership_types;
	StringBuffer title_types;
	StringBuffer identification_types;
	StringBuffer employee_types;
	StringBuffer designation_types;
	StringBuffer association_types;
	StringBuffer account_types;
	StringBuffer facility_types;
	String m_jsp_client_url;
	
%>

<%
	
	session             = request.getSession(true);
	m_sn_methods        = new ADLMARGIN_MGT_conn_methods(session);
	jsp_client_url      = m_sn_methods.jsp_client_url;
	client_name         = m_sn_methods.client_name;
	schema_name         = m_sn_methods.schema_name;
	
	//***************  ADDED BY KANISHKA ON 26/12/2012  *********************//
	
		Object done = (String)session.getValue("logon.isDone");  // marker object
		if (done == null) {
			response.sendRedirect("login.jsp");
			return;
			}
	
	//*************** ADDED BY KANISHKA ON 26/12/2012 [END]  *********************//
	
	connection          = m_sn_methods.met_user_validate();
	m_jsp_client_url    = m_sn_methods.jsp_client_url;
	
	
	/* Get The Sysdate */
	sql = " " +
		"   SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY') SYSTEM_DATE " +
		"   FROM   DUAL " +
		" ";
	
	statement = connection.createStatement();
	resultSet = statement.executeQuery(sql);
	while (resultSet.next()) {
		sysdate = resultSet.getString("SYSTEM_DATE");
	}
	resultSet.close();
	statement.close();
	
	
	/* Put Business Entities Into A String Buffer */
	sql = " " +
		"   SELECT A.CAT_TYPE_CODE, " +
		"          A.DESCRIPTION " +
		"   FROM   " + schema_name + ".DN_REF_CUSTOMER_CATEGORY A " +
		"   WHERE  A.DEFAULT_VALUE = 'C' " +
		"   AND    A.ACTIVE_STATUS = 'Y' " +
		"   ORDER BY A.DESCRIPTION " +
		" ";
	
	statement = connection.createStatement();
	resultSet = statement.executeQuery(sql);
	business_entities = new StringBuffer();
	while(resultSet.next()) {
		business_entities.append("<option value=\"" + resultSet.getString("CAT_TYPE_CODE") + "\">" + resultSet.getString("DESCRIPTION") + "</option>");
	}
	resultSet.close();
	statement.close();
	
	
	/* Put Address Types Into A String Buffer */
	sql = " " +
		"   SELECT A.ADD_TYPE_CODE, " +
		"          A.ADD_TYPE_DESC " +
		"   FROM   " + schema_name + ".FA_CO_MAS_ADDRSS_TYPE A " +
		"   WHERE  A.ACTIVE_STATUS = 'Y' " +
		"   ORDER BY A.ADD_TYPE_DESC " +
		" ";
	
	statement = connection.createStatement();
	resultSet = statement.executeQuery(sql);
	address_types = new StringBuffer();
	while(resultSet.next()) {
		address_types.append("<option value=\"" + resultSet.getString("ADD_TYPE_CODE") + "\">" + resultSet.getString("ADD_TYPE_DESC") + "</option>");
	}
	resultSet.close();
	statement.close();
	
	
	/* Put Ownership Types Into A String Buffer */
	sql = " " +
		"   SELECT A.OWNERSHIP_TYPE, " +
		"          A.OWNERSHIP_DESC " +
		"   FROM   " + schema_name + ".FA_CO_OWNERSHIP A " +
		"   WHERE  A.ACTIVE_STATUS = 'Y' " +
		"   ORDER BY A.OWNERSHIP_DESC " +
		" ";
	
	statement = connection.createStatement();
	resultSet = statement.executeQuery(sql);
	ownership_types = new StringBuffer();
	while(resultSet.next()) {
		ownership_types.append("<option value=\"" + resultSet.getString("OWNERSHIP_TYPE") + "\">" + resultSet.getString("OWNERSHIP_DESC") + "</option>");
	}
	resultSet.close();
	statement.close();
	
	
	/* Put Title Types Into A String Buffer */
	sql = " " +
		"   SELECT A.TITLE_TYPE, " +
		"          A.TITLE_DESC " +
		"   FROM   " + schema_name + ".AF_MK_MAS_TITLES A " +
		"   WHERE  A.ACTIVE_STATUS = 'Y' " +
		"   ORDER BY A.TITLE_DESC " +
		" ";
	
	statement = connection.createStatement();
	resultSet = statement.executeQuery(sql);
	title_types = new StringBuffer();
	while(resultSet.next()) {
		title_types.append("<option value=\"" + resultSet.getString("TITLE_TYPE") + "\">" + resultSet.getString("TITLE_DESC") + "</option>");
	}
	resultSet.close();
	statement.close();
	
	
	/* Put Identification Types Into A String Buffer */
	sql = " " +
		"   SELECT A.CLI_ID_TYPE, " +
		"          A.CLI_ID_DESC " +
		"   FROM   " + schema_name + ".FA_CO_MAS_CLIENT_ID_TYPE A " +
		"   WHERE  A.ACTIVE_STATUS = 'Y' " +
		"   ORDER BY A.CLI_ID_DESC " +
		" ";
	
	statement = connection.createStatement();
	resultSet = statement.executeQuery(sql);
	identification_types = new StringBuffer();
	while(resultSet.next()) {
		identification_types.append("<option value=\"" + resultSet.getString("CLI_ID_TYPE") + "\">" + resultSet.getString("CLI_ID_DESC") + "</option>");
	}
	resultSet.close();
	statement.close();
	
	
	/* Put Employee Types Into A String Buffer */
	sql = " " +
		"   SELECT A.EMPLOYEE_TYPE, " +
		"          A.DESCRIPTION " +
		"   FROM   " + schema_name + ".AF_CO_MAS_EMPLOYEE_TYPES A " +
		"   WHERE  A.ACTIVE_STATUS = 'Y' " +
		"   ORDER BY A.DESCRIPTION " +
		" ";
	
	statement = connection.createStatement();
	resultSet = statement.executeQuery(sql);
	employee_types = new StringBuffer();
	while(resultSet.next()) {
		employee_types.append("<option value=\"" + resultSet.getString("EMPLOYEE_TYPE") + "\">" + resultSet.getString("DESCRIPTION") + "</option>");
	}
	resultSet.close();
	statement.close();
	
	
	/* Put Designation Types Into A String Buffer */
	sql = " " +
		"   SELECT A.DESIG_CODE, " +
		"          A.DESIGNATION " +
		"   FROM   " + schema_name + ".DN_REF_DESIGNATION A " +
		"   WHERE  A.ACTIVE_STATUS = 'Y' " +
		"   ORDER BY A.DESIGNATION " +
		" ";
	
	statement = connection.createStatement();
	resultSet = statement.executeQuery(sql);
	designation_types = new StringBuffer();
	while(resultSet.next()) {
		designation_types.append("<option value=\"" + resultSet.getString("DESIG_CODE") + "\">" + resultSet.getString("DESIGNATION") + "</option>");
	}
	resultSet.close();
	statement.close();
	
	
	/* Put Association Types Into A String Buffer */
	sql = " " +
		"   SELECT A.ASSOC_TYPE_CODE, " +
		"          A.ASSOC_DESC " +
		"   FROM   " + schema_name + ".DN_REF_ASSOCIATION_TYPES A " +
		"   WHERE  A.ACTIVE_STATUS = 'Y' " +
		"   ORDER BY A.ASSOC_DESC " +
		" ";
	
	statement = connection.createStatement();
	resultSet = statement.executeQuery(sql);
	association_types = new StringBuffer();
	while(resultSet.next()) {
		association_types.append("<option value=\"" + resultSet.getString("ASSOC_TYPE_CODE") + "\">" + resultSet.getString("ASSOC_DESC") + "</option>");
	}
	resultSet.close();
	statement.close();
	
	
	/* Put Account Types Into A String Buffer */
	sql = " " +
		"   SELECT A.ACCOUNT_TYPE, " +
		"          A.DESCRIPTION " +
		"   FROM   " + schema_name + ".DN_REF_ACCOUNT_TYPES A " +
		"   WHERE  A.ACTIVE_STATUS = 'Y' " +
		"   ORDER BY A.DESCRIPTION " +
		" ";
	
	statement = connection.createStatement();
	resultSet = statement.executeQuery(sql);
	account_types = new StringBuffer();
	while(resultSet.next()) {
		account_types.append("<option value=\"" + resultSet.getString("ACCOUNT_TYPE") + "\">" + resultSet.getString("DESCRIPTION") + "</option>");
	}
	resultSet.close();
	statement.close();
	
	
	/* Put Facility Types Into A String Buffer */
	sql = " " +
		"   SELECT A.FACILITY_TYPE, " +
		"          A.DESCRIPTION " +
		"   FROM   " + schema_name + ".DN_REF_FACILITY_TYPES A " +
		"   WHERE  A.ACTIVE_STATUS = 'Y' " +
		"   ORDER BY A.DESCRIPTION " +
		" ";
	
	statement = connection.createStatement();
	resultSet = statement.executeQuery(sql);
	facility_types = new StringBuffer();
	while(resultSet.next()) {
		facility_types.append("<option value=\"" + resultSet.getString("FACILITY_TYPE") + "\">" + resultSet.getString("DESCRIPTION") + "</option>");
	}
	resultSet.close();
	statement.close();	
	
	
	String m_system_year  = sysdate.substring(6,10);
    String m_system_month = sysdate.substring(3,5);
    String m_system_date  = sysdate.substring(0,2);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Margin Trading</title>
		<meta name="generator" content="ModelWorks IDE" />
		<!--
		<script type="text/javascript" src="<%= jsp_client_url %>/js/jquery.min.js"></script>
		<script type="text/javascript" src="<%= jsp_client_url %>/js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="<%= jsp_client_url %>/SNET/jquery/fancybox/jquery.filestyle.pack.js"></script>
		<script type="text/javascript" src="<%= jsp_client_url %>/SNET/jquery/grid/4.1/js/i18n/grid.locale-en.js"></script>
		<script type="text/javascript" src="<%= jsp_client_url %>/SNET/jquery/grid/4.1/js/jquery.jqGrid.min.js"></script>
		<script type="text/javascript" src="<%= jsp_client_url %>/js/json2.js"></script>
		<script type="text/javascript" src="<%= jsp_client_url %>/js/popup.js"></script>
		<script type="text/javascript" src="validate.js"></script>
		<script type="text/javascript" src="validate_v1.js"></script>
		<script type="text/javascript" src="ajax_data_gateway.js"></script>
		
		<link rel="stylesheet" type="text/css" href="<%= jsp_client_url %>/css/Asset_Financing_System.css" />
		<link rel="stylesheet" type="text/css" href="<%= jsp_client_url %>/css/redmond/jquery-ui.css" media="screen" />
		-->
		
		
		<!-- -->
		<link REL='STYLESHEET' HREF='<%= jsp_client_url %>/css/Asset_Financing_System.css' TYPE="text/css">
		<link REL='STYLESHEET' HREF='<%= jsp_client_url %>/css/redmond/jquery-ui.css' TYPE="text/css">
		<link REL='STYLESHEET' HREF='<%= jsp_client_url %>/css/blue/style.css' TYPE="text/css">
		<script type="text/javascript" src="<%= jsp_client_url %>/js/jquery.min.js"></script>
		<script type="text/javascript" src="<%= jsp_client_url %>/js/jquery-ui.min.js"></script>
		
		<script type="text/javascript" src="<%= jsp_client_url %>/js/json2.js"></script>
		<script type="text/javascript" src="<%= jsp_client_url %>/js/popup.js"></script>
		<link REL='STYLESHEET' HREF='<%= jsp_client_url %>/SNET/jquery/grid/4.1/themes/ui.jqgrid.css' TYPE="text/css">
		<script type="text/javascript" src="<%= jsp_client_url %>/SNET/jquery/grid/4.1/js/i18n/grid.locale-en.js"></script>
		<script type="text/javascript" src="<%= jsp_client_url %>/SNET/jquery/grid/4.1/js/jquery.jqGrid.min.js"></script>
		
		<script type="text/javascript" src="validate.js"></script>
		<script type="text/javascript" src="validate_v1.js"></script>
		<script type="text/javascript" src="ajax_data_gateway.js"></script>
		
		<!-- -->
		
		<script type="text/javascript">
			
			var m_sav_msg      = '';
			var m_duplicate_report = 'false';
			var rpt_id         = '';
			var m_system_month = '<%=sysdate.substring(3,5)%>';
			var m_system_date  = '<%=sysdate.substring(0,2)%>';
			var m_system_year  = '<%=sysdate.substring(6,10)%>';
			var m_sysdate      = '<%=sysdate%>';
			var m_awplr        = '4.0';
			var m_tbill        = '5.0';
			var m_types_guarantor = '<option value = BOX>boxes</option><option value = G0001>Guarantee Type 1</option><option value = 001>test</option>';
			var m_types_title     = '<option value = HON>Hon</option><option value = MR>Mr</option><option value = MRS>Mrs</option><option value = MS>Ms</option><option value = PROF>Prof</option>';
			var m_types_address   = '<option value = AT003>Factory</option><option value = AT001>Home</option><option value = AT002>Office</option><option value = AT004>Registered</option>';
			var m_types_ownership = '<option value = RENT>On Rent</option><option value = OWN0002>Owned By Spouse</option><option value = OWN0001>Self Owned</option>';
			//var m_user = 'NETFACALL';
			var m_reset           = 'false';
			var g_str_facility_no = null;
			
			
			function saveData(){
				for (var i=0; i < document.Form1.elements.length; i++ ) {
					document.Form1.elements[i].disabled=false;
				}
				//document.Form1.action='http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_Save_client_facility_creation';
				//document.Form1.submit();
				document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"Save_client_facility_creation";
				document.Form1.submit();
				
				
			}
			
			/*
		function showFollowUpDialog(){
			if(document.Form1.SCREEN_NAME.value=="NEW"){
			} else if(document.Form1.SCREEN_NAME.value=="EDIT"){ 
			     if(document.Form1.hid_facility_status.value=="Y"){ 
			          document.Form1.hid_status_value.value = "FAC-EDIT"; 
			     } 
			 if (document.Form1.TXT_FACT_STATUS.value == "TERMINATED") { 
			          document.Form1.hid_status_value.value = "FAC-TERMINATE"; 
			 } 
			} 
			$("#divId").dialog("open");
			$("#modalIframeId").attr("src","http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_MAS_global_followup?screen_name=NETFAC_FA_CR_display_client_facility&ref_code="+document.Form1.TXT_ACC_CODE.value+"&check_status="+document.Form1.hid_status_value.value+"");
			return false;
		}
		*/	
			
			function get_added_report_data(debtor_count){
				var debtor_data_array =new Array();
				debtor_data_array[0]      = document.Form1.elements['TXT_RPT_ID_'+debtor_count].value;
				return debtor_data_array;
			}
			
			
			
			function clear_data(){
				document.Form1.TXT_FACILITY_NO.value="";
				document.Form1.TXT_ACC_CODE.value="";
				document.Form1.TXT_CLIENT_CODE.value="";
				document.Form1.TXT_CLIENT_NAME.value="";
				document.Form1.TXT_CLIENT_MMGR.value="";
				document.Form1.TXT_FACILITY_MANAGER.value="";
				document.Form1.TXT_FACILITY_MANAGER_NAME.value="";
				document.Form1.TXT_EXT_FACILITY_NO.value="";
				document.Form1.TXT_FACT_STATUS.value="";
				document.Form1.TXT_START_DD.value=m_system_date;
				document.Form1.TXT_START_MM.value=m_system_month;
				document.Form1.TXT_START_YY.value=m_system_year;
				document.Form1.TXT_REVIEW_DD.value=m_system_date;
				document.Form1.TXT_REVIEW_MM.value=m_system_month;
				document.Form1.TXT_REVIEW_YY.value=m_system_year;
				//document.Form1.TXT_PRODUCT_CODE.value=""; // commented by udara on 23-02-2012
				document.Form1.hid_new_product_code.value="";
				//document.Form1.TXT_PRODUCT_DESC.value="";
				//document.Form1.TXT_FEE_CODE.value=""; // commented by udara on 23-02-2012
				document.Form1.TXT_FEE_DESC.value="";
				document.Form1.hid_product_count.value=0;
				document.Form1.hid_fee_count.value=0;
				jQuery("#product_data").GridUnload();
				jQuery("#fee_data").GridUnload();
				document.getElementById('product_detail_data').innerHTML="";
				document.getElementById('fee_detail_data').innerHTML="";
				document.Form1.TXT_CREDIT_LIMIT.value="0.00";
				document.Form1.TXT_CREDIT_PERIOD.value="0.00";
				document.Form1.TXT_TOL_CREDIT_PERIOD.value="0.00";
				document.Form1.TXT_RES_MARGIN.value="0.00";
				document.Form1.TXT_ADVANCE.value="0.00";
				document.Form1.TXT_RECOURSE_PERIOD.value="0.00";
				document.Form1.TXT_SLAB_TYPE.value = "FLAT";
				document.Form1.TXT_VALUE_TYPE.value ="F"; 
				document.Form1.TXT_VARIABLE_TYPE.value="P";
				document.Form1.DISCOUNT_TYPE.value="AWPLR";
				document.Form1.TXT_VARIABLE_TYPE.disabled=true;
				document.Form1.DISCOUNT_TYPE.disabled=true;
				document.Form1.TXT_DISPLAY_INT_RATE.value="0.00";
				document.Form1.TXT_OVERPAID_RATE.value="0.00";
				document.Form1.TXT_DISPLAY_OVERPAID_RATE.value="0.00";
				document.Form1.TXT_RETENTION.value="0.00";
				document.Form1.TXT_BANKING.checked=false;
				document.Form1.TXT_REALIZATION.checked=false;
				document.Form1.TXT_SERVICE_CHARGE.value="0.00";
				document.Form1.TXT_FACT_FEE.value="0.00";
				document.Form1.TXT_ESTIMATED_RETURN.value="0.00";
				document.Form1.TXT_COST_ESTIMATED.value="0.00";
				document.Form1.TXT_COMMENTS.value="";
				document.Form1.TXT_APP_RECE_DD.value=m_system_date;  
				document.Form1.TXT_APP_RECE_MM.value=m_system_month;  
				document.Form1.TXT_APP_RECE_YY.value=m_system_year;  
				document.Form1.TXT_INSPEC_DD.value=m_system_date;  
				document.Form1.TXT_INSPEC_MM.value=m_system_month;  
				document.Form1.TXT_INSPEC_YY.value=m_system_year;  
				document.Form1.TXT_INFO_COM_DD.value=m_system_date;  
				document.Form1.TXT_INFO_COM_MM.value=m_system_month;  
				document.Form1.TXT_INFO_COM_YY.value=m_system_year;  
				document.Form1.hid_doc_count.value=0;
				document.getElementById('doc_detail_data').innerHTML="";
				document.Form1.hid_sup_doc_count.value=0;
				document.getElementById('sup_doc_detail_data').innerHTML="";
				document.Form1.hid_reports_count.value=0;
				document.getElementById('client_reports').innerHTML="";
				document.Form1.hid_third_party_guarantors_details_count.value=0;
				delete_third_party_guarantors_details(0);
				document.Form1.hid_slab_count.value=0;
				document.getElementById('DIV_TXT_SLAB_DYNAMIC').innerHTML="";
				document.getElementById('DIV_TXT_SLAB_DYNAMIC_HEAD').innerHTML="";
				hideFlatDiscount();
				document.Form1.TXT_LOCATION_CODE.value="";
				document.Form1.hid_help_row_number.value="";
				document.Form1.hid_facility_status.value="";
				document.Form1.TXT_RANDOM_DISAPP_PER.value="";
				document.Form1.TXT_MIN_INVOICE_VALUE.value="";
				document.Form1.TXT_MAX_INVOICE_VALUE.value="";
				document.Form1.TXT_MAX_DEBTOR_LIMIT.value="";
				document.Form1.TXT_AVG_DEBTOR_LIMIT.value="";
			}
			
			
			function validate_data(){
				if(document.Form1.TXT_CLIENT_CODE.value=="" ){  
					document.getElementById('DIV_TXT_CLIENT_CODE').style.color='red';
					return false;
				}
				else if(document.Form1.TXT_FACILITY_NO.value=="" && document.Form1.SCREEN_NAME.value=="EDIT"){  
					document.getElementById('DIV_TXT_FACILITY_NO').style.color='red';
					return false;
				}
				else if(document.Form1.TXT_FACILITY_MANAGER.value==""){  
					document.getElementById('DIV_TXT_FACILITY_MANAGER').style.color='red';
					return false;
				}
				else if(document.Form1.TXT_START_DD.value==""){  
					document.getElementById('DIV_TXT_CLIENT_START_DATE').style.color='red';
					return false;
				}
				else if(document.Form1.TXT_START_MM.value==""){  
					document.getElementById('DIV_TXT_CLIENT_START_DATE').style.color='red';
					return false;
				}
				else if(document.Form1.TXT_START_YY.value==""){  
					document.getElementById('DIV_TXT_CLIENT_START_DATE').style.color='red';
					return false;
				}
				else if(document.Form1.TXT_REVIEW_DD.value==""){  
					document.getElementById('DIV_TXT_CLIENT_END_DATE').style.color='red';
					return false;
				}
				else if(document.Form1.TXT_REVIEW_MM.value==""){  
					document.getElementById('DIV_TXT_CLIENT_END_DATE').style.color='red';
					return false;
				}
				else if(document.Form1.TXT_REVIEW_YY.value==""){  
					document.getElementById('DIV_TXT_CLIENT_END_DATE').style.color='red';
					return false;
				}
				else if(document.Form1.TXT_CREDIT_LIMIT.value==""){  
					document.getElementById('DIV_TXT_CREDIT_LIMIT').style.color='red';
					return false;
				}
				else if(document.Form1.TXT_CREDIT_PERIOD.value==""){  
					document.getElementById('DIV_TXT_CREDIT_PERIOD').style.color='red';
					return false;
				}
				else if(document.Form1.TXT_TOL_CREDIT_PERIOD.value==""){  
					document.getElementById('DIV_TXT_TOL_CREDIT_PERIOD').style.color='red';
					return false;
				}
				/*
				else if(document.Form1.TXT_RES_MARGIN.value==""){  
					document.getElementById('DIV_TXT_RES_MARGIN').style.color='red';
					return false;
				}
				*/
				else if(document.Form1.TXT_DISPLAY_INT_RATE.value==""){  
					document.getElementById('DIV_TXT_SLAB_TYPE').style.color='red';
					return false;
				}
				else if(document.Form1.TXT_DISPLAY_OVERPAID_RATE.value==""){  
					document.getElementById('DIV_TXT_OVERPAID_DISCOUNT').style.color='red';
					return false;
				}
				// commented below lines by udara on 24-02-2012
				//else if(document.Form1.TXT_PRODUCT_CODE.value==""){  
				//	document.getElementById('DIV_TXT_PRODUCT_CODE').style.color='red';
				//	return false;
				//}
				//else if(document.Form1.TXT_FEE_CODE.value==""){  
				//	document.getElementById('DIV_TXT_FEE_CODE').style.color='red';
				//	return false;
				//}
				else if(document.Form1.TXT_ACC_CODE.value==""){  
					document.getElementById('DIV_TXT_ACC_CODE').style.color='red';
					return false;
				}
				else if(document.Form1.TXT_BANKING.checked==false && document.Form1.TXT_REALIZATION.checked==false){  
					document.getElementById('DIV_TXT_AVAILABILITY').style.color='red';
					return false;
				}
				else if(document.Form1.TXT_LOCATION_CODE.value==""){  
					document.getElementById('DIV_TXT_LOCATION_CODE').style.color='red';
					return false;
				}
				//else if(document.Form1.TXT_ADVISER_NAME.value==""){
				//			document.getElementById('DIV_TXT_ADVISER_NAME').style.color='red';
				//	return false;
				//}

				else{
					return true;
				}
			}
			
			
			
			
			function before_submit(){ 
				/*
				get_display_msg();
				if(validate_data()){
					if(checkProductEdit()){
					if (validateSlabBeforeSave()){
						if (checkUnrealizedCheques()) {
						if(confirm("Are you sure you want to "+m_sav_msg+" ?")){ 
						showFollowUpDialog();
						}
					}
					}
				}
					}
					else { 
					alert("Please enter all required fields marked with a '*' on screen."); 
					}
			
				return true;
				*/
				if(validate_data())
					saveData();
				
			} 
			
			
			function load_lock(){	
			}	
			
			
			
			function new_window(){	
				//window.location.href='http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_display_client_facility';
				top.frames[1].location.href='dn_facility_creation.jsp';
			}
			function save_window(){	
				before_submit();
			}
			function load_help_msg() {
				m_help_message = "m_help_msg_NETFAC_FA_CR_CLIENT_FACILITY_CREATION";
				HelpBox_msg(m_help_message);
			}
			function HelpBox_msg(m_help_message) {
				popupwin = window.showModalDialog(servlet_client_url+":"+client_t3_port+"/"+client_name+"AF_MAS_Help_Msg_Servlet?class_in="+client_name+"FA_MAS_Help_Msg_select"+
					"&help_message_in="+m_help_message);
			}
			function load_roll_value(m_val){
				document.getElementById('help_box').innerHTML="  Credit Process - Client Facility Creation - "+m_val;
			}
			function load_roll_out_value(){
				document.getElementById('help_box').innerHTML="  Credit Process - Client Facility Creation - "+document.Form1.hid_status.value;
			}
			
			
			
			function load_screen_status(m_val){
				if(m_val=="NEW"){
					document.getElementById('div_lable').innerHTML='Facility Creation - New'; 
				}
				else if(m_val=="HELP"){
					load_help_msg();
				}
				document.Form1.SCREEN_NAME.value=m_val;
				if(m_val=="NEW"){
					if(confirm("Are you sure you want enter New record ?")){ 
						new_window();
						document.Form1.BUT_HELP_MAIN_1.disabled=true;
						document.Form1.TXT_FACILITY_NO.disabled=true;
						document.Form1.hid_status.value="New";
					}
				}
				else if(m_val=="EDIT"){
					if(confirm("Are you sure you want to Modify a record ?")){ 
						document.Form1.TXT_CLIENT_CODE.disabled = false; 
						document.Form1.TXT_ACC_CODE.disabled = false; 
						document.Form1.BUT_HELP_ACC.disabled = false;
						document.Form1.BUT_HELP_MAIN.disabled = false;
						document.Form1.BUT_APP_DEBTOR.disabled = false;
						document.Form1.BUT_HELP_MAIN_1.disabled=false;
						document.Form1.TXT_FACILITY_NO.disabled=false;
						document.Form1.hid_status.value="Edit";
						clear_data();
						document.Form1.hid_temp_facility_code.value = "";
					}
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
			
			
			function load_calendar(num) {
				document.Form1.hid_cal_date.value=num;
				popupwin = window.open(servlet_client_url+":"+client_t3_port+"/"+client_name+"CO_Calendar_Window", "oBj","left=450,top=200,width=320,height=230");
			}
			
			function load_c_date(val) {
				v_dd = val.substr(0,val.indexOf('-'));
				if(v_dd.length <2) 
					v_dd = 0+v_dd; 
				val = val.substr(val.indexOf('-')+1,val.length);
				v_mm = val.substr(0,val.indexOf('-')); 
				if(v_mm.length <2) 
					v_mm = 0+v_mm; 
				v_yy = val.substr(val.indexOf('-')+1,val.length);
				if(document.Form1.hid_cal_date.value=='1'){
					document.Form1.TXT_START_DD.value=v_dd;
					document.Form1.TXT_START_MM.value=v_mm;
					document.Form1.TXT_START_YY.value=v_yy;
				}
				if(document.Form1.hid_cal_date.value=='2'){
					document.Form1.TXT_REVIEW_DD.value=v_dd;
					document.Form1.TXT_REVIEW_MM.value=v_mm;
					document.Form1.TXT_REVIEW_YY.value=v_yy;
				}
			}
			
			
			function reset_hid_values() {
				document.getElementById('div_lable').innerHTML='Facility Creation - New'; 
				document.Form1.hid_product_count.value=0;
				document.Form1.hid_fee_count.value=0;
				document.Form1.hid_reports_count.value=0;
				document.Form1.hid_doc_count.value=0;
				document.Form1.hid_temp_facility_code.value = "";
				document.Form1.hid_proposed_security_details.value = "0";
				document.Form1.hid_third_party_guarantors_details_count.value=0;
			}
			
			/*	
			function print_facility_app(){
				if ($("#DIV_APP_SHEET").dialog("isOpen")) {
				$("#DIV_APP_SHEET").dialog("close");
				}
				$("#DIV_APP_SHEET").dialog("option", "title", "Factoring Facility Details");
				$("#DIV_APP_SHEET").dialog("open");
				$("#IFRAME_APP_SHEET").attr("src", "http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_Credit_Appraisal_Form?chksql=main_page&print=TRUE&facility_no=" + document.Form1.TXT_FACILITY_NO.value );
				return false;
			}
			*/
			
			function initAppSheetDialog(){
				$("#DIV_APP_SHEET").dialog({
						bgiframe: true,
						autoOpen: false,
						modal: false,
						height: 500,
						width: getW,
						close: function() {
						}
					});
			}
			
			/*
			function show_client_drill(obj) {
				if ($("#DIV_CLIENT_DRILL").dialog("isOpen")) {
				$("#DIV_CLIENT_DRILL").dialog("close");
				}
				$("#DIV_CLIENT_DRILL").dialog("option", "title", "Client Information");
				$("#DIV_CLIENT_DRILL").dialog("open");
				$("#IFRAME_CLIENT_DRILL").attr("src", "http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_RE_PRO_drill_downs?chksql=SHOW_CLIENT_INFORMATION&client_code=" + obj );
				return false;
			}
			*/	
			
			function initClientDrillDialog(){
				$("#DIV_CLIENT_DRILL").dialog({
						bgiframe: true,
						autoOpen: false,
						modal: false,
						height: 600,
						width: getW,
						close: function() {
						}
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
			
			
			function val_number(obj){
				if(isNaN(obj.value) ) { 
					alert('You have typed an incorrect character as a number');
					obj.value='';
					obj.focus();
				}
			}
			
			function change(obj) {
				if(obj.checked==true && obj.name =="TXT_BANKING" ){
					document.Form1.elements["TXT_REALIZATION"].checked=false;
					document.Form1.TXT_UNREALIZED_CHEQUE.disabled=false;
					document.Form1.TXT_UNREALIZED_CHEQUE.value=document.Form1.TXT_RES_MARGIN.value;
				}
				if(obj.checked==true && obj.name =="TXT_REALIZATION"){
					document.Form1.elements["TXT_BANKING"].checked=false;
					document.Form1.TXT_UNREALIZED_CHEQUE.disabled=true;
					document.Form1.TXT_UNREALIZED_CHEQUE.value="0.00";
				}
			}
			
			
			function collectionchange(obj) {
				if(obj.checked==true && obj.name =="TXT_COLL_CLIENT" ){
					document.Form1.elements["TXT_COLL_COMPANY"].checked=false;
				}
				if(obj.checked==true && obj.name =="TXT_COLL_COMPANY"){
					document.Form1.elements["TXT_COLL_CLIENT"].checked=false;
				}
			}
			
			
			var isOpen=false;
			
			$(document).ready(function() { 
					setRecoursePeriod();
					setDiscountChargeFrequency();
					setValue2("TXT_RES_MARGIN");
					initAppSheetDialog();
					initClientDrillDialog();
					initCal("FACILITY_DATE");
					initCal("REVIEW_DATE");
					initCal("START_DATE");
					initCal("END_DATE");
					initCal("APP_DATE");
					initCal("INSPECT_DATE");
					initCal("INFO_COMPLETE_DATE");
					initCal("reset_date");
				});
			
			var global_var = 'YES';
			
			function initCal(inst){
				// $("#"+inst).datepicker({dateFormat:'dd-mm-yy',duration: 'fast',yearRange: '1920:2050',showOn: 'button',buttonImage: 'http://www.netfac.lk/SNET/images/calendar.gif',buttonImageOnly: true,changeMonth: true,changeYear: true,onSelect: function(dateText, inst){dateSelectFunc(dateText,inst);}});
				$("#"+inst).datepicker({dateFormat:'dd-mm-yy',duration: 'fast',yearRange: '1920:2050',showOn: 'button',
						buttonImage: '<%=m_jsp_client_url%>/SNET/images/calendar.gif',
						//buttonImage: 'https://dev-adlmargin.sasianet.com:8443/ADLMARGIN/LBMARGIN/SNET/images/calendar.gif',
						buttonImageOnly: true,changeMonth: true,changeYear: true,onSelect: function(dateText, inst){dateSelectFunc(dateText,inst);}});
			}
			
			function dateSelectFunc(dateText, inst){
				
				var splitResult = dateText.split('-');
				var instance_id = inst.id;
				var m_last_index_of_underscore = instance_id.lastIndexOf('_');
				var first_part = instance_id.substr(0, m_last_index_of_underscore + 1);
				var second_part = instance_id.substr(m_last_index_of_underscore + 1);
				
				if (inst.id=="FACILITY_DATE"){
					document.Form1.TXT_START_DD.value=splitResult[0];
					document.Form1.TXT_START_MM.value=splitResult[1];
					document.Form1.TXT_START_YY.value=splitResult[2];
				}
				if (inst.id=="REVIEW_DATE"){
					document.Form1.TXT_REVIEW_DD.value=splitResult[0];
					document.Form1.TXT_REVIEW_MM.value=splitResult[1];
					document.Form1.TXT_REVIEW_YY.value=splitResult[2];
				}
				if (inst.id=="START_DATE"){
					document.Form1.TXT_ST_DD.value=splitResult[0];
					document.Form1.TXT_ST_MM.value=splitResult[1];
					document.Form1.TXT_ST_YY.value=splitResult[2];
				}
				if (inst.id=="END_DATE"){
					document.Form1.TXT_END_DD.value=splitResult[0];
					document.Form1.TXT_END_MM.value=splitResult[1];
					document.Form1.TXT_END_YY.value=splitResult[2];
				}
				if (inst.id=="reset_date"){
					document.Form1.TXT_RESET_DD.value=splitResult[0];
					document.Form1.TXT_RESET_MM.value=splitResult[1];
					document.Form1.TXT_RESET_YY.value=splitResult[2];
					document.Form1.TXT_RESET_YY.focus();
				}
				if (inst.id=="APP_DATE"){
					document.Form1.TXT_APP_RECE_DD.value=splitResult[0];
					document.Form1.TXT_APP_RECE_MM.value=splitResult[1];
					document.Form1.TXT_APP_RECE_YY.value=splitResult[2];
				}
				if (inst.id=="INSPECT_DATE"){
					document.Form1.TXT_INSPEC_DD.value=splitResult[0];
					document.Form1.TXT_INSPEC_MM.value=splitResult[1];
					document.Form1.TXT_INSPEC_YY.value=splitResult[2];
				}
				if (inst.id=="INFO_COMPLETE_DATE"){
					document.Form1.TXT_INFO_COM_DD.value=splitResult[0];
					document.Form1.TXT_INFO_COM_MM.value=splitResult[1];
					document.Form1.TXT_INFO_COM_YY.value=splitResult[2];
				}
				if (first_part == "FEE_DATE_") {
					document.Form1.elements["TXT_EFF_DD_" + second_part].value = splitResult[0];
					document.Form1.elements["TXT_EFF_MM_" + second_part].value = splitResult[1];
					document.Form1.elements["TXT_EFF_YY_" + second_part].value = splitResult[2];
				}
				if (first_part == "RECEIVE_DATE_") {
					document.Form1.elements["TXT_RECEIVE_DD_" + second_part].value = splitResult[0];
					document.Form1.elements["TXT_RECEIVE_MM_" + second_part].value = splitResult[1];
					document.Form1.elements["TXT_RECEIVE_YY_" + second_part].value = splitResult[2];
				}
			}
			
			/*
		function add_products(){
			 m_dir_count=parseInt(document.Form1.hid_product_count.value);
			 m_dir_count++;
			 if(parseInt(document.Form1.hid_product_count.value)==0){
			 document.getElementById('product_detail_data').innerHTML=document.getElementById('product_detail_data').innerHTML+'<table >'+
			 	'<tr>'+
	 	 		'<td class = "div_input" align = "center" style = "width: 150px;">Product Feature Code</td> '+
	    		'<td class = "div_input" align = "center" style = "width: 180px;">Product Feature Name</td> '+
	    		'<td class = "div_input" align = "center" style = "width: 125px;">Comments</td> '+
	    		'<td class = "div_input" align = "center" style = "width: 250px;">Activation Point</td> '+
	 	 		'<td class = "div_input" align = "center" style = "width: 125px;">Action</td> '+
	    		'<td class = "div_input" align = "center" style = "width: 150px;">Mail Code</td> '+
	    		'<td class = "div_input" align = "center" style = "width: 125px;">Frequency</td> '+
	    		'<td class = "div_input" align = "center" style = "width: 130px;">Mode of Sending</td> '+
	    		'<td class = "div_input" align = "center" style = "width: 90px;">Applicability</td> '+
	    		'</tr> '+
	    		'<tr> '+
	    		'<td ><DIV id="DIV_TXT_PRO_FEATURE_CODE"  class="div_input" style="width:185px"><input class = "txt_input" type = "text" name = "TXT_PRO_FEATURE_CODE_'+m_dir_count+'" maxlength = "10" style = "width: 125px;"  onblur="help_products_feature('+m_dir_count+',\'help_products_feature\')"> <input class="but_input" type="button" name="PRO_FEATURE_CODE_'+m_dir_count+'" value="..." onClick="help_products_feature('+m_dir_count+',\'help_products_feature\')"><a onClick="help_products_feature('+m_dir_count+',\'help_products_feature\')" style=" text-decoration: none;cursor: text;" id="help_products_feature" class="fancylink iframe" href=""> </a></DIV></td>'+ 
	    		'<td ><input class = "txt_input" type = "text" name = "TXT_PRO_FEATURE_NAME_'+m_dir_count+'" maxlength = "50" style = "width: 175px;"  disabled></td>'+ 
	    		'<td ><input class = "txt_input" type = "text" name = "TXT_COMMENTS_'+m_dir_count+'" maxlength = "4000" style = "width: 125px;" onBlur = "strTrim(this);" ></td> '+
	    		'<td ><select class = "txt_input" name="TXT_PRO_ACT_POINT_'+m_dir_count+'" style = "width: 250px;" ><option value =A0035>Adjustments - Approval</option><option value =A0027>Assign Debtors To Client Facility</option><option value =A0036>Auto Refactoring Approval</option><option value =A0034>Cancel Reassignment</option><option value =A0029>Change Cheque Banking Date - Approval</option><option value =A0006>Cheque Return Entering</option><option value =A0026>Client Approval</option><option value =A0014>Client Credit Approval</option><option value =A0028>Client Debtor Limit Enhancement</option><option value =A0004>Credit Note Approval </option><option value =A0002>Day End Routine</option><option value =A0031>Debtor Credit Evaluation</option><option value =A0012>Every Visit</option><option value =A0023>Facility Activation</option><option value =A0001>Invoice Approval / Confirmation</option><option value =A0033>Invoice Cancellation</option><option value =A0011>Invoice Entry</option><option value =A0003>Month End Routine</option><option value =A0030>Payment Printing</option><option value =A0007>Printing/Posting Level</option><option value =A0005>Settlement Deposit</option><option value =A0013>Settlement Entry</option><option value =A0015>Settlement Receipt Entry Print Or Post</option><option value =A0010>When Calling</option><option value =A0017>When Letter Of Demand Print Of Post</option><option value =A0022>When Making The Advise </option><option value =A0020>When Modifing Each Credit Period</option><option value =A0018>When Sending Account Statement</option><option value =A0019>When Sending Email Or Sms</option><option value =A0021>When Sending Or Printing Assignment Letters</option><option value =A0024>When Sending Or Printing Reminder Letters</option><option value =A0025>When Terminate Client Debtor Relationship</option><option value =A0016>When View Or Update Crib</option></select></td>'+ 
	    		'<td ><select class = "txt_input" name="TXT_ACTION_'+m_dir_count+'" style = "width: 125px;" ><option VALUE="A">Action 1</option><option VALUE="B">Action 2</option></select></td>'+ 
	    		'<td ><DIV id="DIV_TXT_MAIL_CODE"  class="div_input" style="width:185px"><input class = "txt_input" type = "text" name = "TXT_MAIL_CODE_'+m_dir_count+'" maxlength = "10" style = "width: 125px;"  onblur="help_mail_code('+m_dir_count+',\'help_mail_code\')"> '+ 
	    		'<input class="but_input" type="button" name="PRO_MAIL_CODE_'+m_dir_count+'" value="..." onClick="help_mail_code('+m_dir_count+',\'help_mail_code\')"><a onClick="strTrim(this);help_mail_code('+m_dir_count+',\'help_mail_code\')" style=" text-decoration: none;cursor: text;" id="help_mail_code" class="fancylink iframe" href=""> </a></DIV></td>'+ 
	    	 	'<td ><select class = "txt_input" name="TXT_FREQUENCY_'+m_dir_count+'" style = "width: 125px;" ><option VALUE="A">Frequency 1</option><option VALUE="B">Frequency 2</option></select></td>'+ 
			 	'<td ><DIV id="DIV_TXT_MODE_OF_SENDING"  class="div_input" style="width:160px" align = "center">Mail<input type="checkbox" name="CHK_MAIL_'+m_dir_count+'" checked>Fax<input type="checkbox" name="CHK_FAX_'+m_dir_count+'" >Letter<input type="checkbox" name="CHK_LETTER_'+m_dir_count+'" ></DIV></td>'+
			 	'<td align = "center"><input type="checkbox" name="CHK_PRO_'+m_dir_count+'" checked></td>'+
			 	'</tr>'+
			 	'</table>';
			}
			 else{
				document.getElementById('product_detail_data').innerHTML=document.getElementById('product_detail_data').innerHTML+'<table >'+
				'<tr>'+
		 	 	'<td class = "div_input" align = "center" style = "width: 150px;"></td> '+
		    	'<td class = "div_input" align = "center" style = "width: 180px;"></td> '+
		    	'<td class = "div_input" align = "center" style = "width: 125px;"></td> '+
		    	'<td class = "div_input" align = "center" style = "width: 250px;"></td> '+
		 	 	'<td class = "div_input" align = "center" style = "width: 125px;"></td> '+
		    	'<td class = "div_input" align = "center" style = "width: 150px;"></td> '+
		    	'<td class = "div_input" align = "center" style = "width: 125px;"></td> '+
		    	'<td class = "div_input" align = "center" style = "width: 130px;"></td> '+
		    	'<td class = "div_input" align = "center" style = "width: 90px;"></td> '+
		    	'</tr> '+
		    	'<tr> '+
		    	'<td ><DIV id="DIV_TXT_PRO_FEATURE_CODE"  class="div_input" style="width:185px"><input class = "txt_input" type = "text" name = "TXT_PRO_FEATURE_CODE_'+m_dir_count+'" maxlength = "10" style = "width: 125px;"  onblur="help_products_feature('+m_dir_count+',\'help_products_feature\')"> <input class="but_input" type="button" name="PRO_FEATURE_CODE_'+m_dir_count+'" value="..." onClick="help_products_feature('+m_dir_count+',\'help_products_feature\')"><a onClick="help_products_feature('+m_dir_count+',\'help_products_feature\')" style=" text-decoration: none;cursor: text;" id="help_products_feature" class="fancylink iframe" href=""> </a></DIV></td>'+ 
		    	'<td ><input class = "txt_input" type = "text" name = "TXT_PRO_FEATURE_NAME_'+m_dir_count+'" maxlength = "50" style = "width: 175px;"  disabled></td>'+ 
		    	'<td ><input class = "txt_input" type = "text" name = "TXT_COMMENTS_'+m_dir_count+'" maxlength = "4000" style = "width: 125px;" onBlur = "strTrim(this);" ></td> '+
		    	'<td ><select class = "txt_input" name="TXT_PRO_ACT_POINT_'+m_dir_count+'" style = "width: 250px;" ><option value =A0035>Adjustments - Approval</option><option value =A0027>Assign Debtors To Client Facility</option><option value =A0036>Auto Refactoring Approval</option><option value =A0034>Cancel Reassignment</option><option value =A0029>Change Cheque Banking Date - Approval</option><option value =A0006>Cheque Return Entering</option><option value =A0026>Client Approval</option><option value =A0014>Client Credit Approval</option><option value =A0028>Client Debtor Limit Enhancement</option><option value =A0004>Credit Note Approval </option><option value =A0002>Day End Routine</option><option value =A0031>Debtor Credit Evaluation</option><option value =A0012>Every Visit</option><option value =A0023>Facility Activation</option><option value =A0001>Invoice Approval / Confirmation</option><option value =A0033>Invoice Cancellation</option><option value =A0011>Invoice Entry</option><option value =A0003>Month End Routine</option><option value =A0030>Payment Printing</option><option value =A0007>Printing/Posting Level</option><option value =A0005>Settlement Deposit</option><option value =A0013>Settlement Entry</option><option value =A0015>Settlement Receipt Entry Print Or Post</option><option value =A0010>When Calling</option><option value =A0017>When Letter Of Demand Print Of Post</option><option value =A0022>When Making The Advise </option><option value =A0020>When Modifing Each Credit Period</option><option value =A0018>When Sending Account Statement</option><option value =A0019>When Sending Email Or Sms</option><option value =A0021>When Sending Or Printing Assignment Letters</option><option value =A0024>When Sending Or Printing Reminder Letters</option><option value =A0025>When Terminate Client Debtor Relationship</option><option value =A0016>When View Or Update Crib</option></select></td>'+ 
		    	'<td ><select class = "txt_input" name="TXT_ACTION_'+m_dir_count+'" style = "width: 125px;" ><option VALUE="A">Action 1</option><option VALUE="B">Action 2</option></select></td>'+ 
		    	'<td ><DIV id="DIV_TXT_MAIL_CODE"  class="div_input" style="width:185px"><input class = "txt_input" type = "text" name = "TXT_MAIL_CODE_'+m_dir_count+'" maxlength = "10" style = "width: 125px;" onblur="strTrim(this);help_mail_code('+m_dir_count+',\'help_mail_code\')" > <input class="but_input" type="button" name="PRO_MAIL_CODE_'+m_dir_count+'" value="..." onClick="help_mail_code('+m_dir_count+',\'help_mail_code\')"><a onClick="help_mail_code('+m_dir_count+',\'help_mail_code\')" style=" text-decoration: none;cursor: text;" id=\'help_mail_code\' class="fancylink iframe" href=""> </a></DIV></td>'+ 
		    	'<td ><select class = "txt_input" name="TXT_FREQUENCY_'+m_dir_count+'" style = "width: 125px;" ><option VALUE="A">Frequency 1</option><option VALUE="B">Frequency 2</option></select></td>'+ 
				'<td ><DIV id="DIV_TXT_MODE_OF_SENDING"  class="div_input" style="width:160px" align = "center">Mail<input type="checkbox" name="CHK_MAIL_'+m_dir_count+'" checked>Fax<input type="checkbox" name="CHK_FAX_'+m_dir_count+'" >Letter<input type="checkbox" name="CHK_LETTER_'+m_dir_count+'" ></DIV></td>'+
				'<td align = "center"><input type="checkbox" name="CHK_PRO_'+m_dir_count+'" checked></td>'+
				'</tr>'+
				'</table>';
			}
		
			document.Form1.hid_product_count.value=m_dir_count;
			init_fancybox();
		}
		*/	
			
			/*			
			function load_product_grid(mode){
			jQuery("#product_data").GridUnload();
			if (mode =="NEW"){ 
				m_url="http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_xml_validations?q=1&chksql=m_NEW_PRODUCT_FEATURE_FACILITY&product_code="+document.Form1.TXT_PRODUCT_CODE.value;
			}
			if (mode =="EDIT"){ 
				m_url="http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_xml_validations?q=1&chksql=m_EDIT_PRODUCT&product_code="+document.Form1.TXT_PRODUCT_CODE.value+"&facility_code="+document.Form1.TXT_FACILITY_NO.value;
			}
			if (mode =="QUOTATION"){ 
				m_url="http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_xml_validations?q=1&chksql=m_LOAD_QUOTATION_PRODUCT&product_code="+document.Form1.TXT_PRODUCT_CODE.value+"&quotation_code="+document.Form1.TXT_QUOTATION_NO.value;
			}
			jQuery("#product_data").jqGrid(
			{
				url: m_url,
				datatype: "xml",
			colNames:['Applicability','Product Feature Code','Product Feature Description','Comments','Activation Point', 'Action', 'Mail Code', 'Frequency', 'Mail', 'Fax', 'Letter'],
			colModel:[ {name:'APPLICABILITY',index:'APPLICABILITY', width:85, align:"center",formatter:cellFomatterApplicability},
			{name:'PRO_FEATURE_CODE',index:'PRO_FEATURE_CODE', width:150, align:"left",formatter:cellFomatterProductFeatureCode},
			{name:'PRO_FEATURE_NAME',index:'PRO_FEATURE_NAME', width:250, align:"left",formatter:cellFomatterProductFeatureName},
			{name:'COMMENTS',index:'COMMENTS', width:150, align:"center",sortable:false,formatter:cellFomatterCommentsText},
			{name:'ACT_POINT',index:'ACT_POINT', width:250, align:"center",sortable:false},
			{name:'ACTION',index:'ACTION', width:130, align:"center",sortable:false,formatter:cellFomatterAction},
			{name:'MAIL_CODE',index:'MAIL_CODE', width:190, align:"center",formatter:cellFomatterMailCode},
			{name:'FREQUENCY',index:'FREQUENCY', width:130, align:"center",formatter:cellFomatterFrequency},
			{name:'MAIL',index:'MAIL', width:80, align:"center",formatter:cellFomatterEmail},
			{name:'FAX',index:'FAX', width:80, align:"center",sortable:false,formatter:cellFomatterFax},
			{name:'LETTER',index:'LETTER', width:80,align:"center", sortable:false,formatter:cellFomatterLetter}],
			mtype: "GET",
			loadonce: 1,
			rownumbers:true,
			rowNum:-1,
			gridview: true,
			height: 'auto',
			loadComplete : loadCount,
			gridComplete : function(){
			var rec_count=$("#product_data").jqGrid('getGridParam',"records");
			init_fancybox();
			}
			}
			);
			}
			function loadCount(){
			var rec_count=$("#product_data").jqGrid('getGridParam',"records");
			document.Form1.hid_product_count.value=rec_count;
			}
			*/			
			
			
			/*
			function cellFomatterApplicability (cellvalue, options, rowObject){
				var row_id=rowObject.getAttribute('id');
				if (cellvalue =="Y") 
				var checkbox = "<input type='checkbox' id='CHK_PRO_"+row_id+"' name='CHK_PRO_"+row_id+"' checked />";
				else 
				var checkbox = "<input type='checkbox' id='CHK_PRO_"+row_id+"' name='CHK_PRO_"+row_id+"'  />";
			return checkbox;
			}
			*/
			
			/*			
			function cellFomatterCommentsText (cellvalue, options, rowObject){
			var row_id=rowObject.getAttribute('id');
				var texts = "<input class='txt_input' type='text' id='TXT_COMMENTS_"+row_id+"' name='TXT_COMMENTS_"+row_id+"' value='"+cellvalue+"' style='width:130px' maxlength='4000' onblur=\"strTrim(this, null, null, \'COMMENT\');\" />";
			return texts;
			}
			*/			
			
			/*			
			function cellFomatterEmail (cellvalue, options, rowObject){
				var row_id=rowObject.getAttribute('id');
				if (cellvalue =="Y") 
				var checkbox = "<input type='checkbox' id='CHK_MAIL_"+row_id+"' name='CHK_MAIL_"+row_id+"' checked />";
				else 
				var checkbox = "<input type='checkbox' id='CHK_MAIL_"+row_id+"' name='CHK_MAIL_"+row_id+"'  />";
			return checkbox;
			}
			*/			
			
			/*			
			function cellFomatterFax (cellvalue, options, rowObject){
				var row_id=rowObject.getAttribute('id');
				if (cellvalue =="Y") 
				var checkbox = "<input type='checkbox' id='CHK_FAX_"+row_id+"' name='CHK_FAX_"+row_id+"' checked />";
				else 
				var checkbox = "<input type='checkbox' id='CHK_FAX_"+row_id+"' name='CHK_FAX_"+row_id+"'  />";
			return checkbox;
			}
			*/			
			
			/*			
			function cellFomatterLetter (cellvalue, options, rowObject){
				var row_id=rowObject.getAttribute('id');
				if (cellvalue =="Y") 
				var checkbox = "<input type='checkbox' id='CHK_LEETER_"+row_id+"' name='CHK_LETTER_"+row_id+"' checked />";
				else 
				var checkbox = "<input type='checkbox' id='CHK_LEETER_"+row_id+"' name='CHK_LETTER_"+row_id+"'  />";
			return checkbox;
			}
			*/			
			
			/*			
			function cellFomatterAction (cellvalue, options, rowObject){
			var row_id=rowObject.getAttribute('id');
			if (cellvalue=="A" || cellvalue=="B"){ 
				if(cellvalue=="A") 
				var texts = "<select class='txt_input' type='text' id='TXT_ACTION_"+row_id+"' name='TXT_ACTION_"+row_id+"' style='width:100px' ><option VALUE='A' SELECTED>Action 1</option><option VALUE='B'>Action 2</option></select>";
				if(cellvalue=="B") 
				var texts = "<select class='txt_input' type='text' id='TXT_ACTION_"+row_id+"' name='TXT_ACTION_"+row_id+"' style='width:100px' ><option VALUE='A'>Action 1</option><option VALUE='B' SELECTED>Action 2</option>></select>";
			}
				else { 
				if(cellvalue=="A1") 
				var texts = "<select class='txt_input' type='text' id='TXT_ACTION_"+row_id+"' name='TXT_ACTION_"+row_id+"' style='width:100px' ><option VALUE='A1' SELECTED>Action 1</option><option VALUE='A2'>Action 2</option><option VALUE='A3'>Action 3</option></select>";
				if(cellvalue=="A2") 
				var texts = "<select class='txt_input' type='text' id='TXT_ACTION_"+row_id+"' name='TXT_ACTION_"+row_id+"' style='width:100px' ><option VALUE='A1'>Action 1</option><option VALUE='A2' SELECTED>Action 2</option><option VALUE='A3'>Action 3</option></select>";
				if(cellvalue=="A3") 
				var texts = "<select class='txt_input' type='text' id='TXT_ACTION_"+row_id+"' name='TXT_ACTION_"+row_id+"' style='width:100px' ><option VALUE='A1'>Action 1</option><option VALUE='A2'>Action 2</option><option VALUE='A3' SELECTED>Action 3</option></select>";
			}
			return texts;
			}
			*/			
			
			
			/*			
			function cellFomatterFrequency (cellvalue, options, rowObject){
			var row_id=rowObject.getAttribute('id');
				if (cellvalue=="A" || cellvalue=="B"){ 
				if(cellvalue=="A") 
				var texts = "<select class='txt_input' type='text' id='TXT_FREQUENCY_"+row_id+"' name='TXT_FREQUENCY_"+row_id+"' style='width:100px' ><option VALUE='A' SELECTED>Frequency 1</option><option VALUE='B'>Frequency 2</option></select>";
				if(cellvalue=="B") 
				var texts = "<select class='txt_input' type='text' id='TXT_FREQUENCY_"+row_id+"' name='TXT_FREQUENCY_"+row_id+"' style='width:100px' ><option VALUE='A'>Frequency 1</option><option VALUE='B' SELECTED>Frequency 2</option></select>";
			}
				else { 
				if(cellvalue=="F1") 
				var texts = "<select class='txt_input' type='text' id='TXT_FREQUENCY_"+row_id+"' name='TXT_FREQUENCY_"+row_id+"' style='width:100px' ><option VALUE='F1' SELECTED>Frequency 1</option><option VALUE='F2'>Frequency 2</option><option VALUE='F3'>Frequency 3</option></select>";
				if(cellvalue=="F2") 
				var texts = "<select class='txt_input' type='text' id='TXT_FREQUENCY_"+row_id+"' name='TXT_FREQUENCY_"+row_id+"' style='width:100px' ><option VALUE='F1'>Frequency 1</option><option VALUE='F2' SELECTED>Frequency 2</option><option VALUE='F3C'>Frequency 3</option></select>";
				if(cellvalue=="F3") 
				var texts = "<select class='txt_input' type='text' id='TXT_FREQUENCY_"+row_id+"' name='TXT_FREQUENCY_"+row_id+"' style='width:100px' ><option VALUE='F1'>Frequency 1</option><option VALUE='F2'>Frequency 2</option><option VALUE='F3' SELECTED>Frequency 3</option></select>";
			}
			return texts;
			}
			*/			
			
			/*			
			function cellFomatterMailCode (cellvalue, options, rowObject){
			var row_id=rowObject.getAttribute('id');
				var texts = "<input class='txt_input' type='text' id='TXT_MAIL_CODE_"+row_id+"' name='TXT_MAIL_CODE_"+row_id+"' value='"+cellvalue+"' style='width:120px' maxlength='4000' onblur=\"strTrim(this);help_mail_code("+row_id+",\'help_mail_code\')\" ><input class='but_input' type='button' name='PRO_MAIL_CODE_"+row_id+"' value='...' onClick=\"help_mail_code("+row_id+",\'help_mail_code\')\" ><a onClick=\"help_mail_code("+row_id+",\'help_mail_code\')\" style=' text-decoration: none;cursor: text;' id='help_mail_code' class='fancylink iframe' href=''> </a>";
			return texts;
			}
			*/			
			
			/*		
			function cellFomatterProductFeatureCode (cellvalue, options, rowObject){
			var row_id=rowObject.getAttribute('id');
				var texts = "<input class='txt_input' type='text' id='TXT_PRO_FEATURE_CODE_"+row_id+"' name='TXT_PRO_FEATURE_CODE_"+row_id+"' value='"+cellvalue+"' style='width:100px' maxlength='90' onblur=\"strTrim(this);help_products_feature("+row_id+",\'help_products_feature\')\" ><input class='but_input' type='button' name='TXT_PRO_FEATURE_CODE_"+row_id+"' value='...' onClick=\"help_products_feature("+row_id+",\'help_products_feature\')\" ><a onClick=\"help_products_feature("+row_id+",\'help_products_feature\')\" style=' text-decoration: none;cursor: text;' id='help_products_feature' class='fancylink iframe' href=''> </a>";
			return texts;
			}
			*/
			
			/*
			function cellFomatterProductFeatureName (cellvalue, options, rowObject){
			var row_id=rowObject.getAttribute('id');
				var texts = "<input class='txt_input' type='text' id='TXT_PRO_FEATURE_NAME_"+row_id+"' name='TXT_PRO_FEATURE_NAME_"+row_id+"' value='"+cellvalue+"' style='width:230px' maxlength='90' disabled >";
			return texts;
			}
			*/
			
			/*			
			function add_fee(){
						m_dir_count=parseInt(document.Form1.hid_fee_count.value);
						m_dir_count++;
						if(parseInt(document.Form1.hid_fee_count.value)==0){
					var fee_content = '<table  >'+
						'<tr>'+
					'<td class = "div_input" align = "center" style = "width: 170px;">Fee Code</td> '+
				'<td class = "div_input" align = "center" style = "width: 180px;">Fee Discription</td> '+
				'<td class = "div_input" align = "center" style = "width: 170px;">Fee Type</td> '+
				'<td class = "div_input" align = "center" style = "width: 180px;">Fee Amount Rate</td> '+
					'<td class = "div_input" align = "center" style = "width: 170px;">Calculation Basis</td> '+
				'<td class = "div_input" align = "center" style = "width: 275px;">Activation Point</td> '+
				'<td class = "div_input" align = "center" style = "width: 170px;">Tax Applicability</td> '+
				'<td class = "div_input" align = "center" style = "width: 170px;">Fee Effects</td> '+
				'<td class = "div_input" align = "center" style = "width: 160px;">Effective Date</td> '+
				'<td class = "div_input" align = "center" style = "width: 100px;">Applicability</td> '+
				'</tr> '+
				'<tr> '+
				'<td ><DIV id="DIV_TXT_FEE_FEATURE_CODE"  class="div_input" style="width:185px"><input class = "txt_input" type = "text" name = "TXT_FEE_FEATURE_CODE_'+m_dir_count+'" maxlength = "10" style = "width: 125px;" onblur="help_fee_feature('+m_dir_count+',\'help_fees_feature\')" > <input class="but_input" type="button" name="FEE_FEATURE_CODE_'+m_dir_count+'" value="..." onClick="help_fee_feature('+m_dir_count+',\'help_fees_feature\')"><a onClick="help_fee_feature('+m_dir_count+',\'help_fees_feature\')" style=" text-decoration: none;cursor: text;" id="help_fees_feature" class="fancylink iframe" href=""> </a></DIV></td>'+ 
				'<td ><input class = "txt_input" type = "text" name = "TXT_FEE_FEATURE_NAME_'+m_dir_count+'" maxlength = "200" style = "width: 175px;"  disabled></td>'+ 
				'<td ><select class = "txt_input" name="TXT_FEE_TYPE_'+m_dir_count+'" style = "width: 125px;" ><option value="P" SELECTED>Percentage</option><option value="F">Flat</option><option value="V">Variable</option></select></td>'+ 
				'<td ><input class = "txt_input" type = "text" name = "TXT_FEE_AMOUNT_'+m_dir_count+'" maxlength = "25" style = "width: 125px; text-align:right;"  onchange=format_num(document.Form1.elements["TXT_FEE_AMOUNT_'+m_dir_count+'"],4)></td>'+ 
				'<td ><select class = "txt_input" name="TXT_FEE_CALC_BASIS_'+m_dir_count+'" style = "width: 125px;" disabled><option value =B029>Adjust Due Date By Client Debtor</option><option value =B025>Cash Adjustment Amount</option><option value =B024>Client Adjustment Amount</option><option value =B018>Client-Debtor Relationship Charges Amount</option><option value =B016>Credit Facility Amount</option><option value =B019>Credit Note Value</option><option value =B009>Credit Note Value>Invoice Value</option><option value =B014>Current Account Closing Balance</option><option value =B006>Each Cheques Return</option><option value =B007>Each Letter/Calling</option><option value =B021>Each Payment - Bank Transfer Amount</option><option value =B020>Each Payment - Pay Order Amount</option><option value =B036>Each Payment - Rtgs Amount</option><option value =B008>Each Visit</option><option value =B010>Every Event</option><option value =B013>Excess Amount Paid More Than Client Availability</option><option value =B002>Face Value Of The Invoice</option><option value =B001>Flat Value Basis - Not Applicable</option><option value =B015>If Service Charges Less Than The Minimum Service Charge</option><option value =B023>Invoice Adjustment Amount</option><option value =B030>Invoice Date Adjustment</option><option value =B032>Invoice Number Adjustment</option><option value =B027>Invoice Reassignment Amount</option><option value =B028>Invoice Reassignments Reversal Amount</option><option value =B003>Invoice Reversal Amount</option><option value =B033>Invoices Factored Of Each Debtor</option><option value =B022>Non Cash Debit Adjustment Amount</option><option value =B011>Outstanding Invoice Value Event Of Next Cycle</option><option value =B034>Payment Amount - If Late Processed Invoices</option><option value =B004>Per Collection Entry</option><option value =B031>Return Cheque Reassignment Amount</option><option value =B012>Settlement Entry Amount</option><option value =B017>Total Charges Of The Previous Month</option><option value =B035>Total Outstanding Sales Ledger Value</option><option value =B026>Transfer Invoice Amount</option><option value =B005>Value Of Cheque Collected</option></select></td>'+ 
				'<td ><select class = "txt_input" name="TXT_FEE_ACT_POINT_'+m_dir_count+'" style = "width: 250px;" disabled><option value =A0035>Adjustments - Approval</option><option value =A0027>Assign Debtors To Client Facility</option><option value =A0036>Auto Refactoring Approval</option><option value =A0034>Cancel Reassignment</option><option value =A0029>Change Cheque Banking Date - Approval</option><option value =A0006>Cheque Return Entering</option><option value =A0026>Client Approval</option><option value =A0014>Client Credit Approval</option><option value =A0028>Client Debtor Limit Enhancement</option><option value =A0004>Credit Note Approval </option><option value =A0002>Day End Routine</option><option value =A0031>Debtor Credit Evaluation</option><option value =A0012>Every Visit</option><option value =A0023>Facility Activation</option><option value =A0001>Invoice Approval / Confirmation</option><option value =A0033>Invoice Cancellation</option><option value =A0011>Invoice Entry</option><option value =A0003>Month End Routine</option><option value =A0030>Payment Printing</option><option value =A0007>Printing/Posting Level</option><option value =A0005>Settlement Deposit</option><option value =A0013>Settlement Entry</option><option value =A0015>Settlement Receipt Entry Print Or Post</option><option value =A0010>When Calling</option><option value =A0017>When Letter Of Demand Print Of Post</option><option value =A0022>When Making The Advise </option><option value =A0020>When Modifing Each Credit Period</option><option value =A0018>When Sending Account Statement</option><option value =A0019>When Sending Email Or Sms</option><option value =A0021>When Sending Or Printing Assignment Letters</option><option value =A0024>When Sending Or Printing Reminder Letters</option><option value =A0025>When Terminate Client Debtor Relationship</option><option value =A0016>When View Or Update Crib</option></select></td>'+ 
				'<td ><select class = "txt_input" name="TXT_TAX_APPLICABLE_'+m_dir_count+'" style = "width: 125px;" ><option value="Y">Yes</option><option value="N" selected>No</option></select></td>'+ 
				'<td ><select class = "txt_input" name="TXT_FEE_EFFECTS_'+m_dir_count+'" style = "width: 125px;" ><option value="A" SELECTED>Automatic</option><option value="M" SELECTED>Mannual</option></select></td>'+ 
				'<td ><DIV id="DIV_TXT_EFF_DATE"  class="div_input" style="width:150px"><input class = "txt_input5" type = "text" name = "TXT_EFF_DD_'+m_dir_count+'" maxlength = "2" size = "2" onBlur = "checkMonthLength1(document.Form1.elements[\'TXT_EFF_DD_' + m_dir_count + '\'], document.Form1.elements[\'TXT_EFF_MM_' + m_dir_count + '\'], document.Form1.elements[\'TXT_EFF_YY_' + m_dir_count + '\'], document.Form1.elements[\'FEE_DATE_' + m_dir_count + '\'], \'D\', \'N\');"> '+ 
				'<input class = "txt_input5" type = "text" name = "TXT_EFF_MM_'+m_dir_count+'" maxlength = "2" size = "2" onBlur = "checkMonthLength1(document.Form1.elements[\'TXT_EFF_DD_' + m_dir_count + '\'], document.Form1.elements[\'TXT_EFF_MM_' + m_dir_count + '\'], document.Form1.elements[\'TXT_EFF_YY_' + m_dir_count + '\'], document.Form1.elements[\'FEE_DATE_' + m_dir_count + '\'], \'M\', \'N\');"> '+ 
				'<input class = "txt_input5" type = "text" name = "TXT_EFF_YY_'+m_dir_count+'" maxlength = "4" size = "4"  onBlur = "checkMonthLength1(document.Form1.elements[\'TXT_EFF_DD_' + m_dir_count + '\'], document.Form1.elements[\'TXT_EFF_MM_' + m_dir_count + '\'], document.Form1.elements[\'TXT_EFF_YY_' + m_dir_count + '\'], document.Form1.elements[\'FEE_DATE_' + m_dir_count + '\'], \'Y\', \'N\');"> '+
				'<input type="hidden" name="FEE_DATE_'+m_dir_count+'" id="FEE_DATE_'+m_dir_count+'"  /></DIV></td>'+ 
						'<td ><DIV id="DIV_TXT_AVAILABLE"  class="div_input" align = "center" style="width:100px"><input type="checkbox" name="CHK_FEE_'+m_dir_count+'" checked></DIV></td>'+
						'</tr>'+
						'</table>';
						}
						else {
					var fee_content = '<table  >'+
						'<tr>'+
					'<td class = "div_input" align = "center" style = "width: 170px;"></td> '+
				'<td class = "div_input" align = "center" style = "width: 180px;"></td> '+
				'<td class = "div_input" align = "center" style = "width: 170px;"></td> '+
				'<td class = "div_input" align = "center" style = "width: 180px;"></td> '+
					'<td class = "div_input" align = "center" style = "width: 170px;"></td> '+
				'<td class = "div_input" align = "center" style = "width: 275px;"></td> '+
				'<td class = "div_input" align = "center" style = "width: 170px;"></td> '+
				'<td class = "div_input" align = "center" style = "width: 170px;"></td> '+
				'<td class = "div_input" align = "center" style = "width: 160px;"></td> '+
				'<td class = "div_input" align = "center" style = "width: 100px;"></td> '+
				'</tr> '+
				'<tr> '+
				'<td ><DIV id="DIV_TXT_FEE_FEATURE_CODE"  class="div_input" style="width:185px"><input class = "txt_input" type = "text" name = "TXT_FEE_FEATURE_CODE_'+m_dir_count+'" maxlength = "10" style = "width: 125px;" onblur="help_fee_feature('+m_dir_count+',\'help_fees_feature\')" > <input class="but_input" type="button" name="FEE_FEATURE_CODE_'+m_dir_count+'" value="..." onClick="help_fee_feature('+m_dir_count+',\'help_fees_feature\')"><a onClick="help_fee_feature('+m_dir_count+',\'help_fees_feature\')" style=" text-decoration: none;cursor: text;" id="help_fees_feature" class="fancylink iframe" href=""> </a></DIV></td>'+ 
				'<td ><input class = "txt_input" type = "text" name = "TXT_FEE_FEATURE_NAME_'+m_dir_count+'" maxlength = "200" style = "width: 175px;"  disabled></td>'+ 
				'<td ><select class = "txt_input" name="TXT_FEE_TYPE_'+m_dir_count+'" style = "width: 125px;" ><option value="P" SELECTED>Percentage</option><option value="F">Flat</option><option value="V">Variable</option></select></td>'+ 
				'<td ><input class = "txt_input" type = "text" name = "TXT_FEE_AMOUNT_'+m_dir_count+'" maxlength = "25" style = "width: 125px; text-align:right;"  onchange=format_num(document.Form1.elements["TXT_FEE_AMOUNT_'+m_dir_count+'"],4)></td>'+ 
				'<td ><select class = "txt_input" name="TXT_FEE_CALC_BASIS_'+m_dir_count+'" style = "width: 125px;" disabled><option value =B029>Adjust Due Date By Client Debtor</option><option value =B025>Cash Adjustment Amount</option><option value =B024>Client Adjustment Amount</option><option value =B018>Client-Debtor Relationship Charges Amount</option><option value =B016>Credit Facility Amount</option><option value =B019>Credit Note Value</option><option value =B009>Credit Note Value>Invoice Value</option><option value =B014>Current Account Closing Balance</option><option value =B006>Each Cheques Return</option><option value =B007>Each Letter/Calling</option><option value =B021>Each Payment - Bank Transfer Amount</option><option value =B020>Each Payment - Pay Order Amount</option><option value =B036>Each Payment - Rtgs Amount</option><option value =B008>Each Visit</option><option value =B010>Every Event</option><option value =B013>Excess Amount Paid More Than Client Availability</option><option value =B002>Face Value Of The Invoice</option><option value =B001>Flat Value Basis - Not Applicable</option><option value =B015>If Service Charges Less Than The Minimum Service Charge</option><option value =B023>Invoice Adjustment Amount</option><option value =B030>Invoice Date Adjustment</option><option value =B032>Invoice Number Adjustment</option><option value =B027>Invoice Reassignment Amount</option><option value =B028>Invoice Reassignments Reversal Amount</option><option value =B003>Invoice Reversal Amount</option><option value =B033>Invoices Factored Of Each Debtor</option><option value =B022>Non Cash Debit Adjustment Amount</option><option value =B011>Outstanding Invoice Value Event Of Next Cycle</option><option value =B034>Payment Amount - If Late Processed Invoices</option><option value =B004>Per Collection Entry</option><option value =B031>Return Cheque Reassignment Amount</option><option value =B012>Settlement Entry Amount</option><option value =B017>Total Charges Of The Previous Month</option><option value =B035>Total Outstanding Sales Ledger Value</option><option value =B026>Transfer Invoice Amount</option><option value =B005>Value Of Cheque Collected</option></select></td>'+ 
				'<td ><select class = "txt_input" name="TXT_FEE_ACT_POINT_'+m_dir_count+'" style = "width: 250px;" disabled><option value =A0035>Adjustments - Approval</option><option value =A0027>Assign Debtors To Client Facility</option><option value =A0036>Auto Refactoring Approval</option><option value =A0034>Cancel Reassignment</option><option value =A0029>Change Cheque Banking Date - Approval</option><option value =A0006>Cheque Return Entering</option><option value =A0026>Client Approval</option><option value =A0014>Client Credit Approval</option><option value =A0028>Client Debtor Limit Enhancement</option><option value =A0004>Credit Note Approval </option><option value =A0002>Day End Routine</option><option value =A0031>Debtor Credit Evaluation</option><option value =A0012>Every Visit</option><option value =A0023>Facility Activation</option><option value =A0001>Invoice Approval / Confirmation</option><option value =A0033>Invoice Cancellation</option><option value =A0011>Invoice Entry</option><option value =A0003>Month End Routine</option><option value =A0030>Payment Printing</option><option value =A0007>Printing/Posting Level</option><option value =A0005>Settlement Deposit</option><option value =A0013>Settlement Entry</option><option value =A0015>Settlement Receipt Entry Print Or Post</option><option value =A0010>When Calling</option><option value =A0017>When Letter Of Demand Print Of Post</option><option value =A0022>When Making The Advise </option><option value =A0020>When Modifing Each Credit Period</option><option value =A0018>When Sending Account Statement</option><option value =A0019>When Sending Email Or Sms</option><option value =A0021>When Sending Or Printing Assignment Letters</option><option value =A0024>When Sending Or Printing Reminder Letters</option><option value =A0025>When Terminate Client Debtor Relationship</option><option value =A0016>When View Or Update Crib</option></select></td>'+ 
				'<td ><select class = "txt_input" name="TXT_TAX_APPLICABLE_'+m_dir_count+'" style = "width: 125px;" ><option value="Y">Yes</option><option value="N" selected>No</option></select></td>'+ 
				'<td ><select class = "txt_input" name="TXT_FEE_EFFECTS_'+m_dir_count+'" style = "width: 125px;" ><option value="A" SELECTED>Automatic</option><option value="M" SELECTED>Mannual</option></select></td>'+ 
				'<td ><DIV id="DIV_TXT_EFF_DATE"  class="div_input" style="width:150px"><input class = "txt_input5" type = "text" name = "TXT_EFF_DD_'+m_dir_count+'" maxlength = "2" size = "2" onBlur = "checkMonthLength1(document.Form1.elements[\'TXT_EFF_DD_' + m_dir_count + '\'], document.Form1.elements[\'TXT_EFF_MM_' + m_dir_count + '\'], document.Form1.elements[\'TXT_EFF_YY_' + m_dir_count + '\'], document.Form1.elements[\'FEE_DATE_' + m_dir_count + '\'], \'D\', \'N\');"> '+ 
				'<input class = "txt_input5" type = "text" name = "TXT_EFF_MM_'+m_dir_count+'" maxlength = "2" size = "2" onBlur = "checkMonthLength1(document.Form1.elements[\'TXT_EFF_DD_' + m_dir_count + '\'], document.Form1.elements[\'TXT_EFF_MM_' + m_dir_count + '\'], document.Form1.elements[\'TXT_EFF_YY_' + m_dir_count + '\'], document.Form1.elements[\'FEE_DATE_' + m_dir_count + '\'], \'M\', \'N\');"> '+ 
				'<input class = "txt_input5" type = "text" name = "TXT_EFF_YY_'+m_dir_count+'" maxlength = "4" size = "4" onBlur = "checkMonthLength1(document.Form1.elements[\'TXT_EFF_DD_' + m_dir_count + '\'], document.Form1.elements[\'TXT_EFF_MM_' + m_dir_count + '\'], document.Form1.elements[\'TXT_EFF_YY_' + m_dir_count + '\'], document.Form1.elements[\'FEE_DATE_' + m_dir_count + '\'], \'Y\', \'N\');"> '+
				'<input type="hidden" name="FEE_DATE_'+m_dir_count+'" id="FEE_DATE_'+m_dir_count+'"  /></DIV></td>'+ 
						'<td ><DIV id="DIV_TXT_AVAILABLE"  class="div_input" align = "center" style="width:100px"><input type="checkbox" name="CHK_FEE_'+m_dir_count+'" checked></DIV></td>'+
						'</tr>'+
						'</table>';
						}
				$('#fee_detail_data').append(fee_content); 
			init_fancybox();
			initCal("FEE_DATE_"+m_dir_count);
			document.Form1.hid_fee_count.value=m_dir_count;
			}
			*/
			
			/*			
						
			function load_fee_grid(mode){
			jQuery("#fee_data").GridUnload();
				if (mode =="NEW") 
			m_url="http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_xml_validations?q=1&chksql=m_NEW_FEE_FEATURE_FACILITY&fee_code="+document.Form1.TXT_FEE_CODE.value;
				if (mode =="EDIT") 
			m_url="http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_xml_validations?q=1&chksql=m_EDIT_FEE&fee_code="+document.Form1.TXT_FEE_CODE.value+"&facility_code="+document.Form1.TXT_FACILITY_NO.value;
				if (mode =="QUOTATION") 
			m_url="http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_xml_validations?q=1&chksql=m_LOAD_QUOTATION_FEE&fee_code="+document.Form1.TXT_FEE_CODE.value+"&quotation_code="+document.Form1.TXT_QUOTATION_NO.value;
			jQuery("#fee_data").jqGrid(
			{
				url: m_url,
				datatype: "xml",
			colNames:['Applicability','Fee Feature Code','Fee Feature Description','Fee Type', 'Fee Amount Rate', 'Calculation Basis',  'Activation Point',  'Tax Applicability', 'Fee Effects', 'Effective Date'],
			colModel:[ {name:'APPLICABILITY',index:'APPLICABILITY', width:85, align:"center",formatter:cellFomatterApplicabilityFee},
			{name:'PRO_FEATURE_CODE',index:'PRO_FEATURE_CODE', width:150, align:"left",formatter:cellFomatterFeeFeatureCode},
			{name:'PRO_FEATURE_NAME',index:'PRO_FEATURE_NAME', width:250, align:"left",formatter:cellFomatterFeeFeatureName},
			{name:'FEE_TYPE',index:'FEE_TYPE', width:130, align:"center",formatter:cellFomatterFeeType},
			{name:'AMOUNT',index:'AMOUNT', width:150, align:"center",sortable:false,formatter:cellFomatterAmount},
			{name:'CAL_BASIS',index:'CAL_BASIS', width:250, align:"center",sortable:false},
			{name:'ACT_POINT',index:'ACT_POINT', width:250, align:"center",sortable:false},
			{name:'TAX',index:'TAX', width:130, align:"center",sortable:false,formatter:cellFomatterTax},
			{name:'FEE_EFFECTS',index:'FEE_EFFECTS', width:130, align:"center",formatter:cellFomatterFeeEffects},
			{name:'DATE',index:'DATE', width:140,align:"center", sortable:false,formatter:cellFomatterDate}],
			mtype: "GET",
			loadonce: 1,
			rownumbers:true,
			rowNum:-1,
			gridview: true,
			height: 'auto',
			loadComplete : loadCountfee,
			gridComplete : function(){
			var rec_count=$("#fee_data").jqGrid('getGridParam',"records");
			init_fancybox();
			for(i=1;i<=rec_count;i++)
			initCal("FEE_DATE_"+i);
			}
			}
			);
			}
						
			*/
			
			/*			
			function loadCountfee(){
			var rec_count=$("#fee_data").jqGrid('getGridParam',"records");
			document.Form1.hid_fee_count.value=rec_count;
			}
			*/
			
			/*			
			function cellFomatterApplicabilityFee (cellvalue, options, rowObject){
				var row_id=rowObject.getAttribute('id');
				if(cellvalue=="Y") 
				var checkbox = "<input type='checkbox' id='CHK_FEE_"+row_id+"' name='CHK_FEE_"+row_id+"' checked />";
				else 
				var checkbox = "<input type='checkbox' id='CHK_FEE_"+row_id+"' name='CHK_FEE_"+row_id+"'  />";
			return checkbox;
			}
			*/			
			
			
			/*
			function cellFomatterFeeFeatureCode (cellvalue, options, rowObject){
			var row_id=rowObject.getAttribute('id');
				var texts = "<input class='txt_input' type='text' id='TXT_FEE_FEATURE_CODE_"+row_id+"' name='TXT_FEE_FEATURE_CODE_"+row_id+"' value='"+cellvalue+"' style='width:100px' maxlength='90' onblur=\"strTrim(this);help_fee_feature("+row_id+",\'help_fees_feature\')\" ><input class='but_input' type='button' name='TXT_FEE_FEATURE_CODE_"+row_id+"' value='...' onClick=\"help_fee_feature("+row_id+",\'help_fees_feature\')\" ><a onClick=\"help_fee_feature("+row_id+",\'help_fees_feature\')\" style=' text-decoration: none;cursor: text;' id='help_fees_feature' class='fancylink iframe' href=''> </a>";
			return texts;
			}
			*/
			
			/*			
			function cellFomatterFeeFeatureName (cellvalue, options, rowObject){
			var row_id=rowObject.getAttribute('id');
				var texts = "<input class='txt_input' type='text' id='TXT_FEE_FEATURE_NAME_"+row_id+"' name='TXT_FEE_FEATURE_NAME_"+row_id+"' value='"+cellvalue+"' style='width:230px' maxlength='90' disabled >";
			return texts;
			}
			*/
			
			/*		
			function cellFomatterFeeType (cellvalue, options, rowObject){
			var row_id=rowObject.getAttribute('id');
				if(cellvalue=="P") 
				var texts = "<select class='txt_input' type='text' id='TXT_FEE_TYPE_"+row_id+"' name='TXT_FEE_TYPE_"+row_id+"' style='width:100px' ><option VALUE='P' SELECTED>Percentage</option><option VALUE='V'>Variable</option><option VALUE='F'>Flat</option></select>";
				if(cellvalue=="V") 
				var texts = "<select class='txt_input' type='text' id='TXT_FEE_TYPE_"+row_id+"' name='TXT_FEE_TYPE_"+row_id+"' style='width:100px' ><option VALUE='P'>Percentage</option><option VALUE='V' SELECTED>Variable</option><option VALUE='F'>Flat</option></select>";
				if(cellvalue=="F") 
				var texts = "<select class='txt_input' type='text' id='TXT_FEE_TYPE_"+row_id+"' name='TXT_FEE_TYPE_"+row_id+"' style='width:100px' ><option VALUE='P'>Percentage</option><option VALUE='V' >Variable</option><option VALUE='F' SELECTED>Flat</option></select>";
			return texts;
			}
			*/
			
			/*			
			function cellFomatterAmount (cellvalue, options, rowObject){
			var row_id=rowObject.getAttribute('id');
				var texts = "<input class='txt_input' type='text' id='TXT_FEE_AMOUNT_"+row_id+"' name='TXT_FEE_AMOUNT_"+row_id+"' value='"+cellvalue+"' style='width:130px;text-align:right' maxlength='4000' onchange=\"format_num(this, 4);\" />";
			return texts;
			}
			*/
			
			/*			
			function cellFomatterTax (cellvalue, options, rowObject){
			var row_id=rowObject.getAttribute('id');
				if(cellvalue=="Y") 
				var texts = "<select class='txt_input' type='text' id='TXT_TAX_APPLICABLE_"+row_id+"' name='TXT_TAX_APPLICABLE_"+row_id+"' style='width:100px' ><option VALUE='Y' SELECTED>Yes</option><option VALUE='N'>No</option></select>";
				if(cellvalue=="N") 
				var texts = "<select class='txt_input' type='text' id='TXT_TAX_APPLICABLE_"+row_id+"' name='TXT_TAX_APPLICABLE_"+row_id+"' style='width:100px' ><option VALUE='Y'>Yes</option><option VALUE='N' SELECTED>No</option></select>";
			return texts;
			}
			*/
			
			/*			
			function cellFomatterFeeEffects (cellvalue, options, rowObject){
			var row_id=rowObject.getAttribute('id');
				if(cellvalue=="A") 
				var texts = "<select class='txt_input' type='text' id='TXT_FEE_EFFECTS_"+row_id+"' name='TXT_FEE_EFFECTS_"+row_id+"' style='width:100px' ><option VALUE='A' SELECTED>Automatic</option><option VALUE='M'>Mannual</option></select>";
				if(cellvalue=="M") 
				var texts = "<select class='txt_input' type='text' id='TXT_FEE_EFFECTS_"+row_id+"' name='TXT_FEE_EFFECTS_"+row_id+"' style='width:100px' ><option VALUE='A'>Automatic</option><option VALUE='M' SELECTED>Mannual</option></select>";
			return texts;
			}
			*/			
			
			/*			
			function cellFomatterDate(cellvalue, options, rowObject){
				var row_id=rowObject.getAttribute('id');
				var m_dd=cellvalue.substr(0,2);
				var m_mm=cellvalue.substr(3,2);
				var m_yy=cellvalue.substr(6,4);
				var text = "<input type = 'text' id = 'TXT_EFF_DD_"+row_id+"' name = 'TXT_EFF_DD_"+row_id+"' maxlength = '2' size = '2'  value = '"+m_dd+"'  onBlur = 'checkMonthLength1(document.Form1.elements[TXT_EFF_DD_"+row_id+"], document.Form1.elements[TXT_EFF_MM_"+row_id+"], document.Form1.elements'TXT_EFF_YY_"+row_id+"], document.Form1.elements[FEE_DATE_"+row_id+"], 'D', 'N');' >" + 
							"<input type = 'text' id = 'TXT_EFF_MM_"+row_id+"' name = 'TXT_EFF_MM_"+row_id+"' maxlength = '2' size = '2'  value = '"+m_mm+"'  onBlur = 'checkMonthLength1(document.Form1.elements[TXT_EFF_DD_"+row_id+"], document.Form1.elements[TXT_EFF_MM_"+row_id+"], document.Form1.elements'TXT_EFF_YY_"+row_id+"], document.Form1.elements[FEE_DATE_"+row_id+"], 'M', 'N');' >" + 
							"<input type = 'text' id = 'TXT_EFF_YY_"+row_id+"' name = 'TXT_EFF_YY_"+row_id+"' maxlength = '4' size = '4'  value = '"+m_yy+"'  onBlur = 'checkMonthLength1(document.Form1.elements[TXT_EFF_DD_"+row_id+"], document.Form1.elements[TXT_EFF_MM_"+row_id+"], document.Form1.elements'TXT_EFF_YY_"+row_id+"], document.Form1.elements[FEE_DATE_"+row_id+"], 'Y', 'N');' >" + 
							"<input type = 'hidden' id = 'FEE_DATE_"+row_id+"' name = 'FEE_DATE_"+row_id+"'  /> " ;
				return text;
			}
			*/
			
			
			function add_third_party_guarantors_details() {
				var m_new_total_count = parseInt(document.Form1.hid_third_party_guarantors_details_count.value) + 1;
				if (parseInt(document.Form1.hid_third_party_guarantors_details_count.value) == 0) {
					document.getElementById("DIV_THIRD_PARTY_GUARANTORS_DETAILS").innerHTML = '';
				}
				createDIV('DIV_THIRD_PARTY_GUARANTORS_DETAILS', m_new_total_count);
				if (parseInt(document.Form1.hid_third_party_guarantors_details_count.value) == 0) {
					document.getElementById("DIV_THIRD_PARTY_GUARANTORS_DETAILS" + m_new_total_count).innerHTML = '' + 
					'   <table> ' + 
						'       <tr> ' + 
						'           <td class = "div_input" align = "center" style = "width: 50px;"></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 50px;"></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Customer Type</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 250px;"><div id = "DIV_TXT_S03_COMPANY_NAME_' + m_new_total_count + '"><b>Company Name</b></div></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><div id = "DIV_TXT_S03_REG_NO_' + m_new_total_count + '"><b>Business Registration Number</b></div></td> ' + 
						'       </tr> ' + 
						'       <tr> ' + 
						'           <td><input class = "but_input" type = "button" name = "BUT_ADD_THIRD_PARTY_GUARANTORS_DETAILS" value = "+" onClick = "add_third_party_guarantors_details();" /></td> ' + 
						'           <td><input class = "but_input" type = "button" name = "BUT_DELETE_THIRD_PARTY_GUARANTORS_DETAILS" value = "-" onClick = "delete_third_party_guarantors_details(' + m_new_total_count + ');" /></td> ' + 
						'           <td><select class = "txt_input" name="TXT_S03_CUSTOMER_TYPE_' + m_new_total_count + '" style = "width: 125px;" onChange = "hideCompanyNameLabelGuarantee(' + m_new_total_count + ')" /><option value = "C">Corporate</option><option value = "I">Individual</option></select></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_COMPANY_NAME_' + m_new_total_count + '" maxlength = "100" style = "width: 250px;" onBlur = "strTrim(this, null, null, \'NAME\'); strProperCase(this);" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_REG_NO_' + m_new_total_count + '"  maxlength = "20" style = "width: 250px;" onBlur = "strTrim(this);" /></td> ' + 
						'       </tr> ' + 
						'   </table> ' + 
						'   <table> ' + 
						'       <tr> ' + 
						'           <td class = "div_input" align = "center" style = "width: 50px;"></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 50px;"></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Type</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 75px;"><div id = "DIV_TXT_S03_TITLE_' + m_new_total_count + '"><b>Title</b></DIV></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><div id = "DIV_TXT_S03_LAST_NAME_' + m_new_total_count + '"><b>Last Name</b></DIV></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 75px;"><div id = "DIV_TXT_S03_INITIALS_' + m_new_total_count + '"><b>Initials</b></DIV></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 250px;"><div id = "DIV_TXT_S03_INITIALS_DETAILS_' + m_new_total_count + '"><b>Name Denoted by Initials</b></DIV></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><div id = "DIV_TXT_S03_NIC_' + m_new_total_count + '"><b>NIC</b></DIV></td> ' + 
						'       </tr> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td><select class = "txt_input" name="TXT_S03_TYPE_' + m_new_total_count + '" style = "width: 125px;" /> ' + m_types_guarantor + ' </select></td> ' + 
						'           <td><select class = "txt_input" name="TXT_S03_TITLE_' + m_new_total_count + '" style = "width: 75px;" /> ' + m_types_title + ' </select></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_LAST_NAME_' + m_new_total_count + '" maxlength = "100" style = "width: 125px;" onBlur = "strTrim(this, null, null, \'NAME\'); strProperCase(this);" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_INITIALS_' + m_new_total_count + '" maxlength = "30" style = "width: 75px;" onBlur = "strTrim(this);" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_INITIALS_DETAILS_' + m_new_total_count + '" maxlength = "400" style = "width: 250px;" onBlur = "strTrim(this, null, null, \'NAME\'); strProperCase(this); setInitials(this, document.Form1.elements[\'TXT_S03_INITIALS_' + m_new_total_count + '\']);" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_NIC_' + m_new_total_count + '" maxlength = "10" style = "width: 125px;" onBlur = "validateNIC(this);" /></td> ' + 
						'       </tr> ' + 
						'   </table> ' + 
						'   <table> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Address Type</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Ownership</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 250px;"><b>Address Line 1</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 250px;"><b>Address Line 2</b></td> ' + 
						'       </tr> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td><select class = "txt_input" name="TXT_S03_ADDRESS_TYPE_' + m_new_total_count + '" style = "width: 125px;" /> ' + m_types_address + ' </select></td> ' + 
						'           <td><select class = "txt_input" name="TXT_S03_OWNERSHIP_' + m_new_total_count + '" style = "width: 125px;" /> ' + m_types_ownership + ' </select></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_ADDRESS_LINE_1_' + m_new_total_count + '" maxlength = "100" style = "width: 250px;" onBlur = "strTrim(this, null, null, \'ADDRESS\'); strProperCase(this);" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_ADDRESS_LINE_2_' + m_new_total_count + '" maxlength = "100" style = "width: 250px;" onBlur = "strTrim(this, null, null, \'ADDRESS\'); strProperCase(this);" /></td> ' + 
						'       </tr> ' + 
						'   </table> ' + 
						'   <table> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 175px;"><b>City</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>District</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Province</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Country</b></td> ' + 
						'       </tr> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td> ' + 
						'               <input type = "hidden" name = "TXT_S03_CITY_' + m_new_total_count + '" /> ' + 
						'               <input class = "txt_input" type = "text" name = "TXT_S03_CITY_NAME_' + m_new_total_count + '" maxlength = "50" onBlur = "strTrim(this); help_update_s03_city(\'help_update_s03_city_' + m_new_total_count + '\', ' + '\'' + m_new_total_count + '\');" style = "width: 125px;" /> ' + 
						'               <input class = "but_input" type = "button" name = "BUT_HELP_S03_CITY" value = "..." onClick = "help_update_s03_city(\'help_update_s03_city_' + m_new_total_count + '\', ' + '\'' + m_new_total_count + '\');" /><a id = "help_update_s03_city_' + m_new_total_count + '" style = "{text-decoration: none; cursor: text;}" class = "fancylink iframe" href = "" > </a> ' + 
						'           </td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_DISTRICT_NAME_' + m_new_total_count + '" disabled = "disabled" style = "width: 125px;" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_PROVINCE_NAME_' + m_new_total_count + '" disabled = "disabled" style = "width: 125px;" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_COUNTRY_NAME_' + m_new_total_count + '" disabled = "disabled" style = "width: 125px;" /></td> ' + 
						'       </tr> ' + 
						'   </table> ' + 
						'   <table> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Telephone 1</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Telephone 2</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Mobile</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Fax</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 175px;"><b>Email</b></td> ' + 
						'       </tr> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_TELEPHONE_1_' + m_new_total_count + '" maxlength = "14" value= "0094" style = "width: 125px;" onBlur = "validatePhoneNumber(this, \'Telephone\');" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_TELEPHONE_2_' + m_new_total_count + '" maxlength = "14" value= "0094" style = "width: 125px;" onBlur = "validatePhoneNumber(this, \'Telephone\');" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_MOBILE_' + m_new_total_count + '" maxlength = "14" value= "0094" style = "width: 125px;" onBlur = "validatePhoneNumber(this, \'Mobile\');" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_FAX_' + m_new_total_count + '" maxlength = "14" value= "0094" style = "width: 125px;" onBlur = "validatePhoneNumber(this, \'Fax\');" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_EMAIL_' + m_new_total_count + '" maxlength = "100" style = "width: 175px;" onBlur ="validateEmail(this);" /></td> ' + 
						'       </tr> ' + 
						'   </table> ' + 
						'   <table> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 250px;"><b>Comments</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Net Worth</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>CRIB Comments</b></td> ' + 
						'       </tr> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_COMMENTS_' + m_new_total_count + '" maxlength = "4000" style = "width: 250px;" onBlur = "strTrim(this);" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_NETWORTH_' + m_new_total_count + '" value = "0.00" maxlength = "24" style = "width: 125px; text-align: right;" onBlur = "validateNumber(this, 0, 9999999999999999.99, 2, \'number\')" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_CRIB_COMMENTS_' + m_new_total_count + '" maxlength = "4000" style = "width: 250px;" onBlur = "strTrim(this);" /> </td>' + 
						'       </tr> ' + 
						'   </table> '+ 
						'   <table> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Indemnity Type</b></td> ' + 
						'       </tr> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td><select class = "txt_input" name="TXT_S03_INDEMNITY_TYPE_' + m_new_total_count + '" style = "width: 125px;" onChange = "" /><option value = "J">Joint</option><option value = "P">Personal</option></select></td> ' + 
						'       </tr> ' + 
						'   </table> '; 
				}
				else {
					document.getElementById("DIV_THIRD_PARTY_GUARANTORS_DETAILS" + m_new_total_count).innerHTML = '' + 
					'   <table> ' + 
						'       <tr> ' + 
						'           <td class = "div_input" align = "center" style = "width: 50px;"></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 50px;"></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Customer Type</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 250px;"><div id = "DIV_TXT_S03_COMPANY_NAME_' + m_new_total_count + '"><b>Company Name</b></div></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><div id = "DIV_TXT_S03_REG_NO_' + m_new_total_count + '"><b>Business Registration Number</b></div></td> ' + 
						'       </tr> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td><input class = "but_input" type = "button" name = "BUT_DELETE_THIRD_PARTY_GUARANTORS_DETAILS" value = "-" onClick = "delete_third_party_guarantors_details(' + m_new_total_count + ');" /></td> ' + 
						'           <td><select class = "txt_input" name="TXT_S03_CUSTOMER_TYPE_' + m_new_total_count + '" style = "width: 125px;" onChange = "hideCompanyNameLabelGuarantee(' + m_new_total_count + ')" /><option value = "C">Corporate</option><option value = "I">Individual</option></select></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_COMPANY_NAME_' + m_new_total_count + '" maxlength = "100" style = "width: 250px;" onBlur = "strTrim(this, null, null, \'NAME\'); strProperCase(this);" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_REG_NO_' + m_new_total_count + '" id = "TXT_S03_REG_NO_" maxlength = "20" style = "width: 250px;" onBlur = "strTrim(this);" /></td> ' + 
						'       </tr> ' + 
						'   </table> ' + 
						'   <table> ' + 
						'       <tr> ' + 
						'           <td class = "div_input" align = "center" style = "width: 50px;"></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 50px;"></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Type</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 75px;"><div id = "DIV_TXT_S03_TITLE_' + m_new_total_count + '"><b>Title</b></div></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><div id = "DIV_TXT_S03_LAST_NAME_' + m_new_total_count + '"><b>Last Name</b></div></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 75px;"><div id = "DIV_TXT_S03_INITIALS_' + m_new_total_count + '"><b>Initials</b></div></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 250px;"><div id = "DIV_TXT_S03_INITIALS_DETAILS_' + m_new_total_count + '"><b>Name Denoted by Initials</b></div></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><div id = "DIV_TXT_S03_NIC_' + m_new_total_count + '"><b>NIC</b></DIV></td> ' + 
						'       </tr> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td><select class = "txt_input" name="TXT_S03_TYPE_' + m_new_total_count + '" style = "width: 125px;" /> ' + m_types_guarantor + ' </select></td> ' + 
						'           <td><select class = "txt_input" name="TXT_S03_TITLE_' + m_new_total_count + '" style = "width: 75px;" /> ' + m_types_title + ' </select></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_LAST_NAME_' + m_new_total_count + '" maxlength = "100" style = "width: 125px;" onBlur = "strTrim(this, null, null, \'NAME\'); strProperCase(this);" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_INITIALS_' + m_new_total_count + '" maxlength = "30" style = "width: 75px;" onBlur = "strTrim(this);" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_INITIALS_DETAILS_' + m_new_total_count + '" maxlength = "400" style = "width: 250px;" onBlur = "strTrim(this, null, null, \'NAME\'); strProperCase(this); setInitials(this, document.Form1.elements[\'TXT_S03_INITIALS_' + m_new_total_count + '\']);" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_NIC_' + m_new_total_count + '" maxlength = "10" style = "width: 125px;" onBlur = "validateNIC(this);" /></td> ' + 
						'       </tr> ' + 
						'   </table> ' + 
						'   <table> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Address Type</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Ownership</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 250px;"><b>Address Line 1</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 250px;"><b>Address Line 2</b></td> ' + 
						'       </tr> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td><select class = "txt_input" name="TXT_S03_ADDRESS_TYPE_' + m_new_total_count + '" style = "width: 125px;" /> ' + m_types_address + ' </select></td> ' + 
						'           <td><select class = "txt_input" name="TXT_S03_OWNERSHIP_' + m_new_total_count + '" style = "width: 125px;" /> ' + m_types_ownership + ' </select></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_ADDRESS_LINE_1_' + m_new_total_count + '" maxlength = "100" style = "width: 250px;" onBlur = "strTrim(this, null, null, \'ADDRESS\'); strProperCase(this);" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_ADDRESS_LINE_2_' + m_new_total_count + '" maxlength = "100" style = "width: 250px;" onBlur = "strTrim(this, null, null, \'ADDRESS\'); strProperCase(this);" /></td> ' + 
						'       </tr> ' + 
						'   </table> ' + 
						'   <table> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 175px;"><b>City</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>District</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Province</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Country</b></td> ' + 
						'       </tr> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td> ' + 
						'               <input type = "hidden" name = "TXT_S03_CITY_' + m_new_total_count + '" /> ' + 
						'               <input class = "txt_input" type = "text" name = "TXT_S03_CITY_NAME_' + m_new_total_count + '" maxlength = "50" onBlur = "strTrim(this); help_update_s03_city(\'help_update_s03_city_' + m_new_total_count + '\', ' + '\'' + m_new_total_count + '\');" style = "width: 125px;" /> ' + 
						'               <input class = "but_input" type = "button" name = "BUT_HELP_S03_CITY" value = "..." onClick = "help_update_s03_city(\'help_update_s03_city_' + m_new_total_count + '\', ' + '\'' + m_new_total_count + '\');" /><a id = "help_update_s03_city_' + m_new_total_count + '" style = "{text-decoration: none; cursor: text;}" class = "fancylink iframe" href = "" > </a> ' + 
						'           </td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_DISTRICT_NAME_' + m_new_total_count + '" disabled = "disabled" style = "width: 125px;" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_PROVINCE_NAME_' + m_new_total_count + '" disabled = "disabled" style = "width: 125px;" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_COUNTRY_NAME_' + m_new_total_count + '" disabled = "disabled" style = "width: 125px;" /></td> ' + 
						'       </tr> ' + 
						'   </table> ' + 
						'   <table> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Telephone 1</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Telephone 2</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Mobile</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Fax</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 175px;"><b>Email</b></td> ' + 
						'       </tr> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_TELEPHONE_1_' + m_new_total_count + '" maxlength = "14" value= "0094" style = "width: 125px;" onBlur = "validatePhoneNumber(this, \'Telephone\');" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_TELEPHONE_2_' + m_new_total_count + '" maxlength = "14" value= "0094" style = "width: 125px;" onBlur = "validatePhoneNumber(this, \'Telephone\');" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_MOBILE_' + m_new_total_count + '" maxlength = "14" value= "0094" style = "width: 125px;" onBlur = "validatePhoneNumber(this, \'Mobile\');" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_FAX_' + m_new_total_count + '" maxlength = "14" value= "0094" style = "width: 125px;" onBlur = "validatePhoneNumber(this, \'Fax\');" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_EMAIL_' + m_new_total_count + '" maxlength = "100" style = "width: 175px;" onBlur ="validateEmail(this);" /></td> ' + 
						'       </tr> ' + 
						'   </table> ' + 
						'   <table> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 250px;"><b>Comments</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Net Worth</b></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 250px;"><b>CRIB Comments</b></td> ' + 
						'       </tr> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_COMMENTS_' + m_new_total_count + '" maxlength = "4000" style = "width: 250px;" onBlur = "strTrim(this);" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_NETWORTH_' + m_new_total_count + '" value = "0.00" maxlength = "24" style = "width: 125px; text-align: right;" onBlur = "validateNumber(this, 0, 9999999999999999.99, 2, \'number\')" /></td> ' + 
						'           <td><input class = "txt_input" type = "text" name = "TXT_S03_CRIB_COMMENTS_' + m_new_total_count + '" maxlength = "4000" style = "width: 250px;" onBlur = "strTrim(this);" /> </td>' + 
						'       </tr> ' + 
						'   </table> '+ 
						'   <table> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td class = "div_input" align = "center" style = "width: 125px;"><b>Indemnity Type</b></td> ' + 
						'       </tr> ' + 
						'       <tr> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td style = "width: 50px;"></td> ' + 
						'           <td><select class = "txt_input" name="TXT_S03_INDEMNITY_TYPE_' + m_new_total_count + '" style = "width: 125px;" onChange = "" /><option value = "J">Joint</option><option value = "P">Personal</option></select></td> ' + 
						'       </tr> ' + 
						'   </table> '; 
				}
				document.Form1.hid_third_party_guarantors_details_count.value = m_new_total_count;
				hideCompanyNameLabelGuarantee(m_new_total_count);
				init_fancybox();
			}
			function delete_third_party_guarantors_details(m_selected_row_number) {
				var m_flag_clear = false;
				if ((parseInt(m_selected_row_number) > 0) && (confirm('Are you sure you want to delete?'))) {
					var m_total_count = parseInt(document.Form1.hid_third_party_guarantors_details_count.value);
					document.Form1.hid_third_party_guarantors_details_count.value = 0;
					var m_count = 0;
					var value01 = new Array();
					var value02 = new Array();
					var value03 = new Array();
					var value04 = new Array();
					var value05 = new Array();
					var value06 = new Array();
					var value07 = new Array();
					var value08 = new Array();
					var value09 = new Array();
					var value10 = new Array();
					var value11 = new Array();
					var value12 = new Array();
					var value13 = new Array();
					var value14 = new Array();
					var value15 = new Array();
					var value16 = new Array();
					var value17 = new Array();
					var value18 = new Array();
					var value19 = new Array();
					var value20 = new Array();
					var value21 = new Array();
					var value22 = new Array();
					var value23 = new Array();
					var value24 = new Array();
					var value26 = new Array();
					var value27 = new Array();
					var value28 = new Array();
					for (var i = 1; i <= m_total_count; i++) {
						if (i != m_selected_row_number) {
							m_count = m_count + 1;
							value01[m_count] = document.Form1.elements["TXT_S03_TYPE_" + i].value;
							value02[m_count] = document.Form1.elements["TXT_S03_TITLE_" + i].value;
							value03[m_count] = document.Form1.elements["TXT_S03_LAST_NAME_" + i].value;
							value04[m_count] = document.Form1.elements["TXT_S03_INITIALS_" + i].value;
							value05[m_count] = document.Form1.elements["TXT_S03_INITIALS_DETAILS_" + i].value;
							value06[m_count] = document.Form1.elements["TXT_S03_NIC_" + i].value;
							value07[m_count] = document.Form1.elements["TXT_S03_ADDRESS_TYPE_" + i].value;
							value08[m_count] = document.Form1.elements["TXT_S03_OWNERSHIP_" + i].value;
							value09[m_count] = document.Form1.elements["TXT_S03_ADDRESS_LINE_1_" + i].value;
							value10[m_count] = document.Form1.elements["TXT_S03_ADDRESS_LINE_2_" + i].value;
							value11[m_count] = document.Form1.elements["TXT_S03_CITY_" + i].value;
							value12[m_count] = document.Form1.elements["TXT_S03_CITY_NAME_" + i].value;
							value13[m_count] = document.Form1.elements["TXT_S03_DISTRICT_NAME_" + i].value;
							value14[m_count] = document.Form1.elements["TXT_S03_PROVINCE_NAME_" + i].value;
							value15[m_count] = document.Form1.elements["TXT_S03_COUNTRY_NAME_" + i].value;
							value16[m_count] = document.Form1.elements["TXT_S03_TELEPHONE_1_" + i].value;
							value17[m_count] = document.Form1.elements["TXT_S03_TELEPHONE_2_" + i].value;
							value18[m_count] = document.Form1.elements["TXT_S03_MOBILE_" + i].value;
							value19[m_count] = document.Form1.elements["TXT_S03_FAX_" + i].value;
							value20[m_count] = document.Form1.elements["TXT_S03_EMAIL_" + i].value;
							value21[m_count] = document.Form1.elements["TXT_S03_COMMENTS_" + i].value;
							value22[m_count] = document.Form1.elements["TXT_S03_COMPANY_NAME_" + i].value;
							value23[m_count] = document.Form1.elements["TXT_S03_NETWORTH_" + i].value;
							value24[m_count] = document.Form1.elements["TXT_S03_CRIB_COMMENTS_" + i].value;
							value26[m_count] = document.Form1.elements["TXT_S03_REG_NO_" + i].value;
							value27[m_count] = document.Form1.elements["TXT_S03_INDEMNITY_TYPE_" + i].value;
							value28[m_count] = document.Form1.elements["TXT_S03_CUSTOMER_TYPE_" + i].value;
						}
					}
					for (var i = 1; i <= m_count; i++) {
						add_third_party_guarantors_details();
					}
					for (var i = 1; i <= m_count; i++) {;
						document.Form1.elements["TXT_S03_TYPE_" + i].value = value01[i];
						document.Form1.elements["TXT_S03_TITLE_" + i].value = value02[i];
						document.Form1.elements["TXT_S03_LAST_NAME_" + i].value = value03[i];
						document.Form1.elements["TXT_S03_INITIALS_" + i].value = value04[i];
						document.Form1.elements["TXT_S03_INITIALS_DETAILS_" + i].value = value05[i];
						document.Form1.elements["TXT_S03_NIC_" + i].value = value06[i];
						document.Form1.elements["TXT_S03_ADDRESS_TYPE_" + i].value = value07[i];
						document.Form1.elements["TXT_S03_OWNERSHIP_" + i].value = value08[i];
						document.Form1.elements["TXT_S03_ADDRESS_LINE_1_" + i].value = value09[i];
						document.Form1.elements["TXT_S03_ADDRESS_LINE_2_" + i].value = value10[i];
						document.Form1.elements["TXT_S03_CITY_" + i].value = value11[i];
						document.Form1.elements["TXT_S03_CITY_NAME_" + i].value = value12[i];
						document.Form1.elements["TXT_S03_DISTRICT_NAME_" + i].value = value13[i];
						document.Form1.elements["TXT_S03_PROVINCE_NAME_" + i].value = value14[i];
						document.Form1.elements["TXT_S03_COUNTRY_NAME_" + i].value = value15[i];
						document.Form1.elements["TXT_S03_TELEPHONE_1_" + i].value = value16[i];
						document.Form1.elements["TXT_S03_TELEPHONE_2_" + i].value = value17[i];
						document.Form1.elements["TXT_S03_MOBILE_" + i].value = value18[i];
						document.Form1.elements["TXT_S03_FAX_" + i].value = value19[i];
						document.Form1.elements["TXT_S03_EMAIL_" + i].value = value20[i];
						document.Form1.elements["TXT_S03_COMMENTS_" + i].value = value21[i];
						document.Form1.elements["TXT_S03_COMPANY_NAME_" + i].value = value22[i];
						document.Form1.elements["TXT_S03_NETWORTH_" + i].value = value23[i];
						document.Form1.elements["TXT_S03_CRIB_COMMENTS_" + i].value = value24[i];
						document.Form1.elements["TXT_S03_REG_NO_" + i].value = value26[i];
						document.Form1.elements["TXT_S03_INDEMNITY_TYPE_" + i].value = value27[i];
						document.Form1.elements["TXT_S03_CUSTOMER_TYPE_" + i].value = value28[i];
						hideCompanyNameLabelGuarantee(i);
					}
					document.Form1.hid_third_party_guarantors_details_count.value = m_count;
					if (m_count == 0) {
						m_flag_clear = true;
					}
				}
				if (m_selected_row_number == 0) {
					m_flag_clear = true;
				}
				if (m_flag_clear == true) {
					document.getElementById("DIV_THIRD_PARTY_GUARANTORS_DETAILS").innerHTML = '' + 
					'   <table> ' + 
						'       <tr> ' + 
						'           <td class = "div_input" align = "center" style = "width: 50px;"></td> ' + 
						'       </tr> ' + 
						'       <tr> ' + 
						'           <td><input class = "but_input" type = "button" name = "BUT_ADD_THIRD_PARTY_GUARANTORS_DETAILS" value = "+" onClick = "add_third_party_guarantors_details();" /></td> ' + 
						'       </tr> ' + 
						'   </table> '; 
				}
			}
			function hideCompanyNameLabelGuarantee(m_row_number) {
				var str_customer_type_object_name      = 'TXT_S03_CUSTOMER_TYPE_' + m_row_number;
				var str_company_name_object_name       = 'TXT_S03_COMPANY_NAME_' + m_row_number;
				var str_company_name_div_tag_id        = 'DIV_TXT_S03_COMPANY_NAME_' + m_row_number;
				var str_reg_no_object_name             = 'TXT_S03_REG_NO_' + m_row_number;
				var str_reg_no_div_tag_id              = 'DIV_TXT_S03_REG_NO_' + m_row_number;
				var str_nic_object_name                = 'TXT_S03_NIC_' + m_row_number;
				var str_nic_div_tag_id                 = 'DIV_TXT_S03_NIC_' + m_row_number;
				var str_first_name_object_name         = 'TXT_S03_INITIALS_DETAILS_' + m_row_number;
				var str_first_name_div_tag_id          = 'DIV_TXT_S03_INITIALS_DETAILS_' + m_row_number;
				var str_intials_object_name            = 'TXT_S03_INITIALS_' + m_row_number;
				var str_intials_div_tag_id             = 'DIV_TXT_S03_INITIALS_' + m_row_number;
				var str_last_name_object_name          = 'TXT_S03_LAST_NAME_' + m_row_number;
				var str_last_name_div_tag_id           = 'DIV_TXT_S03_LAST_NAME_' + m_row_number;
				var str_title_object_name              = 'TXT_S03_TITLE_' + m_row_number;
				var str_title_div_tag_id               = 'DIV_TXT_S03_TITLE_' + m_row_number;
				if (document.forms[0].elements[str_customer_type_object_name].value == 'I') {
					document.forms[0].elements[str_company_name_object_name].value = '';
					document.forms[0].elements[str_company_name_object_name].style.visibility = 'hidden';
					document.getElementById(str_company_name_div_tag_id).style.visibility = 'hidden';
					document.forms[0].elements[str_reg_no_object_name].value = '';
					document.forms[0].elements[str_reg_no_object_name].style.visibility = 'hidden';
					document.getElementById(str_reg_no_div_tag_id).style.visibility = 'hidden';
					document.forms[0].elements[str_nic_object_name].style.visibility = 'visible';
					document.getElementById(str_nic_div_tag_id).style.visibility = 'visible';
					document.forms[0].elements[str_first_name_object_name].style.visibility = 'visible';
					document.getElementById(str_first_name_div_tag_id).style.visibility = 'visible';
					document.forms[0].elements[str_intials_object_name].style.visibility = 'visible';
					document.getElementById(str_intials_div_tag_id).style.visibility = 'visible';
					document.forms[0].elements[str_last_name_object_name].style.visibility = 'visible';
					document.getElementById(str_last_name_div_tag_id).style.visibility = 'visible';
					document.forms[0].elements[str_title_object_name].style.visibility = 'visible';
					document.getElementById(str_title_div_tag_id).style.visibility = 'visible';
				}
				else if (document.forms[0].elements[str_customer_type_object_name].value == 'C') {
					document.forms[0].elements[str_company_name_object_name].style.visibility = 'visible';
					document.getElementById(str_company_name_div_tag_id).style.visibility = 'visible';
					document.forms[0].elements[str_reg_no_object_name].style.visibility = 'visible';
					document.getElementById(str_reg_no_div_tag_id).style.visibility = 'visible';
					document.forms[0].elements[str_nic_object_name].value = '';
					document.forms[0].elements[str_nic_object_name].style.visibility = 'hidden';
					document.getElementById(str_nic_div_tag_id).style.visibility = 'hidden';
					document.forms[0].elements[str_first_name_object_name].value = '';
					document.forms[0].elements[str_first_name_object_name].style.visibility = 'hidden';
					document.getElementById(str_first_name_div_tag_id).style.visibility = 'hidden';
					document.forms[0].elements[str_intials_object_name].value = '';
					document.forms[0].elements[str_intials_object_name].style.visibility = 'hidden';
					document.getElementById(str_intials_div_tag_id).style.visibility = 'hidden';
					document.forms[0].elements[str_last_name_object_name].value = '';
					document.forms[0].elements[str_last_name_object_name].style.visibility = 'hidden';
					document.getElementById(str_last_name_div_tag_id).style.visibility = 'hidden';
					document.forms[0].elements[str_title_object_name].value = '';
					document.forms[0].elements[str_title_object_name].style.visibility = 'hidden';
					document.getElementById(str_title_div_tag_id).style.visibility = 'hidden';
				}
			}
			function createDIV(div_name, row_number) {
				var dynDiv = document.createElement("div");
				dynDiv.id = div_name + row_number;
				document.getElementById(div_name).appendChild(dynDiv);
			}
			function checkSecurityTypes(m_type,m_desc) {
				var m_flag = false;
				m_count = document.Form1.hid_security_setup_count.value;
				for (var i = 1; i <= m_count; i++) {
					if (document.Form1.elements["TXT_S05_SEC_TYPE_"+i].value == m_type) {
						m_flag = true;
					}
				}
				if (m_flag == true) {
					alert('Selected Security Type already added.');
					document.Form1.TXT_SECURITY_CODE.value='';
					m_flag = false;
				}
				else{
					add_proposed_security();
					var k = parseInt(document.Form1.hid_security_setup_count.value);
					document.Form1.elements["TXT_S05_SEC_TYPE_"+k].value=m_type;
					document.Form1.elements["TXT_S05_SEC_TYPE_DESC_"+k].value=m_desc;
				}
			}
			function add_proposed_security() {
				document.Form1.TXT_SECURITY_CODE.value="";
				var count = parseInt(document.Form1.hid_security_setup_count.value) + 1;
				if (parseInt(document.Form1.hid_security_setup_count.value) == 0) {
					document.getElementById("security_setup").innerHTML = '';
				}
				createDIV('security_setup', count);
				document.getElementById("security_setup" + count).innerHTML = '' + 
				'   <table> ' + 
					'       <tr> ' + 
					'		<td style = "width: 10%;"><input class = "txt_input" type = "text" name = "TXT_S05_SEC_TYPE_DESC_' + count + '" style = "width: 200px;border:0px;" readonly="readonly" />'+
					'			<input type = "hidden" name = "TXT_S05_TYPE_' + count + '"               id = "TXT_S05_TYPE_' + count + '" />'+
					'			<input type = "hidden" name = "TXT_S05_SEC_TYPE_' + count + '"           id = "TXT_S05_SEC_TYPE_' + count + '" />'+
					'			<input type = "hidden" name = "TXT_S05_COLLATERAL_AMOUNT_' + count + '"  id = "TXT_S05_COLLATERAL_AMOUNT_' + count + '" />'+
					'			<input type = "hidden" name = "TXT_S05_FORCED_SALE_VALUE_' + count + '"  id = "TXT_S05_FORCED_SALE_VALUE_' + count + '" />'+
					'			<input type = "hidden" name = "TXT_S05_AMOUNT_CONSIDERED_' + count + '"  id = "TXT_S05_AMOUNT_CONSIDERED_' + count + '" />'+
					'			<input type = "hidden" name = "TXT_S05_AMOUNT_CONSIDERED_PERCENT_' + count + '"  id = "TXT_S05_AMOUNT_CONSIDERED_PERCENT_' + count + '" /></td>'+
					'			<td style = "width: 10%;" ><input class="but_input" type="button" name="BUT_LINK" value="Link" onClick="openPopupProposedSecurityDetails('+count+');">'+
					'			<input class="but_input" type="button" name="BUT_DELETE" value="-" onClick="deletePopupProposedSecurityDetails('+count+');"></td>'+
					'			<td style = "width: 10%;" ><input class = "txt_input" type = "text" name = "TXT_S05_SEC_TYPE_AMOUNT_' + count + '"  id = "TXT_S05_SEC_TYPE_AMOUNT_' + count + '" style = "width: 150px;text-align:right;border:0px;"  readonly="readonly" /><div></td>'+
					'			<td style = "width: *%;" ></td>'+
					'		</tr>'+
					'   </table> '; 
				document.Form1.hid_security_setup_count.value = count;
			}
			function deletePopupProposedSecurityDetails(m_selected_row_number) {
				var m_flag_clear = false;
				var m_type = document.Form1.elements["TXT_S05_SEC_TYPE_" + m_selected_row_number].value;
				if ((parseInt(m_selected_row_number) > 0) && (confirm('Are you sure you want to delete?'))) {
					delete_proposed_secuirities_data(m_type);
					var m_total_count = parseInt(document.Form1.hid_security_setup_count.value);
					document.Form1.hid_security_setup_count.value = 0;
					var m_count = 0;
					var value01 = new Array();
					var value02 = new Array();
					var value03 = new Array();
					var value04 = new Array();
					var value05 = new Array();
					var value06 = new Array();
					var value07 = new Array();
					var value08 = new Array();
					for (var i = 1; i <= m_total_count; i++) {
						if (i != m_selected_row_number) {
							m_count = m_count + 1;
							value01[m_count] = document.Form1.elements["TXT_S05_SEC_TYPE_DESC_" + i].value;
							value02[m_count] = document.Form1.elements["TXT_S05_TYPE_" + i].value;
							value03[m_count] = document.Form1.elements["TXT_S05_SEC_TYPE_" + i].value;
							value04[m_count] = document.Form1.elements["TXT_S05_SEC_TYPE_AMOUNT_" + i].value;
							value05[m_count] = document.Form1.elements["TXT_S05_COLLATERAL_AMOUNT_" + i].value;
							value06[m_count] = document.Form1.elements["TXT_S05_FORCED_SALE_VALUE_" + i].value;
							value07[m_count] = document.Form1.elements["TXT_S05_AMOUNT_CONSIDERED_" + i].value;
							value08[m_count] = document.Form1.elements["TXT_S05_AMOUNT_CONSIDERED_PERCENT_" + i].value;
						}
					}
					for (var i = 1; i <= m_count; i++) {
						add_proposed_security();
					}
					for (var i = 1; i <= m_count; i++) {;
						document.Form1.elements["TXT_S05_SEC_TYPE_DESC_" + i].value = value01[i];
						document.Form1.elements["TXT_S05_TYPE_" + i].value = value02[i];
						document.Form1.elements["TXT_S05_SEC_TYPE_" + i].value = value03[i];
						document.Form1.elements["TXT_S05_SEC_TYPE_AMOUNT_" + i].value = value04[i];
						document.Form1.elements["TXT_S05_COLLATERAL_AMOUNT_" + i].value = value05[i];
						document.Form1.elements["TXT_S05_FORCED_SALE_VALUE_" + i].value = value06[i];
						document.Form1.elements["TXT_S05_AMOUNT_CONSIDERED_" + i].value = value07[i];
						document.Form1.elements["TXT_S05_AMOUNT_CONSIDERED_PERCENT_" + i].value = value08[i];
					}
					document.Form1.hid_security_setup_count.value = m_count;
					if (m_count == 0) {
						m_flag_clear = true;
					}
				}
				if (m_selected_row_number == 0) {
					m_flag_clear = true;
				}
				if (m_flag_clear == true) {
					document.getElementById("security_setup").innerHTML = ''; 
				}
			}
			function delete_proposed_secuirities_data(m_type) {
				if(document.Form1.SCREEN_NAME.value == "NEW") {
					m_url="http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_sql_validations?chksql=m_DELETE_TEMP_PROPOSED_SECURITIES&account_no="+document.Form1.TXT_ACC_CODE.value+"&type="+m_type;
				}
				else {
					m_url="http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_sql_validations?chksql=m_DELETE_PROPOSED_SECURITIES&facility_no="+document.Form1.TXT_FACILITY_NO.value+"&type="+m_type;
				}
				load_interface(m_url,'XML');
			}
			function openPopupProposedSecurityDetails(m_count) {
				var m_screen_name = document.Form1.SCREEN_NAME.value;
				var m_facility_code = document.Form1.TXT_FACILITY_NO.value;
				var m_temp_facility_code = document.Form1.hid_temp_facility_code.value;
				var m_temp_facility_code = document.Form1.TXT_ACC_CODE.value;
				m_type = document.Form1.elements["TXT_S05_SEC_TYPE_" + m_count].value ; 
				var m_servlet_type = "";
				if ((m_screen_name == "NEW") && (document.Form1.TXT_ACC_CODE.value == "")) {
					alert('Please select an account code.');
					document.Form1.TXT_ACC_CODE.focus();
					return false;
				}
				if ((m_screen_name == "EDIT") && (m_facility_code.length == 0)) {
					alert('Please select a facility.');
					document.Form1.TXT_FACILITY_NO.focus();
					return false;
				}
				if (m_type == "COLLATERAL-IMMOVABLE-MORTGAGE") {
					m_servlet_type = "Immovable_Assets";
				}
				else if (m_type == "COLLATERAL-MOVABLE-VEHICLE") {
					m_servlet_type = "Movable_Assets";
				}
				else if (m_type == "COLLATERAL-MOVABLE-SHARES") {
					m_servlet_type = "Shares";
				}
				else if (m_type == "COLLATERAL-MOVABLE-STOCKS") {
					m_servlet_type = "Stocks";
				}
				else if (m_type == "COLLATERAL-MOVABLE-FD") {
					m_servlet_type = "Deposits";
				}
				else if (m_type == "COLLATERAL-MOVABLE-GUARANTEE") {
					m_servlet_type = "Bank_Guarantees";
				}
				else if (m_type == "COLLATERAL-MOVABLE-CREDIT") {
					m_servlet_type = "Letter_of_Credit";
				}
				else if (m_type == "COLLATERAL-MOVABLE-CHEQUES") {
					m_servlet_type = "Security_Cheques";
				}
				else if (m_type == "COLLATERAL-MOVABLE-NOTE") {
					m_servlet_type = "Promissory_Notes";
				}
				window.open('http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_Client_Facility_'+m_servlet_type+'_display?screen_name='+m_screen_name+'&facility_code='+m_facility_code+'&temp_facility_code='+m_temp_facility_code+'&count='+m_count, 'm_popup', 'left=0,top=0,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1,width='+screen.availWidth+',height='+screen.availWidth);
			}
			function sumValues(m_type, m_screen_name, m_facility_code, m_sum_collateral_amount, m_sum_forced_sale_value, m_sum_amount_considered, m_sum_amount_considered_percentage,m_count) {
				if (m_screen_name == "NEW") {
					document.Form1.hid_temp_facility_code.value = m_facility_code;
				}
				if (m_type == "SS") {
					document.Form1.elements["TXT_S05_SEC_TYPE_AMOUNT_" + m_count].value = m_sum_collateral_amount; 
					document.Form1.elements["TXT_S05_TYPE_" + m_count].value = "SS";
					document.Form1.elements["TXT_S05_SEC_TYPE_" + m_count].value = "COLLATERAL-MOVABLE-SHARES";
				}
				else if (m_type == "IA") {
					document.Form1.elements["TXT_S05_SEC_TYPE_AMOUNT_" + m_count].value = m_sum_forced_sale_value; 
					document.Form1.elements["TXT_S05_TYPE_" + m_count].value = "IA";
					document.Form1.elements["TXT_S05_SEC_TYPE_" + m_count].value = "COLLATERAL-IMMOVABLE-MORTGAGE";
				}
				else if (m_type == "MA") {
					document.Form1.elements["TXT_S05_SEC_TYPE_AMOUNT_" + m_count].value = m_sum_forced_sale_value; 
					document.Form1.elements["TXT_S05_TYPE_" + m_count].value = "MA";
					document.Form1.elements["TXT_S05_SEC_TYPE_" + m_count].value = "COLLATERAL-MOVABLE-VEHICLE";
				}
				else if (m_type == "ST") {
					document.Form1.elements["TXT_S05_SEC_TYPE_AMOUNT_" + m_count].value = m_sum_forced_sale_value; 
					document.Form1.elements["TXT_S05_TYPE_" + m_count].value = "ST";
					document.Form1.elements["TXT_S05_SEC_TYPE_" + m_count].value = "COLLATERAL-MOVABLE-STOCKS";
				}
				else if (m_type == "DP") {
					document.Form1.elements["TXT_S05_SEC_TYPE_AMOUNT_" + m_count].value = m_sum_collateral_amount; 
					document.Form1.elements["TXT_S05_TYPE_" + m_count].value = "DP";
					document.Form1.elements["TXT_S05_SEC_TYPE_" + m_count].value = "COLLATERAL-MOVABLE-FD";
				}
				else if (m_type == "BG") {
					document.Form1.elements["TXT_S05_SEC_TYPE_AMOUNT_" + m_count].value = m_sum_collateral_amount; 
					document.Form1.elements["TXT_S05_TYPE_" + m_count].value = "BG";
					document.Form1.elements["TXT_S05_SEC_TYPE_" + m_count].value = "COLLATERAL-MOVABLE-GUARANTEE";
				}
				else if (m_type == "LC") {
					document.Form1.elements["TXT_S05_SEC_TYPE_AMOUNT_" + m_count].value = m_sum_collateral_amount; 
					document.Form1.elements["TXT_S05_TYPE_" + m_count].value = "LC";
					document.Form1.elements["TXT_S05_SEC_TYPE_" + m_count].value = "COLLATERAL-MOVABLE-CREDIT";
				}
				else if (m_type == "SC") {
					document.Form1.elements["TXT_S05_SEC_TYPE_AMOUNT_" + m_count].value = m_sum_collateral_amount; 
					document.Form1.elements["TXT_S05_TYPE_" + m_count].value = "SC";
					document.Form1.elements["TXT_S05_SEC_TYPE_" + m_count].value = "COLLATERAL-MOVABLE-CHEQUES";
				}
				else if (m_type == "PN") {
					document.Form1.elements["TXT_S05_SEC_TYPE_AMOUNT_" + m_count].value = m_sum_collateral_amount; 
					document.Form1.elements["TXT_S05_TYPE_" + m_count].value = "PN";
					document.Form1.elements["TXT_S05_SEC_TYPE_" + m_count].value = "COLLATERAL-MOVABLE-NOTE";
				}
				document.Form1.elements["TXT_S05_COLLATERAL_AMOUNT_" + m_count].value = m_sum_collateral_amount;
				document.Form1.elements["TXT_S05_FORCED_SALE_VALUE_" + m_count].value = m_sum_forced_sale_value;
				document.Form1.elements["TXT_S05_AMOUNT_CONSIDERED_" + m_count].value = m_sum_amount_considered;
				document.Form1.elements["TXT_S05_AMOUNT_CONSIDERED_PERCENT_" + m_count].value = m_sum_amount_considered_percentage;
			}
			function totalValues() {
				var total_1	= "0.00"; 
				total_1 = parseFloat(unformat_noobject(total_1))+parseFloat(unformat_noobject(document.Form1.TXT_S05_COLLATERAL_AMOUNT_1.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_COLLATERAL_AMOUNT_2.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_COLLATERAL_AMOUNT_3.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_COLLATERAL_AMOUNT_4.value));
				total_1 = parseFloat(unformat_noobject(total_1))+parseFloat(unformat_noobject(document.Form1.TXT_S05_COLLATERAL_AMOUNT_5.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_COLLATERAL_AMOUNT_6.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_COLLATERAL_AMOUNT_7.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_COLLATERAL_AMOUNT_8.value));
				document.Form1.TXT_S05_COLLATERAL_TOTAL_9.value = parseFloat(unformat_noobject(total_1));
				validateNumber(document.Form1.TXT_S05_COLLATERAL_TOTAL_9, 0, 9999999999999999.99, 2, 'number');
				var total_2	= "0.00"; 
				total_2 = parseFloat(unformat_noobject(total_2))+parseFloat(unformat_noobject(document.Form1.TXT_S05_FORCED_SALE_VALUE_1.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_FORCED_SALE_VALUE_2.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_FORCED_SALE_VALUE_3.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_FORCED_SALE_VALUE_4.value));
				total_2 = parseFloat(unformat_noobject(total_2))+parseFloat(unformat_noobject(document.Form1.TXT_S05_FORCED_SALE_VALUE_5.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_FORCED_SALE_VALUE_6.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_FORCED_SALE_VALUE_7.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_FORCED_SALE_VALUE_8.value));
				document.Form1.TXT_S05_FORCED_SALE_VALUE_TOTAL_9.value = parseFloat(unformat_noobject(total_2));
				validateNumber(document.Form1.TXT_S05_FORCED_SALE_VALUE_TOTAL_9, 0, 9999999999999999.99, 2, 'number');
				var total_3	= "0.00"; 
				total_3 = parseFloat(unformat_noobject(total_3))+parseFloat(unformat_noobject(document.Form1.TXT_S05_AMOUNT_CONSIDERED_1.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_AMOUNT_CONSIDERED_2.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_AMOUNT_CONSIDERED_3.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_AMOUNT_CONSIDERED_4.value));
				total_3 = parseFloat(unformat_noobject(total_3))+parseFloat(unformat_noobject(document.Form1.TXT_S05_AMOUNT_CONSIDERED_5.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_AMOUNT_CONSIDERED_6.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_AMOUNT_CONSIDERED_7.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_AMOUNT_CONSIDERED_8.value));
				document.Form1.TXT_S05_AMOUNT_CONSIDERED_TOTAL_9.value = parseFloat(unformat_noobject(total_3));
				validateNumber(document.Form1.TXT_S05_AMOUNT_CONSIDERED_TOTAL_9, 0, 9999999999999999.99, 2, 'number');
				var total_4	= "0.00"; 
				total_4 = parseFloat(unformat_noobject(total_4))+parseFloat(unformat_noobject(document.Form1.TXT_S05_AMOUNT_CONSIDERED_PERCENT_1.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_AMOUNT_CONSIDERED_PERCENT_2.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_AMOUNT_CONSIDERED_PERCENT_3.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_AMOUNT_CONSIDERED_PERCENT_4.value));
				total_4 = parseFloat(unformat_noobject(total_4))+parseFloat(unformat_noobject(document.Form1.TXT_S05_AMOUNT_CONSIDERED_PERCENT_5.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_AMOUNT_CONSIDERED_PERCENT_6.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_AMOUNT_CONSIDERED_PERCENT_7.value))+parseFloat(unformat_noobject(document.Form1.TXT_S05_AMOUNT_CONSIDERED_PERCENT_8.value));
				document.Form1.TXT_S05_AMOUNT_CONSIDERED_PERCENT_TOTAL_9.value = parseFloat(unformat_noobject(total_4));
				validateNumber(document.Form1.TXT_S05_AMOUNT_CONSIDERED_PERCENT_TOTAL_9, 0, 9999999999999999.99, 2, 'number');
			}
			
			
			function load_screen_status_followup(m_val){
				document.Form1.SCREEN_NAME.value=m_val;
				if(m_val=="EDIT"){
					document.Form1.TXT_CLIENT_CODE.disabled = false 
						document.Form1.TXT_ACC_CODE.disabled = false 
						document.Form1.BUT_HELP_ACC.disabled = false
						document.Form1.BUT_HELP_MAIN.disabled = false
						document.Form1.BUT_HELP_MAIN_1.disabled=false;
					document.Form1.TXT_FACILITY_NO.disabled=false;
					document.Form1.hid_status.value="Edit";
					clear_data();
					document.Form1.hid_temp_facility_code.value = "";
				}
			}
			function setRefactoringType(){
				if(document.Form1.REFACTORING_TYPE.value=="AUTO") {
				}
				if(document.Form1.REFACTORING_TYPE.value=="MANUAL") {
				}
			}
			function setValidationType(){
				if(document.Form1.TXT_AUTO_REASSIGN_TYPE.value=="PRECENTAGE") {
					validateNumber(document.Form1.TXT_AUTO_REASSIGN_VALUE, 0, 100, 2, 'number')
				}
				if(document.Form1.TXT_AUTO_REASSIGN_TYPE.value=="AMOUNT") {
					validateNumber(document.Form1.TXT_AUTO_REASSIGN_VALUE, 0, 9999999999999999.99, 2, 'number')
				}
			}
			function setDiscountChargeFrequency(){
				if(document.Form1.TXT_CHARGE_FREQUENCY.value=="WEEKLY") {
					document.Form1.TXT_CHARGE_FREQUENCY_WEEKLY.style.display='inline'
						document.getElementById("DIV_TXT_CHARGE_FREQUENCY_WEEKLY").style.display='inline'
				}
				else{
					document.Form1.TXT_CHARGE_FREQUENCY_WEEKLY.style.display='none'
						document.getElementById("DIV_TXT_CHARGE_FREQUENCY_WEEKLY").style.display='none'
				}
			}
			function addBeneficiaryDetails() {
				if ($('#SCREEN_NAME').val() == 'NEW') {
					m_url = 'http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_Client_Facility_Beneficiary_display?screen_name=' + $('#SCREEN_NAME').val() + '&facility_no=' + $('#hid_temp_facility_no_b').val();
					window.open(m_url, 'm_popup', 'left = 0, top = 0, toolbar = 0, location = 0, directories = 0, status = 0, menuBar = 0, scrollBars = 1, resizable = 1, width = ' + screen.availWidth + ', height = ' + screen.availWidth);
				}
				else if (($('#SCREEN_NAME').val() == 'EDIT') && ($('#TXT_FACILITY_NO').val().length > 0)) {
					m_url = 'http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_Client_Facility_Beneficiary_display?screen_name=' + $('#SCREEN_NAME').val() + '&facility_no=' +  $('#TXT_FACILITY_NO').val();
					window.open(m_url, 'm_popup', 'left = 0, top = 0, toolbar = 0, location = 0, directories = 0, status = 0, menuBar = 0, scrollBars = 1, resizable = 1, width = ' + screen.availWidth + ', height = ' + screen.availWidth);
				}
				else if (($('#SCREEN_NAME').val() == 'EDIT') && ($('#TXT_FACILITY_NO').val().length == 0)) {
					alert('Please select a facility.');
					$('#TXT_FACILITY_NO').focus();
				}
			}
			function returnBeneficiaryCodes(m_str_temp_facility_no) {
				$('#hid_temp_facility_no_b').val(m_str_temp_facility_no);
			}
			function addStandingOrderDetails() {
				if ($('#SCREEN_NAME').val() == 'NEW') {
					m_url = 'http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_Client_Facility_Standing_Order_display?screen_name=' + $('#SCREEN_NAME').val() + '&facility_no=' + $('#hid_temp_facility_no_s').val() + '&facility_no_beneficiary=' + $('#hid_temp_facility_no_b').val();
					window.open(m_url, 'm_popup', 'left = 0, top = 0, toolbar = 0, location = 0, directories = 0, status = 0, menuBar = 0, scrollBars = 1, resizable = 1, width = ' + screen.availWidth + ', height = ' + screen.availWidth);
				}
				else if (($('#SCREEN_NAME').val() == 'EDIT') && ($('#TXT_FACILITY_NO').val().length > 0)) {
					m_url = 'http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_Client_Facility_Standing_Order_display?screen_name=' + $('#SCREEN_NAME').val() + '&facility_no=' +  $('#TXT_FACILITY_NO').val();
					window.open(m_url, 'm_popup', 'left = 0, top = 0, toolbar = 0, location = 0, directories = 0, status = 0, menuBar = 0, scrollBars = 1, resizable = 1, width = ' + screen.availWidth + ', height = ' + screen.availWidth);
				}
				else if (($('#SCREEN_NAME').val() == 'EDIT') && ($('#TXT_FACILITY_NO').val().length == 0)) {
					alert('Please select a facility.');
					$('#TXT_FACILITY_NO').focus();
				}
			}
			function returnStandingOrderCodes(m_str_temp_facility_no) {
				$('#hid_temp_facility_no_s').val(m_str_temp_facility_no);
			}
			function signatureUpload() {
				if ($('#SCREEN_NAME').val() == 'NEW') {
					m_url = 'http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_Client_Facility_Signature_Upload_display?screen_name=' + $('#SCREEN_NAME').val() + '&facility_no=' + $('#hid_temp_facility_no_u').val();
					window.open(m_url, 'm_popup', 'left = 0, top = 0, toolbar = 0, location = 0, directories = 0, status = 0, menuBar = 0, scrollBars = 1, resizable = 1, width = ' + screen.availWidth + ', height = ' + screen.availWidth);
				}
				else if (($('#SCREEN_NAME').val() == 'EDIT') && ($('#TXT_FACILITY_NO').val().length > 0)) {
					m_url = 'http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_Client_Facility_Signature_Upload_display?screen_name=' + $('#SCREEN_NAME').val() + '&facility_no=' +  $('#TXT_FACILITY_NO').val();
					window.open(m_url, 'm_popup', 'left = 0, top = 0, toolbar = 0, location = 0, directories = 0, status = 0, menuBar = 0, scrollBars = 1, resizable = 1, width = ' + screen.availWidth + ', height = ' + screen.availWidth);
				}
				else if (($('#SCREEN_NAME').val() == 'EDIT') && ($('#TXT_FACILITY_NO').val().length == 0)) {
					alert('Please select a facility.');
					$('#TXT_FACILITY_NO').focus();
				}
			}
			function returnSignatureUpload(m_str_temp_facility_no) {
				$('#hid_temp_facility_no_u').val(m_str_temp_facility_no);
			}
			function approvalSheetUpload() {
				if ($('#SCREEN_NAME').val() == 'NEW') {
					m_url = 'http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_Client_Facility_Approval_Sheet_Upload_display?screen_name=' + $('#SCREEN_NAME').val() + '&facility_no=' + $('#hid_temp_facility_no_a').val();
					window.open(m_url, 'm_popup', 'left = 0, top = 0, toolbar = 0, location = 0, directories = 0, status = 0, menuBar = 0, scrollBars = 1, resizable = 1, width = ' + screen.availWidth + ', height = ' + screen.availWidth);
				}
				else if (($('#SCREEN_NAME').val() == 'EDIT') && ($('#TXT_FACILITY_NO').val().length > 0)) {
					m_url = 'http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_Client_Facility_Approval_Sheet_Upload_display?screen_name=' + $('#SCREEN_NAME').val() + '&facility_no=' +  $('#TXT_FACILITY_NO').val();
					window.open(m_url, 'm_popup', 'left = 0, top = 0, toolbar = 0, location = 0, directories = 0, status = 0, menuBar = 0, scrollBars = 1, resizable = 1, width = ' + screen.availWidth + ', height = ' + screen.availWidth);
				}
				else if (($('#SCREEN_NAME').val() == 'EDIT') && ($('#TXT_FACILITY_NO').val().length == 0)) {
					alert('Please select a facility.');
					$('#TXT_FACILITY_NO').focus();
				}
			}
			function returnapprovalSheetUpload(m_str_temp_facility_no) {
				$('#hid_temp_facility_no_a').val(m_str_temp_facility_no);
			}
			var m_validate_flag="false";
			function setValue(obj){
				if(validateNumber(obj, 0, 100, 2, 'number')){
					m_validate_flag="true";
				}
				else{
					m_validate_flag="false";
				}
				if(m_validate_flag=="true"){
					if(obj.name =="TXT_RES_MARGIN"){
						document.Form1.TXT_ADVANCE.value = parseFloat(100) - parseFloat(unformat_noobject(document.Form1.TXT_RES_MARGIN.value));
						validateNumber(document.Form1.TXT_ADVANCE, 0, 100, 2, 'number');
					}
					else if(obj.name =="TXT_ADVANCE"){ 
						document.Form1.TXT_RES_MARGIN.value = parseFloat(100) - parseFloat(unformat_noobject(document.Form1.TXT_ADVANCE.value));
						validateNumber(document.Form1.TXT_RES_MARGIN, 0, 100, 2, 'number');
					}
				}
			}
			function setValue2(obj){
				if(obj =="TXT_RES_MARGIN"){
					document.Form1.TXT_ADVANCE.value = parseFloat(100) - parseFloat(unformat_noobject(document.Form1.TXT_RES_MARGIN.value));
					validateNumber(document.Form1.TXT_ADVANCE, 0, 100, 2, 'number');
				}
				else if(obj =="TXT_ADVANCE"){ 
					document.Form1.TXT_RES_MARGIN.value = parseFloat(100) - parseFloat(unformat_noobject(document.Form1.TXT_ADVANCE.value));
					validateNumber(document.Form1.TXT_RES_MARGIN, 0, 100, 2, 'number');
				}
			}
			function setRecoursePeriod() {
				document.Form1.TXT_RECOURSE_PERIOD.value = parseFloat(unformat_noobject(document.Form1.TXT_CREDIT_PERIOD.value)) + parseFloat(unformat_noobject(document.Form1.TXT_TOL_CREDIT_PERIOD.value));
			}
			function calculate()
			{
				if(document.Form1.TXT_ADVANCE.value=='0.00')
				{
					alert('Prepayment value cannot be blank');
					document.Form1.TXT_ADVANCE.focus();
				}
				else if(document.Form1.TXT_DISPLAY_INT_RATE.value=='0.00')
				{
					alert('Markup Rate cannot be blank');
					document.Form1.TXT_DISPLAY_INT_RATE.focus();
				}
				else if(document.Form1.TXT_CREDIT_PERIOD.value=='0')
				{
					alert('Credit Period cannot be blank');
					document.Form1.TXT_CREDIT_PERIOD.focus();
				}
				else if(document.Form1.TXT_CREDIT_LIMIT.value=='0.00')
				{
					alert('Credit Limit cannot be blank');
					document.Form1.TXT_CREDIT_LIMIT.focus();
				}
				else if(document.Form1.TXT_FACT_FEE.value=='0.00')
				{
					alert('Factoring fee cannot be blank');
					document.Form1.TXT_FACT_FEE.focus();
				}
				else if(document.Form1.TXT_SERVICE_CHARGE.value=='0.00')
				{
					alert('Service Charge cannot be blank');
					document.Form1.TXT_SERVICE_CHARGE.focus();
				}
				else if((document.Form1.TXT_ADVANCE.value > 100) || (document.Form1.TXT_ADVANCE.value < 0))
				{
					alert('Pre payment value is a percentage and value should be between 0-100');
					document.Form1.TXT_ADVANCE.focus();
				}
				else if((document.Form1.TXT_DISPLAY_INT_RATE.value > 100) || (document.Form1.TXT_DISPLAY_INT_RATE.value < 0))
				{
					alert('Markup is a percentage and value should be between 0-100');
					document.Form1.TXT_DISPLAY_INT_RATE.focus();
				}
				else if((document.Form1.TXT_SERVICE_CHARGE.value > 100) || (document.Form1.TXT_SERVICE_CHARGE.value < 0))
				{
					alert('Service Charge is a percentage and value should be between 0-100');
					document.Form1.TXT_SERVICE_CHARGE.focus();
				}
				else
				{
					var credit_period = parseFloat(unformat_noobject(document.Form1.TXT_CREDIT_PERIOD.value));
					var credit_limit  = parseFloat(unformat_noobject(document.Form1.TXT_CREDIT_LIMIT.value));
					var discount = parseFloat(unformat_noobject(document.Form1.TXT_DISPLAY_INT_RATE.value));
					var service_charge = parseFloat(unformat_noobject(document.Form1.TXT_SERVICE_CHARGE.value));
					var advance = parseFloat(unformat_noobject(document.Form1.TXT_ADVANCE.value));
					var min_charge = parseFloat(unformat_noobject(document.Form1.TXT_FACT_FEE.value));
					document.Form1.hid_display_client.value="25";
					m_url="http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_sql_validations?chksql=ER_CALCULATION&credit_period="+credit_period+"&credit_limit="+credit_limit+"&discount="+discount+"&service_charge="+service_charge+"&advance="+advance+"&min_charge="+min_charge;
					load_interface(m_url,'XML');
				}
			}
			
			function applyToDebtors(){
				m_url="http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_OP_due_date_adjustments?facility_no="+document.Form1.TXT_FACILITY_NO.value+"&credit_period="+document.Form1.TXT_CREDIT_PERIOD.value+"&disapproval_period="+document.Form1.TXT_TOL_CREDIT_PERIOD.value;
				window.open(m_url,'displayWindow1','left=0,top=00,width=1100 ,height=800,toolbar=0,location=0,center:yes,direction=0,menuBar=0,status=0,scrollbars=1,resizable=1');
			}
			
			
			function setDiscount(){
				if(document.Form1.TXT_VALUE_TYPE.value=="V") {
					if(document.Form1.TXT_SLAB_TYPE.value=="FLAT") {
						if(document.Form1.TXT_DISPLAY_INT_RATE.value!="0.00" || document.Form1.TXT_DISPLAY_INT_RATE.value!="0") {
							if(document.Form1.DISCOUNT_TYPE.value=="AWPLR" && document.Form1.TXT_VARIABLE_TYPE.value=="P") {
								document.Form1.TXT_INT_RATE.value = parseFloat(unformat_noobject(document.Form1.TXT_DISPLAY_INT_RATE.value)) + parseFloat(unformat_noobject(m_awplr));
								validateNumber(document.Form1.TXT_INT_RATE, 0, 100, 2, 'number');
							}
							if(document.Form1.DISCOUNT_TYPE.value=="AWPLR" && document.Form1.TXT_VARIABLE_TYPE.value=="D") {
								document.Form1.TXT_INT_RATE.value = parseFloat(unformat_noobject(document.Form1.TXT_DISPLAY_INT_RATE.value)) - parseFloat(unformat_noobject(m_awplr));
								validateNumber(document.Form1.TXT_INT_RATE, 0, 100, 2, 'number');
							}
							if(document.Form1.DISCOUNT_TYPE.value=="TBILL" && document.Form1.TXT_VARIABLE_TYPE.value=="P") {
								document.Form1.TXT_INT_RATE.value = parseFloat(unformat_noobject(document.Form1.TXT_DISPLAY_INT_RATE.value)) + parseFloat(unformat_noobject(m_tbill));
								validateNumber(document.Form1.TXT_INT_RATE, 0, 100, 2, 'number');
							}
							if(document.Form1.DISCOUNT_TYPE.value=="TBILL" && document.Form1.TXT_VARIABLE_TYPE.value=="D") {
								document.Form1.TXT_INT_RATE.value = parseFloat(unformat_noobject(document.Form1.TXT_DISPLAY_INT_RATE.value)) - parseFloat(unformat_noobject(m_tbill));
								validateNumber(document.Form1.TXT_INT_RATE, 0, 100, 2, 'number');
							}
						}
						if(document.Form1.TXT_DISPLAY_OVERPAID_RATE.value!="0.00" || document.Form1.TXT_DISPLAY_OVERPAID_RATE.value!="0" ) {
							if(document.Form1.DISCOUNT_TYPE.value=="AWPLR" && document.Form1.TXT_VARIABLE_TYPE.value=="P") {
								document.Form1.TXT_OVERPAID_RATE.value = parseFloat(unformat_noobject(document.Form1.TXT_DISPLAY_OVERPAID_RATE.value)) + parseFloat(unformat_noobject(m_awplr));
								validateNumber(document.Form1.TXT_OVERPAID_RATE, 0, 100, 2, 'number');
							}
							if(document.Form1.DISCOUNT_TYPE.value=="AWPLR" && document.Form1.TXT_VARIABLE_TYPE.value=="D") {
								document.Form1.TXT_OVERPAID_RATE.value = parseFloat(unformat_noobject(document.Form1.TXT_DISPLAY_OVERPAID_RATE.value)) - parseFloat(unformat_noobject(m_awplr));
								validateNumber(document.Form1.TXT_OVERPAID_RATE, 0, 100, 2, 'number');
							}
							if(document.Form1.DISCOUNT_TYPE.value=="TBILL" && document.Form1.TXT_VARIABLE_TYPE.value=="P") {
								document.Form1.TXT_OVERPAID_RATE.value = parseFloat(unformat_noobject(document.Form1.TXT_DISPLAY_OVERPAID_RATE.value)) + parseFloat(unformat_noobject(m_tbill));
								validateNumber(document.Form1.TXT_OVERPAID_RATE, 0, 100, 2, 'number');
							}
							if(document.Form1.DISCOUNT_TYPE.value=="TBILL" && document.Form1.TXT_VARIABLE_TYPE.value=="D") {
								document.Form1.TXT_OVERPAID_RATE.value = parseFloat(unformat_noobject(document.Form1.TXT_DISPLAY_OVERPAID_RATE.value)) - parseFloat(unformat_noobject(m_tbill));
								validateNumber(document.Form1.TXT_OVERPAID_RATE, 0, 100, 2, 'number');
							}
						}
					}
					if(document.Form1.TXT_SLAB_TYPE.value=="SLAB") {
						count=parseInt(document.Form1.hid_slab_count.value);
						for(k=1;k<=count;k++){
							if(document.Form1.elements["TXT_DISPLAY_AMNT_D_"+k].value!="0.00") {
								if(document.Form1.DISCOUNT_TYPE.value=="AWPLR" && document.Form1.TXT_VARIABLE_TYPE.value=="P") {
									document.Form1.elements["TXT_AMNT_D_"+k].value = parseFloat(unformat_noobject(document.Form1.elements["TXT_DISPLAY_AMNT_D_"+k].value)) + parseFloat(unformat_noobject(m_awplr));
									validateNumber(document.Form1.elements["TXT_AMNT_D_"+k], 0, 100, 2, 'number');
								}
								if(document.Form1.DISCOUNT_TYPE.value=="AWPLR" && document.Form1.TXT_VARIABLE_TYPE.value=="D") {
									document.Form1.elements["TXT_AMNT_D_"+k].value = parseFloat(unformat_noobject(document.Form1.elements["TXT_DISPLAY_AMNT_D_"+k].value)) - parseFloat(unformat_noobject(m_awplr));
									validateNumber(document.Form1.elements["TXT_AMNT_D_"+k], 0, 100, 2, 'number');
								}
								if(document.Form1.DISCOUNT_TYPE.value=="TBILL" && document.Form1.TXT_VARIABLE_TYPE.value=="P") {
									document.Form1.elements["TXT_AMNT_D_"+k].value = parseFloat(unformat_noobject(document.Form1.elements["TXT_DISPLAY_AMNT_D_"+k].value)) + parseFloat(unformat_noobject(m_tbill));
									validateNumber(document.Form1.elements["TXT_AMNT_D_"+k], 0, 100, 2, 'number');
								}
								if(document.Form1.DISCOUNT_TYPE.value=="TBILL" && document.Form1.TXT_VARIABLE_TYPE.value=="D") {
									document.Form1.elements["TXT_AMNT_D_"+k].value = parseFloat(unformat_noobject(document.Form1.elements["TXT_DISPLAY_AMNT_D_"+k].value)) - parseFloat(unformat_noobject(m_tbill));
									validateNumber(document.Form1.elements["TXT_AMNT_D_"+k], 0, 100, 2, 'number');
								}
							}
							if(document.Form1.elements["TXT_DISPLAY_AMNT2_D_"+k].value!="0.00") {
								if(document.Form1.DISCOUNT_TYPE.value=="AWPLR" && document.Form1.TXT_VARIABLE_TYPE.value=="P") {
									document.Form1.elements["TXT_AMNT2_D_"+k].value = parseFloat(unformat_noobject(document.Form1.elements["TXT_DISPLAY_AMNT2_D_"+k].value)) + parseFloat(unformat_noobject(m_awplr));
									validateNumber(document.Form1.elements["TXT_AMNT2_D_"+k], 0, 100, 2, 'number');
								}
								if(document.Form1.DISCOUNT_TYPE.value=="AWPLR" && document.Form1.TXT_VARIABLE_TYPE.value=="D") {
									document.Form1.elements["TXT_AMNT2_D_"+k].value = parseFloat(unformat_noobject(document.Form1.elements["TXT_DISPLAY_AMNT2_D_"+k].value)) - parseFloat(unformat_noobject(m_awplr));
									validateNumber(document.Form1.elements["TXT_AMNT2_D_"+k], 0, 100, 2, 'number');
								}
								if(document.Form1.DISCOUNT_TYPE.value=="TBILL" && document.Form1.TXT_VARIABLE_TYPE.value=="P") {
									document.Form1.elements["TXT_AMNT2_D_"+k].value = parseFloat(unformat_noobject(document.Form1.elements["TXT_DISPLAY_AMNT2_D_"+k].value)) + parseFloat(unformat_noobject(m_tbill));
									validateNumber(document.Form1.elements["TXT_AMNT2_D_"+k], 0, 100, 2, 'number');
								}
								if(document.Form1.DISCOUNT_TYPE.value=="TBILL" && document.Form1.TXT_VARIABLE_TYPE.value=="D") {
									document.Form1.elements["TXT_AMNT2_D_"+k].value = parseFloat(unformat_noobject(document.Form1.elements["TXT_DISPLAY_AMNT2_D_"+k].value)) - parseFloat(unformat_noobject(m_tbill));
									validateNumber(document.Form1.elements["TXT_AMNT2_D_"+k], 0, 100, 2, 'number');
								}
							}
						}
					}
				}
				else if(document.Form1.TXT_VALUE_TYPE.value=="F") {
					if(document.Form1.TXT_SLAB_TYPE.value=="SLAB") {
						count=parseInt(document.Form1.hid_slab_count.value);
						for(k=1;k<=count;k++){
							document.Form1.elements["TXT_AMNT_D_"+k].value = document.Form1.elements["TXT_DISPLAY_AMNT_D_"+k].value;
							document.Form1.elements["TXT_AMNT2_D_"+k].value = document.Form1.elements["TXT_DISPLAY_AMNT2_D_"+k].value;
						}
					}
				}
			}
			
			
			function setVariableType() {
				if(document.Form1.TXT_VALUE_TYPE.value == 'V'){
					document.Form1.TXT_INT_RATE.value="0.00";
					document.Form1.TXT_OVERPAID_RATE.value="0.00";
					document.Form1.TXT_VARIABLE_TYPE.disabled=false;
					document.Form1.DISCOUNT_TYPE.disabled=false;
					document.Form1.RESET_INTERVAL.disabled=false;
					document.Form1.TXT_RESET_DD.disabled=false;
					document.Form1.TXT_RESET_MM.disabled=false;
					document.Form1.TXT_RESET_YY.disabled=false;
					setDiscount();
					
				}
				if(document.Form1.TXT_VALUE_TYPE.value == 'F'){
					document.Form1.TXT_VARIABLE_TYPE.disabled=true;
					document.Form1.DISCOUNT_TYPE.disabled=true;
					document.Form1.RESET_INTERVAL.disabled=true;
					document.Form1.RESET_INTERVAL.value="1";
					document.Form1.TXT_RESET_DD.disabled=true;
					document.Form1.TXT_RESET_MM.disabled=true;
					document.Form1.TXT_RESET_YY.disabled=true;
					document.Form1.TXT_RESET_DD.value=m_system_date;  
					document.Form1.TXT_RESET_MM.value=m_system_month;  
					document.Form1.TXT_RESET_YY.value=m_system_year;  
					if(document.Form1.TXT_SLAB_TYPE.value == 'FLAT'){
						document.Form1.TXT_INT_RATE.value = document.Form1.TXT_DISPLAY_INT_RATE.value;
						validateNumber(document.Form1.TXT_INT_RATE, 0, 100, 2, 'number');
						document.Form1.TXT_OVERPAID_RATE.value = document.Form1.TXT_DISPLAY_OVERPAID_RATE.value;
						validateNumber(document.Form1.TXT_OVERPAID_RATE, 0, 100, 2, 'number');
					}
					if(document.Form1.TXT_SLAB_TYPE.value == 'SLAB'){
						count=parseInt(document.Form1.hid_slab_count.value);
						for(k=1;k<=count;k++){
							document.Form1.elements["TXT_AMNT_D_"+k].value = document.Form1.elements["TXT_DISPLAY_AMNT_D_"+k].value;
						}
					}
				}
			}
			function hideFlatDiscount() {
				var str_object_name2   = 'TXT_DISPLAY_INT_RATE';
				var str_object_name3   = 'TXT_INT_RATE';
				var str_object_name4   = 'DIV_TXT_SLAB_TYPE';
				var str_object_name5   = 'TXT_DISPLAY_OVERPAID_RATE';
				var str_object_name6   = 'TXT_OVERPAID_RATE';
				var str_object_name7   = 'DIV_TXT_OVERPAID_DISCOUNT';
				if(document.Form1.TXT_SLAB_TYPE.value == 'SLAB'){
					document.forms[0].elements[str_object_name2].style.visibility = 'hidden';
					document.forms[0].elements[str_object_name3].style.visibility = 'hidden';
					document.getElementById(str_object_name4).style.visibility = 'hidden';
					document.forms[0].elements[str_object_name5].style.visibility = 'hidden';
					document.forms[0].elements[str_object_name6].style.visibility = 'hidden';
					document.getElementById(str_object_name7).style.visibility = 'hidden';
				}
				else if (document.Form1.TXT_SLAB_TYPE.value == 'FLAT') {
					document.forms[0].elements[str_object_name2].style.visibility = 'visible';
					document.forms[0].elements[str_object_name3].style.visibility = 'visible';
					document.getElementById(str_object_name4).style.visibility = 'visible';
					document.forms[0].elements[str_object_name5].style.visibility = 'visible';
					document.forms[0].elements[str_object_name6].style.visibility = 'visible';
					document.getElementById(str_object_name7).style.visibility = 'visible';
				}
				loadSlabDIV();
			}
			
			
			function loadSlabDIV() {
				if(document.Form1.TXT_SLAB_TYPE.value == 'FLAT')
				{
					document.Form1.hid_slab_count.value = '0';
					document.getElementById("DIV_TXT_SLAB_DYNAMIC").innerHTML='';
					document.getElementById("DIV_TXT_SLAB_DYNAMIC_HEAD").innerHTML="";
					document.Form1.TXT_DISPLAY_INT_RATE.disabled=false;
					document.Form1.TXT_DISPLAY_OVERPAID_RATE.disabled=false;
				}
				if(document.Form1.TXT_SLAB_TYPE.value == 'SLAB')
				{
					document.Form1.TXT_DISPLAY_INT_RATE.disabled=true;
					document.Form1.TXT_DISPLAY_OVERPAID_RATE.disabled=true;
					document.Form1.hid_slab_count.value = '0';
					document.getElementById("DIV_TXT_SLAB_DYNAMIC").innerHTML="";
					loadTaxSlabHead();
				}
			}
			
			
			function loadTaxSlabHead() {
				var s = '<table class="table" width="100%"><tr>'+
					'<input class="but_input" type="button" name="SUB_ADD" value=" + " onClick="add_fee_slab();"/></td></tr></table>';  
				document.getElementById("DIV_TXT_SLAB_DYNAMIC_HEAD").innerHTML=s;
				document.getElementById('DIV_TXT_SLAB_DYNAMIC_HEAD').innerHTML=document.getElementById('DIV_TXT_SLAB_DYNAMIC_HEAD').innerHTML+'<table>'+
				'<tr>'+
					'<td class = "div_input" align = "center" style = \'width: 30px\'><b>Slab</b></td> '+
					'<td class = "div_input" align = "center" style = \'width: 120px\'><b>From</b></td> '+
					'<td class = "div_input" align = "center" style = \'width: 120px\'><b>To</b></td> '+
					'<td class = "div_input" align = "center" style = \'width: 240px\'><b>Markup Rate</b></td> '+
					'<td class = "div_input" align = "center" style = \'width: 240px\'><b>Overpaid Markup Rate</b></td> '+
					'<td class = "div_input" align = "center" style = \'width: 60px\'></td> '+
					'</tr> '+
					'</table>';
				if (document.Form1.hid_slab_count.value == "0") {
					add_fee_slab();
				}
			}
			
			
			function loadFeeSlabHeadEdit() {
				var s = '<table class="table" width="100%">'+
					'<tr><input class="but_input" type="button" name="SUB_ADD" value=" + " onClick="add_fee_slab();"/></td></tr>';  
				document.getElementById("DIV_TXT_SLAB_DYNAMIC_HEAD").innerHTML=s;
				document.getElementById('DIV_TXT_SLAB_DYNAMIC_HEAD').innerHTML=document.getElementById('DIV_TXT_SLAB_DYNAMIC_HEAD').innerHTML+'<table>'+
				'<tr>'+
					'<td class = "div_input" align = "center" style = \'width: 30px\'><b>Slab</b></td> '+
					'<td class = "div_input" align = "center" style = \'width: 120px\'><b>From</b></td> '+
					'<td class = "div_input" align = "center" style = \'width: 120px\'><b>To</b></td> '+
					'<td class = "div_input" align = "center" style = \'width: 240px\'><b>Amount</b></td> '+
					'<td class = "div_input" align = "center" style = \'width: 240px\'><b>Overpaid Markup Rate</b></td> '+
					'<td class = "div_input" align = "center" style = \'width: 60px\'></td> '+
					'</tr> '+
					'</table>';
			}
			
			
			function add_fee_slab(){
				slab_content ='';
				m_dir_count=parseInt(document.Form1.hid_slab_count.value);
				m_dir_count++;
				slab_content=slab_content+'<table>'+
					'<tr> '+
					'<td ><input class = "txt_input" type = "text" name = "TXT_SLAB_D_'+m_dir_count+'" maxlength = "100" style = \'width: 30px\' value="'+m_dir_count+'" disabled></td>'+ 
					'<td ><input class = "txt_input" type = "text" name = "TXT_FROM_D_'+m_dir_count+'" maxlength = "30" style = \'width: 120px;text-align:right\' onchange="format_num(this,4)" onBlur = "validateNumber(this, 0, 9999999999999999.99, 2, \'number\');validateSlab('+m_dir_count+',\'FROM\');"></td>'+ 
					'<td ><input class = "txt_input" type = "text" name = "TXT_TO_D_'+m_dir_count+'" maxlength = "30" style = \'width: 120px;text-align:right\' onchange="format_num(this,4)" onBlur = "validateNumber(this, 0, 9999999999999999.99, 2, \'number\');validateSlab('+m_dir_count+',\'TO\');"></td>'+ 
					'<td ><input class = "txt_input" type = "text" name = "TXT_DISPLAY_AMNT_D_'+m_dir_count+'" maxlength = "20" onchange="format_num(this,4);setDiscount();" style = \'width: 120px;text-align:right\'  value="0.00" onBlur = "validateNumber(this, 0, 9999999999999999.99, 2, \'number\')">'+ 
					'<input class = "txt_input" type = "text" name = "TXT_AMNT_D_'+m_dir_count+'" maxlength = "20" onchange="format_num(this,4)" style = \'width: 120px;text-align:right\'  value="0.00" disabled onBlur = "validateNumber(this, 0, 9999999999999999.99, 2, \'number\')"></td>'+ 
					'<td ><input class = "txt_input" type = "text" name = "TXT_DISPLAY_AMNT2_D_'+m_dir_count+'" maxlength = "20" onchange="format_num(this,4);setDiscount();" style = \'width: 120px;text-align:right\'  value="0.00" onBlur = "validateNumber(this, 0, 9999999999999999.99, 2, \'number\')">'+ 
					'<input class = "txt_input" type = "text" name = "TXT_AMNT2_D_'+m_dir_count+'" maxlength = "20" onchange="format_num(this,4)" style = \'width: 120px;text-align:right\'  value="0.00" disabled onBlur = "validateNumber(this, 0, 9999999999999999.99, 2, \'number\')"></td>'+ 
					'<td align = "center"><input class="but_input" type="button" name="BUT_DELETE_D_'+m_dir_count+'" value=" - " onClick="delete_fee_slabs('+m_dir_count+');"></td>'+ 
					'</tr>'+
					'</table>';
				document.Form1.hid_slab_count.value=m_dir_count;
				if($.browser.msie){
					document.getElementById('DIV_TXT_SLAB_DYNAMIC').innerHTML = document.getElementById('DIV_TXT_SLAB_DYNAMIC').innerHTML + slab_content ; 
				}else{
					$('#DIV_TXT_SLAB_DYNAMIC').append(slab_content);
				}
				setToValue(m_dir_count)
			}
			
			function setToValue(k){
				if(k != 1 ){
					if((document.Form1.elements["TXT_TO_D_"+(k-1)].value.length!=0) && (document.Form1.elements["TXT_TO_D_"+(k-1)].value!="0.00") ) {
						document.Form1.elements["TXT_FROM_D_"+k].value=parseFloat(unformat_noobject(document.Form1.elements["TXT_TO_D_"+(k-1)].value))+parseFloat(1);
						format_num(document.Form1.elements["TXT_FROM_D_"+k],4);
					}
				}
			}
			
			function validateSlab(k,type){
				var slab_count = document.Form1.hid_slab_count.value;
				for (var k = 1; k <= slab_count; k++) {
					if(parseFloat(unformat_noobject(document.Form1.elements["TXT_FROM_D_"+k].value)) >= parseFloat(unformat_noobject(document.Form1.elements["TXT_TO_D_"+k].value)) ){
						alert('To value can not be less than or equal to From value');
						document.Form1.elements["TXT_TO_D_"+k].focus();
						document.Form1.elements["TXT_TO_D_"+k].value="";
					}
					if(k != 1 ){
						if(parseFloat(unformat_noobject(document.Form1.elements["TXT_FROM_D_"+k].value)) <= parseFloat(unformat_noobject(document.Form1.elements["TXT_TO_D_"+(k-1)].value)) ){
							alert('From value can not be grater than or equal to previous To value');
							document.Form1.elements["TXT_FROM_D_"+k].focus();
							document.Form1.elements["TXT_FROM_D_"+k].value="";
						}
					}
				}
			}
			
			var m_slab = "NO";
			
			function validateSlabBeforeSave(){
				var slab_count = document.Form1.hid_slab_count.value;
				for (var k = 1; k <= slab_count; k++) {
					if(document.Form1.elements["TXT_FROM_D_"+k].value.length == 0 || document.Form1.elements["TXT_TO_D_"+k].value.length == 0  ){
						m_slab = "YES";
					}
				}
				if(m_slab == "YES"){
					m_slab = "NO";
					alert('Please enter slab values before save.');
					return false;
				}
				else{
					validateSlab()
					return true;
				}
			}
			
			function delete_fee_slabs(mnum){
				if(confirm("Are you sure you want to delete ?")) { 
					if(parseInt(mnum)>0){
						m_con_per_count=parseInt(document.Form1.hid_slab_count.value);
						m_count=0;
						m_str="";
						for(k=1;k<=m_con_per_count;k++){
							if(k!=mnum){
								m_count++;
								obj_slab  = document.Form1.elements["TXT_SLAB_D_"+k].value;
								obj_from  = document.Form1.elements["TXT_FROM_D_"+k].value;
								obj_to    = document.Form1.elements["TXT_TO_D_"+k].value;
								obj_amount = document.Form1.elements["TXT_AMNT_D_"+k].value;
								obj_display_amount = document.Form1.elements["TXT_DISPLAY_AMNT_D_"+k].value;
								obj_amount2 = document.Form1.elements["TXT_AMNT2_D_"+k].value;
								obj_display_amount2 = document.Form1.elements["TXT_DISPLAY_AMNT2_D_"+k].value;
								m_str=m_str+'<table>'+
									'<tr> '+
									'<td ><input class = "txt_input" type = "text" name = "TXT_SLAB_D_'+m_count+'" value="'+m_count+'" maxlength = "100" style = \'width: 30px\'  disabled></td>'+ 
									'<td ><input class = "txt_input" type = "text" name = "TXT_FROM_D_'+m_count+'" value="'+obj_from+'" maxlength = "30" style = \'width: 120px;text-align:right\' onBlur = "validateNumber(this, 0, 9999999999999999.99, 2, \'number\');validateSlab('+m_count+',\'FROM\');" ></td>'+ 
									'<td ><input class = "txt_input" type = "text" name = "TXT_TO_D_'+m_count+'"   value="'+obj_to+'" maxlength = "30" style = \'width: 120px;text-align:right\'  onBlur = "validateNumber(this, 0, 9999999999999999.99, 2, \'number\');validateSlab('+m_count+',\'TO\');"></td>'+ 
									'<td ><input class = "txt_input" type = "text" name = "TXT_DISPLAY_AMNT_D_'+m_count+'" value="'+obj_display_amount+'" maxlength = "20" onchange="format_num(this,4);setDiscount();"  style = \'width: 120px;text-align:right\'  onBlur = "validateNumber(this, 0, 9999999999999999.99, 2, \'number\')">'+ 
									'<input class = "txt_input" type = "text" name = "TXT_AMNT_D_'+m_count+'" value="'+obj_amount+'" maxlength = "20" onchange="format_num(this,4)" style = \'width: 120px;text-align:right\'  disabled onBlur = "validateNumber(this, 0, 9999999999999999.99, 2, \'number\')"></td>'+ 
									'<td ><input class = "txt_input" type = "text" name = "TXT_DISPLAY_AMNT2_D_'+m_count+'" value="'+obj_display_amount2+'" maxlength = "20" onchange="format_num(this,4);setDiscount();"  style = \'width: 120px;text-align:right\' onBlur = "validateNumber(this, 0, 9999999999999999.99, 2, \'number\')" >'+ 
									'<input class = "txt_input" type = "text" name = "TXT_AMNT2_D_'+m_count+'" value="'+obj_amount2+'" maxlength = "20" onchange="format_num(this,4)" style = \'width: 120px;text-align:right\'  disabled onBlur = "validateNumber(this, 0, 9999999999999999.99, 2, \'number\')"></td>'+ 
									'<td align = "center"><input class="but_input" type="button" name="BUT_DELETE_D_'+m_count+'" value=" - " onClick="delete_fee_slabs('+m_count+');"></td>'+ 
									'</tr>'+
									'</table>';
							}
						}
						document.getElementById('DIV_TXT_SLAB_DYNAMIC').innerHTML=m_str;
						document.Form1.hid_slab_count.value=m_count;
					}
				}
			}
			
			
			
			function screen_close(){
				top.frames[1].location.href='low.jsp';
			} 
			
			
			// ***********************************************************************************		
			// ************* Start New Help ******************************************************	
			// ***********************************************************************************	
			
			function client_no_help(m_strat) {
				//alert('client help');
				var aForm;    //  aForm =oForm.elements;
				aForm =  document.getElementById('Form1');
				
				var myObject=new Array(); //return values set to this object
				myObject[0]=aForm.TXT_CLIENT_CODE;
				myObject[1]=aForm.TXT_CLIENT_NAME;
				myObject[2]=null;
				myObject[3]=null;
				myObject[4]=null;
				
				var myObject_value=new Array(); //passing values set to this object
				
				myObject_value[0]=aForm.TXT_CLIENT_CODE.value;
				myObject_value[1]=aForm.TXT_CLIENT_CODE.value;
				
				
				
				var myObject_type=new Array(); //passing values data type
				
				myObject_type[0]="StringL";
				myObject_type[1]="StringL";
				
				
				
				var qid='60'; // 2
				var close_fun='close_client_no_help';
				var url = 'popup.jsp';
				var json_text = JSON.stringify(myObject_value, null,0);
				var json_obj_type_text=JSON.stringify(myObject_type, null,0);
				var fn_name=arguments.callee.name;
				if(fn_name==undefined){
					re = /^function\s+([^(]+)/;
					fn_name=re.exec(arguments.callee.toString())[1];
				}
				$.showModalDialog({
						url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun, //&close_fun='+close_fun,
						dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
						height:400,// 500,
						width: 400,//900,
						title: 'SasiNet Frame work',
						scrollable: true,
						onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
					});
				
			}	// End client_no_help
			
			
			function close_client_no_help(){
				document.Form1.TXT_CLIENT_CODE.text='';
			}
			
			
			
			// Broker Help
			function broker_no_help(m_strat) {
				//alert('broker help');
				var aForm;    //  aForm =oForm.elements;
				aForm =  document.getElementById('Form1');
				
				var myObject=new Array(); //return values set to this object
				myObject[0]=aForm.TXT_BROKER_CODE;
				myObject[1]=null;
				myObject[2]=null;
				myObject[3]=null;
				myObject[4]=null;
				
				var myObject_value=new Array(); //passing values set to this object
				
				myObject_value[0]=aForm.TXT_CLIENT_CODE.value;
				//myObject_value[1]=aForm.TXT_BROKER_CODE.value;
				
				
				
				var myObject_type=new Array(); //passing values data type
				
				myObject_type[0]="StringL";
				//myObject_type[1]="StringL";
				
				
				
				var qid='140'; //'55'; change by waruna 2012-10-16
				var close_fun='close_broker_no_help';
				var url = 'popup.jsp';
				var json_text = JSON.stringify(myObject_value, null,0);
				var json_obj_type_text=JSON.stringify(myObject_type, null,0);
				var fn_name=arguments.callee.name;
				if(fn_name==undefined){
					re = /^function\s+([^(]+)/;
					fn_name=re.exec(arguments.callee.toString())[1];
				}
				$.showModalDialog({
						url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun, //&close_fun='+close_fun,
						dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
						height:400,// 500,
						width: 400,//900,
						title: 'SasiNet Frame work',
						scrollable: true,
						onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
					});
				
			}	// End client_no_help
			
			
			function close_broker_no_help(){
				document.Form1.TXT_BROKER_CODE.text='';
			}
			
			
			
			
			// Adviser Help
			
			function adviser_code_help(m_strat) {
				//alert('client help');
				var aForm;    //  aForm =oForm.elements;
				aForm =  document.getElementById('Form1');
				
				var myObject=new Array(); //return values set to this object
				myObject[0]=null;
				myObject[1]=aForm.TXT_ADVISER_NAME;
				myObject[2]=null;
				myObject[3]=null;
				myObject[4]=null;
				
				var myObject_value=new Array(); //passing values set to this object
				
				myObject_value[0]=aForm.TXT_ADVISER_NAME.value;
				myObject_value[1]=aForm.TXT_ADVISER_NAME.value;
				myObject_value[2]=aForm.TXT_BROKER_CODE.value; //ADDED BY MADHAWA 2012-01-11
				
				
				var myObject_type=new Array(); //passing values data type
				
				myObject_type[0]="StringL";
				myObject_type[1]="StringL";
				myObject_type[2]="StringL";
				
				
				//var qid='74'; // 2
				var qid='122';
				var close_fun='close_adviser_code_help';
				var url = 'popup.jsp';
				var json_text = JSON.stringify(myObject_value, null,0);
				var json_obj_type_text=JSON.stringify(myObject_type, null,0);
				var fn_name=arguments.callee.name;
				if(fn_name==undefined){
					re = /^function\s+([^(]+)/;
					fn_name=re.exec(arguments.callee.toString())[1];
				}
				$.showModalDialog({
						url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun, //&close_fun='+close_fun,
						dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
						height:400,// 500,
						width: 400,//900,
						title: 'SasiNet Frame work',
						scrollable: true,
						onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
					});
				
			}	// End client_no_help
			
			
			function close_adviser_code_help(){
				document.Form1.TXT_ADVISER_NAME.text='';
			}
			
			
			
			// =====================================================================================
			
			function facility_code_help(m_strat) {
				//alert('client help');
				var aForm;    //  aForm =oForm.elements;
				aForm =  document.getElementById('Form1');
				
				var myObject=new Array(); //return values set to this object
				myObject[0]=aForm.TXT_FACILITY_NO;
				myObject[1]=null;
				myObject[2]=null;
				myObject[3]=null;
				myObject[4]=null;
				
				
				var myObject_value=new Array(); //passing values set to this object
				
				myObject_value[0]=aForm.TXT_FACILITY_NO.value;
				
				
				
				var myObject_type=new Array(); //passing values data type
				
				myObject_type[0]="StringL";
				
				
				
				var qid='77'; // 2
				var close_fun='close_facility_code_help';
				var url = 'popup.jsp';
				var json_text = JSON.stringify(myObject_value, null,0);
				var json_obj_type_text=JSON.stringify(myObject_type, null,0);
				var fn_name=arguments.callee.name;
				if(fn_name==undefined){
					re = /^function\s+([^(]+)/;
					fn_name=re.exec(arguments.callee.toString())[1];
				}
				$.showModalDialog({
						url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun, //&close_fun='+close_fun,
						dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
						height:400,// 500,
						width: 400,//900,
						title: 'SasiNet Frame work',
						scrollable: true,
						onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); if(returnedValue!=null){document.Form1.TXT_FACILITY_NO.focus();} } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
					});
				
				//document.Form1.TXT_FACILITY_NO.focus();
				
			}	// End client_no_help
			
			
			function close_facility_code_help(){
				document.Form1.TXT_ADVISER_NAME.text='';
			}
			
			
			
			// client manager help
			
			function facility_client_manager(m_strat) {
				//alert('client help');
				var aForm;    //  aForm =oForm.elements;
				aForm =  document.getElementById('Form1');
				
				var myObject=new Array(); //return values set to this object
				myObject[0]=aForm.TXT_FACILITY_MANAGER;
				myObject[1]=null;
				myObject[2]=null;
				myObject[3]=null;
				myObject[4]=null;
				
				
				var myObject_value=new Array(); //passing values set to this object
				
				myObject_value[0]=aForm.TXT_FACILITY_MANAGER.value;
				
				
				
				var myObject_type=new Array(); //passing values data type
				
				myObject_type[0]="StringL";
				
				
				
				var qid='78'; // 2
				var close_fun='close_facility_client_manager';
				var url = 'popup.jsp';
				var json_text = JSON.stringify(myObject_value, null,0);
				var json_obj_type_text=JSON.stringify(myObject_type, null,0);
				var fn_name=arguments.callee.name;
				if(fn_name==undefined){
					re = /^function\s+([^(]+)/;
					fn_name=re.exec(arguments.callee.toString())[1];
				}
				$.showModalDialog({
						url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun, //&close_fun='+close_fun,
						dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
						height:400,// 500,
						width: 400,//900,
						title: 'SasiNet Frame work',
						scrollable: true,
						onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); document.Form1.TXT_FACILITY_NO.focus(); } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
					});
				
				//document.Form1.TXT_FACILITY_NO.focus();
				
			}	// End client_no_help
			
			
			function close_facility_client_manager(){
				document.Form1.TXT_FACILITY_MANAGER.text='';
			}
			
			
			// Added by Udara on 09-11-2011
			function help_loc_code(m_strat) {
				//alert('client help');
				var aForm;    //  aForm =oForm.elements;
				aForm =  document.getElementById('Form1');
				
				var myObject=new Array(); //return values set to this object
				myObject[0]=aForm.TXT_LOCATION_CODE;
				myObject[1]=null;
				myObject[2]=null;
				myObject[3]=null;
				myObject[4]=null;
				
				
				var myObject_value=new Array(); //passing values set to this object
				
				myObject_value[0]=aForm.TXT_LOCATION_CODE.value;
				myObject_value[1]=aForm.TXT_LOCATION_CODE.value;
				
				
				var myObject_type=new Array(); //passing values data type
				
				myObject_type[0]="StringL";
				myObject_type[1]="StringL";
				
				
				var qid='111'; // 2
				var close_fun='close_help_loc_code';
				var url = 'popup.jsp';
				var json_text = JSON.stringify(myObject_value, null,0);
				var json_obj_type_text=JSON.stringify(myObject_type, null,0);
				var fn_name=arguments.callee.name;
				if(fn_name==undefined){
					re = /^function\s+([^(]+)/;
					fn_name=re.exec(arguments.callee.toString())[1];
				}
				$.showModalDialog({
						url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun, //&close_fun='+close_fun,
						dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
						height:400,// 500,
						width: 400,//900,
						title: 'SasiNet Frame work',
						scrollable: true,
						onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
					});
				
			}	// End client_no_help
			
			
			function close_help_loc_code(){
				document.Form1.TXT_LOCATION_CODE.text='';
			}	
			
			// End by Udara on 09-11-2011
			
			
			// product code help
			
			function product_code_help(m_strat) {
				var aForm;    //  aForm =oForm.elements;
				aForm =  document.getElementById('Form1');
				
				var myObject=new Array(); //return values set to this object
				myObject[0]=aForm.TXT_PRODUCT_DESC;
				myObject[1]=aForm.TXT_PRODUCT_CODE;
				myObject[2]=null;
				myObject[3]=null;
				myObject[4]=null;
				
				
				var myObject_value=new Array(); //passing values set to this object
				
				myObject_value[0]=aForm.TXT_PRODUCT_CODE.value;
				myObject_value[1]=aForm.TXT_PRODUCT_CODE.value;
				
				
				var myObject_type=new Array(); //passing values data type
				
				myObject_type[0]="StringL";
				myObject_type[1]="StringL";
				
				
				var qid='86'; // 2
				var close_fun='close_product_code_help';
				var url = 'popup.jsp';
				var json_text = JSON.stringify(myObject_value, null,0);
				var json_obj_type_text=JSON.stringify(myObject_type, null,0);
				var fn_name=arguments.callee.name;
				if(fn_name==undefined){
					re = /^function\s+([^(]+)/;
					fn_name=re.exec(arguments.callee.toString())[1];
				}
				$.showModalDialog({
						url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun, //&close_fun='+close_fun,
						dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
						height:400,// 500,
						width: 400,//900,
						title: 'SasiNet Frame work',
						scrollable: true,
						onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); 
							if(document.Form1.TXT_PRODUCT_CODE.text!='')
								load_product_grid_new();
						} //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
					});
				
				//document.Form1.TXT_FACILITY_NO.focus();
				
				
				
			}	// End product_code_help
			
			
			function close_product_code_help(){
				document.Form1.TXT_PRODUCT_CODE.text='';
			}
			
			
			// Fee Code Help
			
			function fee_code_help(m_strat) {
				var aForm;    //  aForm =oForm.elements;
				aForm =  document.getElementById('Form1');
				
				var myObject=new Array(); //return values set to this object
				myObject[0]=aForm.TXT_FEE_CODE;
				myObject[1]=aForm.TXT_FEE_CODE;
				myObject[2]=null;
				myObject[3]=null;
				myObject[4]=null;
				
				
				var myObject_value=new Array(); //passing values set to this object
				
				myObject_value[0]=aForm.TXT_FEE_CODE.value;
				myObject_value[1]=aForm.TXT_FEE_CODE.value;
				
				
				var myObject_type=new Array(); //passing values data type
				
				myObject_type[0]="StringL";
				myObject_type[1]="StringL";
				
				
				var qid='92'; 
				var close_fun='close_fee_code_help';
				var url = 'popup.jsp';
				var json_text = JSON.stringify(myObject_value, null,0);
				var json_obj_type_text=JSON.stringify(myObject_type, null,0);
				var fn_name=arguments.callee.name;
				if(fn_name==undefined){
					re = /^function\s+([^(]+)/;
					fn_name=re.exec(arguments.callee.toString())[1];
				}
				$.showModalDialog({
						url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun, //&close_fun='+close_fun,
						dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
						height:400,// 500,
						width: 400,//900,
						title: 'SasiNet Frame work',
						scrollable: true,
						onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); 
							if(document.Form1.TXT_FEE_CODE.text!='')
								load_fee_grid_new();
						} //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
					});
				
				
				
			}	// End fee_code_help
			
			
			function close_fee_code_help(){
				document.Form1.TXT_FEE_CODE.text='';
			}	
			// End Fee Code Help
			
			
			// Product Feature Code - Grid
			
			function product_feature_help(m_strat) {
				
				var myObject=new Array(); //return values set to this object
				myObject[0]=document.getElementById('TXT_PRO_FEATURE_NAME_'+dynamic_row_id);
				myObject[1]=document.getElementById(dynamic_product_feature_code);
				myObject[2]=document.getElementById('TXT_COMMENTS_'+dynamic_row_id);
				myObject[3]=document.getElementById('TXT_PRO_ACT_POINT_'+dynamic_row_id);
				myObject[4]=document.getElementById('TXT_ACTION_'+dynamic_row_id);
				myObject[5]=document.getElementById('TXT_MAIL_CODE_'+dynamic_row_id);
				myObject[6]=document.getElementById('TXT_FREQUENCY_'+dynamic_row_id);
				
				var myObject_value=new Array(); //passing values set to this object
				
				myObject_value[0]='';
				myObject_value[1]=document.getElementById(dynamic_product_feature_code).value;
				
				var myObject_type=new Array(); //passing values data type
				
				myObject_type[0]="StringL";
				myObject_type[1]="StringL";
				
				var qid='87'; // 2
				var close_fun='close_product_feature_help';
				var url = 'popup.jsp';
				var json_text = JSON.stringify(myObject_value, null,0);
				var json_obj_type_text=JSON.stringify(myObject_type, null,0);
				var fn_name=arguments.callee.name;
				if(fn_name==undefined){
					re = /^function\s+([^(]+)/;
					fn_name=re.exec(arguments.callee.toString())[1];
				}
				$.showModalDialog({
						url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun, //&close_fun='+close_fun,
						dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
						height:400,// 500,
						width: 400,//900,
						title: 'SasiNet Frame work',
						scrollable: true,
						onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); document.Form1.TXT_FACILITY_NO.focus(); 
						} //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
					});	
				
			}	// End product_feature_help
			
			
			function close_product_feature_help(){
				document.getElementById(dynamic_product_feature_code).value='';
			}
			
			
			
			// Fee Feature Help - Grid
			
			function fee_feature_help(m_strat) {
				
				var myObject=new Array(); //return values set to this object
				myObject[0]=document.getElementById('TXT_FEE_FEATURE_NAME_'+dynamic_row_id);
				myObject[1]=document.getElementById(dynamic_fee_feature_code);
				
				var myObject_value=new Array(); //passing values set to this object
				
				//myObject_value[0]='';
				myObject_value[0]=document.getElementById(dynamic_fee_feature_code).value;
				
				var myObject_type=new Array(); //passing values data type
				
				myObject_type[0]="StringL";
				//myObject_type[1]="StringL";
				
				var qid='93'; // 2
				var close_fun='close_fee_feature_help';
				var url = 'popup.jsp';
				var json_text = JSON.stringify(myObject_value, null,0);
				var json_obj_type_text=JSON.stringify(myObject_type, null,0);
				var fn_name=arguments.callee.name;
				if(fn_name==undefined){
					re = /^function\s+([^(]+)/;
					fn_name=re.exec(arguments.callee.toString())[1];
				}
				$.showModalDialog({
						url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun, //&close_fun='+close_fun,
						dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
						height:400,// 500,
						width: 400,//900,
						title: 'SasiNet Frame work',
						scrollable: true,
						onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); document.Form1.TXT_FACILITY_NO.focus(); 
						} //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
					});	
				
			}	// End fee_feature_help
			
			
			function close_fee_feature_help(){
				document.getElementById(dynamic_product_feature_code).value='';
			}
			
			
			// CDS acc Help	
			
			function cds_acc_help(m_strat) {
				var aForm;    //  aForm =oForm.elements;
				aForm =  document.getElementById('Form1');
				
				if(aForm.TXT_CLIENT_CODE.value!=''){	// aForm.TXT_CDS_ACC_NO.value!='' && 
					
					var myObject=new Array(); //return values set to this object
					myObject[0]=aForm.TXT_CDS_ACC_NO;
					myObject[1]=null;
					myObject[2]=null;
					myObject[3]=null;
					myObject[4]=null;
					
					
					var myObject_value=new Array(); //passing values set to this object
					
					myObject_value[0] = aForm.TXT_CLIENT_CODE.value;
					myObject_value[1] = aForm.TXT_CDS_ACC_NO.value;
					
					var myObject_type=new Array(); //passing values data type
					
					myObject_type[0] = "String";
					myObject_type[1] = "StringL";
					
					var qid='102'; 
					var close_fun='close_cds_acc_help';
					var url = 'popup.jsp';
					var json_text = JSON.stringify(myObject_value, null,0);
					var json_obj_type_text=JSON.stringify(myObject_type, null,0);
					var fn_name=arguments.callee.name;
					if(fn_name==undefined){
						re = /^function\s+([^(]+)/;
						fn_name=re.exec(arguments.callee.toString())[1];
					}
					$.showModalDialog({
							url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun, //&close_fun='+close_fun,
							dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
							height:400,// 500,
							width: 400,//900,
							title: 'SasiNet Frame work',
							scrollable: true,
							onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); 
							} //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
						});
					
				}else{
					document.getElementById('DIV_TXT_CLIENT_CODE').style.color='red';
					alert('Please Enter Client Code.');			
				}		
				
			}	// End CDS acc Help	
			
			function close_cds_acc_help(){
				document.Form1.TXT_CDS_ACC_NO.value;
			}	
			
			
			
			// ======================================================================================	
			var dynamic_row_id = '';
			var dynamic_product_feature_code = '';
			
			function dynamic_product_feature_grid_help(row_id,obj,help) {
				dynamic_row_id = row_id; 
				dynamic_product_feature_code = obj.name;
				product_feature_help(0);
				
			}	
			
			var dynamic_fee_feature_code = '';
			
			function dynamic_fee_feature_grid_help(row_id,obj,help) {
				dynamic_row_id = row_id; 
				dynamic_fee_feature_code = obj.name;
				fee_feature_help(0);
				
			}	
			
			// =======================================================================================	
			
			function edit_data(){
				document.Form1.TXT_FACILITY_NO.disabled = false;
				document.Form1.BUT_HELP_MAIN_1.disabled = false;
				document.Form1.SCREEN_NAME.value = 'EDIT' ;
				document.getElementById('div_lable').innerHTML='Facility Creation - Edit'; 
			}
			
			
			function load_facility_edit_scr()
			{
				//	alert("aaaa");
				m_facility=document.Form1.TXT_FACILITY_NO.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Edit_client_facility_values?facility_no="+m_facility+"&chksql=edit_facility";
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
				
				if (m_size > 0) 
				{
					//document.Form1.TXT_FACILITY_NO.value = data_vec[0];
					document.Form1.TXT_ACC_CODE.value    = data_vec[1];
					document.Form1.TXT_CLIENT_CODE.value = data_vec[2];
					document.Form1.TXT_BROKER_CODE.value = data_vec[3];
					document.Form1.TXT_CDS_ACC_NO.value  = data_vec[4];
					document.Form1.TXT_FACILITY_MANAGER.value = data_vec[5];
					document.Form1.TXT_ADVISER_NAME.value = data_vec[6];
					document.Form1.TXT_RES_MARGIN.value = data_vec[7];
					
					document.Form1.TXT_SLAB_TYPE.value  = data_vec[8];
					document.Form1.TXT_VALUE_TYPE.value = data_vec[9];
					document.Form1.DISCOUNT_TYPE.value  = data_vec[10];
					document.Form1.TXT_VARIABLE_TYPE.value = data_vec[11];
					
					document.Form1.TXT_DISPLAY_INT_RATE.value = data_vec[12]*100;
					
					if(data_vec[13]=='B'){
						document.Form1.TXT_BANKING.checked = true;
						document.Form1.TXT_REALIZATION.checked = false;
					}
					else{
						document.Form1.TXT_BANKING.checked = false;
						document.Form1.TXT_REALIZATION.checked = true;
					}
					
					document.Form1.TXT_RETENTION.value = data_vec[14];
					document.Form1.TXT_CURRENCY.value = data_vec[15];
					document.Form1.TXT_LOCATION_CODE.value = data_vec[16];
					
					str1 = data_vec[17].split('-');
					document.Form1.TXT_START_DD.value = str1[0];
					document.Form1.TXT_START_MM.value = str1[1];
					document.Form1.TXT_START_YY.value = str1[2];
					
					str1 = data_vec[18].split('-');
					//document.Form1.TXT_APP_RECE_DD.value = str1[0];
					//document.Form1.TXT_APP_RECE_MM.value = str1[1];
					//document.Form1.TXT_APP_RECE_YY.value = str1[2];
					
					document.Form1.TXT_REVIEW_DD.value = str1[0];
					document.Form1.TXT_REVIEW_MM.value = str1[1];
					document.Form1.TXT_REVIEW_YY.value = str1[2];
					
					document.Form1.TXT_COMMENTS.value = data_vec[19];
					//document.Form1.TXT_PRODUCT_CODE.value = data_vec[20]; // commented by udara on 23-02-2012
					//document.Form1.TXT_FEE_CODE.value = data_vec[21]; // commented by udara on 23-02-2012
					document.Form1.TXT_FACT_STATUS.value = data_vec[22];
					
					document.Form1.TXT_DISPLAY_OVERPAID_RATE.value = data_vec[23]*100;
					document.Form1.TXT_FACT_FEE.value = data_vec[24];
					
					str1 = data_vec[25].split('-');
					document.Form1.TXT_INSPEC_DD.value = str1[0];
					document.Form1.TXT_INSPEC_MM.value = str1[1];
					document.Form1.TXT_INSPEC_YY.value = str1[2];
					
					str1 = data_vec[26].split('-');
					document.Form1.TXT_INFO_COM_DD.value = str1[0];
					document.Form1.TXT_INFO_COM_MM.value = str1[1];
					document.Form1.TXT_INFO_COM_YY.value = str1[2];
					
					document.Form1.TXT_S05_OTHER_COMMENT_9.value = data_vec[27];
					document.Form1.TXT_ADVISER_NAME.value = data_vec[28];
					document.Form1.TXT_CLIENT_NAME.value = data_vec[29];
					document.Form1.TXT_FACILITY_MANAGER_NAME.value = data_vec[30];
					
					document.Form1.TXT_BROKER_NAME.value= data_vec[31];
					//document.Form1.TXT_PRODUCT_DESC.value= data_vec[32];
					//document.Form1.TXT_FEE_DESC.value= data_vec[33];
					
					document.Form1.TXT_CREDIT_LIMIT.value= data_vec[34];
					document.Form1.TXT_CHARGE_FREQUENCY.value= data_vec[35];//add by waruna 2012-09-06
					document.Form1.TXT_SETTL_FREQUENCY.value= data_vec[36];//add by waruna 2012-09-06
					
				} // m_zize
				else //added by madhawa 2012-01-11
				{
					facility_code_help(0);
					
				}	
				
				if(document.Form1.TXT_SLAB_TYPE.value == "SLAB"){
					hideFlatDiscount();
					loadEditDiscountDetails();
					
				}
				
				//load_product_grid_new();
				//load_fee_grid_new();
				
			}
			
			
			// Added below by Udara on 17-10-2011			
			
			function loadEditDiscountDetails(){	
				m_facility=document.Form1.TXT_FACILITY_NO.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Edit_client_facility_values?facility_no="+m_facility+"&chksql=edit_discount_slab";
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
				
				if(m_size>0){
					
					m_act_len=parseInt(data_vec.length)/5;
					m_act_len=parseInt(m_act_len)-parseInt(document.Form1.hid_slab_count.value);
					
					for(var i=1;i<=parseInt(m_act_len);i++){
						add_fee_slab();
					}
					var m_count=0;
					for(k=1;k<=parseInt(document.Form1.hid_slab_count.value);k++){
						document.Form1.elements['TXT_SLAB_D_'+k].value=data_vec[m_count];
						document.Form1.elements['TXT_FROM_D_'+k].value=data_vec[m_count+1];
						document.Form1.elements['TXT_TO_D_'+k].value=data_vec[m_count+2];
						document.Form1.elements['TXT_DISPLAY_AMNT_D_'+k].value=data_vec[m_count+3];
						document.Form1.elements['TXT_DISPLAY_AMNT2_D_'+k].value=data_vec[m_count+4];
						m_count=m_count+5;
					}
					loadFeeSlabHeadEdit();
				}
			}
			
			
			
			function load_product_grid_new() { 
				jQuery('#product_data').GridUnload('#product_data');
				var product_code = document.Form1.TXT_PRODUCT_CODE.value;
				var facility_code = document.Form1.TXT_FACILITY_NO.value;
				
				if(document.Form1.SCREEN_NAME.value == 'NEW')
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Edit_client_facility_values?chksql=get_facility_product_grid&product_code="+product_code;
				else if(document.Form1.SCREEN_NAME.value == 'EDIT')
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Edit_client_facility_values?chksql=edit_facility_product_grid&product_code="+product_code+"&facility_code="+facility_code;
				
				jQuery('#product_data').jqGrid({
						url: m_url,
						loadonce: 1,
						datatype: 'json',
						colNames: ['Applicability','Product Code','Product Desc','Feature Comments','Activation Point','Action','Mail Code','Frequency','Send Mail','Send Fax','Send Letter'],
						colModel: [
							{name: 'APPLICABILITY',         index: 'APPLICABILITY',         jsonmap: 'APPLICABILITY',          sortable: false, align: 'center',  width: 80, resizable: false,   unformat: unformatData, formatter:cellFomatterApplicability},
							{name: 'FA_FEATURE_CODE',       index: 'FA_FEATURE_CODE',       jsonmap: 'FA_FEATURE_CODE',        sortable: false, align: 'left',    width: 170, resizable: false,  unformat: unformatData, formatter:cellFomatterProductFeatureCode},
							{name: 'FA_FEATURE_DESC',       index: 'FA_FEATURE_DESC',   	jsonmap: 'FA_FEATURE_DESC', 	   sortable: false, align: 'left',    width: 240, resizable: false,  unformat: unformatData, formatter:cellFomatterProductFeatureName},
							{name: 'FA_FEATURE_COMMENTS',   index: 'FA_FEATURE_COMMENTS',  	jsonmap: 'FA_FEATURE_COMMENTS',    sortable: false, align: 'left' ,   width: 140, resizable: false,  unformat: unformatData, formatter:cellFomatterCommentsText},
							{name: 'ACTIVATION_POINT_CODE', index: 'ACTIVATION_POINT_CODE', jsonmap: 'ACTIVATION_POINT_CODE',  sortable: false, align: 'left',    width: 220,  resizable: false,  unformat: unformatData},
							{name: 'ACTION',                index: 'ACTION',   	            jsonmap: 'ACTION',  	           sortable: false, align: 'left',    width: 110,  resizable: false,  unformat: unformatData, formatter:cellFomatterAction },
							{name: 'MAIL_CODE',             index: 'MAIL_CODE',   	        jsonmap: 'MAIL_CODE',              sortable: false, align: 'left',    width: 190,  resizable: false,  unformat: unformatData, formatter:cellFomatterMailCode},
							{name: 'FREQUENCY',             index: 'FREQUENCY',             jsonmap: 'FREQUENCY', 			   sortable: false, align: 'left',    width: 110,  resizable: false,  unformat: unformatData, formatter:cellFomatterFrequency},
							{name: 'SEND_MAIL',             index: 'SEND_MAIL',             jsonmap: 'SEND_MAIL', 			   sortable: false, align: 'center',  width: 80,  resizable: false,  unformat: unformatData, formatter:cellFomatterEmail},
							{name: 'SEND_FAX',              index: 'SEND_FAX',              jsonmap: 'SEND_FAX', 			   sortable: false, align: 'center',  width: 80,  resizable: false,  unformat: unformatData, formatter:cellFomatterFax},
							{name: 'SEND_LET',              index: 'SEND_LET',              jsonmap: 'SEND_LET', 			   sortable: false, align: 'center',  width: 80,  resizable: false,  unformat: unformatData, formatter:cellFomatterLetter}],
						
						mtype: 'GET',
						rownumbers: true,
						rowNum: -1,
						gridview: true,
						height: 'auto',
						width: 'auto',
						hidegrid: false,
						toolbar: [false, 'top'],
						caption: 'Product Details',
						jsonReader: {repeatitems: false},
						gridComplete: function() {
							
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_1').css('cursor', 'default');
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_2').css('cursor', 'default');
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_5').css('cursor', 'default');
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_6_0').css('cursor', 'default');
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_6').css('cursor', 'default');
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_7').css('cursor', 'default');
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_8').css('cursor', 'default');
							
							
						},
						loadComplete : function(){
							var rec_count=$("#product_data").jqGrid('getGridParam',"records");
							//document.Form1.hid_count.value=rec_count;
							document.Form1.hid_product_count.value = rec_count;
						}
					});
			}
			
			function unformatData(cellvalue, options, cellobject) {
				return cellvalue;
			}
			
			function cellFomatterApplicability (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				if (cellvalue =="Y") 
					var checkbox = "<input type='checkbox' id='CHK_PRO_"+row_id+"' name='CHK_PRO_"+row_id+"' checked />";
				else 
					var checkbox = "<input type='checkbox' id='CHK_PRO_"+row_id+"' name='CHK_PRO_"+row_id+"'  />";
				return checkbox;
			}
			
			function cellFomatterProductFeatureCode (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var texts = "<input class='txt_input' type='text' id='TXT_PRO_FEATURE_CODE_"+row_id+"' name='TXT_PRO_FEATURE_CODE_"+row_id+"' value='"+cellvalue+"' style='width:100px' maxlength='90' onblur=\"\" ><input class='but_input' type='button' name='TXT_PRO_FEATURE_CODE_"+row_id+"' value='...' onClick=\"dynamic_product_feature_grid_help("+row_id+",this);\" >";
				return texts;
			}
			
			
			function cellFomatterProductFeatureName (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var texts = "<input class='txt_input' type='text' id='TXT_PRO_FEATURE_NAME_"+row_id+"' name='TXT_PRO_FEATURE_NAME_"+row_id+"' value='"+cellvalue+"' style='width:230px' maxlength='90' disabled >";
				return texts;
			}		
			
			function cellFomatterCommentsText (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var texts = "<input class='txt_input' type='text' id='TXT_COMMENTS_"+row_id+"' name='TXT_COMMENTS_"+row_id+"' value='"+cellvalue+"' style='width:130px' maxlength='4000' onblur=\"strTrim(this, null, null, \'COMMENT\');\" />";
				return texts;
			}
			
			
			function cellFomatterAction (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				if (cellvalue=="A" || cellvalue=="B"){ 
					if(cellvalue=="A") 
						var texts = "<select class='txt_input' type='text' id='TXT_ACTION_"+row_id+"' name='TXT_ACTION_"+row_id+"' style='width:100px' ><option VALUE='A' SELECTED>Action 1</option><option VALUE='B'>Action 2</option></select>";
					if(cellvalue=="B") 
						var texts = "<select class='txt_input' type='text' id='TXT_ACTION_"+row_id+"' name='TXT_ACTION_"+row_id+"' style='width:100px' ><option VALUE='A'>Action 1</option><option VALUE='B' SELECTED>Action 2</option>></select>";
				}
				else { 
					if(cellvalue=="A1") 
						var texts = "<select class='txt_input' type='text' id='TXT_ACTION_"+row_id+"' name='TXT_ACTION_"+row_id+"' style='width:100px' ><option VALUE='A1' SELECTED>Action 1</option><option VALUE='A2'>Action 2</option><option VALUE='A3'>Action 3</option></select>";
					if(cellvalue=="A2") 
						var texts = "<select class='txt_input' type='text' id='TXT_ACTION_"+row_id+"' name='TXT_ACTION_"+row_id+"' style='width:100px' ><option VALUE='A1'>Action 1</option><option VALUE='A2' SELECTED>Action 2</option><option VALUE='A3'>Action 3</option></select>";
					if(cellvalue=="A3") 
						var texts = "<select class='txt_input' type='text' id='TXT_ACTION_"+row_id+"' name='TXT_ACTION_"+row_id+"' style='width:100px' ><option VALUE='A1'>Action 1</option><option VALUE='A2'>Action 2</option><option VALUE='A3' SELECTED>Action 3</option></select>";
				}
				return texts;
			}
			
			
			function cellFomatterFrequency (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				if (cellvalue=="A" || cellvalue=="B"){ 
					if(cellvalue=="A") 
						var texts = "<select class='txt_input' type='text' id='TXT_FREQUENCY_"+row_id+"' name='TXT_FREQUENCY_"+row_id+"' style='width:100px' ><option VALUE='A' SELECTED>Frequency 1</option><option VALUE='B'>Frequency 2</option></select>";
					if(cellvalue=="B") 
						var texts = "<select class='txt_input' type='text' id='TXT_FREQUENCY_"+row_id+"' name='TXT_FREQUENCY_"+row_id+"' style='width:100px' ><option VALUE='A'>Frequency 1</option><option VALUE='B' SELECTED>Frequency 2</option></select>";
				}
				else { 
					if(cellvalue=="F1") 
						var texts = "<select class='txt_input' type='text' id='TXT_FREQUENCY_"+row_id+"' name='TXT_FREQUENCY_"+row_id+"' style='width:100px' ><option VALUE='F1' SELECTED>Frequency 1</option><option VALUE='F2'>Frequency 2</option><option VALUE='F3'>Frequency 3</option></select>";
					if(cellvalue=="F2") 
						var texts = "<select class='txt_input' type='text' id='TXT_FREQUENCY_"+row_id+"' name='TXT_FREQUENCY_"+row_id+"' style='width:100px' ><option VALUE='F1'>Frequency 1</option><option VALUE='F2' SELECTED>Frequency 2</option><option VALUE='F3C'>Frequency 3</option></select>";
					if(cellvalue=="F3") 
						var texts = "<select class='txt_input' type='text' id='TXT_FREQUENCY_"+row_id+"' name='TXT_FREQUENCY_"+row_id+"' style='width:100px' ><option VALUE='F1'>Frequency 1</option><option VALUE='F2'>Frequency 2</option><option VALUE='F3' SELECTED>Frequency 3</option></select>";
				}
				return texts;
			}
			
			
			function cellFomatterMailCode (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var texts = "<input class='txt_input' type='text' id='TXT_MAIL_CODE_"+row_id+"' name='TXT_MAIL_CODE_"+row_id+"' value='"+cellvalue+"' style='width:120px' maxlength='4000' onblur=\"strTrim(this);help_mail_code("+row_id+",\'help_mail_code\')\" ><input class='but_input' type='button' name='PRO_MAIL_CODE_"+row_id+"' value='...' onClick=\"help_mail_code("+row_id+",\'help_mail_code\')\" ><a onClick=\"help_mail_code("+row_id+",\'help_mail_code\')\" style=' text-decoration: none;cursor: text;' id='help_mail_code' class='fancylink iframe' href=''> </a>";
				return texts;
			}		
			
			function cellFomatterEmail (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				if (cellvalue =="Y") 
					var checkbox = "<input type='checkbox' id='CHK_MAIL_"+row_id+"' name='CHK_MAIL_"+row_id+"' checked />";
				else 
					var checkbox = "<input type='checkbox' id='CHK_MAIL_"+row_id+"' name='CHK_MAIL_"+row_id+"'  />";
				return checkbox;
			}
			
			
			function cellFomatterFax (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				if (cellvalue =="Y") 
					var checkbox = "<input type='checkbox' id='CHK_FAX_"+row_id+"' name='CHK_FAX_"+row_id+"' checked />";
				else 
					var checkbox = "<input type='checkbox' id='CHK_FAX_"+row_id+"' name='CHK_FAX_"+row_id+"'  />";
				return checkbox;
			}
			
			function cellFomatterLetter (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				if (cellvalue =="Y") 
					var checkbox = "<input type='checkbox' id='CHK_LEETER_"+row_id+"' name='CHK_LETTER_"+row_id+"' checked />";
				else 
					var checkbox = "<input type='checkbox' id='CHK_LEETER_"+row_id+"' name='CHK_LETTER_"+row_id+"'  />";
				return checkbox;
			}	
			
			// ====================================================================================	
			
			function load_fee_grid_new() { 
				jQuery('#fee_data').GridUnload('#fee_data');
				var fee_code = document.Form1.TXT_FEE_CODE.value;
				var facility_code = document.Form1.TXT_FACILITY_NO.value;
				
				if(document.Form1.SCREEN_NAME.value == 'NEW')
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Edit_client_facility_values?chksql=get_facility_fee_grid&fee_code="+fee_code;
				else if(document.Form1.SCREEN_NAME.value == 'EDIT')
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Edit_client_facility_values?chksql=edit_facility_fee_grid&fee_code="+fee_code+"&facility_code="+facility_code;
				
				jQuery('#fee_data').jqGrid({
						url: m_url,
						loadonce: 1,
						datatype: 'json',
						colNames: ['Applicability','Fee Code','Fee Desc','Fee Type','Minimum Value','Calculation Basis','Activation Point','Tax Applicability','Fee Effects','Effect Date'],
						colModel: [
							{name: 'APPLICABILITY',     index: 'APPLICABILITY',       jsonmap: 'APPLICABILITY',     sortable: false, align: 'center',  width: 80,   resizable: false,  unformat: unformatData, formatter:cellFomatterApplicabilityFee},
							{name: 'FEE_CODE',          index: 'FEE_CODE',            jsonmap: 'FEE_CODE',          sortable: false, align: 'left',    width: 160,  resizable: false,  unformat: unformatData, formatter:cellFomatterFeeFeatureCode},
							{name: 'FEE_DESC',          index: 'FEE_DESC',   	      jsonmap: 'FEE_DESC', 	        sortable: false, align: 'left',    width: 240,  resizable: false,  unformat: unformatData, formatter:cellFomatterFeeFeatureName},
							{name: 'FEE_TYPE',          index: 'FEE_TYPE',  	      jsonmap: 'FEE_TYPE',          sortable: false, align: 'left' ,   width: 100,  resizable: false,  unformat: unformatData, formatter:cellFomatterFeeType},
							{name: 'MINIUM_VALUE',      index: 'MINIUM_VALUE',        jsonmap: 'MINIUM_VALUE',      sortable: false, align: 'left',    width: 140,  resizable: false,  unformat: unformatData, formatter:cellFomatterAmount},
							{name: 'CAL_BASIS',         index: 'CAL_BASIS',   	      jsonmap: 'CAL_BASIS',  	    sortable: false, align: 'left',    width: 220,  resizable: false,  unformat: unformatData},
							{name: 'ACTIVATION_POINT',  index: 'ACTIVATION_POINT',    jsonmap: 'ACTIVATION_POINT',  sortable: false, align: 'left',    width: 220,  resizable: false,  unformat: unformatData},
							{name: 'TAX_APPLICABILITY', index: 'TAX_APPLICABILITY',   jsonmap: 'TAX_APPLICABILITY', sortable: false, align: 'left',    width: 110,  resizable: false,  unformat: unformatData, formatter:cellFomatterTax},
							{name: 'FEE_EFFECTS',       index: 'FEE_EFFECTS',         jsonmap: 'FEE_EFFECTS', 		sortable: false, align: 'center',  width: 100,   resizable: false,  unformat: unformatData, formatter:cellFomatterFeeEffects},
							{name: 'EFFECT_DATE',       index: 'EFFECT_DATE',         jsonmap: 'EFFECT_DATE', 	    sortable: false, align: 'center',  width: 160,   resizable: false,  unformat: unformatData, formatter:cellFomatterDate}],
						
						mtype: 'GET',
						rownumbers: true,
						rowNum: -1,
						gridview: true,
						height: 'auto',
						width: 'auto',
						hidegrid: false,
						toolbar: [false, 'top'],
						caption: 'Fee Details',
						jsonReader: {repeatitems: false},
						gridComplete: function() {
							
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_1').css('cursor', 'default');
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_2').css('cursor', 'default');
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_5').css('cursor', 'default');
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_6_0').css('cursor', 'default');
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_6').css('cursor', 'default');
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_7').css('cursor', 'default');
							$('#jqgh_ACTUAL_PAYMENTS_COLUMN_8').css('cursor', 'default');
							
							
						},
						loadComplete : function(){
							var rec_count=$("#fee_data").jqGrid('getGridParam',"records");
							//document.Form1.hid_count.value=rec_count;
							document.Form1.hid_fee_count.value = rec_count;
						}
					});
				
			}
			
			
			
			function cellFomatterApplicabilityFee (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				if(cellvalue=="Y") 
					var checkbox = "<input type='checkbox' id='CHK_FEE_"+row_id+"' name='CHK_FEE_"+row_id+"' checked />";
				else 
					var checkbox = "<input type='checkbox' id='CHK_FEE_"+row_id+"' name='CHK_FEE_"+row_id+"'  />";
				return checkbox;
			}
			
			
			
			
			function cellFomatterFeeFeatureCode (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var texts = "<input class='txt_input' type='text' id='TXT_FEE_FEATURE_CODE_"+row_id+"' name='TXT_FEE_FEATURE_CODE_"+row_id+"' value='"+cellvalue+"' style='width:100px' maxlength='90' onblur=\"\" ><input class='but_input' type='button' name='TXT_FEE_FEATURE_CODE_"+row_id+"' value='...' onClick=\"dynamic_fee_feature_grid_help("+row_id+",this)\" >";
				return texts;
			}
			
			
			function cellFomatterFeeFeatureName (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var texts = "<input class='txt_input' type='text' id='TXT_FEE_FEATURE_NAME_"+row_id+"' name='TXT_FEE_FEATURE_NAME_"+row_id+"' value='"+cellvalue+"' style='width:230px' maxlength='90' disabled >";
				return texts;
			}
			
			
			function cellFomatterFeeType (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				if(cellvalue=="P") 
					var texts = "<select class='txt_input' type='text' id='TXT_FEE_TYPE_"+row_id+"' name='TXT_FEE_TYPE_"+row_id+"' style='width:100px' ><option VALUE='P' SELECTED>Percentage</option><option VALUE='V'>Variable</option><option VALUE='F'>Flat</option></select>";
				if(cellvalue=="V") 
					var texts = "<select class='txt_input' type='text' id='TXT_FEE_TYPE_"+row_id+"' name='TXT_FEE_TYPE_"+row_id+"' style='width:100px' ><option VALUE='P'>Percentage</option><option VALUE='V' SELECTED>Variable</option><option VALUE='F'>Flat</option></select>";
				if(cellvalue=="F") 
					var texts = "<select class='txt_input' type='text' id='TXT_FEE_TYPE_"+row_id+"' name='TXT_FEE_TYPE_"+row_id+"' style='width:100px' ><option VALUE='P'>Percentage</option><option VALUE='V' >Variable</option><option VALUE='F' SELECTED>Flat</option></select>";
				return texts;
			}
			
			function cellFomatterAmount (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var texts = "<input class='txt_input' type='text' id='TXT_FEE_AMOUNT_"+row_id+"' name='TXT_FEE_AMOUNT_"+row_id+"' value='"+cellvalue+"' style='width:130px;text-align:right' maxlength='4000' onchange=\"format_num(this, 4);\" />";
				return texts;
			}
			function cellFomatterTax (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				if(cellvalue=="Y") 
					var texts = "<select class='txt_input' type='text' id='TXT_TAX_APPLICABLE_"+row_id+"' name='TXT_TAX_APPLICABLE_"+row_id+"' style='width:100px' ><option VALUE='Y' SELECTED>Yes</option><option VALUE='N'>No</option></select>";
				if(cellvalue=="N") 
					var texts = "<select class='txt_input' type='text' id='TXT_TAX_APPLICABLE_"+row_id+"' name='TXT_TAX_APPLICABLE_"+row_id+"' style='width:100px' ><option VALUE='Y'>Yes</option><option VALUE='N' SELECTED>No</option></select>";
				return texts;
			}
			function cellFomatterFeeEffects (cellvalue, options, rowObject){
				var row_id=options['rowId'];
				if(cellvalue=="A") 
					var texts = "<select class='txt_input' type='text' id='TXT_FEE_EFFECTS_"+row_id+"' name='TXT_FEE_EFFECTS_"+row_id+"' style='width:100px' ><option VALUE='A' SELECTED>Automatic</option><option VALUE='M'>Mannual</option></select>";
				if(cellvalue=="M") 
					var texts = "<select class='txt_input' type='text' id='TXT_FEE_EFFECTS_"+row_id+"' name='TXT_FEE_EFFECTS_"+row_id+"' style='width:100px' ><option VALUE='A'>Automatic</option><option VALUE='M' SELECTED>Mannual</option></select>";
				return texts;
			}
			function cellFomatterDate(cellvalue, options, rowObject){
				var row_id=options['rowId'];
				var m_dd=cellvalue.substr(0,2);
				var m_mm=cellvalue.substr(3,2);
				var m_yy=cellvalue.substr(6,4);
				var text = "<input type = 'text' id = 'TXT_EFF_DD_"+row_id+"' name = 'TXT_EFF_DD_"+row_id+"' maxlength = '2' size = '2'  value = '"+m_dd+"'  onBlur = 'checkMonthLength1(document.Form1.elements[TXT_EFF_DD_"+row_id+"], document.Form1.elements[TXT_EFF_MM_"+row_id+"], document.Form1.elements'TXT_EFF_YY_"+row_id+"], document.Form1.elements[FEE_DATE_"+row_id+"], 'D', 'N');' >" + 
					"<input type = 'text' id = 'TXT_EFF_MM_"+row_id+"' name = 'TXT_EFF_MM_"+row_id+"' maxlength = '2' size = '2'  value = '"+m_mm+"'  onBlur = 'checkMonthLength1(document.Form1.elements[TXT_EFF_DD_"+row_id+"], document.Form1.elements[TXT_EFF_MM_"+row_id+"], document.Form1.elements'TXT_EFF_YY_"+row_id+"], document.Form1.elements[FEE_DATE_"+row_id+"], 'M', 'N');' >" + 
					"<input type = 'text' id = 'TXT_EFF_YY_"+row_id+"' name = 'TXT_EFF_YY_"+row_id+"' maxlength = '4' size = '4'  value = '"+m_yy+"'  onBlur = 'checkMonthLength1(document.Form1.elements[TXT_EFF_DD_"+row_id+"], document.Form1.elements[TXT_EFF_MM_"+row_id+"], document.Form1.elements'TXT_EFF_YY_"+row_id+"], document.Form1.elements[FEE_DATE_"+row_id+"], 'Y', 'N');' >" + 
					"<input type = 'hidden' id = 'FEE_DATE_"+row_id+"' name = 'FEE_DATE_"+row_id+"'  /> " ;
				return text;
			}	
			//ADDED BY PRABASH ON 28-12-2011-------------------------------**  
			function Facility_view(){
				<%
				
				String m_chksql   	= request.getParameter("chksql");
				String m_Facility_no  = request.getParameter("facility_no");
				//	out.println("alert('"+m_chksql+"');");
				//	out.println("alert('"+m_Facility_no+"');");
				
				out.println("var chksql2 ='"+m_chksql+"'");
				out.println("var Facility_no2 ='"+m_Facility_no+"'");
				%>	
				
				if (chksql2== 'Facility_view') {
					
					edit_data();
					document.Form1.TXT_FACILITY_NO.value = Facility_no2;	
					load_facility_edit_scr();
					document.Form1.TXT_FACILITY_NO.disabled =true;
					document.Form1.save_but.disabled=true;
					document.Form1.add_but.disabled=true;
					document.Form1.Exit.disabled=true;
					document.Form1.Cancel.disabled=true;
					document.Form1.edit.disabled=true;	
				}
			}	
			//-------------------------------------------------------------**	
			
			//---add by waruna 2012-09-06-----------------------------------------------------
			function loadInterestFrq(){	
				m_facility=document.Form1.TXT_FACILITY_NO.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Edit_client_facility_values?chksql=get_interest_frq";
				//window.open(m_url);
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
				
				if(m_size>0){
					
					var m_int_frq_len=parseInt(data_vec.length);
				
					var m_count=0;
					for(m_count=0;m_count<parseInt(m_int_frq_len);){
						
					   var select = document.getElementById("TXT_CHARGE_FREQUENCY");
					   select.options[select.options.length] = new Option(data_vec[m_count+1],data_vec[m_count]);
                        
						m_count=m_count+3;
					}
					
				}
			}
			
			function loadsettlFrq(){	
				m_facility=document.Form1.TXT_FACILITY_NO.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Edit_client_facility_values?chksql=get_settl_frq";
				//window.open(m_url);
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
				
				if(m_size>0){
					
					var m_int_frq_len=parseInt(data_vec.length);
				
					var m_count=0;
					for(m_count=0;m_count<parseInt(m_int_frq_len);){
						
					   var select = document.getElementById("TXT_SETTL_FREQUENCY");
					   select.options[select.options.length] = new Option(data_vec[m_count+1],data_vec[m_count]);
                        
						m_count=m_count+3;
					}
					
				}
			}
			//--end by waruna 2012-09-06------------------------------------------------------
			
		</script>
		<!--<BODY class='body & txt-body' leftmargin='0' topmargin='0' marginwidth='0' ONLOAD="load_lock();reset_hid_values(); delete_third_party_guarantors_details(0);hideFlatDiscount();">-->			<!--comment by Prabash on 28-12-2011-->
		<BODY class='body & txt-body' leftmargin='0' topmargin='0' marginwidth='0' ONLOAD="load_lock();reset_hid_values(); delete_third_party_guarantors_details(0);hideFlatDiscount();Facility_view();loadInterestFrq();loadsettlFrq();" >   <!--added by Prabash on 28-12-2011-->
			<FORM NAME='Form1' ID='Form1' method='post'>
				<input  type='hidden' value='NEW' name='SCREEN_NAME' id='SCREEN_NAME'> 
				<INPUT TYPE='Hidden' NAME='hid_help_type' VALUE="">
				<INPUT TYPE='Hidden' NAME='hid_help_status' VALUE="">
				<INPUT TYPE='Hidden' NAME='hid_status' VALUE="New">
				<INPUT TYPE='Hidden' NAME='hid_option' VALUE="99">
				<INPUT TYPE='Hidden' NAME='hid_product_count' VALUE="0">
				<INPUT TYPE='Hidden' NAME='hid_fee_count' VALUE="0">
				<INPUT TYPE='Hidden' NAME='hid_display_client' VALUE="99">
				<INPUT TYPE='Hidden' NAME='hid_help_count' VALUE="0">
				<INPUT TYPE='Hidden' NAME='hid_cal_date' VALUE="">
				<INPUT TYPE='Hidden' NAME='hid_reports_count' VALUE="0">
				
				<INPUT TYPE='Hidden' NAME='hid_doc_count' VALUE="0">
				<INPUT TYPE='Hidden' NAME='hid_sup_doc_count' VALUE="0">
				<INPUT TYPE='Hidden' NAME='hid_f_count' VALUE=0>
				<INPUT TYPE='Hidden' NAME='hid_security_setup_count' VALUE="0">
				<INPUT TYPE='Hidden' NAME='hid_facility_status' VALUE="">
				<input type = "hidden" name = "hid_help_row_number" value = "" />
				<input type = "hidden" name = "hid_previous_product_code" value = "" />
				<input type = "hidden" name = "hid_new_product_code" value = "" />
				<INPUT TYPE='Hidden' NAME='hid_slab_count' VALUE="0">
				<input type = "hidden" name = "hid_coll_officer" value = "" />
				<input type = "hidden" name = "hid_temp_facility_code" value = "" />
				<input type = "hidden" name = "hid_proposed_security_details" value = "0" />
				<input type = "hidden" name = "hid_third_party_guarantors_details_count" value = "0">
				<input type = "hidden" name = "hid_curr_action" value = "" />
				<input type = "hidden" name = "hid_next_action" value = "" />
				<input type = "hidden" name = "hid_action_be_taken_by" value = "" />
				<input type = "hidden" name = "hid_priority" value = "" />
				
				<input type = "hidden" name = "hid_due_date" value = "" />
				<input type = "hidden" name = "hid_comment" value = "" />
				<input type = "hidden" name = "hid_screen_name" value = "" />
				<input type = "hidden" name = "hid_division" value = "" />
				<input type = "hidden" name = "hid_sub_division" value = "" />
				<input type = "hidden" name = "hid_ref_number" value = "no-ref" />
				<input type = "hidden" name = "hid_status_value" value = "N" />
				<input type = "hidden" name = "hid_pre_followup_number" value = "no-follow" />
				<input type = "hidden" name = "hid_action_screen" value = "" />
				<input type = "hidden" name = "hid_temp_facility_no_b" id = "hid_temp_facility_no_b" value = "NEW" />
				<input type = "hidden" name = "hid_temp_facility_no_s" id = "hid_temp_facility_no_s" value = "NEW" />
				<input type = "hidden" name = "hid_temp_facility_no_u" id = "hid_temp_facility_no_u" value = "NEW" />
				<input type = "hidden" name = "hid_temp_facility_no_a" id = "hid_temp_facility_no_a" value = "NEW" />
				
				
				<DIV>
					<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
						<tr>
							<td height='7'></td>
						</tr>
						
						<tr height='30' >
							<td  width='13' style ="background-image:url('<%=jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
							<td  style ="background-image:url('<%=jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Administration - Client Master Sub Module</B></td> 
							<!--<td  style ="background-image:url('<%=jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B><DIV id='div_screen_status' > Administration - Client Master Sub Module </DIV></B></td>-->
							<td width='13' style ="background-image:url('<%=jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>						
						</tr>
							
						</TABLE>	
							
						</DIV>	
							
							
							<table class='table' cellpadding='2' cellspacing='2' border='0'> 
							<tr>
							<td width='6%'>
							<input type="button" class='mainbut' name="add_but" onclick='load_screen_status("NEW");' value="Add">
						</td>
							<td width='6%' >
							<input type="button" class='mainbut' name="edit"  onClick='edit_data();' value="Edit">
						</td>
							<TD WIDTH='10%'>&nbsp;&nbsp;&nbsp;&nbsp;</TD>		
							<td width='6%' >
							<input type="button" class='mainbut' name="save_but"  onClick='save_window();' value="Save">
						</td>
							<td width='6%' >
							<input type="button" class='mainbut' name="Cancel"  onclick="top.frames[1].location.href=top.frames[1].location.href;" value="Cancel">
						</td>
							<!-- <td width='5%' align='center'><input type="button" class='mainbut'  onclick='show_log_drill();' value="View Log"></td> -->
							
							<!--<td width='6%'>												
							<input type="button" class='mainbut'  onClick='load_screen_status("HELP");' value="Help">
						</td>-->
							<td>
							<input type="button" class='mainbut' name="Exit"  onclick="location.href='low.jsp'" value="Exit">
						</td>
							<TD> <B><div id='div_lable' align='right' > </div> </B> </TD>		
						</tr>
						</table>
							
							<!-- Start Body Objects -->	
							<hr>				
							<br>
							
							
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr>
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_FACILITY_NO'  class='div_input'>Facility Number *</DIV></td>
							<td width='30%' ><input class='txt_input' type='text' name='TXT_FACILITY_NO' id='TXT_FACILITY_NO' maxlength='20' size='10' onblur="load_facility_edit_scr();" disabled >
							<input class='but_input' type='button' name='BUT_HELP_MAIN_1' value="..." onClick="facility_code_help(0);"  disabled></td>
							<td width='20%' ><DIV id='DIV_TXT_EXT_FACILITY_NO'  class='div_input' style="display:none" >Existing Facility Number</DIV></td>
							<td width='30%' ><DIV id='DIV_TXT_EXT_FACILITY_NO_TEXT'  class='div_input' style="display:none" ><input class='txt_input' type='text' name='TXT_EXT_FACILITY_NO' id='TXT_EXT_FACILITY_NO' maxlength='15' size='10' ></DIV></td>
							<td width='*%'></td>
						</tr>
						</table>
							
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr>
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_ACC_CODE'  class='div_input'>Client Account Code *</DIV></td>
							<td width='30%' ><input class='txt_input' type='text' name='TXT_ACC_CODE' maxlength='10' size='10' onblur="" >
							<!-- <input class='but_input' type='button' name='BUT_HELP_ACC' value="..." onClick=""> --> </td>
							<td width='20%' ><DIV id='DIV_TXT_FACT_STATUS'  class='div_input'>Facility Status</DIV></td>
							<td width='30%' ><select name="TXT_FACT_STATUS" class="txt_input" style ='width:120px;' onChange=""> <!-- setFacilityStatus(); -->
							<OPTION value="REGULAR" SELECTED>Regular </option>
							<!--<OPTION value="LEGAL">Legal </option>
							
							<OPTION value="RECOVERIES" >Recoveries </option>-->
					        <OPTION value="DEACTIVATED" >Deactivated</option>			
							<OPTION value="TERMINATED">Terminated </option>
						</select></td>
							<td width='*%'></td>						
						</tr>
						</table>
							
							
							
							
							
							
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr>
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_CLIENT_CODE'  class='div_input' >Client Code *</DIV></td>
							<td width='30%' >
							<input class='txt_input' type='text' name='TXT_CLIENT_CODE' maxlength='10' size='10' onblur="">
							<input class='but_input' type='button' name='BUT_HELP_MAIN' value="..." onClick="client_no_help(0)">
							<!-- 
							<input class='but_input' type='button' name='BUT_HELP_DETAIL' value="Details" onClick="show_client_drill(document.Form1.TXT_CLIENT_CODE.value)" Disabled> 
							-->
						</td>
							<td width='20%' ><DIV id='DIV_TXT_CLIENT_DESC'  class='div_input' >Client Name</DIV></td>
							
							<td width='30%' ><input class='txt_input' type='text' name='TXT_CLIENT_NAME' maxlength='10' size='50' style='width:200px' disabled></td>
							<td width='*%'></td>
						</tr>
						</table>
							
							<!-- udara -->
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr>
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_BROKER_CODE'  class='div_input' >Broker Code *</DIV></td>
							<td width='30%' ><input class='txt_input' type='text' name='TXT_BROKER_CODE' maxlength='10' size='10' onblur="">
							<input class='but_input' type='button' name='BUT_HELP_MAIN' value="..." onClick="broker_no_help(0)">
							<!-- <input class='but_input' type='button' name='BUT_HELP_DETAIL' value="Details" onClick="show_client_drill(document.Form1.TXT_CLIENT_CODE.value)" Disabled> -->
						</td>
							<td width='20%' ><DIV id='DIV_TXT_CLIENT_DESC'  class='div_input' >Broker Name</DIV></td>
							
							<td width='30%' ><input class='txt_input' type='text' name='TXT_BROKER_NAME' maxlength='10' size='50' style='width:200px' disabled></td>
							<td width='*%'></td>
						</tr>
						</table>										
							<!-- end by udara -->
							
							
							<!-- udara -->
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr>
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_CDS_ACC_NO'  class='div_input' >CDS Account No.</DIV></td>
							<td width='30%' ><input class='txt_input' type='text' name='TXT_CDS_ACC_NO' maxlength='15' size='10' onblur="cds_acc_help(0);" > <!-- onClick="cds_acc_help(0);" -->
							<input class='but_input' type='button' name='BUT_HELP_MAIN' value="..." onClick="cds_acc_help(0);">
						</td>
							<td width='20%' > &nbsp; </td>
							<td width='30%'> &nbsp; </td>
							<td width='*%'></td>						
						</tr>
						</table>										
							<!-- end by udara -->										
							
							
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr >
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_FACILITY_MANAGER'  class='div_input' >Facility Manager *</DIV></td>
							<td width='30%' ><input class='txt_input' type='text' name='TXT_FACILITY_MANAGER' maxlength='50' size='50' onblur="">
							<input class="but_input" type="button" name="BUT_CLIENT_MGT" value="..." onClick="facility_client_manager(0);"></td>
							<td width='20%' ><DIV id='DIV_TXT_FACILITY_MANAGER_NAME'  class='div_input' >Facility Manager Name</DIV></td>
							<td width='30%' ><input class='txt_input' type='text' name='TXT_FACILITY_MANAGER_NAME' maxlength='50' size='50'  style='width:200px' disabled></td>
							<td width='*%'></td>
						</tr>
						</table>
							
							<!-- udara -->										
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr >
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_ADVISER_NAME'  class='div_input' >Adviser Code</DIV></td>
							<td width='30%' ><input class='txt_input' type='text' name='TXT_ADVISER_NAME' maxlength='50' size='50' onblur="">
							<input class="but_input" type="button" name="BUT_ADVISER_NAME" value="..." onClick="adviser_code_help(0)"></td>
							<td width='20%' > </td>
							<td width='30%' ></td>
							<td width='*%'></td>
						</tr>
						</table>
							<!-- end by udara -->											
							
							<table border='0' style="display:none" align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr >
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_QUOTATION_NO' style="display:none" class='div_input' >Quotation Number </DIV></td>
							<td width='30%' ><DIV id='DIV_TXT_QUOTATION_NOOBJ_DIV' style="display:none" ><input class='txt_input' type='text' name='TXT_QUOTATION_NO' maxlength='20' size='10' onblur="help_update_quotation('help_quotation')">
							<input class='but_input' type='button' name='BUT_HELP_MAIN_2' value="..." onClick="help_update_quotation('help_quotation')"></td></DIV>
							<td width='20%' ><DIV id='DIV_TXT_CLIENT_DESC' style="display:none" class='div_input' >Marketing Executive</DIV></td>
							<td width='30%' ><DIV id='DIV_TXT_CLIENT_MMGR' style="display:none" > <input class='txt_input' type='text' name='TXT_CLIENT_MMGR' maxlength='10' size='50' style='width:200px' disabled></DIV></td>
							<td width='*%'></td>
						</tr>
						</table>
							
							
							<table border='0' style="display:none" align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr >	
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_CREDIT_PERIOD' style="display:none"  class='div_input' >Credit Period *</DIV></td>	
							<td width='30%' ><DIV id='DIV_TXT_CREDIT_PERIOD_ROW' style="display:none" >
							<input class='txt_input' type='text' name='TXT_CREDIT_PERIOD' maxlength='25' size='50' style='width:200;text-align:right;'  value='0'  onBlur="validateNumber(this, 0, 9999, 0, 'number');setRecoursePeriod()">
							<input class='but_input' type='button' name='BUT_APP_DEBTOR'  style='width:100px;'    value = "Apply to Debtors" onClick="applyToDebtors();" disabled></td>
							<td width='20%' ><DIV id='DIV_TXT_TOL_CREDIT_PERIOD'  class='div_input'  style="display:none" >Disapproval Period *</DIV></td>
							<td width='30%' ><DIV id='DIV_TXT_TOL_CREDIT_PERIOD_TEXT'  class='div_input'  style="display:none" > <input class='txt_input' type='text' name='TXT_TOL_CREDIT_PERIOD' maxlength='25' size='50' style='width:200;text-align:right;' value='0'  onBlur="validateNumber(this, 0, 9999, 0, 'number');setRecoursePeriod()"></td>
							<td width='*%'> </DIV></td>	
						</tr>											
						</table>
							
							
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr >
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_CREDIT_LIMIT'   class='div_input' >Credit Limit *</DIV></td>
							<td width='30%' ><DIV id='DIV_TXT_CREDIT_LIMIT_TEXT' ><input class='txt_input' type='text' name='TXT_CREDIT_LIMIT' maxlength='25' size='50' style='width:200;text-align:right;' value='0.00'  onBlur="validateNumber(this, 0, 9999999999999999.99, 2, 'number');"></DIV></td>
							<td width='20%' ><DIV id='DIV_TXT_RECOURSE_PERIOD' style="display:none"  class='div_input' >Recourse Period</DIV></td>
							<td width='30%' ><DIV id='DIV_TXT_RECOURSE_PERIOD_TEXT' style="display:none" ><input class='txt_input' type='text' name='TXT_RECOURSE_PERIOD' maxlength='25' size='50' style='width:200;text-align:right;'    onBlur="validateNumber(this, 0, 9999, 0, 'number')" disabled> </DIV></td>
							<td width='*%'></td>
							
						</tr>
						</table>
							
							
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr >
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_RES_MARGIN' style="display:none" class='div_input' >Retention% *</DIV></td>
							<td width='30%' ><DIV id='DIV_TXT_RES_MARGIN_LABEL' style="display:none" > <input class='txt_input' type='text' name='TXT_RES_MARGIN' id='TXT_RES_MARGIN' maxlength='25' size='25' style='width:200;text-align:right;'   value='0.00'  onBlur="setValue(this);"></DIV></td>
							<td width='20%' ><DIV id='DIV_TXT_ADVANCE_LABEL' style="display:none" class='div_input' >Prepayment%</DIV></td>
							<td width='30%' ><DIV id='DIV_TXT_ADVANCE' style="display:none" > <input class='txt_input' type='text' name='TXT_ADVANCE' maxlength='25' size='25' style='width:200;text-align:right;'    value = "0.00" onBlur="setValue(this);" ></DIV></td>
							<td width='*%'></td>
						</tr>
						</table>
							
							<!--											
							<table border='0' align='center' width='100%' class='table'>
							<tr >
							<td width='20%' ><DIV id='DIV_TXT_DISCOUNT_TYPE'  class='div_input' >Discount Type</DIV></td>
							
							<td width='30%' ><select name='TXT_SLAB_TYPE' class='txt_input' style='width:60px' onchange="hideFlatDiscount();" disabled >
							<option value="SLAB" >Slabs</option>
							<option value="FLAT" SELECTED >Flat</option>
						</select>
							<select name='TXT_VALUE_TYPE' class='txt_input' style='width:70px' onchange="setVariableType();">
							<option value="F" SELECTED>Fixed</option>
							<option value="V"  >Variable</option>
						</select>
							<select name="DISCOUNT_TYPE" class="txt_input" style ='width:60px;' disabled onChange="setDiscount();">
							<OPTION value="AWPLR">AWPLR</option>
							<OPTION value="TBILL">TBILL</option>
							
						</select>
							<select name='TXT_VARIABLE_TYPE' class='txt_input' style='width:70px' onchange="setDiscount();" disabled>
							<option value="P" SELECTED >Premium</option>
							<option value="D"  >Discount</option>
						</select>
						</td>
							<td width='20%' ><DIV id='DIV_RESET_INTERVAL'  class='div_input' >Reset Interval</DIV></td>
							<td width='30%' ><select name="RESET_INTERVAL" class="txt_input"   onchange="" style='width:75px' disabled tabindex="12">
							<OPTION value="1">1 Week </option>
							<OPTION value="2">2 Week</option>
							<OPTION value="4">4 Week</option>
							
							<OPTION value="8">8 Week</option>
							<OPTION value="12">12 Week</option>
							<OPTION value="26">26 Week</option>
							<OPTION value="52">52 Week</option>
						</select>
							<input class="txt_input5" type="text" name="TXT_RESET_DD" maxlength="2" size="2"  value="10" tabindex="12" disabled onblur="checkMonthLength1(document.Form1.TXT_RESET_DD,document.Form1.TXT_RESET_MM,document.Form1.TXT_RESET_YY,'document.getElementById(reset_date)','D','N',m_sysdate,'no past')" > <input class="txt_input5" type="text" name="TXT_RESET_MM" maxlength="2" size="2" tabindex="12" value="10" disabled onblur="checkMonthLength1(document.Form1.TXT_RESET_DD,document.Form1.TXT_RESET_MM,document.Form1.TXT_RESET_YY,'document.getElementById(reset_date)','M','N',m_sysdate,'no past')" > <input class="txt_input5" type="text" name="TXT_RESET_YY" maxlength="4" size="4"  value="2011" disabled onblur="checkMonthLength1(document.Form1.TXT_RESET_DD,document.Form1.TXT_RESET_MM,document.Form1.TXT_RESET_YY,'document.getElementById(reset_date)','Y','N',m_sysdate,'no past')"  tabindex="12"> <input type="hidden" id="reset_date" />
						</td>
							<td width='*%'></td>
						</tr>
						</table>				
							-->
							
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr >
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_DISCOUNT_TYPE'  class='div_input' >Markup Type</DIV></td>
							
							<td width='40%' ><select name='TXT_SLAB_TYPE' class='txt_input' style='width:60px' onchange="hideFlatDiscount();" disabled >
							<option value="SLAB" >Slabs</option>
							<option value="FLAT" SELECTED >Flat</option>
						</select>
							<DIV style="display:none" ><select name='TXT_VALUE_TYPE' class='txt_input' style='width:70px' onchange="setVariableType();">
							<option value="F" SELECTED>Fixed</option>
							<!--<option value="V"  >Variable</option>-->
						</select>
							<select name="DISCOUNT_TYPE" class="txt_input" style ='width:60px;' disabled onChange="setDiscount();">
							<OPTION value="AWPLR">AWPLR</option>
							<OPTION value="TBILL">TBILL</option>
							
						</select>
							<select name='TXT_VARIABLE_TYPE' class='txt_input' style='width:70px' onchange="setDiscount();" disabled>
							<option value="P" SELECTED >Premium</option>
							<option value="D"  >Discount</option>
									</select></DIV>
						</td>
							<td width='20%'></td>
							<td width='20%'></td>						
							<td width='*%'></td>						
						</tr>
						</table>
							
							
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr >	
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_RESET_INTERVAL'  class='div_input' style="display:none" >Reset Interval</DIV></td>
							<td width='40%' ><DIV style="display:none" ><select name="RESET_INTERVAL" class="txt_input"   onchange="" style='width:75px' disabled tabindex="12">
							<OPTION value="1">1 Week </option>
							<OPTION value="2">2 Week</option>
							<OPTION value="4">4 Week</option>
							
							<OPTION value="8">8 Week</option>
							<OPTION value="12">12 Week</option>
							<OPTION value="26">26 Week</option>
							<OPTION value="52">52 Week</option>
						</select>
							<input class="txt_input5" type="text" name="TXT_RESET_DD" maxlength="2" size="2"  value="<%=m_system_date%>" tabindex="12" disabled onblur="checkMonthLength1(document.Form1.TXT_RESET_DD,document.Form1.TXT_RESET_MM,document.Form1.TXT_RESET_YY,'document.getElementById(reset_date)','D','N',m_sysdate,'no past')" > <input class="txt_input5" type="text" name="TXT_RESET_MM" maxlength="2" size="2" tabindex="12" value="<%=m_system_month%>" disabled onblur="checkMonthLength1(document.Form1.TXT_RESET_DD,document.Form1.TXT_RESET_MM,document.Form1.TXT_RESET_YY,'document.getElementById(reset_date)','M','N',m_sysdate,'no past')" > <input class="txt_input5" type="text" name="TXT_RESET_YY" maxlength="4" size="4"  value="<%=m_system_year%>" disabled onblur="checkMonthLength1(document.Form1.TXT_RESET_DD,document.Form1.TXT_RESET_MM,document.Form1.TXT_RESET_YY,'document.getElementById(reset_date)','Y','N',m_sysdate,'no past')"  tabindex="12"> <input type="hidden" id="reset_date" />
						<DIV> </td>
							<td width='20%'></td>
							<td width='20%'></td>						
							<td width='*%'></td>							
						</tr>
						</table>				
							
							
							
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr >
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_SLAB_TYPE'  class='div_input' >Markup Rate% *</DIV></td>
							<td width='30%' ><input class='txt_input' type='text' id='TXT_DISPLAY_INT_RATE' name='TXT_DISPLAY_INT_RATE' maxlength='25' size='25' style='width:75px;text-align:right;'  value='0.00'  onBlur="validateNumber(this, 0, 100, 2, 'number');" onchange="setVariableType();" >
							<input class='txt_input' type='text' name='TXT_INT_RATE' maxlength='25' size='25' style='width:75px;text-align:right;'  value='0.00'  disabled ></td>
							<td width='20%' ><DIV id='DIV_TXT_OVERPAID_DISCOUNT'  class='div_input' style="display:none"   >Overpaid Markup Rate% *</DIV></td>
							<td width='30%' ><DIV style="display:none"  ><input class='txt_input' type='text' id='TXT_DISPLAY_OVERPAID_RATE' name='TXT_DISPLAY_OVERPAID_RATE' maxlength='25' size='25' style='width:75px;text-align:right;'  value='0.00'  onBlur="validateNumber(this, 0, 100, 2, 'number');" onchange="setVariableType();" >
							<input class='txt_input' type='text' name='TXT_OVERPAID_RATE' maxlength='25' size='25' style='width:75px;text-align:right;'  value='0.00'  disabled ></td>
							<td width='*%'></DIV></td>
						</tr>
						</table>
							
							
							<table align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr>
							<td width='1%' ></td>
							<td width='100%'><DIV id='DIV_TXT_SLAB_DYNAMIC_HEAD'  class='div_input' ></DIV></td>
						</tr>
						</table>
							
							
							<table align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr>
							<td width='1%' ></td>
							<td width='100%'><DIV id='DIV_TXT_SLAB_DYNAMIC'  class='div_input' ></DIV></td>
						</tr>
						</table>
							
							
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr>
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_CHARGE_FREQUENCY'  class='div_input' >Markup Charge Frequency</DIV></td>
							<td width='30%' ><select name="TXT_CHARGE_FREQUENCY"  ID="TXT_CHARGE_FREQUENCY"  class="txt_input" style ='width:120px;' onChange="setDiscountChargeFrequency();">
							<!--<OPTION value="DIALY" >Daily </option>
							<OPTION value="WEEKLY">Weekly </option>
							<OPTION value="MONTHLY" SELECTED>Monthly</option>-->
							
						</select></td>
							<td width='20%' ><DIV id='DIV_TXT_CHARGE_FREQUENCY_WEEKLY'  class='div_input' >Markup Charge Day</DIV></td>
							<td width='30%' ><select name="TXT_CHARGE_FREQUENCY_WEEKLY" class="txt_input" style ='width:120px;' onChange="">
							<OPTION value="SUN">Sunday </option>
							<OPTION value="MON" SELECTED>Monday </option>
							<OPTION value="TUE">Tuesday </option>
							<OPTION value="WED">Wednesday </option>
							<OPTION value="THU">Thursday </option>
							<OPTION value="FRI">Friday </option>
							<OPTION value="SAT">Saturday </option>
							
						</select></td>
							<td width='*%'></td>
						</tr>
						</table>
							
							</table>
							
							
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr>
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_SETTL_FREQUENCY'  class='div_input' >Settlement Frequency</DIV></td>
							<td width='30%' ><select name="TXT_SETTL_FREQUENCY"  ID="TXT_SETTL_FREQUENCY"  class="txt_input" style ='width:120px;' onChange="">
							<!--<OPTION value="DIALY" >Daily </option>
							<OPTION value="WEEKLY">Weekly </option>
							<OPTION value="MONTHLY" SELECTED>Monthly</option>-->
							
						</select></td>
							<td width='20%' ></td>
							<td width='30%' ></td>
							<td width='*%'></td>
						</tr>
						</table>
				
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr>
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_SERVICE_CHARGE'  class='div_input' style="display:none"  >Service Charge</DIV></td>
							<td width='30%' ><input class='txt_input' type='text' name='TXT_SERVICE_CHARGE' maxlength='25' style="display:none;"  size='25'  style='width:200;text-align:right;'  value = "0.00" onBlur="validateNumber(this, 0, 100, 2, 'number');"></td>
							<td width='20%' ><DIV id='DIV_TXT_FACT_FEE'  class='div_input' style="display:none"  >Margin Trading Fee%</DIV></td>
							<td width='30%' ><input class='txt_input' type='text' name='TXT_FACT_FEE' maxlength='25' size='25'  style='width:200;text-align:right;display:none;'  value = "0.00" onBlur="validateNumber(this, 0, 100, 2, 'number');"   ></td>
							<td width='*%'></td>
						</tr>
						</table>
							
							
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr>
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_ESTIMATED_RETURN' style="display:none" class='div_input' >Estimated Return</DIV></td>
							<td width='30%' ><DIV id='DIV_TXT_ESTIMATED_RETURN' style="display:none" ><input class='txt_input' type='text' name='TXT_ESTIMATED_RETURN' maxlength='25' size='25'  style='width:200;text-align:right;'  value = "0.00" onBlur="validateNumber(this, 0, 9999999999999999.99, 2, 'number')">
							<input class='but_input' type='button' name='BUT_CAL'  style='width:70px;'    value = "Calculate" onClick="calculate();"></td></DIV>
							<td width='20%' ><DIV id='DIV_TXT_COST_ESTIMATED'  style="display:none" class='div_input' >Cost Estimation</DIV></td>
							<td width='30%' ><DIV id='DIV_TXT_COST_ESTIMATED_TEXT' style="display:none"> <input class='txt_input' type='text' name='TXT_COST_ESTIMATED' maxlength='25' size='25' style='width:200;text-align:right;'    value = "0.00" onBlur="validateNumber(this, 0, 9999999999999999.99, 2, 'number')"></td></DIV>
							<td width='*%'></td>
							
							
						</tr>
						</table>
							
							
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr >
							<td width='1%' ></td>
							
							<td width='20%' ><DIV id='DIV_TXT_AVAILABILITY'  class='div_input' style="display:none" >Availability *</DIV></td>
							<td width='40%' ><DIV style="display:none">On Banking<input type = 'checkbox' name = 'TXT_BANKING'   style = 'width:50px' onClick = 'change(this)' >
							On Realization<input type = 'checkbox' name = 'TXT_REALIZATION'   checked="yes" style = 'width:50px' onClick = 'change(this)' ></DIV></td>
							
							
							<td width='20%' ><DIV id='DIV_TXT_UNREALIZED_CHEQUES' style="display:none" >Retention of Unrealized Cheques *</DIV></td>
							<td width='20%' ><DIV id='DIV_TXT_UNREALIZED_CHEQUESTEXT' style="display:none" ><input class='txt_input' type='text' id='TXT_UNREALIZED_CHEQUE' name='TXT_UNREALIZED_CHEQUE' maxlength='25' size='25' style='width:200;text-align:right;'    value = "0.00" onBlur="validateNumber(this, 0, 100, 2, 'number');checkUnrealizedCheques()" disabled></DIV></td>
							
							<td width='*%'></td>
							
						</tr>
						</table>
							
							
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr >
							<td width='1%' ></td>
							<!-- <td width='20%' ><DIV id='DIV_TXT_RETENTION'  class='div_input' >Reserve Amount</DIV></td> -->
							<td width='20%' ><DIV id='DIV_TXT_RETENTION'  class='div_input' style="display:none"  >Retention</DIV></td>												
							<td width='30%' ><DIV style="display:none"  ><input class='txt_input' type='text' name='TXT_RETENTION' maxlength='25' size='25'  style='width:200;text-align:right;'  value = "0.00" onBlur="validateNumber(this, 0, 9999999999999999.99, 2, 'number')" ><DIV></td>
							
							<td width='20%' ><DIV id='DIV_TXT_DEBTOR_CONCENTRATION' style="display:none" class='div_input' >Debtor Concentration%</DIV></td>
							<td width='30%' ><DIV id='DIV_TXT_DEBTOR_CONCENTRATION_TEXT' style="display:none" style="display:none" ><input class='txt_input' type='text' name='TXT_DEBTOR_CONCENTRATION' maxlength='25' size='25'  style='width:200;text-align:right;'  value = "0.00" onBlur="validateNumber(this, 0, 100, 2, 'number')"></DIV></td>
							
							<td width='*%'></td>
						</tr>
						</table>
							
							
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr >
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_CURRENCY'  class='div_input' >Currency *</DIV></td>
							<td width='30%' ><select class = "txt_input" name="TXT_CURRENCY"><option value =RS >121</option><option value =AED >AED</option><option value =AFN >AFN</option><option value =ALL >ALL</option><option value =AMD >AMD</option><option value =AOA >AOA</option><option value =ARS >ARS</option><option value =AUD >AUD</option><option value =AWG >AWG</option><option value =AZN >AZN</option><option value =BAM >BAM</option><option value =BBD >BBD</option><option value =BDT >BDT</option><option value =BGN >BGN</option><option value =BH >BHAA</option><option value =BHD >BHD</option><option value =BIF >BIF</option><option value =BMD >BMD</option><option value =BZD >BZD</option><option value =CAD >CAD</option><option value =CDF >CDF</option><option value =CHE >CHE</option><option value =CHF >CHF</option><option value =CHW >CHW</option><option value =CLF >CLF</option><option value =CLP >CLP</option><option value =CNY >CNY</option><option value =COP >COP</option><option value =COU >COU</option><option value =CRC >CRC</option><option value =CUP >CUP</option><option value =CVE >CVE</option><option value =CYP >CYP</option><option value =ERN >CYP</option><option value =CZK >CZK</option><option value =DD >DD</option><option value =DJF >DJF</option><option value =DKK >DKK</option><option value =DOP >DOP</option><option value =DZD >DZD</option><option value =EEK >EEK</option><option value =EGP >EGP</option><option value =ETB >ETB</option><option value =EUR >EUR</option><option value =FJD >FJD</option><option value =FKP >FKP</option><option value =GBP >GBP</option><option value =GEL >GEL</option><option value =GNF >GNF</option><option value =GTQ >GTQ</option><option value =GWP >GWP</option><option value =GYD >GYD</option><option value =HKD >HKD</option><option value =HNL >HNL</option><option value =HRK >HRK</option><option value =HTG >HTG</option><option value =HUF >HUF</option><option value =IDR >IDR</option><option value =ILS >ILS</option><option value =INR >INR</option><option value =IQD >IQD</option><option value =IRR >IRR</option><option value =ISK >ISK</option><option value =JMD >JMD</option><option value =JOD >JOD</option><option value =JPY >JPY</option><option value =KES >KES</option><option value =KGS >KGS</option><option value =KHR >KHR</option><option value =KMF >KMF</option><option value =KPW >KPW</option><option value =KRW >KRW</option><option value =KWD >KWD</option><option value =KYD >KYD</option><option value =KZD >KZD</option><option value =LAK >LAK</option><option value =LBP >LBP</option><option value =LKR selected >LKR</option><option value =LRD >LRD</option><option value =LSL >LSL</option><option value =LTL >LTL</option><option value =LVL >LVL</option><option value =LYD >LYD</option><option value =MAD >MAD</option><option value =MDL >MDL</option><option value =MGA >MGA</option><option value =MKD >MKD</option><option value =MMK >MMK</option><option value =MNT >MNT</option><option value =MOP >MOP</option><option value =MRO >MRO</option><option value =MTL >MTL</option><option value =MUR >MUR</option><option value =MVR >MVR</option><option value =MVX >MVX</option><option value =MWK >MWK</option><option value =MXN >MXN</option><option value =MYR >MYR</option><option value =MZN >MZN</option><option value =NAD >NAD</option><option value =NGN >NGN</option><option value =NIO >NIO</option><option value =NOK >NOK</option><option value =NPR >NPR</option><option value =NZD >NZD</option><option value =OMR >OMR</option><option value =PAB >PAB</option><option value =PEN >PEN</option><option value =PGK >PGK</option><option value =PHP >PHP</option><option value =PKR >PKR</option><option value =PLN >PLN</option><option value =PYG >PYG</option><option value =QAR >QAR</option><option value =ROL >ROL</option><option value =RON >RON</option><option value =RSD >RSD</option><option value =RUB >RUB</option><option value =RWF >RWF</option><option value =SAR >SAR</option><option value =SBD >SBD</option><option value =SCR >SCR</option><option value =SDD >SDD</option><option value =SEK >SEK</option><option value =SGD >SGD</option><option value =SHP >SHP</option><option value =SIT >SIT</option><option value =SKK >SKK</option><option value =SLL >SLL</option><option value =SLR >SLR</option><option value =SOS >SOS</option><option value =SR >SR</option><option value =SRD >SRD</option><option value =STD >STD</option><option value =SVC >SVC</option><option value =SYP >SYP</option><option value =SZL >SZL</option><option value =T11 >T11</option><option value =THB >THB</option><option value =TJS >TJS</option><option value =TMM >TMM</option><option value =TND >TND</option><option value =TOP >TOP</option><option value =TRY >TRY</option><option value =TTD >TTD</option><option value =TWD >TWD</option><option value =TZS >TZS</option><option value =UAH >UAH</option><option value =UGX >UGX</option><option value =UK >UK</option><option value =USD >USD</option><option value =UYI >UYI</option><option value =UYU >UYU</option><option value =UZS >UZS</option><option value =VEB >VEB</option><option value =VND >VND</option><option value =VUV >VUV</option><option value =WST >WST</option><option value =XAF >XAF</option><option value =XAG >XAG</option><option value =XAU >XAU</option><option value =XBA >XBA</option><option value =XBB >XBB</option><option value =XBC >XBC</option><option value =XBD >XBD</option><option value =XCD >XCD</option><option value =XDR >XDR</option><option value =XFO >XFO</option><option value =XFU >XFU</option><option value =XOF >XOF</option><option value =XPD >XPD</option><option value =XPF >XPF</option><option value =XPT >XPT</option><option value =XXX >XXX</option><option value =YER >YER</option><option value =ZAR >ZAR</option><option value =ZMK >ZMK</option><option value =ZWD >ZWD</option></select></td>
							
							<td width='20%' ><DIV id='DIV_TXT_REFACT_TYPE' style="display:none" class='div_input' >Re-factoring Type</DIV></td>
							<td width='30%' ><DIV id='DIV_TXT_REFACT_TYPE_TEXT' style="display:none"> <select name="REFACTORING_TYPE" class="txt_input" style ='width:120px;' onChange="setRefactoringType();">
							<OPTION value="AUTO" SELECTED>Automatic </option>
							<OPTION value="MANUAL">Manual </option>
						</select>
						</DIV>														
						</td>
							<td width='*%'></td>
						</tr>
						</table>
							
							
							<table border='0' style="display:none" align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr >
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_AUTO_REASSIGN_TYPE' style="display:none" class='div_input' >Auto Reassign Type</DIV></td>
							<td width='30%' ><DIV id='DIV_TXT_AUTO_REASSIGN_TYPE_TEXT' style="display:none" ><select name="TXT_AUTO_REASSIGN_TYPE" class="txt_input" style ='width:120px;' onChange="setValidationType()">
							<OPTION value="PRECENTAGE" SELECTED>Percentage</option>
							
							<OPTION value="AMOUNT">Amount</option>
						</select></DIV>
						</td>
							<td width='20%' ><DIV id='DIV_TXT_AUTO_REASSIGN_VALUE' style="display:none"  class='div_input' >Auto Reassign Value</DIV></td>
							<td width='30%' ><DIV id='DIV_TXT_AUTO_REASSIGN_VALUE_TEXT' style="display:none" > <input class='txt_input' type='text' name='TXT_AUTO_REASSIGN_VALUE' maxlength='25' size='25' style='width:200;text-align:right;'    value = "0.00" onBlur="setValidationType()"></td></DIV>
							<td width='*%'></td>
						</tr>
						</table>
							
							
							<table border='0' style="display:none" align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr >
							<td width='1%' ></td>		
							<td width='20%' ><DIV id='DIV_TXT_MAX_DEBTOR_LIMIT' style="display:none"  class='div_input' >Maximum Debtor Limit</DIV></td>
							<td width='30%' ><DIV id='DIV_TXT_MAX_DEBTOR_LIMIT_TEXT' style="display:none" ><input class='txt_input' type='text' name='TXT_MAX_DEBTOR_LIMIT' maxlength='25' size='25' style='width:200;text-align:right;'    value = "0.00" onBlur="validateNumber(this, 0, 9999999999999999.99, 2, 'number')"></td></DIV>						
							
							<td width='20%' ><DIV id='DIV_TXT_RANDOM_DISAPP_PER' style="display:none" class='div_input' >Random Disapproval %</DIV></td>
							<td width='30%' ><DIV id='DIV_TXT_RANDOM_DISAPP_PER_TEXT' style="display:none"> <input class='txt_input' type='text' name='TXT_RANDOM_DISAPP_PER' maxlength='25' size='25' style='width:200;text-align:right;'    value = "0.00" onBlur="validateNumber(this, 0, 100, 2, 'number')"></DIV></td>
							
							<td width='*%'></td>
						</tr>
						</table>
							
							
							<table border='0' style="display:none" align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr >
							<td width='1%' ></td>					
							<td width='20%' ><DIV id='DIV_TXT_MAX_INVOICE_VALUE'  style="display:none"  class='div_input' >Maximum Invoice Value</DIV></td>
							<td width='30%' ><DIV id='DIV_TXT_MAX_INVOICE_VALUE_TEXT' style="display:none" > <input class='txt_input' type='text' name='TXT_MAX_INVOICE_VALUE' maxlength='25' size='25' style='width:200;text-align:right;'    value = "0.00" onBlur="validateNumber(this, 0, 9999999999999999.99, 2, 'number')"></td></DIV>						
							
							<td width='20%' ><DIV id='DIV_TXT_MIN_INVOICE_VALUE' style="display:none"  class='div_input' >Minimum Invoice Value</DIV></td>
							<td width='30%' ><DIV id='DIV_TXT_MIN_INVOICE_VALUE_TEXT' style="display:none" ><input class='txt_input' type='text' name='TXT_MIN_INVOICE_VALUE' maxlength='25' size='25' style='width:200;text-align:right;'    value = "0.00" onBlur="validateNumber(this, 0, 9999999999999999.99, 2, 'number')"></DIV></td>
							
							<td width='*%'></td>
						</tr>
						</table>
							
							
							<table border='0' style="display:none" align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr >
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_AVG_DEBTOR_LIMIT' style="display:none"  class='div_input' >Average Debtor Limit</DIV></td>
							
							<td width='30%' ><DIV id='DIV_TXT_AVG_DEBTOR_LIMIT_TEXT' style="display:none" ><input class='txt_input' type='text' name='TXT_AVG_DEBTOR_LIMIT' maxlength='25' size='25' style='width:200;text-align:right;'    value = "0.00" onBlur="validateNumber(this, 0, 9999999999999999.99, 2, 'number')"></DIV></td>
							<td width='*%'></td>
						</tr >
						</table>
							
							
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr >
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_LOCATION_CODE'  class='div_input' >Location Code *</DIV></td>
							<td width='30%' ><input class='txt_input' type='text' name='TXT_LOCATION_CODE' maxlength='3' size='10' onblur="">
							<input class='but_input' type='button' name='BUT_HELP_MAIN_2' value="..." onClick="help_loc_code(0);"></td>
							
							<td width='20%' ><DIV id='DIV_TXT_COLLECTION' style="display:none" class='div_input' >Collection by</DIV></td>
							<td width='30%' ><DIV id='DIV_TXT_COLLECTION_TEXT' style="display:none"> Client<input type = 'checkbox' name = 'TXT_COLL_CLIENT'   style = 'width:50px' onClick = 'collectionchange(this)' >
							Company<input type = 'checkbox' name = 'TXT_COLL_COMPANY'    style = 'width:50px' onClick = 'collectionchange(this)' ></DIV>
						</td>
							
							<td width='*%'></td>
						</tr>
						</table>
							
							
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr >
							<td width='1%' ></td>
							<td width="20%"><DIV id="DIV_TXT_CLIENT_START_DATE"  class='div_input' >Facility Start Date</DIV></td>
							<td width="30%"><input class="txt_input5" type="text" name="TXT_START_DD" maxlength="2" size="2" value=<%=m_system_date%> onblur = "checkMonthLength1(document.Form1.elements['TXT_START_DD'], document.Form1.elements['TXT_START_MM'], document.Form1.elements['TXT_START_YY'], document.Form1.elements['FACILITY_DATE'], 'D', 'N', m_sysdate, 'no future'); checkTwoDates(document.Form1.elements['TXT_START_DD'], document.Form1.elements['TXT_START_MM'], document.Form1.elements['TXT_START_YY'],  document.Form1.elements['FACILITY_DATE'], document.Form1.elements['TXT_REVIEW_DD'], document.Form1.elements['TXT_REVIEW_MM'], document.Form1.elements['TXT_REVIEW_YY'], document.Form1.elements['REVIEW_DATE'], 1, this, 'D', '<=', 'Facility Start Date' , 'Review Date');" />
							<input class="txt_input5" type="text" name="TXT_START_MM" maxlength="2" size="2" value=<%=m_system_month%> onblur = "checkMonthLength1(document.Form1.elements['TXT_START_DD'], document.Form1.elements['TXT_START_MM'], document.Form1.elements['TXT_START_YY'], document.Form1.elements['FACILITY_DATE'], 'M', 'N', m_sysdate, 'no future'); checkTwoDates(document.Form1.elements['TXT_START_DD'], document.Form1.elements['TXT_START_MM'], document.Form1.elements['TXT_START_YY'],  document.Form1.elements['FACILITY_DATE'], document.Form1.elements['TXT_REVIEW_DD'], document.Form1.elements['TXT_REVIEW_MM'], document.Form1.elements['TXT_REVIEW_YY'], document.Form1.elements['REVIEW_DATE'], 1, this, 'M', '<=', 'Facility Start Date' , 'Review Date');" />
							<input class="txt_input5" type="text" name="TXT_START_YY" maxlength="4" size="4" value=<%=m_system_year%> onblur = "checkMonthLength1(document.Form1.elements['TXT_START_DD'], document.Form1.elements['TXT_START_MM'], document.Form1.elements['TXT_START_YY'], document.Form1.elements['FACILITY_DATE'], 'Y', 'N', m_sysdate, 'no future'); checkTwoDates(document.Form1.elements['TXT_START_DD'], document.Form1.elements['TXT_START_MM'], document.Form1.elements['TXT_START_YY'],  document.Form1.elements['FACILITY_DATE'], document.Form1.elements['TXT_REVIEW_DD'], document.Form1.elements['TXT_REVIEW_MM'], document.Form1.elements['TXT_REVIEW_YY'], document.Form1.elements['REVIEW_DATE'], 1, this, 'Y', '<=', 'Facility Start Date' , 'Review Date');" />
							<input type="hidden" name="FACILITY_DATE" id="FACILITY_DATE" value=<%=sysdate%> /></td>
							<td width="20%"><DIV id="DIV_TXT_CLIENT_END_DATE"  class='div_input' >Review Date</DIV></td>
							<td width="30%"><input class="txt_input5" type="text" name="TXT_REVIEW_DD" maxlength="2" size="2" value=<%=m_system_date%> onblur = "checkMonthLength1(document.Form1.elements['TXT_REVIEW_DD'], document.Form1.elements['TXT_REVIEW_MM'], document.Form1.elements['TXT_REVIEW_YY'], document.Form1.elements['REVIEW_DATE'], 'D', 'N', m_sysdate, 'no past'); checkTwoDates(document.Form1.elements['TXT_START_DD'], document.Form1.elements['TXT_START_MM'], document.Form1.elements['TXT_START_YY'],  document.Form1.elements['FACILITY_DATE'], document.Form1.elements['TXT_REVIEW_DD'], document.Form1.elements['TXT_REVIEW_MM'], document.Form1.elements['TXT_REVIEW_YY'], document.Form1.elements['REVIEW_DATE'], 2, this, 'D', '<=', 'Facility Start Date' , 'Review Date');">
							<input class="txt_input5" type="text" name="TXT_REVIEW_MM" maxlength="2" size="2" value=<%=m_system_month%> onblur = "checkMonthLength1(document.Form1.elements['TXT_REVIEW_DD'], document.Form1.elements['TXT_REVIEW_MM'], document.Form1.elements['TXT_REVIEW_YY'], document.Form1.elements['REVIEW_DATE'], 'M', 'N', m_sysdate, 'no past'); checkTwoDates(document.Form1.elements['TXT_START_DD'], document.Form1.elements['TXT_START_MM'], document.Form1.elements['TXT_START_YY'],  document.Form1.elements['FACILITY_DATE'], document.Form1.elements['TXT_REVIEW_DD'], document.Form1.elements['TXT_REVIEW_MM'], document.Form1.elements['TXT_REVIEW_YY'], document.Form1.elements['REVIEW_DATE'], 2, this, 'M', '<=', 'Facility Start Date' , 'Review Date');">
							<input class="txt_input5" type="text" name="TXT_REVIEW_YY" maxlength="4" size="4" value=<%=m_system_year%> onblur = "checkMonthLength1(document.Form1.elements['TXT_REVIEW_DD'], document.Form1.elements['TXT_REVIEW_MM'], document.Form1.elements['TXT_REVIEW_YY'], document.Form1.elements['REVIEW_DATE'], 'Y', 'N', m_sysdate, 'no past'); checkTwoDates(document.Form1.elements['TXT_START_DD'], document.Form1.elements['TXT_START_MM'], document.Form1.elements['TXT_START_YY'],  document.Form1.elements['FACILITY_DATE'], document.Form1.elements['TXT_REVIEW_DD'], document.Form1.elements['TXT_REVIEW_MM'], document.Form1.elements['TXT_REVIEW_YY'], document.Form1.elements['REVIEW_DATE'], 2, this, 'Y', '<=', 'Facility Start Date' , 'Review Date');">
							<input type="hidden" name="REVIEW_DATE" id="REVIEW_DATE"  value=<%=sysdate%> /></td>
							
							<td width='*%'></td>
						</tr>
						</table>
							
							
							
							
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr >
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_APP_RECEIVE'  class='div_input' >Date Application Received</DIV></td>
							<td width='30%'><input class = "txt_input5" type = "text" name = "TXT_APP_RECE_DD" maxlength = "2" size = "2" value=<%=m_system_date%> onblur = "checkMonthLength1(document.Form1.elements['TXT_APP_RECE_DD'], document.Form1.elements['TXT_APP_RECE_MM'], document.Form1.elements['TXT_APP_RECE_YY'], document.Form1.elements['APP_DATE'], 'D', 'N', m_sysdate, 'no future'); checkTwoDates(document.Form1.elements['TXT_APP_RECE_DD'], document.Form1.elements['TXT_APP_RECE_MM'], document.Form1.elements['TXT_APP_RECE_YY'],  document.Form1.elements['APP_DATE'], document.Form1.elements['TXT_INSPEC_DD'], document.Form1.elements['TXT_INSPEC_MM'], document.Form1.elements['TXT_INSPEC_YY'], document.Form1.elements['INSPECT_DATE'], 1, this, 'D', '<=', 'Date Application Received' , 'Date of Inspection');"> 
							<input class = "txt_input5" type = "text" name = "TXT_APP_RECE_MM" maxlength = "2" size = "2" value=<%=m_system_month%> onblur = "checkMonthLength1(document.Form1.elements['TXT_APP_RECE_DD'], document.Form1.elements['TXT_APP_RECE_MM'], document.Form1.elements['TXT_APP_RECE_YY'], document.Form1.elements['APP_DATE'], 'M', 'N', m_sysdate, 'no future'); checkTwoDates(document.Form1.elements['TXT_APP_RECE_DD'], document.Form1.elements['TXT_APP_RECE_MM'], document.Form1.elements['TXT_APP_RECE_YY'],  document.Form1.elements['APP_DATE'], document.Form1.elements['TXT_INSPEC_DD'], document.Form1.elements['TXT_INSPEC_MM'], document.Form1.elements['TXT_INSPEC_YY'], document.Form1.elements['INSPECT_DATE'], 1, this, 'M', '<=', 'Date Application Received' , 'Date of Inspection');"> 
							<input class = "txt_input5" type = "text" name = "TXT_APP_RECE_YY" maxlength = "4" size = "4" value=<%=m_system_year%> onblur = "checkMonthLength1(document.Form1.elements['TXT_APP_RECE_DD'], document.Form1.elements['TXT_APP_RECE_MM'], document.Form1.elements['TXT_APP_RECE_YY'], document.Form1.elements['APP_DATE'], 'Y', 'N', m_sysdate, 'no future'); checkTwoDates(document.Form1.elements['TXT_APP_RECE_DD'], document.Form1.elements['TXT_APP_RECE_MM'], document.Form1.elements['TXT_APP_RECE_YY'],  document.Form1.elements['APP_DATE'], document.Form1.elements['TXT_INSPEC_DD'], document.Form1.elements['TXT_INSPEC_MM'], document.Form1.elements['TXT_INSPEC_YY'], document.Form1.elements['INSPECT_DATE'], 1, this, 'Y', '<=', 'Date Application Received' , 'Date of Inspection');"> 
							<input type="hidden" name="APP_DATE" id="APP_DATE" value=<%=sysdate%> /></td>
							<td width='20%' ><DIV id='DIV_TXT_INSPEC'  class='div_input' >Date of Inspection</DIV></td>
							<td width='30%'><input class = "txt_input5" type = "text" name = "TXT_INSPEC_DD" maxlength = "2" size = "2" value=<%=m_system_date%> onblur = "checkMonthLength1(document.Form1.elements['TXT_INSPEC_DD'], document.Form1.elements['TXT_INSPEC_MM'], document.Form1.elements['TXT_INSPEC_YY'], document.Form1.elements['INSPECT_DATE'], 'D', 'N', m_sysdate, 'no future'); checkTwoDates(document.Form1.elements['TXT_APP_RECE_DD'], document.Form1.elements['TXT_APP_RECE_MM'], document.Form1.elements['TXT_APP_RECE_YY'],  document.Form1.elements['APP_DATE'], document.Form1.elements['TXT_INSPEC_DD'], document.Form1.elements['TXT_INSPEC_MM'], document.Form1.elements['TXT_INSPEC_YY'], document.Form1.elements['INSPECT_DATE'], 2, this, 'D', '<=', 'Date Application Received' , 'Date of Inspection'); checkTwoDates(document.Form1.elements['TXT_INFO_COM_DD'], document.Form1.elements['TXT_INFO_COM_MM'], document.Form1.elements['TXT_INFO_COM_YY'], document.Form1.elements['INSPECT_DATE'], document.Form1.elements['TXT_APP_RECE_DD'], document.Form1.elements['TXT_APP_RECE_MM'], document.Form1.elements['TXT_APP_RECE_YY'],  document.Form1.elements['INFO_COMPLETE_DATE'], 1, this, 'D', '<=', 'Date of Inspection' , 'Date Information Completed');"> 
							<input class = "txt_input5" type = "text" name = "TXT_INSPEC_MM" maxlength = "2" size = "2"  value=<%=m_system_month%> onblur = "checkMonthLength1(document.Form1.elements['TXT_INSPEC_DD'], document.Form1.elements['TXT_INSPEC_MM'], document.Form1.elements['TXT_INSPEC_YY'], document.Form1.elements['INSPECT_DATE'], 'M', 'N', m_sysdate, 'no future'); checkTwoDates(document.Form1.elements['TXT_APP_RECE_DD'], document.Form1.elements['TXT_APP_RECE_MM'], document.Form1.elements['TXT_APP_RECE_YY'],  document.Form1.elements['APP_DATE'], document.Form1.elements['TXT_INSPEC_DD'], document.Form1.elements['TXT_INSPEC_MM'], document.Form1.elements['TXT_INSPEC_YY'], document.Form1.elements['INSPECT_DATE'], 2, this, 'M', '<=', 'Date Application Received' , 'Date of Inspection'); checkTwoDates(document.Form1.elements['TXT_INFO_COM_DD'], document.Form1.elements['TXT_INFO_COM_MM'], document.Form1.elements['TXT_INFO_COM_YY'], document.Form1.elements['INSPECT_DATE'], document.Form1.elements['TXT_APP_RECE_DD'], document.Form1.elements['TXT_APP_RECE_MM'], document.Form1.elements['TXT_APP_RECE_YY'],  document.Form1.elements['INFO_COMPLETE_DATE'], 1, this, 'M', '<=', 'Date of Inspection' , 'Date Information Completed');"> 
							<input class = "txt_input5" type = "text" name = "TXT_INSPEC_YY" maxlength = "4" size = "4" value=<%=m_system_year%> onblur = "checkMonthLength1(document.Form1.elements['TXT_INSPEC_DD'], document.Form1.elements['TXT_INSPEC_MM'], document.Form1.elements['TXT_INSPEC_YY'], document.Form1.elements['INSPECT_DATE'], 'Y', 'N', m_sysdate, 'no future'); checkTwoDates(document.Form1.elements['TXT_APP_RECE_DD'], document.Form1.elements['TXT_APP_RECE_MM'], document.Form1.elements['TXT_APP_RECE_YY'],  document.Form1.elements['APP_DATE'], document.Form1.elements['TXT_INSPEC_DD'], document.Form1.elements['TXT_INSPEC_MM'], document.Form1.elements['TXT_INSPEC_YY'], document.Form1.elements['INSPECT_DATE'], 2, this, 'Y', '<=', 'Date Application Received' , 'Date of Inspection'); checkTwoDates(document.Form1.elements['TXT_INFO_COM_DD'], document.Form1.elements['TXT_INFO_COM_MM'], document.Form1.elements['TXT_INFO_COM_YY'], document.Form1.elements['INSPECT_DATE'], document.Form1.elements['TXT_APP_RECE_DD'], document.Form1.elements['TXT_APP_RECE_MM'], document.Form1.elements['TXT_APP_RECE_YY'],  document.Form1.elements['INFO_COMPLETE_DATE'], 1, this, 'Y', '<=', 'Date of Inspection' , 'Date Information Completed');"> 
							
							<input type="hidden" name="INSPECT_DATE" id="INSPECT_DATE" value=<%=sysdate%> /></td>
							<td width='*%'></td>
						</tr>
						</table>
							
							
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr >
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_COMMENTS'  class='div_input' >Comments</DIV></td>
							<td width='30%' ><TEXTAREA class="txt_input" name="TXT_COMMENTS" style="width:200px;height:50px"  cols="60"  rows ="4" onKeyPress = "return imposeMaxLength(this, 4000);" onBlur = "strTrim(this, null, null, 'COMMENT'); limitText(this, document.Form1.TXT_COMMENTS_COUNT, 4000);" onKeyUp = "limitText(this, document.Form1.TXT_COMMENTS_COUNT, 4000);" onKeyDown = "limitText(this, document.Form1.TXT_COMMENTS_COUNT, 4000);"></TEXTAREA> <BR /> (Maximum characters: 4000) <input class = "txt_input5" type = "text" size = "3" value = "4000" name = "TXT_COMMENTS_COUNT" disabled = "disabled" /> </td>
							<td width='20%' valign='top'><DIV id='DIV_TXT_INFO_COMPLETE'  class='div_input' >Date Information Completed</DIV></td>
							<td width='30%' valign='top'><input class = "txt_input5" type = "text" name = "TXT_INFO_COM_DD" maxlength = "2" size = "2" value=<%=m_system_date%> onblur = "checkMonthLength1(document.Form1.elements['TXT_INFO_COM_DD'], document.Form1.elements['TXT_INFO_COM_MM'], document.Form1.elements['TXT_INFO_COM_YY'], document.Form1.elements['INFO_COMPLETE_DATE'], 'D', 'N', m_sysdate, 'no future'); checkTwoDates(document.Form1.elements['TXT_INFO_COM_DD'], document.Form1.elements['TXT_INFO_COM_MM'], document.Form1.elements['TXT_INFO_COM_YY'], document.Form1.elements['INSPECT_DATE'], document.Form1.elements['TXT_APP_RECE_DD'], document.Form1.elements['TXT_APP_RECE_MM'], document.Form1.elements['TXT_APP_RECE_YY'],  document.Form1.elements['INFO_COMPLETE_DATE'], 2, this, 'D', '<=', 'Date of Inspection' , 'Date Information Completed');"> 
							
							<input class = "txt_input5" type = "text" name = "TXT_INFO_COM_MM" maxlength = "2" size = "2" value=<%=m_system_month%> onblur = "checkMonthLength1(document.Form1.elements['TXT_INFO_COM_DD'], document.Form1.elements['TXT_INFO_COM_MM'], document.Form1.elements['TXT_INFO_COM_YY'], document.Form1.elements['INFO_COMPLETE_DATE'], 'M', 'N', m_sysdate, 'no future'); checkTwoDates(document.Form1.elements['TXT_INFO_COM_DD'], document.Form1.elements['TXT_INFO_COM_MM'], document.Form1.elements['TXT_INFO_COM_YY'], document.Form1.elements['INSPECT_DATE'], document.Form1.elements['TXT_APP_RECE_DD'], document.Form1.elements['TXT_APP_RECE_MM'], document.Form1.elements['TXT_APP_RECE_YY'],  document.Form1.elements['INFO_COMPLETE_DATE'], 2, this, 'M', '<=', 'Date of Inspection' , 'Date Information Completed');"> 
							<input class = "txt_input5" type = "text" name = "TXT_INFO_COM_YY" maxlength = "4" size = "4" value=<%=m_system_year%> onblur = "checkMonthLength1(document.Form1.elements['TXT_INFO_COM_DD'], document.Form1.elements['TXT_INFO_COM_MM'], document.Form1.elements['TXT_INFO_COM_YY'], document.Form1.elements['INFO_COMPLETE_DATE'], 'Y', 'N', m_sysdate, 'no future'); checkTwoDates(document.Form1.elements['TXT_INFO_COM_DD'], document.Form1.elements['TXT_INFO_COM_MM'], document.Form1.elements['TXT_INFO_COM_YY'], document.Form1.elements['INSPECT_DATE'], document.Form1.elements['TXT_APP_RECE_DD'], document.Form1.elements['TXT_APP_RECE_MM'], document.Form1.elements['TXT_APP_RECE_YY'],  document.Form1.elements['INFO_COMPLETE_DATE'], 2, this, 'Y', '<=', 'Date of Inspection' , 'Date Information Completed');"> 
							<input type="hidden" name="INFO_COMPLETE_DATE" id="INFO_COMPLETE_DATE" value=<%=sysdate%> /></td>
							<td width='*%'></td>
						</tr>
						</table>
							
							<!-- 											
							<br>
							<table border='0' align='center' width='100%' class='table'>
							<tr>
							<td width = "20%"><div id = "DIV_BUT_BENEFICIARY_DETAILS_LABEL" class = "div_input">Beneficiary Details</div></td>
							<td width = "30%"><div id = "DIV_BUT_BENEFICIARY_DETAILS" class = "div_input">
							<input class = "but_input" type = "button" name = "BUT_BENEFICIARY_DETAILS" value = "Beneficiary Details" style="width: 150px;" onClick = "addBeneficiaryDetails();" />
							
						</div></td>
							<td width = "20%"><div id = "DIV_BUT_STANDING_ORDER_DETAILS_LABEL" style="visibility:hidden" class = "div_input">Standing Orders</div></td>
							<td width = "30%"><div id = "DIV_BUT_STANDING_ORDER_DETAILS" style="visibility:hidden" class = "div_input">
							<input class = "but_input" type = "button" name = "BUT_STANDING_ORDER_DETAILS" value = "Standing Orders" style="width: 150px;" onClick = "addStandingOrderDetails();" />
						</div></td>
							<td width = "*%"></td>
						</tr>
						</table>
							
							
							<br>
							
							<table border='0' align='center' width='100%' class='table'>
							<tr>
							<td width = "20%"><div id = "DIV_LABLE_SIGNATURE_UPLOAD" class = "div_input">Authorized Signatory</div></td>
							<td width = "30%"><div id = "DIV_BUT_SIGNATURE_UPLOAD" class = "div_input">
							<input class = "but_input" type = "button" name = "BUT_SIGNATURE_UPLOAD" value = "Signature Upload" style="width: 150px;" onClick = "signatureUpload();" />
						</div></td>
							<td width = "20%"><div id = "DIV_APPROVAL_SHEET_UPLOAD" style="visibility:hidden" class = "div_input">Approval Sheet </div></td>
							<td width = "30%"><div id = "DIV_BUT_APPROVAL_SHAEET_UPLOAD" style="visibility:hidden" class = "div_input">
							
							<input class = "but_input" type = "button" name = "BUT_APPROVAL_SHAEET_UPLOAD" value = "Approval Sheet" style="width: 150px;"  onClick = "print_facility_app();" />
						</div></td>
							<td width = "*%"></td>
						</tr>
						</table>
							
							-->
							
							
							<br>
							<!-- commented below by udara on 24-02-2012 -->
							<!--
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr >
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_PRODUCT_CODE'  class='div_input' >Product Package Code *</DIV></td>
							<td width='30%' ><input class='txt_input' type='text' name='TXT_PRODUCT_CODE' maxlength='10' size='10' onblur="" >
							<input class='but_input' type='button' name='BUT_HELP_MAIN' value="..." onClick="product_code_help(0);"></td>
							
							<td width='20%' ><DIV id='DIV_TXT_PRODUCT_DESC'  class='div_input' >Product Package Description </DIV></td>
							<td width='30%' ><input class='txt_input' type='text' name='TXT_PRODUCT_DESC' maxlength='50' size='50' style='width:200px' disabled></td>
							<td width='*%'></td>
						    </tr>
						    </table>
							
							
							
							<table align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr>
							<td width='1%' ></td>
							<td width='100%'><DIV id='product_detail_data'  class='div_input' ></DIV></td>
							</tr>
							</table>
							
							
							<table id="product_data"></table>
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr>
							<td width='1%' ></td>
							<td width='20%' ><DIV id='DIV_TXT_FEE_CODE'  class='div_input' >Fee Package Code *</DIV></td>
							<td width='30%' ><input class='txt_input' type='text' name='TXT_FEE_CODE' maxlength='10' size='10' onblur="" >
							
							<input class='but_input' type='button' name='BUT_HELP_MAIN' value="..." onClick="fee_code_help(0);"></td>
							<td width='20%' ><DIV id='DIV_TXT_FEE_DESC'  class='div_input' >Fee Package Description </DIV></td>
							<td width='30%' ><input class='txt_input' type='text' name='TXT_FEE_DESC' maxlength='50' size='50' style='width:200px' disabled></td>
							<td width='*%'></td>
							</tr>
							</table>
							
							
							<table align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr>
							<td width='1%' ></td>
							<td width='100%'><DIV id='fee_detail_data'  class='div_input' ></DIV></td>
							</tr>
							</table>
							
							
							<table id="fee_data"></table>
							-->
							<!-- commented above by udara on 24-02-2012 -->
					
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr>
							<td width='1%' ></td>
							<td width='20%' >Other</td>
							
							<td>
							<input width='40%' type = "hidden" name = "TXT_S05_TYPE_COMMENT_9" value = "OTHER" />  
							<TEXTAREA class = "txt_input"  name = "TXT_S05_OTHER_COMMENT_9" cols="60"  rows ="4" style = "width: 200px;height:50px;text-align: left;" onBlur = "strTrim(this, null, null, 'COMMENT'); limitText(this, document.Form1.TXT_COMMENTS_COUNT2, 4000);" onKeyUp = "limitText(this, document.Form1.TXT_COMMENTS_COUNT2, 4000);" onKeyDown = "limitText(this, document.Form1.TXT_COMMENTS_COUNT2, 4000);" ></TEXTAREA> <BR /> (Maximum characters: 4000) <input class = "txt_input5" type = "text" size = "3" value = "4000" name = "TXT_COMMENTS_COUNT2" disabled = "disabled"> 
						</td> 
							<td width='20%'> &nbsp; </td>
							<td width='20%'> &nbsp; </td>
							<td width='*%'></td>						
							
						</tr> 
						</table>
							
							
							<br>
							<table align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr>
							<td class = "div_input" align = "left" colspan ="4"><b><u> <DIV style="display:none" id='DIV_GUARANTEE_LABEL_DIV'> Guarantee</DIV></u></b></td> 
						</tr> 
						</table>
							
							<table align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr>
							<td width='1%' ></td>
							<td width='100%'><DIV style="display:none" id='DIV_THIRD_PARTY_GUARANTORS_DETAILS'  class='div_input' ></DIV></td>
						</tr>
						</table>
							
							
							<br>
							<table align='center' width='100%' class='table' cellpadding='1' cellspacing='0' style="display:none" >
							<tr>
							<td width='1%' ></td>
							<td width='30%'  class="div_input"><u><b>Invoice Supporting Documents</b></u></td>
							<td width='*%'></td>						
						</tr>
						</table>
							
							
							<table align='center' width='100%' class='table' cellpadding='1' cellspacing='0' style="display:none">
							<tr>
							<td width='1%' ></td>
							<td width='100%'><DIV id='sup_doc_detail_data'  class='div_input' ></DIV></td>
							<td width='*%'></td>						
						</tr>
						</table>
							
							<br />
							<table align='center' width='100%' class='table' cellpadding='1' cellspacing='0' style="display:none">
							<tr>
							<td width='1%' ></td>
							<td width='20%'  class="div_input"><u><b>Document Check List</b></u></td>
							<td width='*%'></td>						
						</tr>
						</table>
							
							<table align='center' width='100%' class='table' cellpadding='1' cellspacing='0' style="display:none">
							<tr>
							<td width='1%' ></td>
							<td width='100%'><DIV id='doc_detail_data'  class='div_input' ></DIV></td>
							<td width='*%'></td>						
						</tr>
						</table>
							
							<br/>
							<!--					
							<table align='center' width='100%' class='table'>
							<tr>
							<td width='20%'  class="div_input"><u><b>Reports to be Sent</b></u></td>
						</tr>
						</table>
							
							<table border='0' align='center' width='100%' class='table'>
							<tr >
							<td width='20%' ><DIV id='DIV_TXT_RPT_SENT'  class='div_input' >Report Code</DIV></td>
							<td width='40%' ><input class="txt_input" type="text" name="TXT_RPT_SENT" maxlength="10" size="10"  style="width:175px" onblur="">
							<input class="but_input" type="button" name="BUT_RPT_SENT_HELP" value="..." onClick=""></td>
							<td width='20%' ></td>
							<td width='20%' ></td>
							<td width='*%'></td>
						</tr>
						</table>
							
							<br>
							-->					
							<table align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr>
							<td width='1%' ></td>
							
							<td width='100%'><DIV id='client_reports'  class='div_input' ></DIV></td>
						</tr>
						</table>
							
							
							<br>
							<table align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr>
							<td width='1%' ></td>
							<td width='20%'  class="div_input"><DIV id='DIV_TXT_SECURITY_CODE_LABLE'  ><u><b>Security</b></u></DIV></td>
							<td width='*%' ></td>
						</tr>
						</table>
							
							
							<table border='0' align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr >
							<td width='1%' ></td>
							
							<td width='20%' ><DIV id='DIV_TXT_SECURITY_CODE'   class='div_input' >Security Code</DIV></td>
							<td width='40%' ><DIV id='DIV_TXT_SECURITY_CODE_OBJECTS_DIV' ><input class="txt_input" type="text" name="TXT_SECURITY_CODE" maxlength="10" size="10"  style="width:175px" onblur="">
							<input class="but_input" type="button" name="BUT_SECURITY_HELP" value="..." onClick="">
						</DIV></td>
							
							<td width='20%' ></td>
							<td width='20%' ></td>
							<td width='*%'></td>
						</tr>
						</table>
							
							
							<table align='center' width='100%' class='table' cellpadding='1' cellspacing='0'>
							<tr>
							<td width='1%' ></td>
							
							<td width='100%'><DIV id='security_setup'  class='div_input' ></DIV></td>
						</tr>
						</table>	
							
							<div id = "DIV_APP_SHEET" title = "Margin Trading Facility Details">
							<iframe id = "IFRAME_APP_SHEET" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Factoring Facility Details">
						</iframe>
						</div>
							<div id = "DIV_CLIENT_DRILL" title = "Client Information">
							<iframe id = "IFRAME_CLIENT_DRILL" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Client Information">
						</iframe>
						</div>
							<div id = "DIV_LOG" title = "Details">
							<iframe id = "IFRAME_LOG" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Details">
							
						</iframe>
						</div>
							
							
							<hr>				
							
							
							
							<!-- End Body Objects -->					
							
							<table class='table' cellpadding='2' cellspacing='2' border='0'> 
							<tr>
							<td width='5%' align='center'><input type="button" class='mainbut'  onclick='load_screen_status("NEW");' value="New"></td>
							<td width='5%' align='center'><input type="button" class='mainbut'  onClick='edit_data();' value="Edit"></td>												
							<td width='5%' align='center'><input type="button" class='mainbut'  onClick='save_window();' value="Save"></td>
							<td width='5%' align='center'><input type="button" class='mainbut'  onclick="top.frames[1].location.href=top.frames[1].location.href;" value="Cancel"></td>
							<td width='5%' align='center'><input type="button" class='mainbut'  onclick='show_log_drill();' value="View Log"></td>
							
							<td width='*%'></td>												
							<!--<td width='5%' align='center'><input type="button" class='mainbut'  onClick='load_screen_status("HELP");' value="Help"></td>-->
							<td width='5%' align='center'><input type="button" class='mainbut'  onclick="screen_close();" value="Exit"></td>
						</tr>
						</table>				
							
							
							
							
							
						</form>
						</body>
						</html>
