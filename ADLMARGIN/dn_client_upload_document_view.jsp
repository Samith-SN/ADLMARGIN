<%@page import="net.sasianet.ADLMARGIN.*" %>
<%@page import="java.io.*" %>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.io.File"%>
<%@page import="java.io.OutputStream"%>
<%	
	
	ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
	String m_jsp_client_url=m_sn_methods.jsp_client_url;
	String current_user=m_sn_methods.username; 
	String m_file_upload_path = m_sn_methods.file_upload_path;
	
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
	
	
	String m_client_code = request.getParameter("client_code");
	
	String m_image_path = m_file_upload_path+ m_sn_methods.company_name + "\\Client\\" + m_client_code + "\\" + m_client_code + "-C" + "." + "jpg";
	
%>
<HTML>
	<HEAD>
		<TITLE>Margin Trading</TITLE> 
		
	</HEAD>   
	<SCRIPT language="JavaScript"> 	     
		//added by inditha 8-9-2004/13:19 SRF:0409-012 CLENT BALANCE MOVEMENT
		
		
		function  exit()
		{
			//window.location.href='<%=m_jsp_client_url%>/low.jsp';
			window.close();
			
		}
		function  cancel()
		{
			window.location.href='<%=m_jsp_client_url%>/dn_client_investment_statement.jsp';
			
		}
		
		$(document).ready(function() 
			{
				//initCal('FROM_TXT_DATE');
				//initCal('TO_TXT_DATE');
				
			});
		
		function initCal(m_id) {
			$('#' + m_id).datepicker({
					dateFormat: 'dd-mm-yy',
					duration: 'fast',
					yearRange: '1920:2050',
					showOn: 'button',
					buttonImage: 'https://dev-adlmargin.sasianet.com:8443/ADLMARGIN/LBMARGIN/SNET/images/calendar.gif',
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
			var instance_id = inst.id;
			var m_last_index_of_underscore = instance_id.lastIndexOf('_');
			var first_part = instance_id.substr(0, m_last_index_of_underscore + 1);
			var second_part = instance_id.substr(m_last_index_of_underscore + 1);
			if (instance_id == "FROM_TXT_DATE") {
				document.Form1.TXT_DATE_FROM.value = splitResult[0];
				document.Form1.TXT_MONTH_FROM.value = splitResult[1];
				document.Form1.TXT_YEAR_FROM.value = splitResult[2];
				document.Form1.TXT_YEAR_FROM.focus();
			}
			if (instance_id == "TO_TXT_DATE") {
				document.Form1.TXT_DATE_TO.value = splitResult[0];
				document.Form1.TXT_MONTH_TO.value = splitResult[1];
				document.Form1.TXT_YEAR_TO.value = splitResult[2];
				document.Form1.TXT_YEAR_TO.focus();
			}
			
			
		}
		
		

		function Client_help(m_strat)
		{
			var aForm;    //  aForm =oForm.elements;
			aForm =  document.getElementById('Form1');
			
			var myObject=new Array(); //return values set to this object
			myObject[0]=aForm.TXT_CLIENT; //2011-09-27
			//myObject[1]=aForm.Text_loc_desc;;
			myObject[1]=null;
			myObject[2]=null;
			myObject[3]=null;
			myObject[4]=null;
			
			var myObject_value=new Array(); //passing values set to this object
			//myObject_value[0]=aForm.TXT_UNAME.value; //2011-09-27
			myObject_value[0]=aForm.TXT_CLIENT.value; //2011-09-27
			myObject_value[1]=aForm.TXT_CLIENT.value; //aForm.Text_loc_code.value;
			myObject_value[2]=aForm.TXT_CLIENT.value; 
			myObject_value[3]=null; 
			
			myObject_value[4]=null;
			
			
			var myObject_type=new Array(); //passing values data type
			//myObject_type[0]="StringL";
			myObject_type[0]="StringL";
			//myObject_type[1]="StringL";
			myObject_type[1]="StringL";
			myObject_type[2]="StringL";
			myObject_type[3]=null;
			myObject_type[4]=null;
			
			
			var qid=101;
			
			//help_scr_type=document.Form1.SCR_TYPE;//2011-09-27
			
			
			title_name='Location';
			var url = 'popup.jsp';
			var close_fun='port_help_close';			
			var json_text = JSON.stringify(myObject_value, null,0);
			var json_obj_type_text=JSON.stringify(myObject_type, null,0);
			var fn_name=arguments.callee.name;
			if(fn_name==undefined)
			{
				re = /^function\s+([^(]+)/;
				fn_name=re.exec(arguments.callee.toString())[1];
			}
			
			$.showModalDialog({
					url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
					dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
					height:400,// 500,
					width: 500,//900,
					title: 'SasiNet Frame Work',
					scrollable: true,
					onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); 
						if(returnedValue != null){
							//
							//aForm.TXT_UNAME.focus();
						}
						if(returnedValue == null){
							port_help_close(0);
						} 
					} //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
		}
		
		function port_help_close()
		{
			document.Form1.TXT_CLIENT.value="";
			
		}
		
		
		
		
		
	</SCRIPT>
	<BODY class='body & txt-body'>
		<FORM NAME="Form1" ID="Form1" METHOD="POST" >
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="">
			<INPUT TYPE="Hidden" NAME="hid_help_type" ALIGN="RIGHT" SIZE=2 >	
			<TABLE WidTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0" STYLE="{color: black; font: bold 9pt arial;}">							
				<TD WidTH="1%">
					<TD WidTH="99%">
						
						
						<table width="100%">
							<tr>
								<td>
									<table class='table' align='center' width="100%" border="0" cellpadding="0" cellspacing="0" >
										<!-- <table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 	-->
										<tr>
											<td height='7'></td>
										</tr>
										<tr height="30">		
											<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
											<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Client Upload Document</B></td>
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
									
						<TABLE border=0 >	
										
						 <TR height="200px" >
						 <TD WIDTH='20%'>Picture</TD>			
						 <TD WIDTH='20%' CLASS='DIV_INPUT' ALIGN='CENTER'><img height ="100%" width ="100%"  src="<%=m_jsp_client_url+"//dn_client_upload_photo_view.jsp?client_code="+m_client_code%>&photo_type=P" />
						 </TD>
						 <TD WIDTH='*'></TD>						
						 </TR>	
										
						 <TR height="200px" >
						 <TD WIDTH='20%'>Map</TD>			
						 <TD WIDTH='20%' CLASS='DIV_INPUT' ALIGN='CENTER'><img height ="100%" width ="100%"  src="<%=m_jsp_client_url+"//dn_client_upload_photo_view.jsp?client_code="+m_client_code%>&photo_type=M" />
						 </TD>
						 <TD WIDTH='*'></TD>						
						 </TR>
										
						 <TR height="200px" >
						 <TD WIDTH='20%'>CRIB File</TD>
						 <TD WIDTH='20%'><a href="<%=m_jsp_client_url+"//dn_client_upload_photo_view.jsp?client_code="+m_client_code%>&photo_type=C">CRIB File</a></TD>						
						 </TR>					
						</TABLE>			

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
		<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
</DIV>
		</html>
		
