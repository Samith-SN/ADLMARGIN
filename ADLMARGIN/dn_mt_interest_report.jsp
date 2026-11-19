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
	
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/i18n/grid.locale-en.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/jquery.jqGrid.min.js\"></script>");
	out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\""+m_jsp_client_url+"/css/ui.jqgrid.css\" />");
	
	
	/*
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/redmond/jquery-ui.css' TYPE=\"text/css\">");
			
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
        out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
	*/
	
	
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
		
		//==========Added by Yohan on 30/09/2005================================================================================
		
		
		function portcheck(objx)
		{ // to check the portfolio code
			if (objx.value!="") 
			{
				
				m_portcode=objx.value;
				m_url=servlet_client_url+':'+client_t3_port+"/"+client_name+"mbfsl_reports_TransactionLst?port_code="+m_portcode.toUpperCase()+"&chksql=port_lookup";
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				load_interface(m_url,'XML',false);
				m_size=data_vec.length;  
				
				if (m_size==0) 
				{
					CRClient_help(0);
					objx.focus();
				}
			}
		}
		
		
	
		
		
		function displaycrdata(){  
			ChkDateValidation(document.Form1.TXT_DATE_FROM,document.Form1.TXT_MONTH_FROM,document.Form1.TXT_YEAR_FROM)
			
			if(document.Form1.TXT_DATE_FROM.value!="" || document.Form1.TXT_MONTH_FROM.value!="" || document.Form1.TXT_YEAR_FROM.value!="") {
				
				m_date=document.Form1.TXT_DATE_FROM.value+"-"+document.Form1.TXT_MONTH_FROM.value+"-"+document.Form1.TXT_YEAR_FROM.value;
				sclient  = new String(document.Form1.TXT_CRCLIENT.value);	
				if ((sclient.length == 0)||(sclient == " ")){
					sclient="ALL";
				}
				//	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"cus_outstanding_rep_MT?client="+sclient.toUpperCase()+"&chksql=Customer_outstanding";
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"cus_outstanding_rep_MT?client="+sclient.toUpperCase()+"&chksql=CRCustomer_outstanding_interest&date_in="+m_date+"";
				popupwin2 = window.open(m_url,'displayWindow2','left=0,top=133,width=799,height=380,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
				popupwin2.focus();
			}
		} 
		
		<!--ADDED BY AH ON 06/10/2005 FOR SR0510-017------------------>	
		
		function displaydbdata(){
			ChkDateValidation(document.Form1.TXT_DATE_FROM,document.Form1.TXT_MONTH_FROM,document.Form1.TXT_YEAR_FROM)
			if(document.Form1.TXT_DATE_FROM.value!="" || document.Form1.TXT_MONTH_FROM.value!="" || document.Form1.TXT_YEAR_FROM.value!="") {
				
				m_date=document.Form1.TXT_DATE_FROM.value+"-"+document.Form1.TXT_MONTH_FROM.value+"-"+document.Form1.TXT_YEAR_FROM.value;
				sclient  = new String(document.Form1.TXT_CRCLIENT.value);	
				if ((sclient.length == 0)||(sclient == " ")){
					sclient="ALL";
				}
				//	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"cus_outstanding_rep_MT?client="+sclient.toUpperCase()+"&chksql=Customer_outstanding";
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_db?client="+sclient.toUpperCase()+"&chksql=mrep_data&mdate_from="+m_date+"";
			
				popupwin2 = window.open(m_url,'displayWindow2','left=0,top=133,width=799,height=380,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
				popupwin2.focus();
			}		
			
		}
		<!--END MOIFICATION DONE BY AH ON 06/10/2005 FOR SR0510-017 -->	
		
		
		//=========End of Modification done by Yohan on 30/09/2005====================================================================================		
		
		
		function myDialogObj() {
			var htmlstr; 
			var returnval;
		}
		
		
		function chkstartdate(dayobj,monthobj,yearobj) 
		{
			checkMonthLength(dayobj,monthobj,yearobj);		
		}
		
		
		function displaydata(){  
			//CURRENCY
			/*
			sclient  = new String(document.Form1.TXT_CLIENT.value);	
			
			if ((sclient.length == 0)||(sclient == " ")){
			sclient="ALL";
			}
			*/
			m_date=document.Form1.TXT_DATE_FROM.value+"-"+document.Form1.TXT_MONTH_FROM.value+"-"+document.Form1.TXT_YEAR_FROM.value;
			if(((document.Form1.TXT_DATE_FROM.value)&&(document.Form1.TXT_MONTH_FROM.value)&&(document.Form1.TXT_YEAR_FROM.value))!=""){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"cus_outstanding_rep_MT?M_DATE="+m_date+"&chksql=MT_Interest_Report";
				//alert(m_url);
				popupwin2 = window.open(m_url,'displayWindow2','left=0,top=133,width=799,height=380,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
				popupwin2.focus();
				
			}
			else{
				alert("Please Enter the Date");
			}
			
		} 
		
		

		
		
		function  exit()
		{
			window.location.href='<%=m_jsp_client_url%>/low.jsp';
			
		}
		function  cancel()
		{
			window.location.href='<%=m_jsp_client_url%>/dn_mt_interest_report.jsp';
			
		}	
		
		$(document).ready(function() 
			{
				initCal('FROM_TXT_DATE');
				
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
			
			
			var qid=91;
			
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
	<BODY class='body & txt-body' >
		<FORM NAME="Form1" id="Form1" METHOD="POST" >
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="reveryfication">
			<INPUT TYPE="Hidden" NAME="hid_help_type" ALIGN="RIGHT" SIZE=2 >	
			<TABLE WidTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" >							
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
											<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Management Information - Margin Trading Interest Report </B></td>
											<td width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>
										</tr>
									</table>
								</td>
							</tr>
							
							<tr>
								<td>	
									<table align='center' width="99%" border="0" cellpadding="2" cellspacing="0" >
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
									<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" >
										<TR><BR></TR>
										<TR>
											<td width="5%">Date</td> 
											<td width="15%">
												<INPUT TYPE="Text"   class="txt_input6" NAME="TXT_DATE_FROM" SIZE=3 MAXLENGTH=2>
												<INPUT TYPE="Text"   class="txt_input6" NAME="TXT_MONTH_FROM" SIZE=3 MAXLENGTH=2>
												<INPUT TYPE="Text"   class="txt_input6" NAME="TXT_YEAR_FROM" SIZE=5 MAXLENGTH=4 ONBLUR="ChkDateValidation(document.Form1.TXT_DATE_FROM,document.Form1.TXT_MONTH_FROM,document.Form1.TXT_YEAR_FROM)"> 
												<input type = "hidden" name = "FROM_TXT_DATE" id = "FROM_TXT_DATE" />
											</td> 
											<td width="5%" align="absmiddle">
												<INPUT TYPE="BUTTON" class="mainbut" NAME="but_go" value="Go" ONCLICK="displaydata()">
											</td>
											<td width="10%">Facility code</td> 
											<td width="15%">
												<INPUT TYPE="Text"  class="txt_input6" NAME="TXT_CRCLIENT" ONBLUR="portcheck(document.Form1.TXT_CRCLIENT)" SIZE=10  >
												<INPUT TYPE="BUTTON" class="mainbut" NAME="but_CRCLIENT" value="Help"  ONCLICK="CRClient_help(0)"><!-- CRClient_help(document.Form1.TXT_CRCLIENT) --> 								
											</td>	
											<td width="5%"> 
												<INPUT TYPE="BUTTON" class="mainbut" NAME="but_DISPLAY" style="width:100px" value=" CR CLIENTS  "  ONCLICK="displaycrdata()"> 								
											</td>
										</tr> 
										
										
										
										<tr>
											<td width="5%"></td> 
											<td width="11%"></td> 
											<td width="5%"></td> 
											<td width="10%"></td> 
											<td width="15%"></td> 
											<td width="5%">
												<INPUT TYPE="BUTTON" NAME="but_DB_DISPLAY" class="mainbut" style="width:100px" value=" DB CLIENTS  "  ONCLICK="displaydbdata()"> 								
											</td> 	
										</tr>	
									</table>
								</td>	
							</tr>		
							
							<tr>
								<td>		
									<TABLE width="100%" BORDER="0" CELLPADDING="2" CELLSPACING="1" STYLE="{color: black; font: 10pt sans-serif;}">
									</TABLE>
									<INPUT TYPE="Hidden" NAME="Hid_rows" >
									<DIV id=clientmgr></DIV>
								</td>		
							</tr>
							
						</TD>
					</TD>
				</TABLE> 
			</FORM>
		</BODY>
		<DIV>
			<SCRIPT language1.2="JavaScript" src="validate_v1.js"></SCRIPT>
			<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
		</DIV>
	</html>
	
