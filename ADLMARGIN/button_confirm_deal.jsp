<html>
	<head>

<!-- header - edit "Data/yourHtmlHeader" to customize -->
	<!-- contents - edit "EventHandlers/Html file/onCreate" to customize -->
	<meta name="generator" content="ModelWorks IDE">
	
	<title>Margin Trading </title>
	<%@page import="net.sasianet.ADLMARGIN.*" %>
		<%	
		/*
		LBMARGIN_MGT_conn_methods1 m_sn_methods = new LBMARGIN_MGT_conn_methods1();
		String m_jsp_client_url=m_sn_methods.jsp_client_url;
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
		*/
		
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
			
	%>
		
	</head>
<SCRIPT>
 function display(){
		cname="<b>Generate Confirmation ";
		change="- Deal</b>";
		cname2=cname+ change;	
	  m_cutid.innerHTML=cname2;
 }
	
 function beforesave(){
		/*
		if(document.Form2.inv_but.value =="Brokerage" ){
			parent.frames[1].beforesubmit();  
		}
		else{
			parent.frames[1].beforesubmit2();
		}
		*/
		
		parent.frames[1].beforesubmit(); 
	}
	
	function val_mode(){
		if(document.Form2.inv_but.value =="Brokerage" ){
			top.frames[1].frames[1].location.href='dn_brokerage_fees_inv.html';
		}
		else{
			cname="";
			change="";
			top.frames[1].frames[1].location.href='mbfsl_confirm_dealticket.html';
			document.Form2.inv_but.value = "Brokerage";
			cname="Generate Confirmation ";
			change="- Deal";
			cname2=cname+ change;	
	 	 m_cutid.innerHTML=cname2;
		}
	}
	
	function callDEAL(){
	popupwin = window.open("dealTiket.jsp","displayWindow8","width=600, height=250,scrollbars=yes, menubar=no, resizable=yes");
		//top.frames[1].frames[1].location.href='dealTiket.jsp';
	}
	
	function calldetails(){
	popupwin = window.open("details_Agr.html","displayWindow8","width=600, height=250,scrollbars=yes, menubar=no, resizable=yes");
	}
	
	//aaaaa
	//Added by susitha 23-05-2011
	function beforesave_reject(){
		
			parent.frames[1].beforesubmit_reject();  
		
	}
	
</SCRIPT>
 
<body onload="display()"  class='body & txt-body' >
	 		<FORM NAME="Form2">	
			<INPUT TYPE="Hidden" NAME="Hid_Screen_type" VALUE="C">
				<TABLE WIDTH="100%"  >
				<TR >
					<!--<TD WIDTH="20%"><INPUT TYPE="Button" NAME="inv_but" VALUE="Brokerage"   STYLE="{cursor:hand; color: black; font: bold 10pt arial;border-style: outset; background-color: darkgray;}" onClick="val_mode()">
					</TD>-->	
					<!--<TD WIDTH="10%"><INPUT TYPE="Button" NAME="save_but2" VALUE="Save&nbsp; "   STYLE="{cursor:hand; color: black; font: bold 10pt arial;border-style: outset; background-color: darkgray;}"  onClick="parent.frames[1].beforesubmit()"></TD>-->
 				  <TD  WIDTH="6%">	
			 	  <INPUT TYPE="Button" NAME="save_but" VALUE="&nbsp;Save&nbsp; "          class = "mainbut"  onClick="document.Form2.save_but.disabled=true;beforesave()">
					</TD> <TD  WIDTH="6%">		
						<INPUT TYPE="Button" NAME="reject_but" VALUE="&nbsp;Reject&nbsp; "   class = "mainbut"  onClick="document.Form2.save_but.disabled=false;beforesave_reject()"> <!--Added by susitha 23-05-2011 -->
					</TD> <TD  WIDTH="6%">		
						<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"                class = "mainbut"  onclick="document.Form2.save_but.disabled=false;top.frames[1].frames[1].location.href='mbfsl_confirm_dealticket.jsp';">
					</TD> <TD  WIDTH="6%">		
						<INPUT TYPE="Button" NAME="Exit_but" VALUE=" &nbsp;Exit&nbsp; "      class = "mainbut"  onClick="top.frames[1].location.href='low.html'" > 
					</TD> <TD  WIDTH="6%">		
						<INPUT TYPE="Button" NAME="dealTkt" VALUE="Deal Ticket"              class = "mainbut"  onClick="callDEAL()">
					<!--INPUT TYPE="Button" NAME="dealTkt1" VALUE="Deal Details"  STYLE="{cursor:hand; color: black; font: bold 10pt arial;border-style: outset;background-color: darkgray; }"  onClick="calldetails()"-->
				</TD>
				<TD  WIDTH="*%">&nbsp;</TD>
		        <TD  WIDTH="25%" class="hh1">
			    <DIV id=m_cutid ></DIV></TD>
									
	</TR>
	</TABLE>
				
			
			    <TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
			<HR>
				<TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
</FORM>
	</body>
<DIV><script language="JavaScript1.2" src="validate.js"></SCRIPT></DIV>
</html>

