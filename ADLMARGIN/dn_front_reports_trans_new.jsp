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
		
		
		
		function chk_validity()
		{
			
		}
		
		
		function chkstartdate(dayobj,monthobj,yearobj) {
			checkMonthLength(dayobj,monthobj,yearobj);		
		}
		
		function Load_Report(){
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
			
		}
		
		function select_type(){
			var inv_type ="";
			inv_type =document.Form1.INV_TYPE.value;
			if(inv_type=="OR" ||inv_type=="ORS" || inv_type=="ORP"){//mod by waruna
				//document.Form1.Report_2.disabled=false;
			}
			else{
				//document.Form1.Report_2.disabled=true;
			}
		}
		
		
		function displaydata(){
			
			//  if (document.Form1.TXT_DATE_FROM.value!==""	&& document.Form1.TXT_MONTH_FROM.value !=="" && document.Form1.TXT_YEAR_FROM.value !=="" && document.Form1.TXT_DATE_TO.value !=="" && document.Form1.TXT_MONTH_TO.value !=="" && document.Form1.TXT_YEAR_TO.value !=="" ){
			if ( document.Form1.TXT_DATE_TO.value !=="" && document.Form1.TXT_MONTH_TO.value !=="" && document.Form1.TXT_YEAR_TO.value !=="" ){
				if(document.Form1.INV_TYPE.value=="OR"){
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_trans_new?&mdate_from="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_or&BCode="+document.Form1.TXT_BCODE.value;
					popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
					popupwin2.focus();
				} 
				else if(document.Form1.INV_TYPE.value=="ORS"){ //add by waruna 2010-09-13
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_trans_new?&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_sales";
					popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
					popupwin2.focus();
				} 
				else if(document.Form1.INV_TYPE.value=="ORP"){ //add by waruna 2010-09-13
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_trans_new?&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_purchase";
					popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
					popupwin2.focus();
				} 
				
				else if(document.Form1.INV_TYPE.value=="RF"){
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_trans_new?&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_rf";
					popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
					popupwin2.focus();
				}
				else if(document.Form1.INV_TYPE.value=="RR"){
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_trans_new?&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_rr";
					popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
					popupwin2.focus();
				}
				else if(document.Form1.INV_TYPE.value=="RS"){
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_trans_new?&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_rs";
					popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
					popupwin2.focus();
				}
				else if(document.Form1.INV_TYPE.value=="BF"){
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_trans_new?&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_bf";
					popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
					popupwin2.focus();
				}
				else if(document.Form1.INV_TYPE.value=="BS"){
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_trans_new?&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_bs";
					popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
					popupwin2.focus();
				}
				else if(document.Form1.INV_TYPE.value=="SR"){
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_trans_new?&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_sr";
					popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
					popupwin2.focus();
				}
				else if(document.Form1.INV_TYPE.value=="SO"){
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_trans_new?&mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&chksql=mrep_data_so";
					popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=360,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
					popupwin2.focus();
				}
			}else
			{
				alert('Please Make Sure To Date Is Not Empty');
			}	
		}
		
		function portcheck(objx){
			if (objx.value!="") {
				m_portcode=objx.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_trans_new?port_code="+m_portcode.toUpperCase()+"&chksql=chkport";
				load_interface(m_url,'XML',false);	
				m_size=data_vec.length; 
				
				if (m_size==0) 
				{
					port_help(0);
					objx.focus();
				}
			}
		}
		function myDialogObj() {
			var htmlstr;
			var returnval;
		}
		/*
		
		function port_help(obj1) {
			m_buycode=obj1.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"foffice_reports_trans_new?buyer_code="+m_buycode.toUpperCase()+"&chksql=port_lookup";
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
			vec_pos=0;
			lineno=1;
			m_row="";
			while (vec_pos<m_size) {
				m_issu_code=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
				m_issu_name=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
				m_CDS=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2);
				m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+'><B>'+m_issu_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_issu_name+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_CDS+'</B></TD></TR>';
				vec_pos=vec_pos+3;
				lineno=lineno+1;
			}
			m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color: white; font: 9pt arial;}">'+
				'<TR BGCOLOR="darkblue"><TD WIDTH="25%"><B>Portfolio Code</B></TD>' +
				'<TD WIDTH="50%"><B>Portfolio Name</B></TD><TD WIDTH="25%"><B>CDS No.</B></TD></TR>'+m_row+'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval = "";
			
			popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
			obj1.value=myDialogObj.returnval;
			obj1.focus();			
		}
		*/
		
		function  exit()
		{
			window.location.href='<%=m_jsp_client_url%>/low.jsp';
			
		}
		function  cancel()
		{
			window.location.href='<%=m_jsp_client_url%>/dn_front_reports_trans_new.jsp';
			
		}
		
		
		
		function port_help(m_strat)
		{
			var aForm;    //  aForm =oForm.elements;
			aForm =  document.getElementById('Form1');
			
			var myObject=new Array(); //return values set to this object
			myObject[0]=aForm.TXT_BCODE; //2011-09-27
			//myObject[1]=aForm.Text_loc_desc;;
			myObject[1]=null;
			myObject[2]=null;
			myObject[3]=null;
			myObject[4]=null;
			
			var myObject_value=new Array(); //passing values set to this object
			//myObject_value[0]=aForm.TXT_UNAME.value; //2011-09-27
			myObject_value[0]=aForm.TXT_BCODE.value; //2011-09-27
			myObject_value[1]=aForm.TXT_BCODE.value;//aForm.Text_loc_code.value;
			myObject_value[2]=aForm.TXT_BCODE.value;
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
			
			
			var qid=88;
			
			//help_scr_type=document.Form1.SCR_TYPE;//2011-09-27
			
			
			title_name='Broker';
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
							port_help_close();
						} 
					} //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
		}
		
		function port_help_close()
		{
			document.Form1.TXT_BCODE.value="";	
		}
		
		
			$(document).ready(function() 
			{
				
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

			if (instance_id == "TO_TXT_DATE") {
				document.Form1.TXT_DATE_TO.value = splitResult[0];
				document.Form1.TXT_MONTH_TO.value = splitResult[1];
				document.Form1.TXT_YEAR_TO.value = splitResult[2];
				document.Form1.TXT_YEAR_TO.focus();
			}
			
			
		}

		
	</SCRIPT>
	<BODY class='body & txt-body' onLoad="select_type();">
		
		<FORM NAME="Form1" id="Form1" METHOD="POST" >
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="reveryfication">
			<TABLE WidTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0" STYLE="{color: black; font: bold 9pt arial;}">							
				<TD WidTH="1%">
					<TD WidTH="99%">
						<table width="100%" >
							
							<tr>
								<td>		
									<table class='table' align='left' width="99%" border="0" cellpadding="0" cellspacing="0" >
										<!-- <table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 	-->
										<tr>
											<td height='7'></td>
										</tr>
										<tr height="30">		
											<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
											<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Management Information - Transactions New</B></td>
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
									<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
										<TR>
											<TD WIDTH="12%"><!--Deal Type-->Broker Code</TD>  
											<TD WIDTH="30%">	 	
												<INPUT TYPE="hidden" NAME="INV_TYPE" VALUE="OR" >
												<INPUT TYPE="Text" class="txt_input6"  NAME="TXT_BCODE" ONBLUR="portcheck(document.Form1.TXT_BCODE)" ALIGN="LEFT" SIZE=15 MAXLENGTH=10 >
												<INPUT TYPE="button" class="mainbut" VALUE="Help" NAME="BUT_BCODE" ONCLICK="port_help(0)" ><!-- port_help(document.Form1.TXT_BCODE) -->
											</TD>  
											<TD WIDTH="12%"></TD> 
											<TD WIDTH="30%"> 								
											</TD>
											<TD WIDTH="30%" align="absmiddle">			
											</TD>  
										</TR>
										<TR>
											<TD WIDTH="12%">To Date</TD> 
											<TD WIDTH="30%">
												<INPUT TYPE="Text" class="txt_input6" NAME="TXT_DATE_TO" SIZE=3 MAXLENGTH=2>
												<INPUT TYPE="Text" class="txt_input6" NAME="TXT_MONTH_TO" SIZE=3 MAXLENGTH=2>
												<INPUT TYPE="Text" class="txt_input6" NAME="TXT_YEAR_TO" SIZE=5 MAXLENGTH=4 ONBLUR="chkstartdate(document.Form1.TXT_DATE_TO,document.Form1.TXT_MONTH_TO,document.Form1.TXT_YEAR_TO);chk_validity()"> 								
												<input type = "hidden" name = "TO_TXT_DATE" id = "TO_TXT_DATE" />
											</TD> 
											<TD WIDTH="12%"></TD> 
											<TD WIDTH="30%"> 								
											</TD>
											<TD WIDTH="30%" align="left">			
												<INPUT TYPE="Button" NAME="Report_1" class="mainbut" VALUE="GO" onClick="displaydata()">
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
		<SCRIPT language1.2="JavaScript" src="validate.js"></SCRIPT>
		<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>	
	</DIV>
</html>

