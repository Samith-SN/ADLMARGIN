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
		
			function dateSelectFunc(dateText, inst){
			
				var splitResult = dateText.split('-');
				var instance_id = inst.id;
				var m_last_index_of_underscore = instance_id.lastIndexOf('_');
				var first_part = instance_id.substr(0, m_last_index_of_underscore + 1);
				var second_part = instance_id.substr(m_last_index_of_underscore + 1);
				
				if (inst.id=="TRN_DATE"){
					document.Form1.TXT_DATE.value=splitResult[0];
					document.Form1.TXT_MONTH.value=splitResult[1];
					document.Form1.TXT_YEAR.value=splitResult[2];
					
					document.Form1.TRN_DATE.value = splitResult[0]+'-'+splitResult[1]+'-'+splitResult[2];
				}
			}
		
			function initCal(inst){
				$("#"+inst).datepicker({dateFormat:'dd-mm-yy',duration: 'fast',yearRange: '1920:2050',showOn: 'button',buttonImage: 'http://www.netfac.lk/SNET/images/calendar.gif',buttonImageOnly: true,changeMonth: true,changeYear: true,onSelect: function(dateText, inst){dateSelectFunc(dateText,inst);}});
			}
		
		
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
					initCal("TRN_DATE");
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
						else{
							closeIframe();
						}
					}
					else{
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Save_MarketRates_New?chksql=Auto_Market_Rates&m_date="+document.Form1.TXT_DATE.value+"&m_month="+document.Form1.TXT_MONTH.value+"&m_year="+document.Form1.TXT_YEAR.value+"";
						pop_up_message(m_url);
					} 
					
				}

				
				display_uploaded_prices();
				
			}
		
			function closeIframe(){
			   var iframe = document.getElementById('IFRAME_MSG_WINDOW');
			   iframe.parentNode.removeChild(iframe);
			   document.getElementById('DIV_MSG_WINDOW').innerHTML = '<html><body><table align=center ><tr><td><h1> Cancelled </h1></td></tr><table></body></html>'; 
			}
		
			function display_uploaded_prices(){
				
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"security_marketvalue_equity_new_2?&mdate="+document.Form1.TXT_DATE.value+'-'+document.Form1.TXT_MONTH.value+'-'+document.Form1.TXT_YEAR.value;
				load_interface(m_url,'NO',false);	
		        var newcontent = document.getElementById("data_div");
                newcontent.innerHTML = data_vec_no;
				
				tableToGrid("#myTable_del");
			    jQuery("#myTable_del").setCaption('Security - Market value'); 
			    jQuery("#myTable_del").setGridHeight(m_grid_height);
				jQuery("#myTable_del").setGridWidth(m_grid_width);
				
			}
		
		
			function get_vector_normal(m_data){
			
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
				<INPUT TYPE="Hidden" NAME="Hid_def"	VALUE="0">
				<INPUT TYPE="Hidden" NAME="Hid_pqr"	VALUE="">
				<INPUT TYPE="Hidden" NAME="Hid_abc"	VALUE="">
			
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
							
						   <TD WIDTH="10%"> Value Date </TD>
						   <TD WIDTH="20%">
								<!--
								 <INPUT TYPE="text" NAME="TXT_DATE"	  align="left" size="3"  class="txt_input5 "  maxlength="2" >
								 <INPUT TYPE="text" NAME="TXT_MONTH"  align="left" size="3"  class="txt_input5 "  maxlength="2" > 
								 <INPUT TYPE="text" NAME="TXT_YEAR"	  align="left" size="4"  class="txt_input5 "  maxlength="4"  ONBLUR="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR)" >
						   		-->

								<input class="txt_input5" type="text" name="TXT_DATE"  maxlength="2" size="2" value=10   onblur = "checkMonthLength1(document.Form1.elements['TXT_DATE'], document.Form1.elements['TXT_MONTH'], document.Form1.elements['TXT_YEAR'], document.Form1.elements['TRN_DATE'], 'D', 'N'); " />
								<input class="txt_input5" type="text" name="TXT_MONTH" maxlength="2" size="2" value=10   onblur = "checkMonthLength1(document.Form1.elements['TXT_DATE'], document.Form1.elements['TXT_MONTH'], document.Form1.elements['TXT_YEAR'], document.Form1.elements['TRN_DATE'], 'M', 'N'); " />
								<input class="txt_input5" type="text" name="TXT_YEAR"  maxlength="4" size="4" value=2011 onblur = "checkMonthLength1(document.Form1.elements['TXT_DATE'], document.Form1.elements['TXT_MONTH'], document.Form1.elements['TXT_YEAR'], document.Form1.elements['TRN_DATE'], 'Y', 'N');" />
								<input type="hidden" name="TRN_DATE" id="TRN_DATE" value=10-10-2011 />
								
								
							</TD>
							
							<TD WIDTH="5%">
								<INPUT TYPE="Button" NAME="upload_mkt_val"   VALUE="Upload Market Values"  onClick="before_submit_auto();" STYLE="{ width: 120px; }" class="mainbut"  >
							</TD>
							
							<TD WIDTH="5%">
								<INPUT TYPE="Button" NAME="calcel_but" 		 VALUE=" Cancel"               onClick="top.frames[1].location.href='dn_security_market_rates_new.jsp'" class="mainbut" > 
							</TD>
							
							<TD WIDTH="5%">							
								<INPUT TYPE="Button" NAME="Exit_but"   		 VALUE=" &nbsp;Exit&nbsp; "    onClick="screen_close()" class="mainbut" >  
							</TD>
							
							<TD WIDTH="*%"> &nbsp;
							</TD>
							
							<!-- <TD WIDTH="25%"> <b> Security Market Rates New </b> -->
							<TD WIDTH="25%" align='right'> <b> <div id="m_table"> Security Market Rates New </div></b>
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
	
