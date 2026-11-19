<%@page import="net.sasianet.ADLMARGIN.*" %>
<HTML>
	<HEAD>
	<TITLE>Margin Trading</TITLE>
		
		<!--<LINK REL="stylesheet" TYPE="text/css" HREF="http://www.srilanka.sasianet.lk/MFactor/navbar.css" />-->
		
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
			
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
        out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
		
		
			
	    %>
	<SCRIPT language="JavaScript1.2">
		
		var s_status=false;
		
		
		function chk_holiday(obj_date,obj_month,obj_year) {
				if (checkMonthLength(obj_date,obj_month,obj_year)) {
					m_date=obj_date.value+'/'+obj_month.value+'/'+obj_year.value;
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalholiday?chksql=set_holiday&date="+m_date+"";
					parent.frames[0].document.applets[0].getdata(m_url);
					m_size=parent.frames[0].document.applets[0].outvec_value.size();
					val=(document.Form1.Text_option.selectedIndex);
					<!----------------add ---------------------->	
					if(val==0){
						//document.Form1.Text_help.disabled=true;
						if (m_size >0) {
							alert("Holiday is already existing");
						}
						else {
							give_day(document.Form1.Text_date,document.Form1.Text_month,document.Form1.Text_year);
						}
					} 
					<!----------------modify ---------------------->
					else if(val==1){
						//document.Form1.Text_help.disabled=true;
						if (m_size >0) {
							document.Form1.Text_ins_desc.value=parent.frames[0].document.applets[0].outvec_value.elementAt(1);
							//document.Form1.Text_date.disabled=true;
							//document.Form1.Text_month.disabled=true;
							//document.Form1.Text_year.disabled=true;
						}
			
						else {
							alert("No such holiday exist to modify");
						}
					}
					<!----------------delete ---------------------->
					else if(val==2){
						if (m_size >0) {
							document.Form1.Text_ins_desc.value=parent.frames[0].document.applets[0].outvec_value.elementAt(1);
						}
						else {
							alert("No such holiday exist to delete");
						}
					}
			}
		}
		
			function give_day(obj_date,obj_month,obj_year){
					document.Form1.Text_ins_desc.value='';
					m_date=obj_date.value+'/'+obj_month.value+'/'+obj_year.value;
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalholiday?chksql=see_holi_day&date="+m_date+"";
					parent.frames[0].document.applets[0].getdata(m_url);
					//m_size=parent.frames[0].document.applets[0].outvec_value.size();
					//val=(document.Form1.Text_option.selectedIndex);
					m_select_day=parent.frames[0].document.applets[0].outvec_value.elementAt(0)
					if (m_select_day.trim()=="SATURDAY" || m_select_day.trim()=="SUNDAY" ) {
						document.Form1.Text_ins_desc.value=parent.frames[0].document.applets[0].outvec_value.elementAt(0);
					}
			}

			function myDialogObj() {
			var htmlstr; 
			var returnval;
			}
			function chk_sector(s_obj) {
			if(s_obj.value!=0)   {
			m_s_type=s_obj.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mfsenddata1?sec_code="+m_s_type+"&chksql=sector";
			parent.frames[0].document.applets[0].getdata(m_url);
			m_size=parent.frames[0].document.applets[0].outvec_value.size();
			if(m_size>0)   {
			alert('The entered sector code already exists');
			parent.frames[1].location.href='sector_v1.html';   
			s_status=true;
			}
			else {
			document.Form1.Text_s_desc.focus();
			document.Form1.save_but.disabled=false;
			s_status=false;
			}
			}
			else {
			alert('Please enter the sector code');
			s_status=true;
			document.Form1.Text_s_type.focus();
			}
			}	
			function chk_desc(obj1,obj2) {
			if(!s_status) {
			if(obj1.value=="")  {
			alert('Please enter the sector description');
			document.Form1.Text_s_desc.focus();
			document.Form1.save_but.disabled=true;
			}
			else {
			document.Form1.save_but.disabled=false;
			}
			}
			}			
			function keydownwaspressed() {
			m_keycode=window.event.keyCode;
			if (m_keycode==119) {  
			beforesubmit();
			}
			else if (m_keycode==120) {  
			parent.frames[1].location.href='mfmain.html';
			}
			}
			function disable_save() {
			document.Form1.save_but.disabled=true;
			document.Form1.close_but.disabled=false;
			}	
		
		function BeforeSave(){
		beforesubmit();
		}
			
			function beforesubmit(){
			if(document.Form1.Text_ins_desc.value=="") {
			alert('Please enter the Changes');
			document.Form1.Text_ins_desc.focus();
			}
			else {
			
				/*if (val==1) {
					document.Form1.Hid_scr_name.value="Holiday_Modi";
				}
				if (val==2) {
					document.Form1.Hid_scr_name.value="Holiday_Dele";
				}*/
						
			
			Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsavholiday"	
			Form1.submit();			
			}
			}
			
			
			
				
		function display_sec_opt(m_val){
			
			//document.Form1.SAVETYPE.value=parent.frames[0].document.Form1.SCR_TYPE.options[parent.frames[0].document.Form1.SCR_TYPE.selectedIndex].value;
		//	if(document.Form1.SCR_TYPE.options[document.Form1.SCR_TYPE.selectedIndex].value=='NEW'){
				
			  if(m_val=="new"){
				document.getElementById('div_lable').innerHTML='Holidays - New'; //added by Prabash on 24-11-2011	
			    clearAll();
			    document.Form1.Hid_scr_name.value='Holiday_New';
					
			  }else if(m_val=="mod"){ 
					
				document.getElementById('div_lable').innerHTML='Holidays - Edit'; //added by Prabash on 24-11-2011
			   	clearAll();
			   	document.Form1.Hid_scr_name.value='Holiday_Modi';
			   	document.Form1.Text_help.disabled=false;
					
			   }else if(m_val=="del"){ 
					
				document.getElementById('div_lable').innerHTML='Holidays - Delete'; //added by Prabash on 24-11-2011
			    clearAll();
				document.Form1.Hid_scr_name.value='Holiday_Dele';
				document.Form1.Text_help.disabled=false;
			  }else{
				alert('Please Select Add/Modify/Delete');
			}

		}
		
		function date_help(){
					
			if(document.Form1.Hid_scr_name.value=="Holiday_New"){
			//	alert('55');
			//	portP_help(document.Form1.TXT_portfolio.value);
					
			}else if (document.Form1.Hid_scr_name.value=="Holiday_Modi"){
					data_help_mod(0);
				
			}else if (document.Form1.Hid_scr_name.value=="Holiday_Dele"){
			       data_help_mod(0);
			}else{
				alert('Please Select Add/Modify/Delete');
			}
		}
			
		
		
			function view_holidaysheet(){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalholiday?chksql=view_holidaysheet_button";
				parent.frames[0].document.applets[0].getdata(m_url);
				m_size=parent.frames[0].document.applets[0].outvec_value.size();
				vec_pos=0;
				m_row="";
				lineno=1;
				while (vec_pos<m_size) {
					m_acc_no=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
					m_acc_no_refno=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
					m_row=m_row+'<TR STYLE="{color:black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white"  ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_acc_no+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_acc_no_refno+'</B></TD></TR>';
					vec_pos=vec_pos+2;
					lineno=lineno+1;
					}
					m_writedata ='<TABLE BGCOLOR="gray" WIDTH="100%" STYLE="{color: darkblue; font: 9pt sans-serif;}">'+
						'<TR BGCOLOR="darkgray"><TD WIDTH="15%"><B>Holiday</B></TD>' +
							'<TD WIDTH="85%"><B>Holiday Description</B></TD></TR>'+
						m_row+
						'</TABLE>'; 
					myDialogObj.htmlstr = m_writedata;
					myDialogObj.returnval = "";
					popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
					//document.Form1.Text_acc_number.value=myDialogObj.returnval;
					//document.Form1.Text_acc_number.focus();
					}
					
				/*function date_help(){
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalholiday?chksql=view_holidaysheet_button";
					parent.frames[0].document.applets[0].getdata(m_url);
					m_size=parent.frames[0].document.applets[0].outvec_value.size();
					vec_pos=0;
					m_row="";
					lineno=1;
					while (vec_pos<m_size) {
						m_acc_no=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
						m_acc_no_refno=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
						m_row=m_row+'<TR STYLE="{color:black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white"  ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_acc_no+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_acc_no_refno+'</B></TD></TR>';
						vec_pos=vec_pos+2;
						lineno=lineno+1;
						}
						m_writedata ='<TABLE BGCOLOR="gray" WIDTH="100%" STYLE="{color: darkblue; font: 9pt sans-serif;}">'+
							'<TR BGCOLOR="darkgray"><TD WIDTH="15%"><B>Holiday</B></TD>' +
								'<TD WIDTH="85%"><B>Holiday Description</B></TD></TR>'+
							m_row+
							'</TABLE>'; 
						myDialogObj.htmlstr = m_writedata;
						myDialogObj.returnval = "";
						popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
						m_date=myDialogObj.returnval;
						document.Form1.Text_date.value=m_date.substring(0,2);
						document.Form1.Text_month.value=m_date.substring(3,5);
						document.Form1.Text_year.value=m_date.substring(6,10);
						
						//document.Form1.Text_ins_desc.value=myDialogObj.returnval;
						document.Form1.Text_year.focus();
						}
				*/
	function data_help_mod(m_strat){
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	 /*  var myObject = new Object();
   	 myObject.firstName = aForm.oFirstName.value;
   	 myObject.lastName = aForm.oLastName.value;
		*/
		var myObject=new Array(); //return values set to this object
 		myObject[0]=null;
 		myObject[1]=aForm.Text_ins_desc;
 		myObject[2]=aForm.Text_date;
		myObject[3]=aForm.Text_month;
		myObject[4]=aForm.Text_year;
  
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.Text_date.value+aForm.Text_month.value+aForm.Text_year.value;
 		
		 
 		var myObject_type=new Array(); //passing values data type
 		myObject_type[0]="StringL";
 		
 		var qid='6';
		var hid='3';	
     
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
		 height:400,// 500,
		 width: 700,//900,
		 title: 'SasiNet',		  
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
	}
					
				function clearAll(){
					document.Form1.Text_date.value="";
					document.Form1.Text_month.value="";
					document.Form1.Text_year.value="";
					document.Form1.Text_ins_desc.value="";
					}
				function screenclose(){
					top.frames[1].location=(html_client_url+'/low.html');
					}
					
				</SCRIPT>
				<BODY ONLOAD="display_sec_opt('new')"  class='body & txt-body' >
					<!--<DIV STYLE="{cursor:hand; color: black; font: bold 8pt arial}" ALIGN="RIGHT" >MBFS/04/07/00</DIV>-->
					<FORM NAME="Form1"  ID="Form1" METHOD="POST" >
						<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="Holiday_New">
			
			
			<DIV>
			<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
				<tr>
			<td height='7'></td>
			</tr>
				
			<tr height='30' >
			<td  width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
			<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Administration - System Maintenance</B></td>
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
						<INPUT TYPE="Button" NAME="NEW" VALUE="Add"   onClick="display_sec_opt('new');"  class="mainbut"  >
					</TD>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="MOD" VALUE="Edit"   onClick="display_sec_opt('mod');" class="mainbut"  >
					</TD>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="DEL" VALUE="Delete"   onClick="display_sec_opt('del');"  class="mainbut"  >
					</TD>
					<TD WIDTH='6%'></TD>		
					<!---------------------------------->
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="save_but" VALUE="Save"   onClick="BeforeSave()" class="mainbut"  >
					</TD>
					
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"   onClick="clearAll()" class="mainbut"> 
				</TD>
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit"   onClick="top.frames[1].location.href='low.jsp'" class="mainbut"> 
					</TD>
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="report_but" VALUE="Enquiry"    onClick="obtain_report_before()" class="mainbut">
						
					</TD>
					
						<!--<TD  WIDTH="50%" class="hh1" align="right">-->
						<!--<B>Holidays</B>-->
						<TD> <B><div id='div_lable' align='right' > </div> </B> </TD>				
					</TD>					
				</TR>
			</TABLE>
		  
			<TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
			<HR>
				<TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
			
			<BR>		
						
			
			
				<!--		<TABLE WIDTH="100%" BORDER="0" BGCOLOR="darkblue" STYLE="{border-style: none;}" >
							<TR BGCOLOR="darkblue">
								<TD WIDTH="26%">
									<SELECT NAME="Text_option" STYLE="{color: black; font: bold 10pt arial;}" onChange="display_holi_opt()">
										<OPTION VALUE="IN" SELECTED>Add Holiday</option> 
									<OPTION VALUE="UP" >Modify Holiday</option> 
								<OPTION VALUE="DEA" >Delete Holiday</option> 
							<OPTION VALUE="V" onClick="view_holiday()">View Holidays</option>
					</SELECT></TD>
				<TD  WIDTH="30%">	
					<INPUT TYPE="Button" NAME="save_but" VALUE="Save&nbsp; "   STYLE="{cursor:hand; color: black; font: bold 9pt arial;border-style: outset; background-color: darkgray;}" onClick="beforesubmit()">
					<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"  STYLE="{cursor:hand; color: black; font: bold 9pt arial;border-style: outset;background-color: darkgray; }" onClick="clearing()">
					<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit&nbsp&nbsp;  "  STYLE="{cursor:hand; color: black; font: bold 9pt arial;border-style: outset;background-color: darkgray; }" onClick="screenclose()"> 
				</TD>
				<TD STYLE="{color: white ;font: bold 10pt arial;text-align:right;}" WIDTH="44%">
					<B>System Maintenance - Holidays</B>
				</TD>					
			</TR>
						</TABLE> -->
		
		<TABLE	BORDER="0" CELLPADDING="1" CELLSPACING="0">
			<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0">
				<TR>
					<TD WIDTH="1%"></TD>
					<TD  WIDTH="25%" >Date </TD>
					<TD WIDTH="75%" ><INPUT TYPE="Text" NAME="Text_date"	ALIGN="LEFT" SIZE="3" MAXLENGTH="2" class="txt_input5" >
						<INPUT TYPE="Text" NAME="Text_month"	ALIGN="LEFT" SIZE="3" MAXLENGTH="2" class="txt_input5" >
						<INPUT TYPE="Text" NAME="Text_year"	ALIGN="LEFT" SIZE="5" MAXLENGTH="4" onBlur="chk_holiday(document.Form1.Text_date,document.Form1.Text_month,document.Form1.Text_year)" class="txt_input5" >	
						<INPUT TYPE="BUTTON" NAME="Text_help" onClick="date_help();"  VALUE="..." class="but_input" disabled='true' ></TD>  </TR>
			</TABLE>
			<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0">
				<TR>
					<TD WIDTH="1%"></TD>
					<TD  WIDTH="25%" > Description</TD>
					<TD WIDTH="75%"><INPUT	TYPE="Text" NAME="Text_ins_desc"	ALIGN="LEFT" SIZE="30" MAXLENGTH="30" class="txt_input6" ></TD>
				</TR>
				<TR></TR>
				<TR></TR>
			</TABLE>
		</TABLE>
	</FORM>
	<!--		<SCRIPT LANGUAGE="JavaScript" SRC="http://www.srilanka.sasianet.lk/Mbfsl/mbfsl.js"></SCRIPT> -->
	<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
	<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>
	
	
    </body>
</html>


