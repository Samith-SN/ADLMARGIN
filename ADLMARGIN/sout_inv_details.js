var m_arrdata = new Array();
var repo_pass_vals = new Array();

var repo_pass_vals = new Array();
var select_info;


m_total="0.00";
lineno=0;
du_lineno=0;
i=1;
serialno=3;
n=2;
d=2;





//----------------------------------- Swap Outright Inventory ---------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



function P1display_retuinv(port,instype){
	//parent.frames[1].location='dn_blsecurities_frame4.html';
	//document.Form1.Text_amount1.value=parent.frames[0].document.Form1.Text_leg1.value;
	m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'fvalrollinventory?port_code='+port.toUpperCase()+'&inst_code='+instype.toUpperCase()+'&chksql=P1sout_details';
	m_url_main='dn_F_Outrights_inventory_frame.html';
	popupwin1 = window.open(m_url_main,'displayWindow1','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
  popupwin1.focus();
	popupwin1.parent.frames[0].location.href=m_url;
}


function P2display_retuinv(port,instype){
	//parent.frames[1].location='dn_blsecurities_frame4.html';
	//document.Form1.Text_amount1.value=parent.frames[0].document.Form1.Text_leg1.value;
	m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'fvalrollinventory?port_code='+port.toUpperCase()+'&inst_code='+instype.toUpperCase()+'&chksql=P2sout_details';
	m_url_main='dn_F_Outrights_inventory_frame.html';
	popupwin1 = window.open(m_url_main,'displayWindow1','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
  popupwin1.focus();
	popupwin1.parent.frames[0].location.href=m_url;
}


function display_select_repo(){
 	m_url_select='blsec_inventory_select.html';
	popupwin2 = window.open(m_url_select,'displayWindow2','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
  popupwin2.focus();
	}


function P1display_sreturnselect(seccode,serialno,faceval,invtype,pos,noforval) {
	m_row=1;
 	inputname="SEL"+pos;
	h_payamtobj=parent.frames[0].document.Form1.elements[inputname];
  if (h_payamtobj.checked==true) {
			m_total=parent.frames[0].format_noobject(parseFloat(parent.frames[0].unformat_noobject(m_total))+parseFloat(parent.frames[0].unformat_noobject(faceval)));
			parent.window.opener.parent.frames[0].document.Form1.HID_TEST1.value=m_total;
			unforvalue=parent.frames[0].unformat_noobject(m_total);
			m_writedata='<TR><TD WIDTH="15%" STYLE="{text-align:center;}">'+invtype+'</TD><TD WIDTH="25%" STYLE="{cursor: hand; font: 9pt arial; text-align:center;}">'+seccode+'</TD><TD WIDTH="25%" STYLE="{cursor: hand; font: 9pt arial; text-align:center;}">'+serialno+'</TD><TD WIDTH="25%" STYLE="{text-align:right;}">'+faceval+'</TD></TR>';
  		//'<TR><TD></TD><TD STYLE="{text-align:center;}"><B><FONT COLOR="black">Total</TD><TD STYLE="{text-align:right;}">'+faceval+'</TD></TR>';
			//m_url=servlet_client_url+':'+client_t3_port+'/fvalrollinventory?sec_code='+seccode.toUpperCase()+'&serial_code='+serialno.toUpperCase()+'&facevalue='+faceval+'&m_rowno='+row_no+'&chksql=invdetailselected';
			m_url="outrights_selected.html"
			//popupwin1 = window.open(m_url,'displayWindow2','left=0,top=0,width=500,height=200,toolbar=0,location=0,left=150,top=320,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			//popupwin1.focus();
			//parent.frames[1].m_table.innerHTML=parent.frames[1].m_table.innerHTML+m_writedata;
			m_arrdata[pos]=m_writedata;
			lineno=lineno+1;
			repo_pass_vals[i]=(faceval);
			repo_pass_vals[i+1]=(seccode);			
			parent.frames[1].m_table.innerHTML='<TABLE BORDER="0" BGCOLOR="darkblue" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
			'<TR><TD WIDTH="85%"><B STYLE="{color: white; font: bold 9pt arial;}">Inventory Selection</B></TD><TD  WIDTH="15%"><INPUT TYPE="button" VALUE="Proceed" NAME="BUT_BCODE" ONCLICK="parent.frames[0].P1blsec_transfervals('+unforvalue+',('+lineno+'))" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD></TR><SCRIPT language1.2="JavaScript" src="outrights_inv_details.js"></SCRIPT></TABLE>'+
	  	'<TABLE BORDER="1" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}"><TR BGCOLOR="silver" ><TD WIDTH="15%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Type</TD><TD WIDTH="30%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Security</TD><TD WIDTH="25%" STYLE="{text-align:center;}" ><B><FONT COLOR="black">Serial Number</TD><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Face Value</TD></FONT></FONT></B></TR>'+
			m_arrdata.join(" ")+'<TR><TD></TD><TD></TD><TD BGCOLOR="silver" STYLE="{text-align:center; color: black; font: bold 9pt arial;}">Total</TD><TD STYLE="{text-align:right;}">'+m_total+'</TD></TR></TABLE>';
		  
		  i=i+2;
			//du_lineno=lineno;
}
	else {
			m_total=parent.frames[0].format_noobject(parseFloat(parent.frames[0].unformat_noobject(m_total))-parseFloat(parent.frames[0].unformat_noobject(faceval)));
			parent.window.opener.parent.frames[0].document.Form1.HID_TEST1.value=m_total;
			unforvalue=parent.frames[0].unformat_noobject(m_total);
		  m_arrdata[pos]="";
			del=pos*2;
		  lineno=lineno-1;
			repo_pass_vals[del]="";
			repo_pass_vals[del-1]="";
			parent.frames[1].m_table.innerHTML='<TABLE BORDER="0" BGCOLOR="darkblue" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
		  '<TR><TD  WIDTH="85%"><B STYLE="{color: white; font: bold 9pt arial;}">Inventory Selection</B></TD><TD  WIDTH="15%"><INPUT TYPE="button" VALUE="Proceed" NAME="BUT_BCODE" ONCLICK="parent.frames[0].P1blsec_transfervals('+unforvalue+',('+lineno+'))" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD></TR><SCRIPT language1.2="JavaScript" src="outrights_inv_details.js"></SCRIPT></TABLE>'+
	 		'<TABLE BORDER="1" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}"><TR BGCOLOR="silver" ><TD WIDTH="15%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Type</TD><TD WIDTH="30%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Security</TD><TD WIDTH="25%" STYLE="{text-align:center;}" ><B><FONT COLOR="black">Serial Number</TD><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Face Value</TD></FONT></FONT></B></TR>'+
	  	m_arrdata.join(" ")+'<TR><TD></TD><TD></TD><TD BGCOLOR="silver" STYLE="{text-align:center; color: black; font: bold 9pt arial;}">Total</TD><TD STYLE="{text-align:right;}">'+m_total+'</TD></TR></TABLE>';
		}
 	}
 
	
	function P2display_sreturnselect(seccode,serialno,faceval,invtype,pos,noforval) {
	m_row=1;
 	inputname="SEL"+pos;
	h_payamtobj=parent.frames[0].document.Form1.elements[inputname];
  if (h_payamtobj.checked==true) {
			m_total=parent.frames[0].format_noobject(parseFloat(parent.frames[0].unformat_noobject(m_total))+parseFloat(parent.frames[0].unformat_noobject(faceval)));
			parent.window.opener.parent.frames[0].document.Form1.HID_TEST2.value=m_total;
			unforvalue=parent.frames[0].unformat_noobject(m_total);
			m_writedata='<TR><TD WIDTH="15%" STYLE="{text-align:center;}">'+invtype+'</TD><TD WIDTH="25%" STYLE="{cursor: hand; font: 9pt arial; text-align:center;}">'+seccode+'</TD><TD WIDTH="25%" STYLE="{cursor: hand; font: 9pt arial; text-align:center;}">'+serialno+'</TD><TD WIDTH="25%" STYLE="{text-align:right;}">'+faceval+'</TD></TR>';
  		//'<TR><TD></TD><TD STYLE="{text-align:center;}"><B><FONT COLOR="black">Total</TD><TD STYLE="{text-align:right;}">'+faceval+'</TD></TR>';
			//m_url=servlet_client_url+':'+client_t3_port+'/fvalrollinventory?sec_code='+seccode.toUpperCase()+'&serial_code='+serialno.toUpperCase()+'&facevalue='+faceval+'&m_rowno='+row_no+'&chksql=invdetailselected';
			m_url="outrights_selected.html"
			//popupwin1 = window.open(m_url,'displayWindow2','left=0,top=0,width=500,height=200,toolbar=0,location=0,left=150,top=320,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			//popupwin1.focus();
			//parent.frames[1].m_table.innerHTML=parent.frames[1].m_table.innerHTML+m_writedata;
			m_arrdata[pos]=m_writedata;
			lineno=lineno+1;
			repo_pass_vals[i]=(faceval);
			repo_pass_vals[i+1]=(seccode);			
			parent.frames[1].m_table.innerHTML='<TABLE BORDER="0" BGCOLOR="darkblue" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
			'<TR><TD WIDTH="85%"><B STYLE="{color: white; font: bold 9pt arial;}">Inventory Selection</B></TD><TD  WIDTH="15%"><INPUT TYPE="button" VALUE="Proceed" NAME="BUT_BCODE" ONCLICK="parent.frames[0].P2blsec_transfervals('+unforvalue+',('+lineno+'))" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD></TR><SCRIPT language1.2="JavaScript" src="outrights_inv_details.js"></SCRIPT></TABLE>'+
	  	'<TABLE BORDER="1" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}"><TR BGCOLOR="silver" ><TD WIDTH="15%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Type</TD><TD WIDTH="30%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Security</TD><TD WIDTH="25%" STYLE="{text-align:center;}" ><B><FONT COLOR="black">Serial Number</TD><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Face Value</TD></FONT></FONT></B></TR>'+
			m_arrdata.join(" ")+'<TR><TD></TD><TD></TD><TD BGCOLOR="silver" STYLE="{text-align:center; color: black; font: bold 9pt arial;}">Total</TD><TD STYLE="{text-align:right;}">'+m_total+'</TD></TR></TABLE>';
		  
		  i=i+2;
			//du_lineno=lineno;
}
	else {
			m_total=parent.frames[0].format_noobject(parseFloat(parent.frames[0].unformat_noobject(m_total))-parseFloat(parent.frames[0].unformat_noobject(faceval)));
			parent.window.opener.parent.frames[0].document.Form1.HID_TEST2.value=m_total;
			unforvalue=parent.frames[0].unformat_noobject(m_total);
		  m_arrdata[pos]="";
			del=pos*2;
		  lineno=lineno-1;
			repo_pass_vals[del]="";
			repo_pass_vals[del-1]="";
			parent.frames[1].m_table.innerHTML='<TABLE BORDER="0" BGCOLOR="darkblue" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
		  '<TR><TD  WIDTH="85%"><B STYLE="{color: white; font: bold 9pt arial;}">Inventory Selection</B></TD><TD  WIDTH="15%"><INPUT TYPE="button" VALUE="Proceed" NAME="BUT_BCODE" ONCLICK="parent.frames[0].P2blsec_transfervals('+unforvalue+',('+lineno+'))" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD></TR><SCRIPT language1.2="JavaScript" src="outrights_inv_details.js"></SCRIPT></TABLE>'+
	 		'<TABLE BORDER="1" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}"><TR BGCOLOR="silver" ><TD WIDTH="15%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Type</TD><TD WIDTH="30%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Security</TD><TD WIDTH="25%" STYLE="{text-align:center;}" ><B><FONT COLOR="black">Serial Number</TD><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Face Value</TD></FONT></FONT></B></TR>'+
	  	m_arrdata.join(" ")+'<TR><TD></TD><TD></TD><TD BGCOLOR="silver" STYLE="{text-align:center; color: black; font: bold 9pt arial;}">Total</TD><TD STYLE="{text-align:right;}">'+m_total+'</TD></TR></TABLE>';
		}
 	}
	
	
function P1blsec_transfervals(val,pos){
	actualpos=pos*2;
	parent.window.opener.parent.frames[0].document.Form1.HID_TEST1.value=parent.frames[0].format_noobject(val);
	parent.window.opener.parent.frames[1].document.Form1.TXT_TOTVAL1.value=parent.frames[0].format_noobject(val);
	if (repo_pass_vals[1]!=""){
	parent.window.opener.parent.frames[1].document.Form1.P1TXT_FACEVAL1.value=repo_pass_vals[1];
	parent.window.opener.parent.frames[1].document.Form1.P1TXT_SENOIDEN1.value=repo_pass_vals[2];
	parent.window.opener.parent.frames[1].P1tranfaceval();
	}
	while (actualpos>serialno){
	if (repo_pass_vals[serialno]!=""){
	parent.window.opener.parent.frames[1].P1newpart2();
	mt_sno="P1TXT_SENOIDEN"+n;
	VAL_SNO=parent.window.opener.parent.frames[1].document.Form1.elements[mt_sno];
	mt_face="P1TXT_FACEVAL"+d;
	VAL_FACE=parent.window.opener.parent.frames[1].document.Form1.elements[mt_face];
 	VAL_FACE.value=repo_pass_vals[serialno];
	VAL_SNO.value=repo_pass_vals[serialno+1];
	parent.window.opener.parent.frames[1].P1tranfaceval2();
	n=n+1;
	d=d+1;
  }
	else{
	actualpos=actualpos+2;
	}
  serialno=serialno+2;
	}	
//parent.window.opener.parent.frames[0].document.Form1.TXT_ENCODE.focus();
top.close();
}


function P2blsec_transfervals(val,pos){
  //alert(repo_pass_vals);
	actualpos=pos*2;
	parent.window.opener.parent.frames[0].document.Form1.HID_TEST2.value=parent.frames[0].format_noobject(val);
	parent.window.opener.parent.frames[1].document.Form1.TXT_TOTVAL2.value=parent.frames[0].format_noobject(val);
	if (repo_pass_vals[1]!=""){
	parent.window.opener.parent.frames[1].document.Form1.P2TXT_FACEVAL1.value=repo_pass_vals[1];
	parent.window.opener.parent.frames[1].document.Form1.P2TXT_SENOIDEN1.value=repo_pass_vals[2];
	parent.window.opener.parent.frames[1].P2tranfaceval();
	}
	while (actualpos>serialno){
	if (repo_pass_vals[serialno]!=""){
	parent.window.opener.parent.frames[1].P2newpart2();
	mt_sno="P2TXT_SENOIDEN"+n;
	VAL_SNO=parent.window.opener.parent.frames[1].document.Form1.elements[mt_sno];
	mt_face="P2TXT_FACEVAL"+d;
	VAL_FACE=parent.window.opener.parent.frames[1].document.Form1.elements[mt_face];
 	VAL_FACE.value=repo_pass_vals[serialno];
	VAL_SNO.value=repo_pass_vals[serialno+1];
	parent.window.opener.parent.frames[1].P2tranfaceval2();
	n=n+1;
	d=d+1;
  }
	else{
	actualpos=actualpos+2;
	}
  serialno=serialno+2;
	}	
//parent.window.opener.parent.frames[0].document.Form1.TXT_ENCODE.focus();
top.close();
}



