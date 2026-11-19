
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
		<TITLE>DealNet</TITLE>
		
	</HEAD>
	<SCRIPT language="JavaScript">
		var very;
		var x=0;
		var y=0;
		var x1=0;
		var y1=0;
		
		function default_acts()
		{
			m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'inventory_by_date_location?chksql=chk_sysdate'; 
			//window.open(m_url);
			//top.frames[0].document.applets[0].getdata(m_url); 
			//m_size=top.frames[0].document.applets[0].outvec_value.size(); 
			load_interface(m_url,'XML',false);	
			m_size=data_vec.length;
			if (m_size>0)
			{    
				document.Form1.TXT_DATE.value=data_vec[0]; 
				document.Form1.TXT_MONTH.value=data_vec[1]; 
				document.Form1.TXT_YEAR.value=data_vec[2]; 
			} 
		} 
		
		function chkstartdate(dayobj,monthobj,yearobj) {
			checkMonthLength(dayobj,monthobj,yearobj);	
		}
		function myDialogObj() {
			var htmlstr;
			var returnval;
		}
		
		function displaydata(){
			if (	document.Form1.TXT_DATE.value != ""){
				if (document.Form1.TXT_MONTH.value != ""){
					if (document.Form1.TXT_YEAR.value  != ""){
						if ((document.Form1.TXT_PCODE.value=="")||(document.Form1.TXT_PCODE.value==" " )){
							document.Form1.TXT_PCODE.value="ALL";
							
						}
						if(document.Form1.SEL_DEAL_TYPE.options[document.Form1.SEL_DEAL_TYPE.selectedIndex].value=="SC"){
							m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'inventory_by_date_location?portcode='+document.Form1.TXT_PCODE.value+'&instrument='+document.Form1.TXT_ITYPE.value+'&mdate='+dd+'-'+mm+'-'+document.Form1.TXT_YEAR.value+'&deal_type='+document.Form1.SEL_DEAL_TYPE.options[document.Form1.SEL_DEAL_TYPE.selectedIndex].value+'&chksql=mrep_data';
						}
						else if(document.Form1.SEL_DEAL_TYPE.options[document.Form1.SEL_DEAL_TYPE.selectedIndex].value=="SL"){
							m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'inventory_by_date_location?portcode='+document.Form1.TXT_PCODE.value+'&instrument='+document.Form1.TXT_ITYPE.value+'&mdate='+dd+'-'+mm+'-'+document.Form1.TXT_YEAR.value+'&deal_type='+document.Form1.SEL_DEAL_TYPE.options[document.Form1.SEL_DEAL_TYPE.selectedIndex].value+'&chksql=mrep_data_SL';
							
						}
						else{
							m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'inventory_by_date_location?portcode='+document.Form1.TXT_PCODE.value+'&instrument='+document.Form1.TXT_ITYPE.value+'&mdate='+dd+'-'+mm+'-'+document.Form1.TXT_YEAR.value+'&deal_type='+document.Form1.SEL_DEAL_TYPE.options[document.Form1.SEL_DEAL_TYPE.selectedIndex].value+'&chksql=mrep_data';
						}
						popupwin2 = window.open(m_url,'displayWindow2','left=0,top=160,width=799,height=340,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
						popupwin2.focus();
					}
				}
			}
		}
		
		function portcheck(objx){
			if (objx.value!="") {
				m_portcode=objx.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"inventory_by_date_location?port_code="+m_portcode.toUpperCase()+"&chksql=chkport";
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				load_interface(m_url,'XML',false);	
				m_size=data_vec.length; 
				if (m_size==0) 
				{
					port_help(0);
					objx.focus();
				}
			}
		}
		
		
		
		
		
		function instrument_help(m_strat)
		{
			var aForm;    //  aForm =oForm.elements;
			aForm =  document.getElementById('Form1');
			
			var myObject=new Array(); //return values set to this object
			myObject[0]=aForm.TXT_ITYPE; //2011-09-27
			//myObject[1]=aForm.Text_loc_desc;;
			myObject[1]=null;
			myObject[2]=null;
			myObject[3]=null;
			myObject[4]=null;
			
			var myObject_value=new Array(); //passing values set to this object
			//myObject_value[0]=aForm.TXT_UNAME.value; //2011-09-27
			myObject_value[0]=null; //2011-09-27
			myObject_value[1]=null;//aForm.Text_loc_code.value;
			myObject_value[2]=null;
			myObject_value[3]=null; 
			
			myObject_value[4]=null;
			
			
			var myObject_type=new Array(); //passing values data type
			//myObject_type[0]="StringL";
			myObject_type[0]=null;
			//myObject_type[1]="StringL";
			myObject_type[1]=null;
			myObject_type[2]=null;
			myObject_type[3]=null;
			myObject_type[4]=null;
			
			
			var qid=85;
			
			//help_scr_type=document.Form1.SCR_TYPE;//2011-09-27
			
			
			title_name='Instrument Types';
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
							//aForm.TXT_ITYPE.focus();
						}
						if(returnedValue == null){
							instrument_help_close();
						} 
					} //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
		}
		
		function instrument_help_close()
		{
			document.Form1.TXT_ITYPE.value="";	
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		function port_help(m_strat)
		{
			var aForm;    //  aForm =oForm.elements;
			aForm =  document.getElementById('Form1');
			
			var myObject=new Array(); //return values set to this object
			myObject[0]=aForm.TXT_PCODE; //2011-09-27
			//myObject[1]=aForm.Text_loc_desc;;
			myObject[1]=null;
			myObject[2]=null;
			myObject[3]=null;
			myObject[4]=null;
			
			var myObject_value=new Array(); //passing values set to this object
			//myObject_value[0]=aForm.TXT_UNAME.value; //2011-09-27
			myObject_value[0]=aForm.TXT_PCODE.value; //2011-09-27
			myObject_value[1]=aForm.TXT_PCODE.value;//aForm.Text_loc_code.value;
			myObject_value[2]=aForm.TXT_PCODE.value;
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
			
			
			var qid=84;
			
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
							facility_help_close();
						} 
					} //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
		}
		
		function facility_help_close()
		{
			document.Form1.TXT_PCODE.value="";	
		}
		
		
		
		/*
		--2011-11-17
		function port_help(obj1) {
			m_buycode=obj1.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"inventory_by_date_location?buyer_code="+m_buycode.toUpperCase()+"&chksql=port_lookup";
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			load_interface(m_url,'XML',false);	
			m_size=data_vec.length; 
			vec_pos=0;
			lineno=1;
			m_row="";
			while (vec_pos<m_size) 
			{
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
		function instcheck(objx){
			if (objx.value!="") {
				m_portcode=objx.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"inventory_by_date_location?inst_code="+m_portcode.toUpperCase()+"&chksql=chkinst";
				load_interface(m_url,'XML',false);	
				m_size=data_vec.length; 
				if (m_size==0) {
					instrument_help(0);
					//objx.focus();
				}
			}
		}
		
		function  exit()
		{
			window.location.href='<%=m_jsp_client_url%>/low.jsp';
			
		}
		function  cancel()
		{
			window.location.href='<%=m_jsp_client_url%>/inventory_by_date_location.jsp';
			
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
		
		function dateSelectFunc(dateText, inst) 
		{
			var splitResult = dateText.split('-');
			var instance_id = inst.id;
			var m_last_index_of_underscore = instance_id.lastIndexOf('_');
			var first_part = instance_id.substr(0, m_last_index_of_underscore + 1);
			var second_part = instance_id.substr(m_last_index_of_underscore + 1);
			if (instance_id == "FROM_TXT_DATE") 
			{
				document.Form1.TXT_DATE.value = splitResult[0];
				document.Form1.TXT_MONTH.value = splitResult[1];
				document.Form1.TXT_YEAR.value = splitResult[2];
				document.Form1.TXT_YEAR.focus();
			}
			
		}
		</SCRIPT>
	<BODY class='body & txt-body' onload="default_acts()">
		<FORM id="Form1" NAME="Form1" METHOD="POST" >
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="reveryfication">
			<table class='table' align='center' width="100%">
				<tr>
					<td>
						<table class='table' align='center' width="100%" border="0" cellpadding="0" cellspacing="0" >
							<!-- <table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 	-->
							<tr>
								<td height='7'></td>
							</tr>
							<tr height="30">		
								<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
								<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Management Information - Inventory By Date- Location</B></td>
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
						<table width="100%"  >
							<tr ><td height='20px' ></td></tr>
						</table>
						
						
					</td>	
				</tr>		
				
				<tr>
					<td>		
						<table width="100%"BORDER="0" align="center" CELLPADDING="1" CELLSPACING="0" >
							<tr>
								<td width="1%"></td>
								<td width="12%">Portfolio Code</td>
								<td width="23%">
									<input type="Text" class="txt_input6"  name="TXT_PCODE" onblur="portcheck(document.Form1.TXT_PCODE)" align="LEFT" size=15 maxlength=10 >
									<input type="button" class="mainbut" value="Help" name="BUT_BCODE" onclick="port_help(0)" >  <!-- port_help(document.Form1.TXT_PCODE) -->
								</td>
								<td width="9%">Instrument</td>
								<td width="28%">
									<input type="Text" class="txt_input6" name="TXT_ITYPE" onblur="instcheck(document.Form1.TXT_ITYPE)" align="LEFT" size=15 maxlength=10 >
									<input type="button" class="mainbut" value="Help" name="BUT_BCODE" onclick="instrument_help(0)" >  <!-- inst_help(document.Form1.TXT_ITYPE) -->
								</td>
								<td width="27%"></td>
							</tr>	
							<tr>	
								<td width="1%"></TD>
								<td width="12%">Date</TD> 
								<td width="23%">
									<input type="Text" class="txt_input6" name="TXT_DATE" size=2 maxlength=2>
									<input type="Text" class="txt_input6" name="TXT_MONTH" size=2 maxlength=2>
									<input type="Text" class="txt_input6" name="TXT_YEAR" size=5 maxlength=4 onblur="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR)">
									<input type = "hidden" name = "FROM_TXT_DATE" id = "FROM_TXT_DATE" />
								</td> 								
								<td width="9%">Deal Type</TD>
								<td width="28%">
									<select class="txt_input6" NAME="SEL_DEAL_TYPE">
										<OPTION VALUE="SC" SELECTED>Scrip</OPTION>
										<OPTION VALUE="SL">Scripless</OPTION>
										<OPTION VALUE="ALL">All</OPTION>
									</select>
								</td>
								<td width="*%" align="left">
									<input type="button" value="Go" class="mainbut" name="BUT_UNAME" onclick="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR);displaydata()" >
									<!-- <img STYLE="{cursor:hand;}" src='go.gif' ONCLICK="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR);displaydata()" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"> -->
								</td>
							</tr>
						</table>
					</td>			
				</tr>
			</table>
			
		</FORM>
	</BODY>
	<DIV>
		<SCRIPT language1.2="JavaScript" src="validate_v1.js"></SCRIPT>
		<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
	</DIV>
</html>

