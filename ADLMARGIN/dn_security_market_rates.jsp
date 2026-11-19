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
		//***************  ADDED BY KANISHKA ON 26/12/2012  *********************//
	
		Object done = (String)session.getValue("logon.isDone");  // marker object
		if (done == null) {
			response.sendRedirect("login.jsp");
			return;
			}
	
	//*************** ADDED BY KANISHKA ON 26/12/2012 [END]  *********************//
		
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/redmond/jquery-ui.css' TYPE=\"text/css\">");
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/blue/style.css' TYPE=\"text/css\">");
		
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");	
		
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/SNET/jquery/grid/4.1/themes/ui.jqgrid.css' TYPE=\"text/css\">");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/i18n/grid.locale-en.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/jquery.jqGrid.min.js\"></script>");

		
	%>
	
	<SCRIPT language="JavaScript1.2" >
		
			function pop_up_message(m_url){					
				if ($("#DIV_MSG_WINDOW").dialog("isOpen")) 
				{
            		$("#DIV_MSG_WINDOW").dialog("close");
            	}
            	$("#DIV_MSG_WINDOW").dialog("option", "title", "Upload Market Values");
            	$("#DIV_MSG_WINDOW").dialog("open");
            	$("#IFRAME_MSG_WINDOW").attr("src",m_url);
            	return false;
				
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
	            	height: 300,
	            	width: getW,
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
					m_grid_height = ($(window).height() - 150);
			   		m_grid_width = ($(window).width() - 0);
				}
			);
			
		
			function chkstartdate(dayobj,monthobj,yearobj) {
				checkMonthLength(dayobj,monthobj,yearobj);		
			}
		
			function screen_close(){
				top.frames[1].location.href='low.jsp';
			} 

			function load_date(){
				
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'inventory_by_date_location?chksql=chk_sysdate'; 	
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;

 				if(m_size>0){ 
					document.Form1.TXT_DATE.value  = data_vec[0];
			  		document.Form1.TXT_MONTH.value = data_vec[1]; 						 
			  		document.Form1.TXT_YEAR.value  = data_vec[2];	
				}	
	
			}

		
		
			function before_submit_auto(){
				
				if((document.Form1.TXT_DATE.value=="") || (document.Form1.TXT_MONTH.value=="") || (document.Form1.TXT_YEAR.value=="") ){
					alert("Please enter the date and continue !");
					document.Form1.TXT_DATE.focus();
				}
				else{
					
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Save_MarketRates_New?chksql=chaeck_date&m_date="+document.Form1.TXT_DATE.value+"&m_month="+document.Form1.TXT_MONTH.value+"&m_year="+document.Form1.TXT_YEAR.value+"";
					load_interface(m_url,'XML',false);
					m_size = data_vec.length;
					
					m_url_1 = servlet_client_url+":"+client_t3_port+"/"+client_name+"Save_MarketRates_New?chksql=get_popup&m_date="+document.Form1.TXT_DATE.value+"&m_month="+document.Form1.TXT_MONTH.value+"&m_year="+document.Form1.TXT_YEAR.value+""; // udara
					pop_up_message(m_url_1);
					
					if(m_size!=0){
					  	if(confirm("Do you want to update data for "+document.Form1.TXT_DATE.value+"-"+document.Form1.TXT_MONTH.value+"-"+document.Form1.TXT_YEAR.value+" ?")){
							m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Save_MarketRates_New?chksql=Auto_Market_Rates&m_date="+document.Form1.TXT_DATE.value+"&m_month="+document.Form1.TXT_MONTH.value+"&m_year="+document.Form1.TXT_YEAR.value+"";
							pop_up_message(m_url);
						}
					}
					else{
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Save_MarketRates_New?chksql=Auto_Market_Rates&m_date="+document.Form1.TXT_DATE.value+"&m_month="+document.Form1.TXT_MONTH.value+"&m_year="+document.Form1.TXT_YEAR.value+"";
						pop_up_message(m_url);
					} 
					
				}

				
				//display_uploaded_prices();
				
			}

		
		
		function get_vector_normal(m_data){
			
		}
		
		function refresh(){
			top.frames[1].location.href='dn_security_market_rates.jsp';
		}
		
		function debt(){
			
			document.Form1.Hid_scr_type.value = 'debt';
			
			m_url = servlet_client_url+":"+client_t3_port+"/"+client_name+"security_marketvalue_debt?&mdate="+document.Form1.TXT_DATE.value+'-'+document.Form1.TXT_MONTH.value+'-'+document.Form1.TXT_YEAR.value;

			load_interface(m_url,'NO',false);	
		    var newcontent = document.getElementById("data_div");
            newcontent.innerHTML = data_vec_no;
				
			tableToGrid("#myTable_del");
			jQuery("#myTable_del").setCaption('Security - Market value'); 
			jQuery("#myTable_del").setGridHeight(m_grid_height);
			jQuery("#myTable_del").setGridWidth(m_grid_width);
			
		}
		
		function equity(){
			
			document.Form1.Hid_scr_type.value = 'equity';
			
			m_url = servlet_client_url+":"+client_t3_port+"/"+client_name+"security_marketvalue_equity?&mdate="+document.Form1.TXT_DATE.value+'-'+document.Form1.TXT_MONTH.value+'-'+document.Form1.TXT_YEAR.value;

			load_interface(m_url,'NO',false);	
		    var newcontent = document.getElementById("data_div");
            newcontent.innerHTML = data_vec_no;
				
			tableToGrid("#myTable_del");
			jQuery("#myTable_del").setCaption('Security - Market value'); 
			jQuery("#myTable_del").setGridHeight(m_grid_height);
			jQuery("#myTable_del").setGridWidth(m_grid_width);	
		}
		
		function before_submit_Debt_2(){
			
			for (var i=0; i < document.Form1.elements.length; i++ ) {
					document.Form1.elements[i].disabled=false;					
			}

			var def = jQuery("#myTable_del").getDataIDs().length;
			document.Form1.Hid_def.value = def;
			flag1="yes";
			
			if(document.Form1.Hid_scr_type.value == 'debt'){ 
				//alert('Ready to save');
				Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"sav_marketvalue_debt";
				Form1.submit();
			}
			else if(document.Form1.Hid_scr_type.value == 'equity'){ 
				Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"sav_marketvalue_equity";
			    Form1.submit();
			}
			else{
				alert('No items to save');
			}
			
		}

		
		
		
	</SCRIPT>
	
	<BODY  class='body & txt-body' onload= "load_date();" >
		<FORM NAME="Form1" ID="Form1" METHOD="POST" >
			
			    <INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="MARKET_VALUE">
				<INPUT TYPE="Hidden" NAME="Hid_stat_ser"	VALUE="">
				<INPUT TYPE="Hidden" NAME="Hid_stat_sec"	VALUE="">
				<INPUT TYPE="Hidden" NAME="Hid_stat_trn"	VALUE="">
				<INPUT TYPE="Hidden" NAME="Hid_port"	VALUE="">
				<INPUT TYPE="Hidden" NAME="Hid_inst"	VALUE="">
				<INPUT TYPE="Hidden" NAME="Hid_todate"	VALUE="">
				<INPUT TYPE="Hidden" NAME="Hid_def"	VALUE="">
				<INPUT TYPE="Hidden" NAME="Hid_pqr"	VALUE="">
				<INPUT TYPE="Hidden" NAME="Hid_abc"	VALUE="">
			
				<INPUT TYPE="Hidden" NAME="Hid_scr_type" VALUE="">
			
			<DIV>
				<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
					<tr>
						<td height='7'></td>
					</tr>
					
					<tr height='30' >
						<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
						<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Administration - Security</B></td>
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
							
						   <TD WIDTH="10%"> Value Date </TD>
						   <TD WIDTH="20%"> 
								 <INPUT TYPE="text" NAME="TXT_DATE"	  align="left" size="3"  class="txt_input5 "  maxlength="2" >
								 <INPUT TYPE="text" NAME="TXT_MONTH"  align="left" size="3"  class="txt_input5 "  maxlength="2" > 
								 <INPUT TYPE="text" NAME="TXT_YEAR"	  align="left" size="4"  class="txt_input5 "  maxlength="4"  ONBLUR="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR)" >
						   </TD>
							
							<!--
							
							<TD WIDTH="5%">
								<INPUT TYPE="Button" NAME="ut_debt"   VALUE="Debt"  onClick="debt();"  class="mainbut"  >
							</TD>
							
							<TD WIDTH="5%">
								<INPUT TYPE="Button" NAME="but_save_debt"   VALUE="Save Debt"  onClick="before_submit_Debt_2();"  class="mainbut"  >
							</TD>
							
							-->
							
							<TD WIDTH="5%">
								<INPUT TYPE="Button" NAME="but_equity"   VALUE="Equity"  onClick="equity();"  class="mainbut"  >
							</TD>
							
							<TD WIDTH="5%">
								<INPUT TYPE="Button" NAME="but_save_equity"   VALUE="Save Equity"  onClick="before_submit_Debt_2();"  STYLE="{ width: 80px; }" class="mainbut"  >
							</TD>

							<TD WIDTH="5%">
								<INPUT TYPE="Button" NAME="but_mkt_rate_routine"   VALUE="Market Rates Routine"  onClick="before_submit_auto();" STYLE="{ width: 115px; }" class="mainbut"  >
							</TD>
							
							<TD WIDTH="5%">
								<INPUT TYPE="Button" NAME="but_refresh"   VALUE="Refresh"  onClick="refresh();"  class="mainbut"  >
							</TD>
							
							<TD WIDTH="5%">
								<INPUT TYPE="Button" NAME="but_close"   VALUE="Exit"  onClick="screen_close();"  class="mainbut"  >
							</TD>
							 <TD align='right'> <B> Security Market Rates</B> </TD>	
								
							

							<!--
							<TD WIDTH="25%"> <b> <div id="m_table"> Security Market Rates </div></b>
							</TD>
							-->
							
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
							<TD WIDTH="*%"> <!-- -->
								
										<table align='center' width='100%' class='table'>
										<tr> 
										<td width="100%"  height="70%"><div id="data_div"></div></td>
										</tr> 
										</table>
								
								
										
								
										<DIV ALIGN="CENTER" id=insdata ></DIV>
								
								
							</TD> <!-- -->
								</tr>
							</table>
						</TD>
					</tr>
					
				</table>
		
		
		   <div id ="DIV_MSG_WINDOW" title ="Upload Market Values">
	       <iframe id ="IFRAME_MSG_WINDOW" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Day End Routine">
	       </iframe>
	       </div>
		
		
			</FORM>
			<!-- <SCRIPT language1.2="JavaScript" src="validate.js"></SCRIPT> -->
			<SCRIPT language1.2="JavaScript" src="market_rate_sec.js"></SCRIPT>
			<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>
			<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
			
		</body>
	</html>
	
