<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
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
    
    String screen_title;
    
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
    
    
    screen_title = "Margin Trading";
    
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title><%= screen_title %></title>
        <meta name="generator" content="ModelWorks IDE" />
        
        <script type="text/javascript" src="<%= jsp_client_url %>/js/jquery.min.js"></script>
        <script type="text/javascript" src="<%= jsp_client_url %>/js/jquery-ui.min.js"></script>
        <script type="text/javascript" src="<%= jsp_client_url %>/SNET/jquery/grid/4.1/js/i18n/grid.locale-en.js"></script>
        <script type="text/javascript" src="<%= jsp_client_url %>/SNET/jquery/grid/4.1/js/jquery.jqGrid.min.js"></script>
        <script type="text/javascript" src="validate.js"></script>
        <!-- <script type="text/javascript" src="factoring_drill_down.js"></script> -->
        <script type="text/javascript" src="ajax_data_gateway.js"></script>
        
        <link rel="stylesheet" type="text/css" href="<%= jsp_client_url %>/css/Asset_Financing_System.css" />
        <link rel="stylesheet" type="text/css" href="<%= jsp_client_url %>/css/redmond/jquery-ui.css" media="screen" />
        <link rel="stylesheet" type="text/css" href="<%= jsp_client_url %>/css/ui.jqgrid.css" media="screen" />
       
        <style type="text/css">
            .local_jq_grid_row_1 {
                display: table-cell;
                height: 22px;
                vertical-align: middle;
                width: 195px;
                text-align: left;
            }
            .local_jq_grid_row_2 {
                display: table-cell;
                height: 22px;
                vertical-align: middle;
                width: 145px;
                text-align: right;
            }
            .local_jq_grid_row_2_text {
                width: 140px;
                text-align: right;
            }
        </style>
        
        <script type="text/javascript">
            
            var g_row_number        = '<%= request.getParameter("row_number") %>';
            var g_auditor_details   = '<%= request.getParameter("auditor_details") %>';
            var g_sysdate           = '<%= sysdate %>';
            var g_sysdate_dd        = g_sysdate.substr(0, 2);
            var g_sysdate_mm        = g_sysdate.substr(3, 2);
            var g_sysdate_yy        = g_sysdate.substr(6, 4);
            
            
            $(document).ready(function() {
                loadGrid_1();
            });
            
            
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
                if (first_part == 'TXT_VALUE_DATE_PL_') {
                    document.Form1.elements['TXT_VALUE_DATE_PL_DD_' + second_part].value = splitResult[0];
                    document.Form1.elements['TXT_VALUE_DATE_PL_MM_' + second_part].value = splitResult[1];
                    document.Form1.elements['TXT_VALUE_DATE_PL_YY_' + second_part].value = splitResult[2];
                    document.Form1.elements['TXT_VALUE_DATE_BS_DD_' + second_part].value = splitResult[0];
                    document.Form1.elements['TXT_VALUE_DATE_BS_MM_' + second_part].value = splitResult[1];
                    document.Form1.elements['TXT_VALUE_DATE_BS_YY_' + second_part].value = splitResult[2];
                    document.Form1.elements['TXT_VALUE_DATE_BS_' + second_part].value = splitResult[0] + '-' + splitResult[1] + '-' + splitResult[2];
                }
                else if (first_part == 'TXT_VALUE_DATE_BS_') {
                    document.Form1.elements['TXT_VALUE_DATE_BS_DD_' + second_part].value = splitResult[0];
                    document.Form1.elements['TXT_VALUE_DATE_BS_MM_' + second_part].value = splitResult[1];
                    document.Form1.elements['TXT_VALUE_DATE_BS_YY_' + second_part].value = splitResult[2];
                    document.Form1.elements['TXT_VALUE_DATE_PL_DD_' + second_part].value = splitResult[0];
                    document.Form1.elements['TXT_VALUE_DATE_PL_MM_' + second_part].value = splitResult[1];
                    document.Form1.elements['TXT_VALUE_DATE_PL_YY_' + second_part].value = splitResult[2];
                    document.Form1.elements['TXT_VALUE_DATE_PL_' + second_part].value = splitResult[0] + '-' + splitResult[1] + '-' + splitResult[2];
                }
            }
            
            
            function synchronizeDates(m_str_textbox_type, m_int_column_id) {
                if (m_str_textbox_type == 'PL') {
                    document.Form1.elements['TXT_VALUE_DATE_BS_' + m_int_column_id].value    = document.Form1.elements['TXT_VALUE_DATE_PL_' + m_int_column_id].value;
                    document.Form1.elements['TXT_VALUE_DATE_BS_DD_' + m_int_column_id].value = document.Form1.elements['TXT_VALUE_DATE_PL_DD_' + m_int_column_id].value;
                    document.Form1.elements['TXT_VALUE_DATE_BS_MM_' + m_int_column_id].value = document.Form1.elements['TXT_VALUE_DATE_PL_MM_' + m_int_column_id].value;
                    document.Form1.elements['TXT_VALUE_DATE_BS_YY_' + m_int_column_id].value = document.Form1.elements['TXT_VALUE_DATE_PL_YY_' + m_int_column_id].value;
                }
                else if (m_str_textbox_type == 'BS') {
                    document.Form1.elements['TXT_VALUE_DATE_PL_' + m_int_column_id].value    = document.Form1.elements['TXT_VALUE_DATE_BS_' + m_int_column_id].value;
                    document.Form1.elements['TXT_VALUE_DATE_PL_DD_' + m_int_column_id].value = document.Form1.elements['TXT_VALUE_DATE_BS_DD_' + m_int_column_id].value;
                    document.Form1.elements['TXT_VALUE_DATE_PL_MM_' + m_int_column_id].value = document.Form1.elements['TXT_VALUE_DATE_BS_MM_' + m_int_column_id].value;
                    document.Form1.elements['TXT_VALUE_DATE_PL_YY_' + m_int_column_id].value = document.Form1.elements['TXT_VALUE_DATE_BS_YY_' + m_int_column_id].value;
                }
            }
            
            
            /* ***** JQuery Grid - Account Analysis Form - Profit & Loss Section ***** */
            function loadGrid_1() {
                var m_url = servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Client?&chksql=load_auditor_grid&type=profit_loss';
                jQuery('#TABLE_AUDITOR_DETAILS_PL').jqGrid( {
                    url: m_url,
                    loadonce: 1,
                    datatype: 'xml',
                    colNames: [
                        '',
                        'Enter the most current year',
                        '',
                        '',
                        '',
                        '',
                        ''
                    ],
                    colModel: [
                        {name: 'COLUMN_LABEL',  index: 'COLUMN_LABEL',  sortable: false,    align: 'center',    width: 200, resizable: false,   formatter: cellFormatterProfitLossColumnLabel},
                        {name: 'MONTH_1',       index: 'MONTH_1',       sortable: false,    align: 'center',    width: 165, resizable: false,   formatter: cellFormatterProfitLossColumnMonth_1},
                        {name: 'MONTH_2',       index: 'MONTH_2',       sortable: false,    align: 'center',    width: 165, resizable: false,   formatter: cellFormatterProfitLossColumnMonth_2},
                        {name: 'MONTH_3',       index: 'MONTH_3',       sortable: false,    align: 'center',    width: 165, resizable: false,   formatter: cellFormatterProfitLossColumnMonth_3},
                        {name: 'MONTH_4',       index: 'MONTH_4',       sortable: false,    align: 'center',    width: 165, resizable: false,   formatter: cellFormatterProfitLossColumnMonth_4},
                        {name: 'MONTH_5',       index: 'MONTH_5',       sortable: false,    align: 'center',    width: 165, resizable: false,   formatter: cellFormatterProfitLossColumnMonth_5},
                        {name: 'MONTH_6',       index: 'MONTH_6',       sortable: false,    align: 'center',    width: 165, resizable: false,   formatter: cellFormatterProfitLossColumnMonth_6},
                    ],
                    rownumbers: false,
                    rowNum: -1,
                    height: 'auto',
                    gridComplete : loadGrid_2,
                    caption: '<div id "DIV_AUDITOR_DETAILS_PL_CAPTION" style = "width: 950px; text-align: center; font-size: 12px;">Profit and  Loss Statement for the Year</div>'
                });
            }
            
            
            function loadGrid_2() {
                var m_url = servlet_client_url + ':' + client_t3_port + '/' + client_name + 'Get_Data_Client?&chksql=load_auditor_grid&type=balance_sheet';
                jQuery('#TABLE_AUDITOR_DETAILS_BS').jqGrid( {
                    url: m_url,
                    loadonce: 1,
                    datatype: 'xml',
                    colNames: [
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        ''
                    ],
                    colModel: [
                        {name: 'COLUMN_LABEL',  index: 'COLUMN_LABEL',  sortable: false,    align: 'center',    width: 200, resizable: false,   formatter: cellFormatterBalanceSheetColumnLabel},
                        {name: 'MONTH_1',       index: 'MONTH_1',       sortable: false,    align: 'center',    width: 165, resizable: false,   formatter: cellFormatterBalanceSheetColumnMonth_1},
                        {name: 'MONTH_2',       index: 'MONTH_2',       sortable: false,    align: 'center',    width: 165, resizable: false,   formatter: cellFormatterBalanceSheetColumnMonth_2},
                        {name: 'MONTH_3',       index: 'MONTH_3',       sortable: false,    align: 'center',    width: 165, resizable: false,   formatter: cellFormatterBalanceSheetColumnMonth_3},
                        {name: 'MONTH_4',       index: 'MONTH_4',       sortable: false,    align: 'center',    width: 165, resizable: false,   formatter: cellFormatterBalanceSheetColumnMonth_4},
                        {name: 'MONTH_5',       index: 'MONTH_5',       sortable: false,    align: 'center',    width: 165, resizable: false,   formatter: cellFormatterBalanceSheetColumnMonth_5},
                        {name: 'MONTH_6',       index: 'MONTH_6',       sortable: false,    align: 'center',    width: 165, resizable: false,   formatter: cellFormatterBalanceSheetColumnMonth_6},
                    ],
                    rownumbers: false,
                    rowNum: -1,
                    height: 'auto',
                    gridComplete : gridCompleteFunction,
                    caption: '<div id "DIV_AUDITOR_DETAILS_PL_CAPTION" style = "width: 950px; text-align: center; font-size: 12px;">Balance Sheet as at</div>'
                });
            }
            
            
            function gridCompleteFunction() {
                for (var i = 1; i <= 6; i++) {
                    initCal('TXT_VALUE_DATE_PL_' + i);
                    initCal('TXT_VALUE_DATE_BS_' + i);
                }
                if (g_auditor_details.length > 0) {
                    var arr_auditor_details = new Array();
                    arr_auditor_details = g_auditor_details.split(',');
                    var j = 0;
                    for (var i = 1; i <= 6; i++) {
                        document.Form1.elements['TXT_VALUE_DATE_PL_' + i].value             = arr_auditor_details[j + 0];
                        document.Form1.elements['TXT_VALUE_DATE_PL_DD_' + i].value          = arr_auditor_details[j + 0].substring(0, 2);
                        document.Form1.elements['TXT_VALUE_DATE_PL_MM_' + i].value          = arr_auditor_details[j + 0].substring(3, 5);
                        document.Form1.elements['TXT_VALUE_DATE_PL_YY_' + i].value          = arr_auditor_details[j + 0].substring(6, 10);
                        document.Form1.elements['TXT_VALUE_DATE_BS_' + i].value             = arr_auditor_details[j + 0];
                        document.Form1.elements['TXT_VALUE_DATE_BS_DD_' + i].value          = arr_auditor_details[j + 0].substring(0, 2);
                        document.Form1.elements['TXT_VALUE_DATE_BS_MM_' + i].value          = arr_auditor_details[j + 0].substring(3, 5);
                        document.Form1.elements['TXT_VALUE_DATE_BS_YY_' + i].value          = arr_auditor_details[j + 0].substring(6, 10);
                        document.Form1.elements['TXT_PRICE_INDEX_' + i].value               = format_noobject0(arr_auditor_details[j + 1], 2);
                        document.Form1.elements['TXT_TURNOVER_' + i].value                  = format_noobject0(arr_auditor_details[j + 2], 2);
                        document.Form1.elements['TXT_OPERATING_COSTS_' + i].value           = format_noobject0(arr_auditor_details[j + 3], 2);
                        document.Form1.elements['TXT_DEPRECATION_' + i].value               = format_noobject0(arr_auditor_details[j + 4], 2);
                        document.Form1.elements['TXT_ADMINISTRATION_COST_' + i].value       = format_noobject0(arr_auditor_details[j + 5], 2);
                        document.Form1.elements['TXT_DISTRIBUTION_COST_' + i].value         = format_noobject0(arr_auditor_details[j + 6], 2);
                        document.Form1.elements['TXT_CORPORATION_TAX_' + i].value           = format_noobject0(arr_auditor_details[j + 7], 2);
                        document.Form1.elements['TXT_FINANCE_COST_' + i].value              = format_noobject0(arr_auditor_details[j + 8], 2);
                        document.Form1.elements['TXT_OTHER_INCOME_' + i].value              = format_noobject0(arr_auditor_details[j + 9], 2);
                        document.Form1.elements['TXT_DIVIDENDS_' + i].value                 = format_noobject0(arr_auditor_details[j + 10], 2);
                        document.Form1.elements['TXT_TANGIBLE_' + i].value                  = format_noobject0(arr_auditor_details[j + 11], 2);
                        document.Form1.elements['TXT_INTANGIBLE_' + i].value                = format_noobject0(arr_auditor_details[j + 12], 2);
                        document.Form1.elements['TXT_INVESTMENTS_' + i].value               = format_noobject0(arr_auditor_details[j + 13], 2);
                        document.Form1.elements['TXT_ST_' + i].value                        = format_noobject0(arr_auditor_details[j + 14], 2);
                        document.Form1.elements['TXT_DEBTORS_' + i].value                   = format_noobject0(arr_auditor_details[j + 15], 2);
                        document.Form1.elements['TXT_OTHER_RECEIVABLES_' + i].value         = format_noobject0(arr_auditor_details[j + 16], 2);
                        document.Form1.elements['TXT_CASH_AND_BANK_BALANCES_' + i].value    = format_noobject0(arr_auditor_details[j + 17], 2);
                        document.Form1.elements['TXT_CREDITORS_' + i].value                 = format_noobject0(arr_auditor_details[j + 18], 2);
                        document.Form1.elements['TXT_SUNDRY_CREDITORS_' + i].value          = format_noobject0(arr_auditor_details[j + 19], 2);
                        document.Form1.elements['TXT_STATUTORY_LIABILITIES_' + i].value     = format_noobject0(arr_auditor_details[j + 20], 2);
                        document.Form1.elements['TXT_SHORT_TERM_LOANS_' + i].value          = format_noobject0(arr_auditor_details[j + 21], 2);
                        document.Form1.elements['TXT_BANK_OVERDRAFT_' + i].value            = format_noobject0(arr_auditor_details[j + 22], 2);
                        document.Form1.elements['TXT_LONG_TERM_LOAN_' + i].value            = format_noobject0(arr_auditor_details[j + 23], 2);
                        document.Form1.elements['TXT_SHARE_CAPITAL_' + i].value             = format_noobject0(arr_auditor_details[j + 24], 2);
                        document.Form1.elements['TXT_RESERVES_' + i].value                  = format_noobject0(arr_auditor_details[j + 25], 2);
                        document.Form1.elements['TXT_PROFIT_LOSS_' + i].value               = format_noobject0(arr_auditor_details[j + 26], 2);
                        document.Form1.elements['TXT_RETAINED_EARNINGS_' + i].value         = format_noobject0(arr_auditor_details[j + 27], 2);
                        j = j + 28;
                        localCalculateNumber('PL', i);
                        localCalculateNumber('BS', i);
                    }
                }
            }
            
            
            function cellFormatterProfitLossColumnLabel(cellvalue, options, rowObject) {
                var str_row_id = rowObject.getAttribute('id');
                var int_row_id = parseInt(str_row_id);
                switch (int_row_id) {
                    case 1:
                        cellvalue = '<div class = "local_jq_grid_row_1"></div>';
                        break;
                    case 2:
                        cellvalue = '<div class = "local_jq_grid_row_1"></div>';
                        break;
                    case 3:
                        cellvalue = '<div class = "local_jq_grid_row_1">Price Index (Rs.)</div>';
                        break;
                    case 4:
                        cellvalue = '<div class = "local_jq_grid_row_1"></div>';
                        break;
                    case 5:
                        cellvalue = '<div class = "local_jq_grid_row_1">Turnover</div>';
                        break;
                    case 6:
                        cellvalue = '<div class = "local_jq_grid_row_1">Operating Costs</div>';
                        break;
                    case 7:
                        cellvalue = '<div class = "local_jq_grid_row_1"><b>Gross Profit</b></div>';
                        break;
                    case 8:
                        cellvalue = '<div class = "local_jq_grid_row_1"><b><u>Less</u></b></div>';
                        break;
                    case 9:
                        cellvalue = '<div class = "local_jq_grid_row_1">Deprecation</div>';
                        break;
                    case 10:
                        cellvalue = '<div class = "local_jq_grid_row_1">Administration Cost</div>';
                        break;
                    case 11:
                        cellvalue = '<div class = "local_jq_grid_row_1">Distribution Cost</div>';
                        break;
                    case 12:
                        cellvalue = '<div class = "local_jq_grid_row_1">Finance Cost</div>';
                        break;
                    case 13:
                        cellvalue = '<div class = "local_jq_grid_row_1">Corporation Tax</div>';
                        break;
                    case 14:
                        cellvalue = '<div class = "local_jq_grid_row_1"><b><u>Add</u></b></div>';
                        break;
                    case 15:
                        cellvalue = '<div class = "local_jq_grid_row_1">Other Income</div>';
                        break;
                    case 16:
                        cellvalue = '<div class = "local_jq_grid_row_1"></div>';
                        break;
                    case 17:
                        cellvalue = '<div class = "local_jq_grid_row_1"><b>Net Profit</b></div>';
                        break;
                    case 18:
                        cellvalue = '<div class = "local_jq_grid_row_1">Dividends</div>';
                        break;
                    case 19:
                        cellvalue = '<div class = "local_jq_grid_row_1"></div>';
                        break;
                }
                return cellvalue;
            }
            
            
            function cellFormatterProfitLossColumnMonth_1(cellvalue, options, rowObject) {
                var str_row_id = rowObject.getAttribute('id');
                var int_row_id = parseInt(str_row_id);
                var int_column_id = 1;
                cellvalue = fillTableCellsProfitLoss(int_row_id, int_column_id);
                return cellvalue;
            }
            
            
            function cellFormatterProfitLossColumnMonth_2(cellvalue, options, rowObject) {
                var str_row_id = rowObject.getAttribute('id');
                var int_row_id = parseInt(str_row_id);
                var int_column_id = 2;
                cellvalue = fillTableCellsProfitLoss(int_row_id, int_column_id);
                return cellvalue;
            }
            
            
            function cellFormatterProfitLossColumnMonth_3(cellvalue, options, rowObject) {
                var str_row_id = rowObject.getAttribute('id');
                var int_row_id = parseInt(str_row_id);
                var int_column_id = 3;
                cellvalue = fillTableCellsProfitLoss(int_row_id, int_column_id);
                return cellvalue;
            }
            
            
            function cellFormatterProfitLossColumnMonth_4(cellvalue, options, rowObject) {
                var str_row_id = rowObject.getAttribute('id');
                var int_row_id = parseInt(str_row_id);
                var int_column_id = 4;
                cellvalue = fillTableCellsProfitLoss(int_row_id, int_column_id);
                return cellvalue;
            }
            
            
            function cellFormatterProfitLossColumnMonth_5(cellvalue, options, rowObject) {
                var str_row_id = rowObject.getAttribute('id');
                var int_row_id = parseInt(str_row_id);
                var int_column_id = 5;
                cellvalue = fillTableCellsProfitLoss(int_row_id, int_column_id);
                return cellvalue;
            }
            
            
            function cellFormatterProfitLossColumnMonth_6(cellvalue, options, rowObject) {
                var str_row_id = rowObject.getAttribute('id');
                var int_row_id = parseInt(str_row_id);
                var int_column_id = 6;
                cellvalue = fillTableCellsProfitLoss(int_row_id, int_column_id);
                return cellvalue;
            }
            
            
            function fillTableCellsProfitLoss(m_int_row_id, m_int_column_id) {
                var str_cell_value = '';
                switch (m_int_row_id) {
                    case 1:
                        str_cell_value = '<div class = "local_jq_grid_row_2" style = "text-align: center;">' + 
                                         '<input class = "txt_input5" type = "text" name = "TXT_VALUE_DATE_PL_DD_' + m_int_column_id + '" id = "TXT_VALUE_DATE_PL_DD_' + m_int_column_id + '" maxlength = "2" size = "2" value = "' + g_sysdate_dd + '" onBlur = "checkMonthLength1(document.Form1.elements[\'TXT_VALUE_DATE_PL_DD_' + m_int_column_id + '\'], document.Form1.elements[\'TXT_VALUE_DATE_PL_MM_' + m_int_column_id + '\'], document.Form1.elements[\'TXT_VALUE_DATE_PL_YY_' + m_int_column_id + '\'], document.Form1.elements[\'TXT_VALUE_DATE_PL_' + m_int_column_id + '\'], \'D\', \'N\'); synchronizeDates(\'PL\', ' + m_int_column_id + ');" /> ' + 
                                         '<input class = "txt_input5" type = "text" name = "TXT_VALUE_DATE_PL_MM_' + m_int_column_id + '" id = "TXT_VALUE_DATE_PL_MM_' + m_int_column_id + '"maxlength = "2" size = "2" value = "' + g_sysdate_mm + '" onBlur = "checkMonthLength1(document.Form1.elements[\'TXT_VALUE_DATE_PL_DD_' + m_int_column_id + '\'], document.Form1.elements[\'TXT_VALUE_DATE_PL_MM_' + m_int_column_id + '\'], document.Form1.elements[\'TXT_VALUE_DATE_PL_YY_' + m_int_column_id + '\'], document.Form1.elements[\'TXT_VALUE_DATE_PL_' + m_int_column_id + '\'], \'M\', \'N\'); synchronizeDates(\'PL\', ' + m_int_column_id + ');" /> ' + 
                                         '<input class = "txt_input5" type = "text" name = "TXT_VALUE_DATE_PL_YY_' + m_int_column_id + '" id = "TXT_VALUE_DATE_PL_YY_' + m_int_column_id + '"maxlength = "4" size = "4" value = "' + g_sysdate_yy + '" onBlur = "checkMonthLength1(document.Form1.elements[\'TXT_VALUE_DATE_PL_DD_' + m_int_column_id + '\'], document.Form1.elements[\'TXT_VALUE_DATE_PL_MM_' + m_int_column_id + '\'], document.Form1.elements[\'TXT_VALUE_DATE_PL_YY_' + m_int_column_id + '\'], document.Form1.elements[\'TXT_VALUE_DATE_PL_' + m_int_column_id + '\'], \'Y\', \'N\'); synchronizeDates(\'PL\', ' + m_int_column_id + ');" /> ' + 
                                         '<input type = "hidden" name = "TXT_VALUE_DATE_PL_' + m_int_column_id + '" id = "TXT_VALUE_DATE_PL_' + m_int_column_id + '" value = "' + g_sysdate + '" /> ' + 
                                         '</div>';
                        break;
                    case 2:
                        str_cell_value = '<div class = "local_jq_grid_row_2"></div>';
                        break;
                    case 3:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_PRICE_INDEX_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberProfitLoss(this);" /></div>';
                        break;
                    case 4:
                        str_cell_value = '<div class = "local_jq_grid_row_2"></div>';
                        break;
                    case 5:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_TURNOVER_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberProfitLoss(this);" /></div>';
                        break;
                    case 6:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_OPERATING_COSTS_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberProfitLoss(this);" /></div>';
                        break;
                    case 7:
                        str_cell_value = '<div class = "local_jq_grid_row_2" id = "DIV_GROSS_PROFIT_' + m_int_column_id + '"><b>0.00</b></div>';
                        break;
                    case 8:
                        str_cell_value = '<div class = "local_jq_grid_row_2"></div>';
                        break;
                    case 9:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_DEPRECATION_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberProfitLoss(this);" /></div>';
                        break;
                    case 10:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_ADMINISTRATION_COST_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberProfitLoss(this);" /></div>';
                        break;
                    case 11:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_DISTRIBUTION_COST_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberProfitLoss(this);" /></div>';
                        break;
                    case 12:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_FINANCE_COST_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberProfitLoss(this);" /></div>';
                        break;
                    case 13:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_CORPORATION_TAX_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberProfitLoss(this);" /></div>';
                        break;
                    case 14:
                        str_cell_value = '<div class = "local_jq_grid_row_2"></div>';
                        break;
                    case 15:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_OTHER_INCOME_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberProfitLoss(this);" /></div>';
                        break;
                    case 16:
                        str_cell_value = '<div class = "local_jq_grid_row_2"></div>';
                        break;
                    case 17:
                        str_cell_value = '<div class = "local_jq_grid_row_2" id = "DIV_NET_PROFIT_' + m_int_column_id + '"><b>0.00</b></div>';
                        break;
                    case 18:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_DIVIDENDS_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberProfitLoss(this);" /></div>';
                        break;
                    case 19:
                        str_cell_value = '<div class = "local_jq_grid_row_2"></div>';
                        break;
                }
                return str_cell_value;
            }
            
            
            function cellFormatterBalanceSheetColumnLabel(cellvalue, options, rowObject) {
                var str_row_id = rowObject.getAttribute('id');
                var int_row_id = parseInt(str_row_id);
                switch (int_row_id) {
                    case 1:
                        cellvalue = '<div class = "local_jq_grid_row_1"></div>';
                        break;
                    case 2:
                        cellvalue = '<div class = "local_jq_grid_row_1"></div>';
                        break;
                    case 3:
                        cellvalue = '<div class = "local_jq_grid_row_1"><b>Fixed Assets</b></div>';
                        break;
                    case 4:
                        cellvalue = '<div class = "local_jq_grid_row_1">Tangible</div>';
                        break;
                    case 5:
                        cellvalue = '<div class = "local_jq_grid_row_1">Intangible</div>';
                        break;
                    case 6:
                        cellvalue = '<div class = "local_jq_grid_row_1">Investments</div>';
                        break;
                    case 7:
                        cellvalue = '<div class = "local_jq_grid_row_1"></div>';
                        break;
                    case 8:
                        cellvalue = '<div class = "local_jq_grid_row_1"><b>Fixed Assets</b></div>';
                        break;
                    case 9:
                        cellvalue = '<div class = "local_jq_grid_row_1"></div>';
                        break;
                    case 10:
                        cellvalue = '<div class = "local_jq_grid_row_1"><b>Current Assets</b></div>';
                        break;
                    case 11:
                        cellvalue = '<div class = "local_jq_grid_row_1">ST</div>';
                        break;
                    case 12:
                        cellvalue = '<div class = "local_jq_grid_row_1">Debtors</div>';
                        break;
                    case 13:
                        cellvalue = '<div class = "local_jq_grid_row_1">Other Receivables</div>';
                        break;
                    case 14:
                        cellvalue = '<div class = "local_jq_grid_row_1">Cash &amp Bank Balances</div>';
                        break;
                    case 15:
                        cellvalue = '<div class = "local_jq_grid_row_1"></div>';
                        break;
                    case 16:
                        cellvalue = '<div class = "local_jq_grid_row_1"><b>Current Assets</b></div>';
                        break;
                    case 17:
                        cellvalue = '<div class = "local_jq_grid_row_1"></div>';
                        break;
                    case 18:
                        cellvalue = '<div class = "local_jq_grid_row_1"><b>Current Liabilities</b></div>';
                        break;
                    case 19:
                        cellvalue = '<div class = "local_jq_grid_row_1">Creditors</div>';
                        break;
                    case 20:
                        cellvalue = '<div class = "local_jq_grid_row_1">Sundry Creditors</div>';
                        break;
                    case 21:
                        cellvalue = '<div class = "local_jq_grid_row_1">Statutory Liabilities</div>';
                        break;
                    case 22:
                        cellvalue = '<div class = "local_jq_grid_row_1">Short Term Loans</div>';
                        break;
                    case 23:
                        cellvalue = '<div class = "local_jq_grid_row_1">Bank Overdraft</div>';
                        break;
                    case 24:
                        cellvalue = '<div class = "local_jq_grid_row_1"></div>';
                        break;
                    case 25:
                        cellvalue = '<div class = "local_jq_grid_row_1"><b>Current Liabilities</b></div>';
                        break;
                    case 26:
                        cellvalue = '<div class = "local_jq_grid_row_1"></div>';
                        break;
                    case 27:
                        cellvalue = '<div class = "local_jq_grid_row_1"><b>Long Term Liabilities</b></div>';
                        break;
                    case 28:
                        cellvalue = '<div class = "local_jq_grid_row_1">Long Term Loans</div>';
                        break;
                    case 29:
                        cellvalue = '<div class = "local_jq_grid_row_1"></div>';
                        break;
                    case 30:
                        cellvalue = '<div class = "local_jq_grid_row_1"><b>Net Assets</b></div>';
                        break;
                    case 31:
                        cellvalue = '<div class = "local_jq_grid_row_1"></div>';
                        break;
                    case 32:
                        cellvalue = '<div class = "local_jq_grid_row_1">Share Capital</div>';
                        break;
                    case 33:
                        cellvalue = '<div class = "local_jq_grid_row_1">Reserves</div>';
                        break;
                    case 34:
                        cellvalue = '<div class = "local_jq_grid_row_1">Profit / (Loss)</div>';
                        break;
                    case 35:
                        cellvalue = '<div class = "local_jq_grid_row_1">Retained Earnings</div>';
                        break;
                    case 36:
                        cellvalue = '<div class = "local_jq_grid_row_1"></div>';
                        break;
                    case 37:
                        cellvalue = '<div class = "local_jq_grid_row_1"><b>Share Holders Funds</b></div>';
                        break;
                    case 38:
                        cellvalue = '<div class = "local_jq_grid_row_1"></div>';
                        break;
                }
                return cellvalue;
            }
            
            
            function cellFormatterBalanceSheetColumnMonth_1(cellvalue, options, rowObject) {
                var str_row_id = rowObject.getAttribute('id');
                var int_row_id = parseInt(str_row_id);
                var int_column_id = 1;
                cellvalue = fillTableCellsBalanceSheet(int_row_id, int_column_id);
                return cellvalue;
            }
            
            
            function cellFormatterBalanceSheetColumnMonth_2(cellvalue, options, rowObject) {
                var str_row_id = rowObject.getAttribute('id');
                var int_row_id = parseInt(str_row_id);
                var int_column_id = 2;
                cellvalue = fillTableCellsBalanceSheet(int_row_id, int_column_id);
                return cellvalue;
            }
            
            
            function cellFormatterBalanceSheetColumnMonth_3(cellvalue, options, rowObject) {
                var str_row_id = rowObject.getAttribute('id');
                var int_row_id = parseInt(str_row_id);
                var int_column_id = 3;
                cellvalue = fillTableCellsBalanceSheet(int_row_id, int_column_id);
                return cellvalue;
            }
            
            
            function cellFormatterBalanceSheetColumnMonth_4(cellvalue, options, rowObject) {
                var str_row_id = rowObject.getAttribute('id');
                var int_row_id = parseInt(str_row_id);
                var int_column_id = 4;
                cellvalue = fillTableCellsBalanceSheet(int_row_id, int_column_id);
                return cellvalue;
            }
            
            
            function cellFormatterBalanceSheetColumnMonth_5(cellvalue, options, rowObject) {
                var str_row_id = rowObject.getAttribute('id');
                var int_row_id = parseInt(str_row_id);
                var int_column_id = 5;
                cellvalue = fillTableCellsBalanceSheet(int_row_id, int_column_id);
                return cellvalue;
            }
            
            
            function cellFormatterBalanceSheetColumnMonth_6(cellvalue, options, rowObject) {
                var str_row_id = rowObject.getAttribute('id');
                var int_row_id = parseInt(str_row_id);
                var int_column_id = 6;
                cellvalue = fillTableCellsBalanceSheet(int_row_id, int_column_id);
                return cellvalue;
            }
            
            
            function fillTableCellsBalanceSheet(m_int_row_id, m_int_column_id) {
                var str_cell_value = '';
                switch (m_int_row_id) {
                    case 1:
                        str_cell_value = '<div class = "local_jq_grid_row_2" style = "text-align: center;">' + 
                                         '<input class = "txt_input5" type = "text" name = "TXT_VALUE_DATE_BS_DD_' + m_int_column_id + '" id = "TXT_VALUE_DATE_BS_DD_' + m_int_column_id + '" maxlength = "2" size = "2" value = "' + g_sysdate_dd + '" onBlur = "checkMonthLength1(document.Form1.elements[\'TXT_VALUE_DATE_BS_DD_' + m_int_column_id + '\'], document.Form1.elements[\'TXT_VALUE_DATE_BS_MM_' + m_int_column_id + '\'], document.Form1.elements[\'TXT_VALUE_DATE_BS_YY_' + m_int_column_id + '\'], document.Form1.elements[\'TXT_VALUE_DATE_BS_' + m_int_column_id + '\'], \'D\', \'N\'); synchronizeDates(\'BS\', ' + m_int_column_id + ');" /> ' + 
                                         '<input class = "txt_input5" type = "text" name = "TXT_VALUE_DATE_BS_MM_' + m_int_column_id + '" id = "TXT_VALUE_DATE_BS_MM_' + m_int_column_id + '"maxlength = "2" size = "2" value = "' + g_sysdate_mm + '" onBlur = "checkMonthLength1(document.Form1.elements[\'TXT_VALUE_DATE_BS_DD_' + m_int_column_id + '\'], document.Form1.elements[\'TXT_VALUE_DATE_BS_MM_' + m_int_column_id + '\'], document.Form1.elements[\'TXT_VALUE_DATE_BS_YY_' + m_int_column_id + '\'], document.Form1.elements[\'TXT_VALUE_DATE_BS_' + m_int_column_id + '\'], \'M\', \'N\'); synchronizeDates(\'BS\', ' + m_int_column_id + ');" /> ' + 
                                         '<input class = "txt_input5" type = "text" name = "TXT_VALUE_DATE_BS_YY_' + m_int_column_id + '" id = "TXT_VALUE_DATE_BS_YY_' + m_int_column_id + '"maxlength = "4" size = "4" value = "' + g_sysdate_yy + '" onBlur = "checkMonthLength1(document.Form1.elements[\'TXT_VALUE_DATE_BS_DD_' + m_int_column_id + '\'], document.Form1.elements[\'TXT_VALUE_DATE_BS_MM_' + m_int_column_id + '\'], document.Form1.elements[\'TXT_VALUE_DATE_BS_YY_' + m_int_column_id + '\'], document.Form1.elements[\'TXT_VALUE_DATE_BS_' + m_int_column_id + '\'], \'Y\', \'N\'); synchronizeDates(\'BS\', ' + m_int_column_id + ');" /> ' + 
                                         '<input type = "hidden" name = "TXT_VALUE_DATE_BS_' + m_int_column_id + '" id = "TXT_VALUE_DATE_BS_' + m_int_column_id + '" value = "' + g_sysdate + '" /> ' + 
                                         '</div>';
                        break;
                    case 2:
                        str_cell_value = '<div class = "local_jq_grid_row_2"></div>';
                        break;
                    case 3:
                        str_cell_value = '<div class = "local_jq_grid_row_2"></div>';
                        break;
                    case 4:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_TANGIBLE_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberBalanceSheet(this);" /></div>';
                        break;
                    case 5:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_INTANGIBLE_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberBalanceSheet(this);" /></div>';
                        break;
                    case 6:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_INVESTMENTS_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberBalanceSheet(this);" /></div>';
                        break;
                    case 7:
                        str_cell_value = '<div class = "local_jq_grid_row_2"></div>';
                        break;
                    case 8:
                        str_cell_value = '<div class = "local_jq_grid_row_2" id = "DIV_FIXED_ASSETS_' + m_int_column_id + '"><b>0.00</b></div>';
                        break;
                    case 9:
                        str_cell_value = '<div class = "local_jq_grid_row_2"></div>';
                        break;
                    case 10:
                        str_cell_value = '<div class = "local_jq_grid_row_2"></div>';
                        break;
                    case 11:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_ST_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberBalanceSheet(this);" /></div>';
                        break;
                    case 12:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_DEBTORS_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberBalanceSheet(this);" /></div>';
                        break;
                    case 13:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_OTHER_RECEIVABLES_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberBalanceSheet(this);" /></div>';
                        break;
                    case 14:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_CASH_AND_BANK_BALANCES_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberBalanceSheet(this);" /></div>';
                        break;
                    case 15:
                        str_cell_value = '<div class = "local_jq_grid_row_2"></div>';
                        break;
                    case 16:
                        str_cell_value = '<div class = "local_jq_grid_row_2" id = "DIV_CURRENT_ASSETS_' + m_int_column_id + '"><b>0.00</b></div>';
                        break;
                    case 17:
                        str_cell_value = '<div class = "local_jq_grid_row_2"></div>';
                        break;
                    case 18:
                        str_cell_value = '<div class = "local_jq_grid_row_2"></div>';
                        break;
                    case 19:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_CREDITORS_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberBalanceSheet(this);" /></div>';
                        break;
                    case 20:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_SUNDRY_CREDITORS_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberBalanceSheet(this);" /></div>';
                        break;
                    case 21:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_STATUTORY_LIABILITIES_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberBalanceSheet(this);" /></div>';
                        break;
                    case 22:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_SHORT_TERM_LOANS_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberBalanceSheet(this);" /></div>';
                        break;
                    case 23:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_BANK_OVERDRAFT_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberBalanceSheet(this);" /></div>';
                        break;
                    case 24:
                        str_cell_value = '<div class = "local_jq_grid_row_2"></div>';
                        break;
                    case 25:
                        str_cell_value = '<div class = "local_jq_grid_row_2" id = "DIV_CURRENT_LIABILITIES_' + m_int_column_id + '"><b>0.00</b></div>';
                        break;
                    case 26:
                        str_cell_value = '<div class = "local_jq_grid_row_2"></div>';
                        break;
                    case 27:
                        str_cell_value = '<div class = "local_jq_grid_row_2"></div>';
                        break;
                    case 28:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_LONG_TERM_LOAN_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberBalanceSheet(this);" /></div>';
                        break;
                    case 29:
                        str_cell_value = '<div class = "local_jq_grid_row_2"></div>';
                        break;
                    case 30:
                        str_cell_value = '<div class = "local_jq_grid_row_2" id = "DIV_NET_ASSETS_' + m_int_column_id + '"><b>0.00</b></div>';
                        break;
                    case 31:
                        str_cell_value = '<div class = "local_jq_grid_row_2"></div>';
                        break;
                    case 32:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_SHARE_CAPITAL_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberBalanceSheet(this);" /></div>';
                        break;
                    case 33:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_RESERVES_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberBalanceSheet(this);" /></div>';
                        break;
                    case 34:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_PROFIT_LOSS_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberBalanceSheet(this);" /></div>';
                        break;
                    case 35:
                        str_cell_value = '<div class = "local_jq_grid_row_2"><input class = "local_jq_grid_row_2_text" type = "text" name = "TXT_RETAINED_EARNINGS_' + m_int_column_id + '" value = "0.00" onBlur = "localCalculateNumberBalanceSheet(this);" /></div>';
                        break;
                    case 36:
                        str_cell_value = '<div class = "local_jq_grid_row_2"></div>';
                        break;
                    case 37:
                        str_cell_value = '<div class = "local_jq_grid_row_2" id = "DIV_SHARE_HOLDERS_FUNDS_' + m_int_column_id + '"><b>0.00</b></div>';
                        break;
                    case 38:
                        str_cell_value = '<div class = "local_jq_grid_row_2"></div>';
                        break;
                }
                return str_cell_value;
            }
            
            
            function localCalculateNumberProfitLoss(m_object) {
                var str_textbox_name                = document.Form1.elements[m_object.name].name;
                var int_last_index_of_underscore    = str_textbox_name.lastIndexOf('_');
                var str_textbox_name_part_1         = str_textbox_name.substring(0, int_last_index_of_underscore);
                var str_textbox_name_part_2         = str_textbox_name.substring(int_last_index_of_underscore + 1, str_textbox_name.length);
                var int_column_id                   = parseInt(str_textbox_name_part_2);
                var bool_is_number_validated        = validateNumber(m_object, 0, 9999999999999999.99, 2, 'number');
                if (bool_is_number_validated == true) {
                    localCalculateNumber('PL', int_column_id);
                }
            }
            
            
            function localCalculateNumberBalanceSheet(m_object) {
                var str_textbox_name                = document.Form1.elements[m_object.name].name;
                var int_last_index_of_underscore    = str_textbox_name.lastIndexOf('_');
                var str_textbox_name_part_1         = str_textbox_name.substring(0, int_last_index_of_underscore);
                var str_textbox_name_part_2         = str_textbox_name.substring(int_last_index_of_underscore + 1, str_textbox_name.length);
                var int_column_id                   = parseInt(str_textbox_name_part_2);
                if (str_textbox_name_part_1 == 'TXT_PROFIT_LOSS') {
                    var bool_is_number_validated    = validateNumber(m_object, -9999999999999999.99, 9999999999999999.99, 2, 'number');
                }
                else {
                    var bool_is_number_validated    = validateNumber(m_object, 0, 9999999999999999.99, 2, 'number');
                }
                if (bool_is_number_validated == true) {
                    localCalculateNumber('BS', int_column_id);
                }
            }
            
            
            function localCalculateNumber(m_type, m_column_id) {
                if (m_type == 'PL') {
                    var dbl_turnover                = parseFloat(unformat_noobject(document.Form1.elements['TXT_TURNOVER_' + m_column_id].value));
                    var dbl_operating_costs         = parseFloat(unformat_noobject(document.Form1.elements['TXT_OPERATING_COSTS_' + m_column_id].value));
                    var dbl_deprecation             = parseFloat(unformat_noobject(document.Form1.elements['TXT_DEPRECATION_' + m_column_id].value));
                    var dbl_administration_cost     = parseFloat(unformat_noobject(document.Form1.elements['TXT_ADMINISTRATION_COST_' + m_column_id].value));
                    var dbl_distribution_cost       = parseFloat(unformat_noobject(document.Form1.elements['TXT_DISTRIBUTION_COST_' + m_column_id].value));
                    var dbl_finance_cost            = parseFloat(unformat_noobject(document.Form1.elements['TXT_FINANCE_COST_' + m_column_id].value));
                    var dbl_corporation_tax         = parseFloat(unformat_noobject(document.Form1.elements['TXT_CORPORATION_TAX_' + m_column_id].value));
                    var dbl_other_income            = parseFloat(unformat_noobject(document.Form1.elements['TXT_OTHER_INCOME_' + m_column_id].value));
                    var str_gross_profit            = dbl_turnover - dbl_operating_costs;
                    str_gross_profit                = format_noobject0(str_gross_profit, 2, null, 'BRACKETS');
                    document.getElementById('DIV_GROSS_PROFIT_' + m_column_id).innerHTML = '<b>' + str_gross_profit + '</b>';
                    var str_net_profit              = (dbl_turnover - dbl_operating_costs) - (dbl_deprecation + dbl_administration_cost + dbl_distribution_cost + dbl_finance_cost + dbl_corporation_tax) + dbl_other_income;
                    str_net_profit                  = format_noobject0(str_net_profit, 2, null, 'BRACKETS');
                    document.getElementById('DIV_NET_PROFIT_' + m_column_id).innerHTML = '<b>' + str_net_profit + '</b>';
                }
                else if (m_type == 'BS') {
                    var dbl_tangible                = parseFloat(unformat_noobject(document.Form1.elements['TXT_TANGIBLE_' + m_column_id].value));
                    var dbl_intangible              = parseFloat(unformat_noobject(document.Form1.elements['TXT_INTANGIBLE_' + m_column_id].value));
                    var dbl_investments             = parseFloat(unformat_noobject(document.Form1.elements['TXT_INVESTMENTS_' + m_column_id].value));
                    var dbl_st                      = parseFloat(unformat_noobject(document.Form1.elements['TXT_ST_' + m_column_id].value));
                    var dbl_debtors                 = parseFloat(unformat_noobject(document.Form1.elements['TXT_DEBTORS_' + m_column_id].value));
                    var dbl_other_receivables       = parseFloat(unformat_noobject(document.Form1.elements['TXT_OTHER_RECEIVABLES_' + m_column_id].value));
                    var dbl_cash_and_bank_balances  = parseFloat(unformat_noobject(document.Form1.elements['TXT_CASH_AND_BANK_BALANCES_' + m_column_id].value));
                    var dbl_creditors               = parseFloat(unformat_noobject(document.Form1.elements['TXT_CREDITORS_' + m_column_id].value));
                    var dbl_sundry_creditors        = parseFloat(unformat_noobject(document.Form1.elements['TXT_SUNDRY_CREDITORS_' + m_column_id].value));
                    var dbl_statutory_liabilities   = parseFloat(unformat_noobject(document.Form1.elements['TXT_STATUTORY_LIABILITIES_' + m_column_id].value));
                    var dbl_short_term_loans        = parseFloat(unformat_noobject(document.Form1.elements['TXT_SHORT_TERM_LOANS_' + m_column_id].value));
                    var dbl_bank_overdraft          = parseFloat(unformat_noobject(document.Form1.elements['TXT_BANK_OVERDRAFT_' + m_column_id].value));
                    var dbl_long_term_loan          = parseFloat(unformat_noobject(document.Form1.elements['TXT_LONG_TERM_LOAN_' + m_column_id].value));
                    var dbl_share_capital           = parseFloat(unformat_noobject(document.Form1.elements['TXT_SHARE_CAPITAL_' + m_column_id].value));
                    var dbl_reserves                = parseFloat(unformat_noobject(document.Form1.elements['TXT_RESERVES_' + m_column_id].value));
                    var dbl_profit_loss             = parseFloat(unformat_noobject(document.Form1.elements['TXT_PROFIT_LOSS_' + m_column_id].value));
                    var dbl_retained_earnings       = parseFloat(unformat_noobject(document.Form1.elements['TXT_RETAINED_EARNINGS_' + m_column_id].value));
                    var str_fixed_assets            = dbl_tangible + dbl_intangible + dbl_investments;
                    str_fixed_assets                = format_noobject0(str_fixed_assets, 2, null, 'BRACKETS');
                    document.getElementById('DIV_FIXED_ASSETS_' + m_column_id).innerHTML = '<b>' + str_fixed_assets + '</b>';
                    var str_current_assets          = dbl_st + dbl_debtors + dbl_other_receivables + dbl_cash_and_bank_balances;
                    str_current_assets              = format_noobject0(str_current_assets, 2, null, 'BRACKETS');
                    document.getElementById('DIV_CURRENT_ASSETS_' + m_column_id).innerHTML = '<b>' + str_current_assets + '</b>';
                    var str_current_liabilities     = dbl_creditors + dbl_sundry_creditors + dbl_statutory_liabilities + dbl_short_term_loans + dbl_bank_overdraft;
                    str_current_liabilities         = format_noobject0(str_current_liabilities, 2, null, 'BRACKETS');
                    document.getElementById('DIV_CURRENT_LIABILITIES_' + m_column_id).innerHTML = '<b>' + str_current_liabilities + '</b>';
                    var str_net_assets              = ((dbl_tangible + dbl_intangible + dbl_investments) + (dbl_st + dbl_debtors + dbl_other_receivables + dbl_cash_and_bank_balances)) - ((dbl_creditors + dbl_sundry_creditors + dbl_statutory_liabilities + dbl_short_term_loans + dbl_bank_overdraft) + (dbl_long_term_loan));
                    str_net_assets                  = format_noobject0(str_net_assets, 2, null, 'BRACKETS');
                    document.getElementById('DIV_NET_ASSETS_' + m_column_id).innerHTML = '<b>' + str_net_assets + '</b>';
                    var str_share_holders_funds     = dbl_share_capital + dbl_reserves + dbl_profit_loss + dbl_retained_earnings;
                    str_share_holders_funds         = format_noobject0(str_share_holders_funds, 2, null, 'BRACKETS');
                    document.getElementById('DIV_SHARE_HOLDERS_FUNDS_' + m_column_id).innerHTML = '<b>' + str_share_holders_funds + '</b>';
                }
            }
            
            
            function before_submit() {
                if (confirm('Are you sure you want to save?')) {
                    var arr_final_string = new Array();
                    var j = 0;
                    for (var i = 1; i <= 6; i++) {
                        arr_final_string[j + 0]     = document.Form1.elements['TXT_VALUE_DATE_PL_' + i].value;
                        arr_final_string[j + 1]     = unformat_noobject(document.Form1.elements['TXT_PRICE_INDEX_' + i].value);
                        arr_final_string[j + 2]     = unformat_noobject(document.Form1.elements['TXT_TURNOVER_' + i].value);
                        arr_final_string[j + 3]     = unformat_noobject(document.Form1.elements['TXT_OPERATING_COSTS_' + i].value);
                        arr_final_string[j + 4]     = unformat_noobject(document.Form1.elements['TXT_DEPRECATION_' + i].value);
                        arr_final_string[j + 5]     = unformat_noobject(document.Form1.elements['TXT_ADMINISTRATION_COST_' + i].value);
                        arr_final_string[j + 6]     = unformat_noobject(document.Form1.elements['TXT_DISTRIBUTION_COST_' + i].value);
                        arr_final_string[j + 7]     = unformat_noobject(document.Form1.elements['TXT_CORPORATION_TAX_' + i].value);
                        arr_final_string[j + 8]     = unformat_noobject(document.Form1.elements['TXT_FINANCE_COST_' + i].value);
                        arr_final_string[j + 9]     = unformat_noobject(document.Form1.elements['TXT_OTHER_INCOME_' + i].value);
                        arr_final_string[j + 10]    = unformat_noobject(document.Form1.elements['TXT_DIVIDENDS_' + i].value);
                        arr_final_string[j + 11]    = unformat_noobject(document.Form1.elements['TXT_TANGIBLE_' + i].value);
                        arr_final_string[j + 12]    = unformat_noobject(document.Form1.elements['TXT_INTANGIBLE_' + i].value);
                        arr_final_string[j + 13]    = unformat_noobject(document.Form1.elements['TXT_INVESTMENTS_' + i].value);
                        arr_final_string[j + 14]    = unformat_noobject(document.Form1.elements['TXT_ST_' + i].value);
                        arr_final_string[j + 15]    = unformat_noobject(document.Form1.elements['TXT_DEBTORS_' + i].value);
                        arr_final_string[j + 16]    = unformat_noobject(document.Form1.elements['TXT_OTHER_RECEIVABLES_' + i].value);
                        arr_final_string[j + 17]    = unformat_noobject(document.Form1.elements['TXT_CASH_AND_BANK_BALANCES_' + i].value);
                        arr_final_string[j + 18]    = unformat_noobject(document.Form1.elements['TXT_CREDITORS_' + i].value);
                        arr_final_string[j + 19]    = unformat_noobject(document.Form1.elements['TXT_SUNDRY_CREDITORS_' + i].value);
                        arr_final_string[j + 20]    = unformat_noobject(document.Form1.elements['TXT_STATUTORY_LIABILITIES_' + i].value);
                        arr_final_string[j + 21]    = unformat_noobject(document.Form1.elements['TXT_SHORT_TERM_LOANS_' + i].value);
                        arr_final_string[j + 22]    = unformat_noobject(document.Form1.elements['TXT_BANK_OVERDRAFT_' + i].value);
                        arr_final_string[j + 23]    = unformat_noobject(document.Form1.elements['TXT_LONG_TERM_LOAN_' + i].value);
                        arr_final_string[j + 24]    = unformat_noobject(document.Form1.elements['TXT_SHARE_CAPITAL_' + i].value);
                        arr_final_string[j + 25]    = unformat_noobject(document.Form1.elements['TXT_RESERVES_' + i].value);
                        arr_final_string[j + 26]    = unformat_noobject(document.Form1.elements['TXT_PROFIT_LOSS_' + i].value);
                        arr_final_string[j + 27]    = unformat_noobject(document.Form1.elements['TXT_RETAINED_EARNINGS_' + i].value);
                        j = j + 28;
                    }
                    var str_final_string = '';
                    str_final_string = arr_final_string.join(',');
                    window.opener.setAuditorDetails(g_row_number, str_final_string);
                    window.close();
                }
            }
            
            
            function save_window() {
                before_submit();
            }
            
            
            function load_roll_value(m_value) {
                document.getElementById('SCREEN_TITLE').innerHTML = 'Auditor Details - ' + m_value;
            }
            
            
            function load_roll_out_value() {
                document.getElementById('SCREEN_TITLE').innerHTML = 'Auditor Details';
            }
            
            
            function load_screen_status(m_value) {
                if (m_value == 'HELP') {
                    load_help_msg();
                }
            }
            
            
            function load_help_msg() {
                m_help_message = 'm_help_msg_NETFAC_FA_MK_CLIENT_CREATION';
                HelpBox_msg(m_help_message);
            }
            
            
            function HelpBox_msg(m_help_message) {
                popupwin = window.showModalDialog(servlet_client_url+":"+client_t3_port+"/"+client_name+"AF_MAS_Help_Msg_Servlet?class_in="+client_name+"FA_MAS_Help_Msg_select"+
                    "&help_message_in="+m_help_message);
            }
            
        </script>
    </head>
    
    <body class="body & txt-body" leftmargin="0" topmargin="0" marginwidth="0">
        
        <form name="Form1" method="post">
            <input type="hidden" name="SCREEN_NAME" />
            <input type="hidden" name="hid_help_type" />
            <input type="hidden" name="hid_help_row_number" />
            <input type="hidden" name="hid_validation_type" />
            <input type="hidden" name="hid_screen_status" value="New" />
            
            <table width="100%" class="table" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="8" valign="top"></td>
                    <td class="border_wht" valign="top">
                        <table class="table" width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
                            <tr>
                                <td height="30" class="pdn_mainHD">
                                    <div>
                                        <span>Asset Financing System Version</span>
                                        <span style="position:absolute; right:30px; font-size: 12px;">User : LBMGTALL</span>
                                        <span style="position:absolute; right:150px; font-size: 11px;">System Date: 26-AUG-2011</span>
                                        <span style="position:absolute; right:320px; font-size: 11px;">Current Date: 29-SEP-2011</span>
                                    </div>
                                </td>
                            </tr>
                            <tr> 
                                <td height="1"></td>
                            </tr>
                            <tr>
                                <td>
                                    <table class="table" border="0" cellpadding="0" cellspacing="0" height="100%" width="100%">
                                        <tr>
                                            <td height="1"></td>
                                        </tr>
                                        <tr>
                                            <td align="left" class="pdn_txtpos2" style="height: 18px;" id="SCREEN_TITLE">Auditor Details</td>
                                        </tr>
                                        <tr>
                                            <td height="10px" class="pdn_txtpos">
                                                <table class="table">
                                                    <tr>
                                                        <td width="10"></td>
                                                        <td><input class="mainbut" type="button" name="MAIN_BUT_SAVE" value="Save" onMouseOut="load_roll_out_value();" onMouseOver="load_roll_value("Save");" onclick="save_window();" /></td>
                                                        <td width="100%"></td>
                                                        <td><input class="mainbut" type="button" value="Help" onMouseOut="load_roll_out_value();" onMouseOver="load_roll_value("Help");" onclick="load_screen_status("HELP");" /></td>
                                                        
                                                        <td width="20"></td>
                                                        <td><input class="mainbut" type="button" value="Close" onMouseOut="load_roll_out_value();" onMouseOver="load_roll_value("Close");" onclick="close_window();" /></td>
                                                        <td width="10"></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="line" height="1"></td>
                                        </tr>
                                        <tr>
                                            <td class="pdn_txtpos" height="150" valign="top">
                                                <br />
                                                <div id="DIV_AUDITOR_DETAILS_PL">
                                                    <table id="TABLE_AUDITOR_DETAILS_PL"></table>
                                                </div>
                                                <br />
                                                <div id="DIV_AUDITOR_DETAILS_BS">
                                                    <table id="TABLE_AUDITOR_DETAILS_BS"></table>
                                                </div>
                                                <br />
                                                
                                                <table align='center' width='100%' class='table' border="0">
                                                    <tr>
                                                        <td width="100%">
                                                            <div ID='e_applicable_doc'></div>
                                                        </td>
                                                    </tr>
                                                </table>
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
   </body>
</html>
