<HTML>
	<HEAD>
		<TITLE>Margin Trading 
		</TITLE>
		<STYLE>
			
		</STYLE>
		<%@page import="net.sasianet.ADLMARGIN.*" %>
		<%	
		
		/*
		LBMARGIN_MGT_conn_methods1 m_sn_methods = new LBMARGIN_MGT_conn_methods1();
		String m_jsp_client_url=m_sn_methods.jsp_client_url;
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
		*/	
			
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
		//out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/redmond/jquery-ui.css' TYPE=\"text/css\">");
			
		//out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
		//out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
		//out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
        //out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
			
	    %>
	</HEAD>
	<SCRIPT language="JavaScript">
		var cc;
		
		function get_vector(data_vec) {
		
		 if(document.Form1.hid_chk_status.value=='M1' && data_vec.length>0){
             //document.Form1.hid_c_status.value="Y";
					
				
			vec_pos=0;
			lineno=1;
			m_row="";
			m_size=data_vec.length;
				
			if (m_size==0) {
				alert('No Previous incomplete deals');
			}
			else{
				while (vec_pos<m_size) {
					if(parseFloat(data_vec[vec_pos+2])>=parseFloat(data_vec[vec_pos+3])){
						num=format_noobject(data_vec[vec_pos+2]);
					}
					else{
						num=format_noobject(data_vec[vec_pos+3]);
					}
					m_dealnum=data_vec[vec_pos];
					// alert("****"+data_vec[vec_pos+10));
					m_row=m_row+'<TR BGCOLOR="silver">';
					if(data_vec[vec_pos+10]=='*'){
						m_row=m_row+'<TD  ALIGN="Center"><img height=10 width=10 STYLE="{cursor:hand;}" src="star.gif" ONCLICK=display_details("'+m_dealnum+'")>'+data_vec[vec_pos]+'<INPUT TYPE="Hidden" NAME="DEALNO'+lineno+'"  ID="DEALNO'+lineno+'"  VALUE="'+data_vec[vec_pos]+'"></TD>';
					}
					else{
						m_row=m_row+'<TD  ALIGN="Center">'+data_vec[vec_pos]+'<INPUT TYPE="Hidden" NAME="DEALNO'+lineno+'" ID="DEALNO'+lineno+'" VALUE="'+data_vec[vec_pos]+'"></TD>';
					}
					
					/*add by waruna 2010-08-20
					if(data_vec[vec_pos+1)=='OUTRIGHT'){
					//alert('PURCHASE');
					del_type='PURCHASE'
					}
					else if(data_vec[vec_pos+1)=='REPO FRESH'){
					//alert('LOAN FRESH');
					del_type='LOAN FRESH'
					}
					else{
					//alert(data_vec[vec_pos+1));
					del_type=data_vec[vec_pos+1)
					}
					*/
				
				
					m_row=m_row+'<TD  ALIGN="Center">'+data_vec[vec_pos+1]+'<INPUT TYPE="Hidden" NAME="DEALTYPE'+lineno+'" ID="DEALTYPE'+lineno+'"  VALUE="'+data_vec[vec_pos+1]+'"></TD>';
					//m_row=m_row+'<TD  ALIGN="Center">'+del_type+'<INPUT TYPE="Hidden" NAME="DEALTYPE'+lineno+'" VALUE="'+data_vec[vec_pos+1)+'"></TD>';//add by waruna 2010-08-20
					m_row=m_row+'<TD  ALIGN="Center">'+data_vec[vec_pos+9]+'<INPUT TYPE="Hidden" NAME="VALE'+lineno+'" VALUE="'+data_vec[vec_pos+9]+'"></TD>';
					m_row=m_row+'<TD  ALIGN="Center">'+num+'<INPUT TYPE="Hidden" NAME="AMOUNT'+lineno+'" VALUE="'+data_vec[vec_pos+2]+'"></TD>';
					m_row=m_row+'<TD  ALIGN="Center">'+data_vec[vec_pos+4]+'<INPUT TYPE="Hidden" NAME="DEALER'+lineno+'" VALUE="'+data_vec[vec_pos+3]+'"></TD>';
					m_row=m_row+'<TD  ALIGN="Center">'+data_vec[vec_pos+5]+'</TD><INPUT TYPE="Hidden" NAME="LIMITV'+lineno+'" VALUE="'+data_vec[vec_pos+4]+'">';
					m_row=m_row+'<TD ALIGN="Center" STYLE="{color: black; font:  9pt arial;}"><INPUT TYPE="button" VALUE="Details" NAME=DETAIL'+lineno+' STYLE="{cursor:hand; color: black; font: 8pt arial;}" ONCLICK=preconfirm_report("'+m_dealnum+'")></TD>';//$$##SC
					m_row=m_row+'<TD ALIGN="Center" STYLE="{color: black; font: 9pt arial;}"><INPUT TYPE="checkbox" NAME="Text_save'+lineno+'" ID="Text_save'+lineno+'" STYLE="{ color: black; font: 8pt arial;}"  ONCLICK =chk_serial_no("'+m_dealnum+'",'+lineno+'),chk_security_no("'+m_dealnum+'",'+lineno+'),chk_scripless("'+m_dealnum+'",'+lineno+') ></TD> ';
					m_row=m_row+'<TD ALIGN="Center" STYLE="{color: black; font: 9pt arial;}"><INPUT TYPE="checkbox" NAME="Text_reject'+lineno+'" ID="Text_reject'+lineno+'" STYLE="{ color: black; font: 8pt arial;}"  ></TD> ';
					m_row=m_row+'<TD  ALIGN="Center">'+data_vec[vec_pos+7]+' </TD>';
					m_row=m_row+'<TD ALIGN="Center">'+data_vec[vec_pos+8]+'</TD>';
					m_row=m_row+'<TD ALIGN="Center" STYLE="{color: black; font: 9pt arial;}"><INPUT TYPE="button" NAME="B_fax'+lineno+'" STYLE="{cursor:hand; color: black; font: 8pt arial;}" VALUE="  Fax  "></TD> ';
					m_row=m_row+'<TD ALIGN="Center" STYLE="{color: black; font: 9pt arial;}"><INPUT TYPE="button" NAME="H_print'+lineno+'" STYLE="{cursor:hand; color: black; font: 8pt arial;}" VALUE="  Print  "></TD></TR>';
					
					vec_pos=vec_pos+11;
					lineno=lineno+1;
				}
				document.Form1.Hid_rows.value=lineno;
				
				
				m_writedata ='<TABLE WIDTH="1150"  class="table">'+
					'<TR BGCOLOR="darkgray">'+
					'<TD WIDTH="150" ALIGN="Center"><B><FONT COLOR="black">Deal Number</B></TD>' +
					'<TD WIDTH="125" ALIGN="Center"><B><FONT COLOR="black">Deal Type</B></TD>'+
					'<TD WIDTH="100" ALIGN="Center"><B><FONT COLOR="black">Value</B></TD>'+
					'<TD WIDTH="100" ALIGN="Center"><B><FONT COLOR="black">Amount</B></TD>'+
					'<TD WIDTH="100" ALIGN="Center"><B><FONT COLOR="black">Dealer</B></TD>'+
					'<TD WIDTH="125" ALIGN="Center"><B><FONT COLOR="black">Limit Violations</B></TD>'+
					'<TD WIDTH="75"  ALIGN="Center"><B><FONT COLOR="black">Details</B></TD>'+
					'<TD WIDTH="75"  ALIGN="Center"><B><FONT COLOR="black"><INPUT TYPE="checkbox" alt="Tick to Select/Unseclect" NAME="Select_All" STYLE="{ color: black; font: 8pt arial;}"  ONCLICK =select_all_checkbox();>Save</B></TD>' +//mod by waruna 2011-01-20
					'<TD WIDTH="75"  ALIGN="Center"><B><FONT COLOR="black"><INPUT TYPE="checkbox" NAME="Select_All_reject" STYLE="{ color: black; font: 8pt arial;}"  ONCLICK =select_all_checkbox_rej();>Reject</B></TD>' +//mod by waruna 2011-05-26
					'<TD WIDTH="100" ALIGN="Center"><B><FONT COLOR="black">Party1</B></TD>' +
					'<TD WIDTH="100" ALIGN="Center"><B><FONT COLOR="black">Party2</B></TD>'+
					'<TD WIDTH="100" ALIGN="Center"><B><FONT COLOR="black">Fax</B></TD>' +
					'<TD WIDTH="100" ALIGN="Center"><B><FONT COLOR="black">Print</B></TD></TR>' +
					m_row+
					'</TABLE>'; 
				dealticket1.innerHTML=m_writedata;
			
			}	
				
				
				
		    }
			
			if(document.Form1.hid_chk_status.value=='M2' && data_vec.length>0){
			
					m_size=data_vec.length;
					
					document.Form1.HID_BUY_SETT_DATE.value=data_vec[0];
					
					if(document.Form1.HID_BUY_SETT_DATE.value=="YES"){
						title="Buyer Settlement Date Error Message";
						mess="Buyer Settlement Date is not greater than Last Day End Routine Date for Deal No. "+eval("document.Form1.DEALNO"+r+".value")+" !";
						
						
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
		
		function add_data() {
			var num;
			var del_type="";
			cc=0;
			document.Form1.hid_chk_status.value='M1';
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=confirmation";
			//window.open(m_url);
			load_interface(m_url,'XML',true);
			
			//top.frames[0].document.applets[0].getdata(m_url);	  
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			/*vec_pos=0;
			lineno=1;
			m_row="";
			if (m_size==0) {
				alert('No Previous incomplete deals');
			}
			else{
				while (vec_pos<m_size) {
					if(parseFloat(data_vec[vec_pos+2))>=parseFloat(data_vec[vec_pos+3))){
						num=format_noobject(data_vec[vec_pos+2));
					}
					else{
						num=format_noobject(data_vec[vec_pos+3));
					}
					m_dealnum=data_vec[vec_pos);
					// alert("****"+data_vec[vec_pos+10));
					m_row=m_row+'<TR BGCOLOR="silver">';
					if(data_vec[vec_pos+10)=='*'){
						m_row=m_row+'<TD STYLE="{color: black; font:  9pt arial;text-align:center;} ALIGN="Center"><img height=10 width=10 STYLE="{cursor:hand;}" src="star.gif" ONCLICK=display_details("'+m_dealnum+'")>'+data_vec[vec_pos)+'<INPUT TYPE="Hidden" NAME="DEALNO'+lineno+'"  ID="DEALNO'+lineno+'" VALUE="'+data_vec[vec_pos)+'"></TD>';
					}
					else{
						m_row=m_row+'<TD STYLE="{color: black; font:  9pt arial;text-align:center;} ALIGN="Center">'+data_vec[vec_pos)+'<INPUT TYPE="Hidden" NAME="DEALNO'+lineno+'" VALUE="'+data_vec[vec_pos)+'"></TD>';
					}*/
					
					/*add by waruna 2010-08-20
					if(data_vec[vec_pos+1)=='OUTRIGHT'){
					//alert('PURCHASE');
					del_type='PURCHASE'
					}
					else if(data_vec[vec_pos+1)=='REPO FRESH'){
					//alert('LOAN FRESH');
					del_type='LOAN FRESH'
					}
					else{
					//alert(data_vec[vec_pos+1));
					del_type=data_vec[vec_pos+1)
					}
					*/
					
					/*m_row=m_row+'<TD  ALIGN="Center">'+data_vec[vec_pos+1)+'<INPUT TYPE="Hidden" NAME="DEALTYPE'+lineno+'"   VALUE="'+data_vec[vec_pos+1)+'"></TD>';
					//m_row=m_row+'<TD  ALIGN="Center">'+del_type+'<INPUT TYPE="Hidden" NAME="DEALTYPE'+lineno+'" VALUE="'+data_vec[vec_pos+1)+'"></TD>';//add by waruna 2010-08-20
					m_row=m_row+'<TD  ALIGN="Center">'+data_vec[vec_pos+9)+'<INPUT TYPE="Hidden" NAME="VALE'+lineno+'" VALUE="'+data_vec[vec_pos+9)+'"></TD>';
					m_row=m_row+'<TD  ALIGN="Center">'+num+'<INPUT TYPE="Hidden" NAME="AMOUNT'+lineno+'" VALUE="'+data_vec[vec_pos+2)+'"></TD>';
					m_row=m_row+'<TD  ALIGN="Center">'+data_vec[vec_pos+4)+'<INPUT TYPE="Hidden" NAME="DEALER'+lineno+'" VALUE="'+data_vec[vec_pos+3)+'"></TD>';
					m_row=m_row+'<TD  ALIGN="Center">'+data_vec[vec_pos+5)+'</TD><INPUT TYPE="Hidden" NAME="LIMITV'+lineno+'" VALUE="'+data_vec[vec_pos+4)+'">';
					m_row=m_row+'<TD ALIGN="Center" STYLE="{color: black; font:  9pt arial;}"><INPUT TYPE="button" VALUE="Details" NAME=DETAIL'+lineno+' STYLE="{cursor:hand; color: black; font: 8pt arial;}" ONCLICK=preconfirm_report("'+m_dealnum+'")></TD>';//$$##SC
					m_row=m_row+'<TD ALIGN="Center" STYLE="{color: black; font: 9pt arial;}"><INPUT TYPE="checkbox" NAME="Text_save'+lineno+'" ID="Text_save'+lineno+'" STYLE="{ color: black; font: 8pt arial;}"  ONCLICK =chk_serial_no("'+m_dealnum+'",'+lineno+'),chk_security_no("'+m_dealnum+'",'+lineno+'),chk_scripless("'+m_dealnum+'",'+lineno+') ></TD> ';
					m_row=m_row+'<TD ALIGN="Center" STYLE="{color: black; font: 9pt arial;}"><INPUT TYPE="checkbox" NAME="Text_reject'+lineno+'" ID="Text_reject'+lineno+'" STYLE="{ color: black; font: 8pt arial;}"  ></TD> ';
					m_row=m_row+'<TD  ALIGN="Center">'+data_vec[vec_pos+7)+' </TD>';
					m_row=m_row+'<TD STYLE="{color: black; font:  9pt arial;text-align:center;} ALIGN="Center">'+data_vec[vec_pos+8)+'</TD>';
					m_row=m_row+'<TD ALIGN="Center" STYLE="{color: black; font: 9pt arial;}"><INPUT TYPE="button" NAME="B_fax'+lineno+'" STYLE="{cursor:hand; color: black; font: 8pt arial;}" VALUE="  Fax  "></TD> ';
					m_row=m_row+'<TD ALIGN="Center" STYLE="{color: black; font: 9pt arial;}"><INPUT TYPE="button" NAME="H_print'+lineno+'" STYLE="{cursor:hand; color: black; font: 8pt arial;}" VALUE="  Print  "></TD></TR>';
					
					vec_pos=vec_pos+11;
					lineno=lineno+1;
				}
				document.Form1.Hid_rows.value=lineno;
				
				
				m_writedata ='<TABLE WIDTH="1150" BGCOLOR="silver" STYLE="{color: black; font: 10pt arial;}">'+
					'<TR BGCOLOR="darkgray">'+
					'<TD WIDTH="150" ALIGN="Center"><B><FONT COLOR="black">Deal Number</B></TD>' +
					'<TD WIDTH="125" ALIGN="Center"><B><FONT COLOR="black">Deal Type</B></TD>'+
					'<TD WIDTH="100" ALIGN="Center"><B><FONT COLOR="black">Value</B></TD>'+
					'<TD WIDTH="100" ALIGN="Center"><B><FONT COLOR="black">Amount</B></TD>'+
					'<TD WIDTH="100" ALIGN="Center"><B><FONT COLOR="black">Dealer</B></TD>'+
					'<TD WIDTH="125" ALIGN="Center"><B><FONT COLOR="black">Limit Violations</B></TD>'+
					'<TD WIDTH="75"  ALIGN="Center"><B><FONT COLOR="black">Details</B></TD>'+
					'<TD WIDTH="75"  ALIGN="Center"><B><FONT COLOR="black"><INPUT TYPE="checkbox" alt="Tick to Select/Unseclect" NAME="Select_All" STYLE="{ color: black; font: 8pt arial;}"  ONCLICK =select_all_checkbox();>Save</B></TD>' +//mod by waruna 2011-01-20
					'<TD WIDTH="75"  ALIGN="Center"><B><FONT COLOR="black"><INPUT TYPE="checkbox" NAME="Select_All_reject" STYLE="{ color: black; font: 8pt arial;}"  ONCLICK =select_all_checkbox_rej();>Reject</B></TD>' +//mod by waruna 2011-05-26
					'<TD WIDTH="100" ALIGN="Center"><B><FONT COLOR="black">Party1</B></TD>' +
					'<TD WIDTH="100" ALIGN="Center"><B><FONT COLOR="black">Party2</B></TD>'+
					'<TD WIDTH="100" ALIGN="Center"><B><FONT COLOR="black">Fax</B></TD>' +
					'<TD WIDTH="100" ALIGN="Center"><B><FONT COLOR="black">Print</B></TD></TR>' +
					m_row+
					'</TABLE>'; 
				dealticket1.innerHTML=m_writedata;	
			}*/
		}
		
		function select_all_checkbox(){
			max_recode=document.Form1.Hid_rows.value   
				
				if(document.Form1.Select_All.checked==true){
					for(t=1;t<max_recode;t++){
						chk_box_name='Text_save'+t;
						txt_deal_name='DEALNO'+t;
						//document.Form1.getElementsByName('Text_save1').checked=true;
						//document.Form1.getElementsByName(chk_box_name).checked=true;
						
						m_dealnum=document.getElementById(txt_deal_name).value;
						//alert(m_dealnum);
						document.getElementById(chk_box_name).checked=true;
						chk_serial_no(m_dealnum,t);
						chk_security_no(m_dealnum,t);
						chk_scripless(m_dealnum,t);
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
		
		
		function select_all_checkbox_rej(){
			max_recode=document.Form1.Hid_rows.value   
				
				if(document.Form1.Select_All_reject.checked==true){
					for(t=1;t<max_recode;t++){
						chk_box_name='Text_reject'+t;
						txt_deal_name='DEALNO'+t;
						//document.Form1.getElementsByName('Text_save1').checked=true;
						//document.Form1.getElementsByName(chk_box_name).checked=true;
						
						m_dealnum=document.getElementById(txt_deal_name).value;
						//alert(m_dealnum);
						document.getElementById(chk_box_name).checked=true;
						//chk_serial_no(m_dealnum,t);
						//chk_security_no(m_dealnum,t);
						//chk_scripless(m_dealnum,t);
						///break;
					}
					
				}else{
					for(t=1;t<max_recode;t++){
						chk_box_name='Text_reject'+t;
						//document.Form1.getElementsByName('Text_save1').checked=true;
						//document.Form1.getElementsByName(chk_box_name).checked=true;
						document.getElementById(chk_box_name).checked=false;
						///break;
					}
					
				}	 
		}
		
		//=============== Added by Shanheetha on 12-07-2006 for VC06/012 ================================================
		
		
		/*function checkbuyersettlementdate2(m_dealnum,lineno){
		if(m_dealnum.substring(0,2)=="OR"){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?dealrefno="+m_dealnum+"&chksql=chk_buy_sett_date2";
				top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				
				document.Form1.HID_BUY_SETT_DATE.value=data_vec[0);
						
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
					
					document.Form1.hid_chk_status.value='M2';
				//	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?dealrefno="+eval("document.Form1.DEALNO"+r+".value")+"&chksql=chk_buy_sett_date2";
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?dealrefno="+eval("document.Form1.DEALNO"+r+".value")+"&chksql=chk_buy_sett_date_check2";
					load_interface(m_url,'XML',true);
					
					/*top.frames[0].document.applets[0].getdata(m_url);
					m_size=top.frames[0].document.applets[0].outvec_value.size();
					
					document.Form1.HID_BUY_SETT_DATE.value=data_vec[0);
					
					if(document.Form1.HID_BUY_SETT_DATE.value=="YES"){
						title="Buyer Settlement Date Error Message";
						mess="Buyer Settlement Date is not greater than Last Day End Routine Date for Deal No. "+eval("document.Form1.DEALNO"+r+".value")+" !";
						
						
						v_check="Text_save"+r;
						v_check_1=document.Form1.elements[v_check];
						v_check_1.checked = false ;
						
						icon=1;
						mods=0;
						makeMsgBox(title,mess,icon,0,0,mods)
						
						
					}
					else {
					}*/
				}
			}	
		}
		
		//======================= End ==================================================================================	
		
		
		function beforesubmit() {
			r=1;
			
			//checkbuyersettlementdate2();//--- Added by Shanheetha on 12-07-2006 for VC06-012.
			
			if(chk_confirmed_deal()){
				unable_checkbox();
				Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsavedeal"; 
				Form1.submit();
			}
		}		
		
		// ----- The Following Function Was Added By upul On 01/03/2000 ---------COUNT------ //
		function beforesubmit_dealTiket(Obj) {
			cc=cc+1;
			document.Form1.Hid_scr_name.value="confirm_dealticket";
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
			
				load_interface(m_url,'XML',false);
				m_size=data_vec.length;
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				//	alert(m_size);
				
				if (m_size!==0) {	 
					
					
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmChk*";
						load_interface(m_url,'XML',false);
				         m_size=data_vec.length;
					//top.frames[0].document.applets[0].getdata(m_url);
					//m_size=top.frames[0].document.applets[0].outvec_value.size();
					//alert(m_size);	
					//	 if (m_size ==0) {					
					
					
					
					if (m_size!==0) {	 				
						
						
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmChk";
						//top.frames[0].document.applets[0].getdata(m_url);
						//m_size=top.frames[0].document.applets[0].outvec_value.size();
						load_interface(m_url,'XML',false);
				         m_size=data_vec.length;
						//	alert(m_size);	
						if (m_size ==0) {
							alert(m_dealnum +' Allocate serial numbers prior to  the confirmation'); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:8 --->
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
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();	
				load_interface(m_url,'XML',false);
				m_size=data_vec.length;
				//alert("RRSerialcheck1*"+m_size);
				if (m_size!==0) {	 				
					
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmSerialChk2RR";
					//top.frames[0].document.applets[0].getdata(m_url);
					//m_size=top.frames[0].document.applets[0].outvec_value.size();
					load_interface(m_url,'XML',false);
				    m_size=data_vec.length;
					//alert("RRSerialcheck2**"+m_size);
					if (m_size!==0) {	 			 	 								 
						
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmSerialChk3RR";
						//top.frames[0].document.applets[0].getdata(m_url);
						//m_size=top.frames[0].document.applets[0].outvec_value.size();
						load_interface(m_url,'XML',false);
				        m_size=data_vec.length;
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
			
			
			//add by waruna 2011-02-14
			else if((m_dealnum.substring(0,2)=="OR")){
				
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?deal_no="+m_dealnum+"&chksql=deal_chk";
				//window.open(m_url);
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				load_interface(m_url,'XML',false);
			    m_size=data_vec.length;
				if (m_size !=1) {
					alert('Can not confirm'); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:8 --->
					v_check="Text_save"+lineno;
					v_check_1=document.Form1.elements[v_check];
					v_check_1.checked = false ; 
				}//end msize3
				
				
			}	//end RR
			
		}
		
		function chk_scripless(m_dealnum,lineno){//$$##SC
			if(m_dealnum.substring(0,2)=="OR"){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chksc"; 
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				load_interface(m_url,'XML',false);
			    m_size=data_vec.length;
				if(m_size>0){
					if((data_vec[0]=="SL")&&(data_vec[1]=="P")){//&&(data_vec[2)=="S")
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chksec_tab";
						//window.open(m_url);
						//top.frames[0].document.applets[0].getdata(m_url);
						//m_size=top.frames[0].document.applets[0].outvec_value.size();
						//	alert(top.frames[0].document.applets[0].outvec_value);
						load_interface(m_url,'XML',false);
			            m_size=data_vec.length;
						if(data_vec[0]==0){
							alert(m_dealnum +" Allocate serial numbers prior to the confirmation"); <!---**commented by inditha FOR VC05-002  on 12-7-2005/11:8 --->
							v_check="Text_save"+lineno;
							v_check_1=document.Form1.elements[v_check];
							v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:8 --->
						}
					}
				}
			}//OR
			if(m_dealnum.substring(0,2)=="RF"){//$$##SC
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chksc_rf"; 
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				//alert(top.frames[0].document.applets[0].outvec_value);
				load_interface(m_url,'XML',false);
			    m_size=data_vec.length;
				if(m_size>0){
					if((data_vec[0]=="SL")&&(data_vec[1]=="P")){
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chksec_tab_rf";
						//top.frames[0].document.applets[0].getdata(m_url);
						//m_size=top.frames[0].document.applets[0].outvec_value.size();
						load_interface(m_url,'XML',false);
			            m_size=data_vec.length;
						//alert(top.frames[0].document.applets[0].outvec_value);
						if(data_vec[0]==0){
							alert(m_dealnum+ " Allocate serial numbers prior to  the confirmation"); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:9 --->
							v_check="Text_save"+lineno;
							v_check_1=document.Form1.elements[v_check];
							//v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:9 --->
						}
					}
					else if ((data_vec[0]=="SL")&&(data_vec[1]=="C")){
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chksecurity_tab_rf";
						//top.frames[0].document.applets[0].getdata(m_url);
						//m_size=top.frames[0].document.applets[0].outvec_value.size();
						load_interface(m_url,'XML',false);
			            m_size=data_vec.length;
						//alert(top.frames[0].document.applets[0].outvec_value);
						if(data_vec[0]==0){
							alert(m_dealnum+" Allocate securities prior to  the confirmation");  <!---commented by inditha FOR VC05-002  on 12-7-2005/11:9 --->
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
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				load_interface(m_url,'XML',false);
			    m_size=data_vec.length;
				//alert("RRSLheck1*"+m_size);
				//alert(data_vec[0));
				//alert(data_vec[1));
				if(m_size>0){
					if((data_vec[0]=="SL")&&(data_vec[1]=="P")){
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chkSERIAL_RR";
						//top.frames[0].document.applets[0].getdata(m_url);
						//m_size=top.frames[0].document.applets[0].outvec_value.size();
						load_interface(m_url,'XML',false);
			            m_size=data_vec.length;
						//alert("RRSLheck1**"+m_size);
						if(data_vec[0]==0){
							alert(m_dealnum+" Allocate serial numbers prior to  the confirmation"); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:9 --->
							v_check="Text_save"+lineno;
							v_check_1=document.Form1.elements[v_check];
							//v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:9 --->
						}
					}
					else if ((data_vec[0]=="SL")&&(data_vec[1]=="C")){
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chkSECURITY_RR";
						//top.frames[0].document.applets[0].getdata(m_url);
						//m_size=top.frames[0].document.applets[0].outvec_value.size();
						load_interface(m_url,'XML',false);
			            m_size=data_vec.length;
						//alert("RRSLheck1***"+m_size);
						if(data_vec[0]==0){
							alert(m_dealnum+" Allocate securities prior to  the confirmation"); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:9 --->
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
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				load_interface(m_url,'XML',false);
			    m_size=data_vec.length;
				if (m_size!==0) {
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmChk2";
					//top.frames[0].document.applets[0].getdata(m_url);
					//m_size=top.frames[0].document.applets[0].outvec_value.size();
					load_interface(m_url,'XML',false);
			        m_size=data_vec.length;
					if (m_size!==0) {
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmChk*";
						//top.frames[0].document.applets[0].getdata(m_url);
						//m_size=top.frames[0].document.applets[0].outvec_value.size();
						load_interface(m_url,'XML',false);
			        m_size=data_vec.length;
						if (m_size!==0) {	 	
							m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmChk3";
							///top.frames[0].document.applets[0].getdata(m_url);
							//m_size=top.frames[0].document.applets[0].outvec_value.size();
							load_interface(m_url,'XML',false);
			                m_size=data_vec.length;
							if (m_size==0) {
								alert(m_dealnum+' Allocate securities prior to  the confirmation'); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:10 --->
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
				//window.open(murl);
				//top.frames[0].document.applets[0].getdata(murl);
				//msize=top.frames[0].document.applets[0].outvec_value.size();
					 load_interface(murl,'XML',false);
			         msize=data_vec.length;
				//alert(top.frames[0].document.applets[0].outvec_value);
				//alert(msize);
				if(msize>0){
					alert(m_dealnum+" Please allocate Serial numbers prior to the Confirmation"); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:10 --->
					v_check="Text_save"+lineno;
					v_check_1=document.Form1.elements[v_check];  
					v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:10 --->
				}
			}
			else if((m_dealnum.substring(0,2)=="RR")){ //added By Keith on 9-9-2004/9:28 
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=checkborrrr";//YASOADDED
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				load_interface(m_url,'XML',false);
			    m_size=data_vec.length;
				if (m_size!==0) {
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmSecurityChk1RR";
					//top.frames[0].document.applets[0].getdata(m_url);
					//m_size=top.frames[0].document.applets[0].outvec_value.size();
					load_interface(m_url,'XML',false);
			        m_size=data_vec.length;
					//alert("RRSeccheck1*"+m_size);
					if (m_size!==0) {
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmSecurityChk2RR";
						//top.frames[0].document.applets[0].getdata(m_url);
						//m_size=top.frames[0].document.applets[0].outvec_value.size();
							load_interface(m_url,'XML',false);
			                m_size=data_vec.length;
						//alert("RRSeccheck2**"+m_size);
						if (m_size!==0) {	 	
							m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmSecurityChk3RR";
							//top.frames[0].document.applets[0].getdata(m_url);
							//m_size=top.frames[0].document.applets[0].outvec_value.size();
							//alert("RRSeccheck3***"+m_size);
							load_interface(m_url,'XML',false);
			                m_size=data_vec.length;
							if (m_size==0) {
								alert(m_dealnum+' Allocate securities prior to  the confirmation'); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:10 --->
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
			for(var r=1;document.Form1.Hid_rows.value>r;r++){
				if(eval("document.Form1.Text_save"+r+".checked")) {
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?deal_num="+eval("document.Form1.DEALNO"+r+".value")+"&chksql=checked_confirmdeals";
					//top.frames[0].document.applets[0].getdata(m_url);
					load_interface(m_url,'XML',false);
			        m_size=data_vec.length;
					if(data_vec[0]=="CONF"){
						title="DealNet Generate Confirmation Error Message";
						mess="This deal "+eval("document.Form1.DEALNO"+r+".value")+" has been already confirmed";
						
						icon=1;
						mods=0;
						makeMsgBox(title,mess,icon,0,0,mods)
						
						return false;
						break;
					}
					else {
						return true;
					}
				}
			}	
		}
		
		
		function chk_rejected_deal() {
			for(var r=1;document.Form1.Hid_rows.value>r;r++){
				if(eval("document.Form1.Text_reject"+r+".checked")) {
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?deal_num="+eval("document.Form1.DEALNO"+r+".value")+"&chksql=checked_confirmdeals";
					//top.frames[0].document.applets[0].getdata(m_url);
					load_interface(m_url,'XML',false);
			        m_size=data_vec.length;
					if(data_vec[0]=="CANCEL"){
						title="DealNet Generate Confirmation Error Message";
						mess="This deal "+eval("document.Form1.DEALNO"+r+".value")+" has been already rejected";
						
						icon=1;
						mods=0;
						makeMsgBox(title,mess,icon,0,0,mods)
						
						return false;
						break;
					}
					else {
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
		
		//Added by Susitha 23-05-2011
		
		function beforesubmit_reject() {

			r=1;
			document.Form1.Hid_scr_name.value="reject_dealticket";
			if(chk_rejected_deal()){
				unable_checkbox();
				Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsavedeal"; 
				Form1.submit();
			}
		}
		
		
	</SCRIPT>
	
	<SCRIPT LANGUAGE=VBScript TYPE="text/vbscript">
		Function makeMsgBox(title,mess,icon,buts,defbut,mods)
			butVal = buts + (icon*16) + (defbut*256) + (mods*4096)
			makeMsgBox = MsgBox(mess,butVal,title)  
			
		End Function
		
	</SCRIPT>
	
	
	<BODY onLoad="add_data()" class='body & txt-body' leftmargin='0' topmargin='0' marginwidth='0' >
		<FORM NAME="Form1" ID="Form1" METHOD="POST" >
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="confirm_dealticket">
			<INPUT TYPE="Hidden" NAME="Hid_rows" >
			<INPUT TYPE="Hidden" NAME="Hid_dealValue" >
			<INPUT TYPE="Hidden" NAME="hid_chk_status" >
			
			<INPUT TYPE="Hidden" NAME="HID_BUY_SETT_DATE" VALUE="" >
			<DIV id=dealticket1></DIV>
			
		</FORM>
		<!--<applet code=mf_datagateway.class width=0 height=0></applet>-->
	</body>
	<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
	<SCRIPT language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>
	<script language="JavaScript1.2" SRC="pre_confirm.js">var g_dismsg=false;</SCRIPT>
</html>



