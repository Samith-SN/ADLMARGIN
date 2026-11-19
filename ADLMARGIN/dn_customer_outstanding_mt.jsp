<%@page import="net.sasianet.ADLMARGIN.*" %>
<%	
	
	ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
	String m_jsp_client_url=m_sn_methods.jsp_client_url;
	String current_user=m_sn_methods.username; 
	
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
	
	
	
%>


<HTML>
	<HEAD>
		<TITLE>MFactor</TITLE>
		
	</HEAD>   
	<SCRIPT language="JavaScript"> 	     
		var m_sql = "";
		var m_criteria="";
		var m_curr_help="";
		var m_valid=true;
		
		function myDialogObj() {
			var htmlstr; 
			var returnval;
		}
		
		
		function chkstartdate(dayobj,monthobj,yearobj) {
			checkMonthLength(dayobj,monthobj,yearobj);		
		}
		
		
		function displaydata(){  
			//CURRENCY
			sclient  = new String(document.Form1.TXT_CLIENT.value);	
			
			if ((sclient.length == 0)||(sclient == " ")){
				sclient="ALL";
			}
			
			//if(((document.Form1.TXT_DATE_FROM.value)&&(document.Form1.TXT_MONTH_FROM.value)&&(document.Form1.TXT_YEAR_FROM.value))!=""){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"cus_outstanding_rep_MT?client="+sclient.toUpperCase()+"&chksql=Customer_outstanding";
			//alert(m_url);
			popupwin2 = window.open(m_url,'displayWindow2','left=0,top=133,width=799,height=380,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
			popupwin2.focus();
			/*
			}
			else{
			alert("Please Enter the Date");
			}
			*/
			
			
			
		} 
		/**
		//-----
				function Client_help() {
						document.Form1.hid_help_type.value="1";
						m_sql = "m_clientsql";
						m_criteria = document.Form1.TXT_CLIENT.value+"@";
						m_curr_help=document.Form1.TXT_CLIENT;
						HelpBox('1','10','0');
					}	
					
					function myDialogObj() {
								var htmlstr;
								var returnval;
					}	
								
								
								
					// ----------------------------the function create the Scrip objects-------------------------//
								
					function MyDialog(){
								this.valout   = new Array(10);
					}			
							
					//----------------This Function Is to get The Help Box------------------------------//
					
					function HelpBox(Start,End,Hid_No) {
								oBj = new MyDialog();
								oBj.valout[1]  = " ";
								oBj.valout[2]  = " ";
								oBj.valout[3]  = " ";					
								popupwin = window.showModalDialog(""+servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_Help_Servlet?class_in=mbfsl_help_select"+
								"&Sql_in="+m_sql+"&Start_in="+Start+
								"&End_in="+End+"&Crit_In="+m_criteria+
								"&Hid_No="+Hid_No+"", oBj,"dialogWidth:25em; dialogHeight:18em; center:yes; status:no");
								
								if((oBj.valout[1]!="Prev") && (oBj.valout[1]!="Next") && (oBj.valout[2]!=" ") && (oBj.valout[2]!=null)){
									if (document.Form1.hid_help_type.value=="1") {
										asign_client();
									}
								}
								
								if(oBj.valout[1]=='Next')  {
									Next(oBj.valout[2],oBj.valout[3],Hid_No);
									return false;
								}
								
								else if  (oBj.valout[1]=='Prev') {
									Prev(oBj.valout[2],oBj.valout[3],Hid_No);
								}	
								
								else if(((oBj.valout[1] == 'Close') || (oBj.valout[2]==" ") || (oBj.valout[2]==null)) && m_valid==false)  {
									m_curr_help.value="";
									m_valid=true;
									m_curr_help.focus();
								}
					}	
								
								
					function Prev(Start,End,Hid_No){
								HelpBox(Start,End,Hid_No)
					}
								
					function Next (Start,End,Hid_No){
								HelpBox(Start,End,Hid_No)
					}
								
								//-----------------------asigning returned data-----------------//
								
					function asign_client() {
								m_valid=true;
								document.Form1.TXT_CLIENT.value=oBj.valout[2];
								//document.Form1.Text_client_name.value=oBj.valout[3];
								document.Form1.TXT_CLIENT.focus();
					}
					
		.
		//-------
		
		/** function getdata(){
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"boffice_reports_clc?client_data="+document.Form1.TXT_CLIENT.value+"&chksql=clc_data";
					alert("OK");
			}	*/
		
		
		
		function Client_help(){
			
			
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_reports_TransactionLst?chksql=portfolio_help&portfolio_code="+document.Form1.TXT_CLIENT.value;
			//boffice_reports_clc_1?client_data="+document.Form1.TXT_CLIENT.value+"&chksql=clc_data";
			top.frames[0].document.applets[0].getdata(m_url);
			
			m_size=top.frames[0].document.applets[0].outvec_value.size();
			//alert(top.frames[0].document.applets[0].outvec_value);
			vec_pos=0;
			m_row="";
			lineno=1;
			while (vec_pos <m_size) {
				
				m_port=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
				m_Des=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
				m_CDS=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2);
				m_row=m_row+'<TR STYLE="{color:black; cursor:hand font: bold 9pt Arial;}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+lineno+'>'+
					'<B>'+m_port+'</B></TD><TD ID=C2R'+lineno+'><B>'+m_Des+'</B></TD><TD ID=C2R'+lineno+'><B>'+m_CDS+'</B></TD></TR>';
				vec_pos=vec_pos+3;
				lineno=lineno+1;
			}
			
			m_writedata ='<TABLE BGCOLOR="gray" WIDTH="100%" STYLE="{color:black; font: bold 9pt Arial;}">'+
				'<TR BGCOLOR="silver"><TD WIDTH="25%"><B>Portfolio Code</B></TD>' +
				'<TD WIDTH="50%"><B>Name</B></TD><TD WIDTH="25%"><B>CDS No.</B></TD></TR>'+m_row+
				'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval = "";
			popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:21em; dialogHeight:15em; center:yes; resizable:yes; status:no");
			document.Form1.TXT_CLIENT.value=myDialogObj.returnval;
			document.Form1.TXT_CLIENT.focus();
		}
		
		<!--ADDED BY ASHINI HEWAGE ON 24-05-2005 FOR SR 0506-047-->	
		
		function portcheck(objx){ // to check the portfolio code
			if (objx.value!="") {
				
				m_portcode=objx.value;
				m_url=servlet_client_url+':'+client_t3_port+"/"+client_name+"mbfsl_reports_TransactionLst?port_code="+m_portcode.toUpperCase()+"&chksql=port_lookup";
				top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				if (m_size==0) {
					CRClient_help(objx);
					objx.focus();
				}
			}
		}
		
		function CRClient_help(obj1){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_reports_TransactionLst?chksql=crportfolio_help&crportfolio_code="+document.Form1.TXT_CRCLIENT.value;
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
			vec_pos=0;
			m_row="";
			lineno=1;
			while (vec_pos <m_size) {
				m_port=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
				m_Des=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
				m_CDS=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2);
				m_row=m_row+'<TR STYLE="{color:black; cursor:hand font: bold 9pt Arial;}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+lineno+'>'+
					'<B>'+m_port+'</B></TD><TD ID=C2R'+lineno+'><B>'+m_Des+'</B></TD><TD ID=C2R'+lineno+'><B>'+m_CDS+'</B></TD></TR>';
				vec_pos=vec_pos+3;
				lineno=lineno+1;
			}
			m_writedata ='<TABLE BGCOLOR="gray" WIDTH="100%" STYLE="{color:black; font: bold 9pt Arial;}">'+
				'<TR BGCOLOR="silver"><TD WIDTH="25%"><B>CR-Portfolio Code</B></TD>' +
				'<TD WIDTH="75%"><B>Name</B></TD><TD WIDTH="75%"><B>CDS No.</B></TD></TR>'+m_row+
				'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval = "";
			popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:21em; dialogHeight:15em; center:yes; resizable:yes; status:no");
			document.Form1.TXT_CRCLIENT.value=myDialogObj.returnval;
			document.Form1.TXT_CRCLIENT.focus();
		}
		
		
		
		
		function displaycrdata(){  
			sclient  = new String(document.Form1.TXT_CRCLIENT.value);	
			if ((sclient.length == 0)||(sclient == " ")){
				sclient="ALL";
			}
			//	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"cus_outstanding_rep_MT?client="+sclient.toUpperCase()+"&chksql=Customer_outstanding";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"cus_outstanding_rep_MT?client="+sclient.toUpperCase()+"&chksql=CRCustomer_outstanding";
			//	alert(m_url);
			popupwin2 = window.open(m_url,'displayWindow2','left=0,top=133,width=799,height=380,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
			popupwin2.focus();
		} 
		
		
		<!--END MODIFICATIONS DONE ON 24-05-2005 FOR SR 0506-047-->		        
		
		
		
		<!--ADDED BY AH ON 06/10/2005 FOR SR0510-017------------------>	
		function displaydbdata(){
			//ChkDateValidation(document.Form1.TXT_DATE_FROM,document.Form1.TXT_MONTH_FROM,document.Form1.TXT_YEAR_FROM)
			//if(document.Form1.TXT_DATE_FROM.value!="" || document.Form1.TXT_MONTH_FROM.value!="" || document.Form1.TXT_YEAR_FROM.value!="") {
			
			//m_date=document.Form1.TXT_DATE_FROM.value+"-"+document.Form1.TXT_MONTH_FROM.value+"-"+document.Form1.TXT_YEAR_FROM.value;
			sclient  = new String(document.Form1.TXT_CRCLIENT.value);	
			if ((sclient.length == 0)||(sclient == " ")){
				sclient="ALL";
			}
			//	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"cus_outstanding_rep_MT?client="+sclient.toUpperCase()+"&chksql=Customer_outstanding";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_db?client="+sclient.toUpperCase()+"&chksql=mrep_data2";
			//alert(m_url);
			popupwin2 = window.open(m_url,'displayWindow2','left=0,top=133,width=799,height=380,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
			popupwin2.focus();
			//}		
			
		}
		
		<!--END MOIFICATION DONE BY AH ON 06/10/2005 FOR SR0510-017 -->	
		
		//CURRENCY
		function getcurrency(){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_reports_TransactionLst?chksql=getcurr";
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
			vec_pos=0;
			while(m_size>vec_pos){
				document.Form1.SEL_CURRENCY.options[document.Form1.SEL_CURRENCY.length]=new Option(top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1),top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos));
				vec_pos+=2;
			}
			
		}
		/*onload="getcurrency()"*/
		
		
		
		function  exit()
		{
			window.location.href='<%=m_jsp_client_url%>/low.jsp';
			
		}
		function  cancel()
		{
			window.location.href='<%=m_jsp_client_url%>/dn_customer_outstanding_mt.jsp';
			
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
			myObject_value[1]=aForm.TXT_CLIENT.value;//aForm.Text_loc_code.value;
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
			
			
			var qid=89;
			
			//help_scr_type=document.Form1.SCR_TYPE;//2011-09-27
			
			
			title_name='Facility';
			var url = 'popup.jsp';
			var close_fun='facility_help_close';			
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
							Client_help_close();
						} 
					} //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
		}
		
		function Client_help_close()
		{
			document.Form1.TXT_CLIENT.value="";	
		}
		
		
		
		function CRClient_help(m_strat)
		{
			var aForm;    //  aForm =oForm.elements;
			aForm =  document.getElementById('Form1');
			
			var myObject=new Array(); //return values set to this object
			myObject[0]=aForm.TXT_CRCLIENT; //2011-09-27
			//myObject[1]=aForm.Text_loc_desc;;
			myObject[1]=null;
			myObject[2]=null;
			myObject[3]=null;
			myObject[4]=null;
			
			var myObject_value=new Array(); //passing values set to this object
			//myObject_value[0]=aForm.TXT_UNAME.value; //2011-09-27
			myObject_value[0]=aForm.TXT_CRCLIENT.value; //2011-09-27
			myObject_value[1]=aForm.TXT_CRCLIENT.value;//aForm.Text_loc_code.value;
			myObject_value[2]=aForm.TXT_CRCLIENT.value;
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
			
			var qid=90;
			
			//help_scr_type=document.Form1.SCR_TYPE;//2011-09-27
			
			
			title_name='Facility';
			var url = 'popup.jsp';
			var close_fun='facility_help_close';			
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
							CRClient_help_close();
						} 
					} //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
		}
		
		function CRClient_help_close()
		{
			document.Form1.TXT_CRCLIENT.value="";	
		}
		
		
		
	</SCRIPT>
	<BODY>
		<FORM NAME="Form1" id="Form1" METHOD="POST" >
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="reveryfication">
			<INPUT TYPE="Hidden" NAME="hid_help_type" ALIGN="RIGHT" SIZE=2 >	
			<TABLE WidTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0" STYLE="{color: black; font: bold 9pt arial;}">							
				<TD WidTH="1%">
					<TD WidTH="99%">
						<table width="100%">
							<tr>
								<td>		
									<table class='table' align='left' width="99%" border="0" cellpadding="0" cellspacing="0" >
										<!-- <table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 	-->
										<tr>
											<td height='7'></td>
										</tr>
										<tr height="30">		
											<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
											<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Management Information - Margin Trading OutStanding</B></td>
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
									<TABLE WIDTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0" >
										<TR><BR></TR>
										<TR>
											<TD WIDTH="10%">Facility Code</TD> 
											<TD WIDTH="15%">
												<INPUT TYPE="Text" class="txt_input6" NAME="TXT_CLIENT" SIZE=10  >
												<INPUT TYPE="BUTTON" class="mainbut" NAME="but_CLIENT" value="Help" ONCLICK="Client_help(0)"> 								
											</TD> 
											<TD WIDTH="10%" align="absmiddle">
												<INPUT TYPE="BUTTON" class="mainbut" NAME="but_CLIENT" value="Go" ONCLICK="displaydata()"> 								
												
											<TD WIDTH="10%">Facility Code</TD> 
											<TD WIDTH="15%">
													<INPUT TYPE="Text" class="txt_input6" NAME="TXT_CRCLIENT" ONBLUR="portcheck(document.Form1.TXT_CRCLIENT)" SIZE=10  >
												    <INPUT TYPE="BUTTON" class="mainbut" NAME="but_CRCLIENT" value="Help" ONCLICK="CRClient_help(0)"><!-- CRClient_help(document.Form1.TXT_CRCLIENT) --> 								
											</TD>	
											<TD WIDTH="10%">
												<INPUT TYPE="BUTTON" class="mainbut" NAME="but_DISPLAY" value=" CR CLIENTS  "  style="width:100px" ONCLICK="displaycrdata()"> 								
											</TD>
										</TR>
											
										<tr>
										<td width="10%">
											
										</td> 
										<td width="10%">
										</td> 			
										<td width="10%">
										</td> 			
										<td width="10%">
										</td> 			
										<td width="10%">
										</td> 			
										<td width="10%">
											<INPUT TYPE="BUTTON" class="mainbut" NAME="but_DB_DISPLAY" style="width:100px" value=" DB CLIENTS  "  ONCLICK="displaydbdata()"> 									
										</td> 
										</tr>		
									</TABLE>
								</td>
							</tr>	
							
							
						
							
							<tr>
								<td>
									<TABLE width="100%" BORDER="0" CELLPADDING="2" CELLSPACING="1" STYLE="{color: black; font: 10pt sans-serif;}">
									</TABLE>
								</td>
							</tr>	
							<tr>
								<td>
									<INPUT TYPE="Hidden" NAME="Hid_rows" >
									<DIV id=clientmgr></DIV>
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
	</DIV>
</html>

