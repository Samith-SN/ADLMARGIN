var m_arrdata = new Array();
var passing_vals = new Array();

var repo_pass_vals = new Array();
var select_info;

total="0.00";
lineno=0;
i=1;
serialno=3;
n=2;
d=2;
var mchkstst=0;//$$##SC


function displaydata_SL(port,instype,seccode,deal_ref_no,buy_port,m_inv_type){//$$##SC
	for (var i = 0; i< document.Form1.elements.length; i++) {
	     document.Form1.elements[i].disabled = false;
  }
	parent.frames[1].location='dn_CMoutrights_frame5.html';
	parent.frames[1].document.Form1.TXT_ISSURE.value=document.Form1.TXT_ISSCODE.value;
	parent.frames[1].document.Form1.TXT_SECCODE.value=document.Form1.TXT_SECIDEN.value;
	parent.frames[1].document.Form1.TXT_TOTVAL.value=document.Form1.HID_TEST.value;
	parent.frames[1].document.Form1.TXT_INSTYPE.value=document.Form1.TXT_INSTYPE.value;
	
	if(port!="" && instype!="" && seccode!="" && buy_port!="" ){
			m_url_main='dn_F_Outrights_inventory_frame.html';
			popupwin = window.open(m_url_main,'displayWindow1','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
      popupwin.focus();
     	setTimeout("get_data_SL('"+port+"','"+instype+"','"+seccode+"','"+buy_port+"','"+deal_ref_no+"','"+m_inv_type+"')",2000);	//'"+m_serial+"',
	}
}
//-------------------

function get_data_SL(port,instype,seccode,buy_port,deal_ref_no,m_inv_type){//$$##SC
if(port!="" && instype!="" && seccode!="" && buy_port!="" && deal_ref_no!=""){
m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'fvalblsecout?port_code='+port.toUpperCase()+'&inst_code='+instype.toUpperCase()+'&seccode='+seccode+'&dealrefno='+deal_ref_no+'&buy_port='+buy_port.toUpperCase()+'&inv_type='+m_inv_type+'&chksql=invdetail_mod_cdt_SL';
popupwin.focus();
popupwin.parent.frames[0].location.href=m_url;
}
}
//-------------------------

function disableall(line,tot_line,mfaceval,serial) {//$$##SC
mchkstst=line;
m_pval="TXT_AMT"+line;
m_pval=parent.frames[0].document.Form1.elements[m_pval];
if(parseFloat(m_pval.value) > unformat_noobject(mfaceval)){
 alert("Amount should be less than or equal to the Face Value!");
 m_pval.value=mfaceval;
}
else{
 m_pval.value=format_noobject(m_pval.value);
 mm_ppval=unformat_noobject(mfaceval)-unformat_noobject(m_pval.value);
 parent.window.opener.parent.frames[1].document.Form1.HID_PART_ALLO.value=mm_ppval;
 parent.window.opener.parent.frames[1].document.Form1.HID_PART_ALLO_SER.value=serial;
 parent.window.opener.parent.frames[1].document.Form1.HID_TOT_ALLO.value=unformat_noobject(mfaceval);
	for(y=1;y<tot_line;y++){
   m_val="TXT_AMT"+y;
   m_val=parent.frames[0].document.Form1.elements[m_val];
   m_val.disabled=true;
 }
}
}



function checkkey(e){//$$##SC
 if(e.keyCode==46){
   alert("You are not allowed to enter cents");
   e.keyCode=0;
 }
 }
 //-------------------------------------------------	

function disableall_sl(line,tot_line,mfaceval,serial) {//$$##SC  
mchkstst=line;
m_pval="TXT_AMT"+line;
m_pval=parent.frames[0].document.Form1.elements[m_pval];
if(parseFloat(m_pval.value) > unformat_noobject(mfaceval)){
 alert("Amount should be less than or equal to the Face Value!");
 m_pval.value=mfaceval;
}
else{
 m_pval.value=format_noobject_nodecimal(m_pval.value);
 mm_ppval=unformat_noobject(mfaceval)-unformat_noobject(m_pval.value);
 parent.window.opener.parent.frames[1].document.Form1.HID_PART_ALLO.value=mm_ppval;
 parent.window.opener.parent.frames[1].document.Form1.HID_PART_ALLO_SER.value=serial;
 parent.window.opener.parent.frames[1].document.Form1.HID_TOT_ALLO.value=unformat_noobject(mfaceval);
	for(y=1;y<tot_line;y++){
   m_val="TXT_AMT"+y;
   m_val=parent.frames[0].document.Form1.elements[m_val];
   m_val.disabled=true;
  
	}
}
}
//------------------------------------



function display_more_outinv(m_portcode,insttype,m_seccode,m_serial_no) {
	m_url_outinv=servlet_client_url+':'+client_t3_port+'/'+client_name+'fvalblsecout?portcode='+m_portcode+'&instrument='+insttype+'&seccode='+m_seccode+'&serial_no='+m_serial_no+'&chksql=moredata_outinv_cdt';
	popupwin2 = window.open(m_url_outinv,'displayWindow2','left=0,top=0,width=400,height=400,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
	popupwin2.focus();
}




//------------------------------- Outright Inventory --------------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



function displaydata(port,instype,seccode,dealrefno){
	for (var i = 0; i< document.Form1.elements.length; i++) {
	     document.Form1.elements[i].disabled = false;
  }

	parent.frames[1].location='dn_CMoutrights_frame5.html';
	parent.frames[1].document.Form1.TXT_ISSURE.value=document.Form1.TXT_ISSCODE.value;
	parent.frames[1].document.Form1.TXT_SECCODE.value=document.Form1.TXT_SECIDEN.value;
	parent.frames[1].document.Form1.TXT_TOTVAL.value=document.Form1.HID_TEST.value;
	parent.frames[1].document.Form1.TXT_INSTYPE.value=document.Form1.TXT_INSTYPE.value;
	
	if(port!="" && instype!="" && seccode!="" ){
	    m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'fvalblsecout?port_code='+port.toUpperCase()+'&inst_code='+instype.toUpperCase()+'&seccode='+seccode+'&dealrefno='+dealrefno+'&chksql=invdetail_mod_cdt';
			//popupwin = window.open(m_url,'displayWindow1','left=0,top=0,width=500,height=200,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			m_url_main='dn_F_Outrights_inventory_frame.html';
			popupwin = window.open(m_url_main,'displayWindow1','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
      popupwin.focus();
			popupwin.parent.frames[0].location.href=m_url;
	}

  if(port!="" && instype!="" && seccode=="" ){
			m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'fvalblsecout?port_code='+port.toUpperCase()+'&inst_code='+instype.toUpperCase()+'&dealrefno='+dealrefno+'&chksql=invdetail2';
			m_url_main='dn_F_Outrights_inventory_frame.html';
			popupwin = window.open(m_url_main,'displayWindow1','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
      popupwin.focus();
			popupwin.parent.frames[0].location.href=m_url;

	}
}


function display_select(seccode,serialno,faceval,pos,noforval,m_type) {
if(m_type=="SL"){
			inputname_new="SEL"+pos;
			inputname_new=parent.frames[0].document.Form1.elements[inputname_new];
			
			m_val3="TXT_AMT"+pos;
			m_val3=parent.frames[0].document.Form1.elements[m_val3];
			faceval=m_val3.value
			
			if(inputname_new.checked==true){
			m_val3.disabled=true;
			}else{
			if(mchkstst==pos){
			m_val3.disabled=false;
			}
			}
}			

m_row=1;
   inputname="SEL"+pos;
	 h_payamtobj=parent.frames[0].document.Form1.elements[inputname];
   if (h_payamtobj.checked==true) {
		//added By Nilu on 4-10-2004/9:58  VCF 04-243 Outright inventory allocation face val diffrence. copied from HNB.
		  m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalblsecout?chksql=add_data&tot_amt="+parent.frames[0].unformat_noobject(total)+"&face_val="+parent.frames[0].unformat_noobject(faceval);
			parent.window.opener.parent.frames[0].document.applets[0].getdata(m_url);
			m_size=parent.window.opener.parent.frames[0].document.applets[0].outvec_value.size();
			if (m_size >0) {
			    total       =parent.frames[0].format_noobject(parent.window.opener.parent.frames[0].document.applets[0].outvec_value.elementAt(1));
				  unforvalue	=parent.window.opener.parent.frames[0].document.applets[0].outvec_value.elementAt(1);
			}
	  // Commented By Nilu on 4-10-2004/10:0 VCF 04-243
		//	total=parent.frames[0].format_noobject(parseFloat(parent.frames[0].unformat_noobject(total))+parseFloat(parent.frames[0].unformat_noobject(faceval)));
	 //		unforvalue=parent.frames[0].unformat_noobject(total);
		
			m_writedata='<TR><TD WIDTH="33%" STYLE="{cursor: hand; font: 9pt arial; text-align:center;}">'+seccode+'</TD><TD WIDTH="33%" STYLE="{cursor: hand; font: 9pt arial; text-align:center;}">'+serialno+'</TD><TD WIDTH="34%" STYLE="{text-align:right;}">'+faceval+'</TD><TD><INPUT TYPE="hidden" NAME="HID_SNO'+lineno+'" VALUE='+serialno+'></TD><TD><INPUT TYPE="hidden" NAME="HID_FVAL'+lineno+'" VALUE='+faceval+'></TD></TR>';
  		m_url="outrights_selected.html"
		  m_arrdata[pos]=m_writedata;
  		passing_vals[i]=(faceval);
			passing_vals[i+1]=(serialno);
			lineno=lineno+1;
			parent.frames[1].m_table.innerHTML='<HTML><FORM NAME="Form1"><TABLE BORDER="0" BGCOLOR="darkblue" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
			'<TR><TD  WIDTH="85%"><B STYLE="{color: white; font: bold 9pt arial;}">Inventory Selection</B></TD><TD  WIDTH="15%"><INPUT TYPE="button" VALUE="Proceed" onClick=parent.frames[0].transfervals('+unforvalue+',('+lineno+'),"'+m_type+'") NAME="BUT_BCODE"  STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD></TR><SCRIPT language1.2="JavaScript" src="outrights_inv_details.js"></SCRIPT></TABLE>'+
	  	'<TABLE BORDER="1" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}"><TR BGCOLOR="silver" ><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Security</TD><TD WIDTH="25%" STYLE="{text-align:center;}" ><B><FONT COLOR="black">Serial Number</TD><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Face Value</TD></FONT></B></TR>'+
			m_arrdata.join(" ")+'<TR><TD WIDTH="33%"></TD><TD WIDTH="33%" BGCOLOR="silver" STYLE="{text-align:center; color: black; font: bold 9pt arial;}">Total</TD><TD WIDTH="34%" STYLE="{text-align:right;}">'+total+'</TD></TR></TABLE></FORM><script language="JavaScript1.2" src="outrights_inv_details.js"></SCRIPT></HTML>';
		  i=i+2;
			}
		else {
		
		//added By Nilu on 4-10-2004/9:58  VCF 04-243 Outright inventory allocation face val diffrence. copied from HNB.
		  m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalblsecout?chksql=add_data&tot_amt="+parent.frames[0].unformat_noobject(total)+"&face_val="+parent.frames[0].unformat_noobject(faceval);
			parent.window.opener.parent.frames[0].document.applets[0].getdata(m_url);
			m_size=parent.window.opener.parent.frames[0].document.applets[0].outvec_value.size();
			if (m_size >0) {
			    total       =parent.frames[0].format_noobject(parent.window.opener.parent.frames[0].document.applets[0].outvec_value.elementAt(1));
				  unforvalue	=parent.window.opener.parent.frames[0].document.applets[0].outvec_value.elementAt(1);
			}
	  // Commented By Nilu on 4-10-2004/10:0 VCF 04-243
		//	total=parent.frames[0].format_noobject(parseFloat(parent.frames[0].unformat_noobject(total))-parseFloat(parent.frames[0].unformat_noobject(faceval)));
		//	unforvalue=parent.frames[0].unformat_noobject(total);
		
			m_arrdata[pos]="";
			del=pos*2;
			passing_vals[del]="";
			passing_vals[del-1]="";
			lineno=lineno-1;
			parent.frames[1].m_table.innerHTML='<HTML><FORM NAME="Form1"><TABLE BORDER="0" BGCOLOR="darkblue" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
		  '<TR><TD  WIDTH="85%"><B STYLE="{color: white; font: bold 9pt arial;}">Inventory Selection</B></TD><TD  WIDTH="15%"><INPUT TYPE="button" VALUE="Proceed" ONCLICK=parent.frames[0].transfervals('+unforvalue+',('+lineno+'),"'+m_type+'") NAME="BUT_BCODE" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD></TR><SCRIPT language1.2="JavaScript" src="outrights_inv_details.js"></SCRIPT></TABLE>'+
	 	  '<TABLE BORDER="1" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}"><TR BGCOLOR="silver" ><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Security</TD><TD WIDTH="25%" STYLE="{text-align:center;}" ><B><FONT COLOR="black">Serial Number</TD><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Face Value</TD></FONT></B></TR>'+
			m_arrdata.join(" ")+'<TR><TD WIDTH="33%"></TD><TD WIDTH="33%" BGCOLOR="silver" STYLE="{text-align:center; color: black; font: bold 9pt arial;}">Total</TD><TD WIDTH="34%" STYLE="{text-align:right;}">'+total+'</TD></TR></TABLE></FORM><script language="JavaScript1.2" src="outrights_inv_details.js"></SCRIPT></HTML>';
	    
	}

}


function transfervals(val,pos,m_type){
	if  ( parent.window.opener.parent.frames[0].document.Form1.HID_DEAL_TYPE.value == 'EQUITY' ) {
			  parent.window.opener.parent.frames[0].document.Form1.HID_NO_SHARES.value= val;
				if(m_type=="SL"){//$$##SC
								parent.window.opener.parent.frames[1].document.Form1.TXT_SENOIDEN1.value="0";
								parent.window.opener.parent.frames[1].document.Form1.TXT_FACEVAL1.value=val;
								parent.window.opener.parent.frames[1].document.Form1.TXT_MISS1.value="0.00";
								parent.window.opener.parent.frames[1].document.Form1.TXT_SENOIDEN1.disabled=true;
					      parent.window.opener.parent.frames[1].document.Form1.TXT_SENOIDEN1.disabled=true;
								parent.window.opener.parent.frames[1].document.Form1.TXT_SENOIDEN1.disabled=true;
								parent.window.opener.parent.frames[1].document.Form1.HID_SCRIP_STAT.value="SL";
				     }
		 top.close();

			}
		else{
	
	if (unformat_noobject(parent.window.opener.parent.frames[0].document.Form1.TXT_FACEVAL.value) == val){
	actualpos=pos*2;
	//parent.window.opener.parent.frames[0].document.Form1.HID_TEST.value=parent.frames[0].format_noobject(val);
	//parent.window.opener.parent.frames[0].document.Form1.TXT_FACEVAL.value=parent.frames[0].format_noobject(val);
  parent.window.opener.parent.frames[1].document.Form1.TXT_TOTVAL.value=parent.frames[0].format_noobject(val);
	parent.window.opener.parent.frames[1].document.Form1.TXT_TOTVAL.value=parent.frames[0].format_noobject(val);
	parent.window.opener.parent.frames[0].formatnum1(parent.window.opener.parent.frames[0].document.Form1.TXT_FACEVAL);
	if (passing_vals[1]!=""){
	parent.window.opener.parent.frames[1].document.Form1.TXT_FACEVAL1.value=passing_vals[1];
	parent.window.opener.parent.frames[1].document.Form1.TXT_SENOIDEN1.value=passing_vals[2];
	if(m_type=="SL"){//$$##SC
			 m_writedataNN ='<TD WIDTH="40%" STYLE="{color: black; font: bold 9pt arial;}">'+
				'<B>Yield</B></TD>'; 
				parent.window.opener.parent.frames[1].scrname.innerHTML=m_writedataNN;
		    parent.window.opener.parent.frames[1].document.Form1.HID_SCRIP_STAT.value="SL";
		    parent.window.opener.parent.frames[1].document.Form1.TXT_FACEVAL1.disabled=true;
	      parent.window.opener.parent.frames[1].document.Form1.TXT_SENOIDEN1.disabled=true;
		}else{
		    parent.window.opener.parent.frames[1].document.Form1.TXT_FACEVAL1.disabled=false;
	      parent.window.opener.parent.frames[1].document.Form1.TXT_SENOIDEN1.disabled=false;
		}
    //--------------------
	parent.window.opener.parent.frames[1].tranfaceval();
	}
	while (actualpos>serialno){
	if (passing_vals[serialno]!=""){
	parent.window.opener.parent.frames[1].newpart2();
	mt_sno="TXT_SENOIDEN"+n;
	VAL_SNO=parent.window.opener.parent.frames[1].document.Form1.elements[mt_sno];
	mt_face="TXT_FACEVAL"+d;
	VAL_FACE=parent.window.opener.parent.frames[1].document.Form1.elements[mt_face];
 	VAL_FACE.value=passing_vals[serialno];
	VAL_SNO.value=passing_vals[serialno+1];
	      if(m_type=="SL"){//$$##SC
		     	m_writedataNN ='<TD WIDTH="40%" STYLE="{color: black; font: bold 9pt arial;}">'+
				     '<B>Yield</B></TD>'; 
				  parent.window.opener.parent.frames[1].scrname.innerHTML=m_writedataNN;
					parent.window.opener.parent.frames[1].document.Form1.HID_SCRIP_STAT.value="SL";
		      VAL_FACE.disabled=true;
			    VAL_SNO.disabled=true;
		   
				}else{
				  VAL_FACE.disabled=false;
			    VAL_SNO.disabled=false;
				}
	      //----------------------------
	parent.window.opener.parent.frames[1].tranfaceval2();
	n=n+1;
	d=d+1;
  }
	else{
	actualpos=actualpos+2;
	}
  serialno=serialno+2;
	}	
top.close();
}
else{
alert('Face Value does not match the Original')
top.close();

}

for (var i = 0; i< parent.window.opener.parent.frames[0].document.Form1.elements.length; i++) {
  parent.window.opener.parent.frames[0].document.Form1.elements[i].disabled = true;
}

if(m_type=="SL"){//$$##SC
	 parent.window.opener.parent.frames[0].document.Form1.BUT_INV.disabled = true
	 parent.window.opener.parent.frames[0].document.Form1.BUT_INV_SL.disabled = false;
	
	}else{
	 parent.window.opener.parent.frames[0].document.Form1.BUT_INV.disabled = false;
	 parent.window.opener.parent.frames[0].document.Form1.BUT_INV_SL.disabled = true;
	
	}
	//-----------------------
 parent.window.opener.parent.frames[0].document.Form1.BUT_INV.disabled = false;
 parent.window.opener.parent.frames[0].document.Form1.BUT_INV.focus();
	
	
	
	}

	//parent.window.opener.top.frames[0].document.Form2.save_but.disabled = false;
	// parent.window.opener.top.frames[0].document.Form2.save_but.focus();
	// parent.window.opener.parent.frames[0].document.Form1.BUT_INV.focus();
//

}



//----------------------------------- Repo Inventory ---------------------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



function displayrepoinv(port,instype){
	m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'fvalblsecout?port_code='+port.toUpperCase()+'&inst_code='+instype.toUpperCase()+'&chksql=repofreshinv_details';
	m_url_main='dn_F_Outrights_inventory_frame.html';
	popupwin = window.open(m_url_main,'displayWindow1','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
  popupwin.focus();
	popupwin.parent.frames[0].location.href=m_url;
}

function display_select_repo(){
  m_selectdata=document.Form2.select_info.value;
	alert(m_selectdata);
	// selected_inventory m_url=servlet_client_url+':'+client_t3_port+'/fval_blsecout?port_code='+port.toUpperCase()+'&inst_code='+instype.toUpperCase()+'&chksql=repofreshinv_details';
	m_url_select='dn_repo_inventory_select.html';
	popupwin2 = window.open(m_url_select,'displayWindow2','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
  popupwin2.focus();
	//popupwin.location.href=m_selectdata.innerHTML;
	//popupwin.location.href=
	popupwin2.selected_inventory.innerHTML=m_selectdata;
	
	popupwin2.selected_inventory.innerHTML='<TABLE BORDER="0" BGCOLOR="darkblue" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
			'<TR><TD WIDTH="85%"><B STYLE="{color: white; font: bold 9pt arial;}">Inventory Selection</B></TD><TD  WIDTH="15%"><INPUT TYPE="button" VALUE="Proceed" NAME="BUT_BCODE" ONCLICK="parent.frames[0].repo_transfervals('+unforvalue+',('+pos+'))" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD></TR><SCRIPT language1.2="JavaScript" src="outrights_inv_details.js"></SCRIPT></TABLE>'+
	  	'<TABLE BORDER="1" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}"><TR BGCOLOR="silver" ><TD WIDTH="15%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Type</TD><TD WIDTH="30%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Security</TD><TD WIDTH="25%" STYLE="{text-align:center;}" ><B><FONT COLOR="black">Serial Number</TD><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Face Value</TD></FONT></FONT></B></TR>'+
			m_selectdata.join(" ")+'<TR><TD></TD><TD></TD><TD BGCOLOR="silver" STYLE="{text-align:center; color: black; font: bold 9pt arial;}">Total</TD><TD STYLE="{text-align:right;}">'+total+'</TD></TR></TABLE>';

	//alert(document.Form2.select_info.value);
}


function display_reposelect(seccode,serialno,faceval,invtype,pos,noforval) {
	//alert('inside');
	m_row=1;
 	inputname="SEL"+pos;
	h_payamtobj=parent.frames[0].document.Form1.elements[inputname];
  if (h_payamtobj.checked==true) {
			total=parent.frames[0].format_noobject(parseFloat(parent.frames[0].unformat_noobject(total))+parseFloat(parent.frames[0].unformat_noobject(faceval)));
			unforvalue=parent.frames[0].unformat_noobject(total);
			m_writedata='<TR><TD WIDTH="15%" STYLE="{text-align:center;}">'+invtype+'</TD><TD WIDTH="25%" STYLE="{cursor: hand; font: 9pt arial; text-align:center;}">'+seccode+'</TD><TD WIDTH="25%" STYLE="{cursor: hand; font: 9pt arial; text-align:center;}">'+serialno+'</TD><TD WIDTH="25%" STYLE="{text-align:right;}">'+faceval+'</TD></TR>';
  		//'<TR><TD></TD><TD STYLE="{text-align:center;}"><B><FONT COLOR="black">Total</TD><TD STYLE="{text-align:right;}">'+faceval+'</TD></TR>';
			//m_url=servlet_client_url+':'+client_t3_port+'/fval_blsecout?sec_code='+seccode.toUpperCase()+'&serial_code='+serialno.toUpperCase()+'&facevalue='+faceval+'&m_rowno='+row_no+'&chksql=invdetailselected';
			m_url="outrights_selected.html"
			//popupwin1 = window.open(m_url,'displayWindow2','left=0,top=0,width=500,height=200,toolbar=0,location=0,left=150,top=320,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			//popupwin1.focus();
			//parent.frames[1].m_table.innerHTML=parent.frames[1].m_table.innerHTML+m_writedata;
			m_arrdata[pos]=m_writedata;
			repo_pass_vals[i]=(faceval);
			repo_pass_vals[i+1]=(seccode);			
			parent.frames[1].m_table.innerHTML='<TABLE BORDER="0" BGCOLOR="darkblue" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
			'<TR><TD WIDTH="85%"><B STYLE="{color: white; font: bold 9pt arial;}">Inventory Selection</B></TD><TD  WIDTH="15%"><INPUT TYPE="button" VALUE="Proceed" NAME="BUT_BCODE" ONCLICK="parent.frames[0].repo_transfervals('+unforvalue+',('+pos+'))" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD></TR><SCRIPT language1.2="JavaScript" src="outrights_inv_details.js"></SCRIPT></TABLE>'+
	  	'<TABLE BORDER="1" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}"><TR BGCOLOR="silver" ><TD WIDTH="15%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Type</TD><TD WIDTH="30%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Security</TD><TD WIDTH="25%" STYLE="{text-align:center;}" ><B><FONT COLOR="black">Serial Number</TD><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Face Value</TD></FONT></FONT></B></TR>'+
			m_arrdata.join(" ")+'<TR><TD></TD><TD></TD><TD BGCOLOR="silver" STYLE="{text-align:center; color: black; font: bold 9pt arial;}">Total</TD><TD STYLE="{text-align:right;}">'+total+'</TD></TR></TABLE>';
		  lineno=lineno+1;
		  i=i+2;
}
	else {
			total=parent.frames[0].format_noobject(parseFloat(parent.frames[0].unformat_noobject(total))-parseFloat(parent.frames[0].unformat_noobject(faceval)));
			unforvalue=parent.frames[0].unformat_noobject(total);
		  m_arrdata[pos]="";
			del=pos*2;
			repo_pass_vals[del]="";
			repo_pass_vals[del-1]="";
			parent.frames[1].m_table.innerHTML='<TABLE BORDER="0" BGCOLOR="darkblue" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}">'+
		  '<TR><TD  WIDTH="85%"><B STYLE="{color: white; font: bold 9pt arial;}">Inventory Selection</B></TD><TD  WIDTH="15%"><INPUT TYPE="button" VALUE="Proceed" NAME="BUT_BCODE" ONCLICK="parent.frames[0].repo_transfervals('+unforvalue+',('+pos+'))" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD></TR><SCRIPT language1.2="JavaScript" src="outrights_inv_details.js"></SCRIPT></TABLE>'+
	 		'<TABLE BORDER="1" WIDTH="100%" STYLE="{cursor: hand; font: 9pt arial;}"><TR BGCOLOR="silver" ><TD WIDTH="15%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Type</TD><TD WIDTH="30%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Security</TD><TD WIDTH="25%" STYLE="{text-align:center;}" ><B><FONT COLOR="black">Serial Number</TD><TD WIDTH="25%" STYLE="{text-align:center;}"><B><FONT COLOR="black">Face Value</TD></FONT></FONT></B></TR>'+
	  	m_arrdata.join(" ")+'<TR><TD></TD><TD></TD><TD BGCOLOR="silver" STYLE="{text-align:center; color: black; font: bold 9pt arial;}">Total</TD><TD STYLE="{text-align:right;}">'+total+'</TD></TR></TABLE>';
		 lineno=lineno-1;
		}
 }
 
	
function repo_transfervals(val,pos){
	alert(repo_pass_vals);
	actualpos=pos*2;
	if (repo_pass_vals[1]!=""){
	parent.window.opener.parent.frames[1].document.Form2.Text_face_value1.value=repo_pass_vals[1];
	parent.window.opener.parent.frames[1].document.Form2.Text_security1.value=repo_pass_vals[2];
	parent.window.opener.parent.frames[1].calculate_facevalue(parent.window.opener.parent.frames[1].document.Form2.Text_security1,parent.window.opener.parent.frames[0].document.Form1.H_hair_cut1,parent.window.opener.parent.frames[0].document.Form1.HID_VALDATE,parent.window.opener.parent.frames[1].document.Form2.Text_face_value1,parent.window.opener.parent.frames[1].document.Form2.Text_hair_cut1);
	}
	while (actualpos>serialno){
	if (repo_pass_vals[serialno]!=""){
	parent.window.opener.parent.frames[1].dynomic_textbox();
	mt_sno="Text_security"+n;
	VAL_SECNO=parent.window.opener.parent.frames[1].document.Form2.elements[mt_sno];
	
	mt_face="Text_face_value"+d;
	VAL_FACE=parent.window.opener.parent.frames[1].document.Form2.elements[mt_face];
 	
	mt_hcut="Text_hair_cut"+d;
	HAIR_CUT=parent.window.opener.parent.frames[1].document.Form2.elements[mt_hcut];
  
	VAL_FACE.value=repo_pass_vals[serialno];
	VAL_SECNO.value=repo_pass_vals[serialno+1];
	
	
	parent.window.opener.parent.frames[1].calculate_facevalue(VAL_SECNO,parent.window.opener.parent.frames[0].document.Form1.H_hair_cut1,parent.window.opener.parent.frames[0].document.Form1.HID_VALDATE,VAL_FACE,HAIR_CUT);
 	
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
	
	
