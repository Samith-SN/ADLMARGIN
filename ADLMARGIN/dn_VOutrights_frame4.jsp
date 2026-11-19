<!--<HTML>
<HEAD>
<TITLE>DealNet 
</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="mb-temp.css" />
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
<SCRIPT language="JavaScript">
	i=2;
	b=1;
	k=2;
	j=2;
	m=1;
	c=1;
	n=2;
	d=3;
	p=2;
	q=2;
	r=2;
	s=2;
	
	
	function disable_inputs() {
		for (var i = 0; i< document.Form1.elements.length; i++) {
			document.Form1.elements[i].disabled = true;
		}
		
		document.Form1.SEL_COMM1.disabled = false;
		document.Form1.SEL_COMM2.disabled = false;
		document.Form1.Text_deal_ref.disabled = false;
		document.Form1.Text_help_ref.disabled = false;
		document.Form1.button_broker.disabled = false;
		document.Form1.button_main.disabled = false;
		document.Form1.NEW.disabled = false;
		document.Form1.MOD.disabled = false;
		document.Form1.INQ.disabled = false;
		document.Form1.REA.disabled = false;
		document.Form1.calcel_but.disabled = false;
		document.Form1.Exit_but.disabled = false;
		
	}	
	
	function datapart2(){
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?deal_code="+document.Form2.Text_deal_ref.value+"&sec_code="+document.Form1.TXT_SECCODE.value+"&chksql=outdealinfo2";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
			m_size=data_vec.length;
		if(m_size>0){
			serialno=0;
			document.Form1.TXT_SENOIDEN1.value=data_vec[serialno];
			document.Form1.TXT_FACEVAL2.value=format_noobject(data_vec[serialno+1]);
			tranfaceval();
			serialno=2;
			while (m_size>serialno){
				newpart2();
				mt_sno="TXT_SENOIDEN"+n;
				VAL_SNO=document.Form1.elements[mt_sno];
				mt_face="TXT_FACEVAL"+d;
				VAL_FACE=document.Form1.elements[mt_face];
				VAL_SNO.value=data_vec[serialno];
				VAL_FACE.value=format_noobject(data_vec[serialno+1]);
				tranfaceval2();
				n=n+1;
				d=d+1;
				serialno=serialno+2;
			}
		}
		datapart3();
	}
	
	
	
	function datapart3(){
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?deal_code="+document.Form2.Text_deal_ref.value+"&chksql=outdealinfo3";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
			m_size=data_vec.length;
		//alert(document.Form1.TXT_SECIDEN.value);
		document.Form1.TXT_SECCODE.value=document.Form1.TXT_SECIDEN.value;
		document.Form1.TXT_TOTVAL.value=document.Form1.TXT_FACEVAL.value;
		document.Form1.TXT_INSTYPE1.value=document.Form1.TXT_INSTYPE.value;
		if(m_size>0){
			modeno=0;
			document.Form1.SEL_SETTLE1.value=data_vec[modeno];
			document.Form1.TXT_SETAMO1.value=format_noobject(data_vec[modeno+1]);
			//	calculate_tot();
			if(data_vec[modeno+2]!='@@'){
				document.Form1.TXT_BACC1.value=data_vec[modeno+2];
			}
			if(data_vec[modeno+3]!='@@'){
				document.Form1.SEL_COMM1.value=data_vec[modeno+3];
			}
			if(data_vec[modeno+4]!='@@'){
				document.Form1.TXT_SACC1.value=data_vec[modeno+4];
			}
			if(data_vec[modeno+5]!='@@'){
				document.Form1.SEL_COMM2.value=data_vec[modeno+5];
			}
			modeno=6;
			document.Form1.SEL_MODES.value=(m_size/6);
			nextline();
			while (m_size>modeno){
				mt_ssett="SEL_SETTLE"+p;
				VAL_SETT=document.Form1.elements[mt_ssett];
				mt_samo="TXT_SETAMO"+q;
				VAL_SAMO=document.Form1.elements[mt_samo];
				mt_bacc="TXT_BACC"+r;
				VAL_BACC=document.Form1.elements[mt_bacc];
				mt_sacc="TXT_SACC"+s;
				VAL_SACC=document.Form1.elements[mt_sacc];
				
				VAL_SETT.value=data_vec[modeno];
				VAL_SAMO.value=format_noobject(data_vec[modeno+1]);
				if(data_vec[modeno+2]!='@@'){	
					VAL_BACC.value=data_vec[modeno+2];
				}
				if(data_vec[modeno+4]!='@@'){
					VAL_SACC.value=data_vec[modeno+4];
				}
				p=p+1;
				q=q+1;
				r=r+1;
				s=s+1;
				modeno=modeno+6;
			}
		}
		nomodes=document.Form1.SEL_MODES.value;
		while (nomodes>=c){
			mt_sttamo="TXT_SETAMO"+c;
			VAL_SETT2=document.Form1.elements[mt_sttamo];
			VAL_SETT2.value=format_noobject(VAL_SETT2.value);
			c=c+1;
			if(c>2){
				document.Form1.TXT_TOAMO.value=format_noobject(parseFloat(unformat_noobject(document.Form1.TXT_TOAMO.value))+parseFloat(unformat_noobject(VAL_SETT2.value))+parseFloat(unformat_noobject(document.Form1.HID_MVAL.value)));
				document.Form1.HID_MVAL.value=0.00;
			}
			else{
				document.Form1.HID_TOAMO.value=format_noobject(parseFloat(unformat_noobject(document.Form1.HID_TOAMO.value))+parseFloat(unformat_noobject(VAL_SETT2.value)));
				document.Form1.HID_MVAL.value=document.Form1.HID_TOAMO.value;
			}
		}
		datapart4();
	}
	
	
	
	function datapart4(){
		m_buyer=document.Form1.TXT_BCODE.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?chksql=broker_details_borro&ref_num="+document.Form2.Text_deal_ref.value+"&borrower_code="+m_buyer+"";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size2=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
			m_size=data_vec.length;
		if(m_size2>0){
			document.Form1.TXT_BCODE1.value=data_vec[0];
			document.Form1.TXT_BNAME1.value=data_vec[1];
			document.Form1.TXT_BRAGE1.value=data_vec[2];
			document.Form1.SEL_BBASE1.value=data_vec[3];
			document.Form1.SEL_FEETYPE1.value=data_vec[4];
			document.Form1.TXT_FEEAMO1.value=data_vec[5];
			document.Form1.TXT_VAL1.value=data_vec[6];
			document.Form1.TXT_TOTAMOU1.value=data_vec[7];
		}
		m_seller=document.Form1.TXT_SCODE.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?chksql=broker_details_borro&ref_num="+document.Form2.Text_deal_ref.value+"&borrower_code="+m_seller+"";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size2=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
			m_size=data_vec.length;
		if(m_size2>0){
			document.Form1.TXT_BCODE2.value=data_vec[0];
			document.Form1.TXT_BNAME2.value=data_vec[1];
			document.Form1.TXT_BRAGE2.value=data_vec[2];
			document.Form1.SEL_BBASE2.value=data_vec[3];
			document.Form1.SEL_FEETYPE2.value=data_vec[4];
			document.Form1.TXT_FEEAMO2.value=data_vec[5];
			document.Form1.TXT_VAL2.value=data_vec[6];
			document.Form1.TXT_TOTAMOU2.value=data_vec[7];
		}
		disable_inputs();
	}
	
	
	function calculate_tot(){  
		if (document.Form1.SEL_MODES.value<cc){
			cc=1;
			qq=2;
		}
		if (cc==1){
			document.Form1.TXT_TOAMO.value="0.00";
		}
		var missval;
		document.Form1.HIDD_SETAMO1.value=document.Form1.TXT_SETVAL.value;
		if (document.Form1.SEL_MODES.value>1){
			mt_sttamo="TXT_SETAMO"+cc;
			VAL_SETT=document.Form1.elements[mt_sttamo];
			VAL_SETT.value=format_noobject(VAL_SETT.value);
			cc=cc+1;			
			document.Form1.TXT_TOAMO.value=format_noobject(parseFloat(unformat_noobject(document.Form1.TXT_TOAMO.value))+parseFloat(unformat_noobject(VAL_SETT.value)));
		}
		missval=format_noobject(parseFloat(unformat_noobject(document.Form1.TXT_TOAMO.value))-parseFloat(unformat_noobject(document.Form1.HIDD_SETAMO1.value)));
		if(parseFloat(missval)>0.5 || parseFloat(missval)<-0.5){
			alert('Settlement amount total should be '+document.Form1.HIDD_TXT_CURR.value+' '+document.Form1.HIDD_SETAMO1.value+'. There is a missmatch of '+document.Form1.HIDD_TXT_CURR.value+' '+missval+'. Please make the required changes and press the TAB key');
			if (document.Form1.SEL_MODES.value>=qq){
				dup_sttamo2="TXT_SETAMO"+qq;
				M_SETT=document.Form1.elements[dup_sttamo2];
				M_SETT.focus();
				qq=qq+1;
			}
		}
	}
	
	
	function codes_help1(obj1) {
		bpctype="";
		spctype="";
		bpctype=document.Form1.HID_TYPE1.value;
		spctype=document.Form1.HID_TYPE2.value;
		if (bpctype=='P'){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+document.Form1.TXT_BCODE.value+"&chksql=settle_out1";
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
		}
		if (bpctype=='C'){
			alert(document.Form1.TXT_BCODE.value);
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+document.Form1.TXT_BCODE.value+"&chksql=settle_out2";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?seller_code="+document.Form1.TXT_BCODE.value+"&chksql=settle_out2";
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
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
		m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" >'+
			'<TR BGCOLOR="darkblue"><TD WIDTH="30%"><B>Account No</B></TD>' +
			'<TD WIDTH="70%"><B>Bank Name</B></TD></TR>'+
			m_row+
			'</TABLE>'; 
		myDialogObj.htmlstr = m_writedata;
		myDialogObj.returnval = "";
		
		popupwin = window.showModalDialog("http://www.srilanka.sasianet.lk/mbfsl/help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		obj1.value=myDialogObj.returnval;
		obj1.focus();			
	}			
	
	
	
	function codes_help2(obj1) {
		bpctype="";
		spctype="";
		bpctype=document.Form1.HID_TYPE1.value;
		spctype=document.Form1.HID_TYPE2.value;
		if (spctype=='P'){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?seller_code="+document.Form1.TXT_SCODE.value+"&chksql=settle_out1";
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
		}
		if (spctype=='C'){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?seller_code="+document.Form1.TXT_SCODE.value+"&chksql=settle_out2";
			//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+document.Form1.TXT_SCODE.value+"&chksql=settle_out2";
			//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+document.Form1.TXT_BCODE.value+"&chksql=settle_out2";
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
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
		m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" >'+
			'<TR BGCOLOR="darkblue"><TD WIDTH="30%"><B>Account No</B></TD>' +
			'<TD WIDTH="70%"><B>Bank Name</B></TD></TR>'+
			m_row+
			'</TABLE>'; 
		myDialogObj.htmlstr = m_writedata;
		myDialogObj.returnval = "";
		
		popupwin = window.showModalDialog("http://www.srilanka.sasianet.lk/mbfsl/help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		obj1.value=myDialogObj.returnval;
		obj1.focus();			
	}			
	
	
	function tranfaceval(){
		document.Form1.TXT_MISS1.value=format_noobject(parseFloat(unformat_noobject(document.Form1.TXT_TOTVAL.value))-parseFloat(unformat_noobject(document.Form1.TXT_FACEVAL2.value)));
	}
	
	function tranfaceval2(){
		document.Form1.TXT_MISS1.value=format_noobject(parseFloat(unformat_noobject(document.Form1.TXT_TOTVAL.value))-parseFloat(unformat_noobject(document.Form1.TXT_FACEVAL2.value)));
		mt_miss="TXT_MISS"+k;
		VAL_MISS=document.Form1.elements[mt_miss];
		mt_face="TXT_FACEVAL"+k;
		VAL_FACE=document.Form1.elements[mt_face];
		mt_miss2="TXT_MISS"+j;
		VAL_MISS2=document.Form1.elements[mt_miss2];
		mt_face2="TXT_FACEVAL"+j;
		VAL_FACE2=document.Form1.elements[mt_face2];
		VAL_MISS2.value=format_noobject(parseFloat(unformat_noobject(VAL_MISS.value))-parseFloat(unformat_noobject(VAL_FACE2.value)));
		k=k+1;
		j=j+1;
	}
	
	
	function formatval(){
		mt_face="TXT_FACEVAL"+m;
		VAL_FACE=document.Form1.elements[mt_face];
		VAL_FACE.value=format_noobject(VAL_FACE.value);
		m=m+1;			
	}
	
	function myDialogObj() {
		var htmlstr;
		var returnval;
	}
	
	function feeamo1(num){
		num.value=format_noobject(num.value);
		document.Form1.HID_FEEAMO1.value=unformat_noobject(num.value);
		document.Form1.TXT_VAL1.focus();
	}
	
	function feeamo2(num1){
		num1.value=format_noobject(num1.value);
		document.Form1.HID_FEEAMO2.value=unformat_noobject(num1.value);
		document.Form1.TXT_VAL2.focus();
	}
	
	function totamo1(num2){
		num2.value=format_noobject(num2.value);
		document.Form1.HID_TOTAMOU1.value=unformat_noobject(num2.value);
		document.Form1.TXT_BCODE2.focus();
	}
	
	function totamo2(num3){
		num3.value=format_noobject(num3.value);
		document.Form1.HID_TOTAMOU2.value=unformat_noobject(num3.value);
	}
	
	function gsstamo1(num4){
		num4.value=format_noobject(num4.value);
		document.Form1.HID_VAL1.value=unformat_noobject(num4.value);
		document.Form1.TXT_TOTAMOU1.focus();
	}
	
	function gsstamo2(num5){
		num5.value=format_noobject(num5.value);
		document.Form1.HID_VAL2.value=unformat_noobject(num5.value);
		document.Form1.TXT_TOTAMOU2.focus();
	}
	
	function bprecent1(num6){
		num6.value=format_noobject0(num6.value);
		document.Form1.SEL_BBASE1.focus()
		document.Form1.HID_BRAGE1.value=unformat_noobject(num6.value);
		
	}
	
	
	function bprecent2(num7){
		num7.value=format_noobject0(num7.value);
		document.Form1.SEL_BBASE2.focus()
		document.Form1.HID_BRAGE2.value=unformat_noobject(num7.value);
		
	}
	
	
	
	function gst_help() {
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?chksql=gst";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
			m_size=data_vec.length;
		document.Form1.TXT_GST1.value=data_vec[0];
		document.Form1.TXT_GST2.value=data_vec[0];
	}
	
	
	function brocode(objx,objy,objz){
		if (objx.value=="") {
			alert('Please enter a Code');
			objx.value="";
			objx.focus();
		}
		else {
			m_buycode=objx.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+m_buycode.toUpperCase()+"&chksql=chkbcode";
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			if (m_size==0) {
				if (confirm("Invalid Code..Press the OK button if you want a list of Codes or Press the Cancel button to type again")) {
					bro_help(objx);
					objx.focus();
				}
				else{
					objx.focus();
					objx.value="";
					objx.focus();
				}
			}	  
			else{
				objy.value=data_vec[1];
				objz.focus();
			}
		}
	}
	
	
	function bro_help(obj1) {
		m_url="http://www.srilanka.sasianet.lk:7001/fvaloutrights?chksql=bcode_lookup";
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
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
			'<TR BGCOLOR="darkblue"><TD WIDTH="30%"><B>Broker Code</B></TD>' +
			'<TD WIDTH="70%"><B>Broker Name</B></TD></TR>'+
			m_row+
			'</TABLE>'; 
		myDialogObj.htmlstr = m_writedata;
		myDialogObj.returnval = "";
		
		popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		obj1.value=myDialogObj.returnval;
		obj1.focus();			
	}	
	
	
	function newpart2(){
		hid_val="";
		mt_payamt="TXT_MISS"+i;
		TXT_HID=document.Form1.elements[mt_payamt];
		hid_val=unformat_noobject(TXT_HID.value);
		if (hid_val>0){
			i=i+1;
			m_row="";
			m_writedata ='<TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0" >'+
				'<TR>'+
				'<TD WIDTH="39%"></TD>'+
				'<TD WIDTH="37%"></TD>'+
				'<TD WIDTH="22%"></TD>'+
				'</TR>'+
				'<TR>'+
				'<TD><INPUT TYPE="Text" class="txt_input5" NAME="TXT_SENOIDEN'+i+'" ALIGN="LEFT" SIZE=19 MAXLENGTH=10 ></TD>'+
				'<TD><INPUT TYPE="Text" class="txt_input5" NAME="TXT_FACEVAL'+i+'" STYLE="text-align:right;"	ALIGN="LEFT" SIZE=19 MAXLENGTH=10 ONBLUR="formatval();tranfaceval2()"></TD>'+
				'<TD><INPUT TYPE="Text" class="txt_input5" NAME="TXT_MISS'+i+'" STYLE="text-align:right;"	ALIGN="LEFT" SIZE=19 MAXLENGTH=10 ONBLUR="newpart2()"></TD>'+
				'</TR>'+

				'</TABLE>'; 
			notbal.innerHTML=notbal.innerHTML+m_writedata;	
			document.Form1.HID_SECDET.value=i;
			mt_col="TXT_SENOIDEN"+i;
			TXT_COL=document.Form1.elements[mt_col];
			TXT_COL.focus();
		}		
		else{
			document.Form1.SEL_SETTLE1.focus();
		}	
	}
	
	
	
	function dyoname1(){
		a=a+1;
		m_row="";
		m_writedata ='<TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0" >'+
			'<TD WIDTH="20%">Settlement Mode '+a+'</TD>'+
			'<TD><SELECT class="txt_input6" NAME="SEL_SETTLE'+a+'" >'+
			'<OPTION VALUE="CB_CHEQUE" SELECTED>Central Bank Cheque</option>'+  
			'<OPTION VALUE="CB_TRANF" >Central Bank Transfer</option>'+  
			'<OPTION VALUE="BANK_TRANF" >Bank Transfer</option>'+  
			'<OPTION VALUE="CHEQUE" >Cheque</option>'+  
			'<OPTION VALUE="CASH" >Cash</option>'+  
			'<OPTION VALUE="CURR_ACC" >Margin Trading Account </option>'+
			'</SELECT>'+
			'</TD>'+		
			'<TD WIDTH="20%">Settlement Amount</TD>'+
			'<TD WIDTH="30%"><INPUT class="txt_input6" TYPE="Text" NAME="TXT_SETAMO'+a+'" STYLE="text-align:right;"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10  ONBLUR="calculate_tot()"></TD>'+
			'<TR>'+
			'<TD></TD>'+
			'<TD></TD>'+
			'</TABLE>';
		othername1.innerHTML=othername1.innerHTML+m_writedata;	
		document.Form1.HID_NOMODE.value=a;
	}
	
	
	
	
	
	
	function dyoname2(){
		b=b+1;
		m_row="";
		m_writedata ='<TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0" >'+
			'<TR>'+
			'<TD WIDTH="19%">Buyer Account Mode '+b+'</TD>'+
			'<TD WIDTH="21%"><INPUT class="txt_input6" TYPE="Text" NAME="TXT_BACC'+b+'" ALIGN="LEFT" SIZE=22 MAXLENGTH=10 ></TD>'+
			'<TD WIDTH="8%"><INPUT TYPE="button" class="but_input"  VALUE="Help" NAME="BUT_BACC2"  ONCLICK="codes_help1(document.Form1.TXT_BACC'+b+')"></TD>'+
			'<TD WIDTH="19%">Seller Account Mode '+b+'</TD>'+
			'<TD WIDTH="21%"><INPUT class="txt_input6" TYPE="Text" NAME="TXT_SACC'+b+'" ALIGN="LEFT" SIZE=22 MAXLENGTH=10 ></TD>'+
			'<TD WIDTH="8%"><INPUT TYPE="button" class="but_input"  VALUE="Help" NAME="BUT_SACC2"  ONCLICK="codes_help2(document.Form1.TXT_SACC'+b+')"></TD>'+
			'<TR>'+
			'</TABLE>';
		othername2.innerHTML=othername2.innerHTML+m_writedata;	
	}
	
	
	
	
	function nextline(){
		a=1;
		b=1;
		m_writedata="";
		othername1.innerHTML=m_writedata;	
		othername2.innerHTML=m_writedata;	
		sum=document.Form1.SEL_MODES.value
			sumx=document.Form1.SEL_MODES.value
			while (sum!=1){
				dyoname2();
				dyoname1();
				sum=sum-1;
			}
			if(sumx>=2){
				m_writedata ='<TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="1" >'+
					'<TR><TD WIDTH="20%"></TD><TD WIDTH="30%"></TD><TD WIDTH="20%">Total Amount</TD>'+
					'<TD WIDTH="30%"><INPUT class="txt_input6" TYPE="Text" NAME="TXT_TOAMO" STYLE="text-align:right;" ALIGN="LEFT" SIZE=28 MAXLENGTH=10 ></TD>'+
					'</TR>'+
					'</TABLE>';
				total.innerHTML=m_writedata;
				//document.Form1.TXT_SETAMO1.value="";
				document.Form1.TXT_TOAMO.value="0.00";
				//document.Form1.TXT_TOAMO.focus();
			}
	}
</SCRIPT>
<!--
<BODY onload="gst_help();document.Form1.SEL_MODES.options[0].selected=true">
<FORM  NAME="Form1" METHOD="POST" ACTION=servlet_client_url+":"+client_t3_port+"/"+client_name+"fsav_outrig" >			
<INPUT TYPE="Hidden" NAME="SCR_NAME"	VALUE="BROKERAGE" >
-->
<INPUT TYPE="Hidden" NAME="HID_REF_NO" VALUE="" >
<INPUT TYPE="Hidden" NAME="HID_TOAMO" VALUE=0.00>
<INPUT TYPE="Hidden" NAME="HID_MVAL" VALUE=0.00>


<TD><INPUT TYPE="hidden" NAME="HID_SECDET" VALUE=1 ></TD>	
<TABLE WidTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >							
	<TD WidTH="1%"></TD>
	<TD WidTH="99%">
		
		<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
			<TR>
				<TD WIDTH="20%"><B><U>Security Determination</B></U></TD>
				<TD WIDTH="30%"></TD>
				<TD WIDTH="20%"></TD>
				<TD WIDTH="30%"></TD>
			</TR>
			<TR>
				<TD COLSPAN='4'> <BR></TD> 
			</TR>
			<TR>
				<TD>Issuer</TD>
				<TD><INPUT TYPE="Text" NAME="TXT_ISSURE" class="txt_input6"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10 ></TD>
				<TD>Instrument Type</TD>
				<TD><INPUT TYPE="Text" NAME="TXT_INSTYPE1" class="txt_input6"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10 ></TD>
			</TR>
			<TR>
				<TD>Security Code</TD>
				<TD><INPUT TYPE="Text" NAME="TXT_SECCODE" class="txt_input6"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10 ></TD>
				<TD>Total Face Value</TD>
				<TD><INPUT TYPE="Text" NAME="TXT_TOTVAL" class="txt_input6" STYLE="text-align:right;"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10 ></TD>
			</TR>
		</TABLE>
		
		<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
			<TR><TD COLSPAN='3'> </TD> </TR>
			<TR>
				<TD WIDTH="40%"><B>Serial Number</B></TD>
				<TD WIDTH="38%"><B>Face Value</B></TD>
				<TD WIDTH="22%"><B>Mismatch</B></TD>
			</TR>
			
			<TR>
				<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_SENOIDEN1"	ALIGN="LEFT" SIZE=19 MAXLENGTH=10 ></TD>
				<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_FACEVAL2"	 STYLE="text-align:right;" ALIGN="LEFT" SIZE=19 MAXLENGTH=10 ONBLUR="formatval();tranfaceval()"></TD>
				<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_MISS1" STYLE="text-align:right;"	 ALIGN="LEFT" SIZE=19 MAXLENGTH=10 ONBLUR="newpart2()"></TD>
			</TR>
			
		</TABLE>
		<DIV ID='notbal'></DIV>
		
		
		
		
		<HR WIDTH="*%">	
		
		
		
		
		<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
			<TR><TD COLSPAN='4'><B><U>Settlement Information</U></B></TD> </TR>
			<TR>	
				<TD WIDTH="20%"></TD>
				<TD WIDTH="30%"></TD>
				<TD WIDTH="20%"></TD>
				<TD WIDTH="30%"></TD>
			</TR>
			<TR><TD COLSPAN='4'><BR></TD></TR>
			<TR>
				<TD>Number of Modes</TD>
				<TD><SELECT class="txt_input6" NAME="SEL_MODES"  ONCHANGE="nextline()">
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
					<TD><INPUT TYPE="hidden" NAME="HID_NOMODE" VALUE=1 ></TD>
					
					<TD></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD>Settlement Mode 1</TD>
					<TD><SELECT class="txt_input6" NAME="SEL_SETTLE1" >
							<OPTION VALUE="CB_CHEQUE" SELECTED>Central Bank Cheque</option>  
							<OPTION VALUE="CB_TRANF" >Central Bank Transfer</option>  
							<OPTION VALUE="BANK_TRANF" >Bank Transfer</option>  
							<OPTION VALUE="CHEQUE" >Cheque</option>  
							<OPTION VALUE="CASH" >Cash</option>  
							<OPTION VALUE="CURR_ACC" >Margin Trading Account </option>
						</SELECT>
					</TD>	
					<TD>Settlement Amount</TD>
					<TD><INPUT class="txt_input6" TYPE="Text" NAME="TXT_SETAMO1"	ALIGN="LEFT"  STYLE="text-align:right;" SIZE=28 ONBLUR="calculate_tot()"></TD>
					<TD><INPUT TYPE="hidden" NAME="HIDD_SETAMO1"></TD>
				</TR>
			</TABLE>
			<DIV ID='othername1'></DIV>
			<DIV ID='total'></DIV>
			
			<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >	
				<TR>
					<TD WIDTH="19%">Buyer Account Mode 1</TD>
					<TD WIDTH="21%"><INPUT class="txt_input6" TYPE="Text" NAME="TXT_BACC1" ALIGN="LEFT" SIZE=22 MAXLENGTH=10 ></TD>
					<TD WIDTH="8%"><INPUT TYPE="button" class="but_input"  VALUE="Help" NAME="BUT_BACC1"  ONCLICK="codes_help1(document.Form1.TXT_BACC1)"></TD>
					<TD WIDTH="19%">Seller Account Mode 1</TD>
					<TD WIDTH="21%"><INPUT class="txt_input6" TYPE="Text" NAME="TXT_SACC1" ALIGN="LEFT" SIZE=22 MAXLENGTH=10 ></TD>
					<TD WIDTH="8%"><INPUT TYPE="button" class="but_input"  VALUE="Help" NAME="BUT_SACC2"  ONCLICK="codes_help2(document.Form1.TXT_SACC1)"></TD>
				</TR>
			</TABLE>
			<DIV ID='othername2'></DIV>
			
			
			<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >	
				<TR>	
					<TD WIDTH="20%">Comments</TD>
					<TD WIDTH="30%"><TEXTAREA class="txt_input6" NAME="SEL_COMM1" COLS = "18" ROWS = "2"></TEXTAREA>
					</TD>		    
					<TD WIDTH="20%">Comments</TD>
					<TD WIDTH="30%"><TEXTAREA class="txt_input6" NAME="SEL_COMM2" COLS = "18" ROWS = "2"></TEXTAREA>
					</TD>		    
				</TR>			                
			</TABLE>
			<HR WIDTH="*%">
			
			
			
			
			<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
				<TR>
					<TD WIDTH="20%"><B><U>Brokerage from Buyer</B></U></TD>
					<TD WIDTH="30%"></TD>
					<TD WIDTH="20%"><B><U>Brokerage from Seller</B></U></TD>
					<TD WIDTH="30%"></TD>
				</TR>
				<TR><TD COLSPAN ='4'><BR></TD></TR>
				<TR>
					<TD>Broker Code</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_BCODE1" ALIGN="LEFT" SIZE=22 TABINDEX=0 MAXLENGTH=10 ONBLUR="brocode(document.Form1.TXT_BCODE1,document.Form1.TXT_BNAME1,document.Form1.TXT_BRAGE1)">
						<INPUT TYPE="button" VALUE="Help" class="but_input"  NAME="BUT_BCODE1"  ONCLICK="bro_help(document.Form1.TXT_BCODE1)"></TD>
					<TD>Broker Code</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_BCODE2" ALIGN="LEFT" SIZE=22 TABINDEX=-1 MAXLENGTH=10 ONBLUR="brocode(document.Form1.TXT_BCODE2,document.Form1.TXT_BNAME2,document.Form1.TXT_BRAGE2)">
						<INPUT TYPE="button" VALUE="Help" class="but_input"  NAME="BUT_BCODE2"  ONCLICK="bro_help(document.Form1.TXT_BCODE2)"></TD>
				</TR>
				<TR>
					<TD>Broker Name</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_BNAME1"	ALIGN="LEFT" SIZE=28  TABINDEX=-1 MAXLENGTH=10 ></TD>
					<TD>Broker Name</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_BNAME2"	ALIGN="LEFT" SIZE=28 TABINDEX=-1 MAXLENGTH=10 ></TD>
				</TR>
				<TR>
					<TD>Brokerage %</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_BRAGE1"	ALIGN="LEFT" SIZE=28 TABINDEX=-1 MAXLENGTH=10 ONBLUR="bprecent1(document.Form1.TXT_BRAGE1);"></TD>
					<INPUT TYPE="Hidden" NAME="HID_BRAGE1">
					<TD>Brokerage %</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_BRAGE2"	ALIGN="LEFT" SIZE=28 TABINDEX=-1 MAXLENGTH=10 ONBLUR="bprecent2(document.Form1.TXT_BRAGE2);" ></TD>
					<INPUT TYPE="Hidden" NAME="HID_BRAGE2">
				</TR>
				<TR>
					<TD>Brokerage Base</TD>
					<TD WIDTH="30%"><SELECT class="txt_input6" NAME="SEL_BBASE1"  TABINDEX=-1 ONBLUR="document.Form1.SEL_FEETYPE1.focus()">
							<OPTION VALUE="FV" SELECTED>Face Value</option>  
							<OPTION VALUE="COST" >Cost</option>  
							<OPTION VALUE="SV" >Settlement Value</option>  
							<OPTION VALUE="UD">Higher</option>
						</SELECT>
					</TD><TD>Brokerage Base</TD>
					<TD WIDTH="30%"><SELECT class="txt_input6" NAME="SEL_BBASE2" TABINDEX=-1 ONBLUR="document.Form1.SEL_FEETYPE2.focus()">
							<OPTION VALUE="FV" SELECTED>Face Value</option>  
							<OPTION VALUE="COST" >Cost</option>  
							<OPTION VALUE="SV" >Settlement Value</option>  
							<OPTION VALUE="UD">U / D</option>
						</SELECT></TD>
				</TR>
				<TR>
					<TD>Fee Type</TD>
					<TD WIDTH="30%"><SELECT class="txt_input6" NAME="SEL_FEETYPE1" TABINDEX=-1 ONBLUR="document.Form1.TXT_FEEAMO1.focus()" >
							<OPTION VALUE="PR" SELECTED>Pro rated</option>  
							<OPTION VALUE="FL">Flat</option>
						</SELECT>
					</TD>	
					<TD>Fee Type</TD>
					<TD WIDTH="30%"><SELECT class="txt_input6" NAME="SEL_FEETYPE2" TABINDEX=-1 ONBLUR="document.Form1.TXT_FEEAMO2.focus()" >
							<OPTION VALUE="PR" SELECTED>Pro rated</option>  
							<OPTION VALUE="FL">Flat</option>
						</SELECT>
					</TD>	
				</TR>
				<TR>
					<TD>Fee Amount</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_FEEAMO1"	ALIGN="LEFT" SIZE=28 TABINDEX=-1 MAXLENGTH=10 ONBLUR="feeamo1(document.Form1.TXT_FEEAMO1)">
						<INPUT TYPE="Hidden" NAME="HID_FEEAMO1"></TD>
					<TD>Fee Amount</TD>
					<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_FEEAMO2"	ALIGN="LEFT" SIZE=28 TABINDEX=-1 MAXLENGTH=10 ONBLUR="feeamo2(document.Form1.TXT_FEEAMO2)">
						<INPUT TYPE="Hidden" NAME="HID_FEEAMO2">
						<INPUT TYPE="Hidden" NAME="HIDD_TXT_CURR"></TD>
					
				</TR>
			</TABLE>
			
			
			
			<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
				<TR>
					<TD WIDTH="10%">VAT</TD>
					<TD WIDTH="10%"><INPUT class="txt_input6"  TYPE="Text" NAME="TXT_GST1"	ALIGN="LEFT" SIZE=7 TABINDEX=-1 MAXLENGTH=10 ></TD>
					<TD WIDTH="30%"><INPUT class="txt_input6" TYPE="Text" NAME="TXT_VAL1"	ALIGN="LEFT" SIZE=28 TABINDEX=-1 MAXLENGTH=10 ONBLUR="gsstamo1(document.Form1.TXT_VAL1)">
					<INPUT TYPE="Hidden" NAME="HID_VAL1"></TD>
					<TD WIDTH="10%">VAT</TD>
					<TD WIDTH="10%"><INPUT class="txt_input6" TYPE="Text" NAME="TXT_GST2"	ALIGN="LEFT" SIZE=7 TABINDEX=-1 MAXLENGTH=10 ></TD>
					<TD WIDTH="30%"><INPUT class="txt_input6" TYPE="Text" NAME="TXT_VAL2"	ALIGN="LEFT" SIZE=28 TABINDEX=-1 MAXLENGTH=10 ONBLUR="gsstamo2(document.Form1.TXT_VAL2)">
					<INPUT TYPE="Hidden" NAME="HID_VAL2"></TD>
				</TR>
			</TABLE>
			
			
			<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
				<TR>
					<TD WIDTH="20%">Total Amount Due</TD>
					<TD WIDTH="30%"><INPUT class="txt_input6" TYPE="Text" NAME="TXT_TOTAMOU1"	ALIGN="LEFT" TABINDEX=-1 SIZE=28 MAXLENGTH=10 ONBLUR="totamo1(document.Form1.TXT_TOTAMOU1)">
						<INPUT TYPE="Hidden" NAME="HID_TOTAMOU1"></TD>
					<TD WIDTH="20%">Total Amount Due</TD>
					<TD WIDTH="30%"><INPUT class="txt_input6" TYPE="Text" NAME="TXT_TOTAMOU2"	ALIGN="LEFT" TABINDEX=-1 SIZE=28 MAXLENGTH=10 ONBLUR="totamo2(document.Form1.TXT_TOTAMOU2)">
						<INPUT TYPE="Hidden" NAME="HID_TOTAMOU2"></TD>
				</TR>
			</TABLE>
			<HR WIDTH="*%">
			
		</TD>
	</TR>
</TABLE>


<!--
</FORM>
</BODY>
<DIV>
<SCRIPT language1.2="JavaScript" src="validate.js"></SCRIPT>
</DIV>
</HTML>
-->
