
<!--Created by prabash on 15-09-2011 for LBMARGIN -->
<html>
	<head>
		<meta name="generator" content="ModelWorks IDE">
		<title>Untitled</title>
		<LINK REL="stylesheet" TYPE="text/css" HREF="" />
		
	</head>
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
	<script language="javascript1.2">
		
		var i=1;
		var bank_accs=new Array();
		m_writedata='<tr bgcolor="gray">'+
			'<td ><b>Bank Code</b></td><td ><b>Name</b></td>'+
			'<td ><b>Account No</b></td>'+
			'</tr>';
		bank_accs[0]=m_writedata;		 
		var m_bank_line=1;
		var arr_size=0;
		var m_tel_count=2;
		
		
		function chkstartdate(dayobj,monthobj,yearobj) {
			checkMonthLength(dayobj,monthobj,yearobj);		
		}
		
		
		
		function display_next_tel() {
			m_addition="";
			m_addition='<table width="100%" border="0" cellpadding="1" cellspacing="0">'+
				'<tr><td width="1%"></td><td width="16%"></td>'+
				'<td><input type="text" name="txt_con'+m_tel_count+'"	align="left" size="14"></td></tr></table>';
			m_tel_count++;
			cus_con.innerHTML=cus_con.innerHTML+m_addition;
		}
		
		
		function add_bank_acc() {
			m_writedata='<tr style="{color: white; cursor:hand;}" id=LINE'+m_bank_line+' bgcolor="darkblue" '+
				'onmouseover=mouseover_set(LINE'+m_bank_line+'); onmouseout=mouseout_set(LINE'+m_bank_line+'); onclick=fill_dis_area('+m_bank_line+');>'+
				'<td width="20%"><b>'+document.Form1.txt_bank_code.value+'</b></td>'+
				'<td width="60%"><b>'+document.Form1.txt_bank_name.value+'</b></td>'+
				'<td width="20%"><b>'+document.Form1.txt_accno.value+'</b></td>';
			m_hid_input='<input type="hidden" name=hid_bank_code'+m_bank_line+'	value='+document.Form1.txt_bank_code.value+'>'+	
				'<input type="hidden" name=hid_bank_name'+m_bank_line+'	value='+document.Form1.txt_bank_name.value+'>'+	
				'<input type="hidden" name=hid_accno'+m_bank_line+'	value='+document.Form1.txt_accno.value+'></tr>';	
			bank_accs[m_bank_line]=m_writedata+m_hid_input;			
			m_bank_line++;	
			arr_size++;
			m_table.innerHTML='<table bgcolor="gray" width="98%" align="center" style="{color: dark blue;}">'+
				bank_accs.join(" ")+'</table>';
			document.Form1.txt_bank_code.value="";
			document.Form1.txt_bank_name.value="";
			document.Form1.txt_accno.value="";
		}
		
		
		function mouseover_set(id) {
			id.style.color="darkblue";
			id.style.background="white";
		}
		
		
		function mouseout_set(id) {
			id.style.color="white";
			id.style.background="darkblue";
		}
		
		
		function myDialogObj() {
			var htmlstr; 
			var returnval;  
		}
		
		function beforesubmit(){
			//alert(document.Form1.txt_code.value);
			for (var i=0; i < document.Form1.elements.length; i++ ) {
				document.Form1.elements[i].disabled=false;
			}
			Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"advise_save";
			Form1.submit();
		}
		
		function chkadvcode(){
			if(document.Form1.Hid_scr_name.value=="ADV_NEW"){
				
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bval_advise?code="+document.Form1.txt_code.value+"&chksql=chk_advcode";
				
				
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
					
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				//alert(m_size);
				if (m_size>0){
					alert("Advisor/Mkt.Exec. Code already exist");
					document.Form1.txt_code.value="";
					//document.Form1.txt_code.focus();
				}
				else{
				}
			}
			else {
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bval_advise?code="+document.Form1.txt_code.value+"&chksql=chk_advcode_moddel";
				
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
				
			//	top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				//alert(m_size);
				if (m_size>0){
					// document.Form1.txt_code.value=top.frames[0].document.applets[0].outvec_value.elementAt(0);
					//document.Form1.txt_code.disabled=false;
					document.Form1.txt_title.value=data_vec[0];
					document.Form1.txt_desig.value=data_vec[3];
					document.Form1.txt_add1.value=data_vec[5];
					document.Form1.txt_add2.value=data_vec[6];
					document.Form1.txt_add3.value=data_vec[7];
					document.Form1.txt_add4.value=data_vec[8];
					document.Form1.text_dob_dd.value=data_vec[9].substring(8,10);
					document.Form1.text_dob_mm.value=data_vec[9].substring(5,7);
					document.Form1.text_dob_yy.value=data_vec[9].substring(0,4);
					document.Form1.txt_con1.value=data_vec[11];
					document.Form1.txt_nic.value=data_vec[4];
					document.Form1.txt_remarks.value=data_vec[10];
					if(document.Form1.Hid_scr_name.value=="ADV_MOD"){
						document.Form1.txt_code.disabled=true;
					}
					else if(document.Form1.Hid_scr_name.value=="ADV_DEL"){
						document.Form1.txt_code.disabled=true;
						document.Form1.txt_title.disabled=true;
						document.Form1.txt_desig.disabled=true;
						document.Form1.txt_add1.disabled=true;
						document.Form1.txt_add2.disabled=true;
						document.Form1.txt_add3.disabled=true;
						document.Form1.txt_add4.disabled=true;
						document.Form1.text_dob_dd.disabled=true;
						document.Form1.text_dob_mm.disabled=true;
						document.Form1.text_dob_yy.disabled=true;
						document.Form1.txt_con1.disabled=true;
						document.Form1.txt_nic.disabled=true;
						document.Form1.txt_remarks.disabled=true;
					}
				}
			}
		}
		function defa_acts(){
		//	alert("asd");
				
			document.getElementById('div_lable').innerHTML='Advisor-New'; 
			if(document.Form1.Hid_scr_name.value=="ADV_NEW"){
				document.Form1.but_txt_code.disabled=true;
				document.Form1.txt_code.disabled=true;
				
			}
			else{
				document.Form1.but_txt_code.disabled=false;
				
			}
		}
		
		/*-----------------------------
		
		function code_help(){
			document.Form1.hid_help_type.value="1";
			m_sql = "m_code_help_inqsql";//"m_code_help_inqsql_m";
			m_criteria = "@";
			HelpBox('1','10','7');
		}
		
		*/  //--------------------------
		
	
			
		function code_help(m_strat){
			var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	 
		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.txt_code;
 		myObject[1]=aForm.txt_title;
 		myObject[2]=aForm.txt_desig;
 		myObject[3]=aForm.txt_nic;
 		myObject[4]=aForm.txt_add1;
		myObject[5]=aForm.txt_add2;
		myObject[6]=aForm.txt_add3;
		myObject[7]=aForm.txt_add4;
		myObject[8]=aForm.text_dob_dd;
		myObject[9]=aForm.text_dob_mm;
		myObject[10]=aForm.text_dob_yy;
		myObject[11]=aForm.txt_remarks;
		myObject[12]=aForm.txt_con1;
		myObject[13]=aForm.txt_broker;
		
			
  
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.txt_code.value;
 		myObject_value[1]=null;//aForm.oLastName2.value;
 		myObject_value[2]=null;
 		
 
 		var myObject_type=new Array(); //passing values data type
 		myObject_type[0]="StringL";
 		myObject_type[1]=null;
 		myObject_type[2]=null;
 		myObject_type[3]=null;
 		myObject_type[4]=null;
 
 		var qid='25';
		var hid='10';
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
		 height:400,// 600,
		 width: 400,//900,
		 title: 'SasiNet Frame work',
		 scrollable: true,
		 onClose: function()
		 { 
				var returnedValue = this.returnValue; 
				set_return_value(myObject,returnedValue); 
				mod_display6();	  
			} //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
		
		}
		
		
		function myDialogObj() {
			var htmlstr; 
			var returnval;
		}
		<!--------------------------------------------------------------------------------------------->
		
		function broker_help() {
			
			
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bval_advise?chksql=broker_code_help";
			//alert(m_url);
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
			
		//	top.frames[0].document.applets[0].getdata(m_url);
		//	m_size=top.frames[0].document.applets[0].outvec_value.size();
			//alert(m_size);
			vec_pos=0;
			m_row="";
			lineno=1;
			while (vec_pos<m_size) {
				
				m_ins_code=data_vec[0];
				m_ins_desc=data_vec[1];
				m_row=m_row+'<TR STYLE="{color:black; cursor:hand font: bold 9pt Arial;}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_ins_code+
					'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_ins_desc+'</B></TD></TR>';
				vec_pos=vec_pos+2;
				lineno=lineno+1;
			}
			m_writedata ='<TABLE BGCOLOR="gray" WIDTH="100%" STYLE="{color:black; font: bold 9pt Arial;}">'+
				'<TR BGCOLOR="silver"><TD WIDTH="50%"><B>Broker Code</B></TD>' +
				'<TD WIDTH="50%"><B>Description</B></TD></TR>'+m_row+'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval = "";
			popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
			document.Form1.txt_broker.value=myDialogObj.returnval;
			document.Form1.txt_broker.focus();
		}
			
		function broker_help(m_strat) {	
			
			var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	 
		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.txt_broker;
 		myObject[1]=aForm.null;
 		
		
			
  
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.txt_broker.value;
 		myObject_value[1]=null;//aForm.oLastName2.value;
 		
 		
 
 		var myObject_type=new Array(); //passing values data type
 		myObject_type[0]="StringL";
 		myObject_type[1]=null;
 		
 		var qid='26';

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
		 height:400,// 500,
		 width: 400,//900,
		 title: 'SasiNet Frame work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
		}
			
			
			
			
		
		function myDialogObj() {
			var htmlstr; 
			var returnval;
		}
		
		
		
		
		function broker_help111() {
			
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"_bval_advise?chksql=broker_code_help";
			alert(m_url);
			parent.frames[0].document.applets[0].getdata(m_url);
			m_size=0;
			m_size=parent.frames[0].document.applets[0].outvec_value.size();
			vec_pos=0;
			m_row="";
			lineno=1;
			while (vec_pos<m_size) {
				m_tax_code=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
				m_tax_desc=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1); 
				m_row=m_row+'<TR STYLE="{color:black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_tax_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_tax_desc+'</B></TD></TR>';
				
				vec_pos=vec_pos+3;
				lineno=lineno+1;
			}
			
			m_writedata ='<TABLE BGCOLOR="siler" WIDTH="100%" STYLE="{color: darkblue; font: 9pt sans-serif;}">'+
				'<TR BGCOLOR="silver"><TD WIDTH="50%"><B>Broker Code</B></TD>' +
				'<TD WIDTH="50%"><B>Broker Name</B></TD>'+
				
				m_row+
				'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval = "";
			popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:35em; dialogHeight:20em; center:yes; resizable:yes; status:no"); 
			document.Form1.txt_broker.disabled=false;
			document.Form1.txt_broker.focus();
			
			document.Form1.txt_broker.value=myDialogObj.returnval;
			helpvalue=0;
			vec_pos=0;
			
		}	
		
		
		
		
		
		
		function MyDialog(){
			this.valout   = new Array(10);
		}		
		
		function HelpBox(Start,End,Hid_No,Max) {
			oBj = new MyDialog();
			oBj.valout[1]  = " ";
			oBj.valout[2]  = " ";
			oBj.valout[3]  = " ";
			popupwin = window.showModalDialog(""+servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_fund_Help_Servlet?class_in="+client_name+"mbfsl_fund_help_select"+
				"&Sql_in="+m_sql+"&Start_in="+Start+
					"&End_in="+End+"&Crit_In="+m_criteria+
					"&Hid_No="+Hid_No+"", oBj,"dialogWidth:25em; dialogHeight:18em; center:yes; status:no");
			
			
			
			
			if(document.Form1.hid_help_type.value=="1"){
				if(oBj.valout[1] !=" "){
					if(oBj.valout[1] !='Close'){
						if(oBj.valout[1]!="Prev"){
							if(oBj.valout[1]!="Next"){
								asign_account_no();
							}
							else{
								Next(oBj.valout[2],oBj.valout[3],Hid_No);
								return false;
							} 
						}
						else{	
							Prev(oBj.valout[2],oBj.valout[3],Hid_No);
						}	
					}		
					else{		
						//document.Form1.Text_recno.value="";	
					}		
				}
				else{		
					//document.Form1.Text_recno.value="";	
				}		
			}	
		}
		
		
		
		function Prev(Start,End,Hid_No){
			HelpBox(Start,End,Hid_No)
		}
		function Next (Start,End,Hid_No){
			HelpBox(Start,End,Hid_No)
		}
		
	/*	function asign_account_no() {
			if(document.Form1.Hid_scr_name.value=="ADV_NEW"){
				document.Form1.txt_code.disabled=false;
			}
			else if (document.Form1.Hid_scr_name.value=="ADV_MOD"){
				document.Form1.txt_code.disabled=true;
			}
			else if (document.Form1.Hid_scr_name.value=="ADV_DEL"){
				document.Form1.txt_code.disabled=true;
			}
			
			document.Form1.txt_code.value=oBj.valout[2];
			//document.Form1.txt_code.disabled=false;
			document.Form1.txt_title.value=oBj.valout[3];
			document.Form1.txt_desig.value=oBj.valout[4];
			document.Form1.txt_add1.value=oBj.valout[6];
			document.Form1.txt_add2.value=oBj.valout[7];
			document.Form1.txt_add3.value=oBj.valout[8];
			document.Form1.txt_add4.value=oBj.valout[9];
			document.Form1.text_dob_dd.value=oBj.valout[10].substring(8,10);
			document.Form1.text_dob_mm.value=oBj.valout[10].substring(5,7);
			document.Form1.text_dob_yy.value=oBj.valout[10].substring(0,4);
			document.Form1.txt_con1.value=oBj.valout[12];
			document.Form1.txt_nic.value=oBj.valout[5];
			document.Form1.txt_remarks.value=oBj.valout[11];
			document.Form1.txt_broker.value=oBj.valout[13];
			mod_display6(); 
		}*/
		
		
		function EEmail1(){
			var e=parseInt(document.Form1.Hid_nam5.value); 
			bbbb="TXT_MAIL"+(e);
			var N6=document.Form1.elements[bbbb];
			if((document.Form1.TXT_MAIL1.value=="")||(N6.value=="")){
				alert("Please enter the Email Add");
			}
			else{
				m_row="";
				if (e<5) {
					e=e+1;
					
					m_writedata ='<TABLE WidTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0" ">'+
					 
						'<TR > <TD width="1%" > </TD>'+ 						
						'<TD width="16%" >E-mail '+e+'</TD>'+ 
						'<TD><INPUT TYPE="Text" CLASS="TXT_INPUT6"  NAME="TXT_MAIL'+e+'" SIZE=37 MAXLENGTH=30 ></TD>'+
						'<TD></TD>'+
						'<TD></TD></TR>'+
						m_row+
						'</TABLE>';
					Email1.innerHTML=Email1.innerHTML+m_writedata;	
					document.Form1.Hid_nam5.value=e;// change d into e by waruna 2011-04-21
				}
				
				
				else{
					
				}			 
			}
		}
		 function val_email() {
			/*bbbb="TXT_MAIL"+(e);
			N6=document.Form1.elements[bbbb];
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalportfolio_MT?chksql=pf_email_help&pfcode="+document.Form1.TXT_PORCODE.value+"&email_no="+N6.value;
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
			*/
			m_size=0;
			if (m_size >0) {
				alert("Email Add is Exsisting");
				N6.focus();
			}
		}
		
		<!----------------------------mod-display-------------------------------------------->
		function mod_display6() {
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bval_advise?chksql=adv_email&advcode="+document.Form1.txt_code.value;
			//window.open(m_url);
			load_interface(m_url,'XML',false);
			m_size7 = data_vec.length;
		//alert('123');
		//	top.frames[0].document.applets[0].getdata(m_url);
		//	m_size7=top.frames[0].document.applets[0].outvec_value.size();
			
			var j=1;
			var p=1;
			 Email1.innerHTML="";
			if (m_size7 >0) {
			
				document.Form1.TXT_MAIL1.value=data_vec[0];
				
				while(j<m_size7) { 
					j=j+1;
					m_writedata='<TABLE WidTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0" ">'+
						'<TR > <TD width="1%" > </TD>'+ 
						'<TD width="16%" >E-mail '+j+'</TD>'+ 
						'<TD> <INPUT TYPE="Text" NAME="TXT_MAIL'+j+'"	class="txt_input6" ALIGN="LEFT" SIZE=37 VALUE='+data_vec[p]+'></TD>'+
					      '<TD></TD>'+
						'<TD WidTH="25%"></TD></TR>'+
						'</TABLE>';
					p=p+1;
					Email1.innerHTML=Email1.innerHTML+m_writedata;
					document.Form1.Hid_nam5.value=j;
				}					
			}	
		}
		
	function entry_mode(obj){
	 
		if (obj=="mod") {
		document.getElementById('div_lable').innerHTML='Advisor - Edit'; 
		//	e_mode.innerText="Advisor/Mkt.Exec. - Modify";
   			document.Form1.Hid_scr_name.value="ADV_MOD";
	    for (var i=0; i < document.Form1.elements.length; i++ ) {
			document.Form1.elements[i].disabled=false;
			}
				document.Form1.txt_code.disabled=false;

				
		}	
		else if (obj=="del") {
		document.getElementById('div_lable').innerHTML='Advisor - Delete'; 
		//e_mode.innerText="Advisor/Mkt.Exec. - Delete";
   		document.Form1.Hid_scr_name.value="ADV_DEL";
	    for (var i=0; i < document.Form1.elements.length; i++ ) {
					document.Form1.elements[i].disabled=true;
			}
				document.Form1.but_txt_code.disabled=false;
				document.Form1.NEW.disabled=false;
				document.Form1.MOD.disabled=false;
				document.Form1.DEL.disabled=false;
				document.Form1.save_but.disabled=false;
				document.Form1.calcel_but.disabled=false;
				document.Form1.Exit_but.disabled=false;
				document.Form1.report_but.disabled=false;
			
		}
		else if (obj=="new") {
		document.getElementById('div_lable').innerHTML='Advisor - New'; 
		//e_mode.innerText="Advisor/Mkt.Exec. Creation";
   		document.Form1.Hid_scr_name.value="ADV_NEW";
	    for (var i=0; i < document.Form1.elements.length; i++ ) {
					document.Form1.elements[i].disabled=false;
			}
				document.Form1.but_txt_code.disabled=true;
			
		}
		
		else if (obj=="inq") {
	//	document.getElementById('div_lable').innerHTML='Advisor - Inquiry'; 
		//e_mode.innerText="Advisor/Mkt.Exec. - Inquiry";
   		document.Form1.but_txt_code.disabled=false;
			
		}
			else if (obj=="sav") {
				
			if(document.Form1.txt_broker.value==''){
			document.Form1.txt_broker.focus();	
			alert('Please Enter Stock Broker');
			}else if(document.Form1.txt_title.value==''){
			document.Form1.txt_title.focus();	
			alert('Please Enter Name');
			}else if(document.Form1.text_dob_dd.value==''|| document.Form1.text_dob_mm.value=='' || document.Form1.text_dob_yy.value==''){
			document.Form1.text_dob_dd.focus();	
			alert('Please Enter Date of Birth');
			}
			else if(parent.frames[1].document.Form1.txt_nic.value==''){
			document.Form1.txt_nic.focus();	
			alert('Please Enter NIC No.');
			}	
				else{	
			beforesubmit();
				}
			
		}
		else if (obj=="ref") {
			//e_mode.innerText="Generate Letter - CEYLECT";
			//document.Form1.hid_type.value="letter";
			//document.Form1.but_sav.disabled=true;
			//parent.frames[1].location.href='dn_cus_entry_cey_letter.html'
		}
	}
		function cancelling(){
			reset();
		
		
		}
		function reset(){
			
			document.Form1.txt_code.value="";
			document.Form1.txt_title.value="";
			document.Form1.txt_desig.value="";
			document.Form1.txt_nic.value="";
			document.Form1.txt_add1.value="";
			document.Form1.txt_add2.value="";
			document.Form1.txt_add3.value="";
			document.Form1.txt_add4.value="";
			document.Form1.text_dob_dd.value="";
			document.Form1.text_dob_mm.value="";
			document.Form1.text_dob_yy.value="";
			document.Form1.txt_remarks.value="";
			document.Form1.txt_con1.value="";
			document.Form1.txt_broker.value="";
			document.Form1.TXT_MAIL1.value="";

		}
		//----------------------Calander---------------**
		$(document).ready
			(
				
				function() 
				{
					//initDialog();
					initCal('TXT_START_DATE');
                    initCal('TXT_END_DATE');
					//initDialogPOPup();
				}
			);
			
			
			function initCal(m_id) {
                $('#' + m_id).datepicker({
                    dateFormat: 'dd-mm-yy',
                    duration: 'fast',
                    yearRange: '1920:2050',
                    showOn: 'button',
                    buttonImage: '<%=m_jsp_client_url%>/SNET/images/calendar.gif',
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
               if (instance_id == "TXT_START_DATE") {
                   document.Form1.text_dob_dd.value = splitResult[0];
                   document.Form1.text_dob_mm.value = splitResult[1];
                   document.Form1.text_dob_yy.value = splitResult[2];
                   document.Form1.text_dob_yy.focus();
               }
               else if (instance_id == "TXT_END_DATE") {
                   document.Form1.TXT_RDATE_FROM.value = splitResult[0];
                   document.Form1.TXT_RMONTH_FROM.value = splitResult[1];
                   document.Form1.TXT_RYEAR_FROM.value = splitResult[2];
                   document.Form1.TXT_RYEAR_FROM.focus();
               }
              
           }
		//-------------------------------------**
		 function  obtain_report_before(){
				
			document.Form1.save_but.disabled=true;
			document.Form1.txt_code.disabled=false;	
				code_help(0)
			}
	</script>
	<body class="body & txt-body" onload="defa_acts()"  >
		
		<form name="Form1" ID="Form1" method="post" >
			
			<input type="hidden" name="Hid_scr_name" value="ADV_NEW">
			<input type="hidden" name="hid_help_type"	value="">
			<INPUT TYPE="hidden" NAME="Hid_nam5"	VALUE="1" >
			
			<!--------------------------------------------------------------->
			<DIV>
				<TABLE class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
				<TR>
					<td height='7'></td>
					</tr>
				
					<tr height='30' >
					<td  width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
					<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Administration - Broker Master Sub Module</B></td>
						<td width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>
						
			  </TR>
			  <TR>			
			 </TABLE>	
					
			</DIV>
	
		<!--------------------------------------------------------------->
			<table class='table' border='0' cellpadding='0' cellspacing='0' width='100%'> 
			<tr>
			<td height='1'></td>
			</tr>
			<tr>				
		<!---------------------------------------------------------------->	
		
						
		<!-----------added by prabash on 01-09-2011----------------------->				
			<TABLE WIDTH="100%" BGCOLOR="darkblue" >
				<TR >
					
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="NEW" VALUE="Add "   onClick="entry_mode('new') ; cancelling()"  class="mainbut"  >
					</TD>
								
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="MOD" VALUE="Edit "   onClick="entry_mode('mod') ; cancelling() " class="mainbut"  >
					</TD>
								
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="DEL" VALUE="Delete"   onClick="entry_mode('del'); cancelling() "  class="mainbut"  >
					</TD>
								
					<TD WIDTH='6%'></TD>		
					
								
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="save_but" VALUE="Save"   onClick="entry_mode('sav')" class="mainbut"  >
					</TD>
					
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"   onClick="location.href='dn_m_adviser_main.jsp'" class="mainbut"> 
				</TD>
								
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit"   onClick="location.href='low.jsp'" class="mainbut"> 
					</TD>
								
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="report_but" VALUE="Enquiry"    onClick="obtain_report_before(); entry_mode('inq')" class="mainbut">
						
					</TD>
								
				<!--	<TD  WIDTH="50%" class="hh1" align="right"> -->
					<!--	<B>Advisor</B>-->
					<TD> <B><div id='div_lable' align='right' > </div> </B> 	</TD>
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
			<!------------------------------------------------------>
			
						
			<br>
						
			<table width="100%" border="0" cellpadding="1" cellspacing="0" >
				<tr>
					<td width="1%"></td>
					<td width="16%"> Advisor Code </td> 
					<td width="*%"><input type="text" name="txt_code"	align="left" size="15" class="txt_input6"  ONBLUR="chkadvcode()">
					<input	type="button" name="but_txt_code"	align="left" value="..." class="but_input" onclick="code_help(0)"></td>
				</tr>
							
				<tr>
					<td width="1%"></td>
					<td width="16%">Stock Broker</td>
					<td ><input	type="text" name="txt_broker" class="txt_input6" 	align="left" size="15" >
					<input	type="button" name="but_broker_code"	align="left" value="..." class="but_input" onclick="broker_help(0)"></td>
				</tr>
			
				<tr>
					<td width="1%"></td>
					<td width="16%">Name</td>
					<td width="*%"><input type="text" name="txt_title" class="txt_input6" 	align="left" size="85"></td>
				</tr>
			
				<tr>
					<td width="1%"></td>
					<td width="16%">Designation</td>
					<td><input type="text" name="txt_desig"	align="left" class="txt_input6"  size="40"></td>
				</tr>
			
				<tr>
					<td width="1%"></td>
					<td width="16%">Address Line 1</td>
					<td><input type="text" name="txt_add1"	align="left" class="txt_input6"  size="85"></td>
				</tr>
							
				<tr>
					<td width="1%"></td>
					<td width="16%">Address Line 2</td>
					<td><input type="text" name="txt_add2"	align="left" class="txt_input6"  size="85"></td>
				</tr>
							
				<tr>
					<td width="1%"></td>
					<td width="16%">Address Line 3</td>
					<td><input type="text" name="txt_add3"	align="left" class="txt_input6"  size="85"></td>
				</tr>
							
				<tr>
					<td width="1%"></td>
					<td width="16%">Address Line 4</td>
					<td><input type="text" name="txt_add4"	align="left" class="txt_input6"  size="85"></td>
				</tr>
							
			</table>
			<HR>
						
			<TABLE WidTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0"  >
				<TR>
					<td width="1%"> </td>
					<TD WidTH="16%"> E-mail 1</TD>
					<TD ><INPUT TYPE="Text" NAME="TXT_MAIL1"	ALIGN="LEFT" class="txt_input6"  SIZE=37 MAXLENGTH=30 onBlur="val_email()">
						<INPUT TYPE="button" VALUE="More" NAME="BUT_MMAIL" class="but_input"  ONCLICK="EEmail1()" >
					</TD>
					<TD WidTH="25%">	
				</TR>
			</TABLE>
							
			<DIV id=Email1></DIV>
				<HR>
				<table width="100%" border="0" cellpadding="1" cellspacing="0" >
					<tr>
						<td width="1%"></td>
						<td width="16%">Date of Birth</td>
						<td><input 	type="text" name="text_dob_dd"	align="left" size="3" class="txt_input5 "  maxlength="2" >
							<input 		type="text" name="text_dob_mm"	align="left" size="3"  class="txt_input5 "  maxlength="2" >
							<input 		type="text" name="text_dob_yy"	align="left" size="4"  class="txt_input5 "  maxlength="4"  ONBLUR="chkstartdate(document.Form1.text_dob_dd,document.Form1.text_dob_mm,document.Form1.text_dob_yy)" >
						<input type = "hidden" name = "TXT_START_DATE" id = "TXT_START_DATE" /> </TD>
						 <input type="hidden" name="TXT_S03_C_DATE_OF_INCORPORATION" id="TXT_S03_C_DATE_OF_INCORPORATION" /> 
						</td>
					</tr>
				</table>
							
				<table width="100%" border="0" cellpadding="1" cellspacing="0" >
					<tr>
						<td width="1%"></td>
						<td width="16%">Contact No</td>
						<td width="*%"><input	type="text" name="txt_con1" value="0094"	align="left" class="txt_input6" maxlength="14"  size="15"></td>
					</tr>
				</table>
							
				<div id=cus_con></div>
				
				<table width="100%" border="0" cellpadding="1" cellspacing="0" >
					<tr>
						<td width="1%"></td>
						<td width="16%">NIC No</td>
						<td><input type="text" name="txt_nic"	align="left"  class="txt_input6"  maxlength="10" size="11"></td>
					</tr>
								
					<tr>
						<td width="1%"></td>
						<td width="16%">Remarks</td>
						<td width="*%"><input	type="text" name="txt_remarks"	align="left" class="txt_input6"  size="85"></td>
					</tr>
					
				</table>
			</table>
				<br>
				<script language="JavaScript1.2" SRC="validate_v1.js">var g_dismsg=false;</SCRIPT>
				<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
				</form>			
		</body>
	</html>
	
	
	
