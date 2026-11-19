<HTML>
	<HEAD>
		<TITLE>Margin Traging</TITLE>
		<%@page import="net.sasianet.ADLMARGIN.*" %>
		<%	
			
			//	ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods();
			//	String m_jsp_client_url=m_sn_methods.jsp_client_url;
			
			ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
			String m_jsp_client_url=m_sn_methods.jsp_client_url;
			
			//***************  ADDED BY KANISHKA ON 18/12/2012  *********************//
			
			Object done = (String)session.getValue("logon.isDone");  // marker object
			if (done == null) {
			response.sendRedirect("login.jsp");
			return;
			}
			
			//*************** ADDED BY KANISHKA ON 18/12/2012 [END]  *********************//
			
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
			
			
			function chkstartdate(dayobj,monthobj,yearobj) {
				checkMonthLength(dayobj,monthobj,yearobj);		
			}
			
			/* function val_seccode()
			{
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities?chksql=sec_val&sec_code="+document.Form1.Text_sec_code.value;
				//window.open(m_url);
				top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				if (m_size >0) {
					top.frames[0].document.applets[0].outvec_value.elementAt(0);				
				}			
				else
				{
					sec_help1()
				}
			}*/	
			
			function val_seccode2()
			{
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities?chksql=sec_val&sec_code="+document.Form1.Text_rsec_code.value;
				//window.open(m_url);
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
				
				if (m_size >0) {
					
					data_vec[0];
					
				}			
				else
				{
					sec_help2(0)
				}
			}	
			
			
			/*function	sec_help1()
				{
								m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities?chksql=sec_help_n&sec_code="+document.Form1.Text_sec_code.value;
						//window.open(m_url);
								top.frames[0].document.applets[0].getdata(m_url);
								m_size=top.frames[0].document.applets[0].outvec_value.size();
								vec_pos=0;
								m_row="";
								lineno=1;
									while (vec_pos<m_size) {
										m_acc_no=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
										minst=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
										m_row=m_row+'<TR STYLE="{color:black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white"  ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help_new(C1R'+lineno+',C2R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_acc_no+'</B></TD><TD ID=C2R'+	lineno+'><B>'+minst+'</B></TD></TR>';
										vec_pos=vec_pos+2;
										lineno=lineno+1;
										}
										m_writedata ='<TABLE BGCOLOR="gray" WIDTH="100%" STYLE="{color: darkblue; font: 9pt sans-serif;}">'+
										'<TR BGCOLOR="darkgray"><TD WIDTH="15%"><B>Security Code</B></TD><TD WIDTH="15%"><B>Instrument Type</B></TD>' +
										m_row+
										'</TABLE>'; 
								myDialogObj.htmlstr = m_writedata;
								myDialogObj.returnval = "";
								myDialogObj.returnval1 = "";
								popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
								document.Form1.Text_sec_code.value=myDialogObj.returnval
								document.Form1.Text_inst.value=myDialogObj.returnval1
								document.Form1.txt_bonus_shares.focus();
					}
			*/
			
			/*function	sec_help2()
				{
								m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities?chksql=sec_help_n&sec_code="+document.Form1.Text_rsec_code.value;
						//window.open(m_url);
								top.frames[0].document.applets[0].getdata(m_url);
								m_size=top.frames[0].document.applets[0].outvec_value.size();
								vec_pos=0;
								m_row="";
								lineno=1;
									while (vec_pos<m_size) {
										m_acc_no=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
										minst=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
										m_row=m_row+'<TR STYLE="{color:black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white"  ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help_new(C1R'+lineno+',C2R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_acc_no+'</B></TD><TD ID=C2R'+	lineno+'><B>'+minst+'</B></TD></TR>';
										vec_pos=vec_pos+2;
										lineno=lineno+1;
										}
										m_writedata ='<TABLE BGCOLOR="gray" WIDTH="100%" STYLE="{color: darkblue; font: 9pt sans-serif;}">'+
										'<TR BGCOLOR="darkgray"><TD WIDTH="15%"><B>Security Code</B></TD><TD WIDTH="15%"><B>Instrument Type</B></TD>' +
										m_row+
										'</TABLE>'; 
								myDialogObj.htmlstr = m_writedata;
								myDialogObj.returnval = "";
								myDialogObj.returnval1 = "";
								popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
								document.Form1.Text_rsec_code.value=myDialogObj.returnval
			//					document.Form1.Text_inst.value=myDialogObj.returnval1
								//document.Form1.txt_bonus_shares.focus();
					}
					*/
			
			function	sec_help2(m_strat){
				
				var aForm;    //  aForm =oForm.elements;
				aForm =  document.getElementById('Form1');
				
				var myObject=new Array(); //return values set to this object
				myObject[0]=aForm.Text_rsec_code;
				myObject[1]=aForm.Text_inst;
				
				var myObject_value=new Array(); //passing values set to this object
				myObject_value[0]=aForm.Text_rsec_code.value;
				myObject_value[1]=null;
				
				var myObject_type=new Array(); //passing values data type
				myObject_type[0]="StringL";	
				myObject_type[1]=null;	
				
				var qid='29';
				
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
						
						onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
					});
			}	
			
			
			function myDialogObj() {
				var htmlstr; 
				var returnval;
				var returnval1;
			}
			//----Added by prabash on 05-06-2012---**	
			function val_price(num1)
			{					
				num1.value=format_noobject(num1.value);			
			}
			
			function format_noobject(value) 
			{
				m_format=value.toString();
				m_dot_count=0;
				var m_integer="";
				var m_decimal="";
				m_minus=false;
				for (var i = 0; i < m_format.length; i++) 
				{
					var oneChar = m_format.charAt(i)
					if (oneChar== ".") 
					{
						m_dot_count=m_dot_count+1;
					}
					if (oneChar== "-") 
					{
						m_minus=true;
					}
					
					if (isNaN(oneChar) && oneChar != "," && oneChar != "." && oneChar != "-") 
					{
						alert("You have typed an incorrect charactor as a number");
						return oneChar
							
					}
					if (!isNaN(oneChar) && m_dot_count==0 ) 
					{
						m_integer=m_integer+oneChar;
					}
					if (m_dot_count>0) 
					{
						m_decimal=m_decimal+oneChar;
					}
				}
				if (m_dot_count>1) 
				{
					alert("You have typed more than one decimal separator");
					return false
				}
				m_format=m_integer; 
				
				var m_formatted="";
				var m_new_str="";
				m_end=m_format.length;
				m_stat_pos=m_end-4;
				var m_last_pos=m_end;
				while (m_stat_pos>=0)	
				{
					m_chk_str=m_format.substr(m_stat_pos,1);
					if  (m_chk_str!=null)
					{
						m_add_str=","+m_format.substr(m_stat_pos+1,3);
						m_new_str=m_add_str+m_new_str;
					}
					m_last_pos=m_stat_pos;
					m_stat_pos=m_stat_pos-3;
				}
				if (m_decimal == "") 
				{
					m_decimal=".00";
				}
				else if (m_decimal == ".") 
				{
					m_decimal=".00";
				}
				else if (m_decimal == ".0") 
				{
					m_decimal=".00";
				}
				else if (m_decimal == ". 0") 
				{
					m_decimal=".00";
				}
				else 
				{
					m_decimal=m_decimal.substr(0,3);
				}
				if (m_decimal.length<3) 
				{
					m_decimal=m_decimal+"0";
				}			
				
				m_new_str=m_format.substr(0,m_last_pos+1)+m_new_str+m_decimal;
				if (m_minus) 
				{
					m_new_str="-"+m_new_str;
				}
				value=m_new_str;
				return value;
			}
			
			//------------------------------------------------**	
			function entry_mode(val){
				document.Form1.MOD.disabled=true;
				document.Form1.report_but.disabled=true;
				
				if(val=="new"){
					document.getElementById('div_lable').innerHTML='Rights / Warrants Entry - New'; 
					document.getElementById('div_add_rights_new').style.display='inline';
					document.getElementById('div_del_rights_new').style.display='none';
					document.getElementById('Hid_scr_name').value="rights_new";
					
				}else if(val=="mod"){
					document.getElementById('div_lable').innerHTML='Rights / Warrants Entry - Edit'; 
					document.getElementById('div_add_rights_new').style.display='inline';
					document.getElementById('div_del_rights_new').style.display='none';
					document.getElementById('Hid_scr_name').value="mod";
				}else if(val=="del"){
					document.getElementById('div_lable').innerHTML='Rights / Warrants Entry - Delete'; 
					document.getElementById('div_add_rights_new').style.display='none';
					document.getElementById('div_del_rights_new').style.display='inline';
					document.getElementById('Hid_scr_name').value="rights_del";
				}
				
			}
			function val_seccode()
			{
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities?chksql=sec_val&sec_code="+document.Form1.Text_sec_code.value;
				
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
				
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				if (m_size >0) {
					//top.frames[0].document.applets[0].outvec_value.elementAt(0);	
					data_vec[0];
				}			
				else
				{
					sec_help1(0)
				}
			}
			
			//---Added by Prabash for prevent to enter existing entrys on 17-11-2011-----**
			function chkstartdate2(dayobj,monthobj,yearobj)
			{
				ToDD=dayobj.value;			
				ToMM=monthobj.value;
				ToYYYY=yearobj.value;
				
				ValDate= ToDD+"-"+ToMM+"-"+ToYYYY ;	
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities?chksql=sec_val2&sec_code="+document.Form1.Text_sec_code.value+"&vdate="+ValDate+"";		
				
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
				
				if (m_size >0) {
					alert(" EX Date already exist ");
					
					document.Form1.TXT_DATE_FROM.value=""
						document.Form1.TXT_MONTH_FROM.value=""
						document.Form1.TXT_YEAR_FROM.value=""	
				}			
				
			}	 
			//-------------------------------------------------------------------------**
			
			function	sec_help1(m_strat){
				
				var aForm;    //  aForm =oForm.elements;
				aForm =  document.getElementById('Form1');
				
				var myObject=new Array(); //return values set to this object
				myObject[0]=aForm.Text_sec_code;
				myObject[1]=aForm.Text_inst;
				myObject[2]=aForm.Text_sec_name;
				
				var myObject_value=new Array(); //passing values set to this object
				myObject_value[0]=aForm.Text_sec_code.value;
				myObject_value[1]=null;
				
				var myObject_type=new Array(); //passing values data type
				myObject_type[0]="StringL";	
				myObject_type[1]=null;	
				
				var qid='27';
				
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
						
						onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);chkstartdate2(document.Form1.TXT_DATE_FROM,document.Form1.TXT_MONTH_FROM,document.Form1.TXT_YEAR_FROM);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
					});
			}
			
			function	sec_help3(m_strat){
				var aForm;    //  aForm =oForm.elements;
				aForm =  document.getElementById('Form1');
				
				var myObject=new Array(); //return values set to this object
				myObject[0]=aForm.Text_type2;
				document.Form1.Text_type2.disabled=true;
				myObject[1]=aForm.Text_sec_code2;
				document.Form1.Text_sec_code2.disabled=true;
				myObject[2]=aForm.Text_inst2;
				document.Form1.Text_inst2.disabled=true;	
				myObject[3]=aForm.TXT_DATE_FROM2;
				document.Form1.TXT_DATE_ENT.disabled=true;
				myObject[4]=aForm.TXT_DATE_ENT;
				document.Form1.TXT_DATE_FROM2.disabled=true;
				myObject[5]=aForm.Text_user;
				document.Form1.Text_user.disabled=true;
				myObject[6]=aForm.txt_bonus_shares2;
				document.Form1.txt_bonus_shares2.disabled=true;
				myObject[7]=aForm.txt_bonus_shares3;
				document.Form1.txt_bonus_shares3.disabled=true;
				myObject[8]=aForm.TRE_DATE;
				document.Form1.TRE_DATE.disabled=true;
				myObject[9]=aForm.Text_rsec_code2;
				document.Form1.Text_rsec_code2.disabled=true;
				myObject[10]=aForm.TXT_DATE_ALLOTMENT2;
				document.Form1.TXT_DATE_ALLOTMENT2.disabled=true;
				myObject[11]=aForm.TXT_DATE_LETT_DISPATCH2;
				document.Form1.TXT_DATE_LETT_DISPATCH2.disabled=true;
				myObject[12]=aForm.TXT_DATE_LAST_ACCEPT2;
				document.Form1.TXT_DATE_LAST_ACCEPT2.disabled=true;
				myObject[13]=aForm.TXT_DATE_RIGHT_COMM2;
				document.Form1.TXT_DATE_RIGHT_COMM2.disabled=true;
				
				
				
				var myObject_value=new Array(); //passing values set to this object
				myObject_value[0]=aForm.Text_sec_code2.value;
				myObject_value[1]=null;//aForm.oLastName2.value;
				
				
				
				var myObject_type=new Array(); //passing values data type
				myObject_type[0]="StringL";
				myObject_type[1]=null;
				myObject_type[2]=null;
				myObject_type[3]=null;
				myObject_type[4]=null;
				
				var qid='112';
				var hid='2';
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
						onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);	  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
					});
				
			}
			//pra--**
			function beforesubmit(){
				
				for (var i=0; i < document.Form1.elements.length; i++ ) {
					//	alert('aaaa');
					document.Form1.elements[i].disabled=false;
					
					if(  document.Form1.elements[i].type == 'text'){
						//		alert(document.Form1.elements[i].value );
						document.Form1.elements[i].value = unformat_noobject(document.Form1.elements[i].value); 
					}
					
				}
				//----**
				if(document.Form1.Hid_scr_name.value=="rights_new")
				{
					if(	(document.Form1.Text_sec_code.value=="")||(document.Form1.Text_inst.value== "")||(document.Form1.TXT_YEAR_FROM.value== "")||(document.Form1.TXT_RYEAR_FROM.value== "")||(document.Form1.Text_rsec_code.value== ""))
					{ 
						alert("fill all the required data fields");
					}
					
					else
						
						Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsavcorporate";
					
					location.href='dn_rights_warrants_entry.jsp'
						Form1.submit();
				}
				
				else if(document.Form1.Hid_scr_name.value=="rights_del")
					
					//----------added by Prabash on 07-11-2011 -----
					
				{ 	
					//----------------------------------------------	 
					document.Form1.Text_type2.disabled=false;
					document.Form1.Text_sec_code2.disabled=false;
					document.Form1.TXT_DATE_FROM2.disabled=false;
					document.Form1.TXT_DATE_ENT.disabled=false;
					document.Form1.Text_inst2.disabled=false;
					document.Form1.Text_user.disabled=false;
					document.Form1.txt_bonus_shares2.disabled=false;
					document.Form1.txt_bonus_shares3.disabled=false;
					document.Form1.TRE_DATE.disabled=false;
					document.Form1.Text_rsec_code2.disabled=false;
					//--
					document.Form1.TXT_DATE_ALLOTMENT2.disabled=false;
					document.Form1.TXT_DATE_LETT_DISPATCH2.disabled=false;
					document.Form1.TXT_DATE_LAST_ACCEPT2.disabled=false;
					document.Form1.TXT_DATE_RIGHT_COMM2.disabled=false;
					
					
					if (document.Form1.Text_sec_code2.value=="")
					{
						alert("No selected Security for deletion")
					}
					else{
						
						Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsavcorporate";
						Form1.submit();
						
						
					}
				}
				else
					location.href='dn_rights_warrants_entry.jsp'
			}
			
			function cancel(){
				if (document.Form1.Hid_scr_name.value=="rights_new")
				{
					location.href='dn_rights_warrants_entry.jsp'
				}
				else if (document.Form1.Hid_scr_name.value=="rights_del")
				{
					
					document.Form1.Text_type2.disabled=false;
					document.Form1.Text_type2.value= ""
						document.Form1.Text_sec_code2.disabled=false;
					document.Form1.Text_sec_code2.value= ""
						document.Form1.Text_inst2.disabled=false;
					document.Form1.Text_inst2.value= ""
						document.Form1.TXT_DATE_ENT.disabled=false;
					document.Form1.TXT_DATE_ENT.value= ""
						document.Form1.TXT_DATE_FROM2.disabled=false;
					document.Form1.TXT_DATE_FROM2.value= ""
						document.Form1.Text_user.disabled=false;
					document.Form1.Text_user.value= ""
						document.Form1.txt_bonus_shares2.disabled=false;
					document.Form1.txt_bonus_shares2.value= ""
						document.Form1.txt_bonus_shares3.disabled=false;
					document.Form1.txt_bonus_shares3.value= ""
						document.Form1.TRE_DATE.disabled=false;
					document.Form1.TRE_DATE.value= ""
						document.Form1.Text_rsec_code2.disabled=false;
					document.Form1.Text_rsec_code2.value= ""
						//---
						document.Form1.TXT_DATE_ALLOTMENT2.disabled=false;
					document.Form1.TXT_DATE_ALLOTMENT2.value= ""
						document.Form1.TXT_DATE_LETT_DISPATCH2.disabled=false;
					document.Form1.TXT_DATE_LETT_DISPATCH2.value= ""
						document.Form1.TXT_DATE_LAST_ACCEPT2.disabled=false;
					document.Form1.TXT_DATE_LAST_ACCEPT2.value= ""
						document.Form1.TXT_DATE_RIGHT_COMM2.disabled=false;
					document.Form1.TXT_DATE_RIGHT_COMM2.value= ""
						
				}
				else
					location.href='dn_rights_warrants_entry.jsp'
						
			}	
			//----------------------Calander---------------**
			$(document).ready
			(
				
				function() 
				{
					//initDialog();
					initCal('TXT_START_DATE');
					initCal('TXT_END_DATE');
					initCal('TXT_LASACC_DATE');
					initCal('TXT_LETT_DISPATCH');
					initCal('TXT_ALLOTMENT');
					initCal('TXT_RIGHT_COMM');
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
					document.Form1.TXT_DATE_FROM.value = splitResult[0];
					document.Form1.TXT_MONTH_FROM.value = splitResult[1];
					document.Form1.TXT_YEAR_FROM.value = splitResult[2];
					document.Form1.TXT_YEAR_FROM.focus();
				}
				else if (instance_id == "TXT_END_DATE") {
					document.Form1.TXT_RDATE_FROM.value = splitResult[0];
					document.Form1.TXT_RMONTH_FROM.value = splitResult[1];
					document.Form1.TXT_RYEAR_FROM.value = splitResult[2];
					document.Form1.TXT_RYEAR_FROM.focus();
				}
				else if (instance_id == "TXT_LASACC_DATE") {
					document.Form1.TXT_DATE_LAST_ACCEPT.value = splitResult[0];
					document.Form1.TXT_MONTH_LAST_ACCEPT.value = splitResult[1];
					document.Form1.TXT_YEAR_LAST_ACCEPT.value = splitResult[2];
					document.Form1.TXT_YEAR_LAST_ACCEPT.focus();
				}
				
				else if (instance_id == "TXT_LETT_DISPATCH") {
					document.Form1.TXT_DATE_LETT_DISPATCH.value = splitResult[0];
					document.Form1.TXT_MONTH_LETT_DISPATCH.value = splitResult[1];
					document.Form1.TXT_YEAR_LETT_DISPATCH.value = splitResult[2];
					document.Form1.TXT_YEAR_LETT_DISPATCH.focus();
				}
				
				else if (instance_id == "TXT_ALLOTMENT") {
					document.Form1.TXT_DATE_ALLOTMENT.value = splitResult[0];
					document.Form1.TXT_MONTH_ALLOTMENT.value = splitResult[1];
					document.Form1.TXT_YEAR_ALLOTMENT.value = splitResult[2];
					document.Form1.TXT_YEAR_ALLOTMENT.focus();
				}
				else if (instance_id == "TXT_RIGHT_COMM") {
					document.Form1.TXT_DATE_RIGHT_COMM.value = splitResult[0];
					document.Form1.TXT_MONTH_RIGHT_COMM.value = splitResult[1];
					document.Form1.TXT_YEAR_RIGHT_COMM.value = splitResult[2];
					document.Form1.TXT_YEAR_RIGHT_COMM.focus();
				}
				
				
			} 
			//-------------------------------------**
			//added by Prabash on 07-11-2011-------**	
			function Shares_ck_number()
			{
				var txtname = document.Form1.txt_bonus_shares;
				Sh_val  = document.Form1.txt_bonus_shares.value;
				m_format=Sh_val.toString();
				chacknumber(m_format,txtname);
				
			}
			
			function no_of_Shares_ck()
			{
				var txtname = document.Form1.txt_bonus_shares1;
				Sh_val  = document.Form1.txt_bonus_shares1.value;
				m_format=Sh_val.toString();
				chacknumber(m_format,txtname);
				
			}
			//-------------------------------------**
		</SCRIPT>
	</HEAD>		
	<BODY class="body & txt-body"  ONLOAD="entry_mode('new')" >
		<FORM NAME="Form1" ID="Form1" METHOD="POST" >
			<INPUT TYPE="Hidden" NAME="Hid_scr_name" ID="Hid_scr_name"	VALUE="rights_new">
			<!---------------------------------->				
			<DIV>
				<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
					<tr>
						<td height='7'></td>
					</tr>
					
					<tr height='30' >
						<td  width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
						<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'> <B> Margin Trading - Corporate Actions</B></td>
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
						
						<!-------------------------------------------------------------------->
						
						
						<TABLE WIDTH="100%" BGCOLOR="darkblue" >
						<TR >
						<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="NEW" VALUE="Add"   onClick="entry_mode('new')"  class="mainbut"  >
					</TD>
						<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="MOD" VALUE="Edit" onClick="entry_mode('mod')  " class="mainbut"  >
					</TD>
						
						<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="DEL" VALUE="Delete"   onClick= "entry_mode('del')"  class="mainbut"  >
					</TD>				
						
						<TD WIDTH='6%'></TD>	
						
						
						<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="save_but" VALUE="Save"   onClick="beforesubmit()" class="mainbut"  >
					</TD>
						
						
						
						
						<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"   onClick="cancel()"  class="mainbut" >
					</TD>
						<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit"   onClick="location.href='low.jsp'" class="mainbut"> 
					</TD>
						<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="report_but" VALUE="Enquiry"    onClick="obtain_report_before()" class="mainbut">
						
					</TD>
						
						<!--<TD  WIDTH="50%" class="hh1" align="right">-->
						<!--<B>	Rights / Warrants Entry</B>-->
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
						<!---------------------------------->					
						
						<div id="div_add_rights_new">						
						
						<table width="100%" border="0" cellpadding="1" cellspacing="0" >
						<TR>
						<TD WIDTH="1%"></TD>
						<TD  style = "width: 150px;" >Security Code</TD>
						<TD><INPUT TYPE="Text" NAME="Text_sec_code"	ALIGN="LEFT" class="txt_input6" SIZE="15" onBlur="val_seccode()">
						<INPUT TYPE="BUTTON" NAME="sec_help" ONCLICK="sec_help1(0)" class="mainbut" value="..."></TD>	
						
						<TD WIDTH="1%"></TD>
						<TD style = "width: 150px;">Security Name</TD>
						<TD ><INPUT TYPE="Text" NAME="Text_sec_name"	ALIGN="LEFT" class = "txt_input" SIZE="30" style = "width: 250px;" disabled = "disabled" onBlur="val_seccode()">						
						
						
					</TR>
					</table>							
						<table width="100%" border="0" cellpadding="1" cellspacing="0" >	
						
						<TR>
						<TD WIDTH="1%"></TD>
						<TD style = "width: 150px;">Instrument Code</TD>
						<TD><INPUT TYPE="Text" NAME="Text_inst"	ALIGN="LEFT" class="txt_input6" SIZE="15" ></TD>
					</TR>
						
						
						<TR>
						<TD WIDTH="1%"></TD>
						<TD  style = "width: 150px;">Comment</TD>
						
						<TD ><INPUT TYPE="Text" NAME="Text_comment" style = "width: 300px;"	ALIGN="LEFT" SIZE="5" ></TD>					
						<TR > 
					</table>								
						
						<table width="100%" border="0" cellpadding="1" cellspacing="0" >							
						<TR>
						<TD WIDTH="1%"></TD>
						<TD style = "width: 150px;">Rights Ratio </TD>
						<TD ><INPUT TYPE="Text" NAME="txt_bonus_shares" class="txt_input5" value="0"  SIZE=5 onBlur= "Shares_ck_number()" > 
						No of Bonus Shares for
						
						
						<INPUT TYPE="Text" NAME="txt_bonus_shares1" class="txt_input5" value="0"  SIZE=5 onBlur= "no_of_Shares_ck()" > 
						No of Shares Held Now</TD>
						
						<TD WIDTH="25%"></TD>								
						
					</TR>	
						
						<!--<table width="100%" border="0" cellpadding="1" cellspacing="0" >	
						<TR>
						
						<TD WIDTH="5%"></TD>
						<TD  WIDTH="20%" >No of Bonus Shares for</TD>
						<TD ><INPUT TYPE="Text" NAME="txt_bonus_shares" class="txt_input5" value="0"  SIZE=5 onBlur= "Shares_ck_number()" > </TD>
						
					</TR>						
						
						
						<TR>
						
						<TD WIDTH="5%"></TD>
						<TD  WIDTH="20%" >No of Shares Held Now</TD>
						<TD ><INPUT TYPE="Text" NAME="txt_bonus_shares1" class="txt_input5" value="0"  SIZE=5 onBlur= "no_of_Shares_ck()" > </TD>
						
					</TR>	-->
					</table>
						
						
						
						<table width="100%" border="0" cellpadding="1" cellspacing="0" >	
						
						<TR>
						<TD WIDTH="1%"></TD>
						<TD style = "width: 150px;">Price Per Share</TD>
						<TD><INPUT TYPE="Text" NAME="Text_price"	ALIGN="LEFT" class="txt_input6" SIZE="15" onBlur="val_price(document.Form1.Text_price)" ></TD>
					</TR>									
						
						
						<TR>
						<TD WIDTH="1%"></TD>
						<TD  style = "width: 150px;">Relavant Security Code</TD>
						<TD ><INPUT TYPE="Text" NAME="Text_rsec_code"	ALIGN="LEFT" class="txt_input6" SIZE="15" onBlur="val_seccode2()">
						<INPUT TYPE="BUTTON" NAME="sec_help" ONCLICK="sec_help2(0)" class="mainbut"  value="..."></TD>	
					</TR>									
						
						
						
						<TR>	
						<TD WIDTH="1%"></TD>
						<TD style = "width: 150px;">EGM/Prov. Allotment date</TD> 
						<TD><INPUT TYPE="Text" NAME="TXT_DATE_ALLOTMENT"  class="txt_input5" SIZE="3" MAXLENGTH="2">
						<INPUT	   TYPE="Text" NAME="TXT_MONTH_ALLOTMENT" class="txt_input5" SIZE="3" MAXLENGTH="2">
						<INPUT	   TYPE="Text" NAME="TXT_YEAR_ALLOTMENT"  class="txt_input5"  SIZE="5" MAXLENGTH="4" ONBLUR="chkstartdate(document.Form1.TXT_DATE_ALLOTMENT,document.Form1.TXT_MONTH_ALLOTMENT,document.Form1.TXT_YEAR_ALLOTMENT)"> 								
						<input type = "hidden" name = "TXT_ALLOTMENT" id = "TXT_ALLOTMENT" />
						
					</TD> 
					</TR>									
						
						
						
						<TR>	
						<TD WIDTH="1%"></TD>
						<TD style = "width: 150px;">XR From</TD> 
						<TD ><INPUT TYPE="Text" NAME="TXT_DATE_FROM"  class="txt_input5" SIZE="3" MAXLENGTH="2">
						<INPUT		TYPE="Text" NAME="TXT_MONTH_FROM" class="txt_input5" SIZE="3" MAXLENGTH="2">
						<INPUT		TYPE="Text" NAME="TXT_YEAR_FROM"  class="txt_input5" SIZE="5" MAXLENGTH="4" ONBLUR="chkstartdate(document.Form1.TXT_DATE_FROM,document.Form1.TXT_MONTH_FROM,document.Form1.TXT_YEAR_FROM);chkstartdate2(document.Form1.TXT_DATE_FROM,document.Form1.TXT_MONTH_FROM,document.Form1.TXT_YEAR_FROM);"> 								
						<input type = "hidden" name = "TXT_START_DATE" id = "TXT_START_DATE" />
					</TD> 
					</TR>
						
						
						<TR>	
						<TD WIDTH="1%"></TD>
						<TD style = "width: 150px;">Letter Dispatch Date</TD> 
						<TD><INPUT TYPE="Text" NAME="TXT_DATE_LETT_DISPATCH"  class="txt_input5" SIZE="3" MAXLENGTH="2">
						<INPUT	   TYPE="Text" NAME="TXT_MONTH_LETT_DISPATCH" class="txt_input5" SIZE="3" MAXLENGTH="2">
						<INPUT	   TYPE="Text" NAME="TXT_YEAR_LETT_DISPATCH"  class="txt_input5"  SIZE="5" MAXLENGTH="4" ONBLUR="chkstartdate(document.Form1.TXT_DATE_LETT_DISPATCH,document.Form1.TXT_MONTH_LETT_DISPATCH,document.Form1.TXT_YEAR_LETT_DISPATCH)"> 								
						<input type = "hidden" name = "TXT_LETT_DISPATCH" id = "TXT_LETT_DISPATCH" />
						
					</TD> 
					</TR>									
						
						
						
						
						<TR>	
						<TD WIDTH="1%"></TD>
						<TD style = "width: 150px;">Renunciation Date</TD> 
						<TD><INPUT TYPE="Text" NAME="TXT_RDATE_FROM"  class="txt_input5" SIZE="3" MAXLENGTH="2">
						<INPUT	   TYPE="Text" NAME="TXT_RMONTH_FROM" class="txt_input5" SIZE="3" MAXLENGTH="2">
						<INPUT	   TYPE="Text" NAME="TXT_RYEAR_FROM"  class="txt_input5"  SIZE="5" MAXLENGTH="4" ONBLUR="chkstartdate(document.Form1.TXT_RDATE_FROM,document.Form1.TXT_RMONTH_FROM,document.Form1.TXT_RYEAR_FROM)"> 								
						<input type = "hidden" name = "TXT_END_DATE" id = "TXT_END_DATE" />
						
					</TD> 
					</TR>
						
						
						<TR>	
						<TD WIDTH="1%"></TD>
						<TD style = "width: 150px;">Last Date of Acceptance</TD> 
						<TD><INPUT TYPE="Text" NAME="TXT_DATE_LAST_ACCEPT"  class="txt_input5" SIZE="3" MAXLENGTH="2">
						<INPUT	   TYPE="Text" NAME="TXT_MONTH_LAST_ACCEPT" class="txt_input5" SIZE="3" MAXLENGTH="2">
						<INPUT	   TYPE="Text" NAME="TXT_YEAR_LAST_ACCEPT"  class="txt_input5"  SIZE="5" MAXLENGTH="4" ONBLUR="chkstartdate(document.Form1.TXT_DATE_LAST_ACCEPT,document.Form1.TXT_MONTH_LAST_ACCEPT,document.Form1.TXT_YEAR_LAST_ACCEPT)"> 								
						<input type = "hidden" name = "TXT_LASACC_DATE" id = "TXT_LASACC_DATE" />
						
					</TD> 
					</TR>
						
						<TR>	
						<TD WIDTH="1%"></TD>
						<TD style = "width: 150px;">Trading of Rights Commences On</TD> 
						<TD><INPUT TYPE="Text" NAME="TXT_DATE_RIGHT_COMM"  class="txt_input5" SIZE="3" MAXLENGTH="2">
						<INPUT	   TYPE="Text" NAME="TXT_MONTH_RIGHT_COMM" class="txt_input5" SIZE="3" MAXLENGTH="2">
						<INPUT	   TYPE="Text" NAME="TXT_YEAR_RIGHT_COMM"  class="txt_input5"  SIZE="5" MAXLENGTH="4" ONBLUR="chkstartdate(document.Form1.TXT_DATE_RIGHT_COMM,document.Form1.TXT_MONTH_RIGHT_COMM,document.Form1.TXT_YEAR_RIGHT_COMM)"> 								
						<input type = "hidden" name = "TXT_RIGHT_COMM" id = "TXT_RIGHT_COMM" />
						
					</TD> 
					</TR>								
						
						
						
						
						
						<TR>
						<TD WIDTH="1%"></TD>
						<TD  style = "width: 150px;">Type</TD>
						<TD ><SELECT NAME="Text_type" class="txt_input6"  >
						<OPTION VALUE="RIGHTS" SELECTED>Rights</option> 
						<OPTION VALUE="WARRANT" >Warrant</option>
					</SELECT></TD>
						
					</TR>
					</TABLE>
					</TABLE>
						
					</div>
						
						
						<div id="div_del_rights_new">
						
						<table width="100%" border="0" cellpadding="1" cellspacing="0" >					
						<TR>
						<TD WIDTH="1%"></TD>
						<TD  style = "width: 150px;" >Security Code</TD>
						<TD  ><INPUT TYPE="Text" NAME="Text_sec_code2" class="txt_input6"	ALIGN="LEFT" SIZE="15" >
						<INPUT TYPE="BUTTON" NAME="sec_help" ONCLICK="sec_help3(0)" class="mainbut"  value="..."></TD>
					</TR>
						
						
						<TR>
						<TD WIDTH="1%"></TD>
						<TD  style = "width: 150px;" >Instrument Code</TD>
						<TD  ><INPUT TYPE="Text" NAME="Text_inst2" class="txt_input6"	ALIGN="LEFT" SIZE="15" ></TD>
					</TR>
					</table>							
						<table width="100%" border="0" cellpadding="1" cellspacing="0" >	
						<TR>
						<TD WIDTH="1%"></TD>
						<TD style = "width: 150px;">Rights Ratio </TD>
						<TD> <INPUT TYPE="Text" NAME="txt_bonus_shares2" class="txt_input5" value="0"  SIZE=5 onBlur= "Shares_ck_number()" > 
						No of Bonus Shares for
						<INPUT TYPE="Text" NAME="txt_bonus_shares3" class="txt_input5" value="0"  SIZE=5 onBlur= "no_of_Shares_ck()" > 								
						No of Shares Held No</TD>
						<TD WIDTH="25%"></TD>	
					</TR>	
					</table>
						
						<table width="100%" border="0" cellpadding="1" cellspacing="0" >							
						
						<TR></TR>
						<TR></TR>
						
						<TR>	
						<TD WIDTH="1%"></TD>
						<TD style = "width: 150px;" >XR Date</TD>
						<TD ><INPUT TYPE="Text" class="txt_input6" NAME="TXT_DATE_FROM2" SIZE=15 >
					</TD>
					</TR>
						
						<TR>	
						<TD WIDTH="1%"></TD>
						<TD style = "width: 150px;" >	Renunciation Date</TD>
						<TD ><INPUT TYPE="Text" class="txt_input6" NAME="TRE_DATE" SIZE=15 >
					</TD>								
					</TR>							
						
						<TR>
						<TD WIDTH="1%"></TD>
						<TD  style = "width: 150px;">Relevant Security Code</TD>
						<TD ><INPUT TYPE="Text" NAME="Text_rsec_code2"	ALIGN="LEFT" class="txt_input6" SIZE="15" onBlur="val_seccode2()">
						
					</TR>							
						
						<TR>
						<TD WIDTH="1%"></TD>
						<TD  style = "width: 150px;" > &nbsp</TD>
					</TR>	
						
						
						<TR>
						<TD WIDTH="1%"></TD>
						<TD  style = "width: 150px;" > Type Of Activity</TD>
						<TD ><INPUT TYPE="Text" NAME="Text_type2" class="txt_input6"	ALIGN="LEFT" SIZE="15" ></TD>
					</TR>						
						
						
						
						<!-------->
						
						<TR>	
						<TD WIDTH="1%"></TD>
						<TD style = "width: 150px;" >EGM/Prov. Allotment date</TD> 
						<TD ><INPUT TYPE="Text" class="txt_input6" NAME="TXT_DATE_ALLOTMENT2" SIZE=15 >
					</TD> 
					</TR>
						
						<TR>	
						<TD WIDTH="1%"></TD>
						<TD style = "width: 150px;" >Letter Dispatch Date</TD> 
						<TD ><INPUT TYPE="Text" class="txt_input6" NAME="TXT_DATE_LETT_DISPATCH2" SIZE=15 >
					</TD> 
					</TR>
						
						<TR>	
						<TD WIDTH="1%"></TD>
						<TD style = "width: 150px;" >Last Date of Acceptance</TD> 
						<TD ><INPUT TYPE="Text" class="txt_input6" NAME="TXT_DATE_LAST_ACCEPT2" SIZE=15 >
					</TD> 
					</TR>
						
						<TR>	
						<TD WIDTH="1%"></TD>
						<TD style = "width: 150px;" >Trading of Rights Commences On</TD> 
						<TD ><INPUT TYPE="Text" class="txt_input6" NAME="TXT_DATE_RIGHT_COMM2" SIZE=15 >
					</TD> 
					</TR>
						
						<!-------->								
						
						
						
						
						<TR>	
						<TD WIDTH="1%"></TD>
						<TD style = "width: 150px;" >Entered Date</TD> 
						<TD ><INPUT TYPE="Text" class="txt_input6" NAME="TXT_DATE_ENT" SIZE=15 >
					</TD> 
					</TR>
						
						<TR>
						<TD WIDTH="1%"></TD>
						<TD  style = "width: 150px;" >User Name Code</TD>
						<TD  ><INPUT TYPE="Text" NAME="Text_user" class="txt_input6"	ALIGN="LEFT" SIZE="15">
						
						
					</TR>
					</TABLE> 									
					</div>	
						
						
						
					</TABLE>
					</TABLE>							
					</FORM>
					</body>	
						<DIV>
						<SCRIPT language1.2="JavaScript" src="validate.js"></SCRIPT>
						<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
					</DIV>
						
					</html>	
						
						
						
