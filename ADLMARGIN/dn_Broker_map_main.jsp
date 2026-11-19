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
		
		function broker_code_help(m_strat) {
			
			var aForm;    //  aForm =oForm.elements;
	     	aForm =  document.getElementById('Form1');
	
			var myObject=new Array(); //return values set to this object
	 		myObject[0]=aForm.TXT_PORTFOLIO;
	 		myObject[1]=aForm.TXT_PORTF_NAME;
	 		myObject[2]=null;
	 		myObject[3]=null;
	 		myObject[4]=null;
	  
	 		var myObject_value=new Array(); //passing values set to this object
	
			myObject_value[0]=aForm.TXT_PORTFOLIO.value;
			myObject_value[1]=aForm.TXT_PORTFOLIO.value;
			myObject_value[2]=aForm.TXT_PORTFOLIO.value;
	 
	 		var myObject_type=new Array(); //passing values data type
			
			myObject_type[0]="StringL";
			myObject_type[1]="StringL";
			myObject_type[2]="StringL";
	 
	 		var qid='75'; // 2
			var close_fun='close_broker_code_help';
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
			
		}	// End broker_code_help
			
			
		function close_broker_code_help(){
			document.Form1.TXT_PORTFOLIO.value='';
			document.Form1.TXT_PORTF_NAME.value='';
		}
		
		
		
		// ============================================================================================
		
		function broker_code_help_modify(m_strat) {
			
			var aForm;    //  aForm =oForm.elements;
	     	aForm =  document.getElementById('Form1');
	
			var myObject=new Array(); //return values set to this object
	 		myObject[0]=aForm.TXT_PORTFOLIO;
	 		myObject[1]=aForm.TXT_PORTF_NAME;
	 		myObject[2]=aForm.TXT_BROKER_CODE;
	 		myObject[3]=null;
	 		myObject[4]=null;
	  
	 		var myObject_value=new Array(); //passing values set to this object
	
			myObject_value[0]=aForm.TXT_PORTFOLIO.value;
	 
	 		var myObject_type=new Array(); //passing values data type
			
			myObject_type[0]="StringL";
	 
	 		var qid='76'; // 2
			var close_fun='close_broker_code_help_modify';
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
			
		}	// End broker_code_help
			
			
		function close_broker_code_help_modify(){
			document.Form1.TXT_PORTFOLIO.value='';
			document.Form1.TXT_PORTF_NAME.value='';
		}
		
		
	
	// *********************************************************************************			
	// ************ End New Help *******************************************************		
	// *********************************************************************************
		
		function help_code(){
			if(document.Form1.Hid_scr_name.value=='Broker_New'){
				broker_code_help(0);
			}
			else if(document.Form1.Hid_scr_name.value=='Broker_Modi'){
				broker_code_help_modify(0);
			}

		}

		
		function screen_close(){
			top.frames[1].location.href='low.jsp';
		} 
		
		function screen_cancel(){
			top.frames[1].location.href='dn_Broker_map_main.jsp';
		}
		
		function screen_new(){
			document.getElementById('div_lable').innerHTML='Broker Mapping - New'; //added by Prabash on 24-11-2011	
			document.Form1.Hid_scr_name.value = 'Broker_New';
			document.Form1.Save_but.disabled=false;
			document.Form1.TXT_PORTFOLIO.value = '';
			document.Form1.TXT_PORTF_NAME.value = '';
			document.Form1.TXT_BROKER_CODE.value = '';
			//document.getElementById('div_lable').innerHTML='System Maintenance - Broker Mapping - New'; 
		}
		
		function screen_edit(){
			document.getElementById('div_lable').innerHTML='Broker Mapping - Edit'; //added by Prabash on 24-11-2011
			document.Form1.Hid_scr_name.value = 'Broker_Modi';
			document.Form1.Save_but.disabled=false;
			document.Form1.TXT_PORTFOLIO.value = '';
			document.Form1.TXT_PORTF_NAME.value = '';
			document.Form1.TXT_BROKER_CODE.value = '';
			//document.getElementById('div_lable').innerHTML='System Maintenance - Broker Mapping - Edit'; 
		}

		
		function bank_code_onblur() {
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement1?chksql=set_opt_help&bankcode="+document.Form1.TXT_PORTFOLIO.value+""; 	
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;

 			if(m_size>0){ 
 				document.Form1.TXT_PORTFOLIO.value  = data_vec[0];
			    document.Form1.TXT_PORTF_NAME.value = data_vec[1];
 			}
			
		}
		
		function beforesubmit(){
			if(document.Form1.Hid_scr_name.value=='Broker_New'){
				m_url = servlet_client_url+":"+client_t3_port+"/"+client_name+"SaveBulkTransaction?chksql=WD_Broker_Mapping&Portfolio_code="+document.Form1.TXT_PORTFOLIO.value+"&Broker_code="+document.Form1.TXT_BROKER_CODE.value;
				top.frames[1].location.href=m_url;
			}
			else if(document.Form1.Hid_scr_name.value=='Broker_Modi'){
				m_url = servlet_client_url+":"+client_t3_port+"/"+client_name+"SaveBulkTransaction?chksql=WD_Broker_Mapping_2&Portfolio_code="+document.Form1.TXT_PORTFOLIO.value+"&Broker_code="+document.Form1.TXT_BROKER_CODE.value;
				top.frames[1].location.href=m_url;
			}
		}
		
		function portcheck(objx){
			m_portcode=objx.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"SaveBulkTransaction?port_code="+m_portcode.toUpperCase()+"&chksql=chkport";
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
			
			if (m_size ==0) {
				help_code(0);
				objx.focus();
			}
			else{
				document.Form1.TXT_PORTFOLIO.value  = data_vec[0];
 				document.Form1.TXT_PORTF_NAME.value = data_vec[1];
				brokercheck(objx);
			}
		}
		
		function brokercheck(objx){
			if (objx.value!="") {
				m_portcode=objx.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"SaveBulkTransaction?port_code="+m_portcode.toUpperCase()+"&chksql=chkbroker";
				load_interface(m_url,'XML',false);
			    m_size = data_vec.length;
				
				if (m_size==0) {
					
				}else{
				  document.Form1.TXT_BROKER_CODE.value = data_vec[0];			
				}
			}
		}
		
		
	</SCRIPT>
	
	<BODY  class='body & txt-body' onload= "screen_new();" >
		
		<FORM NAME="Form1" ID="Form1" METHOD="POST" >

				<INPUT TYPE="Hidden" NAME="main_but_type" VALUE="NEW">
			    <INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="Broker_New">
			    <INPUT TYPE="Hidden" NAME="hidden_help_value" ALIGN="RIGHT" SIZE=2 >
				<INPUT TYPE="Hidden" NAME="hid_help_type" ALIGN="RIGHT" SIZE=1 >
				<INPUT TYPE="Hidden" NAME="hidden_max" ALIGN="RIGHT" VALUE=1>

			
			<DIV>
				<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
					<tr>
						<td height='7'></td>
					</tr>
					
					<tr height='30' >
						<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
						 <td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Administration - Broker Master Sub Module</B></td> 
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
					<!--added by prabash on 01-09-2011-->
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="New_but"    VALUE=" Add "    onClick="screen_new();"   class="mainbut" >
					</TD>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="Edit_but"   VALUE=" Edit "    onClick="screen_edit();"  class="mainbut" >
					</TD>
					
						
				<TD WIDTH='6%'>&nbsp;&nbsp;&nbsp;&nbsp;</TD>	
						
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="Save_but"   VALUE=" Save "       onClick="beforesubmit();"    class="mainbut" >
					</TD>
					
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="Cancel_but" VALUE=" Cancel"      onClick="screen_cancel();" class="mainbut" >
				</TD>
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="Exit_but"   VALUE=" Exit "       onClick="screen_close();"  class="mainbut" >
					</TD>
	
					<!--<TD  WIDTH="50%" class="hh1" align="right">-->
					<!--<B>Instrument Types</B>-->
					<TD> <B><div id='div_lable' align='right' > </div> </B> </TD>					
		</TD>
		</TR>
			</TABLE>
						

					<HR>
					
					<BR>	
					<!-- <TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0"> -->
					<TABLE WIDTH="97%" ALIGN="CENTER" BGCOLOR="darkblue" >
						
						<TR>							
						   <TD WIDTH="22%"> Broker Code </TD>							
						   <TD WIDTH="40%"> 
								 <INPUT TYPE="text"   NAME="TXT_PORTFOLIO"   align="left" size="20"  class="txt_input6 "  maxlength="20"  onblur="portcheck(document.Form1.TXT_PORTFOLIO)" >
						    	 <INPUT TYPE="Button" NAME="BUT_TXT_PORTFOLIO" VALUE="..." onClick="help_code();"  class="mainbut" >
							</TD>
							<TD WIDTH="*%"> &nbsp; </TD>
					    </TR>	
						
						<TR>							
						   <TD WIDTH="22%"> Broker Name </TD>							
						   <TD WIDTH="40%"> 
								 <INPUT TYPE="text"   NAME="TXT_PORTF_NAME"   align="left" size="50"  class="txt_input6 "  maxlength="100" Disabled >
							</TD>
							<TD WIDTH="*%"> &nbsp; </TD>
					    </TR>
						
						<TR>							
						   <TD WIDTH="22%"> Broker Code II </TD>							
						   <TD WIDTH="40%"> 
								 <INPUT TYPE="text"   NAME="TXT_BROKER_CODE"   align="left" size="20"  class="txt_input6 "  maxlength="20"  >
							</TD>
							<TD WIDTH="*%"> &nbsp; </TD>
					    </TR>


							</table>
						</TD>
					</tr>
					
				</table>

	
		
			</FORM>

			<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>
			<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
			
		</body>
	</html>
	
