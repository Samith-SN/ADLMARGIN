<%@page import="net.sasianet.ADLMARGIN.*" %>
<%	
	
	ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
	String m_jsp_client_url=m_sn_methods.jsp_client_url;
	String current_user=m_sn_methods.username; 
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
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/i18n/grid.locale-en.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/jquery.jqGrid.min.js\"></script>");
	out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\""+m_jsp_client_url+"/css/ui.jqgrid.css\" />");
	
	
	
%>

<HTML>
	<HEAD>
		<TITLE>MFactor</TITLE>
		
	</HEAD>   
	<SCRIPT language="JavaScript"> 	     
		var m_sql = "";
		var m_criteria="";
		var m_curr_help="";
		var m_valid=true;
		
		function myDialogObj() {
			var htmlstr; 
			var returnval;
		}
		
		
		function chkstartdate(dayobj,monthobj,yearobj) {
			checkMonthLength(dayobj,monthobj,yearobj);		
		}
		
		
		function displaydata(){  
			//CURRENCY
			/*sclient  = new String(document.Form1.TXT_CLIENT.value);	
			
			if ((sclient.length == 0)||(sclient == " ")){
				sclient="ALL";
			}*/
			
			//if(((document.Form1.TXT_DATE_FROM.value)&&(document.Form1.TXT_MONTH_FROM.value)&&(document.Form1.TXT_YEAR_FROM.value))!=""){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"cus_available_limits_rep_MT_email?chksql=Customer_outstanding";
			//alert(m_url);
			popupwin2 = window.open(m_url,'displayWindow2','left=0,top=133,width=799,height=380,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
			popupwin2.focus();
			/*
			}
			else{
			alert("Please Enter the Date");
			}
			*/
			
			
			
		} 
		
		
		

		
		
		
		
		function displaycrdata(){  
			sclient  = new String(document.Form1.TXT_CRCLIENT.value);	
			if ((sclient.length == 0)||(sclient == " ")){
				sclient="ALL";
			}
			//	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"cus_outstanding_rep_MT?client="+sclient.toUpperCase()+"&chksql=Customer_outstanding";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"cus_outstanding_rep_MT?client="+sclient.toUpperCase()+"&chksql=CRCustomer_outstanding";
			//	alert(m_url);
			popupwin2 = window.open(m_url,'displayWindow2','left=0,top=133,width=799,height=380,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
			popupwin2.focus();
		} 
		
		
		<!--END MODIFICATIONS DONE ON 24-05-2005 FOR SR 0506-047-->		        
		
		
		
		<!--ADDED BY AH ON 06/10/2005 FOR SR0510-017------------------>	
		function displaydbdata()
		{
			//ChkDateValidation(document.Form1.TXT_DATE_FROM,document.Form1.TXT_MONTH_FROM,document.Form1.TXT_YEAR_FROM)
			//if(document.Form1.TXT_DATE_FROM.value!="" || document.Form1.TXT_MONTH_FROM.value!="" || document.Form1.TXT_YEAR_FROM.value!="") {
			
			//m_date=document.Form1.TXT_DATE_FROM.value+"-"+document.Form1.TXT_MONTH_FROM.value+"-"+document.Form1.TXT_YEAR_FROM.value;
			sclient  = new String(document.Form1.TXT_CRCLIENT.value);	
			if ((sclient.length == 0)||(sclient == " ")){
				sclient="ALL";
			}
			//	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"cus_outstanding_rep_MT?client="+sclient.toUpperCase()+"&chksql=Customer_outstanding";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_db?client="+sclient.toUpperCase()+"&chksql=mrep_data2";
			//alert(m_url);
			popupwin2 = window.open(m_url,'displayWindow2','left=0,top=133,width=799,height=380,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
			popupwin2.focus();
			//}		
			
		}
		
		
		function getcurrency()
		{
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_reports_TransactionLst?chksql=getcurr";
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
			vec_pos=0;
			while(m_size>vec_pos)
			{
				document.Form1.SEL_CURRENCY.options[document.Form1.SEL_CURRENCY.length]=new Option(top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1),top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos));
				vec_pos+=2;
			}
			
		}
		
		
		
		
			
					
		function  exit()
		{
			window.location.href='<%=m_jsp_client_url%>/low.jsp';
			
		}
		function  cancel()
		{
			window.location.href='<%=m_jsp_client_url%>/dn_customer_available_limits_mt_email.jsp';
			
		}		
			
			
		/*onload="getcurrency()"*/
	</SCRIPT>
	<BODY>
		<FORM NAME="Form1" METHOD="POST" >
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="reveryfication">
			<INPUT TYPE="Hidden" NAME="hid_help_type" ALIGN="RIGHT" SIZE=2 >	
			<TABLE WidTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0" STYLE="{color: black; font: bold 9pt arial;}">							
				<TD WidTH="1%">
					<TD WidTH="99%">
						<table width="100%">
							<tr>
								<td>		
									<table class='table' align='left' width="99%" border="0" cellpadding="0" cellspacing="0" >
										<!-- <table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 	-->
										<tr>
											<td height='7'></td>
										</tr>
										<tr height="30">		
											<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
											<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Management Information - Availbale Limits Bulk </B></td>
											<td width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>
										</tr>
									</table>
								</td>
							</tr>
							
							<tr>
								<td>	
									<table class='table' align='center' width="99%" border="0" cellpadding="2" cellspacing="0" >
										<tr>
											<td width="40%">
											</td>	
											
											<td width="6%">
												<input type="button" value="Cancel" onclick="cancel()" class="mainbut">
											</td>	
											
											<td width="6%">
												<input type="button" value="Exit" onclick="exit()" class="mainbut">
											</td>
											<td width="*%">
												
											</td>	
											
										</tr>	
										
									</table>
								</td>	
							</tr>
							<tr>
								<td>
									<hr>
									
									
								</td>	
							</tr>
							
							<tr>
								<td>
									<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" >
									
										<TR>
											<TD WIDTH="10%" align="absmiddle">
												<input type="button" class="mainbut" value="Go" style="width:100px" ONCLICK="displaydata()" >
												
											</TD>        
											<TD WIDTH="10%">
											</TD> 
											<TD WIDTH="10%">
											</TD>	
											<TD WIDTH="10%"> 
											</TD>
											<TD WIDTH="15%">
												
											</TD> 
										</TR> 
									</TABLE>
								</td>
							</tr>
							
							<tr>
								<td>
									<TABLE width="100%" BORDER="0" CELLPADDING="2" CELLSPACING="1" >
									</TABLE>
									<INPUT TYPE="Hidden" NAME="Hid_rows" >
									<DIV id=clientmgr></DIV>
								</td>
							</tr>
							
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

