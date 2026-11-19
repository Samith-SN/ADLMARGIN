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
<SCRIPT language="JavaScript" type="text/javascript">
	ii=1;
	bb=1;
	kk=1;
	jj=2;
	mm=1;
	ccc=1;
	cccc=1;
	nn=2;
	dd=2;
	pp=2;
	qqq=2;
	qqqq=2;
	rr=2;
	ss=2;    
	
	
	function form_gst(num6){
		document.Form1.TXT_GST1.value=format_noobject0(num6.value);
	}
	
	function form_gst2(num6){
		document.Form1.TXT_GST2.value=format_noobject0(num6.value);
	}
	
	function calculate_tot(){  
		if (document.Form1.SEL_MODES.value<cccc){
			cccc=1;
			qqqq=2;
		}
		if (cccc==1){
			document.Form1.TXT_TOAMO.value="0.00";
		}
		var missval;
		document.Form1.HIDD_SETAMO1.value=document.Form1.TXT_SETVAL.value;
		while (document.Form1.SEL_MODES.value>=cccc){
			mt_sttamo="TXT_SETAMO"+cccc;
			VAL_SETT=document.Form1.elements[mt_sttamo];
			VAL_SETT.value=format_noobject(VAL_SETT.value);
			cccc=cccc+1;			
			document.Form1.TXT_TOAMO.value=format_noobject(parseFloat(unformat_noobject(document.Form1.TXT_TOAMO.value))+parseFloat(unformat_noobject(VAL_SETT.value)));
		}
		missval=format_noobject(parseFloat(unformat_noobject(document.Form1.TXT_TOAMO.value))-parseFloat(unformat_noobject(document.Form1.HIDD_SETAMO1.value)));
		if(parseFloat(missval)>0.5 || parseFloat(missval)<-0.5){
			alert('Settlement amount total should be '+document.Form1.HIDD_TXT_CURR.value+' '+document.Form1.HIDD_SETAMO1.value+'. There is a missmatch of '+document.Form1.HIDD_TXT_CURR.value+' '+missval+'. Please make the required changes and press the TAB key');
		}
	}
	
	
	/*
	function codes_help1(obj1) {
		bpctype="";
		spctype="";
		bpctype=parent.frames[0].document.Form1.HID_TYPE1.value;
		spctype=parent.frames[0].document.Form1.HID_TYPE2.value;
		if (bpctype=='P'){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+parent.frames[0].document.Form1.TXT_BCODE.value+"&chksql=settle_out1";
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
		}
		if (bpctype=='C'){
			alert(parent.frames[0].document.Form1.TXT_BCODE.value);
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+parent.frames[0].document.Form1.TXT_BCODE.value+"&chksql=settle_out2";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?seller_code="+parent.frames[0].document.Form1.TXT_BCODE.value+"&chksql=settle_out2";
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
		}
		vec_pos=0;
		lineno=1;
		m_row="";
		while (vec_pos<m_size) {
			m_issu_code=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
			m_issu_name=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
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
	
	*/
	
	
	var globe_obj;
	
	function codes_help1(obj,m_strat){
		globe_obj = obj;
		var aForm;    //  aForm =oForm.elements;
		aForm =  document.getElementById('Form1');
		
		var bpctype=document.Form1.HID_TYPE1.value;
		var spctype=document.Form1.HID_TYPE2.value;
		
		
		var myObject=new Array(); //return values set to this object
		myObject[0]=obj;
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
		
		var qid;
		
		if(bpctype=='P'){
			qid='117';
			
		}else if(bpctype=='C'){
			qid='118';
			myObject_value[0] =	document.Form1.TXT_BCODE.value;
			myObject_type[0]="String";
		}
		
		title_name='Account Mode';
		var url = 'popup.jsp';
		var close_fun='codes_help1_close';			
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
					if(returnedValue == null){codes_help1_close();} 
					if(returnedValue != null){
						globe_obj.focus();
						
					}
				} 
			});
		
		
	}
	
	function codes_help1_close(){
		globe_obj.value = '';
	}
	
	/*	
	function codes_help2(obj1) {
		bpctype="";
		spctype="";
		bpctype=parent.frames[0].document.Form1.HID_TYPE1.value;
		spctype=parent.frames[0].document.Form1.HID_TYPE2.value;
		if (spctype=='P'){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?seller_code="+parent.frames[0].document.Form1.TXT_SCODE.value+"&chksql=settle_out1";
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
		}
		if (spctype=='C'){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?seller_code="+parent.frames[0].document.Form1.TXT_SCODE.value+"&chksql=settle_out2";
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
		}
		vec_pos=0;
		lineno=1;
		m_row="";
		while (vec_pos<m_size) {
			m_issu_code=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
			m_issu_name=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
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
	*/
	
	
	function codes_help2(obj,m_strat){
		globe_obj = obj;
		var aForm;    //  aForm =oForm.elements;
		aForm =  document.getElementById('Form1');
		
		var bpctype=document.Form1.HID_TYPE1.value;
		var spctype=document.Form1.HID_TYPE2.value;
		
		
		var myObject=new Array(); //return values set to this object
		myObject[0]=obj;
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
		
		var qid;
		
		if(bpctype=='P'){
			qid='117';
			
		}else if(bpctype=='C'){
			qid='118';
			myObject_value[0] =document.Form1.TXT_SCODE.value;
			myObject_type[0]="String";
		}
		
		title_name='Account Mode';
		var url = 'popup.jsp';
		var close_fun='codes_help2_close';			
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
					if(returnedValue == null){codes_help2_close();} 
					if(returnedValue != null){
						globe_obj.focus();
						
					}
				} 
			});
		
		
	}
	
	function codes_help2_close(){
		globe_obj.value = '';
	}
	
	
	
	function tranfaceval(){
		document.Form1.TXT_MISS1.value=format_noobject(parseFloat(unformat_noobject(document.Form1.TXT_TOTVAL.value))-parseFloat(unformat_noobject(document.Form1.TXT_FACEVAL1.value)));
		if(document.Form1.SCRIPT_STAT.value=="SL"){//$$##SC
			document.Form1.TXT_MISS1.disabled=true;
		}else{
			document.Form1.TXT_MISS1.disabled=false;
		}
		//------------
	}
	
	function tranfaceval2(){
		document.Form1.TXT_MISS1.value=format_noobject(parseFloat(unformat_noobject(document.Form1.TXT_TOTVAL.value))-parseFloat(unformat_noobject(document.Form1.TXT_FACEVAL1.value)));
		mt_miss="TXT_MISS"+kk;
		VAL_MISS=document.Form1.elements[mt_miss];
		mt_face="TXT_FACEVAL"+kk;
		VAL_FACE=document.Form1.elements[mt_face];
		mt_miss2="TXT_MISS"+jj;
		VAL_MISS2=document.Form1.elements[mt_miss2];
		mt_face2="TXT_FACEVAL"+jj;
		VAL_FACE2=document.Form1.elements[mt_face2];
		VAL_MISS2.value=format_noobject(parseFloat(unformat_noobject(VAL_MISS.value))-parseFloat(unformat_noobject(VAL_FACE2.value)));
		if(document.Form1.SCRIPT_STAT.value=="SL"){//$$##SC
			VAL_MISS2.disabled=true;
		}
		else{
			VAL_MISS2.disabled=false;
		}
		//-----------------------------
		kk=kk+1;
		jj=jj+1;
	}
	
	
	
	
	function formatval(){
		mt_face="TXT_FACEVAL"+mm;
		VAL_FACE=document.Form1.elements[mt_face];
		VAL_FACE.value=format_noobject(VAL_FACE.value);
		mm=mm+1;			
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
	
	function change_base(num6){
		
		mmm_yield=unformat_noobject(document.Form1.TXT_YIELD.value);
		mm_new_yield=(mmm_yield-num6.value);				
		mm_factor=parseFloat(parseFloat((parseFloat(mmm_yield)+parseFloat(100))/parseFloat(100)) -  parseFloat((parseFloat(mm_new_yield)+parseFloat(100))/parseFloat(100)))/ parseFloat((parseFloat(mmm_yield)+parseFloat(100))/parseFloat(100));
		
		if(document.Form1.SEL_BBASE1.value=='FV'){
			mm_fval=document.Form1.HID_FACEVAL.value;
			mm_fval = unformat_noobject(mm_fval);
			mm_fee =((parseFloat(mm_fval))* parseFloat(mm_factor));
			mm_gst = ((parseFloat(mm_fee)/100)* parseFloat(document.Form1.TXT_GST1.value));
			mm_tot = parseFloat(mm_fee) + parseFloat(mm_gst);
			document.Form1.HID_VAL1.value        = mm_gst;
			document.Form1.HID_TOTAMOU1.value    = mm_tot;
			document.Form1.TXT_VAL1.value        = format_noobject(mm_gst);
			document.Form1.TXT_TOTAMOU1.value    = format_noobject(mm_tot);
			document.Form1.TXT_FEEAMO1.value = format_noobject(mm_fee);
			
		}
		else if(document.Form1.SEL_BBASE1.value=='COST'){
			mm_cost=document.Form1.HID_COST.value;
			mm_cost = unformat_noobject(mm_cost);
			mm_fee = ((parseFloat(mm_cost))* parseFloat(mm_factor));
			mm_gst = ((parseFloat(mm_fee)/100)*parseFloat(document.Form1.TXT_GST1.value));
			mm_tot = parseFloat(mm_fee) + parseFloat(mm_gst);
			document.Form1.HID_VAL1.value        = mm_gst;
			document.Form1.HID_TOTAMOU1.value    = mm_tot;
			document.Form1.TXT_VAL1.value    = format_noobject(mm_gst);
			document.Form1.TXT_TOTAMOU1.value    = format_noobject(mm_tot);
			document.Form1.TXT_FEEAMO1.value = format_noobject(mm_fee);
		}
		else if(document.Form1.SEL_BBASE1.value=='SV'){
			mm_sett=document.Form1.HIDD_SETAMO1.value;
			mm_sett = unformat_noobject(mm_sett);				
			mm_fee = ((parseFloat(mm_sett))* parseFloat(mm_factor));
			mm_gst = ((parseFloat(mm_fee)/100)* parseFloat(document.Form1.TXT_GST1.value));
			mm_tot = parseFloat(mm_fee) + parseFloat(mm_gst);
			document.Form1.HID_VAL1.value        = mm_gst;
			document.Form1.HID_TOTAMOU1.value    = mm_tot;
			document.Form1.TXT_VAL1.value    = format_noobject(mm_gst);
			document.Form1.TXT_TOTAMOU1.value    = format_noobject(mm_tot);
			document.Form1.TXT_FEEAMO1.value =format_noobject(mm_fee);
		}
		else if(document.Form1.SEL_BBASE1.value=='UD'){
			mm_fval  =document.Form1.HID_FACEVAL.value;
			mm_fval  = unformat_noobject(mm_fval);
			mm_cost  = document.Form1.HID_COST.value;
			mm_cost  = unformat_noobject(mm_cost);
			mm_sett  =document.Form1.HIDD_SETAMO1.value;
			mm_sett  = unformat_noobject(mm_sett);
			if((mm_fval > mm_cost) && (mm_fval > mm_sett)){
				mm_fee =((parseFloat(mm_fval))* parseFloat(mm_factor));
				mm_gst = ((parseFloat(mm_fee)/100)* parseFloat(document.Form1.TXT_GST1.value));
				mm_tot = parseFloat(mm_fee) + parseFloat(mm_gst);
				
			}
			else if((mm_cost > mm_fval) && (mm_cost > mm_sett)){
				mm_fee = ((parseFloat(mm_cost))* parseFloat(mm_factor));
				mm_gst = ((parseFloat(mm_fee)/100)* parseFloat(document.Form1.TXT_GST1.value));
				mm_tot = parseFloat(mm_fee) + parseFloat(mm_gst);
				
			}
			else if((mm_sett > mm_fval) && (mm_sett > mm_cost)){
				mm_fee = ((parseFloat(mm_sett))* mm_factor);
				mm_gst = ((parseFloat(mm_fee)/100)* parseFloat(document.Form1.TXT_GST1.value));
				mm_tot = parseFloat(mm_fee) + parseFloat(mm_gst);
				
			}
			document.Form1.HID_VAL1.value        = mm_gst;
			document.Form1.HID_TOTAMOU1.value    = mm_tot;
			document.Form1.TXT_VAL1.value    = format_noobject(mm_gst);
			document.Form1.TXT_TOTAMOU1.value    = format_noobject(mm_tot);
			document.Form1.TXT_FEEAMO1.value = format_noobject(mm_fee);
		}
		
	}
	function bprecent1(num6){
		
		change_base(num6);		
		document.Form1.SEL_BBASE1.focus();
		document.Form1.HID_BRAGE1.value=unformat_noobject(num6.value);
		
	}
	
	function change_base2(num6){
		
		mmm_yield=unformat_noobject(document.Form1.TXT_YIELD.value);
		mm_new_yield=(mmm_yield-num6.value);	
		mm_factor=parseFloat(parseFloat((parseFloat(mmm_yield)+parseFloat(100))/parseFloat(100)) -  parseFloat((parseFloat(mm_new_yield)+parseFloat(100))/parseFloat(100)))/ parseFloat((parseFloat(mmm_yield)+parseFloat(100))/parseFloat(100));
		
		
		
		
		
		if(document.Form1.SEL_BBASE2.value=='FV'){
			mm_fval=document.Form1.HID_FACEVAL.value;
			mm_fval = unformat_noobject(mm_fval);
			
			mm_fee =((parseFloat(mm_fval))* parseFloat(mm_factor));
			mm_gst = ((parseFloat(mm_fee)/100)* parseFloat(document.Form1.TXT_GST2.value));
			mm_tot = parseFloat(mm_fee) + parseFloat(mm_gst);
			document.Form1.HID_VAL2.value        = mm_gst;
			document.Form1.HID_TOTAMOU2.value    = mm_tot;
			document.Form1.TXT_VAL2.value        = format_noobject(mm_gst);
			document.Form1.TXT_TOTAMOU2.value    = format_noobject(mm_tot);
			document.Form1.TXT_FEEAMO2.value     = format_noobject(mm_fee);
			
		}
		else if(document.Form1.SEL_BBASE2.value=='COST'){
			mm_cost=document.Form1.HID_COST.value;
			mm_cost = unformat_noobject(mm_cost);
			
			mm_fee = ((parseFloat(mm_cost))* parseFloat(mm_factor));
			mm_gst = ((parseFloat(mm_fee)/100)* parseFloat(document.Form1.TXT_GST2.value));
			mm_tot = parseFloat(mm_fee) + parseFloat(mm_gst);
			document.Form1.HID_VAL2.value        = mm_gst;
			document.Form1.HID_TOTAMOU2.value    = mm_tot;
			document.Form1.TXT_VAL2.value        = format_noobject(mm_gst);
			document.Form1.TXT_TOTAMOU2.value    = format_noobject(mm_tot);
			document.Form1.TXT_FEEAMO2.value     = format_noobject(mm_fee);
		}
		else if(document.Form1.SEL_BBASE2.value=='SV'){
			mm_sett=document.Form1.HIDD_SETAMO1.value;
			mm_sett = unformat_noobject(mm_sett);
			
			mm_fee = ((parseFloat(mm_sett))* parseFloat(mm_factor));
			mm_gst = ((parseFloat(mm_fee)/100)* parseFloat(document.Form1.TXT_GST2.value));	
			mm_tot = parseFloat(mm_fee) + parseFloat(mm_gst);
			document.Form1.HID_VAL2.value        = mm_gst;
			document.Form1.HID_TOTAMOU2.value    = mm_tot;
			document.Form1.TXT_VAL2.value        = format_noobject(mm_gst);
			document.Form1.TXT_TOTAMOU2.value    = format_noobject(mm_tot);
			document.Form1.TXT_FEEAMO2.value     = format_noobject(mm_fee);
		}
		else if(document.Form1.SEL_BBASE2.value=='UD'){
			mm_fval=document.Form1.HID_FACEVAL.value;
			mm_fval = unformat_noobject(mm_fval);
			mm_cost=document.Form1.HID_COST.value;
			mm_cost = unformat_noobject(mm_cost);
			mm_sett=document.Form1.HIDD_SETAMO1.value;
			mm_sett = unformat_noobject(mm_sett);
			if((mm_fval > mm_cost) && (mm_fval > mm_sett)){
				mm_fee =((parseFloat(mm_fval))* parseFloat(mm_factor));
				mm_gst = ((parseFloat(mm_fee)/100)* parseFloat(document.Form1.TXT_GST2.value));
				mm_tot = parseFloat(mm_fee) + parseFloat(mm_gst);
				
			}
			else if((mm_cost > mm_fval) && (mm_cost > mm_sett)){
				mm_fee = ((parseFloat(mm_cost))* parseFloat(mm_factor));
				mm_gst = ((parseFloat(mm_fee)/100)* parseFloat(document.Form1.TXT_GST2.value));
				mm_tot = parseFloat(mm_fee) + parseFloat(mm_gst);
				
			}
			else if((mm_sett > mm_fval) && (mm_sett > mm_cost)){
				mm_fee = ((parseFloat(mm_sett))* parseFloat(mm_factor));
				mm_gst = ((parseFloat(mm_fee)/100)* parseFloat(document.Form1.TXT_GST2.value));
				mm_tot = parseFloat(mm_fee) + parseFloat(mm_gst);
				
			}
			document.Form1.HID_VAL2.value        = mm_gst;
			document.Form1.HID_TOTAMOU2.value    = mm_tot;
			document.Form1.TXT_VAL2.value        = format_noobject(mm_gst);
			document.Form1.TXT_TOTAMOU2.value    = format_noobject(mm_tot);
			document.Form1.TXT_FEEAMO2.value     = format_noobject(mm_fee);
			
		}
	}
	function bprecent2(num7){
		change_base2(num7);
		document.Form1.SEL_BBASE2.focus()
		document.Form1.HID_BRAGE2.value=unformat_noobject(num7.value);
		
	}
	
	
	
	function gst_help() {
		
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?chksql=gst";			
		//top.frames[0].document.applets[0].getdata(m_url);
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		document.Form1.TXT_GST1.value=data_vec[0];
		document.Form1.TXT_GST2.value=data_vec[0];
		
		
	}
	
	
	function brocode(objx,objy,objz){
		if (objx.value=="") {
			if (confirm('Please enter a Code')) {
			}
			else{
				return false;
			}
			
			objx.value="";
			objx.focus();
		}
		else {
			m_buycode=objx.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+m_buycode.toUpperCase()+"&chksql=chkbcode";
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
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
	
	/*
	function bro_help(obj1) {
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?chksql=bcode_lookup";
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
		m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color: white; font: 9pt arial;}">'+
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
	*/
	
	var glb_help_obj;
	
	function bro_help(m_strat,obj1){
		var aForm;    //  aForm =oForm.elements;
		aForm =  document.getElementById('Form1');
		glb_help_obj = obj1;
		
		var myObject=new Array(); //return values set to this object
		myObject[0]=obj1;
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
		
		var qid='119';
		
		title_name='Buyer Code';
		var url = 'popup.jsp';
		var close_fun='bro_help_close';			
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
					if(returnedValue == null){bro_help_close();} 
					
				} 
			});
		
		
	}
	
	function bro_help_close(){
		glb_help_obj.value = '';
	}
	
	
	function newpart22(){
		hid_val="";
		mt_payamt="TXT_MISS"+ii;
		alert(ii);
		var TXT_HID=document.Form1.elements[mt_payamt];
		hid_val=unformat_noobject(TXT_HID.value);
		if (hid_val>0){
			ii=ii+1;
			m_row="";
			m_writedata ='<TABLE WIDTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0" STYLE="{color: black; font: bold 9pt arial;}">'+
				'<TR>'+
				'<TD WIDTH="39%"></TD>'+
				'<TD WIDTH="37%"></TD>'+
				'<TD WIDTH="22%"></TD>'+
				'</TR>'+
				'<TR>'+
				'<TR>'+
				'<TD id="security'+ii+'"><INPUT TYPE="Text" NAME="TXT_SENOIDEN'+ii+'" ALIGN="LEFT" SIZE=19 MAXLENGTH=20 ></TD>'+
				'<TD><INPUT TYPE="Text" NAME="TXT_FACEVAL'+ii+'"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=19 MAXLENGTH=10 ONBLUR="formatval();tranfaceval2()"></TD>'+
				'<TD><INPUT TYPE="Text" NAME="TXT_MISS'+ii+'"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=19 MAXLENGTH=10 ONBLUR="newpart22()"></TD>'+
				'</TR>'+
				'<TR>'+		
				'</TABLE>'; 
			document.getElementById('notbal').innerHTML=notbal.innerHTML+m_writedata;	
			document.Form1.HID_SECDET.value=ii;
			mt_col="TXT_SENOIDEN"+ii;
			TXT_COL=document.Form1.elements[mt_col];
			TXT_COL.focus();
		}		
		else{
			document.Form1.SEL_SETTLE1.focus();
		}	
	}
	
	
	
	
	
	function dyoname1(){
		aa=aa+1;
		m_row="";
		m_writedata ='<TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0" >'+
			'<TD WIDTH="20%">Settlement Mode '+aa+'</TD>'+
			'<TD WIDTH="30%"><SELECT CLASS="txt_input6" NAME="SEL_SETTLE'+aa+'" >'+
			'<OPTION VALUE="CB_CHEQUE" >Central Bank Cheque</option>'+  
			'<OPTION VALUE="CB_TRANF" >Central Bank Transfer</option>'+  
			'<OPTION VALUE="BANK_TRANF" >Bank Transfer</option>'+  
			'<OPTION VALUE="CHEQUE">Cheque</option>'+  
			'<OPTION VALUE="CASH" >Cash</option>'+  
			'<OPTION VALUE="CURR_ACC" SELECTED>Margin Trading Account</option>'+
			'</SELECT>'+
			'</TD>'+		
			'<TD WIDTH="20%">Settlement Amount</TD>'+
			'<TD WIDTH="30%"><INPUT CLASS="txt_input6"   TYPE="Text" NAME="TXT_SETAMO'+aa+'"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=28 ONBLUR="calculate_tot()"></TD>'+
			'<TR>'+
			'<TD></TD>'+
			'<TD></TD>'+
			'</TABLE>';
		document.getElementById('othername1').innerHTML=othername1.innerHTML+m_writedata;	
		document.Form1.HID_NOMODE.value=aa;
	}
	
	
	
	
	
	
	function dyoname2(){
		bb=bb+1;
		m_row="";
		m_writedata ='<TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0" >'+
			'<TR>'+
			'<TD WIDTH="20%">Buyer Account Mode '+bb+'</TD>'+
			'<TD WIDTH="30%"><INPUT TYPE="Text" NAME="TXT_BACC'+bb+'" ALIGN="LEFT" SIZE=22 MAXLENGTH=10 >'+
			'<INPUT TYPE="button" VALUE="Help" NAME="BUT_BACC2"  ONCLICK="codes_help1(document.Form1.TXT_BACC'+bb+',0)"></TD>'+
			'<TD WIDTH="20%">Seller Account Mode '+bb+'</TD>'+
			'<TD WIDTH="30%"><INPUT TYPE="Text" NAME="TXT_SACC'+bb+'" ALIGN="LEFT" SIZE=22 MAXLENGTH=10 >'+
			'<INPUT TYPE="button" VALUE="Help" NAME="BUT_SACC2"  ONCLICK="codes_help2(document.Form1.TXT_SACC'+bb+',0)"></TD>'+
			'<TR>'+
			'</TABLE>';
		document.getElementById('othername2').innerHTML= document.getElementById('othername2').innerHTML+m_writedata;	
	}
	
	function bprecent1_new(){
		if(document.Form1.HID_VALDATE.value=="UD"){
			mn_effvaldate=document.Form1.TXT_DATE.value+"-"+document.Form1.TXT_MONTH.value+"-"+document.Form1.TXT_YEAR.value;
		}
		else{
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_valuedate="+document.Form1.HID_VALDATETYPE.value+"&chksql=cal_valdate";
			//top.frames[0].document.applets[0].getdata(m_url);
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
			mn_effvaldate=data_vec[0];
		}
		mn_maturity =document.Form1.HID_MATURITY_DATE.value;
		mn_brokerage=unformat_noobject(document.Form1.TXT_BRAGE1.value);
		
		
		
		
		if(document.Form1.SEL_BBASE1.value=='FV'){
			mn_faceval=unformat_noobject(document.Form1.HID_FACEVAL.value);
		}
		else if(document.Form1.SEL_BBASE1.value=='COST'){
			mn_faceval=unformat_noobject(document.Form1.HID_COST.value);
		}
		else if(document.Form1.SEL_BBASE1.value=='SV'){
			mn_faceval=unformat_noobject(document.Form1.HIDD_SETAMO1.value);
		}
		else if	(document.Form1.SEL_BBASE1.value=='UD'){
			mm_fval  =document.Form1.HID_FACEVAL.value;
			mm_fval  = unformat_noobject(mm_fval);
			mm_cost  = document.Form1.HID_COST.value;
			mm_cost  = unformat_noobject(mm_cost);
			mm_sett  =document.Form1.HIDD_SETAMO1.value;
			mm_sett  = unformat_noobject(mm_sett);
			if((mm_fval > mm_cost) && (mm_fval > mm_sett)){
				
				mn_faceval =mm_fval;
				
			}
			else if((mm_cost > mm_fval) && (mm_cost > mm_sett)){
				mn_faceval =mm_cost;			
				
				
			}
			else if((mm_sett > mm_fval) && (mm_sett > mm_cost)){
				mn_faceval =mm_sett;			
				
			}
		}			
		
		
		
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?mn_effvaldate="+mn_effvaldate+"&mn_faceval="+mn_faceval+"&mn_maturity="+mn_maturity+"&mn_brokerage="+mn_brokerage+"&chksql=get_feeamt";
		//top.frames[0].document.applets[0].getdata(m_url);	
		load_interface(m_url, 'XML',false);
		m_size=data_vec.length;
		if(m_size>0){
			mm_fee=data_vec[0];
			mm_gst = ((parseFloat(mm_fee)/100)* parseFloat(document.Form1.TXT_GST1.value));
			mm_tot = parseFloat(mm_fee) + parseFloat(mm_gst);
			document.Form1.TXT_FEEAMO1.value=format_noobject(mm_fee);
			document.Form1.HID_VAL1.value        = mm_gst;
			document.Form1.HID_TOTAMOU1.value    = mm_tot;
			document.Form1.TXT_VAL1.value        = format_noobject(mm_gst);
			document.Form1.TXT_TOTAMOU1.value    = format_noobject(mm_tot);
		}	
	}
	
	
	function bprecent2_new(){
		if(document.Form1.HID_VALDATE.value=="UD"){
			mn_effvaldate=document.Form1.TXT_DATE.value+"-"+document.Form1.TXT_MONTH.value+"-"+document.Form1.TXT_YEAR.value;
		}
		else{
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_valuedate="+document.Form1.HID_VALDATETYPE.value+"&chksql=cal_valdate";
			//top.frames[0].document.applets[0].getdata(m_url);
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
			mn_effvaldate=data_vec[0];
		}
		mn_maturity =document.Form1.HID_MATURITY_DATE.value;
		mn_brokerage=unformat_noobject(document.Form1.TXT_BRAGE2.value);		
		
		
		
		if(document.Form1.SEL_BBASE2.value=='FV'){
			mn_faceval=unformat_noobject(document.Form1.HID_FACEVAL.value);
		}
		else if(document.Form1.SEL_BBASE2.value=='COST'){
			mn_faceval=unformat_noobject(document.Form1.HID_COST.value);
		}
		else if(document.Form1.SEL_BBASE2.value=='SV'){
			mn_faceval=unformat_noobject(document.Form1.HIDD_SETAMO1.value);
		}
		else if	(document.Form1.SEL_BBASE2.value=='UD'){
			mm_fval  =document.Form1.HID_FACEVAL.value;
			mm_fval  = unformat_noobject(mm_fval);
			mm_cost  = document.Form1.HID_COST.value;
			mm_cost  = unformat_noobject(mm_cost);
			mm_sett  =document.Form1.HIDD_SETAMO1.value;
			mm_sett  = unformat_noobject(mm_sett);
			if((mm_fval > mm_cost) && (mm_fval > mm_sett)){
				
				mn_faceval =mm_fval;
				
			}
			else if((mm_cost > mm_fval) && (mm_cost > mm_sett)){
				mn_faceval =mm_cost;			
				
				
			}
			else if((mm_sett > mm_fval) && (mm_sett > mm_cost)){
				mn_faceval =mm_sett;			
				
			}
		}			
		
		
		
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?mn_effvaldate="+mn_effvaldate+"&mn_faceval="+mn_faceval+"&mn_maturity="+mn_maturity+"&mn_brokerage="+mn_brokerage+"&chksql=get_feeamt";
		//top.frames[0].document.applets[0].getdata(m_url);		
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;
		//alert(top.frames[0].document.applets[0].outvec_value);
		if(m_size>0){
			mm_fee=data_vec[0];
			mm_gst = ((parseFloat(mm_fee)/100)* parseFloat(document.Form1.TXT_GST1.value));
			mm_tot = parseFloat(mm_fee) + parseFloat(mm_gst);
			document.Form1.TXT_FEEAMO2.value=format_noobject(mm_fee);
			document.Form1.HID_VAL2.value        = mm_gst;
			document.Form1.HID_TOTAMOU2.value    = mm_tot;
			document.Form1.TXT_VAL2.value        = format_noobject(mm_gst);
			document.Form1.TXT_TOTAMOU2.value    = format_noobject(mm_tot);
		}	
	}
	
	
	
	
	
	
	
	
	function nextline(){
		aa=1;
		bb=1;
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
				m_writedata ='<TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0" >'+
					'<TR><TD WIDTH="20%"></TD><TD WIDTH="30%"></TD><TD WIDTH="20%">Total Amount</TD>'+
					'<TD WIDTH="30%"><INPUT TYPE="Text" NAME="TXT_TOAMO" class=\"txt_input6\"	STYLE="text-align:right;" SIZE=28 MAXLENGTH=10 ></TD>'+
					'</TR>'+
					'</TABLE>';
				document.getElementById('total').innerHTML=m_writedata;
				document.Form1.TXT_SETAMO1.value="";
				document.Form1.TXT_TOAMO.value=document.Form1.TXT_SETVAL.value;
			}
	}
	
	
	
	function load_sett_details(){ 
		if((document.Form1.TXT_BCODE.value!="") &&(document.Form1.TXT_BCODE.value!=" ")){
			m_port1=document.Form1.TXT_BCODE.value;
			m_port2=document.Form1.TXT_SCODE.value;
			
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?chksql=chk_ports&port1="+m_port1+"&port2="+m_port2;		
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			load_interface(m_url,'XML',false);
			
			m_string="";
			if (data_vec[0]=="P" && data_vec[1]=="P" ){ 
				m_string=		"<TABLE WIDTH=\"100%\"BORDER=\"0\" CELLPADDING=\"1\" CELLSPACING=\"0\" > "+
					"<TR><TD><BR></TD></TR> "+
					"<TR><TD colspan='4'><B><U>Settlement Information</B></TD></TR>"+
					"<TR> 	"+
					"<TD WIDTH=\"20%\"></TD> "+
					"<TD WIDTH=\"30%\"></TD> "+
					"<TD WIDTH=\"20%\"></TD> "+
					"<TD WIDTH=\"30%\"></TD> "+
					"</TR> "+
					"<TR><TD><BR></TD></TR> "+
					"<TR> "+
					"<TD>Number of Modes</TD> "+
					"<TD><SELECT NAME=\"SEL_MODES\" class=\"txt_input6\"  ONCHANGE=\"nextline()\"> "+
					"<OPTION VALUE=\"1\" SELECTED>1</option>   "+
					"</SELECT> "+
					"<TD><INPUT TYPE=\"Text\" NAME=\"HID_NOMODE\" style='display:none' VALUE=1 ></TD> "+
					"</TD>	 "+
					"<TD></TD> "+
					"<TD></TD> "+
					"</TR> "+
					"<TR> "+
					"<TD>Settlement Mode 1</TD> "+
					"<TD><SELECT NAME=\"SEL_SETTLE1\" class=\"txt_input6\"  > "+
					"<OPTION VALUE=\"CHEQUE\" SELECTED>Cheque</option>"+
					//"<OPTION VALUE=\"CURR_ACC\" SELECTED>Margin Trading Account</option>   "+
					"</SELECT> "+
					"</TD>	 "+
					"<TD>Settlement Amount</TD> "+
					"<TD><INPUT TYPE=\"Text\" NAME=\"TXT_SETAMO1\" class=\"txt_input6\" 	STYLE=\"text-align:right;\" ALIGN=\"LEFT\" SIZE=28 ONBLUR=\"calculate_tot()\"></TD> "+
					"<TD><INPUT TYPE=\"Text\" NAME=\"HIDD_SETAMO1\" style='display:none'></TD> "+
					"</TR> "+
					"</TABLE> ";
				document.getElementById('sett_details').innerHTML=m_string;
				nextline();
				document.Form1.disp=false;				
			}
			else{
				
				m_string=	"<TABLE WIDTH=\"100%\"BORDER=\"0\" CELLPADDING=\"1\" CELLSPACING=\"0\" > "+
					"<TR><TD><BR></TD></TR> "+
					"<TR><TD><B><U>Settlement Information</B></TD></TR> "+
					"<TR>	 "+
					"<TD WIDTH=\"20%\"></TD> "+
					"<TD WIDTH=\"30%\"></TD> "+
					"<TD WIDTH=\"20%\"></TD> "+
					"<TD WIDTH=\"30%\"></TD> "+
					"</TR> "+
					"<TR><TD><BR></TD></TR> "+
					"<TR> "+
					"<TD>Number of Modes</TD> "+
					"<TD><SELECT NAME=\"SEL_MODES\"  ONCHANGE=\"nextline()\"> "+
					"<OPTION VALUE=\"1\" SELECTED>1</option>   "+
					"<OPTION VALUE=\"2\" >2</option>   "+
					"<OPTION VALUE=\"3\" >3</option>   "+
					"<OPTION VALUE=\"4\" >4</option>   "+
					"<OPTION VALUE=\"5\" >5</option>   "+
					"<OPTION VALUE=\"6\" >6</option>   "+
					"<OPTION VALUE=\"7\" >7</option>   "+
					"<OPTION VALUE=\"8\" >8</option>   "+
					"<OPTION VALUE=\"9\" >9</option>   "+
					"<OPTION VALUE=\"10\">10</option> "+
					"</SELECT> "+
					"<TD><INPUT TYPE=\"Text\" NAME=\"HID_NOMODE\" style='display:none' VALUE=1 ></TD> "+
					"</TD>	 "+
					"<TD></TD> "+
					"<TD></TD> "+
					"</TR> "+
					"<TR> "+
					"<TD>Settlement Mode 1</TD> "+
					"<TD><SELECT NAME=\"SEL_SETTLE1\" class=\"txt_input6\"  > "+
					"<OPTION VALUE=\"CB_CHEQUE\" >Central Bank Cheque</option>   "+
					"<OPTION VALUE=\"CB_TRANF\" >Central Bank Transfer</option>   "+
					"<OPTION VALUE=\"BANK_TRANF\" >Bank Transfer</option>   "+
					"<OPTION VALUE=\"CHEQUE\">Cheque</option>   "+
					"<OPTION VALUE=\"CASH\" >Cash</option>   "+
					"<OPTION VALUE=\"CURR_ACC\"  SELECTED>Margin Trading Account</option> "+
					"</SELECT> "+
					"</TD>	 "+
					"<TD>Settlement Amount</TD> "+
					"<TD><INPUT TYPE=\"Text\" NAME=\"TXT_SETAMO1\" class=\"txt_input6\" 	STYLE=\"text-align:right;\" ALIGN=\"LEFT\" SIZE=28 ONBLUR=\"calculate_tot()\"></TD> "+
					"<TD><INPUT TYPE=\"Text\" NAME=\"HIDD_SETAMO1\" style='display:none'></TD> "+
					"</TR> "+
					"</TABLE> ";
				document.getElementById('sett_details').innerHTML=m_string;
			}
			if(document.Form1.SCRIPT_STAT.value=="SL"){//$$##SC											
				make_disable(m_port2);
			}
			
		}
		
		
	}
	
	
	function make_disable(mm_port2){
		
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?chksql=chk_ports&port1="+mm_port2+"&port2="+mm_port2;		
		//top.frames[0].document.applets[0].getdata(m_url);
		//m_size=top.frames[0].document.applets[0].outvec_value.size();
		load_interface(m_url,'XML',false);
		if (data_vec[0]=="P"){ 
			document.Form1.TXT_SENOIDEN1.disabled=true;
			document.Form1.TXT_FACEVAL1.disabled=true;
			document.Form1.TXT_MISS1.disabled=true;
		}
		else{
			document.Form1.TXT_SENOIDEN1.disabled=false;
			document.Form1.TXT_FACEVAL1.disabled=false;
			document.Form1.TXT_MISS1.disabled=false;
		}
	}
</SCRIPT>

<!--
<BODY onload="gst_help();load_sett_details();">
<FORM  NAME="Form1" METHOD="POST" >			
<INPUT TYPE="Hidden" NAME="SCR_NAME"	VALUE="BROKERAGE" >
-->

<INPUT TYPE="Text" NAME="HID_REF_NO" VALUE="" style='display:none'>
<INPUT TYPE="Text" NAME="HID_SECDET" VALUE=1 style='display:none'>
<INPUT TYPE="Text" NAME="HID_FACEVAL" VALUE="UD" style='display:none'>
<INPUT TYPE="Text" NAME="HID_COST" VALUE="UD" style='display:none'>	
<INPUT TYPE="Text" NAME="HID_SETVAL" VALUE="UD" style='display:none'>
<INPUT TYPE="Text" NAME="HID_SELLER"  style='display:none'>
<INPUT TYPE="Text" NAME="HID_BUYER" style='display:none'>
<INPUT TYPE="Text" NAME="HID_PART_ALLO" VALUE=0 style='display:none'><!--$$##SC-->
<INPUT TYPE="Text" NAME="HID_PART_ALLO_SER" value="NO"  style='display:none'><!--$$##SC-->
<INPUT TYPE="Text" NAME="HID_TOT_ALLO" VALUE=0 style='display:none'><!--$$##SC-->
<!--$$##SC-->




<!--
<TABLE WidTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0" STYLE="{color: black; font: bold 9pt arial;}">							
<TD WidTH="1%">
<TD WidTH="99%">
-->

<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
	<TR>
		<TD WIDTH="20%"><B><U>Security Determination</B></U></TD>
		<TD WIDTH="30%"></TD>
		<TD WIDTH="20%"></TD>
		<TD WIDTH="30%"></TD>
	</TR>
	<TR><BR></TR>
	<TR>
		<TD>Issuer</TD>
		<TD><INPUT TYPE="Text" NAME="TXT_ISSURE" class="txt_input6"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10 ></TD>
		<TD>Instrument Type</TD>
		<TD><INPUT TYPE="Text" NAME="TXT_INSTYPE1"  class="txt_input6"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10 ></TD>
	</TR>
	<TR>
		<TD>Security Code</TD>
		<TD><INPUT TYPE="Text" NAME="TXT_SECCODE" class="txt_input6"	ALIGN="LEFT" SIZE=28 MAXLENGTH=10 ></TD>
		<TD>Total Face Value</TD>
		<TD><INPUT TYPE="Text" NAME="TXT_TOTVAL" class="txt_input6"	STYLE="text-align:right;" ALIGN="LEFT" SIZE=28 MAXLENGTH=10 ></TD>
	</TR>
</TABLE>

<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
	<TR></TR>
	<TR>
		<TD  ID='scrname'   WIDTH="40%"><B>Serial Number</B></TD>
		<TD WIDTH="38%"><B>Face Value</B></TD>
		<TD WIDTH="22%"><B>Mismatch</B></TD>
	</TR>
	<TR>
		<TR>
			<TD><INPUT TYPE="Text" class="txt_input6"  NAME="TXT_SENOIDEN1"	ALIGN="LEFT" SIZE='19' MAXLENGTH='20' ></TD>
			<TD><INPUT TYPE="Text" class="txt_input6"  NAME="TXT_FACEVAL1" STYLE="text-align:right;"	ALIGN="LEFT" SIZE='19' MAXLENGTH='10' ONBLUR="formatval();tranfaceval()"></TD>
			<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_MISS1" STYLE="text-align:right;"	ALIGN="LEFT" SIZE='19' MAXLENGTH='10' ONBLUR="newpart22()"></TD>
		</TR>
		<TR>		
		</TABLE>
		<DIV ID='notbal'></DIV>
		
		
		
		
		<HR WIDTH="*%">	
		
		
		
		<DIV ID='sett_details'></DIV>
		
		
		
		<DIV ID='othername1'></DIV>
		<DIV ID='total'></DIV>
		
		<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >	
			<TR>
				<TD WIDTH="20%">Buyer Account Mode 1</TD>
				<TD WIDTH="30%"><INPUT TYPE="Text" class="txt_input6" NAME="TXT_BACC1" ALIGN="LEFT" SIZE='22' MAXLENGTH='10' >
					<INPUT TYPE="button" class='but_input' VALUE="Help" NAME="BUT_BACC1" ONCLICK="codes_help1(document.Form1.TXT_BACC1,0)"></TD>
				<TD WIDTH="20%">Seller Account Mode 1</TD></TD>
			<TD WIDTH="30%"><INPUT TYPE="Text" class="txt_input6" NAME="TXT_SACC1" ALIGN="LEFT" SIZE='22' MAXLENGTH='10' >
				<INPUT TYPE="button" class='but_input' VALUE="Help" NAME="BUT_SACC2"  ONCLICK="codes_help2(document.Form1.TXT_SACC1,0)"></TD>
		</TR>
	</TABLE>
	<DIV ID=othername2></DIV>
	
	
	<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >	
		<TR>		
			<TD WIDTH="20%">Comments</TD>
			<TD WIDTH="30%"><TEXTAREA NAME="SEL_COMM1" class="txt_input6" COLS = "18" ROWS = "2"></TEXTAREA>
			</TD>		    
			<TD WIDTH="20%">Comments</TD>
			<TD WIDTH="30%"><TEXTAREA NAME="SEL_COMM2"  class="txt_input6" COLS = "18" ROWS = "2"></TEXTAREA>
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
		<TR><BR></TR>
		<TR>
			<TD>Broker Code</TD>
			<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_BCODE1" ALIGN="LEFT" SIZE=22  MAXLENGTH=10 ONBLUR="brocode(document.Form1.TXT_BCODE1,document.Form1.TXT_BNAME1,document.Form1.TXT_BRAGE1)">
				<INPUT TYPE="button" VALUE="Help" class='but_input' NAME="BUT_BCODE1"  ONCLICK="bro_help(0,document.Form1.TXT_BCODE1)"></TD>
			<TD>Broker Code</TD>
			<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_BCODE2" ALIGN="LEFT" SIZE=22  MAXLENGTH=10 ONBLUR="brocode(document.Form1.TXT_BCODE2,document.Form1.TXT_BNAME2,document.Form1.TXT_BRAGE2)">
				<INPUT TYPE="button" VALUE="Help" class='but_input' NAME="BUT_BCODE2"  ONCLICK="bro_help(0,document.Form1.TXT_BCODE2)"></TD>
		</TR>
		<TR>
			<TD>Broker Name</TD>
			<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_BNAME1"	ALIGN="LEFT" SIZE=28   MAXLENGTH=10 ></TD>
			<TD>Broker Name</TD>
			<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_BNAME2"	ALIGN="LEFT" SIZE=28  MAXLENGTH=10 ></TD>
		</TR>
		<TR>
			<TD>Brokerage %</TD>
			<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_BRAGE1"	ALIGN="LEFT" SIZE=28  MAXLENGTH=10 ONCHANGE="bprecent1_new(document.Form1.TXT_BRAGE1);"></TD><!--bprecent1-->
			<INPUT TYPE="Text" NAME="HID_BRAGE1" style='display:none'>
			<TD>Brokerage %</TD>
			<TD><INPUT TYPE="Text" class="txt_input6" NAME="TXT_BRAGE2"	ALIGN="LEFT" SIZE=28  MAXLENGTH=10 ONCHANGE="bprecent2_new(document.Form1.TXT_BRAGE2);" ></TD><!--bprecent2-->
			<INPUT TYPE="Text" NAME="HID_BRAGE2" style='display:none'>
		</TR>
		<TR>
			<TD>Brokerage Base</TD> <!--document.Form1.SEL_FEETYPE1.focus()-->
			<TD WIDTH="30%"><SELECT NAME="SEL_BBASE1" class="txt_input6"   onchange="bprecent1_new(document.Form1.TXT_BRAGE1);"><!--change_base(document.Form1.TXT_BRAGE1)-->
					<OPTION VALUE="FV" SELECTED>Face Value</option>  
					<OPTION VALUE="COST" >Cost</option>  
					<OPTION VALUE="SV" >Settlement Value</option>  
					<OPTION VALUE="UD">Higher</option>
				</SELECT></TD>
		</TD><TD>Brokerage Base</TD>
		<TD WIDTH="30%"><SELECT NAME="SEL_BBASE2" class="txt_input6"  onchange="bprecent2_new(document.Form1.TXT_BRAGE2);"><!--change_base2(document.Form1.TXT_BRAGE2)-->
				<OPTION VALUE="FV" SELECTED>Face Value</option>  
				<OPTION VALUE="COST" >Cost</option>  
				<OPTION VALUE="SV" >Settlement Value</option>  
				<OPTION VALUE="UD">Higher</option>
			</SELECT></TD>
	</TR>
	<TR>
		<TD>Fee Type</TD><!--ONBLUR="document.Form1.TXT_FEEAMO1.focus()"-->
		<TD WIDTH="30%"><SELECT NAME="SEL_FEETYPE1"  class="txt_input6"  >
				<OPTION VALUE="PR" SELECTED>Pro rated</option>  
				<OPTION VALUE="FL">Flat</option>
			</SELECT>
		</TD>	
		<TD>Fee Type</TD>
		<TD WIDTH="30%"><SELECT NAME="SEL_FEETYPE2" class="txt_input6"  ONBLUR="document.Form1.TXT_FEEAMO2.focus()" >
				<OPTION VALUE="PR" SELECTED>Pro rated</option>  
				<OPTION VALUE="FL">Flat</option>
			</SELECT>
		</TD>	
	</TR>
	<TR>
		<TD>Fee Amount</TD><!---->
		<TD><INPUT TYPE="Text" NAME="TXT_FEEAMO1" class="txt_input6"	ALIGN="LEFT" SIZE=28  MAXLENGTH=10  ONCHANGE="feeamo1(document.Form1.TXT_FEEAMO1)"></TD>
		<INPUT TYPE="Text" NAME="HID_FEEAMO1" style='display:none'>
		<TD>Fee Amount</TD>
		<TD><INPUT TYPE="Text" NAME="TXT_FEEAMO2" class="txt_input6"	ALIGN="LEFT" SIZE=28  MAXLENGTH=10 ONCHANGE="feeamo2(document.Form1.TXT_FEEAMO2)"></TD>
		<INPUT TYPE="Text" NAME="HID_FEEAMO2" style='display:none'>
		<INPUT TYPE="Text" NAME="HIDD_TXT_CURR" style='display:none'>
		
	</TR>
</TABLE>

<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
	<TR>
		<TD WIDTH="10%">VAT</TD>
		<TD WIDTH="10%"><INPUT TYPE="Text" NAME="TXT_GST1" class="txt_input6" style='width:60px'	ALIGN="LEFT" SIZE=7  MAXLENGTH=10 onblur="bprecent1(document.Form1.TXT_BRAGE1);form_gst(document.Form1.TXT_GST1)" ></TD>
		<TD WIDTH="30%"><INPUT TYPE="Text" NAME="HID_VAL1" style='display:none'><INPUT TYPE="Text" NAME="TXT_VAL1" class="txt_input6"	ALIGN="LEFT" SIZE=28  MAXLENGTH=10 ONCHANGE="gsstamo1(document.Form1.TXT_VAL1)"></TD>
		
		<TD WIDTH="10%">VAT</TD>
		<TD WIDTH="10%"><INPUT TYPE="Text" NAME="TXT_GST2" class="txt_input6" style='width:60px'	ALIGN="LEFT" SIZE=7  MAXLENGTH=10  onblur="bprecent2(document.Form1.TXT_BRAGE2);form_gst2(document.Form1.TXT_GST2)"></TD>
		<TD WIDTH="30%"><INPUT TYPE="Text" NAME="HID_VAL2" style='display:none'><INPUT TYPE="Text" NAME="TXT_VAL2" class="txt_input6"	ALIGN="LEFT" SIZE=28  MAXLENGTH=10 ONCHANGE="gsstamo2(document.Form1.TXT_VAL2)"></TD>
		
	</TR>
</TABLE>


<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
	<TR>
		<TD WIDTH="20%">Total Amount Due</TD>
		<TD WIDTH="30%"><INPUT TYPE="Text" NAME="TXT_TOTAMOU1" class="txt_input6"	ALIGN="LEFT"  SIZE=28 MAXLENGTH=10 ONCHANGE="totamo1(document.Form1.TXT_TOTAMOU1)"></TD>
		<INPUT TYPE="Text" NAME="HID_TOTAMOU1" style='display:none'>
		<TD WIDTH="20%">Total Amount Due</TD>
		<TD WIDTH="30%"><INPUT TYPE="Text" NAME="TXT_TOTAMOU2" class="txt_input6"	ALIGN="LEFT"  SIZE=28 MAXLENGTH=10 ONCHANGE="totamo2(document.Form1.TXT_TOTAMOU2)"></TD>
		<INPUT TYPE="Text" NAME="HID_TOTAMOU2" style='display:none'>
	</TR>
</TABLE>
<HR WIDTH="*%">
<!--
</TD>
</TD>
</TABLE>


</FORM>
</BODY>
<DIV>
<SCRIPT language1.2="JavaScript" src="validate.js"></SCRIPT>
</DIV>
</HTML>
-->
