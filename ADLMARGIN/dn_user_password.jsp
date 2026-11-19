<%@page import="net.sasianet.ADLMARGIN.*" %>
<HTML>
	<HEAD>
		<TITLE>Margin Trading</TITLE>
		
 	
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
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/redmond/jquery-ui.css' TYPE=\"text/css\">");
			
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
        out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
		
		
			
	    %>
	
	<SCRIPT language="JavaScript1.2">
   var p_status=false;
   var sp_status=false; 
 	var outvec_value = null;
  function get_user() {	
		   /* m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?chksql=idle";
		   
		    top.frames[0].document.applets[0].getdata(m_url);
	        m_size= top.frames[0].document.applets[0].outvec_value.size();
			if (m_size>0) {
		       document.Form1.Text_user_id.value= top.frames[0].document.applets[0].outvec_value.elementAt(0);
				}
		   */
		   
  	}
  	function check_passwordrules(object) {
 			if(object.value!="")  {	
				 m_format=object.value;
	 	     if (m_format.length<6 || m_format.length>10) {
		 		     alert('The length of the password should be between 6 and 10 characters');
				     //parent.frames[1].location.href='user_password.html';
  					 
							document.Form1.Text_new_pword.focus();
						p_status=true;
				 }
	 		   else {
				   	for (var i = 0; i < m_format.length; i++) {
		  				  var oneChar = m_format.charAt(i)
						    if (oneChar==" "){
											sp_status=true; 
								 }
 							}
						 	if(sp_status) {
								 	alert('You can not have spaces in the password');
								  //document.Form1.Text_new_pword.focus();
						      parent.frames[1].location.href='user_password.html';  
                   p_status=true;
							}											
  		   }
	      }
				else {
				    	if (confirm("!Please enter the New Password and if you want to Contiue,Press OK  or Press Cancel to Exit")) {
			           parent.frames[1].location.href='user_password.html';	
			        }
		        	else{
	             parent.frames[1].location.href='low.html';  
						 }
     } 
	 	}
			function chk_user(np_obj)  {
				/*	m_obj=Form1.Text_user_id.value;
					if(np_obj.value==m_obj) {
					  alert('You can not enter the User_ID as the password');
						document.Form1.Text_new_pword.focus();
            p_status=true;					
					}
					else {
				  	check_passwordrules(np_obj);
   			    p_status=false;
					   	//ADDED BY SARANGA TO CHECK PASSWORD
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?chksql=m_password";
						 top.frames[0].document.applets[0].getdata(m_url);
				    m_size= top.frames[0].document.applets[0].outvec_value.size();
  					 if (m_size>0) {
					       m_password= top.frames[0].document.applets[0].outvec_value.elementAt(0);
			  		 }
						 
						if(np_obj.value.toUpperCase()==m_password.toUpperCase()) {
					  alert('You can not enter the same password as the password');
						document.Form1.Text_new_pword.value="";
						document.Form1.Text_new_pword.focus();
            p_status=true;					
					  }else{
						 document.Form1.save_but.disabled=false;		
						
						}		
					 //document.Form1.save_but.disabled=false;		
					}*/
			}		

   function chk_password(n_obj,re_obj)  {
		
		  if(!p_status)  {
					if(re_obj.value!="") {	
						if (n_obj.value!=re_obj.value)  {
					         if(confirm("Retyped password is not equal to the New Password,if you want to want to continue click on O.K or to exit click on Cancel")) {
										 
									      document.Form1.save_but.disabled=true;	
									      document.Form1.Text_retype_pword.value="";
									      document.Form1.Text_retype_pword.focus();
							     }
							      else {
											parent.frames[1].location.href='low.jsp';   
                   	}
						}else{
						//enable save
						document.Form1.save_but.disabled=false;	
						}
		 		}		
	    }
	}	

  function disable_save() {
		document.getElementById('div_lable').innerHTML='User Password'; //added by Prabash on 24-11-2011	
		  document.Form1.save_but.disabled=true;
		}	
		
	function beforesubmit(){
	
	 if(document.Form1.Text_retype_pword.value=="") {
		  alert('Please retype your new password');
			document.Form1.Text_retype_pword.focus();
	 }
	else {
			document.Form1.Text_user_id.disabled=false;
		    Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"user_password";//bsavedeal
	  	    Form1.submit();		

	}
}	
		
		
		// password plicy check
		function password_policy_check()
		{
		
                   var new_password_valid_status = null;
                   var alert_string = null;
			      // window.open(servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=isNewPasswordValid&username="+$('#Text_user_id').val() +"&new_password=" + $('#Text_new_pword').val());
                   
					if ($('#Text_new_pword').val() != '') {
                       //alert('ccc');
						$.ajax({
                           type: 'GET',
                           //url: 'https://dev-adlmargin.sasianet.com:8443/ADLMARGIN/servlet/LBMARGIN2_dnvalsavuser?chksql=isNewPasswordValid&username=' + $('#TXT_USER_ID').val() + '&new_password=' + $('#Text_new_pwordWORD').val(),
                           url:servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=isNewPasswordValid&username="+$('#Text_user_id').val() +"&new_password=" + $('#Text_new_pword').val(),
                           success: function(xml) {
                               $(xml).find('password_status').each(function() {
                                   new_password_valid_status = $(this).find('new_password_valid_status').text();
                                   alert_string = $(this).find('alert_string').text();
                                   if (new_password_valid_status == 'NO') {
                                       alert(alert_string);
                                       $('#Text_new_pword').val('');
                                       $('#Text_new_pword').val('');
                                       setTimeout('$(\'#Text_new_pword\').focus()', 1);
                                   }
                                   else if (new_password_valid_status == 'YES') {
                                       $('#Text_retype_pword').attr('disabled', false);
                                       setTimeout('$(\'#Text_retype_pword\').focus()', 100);
                                   }
                               });
                           }
                       });
						
					   
						
                   }
                   else {
					
                       $('#Text_retype_pword').val('');
                       $('#Text_retype_pword').attr('disabled', true);
                   }
				
             
		}
		
		function display_sec_opt(val){
		
			if(val=="mod"){
				
			alert('Do you want to modify your password?');
			document.getElementById('div_lable').innerHTML='User Password - Modify'; //added by Prabash on 24-11-2011	
		//	document.getElementById('div_scr_status').innerHTML = 'Modify';	
			document.Form1.save_but.disabled=false;	
			document.Form1.Text_new_pword.disabled=false;
			document.Form1.Text_retype_pword.disabled=false;		
			}
			
		}
		function clearAll(){
		document.Form1.Text_new_pword.value="";
		document.Form1.Text_retype_pword.value="";
		
		}
	
	</SCRIPT>
	</HEAD>			
  <BODY onLoad="get_user();disable_save()" class='body & txt-body' >
   <FORM NAME="Form1" METHOD="POST" >
	  <INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="Change_password">
			
			
			
			<DIV>
			<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
				<tr>
			<td height='7'></td>
			</tr>
				
			<tr height='30' >
			<td  width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
			<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B> Administration - System User</B></td>
		<!--	<td  width='50px' style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='right'><B> <DIV ID="div_scr_status" NAME="div_scr_status" ></DIV></B></td>-->
			<td width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>
						
			</tr>
			
			<tr>
						
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
					<!--added by prabash on 01-09-2011-->
					<TD WIDTH="6%">	
						<!--<INPUT TYPE="Button" NAME="NEW" VALUE="Add&nbsp; "   onClick="display_sec_opt('new');"  class="mainbut" disabled >-->
					</TD>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="MOD" VALUE="Edit"   onClick="display_sec_opt('mod');" class="mainbut"  >
					</TD>
					<TD WIDTH="6%">	
						<!--<INPUT TYPE="Button" NAME="DEL" VALUE="Delete&nbsp; "   onClick="display_sec_opt('del');"  class="mainbut" disabled >-->
					</TD>
					<TD WIDTH='6%'></TD>		
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
					<TD WIDTH="6%">
						<!--<INPUT TYPE="Button" NAME="report_but" VALUE="Enquiry&nbsp; "    onClick="obtain_report_before()" class="mainbut">-->
						
					</TD>
					<!--<TD  WIDTH="50%" class="hh1" align="right">-->
					<!--<B>User Password</B>-->
					<TD> <B><div id='div_lable' align='right' > </div> </B> </TD>					
					</TD>					
				</TR>
			</TABLE>
						<!--prabash-->
						
						<!----------->
			
			    <TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
			<HR>
				<TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
			
			<BR>
			
			
			
			
	
  <TABLE WIDTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0" >							
			<TD WIDTH="1%">
			<TD WIDTH="99%">

	<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0">
	  <BR>
		<TR>
		    <TD WIDTH="25%" >User ID</TD>
			   <TD WIDTH="75%"><INPUT TYPE="Text" NAME="Text_user_id" ID="Text_user_id"	ALIGN="LEFT"  DISABLED class="txt_input6" VALUE="<%=((String) session.getValue("logon.isDone")).toUpperCase()%>"></TD>
	   </TR>
	   <TR>
		 	 <TD WIDTH="25%" >New Password</TD>
			  <TD WIDTH="75%"><INPUT	TYPE="Password" NAME="Text_new_pword" ID="Text_new_pword"	ALIGN="LEFT"  MAXLENGTH="10" ONBLUR="chk_user(document.Form1.Text_new_pword);password_policy_check();" class="txt_input6"  disabled ></TD>
	  </TR>	
	 	<TR>
		 	<TD WIDTH="25%" >Retype New Password</TD>
			 <TD WIDTH="75%"><INPUT	TYPE="Password" NAME="Text_retype_pword" ID="Text_retype_pword"	ALIGN="LEFT"  MAXLENGTH="10" ONBLUR="chk_password(document.Form1.Text_new_pword,document.Form1.Text_retype_pword);" class="txt_input6" disabled ></TD>
	 	</TR>
  </TABLE> </TABLE>

 </FORM>
	<!--<applet code=mf_datagateway.class width=0 height=0></applet>-->
	<script language="JavaScript1.2" SRC="validate_v1.js">var g_dismsg=false;</SCRIPT>
	<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>						
							
				
	</body>
</html>


