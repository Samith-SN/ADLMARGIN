
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
	
	
	
%>

<HTML>
	<HEAD>
		<TITLE>MFactor</TITLE>
		
	</HEAD>   
	<SCRIPT language="JavaScript"> 	     
		
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
									alert("'To Date' should be greater than 'From Date' .");
								}
					}
					else{
						alert("'To Date' should be greater than 'From Date' .");
					}
				}
				else{
					if((parseInt(document.Form1.TXT_YEAR_FROM.value))>=(parseInt(document.Form1.TXT_YEAR_TO.value))){
						alert("'To Date' should be greater than 'From Date' .");
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
						alert("'To Date' should be greater than 'From Date' .");
					}
				}
				else{
					if((parseInt(document.Form1.TXT_YEAR_FROM.value))<(parseInt(document.Form1.TXT_YEAR_TO.value))){
					}
					else{
						alert("'To Date' should be greater than 'From Date' .");
					}
				}
			}
		}
		
		
		
		
		function chkstartdate(dayobj,monthobj,yearobj) {
			checkMonthLength(dayobj,monthobj,yearobj);		
		}
		
		function Load_Report()
		{
			
			var inv_type ="";
			inv_type =document.Form1.INV_TYPE.value;
			
			if (inv_type=="OR" && document.Form1.TXT_DATE_FROM.value!==""	&& document.Form1.TXT_MONTH_FROM.value !=="" && document.Form1.TXT_YEAR_FROM.value !=="" && document.Form1.TXT_DATE_TO.value !=="" && document.Form1.TXT_MONTH_TO.value !=="" && document.Form1.TXT_YEAR_TO.value !=="" )
			{
				//if((document.Form1.TXT_YEAR_TO.value)=="" &&  (document.Form1.TXT_MONTH_FROM.value)=="" && (document.Form1.TXT_YEAR_FROM.value)=="")
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_settlement?&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_or_settlement";
				popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
				popupwin2.focus();
			}
			else if (inv_type=="ORP" && document.Form1.TXT_DATE_FROM.value!==""	&& document.Form1.TXT_MONTH_FROM.value !=="" && document.Form1.TXT_YEAR_FROM.value !=="" && document.Form1.TXT_DATE_TO.value !=="" && document.Form1.TXT_MONTH_TO.value !=="" && document.Form1.TXT_YEAR_TO.value !=="" )
			{
				//if((document.Form1.TXT_YEAR_TO.value)=="" &&  (document.Form1.TXT_MONTH_FROM.value)=="" && (document.Form1.TXT_YEAR_FROM.value)=="")
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_settlement?&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_or_parchase_settlement";
				popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
				popupwin2.focus();
			}
			else if (inv_type=="ORS" && document.Form1.TXT_DATE_FROM.value!==""	&& document.Form1.TXT_MONTH_FROM.value !=="" && document.Form1.TXT_YEAR_FROM.value !=="" && document.Form1.TXT_DATE_TO.value !=="" && document.Form1.TXT_MONTH_TO.value !=="" && document.Form1.TXT_YEAR_TO.value !=="" )
			{
				//if((document.Form1.TXT_YEAR_TO.value)=="" &&  (document.Form1.TXT_MONTH_FROM.value)=="" && (document.Form1.TXT_YEAR_FROM.value)=="")
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_settlement?&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_or_sales_settlement";
				popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
				popupwin2.focus();
			}
			else if(document.Form1.TXT_DATE_FROM.value==""	&& document.Form1.TXT_MONTH_FROM.value =="" && document.Form1.TXT_YEAR_FROM.value =="" && document.Form1.TXT_DATE_TO.value =="" && document.Form1.TXT_MONTH_TO.value =="" && document.Form1.TXT_YEAR_TO.value =="") //added to remove confusion of not running the button click
			{
				alert('Make Sure To Date and From Date Are Entered');
				
			}	
			
			
		}
		
		function select_type()
		{
			var inv_type ="";
			
			inv_type =document.Form1.INV_TYPE.value;
			if(inv_type=="OR" ||inv_type=="ORS" || inv_type=="ORP")
			{//mod by waruna
				
				document.Form1.Report_2.disabled=false;
				
			}
			else
			{
				
				document.Form1.Report_2.disabled=true;
			}
		}
		
		
		function displaydata()
		{
			if (document.Form1.TXT_DATE_FROM.value!==""	&& document.Form1.TXT_MONTH_FROM.value !=="" && document.Form1.TXT_YEAR_FROM.value !=="" && document.Form1.TXT_DATE_TO.value !=="" && document.Form1.TXT_MONTH_TO.value !=="" && document.Form1.TXT_YEAR_TO.value !=="" ){
				
				if(document.Form1.INV_TYPE.value=="OR")
				{
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_trans?&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_or";
					popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
					popupwin2.focus();
				} 
				else if(document.Form1.INV_TYPE.value=="ORS")
				{ //add by waruna 2010-09-13
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_trans?&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_sales";
					popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
					popupwin2.focus();
				} 
				else if(document.Form1.INV_TYPE.value=="ORP")
				{ //add by waruna 2010-09-13
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_trans?&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_purchase";
					popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
					popupwin2.focus();
				} 
				
				else if(document.Form1.INV_TYPE.value=="RF")
				{
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_trans?&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_rf";
					popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
					popupwin2.focus();
				}
				else if(document.Form1.INV_TYPE.value=="RR")
				{
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_trans?&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_rr";
					popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
					popupwin2.focus();
				}
				else if(document.Form1.INV_TYPE.value=="RS"){
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_trans?&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_rs";
					popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
					popupwin2.focus();
				}
				else if(document.Form1.INV_TYPE.value=="BF")
				{
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_trans?&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_bf";
					popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
					popupwin2.focus();
				}
				else if(document.Form1.INV_TYPE.value=="BS")
				{
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_trans?&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_bs";
					popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
					popupwin2.focus();
				}
				else if(document.Form1.INV_TYPE.value=="SR")
				{
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_trans?&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_sr";
					popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
					popupwin2.focus();
				}
				else if(document.Form1.INV_TYPE.value=="SO")
				{
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_trans?&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_so";
					popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
					popupwin2.focus();
				}
			}
		}
		
		
		function  exit()
		{
			window.location.href='<%=m_jsp_client_url%>/low.jsp';
			
		}
		function  cancel()
		{
			window.location.href='<%=m_jsp_client_url%>/dn_transactions.jsp';
			
		}
		
		$(document).ready(function() 
			{
				initCal('FROM_TXT_DATE');
				initCal('TO_TXT_DATE');
				
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
		
		
	</SCRIPT>
	<BODY class='body & txt-body' onLoad="select_type();">
		
		<FORM NAME="Form1" METHOD="POST" >
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="reveryfication">
			
			
			<table width="100%"BORDER="0" cellpadding="0" cellspacing="0" >							
				
				<td width="100%">
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
										<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Management Information - Transactions</B></td>
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
						
						<!--	<tr>
						<td >			
						<table width="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0" >
						<tr><br></tr>
						<tr>
						<td width="12%">Deal Type</TD>  
						<td width="72%">	 	
						<select class="txt_input6" name="INV_TYPE" onChange="parent.frames[0].display_head();select_type();">
						<option VALUE="OR" SELECTED>Outrights</option> 
						<option VALUE="ORS" SELECTED>Sales</option> 
						<option VALUE="ORP" SELECTED>Purchase</option> 
						<option VALUE="RF">Borrowings</option>    
						<option VALUE="RR">Lendings</option> 
						<option VALUE="RS">Settlements</option>    	
						</select>    
						</td>  
						<td width="30%" align="absmiddle">			
						<INPUT TYPE="Button" class="mainbut" NAME="Report_2" style="width:150px"  VALUE="SETTLEMENT DATE" onClick="Load_Report()">
						</td>  
						</tr> 
						</table>
						</td>
						</tr>
						-->
						<tr>
							<td>	
								<table WIDTH="100%" border="0" cellpadding="1" cellspacing="0" >
									<tr><br></tr>
									<tr>
										<td width="1%"></TD>
										<td width="12%">Deal Type</TD>
										<td width="30%">
											<select class="txt_input6" name="INV_TYPE" onChange="select_type();">
												<option VALUE="OR" SELECTED>Outrights</option> 
												<option VALUE="ORS" SELECTED>Sales</option> 
												<option VALUE="ORP" SELECTED>Purchase</option> 
												<option VALUE="RF">Borrowings</option>    
												<option VALUE="RR">Lendings</option> 
												<option VALUE="RS">Settlements</option>    	
											</select>    	
										</td> 	
										<td width="12%"></TD>
										<td width="30%" >
										</td>
										<td width="30%" align="center" >
											<INPUT TYPE="Button" class="mainbut" NAME="Report_2" style="width:110px"  VALUE="SETTLEMENT DATE" onClick="Load_Report()">	
										</td>		
									</tr>	
									<tr><td width="1%"></TD>

										<td width="12%">From Date</TD> 
										<td width="30%">
											<INPUT TYPE="Text" class="txt_input6" NAME="TXT_DATE_FROM" SIZE=3 MAXLENGTH=2>
											<INPUT TYPE="Text" class="txt_input6" NAME="TXT_MONTH_FROM" SIZE=3 MAXLENGTH=2>
											<INPUT TYPE="Text" class="txt_input6" NAME="TXT_YEAR_FROM" SIZE=5 MAXLENGTH=4 ONBLUR="chkstartdate(document.Form1.TXT_DATE_FROM,document.Form1.TXT_MONTH_FROM,document.Form1.TXT_YEAR_FROM)"> 								
											<input type = "hidden" name = "FROM_TXT_DATE" id = "FROM_TXT_DATE" />
										</td> 
										<td width="12%">To Date</td> 
										<td width="30%">
											<INPUT TYPE="Text" class="txt_input6" NAME="TXT_DATE_TO" SIZE=3 MAXLENGTH=2>
											<INPUT TYPE="Text" class="txt_input6" NAME="TXT_MONTH_TO" SIZE=3 MAXLENGTH=2>
											<INPUT TYPE="Text" class="txt_input6" NAME="TXT_YEAR_TO" SIZE=5 MAXLENGTH=4 ONBLUR="chkstartdate(document.Form1.TXT_DATE_TO,document.Form1.TXT_MONTH_TO,document.Form1.TXT_YEAR_TO);chk_validity()"> 								
											<input type = "hidden" name = "TO_TXT_DATE" id = "TO_TXT_DATE" />
										</td> 
										<td width="30%" align="center">			
											<INPUT TYPE="Button" NAME="Report_1" VALUE="VALUE DATE" STYLE="width:110px" class="mainbut" onClick="displaydata()">
										</td> 
									</tr> 
								</table>
							</td>
						</tr>
						
						<tr>
							<td>		
								<table width="100%" border="0" cellpadding="2" cellspacing="1" >
								</table>
							</td>
						</tr>
						
						<tr>
							<td>		
								<INPUT TYPE="Hidden" NAME="Hid_rows" >
								<DIV id=clientmgr></DIV>
							</td>
						</tr>
					</table> 		
				</td>
				
			</table> 
			
		</form>
	</body>
	<DIV>
		<SCRIPT language1.2="JavaScript" src="validate.js"></SCRIPT>
	</DIV>
</html>

