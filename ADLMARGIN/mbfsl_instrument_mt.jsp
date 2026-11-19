<HTML>
	<HEAD>
		<TITLE>Margin Traging</TITLE>
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

	    %>	
	
	
<!--	<SCRIPT language="JavaScript1.2">-->
	<script language="JavaScript1.2" >
        var s_status=false;
  
	  function val_inscode(){
		  m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalinsttypes_mt?chksql=ins_opt&ins_code="+document.Form1.Text_ins_code.value;
		  		load_interface(m_url,'XML',false);
				m_size = data_vec.length;
			
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			//val=(document.Form1.Text_option.selectedIndex);
			<!----------------add -------------------------------------------->	
			if(document.Form1.Hid_scr_name2.value=="A"){
			 if (m_size >0) {
			 	alert("Instrument Type is Exsisting.");
				document.Form1.Text_ins_code.value= "";	
				document.Form1.Text_ins_code.focus();
			
		  }
			document.Form1.Text_yield_type.disabled = false;
			document.Form1.Text_cat.disabled = false;
			document.Form1.Text_ins_code.focus();
			/*
			else if(document.Form1.Text_ins_code.value=="") {
			   alert('Please enter the Instrument Code');
					document.Form1.Text_ins_code.focus();
			}*/
		}
			<!------------modify----------------------------------------------->
		else if(document.Form1.Hid_scr_name2.value=="M"){
				document.Form1.Hid_scr_name.value="Instrument_Modi";
		  if (m_size >0) {
				
			 	document.Form1.Text_ins_desc.value=data_vec[1];
				document.Form1.Text_repo.value=data_vec[2];
				document.Form1.Text_repo_trans.value=data_vec[3];
				document.Form1.Text_cat.value=data_vec[4];
				document.Form1.Text_mt_percent.value=data_vec[5];
				document.Form1.Text_base_int_rate.value=data_vec[6];
				if(data_vec[7]=="S"){
				 document.Form1.Text_yield_type.selectedIndex=1;
				}else{
				 document.Form1.Text_yield_type.selectedIndex=0;
				}
				document.Form1.Text_cat.disabled = true;
				document.Form1.Text_yield_type.disabled = true;
			}
			else {
			  if (confirm("Invalid Instrument Type ! Press the OK button if you want a List of Codes.")) {
				   inst_help();
			  }
			 }
		 }
		<!--------------De-Activate---------------------------------------->
		else if(document.Form1.Hid_scr_name2.value=="D"){
				document.Form1.Hid_scr_name.value="Instrument_DeAct";
		  if (m_size >0) {
				document.Form1.Text_ins_desc.value=data_vec[0];
				document.Form1.Text_repo.value=data_vec[1];
				document.Form1.Text_repo_trans.value=data_vec[2];
				document.Form1.Text_cat.value=data_vec[3];
				document.Form1.Text_mt_percent.value=data_vec[4];
				document.Form1.Text_base_int_rate.value=data_vec[5];
				if(data_vec[6]=="S"){
				 document.Form1.Text_yield_type.selectedIndex=1;
				}else{
				 document.Form1.Text_yield_type.selectedIndex=0;
				}
				document.Form1.Text_yield_type.disabled = true;
				document.Form1.Text_cat.disabled = true;
			}
			else {
			  if (confirm("Invalid Instrument Type ! Press the OK button if you want a List of Codes. ")) {
				   inst_help();
			  }
		  }
		 }
			<!------------Re-Activate----------------------------------------->
		else if(document.Form1.Hid_scr_name2.value=="R"){
				document.Form1.Hid_scr_name.value="Instrument_ReAct";
		 if (m_size >0) {
				document.Form1.Text_ins_desc.value=data_vec[0];
				document.Form1.Text_repo.value=data_vec[1];
				document.Form1.Text_repo_trans.value=data_vec[2];
				document.Form1.Text_cat.value=data_vec[3];
				document.Form1.Text_mt_percent.value=data_vec[4];
				document.Form1.Text_base_int_rate.value=data_vec[5];
				if(data_vec[6]=="S"){
				 document.Form1.Text_yield_type.selectedIndex=1;
				}else{
				 document.Form1.Text_yield_type.selectedIndex=0;
				}
				document.Form1.Text_cat.disabled = true;
			}
		 else {
			  if (confirm("Invalid Instrument Type ! Press the OK button if you want a List of Codes. ")) {
				   inst_help();
			  }
			}
		 }
		
			<!-------------------VIEW---------------------------------------->
		else if(document.Form1.Hid_scr_name2.value=="V"){
				
			 if (m_size >0) {
				document.Form1.Text_ins_desc.value=data_vec[0];
				document.Form1.Text_repo.value=data_vec[1];
				document.Form1.Text_repo_trans.value=data_vec[2];
				document.Form1.Text_mt_percent.value=data_vec[4];
				document.Form1.Text_base_int_rate.value=data_vec[5];
				if(data_vec[6]=="S"){
				 document.Form1.Text_yield_type.selectedIndex=1;
				}else{
				 document.Form1.Text_yield_type.selectedIndex=0;
				}
			 }
			 else{
			//  if (confirm("Instrument Type Display !")){
				
			 //   View_help(0);
				
			//	} 
		  }
	   }
		}	
	<!-------------------------------HELP-------------------------------->	
	function inst_help() {
	  	//val=(document.Form1.Text_option.selectedIndex);
	  	if(document.Form1.Hid_scr_name2.value=="M"){
				document.Form1.Hid_scr_name.value="Instrument_Modi";
				sec_help1(0);
    		 //	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalinsttypes_mt?chksql=ins_Deact_help&ins_code="+document.Form1.Text_ins_code.value+"";
			}
	 			else if(document.Form1.Hid_scr_name2.value=="D"){
				document.Form1.Hid_scr_name.value="Instrument_DeAct";
				sec_help2(0);
			//	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalinsttypes_mt?chksql=ins_Deact_help&ins_code="+document.Form1.Text_ins_code.value+"";
    	}
	 			else if(document.Form1.Hid_scr_name2.value=="R"){
				document.Form1.Hid_scr_name.value="Instrument_DeAct";
				sec_help3(0);
		 	//	 m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalinsttypes_mt?chksql=ins_react_help&ins_code="+document.Form1.Text_ins_code.value+"";
    	}

	}
		
			//----------------------------------------help1**
		function	sec_help1(m_strat){
		
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	
		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.Text_ins_code;
 		myObject[1]=null;
 		
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.Text_ins_code.value;
 		myObject_value[1]=null;

 		var myObject_type=new Array(); //passing values data type
		myObject_type[0]="StringL";
 		myObject_type[1]=null;	
 	
 		var qid='35';

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
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400, // 500,
		 width: 500, //900,
		 title: 'SasiNet Frame work',
		 scrollable: true,
			
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);document.Form1.Text_ins_code.focus();  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
	}
		//----------------------------------------------**
		
		//----------------------------------------help2**
		function	sec_help2(m_strat){
		
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	
		var myObject=new Array(); //return values set to this object
		
 		myObject[0]=aForm.Text_ins_code;
 		myObject[1]=null;	
 		
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.Text_ins_code.value;
 		myObject_value[1]=null;	

 		var myObject_type=new Array(); //passing values data type
		myObject_type[0]="StringL";
 		myObject_type[1]=null;	
 	
 		var qid='35';

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
			
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
				
		 height:400, // 500,
		 width: 500, //900,
		 title: 'SasiNet Frame work',
		 scrollable: true,
			
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); document.Form1.Text_ins_code.focus();  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
	}
		//----------------------------------------------**
		//----------------------------------------help3**
		function	sec_help3(m_strat){
		
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	
		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.Text_ins_code;
 		myObject[1]=null;	
 		
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.Text_ins_code.value;
 		myObject_value[1]=null;

 		var myObject_type=new Array(); //passing values data type
		myObject_type[0]="StringL";
 		myObject_type[1]=null;	
 	
 		var qid='36';

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
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400, // 500,
		 width: 500, //900,
		 title: 'SasiNet Frame work',
		 scrollable: true,
			
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); document.Form1.Text_ins_code.focus();  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
	}
		//----------------------------------------------**	
		
	//----------------------------------------View help**
		function	View_help(m_strat){
		
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	
		var myObject=new Array(); //return values set to this object
 		myObject[0]=null;	
 		myObject[1]=null;
		myObject[2]=null;	
		myObject[3]=null;	
 		
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=null;

 		var myObject_type=new Array(); //passing values data type
 		myObject_type[1]=null;	
 	
 		var qid='39';

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
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=20'+'&start='+m_strat+'&fn_name='+fn_name,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:500, // 500,
		 width: 800, //900,
		 title: 'SasiNet Frame work',
		 scrollable: true,
			
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); document.Form1.Text_ins_code.focus();  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
	}
		//----------------------------------------------**		
	<!-----------------------------------NEW-VIEW---------------------------------------------------->
		/*function inst_View_Disp() {
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalinsttypes_mt?chksql=inst_View_Disp";
		  	
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
			
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			vec_pos=0;
      m_row="";
		  lineno=1;
			while (vec_pos<m_size) {
			  m_ins_code=data_vec[0];
	   	  m_ins_desc=data_vec[1];
				m_ins_active=data_vec[2];
				m_row=m_row+'<TR STYLE="{color:black; cursor:hand font: bold 9pt Arial;}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_ins_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_ins_desc+'</B></TD>'+
				'<TD ID=C3R'+ lineno+'><B>'+m_ins_active+'</B></TD></TR>';
				vec_pos=vec_pos+3;
		    lineno=lineno+1;
			}
		 		
		 m_writedata ='<TABLE BGCOLOR="gray" WIDTH="100%" STYLE="{color:black; font: bold 9pt Arial;}">'+
		 '<TR BGCOLOR="silver"><TD WIDTH="10%"><B>Instrument</B></TD>' +
		 '<TD WIDTH="80%"><B>Description</B></TD><TD WIDTH="10%"><B>Status</B></TD></TR>'+
		  m_row+
		 '</TABLE>'; 
		 myDialogObj.htmlstr = m_writedata;
		 myDialogObj.returnval = "";
		 popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		 document.Form1.Text_ins_code.value=myDialogObj.returnval;
		 document.Form1.Text_ins_code.focus();
		}*/
		<!----------------------------------********----------------------------------------------->
  	function default_actions() {	
		  setInterval("set_timer_actions()",120000);
	  }			
	  function set_timer_actions() {	
		  servlet_client_url+":"+client_t3_port+"/"+client_name+"mf_senddata2?chksql=idle";
		  //top.frames[0].document.applets[0].getdata(m_url);
	  }
		<!------------------------------------H-E-L-P------------------------------------------------>
	 function help() {
		 /*if(val==4){
			  inst_View_Disp();
			}*/
		if(document.Form1.Hid_scr_name2.value=="A"){
			 document.Form1.Text_help.disabled=true;
			 document.Form1.Text_ins_code.focus();
			}
			else {
				inst_help();
			}
		}
	<!----------------------------------*********------------------------------------------------>
		function myDialogObj() {
				var htmlstr; 
				var returnval;
 	 }
	 function chk_sector(s_obj) {
			if(s_obj.value!=0)   {
				m_s_type=s_obj.value;
				servlet_client_url+":"+client_t3_port+"/"+client_name+"mf_senddata1?sec_code="+m_s_type+"&chksql=sector";
				top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
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
  
	
	
<!---------------------------*****--------------------------------------------------->	

	<!------------------------------------------------------------------------------------------------------>
		function display_ins_opt(val) {
	document.Form1.report_but.disabled=true;
			if(val=="A"){
				document.getElementById('div_lable').innerHTML='Instrument Types - New';   //added by Prabash on 24-11-2011
				document.Form1.Hid_scr_name2.value='A';
		    	document.Form1.Text_help.disabled=true;
				document.Form1.save_but.disabled=false;
				document.Form1.Text_ins_desc.disabled=false;
				document.Form1.Text_repo.disabled=false;
				document.Form1.Text_repo_trans.disabled=false;
				document.Form1.Text_ins_code.focus();
		 }
		else if(val=="M"){
				document.getElementById('div_lable').innerHTML='Instrument Types - Edit'; //added by Prabash on 24-11-2011
				document.Form1.Hid_scr_name2.value='M';
		    	document.Form1.Text_help.disabled=false;
				document.Form1.save_but.disabled=false;
				document.Form1.Text_ins_desc.disabled=false;
				document.Form1.Text_repo.disabled=false;
				document.Form1.Text_repo_trans.disabled=false;
			//	document.Form1.Text_ins_code.focus();
				
		 }
		else if(val=="D"){
				document.getElementById('div_lable').innerHTML='Instrument Types - Deactivate'; //added by Prabash on 24-11-2011
				document.Form1.Hid_scr_name2.value='D';
			  	document.Form1.Text_help.disabled=false;
				document.Form1.save_but.disabled=false;
				document.Form1.Text_ins_desc.disabled=true;
				document.Form1.Text_repo.disabled=true;
				document.Form1.Text_repo_trans.disabled=true;
		 }
		else if(val=="R"){
				document.getElementById('div_lable').innerHTML='Instrument Types - Reactivate'; //added by Prabash on 24-11-2011
				document.Form1.Hid_scr_name2.value='R';
			  	document.Form1.Text_help.disabled=false;
				document.Form1.save_but.disabled=false;
				document.Form1.Text_ins_desc.disabled=true;
				document.Form1.Text_repo.disabled=true;
				document.Form1.Text_repo_trans.disabled=true;
		 }
	  else if(val=="V"){
			
				document.Form1.Hid_scr_name2.value='V';
				View_help(0);
		 		//location.href=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalinsttypes?chksql=inst_View_Disp";
	  			document.Form1.save_but.disabled=true;
	  }
	}
		/*function reset(){
				
			document.Form1.Text_ins_code.value="";
			document.Form1.Text_ins_desc.value="";
			document.Form1.Text_cat.OPTION VALUE="DEBT";
			document.Form1.Text_repo.OPTION VALUE="Y";
			document.Form1.Text_repo_trans.value="";
			document.Form1.Text_mt_percent.value="";
			document.Form1.Text_base_int_rate.value="";
			document.Form1.Text_yield_type.value="";
		}*/
		
	function beforesubmit(){	
	document.Form1.Text_cat.disabled = false;
			if(document.Form1.Text_ins_code.value=="") {
			   alert('Please enter the Instrument Code');
				document.Form1.Text_ins_code.focus();
			}
			else if(document.Form1.Text_ins_desc.value=="") {
				alert('Please enter the description');
				document.Form1.Text_ins_desc.focus();
			}
		 	else { 
					Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsavinsttypes_mt";
					Form1.submit();
				 }		
	}	
		
<!---------------------------*****------------------------------------------------>	
	
</SCRIPT>
</HEAD>				
<BODY ONLOAD="display_ins_opt('A')" >
 <FORM NAME="Form1" ID="Form1" METHOD="POST" >
	  <INPUT TYPE="Hidden" NAME="Hid_scr_name"  ID="Hid_scr_name"	VALUE="Instrument_New">
	  <INPUT TYPE="Hidden" NAME="Hid_scr_name2" VALUE="A" >  <!--added by prabash  on 26-09-2011-->
			
	<!-----Added by Prabash on 06-09-2011-----------------------------  -->
			<DIV>
			<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
				<tr>
			<td height='7'></td>
			</tr>
				
			<tr height='30' >
			<td  width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
			<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Administration -Security</B></td>
			<td width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>
						
			</tr>
			
			<tr>
						
			</TABLE>	
					
			</DIV>
				

			<table class='table' border='0' cellpadding='0' cellspacing='0' width='100%'> 
			<tr>
			<td height='1'></td>
			</tr>
			<tr>				
				
			<!----------------------------------------------------------------- --->
						<TABLE WIDTH="100%" BGCOLOR="darkblue" >
				<TR >
					<!--added by prabash on 01-09-2011-->
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="Add" VALUE="Add"   onClick="display_ins_opt('A'); reset()"  class="mainbut"  >
					</TD>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="Mod" VALUE="Edit"   onClick="display_ins_opt('M'); reset()" class="mainbut"  >
					</TD>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="DeAct" VALUE="Deactivate"   onClick="display_ins_opt('D'); reset()"  class="mainbut"  style="{ width: 70px; }">
					</TD>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="ReAct" VALUE="Reactivate"   onClick="display_ins_opt('R'); reset()"  class="mainbut"  style="{ width: 70px; }">
					</TD>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="View"  VALUE="View"        onClick="display_ins_opt('V'); reset()"  class="mainbut"  >
					</TD>
					<TD WIDTH='6%'></TD>		
					<!---------------------------------->
						
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="save_but" VALUE="Save"   onClick="beforesubmit()" class="mainbut"  >
					</TD>
					
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"   onClick="reset()" class="mainbut"> 
				</TD>
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit"   onClick="location.href='low.jsp'" class="mainbut"> 
					</TD>
					<TD WIDTH="6%">
									
						<INPUT TYPE="Button" NAME="report_but" VALUE="Enquiry"    onClick="obtain_report_before()" class="mainbut">
						
					</TD>
								<TD WIDTH="6%">
					<INPUT TYPE="Hidden" NAME="SAVETYPE">
					</TD>
					
					<!--<TD  WIDTH="50%" class="hh1" align="right">-->
					<!--<B>Instrument Types</B>-->
					<TD> <B><div id='div_lable' align='right' > </div> </B> </TD>					
		</TD>
		</TR>
			</TABLE>
						
		<!----------------------------------------------------------------- -->				
			
			     <TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
			<HR>
				<TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
					
		<!------------------------------------------------------------------  -->	
	</TR>
	</TABLE> 		
			
			
		
 	
	 <TABLE BORDER="0" CELLPADDING="1" CELLSPACING="0" WIDTH="100%">
		<TR>
		  	<TD WIDTH="1%"></TD>
			<TD  WIDTH="20%">Instrument Code </TD>
			 <TD><INPUT TYPE="Text" NAME="Text_ins_code"	ALIGN="LEFT" SIZE="15" class="txt_input6" onBlur="val_inscode()" MAXLENGTH=7>
			<INPUT TYPE="BUTTON" NAME="Text_help" onClick="help();"  class="mainbut"  VALUE="..."></TD>	
   		</TR>
		
						
		<TR>
		  <TD WIDTH="1%"></TD>
      	  <TD  WIDTH="20%">Instrument Description</TD>
			 <TD ><INPUT	TYPE="Text" NAME="Text_ins_desc"	ALIGN="LEFT" class="txt_input6" SIZE="37" MAXLENGTH=40></TD>
		</TR>
		
		
						
		<TR>
		  <TD WIDTH="1%"></TD>
      	  <TD  WIDTH="20%">Instrument Category</TD>
			 <TD >
				<SELECT NAME="Text_cat" class="txt_input6">
							<OPTION VALUE="DEBT" SELECTED>DEBT</option> 
							<OPTION VALUE="EQUITY" >EQUITY</option></SELECT></TD> 
		</TR>
		
		
						
		 <TR>
		  <TD WIDTH="1%"></TD>
      	  <TD  WIDTH="20%">Enable Repo Transactions</TD></B>
			 	 <TD >
	  					<SELECT NAME="Text_repo" class="txt_input6">
							<OPTION VALUE="Y" SELECTED>Yes</option> 
							<OPTION VALUE="N" >No</option></SELECT></TD> 
        </TR>
		
   		<TR>	
		  	<TD WIDTH="1%"></TD>
		    <TD  WIDTH="20%">Repo Hair-Cut %</TD>
			 <TD ><INPUT	TYPE="Text" NAME="Text_repo_trans" class="txt_input6"	ALIGN="LEFT" SIZE="15"></TD>
		</TR>
	
						
   		<TR>	
		  	<TD WIDTH="1%"></TD>
		    <TD WIDTH="20%">MT Percent </TD>
			 <TD ><INPUT	TYPE="Text" NAME="Text_mt_percent"	ALIGN="LEFT" class="txt_input6" SIZE="15"></TD>
		</TR>
	
						
   		<TR>	
		  	<TD WIDTH="1%"></TD>
		    <TD  WIDTH="20%">Base Interest Rate</TD>
			 <TD><INPUT	TYPE="Text" NAME="Text_base_int_rate"	ALIGN="LEFT" class="txt_input6" SIZE="15"></TD>
		</TR>
	
						
   		<TR>	
		  	<TD WIDTH="1%"></TD>
		    <TD  WIDTH="20%">Yield Type</TD>
			 <TD><SELECT NAME="Text_yield_type" class="txt_input6" >
							<OPTION VALUE="W" >Weighted Average Cost</option> 
							<OPTION VALUE="S" SELECTED>Specific Cost</option></SELECT></TD>
		</TR>
						
	 </TABLE>		
		
	</TABLE> 		
</TABLE>
</FORM>
	<!--		<SCRIPT LANGUAGE="JavaScript" SRC="html_client_url/mbfsl.js"></SCRIPT>--> 
	</body>	
  <DIV>
			<SCRIPT language1.2="JavaScript" src="validate.js"></SCRIPT>
		<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
</DIV>

</html>	


