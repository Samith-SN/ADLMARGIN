<HTML>
	<HEAD>
		<TITLE>Margin Trading </TITLE>
		<LINK rel="stylesheet" type="text/css" href="" />
		
		
	</HEAD>
	<%@page import="net.sasianet.ADLMARGIN.*"%>
	<%
		ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
		String m_jsp_client_url = m_sn_methods.jsp_client_url;
		//***************  ADDED BY KANISHKA ON 26/12/2012  *********************//
	
		Object done = (String)session.getValue("logon.isDone");  // marker object
		if (done == null) {
			response.sendRedirect("login.jsp");
			return;
			}
	
	//*************** ADDED BY KANISHKA ON 26/12/2012 [END]  *********************//
		
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url
			+ "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url
			+ "/css/redmond/jquery-ui.css' TYPE=\"text/css\">");
		
		out.println("<script type=\"text/javascript\" src=\""
			+ m_jsp_client_url + "/js/jquery.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\""
			+ m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\""
			+ m_jsp_client_url + "/js/json2.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\""
			+ m_jsp_client_url + "/js/popup.js\"></script>");
	%>
	
	<SCRIPT language="JavaScript1.2" type="text/javascript">
		
		
		
		
		
		var i=1;
		var a=1;
		var b=1;
		var c=1;
		var d=1;
		var e=1;
		var f=1;
		var j=1;
		var k=1;
		var mt_chk="";
		var mt_inv="";
		var mt_bal="";
		dis1="";
		dis2="";
		dis3="";
		dis4="";
		dis5="";
		dis6="";
		var m_issucode = '';
		
		function call_functions(){
			isspre(document.Form1.HID_INST);//alert();
		}
		
		function myDialogObj() {
			var htmlstr;
			var returnval;
		}
		
		
		function formatnum(num){
			num.value=format_noobject(num.value);
		}
		
		
		function chk_postcode(obj) {
			if (obj.value=="") {
				alert('Please enter a Postal Code');
				obj.value="";
				obj.focus();
			}
			else {
				m_postcode=obj.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnsenddata2?Postal_code="+m_postcode+"&chksql=postal";
				load_interface(m_url,'XML',false);
				m_size=data_vec.length;
				if (m_size==0) {
					if (confirm("Invalid Postal Code..Press the OK button if you want a list of Codes or Press the Cancel button to type again")) {
						postal_help(0);
						
					} 
					else{
						document.Form1.TXT_PCODE.focus();
					}   
				}
				else {
				}
			}    	   
		}
		
		
		
		function postal_help(m_start) {
			
			
			
			var aForm;    //  aForm =oForm.elements;
			aForm =  document.getElementById('Form1');
			
			
			var myObject=new Array(); //return values set to this object
			myObject[0]=aForm.TXT_PCODE;
			myObject[1]=null;
			myObject[2]=null;
			myObject[3]=null;
			myObject[4]=null;
			
			var myObject_value=new Array(); //passing values set to this object
			myObject_value[0]=aForm.TXT_PCODE.value;
			myObject_value[1]=aForm.TXT_PCODE.value;//aForm.oLastName2.value;
			myObject_value[2]=null;
			myObject_value[3]=null;
			myObject_value[4]=null;
			
			
			var myObject_type=new Array(); //passing values data type
			myObject_type[0]="StringL";
			myObject_type[1]="StringL";
			myObject_type[2]=null;
			myObject_type[3]=null;
			myObject_type[4]=null;
			
			var qid='20';
			
			
			
			title_name='Postal Code';
			var url = 'popup.jsp';
			var close_fun='postal_code_help_close';			
			var json_text = JSON.stringify(myObject_value, null,0);
			var json_obj_type_text=JSON.stringify(myObject_type, null,0);
			var fn_name=arguments.callee.name;
			if(fn_name==undefined){
		re = /^function\s+([^(]+)/;
        fn_name=re.exec(arguments.callee.toString())[1];
		}
			
			$.showModalDialog({
					url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_start+'&fn_name='+fn_name+'&close_fun='+close_fun,
					dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
					height:400,// 500,
					width: 500,//900,
					title: 'SasiNet Frame Work',
					scrollable: true,
					onClose: function(){  var returnedValue = this.returnValue;  set_return_value(myObject,returnedValue); 
						if(returnedValue == null){postal_code_help_close();}  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
			
		}	
		
		
		function postal_code_help_close(){
			document.Form1.TXT_PCODE.value = '';
		}
		
		
		function view_all_issuers(m_start) {
			
			
			
			var aForm;    //  aForm =oForm.elements;
			aForm =  document.getElementById('Form1');
			
			
			var myObject=new Array(); //return values set to this object
			myObject[0]=null;
			myObject[1]=null;
			myObject[2]=null;
			myObject[3]=null;
			myObject[4]=null;
			
			var myObject_value=new Array(); //passing values set to this object
			myObject_value[0]=null;
			myObject_value[1]=null;//aForm.oLastName2.value;
			myObject_value[2]=null;
			myObject_value[3]=null;
			myObject_value[4]=null;
			
			
			var myObject_type=new Array(); //passing values data type
			myObject_type[0]=null;
			myObject_type[1]=null;
			myObject_type[2]=null;
			myObject_type[3]=null;
			myObject_type[4]=null;
			
			var qid='21';
			
			
			
			title_name='Issuers';
			var url = 'popup.jsp';
			var close_fun='view_all_issuers_close';			
			var json_text = JSON.stringify(myObject_value, null,0);
			var json_obj_type_text=JSON.stringify(myObject_type, null,0);
			var fn_name=arguments.callee.name;
			if(fn_name==undefined){
		re = /^function\s+([^(]+)/;
        fn_name=re.exec(arguments.callee.toString())[1];
		}
			$.showModalDialog({
					url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_start+'&fn_name='+fn_name+'&close_fun='+close_fun,
					dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
					height:400,// 500,
					width: 600,//900,
					title: 'SasiNet Frame Work',
					scrollable: true,
					onClose: function(){  var returnedValue = this.returnValue;  set_return_value(myObject,returnedValue); 
						if(returnedValue == null){view_all_issuers_close();}  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
			
		}	
		
		function view_all_issuers_close(){
			
		}
		
		
		
		function isspre(Hid_rows){
			j=1;
			var chk_tot = null;
			while (j<=(Hid_rows.value)){
				var mt_chkvalue="ISSUER"+j;
				var chk_tot=document.Form1.elements[mt_chkvalue];
				var mt_invvalue="GUARAN"+j;
				var inv_tot=document.Form1.elements[mt_invvalue];
				var mt_balvalue="ENDO"+j;
				var bal_tot=document.Form1.elements[mt_balvalue];
				
				var mt_chk="CI"+j;
				var chk1=document.Form1.elements[mt_chk];
				var mt_inv="CG"+j;
				var chk2=document.Form1.elements[mt_inv];
				var mt_bal="CE"+j;
				var chk3=document.Form1.elements[mt_bal];
				j=j+1;
				if (chk_tot.checked==true) {
					chk_tot.value='Y';
					chk1.value='on';
				}
				else{
					chk_tot.value='N';
				}
				if (inv_tot.checked==true) {
					inv_tot.value='Y';
					chk2.value='on';
				}
				else{
					inv_tot.value='N';
				}	
				if (bal_tot.checked==true) {
					bal_tot.value='Y';
					chk3.value='on';
				}
				else{
					bal_tot.value='N';
				}	
			}
		}	
		
		function loaddisable(line_no){
			var lineno = line_no;
			while(lineno>0){
				var d1="ISSUER"+lineno;
				var d2="IPREMI"+lineno;
				var d3="GUARAN"+lineno;
				var d4="GPREMI"+lineno;
				var d5="ENDO"+lineno;
				var d6="EPREMI"+lineno;
				var dis1=document.Form1.elements[d1];
				var dis2=document.Form1.elements[d2];
				var dis3=document.Form1.elements[d3];
				var dis4=document.Form1.elements[d4];
				var dis5=document.Form1.elements[d5];
				var dis6=document.Form1.elements[d6];
				dis1.disabled = true;
				dis2.disabled = true;
				dis3.disabled = true;
				dis4.disabled = true;
				dis5.disabled = true;
				dis6.disabled = true;
				lineno=lineno-1;
			}	
		}
		
		function issue(lineno){
			if(document.Form1.Hid_scr_name.value == 'sysmain_issuers'){
				if(document.Form1.ICHB_IOS.checked==true){
					document.Form1.ICHB_IOS.value='Y';
					while(lineno>0){
						var d1="ISSUER"+lineno;
						var d2="IPREMI"+lineno;
						var d3="GUARAN"+lineno;
						var d4="GPREMI"+lineno;
						var d5="ENDO"+lineno;
						var d6="EPREMI"+lineno;
						var dis1=document.Form1.elements[d1];
						var dis2=document.Form1.elements[d2];
						var dis3=document.Form1.elements[d3];
						var dis4=document.Form1.elements[d4];
						var dis5=document.Form1.elements[d5];
						var dis6=document.Form1.elements[d6];
						dis1.disabled = false;
						dis2.disabled = false;
						lineno=lineno-1;
					}
				} 
				else{
					document.Form1.ICHB_IOS.value='N';
					while(lineno>0){
						var d1="ISSUER"+lineno;
						var d2="IPREMI"+lineno;
						var d3="GUARAN"+lineno;
						var d4="GPREMI"+lineno;
						var d5="ENDO"+lineno;
						var d6="EPREMI"+lineno;
						var dis1=document.Form1.elements[d1];
						var dis2=document.Form1.elements[d2];
						var dis3=document.Form1.elements[d3];
						var dis4=document.Form1.elements[d4];
						var dis5=document.Form1.elements[d5];
						var dis6=document.Form1.elements[d6];
						dis1.checked=false;
						dis2.value="";
						dis1.disabled = true;
						dis2.disabled = true;
						lineno=lineno-1;
					}
					
				}
			}else{
				if(document.Form1.ICHB_IOS.checked==true){
					document.Form1.ICHB_IOS.value='Y';
				} 
				else{
					document.Form1.ICHB_IOS.value='N';
				}
				
			}
		}
		
		
		function guaran(lineno){
			if(document.Form1.Hid_scr_name.value == 'sysmain_issuers'){
				if(document.Form1.GCHB_GOS.checked==true){
					document.Form1.GCHB_GOS.value='Y';
					while(lineno>0){
						var d1="ISSUER"+lineno;
						var d2="IPREMI"+lineno;
						var d3="GUARAN"+lineno;
						var d4="GPREMI"+lineno;
						var d5="ENDO"+lineno;
						var d6="EPREMI"+lineno;
						var dis1=document.Form1.elements[d1];
						var dis2=document.Form1.elements[d2];
						var dis3=document.Form1.elements[d3];
						var dis4=document.Form1.elements[d4];
						var dis5=document.Form1.elements[d5];
						var dis6=document.Form1.elements[d6];
						dis3.disabled = false;
						dis4.disabled = false;
						lineno=lineno-1;
					}	
				}
				else{
					document.Form1.GCHB_GOS.value='N';
					while(lineno>0){
						var d1="ISSUER"+lineno;
						var d2="IPREMI"+lineno;
						var d3="GUARAN"+lineno;
						var d4="GPREMI"+lineno;
						var d5="ENDO"+lineno;
						var d6="EPREMI"+lineno;
						var dis1=document.Form1.elements[d1];
						var dis2=document.Form1.elements[d2];
						var dis3=document.Form1.elements[d3];
						var dis4=document.Form1.elements[d4];
						var dis5=document.Form1.elements[d5];
						var dis6=document.Form1.elements[d6];
						dis3.checked=false;
						dis4.value="";
						dis3.disabled = true;
						dis4.disabled = true;
						lineno=lineno-1;
					}	
					
				}}else{
					if(document.Form1.GCHB_GOS.checked==true){
						document.Form1.GCHB_GOS.value='Y';
					}
					else{
						document.Form1.GCHB_GOS.value='N';
					}
				}
		}
		
		function check_premium(obj){
			if(obj.value >= 1000){
				alert('Value is too large');
				obj.value = '';
				obj.select();
			}
		}
		
		function endor(lineno){
			if(document.Form1.Hid_scr_name.value == 'sysmain_issuers'){
				if(document.Form1.SCHB_EOS.checked==true){
					document.Form1.SCHB_EOS.value='Y';
					while(lineno>0){
						var d1="ISSUER"+lineno;
						var d2="IPREMI"+lineno;
						var d3="GUARAN"+lineno;
						var d4="GPREMI"+lineno;
						var d5="ENDO"+lineno;
						var d6="EPREMI"+lineno;
						var dis1=document.Form1.elements[d1];
						var dis2=document.Form1.elements[d2];
						var dis3=document.Form1.elements[d3];
						var dis4=document.Form1.elements[d4];
						var dis5=document.Form1.elements[d5];
						var dis6=document.Form1.elements[d6];
						dis5.disabled = false;
						dis6.disabled = false;
						lineno=lineno-1;
					}	
				}
				else{
					document.Form1.SCHB_EOS.value='N';
					while(lineno>0){
						var d1="ISSUER"+lineno;
						var d2="IPREMI"+lineno;
						var d3="GUARAN"+lineno;
						var d4="GPREMI"+lineno;
						var d5="ENDO"+lineno;
						var d6="EPREMI"+lineno;
						var dis1=document.Form1.elements[d1];
						var dis2=document.Form1.elements[d2];
						var dis3=document.Form1.elements[d3];
						var dis4=document.Form1.elements[d4];
						var dis5=document.Form1.elements[d5];
						var dis6=document.Form1.elements[d6];
						dis5.checked=false;
						dis6.value="";
						dis5.disabled = true;
						dis6.disabled = true;
						lineno=lineno-1;
					}	
				}
			}else{
				if(document.Form1.SCHB_EOS.checked==true){
					document.Form1.SCHB_EOS.value='Y';
				}
				else{
					document.Form1.SCHB_EOS.value='N';
				}
			}
		}
		
		
		
		
		
		
		/*
		function chk_issucode(objx) {
			if (objx.value=="") {
				alert('Please enter Issuer Code');
				objx.value="";
				objx.focus();
			}
			else {
				m_issucode=objx.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnsenddata2?issuer_code="+m_issucode+"&chksql=chkissu";
				top.frames[0].document.applets[0].getdata(m_url);
				var m_size=top.frames[0].document.applets[0].outvec_value.size();
				if (m_size>0) {
					alert('Issuer Code already exists');
					objx.value="";
					objx.focus();
				}	
				else {
					document.Form1.TXT_IGCODE.value =objx.value;
					document.Form1.TXT_IDES.value =objx.value;
				}     
			}
		}
		*/
		function issuer_help_close(){
			if(document.Form1.Hid_scr_name.value == 'MODIISS'){
				select_screen('MOD');
			}
			else if(document.Form1.Hid_scr_name.value == 'sysmain_deactissuers'){
				select_screen('DEA');
			}
			else if(document.Form1.Hid_scr_name.value == 'sysmain_reactissuers'){
				select_screen('REA');
			}
		}
		
		
		function issuer_help(m_start) {
			
			
			var aForm;    //  aForm =oForm.elements;
			aForm =  document.getElementById('Form1');
			
			
			var myObject=new Array(); //return values set to this object
			myObject[0]=aForm.TXT_IOCDE;
			myObject[1]=aForm.TXT_NAME;;
			myObject[2]=null;
			myObject[3]=null;
			myObject[4]=null;
			
			var myObject_value=new Array(); //passing values set to this object
			myObject_value[0]=aForm.TXT_IOCDE.value;
			myObject_value[1]=aForm.TXT_IOCDE.value;//aForm.oLastName2.value;
			myObject_value[2]="Y";
			myObject_value[3]=null;
			myObject_value[4]=null;
			
			
			var myObject_type=new Array(); //passing values data type
			myObject_type[0]="StringL";
			myObject_type[1]="StringL";
			myObject_type[2]="String";
			myObject_type[3]=null;
			myObject_type[4]=null;
			
			var qid='16';
			
			if(document.Form1.Hid_scr_name.value == 'sysmain_reactissuers'){
				myObject_value[2]="N";
			}
			
			title_name='Issuers';
			var url = 'popup.jsp';
			var close_fun='issuer_help_close';			
			var json_text = JSON.stringify(myObject_value, null,0);
			var json_obj_type_text=JSON.stringify(myObject_type, null,0);
			var fn_name=arguments.callee.name;
			if(fn_name==undefined){
		re = /^function\s+([^(]+)/;
        fn_name=re.exec(arguments.callee.toString())[1];
		}
			$.showModalDialog({
					url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_start+'&fn_name='+fn_name+'&close_fun='+close_fun,
					dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
					height:400,// 500,
					width: 500,//900,
					title: 'SasiNet Frame Work',
					scrollable: true,
					onClose: function(){  var returnedValue = this.returnValue;  set_return_value(myObject,returnedValue); 
						if(returnedValue != null){
							chk_issucode(document.Form1.TXT_IOCDE);
						} 
						if(returnedValue == null){
							issuer_help_close();
						}  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
		}	
		
		
		function chk_holecom(objx) {
			if (objx.value=="") {
				alert('Please enter Issuer Code');
				objx.value="";
				objx.focus();
			}
			else {
				m_issucode=objx.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnsenddata2?issuer_code="+m_issucode+"&chksql=chkissu";
				load_interface(m_url,'XML',false);
				m_size=data_vec.length;
				if (m_size==0) {
					if (confirm("Invalid Holding Company..Press the OK button if you want a list of Holding Company or Press the Cancel button to type again")) {
						holecom_help(0);
						document.Form1.SEL_HCOM.focus();
					}
					else{
						document.Form1.SEL_HCOM.focus();
					}
				}	  
			}
		}
		
		
		function holecom_help(m_start) {
			
			var aForm;    //  aForm =oForm.elements;
			aForm =  document.getElementById('Form1');
			
			
			var myObject=new Array(); //return values set to this object
			myObject[0]=aForm.SEL_HCOM;
			myObject[1]=null;
			myObject[2]=null;
			myObject[3]=null;
			myObject[4]=null;
			
			var myObject_value=new Array(); //passing values set to this object
			myObject_value[0]=aForm.SEL_HCOM.value;
			myObject_value[1]=aForm.SEL_HCOM.value;//aForm.oLastName2.value;
			myObject_value[2]="Y";
			myObject_value[3]=null;
			myObject_value[4]=null;
			
			
			var myObject_type=new Array(); //passing values data type
			myObject_type[0]="StringL";
			myObject_type[1]="StringL";
			myObject_type[2]="String";
			myObject_type[3]=null;
			myObject_type[4]=null;
			
			var qid='16';
			
			
			title_name='Holding Company';
			var url = 'popup.jsp';
			var close_fun='holecom_help_help_close';			
			var json_text = JSON.stringify(myObject_value, null,0);
			var json_obj_type_text=JSON.stringify(myObject_type, null,0);
			var fn_name=arguments.callee.name;
			if(fn_name==undefined){
		re = /^function\s+([^(]+)/;
        fn_name=re.exec(arguments.callee.toString())[1];
		}
			$.showModalDialog({
					url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_start+'&fn_name='+fn_name+'&close_fun='+close_fun,
					dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
					height:400,// 500,
					width: 500,//900,
					title: 'SasiNet Frame Work',
					scrollable: true,
					onClose: function(){  var returnedValue = this.returnValue;  set_return_value(myObject,returnedValue); 
						if(returnedValue == null){holecom_help_help_close();}  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
		}	
		
		
		
		function holecom_help_help_close(){
			document.Form1.SEL_HCOM.value  = '';
		}
		
		
		
		function addigcode(objx){
			if (objx.value=="") {
				alert('Please enter Issuer Group Code');
				objx.value="";
				objx.focus();
			}
			else {
				m_issucode=objx.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnsenddata2?issuer_code="+m_issucode+"&chksql=chkissugru";
				load_interface(m_url,'XML',false);
				m_size=data_vec.length;
				if (m_size>0) {
					document.Form1.TXT_IDES.value = data_vec[1];
				}
			}
		}
		
		function issuer_group_help_close(){
			document.Form1.TXT_IGCODE.value = '';
			document.Form1.TXT_IDES.value   = '';	
			document.Form1.TXT_IGCODE.focus();	
		}
		
		function issuergru_help(m_start) {
			
			
			
			var aForm;    //  aForm =oForm.elements;
			aForm =  document.getElementById('Form1');
			
			
			var myObject=new Array(); //return values set to this object
			myObject[0]=aForm.TXT_IGCODE;
			myObject[1]=aForm.TXT_IDES;;
			myObject[2]=null;
			myObject[3]=null;
			myObject[4]=null;
			
			var myObject_value=new Array(); //passing values set to this object
			myObject_value[0]=aForm.TXT_IGCODE.value;
			myObject_value[1]=aForm.TXT_IGCODE.value;//aForm.oLastName2.value;
			myObject_value[2]=null;
			myObject_value[3]=null;
			myObject_value[4]=null;
			
			
			var myObject_type=new Array(); //passing values data type
			myObject_type[0]="StringL";
			myObject_type[1]="StringL";
			myObject_type[2]=null;
			myObject_type[3]=null;
			myObject_type[4]=null;
			
			var qid='17';
			
			
			title_name='Issuers';
			var url = 'popup.jsp';
			var close_fun='issuer_group_help_close';			
			var json_text = JSON.stringify(myObject_value, null,0);
			var json_obj_type_text=JSON.stringify(myObject_type, null,0);
			var fn_name=arguments.callee.name;
			if(fn_name==undefined){
		re = /^function\s+([^(]+)/;
        fn_name=re.exec(arguments.callee.toString())[1];
		}
			
			$.showModalDialog({
					url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_start+'&fn_name='+fn_name+'&close_fun='+close_fun,
					dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
					height:400,// 500,
					width: 500,//900,
					title: 'SasiNet Frame Work',
					scrollable: true,
					onClose: function(){  var returnedValue = this.returnValue;  set_return_value(myObject,returnedValue); 
						if(returnedValue == null){issuer_group_help_close();}  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
			
		}	
		
		var ajax_status = '';
		
		function add_data1(){
			
			//if (document.Form1.Hid_scr_name.value == 'sysmain_issuers' || document.Form1.Hid_scr_name.value == 'MODIISS'){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnsenddata2?chksql=instypes";
			ajax_status = 'instypes_new';
			load_interface(m_url, 'XML',false);
			assign_data(data_vec);
			//}
			
		}
		
		function mbfsl_list() {
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnsenddata2?chksql=mbsec_look";
			ajax_status = 'mbsec_look_new';
			load_interface(m_url, 'XML',false);
			assign_data(data_vec);
		}
		
		
		function general_list() {
			
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnsenddata2?chksql=general_look";
			
			ajax_status = 'general_look_new';
			load_interface(m_url, 'XML',false);
			assign_data(data_vec);
			
		}
		
		function assign_data(data){
			if(ajax_status == 'instypes_new') {
				var vec_pos = 0;
				var lineno=1;
				var m_row = "";
				if(data.length > 0){
					
					while (vec_pos < data.length) {
						m_row=m_row+'<TR>';
						m_row=m_row+'<TD WIDTH="26%" align ="center" ><INPUT  TYPE="Text" SIZE="42" CLASS = "txt_input6" NAME="INS_TYPE'+lineno+'" readonly VALUE="'+data[vec_pos]+'"></TD>';
						m_row=m_row+'<TD WIDTH="10%" align ="center"><INPUT TYPE="checkbox"  CLASS = "txt_input1" NAME="ISSUER'+lineno+'"  ><INPUT TYPE="hidden" NAME="CI'+lineno+'"></TD>';
						m_row=m_row+'<TD WIDTH="16%" align ="center"><INPUT  TYPE="Text" onblur="check_premium(document.Form1.elements[\'IPREMI'+lineno+'\'])" SIZE="7" CLASS = "txt_input1" NAME="IPREMI'+lineno+'"  value="0" ></TD>';
						m_row=m_row+'<TD WIDTH="10%" align ="center"><INPUT TYPE="checkbox" CLASS = "txt_input1" NAME="GUARAN'+lineno+'"><INPUT TYPE="hidden" NAME="CG'+lineno+'"></TD>';
						m_row=m_row+'<TD WIDTH="16%" align ="center"><INPUT  TYPE="Text" SIZE="7" onblur="check_premium(document.Form1.elements[\'GPREMI'+lineno+'\'])" CLASS = "txt_input1" NAME="GPREMI'+lineno+'"  value="0"></TD>';
						m_row=m_row+'<TD WIDTH="10%" align ="center"><INPUT TYPE="checkbox" CLASS = "txt_input1" NAME="ENDO'+lineno+'" ><INPUT TYPE="hidden" NAME="CE'+lineno+'"></TD>';
						m_row=m_row+'<TD WIDTH="16%" align ="center"><INPUT  TYPE="Text" onblur="check_premium(document.Form1.elements[\'EPREMI'+lineno+'\'])" SIZE="7" CLASS = "txt_input1" NAME="EPREMI'+lineno+'" value="0"  ></TD></TR>';
						vec_pos=vec_pos+1;
						
						lineno=lineno+1;
						
					}
					document.Form1.HID_INST.value=lineno-1;
					m_writedata ='<TABLE  width="100%" border="0" cellpadding="1" cellspacing="0" >'+
						'<TR><TD WIDTH="26%" align ="center"><B>Instrument Type</B></TD>' +
						'<TD WIDTH="10%" align ="center"><B>Issue</B></TD>'+
						'<TD WIDTH="16%" align ="center"><B>Premium</B></TD>'+
						'<TD WIDTH="10%" align ="center"><B>Guarantee</B></TD>'+
						'<TD WIDTH="16%" align ="center"><B>Premium</B></TD>'+
						'<TD WIDTH="10%" align ="center"><B>Endorse</B></TD>'+
						'<TD WIDTH="16%" align ="center"><B>Premium</B></TD></TR>'+
						m_row+
						'</TABLE>'; 
					document.getElementById('insdata').innerHTML=m_writedata;	
					if(document.Form1.Hid_scr_name.value != 'MODIISS'){
						loaddisable(document.Form1.HID_INST.value);
					}
					
				}
			}
			
			else if(ajax_status == 'mbsec_look_new') {
				
				if(data.length > 0){
					vec_pos=0;
					document.Form1.TXT_INSEC.innerHTML = "";
					while (vec_pos<data.length) {
						document.Form1.TXT_INSEC.options[document.Form1.TXT_INSEC.length]=new Option(data[vec_pos+1],data[vec_pos]);
						vec_pos=vec_pos+2;
					}
					document.Form1.TXT_INSEC.selectedIndex=0;
				}
			}
			
			else if(ajax_status == 'general_look_new') {
				if(data.length > 0){
					
					vec_pos=0;
					document.Form1.SEL_ICBANK.innerHTML = "";
					while (vec_pos<data.length) {
						document.Form1.SEL_ICBANK.options[document.Form1.SEL_ICBANK.length]=new Option(data[vec_pos+1],data[vec_pos]);
						vec_pos=vec_pos+2;
					}
					document.Form1.SEL_ICBANK.selectedIndex=0;
				}
			}
		}
		
		
		function dyoname1(){
			if (a<5) {
				a=a+1;
				m_row="";
				m_writedata ='<TABLE width="100%" border="0" cellpadding="1" cellspacing="0" WidTH="100%" >'+
					'<TR ><TD WidTH="35%">Other Description '+a+'</TD><TD WidTH="65%"><INPUT class ="txt_input6" TYPE="Text" NAME="TXT_ODES'+a+'" SIZE=46 MAXLENGTH=30></TD>'+
					m_row+
					'</TABLE>'; 
				othername1.innerHTML=othername1.innerHTML+m_writedata;	
			}
			else{
				return false;
			}			 
			document.Form1.HID_ODES.value=a;
		}		              	
		
		
		
		
		
		function dyicrd1(){
			icr_count = icr_count +1;
			m_row="";
			m_writedata ='<TABLE width="100%" border="0" cellpadding="1" cellspacing="0" >'+
				'<TR><TD WidTH="35%">Issuer Credit Rating / Description # '+icr_count+'</TD><TD WidTH="65%"><INPUT TYPE="Text" class ="txt_input6" style = "width:300px"  NAME="TXT_ICRDES'+icr_count+'" SIZE="46" MAXLENGTH="60" ></TD>'+
				m_row+
				'</TR></TABLE>'; 
			document.getElementById('icrd1').innerHTML=document.getElementById('icrd1').innerHTML+m_writedata;	
			document.Form1.HID_ICRD.value = icr_count;
			
		}
		
		function dydirector1(){
			f=f+1;
			m_row="";
			m_writedata ='<TABLE width="100%" border="0" cellpadding="1" cellspacing="0" >'+
				'<TD WidTH="35%">Board Director '+f+'</TD><TD WidTH="65%"><INPUT TYPE="Text" class ="txt_input6" style = "width:300px" NAME="TXT_BDIR'+f+'" SIZE=46 MAXLENGTH=60></TD>'+
				m_row+
				'</TABLE>'; 
			document.getElementById('BoardDirector1').innerHTML=document.getElementById('BoardDirector1').innerHTML+m_writedata;	
			document.Form1.HID_DIREC.value=f;
		}		   
		
		
		function beforesubmit() {
		
		if(validate_submit()){
			if(document.Form1.Hid_scr_name.value != 'sysmain_deactissuers' && document.Form1.Hid_scr_name.value != 'sysmain_reactissuers'){
				
				call_functions();
			}
			
			document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"asavissu";
			document.Form1.submit();
			
			}		   
		}
		
		function validate_submit(){
		
			if(document.getElementById('Form1').TXT_IOCDE.value==''){
			    
				alert('Please enter Issuer Code');
				return false;
				
			}else if(document.getElementById('Form1').TXT_NAME.value==''){
			    
				alert('Please enter Issuer Name');
				return false;
				
			}else if(document.getElementById('Form1').TXT_PCODE.value==''){
			    
				alert('Please enter Postal Code');
				return false;
				
			} 
			else{
			 return true;
			}
			
		}
		
		
		
		function select_screen(m_type)  {
			
			if( m_type == 'ADD'){
				document.getElementById('div_lable').innerHTML='Issuers - New'; //added by Prabash on 24-11-2011
				document.Form1.reset();
				document.Form1.Hid_scr_name.value = 'sysmain_issuers';
				document.Form1.BUT_ICODE.disabled = true;
				document.Form1.TXT_NAME.disabled = false;
				document.Form1.TXT_IGCODE.disabled = false;
				document.Form1.BUT_IGCODE.disabled = false;
				document.Form1.TXT_IDES.disabled = false;
				document.Form1.TXT_INSEC.disabled = false;
				document.Form1.SEL_ICBANK.disabled = false;
				document.Form1.SEL_SELIST.disabled = false;
				document.Form1.SEL_NOEIB.disabled = false;
				document.Form1.SEL_HCOM.disabled = false;
				document.Form1.SEL_LAUFI.disabled = false;
				document.Form1.SEL_AUOPTION.disabled = false;
				document.Form1.SEL_AUCAT.disabled = false;
				document.Form1.TXT_IIER.disabled = false;
				document.Form1.TXT_ODES1.disabled = false;
				document.Form1.TXT_AUOPTION.disabled = false;
				document.Form1.TXT_ICRDES1.disabled = false;
				document.Form1.BUT_IGCODE1.disabled = false;
				document.Form1.BUT_IDE.disabled = false;
				document.Form1.TXT_ABAMO.disabled = false;
				document.Form1.TXT_EXPOS.disabled = false;
				document.Form1.SEL_APPW.disabled = false;
				document.Form1.ICHB_IOS.disabled = false;
				document.Form1.GCHB_GOS.disabled = false;
				document.Form1.SCHB_EOS.disabled = false;
				document.Form1.TXT_IDENTI.disabled = false;
				document.Form1.TXT_LOCA.disabled = false;
				document.Form1.TXT_ADD.disabled = false;
				document.Form1.TXT_CITY.disabled = false;
				document.Form1.TXT_COUN.disabled = false;
				document.Form1.TXT_PCODE.disabled = false;
				document.Form1.TXT_BDIR1.disabled = false;
				document.Form1.BUT_IGCODE2.disabled = false;
				document.Form1.BUT_IDE1.disabled = false;
				document.Form1.TXT_TEL1.disabled = false;
				document.Form1.TXT_FAX1.disabled = false;
				document.Form1.TXT_MAIL1.disabled = false;
				document.Form1.TXT_CONPER1.disabled = false;
				document.Form1.BUT_ICODE2.disabled = false;
				document.Form1.TXT_IIER.disabled = false;
				document.Form1.BUT_IGCODE.disabled = false;
				document.Form1.BUT_ICODE2.disabled = false;
				f =1;
				document.Form1.HID_DIREC.value = 1;
				document.getElementById('BoardDirector1').innerHTML = '';
				icr_count = 1;
				document.Form1.HID_ICRD.value = 1;
				document.getElementById('icrd1').innerHTML = '';
				
			}
			
			if( m_type == 'MOD'){
				document.getElementById('div_lable').innerHTML='Issuers - Edit'; //added by Prabash on 24-11-2011
				document.Form1.reset();
				document.Form1.Hid_scr_name.value = 'MODIISS';
				document.Form1.BUT_ICODE.disabled = false;
				document.Form1.TXT_NAME.disabled = false;
				document.Form1.TXT_IGCODE.disabled = false;
				document.Form1.BUT_IGCODE.disabled = false;
				document.Form1.TXT_IDES.disabled = false;
				document.Form1.TXT_INSEC.disabled = false;
				document.Form1.SEL_ICBANK.disabled = false;
				document.Form1.SEL_SELIST.disabled = false;
				document.Form1.SEL_NOEIB.disabled = false;
				document.Form1.SEL_HCOM.disabled = false;
				document.Form1.SEL_LAUFI.disabled = false;
				document.Form1.SEL_AUOPTION.disabled = false;
				document.Form1.SEL_AUCAT.disabled = false;
				document.Form1.TXT_IIER.disabled = false;
				document.Form1.TXT_ODES1.disabled = false;
				document.Form1.TXT_AUOPTION.disabled = false;
				document.Form1.TXT_ICRDES1.disabled = false;
				document.Form1.BUT_IGCODE1.disabled = false;
				document.Form1.BUT_IDE.disabled = false;
				document.Form1.TXT_ABAMO.disabled = false;
				document.Form1.TXT_EXPOS.disabled = false;
				document.Form1.SEL_APPW.disabled = false;
				document.Form1.ICHB_IOS.disabled = false;
				document.Form1.GCHB_GOS.disabled = false;
				document.Form1.SCHB_EOS.disabled = false;
				document.Form1.TXT_IDENTI.disabled = false;
				document.Form1.TXT_LOCA.disabled = false;
				document.Form1.TXT_ADD.disabled = false;
				document.Form1.TXT_CITY.disabled = false;
				document.Form1.TXT_COUN.disabled = false;
				document.Form1.TXT_PCODE.disabled = false;
				document.Form1.TXT_BDIR1.disabled = false;
				document.Form1.BUT_IGCODE2.disabled = false;
				document.Form1.BUT_IDE1.disabled = false;
				document.Form1.TXT_TEL1.disabled = false;
				document.Form1.TXT_FAX1.disabled = false;
				document.Form1.TXT_MAIL1.disabled = false;
				document.Form1.TXT_CONPER1.disabled = false;
				document.Form1.BUT_ICODE2.disabled = false;
				document.Form1.TXT_IIER.disabled = false;
				document.Form1.BUT_IGCODE.disabled = false;
				document.Form1.BUT_ICODE2.disabled = false;
				f =1;
				document.Form1.HID_DIREC.value = 1;
				document.getElementById('BoardDirector1').innerHTML = '';
				icr_count = 1;
				document.Form1.HID_ICRD.value = 1;
				document.getElementById('icrd1').innerHTML = '';
			}
			
			if( m_type == 'DEA'){
				document.getElementById('div_lable').innerHTML='Issuers - Deactivate'; //added by Prabash on 24-11-2011
				document.Form1.reset();
				document.Form1.Hid_scr_name.value = 'sysmain_deactissuers';
				document.Form1.BUT_ICODE.disabled = false;
				document.Form1.TXT_NAME.disabled = true;
				document.Form1.TXT_IGCODE.disabled = true;
				document.Form1.BUT_IGCODE1.disabled = true;
				document.Form1.TXT_IDES.disabled = true;
				document.Form1.TXT_INSEC.disabled = true;
				document.Form1.SEL_ICBANK.disabled = true;
				document.Form1.SEL_SELIST.disabled = true;
				document.Form1.SEL_NOEIB.disabled = true;
				document.Form1.SEL_HCOM.disabled = true;
				document.Form1.SEL_LAUFI.disabled = true;
				document.Form1.SEL_AUOPTION.disabled = true;
				document.Form1.SEL_AUCAT.disabled = true;
				document.Form1.TXT_IIER.disabled = true;
				document.Form1.TXT_ODES1.disabled = true;
				document.Form1.TXT_AUOPTION.disabled = true;
				document.Form1.TXT_ICRDES1.disabled = true;
				document.Form1.BUT_IGCODE2.disabled = true;
				document.Form1.BUT_IDE.disabled = true;
				document.Form1.TXT_ABAMO.disabled = true;
				document.Form1.TXT_EXPOS.disabled = true;
				document.Form1.SEL_APPW.disabled = true;
				document.Form1.ICHB_IOS.disabled = true;
				document.Form1.GCHB_GOS.disabled = true;
				document.Form1.SCHB_EOS.disabled = true;
				document.Form1.TXT_IDENTI.disabled = true;
				document.Form1.TXT_LOCA.disabled = true;
				document.Form1.TXT_ADD.disabled = true;
				document.Form1.TXT_CITY.disabled = true;
				document.Form1.TXT_COUN.disabled = true;
				document.Form1.TXT_PCODE.disabled = true;
				document.Form1.TXT_BDIR1.disabled = true;
				document.Form1.BUT_IGCODE.disabled = true;
				document.Form1.BUT_IDE1.disabled = true;
				document.Form1.TXT_TEL1.disabled = true;
				document.Form1.TXT_FAX1.disabled = true;
				document.Form1.TXT_MAIL1.disabled = true;
				document.Form1.TXT_CONPER1.disabled = true;
				document.Form1.BUT_ICODE2.disabled = true;
				document.Form1.TXT_IIER.disabled = true;
				document.Form1.BUT_IGCODE.disabled = true;
				document.Form1.BUT_ICODE2.disabled = true;
				f =1;
				document.Form1.HID_DIREC.value = 1;
				document.getElementById('BoardDirector1').innerHTML = '';
				icr_count = 1;
				document.Form1.HID_ICRD.value = 1;
				document.getElementById('icrd1').innerHTML = '';
				
			}
			
			if(m_type == 'REA'){
				document.getElementById('div_lable').innerHTML='Issuers - Reactivate'; //added by Prabash on 24-11-2011
				document.Form1.reset();
				document.Form1.Hid_scr_name.value = 'sysmain_reactissuers';
				document.Form1.BUT_ICODE.disabled = false;
				document.Form1.TXT_NAME.disabled = true;
				document.Form1.TXT_IGCODE.disabled = true;
				document.Form1.BUT_IGCODE.disabled = true;
				document.Form1.TXT_IDES.disabled = true;
				document.Form1.TXT_INSEC.disabled = true;
				document.Form1.SEL_ICBANK.disabled = true;
				document.Form1.SEL_SELIST.disabled = true;
				document.Form1.SEL_NOEIB.disabled = true;
				document.Form1.SEL_HCOM.disabled = true;
				document.Form1.SEL_LAUFI.disabled = true;
				document.Form1.SEL_AUOPTION.disabled = true;
				document.Form1.SEL_AUCAT.disabled = true;
				document.Form1.TXT_IIER.disabled = true;
				document.Form1.TXT_ODES1.disabled = true;
				document.Form1.TXT_AUOPTION.disabled = true;
				document.Form1.TXT_ICRDES1.disabled = true;
				document.Form1.BUT_IGCODE1.disabled = true;
				document.Form1.BUT_IDE.disabled = true;
				document.Form1.TXT_ABAMO.disabled = true;
				document.Form1.TXT_EXPOS.disabled = true;
				document.Form1.SEL_APPW.disabled = true;
				document.Form1.ICHB_IOS.disabled = true;
				document.Form1.GCHB_GOS.disabled = true;
				document.Form1.SCHB_EOS.disabled = true;
				document.Form1.TXT_IDENTI.disabled = true;
				document.Form1.TXT_LOCA.disabled = true;
				document.Form1.TXT_ADD.disabled = true;
				document.Form1.TXT_CITY.disabled = true;
				document.Form1.TXT_COUN.disabled = true;
				document.Form1.TXT_PCODE.disabled = true;
				document.Form1.TXT_BDIR1.disabled = true;
				document.Form1.BUT_IGCODE2.disabled = true;
				document.Form1.BUT_IDE1.disabled = true;
				document.Form1.TXT_TEL1.disabled = true;
				document.Form1.TXT_FAX1.disabled = true;
				document.Form1.TXT_MAIL1.disabled = true;
				document.Form1.TXT_CONPER1.disabled = true;
				document.Form1.BUT_ICODE2.disabled = true;
				document.Form1.TXT_IIER.disabled = true;
				document.Form1.BUT_IGCODE.disabled = true;
				document.Form1.BUT_ICODE2.disabled = true;
				f =1;
				document.Form1.HID_DIREC.value = 1;
				document.getElementById('BoardDirector1').innerHTML = '';
				icr_count = 1;
				document.Form1.HID_ICRD.value = 1;
				document.getElementById('icrd1').innerHTML = '';
				
			}
			
			document.getElementById('insdata').innerHTML = "";
			add_data1();
			mbfsl_list();
			general_list();
		} 
		
		
		function add_data3(){
			var x="";
			var y="";
			var z="";
			var m_row = "";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnsenddata2?issure_code="+m_issucode+"&chksql=exisins";
			load_interface(m_url,'XML',false);
			m_size1=data_vec.length;
			vec_pos=0;
			lineno=1;
			while (vec_pos<m_size1) {
				m_row=m_row+'<TR  >';
				m_row=m_row+'<TD align ="center"><INPUT class="txt_input6" TYPE="Text" SIZE=42 NAME=INS_TYPE'+lineno+' disabled VALUE='+data_vec[vec_pos]+'></TD>';
				m_row=m_row+'<TD align ="center"><INPUT class="txt_input1"  TYPE="checkbox" disabled disabled NAME=ISSUER'+lineno+'><INPUT TYPE="hidden" NAME=CI'+lineno+'></TD>';
				m_row=m_row+'<TD align ="center"><INPUT class="txt_input1"  TYPE="Text" SIZE=7 onblur="check_premium(document.Form1.elements[\'IPREMI'+lineno+'\'])" disabled NAME=IPREMI'+lineno+' VALUE='+data_vec[vec_pos+2]+'></TD>';
				m_row=m_row+'<TD align ="center"><INPUT class="txt_input1"  TYPE="checkbox"  disabled NAME=GUARAN'+lineno+'><INPUT TYPE="hidden" NAME=CG'+lineno+'></TD>';
				m_row=m_row+'<TD align ="center"><INPUT class="txt_input1"   TYPE="Text" SIZE=7 onblur="check_premium(document.Form1.elements[\'GPREMI'+lineno+'\'])"  disabled NAME=GPREMI'+lineno+' VALUE='+data_vec[vec_pos+4]+'></TD>';
				m_row=m_row+'<TD align ="center"><INPUT class="txt_input1"  TYPE="checkbox" disabled NAME=ENDO'+lineno+'><INPUT TYPE="hidden" NAME=CE'+lineno+'></TD>';
				m_row=m_row+'<TD align ="center" ><INPUT class="txt_input1"  TYPE="Text" SIZE=7 onblur="check_premium(document.Form1.elements[\'EPREMI'+lineno+'\'])" disabled NAME=EPREMI'+lineno+' VALUE='+data_vec[vec_pos+6]+'></TD></TR>';
				
				vec_pos=vec_pos+7;
				lineno=lineno+1;
			}
			document.Form1.HID_INST.value=lineno-1;
			m_writedata ='<TABLE WIDTH="100%"  border="0" cellpadding="1" cellspacing="0">'+
				'<TR><TD WIDTH="26%" align ="center"><B>Instrument Type</B></TD>' +
				'<TD WIDTH="8%"><B align ="center">Issue</B></TD>'+
				'<TD WIDTH="8%"><B align ="center">Premium</B></TD>'+
				'<TD WIDTH="8%"><B align ="center">Guarantee</B></TD>'+
				'<TD WIDTH="8%"><B align ="center">Premium</B></TD>'+
				'<TD WIDTH="8%"><B align ="center">Endorse</B></TD>'+
				'<TD WIDTH="8%"><B align ="center">Premium</B></TD></TR>'+
				m_row+
				'</TABLE>'; 
			document.getElementById('insdata').innerHTML=m_writedata;	
			vec_pos=0;
			lineno=1;
			while (vec_pos<m_size1) {
				x="ISSUER"+lineno;
				y="GUARAN"+lineno;
				z="ENDO"+lineno;
				obj1=document.Form1.elements[x];
				obj2=document.Form1.elements[y];
				obj3=document.Form1.elements[z];
				if(data_vec[vec_pos+1]=="Y"){
					obj1.checked=true;
				}
				if(data_vec[vec_pos+3]=="Y"){
					obj2.checked=true;
				}
				if(data_vec[vec_pos+5]=="Y"){
					obj3.checked=true;
				}
				vec_pos=vec_pos+7;
				lineno=lineno+1;
			}
		}	
		
		
		function chk_issucode(objx) {
			if (objx.value=="") {
				alert('Please enter Issuer Code');
				objx.value="";
				objx.focus();
			}
			else {
				
				if(document.Form1.Hid_scr_name.value == 'MODIISS'){
					m_issucode=objx.value;
					
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnsenddata2?issure_code="+m_issucode+"&chksql=modissuer";
					load_interface(m_url,'XML',false);
					var m_size=data_vec.length;
					if (m_size>0) {
						if (data_vec[26]=='N') {
							alert('De - Activated Issuer !');
							objx.value="";
							objx.focus();
						}
						else{
							document.Form1.TXT_NAME.value=data_vec[0];
							document.Form1.TXT_INSEC.value=data_vec[1];
							document.Form1.SEL_SELIST.value=data_vec[2];
							document.Form1.SEL_NOEIB.value=data_vec[3];
							if(data_vec[4]!="@@"){
								document.Form1.SEL_LAUFI.value=data_vec[4];
							}
							if(data_vec[6]!="@@"){
								document.Form1.SEL_AUCAT.value=data_vec[6];
							}
							if(data_vec[7]!="@@"){
								document.Form1.TXT_AUOPTION.value=data_vec[7];
							}
							if(data_vec[8]!="@@"){
								document.Form1.TXT_IIER.value=data_vec[8];
							}
							if(data_vec[9]!="@@"){
								document.Form1.TXT_ODES1.value=data_vec[9];
							}
							if(data_vec[10]!="0"){
								document.Form1.TXT_ABAMO.value=data_vec[10];
							}
							if(data_vec[11]!="0"){
								document.Form1.TXT_EXPOS.value=data_vec[11];
							}
							document.Form1.SEL_APPW.value=data_vec[12];
							
							
							if(data_vec[13]=="Y"){
								document.Form1.ICHB_IOS.checked=true;
							}
							if(data_vec[14]=="Y"){
								document.Form1.GCHB_GOS.checked=true;
							}
							if(data_vec[15]=="Y"){
								document.Form1.SCHB_EOS.checked=true;
							}
							if(data_vec[16]!="@@"){
								document.Form1.TXT_IDENTI.value=data_vec[16];
							}
							if(data_vec[17]!="@@"){
								document.Form1.TXT_LOCA.value=data_vec[17];
							}
							if(data_vec[18]!="@@"){
								document.Form1.TXT_ADD.value=data_vec[18];
							}
							if(data_vec[19]!="@@"){
								document.Form1.TXT_CITY.value=data_vec[19];
							}
							if(data_vec[20]!="@@"){
								document.Form1.TXT_COUN.value=data_vec[20];
							}
							document.Form1.TXT_PCODE.value=data_vec[21];
							document.Form1.TXT_TEL1.value=data_vec[22];
							if(data_vec[23]!="@@"){
								document.Form1.TXT_FAX1.value=data_vec[23];
							}
							document.Form1.TXT_MAIL1.value=data_vec[24];
							document.Form1.TXT_CONPER1.value=data_vec[25];
							document.Form1.TXT_IGCODE.value=data_vec[27];
							document.Form1.SEL_ICBANK.value=data_vec[28];
							if(data_vec[29]!="@@"){
								document.Form1.SEL_HCOM.value=data_vec[29];
							}	
							document.Form1.TXT_IDES.value=data_vec[30];
							dyicrd2();		
							dydirector2();
							
							add_data2();
							
							issue();
							guaran();
							endor();
							isspre(document.Form1.HID_INST);
							
						}	
						
					}
					else {
						if (confirm("Invalid Issuer Code..Press the OK button if you want a list of Codes or Press the Cancel button to type again")) {
							issuer_help(0);
						} 
						else{
							objx.value="";
							objx.focus();
							document.Form1.TXT_IOCDE.focus();
						}   
					}
				}
				
				else if(document.Form1.Hid_scr_name.value == 'sysmain_issuers'){
					m_issucode=objx.value;
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnsenddata2?issuer_code="+m_issucode+"&chksql=chkissu";
					load_interface(m_url,'XML',false);
					var m_size=data_vec.length;
					if (m_size>0) {
						alert('Issuer Code already exists');
						objx.value="";
						objx.focus();
					}	
					else {
						document.Form1.TXT_IGCODE.value =objx.value;
						document.Form1.TXT_IDES.value =objx.value;
					}     
				}
				
				else if(document.Form1.Hid_scr_name.value == 'sysmain_deactissuers'){
					m_issucode=objx.value;
					
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnsenddata2?issure_code="+m_issucode+"&chksql=modissuer";
					load_interface(m_url,'XML',false);
					var m_size=data_vec.length;
					if (data_vec[26]=='N') {
						alert('Issuer is already De-Activated !');
						objx.value="";
						objx.focus();
					}
					else{
						if (m_size>0) {
							document.Form1.TXT_NAME.value=data_vec[0];
							document.Form1.TXT_INSEC.value=data_vec[1];
							document.Form1.SEL_SELIST.value=data_vec[2];
							document.Form1.SEL_NOEIB.value=data_vec[3];
							if(data_vec[4]!="@@"){
								document.Form1.SEL_LAUFI.value=data_vec[4];
							}
							if(data_vec[6]!="@@"){
								document.Form1.SEL_AUCAT.value=data_vec[6];
							}
							if(data_vec[7]!="@@"){
								document.Form1.TXT_AUOPTION.value=data_vec[7];
							}
							if(data_vec[8]!="@@"){
								document.Form1.TXT_IIER.value=data_vec[8];
							}
							if(data_vec[9]!="@@"){
								document.Form1.TXT_ODES1.value=data_vec[9];
							}
							if(data_vec[10]!="0"){
								document.Form1.TXT_ABAMO.value=data_vec[10];
							}
							if(data_vec[11]!="0"){
								document.Form1.TXT_EXPOS.value=data_vec[11];
							}
							document.Form1.SEL_APPW.value=data_vec[12];
							
							
							if(data_vec[13]=="Y"){
								document.Form1.ICHB_IOS.checked=true;
							}
							if(data_vec[14]=="Y"){
								document.Form1.GCHB_GOS.checked=true;
							}
							if(data_vec[15]=="Y"){
								document.Form1.SCHB_EOS.checked=true;
							}
							if(data_vec[16]!="@@"){
								document.Form1.TXT_IDENTI.value=data_vec[16];
							}
							if(data_vec[17]!="@@"){
								document.Form1.TXT_LOCA.value=data_vec[17];
							}
							if(data_vec[18]!="@@"){
								document.Form1.TXT_ADD.value=data_vec[18];
							}
							if(data_vec[19]!="@@"){
								document.Form1.TXT_CITY.value=data_vec[19];
							}
							if(data_vec[20]!="@@"){
								document.Form1.TXT_COUN.value=data_vec[20];
							}
							document.Form1.TXT_PCODE.value=data_vec[21];
							document.Form1.TXT_TEL1.value=data_vec[22];
							if(data_vec[23]!="@@"){
								document.Form1.TXT_FAX1.value=data_vec[23];
							}
							document.Form1.TXT_MAIL1.value=data_vec[24];
							document.Form1.TXT_CONPER1.value=data_vec[25];
							document.Form1.TXT_IGCODE.value=data_vec[27];
							document.Form1.SEL_ICBANK.value=data_vec[28];
							if(data_vec[29]!="@@"){
								document.Form1.SEL_HCOM.value=data_vec[29];
							}	
							document.Form1.TXT_IDES.value=data_vec[30];
							dyicrd2();		
							dydirector2();			
							
							add_data3();
						}	
						else {
							alert('Issuer Code does not exists');
							objx.value="";
							objx.focus();
						}
					}
				}
				
				else if(document.Form1.Hid_scr_name.value == 'sysmain_reactissuers'){
					m_issucode=objx.value;
					
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnsenddata2?issure_code="+m_issucode+"&chksql=reaissuer";
					load_interface(m_url,'XML',false);
					m_size=data_vec.length;
					
					if (m_size>0) {
						document.Form1.TXT_NAME.value=data_vec[0];
						document.Form1.TXT_INSEC.value=data_vec[1];
						document.Form1.SEL_SELIST.value=data_vec[2];
						document.Form1.SEL_NOEIB.value=data_vec[3];
						if(data_vec[4]!="@@"){
							document.Form1.SEL_LAUFI.value=data_vec[4];
						}
						if(data_vec[6]!="@@"){
							document.Form1.SEL_AUCAT.value=data_vec[6];
						}
						if(data_vec[7]!="@@"){
							document.Form1.TXT_AUOPTION.value=data_vec[7];
						}
						if(data_vec[8]!="@@"){
							document.Form1.TXT_IIER.value=data_vec[8];
						}
						if(data_vec[9]!="@@"){
							document.Form1.TXT_ODES1.value=data_vec[9];
						}
						if(data_vec[10]!="0"){
							document.Form1.TXT_ABAMO.value=data_vec[10];
						}
						if(data_vec[11]!="0"){
							document.Form1.TXT_EXPOS.value=data_vec[11];
						}
						document.Form1.SEL_APPW.value=data_vec[12];
						
						
						if(data_vec[13]=="Y"){
							document.Form1.ICHB_IOS.checked=true;
						}
						if(data_vec[14]=="Y"){
							document.Form1.GCHB_GOS.checked=true;
						}
						if(data_vec[15]=="Y"){
							document.Form1.SCHB_EOS.checked=true;
						}
						if(data_vec[16]!="@@"){
							document.Form1.TXT_IDENTI.value=data_vec[16];
						}
						if(data_vec[17]!="@@"){
							document.Form1.TXT_LOCA.value=data_vec[17];
						}
						if(data_vec[18]!="@@"){
							document.Form1.TXT_ADD.value=data_vec[18];
						}
						if(data_vec[19]!="@@"){
							document.Form1.TXT_CITY.value=data_vec[19];
						}
						if(data_vec[20]!="@@"){
							document.Form1.TXT_COUN.value=data_vec[20];
						}
						document.Form1.TXT_PCODE.value=data_vec[21];
						document.Form1.TXT_TEL1.value=data_vec[22];
						if(data_vec[23]!="@@"){
							document.Form1.TXT_FAX1.value=data_vec[23];
						}
						document.Form1.TXT_MAIL1.value=data_vec[24];
						document.Form1.TXT_CONPER1.value=data_vec[25];
						document.Form1.TXT_IGCODE.value=data_vec[27];
						document.Form1.SEL_ICBANK.value=data_vec[28];
						if(data_vec[29]!="@@"){
							document.Form1.SEL_HCOM.value=data_vec[29];
						}	
						document.Form1.TXT_IDES.value=data_vec[30];
						dyicrd2();		
						dydirector2();			
						
						add_data3();
					}	
					else {
						alert('Issuer Code does not exists');
						objx.value="";
						objx.focus();
						
					}     
				}
			}
		}
		
		var icr_count = 1;
		
		function dyicrd2(){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnsenddata2?issure_code="+m_issucode+"&chksql=crrate";
			load_interface(m_url, 'XML',false);
			var m_size3 = data_vec.length;
			var vec_pos=0;
			var lineno = 0;
			if(m_size3>0){
				document.Form1.TXT_ICRDES1.value=data_vec[vec_pos];
			}
			vec_pos=1;
			//icr_count = icr_count+1;
			lineno=1;
			while (vec_pos<m_size3) {
				icr_count = icr_count + 1;
				m_writedata ='<TABLE width="100%" border="0" cellpadding="1" cellspacing="0">';
				if(document.Form1.Hid_scr_name.value == 'sysmain_reactissuers' || document.Form1.Hid_scr_name.value == 'sysmain_deactissuers'){
					m_writedata += '<TD WidTH="35%">Issuer Credit Rating / Description # '+icr_count+'</TD><TD WidTH="65%"><INPUT disabled TYPE="Text" class="txt_input6" style="width:300px"  NAME="TXT_ICRDES'+icr_count+'" SIZE=46 MAXLENGTH=60 VALUE='+data_vec[vec_pos]+'></TD>';
				}else{
					m_writedata += '<TD WidTH="35%">Issuer Credit Rating / Description # '+icr_count+'</TD><TD WidTH="65%"><INPUT TYPE="Text" class="txt_input6" style="width:300px"  NAME="TXT_ICRDES'+icr_count+'" SIZE=46 MAXLENGTH=60 VALUE='+data_vec[vec_pos]+'></TD>';
				}
				//	m_row+
				m_writedata += '</TABLE>'; 
				document.getElementById('icrd1').innerHTML=document.getElementById('icrd1').innerHTML+m_writedata;	
				vec_pos=vec_pos+1;
				//
			}
			document.Form1.HID_ICRD.value=icr_count;
		}
		/*
		function dydirector1(){
			
			m_row="";
			m_writedata ='<TABLE WidTH="100%" STYLE="{color: black; font:bold 10pt arial;}">'+
				'<TR BGCOLOR="silver"><TD WidTH="35%">Board Director '+f+'</TD><TD WidTH="65%"><INPUT TYPE="Text" NAME="TXT_BDIR'+f+'" SIZE=46 MAXLENGTH=10></TD>'+
				m_row+
				'</TABLE>'; 
			document.getElementById('BoardDirector1').innerHTML=document.getElementById('BoardDirector1').innerHTML+m_writedata;	
			document.Form1.HID_DIREC.value=f;
			f=f+1;
		}		              	
		*/
		
		function dydirector2(){
			var m_size4 = 0;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnsenddata2?issure_code="+m_issucode+"&chksql=bdir";
			load_interface(m_url, 'XML',false);
			
			m_size4=data_vec.length;
			var vec_pos=0;
			if(m_size4>0){
				document.Form1.TXT_BDIR1.value=data_vec[vec_pos];
				vec_pos=1;
				//f=f+1;
				var lineno=1;
				var m_row = '';
				
				while (vec_pos<m_size4) {
					f=f+1;
					m_row="";
					m_writedata ='<TABLE width="100%" border="0" cellpadding="1" cellspacing="0" >';
					if(document.Form1.Hid_scr_name.value == 'sysmain_reactissuers' || document.Form1.Hid_scr_name.value == 'sysmain_deactissuers'){
						m_writedata +='<TD WidTH="35%">Board Director '+f+'</TD><TD WidTH="65%"><INPUT class="txt_input6" disabled style="width:300px" TYPE="Text" NAME="TXT_BDIR'+f+'"  VALUE='+data_vec[vec_pos]+' SIZE=46 MAXLENGTH=10></TD>';
					}else{
						m_writedata +=	'<TD WidTH="35%">Board Director '+f+'</TD><TD WidTH="65%"><INPUT class="txt_input6" style="width:300px" TYPE="Text" NAME="TXT_BDIR'+f+'"  VALUE='+data_vec[vec_pos]+' SIZE=46 MAXLENGTH=10></TD>';
					}
					m_writedata +=	m_row+
						'</TABLE>'; 
					document.getElementById('BoardDirector1').innerHTML=document.getElementById('BoardDirector1').innerHTML+m_writedata;	
					vec_pos=vec_pos+1;
					
				}
				document.Form1.HID_DIREC.value=f;
			}
		}	
		
		
		
		function add_data2(){
			var x="";
			var y="";
			var z="";
			var rows = "";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnsenddata2?issure_code="+m_issucode+"&chksql=exisins";
			load_interface(m_url, 'XML',false);
			var m_size1= data_vec.length;
			var vec_pos=0;
			var lineno=1;
			while (vec_pos<m_size1) {
				//alert(document.Form1.HID_INST.value);
				rows=1;
				while ((rows-1)<document.Form1.HID_INST.value) {
					x="ISSUER"+rows;
					y="GUARAN"+rows;
					z="ENDO"+rows;
					
					a="INS_TYPE"+rows;
					b="IPREMI"+rows;
					c="GPREMI"+rows;
					d="EPREMI"+rows;
					
					obj1=document.Form1.elements[x];
					obj2=document.Form1.elements[y];
					obj3=document.Form1.elements[z];
					
					obj4=document.Form1.elements[a];
					obj5=document.Form1.elements[b];
					obj6=document.Form1.elements[c];
					obj7=document.Form1.elements[d];
					//alert(data_vec[vec_pos+0));
					if(data_vec[vec_pos+0]==obj4.value){
						obj5.value=data_vec[vec_pos+2];
						obj6.value=data_vec[vec_pos+4];
						obj7.value=data_vec[vec_pos+6];
						if(data_vec[vec_pos+1]=="Y"){
							obj1.checked=true;
						}
						if(data_vec[vec_pos+3]=="Y"){
							obj2.checked=true;
						}
						if(data_vec[vec_pos+5]=="Y"){
							obj3.checked=true;
						}
					}
					rows=rows+1;
				}
				vec_pos=vec_pos+7;
				lineno=lineno+1;
			}
		}
		
		
		
	</SCRIPT>
	
	<BODY class='body &amp; txt-body' onload="add_data1();mbfsl_list();general_list();select_screen('ADD')">
		<FORM name="Form1" id="Form1" method="POST" action="">
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="sysmain_issuers">
			
			<DIV>
				<TABLE class='table' align='center' border='0' cellpadding='0'
					cellspacing='0' width='99%'>
					<TR>
						<TD height='7'></TD>
					</TR>
					
					<TR height='30'>
						<TD width='13'
							style='background-image: url("<%=m_jsp_client_url%>/images/l1.gif"); background-repeat: no repeat;'
							id='hi1'></TD>
						<TD
							style='background-image: url("<%=m_jsp_client_url%>/images/l3.gif"); background-repeat: repeat;'
							id='hi2' align='left'><B>Administration - Security</B></TD>
						<TD width='13'
							style='background-image: url("<%=m_jsp_client_url%>/images/l2.gif"); background-repeat: no repeat;'
							id='hi3'></TD>
						
					</TR>
					
					
					
				</TABLE>
				
			</DIV>
			<!--------------------------------------------------------------->
			<TABLE class='table' border='0' cellpadding='0' cellspacing='0'
				width='100%'>
				<TR>
					<TD height='1'></TD>
				</TR>
				<TR>
					<TD><!-------------------------------------------------------------------->
						
						
						<TABLE width="100%" bgcolor="darkblue">
							<TR>
								
								<TD width="6%"><INPUT type="Button" name="NEW" value="Add"
										onclick="select_screen('ADD');" class="mainbut"></TD>
								<TD width="6%"><INPUT type="Button" name="MOD" value="Edit"
										onclick="select_screen('MOD');" class="mainbut"></TD>
								<TD width="6%"><INPUT type="Button" style="width: 80px"
										name="DEA" value="Deactivate" onclick="select_screen('DEA');"
										class="mainbut"></TD>
								<TD width="6%"><INPUT type="Button" name="REA"
										style="width: 80px" value="Reactivate"
										onclick="select_screen('REA');" class="mainbut"></TD>
								<TD width='6%'>&nbsp;&nbsp;&nbsp;&nbsp;</TD>
								<!---------------------------------->
								<TD width="6%"><INPUT type="Button" name="save_but"
										value="Save" onclick="beforesubmit()" class="mainbut"></TD>
								
								<TD width="6%"><INPUT type="Button" name="calcel_but"
										value="Cancel" onclick="clearAll()" class="mainbut"></TD>
								<TD width="6%"><INPUT type="Button" name="Exit_but"
										value="Exit" onclick="top.frames[1].location.href='low.jsp'"
										class="mainbut"></TD>
								<TD width="6%"><INPUT type="Button" name="view_all_but"
										value="View All" onclick="view_all_issuers(0)" class="mainbut">
									
								</TD>
	
								<!--<TD  WIDTH="50%" class="hh1" align="right">-->
								<!--<B>Issuers</B>-->
								<TD> <B><div id='div_lable' align='right' > </div> </B> </TD>		
									
								</TD>
							</TR>
						</TABLE>
						
						
						<!----------->
						
						<TABLE width="100%">
							<TR height='25px;'></TR>
						</TABLE>
						<HR>
						<TABLE width="100%">
							<TR height='25px;'></TR>
						</TABLE>
						
						<BR>
						<TABLE width="100%" border="0" cellpadding="1" cellspacing="0">
							<TR>
								<TD width="1%"></TD>
								<TD width="*%">
									<TABLE width="100%" border="0" cellpadding="1" cellspacing="0">
										<TR>
											<TD width="35%">Issuer Code</TD>
											<TD width="40%"><INPUT type="Text" name="TXT_IOCDE"
													class="txt_input6" align="LEFT" size="27" maxlength="6"
													onblur="chk_issucode(document.Form1.TXT_IOCDE)"> <INPUT
													type="button" value="Help" name="BUT_ICODE" class="but_input" onclick="issuer_help(0)"  Disabled></TD>
											<TD width="25%"></TD>
										</TR>
									</TABLE>
									
									
									
									
									<TABLE width="100%" border="0" cellpadding="1" cellspacing="0">
										<TR>
											<TD width="35%">Name</TD>
											<TD width="65%"><INPUT type="Text" name="TXT_NAME"
													class="txt_input6" align="LEFT" size="59" maxlength="40"></TD>
										</TR>
									</TABLE>
									
									
									<TABLE width="100%" border="0" cellpadding="1" cellspacing="0">
										<TR>
											<TD width="35%">Issuer Group Code</TD>
											<TD width="40%"><INPUT type="Text" name="TXT_IGCODE"
													class="txt_input6" align="LEFT" size="27" maxlength="5"
													onblur="addigcode(document.Form1.TXT_IGCODE)";> <INPUT
													type="button" value="Help" name="BUT_IGCODE" class="but_input"
													onclick="issuergru_help(0)"></TD>
											<TD width="25%"></TD>
										</TR>
										<TR>
											<TD>Issuer Group Description</TD>
											<TD><INPUT type="Text" name="TXT_IDES" align="LEFT"
													class="txt_input6" size="27" maxlength="40"></TD>
											<TD></TD>
										</TR>
										
									</TABLE>
									<HR width="*%">
									
									<TABLE width="100%" border="0" cellpadding="1" cellspacing="0">
										<TR>
											<TD width="35%"></TD>
											<TD width="65%"></TD>
										</TR>
										<TR>
											<TD><B><U>Issuer Description</U></B></TD>
										</TR>
										<TR>
											<TD>Industry Sector - CSAM</TD>
											<TD><SELECT class="txt_input6" style="width:200px" name="TXT_INSEC"></SELECT></TD>
										</TR>
										<TR>
											<TD>Industry Sector - Central Bank</TD>
											<TD><SELECT class="txt_input6" style="width:200px" name="SEL_ICBANK"></SELECT></TD>
											
										</TR>
										<TR>
											<TD>Stock Exchange Listing</TD>
											<TD><SELECT class="txt_input6" name="SEL_SELIST">
													<OPTION value="Y" selected>Yes</OPTION>
													<OPTION value="N">No</OPTION>
												</SELECT></TD>
										</TR>
										<TR>
											<TD>Number of Years in Business</TD>
											<TD><SELECT class="txt_input6" style="width:200px"  name="SEL_NOEIB">
													<OPTION value="50MORE" selected>More than 50 Years</OPTION>
													<OPTION value="10-50" selected>10 - 50 Years</OPTION>
													<OPTION value="5-10" selected>5 - 10 Years</OPTION>
													<OPTION value="1-5" selected>1 - 5 Years</OPTION>
													<OPTION value="LESS1">Less then 1 Year</OPTION>
												</SELECT></TD>
										</TR>
										<TR>
											<TD>Holding Company</TD>
											<TD width="40%"><INPUT class="txt_input6" type="Text"
													name="SEL_HCOM" align="LEFT" size="27" maxlength="10"
													onblur="chk_holecom(document.Form1.SEL_HCOM)"> <INPUT
													type="button" class="but_input" value="Help" name="BUT_ICODE2"
													onclick="holecom_help(0)"></TD>
										</TR>
										<TR>
											<TD>Latest Audited Financials Reviewed</TD>
											<TD><SELECT class="txt_input6" style="width:200px" name="SEL_LAUFI">
													<OPTION value="1" selected>1</OPTION>
													<OPTION value="2" selected>2</OPTION>
													<OPTION value="3" selected>3</OPTION>
													<OPTION value="4" selected>4</OPTION>
													<OPTION value="5">5</OPTION>
												</SELECT></TD>
										</TR>
										<TR>
											<TD>Auditors Opinion</TD>
											<TD><SELECT class="txt_input6" style="width:200px"  name="SEL_AUOPTION">
													<OPTION value="UNQ" selected>Unqualified</OPTION>
													<OPTION value="QUA" selected>Qualified</OPTION>
													<OPTION value="MOE">Matter of Emphasis</OPTION>
												</SELECT></TD>
										</TR>
										<TR>
											<TD>Auditor Category</TD>
											<TD><SELECT class="txt_input6" style="width:200px" name="SEL_AUCAT">
													<OPTION value="I" selected>International</OPTION>
													<OPTION value="D">Domestic</OPTION>
												</SELECT></TD>
										</TR>
									</TABLE>
									
									
									<TABLE width="100%" border="0" cellpadding="1" cellspacing="0">
										<TR>
											<TD>Internal Issuer Evaluation Reference</TD>
											<TD><INPUT type="Text" class="txt_input6" name="TXT_IIER"
													align="LEFT" size="27" maxlength="150"></TD>
										</TR>
										<TR>
											<TD width="35%">Summary of Audit Opinion</TD>
											<TD width="65%"><INPUT class="txt_input6" type="Text"
													name="TXT_AUOPTION" align="LEFT" size="59" maxlength="150"></TD>
										</TR>
										<TR>
											<TD>Other Description</TD>
											<TD><INPUT type="Text" class="txt_input6" name="TXT_ODES1"
													align="LEFT" size="59" maxlength="200"></TD>
											<TD width="25%"></TD>
											
										</TR>
									</TABLE>
									
									
									<TABLE width="100%" border="0" cellpadding="1" cellspacing="0">
										<TR>
											<TD width="35%">Issuer Credit Rating / Description # 1</TD>
											<TD width="65%"><INPUT type="Text" class="txt_input6" style = "width:300px" 
													name="TXT_ICRDES1" align="LEFT" size="46" maxlength="10"
													onblur="document.Form1.HID_ICRD.value=1"> <INPUT
													type="button" value="More" class="but_input" name="BUT_IGCODE1"
													onclick="dyicrd1()"> <INPUT type="button" value="Next "
													class="but_input" name="BUT_IDE"></TD>
											<TD width="25%"></TD>
										</TR>
									</TABLE>
									<INPUT type="Hidden" name="HID_ICRD" value="1">
									<DIV id="icrd1"></DIV>
									
									<HR width="*%">
									<TABLE width="100%" border="0" cellpadding="1" cellspacing="0">
										<TR>
											<TD width="35%">Issuer Level Total Exposure Limit :</TD>
											<TD width="20%">Absolute Amount</TD>
											<TD width="45%"><INPUT type="Text" class="txt_input6"
													name="TXT_ABAMO" align="LEFT" size="37" maxlength="12"
													onblur="formatnum(document.Form1.TXT_ABAMO)";></TD>
										</TR>
										<TR>
											<TD></TD>
											<TD>% Exposure</TD>
											<TD><INPUT type="Text" name="TXT_EXPOS" class="txt_input6"
													align="LEFT" size="37" maxlength="6"></TD>
										</TR>
										<TR>
											<TD></TD>
											<TD>Apply whichever is</TD>
											<TD><SELECT class="txt_input6" name="SEL_APPW">
													<OPTION value="L" selected>Lower</OPTION>
													<OPTION value="H">Higher</OPTION>
												</SELECT></TD>
										</TR>
									</TABLE>
									
									
									<HR width="*%">
									<TABLE width="100%" border="0" cellpadding="1" cellspacing="0">
										<TR>
											<TD width="35%">Liability Variation Types :</TD>
											<TD width="5%"><INPUT type="checkbox" class="txt_input6"
													name="ICHB_IOS" value="N"
													onclick="issue(document.Form1.HID_INST.value)"></TD>
											<TD width="60%">Issue of Securities</TD>
										</TR>
										<TR>
											<TD></TD>
											<TD><INPUT type="checkbox" name="GCHB_GOS" class="txt_input6"
													value="N" onclick="guaran(document.Form1.HID_INST.value)"></TD>
											<TD>Guarantee of Securities</TD>
										</TR>
										<TR>
											<TD></TD>
											<TD><INPUT type="checkbox" name="SCHB_EOS" class="txt_input6"
													value="N" onclick="endor(document.Form1.HID_INST.value)"></TD>
											<TD>Endorsement of Securities</TD>
										</TR>
									</TABLE>
									
									
									
									<HR width="*%">
									<B><U>Instrument Types & Premiums for Valuation :</U></B>
									
									<TABLE width="100%" border="0" cellpadding="0" cellspacing="0">
									</TABLE>
									<DIV id="insdata"></DIV>
									
									
									
									<HR width="*%">
									<B><U>Address :</U></B>
									<TABLE width="100%" border="0" cellpadding="1" cellspacing="0">
										<TR>
											<TD width="35%">Identification</TD>
											<TD width="65%"><INPUT type="Text" class="txt_input6"
													name="TXT_IDENTI" align="LEFT" size="59" maxlength="30"
													onclick="isspre(document.Form1.HID_INST)"></TD>
										</TR>
										<TR>
											<TD>Location</TD>
											<TD><INPUT type="Text" name="TXT_LOCA" class="txt_input6"
													align="LEFT" size="59" maxlength="30"></TD>
										</TR>
										<TR>
											<TD>Street Address</TD>
											<TD><INPUT type="Text" name="TXT_ADD" class="txt_input6"
													align="LEFT" size="59" maxlength="30"></TD>
										</TR>
										<TR>
											<TD>City</TD>
											<TD><INPUT type="Text" name="TXT_CITY" class="txt_input6"
													align="LEFT" size="59" maxlength="30"></TD>
										</TR>
										<TR>
											<TD>Country</TD>
											<TD><INPUT type="Text" name="TXT_COUN" class="txt_input6"
													align="LEFT" size="59" maxlength="30"></TD>
										</TR>
										<TR>
											<TD>Postal Code</TD>
											<TD><INPUT type="Text" name="TXT_PCODE" class="txt_input6"
													align="LEFT" size="59" maxlength="5"
													onblur="chk_postcode(document.Form1.TXT_PCODE)"></TD>
										</TR>
									</TABLE>
									
									
									<HR width="*%">
									<B><U>Board Directors :</U></B>
									<TABLE width="100%" border="0" cellpadding="1" cellspacing="0">
										<TR>
											<TD width="35%">Board Director 1</TD>
											<TD width="60%"><INPUT type="Text" name="TXT_BDIR1"
													class="txt_input6" align="LEFT" size="46" maxlength="20" style = "width:300px" 
													onblur='document.Form1.HID_DIREC.value=1'> <INPUT
													type="button" value="More" class="but_input" name="BUT_IGCODE2"
													onclick="dydirector1()"> <INPUT type="button"
													value="Next " name="BUT_IDE1" class="but_input"></TD>
											<TD width="25%"></TD>
										</TR>
									</TABLE>
									<INPUT type="Hidden" name="HID_DIREC" value="0">
									<DIV id="BoardDirector1"></DIV>
									
									
									
									<HR width="*%">
									<B><U>Contact Details :</U></B>
									<TABLE width="100%" border="0" cellpadding="1" cellspacing="0">
										
										<TR>
											<TD width="35%">Telephone</TD>
											<TD width="65%"><INPUT type="Text" class="txt_input6"
													name="TXT_TEL1" align="LEFT" size="59" maxlength="30"></TD>
											
										</TR>
									</TABLE>
									
									
									<TABLE width="100%" border="0" cellpadding="1" cellspacing="0">
										<TR>
											<TD width="35%">Fax</TD>
											<TD width="65%"><INPUT type="Text" class="txt_input6"
													name="TXT_FAX1" align="LEFT" size="59" maxlength="30"></TD>
										</TR>
									</TABLE>
									
									
									<TABLE width="100%" border="0" cellpadding="1" cellspacing="0">
										<TR>
											<TD width="35%">E-mail</TD>
											<TD width="65%"><INPUT type="Text" class="txt_input6"
													name="TXT_MAIL1" align="LEFT" size="59" maxlength="40"></TD>
										</TR>
									</TABLE>
									
									
									
									<TABLE width="100%" border="0" cellpadding="1" cellspacing="0">
										
										<TR>
											<TD width="35%">Contact Person</TD>
											<TD width="65%"><INPUT type="Text" class="txt_input6"
													name="TXT_CONPER1" align="LEFT" size="59" maxlength="40"></TD>
											
										</TR>
									</TABLE>
									<INPUT type="Hidden" name="HID_INST"></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
			
			
		</FORM>
		<SCRIPT language="JavaScript1.2" src="validate.js"
			type="text/javascript"></SCRIPT>
		<SCRIPT language="JavaScript1.2" src="ajax_data_gateway.js"
			type="text/javascript"></SCRIPT>
		
	</BODY>
</HTML>

