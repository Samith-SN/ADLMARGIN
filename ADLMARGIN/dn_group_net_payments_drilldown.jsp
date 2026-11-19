<HTML> 
	<HEAD>
		<TITLE>Margin Trading 
		</TITLE>
		<LINK REL="stylesheet" TYPE="text/css" HREF="" />
		
		
	</HEAD>
	<%@page import="net.sasianet.ADLMARGIN.*" %>
	
	<%	
		ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session); 
		//***************  ADDED BY KANISHKA ON 26/12/2012  *********************//
	
		Object done = (String)session.getValue("logon.isDone");  // marker object
		if (done == null) {
			response.sendRedirect("login.jsp");
			return;
			}
	
	//*************** ADDED BY KANISHKA ON 26/12/2012 [END]  *********************//
		
		String payment_no = request.getParameter("payment_no");
		String m_jsp_client_url = m_sn_methods.jsp_client_url;
		
		//out.println(facility_no);
		
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/redmond/jquery-ui.css' TYPE=\"text/css\">");
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/blue/style.css' TYPE=\"text/css\">");
		
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");	
		
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/SNET/jquery/grid/4.1/themes/ui.jqgrid.css' TYPE=\"text/css\">");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/i18n/grid.locale-en.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/jquery.jqGrid.min.js\"></script>");

		
	%>
	
	<SCRIPT language="JavaScript1.2" >
		
			function pop_up_message_2(m_url){					
				if ($("#DIV_MSG_WINDOW").dialog("isOpen")) 
				{
            		$("#DIV_MSG_WINDOW").dialog("close");
            	}
            	$("#DIV_MSG_WINDOW").dialog("option", "title", "Pending Payments");
            	$("#DIV_MSG_WINDOW").dialog("open");
            	$("#IFRAME_MSG_WINDOW").attr("src",m_url);
            	return false;
				
			}
		
			function hide_image(){
				$("#DIV_MSG_WINDOW").dialog("close");
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
	
	        function clearIsOpen()
			{ 
              	isOpen=false; 
            }
	
			var isOpen=false;
		
			function initmsgDrillDialog()
	        {
				
	             $("#DIV_MSG_WINDOW").dialog(
				
				 {					
	            	bgiframe: true,
	            	autoOpen: false,
	            	//modal: false,
					modal: true, //to disable the back ground	
	            	height: 400,
	            	width: getW,
	            	close: function() 
					{
						
	            	}
	              }
				 );
           }
		
		
		   function initmsgDealTicketDrill(h,w)
	        {
				
	             $("#DIV_MSG_DEAL_TICKET").dialog(
				
				 {
					
	            	bgiframe: true,
	            	autoOpen: false,
	            	//modal: false,
					modal: true, //to disable the back ground	
	            	height: h,
	            	width: w,
	            	close: function() 
					{
						
	            	}
	              }
				 );
           }
		
		
			$(document).ready
			(
				
				function() 
				{
					m_grid_height = ($(window).height() - 310);
	 				initmsgDrillDialog();
					initmsgDealTicketDrill(100,500);
					m_grid_height = ($(window).height() - 150);
			   		m_grid_width = ($(window).width() - 0);
				}
			);
			
		
			function chkstartdate(dayobj,monthobj,yearobj) {
				checkMonthLength(dayobj,monthobj,yearobj);		
			}
		
			function screen_close(){
				top.frames[1].location.href='low.jsp';
			} 		

		
		function fn_view() {   
			
			var payment_no = "<%=payment_no%>";
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"group_net_payments_drilldown?chksql=group_net_payments_drilldown&payment_no="+payment_no; 
			                  
					jQuery('#TABLE_AVAILABILITY_DETAILS').GridUnload();
					jQuery('#TABLE_AVAILABILITY_DETAILS').jqGrid({
                    url: m_url,
                   //loadonce: 1,
                   datatype: 'json',
                   colNames: ['Payment No','Broker','Client Manager','Fasility Number','Client Name' ,'Payment Amount','Value Date','Transation Date','Mode', 'Company Bank Account'],//, 'Comments','Settlement Mode','1st Signature','Reject'
                   colModel: [
						
						{name: 'Payment_No',             index: 'Payment_No',   		jsonmap: 'Payment_No',         sortable: false, align: 'center', width: 100, resizable: false,    unformat: unformatData },//,formatter:cellFomatterPaymentNo//formatter: cellFomatterPaymentsColumn_1,
						{name: 'Beneficiary',            index: 'Beneficiary',      	jsonmap: 'Beneficiary', 		sortable: false, align: 'center',  width: 60, resizable: false,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_5,
						{name: 'Client_Manager',         index: 'Client_Manager',   	jsonmap: 'Client_Manager', 	    sortable: false, align: 'center', width: 100, resizable: false,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_1,
						{name: 'Fasility_Number',        index: 'Fasility_Number',  	jsonmap: 'Fasility_Number', 	sortable: false, align: 'center' , width: 100, resizable: false,  unformat: unformatData},
						{name: 'Client_Name',            index: 'Client_Name',      	jsonmap: 'Client_Name', 		sortable: false, align: 'left', width: 100, resizable: true,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_2,
						{name: 'Payment_Amount',         index: 'Payment_Amount',   	jsonmap: 'Payment_Amount',  	sortable: false, align: 'right',  width: 100, resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_6_0,
						{name: 'Value_Date',             index: 'Value_Date',       	jsonmap: 'Value_Date',  		sortable: false, align: 'right',  width: 100, resizable: false,   unformat: unformatData },//formatter: cellFomatterPaymentsColumn_6,
						{name: 'Tran_Date',              index: 'Tran_Date',       		jsonmap: 'Tran_Date',    		sortable: false, align: 'right',  width: 100, resizable: false,   unformat: unformatData },//formatter: cellFomatterPaymentsColumn_6,
						{name: 'Mode',                   index: 'Mode',             	jsonmap: 'Mode',  			    sortable: false, align: 'center', width: 80,  resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_7, 
						{name: 'Company_Bank_Account',   index: 'Company_Bank_Account', jsonmap: 'Company_Bank_Account',sortable: false, align: 'center', width: 140, resizable: false,  unformat: unformatData }//formatter: cellFomatterPaymentsColumn_8,
						//{name: 'Comments',               index: 'Comments',            	jsonmap: 'Comments', 			sortable: false, align: 'center', width: 75,  resizable: false,  unformat: unformatData},//,   formatter:cellFomatterPayComment//formatter: cellFomatterPaymentsColumn_9,
						//{name: 'Settl_Mode',             index: 'Settl_Mode',          	jsonmap: 'Settl_Mode',  	    sortable: false, align: 'center', width: 120,  resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_7, 
						//{name: 'Signature',              index: 'Signature',           	jsonmap: 'Signature', 			sortable: false, align: 'center', width: 80, resizable: false,   unformat: unformatData},//,  formatter:checkBoxFmatterPaySignature
						//{name: 'Reject',                 index: 'Reject',   			jsonmap: 'Reject', 			    sortable: false, align: 'center', width: 50, resizable: false,   unformat: unformatData}
					], //,  formatter:checkBoxFmatterPayReject
                   mtype: 'GET',
                   rownumbers: true,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
                   toolbar: [false, 'top'],
                   caption: 'Client Payments',
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
                             
                        
                        
             					},
					
               });
           }
			
          
		
		function unformatData(cellvalue, options, cellobject) {
               return cellvalue;
        }
	
		
		 function loadGridReceipts() {
					
	           var payment_no = "<%=payment_no%>";
               jQuery('#TABLE_RECEIPT_DETAILS').GridUnload();
                   m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"group_net_payments_drilldown?chksql=group_net_payments_rec_drilldown&payment_no="+payment_no; 
					jQuery('#TABLE_RECEIPT_DETAILS').jqGrid({
                   url: m_url,
                   //loadonce: 1,
                   datatype: 'json',
                   colNames: ['Receipt No','Broker','Client Manager','Fasility Number','Client Name' ,'Receipt Amount','Value Date','Transation Date','Mode', 'Company Bank Account'], //'Comments','Approve','Reject'
                   colModel: [
						{name: 'Receipt_No',             index: 'Receipt_No',   		jsonmap: 'Receipt_No',          sortable: false, align: 'center', width: 100, resizable: false,    unformat: unformatData},//,formatter:cellFomatterReceiptNo//formatter: cellFomatterReceiptsColumn_1,
						{name: 'Broker',                 index: 'Broker',      	        jsonmap: 'Broker', 		        sortable: false, align: 'center',  width: 60, resizable: false,   unformat: unformatData},//formatter: cellFomatterReceiptsColumn_5,
						{name: 'Client_Manager',         index: 'Client_Manager',   	jsonmap: 'Client_Manager', 	    sortable: false, align: 'center', width: 100, resizable: false,   unformat: unformatData},//formatter: cellFomatterReceiptsColumn_1,
						{name: 'Fasility_Number',        index: 'Fasility_Number',  	jsonmap: 'Fasility_Number', 	sortable: false, align: 'center' , width: 100, resizable: false,  unformat: unformatData},
						{name: 'Client_Name',            index: 'Client_Name',      	jsonmap: 'Client_Name', 		sortable: false, align: 'left', width: 100, resizable: true,   unformat: unformatData},//formatter: cellFomatterReceiptsColumn_2,
						
						{name: 'Receipt_Amount',         index: 'Receipt_Amount',   	jsonmap: 'Receipt_Amount',  	sortable: false, align: 'right',  width: 100, resizable: false,  unformat: unformatData },//formatter: cellFomatterReceiptsColumn_6_0,
						{name: 'Value_Date',             index: 'Value_Date',       	jsonmap: 'Value_Date',  		sortable: false, align: 'right',  width: 100, resizable: false,   unformat: unformatData },//formatter: cellFomatterReceiptsColumn_6,
						{name: 'Tran_Date',              index: 'Tran_Date',       		jsonmap: 'Tran_Date',    		sortable: false, align: 'right',  width: 100, resizable: false,   unformat: unformatData },//formatter: cellFomatterReceiptsColumn_6,
						{name: 'Mode',                   index: 'Mode',             	jsonmap: 'Mode',  			    sortable: false, align: 'center', width: 80,  resizable: false,  unformat: unformatData },//formatter: cellFomatterReceiptsColumn_7, 
						{name: 'Company_Bank_Account',   index: 'Company_Bank_Account', jsonmap: 'Company_Bank_Account',sortable: false, align: 'center', width: 140, resizable: false,  unformat: unformatData }//formatter: cellFomatterReceiptsColumn_8,
						//{name: 'Comments',               index: 'Comments',            	jsonmap: 'Comments', 			sortable: false, align: 'center', width: 75,  resizable: false,  unformat: unformatData},//,   formatter:cellFomatterPayComment//formatter: cellFomatterReceiptsColumn_9,
						///{name: 'Approve',                index: 'Approve',           	jsonmap: 'Approve', 			sortable: false, align: 'center', width: 50, resizable: false,   unformat: unformatData,  formatter:checkBoxFmatterPayApprove},
						//{name: 'Reject',                 index: 'Reject',   			jsonmap: 'Reject', 			    sortable: false, align: 'center', width: 50, resizable: false,   unformat: unformatData,  formatter:checkBoxFmatterPayReject}
					],
                   mtype: 'GET',
                   rownumbers: true,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
                   toolbar: [false, 'top'],
                   caption: 'Client Receipts',
				   jsonReader: {repeatitems: false},
                   gridComplete: function() {
						 
                           $('#jqgh_ACTUAL_ReceiptS_COLUMN_1').css('cursor', 'default');
                           $('#jqgh_ACTUAL_ReceiptS_COLUMN_2').css('cursor', 'default');
                           $('#jqgh_ACTUAL_ReceiptS_COLUMN_5').css('cursor', 'default');
                           $('#jqgh_ACTUAL_ReceiptS_COLUMN_6_0').css('cursor', 'default');
                           $('#jqgh_ACTUAL_ReceiptS_COLUMN_6').css('cursor', 'default');
                           $('#jqgh_ACTUAL_ReceiptS_COLUMN_7').css('cursor', 'default');
                           $('#jqgh_ACTUAL_ReceiptS_COLUMN_8').css('cursor', 'default');
                           $('#jqgh_ACTUAL_ReceiptS_COLUMN_9').css('cursor', 'default');
                           $('#jqgh_ACTUAL_ReceiptS_COLUMN_9_1').css('cursor', 'default');
                           $('#jqgh_ACTUAL_ReceiptS_COLUMN_10').css('cursor', 'default');
                           $('#jqgh_ACTUAL_ReceiptS_COLUMN_11').css('cursor', 'default');
                          
                          
                        
                        
                         //  $('#DIV_NET_AVAILABILITY').text(format_noobject0($('#HID_FINAL_AVAILABILITY').val(), 2, null, 'BRACKETS'));
                           //init_fancybox();
                           //initCal('TXT_VALUE_DATE_' + '1');
                          /* if ((document.Form1.hid_receipts_count_new.value == '0') && (m_onload_add_receipt_flag == false)) {
                              // addReceiptItem();
                              // m_onload_add_receipt_flag = true;
							}*/
                           //get_exchange_rate();
						
						
					}
					
               });
           }
		
	</SCRIPT>
	
	<SCRIPT LANGUAGE=VBScript TYPE="text/vbscript">
		Function makeMsgBox(title,mess,icon,buts,defbut,mods)
			butVal = buts + (icon*16) + (defbut*256) + (mods*4096)
			makeMsgBox = MsgBox(mess,butVal,title)  
			
		End Function
		
	</SCRIPT>

		<BODY  class='body & txt-body' onload= "fn_view();loadGridReceipts();" ><!-- "fn_view();-->
		
		<FORM action="RequestObjectInJSP.jsp" NAME="Form1" ID="Form1" METHOD="POST" >
			
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="confirm_dealticket">
			<input type = "hidden" id = "hid_count" name = "hid_count" />

			<table class='table' border='0' cellpadding='0' cellspacing='0' width='100%'> 
				
				<tr>				
					
					<BR>	
					<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
						<TR>
							<TD WIDTH="1%"></TD>
							<TD WIDTH="*%"> <!-- -->
								
										<table align='center' width='100%' class='table'>
										<tr> 
										<td width="100%"  height="70%"><div id="data_div"></div></td>
										</tr> 
										</table>
								
										<DIV ALIGN="CENTER" id=insdata ></DIV>
								
							</TD> <!-- -->
								</tr>
							</table>
						</TD>
					</tr>
					
				</table>
		
		
		   <div id ="DIV_MSG_WINDOW" title ="Pending Payments">
	       <iframe id ="IFRAME_MSG_WINDOW" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Day End Routine">
	       </iframe>
	       </div>
		
		  <div id ="DIV_MSG_DEAL_TICKET" title ="Deal Ticket">
	       <iframe id ="IFRAME_MSG_DEAL_TICKET" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Deal Ticket">
	       </iframe>
	       </div>
		
		   <div id = "DIV_AVAILABILITY_DETAILS">
                     <table id = "TABLE_AVAILABILITY_DETAILS"></table>
                      <div id = "DIV_PAGER_AVAILABILITY_DETAILS"></div>

           </div>
		<BR>
		             <div id = "DIV_RECEIPT_DETAILS">
                     <table id = "TABLE_RECEIPT_DETAILS"></table>
                      <div id = "DIV_PAGER_RECEIPT_DETAILS"></div>

           </div>
		
			</FORM>
			<!-- <SCRIPT language1.2="JavaScript" src="validate.js"></SCRIPT> -->
			<SCRIPT language1.2="JavaScript" src="market_rate_sec.js"></SCRIPT>
			<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>
			<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
			
		</body>
	</html>
	
