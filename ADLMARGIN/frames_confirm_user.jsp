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
		<TITLE>CSAM
		</TITLE>
		
	</HEAD>
	<SCRIPT language="JavaScript">
		var cc;
		
		function add_data() {
			var num;
			var del_type="";
			cc=0;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalsavuser?chksql=new_user_details_not_conf";
			//window.open(m_url);
			//top.frames[0].document.applets[0].getdata(m_url);	  
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			load_interface(m_url,'XML',false);	 
			m_size=data_vec.length;
			vec_pos=0;
			lineno=1;
			m_row="";
			if (m_size==0) {
				alert('No Previous incomplete Users');
			}
			else{
				//alert("****"+vec_pos+"****"+m_size);
				while (vec_pos<m_size) {
					
					m_user_name=data_vec[vec_pos];
					m_location_code=data_vec[vec_pos+1];
					m_surname=data_vec[vec_pos+2];
					m_other_name=data_vec[vec_pos+3];
					m_designation_code=data_vec[vec_pos+4];
					m_senior_level=data_vec[vec_pos+5];
					m_status=data_vec[vec_pos+6];
					m_status2=data_vec[vec_pos+7];
					// alert("****"+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+10));
					m_row=m_row+'<TR BGCOLOR="silver">';
					
					m_row=m_row+'<TD STYLE="{color: black; font:  9pt arial;text-align:center;} ALIGN="Center">'+m_user_name+'<INPUT TYPE="Hidden" NAME="USERNAME'+lineno+'" VALUE="'+m_user_name+'"></TD>';
					m_row=m_row+'<TD STYLE="{color: black; font: 9pt arial;text-align:center;} ALIGN="Center">'+m_surname+'<INPUT TYPE="Hidden" NAME="SURNAME'+lineno+'" VALUE="'+m_surname+'"></TD>';
					//m_row=m_row+'<TD STYLE="{color: black; font: 9pt arial;text-align:center;} ALIGN="Center">'+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+9)+'<INPUT TYPE="Hidden" NAME="VALE'+lineno+'" VALUE="'+top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+9)+'"></TD>';
					m_row=m_row+'<TD STYLE="{color: black; font: 9pt arial;text-align:center;} ALIGN="Center">'+m_other_name+'</TD>';
					m_row=m_row+'<TD STYLE="{color: black; font: 9pt arial;text-align:center;} ALIGN="Center">'+m_location_code+'</TD>';
					m_row=m_row+'<TD STYLE="{color: black; font: 9pt arial;text-align:center;} ALIGN="Center">'+m_designation_code+'</TD>';
					m_row=m_row+'<TD STYLE="{color: black; font: 9pt arial;text-align:center;} ALIGN="Center">'+m_senior_level+'</TD>';	
					m_row=m_row+'<TD STYLE="{color: black; font: 9pt arial;text-align:center;} ALIGN="Center">'+m_status2+'<INPUT TYPE="Hidden" NAME="STATUS'+lineno+'" VALUE="'+m_status+'"></TD>';
					
					if(m_status=='ENTERD'){
						m_row=m_row+'<TD ALIGN="Center" STYLE="{color: black; font:  9pt arial;}"><INPUT TYPE="button" VALUE="Details" NAME=DETAIL'+lineno+' STYLE="{cursor:hand; color: black; font: 8pt arial;}" ONCLICK=display_user_details_report("'+m_user_name+'","'+m_status+'")></TD>';//$$##SC
					}
					else{
						m_row=m_row+'<TD ALIGN="Center" STYLE="{color: black; font:  9pt arial;}"><INPUT TYPE="button" VALUE="Details" NAME=DETAIL'+lineno+' STYLE="{cursor:hand; color: black; font: 8pt arial;}" ONCLICK=display_user_details_report("'+m_user_name+'","'+m_status+'")></TD>';//$$##SC
					}
					
					m_row=m_row+'<TD ALIGN="Center" STYLE="{color: black; font: 9pt arial;}"><INPUT TYPE="checkbox" NAME="Text_save'+lineno+'" STYLE="{ color: black; font: 8pt arial;}"   ></TD> ';//ONCLICK =chk_serial_no("'+m_dealnum+'",'+lineno+'),chk_security_no("'+m_dealnum+'",'+lineno+'),chk_scripless("'+m_dealnum+'",'+lineno+')
					
					//m_row=m_row+'<TD ALIGN="Center" STYLE="{color: black; font: 9pt arial;}"><INPUT TYPE="button" NAME="B_fax'+lineno+'" STYLE="{cursor:hand; color: black; font: 8pt arial;}" VALUE="  Fax  "></TD> ';
					m_row=m_row+'</TR>';
					vec_pos=vec_pos+8;
					lineno=lineno+1;
				}
				document.Form1.Hid_rows.value=lineno;
				
				
				m_writedata ='<TABLE WIDTH="750" BGCOLOR="silver" STYLE="{color: black; font: 10pt arial;}">'+
					'<TR BGCOLOR="darkgray">'+
					'<TD WIDTH="75" ALIGN="Center"><B><FONT COLOR="black">User Name</B></TD>' +
					'<TD WIDTH="100" ALIGN="Center"><B><FONT COLOR="black">Surname</B></TD>'+
					'<TD WIDTH="200" ALIGN="Center"><B><FONT COLOR="black">Other Names</B></TD>'+
					'<TD WIDTH="100" ALIGN="Center"><B><FONT COLOR="black">Location</B></TD>'+
					'<TD WIDTH="100" ALIGN="Center"><B><FONT COLOR="black">Designation</B></TD>'+
					'<TD WIDTH="100" ALIGN="Center"><B><FONT COLOR="black">Seniority Level</B></TD>'+
					'<TD WIDTH="75" ALIGN="Center"><B><FONT COLOR="black">Active Status</B></TD>'+
					'<TD WIDTH="125" ALIGN="Center"><B><FONT COLOR="black">Details</B></TD>'+
					//'<TD WIDTH="75"  ALIGN="Center"><B><FONT COLOR="black">Save</B></TD>' +
					'<TD WIDTH="75"  ALIGN="Center"><B><FONT COLOR="black"><INPUT TYPE="checkbox" alt="Tick to Select/Unseclect" NAME="Select_All" STYLE="{ color: black; font: 8pt arial;}"  ONCLICK =select_all_checkbox();>Save/Reject</B></TD>' +//mod by waruna 2011-05-30
					
					'</TR>' +
					m_row+
					'</TABLE>'; 
				dealticket1.innerHTML=m_writedata;	
			}
		}
		
		
		//--------------------
		/*
		function select_all_checkbox(){
			max_recode=document.Form1.Hid_rows.value   
				if(document.Form1.Select_All.checked==true){
					for(t=1;t<max_recode;t++){
						chk_box_name='Text_save'+t;
						txt_user_name='DEALNO'+t;
						//document.Form1.getElementsByName('Text_save1').checked=true;
						//document.Form1.getElementsByName(chk_box_name).checked=true;
						//m_dealnum=document.getElementById(txt_user_name).value;
						//alert(m_dealnum);
						document.getElementById(chk_box_name).checked=true;
						//chk_serial_no(m_dealnum,t);
						//chk_security_no(m_dealnum,t);
						//chk_scripless(m_dealnum,t);
						///break;
					}
					
				}else{
					for(t=1;t<max_recode;t++){
						chk_box_name='Text_save'+t;
						//document.Form1.getElementsByName('Text_save1').checked=true;
						//document.Form1.getElementsByName(chk_box_name).checked=true;
						document.getElementById(chk_box_name).checked=false;
						///break;
					}
					
				}	 
		}
		*/
		
		
		function reject_all_checkbox(e,obj){
			e = e||event; /* get IE event ( not passed ) */
			e.stopPropagation? e.stopPropagation() : e.cancelBubble = true;
			max_recode=document.Form1.Hid_rows.value   
				if(document.Form1.Reject_All.checked==true)
				{
					document.Form1.Reject_All.value="on";
					document.Form1.Select_All.checked=false;
					document.Form1.Select_All.value="off";
					
					for(t=1;t<=max_recode;t++)
					{
						//chk_box_name='Text_save'+t;
						chk_box_name='Text_reject'+t;
						txt_user_name='DEALNO'+t;
						
						document.Form1.elements["Text_save"+t].checked=false;
						document.Form1.elements["Text_save"+t].value="off";
						
						document.getElementById(chk_box_name).checked=true;
						document.Form1.elements["Text_reject"+t].value="on";
					}
					
				}else
			{
				document.Form1.Reject_All.value="off";
				for(t=1;t<=max_recode;t++)
				{
					chk_box_name='Text_reject'+t;
					document.getElementById(chk_box_name).checked=false;
					document.Form1.elements["Text_reject"+t].value="off";
					
				}
				
			}	 
		}	
		
		
		
		////////----------------------------------------------
		//=============== Added by Shanheetha on 12-07-2006 for VC06/012 ================================================
		
		
		/*function checkbuyersettlementdate2(m_dealnum,lineno){
		if(m_dealnum.substring(0,2)=="OR"){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?dealrefno="+m_dealnum+"&chksql=chk_buy_sett_date2";
				top.frames[0].top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				
				document.Form1.HID_BUY_SETT_DATE.value=top.frames[0].document.applets[0].outvec_value.elementAt(0);
						
				if(document.Form1.HID_BUY_SETT_DATE.value=="YES"){
				alert("Buyer Settlement Date is not greater than Last Day End Routine Date!.");
					v_check="Text_save"+lineno;
					v_check_1=document.Form1.elements[v_check];
					v_check_1.checked = false ;
				}
					else{
				}
			}
			} */
		
		
		function checkbuyersettlementdate2() {
			for(var r=1;document.Form1.Hid_rows.value>r;r++){
				if(eval("document.Form1.Text_save"+r+".checked")) {
				//	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?dealrefno="+eval("document.Form1.DEALNO"+r+".value")+"&chksql=chk_buy_sett_date2";
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?dealrefno="+eval("document.Form1.DEALNO"+r+".value")+"&chksql=chk_buy_sett_date_check2";
					top.frames[0].document.applets[0].getdata(m_url);
					m_size=top.frames[0].document.applets[0].outvec_value.size();
					
					document.Form1.HID_BUY_SETT_DATE.value=top.frames[0].document.applets[0].outvec_value.elementAt(0);
					
					if(document.Form1.HID_BUY_SETT_DATE.value=="YES"){
						title="Buyer Settlement Date Error Message";
						mess="Buyer Settlement Date is not greater than Last Day End Routine Date or daily margin trading date for Deal No. "+eval("document.Form1.DEALNO"+r+".value")+" !";
						
						
						v_check="Text_save"+r;
						v_check_1=document.Form1.elements[v_check];
						v_check_1.checked = false ;
						
						icon=1;
						mods=0;
						makeMsgBox(title,mess,icon,0,0,mods)
						
						
					}
					else {
					}
				}
			}	
		}
		
		//======================= End ==================================================================================	
		
		
		
		
		// ----- The Following Function Was Added By upul On 01/03/2000 ---------COUNT------ //
		function beforesubmit_dealTiket(Obj) {
			cc=cc+1;
			document.Form1.Hid_dealValue.value=Obj.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?deal_num="+Obj.value+"&COUNT="+cc+"&chksql=Deal_Tiketting";
			//alert(m_url);
			//window.close();
			popupwin = window.open(m_url,"displayWindow8","width=600, height=550,scrollbars=yes, menubar=no, resizable=yes");
			
		}	
		
		//added by hasara  on   01-03-2001-------------
		
		
		function chk_serial_no(m_dealnum,lineno) {
			if((m_dealnum.substring(0,2)=="RF")){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmChk1";
				top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				//	alert(m_size);
				
				if (m_size!==0) {	 
					
					
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmChk*";
					top.frames[0].document.applets[0].getdata(m_url);
					m_size=top.frames[0].document.applets[0].outvec_value.size();
					//alert(m_size);	
					//	 if (m_size ==0) {					
					
					
					
					if (m_size!==0) {	 				
						
						
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmChk";
						top.frames[0].document.applets[0].getdata(m_url);
						m_size=top.frames[0].document.applets[0].outvec_value.size();
						//	alert(m_size);	
						if (m_size ==0) {
							alert('Allocate serial numbers prior to  the confirmation'); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:8 --->
							v_check="Text_save"+lineno;
							v_check_1=document.Form1.elements[v_check];
							//v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:8 --->
						}
						
					}
				}
				
			}	
			//added By Keith on 9-9-2004/9:11 for repo rollover check of serial numbers/physical deleivery
			else if((m_dealnum.substring(0,2)=="RR")){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmSerialchk1RR";
				top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();							
				//alert("RRSerialcheck1*"+m_size);
				if (m_size!==0) {	 				
					
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmSerialChk2RR";
					top.frames[0].document.applets[0].getdata(m_url);
					m_size=top.frames[0].document.applets[0].outvec_value.size();													
					//alert("RRSerialcheck2**"+m_size);
					if (m_size!==0) {	 			 	 								 
						
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmSerialChk3RR";
						top.frames[0].document.applets[0].getdata(m_url);
						m_size=top.frames[0].document.applets[0].outvec_value.size();
						//alert("RRSerialcheck3***"+m_size);
						if (m_size ==0) {
							alert('Allocate serial numbers prior to  the confirmation'); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:8 --->
							v_check="Text_save"+lineno;
							v_check_1=document.Form1.elements[v_check];
							//v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:8 --->
						}//end msize3
					}//end msize2
				}//end msize1
			}	//end RR
			
		}
		
		function chk_scripless(m_dealnum,lineno){//$$##SC
			if(m_dealnum.substring(0,2)=="OR"){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chksc"; 
				top.frames[0].document.applets[0].getdata(m_url);
				//alert("1"+top.frames[0].document.applets[0].outvec_value);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				if(m_size>0){
					if((top.frames[0].document.applets[0].outvec_value.elementAt(0)=="SL")&&(top.frames[0].document.applets[0].outvec_value.elementAt(1)=="P")){//&&(top.frames[0].document.applets[0].outvec_value.elementAt(2)=="S")
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chksec_tab";
						top.frames[0].document.applets[0].getdata(m_url);
						m_size=top.frames[0].document.applets[0].outvec_value.size();
						//	alert(top.frames[0].document.applets[0].outvec_value);
						if(top.frames[0].document.applets[0].outvec_value.elementAt(0)==0){
							alert("Allocate serial numbers prior to  the confirmation"); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:8 --->
							v_check="Text_save"+lineno;
							v_check_1=document.Form1.elements[v_check];
							v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:8 --->
						}
					}
				}
			}//OR
			if(m_dealnum.substring(0,2)=="RF"){//$$##SC
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chksc_rf"; 
				top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				//alert(top.frames[0].document.applets[0].outvec_value);
				if(m_size>0){
					if((top.frames[0].document.applets[0].outvec_value.elementAt(0)=="SL")&&(top.frames[0].document.applets[0].outvec_value.elementAt(1)=="P")){
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chksec_tab_rf";
						top.frames[0].document.applets[0].getdata(m_url);
						m_size=top.frames[0].document.applets[0].outvec_value.size();
						//alert(top.frames[0].document.applets[0].outvec_value);
						if(top.frames[0].document.applets[0].outvec_value.elementAt(0)==0){
							alert("Allocate serial numbers prior to  the confirmation"); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:9 --->
							v_check="Text_save"+lineno;
							v_check_1=document.Form1.elements[v_check];
							//v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:9 --->
						}
					}
					else if ((top.frames[0].document.applets[0].outvec_value.elementAt(0)=="SL")&&(top.frames[0].document.applets[0].outvec_value.elementAt(1)=="C")){
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chksecurity_tab_rf";
						top.frames[0].document.applets[0].getdata(m_url);
						m_size=top.frames[0].document.applets[0].outvec_value.size();
						//alert(top.frames[0].document.applets[0].outvec_value);
						if(top.frames[0].document.applets[0].outvec_value.elementAt(0)==0){
							alert("Allocate securities prior to  the confirmation");  <!---commented by inditha FOR VC05-002  on 12-7-2005/11:9 --->
							v_check="Text_save"+lineno;
							v_check_1=document.Form1.elements[v_check];
							//v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:9 --->
						}
						
					}
				}
			}//RF
			//added By Keith on 8-9-2004/11:49 -------------------------------------------------------------------------------------------------
			if(m_dealnum.substring(0,2)=="RR"){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chkSC_RR"; 
				top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				//alert("RRSLheck1*"+m_size);
				//alert(top.frames[0].document.applets[0].outvec_value.elementAt(0));
				//alert(top.frames[0].document.applets[0].outvec_value.elementAt(1));
				if(m_size>0){
					if((top.frames[0].document.applets[0].outvec_value.elementAt(0)=="SL")&&(top.frames[0].document.applets[0].outvec_value.elementAt(1)=="P")){
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chkSERIAL_RR";
						top.frames[0].document.applets[0].getdata(m_url);
						m_size=top.frames[0].document.applets[0].outvec_value.size();
						//alert("RRSLheck1**"+m_size);
						if(top.frames[0].document.applets[0].outvec_value.elementAt(0)==0){
							alert("Allocate serial numbers prior to  the confirmation"); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:9 --->
							v_check="Text_save"+lineno;
							v_check_1=document.Form1.elements[v_check];
							//v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:9 --->
						}
					}
					else if ((top.frames[0].document.applets[0].outvec_value.elementAt(0)=="SL")&&(top.frames[0].document.applets[0].outvec_value.elementAt(1)=="C")){
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chkSECURITY_RR";
						top.frames[0].document.applets[0].getdata(m_url);
						m_size=top.frames[0].document.applets[0].outvec_value.size();
						//alert("RRSLheck1***"+m_size);
						if(top.frames[0].document.applets[0].outvec_value.elementAt(0)==0){
							alert("Allocate securities prior to  the confirmation"); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:9 --->
							v_check="Text_save"+lineno;
							v_check_1=document.Form1.elements[v_check];
							//v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:9 --->
						}
					}
				}
			}//RR
			//------------------end addition----------------------------------------------------------------------------------------------------------
			
		}
		//-----------------------------------
		
		
		/////added  by  hasara  on  06-03-2001-------/////////////////////////////////////
		function chk_security_no(m_dealnum,lineno) {
			if((m_dealnum.substring(0,2)=="RF")){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=checkborrrf";//YASOADED
				top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				if (m_size!==0) {
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmChk2";
					top.frames[0].document.applets[0].getdata(m_url);
					m_size=top.frames[0].document.applets[0].outvec_value.size();
					if (m_size!==0) {
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmChk*";
						top.frames[0].document.applets[0].getdata(m_url);
						m_size=top.frames[0].document.applets[0].outvec_value.size();
						if (m_size!==0) {	 	
							m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmChk3";
							top.frames[0].document.applets[0].getdata(m_url);
							m_size=top.frames[0].document.applets[0].outvec_value.size();
							if (m_size==0) {
								alert('Allocate securities prior to  the confirmation'); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:10 --->
								v_check="Text_save"+lineno;
								v_check_1=document.Form1.elements[v_check];
								//v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:10 --->
							}	
						}
						
					}     
				}
			}
			else if((m_dealnum.substring(0,2)=="OR")){
				murl=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealno="+m_dealnum+"&chksql=chk_ordeal_curr";	          
				top.frames[0].document.applets[0].getdata(murl);
				msize=top.frames[0].document.applets[0].outvec_value.size();
				//alert(top.frames[0].document.applets[0].outvec_value);
				//alert(msize);
				if(msize>0){
					alert("Please allocate Serial numbers prior to the Confirmation"); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:10 --->
					v_check="Text_save"+lineno;
					v_check_1=document.Form1.elements[v_check];  
					v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:10 --->
				}
			}
			else if((m_dealnum.substring(0,2)=="RR")){ //added By Keith on 9-9-2004/9:28 
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=checkborrrr";//YASOADDED
				top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				if (m_size!==0) {
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmSecurityChk1RR";
					top.frames[0].document.applets[0].getdata(m_url);
					m_size=top.frames[0].document.applets[0].outvec_value.size();
					//alert("RRSeccheck1*"+m_size);
					if (m_size!==0) {
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmSecurityChk2RR";
						top.frames[0].document.applets[0].getdata(m_url);
						m_size=top.frames[0].document.applets[0].outvec_value.size();
						//alert("RRSeccheck2**"+m_size);
						if (m_size!==0) {	 	
							m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmSecurityChk3RR";
							top.frames[0].document.applets[0].getdata(m_url);
							m_size=top.frames[0].document.applets[0].outvec_value.size();
							//alert("RRSeccheck3***"+m_size);
							if (m_size==0) {
								alert('Allocate securities prior to  the confirmation'); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:10 --->
								v_check="Text_save"+lineno;
								v_check_1=document.Form1.elements[v_check];
								//v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:10 --->
							}	
						}     
					}
				}	
			}//END RR
			
		}
		//////////////////////////////////--------------------------------------////////////////////////////////	
		function chk_confirmed_deal() {
			for(var r=1;document.Form1.Hid_rows.value>=r;r++){
				if(eval("document.Form1.Text_save"+r+".checked")||eval("document.Form1.Text_reject"+r+".checked")) {
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_Client_Confirmation?ClientCode="+eval("document.Form1.USERNAME"+r+".value")+"&chksql=Client_Confirmation";
					//top.frames[0].document.applets[0].getdata(m_url);
					load_interface(m_url,'XML',false);	 
					m_size=data_vec.length;
					//if(top.frames[0].document.applets[0].outvec_value.elementAt(0)=="CONF"){
					if(data_vec[0]=="CONF")
					{
						title="Client Confirmation Confirmation Error Message";
						mess="This Client "+eval("document.Form1.USERNAME"+r+".value")+" has been already confirmed";
						
						icon=1;
						mods=0;
						makeMsgBox(title,mess,icon,0,0,mods)
						
						return false;
						break;
					}
					else 
					{
						return true;
					}
				}
			}	
		}
		
		function display_details(m_deal_no){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?chksql=display_data&deal_no="+m_deal_no+"";
			popupwin = window.open(m_url,"displayWindow85","top=150, left=100, width=600, height=200,scrollbars=yes, menubar=no, resizable=yes");
		}
		
		
		function unable_checkbox(){
			for(var t=1;document.Form1.Hid_rows.value>t;t++) {
				m_chk_box="document.Form1.Text_save"+t;
				m_chk_box.disabled=false;
			}		
		}
		
		
		//Added by Susitha 30-05-2011		
		
		/****************************************************/
		function beforesubmit_reject() 
		{
			
			r=1;
			document.Form1.Hid_scr_name.value="reject_user";
			
			if(chk_confirmed_deal())
			{
				//unable_checkbox();
				document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_User_Confirmation"; 
				document.Form1.submit();
			}
			
		}
		
		function beforesubmit() 
		{
			r=1;
			
			//checkbuyersettlementdate2();//--- Added by Shanheetha on 12-07-2006 for VC06-012.
			
			if(chk_confirmed_deal())
			{
				unable_checkbox();
				document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_User_Confirmation"; 
				document.Form1.submit();
				
			}
		}
		
		
		function clearAll(){
			top.frames[1].location.href = jsp_client_url + "/frames_confirm_user.jsp";
		}
		
		function exit()
		{
			top.frames[1].location.href = jsp_client_url + "/low.jsp";
		}	
		
		
		
		/************************add a json grid *****************************************/
		//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"
		
		//new_user_details_not_conf
		jQuery(document).ready(function(){ 
				jQuery("#grid").jqGrid({
						url:servlet_client_url+':'+client_t3_port+'/'+client_name+'dnvalsavuser?chksql=new_user_details_not_conf',
						datatype: "json",
						loadonce: 1,
						mtype: 'GET',
						colNames:['User Name', 'Surname', 'Other Name', 'Location', 'Designation', 'Seniority Level', 'Active Status', 'Details', 'Save <INPUT TYPE="checkbox" alt="Tick to Select/Unseclect" value="off" NAME="Select_All" ONCLICK ="select_all_checkbox(event,this)">','Reject <INPUT TYPE="checkbox" value="off" NAME="Reject_All" ONCLICK ="reject_all_checkbox(event,this)"> '],
						colModel:[
							{name:'User_Name',index:'User_Name',jsonmap: 'User_Name',width:100, sortable:false, editable:false,formatter:userNameFmatter,unformat:unformatData},
							{name:'Surname',index:'Surname',jsonmap: 'Surname',width:100,editable:false,formatter:surName,unformat:unformatData},
							{name:'Other_Name',index:'Other_Name',jsonmap: 'Other_Names', width:100,editable:true},
							{name:'Location',index:'Location',jsonmap:'Location',width:100,editable:true},
							{name:'Designation',index:'Designation',jsonmap:'Designation', width:100,editable:true},
							{name:'Seniority_Level',index:'Seniority_Level',jsonmap:'Seniority_Level',width:50},
							{name:'Active_Status',index:'Active_Status',jsonmap:'Active_Status',width:100},
							{name:'Details',index:'Details',align:'center',formatter:status,jsonmap:'Details',unformat:unformatData,width:100},
							{name:'Save',index:'Save',sortable:false,unformat:unformatData,align:'center',formatter:checkBoxFmatter, width:100},
							{name:'Reject',index:'Reject',sortable:false,unformat:unformatData,align:'center',formatter:checkBoxRejectFmatter, width:100}
							
						],
						jsonReader : {
							repeatitems:false
						},
						rowNum:100000,
						loadComplete: function()
						{
							
							var rec_count =jQuery('#grid').jqGrid('getGridParam','records');
							document.Form1.Hid_rows.value=rec_count;
							//var rec_count = jQuery("#grid").getDataIDs().length; //below line is also working
						},	
						height: 'auto',
						width: 'auto',
						caption:"User Confirmation"
						
					});
				
			});
		
		//,jsonmap:'Details'
		//formatter:status,unformat:unformatData,
		
		function status(cellvalue, options, rowObject)
		{
			var rowid=options['rowId']; //undecoded value is set for the hidden field but the decoded value will be displayed in this column
			//var link=cellvalue+"<INPUT TYPE=\"Hidden\" NAME=\"STATUS"+rowid+"\" VALUE=\""+cellvalue+"\" >";
			var m_user_name=rowObject.User_Name;
			var link1="<INPUT TYPE=\"Hidden\" NAME=\"STATUS"+rowid+"\" VALUE=\""+cellvalue+"\" >";
			
			if(cellvalue=='ENTERD')
			{
				var link=link1+"<INPUT TYPE=\"button\" VALUE=\"Details\" NAME=\"DETAIL"+rowid+"\" STYLE=\"cursor:hand; color: black; font: 8pt arial;\" ONCLICK=\"display_user_details_report('"+m_user_name+"','"+cellvalue+"')\"></TD>";
			}
			else
			{
				var link=link1+"<INPUT TYPE=\"button\" VALUE=\"Details\" NAME=\"DETAIL"+rowid+"\" STYLE=\"cursor:hand; color: black; font: 8pt arial;\" ONCLICK=\"display_user_details_report('"+m_user_name+"','"+cellvalue+"')\"></TD>";
			}
			
			return link; 
		}	
		
		function surName(cellvalue, options, rowObject)
		{
			var rowid=options['rowId'];
			var link=cellvalue+"<INPUT TYPE=\"Hidden\" NAME=\"SURNAME"+rowid+"\" VALUE=\""+cellvalue+"\" >";
			return link;
		}	
		
		function userNameFmatter (cellvalue, options, rowObject)
		{
			var rowid=options['rowId'];
			var link=cellvalue+"<INPUT TYPE=\"Hidden\" NAME=\"USERNAME"+rowid+"\" VALUE=\""+cellvalue+"\" />";
			return link;
		}	
		
		function change_value(rowid)
		{
			if(document.Form1.elements["Text_save"+rowid].checked==true)
			{
				document.Form1.elements["Text_reject"+rowid].checked=false;
				document.Form1.elements["Text_reject"+rowid].value="off";
				document.Form1.elements["Text_save"+rowid].value="on";
			}else
			{
				document.Form1.elements["Text_save"+rowid].value="off";
			}	
		}	
		
		
		function change_reject_value(rowid)
		{
			if(document.Form1.elements["Text_reject"+rowid].checked==true)
			{
				document.Form1.elements["Text_save"+rowid].checked=false;
				document.Form1.elements["Text_save"+rowid].value="off";
				document.Form1.elements["Text_reject"+rowid].value="on";
			}else
			{
				document.Form1.elements["Text_reject"+rowid].value="off";
			}	
		}
		
		
		
		function checkBoxFmatter (cellvalue, options, rowObject){
			var rowid=options['rowId'];
			var link ="<input type='checkbox' id='Text_save"+rowid+"'  name='Text_save"+rowid+"' value=\"off\" onclick=\"change_value('"+rowid+"')\"   />";  // onclick ='testValue("+rowid+")'
			//var link ="<input type='checkbox' id='save_"+rowid+"'  name='save_"+rowid+"' value='on'  onclick ='orTest()';     />"; 
			return link;
		}
		
		
		function checkBoxRejectFmatter(cellvalue,options,rowObject)
		{
			var rowid=options['rowId'];
			var link ="<input type='checkbox' id='Text_reject"+rowid+"'  name='Text_reject"+rowid+"' value=\"off\" onclick=\"change_reject_value('"+rowid+"')\"   />";  // onclick ='testValue("+rowid+")'
			return link
		}	
		
		function unformatData(cellvalue, options, cellobject) {
			return cellvalue;
		}
		
		function select_all_checkbox(e,obj){
			e = e||event; /* get IE event ( not passed ) */
			e.stopPropagation? e.stopPropagation() : e.cancelBubble = true;
			max_recode=document.Form1.Hid_rows.value;   
			if(document.Form1.Select_All.checked==true)
			{
				document.Form1.Select_All.value=="on";
				document.Form1.Reject_All.checked=false;
				document.Form1.Reject_All.value="off";
				for(t=1;t<=max_recode;t++)
				{
					chk_box_name='Text_save'+t;
					txt_user_name='DEALNO'+t;
					
					document.Form1.elements["Text_reject"+t].checked=false;
					document.Form1.elements["Text_reject"+t].value="off";
					document.getElementById(chk_box_name).checked=true;
					document.getElementById(chk_box_name).value="on";
					
				}
				
			}else
			{
				document.Form1.Select_All.value=="off";
				for(t=1;t<=max_recode;t++)
				{
					chk_box_name='Text_save'+t;
					
					document.getElementById(chk_box_name).checked=false;
					document.getElementById(chk_box_name).value="off";
					
				}
				
			}	 
		}
		
		
		function beforesubmit_reject() 
		{
			
			r=1;
			document.Form1.Hid_scr_name.value="reject_user";
			if(chk_confirmed_deal()){
				unable_checkbox();
				document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_User_Confirmation"; 
				//Form1.submit();
			}
		}
		
		
		
		function before_submit() {
			r=1;
			if(chk_confirmed_deal())
			{
				unable_checkbox();
				document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_User_Confirmation"; 
				document.Form1.submit();
			}
		}
		
		
		
		
		
		/*
		m_row=m_row+'<TD STYLE="{color: black; font:  9pt arial;text-align:center;} ALIGN="Center">'+m_user_name+'<INPUT TYPE="Hidden" NAME="USERNAME'+lineno+'" VALUE="'+m_user_name+'"></TD>';
		m_row=m_row+'<TD STYLE="{color: black; font: 9pt arial;text-align:center;} ALIGN="Center">'+m_surname+'<INPUT TYPE="Hidden" NAME="SURNAME'+lineno+'" VALUE="'+m_surname+'"></TD>';
		
		m_row=m_row+'<TD STYLE="{color: black; font: 9pt arial;text-align:center;} ALIGN="Center">'+m_other_name+'</TD>';
		m_row=m_row+'<TD STYLE="{color: black; font: 9pt arial;text-align:center;} ALIGN="Center">'+m_location_code+'</TD>';
		m_row=m_row+'<TD STYLE="{color: black; font: 9pt arial;text-align:center;} ALIGN="Center">'+m_designation_code+'</TD>';
		m_row=m_row+'<TD STYLE="{color: black; font: 9pt arial;text-align:center;} ALIGN="Center">'+m_senior_level+'</TD>';	
		m_row=m_row+'<TD STYLE="{color: black; font: 9pt arial;text-align:center;} ALIGN="Center">'+m_status2+'<INPUT TYPE="Hidden" NAME="STATUS'+lineno+'" VALUE="'+m_status+'"></TD>';
		
		if(m_status=='ENTERD'){
			m_row=m_row+'<TD ALIGN="Center" STYLE="{color: black; font:  9pt arial;}"><INPUT TYPE="button" VALUE="Details" NAME=DETAIL'+lineno+' STYLE="{cursor:hand; color: black; font: 8pt arial;}" ONCLICK=display_user_details_report("'+m_user_name+'","'+m_status+'")></TD>';//$$##SC
		}
		else{
			m_row=m_row+'<TD ALIGN="Center" STYLE="{color: black; font:  9pt arial;}"><INPUT TYPE="button" VALUE="Details" NAME=DETAIL'+lineno+' STYLE="{cursor:hand; color: black; font: 8pt arial;}" ONCLICK=display_user_details_report("'+m_user_name+'","'+m_status+'")></TD>';//$$##SC
		}
		
		m_row=m_row+'<TD ALIGN="Center" STYLE="{color: black; font: 9pt arial;}"><INPUT TYPE="checkbox" NAME="Text_save'+lineno+'" STYLE="{ color: black; font: 8pt arial;}"   ></TD> ';//ONCLICK =chk_serial_no("'+m_dealnum+'",'+lineno+'),chk_security_no("'+m_dealnum+'",'+lineno+'),chk_scripless("'+m_dealnum+'",'+lineno+')
		
		
		m_row=m_row+'</TR>';
		
		*/
		
		
		
		
		
		
		/****************************************************/
	</SCRIPT>
	
	<SCRIPT LANGUAGE=VBScript TYPE="text/vbscript">
		Function makeMsgBox(title,mess,icon,buts,defbut,mods)
			butVal = buts + (icon*16) + (defbut*256) + (mods*4096)
			makeMsgBox = MsgBox(mess,butVal,title)  
			
		End Function
		
	</SCRIPT>
	
	
	<BODY> <!-- onLoad="add_data()" -->
		<FORM NAME="Form1" METHOD="POST" >
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="confirm_user">
			<INPUT TYPE="Hidden" NAME="Hid_rows" >
			<INPUT TYPE="Hidden" NAME="Hid_dealValue" >
			
			<INPUT TYPE="Hidden" NAME="HID_BUY_SETT_DATE" VALUE="" >
			<!-- 2011-09-26 ---->
			
			<table class='table' border='0' align='center' width="100%" border="0" cellpadding="2" cellspacing="0">
				<tr>
					<td width="1%">
					</td>	
					<td width="99%">		
						<table class='table' align='center' width="99%" border="0" cellpadding="0" cellspacing="0" >
							<!-- <table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 	-->
							<tr>
								<td height='7'></td>
							</tr>
							<tr height="30">		
								<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
								<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>	Administration - System User</B></td>
								<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='right'><B> User Confirmation</B></td>
								<td width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>
							</tr>
						</table>
						
					</td>			
				</tr>	
				<tr>
					<td width="1%">
					</td>
					<td width="99%">			
						<table class='table' align='center' width="99%" border="0" cellpadding="2" cellspacing="0" >
							<tr>
								<td width="6%">
									<input type="button" value="Save" onclick="beforesubmit()" class="mainbut">	
								</td>	
								<!-- 
								<td width="6%">
									<input type="button" value="Reject" onclick="beforesubmit()" class="mainbut">	
								</td>	
								-->
								<td width="6%">
									<input type="button" value="Cancel" onclick="clearAll()" class="mainbut">	
								</td>	
								<td width="6%">
									<input type="button" value="Exit" onclick="exit()" class="mainbut">	
								</td>
								<TD WIDTH="*%"> &nbsp; </TD>
								<td width="33%" class="hh1"  align="right" >
								<!--	<B>User Confirmation </B>-->
								</td>	
								<td width="6%">
									<input type="button" value="Save" onclick="beforesubmit()" class="mainbut">	
								</td>	
								<td width="6%">
									<input type="button" value="Cancel" onclick="clearAll()" class="mainbut">	
								</td>	
								<td width="6%">
									<input type="button" value="Exit" onclick="exit()" class="mainbut">	
								</td>

								
							</tr>
							
							
						</table>	
						
							<hr>
			<table width="100%"  >
				<tr ><td height='20px' ></td></tr>
			</table>
						
					</td>
				</tr>			
				<tr >
					<td width="1%">
					</td>
					<td width="99%" align="center">
						<div id="jqgrid">
							<table id="grid"></table>
							<div id="gridpager"></div>
						</div>
					</td>	
				</tr>
				<tr>
					<td
						<DIV id=dealticket1></DIV>
				</td>	
			</tr>	
		</table>
		
		
	</FORM>
	<!-- <applet code=mf_datagateway.class width=0 height=0></applet> -->
</body>
<SCRIPT language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>
<script language="JavaScript1.2" SRC="pre_confirm.js">var g_dismsg=false;</SCRIPT>
<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>	
	</html>
	
	
	
