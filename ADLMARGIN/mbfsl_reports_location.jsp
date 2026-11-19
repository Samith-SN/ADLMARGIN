<%@page import="net.sasianet.ADLMARGIN.*" %>
<%	
	
	ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
	String m_jsp_client_url=m_sn_methods.jsp_client_url;
	//***************  ADDED BY KANISHKA ON 26/12/2012  *********************//
	
		Object done = (String)session.getValue("logon.isDone");  // marker object
		if (done == null) {
			response.sendRedirect("login.jsp");
			return;
			}
	
	//*************** ADDED BY KANISHKA ON 26/12/2012 [END]  *********************//
	String current_user=m_sn_methods.username; 
	
	out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
	out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/redmond/jquery-ui.css' TYPE=\"text/css\">");
	
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/i18n/grid.locale-en.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/jquery.jqGrid.min.js\"></script>");
	out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\""+m_jsp_client_url+"/css/ui.jqgrid.css\" />");
	
	
	
%>

<HTML>
	<HEAD>
		<TITLE>MFactor</TITLE>
		
	</HEAD>
	<SCRIPT language="JavaScript">
		var very;
		
		
		/*function invcheck(objx){
		if (objx.value=='Outrights' || objx.value=='Repo'||objx.value=='B / L Securities') {
		}
		else{
		inv_help(objx);
		objx.focus();
		}
		} 
		function inv_help(obj1) {
		m_row="";
		m_1='Outrights';
		m_2='Outrights Inventory';
		m_3='Repo';
		m_4='Repo Inventory';
		m_5='B / L Securities';
		m_6='B / L Securities Inventory';
	

		m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE1 BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE1); ONMOUSEOUT=mouseout_setings(LINE1); onClick=close_help(C1R1); ><TD ID=C1R1><B>'+m_1+'</B></TD><TD ID=C2R1><B>'+m_2+'</B></TD></TR>'+
    '<TR STYLE="{color: black; cursor:hand}" ID=LINE2 BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE2); ONMOUSEOUT=mouseout_setings(LINE2); onClick=close_help(C1R2); ><TD ID=C1R2><B>'+m_3+'</B></TD><TD ID=C2R2><B>'+m_4+'</B></TD></TR>'+	
		'<TR STYLE="{color: black; cursor:hand}" ID=LINE3 BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE3); ONMOUSEOUT=mouseout_setings(LINE3); onClick=close_help(C1R3); ><TD ID=C1R3><B>'+m_5+'</B></TD><TD ID=C2R3><B>'+m_5+'</B></TD></TR>';
		
		m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color: white; font: 9pt arial;}">'+
		'<TR BGCOLOR="darkblue"><TD WIDTH="30%"><B>Inventory Type</B></TD>' +
		'<TD WIDTH="70%"><B>Inventory</B></TD></TR>'+
		m_row+
		'</TABLE>'; 
		myDialogObj.htmlstr = m_writedata;
		myDialogObj.returnval = "";
		
		popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		obj1.value=myDialogObj.returnval;
		obj1.focus();			
		}	
		
		
		
	function port_help(obj1) { 
	  
		m_criteria = document.Form1.TXT_CLIENT.value+"@";
	   HelpBox('1','10','0');
		m_buycode=obj1.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalwizard4?buyer_code="+m_buycode.toUpperCase()+"&chksql=port_lookup";
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
		'<TR BGCOLOR="darkblue"><TD WIDTH="30%"><B>Portfolio Code</B></TD>' +
		'<TD WIDTH="70%"><B>Portfolio Name</B></TD></TR>'+
		m_row+
		'</TABLE>'; 
		myDialogObj.htmlstr = m_writedata;
		myDialogObj.returnval = "";
		
		popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
		obj1.value=myDialogObj.returnval;
		obj1.focus();	
		}
		
		
	/*	
	function MyDialog(){
	 	 this.valout   = new Array(10);
	 		}		
		
		 function loc_help(){
		 document.Form1.hid_help_type.value="1";
	   m_sql = "m_locationsql";
	   m_criteria = document.Form1.TXT_CLIENT.value+"@";
	   HelpBox('1','10','0');
	  }
	 
		function HelpBox(Start,End,Hid_No) {
		oBj = new MyDialog();
	  oBj.valout[1]  = " ";
		oBj.valout[2]  = " ";
		oBj.valout[3]  = " ";
		popupwin = window.showModalDialog(""+servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_fund_Help_Servlet?class_in="+client_name+"mbfsl_fund_help_select"+
									"&Sql_in="+m_sql+"&Start_in="+Start+
									"&End_in="+End+"&Crit_In="+m_criteria+
									"&Hid_No="+Hid_No+"", oBj,"dialogWidth:25em; dialogHeight:18em; center:yes;  status:no");
									
	
	
if(document.Form1.hid_help_type.value=="1"){
		  if(oBj.valout[1] !=" "){
		     if(oBj.valout[1] !='Close'){
			     if(oBj.valout[1]!="Prev"){
				      if(oBj.valout[1]!="Next"){
				      // alert("uu");
								asign_port_code();
		          }
		          else{//alert("HI");
							     //alert("hi"+oBj.valout[2]+"hi"+oBj.valout[3]);
		            Next(oBj.valout[2],oBj.valout[3],Hid_No);
		 	          return false;
		          } 
	         }
	         else{
		         Prev(oBj.valout[2],oBj.valout[3],Hid_No);
	         }	
         }		
         else{	
	         document.Form1.TXT_CLIENT.value="";	
         }		
    }
    else{		
	    document.Form1.TXT_CLIENT.value="";	
    }		
 }

	}
	
function Prev(Start,End,Hid_No){
	 HelpBox(Start,End,Hid_No)
}
function Next (Start,End,Hid_No){
	 HelpBox(Start,End,Hid_No)
}
	
	function asign_port_code() {	
	 document.Form1.TXT_CLIENT.value=oBj.valout[2];
	}
			*/
		
		
		function snumber(objx){
			if (document.Form1.INV_TYPE.value=='Outrights'){
				if (objx.value!="") {
					m_sno=objx.value;
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalwizard4?s_number="+m_sno.toUpperCase()+"&chksql=chksno_out";
					top.frames[0].document.applets[0].getdata(m_url);
					m_size=top.frames[0].document.applets[0].outvec_value.size();
					if (m_size==0) {
						sno_help(objx);
						objx.focus();
					}
				}
			}
			if (document.Form1.INV_TYPE.value=='Repo'){
				if (objx.value!="") {
					m_sno=objx.value;
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalwizard4?s_number="+m_sno.toUpperCase()+"&chksql=chksno_repo";
					top.frames[0].document.applets[0].getdata(m_url);
					m_size=top.frames[0].document.applets[0].outvec_value.size();
					if (m_size==0) {
						sno_help(objx);
						objx.focus();
					}
				}
			}
			if (document.Form1.INV_TYPE.value=='B / L Securities'){
				if (objx.value!="") {
					m_sno=objx.value;
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalwizard4?s_number="+m_sno.toUpperCase()+"&chksql=chksno_bl";
					top.frames[0].document.applets[0].getdata(m_url);
					m_size=top.frames[0].document.applets[0].outvec_value.size();
					if (m_size==0) {
						sno_help(objx);
						objx.focus();
					}
				}
			}
		}
		
		function sno_help(obj1) {
			if (document.Form1.INV_TYPE.value=='Outrights'){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalwizard4?chksql=sno_out_lookup";
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
					'<TR BGCOLOR="darkblue"><TD WIDTH="60%"><B>Serial No</B></TD>' +
					'<TD WIDTH="40%"><B>Face Value</B></TD></TR>'+
					m_row+
					'</TABLE>'; 
				myDialogObj.htmlstr = m_writedata;
				myDialogObj.returnval = "";
				
				popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
				obj1.value=myDialogObj.returnval;
				obj1.focus();			
			}
			if (document.Form1.INV_TYPE.value=='Repo'){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalwizard4?chksql=sno_repo_lookup";
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
					'<TR BGCOLOR="darkblue"><TD WIDTH="60%"><B>Serial No</B></TD>' +
					'<TD WIDTH="40%"><B>Face Value</B></TD></TR>'+
					m_row+
					'</TABLE>'; 
				myDialogObj.htmlstr = m_writedata;
				myDialogObj.returnval = "";
				
				popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
				obj1.value=myDialogObj.returnval;
				obj1.focus();			
			}
			if (document.Form1.INV_TYPE.value=='B / L Securities'){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalwizard4?chksql=sno_bl_lookup";
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
					'<TR BGCOLOR="darkblue"><TD WIDTH="60%"><B>Serial No</B></TD>' +
					'<TD WIDTH="40%"><B>Face Value</B></TD></TR>'+
					m_row+
					'</TABLE>'; 
				myDialogObj.htmlstr = m_writedata;
				myDialogObj.returnval = "";
				
				popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
				obj1.value=myDialogObj.returnval;
				obj1.focus();			
			}
		}	
		
		
		function display_more2(m_portcode,m_invtype,m_seccode,m_serialno,m_dealno) {
			m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'bvalwizard4?invtype='+m_invtype+'&seccode='+m_seccode+'&dealno='+m_dealno+'&serialno='+m_serialno+'&portcode='+m_portcode+'&chksql=moredata1';
			popupwin = window.open(m_url,'displayWindow1','left=0,top=0,width=375,height=470,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			popupwin.focus();
		}
		
		function myDialogObj() {
			var htmlstr;
			var returnval;
		}
		
		
		function displaydata(port,instype,seccode,sno){
			if(sno=="" && seccode=="" && instype!="" && port!="" ){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"binvreports?inv_type="+document.Form1.INV_TYPE.value+"&port_code="+port.toUpperCase()+"&inst_code="+instype.toUpperCase()+"&chksql=data2";
				popupwin2 = window.open(m_url,'displayWindow2','left=0,top=150,width=799,height=375,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
				popupwin2.focus();
			}
			if(sno=="" && instype=="" && seccode=="" && port!=""){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"binvreports?inv_type="+document.Form1.INV_TYPE.value+"&port_code="+port.toUpperCase()+"&chksql=data3";
				popupwin2 = window.open(m_url,'displayWindow2','left=0,top=150,width=799,height=375,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
				popupwin2.focus();
			}
			if(sno=="" && instype=="" && seccode=="" && port==""){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"binvreports?inv_type="+document.Form1.INV_TYPE.value+"&chksql=data4";
				popupwin2 = window.open(m_url,'displayWindow2','left=0,top=150,width=799,height=375,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
				popupwin2.focus();
			}
			if(sno=="" && instype!="" && seccode!="" && port!=""){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"binvreports?inv_type="+document.Form1.INV_TYPE.value+"&port_code="+port.toUpperCase()+"&inst_code="+instype.toUpperCase()+"&seccode="+seccode+"&chksql=data1";
				popupwin2 = window.open(m_url,'displayWindow2','left=0,top=150,width=799,height=375,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
				popupwin2.focus();
			}
			if(sno!="" && instype!="" && seccode!="" && port!=""){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"binvreports?snumber="+sno+"&inv_type="+document.Form1.INV_TYPE.value+"&port_code="+port.toUpperCase()+"&inst_code="+instype.toUpperCase()+"&seccode="+seccode+"&chksql=data";
				popupwin2 = window.open(m_url,'displayWindow2','left=0,top=150,width=799,height=375,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
				popupwin2.focus();
			}
			if(sno!="" && instype=="" && seccode=="" && port==""){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"binvreports?snumber="+sno+"&inv_type="+document.Form1.INV_TYPE.value+"&chksql=data5";
				popupwin2 = window.open(m_url,'displayWindow2','left=0,top=150,width=799,height=375,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
				popupwin2.focus();
			}
		}
		
		function chkstartdate(dayobj,monthobj,yearobj) {
			if (checkMonthLength(dayobj,monthobj,yearobj)) {
			}
		}
		
		
		function portcheck(objx,objy){
			if ((objx.value!="")&&(objy.value!="")) {
				m_portcode=objx.value;
				m_inv_type=objy.value;
				m_url=servlet_client_url+":"+client_t3_port+"	mbfsl_reports_location?loc_code="+m_portcode.toUpperCase()+"&inv_type="+m_inv_type.toUpperCase()+"&chksql=chkport";
				popupwin2 = window.open(m_url,'displayWindow2','left=0,top=150,width=799,height=375,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
				popupwin2.focus();
				
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				//if (m_size==0) {
				//port_help(objx,objy);
				//objx.focus();
			}
		}
		
		function port_help(obj1) {
			m_buycode=obj1.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalwizard4?buyer_code="+m_buycode.toUpperCase()+"&chksql=port_lookup";
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
				'<TR BGCOLOR="darkblue"><TD WIDTH="30%"><B>Portfolio Code</B></TD>' +
				'<TD WIDTH="70%"><B>Portfolio Name</B></TD></TR>'+
				m_row+
				'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval = "";
			
			popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
			obj1.value=myDialogObj.returnval;
			obj1.focus();			
		}	
		
		
		
		function insttype(objx){
			if (objx.value!="") {
				m_instcode=objx.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalwizard4?inst_code="+m_instcode.toUpperCase()+"&chksql=chkinst";
				top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				if (m_size==0) {
					inst_help(objx);
					objx.focus();
				}
			}
		}
		
		function inst_help(obj1) {
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalwizard4?chksql=inst_lookup";
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
				'<TR BGCOLOR="darkblue"><TD WIDTH="30%"><B>Instrument Type</B></TD>' +
				'<TD WIDTH="70%"><B>Instrument</B></TD></TR>'+
				m_row+
				'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval = "";
			
			popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
			obj1.value=myDialogObj.returnval;
			obj1.focus();			
		}	
		
		
		
		function seccode(objx){
			if (objx.value!="") {
				m_portcode=objx.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalwizard4?sec_code="+m_portcode.toUpperCase()+"&chksql=chksec";
				top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				if (m_size==0) {
					sec_help(objx);
					objx.focus();
				}
			}
		}
		
		function sec_help(obj1) {
			if(document.Form1.TXT_ITYPE.value==""){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalwizard4?chksql=sec_lookup";
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
					'<TR BGCOLOR="darkblue"><TD WIDTH="60%"><B>Security</B></TD>' +
					'<TD WIDTH="40%"><B>Instrument</B></TD></TR>'+
					m_row+
					'</TABLE>'; 
				myDialogObj.htmlstr = m_writedata;
				myDialogObj.returnval = "";
				
				popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
				obj1.value=myDialogObj.returnval;
				obj1.focus();			
			}
			else{
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalwizard4?inst_code="+document.Form1.TXT_ITYPE.value+"&chksql=sec_lookup2";
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
					'<TR BGCOLOR="darkblue"><TD WIDTH="60%"><B>Security</B></TD>' +
					'<TD WIDTH="40%"><B>Instrument</B></TD></TR>'+
					m_row+
					'</TABLE>'; 
				myDialogObj.htmlstr = m_writedata;
				myDialogObj.returnval = "";
				
				popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
				obj1.value=myDialogObj.returnval;
				obj1.focus();			
				
			}
		}	
		
		function default_actions() {	
			setInterval("set_timer_actions()", 120000);
		}			
		
		
		function set_timer_actions() {	
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalwizard4?chksql=idle";
			top.frames[0].document.applets[0].getdata(m_url);
		}
		
		
		function add_data() {
			var num;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalwizard4?chksql=dealrevary";
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
			vec_pos=0;
			lineno=1;
			m_row="";
			if (m_size==0) {
				alert('No Previous Vouchers..Press the OK button if you want to type again or Press the Cancel button to Exit');
			}
			else{
				while (vec_pos<m_size) {
					if(parseFloat(top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2))>=parseFloat(top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+3))){
						num=format_noobject(top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2));
					}
					else{
						num=format_noobject(top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+3));
					}
					m_row=m_row+'<TR BGCOLOR="silver" >';
					m_row=m_row+'<TD ALIGN="Center" STYLE="{color: black; font: 9pt arial;}">'+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos)+'<INPUT TYPE="Hidden" NAME="DEALNO'+lineno+'" VALUE="'+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos)+'"></TD>';
					m_row=m_row+'<TD ALIGN="Center" STYLE="{color: black; font: 9pt arial;}">'+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1)+'<INPUT TYPE="Hidden" NAME="DEALTYPE'+lineno+'" VALUE="'+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1)+'"></TD>';
					m_row=m_row+'<TD ALIGN="Right" STYLE="{color: black; font: 9pt arial;}">'+num+'<INPUT TYPE="Hidden" NAME="AMOUNT'+lineno+'" VALUE="'+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2)+'"></TD>';
					m_row=m_row+'<TD ALIGN="Center" STYLE="{color: black; font: 9pt arial;}">'+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+4)+'<INPUT TYPE="Hidden" NAME="DEALER'+lineno+'" VALUE="'+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+3)+'"></TD>';
					m_row=m_row+'<TD ALIGN="Center" STYLE="{color: black; font: 9pt arial;}">'+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+5)+'<INPUT TYPE="Hidden" NAME="LIMITV'+lineno+'" VALUE="'+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+4)+'"></TD>';
					m_row=m_row+'<TD ALIGN="Center"><INPUT TYPE="button" VALUE="Details" NAME=DETAIL'+lineno+' STYLE="{cursor:hand; color: black; font: 8pt arial;}" ONCLICK=""></TD>';
					m_row=m_row+'<TD ALIGN="Center"><INPUT TYPE="checkbox" NAME=SEL'+lineno+' ONCLICK=""></TD></TR>';
					//m_row=m_row+'<TR><HR WIDTH="*%"></TR>';
					vec_pos=vec_pos+7;
					lineno=lineno+1;
				}
				document.Form1.Hid_rows.value=lineno;
				m_writedata ='<TABLE WIDTH="100%"BGCOLOR="silver" STYLE="{color: black; font: 10pt arial;}">'+
					'<TR BGCOLOR="darkgray">'+
					'<TD WIDTH="15%" ALIGN="Center"><B><FONT COLOR="black">Deal Number</B></TD>' +
					'<TD WIDTH="18%" ALIGN="Center"><B><FONT COLOR="black">Deal Type</B></TD>'+
					'<TD WIDTH="15%" ALIGN="Center"><B><FONT COLOR="black">Amount</B></TD>'+
					'<TD WIDTH="15%" ALIGN="Center"><B><FONT COLOR="black">Dealer</B></TD>'+
					'<TD WIDTH="15%" ALIGN="Center"><B><FONT COLOR="black">Limit Violations</B></TD>'+
					'<TD WIDTH="15%" ALIGN="Center"><B><FONT COLOR="black">Details</B></TD>'+
					'<TD WIDTH="7%" ALIGN="Center"><B><FONT COLOR="black">Select</B></TD></TR>' +
					m_row+
					'</TABLE>'; 
				clientmgr.innerHTML=m_writedata;	
			}
		}
		
		
		
		function port_help(obj1) {
			m_buycode=obj1.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalwizard4?buyer_code="+m_buycode.toUpperCase()+"&chksql=portcode_lookup";
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
			vec_pos=0;
			lineno=1;
			m_row="";
			while (vec_pos<m_size) {
				m_issu_code=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
				//m_issu_name=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
				m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+'><B>'+m_issu_code+'</B></TD></TR>';
				vec_pos=vec_pos+1;
				lineno=lineno+1;
			}
			m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color: white; font: 9pt arial;}">'+
				'<TR BGCOLOR="darkblue"><TD WIDTH="40%"><B>Location Code</B></TD>' +
				'<!--TD WIDTH="70%"><B>Description</B></TD--></TR>'+
				m_row+
				'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval = "";
			
			popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
			obj1.value=myDialogObj.returnval;
			obj1.focus();			
		}	
		
		function portcheck(objx){
			m_portcode=objx.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalwizard4?loc_code="+m_portcode.toUpperCase()+"&chksql=chkport_code";
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
			if (m_size>0) {
			}
			else{
				if(confirm("Invalid Location Code.press OK to get the Help or press CANCEL to type again.")){
					loc_help(objx);
				}
				else{
					document.Form1.TXT_PCODE.value=""
				}
			}
		}	
		function displaydata(){
			if(document.Form1.INV_TYPE.value=="OR"){
				if(document.Form1.TXT_PCODE.value==""){
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_reports_location?&chksql=chkport_oor";
				}
				else{
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_reports_location?&loc_code="+document.Form1.TXT_PCODE.value.toUpperCase()+"&chksql=chkport_or";
				}   
				popupwin2 = window.open(m_url,'displayWindow2','left=0,top=133,width=799,height=380,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
				popupwin2.focus();
			} 
			else if(document.Form1.INV_TYPE.value=="RP"){
				if(document.Form1.TXT_PCODE.value==""){
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_reports_location?&chksql=chkport_rrp";
				}
				else{
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_reports_location?&loc_code="+document.Form1.TXT_PCODE.value.toUpperCase()+"&chksql=chkport_rp";
				}
				popupwin2 = window.open(m_url,'displayWindow2','left=0,top=133,width=799,height=380,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
				popupwin2.focus();
			}
			else if(document.Form1.INV_TYPE.value=="BL"){
				if(document.Form1.TXT_PCODE.value==""){
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_reports_location?&chksql=chkport_bbl";
				}
				else{
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_reports_location?&loc_code="+document.Form1.TXT_PCODE.value.toUpperCase()+"&chksql=chkport_bl";
				}
				popupwin2 = window.open(m_url,'displayWindow2','left=0,top=133,width=799,height=380,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
				popupwin2.focus();
			}
		}	
		function myDialogObj() {
			var htmlstr;
			var returnval;
		}
		function change_head(){
			if(document.Form1.INV_TYPE.value=="OR"){
				m_writedata ='<TD WIDTH="50%" STYLE="{color: white ;font: bold 10pt arial;text-align:right;}"'+
					'<B>Reports - Inventory By Location-Outrights</B></TD>'; 
				parent.frames[0].scrname.innerHTML=m_writedata;	
			}	
			else if(document.Form1.INV_TYPE.value=="RP"){
				m_writedata ='<TD WIDTH="50%" STYLE="{color: white ;font: bold 10pt arial;text-align:right;}"'+
					'<B>Reports - Inventory By Location-Repo</B></TD>'; 
				parent.frames[0].scrname.innerHTML=m_writedata;	
			}	
			else if(document.Form1.INV_TYPE.value=="BL"){
				m_writedata ='<TD WIDTH="50%" STYLE="{color: white ;font: bold 10pt arial;text-align:right;}"'+
					'<B>Reports - Inventory By Location-B/L Securities</B></TD>'; 
				parent.frames[0].scrname.innerHTML=m_writedata;	
			}	
		}	
		
		
		function MyDialog(){
			this.valout   = new Array(10);
		}		
		/*
		
		function port_help1(obj2)
		{
			
			document.Form1.hid_help_type.value="1";
			m_sql = "m_locationsql";
			
			m_criteria = document.Form1.TXT_PCODE.value+"@";
			HelpBox('1','10','0');
		}	
		
		function HelpBox(Start,End,Hid_No) {
			oBj = new MyDialog();
			oBj.valout[1]  = " ";
			oBj.valout[2]  = " ";
			oBj.valout[3]  = " ";
			popupwin = window.showModalDialog(""+servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_fund_Help_Servlet?class_in="+client_name+"mbfsl_fund_help_select"+
				"&Sql_in="+m_sql+"&Start_in="+Start+
					"&End_in="+End+"&Crit_In="+m_criteria+
					"&Hid_No="+Hid_No+"", oBj,"dialogWidth:25em; dialogHeight:18em; center:yes;  status:no");
			
			
			
			if(document.Form1.hid_help_type.value=="1"){
				if(oBj.valout[1] !=" "){
					if(oBj.valout[1] !='Close'){
						if(oBj.valout[1]!="Prev"){
							if(oBj.valout[1]!="Next"){
								// alert("uu");
								asign_port_code();
							}
							else{//alert("HI");
								//alert("hi"+oBj.valout[2]+"hi"+oBj.valout[3]);
								Next(oBj.valout[2],oBj.valout[3],Hid_No);
								return false;
							} 
						}
						else{
							Prev(oBj.valout[2],oBj.valout[3],Hid_No);
						}	
					}		
					else{	
						document.Form1.TXT_PCODE.value="";	
					}		
				}
				else{		
					document.Form1.TXT_PCODE.value="";	
				}		
			}
			
		}
		
		function Prev(Start,End,Hid_No){
			HelpBox(Start,End,Hid_No)
		}
		function Next (Start,End,Hid_No){
			HelpBox(Start,End,Hid_No)
		}
		
		function asign_port_code() {	
			document.Form1.TXT_PCODE.value=oBj.valout[2];
		}
		
		*/
		
		function  exit()
		{
			window.location.href='<%=m_jsp_client_url%>/low.jsp';
			
		}
		function  cancel()
		{
			window.location.href='<%=m_jsp_client_url%>/mbfsl_reports_location.jsp';
			
		}
		
	/*
	$(document).ready(function() 
			{
				initCal('FROM_TXT_DATE');
				initCal('TO_TXT_DATE');
				
			});
	*/		
		/*
		function initCal(m_id) {
			$('#' + m_id).datepicker({
					dateFormat: 'dd-mm-yy',
					duration: 'fast',
					yearRange: '1920:2050',
					showOn: 'button',
					buttonImage: 'https://dev-adlmargin.sasianet.com:8443/ADLMARGIN/LBMARGIN/SNET/images/calendar.gif',
					buttonImageOnly: true,
					changeMonth: true,
					changeYear: true,
					onSelect: function(dateText, inst) {
						dateSelectFunc(dateText,inst);
					}
				});
		}
		
		function dateSelectFunc(dateText, inst) {
			var splitResult = dateText.split('-');
			var instance_id = inst.id;
			var m_last_index_of_underscore = instance_id.lastIndexOf('_');
			var first_part = instance_id.substr(0, m_last_index_of_underscore + 1);
			var second_part = instance_id.substr(m_last_index_of_underscore + 1);
			if (instance_id == "FROM_TXT_DATE") {
				document.Form1.TXT_DATE_FROM.value = splitResult[0];
				document.Form1.TXT_MONTH_FROM.value = splitResult[1];
				document.Form1.TXT_YEAR_FROM.value = splitResult[2];
				document.Form1.TXT_YEAR_FROM.focus();
			}
			if (instance_id == "TO_TXT_DATE") {
				document.Form1.TXT_DATE_TO.value = splitResult[0];
				document.Form1.TXT_MONTH_TO.value = splitResult[1];
				document.Form1.TXT_YEAR_TO.value = splitResult[2];
				document.Form1.TXT_YEAR_TO.focus();
			}
			
			
		}
		*/
		
		function port_help1(m_strat)
		{
			var aForm;    //  aForm =oForm.elements;
			aForm =  document.getElementById('Form1');
			
			var myObject=new Array(); //return values set to this object
			myObject[0]=aForm.TXT_PCODE; //2011-09-27
			//myObject[1]=aForm.Text_loc_desc;;
			myObject[1]=null;
			myObject[2]=null;
			myObject[3]=null;
			myObject[4]=null;
			
			var myObject_value=new Array(); //passing values set to this object
			//myObject_value[0]=aForm.TXT_UNAME.value; //2011-09-27
			myObject_value[0]=aForm.TXT_PCODE.value; //2011-09-27
			myObject_value[1]=null;//aForm.Text_loc_code.value;
			myObject_value[2]=null;
			myObject_value[3]=null; 
			
			myObject_value[4]=null;
			
			
			var myObject_type=new Array(); //passing values data type
			//myObject_type[0]="StringL";
			myObject_type[0]="StringL";
			//myObject_type[1]="StringL";
			myObject_type[1]=null;
			myObject_type[2]=null;
			myObject_type[3]=null;
			myObject_type[4]=null;
			
			
			var qid=99;
			
			//help_scr_type=document.Form1.SCR_TYPE;//2011-09-27
			
			
			title_name='Location';
			var url = 'popup.jsp';
			var close_fun='port_help_close';			
			var json_text = JSON.stringify(myObject_value, null,0);
			var json_obj_type_text=JSON.stringify(myObject_type, null,0);
			var fn_name=arguments.callee.name;
			if(fn_name==undefined)
			{
				re = /^function\s+([^(]+)/;
				fn_name=re.exec(arguments.callee.toString())[1];
			}
			
			$.showModalDialog({
					url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
					dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
					height:400,// 500,
					width: 500,//900,
					title: 'SasiNet Frame Work',
					scrollable: true,
					onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); 
						if(returnedValue != null){
							//
							//aForm.TXT_UNAME.focus();
						}
						if(returnedValue == null){
							port_help_close();
						} 
					} //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
		}
		
		function port_help_close()
		{
			document.Form1.TXT_PCODE.value="";
			
		}
		
		
		
		
	</SCRIPT>
	<BODY>
		<FORM NAME="Form1" id="Form1" METHOD="POST" >
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="reveryfication">
			<INPUT TYPE="Hidden" NAME="hid_help_type"	VALUE="">
			<TABLE WidTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0" STYLE="{color: black; font: bold 9pt arial;}">							
				<TD WidTH="1%">
					<TD WidTH="99%">
						
						<table width="100%">	
							<tr>
								<td>
									<table class='table' align='center' width="100%" border="0" cellpadding="0" cellspacing="0" >
										<!-- <table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 	-->
										<tr>
											<td height='7'></td>
										</tr>
										<tr height="30">		
											<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
											<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Management Information - Inventory By Location</B></td>
											<td width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>
										</tr>
									</table>
								</td>			
							</tr>
							<tr>
								<td>	
									<table class='table' align='center' width="99%" border="0" cellpadding="2" cellspacing="0" >
										<tr>
											<td width="40%">
											</td>	
											
											<td width="6%">
												<input type="button" value="Cancel" onclick="cancel()" class="mainbut">
											</td>	
											
											<td width="6%">
												<input type="button" value="Exit" onclick="exit()" class="mainbut">
											</td>
											<td width="*%">
											</td>	
											
										</tr>	
									</table>	
								</td>	
							</tr>	
							<tr>
								<td>
									<hr>
									
									
								</td>	
							</tr>	
							
							<tr>
								<td>			
									<TABLE WIDTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0" >
										<TR><BR></TR>
										<TR>	
											<TD WIDTH="12%">Inventory Type</TD>
											<TD WIDTH="23%">	 	
												<SELECT class="txt_input6" NAME="INV_TYPE" ONCHANGE="change_head()" >
													<OPTION VALUE="OR" SELECTED>Outrights</option> 
													<OPTION VALUE="RP">Repo</option>    
													<OPTION VALUE="BL">B/L Securities</option> 
												</SELECT>    
											</TD>  
											<TD WIDTH="12%">Location Code</TD>
											<TD WIDTH="25%">
												<INPUT TYPE="Text" class="txt_input6"  NAME="TXT_PCODE" ALIGN="LEFT" SIZE=15 MAXLENGTH=10 >
												<INPUT TYPE="button" class="mainbut" VALUE="Help" NAME="BUT_BCODE" ONCLICK="port_help1(0)" > <!-- port_help1(document.Form1.TXT_PCODE) -->
											</TD>
											<TD>
												
												<INPUT TYPE="button" class="mainbut" style="width:100px" value="Go" onclick="displaydata()">
											</TD>
										</TR>
										
									</TABLE>
								</td>	
							</tr>
							<tr>
								<td>	
									<TABLE width="100%" BORDER="0" CELLPADDING="2" CELLSPACING="1" STYLE="{color: yellow; font: bold 10pt sans-serif;}">
									</TABLE>
									<INPUT TYPE="Hidden" NAME="Hid_rows" >
									<DIV id=clientmgr></DIV>
								</td>
							</tr>
							
						</table>	
					</TD>
				</TD>
			</TABLE> 
			
		</FORM>
	</BODY>
	<DIV>
		<SCRIPT language1.2="JavaScript" src="validate.js"></SCRIPT>
	</DIV>
</html>

