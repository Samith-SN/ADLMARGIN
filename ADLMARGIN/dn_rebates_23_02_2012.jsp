<HTML>
	<HEAD>
		<TITLE>Margin Trading 
		</TITLE>
		
	</HEAD>
	<%@page import="net.sasianet.ADLMARGIN.*" %> 
	
	<%	
		ADLMARGIN_MGT_conn_methods m_sn_methods1 = new ADLMARGIN_MGT_conn_methods();
		String m_html_client_url = m_sn_methods1.html_client_url;
		String m_schema_name     = m_sn_methods1.schema_name.trim();
		String m_client_name     = m_sn_methods1.client_name;
		Object done = (String)session.getValue("logon.isDone"); // marker object
		if (done == null) {
			out.println("<html><head>");
			out.println("<script language='JavaScript'>");
			out.println("function displaymsg() {");
			out.println("alert('Your login expired or invalid');");
			out.println("window.location.href='"+m_html_client_url+"/login.htm';");
			out.println("}</script></head>");
			out.println("<body onload='displaymsg();'></body>");
			out.println("</html>");
			out.flush();
			return;
		}
		
		ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
		String m_jsp_client_url=m_sn_methods.jsp_client_url;
		
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/redmond/jquery-ui.css' TYPE=\"text/css\">");
		
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
		
		
		
	%>
	<SCRIPT language="JavaScript">
		var m_user="";
		
		a=1;
		b=1;
		c=1;	
		var cal_status=false;
		var iframe_html_string = '<iframe id = "IFRAME_DRILL_DOWN" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Drill Down"></iframe>';
		
		
		
		
		function MyDialog(){
			this.valout   = new Array(10);
		}			
		
	function deal_ref_help(m_strat)
			{
     var aForm;    //  aForm =oForm.elements;
     aForm =  document.getElementById('Form1');
	 /*  var myObject = new Object();
   	 myObject.firstName = aForm.oFirstName.value;
   	 myObject.lastName = aForm.oLastName.value;
		*/
	
 	var myObject=new Array(); //return values set to this object
 	myObject[0]=aForm.Text_deal_ref;
	myObject[1]=null
 	myObject[2]=null;
 	myObject[3]=null;
 	myObject[4]=null;
  
 	var myObject_value=new Array(); //passing values set to this object
 	myObject_value[0]=aForm.Text_deal_ref.value;
 	myObject_value[1]=m_user;//aForm.oLastName2.value;
 	myObject_value[2]=m_user;
 	myObject_value[3]=null;
 	myObject_value[4]=null;
 

 	var myObject_type=new Array(); //passing values data type
 	myObject_type[0]="StringL";
 	myObject_type[1]="String";
 	myObject_type[2]="String";
 	myObject_type[3]=null;
 	myObject_type[4]=null;
 
 	var qid='1000';
    title_name='Help';
 	var url = 'popup.jsp';
	var close_fun='close_deal_ref_help';			
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
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400,// 500,
		 width: 600,//900,
		 title: 'SasiNet Frame Work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); if(returnedValue!=null){chk_deadref(document.Form1.Text_deal_ref);}  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
	}
	function close_deal_ref_help(){
		//alert('fff');
		} 
		
	function dealrefrs_help(m_strat)
			{
     var aForm;    //  aForm =oForm.elements;
     aForm =  document.getElementById('Form1');
	 /*  var myObject = new Object();
   	 myObject.firstName = aForm.oFirstName.value;
   	 myObject.lastName = aForm.oLastName.value;
		*/
	
 	var myObject=new Array(); //return values set to this object
 	myObject[0]=aForm.Text_deal_ref;
	myObject[1]=null
 	myObject[2]=null;
 	myObject[3]=null;
 	myObject[4]=null;
  
 	var myObject_value=new Array(); //passing values set to this object
 	myObject_value[0]=aForm.Text_deal_ref.value;
 	myObject_value[1]=m_user;//aForm.oLastName2.value;
 	myObject_value[2]=m_user;
 	myObject_value[3]=null;
 	myObject_value[4]=null;
 

 	var myObject_type=new Array(); //passing values data type
 	myObject_type[0]="StringL";
 	myObject_type[1]="String";
 	myObject_type[2]="String";
 	myObject_type[3]=null;
 	myObject_type[4]=null;
 
 	var qid='1002';
    title_name='Help';
 	var url = 'popup.jsp';
	var close_fun='close_dealrefrs_help';			
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
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400,// 500,
		 width: 600,//900,
		 title: 'SasiNet Frame Work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); if(returnedValue!=null){chk_deadref(document.Form1.Text_deal_ref);calculate_tot();check_rebates_date();format_rebates_yield(document.Form1.Text_rebates_new_yield);}  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
	}
		
function close_dealrefrs_help(){
		//alert('fff');
		}
		
		function dealref_help(help_sql) {
			if(document.Form1.Text_deal_ref.value!=""){
				if(document.Form1.Text_deal_ref.value!=" "){
					
					document.Form1.hid_help_type.value="1";
					if(help_sql=="1"){
						m_sql = "m_pre_ma_rfhelp";
					}
					else if(help_sql=="2"){
						m_sql="m_pre_ma_rrhelp";
					}
					else if(help_sql=="3"){
						m_sql="m_pre_ma_rshelp";
					}
					m_criteria = document.Form1.Text_deal_ref.value+"@"+m_user+"@";
					//alert(m_criteria);
					HelpBox('1','10','0');
				}
				
				else{
					alert("Please try to enter the Deal Reference No");
					document.Form1.Text_deal_ref.focus();
				}
				
			}
			else{
				alert("Please try to enter the Deal Reference No");
				document.Form1.Text_deal_ref.focus();
			}
			
		}
		
		
		//----------------This Function Is to get The Help Box------------------------------//
		function HelpBox(Start,End,Hid_No) {
			oBj = new MyDialog();
			oBj.valout[1]  = " ";
			oBj.valout[2]  = " ";
			oBj.valout[3]  = " ";
			//alert(m_sql);
			/*
			window.open(""+servlet_client_url+":"+client_t3_port+"/"+client_name+"dn_Help_Servlet_receipt?class_in="+client_name+"dn_help_select"+
									"&Sql_in="+m_sql+"&Start_in="+Start+
									"&End_in="+End+"&Crit_In="+m_criteria+
									"&Hid_No="+Hid_No+"");
			*/
			
			
			popupwin = window.showModalDialog(""+servlet_client_url+":"+client_t3_port+"/"+client_name+"dn_Help_Servlet_receipt?class_in="+client_name+"dn_help_select"+
				"&Sql_in="+m_sql+"&Start_in="+Start+
					"&End_in="+End+"&Crit_In="+m_criteria+
					"&Hid_No="+Hid_No+"", oBj,"dialogWidth:60em; dialogHeight:18em; center:yes; status:no");
			
			
			
			
			if(document.Form1.hid_help_type.value=="1"){
				if(oBj.valout[1] !=" "){
					if(oBj.valout[1] !='Close'){
						if(oBj.valout[1]!="Prev"){
							if(oBj.valout[1]!="Next"){
								asign_repo_code();
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
						document.Form1.Text_deal_ref.value="";	
					}		
				}
				else{		
					document.Form1.Text_deal_ref.value="";	
				}		
			}
			
		}
		function Prev(Start,End,Hid_No){
			HelpBox(Start,End,Hid_No)
		}
		function Next (Start,End,Hid_No){
			HelpBox(Start,End,Hid_No)
		}
		
		function asign_repo_code() {	
			document.Form1.Text_deal_ref.value=oBj.valout[2];
			document.Form1.Text_deal_ref.focus();
		}
		
		
		
		
		function codes_help1(obj1) {
			bpctype="";
			spctype="";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fval_rebates?buyer_code="+document.Form1.TXT_BCODE.value+"&chksql=chkbuy";
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;;
			bpctype=data_vec[2];
			if (bpctype=='P'){ 
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fval_rebates?buyer_code="+document.Form1.TXT_BCODE.value+"&chksql=settle_out1";
				load_interface(m_url,'XML',false);
				m_size=data_vec.length;;
			}
			if (bpctype=='C'){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fval_rebates?buyer_code="+document.Form1.TXT_BCODE.value+"&chksql=settle_out2";
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fval_rebates?seller_code="+document.Form1.TXT_BCODE.value+"&chksql=settle_out2";
				load_interface(m_url,'XML',false);
				m_size=data_vec.length;;
			}
			vec_pos=0;
			lineno=1;
			m_row="";
			while (vec_pos<m_size) {
				m_issu_code=data_vec[vec_pos+1];
				m_issu_name=data_vec[vec_pos];
				m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+'><B>'+m_issu_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_issu_name+'</B></TD></TR>';
				vec_pos=vec_pos+2;
				lineno=lineno+1;
			}
			m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color: white; font: 9pt arial;}">'+
				'<TR BGCOLOR="darkblue"><TD WIDTH="30%"><B>Account No</B></TD>' +
				'<TD WIDTH="70%"><B>Bank Name</B></TD></TR>'+
				m_row+
				'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval = "";
			
			popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
			obj1.value=myDialogObj.returnval;
			obj1.focus();			
		}			
		
		
		
		function codes_help2(obj1) {
			bpctype="";
			spctype="";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fval_rebates?buyer_code="+document.Form1.TXT_LCODE.value+"&chksql=chkbuy";
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;;
			
			spctype=data_vec[2];
			if (spctype=='P'){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fval_rebates?seller_code="+document.Form1.TXT_LCODE.value+"&chksql=settle_out1";
				load_interface(m_url,'XML',false);
				m_size=data_vec.length;;
			}
			if (spctype=='C'){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fval_rebates?seller_code="+document.Form1.TXT_LCODE.value+"&chksql=settle_out2";
				//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fval_rebates?buyer_code="+parent.frames[0].document.Form1.TXT_SCODE.value+"&chksql=settle_out2";
				//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fval_rebates?buyer_code="+parent.frames[0].document.Form1.TXT_BCODE.value+"&chksql=settle_out2";
				load_interface(m_url,'XML',false);
				m_size=data_vec.length;;
			}
			vec_pos=0;
			lineno=1;
			m_row="";
			while (vec_pos<m_size) {
				m_issu_code=data_vec[vec_pos+1];
				m_issu_name=data_vec[vec_pos];
				m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+'><B>'+m_issu_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_issu_name+'</B></TD></TR>';
				vec_pos=vec_pos+2;
				lineno=lineno+1;
			}
			m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color: white; font: 9pt arial;}">'+
				'<TR BGCOLOR="darkblue"><TD WIDTH="30%"><B>Account No</B></TD>' +
				'<TD WIDTH="70%"><B>Bank Name</B></TD></TR>'+
				m_row+
				'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval = "";
			
			popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
			obj1.value=myDialogObj.returnval;
			obj1.focus();			
		}			
		
		function setformat(){
			
			VAL_SETT.value=format_noobject(VAL_SETT.value);
			document.Form1.TXT_TOAMO.value=format_noobject( document.Form1.TXT_TOAMO.value);
			
		}
		
		
		function calculate_tot(){
			
			//Modification  : Adding part of the Settlment done on servlet  
			//  created by Samanthi Ranasinghe on 12/03/2001 
			
			
			var missval;
			if (document.Form1.SEL_REBATES_MODES.value>1){
				mt_sttamo="TXT_SETAMO"+c;
				VAL_SETT=document.Form1.elements[mt_sttamo];
				//VAL_SETT.value=format_noobject(VAL_SETT.value);
				VAL_SETT.value = unformat_noobject(VAL_SETT.value);
				document.Form1.TXT_TOAMO.value=unformat_noobject(document.Form1.TXT_TOAMO.value);
				
				c=c+1;
				///////ssssss
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"settlement?chksql=deal&totamt="+document.Form1.TXT_TOAMO.value+"&setamt="+VAL_SETT.value+"";
				load_interface(m_url,'XML',false);
				m_size=data_vec.length;;
				//	alert(m_url);	
				//	vec_pos=0;
				//	  alert(m_size);
				// 	alert(data_vec[0));
				/////sssssss
				//document.Form1.TXT_TOAMO.value=format_noobject(parseFloat(unformat_noobject(document.Form1.TXT_TOAMO.value))+parseFloat(unformat_noobject(VAL_SETT.value)));
				document.Form1.TXT_TOAMO.value=data_vec[0];
			}
			
			
			if(c>document.Form1.SEL_REBATES_MODES.value){
				//alert(document.Form1.TXT_TOAMO.value);
				//alert(document.Form1.TXT_TENOR.value);
				if (unformat_noobject(document.Form1.TXT_TOAMO.value)!=unformat_noobject(document.Form1.TXT_TENOR.value)){
					//alert("tot="document.Form1.TXT_TOAMO.value);
					//alert("ten="document.Form1.TXT_TENOR.value);
					////ssss
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"settlement?chksql=deal1&totamt="+unformat_noobject(document.Form1.TXT_TOAMO.value)+"&tenor="+unformat_noobject(document.Form1.TXT_TENOR.value)+"";
					
					load_interface(m_url,'XML',false);
					m_size=data_vec.length;;
					//vec_pos=0;
					
					missval=data_vec[0];
					//alert (missval);
					VAL_SETT.value=format_noobject(VAL_SETT.value);
					
					//	alert(missval);
					//missval=format_noobject(parseFloat(unformat_noobject(document.Form1.TXT_TOAMO.value))-parseFloat(unformat_noobject(document.Form1.TXT_TENOR.value)));
					alert('Settlement amount total should be '+document.Form1.TXT_TENOR.value+'. There is a missmatch of '+missval+'. Please make the required changes and press the TAB key');
					c=1;
					q=1
						while (q<document.Form1.SEL_REBATES_MODES.value){
							dup_sttamo="TXT_SETAMO"+q;
							dup_sttamo.value="";
							q=q+1;
						}
						document.Form1.TXT_TOAMO.value="0.00";
					document.Form1.TXT_SETAMO1.focus();
				}
			}
			
		}
		
		function submit() {
			//	alert(document.Form1.SCR_NAME.value);
			
			
			document.Form1.TXT_TENOR.value = unformat_noobject(document.Form1.TXT_TENOR.value);
			document.Form1.Text_new_leg2.value = unformat_noobject(document.Form1.Text_new_leg2.value);
			document.Form1.TXT_SETAMO1.value = unformat_noobject(document.Form1.TXT_SETAMO1.value);
			document.Form1.Text_leg2.value = unformat_noobject(document.Form1.Text_leg2.value);
			document.Form1.TXT_leg1.value = unformat_noobject(document.Form1.TXT_leg1.value);
			document.Form1.TXT_TENOR.value = unformat_noobject(document.Form1.TXT_TENOR.value);
			document.Form1.Text_interest.value = unformat_noobject(document.Form1.Text_interest.value);
			
			document.Form1.save_but.disabled=true;
			//enable_inputs(); 
			
			if(document.Form1.Text_new_date1.value=="" ||document.Form1.Text_new_month1.value==""||document.Form1.Text_new_year1.value =="")
			{
				alert('Please Enter the Settlement Date');
				 document.Form1.save_but.disabled=false;
			}
			else if(document.Form1.Text_new_yield.value=="")
			{
				alert('Please Enter a value for Markup');
				document.Form1.save_but.disabled=false;
			}	
			else
			{	
				document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"fsavrebates";
				document.Form1.submit();
			}	
				
		}
		
		function beforesubmit() {
			
			enable_inputs();
			submit();				
			//displayconfirmdata_Repo_settlement(); 					
			
		}
		
		function enable_inputs() {
			for (var i = 0; i< document.Form1.elements.length; i++) {
				document.Form1.elements[i].disabled = false;
				
			}
		}
		
		function myDialogObj() {
			var htmlstr;
			var returnval;
		}
		
		
		
		function change_type(m_val){
			document.Form1.Hid_but_type.value = document.Form1.Hid_but_type.value
			
		}
		
		function change_button(m_val){
			document.Form1.Hid_but_type.value = m_val;
			//alert(m_val);
			if(m_val=='DEL') //added 2011-11-15
			{
				//alert('xxx') 
				document.Form1.Text_help_ref.disabled=true;
				//alert(document.Form1.Text_help_ref.disabled);
				document.Form1.Text_help_rollover.disabled=true;
				<!--  Text_help_rollover -->
			}else
			{
				document.Form1.Text_help_ref.disabled=false;
				document.Form1.Text_help_rollover.disabled=false;
			}	
			
			parent.frames[0].document.Form1.save_but.disabled=false; //2011-11-15
		
		}
		
		
		
		function chk_deadref(obj) {
			
			mm_ref=obj.value;
			if (obj.value=="") {
				alert('Please enter a Deal Reference No');
				obj.value=""
					obj.focus();
			}
			
			else {
				
				mm_ref =mm_ref.substring(0,2);
				m_postcode=obj.value;
				if(document.Form1.Hid_but_type.value=="DEL"){
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fval_rebates?deal_code="+m_postcode+"&chksql=chkdeal_DEL";
					
					load_interface(m_url,'XML',false);
					//window.open(m_url);
					m_size=data_vec.length;;
					//alert('m_size'+m_size);
				}else{
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fval_rebates?deal_code="+m_postcode+"&chksql=chkdeal";
					load_interface(m_url,'XML',false);
					m_size=data_vec.length;;
				}
				if (m_size==0) {
					if (confirm("Invalid Deal Reference No..Press the OK button if you want a list of Deal Reference Numbers or Press the Cancel button to type again")) {
						if(document.Form1.Hid_but_type.value=="DEL"){
							if(mm_ref =="RB"){
								dealrefrbelp(0);
								//reference_rp_help();
							}
						}else{
							 if(mm_ref =="RS"){
								deal_ref_help(0);
								//reference_repo_help(); 
							}
						}
					} 
					else{  
						document.Form1.Text_deal_ref.focus();
					}   
				}
				else {
					m_dealcode=obj.value;
					
					if(mm_ref =="RB"){
						if(document.Form1.Hid_but_type.value=="DEL"){
							
							m_url3=servlet_client_url+":"+client_t3_port+"/"+client_name+"fval_rebates?ref_code="+m_dealcode+"&chksql=rb_setleinfo";
							//window.open(m_url3);
							load_interface(m_url3,'XML',false);
							m_size3=data_vec.length;;
							
							if (m_size3>0){
								document.Form1.TXT_BCODE.value=data_vec[1];
								document.Form1.TXT_LCODE.value=data_vec[2];
								document.Form1.Text_chq_date1.value=data_vec[3];
								document.Form1.Text_chq_month1.value=data_vec[4];
								document.Form1.Text_chq_year1.value=data_vec[5];
								document.Form1.TXT_CURR.value=data_vec[6];
							    document.Form1.TXT_TENOR.value=format_noobject(data_vec[7]);
								document.Form1.TXT_BNAME.value=data_vec[8];
								document.Form1.TXT_LNAME.value=data_vec[9];
								document.Form1.Text_Tenor.value=data_vec[14];
								document.Form1.Text_Yield.value=data_vec[15];
								document.Form1.TXT_leg1.value=data_vec[16];
								document.Form1.Text_leg2.value=data_vec[17];
								
								document.Form1.TXT_SETAMO1.value=data_vec[17];
								
								
								document.Form1.hid_eff_validate.value=data_vec[18];
								document.Form1.Text_basis_code.value=data_vec[19];
								document.Form1.Text_new_date1.value  	 =data_vec[20];
								document.Form1.Text_new_month1.value		 =data_vec[21];
								document.Form1.Text_new_year1.value		 =data_vec[22];
								document.Form1.Text_new_Tenor.value		 =data_vec[24];	
								document.Form1.Text_new_leg2.value	  	 =data_vec[23];	
								document.Form1.Text_new_yield.value	   =data_vec[26];	
								document.Form1.Hid_PRI_DEAL_no.value	   =data_vec[27];		
								document.Form1.Text_new_yield.disabled	 =true;	
								document.Form1.Text_new_date1.disabled	 =true;	
								document.Form1.Text_new_month1.disabled =true;	
								document.Form1.Text_new_year1.disabled	 =true;	
								document.Form1.Text_new_Tenor.disabled	 =true;	
								document.Form1.Text_new_leg2.disabled	 =true;	
								document.Form1.Text_new_yield.disabled	 =true;	
							}
						}else{
							alert('Please enter corect deal number');
						}
					}
					else{
						document.Form1.Text_new_yield.disabled	 = true;	
						document.Form1.Text_new_date1.disabled	 = true;	
						document.Form1.Text_new_month1.disabled  = true;		
						document.Form1.Text_new_year1.disabled	 = true;	
						// document.Form1.Text_new_Tenor.disabled	 =false;	
						//document.Form1.Text_new_leg2.disabled	 =false;	
						document.Form1.Text_new_yield.disabled	 =true;	
						m_url3=servlet_client_url+":"+client_t3_port+"/"+client_name+"fval_rebates?ref_code="+m_dealcode+"&chksql=rs_setleinfo";
						//window.open(m_url3);	
						load_interface(m_url3,'XML',false);
						m_size3=data_vec.length;;
						//alert(m_size3);
						//alert(data_vec[1));
						if (m_size3>0)
						{
							document.Form1.TXT_BCODE.value=data_vec[1];
							document.Form1.TXT_LCODE.value=data_vec[2];
							document.Form1.Text_chq_date1.value=data_vec[3];
							document.Form1.Text_chq_month1.value=data_vec[4];
							document.Form1.Text_chq_year1.value=data_vec[5];
							document.Form1.TXT_CURR.value=data_vec[6];
							document.Form1.TXT_TENOR.value=format_noobject(data_vec[7]);
							document.Form1.TXT_BNAME.value=data_vec[8];
							document.Form1.TXT_LNAME.value=data_vec[9];
							document.Form1.Text_Tenor.value=data_vec[14];
							document.Form1.Text_Yield.value=data_vec[15];
							document.Form1.TXT_leg1.value=data_vec[16];
							document.Form1.Text_leg2.value=data_vec[17];
							document.Form1.Text_new_yield=data_vec[17]; //over ride
							document.Form1.hid_eff_validate.value=data_vec[18];
							document.Form1.Text_basis_code.value=data_vec[19];
							
							document.Form1.Text_new_date1.value  = data_vec[20];
							document.Form1.Text_new_month1.value = data_vec[21];
							document.Form1.Text_new_year1.value	 = data_vec[22];
							
							document.Form1.Text_rebates_new_date1.value  = data_vec[20];
							document.Form1.Text_rebates_new_month1.value = data_vec[21];
							document.Form1.Text_rebates_new_year1.value	 = data_vec[22];
							
							document.Form1.Text_new_Tenor.value	 = data_vec[24];	
							document.Form1.Text_new_leg2.value	 = data_vec[23];
							
							document.Form1.TXT_REBATES_SETAMO1.value	 = data_vec[23];
							
							document.Form1.Text_new_yield.value	 = data_vec[26];
							document.Form1.Text_rebates_new_yield.value= data_vec[26];
							document.Form1.Hid_PRI_DEAL_no.value = data_vec[27];
							
						}
						else{
							m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fval_rebates?ref_code="+m_dealcode+"&chksql=setleinfo_reporoll";
							//window.open(m_url);	
							load_interface(m_url,'XML',false);
							m_size=data_vec.length;;
							if (m_size>0){
								document.Form1.TXT_BCODE.value=data_vec[1];
								document.Form1.TXT_LCODE.value=data_vec[2];
								document.Form1.Text_chq_date1.value=data_vec[3];
								document.Form1.Text_chq_month1.value=data_vec[4];
								document.Form1.Text_chq_year1.value=data_vec[5];
								document.Form1.TXT_CURR.value=data_vec[6];
								document.Form1.TXT_TENOR.value=format_noobject(data_vec[7]);
								document.Form1.TXT_BNAME.value=data_vec[8];
								document.Form1.TXT_LNAME.value=data_vec[9];
								document.Form1.Text_Tenor.value=data_vec[14];
								document.Form1.Text_Yield.value=data_vec[15];
								document.Form1.TXT_leg1.value=data_vec[16];
								document.Form1.Text_leg2.value=data_vec[17];
								document.Form1.Text_new_yield=data_vec[17]; //over ride
								document.Form1.hid_eff_validate.value=data_vec[18];
								document.Form1.Text_basis_code.value=data_vec[19];
							}
							
						}
					}
					if((data_vec[10]=="C" && data_vec[12]=="R") || (data_vec[11]=="C" && data_vec[13]=="R")){
						document.Form1.SEL_SETTLE1.selectedIndex = 4
					}else{
						document.Form1.SEL_SETTLE1.selectedIndex = 0
					}	
					document.Form1.TXT_BCODE.disabled=true;
					document.Form1.TXT_LCODE.disabled=true;
					document.Form1.TXT_CURR.disabled=true;
					document.Form1.TXT_TENOR.disabled=true;
					document.Form1.TXT_BNAME.disabled=true;
					document.Form1.TXT_LNAME.disabled=true;
					document.Form1.Text_chq_date1.disabled=true;
					document.Form1.Text_chq_month1.disabled=true;
					document.Form1.Text_chq_year1.disabled=true;
					document.Form1.TXT_SETAMO1.value=document.Form1.TXT_TENOR.value;
				}
			}    	   
		}
		
		function get_user() {
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fval_rebates?chksql=get_user";
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
			
			if(m_size>0){
				m_user=data_vec[0];
			}
		}
		
		function load_frame(){
			//parent.frames[0].location.href= "dn_pre_mature_settle_frame1.html";
		}
		
		function check_date(){
			
			if(document.Form1.Text_new_date1.value!="" &&	document.Form1.Text_new_month1.value!="" &&	document.Form1.Text_new_year1.value!="")
			{
			   
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fval_rebates?chksql=get_date_status&value_date="+document.Form1.Text_new_date1.value+"-"+document.Form1.Text_new_month1.value+"-"+document.Form1.Text_new_year1.value+""+
					"&eff_validate="+document.Form1.hid_eff_validate.value+"&maturity_date="+document.Form1.Text_chq_date1.value+"-"+document.Form1.Text_chq_month1.value+"-"+document.Form1.Text_chq_year1.value;
				//window.open(m_url);	
				load_interface(m_url,'XML',false);
				m_size=data_vec.length;;
				if(m_size>0)
				{
					document.Form1.Text_new_date1.value  =data_vec[0];
					document.Form1.Text_new_month1.value	=data_vec[1];
					document.Form1.Text_new_year1.value	=data_vec[2];
					document.Form1.Text_new_Tenor.value	=data_vec[3];	
				}else
				{
					document.Form1.Text_new_date1.value  ="";
					document.Form1.Text_new_month1.value	="";
					document.Form1.Text_new_year1.value	="";	
					document.Form1.Text_new_date1.focus();
					alert('Please make sure that the Settlement Date Greater than the Delas Effective Date and Settlement Date is less than the Previous Settlement Date ');	
					
				}
			}
		}
		
		
		function check_rebates_date(){
			
			if(document.Form1.Text_rebates_new_date1.value!="" &&	document.Form1.Text_rebates_new_month1.value!="" &&	document.Form1.Text_rebates_new_year1.value!="")
			{
			   
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fval_rebates?chksql=get_rebate_date_status&value_date="+document.Form1.Text_rebates_new_date1.value+"-"+document.Form1.Text_rebates_new_month1.value+"-"+document.Form1.Text_rebates_new_year1.value+""+
					//"&eff_validate="+document.Form1.Text_new_date1.value+"-"+document.Form1.Text_new_month1.value+"-"+document.Form1.Text_new_year1.value+
					"&eff_validate="+document.Form1.hid_eff_validate.value+
					"&maturity_date="+document.Form1.Text_chq_date1.value+"-"+document.Form1.Text_chq_month1.value+"-"+document.Form1.Text_chq_year1.value;
				//window.open(m_url);	
				load_interface(m_url,'XML',false);
				m_size=data_vec.length;;
				if(m_size>0)
				{
					document.Form1.Text_rebates_new_date1.value  =data_vec[0];
					document.Form1.Text_rebates_new_month1.value	=data_vec[1];
					document.Form1.Text_rebates_new_year1.value	=data_vec[2];
					document.Form1.Text_rebates_new_Tenor.value	=data_vec[3];	
				}else
				{
					document.Form1.Text_rebates_new_date1.value  ="";
					document.Form1.Text_rebates_new_month1.value	="";
					document.Form1.Text_rebates_new_year1.value	="";	
					document.Form1.Text_rebates_new_date1.focus();
					alert('Please make sure that the Rebates Date Greater than the Delas Effective Date and Rebates Date is less than the Previous Rebates Date ');	
					
				}
			}
		}
		
		function format_yield(obj_yield,nextobj){
			if(!obj_yield.value==""){
				if (!isnumberok(obj_yield,8)) {
					alert("Please enter a number!");
					obj_yield.focus();
					
				}
				else {
					obj_yield.value=format_noobject0(obj_yield.value);
					calculate_leg2(document.Form1.TXT_leg1,
						           document.Form1.Text_new_Tenor,
						           obj_yield,
						           document.Form1.Text_basis_code,
						           document.Form1.hid_eff_validate);
					//nextobj.focus();
				} 
			}	
		}
		
		function format_rebates_yield(obj_yield){
			if(!obj_yield.value==""){
				if (!isnumberok(obj_yield,8)) {
					alert("Please enter a number!");
					obj_yield.focus();
					
				}
				else {
					 obj_yield.value=format_noobject0(obj_yield.value);
				   
					//	calculate_leg2(document.Form1.TXT_leg1,document.Form1.Text_new_Tenor,obj_yield,document.Form1.Text_basis_code,document.Form1.hid_eff_validate);
					
					calculate_rebates_intamt(document.Form1.TXT_REBATES_SETAMO1,
							document.Form1.Text_rebates_new_yield,
							document.Form1.Text_rebates_new_Tenor,
							document.Form1.Text_basis_code
					         ) 
				} 
			}	
		}
		
		function calculate_rebates_intamt(obj_leg2,obj_yield,obj_tenor,obj_basis) {
			//alert('');
			//m_leg1=unformat_number(obj_leg1);
			m_leg2=unformat_number(obj_leg2);
			m_yield= unformat_number(obj_yield)/100;
			m_tenor=unformat_number(obj_tenor);
			m_basis=obj_basis.value;
			m_valdate =document.Form1.Text_rebates_new_date1.value+"-"+document.Form1.Text_rebates_new_month1.value+"-"+document.Form1.Text_rebates_new_year1.value;
			
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?chksql=calculateinterstleg2&leg2="+m_leg2+"&yield="+m_yield+"&tenor="+m_tenor+"&basis="+m_basis+"&val_date="+m_valdate;
		
				
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;;
			document.Form1.Text_rebates_new_leg2.value=data_vec[0];
			//document.Form1.Text_pay_borrower.focus();
		}
		
		function calculate_leg2(obj_leg1,obj_tenor,obj_yield,obj_base,obj_valdate){
			obj_leg1.value=format_noobject(obj_leg1.value);
			m_leg1=unformat_noobject(obj_leg1.value);
			m_yield=obj_yield.value/100;
			m_tenor=unformat_noobject(obj_tenor.value);
			m_basis=obj_base.value;
			m_valdate=obj_valdate.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?chksql=calculateleg2&leg1="+m_leg1+"&yield="+m_yield+"&tenor="+m_tenor+"&basis="+m_basis+"&val_date="+m_valdate;
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
			
			document.Form1.Text_new_leg2.value=data_vec[0];
			calculate_intamt(obj_leg1,document.Form1.Text_leg2,document.Form1.Text_new_Tenor,document.Form1.Text_basis_code);
			
			
		} 
		
		
		function calculate_intamt(obj_leg1,obj_leg2,obj_tenor,obj_basis) {
			//alert('');
			m_leg1=unformat_number(obj_leg1);
			m_leg2=unformat_number(obj_leg2);
			m_tenor=unformat_number(obj_tenor);
			m_basis=obj_basis.value;
			
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?chksql=calculateinterest&leg1="+m_leg1+"&leg2="+m_leg2+"&tenor="+m_tenor+"&basis="+m_basis;
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;;
			document.Form1.Text_interest.value=data_vec[0];
			//document.Form1.Text_pay_borrower.focus();
		}			
		
	function select_screen(val) {
	//document.Form1.report_but.disabled=true;
		document.Form1.Hid_but_type.value = val;
		if(val=="ADD"){
				document.getElementById('div_lable').innerHTML='Rebates - Add';   //added by Prabash on 24-11-2011
				document.Form1.save_but.disabled=false; 
			    document.getElementById('div_help_rs').style.display = 'none';
			    document.getElementById('div_help_ref').style.display = 'inline';	
		 }
		else if(val=="MOD"){
				document.getElementById('div_lable').innerHTML='Rebates - Edit'; //added by Prabash on 24-11-2011
		        document.Form1.save_but.disabled=false;
			    document.getElementById('div_help_rs').style.display = 'inline';
			    document.getElementById('div_help_ref').style.display = 'none';	
			 
				
		}else if(val=="DEL"){
				document.getElementById('div_lable').innerHTML='Rebates - Delete'; //added by Prabash on 24-11-2011
				document.Form1.Text_help_ref.disabled=true;
			    document.Form1.save_but.disabled=false; //2011-11-15
			    document.getElementById('div_help_rs').style.display = 'inline';
			    document.getElementById('div_help_ref').style.display = 'none';	
			
		}else if(val=="INQUIRY"){
		        document.getElementById('div_lable').innerHTML='Rebates - Enquiry'; 
			    enquiry();
		}
	
	} 
		
		
function rollover_details_pop(obj_dealnum){
	var m_dealnum="";
	
	if(obj_dealnum.substring(0,2)=="RF"){	
	
		m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmrepo?chksql=confirm_details_repo&m_identity=REPOFRESH&deal_num="+obj_dealnum;
  	 }
    else if(obj_dealnum.substring(0,2)=="RR"){	
		
		m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmrepo?chksql=confirm_details_rollover&m_identity=REPOROLLOVER&deal_num="+obj_dealnum;
  	 }
	else if(obj_dealnum.substring(0,2)=="RS"){		
		m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmrepo_setlle?chksql=confirm_details_reposettle&m_identity=REPOSETTLEMENT&deal_num="+obj_dealnum;
	}
	pop_up_message(m_url);
	//popupwin = window.open(m_url,'displayWindow2','left=50,top=50,width=500,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
    //popupwin.focus();
  }  

  $(document).ready(function() 
				{
					initCal('VAL_TXT_DATE');
					initCal('VAL_TXT_DATE_2');
					initCal('VAL_TXT_REBATES_DATE_2');
					initDrillDownDialog();
					//initmsgDrillDialog();
					//initmsgDrillDialog();
					m_grid_height = ($(window).height() - 310);
					m_grid_width = ($(window).width() - 0);
					//bind_events();
				});	
		
	function initDrillDownDialog(){
				$('#DIV_MSG_WINDOW').dialog({
						bgiframe: true,
						autoOpen: false,
						modal: false,
						height: 500,
						width: getW
					});
				$('#DIV_DRILL_DOWN_2').dialog({
						bgiframe: true,
						autoOpen: false,
						modal: false,
						height: 500,
						width: getW
					});
			}	
			
			function pop_up_message(m_url){					
				if ($("#DIV_MSG_WINDOW").dialog("isOpen")) 
				{
					$("#DIV_MSG_WINDOW").dialog("close");
				}
				$("#DIV_MSG_WINDOW").dialog("option", "title", "Details");
				$("#DIV_MSG_WINDOW").dialog("open");
				$("#IFRAME_MSG_WINDOW").attr("src",m_url);
				//alert(m_url);
				return false;
				
			}
		
			
			
			function hide_image(){
				$("#DIV_MSG_WINDOW").dialog("close");
			}
			
			
			function getW() {
				var w = 0;
				if (window.document.innerWidth > w) {
					w = window.document.innerWidth;
				}
				if (window.document.documentElement.clientWidth > w) {
					w = window.document.documentElement.clientWidth;
				}
				return (w - 100);
			}
			
			function clearIsOpen()
			{ 
				isOpen=false; 
			}
			
			var isOpen=false;
			
			function initmsgDrillDialog()
			{
				
				$("#DIV_MSG_WINDOW").dialog(
					
					{
						
						bgiframe: true,
						autoOpen: false,
						//modal: false,
						modal: true, //to disable the back ground	
						height: 300,
						width: getW,
						close: function() 
						{
							
						}
					}
				);
			}	
		
	function clearAll(){
	top.frames[1].location.href='dn_rebates.jsp'
	}	
		
	function enquiry(){
		
		document.Form1.save_but.disabled = true;
		document.Form1.Text_deal_ref.disabled =false;
		
		var m_deal_no=prompt("Please enter Deal Reference ","");
		if (m_deal_no!=null && m_deal_no!=""){
			document.Form1.Text_deal_ref.value=m_deal_no;	
		}
       	dealrefrs_help(0);
		}	
	
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
               if (instance_id == "VAL_TXT_DATE") {
                   document.Form1.Text_chq_date1.value = splitResult[0];
                   document.Form1.Text_chq_month1.value = splitResult[1];
                   document.Form1.Text_chq_year1.value = splitResult[2];
                   document.Form1.Text_chq_year1.focus();
               }
			  if (instance_id == "VAL_TXT_DATE_2") {
                   document.Form1.Text_new_date1.value = splitResult[0];
                   document.Form1.Text_new_month1.value = splitResult[1];
                   document.Form1.Text_new_year1.value = splitResult[2];
                   document.Form1.Text_new_year1.focus();
               }
			 if (instance_id == "VAL_TXT_REBATES_DATE_2") {
                   document.Form1.Text_rebates_new_date1.value  = splitResult[0];
                   document.Form1.Text_rebates_new_month1.value = splitResult[1];
                   document.Form1.Text_rebates_new_year1.value  = splitResult[2];
                   document.Form1.Text_rebates_new_year1.focus();
               }
		}		
	</SCRIPT>
	
	<BODY class='body & txt-body'  onload="select_screen('ADD');load_frame();document.Form1.SEL_REBATES_MODES.options[0].selected=true;get_user();change_type();">
		<FORM  NAME="Form1" ID="Form1" METHOD="POST" >			
			<INPUT TYPE="Hidden" NAME="SCR_NAME"	VALUE="MAIN" >
			<INPUT TYPE="Hidden" NAME="hid_help_type">	
			<INPUT TYPE="Hidden" NAME="hid_eff_validate">	
			<INPUT TYPE="Hidden" NAME="Text_basis_code">	
			<INPUT TYPE="Hidden" NAME="Text_interest">	
			<INPUT TYPE="Hidden" NAME="Hid_but_type">	
			<INPUT TYPE="Hidden" NAME="Hid_PRI_DEAL_no">	
			
				<DIV>
				<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
					<tr>
						<td height='7'></td>
					</tr>
					
					<tr height='30' >
						<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
						<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Margin Trading - Data Entry</B></td>
						<td width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>
						
					</tr>
					
					
				</TABLE>	
				
			</DIV>
			<!--------------------------------------------------------------->
			<table class='table' border='1' cellpadding='0' cellspacing='0' width='100%'> 
				<tr>
					<td height='1'></td>
				</tr>
				<tr>				
					
					<!-------------------------------------------------------------------->
					
					
					<TABLE WIDTH="100%" BGCOLOR="darkblue" >
						<TR >
							
							<TD WIDTH="6%">	
							<INPUT TYPE="Button" NAME="NEW" VALUE="Add"   onClick="select_screen('ADD');"  class="mainbut"  >
							</TD>
							
							<!--<TD WIDTH="6%">	
								<INPUT TYPE="Button" NAME="MOD" VALUE="Edit"   onClick="select_screen('MOD');" class="mainbut"  >
							</TD>-->
							<TD WIDTH="6%">	
								<INPUT TYPE="Button" style="width:80px" NAME="INQ" VALUE="Inquiry"   onClick="select_screen('INQUIRY');"  class="mainbut"  >
							</TD>
							
							<TD WIDTH="6%">	
								<INPUT TYPE="Button" NAME="REA" style="width:80px"  VALUE="Delete"   onClick="select_screen('DEL');"  class="mainbut"  >
							</TD>
							<TD WIDTH='6%'>&nbsp;&nbsp;&nbsp;&nbsp;</TD>		
							<TD WIDTH='6%'>&nbsp;&nbsp;&nbsp;&nbsp;</TD>	
							<!---------------------------------->
							<TD WIDTH="6%">	
								<INPUT TYPE="Button" NAME="save_but" VALUE="Save"   onClick="beforesubmit()" class="mainbut"  >
							</TD>
							
							<TD WIDTH="6%">
								<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"   onClick="clearAll()" class="mainbut"> 
							</TD>
							<TD WIDTH="6%">
								<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit"   onClick="top.frames[1].location.href='low.jsp'" class="mainbut"> 
							</TD>
							
							<TD  WIDTH="50%" class="hh1" align="right">
								<B><DIV id="div_lable">Rebates</DIV> </B>
							</TD>					
						</TR>
					</TABLE>
					
					
					<!----------->
					
					<TABLE WIDTH="100%"  >
						<tr ></tr>
					</TABLE>
					<HR>
					<TABLE WIDTH="100%"  >
						<tr ></tr>
					</TABLE>
					
					<BR>
			
			
			
			<TABLE WidTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" >							
				<TD WidTH="1%">
					<TD WidTH="99%">
						<TABLE WIDTH="100%"BORDER="-1" CELLPADDING="0" CELLSPACING="0" >
							<TD WIDTH="1%"></TD>
							<TD  WIDTH="30%" >Deal Reference </TD>
							<TD WIDTH="20%" ><INPUT TYPE="Text" NAME="Text_deal_ref" ID="Text_deal_ref"	ALIGN="LEFT" SIZE="20" ONBLUR="chk_deadref(document.Form1.Text_deal_ref)" class='txt_input6' ></TD>
							<TD WIDTH="10%" ALIGN="CENTER"><DIV id="div_help_ref"><INPUT TYPE="BUTTON" NAME="Text_help_ref" onClick="dealrefrs_help(0)"  VALUE="Help" class='but_input' ></DIV><DIV id="div_help_rs"><INPUT TYPE="BUTTON" NAME="Text_help_RS"  VALUE="RS-Help" ONCLICK="deal_ref_help(0)" class='but_input' ></DIV></TD>	
							<TD WIDTH="10%" ALIGN="CENTER"><!--<INPUT TYPE="BUTTON" NAME="Text_help_rollover" onClick="dealref_help(2)"  VALUE="RR-Help" class='but_input' >--></TD>	
							<TD WIDTH="10%" ALIGN="CENTER"></TD>	
							<TD WIDTH="10%" ALIGN="CENTER"><INPUT TYPE="BUTTON" NAME="Text_status"   VALUE="Details" ONCLICK="rollover_details_pop(document.Form1.Text_deal_ref.value)" class='but_input' ></TD>	
						</TR>
						<TR></TR>	
					</TABLE>  
					
					
					
					<TABLE WidTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" >							
						<TD WidTH="1%">
							<TD WidTH="99%">
								
								
								<HR WIDTH="*%">
								<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" >
									<TR>
										<TD><B><U>Borrower Information</B></TD>
											<TD></TD>
											<TD><B><U>Lender Information</B></TD>
												<TD></TD>
											</TR>
											<TR>
												<TD WIDTH="20%">Borrower Code</TD>
												<TD WIDTH="30%"><INPUT TYPE="Text" NAME="TXT_BCODE" ALIGN="LEFT" SIZE=22 MAXLENGTH=10  class="txt_input6" >
													<INPUT TYPE="button" VALUE="Help" NAME="BUT_BCODE"  DISABLED  class='but_input' ></TD>
												<TD WIDTH="20%">Lender Code</TD>
												<TD WIDTH="30%"><INPUT TYPE="Text" NAME="TXT_LCODE" ALIGN="LEFT" SIZE=22 MAXLENGTH=10  class="txt_input6" >
													<INPUT TYPE="button" VALUE="Help" NAME="BUT_LCODE" DISABLED  class='but_input'></TD>
											</TR>
											<TR>
												<TD>Borrower Name</TD>
												<TD><INPUT TYPE="Text" NAME="TXT_BNAME"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10 class="txt_input6" ></TD>
												<TD>Lender Name</TD>
												<TD><INPUT TYPE="Text" NAME="TXT_LNAME"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10 class="txt_input6" ></TD>
											</TR>
										</TABLE>
										<HR WIDTH="*%">	
										
										
										
										<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" >
											<TR><B><U>Settlement Amount Information</B></TR>
												<TR>
													<TD WIDTH="20%"></TD>
													<TD WIDTH="30%"></TD>
													<TD WIDTH="20%"></TD>
													<TD WIDTH="30%"></TD>
												</TR>
												<TR>
													<TD>Currency</TD>
													<TD><INPUT TYPE="Text" NAME="TXT_CURR" ALIGN="LEFT" SIZE=15 MAXLENGTH=10 class="txt_input6" ></TD>
													
												</TR>
												
												<TR>
													<TD>Settlement Date</TD>
													<TD><INPUT
															TYPE="Text" NAME="Text_chq_date1"  SIZE=3 MAXLENGTH=2 TABINDEX=-1 class="txt_input5" DISABLED ><INPUT
															TYPE="Text" NAME="Text_chq_month1" SIZE=3 MAXLENGTH=2 TABINDEX=-1 class="txt_input5" DISABLED ><INPUT
															TYPE="Text" NAME="Text_chq_year1" SIZE=5 MAXLENGTH=4 TABINDEX=-1 class="txt_input5"  DISABLED ><input type = "hidden" name = "VAL_TXT_DATE" id = "VAL_TXT_DATE" DISABLED/>	</TD>
													      
															<TD>Tenor</TD>
													<TD><INPUT
															TYPE="Text" NAME="Text_Tenor"  SIZE=10 MAXLENGTH=4 DISABLED class="txt_input6" ></TD>
												</TR>
												<TR>
													<TD>Payment to Lender</TD>
													<TD><INPUT TYPE="Text" NAME="TXT_TENOR"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10 DISABLED class="txt_input6"></TD>
													<TD>Yield</TD>
													<TD><INPUT
															TYPE="Text" NAME="Text_Yield"  SIZE=10 MAXLENGTH=4 DISABLED class="txt_input6" ></TD>
												</TR>
												
												<TR>
													<TD>Leg 1</TD>
													<TD><INPUT TYPE="Text" NAME="TXT_leg1"	ALIGN="LEFT" SIZE=28 DISABLED class="txt_input6" ></TD>
													<TD>Leg 2</TD>
													<TD><INPUT TYPE="Text" NAME="Text_leg2"  SIZE=28 DISABLED class="txt_input6" ></TD>
												</TR>
												
											</TABLE>
											<HR WIDTH="*%">
											
											
											<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" >
												<TR><B><U>Pre Settlement Information</B></TR>
													<TR>	
														<TD WIDTH="20%"></TD>
														<TD WIDTH="30%"></TD>
														<TD WIDTH="20%"></TD>
														<TD WIDTH="30%"></TD>
													</TR>
													<!--<TR>
														<TD>Number of Modes</TD>
														<TD><SELECT NAME="SEL_MODES" ONCHANGE="nextline()" DISABLED>
																<OPTION VALUE="1" SELECTED>1</option>  
																<OPTION VALUE="2" >2</option>  
																<OPTION VALUE="3" >3</option>  
																<OPTION VALUE="4" >4</option>  
																<OPTION VALUE="5" >5</option>  
																<OPTION VALUE="6" >6</option>  
																<OPTION VALUE="7" >7</option>  
																<OPTION VALUE="8" >8</option>  
																<OPTION VALUE="9" >9</option>  
																<OPTION VALUE="10">10</option>
															</SELECT>
														</TD>	
														<TD></TD>
														<TD></TD>
													</TR>-->
													<TR>
														<TD>Settlement Mode 1</TD>
														<TD>
															<SELECT NAME="SEL_SETTLE1" class="txt_input6" disabled >
																<OPTION VALUE="BANK_TRANF" SELECTED >Bank Transfer</option> 
															    <OPTION VALUE="CURR_ACC" >Margin Trading Account</option><!-- Netting Account-->
																<OPTION VALUE="CB_CHEQUE" >Central Bank Cheque</option>  
																<OPTION VALUE="CHEQUE" >Cheque</option>  
																<OPTION VALUE="CASH" >Cash</option>  
															</SELECT>
														</TD>						
														<TD>Settlement Amount</TD>
														<TD><INPUT TYPE="Text" NAME="TXT_SETAMO1" ALIGN="LEFT" SIZE=28 MAXLENGTH=15 ONBLUR="calculate_tot();setformat()" DISABLED class="txt_input6" ></TD>
													</TR>
												</TABLE>
												<DIV ID=othername1></DIV>
												<DIV ID=total></DIV>
												
												
												<DIV ID=othername2></DIV>
												
												
												
												<!--<TABLE WIDTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0" >	
													<TD WIDTH="20%">Comments</TD>
													<TD WIDTH="30%"><TEXTAREA NAME="SEL_COMM1" COLS = "18" ROWS = "2" class="txt_input6" ></TEXTAREA>
													</TD>		    
													<TD WIDTH="20%">Comments</TD>
													<TD WIDTH="30%"><TEXTAREA NAME="SEL_COMM2" COLS = "18" ROWS = "2" class="txt_input6" ></TEXTAREA>
													</TD>		    
												</TR>			                
													</TABLE>-->
											<!--<HR WIDTH="*%">-->
										</TD>	
									</TR>
									<TR>
										<TD></TD>
										<TD>
											<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" >	
												
												<TR>
													<TD  WIDTH="20%">Settlement Date</TD>
													<TD WIDTH="30%"><INPUT
															TYPE="Text" NAME="Text_new_date1"  SIZE=3 MAXLENGTH=2 ONBLUR="check_date()" class="txt_input5"  disabled>
															<INPUT TYPE="Text" NAME="Text_new_month1" SIZE=3 MAXLENGTH=2 ONBLUR="check_date()" class="txt_input5" disabled>
															<INPUT TYPE="Text" NAME="Text_new_year1" SIZE=5 MAXLENGTH=4 ONBLUR="check_date()" class="txt_input5" disabled ><input type = "hidden" name = "VAL_TXT_DATE_2" id = "VAL_TXT_DATE_2" /></TD>
															
													<TD  WIDTH="20%">Tenor</TD>
													<TD WIDTH="30%"><INPUT
															TYPE="Text" NAME="Text_new_Tenor"  SIZE=28 disabled class="txt_input6" ></TD>
												</TR>
												<TR>
													<TD>Markup</TD>
													<TD><INPUT TYPE="Text" NAME="Text_new_yield"	ALIGN="LEFT" SIZE=19 ONCHANGE="format_yield(document.Form1.Text_new_yield,document.Form1.TXT_leg1)" class="txt_input6" disabled ></TD>
													<TD>Settlement</TD>
													<TD><INPUT TYPE="Text" NAME="Text_new_leg2"  SIZE=28  disabled></TD>
												</TR>
												
												
												
													</TABLE>
													
										<!------------------------------------------------------  Rebate ------------------------>
												<HR WIDTH="*%">
											
											
											<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" >
												<TR><B><U>Rebate Information</B></TR>
													<TR>	
														<TD WIDTH="20%"></TD>
														<TD WIDTH="30%"></TD>
														<TD WIDTH="20%"></TD>
														<TD WIDTH="30%"></TD>
													</TR>
													<TR>
														<TD>Number of Modes</TD>
														<TD><SELECT NAME="SEL_REBATES_MODES" ONCHANGE="nextline()" DISABLED>
																<OPTION VALUE="1" SELECTED>1</option>  
																<OPTION VALUE="2" >2</option>  
																<OPTION VALUE="3" >3</option>  
																<OPTION VALUE="4" >4</option>  
																<OPTION VALUE="5" >5</option>  
																<OPTION VALUE="6" >6</option>  
																<OPTION VALUE="7" >7</option>  
																<OPTION VALUE="8" >8</option>  
																<OPTION VALUE="9" >9</option>  
																<OPTION VALUE="10">10</option>
															</SELECT>
														</TD>	
														<TD></TD>
														<TD></TD>
													</TR>
													<TR>
														<TD>Settlement Mode 1</TD>
														<TD>
															<SELECT NAME="SEL_REBATES_SETTLE1" class="txt_input6" >
																<OPTION VALUE="BANK_TRANF" SELECTED >Bank Transfer</option>  
															    <OPTION VALUE="CURR_ACC" >Margin Trading Account</option><!-- Netting Account-->
																<OPTION VALUE="CB_CHEQUE" >Central Bank Cheque</option>  
																<OPTION VALUE="CHEQUE" >Cheque</option>  
																<OPTION VALUE="CASH"  >Cash</option>  
															</SELECT>
														</TD>						
														<TD>Settled Amount</TD>
														<TD><INPUT TYPE="Text" NAME="TXT_REBATES_SETAMO1" ALIGN="LEFT" SIZE=28 MAXLENGTH=15 ONBLUR="calculate_tot();setformat()" DISABLED class="txt_input6" ></TD>
													</TR>
												</TABLE>
												<DIV ID=othername1></DIV>
												<DIV ID=total></DIV>
												
												
												<DIV ID=othername2></DIV>
												
												
												
												<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" >	
													<TD WIDTH="20%">Comments</TD>
													<TD WIDTH="30%"><TEXTAREA NAME="SEL_REBATES_COMM1" COLS = "18" ROWS = "2" class="txt_input6" ></TEXTAREA>
													</TD>		    
													<TD WIDTH="20%">Comments</TD>
													<TD WIDTH="30%"><TEXTAREA NAME="SEL_REBATES_COMM2" COLS = "18" ROWS = "2" class="txt_input6" ></TEXTAREA>
													</TD>		    
												</TR>			                
											</TABLE>
											<HR WIDTH="*%">
										</TD>	
									</TR>
									<TR>
										<TD></TD>
										<TD>
											<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" >	
												
												<TR>
													<TD  WIDTH="20%">Rebate Date</TD>
													<TD WIDTH="30%"><INPUT
															TYPE="Text" NAME="Text_rebates_new_date1"  SIZE=3 MAXLENGTH=2 ONBLUR="check_rebates_date()" class="txt_input5" disabled >
															<INPUT TYPE="Text" NAME="Text_rebates_new_month1" SIZE=3 MAXLENGTH=2 ONBLUR="check_rebates_date()" class="txt_input5" disabled >
															<INPUT TYPE="Text" NAME="Text_rebates_new_year1" SIZE=5 MAXLENGTH=4 ONBLUR="check_rebates_date()" class="txt_input5" disabled ><input type = "hidden" name = "VAL_TXT_REBATES_DATE_2" id = "VAL_TXT_REBATES_DATE_2" disabled /></TD>
															
													<TD  WIDTH="20%">Tenor</TD>
													<TD WIDTH="30%"><INPUT
															TYPE="Text" NAME="Text_rebates_new_Tenor"  SIZE=28 disabled class="txt_input6" ></TD>
												</TR>
												<TR>
													<TD>Rebate Markup</TD>
													<TD><INPUT TYPE="Text" NAME="Text_rebates_new_yield" ALIGN="LEFT" SIZE=19 ONCHANGE="format_rebates_yield(document.Form1.Text_rebates_new_yield)" class="txt_input6" ></TD>
													<TD>Rebate Amount</TD>
													<TD><INPUT TYPE="Text" NAME="Text_rebates_new_leg2"  SIZE=28  ></TD>
												</TR>
												
												
												
													</TABLE>	
										<!-------------------------------------------------------    ------------------------>			
													
										</TD>
									</TD>			                
								</TABLE>
								
							</TD>
							
							
						</TD>
					</TABLE> 
					
				</FORM>
						
				<div id ="DIV_MSG_WINDOW" title ="Details">
							<iframe id ="IFRAME_MSG_WINDOW" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Day End Routine">
							</iframe>
						</div>		
			  </BODY>
			<DIV>
				<script language="JavaScript1.2" src="validate.js"></SCRIPT>
				<script language="JavaScript1.2" src="repo_rollover.js"></SCRIPT>
				<SCRIPT language1.2="JavaScript" src="Deal_confirm.js"></SCRIPT>
				<SCRIPT language="JavaScript" type='text/javascript' SRC="ajax_data_gateway.js"></SCRIPT>		
			</DIV>
		</HTML>
		
