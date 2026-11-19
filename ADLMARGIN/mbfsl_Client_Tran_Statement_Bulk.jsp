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
		
	</HEAD>   
	<SCRIPT language="JavaScript"> 	     
		//added by inditha 8-9-2004/13:18 SRF:0409-012 CLIENT PORTFOLIO POSITION
		$(document).ready(function() {
				
				initCal('FROM_TXT_DATE');
				initCal('TO_TXT_DATE');
				// initCal('CHEQUE_REALIZATION_TXT_DATE');
				// loadGridPaymentsPrint();
				//initmsgDrillDialog();
				// initmsgDrillEnq(getW,150);	
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
				document.Form1.TXT_DATE.value = splitResult[0];
				document.Form1.TXT_MONTH.value = splitResult[1];
				document.Form1.TXT_YEAR.value = splitResult[2];
				document.Form1.TXT_YEAR.focus();
			}
			else if (instance_id == "TO_TXT_DATE") {
				document.Form1.TXT_TODATE.value = splitResult[0];
				document.Form1.TXT_TOMONTH.value = splitResult[1];
				document.Form1.TXT_TOYEAR.value = splitResult[2];
				document.Form1.TXT_TOYEAR.focus();
			}/*else if (instance_id == "CHEQUE_REALIZATION_TXT_DATE") {
				document.Form1.CHEQUE_REALIZATION_TXT_DAY.value = splitResult[0];
				document.Form1.CHEQUE_REALIZATION_TXT_MONTH.value = splitResult[1];
				document.Form1.CHEQUE_REALIZATION_TXT_YEAR.value = splitResult[2];
				document.Form1.CHEQUE_REALIZATION_TXT_YEAR.focus();
			}*/
			
		}
		
		function myDialogObj() {
			var htmlstr; 
			var returnval;
		}
		
		function Client_help(){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Client_Transction_Statement_Bulk_rpts?chksql=portfolio_help&portfolio_code="+document.Form1.TXT_PORT.value;
			//window.open(m_url);
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
			vec_pos=0;
			m_row="";
			lineno=1;
			while (vec_pos <m_size) {
				
				m_port=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
				m_Des=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
				m_cds=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2);
				m_row=m_row+'<TR STYLE="{color:black; cursor:hand font: bold 9pt Arial;}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+lineno+'>'+
					'<B>'+m_port+'</B></TD><TD ID=C2R'+lineno+'><B>'+m_Des+'</B></TD></TD><TD ID=C2R'+lineno+'><B>'+m_cds+'</B></TD></TR>';
				vec_pos=vec_pos+3;
				lineno=lineno+1;
			}
			
			m_writedata ='<TABLE BGCOLOR="gray" WIDTH="100%" STYLE="{color:black; font: bold 9pt Arial;}">'+
				'<TR BGCOLOR="silver"><TD WIDTH="25%"><B>Facility No </B></TD>' +
				'<TD WIDTH="50%"><B>Name</B></TD><TD WIDTH="25%"><B>CDS No.</B></TD></TR>'+m_row+
				'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval = "";
			popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:21em; dialogHeight:15em; center:yes; resizable:yes; status:no");
			document.Form1.TXT_PORT.value=myDialogObj.returnval;
			document.Form1.TXT_PORT.focus();
		}
		
		function chk_validity(){
			if((parseInt(document.Form1.TXT_DATE_FROM.value))>=(parseInt(document.Form1.TXT_DATE_TO.value))){
				if((parseInt(document.Form1.TXT_MONTH_FROM.value))<=(parseInt(document.Form1.TXT_MONTH_TO.value))){
					if((parseInt(document.Form1.TXT_YEAR_FROM.value))<=(parseInt(document.Form1.TXT_YEAR_TO.value))){
						if(((parseInt(document.Form1.TXT_DATE_FROM.value))==(parseInt(document.Form1.TXT_DATE_TO.value)))&&
								((parseInt(document.Form1.TXT_MONTH_FROM.value))==(parseInt(document.Form1.TXT_MONTH_TO.value)))&&
								((parseInt(document.Form1.TXT_YEAR_FROM.value))==(parseInt(document.Form1.TXT_YEAR_TO.value)))){
								}
						else if(((parseInt(document.Form1.TXT_DATE_FROM.value))>(parseInt(document.Form1.TXT_DATE_TO.value)))&&
								((parseInt(document.Form1.TXT_MONTH_FROM.value))==(parseInt(document.Form1.TXT_MONTH_TO.value)))&&
								((parseInt(document.Form1.TXT_YEAR_FROM.value))==(parseInt(document.Form1.TXT_YEAR_TO.value)))){
									alert("'To Date' should be greater than 'From Date'");
								}
					}
					else{
						alert("'To Date' should be greater than 'From Date'");
					}
				}
				else{
					if((parseInt(document.Form1.TXT_YEAR_FROM.value))>=(parseInt(document.Form1.TXT_YEAR_TO.value))){
						alert("'To Date' should be greater than 'From Date'");
					}
					else{
					}	
				}
			}
			else{
				if((parseInt(document.Form1.TXT_MONTH_FROM.value))<=(parseInt(document.Form1.TXT_MONTH_TO.value))){
					if((document.Form1.TXT_YEAR_FROM.value)<=(document.Form1.TXT_YEAR_TO.value)){
					}
					else{
						alert("'To Date' should be greater than 'From Date'");
					}
				}
				else{
					if((parseInt(document.Form1.TXT_YEAR_FROM.value))<(parseInt(document.Form1.TXT_YEAR_TO.value))){
					}
					else{
						alert("'To Date' should be greater than 'From Date'");
					}
				}
			}
		}
		
		
		function chk_port(){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Client_Transction_Statement_Bulk_rpts?chksql=chk_port&port="+document.Form1.TXT_PORT.value;
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
			if(m_size>0){
			}
			else{
				if(confirm("Invalid Facility No .Press OK to get the Help")){
					Client_help();
				}
				else{
					document.Form1.TXT_PORT.value="";
				}	
			}
		}
		
		function help_port(){
			document.Form1.hid_help_type.value="1";
			m_sql = "m_client_portfolio_pos";
			m_criteria = document.Form1.TXT_PORT.value+"@";
			HelpBox('1','10','0');
		}
		
		function MyDialog(){
			this.valout   = new Array(10);
		}		
		
		function HelpBox(Start,End,Hid_No) {
			oBj = new MyDialog();
			oBj.valout[1]  = " ";
			oBj.valout[2]  = " ";
			oBj.valout[3]  = " ";
			
			popupwin = window.showModalDialog(""+servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_fund_Help_Servlet?class_in="+client_name+"mbfsl_fund_help_select"+
				"&Sql_in="+m_sql+"&Start_in="+Start+
					"&End_in="+End+"&Crit_In="+m_criteria+
					"&Hid_No="+Hid_No+"", oBj,"dialogWidth:25em; dialogHeight:18em; center:yes; status:no");
			
			
			
			
			if(document.Form1.hid_help_type.value=="1"){
				if(oBj.valout[1] !=" "){
					if(oBj.valout[1] !='Close'){
						if(oBj.valout[1]!="Prev"){
							if(oBj.valout[1]!="Next"){
								// alert("uu");
								asign_port_code();
							}
							else{
								Next(oBj.valout[2],oBj.valout[3],Hid_No);
								return false;
							} 
						}
						else{	
							Prev(oBj.valout[2],oBj.valout[3],Hid_No);
						}	
					}		
					else{		
						document.Form1.TXT_PORT.value="";	
					}		
				}
				else{		
					document.Form1.TXT_PORT.value="";	
				}		
			}
			
		}
		
		function Prev(Start,End,Hid_No){
			HelpBox(Start,End,Hid_No)
		}
		function Next (Start,End,Hid_No){
			HelpBox(Start,End,Hid_No)
		}
		
		function asign_port_code() {	
			document.Form1.TXT_PORT.value=oBj.valout[2];
		}
		
		function chkstartdate(dayobj,monthobj,yearobj) {
			checkMonthLength(dayobj,monthobj,yearobj);		
		}
		
		function displaydata(){ 
			//if(document.Form1.TXT_PORT.value!=""){
			if(((document.Form1.TXT_DATE.value!="")&&(document.Form1.TXT_MONTH.value!="")&&(document.Form1.TXT_YEAR.value)!="")
					&& ((document.Form1.TXT_TODATE.value!="")&&(document.Form1.TXT_TOMONTH.value!="")&&(document.Form1.TXT_TOYEAR.value)!="")
				){
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Client_Transction_Statement_Bulk_rpts?mdate_from="+document.Form1.TXT_DATE.value+'-'+document.Form1.TXT_MONTH.value+'-'+document.Form1.TXT_YEAR.value+"&mdate_to="+document.Form1.TXT_TODATE.value+'-'+document.Form1.TXT_TOMONTH.value+'-'+document.Form1.TXT_TOYEAR.value+"&chksql=display_report";//&client="+document.Form1.TXT_PORT.value.toUpperCase()+"
					popupwin2 = window.open(m_url,'displayWindow2','left=0,top=133,width=799,height=380,toolbar=0,location=0,directories=0,status=1,menuBar=1,scrollBars=1,resizable=1');
					popupwin2.focus();
				}
			else{
				alert("Please Enter the Date");
			}
			/* }
			else{
							alert("Please Enter the Facility No ");
			}*/
		} 
		
		
		function clearAll()
		{
			top.frames[1].location.href = jsp_client_url + "/mbfsl_Client_Tran_Statement_Bulk.jsp";
		}		
		
		
	</SCRIPT>
	<BODY class='body & txt-body'>
		<FORM NAME="Form1" METHOD="POST" >
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="">
			<INPUT TYPE="Hidden" NAME="hid_help_type"	VALUE="">
			
			
			<DIV>
				<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
					<tr>
						<td height='7'></td>
					</tr>
					
					<tr height='30' >
						<td  width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
						<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Margin Trading - Client Statement Bulk</B></td>
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
						<!--<INPUT TYPE="Button" NAME="NEW" VALUE="Add&nbsp; "   onClick="display_sec_opt('new');"  class="mainbut"  >-->
					</TD>
						<TD WIDTH="6%">	
						<!--<INPUT TYPE="Button" NAME="MOD" VALUE="Modify&nbsp; "   onClick="display_sec_opt('mod');" class="mainbut"  >-->
					</TD>
						<TD WIDTH="6%">	
						<!--<INPUT TYPE="Button" NAME="DEL" VALUE="Delete&nbsp; "   onClick="display_sec_opt('del');"  class="mainbut"  >-->
					</TD>
						<TD WIDTH='6%'></TD>		
						<!---------------------------------->
						<TD WIDTH="6%">	
						<!--<INPUT TYPE="Button" NAME="save_but" VALUE="Save&nbsp; "   onClick="BeforeSave()" class="mainbut"  >-->
					</TD>
						
						<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"   onClick="clearAll()" class="mainbut"> 
					</TD>
						<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit&nbsp&nbsp;  "   onClick="top.frames[1].location.href='low.jsp'" class="mainbut"> 
					</TD>
						<TD WIDTH="6%">
						<!--<INPUT TYPE="Button" NAME="report_but" VALUE="Enquiry&nbsp; "    onClick="obtain_report_before()" class="mainbut">-->
						
					</TD>
						<TD  WIDTH="50%" class="hh1" align="right">
						<B>Client Statement Bulk</B>
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
						
						
						
						<TABLE WidTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0" >							
						<TD WidTH="1%">
						<TD WidTH="99%">
						<TABLE WIDTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0" >
						<TR><BR></TR>
						<TR>
						<!--<TD WIDTH="12%">Facility No </TD> 
						<TD WIDTH="20%"><INPUT TYPE="Text" NAME="TXT_PORT" SIZE=10 MAXLENGTH=10 ONBLUR="chk_port()">
						<INPUT TYPE="Button" NAME="But_PORT" value="Help" ONCLICK="Client_help()">
						-->
						<TD WIDTH="8%">From Date</TD> 
						<TD WIDTH="20%">
						<INPUT TYPE="Text" NAME="TXT_DATE"  SIZE=2 MAXLENGTH=2 class="txt_input5" >
						<INPUT TYPE="Text" NAME="TXT_MONTH" SIZE=2  MAXLENGTH=2  class="txt_input5">
						<INPUT TYPE="Text" NAME="TXT_YEAR"  SIZE=4 MAXLENGTH=4 ONBLUR="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR)"  class="txt_input5"> 								
						<input type = "hidden" name = "FROM_TXT_DATE" id = "FROM_TXT_DATE" />
					</TD> 
						<TD WIDTH="8%">To Date</TD> 
						<TD WIDTH="20%">
						<INPUT TYPE="Text" NAME="TXT_TODATE"   SIZE=2 MAXLENGTH=2  class="txt_input5">
						<INPUT TYPE="Text" NAME="TXT_TOMONTH" SIZE=2  MAXLENGTH=2  class="txt_input5">
						<INPUT TYPE="Text" NAME="TXT_TOYEAR"  SIZE=4 MAXLENGTH=4 ONBLUR="chkstartdate(document.Form1.TXT_TODATE,document.Form1.TXT_TOMONTH,document.Form1.TXT_TOYEAR)"  class="txt_input5"> 								
						<input type = "hidden" name = "TO_TXT_DATE" id = "TO_TXT_DATE" />
					</TD> 
						
						<TD WIDTH="10%" align="absmiddle"><INPUT TYPE="Button" NAME="But_go" value="Go" ONCLICK="displaydata()" class="but_input"></TD>
						<TD WIDTH="20%"></TD> 
					</TR> 
					</TABLE>  
						<TABLE width="100%" BORDER="0" CELLPADDING="2" CELLSPACING="1" >
					</TABLE>
						<INPUT TYPE="Hidden" NAME="Hid_rows" >
						<DIV id=clientmgr></DIV>
					</TD>
					</TD>
					</TABLE> 
					</FORM>
					</BODY>
						<DIV>
						<SCRIPT language1.2="JavaScript" src="validate_v1.js"></SCRIPT>
						<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>				
					</DIV>
					</HTML>
						
