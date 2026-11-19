
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
		<TITLE>DealNet 
		</TITLE>
		<LINK REL="stylesheet" TYPE="text/css" HREF="" />
		
	</HEAD>
	<SCRIPT language="JavaScript">
		p_enterd=false;
		
		function myDialogObj() {
			var htmlstr;
			var returnval;
		}
		
		//========================================Under Constraction check boxes============================================
		
		
		
		
		//=========================================auto ckick view==========================================================
		
		function auto_click(chk_view,chk_exe){
			m_chkexe=element[chk_exe];
			//alert(m_chkexe.checked);
			if(m_chkexe.checked==true){
				chk_name.checked=true;
			}
			else{
				chk_name.checked=false;
			}
		}
		
		
		//=========================================existing user Help=======================================================
		
		function exis_userid(uid){
			m_user_id=uid.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?user_id="+m_user_id.toUpperCase()+"&chksql=exist_user"
			load_interface(m_url,'XML',false);	
			//top.frames[0].document.applets[0].getdata(m_url);
			//window.open(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			m_size=data_vec.length; 
			vec_pos=0;
			if(m_size==0){
				//if (confirm("This User does not exists or user is inactive,..Press the OK button if you want a list of Users or Press the Cancel button to type again")) {
				//exuser_help(); 2011-09-27
				exuser_help(0);
				//}
				//else{
				//	document.Form1.TXT_UNAME.value="";
				//	document.Form1.TXT_UNAME.focus();
				//} //2011-10-
			}
			else{
				document.Form1.TXT_SURNAME.value=data_vec[1];
				document.Form1.TXT_ONAME.value=data_vec[2];
				document.Form1.TXT_LCODE.value=data_vec[3];
				document.Form1.TXT_LOCA.value=data_vec[4];
				document.Form1.TXT_DESIG.value=data_vec[5];
				document.Form1.TXT_SLEVEL.value=data_vec[6];
				document.Form1.TXT_PASS.value='**********';
				document.Form1.TXT_RE_PASS.value='**********';
				add_data(uid.value);
			}
		}
		
		
		function exis_userid_m(uid){ //add by waruna 2011-06-20
			m_user_id=uid.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?user_id="+m_user_id.toUpperCase()+"&chksql=exist_user_m"
			//top.frames[0].document.applets[0].getdata(m_url);
			load_interface(m_url,'XML',false);	
			//window.open(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			m_size=data_vec.length; 
			vec_pos=0;
			if(m_size==0){
				//if (confirm("This User does not exists or user is inactive,..Press the OK button if you want a list of Users or Press the Cancel button to type again")) { //2011-11-04
				//exuser_help(); 2011-09-27
				exuser_help(0);
				//}
				//else{  //2011-11-04
				//	document.Form1.TXT_UNAME.value="";  //2011-11-04
				//	document.Form1.TXT_UNAME.focus();    //2011-11-04
				//}  //2011-11-04
			}
			else{
				document.Form1.TXT_SURNAME.value=data_vec[1];
				document.Form1.TXT_ONAME.value=data_vec[2];
				document.Form1.TXT_LCODE.value=data_vec[3];
				document.Form1.TXT_LOCA.value=data_vec[4];
				document.Form1.TXT_DESIG.value=data_vec[5];
				document.Form1.TXT_SLEVEL.value=data_vec[6];
				document.Form1.TXT_PASS.value='**********';
				document.Form1.TXT_RE_PASS.value='**********';
				add_data(uid.value);
			}
		}
		
		
		
		function on_load(){
			///	alert(document.Form1.SCR_TYPE.value);
			//if(document.Form1.SCR_TYPE.value=='ADD'){
			//	document.Form1.BUT_UNAME.disabled=true;
			//}
			
			/*
			else if(document.Form1.SCR_TYPE.value=='MOD'){
			top.frames[1].frames[1].document.Form1.BUT_UNAME.disabled=false;
			}
			else if(document.Form1.SCR_TYPE.value=='DEA'){
			top.frames[1].frames[1].document.Form1.BUT_UNAME.disabled=false;
			}
			
			// Added by Udara on 23-05-2011
			else if(document.Form1.SCR_TYPE.value=='UTE'){
			top.frames[1].frames[1].document.Form1.BUT_UNAME.disabled=false;
			}
			
			else if(document.Form1.SCR_TYPE.value=='REA'){
			
			top.frames[1].frames[1].document.Form1.BUT_UNAME.disabled=false;
			}
			else if(document.Form1.SCR_TYPE.value=='VIE'){
			
			top.frames[1].frames[1].document.Form1.BUT_UNAME.disabled=false;
	} 			*/
		}
		
		
		/************2011-09-27********/
		function exuser_help(m_strat){
			var aForm;    //  aForm =oForm.elements;
			aForm =  document.getElementById('Form1');
			/*  var myObject = new Object();
			myObject.firstName = aForm.oFirstName.value;
			myObject.lastName = aForm.oLastName.value;
			*/
			
			var myObject=new Array(); //return values set to this object
			myObject[0]=aForm.TXT_UNAME; //2011-09-27
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
			
			/* 
			var qid='8';
			
			if(document.Form1.Hid_scr_name.value == 'Location_Reactive'){
				qid='9';	
			}
			*/
			var qid=null;
			
			help_scr_type=document.Form1.SCR_TYPE;//2011-09-27
			
			//alert('help... call'+document.Form1.SCR_TYPE.value);mcp
			if (help_scr_type.value=="ADD"||help_scr_type.value=="DEA"||help_scr_type.value=="VIE"||help_scr_type.value=="UTE")////help_scr_type.value=="MOD"|| remove add by waruna 2011-06-22
			{
				//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=exist_help";
				qid=43;
				myObject_value[0]=aForm.TXT_UNAME.value;
				myObject_value[1]=aForm.TXT_UNAME.value;
				myObject_type[0]="StringL";
				myObject_type[1]="StringL";
				
				
			}else if (help_scr_type.value=="MOD"){
				
				//add by waruna 2011-06-22
				//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=exist_help2";
				qid=44;
				
				myObject_value[0]=aForm.TXT_UNAME.value;
				myObject_value[1]=aForm.TXT_UNAME.value;
				myObject_type[0]="StringL";
				myObject_type[1]="StringL";
				
			}	
			else if (help_scr_type.value=="REA")
			{
				//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=exist_help1";
				qid=45;
				myObject_value[0]=aForm.TXT_UNAME.value;
				myObject_value[1]=aForm.TXT_UNAME.value;
				myObject_type[0]="StringL";
				myObject_type[1]="StringL";
				
			}	
			
			
			
			
			title_name='Users';
			var url = 'popup.jsp';
			var close_fun='user_help_close';			
			var json_text = JSON.stringify(myObject_value, null,0);
			var json_obj_type_text=JSON.stringify(myObject_type, null,0);
			var fn_name=arguments.callee.name;
			if(fn_name==undefined){
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
					onClose: function()
					{ 
						var returnedValue = this.returnValue; 
						set_return_value(myObject,returnedValue); 
						if(returnedValue != null){
							//
							//reset the values when the user has been changed
								//document.Form1.TXT_UNAME.value="";
								document.Form1.TXT_PASS.value="";
								document.Form1.TXT_RE_PASS.value="";
								document.Form1.TXT_SURNAME.value="";
								document.Form1.TXT_ONAME.value="";
								document.Form1.TXT_LCODE.value="";
								document.Form1.TXT_LOCA.value="";
								document.Form1.TXT_DESIG.value="";
							    document.Form1.HID_CHANGE.value="";
								$("input[type=checkbox]").each(function() {
										this.checked = false;
										this.value = "off" ; //reset 
									});
							aForm.TXT_UNAME.focus();
						}
						//alert('onclose is running');
						//if(returnedValue == null){
						//document.Form1.TXT_UNAME.value ="";
						//} 
					} //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
		}
		
		function user_help_close()
		{
			
			document.Form1.TXT_UNAME.value ="";
			
			var backupSCR_TYPE=document.Form1.SCR_TYPE.value;
			//var backupHID_CHANGE=document.Form1.HID_CHANGE.value; when canging the user to empty user this value must be reset.if one pawd change cause a value change might exists even after a mode change.then will cause a password change
			var backupHid_scr_name=document.Form1.Hid_scr_name.value;
			
			//ADDED 2011-11-07
			document.Form1.reset();
			$("input[type=checkbox]").each(function() {
					this.checked = false;
					this.value = "off" ; //reset 
				});
			//reset the values from back ups to original hidden fields
			document.Form1.SCR_TYPE.value=backupSCR_TYPE;
			//document.Form1.HID_CHANGE.value=backupHID_CHANGE.value; when canging the mode this value must be reset.if one pawd change cause a value change might exists even after a mode change.then will cause a password change
			document.Form1.Hid_scr_name.value=backupHid_scr_name;
			backupSCR_TYPE="";
			backupHid_scr_name="";
			
			
			//END 2011-11-07
			
			
			
			
			//alert('user_help_closexxxx'+document.Form1.SCR_TYPE.value);mcp
			/*
			if(document.Form1.SCR_TYPE.value == 'MOD')
			{
				selectscr('MOD');
			}
			else if(document.Form1.SCR_TYPE.value == 'DEA')
			{
				selectscr('DEA');
			}
			else if(document.Form1.SCR_TYPE.value == 'REA')
			{
				selectscr('REA');
			}
			else if(document.Form1.SCR_TYPE.value == 'UTE')
			{
				selectscr('UTE');
			}
			else if(document.Form1.SCR_TYPE.value == 'VIE')
			{
				selectscr('VIE');
			}
			else if(document.Form1.SCR_TYPE.value == 'ADD')
			{
				selectscr('ADD');
			}
			*/
		}
		/*****************2011-09-27***********************************/
		
		
		
		
		
		/*   commented 2011-09-27 add new help
		function exuser_help() {
			help_scr_type=document.Form1.SCR_TYPE;
			
			if (help_scr_type.value=="DEA"||help_scr_type.value=="VIE")////help_scr_type.value=="MOD"|| remove add by waruna 2011-06-22
			{
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=exist_help";
				//window.open(m_url);
				top.frames[0].document.applets[0].getdata(m_url);
			}else if (help_scr_type.value=="MOD"){//add by waruna 2011-06-22
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=exist_help2";
				//window.open(m_url);
				top.frames[0].document.applets[0].getdata(m_url);
			}	
			// Added by Udara on 23-05-2011
			else if (help_scr_type.value=="UTE")
			{
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=exist_help";
				top.frames[0].document.applets[0].getdata(m_url);
				
			} 
			// End by Udara on 23-05-2011
			
			
			else if (help_scr_type.value=="REA")
			{
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=exist_help1";
				top.frames[0].document.applets[0].getdata(m_url);
			}	
			m_size=top.frames[0].document.applets[0].outvec_value.size();
			vec_pos=0;
			lineno=1;
			m_row="";
			while (vec_pos<m_size) {	
				m_issu_code=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
				m_issu_name=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
				m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+'><B>'+m_issu_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_issu_name+'</B></TD></TR>';
				vec_pos=vec_pos+2;
				lineno=lineno+1;
			}
			m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color: white; font: 9pt arial;}">'+
				'<TR BGCOLOR="darkblue"><TD WIDTH="30%"><B>Designation Code</B></TD>' +
				'<TD WIDTH="70%"><B>Seniority Level</B></TD></TR>'+
				m_row+
				'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval = "";
			
			popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
			document.Form1.TXT_UNAME.value=myDialogObj.returnval;
			document.Form1.TXT_UNAME.focus();			
		}	
		
		
		*/
		
		
		//========================================dispaly selected roles==================================================
		
		function add_data(uid){		
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?user_id="+uid.toUpperCase()+"&chksql=user_info";
			//alert(m_url);
			//window.open(m_url);
			//top.frames[0].document.applets[0].getdata(m_url);
			load_interface(m_url,'XML',false);	
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			m_size=data_vec.length; 
			//window.open(m_url);
			//alert(top.frames[0].document.applets[0].outvec_value)
			k=0;
			//alert('m_size'+m_size);
			while(m_size>k){
				m_chke 		= "chke_"+data_vec[k];     //ADD
				m_chkv 		= "chkv_"+data_vec[k];     //VIEW
				m_chkEdit	= "chkEd_"+data_vec[k];    //EDIT
				chkDel		= "chkDel_"+data_vec[k];   //DEL
				chkReact 	= "chkReact_"+data_vec[k]; //REACTIVE	
				
				m_savestat = data_vec[k+1];		
				m_viewstat = data_vec[k+2];		
				m_editstat = data_vec[k+3];		
				m_delstat = data_vec[k+4];		
				m_reactstat = data_vec[k+5];		
				//alert("m_chke" +m_chke);
				//alert("m_chkv" +m_chkv);
				//alert("m_savestat" +m_savestat);
				
				if(m_savestat=='Y')
				{ 
					
					//parent.frames[2].document.form2.elements[m_chke].checked=true;	
					//parent.frames[2].document.form2.elements[m_chkv].checked=true;	
					document.Form1.elements[m_chke].checked=true;	
					document.Form1.elements[m_chkv].checked=true;
					document.Form1.elements[m_chke].value="on";	
					document.Form1.elements[m_chkv].checked="on";
					
					//alert(document.Form1.elements[m_chkv].checked);
					//alert("m_chke"+m_chke+"m_chkv"+m_chkv+document.Form1.elements[m_chkv].checked+".."+document.Form1.elements[m_chke].value);
					
				} else
				{
					//parent.frames[2].document.form2.elements[m_chke].checked=false;	
					//parent.frames[2].document.form2.elements[m_chkv].checked=true;
					document.Form1.elements[m_chke].checked=false;	
					document.Form1.elements[m_chke].value="off";//though this set to off this value will not picked up in save servelets under req.getParameter	
					//document.Form1.elements[m_chkv].checked=true;	 //COMMENTED 2011-09-26
					//alert("m_chke"+m_chke+"m_chkv"+m_chkv+document.Form1.elements[m_chkv].checked+".."+document.Form1.elements[m_chke].value);
				}
				if(m_viewstat=='Y')
				{
					document.Form1.elements[m_chkv].checked=true;	
					document.Form1.elements[m_chkv].value="on";	
				}
				else
				{
					document.Form1.elements[m_chkv].checked=false;	
					document.Form1.elements[m_chkv].value="off";//though this set to off this value will not picked up in save servelets under req.getParameter	
					
				}
				if(m_editstat=='Y')
				{
					document.Form1.elements[m_chkEdit].checked=true;	
					document.Form1.elements[m_chkEdit].value="on";	
				}
				else
				{
					document.Form1.elements[m_chkEdit].checked=false;	
					document.Form1.elements[m_chkEdit].value="off";	//though this set to off this value will not picked up in save servelets under req.getParameter
					
				}
				if(m_delstat=='Y')
				{
					document.Form1.elements[chkDel].checked=true;	
					document.Form1.elements[chkDel].value="on";	
				}
				else
				{
					document.Form1.elements[chkDel].checked=false;	
					document.Form1.elements[chkDel].value="off";//though this set to off this value will not picked up in save servelets under req.getParameter	
					
				}
				
				if(m_reactstat=='Y')
				{
					document.Form1.elements[chkReact].checked=true;	
					document.Form1.elements[chkReact].value="on";	
				}
				else
				{
					document.Form1.elements[chkReact].checked=false;	
					document.Form1.elements[chkReact].value="off";//though this set to off this value will not picked up in save servelets under req.getParameter		
					
				}	
				
				
				k=k+6; 		
			}
		}
		
		
		
		
		function desig_help(m_strat){
			var aForm;    //  aForm =oForm.elements;
			aForm =  document.getElementById('Form1');
			/*  var myObject = new Object();
			myObject.firstName = aForm.oFirstName.value;
			myObject.lastName = aForm.oLastName.value;
			*/
			
			var myObject=new Array(); //return values set to this object
			myObject[0]=aForm.TXT_DESIG; //2011-09-27
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
			
			/* 
			var qid='8';
			
			if(document.Form1.Hid_scr_name.value == 'Location_Reactive'){
				qid='9';	
			}
			*/
			var qid=48;
			
			help_scr_type=document.Form1.SCR_TYPE;//2011-09-27
			
			
			
			title_name='Users';
			var url = 'popup.jsp';
			var close_fun='desig_help_close';			
			var json_text = JSON.stringify(myObject_value, null,0);
			var json_obj_type_text=JSON.stringify(myObject_type, null,0);
			var fn_name=arguments.callee.name;
			if(fn_name==undefined){
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
							aForm.TXT_DESIG.focus();
						}
						//if(returnedValue == null){
						//	desig_help_close();
						//} 
					} //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
		}
		
		function desig_help_close()
		{
			document.Form1.TXT_DESIG.value="";
			document.Form1.TXT_DESIG.focus();
		}	
		
		//=========================================Designation Help=======================================================
		/* 2011-09-27 
		function desig_help() {
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=desig_help";
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
			vec_pos=0;
			lineno=1;
			m_row="";
			while (vec_pos<m_size) {
				m_issu_code=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
				m_issu_name=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
				m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+'><B>'+m_issu_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_issu_name+'</B></TD></TR>';
				vec_pos=vec_pos+2;
				lineno=lineno+1;
			}
			m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color: white; font: 9pt arial;}">'+
				'<TR BGCOLOR="darkblue"><TD WIDTH="30%"><B>Designation Code</B></TD>' +
				'<TD WIDTH="70%"><B>Seniority Level</B></TD></TR>'+
				m_row+
				'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval = "";
			
			popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
			document.Form1.TXT_DESIG.value=myDialogObj.returnval;
			document.Form1.TXT_DESIG.focus();			
		}	
		*/
		
		
		//=========================================check location==========================================================
		
		function chk_location(objx){
			if (objx.value=="") {
				alert('Please enter a Location Code');
				objx.value="";
				objx.focus();
			}
			else {
				m_locacode=objx.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?loca="+m_locacode.toUpperCase()+"&chksql=location";
				load_interface(m_url,'XML',false);	
				m_size=data_vec.length; 
				//window.open(m_url);
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				if (m_size==0) {
					if (confirm("Invalid Code..Press the OK button if you want a list of Codes or Press the Cancel button to type again")) {
						//location_help(); //2011-09-27
						location_help(0);
						objx.focus();
					}
					else{
						objx.focus();
						objx.value="";
						objx.focus();
					}
				}	  
				else{
					document.Form1.TXT_LOCA.value=data_vec[1];
				}
			}
		}
		
		
		/******2011-09-27 **************************/
		function location_help(m_strat){
			var aForm;    //  aForm =oForm.elements;
			aForm =  document.getElementById('Form1');
			/*  var myObject = new Object();
			myObject.firstName = aForm.oFirstName.value;
			myObject.lastName = aForm.oLastName.value;
			*/
			var myObject=new Array(); //return values set to this object
			myObject[0]=aForm.TXT_LCODE; //2011-09-27
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
			
			/* 
			var qid='8';
			
			if(document.Form1.Hid_scr_name.value == 'Location_Reactive'){
				qid='9';	
			}
			*/
			var qid=null;
			
			help_scr_type=document.Form1.SCR_TYPE;//2011-09-27
			
			qid=47;
			
			title_name='Locations';
			var url = 'popup.jsp';
			var close_fun='location_help_close';			
			var json_text = JSON.stringify(myObject_value, null,0);
			var json_obj_type_text=JSON.stringify(myObject_type, null,0);
			var fn_name=arguments.callee.name;
			if(fn_name==undefined){
				re      = /^function\s+([^(]+)/;
				fn_name = re.exec(arguments.callee.toString())[1];
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
							aForm.TXT_LCODE.focus();
						}
						//if(returnedValue == null){
						//	location_help_close();
						//} 
					} //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
		}
		
		function location_help_close()
		{
			document.Form1.TXT_LCODE.value="";
			document.Form1.TXT_LCODE.focus();
		}	
		
		
		
		/*******2011-09-27*************************/
		
		/*
		function location_help() {
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=location_help";
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
			vec_pos=0;
			lineno=1;
			m_row="";
			while (vec_pos<m_size) {
				m_issu_code=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
				m_issu_name=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
				m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+'><B>'+m_issu_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_issu_name+'</B></TD></TR>';
				vec_pos=vec_pos+2;
				lineno=lineno+1;
			}
			m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color: white; font: 9pt arial;}">'+
				'<TR BGCOLOR="darkblue"><TD WIDTH="30%"><B>Location Code</B></TD>' +
				'<TD WIDTH="70%"><B>Location Description</B></TD></TR>'+
				m_row+
				'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval = "";
			
			popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
			document.Form1.TXT_LCODE.value=myDialogObj.returnval;
			document.Form1.TXT_LCODE.focus();			
		}	
		*/
		
		//=========================================check re-entered password===============================================
		
		
		function chk_repass(repass){
			if (p_enterd==true){
				if (repass.value==""){
					alert('Please Retype the password');
					repass.focus();
					return false;
				}
				else{
					if(document.Form1.TXT_PASS.value==document.Form1.TXT_RE_PASS.value){
						document.Form1.TXT_UNAME.disabled=false;
						document.Form1.TXT_SURNAME.focus();
					}
					else{
						alert('Retyped Password does not match wih the original Password');
						document.Form1.TXT_PASS.value="";
						document.Form1.TXT_RE_PASS.value="";
						document.Form1.TXT_PASS.focus();
						return false;
					}
				}	
			}
		}
		
		//=====================================check with existing passwords===============================================
		
		function userid_chk(uid){
			m_user_id=uid.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?user_id="+m_user_id.toUpperCase()+"&chksql=useridchk"
			load_interface(m_url,'XML',false);	
			m_size=data_vec.length; 
			//window.open(m_url);
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			
			vec_pos=0;
			if(m_size>0){
				if(data_vec[0]=='N'){
					alert('This User ID is an inactive,Please type another User ID');
					document.Form1.TXT_UNAME.value="";
					document.Form1.TXT_UNAME.focus();
				}
				else{
					if(data_vec[1]!=""){
						
						alert('This User ID already exists,Please type another User ID or Select the Modify User option for Modifications');
						document.Form1.TXT_UNAME.value="";
					}
				}
			}
			else{
				document.Form1.TXT_PASS.disabled=false;
				document.Form1.TXT_PASS.focus();
			}
		}
		
		
		//=====================================check new password==========================================================
		
		function chk_pass(object){
			if(object.value==document.Form1.TXT_UNAME.value){
				g_pass=false;
				alert('Password can not equal to the User ID');
				document.Form1.TXT_PASS.value="";
				document.Form1.TXT_PASS.focus();
				return false;
				p_enterd=false;
			}
			else{	
				if(object.value!="")  {	
					m_format=object.value;
					if (m_format.length<6 || m_format.length>10) {
						g_pass=false;
						alert('The length of the password should be between 6 and 10 characters');
						document.Form1.TXT_PASS.value="";
						document.Form1.TXT_PASS.focus();
						return false;
						p_enterd=false;
					}
					else {
						var i = 0;
						if (m_format.charAt(0) >=0){
							alert('First charactor of the Password must not be a Numeric value !');
							document.Form1.TXT_PASS.value="";
							document.Form1.TXT_PASS.focus();
							return false;
							p_enterd=false;
						}
						while (i < m_format.length) {
							var oneChar = m_format.charAt(i)
							if (oneChar == " "){ 
								g_pass=false;
								alert('You cannot have spaces in your password');
								document.Form1.TXT_PASS.value="";
								document.Form1.TXT_PASS.focus();
								p_enterd=false;
								return false;
							}
							i=i+1;
						}
						document.Form1.TXT_RE_PASS.disabled=false;
						document.Form1.TXT_RE_PASS.focus();
						g_pass=true;
						p_enterd=true;
					}	
				}
				else{
					g_pass=false;
					alert('Please enter a password');
					object.focus();
					p_enterd=false;
				}		
			}
		}
		
		
		
		//=====================================Back office select all===================================================
		
		function backselect_all() {
			for (var i = 72; i< document.Form1.elements.length; i++) {
				if (document.Form1.CHK_BAKE.checked==true){
					document.Form1.elements[i].checked = true;
				}
				else{
					document.Form1.elements[i].checked = false;
				}
			}
		}
		
		//=====================================Front office select all===================================================
		
		function frontselect_all() {
			for (var i = 13; i< 36; i++) {
				if (document.Form1.CHK_FALLE.checked==true){
					document.Form1.elements[i].checked = true;
				}
				else{
					document.Form1.elements[i].checked = false;
				}
			}
		}
		//ONCLICK="auto_click(document.Form1.CHK_V1,document.Form1.CHE_V1)"
		
		//=====================================Account select all===================================================
		
		function accselect_all() {
			for (var i = 36; i< 48; i++) {
				if (document.Form1.CHK_ACCE.checked==true){
					document.Form1.elements[i].checked = true;
				}
				else{
					document.Form1.elements[i].checked = false;
				}
			}
		}
		
		
		
		//=====================================Middle office select all===================================================
		
		function middleselect_all() {
			for (var i = 48; i< 62; i++) {
				if (document.Form1.CHK_MIDE.checked==true){
					document.Form1.elements[i].checked = true;
				}
				else{
					document.Form1.elements[i].checked = false;
				}
			}
		}
		
		
		
		//=====================================System monitor select all===================================================
		
		function sysmonselect_all() {
			for (var i = 62; i< 73; i++) {
				if (document.Form1.CHK_SALL.checked==true){
					document.Form1.elements[i].checked = true;
				}
				else{
					document.Form1.elements[i].checked = false;
				}
			}
		}
		
		
		
		
		//----Add By Chandana For VC06/020 on 13/10/2006-----
		
		function usermod_chk1(uid){
			m_user_id=uid.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?user_id="+m_user_id.toUpperCase()+"&chksql=exist_user_inactive"
			load_interface(m_url,'XML',false);	
			m_size=data_vec.length; 
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			vec_pos=0;
			if(m_size==0){
				//if (confirm("This User does not exists or user is active,..Press the OK button if you want a list of Users or Press the Cancel button to type again")) {
					//exuser_help(); //2011-09-27
					exuser_help(0);
				//}
				//else{
				//	document.Form1.TXT_UNAME.value="";
				//	document.Form1.TXT_UNAME.focus();
				//}
			}
			else{
				document.Form1.TXT_SURNAME.value=data_vec[0];
				document.Form1.TXT_ONAME.value=data_vec[1];
				document.Form1.TXT_LCODE.value=data_vec[2];
				document.Form1.TXT_LOCA.value=data_vec[3];
				document.Form1.TXT_DESIG.value=data_vec[4];
				document.Form1.TXT_SLEVEL.value=data_vec[5];
				document.Form1.TXT_PASS.value='**********';
				document.Form1.TXT_RE_PASS.value='**********';
				add_data(uid.value);
			}
		}
		
		//----End  VC06/020 on 13/10/2006-----
		
		
		
		//=========================================check user ID========================================================
		
		function chknull(uid){
			//if (uid.value=="")  //commented 2011-10-27
			//{                   //commented 2011-10-27
			//alert()
			
			//}
			//else{  //commented 2011-10-27
			//alert('chknull'+document.Form1.SCR_TYPE.value);mcp
			if(document.Form1.SCR_TYPE.value=="ADD"){
				//alert("1");
				
				userid_chk(uid);
			}
			if(document.Form1.SCR_TYPE.value=="MOD"){
				//alert("2");
				
				exis_userid_m(uid);
				
			}
			if(document.Form1.SCR_TYPE.value=="DEA"){
				exis_userid(uid);//----Add By Chandana For VC06/020 on 12/10/2006-----
				//alert("3");
				
				//changeuser_chk(uid);
			}
			
			// Added by Udara on 23-05-2011
			if(document.Form1.SCR_TYPE.value=="UTE"){
				exis_userid(uid);
			}
			// End by Udara on 23-05-2011
			
			if(document.Form1.SCR_TYPE.value=="REA"){
				usermod_chk1(uid);//----Add By Chandana For VC06/020 on 12/10/2006-----
				//alert("4");
				
				//usermod_chk1(uid);
			}
			if(document.Form1.SCR_TYPE.value=="VIE"){
				
				exis_userid(uid);
				//alert("5");
				
			}
			//} //commented 2011-10-27
		}
		
		
		//2011-09-26 ADDED  BY MADHAWA 
		function selectscr(SCR_TYPE)
		{
			document.Form1.SCR_TYPE.value=SCR_TYPE;
			
			
			var backupSCR_TYPE=document.Form1.SCR_TYPE.value;
			//var backupHID_CHANGE=document.Form1.HID_CHANGE.value; when canging the mode this value must be reset.if one pawd change cause a value change might exists even after a mode change.then will cause a password change
			var backupHid_scr_name=document.Form1.Hid_scr_name.value;
			
			
			//alert('selectscr'+document.Form1.SCR_TYPE.value);mcp
			if(SCR_TYPE=='ADD')
			{
				document.getElementById('div_lable').innerHTML='Users - New'; //added by Prabash on 24-11-2011	
				document.Form1.BUT_UNAME.disabled=true;
				var backupSCR_TYPE=document.Form1.SCR_TYPE.value;
				//var backupHID_CHANGE=document.Form1.HID_CHANGE.value; when canging the mode this value must be reset.if one pawd change cause a value change might exists even after a mode change.then will cause a password change
				var backupHid_scr_name=document.Form1.Hid_scr_name.value;
				
				/** 2011-10-20
				reset--> will reset all the hidden fieldsunder ie..but in mozilla reset hidden fields does not reset
					so the value of SCR_TYPE
				   will be reset to ADD	
				***/
				document.Form1.reset();
				$("input[type=checkbox]").each(function() {
						this.checked = false;
						this.value = "off" ; //reset 
					});
				//reset the values from back ups to original hidden fields
				document.Form1.SCR_TYPE.value=backupSCR_TYPE;
				//document.Form1.HID_CHANGE.value=backupHID_CHANGE.value; when canging the mode this value must be reset.if one pawd change cause a value change might exists even after a mode change.then will cause a password change
				document.Form1.Hid_scr_name.value=backupHid_scr_name;
				backupSCR_TYPE="";
				backupHid_scr_name="";
				
				
				
			}
			else if(SCR_TYPE=='MOD')
			{
				document.getElementById('div_lable').innerHTML='Users - Edit'; //added by Prabash on 24-11-2011	
				//parent.frames[2].location.href=servlet_client_url+":"+client_t3_port+"/"+client_name+"users_frame2";
				//parent.frames[1].location.href='dn_users_frame2.html';
				//m_writedata ='<TD WIDTH="50%" STYLE="{color: white ;font: bold 10pt arial;text-align:right;}"'+
				//	'<B>System Maintenance - Modify Users</B></TD>'; 
				//scrname.innerHTML=m_writedata;	
				document.Form1.BUT_UNAME.disabled=false;
				
				/** 2011-10-20
				reset--> will reset all the hidden fieldsunder ie..but in mozilla reset hidden fields does not reset
					so the value of SCR_TYPE
				   will be reset to ADD	
				***/
				document.Form1.reset();
				$("input[type=checkbox]").each(function() {
						this.checked = false;
						this.value = "off" ; //reset 
					});
				//reset the values from back ups to original hidden fields
				document.Form1.SCR_TYPE.value=backupSCR_TYPE;
				//document.Form1.HID_CHANGE.value=backupHID_CHANGE.value; when canging the mode this value must be reset.if one pawd change cause a value change might exists even after a mode change.then will cause a password change
				document.Form1.Hid_scr_name.value=backupHid_scr_name;
				backupSCR_TYPE="";
				backupHid_scr_name="";
				
			}
			else if(SCR_TYPE=='DEA')
			{
				document.getElementById('div_lable').innerHTML='Users - Deactivate'; //added by Prabash on 24-11-2011	
				//parent.frames[1].location.href='dn_users_frame2.html';
				//parent.frames[2].location.href=servlet_client_url+":"+client_t3_port+"/"+client_name+"users_frame2";
				//m_writedata ='<TD WIDTH="50%" STYLE="{color: white ;font: bold 10pt arial;text-align:right;}"'+
				//	'<B>System Maintenance - De Activate Users</B></TD>'; 
				//scrname.innerHTML=m_writedata;	
				document.Form1.BUT_UNAME.disabled=false;
				
				/** 2011-10-20
				reset--> will reset all the hidden fieldsunder ie..but in mozilla reset hidden fields does not reset
					so the value of SCR_TYPE
				   will be reset to ADD	
				***/
				document.Form1.reset();
				$("input[type=checkbox]").each(function() {
						this.checked = false;
						this.value = "off" ; //reset 
					});
				//reset the values from back ups to original hidden fields
				document.Form1.SCR_TYPE.value=backupSCR_TYPE;
				//document.Form1.HID_CHANGE.value=backupHID_CHANGE.value; when canging the mode this value must be reset.if one pawd change cause a value change might exists even after a mode change.then will cause a password change
				document.Form1.Hid_scr_name.value=backupHid_scr_name;
				backupSCR_TYPE="";
				backupHid_scr_name="";
				
				
			}
			
			// Added by Udara on 20-05-2011
			else if(SCR_TYPE=='UTE')
			{
				document.getElementById('div_lable').innerHTML='Users - User Termination'; //added by Prabash on 24-11-2011		
				
				//parent.frames[1].location.href='dn_users_frame2.html';
				//parent.frames[2].location.href=servlet_client_url+":"+client_t3_port+"/"+client_name+"users_frame2";
				//m_writedata ='<TD WIDTH="50%" STYLE="{color: white ;font: bold 10pt arial;text-align:right;}"'+
				//	'<B>System Maintenance - User Termination</B></TD>'; 
				//scrname.innerHTML=m_writedata;	
				document.Form1.BUT_UNAME.disabled=false;
				
				/** 2011-10-20
				reset--> will reset all the hidden fieldsunder ie..but in mozilla reset hidden fields does not reset
					so the value of SCR_TYPE
				   will be reset to ADD	
				***/
				document.Form1.reset();
				$("input[type=checkbox]").each(function() {
						this.checked = false;
						this.value = "off" ; //reset 
					});
				//reset the values from back ups to original hidden fields
				document.Form1.SCR_TYPE.value=backupSCR_TYPE;
				//document.Form1.HID_CHANGE.value=backupHID_CHANGE.value; when canging the mode this value must be reset.if one pawd change cause a value change might exists even after a mode change.then will cause a password change
				document.Form1.Hid_scr_name.value=backupHid_scr_name;
				backupSCR_TYPE="";
				backupHid_scr_name="";
				
				
			}
			
			
			else if(SCR_TYPE=='REA')
			{
				document.getElementById('div_lable').innerHTML='Users - Reactivate'; //added by Prabash on 24-11-2011	
				//parent.frames[1].location.href='dn_users_frame2.html';
				//parent.frames[2].location.href=servlet_client_url+":"+client_t3_port+"/"+client_name+"users_frame2";
				//m_writedata ='<TD WIDTH="50%" STYLE="{color: white ;font: bold 10pt arial;text-align:right;}"'+
				//	'<B>System Maintenance - Re Activate Users</B></TD>'; 
				//scrname.innerHTML=m_writedata;	
				document.Form1.BUT_UNAME.disabled=false;
				
				/** 2011-10-20
				reset--> will reset all the hidden fieldsunder ie..but in mozilla reset hidden fields does not reset
					so the value of SCR_TYPE
				   will be reset to ADD	
				***/
				document.Form1.reset();
				$("input[type=checkbox]").each(function() {
						this.checked = false;
						this.value = "off" ; //reset 
					});
				//reset the values from back ups to original hidden fields
				document.Form1.SCR_TYPE.value=backupSCR_TYPE;
				//document.Form1.HID_CHANGE.value=backupHID_CHANGE.value; when canging the mode this value must be reset.if one pawd change cause a value change might exists even after a mode change.then will cause a password change
				document.Form1.Hid_scr_name.value=backupHid_scr_name;
				backupSCR_TYPE="";
				backupHid_scr_name="";
				
				
			}
			else if(SCR_TYPE=='VIE')
			{
				//parent.frames[1].location.href='dn_users_frame2.html';
				//parent.frames[2].location.href=servlet_client_url+":"+client_t3_port+"/"+client_name+"users_frame2";
				//m_writedata ='<TD WIDTH="50%" STYLE="{color: white ;font: bold 10pt arial;text-align:right;}"'+
				//	'<B>System Maintenance - View Users</B></TD>'; 
				//scrname.innerHTML=m_writedata;	
				document.Form1.BUT_UNAME.disabled=false;
				
				/** 2011-10-20
				reset--> will reset all the hidden fieldsunder ie..but in mozilla reset hidden fields does not reset
					so the value of SCR_TYPE
				   will be reset to ADD	
				***/
				document.Form1.reset();
				$("input[type=checkbox]").each(function() {
						this.checked = false;
						this.value = "off" ; //reset 
					});
				//reset the values from back ups to original hidden fields
				document.Form1.SCR_TYPE.value=backupSCR_TYPE;
				//document.Form1.HID_CHANGE.value=backupHID_CHANGE.value; when canging the mode this value must be reset.if one pawd change cause a value change might exists even after a mode change.then will cause a password change
				document.Form1.Hid_scr_name.value=backupHid_scr_name;
				backupSCR_TYPE="";
				backupHid_scr_name="";
				
				
			}
		}
		//2011-09-26 END OF ADD BY MADHAWA
		
		function clearAll(){
			top.frames[1].location.href = jsp_client_url + "/dn_maintenance_users.jsp";
		}
		
		
		function exit()
		{
			top.frames[1].location.href = jsp_client_url + "/low.jsp";
		}	
		
		
		function disable()
		{
			//alert('XXX');
			document.Form1.BUT_UNAME.disabled=true;
		}	
		
		
		var m_option_name; //Global defined for Sub Grid URL access
		var m_expand=0;
		var m_colspan=0;
		
		
		
		// password plicy check
		function password_policy_check()
		{
			
			var new_password_valid_status = null;
			var alert_string = null;
			// window.open(servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=isNewPasswordValid&username="+$('#TXT_UNAME').val() +"&new_password=" + $('#TXT_PASS').val());
			
			if ($('#TXT_PASS').val() != '') {
				//alert('ccc');
				$.ajax({
						type: 'GET',
						//url: 'https://dev-adlmargin.sasianet.com:8443/ADLMARGIN/servlet/LBMARGIN2_dnvalsavuser?chksql=isNewPasswordValid&username=' + $('#TXT_USER_ID').val() + '&new_password=' + $('#TXT_PASSWORD').val(),
						url:servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=isNewPasswordValid&username="+$('#TXT_UNAME').val() +"&new_password=" + $('#TXT_PASS').val(),
						success: function(xml) {
							$(xml).find('password_status').each(function() {
									new_password_valid_status = $(this).find('new_password_valid_status').text();
									alert_string = $(this).find('alert_string').text();
									if (new_password_valid_status == 'NO') {
										alert(alert_string);
										$('#TXT_PASS').val('');
										$('#TXT_PASS').val('');
										setTimeout('$(\'#TXT_PASS\').focus()', 1);
									}
									else if (new_password_valid_status == 'YES') {
										$('#TXT_RE_PASS').attr('disabled', false);
										setTimeout('$(\'#TXT_RE_PASS\').focus()', 100);
									}
								});
						}
					});
				
				
				
			}
			else {
				
				$('#TXT_RE_PASS').val('');
				$('#TXT_RE_PASS').attr('disabled', true);
			}
			
			
		}	
		
		
		$(document).ready
		(
			
			function() 
			{
				loadProfileGrid();
				//2011-010-06 bind the onblur event for the password then calls a password validation
			}
		);	
		
		
		function setPasswordLength()
		{
			
			//if only the password has been changed other than ******* then this password policy check should be
			if((document.Form1.TXT_PASS.value!='**********')&&(document.Form1.TXT_RE_PASS.value!='**********'))
			{ //user dont have the intention of changing the paswword donot run password policy check		
				$.ajax
				(
					{
						type: 'GET',
						url:servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=pwdLength",
						success: function(xml) 
						{
							$(xml).find('password_length').each
							(
								function() 
								{
									pwdLength = $(this).find('size').text();
									$('#TXT_PASS').attr('maxlength',pwdLength);  //set the length attr is function
									$('#TXT_RE_PASS').attr('maxlength',pwdLength); 
									password_policy_check();//then checks the policy
									
								}
							);
						}
					}
				);
			}		
		}			
		
		
		
		
		function loadProfileGrid(){
			//m_url="http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CAM_sql_validations?chksql=m_get_grid";
			//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?user_id="+m_user_id.toUpperCase()+"&chksql=m_get_grid"
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=m_get_grid";
			jQuery("#profile").jqGrid(
				{
					url:m_url,
					datatype: "xml",
					height: 'auto',
					colNames:['Client Profile'],
					colModel:[ {name:'Client_Profile',index:'Client_Profile',sortable:false ,resizable:false,width:600,align:"left"}],
					loadonce: true,
					loadComplete: function () { changeStyle();},
					rowNum:-1,
					subGrid: true,
					caption:"Client Profile",
					subGridRowExpanded: function(subgrid_id, row_id) {	
						var the_char=row_id.charAt(0);
						if (the_char!="h"){
							click_event_user(row_id);
							var subgrid_table_id, pager_id,check_box_id; 
							subgrid_table_id = subgrid_id+"_t"; 
							check_box_id = "CH_"+subgrid_table_id; 
							//m_url2="http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_CAM_sql_validations?chksql=m_get_grid_sub&option_name="+m_option_name+"";
							m_url2=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?option_name="+m_option_name+"&chksql=m_get_grid_sub";
							$("#"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table>");
							jQuery("#"+subgrid_table_id).jqGrid({ 
									url:m_url2,
									datatype: "xml",
									colNames:['Screen Name&nbsp<span style = "position:absolute;right:30px" ><input class="but_input" type="button" style="width:52px;" id='+check_box_id+' name='+check_box_id+' value="Check" onclick="check_section_wise(this)"></span>','View', 'Add','Edit','Delete','Reactivate'],
									colModel:[ {name:'Screen Name',index:'Screen Name', width:210,align:"left",sortable:false,resizable:false},
										{name:'View',index:'View', width:50, align:"center",formatter:CheckBoxDispaly_v ,sortable:false,resizable:false},
										{name:'Add',index:'Add', width:50, align:"center", formatter:CheckBoxDispaly_a,sortable:false,resizable:false}, //hidden:true,
										{name:'Edit',index:'Edit', width:50, align:"center", formatter:CheckBoxDispaly_e,sortable:false,resizable:false}, //hidden:true,
										{name:'Delete',index:'Delete', width:50,align:"center", formatter:CheckBoxDispaly_d,sortable:false,resizable:false }, //hidden:true,
										{name:'Reactivate',index:'Reactivate', width:50,align:"center",formatter:CheckBoxDispaly_r,sortable:false,resizable:false }],//hidden:true, 
									loadonce: true,
									rowNum:-1,
									autowidth: true,
									height: 'auto',
									caption:m_option_name
								});
						}
					}
				});
		}
		function changeStyle(){
			var ids = jQuery("#profile").jqGrid('getDataIDs')
			for(var i=0;i<ids.length;i++){
				var cl = ids[i];
				var ret = jQuery("#profile").jqGrid('getRowData',cl); 
				var the_char=cl.charAt(0);
				if (the_char=="h"){
					$("#"+cl+">td>a>span").removeClass('ui-icon-plus')
					$("#"+cl+">td>a>span").addClass('ui-icon-arrowthickstop-1-e')
					$("#"+cl+">td").removeClass('sgcollapsed')
					$("#"+cl+">td:first").addClass('ui-remove-icon jqgrid-rownum')
				}
			}
			exAll();
			var rec_count=$("#profile").jqGrid('getGridParam',"records");
			var i=1
				for (i=1;i<rec_count;i++){
					$("#"+i+"").remove()
				}
		}
		function exAll(){
			if (m_expand!=1){
				colAll();
				var rec_count=$("#profile").jqGrid('getGridParam',"records");
				var i=0
					for (i=0;i<rec_count;i++){
						jQuery("#profile").toggleSubGridRow(i);
					}
					m_expand=1;
				m_colspan=0;
			}
		}
		function colAll(){
			if (m_colspan!=1){
				var rec_count=$("#profile").jqGrid('getGridParam',"records");
				var i=0
					for (i=0;i<rec_count;i++){
						jQuery("#profile").collapseSubGridRow(i);
					}
					m_colspan=1;
				m_expand=0;
			}
		}
		function click_event_user(rowid){
			var id = rowid; 
			var ret = jQuery("#profile").jqGrid('getRowData',id); 
			m_option_name=ret.Client_Profile;
		}
		function CheckBoxDispaly_v(cellvalue, options, rowObject){
			var row_id=rowObject.getAttribute('id');
			var the_char=row_id.charAt(0);
			if (the_char=="h"){
				var the_empty="-"
					return the_empty; 
			}
			else {
				m_chk_box='<input type=checkbox value="off"  name="chkv_'+row_id+'" onclick="check_view('+row_id+')" >'; 
				return m_chk_box; 
			}
		}
		function CheckBoxDispaly_a(cellvalue, options, rowObject){
			var row_id=rowObject.getAttribute('id');
			var the_char=row_id.charAt(0);
			if (the_char=="h"){
				var the_empty="-"
					return the_empty; 
			}
			else {
				m_chk_box='<input type=checkbox value="off"  name="chke_'+row_id+'" onclick="check_exec('+row_id+')" >'; 
				return m_chk_box; 
			}
		}
		function CheckBoxDispaly_e(cellvalue, options, rowObject){
			var row_id=rowObject.getAttribute('id');
			var the_char=row_id.charAt(0);
			if (the_char=="h"){
				var the_empty="-"
					return the_empty; 
			}
			else {
				m_chk_box='<input type=checkbox value="off"  name="chkEd_'+row_id+'" onclick="check_edit('+row_id+')" >'; 
				return m_chk_box; 
			}
		}
		function check_exec(rownum){ 
			m_chke="chke_"+rownum; 
			m_chke=document.Form1.elements[m_chke];
			m_chk="chkv_"+rownum; 
			m_chk=document.Form1.elements[m_chk];
			if (m_chke.checked==true){
				m_chk.checked=true;
				m_chk.value='on';//added 2011-10-27
				m_chke.value='on';
			}else{
				m_chke.value='off';
				m_chkEd="chkEd_"+rownum; 
				m_chkedit=document.Form1.elements[m_chkEd];
				m_chkDel="chkDel_"+rownum; 
				m_chkdelete=document.Form1.elements[m_chkDel];
				m_chkRe="chkReact_"+rownum; 
				m_chkReact=document.Form1.elements[m_chkRe];
				if (m_chkedit.checked!=true&&m_chkdelete.checked!=true&&m_chkReact.checked!=true){
					m_chk.checked=false;
					m_chk.value='off';//added 2011-10-27
				}
			}
		}
		function check_edit(rownum){ 
			m_chkEd="chkEd_"+rownum; 
			m_chke=document.Form1.elements[m_chkEd];
			m_chk="chkv_"+rownum; 
			m_chk=document.Form1.elements[m_chk];
			if (m_chke.checked==true){
				m_chk.checked=true;
				m_chk.value='on';//added 2011-10-27
				m_chke.value='on';
			}else{
				m_chke.value='off';
				m_chkAdd="chke_"+rownum; 
				m_chkexecute=document.Form1.elements[m_chkAdd];
				m_chkDel="chkDel_"+rownum; 
				m_chkdelete=document.Form1.elements[m_chkDel];
				m_chkRe="chkReact_"+rownum; 
				m_chkReact=document.Form1.elements[m_chkRe];
				if (m_chkexecute.checked!=true&&m_chkdelete.checked!=true&&m_chkReact.checked!=true){
					m_chk.checked=false;
					m_chk.value='off';//added 2011-10-27
				}
			}
		}
		function check_delete(rownum){ 
			m_chkDel="chkDel_"+rownum; 
			m_chke=document.Form1.elements[m_chkDel];
			m_chk="chkv_"+rownum; 
			m_chk=document.Form1.elements[m_chk];
			if (m_chke.checked==true){
				m_chk.checked=true;
				m_chk.value='on';//added 2011-10-27
				m_chke.value='on';
			}else{
				m_chke.value='off';
				m_chkAdd="chke_"+rownum; 
				m_chkexecute=document.Form1.elements[m_chkAdd];
				m_chkEd="chkEd_"+rownum; 
				m_chkedit=document.Form1.elements[m_chkEd];
				m_chkRe="chkReact_"+rownum; 
				m_chkReact=document.Form1.elements[m_chkRe];
				if (m_chkexecute.checked!=true&&m_chkedit.checked!=true&&m_chkReact.checked!=true){
					m_chk.checked=false;
					m_chk.value='off';//added 2011-10-27
				}
			}
		}
		function check_react(rownum){ 
			m_chkReact="chkReact_"+rownum; 
			m_chkr=document.Form1.elements[m_chkReact];
			m_chk="chkv_"+rownum; 
			m_chk=document.Form1.elements[m_chk];
			if (m_chkr.checked==true){
				m_chk.checked=true;
				m_chk.value='on';//added 2011-10-27
				m_chkr.value='on';
			}else{
				m_chkr.value='off';
				m_chkAdd="chke_"+rownum; 
				m_chkexecute=document.Form1.elements[m_chkAdd];
				m_chkEd="chkEd_"+rownum; 
				m_chkedit=document.Form1.elements[m_chkEd];
				m_chkDel="chkDel_"+rownum; 
				m_chkdelete=document.Form1.elements[m_chkDel];
				if (m_chkexecute.checked!=true&&m_chkedit.checked!=true&&m_chkdelete.checked!=true){
					m_chk.checked=false;
					m_chk.value='on';//added 2011-10-27
				}
			}
		}
		function check_view(rownum){ 
			m_chk="chkv_"+rownum; 
			m_chk=document.Form1.elements[m_chk];
			if (m_chk.checked==true){
				m_chk.value='on';
			}else{
				m_chk.value='off';
			}
		}
		function CheckBoxDispaly_d(cellvalue, options, rowObject){
			var row_id=rowObject.getAttribute('id');
			var the_char=row_id.charAt(0);
			if (the_char=="h"){
				var the_empty="-"
					return the_empty; 
			}
			else {
				m_chk_box='<input type=checkbox value="off"  name="chkDel_'+row_id+'" onclick="check_delete('+row_id+')" >'; 
				return m_chk_box; 
			}
		}
		function CheckBoxDispaly_r(cellvalue, options, rowObject){
			var row_id=rowObject.getAttribute('id');
			var the_char=row_id.charAt(0);
			if (the_char=="h"){
				var the_empty="-"
					return the_empty; 
			}
			else {
				m_chk_box='<input type=checkbox value="off"  name="chkReact_'+row_id+'" onclick="check_react('+row_id+')" >'; 
				return m_chk_box; 
			}
		}
		function check_section_wise(obj){
			var objID=obj.name.substring(3)
			if (document.getElementById("CH_"+objID).value=="Check"){ 
				document.getElementById("CH_"+objID).value="UnCheck" 
				document.getElementById("CH_"+objID).checked="true" 
			}else if (document.getElementById("CH_"+objID).value=="UnCheck") {
				document.getElementById("CH_"+objID).value="Check" 
				document.getElementById("CH_"+objID).checked="false" 
			}
			$("#"+objID + " input[type=checkbox]").each(function() {
					if (document.getElementById("CH_"+objID).value=="UnCheck") {
						this.checked = true;
						this.value = "on" ;
					}else if (document.getElementById("CH_"+objID).value=="Check") {
						this.checked = false;
						this.value = "off" ;
					}
				});
		}
		function uncheckAll(){
			$("input[type=checkbox]").each(function() {
					this.checked = false;
					this.value = "off" ;
				});
			/*
			if (document.Form1.elements["hid_reset_pass"].value=="ON") 
			{
				document.Form1.elements["TXT_RESET_PASS"].checked=true ;
			}
			*/
		}
		
		
		function validated()
		{
			var validated=true;
			
			var msg="Please Check the Marked Fields";
			
			
			if(document.Form1.TXT_UNAME.value=="")
			{
				validated=false;
				document.Form1.TXT_UNAME.style.border='1px solid rgb(255, 0, 0)';
			}else
			{
				document.Form1.TXT_UNAME.style.border='1px solid rgb(172, 198, 219)';
			}	
			
			if(document.Form1.TXT_SURNAME.value=="")
			{
				validated=false;
				document.Form1.TXT_SURNAME.style.border='1px solid rgb(255, 0, 0)';
			}	
			else
			{
				document.Form1.TXT_SURNAME.style.border='1px solid rgb(172, 198, 219)';
			}	
			if(document.Form1.TXT_LCODE.value=="")	
			{
				validated=false;
				document.Form1.TXT_LCODE.style.border='1px solid rgb(255, 0, 0)';
			}	
			else
			{
				document.Form1.TXT_LCODE.style.border='1px solid rgb(172, 198, 219)';
			}	
			
			if(document.Form1.TXT_DESIG.value=="")	
			{
				validated=false;
				document.Form1.TXT_DESIG.style.border='1px solid rgb(255, 0, 0)';
			}else
			{
				document.Form1.TXT_DESIG.style.border='1px solid rgb(172, 198, 219)';
			}	
			
			
			if(document.Form1.TXT_RE_PASS.value!=""&&document.Form1.TXT_PASS.value!="")
			{
				if(document.Form1.TXT_RE_PASS.value!=document.Form1.TXT_PASS.value)
				{
					validated=false;
					msg='Please check the Password with the Confirmation password.They dont match each other';
					document.Form1.TXT_RE_PASS.style.border='1px solid rgb(255, 0, 0)';
					document.Form1.TXT_PASS.style.border='1px solid rgb(255, 0, 0)';
				}	
				else
				{
					document.Form1.TXT_RE_PASS.style.border='1px solid rgb(172, 198, 219)';
					document.Form1.TXT_PASS.style.border='1px solid rgb(172, 198, 219)';
				}	
			}
			else
			{
				if(document.Form1.TXT_RE_PASS.value=="")
				{
					validated=false;
					document.Form1.TXT_RE_PASS.style.border='1px solid rgb(255, 0, 0)';
				}
				else
				{
					document.Form1.TXT_RE_PASS.style.border='1px solid rgb(172, 198, 219)';
					
				}
				
				if(document.Form1.TXT_PASS.value=="")
				{
					validated=false;
					document.Form1.TXT_PASS.style.border='1px solid rgb(255, 0, 0)';
				}
				else
				{
					document.Form1.TXT_PASS.style.border='1px solid rgb(172, 198, 219)';
				}	
			}	
			
			return validated;
		}	
		
		
		function before_submit()
		{
			
			if(validated())	
			{	
				if (document.Form1.SCR_TYPE.value=='MOD') 
				{
					//under modify mode password will be changed,when data is loaded,under any mode, password filed will not be filled with data base password values
					//when data loading data 10 '*' marks will be loaded to password
					//if user changes the pwd under modify mode, TXT_PASS.value will be changed to the user given value other than '**********' -10 astric marks
					//in any occation, where data loading from data base, TXT_PASS will have '**********' as the value
					//if user changes that value then TXT_PASS will get user entered value then keep a log in the HID_CHANGE that user changed the pwd  
					if (document.Form1.TXT_PASS.value!='**********')
					{
						document.Form1.HID_CHANGE.value='CHA';
						//top.frames[1].frames[1].document.Form1.HID_CHANGE.value='CHA';
					}
				}
				document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnsavuser";
				//alert(document.Form1.action);
				document.Form1.submit();
			}
			else 
			{
				alert('Please  Check the marked fields');
			}	
			
			
		}
		
		
		
		//======================================================================================================================
		
	</SCRIPT>
	<BODY onload="disable(); selectscr('ADD')" > <!-- onload="on_load()" 2011-09-26 -->
		<FORM NAME="Form1" ID="Form1" METHOD="POST" >                                                                                          
			<!--INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="user_maintenance"-->
			<input type="hidden" name="SCR_TYPE" value="ADD">
			<input type="hidden" name="HID_CHANGE" value="" >
			<INPUT TYPE="hidden" NAME="Hid_scr_name" VALUE="user_maintenance"> 
			
			
			<!-- 2011-09-26 ---->
			
			<table class='table' align='center' width="99%" border="0" cellpadding="0" cellspacing="0" >
				<!-- <table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 	-->
				<tr>
					<td height='7'></td>
				</tr>
				<tr height="30">		
					<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
					<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Administration - System User</B></td>
					<td width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>
				</tr>
			</table>
			
			<table class='table' align='center' width="99%" border="0" cellpadding="2" cellspacing="0" >
				<tr>
					<td width="6%">
						<input type="button" value="Add" onclick="selectscr('ADD')" class="mainbut">
					</td>	
					
					<td width="6%">
						<input type="button" value="Edit" onclick="selectscr('MOD')" class="mainbut">
					</td>	
					<td width="6%">
						<input type="button" value="Deactivate" onclick="selectscr('DEA')" class="mainbut">	
					</td>
					<td width="6%">
						<input type="button" value="Reactivate" onclick="selectscr('REA')" class="mainbut" >	
					</td>
					<td width="6%">
						<input type="button" value="View Users" onclick="selectscr('VIE')" class="mainbut" >	
					</td>
					<td width="6%">
						<input type="button" value="User Termination" style="width:100px" onclick="selectscr('UTE')" class="mainbut">	
					</td>
					
					</TD>
							<TD WIDTH='6%'>&nbsp;&nbsp;&nbsp;&nbsp;</TD>	
				<!--	<td style="15%">
						<div style="width:50px"></div>
						
					</td>-->					
					
					
					<td width="6%">
						<input type="button" value="Save" onclick="before_submit()" class="mainbut">	
					</td>	
					<td width="6%">
						<input type="button" value="Cancel" onclick="clearAll()" class="mainbut">	
					</td>	
					<td width="6%">
						<input type="button" value="Exit" onclick="exit()" class="mainbut">	
					</td>	
					<!--<TD  WIDTH="50%" class="hh1" align="right">-->
					<!--<B>Users</B>-->
					<TD> <B><div id='div_lable' align='right' > </div> </B> </TD>	
						
					</td>	
					
				</tr>
			</table>	
			
			
			
			<hr>
			<table width="100%"  >
				<tr ><td height='20px' ></td></tr>
			</table>
			
			
			<!-- 2011-09-26 ---->
			
			
			<table width="100%" border="0" cellpadding="0" cellspacing="0" > <!-- style="{color: black; font: bold 10pt arial;}" -->							
				<td width="1%" ></td>
				<td width="99%">
					
					<table width="100%"border="0" cellpadding="1" cellspacing="0" >
						<tr>
							<td width="25%">User Name</td>
							<td width="35%"><input type="text" name="TXT_UNAME" id="TXT_UNAME" class="txt_input6" align="left" size=23 maxlength=10 onblur="chknull(document.Form1.TXT_UNAME)" > <!-- onblur="chknull(document.Form1.TXT_UNAME)" -->
								<input type="button" value="Help" class="mainbut" name="BUT_UNAME" onclick="exuser_help(0)" ></td>
							<td width="40%">
							</td>
						</tr>
					</table>
					
					
					<table width="100%" border="0" cellpadding="1" cellspacing="0" > <!-- STYLE="{color: black; font: bold 10pt arial;}" -->
						<tr>
							<td width="25%">User Password</td>
							<td width="25%"><INPUT TYPE="password" id="TXT_PASS" NAME="TXT_PASS" class="txt_input6"	ALIGN="LEFT" SIZE=23 MAXLENGTH=10 ONBLUR="setPasswordLength()"></td> <!-- chk_pass(document.Form1.TXT_PASS) -->
							<td width="23%">Confirm User Password</TD>
							<!--TYPE="password" -->	<td width="27%"><INPUT TYPE="password"  id="TXT_RE_PASS" NAME="TXT_RE_PASS" class="txt_input6" ALIGN="LEFT" SIZE=23 MAXLENGTH=10 ONBLUR="chk_repass(document.Form1.TXT_RE_PASS)"></td>
						</tr>
					</table>
					<!-- <hr width="*%"> -->	
					
					
					
					<table width="100%" border="0" cellpadding="1" cellspacing="0" >
						<TR>
							<td width="25%">Surname</td>
							<td width="49%">
								<input type="Text" name="TXT_SURNAME" class="txt_input6"	align="LEFT" size=50 maxlength=40 ></TD>
							<td width="22%">
								<td width="4%">
								</td>
							</tr>
						</table>
						
						
						<table width="100%" border="0" cellpadding="1" cellspacing="0" >
							<tr>
								<td width="25%">Other Names</TD>
								<td width="49%">
									<INPUT TYPE="Text" class="txt_input6" NAME="TXT_ONAME"	ALIGN="LEFT" SIZE=50 MAXLENGTH=40 >
								</td>
								<td width="22%">
									<td width="4%">
									</td>
								</tr>
							</table>
							<!-- <HR WIDTH="*%"> -->	
							
							
							
							<table width="100%" border="0" cellpadding="1" cellspacing="0" >
								<tr>
									<td width="25%">Location Code</TD>
									<td width="35%"><input type="Text" class="txt_input6" name="TXT_LCODE"	align="LEFT" size=23 maxlength=40 ONBLUR="chk_location(document.Form1.TXT_LCODE)">
										<input type="button" value="Help" class="mainbut" name="BUT_LCODE" onclick="location_help(0)" ></TD>
									<td width="40%">
									</td>
								</tr>
								
								<tr>
									<td width="25%">Location</td>
									<td width="35%">
										<input type="Text" class="txt_input6" name="TXT_LOCA"	align="LEFT" size=23 maxlength=40 ></TD>
									<td width="40%">
									</td>
								</tr>
							</table>
							
							<!--TABLE WIDTH="100%"BORDER="0" cellpadding="1" CELLSPACING="0" STYLE="{color: black; font: bold 9pt arial;}">
							<TR>
							<TD  WIDTH="25%" STYLE="{color:black; font: bold 10pt Arial;}">Branch</TD></B>
							<TD WIDTH="60%">
							<SELECT NAME="TXT_LCODE" STYLE="{color: black; font: bold 10pt arial;}">
							<OPTION VALUE="COLOMBO" SELECTED>Colombo</option> 
							<OPTION VALUE="KANDY" >Kandy</option> 
							<OPTION VALUE="MATARA" >Matara</option></SELECT></TD> 
							<TD WidTH="15%">
							</TR>
							<TR></TR>
							<TR></TR>
							</TABLE-->
							
							
							<!-- <hr width="*%"> -->	
							
							
							
							<table width="100%" border="0" cellpadding="1" cellspacing="0" >
								<tr>
									<td width="25%">Designation</TD>
									<td width="35%">
										<input type="Text" class="txt_input6" name="TXT_DESIG"	align="LEFT" size=23 maxlength=40 >
										<input type="button" value="Help"  class="mainbut" name="BUT_DESIG" onclick="desig_help(0)" ></td>
									<td width="40%">
									</tr>
									<tr>
										<td>Seniority Level</td>
										<td><select name="TXT_SLEVEL" class="txt_input6" >
												<option value="1" SELECTED>1</option>  
												<option value="2">2</option> 
												<option value="3">3</option> 
												<option value="4">4</option> 
												<option value="5">5</option>
											</select>
										</td>		    
										<td></td>
									</tr>
								</table>
								
								<!-- <hr width="*%"> -->	
								
								<table width="100%" border="1" cellpadding="2" cellspacing="1" >
									<tr>
										<table id="profile"></table> 
									</tr>	
								</table>
								
								
							</tr>
						</td>
						<tr>		
							
							
						</td>
					</tr>
				</tr>
			</table>


			<table class='table' align='center' width="99%" border="0" cellpadding="2" cellspacing="0" >
				<tr>
					<td width="6%">
						<input type="button" value="Add" onclick="selectscr('ADD')" class="mainbut">
					</td>	
					
					<td width="6%">
						<input type="button" value="Edit" onclick="selectscr('MOD')" class="mainbut">
					</td>	
					<td width="6%">
						<input type="button" value="Deactivate" onclick="selectscr('DEA')" class="mainbut">	
					</td>
					<td width="6%">
						<input type="button" value="Reactivate" onclick="selectscr('REA')" class="mainbut" >	
					</td>
					<td width="6%">
						<input type="button" value="View Users" onclick="selectscr('VIE')" class="mainbut" >	
					</td>
					<td width="6%">
						<input type="button" value="User Termination" style="width:100px" onclick="selectscr('UTE')" class="mainbut">	
					</td>
					
					
					<td style="15%">
						<div style="width:50px"></div>
						
					</td>					
					
					
					<td width="6%">
						<input type="button" value="Save" onclick="before_submit()" class="mainbut">	
					</td>	
					<td width="6%">
						<input type="button" value="Cancel" onclick="clearAll()" class="mainbut">	
					</td>	
					<td width="6%">
						<input type="button" value="Exit" onclick="exit()" class="mainbut">	
					</td>	
					<td width="45%" class="hh1"  align="right" >
					</td>	
					
				</tr>
			</table>	





		</td> <!-- 99% -->
		
	</table>
</form>
			</body>
			<div>
<SCRIPT language1.2="JavaScript" src="validate.js"></SCRIPT>
<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>	
</DIV>
		</html>
		
