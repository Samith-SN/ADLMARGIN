<%@page import="net.sasianet.ADLMARGIN.*" %>
<HTML>
	<HEAD>
		<TITLE>MFactor</TITLE>
		
	</HEAD>
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
		out.println("       <script src='"+m_jsp_client_url+"/js/jquery.min.js' type=\"text/javascript\"></script>");
		out.println("       <script src='"+m_jsp_client_url+"/js/jquery-ui.min.js' type=\"text/javascript\"></script>");
		
		/*
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
		
		*/
		
		
		
		
	%>	
	<SCRIPT language="JavaScript">
		var very;
		
		
		
		function detail_help(m_portcode,m_dn_portcode) {
			document.Form1.hidden_help_value.value="1";
			m_max_num=document.Form1.hidden_max.value;
			m_sql = "m_cgdatasql";
			m_criteria = m_portcode+"@"+m_dn_portcode+"@";
			HelpBox('1','20','0',m_max_num);
		}		
		
		function detail_help2(m_portcode,m_fromdate,m_todate,m_dn_portcode) {
			document.Form1.hidden_help_value.value="1";
			m_max_num=document.Form1.hidden_max.value;
			m_sql = "m_cgdata2sql";
			m_criteria = m_portcode+"@"+m_fromdate+"@"+m_todate+"@"+m_dn_portcode+"@";
			HelpBox('1','20','0',m_max_num);
		}		
		
		function detail_help5(m_portcode,m_todate,m_dn_portcode) {
			document.Form1.hidden_help_value.value="1";
			m_max_num=document.Form1.hidden_max.value;
			m_sql = "m_cgdata5sql";
			m_criteria = m_portcode+"@"+m_todate+"@"+m_dn_portcode+"@";
			HelpBox('1','20','0',m_max_num);
		}	
		
		function detail_help6(m_portcode,m_fromdate,m_dn_portcode) {
			
			document.Form1.hidden_help_value.value="1";
			m_max_num=document.Form1.hidden_max.value;
			
			m_sql = "m_cgdata6sql";
			m_criteria = m_portcode+"@"+m_fromdate+"@"+m_dn_portcode+"@";
			HelpBox('1','20','0',m_max_num);
		}	
		
		// ----------------------------the function create the Scrip objects-------------------------//
		
		function MyDialog(){
			this.valout   = new Array(20);
		}			
		
		//------------------This Function Is to get The Help Box--------------------------------//
		function HelpBox(Start,End,Hid_No,Max) {
			oBj = new MyDialog();
			oBj.valout[1]  = " ";
			oBj.valout[2]  = " ";
			oBj.valout[3]  = " ";
			popupwin = window.showModalDialog(""+servlet_client_url+":"+client_t3_port+"/"+client_name+"dn_Help_Servlet?class_in="+client_name+"dn_help_select"+
				"&Sql_in="+m_sql+"&Start_in="+Start+
					"&End_in="+End+"&Crit_In="+m_criteria+
					"&Hid_No="+Hid_No+"&Max_in="+Max+"", oBj,"dialogWidth:50em; dialogHeight:30em; center:yes; status:no");
			
			if((oBj.valout[1]!="Prev") && (oBj.valout[1]!="Next") && (oBj.valout[2]!=" ") && (oBj.valout[2]!=null)){1
				if (document.Form1.hidden_help_value.value=="2") {
					//asign_postalCodes();
				}
			}
			
			
			if(oBj.valout[1]=='Next')  {
				Next(oBj.valout[2],oBj.valout[3],Hid_No,Max);
				return false;
			}
			else if  (oBj.valout[1]=='Prev') {
				Prev(oBj.valout[2],oBj.valout[3],Hid_No,Max);
			}	
			else if  (oBj.valout[1]=='Last') {
				Last(oBj.valout[2],oBj.valout[3],Hid_No,Max);
			}	
			else if  (oBj.valout[1]=='First') {
				First(oBj.valout[2],oBj.valout[3],Hid_No,Max); 
			}	
			else if(((oBj.valout[1] == 'Close') || (oBj.valout[2]==" ") || (oBj.valout[2]==null)) )  {
				if (document.Form1.hidden_help_value.value==2) {
					// document.Form1.Text_postal_code.value="";
					// document.Form1.Text_postal_desc.value="";
				}
			}
		}
		/**/
		function Prev(Start,End,Hid_No,Max){
			HelpBox(Start,End,Hid_No,Max)
		}
		
		
		function Next (Start,End,Hid_No,Max){
			HelpBox(Start,End,Hid_No,Max)
		}
		function Last(Start,End,Hid_No,Max){
			HelpBox(Start,End,Hid_No,Max)
		}
		
		
		function First(Start,End,Hid_No,Max){
			HelpBox(Start,End,Hid_No,Max)
		}
		//------------------------asigning returned data-----------------//
		function display_more2(m_portcode,m_dn_portcode,m_fromdate,m_todate,m_option){
			
			if(m_option=='data1'){
				m1_url2= servlet_client_url+':'+client_t3_port+'/'+client_name+'accvalwizardclientaccount?chksql=acc_level&portcode='+m_portcode+'&dnportcode='+m_dn_portcode+'&option='+m_option;
				popupwin3 = window.open(m1_url2,'displayWindowN','left=0,top=0,width=680,height=250,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
				popupwin3.focus();	
			}
			if(m_option=='data4'){
				m1_url2= servlet_client_url+':'+client_t3_port+'/'+client_name+'accvalwizardclientaccount?chksql=acc_level&portcode='+m_portcode+'&dnportcode='+m_dn_portcode+'&option='+m_option;
				popupwin3 = window.open(m1_url2,'displayWindowN','left=0,top=0,width=680,height=250,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
				popupwin3.focus();	
			}
			if(m_option=='data2'){
				
				m1_url2= servlet_client_url+':'+client_t3_port+'/'+client_name+'accvalwizardclientaccount?chksql=acc_level2&portcode='+m_portcode+'&dnportcode='+m_dn_portcode+'&option='+m_option+'&val_fromdate='+m_fromdate+'&val_todate='+m_todate;
				popupwin3 = window.open(m1_url2,'displayWindowN','left=0,top=0,width=680,height=250,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
				popupwin3.focus();	
			}
			if(m_option=='data3'){
				
				m1_url2= servlet_client_url+':'+client_t3_port+'/'+client_name+'accvalwizardclientaccount?chksql=acc_level2&portcode='+m_portcode+'&dnportcode='+m_dn_portcode+'&option='+m_option+'&val_fromdate='+m_fromdate+'&val_todate='+m_todate;
				popupwin3 = window.open(m1_url2,'displayWindowN','left=0,top=0,width=680,height=250,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
				popupwin3.focus();	
			}
			if(m_option=='data5'){
				
				m1_url2= servlet_client_url+':'+client_t3_port+'/'+client_name+'accvalwizardclientaccount?chksql=acc_level5&portcode='+m_portcode+'&dnportcode='+m_dn_portcode+'&option='+m_option+'&val_fromdate='+m_fromdate+'&val_todate='+m_todate;
				popupwin3 = window.open(m1_url2,'displayWindowN','left=0,top=0,width=680,height=250,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
				popupwin3.focus();	
			}
			if(m_option=='data6'){
				
				m1_url2= servlet_client_url+':'+client_t3_port+'/'+client_name+'accvalwizardclientaccount?chksql=acc_level5&portcode='+m_portcode+'&dnportcode='+m_dn_portcode+'&option='+m_option+'&val_fromdate='+m_fromdate+'&val_todate='+m_todate;
				popupwin3 = window.open(m1_url2,'displayWindowN','left=0,top=0,width=680,height=250,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
				popupwin3.focus();	
			}
		}
		
		
		function display_more(m_portcode,m_dn_portcode,m_acc_typecode,m_val,m_option) {
			
			m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'accvalwizardclientaccount?chksql=test_max2&portcode='+m_portcode+'&dnportcode='+m_dn_portcode+'&option='+m_option+'';
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
			if(m_size>0){
				m_tot1=top.frames[0].document.applets[0].outvec_value.elementAt(0);
				document.Form1.hidden_max.value=m_tot1;
			}
			
			if(m_option=='data1'){
				detail_help(m_portcode,m_dn_portcode);
			}
			if(m_option=='data4'){
				detail_help(m_portcode,m_dn_portcode);
			}
			
		} 
		
		function display_more_date(m_dn_portcode,m_fromdate,m_todate,m_option) {	
			
			m_url3=servlet_client_url+':'+client_t3_port+'/'+client_name+'accvalwizardclientaccount?chksql=test_max3_new&portcode=&dnportcode='+m_dn_portcode+'&selec_fromdate='+m_fromdate+'&selec_todate='+m_todate+'&option='+m_option+'';
			top.frames[0].document.applets[0].getdata(m_url3);
			m_size3=top.frames[0].document.applets[0].outvec_value.size();
			m_tot1=0; m_tot2=0;
			
			if(m_size3>0){
				m_tot1=top.frames[0].document.applets[0].outvec_value.elementAt(0);
				document.Form1.hidden_max.value=Number(m_tot1)+Number(m_tot2);
			}
			if(m_option=='data2'){
				
				detail_help2(m_portcode,m_fromdate,m_todate,m_dn_portcode);//m_portcode
			}
			
		}
		function myDialogObj() {
			var htmlstr;
			var returnval;
		}
		
		function entryConfirm(){
			popupwin.close();		
			
		}
		
		function displaydata(from_date,from_month,from_year,to_date,to_month,to_year){			
		 
			if(from_date+"-"+from_month+"-"+from_year=="--"){
				alert("Please enter From Date");
				document.Form1.TXT_FROMDATE.focus();
				return false;
			}
			else if(to_date+"-"+to_month+"-"+to_year=="--"){
				alert("Please enter  To Date");
				document.Form1.TXT_TODATE.focus();
				return false;
			}else{
				m_url=servlet_client_url+':'+client_t3_port+"/"+client_name+"auto_reporollover1?m_to_date="+to_date+"-"+to_month+"-"+to_year+"&chksql=chkdatedeff";
				//top.frames[0].document.applets[0].getdata(m_url);
				load_interface(m_url,'XML',false);
				m_size=data_vec.length; 
				
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				if(m_size==0){
					m_url=servlet_client_url+':'+client_t3_port+"/"+client_name+"auto_reporollover1?chksql=auto_repo&val_fromdate="+from_date+"&val_frommonth="+from_month+"&val_fromyear="+from_year+"&val_todate="+to_date+"&val_tomonth="+to_month+"&val_toyear="+to_year;
					//2011-09-21 //popupwin = window.open(m_url,'displayWindow1','left=0,top=130,width=790,height=390,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1'); //2011-09-21					
					//2011-09-21 //popupwin.focus();	//2011-09-21
					
					show_drill(m_url);//2011-09-21
				}else{
					alert("Date should be lessthan day end routine date+1");
				}
			}
			
		}			
		
		
		function chkstartdate(dayobj,monthobj,yearobj) {
			if (checkMonthLength(dayobj,monthobj,yearobj)) {
			}
		}
		
		
		
		
		
		
		
		function instcheck(objx){
			if (objx.value!="") {
				m_portcode=objx.value;
				m_url=servlet_client_url+':'+client_t3_port+"/"+client_name+"bvalwizard?inst_code="+m_portcode.toUpperCase()+"&chksql=chkinst";
				top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				if (m_size==0) {
					inst_help(objx);
					objx.focus();
				}
			}
		}			
		
		function default_actions() {	
			setInterval("set_timer_actions()", 120000);
		}			
		
		
		function set_timer_actions() {	
			m_url=servlet_client_url+':'+client_t3_port+"/"+client_name+"bvalwizard?chksql=idle";
			top.frames[0].document.applets[0].getdata(m_url);
		}	
		
		
		function get_date() {   
			m_urls=servlet_client_url+":"+client_t3_port+"/"+client_name+"auto_reporollover1?chksql=chk_lastdate";
			//window.open(m_urls);
			load_interface(m_urls,'XML',false);
			m_size=data_vec.length;
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			if(m_size>0)
			{	
				/*document.Form1.TXT_FROMDATE.value=top.frames[0].document.applets[0].outvec_value.elementAt(0);
				document.Form1.TXT_FROMMONTH.value=top.frames[0].document.applets[0].outvec_value.elementAt(1);
				document.Form1.TXT_FROMYEAR.value=top.frames[0].document.applets[0].outvec_value.elementAt(2);
				document.Form1.TXT_TODATE.value=top.frames[0].document.applets[0].outvec_value.elementAt(0);
				document.Form1.TXT_TOMONTH.value=top.frames[0].document.applets[0].outvec_value.elementAt(1);
				document.Form1.TXT_TOYEAR.value=top.frames[0].document.applets[0].outvec_value.elementAt(2);
				*/
				document.Form1.TXT_FROMDATE.value=data_vec[0];
				document.Form1.TXT_FROMMONTH.value=data_vec[1];
				document.Form1.TXT_FROMYEAR.value=data_vec[2];
				document.Form1.TXT_TODATE.value=data_vec[0];
				document.Form1.TXT_TOMONTH.value=data_vec[1];
				document.Form1.TXT_TOYEAR.value=data_vec[2];
				
			}	
			
		}
		
		<!---------------- Added by S.Shanheetha on 01-03-2007 for SR0702-077 --------------->
		
		function chk_confirm(){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?chksql=chk_confirm_deal1";
			//top.frames[0].document.applets[0].getdata(m_url);
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;     
			//m_size=top.frames[0].document.applets[0].outvec_value.size();        
			if (m_size>0) { 
				m_url5=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?chksql=chk_confirm_deal";
				show_popup(m_url5);//2011-09-26
				//popupwin2 = window.open(m_url5,'displayWindow2','left=180,top=165,width=418,height=200,toolbar=0,location=0,directories=0,status=1,menuBar=1,scrollBars=1,resizable=1');
				//popupwin2.focus();
			}
			else{
			}
		}
		
		<!---------------------- End -------------------------------------------------------->
		/* added by madhawa 2011-09-20 */	
		function  cancel()
		{
			window.location.href='<%=m_jsp_client_url%>/dn_auto_rollover_main.jsp';
		}	
		function  exit()
		{
			window.location.href='<%=m_jsp_client_url%>/low.jsp';
			
		}	
		
		
		//added by 2011-09-16
		$(document).ready
		(
			
			function() 
			{
				initDialog();
				initDialogPOPup();
			}
		);
		
		function initDialogPOPup()
		{
				$("#DIV_DAILY_MARG_ACTIVITY_POPUP").dialog(
				
				{
					
					bgiframe: true,
					autoOpen: false,
					//modal: false,
					modal: true, //to disable the back ground	
					height: 500,
					width: getW,
					close: function() 
					{
						
					}
				}
			);
		}	
		
		function initDialog() 
		{
			
			$("#DIV_DAILY_MARG_ACTIVITY").dialog(
				
				{
					
					bgiframe: true,
					autoOpen: false,
					//modal: false,
					modal: true, //to disable the back ground	
					height: 500,
					width: getW,
					close: function() 
					{
						
					}
				}
			);
		}	
		
		function show_drill(m_url) 
		{
			if ($("#DIV_DAILY_MARG_ACTIVITY").dialog("isOpen")) 
			{
				$("#DIV_DAILY_MARG_ACTIVITY").dialog("close");
			}
			
			$("#DIV_DAILY_MARG_ACTIVITY").empty();
			$("#DIV_DAILY_MARG_ACTIVITY").html('<iframe id ="DIV_DAILY_MARG_IFRAME_ACTIVITY" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Daily Margin Trading Activity">');
			
			
			$("#DIV_DAILY_MARG_ACTIVITY").dialog("option", "title", "Auto Loan Generating ");
			$("#DIV_DAILY_MARG_IFRAME_ACTIVITY").attr("src",m_url);
			$("#DIV_DAILY_MARG_ACTIVITY").dialog("open");
			return false;
		}
		
		
		function close_iframe(iframe_id)
		{
			   $(iframe_id).dialog("close"); 
			   
		}	
		
		
		function show_popup(m_url) 
		{ 
			
			if ($("#DIV_DAILY_MARG_ACTIVITY_POPUP").dialog("isOpen")) 
			{
				
				$("#DIV_DAILY_MARG_ACTIVITY_POPUP").dialog("close");
			}
			$("#DIV_DAILY_MARG_ACTIVITY_POPUP").dialog("option", "title", "Auto Loan Generating");
			$("#DIV_DAILY_MARG_IFRAME_ACTIVITY_POPUP").attr("src",m_url); //replace with new url and then open the pop up
			$("#DIV_DAILY_MARG_ACTIVITY_POPUP").dialog("open");
			
			return false;
		}
		
		
		
		function getW() 
		{
			var w = 0;
			if (window.document.innerWidth > w) 
			{
				w = window.document.innerWidth;
			}
			if (window.document.documentElement.clientWidth > w) 
			{
				w = window.document.documentElement.clientWidth;
			}
			return (w - 100);
		}
		
		
	</SCRIPT>
	<BODY ONLOAD="get_date(),chk_confirm()">
		<FORM NAME="Form1">
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="reveryfication">
			<INPUT TYPE="Hidden" NAME="hidden_help_value" ALIGN="RIGHT" SIZE=2 >
			<INPUT TYPE="Hidden" NAME="hidden_max" ALIGN="RIGHT" VALUE=1>
			
			
			<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" STYLE="{color: black; font: bold 9pt arial;}" >
				 <tr>
					<td height='7'></td>
				</tr>
				<TR HEIGHT="30">		
					<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
					<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Margin Trading - Day End Routine </B></td>
					<td width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>
				</TR>
			</TABLE>	

			<!--  here <INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="user_maintenance"> commented but was originally on the  buttons file dn_autorollover_frame1.html -->
			
			<TABLE WIDTH="100%" BORDER="0" BGCOLOR="darkblue" STYLE="{border-style: none;}" >
				<TR >
					<TD WIDTH="40%"></TD>
					<TD WIDTH="40%">
						<INPUT TYPE="Button" NAME="calcel_but" CLASS="mainbut" VALUE="Cancel" onClick="cancel()"> <!-- STYLE="{cursor:hand; color: black; font: bold 10pt arial;border-style: outset;background-color: darkgray; }" -->
						<INPUT TYPE="Button" NAME="Exit_but"   CLASS="mainbut" VALUE=" Exit  "  onClick="exit()" >  <!-- STYLE="{cursor:hand; color: black; font: bold 10pt arial;border-style: outset;background-color: darkgray; }" -->
					</TD>
					<TD WIDTH="20%" ID=scrname ALIGN="RIGHT">
						<div style="width:200px" ><B>Margin Trading Routine</B> <div>
							</TD>					
						</TR>
					</TABLE>
					
					<hr>					

					<TABLE WidTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0" STYLE="{color: black; }">										<TD WidTH="1%">
							<TD WidTH="99%">						
								<TABLE WIDTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0" STYLE="{color: black; }">
									<TR><BR></TR>
									<TR> 
										<TD WIDTH="12%">From Date</TD> 
										<TD WIDTH="30%">
											<INPUT TYPE="Text" NAME="TXT_FROMDATE" SIZE=3 MAXLENGTH=2 class="txt_input5">
											<INPUT TYPE="Text" NAME="TXT_FROMMONTH" SIZE=3 MAXLENGTH=2 class="txt_input5">
											<INPUT TYPE="Text" NAME="TXT_FROMYEAR" SIZE=5 MAXLENGTH=4 class="txt_input5" ONBLUR="chkstartdate(document.Form1.TXT_FROMDATE,document.Form1.TXT_FROMMONTH,document.Form1.TXT_FROMYEAR)";> 								
										</TD> 
										
										<TD></TD>								
										
										<TD WIDTH="12%">To Date</TD> 
										<TD WIDTH="30%">
											<INPUT TYPE="Text" NAME="TXT_TODATE" SIZE=3 MAXLENGTH=2 class="txt_input5" >
											<INPUT TYPE="Text" NAME="TXT_TOMONTH" SIZE=3 MAXLENGTH=2 class="txt_input5">
											<INPUT TYPE="Text" NAME="TXT_TOYEAR" SIZE=5 MAXLENGTH=4 class="txt_input5" ONBLUR="chkstartdate(document.Form1.TXT_TODATE,document.Form1.TXT_TOMONTH,document.Form1.TXT_TOYEAR);"><!--chk_validity()"--> 								
										</TD> 
										
										
										
										<TD WIDTH="30%"><INPUT TYPE="button" class='mainbut' VALUE=" GO " NAME="BUT_BCODE" ONCLICK="displaydata(document.Form1.TXT_FROMDATE.value,document.Form1.TXT_FROMMONTH.value,document.Form1.TXT_FROMYEAR.value,document.Form1.TXT_TODATE.value,document.Form1.TXT_TOMONTH.value,document.Form1.TXT_TOYEAR.value)" STYLE="{cursor:hand; }"></TD>								
									</TR> 
								</TABLE>  
								<TABLE width="100%" BORDER="0" CELLPADDING="2" CELLSPACING="1" STYLE="{color: black; font: 10pt sans-serif;}">
								</TABLE>
							</TD>
						</TD>
					</TABLE> 			
					
				</FORM>
				
				<div id ="DIV_DAILY_MARG_ACTIVITY" title ="Daily Margin Trading Activity">
					<iframe id ="DIV_DAILY_MARG_IFRAME_ACTIVITY" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Daily Margin Trading Activity">
					</iframe>
				</div>
				
				<div id ="DIV_DAILY_MARG_ACTIVITY_POPUP" >
					<iframe id ="DIV_DAILY_MARG_IFRAME_ACTIVITY_POPUP" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Daily Margin Trading Activity">
					</iframe>
				</div>
				
				
			</BODY>
			<DIV>
				<SCRIPT language1.2="JavaScript" src="validate.js"></SCRIPT>
				<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>	
			</DIV>
		</html>
		
