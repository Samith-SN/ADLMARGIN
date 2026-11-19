<HTML> 
	<HEAD>
		<TITLE>Margin Trading 
		</TITLE>
		<LINK REL="stylesheet" TYPE="text/css" HREF="" />
		
		
	</HEAD>
	<%@page import="net.sasianet.ADLMARGIN.*" %>
	
	<%	
		ADLMARGIN_MGT_conn_methods m_sn_methods1 = new ADLMARGIN_MGT_conn_methods();
		String m_html_client_url = m_sn_methods1.html_client_url;
		Object done = (String)session.getValue("logon.isDone"); // marker object
			if (done == null) {
				out.println("<html><head>");
				out.println("<script language='JavaScript'>");
				out.println("function displaymsg() {");
				out.println("alert('Your login expired or invalid');");
				out.println("window.location.href='"+m_html_client_url+"/login.htm';");
				out.println("}</script></head>");
				out.println("<body onload='displaymsg();'></body>");
				out.println("</html>");
				out.flush();
				return;
			}
		
		ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
		String m_jsp_client_url=m_sn_methods.jsp_client_url;
		
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/redmond/jquery-ui.css' TYPE=\"text/css\">");
		
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
		
		
		
	%>
	
	<SCRIPT language="JavaScript1.2" >
		/*
		
		function before_submit() {
			
			
			
			if (document.Form1.HID_DEAL_TYPE.value  == "DEBT" )
			{
				if (document.Form1.SEL_MODES.value==1){
					if(document.Form1.TXT_SETAMO1.value!=document.Form1.TXT_SETVAL.value){
						alert('There is a mismatch in total settlement amount, Re enter the settlement amounts');
					}
					else{
						
						if((document.Form1.TXT_BCODE.value=="GROUP") ||(document.Form1.TXT_SCODE.value=="GROUP")){
							
							document.Form1.HID_SELLER.value= document.Form1.TXT_SCODE.value;
							document.Form1.HID_BUYER.value= document.Form1.TXT_BCODE.value;
							
							if(parseFloat(unformat_noobject(document.Form1.txt_face_tot.value))!=0){
								alert("Mismatch should be 0 in the Group Deal Information");
							}
							else{
								//displayconfirmdata();				 
								submit_new();
							}
						}
						else{
							//displayconfirmdata();		
							submit_new();
						}							
						
						
						
					}
				}
				else{
					if(document.Form1.TXT_TOAMO.value!=document.Form1.TXT_SETVAL.value){
						alert('There is a mismatch in total settlement amount, Re enter the settlement amounts');
					}
					else{ 
						
						
						if((document.Form1.TXT_BCODE.value=="GROUP") ||(document.Form1.TXT_SCODE.value=="GROUP")){
							
							document.Form1.HID_SELLER.value= document.Form1.TXT_SCODE.value;
							document.Form1.HID_BUYER.value= document.Form1.TXT_BCODE.value;
							if(parseFloat(unformat_noobject(document.Form1.txt_face_tot.value))!=0){
								alert("Mismatch should be 0 in the Group Deal Information");
							}
							else{
								//displayconfirmdata();	
								submit_new();
							}
						}
						else{
							
							//displayconfirmdata();		
							submit_new();
						}
						
						
					}
				}
				
			}
			
			else{
				document.Form1.TXT_NOMINAL.disabled=false;
				document.Form1.TXT_PURCH_COST.disabled=false;
				document.Form1.TXT_TOT_COST.disabled=false;
				document.Form1.TXT_PAR.disabled=false;
				document.Form1.TXT_BROKER_COST.disabled=false;
				//displayconfirmdata_equity();		 
				submit_new();			
			}
			
		}
		function submit_new() {
			document.Form1.HID_SCRIPT.value=document.Form1.SCRIPT_STAT.value;//scriptless
			document.Form1.TXT_SENOIDEN1.disabled=false;
			document.Form1.TXT_FACEVAL1.disabled=false;
			document.Form1.TXT_MISS1.disabled=false;
			
			document.Form1.TXT_BCODE.disabled=false;
			document.Form1.TXT_SCODE.disabled=false;
			//alert(top.frames[1].frames[2].frames[1].document.Form1.HID_SCRIP_STAT.value);
			//alert(top.frames[1].frames[2].frames[1].document.location.href);
			
			for(h=1;h<=document.Form1.HID_SECDET.value;h++){//$$##SC
				document.Form1.elements["TXT_SENOIDEN"+h].disabled=false;
				document.Form1.elements["TXT_FACEVAL"+h].disabled=false;
				document.Form1.elements["TXT_MISS"+h].disabled=false;
			}
			//-------------------------------------  
			
			//----------------- Added by S.Shanheetha on 07-06-2007 ----------------------------------------------------------
			buy_sett_date=document.Form1.TXT_BDATE.value+'/'+document.Form1.TXT_BMONTH.value+'/'+document.Form1.TXT_BYEAR.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buy_sett_date="+buy_sett_date+"&chksql=chk_margin_trading_date_with_value_date";
			//top.frames[0].document.applets[0].getdata(m_url);
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			//	window.open(m_url);
			//alert(top.frames[0].document.applets[0].outvec_value.elementAt(0));
			document.Form1.HID_BUY_SETT_DATE.value=data_vec[0];
			
			if(document.Form1.HID_BUY_SETT_DATE.value=="NO"){
				alert("Buyer Settlement Date is not greater than the Last Margin Trading Routine Date, Please Re-Enter the Buyer Settlement Date .");
				document.Form1.TXT_BDATE.value=" ";	
				document.Form1.TXT_BMONTH.value=" ";
				document.Form1.TXT_BYEAR.value=" ";
				document.Form1.TXT_BDATE.focus();
			}
			else{	
				buy_sett_date=document.Form1.TXT_SDATE.value+'/'+document.Form1.TXT_SMONTH.value+'/'+document.Form1.TXT_SYEAR.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buy_sett_date="+buy_sett_date+"&chksql=chk_margin_trading_date_with_value_date";
				//top.frames[0].document.applets[0].getdata(m_url);
				load_interface(m_url,'XML',false);
				m_size=data_vec.length;
			//	m_size=top.frames[0].document.applets[0].outvec_value.size();
				
				document.Form1.HID_BUY_SETT_DATE.value=data_vec[0];
				
				if(document.Form1.HID_BUY_SETT_DATE.value=="NO"){
					alert("Seller Settlement Date is not greater than the Last Margin Trading Routine Date, Please Re-Enter the Seller Settlement Date !.");
					document.Form1.TXT_SDATE.value=" ";	
					document.Form1.TXT_SMONTH.value=" ";
					document.Form1.TXT_SYEAR.value=" ";
					document.Form1.TXT_SDATE.focus();
				}
				else{
					Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"fsavoutrig";
				}
			}
			//---------------------- End on 07-06-2007 ------------------------------------------------------------------------	
			
			
			
			Form1.submit();
		}
		
		
		var chg_status=false;
		var m_buyer_code="";
		var	m_buyer_type="";
		var m_buyer_status="";
		var m_seller_code="";
		var	m_seller_type="";
		var m_seller_status="";
		var m_face_value="";
		
		function dynomic_button() {
			m_writedata='<INPUT TYPE="BUTTON" NAME="button_main"  ALIGN="CENTER"    VALUE="                    Main                    " STYLE="{cursor:hand; color: black; font: bold 8pt arial; background-color: silver;}" >';
			change.innerHTML=m_writedata;
			parent.frames[2].dn_F_Outrights.cols="100%,0%";
			if(chg_status) {
				m_writedata1='<INPUT TYPE="BUTTON" NAME="button_broker"  ALIGN="CENTER"  VALUE="Security / Settlement / Brokerage" STYLE="{cursor:hand; color: white; font: bold 8pt arial; background-color: silver;}" onclick="change_button ()">';
				change1.innerHTML=m_writedata1;
			}
		}	
		
		
		function change_button () {
			
			
			m_writedata='<INPUT TYPE="BUTTON" NAME="button_main"  ALIGN="CENTER"   VALUE="                    Main                    " STYLE="{cursor:hand; color: white; font: bold 8pt arial; background-color: silver;}" onclick="dynomic_button()" >';
			change.innerHTML=m_writedata;
			m_writedata1='<INPUT TYPE="BUTTON" NAME="button_broker"  ALIGN="CENTER" VALUE="Security / Settlement / Brokerage" STYLE="{cursor:hand; color: black; font: bold 8pt arial; background-color: silver;}" >'
				change1.innerHTML=m_writedata1;
			parent.frames[2].dn_F_Outrights.cols="0%,100%";
			
			
			chg_status=true;
			if(document.Form1.TXT_ISSCODE.value!="" && document.Form1.TXT_ISSCODE.value!= null){
				document.Form1.TXT_ISSURE.value=document.Form1.TXT_ISSCODE.value;
			}
			if(document.Form1.TXT_SECIDEN.value!="" && document.Form1.TXT_SECIDEN.value!=null){
				document.Form1.TXT_SECCODE.value=document.Form1.TXT_SECIDEN.value;
			}
			if(document.Form1.HID_TEST.value!="" && document.Form1.HID_TEST.value!=null){
				document.Form1.TXT_TOTVAL.value=document.Form1.HID_TEST.value;
			}
			if(document.Form1.TXT_INSTYPE.value!="" && document.Form1.TXT_INSTYPE.value!=null){
				document.Form1.TXT_INSTYPE.value=document.Form1.TXT_INSTYPE.value;
			}
			document.Form1.HID_SETVAL.value=document.Form1.TXT_TOTVAL.value;
			document.Form1.HID_FACEVAL.value=document.Form1.TXT_FACEVAL.value; 
			
			
			load_sett_details();
			
			if (document.Form1.HID_DEAL_TYPE.value == "DEBT" ) {					
				document.Form1.TXT_SETAMO1.value=document.Form1.TXT_SETVAL.value;		
			}
			
			if (document.Form1.HID_DEAL_TYPE.value == "EQUITY")
			{	
				document.Form1.TXT_SETAMO1.value=document.Form1.TXT_TOT_COST.value; 
			}
			
		}
		
		$(document).ready(function(){
				m_url="dn_Outrights_frame3.jsp";
				load_interface(m_url, 'NORMAL',false);
				$('#MAIN_DIV').html(data_vec_no);
				
				
				m_url="dn_Outrights_frame4.jsp";
				load_interface(m_url, 'NORMAL',false);
				$('#BROKERAGE_DIV').html(data_vec_no);
				
				
				gst_help();
				load_sett_details();
				
			}
		);
		
		function get_vector_normal(){
			
		}
		
		function display_main(){
			document.getElementById('MAIN_DIV').style.display = 'inline';
			document.getElementById('BROKERAGE_DIV').style.display = 'none';
			
			document.Form1.button_broker.style.fontWeight = 'normal';
			document.Form1.button_main.style.fontWeight = 'bold';
			
		}
		
		function display_brokerage(){
			document.getElementById('MAIN_DIV').style.display = 'none';
			document.getElementById('BROKERAGE_DIV').style.display = 'inline';
			
			document.Form1.button_broker.style.fontWeight = 'bold';
			document.Form1.button_main.style.fontWeight = 'normal';
			
			chg_status=true;
			if(document.Form1.TXT_ISSCODE.value!="" && document.Form1.TXT_ISSCODE.value!= null){
				document.Form1.TXT_ISSURE.value=document.Form1.TXT_ISSCODE.value;
			}
			if(document.Form1.TXT_SECIDEN.value!="" && document.Form1.TXT_SECIDEN.value!=null){
				document.Form1.TXT_SECCODE.value=document.Form1.TXT_SECIDEN.value;
			}
			if(document.Form1.HID_TEST.value!="" && document.Form1.HID_TEST.value!=null){
				document.Form1.TXT_TOTVAL.value=document.Form1.HID_TEST.value;
			}
			if(document.Form1.TXT_INSTYPE.value!="" && document.Form1.TXT_INSTYPE.value!=null){
				document.Form1.TXT_INSTYPE2.value=document.Form1.TXT_INSTYPE.value;
			}
			document.Form1.HID_SETVAL.value=document.Form1.TXT_TOTVAL.value;
			document.Form1.HID_FACEVAL.value=document.Form1.TXT_FACEVAL1.value; 
			
			
		
			load_sett_details();
			
	
			if (document.Form1.HID_DEAL_TYPE.value == "DEBT" ) {					
				document.Form1.TXT_SETAMO1.value=document.Form1.TXT_SETVAL.value;		
			}
			
			if (document.Form1.HID_DEAL_TYPE.value == "EQUITY")
			{	
				document.Form1.TXT_SETAMO1.value=document.Form1.TXT_TOT_COST.value; 
			}
			
			
		}
		*/
		
		
		function before_submit() {
			document.Form1.HID_SCRIPT.value=document.Form1.SCRIPT_STAT.value;//$$##SC
			
			if (document.Form1.SEL_MODES.value==1){
				
				if (document.Form1.HID_DEAL_TYPE.value == "DEBT" ) 
				{	
					if(document.Form1.TXT_SETAMO1.value!=document.Form1.TXT_SETVAL.value){
						alert('There is a mismatch in total settlement amount, Re enter the settlement amounts');					
					}
					else{
						document.Form1.save_but.disabled=true;
						document.Form1.SEL_SETTLE1.disabled=false;	
						
						for(h=1;h<=document.Form1.HID_SECDET.value;h++){//$$##SC
							document.Form1.elements["TXT_SENOIDEN"+h].disabled=false;
							document.Form1.elements["TXT_FACEVAL"+h].disabled=false;
							document.Form1.elements["TXT_MISS"+h].disabled=false;
						}
						//-------------------------------
						document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"fmodoutrig";
						document.Form1.submit();
						
					}
					
				}
				else
				{    
					
					document.Form1.TXT_NOMINAL.disabled=false;
					document.Form1.TXT_PURCH_COST.disabled=false;
					document.Form1.TXT_TOT_COST.disabled=false;				
					document.Form1.TXT_SENOIDEN1.disabled=false;
					document.Form1.TXT_FACEVAL1.disabled=false;
					document.Form1.TXT_MISS1.disabled=false;
					
					/*
					}
					}
					else{
					if(parent.frames[2].frames[1].document.Form1.TXT_TOAMO.value!=document.Form1.TXT_SETVAL.value){
					alert('There is a mismatch in total settlement amount, Re enter the settlement amounts');
					}
					else{
					document.Form1.save_but.disabled=true;*/
					
					if(document.Form1.TXT_SETAMO1.value!=document.Form1.TXT_TOT_COST.value){
						alert('There is a mismatch in total settlement amount, Re enter the settlement amounts');					
					}
					else{
						document.Form1.save_but.disabled=true;
						document.Form1.SEL_SETTLE1.disabled=false;	
						
						
						for(h=1;h<=document.Form1.HID_SECDET.value;h++){//$$##SC
							document.Form1.elements["TXT_SENOIDEN"+h].disabled=false;
							document.Form1.elements["TXT_FACEVAL"+h].disabled=false;
							document.Form1.elements["TXT_MISS"+h].disabled=false;
						}
						//------------------------------------
						
						document.Form1.SEL_SETTLE1.disabled=false;	
						document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"fmodoutrig";
						document.Form1.submit();
						
					}
				}
			}
			
			
		}
		
		
		
		function get_vector_normal(){
			
		}
		
		
		
		$(document).ready(function(){
				
				m_url="dn_MOutrights_frame3.jsp";
				load_interface(m_url, 'NORMAL',false);
				$('#MAIN_DIV').html(data_vec_no);
				
				
				m_url="dn_MOutrights_frame4.jsp";
				load_interface(m_url, 'NORMAL',false);
				$('#BROKERAGE_DIV').html(data_vec_no);
				
				
				gst_help();
				//load_sett_details();
				
			}
		);
		
		
		function status_help(dealobj)
		{
			deal_no=dealobj.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_reports_timelog?deal_refno="+deal_no+"&chksql=disprep";
			popupwin2 = window.open(m_url,'displayWindow2','left=0,top=190 ,width=700,height=300,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
			popupwin2.focus();
		} 	
		
		
		
		function display_brokerage(){
			document.getElementById('MAIN_DIV').style.display = 'none';
			document.getElementById('BROKERAGE_DIV').style.display = 'inline';
			
			document.Form1.button_broker.style.fontWeight = 'bold';
			document.Form1.button_main.style.fontWeight = 'normal';
			
			chg_status=true;
			
			if(document.Form1.TXT_ISSCODE.value!=""){
				document.Form1.TXT_ISSURE.value=document.Form1.TXT_ISSCODE.value;
			}
			if(document.Form1.TXT_SECIDEN.value!=""){
				document.Form1.TXT_SECCODE.value=document.Form1.TXT_SECIDEN.value;
			}
			if(document.Form1.HID_TEST.value!=""){
				document.Form1.TXT_TOTVAL.value=document.Form1.HID_TEST.value;
			}
			if(document.Form1.TXT_INSTYPE.value!=""){
				document.Form1.TXT_INSTYPE.value=document.Form1.TXT_INSTYPE.value;
			}
			if(document.Form1.SEL_MODES.value==1){
				if (document.Form1.HID_DEAL_TYPE.value == "DEBT" ) {					
					document.Form1.TXT_SETAMO1.value=document.Form1.TXT_SETVAL.value;		
				}
				
			}
			
			document.Form1.HIDD_SETAMO1.value=document.Form1.TXT_SETAMO1.value;
			document.Form1.HID_FACEVAL.value=document.Form1.TXT_FACEVAL.value; 
			document.Form1.HID_COST.value=document.Form1.TXT_COST.value;  
			
			
		}
		
		
		function display_main(){
			document.getElementById('MAIN_DIV').style.display = 'inline';
			document.getElementById('BROKERAGE_DIV').style.display = 'none';
			
			document.Form1.button_broker.style.fontWeight = 'normal';
			document.Form1.button_main.style.fontWeight = 'bold';
			
		}
		
		function select_screen(mode){
			if(mode == 'NEW'){
				window.location.href = 'dn_frontoffice_outrights.jsp';
			}
			else if(mode == 'DELETE'){
				window.location.href = 'dn_Dfrontoffice_outrights.jsp';
			}

			else if(mode == 'INQUIRY'){
				window.location.href = 'dn_Vfrontoffice_outrights.jsp';
			}
		}
		
		function clearAll(){
				window.location.href=window.location.href;
			}
		
		
	</SCRIPT>
	
	<BODY  class='body & txt-body' >
		<FORM NAME="Form1" ID="Form1" METHOD="POST" >
			
			<!--
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	 VALUE="Location_New">
			<INPUT TYPE="Hidden" NAME="Hid_tel_no" VALUE="null">
			<INPUT TYPE="Hidden" NAME="Hid_tel_count">
			<INPUT TYPE="Hidden" NAME="Hid_main" >
			<INPUT TYPE="Hidden" NAME="Hid_fax_no" >
			<INPUT TYPE="Hidden" NAME="Hid_fax_count" >
			<INPUT TYPE="Hidden" NAME="Hid_email_no" >
			<INPUT TYPE="Hidden" NAME="Hid_email_count">
			-->
			
			
			<INPUT TYPE="Text" NAME="SCR_NAME"	VALUE="MAIN" style='display:none'>
			<INPUT TYPE="Text" NAME="HID_SCRIP_STAT" value="SL" style='display:none'>
			<INPUT TYPE="Text" NAME="SCRIPT_STAT" value="SL" style='display:none' >
			
			<DIV>
				<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
					<tr>
						<td height='7'></td>
					</tr>
					
					<tr height='30' >
						<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
						<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Margin Trading - Data Entry</B></td>
						<td width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>
						
					</tr>
					
					
				</TABLE>	
				
			</DIV>
			<!--------------------------------------------------------------->
			<table class='table' border='0' cellpadding='1' cellspacing='0' width='100%'> 
				<tr>
					<td height='1'></td>
				</tr>
				<tr>				
					
					<!-------------------------------------------------------------------->
					
					
					<TABLE WIDTH="100%" BGCOLOR="darkblue" >
						<TR >
							
							<TD WIDTH="6%">	
								<INPUT TYPE="Button" NAME="NEW" VALUE="Add"   onClick="select_screen('NEW');"  class="mainbut"  >
							</TD>
							<!--
							<TD WIDTH="6%">	
							<INPUT TYPE="Button" NAME="MOD" VALUE="Edit"   onClick="select_screen('MOD');" class="mainbut"  >
							</TD>
							-->
							<TD WIDTH="6%">	
								<INPUT TYPE="Button" style="width:80px" NAME="INQ" VALUE="Inquiry"   onClick="select_screen('INQUIRY');"  class="mainbut"  >
							</TD>
							<TD WIDTH="6%">	
								<INPUT TYPE="Button" NAME="REA" style="width:80px"  VALUE="Delete"   onClick="select_screen('DELETE');"  class="mainbut"  >
							</TD>
							<TD WIDTH='6%'>&nbsp;&nbsp;&nbsp;&nbsp;</TD>		
							<TD WIDTH='6%'>&nbsp;&nbsp;&nbsp;&nbsp;</TD>	
							<!---------------------------------->
							<TD WIDTH="6%">	
								<INPUT TYPE="Button" NAME="save_but" VALUE="Save"   onClick="before_submit()" class="mainbut"  >
							</TD>
							
							<TD WIDTH="6%">
								<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"   onClick="clearAll()" class="mainbut"> 
							</TD>
							<TD WIDTH="6%">
								<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit"   onClick="top.frames[1].location.href='low.jsp'" class="mainbut"> 
							</TD>
							
							<TD  WIDTH="50%" class="hh1" align="right">
								<B>	Manual Transactions Upload - Modify  </B>
							</TD>					
						</TR>
					</TABLE>
					
					
					<!----------->
					
					<TABLE WIDTH="100%"  >
						<tr ></tr>
					</TABLE>
					<HR>
					<TABLE WIDTH="100%"  >
						<tr ></tr>
					</TABLE>
					
					<BR>	
					<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0">
						<TR>
							<TD WIDTH="1%"></TD>
							<TD WIDTH="*%">
								
								<TABLE WIDTH="100%" BORDER="0" CELLPADDING="2" CELLSPACING="0" >
									
									<TD WIDTH="25%" >Deal Reference Number</TD>
									<TD WIDTH="20%" ><INPUT TYPE="Text" NAME="Text_deal_ref" class="txt_input6"	ALIGN="LEFT" SIZE="20"></TD>
									<TD WIDTH="20%" ALIGN="LEFT"><INPUT class="but_input" TYPE="BUTTON" NAME="Text_help_ref" onClick="dealref_help(0);"  VALUE="Help"></TD>	
									<TD WIDTH="15%" ALIGN="CENTER"><INPUT class="but_input" style='width:80px' TYPE="BUTTON" NAME="Text_status" onClick="status_help(document.Form1.Text_deal_ref);"  VALUE="Status"></TD>	
									<TD WIDTH="20%" ALIGN="CENTER" ><INPUT class="but_input" style='width:100px' TYPE="BUTTON" NAME="Text_help_limit"   VALUE="Check Limits" ONCLICk="limit_help()" ></TD>	<!---->
									<TR></TR>	
								</TABLE> 
								<TABLE CELLPADDING="2" >
									<TR>
										<TD id="change"><INPUT TYPE="BUTTON"  class='but_input' NAME="button_main" style='width:120px;font-weight:bold' ALIGN="CENTER" SIZE="25"  VALUE="Main" onclick='display_main()' ></TD>
										<TD id="change1"><INPUT TYPE="BUTTON" class='but_input' NAME="button_broker" style='width:240px'  ALIGN="CENTER"  VALUE="Security / Settlement / Brokerage"  onclick="display_brokerage()"></TD>      
									</TR>
								</TABLE>
								
								<HR>
								
								<TABLE CELLPADDING="2" WIDTH="100%" >
									<TR>
										<TD>
											<DIV id ='MAIN_DIV' WIDTH="100%"></DIV>
											<DIV id ='BROKERAGE_DIV' WIDTH="100%" style='display:none'></DIV>
										</TD>    
									</TR>
								</TABLE>
								
								
							</TD>
						</tr>
					</table>
					
					
				</FORM>
				<SCRIPT language="JavaScript" type='text/javascript' src="validate_v1.js"></SCRIPT>
				<script language='JavaScript' type='text/javascript' src="Moutrights_inv_details.js"></SCRIPT>
				<SCRIPT LANGUAGE="JavaScript" type='text/javascript' SRC="mb-temp.js"></SCRIPT> 
				<script language="JavaScript" type='text/javascript' SRC="validate.js"></SCRIPT>
				<SCRIPT language="JavaScript" type='text/javascript' SRC="ajax_data_gateway.js"></SCRIPT>
				<SCRIPT language="JavaScript" type='text/javascript' src="Deal_confirm.js"></SCRIPT>
				
			</body>
		</html>
		
