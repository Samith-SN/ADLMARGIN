<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
	<HEAD>
		<TITLE>System Administration - Nature of Relationship</TITLE>
		<!--
		<script type = "text/javascript" src = "http://www.netfac.lk/SNET/jquery/fancybox/jquery-1.4.1.min.js"></script>
		<script type = "text/javascript" src = "http://www.netfac.lk/SNET/jquery/fancybox/jquery.fancybox-1.3.0.pack.js"></script>
		<script language1.2 = "JavaScript" src = "http://www.netfac.lk/validate.js"></script>
		<script language1.2 = "JavaScript" src = "http://www.netfac.lk/validate_v1.js"></script>
		
		<script language1.2 = "JavaScript" src = "http://www.netfac.lk/ajax_data_gateway.js"></script>
		<script language1.2 = "JavaScript" src = "http://www.netfac.lk/user_rights_data_gateway.js"></script>
		<link rel = "stylesheet" type = "text/css" href = "http://www.netfac.lk/SNET/jquery/fancybox/jquery.fancybox-1.3.0.css" media = "screen" />
		<link rel = "stylesheet" type = "text/css" href = "http://www.netfac.lk/SNET/css/Asset_Financing_System.css" />
		-->
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
			out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/redmond/jquery-ui.css' TYPE=\"text/css\">");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/i18n/grid.locale-en.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/jquery.jqGrid.min.js\"></script>");
			out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\""+m_jsp_client_url+"/css/ui.jqgrid.css\" />");
			//out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "ajax_data_gateway.js \"></script>");
			
		%>
		<SCRIPT language="JavaScript">
		var bank_arry=new Array();
		var dist_arry=new Array();
		var alert_msg;
		var error_msg1 = false;
		var error_msg2 = false;
		var error_msg3 = false;
		var error_msg4 = false;
		var error_msg5 = false;
		var isOpen=false;

			
			$(document).ready(function() 
			{ 
		//init_fancybox();
				bind_events();
			});
			
			function bind_events() 
			{
			  $('#TXT_MIN_LENGTH').blur(function(event) 
			  {
				var isNumberValidated = validateNumber(event.target, 1, 999, 0, 'number');
				if (isNumberValidated == true) 
				{
					var minLength = parseInt($('#TXT_MIN_LENGTH').val());
					var maxLength = parseInt($('#TXT_MAX_LENGTH').val());
					var lowerCaseCount = parseInt($('#TXT_MIN_LOWER').val());
					var upperCaseCount = parseInt($('#TXT_MIN_UPPER').val());
					var numericCharacterCount = parseInt($('#TXT_MIN_NUM').val());
					var specialCharacterCount = parseInt($('#TXT_MIN_SPECIAL').val());
					var minCharacterCount = lowerCaseCount + upperCaseCount + numericCharacterCount + specialCharacterCount;
					if (minLength > maxLength)
					{
						$('#TXT_MAX_LENGTH').val(minLength);
					}
					if (minLength < minCharacterCount) 
					{
						$('#TXT_MIN_LOWER').val('0');
						$('#TXT_MIN_UPPER').val('0');
						$('#TXT_MIN_NUM').val('0');
						$('#TXT_MIN_SPECIAL').val('0');
						$('#TXT_MIN_NUM').attr('disabled', true);
						$('#TXT_MIN_SPECIAL').attr('disabled', true);
						$('#TXT_NUM_EMBED').val('N');
						$('#TXT_CHAR_EMBED').val('N');
					}
				}
			   }
			);
			$('#TXT_MAX_LENGTH').blur(function(event) 
			{
				var isNumberValidated = validateNumber(event.target, 1, 999, 0, 'number');
				if (isNumberValidated == true) 
				{
					var minLength = parseInt($('#TXT_MIN_LENGTH').val());
					var maxLength = parseInt($('#TXT_MAX_LENGTH').val());
					var lowerCaseCount = parseInt($('#TXT_MIN_LOWER').val());
					var upperCaseCount = parseInt($('#TXT_MIN_UPPER').val());
					var numericCharacterCount = parseInt($('#TXT_MIN_NUM').val());
					var specialCharacterCount = parseInt($('#TXT_MIN_SPECIAL').val());
					var minCharacterCount = lowerCaseCount + upperCaseCount + numericCharacterCount + specialCharacterCount;
					if (maxLength < minLength) 
					{
						$('#TXT_MIN_LENGTH').val(maxLength);
					}
					if (maxLength < minCharacterCount) 
					{
						$('#TXT_MIN_LOWER').val('0');
						$('#TXT_MIN_UPPER').val('0');
						$('#TXT_MIN_NUM').val('0');
						$('#TXT_MIN_SPECIAL').val('0');
						$('#TXT_MIN_NUM').attr('disabled', true);
						$('#TXT_MIN_SPECIAL').attr('disabled', true);
						$('#TXT_NUM_EMBED').val('N');
						$('#TXT_CHAR_EMBED').val('N');
					}
				}
			});
			$('#TXT_MIN_LOWER, #TXT_MIN_UPPER, #TXT_MIN_NUM, #TXT_MIN_SPECIAL').blur(function(event) 
			{
				var isNumberValidated = validateNumber(event.target, 0, 999, 0, 'number');
				if (isNumberValidated == true) 
				{
					var minLength = parseInt($('#TXT_MIN_LENGTH').val());
					var maxLength = parseInt($('#TXT_MAX_LENGTH').val());
					var lowerCaseCount = parseInt($('#TXT_MIN_LOWER').val());
					var upperCaseCount = parseInt($('#TXT_MIN_UPPER').val());
					var numericCharacterCount = parseInt($('#TXT_MIN_NUM').val());
					var specialCharacterCount = parseInt($('#TXT_MIN_SPECIAL').val());
					var minCharacterCount = lowerCaseCount + upperCaseCount + numericCharacterCount + specialCharacterCount;
					if (minCharacterCount > minLength) {
					$('#TXT_MIN_LENGTH').val(minCharacterCount);
					}
					if ($('#TXT_MIN_LENGTH').val() > maxLength) 
					{
						$('#TXT_MAX_LENGTH').val($('#TXT_MIN_LENGTH').val());
					}
					if ((event.target.id == 'TXT_MIN_NUM') && (event.target.value == '0'))
					{
						$('#TXT_MIN_NUM').attr('disabled', true);
						$('#TXT_NUM_EMBED').val('N');
					}
					else if ((event.target.id == 'TXT_MIN_SPECIAL') && (event.target.value == '0')) 
					{
						$('#TXT_MIN_SPECIAL').attr('disabled', true);
						$('#TXT_CHAR_EMBED').val('N');
					}
				}
		   });
			$('#TXT_NUM_EMBED').change(function() 
			{
					if ($('#TXT_NUM_EMBED').val() == 'N') 
					{
						$('#TXT_MIN_NUM').val('0');
						$('#TXT_MIN_NUM').attr('disabled', true);
					}
					else if ($('#TXT_NUM_EMBED').val() == 'Y')
					{
						$('#TXT_MIN_NUM').attr('disabled', false);
						setTimeout('$(\'#TXT_MIN_NUM\').select()', 1);
					}
			});
			$('#TXT_CHAR_EMBED').change(function() 
			{
				if ($('#TXT_CHAR_EMBED').val() == 'N') 
				{
					$('#TXT_MIN_SPECIAL').val('0');
					$('#TXT_MIN_SPECIAL').attr('disabled', true);
				}
				else if ($('#TXT_CHAR_EMBED').val() == 'Y') 
				{
					$('#TXT_MIN_SPECIAL').attr('disabled', false);
					setTimeout('$(\'#TXT_MIN_SPECIAL\').select()', 1);
				}
			});
			
			$('#TXT_CHANGE_ATTEMPT, #TXT_REPEAT_PW, #TXT_MIN_GAP').blur(function(event) 
			{
					validateNumber(event.target, 0, 999, 0, 'number');
			});
			$('#TXT_EXPIRE_DAYS').blur(function(event)
			{
				var isNumberValidated = validateNumber(event.target, 0, 999, 0, 'number');
				if (isNumberValidated == true) 
				{
					var expirationInDays = parseInt($('#TXT_EXPIRE_DAYS').val());
					var messagePriorToPasswordExpirationInDays = parseInt($('#TXT_EXPIRE_MSG').val());
					if (expirationInDays < messagePriorToPasswordExpirationInDays) 
					{
						$('#TXT_EXPIRE_MSG').val(expirationInDays);
					}
				}
			});
			$('#TXT_EXPIRE_MSG').blur(function(event) 
			{
				var isNumberValidated = validateNumber(event.target, 0, 999, 0, 'number');
				if (isNumberValidated == true) 
				{
					var expirationInDays = parseInt($('#TXT_EXPIRE_DAYS').val());
					var messagePriorToPasswordExpirationInDays = parseInt($('#TXT_EXPIRE_MSG').val());
					if (messagePriorToPasswordExpirationInDays > expirationInDays) 
					{
						$('#TXT_EXPIRE_DAYS').val(messagePriorToPasswordExpirationInDays);
					}
				}
		    });
		}
			
			
		
			
		
		function assign_vector_data(data_vec) 
		{
				if(data_vec.length>0 && document.Form1.hid_display_client.value=="1")
				{
					document.Form1.TXT_MIN_LENGTH.value=data_vec[0];
					document.Form1.TXT_MAX_LENGTH.value=data_vec[1];
					document.Form1.TXT_MIN_LOWER.value=data_vec[2];
					document.Form1.TXT_MIN_UPPER.value=data_vec[3];
					document.Form1.TXT_MIN_NUM.value=data_vec[4];
					document.Form1.TXT_NUM_EMBED.value=data_vec[5];
					document.Form1.TXT_MIN_SPECIAL.value=data_vec[6];
					document.Form1.TXT_CHAR_EMBED.value=data_vec[7];
					document.Form1.TXT_CHANGE_ATTEMPT.value=data_vec[8];
					document.Form1.TXT_USER_NAME_ALLOW.value=data_vec[9];
					document.Form1.TXT_REPEAT_PW.value=data_vec[10];
					document.Form1.TXT_MIN_GAP.value=data_vec[11];
					document.Form1.TXT_EXPIRE_DAYS.value=data_vec[12];
					document.Form1.TXT_EXPIRE_MSG.value=data_vec[13];
					if ($('#TXT_NUM_EMBED').val() == 'N') 
					{
						$('#TXT_MIN_NUM').attr('disabled', true);
					}
					if ($('#TXT_CHAR_EMBED').val() == 'N') 
					{
						$('#TXT_MIN_SPECIAL').attr('disabled', true);
					}
				}
				/*
				else if(data_vec.length==0 && document.Form1.hid_display_client.value=="1")
				{
					makeRequest(99);
				}
				*/
		}
			
			
		/*
		function get_vector(data_vec) 
		{
				if(data_vec.length>0 && document.Form1.hid_display_client.value=="1")
				{
					document.Form1.TXT_MIN_LENGTH.value=data_vec[0];
					document.Form1.TXT_MAX_LENGTH.value=data_vec[1];
					document.Form1.TXT_MIN_LOWER.value=data_vec[2];
					document.Form1.TXT_MIN_UPPER.value=data_vec[3];
					document.Form1.TXT_MIN_NUM.value=data_vec[4];
					document.Form1.TXT_NUM_EMBED.value=data_vec[5];
					document.Form1.TXT_MIN_SPECIAL.value=data_vec[6];
					document.Form1.TXT_CHAR_EMBED.value=data_vec[7];
					document.Form1.TXT_CHANGE_ATTEMPT.value=data_vec[8];
					document.Form1.TXT_USER_NAME_ALLOW.value=data_vec[9];
					document.Form1.TXT_REPEAT_PW.value=data_vec[10];
					document.Form1.TXT_MIN_GAP.value=data_vec[11];
					document.Form1.TXT_EXPIRE_DAYS.value=data_vec[12];
					document.Form1.TXT_EXPIRE_MSG.value=data_vec[13];
					if ($('#TXT_NUM_EMBED').val() == 'N') 
					{
						$('#TXT_MIN_NUM').attr('disabled', true);
					}
					if ($('#TXT_CHAR_EMBED').val() == 'N') 
					{
						$('#TXT_MIN_SPECIAL').attr('disabled', true);
					}
				}
				else if(data_vec.length==0 && document.Form1.hid_display_client.value=="1")
				{
					makeRequest(99);
				}
		}
		*/
		function makeRequest(m_val) 
		{
			if(m_val=="1")
			{
				document.Form1.hid_display_client.value=1;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=GET_PASSWORD_POLICY";	
				//m_url="http://www.netfac.lk:8080/myserver/servlet/LBMARGIN2_dnvalsavuser?chksql=GET_PASSWORD_POLICY";
			}
			else if(m_val=="99")
			{
				document.Form1.hid_display_client.value=99;
				//m_url="http://www.netfac.lk:8080/myserver/servlet/NETFAC_AF_MAS_sql_validations3?chksql=idle";
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=idle";	
			}
			load_interface(m_url,'XML');
			assign_vector_data(data_vec);
		}
		/*****/
	
			function validate_data()
			{
				if(document.Form1.TXT_MIN_LENGTH.value=="")
				{  
					document.getElementById('DIV_TXT_MIN_LENGTH').style.color='red';
					document.Form1.TXT_MIN_LENGTH.focus()
					error_msg1 = true;
					return false;
				}
				else if(document.Form1.TXT_MAX_LENGTH.value=="")
				{  
					document.getElementById('DIV_TXT_MAX_LENGTH').style.color='red';
					document.Form1.TXT_MAX_LENGTH.focus()
					error_msg1 = true;
					return false;
				}
				if(document.Form1.TXT_EXPIRE_DAYS.value=="")
				{  
					document.getElementById('DIV_TXT_EXPIRE_DAYS').style.color='red';
					document.Form1.TXT_EXPIRE_DAYS.focus()
					error_msg1 = true;
					return false;
				}
				else if(document.Form1.TXT_EXPIRE_MSG.value=="")
				{  
					document.getElementById('DIV_TXT_EXPIRE_MSG').style.color='red';
					document.Form1.TXT_EXPIRE_MSG.focus()
					error_msg1 = true;
					return false;
				}
				else if(parseInt(document.Form1.TXT_EXPIRE_DAYS.value) == 0)
				{
					document.getElementById('DIV_TXT_EXPIRE_DAYS').style.color='red';
					document.Form1.TXT_EXPIRE_DAYS.focus()
					error_msg3 = true;
					return false;
				}
				else if(parseInt(document.Form1.TXT_EXPIRE_MSG.value) >= parseInt(document.Form1.TXT_EXPIRE_DAYS.value))
				{
					document.getElementById('DIV_TXT_EXPIRE_MSG').style.color='red';
					document.Form1.TXT_EXPIRE_MSG.focus()
					error_msg3 = false;
					error_msg2 = true;
					return false;
				}
				else if(parseInt(document.Form1.TXT_MAX_LENGTH.value) == 0)
				{
					document.getElementById('DIV_TXT_MAX_LENGTH').style.color='red';
					document.Form1.TXT_MAX_LENGTH.focus()
					error_msg4 = true;
					return false;
				}
				else if(parseInt(document.Form1.TXT_MIN_LENGTH.value) >= parseInt(document.Form1.TXT_MAX_LENGTH.value))
				{
					document.getElementById('DIV_TXT_MIN_LENGTH').style.color='red';
					document.Form1.TXT_MIN_LENGTH.focus()
					error_msg4 = false;
					error_msg5 = true;
					return false;
				}
				else
				{
					return true;
				}
			}
			function before_submit()
			{ 
				for (var i=0; i < document.Form1.elements.length; i++ ) 
				{
					document.Form1.elements[i].disabled=false;
				}
				if(validate_data())
				{
					if(confirm("Are you sure you want to "+document.Form1.hid_save.value+"?"))
					{ 
						//document.Form1.action='http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_MAS_password_policy_save';
						document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"FA_MAS_password_policy_save";
						//alert();
						//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=idle";	
						document.Form1.submit();	
					}
				}
				else 
				{
					if(error_msg1==true)
					alert('Please enter all required fields marked with a * on the screen')
					if(error_msg2==true)
					alert('Numbers of days to appear password expiry message can not be grater than number of days for passwords expiration');
					if(error_msg3==true)
					alert('Period for Password Expiration can not be zero')
					if(error_msg4==true)
					alert('Maxlength Length can not be zero');
					if(error_msg5==true)
					alert('Minimum length can not be grater than Maximum length.');
				} 
			} 
			
			function save_window()
			{	
				before_submit();
			}
			function assign_data(data_vec)
			{ 
				document.Form1.TXT_RELATION_TYPE.value=data_vec[0];
				document.Form1.TXT_NAME.value=data_vec[1];
				document.Form1.TXT_DEFAULT_VALUE.value=data_vec[2];
			}
	
	
		
		
		

		
			function load_rights()
			{
				check_user_rights('NETFAC_FA_MAS_password_policy_display','NETFACALL','SNET');
			}
		
			function load_roll_out_value()
			{
				document.getElementById('help_box').innerHTML=" System Administration - Password Policy - "+document.Form1.hid_status.value;
			}
			
			function load_screen_status(m_val)
			{
				if(m_val=="NEW")
				{
					new_window();
					document.Form1.BUT_HELP_MAIN.disabled=true;
				}
				else if(m_val=="HELP")
				{
					load_help_msg();
				}
				else if(m_val!="EDIT")
				{
					document.Form1.BUT_HELP_MAIN.disabled=false;
					document.Form1.TXT_NAME.disabled=true;
					document.Form1.TXT_DEFAULT_VALUE.disabled=true;
				}
				else{
					document.Form1.BUT_HELP_MAIN.disabled=false;
				}
				document.Form1.SCREEN_NAME.value=m_val;
				if(m_val=="NEW")
				{
					document.Form1.hid_status.value="New";
					document.Form1.hid_save.value="Save";
				}else if(m_val=="EDIT")
				{
					document.Form1.hid_status.value="Edit";
					document.Form1.hid_save.value="Modify";
				}else if(m_val=="DACT")
				{
					document.Form1.hid_status.value="Deactivate";
					document.Form1.hid_save.value="Deactivate";
				}else if(m_val=="RACT")
				{
					document.Form1.hid_status.value="Reactivate";
					document.Form1.hid_save.value="Reactivate";
				}else
				{
					document.Form1.hid_status.value="";
				}
			}
		
		
	
		
			
			
		function clearAll(){
			top.frames[1].location.href = jsp_client_url + "/password_policy_display.jsp";
		}
		
		
		function exit()
		{
			top.frames[1].location.href = jsp_client_url + "/low.jsp";
		}	
			
			
	</script>
	</HEAD>
		<BODY class='body & txt-body' leftmargin='0' topmargin='0' marginwidth='0' ONLOAD="makeRequest(1)"> <!--load_roll_value('New'); load_rights() -->
		<FORM NAME='Form1' method='post'>
		<input  type='hidden' value='NEW' name='SCREEN_NAME'> 
		<INPUT TYPE='Hidden' NAME='hid_help_type' VALUE="">
		
		<INPUT TYPE='Hidden' NAME='hid_help_status' VALUE="">
		<INPUT TYPE='Hidden' NAME='hid_status' VALUE="New">
		<INPUT TYPE='Hidden' NAME='hid_display_client' VALUE="99">
		<INPUT TYPE='Hidden' NAME='hid_save' VALUE="Save">
		<table width='100%' class=table border='0' cellspacing='0' cellpadding='0'>
		<tr>
		<td width='8' valign='top'></td>
		<td  valign='top'> <!-- class='border_wht' -->
		<table class='table' width='100%' border='0' cellspacing='0' cellpadding='0' height='100%'>
		<!-- <tr> 
		<td height='30' class='pdn_mainHD'><div><span>Asset Financing System Version</span><span style='position:absolute;right:30px;font-size: 12px;'>User : NETFACALL</span> <span  style='position:absolute;right:150px;font-size: 11px;'>System Date: 26-AUG-2011</span><span  style='position:absolute;right:320px;font-size: 11px;'>Current Date: 05-OCT-2011</span></div></td>
		</tr>
		-->
		
		<tr> 
		<td height='1'></td>
		</tr>
							
		<tr>
		<td
			<table class='table' border='0' cellpadding='0' cellspacing='0' height='100%' width='100%'> 
			<tr>
			<td >										
			<table class='table' border='0' align='center' width="100%" border="0" cellpadding="2" cellspacing="0">
				<tr>
					<td width="1%">
					</td>	
					<td width="99%">		
						<table class='table' align='center' width="99%" border="0" cellpadding="0" cellspacing="0" >
							<!-- <table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 	-->
							<tr>
								<td height='7'></td>
							</tr>
							<tr height="30">		
								<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
								<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Administration -System User</B></td>
								<td width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>
							</tr>
						</table>
						
					</td>			
				</tr>	
				<tr>
					<td width="1%">
					</td>
					<td width="99%">			
						<table class='table' align='center' width="99%" border="0" cellpadding="2" cellspacing="0" >
							<tr>
								<td width="6%">
									<input type="button" value="Save" onclick="save_window()" class="mainbut">	
								</td>	
								<td width="6%">
									<input type="button" value="Cancel" onclick="clearAll()" class="mainbut">	
								</td>	
								<td width="6%">
									<input type="button" value="Exit" onclick="exit()" class="mainbut">	
								</td>	
								<TD WIDTH="*%"> &nbsp; </TD>

								<td width="33%" class="hh1"  align="right" >
									<B>Password Policy</B>
								</td>	
								
							</tr>
						</table>	
					</td>
				</tr>
			    </table>
			</td>								
			</tr>						
									
									
									
									
			<tr>
				<td height='1'></td>
	    	</tr>
			<!--
			<tr>
				<td align='left' class='pdn_txtpos2' style='height: 18px' id='help_box'>System Administration - Password Poloicy</td>
			</tr>
			-->
	
									
			<tr>
				<td class='line' height='1'></td>
			</tr>
			<tr>
				<td class='pdn_txtpos' height='150' valign='top'>
				<br >
				<table align='center' width='100%' class='table' >
				<tr >
					<td width='30%' ><DIV id='DIV_TXT_MIN_LENGTH'  class=div_input>Minimum Length *</DIV></td>
					<td width='20%' ><input class='txt_input5' type='text' id='TXT_MIN_LENGTH' name='TXT_MIN_LENGTH' maxlength='5' size='5' /></td>
					<td width='30%' ><DIV id='DIV_TXT_MAX_LENGTH'  class=div_input>Maxlength Length *</DIV></td>
					<td width='20%' ><input class='txt_input5' type='text' id='TXT_MAX_LENGTH' name='TXT_MAX_LENGTH' maxlength='5' size='5' /></td>
				</tr>
				<tr >
					<td width='30%' ><DIV id='DIV_TXT_MIN_LOWER'  class=div_input>Minimum Number of Lowercase Char </DIV></td>
					<td width='20%' ><input class='txt_input5' type='text' id='TXT_MIN_LOWER' name='TXT_MIN_LOWER' maxlength='5' size='5' /></td>
					<td width='30%' ><DIV id='DIV_TXT_MIN_UPPER'  class=div_input>Minimum Number of Uppercase Char </DIV></td>
					<td width='20%' ><input class='txt_input5' type='text' id='TXT_MIN_UPPER' name='TXT_MIN_UPPER' maxlength='5' size='5' /></td>
					<td width='*%'></td>
				</tr>
				<tr >
					<td width='30%' ><DIV id='DIV_TXT_MIN_NUM'  class=div_input>Minimum Number of Numeric Char </DIV></td>
					<td width='20%' ><input class='txt_input5' type='text' id='TXT_MIN_NUM' name='TXT_MIN_NUM' maxlength='5' size='5' /></td>
					<td width='30%' >Numbers be Embedded</td>
					<td width='20%' >
						<select id='TXT_NUM_EMBED' name='TXT_NUM_EMBED' class="txt_input5" style= 'text-align:left;' >
							<OPTION value="Y" >Yes </option>
							<OPTION value="N" SELECTED >No </option>
						</SELECT>
					</td>
				</tr>
				<tr >
					<td width='30%' ><DIV id='DIV_TXT_MIN_SPECIAL'  class=div_input>Minimum Numbers of Special Char </DIV></td>
					<td width='20%' ><input class='txt_input5' type='text' id='TXT_MIN_SPECIAL' name='TXT_MIN_SPECIAL' maxlength='5' size='5' /></td>
					<td width='30%' >Special Char be Embedded</td>
					<td width='20%'>
						<select id='TXT_CHAR_EMBED' name='TXT_CHAR_EMBED' class="txt_input5" style= 'text-align:left;'>
							<OPTION value="Y" >Yes </option>
							<OPTION value="N" SELECTED >No </option>
						</SELECT>
					</td>
				</tr>
				<tr >
					<td width='30%' ><DIV id='DIV_TXT_CHANGE_ATTEMPT'  class=div_input>Number of Password Change Attempts </DIV></td>
					<td width='20%' ><input class='txt_input5' type='text' id='TXT_CHANGE_ATTEMPT' name='TXT_CHANGE_ATTEMPT' maxlength='5' size='5' /></td>
					<td width='30%' >Allow User Name in Password</td>
					<td width='20%'>
						<select name='TXT_USER_NAME_ALLOW' class="txt_input5" style= 'text-align:left;'>
						<OPTION value="Y" >Yes </option>
						<OPTION value="N" SELECTED >No </option>
						</SELECT>
					</td>
				</tr>
				<tr >
					<td width='30%' ><DIV id='DIV_TXT_REPEAT_PW'  class=div_input>Allow Repeat a Password After How Many Passwords </DIV></td>
					<td width='20%' ><input class='txt_input5' type='text' id='TXT_REPEAT_PW' name='TXT_REPEAT_PW' maxlength='5' size='5' /></td>
					<td width='30%' ><DIV id='DIV_TXT_MIN_GAP'  class=div_input>Minimum Gap Before Subsequent Password Change in Minutes </DIV></td>
					<td width='20%' ><input class='txt_input5' type='text' id='TXT_MIN_GAP' name='TXT_MIN_GAP' maxlength='5' size='5' /></td>
				</tr>
				<tr >
					<td width='30%' ><DIV id='DIV_TXT_EXPIRE_DAYS'  class=div_input>Period for Password Expiration in Days *</DIV></td>
					<td width='20%' ><input class='txt_input5' type='text' id='TXT_EXPIRE_DAYS' name='TXT_EXPIRE_DAYS' maxlength='5' size='5' /></td>
					<td width='30%' ><DIV id='DIV_TXT_EXPIRE_MSG'  class=div_input>Number of Days Prior to Expiration Date Should the Password Expiry Warning Message Appear *</DIV></td>
					<td width='20%' ><input class='txt_input5' type='text' id='TXT_EXPIRE_MSG' name='TXT_EXPIRE_MSG' maxlength='5' size='5' /></td>
				</tr>
				</table>
				<br>
				<table align='center' width='100%'>
				<tr>
					<td width='100%' class='note'></td>
				</tr>
				</table>
			    </td>
		   </tr>
		  </table>
		  </td>
		  </tr>
		  </table>
	</form>
	</body>
	<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
	<SCRIPT language1.2="JavaScript" src="validate.js"></SCRIPT>		
	</html>
		
