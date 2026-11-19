<HTML>
	<HEAD>
		<TITLE>Margin Trading 
		</TITLE>
		
	</HEAD>
	<%@page import="net.sasianet.ADLMARGIN.*" %>
	
	<%	
		ADLMARGIN_MGT_conn_methods m_sn_methods1 = new ADLMARGIN_MGT_conn_methods();
		String m_html_client_url = m_sn_methods1.html_client_url;
		String m_schema_name     = m_sn_methods1.schema_name.trim();
		String m_client_name     = m_sn_methods1.client_name;
		Object done = (String)session.getValue("logon.isDone"); // marker object
		if (done == null) {
			out.println("<html><head>");
			out.println("<script language='JavaScript'>");
			out.println("function displaymsg() {");
			out.println("alert('Your login expired or invalid');");
			out.println("window.location.href='"+m_html_client_url+"/login.htm';");
			out.println("}</script></head>");
			out.println("<body onload='displaymsg();'></body>");
			out.println("</html>");
			out.flush();
			return;
		}
		
		ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
		String m_jsp_client_url=m_sn_methods.jsp_client_url;
		
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/redmond/jquery-ui.css' TYPE=\"text/css\">");
		
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
		
		
		
	%>
	<SCRIPT language="JavaScript">
		
		
		
		function select_screen(val) {
		
			document.Form1.Hid_but_type.value = val;
			if(val=="ADD"){
				document.getElementById('div_lable').innerHTML='Loan Full Settlement - New';  
				document.Form1.save_but.disabled=false; 
				//document.getElementById('div_help_rs').style.display = 'none';
				//document.getElementById('div_help_ref').style.display = 'inline';	
			}
			else if(val=="MOD"){
				document.getElementById('div_lable').innerHTML='Loan Full Settlement - Edit'; 
				document.Form1.save_but.disabled=false;
				//document.getElementById('div_help_rs').style.display = 'inline';
				//document.getElementById('div_help_ref').style.display = 'none';	
				
				
			}else if(val=="DEL"){
				document.getElementById('div_lable').innerHTML='Loan Full Settlement - Delete'; 
				document.Form1.Text_help_ref.disabled=true;
				//document.Form1.Text_help_rollover.disabled=true;
				document.Form1.save_but.disabled=false; //2011-11-15
				//document.getElementById('div_help_rs').style.display = 'inline';
				//document.getElementById('div_help_ref').style.display = 'none';	
				
			}else if(val=="INQUIRY"){
				document.getElementById('div_lable').innerHTML='Loan Full Settlement - Enquiry'; 
				//enquiry();
			}
			
		} 
		
	</SCRIPT>
	
	<BODY class='body & txt-body'  onload="">
		<FORM  NAME="Form1" ID="Form1" METHOD="POST" >			
			
			
			<DIV>
				<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
					<tr>
						<td height='7'></td>
					</tr>
					
					<tr height='30' >
						<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
						<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Margin Trading - Data Entry</B></td>
						<td width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>
						
					</tr>
					
					
				</TABLE>	
				
			</DIV>
			<!--------------------------------------------------------------->
			<table class='table' border='0' cellpadding='0' cellspacing='0' width='100%'> 
				<tr>
					<td height='1'></td>
				</tr>
				<tr>				
					
					<!-------------------------------------------------------------------->
					
					
					<TABLE WIDTH="100%" BGCOLOR="darkblue" >
						<TR >
							
							
							<TD  WIDTH="30%">	
								<INPUT TYPE="Button" NAME="mod_but" VALUE="Modify"   STYLE="{cursor:hand; color: black; font: bold 9pt arial;border-style: outset; background-color: darkgray;}" onClick="top.frames[1].location.href='dn_MF_Repofullset_Entry_Frame.html'">
								<INPUT TYPE="Button" NAME="del_but" VALUE="Delete"   STYLE="{cursor:hand; color: black; font: bold 9pt arial;border-style: outset; background-color: darkgray;}" onClick="top.frames[1].location.href='dn_DF_Repofullset_Entry_Frame.html'">
								<INPUT TYPE="Button" NAME="inqiry_but" VALUE="Inquiry"   STYLE="{cursor:hand; color: black; font: bold 9pt arial;border-style: outset; background-color: darkgray;}" onClick="top.frames[1].location.href='dn_IF_Repofullset_Entry_Frame.html'">
							</TD>
							<TD WIDTH="28%">	
								<INPUT TYPE="Button" NAME="save_but" VALUE="Save&nbsp; "   STYLE="{cursor:hand; color: black; font: bold 10pt arial;border-style: outset; background-color: darkgray;}" onClick="top.frames[1].frames[1].beforesubmit()">
								<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"  STYLE="{cursor:hand; color: black; font: bold 10pt arial;border-style: outset;background-color: darkgray; }" onClick="top.frames[1].frames[1].location.href='dn_fullsettle_frame3.html'">
								<!--<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit&nbsp&nbsp;  "  STYLE="{cursor:hand; color: black; font: bold 10pt arial;border-style: outset;background-color: darkgray; }"onClick="top.frames[0].location.href='mbindex.html'">-->
								<INPUT TYPE="Button" NAME="Exit_but" VALUE=" &nbsp;Exit&nbsp; "  STYLE="{cursor:hand; color: black; font: bold 10pt arial;border-style: outset;background-color: darkgray; }" onClick="top.frames[1].location.href='low.html'"> 
							</TD>
							<TD STYLE="{color: white ;font: bold 10pt arial;text-align:right;}" WIDTH="31%">
								<B>Repo-Settlement - New</B>
							</TD>			
							
							
							<TD WIDTH="6%">	
								<INPUT TYPE="Button" NAME="NEW" VALUE="Add"   onClick="select_screen('ADD');"  class="mainbut"  >
							</TD>
							
							<TD WIDTH="6%">	
								<INPUT TYPE="Button" NAME="MOD" VALUE="Edit"   onClick="select_screen('MOD');" class="mainbut"  >
							</TD>
							<TD WIDTH="6%">	
								<INPUT TYPE="Button" style="width:80px" NAME="INQ" VALUE="Inquiry"   onClick="select_screen('INQUIRY');"  class="mainbut"  >
							</TD>
							
							<TD WIDTH="6%">	
								<INPUT TYPE="Button" NAME="REA" style="width:80px"  VALUE="Delete"   onClick="select_screen('DELETE');"  class="mainbut"  >
							</TD>
							<TD WIDTH='6%'>&nbsp;&nbsp;&nbsp;&nbsp;</TD>		
							<TD WIDTH='6%'>&nbsp;&nbsp;&nbsp;&nbsp;</TD>	
							<!---------------------------------->
							<TD WIDTH="6%">	
								<INPUT TYPE="Button" NAME="save_but" VALUE="Save"   onClick="beforesubmit()" class="mainbut"  >
							</TD>
							
							<TD WIDTH="6%">
								<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"   onClick="clearAll()" class="mainbut"> 
							</TD>
							<TD WIDTH="6%">
								<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit"   onClick="top.frames[1].location.href='low.jsp'" class="mainbut"> 
							</TD>
							
							<TD  WIDTH="50%" class="hh1" align="right">
								<B><DIV id="div_lable">Loan Full Settlement - New</DIV> </B>
							</TD>					
						</TR>
					</TABLE>
					
					
					<!----------->
					
					<TABLE WIDTH="100%"  >
						<tr ></tr>
					</TABLE>
					<HR>
					<TABLE WIDTH="100%"  >
						<tr ></tr>
					</TABLE>
					
					<BR>
					
					
					
					
					
				</FORM>
				
				
			</BODY>
			
		</HTML>
		
