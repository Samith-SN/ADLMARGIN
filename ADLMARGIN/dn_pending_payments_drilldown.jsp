<HTML> 
	<HEAD>
		<TITLE>Margin Trading 
		</TITLE>
		<LINK REL="stylesheet" TYPE="text/css" HREF="" />
		
		
	</HEAD>
	<%@page import="net.sasianet.ADLMARGIN.*" %>
	
	<%	
		ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session); 
		//***************  ADDED BY KANISHKA ON 26/12/2012  *********************//
	
		Object done = (String)session.getValue("logon.isDone");  // marker object
		if (done == null) {
			response.sendRedirect("login.jsp");
			return;
			}
	
	//*************** ADDED BY KANISHKA ON 26/12/2012 [END]  *********************//
		
		String facility_no = request.getParameter("facility");
		String m_jsp_client_url = m_sn_methods.jsp_client_url;
		
		//out.println(facility_no);
		
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
		
			function pop_up_message_2(m_url){					
				if ($("#DIV_MSG_WINDOW").dialog("isOpen")) 
				{
            		$("#DIV_MSG_WINDOW").dialog("close");
            	}
            	$("#DIV_MSG_WINDOW").dialog("option", "title", "Pending Payments");
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
	            	height: 400,
	            	width: getW,
	            	close: function() 
					{
						
	            	}
	              }
				 );
           }
		
		
		   function initmsgDealTicketDrill(h,w)
	        {
				
	             $("#DIV_MSG_DEAL_TICKET").dialog(
				
				 {
					
	            	bgiframe: true,
	            	autoOpen: false,
	            	//modal: false,
					modal: true, //to disable the back ground	
	            	height: h,
	            	width: w,
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
					m_grid_height = ($(window).height() - 310);
	 				initmsgDrillDialog();
					initmsgDealTicketDrill(100,500);
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

		
		function fn_view() {   
			var facility_no = "<%=facility_no%>";
			var m_port = "<%=facility_no%>";
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Pending_payments_drilldown?chksql=pending_payments_drilldown&facility_no="+facility_no+"&port="+m_port; 
			       jQuery('#TABLE_AVAILABILITY_DETAILS').jqGrid({
                   url: m_url,
                   loadonce: 1,
                   datatype: 'json',
                   colNames: ['Broker Code','Broker Name','Facility No','Clinet Name','Due Date','Purchase Date','Amount Payable','Amount Paid','Pending Payment'],
                   colModel: [
						
						{name: 'sell_portfolio_code', index: 'sell_portfolio_code', jsonmap: 'sell_portfolio_code', sortable: true, align: 'left' , width: 70,  resizable: false,  unformat: unformatData},
						{name: 'pf_name',             index: 'pf_name',      	    jsonmap: 'pf_name', 		    sortable: true, align: 'left',  width: 150, resizable: false,  unformat: unformatData},
						{name: 'buy_portfolio_code',  index: 'buy_portfolio_code',  jsonmap: 'buy_portfolio_code',  sortable: true, align: 'left',  width: 70,  resizable: false,  unformat: unformatData},
						{name: 'name',                index: 'name',   	            jsonmap: 'name',  	            sortable: true, align: 'left',  width: 150, resizable: false,  unformat: unformatData},
						{name: 'due_date',            index: 'due_date',   	        jsonmap: 'due_date',            sortable: true, align: 'left',  width: 70,  resizable: false,  unformat: unformatData},
						{name: 'purchase_date',       index: 'purchase_date',       jsonmap: 'purchase_date', 		sortable: true, align: 'left',  width: 100,  resizable: false,  unformat: unformatData},
						{name: 'amount_payable',      index: 'amount_payable',   	jsonmap: 'amount_payable', 		sortable: true, align: 'right', width: 100, resizable: false,  unformat: unformatData},
						{name: 'amount_paid',         index: 'amount_paid',         jsonmap: 'amount_paid',         sortable: true, align: 'right', width: 100, resizable: false,  unformat: unformatData},
						{name: 'pending_payment',     index: 'pending_payment',     jsonmap: 'pending_payment',     sortable: true, align: 'right', width: 100, resizable: false,  unformat: unformatData }], 
							
                   mtype: 'GET',
                   rownumbers: true,
                   //rowNum: -1,
				   rownumbers: true,
                   gridview: true,
                   height: 'auto',
							width: 'auto',
                   hidegrid: false,
                   toolbar: [false, 'top'],
                   caption: 'Pending Payment',
				   sortname: 'buy_portfolio_code',
                   sortorder: 'DESC',
				   jsonReader: {repeatitems: false},
                   gridComplete: function() {
						 /*
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_1').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_2').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_5').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_6_0').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_6').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_7').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_8').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_9').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_9_1').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_10').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_11').css('cursor', 'default');
						*/
						
					},
					loadComplete : function(){
                        var rec_count=$("#TABLE_CLIENT_PAYMENT_APPROVE").jqGrid('getGridParam',"records");
                        document.Form1.hid_count.value=rec_count;
					}
               });
           }
		
		function unformatData(cellvalue, options, cellobject) {
               return cellvalue;
        }
	
		
	</SCRIPT>
	
	<SCRIPT LANGUAGE=VBScript TYPE="text/vbscript">
		Function makeMsgBox(title,mess,icon,buts,defbut,mods)
			butVal = buts + (icon*16) + (defbut*256) + (mods*4096)
			makeMsgBox = MsgBox(mess,butVal,title)  
			
		End Function
		
	</SCRIPT>

		<BODY  class='body & txt-body' onload= "fn_view();" >
		
		<FORM action="RequestObjectInJSP.jsp" NAME="Form1" ID="Form1" METHOD="POST" >
			
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="confirm_dealticket">
			<input type = "hidden" id = "hid_count" name = "hid_count" />

			<table class='table' border='0' cellpadding='0' cellspacing='0' width='100%'> 
				
				<tr>				
					
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
		
		
		   <div id ="DIV_MSG_WINDOW" title ="Pending Payments">
	       <iframe id ="IFRAME_MSG_WINDOW" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Day End Routine">
	       </iframe>
	       </div>
		
		  <div id ="DIV_MSG_DEAL_TICKET" title ="Deal Ticket">
	       <iframe id ="IFRAME_MSG_DEAL_TICKET" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Deal Ticket">
	       </iframe>
	       </div>
		
		   <div id = "DIV_AVAILABILITY_DETAILS">
                     <table id = "TABLE_AVAILABILITY_DETAILS"></table>
                      <div id = "DIV_PAGER_AVAILABILITY_DETAILS"></div>

           </div>
		
		
			</FORM>
			<!-- <SCRIPT language1.2="JavaScript" src="validate.js"></SCRIPT> -->
			<SCRIPT language1.2="JavaScript" src="market_rate_sec.js"></SCRIPT>
			<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>
			<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
			
		</body>
	</html>
	
