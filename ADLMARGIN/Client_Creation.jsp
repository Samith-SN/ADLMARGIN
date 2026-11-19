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
    String m_chksql,m_Client_no;
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
		"   AND    A.TITLE_DESC <> 'Hon' " +
        "   ORDER BY A.TITLE_DESC " +
        " ";
    
    statement = connection.createStatement();
    resultSet = statement.executeQuery(sql);
    title_types = new StringBuffer();
    while(resultSet.next()) {
        title_types.append("<option value=\"" + resultSet.getString("TITLE_TYPE") + "\">" + resultSet.getString("TITLE_DESC") + "</option>");
    }
	title_types.append("<option value=\"HON\">" + "Hons" + "</option>");
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
    
    
    // String m_servlet_client_url = m_sn_methods.servlet_client_url;
    // String m_client_t3_port = m_sn_methods.client_t3_port;
    // String m_client_name = m_sn_methods.client_name;
    
    // Calendar calendar = Calendar.getInstance();
    
    // String system_day   = Integer.toString(calendar.get(Calendar.DATE));
    // String system_month = Integer.toString(calendar.get(Calendar.MONTH) + 1);
    // String system_year  = Integer.toString(calendar.get(Calendar.YEAR));
    
    // if (calendar.get(Calendar.DATE) < 10) {
        // system_day = "0" + calendar.get(Calendar.DATE);
    // }
    // if (calendar.get(Calendar.MONTH) + 1 < 10) {
        // system_month = "0" + (calendar.get(Calendar.MONTH) + 1);
    // }
    
%>


	

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Margin Trading</title>
        <meta name="generator" content="ModelWorks IDE" />
        
        <script type="text/javascript" src="<%= jsp_client_url %>/js/jquery.min.js"></script>
        <script type="text/javascript" src="<%= jsp_client_url %>/js/jquery-ui.min.js"></script>
        <script type="text/javascript" src="<%= jsp_client_url %>/SNET/jquery/fancybox/jquery.filestyle.pack.js"></script>
        <!-- <script type="text/javascript" src="<%= jsp_client_url %>/SNET/jquery/grid/4.1/js/i18n/grid.locale-en.js"></script> -->
        <!-- <script type="text/javascript" src="<%= jsp_client_url %>/SNET/jquery/grid/4.1/js/jquery.jqGrid.min.js"></script> -->
        <script type="text/javascript" src="<%= jsp_client_url %>/js/json2.js"></script>
        <script type="text/javascript" src="<%= jsp_client_url %>/js/popup.js"></script>
        <script type="text/javascript" src="validate.js"></script>
        <script type="text/javascript" src="validate_v1.js"></script>
        <!-- <script type="text/javascript" src="factoring_drill_down.js"></script> -->
        <script type="text/javascript" src="ajax_data_gateway.js"></script>
        
        <link rel="stylesheet" type="text/css" href="<%= jsp_client_url %>/css/Asset_Financing_System.css" />
        <link rel="stylesheet" type="text/css" href="<%= jsp_client_url %>/css/redmond/jquery-ui.css" media="screen" />
        <!-- <link rel="stylesheet" type="text/css" href="<%= jsp_client_url %>/css/ui.jqgrid.css" media="screen" /> -->
        
        <style type="text/css">
            
            .but_input_client {
                width: 50px;
            }
            
        </style>
        
        <script type="text/javascript">
            
            var banks_list = '';
            var g_sysdate = '<%= sysdate %>';
            
            var g_business_entities     = '<%= String.valueOf(business_entities) %>';
            var g_address_types         = '<%= String.valueOf(address_types) %>';
            var g_ownership_types       = '<%= String.valueOf(ownership_types) %>';
            var g_title_types           = '<%= String.valueOf(title_types) %>';
            var g_identification_types  = '<%= String.valueOf(identification_types) %>';
            var g_employee_types        = '<%= String.valueOf(employee_types) %>';
            var g_designation_types     = '<%= String.valueOf(designation_types) %>';
            var g_association_types     = '<%= String.valueOf(association_types) %>';
            var g_account_types         = '<%= String.valueOf(account_types) %>';
            var g_facility_types        = '<%= String.valueOf(facility_types) %>';
            
            var g_auditor_string        = '' + g_sysdate + ',0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,' + g_sysdate + ',0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,' + g_sysdate + ',0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,' + g_sysdate + ',0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,' + g_sysdate + ',0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,' + g_sysdate + ',0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00';
            
            
            var g_help_type             = '';
            var g_help_row_id           = '';
            
            var g_save_type             = 'save';
            
            $(document).ready(function () {
                
                setWHTEnable();
                
                load_data_sections();
                
            });
            
            
            function load_data_sections() {
                add_contact_person();
                load_business_entity(); 
                load_general_information();
                delete_directors_partners_shareholders(0);
                delete_subsidiaries_and_associated_companies(0);
                delete_auditors_details(0);
                delete_accounts_and_banking_details(0);
                delete_details_of_credit_facilities(0);
                delete_stock_brokering_accounts(0);
                
                init_filestyle('TXT_S01_MAP');
                init_filestyle('TXT_S01_PICTURE');
            }
            
            
            function load_business_entity() {
                if (document.getElementById('TXT_CLIENT_TYPE').value == "C") {
                    document.getElementById('TXT_BUSINESS_ENTITY').disabled = false;
                    document.getElementById('TXT_BUSINESS_ENTITY').style.display = 'inline';
                }
                else if (document.getElementById('TXT_CLIENT_TYPE').value == "I") {
                    document.getElementById('TXT_BUSINESS_ENTITY').disabled = true;
                    document.getElementById('TXT_BUSINESS_ENTITY').style.display = 'none';
                }
            }
            
            
            function load_general_information() {
                if (document.getElementById('TXT_CLIENT_TYPE').value == 'C') {
                    document.getElementById("DIV_CLIENT_GENERAL_INFORMATION").innerHTML = '' +
                        '   <table> ' +
                        '       <tr> ' +
                        '           <td style="width: 200px;">Legal Status of Business</td> ' +
                        '           <td> ' +
                        '               <input type="hidden" name="TXT_S03_C_LEGAL_STATUS_OF_BUSINESS" id="TXT_S03_C_LEGAL_STATUS_OF_BUSINESS" /> ' +
                        '               <input class="txt_input" type="text" name="TXT_S03_C_LEGAL_STATUS_OF_BUSINESS_NAME" id="TXT_S03_C_LEGAL_STATUS_OF_BUSINESS_NAME" maxlength="50" style="width: 125px;" onblur="strTrim(this); popup_help(0, \'legal_status_of_business\');" /> ' +
                        '               <input class="but_input but_input_client" type="button" name="BUT_HELP_S03_C_LEGAL_STATUS_OF_BUSINESS" id="BUT_HELP_S03_C_LEGAL_STATUS_OF_BUSINESS" value="..." onclick="popup_help(0, \'legal_status_of_business\');" /> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>Client Group</td> ' +
                        '           <td> ' +
                        '               <input type="hidden" name="TXT_S03_C_CLIENT_GROUP" id="TXT_S03_C_CLIENT_GROUP" /> ' +
                        '               <input class="txt_input" type="text" name="TXT_S03_C_CLIENT_GROUP_NAME" id="TXT_S03_C_CLIENT_GROUP_NAME" maxlength="50" style="width: 125px;" onblur="strTrim(this); popup_help(0, \'client_group\');" /> ' +
                        '               <input class="but_input but_input_client" type="button" name="BUT_HELP_S03_C_CLIENT_GROUP" id="BUT_HELP_S03_C_CLIENT_GROUP" value="..." onclick="popup_help(0, \'client_group\');" /> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>Issued Share Capital (Rs.)</td> ' +
                        '           <td><input class="txt_input" type="text" name="TXT_S03_C_ISSUED_SHARE_CAPITAL" id="TXT_S03_C_ISSUED_SHARE_CAPITAL" value="0.00" maxlength="24" style="width: 250px; text-align: right;" onblur="validateNumber(this, 0, 9999999999999999.99, 2, \'number\')" /></td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td><div id="DIV_TXT_S03_C_BUSINESS_CERTIFICATE_NO">Business Registration Number</div></td> ' +
                        '           <td><input class="txt_input" type="text" name="TXT_S03_C_BUSINESS_CERTIFICATE_NO" id="TXT_S03_C_BUSINESS_CERTIFICATE_NO" maxlength="20" style="width: 250px;" onblur="strTrim(this); check_business_registration()" /></td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td><div id="DIV_TXT_S03_C_BUSINESS_REG_LOCATION">Business Registered Location</div></td> ' +
                        '           <td><input class="txt_input" type="text" name="TXT_S03_C_BUSINESS_REG_LOCATION" id="TXT_S03_C_BUSINESS_REG_LOCATION" maxlength="100" style="width: 250px;" onblur="strTrim(this);" /></td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>Address Type</td> ' +
                        '           <td> ' +
                        '               <select name="TXT_S03_C_ADDRESS_TYPE" id="TXT_S03_C_ADDRESS_TYPE" class="txt_input" style="width: 125px;">' + g_address_types + '</select> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>Address Line 1</td> ' + 
                        '           <td> ' +
                        '               <input class="txt_input" type="text" name="TXT_S03_C_ADDRESS_LINE_1" id="TXT_S03_C_ADDRESS_LINE_1" maxlength="100" style="width: 250px;" onblur="strTrim(this, null, null, \'ADDRESS\'); strProperCase(this);" /> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>Address Line 2</td> ' +
                        '           <td> ' +
                        '               <input class="txt_input" type="text" name="TXT_S03_C_ADDRESS_LINE_2" id="TXT_S03_C_ADDRESS_LINE_2" maxlength="100" style="width: 250px;" onblur="strTrim(this, null, null, \'ADDRESS\'); strProperCase(this);" /> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>City</td> ' +
                        '           <td> ' +
                        '               <input type="hidden" name="TXT_S03_C_CITY" id="TXT_S03_C_CITY" /> ' +
                        '               <input class="txt_input" type="text" name="TXT_S03_C_CITY_NAME" id="TXT_S03_C_CITY_NAME" maxlength="50" style="width: 125px;" onblur="strTrim(this); popup_help(0, \'city_2\');" /> ' +
                        '               <input class="but_input but_input_client" type="button" name="BUT_HELP_S03_C_CITY" id="BUT_HELP_S03_C_CITY" value="..." onclick="popup_help(0, \'city_2\');" /> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>District</td> ' +
                        '           <td> ' +
                        '               <input class="txt_input" type="text" name="TXT_S03_C_DISTRICT_NAME" id="TXT_S03_C_DISTRICT_NAME" style="width: 125px;" disabled="disabled" /> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>Province</td> ' +
                        '           <td> ' +
                        '               <input class="txt_input" type="text" name="TXT_S03_C_PROVINCE_NAME" id="TXT_S03_C_PROVINCE_NAME" style="width: 125px;" disabled="disabled" /> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>Country</td> ' +
                        '           <td> ' +
                        '               <input class="txt_input" type="text" name="TXT_S03_C_COUNTRY_NAME" id="TXT_S03_C_COUNTRY_NAME" style="width: 125px;" disabled="disabled" /> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>Date of Incorporation</td> ' +
                        '           <td> ' +
                        '               <input class="txt_input5" type="text" name="TXT_S03_C_DATE_OF_INCORPORATION_DD" id="TXT_S03_C_DATE_OF_INCORPORATION_DD" maxlength="2" size="2" onblur="checkMonthLength1(document.Form1.elements[\'TXT_S03_C_DATE_OF_INCORPORATION_DD\'], document.Form1.elements[\'TXT_S03_C_DATE_OF_INCORPORATION_MM\'], document.Form1.elements[\'TXT_S03_C_DATE_OF_INCORPORATION_YY\'], document.Form1.elements[\'TXT_S03_C_DATE_OF_INCORPORATION\'], \'D\', \'Y\', g_sysdate, \'no future\');" /> ' +
                        '               <input class="txt_input5" type="text" name="TXT_S03_C_DATE_OF_INCORPORATION_MM" id="TXT_S03_C_DATE_OF_INCORPORATION_MM" maxlength="2" size="2" onblur="checkMonthLength1(document.Form1.elements[\'TXT_S03_C_DATE_OF_INCORPORATION_DD\'], document.Form1.elements[\'TXT_S03_C_DATE_OF_INCORPORATION_MM\'], document.Form1.elements[\'TXT_S03_C_DATE_OF_INCORPORATION_YY\'], document.Form1.elements[\'TXT_S03_C_DATE_OF_INCORPORATION\'], \'M\', \'Y\', g_sysdate, \'no future\');" /> ' +
                        '               <input class="txt_input5" type="text" name="TXT_S03_C_DATE_OF_INCORPORATION_YY" id="TXT_S03_C_DATE_OF_INCORPORATION_YY" maxlength="4" size="4" onblur="checkMonthLength1(document.Form1.elements[\'TXT_S03_C_DATE_OF_INCORPORATION_DD\'], document.Form1.elements[\'TXT_S03_C_DATE_OF_INCORPORATION_MM\'], document.Form1.elements[\'TXT_S03_C_DATE_OF_INCORPORATION_YY\'], document.Form1.elements[\'TXT_S03_C_DATE_OF_INCORPORATION\'], \'Y\', \'Y\', g_sysdate, \'no future\');" /> ' +
                        '               <input type="hidden" name="TXT_S03_C_DATE_OF_INCORPORATION" id="TXT_S03_C_DATE_OF_INCORPORATION" /> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>Withholding Tax</td> ' +
                        '           <td> ' +
                        '               <select name="TXT_S03_C_WITHHOLDING_TAX" id="TXT_S03_C_WITHHOLDING_TAX" class="txt_input" style="width: 75px;" onchange="setWHTEnable();"> ' +
                        '                   <option value="N" >No</option> ' +
                        '                   <option value="Y" selected="selected">Yes</option> ' +
                        '               </select> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>Withholding Tax %</td> ' +
                        '           <td><input class="txt_input" type="text" name="TXT_S03_C_WITHHOLDING_TAX_PERCENTAGE" id="TXT_S03_C_WITHHOLDING_TAX_PERCENTAGE" value="0.00" maxlength="6" style="width: 50px; text-align: right;" onblur="validateNumber(this, 0, 100, 2, \'number\')" /></td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>Withholding Tax Certificate Number</td> ' +
                        '           <td><input class="txt_input" type="text" name="TXT_S03_C_WITHHOLDING_TAX_CERTIFICATE_NUMBER" id="TXT_S03_C_WITHHOLDING_TAX_CERTIFICATE_NUMBER" maxlength="50" style="width: 125px;" onblur="strTrim(this);" /></td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>VAT Registration Number</td> ' +
                        '           <td><input class="txt_input" type="text" name="TXT_S03_C_VAT_REG_NO" id="TXT_S03_C_VAT_REG_NO" maxlength="20" style="width: 125px;" onblur="strTrim(this);" /></td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>VAT Registration Date</td> ' +
                        '           <td> ' +
                        '               <input class="txt_input5" type="text" name="TXT_S03_C_VAT_REGISTRATION_DATE_DD" id="TXT_S03_C_VAT_REGISTRATION_DATE_DD" maxlength="2" size="2" onblur="checkMonthLength1(document.Form1.elements[\'TXT_S03_C_VAT_REGISTRATION_DATE_DD\'], document.Form1.elements[\'TXT_S03_C_VAT_REGISTRATION_DATE_MM\'], document.Form1.elements[\'TXT_S03_C_VAT_REGISTRATION_DATE_YY\'], document.Form1.elements[\'TXT_S03_C_VAT_REGISTRATION_DATE\'], \'D\', \'Y\', g_sysdate, \'no future\');" /> ' +
                        '               <input class="txt_input5" type="text" name="TXT_S03_C_VAT_REGISTRATION_DATE_MM" id="TXT_S03_C_VAT_REGISTRATION_DATE_MM" maxlength="2" size="2" onblur="checkMonthLength1(document.Form1.elements[\'TXT_S03_C_VAT_REGISTRATION_DATE_DD\'], document.Form1.elements[\'TXT_S03_C_VAT_REGISTRATION_DATE_MM\'], document.Form1.elements[\'TXT_S03_C_VAT_REGISTRATION_DATE_YY\'], document.Form1.elements[\'TXT_S03_C_VAT_REGISTRATION_DATE\'], \'M\', \'Y\', g_sysdate, \'no future\');" /> ' +
                        '               <input class="txt_input5" type="text" name="TXT_S03_C_VAT_REGISTRATION_DATE_YY" id="TXT_S03_C_VAT_REGISTRATION_DATE_YY" maxlength="4" size="4" onblur="checkMonthLength1(document.Form1.elements[\'TXT_S03_C_VAT_REGISTRATION_DATE_DD\'], document.Form1.elements[\'TXT_S03_C_VAT_REGISTRATION_DATE_MM\'], document.Form1.elements[\'TXT_S03_C_VAT_REGISTRATION_DATE_YY\'], document.Form1.elements[\'TXT_S03_C_VAT_REGISTRATION_DATE\'], \'Y\', \'Y\', g_sysdate, \'no future\');" /> ' +
                        '               <input type="hidden" name="TXT_S03_C_VAT_REGISTRATION_DATE" id="TXT_S03_C_VAT_REGISTRATION_DATE" /> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>External Rating</td> ' +
                        '           <td> ' +
                        '               <input class="txt_input" type="text" name="TXT_S03_C_EXTERNAL_RATING" id="TXT_S03_C_EXTERNAL_RATING" maxlength="20" style="width: 50px;" onblur="strTrim(this);" /> ' +
                        '               &nbsp; &nbsp; &nbsp; &nbsp; ' +
                        '               Agency ' +
                        '               &nbsp; &nbsp; ' +
                        '               <input class="txt_input" type="text" name="TXT_S03_C_RATING_AGENCY" id="TXT_S03_C_RATING_AGENCY" maxlength="20" style="width: 50px;" onblur="strTrim(this);" /> ' +
                        '               &nbsp; &nbsp; &nbsp; &nbsp; ' +
                        '               Year ' +
                        '               &nbsp; &nbsp; ' +
                        '               <input class="txt_input" type="text" name="TXT_S03_C_RATING_YEAR" id="TXT_S03_C_RATING_YEAR" maxlength="4" style="width: 50px;" onblur="strTrim(this); validateYear(this);" /> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>CRIB File Upload</td> ' +
                        '           <td> ' +
                        '               <input class="txt_input TXT_S03_CRIB" type="file" id="TXT_S03_CRIB" name="TXT_S03_CRIB" style="width: 250px;" /> ' +
                        '           </td> ' +
                        '       </tr> '+ 
                        '       <tr> '+ 
                        '           <td valign="top">Nature of Business</td> ' +
                        '           <td> ' +
                        '               <textarea name="TXT_S03_C_NATURE_OF_BUSINESS" id="TXT_S03_C_NATURE_OF_BUSINESS" rows="4" cols="40" onKeyPress="return imposeMaxLength(this, 4000);" onblur="strTrim(this, null, null, \'COMMENT\'); limitText(this, document.Form1.TXT_S03_C_NATURE_OF_BUSINESS_COUNT, 4000);" onKeyUp="limitText(this, document.Form1.TXT_S03_C_NATURE_OF_BUSINESS_COUNT, 4000);" onKeyDown="limitText(this, document.Form1.TXT_S03_C_NATURE_OF_BUSINESS_COUNT, 4000);"></textarea> ' +
                        '               <br /> ' +
                        '               (Maximum characters: 4000) <input class="txt_input5" type="text" size="3" value="4000" name="TXT_S03_C_NATURE_OF_BUSINESS_COUNT" id="TXT_S03_C_NATURE_OF_BUSINESS_COUNT" disabled="disabled"> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> '+ 
                        '           <td valign="top">Comments</td> ' +
                        '           <td> ' +
                        '               <textarea name="TXT_S03_C_COMMENTS" id="TXT_S03_C_COMMENTS" rows="4" cols="40" onKeyPress="return imposeMaxLength(this, 4000);" onblur="strTrim(this, null, null, \'COMMENT\'); limitText(this, document.Form1.TXT_S03_C_COMMENTS_COUNT, 4000);" onKeyUp="limitText(this, document.Form1.TXT_S03_C_COMMENTS_COUNT, 4000);" onKeyDown="limitText(this, document.Form1.TXT_S03_C_COMMENTS_COUNT, 4000);"></textarea> ' +
                        '               <br /> ' +
                        '               (Maximum characters: 4000) <input class="txt_input5" type="text" size="3" value="4000" name="TXT_S03_C_COMMENTS_COUNT" id="TXT_S03_C_COMMENTS_COUNT" disabled="disabled"> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '   </table> ' +
                        '';
                    
                    initCal('TXT_S03_C_DATE_OF_INCORPORATION');
                    initCal('TXT_S03_C_VAT_REGISTRATION_DATE');
                }
                else if (document.getElementById('TXT_CLIENT_TYPE').value == 'I') {
                    document.getElementById("DIV_CLIENT_GENERAL_INFORMATION").innerHTML = '' +
                        '   <table> ' +
                        '       <tr> ' +
                        '           <td valign="top" style="width: 200px;">Title</td> ' +
                        '           <td> ' +
                        '               <select class="txt_input" name="TXT_S03_I_TITLE" id="TXT_S03_I_TITLE" style="width: 75px;">' + g_title_types + '</select> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>Surname</td> ' +
                        '           <td><input class="txt_input" type="text" name="TXT_S03_I_SURNAME" id="TXT_S03_I_SURNAME" maxlength="100" style="width: 125px;" onblur="strTrim(this, null, null, \'NAME\'); strProperCase(this);" /></td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>Initials</td> ' +
                        '           <td><input class="txt_input" type="text" name="TXT_S03_I_INITIALS" id="TXT_S03_I_INITIALS" maxlength="30" style="width: 75px;" onblur="strTrim(this);" /></td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>Names Denoted by Initials</td> ' +
                        '           <td><input class="txt_input" type="text" name="TXT_S03_I_INITIALS_DETAILS" id="TXT_S03_I_INITIALS_DETAILS" maxlength="400" style="width: 250px;" onblur="strTrim(this, null, null, \'NAME\'); strProperCase(this); setInitials(this, document.Form1.TXT_S03_I_INITIALS); " /></td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>Gender</td> ' +
                        '           <td> ' +
                        '               <select name="TXT_S03_I_GENDER" id="TXT_S03_I_GENDER" class="txt_input" style="width: 75px;"> ' +
                        '                   <option value="MALE" selected="selected">Male</option> ' +
                        '                   <option value="FEMALE">Female</option> ' +
                        '               </select> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>Nationality</td> ' +
                        '           <td> ' +
                        '               <input type="hidden" name="TXT_S03_I_NATIONALITY" id="TXT_S03_I_NATIONALITY" VALUE="SRI_LANKAN" /> ' +
                        '               <input class="txt_input" type="text" name="TXT_S03_I_NATIONALITY_NAME" id="TXT_S03_I_NATIONALITY_NAME" maxlength="50" style="width: 125px;" onblur="strTrim(this); popup_help(0, \'nationality\');" VALUE="Sri Lankan"  /> ' +
                        '               <input class="but_input but_input_client" type="button" name="BUT_HELP_S03_I_NATIONALITY" value="..." onclick="popup_help(0, \'nationality\');" /> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>Identification Type</td> ' +
                        '           <td> ' +
                        '               <select class="txt_input" name="TXT_S03_I_IDENTIFICATION_TYPE" id="TXT_S03_I_IDENTIFICATION_TYPE" style="width: 125px;" onchange="change_id_label_s03(); document.getElementById(\'TXT_S03_I_IDENTIFICATION\').focus();">' + g_identification_types + '</select> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td><div id="DIV_S03_I_IDENTIFICATION"></div></td> ' +
                        '           <td><input class="txt_input" type="text" name="TXT_S03_I_IDENTIFICATION" id="TXT_S03_I_IDENTIFICATION" maxlength="30" style="width: 125px;" onblur="strTrim(this); check_nic();" /></td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td><div id="DIV_TXT_S03_C_BUSINESS_REG_LOCATION">Business Registered Location</div></td> ' +
                        '           <td><input class="txt_input" type="text" name="TXT_S03_C_BUSINESS_REG_LOCATION" id="TXT_S03_C_BUSINESS_REG_LOCATION" maxlength="100" style="width: 250px;" onblur="strTrim(this);" /></td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>Marital Status</td> ' +
                        '           <td> ' +
                        '               <select name="TXT_S03_I_MARITAL_STATUS" id="TXT_S03_I_MARITAL_STATUS" class="txt_input" style="width: 125px;"> ' +
                        '                   <option value="SINGLE" selected="selected">Single</option> ' +
                        '                   <option value="MARRIED">Married</option> ' +
                        '                   <option value="DIVORCED">Divorced</option> ' +
                        '               </select> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>Dependents</td> ' +
                        '           <td><input class="txt_input" type="text" name="TXT_S03_I_DEPENDENTS" id="TXT_S03_I_DEPENDENTS" maxlength="50" style="width: 250px;" onblur="strTrim(this);" /></td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>No. of Children</td> ' +
                        '           <td><input class="txt_input" type="text" name="TXT_S03_I_NO_OF_CHILDREN" id="TXT_S03_I_NO_OF_CHILDREN" value="0" maxlength="2" style="width: 75px; text-align: right;" onblur="validateNumber(this, 0, 99, 0, \'number\')" /></td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>D. O. B.</td> ' +
                        '           <td> ' +
                        '               <input class="txt_input5" type="text" name="TXT_S03_I_DATE_OF_BIRTH_DD" id="TXT_S03_I_DATE_OF_BIRTH_DD" maxlength="2" size="2" onblur="checkMonthLength1(document.Form1.elements[\'TXT_S03_I_DATE_OF_BIRTH_DD\'], document.Form1.elements[\'TXT_S03_I_DATE_OF_BIRTH_MM\'], document.Form1.elements[\'TXT_S03_I_DATE_OF_BIRTH_YY\'], document.Form1.elements[\'TXT_S03_I_DATE_OF_BIRTH\'], \'D\', \'Y\', g_sysdate, \'no future\');" /> ' +
                        '               <input class="txt_input5" type="text" name="TXT_S03_I_DATE_OF_BIRTH_MM" id="TXT_S03_I_DATE_OF_BIRTH_MM" maxlength="2" size="2" onblur="checkMonthLength1(document.Form1.elements[\'TXT_S03_I_DATE_OF_BIRTH_DD\'], document.Form1.elements[\'TXT_S03_I_DATE_OF_BIRTH_MM\'], document.Form1.elements[\'TXT_S03_I_DATE_OF_BIRTH_YY\'], document.Form1.elements[\'TXT_S03_I_DATE_OF_BIRTH\'], \'M\', \'Y\', g_sysdate, \'no future\');" /> ' +
                        '               <input class="txt_input5" type="text" name="TXT_S03_I_DATE_OF_BIRTH_YY" id="TXT_S03_I_DATE_OF_BIRTH_YY" maxlength="4" size="4" onblur="checkMonthLength1(document.Form1.elements[\'TXT_S03_I_DATE_OF_BIRTH_DD\'], document.Form1.elements[\'TXT_S03_I_DATE_OF_BIRTH_MM\'], document.Form1.elements[\'TXT_S03_I_DATE_OF_BIRTH_YY\'], document.Form1.elements[\'TXT_S03_I_DATE_OF_BIRTH\'], \'Y\', \'Y\', g_sysdate, \'no future\');" /> ' +
                        '               <input type="hidden" name="TXT_S03_I_DATE_OF_BIRTH" id="TXT_S03_I_DATE_OF_BIRTH" /> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>Occupation</td> ' +
                        '           <td><input class="txt_input" type="text" name="TXT_S03_I_OCCUPATION" id="TXT_S03_I_OCCUPATION" maxlength="50" style="width: 125px;" onblur="strTrim(this, null, null, \'NAME_2\');" /></td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td valign="top">Employement Type</td> ' +
                        '           <td> ' +
                        '               <select class="txt_input" name="TXT_S03_I_EMPLOYEMENT_TYPE" id="TXT_S03_I_EMPLOYEMENT_TYPE" style="width: 125px;">' + g_employee_types + '</select> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>VAT Registration Number</td> ' +
                        '           <td><input class="txt_input" type="text" name="TXT_S03_I_VAT_REG_NO" id="TXT_S03_I_VAT_REG_NO" maxlength="20" style="width: 125px;" onblur="strTrim(this);" /></td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>VAT Registration Date</td> ' +
                        '           <td> ' +
                        '               <input class="txt_input5" type="text" name="TXT_S03_I_VAT_REGISTRATION_DATE_DD" id="TXT_S03_I_VAT_REGISTRATION_DATE_DD" maxlength="2" size="2" onblur="checkMonthLength1(document.Form1.elements[\'TXT_S03_I_VAT_REGISTRATION_DATE_DD\'], document.Form1.elements[\'TXT_S03_I_VAT_REGISTRATION_DATE_MM\'], document.Form1.elements[\'TXT_S03_I_VAT_REGISTRATION_DATE_YY\'], document.Form1.elements[\'TXT_S03_I_VAT_REGISTRATION_DATE\'], \'D\', \'Y\', g_sysdate, \'no future\');" /> ' +
                        '               <input class="txt_input5" type="text" name="TXT_S03_I_VAT_REGISTRATION_DATE_MM" id="TXT_S03_I_VAT_REGISTRATION_DATE_MM" maxlength="2" size="2" onblur="checkMonthLength1(document.Form1.elements[\'TXT_S03_I_VAT_REGISTRATION_DATE_DD\'], document.Form1.elements[\'TXT_S03_I_VAT_REGISTRATION_DATE_MM\'], document.Form1.elements[\'TXT_S03_I_VAT_REGISTRATION_DATE_YY\'], document.Form1.elements[\'TXT_S03_I_VAT_REGISTRATION_DATE\'], \'M\', \'Y\', g_sysdate, \'no future\');" /> ' +
                        '               <input class="txt_input5" type="text" name="TXT_S03_I_VAT_REGISTRATION_DATE_YY" id="TXT_S03_I_VAT_REGISTRATION_DATE_YY" maxlength="4" size="4" onblur="checkMonthLength1(document.Form1.elements[\'TXT_S03_I_VAT_REGISTRATION_DATE_DD\'], document.Form1.elements[\'TXT_S03_I_VAT_REGISTRATION_DATE_MM\'], document.Form1.elements[\'TXT_S03_I_VAT_REGISTRATION_DATE_YY\'], document.Form1.elements[\'TXT_S03_I_VAT_REGISTRATION_DATE\'], \'Y\', \'Y\', g_sysdate, \'no future\');" /> ' +
                        '               <input type="hidden" name="TXT_S03_I_VAT_REGISTRATION_DATE" id="TXT_S03_I_VAT_REGISTRATION_DATE" /> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td>CRIB File Upload</td> ' +
                        '           <td> ' +
                        '               <input class="txt_input TXT_S03_CRIB" type="file" id="TXT_S03_CRIB" name="TXT_S03_CRIB" style="width: 250px;" /> ' +
                        '           </td> ' +
                        '       </tr> '+ 
                        '       <tr> '+ 
                        '           <td valign="top">Nature of Business</td> ' +
                        '           <td> ' +
                        '               <textarea name="TXT_S03_C_NATURE_OF_BUSINESS" id="TXT_S03_C_NATURE_OF_BUSINESS" rows="4" cols="40" onKeyPress="return imposeMaxLength(this, 4000);" onblur="strTrim(this, null, null, \'COMMENT\'); limitText(this, document.Form1.TXT_S03_C_NATURE_OF_BUSINESS_COUNT, 4000);" onKeyUp="limitText(this, document.Form1.TXT_S03_C_NATURE_OF_BUSINESS_COUNT, 4000);" onKeyDown="limitText(this, document.Form1.TXT_S03_C_NATURE_OF_BUSINESS_COUNT, 4000);"></textarea> ' +
                        '               <br /> ' +
                        '               (Maximum characters: 4000) <input class="txt_input5" type="text" size="3" value="4000" name="TXT_S03_C_NATURE_OF_BUSINESS_COUNT" id="TXT_S03_C_NATURE_OF_BUSINESS_COUNT" disabled="disabled"> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '       <tr> ' +
                        '           <td valign="top">Qualification</td> ' +
                        '           <td> ' +
                        '               <textarea name="TXT_S03_I_QUALIFICATION" id="TXT_S03_I_QUALIFICATION" rows="4" cols="40" onKeyPress="return imposeMaxLength(this, 200);" onblur="strTrim(this, null, null, \'COMMENT\'); limitText(this, document.Form1.TXT_S03_I_QUALIFICATION_COUNT, 200);" onKeyUp="limitText(this, document.Form1.TXT_S03_I_QUALIFICATION_COUNT, 200);" onKeyDown="limitText(this, document.Form1.TXT_S03_I_QUALIFICATION_COUNT, 200);"></textarea> ' +
                        '               <br /> ' +
                        '               (Maximum characters: 200) <input class="txt_input5" type="text" size="3" value="200" name="TXT_S03_I_QUALIFICATION_COUNT" id="TXT_S03_I_QUALIFICATION_COUNT" disabled="disabled"> ' +
                        '           </td> ' +
                        '       </tr> ' +
                        '   </table> ' +
                        '';
                    
                    change_id_label_s03();
                    initCal('TXT_S03_I_DATE_OF_BIRTH');
                    initCal('TXT_S03_I_VAT_REGISTRATION_DATE');
                }
                
                init_filestyle('TXT_S03_CRIB');
            }
            
            
            function change_id_label_s03() {
                $('#DIV_S03_I_IDENTIFICATION').text($('#TXT_S03_I_IDENTIFICATION_TYPE option:selected').text());
            }
            
            
            function add_contact_person() {
                var html_content = null;
                
                var m_new_total_count = parseInt(document.Form1.hid_contact_person_count.value) + 1;
                if (m_new_total_count == 1) {
                    document.getElementById("DIV_CONTACT_PERSON").innerHTML = '';
                }
                createDIV('DIV_CONTACT_PERSON', m_new_total_count);
                
                html_content = '' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td class="div_input" align="center" style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 75px;"><b>Title</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Last Name</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 75px;"><b>Initials</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 250px;"><b>Name Denoted by Initials</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 175px;"><b>Designation</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '';
                
                if (m_new_total_count == 1) {
                    html_content = html_content +
                        '           <td><input class="but_input but_input_client" type="button" name="BUT_ADD_CONTACT_PERSON" value="+" onclick="add_contact_person();" /></td> ' + 
                        '';
                }
                else {
                    html_content = html_content +
                        '           <td style="width: 50px;"></td> ' + 
                        '';
                }
                
                html_content = html_content +
                    '           <td><input class="but_input but_input_client" type="button" name="BUT_DELETE_CONTACT_PERSON" value="-" onclick="delete_contact_person(' + m_new_total_count + ');" /></td> ' + 
                    '           <td><select class="txt_input" name="TXT_S02_TITLE_' + m_new_total_count + '" id="TXT_S02_TITLE_' + m_new_total_count + '" style="width: 75px;" />' + g_title_types + '</select></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S02_LAST_NAME_' + m_new_total_count + '" id="TXT_S02_LAST_NAME_' + m_new_total_count + '" maxlength="100" style="width: 125px;" onblur="strTrim(this, null, null, \'NAME\'); strProperCase(this);" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S02_INITIALS_' + m_new_total_count + '" id="TXT_S02_INITIALS_' + m_new_total_count + '" maxlength="30" style="width: 75px;" onblur="strTrim(this);" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S02_INITIALS_DETAILS_' + m_new_total_count + '" id="TXT_S02_INITIALS_DETAILS_' + m_new_total_count + '" maxlength="400" style="width: 250px;" onblur="strTrim(this, null, null, \'NAME\'); strProperCase(this); setInitials(this, document.Form1.elements[\'TXT_S02_INITIALS_' + m_new_total_count + '\']);" /></td> ' + 
                    '           <td><select class="txt_input" name="TXT_S02_DESIGNATION_' + m_new_total_count + '" id="TXT_S02_DESIGNATION_' + m_new_total_count + '" style="width: 175px;" />' + g_designation_types + '</select></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Address Type</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 250px;"><b>Address Line 1</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 250px;"><b>Address Line 2</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td><select class="txt_input" name="TXT_S02_ADDRESS_TYPE_' + m_new_total_count + '" id="TXT_S02_ADDRESS_TYPE_' + m_new_total_count + '" style="width: 125px;" />' + g_address_types + '</select></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S02_ADDRESS_LINE_1_' + m_new_total_count + '" id="TXT_S02_ADDRESS_LINE_1_' + m_new_total_count + '" maxlength="100" style="width: 250px;" onblur="strTrim(this, null, null, \'ADDRESS\'); strProperCase(this);" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S02_ADDRESS_LINE_2_' + m_new_total_count + '" id="TXT_S02_ADDRESS_LINE_2_' + m_new_total_count + '" maxlength="100" style="width: 250px;" onblur="strTrim(this, null, null, \'ADDRESS\'); strProperCase(this);" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 185px;"><b>City</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>District</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Province</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Country</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td> ' + 
                    '               <input type="hidden" name="TXT_S02_CITY_' + m_new_total_count + '" id="TXT_S02_CITY_' + m_new_total_count + '" /> ' + 
                    '               <input class="txt_input" type="text" name="TXT_S02_CITY_NAME_' + m_new_total_count + '" id="TXT_S02_CITY_NAME_' + m_new_total_count + '" maxlength="50" onblur="strTrim(this); popup_help(0, \'city_3\', \'' + m_new_total_count + '\');" style="width: 125px;" /> ' + 
                    '               <input class="but_input but_input_client" type="button" name="BUT_HELP_S02_CITY" id="BUT_HELP_S02_CITY" value="..." onclick="popup_help(0, \'city_3\', \'' + m_new_total_count + '\');" />' + 
                    '           </td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S02_DISTRICT_NAME_' + m_new_total_count + '" id="TXT_S02_DISTRICT_NAME_' + m_new_total_count + '" disabled="disabled" style="width: 125px;" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S02_PROVINCE_NAME_' + m_new_total_count + '" id="TXT_S02_PROVINCE_NAME_' + m_new_total_count + '" disabled="disabled" style="width: 125px;" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S02_COUNTRY_NAME_' + m_new_total_count + '" id="TXT_S02_COUNTRY_NAME_' + m_new_total_count + '" disabled="disabled" style="width: 125px;" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Telephone 1</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Telephone 2</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Mobile</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Fax</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 175px;"><b>Email</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 50px;"><b>Default</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S02_TELEPHONE_1_' + m_new_total_count + '" id="TXT_S02_TELEPHONE_1_' + m_new_total_count + '" maxlength="14" value= "0094" style="width: 125px;" onblur="validatePhoneNumber(this, \'Telephone\');" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S02_TELEPHONE_2_' + m_new_total_count + '" id="TXT_S02_TELEPHONE_2_' + m_new_total_count + '" maxlength="14" value= "0094" style="width: 125px;" onblur="validatePhoneNumber(this, \'Telephone\');" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S02_MOBILE_' + m_new_total_count + '" id="TXT_S02_MOBILE_' + m_new_total_count + '" maxlength="14" value= "0094" style="width: 125px;" onblur="validatePhoneNumber(this, \'Mobile\');" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S02_FAX_' + m_new_total_count + '" id="TXT_S02_FAX_' + m_new_total_count + '" maxlength="14" value= "0094" style="width: 125px;" onblur="validatePhoneNumber(this, \'Fax\');" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S02_EMAIL_' + m_new_total_count + '" id="TXT_S02_EMAIL_' + m_new_total_count + '" maxlength="100" style="width: 175px;" onblur ="validateEmail(this);" /></td> ' + 
                    '           <td><input type="checkbox" name="TXT_S02_DEFAULT_' + m_new_total_count + '" id="TXT_S02_DEFAULT_' + m_new_total_count + '" value="N" align="center" style="width: 50px;" onclick="check_s02_default(this);" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' +
                    '';
                
                document.getElementById("DIV_CONTACT_PERSON" + m_new_total_count).innerHTML = html_content;
                document.Form1.hid_contact_person_count.value = m_new_total_count;
            }
            
            
            function delete_contact_person(m_selected_row_number) {
                var m_flag_clear = false;
                if ((parseInt(m_selected_row_number) > 0) && (confirm('Are you sure you want to delete?'))) {
                    var m_total_count = parseInt(document.Form1.hid_contact_person_count.value);
                    document.Form1.hid_contact_person_count.value = 0;
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
                    for (var i = 1; i <= m_total_count; i++) {
                        if (i != m_selected_row_number) {
                            m_count = m_count + 1;
                            value01[m_count] = document.Form1.elements["TXT_S02_TITLE_" + i].value;
                            value02[m_count] = document.Form1.elements["TXT_S02_LAST_NAME_" + i].value;
                            value03[m_count] = document.Form1.elements["TXT_S02_INITIALS_" + i].value;
                            value04[m_count] = document.Form1.elements["TXT_S02_INITIALS_DETAILS_" + i].value;
                            value05[m_count] = document.Form1.elements["TXT_S02_DESIGNATION_" + i].value;
                            value06[m_count] = document.Form1.elements["TXT_S02_TELEPHONE_1_" + i].value;
                            value07[m_count] = document.Form1.elements["TXT_S02_TELEPHONE_2_" + i].value;
                            value08[m_count] = document.Form1.elements["TXT_S02_MOBILE_" + i].value;
                            value09[m_count] = document.Form1.elements["TXT_S02_FAX_" + i].value;
                            value10[m_count] = document.Form1.elements["TXT_S02_EMAIL_" + i].value;
                            value11[m_count] = document.Form1.elements["TXT_S02_DEFAULT_" + i].checked;
                            value12[m_count] = document.Form1.elements["TXT_S02_DEFAULT_" + i].value;
                            value13[m_count] = document.Form1.elements["TXT_S02_ADDRESS_TYPE_" + i].value;
                            value14[m_count] = document.Form1.elements["TXT_S02_ADDRESS_LINE_1_" + i].value;
                            value15[m_count] = document.Form1.elements["TXT_S02_ADDRESS_LINE_2_" + i].value;
                            value16[m_count] = document.Form1.elements["TXT_S02_CITY_" + i].value;
                            value17[m_count] = document.Form1.elements["TXT_S02_CITY_NAME_" + i].value;
                            value18[m_count] = document.Form1.elements["TXT_S02_DISTRICT_NAME_" + i].value;
                            value19[m_count] = document.Form1.elements["TXT_S02_PROVINCE_NAME_" + i].value;
                            value20[m_count] = document.Form1.elements["TXT_S02_COUNTRY_NAME_" + i].value;
                        }
                    }
                    for (var i = 1; i <= m_count; i++) {
                        add_contact_person();
                    }
                    for (var i = 1; i <= m_count; i++) {;
                        document.Form1.elements["TXT_S02_TITLE_" + i].value = value01[i];
                        document.Form1.elements["TXT_S02_LAST_NAME_" + i].value = value02[i];
                        document.Form1.elements["TXT_S02_INITIALS_" + i].value = value03[i];
                        document.Form1.elements["TXT_S02_INITIALS_DETAILS_" + i].value = value04[i];
                        document.Form1.elements["TXT_S02_DESIGNATION_" + i].value = value05[i];
                        document.Form1.elements["TXT_S02_TELEPHONE_1_" + i].value = value06[i];
                        document.Form1.elements["TXT_S02_TELEPHONE_2_" + i].value = value07[i];
                        document.Form1.elements["TXT_S02_MOBILE_" + i].value = value08[i];
                        document.Form1.elements["TXT_S02_FAX_" + i].value = value09[i];
                        document.Form1.elements["TXT_S02_EMAIL_" + i].value = value10[i];
                        document.Form1.elements["TXT_S02_DEFAULT_" + i].checked = value11[i];
                        document.Form1.elements["TXT_S02_DEFAULT_" + i].value = value12[i];
                        document.Form1.elements["TXT_S02_ADDRESS_TYPE_" + i].value= value13[i];
                        document.Form1.elements["TXT_S02_ADDRESS_LINE_1_" + i].value= value14[i];
                        document.Form1.elements["TXT_S02_ADDRESS_LINE_2_" + i].value= value15[i];
                        document.Form1.elements["TXT_S02_CITY_" + i].value= value16[i];
                        document.Form1.elements["TXT_S02_CITY_NAME_" + i].value= value17[i];
                        document.Form1.elements["TXT_S02_DISTRICT_NAME_" + i].value= value18[i];
                        document.Form1.elements["TXT_S02_PROVINCE_NAME_" + i].value= value19[i];
                        document.Form1.elements["TXT_S02_COUNTRY_NAME_" + i].value= value20[i];
                    }
                    document.Form1.hid_contact_person_count.value = m_count;
                    if (m_count == 0) {
                        m_flag_clear = true;
                    }
                }
                if (m_selected_row_number == 0) {
                    m_flag_clear = true;
                }
                if (m_flag_clear == true) {
                    document.getElementById("DIV_CONTACT_PERSON").innerHTML = '' + 
                        '   <table> ' + 
                        '       <tr> ' + 
                        '           <td class="div_input" align="center" style="width: 50px;"></td> ' + 
                        '       </tr> ' + 
                        '       <tr> ' + 
                        '           <td><input class="but_input but_input_client" type="button" name="BUT_ADD_CONTACT_PERSON" value="+" onclick="add_contact_person();" /></td> ' + 
                        '       </tr> ' + 
                        '   </table> '; 
                }
            }
            
            
            function add_directors_partners_shareholders() {
                var html_content = null;
                
                var m_new_total_count = parseInt(document.Form1.hid_directors_partners_shareholders_count.value) + 1;
                if (m_new_total_count == 1) {
                    document.getElementById("DIV_DIRECTORS_PARTNERS_SHAREHOLDERS").innerHTML = '';
                }
                createDIV('DIV_DIRECTORS_PARTNERS_SHAREHOLDERS', m_new_total_count);
                
                html_content = '' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td class="div_input" align="center" style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 75px;"><b>Title</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Last Name</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 75px;"><b>Initials</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 250px;"><b>Name Denoted by Initials</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Position</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>NIC</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '';
                
                if (m_new_total_count == 1) {
                    html_content = html_content +
                        '           <td><input class="but_input but_input_client" type="button" name="BUT_ADD_DIRECTORS_PARTNERS_SHAREHOLDERS" value="+" onclick="add_directors_partners_shareholders();" /></td> ' + 
                        '';
                }
                else {
                    html_content = html_content +
                        '           <td style="width: 50px;"></td> ' + 
                        '';
                }
                
                html_content = html_content +
                    '           <td><input class="but_input but_input_client" type="button" name="BUT_DELETE_DIRECTORS_PARTNERS_SHAREHOLDERS" value="-" onclick="delete_directors_partners_shareholders(' + m_new_total_count + ');" /></td> ' + 
                    '           <td><select class="txt_input" name="TXT_S04_TITLE_' + m_new_total_count + '" id="TXT_S04_TITLE_' + m_new_total_count + '" style="width: 75px;" /> ' + g_title_types + ' </select></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S04_LAST_NAME_' + m_new_total_count + '" id="TXT_S04_LAST_NAME_' + m_new_total_count + '" maxlength="100" style="width: 125px;" onblur="strTrim(this, null, null, \'NAME\'); strProperCase(this);" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S04_INITIALS_' + m_new_total_count + '" id="TXT_S04_INITIALS_' + m_new_total_count + '" maxlength="30" style="width: 75px;" onblur="strTrim(this);" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S04_INITIALS_DETAILS_' + m_new_total_count + '" id="TXT_S04_INITIALS_DETAILS_' + m_new_total_count + '" maxlength="400" style="width: 250px;" onblur="strTrim(this, null, null, \'NAME\'); strProperCase(this); setInitials(this, document.Form1.elements[\'TXT_S04_INITIALS_' + m_new_total_count + '\']);" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S04_POSITION_' + m_new_total_count + '" id="TXT_S04_POSITION_' + m_new_total_count + '" maxlength="50" style="width: 125px;" onblur="strTrim(this);" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S04_NIC_' + m_new_total_count + '" id="TXT_S04_NIC_' + m_new_total_count + '" maxlength="10" style="width: 125px;" onblur="validateNIC(this);" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Address Type</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Ownership</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 250px;"><b>Address Line 1</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 250px;"><b>Address Line 2</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td><select class="txt_input" name="TXT_S04_ADDRESS_TYPE_' + m_new_total_count + '" id="TXT_S04_ADDRESS_TYPE_' + m_new_total_count + '" style="width: 125px;" /> ' + g_address_types + ' </select></td> ' + 
                    '           <td><select class="txt_input" name="TXT_S04_OWNERSHIP_' + m_new_total_count + '" id="TXT_S04_OWNERSHIP_' + m_new_total_count + '" style="width: 125px;" /> ' + g_ownership_types + ' </select></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S04_ADDRESS_LINE_1_' + m_new_total_count + '" id="TXT_S04_ADDRESS_LINE_1_' + m_new_total_count + '" maxlength="100" style="width: 250px;" onblur="strTrim(this, null, null, \'ADDRESS\'); strProperCase(this);" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S04_ADDRESS_LINE_2_' + m_new_total_count + '" id="TXT_S04_ADDRESS_LINE_2_' + m_new_total_count + '" maxlength="100" style="width: 250px;" onblur="strTrim(this, null, null, \'ADDRESS\'); strProperCase(this);" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 185px;"><b>City</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>District</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Province</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Country</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td> ' + 
                    '               <input type="hidden" name="TXT_S04_CITY_' + m_new_total_count + '" id="TXT_S04_CITY_' + m_new_total_count + '" /> ' + 
                    '               <input class="txt_input" type="text" name="TXT_S04_CITY_NAME_' + m_new_total_count + '" id="TXT_S04_CITY_NAME_' + m_new_total_count + '" maxlength="50" onblur="strTrim(this); popup_help(0, \'city_4\', \'' + m_new_total_count + '\');" style="width: 125px;" /> ' + 
                    '               <input class="but_input but_input_client" type="button" name="BUT_HELP_S04_CITY" id="BUT_HELP_S04_CITY" value="..." onclick="popup_help(0, \'city_4\', \'' + m_new_total_count + '\');" />' + 
                    '           </td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S04_DISTRICT_NAME_' + m_new_total_count + '" id="TXT_S04_DISTRICT_NAME_' + m_new_total_count + '" disabled="disabled" style="width: 125px;" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S04_PROVINCE_NAME_' + m_new_total_count + '" id="TXT_S04_PROVINCE_NAME_' + m_new_total_count + '" disabled="disabled" style="width: 125px;" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S04_COUNTRY_NAME_' + m_new_total_count + '" id="TXT_S04_COUNTRY_NAME_' + m_new_total_count + '" disabled="disabled" style="width: 125px;" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Telephone 1</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Telephone 2</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Mobile</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Fax</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 175px;"><b>Email</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S04_TELEPHONE_1_' + m_new_total_count + '" id="TXT_S04_TELEPHONE_1_' + m_new_total_count + '" maxlength="14" value= "0094" style="width: 125px;" onblur="validatePhoneNumber(this, \'Telephone\');" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S04_TELEPHONE_2_' + m_new_total_count + '" id="TXT_S04_TELEPHONE_2_' + m_new_total_count + '" maxlength="14" value= "0094" style="width: 125px;" onblur="validatePhoneNumber(this, \'Telephone\');" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S04_MOBILE_' + m_new_total_count + '" id="TXT_S04_MOBILE_' + m_new_total_count + '" maxlength="14" value= "0094" style="width: 125px;" onblur="validatePhoneNumber(this, \'Mobile\');" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S04_FAX_' + m_new_total_count + '" id="TXT_S04_FAX_' + m_new_total_count + '" maxlength="14" value= "0094" style="width: 125px;" onblur="validatePhoneNumber(this, \'Fax\');" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S04_EMAIL_' + m_new_total_count + '" id="TXT_S04_EMAIL_' + m_new_total_count + '" maxlength="100" style="width: 175px;" onblur ="validateEmail(this);" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 75px;"><b>Stake (%)</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>No of Shares</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Value (Rs.)</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Guarantor Status</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 75px;"><b>Signatories</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 250px;"><b>Comments</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S04_STAKE_' + m_new_total_count + '" id="TXT_S04_STAKE_' + m_new_total_count + '" value="0.00" maxlength="6" style="width: 75px; text-align: right;" onblur="validateNumber(this, 0, 100, 2, \'number\')" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S04_NO_OF_SHARES_' + m_new_total_count + '" id="TXT_S04_NO_OF_SHARES_' + m_new_total_count + '" value="0" maxlength="13" style="width: 125px; text-align: right;" onblur="validateNumber(this, 0, 9999999999, 0, \'number\')" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S04_VALUE_' + m_new_total_count + '" id="TXT_S04_VALUE_' + m_new_total_count + '" value="0.00" maxlength="24" style="width: 125px; text-align: right;" onblur="validateNumber(this, 0, 9999999999999999.99, 2, \'number\')" /></td> ' + 
                    '           <td> ' + 
                    '               <select name="TXT_S04_GUARANTOR_STATUS_' + m_new_total_count + '" id="TXT_S04_GUARANTOR_STATUS_' + m_new_total_count + '" class="txt_input" style="width: 125px;"> ' + 
                    '                   <option value="Y" selected="selected">Yes</option> ' + 
                    '                   <option value="N">No</option> ' + 
                    '               </select> ' + 
                    '           </td> ' + 
                    '           <td> ' + 
                    '               <select name="TXT_S04_SIGNATORIES_' + m_new_total_count + '" id="TXT_S04_SIGNATORIES_' + m_new_total_count + '" class="txt_input" style="width: 75px;"> ' + 
                    '                   <option value="Y" selected="selected">Yes</option> ' + 
                    '                   <option value="N">No</option> ' + 
                    '               </select> ' + 
                    '           </td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S04_COMMENTS_' + m_new_total_count + '" id="TXT_S04_COMMENTS_' + m_new_total_count + '" maxlength="4000" style="width: 250px;" onblur="strTrim(this);" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' +
                    '';
                
                document.getElementById("DIV_DIRECTORS_PARTNERS_SHAREHOLDERS" + m_new_total_count).innerHTML = html_content;
                document.Form1.hid_directors_partners_shareholders_count.value = m_new_total_count;
            }
            
            
            function delete_directors_partners_shareholders(m_selected_row_number) {
                var m_flag_clear = false;
                if ((parseInt(m_selected_row_number) > 0) && (confirm('Are you sure you want to delete?'))) {
                    var m_total_count = parseInt(document.Form1.hid_directors_partners_shareholders_count.value);
                    document.Form1.hid_directors_partners_shareholders_count.value = 0;
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
                    var value25 = new Array();
                    var value26 = new Array();
                    for (var i = 1; i <= m_total_count; i++) {
                        if (i != m_selected_row_number) {
                            m_count = m_count + 1;
                            value01[m_count] = document.Form1.elements["TXT_S04_TITLE_" + i].value;
                            value02[m_count] = document.Form1.elements["TXT_S04_LAST_NAME_" + i].value;
                            value03[m_count] = document.Form1.elements["TXT_S04_INITIALS_" + i].value;
                            value04[m_count] = document.Form1.elements["TXT_S04_INITIALS_DETAILS_" + i].value;
                            value05[m_count] = document.Form1.elements["TXT_S04_POSITION_" + i].value;
                            value06[m_count] = document.Form1.elements["TXT_S04_NIC_" + i].value;
                            value07[m_count] = document.Form1.elements["TXT_S04_ADDRESS_TYPE_" + i].value;
                            value08[m_count] = document.Form1.elements["TXT_S04_OWNERSHIP_" + i].value;
                            value09[m_count] = document.Form1.elements["TXT_S04_ADDRESS_LINE_1_" + i].value;
                            value10[m_count] = document.Form1.elements["TXT_S04_ADDRESS_LINE_2_" + i].value;
                            value11[m_count] = document.Form1.elements["TXT_S04_CITY_" + i].value;
                            value12[m_count] = document.Form1.elements["TXT_S04_CITY_NAME_" + i].value;
                            value13[m_count] = document.Form1.elements["TXT_S04_DISTRICT_NAME_" + i].value;
                            value14[m_count] = document.Form1.elements["TXT_S04_PROVINCE_NAME_" + i].value;
                            value15[m_count] = document.Form1.elements["TXT_S04_COUNTRY_NAME_" + i].value;
                            value16[m_count] = document.Form1.elements["TXT_S04_TELEPHONE_1_" + i].value;
                            value17[m_count] = document.Form1.elements["TXT_S04_TELEPHONE_2_" + i].value;
                            value18[m_count] = document.Form1.elements["TXT_S04_MOBILE_" + i].value;
                            value19[m_count] = document.Form1.elements["TXT_S04_FAX_" + i].value;
                            value20[m_count] = document.Form1.elements["TXT_S04_EMAIL_" + i].value;
                            value21[m_count] = document.Form1.elements["TXT_S04_STAKE_" + i].value;
                            value22[m_count] = document.Form1.elements["TXT_S04_NO_OF_SHARES_" + i].value;
                            value23[m_count] = document.Form1.elements["TXT_S04_VALUE_" + i].value;
                            value24[m_count] = document.Form1.elements["TXT_S04_GUARANTOR_STATUS_" + i].value;
                            value25[m_count] = document.Form1.elements["TXT_S04_SIGNATORIES_" + i].value;
                            value26[m_count] = document.Form1.elements["TXT_S04_COMMENTS_" + i].value;
                        }
                    }
                    for (var i = 1; i <= m_count; i++) {
                        add_directors_partners_shareholders();
                    }
                    for (var i = 1; i <= m_count; i++) {;
                        document.Form1.elements["TXT_S04_TITLE_" + i].value = value01[i];
                        document.Form1.elements["TXT_S04_LAST_NAME_" + i].value = value02[i];
                        document.Form1.elements["TXT_S04_INITIALS_" + i].value = value03[i];
                        document.Form1.elements["TXT_S04_INITIALS_DETAILS_" + i].value = value04[i];
                        document.Form1.elements["TXT_S04_POSITION_" + i].value = value05[i];
                        document.Form1.elements["TXT_S04_NIC_" + i].value = value06[i];
                        document.Form1.elements["TXT_S04_ADDRESS_TYPE_" + i].value = value07[i];
                        document.Form1.elements["TXT_S04_OWNERSHIP_" + i].value = value08[i];
                        document.Form1.elements["TXT_S04_ADDRESS_LINE_1_" + i].value = value09[i];
                        document.Form1.elements["TXT_S04_ADDRESS_LINE_2_" + i].value = value10[i];
                        document.Form1.elements["TXT_S04_CITY_" + i].value = value11[i];
                        document.Form1.elements["TXT_S04_CITY_NAME_" + i].value = value12[i];
                        document.Form1.elements["TXT_S04_DISTRICT_NAME_" + i].value = value13[i];
                        document.Form1.elements["TXT_S04_PROVINCE_NAME_" + i].value = value14[i];
                        document.Form1.elements["TXT_S04_COUNTRY_NAME_" + i].value = value15[i];
                        document.Form1.elements["TXT_S04_TELEPHONE_1_" + i].value = value16[i];;
                        document.Form1.elements["TXT_S04_TELEPHONE_2_" + i].value = value17[i];;
                        document.Form1.elements["TXT_S04_MOBILE_" + i].value = value18[i];;
                        document.Form1.elements["TXT_S04_FAX_" + i].value = value19[i];;
                        document.Form1.elements["TXT_S04_EMAIL_" + i].value = value20[i];;
                        document.Form1.elements["TXT_S04_STAKE_" + i].value = value21[i];
                        document.Form1.elements["TXT_S04_NO_OF_SHARES_" + i].value = value22[i];
                        document.Form1.elements["TXT_S04_VALUE_" + i].value = value23[i];
                        document.Form1.elements["TXT_S04_GUARANTOR_STATUS_" + i].value = value24[i];
                        document.Form1.elements["TXT_S04_SIGNATORIES_" + i].value = value25[i];
                        document.Form1.elements["TXT_S04_COMMENTS_" + i].value = value26[i];
                    }
                    document.Form1.hid_directors_partners_shareholders_count.value = m_count;
                    if (m_count == 0) {
                        m_flag_clear = true;
                    }
                }
                if (m_selected_row_number == 0) {
                    m_flag_clear = true;
                }
                if (m_flag_clear == true) {
                    document.getElementById("DIV_DIRECTORS_PARTNERS_SHAREHOLDERS").innerHTML = '' + 
                        '   <table> ' + 
                        '       <tr> ' + 
                        '           <td class="div_input" align="center" style="width: 50px;"></td> ' + 
                        '       </tr> ' + 
                        '       <tr> ' + 
                        '           <td><input class="but_input but_input_client" type="button" name="BUT_ADD_DIRECTORS_PARTNERS_SHAREHOLDERS" value="+" onclick="add_directors_partners_shareholders();" /></td> ' + 
                        '       </tr> ' + 
                        '   </table> '; 
                }
            }
            
            
            function add_subsidiaries_and_associated_companies() {
                var html_content = null;
                
                var m_new_total_count = parseInt(document.Form1.hid_subsidiaries_and_associated_companies_count.value) + 1;
                if (m_new_total_count == 1) {
                    document.getElementById("DIV_SUBSIDIARIES_AND_ASSOCIATED_COMPANIES").innerHTML = '';
                }
                createDIV('DIV_SUBSIDIARIES_AND_ASSOCIATED_COMPANIES', m_new_total_count);
                
                html_content = '' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td class="div_input" align="center" style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Association</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 310px;"><b>Company Name</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 75px;"><b>Stake (%)</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Value (Rs.)</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '';
                
                if (m_new_total_count == 1) {
                    html_content = html_content +
                        '           <td><input class="but_input but_input_client" type="button" name="BUT_ADD_SUBSIDIARIES_AND_ASSOCIATED_COMPANIES" value="+" onclick="add_subsidiaries_and_associated_companies();" /></td> ' + 
                        '';
                }
                else {
                    html_content = html_content +
                        '           <td style="width: 50px;"></td> ' + 
                        '';
                }
                
                html_content = html_content +
                    '           <td><input class="but_input but_input_client" type="button" name="BUT_DELETE_SUBSIDIARIES_AND_ASSOCIATED_COMPANIES" value="-" onclick="delete_subsidiaries_and_associated_companies(' + m_new_total_count + ');" /></td> ' + 
                    '           <td><select class="txt_input" name="TXT_S05_ASSOCIATION_' + m_new_total_count + '" id="TXT_S05_ASSOCIATION_' + m_new_total_count + '" style="width: 125px;" /> ' + g_association_types + ' </select></td> ' + 
                    '           <td> ' + 
                    '               <input class="txt_input" type="text" name="TXT_S05_COMPANY_NAME_' + m_new_total_count + '" id="TXT_S05_COMPANY_NAME_' + m_new_total_count + '" maxlength="250" style="width: 250px;" onblur="strTrim(this);" /> ' + 
                    '               <input class="but_input but_input_client" type="button" name="BUT_HELP_S05_COMPANY_NAME" id="BUT_HELP_S05_COMPANY_NAME" value="..." onclick="popup_help(0, \'company_name\', \'' + m_new_total_count + '\');" /><a id="help_update_s05_company_name_' + m_new_total_count + '" style="{text-decoration: none; cursor: text;}" class="fancylink iframe" href="" > </a> ' + 
                    '           </td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S05_STAKE_' + m_new_total_count + '" id="TXT_S05_STAKE_' + m_new_total_count + '" value="0.00" maxlength="6" style="width: 75px; text-align: right;" onblur="validateNumber(this, 0, 100, 2, \'number\')" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S05_VALUE_' + m_new_total_count + '" id="TXT_S05_VALUE_' + m_new_total_count + '" value="0.00" maxlength="24" style="width: 125px; text-align: right;" onblur="validateNumber(this, 0, 9999999999999999.99, 2, \'number\')" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Telephone 1</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Telephone 2</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Mobile</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Fax</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 175px;"><b>Email</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S05_TELEPHONE_1_' + m_new_total_count + '" id="TXT_S05_TELEPHONE_1_' + m_new_total_count + '" maxlength="14" value= "0094" style="width: 125px;" onblur="validatePhoneNumber(this, \'Telephone\');" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S05_TELEPHONE_2_' + m_new_total_count + '" id="TXT_S05_TELEPHONE_2_' + m_new_total_count + '" maxlength="14" value= "0094" style="width: 125px;" onblur="validatePhoneNumber(this, \'Telephone\');" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S05_MOBILE_' + m_new_total_count + '" id="TXT_S05_MOBILE_' + m_new_total_count + '" maxlength="14" value= "0094" style="width: 125px;" onblur="validatePhoneNumber(this, \'Mobile\');" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S05_FAX_' + m_new_total_count + '" id="TXT_S05_FAX_' + m_new_total_count + '" maxlength="14" value= "0094" style="width: 125px;" onblur="validatePhoneNumber(this, \'Fax\');" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S05_EMAIL_' + m_new_total_count + '" id="TXT_S05_EMAIL_' + m_new_total_count + '" maxlength="100" style="width: 175px;" onblur ="validateEmail(this);" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 75px;"><b>Title</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Last Name</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 75px;"><b>Initials</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 250px;"><b>Name Denoted by Initials</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td><select class="txt_input" name="TXT_S05_TITLE_' + m_new_total_count + '" id="TXT_S05_TITLE_' + m_new_total_count + '" style="width: 75px;" /> ' + g_title_types + ' </select></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S05_LAST_NAME_' + m_new_total_count + '" id="TXT_S05_LAST_NAME_' + m_new_total_count + '" maxlength="100" style="width: 125px;" onblur="strTrim(this, null, null, \'NAME\'); strProperCase(this);" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S05_INITIALS_' + m_new_total_count + '" id="TXT_S05_INITIALS_' + m_new_total_count + '" maxlength="30" style="width: 75px;" onblur="strTrim(this);" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S05_INITIALS_DETAILS_' + m_new_total_count + '" id="TXT_S05_INITIALS_DETAILS_' + m_new_total_count + '" maxlength="400" style="width: 250px;" onblur="strTrim(this, null, null, \'NAME\'); strProperCase(this); setInitials(this, document.Form1.elements[\'TXT_S05_INITIALS_' + m_new_total_count + '\']);" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 250px;"><b>Business Activities</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 250px;"><b>Comments</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S05_BUSINESS_ACTIVITIES_' + m_new_total_count + '" id="TXT_S05_BUSINESS_ACTIVITIES_' + m_new_total_count + '" maxlength="100" style="width: 250px;" onblur="strTrim(this);" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S05_COMMENTS_' + m_new_total_count + '" id="TXT_S05_COMMENTS_' + m_new_total_count + '" maxlength="4000" style="width: 250px;" onblur="strTrim(this);" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' +
                    '';
                
                document.getElementById("DIV_SUBSIDIARIES_AND_ASSOCIATED_COMPANIES" + m_new_total_count).innerHTML = html_content;
                document.Form1.hid_subsidiaries_and_associated_companies_count.value = m_new_total_count;
            }
            
            
            function delete_subsidiaries_and_associated_companies(m_selected_row_number) {
                var m_flag_clear = false;
                if ((parseInt(m_selected_row_number) > 0) && (confirm('Are you sure you want to delete?'))) {
                    var m_total_count = parseInt(document.Form1.hid_subsidiaries_and_associated_companies_count.value);
                    document.Form1.hid_subsidiaries_and_associated_companies_count.value = 0;
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
                    for (var i = 1; i <= m_total_count; i++) {
                        if (i != m_selected_row_number) {
                            m_count = m_count + 1;
                            value01[m_count] = document.Form1.elements["TXT_S05_ASSOCIATION_" + i].value;
                            value02[m_count] = document.Form1.elements["TXT_S05_COMPANY_NAME_" + i].value;
                            value03[m_count] = document.Form1.elements["TXT_S05_STAKE_" + i].value;
                            value04[m_count] = document.Form1.elements["TXT_S05_VALUE_" + i].value;
                            value05[m_count] = document.Form1.elements["TXT_S05_TELEPHONE_1_" + i].value;
                            value06[m_count] = document.Form1.elements["TXT_S05_TELEPHONE_2_" + i].value;
                            value07[m_count] = document.Form1.elements["TXT_S05_MOBILE_" + i].value;
                            value08[m_count] = document.Form1.elements["TXT_S05_FAX_" + i].value;
                            value09[m_count] = document.Form1.elements["TXT_S05_EMAIL_" + i].value;
                            value10[m_count] = document.Form1.elements["TXT_S05_TITLE_" + i].value;
                            value11[m_count] = document.Form1.elements["TXT_S05_LAST_NAME_" + i].value;
                            value12[m_count] = document.Form1.elements["TXT_S05_INITIALS_" + i].value;
                            value13[m_count] = document.Form1.elements["TXT_S05_INITIALS_DETAILS_" + i].value;
                            value14[m_count] = document.Form1.elements["TXT_S05_BUSINESS_ACTIVITIES_" + i].value;
                            value15[m_count] = document.Form1.elements["TXT_S05_COMMENTS_" + i].value;
                        }
                    }
                    for (var i = 1; i <= m_count; i++) {
                        add_subsidiaries_and_associated_companies();
                    }
                    for (var i = 1; i <= m_count; i++) {;
                        document.Form1.elements["TXT_S05_ASSOCIATION_" + i].value = value01[i];
                        document.Form1.elements["TXT_S05_COMPANY_NAME_" + i].value = value02[i];
                        document.Form1.elements["TXT_S05_STAKE_" + i].value = value03[i];
                        document.Form1.elements["TXT_S05_VALUE_" + i].value = value04[i];
                        document.Form1.elements["TXT_S05_TELEPHONE_1_" + i].value = value05[i];
                        document.Form1.elements["TXT_S05_TELEPHONE_2_" + i].value = value06[i];
                        document.Form1.elements["TXT_S05_MOBILE_" + i].value = value07[i];
                        document.Form1.elements["TXT_S05_FAX_" + i].value = value08[i];
                        document.Form1.elements["TXT_S05_EMAIL_" + i].value = value09[i];
                        document.Form1.elements["TXT_S05_TITLE_" + i].value = value10[i];
                        document.Form1.elements["TXT_S05_LAST_NAME_" + i].value = value11[i];
                        document.Form1.elements["TXT_S05_INITIALS_" + i].value = value12[i];
                        document.Form1.elements["TXT_S05_INITIALS_DETAILS_" + i].value = value13[i];
                        document.Form1.elements["TXT_S05_BUSINESS_ACTIVITIES_" + i].value = value14[i];
                        document.Form1.elements["TXT_S05_COMMENTS_" + i].value = value15[i];
                    }
                    document.Form1.hid_subsidiaries_and_associated_companies_count.value = m_count;
                    if (m_count == 0) {
                        m_flag_clear = true;
                    }
                }
                if (m_selected_row_number == 0) {
                    m_flag_clear = true;
                }
                if (m_flag_clear == true) {
                    document.getElementById("DIV_SUBSIDIARIES_AND_ASSOCIATED_COMPANIES").innerHTML = '' + 
                        '   <table> ' + 
                        '       <tr> ' + 
                        '           <td class="div_input" align="center" style="width: 50px;"></td> ' + 
                        '       </tr> ' + 
                        '       <tr> ' + 
                        '           <td><input class="but_input but_input_client" type="button" name="BUT_ADD_SUBSIDIARIES_AND_ASSOCIATED_COMPANIES" value="+" onclick="add_subsidiaries_and_associated_companies();" /></td> ' + 
                        '       </tr> ' + 
                        '   </table> '; 
                }
            }
            
            
            function add_auditors_details() {
                var html_content = null;
                
                var m_new_total_count = parseInt(document.Form1.hid_auditors_details_count.value) + 1;
                if (m_new_total_count == 1) {
                    document.getElementById("DIV_AUDITORS_DETAILS").innerHTML = '';
                }
                createDIV('DIV_AUDITORS_DETAILS', m_new_total_count);
                
                html_content = '' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td class="div_input" align="center" style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 350px;"><div id="DIV_TXT_S06_COMPANY_NAME_' + m_new_total_count + '"><b>Company Name</b></div></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '';
                
                if (m_new_total_count == 1) {
                    html_content = html_content +
                        '           <td><input class="but_input but_input_client" type="button" name="BUT_ADD_AUDITORS_DETAILS" value="+" onclick="add_auditors_details();" /></td> ' + 
                        '';
                }
                else {
                    html_content = html_content +
                        '           <td style="width: 50px;"></td> ' + 
                        '';
                }
                
                html_content = html_content +
                    '           <td><input class="but_input but_input_client" type="button" name="BUT_DELETE_AUDITORS_DETAILS" value="-" onclick="delete_auditors_details(' + m_new_total_count + ');" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S06_COMPANY_NAME_' + m_new_total_count + '" id="TXT_S06_COMPANY_NAME_' + m_new_total_count + '" maxlength="100" style="width: 350px;" onblur="strTrim(this, null, null, \'NAME\'); strProperCase(this);" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 75px;"><b>Title</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Last Name</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 75px;"><b>Initials</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 250px;"><b>Name Denoted by Initials</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td><select class="txt_input" name="TXT_S06_TITLE_' + m_new_total_count + '" id="TXT_S06_TITLE_' + m_new_total_count + '" style="width: 75px;" /> ' + g_title_types + ' </select></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S06_LAST_NAME_' + m_new_total_count + '" id="TXT_S06_LAST_NAME_' + m_new_total_count + '" maxlength="100" style="width: 125px;" onblur="strTrim(this, null, null, \'NAME\'); strProperCase(this);" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S06_INITIALS_' + m_new_total_count + '" id="TXT_S06_INITIALS_' + m_new_total_count + '" maxlength="30" style="width: 75px;" onblur="strTrim(this);" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S06_INITIALS_DETAILS_' + m_new_total_count + '" id="TXT_S06_INITIALS_DETAILS_' + m_new_total_count + '" maxlength="400" style="width: 250px;" onblur="strTrim(this, null, null, \'NAME\'); strProperCase(this); setInitials(this, document.Form1.elements[\'TXT_S06_INITIALS_' + m_new_total_count + '\']);" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Address Type</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Ownership</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 250px;"><b>Address Line 1</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 250px;"><b>Address Line 2</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td><select class="txt_input" name="TXT_S06_ADDRESS_TYPE_' + m_new_total_count + '" id="TXT_S06_ADDRESS_TYPE_' + m_new_total_count + '" style="width: 125px;" /> ' + g_address_types + ' </select></td> ' + 
                    '           <td><select class="txt_input" name="TXT_S06_OWNERSHIP_' + m_new_total_count + '" id="TXT_S06_OWNERSHIP_' + m_new_total_count + '" style="width: 125px;" /> ' + g_ownership_types + ' </select></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S06_ADDRESS_LINE_1_' + m_new_total_count + '" id="TXT_S06_ADDRESS_LINE_1_' + m_new_total_count + '" maxlength="100" style="width: 250px;" onblur="strTrim(this, null, null, \'ADDRESS\'); strProperCase(this);" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S06_ADDRESS_LINE_2_' + m_new_total_count + '" id="TXT_S06_ADDRESS_LINE_2_' + m_new_total_count + '" maxlength="100" style="width: 250px;" onblur="strTrim(this, null, null, \'ADDRESS\'); strProperCase(this);" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 185px;"><b>City</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>District</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Province</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Country</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td> ' + 
                    '               <input type="hidden" name="TXT_S06_CITY_' + m_new_total_count + '" id="TXT_S06_CITY_' + m_new_total_count + '" /> ' + 
                    '               <input class="txt_input" type="text" name="TXT_S06_CITY_NAME_' + m_new_total_count + '" id="TXT_S06_CITY_NAME_' + m_new_total_count + '" maxlength="50" onblur="strTrim(this); popup_help(0, \'city_5\', \'' + m_new_total_count + '\');" style="width: 125px;" /> ' + 
                    '               <input class="but_input but_input_client" type="button" name="BUT_HELP_S06_CITY" value="..." id="BUT_HELP_S06_CITY" value="..." onclick="popup_help(0, \'city_5\', \'' + m_new_total_count + '\');" />' + 
                    '           </td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S06_DISTRICT_NAME_' + m_new_total_count + '" id="TXT_S06_DISTRICT_NAME_' + m_new_total_count + '" disabled="disabled" style="width: 125px;" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S06_PROVINCE_NAME_' + m_new_total_count + '" id="TXT_S06_PROVINCE_NAME_' + m_new_total_count + '" disabled="disabled" style="width: 125px;" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S06_COUNTRY_NAME_' + m_new_total_count + '" id="TXT_S06_COUNTRY_NAME_' + m_new_total_count + '" disabled="disabled" style="width: 125px;" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Telephone 1</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Telephone 2</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Mobile</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Fax</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 175px;"><b>Email</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S06_TELEPHONE_1_' + m_new_total_count + '" id="TXT_S06_TELEPHONE_1_' + m_new_total_count + '" maxlength="14" value= "0094" style="width: 125px;" onblur="validatePhoneNumber(this, \'Telephone\');" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S06_TELEPHONE_2_' + m_new_total_count + '" id="TXT_S06_TELEPHONE_2_' + m_new_total_count + '" maxlength="14" value= "0094" style="width: 125px;" onblur="validatePhoneNumber(this, \'Telephone\');" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S06_MOBILE_' + m_new_total_count + '" id="TXT_S06_MOBILE_' + m_new_total_count + '" maxlength="14" value= "0094" style="width: 125px;" onblur="validatePhoneNumber(this, \'Mobile\');" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S06_FAX_' + m_new_total_count + '" id="TXT_S06_FAX_' + m_new_total_count + '" maxlength="14" value= "0094" style="width: 125px;" onblur="validatePhoneNumber(this, \'Fax\');" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S06_EMAIL_' + m_new_total_count + '" id="TXT_S06_EMAIL_' + m_new_total_count + '" maxlength="100" style="width: 175px;" onblur ="validateEmail(this);" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Relationship (Yrs)</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 250px;"><b>Reference</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 100px;"><b>Auditor Details</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S06_RELATIONSHIP_' + m_new_total_count + '" id="TXT_S06_RELATIONSHIP_' + m_new_total_count + '" value="0.0" maxlength="5" style="width: 125px; text-align: right;" onblur="validateNumber(this, 0, 999.9, 1, \'number\')" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S06_REFERENCE_' + m_new_total_count + '" id="TXT_S06_REFERENCE_' + m_new_total_count + '" maxlength="100" style="width: 250px;" onblur="strTrim(this);" /></td> ' + 
                    '           <td> ' + 
                    '               <input type="hidden" name="TXT_S06_AUDITOR_DETAILS_' + m_new_total_count + '" id="TXT_S06_AUDITOR_DETAILS_' + m_new_total_count + '" value="' + g_auditor_string + '" /> ' + 
                    '               <input class="but_input but_input_client" type="button" id="BUT_S06_AUDITOR_DETAILS_' + m_new_total_count + '" name="BUT_S06_AUDITOR_DETAILS_' + m_new_total_count + '" value="Details" style="width: 100px;" onclick="openAuditorDetails(' + m_new_total_count + ');" /> ' + 
                    '           </td> ' + 
                    '       </tr> ' + 
                    '   </table> ' +
                    '';
                
                document.getElementById("DIV_AUDITORS_DETAILS" + m_new_total_count).innerHTML = html_content;
                document.Form1.hid_auditors_details_count.value = m_new_total_count;
            }
            
            
            function delete_auditors_details(m_selected_row_number) {
                var m_flag_clear = false;
                if ((parseInt(m_selected_row_number) > 0) && (confirm('Are you sure you want to delete?'))) {
                    var m_total_count = parseInt(document.Form1.hid_auditors_details_count.value);
                    document.Form1.hid_auditors_details_count.value = 0;
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
                    for (var i = 1; i <= m_total_count; i++) {
                        if (i != m_selected_row_number) {
                            m_count = m_count + 1;
                            value01[m_count] = document.Form1.elements["TXT_S06_TITLE_" + i].value;
                            value02[m_count] = document.Form1.elements["TXT_S06_LAST_NAME_" + i].value;
                            value03[m_count] = document.Form1.elements["TXT_S06_INITIALS_" + i].value;
                            value04[m_count] = document.Form1.elements["TXT_S06_INITIALS_DETAILS_" + i].value;
                            value05[m_count] = document.Form1.elements["TXT_S06_ADDRESS_TYPE_" + i].value;
                            value06[m_count] = document.Form1.elements["TXT_S06_OWNERSHIP_" + i].value;
                            value07[m_count] = document.Form1.elements["TXT_S06_ADDRESS_LINE_1_" + i].value;
                            value08[m_count] = document.Form1.elements["TXT_S06_ADDRESS_LINE_2_" + i].value;
                            value09[m_count] = document.Form1.elements["TXT_S06_CITY_" + i].value;
                            value10[m_count] = document.Form1.elements["TXT_S06_CITY_NAME_" + i].value;
                            value11[m_count] = document.Form1.elements["TXT_S06_DISTRICT_NAME_" + i].value;
                            value12[m_count] = document.Form1.elements["TXT_S06_PROVINCE_NAME_" + i].value;
                            value13[m_count] = document.Form1.elements["TXT_S06_COUNTRY_NAME_" + i].value;
                            value14[m_count] = document.Form1.elements["TXT_S06_TELEPHONE_1_" + i].value;
                            value15[m_count] = document.Form1.elements["TXT_S06_TELEPHONE_2_" + i].value;
                            value16[m_count] = document.Form1.elements["TXT_S06_MOBILE_" + i].value;
                            value17[m_count] = document.Form1.elements["TXT_S06_FAX_" + i].value;
                            value18[m_count] = document.Form1.elements["TXT_S06_EMAIL_" + i].value;
                            value19[m_count] = document.Form1.elements["TXT_S06_RELATIONSHIP_" + i].value;
                            value20[m_count] = document.Form1.elements["TXT_S06_REFERENCE_" + i].value;
                            value21[m_count] = document.Form1.elements["TXT_S06_AUDITOR_DETAILS_" + i].value;
                            value22[m_count] = document.Form1.elements["TXT_S06_COMPANY_NAME_" + i].value;
                        }
                    }
                    for (var i = 1; i <= m_count; i++) {
                        add_auditors_details();
                    }
                    for (var i = 1; i <= m_count; i++) {;
                        document.Form1.elements["TXT_S06_TITLE_" + i].value = value01[i];
                        document.Form1.elements["TXT_S06_LAST_NAME_" + i].value = value02[i];
                        document.Form1.elements["TXT_S06_INITIALS_" + i].value = value03[i];
                        document.Form1.elements["TXT_S06_INITIALS_DETAILS_" + i].value = value04[i];
                        document.Form1.elements["TXT_S06_ADDRESS_TYPE_" + i].value = value05[i];
                        document.Form1.elements["TXT_S06_OWNERSHIP_" + i].value = value06[i];
                        document.Form1.elements["TXT_S06_ADDRESS_LINE_1_" + i].value = value07[i];
                        document.Form1.elements["TXT_S06_ADDRESS_LINE_2_" + i].value = value08[i];
                        document.Form1.elements["TXT_S06_CITY_" + i].value = value09[i];
                        document.Form1.elements["TXT_S06_CITY_NAME_" + i].value = value10[i];
                        document.Form1.elements["TXT_S06_DISTRICT_NAME_" + i].value = value11[i];
                        document.Form1.elements["TXT_S06_PROVINCE_NAME_" + i].value = value12[i];
                        document.Form1.elements["TXT_S06_COUNTRY_NAME_" + i].value = value13[i];
                        document.Form1.elements["TXT_S06_TELEPHONE_1_" + i].value = value14[i];
                        document.Form1.elements["TXT_S06_TELEPHONE_2_" + i].value = value15[i];
                        document.Form1.elements["TXT_S06_MOBILE_" + i].value = value16[i];
                        document.Form1.elements["TXT_S06_FAX_" + i].value = value17[i];
                        document.Form1.elements["TXT_S06_EMAIL_" + i].value = value18[i];
                        document.Form1.elements["TXT_S06_RELATIONSHIP_" + i].value = value19[i];
                        document.Form1.elements["TXT_S06_REFERENCE_" + i].value = value20[i];
                        document.Form1.elements["TXT_S06_AUDITOR_DETAILS_" + i].value = value21[i];
                        document.Form1.elements["TXT_S06_COMPANY_NAME_" + i].value = value22[i];
                    }
                    document.Form1.hid_auditors_details_count.value = m_count;
                    if (m_count == 0) {
                        m_flag_clear = true;
                    }
                }
                if (m_selected_row_number == 0) {
                    m_flag_clear = true;
                }
                if (m_flag_clear == true) {
                    document.getElementById("DIV_AUDITORS_DETAILS").innerHTML = '' + 
                        '   <table> ' + 
                        '       <tr> ' + 
                        '           <td class="div_input" align="center" style="width: 50px;"></td> ' + 
                        '       </tr> ' + 
                        '       <tr> ' + 
                        '           <td><input class="but_input but_input_client" type="button" name="BUT_ADD_SUBSIDIARIES_AND_ASSOCIATED_COMPANIES" value="+" onclick="add_auditors_details();" /></td> ' + 
                        '       </tr> ' + 
                        '   </table> '; 
                }
            }
            
            
            function add_accounts_and_banking_details() {
                var html_content = null;
                
                var m_new_total_count = parseInt(document.Form1.hid_accounts_and_banking_details_count.value) + 1;
                if (m_new_total_count == 1) {
                    document.getElementById("DIV_ACCOUNTS_AND_BANKING_DETAILS").innerHTML = '';
                };
                createDIV('DIV_ACCOUNTS_AND_BANKING_DETAILS', m_new_total_count);
                
                html_content = '' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td class="div_input" align="center" style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><div id="DIV_TXT_S07_BANK_NAME_' + m_new_total_count + '"><b>Bank Name</b></div></td> ' + 
                    '           <td class="div_input" align="center" style="width: 185px;"><div id="DIV_TXT_S07_BRANCH_NAME_' + m_new_total_count + '"><b>Branch Name</b></div></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Account Type</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><div id="DIV_TXT_S07_ACCOUNT_NO_' + m_new_total_count + '"><b>Account No</b></div></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Account Name</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '';
                
                if (m_new_total_count == 1) {
                    html_content = html_content +
                        '           <td><input class="but_input but_input_client" type="button" name="BUT_ADD_ACCOUNTS_AND_BANKING_DETAILS" value="+" onclick="add_accounts_and_banking_details();" /></td> ' + 
                        '';
                }
                else {
                    html_content = html_content +
                        '           <td style="width: 50px;"></td> ' + 
                        '';
                }
                
                html_content = html_content +
                    '           <td><input class="but_input but_input_client" type="button" name="BUT_DELETE_ACCOUNTS_AND_BANKING_DETAILS" value="-" onclick="delete_accounts_and_banking_details(' + m_new_total_count + ');" /></td> ' + 
                    '           <td> ' + 
                    // '               <input type="hidden" name="TXT_S07_BANK_' + m_new_total_count + '" /> ' + 
                    '               <input class="txt_input" type="text" name="TXT_S07_BANK_NAME_' + m_new_total_count + '" id="TXT_S07_BANK_NAME_' + m_new_total_count + '" maxlength="50" style="width: 125px;" disabled="disabled" /> ' + 
                    // '               <input class="but_input but_input_client" type="button" name="BUT_HELP_S07_BANK" value="..." onclick="help_update_s07_bank_name(\'help_update_s07_bank_name_' + m_new_total_count + '\', ' + '\'' + m_new_total_count + '\');" /><a id="help_update_s07_bank_name_' + m_new_total_count + '" style="{text-decoration: none; cursor: text;}" class="fancylink iframe" href="" > </a> ' + 
                    '           </td> ' + 
                    '           <td> ' + 
                    '               <input type="hidden" name="TXT_S07_BRANCH_' + m_new_total_count + '" id="TXT_S07_BRANCH_' + m_new_total_count + '" /> ' + 
                    '               <input class="txt_input" type="text" name="TXT_S07_BRANCH_NAME_' + m_new_total_count + '" id="TXT_S07_BRANCH_NAME_' + m_new_total_count + '" maxlength="50" onblur="strTrim(this); popup_help(0, \'bank_branch\', \'' + m_new_total_count + '\');" style="width: 125px;" /> ' + 
                    '               <input class="but_input but_input_client" type="button" name="BUT_HELP_S07_BRANCH" id="BUT_HELP_S07_BRANCH" value="..." onclick="popup_help(0, \'bank_branch\', \'' + m_new_total_count + '\');" />' + 
                    '           </td> ' + 
                    '           <td><select class="txt_input" name="TXT_S07_ACCOUNT_TYPE_' + m_new_total_count + '" style="width: 125px;" /> ' + g_account_types + ' </select></td> ' + 
                    // '           <td><input class="txt_input" type="text" name="TXT_S07_ACCOUNT_NO_' + m_new_total_count + '" id="TXT_S07_ACCOUNT_NO_' + m_new_total_count + '" maxlength="20" style="width: 125px;" onblur="strTrim(this);checkBankAccount(' + m_new_total_count + ');" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S07_ACCOUNT_NO_' + m_new_total_count + '" id="TXT_S07_ACCOUNT_NO_' + m_new_total_count + '" maxlength="20" style="width: 125px;" onblur="strTrim(this);" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S07_ACCOUNT_NAME_' + m_new_total_count + '" id="TXT_S07_ACCOUNT_NAME_' + m_new_total_count + '" maxlength="200" style="width: 125px;" onblur="strTrim(this);" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 175px;"><b>Start Date</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Branch Tel. No.</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Branch Fax No.</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 250px;"><b>Branch Reference</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Relation (Yrs.)</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td align="center"> ' + 
                    '               <input class="txt_input5" type="text" name="TXT_S07_START_DATE_DD_' + m_new_total_count + '" id="TXT_S07_START_DATE_DD_' + m_new_total_count + '" maxlength="2" size="2" onblur="checkMonthLength1(document.Form1.elements[\'TXT_S07_START_DATE_DD_' + m_new_total_count + '\'], document.Form1.elements[\'TXT_S07_START_DATE_MM_' + m_new_total_count + '\'], document.Form1.elements[\'TXT_S07_START_DATE_YY_' + m_new_total_count + '\'], document.Form1.elements[\'TXT_S07_START_DATE_' + m_new_total_count + '\'], \'D\', \'Y\', g_sysdate, \'no future\');" /> ' + 
                    '               <input class="txt_input5" type="text" name="TXT_S07_START_DATE_MM_' + m_new_total_count + '" id="TXT_S07_START_DATE_MM_' + m_new_total_count + '"maxlength="2" size="2" onblur="checkMonthLength1(document.Form1.elements[\'TXT_S07_START_DATE_DD_' + m_new_total_count + '\'], document.Form1.elements[\'TXT_S07_START_DATE_MM_' + m_new_total_count + '\'], document.Form1.elements[\'TXT_S07_START_DATE_YY_' + m_new_total_count + '\'], document.Form1.elements[\'TXT_S07_START_DATE_' + m_new_total_count + '\'], \'M\', \'Y\', g_sysdate, \'no future\');" /> ' + 
                    '               <input class="txt_input5" type="text" name="TXT_S07_START_DATE_YY_' + m_new_total_count + '" id="TXT_S07_START_DATE_YY_' + m_new_total_count + '"maxlength="4" size="4" onblur="checkMonthLength1(document.Form1.elements[\'TXT_S07_START_DATE_DD_' + m_new_total_count + '\'], document.Form1.elements[\'TXT_S07_START_DATE_MM_' + m_new_total_count + '\'], document.Form1.elements[\'TXT_S07_START_DATE_YY_' + m_new_total_count + '\'], document.Form1.elements[\'TXT_S07_START_DATE_' + m_new_total_count + '\'], \'Y\', \'Y\', g_sysdate, \'no future\');" /> ' + 
                    '               <input type="hidden" name="TXT_S07_START_DATE_' + m_new_total_count + '" id="TXT_S07_START_DATE_' + m_new_total_count + '" /> ' + 
                    '           </td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S07_BRANCH_TEL_NO_' + m_new_total_count + '" id="TXT_S07_BRANCH_TEL_NO_' + m_new_total_count + '" maxlength="14" value= "0094" style="width: 125px;" onblur="validatePhoneNumber(this, \'Telephone\');" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S07_BRANCH_FAX_NO_' + m_new_total_count + '" id="TXT_S07_BRANCH_FAX_NO_' + m_new_total_count + '" maxlength="14" value= "0094" style="width: 125px;" onblur="validatePhoneNumber(this, \'Fax\');" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S07_BRANCH_REFERENCE_' + m_new_total_count + '" id="TXT_S07_BRANCH_REFERENCE_' + m_new_total_count + '" maxlength="300" style="width: 250px;" onblur="strTrim(this);" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S07_RELATION_' + m_new_total_count + '" id="TXT_S07_RELATION_' + m_new_total_count + '" value="0.0" maxlength="5" style="width: 125px; text-align: right;" onblur="validateNumber(this, 0, 999.9, 1, \'number\')" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 250px;"><b>Comments</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 250px;"><b>Performance</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S07_COMMENTS_' + m_new_total_count + '" id="TXT_S07_COMMENTS_' + m_new_total_count + '" maxlength="4000" style="width: 250px;" onblur="strTrim(this, null, null, \'COMMENT\');" /></td> ' + 
                    '           <td><input class="TXT_S07_PERFORMANCE_' + m_new_total_count + ' txt_input" type="file" id="TXT_S07_PERFORMANCE_' + m_new_total_count + '" name="TXT_S07_PERFORMANCE_' + m_new_total_count + '" style="width: 250px;" onchange=set_file_val("TXT_S07_PERFORMANCE_' + m_new_total_count + '"); onMouseOut=set_file_val("TXT_S07_PERFORMANCE_' + m_new_total_count + '"); /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' +
                    '';
                
                document.getElementById("DIV_ACCOUNTS_AND_BANKING_DETAILS" + m_new_total_count).innerHTML = html_content;
                document.Form1.hid_accounts_and_banking_details_count.value = m_new_total_count;
                
                init_filestyle('TXT_S07_PERFORMANCE_' + m_new_total_count);
                initCal('TXT_S07_START_DATE_' + m_new_total_count);
            }
            
            
            function delete_accounts_and_banking_details(m_selected_row_number) {
                var m_flag_clear = false;
                if ((parseInt(m_selected_row_number) > 0) && (confirm('Are you sure you want to delete?'))) {
                    var m_total_count = parseInt(document.Form1.hid_accounts_and_banking_details_count.value);
                    document.Form1.hid_accounts_and_banking_details_count.value = 0;
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
                    for (var i = 1; i <= m_total_count; i++) {
                        if (i != m_selected_row_number) {
                            m_count = m_count + 1;
                            value01[m_count] = document.Form1.elements["TXT_S07_BANK_" + i].value;
                            value02[m_count] = document.Form1.elements["TXT_S07_BANK_NAME_" + i].value;
                            value03[m_count] = document.Form1.elements["TXT_S07_BRANCH_" + i].value;
                            value04[m_count] = document.Form1.elements["TXT_S07_BRANCH_NAME_" + i].value;
                            value05[m_count] = document.Form1.elements["TXT_S07_ACCOUNT_TYPE_" + i].value;
                            value06[m_count] = document.Form1.elements["TXT_S07_ACCOUNT_NO_" + i].value;
                            value07[m_count] = document.Form1.elements["TXT_S07_ACCOUNT_NAME_" + i].value;
                            value08[m_count] = document.Form1.elements["TXT_S07_START_DATE_" + i].value;
                            value09[m_count] = document.Form1.elements["TXT_S07_START_DATE_DD_" + i].value;
                            value10[m_count] = document.Form1.elements["TXT_S07_START_DATE_MM_" + i].value;
                            value11[m_count] = document.Form1.elements["TXT_S07_START_DATE_YY_" + i].value;
                            value12[m_count] = document.Form1.elements["TXT_S07_BRANCH_TEL_NO_" + i].value;
                            value13[m_count] = document.Form1.elements["TXT_S07_BRANCH_FAX_NO_" + i].value;
                            value14[m_count] = document.Form1.elements["TXT_S07_BRANCH_REFERENCE_" + i].value;
                            value15[m_count] = document.Form1.elements["TXT_S07_RELATION_" + i].value;
                            value16[m_count] = document.Form1.elements["TXT_S07_PERFORMANCE_" + i].value;
                            value17[m_count] = document.Form1.elements["TXT_S07_COMMENTS_" + i].value;
                        }
                    }
                    for (var i = 1; i <= m_count; i++) {
                        add_accounts_and_banking_details();
                    }
                    for (var i = 1; i <= m_count; i++) {;
                        document.Form1.elements["TXT_S07_BANK_" + i].value = value01[i];
                        document.Form1.elements["TXT_S07_BANK_NAME_" + i].value = value02[i];
                        document.Form1.elements["TXT_S07_BRANCH_" + i].value = value03[i];
                        document.Form1.elements["TXT_S07_BRANCH_NAME_" + i].value = value04[i];
                        document.Form1.elements["TXT_S07_ACCOUNT_TYPE_" + i].value = value05[i];
                        document.Form1.elements["TXT_S07_ACCOUNT_NO_" + i].value = value06[i];
                        document.Form1.elements["TXT_S07_ACCOUNT_NAME_" + i].value = value07[i];
                        document.Form1.elements["TXT_S07_START_DATE_" + i].value = value08[i];
                        document.Form1.elements["TXT_S07_START_DATE_DD_" + i].value = value09[i];
                        document.Form1.elements["TXT_S07_START_DATE_MM_" + i].value = value10[i];
                        document.Form1.elements["TXT_S07_START_DATE_YY_" + i].value = value11[i];
                        document.Form1.elements["TXT_S07_BRANCH_TEL_NO_" + i].value = value12[i];
                        document.Form1.elements["TXT_S07_BRANCH_FAX_NO_" + i].value = value13[i];
                        document.Form1.elements["TXT_S07_BRANCH_REFERENCE_" + i].value = value14[i];
                        document.Form1.elements["TXT_S07_RELATION_" + i].value = value15[i];
                        document.Form1.elements["TXT_S07_PERFORMANCE_" + i].value = value16[i];
                        document.Form1.elements["TXT_S07_COMMENTS_" + i].value = value17[i];
                    }
                    document.Form1.hid_accounts_and_banking_details_count.value = m_count;
                    if (m_count == 0) {
                       m_flag_clear = true;
                    }
                }
                if (m_selected_row_number == 0) {
                    m_flag_clear = true;
                }
                if (m_flag_clear == true) {
                    document.getElementById("DIV_ACCOUNTS_AND_BANKING_DETAILS").innerHTML = '' + 
                        '   <table> ' + 
                        '       <tr> ' + 
                        '           <td class="div_input" align="center" style="width: 50px;"></td> ' + 
                        '       </tr> ' + 
                        '       <tr> ' + 
                        '           <td><input class="but_input but_input_client" type="button" name="BUT_ADD_ACCOUNTS_AND_BANKING_DETAILS" value="+" onclick="add_accounts_and_banking_details();" /></td> ' + 
                        '       </tr> ' + 
                        '   </table> '; 
                }
            }
            
            
            function add_details_of_credit_facilities() {
                var html_content = null;
                var m_new_total_count = parseInt(document.Form1.hid_details_of_credit_facilities_count.value) + 1;
                
                if (m_new_total_count == 1) {
                   document.getElementById("DIV_DETAILS_OF_CREDIT_FACILITIES").innerHTML = '';
                }
                createDIV('DIV_DETAILS_OF_CREDIT_FACILITIES', m_new_total_count);
                
                html_content = '' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td class="div_input" align="center" style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 175px;"><b>Institution Name</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 75px;"><b>Title</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Last Name</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 75px;"><b>Initials</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 250px;"><b>Name Denoted by Initials</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '';
                
                if (m_new_total_count == 1) {
                    html_content = html_content +
                        '           <td><input class="but_input but_input_client" type="button" name="BUT_ADD_DETAILS_OF_CREDIT_FACILITIES" value="+" onclick="add_details_of_credit_facilities();" /></td> ' + 
                        '';
                }
                else {
                    html_content = html_content +
                        '           <td style="width: 50px;"></td> ' + 
                        '';
                }
                
                html_content = html_content +
                    '           <td><input class="but_input but_input_client" type="button" name="BUT_DELETE_DETAILS_OF_CREDIT_FACILITIES" value="-" onclick="delete_details_of_credit_facilities(' + m_new_total_count + ');" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S08_INSTITUTION_NAME_' + m_new_total_count + '" id="TXT_S08_INSTITUTION_NAME_' + m_new_total_count + '" maxlength="100" style="width: 175px;" onblur="strTrim(this);" /></td> ' + 
                    '           <td><select class="txt_input" name="TXT_S08_TITLE_' + m_new_total_count + '" id="TXT_S08_TITLE_' + m_new_total_count + '" style="width: 75px;" /> ' + g_title_types + ' </select></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S08_LAST_NAME_' + m_new_total_count + '" id="TXT_S08_LAST_NAME_' + m_new_total_count + '" maxlength="100" style="width: 125px;" onblur="strTrim(this, null, null, \'NAME\'); strProperCase(this);" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S08_INITIALS_' + m_new_total_count + '" id="TXT_S08_INITIALS_' + m_new_total_count + '" maxlength="30" style="width: 75px;" onblur="strTrim(this);" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S08_INITIALS_DETAILS_' + m_new_total_count + '" id="TXT_S08_INITIALS_DETAILS_' + m_new_total_count + '" maxlength="400" style="width: 250px;" onblur="strTrim(this, null, null, \'NAME\'); strProperCase(this); setInitials(this, document.Form1.elements[\'TXT_S08_INITIALS_' + m_new_total_count + '\']);" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Address Type</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Ownership</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 250px;"><b>Address Line 1</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 250px;"><b>Address Line 2</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td><select class="txt_input" name="TXT_S08_ADDRESS_TYPE_' + m_new_total_count + '" id="TXT_S08_ADDRESS_TYPE_' + m_new_total_count + '" style="width: 125px;" /> ' + g_address_types + ' </select></td> ' + 
                    '           <td><select class="txt_input" name="TXT_S08_OWNERSHIP_' + m_new_total_count + '" id="TXT_S08_OWNERSHIP_' + m_new_total_count + '" style="width: 125px;" /> ' + g_ownership_types + ' </select></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S08_ADDRESS_LINE_1_' + m_new_total_count + '" id="TXT_S08_ADDRESS_LINE_1_' + m_new_total_count + '" maxlength="100" style="width: 250px;" onblur="strTrim(this, null, null, \'ADDRESS\'); strProperCase(this);" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S08_ADDRESS_LINE_2_' + m_new_total_count + '" id="TXT_S08_ADDRESS_LINE_2_' + m_new_total_count + '" maxlength="100" style="width: 250px;" onblur="strTrim(this, null, null, \'ADDRESS\'); strProperCase(this);" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 185px;"><b>City</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>District</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Province</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Country</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td> ' + 
                    '               <input type="hidden" name="TXT_S08_CITY_' + m_new_total_count + '" id="TXT_S08_CITY_' + m_new_total_count + '" /> ' + 
                    '               <input class="txt_input" type="text" name="TXT_S08_CITY_NAME_' + m_new_total_count + '" id="TXT_S08_CITY_NAME_' + m_new_total_count + '" maxlength="50" onblur="strTrim(this); popup_help(0, \'city_6\', \'' + m_new_total_count + '\');" style="width: 125px;" /> ' + 
                    '               <input class="but_input but_input_client" type="button" name="BUT_HELP_S08_CITY" value="..." id="BUT_HELP_S08_CITY" value="..." onclick="popup_help(0, \'city_6\', \'' + m_new_total_count + '\');" />' + 
                    '           </td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S08_DISTRICT_NAME_' + m_new_total_count + '" id="TXT_S08_DISTRICT_NAME_' + m_new_total_count + '" disabled="disabled" style="width: 125px;" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S08_PROVINCE_NAME_' + m_new_total_count + '" id="TXT_S08_PROVINCE_NAME_' + m_new_total_count + '" disabled="disabled" style="width: 125px;" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S08_COUNTRY_NAME_' + m_new_total_count + '" id="TXT_S08_COUNTRY_NAME_' + m_new_total_count + '" disabled="disabled" style="width: 125px;" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Type of Facility</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 175px;"><b>Equipment / Security</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Approved Amount</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Monthly Rental</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 125px;"><b>Period (Mts.)</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td><select class="txt_input" name="TXT_S08_TYPE_OF_FACILITY_' + m_new_total_count + '" id="TXT_S08_TYPE_OF_FACILITY_' + m_new_total_count + '" style="width: 125px;" /> ' + g_facility_types + ' </select></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S08_EQUIPMENT_SECURITY_' + m_new_total_count + '" id="TXT_S08_EQUIPMENT_SECURITY_' + m_new_total_count + '" maxlength="100" style="width: 175px;" onblur="strTrim(this);" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S08_APPROVED_AMOUNT_' + m_new_total_count + '" id="TXT_S08_APPROVED_AMOUNT_' + m_new_total_count + '" value="0.00" maxlength="24" style="width: 125px; text-align: right;" onblur="validateNumber(this, 0, 9999999999999999.99, 2, \'number\')" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S08_MONTHLY_RENTAL_' + m_new_total_count + '" id="TXT_S08_MONTHLY_RENTAL_' + m_new_total_count + '" value="0.00" maxlength="24" style="width: 125px; text-align: right;" onblur="validateNumber(this, 0, 9999999999999999.99, 2, \'number\')" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S08_PERIOD_' + m_new_total_count + '" id="TXT_S08_PERIOD_' + m_new_total_count + '" value="0.0" maxlength="5" style="width: 125px; text-align: right;" onblur="validateNumber(this, 0, 999.9, 1, \'number\')" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 200px;"><b>Balance Payable (Mts.)</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 200px;"><b>Balance Outstanding</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 250px;"><b>Comments</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td style="width: 50px;"></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S08_BALANCE_PAYABLE_' + m_new_total_count + '" id="TXT_S08_BALANCE_PAYABLE_' + m_new_total_count + '" value="0.0" maxlength="5" style="width: 200px; text-align: right;" onblur="validateNumber(this, 0, 999.9, 1, \'number\')" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S08_BALANCE_OUTSTANDING_' + m_new_total_count + '" id="TXT_S08_BALANCE_OUTSTANDING_' + m_new_total_count + '" value="0.00" maxlength="24" style="width: 200px; text-align: right;" onblur="validateNumber(this, 0, 9999999999999999.99, 2, \'number\')" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S08_COMMENTS_' + m_new_total_count + '" id="TXT_S08_COMMENTS_' + m_new_total_count + '" maxlength="4000" style="width: 250px;" onblur="strTrim(this);" /></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' +
                    '';
                
                document.getElementById("DIV_DETAILS_OF_CREDIT_FACILITIES" + m_new_total_count).innerHTML = html_content;
                document.Form1.hid_details_of_credit_facilities_count.value = m_new_total_count;
            }
            
            
            function delete_details_of_credit_facilities(m_selected_row_number) {
                var m_flag_clear = false;
                if ((parseInt(m_selected_row_number) > 0) && (confirm('Are you sure you want to delete?'))) {
                    var m_total_count = parseInt(document.Form1.hid_details_of_credit_facilities_count.value);
                    document.Form1.hid_details_of_credit_facilities_count.value = 0;
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
                    for (var i = 1; i <= m_total_count; i++) {
                        if (i != m_selected_row_number) {
                            m_count = m_count + 1;
                            value01[m_count] = document.Form1.elements["TXT_S08_INSTITUTION_NAME_" + i].value;
                            value02[m_count] = document.Form1.elements["TXT_S08_TITLE_" + i].value;
                            value03[m_count] = document.Form1.elements["TXT_S08_LAST_NAME_" + i].value;
                            value04[m_count] = document.Form1.elements["TXT_S08_INITIALS_" + i].value;
                            value05[m_count] = document.Form1.elements["TXT_S08_INITIALS_DETAILS_" + i].value;
                            value06[m_count] = document.Form1.elements["TXT_S08_ADDRESS_TYPE_" + i].value;
                            value07[m_count] = document.Form1.elements["TXT_S08_OWNERSHIP_" + i].value;
                            value08[m_count] = document.Form1.elements["TXT_S08_ADDRESS_LINE_1_" + i].value;
                            value09[m_count] = document.Form1.elements["TXT_S08_ADDRESS_LINE_2_" + i].value;
                            value10[m_count] = document.Form1.elements["TXT_S08_CITY_" + i].value;
                            value11[m_count] = document.Form1.elements["TXT_S08_CITY_NAME_" + i].value;
                            value12[m_count] = document.Form1.elements["TXT_S08_DISTRICT_NAME_" + i].value;
                            value13[m_count] = document.Form1.elements["TXT_S08_PROVINCE_NAME_" + i].value;
                            value14[m_count] = document.Form1.elements["TXT_S08_COUNTRY_NAME_" + i].value;
                            value15[m_count] = document.Form1.elements["TXT_S08_TYPE_OF_FACILITY_" + i].value;
                            value16[m_count] = document.Form1.elements["TXT_S08_EQUIPMENT_SECURITY_" + i].value;
                            value17[m_count] = document.Form1.elements["TXT_S08_APPROVED_AMOUNT_" + i].value;
                            value18[m_count] = document.Form1.elements["TXT_S08_MONTHLY_RENTAL_" + i].value;
                            value19[m_count] = document.Form1.elements["TXT_S08_PERIOD_" + i].value;
                            value20[m_count] = document.Form1.elements["TXT_S08_BALANCE_PAYABLE_" + i].value;
                            value21[m_count] = document.Form1.elements["TXT_S08_BALANCE_OUTSTANDING_" + i].value;
                            value22[m_count] = document.Form1.elements["TXT_S08_COMMENTS_" + i].value;
                        }
                    }
                    for (var i = 1; i <= m_count; i++) {
                        add_details_of_credit_facilities();
                    }
                    for (var i = 1; i <= m_count; i++) {;
                        document.Form1.elements["TXT_S08_INSTITUTION_NAME_" + i].value = value01[i];
                        document.Form1.elements["TXT_S08_TITLE_" + i].value = value02[i];
                        document.Form1.elements["TXT_S08_LAST_NAME_" + i].value = value03[i];
                        document.Form1.elements["TXT_S08_INITIALS_" + i].value = value04[i];
                        document.Form1.elements["TXT_S08_INITIALS_DETAILS_" + i].value = value05[i];
                        document.Form1.elements["TXT_S08_ADDRESS_TYPE_" + i].value = value06[i];
                        document.Form1.elements["TXT_S08_OWNERSHIP_" + i].value = value07[i];
                        document.Form1.elements["TXT_S08_ADDRESS_LINE_1_" + i].value = value08[i];
                        document.Form1.elements["TXT_S08_ADDRESS_LINE_2_" + i].value = value09[i];
                        document.Form1.elements["TXT_S08_CITY_" + i].value = value10[i];
                        document.Form1.elements["TXT_S08_CITY_NAME_" + i].value = value11[i];
                        document.Form1.elements["TXT_S08_DISTRICT_NAME_" + i].value = value12[i];
                        document.Form1.elements["TXT_S08_PROVINCE_NAME_" + i].value = value13[i];
                        document.Form1.elements["TXT_S08_COUNTRY_NAME_" + i].value = value14[i];
                        document.Form1.elements["TXT_S08_TYPE_OF_FACILITY_" + i].value = value15[i];
                        document.Form1.elements["TXT_S08_EQUIPMENT_SECURITY_" + i].value = value16[i];
                        document.Form1.elements["TXT_S08_APPROVED_AMOUNT_" + i].value = value17[i];
                        document.Form1.elements["TXT_S08_MONTHLY_RENTAL_" + i].value = value18[i];
                        document.Form1.elements["TXT_S08_PERIOD_" + i].value = value19[i];
                        document.Form1.elements["TXT_S08_BALANCE_PAYABLE_" + i].value = value20[i];
                        document.Form1.elements["TXT_S08_BALANCE_OUTSTANDING_" + i].value = value21[i];
                        document.Form1.elements["TXT_S08_COMMENTS_" + i].value = value22[i];
                    }
                    document.Form1.hid_details_of_credit_facilities_count.value = m_count;
                    if (m_count == 0) {
                        m_flag_clear = true;
                    }
                }
                if (m_selected_row_number == 0) {
                    m_flag_clear = true;
                }
                if (m_flag_clear == true) {
                    document.getElementById("DIV_DETAILS_OF_CREDIT_FACILITIES").innerHTML = '' + 
                        '   <table> ' + 
                        '       <tr> ' + 
                        '           <td class="div_input" align="center" style="width: 50px;"></td> ' + 
                        '       </tr> ' + 
                        '       <tr> ' + 
                        '           <td><input class="but_input but_input_client" type="button" name="BUT_ADD_DETAILS_OF_CREDIT_FACILITIES" value="+" onclick="add_details_of_credit_facilities();" /></td> ' + 
                        '       </tr> ' + 
                        '   </table> '; 
                }
				
				 document.getElementById("DIV_VEIW_DOCUMENT").innerHTML = '' + 
                        '   <table> ' + 
                        '       <tr> ' + 
                        '           <td class="div_input" align="center" style="width: 50px;"></td> ' + 
                        '       </tr> ' + 
                        '       <tr> ' + 
                        '           <td><input class="but_input but_input_client" type="button" name="BUT_VEIW_CLIENT_UPLOAD_DOC" value="View" onclick="view_client_upload_doc();" /></td> ' + 
                        '       </tr> ' + 
                        '   </table> '; 
				
            }
			
            function view_client_upload_doc(){
			    var  m_client_code = document.Form1.TXT_CLIENT_CODE.value;	
				if(m_client_code != null){
				var m_url = jsp_client_url + 'dn_client_upload_document_view.jsp?client_code=' + m_client_code;
                window.open(m_url, 'scr_popup_auditor_details', 'left=0, top=0, toolbar=0, location=0, directories=0, status=0, menuBar=0, scrollBars=1, resizable=1, width=' + screen.availWidth-100 + ', height=' + screen.availWidth-100);
				}			
			}
            
            function add_stock_brokering_accounts() {
                var html_content = null;
                var m_new_total_count = parseInt(document.Form1.hid_stock_brokering_accounts_count.value) + 1;
                
                if (m_new_total_count == 1) {
                   document.getElementById("DIV_STOCK_BROKERING_ACCOUNTS").innerHTML = '';
                }
                createDIV('DIV_STOCK_BROKERING_ACCOUNTS', m_new_total_count);
                
                html_content = '' + 
                    '   <table> ' + 
                    '       <tr> ' + 
                    '           <td class="div_input" align="center" style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 50px;"></td> ' + 
                    '           <td class="div_input" align="center" style="width: 175px;"><b>CDS Account No.</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 195px;"><b>Broker</b></td> ' + 
                    '           <td class="div_input" align="center" style="width: 195px;"><b>Advisor</b></td> ' + 
                    '       </tr> ' + 
                    '       <tr> ' + 
                    '';
                
                if (m_new_total_count == 1) {
                    html_content = html_content +
                        '           <td><input class="but_input but_input_client" type="button" name="BUT_STOCK_BROKERING_ACCOUNTS" value="+" onclick="add_stock_brokering_accounts();" maxlength="20" /></td> ' + 
                        '';
                }
                else {
                    html_content = html_content +
                        '           <td style="width: 50px;"></td> ' + 
                        '';
                }
                
                html_content = html_content +
                    '           <td><input class="but_input but_input_client" type="button" name="BUT_DELETE_STOCK_BROKERING_ACCOUNTS" value="-" onclick="delete_stock_brokering_accounts(' + m_new_total_count + ');" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S09_CDS_ACCOUNT_NO_' + m_new_total_count + '" id="TXT_S09_CDS_ACCOUNT_NO_' + m_new_total_count + '" maxlength="20" style="width: 175px;" onblur="strTrim(this);" /></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S09_BROKER_' + m_new_total_count + '" id="TXT_S09_BROKER_' + m_new_total_count + '" maxlength="100" style="width: 125px;" onblur="strTrim(this, null, null, \'NAME\'); this.value.toUpperCase(); " /><input id="BUT_HELP_S09_BROKER" class="but_input but_input_client" type="button" onclick="popup_help(0,\'broker\', \'' + m_new_total_count + '\');" value="..." name="BUT_HELP_S09_BROKER"></td> ' + 
                    '           <td><input class="txt_input" type="text" name="TXT_S09_ADVISOR_' + m_new_total_count + '" id="TXT_S09_ADVISOR_' + m_new_total_count + '" maxlength="100" style="width: 125px;" onblur="strTrim(this, null, null, \'NAME\'); this.value.toUpperCase(); " /><input id="BUT_HELP_S09_ADVISOR" class="but_input but_input_client" type="button" onclick="popup_help(0,\'advisor\', \'' + m_new_total_count + '\');" value="..." name="BUT_HELP_S09_ADVISOR"></td> ' + 
                    '       </tr> ' + 
                    '   </table> ' + 
                    '';
                
                document.getElementById("DIV_STOCK_BROKERING_ACCOUNTS" + m_new_total_count).innerHTML = html_content;
                document.Form1.hid_stock_brokering_accounts_count.value = m_new_total_count;
            }
            
            
            function delete_stock_brokering_accounts(m_selected_row_number) {
                var m_flag_clear = false;
                if ((parseInt(m_selected_row_number) > 0) && (confirm('Are you sure you want to delete?'))) {
                    var m_total_count = parseInt(document.Form1.hid_stock_brokering_accounts_count.value);
                    document.Form1.hid_stock_brokering_accounts_count.value = 0;
                    var m_count = 0;
                    var value01 = new Array();
                    var value02 = new Array();
                    var value03 = new Array();
                    for (var i = 1; i <= m_total_count; i++) {
                        if (i != m_selected_row_number) {
                            m_count = m_count + 1;
                            value01[m_count] = document.Form1.elements["TXT_S09_CDS_ACCOUNT_NO_" + i].value;
                            value02[m_count] = document.Form1.elements["TXT_S09_BROKER_" + i].value;
                            value03[m_count] = document.Form1.elements["TXT_S09_ADVISOR_" + i].value;
                        }
                    }
                    for (var i = 1; i <= m_count; i++) {
                        add_stock_brokering_accounts();
                    }
                    for (var i = 1; i <= m_count; i++) {;
                        document.Form1.elements["TXT_S09_CDS_ACCOUNT_NO_" + i].value = value01[i];
                        document.Form1.elements["TXT_S09_BROKER_" + i].value = value02[i];
                        document.Form1.elements["TXT_S09_ADVISOR_" + i].value = value03[i];
                    }
                    document.Form1.hid_stock_brokering_accounts_count.value = m_count;
                    if (m_count == 0) {
                        m_flag_clear = true;
                    }
                }
                if (m_selected_row_number == 0) {
                    m_flag_clear = true;
                }
                if (m_flag_clear == true) {
                    document.getElementById("DIV_STOCK_BROKERING_ACCOUNTS").innerHTML = '' + 
                        '   <table> ' + 
                        '       <tr> ' + 
                        '           <td class="div_input" align="center" style="width: 50px;"></td> ' + 
                        '       </tr> ' + 
                        '       <tr> ' + 
                        '           <td><input class="but_input but_input_client" type="button" name="BUT_STOCK_BROKERING_ACCOUNTS" value="+" onclick="add_stock_brokering_accounts();"  maxlength="20" /></td> ' + 
                        '       </tr> ' + 
                        '   </table> '; 
                }
            }
            
            
            function createDIV(div_name, row_number) {
                var dynDiv = document.createElement("div");
                dynDiv.id = div_name + row_number;
                document.getElementById(div_name).appendChild(dynDiv);
            }
            
            
            function display_rec_opt(val) {
                
            //    if ((val == 'MOD') && (confirm('Are you sure you want to modify an existing record?'))) {
                 if (val == 'MOD')  {     
                    $('#SCREEN_NAME').val('EDIT');
                    $('#TXT_CLIENT_CODE').attr('disabled', false);
                    $('#BUT_HELP_CLIENT_MAIN').attr('disabled', false);
                    $('#TXT_CLIENT_CODE').focus();
                    g_save_type = 'modify';
					document.getElementById('div_lable').innerHTML='Client Creation - Edit'; 	
                    
                }
                
                
                if (val == 'ADD') {
                    // $('#date_div').show();
                    if (confirm('Are you sure you want to add a new record?')) {
                        window.location.href = window.location.href;
						
                    }
					document.getElementById('div_lable').innerHTML='Client Creation - New'; 
			        // document.getElementById('date_div').style.visibility = 'visible';
					// parent.document.body.rows = "20%,*";
					// parent.frames[1].location.href=html_client_url+"/blank.html";
                }
                else if (val == 'DEL') {
                    $('#date_div').hide();
                    loadGridDeleteReceipt();
					document.getElementById('div_lable').innerHTML='Client Creation - Delete'; 
			// //parent.fset.rows="6%,15%";
			// //parent.document.body.cols = "*,5%";
			// parent.document.body.rows = "6%,*";
			// document.getElementById('date_div').style.visibility = 'hidden';
			// parent.frames[1].location.href=html_client_url+"/mbfsl_delete_receipts.html";;
                }
			
            }
            
            
            function validateData() {
                
                if (g_save_type == 'modify') {
                    if ($('#TXT_CLIENT_CODE').val() == '') {
                        alert('Please select a client to modify.');
                        $('#TXT_CLIENT_CODE').focus();
                        
                        return false;
                    }
                }
                
                if ($('#TXT_FULL_NAME').val() == '') {
                    alert('Please type a full name.');
                    $('#TXT_FULL_NAME').focus();
                    
                    return false;
                }
                
                return true;
                
            }
            
            
            function beforesubmit() {
                if ((validateData() == true) && (confirm('Are you sure you want to ' + g_save_type + '?'))) {
                    document.Form1.action = servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Client_Creation_save';
                    document.Form1.submit();
                }
                else {
                    document.Form1.save_but.disabled = false;
                }
            }
            
            
            function setWHTEnable() {
                if ($('#TXT_S03_C_WITHHOLDING_TAX').val() == 'Y') {
                    $('#TXT_S03_C_WITHHOLDING_TAX_PERCENTAGE').attr('disabled', false);
                    $('#TXT_S03_C_WITHHOLDING_TAX_CERTIFICATE_NUMBER').attr('disabled', false);
                }
                else if ($('#TXT_S03_C_WITHHOLDING_TAX').val() == 'N') {
                    $('#TXT_S03_C_WITHHOLDING_TAX_PERCENTAGE').attr('disabled', true);
                    $('#TXT_S03_C_WITHHOLDING_TAX_PERCENTAGE').val('0.00');
                    $('#TXT_S03_C_WITHHOLDING_TAX_CERTIFICATE_NUMBER').attr('disabled', true);
                    $('#TXT_S03_C_WITHHOLDING_TAX_CERTIFICATE_NUMBER').val('');
                }
            }
            
            
            function init_filestyle(m_id) {
                $('#' + m_id).filestyle({
                    image: "<%= jsp_client_url %>/SNET/images/file-upload.gif",
                    imageheight: 22,
                    imagewidth: 80,
                    width: 250
                });
            }
            
            
            function initCal(m_id) {
                $('#' + m_id).datepicker({
                    dateFormat: 'dd-mm-yy',
                    duration: 'fast',
                    yearRange: '1920:2050',
                    showOn: 'button',
                    buttonImage: '<%= jsp_client_url %>/SNET/images/calendar.gif',
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
                if (instance_id == "TXT_S03_C_DATE_OF_INCORPORATION") {
                    document.Form1.TXT_S03_C_DATE_OF_INCORPORATION_DD.value = splitResult[0];
                    document.Form1.TXT_S03_C_DATE_OF_INCORPORATION_MM.value = splitResult[1];
                    document.Form1.TXT_S03_C_DATE_OF_INCORPORATION_YY.value = splitResult[2];
                    document.Form1.TXT_S03_C_DATE_OF_INCORPORATION_YY.focus();
                }
                else if (instance_id == "TXT_S03_C_VAT_REGISTRATION_DATE") {
                    document.Form1.TXT_S03_C_VAT_REGISTRATION_DATE_DD.value = splitResult[0];
                    document.Form1.TXT_S03_C_VAT_REGISTRATION_DATE_MM.value = splitResult[1];
                    document.Form1.TXT_S03_C_VAT_REGISTRATION_DATE_YY.value = splitResult[2];
                    document.Form1.TXT_S03_C_VAT_REGISTRATION_DATE_YY.focus();
                }
                else if (instance_id == "TXT_S03_I_DATE_OF_BIRTH") {
                    document.Form1.TXT_S03_I_DATE_OF_BIRTH_DD.value = splitResult[0];
                    document.Form1.TXT_S03_I_DATE_OF_BIRTH_MM.value = splitResult[1];
                    document.Form1.TXT_S03_I_DATE_OF_BIRTH_YY.value = splitResult[2];
                    document.Form1.TXT_S03_I_DATE_OF_BIRTH_YY.focus();
                }
                else if (instance_id == "TXT_S03_I_VAT_REGISTRATION_DATE") {
                    document.Form1.TXT_S03_I_VAT_REGISTRATION_DATE_DD.value = splitResult[0];
                    document.Form1.TXT_S03_I_VAT_REGISTRATION_DATE_MM.value = splitResult[1];
                    document.Form1.TXT_S03_I_VAT_REGISTRATION_DATE_YY.value = splitResult[2];
                    document.Form1.TXT_S03_I_VAT_REGISTRATION_DATE_YY.focus();
                }
                else if (first_part == "TXT_S07_START_DATE_") {
                    document.Form1.elements["TXT_S07_START_DATE_DD_" + second_part].value = splitResult[0];
                    document.Form1.elements["TXT_S07_START_DATE_MM_" + second_part].value = splitResult[1];
                    document.Form1.elements["TXT_S07_START_DATE_YY_" + second_part].value = splitResult[2];
                    document.Form1.elements["TXT_S07_START_DATE_YY_" + second_part].focus();
                }
            }
            
            
            function get_data_help_validation(help_type, row_id) {
                
                if (help_type != null) {
                    g_help_type = help_type;
                    g_help_row_id = row_id;
                }
                
                
                if (g_help_type == 'client_code') {
                    
                    $.ajax({
                        url: servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Client?&chksql=help_validation_client_code&client_code=' + $('#TXT_CLIENT_CODE').val(),
                        type: 'GET',
                        dataType: 'xml',
                        success: function(xml) {
                            $(xml).find('client').each(function() {
                                
                                var count = $(this).attr('count');
                                if (count == 1) {
                                    
                                    $('#TXT_CLIENT_CODE').val($(this).find('client_code').text());
                                    $('#TXT_FULL_NAME').val($(this).find('client_full_name').text());
                                    
                                    get_other_data();
                                }
                                else {
                                    popup_help(0, g_help_type);
                                }
                                
                            });
                        }
                    });
                    
                }
                
            }
            
            
            function popup_help(start, help_type, row_id) {
                
                if (help_type != null) {
                    g_help_type = help_type;
                    g_help_row_id = row_id;
                }
                
                var myObject = new Array(); // return values set to this object
                var myObject_value = new Array(); // passing values set to this object
                var myObject_type = new Array(); // passing values data type
                
                var hid = 0;
                
                
                if (g_help_type == 'city') {
                    
                    myObject[0] = $('#TXT_S01_CITY').get(0);
                    myObject[1] = $('#TXT_S01_CITY_NAME').get(0);
                    myObject[2] = null;
                    myObject[3] = $('#TXT_S01_DISTRICT_NAME').get(0);
                    myObject[4] = null;
                    myObject[5] = $('#TXT_S01_PROVINCE_NAME').get(0);
                    myObject[6] = null;
                    myObject[7] = $('#TXT_S01_COUNTRY_NAME').get(0);
                    myObject[8] = null;
                    
                    myObject_value[0] = $('#TXT_S01_CITY_NAME').val();
                    myObject_value[1] = $('#TXT_S01_CITY_NAME').val();
                    myObject_value[2] = 'Y';
                    
                    myObject_type[0] = "StringL";
                    myObject_type[1] = "StringL";
                    myObject_type[2] = "String";
                    
                    var qid = '37';
                    hid = 7;
                    
                }
                else if (g_help_type == 'legal_status_of_business') {
                    
                    myObject[0] = $('#TXT_S03_C_LEGAL_STATUS_OF_BUSINESS').get(0);
                    myObject[1] = $('#TXT_S03_C_LEGAL_STATUS_OF_BUSINESS_NAME').get(0);
                    
                    myObject_value[0] = $('#TXT_S03_C_LEGAL_STATUS_OF_BUSINESS_NAME').val();
                    myObject_value[1] = $('#TXT_S03_C_LEGAL_STATUS_OF_BUSINESS_NAME').val();
                    myObject_value[2] = 'Y';
                    
                    myObject_type[0] = "StringL";
                    myObject_type[1] = "StringL";
                    myObject_type[2] = "String";
                    
                    var qid = '38';
                    
                }
                else if (g_help_type == 'client_group') {
                    
                    myObject[0] = $('#TXT_S03_C_CLIENT_GROUP').get(0);
                    myObject[1] = $('#TXT_S03_C_CLIENT_GROUP_NAME').get(0);
                    
                    myObject_value[0] = $('#TXT_S03_C_CLIENT_GROUP_NAME').val();
                    myObject_value[1] = $('#TXT_S03_C_CLIENT_GROUP_NAME').val();
                    myObject_value[2] = 'Y';
                    
                    myObject_type[0] = "StringL";
                    myObject_type[1] = "StringL";
                    myObject_type[2] = "String";
                    
                    var qid = '40';
                    
                }
                else if (g_help_type == 'city_2') {
                    
                    myObject[0] = $('#TXT_S03_C_CITY').get(0);
                    myObject[1] = $('#TXT_S03_C_CITY_NAME').get(0);
                    myObject[2] = null;
                    myObject[3] = $('#TXT_S03_C_DISTRICT_NAME').get(0);
                    myObject[4] = null;
                    myObject[5] = $('#TXT_S03_C_PROVINCE_NAME').get(0);
                    myObject[6] = null;
                    myObject[7] = $('#TXT_S03_C_COUNTRY_NAME').get(0);
                    myObject[8] = null;
                    
                    myObject_value[1] = $('#TXT_S03_C_CITY_NAME').val();
                    myObject_value[0] = $('#TXT_S03_C_CITY_NAME').val();
                    myObject_value[2] = 'Y';
                    
                    myObject_type[0] = "StringL";
                    myObject_type[1] = "StringL";
                    myObject_type[2] = "String";
                    
                    var qid = '37';
                    hid = 7;
                    
                }
                else if (g_help_type == 'nationality') {
                    
                    myObject[0] = $('#TXT_S03_I_NATIONALITY').get(0);
                    myObject[1] = $('#TXT_S03_I_NATIONALITY_NAME').get(0);
                    
                    myObject_value[1] = $('#TXT_S03_I_NATIONALITY_NAME').val();
                    myObject_value[0] = $('#TXT_S03_I_NATIONALITY_NAME').val();
                    myObject_value[2] = 'Y';
                    
                    myObject_type[0] = "StringL";
                    myObject_type[1] = "StringL";
                    myObject_type[2] = "String";
                    
                    var qid = '42';
                    
                }
                else if (g_help_type == 'city_3') {
                    
                    myObject[0] = $('#TXT_S02_CITY_' + g_help_row_id).get(0);
                    myObject[1] = $('#TXT_S02_CITY_NAME_' + g_help_row_id).get(0);
                    myObject[2] = null;
                    myObject[3] = $('#TXT_S02_DISTRICT_NAME_' + g_help_row_id).get(0);
                    myObject[4] = null;
                    myObject[5] = $('#TXT_S02_PROVINCE_NAME_' + g_help_row_id).get(0);
                    myObject[6] = null;
                    myObject[7] = $('#TXT_S02_COUNTRY_NAME_' + g_help_row_id).get(0);
                    myObject[8] = null;
                    
                    myObject_value[1] = $('#TXT_S02_CITY_NAME_' + g_help_row_id).val();
                    myObject_value[0] = $('#TXT_S02_CITY_NAME_' + g_help_row_id).val();
                    myObject_value[2] = 'Y';
                    
                    myObject_type[0] = "StringL";
                    myObject_type[1] = "StringL";
                    myObject_type[2] = "String";
                    
                    var qid = '37';
                    hid = 7;
                    
                }
                else if (g_help_type == 'city_4') {
                    
                    myObject[0] = $('#TXT_S04_CITY_' + g_help_row_id).get(0);
                    myObject[1] = $('#TXT_S04_CITY_NAME_' + g_help_row_id).get(0);
                    myObject[2] = null;
                    myObject[3] = $('#TXT_S04_DISTRICT_NAME_' + g_help_row_id).get(0);
                    myObject[4] = null;
                    myObject[5] = $('#TXT_S04_PROVINCE_NAME_' + g_help_row_id).get(0);
                    myObject[6] = null;
                    myObject[7] = $('#TXT_S04_COUNTRY_NAME_' + g_help_row_id).get(0);
                    myObject[8] = null;
                    
                    myObject_value[1] = $('#TXT_S04_CITY_NAME_' + g_help_row_id).val();
                    myObject_value[0] = $('#TXT_S04_CITY_NAME_' + g_help_row_id).val();
                    myObject_value[2] = 'Y';
                    
                    myObject_type[0] = "StringL";
                    myObject_type[1] = "StringL";
                    myObject_type[2] = "String";
                    
                    var qid = '37';
                    hid = 7;
                    
                }
                else if (g_help_type == 'company_name') {
                    
                    myObject[0] = null;
                    myObject[1] = $('#TXT_S05_COMPANY_NAME_' + g_help_row_id).get(0);
                    
                    myObject_value[1] = $('#TXT_S05_COMPANY_NAME_' + g_help_row_id).val();
                    myObject_value[0] = $('#TXT_S05_COMPANY_NAME_' + g_help_row_id).val();
                    
                    myObject_type[0] = "StringL";
                    myObject_type[1] = "StringL";
                    
                    var qid = '49';
                    
                }
                else if (g_help_type == 'city_5') {
                    
                    myObject[0] = $('#TXT_S06_CITY_' + g_help_row_id).get(0);
                    myObject[1] = $('#TXT_S06_CITY_NAME_' + g_help_row_id).get(0);
                    myObject[2] = null;
                    myObject[3] = $('#TXT_S06_DISTRICT_NAME_' + g_help_row_id).get(0);
                    myObject[4] = null;
                    myObject[5] = $('#TXT_S06_PROVINCE_NAME_' + g_help_row_id).get(0);
                    myObject[6] = null;
                    myObject[7] = $('#TXT_S06_COUNTRY_NAME_' + g_help_row_id).get(0);
                    myObject[8] = null;
                    
                    myObject_value[1] = $('#TXT_S06_CITY_NAME_' + g_help_row_id).val();
                    myObject_value[0] = $('#TXT_S06_CITY_NAME_' + g_help_row_id).val();
                    myObject_value[2] = 'Y';
                    
                    myObject_type[0] = "StringL";
                    myObject_type[1] = "StringL";
                    myObject_type[2] = "String";
                    
                    var qid = '37';
                    hid = 7;
                    
                }
                else if (g_help_type == 'city_6') {
                    
                    myObject[0] = $('#TXT_S08_CITY_' + g_help_row_id).get(0);
                    myObject[1] = $('#TXT_S08_CITY_NAME_' + g_help_row_id).get(0);
                    myObject[2] = null;
                    myObject[3] = $('#TXT_S08_DISTRICT_NAME_' + g_help_row_id).get(0);
                    myObject[4] = null;
                    myObject[5] = $('#TXT_S08_PROVINCE_NAME_' + g_help_row_id).get(0);
                    myObject[6] = null;
                    myObject[7] = $('#TXT_S08_COUNTRY_NAME_' + g_help_row_id).get(0);
                    myObject[8] = null;
                    
                    myObject_value[1] = $('#TXT_S08_CITY_NAME_' + g_help_row_id).val();
                    myObject_value[0] = $('#TXT_S08_CITY_NAME_' + g_help_row_id).val();
                    myObject_value[2] = 'Y';
                    
                    myObject_type[0] = "StringL";
                    myObject_type[1] = "StringL";
                    myObject_type[2] = "String";
                    
                    var qid = '37';
                    hid = 7;
                    
                }
                else if (g_help_type == 'bank_branch') {
                    
                    myObject[0] = $('#TXT_S07_BRANCH_' + g_help_row_id).get(0);
                    myObject[1] = $('#TXT_S07_BANK_NAME_' + g_help_row_id).get(0);
                    myObject[2] = $('#TXT_S07_BRANCH_NAME_' + g_help_row_id).get(0);
                    
                    myObject_value[0] = $('#TXT_S07_BRANCH_NAME_' + g_help_row_id).val();
                    myObject_value[1] = $('#TXT_S07_BRANCH_NAME_' + g_help_row_id).val();
                    myObject_value[2] = $('#TXT_S07_BRANCH_NAME_' + g_help_row_id).val();
                    myObject_value[3] = 'Y';
                    
                    myObject_type[0] = "StringL";
                    myObject_type[1] = "StringL";
                    myObject_type[2] = "StringL";
                    myObject_type[3] = "String";
                    
                    var qid = '50';
                    
                }
                else if (g_help_type == 'client_code') {
                    
                    myObject[0] = $('#TXT_CLIENT_CODE').get(0);
                    myObject[1] = $('#TXT_FULL_NAME').get(0);
                    
                    myObject_value[0] = $('#TXT_CLIENT_CODE').val();
                    myObject_value[1] = $('#TXT_CLIENT_CODE').val();
                    
                    myObject_type[0] = "StringL";
                    myObject_type[1] = "StringL";
                    
                    var qid = '60';
                    
                }else if (g_help_type == 'broker') {
                    
                    myObject[0] = $('#TXT_S09_BROKER_' + g_help_row_id).get(0);
                   
                    myObject_value[0] = $('#TXT_S09_BROKER_' + g_help_row_id).val();
                    
                    
                    myObject_type[0] = "StringL";
                                    
                    var qid = '80';
                   
                }
                else if (g_help_type == 'advisor') {
                   
					myObject[0] = null
					myObject[1] = $('#TXT_S09_ADVISOR_' + g_help_row_id).get(0);
                   
					
                    myObject_value[0] = $('#TXT_S09_ADVISOR_' + g_help_row_id).val();
                    myObject_value[1] = $('#TXT_S09_ADVISOR_' + g_help_row_id).val();
					myObject_value[2] = $('#TXT_S09_BROKER_' + g_help_row_id).val();
					
                    myObject_type[0] = "StringL";
                    myObject_type[1] = "StringL";    
					myObject_type[2] = "StringL";
					
                    var qid = '122';
                   
                }
                
                var url = 'popup.jsp';
                var json_text = JSON.stringify(myObject_value, null,0);
                var json_obj_type_text = JSON.stringify(myObject_type, null,0);
                var fn_name = arguments.callee.name;
                
                if (fn_name == undefined) {
                    re = /^function\s+([^(]+)/;
                    fn_name = re.exec(arguments.callee.toString())[1];
                }
                
                // var m_strat = 0;
                var help_close_function = 'help_close_function';
                
                $.showModalDialog({
                    url: url + '?par=' + json_text + '&type=' + json_obj_type_text + '&qid=' + qid + '&show=10' + '&start=' + start + '&fn_name=' + fn_name + '&hid=' + hid + '&close_fun=' + help_close_function,
                    dialogArguments: myObject_value,
                    height: 400,
                    width: 500,
                    title: 'SasiNet Frame work',
                    scrollable: true,
                    onClose: function() {
                        var returnedValue = this.returnValue;
                        set_return_value1(myObject, returnedValue);
                    }
                });
                
            }
            
            
            function help_close_function() {
                
                if (g_help_type == 'city') {
                    
                    $('#TXT_S01_CITY').val('');
                    $('#TXT_S01_CITY_NAME').val('');
                    $('#TXT_S01_DISTRICT_NAME').val('');
                    $('#TXT_S01_PROVINCE_NAME').val('');
                    $('#TXT_S01_COUNTRY_NAME').val('');
                    
                }
                else if (g_help_type == 'legal_status_of_business') {
                    
                    $('#TXT_S03_C_LEGAL_STATUS_OF_BUSINESS').val('');
                    $('#TXT_S03_C_LEGAL_STATUS_OF_BUSINESS_NAME').val('');
                    
                }
                else if (g_help_type == 'client_group') {
                    
                    $('#TXT_S03_C_CLIENT_GROUP').val('');
                    $('#TXT_S03_C_CLIENT_GROUP_NAME').val('');
                    
                }
                else if (g_help_type == 'city_2') {
                    
                    $('#TXT_S03_C_CITY').val('');
                    $('#TXT_S03_C_CITY_NAME').val('');
                    $('#TXT_S03_C_DISTRICT_NAME').val('');
                    $('#TXT_S03_C_PROVINCE_NAME').val('');
                    $('#TXT_S03_C_COUNTRY_NAME').val('');
                    
                }
                else if (g_help_type == 'nationality') {
                    
                    $('#TXT_S03_I_NATIONALITY').val('');
                    $('#TXT_S03_I_NATIONALITY_NAME').val('');
                    
                }
                else if (g_help_type == 'city_3') {
                    
                    $('#TXT_S02_CITY_' + g_help_row_id).val('');
                    $('#TXT_S02_CITY_NAME_' + g_help_row_id).val('');
                    $('#TXT_S02_DISTRICT_NAME_' + g_help_row_id).val('');
                    $('#TXT_S02_PROVINCE_NAME_' + g_help_row_id).val('');
                    $('#TXT_S02_COUNTRY_NAME_' + g_help_row_id).val('');
                    
                }
                else if (g_help_type == 'city_4') {
                    
                    $('#TXT_S04_CITY_' + g_help_row_id).val('');
                    $('#TXT_S04_CITY_NAME_' + g_help_row_id).val('');
                    $('#TXT_S04_DISTRICT_NAME_' + g_help_row_id).val('');
                    $('#TXT_S04_PROVINCE_NAME_' + g_help_row_id).val('');
                    $('#TXT_S04_COUNTRY_NAME_' + g_help_row_id).val('');
                    
                }
                else if (g_help_type == 'company_name') {
                    
                    $('#TXT_S05_COMPANY_NAME_' + g_help_row_id).val('');
                    
                }
                else if (g_help_type == 'city_5') {
                    
                    $('#TXT_S06_CITY_' + g_help_row_id).val('');
                    $('#TXT_S06_CITY_NAME_' + g_help_row_id).val('');
                    $('#TXT_S06_DISTRICT_NAME_' + g_help_row_id).val('');
                    $('#TXT_S06_PROVINCE_NAME_' + g_help_row_id).val('');
                    $('#TXT_S06_COUNTRY_NAME_' + g_help_row_id).val('');
                    
                }
                else if (g_help_type == 'city_6') {
                    
                    $('#TXT_S08_CITY_' + g_help_row_id).val('');
                    $('#TXT_S08_CITY_NAME_' + g_help_row_id).val('');
                    $('#TXT_S08_DISTRICT_NAME_' + g_help_row_id).val('');
                    $('#TXT_S08_PROVINCE_NAME_' + g_help_row_id).val('');
                    $('#TXT_S08_COUNTRY_NAME_' + g_help_row_id).val('');
                    
                }
                else if (g_help_type == 'bank_branch') {
                    
                    $('#TXT_S07_BRANCH_' + g_help_row_id).val('');
                    $('#TXT_S07_BANK_NAME_' + g_help_row_id).val('');
                    $('#TXT_S07_BRANCH_NAME_' + g_help_row_id).val('');
                    
                }
                else if (g_help_type == 'client_code') {
                    $('#TXT_CLIENT_CODE').val('');
                    $('#TXT_FULL_NAME').val('');
                }
                
            }
            
            
            function set_return_value1(from_obj, return_obj) { // return value set to the object in this function
                
                if (return_obj != null) {
                    for (i=1; i < return_obj.length; i++) {
                        // alert(return_obj[i]);
                        if (from_obj[i-1] != null) {
                            from_obj[i-1].value = return_obj[i];
                        }
                    }
                    
                    get_other_data();
                    
                }
                
                
                
                // get_other_data();
                
            }
            
            
            function get_other_data() {
                
                if (g_help_type == 'city') {
                    
                    copy_address();
                    
                }
                
                else if (g_help_type == 'client_code') {
                    
                    $.ajax({
                        url: servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Client?&chksql=get_client_details&client_code=' + $('#TXT_CLIENT_CODE').val(),
                        type: 'GET',
                        dataType: 'xml',
                        success: function(xml) {
                            $(xml).find('client').each(function() {
                                
                                $('#TXT_CLIENT_TYPE').val($(this).find('client_type').text());
                                load_business_entity();
                                load_general_information();
                                
                                $('#TXT_BUSINESS_ENTITY').val($(this).find('client_category').text());
                                
                                $('#TXT_S01_ADDRESS_TYPE').val($(this).find('address_type').text());
                                $('#TXT_S01_OWNERSHIP').val($(this).find('ownership').text());
                                $('#TXT_S01_ADDRESS_LINE_1').val($(this).find('registered_address1').text());
                                $('#TXT_S01_ADDRESS_LINE_2').val($(this).find('registered_address2').text());
                                $('#TXT_S01_CITY').val($(this).find('city_code').text());
                                $('#TXT_S01_CITY_NAME').val($(this).find('city_name').text());
                                $('#TXT_S01_DISTRICT_NAME').val($(this).find('district_name').text());
                                $('#TXT_S01_PROVINCE_NAME').val($(this).find('province_name').text());
                                $('#TXT_S01_COUNTRY_NAME').val($(this).find('country_name').text());
                                
                                var joint_holder_applicable = $(this).find('joint_holder_applicable').text();
                                if (joint_holder_applicable == 'Y') {
                                    $('#TXT_FULL_NAME_JOINT_HOLDER').attr('disabled', false);
                                    $('#TXT_FULL_NAME_JOINT_HOLDER').val($(this).find('full_name_joint_holder').text());
                                    $('#CHK_JOINT_HOLDER_STATUS').attr('checked', true);
                                }
                                else {
                                    $('#TXT_FULL_NAME_JOINT_HOLDER').attr('disabled', true);
                                    $('#TXT_FULL_NAME_JOINT_HOLDER').val('');
                                    $('#CHK_JOINT_HOLDER_STATUS').attr('checked', false);
                                }
                                
                                
                                if ($('#TXT_CLIENT_TYPE').val() == 'C') {
                                    
                                    $('#TXT_S03_C_LEGAL_STATUS_OF_BUSINESS').val($(this).find('legal_status_of_business').text());
                                    $('#TXT_S03_C_LEGAL_STATUS_OF_BUSINESS_NAME').val($(this).find('legal_status_of_business_name').text());
                                    $('#TXT_S03_C_CLIENT_GROUP').val($(this).find('client_group').text());
                                    $('#TXT_S03_C_CLIENT_GROUP_NAME').val($(this).find('client_group_name').text());
                                    $('#TXT_S03_C_ISSUED_SHARE_CAPITAL').val(format_noobject1($(this).find('issued_share_capital').text(), 2));
                                    $('#TXT_S03_C_BUSINESS_CERTIFICATE_NO').val($(this).find('business_registration_number').text());
                                    $('#TXT_S03_C_BUSINESS_REG_LOCATION').val($(this).find('business_registered_location').text());
                                    $('#TXT_S03_C_ADDRESS_TYPE').val($(this).find('business_address_type').text());
                                    $('#TXT_S03_C_ADDRESS_LINE_1').val($(this).find('business_address1').text());
                                    $('#TXT_S03_C_ADDRESS_LINE_2').val($(this).find('business_address2').text());
                                    $('#TXT_S03_C_CITY').val($(this).find('business_city_code').text());
                                    $('#TXT_S03_C_CITY_NAME').val($(this).find('business_city_name').text());
                                    $('#TXT_S03_C_DISTRICT_NAME').val($(this).find('business_district_name').text());
                                    $('#TXT_S03_C_PROVINCE_NAME').val($(this).find('business_province_name').text());
                                    $('#TXT_S03_C_COUNTRY_NAME').val($(this).find('business_country_name').text());
                                    
                                    $('#TXT_S03_C_DATE_OF_INCORPORATION_DD').val($(this).find('date_of_incorporation').attr('day'));
                                    $('#TXT_S03_C_DATE_OF_INCORPORATION_MM').val($(this).find('date_of_incorporation').attr('month'));
                                    $('#TXT_S03_C_DATE_OF_INCORPORATION_YY').val($(this).find('date_of_incorporation').attr('year'));
                                    $('#TXT_S03_C_DATE_OF_INCORPORATION').val($(this).find('date_of_incorporation').text());
                                    
                                    $('#TXT_S03_C_WITHHOLDING_TAX').val($(this).find('withholding_tax').text());
                                    $('#TXT_S03_C_WITHHOLDING_TAX_PERCENTAGE').val(format_noobject1($(this).find('withholding_tax_percentage').text(), 2));
                                    $('#TXT_S03_C_WITHHOLDING_TAX_CERTIFICATE_NUMBER').val($(this).find('withholding_tax_certificate_number').text());
                                    $('#TXT_S03_C_VAT_REG_NO').val($(this).find('vat_registration_number').text());
                                    
                                    $('#TXT_S03_C_VAT_REGISTRATION_DATE_DD').val($(this).find('vat_registration_date').attr('day'));
                                    $('#TXT_S03_C_VAT_REGISTRATION_DATE_MM').val($(this).find('vat_registration_date').attr('month'));
                                    $('#TXT_S03_C_VAT_REGISTRATION_DATE_YY').val($(this).find('vat_registration_date').attr('year'));
                                    $('#TXT_S03_C_VAT_REGISTRATION_DATE').val($(this).find('vat_registration_date').text());
                                    
                                    $('#TXT_S03_C_EXTERNAL_RATING').val($(this).find('external_rating').text());
                                    $('#TXT_S03_C_RATING_AGENCY').val($(this).find('rating_agency').text());
                                    $('#TXT_S03_C_RATING_YEAR').val($(this).find('rating_year').text());
                                    $('#TXT_S03_C_NATURE_OF_BUSINESS').val($(this).find('nature_of_business').text());
                                    $('#TXT_S03_C_COMMENTS').val($(this).find('comments').text());
                                    
                                    limitText($('#TXT_S03_C_NATURE_OF_BUSINESS').get(0), $('#TXT_S03_C_NATURE_OF_BUSINESS_COUNT').get(0), 4000);
                                    limitText($('#TXT_S03_C_COMMENTS').get(0), $('#TXT_S03_C_COMMENTS_COUNT').get(0), 200);
                                    
                                }
                                else if ($('#TXT_CLIENT_TYPE').val() == 'I') {
                                    
                                    $('#TXT_S03_I_TITLE').val($(this).find('title').text());
                                    $('#TXT_S03_I_SURNAME').val($(this).find('surname').text());
                                    $('#TXT_S03_I_INITIALS').val($(this).find('initials').text());
                                    $('#TXT_S03_I_INITIALS_DETAILS').val($(this).find('other_names').text());
                                    $('#TXT_S03_I_GENDER').val($(this).find('gender').text());
                                    $('#TXT_S03_I_NATIONALITY').val($(this).find('nationality').text());
                                    $('#TXT_S03_I_NATIONALITY_NAME').val($(this).find('nationality_name').text());
                                    $('#TXT_S03_I_IDENTIFICATION_TYPE').val($(this).find('identification_type').text());
                                    change_id_label_s03();
                                    
                                    $('#TXT_S03_I_IDENTIFICATION').val($(this).find('identification').text());
                                    $('#TXT_S03_C_BUSINESS_REG_LOCATION').val($(this).find('business_registered_location').text());
                                    $('#TXT_S03_I_MARITAL_STATUS').val($(this).find('marital_status').text());
                                    $('#TXT_S03_I_DEPENDENTS').val($(this).find('dependents').text());
                                    $('#TXT_S03_I_NO_OF_CHILDREN').val($(this).find('number_of_children').text());
                                    
                                    $('#TXT_S03_I_DATE_OF_BIRTH_DD').val($(this).find('date_of_birth').attr('day'));
                                    $('#TXT_S03_I_DATE_OF_BIRTH_MM').val($(this).find('date_of_birth').attr('month'));
                                    $('#TXT_S03_I_DATE_OF_BIRTH_YY').val($(this).find('date_of_birth').attr('year'));
                                    $('#TXT_S03_I_DATE_OF_BIRTH').val($(this).find('date_of_birth').text());
                                    
                                    $('#TXT_S03_I_OCCUPATION').val($(this).find('occupation').text());
                                    $('#TXT_S03_I_EMPLOYEMENT_TYPE').val($(this).find('employement_type').text());
                                    $('#TXT_S03_I_VAT_REG_NO').val($(this).find('vat_registration_number').text());
                                    
                                    $('#TXT_S03_I_VAT_REGISTRATION_DATE_DD').val($(this).find('vat_registration_date').attr('day'));
                                    $('#TXT_S03_I_VAT_REGISTRATION_DATE_MM').val($(this).find('vat_registration_date').attr('month'));
                                    $('#TXT_S03_I_VAT_REGISTRATION_DATE_YY').val($(this).find('vat_registration_date').attr('year'));
                                    $('#TXT_S03_I_VAT_REGISTRATION_DATE').val($(this).find('vat_registration_date').text());
                                    
                                    $('#TXT_S03_C_NATURE_OF_BUSINESS').val($(this).find('nature_of_business').text());
                                    $('#TXT_S03_I_QUALIFICATION').val($(this).find('qualification').text());
                                    
                                    limitText($('#TXT_S03_C_NATURE_OF_BUSINESS').get(0), $('#TXT_S03_C_NATURE_OF_BUSINESS_COUNT').get(0), 4000);
                                    limitText($('#TXT_S03_I_QUALIFICATION').get(0), $('#TXT_S03_I_QUALIFICATION_COUNT').get(0), 200);
                                    
                                }
                                
                                
                                get_contact_persons();
                                
                            });
                        }
                    });
                    
                }
                
            }
            
            
            function get_contact_persons() {
                
                $.ajax({
                    url: servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Client?&chksql=get_contact_persons_count&client_code=' + $('#TXT_CLIENT_CODE').val(),
                    type: 'GET',
                    dataType: 'xml',
                    success: function(xml) {
                        $(xml).find('client').each(function() {
                            
                            var contact_person_count = $(this).attr('count');
                            
                            delete_contact_person(0);
                            $('#hid_contact_person_count').val(0);
                            
                            for (var i = 1; i <= contact_person_count; i++) {
                                add_contact_person();
                            }
                            
                            contact_person_count = parseInt(contact_person_count);
                            if (contact_person_count > 0) {
                                
                                $.ajax({
                                    url: servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Client?&chksql=get_contact_persons&client_code=' + $('#TXT_CLIENT_CODE').val(),
                                    type: 'GET',
                                    dataType: 'xml',
                                    success: function(xml) {
                                        
                                        $(xml).find('client').each(function() {
                                            
                                            $(this).find('contact_person').each(function() {
                                                
                                                var id = $(this).attr('id');
                                                
                                                $('#TXT_S02_TITLE_' + id).val($(this).find('title').text());
                                                $('#TXT_S02_LAST_NAME_' + id).val($(this).find('last_name').text());
                                                $('#TXT_S02_INITIALS_' + id).val($(this).find('initials').text());
                                                $('#TXT_S02_INITIALS_DETAILS_' + id).val($(this).find('initials_details').text());
                                                $('#TXT_S02_DESIGNATION_' + id).val($(this).find('designation').text());
                                                $('#TXT_S02_ADDRESS_TYPE_' + id).val($(this).find('address_type').text());
                                                $('#TXT_S02_ADDRESS_LINE_1_' + id).val($(this).find('address_line_1').text());
                                                $('#TXT_S02_ADDRESS_LINE_2_' + id).val($(this).find('address_line_2').text());
                                                $('#TXT_S02_CITY_' + id).val($(this).find('city_code').text());
                                                $('#TXT_S02_CITY_NAME_' + id).val($(this).find('city_name').text());
                                                $('#TXT_S02_DISTRICT_NAME_' + id).val($(this).find('district_name').text());
                                                $('#TXT_S02_PROVINCE_NAME_' + id).val($(this).find('province_name').text());
                                                $('#TXT_S02_COUNTRY_NAME_' + id).val($(this).find('country_name').text());
                                                $('#TXT_S02_TELEPHONE_1_' + id).val($(this).find('telephone_1').text());
                                                $('#TXT_S02_TELEPHONE_2_' + id).val($(this).find('telephone_2').text());
                                                $('#TXT_S02_MOBILE_' + id).val($(this).find('mobile').text());
                                                $('#TXT_S02_FAX_' + id).val($(this).find('fax').text());
                                                $('#TXT_S02_EMAIL_' + id).val($(this).find('email').text());
                                                
                                                if ($(this).find('default_status').text() == 'Y') {
                                                    $('#TXT_S02_DEFAULT_' + id).val('Y');
                                                    $('#TXT_S02_DEFAULT_' + id).attr('checked', true);
                                                }
                                                
                                            });
                                            
                                            get_directors_partners_shareholders();
                                            
                                        });
                                    }
                                });
                                
                            }
                            
                            else {
                                get_directors_partners_shareholders();
                            }
                            
                        });
                    }
                });
                
            }
            
            
            function get_directors_partners_shareholders() {
                
                $.ajax({
                    url: servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Client?&chksql=get_directors_partners_shareholders_count&client_code=' + $('#TXT_CLIENT_CODE').val(),
                    type: 'GET',
                    dataType: 'xml',
                    success: function(xml) {
                        $(xml).find('client').each(function() {
                            
                            var directors_partners_shareholders_count = $(this).attr('count');
                            
                            delete_directors_partners_shareholders(0);
                            $('#hid_directors_partners_shareholders_count').val(0);
                            
                            for (var i = 1; i <= directors_partners_shareholders_count; i++) {
                                add_directors_partners_shareholders();
                            }
                            
                            directors_partners_shareholders_count = parseInt(directors_partners_shareholders_count);
                            if (directors_partners_shareholders_count > 0) {
                                
                                $.ajax({
                                    url: servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Client?&chksql=get_directors_partners_shareholders&client_code=' + $('#TXT_CLIENT_CODE').val(),
                                    type: 'GET',
                                    dataType: 'xml',
                                    success: function(xml) {
                                        
                                        $(xml).find('client').each(function() {
                                            
                                            $(this).find('director_partner_shareholder').each(function() {
                                                
                                                var id = $(this).attr('id');
                                                
                                                $('#TXT_S04_TITLE_' + id).val($(this).find('title').text());
                                                $('#TXT_S04_LAST_NAME_' + id).val($(this).find('last_name').text());
                                                $('#TXT_S04_INITIALS_' + id).val($(this).find('initials').text());
                                                $('#TXT_S04_INITIALS_DETAILS_' + id).val($(this).find('initials_details').text());
                                                $('#TXT_S04_POSITION_' + id).val($(this).find('position').text());
                                                $('#TXT_S04_NIC_' + id).val($(this).find('nic').text());
                                                $('#TXT_S04_ADDRESS_TYPE_' + id).val($(this).find('address_type').text());
                                                $('#TXT_S04_OWNERSHIP_' + id).val($(this).find('ownership').text());
                                                $('#TXT_S04_ADDRESS_LINE_1_' + id).val($(this).find('address_line_1').text());
                                                $('#TXT_S04_ADDRESS_LINE_2_' + id).val($(this).find('address_line_2').text());
                                                $('#TXT_S04_CITY_' + id).val($(this).find('city_code').text());
                                                $('#TXT_S04_CITY_NAME_' + id).val($(this).find('city_name').text());
                                                $('#TXT_S04_DISTRICT_NAME_' + id).val($(this).find('district_name').text());
                                                $('#TXT_S04_PROVINCE_NAME_' + id).val($(this).find('province_name').text());
                                                $('#TXT_S04_COUNTRY_NAME_' + id).val($(this).find('country_name').text());
                                                $('#TXT_S04_TELEPHONE_1_' + id).val($(this).find('telephone_1').text());
                                                $('#TXT_S04_TELEPHONE_2_' + id).val($(this).find('telephone_2').text());
                                                $('#TXT_S04_MOBILE_' + id).val($(this).find('mobile').text());
                                                $('#TXT_S04_FAX_' + id).val($(this).find('fax').text());
                                                $('#TXT_S04_EMAIL_' + id).val($(this).find('email').text());
                                                $('#TXT_S04_STAKE_' + id).val(format_noobject1($(this).find('stake').text(), 2));
                                                $('#TXT_S04_NO_OF_SHARES_' + id).val(format_noobject1($(this).find('number_of_shares').text(), 2));
                                                $('#TXT_S04_VALUE_' + id).val(format_noobject1($(this).find('share_value').text(), 2));
                                                $('#TXT_S04_GUARANTOR_STATUS_' + id).val($(this).find('guarantor_status').text());
                                                $('#TXT_S04_SIGNATORIES_' + id).val($(this).find('signatories').text());
                                                $('#TXT_S04_COMMENTS_' + id).val($(this).find('comments').text());
                                                
                                            });
                                            
                                            get_subsidiaries_and_associated_companies();
                                            
                                        });
                                    }
                                });
                                
                            }
                            
                            else {
                                get_subsidiaries_and_associated_companies();
                            }
                            
                        });
                    }
                });
                
            }
            
            
            function get_subsidiaries_and_associated_companies() {
                
                $.ajax({
                    url: servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Client?&chksql=get_subsidiaries_and_associated_companies_count&client_code=' + $('#TXT_CLIENT_CODE').val(),
                    type: 'GET',
                    dataType: 'xml',
                    success: function(xml) {
                        $(xml).find('client').each(function() {
                            
                            var subsidiaries_and_associated_companies_count = $(this).attr('count');
                            
                            delete_subsidiaries_and_associated_companies(0);
                            $('#hid_subsidiaries_and_associated_companies_count').val(0);
                            
                            for (var i = 1; i <= subsidiaries_and_associated_companies_count; i++) {
                                add_subsidiaries_and_associated_companies();
                            }
                            
                            subsidiaries_and_associated_companies_count = parseInt(subsidiaries_and_associated_companies_count);
                            if (subsidiaries_and_associated_companies_count > 0) {
                                
                                $.ajax({
                                    url: servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Client?&chksql=get_subsidiaries_and_associated_companies&client_code=' + $('#TXT_CLIENT_CODE').val(),
                                    type: 'GET',
                                    dataType: 'xml',
                                    success: function(xml) {
                                        
                                        $(xml).find('client').each(function() {
                                            
                                            $(this).find('subsidiary_associated_company').each(function() {
                                                
                                                var id = $(this).attr('id');
                                                
                                                $('#TXT_S05_ASSOCIATION_' + id).val($(this).find('association').text());
                                                $('#TXT_S05_COMPANY_NAME_' + id).val($(this).find('company_name').text());
                                                $('#TXT_S05_STAKE_' + id).val(format_noobject1($(this).find('stake').text(), 2));
                                                $('#TXT_S05_VALUE_' + id).val(format_noobject1($(this).find('share_value').text(), 2));
                                                $('#TXT_S05_TELEPHONE_1_' + id).val($(this).find('telephone_1').text());
                                                $('#TXT_S05_TELEPHONE_2_' + id).val($(this).find('telephone_2').text());
                                                $('#TXT_S05_MOBILE_' + id).val($(this).find('mobile').text());
                                                $('#TXT_S05_FAX_' + id).val($(this).find('fax').text());
                                                $('#TXT_S05_EMAIL_' + id).val($(this).find('email').text());
                                                $('#TXT_S05_TITLE_' + id).val($(this).find('title').text());
                                                $('#TXT_S05_LAST_NAME_' + id).val($(this).find('last_name').text());
                                                $('#TXT_S05_INITIALS_' + id).val($(this).find('initials').text());
                                                $('#TXT_S05_INITIALS_DETAILS_' + id).val($(this).find('initials_details').text());
                                                $('#TXT_S05_BUSINESS_ACTIVITIES_' + id).val($(this).find('business_activities').text());
                                                $('#TXT_S05_COMMENTS_' + id).val($(this).find('comments').text());
                                                
                                            });
                                            
                                            get_auditors_details();
                                            
                                        });
                                    }
                                });
                                
                            }
                            
                            else {
                                get_auditors_details();
                            }
                            
                        });
                    }
                });
                
            }
            
            
            function get_auditors_details() {
                
                $.ajax({
                    url: servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Client?&chksql=get_auditors_details_count&client_code=' + $('#TXT_CLIENT_CODE').val(),
                    type: 'GET',
                    dataType: 'xml',
                    success: function(xml) {
                        $(xml).find('client').each(function() {
                            
                            var auditors_details_count = $(this).attr('count');
                            
                            delete_auditors_details(0);
                            $('#hid_auditors_details_count').val(0);
                            
                            for (var i = 1; i <= auditors_details_count; i++) {
                                add_auditors_details();
                            }
                            
                            auditors_details_count = parseInt(auditors_details_count);
                            if (auditors_details_count > 0) {
                                
                                $.ajax({
                                    url: servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Client?&chksql=get_auditors_details&client_code=' + $('#TXT_CLIENT_CODE').val(),
                                    type: 'GET',
                                    dataType: 'xml',
                                    success: function(xml) {
                                        
                                        $(xml).find('client').each(function() {
                                            
                                            $(this).find('auditor').each(function() {
                                                
                                                var id = $(this).attr('id');
                                                
                                                $('#TXT_S06_COMPANY_NAME_' + id).val($(this).find('company_name').text());
                                                $('#TXT_S06_TITLE_' + id).val($(this).find('title').text());
                                                $('#TXT_S06_LAST_NAME_' + id).val($(this).find('last_name').text());
                                                $('#TXT_S06_INITIALS_' + id).val($(this).find('initials').text());
                                                $('#TXT_S06_INITIALS_DETAILS_' + id).val($(this).find('initials_details').text());
                                                $('#TXT_S06_ADDRESS_TYPE_' + id).val($(this).find('address_type').text());
                                                $('#TXT_S06_OWNERSHIP_' + id).val($(this).find('ownership').text());
                                                $('#TXT_S06_ADDRESS_LINE_1_' + id).val($(this).find('address_line_1').text());
                                                $('#TXT_S06_ADDRESS_LINE_2_' + id).val($(this).find('address_line_2').text());
                                                $('#TXT_S06_CITY_' + id).val($(this).find('city_code').text());
                                                $('#TXT_S06_CITY_NAME_' + id).val($(this).find('city_name').text());
                                                $('#TXT_S06_DISTRICT_NAME_' + id).val($(this).find('district_name').text());
                                                $('#TXT_S06_PROVINCE_NAME_' + id).val($(this).find('province_name').text());
                                                $('#TXT_S06_COUNTRY_NAME_' + id).val($(this).find('country_name').text());
                                                $('#TXT_S06_TELEPHONE_1_' + id).val($(this).find('telephone_1').text());
                                                $('#TXT_S06_TELEPHONE_2_' + id).val($(this).find('telephone_2').text());
                                                $('#TXT_S06_MOBILE_' + id).val($(this).find('mobile').text());
                                                $('#TXT_S06_FAX_' + id).val($(this).find('fax').text());
                                                $('#TXT_S06_EMAIL_' + id).val($(this).find('email').text());
                                                $('#TXT_S06_RELATIONSHIP_' + id).val($(this).find('relationship').text());
                                                $('#TXT_S06_REFERENCE_' + id).val($(this).find('reference').text());
                                                
                                            });
                                            
                                            get_accounts_and_banking_details();
                                            
                                        });
                                    }
                                });
                                
                            }
                            
                            else {
                                get_accounts_and_banking_details();
                            }
                            
                        });
                    }
                });
                
            }
            
            
            function get_accounts_and_banking_details() {
                
                $.ajax({
                    url: servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Client?&chksql=get_accounts_and_banking_details_count&client_code=' + $('#TXT_CLIENT_CODE').val(),
                    type: 'GET',
                    dataType: 'xml',
                    success: function(xml) {
                        $(xml).find('client').each(function() {
                            
                            var accounts_and_banking_details_count = $(this).attr('count');
                            
                            delete_accounts_and_banking_details(0);
                            $('#hid_accounts_and_banking_details_count').val(0);
                            
                            for (var i = 1; i <= accounts_and_banking_details_count; i++) {
                                add_accounts_and_banking_details();
                            }
                            
                            accounts_and_banking_details_count = parseInt(accounts_and_banking_details_count);
                            if (accounts_and_banking_details_count > 0) {
                                
                                $.ajax({
                                    url: servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Client?&chksql=get_accounts_and_banking_details&client_code=' + $('#TXT_CLIENT_CODE').val(),
                                    type: 'GET',
                                    dataType: 'xml',
                                    success: function(xml) {
                                        
                                        $(xml).find('client').each(function() {
                                            
                                            $(this).find('account_bank').each(function() {
                                                
                                                var id = $(this).attr('id');
                                                
                                                $('#TXT_S07_BANK_NAME_' + id).val($(this).find('bank_name').text());
                                                $('#TXT_S07_BRANCH_NAME_' + id).val($(this).find('branch_name').text());
                                                $('#TXT_S07_BRANCH_' + id).val($(this).find('branch_code').text());
                                                $('#TXT_S07_ACCOUNT_TYPE_' + id).val($(this).find('account_type').text());
                                                $('#TXT_S07_ACCOUNT_NO_' + id).val($(this).find('account_no').text());
                                                $('#TXT_S07_ACCOUNT_NAME_' + id).val($(this).find('account_name').text());
                                                $('#TXT_S07_START_DATE_DD_' + id).val($(this).find('start_date').attr('day'));
                                                $('#TXT_S07_START_DATE_MM_' + id).val($(this).find('start_date').attr('month'));
                                                $('#TXT_S07_START_DATE_YY_' + id).val($(this).find('start_date').attr('year'));
                                                $('#TXT_S07_START_DATE_' + id).val($(this).find('start_date').text());
                                                $('#TXT_S07_BRANCH_TEL_NO_' + id).val($(this).find('telephone').text());
                                                $('#TXT_S07_BRANCH_FAX_NO_' + id).val($(this).find('fax').text());
                                                $('#TXT_S07_BRANCH_REFERENCE_' + id).val($(this).find('reference').text());
                                                $('#TXT_S07_RELATION_' + id).val($(this).find('relation').text());
                                                $('#TXT_S07_COMMENTS_' + id).val($(this).find('comments').text());
                                                
                                            });
                                            
                                            get_details_of_credit_facilities();
                                            
                                        });
                                    }
                                });
                                
                            }
                            
                            else {
                                get_details_of_credit_facilities();
                            }
                            
                        });
                    }
                });
                
            }
            
            
            function get_details_of_credit_facilities() {
                
                $.ajax({
                    url: servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Client?&chksql=get_details_of_credit_facilities_count&client_code=' + $('#TXT_CLIENT_CODE').val(),
                    type: 'GET',
                    dataType: 'xml',
                    success: function(xml) {
                        $(xml).find('client').each(function() {
                            
                            var details_of_credit_facilities_count = $(this).attr('count');
                            
                            delete_details_of_credit_facilities(0);
                            $('#hid_details_of_credit_facilities_count').val(0);
                            
                            for (var i = 1; i <= details_of_credit_facilities_count; i++) {
                                add_details_of_credit_facilities();
                            }
                            
                            details_of_credit_facilities_count = parseInt(details_of_credit_facilities_count);
                            if (details_of_credit_facilities_count > 0) {
                                
                                $.ajax({
                                    url: servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Client?&chksql=get_details_of_credit_facilities&client_code=' + $('#TXT_CLIENT_CODE').val(),
                                    type: 'GET',
                                    dataType: 'xml',
                                    success: function(xml) {
                                        
                                        $(xml).find('client').each(function() {
                                            
                                            $(this).find('credit_facility').each(function() {
                                                
                                                var id = $(this).attr('id');
                                                
                                                $('#TXT_S08_INSTITUTION_NAME_' + id).val($(this).find('institution_name').text());
                                                $('#TXT_S08_TITLE_' + id).val($(this).find('title').text());
                                                $('#TXT_S08_LAST_NAME_' + id).val($(this).find('last_name').text());
                                                $('#TXT_S08_INITIALS_' + id).val($(this).find('initials').text());
                                                $('#TXT_S08_INITIALS_DETAILS_' + id).val($(this).find('initials_details').text());
                                                $('#TXT_S08_ADDRESS_TYPE_' + id).val($(this).find('address_type').text());
                                                $('#TXT_S08_OWNERSHIP_' + id).val($(this).find('ownership').text());
                                                $('#TXT_S08_ADDRESS_LINE_1_' + id).val($(this).find('address_line_1').text());
                                                $('#TXT_S08_ADDRESS_LINE_2_' + id).val($(this).find('address_line_2').text());
                                                $('#TXT_S08_CITY_' + id).val($(this).find('city_code').text());
                                                $('#TXT_S08_CITY_NAME_' + id).val($(this).find('city_name').text());
                                                $('#TXT_S08_DISTRICT_NAME_' + id).val($(this).find('district_name').text());
                                                $('#TXT_S08_PROVINCE_NAME_' + id).val($(this).find('province_name').text());
                                                $('#TXT_S08_COUNTRY_NAME_' + id).val($(this).find('country_name').text());
                                                $('#TXT_S08_TYPE_OF_FACILITY_' + id).val($(this).find('facility_type').text());
                                                $('#TXT_S08_EQUIPMENT_SECURITY_' + id).val($(this).find('equipment_security').text());
                                                $('#TXT_S08_APPROVED_AMOUNT_' + id).val(format_noobject1($(this).find('approved_amount').text(), 2));
                                                $('#TXT_S08_MONTHLY_RENTAL_' + id).val(format_noobject1($(this).find('monthly_rental').text(), 2));
                                                $('#TXT_S08_PERIOD_' + id).val(format_noobject1($(this).find('period').text(), 1));
                                                $('#TXT_S08_BALANCE_PAYABLE_' + id).val(format_noobject1($(this).find('balance_payable').text(), 1));
                                                $('#TXT_S08_BALANCE_OUTSTANDING_' + id).val(format_noobject1($(this).find('balance_outstanding').text(), 2));
                                                $('#TXT_S08_COMMENTS_' + id).val($(this).find('comments').text());
                                                
                                            });
                                            
                                            get_stock_brokering_accounts();
                                            
                                        });
                                    }
                                });
                                
                            }
                            
                            else {
                                get_stock_brokering_accounts();
                            }
                            
                        });
                    }
                });
                
            }
            
            
            function get_stock_brokering_accounts() {
                
                $.ajax({
                    url: servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Client?&chksql=get_stock_brokering_accounts_count&client_code=' + $('#TXT_CLIENT_CODE').val(),
                    type: 'GET',
                    dataType: 'xml',
                    success: function(xml) {
                        $(xml).find('client').each(function() {
                            
                            var stock_brokering_accounts_count = $(this).attr('count');
                            
                            delete_stock_brokering_accounts(0);
                            $('#hid_stock_brokering_accounts_count').val(0);
                            
                            for (var i = 1; i <= stock_brokering_accounts_count; i++) {
                                add_stock_brokering_accounts();
                            }
                            
                            stock_brokering_accounts_count = parseInt(stock_brokering_accounts_count);
                            if (stock_brokering_accounts_count > 0) {
                                
                                $.ajax({
                                    url: servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Client?&chksql=get_stock_brokering_accounts&client_code=' + $('#TXT_CLIENT_CODE').val(),
                                    type: 'GET',
                                    dataType: 'xml',
                                    success: function(xml) {
                                        
                                        $(xml).find('client').each(function() {
                                            
                                            $(this).find('stock_brokering_account').each(function() {
                                                
                                                var id = $(this).attr('id');
                                                
                                                $('#TXT_S09_CDS_ACCOUNT_NO_' + id).val($(this).find('cds_account_no').text());
                                                $('#TXT_S09_BROKER_' + id).val($(this).find('broker_name').text());
                                                $('#TXT_S09_ADVISOR_' + id).val($(this).find('advisor_name').text());
                                                
                                            });
                                            
                                            handle_null();
                                            
                                        });
                                    }
                                });
                                
                            }
                            
                            else {
                                handle_null();
                            }
                            
                        });
                    }
                });
                
            }
            
            
            function check_joint_holder_status() {
                if ($('#CHK_JOINT_HOLDER_STATUS').is(':checked')) {
                    $('#TXT_FULL_NAME_JOINT_HOLDER').attr('disabled', false);
                    $('#TXT_FULL_NAME_JOINT_HOLDER').focus();
                }
                else {
                    $('#TXT_FULL_NAME_JOINT_HOLDER').attr('disabled', true);
                    $('#TXT_FULL_NAME_JOINT_HOLDER').val('');
                }
            }
            
            
            function check_s02_default(object) {
                if (object.checked == false) {
                    object.checked = true;
                    object.value = "Y";
                }
                else if (object.checked == true) {
                    var number_of_rows = document.Form1.hid_contact_person_count.value;
                    for (var i = 1; i <= number_of_rows; i++) {
                        document.Form1.elements["TXT_S02_DEFAULT_" + i].checked = false;
                        document.Form1.elements["TXT_S02_DEFAULT_" + i].value = "N";
                    }
                    object.checked = true;
                    object.value = "Y";
                }
            }
            
            
            function imposeMaxLength(Object, MaxLen) {
                return (Object.value.length <= MaxLen);
            }
            
            
            function validateNumberLocal(object, min_value, max_value, db_scale, number_or_percentage) {
                var m_flag = true;
                var m_object = object;
                alert(m_object.id);
                var my_id = m_object.id;
                m_flag = validateNumber(object, min_value, max_value, db_scale, number_or_percentage);
                if (m_flag == false) {
                    setTimeout('document.getElementById(\''+my_id+'\').select()', 1);
                    alert('Local');
                }
            }
            
            
            function openAuditorDetails(m_row_number) {
                var int_row_number      = m_row_number;
                var str_auditor_details = document.Form1.elements['TXT_S06_AUDITOR_DETAILS_' + m_row_number].value;
                var m_url = jsp_client_url + 'Client_Creation_Auditor_Details.jsp?row_number=' + int_row_number + '&auditor_details=' + str_auditor_details;
                window.open(m_url, 'scr_popup_auditor_details', 'left=0, top=0, toolbar=0, location=0, directories=0, status=0, menuBar=0, scrollBars=1, resizable=1, width=' + screen.availWidth + ', height=' + screen.availWidth);
            }
            
            
            function setAuditorDetails(m_row_number, m_auditor_details) {
                document.Form1.elements['TXT_S06_AUDITOR_DETAILS_' + m_row_number].value = m_auditor_details;
            }
            
            
            function followup_update_client_data(client) {
                document.Form1.MAIN_BUT_SAVE.disabled = true;
                document.Form1.TXT_CLIENT_CODE.value = client;
                setTimeout('document.Form1.elements[\'TXT_FULL_NAME\'].select()', 1);
                document.Form1.hid_contact_person_count.value = "0";
                document.Form1.hid_directors_partners_shareholders_count.value = "0";
                document.Form1.hid_subsidiaries_and_associated_companies_count.value = "0";
                document.Form1.hid_auditors_details_count.value = "0";
                document.Form1.hid_accounts_and_banking_details_count.value = "0";
                document.Form1.hid_suppliers_customers_details_count.value = "0";
                document.Form1.hid_details_of_credit_facilities_count.value = "0";
                document.getElementById("DIV_CONTACT_PERSON").innerHTML = "";
                document.getElementById("DIV_DIRECTORS_PARTNERS_SHAREHOLDERS").innerHTML = "";
                document.getElementById("DIV_SUBSIDIARIES_AND_ASSOCIATED_COMPANIES").innerHTML = "";
                document.getElementById("DIV_AUDITORS_DETAILS").innerHTML = "";
                document.getElementById("DIV_ACCOUNTS_AND_BANKING_DETAILS").innerHTML = "";
                document.getElementById("DIV_DETAILS_OF_CREDIT_FACILITIES").innerHTML = "";
                document.getElementById("DIV_PRODUCT_DETAILS").innerHTML = "";
                document.getElementById("DIV_SUPPLIERS_CUSTOMERS_DETAILS").innerHTML = "";
                document.getElementById("DIV_TOP_DEBTORS").innerHTML = "";
                delete_contact_person(0);
                delete_directors_partners_shareholders(0);
                delete_subsidiaries_and_associated_companies(0);
                delete_auditors_details(0);
                delete_accounts_and_banking_details(0);
                delete_details_of_credit_facilities(0);
                delete_product_details(0);
                delete_suppliers_customers_details(0);
                delete_top_debtors(0);
                document.Form1.hid_validation_type.value = "611";
                var m_client_code = document.Form1.TXT_CLIENT_CODE.value;
                m_url = "http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_sql_validations_1?chksql=client_information_collection_edit_get_client_details&client_code="+m_client_code;
                load_interface(m_url, 'XML');
            }
            
            
            function load_screen_status_followup(m_value) {
                if ((m_value == "EDIT") ) {
                    document.Form1.SCREEN_NAME.value = "EDIT";
                    document.Form1.hid_screen_status.value = "Edit";
                    document.Form1.hid_save_message.value = "modify";
                    document.getElementById("SCREEN_TITLE").innerHTML = "Credit - Client Master Creation - " + document.Form1.hid_screen_status.value;
                    reset_div_tag_labels();
                    clear_screen_values();
                    document.Form1.TXT_ENQUIRY_NO.disabled = true;
                    document.Form1.BUT_HELP_ENQUIRY_MAIN.disabled = true;
                    document.Form1.TXT_CLIENT_CODE.disabled = false;
                    document.Form1.BUT_HELP_CLIENT_MAIN.disabled = false;
                }
            }
            
            
            function hideCompanyNameLabel(m_row_number) {
                var str_customer_type_object_name  = 'TXT_S10_CUSTOMER_TYPE_' + m_row_number;
                var str_company_name_object_name   = 'TXT_S10_COMPANY_NAME_' + m_row_number;
                var str_company_name_div_tag_id    = 'DIV_TXT_S10_COMPANY_NAME_' + m_row_number;
                var str_title_object_name          = 'TXT_S10_TITLE_2_' + m_row_number;
                var str_title_div_tag_id           = 'DIV_TXT_S10_TITLE_2_' + m_row_number;
                var str_name_object_name       		= 'TXT_S10_LAST_NAME_2_' + m_row_number;
                var str_name_div_tag_id        		= 'DIV_TXT_S10_LAST_NAME_2_' + m_row_number;
                var str_initials_object_name       = 'TXT_S10_INITIALS_2_' + m_row_number;
                var str_initials_div_tag_id        = 'DIV_TXT_S10_INITIALS_2_' + m_row_number;
                var str_detail_name_object_name    = 'TXT_S10_INITIALS_DETAILS_2_' + m_row_number;
                var str_detail_name_div_tag_id     = 'DIV_TXT_S10_INITIALS_DETAILS_2_' + m_row_number;
                var str_relation_object_name       = 'TXT_S10_RELATION_' + m_row_number;
                var str_relation_div_tag_id        = 'DIV_TXT_S10_RELATION_' + m_row_number;
                var str_comment_object_name        = 'TXT_S10_COMMENTS_' + m_row_number;
                var str_comment_div_tag_id         = 'DIV_TXT_S10_COMMENTS_' + m_row_number;
                var str_credit_period_object_name  = 'TXT_S10_CREDIT_PERIOD_RECEIVED_' + m_row_number;
                var str_credit_period_div_tag_id   = 'DIV_TXT_S10_CREDIT_PERIOD_RECEIVED_' + m_row_number;
                var str_security_object_name       = 'TXT_S10_SECURITY_' + m_row_number;
                var str_secuity_div_tag_id         = 'DIV_TXT_S10_SECURITY_' + m_row_number;
                var str_contact_person_div_tag_id  = 'DIV_TXT_S10_CONTACT_PERSON_' + m_row_number;
                if (document.forms[0].elements[str_customer_type_object_name].value == 'I') {
                    document.forms[0].elements[str_company_name_object_name].value = '';
                    document.forms[0].elements[str_company_name_object_name].style.visibility = 'hidden';
                    document.getElementById(str_company_name_div_tag_id).style.visibility = 'hidden';
                    document.getElementById(str_contact_person_div_tag_id).style.visibility = 'visible';
                    document.forms[0].elements[str_title_object_name].style.visibility = 'visible';
                    document.getElementById(str_title_div_tag_id).style.visibility = 'visible';
                    document.forms[0].elements[str_name_object_name].style.visibility = 'visible';
                    document.getElementById(str_name_div_tag_id).style.visibility = 'visible';
                    document.forms[0].elements[str_initials_object_name].style.visibility = 'visible';
                    document.getElementById(str_initials_div_tag_id).style.visibility = 'visible';
                    document.forms[0].elements[str_detail_name_object_name].style.visibility = 'visible';
                    document.getElementById(str_detail_name_div_tag_id).style.visibility = 'visible';
                    document.forms[0].elements[str_relation_object_name].style.visibility = 'visible';
                    document.getElementById(str_relation_div_tag_id).style.visibility = 'visible';
                    document.forms[0].elements[str_comment_object_name].style.visibility = 'visible';
                    document.getElementById(str_comment_div_tag_id).style.visibility = 'visible';
                    document.forms[0].elements[str_credit_period_object_name].style.visibility = 'visible';
                    document.getElementById(str_credit_period_div_tag_id).style.visibility = 'visible';
                    document.forms[0].elements[str_security_object_name].style.visibility = 'visible';
                    document.getElementById(str_secuity_div_tag_id).style.visibility = 'visible';
                }
                else if (document.forms[0].elements[str_customer_type_object_name].value == 'C') {
                    document.forms[0].elements[str_company_name_object_name].style.visibility = 'visible';
                    document.getElementById(str_company_name_div_tag_id).style.visibility = 'visible';
                    document.getElementById(str_contact_person_div_tag_id).style.visibility = 'hidden';
                    document.forms[0].elements[str_title_object_name].value = '';
                    document.forms[0].elements[str_title_object_name].style.visibility = 'hidden';
                    document.getElementById(str_title_div_tag_id).style.visibility = 'hidden';
                    document.forms[0].elements[str_name_object_name].value = '';
                    document.forms[0].elements[str_name_object_name].style.visibility = 'hidden';
                    document.getElementById(str_name_div_tag_id).style.visibility = 'hidden';
                    document.forms[0].elements[str_initials_object_name].value = '';
                    document.forms[0].elements[str_initials_object_name].style.visibility = 'hidden';
                    document.getElementById(str_initials_div_tag_id).style.visibility = 'hidden';
                    document.forms[0].elements[str_detail_name_object_name].value = '';
                    document.forms[0].elements[str_detail_name_object_name].style.visibility = 'hidden';
                    document.getElementById(str_detail_name_div_tag_id).style.visibility = 'hidden';
                    document.forms[0].elements[str_relation_object_name].value = '';
                    document.forms[0].elements[str_relation_object_name].style.visibility = 'hidden';
                    document.getElementById(str_relation_div_tag_id).style.visibility = 'hidden';
                    document.forms[0].elements[str_comment_object_name].value = '';
                    document.forms[0].elements[str_comment_object_name].style.visibility = 'hidden';
                    document.getElementById(str_comment_div_tag_id).style.visibility = 'hidden';
                    document.forms[0].elements[str_credit_period_object_name].value = '';
                    document.forms[0].elements[str_credit_period_object_name].style.visibility = 'hidden';
                    document.getElementById(str_credit_period_div_tag_id).style.visibility = 'hidden';
                    document.forms[0].elements[str_security_object_name].value = '';
                    document.forms[0].elements[str_security_object_name].style.visibility = 'hidden';
                    document.getElementById(str_secuity_div_tag_id).style.visibility = 'hidden';
                }
            }
            
            
            function check_nic() {
                if (document.Form1.TXT_S03_I_IDENTIFICATION_TYPE.value == 'NIC'){ 
                    var result = validateNIC(document.Form1.TXT_S03_I_IDENTIFICATION);
                    var m_length = document.Form1.TXT_S03_I_IDENTIFICATION.value.length;
                    if ((result == true) && (m_length == 10)) { 
                        $.ajax({
                            url: servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Client?&chksql=check_client_nic&nic_no=' + document.Form1.TXT_S03_I_IDENTIFICATION.value,
                            type: 'GET',
                            dataType: 'xml',
                            success: function(xml) {
                                $(xml).find('root').each(function() {
                                    if ($(this).find('nic_count').text() == '1') {
                                        alert('NIC already exist in the system.');
                                        document.Form1.TXT_S03_I_IDENTIFICATION.focus();
                                    }
                                });
                            }
                        });
                    }
                }
            }
            
            
            function check_business_registration() {
                
                $.ajax({
                    url: servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Client?chksql=check_client_business_registration&client_code=' + $('#TXT_CLIENT_CODE').val() + '&client_business_registration=' + $('#TXT_S03_C_BUSINESS_CERTIFICATE_NO').val(),
                    type: 'GET',
                    dataType: 'xml',
                    success: function(xml) {
                        var client_business_registration_count = parseInt($(xml).find('client').attr('client_business_registration_count'));
                        
                        if (client_business_registration_count > 0) {
                            alert('Business Registration Number already exist in the system.');
                            $('#TXT_S03_C_BUSINESS_CERTIFICATE_NO').focus();
                        }
                    }
                });
                
            }
            
            
            // function checkBankAccount(m_row_number) {
                
                // var branch_code     = $('#TXT_S07_BRANCH_' + m_row_number).val();
                // var account_no      = $('#TXT_S07_ACCOUNT_NO_' + m_row_number).val();
                
                // if ((branch_code != '') && (account_no != '')) {
                    // m_url="http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CR_sql_validations?chksql=m_check_bank_account&branch_no="+branch+"&acc_no="+acc+"&row_number="+m_row_number;
                    // $.ajax({
                        // url: servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Client?chksql=check_bank_account&client_code=' + $('#TXT_CLIENT_CODE').val() + '&branch_code=' + branch_code + '&account_no=' + account_no + '&row_number=' + m_row_number,
                        // type: 'GET',
                        // dataType: 'xml',
                        // success: function(xml) {
                            // // var client_business_registration_count = parseInt($(xml).find('client').attr('client_business_registration_count'));
                            
                            // // if (client_business_registration_count > 0) {
                                // // alert('Business Registration Number already exist in the system.');
                                // // $('#TXT_S03_C_BUSINESS_CERTIFICATE_NO').focus();
                            // // }
                        // }
                    // });
                // }
                
                
            // }
            
            
            function search_global_client() {
showGlobalDialog()
           }
            function copy_address() {
                if (document.Form1.TXT_CLIENT_TYPE.value == 'C') {
                    if (document.Form1.TXT_S01_ADDRESS_LINE_1.value != "" && document.Form1.TXT_S03_C_ADDRESS_LINE_1.value == "") {
                        document.Form1.TXT_S03_C_ADDRESS_LINE_1.value = document.Form1.TXT_S01_ADDRESS_LINE_1.value;
                    }
                    if (document.Form1.TXT_S01_ADDRESS_LINE_2.value != "" && document.Form1.TXT_S03_C_ADDRESS_LINE_2.value == "") {
                        document.Form1.TXT_S03_C_ADDRESS_LINE_2.value = document.Form1.TXT_S01_ADDRESS_LINE_2.value;
                    }
                    if (document.Form1.TXT_S01_CITY_NAME.value != "" && document.Form1.TXT_S03_C_CITY_NAME.value == "") {
                       document.Form1.TXT_S03_C_CITY_NAME.value = document.Form1.TXT_S01_CITY_NAME.value;
                       document.Form1.TXT_S03_C_DISTRICT_NAME.value = document.Form1.TXT_S01_DISTRICT_NAME.value;
                       document.Form1.TXT_S03_C_PROVINCE_NAME.value = document.Form1.TXT_S01_PROVINCE_NAME.value;
                       document.Form1.TXT_S03_C_COUNTRY_NAME.value = document.Form1.TXT_S01_COUNTRY_NAME.value;
                       document.Form1.TXT_S03_C_CITY.value = document.Form1.TXT_S01_CITY.value;
                    }
                }
            }
           
           
/* Function Re-done By Samitha Kulatilaka On 2010-07-02 */
function format_noobject1(value, passed_decimalsize, m_alert, m_brackets) {
    
    /* Trim The data */
    // var new_value = value.replace(/^\s+|\s+$/g, '');
    new_value = value;
    new_value = unformat_noobject(new_value);
    // alert('value : ' + new_value + '     length : ' + new_value.length);
    
    /* Check Whether The Value Is Actually A Number */
    if (isNaN(new_value)) {
        if (m_alert != 'N') {
            alert("You have typed an incorrect charactor as a number.");
            return value;
        }
    }
    
    /* Check Whether The Number Is Negative */
    var is_number_negative = false;
    if (new_value < 0) {
        is_number_negative = true;
        new_value = new_value.slice(1);
    }
    
    /* Create A Number Object And Round It As Necessary */
    var number_object = new Number(new_value);
    number_object = number_object.toFixed(passed_decimalsize);
    
    
    /* Format The Number */
    new_value = number_object.toString();
    
    var index_of_dot = new_value.indexOf('.');
    /* If Clauses Added By Samitha Kulatilaka On 2010-08-10 */
    var integer_part = '';
    var fraction_part = '';
    if (index_of_dot != -1) {
        integer_part = new_value.substring(0, index_of_dot);
        fraction_part = new_value.substring(index_of_dot + 1);
    }
    else {
        integer_part = new_value;
    }
    
    new_value = '';
    var j = 0;
    if (integer_part.length > 3) {
        for (var i = integer_part.length - 1; i >= 0; i--) {
            j = j + 1;
            new_value = integer_part.charAt(i) + new_value;
            if (j == 3) {
                /* Only Prefix A Comma If There Are More Numbers To The Left */
                if (i > 0) {
                    new_value = ',' + new_value;
                }
                j = 0;
            }
        }
    }
    /* Commas Are Not Necessary For This If Clause */
    else {
        new_value = integer_part;
    }
    
    /* If Clause Added By Samitha Kulatilaka On 2010-08-10 */
    if (index_of_dot != -1) {
        new_value = new_value.concat('.', fraction_part);
    }
    
    if (is_number_negative == true) {
        new_value = '-' + new_value;
    }
    
    
    /* Put Brackets For Negative Numbers */
    if (m_brackets == 'BRACKETS') {
        // alert(new_value);
        if (new_value.charAt(0) == '-') {
            new_value = new_value.slice(1);
            new_value = '(' + new_value + ')';
        }
    }
    
    return new_value;
    
    
    
    
    /* Commented By Samitha Kulatilaka 2010-07-02 */
    // var decimalsize = 4;
    // if (!isNaN(passed_decimalsize)) {
        // decimalsize = passed_decimalsize;
    // }
    
    // m_format = value.toString();
    // m_dot_count = 0;
    // var m_integer = "";
    // var m_decimal = "";
    // m_minus = false;
    
    // for (var i = 0; i < m_format.length; i++) {
        // var oneChar = m_format.charAt(i);
        // if (oneChar ==  ".") {
            // m_dot_count = m_dot_count + 1;
        // }
        // if (oneChar == "-") {
            // m_minus = true;
        // }
        // if ((isNaN(oneChar)) && (oneChar != ",") && (oneChar != ".") && (oneChar != "-")) {
            // /* If Conditon Added By Samitha Kulatilaka On 2010-06-10 */
            // if (m_alert != 'N') {
                // alert("You have typed an incorrect charactor as a number.");
                // return oneChar;
            // }
        // }
        // if (!isNaN(oneChar) && m_dot_count == 0) {
            // m_integer = m_integer + oneChar;
        // }
        // if (m_dot_count > 0 && oneChar != ".") {
            // m_decimal = m_decimal + oneChar;
        // }
    // }
    
    // if (m_dot_count > 1) {
        // alert("You have typed more than one decimal separator.");
        // return false;
    // }
    
    // m_format = m_integer;
    // var m_formatted = "";
    // var m_new_str = "";
    // m_end = m_format.length;
    // m_stat_pos = m_end - 4;
    // var m_last_pos = m_end;
    // while (m_stat_pos >= 0) {
        // m_chk_str = m_format.substr(m_stat_pos, 1);
        // if (m_chk_str != null) {
            // m_add_str = "," + m_format.substr(m_stat_pos + 1, 3);
            // m_new_str = m_add_str + m_new_str;
        // }
        // m_last_pos = m_stat_pos;
        // m_stat_pos = m_stat_pos - 3;
    // }
    
    // if (m_decimal.length > decimalsize){
        // m_decimal = m_decimal.substr(0, decimalsize);
    // }
    // else {
        // i = 1;
        // bal_length = decimalsize - m_decimal.length;
        // while (i <= bal_length) {
            // m_decimal = m_decimal + "0";
            // i = i + 1;
        // }
    // }
    // m_decimal = "." + m_decimal;
    
    // m_new_str = m_format.substr(0, m_last_pos + 1) + m_new_str + m_decimal;
    
    // if (m_minus) {
        // m_new_str = "-" + m_new_str;
    // }
    // value = m_new_str;
    
    // return value;
}

            
            
           function set_file_val(filestyle_id) {
				
               filestyle_element = document.getElementById(filestyle_id);
               fake_filestyle_element = document.getElementById("fake_" + filestyle_id);
               fake_filestyle_element.value = filestyle_element.value;
           }
          //ADDED BY PRABASH ON 28-12-2011-------------------------------**  
			function client_view(){
			<%

				String m_chksql   	= request.getParameter("chksql");
				String m_Client_no  = request.getParameter("Client_no");

				out.println("var chksql2 ='"+m_chksql+"'");
				out.println("var Client_no2 ='"+m_Client_no+"'");

			%>	
		
				
		if (chksql2== 'Client_view') {
			
			
		  display_rec_opt('MOD');	
		  document.Form1.TXT_CLIENT_CODE.value = Client_no2;	
		  get_data_help_validation('client_code');
		  document.Form1.TXT_CLIENT_CODE.disabled =true;
		  document.Form1.save.disabled = true;
		  document.Form1.Add.disabled = true;
		  document.Form1.Exit.disabled = true;
		  document.Form1.cancel.disabled = true;
		  document.Form1.Add_but.disabled = true;
		  document.Form1.MOD_but.disabled = true;
		  document.Form1.DEL_but.disabled = true;
			
		  
		//  document.Form1.DEL.disabled = true;
			}
		}
		//------------------------------------------------------------**
			
		function enquiry(){
		document.getElementById('div_lable').innerHTML='Client Creation - Enquiry'; 
		document.Form1.save.disabled = true;
		document.Form1.TXT_CLIENT_CODE.disabled =false;
		
		var m_client_code=prompt("Please enter Client Code","");
		if (name!=null && name!=""){
			document.Form1.TXT_CLIENT_CODE.value=m_client_code;	
		}
       	

		popup_help(0, 'client_code');
		}	
        </script>
    </head>
    
    <body class="body & txt-body" ONLOAD="client_view()">
        <form name="Form1" enctype="multipart/form-data" method="post">
            
            <input type="hidden" name="SCREEN_NAME" id="SCREEN_NAME" value="NEW" />
            <input type="hidden" name="hid_contact_person_count" id="hid_contact_person_count" value="0" />
            <input type="hidden" name="hid_directors_partners_shareholders_count" id="hid_directors_partners_shareholders_count" value="0" />
            <input type="hidden" name="hid_subsidiaries_and_associated_companies_count" id="hid_subsidiaries_and_associated_companies_count" value="0" />
            <input type="hidden" name="hid_auditors_details_count" id="hid_auditors_details_count" value="0" />
            <input type="hidden" name="hid_accounts_and_banking_details_count" id="hid_accounts_and_banking_details_count" value="0" />
            <input type="hidden" name="hid_details_of_credit_facilities_count" id="hid_details_of_credit_facilities_count" value="0" />
            <input type="hidden" name="hid_stock_brokering_accounts_count" id="hid_stock_brokering_accounts_count" value="0" />
            
            <div>
                <table class="table" align="center" border="0" cellpadding="0" cellspacing="0" width="99%">
                    <tr>
                        <td height="7"></td>
                    </tr>
                    
                    <tr height="30">
                        <td width="13px" style="background-image: url('<%= jsp_client_url %>/images/l1.gif'); background-repeat: no repeat;" id="hi1"></td>
                        <td style="background-image: url('<%= jsp_client_url %>/images/l3.gif'); background-repeat: repeat;" id="hi2" align="left"><b>	Administration - Client Master Sub Module</b></td>
                        <td width="13px" style="background-image: url('<%= jsp_client_url %>/images/l2.gif'); background-repeat: no repeat;"  id="hi3"></td>
                    </tr>
                </table>
            </div>
            
            
            <table class="table" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td height="1"></td>
                </tr>
            </table>
            
            <table width="100%" bgcolor="darkblue">
                <tr>
                    <td width="6%">
                        <input class="mainbut" type="button" name="Add" value="Add" id="Add_but" onclick="display_rec_opt('ADD');" />
                    </td>
                    <td width="6%">
                        <input class="mainbut" type="button" name="MOD" value="Edit" id="MOD_but" onclick="display_rec_opt('MOD');" />
                    </td>
                    <td width="6%">
                        <input class="mainbut" type="button" name="DEL" value="Delete" id="DEL_but" onclick="display_rec_opt('DEL');" disabled="disabled" />
                    </td>
                    <td width="6%"></td>
                    
                    <td width="6%">
                        <input class="mainbut" type="button" name="save_but" id="save" value="Save" onclick="document.Form1.save_but.disabled=true; parent.frames[1].beforesubmit();" />
                    </td>
                    <td width="6%">
                        <input class="mainbut" type="button" name="calcel_but" id="cancel" value="Cancel" onclick="document.Form1.save_but.disabled=false; top.frames[1].location.href=top.frames[1].location.href;" />
                    </td>
                    <td width="6%">
                        <input class="mainbut" type="button" name="Exit_but"  id="Exit" value="Exit" onclick="location.href='low.jsp'" />
                    </td>
                    <td width="6%">
                        <input class="mainbut" type="button" name="report_but" value="Enquiry" onclick="enquiry();" /> <!-- --disabled="disabled" remove by waruna 2012-02-10-->
                    </td>
                    <td width="50%" class="hh1" align="right" style="font-weight: bold;"><div id='div_lable' align='right' >Client Creation </div></td>
                </tr>
            </table>
            
            <table width="100%">
                <tr height="25px;"></tr>
            </table>
            <hr />
            <table width="100%">
                <tr height="25px;"></tr>
            </table>
            
            <br />
            
            <table width="100%">
                <tr>
                    <td style="width: 200px;">Client Type</td>
                    <td>
                        <select class="txt_input" name="TXT_CLIENT_TYPE" id="TXT_CLIENT_TYPE" style="width: 125px;" onchange="load_business_entity(); load_general_information();">
                            <option value="C" >Corporate</option>
                            <option value="I" selected="selected" >Individual</option>
						<!--	<option value="P" >PLC</option>--><!--added byPrabsh on 21-09-2012 -->
							
                        </select>
                        <select class="txt_input" name="TXT_BUSINESS_ENTITY" id="TXT_BUSINESS_ENTITY" style="width: 125px;">
                            <%= String.valueOf(business_entities) %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><div id="DIV_TXT_CLIENT_CODE">Client Code</div></td>
                    <td>
                        <input class="txt_input" type="text" name="TXT_CLIENT_CODE" id="TXT_CLIENT_CODE" maxlength="250" style="width: 125px;" disabled="disabled" onblur="strTrim(this); get_data_help_validation('client_code');" />
                        <input class="but_input but_input_client" type="button" name="BUT_HELP_CLIENT_MAIN" id="BUT_HELP_CLIENT_MAIN" value="..." disabled="disabled" onclick="popup_help(0, 'client_code');" />
                    </td>
                </tr>
                <tr>
                    <td><div id="DIV_TXT_FULL_NAME">Full Name *</div></td>
                    <td>
                        <input class="txt_input" type="text" name="TXT_FULL_NAME" id="TXT_FULL_NAME" maxlength="250" style="width: 250px;" onblur="strTrim(this, null, null, 'FULL_NAME'); strProperCase(this);" />
                    </td>
                </tr>
                <tr>
                    <td><div id="DIV_TXT_FULL_NAME_JOINT_HOLDER">Full Name - Joint Holder</div></td>
                    <td>
                        <input class="txt_input" type="text" name="TXT_FULL_NAME_JOINT_HOLDER" id="TXT_FULL_NAME_JOINT_HOLDER" maxlength="250" style="width: 250px;" onblur="strTrim(this, null, null, 'FULL_NAME'); strProperCase(this);" disabled="disabled" />
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        Joint Holder
                        <input type="checkbox" name="CHK_JOINT_HOLDER_STATUS" id="CHK_JOINT_HOLDER_STATUS" style="vertical-align: sub;" value="A" onclick="check_joint_holder_status();" />
                    </td>
                </tr>
            </table>
           
			<!---             -->
			 <br />
			 <table width="100%" border="0">
                
               <tr>
                   <td style="width: 200px;"><u><b>Stock Brokering Accounts</b></u></td>
                   <td></td>
               </tr>
           </table>
           <div id="DIV_STOCK_BROKERING_ACCOUNTS"></div>
			<!---             -->
			<br />
            <table width="100%">
                <tr>
                    <td style="width: 200px; font-weight: bold; text-decoration: underline;">Contact Information</td>
                    <td></td>
                </tr>
                <tr>
                    <td>Address Type</td>
                    <td>
                        <select class="txt_input" name="TXT_S01_ADDRESS_TYPE" id="TXT_S01_ADDRESS_TYPE" style="width: 125px;">
                            <%= String.valueOf(address_types) %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Ownership</td>
                    <td>
                        <select class="txt_input" name="TXT_S01_OWNERSHIP" id="TXT_S01_OWNERSHIP" style="width: 125px;">
                            <%= String.valueOf(ownership_types) %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Address Line 1</td>
                    <td>
                        <input class="txt_input" type="text" name="TXT_S01_ADDRESS_LINE_1" id="TXT_S01_ADDRESS_LINE_1" maxlength="100" style="width: 250px;" onblur="strTrim(this, null, null, 'ADDRESS'); strProperCase(this); copy_address();" />
                    </td>
                </tr>
                <tr>
                    <td>Address Line 2</td>
                    <td>
                        <input class="txt_input" type="text" name="TXT_S01_ADDRESS_LINE_2" id="TXT_S01_ADDRESS_LINE_2" maxlength="100" style="width: 250px;" onblur="strTrim(this, null, null, 'ADDRESS'); strProperCase(this); copy_address();" />
                    </td>
                </tr>
                <tr>
                    <td>City</td>
                    <td>
                        <input type="hidden" name="TXT_S01_CITY" id="TXT_S01_CITY" />
                        <input class="txt_input" type="text" name="TXT_S01_CITY_NAME" id="TXT_S01_CITY_NAME" maxlength="50" style="width: 125px;" onblur="strTrim(this); popup_help(0, 'city');" />
                        <input class="but_input but_input_client" type="button" name="BUT_HELP_S01_CITY" value="..." onclick="popup_help(0, 'city');" />
                    </td>
                </tr>
                <tr>
                    <td>District</td>
                    <td>
                        <input class="txt_input" type="text" name="TXT_S01_DISTRICT_NAME" id="TXT_S01_DISTRICT_NAME" style="width: 125px;" disabled="disabled" />
                    </td>
                </tr>
                <tr>
                    <td>Province</td>
                    <td>
                        <input class="txt_input" type="text" name="TXT_S01_PROVINCE_NAME" id="TXT_S01_PROVINCE_NAME" style="width: 125px;" disabled="disabled" />
                    </td>
                </tr>
                <tr>
                    <td>Country</td>
                    <td>
                        <input class="txt_input" type="text" name="TXT_S01_COUNTRY_NAME" id="TXT_S01_COUNTRY_NAME" style="width: 125px;" disabled="disabled" />
                    </td>
                    </tr>
                <tr>
                    <td>Attach Map</td>
                    <td>
                        <input class="txt_input" type="file" id="TXT_S01_MAP" name="TXT_S01_MAP" style="width: 250px;" />
                    </td>
                </tr>
                <tr>
                    <td>Attach Picture</td>
                    <td>
                        <input class="txt_input" type="file" id="TXT_S01_PICTURE" name="TXT_S01_PICTURE" style="width: 250px;" />
                    </td>
                </tr>
            </table>
            
            <br />
            
            <table width="100%" border="0">
                
               <tr>
                   <td style="width: 200px;"><u><b>Contact Person</b></u></td>
                   <td></td>
               </tr>
           </table>
           <div id="DIV_CONTACT_PERSON"></div>
           <br />
           <table width="100%" border="0">

               <tr >
                   <td style="width: 200px;"><u><b>General Information</b></u></td>
                   <td></td>
               </tr>
           </table>
           <div id="DIV_CLIENT_GENERAL_INFORMATION"></div>
           <br />
           <table width="100%" border="0">

               <tr>
                   <td style="width: 200px;"><u><b>Directors / Partners / Shareholders</b></u></td>
                   <td></td>
               </tr>
           </table>
           <div id="DIV_DIRECTORS_PARTNERS_SHAREHOLDERS"></div>
           <br />
           <table width="100%" border="0">

               <tr>
                   <td style="width: 300px;"><u><b>Subsidiaries & Associated Companies</b></u></td>
                   <td></td>
               </tr>
           </table>
           <div id="DIV_SUBSIDIARIES_AND_ASSOCIATED_COMPANIES"></div>
           <br />
           <table width="100%" border="0">

               <tr>
                   <td style="width: 200px;"><u><b>Financial Details</b></u></td>
                   <td></td>
               </tr>
           </table>
           <div id="DIV_AUDITORS_DETAILS"></div>
           <br />
           <table width="100%" border="0">

               <tr>
                   <td style="width: 200px;"><u><b>Accounts and Banking Details</b></u></td>
                   <td></td>
               </tr>
           </table>
           <div id="DIV_ACCOUNTS_AND_BANKING_DETAILS"></div>
           <br />
           <table width="100%" border="0">

               <tr>
             <td style="width: 200px;"><u><b>Details of Credit Facilities</b></u></td>
                   <td></td>
               </tr>
           </table>
           <div id="DIV_DETAILS_OF_CREDIT_FACILITIES"></div>
           
		  <table width="100%" border="0">

               <tr>
             <td style="width: 200px;"><u><b>Veiw Document</b></u></td>
                   <td></td>
               </tr>
           </table>	
           <div id="DIV_VEIW_DOCUMENT"></div>
			
			
           <!--<br />
           <table width="100%" border="0">
                
               <tr>
                   <td style="width: 200px;"><u><b>Stock Brokering Accounts</b></u></td>
                   <td></td>
               </tr>
           </table>
           <div id="DIV_STOCK_BROKERING_ACCOUNTS"></div>-->
			
			<table width="100%">
                <tr height="25px;"></tr>
            </table>
            <hr />

			
			<table width="100%" bgcolor="darkblue">
                <tr>
                    <td width="6%">
                        <input class="mainbut" type="button" name="Add" value="Add" onclick="display_rec_opt('ADD');" />
                    </td>
                    <td width="6%">
                        <input class="mainbut" type="button" name="MOD" value="Edit" onclick="display_rec_opt('MOD');" />
                    </td>
                    <td width="6%">
                        <input class="mainbut" type="button" name="DEL" value="Delete" onclick="display_rec_opt('DEL');" disabled="disabled" />
                    </td>
                    <td width="6%"></td>
                    
                    <td width="6%">
                        <input class="mainbut" type="button" name="save_but" value="Save" onclick="document.Form1.save_but.disabled=true; parent.frames[1].beforesubmit();" />
                    </td>
                    <td width="6%">
                        <input class="mainbut" type="button" name="calcel_but" value="Cancel" onclick="document.Form1.save_but.disabled=false; top.frames[1].location.href=top.frames[1].location.href;" />
                    </td>
                    <td width="6%">
                        <input class="mainbut" type="button" name="Exit_but" value="Exit" onclick="location.href='low.jsp'" />
                    </td>
                    <td width="6%">
                        <input class="mainbut" type="button" name="report_but" value="Enquiry" onclick="enquiry();" /><!-- disabled="disabled" remove by waruna 2012-02-10-->
                    </td>
					<TD WIDTH="*%"> &nbsp; </TD>

                </tr>
            </table>

            
        </form>
    </body>
</html>
