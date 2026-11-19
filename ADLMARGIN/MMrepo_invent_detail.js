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
//n=2;
//d=2;





//----------------------------------- Reporoll Inventory ---------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function displayrepoinv(port,instype,security){
	//port,instype,date,
/*	dd=ddcomp.value;
	mm=mmcomp.value;
	yy=yycomp.value;
	      val_date=new Date(yy,mm,dd);
	ddb=ddbcomp.value;
	mmb=mmbcomp.value;
	yyb=yybcomp.value;
      	base_date=new Date(yyb,mmb,ddb);	*/
	
	
	
	

	m_url_main='dn_F_Outrights_inventory_frame.html';
	popupwin1 = window.open(m_url_main,'displayWindow1','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
//	popupwin1.focus();
	
	//if(val_date != base_date){
		//m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'val_indextypes_1?chksql=get_security_any&m_array='+m_delete_array+'';
	//}
	//else{
	 //	m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'val_indextypes_1?chksql=get_security&m_array='+m_delete_array+'&base_date='+document.Form2.TXT_DATEB.value+'-'+document.Form2.TXT_MONTHB.value+'-'+document.Form2.TXT_YEARB.value;
	m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'fvalblsecout_new?port_code='+port.toUpperCase()+'&inst_code='+instype.toUpperCase()+'&sec_code='+security+'&chksql=repofreshinv_details';
  //popupwin1.parent.frames[0].location.href=m_url;
setTimeout("abs()",800);
}

function abs(){
popupwin1.parent.frames[0].location.href=m_url;
popupwin1.focus();
}

function display_select_reporoll(){
	m_url_select='dn_repo_inventory_select.html';
	popupwin2 = window.open(m_url_select,'displayWindow2','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
  popupwin2.focus();
	}

 
function display_reposelect(seccode,matdays,pos) {
	m_row=1;
 	inputname="SEL"+pos;
	
	h_payamtobj=parent.frames[0].document.Form1.elements[inputname];
  if (h_payamtobj.checked==true) {
			m_writedata='<TR><TD WIDTH="50%" STYLE="{text-align:center;}">'+seccode+'</TD>'+
			            '<TD WIDTH="50%" STYLE="{cursor: hand; font: 9pt arial; text-align:center;}">'+matdays+'</TD></TR>';
			m_url="outrights_selected.html"
			lineno=lineno+1;
			m_arrdata[pos]=m_writedata;
			
			repo_pass_vals[i]=(seccode);
		  repo_pass_vals[i+1]=(matdays);
			parent.frames[1].m_table.innerHTML='<TABLE BORDER="0" BGCOLOR="darkblue" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
			                                   '<TR><TD WIDTH="85%"><B STYLE="{color: white; font: bold 9pt arial;}">Security Selection</B></TD>'+
																				 '<TD WIDTH="15%"><INPUT TYPE="button" VALUE="Proceed" NAME="BUT_BCODE" ONCLICK="parent.frames[0].reporoll_transfervals(('+lineno+'))" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD></TR><SCRIPT language1.2="JavaScript" src="outrights_inv_details.js"></SCRIPT></TABLE>'+
	  	'<TABLE BORDER="1" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
			'<TR BGCOLOR="silver" ><TD WIDTH="50%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Security</TD>'+
			'<TD WIDTH="50%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Days to Maturity</TD>'+
			'</FONT></FONT></B></TR>'+
			m_arrdata.join(" ")+'</TABLE>';
		  i=i+2;
}
	else {
		  m_arrdata[pos]="";
			del=pos*2;
		  lineno=lineno-1;
			repo_pass_vals[del]="";
			repo_pass_vals[del-1]="";
			parent.frames[1].m_table.innerHTML='<TABLE BORDER="0" BGCOLOR="darkblue" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
		  '<TR><TD  WIDTH="85%"><B STYLE="{color: white; font: bold 9pt arial;}">Security Selection</B></TD><TD  WIDTH="15%"><INPUT TYPE="button" VALUE="Proceed" NAME="BUT_BCODE" ONCLICK="parent.frames[0].reporoll_transfervals(('+lineno+'))" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD></TR><SCRIPT language1.2="JavaScript" src="outrights_inv_details.js"></SCRIPT></TABLE>'+
	 		'<TABLE BORDER="1" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}"><TR BGCOLOR="silver" ><TD WIDTH="50%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Security</TD><TD WIDTH="50%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Days to Maturity</TD></TR>'+
			m_arrdata.join(" ")+'</TABLE>';
		}
 	}
function reporoll_transfervals(pos){
		//alert(parent.window.opener.parent.frames[1].document.Form2.HID_SECURITY.value);
		n=parseInt(parent.window.opener.parent.frames[1].document.Form2.HID_SECURITY.value)+parseInt(1);
 		d=parseInt(parent.window.opener.parent.frames[1].document.Form2.HID_SECURITY.value)+parseInt(1);
	  //alert("d"+d);
		actualpos=pos*2;
			/*if (repo_pass_vals[1]!=""){
				parent.window.opener.parent.frames[1].document.Form2.Text_matu1.value=repo_pass_vals[2];
				parent.window.opener.parent.frames[1].document.Form2.Text_security1.value=repo_pass_vals[1];
				parent.window.opener.parent.frames[1].document.Form2.Hid_sno1.value=repo_pass_vals[3];
				parent.window.opener.parent.frames[1].document.Form2.Hid_invtype1.value=repo_pass_vals[4];
				parent.window.opener.parent.frames[1].document.Form2.Hid_dealno1.value=repo_pass_vals[5];
				parent.window.opener.parent.frames[1].calculate_facevalue(parent.window.opener.parent.frames[1].document.Form2.Text_security1,parent.window.opener.parent.frames[1].document.Form2.Text_face_value1,parent.window.opener.parent.frames[1].document.Form2.Text_hair_cut1);
				parent.window.opener.parent.frames[1].m_delete_array[0]="'"+repo_pass_vals[1]+"'";
				parent.window.opener.parent.frames[1].flag=1;
     	}	*/												  
	while (actualpos>serialno){
	if (repo_pass_vals[serialno]!=""){
	parent.window.opener.parent.frames[1].dynomic_textbox(repo_pass_vals[serialno],repo_pass_vals[serialno+1]);
	mt_sno="Text_security"+n;
	VAL_SECNO=parent.window.opener.parent.frames[1].document.Form2.elements[mt_sno];
	mt_matu="Text_matu"+d;
	//alert(mt_matu);
	VAL_MATU=parent.window.opener.parent.frames[1].document.Form2.elements[mt_matu];
	VAL_MATU.value=repo_pass_vals[serialno+1];
	//alert(VAL_MATU.value);
	VAL_SECNO.value=repo_pass_vals[serialno];
	n=n+1;
	d=d+1;
  }
	else{
	actualpos=actualpos+2;
	}
  serialno=serialno+2;
	}	
	parent.window.opener.parent.frames[1].document.Form2.select_info.value=m_arrdata;
	top.close();
}
	
	
