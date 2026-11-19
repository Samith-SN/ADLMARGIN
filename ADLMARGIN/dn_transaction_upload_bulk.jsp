<HTML> 
	<HEAD>
		<TITLE>Margin Trading 
		</TITLE>
		<LINK REL="stylesheet" TYPE="text/css" HREF="" />
		
		
	</HEAD>
	<%@page import="net.sasianet.ADLMARGIN.*" %>
	<%	
		
		ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
		String m_jsp_client_url=m_sn_methods.jsp_client_url;
		//String client_name = m_sn_methods.client_name;
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
	
	<SCRIPT language="JavaScript1.2" >
		
			function Check_code(){
				document.Form1.save_but_sales.disabled='true';
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"SaveBulkTransaction?chksql=LastTRN";
				//window.open(m_url);	
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=0;
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				
				load_interface(m_url,'XML',false);
			    m_size = data_vec.length;
				
				if (m_size>1){	
					//document.Form1.Text_Record.value=top.frames[0].document.applets[0].outvec_value.elementAt(0);
					//document.Form1.Text_Date.value=top.frames[0].document.applets[0].outvec_value.elementAt(1);
					//document.Form1.Text_User.value=top.frames[0].document.applets[0].outvec_value.elementAt(2);
					//document.Form1.Text_Status.value=top.frames[0].document.applets[0].outvec_value.elementAt(3);
					
					document.Form1.Text_Record.value=data_vec[0];
					document.Form1.Text_Date.value=data_vec[1];
					document.Form1.Text_User.value=data_vec[2];
					document.Form1.Text_Status.value=data_vec[3];
					
					
					//document.Form1.Text_base_code.value=parent.frames[0].document.applets[0].outvec_value.elementAt(2);
					
				}
				
				Check_Purchase();
			}
			
			function Check_Purchase(){
				
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"SaveBulkTransaction?chksql=purchaseChk";
				//window.open(m_url);	
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=0;
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				
				load_interface(m_url,'XML',false);
			    m_size = data_vec.length;
				
				//alert(m_size);
				
				if (m_size>1){	
					
					
					//var pCount=top.frames[0].document.applets[0].outvec_value.elementAt(0);
					//var ptemCount=top.frames[0].document.applets[0].outvec_value.elementAt(1);
					
					var pCount=data_vec[0];
					var ptemCount=data_vec[1];
					
					//alert(pCount);
					//alert(ptemCount);
					if(pCount==0 && ptemCount==0){
						document.Form1.save_but_sales.disabled=false;
						return true;
					}
					
					else if(ptemCount>0){
						alert(' Please Genarate  Purchase');
						return false;
					}
					else if(pCount==1){
						document.Form1.save_but_sales.disabled=true;
						alert('There is a Pending Purchase  to be Confirmed ');
						return false;
					}
					else if(pCount>1){
						document.Form1.save_but_sales.disabled=true;
						alert('There are  Pending Purchase  to be Confirmed ');
						return false;
					}
					
				}
				
			}
			
			/*
			
			function before_submit(){
				m_url = servlet_client_url+":"+client_t3_port+"/"+client_name+"SaveBulkTransaction?chksql=Bulk_Transactio_Upload";
				window.open(m_url,'disp_Window_details','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=400,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				//document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"SaveBulkTransaction";
				//document.Form1.submit();
				
				//add by waruna 2011-01-24 mactching cds and security codes//comment by waruna 2011-05-19
				//m_url = servlet_client_url+":"+client_t3_port+"/"+client_name+"SaveBulkTransaction?chksql=Not_Match";
				//window.open(m_url,'disp_Window_error','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=400,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			}		
			
			function before_submit_rej(){
				m_url = servlet_client_url+":"+client_t3_port+"/"+client_name+"SaveBulkTransaction?chksql=Bulk_Transactio_Upload_rej";
				window.open(m_url,'disp_Window_details','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=400,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				//document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"SaveBulkTransaction";
				//document.Form1.submit();
				
				//add by waruna 2011-01-24 mactching cds and security codes//comment by waruna 2011-05-19
				//m_url = servlet_client_url+":"+client_t3_port+"/"+client_name+"SaveBulkTransaction?chksql=Not_Match";
				//window.open(m_url,'disp_Window_error','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=400,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			}		
			
			function gen_transaction(tType){
				
				m_url = servlet_client_url+":"+client_t3_port+"/"+client_name+"SaveBulkTransaction?chksql=Bulk_Transactio_Generate&type="+tType+"";
				window.open(m_url,'disp_Window_details','left=0,top=0,width=1000,height=400,toolbar=0,location=0,left=150,top=400,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				//document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"SaveBulkTransaction";
				//document.Form1.submit();
			}		
			function gen_transaction_sale(tType){
				var val= Check_Purchase();
				//alert(val);
				if(val==true){
					m_url = servlet_client_url+":"+client_t3_port+"/"+client_name+"SaveBulkTransaction?chksql=Bulk_Transactio_Generate&type="+tType+"";
					window.open(m_url,'disp_Window_details','left=0,top=0,width=1000,height=400,toolbar=0,location=0,left=150,top=400,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
					//document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"SaveBulkTransaction";
					//document.Form1.submit();
				}
				else{
					document.Form1.save_but_sales.disabled=true;
					alert(' Please Genarate  Purchase');
				}
			}	
		
			*/
		
			// ------------------------------------------------------------------
		
			function pop_up_message(m_url){	
				
				//setTimeout("hide_image()",2000);
				if ($("#DIV_MSG_WINDOW").dialog("isOpen")) 
				{
            		$("#DIV_MSG_WINDOW").dialog("close");
            	}
            	$("#DIV_MSG_WINDOW").dialog("option", "title", "Upload");
            	$("#DIV_MSG_WINDOW").dialog("open");
				//m_url="<%=m_jsp_client_url%>/Daily_Routine_gif.jsp";
            	$("#IFRAME_MSG_WINDOW").attr("src",m_url);
            	return false;
				
			}
		
			function before_submit(){
				m_url = servlet_client_url+":"+client_t3_port+"/"+client_name+"SaveBulkTransaction?chksql=Bulk_Transactio_Upload";
				//window.open(m_url,'disp_Window_details','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=400,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				pop_up_message(m_url);
			}
			
			function before_submit_rej(){
				
				m_url = servlet_client_url+":"+client_t3_port+"/"+client_name+"SaveBulkTransaction?chksql=Bulk_Transactio_Upload_rej";
				//window.open(m_url,'disp_Window_details','left=0,top=0,width=500,height=400,toolbar=0,location=0,left=150,top=400,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				pop_up_message(m_url);

			}		
			
			function gen_transaction(tType){
				
				m_url = servlet_client_url+":"+client_t3_port+"/"+client_name+"SaveBulkTransaction?chksql=Bulk_Transactio_Generate&type="+tType+"";
				//window.open(m_url,'disp_Window_details','left=0,top=0,width=1000,height=400,toolbar=0,location=0,left=150,top=400,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				pop_up_message(m_url);
			}		
			function gen_transaction_sale(tType){
				var val= Check_Purchase();

				if(val==true){
					m_url = servlet_client_url+":"+client_t3_port+"/"+client_name+"SaveBulkTransaction?chksql=Bulk_Transactio_Generate&type="+tType+"";
                    pop_up_message(m_url);
				}
				else{
					document.Form1.save_but_sales.disabled=true;
					alert(' Please generate purchases before the generation of sales');
				}
			}	
		
		    // ---------------------------------------------------
		
		
		
		
			<!----------------------------------------------------------------------------------------------->
			function screen_close(){
				//top.frames[1].location=(html_client_url+"/low.html");
				top.frames[1].location.href='low.jsp';
			} 

		
			function hide_image(){
				$("#DIV_MSG_WINDOW").dialog("close");
			}
		
		
			function getW() {
	            var w = 0;
	            if (window.document.innerWidth > w) {
	            w = window.document.innerWidth;
	            }
	            if (window.document.documentElement.clientWidth > w) {
	            w = window.document.documentElement.clientWidth;
	            }
	            return (w - 100);
			}
	
	        function clearIsOpen()
			{ 
              	isOpen=false; 
            }
	
			var isOpen=false;
		
			function initmsgDrillDialog()
	        {
				
	             $("#DIV_MSG_WINDOW").dialog(
				
				 {
					
	            	bgiframe: true,
	            	autoOpen: false,
	            	//modal: false,
					modal: true, //to disable the back ground	
	            	//height: 300,
	            	//width: getW,
				    height: 600,
	            	width: 500,
	            	close: function() 
					{
						
	            	}
	              }
				 );
           }
		
			$(document).ready
			(
				
				function() 
				{
	 				initmsgDrillDialog();
				}
			);
		
			
		
		
		
	</SCRIPT>
	
	<BODY  class='body & txt-body' onload='Check_code();' >
		<FORM NAME="Form1" ID="Form1" METHOD="POST" >
			
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="Bulk_Transactio_Upload">
			<INPUT TYPE="Hidden" NAME="Hid_stat_ser"	VALUE="">
			<INPUT TYPE="Hidden" NAME="Hid_stat_sec"	VALUE="">
			<INPUT TYPE="Hidden" NAME="Hid_stat_trn"	VALUE="">
			<INPUT TYPE="Hidden" NAME="Hid_port"		VALUE="">
			<INPUT TYPE="Hidden" NAME="Hid_inst"		VALUE="">
			<INPUT TYPE="Hidden" NAME="Hid_todate"		VALUE="">
			<INPUT TYPE="Hidden" NAME="Hid_def"			VALUE="0">
			<INPUT TYPE="Hidden" NAME="Hid_pqr"			VALUE="">
			<INPUT TYPE="Hidden" NAME="Hid_abc"			VALUE="">
			
			<DIV>
				<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
					<tr>
						<td height='7'></td>
					</tr>
					
					<tr height='30' >
						<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
						<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Margin Trading - Data Entry</B></td>
						<td width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>
						
					</tr>
					
					
					
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
						<TR>
							<TD WIDTH="5%">
								<INPUT TYPE="Button" NAME="uplo_but"  VALUE=" Upload File "         onClick="before_submit();"      STYLE="{ width: 80px; }"   class="mainbut" >
							</TD>
							
							<TD WIDTH="5%">
								<INPUT TYPE="Button" NAME="uplo_but"  VALUE=" Upload Reject Data "  onClick="before_submit_rej();"  STYLE="{ width: 110px; }"  class="mainbut" >
							</TD>
							
							<TD WIDTH="5%">
								<INPUT TYPE="Button" NAME="save_but"  VALUE="Generate Purchases"    onClick="gen_transaction('B');" STYLE="{ width: 110px; }"  class="mainbut" >
							</TD>
							
							<TD WIDTH="5%">
								<INPUT TYPE="Button" NAME="save_but_sales"   VALUE="Generate Sales"  	   onClick="gen_transaction_sale('S');" STYLE="{ width: 100px; }" class="mainbut" disabled >
							</TD>
							
							<TD WIDTH='6%'>&nbsp;&nbsp;&nbsp;&nbsp;</TD>	
							
							<TD WIDTH="5%">
								<INPUT TYPE="Button" NAME="calcel_but" 		 VALUE=" Cancel"               onClick="top.frames[1].location.href='dn_transaction_upload_bulk.jsp'" class="mainbut" > 
							</TD>
							
							<TD WIDTH="5%">							
								<INPUT TYPE="Button" NAME="Exit_but"   		 VALUE=" &nbsp;Exit&nbsp; "    onClick="screen_close()" class="mainbut" >  
							</TD>
							
							<TD WIDTH="*%"> &nbsp;
							</TD>
							
							<TD WIDTH="20%" align='right'> <b> Transaction Upload </b> 
							</TD>
							
						</TR>
					</TABLE>
					
					<!----------->
					
					<TABLE WIDTH="100%">
						<tr height='25px;'></tr>
					</TABLE>
					<HR>
					<TABLE WIDTH="100%">
						<tr height='25px;'></tr>
					</TABLE>
					
					<BR>	
					<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
						<TR>
							<TD WIDTH="1%"></TD>
							<TD WIDTH="*%">
								
										<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0">
											<TR>
												<TD WIDTH="25%"> Last Updated Date  </TD>
												<TD WIDTH="25%"><INPUT TYPE="Text" class="txt_input6" NAME="Text_Date"	  ALIGN="LEFT" SIZE="20"  disabled></TD>
												<TD WIDTH="25%"> Number Of Record  </TD>
												<TD WIDTH="25%"><INPUT TYPE="Text" class="txt_input6" NAME="Text_Record"  ALIGN="LEFT" SIZE="20"  disabled></TD>
											</TR>
									
											<TR>
												<TD WIDTH="25%"> User  </TD>
												<TD WIDTH="25%"><INPUT TYPE="Text" class="txt_input6" NAME="Text_User"	  ALIGN="LEFT" SIZE="20"  disabled></TD>
												<TD WIDTH="25%"> Status </TD>
												<TD WIDTH="25%"><INPUT TYPE="Text" class="txt_input6" NAME="Text_Status"  ALIGN="LEFT" SIZE="20"  disabled></TD>
										
											</TR>
									
										</TABLE>
								
										<DIV ALIGN="CENTER" id=insdata ></DIV>
								
								
									</TD>
								</tr>
							</table>
						</TD>
					</tr>
					
				</table>
		
		
		   <div id ="DIV_MSG_WINDOW" title ="Upload">
	       <iframe id ="IFRAME_MSG_WINDOW" width = "90%" height = "90%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Day End Routine">
	       </iframe>
	       </div>
		
		
			</FORM>
			<SCRIPT language1.2="JavaScript" src="validate.js"></SCRIPT>
			<SCRIPT language1.2="JavaScript" src="market_rate_sec.js"></SCRIPT>
			<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
			
		</body>
	</html>
	
