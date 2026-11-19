        <%@page import="java.text.SimpleDateFormat" %>
        <%@page import="java.util.Calendar" %>
        <%@page import="java.util.Date" %>
        <%@page import="net.sasianet.ADLMARGIN.*" %>
        <%@page import="java.sql.*" %>
<html>
    <head>
        <title>Margin Trading </title>
        <meta name="generator" content="ModelWorks IDE" />
        
  
        
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
            String m_jsp_client_url = m_sn_methods.jsp_client_url;
            String m_schema_name    = m_sn_methods.schema_name.trim();
            // String m_servlet_client_url = m_sn_methods.servlet_client_url;
            // String m_client_t3_port = m_sn_methods.client_t3_port;
            // String m_client_name = m_sn_methods.client_name;
            
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
        
        <script type="text/javascript" src="<%= m_jsp_client_url %>/js/jquery.min.js"></script>
        <script type="text/javascript" src="<%= m_jsp_client_url %>/js/jquery-ui.min.js"></script>
        <!-- <script type="text/javascript" src="<%= m_jsp_client_url %>/js/json2.js"></script> -->
        <script type="text/javascript" src="<%= m_jsp_client_url %>/js/popup.js"></script>
        <script type="text/javascript" src="<%= m_jsp_client_url %>/SNET/jquery/grid/4.1/js/i18n/grid.locale-en.js"></script>
        <script type="text/javascript" src="<%= m_jsp_client_url %>/SNET/jquery/grid/4.1/js/jquery.jqGrid.min.js"></script>
        <script type="text/javascript" src="validate.js"></script>
        <script type="text/javascript" src="validate_v1.js"></script>
        <!-- <script type="text/javascript" src="ajax_data_gateway.js"></script> -->
        
        <link rel="stylesheet" type="text/css" href="<%= m_jsp_client_url %>/css/Asset_Financing_System.css" />
        <link rel="stylesheet" type="text/css" href="<%= m_jsp_client_url %>/css/redmond/jquery-ui.css" />
        <link rel="stylesheet" type="text/css" href="<%= m_jsp_client_url %>/css/ui.jqgrid.css" />
        <!-- <link rel="stylesheet" type="text/css" href="<%= m_jsp_client_url %>/SNET/jquery/grid/3.8/themes/ui.jqgrid.css" /> -->
        
        <script type="text/javascript">
            
            var banks_list = '';
            
            $(document).ready(function () {
                
                bind_events();
                initCal('VAL_TXT_DATE');
                
                // $.ajax({
                    // type: 'GET',
                    // url: servlet_client_url + ":" + client_t3_port + "/" + client_name + "BrokerBulkReceiptsAll?chksql=get_account_nos_list",
                    // dataType: 'xml',
                    // success: function(xml) {
                        // $(xml).find('account_no').each(function() {
                            // banks_list = banks_list + '<option value="' + $(this).find('account_no_column_2').text() + '">' + $(this).find('account_no_column_1').text() + '</option>';
                        // });
                        // // loadGridAddReceipt();
                        // // loadGridDeleteReceipt();
                    // }
                // });
                
            });
            
            
            function initCal(m_id) {
                $('#' + m_id).datepicker({
                    dateFormat: 'dd-mm-yy',
                    duration: 'fast',
                    yearRange: '1920:2050',
                    showOn: 'button',
                    buttonImage: '<%= m_jsp_client_url %>/SNET/images/calendar.gif',
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
                if (inst.id == "VAL_TXT_DATE") {
                    $('#TXT_FROMDATE').val(splitResult[0]);
                    $('#TXT_FROMMONTH').val(splitResult[1]);
                    $('#TXT_FROMYEAR').val(splitResult[2]);
                    $('#TXT_FROMYEAR').focus();
                }
            }
            
            
            function bind_events() {
                
                $('#go_but').click(function() {
                    // call_frame();
                    jQuery('#TABLE_JQ_GRID').jqGrid('GridUnload');
                    loadGridAddReceipt();
					document.getElementById('save_but').disabled=false;	
                });
                
            }
            
            
            function call_frame() {
                
                if (($('#TXT_FROMDATE').val() != "") && ($('#TXT_FROMMONTH').val() != "") && ($('#TXT_FROMYEAR').val() != "")) {
                    
                    var m_url = servlet_client_url + ":" + client_t3_port + "/" + client_name + "BrokerBulkReceiptsAll?chksql=Bulk_Receipt" +
                            "&val_fromdate=" + $('#TXT_FROMDATE').val() +
                            "&val_frommonth=" + $('#TXT_FROMMONTH').val() +
                            "&val_fromyear=" + $('#TXT_FROMYEAR').val();
                    
                    load_interface(m_url, 'NO', false);
                    var newcontent = document.getElementById("data_div2");
                    newcontent.innerHTML = data_vec_no;
                    
                    /*parent.frames[1].location.href=""+servlet_client_url+":"+client_t3_port+"/"+client_name+"BrokerBulkReceiptsAll?chksql=Bulk_Receipt"+
			                              "&val_fromdate="+document.Form2.TXT_FROMDATE.value+
																		"&val_frommonth="+document.Form2.TXT_FROMMONTH.value+
																		"&val_fromyear="+document.Form2.TXT_FROMYEAR.value;
                                                                        */
                }
                else {
                    alert("Please enter Date and continue.");
                }
            }
            
            
            function loadGridAddReceipt() {
                var m_url = servlet_client_url + ":" + client_t3_port + "/" + client_name + "BrokerBulkReceiptsAll?chksql=Bulk_Receipt" +
                        "&val_fromdate=" + $('#TXT_FROMDATE').val() +
                        "&val_frommonth=" + $('#TXT_FROMMONTH').val() +
                        "&val_fromyear=" + $('#TXT_FROMYEAR').val() +
                        "&val_client_manager_code=" + $('#TXT_CLIENT_MANAGER').val() +
                        "&val_client_code=" + $('#txt_client_code').val() +
                        "&val_facility_no=" + $('#txt_facility_number').val() +
                        "&val_broker_code=" + $('#txt_broker_code').val();
                
                jQuery('#TABLE_JQ_GRID').jqGrid({
                    url: m_url,
                    datatype: 'xml',
                    colNames: [
                        'Broker Code',
                        'Facility No',
                        'CDS No.',
                        'Client Name',
                        'Settlement Date',
                        'Amount Receivable',
                        'Amount Received',
                        'Amount Pending',
                        'Amount Receipt',
                        'Save Status',
                        'Account No.',
                        'Settlement Mode',
                        'Payer Bank Code',
                        'Cheque No.',
                        'Payer Reference',
                        'Status',
                        'Comments'
                    ],
                    colModel: [
                        {name: 'BROKER_CODE',               index: 'BROKER_CODE',               sortable: true,         align: 'left',      width: 100,     resizable: true,       unformat: unformatData ,formatter:cellFomatterBrokerCode,                                                        xmlmap: 'broker_code'},
                        {name: 'CLIENT_CODE',               index: 'CLIENT_CODE',               sortable: true,         align: 'left',      width: 100,     resizable: true,       unformat: unformatData ,formatter:cellFomatterFacilityNo,                                                        xmlmap: 'client_code'},
                        {name: 'CDS_NO',                    index: 'CDS_NO',                    sortable: true,         align: 'left',      width: 100,     resizable: true,                                                                                                                        xmlmap: 'cds_no'},
                        {name: 'CLIENT_NAME',               index: 'CLIENT_NAME',               sortable: true,         align: 'left',      width: 200,     resizable: true,                                                                                                                        xmlmap: 'client_name'},
                        {name: 'SETTLEMENT_DATE',           index: 'SETTLEMENT_DATE',           sortable: true,         align: 'center',    width: 125,     resizable: true,       unformat: unformatData ,formatter:cellFomatterSettlDate,         sorttype: 'date',       datefmt: 'd/m/Y',       xmlmap: 'settlement_date'},
                        {name: 'AMOUNT_RECEIVABLE',         index: 'AMOUNT_RECEIVABLE',         sortable: true,         align: 'right',     width: 150,     resizable: true,                                                                        sorttype: 'float',                              xmlmap: 'amount_receivable'},
                        {name: 'AMOUNT_RECEIVED',           index: 'AMOUNT_RECEIVED',           sortable: true,         align: 'right',     width: 150,     resizable: true,                                                                        sorttype: 'float',                              xmlmap: 'amount_received'},
                        {name: 'AMOUNT_PENDING',            index: 'AMOUNT_PENDING',            sortable: true,         align: 'right',     width: 150,     resizable: true,                                                                        sorttype: 'float',                              xmlmap: 'amount_pending'},
                        {name: 'AMOUNT_RECEIPT',            index: 'AMOUNT_RECEIPT',            sortable: false,        align: 'center',    width: 150,     resizable: false,      unformat: unformatData , formatter: cellFomatterAmountReceipt,   sorttype: 'float',                              xmlmap: 'amount_receipt'},
                        {name: 'SAVE_STATUS',               index: 'SAVE_STATUS',               sortable: false,        align: 'center',    width: 100,     resizable: false,      unformat: unformatData , formatter: cellFomatterSaveStatus},
                        {name: 'ACCOUNT_NO',                index: 'ACCOUNT_NO',                sortable: false,        align: 'center',    width: 175,     resizable: false,      unformat: unformatData , formatter: cellFomatterAccountNo},
                        {name: 'SETTLEMENT_MODE',           index: 'SETTLEMENT_MODE',           sortable: false,        align: 'center',    width: 175,     resizable: false,      unformat: unformatData , formatter: cellFomatterSettlementMode},
                        {name: 'PAYER_BANK_CODE',           index: 'PAYER_BANK_CODE',           sortable: false,        align: 'center',    width: 150,     resizable: false,      unformat: unformatData , formatter: cellFomatterPayerBankCode},
                        {name: 'CHEQUE_NO',                 index: 'CHEQUE_NO',                 sortable: false,        align: 'center',    width: 100,     resizable: false,      unformat: unformatData , formatter: cellFomatterChequeNo},
                        {name: 'PAYER_REFERENCE',           index: 'PAYER_REFERENCE',           sortable: false,        align: 'center',    width: 150,     resizable: false,      unformat: unformatData , formatter: cellFomatterPayerReference},
                        {name: 'STATUS',                    index: 'STATUS',                    sortable: false,        align: 'center',    width: 100,     resizable: false,      unformat: unformatData , formatter: cellFomatterStatus},
                        {name: 'COMMENTS',                  index: 'COMMENTS',                  sortable: false,        align: 'center',    width: 150,     resizable: false,      unformat: unformatData , formatter: cellFomatterComments}    // unformat: unformatData ,formatter:cellFomatterPaymentNo
                    ],
                    loadonce: 1,
                    mtype: 'GET',
                    rownumbers: true,
                    rowNum: 100000,
                    // rowTotal: 100000,
                    // rowList: [20, 30, 50, 100, 100000],
                    // viewrecords: true,
                    gridview: true,
                    // height: m_grid_height,
                    height: 'auto',
            //         height: '800px',
            //         toolbar: [true, 'top'],
                    // footerrow: true,
                    // userDataOnFooter: true,
                    hidegrid: false,
                    // forceFit: true,
                    // sortname: 'BROKER_CODE',
                    // sortorder: 'ASC',
                    // onCellSelect: jq_grid_click_event,
                    gridComplete: function() {
                        // $('[title=\"Total\"] > div').css({
                            // 'text-align' : 'left',
                            // 'cursor' : 'default'
                        // });
            //             var m_html = '' + 
            //                 '&nbsp;&nbsp;' + 
            //                 '<select id = \"SEL_TABLE_FACILITY_DETAILS_GRID_COLUMNS\" name = \"SEL_TABLE_FACILITY_DETAILS_GRID_COLUMNS\">' +
            //                 '   <option value = \"CLIENT_NAME\">Client Name</option>' +
            //                 '   <option value = \"FACILITY_NO\">Facility Number</option>' +
            //                 '</select>' +
            //                 '&nbsp;&nbsp;' + 
            //                 '<input type = \"button\" style = \"width: 150px;\" onclick = \"showHideGridColumn();\" value=\"Show / Hide\" name=\"BUT_TABLE_FACILITY_DETAILS_SHOW_HIDE_GRID_COLUMNS\" id=\"BUT_TABLE_FACILITY_DETAILS_SHOW_HIDE_GRID_COLUMNS\" class=\"but_input ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only\" />' +
            //                 '';
            //             $('#t_TABLE_FACILITY_DETAILS').css('height', '30px');
            //             $('#t_TABLE_FACILITY_DETAILS').html(m_html);
                    },
					loadComplete : function(){
                        var rec_count=$("#TABLE_JQ_GRID").jqGrid('getGridParam',"records");
                        document.Form2.hid_count.value=rec_count;
					},
                    caption: 'Broker Receipts',
                    xmlReader: {
                        repeatitems: false,
                        root: 'broker_receipts',
                        row: 'broker_receipt'
                    }
                });
            //     .navGrid('#DIV_PAGER_FACILITY_DETAILS' {add: false});
            //     jQuery('#TABLE_FACILITY_DETAILS').jqGrid('navGrid', '#DIV_PAGER_FACILITY_DETAILS', {add: false, edit: false, del: false, search: false, refresh: false});
            }
            
			
		   function  cellFomatterBrokerCode(cellvalue, options, rowObject) {
			 var rowId = options['rowId'];
                cellvalue =cellvalue+ '<input type="hidden" name="m_broker_code_' + rowId + '" id="m_broker_code_' + rowId + '" style="text-align: right; width: 150px;" value="' + cellvalue + '"  />';
                 return cellvalue;
			}
				
			function  cellFomatterFacilityNo(cellvalue, options, rowObject) {
			 var rowId = options['rowId'];
                cellvalue =cellvalue+ '<input type="hidden" name="m_facility_no_' + rowId + '" id="m_facility_no_' + rowId + '" style="text-align: right; width: 150px;" value="' + cellvalue + '"  />';
                 return cellvalue;
			}
			
            function  cellFomatterSettlDate(cellvalue, options, rowObject) {
			 var rowId = options['rowId'];
                cellvalue =cellvalue+ '<input type="hidden" name="m_trndate_' + rowId + '" id="m_trndate_' + rowId + '" style="text-align: right; width: 150px;" value="' + cellvalue + '"  />';
                 return cellvalue;
			}
            function cellFomatterAmountReceipt(cellvalue, options, rowObject) {
                var rowId = options['rowId'];
                cellvalue = '<input type="text" name="m_sett_amount_' + rowId + '" id="m_sett_amount_' + rowId + '" style="text-align: right; width: 150px;" value="' + cellvalue + '" onchange="check_amount(' + rowId + ');" onblur="guaran(' + rowId + '); chk_validate(' + rowId + ');" /><input type="hidden" name="m_amount_' + rowId + '" id="m_amount_' + rowId + '" value="' + unformat_noobject(cellvalue) + '" />';
                // onchange=check_amount('"+i+"') onblur=\"guaran('"+i+"');chk_validate('"+i+"')\" ><input type=hidden name='m_amount_"+i+"' value="+rs2.getString(6)+">';
                // out.println("<TD STYLE='{text-align:right;}' ><FONT COLOR='black'><input STYLE='{text-align:right;}' type=text name='m_sett_amount_"+i+"' value=\""+nf.format(rs2.getDouble(6))+"\" onchange=check_amount('"+i+"')  onblur=\"guaran('"+i+"');chk_validate('"+i+"')\" ><input type=hidden name='m_amount_"+i+"' value="+rs2.getString(6)+"></TD>");
                return cellvalue;
            }
            
            
            function cellFomatterSaveStatus(cellvalue, options, rowObject) {
                var rowId = options['rowId'];
                cellvalue = '<input type="checkbox" name="save_status_'+rowId + '" id="save_status_' + rowId + '" value="on" onclick="guaran(' + rowId + '); chk_validate(' + rowId + ');" />';
                // out.println("<TD STYLE='{text-align:center;}' ><FONT COLOR='black'><INPUT TYPE=checkbox NAME='save_status_"+i+"' ONCLICK=\"guaran('"+i+"');chk_validate('"+i+"')\" value='N' ></TD>");//chk_margin_factor('"+i+"')
                return cellvalue;
            }
			
			function cellFomatterDelete(cellvalue, options, rowObject) {
                var rowId = options['rowId'];
                cellvalue = '<input type="checkbox" name="delete_status_'+rowId + '" id="delete_status_' + rowId + '" value="on"  />';
                // out.println("<TD STYLE='{text-align:center;}' ><FONT COLOR='black'><INPUT TYPE=checkbox NAME='save_status_"+i+"' ONCLICK=\"guaran('"+i+"');chk_validate('"+i+"')\" value='N' ></TD>");//chk_margin_factor('"+i+"')
                return cellvalue;
            }
            
            
           /* function cellFomatterAccountNo(cellvalue, options, rowObject) {
                var rowId = options['rowId'];
                cellvalue = '<select name="account_no_' + rowId + '" id="account_no_' + rowId + '" style="width: 175px;">' + banks_list + '</select>';
                // out.println("<TD STYLE='{text-align:center;}' ><FONT COLOR='black'><INPUT TYPE=checkbox NAME='save_status_"+i+"' ONCLICK=\"guaran('"+i+"');chk_validate('"+i+"')\" value='N' ></TD>");//chk_margin_factor('"+i+"')
                return cellvalue;
           
			
			
			}*/
            
			function cellFomatterAccountNo(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
			
			<% 
			Connection conn = m_sn_methods.met_user_validate(session);
			Statement stmt = conn.createStatement ();
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
			
			
            
            function cellFomatterSettlementMode(cellvalue, options, rowObject) {
                var rowId = options['rowId'];
                cellvalue = '<select name="Hid_Sett_type_' + rowId + '" id="Hid_Sett_type_' + rowId + '" style="width: 175px;">' +
                                '<option value="CB_CHEQUE" selected="selected">CB_CHEQUE</option>' +
                                '<option value="CB_TRANF">CB_TRANF</option>' +
                                '<option value="BANK_TRANF">BANK_TRANF</option>' +
                                '<option value="CHEQUE">CHEQUE</option>' +
                                '<option value="CASH">CASH</option>' +
                                '<option value="CURR_ACC">CURR_ACC</option>' +
                            '</select>';
                return cellvalue;
            }
            
            
            function cellFomatterPayerBankCode(cellvalue, options, rowObject) {
                var rowId = options['rowId'];
                cellvalue = '<input type="text" name="Payer_Bank_Code' + rowId + '" id="Payer_Bank_Code' + rowId + '" style="width: 150px;" VALUE="-"/>';
                return cellvalue;
            }
            
            
            function cellFomatterChequeNo(cellvalue, options, rowObject) {
                var rowId = options['rowId'];
                cellvalue = '<input type="text" name="Cheque_NO' + rowId + '" id="Cheque_NO' + rowId + '" maxlength="6" style="width: 100px;" VALUE="-" />';
                return cellvalue;
            }
            
            
            function cellFomatterPayerReference(cellvalue, options, rowObject) {
                var rowId = options['rowId'];
                cellvalue = '<input type="text" name="Payer_Reference' + rowId + '" id="Payer_Reference' + rowId + '" style="width: 150px;" VALUE="-" />';
                return cellvalue;
            }
            
            
            function cellFomatterStatus(cellvalue, options, rowObject) {
                var rowId = options['rowId'];
                cellvalue = '<select name="Status' + rowId + '" id="Status' + rowId + '" style="width: 100px;">' +
                                '<option value="CRD" selected="selected">Credited</option>' +
                                '<option value="TBD">To Be Deposited</option>' +
                            '</select>';
                return cellvalue;
            }
            
            
            function cellFomatterComments(cellvalue, options, rowObject) {
                var rowId = options['rowId'];
                cellvalue = '<input type="text" name="comment_' + rowId + '" id="comment_' + rowId + '" style="width: 150px;" />';
                return cellvalue;
            }
            
            
            function loadGridDeleteReceipt() {
                var m_url = servlet_client_url + ":" + client_t3_port + "/" + client_name + "BrokerBulkReceiptsAll?chksql=Bulk_Receipts_del" +
                        "&val_fromdate=" + $('#TXT_FROMDATE').val() +
                        "&val_frommonth=" + $('#TXT_FROMMONTH').val() +
                        "&val_fromyear=" + $('#TXT_FROMYEAR').val();
                
                jQuery('#TABLE_JQ_GRID').jqGrid({
                    url: m_url,
                    datatype: 'json',
                    colNames: [
                        'Receipt No.',
                        'Facility No',
                        'Broker Code',
                        'Settle Mode',
                        'Amount',
                        'Branch Code',
                        'Account Code',
                        'Payer Bank Code',
                        'Payer Account Code',
                        'Payer Reference',
                        'Comments',
                        'Effective Date',
                        'Transaction Date',
                      //  'Status',
                        'Delete'
                        // 'Client Code',
                        // 'CDS No.',
                        // 'Client Name',
                        // 'Settlement Date',
                        // 'Amount Receivable',
                        // 'Amount Received',
                        // 'Amount Pending',
                        // 'Amount Receipt',
                        // 'Save Status',
                        // 'Account No.',
                        // 'Settlement Mode',
                        // 'Payer Bank Code',
                        // 'Cheque No.',
                        // 'Payer Reference',
                        // 'Status',
                        // 'Comments'
                    ],
                    colModel: [
						{name: 'RECEIPT_NO',                index: 'RECEIPT_NO',                sortable: true,         align: 'center',    width: 100,     resizable: true,  unformat: unformatData , formatter: cellFomatterReceiptNo ,                                                   jsonmap: 'receipt_no'},
                        {name: 'CLIENT_CODE',               index: 'CLIENT_CODE',               sortable: true,         align: 'left',      width: 100,     resizable: true,                                                                                                                jsonmap: 'client_code'},
                        {name: 'BROKER_CODE',               index: 'BROKER_CODE',               sortable: true,         align: 'left',      width: 100,     resizable: true,                                                                                                                jsonmap: 'broker_code'},
                        {name: 'SETTLEMENT_MODE',           index: 'SETTLEMENT_MODE',           sortable: true,         align: 'center',    width: 100,     resizable: true,                                                                                                                jsonmap: 'settle_mode'},
                        {name: 'AMOUNT',                    index: 'AMOUNT',                    sortable: true,         align: 'right',     width: 150,     resizable: true,                                                                                                                jsonmap: 'amount'},
                        {name: 'BRANCH_CODE',               index: 'BRANCH_CODE',               sortable: true,         align: 'left',      width: 100,     resizable: true,                                                                                                                jsonmap: 'branch_code'},
                        {name: 'ACCOUNT_CODE',              index: 'ACCOUNT_CODE',              sortable: true,         align: 'left',      width: 100,     resizable: true,                                                                                                                jsonmap: 'account_code'},
                        {name: 'PAYER_BANK_CODE',           index: 'PAYER_BANK_CODE',           sortable: true,         align: 'left',      width: 125,     resizable: true,                                                                                                                jsonmap: 'payer_bank_code'},
                        {name: 'PAYER_ACCOUNT_CODE',        index: 'PAYER_ACCOUNT_CODE',        sortable: true,         align: 'left',      width: 150,     resizable: true,                                                                                                                jsonmap: 'payer_account_code'},
                        {name: 'PAYER_REFERENCE',           index: 'PAYER_REFERENCE',           sortable: true,         align: 'left',      width: 125,     resizable: true,                                                                                                                jsonmap: 'payer_reference'},
                        {name: 'COMMENTS',                  index: 'COMMENTS',                  sortable: true,         align: 'left',      width: 200,     resizable: true,                                                                                                                jsonmap: 'comments'},
                        {name: 'EFFECTICE_DATE',            index: 'EFFECTICE_DATE',            sortable: true,         align: 'center',    width: 125,     resizable: true,                                                                                                                jsonmap: 'effectice_date'},
                        {name: 'TRANSACTION_DATE',          index: 'TRANSACTION_DATE',          sortable: true,         align: 'center',    width: 125,     resizable: true,                                                                                                                jsonmap: 'transaction_date'},
                      //  {name: 'APP_STATUS',                index: 'APP_STATUS',                sortable: true,         align: 'left',      width: 100,     resizable: true,                                                                                                                jsonmap: 'app_status'},
						{name: 'DELETE',                    index: 'DELETE',                    sortable: true,         align: 'left',      width: 100,     resizable: true,   unformat: unformatData , formatter: cellFomatterDelete ,                                                     jsonmap: 'delete'}
                        // {name: 'CDS_NO',                    index: 'CDS_NO',                    sortable: true,         align: 'left',      width: 100,     resizable: true,                                                                                                                xmlmap: 'cds_no'},
                        // {name: 'CLIENT_NAME',               index: 'CLIENT_NAME',               sortable: true,         align: 'left',      width: 200,     resizable: true,                                                                                                                xmlmap: 'client_name'},
                        // {name: 'SETTLEMENT_DATE',           index: 'SETTLEMENT_DATE',           sortable: true,         align: 'center',    width: 125,     resizable: true,                                                            sorttype: 'date',       datefmt: 'd/m/Y',           xmlmap: 'settlement_date'},
                        // {name: 'AMOUNT_RECEIVABLE',         index: 'AMOUNT_RECEIVABLE',         sortable: true,         align: 'right',     width: 150,     resizable: true,                                                            sorttype: 'float',                                  xmlmap: 'amount_receivable'},
                        // {name: 'AMOUNT_RECEIVED',           index: 'AMOUNT_RECEIVED',           sortable: true,         align: 'right',     width: 150,     resizable: true,                                                            sorttype: 'float',                                  xmlmap: 'amount_received'},
                        // {name: 'AMOUNT_PENDING',            index: 'AMOUNT_PENDING',            sortable: true,         align: 'right',     width: 150,     resizable: true,                                                            sorttype: 'float',                                  xmlmap: 'amount_pending'},
                        // {name: 'AMOUNT_RECEIPT',            index: 'AMOUNT_RECEIPT',            sortable: false,        align: 'center',    width: 150,     resizable: false,       formatter: cellFomatterAmountReceipt,               sorttype: 'float',                                  xmlmap: 'amount_receipt'},
                        // {name: 'SAVE_STATUS',               index: 'SAVE_STATUS',               sortable: false,        align: 'center',    width: 100,     resizable: false,       formatter: cellFomatterSaveStatus},
                        // {name: 'ACCOUNT_NO',                index: 'ACCOUNT_NO',                sortable: false,        align: 'center',    width: 175,     resizable: false,       formatter: cellFomatterAccountNo},
                        // {name: 'SETTLEMENT_MODE',           index: 'SETTLEMENT_MODE',           sortable: false,        align: 'center',    width: 175,     resizable: false,       formatter: cellFomatterSettlementMode},
                        // {name: 'PAYER_BANK_CODE',           index: 'PAYER_BANK_CODE',           sortable: false,        align: 'center',    width: 150,     resizable: false,       formatter: cellFomatterPayerBankCode},
                        // {name: 'CHEQUE_NO',                 index: 'CHEQUE_NO',                 sortable: false,        align: 'center',    width: 100,     resizable: false,       formatter: cellFomatterChequeNo},
                        // {name: 'PAYER_REFERENCE',           index: 'PAYER_REFERENCE',           sortable: false,        align: 'center',    width: 150,     resizable: false,       formatter: cellFomatterPayerReference},
                        // {name: 'STATUS',                    index: 'STATUS',                    sortable: false,        align: 'center',    width: 100,     resizable: false,       formatter: cellFomatterStatus},
                        // {name: 'COMMENTS',                  index: 'COMMENTS',                  sortable: false,        align: 'center',    width: 150,     resizable: false,       formatter: cellFomatterComments}
                    ],
                    loadonce: 1,
                    mtype: 'GET',
                    rownumbers: true,
                    rowNum: 100000,
                    // rowTotal: 100000,
                    // rowList: [20, 30, 50, 100, 100000],
                    // viewrecords: true,
                    gridview: true,
                    // height: m_grid_height,
                    height: 'auto',
            //         height: '800px',
            //         toolbar: [true, 'top'],
                    // footerrow: true,
                    // userDataOnFooter: true,
                    hidegrid: false,
                    // forceFit: true,
                    // sortname: 'BROKER_CODE',
                    // sortorder: 'ASC',
                    // onCellSelect: jq_grid_click_event,
                    gridComplete: function() {
                        // $('[title=\"Total\"] > div').css({
                            // 'text-align' : 'left',
                            // 'cursor' : 'default'
                        // });
            //             var m_html = '' + 
            //                 '&nbsp;&nbsp;' + 
            //                 '<select id = \"SEL_TABLE_FACILITY_DETAILS_GRID_COLUMNS\" name = \"SEL_TABLE_FACILITY_DETAILS_GRID_COLUMNS\">' +
            //                 '   <option value = \"CLIENT_NAME\">Client Name</option>' +
            //                 '   <option value = \"FACILITY_NO\">Facility Number</option>' +
            //                 '</select>' +
            //                 '&nbsp;&nbsp;' + 
            //                 '<input type = \"button\" style = \"width: 150px;\" onclick = \"showHideGridColumn();\" value=\"Show / Hide\" name=\"BUT_TABLE_FACILITY_DETAILS_SHOW_HIDE_GRID_COLUMNS\" id=\"BUT_TABLE_FACILITY_DETAILS_SHOW_HIDE_GRID_COLUMNS\" class=\"but_input ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only\" />' +
            //                 '';
            //             $('#t_TABLE_FACILITY_DETAILS').css('height', '30px');
            //             $('#t_TABLE_FACILITY_DETAILS').html(m_html);
                    },loadComplete : function(){
                        var rec_count=$("#TABLE_JQ_GRID").jqGrid('getGridParam',"records");
                        document.Form2.hid_count.value=rec_count;
					},
                    caption: 'Broker Receipts',
                    jsonReader: {
                        repeatitems: false,
                        root: 'broker_receipts'
                    }
                });
            //     .navGrid('#DIV_PAGER_FACILITY_DETAILS' {add: false});
            //     jQuery('#TABLE_FACILITY_DETAILS').jqGrid('navGrid', '#DIV_PAGER_FACILITY_DETAILS', {add: false, edit: false, del: false, search: false, refresh: false});
            }
            
             function cellFomatterReceiptNo(cellvalue, options, rowObject) {
                var rowId = options['rowId'];
                cellvalue = cellvalue+'<input type="hidden" name="recno_' + rowId + '" id="recno_' + rowId + '" style="width: 150px;"  value="'+cellvalue+'"/>';
                return cellvalue;
            }
            
            
            
            function check_amount(rowId) {
                // if(parseFloat($('#m_sett_amount_'+rowId).val())>parseFloat(document.Form2.elements[\"m_amount_\"+rowId].value)){
                // }
                var settle_amount = parseFloat(unformat_noobject($('#m_sett_amount_' + rowId).val()));
                var max_amount = unformat_noobject($('#m_amount_' + rowId).val());
                
                if (settle_amount > max_amount) {
                    alert('Amount should not be grater than ' + format_noobject($('#m_amount_' + rowId).val()) + '.');
                }
                
            }
            
            
            function guaran(rowId) {
                if ($('#save_status_' + rowId).is(':checked')) {
                    $('#save_status_' + rowId).val('on');
                }
                else {
                    $('#save_status_' + rowId).val('off');
                }
            }
            
            
            function chk_validate(rowId) {
             // if(document.Form2.elements[\"Payer_Bank_Code\"+line].value==''){ 
            		// document.Form2.elements[\"save_status_\"+line].value='N'; 
            	// document.Form2.elements[\"save_status_\"+line].checked=false
               // alert('Please Enter Payer Bank Code'); 
            	// }
             // else if(document.Form2.elements[\"Cheque_NO\"+line].value==''){ 
            		// document.Form2.elements[\"save_status_\"+line].value='N'; 
            	// document.Form2.elements[\"save_status_\"+line].checked=false
               // alert('Please Enter Cheque NO'); 
            	// }
             // else if(document.Form2.elements[\"Payer_Reference\"+line].value==''){ 
            		// document.Form2.elements[\"save_status_\"+line].value='N'; 
            	// document.Form2.elements[\"save_status_\"+line].checked=false
               // alert('Please Enter Payer Reference'); 
            	// }
            
            // // else if(parseFloat(document.Form2.elements[\"m_sett_amount_\"+line].value)>0){ m_amount_
            // //		document.Form2.elements[\"save_status_\"+line].value='N'; 
            // //	document.Form2.elements[\"save_status_\"+line].checked=false
            // //   alert('Please Enter Net Amount'); 
            // //	}
            
            if ((isNumber(unformat_noobject($('#m_sett_amount_' + rowId).val()))) == false) {
                $('#save_status_' + rowId).val('off');
                $('#save_status_' + rowId).attr('checked', false);
                alert('Please Enter Numerics for The Net Amount.');
                return false;
            }
            
            check_amount(rowId);
            // else if ((isNumber(unformat_noobject($('#m_sett_amount_' + rowId).val()))) == false) {
                // $('#save_status_' + rowId).val('N');
                // $('#save_status_' + rowId).attr('checked', false);
                // alert('Please Enter Less Amount.');
            // }
            
             // else if(parseFloat(unformat_noobject(document.Form2.elements[\"m_sett_amount_\"+line].value))>parseFloat(document.Form2.elements[\"m_amount_\"+line].value)){ 
            		// document.Form2.elements[\"save_status_\"+line].value='N'; 
            	// document.Form2.elements[\"save_status_\"+line].checked=false
               // alert('Please Enter Less Amount'); 
            	// }
            
            }
            
            
            function isNumber(sText) {
                if (sText == '') {
                    return false;
                }
                var ValidChars = ',-0123456789.';
                var IsNumber = true;
                var Char;
                var dotCnt = 0;
                for (i = 0; i < sText.length && IsNumber == true; i++) {
                    Char = sText.charAt(i);
                    if (Char == '.') {
                        dotCnt = dotCnt + 1;
                    }
                    if (ValidChars.indexOf(Char) == -1 || dotCnt > 1) {
                        IsNumber = false;
                    }
                }
                return IsNumber;
            }
            
            
            
            
	 function chkstartdate(dayobj,monthobj,yearobj) {
			if (checkMonthLength(dayobj,monthobj,yearobj)) {
			}
	 }	
	 
	 
	 //add by waruna 2011-02-23 
            function display_rec_opt(val){
		//	val=(document.Form2.Text_option.value);
				 
                if (val == 'ADD') {
					document.Form2.Hid_scr_name.value="broker_receipt";
                    $('#date_div').show();
                    jQuery('#TABLE_JQ_GRID').jqGrid('GridUnload');
			        // document.getElementById('date_div').style.visibility = 'visible';
					// parent.document.body.rows = "20%,*";
					// parent.frames[1].location.href=html_client_url+"/blank.html";
                }else if (val == 'DEL') {
					
					document.Form2.Hid_scr_name.value="broker_receipt_del";
                    $('#date_div').hide();
                    jQuery('#TABLE_JQ_GRID').jqGrid('GridUnload');
                    loadGridDeleteReceipt();
			       
				} else if (val == 'MOD') {
					document.Form2.Hid_scr_name.value="broker_receipt_mod";
                    $('#date_div').hide();
                    jQuery('#TABLE_JQ_GRID').jqGrid('GridUnload');
                    loadGridDeleteReceipt();
			       }
			
            }
            function unformatData(cellvalue, options, cellobject) {
               return cellvalue;
           }
            
           /* function beforesubmit() {
                document.Form2.action = servlet_client_url + ':' + client_t3_port + '/' + client_name + 'save_BulkReceiptsAll';
                // alert(servlet_client_url + ':' + client_t3_port + '/' + client_name + 'save_BulkReceiptsAll');
                document.Form2.submit();
			}*/
			
			
			function beforesubmit(){
			 
			if(chk_confirmed_deal()){
				
						//----------------------------------------------**	
			dayobj=document.Form1.TXT_FROMDATE;
			monthobj=document.Form1.TXT_FROMMONTH;
			yearobj=document.Form1.TXT_FROMYEAR;
		//	unformat(document.Form1.TXT_amount);
			
			buy_sett_date=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buy_sett_date="+buy_sett_date+"&chksql=chk_buy_sett_date_check";//-change by Prabash on 08-05-2013--chk_buy_sett_date
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
			
			
			document.Form1.HID_BUY_SETT_DATE.value=data_vec[0];
			//	alert(document.Form1.HID_BUY_SETT_DATE.value);
			
			if(document.Form1.HID_BUY_SETT_DATE.value=="YES"){
			//	alert("Value Date is not greater than Last Day End Routine Date, Please Re-Enter the Value Date !.");
				alert("Value Date is not greater than Last Day End Routine Date or daily margin trading date , Please Re-Enter the Value Date !.");
				dayobj.value=" ";	monthobj.value=" ";yearobj.value=" ";dayobj.focus();
			}
			//---------------------------------------------**	
			else{
		 	if(document.Form2.Hid_scr_name.value=="broker_receipt"){
			      document.Form2.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"save_BulkReceiptsAll?chksql=Broker_Payment";
				  document.Form2.submit();
			}else if(document.Form2.Hid_scr_name.value=="broker_receipt_del"){ 
				 document.Form2.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_receipts_confirmation?chksql=Bulk_payments_del";
				 document.Form2.submit();	
			}else if(document.Form2.Hid_scr_name.value=="broker_receipt_mod"){ 
				 document.Form2.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_receipts_confirmation?chksql=Bulk_payments_del";
				 document.Form2.submit();	
			}
			         
			}
			}
			else{
				alert('No records to save');
			}
			     
				
		     }
            
           
		function chk_confirmed_deal() {
			
			var no_of_rows = jQuery("#TABLE_JQ_GRID").getDataIDs().length;
			document.Form2.hid_count.value = no_of_rows;
			
			flag = false;
			
			for(var r=1;r<=document.Form2.hid_count.value;r++){
				
			
				if(eval("document.Form2.save_status_"+r+".checked")) {
				
					flag = true ;					 
					
				}
				
				
			}	
			
			return flag;
		}
			
			function facility_number_help(m_strat)
			{
				var aForm;    //  aForm =oForm.elements;
				aForm =  document.getElementById('Form2');
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
				aForm =  document.getElementById('Form2');
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
				aForm =  document.getElementById('Form2');
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
				aForm =  document.getElementById('Form2');
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
            	function chk_screen(){
			
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=get_pay_screen_status";	
		load_interface(m_url,'XML',false);
		
		m_size = data_vec.length;
		
			if(m_size>0){
			  if(data_vec[0]>0){
				
					if(confirm(data_vec[1] +'  is proceeding with the payment!!!! do you want to clear the data  and go ahead??')){
					
					   m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=payment_clear";	
		               load_interface(m_url,'XML',false);	
						
					}else{
					top.frames[1].location.href='low.jsp';
					}
				
				}
				
			}
		}
        </script>
    </head>
    
    <body class="body & txt-body" onload="chk_screen();" >
        <form name="Form2" id="Form2">
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="broker_receipt">
			<input type = "hidden" id = "hid_count" name = "hid_count" />
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
										<td style="background-image: url('<%= m_jsp_client_url %>/images/l3.gif'); background-repeat: repeat;" id="hi2" align="left"><b>Margin Trading - Receipt Management</b></td>
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
                    <td width="50px">
                        <input class="mainbut" type="button" name="Add" value="Add" onclick="display_rec_opt('ADD');" />
                    </td>
                    <td width="50px">
                        <input class="mainbut" type="button" name="MOD" value="Edit" onclick="display_rec_opt('MOD');" disabled />
                    </td>
                    <td width="50px">
                        <input class="mainbut" type="button" name="DEL" value="Delete" onclick="display_rec_opt('DEL');" />
                    </td>
                    
                    <td width="50px">
                        <input class="mainbut" type="button" name="save_but"  id="save_but" value="Save" onclick="beforesubmit();" disabled />
                    </td>
                    <td width="50px">
                        <input class="mainbut" type="button" name="calcel_but" value="Cancel" onclick="document.Form2.save_but.disabled=false; top.frames[1].location.href=top.frames[1].location.href;" />
                    </td>
                    <td width="50px">
                        <input class="mainbut" type="button" name="Exit_but" value="Exit" onclick="top.frames[1].location.href='low.jsp'" />
                    </td>
                    <td width="50px">
                        <input class="mainbut" type="button" name="report_but" value="Enquiry" onclick="obtain_report_before();" />
                    </td>
										<TD WIDTH="*%"> &nbsp; </TD>

                    <td width="50%" class="hh1" align="right"><b>Broker Receipt All</b></td>
                    
                    <td width="50px">
                        <input class="mainbut" type="button" name="save_but"  id="save_but" value="Save" onclick="beforesubmit();" disabled />
                    </td>
                    <td width="50px">
                        <input class="mainbut" type="button" name="calcel_but" value="Cancel" onclick="document.Form2.save_but.disabled=false; top.frames[1].location.href=top.frames[1].location.href;" />
                    </td>
                    <td width="50px">
                        <input class="mainbut" type="button" name="Exit_but" value="Exit" onclick="top.frames[1].location.href='low.jsp'" />
                    </td>

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
            
            <div id="date_div">
                <table cellpadding="1" cellspacing="1">
                    <tr>
                        <td style="width: 10px;"></td>
                        <td style="width: 125px;">Date</td>
                        <td style="width: 500px;">
                            <input class="txt_input5" type="text" id="TXT_FROMDATE" name="TXT_FROMDATE" size="3" maxlength="2" value="<%= system_day %>" />
                            <input class="txt_input5" type="text" id="TXT_FROMMONTH" name="TXT_FROMMONTH" size="3" maxlength="2" value="<%= system_month %>" />
                            <input class="txt_input5" type="text" id="TXT_FROMYEAR" name="TXT_FROMYEAR" size="4" maxlength="4" value="<%= system_year %>" onblur="chkstartdate(document.Form2.TXT_FROMDATE, document.Form2.TXT_FROMMONTH, document.Form2.TXT_FROMYEAR);" />
                            <input type="hidden" id="VAL_TXT_DATE" name="VAL_TXT_DATE" value="<%= system_day %>-<%= system_month %>-<%= system_year %>" />
                            <input class="mainbut" type="button" id="go_but" name="go_but" VALUE="View" />
                        </td>
                    </tr>
                </table>
                
                <table cellpadding="1" cellspacing="1">
                    <tr>
                        <td style="width: 10px;"></td>
                        <td style="width: 125px;">Client Manager Code</td>
                        <td style="width: 180px;">
                            <input class="txt_input" type="text" id="TXT_CLIENT_MANAGER" name="TXT_CLIENT_MANAGER" maxlength="15" style="width: 125px;" />
                            <input class="but_input" type="button" id="BUT_HELP_CLIENT_MANAGER_MAIN" name="BUT_HELP_CLIENT_MANAGER_MAIN" value="..." onclick="client_manager_code_help(0);" />
                        </td>
                        <td style="width: 50px;"></td>
                        <td style="width: 125px;">Client Manager Name</td>
                        <td style="width: 200px;">
                            <input class="txt_input" type="text" id="TXT_CLIENT_MANAGER_NAME" name="TXT_CLIENT_MANAGER_NAME" style="width: 200px;" disabled="disabled" />
                        </td>
                    </tr>
                    
                    <tr>
                        <td></td>
                        <td>Client Code</td>
                        <td>
                            <input class="txt_input" type="text" id="txt_client_code" name="txt_client_code" maxlength="15" style="width: 125px;" />
                            <input class="but_input" type="button" id="but_help_client_code_main" name="but_help_client_code_main" value="..." onclick="client_code_help(0);" />
                        </td>
                        <td></td>
                        <td>Client Full Name</td>
                        <td>
                            <input class="txt_input" type="text" id="txt_client_full_name" name="txt_client_full_name" style="width: 200px;" disabled="disabled" />
                        </td>
                    </tr>
                    
                    <tr>
                        <td></td>
                        <td>Facility Number</td>
                        <td>
                            <input class="txt_input" type="text" id="txt_facility_number" name="txt_facility_number" maxlength="15" style="width: 125px;" />
                            <input class="but_input" type="button" id="BUT_HELP_FACILITY_NUMBER" name="BUT_HELP_FACILITY_NUMBER" value="..." onclick="facility_number_help(0);" />
                        </td>
                        <td></td>
                        <td>Facility Number</td>
                        <td>
                            <input class="txt_input" type="text" id="txt_facility_number_name" name="txt_facility_number_name" style="width: 200px;" disabled="disabled" />
                        </td>
                    </tr>
                    
                    <tr>
                        <td></td>
                        <td>Broker Code</td>
                        <td>
                            <input class="txt_input" type="text" id="txt_broker_code" name="txt_broker_code" maxlength="15" style="width: 125px;" />
                            <input class="but_input" type="button" id="BUT_HELP_CLIENT_MANAGER_MAIN" name="BUT_HELP_CLIENT_MANAGER_MAIN" value="..." onclick="broker_code_help(0);" />
                        </td>
                        <td></td>
                        <td>Broker Full Name</td>
                        <td>
                            <input class="txt_input" type="text" id="txt_broker_full_name" name="txt_broker_full_name" style="width: 200px;" disabled="disabled" />
                        </td>
                    </tr>
                    
                </table>
            </div>
            
            <br />
            
            <div>
                <table id="TABLE_JQ_GRID"></table>
            </div>
        </form>
		<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>	
		<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>
    </body>
</html>
