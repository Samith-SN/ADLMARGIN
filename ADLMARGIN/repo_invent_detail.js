//*******************************************************************************************************
m_arrdata= new Array ();
m_arrdata1= new Array ();
m_arrpos = new Array ();
m_store_array = new Array ();
var m_delete_array=new Array();//BY NF

serialno=6;//BY NF
lineno=0;
repo_pass_vals= new Array();
i=1;
w=1;
m_total="0.00";



//*******************************************************************************************************
n=0;
function def_load(){
totrow=document.Form1.totrow.value;
while (n!=totrow){
	m_arrpos[n]="X";
	n=parseInt(n)+1;
}
}


function displayrepoinv(port,instype,security,dealref){
	////BY NF
	/*if(flag==0){
	parent.frames[1].notbal.innerHTML="";
	parent.frames[1].insdata.innerHTML="";
  parent.frames[1].document.Form1.TXT_SENOIDEN1_1.value="";
  parent.frames[1].document.Form1.TXT_FACEVAL1_1.value="";
  parent.frames[1].document.Form1.HID_FACEVAL1_1.value="";
  parent.frames[1].document.Form1.MIS1_1.value="0.00";
  parent.frames[1].document.Form1.INV_TYPE1_1.value="";
  m_mismat ="0.00";
	}*/
	//flag=0;//BY NF
	//m_url=servlet_client_url+':'+client_t3_port+'/fvalblsecout_new?port_code='+port.toUpperCase()+'&inst_code='+instype.toUpperCase()+'&sec_code='+security+'&chksql=repofreshinv_details';//BY NF
	m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'fvalblsecout_new?port_code='+port.toUpperCase()+'&inst_code='+instype.toUpperCase()+'&sec_code='+security+'&m_array='+m_delete_array+'&dealref='+dealref+'&chksql=repofreshinv_details';///BY NF
	m_url_main='dn_F_Outrights_inventory_frame.html';
  popupwin1 =window.open(m_url_main,'displayWindow1','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
	//popupwin1.focus();
	setTimeout("abs()",800);
	//popupwin1.parent.frames[0].location.href=m_url;
}
function abs(){
popupwin1.parent.frames[0].location.href=m_url;
popupwin1.focus();
}
function display_reposelect(seccode,serialno,faceval,invtype,pos,noforval,deal_no) {
	w=pos;
	m_row=1;
 	inputname="SEL"+pos;
	h_payamtobj=parent.frames[0].document.Form1.elements[inputname];
	if (h_payamtobj.checked==true) {
			m_total=parseFloat(unformat_noobject(m_total))+parseFloat(unformat_noobject(faceval));
			m_total=format_noobject(m_total);
			unforvalue=parent.frames[0].unformat_noobject(m_total);
			m_writedata='<TR><TD WIDTH="15%" ID=K'+w+'N1 STYLE="{text-align:center;}">'+invtype+'<INPUT TYPE="Hidden" NAME="Hid_type_'+w+'N1"	VALUE='+invtype+'></TD>'+
			 					 '<TD WIDTH="25%" ID=K'+w+'N2 STYLE="{cursor: hand; font: 9pt arial; text-align:center;}">'+seccode+'</TD>'+
									'<TD WIDTH="25%" ID=K'+w+'N3 STYLE="{cursor: hand; font: 9pt arial; text-align:center;}">'+serialno+'</TD>'+
									'<TD WIDTH="25%" ID=K'+w+'N4 STYLE="{text-align:right;}">'+faceval+'</TD></TR>';
		 
			m_hid_input2='<TR><TD WIDTH="15%"  STYLE="{text-align:center;}"><INPUT TYPE="Hidden" NAME="Hid_type_'+w+'N1"	VALUE='+invtype+'></TD>'+
			 								'<TD WIDTH="25%"  STYLE="{cursor: hand; font: 9pt arial; text-align:center;}"><INPUT TYPE="Hidden" NAME="Hid_type_'+w+'N2"	VALUE='+seccode+'></TD>'+
											 '<TD WIDTH="25%"  STYLE="{cursor: hand; font: 9pt arial; text-align:center;}"><INPUT TYPE="Hidden" NAME="Hid_type_'+w+'N3"	VALUE='+serialno+'></TD>'+
			 								'<TD WIDTH="25%"  STYLE="{text-align:right;}"><INPUT TYPE="Hidden" NAME="Hid_type_'+w+'N4"	VALUE='+faceval+'></TD></TR>';
	 	 
			m_arrpos[pos]=pos;
			w=w+1;
			m_url="outrights_selected.html"
			m_arrdata[pos]=m_writedata;
			m_arrdata1[pos]=m_hid_input2;
			lineno=lineno+1;
			repo_pass_vals[i]=(faceval);
			repo_pass_vals[i+1]=(seccode);
			repo_pass_vals[i+2]=(serialno);	
			repo_pass_vals[i+3]=(invtype);	
			repo_pass_vals[i+4]=(deal_no);
			
			parent.frames[1].m_table.innerHTML='<TABLE BORDER="0" BGCOLOR="darkblue" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
			'<TR><TD WIDTH="85%"><B STYLE="{color: white; font: bold 9pt arial;}">Inventory Selection</B></TD><TD  WIDTH="15%"><INPUT TYPE="button" VALUE="Proceed" NAME="BUT_BCODE" ONCLICK="parent.frames[0].repo_transfervals('+unforvalue+',('+lineno+'))" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD></TR><SCRIPT language1.2="JavaScript" src="outrights_inv_details.js"></SCRIPT></TABLE>'+
	  	'<TABLE BORDER="1" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}"><TR BGCOLOR="silver" ><TD WIDTH="15%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Type</TD><TD WIDTH="30%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Security</TD><TD WIDTH="25%" STYLE="{text-align:center;}" ><B><FONT COLOR="black">Serial Number</TD><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Face Value</TD></FONT></FONT></B></TR>'+
			m_arrdata.join(" ")+'<TR><TD></TD><TD></TD><TD BGCOLOR="silver" STYLE="{text-align:center; color: black; font: bold 9pt arial;}">Total</TD><TD STYLE="{text-align:right;}">'+m_total+'</TD></TR></TABLE>';
			
			parent.window.opener.parent.frames[1].insdata.innerHTML='<TABLE><TR><TD></TD><TD></TD><TD></TD><TD></TD></TR>'+
			m_arrdata1.join(" ")+'<TR><TD></TD><TD></TD><TD></TD><TD></TD></TR></TABLE>';
			
			i=i+5;
}
	else {
			m_total=parseFloat(unformat_noobject(m_total))-parseFloat(unformat_noobject(faceval));
			m_total=format_noobject(m_total);
			unforvalue=parent.frames[0].unformat_noobject(m_total);
			m_arrdata[pos]="";
			m_arrdata1[pos]="";
			m_arrpos[pos]="X";

			del=pos*2;
			lineno=lineno-1;
			repo_pass_vals[del]="";
			repo_pass_vals[del-1]="";
			repo_pass_vals[del-2]="";
			repo_pass_vals[del-3]="";
			repo_pass_vals[del-4]="";
			parent.frames[1].m_table.innerHTML='<TABLE BORDER="0" BGCOLOR="darkblue" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
			'<TR><TD  WIDTH="85%"><B STYLE="{color: white; font: bold 9pt arial;}">Inventory Selection</B></TD><TD  WIDTH="15%"><INPUT TYPE="button" VALUE="Proceed" NAME="BUT_BCODE" ONCLICK="parent.frames[0].repo_transfervals('+unforvalue+',('+lineno+'))" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD></TR><SCRIPT language1.2="JavaScript" src="outrights_inv_details.js"></SCRIPT></TABLE>'+
	 		'<TABLE BORDER="1" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}"><TR BGCOLOR="silver" ><TD WIDTH="15%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Type</TD><TD WIDTH="30%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Security</TD><TD WIDTH="25%" STYLE="{text-align:center;}" ><B><FONT COLOR="black">Serial Number</TD><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Face Value</TD></FONT></FONT></B></TR>'+
	  	m_arrdata.join(" ")+'<TR><TD></TD><TD></TD><TD BGCOLOR="silver" STYLE="{text-align:center; color: black; font: bold 9pt arial;}">Total</TD><TD STYLE="{text-align:right;}">'+m_total+'</TD></TR></TABLE>';
		
			parent.window.opener.parent.frames[1].insdata.innerHTML='<TABLE><TR><TD></TD><TD></TD><TD></TD><TD></TD></TR>'+
			m_arrdata1.join(" ")+'<TR><TD></TD><TD></TD><TD></TD><TD></TD></TR></TABLE>';
		}
 		}

////////modified by nf
function repo_transfervals(val,pos){
		n=parseInt(parent.window.opener.parent.frames[1].document.Form1.HID_SECURITY1.value)+parseInt(1);
 		d=parseInt(parent.window.opener.parent.frames[1].document.Form1.HID_SECURITY1.value)+parseInt(1);
		actualpos=pos*5;
		if(parent.window.opener.parent.frames[1].flag==1){	
			if (repo_pass_vals[3]!=""){
				parent.window.opener.parent.frames[1].document.Form1.TXT_SENOIDEN1_1.value=repo_pass_vals[3];
				parent.window.opener.parent.frames[1].document.Form1.TXT_FACEVAL1_1.value=repo_pass_vals[1];
				parent.window.opener.parent.frames[1].document.Form1.HID_FACEVAL1_1.value=repo_pass_vals[1];
				parent.window.opener.parent.frames[1].document.Form1.MIS1_1.value=format_noobject(parseFloat(unformat_noobject(parent.window.opener.parent.frames[1].document.Form1.TXT_FFACEVAL1.value))-parseFloat(unformat_noobject(parent.window.opener.parent.frames[1].document.Form1.TXT_FACEVAL1_1.value)));
				parent.window.opener.parent.frames[1].document.Form1.INV_TYPE1_1.value="OR";
				parent.window.opener.parent.frames[1].m_delete_array[0]="'"+repo_pass_vals[3]+"'";
				//alert(parent.window.opener.parent.frames[1].m_delete_array[0]);
				parent.window.opener.parent.frames[1].flag=0;
       }
		}
		else{
		  serialno=1;
		}
	while (actualpos>serialno){
	if (repo_pass_vals[serialno]!=""){
   parent.window.opener.parent.frames[1].dynomic_textbox(repo_pass_vals[serialno+2],repo_pass_vals[serialno]);
	 mt_sno="TXT_SENOIDEN1_"+d;
 	 VAL_SECNO=parent.window.opener.parent.frames[1].document.Form1.elements[mt_sno];
	 mt_matu="TXT_FACEVAL1_"+d;
	 VAL_MATU=parent.window.opener.parent.frames[1].document.Form1.elements[mt_matu];
	 VAL_MATU.value=repo_pass_vals[serialno];
	 VAL_SECNO.value=repo_pass_vals[serialno+2];
	
   mn_miss="MIS1_"+d;
   mn_miss=parent.window.opener.parent.frames[1].document.Form1.elements[mn_miss];
 
   mp_miss="MIS1_"+(d-1);
   mp_miss=parent.window.opener.parent.frames[1].document.Form1.elements[mp_miss];
	
   mn_miss.value=format_noobject(parseFloat(unformat_noobject(mp_miss.value))-parseFloat(unformat_noobject(VAL_MATU.value)));
	
	 n=n+1;
	 d=d+1;
	}
	else{
	actualpos=actualpos+6;
	}
  serialno=serialno+5;
	}	
	parent.window.opener.parent.frames[1].document.Form1.select_info.value=m_arrdata;
	top.close();
}
//////	
		
	
		
	
	
	
	
		
 
