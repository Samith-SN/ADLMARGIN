<%@page import="net.sasianet.ADLMARGIN.*" %>
<HTML>
	<HEAD>
		<TITLE>Margin Trading</TITLE>
		
		
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
			
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/redmond/jquery-ui.css' TYPE=\"text/css\">");
			
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
        out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
		
		
			
	    %>
	
	<SCRIPT language="JavaScript1.2">
    
   <!---------------------------------------------------------------------------------------------> 

	function myDialogObj() {
				var htmlstr; 
				var returnval;
	 }
 <!--------------------------------------------------------------------------------------------->
	function tax_mod_help() {
			m=document.Form1.Text_option.value;
			modi="ADD";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement1?chksql=tax_mod_help&taxcode="+document.Form1.Text_Repo_code.value+"&chksum="+modi+"";
		 	parent.frames[0].document.applets[0].getdata(m_url);
			m_size=0;
			m_size=parent.frames[0].document.applets[0].outvec_value.size();
			vec_pos=0;
      m_row="";
		  lineno=1;
			while (vec_pos<m_size) {
				m_tax_code=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
	  	  m_tax_desc=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1); 
			  m_rate=format_noobject(parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2));
				m_ent_date=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+3);
				m_new_rate=format_noobject(parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+4));
				m_effective_date=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+5);
				m_row=m_row+'<TR STYLE="{color:black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_tax_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_tax_desc+'</B></TD><TD ID=C3R'+	lineno+'><B>'+m_rate+'</B></TD><TD ID=C4R'+	lineno+'><B>'+m_ent_date+'</B></TD><TD ID=C5R'+	lineno+'><B>'+m_new_rate+'</B></TD><TD ID=C6R'+	lineno+'><B>'+m_effective_date+'</B></TD></TR>';
				vec_pos=vec_pos+9;
		    lineno=lineno+1;
			}
			
			m_writedata ='<TABLE BGCOLOR="siler" WIDTH="100%" STYLE="{color: darkblue; font: 9pt sans-serif;}">'+
		 '<TR BGCOLOR="silver"><TD WIDTH="12%"><B>Rate Code</B></TD>' +
		 '<TD WIDTH="33%"><B>Rate Description</B></TD>'+
		 '<TD WIDTH="10%"><B>Rate</B></TD>'+			
		 '<TD WIDTH="16%"><B>Ent Date</B></TD>'+	
		 '<TD WIDTH="12%"><B>New Rate</B></TD>'+
		 '<TD WIDTH="16%"><B>Effective Date</B></TD></TR>'+
		 m_row+
		 '</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
		 	myDialogObj.returnval = "";
	   	popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:35em; dialogHeight:20em; center:yes; resizable:yes; status:no"); 
					helpvalue=parent.frames[0].document.applets[0].outvec_value.indexOf(myDialogObj.returnval);
		 			if(helpvalue==-1){
						document.Form1.Text_Repo_code.disabled=false;
						document.Form1.Text_Repo_code.focus();
						}
					else {
							 
							document.Form1.Text_Repo_code.value=parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+0);
						//	document.Form1.Text_hair_cut.value=parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+1);
							document.Form1.Text_current_rate.value=format_noobject(parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+2));
		 					document.Form1.Text_new_rate.value=format_noobject(parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+4));
							
							document.Form1.Text_date1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+6);
		 					document.Form1.Text_month1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+7);
							document.Form1.Text_year1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+8);

							}
			document.Form1.Text_Repo_code.value=myDialogObj.returnval;
		  helpvalue=0;
			vec_pos=0;
		if (m=="UP"){
			if(document.Form1.Text_Repo_code.value==""){
						document.Form1.Text_Repo_code.disabled=false;
						document.Form1.Text_Repo_code.focus();
						}
			else {document.Form1.Text_Repo_code.disabled=true;}
  					
						document.Form1.Text_hair_cut.disabled=false;
						document.Form1.Text_current_rate.disabled=false;
						document.Form1.Text_new_rate.disabled=false;
						document.Form1.Text_date1.disabled=false;
						document.Form1.Text_month1.disabled=false;
						document.Form1.Text_year1.disabled=false;
			helpvalue=-1;
			}
		else if(m=="DEA"){
			document.Form1.Text_Repo_code.disabled=true;
			document.Form1.Text_hair_cut.disabled=true;
			document.Form1.Text_current_rate.disabled=true;
			document.Form1.Text_new_rate.disabled=true;
			document.Form1.Text_date1.disabled=true;
			document.Form1.Text_month1.disabled=true;
			document.Form1.Text_year1.disabled=true;
		}
		}
		
	 	<!-- END OF CURRENCY ADD HELP FUNCTION ------------------------------------  -->
		
<!-- START OF CURRENCY DEACTIVATING/REACTIVATING HELP FUNCTION ------------------------------------  -->
		
	function view_help(){
			modi="V";
			val=(document.Form1.Text_option.selectedIndex);
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement1?chksql=tax_view_help&taxcode="+document.Form1.Text_Repo_code.value+"&chksum="+modi+"";
		 	parent.frames[0].document.applets[0].getdata(m_url);
			m_size=0;
			m_size=parent.frames[0].document.applets[0].outvec_value.size();
			vec_pos=0;
      m_row="";
		  lineno=1;
			while (vec_pos<m_size) {
				m_tax_code=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
	  	  m_tax_desc=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1); 
			  m_rate=format_noobject(parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2));
				m_ent_date=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+3);
				m_new_rate=format_noobject(parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+4));
				m_effective_date=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+5);
				m_active_status=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+9);
				m_row=m_row+'<TR STYLE="{color:black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_tax_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_tax_desc+'</B></TD><TD ID=C3R'+	lineno+'><B>'+m_rate+'</B></TD><TD ID=C4R'+	lineno+'><B>'+m_ent_date+'</B></TD><TD ID=C5R'+	lineno+'><B>'+m_new_rate+'</B></TD><TD ID=C6R'+	lineno+'><B>'+m_effective_date+'</B></TD><TD ID=C7R'+	lineno+'><B>'+m_active_status+'</B></TD></TR>';
				vec_pos=vec_pos+10;
		    lineno=lineno+1;
			 }
			m_writedata ='<TABLE BGCOLOR="siler" WIDTH="100%" STYLE="{color: darkblue; font: 9pt sans-serif;text-align: center}">'+
		 '<TR BGCOLOR="silver"><TD WIDTH="12%"><B>Rate Code</B></TD>' +
		 '<TD WIDTH="37%"><B>Rate Description</B></TD>'+
		 '<TD WIDTH="10%"><B>Rate</B></TD>'+			
		 '<TD WIDTH="12%"><B>Ent Date</B></TD>'+	
		 '<TD WIDTH="12%"><B>New Rate</B></TD>'+
		 '<TD WIDTH="12%"><B>Effective Date</B></TD>'+
		 '<TD WIDTH="5%" STYLE="{text-align: center}"><B>Active</B></TD></TR>'+
			m_row+
		 '</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
		 	myDialogObj.returnval = "";
	   	popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:45em; dialogHeight:20em; center:yes; resizable:yes; status:no"); 
					helpvalue=parent.frames[0].document.applets[0].outvec_value.indexOf(myDialogObj.returnval);
		 			if(helpvalue==-1){}
			if (val==2 || val==3){
							document.Form1.Text_Repo_code.value=parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+0);
							document.Form1.Text_hair_cut.value=parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+1);
							document.Form1.Text_current_rate.value=format_noobject(parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+2));
		 					document.Form1.Text_new_rate.value=format_noobject(parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+4));
							
							document.Form1.Text_date1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+6);
		 					document.Form1.Text_month1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+7);
							document.Form1.Text_year1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+8);
			}
			helpvalue=0;
			vec_pos=0;
		}
	<!----------------------------------------------------------------------------------------------->
function tax_react__help() {
			modi="ADD";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement1?chksql=tax_react_help&taxcode="+document.Form1.Text_Repo_code.value+"&chksum="+modi+"";
		 	parent.frames[0].document.applets[0].getdata(m_url);
			m_size=0;
			m_size=parent.frames[0].document.applets[0].outvec_value.size();
			vec_pos=0;
      m_row="";
		  lineno=1;
			while (vec_pos<m_size) {
				m_tax_code=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
	  	  m_tax_desc=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1); 
			  m_rate=format_noobject(parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2));
				m_ent_date=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+3);
				m_new_rate=format_noobject(parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+4));
				m_effective_date=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+5);
				m_row=m_row+'<TR STYLE="{color:black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_tax_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_tax_desc+'</B></TD><TD ID=C3R'+	lineno+'><B>'+m_rate+'</B></TD><TD ID=C4R'+	lineno+'><B>'+m_ent_date+'</B></TD><TD ID=C5R'+	lineno+'><B>'+m_new_rate+'</B></TD><TD ID=C6R'+	lineno+'><B>'+m_effective_date+'</B></TD></TR>';
				vec_pos=vec_pos+9;
		    lineno=lineno+1;
			}
			
			m_writedata ='<TABLE BGCOLOR="siler" WIDTH="100%" STYLE="{color: darkblue; font: 9pt sans-serif;}">'+
		 '<TR BGCOLOR="silver"><TD WIDTH="12%"><B>Rate Code</B></TD>' +
		 '<TD WIDTH="35%"><B>Rate Description</B></TD>'+
		 '<TD WIDTH="10%"><B>Rate</B></TD>'+			
		 '<TD WIDTH="16%"><B>Ent Date</B></TD>'+	
		 '<TD WIDTH="10%"><B>New Rate</B></TD>'+
		 '<TD WIDTH="16%"><B>Effective Date</B></TD></TR>'+
		 m_row+
		 '</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
		 	myDialogObj.returnval = "";
	   	popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:35em; dialogHeight:20em; center:yes; resizable:yes; status:no"); 
					helpvalue=parent.frames[0].document.applets[0].outvec_value.indexOf(myDialogObj.returnval);
		 			if(helpvalue==-1){}
					else {
							 
							document.Form1.Text_Repo_code.value=parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+0);
							document.Form1.Text_hair_cut.value=parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+1);
							document.Form1.Text_current_rate.value=format_noobject(parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+2));
		 					document.Form1.Text_new_rate.value=format_noobject(parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+4));
							
							document.Form1.Text_date1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+6);
		 					document.Form1.Text_month1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+7);
							document.Form1.Text_year1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+8);

							}
			document.Form1.Text_Repo_code.value=myDialogObj.returnval;
		  helpvalue=0;
			vec_pos=0;
			
			document.Form1.Text_Repo_code.disabled=true;
			document.Form1.Text_hair_cut.disabled=true;
			document.Form1.Text_current_rate.disabled=true;
			document.Form1.Text_new_rate.disabled=true;
			document.Form1.Text_date1.disabled=true;
			document.Form1.Text_month1.disabled=true;
			document.Form1.Text_year1.disabled=true;
		
		}
<!----------------------------------------------------------------------------------------------->

function chk_add(){}

function chk_default_status(){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mf_senddata1?chksql=set_default&curruncycode="+document.Form1.Text_currency_code.value+"";
			parent.frames[0].document.applets[0].getdata(m_url);
		 	m_size=parent.frames[0].document.applets[0].outvec_value.size();
			if (m_size>0){
				alert("Sorry, there is a record in Default status.First change the existing record ?")
				document.Form1.Text_status.focus(); 
			}
			else {
			beforesubmit();
			}
	}
	
<!----------------------------------------------------------------------------------------------->

function set_accuracy_tax() {
		  m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement1?chksql=set_accuracy_tax&taxcode="+document.Form1.Text_Repo_code.value+"";
		  parent.frames[0].document.applets[0].getdata(m_url);
		 	m_size=parent.frames[0].document.applets[0].outvec_value.size();
			val=(document.Form1.Text_option.selectedIndex);
			data=document.Form1.Text_Repo_code.value;	
			defaultval=parent.frames[0].document.applets[0].outvec_value.value;
			<!-- -------------------------------------  -->
			if (val==0){
				if (m_size >0) {
				 	alert("This Tax Code is EXSISTING");
			  	document.Form1.Text_Repo_code.focus();
					document.Form1.Text_Repo_code.value="";
					}
				else if (data==""){
					alert("Tax code can't be Null");
					document.Form1.Text_Repo_code.focus();
				}
				
				else if (defaultval=="Y"){
				chk_default_status();
				}
				
				else {
				beforesubmit();
				}	
			}
			
			else if (val==1){
					if (data==""){
					alert("Tax code can't be null");
					document.Form1.Text_Repo_code.focus();
					document.Form1.Text_Repo_code.value="";
					}
					
					else if(m_size=='0'){
					alert("Sorry, Requested Tax Code not found");
					document.Form1.Text_Repo_code.focus();
					document.Form1.Text_Repo_code.value="";
					}
					
					else {
					beforesubmit();
					}
			}
			
			else if (val==2){
				if (defaultval=="Y"){
				alert("Sorry you can't De-activate this record");
				document.Form1.Text_Repo_code.focus();
				document.Form1.Text_Repo_code.value="";
				}
				
				else if (data==""){
					alert("Tax code can't be Null");
					document.Form1.Text_Repo_code.focus();
					document.Form1.Text_Repo_code.value="";
				}
				else if (m_size ==0) {
				 	alert("Sorry,This Tax Code is Not Existing");
			  	document.Form1.Text_Repo_code.focus();
					document.Form1.Text_Repo_code.value="";
					}
				
				else {beforesubmit();}
				}
				
				else if (val==3){
				 m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement1?chksql=set_accuracy_tax_react&taxcode="+document.Form1.Text_Repo_code.value+"";
				  parent.frames[0].document.applets[0].getdata(m_url);
				 	m_size=parent.frames[0].document.applets[0].outvec_value.size();
					val=(document.Form1.Text_option.selectedIndex);
					data=document.Form1.Text_Repo_code.value;	
					defaultval=parent.frames[0].document.applets[0].outvec_value.value;
						if (data==""){
						alert("Tax code can't be Null");
						document.Form1.Text_Repo_code.focus();
						document.Form1.Text_Repo_code.value="";
						}
							else if (m_size=='0') {
						 	alert("Sorry,This Tax Code is Not Existing.Press Help");
					  	}
				
				else {beforesubmit();}
				}
				
			}
	
<!----------------------------------------------------------------------------------------------->
  	function default_actions() {	
		  setInterval("set_timer_actions()",120000);
	  }			
	  function set_timer_actions() {	
		  m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mfsenddata2?chksql=idle";
		  //parent.frames[0].document.applets[0].getdata(m_url);
	  }
		function dynomic_text(){
		  if(document.Form1.Text_denominator.value=="UD") {
				m_row="";
		  	m_writedata ='<TABLE WIDTH="100%"> '+
	 		  '<BGCOLOR="silver"><TD WIDTH="1%"></TD> '+
        '<TD WIDTH="25%" STYLE="{color: black; font:bold 9pt arial;}">Number of Days</TD><TD WIDTH="74%"><INPUT TYPE="Text" NAME="Text_denominator" SIZE=15 ></TD>'+
				m_row+
				'</TABLE>'; 
			 othertextbox.innerHTML=m_writedata;
		 }
		 else {
		     othertextbox.innerHTML="";
   	}			
	}	
<!----------------------------------------------------------------------------------------------->
 	function keydownwaspressed() {
		 m_keycode=window.event.keyCode;
    if (m_keycode==119) {  
		    beforesubmit();
		  }
		  else if (m_keycode==120) {  
		      parent.frames[1].location.href='mfmain.html';
	  	}
   }
   function disable_save() {
	         document.Form1.save_but.disabled=true;
					 document.Form1.close_but.disabled=false;
	}						
<!----------------------------------------------------------------------------------------------->
	function beforehelp(){
			m=document.Form1.Text_option.value;	<!--m is the value comming from drop down selection box-->
				if (m=="IN"){				
					modi="ADD"; 
					document.Form1.Text_Repo_code.focus();
					}
				else if (m=="UP"){
					modi="MODI"; 
					tax_mod_help();
					} 
				else if (m=="DEA"){
					modi="DEACT"; 
					tax_mod_help();
					}
				else if (m=="REA"){
					modi="REACT"; 
					tax_react__help();
				}
				else if (m=="V"){
					modi="VIEW"; 
					view_help();
				}
	}
	
	
<!----------------------------------------------------------------------------------------------->

function beforesubmit(){
		/*m=document.Form1.Text_option.value;
		if (m=="IN"){ document.Form1.Hid_scr_name.value="ADD";}
		if (m=="UP"){ document.Form1.Hid_scr_name.value="MODI";}
		if (m=="DEA"){ document.Form1.Hid_scr_name.value="DEACT";}
		if (m=="REA"){ document.Form1.Hid_scr_name.value="REACT";}
			document.Form1.Text_Repo_code.disabled=false;
			document.Form1.Text_hair_cut.disabled=false;
			document.Form1.Text_current_rate.disabled=false;
			document.Form1.Text_new_rate.disabled=false;
			document.Form1.Text_date1.disabled=false;
			document.Form1.Text_month1.disabled=false;
			document.Form1.Text_year1.disabled=false;*/
		  Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsavrepo";
		  Form1.submit();
		}
<!----------------------------------------------------------------------------------------------->

function display_opt(){
m=document.Form1.Text_option.value;	<!--m is the value comming from drop down selection box-->
			document.Form1.Text_Repo_code.value="";
			document.Form1.DN_REF_MT_REPO_RATE.value="";
			document.Form1.Text_current_rate.value="";
			document.Form1.Text_new_rate.value="";
			document.Form1.Text_date1.value="";
			document.Form1.Text_month1.value="";
			document.Form1.Text_year1.value="";
				if (m=="IN"){				
					m_writedata ='<TD WIDTH="25%" STYLE="{color: white ;font: bold 9pt arial;text-align:right;}"'+
					'<B>System Maintenance-Tax Rates-New</B></TD>'; 
					change.innerHTML=m_writedata;	
					document.Form1.tax_help.disabled=true;
					document.Form1.Text_Repo_code.disabled=false;
					document.Form1.Text_Repo_code.focus();
					}
				else if (m=="UP"){
					m_writedata ='<TD WIDTH="25%" STYLE="{color: white ;font: bold 9pt arial;text-align:right;}"'+
					'<B>System Maintenance-Repo Rates-Modify</B></TD>'; 
					change.innerHTML=m_writedata;	
					document.Form1.tax_help.disabled=false;
					document.Form1.Text_Repo_code.disabled=false;
 					}  
				else if (m=="DEA"){
					m_writedata ='<TD WIDTH="25%" STYLE="{color: white ;font: bold 9pt arial;text-align:right;}"'+
					'<B>System Maintenance-Tax Rates-De-Activate</B></TD>'; 
					change.innerHTML=m_writedata;	
					document.Form1.tax_help.disabled=false;
					}
				else if (m=="REA"){
					m_writedata ='<TD WIDTH="25%" STYLE="{color: white ;font: bold 9pt arial;text-align:right;}"'+
					'<B>System Maintenance-Tax Rates-Re-Activate</B></TD>'; 
					change.innerHTML=m_writedata;	
					document.Form1.tax_help.disabled=false;
					}
				else if (m=="V"){
	 			m_writedata ='<TD WIDTH="25%" STYLE="{color: white ;font: bold 9pt arial;text-align:right;}"'+
				'<B>System Maintenance-Tax Rates-View</B></TD>'; 
				change.innerHTML=m_writedata;	
				view_help();
					document.Form1.tax_help.disabled=false;
					}
}	
<!----------------------------------------------------------------------------------------------->
function chk_dates(obj_date,obj_month,obj_year) {
				if (checkMonthLength(obj_date,obj_month,obj_year)) {
					m_date=obj_date.value+'/'+obj_month.value+'/'+obj_year.value;
					
			}
		}
<!----------------------------------------------------------------------------------------------->
function rate_chk(){
		m=document.Form1.Text_option.value;
		if (m=="IN"){document.Form1.Text_new_rate.value=document.Form1.Text_current_rate.value;}
}
<!----------------------------------------------------------------------------------------------->
	function screen_close(){
		top.frames[1].location=(html_client_url+"/low.html");
	} 
<!----------------------------------------------------------------------------------------------->



function get_date() {   
	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalRepo_Rate?chksql=get_sysdate";
	//top.frames[0].document.applets[0].getdata(m_urls);
	//m_size=top.frames[0].document.applets[0].outvec_value.size();
	
	load_interface(m_url,'XML',false);
	m_size = data_vec.length;
	
	document.Form1.Text_date1.value=data_vec[0];
	document.Form1.Text_month1.value=data_vec[1];
	document.Form1.Text_year1.value=data_vec[2];
	//document.Form1.Text_option.value="Y";
}


function getdata(){
	document.getElementById('div_lable').innerHTML='Loan Rate'; //added by Prabash on 24-11-2011	
	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalRepo_Rate?chksql=get_data";
	//top.frames[0].document.applets[0].getdata(m_urls);
	//m_size=top.frames[0].document.applets[0].outvec_value.size();
	
	load_interface(m_url,'XML',false);
	m_size = data_vec.length;
	
	document.Form1.Text_Repo_code.value=data_vec[0];
	m=data_vec[1];
	//document.Form1.Text_option.value =top.frames[0].document.applets[0].outvec_value.elementAt(2);
	
document.Form1.Text_option.value ="Y";
}

function BeforeSave(){
	
 beforesubmit();
	
}	
		
function display_sec_opt(val){

	 if(val='new'){
			
		document.getElementById('div_lable').innerHTML='Loan Rate - New'; //added by Prabash on 24-11-2011	
		document.Form1.Text_Repo_code.disabled=false;
							//document.Form1.Text_hair_cut.value=parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+1);
							//document.Form1.Text_current_rate.value=format_noobject(parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+2));
		 					//document.Form1.Text_new_rate.value=format_noobject(parent.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+4));
							
							document.Form1.Text_date1.disabled=false;
		 					document.Form1.Text_month1.disabled=false;
							document.Form1.Text_year1.disabled=false;
				            document.Form1.Text_option.disabled=false;
			                document.Form1.save_but.disabled=false;
			
	 }
}	
		
function clearAll(){
document.Form1.Text_Repo_code.value="0";
document.Form1.Text_date1.value="";
document.Form1.Text_month1.value="";
document.Form1.Text_year1.value="";
document.Form1.Text_option.value="Y";	

}		
		
</SCRIPT>
</HEAD>
<BODY ONLOAD="get_date();getdata()" class='body & txt-body' > 

			<FORM NAME="Form1"  ID="Form1" METHOD="POST" >
						<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="Repo_Rate">
			
			
			<DIV>
			<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
				<tr>
			<td height='7'></td>
			</tr>
				
			<tr height='30' >
			<td  width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
			<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Administration - System Maintenance</B></td>
			<td width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>
						
			</tr>
			
			<tr>
						
			</TABLE>	
					
			</DIV>
				
		<!--------------------------------------------------------------->
			<table class='table' border='0' cellpadding='0' cellspacing='0' width='100%'> 
			<tr>
			<td height='1'></td>
			</tr>
			<tr>				
					
		<!-------------------------------------------------------------------->
				
						
						<TABLE WIDTH="100%" BGCOLOR="darkblue" >
				<TR >
					<!--added by prabash on 01-09-2011-->
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="NEW" VALUE="Add"   onClick="display_sec_opt('new');"  class="mainbut"  >
					</TD>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="MOD" VALUE="Modify"   onClick="display_sec_opt('mod');" class="mainbut" disabled  >
					</TD>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="DEL" VALUE="Delete"   onClick="display_sec_opt('del');"  class="mainbut" disabled >
					</TD>
					<TD WIDTH='6%'></TD>		
					<!---------------------------------->
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="save_but" VALUE="Save"   onClick="BeforeSave()" class="mainbut"  >
					</TD>
					
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"   onClick="clearAll()" class="mainbut"> 
				</TD>
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit"   onClick="top.frames[1].location.href='low.jsp'" class="mainbut"> 
					</TD>
					<TD WIDTH="6%">
						<!--<INPUT TYPE="Button" NAME="report_but" VALUE="Enquiry&nbsp; "    onClick="obtain_report_before()" class="mainbut">-->
						
					</TD>
						<!--<TD  WIDTH="50%" class="hh1" align="right">-->
						<!--<B>Loan Rate</B>-->
						<TD> <B><div id='div_lable' align='right' > </div> </B> </TD>					
									
					</TD>					
				</TR>
			</TABLE>
		
			<TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
			<HR>
				<TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
			
			<BR>			
	  <!--TABLE WIDTH="100%"  BORDER="0" CELLPADDING="0" CELLSPACING="0">
		<TR></TR> 
    <TR>
		  <TD WIDTH="25%" STYLE="{color:black; font: bold 9pt Arial;}">Hair Cut</TD>
			<TD WIDTH="75%"><INPUT TYPE="Text" NAME="Text_hair_cut"	ALIGN="LEFT" SIZE="15"></TD>
	  </TR>	
	</TABLE-->
	<TABLE WIDTH="100%"  BORDER="0" CELLPADDING="1" CELLSPACING="0">
		<TR></TR>
    <TR>									<TD WIDTH="1%"></TD>

		  <TD WIDTH="25%" >Loan Rate</TD>
			<TD WIDTH="75%"><INPUT TYPE="Text" NAME="Text_Repo_code"	ALIGN="LEFT" SIZE="15" class="txt_input6" disabled ></TD>

		</TR>	
	</TABLE>					
	  <TABLE WIDTH="100%"  BORDER="0" CELLPADDING="1" CELLSPACING="0">
		<TR></TR> 
    <TR>
		<TD WIDTH="1%"></TD>

		  <TD WIDTH="25%" >Status</TD>
			<TD WIDTH="75%">
			  		<SELECT NAME="Text_option" class="txt_input6" disabled  >
							<OPTION VALUE="Y" SELECTED>YES</option> 
							<OPTION VALUE="N" >NO</option> 
			      </SELECT></TD>
	  </TR>	
	</TABLE>


	<TABLE WIDTH="100%"  BORDER="0" CELLPADDING="1" CELLSPACING="0">
 		<TR>									<TD WIDTH="1%"></TD>

       <B><TD WIDTH="25%"> Date</TD></B>
			 <TD WIDTH="79%"><INPUT	TYPE="Text" NAME="Text_date1"		ALIGN="LEFT" SIZE="3" class="txt_input5" disabled  >
							<INPUT 								TYPE="Text" NAME="Text_month1"	ALIGN="LEFT" SIZE="4" class="txt_input5" disabled  >
							<INPUT 								TYPE="Text" NAME="Text_year1"		ALIGN="LEFT" SIZE="4" onBlur="chk_dates(document.Form1.Text_date1,document.Form1.Text_month1,document.Form1.Text_year1)" class="txt_input5" disabled  >
			 </TD>
		</TR>	
 	 </TD> 
	</TABLE>
  </TABLE>  
		
</FORM>
		<!--	<SCRIPT LANGUAGE="JavaScript" SRC=html_client_url+"/mbfsl.js"></SCRIPT> 
   <script language="JavaScript1.2" SRC="http://www.srilanka.sasianet.lk/MFactor/validate.js">var g_dismsg=false;</SCRIPT>-->
	
	<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
	<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>	
	</body>
</html>


