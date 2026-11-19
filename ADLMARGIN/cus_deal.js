var m_arrdata = new Array();
var passing_vals = new Array();

var repo_pass_vals = new Array();
var select_info;


m_total="0.00";
lineno=0;
du_lineno=0;
i=1;
serialno=6;
n=2;
d=2;





//----------------------------------- Repo Inventory ---------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


function display_more2(m_portcode,m_invtype,m_seccode,m_serialno) {
alert("you are calling this function");
	m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'bvalwizard7?invtype='+m_invtype+'&seccode='+m_seccode+'&serialno='+m_serialno+'&portcode='+m_portcode+'&chksql=moredata_repo';
  popupwin = window.open(m_url,'displayWindow22','left=0,top=0,width=375,height=470,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
	popupwin.focus();
}



//JJJJJJJJJJJJJJ
function Sec_detailsttt(clcode,cins,cday,cmon,cyear){
alert("HI");
  //parent.frames[1].location='mbfsl_broker_settlement_v2.html';
	location='dn_custodial_deals_frame.html';
	m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'bvalCusDeal?&chksql=cusdeal_details&port_code='+clcode.vlaue+'&inst_code='+cins.value+'&eff_day='+cday.value+'&eff_mon='+cmon.value+'&eff_year='+cyear.value;
	m_url_main='dn_cusdeal_sdetails_frame.html';
	alert("H2");
	popupwin1 = window.open(m_url,'displayWindow1','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
//	popupwin1 = window.open(m_url,'displayWindow1','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
  alert("H3");
  popupwin1.focus();

//	popupwin1.location.href=m_url;
	//popupwin1.parent.frames[0].location.href=m_url;
 
}

function Sec_details(clcode,cins,cday,cmon,cyear){
	m_url_select='dn_custodial_deals_frame.html';
	m_cus="CUST1";
	m_url_main='dn_cusdeal_sdetails_frame.html'
	m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'bvalCusDeal?&chksql=cusdeal_details&port_code='+clcode+'&inst_code='+cins+'&eff_day='+cday.value+'&eff_mon='+cmon.value+'&eff_year='+cyear.value;
  popupwin1 = window.open(m_url_main,'displayWindow1','left=0,top=0,width=600,height=400,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
  setTimeout("abs()",800);
	//popupwin1.focus();
	//popupwin1.parent.frames[0].location.href=m_url;
}

function abs(){
popupwin1.parent.frames[0].location.href=m_url;
popupwin1.focus();
}

function display_select_repo(){
 	m_url_select='dn_repo_inventory_select.html';
	popupwin2 = window.open(m_url_select,'displayWindow2','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
  popupwin2.focus();
	}


function display_reposelect(seccode,serialno,faceval,pos,noforval,invtype) {
	alert("this is onclick");
	m_row=1;
 	inputname="SEL"+pos;
	h_payamtobj=document.Form1.elements[inputname];
  if (h_payamtobj.checked==true) {
			m_total=format_noobject(parseFloat(unformat_noobject(m_total))+parseFloat(unformat_noobject(faceval)));
			parent.window.opener.parent.frames[1].document.Form2.select_total.value=m_total;
			unforvalue=parent.frames[0].unformat_noobject(m_total);
			m_writedata='<TR><TD WIDTH="15%" STYLE="{text-align:center;}">'+invtype+'</TD><TD WIDTH="25%" STYLE="{cursor: hand; font: 9pt arial; text-align:center;}">'+seccode+'</TD><TD WIDTH="25%" STYLE="{cursor: hand; font: 9pt arial; text-align:center;}">'+serialno+'</TD><TD WIDTH="25%" STYLE="{text-align:right;}">'+faceval+'</TD></TR>';
  		m_url="cusdeal_selected.html"
		
			m_arrdata[pos]=m_writedata;
			lineno=lineno+1;
			repo_pass_vals[i]=(faceval);
			repo_pass_vals[i+1]=(seccode);
			repo_pass_vals[i+2]=(serialno);	
			repo_pass_vals[i+3]=(invtype);	
		//	repo_pass_vals[i+4]=(deal_no);
			m_table.innerHTML='<TABLE BORDER="0" BGCOLOR="darkblue" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
			'<TR><TD WIDTH="85%"><B STYLE="{color: white; font: bold 9pt arial;}">Inventory Selection</B></TD><TD  WIDTH="15%"><INPUT TYPE="button" VALUE="Proceed" NAME="BUT_BCODE" ONCLICK="repo_transfervals('+unforvalue+',('+lineno+'))" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD></TR><SCRIPT language1.2="JavaScript" src="outrights_inv_details.js"></SCRIPT></TABLE>'+
	  	'<TABLE BORDER="1" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}"><TR BGCOLOR="silver" ><TD WIDTH="15%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Type</TD><TD WIDTH="30%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Security</TD><TD WIDTH="25%" STYLE="{text-align:center;}" ><B><FONT COLOR="black">Serial Number</TD><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Face Value</TD></FONT></FONT></B></TR>'+
			m_arrdata.join(" ")+'<TR><TD></TD><TD></TD><TD BGCOLOR="silver" STYLE="{text-align:center; color: black; font: bold 9pt arial;}">Total</TD><TD STYLE="{text-align:right;}">'+m_total+'</TD></TR></TABLE>';
		  
		  i=i+5;
			//du_lineno=lineno;
}
	else {
			m_total=format_noobject(parseFloat(unformat_noobject(m_total))-parseFloat(unformat_noobject(faceval)));
			window.opener.document.Form2.select_total.value=m_total;
			unforvalue=unformat_noobject(m_total);
		  m_arrdata[pos]="";
			del=pos*2;
		  lineno=lineno-1;
			repo_pass_vals[del]="";
			repo_pass_vals[del-1]="";
			repo_pass_vals[del-2]="";
			repo_pass_vals[del-3]="";
		//	repo_pass_vals[del-4]="";
			m_table.innerHTML='<TABLE BORDER="0" BGCOLOR="darkblue" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
		  '<TR><TD  WIDTH="85%"><B STYLE="{color: white; font: bold 9pt arial;}">Inventory Selection</B></TD><TD  WIDTH="15%"><INPUT TYPE="button" VALUE="Proceed" NAME="BUT_BCODE" ONCLICK="repo_transfervals('+unforvalue+',('+lineno+'))" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD></TR><SCRIPT language1.2="JavaScript" src="outrights_inv_details.js"></SCRIPT></TABLE>'+
	 		'<TABLE BORDER="1" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}"><TR BGCOLOR="silver" ><TD WIDTH="15%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Type</TD><TD WIDTH="30%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Security</TD><TD WIDTH="25%" STYLE="{text-align:center;}" ><B><FONT COLOR="black">Serial Number</TD><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Face Value</TD></FONT></FONT></B></TR>'+
	  	m_arrdata.join(" ")+'<TR><TD></TD><TD></TD><TD BGCOLOR="silver" STYLE="{text-align:center; color: black; font: bold 9pt arial;}">Total</TD><TD STYLE="{text-align:right;}">'+m_total+'</TD></TR></TABLE>';
		}
 		}
 
	
function repo_transfervals(val,pos){
	//parent.frames[1].location='mbfsl_broker_settlement_v1.html';
	actualpos=pos*5;
	if (repo_pass_vals[1]!=""){
	
	window.opener.document.Form2.Text_face_value1.value=repo_pass_vals[1];
	window.opener.document.Form2.Text_security1.value=repo_pass_vals[2];
	window.opener.document.Form2.Hid_sno1.value=repo_pass_vals[3];
	window.opener.document.Form2.Hid_invtype1.value=repo_pass_vals[4];
	window.opener.document.Form2.Hid_dealno1.value=repo_pass_vals[5];
	window.opener.calculate_facevalue(window.opener.document.Form2.Text_security1,window.opener.document.Form2.Text_face_value1,window.opener.document.Form2.Text_hair_cut1);
	}  
	while (actualpos>serialno){
	if (repo_pass_vals[serialno]!=""){
	window.opener.dynomic_textbox();
	mt_sno="Text_security"+n;
	VAL_SECNO=window.opener.document.Form2.elements[mt_sno];
	
	mt_face="Text_face_value"+d;
	VAL_FACE=window.opener.document.Form2.elements[mt_face];
 	
	mt_hcut="Text_hair_cut"+d;
	HAIR_CUT=window.opener.document.Form2.elements[mt_hcut];
  
	mt_sno="Hid_sno"+d;
	S_NO=window.opener.document.Form2.elements[mt_sno];

  mt_itype="Hid_invtype"+d;
	I_TYPE=window.opener.document.Form2.elements[mt_itype];

  mt_deal="Hid_dealno"+d;
	DEAL_N0=window.opener.document.Form2.elements[mt_deal];


	VAL_FACE.value=repo_pass_vals[serialno];
	VAL_SECNO.value=repo_pass_vals[serialno+1];
	S_NO.value=repo_pass_vals[serialno+2];
	I_TYPE.value=repo_pass_vals[serialno+3];
//	DEAL_N0.value=repo_pass_vals[serialno+4];
	
	window.opener.calculate_facevalue(VAL_SECNO,VAL_FACE,HAIR_CUT);
	n=n+1;
	d=d+1;
  }
	else{
	actualpos=actualpos+5;
	}
  serialno=serialno+5;
	}	
 window.opener.document.Form2.select_info.value=m_arrdata;


 top.close();
}
	
	
