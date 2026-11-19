<HTML>
	<HEAD>
		<TITLE>Margin Traging</TITLE>
		<%@page import="net.sasianet.ADLMARGIN.*" %>
		<%	
			ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
			String m_jsp_client_url=m_sn_methods.jsp_client_url;
			
			
			Object done = (String)session.getValue("logon.isDone");  // marker object
			if (done == null) {
			response.sendRedirect("login.jsp");
			return;
			}
			
			
			out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
			out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/redmond/jquery-ui.css' TYPE=\"text/css\">");
			
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
			
		%>	
		
		
		
		<!--	<SCRIPT language="JavaScript1.2">-->
		<script language="JavaScript1.2" >
			var s_status=false;
			
			
			function chkstartdate(dayobj,monthobj,yearobj) {
				checkMonthLength(dayobj,monthobj,yearobj);		
			}
			
			function val_seccode()
			{
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities?chksql=sec_val&sec_code="+document.Form1.Text_sec_code.value;
				top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				if (m_size >0) {
					top.frames[0].document.applets[0].outvec_value.elementAt(0);				
				}			
				else
				{
					sec_help1(0)
				}
			}	
			
			//---Added by Prabash for prevent to enter existing entrys on 17-11-2011-----**
			function chkstartdate2(dayobj,monthobj,yearobj)
			{
				ToDD=dayobj.value;			
				ToMM=monthobj.value;
				ToYYYY=yearobj.value;
				
				ValDate= ToDD+"-"+ToMM+"-"+ToYYYY ;	
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities?chksql=sec_val2&sec_code="+document.Form1.Text_sec_code.value+"&vdate="+ValDate+"";		
				
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
				
				if (m_size >0) {
					alert(" Split Date already exist ");
					
					document.Form1.TXT_DATE_FROM.value=""
						document.Form1.TXT_MONTH_FROM.value=""
						document.Form1.TXT_YEAR_FROM.value=""	
				}			
				
			}	
			//-------------------------------------------------------------------------**
			/*function	sec_help1()
				{
								m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities?chksql=sec_help";
								top.frames[0].document.applets[0].getdata(m_url);
								m_size=top.frames[0].document.applets[0].outvec_value.size();
								vec_pos=0;
								m_row="";
								lineno=1;
									while (vec_pos<m_size) {
										m_acc_no=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
										minst=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
										m_row=m_row+'<TR STYLE="{color:black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white"  ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help_new(C1R'+lineno+',C2R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_acc_no+'</B></TD><TD ID=C2R'+	lineno+'><B>'+minst+'</B></TD></TR>';
										vec_pos=vec_pos+2;
										lineno=lineno+1;
										}
										m_writedata ='<TABLE BGCOLOR="gray" WIDTH="100%" STYLE="{color: darkblue; font: 9pt sans-serif;}">'+
										'<TR BGCOLOR="darkgray"><TD WIDTH="15%"><B>Security Code</B></TD><TD WIDTH="15%"><B>Instrument Type</B></TD>' +
										m_row+
										'</TABLE>'; 
								myDialogObj.htmlstr = m_writedata;
								myDialogObj.returnval = "";
								myDialogObj.returnval1 = "";
								popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
								document.Form1.Text_sec_code.value=myDialogObj.returnval
								document.Form1.Text_inst.value=myDialogObj.returnval1
								document.Form1.txt_bonus_shares.focus();
					}
			*/
			
			
			
			function myDialogObj() {
				var htmlstr; 
				var returnval;
				var returnval1;
			}
			
			function entry_mode(val){
				document.Form1.MOD.disabled=true;
				document.Form1.report_but.disabled=true;
				if(val=="new"){
					document.getElementById('div_lable').innerHTML='Share Spilt Entry - New'; 
					document.getElementById('div_add_split_new').style.display='inline';
					document.getElementById('div_del_split_new').style.display='none';
					document.getElementById('Hid_scr_name').value="split_new";
					
				}else if(val=="mod"){
					document.getElementById('div_lable').innerHTML='Share Spilt Entry - Edit'; 
					document.getElementById('div_add_split_new').style.display='inline';
					document.getElementById('div_del_split_new').style.display='none';
					document.getElementById('Hid_scr_name').value="mod";
				}else if(val=="del"){
					document.getElementById('div_lable').innerHTML='Share Spilt Entry - Delete'; 
					document.getElementById('div_add_split_new').style.display='none';
					document.getElementById('div_del_split_new').style.display='inline';
					document.getElementById('Hid_scr_name').value="split_del";
				}
				
			}
			function val_seccode()
			{
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities?chksql=sec_val&sec_code="+document.Form1.Text_sec_code.value;
				
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
				
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				if (m_size >0) {
					//top.frames[0].document.applets[0].outvec_value.elementAt(0);	
					data_vec[0];
				}			
				else
				{
					sec_help1(0)
				}
			}
			
			function	sec_help1(m_strat){
				
				var aForm;    //  aForm =oForm.elements;
				aForm =  document.getElementById('Form1');
				
				var myObject=new Array(); //return values set to this object
				myObject[0]=aForm.Text_sec_code;
				myObject[1]=aForm.Text_inst;
				myObject[2]=aForm.Text_sec_name;
				
				var myObject_value=new Array(); //passing values set to this object
				myObject_value[0]=aForm.Text_sec_code.value;
				myObject_value[1]=null;
				
				var myObject_type=new Array(); //passing values data type
				myObject_type[0]="StringL";
				myObject_type[1]=null;	
				
				var qid='27';
				
				var url = 'popup.jsp';
				var json_text = JSON.stringify(myObject_value, null,0);
				var json_obj_type_text=JSON.stringify(myObject_type, null,0);
				var fn_name=arguments.callee.name;
				if(fn_name==undefined){
					re = /^function\s+([^(]+)/;
					fn_name=re.exec(arguments.callee.toString())[1];
				}
				//JSON.parse(str) 
				//alert(json_text);
				$.showModalDialog({
						url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name,
						dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
						height:400, // 500,
						width: 500, //900,
						title: 'SasiNet Frame work',
						scrollable: true,
						
						onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);chkstartdate2(document.Form1.TXT_DATE_FROM,document.Form1.TXT_MONTH_FROM,document.Form1.TXT_YEAR_FROM);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
					});
			}
			
			function	sec_help2(m_strat){
				var aForm;    //  aForm =oForm.elements;
				aForm =  document.getElementById('Form1');
				
				var myObject=new Array(); //return values set to this object
				myObject[0]=aForm.Text_type;
				document.Form1.Text_type.disabled=true;
				myObject[1]=aForm.Text_sec_code2;
				document.Form1.Text_sec_code2.disabled=true;
				myObject[2]=aForm.Text_inst2;
				document.Form1.Text_inst2.disabled=true;	
				myObject[3]=aForm.TXT_DATE_FROM2;
				document.Form1.TXT_DATE_ENT.disabled=true;
				myObject[4]=aForm.TXT_DATE_ENT;
				document.Form1.TXT_DATE_FROM2.disabled=true;
				myObject[5]=aForm.Text_user;
				document.Form1.Text_user.disabled=true;
				myObject[6]=aForm.txt_bonus_shares2;
				document.Form1.txt_bonus_shares2.disabled=true;
				myObject[7]=aForm.txt_bonus_shares3;
				document.Form1.txt_bonus_shares3.disabled=true;
				
				
				
				var myObject_value=new Array(); //passing values set to this object
				//myObject_value[0]=null;
				myObject_value[0]=aForm.Text_sec_code2.value;//aForm.oLastName2.value;
				
				var myObject_type=new Array(); //passing values data type
				//myObject_type[0]=null;
				myObject_type[0]="StringL";
				myObject_type[1]=null;
				myObject_type[2]=null;
				myObject_type[3]=null;
				myObject_type[4]=null;
				myObject_type[5]=null;
				
				var qid='113';
				var hid='2';
				var url = 'popup.jsp';
				var json_text = JSON.stringify(myObject_value, null,0);
				var json_obj_type_text=JSON.stringify(myObject_type, null,0);
				var fn_name=arguments.callee.name;
				if(fn_name==undefined){
					re = /^function\s+([^(]+)/;
					fn_name=re.exec(arguments.callee.toString())[1];
				}
				//JSON.parse(str) 
				//alert(json_text);
				$.showModalDialog({
						url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&hid='+hid,
						dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
						height:400,// 600,
						width: 400,//900,
						title: 'SasiNet Frame work',
						scrollable: true,
						onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);	  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
					});
				
			}
			function beforesubmit(){
				
				
				
				if(document.Form1.Hid_scr_name.value=="split_new")
				{
					if(	(document.Form1.Text_sec_code.value=="")||(document.Form1.Text_inst.value== "")||(document.Form1.TXT_YEAR_FROM.value== ""))
					{ 
						alert("fill all the required data fields");
					}
					
					else
						Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsavcorporate";
					
					location.href='dn_share_spilt_entry.jsp'
						Form1.submit();
				}
				
				else if(document.Form1.Hid_scr_name.value=="split_del")
					//----------added by Prabash on 07-11-2011 -----
				{ 	if (document.Form1.Text_sec_code2.disabled=="")
					{
						alert("No selected Security for deletion")
					}
					else{
						//----------------------------------------------	 
						document.Form1.Text_type.disabled=false;
						document.Form1.Text_sec_code2.disabled=false;
						document.Form1.TXT_DATE_FROM2.disabled=false;
						document.Form1.TXT_DATE_ENT.disabled=false;
						document.Form1.Text_inst2.disabled=false;
						document.Form1.Text_user.disabled=false;
						Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsavcorporate";
						Form1.submit();
						
						
					}
				}
				else
					location.href='dn_share_spilt_entry.jsp'
			}
			
			function cancel(){
				if (document.Form1.Hid_scr_name.value=="split_new")
				{
					location.href='dn_share_spilt_entry.jsp'
				}
				else if (document.Form1.Hid_scr_name.value=="split_del")
				{
					
					document.Form1.Text_type.disabled=false;
					document.Form1.Text_type.value= ""
						document.Form1.Text_sec_code2.disabled=false;
					document.Form1.Text_sec_code2.value= ""
						document.Form1.Text_inst2.disabled=false;
					document.Form1.Text_inst2.value= ""
						document.Form1.TXT_DATE_ENT.disabled=false;
					document.Form1.TXT_DATE_ENT.value= ""
						document.Form1.TXT_DATE_FROM2.disabled=false;
					document.Form1.TXT_DATE_FROM2.value= ""
						document.Form1.Text_user.disabled=false;
					document.Form1.Text_user.value= ""
						document.Form1.bonus_shares2.disabled=false;
					document.Form1.bonus_shares2.value= ""
						document.Form1.bonus_shares3.disabled=false;
					document.Form1.bonus_shares3.value= ""
						
				}
				else
					location.href='dn_share_spilt_entry.jsp'
						
			}		
			//----------------------Calander---------------**
			$(document).ready
			(
				
				function() 
				{
					//initDialog();
					initCal('TXT_START_DATE');
					initCal('TXT_END_DATE');
					//initDialogPOPup();
				}
			);
			
			
			function initCal(m_id) {
				$('#' + m_id).datepicker({
						dateFormat: 'dd-mm-yy',
						duration: 'fast',
						yearRange: '1920:2050',
						showOn: 'button',
						buttonImage: '<%=m_jsp_client_url%>/SNET/images/calendar.gif',
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
				if (instance_id == "TXT_START_DATE") {
					document.Form1.TXT_DATE_FROM.value = splitResult[0];
					document.Form1.TXT_MONTH_FROM.value = splitResult[1];
					document.Form1.TXT_YEAR_FROM.value = splitResult[2];
					document.Form1.TXT_YEAR_FROM.focus();
				}
				else if (instance_id == "TXT_END_DATE") {
					document.Form1.TXT_RDATE_FROM.value = splitResult[0];
					document.Form1.TXT_RMONTH_FROM.value = splitResult[1];
					document.Form1.TXT_RYEAR_FROM.value = splitResult[2];
					document.Form1.TXT_RYEAR_FROM.focus();
				}
				
			}
			//-------------------------------------**
			
			/*	
				function Shares_ck_number() //function added by Prabash on 07-11-2011
				{
					
					Sh_val=document.Form1.txt_bonus_shares.value;
					
					m_format=Sh_val.toString();
					
				for (var i = 0; i < m_format.length; i++)	{
				var oneChar = m_format.charAt(i)
				
				if (isNaN(oneChar)) {
					alert("You have typed an incorrect charactor as a number.");
					document.Form1.txt_bonus_shares.value="";
					document.Form1.txt_bonus_shares.focus();
					return oneChar
						
				}
				
			}
					
				}
					
						
				
				function no_of_Shares_ck() //function added by Prabash on 07-11-2011
				{
					Sh_val=document.Form1.txt_bonus_shares1.value;
					
				m_format=Sh_val.toString();
					
				for (var i = 0; i < m_format.length; i++)	{
				var oneChar = m_format.charAt(i)
				
				if (isNaN(oneChar)) {
					alert("You have typed an incorrect charactor as a number.");
					document.Form1.txt_bonus_shares1.value="";
					document.Form1.txt_bonus_shares1.focus();
					return oneChar
						
				}
				
			}
					
				}
			*/	
			//added by Prabash on 07-11-2011-------**	
			function Shares_ck_number()
			{
				var txtname = document.Form1.txt_bonus_shares;
				Sh_val  = document.Form1.txt_bonus_shares.value;
				m_format=Sh_val.toString();
				chacknumber(m_format,txtname);
				
			}
			
			function no_of_Shares_ck()
			{
				var txtname = document.Form1.txt_bonus_shares1;
				Sh_val  = document.Form1.txt_bonus_shares1.value;
				m_format=Sh_val.toString();
				chacknumber(m_format,txtname);
				
			}
			//-------------------------------------**	
			
		</SCRIPT>
	</HEAD>		
	<BODY class="body & txt-body" ONLOAD="entry_mode('new')" >
		<FORM NAME="Form1" ID="Form1" METHOD="POST" >
			<INPUT TYPE="Hidden" NAME="Hid_scr_name" ID="Hid_scr_name"	VALUE="split_new">
			<!---------------------------------->				
			<DIV>
				<TABLE class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
					<tr>
						<td height='7'></td>
					</tr>
					
					<tr height='30' >
						<td  width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
						<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'> <B> Margin Trading - Corporate Actions</B></td>
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
						<!--------------------------------------------------------------->				
						
						
						
						
						<!--------------------------------------------------------------->				
						<TABLE WIDTH="100%" BGCOLOR="darkblue" >
							<TR >
								<TD WIDTH="6%">	
									<INPUT TYPE="Button" NAME="NEW" VALUE="Add"   onClick="entry_mode('new')"  class="mainbut"  >
								</TD>
								
								<TD WIDTH="6%">	
									<INPUT TYPE="Button" NAME="MOD" VALUE="Edit" onClick="entry_mode('mod')  " class="mainbut"  >
								</TD>
								
								<TD WIDTH="6%">	
									<INPUT TYPE="Button" NAME="DEL" VALUE="Delete"   onClick= "entry_mode('del')"  class="mainbut"  >
								</TD>				
								
								<TD WIDTH='6%'></TD>	
								
								<TD WIDTH="6%">	
									<INPUT TYPE="Button" NAME="save_but" VALUE="Save"   onClick="beforesubmit()" class="mainbut"  >
								</TD>
								
								<TD WIDTH="6%">
									<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"   onClick="cancel()"  class="mainbut"> 
								</TD>
								
								<TD WIDTH="6%">
									<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit"   onClick="location.href='low.jsp'" class="mainbut"> 
								</TD>
								
								<TD WIDTH="6%">
									<INPUT TYPE="Button" NAME="report_but" VALUE="Enquiry"    onClick="obtain_report_before()" class="mainbut">
								</TD>
								<!--<TD  WIDTH="50%" class="hh1" align="right">-->
								<!--<B>	Share Spilt Entry</B>-->
								<TD> <B><div id='div_lable' align='right' > </div> </B> </TD>
							</TD>
							
						</TR>
					</TABLE>
					<!--------------------------------------------------------------->	
					
					<!-------------------------------->
					<TABLE WIDTH="100%"  >
						<tr height='25px;'></tr>
					</TABLE>
					<HR>
					<TABLE WIDTH="100%"  >
						<tr height='25px;'></tr>
					</TABLE>
					<!-------------------------------->		
					
					<div id="div_add_split_new">
						
						<table width="100%" border="0" cellpadding="1" cellspacing="0" >
							<TR>
								<TD WIDTH="1%"></TD>
								<td style = "width: 150px;">Security Code</TD>
								<TD style = "width: 100px;" ><INPUT TYPE="Text" NAME="Text_sec_code"	ALIGN="LEFT" class="txt_input6"  style = "width: 125px;" SIZE="15" onBlur="val_seccode()">
									<INPUT TYPE="BUTTON" NAME="sec_help" ONCLICK="sec_help1(0)" class="mainbut"  value="..."></TD>			
								
								<TD WIDTH="1%"></TD>
								<td style = "width: 100px;">Security Name</TD>
								<TD WIDTH="15%"><INPUT TYPE="Text" NAME="Text_sec_name"	ALIGN="LEFT" class = "txt_input" SIZE="30" style = "width: 250px;" disabled = "disabled" onBlur="val_seccode()">
								</TD>							
								<td style = "width: 60px;">
								</TR>
								
								<TR>
									<TD WIDTH="1%"></TD>
									<td style = "width: 150px;">Instrument Code</TD>
									<TD ><INPUT TYPE="Text" NAME="Text_inst" class = "txt_input"	 style = "width: 125px;"  ALIGN="LEFT" SIZE="15" ></TD>					
									<TR>
										
										<TR>
											<TD WIDTH="1%"></TD>
											<td style = "width: 150px;">Comment</TD>
											
											<TD style = "width: 300px;"><INPUT TYPE="Text" NAME="Text_comment" style = "width: 300px;"	ALIGN="LEFT" SIZE="50" ></TD>					
										</TR>
										
										
										
										<TR>	<TD WIDTH="1%"></TD>					
											<td style = "width: 150px;">Split Ratio </TD>
											<TD style = "width: 30px;" ><INPUT TYPE="Text" NAME="txt_bonus_shares" id ="txt_bonus_shares" class="txt_input5" value="0"  SIZE=5 onBlur= "Shares_ck_number()" > 				
												No of  Shares Change to
												
												<INPUT TYPE="Text" NAME="txt_bonus_shares1" class="txt_input5" value="0"  SIZE=5 onBlur= "no_of_Shares_ck()" > 
												No of Shares</TD>
											
											<td style = "width: 60px;">
											</TR>	
											
											<TR>	
												<TD WIDTH="1%"></TD>
												<td style = "width: 150px;">Split Date</TD> 
												<TD><INPUT TYPE="Text" NAME="TXT_DATE_FROM"  class="txt_input5" SIZE="3" MAXLENGTH="2">
													<INPUT 	   TYPE="Text" NAME="TXT_MONTH_FROM" class="txt_input5" SIZE="3" MAXLENGTH="2">
													<INPUT 	   TYPE="Text" NAME="TXT_YEAR_FROM"  class="txt_input5" SIZE="5" MAXLENGTH="4" ONBLUR="chkstartdate(document.Form1.TXT_DATE_FROM,document.Form1.TXT_MONTH_FROM,document.Form1.TXT_YEAR_FROM);chkstartdate2(document.Form1.TXT_DATE_FROM,document.Form1.TXT_MONTH_FROM,document.Form1.TXT_YEAR_FROM);"> 								
													<input type = "hidden" name = "TXT_START_DATE" id = "TXT_START_DATE" />
												</TD> 
											</TR>
											
										</TABLE>
										
									</table>
									
								</div>
								
								
								
								<div id="div_del_split_new">
									
									<table width="100%" border="0" cellpadding="1" cellspacing="0" >					
										<TR>
											<TD WIDTH="1%"></TD>
											<td style = "width: 150px;">Security Code</TD>
											<TD  ><INPUT TYPE="Text" NAME="Text_sec_code2" class = "txt_input"	ALIGN="LEFT" SIZE="15" >
												<INPUT TYPE="BUTTON" NAME="sec_help" ONCLICK="sec_help2(0)" class="mainbut"  value="..."></TD>
										</TR>
										
										<TR>
											<TD WIDTH="1%"></TD>
											<td style = "width: 150px;">Instrument Code</TD>
											<TD  ><INPUT TYPE="Text" NAME="Text_inst2" class = "txt_input"	ALIGN="LEFT" SIZE="15" ></TD>
										</TR>
										
										
										
										<table width="100%" border="0" cellpadding="1" cellspacing="0" >	
											
											<TR>
												<TR>	<TD WIDTH="1%"></TD>					
													<td style = "width: 150px;">Split Ratio </TD>					
													<TD ><INPUT TYPE="Text" NAME="txt_bonus_shares2" id ="txt_bonus_shares" class="txt_input5" value="0"  SIZE=5 onBlur= "Shares_ck_number()" > 
														No of  Shares Change to
														
														<INPUT TYPE="Text" NAME="txt_bonus_shares3" class="txt_input5" value="0"  SIZE=5 onBlur= "no_of_Shares_ck()" > 	
														No of Shares</TD>
													
													<TD WIDTH="30%"></TD>
												</TR>	
												
												
											</table>		
											<table width="100%" border="0" cellpadding="1" cellspacing="0" >							
												
												<TR>	
													<TD WIDTH="1%"></TD>
													<td style = "width: 150px;">Split Date</TD>
													<TD ><INPUT TYPE="Text" class = "txt_input" NAME="TXT_DATE_FROM2" SIZE=15 >
													</TD>
												</TR>
												
												<TR>
													<TD WIDTH="1%"></TD>
													<td style = "width: 150px;"> &nbsp</TD>
												</TR>						
												
												<TR>
													<TD WIDTH="1%"></TD>
													<td style = "width: 150px;"> Type Of Activity</TD>
													<TD ><INPUT TYPE="Text" NAME="Text_type" class = "txt_input"	ALIGN="LEFT" SIZE="15" ></TD>
												</TR>
												
												
												<TR>	
													<TD WIDTH="1%"></TD>
													<td style = "width: 150px;">Entered Date</TD> 
													<TD ><INPUT TYPE="Text" class = "txt_input" NAME="TXT_DATE_ENT" SIZE=15 >
													</TD> 
												</TR>
												
												<TR>
													<TD WIDTH="1%"></TD>
													<td style = "width: 150px;">User Name Code</TD>
													<TD  ><INPUT TYPE="Text" NAME="Text_user" class = "txt_input"	ALIGN="LEFT" SIZE="15">
													</TR>
												</TABLE> 									
											</div>	
											
										</TABLE>
									</TABLE>							
								</FORM>
							</body>	
							<DIV>
								<SCRIPT language="JavaScript1.2" src="validate.js"></SCRIPT>
								<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
							</DIV>
							
						</html>	
						
						
						
