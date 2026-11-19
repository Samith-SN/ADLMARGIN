        <%@page import="net.sasianet.ADLMARGIN.*" %>
<%
            ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
            String m_jsp_client_url = m_sn_methods.jsp_client_url;
	//***************  ADDED BY KANISHKA ON 26/12/2012  *********************//
	
		Object done = (String)session.getValue("logon.isDone");  // marker object
		if (done == null) {
			response.sendRedirect("login.jsp");
			return;
			}
	
	//*************** ADDED BY KANISHKA ON 26/12/2012 [END]  *********************//
%>
<html>
    <head>
	<title>Margin Trading</title>	

		
	    <script type="text/javascript">
			
			
	</script>
 	
 </head>
    
    <body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
        <form name="Form1" id="Form1" >
			
		<img src="<%= m_jsp_client_url %>/images/shutdown-dialog.jpg" alt="logoff" width="318px" height="204px" 	border="0" hspace="0" 	vspace="0"/> 				
						
        </form>		
			
 </body>		
</html>
				