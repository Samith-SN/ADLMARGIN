<HTML> 
	<HEAD>
		<TITLE>Margin Trading 
		</TITLE>
		<LINK REL="stylesheet" TYPE="text/css" HREF="" />
		
	</HEAD>
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
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/blue/style.css' TYPE=\"text/css\">");
		
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");	
		
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/SNET/jquery/grid/4.1/themes/ui.jqgrid.css' TYPE=\"text/css\">");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/i18n/grid.locale-en.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/jquery.jqGrid.min.js\"></script>");		
	%>
	
	<SCRIPT language="JavaScript1.2" >
		
	// ***********************************************************************************		
	// ************* Start New Help ******************************************************	
	// ***********************************************************************************			
		
		function bank_code_help(m_strat) {
			
			var aForm;    //  aForm =oForm.elements;
	     	aForm =  document.getElementById('Form1');
	
			var myObject=new Array(); //return values set to this object
	 		myObject[0]=aForm.Text_bankcode;
	 		myObject[1]=aForm.Text_bank_name;
	 		myObject[2]=null;
	 		myObject[3]=null;
	 		myObject[4]=null;
	  
	 		var myObject_value=new Array(); //passing values set to this object
	
			myObject_value[0]=aForm.Text_bankcode.value;
			myObject_value[1]=aForm.Text_bank_name.value;
	 
	 		var myObject_type=new Array(); //passing values data type
			
			myObject_type[0]="StringL";
			myObject_type[1]="StringL";
	 
	 		var qid='67'; // 2
			var close_fun='close_bank_code_help';
	 		var url = 'popup.jsp';
	 		var json_text = JSON.stringify(myObject_value, null,0);
	 		var json_obj_type_text=JSON.stringify(myObject_type, null,0);
	 		var fn_name=arguments.callee.name;
	if(fn_name==undefined){
		re = /^function\s+([^(]+)/;
        fn_name=re.exec(arguments.callee.toString())[1];
		}
	       	$.showModalDialog({
			 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun, //&close_fun='+close_fun,
			 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
			 height:400,// 500,
			 width: 400,//900,
			 title: 'SasiNet Frame work',
			 scrollable: true,
			 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
			});
			
		}	// End bank_code_help
			
			
		function close_bank_code_help(){
			document.Form1.Text_bankcode.value='';
		}
		
		
		function account_code_help(m_strat) {
			var aForm;    //  aForm =oForm.elements;
	     	aForm =  document.getElementById('Form1');
	
			var myObject=new Array(); //return values set to this object
	 		myObject[0]=null;
	 		myObject[1]=aForm.Text_bankcode;
	 		myObject[2]=aForm.Text_acc_number;
	 		myObject[3]=aForm.Text_bank_name;
	 		myObject[4]=aForm.Text_account_reference; 
	  
	 		var myObject_value=new Array(); //passing values set to this object
	
			myObject_value[0]=aForm.Text_bankcode.value;
			myObject_value[1]=aForm.Text_bank_name.value;
	 
	 		var myObject_type=new Array(); //passing values data type
			
			myObject_type[0]="StringL";
			myObject_type[1]="StringL";
	 
	 		var qid='68'; // 2
			var close_fun='close_account_code_help';
	 		var url = 'popup.jsp';
	 		var json_text = JSON.stringify(myObject_value, null,0);
	 		var json_obj_type_text=JSON.stringify(myObject_type, null,0);
	 		var fn_name=arguments.callee.name;
	if(fn_name==undefined){
		re = /^function\s+([^(]+)/;
        fn_name=re.exec(arguments.callee.toString())[1];
		}
	       	$.showModalDialog({
			 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun, //&close_fun='+close_fun,
			 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
			 height:400,// 500,
			 width: 400,//900,
			 title: 'SasiNet Frame work',
			 scrollable: true,
			 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
			});
			
		}	// End account_code_help
			
			
		function close_account_code_help(){
			document.Form1.Text_bankcode.value='';
		}	
		
		
		
		function account_code_react_help(m_strat) {
			var aForm;    //  aForm =oForm.elements;
	     	aForm =  document.getElementById('Form1');
	
			var myObject=new Array(); //return values set to this object
	 		myObject[0]=null;
	 		myObject[1]=aForm.Text_bankcode;
	 		myObject[2]=aForm.Text_acc_number;
	 		myObject[3]=aForm.Text_bank_name;
	 		myObject[4]=aForm.Text_account_reference; 
	  
	 		var myObject_value=new Array(); //passing values set to this object
	
			myObject_value[0]=aForm.Text_bankcode.value;
			myObject_value[1]=aForm.Text_bank_name.value;
	 
	 		var myObject_type=new Array(); //passing values data type
			
			myObject_type[0]="StringL";
			myObject_type[1]="StringL";
	 
	 		var qid='69'; // 2
			var close_fun='close_account_code_react_help';
	 		var url = 'popup.jsp';
	 		var json_text = JSON.stringify(myObject_value, null,0);
	 		var json_obj_type_text=JSON.stringify(myObject_type, null,0);
	 		var fn_name=arguments.callee.name;
	if(fn_name==undefined){
		re = /^function\s+([^(]+)/;
        fn_name=re.exec(arguments.callee.toString())[1];
		}
	       	$.showModalDialog({
			 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun, //&close_fun='+close_fun,
			 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
			 height:400,// 500,
			 width: 400,//900,
			 title: 'SasiNet Frame work',
			 scrollable: true,
			 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
			});
			
		}	// End account_code_react_help
			
			
		function close_account_code_react_help(){
			document.Form1.Text_bankcode.value='';
		}
		
		
		function account_code_view_help(m_strat) {
			var aForm;    //  aForm =oForm.elements;
	     	aForm =  document.getElementById('Form1');
	
			var myObject=new Array(); //return values set to this object
	 		myObject[0]=null;
	 		myObject[1]=null;
	 		myObject[2]=null;
	 		myObject[3]=null;
	 		myObject[4]=null; 
	  
	 		var myObject_value=new Array(); //passing values set to this object
	
			myObject_value[0]=aForm.Text_bankcode.value;
			myObject_value[1]=aForm.Text_bank_name.value;
	 
	 		var myObject_type=new Array(); //passing values data type
			
			myObject_type[0]="StringL";
			myObject_type[1]="StringL";
	 
	 		var qid='69'; // 2
			var close_fun='close_account_code_view_help';
	 		var url = 'popup.jsp';
	 		var json_text = JSON.stringify(myObject_value, null,0);
	 		var json_obj_type_text=JSON.stringify(myObject_type, null,0);
	 		var fn_name=arguments.callee.name;
	if(fn_name==undefined){
		re = /^function\s+([^(]+)/;
        fn_name=re.exec(arguments.callee.toString())[1];
		}
	       	$.showModalDialog({
			 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun, //&close_fun='+close_fun,
			 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
			 height:400,// 500,
			 width: 400,//900,
			 title: 'SasiNet Frame work',
			 scrollable: true,
			 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
			});
			
		}	// End account_code_view_help
			
			
		function close_account_code_view_help(){
			document.Form1.Text_bankcode.value='';
		}
		
		
	
	// *********************************************************************************			
	// ************ End New Help *******************************************************		
	// *********************************************************************************
		
		function help_code(){
			if(document.Form1.Hid_scr_name.value=='Settlement_New'){
				bank_code_help(0);
			}
			else if(document.Form1.Hid_scr_name.value=='Settlement_Modi'){
				account_code_help(0);
			}
			else if(document.Form1.Hid_scr_name.value=='DEACT'){ 
				account_code_help(0);
			}
			else if(document.Form1.Hid_scr_name.value=='REACT'){
				account_code_react_help(0);
			}
			else if(document.Form1.Hid_scr_name.value=='VIEW_ALL'){
				account_code_view_help(0);
			} 

		}
		
		
		function screen_save(){
			
			data=document.Form1.Text_acc_number.value;	
			
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement1?chksql=set_opt_acc&acc_no="+document.Form1.Text_acc_number.value+"";	
			//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement1?chksql=set_opt_acc&acc_no="+document.Form1.Text_acc_number.value+"&bankcode="+document.Form1.Text_bank_name.value;
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;

			if(document.Form1.Hid_scr_name.value=='Settlement_New'){
				if (m_size >0) {
					alert("Bank account number is EXSISTING");
			  	    document.Form1.Text_acc_number.focus();
				}
				else if (data==""){
					alert("Account number can't be null");
					document.Form1.Text_acc_number.focus();
				}
				else {
				  if(document.Form1.Text_account_reference.value==""){
						 alert("Please enter the Accounting System Reference");
						 document.Form1.Text_account_reference.focus();
						}
						else{
						   	beforesubmit();
						}
				}
				
				
			}
			else if(document.Form1.Hid_scr_name.value=='Settlement_Modi'){
				 if(document.Form1.Text_account_reference.value==""){
					alert("Please enter the Accounting System Reference");
					document.Form1.Text_account_reference.focus();
				}
				else{
					beforesubmit();
				}
				
				
				
			}
			else if(document.Form1.Hid_scr_name.value=='DEACT'){ 
				if(document.Form1.Text_account_reference.value==""){
					alert("Please enter the Accounting System Reference");
					document.Form1.Text_account_reference.focus();
				}
				else{
					beforesubmit();
				}
				
				
			}
			else if(document.Form1.Hid_scr_name.value=='REACT'){
				if(document.Form1.Text_account_reference.value==""){
						 alert("Please enter the Accounting System Reference");
						document.Form1.Text_account_reference.focus();
				}
				else{
					beforesubmit();
				}
				
				
				
			}
			
		}
		
		function screen_close(){
			top.frames[1].location.href='low.jsp';
		} 
		
		function screen_cancel(){
			top.frames[1].location.href='mbfsl_settlement.jsp';
		}
		
		function screen_new(){
				
			document.Form1.Hid_scr_name.value = 'Settlement_New';
			document.Form1.Save_but.disabled=false;
			document.Form1.Text_bankcode.value = '';
			document.Form1.Text_bank_name.value = '';
			document.Form1.Text_acc_number.value = '';
			document.Form1.Text_account_reference.value = '';
			document.getElementById('div_lable').innerHTML='Settlement Options - New'; 
		}
		
		function screen_edit(){
			document.Form1.Hid_scr_name.value = 'Settlement_Modi';
			document.Form1.Save_but.disabled=false;
			document.Form1.Text_bankcode.value = '';
			document.Form1.Text_bank_name.value = '';
			document.Form1.Text_acc_number.value = '';
			document.Form1.Text_account_reference.value = '';
			document.getElementById('div_lable').innerHTML='Settlement Options - Edit'; 
		}
		
		function screen_deact(){
			document.Form1.Hid_scr_name.value = 'DEACT';
			document.Form1.Save_but.disabled=false;
			document.Form1.Text_bankcode.value = '';
			document.Form1.Text_bank_name.value = '';
			document.Form1.Text_acc_number.value = '';
			document.Form1.Text_account_reference.value = '';
			document.getElementById('div_lable').innerHTML='Settlement Options - Deactivate'; 
		}
		
		function screen_react(){
			document.Form1.Hid_scr_name.value = 'REACT';
			document.Form1.Save_but.disabled=false;
			document.Form1.Text_bankcode.value = '';
			document.Form1.Text_bank_name.value = '';
			document.Form1.Text_acc_number.value = '';
			document.Form1.Text_account_reference.value = '';
			document.getElementById('div_lable').innerHTML='Settlement Options - Reactivate'; 
		}
		
		function screen_view(){
			document.Form1.Hid_scr_name.value = 'VIEW_ALL';
			document.Form1.Save_but.disabled=true;
			document.Form1.Text_bankcode.value = '';
			document.Form1.Text_bank_name.value = '';
			document.Form1.Text_acc_number.value = '';
			document.Form1.Text_account_reference.value = '';
			document.getElementById('div_lable').innerHTML='Settlement Options - View All'; 
		}
		
		
		function bank_code_onblur() {
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement1?chksql=set_opt_help&bankcode="+document.Form1.Text_bankcode.value+""; 	
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;

 			if(m_size>0){ 
 				document.Form1.Text_bankcode.value  = data_vec[0];
			    document.Form1.Text_bank_name.value = data_vec[1];
 			}
			
		}
		
		function beforesubmit(){
			document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsavsett";
			document.Form1.submit();
		}
		
		
	</SCRIPT>
	
	<BODY  class='body & txt-body' onload= "screen_new();" >
		
		<FORM NAME="Form1" ID="Form1" METHOD="POST" >

			    <INPUT TYPE="Hidden" NAME="Hid_scr_name"  VALUE="Settlement_New">
				<INPUT TYPE="Hidden" NAME="main_but_type" VALUE="NEW">

			
			<DIV>
				<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
					<tr>
						<td height='7'></td>
					</tr>
					
					<tr height='30' >
						<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
						 <td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>	Administration -System Maintenance </B></td> 
					<!--	<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B><div id='div_lable' align='left' > </div> </B> </td>-->
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
					<TABLE WIDTH="97%" ALIGN="CENTER" BGCOLOR="darkblue" >
						<TR>								 											   
							<TD WIDTH="5%"><INPUT TYPE="Button" NAME="New_but"    VALUE=" Add"        onClick="screen_new();"   class="mainbut" ></TD>
							<TD WIDTH="5%"><INPUT TYPE="Button" NAME="Edit_but"   VALUE=" Edit"       onClick="screen_edit();"  class="mainbut" ></TD>
							<TD WIDTH="5%"><INPUT TYPE="Button" NAME="Deact_but"  VALUE=" Deactivate" onClick="screen_deact();" class="mainbut" style="{ width: 70px; }" ></TD>
							<TD WIDTH="5%"><INPUT TYPE="Button" NAME="React_but"  VALUE=" Reactivate" onClick="screen_react();" class="mainbut" style="{ width: 70px; }" ></TD>
							<TD WIDTH="5%"><INPUT TYPE="Button" NAME="View_but"   VALUE=" View All"   onClick="screen_view();"  class="mainbut" ></TD>	
							<TD WIDTH='6%'>&nbsp;&nbsp;&nbsp;&nbsp;</TD>	
							<TD WIDTH="5%"><INPUT TYPE="Button" NAME="Save_but"   VALUE=" Save "       onClick="screen_save();"    class="mainbut" ></TD>
							<TD WIDTH="5%"><INPUT TYPE="Button" NAME="Cancel_but" VALUE=" Cancel"                  onClick="screen_cancel();" class="mainbut" > </TD>
							<TD WIDTH="5%"><INPUT TYPE="Button" NAME="Exit_but"   VALUE=" Exit "       onClick="screen_close();"  class="mainbut" ></TD>					
						  
							<!--<td width="50%" class="hh1" align="right" style="font-weight: bold;">Settlement Options</td> -->
							<TD> <B><div id='div_lable' align='right' > </div> </B> </TD>
							
						</TR>
					</TABLE>
					
					<HR>
					
					<BR>	
					<!-- <TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0"> -->
					<TABLE WIDTH="97%" ALIGN="CENTER" BGCOLOR="darkblue" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
						
						<TR>							
						   <TD WIDTH="22%"> Bank Code </TD>							
						   <TD WIDTH="40%"> 
								 <INPUT TYPE="text"   NAME="Text_bankcode"   align="left" size="20"  class="txt_input6 "  maxlength="20" onblur="bank_code_onblur();" >
						    	 <INPUT TYPE="Button" NAME="BUT_BANK_CODE" VALUE="..." onClick="help_code();"  class="mainbut" >
							</TD>
							<TD WIDTH="*%"> &nbsp; </TD>
					    </TR>	
						
						<TR>							
						   <TD WIDTH="22%"> Bank Name & Branch </TD>							
						   <TD WIDTH="40%"> 
								 <INPUT TYPE="text"   NAME="Text_bank_name"   align="left" size="50"  class="txt_input6 "  maxlength="100" >
							</TD>
							<TD WIDTH="*%"> &nbsp; </TD>
					    </TR>
						
						<TR>							
						   <TD WIDTH="22%"> Account No. </TD>							
						   <TD WIDTH="40%"> 
								 <INPUT TYPE="text"   NAME="Text_acc_number"   align="left" size="20"  class="txt_input6 "  maxlength="20" >
							</TD>
							<TD WIDTH="*%"> &nbsp; </TD>
					    </TR>
						
						<TR>							
						   <TD WIDTH="22%"> Accounting System Reference </TD>							
						   <TD WIDTH="40%"> 
								 <INPUT TYPE="text"   NAME="Text_account_reference"   align="left" size="20"  class="txt_input6 "  maxlength="20" >
							</TD>
							<TD WIDTH="*%"> &nbsp; </TD>
					    </TR>
						
								<TR>
									<TD WIDTH="1%"></TD>
									<TD WIDTH="*%"> <!-- -->
										
												<table align='center' width='100%' class='table'>
												<tr> 
												<td width="100%"  height="70%"><div id="data_div"></div></td>
												</tr> 
												</table>										
										
												<DIV ALIGN="CENTER" id=insdata ></DIV>																		
									</TD> 
								</tr>
							</table>
						</TD>
					</tr>
					
				</table>
		
		  <div id = "DIV_AVAILABILITY_DETAILS">
                     <table id = "TABLE_SECURITY_APPROVAL"></table>
                      <div id = "DIV_PAGER_REVERSAL_DETAILS"></div>
           </div>
	
		
			</FORM>

			<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>
			<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
			
		</body>
	</html>
	
