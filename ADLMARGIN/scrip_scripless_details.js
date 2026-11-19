var m_arrdata = new Array();
var passing_vals = new Array();

var repo_pass_vals = new Array();
var select_info;

 var m_len=0;
m_total="0.00";
lineno=0;
du_lineno=0;
i=1;
serialno=1;

m_new=1;//$$##SC


//----------------------------------- Reporoll Inventory ---------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function displayrepoinv(m_port,m_sec,m_inst){
	m_port=m_port.value;
	m_sec=m_sec.value;
	m_inst=m_inst.value;
	m_url_main='dn_F_Outrights_inventory_frame.html';
	popupwin1 = window.open(m_url_main,'displayWindow1','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
	popupwin1.focus();
  setTimeout("get_data('"+m_port+"','"+m_sec+"','"+m_inst+"')",2000)
} 


function get_data(m_port,m_sec,m_inst){
  m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'val_scripscripless?chksql=get_security_any&port='+m_port.toUpperCase()+'&sec='+m_sec+'&inst='+m_inst+'&m_array='+m_delete_array+'';
	popupwin1.parent.frames[0].location.href=m_url;
}




function display_select_reporoll(){
	m_url_select='dn_repo_inventory_select.html';
	popupwin2 = window.open(m_url_select,'displayWindow2','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
  popupwin2.focus();
	}


function display_reposelect(serialno,faceval,yield,pos) {
//----$$##SC-----------	
if (m_new==1 ){
m_first=yield;
m_new=2;
}
//---------------------	
	m_row=1;
 	inputname="SEL"+pos;
	
	h_payamtobj=parent.frames[0].document.Form1.elements[inputname];
  if (h_payamtobj.checked==true) {
	//-------------------------$$##SC-------------------
	if (yield != m_first){
	 alert("Please select inventory from one YIELD ");
   h_payamtobj.checked=false;
  }else{
	//---------------------------------------------------
	
	m_writedata='<TR><TD WIDTH="50%" STYLE="{text-align:center;}">'+serialno+'</TD>'+
			            '<TD WIDTH="25%" STYLE="{cursor: hand; font: 9pt arial; text-align:center;}">'+faceval+'</TD>'+
									'<TD WIDTH="25%" STYLE="{cursor: hand; font: 9pt arial; text-align:center;}">'+yield+'</TD></TR>';
			m_url="outrights_selected.html"
			lineno=lineno+1;
			m_arrdata[pos]=m_writedata;
			
			repo_pass_vals[i]=(serialno);
		  repo_pass_vals[i+1]=(faceval);
		  repo_pass_vals[i+2]=(yield);
			parent.frames[1].m_table.innerHTML='<TABLE BORDER="0" BGCOLOR="darkblue" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
			                                   '<TR><TD WIDTH="85%"><B STYLE="{color: white; font: bold 9pt arial;}">Serial No Selection</B></TD>'+
																				 '<TD WIDTH="15%"><INPUT TYPE="button" VALUE="Proceed" NAME="BUT_BCODE" ONCLICK="parent.frames[0].reporoll_transfervals(('+lineno+'))" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD></TR><SCRIPT language1.2="JavaScript" src="scrip_scripless_details.js"></SCRIPT></TABLE>'+
	  	'<TABLE BORDER="1" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
			'<TR BGCOLOR="silver" ><TD WIDTH="50%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Serial No</TD>'+
			'<TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Face Value</TD>'+
			'<TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Yield</TD>'+
			'</FONT></FONT></B></TR>'+
			m_arrdata.join(" ")+'</TABLE>';
		  i=i+3;
	}//$$##SC		
}
	else {
		  m_arrdata[pos]="";
			del=pos*3;
		  lineno=lineno-1;
			repo_pass_vals[del]="";
			repo_pass_vals[del-1]="";
			parent.frames[1].m_table.innerHTML='<TABLE BORDER="0" BGCOLOR="darkblue" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
		  '<TR><TD  WIDTH="85%"><B STYLE="{color: white; font: bold 9pt arial;}">Serial No Selection</B></TD><TD  WIDTH="15%"><INPUT TYPE="button" VALUE="Proceed" NAME="BUT_BCODE" ONCLICK="parent.frames[0].reporoll_transfervals(('+lineno+'))" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD></TR><SCRIPT language1.2="JavaScript" src="scrip_scripless_details.js"></SCRIPT></TABLE>'+
	 		'<TABLE BORDER="1" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}"><TR BGCOLOR="silver" ><TD WIDTH="50%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Serial No</TD><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Face Value</TD><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Yield</TD></TR>'+
			m_arrdata.join(" ")+'</TABLE>';
		}
 	}
function reporoll_transfervals(pos){
		n=parseInt(parent.window.opener.parent.frames[1].document.Form1.Hid_row.value)+parseInt(1);
 		d=parseInt(parent.window.opener.parent.frames[1].document.Form1.Hid_row.value)+parseInt(1);
		actualpos=pos*3;
	while (actualpos>serialno){
	if (repo_pass_vals[serialno]!=""){
	parent.window.opener.parent.frames[1].dynomic_textbox(repo_pass_vals[serialno],repo_pass_vals[serialno+1],repo_pass_vals[serialno+2]);
	mt_sno="TXT_SENOIDEN1_"+d;
	mt_face="TXT_FACEVAL1_"+d;
	mt_yeild="MIS1_"+d;
	
	VAL_SERNO=parent.window.opener.parent.frames[1].document.Form1.elements[mt_sno];
	VAL_FACE=parent.window.opener.parent.frames[1].document.Form1.elements[mt_face];
	VAL_YIELD=parent.window.opener.parent.frames[1].document.Form1.elements[mt_yeild];
	
	VAL_SERNO.value=repo_pass_vals[serialno];
	VAL_FACE.value=format_noobject(repo_pass_vals[serialno+1]);
	VAL_YIELD.value=repo_pass_vals[serialno+2];
	
	 parent.window.opener.parent.frames[1].document.Form1.Hid_tot_face.value=parseFloat( parent.window.opener.parent.frames[1].document.Form1.Hid_tot_face.value)+parseFloat(unformat_noobject(VAL_FACE.value));
	 parent.window.opener.parent.frames[1].document.Form1.TXT_TFACE.value=parent.window.opener.parent.frames[1].document.Form1.Hid_tot_face.value;
	 parent.window.opener.parent.frames[1].document.Form1.TXT_TFACE.value=format_noobject(parent.window.opener.parent.frames[1].document.Form1.TXT_TFACE.value);

	n=n+1;
	d=d+1;
  }
	else{
	actualpos=actualpos+3;
	}
  serialno=serialno+3;
	}	
	parent.window.opener.parent.frames[1].document.Form1.select_info.value=m_arrdata;
	top.close();
}
	
	
