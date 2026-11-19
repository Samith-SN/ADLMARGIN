<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.*" %>
<%@page import="javax.servlet.*" %>
<%@page import="javax.servlet.http.*" %>
<%@page import="oracle.jdbc.driver.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="net.sasianet.ADLMARGIN.*" %>

<html>
	<head>
		<title>Web Accounting</title>
		
		<%	
			
					
			//***************  ADDED BY KANISHKA ON 18/12/2012  *********************//
			/*session     = request.getSession(true);
			Object done = (String)session.getValue("logon.isDone");  // marker object
			if (done == null) {
				response.sendRedirect("login.jsp");
				return;
			}*/
			

	        //net.sasianet.ADLMARGIN.CDBMGT_user_rights oUserRight = new net.sasianet.ADLMARGIN.CDBMGT_user_rights();
			 
			ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
			String m_jsp_client_url=m_sn_methods.jsp_client_url;
	       /* Connection connection;
			connection = m_sn_methods.met_user_validate(session); 
			String m_schema_name    = m_sn_methods.schema_name.trim();
			String m_user_name=m_sn_methods.username;
		
		   	Statement statement=null;
		    ResultSet resultSet=null;
		    String sql=null;
			int m_exp_due = 0;	
			
			sql = " SELECT  FLOOR(EXPIRE_DURATION -(TO_DATE(TO_CHAR(SYSDATE,'DD-MON-YYYY'),'DD-MON-YYYY')-A.ENT_DATE)) EXP_DUE "+
                  " FROM    "+m_schema_name+".DN_REF_PASSWORD_UPDATE A , "+m_schema_name+".DN_REF_PASSWORD_EXPIRE_DUR B "+
                  " WHERE   DN_USER = '"+m_user_name+"' "+
		          " ";
	
				statement = connection.createStatement();
				resultSet = statement.executeQuery(sql);
				while (resultSet.next()) {
					m_exp_due = resultSet.getInt("EXP_DUE");
				}
				resultSet.close();
				statement.close();
			*/
			//*************** ADDED BY KANISHKA ON 18/12/2012 [END]  *********************//
			
			out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
			out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/redmond/jquery-ui.css' TYPE=\"text/css\">");
			
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/pop_window.js\"></script>");
			
			
			
		%>
		<SCRIPT LANGUAGE="JavaScript" SRC="validate.js"></SCRIPT> 
		<SCRIPT language="JavaScript">
			
			
			
			function get_user(){
				
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"login_name?chksql=cf_opt";	
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;  
				m_user = data_vec[0];
				
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"login_name?chksql=get_margin_sys_date";
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;  
				var m_mgt_sys_date = data_vec[0];
				
				m_writedata='<DIV ALIGN = right ><TABLE WIDTH = 100% BORDER = 0 class="table_grid" ><TR ><TH WIDTH = 20%  >&nbsp;</TH><TH WIDTH = 20% ><DIV id="date_time"></DIV></TH><TH WIDTH = 20% >System Date : '+m_mgt_sys_date+'</TH><TH WIDTH = 15% align="right"> User : '+m_user+' </TH><TH align="right" WIDTH = 6%  > <input type="button" Value="Logoff" class="mainbut" onClick="logoff_window();"> </TH></TR></TABLE></DIV>'
				document.getElementById("selected_inventory").innerHTML = m_writedata;
				
				/*var user_status  = chk_login_lock();
				
				if(user_status == "Y"){
				 chk_login_exp();
				}else if (user_status == "L"){
				 alert('Your login account has locked.');
				}else{
				 alert('your login account has not activated.');
				}
				*/
				
			}
			
			function logout(){
				
				window.location.href=servlet_client_url+":"+client_t3_port+"/"+client_name+"LoginHandler?screen_name=AF_LOGIN&logout=invalidate";//groupby="+m_group
			}
			
			function chk_login_exp(){
				
			    m_url = servlet_client_url+":"+client_t3_port+"/"+client_name+"login_name?chksql=chk_login_exp";	
			    load_interface(m_url,'XML',false);
				m_size = data_vec.length;
				var m_due_exp_date =  new Number(data_vec[0]);
				var m_reminder_days = new Number(data_vec[1]);
				//alert("m_due_exp_date"+m_due_exp_date+"m_reminder_days"+m_reminder_days);
				if(m_due_exp_date<=0){
				 alert('Your loggin has expired..! ');
				}else if( m_due_exp_date <= m_reminder_days){
				 alert('Please update your password. Your login will expire after '+m_due_exp_date+' days. ');
			 	 window.location.href=servlet_client_url+":"+client_t3_port+"/"+client_name+"MGT_login?screen_name=WD_USER_PASSWORD";		
				}else{
			    	//alert('Your password has update '+m_due_exp_date+' days ago.');
				
				}
								
			}
			
			function chk_login_lock(){
			
			    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"login_name?chksql=chk_login_lock";	
				//window.open(m_url);
			    load_interface(m_url,'XML',false);
				m_size = data_vec.length;
				var m_user_status =  new String(data_vec[0]);
				
				
				return m_user_status;
				
				
				
			}
			
			function logoff_window()
			{
				
				logout();
				
			}
			
			
			
			function set_Time(){
				var aa = setTimeout("get_user()", 1000);

			}
			
			
			
			
		</SCRIPT>
		<style type="text/css">
			<!--
			body {
				background-image: url(low_back.jpg);
			}
			-->
				
		</style>		
		
		<style type="text/css" >
			
			
			<style type="text/css" >;
			.header 
			{
				position:absolute;
				top:0;
				width:95%;
				height:20px;
				//background:#6cf;
			}
		</style>
		
	</head>
	<BODY   ONLOAD = "set_Time();" >
		<DIV id=selected_inventory>
		</DIV>
		
		<TABLE>
			<TR><TD ><DIV id='myDiv'></DIV></TD></TR></TABLE>
		<br>&nbsp;
		<br>&nbsp;
		<br>&nbsp;
		<br>&nbsp;
		<br>&nbsp;
		<br>&nbsp;
		<br>&nbsp;
		<br>&nbsp;
		<br>&nbsp;
		<center>
		</center><br>
		<center></center>
		<center></center>
		<center></center>
		<br>&nbsp;
		<br>&nbsp;
		<br>&nbsp;
		
		<!-- <applet code=mf_datagateway.class width=0 height=0></applet> -->
		<SCRIPT LANGUAGE="JavaScript" SRC="validate.js"></SCRIPT>
		<!--<SCRIPT LANGUAGE="JavaScript" SRC="ajax_data_gateway_light.js"></SCRIPT>-->
		<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
	</body>
</html>

<%

	try{
	    /*
		if(connection!=null){
		connection.close();
		}
		*/
		
	}catch(Exception e ){
	
	}
%>
