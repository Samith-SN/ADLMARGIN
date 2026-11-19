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
</HEAD>
-->
<%@page import="net.sasianet.ADLMARGIN.*" %>
<SCRIPT language="JavaScript" type="text/javascript">
	<% ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
	
		Object done = (String)session.getValue("logon.isDone"); 
		if (done == null) {
			response.sendRedirect("login.jsp");
			return;
			}
	
%>
	var username = '<%= m_sn_methods.username %>';
	
	i1=1;
	j1=1;
	ftime=1;
	g_line=1;
	user_date=false;
	var text_possi;
	var disp=true;
	
	var a_array = new Array();			
	
	
	function myDialogObj() {
		var htmlstr;
		var returnval;
	}
	
	
	function cal_valdate(){
		if(user_date!=true){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_valuedate="+document.Form1.HID_VALDATETYPE.value+"&chksql=cal_valdate";
			//top.frames[0].document.applets[0].getdata(m_url);
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?seccode="+document.Form1.TXT_SECIDEN.value+"&val_date="+data_vec[0]+"&chksql=cal_valdate2";
			//top.frames[0].document.applets[0].getdata(m_url);
			load_interface(m_url,'XML',false);
			m_size1=data_vec.length;
			
		}
		else{
			document.Form1.HID_VALDATETYPE.value=document.Form1.TXT_DATE.value+'/'+document.Form1.TXT_MONTH.value+'/'+document.Form1.TXT_YEAR.value;
			m_url1=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?seccode="+document.Form1.TXT_SECIDEN.value+"&val_date="+document.Form1.HID_VALDATETYPE.value+"&chksql=cal_valdate2";
			//top.frames[0].document.applets[0].getdata(m_url1);
			load_interface(m_url,'XML',false);
			m_size1=data_vec.length;
		}
		if(m_size1>0){
			document.Form1.TXT_DIRTY.value=document.Form1.TXT_CLEAN.value;
			document.Form1.TXT_ACCINT.value='0.00';
			document.Form1.TXT_SETVAL.value=document.Form1.TXT_COST.value;
			document.Form1.TXT_SETAMO1.value=document.Form1.TXT_SETVAL.value;
		}
	}
	
	
	
	function get_settle_dates(){
		//alert("hi");
		m_valdate=document.Form1.HID_DATE.value+'/'+document.Form1.HID_MONTH.value+'/'+document.Form1.HID_YEAR.value;
		//alert(m_valdate);
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?value_date="+m_valdate+"&chksql=get_settle_dates";	
		//top.frames[0].document.applets[0].getdata(m_url);	
		load_interface(m_url,'XML',false);
		//window.open(m_url);
		document.Form1.TXT_BDATE.value=data_vec[0].substring(0,2);
		document.Form1.TXT_BMONTH.value=data_vec[0].substring(3,5);
		document.Form1.TXT_BYEAR.value=data_vec[0].substring(6,10);
		document.Form1.TXT_SDATE.value=data_vec[1].substring(0,2);
		document.Form1.TXT_SMONTH.value=data_vec[1].substring(3,5);
		document.Form1.TXT_SYEAR.value=data_vec[1].substring(6,10);		    
	}
	
	
	
	
	
	
	
	
	function defalt_b(m_inst_type){
		if(m_inst_type!=""){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?inst_type="+m_inst_type.toUpperCase()+"&chksql=defalt_basis";
			//top.frames[0].document.applets[0].getdata(m_url);
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
			document.Form1.TXT_BASIS.value=data_vec[1];
			document.Form1.HID_BASIS.value=data_vec[0];
		}
	}
	
	
	
	
	function add_data2(Hid_row){
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mfsenddata2?Debtor_No="+m_debtorno.toUpperCase()+"&Client_No="+m_clientno.toUpperCase()+"&chksql=pay_tran";
		top.frames[0].document.applets[0].getdata(m_url);
		m_size=top.frames[0].document.applets[0].outvec_value.size();
		m_row="";
		var ji=1;
		vec_pos=0;
		lineno=1;
		while (ji<(Hid_row.value)){
			mt_chkvalue="disp"+j;
			chk_tot=document.Form1.elements[mt_chkvalue];
			ji=ji+1;
			if (chk_tot.checked==true) {
				m_row=m_row+'<TR BGCOLOR="white" >';
				m_row=m_row+'<TD>'+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos)+'<INPUT TYPE="Hidden" NAME="h_schno'+lineno+'" VALUE="'+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos)+'" ></TD>';
				m_row=m_row+'<TD>'+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1)+'<INPUT TYPE="Hidden" NAME="h_schdate'+lineno+'" VALUE="'+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1)+'"></TD>';
				m_row=m_row+'<TD>'+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2)+'<INPUT TYPE="Hidden" NAME="h_invno'+lineno+'" VALUE="'+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2)+'"></TD>';
				m_row=m_row+'<TD>'+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2)+'<INPUT TYPE="Hidden" NAME="h_invdate'+lineno+'" VALUE="'+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2)+'"></TD>';
				m_row=m_row+'<TD>'+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+4)+'<INPUT TYPE="Hidden" NAME="h_invdate'+lineno+'" VALUE="'+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+4)+'"></TD></TR>';
				lineno=lineno+1;
			}
			vec_pos=vec_pos+5;
		}
		m_row=m_row+'<TABLE WIDTH="100%"><TR><TD WIDTH="180%"><TD WIDTH="20%"><INPUT TYPE="TEXT" NAME="RRRRR" SIZE="23"ONCLICK=""></TD></TR></TABLE>';
		m_writedata2 ='<TABLE WIDTH="100%" ">'+
			'<TR >'+
			'<TD WIDTH="16%"><B><FONT COLOR="black">Instrument</B></TD>' +
			'<TD WIDTH="16%"><B><FONT COLOR="black">Issuer</B></TD>'+
			'<TD WIDTH="16%"><B><FONT COLOR="black">Security Code</B></TD>'+
			'<TD WIDTH="16%"><B><FONT COLOR="black">Serial Number</B></TD>'+
			'<TD WIDTH="16%"><B><FONT COLOR="black">Face Value</B></TD>'+
			m_row+
			'</TABLE>'; 
		issue.innerHTML=m_writedata2;	
	}	
	
	
	function formatnumequity(num1)
	{					
		num1.value=format_noobject(num1.value);			
	}
	
	
	// Dummy function added by Chatura Jayawardena
	function deal_type()
	{					
		
	}
	
	
	
	function check()
	{
		if (unformat_noobject(document.Form1.TXT_CLEAN.value) > 1 )
		{
			check_pricetwentyfive();
		}
		else if (unformat_noobject(document.Form1.TXT_CLEAN.value) < 1 )
		{
			check_priceten();
		}
		
		
		
	}
	
	function get_broker() 
	{	
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_purchase_cost="+unformat_noobject(document.Form1.TXT_PURCH_COST.value)+"&chksql=get_broker_cost";					
		//	alert(m_url);
		load_interface(m_url,'XML',false);
		//top.frames[0].document.applets[0].getdata(m_url);	
		document.Form1.TXT_BROKER_COST.value   =format_noobject(data_vec[0]);
	}
	
	function check_share()
	{
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?share="+document.Form1.TXT_FACEVAL.value+"&chksql=check_share";					
		//top.frames[0].document.applets[0].getdata(m_url);	
		load_interface(m_url,'XML',false);
		if (data_vec[0] > 0 ) 
		{
			if(confirm("Not A valid amount.Are you sure to continue?")) {
				getnominal_value();
				get_broker();
				get_total();
			}
			else
			{
			}
		}
		else
		{
			getnominal_value();
			get_broker();
			get_total();
		}			
	}
	
	
	
	
	
	function check_pricetwentyfive()
	{
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?price="+unformat_noobject(document.Form1.TXT_CLEAN.value)+"&chksql=check_pricetwentyfive";					
		//top.frames[0].document.applets[0].getdata(m_url);	
		load_interface(m_url,'XML',false);
		if (data_vec[0] > 0 ) 
		{	    if(confirm("Not A valid amount.Are you sure to continue?")) {		
				if((document.Form1.TXT_FACEVAL.value=="")||(document.Form1.TXT_FACEVAL.value==" ")){	
					document.Form1.TXT_FACEVAL.focus();
				}
				else
				{
					getnominal_value()
					get_broker();
					get_total();																										
				}
				
			}
			else
			{
				document.Form1.TXT_CLEAN.value="";
				document.Form1.TXT_CLEAN.focus();
			}
		}
		else
		{
			if((document.Form1.TXT_FACEVAL.value=="")||(document.Form1.TXT_FACEVAL.value==" ")){	
				document.Form1.TXT_FACEVAL.focus();
			}
			else
			{
				getnominal_value()
				get_broker();
				get_total();																										
			}
			
			
		}
	}
	
	
	function check_priceten()
	{
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?price="+unformat_noobject(document.Form1.TXT_CLEAN.value)+"&chksql=check_priceten";					
		//top.frames[0].document.applets[0].getdata(m_url);	
		load_interface(m_url,'XML',false);
		if (data_vec[0] > 0 ) 
		{	    if(confirm("Not A valid amount.Are you sure to continue?")) {		
				if((document.Form1.TXT_FACEVAL.value=="")||(document.Form1.TXT_FACEVAL.value==" ")){	
					document.Form1.TXT_FACEVAL.focus();
				}
				else
				{
					getnominal_value()
					get_broker();
					get_total();																										
				}
				
			}
			else
			{
				document.Form1.TXT_CLEAN.value="";
				//document.Form1.TXT_CLEAN.focus(); NILU
			}
		}
		else
		{
			if((document.Form1.TXT_FACEVAL.value=="")||(document.Form1.TXT_FACEVAL.value==" ")){	
				document.Form1.TXT_FACEVAL.focus();
			}
			else
			{
				getnominal_value()
				get_broker();
				get_total();																										
			}
			
			
		}
	}
	
	
	
	function get_total() 
	{	  			
		broker=unformat_noobject(document.Form1.TXT_BROKER_COST.value);	
		pur=unformat_noobject(document.Form1.TXT_PURCH_COST.value);	
		//CHANGEDED ON 25-06-2004 
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_broker="+broker+"&m_cost="+pur+"&m_seller="+document.Form1.TXT_SCODE.value+"&m_buyer="+document.Form1.TXT_BCODE.value+"&chksql=get_total";					
		//top.frames[0].document.applets[0].getdata(m_url);		
		load_interface(m_url,'XML',false);
		document.Form1.TXT_TOT_COST.value   =format_noobject(data_vec[0]);
		document.Form1.HID_TOT_COST.value   =document.Form1.TXT_TOT_COST.value   
			//document.Form1.TXT_TOT_COST.disabled=true;				
			document.Form1.TXT_TOTVAL.value=document.Form1.TXT_FACEVAL.value;
		document.Form1.TXT_SETAMO1.value=document.Form1.TXT_TOT_COST.value;
		//ADDED ON 25-06-2004 
		
		document.Form1.HID_TYPE_B.value=data_vec[1];
		document.Form1.HID_TYPE_S.value=data_vec[2];
		if (document.Form1.HID_TYPE_S.value=="P" && document.Form1.HID_TYPE_B.value=="P"){
			alert("Brokerage amount should be zero.");
			document.Form1.TXT_BROKER_COST.value = "0.00";
		}
		
	}
	
	
	
	function getnominal_value() {	
		
		clean=unformat_noobject(document.Form1.TXT_CLEAN.value);	
		par=unformat_noobject(document.Form1.HID_PAR_VALUE.value);	
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_par="+par+"&m_shares="+document.Form1.TXT_FACEVAL.value+"&m_price="+clean+"&chksql=get_nominal";
		//top.frames[0].document.applets[0].getdata(m_url);
		load_interface(m_url,'XML',false);
		document.Form1.TXT_NOMINAL.value   =format_noobject(data_vec[0]);
		document.Form1.TXT_PURCH_COST.value=format_noobject(data_vec[1]);
		document.Form1.TXT_NOMINAL.disabled=true;
		document.Form1.TXT_PURCH_COST.disabled=true;
		
	}
	
	function chk_insttype(m_instype){//----$$##SC
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?insttype="+m_instype.toUpperCase()+"&chksql=chk_inst";
		//top.frames[0].document.applets[0].getdata(m_url);
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		if (m_size>0) {
			if(data_vec[0]=="W" ){
				//document.Form1.BUT_INV.disabled=true;
				//document.Form1.BUT_INV_SL.disabled=true;	
			}else{
				document.Form1.BUT_INV.disabled=true;
				document.Form1.BUT_INV_SL.disabled=false;	
			}	
		}
	}
	//-------------------------------------
	
	function find_amount(numval){
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalCounterParties?chksql=get_last1&code="+document.Form1.TXT_FACEVAL.value ;				
		//top.frames[0].document.applets[0].getdata(m_url);
		load_interface(m_url,'XML',false);
		char1=data_vec[0];	
		amt=data_vec[1];	
		
		if (char1.toUpperCase() == "T" ){
			document.Form1.TXT_FACEVAL.value=1000*amt;
		}
		else if (char1.toUpperCase() == "M" ){
			document.Form1.TXT_FACEVAL.value=1000000*amt;
			
		}
		else if (char1.toUpperCase() == "B" ){
			document.Form1.TXT_FACEVAL.value=1000000000*amt;
		}
		else{
			
			if(top.frames[1].frames[0].document.Form1.SCRIPT_STAT.value=="SL"){//$$##SC
				document.Form1.TXT_FACEVAL.value=format_noobject_nodecimal(numval);	
			}
			else{
				document.Form1.TXT_FACEVAL.value=format_noobject(numval);	
			}
			//--------------------------------------
			
		}
	}
	
	
	function formatnum1(num1){
		
		
		
		if((document.Form1.TXT_YIELD.value=="")||(document.Form1.TXT_YIELD.value==" ")){
			if(document.Form1.SCRIPT_STAT.value=="SL"){//$$##SC
				num1.value=format_noobject_nodecimal(num1.value);
			}
			else{
				num1.value=format_noobject(num1.value);
			}
			//--------------------------------------------
			document.Form1.HID_FACEVAL.value=unformat_noobject(num1.value);
		}
		else{
			
			//TXT_FACEVAL TXT_COST  TXT_SETVAL
			//num1.value=format_noobject(num1.value);
			
			if(document.Form1.SCRIPT_STAT.value=="SL"){//$$##SC
				num1.value=format_noobject_nodecimal(num1.value);
			}
			else{
				num1.value=format_noobject(num1.value);
			}
			//--------------------------------------------
			
			//document.Form1.TXT_COST.focus();
			document.Form1.HID_FACEVAL.value=unformat_noobject(num1.value);
			mm_pricec=unformat_noobject(document.Form1.TXT_CLEAN.value);
			mm_faceval=unformat_noobject(document.Form1.TXT_FACEVAL.value);
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_seccode="+document.Form1.TXT_SECIDEN.value+"&m_pricec="+mm_pricec+"&m_valuedate="+document.Form1.HID_VALDATETYPE.value+"&m_faceval="+mm_faceval+"&chksql=Ccla_threeval";
			//	window.open(m_url);
			//top.frames[0].document.applets[0].getdata(m_url);	
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
			document.Form1.TXT_COST.value=data_vec[0];
			document.Form1.TXT_ACCINT.value=data_vec[1];
			document.Form1.TXT_SETVAL.value=data_vec[2];
			document.Form1.TXT_TOTVAL.value=document.Form1.TXT_FACEVAL.value;
			document.Form1.TXT_SETAMO1.value=document.Form1.TXT_SETVAL.value;
			document.Form1.HIDD_SETAMO1.value=document.Form1.TXT_SETVAL.value;
			document.Form1.HIDD_TXT_CURR.value=document.Form1.TXT_CURR.value;
			if(document.Form1.TXT_ISSCODE.value!=""){
				document.Form1.TXT_ISSURE.value=document.Form1.TXT_ISSCODE.value;
			}
			if(document.Form1.TXT_SECIDEN.value!=""){
				document.Form1.TXT_SECCODE.value=document.Form1.TXT_SECIDEN.value;
			}
			if(document.Form1.HID_TEST.value!=""){
				document.Form1.TXT_TOTVAL.value=document.Form1.HID_TEST.value;
			}
			if(document.Form1.TXT_INSTYPE.value!=""){
				document.Form1.TXT_INSTYPE.value=document.Form1.TXT_INSTYPE.value;
			}
			cal_valdate();
			//display_possible(document.Form1.HID_FACEVAL.value);
		}
		
		
		document.Form1.TXT_BCODE.disabled=true;
		document.Form1.TXT_SCODE.disabled=true;
		document.Form1.BUT_BCODE.disabled=true;
		document.Form1.BUT_SCODE.disabled=true;
		
		
	}	
	
	//@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#
	function display_limit_details_enable(){
		chk_cash_daeal=document.Form1.HID_VALDATE.value;
		if (chk_cash_daeal=='CASH') {			
			top.frames[1].frames[1].document.Form1.Text_help_limit.disabled=false;
		}
		group_deals();
	}
	
	function display_limit_details(){
		m_buy_portfolio_code=document.Form1.TXT_BCODE.value.toUpperCase();
		m_sell_portfolio_code=document.Form1.TXT_SCODE.value.toUpperCase();
		m_face_value=unformat_noobject(document.Form1.TXT_FACEVAL.value);
		m_security_code=document.Form1.TXT_SECIDEN.value.toUpperCase();
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"midvallimits?buy_portfolio_code="+m_buy_portfolio_code+"&sell_portfolio_code="+m_sell_portfolio_code+"&face_value="+m_face_value+"&security_code="+m_security_code+"&chksql=check_ovrl_possible_vio";
		//top.frames[0].document.applets[0].getdata(m_url);
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		
		if (m_size>0) {
			vec_pos=0;
			m_row="";
			lineno=1;
			m_status=true;
			while (vec_pos<m_size){
				m_row=m_row+'<TD>'+data_vec[vec_pos+4]+'<INPUT TYPE="Hidden" NAME="COL_A'+lineno+'" VALUE='+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+0)+' ><INPUT TYPE="Hidden" NAME="COL_B'+lineno+'" VALUE='+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1)+' ><INPUT TYPE="Hidden" NAME="COL_C'+lineno+'" VALUE='+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2)+'><INPUT TYPE="Hidden" NAME="COL_D'+lineno+'" VALUE='+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+3)+' ><INPUT TYPE="Hidden" NAME="COL_E'+lineno+'" VALUE='+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+4)+' ><INPUT TYPE="Hidden" NAME="COL_F'+lineno+'" VALUE='+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+5)+'></TD></TR>';
				a_array[vec_pos]   = data_vec[vec_pos];
				a_array[vec_pos+1]   = data_vec[vec_pos+1];
				a_array[vec_pos+2]   = data_vec[vec_pos+2];
				a_array[vec_pos+3]   = data_vec[vec_pos+3];
				a_array[vec_pos+4]   = data_vec[vec_pos+4];
				a_array[vec_pos+5]   = data_vec[vec_pos+5];
				vec_pos=vec_pos+6;
				lineno=lineno+1;
			}				
			document.Form1.HID_POSS_ROW.value=Number(lineno)-1;		
			if (m_size>0) {
				popupwin_limit = window.open('mbfsl_limits_possible_outright.jsp','disp_Window_details','left=0,top=0,width=700,height=150,toolbar=0,location=0,left=150,top=180,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin_limit.focus(); 
			}	
		}
		else {
			alert("No possible violation reported");
		}
	}
	//@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#@#
	
	
	
	function formatnum2(num2){
		num2.value=format_noobject(num2.value);
		document.Form1.HID_COST.value=unformat_noobject(num2.value);
		mm_cost=unformat_noobject(document.Form1.TXT_COST.value);
		mm_faceval=unformat_noobject(document.Form1.TXT_FACEVAL.value);
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_seccode="+document.Form1.TXT_SECIDEN.value+"&m_cost="+mm_cost+"&m_valuedate="+document.Form1.HID_VALDATETYPE.value+"&m_faceval="+mm_faceval+"&chksql=Ccla_threeval_2";
		//top.frames[0].document.applets[0].getdata(m_url);	
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		document.Form1.TXT_CLEAN.value=data_vec[0];
		document.Form1.HID_CLEAN.value=data_vec[0];
		formatnum02(document.Form1.HID_CLEAN);
	}
	
	function formatnum3(num3)
	{
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
		//alert(num5.value);
		document.Form1.TXT_CLEAN.focus();
		document.Form1.HID_YIELD.value=unformat_noobject(num5.value);
		
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_yield="+document.Form1.HID_YIELD.value/100+"&m_valuedate="+document.Form1.HID_VALDATETYPE.value+"&m_security="+document.Form1.TXT_SECIDEN.value+"&m_basis="+document.Form1.HID_BASIS.value+"&chksql=c_d_fromyield";
		//top.frames[0].document.applets[0].getdata(m_url);																																																																																					
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		//alert(top.frames[0].document.applets[0].outvec_value);
		
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		document.Form1.TXT_CLEAN.value=format_noobject0(data_vec[1],4);
		document.Form1.TXT_DIRTY.value=format_noobject0(data_vec[0],4);
		formatnum1(document.Form1.TXT_FACEVAL);
	}
	
	
	function curfocus	(){
		document.Form1.TXT_FACEVAL.focus();
	}
	
	//================================from clean=================
	
	
	function formatnum02(num6){
		num6.value=format_noobject0(num6.value);
		document.Form1.HID_CLEAN.value=unformat_noobject(num6.value);
		document.Form1.TXT_DIRTY.focus();
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_clean="+document.Form1.TXT_CLEAN.value+"&m_valuedate="+document.Form1.HID_VALDATETYPE.value+"&m_security="+document.Form1.TXT_SECIDEN.value+"&m_basis="+document.Form1.HID_BASIS.value+"&chksql=y_d_fromclean";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();			
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		document.Form1.TXT_DIRTY.value=format_noobject0(data_vec[0],4);
		document.Form1.TXT_YIELD.value=format_noobject0(((data_vec[1])*100),4);			
		//	document.Form1.TXT_FACEVAL.focus();
		formatnum1(document.Form1.TXT_FACEVAL);
	}
	
	//================================from dirty==================		
	
	function formatnum03(num7){
		num7.value=format_noobject0(num7.value);
		document.Form1.HID_DIRTY.value=unformat_noobject(num7.value);
		
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_dirty="+document.Form1.TXT_DIRTY.value+"&m_valuedate="+document.Form1.HID_VALDATETYPE.value+"&m_security="+document.Form1.TXT_SECIDEN.value+"&m_basis="+document.Form1.HID_BASIS.value+"&chksql=y_c_fromdirty";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		
		document.Form1.TXT_YIELD.value=format_noobject0(((data_vec[1])*100),4);
		document.Form1.TXT_CLEAN.value=format_noobject0(data_vec[0],4);
		
		
		//document.Form1.TXT_FACEVAL.focus();
		formatnum1(document.Form1.TXT_FACEVAL);
	}
	
	
	
	function checkallvalues(dayobj,monthobj,yearobj) {
		if ( ( monthobj.value == "" || monthobj.value == " ") &&  ( yearobj.value == "" || yearobj.value == " ")  )
		{				
		}
		else
		{
			if (checkMonthLength(dayobj,monthobj,yearobj)) {
				document.Form1.HID_VALDATETYPE.value=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
				document.Form1.HID_DATE.value=dayobj.value;
				document.Form1.HID_MONTH.value=monthobj.value;
				document.Form1.HID_YEAR.value=yearobj.value;
				//alert('4-'+document.Form1.HID_YEAR.value);
				
			}
		}
		
	}
	
	
	function checkallvaluesmon(dayobj,monthobj,yearobj) {
		if (  yearobj.value == "" || yearobj.value == " "  )
		{				
		}
		else
		{
			if (checkMonthLength(dayobj,monthobj,yearobj)) {
				document.Form1.HID_VALDATETYPE.value=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
				document.Form1.HID_DATE.value=dayobj.value;
				document.Form1.HID_MONTH.value=monthobj.value;
				document.Form1.HID_YEAR.value=yearobj.value;			
			}
		}
	}			
	
	
	function checkallvaluesset(dayobj,monthobj,yearobj) 
	{
		if ( ( monthobj.value == "" || monthobj.value == " ") &&  ( yearobj.value == "" || yearobj.value == " ")  )
		{			}
		else
		{
			checkMonthLength(dayobj,monthobj,yearobj)
		}
		
	}
	
	
	function checkallvaluesmonset(dayobj,monthobj,yearobj) {
		if (  yearobj.value == "" || yearobj.value == " "  )
		{				
		}
		else
		{
			checkMonthLength(dayobj,monthobj,yearobj)
		}
		
		
	}
	
	
	function chk_holiday_settle(dayobj,monthobj,yearobj){
		m_valdate=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?value_date="+m_valdate+"&chksql=chk_valholiday";
		//top.frames[0].document.applets[0].getdata(m_url);
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		if (m_size>0){
			alert('Selected date is a holiday !. '+data_vec[1]+'');
			dayobj.value="";
			monthobj.value="";
			yearobj.value="";
			dayobj.focus();
		}
	}
	
	
	
	function chkstartdate1(dayobj,monthobj,yearobj) {
		if (checkMonthLength(dayobj,monthobj,yearobj)) {
			document.Form1.HID_VALDATETYPE.value=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
			document.Form1.HID_DATE.value=dayobj.value;
			document.Form1.HID_MONTH.value=monthobj.value;
			document.Form1.HID_YEAR.value=yearobj.value;
			//alert('5-'+document.Form1.HID_YEAR.value);
			chk_holiday_settle(dayobj,monthobj,yearobj)
			
		}
	}
	
	
	
	
	function chkstartdate(dayobj,monthobj,yearobj) {
		//ftime=ftime+1;
		//if(ftime>3){
		//dayobj.value+'-'+monthobj.value+'-'+yearobj.value!="--"
		if(dayobj.value!="" && monthobj.value!="" && yearobj.value!=""){
			if (checkMonthLength(dayobj,monthobj,yearobj)) {
				//	alert();
				document.Form1.HID_VALDATETYPE.value=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
				document.Form1.HID_DATE.value=dayobj.value;
				document.Form1.HID_MONTH.value=monthobj.value;
				document.Form1.HID_YEAR.value=yearobj.value;
				//alert('6-'+document.Form1.HID_YEAR.value);
				
				chk_holiday(dayobj,monthobj,yearobj);
			}
		}
		//}
	}			
	
	
	function chk_holiday(dayobj,monthobj,yearobj){
		m_valdate=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?value_date="+m_valdate+"&chksql=chk_valholiday";
		//top.frames[0].document.applets[0].getdata(m_url);
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		if (m_size>0){
			alert('Selected date is a holiday !. '+data_vec[1]+'');
			dayobj.value="";
			monthobj.value="";
			yearobj.value="";
			dayobj.focus();
		}
		else{
			if (inst_cat== "DEBT" ){	
				document.Form1.TXT_BASIS.focus();
			}
			else {		
				get_settle_dates();
				document.Form1.HID_DATE.value=document.Form1.TXT_DATE.value;
				document.Form1.HID_MONTH.value=document.Form1.TXT_MONTH.value;
				document.Form1.HID_YEAR.value=document.Form1.TXT_YEAR.value;	
				//alert('7-'+document.Form1.HID_YEAR.value);
				//document.Form1.TXT_CLEAN.focus();
			}
		}
		/*
		alert(document.Form1.TXT_DATE.value);
		alert(document.Form1.TXT_MONTH.value);
		alert(document.Form1.TXT_YEAR.value)*/
		document.Form1.HID_DATE.value=document.Form1.TXT_DATE.value;
		document.Form1.HID_MONTH.value=document.Form1.TXT_MONTH.value;
		document.Form1.HID_YEAR.value=document.Form1.TXT_YEAR.value;				
		//alert('8-'+document.Form1.HID_YEAR.value);
		/*
		alert(document.Form1.HID_DATE.value);
		alert(document.Form1.HID_MONTH.value);
		alert(document.Form1.HID_YEAR.value);*/
		
	}
	
	
	
	function chk_currency(curr_obj) {
		m_code=curr_obj.value; 
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?chksql=currency&cur_code="+m_code+"";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		if(m_size==0)  {
			currency_help(0);
		}
	}
	
	/*
	function currency_help(){
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?chksql=currency_lookup";
		top.frames[0].document.applets[0].getdata(m_url);
		m_size=top.frames[0].document.applets[0].outvec_value.size();
		vec_pos=0;
		m_row="";
		lineno=1;
		while (vec_pos<m_size) {
			m_cr_code=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
			m_cr_desc=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
			m_row=m_row+'<TR STYLE="{color:black; cursor:hand font: bold 10pt Arial;}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_cr_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_cr_desc+'</B></TD></TR>';
			vec_pos=vec_pos+2;
			lineno=lineno+1;
		}
		m_writedata ='<TABLE WIDTH="100%" >'+
			'<TR ><TD WIDTH="30%"><B>Crrency Code</B></TD>' +
			'<TD WIDTH="70%"><B>Currency Description</B></TD></TR>'+
			m_row+
			'</TABLE>'; 
		myDialogObj.htmlstr = m_writedata;
		myDialogObj.returnval = "";
		
		popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		document.Form1.TXT_CURR.value=myDialogObj.returnval;
		document.Form1.TXT_CURR.focus();
	}
	*/
	
	
	function currency_help(m_strat){
		var aForm;    //  aForm =oForm.elements;
		aForm =  document.getElementById('Form1');
		
		
		var myObject=new Array(); //return values set to this object
		myObject[0]=aForm.TXT_CURR;
		myObject[1]=null;
		myObject[2]=null;
		myObject[3]=null;
		myObject[4]=null;
		
		var myObject_value=new Array(); //passing values set to this object
		myObject_value[0]=null;
		myObject_value[1]=null;//aForm.oLastName2.value;
		myObject_value[2]=null;
		myObject_value[3]=null;
		myObject_value[4]= null;
		
		
		var myObject_type=new Array(); //passing values data type
		myObject_type[0]=null;
		myObject_type[1]=null;
		myObject_type[2]=null;
		myObject_type[3]=null;
		myObject_type[4]=null;
		
		var qid='115';
		
		title_name='Currency Code';
		var url = 'popup.jsp';
		var close_fun='currency_help_close';			
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
					if(returnedValue == null){currency_help_close();} 
					if(returnedValue != null){document.Form1.TXT_CURR.focus();}
				} 
			});
	}
	
	function currency_help_close(){
		document.Form1.TXT_CURR.value = '';
	}
	
	
	function basis_help(m_strat){
		var aForm;    //  aForm =oForm.elements;
		aForm =  document.getElementById('Form1');
		
		
		var myObject=new Array(); //return values set to this object
		myObject[0]=aForm.TXT_BASIS;
		myObject[1]=null;
		myObject[2]=null;
		myObject[3]=null;
		myObject[4]=null;
		
		var myObject_value=new Array(); //passing values set to this object
		myObject_value[0]=null;
		myObject_value[1]=null;//aForm.oLastName2.value;
		myObject_value[2]=null;
		myObject_value[3]=null;
		myObject_value[4]= null;
		
		
		var myObject_type=new Array(); //passing values data type
		myObject_type[0]=null;
		myObject_type[1]=null;
		myObject_type[2]=null;
		myObject_type[3]=null;
		myObject_type[4]=null;
		
		var qid='115';
		
		title_name='Basis Help';
		var url = 'popup.jsp';
		var close_fun='basis_help_close';			
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
					if(returnedValue == null){basis_help_close();} 
					if(returnedValue != null){document.Form1.TXT_BASIS.focus();}
				} 
			});
	}
	
	function basis_help_close(){
		document.Form1.TXT_BASIS.value = '';
	}
	/*
	function basis_help(){
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?chksql=basis_lookup";
		top.frames[0].document.applets[0].getdata(m_url);
		m_size=top.frames[0].document.applets[0].outvec_value.size();
		vec_pos=0;
		m_row="";
		lineno=1;
		while (vec_pos<m_size) {
			m_basis_code=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
			m_basis_desc=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
			m_row=m_row+'<TR STYLE="{color:black; cursor:hand font: bold 10pt Arial;}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C2R'+lineno+');><TD ID=C1R'+lineno+'><B>'+m_basis_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_basis_desc+'</B></TD></TR>';
			vec_pos=vec_pos+2;
			lineno=lineno+1;
		}
		m_writedata ='<TABLE  WIDTH="100%" >'+
			'<TR ><TD WIDTH="50%"><B>Interest Base Code</B></TD>' +
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
	*/
	
	
	function chk_basis(obj_basis) {
		m_basis=obj_basis.value; 
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?basis_desc="+m_basis+"&chksql=basis";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();.
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		if(m_size==0) {
			basis_help(0);
		}
		else{
			document.Form1.HID_BASIS.value=data_vec[0];
			//document.Form1.TXT_YIELD.focus();
		}
	}
	
	
	function endcodex(endcode,value){
		if (value.value!="") {
			m_instype=endcode.value;
			m_end=value.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?end_code="+m_end.toUpperCase()+"&buyer_code="+m_instype.toUpperCase()+"&chksql=endcode1";
			//top.frames[0].document.applets[0].getdata(m_url);
			load_interface(m_url,'XML',false);
			m_size= data_vec.length;
			if (m_size==0) {
				end_help(0);
				value.focus();
			}
			else{
				document.Form1.TXT_ENNAME.value=data_vec[1];
			}
		}
	}
	
	/*
	function end_help(obj1) {
		m_instype=obj1.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+m_instype.toUpperCase()+"&chksql=endcode";
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
		m_writedata ='<TABLE  WIDTH="100%" >'+
			'<TR ><TD WIDTH="30%"><B>Endorser Code</B></TD>' +
			'<TD WIDTH="70%"><B>Endorser Name</B></TD></TR>'+
			m_row+
			'</TABLE>'; 11
		myDialogObj.htmlstr = m_writedata;
		myDialogObj.returnval = "";
		
		popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		document.Form1.TXT_ENCODE.value=myDialogObj.returnval;
		document.Form1.TXT_ENCODE.focus();			
	}	
	*/
	
	
	
	function sectype(objz,objz1){
		if (objz.value=="") {			
			sec_help(0);
			objz1.focus();
		}
		else {
			m_sectype=objz.value;
			m_secinst=objz1.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+m_sectype.toUpperCase()+"&inst_num="+m_secinst.toUpperCase()+"&chksql=chksec";
			//top.frames[0].document.applets[0].getdata(m_url);						
			//alert(top.frames[0].document.applets[0].outvec_value);
			load_interface(m_url,'XML',false);
			m_size= data_vec.length;
			if (m_size==0) {
				sec_help(0);
				objz1.focus();
			}
			else{
				document.Form1.TXT_ISSCODE.value=data_vec[2];
				document.Form1.TXT_GUCODE.value=data_vec[4];
				document.Form1.TXT_ISSNAME.value=data_vec[5];
				document.Form1.TXT_GUNAME.value=data_vec[3]
				document.Form1.TXT_SECCODE.value=document.Form1.TXT_SECIDEN.value;
				document.Form1.TXT_ISSURE.value=document.Form1.TXT_ISSCODE.value;
				document.Form1.HID_PAR_VALUE.value=data_vec[6];
				document.Form1.TXT_ENCODE.focus();
			}
		}
	}
	
	/*
	function sec_help(obj1) {
		m_secinst=obj1.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?seccode="+document.Form1.TXT_SECIDEN.value+"&inst_num="+m_secinst.toUpperCase()+"&chksql=sec_lookup";
		top.frames[0].document.applets[0].getdata(m_url);
		m_size=top.frames[0].document.applets[0].outvec_value.size();
		vec_pos=0;
		lineno=1;
		m_row="";
		if (m_size>0){
			while (vec_pos<m_size) {
				m_issu_code=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
				m_issu_name=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
				if (document.Form1.HID_DEAL_TYPE.value == "DEBT" ){
					m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+'><B>'+m_issu_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_issu_name+'</B></TD></TR>';
				}
				else
				{
					m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+'><B>'+m_issu_code+'</B></TD></TR>';
				}
				vec_pos=vec_pos+2;
				lineno=lineno+1;
			}
			if (document.Form1.HID_DEAL_TYPE.value == "DEBT" ){
				
				m_writedata ='<TABLE BGCOLOR="silver" WIDTH="120%" >'+
					'<TR ><TD WIDTH="60%"><B>Security Identification</B></TD>' +
					'<TD WIDTH="40%"><B>Maturity_Date</B></TD></TR>'+
					m_row+
					'</TABLE>'; 
			}
			else
			{
				m_writedata ='<TABLE BGCOLOR="silver" WIDTH="120%" >'+
					'<TR BGCOLOR="darkblue"><TD WIDTH="60%"><B>Security Identification</B></TD>' +
					'</TR>'+
					m_row+
					'</TABLE>'; 
			}
			
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval = "";
			
			popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
			abc=top.frames[0].document.applets[0].outvec_value.indexOf(myDialogObj.returnval);
			document.Form1.TXT_SECIDEN.value=top.frames[0].document.applets[0].outvec_value.elementAt(abc);
			document.Form1.TXT_SECIDEN.focus();		
			document.Form1.HID_MATURITY_DATE.value=top.frames[0].document.applets[0].outvec_value.elementAt(abc+1);
		}	
		else{
			alert('Currently no data available for the selected Instrument type !');
		}
	}
	*/
	
	function insttype(endcode){
		if (endcode.value=="") {
			inst_help(0);
			endcode.focus();
		}
		else {
			m_instype=endcode.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+m_instype.toUpperCase()+"&chksql=chkins";
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
			if (m_size==0) {
				inst_help(0);
				endcode.focus();
			}
			else{
				if((document.Form1.SCRIPT_STAT.value=="SL")&&(document.Form1.HID_BUYER_VAL.value!='C')){//$$##SC
					chk_insttype(document.Form1.TXT_INSTYPE.value);
				}
				else{
					document.Form1.BUT_INV_SL.disabled=true;	
				}
			}
		}	  
	}
	
	/*
	function inst_help(obj1) {
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?chksql=inst_lookup";
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
		m_writedata ='<TABLE BGCOLOR="silver" WIDTH="120%" >'+
			'<TR BGCOLOR="darkblue"><TD WIDTH="30%"><B>Instrument Type</B></TD>' +
			'<TD WIDTH="120%"><B>Instrument Description</B></TD></TR>'+
			m_row+
			'</TABLE>'; 
		myDialogObj.htmlstr = m_writedata;
		myDialogObj.returnval = "";
		
		popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		document.Form1.TXT_INSTYPE.value=myDialogObj.returnval;
		document.Form1.TXT_INSTYPE.focus();		
		
		m_url1=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities?chksql=get_inst_cat&inst="+document.Form1.TXT_INSTYPE.value+"";
		top.frames[0].document.applets[0].getdata(m_url1);
		m_size=top.frames[0].document.applets[0].outvec_value.size();				
		inst_cat=top.frames[0].document.applets[0].outvec_value.elementAt(0);		
		document.Form1.HID_DEAL_TYPE.value=top.frames[0].document.applets[0].outvec_value.elementAt(0);
		parent.frames[1].document.Form1.HID_DEAL_TYPE.value=top.frames[0].document.applets[0].outvec_value.elementAt(0);
		
	}	
	*/
	
	function buyercode1(objx,objy){
		if (objx.value=="") {
			buyer_help(0);
			//objx.focus();
		}
		
		else{
			m_buycode=objx.value;
			// add yohan 06-09-2006 VC 06/017
			document.Form1.TXT_BCODE.value = m_buycode.toUpperCase();
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+m_buycode.toUpperCase()+"&chksql=chkbuy1";
			load_interface(m_url,'XML',false);
			//window.open(m_url);
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			m_size = data_vec.length;
			if (m_size==0) {
				buyer_help(0);
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
					document.Form1.HID_BUYER_OWN_STATUS.value=data_vec[3];//added by Dayan
					if (disp){
						load_sett_details();  
					}
					document.Form1.TXT_SCODE.focus();
					if(document.Form1.HID_TOT_COST.value!=""){
						get_broker();
						get_total();
					}
				}
			}
		}
	}
	
	
	
	function buyercode2(objx,objy){
		if (objx.value=="") {
			buyer_help1(0);
			//objx.focus();
		}
		else{
			m_buycode=objx.value;
			// add yohan 06-09-2006 VC 06/017
			document.Form1.TXT_SCODE.value = m_buycode.toUpperCase();
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+m_buycode.toUpperCase()+"&chksql=chkbuy";
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
			if (m_size==0) {
				buyer_help1(0);
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
					document.Form1.HID_SELLER_OWN_STATUS.value=data_vec[3];//added by Dayan
					newpart2();
					document.Form1.HID_BUYER_VAL.value=data_vec[2];//$$##SC
					//ADDED ON 25-06-2004 
					if(document.Form1.HID_TOT_COST.value!=""){
						get_broker();
						get_total(); 
					}
					
					/*
					if(top.frames[0].document.applets[0].outvec_value.elementAt(2)=='C'){
					document.Form1.BUT_INV.disabled=true;
					document.Form1.TXT_INSTYPE.focus();
					top.frames[1].frames[0].document.Form1.SCRIPT_STAT.disabled=true;//scriptless
					
					if (disp){
					parent.frames[1].load_sett_details();  
					}
					
					
					}
					else{
					//-------------------SCRIPTLESS-------------------------------------------
					if(top.frames[1].frames[0].document.Form1.SCRIPT_STAT.value=="SC"){//scriptless
					document.Form1.BUT_INV.disabled=false;//scriptless
					}//scriptless
					else{//scriptless
					document.Form1.BUT_INV.disabled=false;
					}//scriptless
					//--------------------------------------------------------------------------
					top.frames[1].frames[0].document.Form1.SCRIPT_STAT.disabled=true;//scriptless
					if (disp){
					parent.frames[1].load_sett_details();  
					}
					document.Form1.TXT_INSTYPE.focus();
					}************/
					
					if(data_vec[2]=='C'){//$$##SC
						document.Form1.BUT_INV.disabled=true;
						document.Form1.BUT_INV_SL.disabled=true;
						//document.Form1.TXT_INSTYPE.focus();//COMMENTED BY SVA ON 01-04-2005 FOR CUSTODIAN INVENTORY
						document.Form1.SCRIPT_STAT.disabled=true;
					}
					else{
						if(document.Form1.SCRIPT_STAT.value=="SC"){
							document.Form1.BUT_INV.disabled=false;
							document.Form1.BUT_INV_SL.disabled=true;
						}
						else{
							document.Form1.BUT_INV.disabled=true;
							document.Form1.BUT_INV_SL.disabled=false;
						}
						document.Form1.SCRIPT_STAT.disabled=true;
						//document.Form1.TXT_INSTYPE.focus();//COMMENTED BY SVA ON 01-04-2005 FOR CUSTODIAN INVENTORY
					}
					//----------------------------------------------------------------------------
				}
			}
		}
	}
	function dis_serial(){ 
		if(top.frames[1].frames[0].document.Form1.SCRIPT_STAT.value=="SL"){//$$##SC			
			parent.frames[1].document.Form1.TXT_SENOIDEN1.disabled=true;
			parent.frames[1].document.Form1.TXT_FACEVAL1.disabled=true;
			parent.frames[1].document.Form1.TXT_MISS1.disabled=true;
			parent.frames[1].document.Form1.HID_SCRIP_STAT.value="SL";
		}
		else if(top.frames[1].frames[0].document.Form1.SCRIPT_STAT.value=="SC"){
			
			parent.frames[1].document.Form1.TXT_SENOIDEN1.disabled=false;
			parent.frames[1].document.Form1.TXT_FACEVAL1.disabled=false;
			parent.frames[1].document.Form1.TXT_MISS1.disabled=false;
			parent.frames[1].document.Form1.HID_SCRIP_STAT.value="SC";
		}
		
	}
	//---------------------------------------------------
	
	
	
	function check_back_date(dayobj,monthobj,yearobj) {
		
		document.Form1.HID_VALDATETYPE1.value=dayobj.value+'-'+monthobj.value+'-'+yearobj.value;
		//alert(document.Form1.HID_VALDATETYPE1.value)
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?chksql=backdate_check&m_valuedate="+document.Form1.HID_VALDATETYPE1.value+"&sec="+document.Form1.TXT_SECIDEN.value+" ";
		//alert(m_url)
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		//alert(top.frames[0].document.applets[0].outvec_value)
		if(   (data_vec[0] > 0) &&  (  data_vec[1] >= 0) )   {	
			alert(" This Deal Is not possible!!!!!!!!!!!!!!!!!!! ")
		}			
	}
	
	
	function date_obj(){  
		document.Form1.HID_VALDATE.value=document.Form1.SEL_DATETYPE.value;
		document.Form1.HID_VALDATETYPE.value=document.Form1.SEL_DATETYPE.value;
		
		if(document.Form1.SEL_DATETYPE.value=="UD"){
			if (confirm("To enter a user defined date click on OK !")) {
				m_writedata ='<TD><INPUT TYPE="Text" class=\"txt_input5\" TABINDEX=0 NAME="TXT_DATE" SIZE=3 MAXLENGTH=2 ONCHANGE="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR)">'+
					'<INPUT TYPE="Text" NAME="TXT_MONTH" class=\"txt_input5\" SIZE=3 MAXLENGTH=2 ONCHANGE="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR)">'+
					'<INPUT TYPE="Text" NAME="TXT_YEAR" class=\"txt_input5\" SIZE=5 MAXLENGTH=4 ONCHANGE="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR);check_back_date(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR)"></TD>';
				newdate.innerHTML=m_writedata;	
				user_date=true;
				document.Form1.TXT_DATE.focus();			
			}
			if( (document.Form1.TXT_DATE.value=="")&&(document.Form1.TXT_MONTH.value=="")&&(document.Form1.TXT_YEAR.value=="") ){
				//alert('1');
			}else{
				document.Form1.HID_DATE.value=document.Form1.TXT_DATE.value;
				document.Form1.HID_MONTH.value=document.Form1.TXT_MONTH.value;
				document.Form1.HID_YEAR.value=document.Form1.TXT_YEAR.value;
				//alert('2-'+document.Form1.HID_YEAR.value);
				
			}
		}else{
			m_writedata ='<TD><INPUT TYPE="Hidden" NAME="HID_DATE" VALUE="01" SIZE=3 MAXLENGTH=2 >'+
				'<INPUT TYPE="Hidden" NAME="HID_MONTH" VALUE="01" SIZE=3 MAXLENGTH=2 >'+
				'<INPUT TYPE="Hidden" NAME="HID_YEAR" VALUE="1999" SIZE=5 MAXLENGTH=4 ></TD>';
		}
	}			
	
	
	
	function newpart2(){
		
		if (i1 == 1){
			m_row="";
			m_writedata ='<TABLE  WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >'+
				'<TR><TD><BR></TD></TR>'+
				'<TR><TD COLSPAN=\"4\"><B><U>Instrument & Security Information</B></TD></TR>'+
				'<TR><TD><BR></TD></TR>'+
				
				//ADDED BY SVA ON 22-03-2005 FOR CUSTODIAN AND BROKER INVENTORY 
				'<TR>'+
				'<TD WIDTH = "20%">Inventory Type</TD>'+
				'<TD WIDTH = "30%"><SELECT NAME="SEL_DEALTYPE" class=\"txt_input6\" ONBLUR="deal_type();">'+
				'<OPTION VALUE="CUSD" >Custodian</option>'+  
				'<OPTION VALUE="BROKER" SELECTED>Broker</option>'+ 
				'</SELECT></TD>'+
				'<TD WIDTH = "20%">'+
				'</TD>'+
				'<TD WIDTH = "30%">'+
				'</TD>'+
				'</TR>'+
				//END 
				
				'<TR>'+
				'<TD WIDTH = "20%">Instrument Type</TD>'+
				'<TD WIDTH = "30%"><INPUT TYPE="Text" NAME="TXT_INSTYPE" class=\"txt_input6\" ALIGN="LEFT" SIZE=22 MAXLENGTH=30 ONBLUR="insttype(document.Form1.TXT_INSTYPE)">'+
				'<INPUT TYPE="button" VALUE="Help" class=\"but_input\" NAME="BUT_INSTYPE" ONCLICK="inst_help(0)" "></TD>'+
				//----------------------------$$##SC----------------------------------------//
				'<TD WIDTH = "50%" colSpan="2"><INPUT TYPE="button" class=\"but_input\" VALUE="SL Inventory Details" NAME="BUT_INV_SL" style=\"width:200px\" ONCLICK="displaydata_SL(document.Form1.TXT_SCODE.value,document.Form1.TXT_INSTYPE.value,document.Form1.TXT_SECIDEN.value,document.Form1.TXT_BCODE.value,document.Form1.SEL_DEALTYPE.value)" >'+
				'</TD>'+
				//---------------------------------------------------------------------------//
				
				'</TR>'+
				'<TR>'+
				'<TD WIDTH = "20%">Security Identification</TD>'+
				'<TD WIDTH = "30%"><INPUT TYPE="Text" NAME="TXT_SECIDEN" class=\"txt_input6\" ALIGN="LEFT" SIZE=22 MAXLENGTH=30 ONBLUR="sectype(document.Form1.TXT_SECIDEN,document.Form1.TXT_INSTYPE)">'+
				'<INPUT TYPE="button" VALUE="Help" class=\"but_input\" NAME="BUT_SECIDEN" ONCLICK="sec_help(0)" ></TD>'+
				//'<TD><INPUT TYPE="button" VALUE="Inventory Details" NAME="BUT_INV" ONCLICK="displaydata(document.Form1.TXT_SCODE.value,document.Form1.TXT_INSTYPE.value,document.Form1.TXT_SECIDEN.value)" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD>'+
				//--------------------------$$##SC---------------------------------------//
				'<TD WIDTH = "50%" colSpan="2"><INPUT TYPE="button" VALUE="SC Inventory Details" class=\"but_input\" style=\"visibility:hidden\" NAME="BUT_INV" ONCLICK="displaydata(document.Form1.TXT_SCODE.value,document.Form1.TXT_INSTYPE.value,document.Form1.TXT_SECIDEN.value,document.Form1.TXT_BCODE.value)" >'+
				'</TD>'+
				//-----------------------------------------------------------------------//
				'</TR>'+
				'<TR>'+
				'<TD WIDTH = "20%">Issuer Code</TD>'+
				'<TD WIDTH = "30%"><INPUT TYPE="Text" NAME="TXT_ISSCODE" class=\"txt_input6\"	ALIGN="LEFT" SIZE=22 MAXLENGTH=30 ></TD>'+
				'<TD WIDTH = "20%">Issuer Name</TD>'+
				'<TD WIDTH = "30%"><INPUT TYPE="Text" style="width:180px" NAME="TXT_ISSNAME" class=\"txt_input6\"	ALIGN="LEFT" SIZE=28 MAXLENGTH=30 ></TD>'+
				'</TR>'+
				'<TR>'+
				'<TD WIDTH = "20%">Guarantor Code</TD>'+
				'<TD WIDTH = "30%"><INPUT TYPE="Text" NAME="TXT_GUCODE" class=\"txt_input6\"	ALIGN="LEFT" SIZE=22 MAXLENGTH=30></TD>'+
				'<TD WIDTH = "20%">Guarantor Name</TD>'+
				'<TD WIDTH = "30%"><INPUT TYPE="Text" style="width:180px" NAME="TXT_GUNAME" class=\"txt_input6\"	ALIGN="LEFT" SIZE=28 MAXLENGTH=30></TD>'+
				'</TR>'+
				'<TR>'+
				'<TD WIDTH = "20%">Endorser Code</TD>'+
				'<TD WIDTH = "30%"><INPUT TYPE="Text" NAME="TXT_ENCODE" class=\"txt_input6\" ALIGN="LEFT" SIZE=22 MAXLENGTH=10 ONBLUR="endcodex(document.Form1.TXT_INSTYPE,document.Form1.TXT_ENCODE)">'+
				'<INPUT TYPE="button" VALUE="Help" NAME="BUT_ENCODE" class=\"but_input\"  ONCLICK="end_help(0)" ></TD>'+
				'<TD WIDTH = "20%">Endorser Name</TD>'+
				'<TD WIDTH = "30%"><INPUT TYPE="Text" style="width:180px" NAME="TXT_ENNAME" class=\"txt_input6\"	ALIGN="LEFT" SIZE=28 MAXLENGTH=30 ONBLUR="newpart3();"></TD>'+
				'</TR>'+
				'</TABLE><HR WIDTH="*%">'+
				'<DIV ID="part3"></DIV>'; 
			i1=i1+1;
			document.getElementById('part2').innerHTML=m_writedata;	
		}		
	}
	
	function newpart3a(){
		if (j1==1){
			m_row="";
			m_writedata ='<TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0" >'+
				'<TR><TD><BR></TD></TR>'+
				'<TR><TD colspan="2"><B><U>Transaction Value Date & Amount Information</B></TD></TR>'+
				'<TR><TD><BR></TD></TR>'+
				
				'<TR>'+
				'<TD width="20%">Currency</TD>'+
				'<TD width="30%"><INPUT TYPE="Text" class=\"txt_input6\" NAME="TXT_CURR" ALIGN="LEFT" VALUE="SLR" SIZE=22 MAXLENGTH=30  ONBLUR="chk_currency(document.Form1.TXT_CURR)">'+
				'<INPUT TYPE="button" VALUE="Help" class=\"but_input\" NAME="BUT_CURR"  onClick="currency_help(0);"></TD>'+					
				'<TD width="20%">Custodial Status</TD>'+
				'<TD width="30%"><SELECT NAME="cust_stat" class=\"txt_input6\" >'+
				'<OPTION VALUE="Y" >Yes</option>'+  
				'<OPTION VALUE="N" SELECTED>No</option>'+  
				'</SELECT>'+
				'</TD>'+
				'</TR>'+
				'<TR>'+
				'<TD width="20%">Value Date</TD>'+
				'<TD width="30%" ID=newdate><SELECT class=\"txt_input6\"  NAME="SEL_DATETYPE"  onchange="date_obj()">'+
				'<OPTION VALUE="SPOT" SELECTED>Spot</option>'+  
				'<OPTION VALUE="TOM" >Tom</option>'+  
				'<OPTION VALUE="CASH" >Cash</option>'+  
				'<OPTION VALUE="UD">U / D</option>'+
				'</SELECT>'+
				
				//####------------ Added By Manjula on 20-07-2004 ----- Adding a new option called 'swift status'----VC of PCTF NO 0406-051-----
				'<TD width="20%">Swift Status</TD>'+
				'<TD width="30%"><SELECT class=\"txt_input6\" NAME="swift_stat" disabled>'+
				'<OPTION VALUE="Y" >Yes</option>'+  
				'<OPTION VALUE="N" >No</option>'+  
				'</SELECT>'+
				'</TD>'+
				
				
				//###------------------End here ------------------------VC of PCTF NO 0406-051-------------			
				
				
				
				'</TR>'+
				'<TD width="20%" colspan="4">'+
				'<INPUT TYPE="Hidden" NAME="HID_DATE" VALUE="01" SIZE=3 MAXLENGTH=2 >'+
				'<INPUT TYPE="Hidden" NAME="HID_MONTH" VALUE="01" SIZE=3 MAXLENGTH=2 >'+
				'<INPUT TYPE="Hidden" NAME="HID_YEAR" VALUE="1999" SIZE=5 MAXLENGTH=4 >'+
				'</TD>'+
				'<TR>'+
				'<TD width="20%">Basis</TD>'+
				'<TD width="30%"><INPUT TYPE="Text" NAME="TXT_BASIS" class=\"txt_input6\"  ALIGN="LEFT" SIZE=22 MAXLENGTH=30 ONBLUR="chk_basis(document.Form1.TXT_BASIS)">'+
				'<INPUT TYPE="button" VALUE="Help"  class=\"but_input\" NAME="BUT_BASIS" onClick="basis_help(0);"></TD>'+
				'<TD width="20%">Face Value</TD>';
			if(document.Form1.SCRIPT_STAT.value=="SL"){//$$##SC
				//m_writedata=m_writedata+'<TD><INPUT TYPE="Text" NAME="TXT_FACEVAL"	value=0 STYLE="text-align:right;" ALIGN="LEFT" SIZE=28 MAXLENGTH=30 TABINDEX=-1   onkeypress="checkkey(event)" ONBLUR="formatnum1(document.Form1.TXT_FACEVAL);display_limit_details_enable();"  ></TD>';  //ADD BY INDITHA 2005-7-11 1:13PM  VC05-001
				m_writedata=m_writedata+'<TD width="30%"><INPUT TYPE="Text" class=\"txt_input6\" NAME="TXT_FACEVAL"  value=0 STYLE="text-align:right;" ALIGN="LEFT" SIZE=28 MAXLENGTH=30 TABINDEX=-1  ONBLUR="formatnum1(document.Form1.TXT_FACEVAL);display_limit_details_enable();"  ></TD>';
			}
			else{
				m_writedata=m_writedata+'<TD width="30%"><INPUT TYPE="Text" class=\"txt_input6\" NAME="TXT_FACEVAL"	value=0 STYLE="text-align:right;" ALIGN="LEFT" SIZE=28 MAXLENGTH=30 TABINDEX=-1    ONBLUR="formatnum1(document.Form1.TXT_FACEVAL);display_limit_details_enable();" ></TD>'; <!--find_amount(document.Form1.TXT_FACEVAL.value);-->
			}
			//--------------------------------------------
			m_writedata=m_writedata+'<INPUT TYPE="Hidden" NAME="HID_FACEVAL">'+
				'</TR>'+
				'<TR>'+
				'<TD width="20%">Yield to Maturity %</TD>'+
				'<TD width="30%"><INPUT TYPE="Text" NAME="TXT_YIELD" class=\"txt_input6\" STYLE="text-align:right;" ALIGN="LEFT" SIZE=28 MAXLENGTH=30 TABINDEX=0 ONCHANGE="formatnum01(document.Form1.TXT_YIELD)" ONBLUR="curfocus()"></TD>'+
				'<INPUT TYPE="Hidden" NAME="HID_YIELD">'+
				'<TD width="20%">Cost</TD>'+  
				'<TD width="30%"><INPUT TYPE="Text" NAME="TXT_COST" class=\"txt_input6\"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=28 MAXLENGTH=30 TABINDEX=-1 ONCHANGE="formatnum2(document.Form1.TXT_COST)"></TD>'+
				'<INPUT TYPE="Hidden" NAME="HID_COST">'+
				'</TR>'+
				'<TR>'+
				'<TD width="20%">Price - Clean</TD>'+
				'<TD width="30%"><INPUT TYPE="Text" NAME="TXT_CLEAN" class=\"txt_input6\"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=28 MAXLENGTH=30 TABINDEX=-1 ONCHANGE="formatnum02(document.Form1.TXT_CLEAN)"></TD>'+
				'<INPUT TYPE="Hidden" NAME="HID_CLEAN">'+
				'<TD width="20%">Accrued Interest</TD>'+
				'<TD width="30%"><INPUT TYPE="Text" NAME="TXT_ACCINT" class=\"txt_input6\"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=28 MAXLENGTH=30 TABINDEX=-1 ONCHANGE="formatnum3(document.Form1.TXT_ACCINT);"></TD>'+
				'<INPUT TYPE="Hidden" NAME="HID_ACCINT">'+
				'</TR>'+
				'<TR>'+
				'<TD width="20%">Price - Dirty</TD>'+
				'<TD width="30%"><INPUT TYPE="Text" NAME="TXT_DIRTY" class=\"txt_input6\"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=28 MAXLENGTH=30 TABINDEX=-1 ONCHANGE="formatnum03(document.Form1.TXT_DIRTY)"></TD>'+
				'<INPUT TYPE="Hidden" NAME="HID_DIRTY">'+
				'<TD width="20%">Settlement Value</TD>'+
				'<TD width="30%"><INPUT TYPE="Text" NAME="TXT_SETVAL" class=\"txt_input6\"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=28 MAXLENGTH=30 TABINDEX=-1 ONCHANGE="formatnum4(document.Form1.TXT_SETVAL);"></TD>'+
				'<INPUT TYPE="Hidden" NAME="HID_SETVAL">'+
				'</TR>'+
				'</TABLE>'
				j1=j1+1;
			document.getElementById('part3').innerHTML=m_writedata;
			
			disp_swift_stat(); 	//-------------added by manjula on 21-07-2004 --VC of PCTF NO 0406-051-----
			change_opt(); 	//-----------------added by manjula on 21-07-2004 --VC of PCTF NO 0406-051-----
			
			document.Form1.HID_VALDATETYPE.value='SPOT';
			document.Form1.HID_VALDATE.value='SPOT';
		}		
		if (document.Form1.HID_TEST.value!=""){
			document.Form1.TXT_FACEVAL.value=document.Form1.HID_TEST.value;
		}
		defalt_b(document.Form1.TXT_INSTYPE.value);
	}
	
	function val_primary(){
		if (document.Form1.TXT_CLEAN.value=""){
		}
		else{
			document.Form1.TXT_CLEAN.value=unformat_noobject(document.Form1.TXT_CLEAN.value);
			document.Form1.TXT_DIRTY.value=unformat_noobject(document.Form1.TXT_DIRTY.value);
			document.Form1.TXT_YIELD.value=unformat_noobject(document.Form1.TXT_YIELD.value);
			
			if(document.Form1.CHB_PRIM.checked==true){
				document.Form1.TXT_CLEAN.value=format_noobject0(document.Form1.TXT_CLEAN.value,2);
				document.Form1.TXT_DIRTY.value=format_noobject0(document.Form1.TXT_DIRTY.value,2);
				document.Form1.TXT_YIELD.value=format_noobject0(document.Form1.TXT_YIELD.value,2);
			}
			else{
				document.Form1.TXT_CLEAN.value=format_noobject0(document.Form1.TXT_CLEAN.value,4);
				document.Form1.TXT_DIRTY.value=format_noobject0(document.Form1.TXT_DIRTY.value,4);
				document.Form1.TXT_YIELD.value=format_noobject0(document.Form1.TXT_YIELD.value,4);
			}
		}
	}
	
	function change_cal(){
		//CHANGEDED ON 25-06-2004 
		//alert();
		if (document.Form1.HID_TYPE_S.value=="P" && document.Form1.HID_TYPE_B.value=="P"){
			alert("Brokerage amount should be zero.");
			document.Form1.TXT_BROKER_COST.value=format_noobject("0");
			document.Form1.TXT_TOT_COST.value   =document.Form1.TXT_PURCH_COST.value
				document.Form1.HID_TOT_COST.value   =document.Form1.TXT_TOT_COST.value   
				//ADDED BY SVA ON 27-05-2004 FOR EQUITY CHANGERS
				document.Form1.TXT_SETAMO1.value=document.Form1.TXT_TOT_COST.value;
			//END
			
		}else if(document.Form1.HID_TYPE_B.value=="P"){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_t_cost="+unformat_noobject(document.Form1.TXT_TOT_COST.value)+"&m_p_cost="+unformat_noobject(document.Form1.TXT_PURCH_COST.value)+"&chksql=get_broker";					
			//window.open(m_url); 
			//top.frames[0].document.applets[0].getdata(m_url);
			load_interface(m_url,'XML');
			m_size=data_vec.length;
			if(m_size>0) {
				v_def =data_vec[0];
			}
			
			//v_def =parseFloat(unformat_noobject(document.Form1.TXT_TOT_COST.value))-parseFloat(unformat_noobject(document.Form1.TXT_PURCH_COST.value));
			if(v_def>=0){
				document.Form1.TXT_BROKER_COST.value=format_noobject(v_def);
				//ADDED BY SVA ON 27-05-2004 FOR EQUITY CHANGERS
				parent.frames[1].document.Form1.TXT_SETAMO1.value=document.Form1.TXT_TOT_COST.value;
				//END
			}else{
				alert("Sorry, Total Cost should not be less than Purchase Cost ");
				document.Form1.TXT_TOT_COST.value = document.Form1.HID_TOT_COST.value;
				document.Form1.TXT_TOT_COST.focus();
				
			}
		}else if(document.Form1.HID_TYPE_S.value=="P"){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_t_cost="+unformat_noobject(document.Form1.TXT_PURCH_COST.value)+"&m_p_cost="+unformat_noobject(document.Form1.TXT_TOT_COST.value)+"&chksql=get_broker";					
			//window.open(m_url); 
			load_interface(m_url,'XML');
			m_size=data_vec.length;
			if(m_size>0) {
				v_def =data_vec[0];
			}
			//v_def =parseFloat(unformat_noobject(document.Form1.TXT_PURCH_COST.value))-parseFloat(unformat_noobject(document.Form1.TXT_TOT_COST.value));
			if(v_def>=0){
				document.Form1.TXT_BROKER_COST.value=format_noobject(v_def);
				//ADDED BY SVA ON 27-05-2004 FOR EQUITY CHANGERS
				parent.frames[1].document.Form1.TXT_SETAMO1.value=document.Form1.TXT_TOT_COST.value;
				//END
			}else{
				alert("Sorry, Total Cost should not be grater than Purchase Cost ");
				document.Form1.TXT_TOT_COST.value = document.Form1.HID_TOT_COST.value;
				document.Form1.TXT_TOT_COST.focus();
				
			}
		}
	}
	
	//---------------------- Added by S.Shanheetha on 07-06-2007 ----- --------------------------------
	
	function checkmargintradingdate(dayobj,monthobj,yearobj) {
		buy_sett_date=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buy_sett_date="+buy_sett_date+"&chksql=chk_margin_trading_date_with_value_date2"; //CHANGE BY WARUNA 2011-02-14 chk_margin_trading_date_with_value_date
		//top.frames[0].document.applets[0].getdata(m_url);
		load_interface(m_url,'XML',false);
		m_size= data_vec.length;
		
		document.Form1.HID_BUY_SETT_DATE.value=data_vec[0];
		//	alert(document.Form1.HID_BUY_SETT_DATE.value);
		if(document.Form1.HID_BUY_SETT_DATE.value=="NO"){
			alert("Buyer Settlement Date is not greater than the Last Margin Trading Routine Date, Please Re-Enter the Buyer Settlement Date !.");
			dayobj.value=" ";	monthobj.value=" ";yearobj.value=" ";dayobj.focus();
		}
		else{
			
		}
	}	
	
	function checkmargintradingdate2(dayobj,monthobj,yearobj) {
		buy_sett_date=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buy_sett_date="+buy_sett_date+"&chksql=chk_margin_trading_date_with_value_date2";//CHANGE BY WARUNA 2011-02-14 chk_margin_trading_date_with_value_date
		//top.frames[0].document.applets[0].getdata(m_url);
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		
		document.Form1.HID_BUY_SETT_DATE.value=data_vec[0];
		
		if(document.Form1.HID_BUY_SETT_DATE.value=="NO"){
			alert("Seller Settlement Date is not greater than the Last Margin Trading Routine Date, Please Re-Enter the Seller Settlement Date !.");
			dayobj.value=" ";	monthobj.value=" ";yearobj.value=" ";dayobj.focus();
		}
		else{
			
		}
	}	
	//----------------------- End of Modifications on 07-06-2007 -----------------------------------
	
	function newpart3b(){			
		m_row="";
		m_writedata ='<TABLE  WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >'+
			'<TR><TD><BR></TD></TR>'+
			'<TR><TD><B><U>Share Information</U></B></TD></TR>'+
			'<TR><TD><BR></TD></TR>'+
			
			'<TR>'+
			'<TD width="20%">Value Date</TD>'+
			'<TD width="30%" ><INPUT TYPE="Text" NAME="TXT_DATE" class=\"txt_input5\" SIZE=3 MAXLENGTH=2  ONBLUR="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR)">'+//checkallvalues
			'<INPUT TYPE="Text" NAME="TXT_MONTH" SIZE=3 class=\"txt_input5\" MAXLENGTH=2  ONBLUR="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR)">'+//checkallvaluesmon
			'<INPUT TYPE="Text" NAME="TXT_YEAR" SIZE=5 class=\"txt_input5\"  MAXLENGTH=4   ONBLUR="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR);document.Form1.TXT_CLEAN.focus();"></TD>'+													
			
			'<TD width="20%" >Purchase Cost</TD>'+
			'<TD width="30%" ><INPUT TYPE="Text" NAME="TXT_PURCH_COST" class=\"txt_input6\"	STYLE="text-align:right;" ALIGN="RIGHT" SIZE=25 MAXLENGTH=25   ></TD>'+
			
			
			
			'</TR>'+					
			'<TR>'+
			'<TD width="20%" >Price per share</TD>'+
			'<TD width="30%" ><INPUT TYPE="Text" NAME="TXT_CLEAN" class=\"txt_input6\"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25  MAXLENGTH=25  ONBLUR="check_sharePrice();check();" ></TD>'+		//formatnumequity(document.Form1.TXT_CLEAN);	document.Form1.TXT_FACEVAL.focus();																									
			'<TD width="20%" >Broker and Other Cost</TD>'+
			'<TD width="30%"><SELECT NAME="SEL_BROKER" class=\"txt_input6\" style="width:40px"  onchange="get_broker_cost()">'+ 
			'<OPTION VALUE="Y" SELECTED>Yes</option>'+  
			'<OPTION VALUE="N" >No</option>'+  
			'</SELECT><INPUT TYPE="Text" NAME="TXT_BROKER_COST" class=\"txt_input6\"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25  ONBLUR="formatnumequity(document.Form1.TXT_BROKER_COST);get_total()"  VALUE=0 DISABLED></TD>'+
			'</TR>'+
			
			'<TR>'+
			'<TD width="20%">No of shares</TD>'+
			'<TD width="30%"><INPUT TYPE="Text" NAME="TXT_FACEVAL" class=\"txt_input6\"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25   ONBLUR="check_share();"></TD>'+//get_broker();
			'<TD width="20%">Total Cost</TD>'+
			'<TD width="30%"><INPUT TYPE="Text" NAME="TXT_TOT_COST" class=\"txt_input6\"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25 ONBLUR="change_cal();formatnumequity(document.Form1.TXT_TOT_COST)" ></TD>'+
			'</TR>'+
			
			/*'<TR>'+ remove par val by waruna 2012-04-27
			'<TD width="20%">Par Value</TD>'+
			'<TD width="30%"><INPUT TYPE="Text" NAME="TXT_PAR" class=\"txt_input6\"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25 TABINDEX=-1 ONBLUR="formatnumequity(document.Form1.TXT_PAR)"  ></TD>'+
			'<TD width="20%">Buyer Settle Date</TD>'+
			'<TD width="30%"><INPUT TYPE="Text" TABINDEX=0 class=\"txt_input5\" NAME="TXT_BDATE" SIZE=3 MAXLENGTH=2 ONBLUR="checkallvaluesmonset(document.Form1.TXT_BDATE,document.Form1.TXT_BMONTH,document.Form1.TXT_BYEAR);">'+
			'<INPUT TYPE="Text" NAME="TXT_BMONTH" class=\"txt_input5\" SIZE=3 MAXLENGTH=2 ONBLUR="checkallvaluesmonset(document.Form1.TXT_BDATE,document.Form1.TXT_BMONTH,document.Form1.TXT_BYEAR)">'+
			'<INPUT TYPE="Text" NAME="TXT_BYEAR" SIZE=5 class=\"txt_input5\" MAXLENGTH=4 ONBLUR="chkstartdate1(document.Form1.TXT_BDATE,document.Form1.TXT_BMONTH,document.Form1.TXT_BYEAR);checkmargintradingdate(document.Form1.TXT_BDATE,document.Form1.TXT_BMONTH,document.Form1.TXT_BYEAR);"></TD>'+													
			'</TR>'+
			'<TR>'+
			'<TD width="20%">Nominal Value</TD>'+
			'<TD width="30%"><INPUT TYPE="Text" NAME="TXT_NOMINAL" class=\"txt_input6\"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25 TABINDEX=-1 ONBLUR="formatnumequity(document.Form1.TXT_NOMINAL)" ></TD>'+
			'<TD width="20%">Seller Settle Date</TD>'+
			'<TD width="30%"><INPUT TYPE="Text" TABINDEX=0 NAME="TXT_SDATE" class=\"txt_input5\" SIZE=3 MAXLENGTH=2 ONBLUR="checkallvaluesmonset(document.Form1.TXT_SDATE,document.Form1.TXT_SMONTH,document.Form1.TXT_SYEAR)">'+
			'<INPUT TYPE="Text" NAME="TXT_SMONTH" SIZE=3  class=\"txt_input5\" MAXLENGTH=2 ONBLUR="checkallvaluesmonset(document.Form1.TXT_SDATE,document.Form1.TXT_SMONTH,document.Form1.TXT_SYEAR)">'+
			'<INPUT TYPE="Text" NAME="TXT_SYEAR" SIZE=5  class=\"txt_input5\" MAXLENGTH=4 ONBLUR="chkstartdate1(document.Form1.TXT_SDATE,document.Form1.TXT_SMONTH,document.Form1.TXT_SYEAR);checkmargintradingdate2(document.Form1.TXT_SDATE,document.Form1.TXT_SMONTH,document.Form1.TXT_SYEAR);"></TD>'+													
			'</TR>'+
			
			'<TR>'+
			'<TD width="20%" >Contract No</TD>'+
			'<TD width="30%" ><INPUT TYPE="Text" NAME="TXT_contract" class=\"txt_input6\"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=100></TD>'+
			'<TD width="20%"></TD>'+
			'<TD width="30%">'+
			'<INPUT TYPE="Hidden" NAME="HID_DATE" VALUE="01" SIZE=3 MAXLENGTH=2 >'+
			'<INPUT TYPE="Hidden" NAME="HID_MONTH" VALUE="01" SIZE=3 MAXLENGTH=2 >'+
			'<INPUT TYPE="Hidden" NAME="HID_YEAR" VALUE="1999" SIZE=5 MAXLENGTH=4 >'+
			'<INPUT TYPE="Hidden" NAME="HID_BUY_SETT_DATE" VALUE="" >'+//---Added by S.Shanheetha on 07-06-2007 .
			
			'</TD>'+
			
			'</TR>'+
			*/
			
			'<TR>'+
			'<TD width="20%">Nominal Value</TD>'+
			'<TD width="30%"><INPUT TYPE="Text" NAME="TXT_NOMINAL" class=\"txt_input6\"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25 TABINDEX=-1 ONBLUR="formatnumequity(document.Form1.TXT_NOMINAL)" ></TD>'+
			'<TD width="20%">Buyer Settle Date</TD>'+
			'<TD width="30%"><INPUT TYPE="Text" TABINDEX=0 class=\"txt_input5\" NAME="TXT_BDATE" SIZE=3 MAXLENGTH=2 ONBLUR="checkallvaluesmonset(document.Form1.TXT_BDATE,document.Form1.TXT_BMONTH,document.Form1.TXT_BYEAR);">'+
			'<INPUT TYPE="Text" NAME="TXT_BMONTH" class=\"txt_input5\" SIZE=3 MAXLENGTH=2 ONBLUR="checkallvaluesmonset(document.Form1.TXT_BDATE,document.Form1.TXT_BMONTH,document.Form1.TXT_BYEAR)">'+
			'<INPUT TYPE="Text" NAME="TXT_BYEAR" SIZE=5 class=\"txt_input5\" MAXLENGTH=4 ONBLUR="chkstartdate1(document.Form1.TXT_BDATE,document.Form1.TXT_BMONTH,document.Form1.TXT_BYEAR);checkmargintradingdate(document.Form1.TXT_BDATE,document.Form1.TXT_BMONTH,document.Form1.TXT_BYEAR);"></TD>'+													
			'</TR>'+
			'<TR>'+
			'<TD width="20%">Contract No</TD>'+
			'<TD width="30%"><INPUT TYPE="Text" NAME="TXT_contract" class=\"txt_input6\"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=100></TD>'+
			'<TD width="20%">Seller Settle Date</TD>'+
			'<TD width="30%"><INPUT TYPE="Text" TABINDEX=0 NAME="TXT_SDATE" class=\"txt_input5\" SIZE=3 MAXLENGTH=2 ONBLUR="checkallvaluesmonset(document.Form1.TXT_SDATE,document.Form1.TXT_SMONTH,document.Form1.TXT_SYEAR)">'+
			'<INPUT TYPE="Text" NAME="TXT_SMONTH" SIZE=3  class=\"txt_input5\" MAXLENGTH=2 ONBLUR="checkallvaluesmonset(document.Form1.TXT_SDATE,document.Form1.TXT_SMONTH,document.Form1.TXT_SYEAR)">'+
			'<INPUT TYPE="Text" NAME="TXT_SYEAR" SIZE=5  class=\"txt_input5\" MAXLENGTH=4 ONBLUR="chkstartdate1(document.Form1.TXT_SDATE,document.Form1.TXT_SMONTH,document.Form1.TXT_SYEAR);checkmargintradingdate2(document.Form1.TXT_SDATE,document.Form1.TXT_SMONTH,document.Form1.TXT_SYEAR);"></TD>'+													
			'</TR>'+
			
			'<TR>'+
			'<TD width="20%" ></TD>'+
			'<TD width="30%" ></TD>'+
			'<TD width="20%"></TD>'+
			'<TD width="30%">'+
			'<INPUT TYPE="Hidden" NAME="HID_DATE" VALUE="01" SIZE=3 MAXLENGTH=2 >'+
			'<INPUT TYPE="Hidden" NAME="HID_MONTH" VALUE="01" SIZE=3 MAXLENGTH=2 >'+
			'<INPUT TYPE="Hidden" NAME="HID_YEAR" VALUE="1999" SIZE=5 MAXLENGTH=4 >'+
			'<INPUT TYPE="Hidden" NAME="HID_BUY_SETT_DATE" VALUE="" >'+//---Added by S.Shanheetha on 07-06-2007 .
			
			'</TD>'+
			
			'</TR>'+
			'</TABLE>';				 
		document.getElementById('part3').innerHTML=m_writedata;
		document.Form1.TXT_PAR.value=document.Form1.HID_PAR_VALUE.value;
		document.Form1.TXT_PAR.disabled=true;
		m_url1=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities?chksql=get_date_system_new";
		//top.frames[0].document.applets[0].getdata(m_url1);
		load_interface(m_url1,'XML',false);
		m_size=data_vec.length;	
		document.Form1.TXT_DATE.value  =data_vec[0];
		document.Form1.TXT_MONTH.value =data_vec[1];
		document.Form1.TXT_YEAR.value  =data_vec[2];
		
		document.Form1.HID_DATE.value=document.Form1.TXT_DATE.value;
		document.Form1.HID_MONTH.value=document.Form1.TXT_MONTH.value;
		document.Form1.HID_YEAR.value=document.Form1.TXT_YEAR.value;
		//alert('3-'+document.Form1.HID_YEAR.value);
		get_settle_dates();
		document.Form1.TXT_FACEVAL.value  = document.Form1.HID_NO_SHARES.value;  
		
	}
	
	function newpart3()
	{
		m_url1=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities?chksql=get_inst_cat&inst="+document.Form1.TXT_INSTYPE.value+"";
		//top.frames[0].document.applets[0].getdata(m_url1);
		load_interface(m_url1,'XML',false);
		m_size=data_vec.length;	
		if(m_size>0){//add if by waruna 2011-05-26
			inst_cat=data_vec[0];		
			document.Form1.HID_DEAL_TYPE.value=data_vec[0];		
			document.Form1.HID_YIELD_TYPE.value=data_vec[1];
			parent.frames[1].document.Form1.HID_DEAL_TYPE.value=data_vec[0];
			
			if (inst_cat== "DEBT" ){	
				newpart3a()
			}
			else
			{
				newpart3b();
			}
			
		}else{
			alert('Please Select Instrument Type')
		}								
	}
	
	
	function get_broker_cost()
	{
		
		document.Form1.TXT_TOT_COST.value    = "0";
		document.Form1.HID_TOT_COST.value   =document.Form1.TXT_TOT_COST.value   
			if (document.Form1.SEL_BROKER.value == "N") {					
				document.Form1.TXT_BROKER_COST.disabled = false;
				document.Form1.TXT_BROKER_COST.value    = "";
				alert("Please enter the broker cost.")
				document.Form1.TXT_BROKER_COST.focus();
				
				
			}
			else{
				
				//document.Form1.TXT_BROKER_COST.value    = "0";
				//document.Form1.TXT_BROKER_COST.disabled = true;
				//get_total();
				getnominal_value()
				get_broker();
				get_total();
				document.Form1.TXT_BROKER_COST.disabled = true;
				
			}					
	}		
	
	
	
	
	//----------------------------GROUP DEALS----------------------------------------------//
	
	
	function group_deals(){
		group_deal.innerHTML="";
		group_deal_tot.innerHTML="";
		if((document.Form1.TXT_BCODE.value=="GROUP") ||(document.Form1.TXT_SCODE.value=="GROUP")){
			m_writedata22 ="";
			m_writedata22 ="<HR WIDTH=\"*%\">"+ 
				"<TABLE WIDTH=\"100%\"BORDER=\"0\" CELLPADDING=\"1\" CELLSPACING=\"0\" >"+
				"<TR>"+
				"<TD WIDTH=\"25%\" ALIGN=\"left\"><B><U>Group Deal Information</B></TD>"+
				"<TD WIDTH=\"20%\" ALIGN=\"CENTER\"></TD>"+
				"<TD WIDTH=\"40%\" ALIGN=\"CENTER\"></TD>"+
				"<TD WIDTH=\"15%\" ALIGN=\"CENTER\"></TD>"+
				"</TR>"+
				"<TR></TR><TR></TR><TR></TR><TR></TR><TR></TR>"+
				"<TR>"+
				"<TD WIDTH=\"25%\" ALIGN=\"CENTER\"><B>Counter Party Code</B></TD>"+
				"<TD WIDTH=\"20%\" ALIGN=\"CENTER\"><B>Counter Party Name</B></TD>"+
				"<TD WIDTH=\"40%\" ALIGN=\"CENTER\"><B>Face Value</B></TD>"+
				"<TD WIDTH=\"15%\" ALIGN=\"CENTER\"></TD>"+
				"</TR>"+
				"<TR></TR><TR></TR>"+
				"<TR>"+
				"<TD WIDTH=\"25%\" ALIGN=\"CENTER\">"+
				"<input type=\"text\" name=\"txt_cp1\" class=\"txt_input6\" size=\"15\" onblur=\"get_count(1)\">"+
				"<input type=\"button\" name=\"but_coun_help1\"   value=\"Help\" onclick=\"get_count_help(1)\">"+
				"<input type=\"hidden\" name=\"hid_cp1\"></TD>"+
				"<TD WIDTH=\"20%\" ALIGN=\"CENTER\">"+
				"<input type=\"text\" name=\"txt_cp_name1\" class=\"txt_input6\"  size=\"30\" ></TD>"+
				"<TD WIDTH=\"40%\" ALIGN=\"CENTER\">"+
				"<input type=\"text\" name=\"txt_face1\" class=\"txt_input6\" size=\"30\" STYLE=\"text-align:right;\" onblur=\"format_nogroup(1);\" value=0>"+
				"<input type=\"hidden\" name=\"hid_face1\" value=0>"+
				" <input type=\"button\" name=\"but_dele1\"   value=\"X\" onclick=\"del_rec(1)\">"+
				"<input type=\"hidden\" name=\"hid_cost1\" value=0>"+
				"<input type=\"hidden\" name=\"hid_accint1\" value=0>"+
				"<input type=\"hidden\" name=\"hid_settvalu1\" value=0>"+
				"</TD>"+
				"<TD WIDTH=\"15%\" ALIGN=\"CENTER\"></TD>"+
				"</TR>"+
				"</table>";
			group_deal.innerHTML=group_deal.innerHTML+m_writedata22;
			//--------------------TOTAL-------------------
			m_writedata66 ="";
			m_writedata66 ="<TABLE WIDTH=\"100%\"  BORDER=\"0\" CELLPADDING=\"1\" CELLSPACING=\"0\" >"+
				"<TR>"+
				"<TD WIDTH=\"20%\"></td>"+
				"<TD WIDTH=\"25%\" ALIGN=\"right\" >mismatch</TD>"+
				"<TD WIDTH=\"40%\" ALIGN=\"CENTER\" >"+
				"<input type=\"text\" class=\"txt_input6\"  STYLE=\"text-align:right;\" name=\"txt_face_tot\" size=\"30\"onblur=\"format_notot();\"  value="+format_noobject(document.Form1.HID_FACEVAL.value)+"  disabled >"+//
			"<input type=\"hidden\" name=\"hid_face_tot\" value="+document.Form1.HID_FACEVAL.value+"></td>"+//
				"<TD WIDTH=\"10%\" >"+
				"<input type=\"button\" name=\"but_morerec\"   value=\"more\" onclick=\"disp_more()\">"+
				"</TD>"+
				"</TR>"+
				"</table>";
			group_deal_tot.innerHTML=group_deal_tot.innerHTML+m_writedata66;
			document.Form1.txt_cp1.focus();
		}
	}
	function disp_more(){
		g_line=g_line+1;
		m_writedata11 ="<TABLE WIDTH=\"100%\"BORDER=\"0\" CELLPADDING=\"1\" CELLSPACING=\"0\" >"+
			"<TR>"+
			"<TD WIDTH=\"25%\" ALIGN=\"CENTER\">"+
			"<input type=\"text\"  class=\"txt_input6\" name=\"txt_cp"+g_line+"\" size=\"15\" onblur=\"get_count("+g_line+")\">"+
			"<input type=\"button\" name=\"but_coun_help"+g_line+"\"   value=\"Help\" onclick=\"get_count_help("+g_line+")\">"+
			"<input type=\"hidden\" name=\"hid_cp"+g_line+"\"></TD>"+
			"<TD WIDTH=\"20%\" ALIGN=\"CENTER\">"+
			"<input type=\"text\" class=\"txt_input6\" name=\"txt_cp_name"+g_line+"\" size=\"30\" ></TD>"+
			"<TD WIDTH=\"40%\" ALIGN=\"CENTER\">"+
			"<input type=\"text\"  class=\"txt_input6\" name=\"txt_face"+g_line+"\" size=\"30\" STYLE=\"text-align:right;\" onblur=\"format_nogroup("+g_line+");\" value=0.00>"+
			"<input type=\"hidden\" name=\"hid_face"+g_line+"\" value=0 >"+
			" <input type=\"button\" name=\"but_dele"+g_line+"\"   value=\"X\" onclick=\"del_rec("+g_line+")\">"+
			"<input type=\"hidden\" name=\"hid_cost"+g_line+"\" value=0>"+
			"<input type=\"hidden\" name=\"hid_accint"+g_line+"\" value=0>"+
			"<input type=\"hidden\" name=\"hid_settvalu"+g_line+"\" value=0>"+
			"</TD>"+
			"<TD WIDTH=\"15%\" ALIGN=\"CENTER\"></TD>"+
			"</TR>"+
			"</table>";
		//alert(m_writedata11);
		group_deal.innerHTML=group_deal.innerHTML+m_writedata11;
		document.Form1.HID_GROUPROW.value=g_line;
	}
	
	
	function del_rec(lin){
		m_txt_cp="txt_cp"+lin;
		m_txt_cp=document.Form1.elements[m_txt_cp];
		m_txt_cp.value="";
		m_txt_cp_name="txt_cp_name"+lin;
		m_txt_cp_name=document.Form1.elements[m_txt_cp_name];
		m_txt_cp_name.value="";
		m_txt_face="txt_face"+lin;
		m_txt_face=document.Form1.elements[m_txt_face];
		m_txt_face_tot="txt_face_tot";
		m_txt_face_tot=document.Form1.elements[m_txt_face_tot];
		m_txt_face_tot.value=format_noobject(parseFloat(unformat_noobject(m_txt_face_tot.value))+parseFloat(unformat_noobject(m_txt_face.value)));
		m_txt_face.value="0.00";
		m_hid_face="hid_face"+lin;
		m_hid_face=document.Form1.elements[m_hid_face];		
		m_hid_face.value=0;
	}
	
	function format_nogroup(line){
		m_val="txt_face"+line;
		m_val=document.Form1.elements[m_val];
		m_totval="txt_face_tot";
		m_totval=document.Form1.elements[m_totval];
		m_hidval="hid_face"+line;
		m_hidval=document.Form1.elements[m_hidval];		
		m_newtot=(parseFloat(unformat_noobject(m_totval.value))+parseFloat(m_hidval.value))-parseFloat(unformat_noobject(m_val.value));
		m_totval.value=format_noobject(m_newtot);
		m_val.value=format_noobject(m_val.value);
		m_hidval.value=unformat_noobject(m_val.value);
		//------bond calculator-------------------------------//
		mn_clean_price=unformat_noobject(document.Form1.TXT_CLEAN.value);
		mn_face_value=parseFloat(unformat_noobject(m_val.value));
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_seccode="+document.Form1.TXT_SECIDEN.value+"&m_pricec="+mn_clean_price+"&m_valuedate="+document.Form1.HID_VALDATETYPE.value+"&m_faceval="+mn_face_value+"&chksql=Ccla_threeval";
		//top.frames[0].document.applets[0].getdata(m_url);	
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url1,'XML',false);
		m_size=data_vec.length;	
		m_hid_cost="hid_cost"+line;
		m_hid_cost=document.Form1.elements[m_hid_cost];		
		m_hid_accint="hid_accint"+line;
		m_hid_accint=document.Form1.elements[m_hid_accint];		
		m_hid_settvalu="hid_settvalu"+line;
		m_hid_settvalu=document.Form1.elements[m_hid_settvalu];		
		m_hid_cost.value=data_vec[0];
		m_hid_accint.value=data_vec[1];
		m_hid_settvalu.value=data_vec[2];
		m_hid_cost.value=unformat_noobject(m_hid_cost.value);
		m_hid_accint.value=unformat_noobject(m_hid_accint.value);
		m_hid_settvalu.value=unformat_noobject(m_hid_settvalu.value);
		//--------------------------------------------------------	
	}
	function format_notot(){
		m_totval="txt_face_tot";
		m_totval=document.Form1.elements[m_totval];
		m_totval.value=format_noobject(m_totval.value);
	}
	/*
	function get_count_help(m_line){
		m_countval="txt_cp"+m_line;
		m_countval=document.Form1.elements[m_countval];
		m_countname="txt_cp_name"+m_line;
		m_countname=document.Form1.elements[m_countname];
		
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+(m_countval.value).toUpperCase()+"&chksql=buyer_lookup_group";
		top.frames[0].document.applets[0].getdata(m_url);
		m_size=top.frames[0].document.applets[0].outvec_value.size();
		vec_pos=0;
		lineno=1;
		m_row="";
		while (vec_pos<m_size) {
			m_issu_code=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
			m_issu_name=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
			m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+'><B>'+m_issu_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_issu_name+'</B></TD></TR>';
			vec_pos=vec_pos+2;
			lineno=lineno+1;
		}
		m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" >'+
			'<TR ><TD WIDTH="30%"><B>Buyer Code</B></TD>' +
			'<TD WIDTH="70%"><B>Buyer Name</B></TD></TR>'+
			m_row+
			'</TABLE>'; 
		myDialogObj.htmlstr = m_writedata;
		myDialogObj.returnval = "";
		popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		abc=top.frames[0].document.applets[0].outvec_value.indexof(myDialogObj.returnval);
		m_countval.value=top.frames[0].document.applets[0].outvec_value.elementAt(abc);
		m_countname.value=top.frames[0].document.applets[0].outvec_value.elementAt(abc+1);
	}	
	*/
	
	function get_count(m_line){
		m_countval="txt_cp"+m_line;
		m_countval=document.Form1.elements[m_countval];
		m_countname="txt_cp_name"+m_line;
		m_countname=document.Form1.elements[m_countname];
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+(m_countval.value).toUpperCase()+"&chksql=buyer_group";
		top.frames[0].document.applets[0].getdata(m_url);
		m_size=top.frames[0].document.applets[0].outvec_value.size();
		if(m_size!=2){
			get_count_help(m_line);
		}
		else{
			m_countval.value=top.frames[0].document.applets[0].outvec_value.elementAt(0);
			m_countname.value=top.frames[0].document.applets[0].outvec_value.elementAt(1);
		}
	}
	
	function checkkey(e){//$$##SC  
		if(e.keyCode==46){
			alert("You are not allowed to enter cents");
			e.keyCode=0;
		}
	}
	
	//####------------ Added By Manjula on 20-07-2004 ----- Adding a new option called 'swift status'----VC of PCTF NO 0406-051-----
	
	function change_opt()
	{
		if(document.Form1.swift_stat.value=="Y"){
			document.Form1.cust_stat.value="N";
			
		}else if(document.Form1.swift_stat.value=="N"){  
			document.Form1.cust_stat.value="Y";
			
		}
	}
	
	function disp_swift_stat()
	{
		m_buyer_code=document.Form1.TXT_BCODE.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+m_buyer_code+"&chksql=swift_status";
		//top.frames[0].document.applets[0].getdata(m_url);
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		//alert(m_size);
		//alert(top.frames[0].document.applets[0].outvec_value);
		if (m_size>0){
			//alert("ok");
			document.Form1.swift_stat.value=data_vec[0];
		}
	}
	
	//####------------ End Here ---------VC of PCTF NO 0406-051-----------------------	
	
	
	//added By Nilu on 27-9-2004/15:17 to check the share price. SRF 0409-071 No-08
	function check_sharePrice(){ 
		if (document.Form1.TXT_CLEAN.value=="0"){        
			alert("Share Price is zero.");
		}
	}
	
	
	
	function buyer_help(m_strat){
		var aForm;    //  aForm =oForm.elements;
		aForm =  document.getElementById('Form1');
		
		
		var myObject=new Array(); //return values set to this object
		myObject[0]=aForm.TXT_BCODE;
		myObject[1]=aForm.TXT_BNAME;
		myObject[2]=null;
		myObject[3]=null;
		myObject[4]=null;
		
		var myObject_value=new Array(); //passing values set to this object
		myObject_value[0]=aForm.TXT_BCODE.value;
		myObject_value[1]=aForm.TXT_BCODE.value;//aForm.oLastName2.value;
		myObject_value[2]=aForm.TXT_BCODE.value;
		myObject_value[3]=aForm.TXT_BCODE.value;
		myObject_value[4]= username;
		
		
		var myObject_type=new Array(); //passing values data type
		myObject_type[0]="StringL";
		myObject_type[1]="StringL";
		myObject_type[2]="StringL";
		myObject_type[3]="StringL";
		myObject_type[4]="String";
		
		var qid='59';
		
		title_name='Buyer Code';
		var url = 'popup.jsp';
		var close_fun='buyer_help_close';			
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
					if(returnedValue == null){buyer_help_close();} 
					if(returnedValue != null){load_sett_details();} 
					if(returnedValue != null){buyercode1(document.Form1.TXT_BCODE,document.Form1.TXT_BNAME);}
				} 
			});
		
		
	}
	
	
	function buyer_help1(m_strat){
		var aForm;    //  aForm =oForm.elements;
		aForm =  document.getElementById('Form1');
		
		
		var myObject=new Array(); //return values set to this object
		myObject[0]=aForm.TXT_SCODE;
		myObject[1]=aForm.TXT_SNAME;
		myObject[2]=null;
		myObject[3]=null;
		myObject[4]=null;
		
		var myObject_value=new Array(); //passing values set to this object
		myObject_value[0]=aForm.TXT_SCODE.value;
		myObject_value[1]=aForm.TXT_SCODE.value;//aForm.oLastName2.value;
		myObject_value[2]=aForm.TXT_SCODE.value;
		myObject_value[3]=aForm.TXT_SCODE.value;
		myObject_value[4]=username;
		
		
		var myObject_type=new Array(); //passing values data type
		myObject_type[0]="StringL";
		myObject_type[1]="StringL";
		myObject_type[2]="StringL";
		myObject_type[3]="StringL";
		myObject_type[4]="String";
		
		var qid='59';
		
		
		title_name='Seller Code';
		var url = 'popup.jsp';
		var close_fun='buyer_help_close';			
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
					if(returnedValue == null){buyer_help_close();} 
					if(returnedValue != null){load_sett_details();} 
					if(returnedValue != null){document.Form1.TXT_SCODE.focus();}
					
					if(returnedValue != null){buyercode2(document.Form1.TXT_SCODE,document.Form1.TXT_SNAME);}
				} 
			});
		
		
	}
	
	
	function inst_help(m_strat){
		var aForm;    //  aForm =oForm.elements;
		aForm =  document.getElementById('Form1');
		
		
		var myObject=new Array(); //return values set to this object
		myObject[0]=aForm.TXT_INSTYPE;
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
		
		var qid='64';
		
		
		title_name='Instrument Code';
		var url = 'popup.jsp';
		var close_fun='inst_help_close';			
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
					if(returnedValue == null){inst_help_close();} 
					if(returnedValue != null){load_sett_details();} 
					if(returnedValue != null){
						document.Form1.TXT_INSTYPE.focus();
						m_url1=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities?chksql=get_inst_cat&inst="+document.Form1.TXT_INSTYPE.value+"";
						load_interface(m_url1, 'XML',false);
						m_size=data_vec.length;				
						inst_cat=data_vec[0];		
						document.Form1.HID_DEAL_TYPE.value=data_vec[0];
						//parent.frames[1].document.Form1.HID_DEAL_TYPE.value=data_vec[0];
					}
				} 
			});
		
		
	}
	
	
	function sec_help(m_strat){
		var aForm;    //  aForm =oForm.elements;
		aForm =  document.getElementById('Form1');
		
		
		var myObject=new Array(); //return values set to this object
		myObject[0]=aForm.TXT_SECIDEN;
		myObject[1]=aForm.HID_MATURITY_DATE;
		myObject[2]=null;
		myObject[3]=null;
		myObject[4]=null;
		
		var myObject_value=new Array(); //passing values set to this object
		myObject_value[0]=aForm.TXT_SECIDEN.value;
		myObject_value[1]=aForm.TXT_INSTYPE.value;//aForm.oLastName2.value;
		myObject_value[2]=null;
		myObject_value[3]=null;
		myObject_value[4]=null;
		
		
		var myObject_type=new Array(); //passing values data type
		myObject_type[0]="StringL";
		myObject_type[1]="String";
		myObject_type[2]=null;
		myObject_type[3]=null;
		myObject_type[4]=null;
		
		var qid='65';
		
		
		title_name='Security Identification Code';
		var url = 'popup.jsp';
		var close_fun='sec_help_close';			
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
					if(returnedValue == null){sec_help_close();} 
					if(returnedValue != null){load_sett_details();} 
					if(returnedValue != null){
						document.Form1.TXT_SECIDEN.focus();
						
					}
				} 
			});
		
		
	}
	
	
	function end_help(m_strat){
		var aForm;    //  aForm =oForm.elements;
		aForm =  document.getElementById('Form1');
		
		
		var myObject=new Array(); //return values set to this object
		myObject[0]=aForm.TXT_ENCODE;
		myObject[1]=aForm.TXT_ENNAME;
		myObject[2]=null;
		myObject[3]=null;
		myObject[4]=null;
		
		var myObject_value=new Array(); //passing values set to this object
		myObject_value[0]=aForm.TXT_INSTYPE.value;
		myObject_value[1]=null;//aForm.oLastName2.value;
		myObject_value[2]=null;
		myObject_value[3]=null;
		myObject_value[4]=null;
		
		
		var myObject_type=new Array(); //passing values data type
		myObject_type[0]="String";
		myObject_type[1]=null;
		myObject_type[2]=null;
		myObject_type[3]=null;
		myObject_type[4]=null;
		
		var qid='66';
		
		
		title_name='Endorser Code';
		var url = 'popup.jsp';
		var close_fun='end_help_close';			
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
					if(returnedValue == null){end_help_close();} 
					if(returnedValue != null){load_sett_details();} 
					if(returnedValue != null){
						document.Form1.TXT_ENCODE.focus();
						
					}
				} 
			});
		
		
	}
	
	function inst_help_close(){
		document.Form1.TXT_INSTYPE.value = '';
	}
	
	function end_help_close(){
		document.Form1.TXT_ENCODE.value = '';
		document.Form1.TXT_ENNAME.value = '';
	}
	
	function sec_help_close(){
		document.Form1.TXT_SECIDEN.value = '';
	}
	
	function buyer_help_close(){
	}
	
	
	
	
	/*
	function buyer_help(obj1){
		m_buycode=obj1.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+m_buycode.toUpperCase()+"&chksql=buyer_lookup1";
		top.frames[0].document.applets[0].getdata(m_url);
		m_size=top.frames[0].document.applets[0].outvec_value.size();
		//alert("********************"+top.frames[0].document.applets[0].outvec_value);
		vec_pos=0;
		lineno=1;
		m_row="";
		while (vec_pos<m_size) {
			m_issu_code=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
			m_issu_name=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
			m_cds_no   =top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2);//add by waruna 2011-01-10
			
			m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+'><B>'+m_issu_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_issu_name+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_cds_no+'</B></TD></TR>';
			vec_pos=vec_pos+3;
			lineno=lineno+1;
		}
		m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" ">'+
			'<TR BGCOLOR="darkblue"><TD WIDTH="25%"><B>Buyer Code</B></TD>' +
			'<TD WIDTH="50%"><B>Buyer Name</B></TD><TD WIDTH="25%"><B>CDS No.</B></TD></TR>'+
			m_row+
			'</TABLE>'; 
		myDialogObj.htmlstr = m_writedata;
		myDialogObj.returnval = "";
		popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		obj1.value=myDialogObj.returnval;
		if (disp){
			parent.frames[1].load_sett_details();  
		}
		obj1.focus();			
	}	
	*/
	/*
	function buyer_help1(obj1){
		m_buycode=obj1.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+m_buycode.toUpperCase()+"&chksql=buyer_lookup";
		//window.open(m_url);
		top.frames[0].document.applets[0].getdata(m_url);
		m_size=top.frames[0].document.applets[0].outvec_value.size();
		vec_pos=0;
		lineno=1;
		m_row="";
		while (vec_pos<m_size) {
			m_issu_code=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
			m_issu_name=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
			m_cds_no=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2);//add by waruna 2011-01-10
			m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+'><B>'+m_issu_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_issu_name+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_cds_no+'</B></TD></TR>';
			vec_pos=vec_pos+3;
			lineno=lineno+1;
		}
		m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" ">'+
			'<TR BGCOLOR="darkblue"><TD WIDTH="25%"><B>Buyer Code</B></TD>' +
			'<TD WIDTH="50%"><B>Buyer Name</B></TD><TD WIDTH="25%"><B>CDS No.</B></TD></TR>'+
			m_row+
			'</TABLE>'; 
		myDialogObj.htmlstr = m_writedata;
		myDialogObj.returnval = "";
		popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		obj1.value=myDialogObj.returnval;
		if (disp){
			parent.frames[1].load_sett_details();  
		}
		obj1.focus();			
	}	
	*/
	
</SCRIPT>
<!--	
<BODY >
<FORM  NAME="Form1" METHOD="POST"  >			
<INPUT TYPE="Hidden" NAME="SCR_NAME"	VALUE="MAIN" >

<TABLE WidTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0" STYLE="{color: black; font: bold 9pt arial;}">							
<TD WidTH="1%"></TD>
<TD WidTH="99%">
-->
<INPUT TYPE="Text" NAME="HID_BASIS" style='display:none'>
<INPUT TYPE="Text" NAME="HID_TEST" style='display:none'>
<INPUT TYPE="Text" NAME="HID_TYPE1" VALUE=""style='display:none'>
<INPUT TYPE="Text" NAME="HID_TYPE2" VALUE=""style='display:none'>
<!--//ADDED ON 25-06-2004 -->
<INPUT TYPE="Text" NAME="HID_TYPE_B" VALUE=""style='display:none'>
<INPUT TYPE="Text" NAME="HID_TYPE_S" VALUE=""style='display:none'>
<INPUT TYPE="Text" NAME="HID_VALDATE" style='display:none'>
<INPUT TYPE="Text" NAME="HID_VALDATETYPE"style='display:none'>
<INPUT TYPE="Text" NAME="HID_VALDATETYPE1"style='display:none'>
<INPUT TYPE="Text" NAME="HID_BUYER_OWN_STATUS" VALUE="" style='display:none'>
<INPUT TYPE="Text" NAME="HID_SELLER_OWN_STATUS" VALUE="" style='display:none'>
<INPUT TYPE="Text" NAME="HID_POSS_ROW" VALUE="" style='display:none'>
<INPUT TYPE="Text" NAME="HID_SCRIPT" VALUE="" style='display:none'>
<INPUT TYPE="Text" NAME="HID_GROUPROW" VALUE=1 style='display:none'>
<INPUT TYPE="Text" NAME="HID_MATURITY_DATE" VALUE="" style='display:none'>
<INPUT TYPE="Text" NAME="HID_DEAL_TYPE"   VALUE="DEBT" style='display:none'>
<INPUT TYPE="Text" NAME="HID_PAR_VALUE"   VALUE="0" style='display:none'>
<!--INPUT TYPE="Text" NAME="HID_DATE" VALUE="01" style='display:none'>
<INPUT TYPE="Text" NAME="HID_MONTH" VALUE="01"  >
<INPUT TYPE="Text" NAME="HID_YEAR" VALUE="1999"  !-->
<input type="Text"   name="HID_BUYER_VAL" value=""style='display:none'> <!--$$##SC-->
<INPUT TYPE="Text" NAME="HID_NO_SHARES"  style='display:none'>
<INPUT TYPE="Text" NAME="HID_TOT_COST"  style='display:none'>
<INPUT TYPE="Text" NAME="HID_YIELD_TYPE" VALUE="" style='display:none'>
<INPUT TYPE="Hidden" NAME="TXT_PAR" class=\"txt_input6\"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25 TABINDEX=-1 ONBLUR="formatnumequity(document.Form1.TXT_PAR)"  >



<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
	<TR><BR></TR>
	<TR>
		<TD><B><U>Buyer Information</B></TD>
			<TD></TD>
			<TD  ><B><U>Seller Information</B></TD>
				<TD></TD>
			</TR>
		</TABLE> 	
		
		
		<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
			<TR><td><BR></td></TR>
			<TR>
				<TD WIDTH="20%">Buyer Code</TD> <!--Nilu-->
				<TD WIDTH="30%"><INPUT TYPE="Text" class="txt_input6" NAME="TXT_BCODE" VALUE="" ONBLUR="buyercode1(document.Form1.TXT_BCODE,document.Form1.TXT_BNAME)" ALIGN="LEFT" SIZE=22 MAXLENGTH=10 >
					<INPUT TYPE="button" VALUE="Help" NAME="BUT_BCODE" class="but_input" ONCLICK="buyer_help(0)" ></TD>
				<TD WIDTH="20%" >Seller Code</TD>
				<TD WIDTH="30%" ><INPUT TYPE="Text" class="txt_input6" NAME="TXT_SCODE" VALUE="" ONBLUR="buyercode2(document.Form1.TXT_SCODE,document.Form1.TXT_SNAME)" ALIGN="LEFT" SIZE=22 MAXLENGTH=10 >
					<INPUT TYPE="button" VALUE="Help" NAME="BUT_SCODE"  class="but_input"  ONCLICK="buyer_help1(0)"   ></TD>
			</TR>
			<TR>
				<TD>Buyer Name</TD>
				<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_BNAME" style='width:180px'	VALUE="" ALIGN="LEFT" SIZE=28 MAXLENGTH=40  ></TD>
				<TD >Seller Name</TD>
				<TD ><INPUT TYPE="Text" class="txt_input6" NAME="TXT_SNAME" style='width:180px'	VALUE="" ALIGN="LEFT" SIZE=28 MAXLENGTH=10></TD>
			</TR>
		</TABLE>
		<HR WIDTH="*%">
		<DIV WIDTH="100%" ID='part2' ></DIV> 								
		<DIV WIDTH="100%" ID='group_deal' ></DIV> 
		<DIV  WIDTH="100%" ID='group_deal_tot' ></DIV> 
		<!--			
		</TD>
		</TD>
		</TABLE> 
		
		</FORM>
		
		</BODY>
		<DIV>
		<SCRIPT language1.2="JavaScript" src="validate_v1.js"></SCRIPT>
		<script language='JavaScript1.2' src="outrights_inv_details.js"></SCRIPT>
		</DIV>
		</HTML>
		-->
