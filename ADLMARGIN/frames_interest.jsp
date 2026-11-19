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
		
	</HEAD>		
	
	<SCRIPT language="JavaScript1.2">
		var s_status=false;
		j=1,k=0,p=1,q=0;
		function default_actions() {	
			setInterval("set_timer_actions()",120000);
		}			
		
		function set_timer_actions() {	
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mfsenddata2?chksql=idle";			
			// m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mf_senddata2?chksql=idle";			
		}
		
		
		function chk_option(){	
			top.frames[1].frames[0].document.Form1.Exit_but.disabled=false;
			if (top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==0){				 		 
				document.Form1.Text_denominator.disabled=false;	
				document.Form1.Text_help.disabled=true;	
				document.Form1.Text_base_code.disabled=true;			
				dynamic_instrument();
				dynamic_activity();	
			}else if (top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==1){
				top.frames[1].frames[1].document.Form1.Text_denominator.disabled=true;			
			}			
		}
				
		function dynomic_text(){
			document.Form1.Text_base_code.value="";
			document.Form1.Text_desc.value="";			
			
			if(document.Form1.Text_denominator.value=="UD") {
				m_row="";
				m_writedata ='<TABLE WidTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0"> '+
					'<BGCOLOR="silver"><TD WIDTH="1%"></TD> '+
					'<TD WIDTH="25%" >Number of Days</TD><TD WIDTH="74%"><INPUT TYPE="Text" class="txt_input6" NAME="Text_ud_denominator" SIZE=15 onBlur=chk_Text_ud_denominator();></TD>'+
					m_row+
					'</TABLE>'; 
				othertextbox.innerHTML=m_writedata;
				if (top.frames[1].frames[0].document.Form1.option_selected.value==0){
					if (otherinstrument.innerHTML==""){			
						modify_instrument();								
						modify_activity();						
					}		
				}				
			}else {
			  dynamic_desc();
				othertextbox.innerHTML=""; 
			}			
		}	
		 
		function dynamic_desc(){
			document.Form1.Text_base_code.disabled=false;
			document.Form1.Text_desc.disabled=false;
		  if(document.Form1.Text_denominator.value=="UD") {
			   document.Form1.Text_base_code.value="A"+document.Form1.Text_ud_denominator.value;
			   document.Form1.Text_desc.value="Act/"+document.Form1.Text_ud_denominator.value;
			}
			else {
			   document.Form1.Text_base_code.value="AA";
				 	
			   document.Form1.Text_desc.value="Act/Act";
			}
			
			if (top.frames[1].frames[0].document.Form1.option_selected.value==""){
				document.Form1.Text_base_code.disabled=true;
				document.Form1.Text_desc.disabled=true;			
				top.frames[1].frames[0].document.Form1.option_selected.value=0;
			}					
			if (top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==0){				 		 
			  chk_base_code();
			}	
		}		
		
		function chk_base_code() { 			
				
			if (document.Form1.Text_base_code.value==""){
				if(confirm("Press OK to Exit CANCEL for Help")) {											
					document.Form1.Text_base_code.disabled=true;					
					document.Form1.save_but.disabled=true;					
				}else{				
					 base_code_help(0);
				}				
			}
			else
			{						
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalbasecode?chksql=chk_base&base_code="+document.Form1.Text_base_code.value+"&base_option="+top.frames[1].frames[0].document.Form1.option_selected.value;
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();	
				
				load_interface(m_url,'XML',false);
			    m_size = data_vec.length;
				
				if (top.frames[1].frames[0].document.Form1.option_selected.value==0){			
					if (m_size > 0 ) {					
						if(confirm("Base code already exist ... Exit ? ! Press OK to Exit")) {						
							document.Form1.Text_base_code.value="";
							document.Form1.Text_desc.value="";
							document.Form1.Text_denominator.disabled=true;
						}		
						else{
							document.Form1.Text_base_code.value="";
							document.Form1.Text_desc.value="";
						  document.Form1.Text_denominator.focus();		
						  document.Form1.Text_denominator.value="";		
						}					
					}	
				}
				
				if (top.frames[1].frames[0].document.Form1.option_selected.value==1 || top.frames[1].frames[0].document.Form1.option_selected.value==4) {			
					if (m_size == 0 ) {
						if(confirm("Invalid Base Code ...!  Press OK for Help")) {						
							base_code_help()
						}		
						else{
								document.Form1.Text_base_code.focus();
						}							
					} else {				
							document.Form1.Text_desc.value=data_vec[0];												
							modify_instrument();								
							modify_activity();
					}							
				}
				
			  else if (top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==4){	
					document.Form1.Text_desc.value=top.frames[0].document.applets[0].outvec_value.elementAt(0);												
					modify_instrument();								
					modify_activity();
				}
				else if (top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==2){ //de activate
					if (m_size == 0 ) {
						if(confirm("Invalid Base Code ...!  Press OK for Help")) {						
							base_code_help()
						}		
						else{
								document.Form1.Text_base_code.value="";
								document.Form1.Text_base_code.focus();
						}		
					}else	if (top.frames[0].document.applets[0].outvec_value.elementAt(1)=="N"){					 
							alert("This code is already De-Active");
							document.Form1.Text_base_code.value="";
							document.Form1.Text_base_code.focus();						
					}else{
					  document.Form1.Text_desc.value=top.frames[0].document.applets[0].outvec_value.elementAt(0);												
						modify_instrument();								
						modify_activity();				
					}				
				}else if (top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==3){ //Re activate
					if (m_size == 0 ) {
						if(confirm("Invalid Base Code ...!  Press OK for Help")) {						
							base_code_help()
						}		
						else{
								document.Form1.Text_base_code.value="";
								document.Form1.Text_base_code.focus();
						}		
					}else	if (top.frames[0].document.applets[0].outvec_value.elementAt(1)=="Y"){					 
							alert("This code is already Active");
							document.Form1.Text_base_code.value="";
							document.Form1.Text_base_code.focus();						
					}else{
					 	document.Form1.Text_desc.value=top.frames[0].document.applets[0].outvec_value.elementAt(0);												
						modify_instrument();								
						modify_activity();				
					}				
				}				
			}
		} 
		
	  // user defined denominator (No of Days)
		function chk_Text_ud_denominator(){					
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalbasecode?chksql=chk_Text_ud&Text_ud_denominator="+"A"+document.Form1.Text_ud_denominator.value;		
			top.frames[0].document.applets[0].getdata(m_url);																									
			m_size=top.frames[0].document.applets[0].outvec_value.size();							
			if (m_size > 0 ) {
				alert("User Defined Denominator Already Exist ... ");						
				document.Form1.Text_ud_denominator.focus();
				document.Form1.Text_ud_denominator.value="";
			}	  		
			else{
				dynamic_desc();				
			}
		}
   
		function myDialogObj() {
			var htmlstr; 
			var returnval;
		}		

		function base_code_mod_help(m_strat){			
		
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	
		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.Text_base_code;
 		myObject[1]=null;
 		myObject[2]=null;
 		myObject[3]=null;
 		myObject[4]=null;
  
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.Text_base_code.value;
 		myObject_value[1]=null;//aForm.oLastName2.value;
 		myObject_value[2]=null;
 		myObject_value[3]=null;
 		myObject_value[4]=null;
 
 
 		var myObject_type=new Array(); //passing values data type
 		myObject_type[0]="StringL";
 		myObject_type[1]=null;
 		myObject_type[2]=null;
 		myObject_type[3]=null;
 		myObject_type[4]=null;
 
 		var qid='108';

 		var url = 'popup.jsp';
 		var json_text = JSON.stringify(myObject_value, null,0);
 		var json_obj_type_text=JSON.stringify(myObject_type, null,0);
 		var fn_name=arguments.callee.name;
			
		if(fn_name==undefined){
		re = /^function\s+([^(]+)/;
        fn_name=re.exec(arguments.callee.toString())[1];
		}	
		//JSON.parse(str) 
		//alert(json_text);
       	$.showModalDialog({
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400,// 500,
		 width: 400,//900,
		 title: 'SasiNet Frame work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
		}				
		
		// instruments add
		function dynamic_instrument(){		 		
		  j=1,k=0,p=1,q=0;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalbasecode?chksql=instruments";
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();	
			m_row="";
		  m_row='<TR>'+
			  '<TD WidTH="70%"  >Instrument Type </TD>'+
				'<TD WidTH="15%"  >Default</TD>'+
				'<TD WidTH="15%"  >Applicable</TD>'+
			  '</TR>';
			while (j<= m_size & k<m_size){
					m_row=m_row+'<TR>'+
							'<TD WIDTH="70%"><INPUT TYPE="Text" NAME="Text_instrument'+j+'" VALUE="'+top.frames[0].document.applets[0].outvec_value.elementAt(k+1)+'" DISABLED SIZE=40><INPUT TYPE="hidden" NAME="hid_instrumentcode'+j+'" VALUE="'+top.frames[0].document.applets[0].outvec_value.elementAt(k)+'" ></TD>'+
							'<TD WidTH="15%"><INPUT TYPE="checkbox" NAME="Chb_default_inst'+j+'"></TD>'+
							'<TD WidTH="15%"><INPUT TYPE="checkbox" NAME="Chb_applicable_inst'+j+'"></TD>'+
							'</TR>'; 
						   k=k+2;
						   j=j+1;
			}	
			document.Form1.Hid_scr_name.value="Interest_New"
			document.Form1.Hid_inst_cnt.value=j-1;
			m_writedata ='<TABLE border=0 WIDTH="75%">'+m_row+'<TABLE>';
			otherinstrument.innerHTML=otherinstrument.innerHTML+m_writedata;			
		}		
		
		// instruments modify/view
		function modify_instrument(){		 
			otherinstrument.innerHTML=""
		  j=1,k=0,p=1,q=0;				
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalbasecode?chksql=modi_instruments&modi_base_code="+document.Form1.Text_base_code.value
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();		
			m_row="";			
		  m_row='<TR>'+
			  '<TD WidTH="70%"  >Instrument Type </TD>'+
				'<TD WidTH="15%"  >Default</TD>'+
				'<TD WidTH="15%"  >Applicable</TD>'+
			  '</TR>';				
			while (j<= m_size & k<m_size-3){
					m_row =m_row+'<TR>'+
							'<TD WIDTH="70%"><INPUT TYPE="Text" NAME="Text_instrument'+j+'" VALUE="'+top.frames[0].document.applets[0].outvec_value.elementAt(k+1)+'" DISABLED SIZE=40><INPUT TYPE="hidden" NAME="hid_instrumentcode'+j+'" VALUE="'+top.frames[0].document.applets[0].outvec_value.elementAt(k)+'"></TD>';																																
							
							if (top.frames[0].document.applets[0].outvec_value.elementAt(k+2)=="Y"){							
								if (top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==2 || top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==3 || top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==4){	
									m_row =m_row+'<TD WidTH="15%"><INPUT TYPE="checkbox" NAME="Chb_default_inst'+j+'" CHECKED DISABLED></TD>';
								}else{
									m_row =m_row+'<TD WidTH="15%"><INPUT TYPE="checkbox" NAME="Chb_default_inst'+j+'" CHECKED></TD>';
								}								
							}
							else{
							  if (top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==2 || top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==3 || top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==4  ){	
								  m_row =m_row+'<TD WidTH="15%"><INPUT TYPE="checkbox" NAME="Chb_default_inst'+j+'"DISABLED></TD>';   
								}else{
								  m_row =m_row+'<TD WidTH="15%"><INPUT TYPE="checkbox" NAME="Chb_default_inst'+j+'"></TD>';   
								}
							}							
			
							if (top.frames[0].document.applets[0].outvec_value.elementAt(k+3)=="Y"){							
								if (top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==2 || top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==3 || top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==4  ){	
									m_row =m_row+'<TD WidTH="15%"><INPUT TYPE="checkbox" NAME="Chb_applicable_inst'+j+'" CHECKED DISABLED></TD>';
								}else{
									m_row =m_row+'<TD WidTH="15%"><INPUT TYPE="checkbox" NAME="Chb_applicable_inst'+j+'" CHECKED></TD>';
								}
							} 																																												
							else{
								if (top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==2 || top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==3 || top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==4  ){	
									m_row =m_row+'<TD WidTH="15%"><INPUT TYPE="checkbox" NAME="Chb_applicable_inst'+j+'" DISABLED></TD>';   
								}else{
									m_row =m_row+'<TD WidTH="15%"><INPUT TYPE="checkbox" NAME="Chb_applicable_inst'+j+'"></TD>';   								
								}								
							}
							m_row =m_row+'</TR>'; 							
					    k=k+4;
						  j=j+1;
			}	
			if (top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==1){			
				document.Form1.Hid_scr_name.value="Interest_modi"
			}else if(top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==2){
				document.Form1.Hid_scr_name.value="Interest_deacti"	
			}else if(top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==3){
				document.Form1.Hid_scr_name.value="Interest_reacti"	
			}	
			
			document.Form1.Hid_inst_modi_cnt.value=j-1;
			m_writedata ='<TABLE border=0 WIDTH="75%">'+m_row+'<TABLE>';
			otherinstrument.innerHTML=otherinstrument.innerHTML+m_writedata;		
  	}
		
		// applicable activity types add
		function dynamic_activity(){			
			j=1,k=0,p=1,q=0;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalbasecode?chksql=activity";
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();		
			m_row="";
		  m_row='<TR>'+
			  '<TD WidTH="70%"  >Activity Type</TD>'+
				'<TD WidTH="15%"  >Default</TD>'+
				'<TD WidTH="15%"  >Applicable</TD>'+
			  '</TR>';				
				
			while (j<= m_size & k<m_size){ 
					m_row =m_row+'<TR>'+
							'<TD WIDTH="70%"><INPUT TYPE="Text" NAME="Text_activity'+j+'" VALUE="'+top.frames[0].document.applets[0].outvec_value.elementAt(k+1)+'" DISABLED SIZE=40><INPUT TYPE="hidden" NAME="hid_activity'+j+'" VALUE="'+top.frames[0].document.applets[0].outvec_value.elementAt(k)+'" ></TD>'+							
							'<TD WidTH="15%"><INPUT TYPE="checkbox" NAME="Chb_default_acti'+j+'"></TD>'+
							'<TD WidTH="15%"><INPUT TYPE="checkbox" NAME="Chb_applicable_acti'+j+'"></TD>'+
							'</TR>'; 
						   k=k+2;
						   j=j+1;
			}	
			document.Form1.Hid_scr_name.value="Interest_New"
			document.Form1.Hid_acti_cnt.value=j-1;
			m_writedata ='<TABLE border=0 WIDTH="75%">'+m_row+'<TABLE>';
			otheractivity.innerHTML=otheractivity.innerHTML+m_writedata;			
		}		
	
	  // applicable activity types modify/view
  	function modify_activity(){		 
			otheractivity.innerHTML=""
		  j=1,k=0,p=1,q=0;				
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalbasecode?chksql=modi_activity&modi_base_code="+document.Form1.Text_base_code.value
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();							
			m_row="";			
		  m_row='<TR>'+
			  '<TD WidTH="70%"  >Activity Type </TD>'+
				'<TD WidTH="15%"  >Default</TD>'+
				'<TD WidTH="15%"  >Applicable</TD>'+
			  '</TR>';				
			while (j<= m_size & k<m_size-3){
					m_row =m_row+'<TR>'+
							'<TD WIDTH="70%"><INPUT TYPE="Text" NAME="Text_activity'+j+'" VALUE="'+top.frames[0].document.applets[0].outvec_value.elementAt(k+1)+'" DISABLED  SIZE=40><INPUT TYPE="hidden" NAME="hid_activity'+j+'" VALUE="'+top.frames[0].document.applets[0].outvec_value.elementAt(k)+'"></TD>';																																
							if (top.frames[0].document.applets[0].outvec_value.elementAt(k+2)=="Y"){							
								if (top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==2 || top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==3 || top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==4  ){	
									m_row =m_row+'<TD WidTH="15%"><INPUT TYPE="checkbox" NAME="Chb_default_acti'+j+'" CHECKED DISABLED></TD>';
								}else{
									m_row =m_row+'<TD WidTH="15%"><INPUT TYPE="checkbox" NAME="Chb_default_acti'+j+'" CHECKED></TD>';
								}
							}
							else{
								if (top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==2 || top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==3 || top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==4  ){	
									m_row =m_row+'<TD WidTH="15%"><INPUT TYPE="checkbox" NAME="Chb_default_acti'+j+'" DISABLED></TD>';   
								}else{
									m_row =m_row+'<TD WidTH="15%"><INPUT TYPE="checkbox" NAME="Chb_default_acti'+j+'"></TD>';   								
								}								
							}													
			
							if (top.frames[0].document.applets[0].outvec_value.elementAt(k+3)=="Y"){							
								if (top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==2 || top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==3 || top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==4  ){	
									m_row =m_row+'<TD WidTH="15%"><INPUT TYPE="checkbox" NAME="Chb_applicable_acti'+j+'" CHECKED DISABLED></TD>';
								}else{
									m_row =m_row+'<TD WidTH="15%"><INPUT TYPE="checkbox" NAME="Chb_applicable_acti'+j+'" CHECKED></TD>';
								}
							}
							else{
								if (top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==2 || top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==3 || top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==4  ){	
									m_row =m_row+'<TD WidTH="15%"><INPUT TYPE="checkbox" NAME="Chb_applicable_acti'+j+'" DISABLED></TD>';   
								}else{
									m_row =m_row+'<TD WidTH="15%"><INPUT TYPE="checkbox" NAME="Chb_applicable_acti'+j+'"></TD>';   
								}
							}							
							m_row =m_row+'</TR>'; 
					    k=k+4;
						  j=j+1;
			}	
			if (top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==1){			
				document.Form1.Hid_scr_name.value="Interest_modi"
			}else if(top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==2){
				document.Form1.Hid_scr_name.value="Interest_deacti"	
			}else if(top.frames[1].frames[0].document.Form1.Text_option.selectedIndex==3){
				document.Form1.Hid_scr_name.value="Interest_reacti"	
			}	
			document.Form1.Hid_acti_modi_cnt.value=j-1;
			m_writedata ='<TABLE border=0 WIDTH="75%">'+m_row+'<TABLE>';
			otheractivity.innerHTML=otheractivity.innerHTML+m_writedata;
		}		
		
		<!----------------- END OF BASE CODE HELP FUNCTION -------------------------->	
		
		function pop_base_code_help(){
			
			 base_code_mod_help(0);
		
		}
		
		function display_sec_opt(val){
		
			if(val=='mod'){
			//Hid_scr_name
			}
		}
		function beforesubmit(){		
			if (document.Form1.Text_base_code.value==""){
				alert("Base code can not be blank ..!");
			}
			else{
			  document.Form1.Text_base_code.disabled=false;
		      document.Form1.Text_desc.disabled=false;			
			  Form1.action= servlet_client_url+":"+client_t3_port+"/"+client_name+"bsavbasecode";				
		      Form1.submit();				
			}	
		}
 </SCRIPT>
	
	<BODY ONLOAD="chk_option();" class='body & txt-body' >		
		<FORM NAME="Form1" ID="Form1" METHOD="POST">
			<INPUT TYPE="Hidden" NAME="Hid_scr_name">	
			<INPUT TYPE="Hidden" NAME="Hid_inst_cnt">
			<INPUT TYPE="Hidden" NAME="Hid_acti_cnt"> 
			<INPUT TYPE="Hidden" NAME="Hid_inst_modi_cnt"> 
			<INPUT TYPE="Hidden" NAME="Hid_acti_modi_cnt"> 
			<INPUT TYPE="Hidden" NAME="Hid_option"> 			
			
			<DIV>
			<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
				<tr>
			<td height='7'></td>
			</tr>
				
			<tr height='30' >
			<td  width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
			<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Margin Trading - System Maintenance</B></td>
			<td  width='50px' style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='right'><B> <DIV ID="div_scr_status" NAME="div_scr_status" ></DIV></B></td>
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
						<INPUT TYPE="Button" NAME="NEW" VALUE="Add"   onClick="display_sec_opt('new');"  class="mainbut" >
					</TD>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="MOD" VALUE="Edit"   onClick="display_sec_opt('mod');" class="mainbut"  >
					</TD>
					<TD WIDTH="6%">	
						<!--<INPUT TYPE="Button" NAME="DEL" VALUE="Delete&nbsp; "   onClick="display_sec_opt('del');"  class="mainbut" disabled >-->
					</TD>
					<TD WIDTH='6%'></TD>		
					<!---------------------------------->
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="save_but" VALUE="Save"   onClick="beforesubmit()" class="mainbut"  >
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
					<TD  WIDTH="50%" class="hh1" align="right">
						<B>Interest Rate Bases </B>
					</TD>					
				</TR>
			</TABLE>
						<!--prabash-->
						
						<!----------->
			
			    <TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
			<HR>
				<TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
			
			<BR>
			
			<TABLE WidTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0">
				<TABLE WidTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0">
					<TR>
						<TD WIDTH="1%"></TD>
						<TD WIDTH="25%" >Base Code</TD>						
						<TD WIDTH="" ><INPUT TYPE="Text" NAME="Text_base_code"	class="txt_input6" ALIGN="LEFT" SIZE="15" onBlur="chk_base_code();" >
						<INPUT TYPE="BUTTON" NAME="Text_help" onClick="pop_base_code_help();"  VALUE="Help" class="but_input"  ></TD>

					</TR>
					<TR></TR>	
					<TR></TR>
				</TABLE>
				<TABLE WidTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0">
					<TR>
						<TD WIDTH="1%"></TD>
						<TD  WIDTH="25%" >Description</TD>
						<TD WIDTH="74%"><INPUT	TYPE="Text" class="txt_input6" NAME="Text_desc"	ALIGN="LEFT" SIZE="20" DISABLED></TD>
					</TR>
					<TR></TR>
					<TR></TR>
				</TABLE>
				<TABLE WidTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0">
					<TR>
						<TD WIDTH="1%"></TD>
						<TD  WIDTH="25%" >Numerator</TD>
						<TD WIDTH="74%"><INPUT	TYPE="Text" class="txt_input6" NAME="Text_numerator" VALUE="Actual"  ALIGN="LEFT" SIZE="15" DISABLED></TD>
					</TR>
					<TR></TR>
					<TR></TR>
				</TABLE>
				
				<TABLE WidTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0">
					<TR>
						<TD WIDTH="1%"></TD>
						<TD  WIDTH="25%" >Denominator (Days)</TD>
						<TD WIDTH="74%"><SELECT NAME="Text_denominator"  onblur="dynomic_text()" class="txt_input6">
								<OPTION VALUE="A" SELECTED>Actual </option> 
							  <OPTION VALUE="UD">User Defined</option></SELECT></TD> 
				</TR>
				<TR></TR>
			</TABLE WidTH="100%">		
			<DIV id=othertextbox></DIV>		
			<HR WidTH="*%">			
			<TABLE WidTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0">
				<TR>
										<TD WIDTH="1%"></TD>

					<TD WIDTH="99%" ><b><U>Applicable Instrument Types</U></b></TD>					
				</TR>	
				<TR></TR>
			</TABLE>
				<TR><DIV id=otherinstrument></DIV></TR>
				<HR WidTH="*%">
				<TABLE WidTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0">					
					<TR></TR>
				</TABLE>  		<TABLE WidTH="100%"BORDER="1" CELLPADDING="0" CELLSPACING="0">
				<TR></TR>
				<TR>	
				</TABLE>
			  <TABLE WidTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0">
										<TD WIDTH="1%"></TD>

				<TD WIDTH="99%" ><b><U>Applicable Activity Types</U></b></TD>								
				<TR></TR>				
			  </TABLE>			
				<DIV id=otheractivity></DIV>												
			</TABLE>
			</FORM>
				<script language="JavaScript1.2" SRC="validate.js">var g_dismsg=false;</SCRIPT>
	           <SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
	</body>	
	
</html>
								
								
