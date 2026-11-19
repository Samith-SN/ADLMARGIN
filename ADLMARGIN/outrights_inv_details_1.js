var m_arrdata = new Array();
total="0.00";


function transfervals(val){
	alert(val);
	//window.opener.top.frames[1].frames[2].frames[0].document.Form1.HID_TEST.value=val;
	window.opener.parent.frames[0].document.Form1.HID_TEST.value=val;	
	//window.opener.top.frames[1].frames[2].frames[0].document.Form1.HID_TEST.value=val;
	//window.opener.top.frames[1].frames[2].frames[0].document.Form1.HID_TEST.value=val;
	//window.opener.top.frames[1].frames[2].frames[0].document.Form1.HID_TEST.value=val;
	//window.opener.top.frames[1].frames[2].frames[0].document.Form1.HID_TEST.value=val;
  top.close();
}

function displaydata(port,instype,seccode){
  alert(window.opener.parent.frames[0].document.Form1.HID_TEST.value);
  if(port!="" && instype!="" && seccode!="" ){
	    m_url='servlet_client_url+':'+client_t3_port+'/fval_blsecout?port_code='+port.toUpperCase()+'&inst_code='+instype.toUpperCase()+'&seccode='+seccode+'&chksql=invdetail';
			//popupwin = window.open(m_url,'displayWindow1','left=0,top=0,width=500,height=200,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			m_url_main='dn_F_Outrights_inventory_frame.html';
			popupwin = window.open(m_url_main,'displayWindow1','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
      popupwin.focus();
			popupwin.parent.frames[0].location.href=m_url;
	}
	if(port!="" && instype!="" && seccode=="" ){
			m_url='servlet_client_url+':'+client_t3_port+'/fval_blsecout?port_code='+port.toUpperCase()+'&inst_code='+instype.toUpperCase()+'&chksql=invdetail2';
			m_url_main='dn_F_Outrights_inventory_frame.html';
			popupwin = window.open(m_url_main,'displayWindow1','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
      popupwin.focus();
			popupwin.parent.frames[0].location.href=m_url;

	}
}


function displayrepoinv(port,instype){
			m_url='servlet_client_url+':'+client_t3_port+'/fval_blsecout?port_code='+port.toUpperCase()+'&inst_code='+instype.toUpperCase()+'&chksql=repofreshinv_details';
			m_url_main='dn_F_Outrights_inventory_frame.html';
			popupwin = window.open(m_url_main,'displayWindow1','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
      popupwin.focus();
			popupwin.parent.frames[0].location.href=m_url;
	}




function display_select(seccode,serialno,faceval,pos,noforval) {
	m_row=1;
   inputname="SEL"+pos;
	 h_payamtobj=parent.frames[0].document.Form1.elements[inputname];
   if (h_payamtobj.checked==true) {
			total=parent.frames[0].format_noobject(parseFloat(parent.frames[0].unformat_noobject(total))+parseFloat(parent.frames[0].unformat_noobject(faceval)));
			unforvalue=parent.frames[0].unformat_noobject(total);
			m_writedata='<TR><TD WIDTH="33%" STYLE="{cursor: hand; font: 9pt arial; text-align:center;}">'+seccode+'</TD><TD WIDTH="33%" STYLE="{cursor: hand; font: 9pt arial; text-align:center;}">'+serialno+'</TD><TD WIDTH="34%" STYLE="{text-align:right;}">'+faceval+'</TD></TR>';
  		//'<TR><TD></TD><TD STYLE="{text-align:center;}"><B><FONT COLOR="black">Total</TD><TD STYLE="{text-align:right;}">'+faceval+'</TD></TR>';
			//m_url='http://www.srilanka.sasianet.lk:7001/fval_blsecout?sec_code='+seccode.toUpperCase()+'&serial_code='+serialno.toUpperCase()+'&facevalue='+faceval+'&m_rowno='+row_no+'&chksql=invdetailselected';
			m_url="outrights_selected.html"
			//popupwin1 = window.open(m_url,'displayWindow2','left=0,top=0,width=500,height=200,toolbar=0,location=0,left=150,top=320,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			//popupwin1.focus();
			//parent.frames[1].m_table.innerHTML=parent.frames[1].m_table.innerHTML+m_writedata;
			m_arrdata[pos]=m_writedata;
			parent.frames[1].m_table.innerHTML='<TABLE BORDER="0" BGCOLOR="darkblue" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
			'<TR><TD  WIDTH="85%"><B STYLE="{color: white; font: bold 9pt arial;}">Inventory Selection</B></TD><TD  WIDTH="15%"><INPUT TYPE="button" VALUE="Proceed" NAME="BUT_BCODE" ONCLICK="parent.frames[0].transfervals('+unforvalue+')" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD></TR><SCRIPT language1.2="JavaScript" src="outrights_inv_details.js"></SCRIPT></TABLE>'+
	  	'<TABLE BORDER="1" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}"><TR BGCOLOR="silver" ><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Security</TD><TD WIDTH="25%" STYLE="{text-align:center;}" ><B><FONT COLOR="black">Serial Number</TD><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Face Value</TD></FONT></B></TR>'+
			m_arrdata.join(" ")+'<TR><TD WIDTH="33%"></TD><TD WIDTH="33%" BGCOLOR="silver" STYLE="{text-align:center; color: black; font: bold 9pt arial;}">Total</TD><TD WIDTH="34%" STYLE="{text-align:right;}">'+total+'</TD></TR></TABLE>';
		}
		else {
			total=parent.frames[0].format_noobject(parseFloat(parent.frames[0].unformat_noobject(total))-parseFloat(parent.frames[0].unformat_noobject(faceval)));
			unforvalue=parent.frames[0].unformat_noobject(total);
			m_arrdata[pos]="";
			parent.frames[1].m_table.innerHTML='<TABLE BORDER="0" BGCOLOR="darkblue" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
		  '<TR><TD  WIDTH="85%"><B STYLE="{color: white; font: bold 9pt arial;}">Inventory Selection</B></TD><TD  WIDTH="15%"><INPUT TYPE="button" VALUE="Proceed" NAME="BUT_BCODE" ONCLICK="parent.frames[0].transfervals('+unforvalue+')" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD></TR><SCRIPT language1.2="JavaScript" src="outrights_inv_details.js"></SCRIPT></TABLE>'+
	 	  '<TABLE BORDER="1" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}"><TR BGCOLOR="silver" ><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Security</TD><TD WIDTH="25%" STYLE="{text-align:center;}" ><B><FONT COLOR="black">Serial Number</TD><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Face Value</TD></FONT></B></TR>'+
			m_arrdata.join(" ")+'<TR><TD WIDTH="33%"></TD><TD WIDTH="33%" BGCOLOR="silver" STYLE="{text-align:center; color: black; font: bold 9pt arial;}">Total</TD><TD WIDTH="34%" STYLE="{text-align:right;}">'+total+'</TD></TR></TABLE>';
	}
	}



function display_reposelect(seccode,serialno,faceval,invtype,pos,noforval) {
	m_row=1;
   inputname="SEL"+pos;
	 h_payamtobj=parent.frames[0].document.Form1.elements[inputname];
   if (h_payamtobj.checked==true) {
			total=parent.frames[0].format_noobject(parseFloat(parent.frames[0].unformat_noobject(total))+parseFloat(parent.frames[0].unformat_noobject(faceval)));
			unforvalue=parent.frames[0].unformat_noobject(total);
			m_writedata='<TR><TD WIDTH="15%" STYLE="{text-align:center;}">'+invtype+'</TD><TD WIDTH="25%" STYLE="{cursor: hand; font: 9pt arial; text-align:center;}">'+seccode+'</TD><TD WIDTH="25%" STYLE="{cursor: hand; font: 9pt arial; text-align:center;}">'+serialno+'</TD><TD WIDTH="25%" STYLE="{text-align:right;}">'+faceval+'</TD></TR>';
  		//'<TR><TD></TD><TD STYLE="{text-align:center;}"><B><FONT COLOR="black">Total</TD><TD STYLE="{text-align:right;}">'+faceval+'</TD></TR>';
			//m_url='http://www.srilanka.sasianet.lk:7001/fval_blsecout?sec_code='+seccode.toUpperCase()+'&serial_code='+serialno.toUpperCase()+'&facevalue='+faceval+'&m_rowno='+row_no+'&chksql=invdetailselected';
			m_url="outrights_selected.html"
			//popupwin1 = window.open(m_url,'displayWindow2','left=0,top=0,width=500,height=200,toolbar=0,location=0,left=150,top=320,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			//popupwin1.focus();
			//parent.frames[1].m_table.innerHTML=parent.frames[1].m_table.innerHTML+m_writedata;
			m_arrdata[pos]=m_writedata;
			parent.frames[1].m_table.innerHTML='<TABLE BORDER="0" BGCOLOR="darkblue" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
			'<TR><TD WIDTH="85%"><B STYLE="{color: white; font: bold 9pt arial;}">Inventory Selection</B></TD><TD  WIDTH="15%"><INPUT TYPE="button" VALUE="Proceed" NAME="BUT_BCODE" ONCLICK="parent.frames[0].transfervals('+unforvalue+')" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD></TR><SCRIPT language1.2="JavaScript" src="outrights_inv_details.js"></SCRIPT></TABLE>'+
	  	'<TABLE BORDER="1" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}"><TR BGCOLOR="silver" ><TD WIDTH="15%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Type</TD><TD WIDTH="30%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Security</TD><TD WIDTH="25%" STYLE="{text-align:center;}" ><B><FONT COLOR="black">Serial Number</TD><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Face Value</TD></FONT></FONT></B></TR>'+
			m_arrdata.join(" ")+'<TR><TD></TD><TD></TD><TD BGCOLOR="silver" STYLE="{text-align:center; color: black; font: bold 9pt arial;}">Total</TD><TD STYLE="{text-align:right;}">'+total+'</TD></TR></TABLE>';
		}
		else {
			total=parent.frames[0].format_noobject(parseFloat(parent.frames[0].unformat_noobject(total))-parseFloat(parent.frames[0].unformat_noobject(faceval)));
			unforvalue=parent.frames[0].unformat_noobject(total);
			m_arrdata[pos]="";
			parent.frames[1].m_table.innerHTML='<TABLE BORDER="0" BGCOLOR="darkblue" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
		  '<TR><TD  WIDTH="85%"><B STYLE="{color: white; font: bold 9pt arial;}">Inventory Selection</B></TD><TD  WIDTH="15%"><INPUT TYPE="button" VALUE="Proceed" NAME="BUT_BCODE" ONCLICK="parent.frames[0].transfervals('+unforvalue+')" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD></TR><SCRIPT language1.2="JavaScript" src="outrights_inv_details.js"></SCRIPT></TABLE>'+
	 		'<TABLE BORDER="1" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}"><TR BGCOLOR="silver" ><TD WIDTH="15%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Type</TD><TD WIDTH="30%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Security</TD><TD WIDTH="25%" STYLE="{text-align:center;}" ><B><FONT COLOR="black">Serial Number</TD><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Face Value</TD></FONT></FONT></B></TR>'+
	  	m_arrdata.join(" ")+'<TR><TD></TD><TD></TD><TD BGCOLOR="silver" STYLE="{text-align:center; color: black; font: bold 9pt arial;}">Total</TD><TD STYLE="{text-align:right;}">'+total+'</TD></TR></TABLE>';
		}
	}

