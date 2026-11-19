        <%@page import="java.text.SimpleDateFormat" %>
        <%@page import="java.util.Calendar" %>
        <%@page import="java.util.Date" %>
        <%@page import="net.sasianet.ADLMARGIN.*" %>
        <%@page import="java.sql.*" %>
        <%@page import="java.util.*" %>

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
	        java.text.NumberFormat nf;
	
            String m_jsp_client_url = m_sn_methods.jsp_client_url;
            String m_schema_name    = m_sn_methods.schema_name.trim();
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
	
	String m_facility_no = request.getParameter("facility_no").toUpperCase();
	String m_payment_no  = request.getParameter("payment_no").toUpperCase();
	String m_mode        = request.getParameter("mode").toUpperCase();
	String m_cheque_no   = "-";
	String m_payment_type         = request.getParameter("settl_mode").toUpperCase();
	String m_company_bank_account = request.getParameter("company_bank_account");
	String m_settle_mode          = request.getParameter("settle_mode");
	
	String m_broker_code      = request.getParameter("broker_code").toUpperCase();
	String m_save_order_no    = request.getParameter("save_order_no").toUpperCase();
	String m_payment_category = request.getParameter("payment_category");
	String m_payment_category_1 = "";
	String  m_approve_status   = request.getParameter("approve_status");//SIG1,SIG2,APPR1 aadd by waruna 2012-08-21
	boolean m_print_enable     = false;
	
	
	  m_print_enable = Boolean.valueOf(request.getParameter("print_enable"));
	
	
	
	if (m_payment_category.equals("BROKER_PAYMENT")){
	m_payment_category_1="Daily Settlement";
	}else if(m_payment_category.equals("WITHDRAWAL")){
	m_payment_category_1="Capital Withdrawal";
	} 
	
	        nf = java.text.NumberFormat.getInstance(Locale.US);
			nf.setMinimumFractionDigits(2);
			nf.setMaximumFractionDigits(2);
        %>
<html>
    <head>
	<title>Margin Trading|Payment Voucher|<%=m_facility_no+"|"+m_payment_no+"|"+m_mode+"|"+m_payment_type+"|"+m_company_bank_account+"|"+m_settle_mode+"|"+m_broker_code+"|"+m_save_order_no%></title>	
	 <script type="text/javascript" src="<%= m_jsp_client_url %>/js/jquery.min.js"></script>
        <script type="text/javascript" src="<%= m_jsp_client_url %>/js/jquery-ui.min.js"></script>
        <!-- <script type="text/javascript" src="<%= m_jsp_client_url %>/js/json2.js"></script> -->
        <!-- <script type="text/javascript" src="<%= m_jsp_client_url %>/js/popup.js"></script> -->
        <script type="text/javascript" src="<%= m_jsp_client_url %>/SNET/jquery/grid/4.1/js/i18n/grid.locale-en.js"></script>
        <script type="text/javascript" src="<%= m_jsp_client_url %>/SNET/jquery/grid/4.1/js/jquery.jqGrid.min.js"></script>
        <script type="text/javascript" src="validate_v1.js"></script>
        <script type="text/javascript" src="ajax_data_gateway.js"></script> 
       	<script type="text/javascript" src="validate.js"></script>
		
        <link rel="stylesheet" type="text/css" href="<%= m_jsp_client_url %>/css/Asset_Financing_System.css" />
        <link rel="stylesheet" type="text/css" href="<%= m_jsp_client_url %>/css/redmond/jquery-ui.css" />
        <link rel="stylesheet" type="text/css" href="<%= m_jsp_client_url %>/css/ui.jqgrid.css" />

				
	  		
	    <script type="text/javascript">
			
			var iframe_html_string = '<iframe id = "IFRAME_DRILL_DOWN" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Drill Down"></iframe>';
			var iframe_html_string_2 = '<iframe id = "IFRAME_DRILL_DOWN_2" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Drill Down"></iframe>';
			var iframe_html_string_3 = '<iframe id = "IFRAME_DRILL_DOWN_3" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Drill Down"></iframe>';
			
			<% ResultSet rs_monthes = stmt.executeQuery(" " +
                "   SELECT TO_CHAR(LAST_DAILY+1, 'DD-MM-YYYY') MONTH_0_TODAY, " +
                "          TO_CHAR(LAST_DAY(LAST_DAILY+1), 'DD-MM-YYYY') MONTH_0_END, " +
                "          TO_CHAR(TRUNC(LAST_DAILY+1, 'MONTH'), 'DD-MM-YYYY') MONTH_0_START, " +
                "          TO_CHAR(LAST_DAY(ADD_MONTHS(LAST_DAILY+1, -1)), 'DD-MM-YYYY') MONTH_1_END, " +
                "          TO_CHAR(TRUNC(ADD_MONTHS(LAST_DAILY+1, -1), 'MONTH'), 'DD-MM-YYYY') MONTH_1_START, " +
                "          TO_CHAR(LAST_DAY(ADD_MONTHS(LAST_DAILY+1, -2)), 'DD-MM-YYYY') MONTH_2_END, " +
                "          TO_CHAR(TRUNC(ADD_MONTHS(LAST_DAILY+1, -2), 'MONTH'), 'DD-MM-YYYY') MONTH_2_START, " +
                "          TO_CHAR(LAST_DAY(ADD_MONTHS(LAST_DAILY+1, -3)), 'DD-MM-YYYY') MONTH_3_END, " +
                "          TO_CHAR(TRUNC(ADD_MONTHS(LAST_DAILY+1, -3), 'MONTH'), 'DD-MM-YYYY') MONTH_3_START, " +
                "          TO_CHAR(LAST_DAY(ADD_MONTHS(LAST_DAILY+1, -4)), 'DD-MM-YYYY') MONTH_4_END, " +
                "          TO_CHAR(TRUNC(ADD_MONTHS(LAST_DAILY+1, -4), 'MONTH'), 'DD-MM-YYYY') MONTH_4_START, " +
                "          TO_CHAR(LAST_DAY(ADD_MONTHS(LAST_DAILY+1, -5)), 'DD-MM-YYYY') MONTH_5_END, " +
                "          TO_CHAR(TRUNC(ADD_MONTHS(LAST_DAILY+1, -5), 'MONTH'), 'DD-MM-YYYY') MONTH_5_START, " +
                "          TO_CHAR(LAST_DAY(ADD_MONTHS(LAST_DAILY+1, -6)), 'DD-MM-YYYY') MONTH_6_END, " +
                "          TO_CHAR(TRUNC(ADD_MONTHS(LAST_DAILY+1, -6), 'MONTH'), 'DD-MM-YYYY') MONTH_6_START, " +
                "          TO_CHAR(LAST_DAY(ADD_MONTHS(LAST_DAILY+1, -7)), 'DD-MM-YYYY') MONTH_7_END " +
                "   FROM   " + m_schema_name + ".DN_SYS_PARAMETER " +
                " ");
                
                if (rs_monthes.next()) {
				%>	
					
                    var m_month_0_today  = '<%=rs_monthes.getString(1)%>';
                    var m_month_0_end    = '<%=rs_monthes.getString(2)%>';
                    var m_month_0_start  = '<%=rs_monthes.getString(3)%>';
                    var m_month_1_end    = '<%=rs_monthes.getString(4)%>';
                    var m_month_1_start  = '<%=rs_monthes.getString(5)%>';
                    var m_month_2_end    = '<%=rs_monthes.getString(6)%>';
                    var m_month_2_start  = '<%=rs_monthes.getString(7)%>';
                    var m_month_3_end    = '<%=rs_monthes.getString(8)%>';
                    var m_month_3_start  = '<%=rs_monthes.getString(9)%>';
                    var  m_month_4_end   = '<%=rs_monthes.getString(10)%>';
                    var m_month_4_start  = '<%=rs_monthes.getString(11)%>';
                    var m_month_5_end    = '<%=rs_monthes.getString(12)%>';
                    var m_month_5_start  = '<%=rs_monthes.getString(13)%>';
                    var m_month_6_end    = '<%=rs_monthes.getString(14)%>';
                    var m_month_6_start  = '<%=rs_monthes.getString(15)%>';
                    var m_month_7_end    ='<%=rs_monthes.getString(16)%>';
             <%   }
			   %>	
			
		   <% 
			ResultSet rs_pay_deatils = null;	 
			if (m_payment_category.equals("BROKER_PAYMENT")){
	           rs_pay_deatils = stmt.executeQuery(" SELECT "+m_schema_name+".DN_GET_PORTFOLIO_NAME('"+m_broker_code+"') FROM DUAL ");
	        }else if(m_payment_category.equals("WITHDRAWAL")){
	           rs_pay_deatils = stmt.executeQuery(" SELECT  A.BENEFICIARY_NAME,PAYEE_BANK,PAYEE_ACCOUNT_NO  FROM "+m_schema_name+".DN_TRN_BO_CAP_DEPOSIT A WHERE SAVE_ORDER_NO='"+m_save_order_no+"' ");
	        } 
			else if(m_payment_category.equals("REBATE_PAYMENT")){
	           rs_pay_deatils = stmt.executeQuery(" SELECT  "+m_schema_name+".DN_GET_PORTFOLIO_NAME(ID_PORTFOLIO_CODE) ,NVL(PAYEE_BRANCH_CODE,'-'),NVL(PAYEE_ACC_NO,'-')  FROM "+m_schema_name+".DN_TRN_REBATE_PAYMENT A WHERE SAVE_ORDER_NO='"+m_save_order_no+"' ");
	         
			}
							
				
			String m_payee     = "";
			String m_amount    = "0";
			String m_bank_code = "";
			String m_acc_no    = "";
			String m_branch_code = "";
			
			String m_payee_bank_code      = "N/A";
			String m_payee_branch_code    = "N/A";
			String m_payee_acc_no         = "N/A";
			
			if (rs_pay_deatils.next()) {
				
				m_payee       = rs_pay_deatils.getString(1);//m_payee       = rs_pay_deatils.getString(13);
				//m_amount      = rs_pay_deatils.getDouble(6);
				//m_bank_code   = rs_pay_deatils.getString(10);
				//m_branch_code = rs_pay_deatils.getString(10);
				//m_acc_no      = rs_pay_deatils.getString(11);	
				
				/*if(m_bank_code.length() >=4){
				m_bank_code = m_bank_code.substring(0, 4);
				}
				
				if(m_branch_code.length() >=4){
				m_branch_code=m_branch_code.substring(5, m_branch_code.length());
				}*/
				if (m_payment_category.equals("WITHDRAWAL")){
					
				   m_payee_bank_code   = rs_pay_deatils.getString(2);
				   m_payee_branch_code  = rs_pay_deatils.getString(2);
					
				  if(m_payee_bank_code!=null && m_payee_bank_code.length() >=4){
				   m_payee_bank_code = m_payee_bank_code.substring(0, 4);
				  }
				
				  if(m_payee_branch_code !=null && m_payee_branch_code.length() >=4){
				   m_payee_branch_code=m_payee_branch_code.substring(5, m_payee_branch_code.length());
				  }
				   m_payee_acc_no = rs_pay_deatils.getString(3);
						
				}
				else if (m_payment_category.equals("REBATE_PAYMENT")){
					
				   m_payee_bank_code   = rs_pay_deatils.getString(2);
				   m_payee_branch_code  = rs_pay_deatils.getString(2);
					
				  if(m_payee_bank_code!=null && m_payee_bank_code.length() >=4){
				   m_payee_bank_code = m_payee_bank_code.substring(0, 4);
				  }
				
				  if(m_payee_branch_code !=null && m_payee_branch_code.length() >=4){
				   m_payee_branch_code=m_payee_branch_code.substring(5, m_payee_branch_code.length());
				  }
				   m_payee_acc_no = rs_pay_deatils.getString(3);
						
				}
				
				
			}
		    m_amount=request.getParameter("amount");	
			if(m_company_bank_account.length() >=4){
				m_bank_code = m_company_bank_account.substring(0, 4);
				}
				
			if(m_company_bank_account.length() >=4){
				m_branch_code=m_company_bank_account.substring(5, 8);
				}
			if(m_company_bank_account.length() >=4){
				m_acc_no=m_company_bank_account.substring(9, m_company_bank_account.length());
				}
			
			
			
			%>
			
		
	function load_settlement_details(){
			           
            m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"BrokerBulkPaymentsVoucher?chksql=payment_settlement_details&port=<%=m_facility_no%>&broker_code=<%=m_broker_code%>&save_order_no=<%=m_save_order_no%>&settle_mode=<%=m_settle_mode%>&mode=<%=m_mode%>&approve_status=<%=m_approve_status%>";
				//window.open(m_url);				
			jQuery('#TABLE_SETTLEMENT_DETAILS').jqGrid({
                   url: m_url,
                   loadonce: 1,
                   datatype: 'json',
                   colNames: [
                       'Date',
                       'Ref no',
                       'Purchases',
                       'Receipts',
                       'Due Amount',
                       'Payment Amount',
                       'Balance'
                      
                   ],
                   colModel: [
						
						{name: 'Date',          index: 'Date',           jsonmap: 'Date',        sortable: false,    align: 'left',     width: 80,      resizable: false},//formatter: cellFomatterSLLabel,         unformat: unformatData
						{name: 'Ref_No',        index: 'Ref_No',         jsonmap: 'Ref_No',      sortable: false,    align: 'right',    width:  95,     resizable: false,  unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'Purchases',     index: 'Purchases',      jsonmap: 'Purchases',   sortable: false,    align: 'right',    width:  85,     resizable: false,  unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'Receipts',      index: 'Receipts',       jsonmap: 'Receipts',    sortable: false,    align: 'right',    width:  85,     resizable: false,  unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'Due_Amount',    index: 'Due_Amount',     jsonmap: 'Due_Amount',  sortable: false,    align: 'right',    width:  85,     resizable: false,  unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'Payment_Amount',index: 'Payment_Amount', jsonmap: 'Payment_Amount', sortable: false, align: 'right',    width:  110,     resizable: false,  unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'Balance',       index: 'Balance',        jsonmap: 'Balance',     sortable: false,    align: 'right',    width:  85,     resizable: false,  unformat: unformatData2}//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						   ],
                   // rowNum:10, 
					//rowList:[10,20,30],
				   mtype: 'GET',
                   rownumbers: false,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
				   footerrow: true,
				   userDataOnFooter: true,		
				   jsonReader: {repeatitems: false},	
				  // onCellSelect: jq_grid_click_event_client_portfolio,
                   gridComplete: function() {
                       $('#Date').css('cursor', 'default');
                       $('#Ref_No').css('cursor', 'default');
                       $('#Purchases').css('cursor', 'default');
                       $('#Receipts').css('cursor', 'default');
                       $('#Due_Amount').css('cursor', 'default');
                       $('#Payment_Amount').css('cursor', 'default');
                       $('#Balance').css('cursor', 'default');
                      },
                   caption: '<div id = "DIV_CLIENT_PAYMENT_REPORT_CAPTION" style = "width: 600px; text-align: center; font-size: 12px;">Settlement Details</div>'
                        
                  
               });
			
			// add custom button to export the data to excel
      jQuery("#TABLE_SETTLEMENT_DETAILS").jqGrid('navButtonAdd','#DIV_PAGER_SETTLEMENT_DETAILS',{
       caption:"Excel", 
       onClickButton : function () { 
           jQuery("#TABLE_SETTLEMENT_DETAILS").excelExport();
       } 
      });
			
		jQuery("#TABLE_SETTLEMENT_DETAILS").jqGrid('navGrid','#DIV_PAGER_SETTLEMENT_DETAILS',{edit:false,add:false,del:false});
	}
	
	function load_settlement_details_with_payment_no(){
			           
            m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"BrokerBulkPaymentsVoucher?chksql=payment_settlement_details_with_pay_no&port=<%=m_facility_no%>&broker_code=<%=m_broker_code%>&save_order_no=<%=m_save_order_no%>&settle_mode=<%=m_settle_mode%>&mode=<%=m_mode%>&approve_status=<%=m_approve_status%>";
								
			jQuery('#TABLE_SETTLEMENT_DETAILS2').jqGrid({
                   url: m_url,
                   loadonce: 1,
                   datatype: 'json',
                   colNames: [
                       'Payment No',
					   'Date',
                       'Ref no',
                       'Purchases',
                       'Receipts',
                       'Due_Amount',
                       'Payment_Amount',
                       'Balance'
                      
                   ],
                   colModel: [
						{name: 'Payment_No',    index: 'Payment_No',     jsonmap: 'Payment_No',  sortable: false,    align: 'left',     width: 100,      resizable: false},//formatter: cellFomatterSLLabel,         unformat: unformatData
						{name: 'Date',          index: 'Date',           jsonmap: 'Date',        sortable: false,    align: 'left',     width: 80,      resizable: false},//formatter: cellFomatterSLLabel,         unformat: unformatData
						{name: 'Ref_No',        index: 'Ref_No',         jsonmap: 'Ref_No',      sortable: false,    align: 'right',    width:  85,     resizable: false,  unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'Purchases',     index: 'Purchases',      jsonmap: 'Purchases',   sortable: false,    align: 'right',    width:  85,     resizable: false,  unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'Receipts',      index: 'Receipts',       jsonmap: 'Receipts',    sortable: false,    align: 'right',    width:  85,     resizable: false,  unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'Due_Amount',    index: 'Due_Amount',     jsonmap: 'Due_Amount',  sortable: false,    align: 'right',    width:  85,     resizable: false,  unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'Payment_Amount',index: 'Payment_Amount', jsonmap: 'Payment_Amount', sortable: false, align: 'right',    width:  110,     resizable: false,  unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'Balance',       index: 'Balance',        jsonmap: 'Balance',     sortable: false,    align: 'right',    width:  85,     resizable: false,  unformat: unformatData2}//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						   ],
                   // rowNum:10, 
					//rowList:[10,20,30],
				   mtype: 'GET',
                   rownumbers: false,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
				   footerrow: true,
				   userDataOnFooter: true,		
				   jsonReader: {repeatitems: false},	
				  // onCellSelect: jq_grid_click_event_client_portfolio,
                   gridComplete: function() {
                       $('#Date').css('cursor', 'default');
                       $('#Ref_No').css('cursor', 'default');
                       $('#Purchases').css('cursor', 'default');
                       $('#Receipts').css('cursor', 'default');
                       $('#Due_Amount').css('cursor', 'default');
                       $('#Payment_Amount').css('cursor', 'default');
                       $('#Balance').css('cursor', 'default');
                      },
                   caption: '<div id = "DIV_CLIENT_PAYMENT_REPORT_CAPTION" style = "width: 600px; text-align: center; font-size: 12px;">Settlement Details</div>'
                        
                  
               });
			
			// add custom button to export the data to excel
      jQuery("#TABLE_SETTLEMENT_DETAILS2").jqGrid('navButtonAdd','#DIV_PAGER_SETTLEMENT_DETAILS2',{
       caption:"Excel", 
       onClickButton : function () { 
           jQuery("#TABLE_SETTLEMENT_DETAILS2").excelExport();
       } 
      });
			
		jQuery("#TABLE_SETTLEMENT_DETAILS2").jqGrid('navGrid','#DIV_PAGER_SETTLEMENT_DETAILS2',{edit:false,add:false,del:false});
	}
			
			
	function load_settlement_details_approve_deatails(){
			           
            m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"BrokerBulkPaymentsVoucher?chksql=payment_settlement_details_approve&port=<%=m_facility_no%>&broker_code=<%=m_broker_code%>&save_order_no=<%=m_save_order_no%>&settle_mode=<%=m_settle_mode%>&mode=<%=m_mode%>&approve_status=<%=m_approve_status%>";
								
			jQuery('#TABLE_SETTLEMENT_DETAILS3').jqGrid({
                   url: m_url,
                   loadonce: 1,
                   datatype: 'json',
                   colNames: [
                       'Payment No',
					   'Payment Status',
					   'Done By',
					   'Date & Time',
					   'Comments'	
					   //'Date',
                       //'Ref no',
                       //'Purchases',
                       //'Receipts',
                       //'Due_Amount',
                       //'Payment_Amount',
                       //'Balance'
                      
                   ],
                   colModel: [
						{name: 'Payment_No',    index: 'Payment_No',     jsonmap: 'Payment_No',     sortable: false,    align: 'left',     width: 100,      resizable: false},//formatter: cellFomatterSLLabel,         unformat: unformatData
						{name: 'App_Status',    index: 'App_Status',     jsonmap: 'App_Status',     sortable: false,    align: 'left',     width: 100,      resizable: false},//formatter: cellFomatterSLLabel,         unformat: unformatData
						{name: 'Ent_User',       index: 'Ent_User',      jsonmap: 'Ent_User',       sortable: false,    align: 'left',     width: 100,      resizable: false},//formatter: cellFomatterSLLabel,         unformat: unformatData
						{name: 'Date_Time',       index: 'Date_Time',    jsonmap: 'Date_Time',       sortable: false,    align: 'left',    width: 100,      resizable: false},//formatter: cellFomatterSLLabel,         unformat: unformatData
						{name: 'App_Comments',  index: 'App_Comments',   jsonmap: 'App_Comments',   sortable: false,    align: 'left',     width: 200,      resizable: false}//formatter: cellFomatterSLLabel,         unformat: unformatData
						//{name: 'Date',          index: 'Date',           jsonmap: 'Date',        sortable: false,    align: 'left',     width: 80,      resizable: false},//formatter: cellFomatterSLLabel,         unformat: unformatData
						//{name: 'Ref_No',        index: 'Ref_No',         jsonmap: 'Ref_No',      sortable: false,    align: 'right',    width:  85,     resizable: false,  unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						//{name: 'Purchases',     index: 'Purchases',      jsonmap: 'Purchases',   sortable: false,    align: 'right',    width:  85,     resizable: false,  unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						//{name: 'Receipts',      index: 'Receipts',       jsonmap: 'Receipts',    sortable: false,    align: 'right',    width:  85,     resizable: false,  unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						//{name: 'Due_Amount',    index: 'Due_Amount',     jsonmap: 'Due_Amount',  sortable: false,    align: 'right',    width:  85,     resizable: false,  unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						//{name: 'Payment_Amount',index: 'Payment_Amount', jsonmap: 'Payment_Amount', sortable: false, align: 'right',    width:  110,     resizable: false,  unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						//{name: 'Balance',       index: 'Balance',        jsonmap: 'Balance',     sortable: false,    align: 'right',    width:  85,     resizable: false,  unformat: unformatData2}//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						   ],
                   // rowNum:10, 
					//rowList:[10,20,30],
				   mtype: 'GET',
                   rownumbers: false,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
				  jsonReader: {repeatitems: false},	
				  // onCellSelect: jq_grid_click_event_client_portfolio,
                   gridComplete: function() {
                       $('#Payment_No').css('cursor', 'default');
                      
                      },
                   caption: '<div id = "DIV_CLIENT_PAYMENT_REPORT_CAPTION" style = "width: 600px; text-align: center; font-size: 12px;"></div>'
                        
                  
               });
			
			// add custom button to export the data to excel
      jQuery("#TABLE_SETTLEMENT_DETAILS2").jqGrid('navButtonAdd','#DIV_PAGER_SETTLEMENT_DETAILS3',{
       caption:"Excel", 
       onClickButton : function () { 
           jQuery("#TABLE_SETTLEMENT_DETAILS3").excelExport();
       } 
      });
			
		jQuery("#TABLE_SETTLEMENT_DETAILS3").jqGrid('navGrid','#DIV_PAGER_SETTLEMENT_DETAILS3',{edit:false,add:false,del:false});
	}		
			
	function load_pf_details(){
			           
            m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"BrokerBulkPaymentsVoucher?chksql=client_pf_details&port=<%=m_facility_no%>&broker_code=<%=m_broker_code%>&save_order_no=<%=m_save_order_no%>&settle_mode=<%=m_settle_mode%>&mode=<%=m_mode%>";
								
			jQuery('#TABLE_PF_DETAILS').jqGrid({
                   url: m_url,
                   loadonce: 1,
                   datatype: 'json',
                   colNames: [
                       'Security Code',
                       'Quantity',
                       'Market Rate',
					   'Market Value',
                       'Company Value'
                         ],
								
                   colModel: [
						{name: 'Security_Code',          index: 'Security_Code',     jsonmap: 'Security_Code',        sortable: false,    align: 'left',     width: 80,      resizable: false},//formatter: cellFomatterSLLabel,         unformat: unformatData
						{name: 'Qty',                    index: 'Qty',               jsonmap: 'Qty',                  sortable: false,    align: 'right',    width:  85,     resizable: false,  unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'Market_Rate',            index: 'Market_Rate',       jsonmap: 'Market_Rate',          sortable: false,    align: 'right',    width:  85,     resizable: false,  unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'Market_Value',           index: 'Market_Value',      jsonmap: 'Market_Value',         sortable: false,    align: 'right',    width:  85,     resizable: false,  unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'Company_Value',          index: 'Company_Value',     jsonmap: 'Company_Value',        sortable: false,    align: 'right',    width:  85,     resizable: false,  unformat: unformatData2}//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						
						   ],
                   // rowNum:10, 
					//rowList:[10,20,30],
				   mtype: 'GET',
                   rownumbers: false,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
				   jsonReader: {repeatitems: false},
				   footerrow: true,
				   userDataOnFooter: true,	
				  // onCellSelect: jq_grid_click_event_client_portfolio,
                   gridComplete: function() {
                       $('#Security_Code').css('cursor', 'default');
                       $('#Qty').css('cursor', 'default');
                       $('#Market_Rate').css('cursor', 'default');
                       $('#Market_Value').css('cursor', 'default');
                       $('#Company_Value').css('cursor', 'default');
                      
                      },
                   caption: '<div id = "DIV_CLIENT_PAYMENT_REPORT_CAPTION" style = "width: 450px; text-align: center; font-size: 12px;">Share Portfolio</div>'
                        
                  
               });
			
			// add custom button to export the data to excel
      jQuery("#TABLE_PF_DETAILS").jqGrid('navButtonAdd','#DIV_PAGER_PF_DETAILS',{
       caption:"Excel", 
       onClickButton : function () { 
           jQuery("#TABLE_PF_DETAILS").excelExport();
       } 
      });
			
		jQuery("#TABLE_SETTLEMENT_DETAILS").jqGrid('navGrid','#DIV_PAGER_SETTLEMENT_DETAILS',{edit:false,add:false,del:false});
	}		
		
		function load_client_portfolio(){
		
		
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"availability_rpt?chksql=mt_port_rpt&facility_no=<%=m_facility_no%>";
			
			
						
			jQuery('#TABLE_PORTFOLIO_DETAILS').jqGrid({
                   url: m_url,
                   loadonce: 1,
                   datatype: 'json',
                   colNames: [
                       '',
                       m_month_0,
                       m_month_1,
                       m_month_2,
                       m_month_3,
                       m_month_4,
                       m_month_5,
                       m_month_6,
                       'Total',
                       'Average'
                   ],
                   colModel: [
					    {name: 'PORT_LABEL',        index: 'PORT_LABEL',     sortable: false,    align: 'left',     width: 200,      resizable: false},//formatter: cellFomatterSLLabel,         unformat: unformatData
						{name: 'PORT_MONTH_0',      index: 'PORT_MONTH_0',   sortable: false,    align: 'right',    width:  85,     resizable: false, formatter:cellFomatterNumberSL, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'PORT_MONTH_1',      index: 'PORT_MONTH_1',   sortable: false,    align: 'right',    width:  85,     resizable: false, formatter:cellFomatterNumberSL, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'PORT_MONTH_2',      index: 'PORT_MONTH_2',   sortable: false,    align: 'right',    width:  85,     resizable: false, formatter:cellFomatterNumberSL, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'PORT_MONTH_3',      index: 'PORT_MONTH_3',   sortable: false,    align: 'right',    width:  85,     resizable: false, formatter:cellFomatterNumberSL, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'PORT_MONTH_4',      index: 'PORT_MONTH_4',   sortable: false,    align: 'right',    width:  85,     resizable: false, formatter:cellFomatterNumberSL, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'PORT_MONTH_5',      index: 'PORT_MONTH_5',   sortable: false,    align: 'right',    width:  85,     resizable: false, formatter:cellFomatterNumberSL, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'PORT_MONTH_6',      index: 'PORT_MONTH_6',   sortable: false,    align: 'right',    width:  85,     resizable: false, formatter:cellFomatterNumberSL, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'PORT_TOTAL',        index: 'PORT_TOTAL',     sortable: false,    align: 'right',    width:  85,     resizable: false, formatter:cellFomatterNumberSL, unformat: unformatData2},//,   formatter: cellFomatterNumberSLTot,     unformat: unformatData},
						{name: 'PORT_AVERAGE',      index: 'PORT_AVERAGE',   sortable: false,    align: 'right',    width:  85,     resizable: false, formatter:cellFomatterNumberSL, unformat: unformatData2},//,   formatter: cellFomatterNumberSLAve,     unformat: unformatData}
                   ],
                   // rowNum:10, 
					//rowList:[10,20,30],
				   mtype: 'GET',
                   rownumbers: false,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
				   onCellSelect: jq_grid_click_event_client_portfolio,
                   gridComplete: function() {
                       $('#jqgh_PORT_LABEL').css('cursor', 'default');
                       $('#jqgh_PORT_MONTH_0').css('cursor', 'default');
                       $('#jqgh_PORT_MONTH_1').css('cursor', 'default');
                       $('#jqgh_PORT_MONTH_2').css('cursor', 'default');
                       $('#jqgh_PORT_MONTH_3').css('cursor', 'default');
                       $('#jqgh_PORT_MONTH_4').css('cursor', 'default');
                       $('#jqgh_PORT_MONTH_5').css('cursor', 'default');
                       $('#jqgh_PORT_MONTH_6').css('cursor', 'default');
                       $('#jqgh_PORT_TOTAL').css('cursor', 'default');
                       $('#jqgh_PORT_AVERAGE').css('cursor', 'default');
                   },
                   caption: '<div id = "DIV_CLIENT_PAYMENT_REPORT_CAPTION" style = "width: 960px; text-align: center; font-size: 12px;">Margin Trading Security Portfolio</div>'
              
                  
                  
               });
			
			// add custom button to export the data to excel
      jQuery("#TABLE_PORTFOLIO_DETAILS").jqGrid('navButtonAdd','#DIV_PAGER_PORTFOLIO_DETAILS',{
       caption:"Excel", 
       onClickButton : function () { 
           jQuery("#TABLE_PORTFOLIO_DETAILS").excelExport();
       } 
      });
			
		jQuery("#TABLE_PORTFOLIO_DETAILS").jqGrid('navGrid','#DIV_PAGER_PORTFOLIO_DETAILS',{edit:false,add:false,del:false});
	}
		
			  function jq_grid_click_event_client_portfolio(rowid, iCol, cellcontent) {
					
			
			 var m_selected_row = jQuery('#TABLE_PORTFOLIO_DETAILS').jqGrid('getRowData', rowid);
               var start_date = null;
               var end_date = null;
               if ((rowid == 2) ||(rowid == 3) || (rowid == 5)) {
                   if (iCol == 0) {
                       m_month = 'CLIENT';
                   }
                   else if (iCol == 1) {
                       m_month     = 0;
                       start_date  = m_month_0_start;
                       end_date    = m_month_0_today;// m_month_0_end;
						
                      /* if (rowid == 7) {
                           end_date    = m_month_0_today;
						}*/
                   }
                   else if (iCol == 2) {
                       m_month = -1;
					 // alert(m_month_1_start);	
                       start_date  = m_month_1_start;
                       end_date    = m_month_1_end;
                   }
                   else if (iCol == 3) {
                       m_month = -2;
                       start_date  = m_month_2_start;
                       end_date    = m_month_2_end;
                   }
                   else if (iCol == 4) {
                       m_month = -3;
                       start_date  = m_month_3_start;
                       end_date    = m_month_3_end;
                   }
                   else if (iCol == 5) {
                       m_month = -4;
                       start_date  = m_month_4_start;
                       end_date    = m_month_4_end;
                   }
                   else if (iCol == 6) {
                       m_month = -5;
                       start_date  = m_month_5_start;
                       end_date    = m_month_5_end;
                   }
                   else if (iCol == 7) {
                       m_month = -6;
                       start_date  = m_month_6_start;
                       end_date    = m_month_6_end;
                   }
                   else if (iCol == 8) {
                       m_month = 'TOTAL';
                       start_date  = m_month_6_start;
					   end_date    = m_month_0_end;
                      
                   }
				}//end if
					
				 if ((iCol == 0) || (iCol == 1) || (iCol == 2) || (iCol == 3) || (iCol == 4) || (iCol == 5) || (iCol == 6) || (iCol == 7) || (iCol == 8)) {
			
					if (rowid == 2) {//purchase
                           if ($('#DIV_DRILL_DOWN').dialog('isOpen')) {
                               $('#DIV_DRILL_DOWN').dialog('close');
                           }
                           $('#IFRAME_DRILL_DOWN').attr('src', '');
                           $('#IFRAME_DRILL_DOWN').remove();
                           $('#DIV_DRILL_DOWN').html(iframe_html_string);
                           $('#DIV_DRILL_DOWN').dialog('option', 'title', 'Drill Down');
                           if (iCol == 0) {
                              // $('#IFRAME_DRILL_DOWN').attr('src', "<%= m_jsp_client_url %>"+"/dn_parchase_drildown.jsp?chksql=all&facility_no=<%=m_facility_no%>");
                           }
                           else {
                               $('#IFRAME_DRILL_DOWN').attr('src', "<%= m_jsp_client_url %>"+"/dn_parchase_drildown.jsp?chksql=parchase_details_month&facility_no=<%=m_facility_no%>&start_date=" + start_date + "&end_date=" + end_date);
                           }
                           $('#DIV_DRILL_DOWN').dialog('open');
                       }	
						else if (rowid == 3) {//sales
                           if ($('#DIV_DRILL_DOWN').dialog('isOpen')) {
                               $('#DIV_DRILL_DOWN').dialog('close');
                           }
                           $('#IFRAME_DRILL_DOWN').attr('src', '');
                           $('#IFRAME_DRILL_DOWN').remove();
                           $('#DIV_DRILL_DOWN').html(iframe_html_string);
                           $('#DIV_DRILL_DOWN').dialog('option', 'title', 'Drill Down');
                           if (iCol == 0) {
                              // $('#IFRAME_DRILL_DOWN').attr('src', "<%= m_jsp_client_url %>"+"/dn_parchase_drildown.jsp?chksql=all&facility_no=<%=m_facility_no%>");
                           }
                           else {
                               $('#IFRAME_DRILL_DOWN').attr('src', "<%= m_jsp_client_url %>"+"/dn_sale_drildown.jsp?chksql=sale_details_month&facility_no=<%=m_facility_no%>&start_date=" + start_date + "&end_date=" + end_date);
                           }
                           $('#DIV_DRILL_DOWN').dialog('open');
						}
						else if (rowid == 5) {//market value difference
                           if ($('#DIV_DRILL_DOWN').dialog('isOpen')) {
                               $('#DIV_DRILL_DOWN').dialog('close');
                           }
                           $('#IFRAME_DRILL_DOWN').attr('src', '');
                           $('#IFRAME_DRILL_DOWN').remove();
                           $('#DIV_DRILL_DOWN').html(iframe_html_string);
                           $('#DIV_DRILL_DOWN').dialog('option', 'title', 'Drill Down');
                           if (iCol == 0) {
                              // $('#IFRAME_DRILL_DOWN').attr('src', "<%= m_jsp_client_url %>"+"/dn_parchase_drildown.jsp?chksql=all&facility_no=<%=m_facility_no%>");
                           }
                           else {
                               $('#IFRAME_DRILL_DOWN').attr('src', "<%= m_jsp_client_url %>"+"/dn_market_value_difference_month.jsp?chksql=mkt_difference&facility_no=<%=m_facility_no%>&start_date=" + start_date + "&end_date=" + end_date);
                           }
                           $('#DIV_DRILL_DOWN').dialog('open');
                       }
						
						
					
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
                           
                           $('#IFRAME_DRILL_DOWN_2').attr('src', "<%= m_jsp_client_url %>"+"/dn_parchase_drildown_2.jsp?chksql=parchase_details_settle_date&facility_no=<%=m_facility_no%>&start_date=" + transaction_date + "&end_date=" + transaction_date);
                           $('#DIV_DRILL_DOWN_2').dialog('open');	
}
			
     function showSaleDrill2(transaction_date){	
			
	                     if ($('#DIV_DRILL_DOWN_2').dialog('isOpen')) {
                             $('#DIV_DRILL_DOWN_2').dialog('close');
                           }
                           $('#IFRAME_DRILL_DOWN_2').attr('src', '');
                           $('#IFRAME_DRILL_DOWN_2').remove();
                           $('#DIV_DRILL_DOWN_2').html(iframe_html_string_2);
                           $('#DIV_DRILL_DOWN_2').dialog('option', 'title', 'Drill Down');
                           
                           $('#IFRAME_DRILL_DOWN_2').attr('src', "<%= m_jsp_client_url %>"+"/dn_sale_drildown_2.jsp?chksql=sale_details_settle_date&facility_no=<%=m_facility_no%>&start_date=" + transaction_date + "&end_date=" + transaction_date);
                           $('#DIV_DRILL_DOWN_2').dialog('open');	
}			
   //-END load_client_portfolio------------------------------------------------------------------------------------------------------------------		
      
	
			
	function load_client_loan(){
		
		
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"availability_rpt?chksql=mt_loan_rpt&facility_no=<%=m_facility_no%>";
			
			
						
			jQuery('#TABLE_LOAN_DETAILS').jqGrid({
                   url: m_url,
                   loadonce: 1,
                   datatype: 'json',
                   colNames: [
                       '',
                       m_month_0,
                       m_month_1,
                       m_month_2,
                       m_month_3,
                       m_month_4,
                       m_month_5,
                       m_month_6,
                       'Total',
                       'Average'
                   ],
                   colModel: [
					    {name: 'PORT_LABEL',        index: 'PORT_LABEL',     sortable: false,    align: 'left',     width: 200,     resizable: false},//formatter: cellFomatterSLLabel,         unformat: unformatData
						{name: 'PORT_MONTH_0',      index: 'PORT_MONTH_0',   sortable: false,    align: 'right',    width:  85,     resizable: false, formatter:cellFomatterNumberLO, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'PORT_MONTH_1',      index: 'PORT_MONTH_1',   sortable: false,    align: 'right',    width:  85,     resizable: false, formatter:cellFomatterNumberLO, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'PORT_MONTH_2',      index: 'PORT_MONTH_2',   sortable: false,    align: 'right',    width:  85,     resizable: false, formatter:cellFomatterNumberLO, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'PORT_MONTH_3',      index: 'PORT_MONTH_3',   sortable: false,    align: 'right',    width:  85,     resizable: false, formatter:cellFomatterNumberLO, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'PORT_MONTH_4',      index: 'PORT_MONTH_4',   sortable: false,    align: 'right',    width:  85,     resizable: false, formatter:cellFomatterNumberLO, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'PORT_MONTH_5',      index: 'PORT_MONTH_5',   sortable: false,    align: 'right',    width:  85,     resizable: false, formatter:cellFomatterNumberLO, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'PORT_MONTH_6',      index: 'PORT_MONTH_6',   sortable: false,    align: 'right',    width:  85,     resizable: false, formatter:cellFomatterNumberLO, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'PORT_TOTAL',        index: 'PORT_TOTAL',     sortable: false,    align: 'right',    width:  85,     resizable: false, formatter:cellFomatterNumberLO, unformat: unformatData2},//,   formatter: cellFomatterNumberSLTot,     unformat: unformatData},
						{name: 'PORT_AVERAGE',      index: 'PORT_AVERAGE',   sortable: false,    align: 'right',    width:  85,     resizable: false, formatter:cellFomatterNumberLO, unformat: unformatData2},//,   formatter: cellFomatterNumberSLAve,     unformat: unformatData}
                   ],
                   // rowNum:10, 
					//rowList:[10,20,30],
				   mtype: 'GET',
                   rownumbers: false,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
				   onCellSelect: jq_grid_click_event_client_loan,
                   gridComplete: function() {
                       $('#jqgh_PORT_LABEL').css('cursor', 'default');
                       $('#jqgh_PORT_MONTH_0').css('cursor', 'default');
                       $('#jqgh_PORT_MONTH_1').css('cursor', 'default');
                       $('#jqgh_PORT_MONTH_2').css('cursor', 'default');
                       $('#jqgh_PORT_MONTH_3').css('cursor', 'default');
                       $('#jqgh_PORT_MONTH_4').css('cursor', 'default');
                       $('#jqgh_PORT_MONTH_5').css('cursor', 'default');
                       $('#jqgh_PORT_MONTH_6').css('cursor', 'default');
                       $('#jqgh_PORT_TOTAL').css('cursor', 'default');
                       $('#jqgh_PORT_AVERAGE').css('cursor', 'default');
                   },
                   caption: '<div id = "DIV_CLIENT_PAYMENT_REPORT_CAPTION" style = "width: 960px; text-align: center; font-size: 12px;">Margin Trading Loan Balance</div>'
              
                  
                  
               });
			
			// add custom button to export the data to excel
      jQuery("#TABLE_LOAN_DETAILS").jqGrid('navButtonAdd','#DIV_PAGER_LAON_DETAILS',{
       caption:"Excel", 
       onClickButton : function () { 
           jQuery("#TABLE_LAON_DETAILS").excelExport();
       } 
      });
			
		jQuery("#TABLE_LOAN_DETAILS").jqGrid('navGrid','#DIV_PAGER_LAON_DETAILS',{edit:false,add:false,del:false});
	}
			
			
			function jq_grid_click_event_client_loan(rowid, iCol, cellcontent) {
					
			
			 var m_selected_row = jQuery('#TABLE_PORTFOLIO_DETAILS').jqGrid('getRowData', rowid);
               var start_date = null;
               var end_date = null;
               if ((rowid == 2) ||(rowid == 3) || (rowid == 4)|| (rowid == 5)|| (rowid == 6)) {
                   if (iCol == 0) {
                       m_month = 'CLIENT';
                   }
                   else if (iCol == 1) {
                       m_month     = 0;
                       start_date  = m_month_0_start;
                       end_date    = m_month_0_today;// m_month_0_end;
						
                      /* if (rowid == 7) {
                           end_date    = m_month_0_today;
						}*/
                   }
                   else if (iCol == 2) {
                       m_month = -1;
					 // alert(m_month_1_start);	
                       start_date  = m_month_1_start;
                       end_date    = m_month_1_end;
                   }
                   else if (iCol == 3) {
                       m_month = -2;
                       start_date  = m_month_2_start;
                       end_date    = m_month_2_end;
                   }
                   else if (iCol == 4) {
                       m_month = -3;
                       start_date  = m_month_3_start;
                       end_date    = m_month_3_end;
                   }
                   else if (iCol == 5) {
                       m_month = -4;
                       start_date  = m_month_4_start;
                       end_date    = m_month_4_end;
                   }
                   else if (iCol == 6) {
                       m_month = -5;
                       start_date  = m_month_5_start;
                       end_date    = m_month_5_end;
                   }
                   else if (iCol == 7) {
                       m_month = -6;
                       start_date  = m_month_6_start;
                       end_date    = m_month_6_end;
                   }
                   else if (iCol == 8) {
                       m_month = 'TOTAL';
                       start_date  = m_month_6_start;
					   end_date    = m_month_0_end;
                      
                   }
				}//end if
					
				 if ((iCol == 0) || (iCol == 1) || (iCol == 2) || (iCol == 3) || (iCol == 4) || (iCol == 5) || (iCol == 6) || (iCol == 7) || (iCol == 8)) {
			
					if (rowid == 2) {//payment
                          
						 if ($('#DIV_DRILL_DOWN_3').dialog('isOpen')) {
                               $('#DIV_DRILL_DOWN_3').dialog('close');
                           }
                           $('#IFRAME_DRILL_DOWN_3').attr('src', '');
                           $('#IFRAME_DRILL_DOWN_3').remove();
                           $('#DIV_DRILL_DOWN_3').html(iframe_html_string_3);
                           $('#DIV_DRILL_DOWN_3').dialog('option', 'title', 'Drill Down');
                           if (iCol == 0) {
                              // $('#IFRAME_DRILL_DOWN').attr('src', "<%= m_jsp_client_url %>"+"/dn_parchase_drildown.jsp?chksql=all&facility_no=<%=m_facility_no%>");
                           }
                           else {
                           $('#IFRAME_DRILL_DOWN_3').attr('src', "<%= m_jsp_client_url %>"+"/dn_payment_drildown.jsp?chksql=payment_details_month&facility_no=<%=m_facility_no%>&start_date=" + start_date + "&end_date=" + end_date);
                           }
                           $('#DIV_DRILL_DOWN_3').dialog('open');
                       }	
						else if (rowid == 3) {//receipt
                           if ($('#DIV_DRILL_DOWN_3').dialog('isOpen')) {
                               $('#DIV_DRILL_DOWN_3').dialog('close');
                           }
                           $('#IFRAME_DRILL_DOWN_3').attr('src', '');
                           $('#IFRAME_DRILL_DOWN_3').remove();
                           $('#DIV_DRILL_DOWN_3').html(iframe_html_string_3);
                           $('#DIV_DRILL_DOWN_3').dialog('option', 'title', 'Drill Down');
                           if (iCol == 0) {
                              // $('#IFRAME_DRILL_DOWN').attr('src', "<%= m_jsp_client_url %>"+"/dn_parchase_drildown.jsp?chksql=all&facility_no=<%=m_facility_no%>");
                           }
                           else {
                               $('#IFRAME_DRILL_DOWN_3').attr('src', "<%= m_jsp_client_url %>"+"/dn_receipt_drildown.jsp?chksql=receipt_details_month&facility_no=<%=m_facility_no%>&start_date=" + start_date + "&end_date=" + end_date);
                           }
                           $('#DIV_DRILL_DOWN_3').dialog('open');
						}
						else if (rowid == 4) {//devident
                           if ($('#DIV_DRILL_DOWN_2').dialog('isOpen')) {
                               $('#DIV_DRILL_DOWN_2').dialog('close');
                           }
                           $('#IFRAME_DRILL_DOWN_2').attr('src', '');
                           $('#IFRAME_DRILL_DOWN_2').remove();
                           $('#DIV_DRILL_DOWN_2').html(iframe_html_string);
                           $('#DIV_DRILL_DOWN_2').dialog('option', 'title', 'Drill Down');
                           if (iCol == 0) {
                              // $('#IFRAME_DRILL_DOWN').attr('src', "<%= m_jsp_client_url %>"+"/dn_parchase_drildown.jsp?chksql=all&facility_no=<%=m_facility_no%>");
                           }
                           else {
                               $('#IFRAME_DRILL_DOWN_2').attr('src', "<%= m_jsp_client_url %>"+"/dn_market_value_difference_month.jsp?chksql=mkt_difference&facility_no=<%=m_facility_no%>&start_date=" + start_date + "&end_date=" + end_date);
                           }
                           $('#DIV_DRILL_DOWN_2').dialog('open');
                       }
						else if (rowid == 5){//deposit
                           if ($('#DIV_DRILL_DOWN_3').dialog('isOpen')) {
                               $('#DIV_DRILL_DOWN_3').dialog('close');
                           }
                           $('#IFRAME_DRILL_DOWN_3').attr('src', '');
                           $('#IFRAME_DRILL_DOWN_3').remove();
                           $('#DIV_DRILL_DOWN_3').html(iframe_html_string_3);
                           $('#DIV_DRILL_DOWN_3').dialog('option', 'title', 'Drill Down');
                           if (iCol == 0) {
                              // $('#IFRAME_DRILL_DOWN').attr('src', "<%= m_jsp_client_url %>"+"/dn_parchase_drildown.jsp?chksql=all&facility_no=<%=m_facility_no%>");
                           }
                           else {
                               $('#IFRAME_DRILL_DOWN_3').attr('src', "<%= m_jsp_client_url %>"+"/dn_deposit_drildown.jsp?chksql=deposit_details_month&facility_no=<%=m_facility_no%>&start_date=" + start_date + "&end_date=" + end_date);
                           }
                           $('#DIV_DRILL_DOWN_3').dialog('open');
						}
						else if (rowid == 6){//withdrawal
                           if ($('#DIV_DRILL_DOWN_3').dialog('isOpen')) {
                               $('#DIV_DRILL_DOWN_3').dialog('close');
                           }
                           $('#IFRAME_DRILL_DOWN_3').attr('src', '');
                           $('#IFRAME_DRILL_DOWN_3').remove();
                           $('#DIV_DRILL_DOWN_3').html(iframe_html_string_3);
                           $('#DIV_DRILL_DOWN_3').dialog('option', 'title', 'Drill Down');
                           if (iCol == 0) {
                              // $('#IFRAME_DRILL_DOWN').attr('src', "<%= m_jsp_client_url %>"+"/dn_parchase_drildown.jsp?chksql=all&facility_no=<%=m_facility_no%>");
                           }
                           else {
                               $('#IFRAME_DRILL_DOWN_3').attr('src', "<%= m_jsp_client_url %>"+"/dn_withdrawal_drildown.jsp?chksql=withdrawal_details_month&facility_no=<%=m_facility_no%>&start_date=" + start_date + "&end_date=" + end_date);
                           }
                           $('#DIV_DRILL_DOWN_3').dialog('open');
						}
					
					}
									
		}
   //-END load_client_loan------------------------------------------------------------------------------------------------------------------		
     		
			
		

function load_client_purchase_history(){
		
		
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"availability_rpt?chksql=mt_purchase_history_rpt&facility_no=<%=m_facility_no%>";
			
			
						
			jQuery('#TABLE_PURCHASE_HISTORY').jqGrid({
                   url: m_url,
                   loadonce: 1,
                   datatype: 'json',
                   colNames: [
                       '',
                       m_month_0,
                       m_month_1,
                       m_month_2,
                       m_month_3,
                       m_month_4,
                       m_month_5,
                       m_month_6,
                       'Total',
                       'Average'
                   ],
                   colModel: [
					   {name: 'PURCHASE_HISTORY_LABEL',        index: 'PURCHASE_HISTORY_LABEL',     sortable: false,    align: 'left',     width: 200,     resizable: false},//formatter: cellFomatterSLLabel,         unformat: unformatData
						{name: 'PURCHASE_HISTORY_MONTH_0',      index: 'PURCHASE_HISTORY_MONTH_0',   sortable: false,    align: 'right',    width:  85,     resizable: false, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'PURCHASE_HISTORY_MONTH_1',      index: 'PURCHASE_HISTORY_MONTH_1',   sortable: false,    align: 'right',    width:  85,     resizable: false, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'PURCHASE_HISTORY_MONTH_2',      index: 'PURCHASE_HISTORY_MONTH_2',   sortable: false,    align: 'right',    width:  85,     resizable: false, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'PURCHASE_HISTORY_MONTH_3',      index: 'PURCHASE_HISTORY_MONTH_3',   sortable: false,    align: 'right',    width:  85,     resizable: false, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'PURCHASE_HISTORY_MONTH_4',      index: 'PURCHASE_HISTORY_MONTH_4',   sortable: false,    align: 'right',    width:  85,     resizable: false, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'PURCHASE_HISTORY_MONTH_5',      index: 'PURCHASE_HISTORY_MONTH_5',   sortable: false,    align: 'right',    width:  85,     resizable: false, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'PURCHASE_HISTORY_MONTH_6',      index: 'PURCHASE_HISTORY_MONTH_6',   sortable: false,    align: 'right',    width:  85,     resizable: false, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'PURCHASE_HISTORY_TOTAL',        index: 'PURCHASE_HISTORY_TOTAL',     sortable: false,    align: 'right',    width:  85,     resizable: false, unformat: unformatData2},//,   formatter: cellFomatterNumberSLTot,     unformat: unformatData},
						{name: 'PURCHASE_HISTORY_AVERAGE',      index: 'PURCHASE_HISTORY_AVERAGE',   sortable: false,    align: 'right',    width:  85,     resizable: false, unformat: unformatData2},//,   formatter: cellFomatterNumberSLAve,     unformat: unformatData}
                   ],
                   // rowNum:10, 
					//rowList:[10,20,30],
				   mtype: 'GET',
                   rownumbers: false,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
				   footerrow: true,
				   userDataOnFooter: true,	
				   //onCellSelect: jq_grid_click_event_sales_ledger,
                   gridComplete: function() {
                       $('#jqgh_PURCHASE_HISTORY_LABEL').css('cursor', 'default');
                       $('#jqgh_PURCHASE_HISTORY_MONTH_0').css('cursor', 'default');
                       $('#jqgh_PURCHASE_HISTORY_MONTH_1').css('cursor', 'default');
                       $('#jqgh_PURCHASE_HISTORY_MONTH_2').css('cursor', 'default');
                       $('#jqgh_PURCHASE_HISTORY_MONTH_3').css('cursor', 'default');
                       $('#jqgh_PURCHASE_HISTORY_MONTH_4').css('cursor', 'default');
                       $('#jqgh_PURCHASE_HISTORY_MONTH_5').css('cursor', 'default');
                       $('#jqgh_PURCHASE_HISTORY_MONTH_6').css('cursor', 'default');
                       $('#jqgh_PURCHASE_HISTORY_TOTAL').css('cursor', 'default');
                       $('#jqgh_PURCHASE_HISTORY_AVERAGE').css('cursor', 'default');
                   },
                   caption: '<div id = "DIV_CLIENT_PURCHASE_HISTORY_CAPTION" style = "width: 960px; text-align: center; font-size: 12px;">Purchases History</div>'
              
                  
                  
               });
			
			// add custom button to export the data to excel
      jQuery("#TABLE_PURCHASE_HISTORY").jqGrid('navButtonAdd','#DIV_PAGER_PURCHASE_HISTORY',{
       caption:"Excel", 
       onClickButton : function () { 
           jQuery("#TABLE_PURCHASE_HISTORY").excelExport();
       } 
      });
			
		jQuery("#TABLE_PURCHASE_HISTORY").jqGrid('navGrid','#DIV_PAGER_PURCHASE_HISTORY',{edit:false,add:false,del:false});
	}
   //-END load_purchase_history------------------------------------------------------------------------------------------------------------------		
     				
		
			
			function load_client_sale_history(){
		
		
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"availability_rpt?chksql=mt_sale_history_rpt&facility_no=<%=m_facility_no%>";
			
			
						
			jQuery('#TABLE_SALE_HISTORY').jqGrid({
                   url: m_url,
                   loadonce: 1,
                   datatype: 'json',
                   colNames: [
                       '',
                       m_month_0,
                       m_month_1,
                       m_month_2,
                       m_month_3,
                       m_month_4,
                       m_month_5,
                       m_month_6,
                       'Total',
                       'Average'
                   ],
                   colModel: [
					   {name: 'SALE_HISTORY_LABEL',        index: 'SALE_HISTORY_LABEL',     sortable: false,    align: 'left',     width: 200,     resizable: false},//formatter: cellFomatterSLLabel,         unformat: unformatData
						{name: 'SALE_HISTORY_MONTH_0',      index: 'SALE_HISTORY_MONTH_0',   sortable: false,    align: 'right',    width:  85,     resizable: false, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'SALE_HISTORY_MONTH_1',      index: 'SALE_HISTORY_MONTH_1',   sortable: false,    align: 'right',    width:  85,     resizable: false, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'SALE_HISTORY_MONTH_2',      index: 'SALE_HISTORY_MONTH_2',   sortable: false,    align: 'right',    width:  85,     resizable: false, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'SALE_HISTORY_MONTH_3',      index: 'SALE_HISTORY_MONTH_3',   sortable: false,    align: 'right',    width:  85,     resizable: false, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'SALE_HISTORY_MONTH_4',      index: 'SALE_HISTORY_MONTH_4',   sortable: false,    align: 'right',    width:  85,     resizable: false, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'SALE_HISTORY_MONTH_5',      index: 'SALE_HISTORY_MONTH_5',   sortable: false,    align: 'right',    width:  85,     resizable: false, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'SALE_HISTORY_MONTH_6',      index: 'SALE_HISTORY_MONTH_6',   sortable: false,    align: 'right',    width:  85,     resizable: false, unformat: unformatData2},//,   formatter: cellFomatterNumberSL,        unformat: unformatData},
						{name: 'SALE_HISTORY_TOTAL',        index: 'SALE_HISTORY_TOTAL',     sortable: false,    align: 'right',    width:  85,     resizable: false, unformat: unformatData2},//,   formatter: cellFomatterNumberSLTot,     unformat: unformatData},
						{name: 'SALE_HISTORY_AVERAGE',      index: 'SALE_HISTORY_AVERAGE',   sortable: false,    align: 'right',    width:  85,     resizable: false, unformat: unformatData2},//,   formatter: cellFomatterNumberSLAve,     unformat: unformatData}
                   ],
                   // rowNum:10, 
					//rowList:[10,20,30],
				   mtype: 'GET',
                   rownumbers: false,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
				   footerrow: true,
				   userDataOnFooter: true,	
				   //onCellSelect: jq_grid_click_event_sales_ledger,
                   gridComplete: function() {
                       $('#jqgh_SALE_HISTORY_LABEL').css('cursor', 'default');
                       $('#jqgh_SALE_HISTORY_MONTH_0').css('cursor', 'default');
                       $('#jqgh_SALE_HISTORY_MONTH_1').css('cursor', 'default');
                       $('#jqgh_SALE_HISTORY_MONTH_2').css('cursor', 'default');
                       $('#jqgh_SALE_HISTORY_MONTH_3').css('cursor', 'default');
                       $('#jqgh_SALE_HISTORY_MONTH_4').css('cursor', 'default');
                       $('#jqgh_SALE_HISTORY_MONTH_5').css('cursor', 'default');
                       $('#jqgh_SALE_HISTORY_MONTH_6').css('cursor', 'default');
                       $('#jqgh_SALE_HISTORY_TOTAL').css('cursor', 'default');
                       $('#jqgh_SALE_HISTORY_AVERAGE').css('cursor', 'default');
                   },
                   caption: '<div id = "DIV_CLIENT_SALE_HISTORY_CAPTION" style = "width: 960px; text-align: center; font-size: 12px;">Sales History</div>'
              
                  
                  
               });
			
			// add custom button to export the data to excel
      jQuery("#TABLE_SALE_HISTORY").jqGrid('navButtonAdd','#DIV_PAGER_SALE_HISTORY',{
       caption:"Excel", 
       onClickButton : function () { 
           jQuery("#TABLE_SALE_HISTORY").excelExport();
       } 
      });
			
		jQuery("#TABLE_SALE_HISTORY").jqGrid('navGrid','#DIV_PAGER_SALE_HISTORY',{edit:false,add:false,del:false});
	}
   //-END load_sale_history------------------------------------------------------------------------------------------------------------------		
     
			
			
			   function loadGridActualPayments() {
             
               m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"BrokerBulkPaymentsAll?chksql=Bulk_payments_client&facility_no=<%=m_facility_no%>";
					jQuery('#TABLE_CLIENT_PAYMENT_REPORT_PAYMENTS').jqGrid({
                   url: m_url,
                   loadonce: 1,
                   datatype: 'json',
                   colNames: ['Beneficiary','Fasility Code' ,'Amount Payable', 'Amount Paid','Amount Pending','Payment Amount','Value Date','Mode', 'Company Bank Account', 'Comments','Save'],
                   colModel: [
						{name: 'ACTUAL_PAYMENTS_COLUMN_1',      index: 'ACTUAL_PAYMENTS_COLUMN_1',   sortable: false, align: 'center', width: 80, resizable: false,  unformat: unformatData,formatter: cellFomatterPayBeneficiary},//formatter: cellFomatterPaymentsColumn_1,
						{name: 'ACTUAL_PAYMENTS_COLUMN_1_1',    index: 'ACTUAL_PAYMENTS_COLUMN_1_1', hidden: true,  unformat: unformatData, formatter:cellFomatterPayClient},
						{name: 'ACTUAL_PAYMENTS_COLUMN_2',      index: 'ACTUAL_PAYMENTS_COLUMN_2',   sortable: false, align: 'center', width: 100, resizable: false,  unformat: unformatData},//formatter: cellFomatterPaymentsColumn_2,
						{name: 'ACTUAL_PAYMENTS_COLUMN_5',      index: 'ACTUAL_PAYMENTS_COLUMN_5',   sortable: false, align: 'right',  width: 100, resizable: false,  unformat: unformatData},//formatter: cellFomatterPaymentsColumn_5,
						{name: 'ACTUAL_PAYMENTS_COLUMN_6_0',    index: 'ACTUAL_PAYMENTS_COLUMN_6_0', sortable: false, align: 'right',  width: 100, resizable: false,  unformat: unformatData},//formatter: cellFomatterPaymentsColumn_6_0,
						{name: 'ACTUAL_PAYMENTS_COLUMN_6',      index: 'ACTUAL_PAYMENTS_COLUMN_6',   sortable: false, align: 'right',  width: 110, resizable: false,  unformat: unformatData , formatter: cellFomatterSetlAmount},//formatter: cellFomatterPaymentsColumn_6,
						{name: 'ACTUAL_PAYMENTS_COLUMN_7',      index: 'ACTUAL_PAYMENTS_COLUMN_7',   sortable: false, align: 'center', width: 80,  resizable: false,  unformat: unformatData,  formatter: cellFomatterPaySettDate},//formatter: cellFomatterPaymentsColumn_7, 
						{name: 'ACTUAL_PAYMENTS_COLUMN_8',      index: 'ACTUAL_PAYMENTS_COLUMN_8',   sortable: false, align: 'center', width: 110, resizable: false,  unformat: unformatData,  formatter: cellFomatterPayMode},//formatter: cellFomatterPaymentsColumn_8,
						{name: 'ACTUAL_PAYMENTS_COLUMN_9',      index: 'ACTUAL_PAYMENTS_COLUMN_9',   sortable: false, align: 'center', width: 75,  resizable: false,  unformat: unformatData,  formatter: cellFomatterPayCompanyAccNo},//formatter: cellFomatterPaymentsColumn_9,
						//{name: 'ACTUAL_PAYMENTS_COLUMN_9_1',    index: 'ACTUAL_PAYMENTS_COLUMN_9_1', sortable: false, align: 'center', width: 55,  resizable: false,  unformat: unformatData},//formatter: cellFomatterPaymentsColumn_9_1,
						{name: 'ACTUAL_PAYMENTS_COLUMN_10',    index: 'ACTUAL_PAYMENTS_COLUMN_10',   sortable: false, align: 'center', width: 100, resizable: false,  unformat: unformatData, formatter: cellFomatterPayComment},
						{name: 'ACTUAL_PAYMENTS_COLUMN_11',    index: 'ACTUAL_PAYMENTS_COLUMN_11',   sortable: false, align: 'center', width: 50, resizable: false,  unformat: unformatData,  formatter:checkBoxFmatterPaySave}],
                   mtype: 'GET',
                   rownumbers: true,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
                   toolbar: [true, 'top'],
                   caption: 'Client Payments',
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
                           document.getElementById('t_TABLE_CLIENT_PAYMENT_REPORT_PAYMENTS').style.height = '30px';
                           var m_toolbar = ' ' +
                               '<div style = "display: table-row;">' +
                               '   <div style = "display: table-cell;">' +
                               '       <input class = "but_input ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" type = "button" id = "BUT_ADD_PAYMENT_ITEM" name = "BUT_ADD_PAYMENT_ITEM" value = "Save Client Payment" onClick = "save_client_payment();" style = "width: 150px;" />' +
                               '   </div>' +
                               '   <div style = "width: 50px; display: table-cell;"></div>' +
                               '   <div style = "display: table-cell; font-weight: bold; cursor: default;">Net Availability :</div>' +
                               '   <div id = "DIV_NET_AVAILABILITY" style = "width: 100px; display: table-cell; text-align: right; font-weight: bold; cursor: default;"></div>' +
                               '   <div style = "width: 50px; display: table-cell;"></div>' +
                               '   <div style = "display: table-cell; font-weight: bold; cursor: default;">Payment :</div>' +
                               '   <div id = "DIV_FINAL_PAYMENT" style = "width: 100px; display: table-cell; text-align: right; font-weight: bold; cursor: default;">0.00</div>' +
                               '   <div style = "width: 50px; display: table-cell;"></div>' +
                               '   <div style = "display: table-cell; font-weight: bold; cursor: default;">Balance :</div>' +
                               '   <div id = "DIV_BALANCE" style = "width: 100px; display: table-cell; text-align: right; font-weight: bold; cursor: default;">0.00</div>' +
                                '   <div style = "display: table-cell; font-weight: bold; cursor: default;">Spot Margin:</div>' +
                               '   <div id = "DIV_SPORT_MARGIN" style = "width: 55px; display: table-cell; text-align: right; font-weight: bold; cursor: default;">0.00%</div>' +    
							
							   '</div>' +
                               ' ';
                         //  $('#t_TABLE_CLIENT_PAYMENT_REPORT_PAYMENTS').html(m_toolbar);
                           if ($('#HID_FINAL_AVAILABILITY').val() < 0) {
                               $('#DIV_NET_AVAILABILITY').css('color', 'red');
							}
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
                        var rec_count=$("#TABLE_CLIENT_PAYMENT_REPORT_PAYMENTS").jqGrid('getGridParam',"records");
                        document.Form1.hid_count.value=rec_count;
						get_paynment_headear_details();
					}
               });
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
	          var link ="<input type='checkbox' id='save_status_"+rowid+"'  name='save_status_"+rowid+"' value='on'  onclick =guaran('"+rowid+"');check_amount('"+rowid+"');    onchange=guaran('"+rowid+"');check_amount('"+rowid+"')  />"; 
              return link;
		  }
		 function cellFomatterPayComment(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span><input type='text' align='right' style ='text-align: right;'  id='comment_"+row_id+"' name='comment_"+row_id+"' value=''/></span>";
                     return texts;
          }
		 function cellFomatterPayMode(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span><select name='Hid_Sett_type_"+row_id+"'  ><OPTION VALUE='CHEQUE' SELECTED>CHEQUE</OPTION><OPTION VALUE='PAY_ORDER' SELECTED>PAY ORDER</OPTION><OPTION VALUE='BANK_TRANF'>BANK_TRANF</OPTION></select></span>";
				     return texts;
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
			
			function save_client_payment(){
			document.Form1.Hid_scr_name.value="Broker_Payment_Individual";
			 document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"save_BulkPaymentsAll?chksql=Broker_Payment";
		     document.Form1.submit();
			}
		//---end-----------	ActualPayments -------------------------------------------------------------------
		          function loadGridMemoPad() {
               m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"availability_rpt?q=1&chksql=get_client_payment_report_memo_pad&facility_no=<%=m_facility_no%>";
               jQuery('#TABLE_CLIENT_PAYMENT_REPORT_MEMO_PAD').jqGrid({
                   url: m_url,
                   datatype: 'json',
                   colNames: [
                       'Date',
                       'Entered By',
                       'Comments'
                   ],
                   colModel: [
                       {name: 'MEMO_PAD_COLUMN_1',                 index: 'MEMO_PAD_COLUMN_1',                 sortable: false,    align: 'center',    width: 100,     resizable: false,   formatter: cellFomatterMemoPadColumn_1, unformat: unformatData},
                       {name: 'MEMO_PAD_COLUMN_2',                 index: 'MEMO_PAD_COLUMN_2',                 sortable: false,    align: 'left',      width: 100,     resizable: false,   formatter: cellFomatterMemoPadColumn_2, unformat: unformatData},
                       {name: 'MEMO_PAD_COLUMN_3',                 index: 'MEMO_PAD_COLUMN_3',                 sortable: false,    align: 'center',    width: 300,     resizable: false,   formatter: cellFomatterMemoPadColumn_3, unformat: unformatData}
                   ],
                   mtype: 'GET',
                   rownumbers: true,
                   rowNum: 8,
                   gridview: true,
                   height: 'auto',
                   toolbar: [true, 'top'],
                   pager: jQuery('#DIV_CLIENT_PAYMENT_REPORT_MEMO_PAD_PAGER'),
                   hidegrid: false,
                   gridComplete: function() {
                       $('#jqgh_MEMO_PAD_COLUMN_1').css('cursor', 'default');
                       $('#jqgh_MEMO_PAD_COLUMN_2').css('cursor', 'default');
                       $('#jqgh_MEMO_PAD_COLUMN_3').css('cursor', 'default');
                       $('#t_TABLE_CLIENT_PAYMENT_REPORT_MEMO_PAD').html('<div style = "display: table-cell;">Comment&nbsp;&nbsp;&nbsp;&nbsp;<input class = "txt_input" type = "text" style = "width: 325px;" id = "TXT_MEMO_PAD_COMMENT" name = "TXT_MEMO_PAD_COMMENT" onBlur = "strTrim(this, null, null, \'COMMENT\');" /></div><div style = "display: table-cell;">&nbsp;&nbsp;&nbsp;&nbsp;<input class = "but_input ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" type = "button" id = "BUT_SAVE_MEMO_PAD" name = "BUT_SAVE_MEMO_PAD" value = "Save Memo" onClick = "saveMemoPad();" style = "width: 100px;" /></div>');
                       document.getElementById('t_TABLE_CLIENT_PAYMENT_REPORT_MEMO_PAD').style.height = '30px';
                   },
                   caption: 'Memo Pad'
               });
           }	
		 //---end --memopadfuntion----------------------------------------------------------------------------------------
			
		 function loadGridAvailabilitySummary() {
          
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"availability_rpt?chksql=memorandum_details_rpt&port=<%=m_facility_no%>&save_order_no=<%=m_save_order_no%>";	
			jQuery('#TABLE_CLIENT_PAYMENT_REPORT_CURRENT_ACCOUNT_SUMMARY').jqGrid({
                   url: m_url,
                   loadonce: 1,
                   datatype: 'json',
                   colNames: [
                       '',
                       '',
					   ''	
                   ],
                   colModel: [
						{name: 'SUMMARY_COL_1',        index: 'SUMMARY_COL_1',     sortable: false,    align: 'left',     width: 200,     resizable: false,		jsonmap: 'label'},//formatter: cellFomatterSLLabel,         unformat: unformatData
						{name: 'SUMMARY_COL_2',        index: 'SUMMARY_COL_2',     sortable: false,    align: 'right',    width:  85,     resizable: false,		jsonmap: 'value1',formatter: cellFomattersummercol2, unformat: unformatData2 },//,   formatter: cellFomatterNumberSLAve,     unformat: unformatData}
						{name: 'SUMMARY_COL_3',        index: 'SUMMARY_COL_3',     sortable: false,    align: 'right',    width:  85,     resizable: false,		jsonmap: 'value2',formatter: cellFomattersummercol2, unformat: unformatData2 }//,   formatter: cellFomatterNumberSLAve,     unformat: unformatData}
                   ],
                   // rowNum:10, 
					//rowList:[10,20,30],
				   mtype: 'GET',
                   rownumbers: false,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
				   //onCellSelect: jq_grid_click_event_sales_ledger,
                   caption: '<div id = "DIV_CLIENT_PAYMENT_REPORT_CAPTION" style = "width: 150px; text-align: center; font-size: 12px;">Memorandum Details</div>',
					jsonReader: {
						repeatitems: false
					}
              
                  
                  
               });
			}
		//END---loadGridAvailabilitySummary----------------------------------------------------------------------------------
			
			
			$(document).ready(function() {
              m_grid_height = ($(window).height() - 310);
               //$('#DIV_SECTION_1_DATE').text(': ' + m_sysdate_dd + '/' + m_sysdate_mm + '/' + m_sysdate_yy.substr(2, 2));
              // $('#DIV_SECTION_1_TIME').text(': ' + m_sysdate_time);
               //$('#DIV_SECTION_1_CURRENCY').text(': ' + m_facility_currency_symbol);
			  initDrillDownDialog();	
               $.ajax({
                   type: 'GET',
                   url : servlet_client_url+":"+client_t3_port+"/"+client_name+"availability_rpt?chksql=get_client_details_from_facility&facility_no=<%=m_facility_no%>",
				   dataType: 'xml',
                   success: function(xml) {
                       $(xml).find('DATA').each(function() {
                           $(this).find('ITEM').each(function() {
                              
                               m_month_0 = $(this).find('MONTH_0').text().toLowerCase().replace(/^(.)|\s(.)/g, function($1) { return $1.toUpperCase(); });
                               m_month_1 = $(this).find('MONTH_1').text().toLowerCase().replace(/^(.)|\s(.)/g, function($1) { return $1.toUpperCase(); });
                               m_month_2 = $(this).find('MONTH_2').text().toLowerCase().replace(/^(.)|\s(.)/g, function($1) { return $1.toUpperCase(); });
                               m_month_3 = $(this).find('MONTH_3').text().toLowerCase().replace(/^(.)|\s(.)/g, function($1) { return $1.toUpperCase(); });
                               m_month_4 = $(this).find('MONTH_4').text().toLowerCase().replace(/^(.)|\s(.)/g, function($1) { return $1.toUpperCase(); });
                               m_month_5 = $(this).find('MONTH_5').text().toLowerCase().replace(/^(.)|\s(.)/g, function($1) { return $1.toUpperCase(); });
                               m_month_6 = $(this).find('MONTH_6').text().toLowerCase().replace(/^(.)|\s(.)/g, function($1) { return $1.toUpperCase(); });
                              
							  
							   //document.getElementById("DIV_CLIENT").innerHTML = $(this).find('CLIENT_CODE').text().toLowerCase().replace(/^(.)|\s(.)/g, function($1) { return $1.toUpperCase(); }); change by waruna 2012-08-14
							   document.getElementById("DIV_CLIENT").innerHTML = $(this).find('CLIENT_FULL_NAME').text().toLowerCase().replace(/^(.)|\s(.)/g, function($1) { return $1.toUpperCase(); });	
							   document.getElementById("DIV_CLIENT_CODE").innerHTML = $(this).find('FACILITY_MANAGER_NAME').text().toLowerCase().replace(/^(.)|\s(.)/g, function($1) { return $1.toUpperCase(); });	
							   document.getElementById("DIV_FACILITY_NO").innerHTML = $(this).find('FACILITY_NO').text().toLowerCase().replace(/^(.)|\s(.)/g, function($1) { return $1.toUpperCase(); });
							   document.getElementById("DIV_BROKER_CODE").innerHTML = $(this).find('BROKER_CODE').text().toLowerCase().replace(/^(.)|\s(.)/g, function($1) { return $1.toUpperCase(); });		 					
							   document.getElementById("DIV_CDS_NO").innerHTML = $(this).find('CDS_NO').text().toLowerCase().replace(/^(.)|\s(.)/g, function($1) { return $1.toUpperCase(); });		 							
                               document.getElementById("DIV_DATE").innerHTML = $(this).find('SYS_DATE').text().toLowerCase().replace(/^(.)|\s(.)/g, function($1) { return $1.toUpperCase(); });
							   document.getElementById("DIV_TIME").innerHTML = $(this).find('SYS_TIME').text().toLowerCase().replace(/^(.)|\s(.)/g, function($1) { return $1.toUpperCase(); });
									
									
									
									//loadGridSalesLedger();
							   //loadGridAvailabilitySummary();		COMMENT BY WARUNA 2012-10-16 INF BY SM
                               //load_client_portfolio();COMMENT BY WARUNA 2012-10-16 INF BY SM
							   //load_client_loan();COMMENT BY WARUNA 2012-10-16 INF BY SM
							   load_settlement_details();
							   load_settlement_details_with_payment_no();
							   //load_settlement_details_approve_deatails();		
							   //load_pf_details();COMMENT BY WARUNA 2012-10-16 INF BY SM
							   //loadGridAvailabilityReport();		
									
							  // loadGridMemoPad();		
							 //  loadGridActualPayments();								
							  // load_client_purchase_history();
							 //  load_client_sale_history();		
                           });
                       });
                   }
               });
			
			    		
					
			 });
			
			
			function get_paynment_headear_details (){
			
			 $.ajax({
                   type: 'GET',
                   url : servlet_client_url+":"+client_t3_port+"/"+client_name+"availability_rpt?chksql=get_summarize_from_facility&facility_no=<%=m_facility_no%>",
				   dataType: 'xml',
                   success: function(xml) {
                       $(xml).find('DATA').each(function() {
                           $(this).find('ITEM').each(function() {
                              
                               
								document.getElementById("DIV_NET_AVAILABILITY").innerHTML =  format_noobject00($(this).find('NET_AVAILABILITY').text().toLowerCase().replace(/^(.)|\s(.)/g, function($1) { return $1.toUpperCase(); }), 2, null, 'BRACKETS');
								document.getElementById("DIV_FINAL_PAYMENT").innerHTML =  format_noobject00($(this).find('FINAL_PAYMENT').text().toLowerCase().replace(/^(.)|\s(.)/g, function($1) { return $1.toUpperCase(); }), 2, null, 'BRACKETS');		 							
								document.getElementById("DIV_BALANCE").innerHTML =  format_noobject00($(this).find('NET_AVAILABILITY').text().toLowerCase().replace(/^(.)|\s(.)/g, function($1) { return $1.toUpperCase(); }), 2, null, 'BRACKETS');		 						
								document.getElementById("DIV_SPORT_MARGIN").innerHTML =  format_noobject00($(this).find('SPORT_MARGIN').text().toLowerCase().replace(/^(.)|\s(.)/g, function($1) { return $1.toUpperCase(); }), 2, null, 'BRACKETS')+'%';		 								
									
									
										
                           });
                       });
                   }
               });
				
			}
			
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
			  $('#DIV_DRILL_DOWN_3').dialog({
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
			
			function cellFomatterSLLabel(cellvalue, options, rowObject) {
               var row_id = options['rowId'];
               if (row_id == 1) {
                   cellvalue = '<div style = "display: table-cell; vertical-align: middle; font-weight: bold; text-decoration: underline;">' + cellvalue + '</div>';
               }
               else if ((row_id == 3) || (row_id == 4) || (row_id == 5) || (row_id == 6) || (row_id == 7) || (row_id == 8) || (row_id == 9)) {
                   cellvalue = '<div style = "cursor: pointer; width: 200px; height: 22px; display: table-cell; vertical-align: middle;">' + cellvalue + '</div>';
               }
               else if (row_id == 10) {
                   cellvalue = '';
               }
               else if (row_id == 12) {
                   cellvalue = '<div style = "display: table-cell; vertical-align: middle; font-weight: bold;">' + cellvalue + '</div>';
               }
               return cellvalue;
           }
           function cellFomatterNumberSL(cellvalue, options, rowObject) {
               var row_id = options['rowId'];
				
               if ((row_id == 2) || (row_id == 3) || (row_id == 5) ) {
                     
					     cellvalue = format_noobject00(cellvalue, 2, null, 'BRACKETS');
                         cellvalue = '<div style = "cursor: pointer; width: 85px; display: table-cell; vertical-align: middle;">' + cellvalue + '</div>';
                  
                  
               }
               else  {
                   cellvalue = cellvalue;
               }
               return cellvalue;
           }
	 	   function cellFomatterNumberLO(cellvalue, options, rowObject) {
               var row_id = options['rowId'];
				
               if ((row_id == 2) || (row_id == 3) || (row_id == 4) || (row_id == 5)|| (row_id == 6)) {
                     
					     cellvalue = format_noobject00(cellvalue, 2, null, 'BRACKETS');
                         cellvalue = '<div style = "cursor: pointer; width: 85px; display: table-cell; vertical-align: middle;">' + cellvalue + '</div>';
                  
                  
               }
               else  {
                   cellvalue = cellvalue;
               }
               return cellvalue;
           }
		 	
			
		function cellFomattersummercol2(cellvalue, options, rowObject) {
		
			undefined
	
   if(cellvalue!=undefined){
       
		       //cellvalue = format_noobject00(cellvalue, 2, null, 'BRACKETS');
               cellvalue = '<div style = "cursor: pointer;">' + cellvalue + '</div>';
			   return cellvalue;
	 }else{
	 return '&nbsp;';
	 }    
	}
			
           function cellFomatterNumberSLTot(cellvalue, options, rowObject) {
               var row_id = options['rowId'];
               if ((row_id == 3) || (row_id == 4) || (row_id == 5) || (row_id == 6) || (row_id == 7) || (row_id == 8) || (row_id == 9)) {
                   cellvalue = format_noobject00(cellvalue, 2, null, 'BRACKETS');
                   cellvalue = '<div style = "cursor: pointer; width: 85px; display: table-cell; vertical-align: middle;">' + cellvalue + '</div>';
               }
               else  {
                   cellvalue = '';
               }
               return cellvalue;
           }
           function cellFomatterNumberSLAve(cellvalue, options, rowObject) {
               var row_id = options['rowId'];
               if ((row_id == 3) || (row_id == 4) || (row_id == 5) || (row_id == 6) || (row_id == 7) || (row_id == 8) || (row_id == 9)) {
                   cellvalue = format_noobject00(cellvalue, 2, null, 'BRACKETS');
               }
               else  {
                   cellvalue = '';
               }
               return cellvalue;
           }
		  function cellFomatterMemoPadColumn_1(cellvalue, options, rowObject) {
               var rowid = options['rowId'];
               return cellvalue;
           }
           function cellFomatterMemoPadColumn_2(cellvalue, options, rowObject) {
               var rowid = options['rowId'];
               return cellvalue;
           }
           function cellFomatterMemoPadColumn_3(cellvalue, options, rowObject) {
               var rowid = options['rowId'];
                   cellvalue = '<div style = "width: 285px; text-align: left">' + cellvalue + '</div>';
               return cellvalue;
           } 
			
		  function unformatData(cellvalue, options, cellobject) {
               return cellvalue;
           }
		function cellFomatterNumberPointer(cellvalue, options, rowObject) {
               cellvalue = format_noobject00(cellvalue, 2, null, 'BRACKETS');
               cellvalue = '<div style = "cursor: pointer;">' + cellvalue + '</div>';
               return cellvalue;
           }
         function unformatData2(cellvalue, options, cellobject) {
               return cellvalue;
           }			
				
			
		function guaran(line){ 
					if(document.Form1.elements["save_status_"+line].checked==true){ 
				  document.Form1.elements["save_status_"+line].value='Y'; 
					}else{
						document.Form1.elements["save_status_"+line].value='N'; 
					}
				}	
		
		function isNumber(sText) { 
					if (sText=='') return false;
					var ValidChars = ',-0123456789.';
					var IsNumber=true;
					var Char;
					var dotCnt = 0;
					for (i = 0; i < sText.length && IsNumber == true; i++)
					{
						Char = sText.charAt(i);
						if (Char=='.') dotCnt = dotCnt +1;
						if (ValidChars.indexOf(Char) == -1 || dotCnt>1)
						{
							IsNumber = false;
						}
					}
					return IsNumber;
				}
	function check_amount(line){
				//alert(parseFloat(unformat_noobject(document.Form1.elements["m_sett_amount_"+line].value))+"***"+parseFloat(unformat_noobject(document.Form1.elements["m_amount_"+line].value))); 
		if(parseFloat(unformat_noobject(document.Form1.elements["m_sett_amount_"+line].value))>parseFloat(unformat_noobject(document.Form1.elements["m_amount_"+line].value))){ 
					document.Form1.elements["save_status_"+line].value='N'; 
					document.Form1.elements["save_status_"+line].checked=false 
				     alert('Amount should not be grater than '+document.Form1.elements["m_amount_"+line].value+'.'); 
					document.Form1.elements["save_status_"+line].checked=false 
				
					}
				
				 else if(isNumber(unformat_noobject(document.Form1.elements["m_sett_amount_"+line].value))==false){ 
						document.Form1.elements["save_status_"+line].value='N'; 
					    document.Form1.elements["save_status_"+line].checked=false
				        alert('Please Enter Numerics for The Net Amount'); 
					}
				
		else if(parseFloat(unformat_noobject(document.Form1.elements["m_sett_amount_"+line].value))>parseFloat(unformat_noobject(document.Form1.elements["m_amount_"+line].value))){ 
						document.Form1.elements["save_status_"+line].value='N'; 
					    document.Form1.elements["save_status_"+line].checked=false
				        alert('Please Enter Less Amount'); 
					}else{
					
					
					}
	}	
		
	 function saveMemoPad() {
               if ($('#TXT_MEMO_PAD_COMMENT').val().length > 0) {
                   if (confirm('Are you sure you want to save an entry in the memo pad?')) {
                       for (var i = 0; i < document.Form1.elements.length; i++) {
                           document.Form1.elements[i].disabled = false;
                       }
                       $('#hid_memo_pad_save_status').val(1);
                        document.Form1.Hid_scr_name.value="Broker_Payment_Individual";
						document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"save_BulkPaymentsAll?chksql=Broker_Payment";
						document.Form1.submit();
                   }
               }
               else {
                   alert('Please enter a memo in the memo pad.');
                   $('#TXT_MEMO_PAD_COMMENT').focus();
               }
           }		
	function chk_margin_factor(line){
				
				}	
	function print_data(){
		
		     
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"BrokerBulkPaymentsVoucher?chksql=gen_payment_voucher";
			//window.open(m_url);
			load_interface(m_url,'XML',false);
		    m_size = data_vec.length;
		
			if(m_size>0){	
			    var m_voucher_no=data_vec[0];
				document.getElementById("DIV_PAYMENT_VAUCHER_REF_NO").innerHTML= m_voucher_no;
				
				
				//TABLE_SETTLEMENT_DETAILS2
				
				var m_detail_grid_no_of_rows   = $('#TABLE_SETTLEMENT_DETAILS2').jqGrid('getGridParam',"records");
			    var m_flag = false ;
			  
				for(j = 1 ; j <= m_detail_grid_no_of_rows; j ++){
				
				  var m_selected_row = jQuery('#TABLE_SETTLEMENT_DETAILS2').jqGrid('getRowData', j);
			     // alert(m_selected_row.Payment_No);
					
				 				      var m_payment_no     = m_selected_row.Payment_No;
								      var m_date		     = m_selected_row.Date;
									  var m_ref_no   	     = m_selected_row.Ref_No;
									  var m_purchases	     = unformat_noobject(m_selected_row.Purchases);
									  var m_receipts	     = unformat_noobject(m_selected_row.Receipts);
									  var m_due_amount     = unformat_noobject(m_selected_row.Due_Amount)	;
									  var m_payment_amount = unformat_noobject(m_selected_row.Payment_Amount);
									  var m_balance	     = unformat_noobject(m_selected_row.Balance);
									 // var m_facility_no    = <%=m_facility_no%>;
					
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_payments_voucher?Hid_scr_name=payment_voucher_details&voucher_no="+m_voucher_no+"&payment_no="+m_payment_no+"&date="+m_date+"&ref_no="+m_ref_no+"&purchases="+m_purchases+"&receipts="+m_receipts+"&due_amount="+m_due_amount+"&payment_amount="+m_payment_amount+"&balance="+m_balance+"&facility_no=<%=m_facility_no%>&save_order_no=<%=m_save_order_no%>";
					//window.open(m_url);
					load_interface(m_url,'XML',false);
					//alert(data_vec[0]+'**');
					m_size = data_vec.length;
		            if(data_vec[0]=="OK"){
					 
					  m_flag =true ;	
					  
					}else{
					 m_flag =false ;
					 document.getElementById("DIV_PAYMENT_VAUCHER_REF_NO").innerHTML= "";
					 alert('Error..Data not save.');	
					}
						
				}
		
				if(m_flag ==true){
				 $('#DIV_PRINT').empty();
                   window.print();
				}
				
				
			
				
			  }else{
			   alert('Payment Voucher No. not Generated..Please try again');
			   		
			  }	
				
		
               
           }
			
			
		function loadGridAvailabilityReport() {
				
				// var m_client_code= document.getElementById("txt_client_code").value;
				//var m_client_manager= document.getElementById("TXT_CLIENT_MANAGER").value;
				var m_port          = '<%=m_facility_no%>'; //document.getElementById("txt_facility_number").value;
				var m_save_order_no = '<%=m_save_order_no%>';
				//var m_broker_code= document.getElementById("txt_broker_code").value;		
				
				//  m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"BrokerBulkPaymentsFirstSign?chksql=bulk_save_increase_availability&port="+m_port+"&client_code="+m_client_code+"&client_manager="+m_client_manager+"&broker_code="+m_broker_code+"";
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"increase_availability?chksql=get_increase_availability_summary_on_payment&port="+m_port+"&save_order_no="+m_save_order_no+"";		
				
				jQuery('#TABLE_CLIENT_AVAILABILITY_INCREASE').GridUnload();
				jQuery('#TABLE_CLIENT_AVAILABILITY_INCREASE').jqGrid({
						url: m_url,
						//loadonce: 1,
						datatype: 'json',
						colNames: ['','System','Recommended','Approved'],
						colModel: [
							{name: 'Summery',             index: 'Summery',   		jsonmap: 'Summery',         sortable: false, align: 'left',   width: 180, resizable: false,    unformat: unformatData },//formatter: cellFomatterPaymentsColumn_1,
							{name: 'System',              index: 'System',       	jsonmap: 'System', 	        sortable: false, align: 'right',  width: 100, resizable: false,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_1,
							{name: 'Recommended',         index: 'Recommended',   	jsonmap: 'Recommended', 	sortable: false, align: 'right',  width: 100, resizable: false,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_1,
							{name: 'Approved',            index: 'Approved',      	jsonmap: 'Approved', 	    sortable: false, align: 'right' , width: 100, resizable: false,  unformat: unformatData}
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
						//onCellSelect: jq_grid_click_event_avail_summary,				
						jsonReader: {repeatitems: false},
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
							var rec_count=$("#TABLE_CLIENT_AVAILABILITY_INCREASE").jqGrid('getGridParam',"records");
							document.Form1.hid_count.value=rec_count;
						}
					});
			}	
		</script>
 	
 </head>
    
    <body class="body & txt-body">
        <form name="Form1">
			 <input type = "hidden" id = "HID_FINAL_AVAILABILITY" name = "HID_FINAL_AVAILABILITY" />
			 <input type = "hidden" id = "Hid_scr_name" name = "Hid_scr_name" />
			 <input type = "hidden" id = "hid_count" name = "hid_count" />
			 <input type = "hidden" id = "hid_memo_pad_save_status" name = "hid_memo_pad_save_status" />
			 <input type = "hidden" id = "hid_facility_code" name = "hid_facility_code" value="<%=m_facility_no%>"/>
			 <input type = "hidden" id = "hid_save_order_no" name = "hid_save_order_no" value="<%=m_save_order_no%>"/>
			
		     <div style="visibility:hidden" >
                <table class="table" align="center" border="0" cellpadding="0" cellspacing="0" width="99%">
                    <tr>
                        <td height="7"></td>
                    </tr>
                    
                    <tr height="30">
                        <td width="13px" style="background-image: url('<%= m_jsp_client_url %>/images/l1.gif'); background-repeat: no repeat;" id="hi1"></td>
                        <td style="background-image: url('<%= m_jsp_client_url %>/images/l3.gif'); background-repeat: repeat;" id="hi2" align="left"><b>Administration - Settlement Management</b></td>
                        <td width="13px" style="background-image: url('<%= m_jsp_client_url %>/images/l2.gif'); background-repeat: no repeat;"  id="hi3"></td>
                    </tr>
                </table>
					
					
            </div>	
				
			<!--
			<div>		
				
				<table class="table" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td height="1"></td>
                </tr>
            </table>
					
			</div>	
			-->	
            <div style="visibility:hidden" >
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
                       <!--  <input class="mainbut" type="button" name="save_but" value="Save" onclick="document.Form2.save_but.disabled=true; parent.frames[1].beforesubmit();" />-->
                    </td>
                    <td width="6%">
                        <input class="mainbut" type="button" name="calcel_but" value="Cancel" onclick="document.Form2.save_but.disabled=false; top.frames[1].location.href=top.frames[1].location.href;" />
                    </td>
                    <td width="6%">
                        <input class="mainbut" type="button" name="Exit_but" value="Exit" onclick="window.close();" />
                    </td>
                    <td width="6%">
                       <!-- <input class="mainbut" type="button" name="report_but" value="Enquiry" onclick="obtain_report_before();" />-->
                    </td>
                    <td width="50%" class="hh1" align="right"><b>Payment Voucher</b></td>
                </tr>
            </table>
			</div>
			<DIV>	
            <table width="100%">
                <tr height="25px;"></tr>
            </table>
				
			<div id = "DIV_PRINT">
               <table class = "table">
                   <tr>
                       <td>
							<%if(m_print_enable==true){ %>	
                           <input class = "ui-state-default ui-corner-all" type = "button" id = "BUT_PRINT" name = "BUT_PRINT" value = "Print" onclick = "print_data();" />
                           <% } %>
                       </td>
                   </tr>
               </table>
					
           </div>	
				
            <hr />
				
            <table width="100%">
                <tr height="25px;" ></tr>
		    </table>
             <br /> 
		    </DIV>	
				
			<table width="100%">
                <TD height="25px;" align="CENTER" ><H3>Payment Voucher</H3></td>
		    </table>
            	
				
			<table border = "0">
				
					
					<tr>
                          <td style = "width: 200px;"><div id = "DIV_TXT_CLIENT_LB">Client :</div></td>
						       <td><div id="DIV_CLIENT" ></div>
                                  </td>
                                      <td style = "width: 260px;">
                                         <td style = "width: 120px;">Date :
                                      </td>
                                    <td style = "width: 100px;"><div id="DIV_DATE" ></div></td>
                                <td>
                             
                          </td>
                      </tr>
					
					
					<tr>
                         <td style = "width: 200px;"><div id = "DIV_TXT_CLIENT_CODE_LB">Client Manager : </div></td>
                              <td> <div id = "DIV_CLIENT_CODE"> </div></td>
                                  <td style = "width: 260px;">
                                       </td>
                                    <td style = "width: 120px;">Time :</td>
                               <td style = "width: 100px;"><div id="DIV_TIME" ></div></td>
                           <td></td>
                     </tr>
					  
					<tr>
                          <td style = "width: 200px;"><div id = "div_txt_facility_number">Facility Number : </div></td>
						       <td> <div id = "DIV_FACILITY_NO"> </div>
                                  </td>
                                      <td style = "width: 260px;"></td>
                                        <td style = "width: 120px;">
                                       </td>
                                    <td style = "width: 100px;"></td>
                                <td>
                            
                          </td>
                      </tr>
						
						<tr>
                          <td style = "width: 200px;"><div id = "div_txt_facility_number">CDS Account Number : </div></td>
						       <td> <div id = "DIV_CDS_NO"> </div>
                                  </td>
                                      <td style = "width: 260px;"></td>
                                        <td style = "width: 120px;">
                                       </td>
                                    <td style = "width: 100px;"></td>
                                <td>
                            
                          </td>
                      </tr>	
					
                    <tr>
                          <td style = "width: 200px;"><div id = "div_txt_broker_code">Broker Code : </div></td>
						       <td>
								<div id = "DIV_BROKER_CODE"> </div>
                                  </td>
                                      <td style = "width: 260px;">
                                         <td style = "width: 120px;">Voucher Number:
                                       </td>
                                    <td style = "width: 100px;"><div id ='DIV_PAYMENT_VAUCHER_REF_NO'></div> </td><!-- <%=m_payment_no%>-->
                                <td>
                             
                          </td>
                      </tr>  
								
								
					<tr>
                          <td style = "width: 200px;"></div></td>
						       <td> 
                                  </td>
                                      <td style = "width: 260px;">
                                        <td style = "width: 120px;">
                                       </td>
                                    <td style = "width: 100px;"></td>
                                <td>
                            
                          </td>
                      </tr>	
								
				 <tr>
                          <td style = "width: 200px;"><div id = "div_txt_settlement_mode">Settlement Mode : </div></td>
						       <td>
								<div id = "DIV_SETTLEMENT_MODE"><%=m_mode%> </div>
                                  </td>
                                      <td style = "width: 260px;"></td>
                                         <td style = "width: 120px;">Cheque Number:
                                       </td>
                                    <td style = "width: 100px;"><%=m_cheque_no%></td>
                                <td>
                             
                          </td>
                      </tr> 
					
									
                     <tr>            
				       <td style = "width: 200px;"><div id = "div_txt_payment_type">Payment Type : </div></td>
						       <td>
								<div id = "DIV_PAYMENT_TYPE"><%=m_payment_type%> </div>
                                  </td>
                                      <td style = "width: 260px;">
                                         <td style = "width: 120px;">
                                       </td>
                                    <td style = "width: 100px;"></td>
                                <td>
                             
                          </td>
                      </tr> 					
				     <tr>            
				       <td style = "width: 200px;"><div id = "div_txt_payment_type">Payment Category : </div></td>
						       <td>
								<div id = "DIV_PAYMENT_TYPE"><%=m_payment_category_1%> </div>
                                  </td>
                                      <td style = "width: 260px;">
                                         <td style = "width: 120px;">
                                       </td>
                                    <td style = "width: 100px;"></td>
                                <td>
                             
                          </td>
                      </tr> 					
				
					
					 <tr>            
				       <td style = "width: 200px;"></td>
						       <td>
								
                                  </td>
                                      <td style = "width: 260px;">
                                         <td style = "width: 120px;">
                                       </td>
                                    <td style = "width: 100px;"></td>
                                <td>
                             
                          </td>
                      </tr> 
											
										
					   <tr>            
				       <td style = "width: 200px;"><B>Payment Details :<B></td>
						       <td>
								
                                  </td>
                                      <td style = "width: 260px;">
                                         <td style = "width: 120px;">
                                       </td>
                                    <td style = "width: 100px;"></td>
                                <td>
                             
                          </td>
                      </tr> 
												
					<tr>            
				       <td style = "width: 200px;"><div id = "div_txt_payee">Payee: </div></td>
						       <td>
								<div id = "DIV_PAYEE"><%=m_payee%> </div>
                                  </td>
                                      <td style = "width: 260px;">
                                         <td style = "width: 120px;">
                                       </td>
                                    <td style = "width: 100px;"></td>
                                <td>
                             
                          </td>
                      </tr> 
				 </table>	
													
			<!-- -------------------------------------  -----add by waruna 2012-07-25 --------------------------------------------------------------------        -->	
				<table border = "0" >									
					<tr>            
				       <td style = "width: 200px;"><div id = "div_txt_payment_amount"></div></td>
						       <td style = "width: 120px;">
								<div id = "div_txt_bank_code">Payee Bank Code</div>
                                  </td>
                                      <td style = "width: 20px;"></td>
                                         <td style = "width: 120px;">Payee Branch Code 
                                       </td>
                                    <td style = "width: 120px;">Payee Payment Account</td>
                                <td>
                             
                          </td>
                      </tr> 
													
					<tr>            
				       <td style = "width: 200px;"><div id = "div_txt_payment_amount"></div></td>
						       <td style = "width: 120px;">
								<div id = "div_txt_bank_code"><%=m_payee_bank_code%></div>
                                  </td>
                                      <td style = "width: 20px;"></td>
                                         <td style = "width: 120px;"><%=m_payee_branch_code%> 
                                       </td>
                                    <td style = "width: 100px;"><%=m_payee_acc_no%></td>
                                <td>
                             
                          </td>
                      </tr>								
					
													
															
               <!--</table>-->										
		<!---------------------------------------  -------------------------------------------------------------------------        -->	
				<!--<table border = "0">	-->
					<tr>            
				       <td style = "width: 200px;"><div id = "div_txt_payment_amount">Payment Amount</div></td>
						       <td style = "width: 120px;">
								<div id = "div_txt_bank_code">Bank Code</div>
                                  </td>
                                      <td style = "width: 20px;"></td>
                                         <td style = "width: 120px;">Branch Code 
                                       </td>
                                    <td style = "width: 100px;">Payment Account</td>
                                <td>
                             
                          </td>
                      </tr> 
													
					<tr>            
				       <td style = "width: 200px;"><div id = "div_txt_payment_amount"><%=m_amount%></div></td>
						       <td style = "width: 120px;">
								<div id = "div_txt_bank_code"><%=m_bank_code%></div>
                                  </td>
                                      <td style = "width: 20px;"></td>
                                         <td style = "width: 120px;"><%=m_branch_code%> 
                                       </td>
                                    <td style = "width: 100px;"><%=m_acc_no%></td>
                                <td>
                             
                          </td>
                      </tr>								
					
						<tr>            
				       <td style = "width: 200px;"><div id = "div_txt_payment_amount">Remarks:</div></td>
						       <td style = "width: 120px;">
								<div id = "div_txt_bank_code"></div>
                                  </td>
                                      <td style = "width: 20px;"></td>
                                         <td style = "width: 120px;">
                                       </td>
                                    <td style = "width: 100px;"></td>
                                <td>
                             
                          </td>
                      </tr>								
															
               </table>	
			
				
	   <BR>
		   		
	   <div id = "DIV_SETTLEMENT_DETAILS">
                     <table id = "TABLE_SETTLEMENT_DETAILS"></table>
                      <div id = "DIV_PAGER_SETTLEMENT_DETAILS"></div>

       </div>
	   <BR>										
	   <div id = "DIV_SETTLEMENT_DETAILS2"  style="display:none;" ><!-- style="visibility:hidden;" -->
                     <table id = "TABLE_SETTLEMENT_DETAILS2"></table>
                     <div id = "DIV_PAGER_SETTLEMENT_DETAILS2"></div>

       </div>										
	   <BR>	
       	   <div id = "DIV_PORTFOLIO_DETAILS">
                     <table id = "TABLE_PORTFOLIO_DETAILS"></table>
                      <div id = "DIV_PAGER_PORTFOLIO_DETAILS"></div>

       </div>												
												
	
	   <BR>					
		 <div id = "DIV_LOAN_DETAILS">
                     <table id = "TABLE_LOAN_DETAILS"></table>
                      <div  id =  "DIV_PAGER_LOAN_DETAILS"></div>
       <BR>	 
       </div>
	                                             
								
												<div id = "DIV_CLIENT_PAYMENT_REPORT_SUMMARY">
                                                   <table>
                                                       <tr>
                                                           <td valign = "top">
                                                               <table id = "TABLE_CLIENT_PAYMENT_REPORT_CURRENT_ACCOUNT_SUMMARY">
                                                               </table>
                                                           </td>
                                                           <td width = "100" style = "min-width: 145px;">
                                                           </td>

                                                           <td valign = "top">
                                                               <table id = "TABLE_CLIENT_PAYMENT_REPORT_MEMO_PAD">
                                                               </table>
                                                               <div id = "DIV_CLIENT_PAYMENT_REPORT_MEMO_PAD_PAGER">
                                                               </div>
																
								<div id = "DIV_CLIENT_AVAILABILITY">
									<table id = "TABLE_CLIENT_AVAILABILITY_INCREASE"></table>
									<div id = "DIV_PAGER_TABLE_CLIENT_AVAILABILITY_INCREASE"></div>
									
								</div>
                                                           </td>
                                                       </tr>
                                                   </table>
                                               </div>
	 <BR>	
												
											
	   <div id = "DIV_SETTLEMENT_DETAILS3"><!-- style="visibility:hidden;" -->
                     <table id = "TABLE_SETTLEMENT_DETAILS3"></table>
                     <div id = "DIV_PAGER_SETTLEMENT_DETAILS3"></div>

       </div>										
	   <BR>	
												
	 <div id = "DIV_PF_DETAILS">
                     <table id = "TABLE_PF_DETAILS"></table>
                      <div id = "DIV_PAGER_PF_DETAILS"></div>

       </div>
	  
	   <BR>
												
												
	   <div id = "div_CLIENT_PAYMENT_REPORT_AVAILABILITY_PAYMENTS">
           <table>
                <tr>
                  <td valign = "top">
                      <table id = "TABLE_CLIENT_PAYMENT_REPORT_PAYMENTS">
                      </table>
                </td>
             </tr>
          </table>
      </div>
						
	   <BR>	
		
	   <div id = "DIV_PURCHASE_HISTORY">

                     <table id = "TABLE_PURCHASE_HISTORY"></table>
                      <div  id =  "DIV_PAGER_PURCHASE_HISTORY"></div>

       </div>
	    <BR>	
		
	   <div id = "DIV_SELE_HISTORY">

                     <table id = "TABLE_SALE_HISTORY"></table>
                      <div  id =  "DIV_PAGER_SELE_HISTORY"></div>

       </div>				
		
	    <div id = "DIV_DRILL_DOWN" title = "">
               <iframe id = "IFRAME_DRILL_DOWN" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Invoice Drill Down">
               </iframe>
        </div>	
		 <div id = "DIV_DRILL_DOWN_2" title = "">
               <iframe id = "IFRAME_DRILL_DOWN_2" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Invoice Drill Down">
               </iframe>
        </div>
	   <div id = "DIV_DRILL_DOWN_3" title = "">
               <iframe id = "IFRAME_DRILL_DOWN_3" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Invoice Drill Down">
               </iframe>
        </div>					
		
	    <TABLE>
		<TR><TD></TD><TD align="center">........................</TD><TD width = "10%"></TD><TD align="center">........................</TD><TD width = "10%" ></TD><TD align="center">........................</TD></TR>									
		<TR><TD></TD><TD align="center">Data Entered</TD><TD width = "10%" ></TD><TD align="center">1st Signature</TD><TD width = "10%"></TD><TD align="center">2nd Signature</TD></TR>								
		</TABLE>									
						
        </form>		
			
 </body>		
</html>
	<% 
	if(conn!=null){conn.close();}		
	%>