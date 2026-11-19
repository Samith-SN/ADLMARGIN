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
		var very;
		
		
		/*
		function detail_help(m_portcode,m_dn_portcode) {
			document.Form1.hid_help_type.value="1";
			m_sql = "m_portfolio1sql";
			m_criteria = document.Form1.TXT_PORTFOLIO.value+"@";
			HelpBox('1','10','0');
		}		
		
		*/
		
		function MyDialog(){
			this.valout   = new Array(20);
		}			
		
		//------------------This Function Is to get The Help Box--------------------------------//
		function HelpBox(Start,End,Hid_No) {
			oBj = new MyDialog();
			oBj.valout[1]  = " ";
			oBj.valout[2]  = " ";
			oBj.valout[3]  = " ";
			popupwin = window.showModalDialog(""+servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_fund_Help_Servlet?class_in="+client_name+"mbfsl_fund_help_select"+
				"&Sql_in="+m_sql+"&Start_in="+Start+
					"&End_in="+End+"&Crit_In="+m_criteria+
					"&Hid_No="+Hid_No+"", oBj,"dialogWidth:25em; dialogHeight:18em; center:yes;  status:no");
			
			
			
			if(document.Form1.hid_help_type.value=="1"){
				if(oBj.valout[1] !=" "){
					if(oBj.valout[1] !='Close'){
						if(oBj.valout[1]!="Prev"){
							if(oBj.valout[1]!="Next"){
								// alert("uu");
								asign_port_code();
							}
							else{//alert("HI");
								//alert("hi"+oBj.valout[2]+"hi"+oBj.valout[3]);
								Next(oBj.valout[2],oBj.valout[3],Hid_No);
								return false;
							} 
						}
						else{
							Prev(oBj.valout[2],oBj.valout[3],Hid_No);
						}	
					}		
					else{	
						document.Form1.TXT_PORTFOLIO.value="";	
					}		
				}
				else{		
					document.Form1.TXT_PORTFOLIO.value="";	
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
			document.Form1.TXT_PORTFOLIO.value=oBj.valout[2];
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
				
				detail_help2(m_portcode,m_fromdate,m_todate,m_dn_portcode);
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
			
			if(from_date==""){
				alert("Please Enter the 'From Date'.");
				document.Form1.TXT_FROMDATE.focus();
				return false;
			}
			else if(to_date==""){
				alert("Please Enter the 'To Date'.");
				document.Form1.TXT_TODATE.focus();
				return false;
			}
			
			
			
			if(to_year!=="" && from_year!=="") {
				//	parent.frames[1].location.href=servlet_client_url+':'+client_t3_port+"/"+client_name+"interest_capitalization?chksql=auto_repo&val_fromdate="+from_date+"&val_frommonth="+from_month+"&val_fromyear="+from_year+"&val_todate="+to_date+"&val_tomonth="+to_month+"&val_toyear="+to_year;
				m_url=servlet_client_url+':'+client_t3_port+"/"+client_name+"interest_capitalization?chksql=interest_cap_rep&val_fromdate="+from_date+"&val_frommonth="+from_month+"&val_fromyear="+from_year+"&val_todate="+to_date+"&val_tomonth="+to_month+"&val_toyear="+to_year+"&portfolio="+document.Form1.TXT_PORTFOLIO.value;
				popupwin = window.open(m_url,'displayWindow1','left=0,top=130,width=790,height=390,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');					
				popupwin.focus();		
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
			m_urls=servlet_client_url+":"+client_t3_port+"/"+client_name+"interest_capitalization?chksql=get_sysdate";
			//window.open(m_urls);
			//top.frames[0].document.applets[0].getdata(m_urls);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			load_interface(m_urls,'XML',false);	
			m_size=data_vec.length; 
			document.Form1.TXT_FROMDATE.value="01";
			document.Form1.TXT_FROMMONTH.value=data_vec[1];
			document.Form1.TXT_FROMYEAR.value=data_vec[2];
			document.Form1.TXT_TODATE.value=data_vec[0];
			document.Form1.TXT_TOMONTH.value=data_vec[1];
			document.Form1.TXT_TOYEAR.value=data_vec[2];
		}
		
		function portcheck(objx){
			if (objx.value!="") {
				m_portcode=objx.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"accvalwizard?port_code="+m_portcode.toUpperCase()+"&chksql=chkport";
				load_interface(m_urls,'XML',false);	
				m_size=data_vec.length; 
				if (m_size==0) {
					detail_help_new(0); //detail_help(objx);
					objx.focus();
				}
			}
		}
		
		
		
		
		
		
		function  exit()
		{
			window.location.href='<%=m_jsp_client_url%>/low.jsp';
			
		}
		function  cancel()
		{
			window.location.href='<%=m_jsp_client_url%>/dn_fund_out_standingBal.jsp';
			
		}
		
		/*
		$(document).ready(function() 
				{
					initCal('FROM_TXT_DATE');
					initCal('TO_TXT_DATE');
					
				});
		*/		
		/*
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
		*/
		
		function detail_help_new(m_strat)
		{
			var aForm;    //  aForm =oForm.elements;
			aForm =  document.getElementById('Form1');
			
			var myObject=new Array(); //return values set to this object
			myObject[0]=aForm.TXT_PORTFOLIO; //2011-09-27
			//myObject[1]=aForm.Text_loc_desc;;
			myObject[1]=null;
			myObject[2]=null;
			myObject[3]=null;
			myObject[4]=null;
			
			var myObject_value=new Array(); //passing values set to this object
			//myObject_value[0]=aForm.TXT_UNAME.value; //2011-09-27
			myObject_value[0]=aForm.TXT_PORTFOLIO.value; //2011-09-27
			myObject_value[1]=aForm.TXT_PORTFOLIO.value;//aForm.Text_loc_code.value;
			myObject_value[2]=aForm.TXT_PORTFOLIO.value;
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
			
			
			title_name='Portfolio';
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
							port_help_close();
						} 
					} //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
		}
		
		function port_help_close()
		{
			document.Form1.TXT_PORTFOLIO.value="";
			
		}
		
		
	</SCRIPT>
	<BODY ONLOAD="get_date()">
		<FORM NAME="Form1" id="Form1">
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="reveryfication">
			<INPUT TYPE="Hidden" NAME="hidden_help_value" ALIGN="RIGHT" SIZE=2 >
			<INPUT TYPE="Hidden" NAME="hid_help_type" ALIGN="RIGHT" SIZE=1 >
			<INPUT TYPE="Hidden" NAME="hidden_max" ALIGN="RIGHT" VALUE=1>
			<TABLE WidTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0" STYLE="{color: black; font: bold 9pt arial;}">										<TD WidTH="1%">
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
											<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Management Information - Fund Outstanding Balance</B></td>
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
											<TD WIDTH="10%">Portfolio</TD> 
											<TD WIDTH="20%"> 
												<INPUT TYPE="Text" class="txt_input6" NAME="TXT_PORTFOLIO" SIZE=10 MAXLENGTH=10 ONBLUR="portcheck(document.Form1.TXT_PORTFOLIO)";>  <!-- detail_help_new(document.Form1.TXT_PORTFOLIO) --> 								
												<INPUT TYPE="button" class="mainbut" VALUE="Help" NAME="BUT_PORT" onclick ="detail_help_new(0)" > <!-- detail_help(document.Form1.TXT_PORTFOLIO) -->
											</TD> 
											
											<TD WIDTH="10%"></TD> <!--From Date-->
											<TD WIDTH="20%">
												<INPUT TYPE="HIDDEN" NAME="TXT_FROMDATE" SIZE=3 MAXLENGTH=2>
												<INPUT TYPE="HIDDEN" NAME="TXT_FROMMONTH" SIZE=3 MAXLENGTH=2>
												<INPUT TYPE="HIDDEN" NAME="TXT_FROMYEAR" SIZE=5 MAXLENGTH=4 ONBLUR="chkstartdate(document.Form1.TXT_FROMDATE,document.Form1.TXT_FROMMONTH,document.Form1.TXT_FROMYEAR)";> 								
											</TD> 
											
											<TD></TD>								
											
											<TD WIDTH="10%"></TD> <!--To Date-->
											<TD WIDTH="20%">
												<INPUT TYPE="HIDDEN" NAME="TXT_TODATE" SIZE=3 MAXLENGTH=2>
												<INPUT TYPE="HIDDEN" NAME="TXT_TOMONTH" SIZE=3 MAXLENGTH=2>
												<INPUT TYPE="HIDDEN" NAME="TXT_TOYEAR" SIZE=5 MAXLENGTH=4 ONBLUR="chkstartdate(document.Form1.TXT_TODATE,document.Form1.TXT_TOMONTH,document.Form1.TXT_TOYEAR);"><!--chk_validity()"--> 								
											</TD> 
											
											
											
											<TD WIDTH="30%">
												<INPUT TYPE="button" class="mainbut" VALUE=" GO " NAME="BUT_BCODE" ONCLICK="displaydata(document.Form1.TXT_FROMDATE.value,document.Form1.TXT_FROMMONTH.value,document.Form1.TXT_FROMYEAR.value,document.Form1.TXT_TODATE.value,document.Form1.TXT_TOMONTH.value,document.Form1.TXT_TOYEAR.value)" >
											</TD>								
										</TR> 
									</TABLE>  
								</td>
							</tr>
							<tr>
								<td>	
									<TABLE width="100%" BORDER="0" CELLPADDING="2" CELLSPACING="1" STYLE="{color: black; font: 10pt sans-serif;}">
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
		<SCRIPT language1.2="JavaScript" src="validate.js"></SCRIPT>
		<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
	</DIV>
</html>

