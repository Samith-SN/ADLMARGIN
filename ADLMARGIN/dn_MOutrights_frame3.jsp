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
<SCRIPT language="JavaScript">
	<% ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
	//***************  ADDED BY KANISHKA ON 26/12/2012  *********************//
	
		Object done = (String)session.getValue("logon.isDone");  // marker object
		if (done == null) {
			response.sendRedirect("login.jsp");
			return;
			}
	
	//*************** ADDED BY KANISHKA ON 26/12/2012 [END]  *********************//
	%>
	var username = '<%= m_sn_methods.username %>';
	i=1;
	j=1;
	user_date=false;
	
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@			
	function display_limit_details_enable(){
		chk_cash_daeal=document.Form1.SEL_DATETYPE.value
			if (chk_cash_daeal=='CASH') {			
				document.Form1.Text_help_limit.disabled=false;
			}
	}
	
	function display_limit_details_M(){  
		/*
		m_buy_portfolio_code=document.Form1.TXT_BCODE.value.toUpperCase();
		m_sell_portfolio_code=document.Form1.TXT_SCODE.value.toUpperCase();
		m_face_value=unformat_noobject(document.Form1.TXT_FACEVAL.value);
		m_security_code=document.Form1.TXT_SECIDEN.value.toUpperCase();*/
		m_deal_no=document.Form1.Text_deal_ref.value;
		//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"midvallimits?buy_portfolio_code="+m_buy_portfolio_code+"&sell_portfolio_code="+m_sell_portfolio_code+"&face_value="+m_face_value+"&security_code="+m_security_code+"&chksql=check_ovrl_possible_vio";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		alert(m_size);
		if (m_size>0) {
			vec_pos=0;
			m_row="";
			lineno=1;
			m_status=true;
			while (vec_pos<m_size){
				m_row=m_row+'<TD>'+data_vec[vec_pos+4]+'<INPUT TYPE="Hidden" NAME="COL_A'+lineno+'" VALUE='+data_vec[vec_pos+0]+' ><INPUT TYPE="Hidden" NAME="COL_B'+lineno+'" VALUE='+data_vec[vec_pos+1]+' ><INPUT TYPE="Hidden" NAME="COL_C'+lineno+'" VALUE='+data_vec[vec_pos+2]+'><INPUT TYPE="Hidden" NAME="COL_D'+lineno+'" VALUE='+data_vec[vec_pos+3]+' ><INPUT TYPE="Hidden" NAME="COL_E'+lineno+'" VALUE='+data_vec[vec_pos+4]+' ><INPUT TYPE="Hidden" NAME="COL_F'+lineno+'" VALUE='+data_vec[vec_pos+5]+'></TD></TR>';
				a_array[vec_pos]     = data_vec[vec_pos];
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
				popupwin_limit = window.open('mbfsl_limits_possible_outright.html','disp_Window_details','left=0,top=0,width=600,height=150,toolbar=0,location=0,left=150,top=180,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin_limit.focus(); 
			}	
		}
		else {
			alert("No possible violation reported");
		}
	}
	
	
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@			
	
	function cal_valdate(){
		if(user_date!=true){
			document.Form1.HID_VALDATETYPE.value=document.Form1.TXT_DATE.value+'/'+document.Form1.TXT_MONTH.value+'/'+document.Form1.TXT_YEAR.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?seccode="+document.Form1.TXT_SECIDEN.value+"&val_date="+document.Form1.HID_VALDATETYPE.value+"&chksql=cal_valdate2";
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size1=top.frames[0].document.applets[0].outvec_value.size();
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
		}
		else{
			document.Form1.HID_VALDATETYPE.value=document.Form1.TXT_DATE.value+'/'+document.Form1.TXT_MONTH.value+'/'+document.Form1.TXT_YEAR.value;
			m_url1=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?seccode="+document.Form1.TXT_SECIDEN.value+"&val_date="+document.Form1.HID_VALDATETYPE.value+"&chksql=cal_valdate2";
			//top.frames[0].document.applets[0].getdata(m_url1);
			//m_size1=top.frames[0].document.applets[0].outvec_value.size();
			load_interface(m_url1,'XML',false);
			m_size=data_vec.length;
		}
		if(m_size1>0){
			document.Form1.TXT_DIRTY.value=document.Form1.TXT_CLEAN.value;
			//document.Form1.TXT_DIRTY.disabled=true;
			document.Form1.TXT_ACCINT.value='0.00';
			//document.Form1.TXT_ACCINT.disabled=true;
			document.Form1.TXT_SETVAL.value=document.Form1.TXT_COST.value;
			//document.Form1.TXT_SETVAL.disabled=true;
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
			document.Form1.HID_REF_NO.value=obj.value;
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
				get_cust();
				get_script();//scriptless
				get_invdetails();//scriptless
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?outref_code="+m_dealcode+"&chksql=outdealinfo1";
				//window.open(m_url);
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				//alert(top.frames[0].document.applets[0].outvec_value)
				load_interface(m_url,'XML',false);
				m_size=data_vec.length;
				
				document.Form1.TXT_BCODE.value=data_vec[1];
				document.Form1.TXT_BNAME.value=data_vec[2];
				//buyercode1(document.Form1.TXT_BCODE,document.Form1.TXT_BNAME);
				document.Form1.TXT_SCODE.value=data_vec[3];
				document.Form1.TXT_SNAME.value=data_vec[4];
				//buyercode2(document.Form1.TXT_SCODE,document.Form1.TXT_SNAME);
				
				
				//alert(data_vec[5))
				document.Form1.TXT_INSTYPE.value=data_vec[5];
				document.Form1.TXT_SECIDEN.value=data_vec[6];
				//------------------------ ADDED BY SVA ON 23-03-2005 --------------------------------------
				//alert(data_vec[36));
				if(data_vec[36]=="CUSD"){
					document.Form1.SEL_DEALTYPE.selectedIndex=0;
				}else{
					document.Form1.SEL_DEALTYPE.selectedIndex=1;
				}
				//------------------------------------------------------------------------------------------
				
				
				document.Form1.swift_stat.value=data_vec[34]; //--------------- Added By Manjula on 20-07-04--for swift status-VC of PCTF 0406-051-----------
				document.Form1.cust_stat.value=data_vec[35]; //---------------- Added By Manjula on 21-07-04--for custodial status-VC of PCTF 0406-051-----------
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
				document.Form1.TXT_contract.value=data_vec[33];
				
				document.Form1.TXT_ISSURE.value=data_vec[21];
				document.Form1.TXT_SECCODE.value=data_vec[6];
				document.Form1.TXT_INSTYPE.value=data_vec[5];
				document.Form1.HID_MATURITY_DATE.value=data_vec[26]+'/'+data_vec[27]+'/'+data_vec[28];		
				
				
				if (data_vec[32]  ==  "EQUITY")
				{
					
					document.Form1.TXT_DATE1.value  = data_vec[10];
					document.Form1.TXT_MONTH1.value = data_vec[11];
					document.Form1.TXT_YEAR1.value  = data_vec[12];
					document.Form1.TXT_CLEAN1.value =format_noobject(data_vec[14]);
					document.Form1.TXT_FACEVAL1.value =data_vec[17];
					document.Form1.TXT_NOMINAL.value =format_noobject(data_vec[29]);			
					document.Form1.TXT_BROKER_COST.value =format_noobject(data_vec[31]);
					document.Form1.TXT_PURCH_COST.value =format_noobject(data_vec[30]);
					
					
					
					
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?msec="+document.Form1.TXT_SECIDEN.value+"&chksql=getpar";
					//top.frames[0].document.applets[0].getdata(m_url);
					//m_size=top.frames[0].document.applets[0].outvec_value.size();
					load_interface(m_url,'XML',false);
					m_size=data_vec.length;
					document.Form1.TXT_PAR.value =format_noobject(data_vec[0]);
					document.Form1.TXT_PAR.disabled=true;
					
					
					
					
					broker=unformat_noobject(document.Form1.TXT_BROKER_COST.value);	
					pur=unformat_noobject(document.Form1.TXT_PURCH_COST.value);	
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_broker="+broker+"&m_cost="+pur+"&chksql=get_total&m_seller="+document.Form1.TXT_SCODE.value+"&m_buyer="+document.Form1.TXT_BCODE.value;					
					//top.frames[0].document.applets[0].getdata(m_url);		
					load_interface(m_url,'XML',false);
					m_size=data_vec.length;
					document.Form1.TXT_TOT_COST.value   =format_noobject(data_vec[0]);
					document.Form1.HID_TOT_COST.value   =document.Form1.TXT_TOT_COST.value   
						//Form1.TXT_TOTVAL.value=document.Form1.TXT_TOT_COST.value;					
						document.Form1.TXT_SETAMO1.value=document.Form1.TXT_TOT_COST.value;	
					//alert("1-------------->"+document.Form1.TXT_TOTVAL.value)
					
					document.Form1.TXT_TOTVAL.value=document.Form1.TXT_FACEVAL1.value;
					
					//top.frames[0].document.applets[0].outvec_value.removeAllElements();
					
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?outref_code="+m_dealcode+"&chksql=get_settle_date_mod";
					//top.frames[0].document.applets[0].getdata(m_url);		
					load_interface(m_url,'XML',false);
					m_size=data_vec.length;
					document.Form1.TXT_BDATE.value=data_vec[0].substring(0,2);
					document.Form1.TXT_BMONTH.value=data_vec[0].substring(3,5);
					document.Form1.TXT_BYEAR.value=data_vec[0].substring(6,10);
					document.Form1.TXT_SDATE.value=data_vec[1].substring(0,2);
					document.Form1.TXT_SMONTH.value=data_vec[1].substring(3,5);
					document.Form1.TXT_SYEAR.value=data_vec[1].substring(6,10);	
					
					
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
					document.Form1.cust_stat.disabled=true;		
					document.Form1.TXT_NOMINAL.disabled=true;
					document.Form1.TXT_PURCH_COST.disabled=true;
					//document.Form1.TXT_TOT_COST.disabled=true;
					
					
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
					if(document.Form1.SCRIPT_STAT.value=="SL"){//$$##SC
						document.Form1.TXT_FACEVAL.value=format_noobject_nodecimal(data_vec[17]);
					}
					else{
						document.Form1.TXT_FACEVAL.value=format_noobject(data_vec[17]);
					}
					//---------------------------------
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
					//document.Form1.TXT_TOT_COST.disabled=true;
					document.Form1.TXT_PAR.disabled=true;
					document.Form1.TXT_NOMINAL.disabled=true;
					
					document.Form1.TXT_BDATE.disabled=true;
					document.Form1.TXT_BMONTH.disabled=true;
					document.Form1.TXT_BYEAR.disabled=true;
					
					document.Form1.TXT_SDATE.disabled=true;
					document.Form1.TXT_SMONTH.disabled=true;
					document.Form1.TXT_SYEAR.disabled=true;
					
				}
				
				m_url1=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities?chksql=get_inst_cat&inst="+document.Form1.TXT_INSTYPE.value+"";
				//top.frames[0].document.applets[0].getdata(m_url1);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();	
				load_interface(m_url1,'XML',false);
				m_size=data_vec.length;
				inst_cat=data_vec[0];		
				document.Form1.HID_DEAL_TYPE.value=data_vec[0];	
				//alert(document.location.href);
				document.Form1.HID_DEAL_TYPE.value=data_vec[0];
				
				if((document.Form1.SCRIPT_STAT.value=="SL")&&(document.Form1.HID_TYPE2.value=='P')){//$$##SC
					chk_insttype(document.Form1.TXT_INSTYPE.value);
					document.Form1.BUT_INV_SL.disabled=false;	
					document.Form1.BUT_INV.disabled=true;		
				}
				else if(document.Form1.SCRIPT_STAT.value=="SL"){
					///////////document.Form1.BUT_INV_SL.disabled=true;	//nirmala
					document.Form1.BUT_INV.disabled=true;		 
				}
				else{
					//////////////document.Form1.BUT_INV_SL.disabled=true;	//nirmala
					document.Form1.BUT_INV.disabled=false;	
				}	
				//-------------------
				
				//alert("2-------------->"+document.Form1.TXT_TOTVAL.value)
				
				//documentload_sett_details();			
				datapart2();
				//document.Form1.TXT_SETAMO1.value=document.Form1.TXT_SETVAL.value;
				
				
			}
		}   

		buyercode1(document.Form1.TXT_BCODE,document.Form1.TXT_BNAME);
		buyercode2(document.Form1.TXT_SCODE,document.Form1.TXT_SNAME);
		
		
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
	
	
	function getnominal_value() {	
		
		clean=unformat_noobject(document.Form1.TXT_CLEAN1.value);	
		par=unformat_noobject(document.Form1.TXT_PAR.value);	
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_par="+par+"&m_shares="+unformat_noobject(document.Form1.TXT_FACEVAL1.value)+"&m_price="+clean+"&chksql=get_nominal";
		//top.frames[0].document.applets[0].getdata(m_url);
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		document.Form1.TXT_NOMINAL.value   =format_noobject(data_vec[0]);
		document.Form1.TXT_PURCH_COST.value=format_noobject(data_vec[1]);
		document.Form1.TXT_NOMINAL.disabled=true;
		document.Form1.TXT_PURCH_COST.disabled=true;
		
	}
	
	function get_total4444() 
	{	  
		
		//alert(top.frames[1].frames[2].frames[1].location)	
		broker=unformat_noobject(document.Form1.TXT_BROKER_COST.value);	
		pur=unformat_noobject(document.Form1.TXT_PURCH_COST.value);	
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_broker="+broker+"&m_cost="+pur+"&m_seller="+document.Form1.TXT_SCODE.value+"&m_buyer="+document.Form1.TXT_BCODE.value+"&chksql=get_total";					
		//top.frames[0].document.applets[0].getdata(m_url);			
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		document.Form1.TXT_TOT_COST.value   =format_noobject(data_vec[0]);
		document.Form1.HID_TOT_COST.value   =document.Form1.TXT_TOT_COST.value   
			document.Form1.TXT_TOTVAL.value=document.Form1.TXT_TOT_COST.value;
		//alert(document.Form1.TXT_TOTVAL.value)
		document.Form1.TXT_SETAMO1.value=document.Form1.TXT_TOT_COST.value;
		//alert(document.Form1.TXT_SETAMO1.value)
	}
	
	
	function chk_holiday_settle(dayobj,monthobj,yearobj){
		m_valdate=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?value_date="+m_valdate+"&chksql=chk_valholiday";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
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
			chk_holiday_settle(dayobj,monthobj,yearobj)
			
		}
	}
	/*
	function change_cal(){
		if(document.Form1.TXT_TOT_COST.value!="" &&  document.Form1.TXT_PURCH_COST.value!=""){
		v_def =parseFloat(unformat_noobject(document.Form1.TXT_TOT_COST.value))-parseFloat(unformat_noobject(document.Form1.TXT_PURCH_COST.value));
		if(v_def>=0){
				document.Form1.TXT_BROKER_COST.value=format_noobject(v_def);
			}else{
				alert("Sorry, Total Cost should not be less than Purchase Cost ");
				document.Form1.TXT_TOT_COST.value = document.Form1.HID_TOT_COST.value;
				document.Form1.TXT_TOT_COST.focus();
			}
		}	
	}
	*/
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
			v_def =parseFloat(unformat_noobject(document.Form1.TXT_TOT_COST.value))-parseFloat(unformat_noobject(document.Form1.TXT_PURCH_COST.value));
			if(v_def>=0){
				document.Form1.TXT_BROKER_COST.value=format_noobject(v_def);
				//ADDED BY SVA ON 27-05-2004 FOR EQUITY CHANGERS
				document.Form1.TXT_SETAMO1.value=document.Form1.TXT_TOT_COST.value;
				//END
			}else{
				alert("Sorry, Total Cost should not be less than Purchase Cost ");
				document.Form1.TXT_TOT_COST.value = document.Form1.HID_TOT_COST.value;
				document.Form1.TXT_TOT_COST.focus();
				
			}
		}else if(document.Form1.HID_TYPE_S.value=="P"){
			v_def =parseFloat(unformat_noobject(document.Form1.TXT_PURCH_COST.value))-parseFloat(unformat_noobject(document.Form1.TXT_TOT_COST.value));
			if(v_def>=0){
				document.Form1.TXT_BROKER_COST.value=format_noobject(v_def);
				//ADDED BY SVA ON 27-05-2004 FOR EQUITY CHANGERS
				document.Form1.TXT_SETAMO1.value=document.Form1.TXT_TOT_COST.value;
				//END
			}else{
				alert("Sorry, Total Cost should not be grater than Purchase Cost ");
				document.Form1.TXT_TOT_COST.value = document.Form1.HID_TOT_COST.value;
				document.Form1.TXT_TOT_COST.focus();
				
			}
		}
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
	
	
	
	function get_settle_dates(){
		m_valdate=document.Form1.HID_DATE.value+'/'+document.Form1.HID_MONTH.value+'/'+document.Form1.HID_YEAR.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?value_date="+m_valdate+"&chksql=get_settle_dates";	
		//top.frames[0].document.applets[0].getdata(m_url);
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
	
	function chk_holiday(dayobj,monthobj,yearobj){
		m_valdate=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?value_date="+m_valdate+"&chksql=chk_valholiday";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
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
				//document.Form1.TXT_CLEAN.focus();
			}
		}
	}
	
	
	
	
	function formatnumequity(num1)
	{					
		num1.value=format_noobject(num1.value);
		//document.Form1.HID_FACEVAL.value=unformat_noobject(num1.value);
	}
	
	
	
	function check()
	{
		if (unformat_noobject(document.Form1.TXT_CLEAN.value) > 1 )
		{
			//alert(">1")
			check_pricetwentyfive();
		}
		else if (unformat_noobject(document.Form1.TXT_CLEAN.value) < 1 )
		{
			//alert("<1")
			check_priceten();
		}
		
		
		
	}
	
	
	function get_broker() 
	{	
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_purchase_cost="+unformat_noobject(document.Form1.TXT_PURCH_COST.value)+"&chksql=get_broker_cost";					
		//top.frames[0].document.applets[0].getdata(m_url);	
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		
		
		document.Form1.TXT_BROKER_COST.value   =format_noobject(data_vec[0]);
	}
	
	
	function check_share()
	{
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?share="+document.Form1.TXT_FACEVAL1.value+"&chksql=check_share";					
		//top.frames[0].document.applets[0].getdata(m_url);	
		//alert(data_vec[0])
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
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
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?price="+unformat_noobject(document.Form1.TXT_CLEAN1.value)+"&chksql=check_pricetwentyfive";					
		//top.frames[0].document.applets[0].getdata(m_url);	
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
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
				document.Form1.TXT_CLEAN1.value="";
				document.Form1.TXT_CLEAN1.focus();
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
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?price="+unformat_noobject(document.Form1.TXT_CLEAN1.value)+"&chksql=check_priceten";					
		//top.frames[0].document.applets[0].getdata(m_url);	
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
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
				document.Form1.TXT_CLEAN1.value="";
				document.Form1.TXT_CLEAN1.focus();
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
		//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_broker="+broker+"&m_cost="+pur+"&chksql=get_total";					
		//top.frames[0].document.applets[0].getdata(m_url);	
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		document.Form1.TXT_TOT_COST.value   =format_noobject(data_vec[0]);
		document.Form1.HID_TOT_COST.value   =document.Form1.TXT_TOT_COST.value   
			//document.Form1.TXT_TOT_COST.disabled=true;
			//documentdocument.Form1.TXT_TOTVAL.value=document.Form1.TXT_TOT_COST.value;						
			document.Form1.TXT_TOTVAL.value=document.Form1.TXT_FACEVAL1.value;
		document.Form1.TXT_SETAMO1.value=document.Form1.TXT_TOT_COST.value;
		
		//ADDED ON 25-06-2004 
		
		document.Form1.HID_TYPE_B.value=data_vec[1];
		document.Form1.HID_TYPE_S.value=data_vec[2];
		if (document.Form1.HID_TYPE_S.value=="P" && document.Form1.HID_TYPE_B.value=="P"){
			alert("Brokerage amount should be zero.");
			document.Form1.TXT_BROKER_COST.value = "0.00";
		}
	}
	
	function get_invdetails(){
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?chksql=getinvs&dealno="+m_dealcode+"";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		//alert(top.frames[0].document.applets[0].outvec_value);
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		if(m_size>0){
			document.Form1.SCRIPT_STAT.disabled=true;
		}
		else{
			document.Form1.SCRIPT_STAT.disabled=false;
		}
	}	
	
	function dis_serial(){//$$##SC
		if(document.Form1.SCRIPT_STAT.value=="SL"){
			document.Form1.TXT_SENOIDEN1.disabled=true;
			document.Form1.TXT_FACEVAL1.disabled=true;
			document.Form1.TXT_MISS1.disabled=true;
			document.Form1.Text_remove1.disabled=true;
			document.Form1.Text_more.disabled=true;
		}
		else if(document.Form1.SCRIPT_STAT.value=="SC"){
			document.Form1.TXT_SENOIDEN1.disabled=false;
			document.Form1.TXT_FACEVAL1.disabled=false;
			document.Form1.TXT_MISS1.disabled=false;
			document.Form1.Text_remove1.disabled=false;
			document.Form1.Text_more.disabled=false;
		}
	}
	//--------------------------------------------------------------//
	
	
	function get_script(){//$$##SC
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?chksql=getscript&dealno="+m_dealcode+"";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		vec_pos=0;
		if(data_vec[0]=="SC"){
			m_stat=0;
		}
		else{
			m_stat=1;
		}
		document.Form1.SCRIPT_STAT.selectedIndex=m_stat;
	}	
	//-----------------------------------
	function get_cust(){
		m_url88=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?chksql=getcust&dealno="+m_dealcode+"";
		//top.frames[0].document.applets[0].getdata(m_url88);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url88,'XML',false);
		m_size=data_vec.length;
		vec_pos=0;
		if(data_vec[0]=="Y"){
			m_stat=0;
		}
		else{
			m_stat=1;
		}
		//document.Form1.cust_stat.options[document.Form1.cust_stat.length]=new Option(m_stat);
		//document.Form1.cust_stat.options[data_vec[0].selected=true;
		document.Form1.cust_stat.selectedIndex=m_stat;
		
		
	}
	
	/*
	function dealref_help() {
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?chksql=outdeal_lookup";
		//top.frames[0].document.applets[0].getdata(m_url);
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
		m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color: white; font: 8pt sans-serif;}">'+
			'<TR BGCOLOR="darkblue"><TD WIDTH="28%"><B>Deal No</B></TD>' +
			'<TD WIDTH="20%"><B>Buyer Code</B></TD><TD WIDTH="20%"><B>Seller Code</B></TD><TD WIDTH="32%"><B>Value Date</B></TD></TR>'+
			m_row+
			'</TABLE>'; 
		myDialogObj.htmlstr = m_writedata;
		myDialogObj.returnval = "";
		popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:25em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		document.Form1.Text_deal_ref.value=myDialogObj.returnval;
		//Form1.Text_deal_ref.focus();
		chk_deadref(document.Form1.Text_deal_ref);
	}	
	
	*/
	var glb_help_obj;
	
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
		// num1.value=format_noobject(num1.value);
		//document.Form1.TXT_COST.focus();
		
		if(document.Form1.SCRIPT_STAT.value=="SL"){//$$##SC
			num1.value=format_noobject_nodecimal(num1.value);
		}
		else{
			num1.value=format_noobject(num1.value);
		}
		//--------------------------------------------
		
		document.Form1.HID_FACEVAL.value=unformat_noobject(num1.value);
		mm_pricec=unformat_noobject(document.Form1.TXT_CLEAN.value);
		mm_faceval=unformat_noobject(document.Form1.TXT_FACEVAL.value);
		document.Form1.HID_VALDATETYPE.value=document.Form1.TXT_DATE.value+'/'+document.Form1.TXT_MONTH.value+'/'+document.Form1.TXT_YEAR.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_seccode="+document.Form1.TXT_SECIDEN.value+"&m_pricec="+mm_pricec+"&m_valuedate="+document.Form1.HID_VALDATETYPE.value+"&m_faceval="+mm_faceval+"&chksql=Ccla_threeval";
		//top.frames[0].document.applets[0].getdata(m_url);	
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		document.Form1.TXT_COST.value=data_vec[0];
		document.Form1.TXT_ACCINT.value=data_vec[1];
		document.Form1.TXT_SETVAL.value=data_vec[2];
		document.Form1.TXT_TOTVAL.value=document.Form1.TXT_FACEVAL.value;
		rows=1;
		kkkk=1;
		jjjj=2;     
		
		while (document.Form1.HID_SECDET.value>rows){
			tranfaceval3();
			rows=rows+1;
		}
		
		if(document.Form1.SEL_MODES.value>1){
			document.Form1.TXT_TOAMO.value=document.Form1.TXT_SETVAL.value;
		}
		
		
		document.Form1.HIDD_SETAMO1.value=document.Form1.TXT_SETVAL.value;
		document.Form1.HIDD_TXT_CURR.value=document.Form1.TXT_CURR.value;
		
		cal_valdate();
		curfocus2();
		document.Form1.TXT_SETAMO1.value=document.Form1.TXT_SETVAL.value;
		
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
		//document.Form1.TXT_CLEAN.focus();
		document.Form1.HID_YIELD.value=unformat_noobject(num5.value);
		document.Form1.HID_VALDATETYPE.value=document.Form1.TXT_DATE.value+'/'+document.Form1.TXT_MONTH.value+'/'+document.Form1.TXT_YEAR.value;
		
		if(document.Form1.TXT_BASIS.value=="Act/Act"){
			document.Form1.HID_BASIS.value="AA";
		}
		else if(document.Form1.TXT_BASIS.value=="Act/365"){
			document.Form1.HID_BASIS.value="A365";
		}
		else if(document.Form1.TXT_BASIS.value=="Act/364"){
			document.Form1.HID_BASIS.value="A364";
		}
		//alert(document.Form1.HID_BASIS.value);
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_yield="+document.Form1.HID_YIELD.value/100+"&m_valuedate="+document.Form1.HID_VALDATETYPE.value+"&m_security="+document.Form1.TXT_SECIDEN.value+"&m_basis="+document.Form1.HID_BASIS.value+"&chksql=c_d_fromyield";
		//alert(m_url);
		//top.frames[0].document.applets[0].getdata(m_url);
		//alert(top.frames[0].document.applets[0].outvec_value);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		document.Form1.TXT_CLEAN.value=data_vec[1];
		document.Form1.TXT_DIRTY.value=data_vec[0];
		//document.Form1.TXT_FACEVAL.focus();
		formatnum1(document.Form1.TXT_FACEVAL);
	}
	
	
	function formatnum02(num6){
		num6.value=format_noobject0(num6.value);
		document.Form1.HID_CLEAN.value=unformat_noobject(num6.value);
		document.Form1.TXT_DIRTY.focus();
		document.Form1.HID_VALDATETYPE.value=document.Form1.TXT_DATE.value+'/'+document.Form1.TXT_MONTH.value+'/'+document.Form1.TXT_YEAR.value;
		if(document.Form1.TXT_BASIS.value=="Act/Act"){
			document.Form1.HID_BASIS.value="AA";
		}
		else if(document.Form1.TXT_BASIS.value=="Act/365"){
			document.Form1.HID_BASIS.value="A365";
		}
		else if(document.Form1.TXT_BASIS.value=="Act/364"){
			document.Form1.HID_BASIS.value="A364";
		}
		
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_clean="+document.Form1.TXT_CLEAN.value+"&m_valuedate="+document.Form1.HID_VALDATETYPE.value+"&m_security="+document.Form1.TXT_SECIDEN.value+"&m_basis="+document.Form1.HID_BASIS.value+"&chksql=y_d_fromclean";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		document.Form1.TXT_YIELD.value=(data_vec[1]*100);
		document.Form1.TXT_DIRTY.value=data_vec[0];
		document.Form1.TXT_FACEVAL.focus();
		formatnum1(document.Form1.TXT_FACEVAL);
		
	}
	
	function formatnum03(num7){
		num7.value=format_noobject0(num7.value);
		document.Form1.HID_DIRTY.value=unformat_noobject(num7.value);
		if(document.Form1.TXT_BASIS.value=="Act/Act"){
			document.Form1.HID_BASIS.value="AA";
		}
		else if(document.Form1.TXT_BASIS.value=="Act/365"){
			document.Form1.HID_BASIS.value="A365";
		}
		else if(document.Form1.TXT_BASIS.value=="Act/364"){
			document.Form1.HID_BASIS.value="A364";
		}
		
		document.Form1.HID_VALDATETYPE.value=document.Form1.TXT_DATE.value+'/'+document.Form1.TXT_MONTH.value+'/'+document.Form1.TXT_YEAR.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_dirty="+document.Form1.TXT_DIRTY.value+"&m_valuedate="+document.Form1.HID_VALDATETYPE.value+"&m_security="+document.Form1.TXT_SECIDEN.value+"&m_basis="+document.Form1.HID_BASIS.value+"&chksql=y_c_fromdirty";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		document.Form1.TXT_YIELD.value=format_noobject0(((data_vec[1])*100),4);
		document.Form1.TXT_CLEAN.value=format_noobject0(data_vec[0],4);
		document.Form1.TXT_FACEVAL.focus();
		formatnum1(document.Form1.TXT_FACEVAL);
	}
	
	
	
	function chkstartdate(dayobj,monthobj,yearobj) {
		
		if (checkMonthLength(dayobj,monthobj,yearobj)) {
			document.Form1.HID_VALDATETYPE.value=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
			document.Form1.HID_DATE.value=dayobj.value;
			document.Form1.HID_MONTH.value=monthobj.value;
			document.Form1.HID_YEAR.value=yearobj.value;
			chk_holiday(dayobj,monthobj,yearobj);
		}
		
		
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
			m_row=m_row+'<TR STYLE="{color:black; cursor:hand font: bold 10pt Arial;}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_cr_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_cr_desc+'</B></TD></TR>';
			vec_pos=vec_pos+2;
			lineno=lineno+1;
		}
		m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color:black; font: bold 9pt Arial;}>'+
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
	
	/*
	function basis_help(){
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?chksql=basis_lookup";
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
			m_row=m_row+'<TR STYLE="{color:black; cursor:hand font: bold 10pt Arial;}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C2R'+lineno+');><TD ID=C1R'+lineno+'><B>'+m_basis_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_basis_desc+'</B></TD></TR>';
			vec_pos=vec_pos+2;
			lineno=lineno+1;
		}
		m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color:black; font: bold 9pt Arial;}>'+
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
	
	*/
	
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
	
	function chk_basis(obj_basis) {
		m_basis=obj_basis.value; 
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?chksql=basis&basis_desc="+m_basis+"";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		if(m_size==0) {
			basis_help(0);
		}
		else{
			document.Form1.HID_BASIS.value=data_vec[0];
			document.Form1.TXT_YIELD.focus();
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
				end_help(0);
				value.focus();
			}
			else{
				document.Form1.TXT_ENNAME.value=data_vec[1]
			}
		}
	}
	
	/*
	function end_help(obj1) {
		m_instype=obj1.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+m_instype.toUpperCase()+"&chksql=endcode";
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
		m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color: white; font: 9pt arial;}">'+
			'<TR BGCOLOR="darkblue"><TD WIDTH="30%"><B>Endorser Code</B></TD>' +
			'<TD WIDTH="70%"><B>Endorser Name</B></TD></TR>'+
			m_row+
			'</TABLE>'; 
		myDialogObj.htmlstr = m_writedata;
		myDialogObj.returnval = "";
		
		popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		document.Form1.TXT_ENCODE.value=myDialogObj.returnval;
		document.Form1.TXT_ENCODE.focus();			
	}	
	*/
	
	
	
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
					//if(returnedValue != null){load_sett_details();} 
					if(returnedValue != null){
						document.Form1.TXT_ENCODE.focus();
						
					}
				} 
			});
		
		
	}
	
	function end_help_close(){
		document.Form1.TXT_ENCODE.value = '';
		document.Form1.TXT_ENNAME.value = '';
	}
	
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
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
			if (m_size==0) {
				sec_help(0);
				objz1.focus();
			}
			else{
				document.Form1.TXT_ISSCODE.value=data_vec[2]
				document.Form1.TXT_GUCODE.value=data_vec[4]
				document.Form1.TXT_ISSNAME.value=data_vec[3]
				document.Form1.TXT_GUNAME.value=data_vec[5]
				Form1.TXT_SECCODE.value=document.Form1.TXT_SECIDEN.value;
				Form1.TXT_ISSURE.value=document.Form1.TXT_ISSCODE.value;
				document.Form1.TXT_ENCODE.focus();
			}
		}
	}
	
	/*
	function sec_help(obj1) {
		m_secinst=obj1.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?inst_num="+m_secinst.toUpperCase()+"&chksql=sec_lookup";
		//alert(m_url);by WARUNA
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		vec_pos=0;
		lineno=1;
		m_row="";
		if (m_size>0){
			while (vec_pos<m_size) {
				m_issu_code=data_vec[vec_pos];
				m_issu_name=data_vec[vec_pos+1];
				m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+'><B>'+m_issu_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_issu_name+'</B></TD></TR>';
				vec_pos=vec_pos+2;
				lineno=lineno+1;
			}
			m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color: white; font: 9pt arial;}">'+
				'<TR BGCOLOR="darkblue"><TD WIDTH="60%"><B>Security Identification</B></TD>' +
				'<TD WIDTH="40%"><B>Maturity_Date</B></TD></TR>'+
				m_row+
				'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval = "";
			
			popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
			//document.Form1.TXT_SECIDEN.value=myDialogObj.returnval;
			//document.Form1.TXT_SECIDEN.focus();	
			abc=top.frames[0].document.applets[0].outvec_value.indexOf(myDialogObj.returnval);
			document.Form1.TXT_SECIDEN.value=data_vec[abc];
			document.Form1.HID_MATURITY_DATE.value=data_vec[abc+1];
		}
		else{
			alert('Currently no data available for the selected Instrument type !');
		}
		
	}	
	*/
	
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
					//if(returnedValue != null){load_sett_details();} 
					if(returnedValue != null){
						document.Form1.TXT_SECIDEN.focus();
						
					}
				} 
			});
		
		
	}
	
	function sec_help_close(){
		document.Form1.TXT_SECIDEN.value = '';
	}
	
	
	
	function insttype(endcode){
		if (endcode.value=="") {
			inst_help(0);
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
				inst_help(0);
				endcode.focus();
			}
			else{
				document.Form1.TXT_INSTYPE1.value=document.Form1.TXT_INSTYPE.value;
			}
		}	  
	}
	
	/*
	
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
		m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color: white; font: 9pt arial;}">'+
			'<TR BGCOLOR="darkblue"><TD WIDTH="30%"><B>Instrument Type</B></TD>' +
			'<TD WIDTH="70%"><B>Instrument Description</B></TD></TR>'+
			m_row+
			'</TABLE>'; 
		myDialogObj.htmlstr = m_writedata;
		myDialogObj.returnval = "";
		
		popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		document.Form1.TXT_INSTYPE.value=myDialogObj.returnval;
		//document.Form1.TXT_INSTYPE.focus();			
	}	
	*/
	
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
					//if(returnedValue != null){load_sett_details();} 
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
	
	function inst_help_close(){
		document.Form1.TXT_INSTYPE.value = '';
	}
	
	function buyercode1(objx,objy){
		if (objx.value=="") {
			buyer_help(0);
			objx.focus();
		}
		else{
			m_buycode=objx.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+m_buycode.toUpperCase()+"&chksql=chkbuy";
			//window.open(m_url);
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
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
					objy.value                    =data_vec[1];
					document.Form1.HID_TYPE1.value=data_vec[2];
					//load_sett_details();
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
			buyer_help(0);
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
					document.Form1.HID_TYPE2.value=data_vec[2];
					if(document.Form1.HID_TOT_COST.value!=""){
						get_broker();
						get_total(); 
					}
					if(data_vec[2]=='C'){//$$##SC
						document.Form1.BUT_INV.disabled=true;
					}
					else{
						document.Form1.BUT_INV.disabled=false;
					}
					//-----------------------------
				}
			}
		}
	}
	
	/*
	function buyer_help(obj1) {
		m_buycode=obj1.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+m_buycode.toUpperCase()+"&chksql=buyer_lookup";
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
		m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color: white; font: 9pt arial;}">'+
			'<TR BGCOLOR="darkblue"><TD WIDTH="25%"><B>Buyer Code</B></TD>' +
			'<TD WIDTH="50%"><B>Buyer Name</B></TD><TD WIDTH="25%"><B>CDS No.</B></TD></TR>'+
			m_row+
			'</TABLE>'; 
		myDialogObj.htmlstr = m_writedata;
		myDialogObj.returnval = "";
		
		popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		obj1.value=myDialogObj.returnval;
		//load_sett_details();
		obj1.focus();			
	}	
	*/
	
	
	
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
					if(returnedValue != null){buyercode1(document.Form1.TXT_BCODE,document.Form1.TXT_BNAME);} 
					//if(returnedValue != null){document.Form1.TXT_BCODE.focus();}
				} 
			});
		
		
	}
	
	/*
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
				} 
			});
		
		
	}
	*/
	
	function buyer_help_close(){
	}
	
	function date_obj(){
		document.Form1.HID_VALDATE.value=document.Form1.SEL_DATETYPE.value;
		document.Form1.HID_VALDATETYPE.value=document.Form1.SEL_DATETYPE.value;
		if(document.Form1.SEL_DATETYPE.value=='UD'){
			if (confirm("To entr an user define date click on OK !")) {
				m_writedata ='<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_DATE" SIZE=3 MAXLENGTH=2 >'+
					'<INPUT TYPE="Text" class="txt_input6" NAME="TXT_MONTH" SIZE=3 MAXLENGTH=2 >'+
					'<INPUT TYPE="Text" class="txt_input6" NAME="TXT_YEAR" SIZE=5 MAXLENGTH=4 ONBLUR="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR);chk_holiday()"></TD>';
				document.getElementById('newdate').innerHTML=m_writedata;	
				document.Form1.TXT_DATE.focus();
				user_date=true;
			}
		}		
		else{
			m_writedata ='<TD><INPUT TYPE="Hidden" NAME="HID_DATE" VALUE="01" SIZE=3 MAXLENGTH=2 >'+
				'<INPUT TYPE="Hidden" NAME="HID_MONTH" VALUE="01" SIZE=3 MAXLENGTH=2 >'+
				'<INPUT TYPE="Hidden" NAME="HID_YEAR" VALUE="1999" SIZE=5 MAXLENGTH=4 ></TD>';
		}
	}
	
	function date_objfprev(){
		m_writedata ='<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_DATE" SIZE=3 MAXLENGTH=2 ONBLUR="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR)">'+
			'<INPUT TYPE="Text" class="txt_input6" NAME="TXT_MONTH" SIZE=3 MAXLENGTH=2 ONBLUR="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR)">'+
			'<INPUT TYPE="Text" class="txt_input6" NAME="TXT_YEAR" SIZE=5 MAXLENGTH=4 ONBLUR="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR)"></TD>';
		document.getElementById('newdate').innerHTML=m_writedata;	
	}
	
	/*	function val_primary(){
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
		
		}*/
	
	
	function curfocus	(){
		
		//document.Form1.TXT_FACEVAL.focus();
	}
	
	function curfocus2	(){
		//document.Form1.button_broker.focus();
		//document.Form1.TXT_ENCODE.focus();
	}
	
	function chk_insttype(m_instype){//$$##SC
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?insttype="+m_instype.toUpperCase()+"&chksql=chk_inst";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		if (m_size>0) {
			if(data_vec[0]=="W" ){
				document.Form1.BUT_INV.disabled=true;
				document.Form1.BUT_INV_SL.disabled=false;	
			}else{
				document.Form1.BUT_INV.disabled=true;
				document.Form1.BUT_INV_SL.disabled=false;	
			}	
		}
	}
	//-----------------------------
	
	function checkkey(e){//$$##SC
		if(document.Form1.SCRIPT_STAT.value=="SL"){//$$##SC
			if(e.keyCode==46){
				alert("You are not allowed to enter cents");
				e.keyCode=0;
			}
		}
	}
	//-------------------------------------------------	
	
	//added By Nilu on 27-9-2004/15:17 to check the share price. SRF 0409-071 No-08
	function check_sharePrice(){ 
		if (document.Form1.TXT_CLEAN1.value=="0"){        
			alert("Share Price is zero.")
		}
	}
	
</SCRIPT>
<!--
<BODY onload="document.Form1.save_but.disabled=false;">
<FORM  NAME="Form1" METHOD="POST" >			
-->
<INPUT TYPE="Hidden" NAME="SCR_NAME"	VALUE="MAIN" >
<TABLE WidTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >							
	<TD WidTH="1%">
		<TD WidTH="99%">
			<INPUT TYPE="Hidden" NAME="HID_TOT_COST"  >
			<INPUT TYPE="Hidden" NAME="HID_BASIS" >
			<!--//ADDED ON 25-06-2004 -->
			<INPUT TYPE="Hidden" NAME="HID_TYPE_B" VALUE="">
			<INPUT TYPE="Hidden" NAME="HID_TYPE_S" VALUE="">
			
			<INPUT TYPE="Hidden" NAME="HID_TYPE1">
			<INPUT TYPE="Hidden" NAME="HID_TYPE2">
			<INPUT TYPE="Hidden" NAME="HID_TEST" >
			<INPUT TYPE="Hidden" NAME="HID_REF_NO"  >
			<INPUT TYPE="Hidden" NAME="HID_VALDATE" VALUE="UD" >
			<INPUT TYPE="Hidden" NAME="HID_VALDATETYPE">	
			<INPUT TYPE="Hidden" NAME="HID_SCRIPT" VALUE="" >
			<INPUT TYPE="Hidden" NAME="HID_MATURITY_DATE" VALUE="" >
			<INPUT TYPE="Hidden" NAME="HID_PAR_VALUE"   VALUE="0" >
			<INPUT TYPE="Hidden" NAME="HID_DEAL_TYPE"   VALUE="EQUITY" >
			<INPUT TYPE="Hidden" NAME="HID_DATE" VALUE="01" >
			<INPUT TYPE="Hidden" NAME="HID_MONTH" VALUE="01"  >
			<INPUT TYPE="Hidden" NAME="HID_YEAR" VALUE="1999"  >
			<INPUT TYPE="Hidden" NAME="HID_NO_SHARES"  >
			<INPUT TYPE="Hidden" class="txt_input6" NAME="TXT_PAR"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25  ONBLUR="formatnumequity(document.Form1.TXT_PAR)"  >
			
			
			<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
				<TR><TD><BR></TD></TR>
				<TR>
					<TD COLSPAN='2'><B><U>Buyer Information</U></B></TD>
					<TD></TD>
					<TD ><B><U>Seller Information</U></B></TD>
					<TD></TD>
				</TR>
			</TABLE> 	
			
			
			<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
				<TR><BR></TR>
				<TR>
					<TD WIDTH="20%">Buyer Code</TD>
					<TD WIDTH="30%"><INPUT class="txt_input6" TYPE="Text" NAME="TXT_BCODE" ONBLUR="buyercode1(document.Form1.TXT_BCODE,document.Form1.TXT_BNAME);" ALIGN="LEFT" SIZE=22 MAXLENGTH=10 ><!--display_limit_details_M()-->
						<INPUT TYPE="button" class="but_input" VALUE="Help" NAME="BUT_BCODE" ONCLICK="buyer_help(0)" ></TD>
					<TD WIDTH="20%" >Seller Code</TD>
					<TD WIDTH="30%" ><INPUT class="txt_input6" TYPE="Text" NAME="TXT_SCODE" ONBLUR="buyercode2(document.Form1.TXT_SCODE,document.Form1.TXT_SNAME)" ALIGN="LEFT" SIZE=22 MAXLENGTH=10 >
						<INPUT TYPE="button" class="but_input" VALUE="Help" NAME="BUT_SCODE"  ONCLICK="buyer_help(0)"   ></TD>
				</TR>
				<TR>
					<TD>Buyer Name</TD>
					<TD><INPUT TYPE="Text" class="txt_input6"  NAME="TXT_BNAME"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10  ></TD>
					<TD >Seller Name</TD>
					<TD ><INPUT TYPE="Text" class="txt_input6" NAME="TXT_SNAME"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10 ></TD>
				</TR>
			</TABLE>
			<HR WIDTH="*%">
			
			
			
			<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
				<TR><TD COLSPAN='4'><B><U>Instrument & Security Information</U></B></TD></TR>
				<TR><TD><BR></TD></TR>
				<TR>
					<TD WIDTH="20%"></TD>
					<TD WIDTH="30%"></TD>
					<TD WIDTH="20%"></TD>											
					<TD WIDTH="30%"></TD>
				</TR>
				<!---------------------------------------------------------------------------->  
				<TR>
					<TD WIDTH="20%">Inventory Type</TD>
					<TD WIDTH="30%"><SELECT NAME ="SEL_DEALTYPE" class="txt_input6" ONBLUR="deal_type();">
							<OPTION VALUE="CUSD"    SELECTED>Custodian</option>
							<OPTION VALUE="BROKER" >Broker</option>
						</SELECT>
					</TD>
					<TD COLSPAN='2' WIDTH="50%"></TD>	
				</TR>
				<!---------------------------------------------------------------------------->  
				
				
				<TR>
					<TD WIDTH="20%">Instrument Type</TD>
					<TD WIDTH="30%"><INPUT TYPE="Text" class="txt_input6" NAME="TXT_INSTYPE" ALIGN="LEFT" SIZE=22 MAXLENGTH=10 ONBLUR="insttype(document.Form1.TXT_INSTYPE)">
						<INPUT TYPE="button" class="but_input" VALUE="Help" NAME="BUT_INSTYPE" ONCLICK="inst_help(0)" ></TD>
					<!----------------------------$$##SC---------------------------------------
					<TD><INPUT TYPE="button" class="but_input" VALUE="SC Inventory Details" style="display:none" NAME="BUT_INV" ONCLICK="displaydata(document.Form1.TXT_SCODE.value,document.Form1.TXT_INSTYPE.value,document.Form1.TXT_SECIDEN.value,document.Form1.TXT_BCODE.value,document.Form1.Text_deal_ref.value)" ></TD>
					<!---------------------------------------------------------------------------->  
					<TD COLSPAN='2' WIDTH="50%"><INPUT TYPE="button" class="but_input" VALUE="SC Inventory Details" style="display:none" NAME="BUT_INV" ONCLICK="displaydata(document.Form1.TXT_SCODE.value,document.Form1.TXT_INSTYPE.value,document.Form1.TXT_SECIDEN.value,document.Form1.TXT_BCODE.value,document.Form1.Text_deal_ref.value)"  ><INPUT TYPE="button" class="but_input" VALUE="SL Inventory Details" style="width:160px" NAME="BUT_INV_SL" ONCLICK="displaydata_SL(document.Form1.TXT_SCODE.value,document.Form1.TXT_INSTYPE.value,document.Form1.TXT_SECIDEN.value,document.Form1.TXT_BCODE.value,document.Form1.Text_deal_ref.value,document.Form1.SEL_DEALTYPE.value)" ></TD>
					
				</TR>
				<TR>
					<TD>Security Identification</TD>
					<TD COLSPAN='3'><INPUT TYPE="Text" class="txt_input6" NAME="TXT_SECIDEN" ALIGN="LEFT" SIZE=22 MAXLENGTH=10 ONBLUR="sectype(document.Form1.TXT_SECIDEN,document.Form1.TXT_INSTYPE)">											
						<INPUT TYPE="button" class="but_input" VALUE="Help" NAME="BUT_SECIDEN" ONCLICK="sec_help(0)" ></TD>
					<!--<TD><INPUT TYPE="button" VALUE="Inventory Details" NAME="BUT_INV" ONCLICK="displaydata(document.Form1.TXT_SCODE.value,document.Form1.TXT_INSTYPE.value,document.Form1.TXT_SECIDEN.value)" ></TD>-->
					<!----------------------------$$##SC------------------------------------------>
					
					<!---------------------------------------------------------------------------->
				</TR>
				<TR>
					<TD WIDTH="20%">Issuer Code</TD>
					<TD WIDTH="30%"><INPUT TYPE="Text" class="txt_input6" NAME="TXT_ISSCODE"	ALIGN="LEFT" SIZE=22 MAXLENGTH=10 ></TD>
					<TD WIDTH="20%">Issuer Name</TD>
					<TD WIDTH="30%"><INPUT TYPE="Text" class="txt_input6" NAME="TXT_ISSNAME"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10 ></TD>
				</TR>
				<TR>											
					<TD WIDTH="20%">Guarantor Code</TD>
					<TD WIDTH="30%"><INPUT TYPE="Text" class="txt_input6" NAME="TXT_GUCODE"	ALIGN="LEFT" SIZE=22 MAXLENGTH=10></TD>
					<TD WIDTH="20%">Guarantor Name</TD>
					<TD WIDTH="30%"><INPUT TYPE="Text" class="txt_input6" NAME="TXT_GUNAME"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10></TD>
				</TR>
				<TR>
					<TD>Endorser Code</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_ENCODE" ALIGN="LEFT" SIZE=22 MAXLENGTH=10 ONBLUR="endcodex(document.Form1.TXT_INSTYPE,document.Form1.TXT_ENCODE)">
						<INPUT TYPE="button" class="but_input" VALUE="Help" NAME="BUT_ENCODE"  ONCLICK="end_help(0)" ></TD>
					<TD>Endorser Name</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_ENNAME"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10 ></TD>
				</TR>
			</TABLE><HR WIDTH="*%">									
			
			<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
				<TR><TD COLSPAN='4'><B>DEBT</B></td></TR>								
				<TR><TD COLSPAN='4'><B><U>Transaction Value Date & Amount Information</U></B></td></TR>											
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
						<INPUT TYPE="button" class="but_input" VALUE="Help" NAME="BUT_CURR"  onClick="currency_help(0);"></TD>
					<TD>Primary Auction Deal</TD><TD WidTH="12%"><INPUT  TYPE="checkbox" NAME="CHB_PRIM"  onclick="val_primary()"></TD>
					
				</TR>
				<TR>
					<TD>Value Date</TD>
					<TD ID='newdate'><SELECT class="txt_input6" NAME="SEL_DATETYPE"  ONBLUR="date_obj()">
							<OPTION VALUE="SPOT" SELECTED>Spot</option>  
							<OPTION VALUE="TOM" >Tom</option>  
							<OPTION VALUE="CASH" >Cash</option>  
							<OPTION VALUE="UD">U / D</option>
						</SELECT>
					</TD>								
					
					<TD>Custodial Status</TD>
					<TD><SELECT  class="txt_input6" NAME="cust_stat" >
							<OPTION VALUE="Y" >Yes</option>  
							<OPTION VALUE="N" >No </option>  
						</SELECT>
						&nbsp;&nbsp;&nbsp;&nbsp;
						
						<!---------## Added By Manjula	on 20-07-04---------->
						
						Swift Status       
						<SELECT class="txt_input6" NAME="swift_stat" disabled>
							<OPTION VALUE="Y" SELECTED>Yes</option>  
							<OPTION VALUE="N" >No </option>  
						</SELECT>
					</TD>
					
					<!---------## End here ---------->
					
					
					
					
					
					
				</TR>
				<TD>								
					<INPUT TYPE="Hidden" NAME="HID_DATE" VALUE="01" SIZE=3 MAXLENGTH=2 >
					<INPUT TYPE="Hidden" NAME="HID_MONTH" VALUE="01" SIZE=3 MAXLENGTH=2 >
					<INPUT TYPE="Hidden" NAME="HID_YEAR" VALUE="1999" SIZE=5 MAXLENGTH=4 >								
				</TD>
				<TR>								
					<TD>Basis</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_BASIS" ALIGN="LEFT" SIZE=22 MAXLENGTH=10 ONblur="chk_basis(document.Form1.TXT_BASIS)">									
						<INPUT TYPE="button" class="but_input" VALUE="Help" NAME="BUT_BASIS"   onClick="basis_help(0);"></TD>
					<TD>Face Value</TD><!--$$##SC-->
					<!--<TD><INPUT TYPE="Text" NAME="TXT_FACEVAL" STYLE="text-align:right;"	ALIGN="LEFT" SIZE=28 MAXLENGTH=18 TABINDEX=-1 value=0  onkeypress="checkkey(event)" ONBLUR="formatnum1(document.Form1.TXT_FACEVAL)"></TD>-->
					<TD><INPUT TYPE="Text" class="txt_input6"  NAME="TXT_FACEVAL" STYLE="text-align:right;"   ALIGN="LEFT" SIZE=28 MAXLENGTH=18 TABINDEX=-1 value=0  ONBLUR="formatnum1(document.Form1.TXT_FACEVAL)"></TD><!--//ADD BY INDITHA 2005-7-11 1:13PM  VC05-001-->
					<INPUT TYPE="Hidden" NAME="HID_FACEVAL">  
				</TR>
				<TR>
					<TD>Yield to Maturity %</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_YIELD" STYLE="text-align:right;" ALIGN="LEFT" SIZE=28 MAXLENGTH=10 TABINDEX=0 ONCHANGE="formatnum01(document.Form1.TXT_YIELD)" ONBLUR="curfocus()"></TD>
					<INPUT TYPE="Hidden" NAME="HID_YIELD">
					<TD>Cost</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_COST" STYLE="text-align:right;"	ALIGN="LEFT" SIZE=28 MAXLENGTH=18 TABINDEX=-1 ONCHANGE="formatnum2(document.Form1.TXT_COST)"></TD>
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
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_DIRTY" STYLE="text-align:right;"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10 TABINDEX=-1 ONCHANGE="formatnum03(document.Form1.TXT_DIRTY)"></TD>
					<INPUT TYPE="Hidden" NAME="HID_DIRTY">
					<TD>Settlement Value</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_SETVAL" STYLE="text-align:right;" ALIGN="LEFT" SIZE=28 MAXLENGTH=18 TABINDEX=-1 ONCHANGE="formatnum4(document.Form1.TXT_SETVAL);"></TD>
					<INPUT TYPE="Hidden" NAME="HID_SETVAL">
				</TR>
			</TABLE>
			
			<HR WIDTH="*%">	
			
			
			<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
				<TR><TD COLSPAN='4'><B>EQUITY</B></TD></TR>		
				<TR><TD COLSPAN='4'><B><U>Share Information</U></B></TD></TR>
				<TR><TD><BR></TD></TR>
				<TR>
					<TD WIDTH="20%"></TD>
					<TD WIDTH="30%"></TD>
					<TD WIDTH="20%"></TD>											
					<TD WIDTH="30%"></TD>
				</TR>	
				<TR>
					<TD>Value Date</TD>				
					<TD><INPUT TYPE="Text" class="txt_input5" TABINDEX= 0 NAME="TXT_DATE1" SIZE=3 MAXLENGTH=2 ONBLUR="chkstartdate(document.Form1.TXT_DATE1,document.Form1.TXT_MONTH1,document.Form1.TXT_YEAR1)" >												
						<INPUT TYPE="Text" class="txt_input5" NAME="TXT_MONTH1" SIZE=3 MAXLENGTH=2  ONBLUR="chkstartdate(document.Form1.TXT_DATE1,document.Form1.TXT_MONTH1,document.Form1.TXT_YEAR1)">												
						<INPUT TYPE="Text"  class="txt_input5" NAME="TXT_YEAR1" SIZE=5 MAXLENGTH=4 ONBLUR="chkstartdate(document.Form1.TXT_DATE1,document.Form1.TXT_MONTH1,document.Form1.TXT_YEAR1)"></TD>													
					<TD>Purchase Cost Per Share</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_PURCH_COST"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25   ></TD>
				</TR>					
				<TR>
					<TD>Price per share</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_CLEAN1"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25  MAXLENGTH=25  ONBLUR="check_sharePrice();formatnumequity(document.Form1.TXT_CLEAN1);check()" ></TD>																														
					<TD>Broker and Other Cost&nbsp;&nbsp;&nbsp;
					</TD>
					<TD><SELECT class="txt_input6" NAME="SEL_BROKER"  onchange="get_broker_cost()"> //ID=broker  //;160()
							<OPTION VALUE="Y" SELECTED>Yes</option>  
							<OPTION VALUE="N" >No</option>  
						</SELECT><INPUT TYPE="Text" class="txt_input6" NAME="TXT_BROKER_COST"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25  ONBLUR="formatnumequity(document.Form1.TXT_BROKER_COST);get_total()"  ></TD>
				</TR>
				
				<TR>
					<TD>No of shares</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_FACEVAL1"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25   ONCHANGE="check_share()"></TD>
					<TD>Total Cost</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_TOT_COST"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25  ONBLUR="change_cal();formatnumequity(document.Form1.TXT_TOT_COST)" ></TD>
				</TR>
				
				<!---
				<TR>
					<TD>Par Value</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_PAR"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25  ONBLUR="formatnumequity(document.Form1.TXT_PAR)"  ></TD>
					<TD>Buyer Settle Date</TD>
					<TD><INPUT TYPE="Text" class="txt_input5" TABINDEX=0 NAME="TXT_BDATE" SIZE=3 MAXLENGTH=2 ONBLUR="checkallvaluesmonset(document.Form1.TXT_BDATE,document.Form1.TXT_BMONTH,document.Form1.TXT_BYEAR)">													
						<INPUT TYPE="Text" class="txt_input5" NAME="TXT_BMONTH" SIZE=3 MAXLENGTH=2O ONBLUR="checkallvaluesmonset(document.Form1.TXT_BDATE,document.Form1.TXT_BMONTH,document.Form1.TXT_BYEAR)">												
						<INPUT TYPE="Text" class="txt_input5" NAME="TXT_BYEAR" SIZE=5 MAXLENGTH=4  ONBLUR="chkstartdate1(document.Form1.TXT_BDATE,document.Form1.TXT_BMONTH,document.Form1.TXT_BYEAR)"></TD>												
				</TR>
				
				<TR>
					<TD>Nominal Value</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_NOMINAL"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25 ONBLUR="formatnumequity(document.Form1.TXT_NOMINAL)" ></TD>
					<TD>Seller Settle Date</TD>
					<TD ><INPUT TYPE="Text" class="txt_input5"  NAME="TXT_SDATE" SIZE=3 MAXLENGTH=2 ONBLUR="checkallvaluesmonset(document.Form1.TXT_SDATE,document.Form1.TXT_SMONTH,document.Form1.TXT_SYEAR)">							
						<INPUT TYPE="Text" class="txt_input5" NAME="TXT_SMONTH" SIZE=3 MAXLENGTH=2  ONBLUR="checkallvaluesmonset(document.Form1.TXT_SDATE,document.Form1.TXT_SMONTH,document.Form1.TXT_SYEAR)">									
						<INPUT TYPE="Text" class="txt_input5" NAME="TXT_SYEAR" SIZE=5 MAXLENGTH=4   ONBLUR="chkstartdate1(document.Form1.TXT_SDATE,document.Form1.TXT_SMONTH,document.Form1.TXT_SYEAR)"></TD>												
					
				</TR>
				
				<TR>
					<TD >Contract No</TD>
					<TD ><INPUT TYPE="Text" class="txt_input6" NAME="TXT_contract"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=100></TD>
					<TD></TD>
					<TD ></TD>													
					
					<TD ></TD>
				</TR>
				-->
				<TR>
					<TD>Nominal Value</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_NOMINAL"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=25 ONBLUR="formatnumequity(document.Form1.TXT_NOMINAL)" ></TD>
					<TD>Buyer Settle Date</TD>
					<TD><INPUT TYPE="Text" class="txt_input5" TABINDEX=0 NAME="TXT_BDATE" SIZE=3 MAXLENGTH=2 ONBLUR="checkallvaluesmonset(document.Form1.TXT_BDATE,document.Form1.TXT_BMONTH,document.Form1.TXT_BYEAR)">													
						<INPUT TYPE="Text" class="txt_input5" NAME="TXT_BMONTH" SIZE=3 MAXLENGTH=2O ONBLUR="checkallvaluesmonset(document.Form1.TXT_BDATE,document.Form1.TXT_BMONTH,document.Form1.TXT_BYEAR)">												
						<INPUT TYPE="Text" class="txt_input5" NAME="TXT_BYEAR" SIZE=5 MAXLENGTH=4  ONBLUR="chkstartdate1(document.Form1.TXT_BDATE,document.Form1.TXT_BMONTH,document.Form1.TXT_BYEAR)"></TD>												
				</TR>
				
				<TR>
					<TD>Contract No</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_contract"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=25 MAXLENGTH=100></TD>
					<TD>Seller Settle Date</TD>
					<TD ><INPUT TYPE="Text" class="txt_input5"  NAME="TXT_SDATE" SIZE=3 MAXLENGTH=2 ONBLUR="checkallvaluesmonset(document.Form1.TXT_SDATE,document.Form1.TXT_SMONTH,document.Form1.TXT_SYEAR)">							
						<INPUT TYPE="Text" class="txt_input5" NAME="TXT_SMONTH" SIZE=3 MAXLENGTH=2  ONBLUR="checkallvaluesmonset(document.Form1.TXT_SDATE,document.Form1.TXT_SMONTH,document.Form1.TXT_SYEAR)">									
						<INPUT TYPE="Text" class="txt_input5" NAME="TXT_SYEAR" SIZE=5 MAXLENGTH=4   ONBLUR="chkstartdate1(document.Form1.TXT_SDATE,document.Form1.TXT_SMONTH,document.Form1.TXT_SYEAR)"></TD>												
					
				</TR>
				
				<TR>
					<TD ></TD>
					<TD ></TD>
					<TD></TD>
					<TD ></TD>													
					
					<TD ></TD>
				</TR>
			</TABLE>
			
			
			
			
		</FORM>		
		<!--
		</BODY>
		<DIV>
		
		</DIV>
		</HTML>
		-->
