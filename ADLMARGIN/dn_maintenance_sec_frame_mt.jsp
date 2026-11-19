<%@page import="net.sasianet.ADLMARGIN.*" %>	
<HTML>
		<HEAD>
		 	<TITLE>Margin Trading
			</TITLE>
			
		<%	
		ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods();
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
	
		
	
		<SCRIPT language="JavaScript">
			
			var a=1;
			var f=1;
			
		 	
		function dyoname1(){
				a=a+1;
				m_row="";
				m_writedata ='<TABLE WidTH="100%" STYLE="{color: black; font:bold 10pt arial;}">'+
					'<TR BGCOLOR="silver"><TD WidTH="35%">Information From Prospectus '+a+'</TD><TD WidTH="65%"><INPUT TYPE="Text" NAME="TXT_IFP'+a+'" SIZE=46 MAXLENGTH=30 ></TD>'+
						m_row+
						'</TABLE>'; 
				othername1.innerHTML=othername1.innerHTML+m_writedata;
				if (a>1) {
					document.Form1.BUT_IGCODE1.disabled=true;
					}		
			}		              	
				
				
			function dydirector1(){
				f=f+1;
				m_row="";
				m_writedata ='<TABLE WidTH="100%" STYLE="{color: black; font:bold 10pt arial;}">'+
					'<TR BGCOLOR="silver"><TD WidTH="35%">Other Notes '+f+'</TD><TD WidTH="65%"><INPUT TYPE="Text" NAME="TXT_ONOTE'+f+'" SIZE=46 MAXLENGTH=30></TD>'+
						m_row+
						'</TABLE>'; 
					BoardDirector1.innerHTML=BoardDirector1.innerHTML+m_writedata;
				if (f>1) {
					document.Form1.BUT_IGCODE3.disabled=true;
					}			
			}       
			
			
				function display_sec_opt(val){
		
				//-----------------*
				if(val=="add"){	
				document.getElementById('div_lable').innerHTML='Securities - New'; 
			    document.Form1.Hid_scr_name2.value='add';
			
				}
					else if(val=="mod"){ 
				document.getElementById('div_lable').innerHTML='Securities - Edit'; 
				document.Form1.Hid_scr_name2.value='mod';
			  }
					else if(val=="de_ac"){ 
				document.getElementById('div_lable').innerHTML='Securities - Deactivate'; 
				document.Form1.Hid_scr_name2.value='de_ac';
			  }
					else if(val=="re_ac"){ 
			   document.getElementById('div_lable').innerHTML='Securities - Reactivate'; 
				document.Form1.Hid_scr_name2.value='re_ac';
			  }
					else if(val=="view"){ 
		//	  document.getElementById('div_lable').innerHTML='Securities - view'; 
				document.Form1.Hid_scr_name2.value='view';
			  }
			
			//-----------------*
					
					
					
				for(var i=0; i<document.Form1.elements.length; i++) {
		      document.Form1.elements[i].disabled = false;
	        }
					document.Form1.BUT_ITYPE.focus();		
				 // val=(document.Form1.SCR_TYPE.selectedIndex);
					 val=(document.Form1.Hid_scr_name2.value);
					 document.Form1.Hid_scr_name.disabled=false;
				  
					if (val=="add"){
						for(var i=0; i<document.Form1.elements.length; i++) {
		         document.Form1.elements[i].disabled = false;
	           }
							document.Form1.BUTISCODE.disabled=true;
						//	document.Form1.BUT_ESCODE.disabled=true;
						/*						
						document.Form1.TXT_ISCODE.disabled=false;
				 	  document.Form1.BUT_ISCODE.disabled=false;
						document.Form1.SCR_TYPE.disabled=false;
						document.Form1.save_but.disabled=false;
						document.Form1.calcel_but.disabled=false;
						document.Form1.Exit_but.disabled=false;
						document.Form1.TXT_ITYPE.disabled=false;
						document.Form1.BUT_ITYPE.disabled=false;
						document.Form1.TXT_ABAMO3.disabled=false;
						document.Form1.TXT_EXPOS3.disabled=false;
						document.Form1.TXT_ILIMIT.disabled=false;
						document.Form1.TXT_GLIMIT.disabled=false;
						document.Form1.TXT_AWICH3.disabled=false;
						document.Form1.BUT_ISCODE.disabled=true;
						document.Form1.BUT_ESCODE.disabled=true; 
						
						*/
					}	
					else if  (val=="mod"){
						for(var i=0; i<document.Form1.elements.length; i++) {
		             document.Form1.elements[i].disabled = false;
						}
						document.Form1.BUTISCODE.focus();
						document.Form1.TXT_ITYPE.disabled=true;
						document.Form1.BUT_ITYPE.disabled=true;
						document.Form1.TXT_ABAMO3.disabled=true;
						document.Form1.TXT_EXPOS3.disabled=true;
						document.Form1.TXT_ILIMIT.disabled=true;
						document.Form1.TXT_GLIMIT.disabled=true;
						document.Form1.TXT_AWICH3.disabled=true;
					}	
						/* 
						document.Form1.BUT_ISCODE.disabled=false;
						document.Form1.BUT_ESCODE.disabled=false;
						document.Form1.BUT_ISCODE.focus(); */
					
					else if (val=="de_ac"){
					   for(var i=0; i<document.Form1.elements.length; i++) {
		             	document.Form1.elements[i].disabled = true;
						
					//	document.Form1.Add.disabled=false;	
					//	document.Form1.Mod.disabled=false;
					//	document.Form1.Re-Act.disabled=false;
					//	document.Form1.View.disabled=false;		
	           }
						
						document.Form1.Hid_scr_name.disabled=false;	
						document.Form1.Hid_scr_name2.disabled=false;
		    	  		document.Form1.TXT_ISCODE.disabled=false;
				 	  	document.Form1.BUTISCODE.disabled=false;

						
						document.Form1.save_but.disabled=false;
						document.Form1.Exit_but.disabled=false;
						document.Form1.calcel_but.disabled=false;
						
						
					//--prabash on -09-09-2011---------------**	
						document.Form1.Add.disabled=false;	
						document.Form1.Mod.disabled=false;
						document.Form1.ReAct.disabled=false;
						document.Form1.DeAct.disabled=false;
						document.Form1.View.disabled=false;   	
					//--------------------------------------**	
						
						//parent.frames[0].Form1.save_but.disabled=false;
						//document.Form1.SCR_TYPE.disabled=false;
						//parent.frames[0].Form1.SCR_TYPE.disabled=false;
						//parent.frames[0].Form1.calcel_but.disabled=false;
						//parent.frames[0].Form1.Exit_but.disabled=false;
					
					}
					else if (val=="re_ac"){
					   for(var i=0; i<document.Form1.elements.length; i++) {
		             document.Form1.elements[i].disabled = true;
	           }
						document.Form1.Hid_scr_name.disabled=false;	
		    	  		document.Form1.TXT_ISCODE.disabled=false;
				 	  	document.Form1.BUTISCODE.disabled=false;
						
						//--prabash on -09-09-2011---------------**	
						document.Form1.Add.disabled=false;	
						document.Form1.Mod.disabled=false;
						document.Form1.ReAct.disabled=false;
						document.Form1.DeAct.disabled=false;
						document.Form1.View.disabled=false;   	
					//--------------------------------------**	
						
						
						
						//document.Form1.SCR_TYPE.disabled=false;
					//	parent.frames[0].Form1.SCR_TYPE.disabled=false;
				/*		document.Form1.save_but.disabled=false;
						document.Form1.calcel_but.disabled=false;
						document.Form1.Exit_but.disabled=false; */
						
						document.Form1.save_but.disabled=false;
						document.Form1.Exit_but.disabled=false;
						document.Form1.calcel_but.disabled=false;
						
						//parent.frames[0].Form1.save_but.disabled=false;
						//parent.frames[0].Form1.calcel_but.disabled=false;
						//parent.frames[0].Form1.Exit_but.disabled=false;
						
					
					}

					/*else if (val=="view"){
						for(var i=0; i<document.Form1.elements.length; i++) {
		             document.Form1.elements[i].disabled = true;
	           }
		    	  //document.Form1.TXT_ISCODE.disabled=false;
				 	  //document.Form1.BUT_ISCODE.disabled=false;
						document.Form1.Hid_scr_name.disable=false;	
						//document.Form1.SCR_TYPE.disabled=false;
					//	parent.frames[0].Form1.SCR_TYPE.disabled=false;
						//document.Form1.Exit_but.disabled=false;
						document.Form1.Exit_but.disabled=false;
						//parent.frames[0].Form1.Exit_but.disabled=false;
						
					//--prabash on -09-09-2011---------------**	
						document.Form1.Add.disabled=false;	
						document.Form1.Mod.disabled=false;
						document.Form1.ReAct.disabled=false;
						document.Form1.View.disabled=false;   	
					//--------------------------------------**	
						
						if (confirm('Do you want to view the list of all the securities')){
						  m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities_MT?chksql=VIEW";
							//parent.frames[0].document.applets[0].getdata(m_url);
							//m_size=parent.frames[0].document.applets[0].outvec_value.size();
							
							load_interface(m_url,'XML',false);
							m_size = data_vec.length;
							
						//	top.frames[0].document.applets[0].getdata(m_url);
						//	m_size=top.frames[0].document.applets[0].outvec_value.size();
							vec_pos=0;
							m_row="";
							lineno=1;
								while (vec_pos<m_size) {
						//		m_security_code=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
						//			m_issuer_group_code=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
						//			m_issuer_code=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2);
						//			m_issuer_name=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+3);
						//			m_inst_type=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+4);
						//			m_coupon_int=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+5);
						//			m_frequency=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+6);
						//			m_credit_rating=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+7);
						//			m_active_status=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+8); 
									//=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
								
							    	m_security_code=data_vec[0];
									m_issuer_group_code=data_vec[1];
									m_issuer_code=data_vec[2];
									m_issuer_name=data_vec[3];
									m_inst_type=data_vec[4];
									m_coupon_int=data_vec[5];
									m_frequency=data_vec[6];
									m_credit_rating=data_vec[7];
									m_active_status=data_vec[8];
							
							
							m_row=m_row+'<TR STYLE="{color:black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white"  ONMOUSEOVER=mouseover_setings(LINE'+lineno+');'+
							'ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_security_code+'</B></TD>'+
							'<TD ID=C2R'+	lineno+'><B>'+m_issuer_group_code+'</B></TD><TD ID=C3R'+	lineno+'><B>'+m_issuer_code+'</B></TD><TD ID=C4R'+	lineno+'><B>'+m_issuer_name+'</B></TD>'+
							'<TD ID=C5R'+	lineno+'><B>'+m_inst_type+'</B></TD><TD ID=C6R'+	lineno+'><B>'+m_coupon_int+'</B></TD><TD ID=C7R'+	lineno+'><B>'+m_frequency+'</B></TD>'+
							'<TD ID=C8R'+	lineno+'><B>'+m_credit_rating+'</B></TD><TD ID=C9R'+	lineno+'><B>'+m_active_status+'</B></TD></TR>';
							vec_pos=vec_pos+9;
							lineno=lineno+1;
							}
							m_writedata ='<TABLE BGCOLOR="gray" WIDTH="100%" STYLE="{color: darkblue; font: 10pt sans-serif;}">'+
							'<TR BGCOLOR="darkgray"><TD WIDTH="30%"><B>Security Code</B></TD>' +
							'<TD WIDTH="10%"><B>Issuer Group Code</B></TD>'+
							'<TD WIDTH="5%"><B>Issuer Code</B></TD>'+
							'<TD WIDTH="15%"><B>Issuer Name</B></TD>'+
							'<TD WIDTH="5%"><B>Instrument Type</B></TD>'+
							'<TD WIDTH="10%"><B>Coupon Interest</B></TD>'+
							'<TD WIDTH="5%"><B>Frequency</B></TD>'+
							'<TD WIDTH="15%"><B>Credit Rating</B></TD>'+
							'<TD WIDTH="5%"><B>Status</B></TD></TR>'+
							m_row+
							'</TABLE>'; 
							myDialogObj.htmlstr = m_writedata;
							myDialogObj.returnval = "";
							popupwin = window.showModalDialog(html_client_url+"/help_box2.jsp",myDialogObj,"dialogWidth:50em; dialogHeight:15em; center:yes; resizable:yes; status:no");
							}
			}*/
					else if (val=="view"){
						
					view_help7(0);
						
					
					}	
				}		
			
<!----------- DISABLE IMPORTANT FIELDS OF SECURITIES- Added by Yohan on 23-06-2006 for VC 06/009 ---------------------------------> 			
			
      function disable_sec_data(){
			// alert("inside");
			 m_sec_code=document.Form1.TXT_ISCODE.value;
			 m_url_222=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities_MT?chksql=disable_sec_data&sec_code="+m_sec_code+"";
			 //window.open(m_url_222);
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
	//		 top.frames[0].document.applets[0].outvec_value.removeAllElements();
	//		 top.frames[0].document.applets[0].getdata(m_url_222);
	//		 m_size=top.frames[0].document.applets[0].outvec_value.size();
			 //window.open(m_url_222);
			
        if(m_size > 0){
          m_recount=data_vec[0];
			
					if(m_recount > 0){
					//alert(m_recount);
					//flag_disable=true;
					document.Form1.TXT_ISCODE.disabled=true;
					document.Form1.TXT_CSYM.disabled=true;
					document.Form1.BUT_CSYM.disabled=true;
					document.Form1.Text_mt_percent.disabled=true;
					//document.Form1.Text_licence_mt_percent.disabled=true;//add and commetn by waruna 2010-10-04
					document.Form1.TXT_CPPA.disabled=true;
					document.Form1.Text_pay_date1.disabled=true;
					document.Form1.Text_pay_month1.disabled=true;
					document.Form1.Text_pay_year1.disabled=true;
					document.Form1.Text_iss_date1.disabled=true;
					document.Form1.Text_iss_month1.disabled=true;
					document.Form1.Text_iss_year1.disabled=true;
					document.Form1.Text_mat_date1.disabled=true;
					document.Form1.Text_mat_month1.disabled=true;
					document.Form1.Text_mat_year1.disabled=true;
					//document.Form1.maturity_type.disabled=true;
					//document.Form1.coupon_dates.disabled=true;
					//document.Form1.coupon_type.disabled=true;
					document.Form1.TXT_CRSE.disabled=true;
					document.Form1.TXT_PAR.disabled=true;
					//document.Form1.TXT_RATE1.disabled=true;
					//document.Form1.TXT_RATE2.disabled=true;
					//document.Form1.TXT_AMOISS.disabled=true; comment by waruna 2011-03-21
					document.Form1.TXT_WAYISS.disabled=true;
					document.Form1.TXT_PAR.disabled=true;
					//document.Form1.TXT_LST_STATUS.disabled=true;
					//document.Form1.TXT_CR_RANKING.disabled=true;
					//document.Form1.SEL_DIV_CUM.disabled=true;
					//document.Form1.TXT_CAP_GURARANT.disabled=true;
					document.Form1.TXT_COUINT.disabled=true;
					
				  }
					
				}				
				
			}					
//----------------------------------------------------------------------*			
	function view_help7(m_strat){
						
						
						
					for(var i=0; i<document.Form1.elements.length; i++) {
		             document.Form1.elements[i].disabled = true;
	           		}
						document.Form1.Hid_scr_name.disable=false;	
						document.Form1.Exit_but.disabled=false;
						document.Form1.Add.disabled=false;	
						document.Form1.Mod.disabled=false;
						document.Form1.ReAct.disabled=false;
						document.Form1.DeAct.disabled=false;
						document.Form1.View.disabled=false;   	
					
				if (confirm('Do you want to view the list of all the securities')){		
     				var aForm;    //  aForm =oForm.elements;
     				aForm =  document.getElementById('Form1');
	
	
 					var myObject=new Array(); //return values set to this object
 					myObject[0]=null;
					myObject[1]=null;
 					myObject[2]=null;
					myObject[3]=null;
					myObject[4]=null;
					myObject[5]=null;
					myObject[6]=null;
					myObject[7]=null;
					myObject[8]=null;
					
					
  
 					var myObject_value=new Array(); //passing values set to this object
 					myObject_value[0]=null;
					myObject_value[1]=null;
					myObject_value[2]=null;
					myObject_value[3]=null;
					myObject_value[4]=null;
					myObject_value[5]=null;
					myObject_value[6]=null;
					myObject_value[7]=null;
					myObject_value[8]=null;
 	
 
 
 					var myObject_type=new Array(); //passing values data type
 					myObject_type[0]=null;
 					myObject_type[1]=null;
					myObject_type[2]=null;
					myObject_type[3]=null;
					myObject_type[4]=null;
					myObject_type[5]=null;
					myObject_type[6]=null;
					myObject_type[7]=null;
					myObject_type[8]=null;
 		
 	
 
 					var qid='24';
    				title_name='Help';
 					var url = 'popup.jsp';
					var close_fun='close_portP_help'
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
					url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=20'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
				 	dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
					height:800,// 500,
					width: 970,//900,
		 			title: 'SasiNet Frame Work',
		 			scrollable: true,
		 			onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
				}
	}
		
		
		
	//-----------------------------------------------------------------------**		
			
			
			
<!----------FIRST TEXTBOX OPERATION--------------------------------------------------------------------->		
				function first_text(){
				
					m_code=document.Form1.TXT_ISCODE.value;
					m_code2=document.Form1.TXT_ITYPE.value;
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities_MT?chksql=first_text&date="+m_code+"&date2="+m_code2+"";
					
					load_interface(m_url,'XML',false);
					var m_size = data_vec.length;
					
					
					//parent.frames[0].document.applets[0].getdata(m_url);
					//top.frames[0].document.applets[0].getdata(m_url);
					//m_size=parent.frames[0].document.applets[0].outvec_value.size();
					//m_size=top.frames[0].document.applets[0].outvec_value.size();
					//val=(document.Form1.SCR_TYPE.selectedIndex);
					val=(document.Form1.Hid_scr_name2.value);
						if (val=="add"){
								if (m_size>0){																	
									alert('Sorry, the same code is already existing');
									document.Form1.TXT_ISCODE.focus();
								}
								else {
								//alert('Internal code is OK');
								}
						}
						<!--------Modification------------------------------------------>
					else if (val=="mod"){
						 	
				
								m_code=document.Form1.TXT_ISCODE.value;
								m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities_MT?chksql=first_mod_text&date="+m_code+"";								
								//window.open(m_url);
					
						        load_interface(m_url,'XML',false);
						        var m_size = data_vec.length;
						        //alert(m_size);
								//top.frames[0].document.applets[0].getdata(m_url);								
								//m_size=top.frames[0].document.applets[0].outvec_value.size();
								//alert(top.frames[0].document.applets[0].outvec_value)
								
								if (m_size>0){										
										/*document.Form1.TXT_ESCODE.value=parent.frames[0].document.applets[0].outvec_value.elementAt(0);
											document.Form1.TXT_ICODE.value=parent.frames[0].document.applets[0].outvec_value.elementAt(1);
											document.Form1.TXT_NAME.value=parent.frames[0].document.applets[0].outvec_value.elementAt(2);	
											document.Form1.TXT_IGCODE.value=parent.frames[0].document.applets[0].outvec_value.elementAt(3);
											document.Form1.TXT_GCODE.value=parent.frames[0].document.applets[0].outvec_value.elementAt(4);
											document.Form1.TXT_CSYM.value=parent.frames[0].document.applets[0].outvec_value.elementAt(5);	
											document.Form1.Text_iss_date1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(6);
											document.Form1.Text_iss_month1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(7);
											document.Form1.Text_iss_year1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(8);
											document.Form1.Text_mat_date1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(9);
											document.Form1.Text_mat_month1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(10);
											document.Form1.Text_mat_year1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(11);
											
											
											document.Form1.TXT_COUINT.value=format_noobject0(parent.frames[0].document.applets[0].outvec_value.elementAt(12));
											document.Form1.TXT_CPPA.value=parent.frames[0].document.applets[0].outvec_value.elementAt(13);
											document.Form1.Text_pay_date1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(14);
											document.Form1.Text_pay_month1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(15);
											document.Form1.Text_pay_year1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(16);
											document.Form1.TXT_CRSE.value=parent.frames[0].document.applets[0].outvec_value.elementAt(17);
											document.Form1.TXT_AMOISS.value=format_noobject(parent.frames[0].document.applets[0].outvec_value.elementAt(18));
											document.Form1.TXT_WAYISS.value=format_noobject0(parent.frames[0].document.applets[0].outvec_value.elementAt(19));
											document.Form1.TXT_IFP1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(20);
											document.Form1.TXT_IFP2.value=parent.frames[0].document.applets[0].outvec_value.elementAt(21);
											document.Form1.TXT_ONOTE1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(22);
											document.Form1.TXT_ONOTE2.value=parent.frames[0].document.applets[0].outvec_value.elementAt(23);
											document.Form1.TXT_ITYPE.value=parent.frames[0].document.applets[0].outvec_value.elementAt(24);   */
											
											
											document.Form1.TXT_ESCODE.value=data_vec[0];
											document.Form1.TXT_ICODE.value=data_vec[1];
											document.Form1.TXT_NAME.value=data_vec[2];
											document.Form1.TXT_IGCODE.value=data_vec[3];
											document.Form1.TXT_GCODE.value=data_vec[4];
											document.Form1.TXT_CSYM.value=data_vec[5];
											document.Form1.Text_iss_date1.value=data_vec[6];
											document.Form1.Text_iss_month1.value=data_vec[7];
											document.Form1.Text_iss_year1.value=data_vec[8];
											document.Form1.Text_mat_date1.value=data_vec[9];
											document.Form1.Text_mat_month1.value=data_vec[10];
											document.Form1.Text_mat_year1.value=data_vec[11];
											document.Form1.TXT_COUINT.value=data_vec[12];
											document.Form1.TXT_CPPA.value=data_vec[13];
											document.Form1.Text_pay_date1.value=data_vec[14];
											document.Form1.Text_pay_month1.value=data_vec[15];
											document.Form1.Text_pay_year1.value=data_vec[16];
											document.Form1.TXT_CRSE.value=data_vec[17];
											document.Form1.TXT_AMOISS.value=data_vec[18];
											document.Form1.TXT_WAYISS.value=data_vec[19];
											document.Form1.TXT_IFP1.value=data_vec[20];
											document.Form1.TXT_IFP2.value=data_vec[21];
											document.Form1.TXT_ONOTE1.value=data_vec[22];
											document.Form1.TXT_ONOTE2.value=data_vec[23];
											document.Form1.TXT_ITYPE.value=data_vec[24];						
								      		par =data_vec[25];
								      		document.Form1.Text_mt_percent.value=data_vec[26];
                                     		document.Form1.Text_licence_mt_percent.value=data_vec[27];		//add by waruna 2010-10-04	
											document.Form1.Text_consent_perc.value=data_vec[28]; // added by udara on 13-01-2012 
								            document.Form1.Text_li_status.value=data_vec[29]; // added by udara on 13-01-2012   
									
											document.Form1.TXT_ITYPE.disabled=false;
											document.Form1.BUT_ITYPE.disabled=false;
											document.Form1.TXT_ABAMO3.disabled=false;
											document.Form1.TXT_EXPOS3.disabled=false;
											document.Form1.TXT_ILIMIT.disabled=false;
											document.Form1.TXT_GLIMIT.disabled=false;
											document.Form1.TXT_AWICH3.disabled=false;
											
											
											  m_url1=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities_MT?chksql=get_inst_cat&inst="+document.Form1.TXT_ITYPE.value+"";
												
									load_interface(m_url,'XML',false);
									m_size = data_vec.length;
												//top.frames[0].document.applets[0].getdata(m_url1);
												//m_size=top.frames[0].document.applets[0].outvec_value.size();				
												inst_cat=data_vec[0];		
												
												document.Form1.Hid_inst_cat.value=inst_cat;
										
										    if (inst_cat== "DEBT" ){	
												 document.Form1.TXT_PAR.value ="Not Applicable for Debt";	
												 document.Form1.TXT_PAR.disabled =true;				 
												}
												else
												{
												 document.Form1.Text_mat_date1.disabled =true;
												 document.Form1.Text_mat_month1.disabled =true;
												 document.Form1.Text_mat_year1.disabled =true;
												 document.Form1.TXT_COUINT.disabled   =true;
												 document.Form1.TXT_CPPA.disabled   =true;
												 document.Form1.TXT_CRSE.disabled =true;					
				                                 document.Form1.TXT_WAYISS.disabled =true;
												 document.Form1.TXT_PAR.value =par;	
												
												}
												
											disable_sec_data(); // Added by Yohan on 23-06-2006 for VC 06/009
							
								
								}
								 else {
											alert('No such record to modify');
								}
							}
					else if (val=="de_ac"){
								m_code=document.Form1.TXT_ISCODE.value;
								m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities_MT?chksql=first_deact_text&date="+m_code+"";
							
								load_interface(m_url,'XML',false);
								m_size = data_vec.length;
						
							//	top.frames[0].document.applets[0].getdata(m_url);
							//	m_size=top.frames[0].document.applets[0].outvec_value.size();
						
								//alert('uuuu');
								if (m_size>0){
										/*document.Form1.TXT_ESCODE.value=parent.frames[0].document.applets[0].outvec_value.elementAt(0);
											document.Form1.TXT_ICODE.value=parent.frames[0].document.applets[0].outvec_value.elementAt(1);
											document.Form1.TXT_NAME.value=parent.frames[0].document.applets[0].outvec_value.elementAt(2);	
											document.Form1.TXT_IGCODE.value=parent.frames[0].document.applets[0].outvec_value.elementAt(3);
											document.Form1.TXT_GCODE.value=parent.frames[0].document.applets[0].outvec_value.elementAt(4);
											document.Form1.TXT_CSYM.value=parent.frames[0].document.applets[0].outvec_value.elementAt(5);	
											document.Form1.Text_iss_date1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(6);
											document.Form1.Text_iss_month1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(7);
											document.Form1.Text_iss_year1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(8);
											document.Form1.Text_mat_date1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(9);
											document.Form1.Text_mat_month1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(10);
											document.Form1.Text_mat_year1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(11);
											
											
											document.Form1.TXT_COUINT.value=parent.frames[0].document.applets[0].outvec_value.elementAt(12);
											document.Form1.TXT_CPPA.value=parent.frames[0].document.applets[0].outvec_value.elementAt(13);
											document.Form1.Text_pay_date1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(14);
											document.Form1.Text_pay_month1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(15);
											document.Form1.Text_pay_year1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(16);
											document.Form1.TXT_CRSE.value=parent.frames[0].document.applets[0].outvec_value.elementAt(17);
											document.Form1.TXT_AMOISS.value=parent.frames[0].document.applets[0].outvec_value.elementAt(18);
											document.Form1.TXT_WAYISS.value=parent.frames[0].document.applets[0].outvec_value.elementAt(19);
											document.Form1.TXT_IFP1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(20);
											document.Form1.TXT_IFP2.value=parent.frames[0].document.applets[0].outvec_value.elementAt(21);
											document.Form1.TXT_ONOTE1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(22);
											document.Form1.TXT_ONOTE2.value=parent.frames[0].document.applets[0].outvec_value.elementAt(23);
											document.Form1.TXT_ITYPE.value=parent.frames[0].document.applets[0].outvec_value.elementAt(24);  */
											
											
											document.Form1.TXT_ESCODE.value=data_vec[0];
											document.Form1.TXT_ICODE.value=data_vec[1];
											document.Form1.TXT_NAME.value=data_vec[2];	
											document.Form1.TXT_IGCODE.value=data_vec[3];
											document.Form1.TXT_GCODE.value=data_vec[4];
											document.Form1.TXT_CSYM.value=data_vec[5];	
											document.Form1.Text_iss_date1.value=data_vec[6];
											document.Form1.Text_iss_month1.value=data_vec[7];
											document.Form1.Text_iss_year1.value=data_vec[8];
											document.Form1.Text_mat_date1.value=data_vec[9];
											document.Form1.Text_mat_month1.value=data_vec[10];
											document.Form1.Text_mat_year1.value=data_vec[11];
											
											
											document.Form1.TXT_COUINT.value=data_vec[12];
											document.Form1.TXT_CPPA.value=data_vec[13];
											document.Form1.Text_pay_date1.value=data_vec[14];
											document.Form1.Text_pay_month1.value=data_vec[15];
											document.Form1.Text_pay_year1.value=data_vec[16];
											document.Form1.TXT_CRSE.value=data_vec[17];
											document.Form1.TXT_AMOISS.value=data_vec[18];
											document.Form1.TXT_WAYISS.value=data_vec[19];
											document.Form1.TXT_IFP1.value=data_vec[20];
											document.Form1.TXT_IFP2.value=data_vec[21];
											document.Form1.TXT_ONOTE1.value=data_vec[22];
											document.Form1.TXT_ONOTE2.value=data_vec[23];
											document.Form1.TXT_ITYPE.value=data_vec[24];
											par =data_vec[25];
											document.Form1.Text_mt_percent.value=data_vec[26];							
								      		document.Form1.Text_licence_mt_percent.value=data_vec[27];
											
											 m_url1=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities_MT?chksql=get_inst_cat&inst="+document.Form1.TXT_ITYPE.value+"";
												
										load_interface(m_url,'XML',false);
										m_size = data_vec.length;
									
									//	parent.frames[0].document.applets[0].getdata(m_url1);
										//	m_size=parent.frames[0].document.applets[0].outvec_value.size();				
												
										inst_cat=data_vec[0];	
												document.Form1.Hid_inst_cat.value=inst_cat;
											
											if (inst_cat== "DEBT" ){	
												 document.Form1.TXT_PAR.value ="Not Applicable for Debt";	
												 document.Form1.TXT_PAR.disabled =true;				 
												}
												else
												{
												 document.Form1.Text_mat_date1.disabled =true;
												 document.Form1.Text_mat_month1.disabled =true;
												 document.Form1.Text_mat_year1.disabled =true;
												 document.Form1.TXT_COUINT.disabled   =true;
												 document.Form1.TXT_CPPA.disabled   =true;
												 document.Form1.TXT_PAR.value =par;	
													document.Form1.TXT_CRSE.disabled =true;					
				                 document.Form1.TXT_WAYISS.disabled =true;
												}
							
								
								}
									else {
									alert('No such deal to deactivate');
									}
							}		
					else if (val=="re_ac"){
								m_code=document.Form1.TXT_ISCODE.value;
								m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities_MT?chksql=first_react_text&date="+m_code+"";
								
								load_interface(m_url,'XML',false);
								m_size = data_vec.length;
						
								//top.frames[0].document.applets[0].getdata(m_url);
								//m_size=top.frames[0].document.applets[0].outvec_value.size();
								//alert('uuuu');
								if (m_size>0){
											// document.Form1.TXT_ONOTE2.disabled=true;
											// document.Form1.TXT_IFP2.disabled=true;
									/*	document.Form1.TXT_ESCODE.value=parent.frames[0].document.applets[0].outvec_value.elementAt(0);
											document.Form1.TXT_ICODE.value=parent.frames[0].document.applets[0].outvec_value.elementAt(1);
											document.Form1.TXT_NAME.value=parent.frames[0].document.applets[0].outvec_value.elementAt(2);	
											document.Form1.TXT_IGCODE.value=parent.frames[0].document.applets[0].outvec_value.elementAt(3);
											document.Form1.TXT_GCODE.value=parent.frames[0].document.applets[0].outvec_value.elementAt(4);
											document.Form1.TXT_CSYM.value=parent.frames[0].document.applets[0].outvec_value.elementAt(5);	
											document.Form1.Text_iss_date1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(6);
											document.Form1.Text_iss_month1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(7);
											document.Form1.Text_iss_year1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(8);
											document.Form1.Text_mat_date1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(9);
											document.Form1.Text_mat_month1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(10);
											document.Form1.Text_mat_year1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(11);
											
											
											document.Form1.TXT_COUINT.value=parent.frames[0].document.applets[0].outvec_value.elementAt(12);
											document.Form1.TXT_CPPA.value=parent.frames[0].document.applets[0].outvec_value.elementAt(13);
											document.Form1.Text_pay_date1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(14);
											document.Form1.Text_pay_month1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(15);
											document.Form1.Text_pay_year1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(16);
											document.Form1.TXT_CRSE.value=parent.frames[0].document.applets[0].outvec_value.elementAt(17);
											document.Form1.TXT_AMOISS.value=parent.frames[0].document.applets[0].outvec_value.elementAt(18);
											document.Form1.TXT_WAYISS.value=parent.frames[0].document.applets[0].outvec_value.elementAt(19);
											document.Form1.TXT_IFP1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(20);
											document.Form1.TXT_IFP2.value=parent.frames[0].document.applets[0].outvec_value.elementAt(21);
											document.Form1.TXT_ONOTE1.value=parent.frames[0].document.applets[0].outvec_value.elementAt(22);
											document.Form1.TXT_ONOTE2.value=parent.frames[0].document.applets[0].outvec_value.elementAt(23);
											document.Form1.TXT_ITYPE.value=parent.frames[0].document.applets[0].outvec_value.elementAt(24);  */
											
											
											document.Form1.TXT_ESCODE.value=data_vec[0];
											document.Form1.TXT_ICODE.value=data_vec[1];
											document.Form1.TXT_NAME.value=data_vec[2];
											document.Form1.TXT_IGCODE.value=data_vec[3];
											document.Form1.TXT_GCODE.value=data_vec[4];
											document.Form1.TXT_CSYM.value=data_vec[5];
											document.Form1.Text_iss_date1.value=data_vec[6];
											document.Form1.Text_iss_month1.value=data_vec[7];
											document.Form1.Text_iss_year1.value=data_vec[8];
											document.Form1.Text_mat_date1.value=data_vec[9];
											document.Form1.Text_mat_month1.value=data_vec[10];
											document.Form1.Text_mat_year1.value=data_vec[11];
											
											
											document.Form1.TXT_COUINT.value=data_vec[12];
											document.Form1.TXT_CPPA.value=data_vec[13];
											document.Form1.Text_pay_date1.value=data_vec[14];
											document.Form1.Text_pay_month1.value=data_vec[15];
											document.Form1.Text_pay_year1.value=data_vec[16];
											document.Form1.TXT_CRSE.value=data_vec[17];
											document.Form1.TXT_AMOISS.value=data_vec[18];
											document.Form1.TXT_WAYISS.value=data_vec[19];
											document.Form1.TXT_IFP1.value=data_vec[20];
											document.Form1.TXT_IFP2.value=data_vec[21];
											document.Form1.TXT_ONOTE1.value=data_vec[22];
											document.Form1.TXT_ONOTE2.value=data_vec[23];
											document.Form1.TXT_ITYPE.value=data_vec[24];
												par =data_vec[25];
											document.Form1.Text_mt_percent.value=data_vec[26];					
								            document.Form1.Text_licence_mt_percent.value=data_vec[27];//add by waruna 2010-10-04
											 
											 m_url1=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities_MT?chksql=get_inst_cat&inst="+document.Form1.TXT_ITYPE.value+"";
										
											load_interface(m_url,'XML',false);
											m_size = data_vec.length;	
										//	parent.frames[0].document.applets[0].getdata(m_url1);
										//	m_size=parent.frames[0].document.applets[0].outvec_value.size();				
												
											inst_cat=data_vec[0];		
												document.Form1.Hid_inst_cat.value=inst_cat;											
											
											if (inst_cat== "DEBT" ){	
												 document.Form1.TXT_PAR.value ="Not Applicable for Debt";	
												 document.Form1.TXT_PAR.disabled =true;				 
												}
												else
												{
												 document.Form1.Text_mat_date1.disabled =true;
												 document.Form1.Text_mat_month1.disabled =true;
												 document.Form1.Text_mat_year1.disabled =true;
												 document.Form1.TXT_COUINT.disabled   =true;
												 document.Form1.TXT_CPPA.disabled   =true;
												 document.Form1.TXT_PAR.value =par;	
													document.Form1.TXT_CRSE.disabled =true;					
				 document.Form1.TXT_WAYISS.disabled =true;
												}
							
								
								}
								else {
											alert('No such record exist to deactivate');
								}
							}	
						else  {
							 	alert('Only for selection 1 & 2');
						}		
				}
				
<!----------FIRST HELPBOX OPERATION--------------------------------------------------------------------->		
				function myDialogObj() {
					var htmlstr; 
					var returnval;
				}
				
		function view_help1(m_strat){
			//val=(document.Form1.SCR_TYPE.selectedIndex);
					val=(document.Form1.Hid_scr_name2.value);
		 if (val=="mod"){
				
				
     				var aForm;    //  aForm =oForm.elements;
     				aForm =  document.getElementById('Form1');
	
	
 					var myObject=new Array(); //return values set to this object
 					myObject[0]=aForm.TXT_ISCODE;
					myObject[1]=null;
 					myObject[2]=aForm.TXT_ESCODE;
  
 					var myObject_value=new Array(); //passing values set to this object
 					myObject_value[0]=aForm.TXT_ISCODE.value;
					myObject_value[1]=aForm.TXT_ISCODE.value;
 	
 
 
 					var myObject_type=new Array(); //passing values data type
 					myObject_type[0]="StringL";
 					myObject_type[1]="StringL";
 		
 	
 
 					var qid='15';
    				title_name='Help';
 					var url = 'popup.jsp';
					var close_fun='close_portP_help';			
 					var json_text = JSON.stringify(myObject_value, null,0);
 					var json_obj_type_text=JSON.stringify(myObject_type, null,0);
 					var fn_name=arguments.callee.name;
					//JSON.parse(str) 
					//alert(json_text);
       				$.showModalDialog({
					url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
				 	dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
					height:400,// 500,
					width: 600,//900,
		 			title: 'SasiNet Frame Work',
		 			scrollable: true,
		 			onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);first_text();  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
			}		
			else if (val=="de_ac"){
				
				
     				var aForm;    //  aForm =oForm.elements;
     				aForm =  document.getElementById('Form1');
	
	
 					var myObject=new Array(); //return values set to this object
 					myObject[0]=aForm.TXT_ISCODE;
					myObject[1]=null;
 					myObject[2]=aForm.TXT_ESCODE;
  
 					var myObject_value=new Array(); //passing values set to this object
 					myObject_value[0]=aForm.TXT_ISCODE.value;
					myObject_value[1]=null;
 	
 
 
 					var myObject_type=new Array(); //passing values data type
 					myObject_type[0]="StringL";
 					myObject_type[1]=null;
 		
 	
 
 					var qid='22';
    				title_name='Help';
 					var url = 'popup.jsp';
					var close_fun='close_portP_help';			
 					var json_text = JSON.stringify(myObject_value, null,0);
 					var json_obj_type_text=JSON.stringify(myObject_type, null,0);
 					var fn_name=arguments.callee.name;
					//JSON.parse(str) 
					//alert(json_text);
       				$.showModalDialog({
					url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
				 	dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
					height:400,// 500,
					width: 600,//900,
		 			title: 'SasiNet Frame Work',
		 			scrollable: true,
		 			onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);first_text();  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
			}
			
			else if (val=="re_ac"){
				
				
     				var aForm;    //  aForm =oForm.elements;
     				aForm =  document.getElementById('Form1');
	
	
 					var myObject=new Array(); //return values set to this object
 					myObject[0]=aForm.TXT_ISCODE;
					myObject[1]=null;
 					myObject[2]=aForm.TXT_ESCODE;
  
 					var myObject_value=new Array(); //passing values set to this object
 					myObject_value[0]=aForm.TXT_ISCODE.value;
					myObject_value[1]=null;
 	
 
 
 					var myObject_type=new Array(); //passing values data type
 					myObject_type[0]="StringL";
 					myObject_type[1]=null;
 		
 	
 
 					var qid='23';
    				title_name='Help';
 					var url = 'popup.jsp';
					var close_fun='close_portP_help';			
 					var json_text = JSON.stringify(myObject_value, null,0);
 					var json_obj_type_text=JSON.stringify(myObject_type, null,0);
 					var fn_name=arguments.callee.name;
					//JSON.parse(str) 
					//alert(json_text);
       				$.showModalDialog({
					url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
				 	dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
					height:400,// 500,
					width: 600,//900,
		 			title: 'SasiNet Frame Work',
		 			scrollable: true,
		 			onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);first_text();  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
			}
			
			
	}		
<!----------SECOND TEXTBOX OPERATION--------------------------------------------------------------------->
			function second_text(){
					m_code=document.Form1.TXT_ESCODE.value;
					m_code2=document.Form1.TXT_ITYPE.value;
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities_MT?chksql=second_text&date="+m_code+"&date2="+m_code2+"";
					
					load_interface(m_url,'XML',false);
					m_size = data_vec.length;
				
				//parent.frames[0].document.applets[0].getdata(m_url);
					//top.frames[0].document.applets[0].getdata(m_url);
					//m_size=parent.frames[0].document.applets[0].outvec_value.size();
					//m_size=top.frames[0].document.applets[0].outvec_value.size();
					//val=(document.Form1.SCR_TYPE.selectedIndex);
					val=(document.Form1.Hid_scr_name2.value);
					if (val=="add"){
						if (m_size>0){																	
							alert('Sorry, the same code is already existing');
							document.Form1.TXT_ESCODE.focus();
						}
					}
					
				 if (val=="mod"){
						if (m_size>0){																	
							alert('The modification can not be accepted');
						}
						else {
						}			
					}
			}
<!----------SECOND HELPBOX OPERATION--------------------------------------------------------------------->							
				
			function view_help2(){
							
			
			
			
		//------Prabash ------------**
			
				var aForm;    //  aForm =oForm.elements;
     			aForm =  document.getElementById('Form1');
	
	
 				var myObject=new Array(); //return values set to this object
 				myObject[0]=aForm.TXT_ESCODE;
				myObject[1]=null;
 				myObject[2]=null;
  
 				var myObject_value=new Array(); //passing values set to this object
 				myObject_value[0]=TXT_ITYPE.value;
 	
 
 
 				var myObject_type=new Array(); //passing values data type
 				myObject_type[0]=null;
 		
 	
 
 				var qid='16';
    			title_name='Help';
 				var url = 'popup.jsp';
				var close_fun='close_portP_help';			
 				var json_text = JSON.stringify(myObject_value, null,0);
 				var json_obj_type_text=JSON.stringify(myObject_type, null,0);
 				var fn_name=arguments.callee.name;
				//JSON.parse(str) 
				//alert(json_text);
       			$.showModalDialog({
		 		url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
		 		dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 		height:400,// 500,
		 		width: 600,//900,
		 		title: 'SasiNet Frame Work',
		 		scrollable: true,
		 		onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
					});
				}
		//------------------**
<!----------THIRD HELPBOX&THIRD&FOURTH&FIFTH&SIXTH TEXTBOX OPERATION--------------------------------------------------------------------->							
				function third_text(){
					m_code=document.Form1.TXT_ICODE.value;
					m_code2=document.Form1.TXT_ITYPE.value;
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities_MT?chksql=third_text&date="+m_code+"&date2="+m_code2+"";
				
					load_interface(m_url,'XML',false);
					m_size = data_vec.length;
					
					//parent.frames[0].document.applets[0].getdata(m_url);
					//top.frames[0].document.applets[0].getdata(m_url);
					//m_size=parent.frames[0].document.applets[0].outvec_value.size();
					//m_size=top.frames[0].document.applets[0].outvec_value.size();
					//val=(document.Form1.SCR_TYPE.selectedIndex);
					
					val=(document.Form1.Hid_scr_name2.value);
						if (val=="add"){
							//alert('sorry already 0');	
								if (m_size>0){																	
								//alert('Yes this is a valid code');
								m_code=document.Form1.TXT_ICODE.value;
								
								m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities_MT?chksql=fourth_text&date="+m_code+"";
								load_interface(m_url,'XML',false);
								m_size = data_vec.length;
									
									//parent.frames[0].document.applets[0].getdata(m_url);
								//top.frames[0].document.applets[0].getdata(m_url);
								//m_size2=parent.frames[0].document.applets[0].outvec_value.size();
								//m_size2=top.frames[0].document.applets[0].outvec_value.size();
								//val=(document.Form1.SCR_TYPE.selectedIndex);						
								val=(document.Form1.Hid_scr_name2.value);						
										if (m_size2>0){
											//document.Form1.TXT_NAME.value=parent.frames[0].document.applets[0].outvec_value.elementAt(0);
											//document.Form1.TXT_IGCODE.value=parent.frames[0].document.applets[0].outvec_value.elementAt(1);
											document.Form1.TXT_NAME.value=data_vec[0];
											document.Form1.TXT_IGCODE.value=data_vec[1];
											//document.Form1.TXT_ISSCR.value=parent.frames[0].document.applets[0].outvec_value.elementAt(2);
											document.Form1.BUT_GCODE.focus();
										}
										else{
											alert('Adequate record does not exist');
										}
								}	
								else  {
									alert('No this is not a valid issuer code');
									//document.Form1.TXT_ICODE.focus();
								}
					}
		
				
					else if (val=="mod"){
							if (m_size>0){																	
								//alert('Yes this is a valid code');
								m_code=document.Form1.TXT_ICODE.value;
								
								m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities_MT?chksql=fourth_text&date="+m_code+"";
								alert(data_vec[0]);
								load_interface(m_url,'XML',false);
								m_size = data_vec.length;
								
								//parent.frames[0].document.applets[0].getdata(m_url);
								//m_size=parent.frames[0].document.applets[0].outvec_value.size();
								//val=(document.Form1.SCR_TYPE.selectedIndex);	
								
								val=(document.Form1.Hid_scr_name2.value);						
									if (m_size>0){
											document.Form1.TXT_NAME.value=data_vec[0];
											document.Form1.TXT_IGCODE.value=data_vec[1];
											document.Form1.TXT_ISSCR.value=data_vec[2];
											document.Form1.BUT_GCODE.focus();
									}
									else{
											alert('Record does not exist');
									}
							}
							else {
							alert('No this is not a valid code');
							}
					}
			}
			
				/*function view_help3(){
					m_code=document.Form1.TXT_ITYPE.value;
 					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities_MT?chksql=view_help3&date="+m_code+"";
					top.frames[0].document.applets[0].getdata(m_url);
					m_size=top.frames[0].document.applets[0].outvec_value.size();
					vec_pos=0;
					m_row="";
					lineno=1;
						while (vec_pos<m_size) {
							m_acc_no=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
							m_acc_no_refno=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
							m_row=m_row+'<TR STYLE="{color:black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white"  ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_acc_no+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_acc_no_refno+'</B></TD></TR>';
							vec_pos=vec_pos+2;
							lineno=lineno+1;
							}
					m_writedata ='<TABLE BGCOLOR="gray" WIDTH="100%" STYLE="{color: darkblue; font: 9pt sans-serif;}">'+
						'<TR BGCOLOR="darkgray"><TD WIDTH="40%"><B>Issuer Code</B></TD>' +
						'<TD WIDTH="60%"><B>Issuer Name</B></TD>'+
						m_row+
						'</TABLE>'; 
					myDialogObj.htmlstr = m_writedata;
					myDialogObj.returnval = "";
					popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
					document.Form1.TXT_ICODE.value=myDialogObj.returnval;
					document.Form1.TXT_ICODE.focus();
			}
			*/
	//-------------Prabash------------------------------------------**	
			function view_help3(m_strat){
				
     var aForm;    //  aForm =oForm.elements;
     aForm =  document.getElementById('Form1');
	
	
 	var myObject=new Array(); //return values set to this object
 	myObject[0]=aForm.TXT_ICODE;
	myObject[1]=aForm.TXT_NAME;
 	
  
 	var myObject_value=new Array(); //passing values set to this object
 	myObject_value[0]=aForm.TXT_ITYPE.value;
 	myObject_value[1]=null;//aForm.oLastName2.value;
 	
 
 	var myObject_type=new Array(); //passing values data type
 	myObject_type[0]="StringL";
 	myObject_type[1]=null;
 
 	var qid='18';
    title_name='Help';
 	var url = 'popup.jsp';
	var close_fun='close_portP_help';			
 	var json_text = JSON.stringify(myObject_value, null,0);
 	var json_obj_type_text=JSON.stringify(myObject_type, null,0);
 	var fn_name=arguments.callee.name;
	//JSON.parse(str) 
	//alert(json_text);
       	$.showModalDialog({
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400,// 500,
		 width: 600,//900,
		 title: 'SasiNet Frame Work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
			}
			
			
<!---------- TEXTBOX OPERATION--------------------------------------------------------------------->	
			
			/*
			function fourth_text(){
				m_code=document.Form1.TXT_ICODE.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities_MT?chksql=fourth_text&date="+m_code+"";
				parent.frames[0].document.applets[0].getdata(m_url);
				m_size=parent.frames[0].document.applets[0].outvec_value.size();
				val=(parent.frames[1].Form1.SCR_TYPE.selectedIndex);
					if (val==0){
						if (m_size>0){
							document.Form1.TXT_NAME.value=parent.frames[0].document.applets[0].outvec_value.elementAt(0);
							document.Form1.TXT_IGCODE.value=parent.frames[0].document.applets[0].outvec_value.elementAt(1);
							document.Form1.TXT_ISSCR.value=parent.frames[0].document.applets[0].outvec_value.elementAt(2);
							document.Form1.BUT_GCODE.focus();
						}
						else{
						alert('Something wrong!!!!!!!');
						}
					}
			 } 
				*/
				
<!----------FOURTH HELPBOX OPERATION--------------------------------------------------------------------->							
		 
									
			/*function view_help4(){
					m_code=document.Form1.TXT_ITYPE.value;
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities_MT?chksql=view_help4&date="+m_code+"";
					//parent.frames[0].document.applets[0].getdata(m_url);
					top.frames[0].document.applets[0].getdata(m_url);
					//m_size=parent.frames[0].document.applets[0].outvec_value.size();
					m_size=top.frames[0].document.applets[0].outvec_value.size();
					vec_pos=0;
					m_row="";
					lineno=1;
						while (vec_pos<m_size) {
							//m_acc_no=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
							m_acc_no=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
							//m_acc_no_refno=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
							m_acc_no_refno=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
							m_row=m_row+'<TR STYLE="{color:black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white"  ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_acc_no+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_acc_no_refno+'</B></TD></TR>';
							vec_pos=vec_pos+2;
							lineno=lineno+1;
							}
					m_writedata ='<TABLE BGCOLOR="gray" WIDTH="100%" STYLE="{color: darkblue; font: 9pt sans-serif;}">'+
						'<TR BGCOLOR="darkgray"><TD WIDTH="15%"><B>Gurantor Code</B></TD>' +
							'<TD WIDTH="85%"><B>Gurantor Name</B></TD></TR>'+
						m_row+
						'</TABLE>'; 
					myDialogObj.htmlstr = m_writedata;
					myDialogObj.returnval = "";
					popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
					document.Form1.TXT_GCODE.value=myDialogObj.returnval
					document.Form1.TXT_GCODE.focus();
			}*/
			
			function view_help4(m_strat){
				
     var aForm;    //  aForm =oForm.elements;
     aForm =  document.getElementById('Form1');
	
	
 	var myObject=new Array(); //return values set to this object
 	myObject[0]=aForm.TXT_GCODE;
	myObject[1]=null;
 	
  
 	var myObject_value=new Array(); //passing values set to this object
 	myObject_value[0]=aForm.TXT_ITYPE.value;
 	myObject_value[1]=null;//aForm.oLastName2.value;
 	
 
 	var myObject_type=new Array(); //passing values data type
 	myObject_type[0]="StringL";
 	myObject_type[1]=null;
 
 	var qid='18';
    title_name='Help';
 	var url = 'popup.jsp';
	var close_fun='close_portP_help';			
 	var json_text = JSON.stringify(myObject_value, null,0);
 	var json_obj_type_text=JSON.stringify(myObject_type, null,0);
 	var fn_name=arguments.callee.name;
	//JSON.parse(str) 
	//alert(json_text);
       	$.showModalDialog({
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400,// 500,
		 width: 600,//900,
		 title: 'SasiNet Frame Work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
		}
			
			
	<!----------SEVENTH TEXTBOX OPERATION------------------------------------------------------------------			
				
			function seventh_text(){
				m_code=document.Form1.TXT_ITYPE.value;
				m_code2=document.Form1.TXT_GCODE.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities_MT?chksql=seventh_text&date="+m_code+"&date2="+m_code2+"";
				
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				val=(document.Form1.Hid_scr_name2.value);
					if (val=="add"){
						if (m_size>0){
						}
						else {
						alert('Error in the gurantor code');
						}
					}						
			}
	<!----------EIGHTH TEXTBOX OPERATION--------------------------------------------------------------------->					
		/*
		
			function eighth_text(){			
				m_code=document.Form1.TXT_GCODE.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities_MT?chksql=eighth_text&date="+m_code+"";
				//parent.frames[0].document.applets[0].getdata(m_url);
				top.frames[0].document.applets[0].getdata(m_url);
				//m_size=parent.frames[0].document.applets[0].outvec_value.size();
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				//val=(document.Form1.SCR_TYPE.sele	ctedIndex);
				//val=(parent.frames[0].Form1.SCR_TYPE.selectedIndex);
				val=(top.frames[0].Form1.SCR_TYPE.selectedIndex);
					if (val==0){
						if (m_size>0){
							//document.Form1.TXT_GCR.value=parent.frames[0].document.applets[0].outvec_value.elementAt(0);
							document.Form1.TXT_GCR.value=top.frames[0].document.applets[0].outvec_value.elementAt(0);
							
						}
						else {
						alert('Error in the gurantor code');
						}
					}	
					if (val==1){
						if (m_size>0){
							//document.Form1.TXT_GCR.value=parent.frames[0].document.applets[0].outvec_value.elementAt(0);
							document.Form1.TXT_GCR.value=top.frames[0].document.applets[0].outvec_value.elementAt(0);
						}
						else {
						alert('Error in the gurantor code');
						}
					}
					
		 }*/
			
			
				
<!----------FIFTH HELPBOX $ NINTH TEXT BOX OPERATION--------------------------------------------------------------------->				
		
			function view_help5(m_strat){
     	var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	
	
 		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.TXT_ITYPE;
		myObject[1]=null;
 		myObject[2]=null;
  
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.TXT_ITYPE.value;
		myObject_value[1]=aForm.TXT_ITYPE.value;
 	
 
 
 		var myObject_type=new Array(); //passing values data type
 		myObject_type[0]="StringL";
 		myObject_type[1]="StringL";
 		
 	
 
 		var qid='14';
    	title_name='Help';
 		var url = 'popup.jsp';
		var close_fun='close_portP_help';			
 		var json_text = JSON.stringify(myObject_value, null,0);
 		var json_obj_type_text=JSON.stringify(myObject_type, null,0);
 		var fn_name=arguments.callee.name;
		//JSON.parse(str) 
		//alert(json_text);
       	$.showModalDialog({
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400,// 500,
		 width: 600,//900,
		 title: 'SasiNet Frame Work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
			}
			//----------------
		function ninth_text(){
	
				var m_code=document.Form1.TXT_ITYPE.value;
				//alert(parent.frames[0].location)
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities_MT?chksql=nintht_text&date="+m_code+"";
			
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
			
			//	parent.frames[0].document.applets[0].getdata(m_url);
			//	m_size=parent.frames[0].document.applets[0].outvec_value.size();
				
				//val=(document.Form1.SCR_TYPE.selectedIndex);
				val=(document.Form1.Hid_scr_name2.value);
					if (val=="add"){
						if (m_size>0){
						}
						else {
							alert('erronous instrument code');
							document.Form1.BUT_ITYPE.focus();
						}
					}	
					check_equity();
					
		}
		
		function check_equity()
		{   
		    m_url1=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities_MT?chksql=get_inst_cat&inst="+document.Form1.TXT_ITYPE.value+"";
			
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
			
			//parent.frames[0].document.applets[0].getdata(m_url1);
				//m_size=parent.frames[0].document.applets[0].outvec_value.size();
			
				inst_cat=data_vec[0];		
				
			document.Form1.Hid_inst_cat.value=inst_cat;
		   
			if (inst_cat== "DEBT" ){	
				 document.Form1.TXT_PAR.value ="Not Applicable for Debt";	
				 document.Form1.TXT_PAR.disabled =true;				 
				}				
				else
				{
				 document.Form1.TXT_COUINT.value      ="0";
				 document.Form1.TXT_CPPA.value      ="Not Applicable for Equity";
				 document.Form1.TXT_COUINT.disabled   =true;
				 document.Form1.TXT_CPPA.disabled   =true;
				 document.Form1.Text_mat_date1.value  ="01";
				 document.Form1.Text_mat_month1.value ="01";
				 document.Form1.Text_mat_year1.value  ="2099";
				 document.Form1.Text_mat_date1.disabled =true;
				 document.Form1.Text_mat_month1.disabled =true;
				 document.Form1.Text_mat_year1.disabled =true;
				 document.Form1.TXT_CRSE.value      ="0";
				 document.Form1.TXT_WAYISS.value      ="0";
					 document.Form1.TXT_CRSE.disabled =true;					
				 document.Form1.TXT_WAYISS.disabled =true;
				}
				m_url1=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities?chksql=get_date_system";
			
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
			
			// parent.frames[0].document.applets[0].getdata(m_url1);
				// m_size=parent.frames[0].document.applets[0].outvec_value.size();	
			
				 document.Form1.Text_iss_date1.value  =data_vec[0];
				 document.Form1.Text_iss_month1.value =data_vec[1];
				 document.Form1.Text_iss_year1.value  =data_vec[2];
				
				
				
		}
				
	<!----------SIXTH HELPBOX $ TWENTYFIRST TEXT BOX OPERATION--------------------------------------------------------------------->				
	/*	function view_help6(){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities_MT?chksql=view_help6";
				//parent.frames[0].document.applets[0].getdata(m_url);
				top.frames[0].document.applets[0].getdata(m_url);
				//m_size=parent.frames[0].document.applets[0].outvec_value.size();
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				vec_pos=0;
				m_row="";
				lineno=1;
					while (vec_pos<m_size) {
						//m_acc_no=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
						//m_acc_no_refno=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
						m_acc_no=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
						m_acc_no_refno=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
						m_row=m_row+'<TR STYLE="{color:black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white"  ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_acc_no+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_acc_no_refno+'</B></TD></TR>';
						vec_pos=vec_pos+2;
						lineno=lineno+1;
						}
				m_writedata ='<TABLE BGCOLOR="gray" WIDTH="100%" STYLE="{color: darkblue; font: 9pt sans-serif;}">'+
					'<TR BGCOLOR="darkgray"><TD WIDTH="20%"><B>Currency Code</B></TD>' +
						'<TD WIDTH="80%"><B>Currency Description</B></TD></TR>'+
						m_row+
						'</TABLE>'; 
				myDialogObj.htmlstr = m_writedata;
				myDialogObj.returnval = "";
				popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
				document.Form1.TXT_CSYM.value=myDialogObj.returnval;
				// document.Form1.TXT_GCODE.focus();
			}
		 */
			
			//Prabsh on 09-09-2011--------------------------**
			function view_help6(m_strat){
     		var aForm;    //  aForm =oForm.elements;
     		aForm =  document.getElementById('Form1');
	
	
 			var myObject=new Array(); //return values set to this object
 			myObject[0]=aForm.TXT_CSYM;
			myObject[1]=null;
 			myObject[2]=null;
  
 			var myObject_value=new Array(); //passing values set to this object
 			myObject_value[0]=null;
 	
 
 
 			var myObject_type=new Array(); //passing values data type
 			myObject_type[0]=null;
 		
 	
 
 			var qid='19';
    		title_name='Help';
 			var url = 'popup.jsp';
			var close_fun='close_portP_help';			
 			var json_text = JSON.stringify(myObject_value, null,0);
 			var json_obj_type_text=JSON.stringify(myObject_type, null,0);
 			var fn_name=arguments.callee.name;
			//JSON.parse(str) 
			//alert(json_text);
       		$.showModalDialog({
		 	url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
		 	dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
			height:400,// 500,
		 	width: 600,//900,
		 	title: 'SasiNet Frame Work',
		 	scrollable: true,
		 	onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
			}
	<!----------ISSUEDATE BOX OPERATION--------------------------------------------------------------------->				
			
	function Issue_date(obj_date,obj_month,obj_year){
				if (checkMonthLength(obj_date,obj_month,obj_year)) {
				}	
			}		

	<!----------MATURITYDATE BOX OPERATION--------------------------------------------------------------------->		
		function 	Maturity_date(obj_date,obj_month,obj_year){
			
				if (checkMonthLength(obj_date,obj_month,obj_year)){
					iss_day = new Date(document.Form1.Text_iss_year1.value,document.Form1.Text_iss_month1.value,document.Form1.Text_iss_date1.value);
					matt_day = new Date(document.Form1.Text_mat_year1.value,document.Form1.Text_mat_month1.value,document.Form1.Text_mat_date1.value);
					if (iss_day>=matt_day){
						alert('Maturity date does not comply with issue date.Please check it');
					}	
				}
		}		
	<!---------PAYMENTDATE BOX OPERATION--------------------------------------------------------------------->		
		function 	Payment_date(obj_date,obj_month,obj_year){
				if (checkMonthLength(obj_date,obj_month,obj_year)){
					iss_day = new Date(document.Form1.Text_iss_year1.value,document.Form1.Text_iss_month1.value,document.Form1.Text_iss_date1.value);
					matt_day = new Date(document.Form1.Text_mat_year1.value,document.Form1.Text_mat_month1.value,document.Form1.Text_mat_date1.value);
					pay_day=  new Date(document.Form1.Text_pay_year1.value,document.Form1.Text_pay_month1.value,document.Form1.Text_pay_date1.value);
					if (iss_day>=pay_day){
						alert('Interest payment date does not comply with issue date.Please check it');
					}	
					if (pay_day>matt_day){
						alert('Interest payment date does not comply with maturity date.Please check it');
					}	
				
				}	
			}
			
<!-------CONVERSION TO  DECIMALS--------------------------------------------------------------------->			
					
		function	format_interest(obj_int) {
		      obj_int.value=format_noobject0(obj_int.value);
			}		


		function	format_In_Issue(obj_int) {
					obj_int.value=format_noobject(obj_int.value);
			}
			
		function format_Weighted_Average(obj_int) {
					obj_int.value=format_noobject0(obj_int.value);
			}	
			
			
<!------- FORM SUBMITION--------------------------------------------------------------------------------->			
	
	function beforesubmit(){
	inst_cat=document.Form1.Hid_inst_cat.value;//add by warna 2010-10-04
	document.Form1.TXT_ITYPE.disabled =false;
	document.Form1.TXT_CSYM.disabled =false;
	document.Form1.Text_mat_date1.disabled =false;
	document.Form1.Text_mat_month1.disabled =false;
	document.Form1.Text_mat_year1.disabled =false;
	document.Form1.TXT_ISCODE.disabled =false;
	document.Form1.Text_iss_date1.disabled =false;
	document.Form1.Text_iss_month1.disabled =false;
	document.Form1.Text_iss_year1.disabled =false;
	document.Form1.Text_pay_date1.disabled =false;
	document.Form1.Text_pay_month1.disabled =false;
	document.Form1.Text_pay_year1.disabled =false;
	document.Form1.TXT_AMOISS.disabled =false;
	document.Form1.TXT_PAR.disabled =false;
	document.Form1.Text_mt_percent.disabled =false;
		if (inst_cat== "DEBT" ){					
				 document.Form1.TXT_PAR.disabled =false;	
					document.Form1.TXT_PAR.value=0;
				 if (document.Form1.TXT_CPPA.value <= 0 ){
					alert("The Frequency has to me greater than 0");				
					}	
					
				}				
				else
				{ 
				 document.Form1.TXT_CPPA.value=0;
				 document.Form1.TXT_COUINT.disabled   =false;
				 document.Form1.TXT_CPPA.disabled   =false;				
				 document.Form1.Text_mat_date1.disabled =false;
				 document.Form1.Text_mat_month1.disabled =false;
				 document.Form1.Text_mat_year1.disabled =false;
				 document.Form1.TXT_CRSE.disabled =false;					
				 document.Form1.TXT_WAYISS.disabled =false;
				  
				}
	
	
	
			document.Form1.Hid_scr_name.disabled=false;			
			val=(document.Form1.Hid_scr_name2.value);
			if (document.Form1.TXT_ISCODE.value=="") {
			   alert('Please enter the security Code');
				 document.Form1.TXT_ISCODE.focus();
			}
		 	else {
					if (val=="add") {
						document.Form1.Hid_scr_name.value="security_add";
					}
					else if (val=="mod") {
						document.Form1.Hid_scr_name.value="security_modi";
					}
					else if (val=="de_ac") {
						document.Form1.Hid_scr_name.value="security1";
					}
					else if (val=="re_ac") {
						document.Form1.Hid_scr_name.value="security2";
					}
					document.Form1.TXT_COUINT.value=unformat_noobject(document.Form1.TXT_COUINT.value);
					document.Form1.TXT_AMOISS.value=unformat_noobject(document.Form1.TXT_AMOISS.value);
					document.Form1.TXT_WAYISS.value=unformat_noobject(document.Form1.TXT_WAYISS.value);
					document.Form1.Hid_scr_name.disabled=false;
					
					if(document.Form1.Text_consent_perc.value==""){
						document.Form1.Text_consent_perc.value = 0;
					}
					
				   if(parseFloat(document.Form1.Text_consent_perc.value) > 100){
						alert('Concentration percentage is wrong');
						document.Form1.Text_consent_perc.focus();
					}
					else{
						document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsavsecurities_mt";
						document.Form1.submit();	
					}
			}
	}			
			
//------- CANCEL AND EXIT OPERATION--------------------------------		
		function cancelling(){
			reset();
			display_sec_opt();
		}
			//-----------
		function reset(){
				
			document.Form1.TXT_ITYPE.value="";
			document.Form1.TXT_ISCODE.value="";
			document.Form1.TXT_ISCODE.value="";
			document.Form1.TXT_ESCODE.value="";
			document.Form1.TXT_ICODE.value="";
			document.Form1.TXT_NAME.value="";
			document.Form1.TXT_IGCODE.value="";
			document.Form1.TXT_ISSCR.value="";
			document.Form1.TXT_GCODE.value="";
			document.Form1.TXT_GCR.value="";
			document.Form1.TXT_ABAMO1.value="";
			document.Form1.TXT_ABAMO1.value="";
			document.Form1.TXT_EXPOS1.value="";
			document.Form1.TXT_AWICH1.value="";
			document.Form1.TXT_ABAMO2.value="";
			document.Form1.TXT_EXPOS2.value="";
			document.Form1.TXT_AWICH2.value="";
			document.Form1.TXT_CSYM.value="";
			document.Form1.Text_iss_date1.value="";
			document.Form1.Text_iss_month1.value="";
			document.Form1.Text_iss_year1.value="";
			document.Form1.Text_mat_date1.value="";
			document.Form1.Text_mat_month1.value="";
			document.Form1.Text_mat_year1.value="";
			document.Form1.TXT_COUINT.value="";
			document.Form1.TXT_CPPA.value="";
			document.Form1.TXT_CRSE.value="";
			document.Form1.TXT_AMOISS.value="";
			document.Form1.TXT_WAYISS.value="";
			document.Form1.TXT_PAR.value="";
			document.Form1.Text_mt_percent.value="";
			document.Form1.Text_licence_mt_percent.value="";
			document.Form1.Text_consent_perc.value="";	
			document.Form1.Text_li_status.value="";		
				
			
			//pf_name.innerHTML="";
		}
			//-----------
			
		function screenclose(){
			top.frames[1].location.href='low.jsp';
		}
							
		function checkkey(e){
							
		
			if(e.keyCode==32){
		     alert("You are not allowed to enter space!!.");
		   	e.keyCode=0;
		  
			}
		}	
			
		//----------------------Calander---------------**
		$(document).ready
			(
				
				function() 
				{
					//initDialog();
					initCal('TXT_START_DATE');
                    initCal('TXT_END_DATE');
					//initDialogPOPup();
				}
			);
			
			
			function initCal(m_id) {
                $('#' + m_id).datepicker({
                    dateFormat: 'dd-mm-yy',
                    duration: 'fast',
                    yearRange: '1920:2050',
                    showOn: 'button',
                    buttonImage: '<%=m_jsp_client_url%>/SNET/images/calendar.gif',
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
               if (instance_id == "TXT_START_DATE") {
                   document.Form1.Text_iss_date1.value = splitResult[0];
                   document.Form1.Text_iss_month1.value = splitResult[1];
                   document.Form1.Text_iss_year1.value = splitResult[2];
                   document.Form1.Text_iss_year1.focus();
               }
               else if (instance_id == "TXT_END_DATE") {
                   document.Form1.Text_mat_date1.value = splitResult[0];
                   document.Form1.Text_mat_month1.value = splitResult[1];
                   document.Form1.Text_mat_year1.value = splitResult[2];
                   document.Form1.Text_mat_year1.focus();
               }
              
           }
		//-------------------------------------**	
			
			
			// added by udara on 13-01-2012
			
			function load_date(){
				
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'inventory_by_date_location?chksql=chk_sysdate'; 	
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;

 				if(m_size>0){ 
					document.Form1.Text_iss_date1.value  = data_vec[0];
			  		document.Form1.Text_iss_month1.value = data_vec[1]; 						 
			  		document.Form1.Text_iss_year1.value  = data_vec[2];	
				}	
	
			}
			
			// end by udara on 13-01-2012
			
			
			</SCRIPT>
			</HEAD>
				<BODY  ONLOAD="load_date(); display_sec_opt('add');" class='body & txt-body'  > <!--  -->
					<FORM NAME="Form1" ID="Form1" METHOD="POST"  >
						<INPUT TYPE="Hidden" NAME="Hid_scr_name" VALUE="" >
						<INPUT TYPE="Hidden" NAME="Hid_scr_name2" VALUE="add" >  <!--added by prabash  on 07-09-2011-->
						<INPUT TYPE="Hidden" NAME="Hid_inst_cat" VALUE="" >
						<INPUT TYPE="Hidden" NAME="SAVETYPE">
			
			<!-----Added by Prabash on 06-09-2011-----------------------------  -->
			<DIV>
			<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
				<tr>
			<td height='7'></td>
			</tr>
				
			<tr height='30' >
			<td  width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
			<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Administration - Security</B></td>
			<td width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>
						
			</tr>
			
			<tr>
						
			</TABLE>	
					
			</DIV>
				

			<table class='table' border='0' cellpadding='0' cellspacing='0' width='100%'> 
			<tr>
			<td height='1'></td>
			</tr>
			<tr>				
				
			<!----------------------------------------------------------------- --->
						<TABLE WIDTH="100%" BGCOLOR="darkblue" >
					<TR >
					<!--added by prabash on 01-09-2011-->
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="Add" VALUE="Add"   onClick="display_sec_opt('add'); cancelling()"  class="mainbut"  >
					</TD>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="Mod" VALUE="Edit"   onClick="display_sec_opt('mod'); cancelling()" class="mainbut"  >
					</TD>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="DeAct" VALUE="Deactivate"   onClick="display_sec_opt('de_ac'); cancelling()"  class="mainbut" style="{ width: 70px; }" >
					</TD>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="ReAct" VALUE="Reactivate"   onClick="display_sec_opt('re_ac'); cancelling()"  class="mainbut" style="{ width: 70px; }" >
					</TD>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="View" VALUE="View"   onClick="display_sec_opt('view')"  class="mainbut"  >
					</TD>
					<TD WIDTH='6%'></TD>		
					<!---------------------------------->
						
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="save_but" VALUE="Save"   onClick="beforesubmit()" class="mainbut"  >
					</TD>
					
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"   onClick="cancelling()" class="mainbut"> 
				</TD>
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit"   onClick="screenclose()" class="mainbut"> 
					</TD>
					<TD WIDTH="6%">
									
						<INPUT TYPE="Button" NAME="report_but" VALUE="Enquiry"    onClick="obtain_report_before()" class="mainbut">
						
					</TD>
								<TD WIDTH="6%">
					<INPUT TYPE="Hidden" NAME="SAVETYPE">
					</TD>
			<!--		<TD  WIDTH="50%" class="hh1" align="right">	-->
									

				
			<!--<B>	Securities</B>-->
			<TD> <B><div id='div_lable' align='right' > </div> </B> 	</TD>
		</TD>
		</TR>
			</TABLE>
						
		<!----------------------------------------------------------------- -->				
			
			     <TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
			<HR>
				<TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
					
		<!------------------------------------------------------------------  -->	
	</TR>
	</TABLE> 
				
	<div id="date_div">	
					
		
			</TABLE>				
						<TABLE WIDTH="80%"BORDER="0" CELLPADDING="1" CELLSPACING="0">						
		        <TD WidTH="1%">
			      <TD WidTH="99%">
						<TABLE WIDTH="100%"BORDER="0" CELLPADDING="0" CELLSPACING="0">
						 <TD WidTH="35%">Instrument Type</TD>
						 <TD WidTH="40%"><INPUT TYPE="Text" NAME="TXT_ITYPE" ALIGN="LEFT" SIZE=27 MAXLENGTH=5 onBlur="ninth_text()" class="txt_input6" >
						 <INPUT TYPE="button" VALUE="..." NAME="BUT_ITYPE" class="but_input" onClick="view_help5(0)"></TD>
						 <TD WidTH="25%"></TD>
							
						</TABLE>
						
						<DIV DIV ID = 'Instrument_Level_TEL'>    
						<HR WidTH="*%">	
								
						<TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0">
							<TR>
									
								<TD WidTH="35%">Instrument Level Total Exposure Limit :</TD>
								<TD WidTH="20%">Absolute Amount</TD>
								<TD WidTH="45%"><INPUT TYPE="Text" NAME="TXT_ABAMO3"	VALUE="User Input"	ALIGN="LEFT" SIZE=37 MAXLENGTH=30 class="txt_input6"></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD>% Exposure</TD>
								<TD><INPUT TYPE="Text" NAME="TXT_EXPOS3"	VALUE="User Input"	ALIGN="LEFT" SIZE=37 MAXLENGTH=30 class="txt_input6" ></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD>% Issuer Limit</TD>
								<TD><INPUT TYPE="Text" NAME="TXT_ILIMIT"	VALUE="User Input"	ALIGN="LEFT" SIZE=37 MAXLENGTH=30 class="txt_input6" ></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD>% Guarantor Limit</TD>
								<TD><INPUT TYPE="Text" NAME="TXT_GLIMIT"	VALUE="User Input"	ALIGN="LEFT" SIZE=37 MAXLENGTH=30  class="txt_input6" ></TD>
							</TR>
							
							<TR>
								<TD></TD>
								<TD>Apply whichever is</TD>
								<TD><INPUT TYPE="Text" NAME="TXT_AWICH3"	VALUE="User Input"	ALIGN="LEFT" SIZE=37 MAXLENGTH=30 class="txt_input6" ></TD>    
							</TR>
								
						</TABLE>
						</DIV>	
							
							<HR WidTH="*%">	
							
							
				<TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0">
					<TR>
						<TD WidTH="35%">Internal Security Code</TD>
						<TD WidTH="40%"><INPUT TYPE="Text" NAME="TXT_ISCODE" ALIGN="LEFT" SIZE=27 MAXLENGTH=19  onkeypress="checkkey(event)" onBlur="first_text()" class="txt_input6" >
							<INPUT TYPE="button" VALUE="..." NAME="BUTISCODE"  class="but_input" onClick="view_help1(0)" ></TD>
						<TD WidTH="25%">
						</TR>
						<TR>
							<TD>External Security Code</TD>
							<TD><INPUT TYPE="Text" NAME="TXT_ESCODE" ALIGN="LEFT" SIZE=27 MAXLENGTH=19  onkeypress="checkkey(event)" onBlur="second_text()" class="txt_input6" >
								<!-- <INPUT TYPE="button" VALUE="..." NAME="BUT_ESCODE" class="but_input" onClick="view_help2()"></TD> -->
							<TD></TD>
						</TR>
						<TR>
							<TD>Issuer Code</TD>
							<TD><INPUT TYPE="Text" NAME="TXT_ICODE" ALIGN="LEFT" SIZE=27 MAXLENGTH=10 onBlur="third_text()" class="txt_input6" >
								<INPUT TYPE="button" VALUE="..." NAME="BUT_ICODE" class="but_input" onClick="view_help3(0)"></TD>
							<TD></TD>
						</TR>

						<TR>
							<TD WidTH= >Name</TD>
							<TD><INPUT TYPE="Text" NAME="TXT_NAME"	ALIGN="LEFT" SIZE=59 MAXLENGTH=10 class="txt_input6" >
						<TD></TD>
						</TR>
					</TABLE>
					
					
					<TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0">
						<TR>
							<TD WidTH="35%">Issuer Group Code</TD>
							<TD WidTH="40%"><INPUT TYPE="Text" NAME="TXT_IGCODE"	ALIGN="LEFT" SIZE=27 MAXLENGTH=30 class="txt_input6" >
								
							</TR>
							<TR>
								<TD WidTH="35%">Issuer Credit Rating / Description</TD>
								<TD WidTH="65%"><INPUT TYPE="Text" NAME="TXT_ISSCR"	ALIGN="LEFT" SIZE=59 MAXLENGTH=20 class="txt_input6" ></TD>
							</TR>
						</TABLE>
						
						
						<TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0">
							
							<TD WidTH="35%">Guarantor Code</TD>
							<TD WidTH="60%"><INPUT TYPE="Text" NAME="TXT_GCODE" ALIGN="LEFT" SIZE=27 MAXLENGTH=10 onBlur="seventh_text()" class="txt_input6" >
								<INPUT TYPE="button" VALUE="..." NAME="BUT_GCODE" class="but_input" onClick="view_help4(0)"></TD>
							<TD></TD>
							 </TR>
								<TR>				
								<TD WidTH="35%">Guarantor Credit Rating / Description</TD>
								<TD WidTH="60%"><INPUT TYPE="Text" NAME="TXT_GCR"	class="txt_input6" ALIGN="LEFT" SIZE=59 MAXLENGTH=40  ></TD>
											</TR>
						</TABLE>
						
						<HR WidTH="*%">
						<TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0">
							<TR>
								<TD WidTH="35%">Issuer Level Total Exposure Limit :</TD>
								<TD WidTH="20%">Absolute Amount</TD>
								<TD WidTH="45%"><INPUT TYPE="Text" NAME="TXT_ABAMO1" VALUE="User Input"	class="txt_input6" ALIGN="LEFT" SIZE=37 MAXLENGTH=30 ></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD>% Exposure</TD>
								<TD><INPUT TYPE="Text" NAME="TXT_EXPOS1"	VALUE="User Input"	VALUE="User Input" class="txt_input6"	ALIGN="LEFT" SIZE=37 MAXLENGTH=30 ></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD>Apply whichever is</TD>
								<TD><INPUT TYPE="Text" NAME="TXT_AWICH1"	VALUE="User Input"	class="txt_input6" ALIGN="LEFT" SIZE=37 MAXLENGTH=30 ></TD>    
							</TR>
						</TABLE>
						
						
						<HR WidTH="*%">
						<TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0">
							<TR>
								<TD WidTH="35%">Guarantor Level Total Exposure Limit  :</TD>
								<TD WidTH="20%">Absolute Amount</TD>
								<TD WidTH="45%"><INPUT TYPE="Text" NAME="TXT_ABAMO2"	VALUE="User Input"	class="txt_input6" ALIGN="LEFT" SIZE=37 MAXLENGTH=30 ></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD>% Exposure</TD>
								<TD><INPUT TYPE="Text" NAME="TXT_EXPOS2"	VALUE="User Input" class="txt_input6"	ALIGN="LEFT" SIZE=37 MAXLENGTH=30 ></TD>
							</TR>
							<TR>
								<TD></TD>
								<TD>Apply whichever is</TD>
								<TD><INPUT TYPE="Text" NAME="TXT_AWICH2"	VALUE="User Input" class="txt_input6"	ALIGN="LEFT" SIZE=37 MAXLENGTH=30 ></TD>    
							</TR>
						</TABLE>
						
									
									
						<HR WidTH="*%">	
									
									
									
						<B><U>Security Features :</U></B>
						<TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0">
							<TD WidTH="32%">Currency Symbol</TD>
							<TD WidTH="35%"><INPUT TYPE="Text" VALUE="SLR"  NAME="TXT_CSYM" 	class="txt_input6" ALIGN="LEFT" SIZE=27 MAXLENGTH=4 >
							<INPUT TYPE="button" VALUE="..." NAME="BUT_CSYM" class="but_input" onClick="view_help6(0)"></TD>
							<TD WidTH="25%"></TD>
						</TABLE>
						
						
						
						<TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0">
							<TR>
								<TD WidTH="35%">Issue Date</TD>
								<TD WidTH="65%">
									<INPUT TYPE="Text" NAME="Text_iss_date1"  	SIZE=3 MAXLENGTH=2 class="txt_input5" >
									<INPUT TYPE="Text" NAME="Text_iss_month1" SIZE=3 MAXLENGTH=2 class="txt_input5" >
									<INPUT TYPE="Text" NAME="Text_iss_year1" SIZE=5 MAXLENGTH=4   class="txt_input5" onBlur="Issue_date(document.Form1.Text_iss_date1,document.Form1.Text_iss_month1,document.Form1.Text_iss_year1)">
							<input type = "hidden" name = "TXT_START_DATE" id = "TXT_START_DATE" /> </TD>
								</TR>
							<TR>
								<TD>Maturity Date</TD>  
								<TD>
									<INPUT TYPE="Text" NAME="Text_mat_date1" VALUE="01"	SIZE=3 MAXLENGTH=2 class="txt_input5" >
									<INPUT TYPE="Text" NAME="Text_mat_month1" VALUE="12" SIZE=3 MAXLENGTH=2 class="txt_input5" >
									<INPUT TYPE="Text" NAME="Text_mat_year1"  VALUE="2099" SIZE=5 MAXLENGTH=4   class="txt_input5" onBlur="Maturity_date(document.Form1.Text_mat_date1,document.Form1.Text_mat_month1,document.Form1.Text_mat_year1)">
							<input type = "hidden" name = "TXT_END_DATE" id = "TXT_END_DATE" /></TD>
							</TR>
							<TR>
								<TD WidTH="35%">Coupon Interest %</TD>
								<TD WidTH="65%"><INPUT TYPE="Text" NAME="TXT_COUINT" VALUE="0"	class="txt_input6" ALIGN="LEFT" SIZE=59 MAXLENGTH=10 ONCHANGE="format_interest(document.Form1.TXT_COUINT)"></TD>
							</TR>
							<TR>
								<TD>Frequency of Coupon Payments per Annum</TD>
								<TD><INPUT TYPE="Text" NAME="TXT_CPPA"	class="txt_input6" VALUE="0" ALIGN="LEFT" SIZE=59 MAXLENGTH=1 ></TD>
							</TR>
							<TR>
								<TD>First Interest Payment Date</TD>
								<TD>
									<INPUT TYPE="Text" NAME="Text_pay_date1"  VALUE='01' SIZE=3 MAXLENGTH=2 class="txt_input5">
									<INPUT TYPE="Text" NAME="Text_pay_month1" VALUE='01' SIZE=3 MAXLENGTH=2 class="txt_input5" >
									<INPUT TYPE="Text" NAME="Text_pay_year1" VALUE='1900' SIZE=5 MAXLENGTH=4 class="txt_input5" onBlur="Payment_date(document.Form1.Text_pay_date1,document.Form1.Text_pay_month1,document.Form1.Text_pay_year1)" ></TD>
							</TR>
							<TR>
								<TD>Credit Rating for Security Issue</TD>
								<TD><INPUT TYPE="Text" NAME="TXT_CRSE"	class="txt_input6" VALUE="0" ALIGN="LEFT" SIZE=59 MAXLENGTH=10 ></TD>
							</TR>
							<TR>
								<TD WidTH="35%">Amount In Issue</TD>
								<TD WidTH="65%"><INPUT TYPE="Text" NAME="TXT_AMOISS"	class="txt_input6" VALUE="0" ALIGN="LEFT" SIZE=59 MAXLENGTH=59 ONCHANGE="format_In_Issue(document.Form1.TXT_AMOISS)"></TD>
							</TR>
							<TR>
								<TD>Weighted Average Yield at Issue</TD>
								<TD><INPUT TYPE="Text" NAME="TXT_WAYISS" class="txt_input6" ALIGN="LEFT" VALUE="0" SIZE=59 MAXLENGTH=3 ONCHANGE="format_Weighted_Average(document.Form1.TXT_WAYISS)"></TD>
							</TR>
							<TR>
								<TD>Par Value for Share</TD>
								<TD><INPUT TYPE="Text" NAME="TXT_PAR" class="txt_input6" ALIGN="LEFT" VALUE= "0" SIZE=59 MAXLENGTH=3 ONCHANGE="format_Weighted_Average(document.Form1.TXT_PAR)"></TD>
							</TR>
							<TR>
								<TD>MT Percent</TD>
								<TD><INPUT	TYPE="Text" NAME="Text_mt_percent" class="txt_input6" VALUE= "0"	ALIGN="LEFT" SIZE="15"></TD>
							</TR>
							<TR>
								<TD>Licence MT Percent</TD>
								<TD><INPUT	TYPE="Text" NAME="Text_licence_mt_percent"	VALUE= "0"class="txt_input6" ALIGN="LEFT" SIZE="15"></TD>
							</TR>
										
							<!-- Added by Udara on 12-01-2012 -->
							<TR>
								<TD>Concentration Percentage</TD>
								<TD><INPUT	TYPE="Text" NAME="Text_consent_perc"	VALUE= "0"class="txt_input6" MAXLENGTH="8" ALIGN="LEFT" SIZE="15"></TD>
							</TR>
							<!-- End by Udara on 12-01-2012 -->
										
							<!-- Added by Waruna on 2012-04-27--> 
							<TR>
								<TD>Listed Status</TD>
								<TD><SELECT NAME="Text_li_status" class="txt_input6" >
									<OPTION VALUE="B"  STYLE="{font: bold 9pt arial}" SELECTED>Non W</option> <!-- B change by waruna 2012-04-25 -->
									<OPTION VALUE="W"  STYLE="{font: bold 9pt arial}" >W</option>
                                </TD>
							</TR>
							<!-- End by Waruna on 2012-04-27 -->			
										
						</TABLE>
						
						
						
						
						<HR WidTH="*%">
						<B><U>Prospectus Information :</U></B>
						<TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0">
							<TR>
								<TD WidTH="35%">Information From Prospectus 1</TD>
								<TD WidTH="60%"><INPUT TYPE="Text" NAME="TXT_IFP1"	VALUE="User Input" class="txt_input6"	ALIGN="LEFT" SIZE=46 MAXLENGTH=200>
							</TR>
							<TR>
									<TD WidTH="35%">
									<TD WidTH="60%"><INPUT TYPE="Text" NAME="TXT_IFP2"	VALUE="User Input" class="txt_input6"	ALIGN="LEFT" SIZE=46 MAXLENGTH=200>
									<!-- <INPUT TYPE="button" VALUE="Next " NAME="BUT_IGCODE2" STYLE="{color: black; font: bold 8pt arial;}" ></TD>-->
									<TD WidTH="05%">
								 
							</TR>
						</TABLE>
						<DIV id=othername1></DIV>
						
						
						
						
						<HR WidTH="100%">
						<B><U>Other Notes :</U></B>
						<TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0">
							<TR>	
								<TD WidTH="35%">Other Notes 1</TD>
								<TD WidTH="60%"><INPUT TYPE="Text" NAME="TXT_ONOTE1"	VALUE="User Input" class="txt_input6"	ALIGN="LEFT" SIZE=46 MAXLENGTH=200>
							</TR>
							<TR>
							  <TD WidTH="35%">
								<TD WidTH="60%"><INPUT TYPE="Text" NAME="TXT_ONOTE2"	VALUE="User Input" class="txt_input6"	ALIGN="LEFT" SIZE=46 MAXLENGTH=200>
									<!--<INPUT TYPE="button" VALUE="Next " NAME="BUT_IGCODE4" STYLE="{color: black; font: bold 8pt arial;}" ></TD>-->
									<TD WidTH="05%">

							</TR>
						</TABLE>
						<DIV id=BoardDirector1></DIV>
						
						
						
					</TD>
				</TD>
			</TABLE>
		</FORM>
		<!--SCRIPT LANGUAGE="JavaScript" SRC="http://www.srilanka.sasianet.lk/home/mbfsl.js"></SCRIPT--> 
			<SCRIPT language1.2="JavaScript" src="validate_v1.js"></SCRIPT>
			<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
			<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT> 
</BODY>
		</HTML>
		
