<html>
	<head>
		
		<!-- header - edit "Data/yourHtmlHeader" to customize -->
		<!-- contents - edit "EventHandlers/Html file/onCreate" to customize -->
	<!--	<meta name="generator" content="ModelWorks IDE">  -->
		
		<title>Bank Branch Reference Detail</title>
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
		
		
		
		<SCRIPT LANGUAGE="JAVASCRIPT">
			
			//-----------------Start of Java Script-------------------------------------------------------------	
			//-----------------Get the Systems date-------------------------------------------------------------
			
		/*	function get_date() {   
			m_urls=servlet_client_url+":"+client_t3_port+"/"+client_name+"val_bank_ref?chksql=chkscr";
			top.frames[0].document.applets[0].getdata(m_urls);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
			document.Form1.TXTDD.value=top.frames[0].document.applets[0].outvec_value.elementAt(0).substring(0,2);
			document.Form1.TXTMM.value=top.frames[0].document.applets[0].outvec_value.elementAt(0).substring(3,5);
			document.Form1.TXTYYYY.value=top.frames[0].document.applets[0].outvec_value.elementAt(0).substring(6,10);
			document.Form1.TXTDD.disabled=true;
			document.Form1.TXTMM.disabled=true;
			document.Form1.TXTYYYY.disabled=true;
			enable_inputs();
			}
			*/
			//--------------------------------------------------------------------------------------------------
			//-----------------To Enable Inputs-----------------------------------------------------------------
			
			function enable_inputs(){
			if(document.Form1.Hid_scr_name2.value=="add"){
			document.Form1.BUT_HELP.disabled = true;
			}
			
			else if(document.Form1.Hid_scr_name2.value=="mod"){
			document.Form1.BUT_HELP.disabled = false;
			}	
			else if(document.Form1.Hid_scr_name2.value=="re_ac"){
			document.Form1.BUT_HELP.disabled = false;
			
			}
			else if(document.Form1.Hid_scr_name2.value=="de_ac"){
			document.Form1.BUT_HELP.disabled = false;
			
			}	
			else if(ocument.Form1.Hid_scr_name2.value=="view"){
			document.Form1.BUT_HELP.disabled = false;
			}	
			}
			//--------------------------------------------------------------------------------------------------
			//--------------Changing the Hidden Screen Name on Load of the page---------------------------------
			function change_status(){
			if(document.Form1.Hid_scr_name2.value=="add"){
			document.Form1.Hid_scr_name.value = "create";
			}
			
			else if(document.Form1.Hid_scr_name2.value=="mod"){
			document.Form1.Hid_scr_name.value = "modify";
			}	
			else if(document.Form1.Hid_scr_name2.value=="re_ac"){
			document.Form1.Hid_scr_name.value = "reactivate";
			
			}
			else if(document.Form1.Hid_scr_name2.value=="de_ac"){
			document.Form1.Hid_scr_name.value = "deactivate";
			
			}	
			else if(ocument.Form1.Hid_scr_name2.value=="view"){
			document.Form1.Hid_scr_name.value = "view";
			}	
			}
			//--------------------------------------------------------------------------------------------------
			//--------------------Initialization for the HelpBox------------------------------------------------
			
			function myDialogObj() {
			var htmlstr; 
			var returnval;
			}
			
			//--------------------------------------------------------------------------------------------------
			//--------------------Initialization for the View---------------------------------------------------
			
			function myDialogObjview() {
			var htmlstr; 
			}
			
			//--------------------------------------------------------------------------------------------------
			//--------------------Loading the Help data---------------------------------------------------------
			
		/*	function load_help(){
			if 	
			var option1=parseInt(parent.frame1.Form1.SEL_BR_TYPE.value);
			if(option1!=1)
			{	
			var m_bcode2=(parent.frames[1].document.Form1.TXTBRCODE.value.toUpperCase());
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"val_bank_ref?chksql=help_data&bcode2="+m_bcode2+"&option="+option1;
			//alert(m_url);
			top.frames[0].document.applets[0].getdata(m_url);
			var rec_size=top.frames[0].document.applets[0].outvec_value.size();
			var vec_pos=0;
			var rec_str="";
			var str1,str2;
			var lineno=1;
			var main_body="";
			while(vec_pos<rec_size){
			str1=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
			str2=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
			rec_str=rec_str+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+lineno+'><B>'+str1+'</B></TD><TD ID=C2R'+lineno+'><B>'+str2+'</B></TD></TR>';
			lineno++;
			vec_pos=vec_pos+2;
			}
			main_body="<table style='{color:white ; font: 9pt arial;text-align:center;}'  bgcolor='silver'  width='100%'><tr bgcolor='darkblue'><td  style='{font:bold 10pt arial ;text-align:center;}' width='50%'>Branch Code</td><td  style='{font:bold 10pt arial;text-align:center}' width='50%'>Branch Name</td></tr>"+rec_str+"</table>";
			myDialogObj.htmlstr=main_body;
			myDialogObj.returnval="";
			popupwin = window.showModalDialog(html_client_url+"/help_box.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no"); 
				if(!myDialogObj.returnval){//added by keith 10-05-2004
				return 0;
				}//end here
			load_data_modify(myDialogObj.returnval);
			}	
			}
			*/
			function load_help(){

			if(document.Form1.Hid_scr_name2.value=="re_ac"){
				sec_help1(0);	
			  }
			else 
				sec_help2(0);
		   }
			//----------------------------------------help1**
		function	sec_help1(m_strat){
			
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	
		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.TXTBRCODE;
 		myObject[1]=aForm.TXTBRNAME;
 		myObject[2]=aForm.TXTBANKNAME;
			
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.TXTBRCODE.value;
 		myObject_value[1]=null;

 		var myObject_type=new Array(); //passing values data type
		myObject_type[0]="StringL";
 		myObject_type[1]=null;	
 	
 		var qid='57';

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
			
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);load_data_modify(myDialogObj.returnval);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
	}
		//----------------------------------------------**
			
		//----------------------------------------help2**
		function	sec_help2(m_strat){
			
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	
		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.TXTBRCODE;
 		myObject[1]=aForm.TXTBRNAME;
 		myObject[2]=aForm.TXTBANKNAME;
			
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.TXTBRCODE.value;
 		myObject_value[1]=null;

 		var myObject_type=new Array(); //passing values data type
		myObject_type[0]="StringL";
 		myObject_type[1]=null;	
 	
 		var qid='58';

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
			
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); if(returnedValue!=null){load_data_modify(myDialogObj.returnval);}  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
	}
		//----------------------------------------------**	
			
			
		function load_tab(){
			
			
			m_brcode=document.Form1.TXTBRCODE.value;
		
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"val_bank_ref?chksql=modify_data&bcode="+m_brcode+"";
			//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities_MT?chksql=first_text&date="+m_code+"&date2="+m_code2+"";
			
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
		
			//top.frames[0].document.applets[0].getdata(m_url);
			//var rec_size=top.frames[0].document.applets[0].outvec_value.size();
			
			if(m_size==0){0
			 return 0;
					}

		
			document.Form1.TXTBRCODE.value=data_vec[0];
			document.Form1.TXTBRNAME.value=data_vec[1];
			document.Form1.TXTADDR1.value=data_vec[2];
			document.Form1.TXTADDR2.value=data_vec[3];
			document.Form1.TXTADDR3.value=data_vec[4];
			document.Form1.TXTBRTPNO.value=data_vec[5];
			document.Form1.SEL_GS.value=data_vec[6];
			document.Form1.TXTBANKNAME.value=data_vec[7];
			
		 
		}	
			//------------------------------------------------------------------------------------------------------------
			//--------------------Loading the Help data to Modify---------------------------------------------------------
			
			function load_data_modify(){
			
			
			m_brcode=document.Form1.TXTBRCODE.value;
			
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"val_bank_ref?chksql=modify_data&bcode="+m_brcode+"";
			//window.open(m_url);
			
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;	
		//	alert(m_size);	
			if(m_size>0){	
			//top.frames[0].document.applets[0].getdata(m_url);
			//var rec_size=top.frames[0].document.applets[0].outvec_value.size();
			
			
			//alert("2");
			//alert(rec_size);
			//alert(top.frames[0].document.applets[0].outvec_value.elementAt(0).toString());
			//alert("3");
			
			document.Form1.TXTBRCODE.value=data_vec[0];
	
			document.Form1.TXTBRNAME.value=data_vec[1];
			document.Form1.TXTADDR1.value=data_vec[2];
			document.Form1.TXTADDR2.value=data_vec[3];
			document.Form1.TXTADDR3.value=data_vec[4];
			document.Form1.TXTBRTPNO.value=data_vec[5];
			document.Form1.SEL_GS.value=data_vec[6];
			document.Form1.TXTBANKNAME.value=data_vec[7];
			
				if(document.Form1.Hid_scr_name2.value=="de_ac"){
			document.Form1.TXTBRCODE.disabled=true;
			document.Form1.TXTBRNAME.disabled=true;
			document.Form1.TXTADDR1.disabled=true;
			document.Form1.TXTADDR2.disabled=true;
			document.Form1.TXTADDR3.disabled=true;
			document.Form1.TXTBRTPNO.disabled=true;
			document.Form1.SEL_GS.disabled=true;
			document.Form1.TXTBANKNAME.disabled=true;
		
			
		}	
		else if(document.Form1.Hid_scr_name2.value=="re_ac"){
			document.Form1.TXTBRCODE.disabled=true;
			document.Form1.TXTBRNAME.disabled=true;
			document.Form1.TXTADDR1.disabled=true;
			document.Form1.TXTADDR2.disabled=true;
			document.Form1.TXTADDR3.disabled=true;
			document.Form1.TXTBRTPNO.disabled=true;
			document.Form1.SEL_GS.disabled=true;
			document.Form1.TXTBANKNAME.disabled=true;	
		}
		
		else if(document.Form1.Hid_scr_name2.value=="mod"){
		//	document.Form1.TXTBRCODE.disabled=true;
			
		}
		   }	
			}
			
			//------------------------------------------------------------------------------------------------------------
			//--------------------Loading the View------------------------------------------------------------------------
			
		function view_rec(m_strat){
			var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	
		var myObject=new Array(); //return values set to this object
 		myObject[0]=null;
 		myObject[1]=null;
 		myObject[2]=null;
		myObject[3]=null;
		myObject[4]=null;
		myObject[5]=null;
		myObject[6]=null;
		myObject[7]=null;
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=null;
 		myObject_value[1]=null;

 		var myObject_type=new Array(); //passing values data type
		myObject_type[0]=null;	
 		myObject_type[1]=null;	
 	
 		var qid='61';

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
		 height:500, // 500,
		 width: 800, //900,
		 title: 'SasiNet Frame work',
		 scrollable: true,
			
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
	}
			
			/*	function view_rec(){
				
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"val_bank_ref?chksql=view";
			top.frames[0].document.applets[0].getdata(m_url);
			var rec_size=top.frames[0].document.applets[0].outvec_value.size();
			var vec_pos=0;
			var rec_str1;
			var str1,str2,str3,str4,str5,str6,str7;
			var main_body;
			rec_str1=" ";
			
			while(vec_pos<rec_size){
			str1=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
			str2=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
			str3=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2);
			str4=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+3);
			str5=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+4);
			str6=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+5);
			str7=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+6);
			str8=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+7);
			rec_str1=rec_str1+'<TR STYLE="{color: black;}"><TD><B>'+str1+'</B></TD><TD><B>'+str2+'</B></TD><TD><B>'+str3+'</B></TD><TD><B>'+str4+'</B></TD><TD><B>'+str5+'</B></TD><TD><B>'+str6+'</B></TD><TD><B>'+str7+'</B></TD><TD><B>'+str8+'</B></TD></TR>';
			vec_pos=vec_pos+8;
			}
			main_body="<table style='{color: white; font: 9pt arial;text-align:center;}'  bgcolor='white'  border=1 width='100%'><tr bgcolor='darkblue'><td  style='{font:bold 10pt arial ;text-align:center;}' >Branch Code</td><td  style='{font:bold 10pt arial ;text-align:center;}' >Branch Name</td>";
			
			main_body=main_body+"<td  style='{font:bold 10pt arial ;text-align:center;}' >Bank Address 1</td><td  style='{font:bold 10pt arial ;text-align:center;}' >Bank Address 2</td>";
			main_body=main_body+"<td  style='{font:bold 10pt arial ;text-align:center;}' >Bank Address 3</td><td  style='{font:bold 10pt arial ;text-align:center;}' >Branch Telephone No</td>";
			main_body=main_body+"<td  style='{font:bold 10pt arial ;text-align:center;}' >Globus Status</td><td  style='{font:bold 10pt arial ;text-align:center;}' >Active Status</td>"+rec_str1+"</table>";
			myDialogObjview.htmlstr=main_body;
			popupwin = window.showModalDialog(html_client_url+"/dn_bank_view.html",myDialogObjview,"dialogWidth:250em; dialogHeight:43em; dialogTop:80;center:yes; resizable:yes; status:no"); 
			}
		*/	
			//------------------------------------------------------------------------------------------------------------
			//----------Checks the Branch Code in the database and loads data------------------------------------------------------------------------------------------------
			
			function checkval(){
			if(document.Form1.Hid_scr_name2.value=="add"){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"val_bank_ref?bcode="+document.Form1.TXTBRCODE.value.toUpperCase()+'&chksql=chk_bcode';
			//alert()
			//top.frames[0].document.applets[0].getdata(m_urls);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();		
			
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
				
			//alert(m_size);	
			if(m_size>0){
			alert("'Branch code' is already in the database...");
			Form1.TXTBRCODE.value="";
			Form1.TXTBRNAME.value="";
			Form1.TXTADDR1.value="";
			Form1.TXTADDR2.value="";
			Form1.TXTADDR3.value="";
			Form1.TXTBRTPNO.value="";
			Form1.TXTBRCODE.focus();
			}
			//document.Form1.Hid_scr_name.value = "create";
			}
			
				else if(document.Form1.Hid_scr_name2.value=="mod"){
				
			//load_help();
			load_tab();
			//load_data_modify(parent.frames[1].Form1.TXTBRCODE.value.toUpperCase());
			//document.Form1.Hid_scr_name.value = "modify";
			}	
			else if(document.Form1.Hid_scr_name2.value=="re_ac"){		
			//	load_data_modify();
				load_tab()	
		
		
		
			//document.Form1.Hid_scr_name.value = "reactivate";
			}
			else if(document.Form1.Hid_scr_name2.value=="de_ac"){
			//	load_data_modify();
				load_tab()
				
			//document.Form1.Hid_scr_name.value = "deactivate";
			}	
			else if(document.Form1.Hid_scr_name2.value=="view"){
			document.Form1.Hid_scr_name.value = "view";
			}	
			}
			
			//-----------------------------------------------------------------------------------------------------------------------------
			function telcheck()
			{
			var telno=document.Form1.TXTBRTPNO.value;
			 chkNumber(telno);			
			}
			function chkNumber(inputVal) 
	    {
		   oneDecimal = false;
		   inputStr = inputVal.toString();
		   for (var i = 0; i < inputStr.length; i++) 
		   {
				var oneChar = inputStr.charAt(i);
				if (oneChar < "0" || oneChar > "9") 
			{
			alert('Please Enter a Number');
		 	return false
			}
				
				
		}
		return true;
		
	}
			
		//function display_type(){
			
		function display_sec_opt(val){
		//alert(val);
				//-----------------*
				if(val=="add"){	
		  		document.getElementById('div_lable').innerHTML='Banks - New'; 
			    document.Form1.Hid_scr_name2.value='add';
			
				}
					else if(val=="mod"){ 
  				document.getElementById('div_lable').innerHTML='Banks - Edit'; 
				document.Form1.Hid_scr_name2.value='mod';
			  }
					else if(val=="de_ac"){ 
	  			document.getElementById('div_lable').innerHTML='Banks - Deactivate'; 
				document.Form1.Hid_scr_name2.value='de_ac';
			  }
					else if(val=="re_ac"){ 
		  		document.getElementById('div_lable').innerHTML='Banks - Reactivate'; 	   
				document.Form1.Hid_scr_name2.value='re_ac';
			  }
					else if(val=="view"){ 
			  // 	document.getElementById('div_lable').innerHTML='Banks - view';  
				document.Form1.Hid_scr_name2.value='view';
			  }	
			
			
			 if  (val=="add"){
				document.Form1.BUT_HELP.disabled = true;
				parent.frames[1].document.Form1.TXTBRCODE.disabled = false;//edited by keith
				document.Form1.BUT_SAVE.disabled = false;
				document.Form1.BUT_CANCEL.disabled = false;
				document.Form1.BUT_EXIT.disabled = false;
			//	document.location.reload();
				document.Form1.Hid_scr_name.value="create";
	}
				else if  (val=="mod"){
				document.Form1.BUT_HELP.disabled = false;
				//parent.frames[1].document.Form1.TXTBRCODE.disabled = true;//edited by keith
				document.Form1.BUT_SAVE.disabled = false;
				document.Form1.BUT_CANCEL.disabled = false;
				document.Form1.BUT_EXIT.disabled = false;
				//document.location.reload();
			//	document.Form1.SEL_BR_TYPE.selectedIndex=1;
				document.Form1.Hid_scr_name.value="modify";
	}	
	 			else if (val=="re_ac"){
				//document.location.reload();
				document.Form1.BUT_HELP.disabled = false;
				document.Form1.TXTBRCODE.disabled = false;//edited by keith
				document.Form1.BUT_SAVE.disabled = false;
				document.Form1.BUT_CANCEL.disabled = false;
				document.Form1.BUT_EXIT.disabled = false;
			//	document.Form1.SEL_BR_TYPE.selectedIndex=2;
				document.Form1.Hid_scr_name.value="reactivate";
	}
				else if (val=="de_ac"){
				document.Form1.BUT_HELP.disabled = false;
				document.Form1.TXTBRCODE.disabled = false;//edited by keith
				document.Form1.BUT_SAVE.disabled = false;
				document.Form1.BUT_CANCEL.disabled = false;
				document.Form1.BUT_EXIT.disabled = false;
				//document.location.reload();
				//document.Form1.SEL_BR_TYPE.selectedIndex=3;
				document.Form1.Hid_scr_name.value="deactivate";
			  }	
				else if (val=="view"){
				//parent.frames[1].document.Form1.BUT_HELP.disabled = false;
				//parent.frames[1].document.Form1.TXTBRCODE.disabled = true;
				document.Form1.BUT_SAVE.disabled = true;
				document.Form1.BUT_HELP.disabled=true;		    
		    	document.Form1.TXTBRCODE.disabled=true;
				document.Form1.Hid_scr_name.value="view";
				view_rec(0);
	}	
}
			function  beforesubmit(){

		if(document.Form1.TXTBRCODE.value=="") {
			   alert('Please enter the Branch Code');
				 document.Form1.TXTBRCODE.focus();
				 return false;
			}
		else if(document.Form1.TXTBRNAME.value=="") {
			   alert('Please enter the Branch Name');
				document.Form1.TXTBRNAME.focus();
				 return false;	
		}
			document.Form1.TXTBRCODE.disabled=false;
			document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"save_bank_ref";
			document.Form1.submit();

		}
		
			function screenclose(){
			top.frames[1].location.href='low.jsp';
		}
		
			function cancelling(){
			document.Form1.TXTBRCODE.value="";
			document.Form1.TXTBRNAME.value="";
			document.Form1.TXTBANKNAME.value="";
			document.Form1.TXTADDR1.value="";
			document.Form1.TXTADDR2.value="";
			document.Form1.TXTADDR3.value="";
			document.Form1.TXTBRTPNO.value="";
			
			document.Form1.TXTBRCODE.disabled=false;
			document.Form1.TXTBRNAME.disabled=false;
			document.Form1.TXTADDR1.disabled=false;
			document.Form1.TXTADDR2.disabled=false;
			document.Form1.TXTADDR3.disabled=false;
			document.Form1.TXTBRTPNO.disabled=false;
			document.Form1.SEL_GS.disabled=false;
			document.Form1.TXTBANKNAME.disabled=false;	
			
			}	
				
			function reset(){
				
			document.Form1.TXTBRCODE.value="";
			document.Form1.TXTBRNAME.value="";
			document.Form1.TXTBANKNAME.value="";
			document.Form1.TXTADDR1.value="";
			document.Form1.TXTADDR2.value="";
			document.Form1.TXTADDR3.value="";
			document.Form1.TXTBRTPNO.value="";
			
			}
			
			function  obtain_report_before(){
				
			document.Form1.BUT_SAVE.disabled=true;
			document.Form1.TXTBRCODE.disabled=true;	
				sec_help2(0)
			}
			//----------------------------------------End of JavaScript--------------------------------------------------------------------
			
		</SCRIPT>
	</head>
	<body  ONLOAD = "display_sec_opt('add')" >
		<FORM NAME="Form1"  ID="Form1" METHOD="POST">
			<INPUT TYPE="Hidden" NAME="Hid_scr_name" VALUE="create">
			<INPUT TYPE="Hidden" NAME="Hid_scr_name2" VALUE="add" >
			<DIV>
			<TABLE class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
			
			<tr>
			<td height='7'></td>
			</tr>
				
			<tr height='30' >
			<td  width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
			<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'> <B> 	Administration  - System Maintenance</B></td>
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
	    <!---------------------------------------------------------------->		
						
	
						
		<!----------------------------------------------------------------- --->
						<TABLE WIDTH="100%" BGCOLOR="darkblue" >
					<TR >
					<!--added by prabash on 01-09-2011-->
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="Add" VALUE="Add"   onClick="display_sec_opt('add'); cancelling()"  class="mainbut"  >
					</TD>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="Mod" VALUE="Edit"   onClick="display_sec_opt('mod'); cancelling()" class="mainbut"  >
					</TD>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="DeAct" VALUE="Deactivate"   onClick="display_sec_opt('de_ac'); cancelling()"  class="mainbut"  style="{ width: 70px; }">
					</TD>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="ReAct" VALUE="Reactivate"   onClick="display_sec_opt('re_ac'); cancelling()"  class="mainbut"  style="{ width: 70px; }">
					</TD>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="View" VALUE="View"   onClick="display_sec_opt('view')"  class="mainbut"  >
					</TD>
					<TD WIDTH='6%'></TD>		
					<!---------------------------------->
						
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="BUT_SAVE" VALUE="Save"   onClick="beforesubmit()" class="mainbut"  >
					</TD>
					
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="BUT_CANCEL" VALUE="Cancel"   onClick="cancelling()" class="mainbut"> 
				</TD>
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="BUT_EXIT" VALUE="Exit"   onClick="screenclose()" class="mainbut"> 
					</TD>
					<TD WIDTH="6%">
									
						<INPUT TYPE="Button" NAME="report_but" VALUE="Enquiry"    onClick=" cancelling(); obtain_report_before()" class="mainbut">
						
					</TD>
								<TD WIDTH="6%">
					<INPUT TYPE="Hidden" NAME="SAVETYPE">
					</TD>
						<!--<TD  WIDTH="50%" class="hh1" align="right">-->
									
					<!--<B>Banks</B>-->
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
	
			
				
		<table width="100%" border="0" cellpadding="1" cellspacing="0" >
							
							
						<TR>			
							<TD WIDTH="1%"></TD>
							<TD  WIDTH="16%">Branch Code</TD>									
							<TD><INPUT TYPE="Text" NAME="TXTBRCODE" VALUE="" MAXLENGTH="10" class="txt_input6" onBlur="checkval()">
							<INPUT TYPE="Button" NAME="BUT_HELP" VALUE="..." class="mainbut"  onClick="load_help()">
						</TR>
				
						<TR>
							<TD WIDTH="1%"></TD>				
							<TD WIDTH="16%">Branch Name</TD>
							<TD><INPUT TYPE="Text" NAME="TXTBRNAME" VALUE="" class="txt_input6" SIZE="50" MAXLENGTH="50"></TD>
						</TR>
								
						<TR>
							<TD WIDTH="1%"></TD>				
							<TD WIDTH="16%">Bank Name</TD>
							<TD><INPUT TYPE="Text" NAME="TXTBANKNAME" VALUE="" class="txt_input6" SIZE="50" MAXLENGTH="50"></TD>
						</TR>
								
						<TR >
							<TD WIDTH="1%"></TD>
							<TD WIDTH="16%"><u>Bank Address</u></TD>
						</TR>
						
						<TR>
							<TD WIDTH="1%"></TD>				
							<TD WIDTH="16%">Address</TD>
							<TD><INPUT TYPE="Text" NAME="TXTADDR1" VALUE="" class="txt_input6" SIZE="30" MAXLENGTH="30"></TD>
						</TR>
										
						<TR>
							<TD WIDTH="1%"></TD>				
							<TD WIDTH="16%"></TD>
							<TD ><INPUT TYPE="Text" NAME="TXTADDR2" VALUE="" class="txt_input6" SIZE="30" MAXLENGTH="30"></TD>
						</TR>
										
						<TR> 
							<TD WIDTH="1%"></TD>				
							<TD WIDTH="16%"></TD>
							<TD ><INPUT TYPE="Text" NAME="TXTADDR3" VALUE="" class="txt_input6" SIZE="30" MAXLENGTH="30"></TD>
						</TR>


						<TR>
							<TD WIDTH="1%"></TD>				
							<TD WIDTH="16%">Branch Tel.No</TD>
							<TD ><INPUT TYPE="Text" NAME="TXTBRTPNO" VALUE="" class="txt_input6" MAXLENGTH="20" onBlur="telcheck()" ></TD>
						</TR>
									
						<TR>
							<TD WIDTH="1%"></TD>				
							<TD WIDTH="16%">Global Status</TD>
							<TD><SELECT NAME="SEL_GS" class="txt_input6" >
								<OPTION VALUE="Y" SELECTED>Yes</option> 
								<OPTION VALUE="N" >No</option> </TD>
						</TR>				
								
							</TABLE> 
						</TD>
					</TR>
				</TABLE>
			</TABLE>
			</FORM>
			<SCRIPT language1.2="JavaScript" src="validate_v1.js"></SCRIPT>
			<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>									
		</body>
											
		
		
	</html>
	
