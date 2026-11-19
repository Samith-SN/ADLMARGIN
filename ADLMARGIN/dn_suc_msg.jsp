<%@page import="net.sasianet.ADLMARGIN.*" %>
<%	
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
<HTML>
	<HEAD>
		<TITLE></TITLE>	
		
		<!--<LINK REL="stylesheet" TYPE="text/css" HREF="navbar.css /"> -->


	</HEAD>		

<SCRIPT language="JavaScript1.2">

function displaymsg() {
  alert('Day End Routine completed successfully.');
	
	window.location.href="<%= m_jsp_client_url%>/Daily_Routine.jsp";		
	 // window.location.href=html_client_url+"/Daily_Routine.html";
}
		
</SCRIPT>
	 <BODY ONLOAD="displaymsg();"> 
			<FORM NAME="Form1">

		</FORM>
		<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>
 </body>
</html>
