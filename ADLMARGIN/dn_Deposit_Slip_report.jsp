<%@page import="net.sasianet.ADLMARGIN.*" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Calendar" %>
<%@page import="java.util.Date" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.*" %>

<%	
	
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
	String m_jsp_client_url=m_sn_methods.jsp_client_url;
	String current_user=m_sn_methods.username; 
	String m_scr_name,mm_entry_type,m_pay_no,m_facility_No,m_PF_NAME,m_Receipt_Type,m_Description,m_Bank,m_Branch_Code,m_cheque_No,m_Amount;
	
	out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
	out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/redmond/jquery-ui.css' TYPE=\"text/css\">");
	
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/i18n/grid.locale-en.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/jquery.jqGrid.min.js\"></script>");
	out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\""+m_jsp_client_url+"/css/ui.jqgrid.css\" />");
	
	
	int m_main_maxentries =(Integer.parseInt((String)request.getParameter("hid_count")));
	
	
		ResultSet rs_rpt_date = stmt.executeQuery ("SELECT TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS') FROM DUAL");
				String rpt_run_date="";
				boolean more_rpt_date=rs_rpt_date.next();
				if(more_rpt_date){
				  rpt_run_date = rs_rpt_date.getString(1);
				}
%>

<!==========================================================================================================================================-->			
	<!--------------------------------Done by Manjula on 08-09-2004 For Srock Movement Statement----SRF 0409-012 --------------------------------->
	<!==========================================================================================================================================-->
		
		<HTML>
			<HEAD>
				<TITLE>Deal Net</TITLE>
				
			</HEAD>   
			<SCRIPT language="JavaScript"> 	     
				var m_sql = "";
				var m_criteria="";
				
				
				
				function chkstartdate(dayobj,monthobj,yearobj) {
					checkMonthLength(dayobj,monthobj,yearobj);		
				}

				//--------------------------------------------------------PORTFOLIO HELP----------------------------------
				
				function  exit()
				{// document.Form1.target="parent";	
				//window.location.href='<%=m_jsp_client_url%>/dn_Deposit_Slip.jsp';
				window.close();
				}
				function  cancel()
				{
					window.location.href='<%=m_jsp_client_url%>/dn_Deposit_Slip_report.jsp';
					
				}
				
				$(document).ready(function() 
					{
						initCal('FROM_TXT_DATE');
						initCal('TO_TXT_DATE');
						
					});
				
				function initCal(m_id) {
					$('#' + m_id).datepicker({
							dateFormat: 'dd-mm-yy',
							duration: 'fast',
							yearRange: '1920:2050',
							showOn: 'button',
							buttonImage: 'https://dev-adlmargin.sasianet.com:8443/ADLMARGIN/adlmargin/SNET/images/calendar.gif',
							buttonImageOnly: true,
							changeMonth: true,
							changeYear: true,
							onSelect: function(dateText, inst) {
								dateSelectFunc(dateText,inst);
							}
						});
				}
				

				function port_help_close()
				{
					document.Form1.TXT_CLIENT.value="";
					
				}
				
			
				
				function print_data(){
		
	
				//	$('#DIV_PRINT').empty();
                    window.print();
			
           }
			
				
			</SCRIPT>
			<BODY class='body & txt-body' >
				<FORM NAME="Form1" id="Form1" METHOD="POST" >
					
					<INPUT TYPE="Hidden" NAME="hidden_help_value" ALIGN="RIGHT" SIZE=2 >	
					<TABLE WidTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0" STYLE="{color: black; font: bold 9pt arial;}">							
						<TD WidTH="1%">
							<TD WidTH="99%">
								<table width="100%">
									<tr>
										<td>
									<!--		<table class='table' align='center' width="100%" border="0" cellpadding="0" cellspacing="0" >
												<tr>
													<td height='7'></td>
												</tr>
												<tr height="30">		
													<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
													<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Receipts Management - Deposit Slip-Report</B></td>
													<td width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>
												</tr>
											</table>-->
										</td>			
									</tr>
									<tr>
										<td>	
											 <table class='table' align='left' border="0" cellpadding="2" cellspacing="0" >
												<tr>
															
														<td>
														  <input class = "ui-state-default ui-corner-all" type = "button" id = "BUT_PRINT" name = "BUT_PRINT" value = "Print" onclick = "print_data();" />
														</td>		
														<td >
														 <input class = "ui-state-default ui-corner-all" type = "button"  value = "Exit" onclick = "exit();" />
														</td>
															
												</tr>	
											</table>	
											
										</td>
									
									<table>
											<hr>
									</table>

										<table class='table' align='center' width="100%" border="0" cellpadding="0" cellspacing="0" >
												<tr>
												
												<TD STYLE='{text-align:center;}'><B><FONT COLOR='black'>No. 275/75,</TD></TR></B></FONT>
												
												<tr >	
												<TD STYLE='{text-align:center;}'><B><FONT COLOR='black'>Prof. Stanley Wijesundara Mawatha,</TD></TR></B></FONT>
												
												</tr>
												<tr >		
												<TD STYLE='{text-align:center;}'><B><FONT COLOR='black'>Colombo 07.</TD></TR></B></FONT>
													
												</tr>
												<tr >		
												<TD STYLE='{text-align:center;}'><B><FONT COLOR='black'>Deposit Slip:<%=rpt_run_date%></TD></TR></B></FONT>
													
												</tr>
												
									
											</table>
									
									
			<TABLE  WIDTH='100%' id=\"myTable_del\" BORDER='1' WIDTH='80%'  class=\"full\"  >
				<THEAD> 			
				<TR BGCOLOR='silver' >
				<TH WIDTH='100'><B>Payment No</TH>
				<TH WIDTH='80'>facility No</TH>
				<TH WIDTH='100'>PF Name  </TH>							
				<TH WIDTH='90'>Receipt Type </TH>
				<TH WIDTH='150'>Description </TH>
				<TH WIDTH='100'>Bank </TH>
				<TH WIDTH='80'>Branch Code</TH>
				<TH WIDTH='100'>chequeNo</TH>
				<TH WIDTH='100'>Amount</TH></B></TR>
				</THEAD>
			
				<TBODY>
				<% for (int i=1;i< m_main_maxentries; i++){%>
				<% String flag = (String)request.getParameter("approve_"+i);%>					
				<%	if(flag!=null && flag.equals("on")){ %>
		        <TR BGCOLOR='white'>
				<TD WIDTH='100'><%=request.getParameter("PAYMENTNO"+i)%></TD>
				<TD WIDTH='80'><%=(String)request.getParameter("facilityNo"+i) %></TD>
				<TD WIDTH='100'><%=(String)request.getParameter("PFNAME"+i) %></TD>
				<TD WIDTH='90'><%=(String)request.getParameter("ReceiptType"+i) %></TD>
				<TD WIDTH='150'><%=(String)request.getParameter("Description"+i) %></TD>
				<TD WIDTH='100'><%=(String)request.getParameter("Bank"+i)%></TD>
				<TD WIDTH='80'><%=(String)request.getParameter("BranchCode"+i) %></TD>
				<TD WIDTH='100'><%=(String)request.getParameter("chequeNo"+i) %></TD>
				<TD STYLE='{text-align:right;}' ><%=(String)request.getParameter("Amount"+i)%></TD>			 						
	             </TR>
					<% }%>
					<% }%>
							
				</TBODY>											
								</table>	
							</TD>
						</TD>
					</TABLE> 
				</FORM>
			</BODY>
			<DIV>
				<SCRIPT language1.2="JavaScript" src="validate_v1.js"></SCRIPT>
			</DIV>
		</html>
		
