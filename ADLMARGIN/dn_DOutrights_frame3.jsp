<!--
<HTML>
<HEAD>
<TITLE>DealNet 
</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="mbfsl.css" />
<STYLE>
BODY 								{ background-color: silver;color: black; font: 10pt 
arial; }
LI 									{ cursor: hand; }
UL 									{ display: none;font: 18pt; }
UL.showList					{ display: block; }
.defaultStyles UL		{ color: gold; }
UL.defaultStyles LI	{ display: none; }
</STYLE>
</HEAD>.
-->
<%@page import="net.sasianet.ADLMARGIN.*" %>
<SCRIPT language="JavaScript">
	<% ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
	//***************  ADDED BY KANISHKA ON 26/12/2012  *********************//
	
		Object done = (String)session.getValue("logon.isDone");  // marker object
		if (done == null) {
			response.sendRedirect("login.jsp");
			return;
			}
	
	//*************** ADDED BY KANISHKA ON 26/12/2012 [END]  *********************//%>
	var username = '<%= m_sn_methods.username %>';
	i=1;
	j=1;
	
	function enable_inputs1() {
		for (var i = 0; i< document.Form1.elements.length; i++) {
			document.Form1.elements[i].disabled = false;
			
		}
	}
	
	function enable_inputs2() {
		for (var i = 0; i< document.Form1.elements.length; i++) {
			document.Form1.elements[i].disabled = false;
		}
	}
	
	
	function disable_inputs() {
		for (var i = 0; i< document.Form1.elements.length; i++) {
			document.Form1.elements[i].disabled = true;
		}
	}	
	
	
	
	function chk_deadref(obj) {
		if (obj.value=="") {
			alert('Please enter a Deal Reference No');
			obj.value=""
				obj.focus();
		}
		else {
			m_postcode=obj.value;
			document.Form1.HID_DEALREF.value=obj.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?deal_code="+m_postcode+"&chksql=outchkdeal";
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
			if (m_size==0) {
				if (confirm("Invalid Deal Reference No..Press the OK button if you want a list of Deal Reference Numbers or Press the Cancel button to type again")) {
					dealref_help(0);
				} 
				else{
					document.Form1.Text_deal_ref.focus();
				}   
			}
			else {
				m_dealcode=obj.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?outref_code="+m_dealcode+"&chksql=outdealinfo1";
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				load_interface(m_url,'XML',false);
				m_size=data_vec.length;
				
				
				
				document.Form1.TXT_BCODE.value=data_vec[1];
				document.Form1.TXT_BNAME.value=data_vec[2];
				document.Form1.TXT_SCODE.value=data_vec[3];
				document.Form1.TXT_SNAME.value=data_vec[4];
				document.Form1.TXT_INSTYPE.value=data_vec[5];
				document.Form1.TXT_SECIDEN.value=data_vec[6];
				if(data_vec[7]!='@@'){
					document.Form1.TXT_ENCODE.value=data_vec[7];
				}
				
				date_objfprev();
				
				
				if(data_vec[23]!='@@'){
					document.Form1.TXT_GUCODE.value=data_vec[23];
					document.Form1.TXT_GUNAME.value=data_vec[24];
				}
				if(data_vec[25]!='@@'){
					document.Form1.TXT_ENNAME.value=data_vec[25];
				}
				document.Form1.TXT_ISSURE.value=data_vec[21];
				
				document.Form1.TXT_ISSCODE.value=data_vec[21];
				document.Form1.TXT_ISSNAME.value=data_vec[22];
				
				if(data_vec[25]!='@@'){
					document.Form1.TXT_ENNAME.value=data_vec[25];
				}
				
				document.Form1.TXT_ISSURE.value=data_vec[21];
				document.Form1.TXT_SECCODE.value=data_vec[6];
				document.Form1.TXT_INSTYPE.value=data_vec[5];
				
				document.Form1.HID_MATURITY_DATE.value=data_vec[26]+'/'+data_vec[27]+'/'+data_vec[28];		
				
				
				if (data_vec[32]  ==  "EQUITY")
				{
					
					
					
					document.Form1.TXT_DATE1.value  = data_vec[10];
					document.Form1.TXT_MONTH1.value = data_vec[11];
					document.Form1.TXT_YEAR1.value  = data_vec[12];
					document.Form1.TXT_CLEAN1.value =data_vec[14];
					document.Form1.TXT_FACEVAL1.value =format_noobject(data_vec[17]);
					
					//document.Form1.TXT_TOT_COST.value =format_noobject(data_vec[17]);
					//document.Form1.TXT_PAR.value =format_noobject(data_vec[17]);
					document.Form1.TXT_NOMINAL.value =format_noobject(data_vec[29]);
					
					document.Form1.TXT_BROKER_COST.value =format_noobject(data_vec[31]);
					document.Form1.TXT_PURCH_COST.value =format_noobject(data_vec[30]);
					
					
					
					
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?msec="+document.Form1.TXT_SECIDEN.value+"&chksql=getpar";
					//top.frames[0].document.applets[0].getdata(m_url);
					//m_size=top.frames[0].document.applets[0].outvec_value.size();
					load_interface(m_url,'XML',false);
					m_size=data_vec.length;
					document.Form1.TXT_PAR.value =format_noobject(data_vec[0]);
					//get_total()
					
					
					broker=unformat_noobject(document.Form1.TXT_BROKER_COST.value);	
					pur=unformat_noobject(document.Form1.TXT_PURCH_COST.value);	
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_broker="+broker+"&m_cost="+pur+"&chksql=get_total&m_seller="+document.Form1.TXT_SCODE.value+"&m_buyer="+document.Form1.TXT_BCODE.value;					
					//top.frames[0].document.applets[0].getdata(m_url);			
					load_interface(m_url,'XML',false);
					m_size=data_vec.length;
					document.Form1.TXT_TOT_COST.value   =format_noobject(data_vec[0]);
					
					document.Form1.TXT_TOTVAL.value=document.Form1.TXT_TOT_COST.value;					
					document.Form1.TXT_SETAMO1.value=document.Form1.TXT_TOT_COST.value;
					
					
					document.Form1.TXT_FACEVAL.disabled=true;
					document.Form1.TXT_COST.disabled=true;
					document.Form1.BUT_CURR.disabled=true;
					document.Form1.BUT_BASIS.disabled=true;
					document.Form1.TXT_CURR.disabled=true;
					document.Form1.TXT_CLEAN.disabled=true;
					document.Form1.TXT_DIRTY.disabled=true;
					document.Form1.TXT_ACCINT.disabled=true;
					document.Form1.TXT_SETVAL.disabled=true;
					document.Form1.TXT_BASIS.disabled=true;
					document.Form1.TXT_DATE.disabled=true;
					document.Form1.TXT_MONTH.disabled=true;
					document.Form1.TXT_YEAR.disabled=true;
					document.Form1.TXT_YIELD.disabled=true;
					document.Form1.TXT_CLEAN.disabled=true;
					document.Form1.TXT_DIRTY.disabled=true;
					//document.Form1.cust_stat.disabled=true;
					//document.Form1.SEL_DATETYPE.disabled=true;
					get_settle_dates();
					
					
				}
				
				else if (data_vec[32]  ==  "DEBT" )
				{
					
					document.Form1.TXT_CURR.value=data_vec[8];
					document.Form1.TXT_DATE.value=data_vec[10];
					document.Form1.TXT_MONTH.value=data_vec[11];
					document.Form1.TXT_YEAR.value=data_vec[12];
					document.Form1.TXT_CLEAN.value=data_vec[14];
					document.Form1.TXT_DIRTY.value=format_noobject0(data_vec[15],4);
					document.Form1.TXT_YIELD.value=data_vec[16];
					document.Form1.TXT_FACEVAL.value=format_noobject(data_vec[17]);
					document.Form1.TXT_COST.value=format_noobject(data_vec[18]);
					document.Form1.TXT_ACCINT.value=format_noobject(data_vec[19]);
					document.Form1.TXT_SETVAL.value=format_noobject(data_vec[20]);	
					document.Form1.TXT_TOTVAL.value=format_noobject(data_vec[17]);
					
					m_basis=data_vec[13]; 
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?chksql=basis2&basis_desc="+m_basis+"";
					//top.frames[0].document.applets[0].getdata(m_url);
					//m_size=top.frames[0].document.applets[0].outvec_value.size();
					load_interface(m_url,'XML',false);
					m_size=data_vec.length;
					document.Form1.TXT_BASIS.value=data_vec[1];
					buyercode2(document.Form1.TXT_SCODE,document.Form1.TXT_SNAME);
					
					
					document.Form1.TXT_DATE1.disabled=true;
					document.Form1.TXT_MONTH1.disabled=true;
					document.Form1.TXT_YEAR1.disabled=true;
					document.Form1.TXT_PURCH_COST.disabled=true;
					document.Form1.SEL_BROKER.disabled=true;
					document.Form1.TXT_CLEAN1.disabled=true;
					document.Form1.TXT_BROKER_COST.disabled=true;
					document.Form1.TXT_FACEVAL1.disabled=true;
					document.Form1.TXT_TOT_COST.disabled=true;
					document.Form1.TXT_PAR.disabled=true;
					document.Form1.TXT_NOMINAL.disabled=true;
					document.Form1.TXT_BDATE.disabled=true;
					document.Form1.TXT_BMONTH.disabled=true;
					document.Form1.TXT_BYEAR.disabled=true;
					
					document.Form1.TXT_SDATE.disabled=true;
					document.Form1.TXT_SMONTH.disabled=true;
					document.Form1.TXT_SYEAR.disabled=true;
				}
				datapart2();
				
				
			}
		}    	   
	}
	
	
	/*
	function dealref_help() {
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?chksql=outdeal_lookup";
		//top.frames[0].document.applets[0].getdata(m_url);
		//alert(top.frames[0].document.applets[0].outvec_value);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		vec_pos=0;
		lineno=1;
		m_row="";
		while (vec_pos<m_size) {
			m_dealref=data_vec[vec_pos];
			m_borrcode=data_vec[vec_pos+1];
			m_lendref=data_vec[vec_pos+2];
			m_valdate=data_vec[vec_pos+3];
			m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+lineno+'><B>'+m_dealref+'</B></TD><TD ID=C2R'+lineno+'><B>'+m_borrcode+'</B></TD><TD ID=C2R'+lineno+'><B>'+m_lendref+'</B></TD><TD ID=C2R'+lineno+'><B>'+m_valdate+'</B></TD></TR>';
			vec_pos=vec_pos+4;
			lineno=lineno+1;
		}
		m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" >'+
			'<TR BGCOLOR="darkblue"><TD WIDTH="28%"><B>Deal No</B></TD>' +
			'<TD WIDTH="20%"><B>Buyer Code</B></TD><TD WIDTH="20%"><B>Seller Code</B></TD><TD WIDTH="32%"><B>Value Date</B></TD></TR>'+
			m_row+
			'</TABLE>'; 
		myDialogObj.htmlstr = m_writedata;
		myDialogObj.returnval = "";
		popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:25em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		document.Form1.Text_deal_ref.value=myDialogObj.returnval;
		document.Form1.Text_deal_ref.focus();
		
	}	
	
	
	*/
	
	function dealref_help(m_strat){
		var aForm;    //  aForm =oForm.elements;
		aForm =  document.getElementById('Form1');
		
		
		var myObject=new Array(); //return values set to this object
		myObject[0]=aForm.Text_deal_ref;
		myObject[1]=null;
		myObject[2]=null;
		myObject[3]=null;
		myObject[4]=null;
		
		var myObject_value=new Array(); //passing values set to this object
		myObject_value[0]=username;
		myObject_value[1]=username;//aForm.oLastName2.value;
		myObject_value[2]=null;
		myObject_value[3]=null;
		myObject_value[4]=null;
		
		
		var myObject_type=new Array(); //passing values data type
		myObject_type[0]="String";
		myObject_type[1]="String";
		myObject_type[2]=null;
		myObject_type[3]=null;
		myObject_type[4]=null;
		
		var qid='120';
		
		title_name='Deal Code';
		var url = 'popup.jsp';
		var close_fun='dealref_help_close';			
		var json_text = JSON.stringify(myObject_value, null,0);
		var json_obj_type_text=JSON.stringify(myObject_type, null,0);
		var fn_name=arguments.callee.name;
		if(fn_name==undefined){
			re = /^function\s+([^(]+)/;
			fn_name=re.exec(arguments.callee.toString())[1];
		} 
		
		$.showModalDialog({
				url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
				dialogArguments: myObject_value,
				height:400,// 500,
				width: 500,//900,
				title: 'SasiNet Frame Work',
				scrollable: true,
				onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); 
					if(returnedValue == null){dealref_help_close();} 
					if(returnedValue != null){chk_deadref(document.Form1.Text_deal_ref);}
					
				} 
			});
		
		
	}
	
	function dealref_help_close(){
		document.Form1.Text_deal_ref.value = '';
	}
	
	
	function myDialogObj() {
		var htmlstr;
		var returnval;
	}
	
	
	function formatnum1(num1){
		num1.value=format_noobject(num1.value);
		document.Form1.TXT_COST.focus();
		document.Form1.HID_FACEVAL.value=unformat_noobject(num1.value);
		mm_pricec=unformat_noobject(document.Form1.TXT_CLEAN.value);
		mm_faceval=unformat_noobject(document.Form1.TXT_FACEVAL.value);
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_seccode="+document.Form1.TXT_SECIDEN.value+"&m_pricec="+mm_pricec+"&m_valuedate="+document.Form1.HID_VALDATETYPE.value+"&m_faceval="+mm_faceval+"&chksql=Ccla_threeval";
		//top.frames[0].document.applets[0].getdata(m_url);	
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		document.Form1.TXT_COST.value=data_vec[0];
		document.Form1.TXT_ACCINT.value=data_vec[1];
		document.Form1.TXT_SETVAL.value=data_vec[2];
		document.Form1.TXT_TOTVAL.value=document.Form1.TXT_FACEVAL.value;
		document.Form1.TXT_SETAMO1.value=document.Form1.TXT_SETVAL.value;
		document.Form1.HIDD_SETAMO1.value=document.Form1.TXT_SETVAL.value;
		document.Form1.HIDD_TXT_CURR.value=document.Form1.TXT_CURR.value;
	}
	
	function formatnum2(num2){
		num2.value=format_noobject(num2.value);
		document.Form1.TXT_ACCINT.focus();
		document.Form1.HID_COST.value=unformat_noobject(num2.value);
	}
	
	function formatnum3(num3){
		num3.value=format_noobject(num3.value);
		document.Form1.TXT_SETVAL.focus();
		document.Form1.HID_ACCINT.value=unformat_noobject(num3.value);
	}
	
	function formatnum4(num4){
		num4.value=format_noobject(num4.value);
		document.Form1.HID_SETVAL.value=unformat_noobject(num4.value);
	}
	
	function formatnum01(num5){
		num5.value=format_noobject0(num5.value);
		document.Form1.TXT_CLEAN.focus();
		document.Form1.HID_YIELD.value=unformat_noobject(num5.value);
		
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_yield="+document.Form1.HID_YIELD.value/100+"&m_valuedate="+document.Form1.HID_VALDATETYPE.value+"&m_security="+document.Form1.TXT_SECIDEN.value+"&chksql=c_d_fromyield";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		document.Form1.TXT_CLEAN.value=data_vec[1];
		document.Form1.TXT_DIRTY.value=data_vec[0];
		document.Form1.TXT_FACEVAL.focus();
	}
	
	
	function formatnum02(num6){
		num6.value=format_noobject0(num6.value);
		document.Form1.HID_CLEAN.value=unformat_noobject(num6.value);
		document.Form1.TXT_DIRTY.focus();
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_yield="+document.Form1.HID_YIELD.value+"&m_valuedate="+document.Form1.HID_VALDATETYPE.value+"&m_security="+document.Form1.TXT_SECIDEN.value+"&chksql=y_d_fromclean";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		document.Form1.TXT_CLEAN.value=data_vec[0];
		document.Form1.TXT_DIRTY.value=data_vec[1];
		
	}
	
	function formatnum03(num7){
		num7.value=format_noobject0(num7.value);
		document.Form1.TXT_FACEVAL.focus();
		document.Form1.HID_DIRTY.value=unformat_noobject(num7.value);
	}
	
	
	
	function chkstartdate(dayobj,monthobj,yearobj) {
		if (checkMonthLength(dayobj,monthobj,yearobj)) {
			document.Form1.HID_VALDATETYPE.value=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
			document.Form1.HID_DATE.value=dayobj.value;
			document.Form1.HID_MONTH.value=monthobj.value;
			document.Form1.HID_YEAR.value=yearobj.value;
		}
	}
	
	
	function chk_currency(curr_obj) {
		m_code=curr_obj.value; 
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fval_repofresh?chksql=currency&cur_code="+m_code+"";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		if(m_size==0)  {
			currency_help();
		}
	}
	
	function currency_help(){
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fval_repofresh?chksql=currency_lookup";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		vec_pos=0;
		m_row="";
		lineno=1;
		while (vec_pos<m_size) {
			m_cr_code=data_vec[vec_pos];
			m_cr_desc=data_vec[vec_pos+1];
			m_row=m_row+'<TR  ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_cr_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_cr_desc+'</B></TD></TR>';
			vec_pos=vec_pos+2;
			lineno=lineno+1;
		}
		m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" >'+
			'<TR BGCOLOR="darkblue"><TD WIDTH="30%"><B>Crrency Code</B></TD>' +
			'<TD WIDTH="70%"><B>Currency Description</B></TD></TR>'+
			m_row+
			'</TABLE>'; 
		myDialogObj.htmlstr = m_writedata;
		myDialogObj.returnval = "";
		
		popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		document.Form1.TXT_CURR.value=myDialogObj.returnval;
		document.Form1.TXT_CURR.focus();
	}
	
	function basis_help(){
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fval_repofresh?chksql=basis_lookup";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		vec_pos=0;
		m_row="";
		lineno=1;
		while (vec_pos<m_size) {
			m_basis_code=data_vec[vec_pos];
			m_basis_desc=data_vec[vec_pos+1];
			m_row=m_row+'<TR  ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C2R'+lineno+');><TD ID=C1R'+lineno+'><B>'+m_basis_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_basis_desc+'</B></TD></TR>';
			vec_pos=vec_pos+2;
			lineno=lineno+1;
		}
		m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" >'+
			'<TR BGCOLOR="darkblue"><TD WIDTH="50%"><B>Interest Base Code</B></TD>' +
			'<TD WIDTH="50%"><B> Description</B></TD></TR>'+
			m_row+
			'</TABLE>'; 
		myDialogObj.htmlstr = m_writedata;
		myDialogObj.returnval = "";
		1
		popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		document.Form1.TXT_BASIS.value=myDialogObj.returnval;
		document.Form1.TXT_BASIS.focus();
	}
	
	
	function chk_basis(obj_basis) {
		m_basis=obj_basis.value; 
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fval_repofresh?chksql=basis&basis_desc="+m_basis+"";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		if(m_size==0) {
			basis_help();
		}
	}
	
	
	function endcodex(endcode,value){
		if (value.value!="") {
			m_instype=endcode.value;
			m_end=value.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?end_code="+m_end.toUpperCase()+"&buyer_code="+m_instype.toUpperCase()+"&chksql=endcode1";
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
			if (m_size==0) {
				end_help(endcode);
				value.focus();
			}
			else{
				document.Form1.TXT_ENNAME.value=data_vec[1];
			}
		}
	}
	
	function end_help(obj1) {
		m_instype=obj1.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+m_instype.toUpperCase()+"&chksql=endcode";
		//top.frames[0].document.applets[0].getdata(m_url);
		//	m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		vec_pos=0;
		lineno=1;
		m_row="";
		while (vec_pos<m_size) {
			m_issu_code=data_vec[vec_pos];
			m_issu_name=data_vec[vec_pos+1];
			m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+'><B>'+m_issu_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_issu_name+'</B></TD></TR>';
			vec_pos=vec_pos+2;
			lineno=lineno+1;
		}
		m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" >'+
			'<TR BGCOLOR="darkblue"><TD WIDTH="30%"><B>Endorser Code</B></TD>' +
			'<TD WIDTH="70%"><B>Endorser Name</B></TD></TR>'+
			m_row+
			'</TABLE>'; 11
		myDialogObj.htmlstr = m_writedata;
		myDialogObj.returnval = "";
		
		popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		document.Form1.TXT_ENCODE.value=myDialogObj.returnval;
		document.Form1.TXT_ENCODE.focus();			
	}	
	
	
	function sectype(objz,objz1){
		if (objz.value=="") {
			sec_help(objz1);
			objz1.focus();
		}
		else {
			m_sectype=objz.value;
			m_secinst=objz1.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+m_sectype.toUpperCase()+"&inst_num="+m_secinst.toUpperCase()+"&chksql=chksec";
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
			if (m_size==0) {
				sec_help(objz1);
				objz1.focus();
			}
			else{
				document.Form1.TXT_ISSCODE.value=data_vec[2];
				document.Form1.TXT_GUCODE.value=data_vec[4];
				document.Form1.TXT_ISSNAME.value=data_vec[3];
				document.Form1.TXT_GUNAME.value=data_vec[5];
				document.Form1.TXT_SECCODE.value=document.Form1.TXT_SECIDEN.value;
				document.Form1.TXT_ISSURE.value=document.Form1.TXT_ISSCODE.value;
				document.Form1.TXT_ENCODE.focus();
			}
		}
	}
	
	function sec_help(obj1) {
		m_secinst=obj1.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?inst_num="+m_secinst.toUpperCase()+"&chksql=sec_lookup";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		vec_pos=0;
		lineno=1;
		m_row="";
		while (vec_pos<m_size) {
			m_issu_code=data_vec[vec_pos];
			m_issu_name=data_vec[vec_pos+1];
			m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+'><B>'+m_issu_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_issu_name+'</B></TD></TR>';
			vec_pos=vec_pos+2;
			lineno=lineno+1;
		}
		m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" >'+
			'<TR BGCOLOR="darkblue"><TD WIDTH="60%"><B>Security Identification</B></TD>' +
			'<TD WIDTH="40%"><B>Maturity_Date</B></TD></TR>'+
			m_row+
			'</TABLE>'; 
		myDialogObj.htmlstr = m_writedata;
		myDialogObj.returnval = "";
		
		popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		document.Form1.TXT_SECIDEN.value=myDialogObj.returnval;
		document.Form1.TXT_SECIDEN.focus();			
	}	
	
	
	function insttype(endcode){
		if (endcode.value=="") {
			inst_help(endcode);
			endcode.focus();
		}
		else {
			m_instype=endcode.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+m_instype.toUpperCase()+"&chksql=chkins";
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
			if (m_size==0) {
				inst_help(endcode);
				endcode.focus();
			}
			else{
				document.Form1.TXT_INSTYPE.value=document.Form1.TXT_INSTYPE.value;
			}
		}	  
	}
	
	
	function inst_help(obj1) {
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?chksql=inst_lookup";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		vec_pos=0;
		lineno=1;
		m_row="";
		while (vec_pos<m_size) {
			m_issu_code=data_vec[vec_pos];
			m_issu_name=data_vec[vec_pos+1];
			m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+'><B>'+m_issu_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_issu_name+'</B></TD></TR>';
			vec_pos=vec_pos+2;
			lineno=lineno+1;
		}
		m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" >'+
			'<TR BGCOLOR="darkblue"><TD WIDTH="30%"><B>Instrument Type</B></TD>' +
			'<TD WIDTH="70%"><B>Instrument Description</B></TD></TR>'+
			m_row+
			'</TABLE>'; 
		myDialogObj.htmlstr = m_writedata;
		myDialogObj.returnval = "";
		
		popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		document.Form1.TXT_INSTYPE.value=myDialogObj.returnval;
		document.Form1.TXT_INSTYPE.focus();			
	}	
	
	
	function buyercode1(objx,objy){
		if (objx.value=="") {
			buyer_help(objx);
			objx.focus();
		}
		else{
			m_buycode=objx.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+m_buycode.toUpperCase()+"&chksql=chkbuy";
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
			if (m_size==0) {
				buyer_help(objx);
				objx.focus();
			}
			else{
				if(document.Form1.TXT_BCODE.value==document.Form1.TXT_SCODE.value){
					alert('Buyer Code and the Seller Code should be different');
					objx.value="";
					objx.focus();
				}
				else{
					objy.value=data_vec[1];
					document.Form1.HID_TYPE1.value=data_vec[2];
				}
			}
		}
	}
	
	function buyercode2(objx,objy){
		if (objx.value=="") {
			buyer_help(objx);
			objx.focus();
		}
		else{
			m_buycode=objx.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+m_buycode.toUpperCase()+"&chksql=chkbuy";
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
			if (m_size==0) {
				buyer_help(objx);
				objx.focus();
			}
			else{
				if(document.Form1.TXT_BCODE.value==document.Form1.TXT_SCODE.value){
					alert('Buyer Code and the Seller Code should be different');
					objx.value="";
					objx.focus();
				}
				else{
					objy.value=data_vec[1];
					document.Form1.HID_TYPE2.value=data_vec[2];
					//		newpart2();
					if(data_vec[2]=='C'){
						document.Form1.BUT_INV.disabled=true;
						document.Form1.TXT_INSTYPE.focus();
					}
					else{
						document.Form1.BUT_INV.disabled=false;
						document.Form1.TXT_INSTYPE.focus();
					}
				}
			}
		}
	}
	
	function get_settle_dates(){
		m_valdate=document.Form1.HID_DATE.value+'/'+document.Form1.HID_MONTH.value+'/'+document.Form1.HID_YEAR.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?value_date="+m_valdate+"&chksql=get_settle_dates";	
		//  top.frames[0].document.applets[0].getdata(m_url);
		//alert(top.frames[0].document.applets[0].outvec_value)
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		document.Form1.TXT_BDATE.value=data_vec[0].substring(0,2);
		document.Form1.TXT_BMONTH.value=data_vec[0].substring(3,5);
		document.Form1.TXT_BYEAR.value=data_vec[0].substring(6,10);
		document.Form1.TXT_SDATE.value=data_vec[1].substring(0,2);
		document.Form1.TXT_SMONTH.value=data_vec[1].substring(3,5);
		document.Form1.TXT_SYEAR.value=data_vec[1].substring(6,10);		    
	}
	
	function buyer_help(obj1) {
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?chksql=buyer_lookup";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		vec_pos=0;
		lineno=1;
		m_row="";
		while (vec_pos<m_size) {
			m_issu_code=data_vec[vec_pos];
			m_issu_name=data_vec[vec_pos+1];
			m_cds_no=data_vec[vec_pos+2];
			m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+'><B>'+m_issu_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_issu_name+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_cds_no+'</B></TD></TR>';
			vec_pos=vec_pos+3;
			lineno=lineno+1;
		}
		m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" >'+
			'<TR BGCOLOR="darkblue"><TD WIDTH="25%"><B>Buyer Code</B></TD>' +
			'<TD WIDTH="50%"><B>Buyer Name</B></TD><TD WIDTH="25%"><B>CDS No.</B></TD></TR>'+
			m_row+
			'</TABLE>'; 
		myDialogObj.htmlstr = m_writedata;
		myDialogObj.returnval = "";
		
		popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		obj1.value=myDialogObj.returnval;
		obj1.focus();			
	}	
	
	
	function date_obj(){
		document.Form1.HID_VALDATE.value=document.Form1.SEL_DATETYPE.value;
		document.Form1.HID_VALDATETYPE.value=document.Form1.SEL_DATETYPE.value;
		if(document.Form1.SEL_DATETYPE.value=='UD'){
			if (confirm("To entr an user define date click on OK !")) {
				m_writedata ='<TD><INPUT class="txt_input5" TYPE="Text" NAME="TXT_DATE" SIZE=3 MAXLENGTH=2 >'+
					'<INPUT TYPE="Text" class="txt_input5" NAME="TXT_MONTH" SIZE=3 MAXLENGTH=2 >'+
					'<INPUT TYPE="Text" class="txt_input5" NAME="TXT_YEAR" SIZE=5 MAXLENGTH=4 ONBLUR="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR)"></TD>';
				document.getElementById('newdate').innerHTML=m_writedata;	
				document.Form1.TXT_DATE.focus();
			}
		}		
		else{
			m_writedata ='<TD><INPUT TYPE="Hidden" NAME="HID_DATE" VALUE="01" SIZE=3 MAXLENGTH=2 >'+
				'<INPUT TYPE="Hidden" NAME="HID_MONTH" VALUE="01" SIZE=3 MAXLENGTH=2 >'+
				'<INPUT TYPE="Hidden" NAME="HID_YEAR" VALUE="1999" SIZE=5 MAXLENGTH=4 ></TD>';
		}
	}
	
	function date_objfprev(){
		m_writedata ='<TD><INPUT TYPE="Text" class="txt_input5" NAME="TXT_DATE" SIZE=3 MAXLENGTH=2 >'+
			'<INPUT TYPE="Text" class="txt_input5" NAME="TXT_MONTH" SIZE=3 MAXLENGTH=2 >'+
			'<INPUT TYPE="Text" class="txt_input5" NAME="TXT_YEAR" SIZE=5 MAXLENGTH=4 ONBLUR="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR)"></TD>';
		document.getElementById('newdate').innerHTML=m_writedata;	
	}
	
	function beforesubmit() {
		enable_inputs2();
		enable_inputs1();
		document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"front_sav_del_out";
		document.Form1.submit();
		document.Form1.Text_deal_ref.value="";
		
		//document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"fsavmodideloutright";
		//document.Form1.submit();
	}
	
	
</SCRIPT>
<!--
<BODY>
<FORM  NAME="Form1" METHOD="POST" >		
-->
<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="DELETE_OUT" >
<!--INPUT TYPE="Hidden" NAME="Hid_scr_name1"	VALUE="DEL" -->
<TABLE WidTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0" >							
	<TD WidTH="1%">
		<TD WidTH="99%">
			<INPUT TYPE="Hidden" NAME="HID_TYPE1">
			<INPUT TYPE="Hidden" NAME="HID_TYPE2">
			<INPUT TYPE="Hidden" NAME="HID_VALDATE">
			<INPUT TYPE="Hidden" NAME="HID_VALDATETYPE">
			<INPUT TYPE="Hidden" NAME="HID_DEALREF"  >
			<INPUT TYPE="Hidden" NAME="HID_MATURITY_DATE" VALUE="" >
			<INPUT TYPE="Hidden" NAME="HID_PAR_VALUE"   VALUE="0" >
			<INPUT TYPE="Hidden" NAME="HID_DEAL_TYPE"   VALUE="DEBT" >
			<INPUT TYPE="Hidden" class="txt_input6" NAME="TXT_PAR"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25 TABINDEX=-1 ONBLUR="formatnumequity(document.Form1.TXT_PAR)"  >
			
			<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
				<TR><TD><BR></TD></TR>
				<TR>
					<TD><B><U>Buyer Information</U></B></TD>
					<TD></TD>
					<TD  ><B><U>Seller Information</U></B></TD>
					<TD></TD>
				</TR>
			</TABLE> 	
			
			
			<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
				<TR><TD COLSPAN><BR></TD></TR>
				<TR>
					<TD WIDTH="20%">Buyer Code</TD>
					<TD WIDTH="30%"><INPUT class="txt_input6" TYPE="Text" NAME="TXT_BCODE" ONBLUR="buyercode1(document.Form1.TXT_BCODE,document.Form1.TXT_BNAME)" ALIGN="LEFT" SIZE=22 MAXLENGTH=10 >
						<INPUT TYPE="button"  class="but_input" VALUE="Help" NAME="BUT_BCODE" ONCLICK="buyer_help(document.Form1.TXT_BCODE)" ></TD>
					<TD WIDTH="20%" >Seller Code</TD>
					<TD WIDTH="30%" ><INPUT class="txt_input6" TYPE="Text" NAME="TXT_SCODE" ONBLUR="buyercode2(document.Form1.TXT_SCODE,document.Form1.TXT_SNAME)" ALIGN="LEFT" SIZE=22 MAXLENGTH=10 >
						<INPUT TYPE="button" class="but_input" VALUE="Help" NAME="BUT_SCODE"  ONCLICK="buyer_help(document.Form1.TXT_SCODE)"  ></TD>
				</TR>
				<TR>
					<TD>Buyer Name</TD>
					<TD><INPUT TYPE="Text"  class="txt_input6" NAME="TXT_BNAME"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10  ></TD>
					<TD >Seller Name</TD>
					<TD ><INPUT TYPE="Text" class="txt_input6" NAME="TXT_SNAME"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10 ></TD>
				</TR>
			</TABLE>
			<HR WIDTH="*%">
			
			
			
			<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
				<TR><TD COLSPAN='2'><B><U>Instrument & Security Information</U></B></TD></TR>
				<TR><TD><BR></TD></TR>
				<TR>
					<TD WIDTH="20%"></TD>
					<TD WIDTH="30%"></TD>
					<TD WIDTH="20%"></TD>											
					<TD WIDTH="30%"></TD>
				</TR>
				<TR>
					<TD>Instrument Type</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_INSTYPE" ALIGN="LEFT" SIZE=22 MAXLENGTH=10 ONBLUR="insttype(document.Form1.TXT_INSTYPE)">
						<INPUT TYPE="button"  class="but_input" VALUE="Help" NAME="BUT_INSTYPE" ONCLICK="inst_help()" ></TD>
				</TR>
				<TR>
					<TD>Security Identification</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_SECIDEN" ALIGN="LEFT" SIZE=22 MAXLENGTH=10 ONBLUR="sectype(document.Form1.TXT_SECIDEN,document.Form1.TXT_INSTYPE)">											
						<INPUT TYPE="button" class="but_input"  VALUE="Help" NAME="BUT_SECIDEN" ONCLICK="sec_help(document.Form1.TXT_INSTYPE)" ></TD>
					<TD><INPUT TYPE="button" class="but_input" VALUE="Security Details" NAME="BUT_INV" style="width:160px" ></TD>
				</TR>
				<TR>
					<TD>Issuer Code</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_ISSCODE"	ALIGN="LEFT" SIZE=22 MAXLENGTH=10 ></TD>
					<TD>Issuer Name</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_ISSNAME"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10 ></TD>
				</TR>
				<TR>											
					<TD>Guarantor Code</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_GUCODE"	ALIGN="LEFT" SIZE=22 MAXLENGTH=10></TD>
					<TD>Guarantor Name</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_GUNAME"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10></TD>
				</TR>
				<TR>
					<TD>Endorser Code</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_ENCODE" ALIGN="LEFT" SIZE=22 MAXLENGTH=10 ONBLUR="endcodex(document.Form1.TXT_INSTYPE,document.Form1.TXT_ENCODE)">
						<INPUT TYPE="button" class="but_input" VALUE="Help" NAME="BUT_ENCODE"  ONCLICK="end_help(document.Form1.TXT_INSTYPE)" ></TD>
					<TD>Endorser Name</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_ENNAME"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10 ></TD>
				</TR>
			</TABLE><HR WIDTH="*%">									
			
			<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
				<TR><TD COLSPAN='2'><B><U>Transaction Value Date & Amount Information</U></B></TD></TR>										
				<TR><TD><BR></TD></TR>
				<TR>
					<TD WIDTH="20%"></TD>
					<TD WIDTH="30%"></TD>												
					<TD WIDTH="20%"></TD>
					<TD WIDTH="30%"></TD>
				</TR>											
				<TR>
					<TD>Currency</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_CURR" ALIGN="LEFT" VALUE="SLR" SIZE=22 MAXLENGTH=10  ONBLUR="chk_currency(document.Form1.TXT_CURR)">
						<INPUT TYPE="button" class="but_input" VALUE="Help" NAME="BUT_CURR"  onClick="currency_help();"></TD>
				</TR>
				<TR>
					<TD>Value Date</TD>
					<TD ID=newdate><SELECT class="txt_input6" NAME="SEL_DATETYPE"  ONBLUR="date_obj()">
							<OPTION VALUE="SPOT" SELECTED>Spot</option>  
							<OPTION VALUE="TOM" >Tom</option>  
							<OPTION VALUE="CASH" >Cash</option>  
							<OPTION VALUE="UD">U / D</option>
						</SELECT>
					</TD>								
					
					<TD>								
						<INPUT TYPE="Hidden" NAME="HID_DATE" VALUE="01" SIZE=3 MAXLENGTH=2 >
						<INPUT TYPE="Hidden" NAME="HID_MONTH" VALUE="01" SIZE=3 MAXLENGTH=2 >
						<INPUT TYPE="Hidden" NAME="HID_YEAR" VALUE="1999" SIZE=5 MAXLENGTH=4 >								
					</TD>
				</TR>	
				<TR>								
					<TD>Basis</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_BASIS" ALIGN="LEFT" SIZE=22 MAXLENGTH=10 ONCHANGE="chk_basis(document.Form1.TXT_BASIS)">									
						<INPUT TYPE="button" class="but_input" VALUE="Help" NAME="BUT_BASIS"   onClick="basis_help();"></TD>
					<TD>Face Value</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_FACEVAL"	ALIGN="LEFT" STYLE="text-align:right;" SIZE=28 MAXLENGTH=18 TABINDEX=-1 ONCHANGE="formatnum1(document.Form1.TXT_FACEVAL)"></TD>
					<INPUT TYPE="Hidden" NAME="HID_FACEVAL">
				</TR>
				<TR>
					<TD>Yield to Maturity %</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_YIELD" STYLE="text-align:right;" ALIGN="LEFT" SIZE=28 MAXLENGTH=10 TABINDEX=0 ONCHANGE="formatnum01(document.Form1.TXT_YIELD)"></TD>
					<INPUT TYPE="Hidden" NAME="HID_YIELD">
					<TD>Cost</TD>
					<TD><INPUT TYPE="Text"  class="txt_input6" NAME="TXT_COST" STYLE="text-align:right;"	ALIGN="LEFT" SIZE=28 MAXLENGTH=18 TABINDEX=-1 ONCHANGE="formatnum2(document.Form1.TXT_COST)"></TD>
					<INPUT TYPE="Hidden" NAME="HID_COST">
				</TR>
				<TR>
					<TD>Price - Clean</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_CLEAN" STYLE="text-align:right;"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10 TABINDEX=-1 ONCHANGE="formatnum02(document.Form1.TXT_CLEAN)"></TD>
					<INPUT TYPE="Hidden" NAME="HID_CLEAN">
					<TD>Accrued Interest</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_ACCINT" STYLE="text-align:right;"	ALIGN="LEFT" SIZE=28 MAXLENGTH=18 TABINDEX=-1 ONCHANGE="formatnum3(document.Form1.TXT_ACCINT);"></TD>
					<INPUT TYPE="Hidden" NAME="HID_ACCINT">
				</TR>
				<TR>
					<TD>Price - Dirty</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_DIRTY"	ALIGN="LEFT" STYLE="text-align:right;" SIZE=28 MAXLENGTH=10 TABINDEX=-1 ONCHANGE="formatnum03(document.Form1.TXT_DIRTY)"></TD>
					<INPUT TYPE="Hidden" NAME="HID_DIRTY">
					<TD>Settlement Value</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_SETVAL" STYLE="text-align:right;"	ALIGN="LEFT" SIZE=28 MAXLENGTH=18 TABINDEX=-1 ONCHANGE="formatnum4(document.Form1.TXT_SETVAL);"></TD>
					<INPUT TYPE="Hidden" NAME="HID_SETVAL">
				</TR>
			</TABLE>
			
			<HR WIDTH="*%">	
			<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
				<TR><TD><B><U>Share Information</U></B></TD></TR>
				<TR><TD><BR></TD></TR>
				<TD WIDTH="20%"></TD>
				<TD WIDTH="30%"></TD>
				<TD WIDTH="20%"></TD>											
				<TD WIDTH="30%"></TD>
			</TR>
			<TR>
				<TD>Value Date</TD>
				
				<TD><INPUT TYPE="Text" class="txt_input6" TABINDEX=0 NAME="TXT_DATE1" SIZE=3 MAXLENGTH=2 ONCHANGE="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR)">
					<INPUT TYPE="Text" class="txt_input6" NAME="TXT_MONTH1" SIZE=3 MAXLENGTH=2 ONCHANGE="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR)">
					<INPUT TYPE="Text" class="txt_input6" NAME="TXT_YEAR1" SIZE=5 MAXLENGTH=4 ONCHANGE="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR)"></TD>													
				<TD>Purchase Cost Per Share</TD>
				<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_PURCH_COST"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25 TABINDEX=-1  ></TD>
			</TR>					
			<TR>
				<TD>Price per share</TD>
				<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_CLEAN1"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25  MAXLENGTH=25 TABINDEX=-1 ONBLUR="formatnumequity(document.Form1.TXT_CLEAN)" ></TD>																														
				<TD>Broker and Other Cost
				</TD>
				<TD><SELECT class="txt_input6" NAME="SEL_BROKER"  onchange="get_broker_cost()"> 
						<OPTION VALUE="Y" SELECTED>Yes</option>  
						<OPTION VALUE="N" >No</option>  
					</SELECT><INPUT TYPE="Text" class="txt_input6" NAME="TXT_BROKER_COST"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25 TABINDEX=-1 ONBLUR="formatnumequity(document.Form1.TXT_BROKER_COST);get_total()"  VALUE=0 DISABLED></TD>
			</TR>
			<TR>
				<TD>No of shares</TD>
				<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_FACEVAL1"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25 TABINDEX=-1  ONBLUR="getnominal_value();get_total()"></TD>
				<TD>Total Cost</TD>
				<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_TOT_COST"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25 TABINDEX=-1 ONBLUR="formatnumequity(document.Form1.TXT_TOT_COST)" ></TD>
			</TR>
			<!--
			<TR>
				<TD>Par Value</TD>
				<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_PAR"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25 TABINDEX=-1 ONBLUR="formatnumequity(document.Form1.TXT_PAR)"  ></TD>
				<TD>Buyer Settle Date</TD>
				<TD><INPUT TYPE="Text" class="txt_input6" TABINDEX=0 NAME="TXT_BDATE" SIZE=3 MAXLENGTH=2 ONCHANGE="chkstartdate(document.Form1.TXT_BDATE,document.Form1.TXT_BMONTH,document.Form1.TXT_BYEAR)">
					<INPUT TYPE="Text" class="txt_input6" NAME="TXT_BMONTH" SIZE=3 MAXLENGTH=2 ONCHANGE="chkstartdate(document.Form1.TXT_BDATE,document.Form1.TXT_BMONTH,document.Form1.TXT_BYEAR)">
					<INPUT TYPE="Text" class="txt_input6" NAME="TXT_BYEAR" SIZE=5 MAXLENGTH=4 ONCHANGE="chkstartdate(document.Form1.TXT_BDATE,document.Form1.TXT_BMONTH,document.Form1.TXT_BYEAR);chk_holiday()"></TD>												
				
			</TR>
			<TR>
				<TD>Nominal Value</TD>
				<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_NOMINAL"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25 TABINDEX=-1 ONBLUR="formatnumequity(document.Form1.TXT_NOMINAL)" ></TD>
				<TD>Seller Settle Date</TD>
				<TD ><INPUT TYPE="Text" class="txt_input6" TABINDEX=0 NAME="TXT_SDATE" SIZE=3 MAXLENGTH=2 ONCHANGE="chkstartdate(document.Form1.TXT_SDATE,document.Form1.TXT_SMONTH,document.Form1.TXT_SYEAR)">
					<INPUT TYPE="Text" class="txt_input6" NAME="TXT_SMONTH" SIZE=3 MAXLENGTH=2 ONCHANGE="chkstartdate(document.Form1.TXT_SDATE,document.Form1.TXT_SMONTH,document.Form1.TXT_SYEAR)">
					<INPUT TYPE="Text" class="txt_input6" NAME="TXT_SYEAR" SIZE=5 MAXLENGTH=4 ONCHANGE="chkstartdate(document.Form1.TXT_SDATE,document.Form1.TXT_SMONTH,document.Form1.TXT_SYEAR);chk_holiday()"></TD>												
				
			</TR>
			-->
			
			<TR>
				<TD>Nominal Value</TD>
				<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_NOMINAL"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25 TABINDEX=-1 ONBLUR="formatnumequity(document.Form1.TXT_NOMINAL)" ></TD>
				<TD>Buyer Settle Date</TD>
				<TD><INPUT TYPE="Text" class="txt_input6" TABINDEX=0 NAME="TXT_BDATE" SIZE=3 MAXLENGTH=2 ONCHANGE="chkstartdate(document.Form1.TXT_BDATE,document.Form1.TXT_BMONTH,document.Form1.TXT_BYEAR)">
					<INPUT TYPE="Text" class="txt_input6" NAME="TXT_BMONTH" SIZE=3 MAXLENGTH=2 ONCHANGE="chkstartdate(document.Form1.TXT_BDATE,document.Form1.TXT_BMONTH,document.Form1.TXT_BYEAR)">
					<INPUT TYPE="Text" class="txt_input6" NAME="TXT_BYEAR" SIZE=5 MAXLENGTH=4 ONCHANGE="chkstartdate(document.Form1.TXT_BDATE,document.Form1.TXT_BMONTH,document.Form1.TXT_BYEAR);chk_holiday()"></TD>												
				
			</TR>
			<TR>
				<TD></TD>
				<TD></TD>
				<TD>Seller Settle Date</TD>
				<TD ><INPUT TYPE="Text" class="txt_input6" TABINDEX=0 NAME="TXT_SDATE" SIZE=3 MAXLENGTH=2 ONCHANGE="chkstartdate(document.Form1.TXT_SDATE,document.Form1.TXT_SMONTH,document.Form1.TXT_SYEAR)">
					<INPUT TYPE="Text" class="txt_input6" NAME="TXT_SMONTH" SIZE=3 MAXLENGTH=2 ONCHANGE="chkstartdate(document.Form1.TXT_SDATE,document.Form1.TXT_SMONTH,document.Form1.TXT_SYEAR)">
					<INPUT TYPE="Text" class="txt_input6" NAME="TXT_SYEAR" SIZE=5 MAXLENGTH=4 ONCHANGE="chkstartdate(document.Form1.TXT_SDATE,document.Form1.TXT_SMONTH,document.Form1.TXT_SYEAR);chk_holiday()"></TD>												
				
			</TR>
		</TABLE>	
		<!--
		</FORM>		
		</BODY>
		<DIV>
		<SCRIPT language1.2="JavaScript" src="validate.js"></SCRIPT></DIV>
		</HTML>
		-->
