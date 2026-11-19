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
		

		
		function refresh(){
			top.frames[1].location.href='dn_facility_approval.jsp';
		}
		
		function refresh_2(){
			top.frames[1].location.href='dn_facility_approval.jsp?deal_num=ORMT1109270002';
		}


		
		function pop_up_message(row_id){
			
			var obj_facility_no = jQuery("#FACILITY_APPROVAL_DETAILS").jqGrid ("getCell", row_id, 'PORTFOLIO_CODE'); 
			// m_url ='dn_facility_creation_drill.jsp?facility_no='+obj_facility_no;
			m_url ='dn_facility_creation_drill_new.jsp?facility_no='+obj_facility_no;
			/*
				if ($("#DIV_MSG_WINDOW").dialog("isOpen")) 
				{
            		$("#DIV_MSG_WINDOW").dialog("close");
            	}
            	$("#DIV_MSG_WINDOW").dialog("option", "title", "Facility Approval");
            	$("#DIV_MSG_WINDOW").dialog("open");
            	$("#IFRAME_MSG_WINDOW").attr("src",m_url);
            	return false;
			*/
			window.open(m_url,'displayWindow','menuBar=0,width=1024,height=768,resizable=yes,scrollbars=yes');

		}
		

		
		// ====================== Adding jason grid Start =====================================
		
		 function fn_view() {             
               m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Edit_client_facility_values?chksql=load_facility_approval_grid";
					jQuery('#FACILITY_APPROVAL_DETAILS').jqGrid({
                   url: m_url,
                   loadonce: 1,
                   datatype: 'json',
                   //colNames: ['Facility Code','Client Code','Client Name','Broker Code','Broker Name','Fac.Man Code','Fac.Man Name','Product Code','Product Name','Fee Code','Fee Name','Adviser Code','Details','Approve <input type="checkbox"  name="save_cb" value="s" onclick="checkBoxSaveAll(event,this);" />','Retrieve Type'], // commented by udara on 06-03-2012
				   colNames: ['Facility Code','Client Code','Client Name','Broker Code','Broker Name','Fac.Man Code','Fac.Man Name','Product Code','Product Name','Fee Code','Fee Name','Adviser Code','Details','Approve <input type="checkbox"  name="save_cb" value="s" onclick="checkBoxSaveAll(event,this);" />','Retrieve Type','Reject <input type="checkbox"  name="reject_cb" value="s" onclick="checkBoxRejectAll(event,this);" />'], // added by udara on 06-03-2012
                   colModel: [
						{name: 'PORTFOLIO_CODE',        index: 'PORTFOLIO_CODE',   	jsonmap: 'PORTFOLIO_CODE',    sortable: false, align: 'left',   width: 100, resizable: false,  unformat: unformatData, formatter:cellFomatterFacilityNo},
						{name: 'CLIENT_CODE',         	index: 'CLIENT_CODE',   	jsonmap: 'CLIENT_CODE', 	  sortable: false, align: 'left',   width: 100, resizable: false,  unformat: unformatData},
						{name: 'CLIENT_NAME',        	index: 'CLIENT_NAME',  	    jsonmap: 'CLIENT_NAME', 	  sortable: false, align: 'left' ,  width: 100, resizable: false,  unformat: unformatData},
						{name: 'BROKER_CODE',           index: 'BROKER_CODE',      	jsonmap: 'BROKER_CODE', 	  sortable: false, align: 'left',   width: 100, resizable: false,  unformat: unformatData},
						{name: 'BROKER_NAME',           index: 'BROKER_NAME',   	jsonmap: 'BROKER_NAME',  	  sortable: false, align: 'left',   width: 100, resizable: false,  unformat: unformatData },
						{name: 'FACILITY_MGR_CODE',     index: 'FACILITY_MGR_CODE', jsonmap: 'FACILITY_MGR_CODE', sortable: false, align: 'left',   width: 100, resizable: false,  unformat: unformatData },
						{name: 'FACILITY_MAN_NAME',     index: 'FACILITY_MAN_NAME', jsonmap: 'FACILITY_MAN_NAME', sortable: false, align: 'left',   width: 100, resizable: false,  unformat: unformatData },
						{name: 'FA_PRODUCT_CODE',       index: 'FA_PRODUCT_CODE',   jsonmap: 'FA_PRODUCT_CODE',   sortable: false, align: 'left',   width: 100, resizable: false,  unformat: unformatData, hidden:true },
						{name: 'PRODUCT_NAME',          index: 'PRODUCT_NAME',   	jsonmap: 'PRODUCT_NAME',  	  sortable: false, align: 'left',   width: 100, resizable: false,  unformat: unformatData, hidden:true },
						{name: 'FEE_PACK_CODE',         index: 'FEE_PACK_CODE',   	jsonmap: 'FEE_PACK_CODE',  	  sortable: false, align: 'left',   width: 100, resizable: false,  unformat: unformatData, hidden:true },
						{name: 'FEE_NAME',              index: 'FEE_NAME',   	    jsonmap: 'FEE_NAME',  	      sortable: false, align: 'left',   width: 100, resizable: false,  unformat: unformatData, hidden:true },
						{name: 'ADVISER_CODE',          index: 'ADVISER_CODE',   	jsonmap: 'ADVISER_CODE',  	  sortable: false, align: 'left',   width: 100, resizable: false,  unformat: unformatData },
						{name: 'details_but',           index: 'details_but',   	jsonmap: 'details_but',       sortable: false, align: 'center', width: 80,  resizable: false,  unformat: unformatData, formatter:cellFomatterDetailsButton},
						{name: 'Save',                  index: 'Save',              jsonmap: 'Approve', 		  sortable: false, align: 'center', width: 80,  resizable: false,  unformat: unformatData, formatter:checkBoxFmatterSave},
						{name: 'RETRIVE_TYPE',          index: 'RETRIVE_TYPE',      jsonmap: 'RETRIVE_TYPE', 	  sortable: false, align: 'center', width: 80,  resizable: false,  unformat: unformatData, formatter:cellFomatterRetrieveType, hidden:true},
						{name: 'Reject',                index: 'Reject',            jsonmap: 'Approve', 		  sortable: false, align: 'center', width: 80,  resizable: false,  unformat: unformatData, formatter:checkBoxFmatterReject}],
						
                   mtype: 'GET',
                   rownumbers: true,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
							width: 'auto',
                   hidegrid: false,
                   toolbar: [false, 'top'],
                   caption: 'Facility Approval',
				   jsonReader: {repeatitems: false},
                   gridComplete: function() {
						 
                           //$('#jqgh_ACTUAL_PAYMENTS_COLUMN_1').css('cursor', 'default');
                           //$('#jqgh_ACTUAL_PAYMENTS_COLUMN_2').css('cursor', 'default');
                           //$('#jqgh_ACTUAL_PAYMENTS_COLUMN_5').css('cursor', 'default');
                           //$('#jqgh_ACTUAL_PAYMENTS_COLUMN_6_0').css('cursor', 'default');
                           //$('#jqgh_ACTUAL_PAYMENTS_COLUMN_6').css('cursor', 'default');
                           //$('#jqgh_ACTUAL_PAYMENTS_COLUMN_7').css('cursor', 'default');
                           //$('#jqgh_ACTUAL_PAYMENTS_COLUMN_8').css('cursor', 'default');
                           //$('#jqgh_ACTUAL_PAYMENTS_COLUMN_9').css('cursor', 'default');
                           //$('#jqgh_ACTUAL_PAYMENTS_COLUMN_9_1').css('cursor', 'default');						
						
					},
					loadComplete : function(){
                        var rec_count=$("#TABLE_CLIENT_PAYMENT_APPROVE").jqGrid('getGridParam',"records");
                        document.Form1.hid_count.value=rec_count;
					}
               });
           }
		
		
		// Added by udara on 14-03-2012
		
		function checkBoxFmatterReject (cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='checkbox' id='reject_"+rowid+"'  name='reject_"+rowid+"' value='on'  onclick ='uncheckOppositeChkbox(\"reject\",this,"+rowid+");'     />";  
			  return link;
		 }
		
		
		 function uncheckOppositeChkbox(req_type,obj,rownum) {
			
			if(req_type=='save'){
				if(obj.checked==true){
					document.getElementById("reject_"+rownum).checked = false;	
					document.Form1.reject_cb.checked = false; 
				}
			}
			else if(req_type=='reject'){
				document.getElementById("save_"+rownum).checked = false;
				document.Form1.save_cb.checked = false; 
			}
			
		}    
		
		// End by udara on 14-03-2012
		
		
		 function cellFomatterDetailsButton(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span><input type='button' align='center' style ='text-align: center;'  id='m_detail_but_"+row_id+"' name='m_detail_but_"+row_id+"' value='Details' class='mainbut' onclick='pop_up_message("+row_id+");' /></span>";
                     return texts;
         } 
		
		/*
		 function checkBoxFmatterSave (cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='checkbox' id='save_"+rowid+"'  name='save_"+rowid+"' value='on'  onclick ='';     />";  
			  return link;
		 }
		*/
		
		function checkBoxFmatterSave (cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='checkbox' id='save_"+rowid+"'  name='save_"+rowid+"' value='on'  onclick ='uncheckOppositeChkbox(\"save\",this,"+rowid+");'     />";  
			  return link;
		 }


		function cellFomatterFacilityNo (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='FacNo_"+row_id+"' name='FacNo_"+row_id+"' value='"+cellvalue+"'  /></span>";
                     return texts;
        } 
		
		// Added by Udara on 17-11-2011
		function cellFomatterRetrieveType (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<input type='hidden' align='right' style ='text-align: right;'  id='hid_retrieve_type_"+row_id+"' name='hid_retrieve_type_"+row_id+"' value='"+cellvalue+"'  />";
                     return texts;
        } 
		// End by Udara on 17-11-2011

		function unformatData(cellvalue, options, cellobject) {
               return cellvalue;
        }
		

		// mod by udara on 14-03-2012
		function checkBoxSaveAll(e,obj) {
		  	e = e||event; /* get IE event ( not passed ) */
		  	e.stopPropagation? e.stopPropagation() : e.cancelBubble = true;

		  	var no_of_rows = jQuery("#FACILITY_APPROVAL_DETAILS").getDataIDs().length;
			
			document.Form1.reject_cb.checked = false;
			
		  	if(obj.checked==true){
				for(i=1; i<=no_of_rows; i++){
					document.getElementById("save_"+i).checked = true;
					document.getElementById("reject_"+i).checked = false; // added by udara on 06-03-2012
					m_dealnum = jQuery("#FACILITY_APPROVAL_DETAILS").jqGrid ("getCell", i, 'deal_no'); 

				}
		  	}
			else if(obj.checked==false){
				for(i=1; i<=no_of_rows; i++){
					document.getElementById("save_"+i).checked = false;
				}
			}
			
		}
		
		
		// mod by udara on 14-03-2012
		function checkBoxRejectAll(e,obj) {
		  	e = e||event; /* get IE event ( not passed ) */
		  	e.stopPropagation? e.stopPropagation() : e.cancelBubble = true;

		  	var no_of_rows = jQuery("#FACILITY_APPROVAL_DETAILS").getDataIDs().length;
			
			document.Form1.save_cb.checked = false;
			
		  	if(obj.checked==true){
				for(i=1; i<=no_of_rows; i++){
					document.getElementById("reject_"+i).checked = true;
					document.getElementById("save_"+i).checked = false; // added by udara on 06-03-2012
				}
		  	}
			else if(obj.checked==false){
				for(i=1; i<=no_of_rows; i++){
					document.getElementById("reject_"+i).checked = false;
				}
			}
			
		}
		
		
		
		// ====================== End Adding grid =============================================
		
	
	
		/*
		function beforesubmit() {
			
				var flag = "false";
			
				var no_of_rows = jQuery("#FACILITY_APPROVAL_DETAILS").getDataIDs().length;
			    document.Form1.Hid_rows.value = no_of_rows;
			    document.Form1.hid_count.value = no_of_rows;
				
				for(var t=1;t<=document.Form1.Hid_rows.value;t++) {
					
					if(document.getElementById("save_"+t).checked == true){
						flag = "true";
						break;
					}
				
				}
			
				if(flag == "true"){
					// alert("Ready to save");
					document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_facility_approval"; 
				    document.Form1.submit();
				}
				else{
					alert("No facilities to approve");
				}
				
				
				//Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_facility_approval"; 
				//Form1.submit();
		}
		
		*/
		
		function beforesubmit() {
			
				var flag = "false";
			
				var no_of_rows = jQuery("#FACILITY_APPROVAL_DETAILS").getDataIDs().length;
			    document.Form1.Hid_rows.value = no_of_rows;
			    document.Form1.hid_count.value = no_of_rows;
				
				for(var t=1;t<=document.Form1.Hid_rows.value;t++) {
					
					if(document.getElementById("save_"+t).checked == true){
						flag = "true";
						break;
					}
					
					else if(document.getElementById("reject_"+t).checked == true){
						flag = "true";
						break;
					}
				
				}
			
				if(flag == "true"){
					// alert("Ready to save");
					document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_facility_approval"; 
				    document.Form1.submit();
				}
				else{
					alert("No facilities to approve");
				}
				
				
				//Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_facility_approval"; 
				//Form1.submit();
		}  


		// ================== end saving functions =====================================
		
		// ================== starting reject functions ================================

		
		function unable_checkbox(){
			
			var no_of_rows = jQuery("#FACILITY_APPROVAL_DETAILS").getDataIDs().length;
			document.Form1.Hid_rows.value = no_of_rows;

			for(var t=1;t<=document.Form1.Hid_rows.value;t++) {
				m_chk_box="document.Form1.save_"+t;
				m_chk_box.disabled=false;
			}		
		}
		
		
		function testValue(rowid){
			var dealnum = jQuery("#FACILITY_APPROVAL_DETAILS").jqGrid ("getCell", rowid, 'deal_no'); 
		}
		
		
		// ================== end reject functions =====================================
		
	
		
	</SCRIPT>
	
	<SCRIPT LANGUAGE=VBScript TYPE="text/vbscript">
		Function makeMsgBox(title,mess,icon,buts,defbut,mods)
			butVal = buts + (icon*16) + (defbut*256) + (mods*4096)
			makeMsgBox = MsgBox(mess,butVal,title)  
			
		End Function
		
	</SCRIPT>

		<BODY  class='body & txt-body' onload= "fn_view();" > 
		
		<FORM action="RequestObjectInJSP.jsp" NAME="Form1" ID="Form1" METHOD="POST" >
			
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="facility_approval">
			<INPUT TYPE="Hidden" NAME="Hid_rows" >
			<INPUT TYPE="Hidden" NAME="Hid_dealValue" >
			<INPUT TYPE="Hidden" NAME="hid_chk_status" >
			<input type = "hidden" id = "hid_count" name = "hid_count" value="0" />
			
			<!--------------------------------------------------------------->
			<table class='table' border='0' cellpadding='0' cellspacing='0' width='100%'> 
				<tr>
					<td height='1'></td>
				</tr>
				<tr>				
					
					<td >
					
			<DIV   width='100%'>
				<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
					<tr>
						<td height='7'></td>
					</tr>
					
					<tr height='30' >
						<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
						<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Administration - Client Master Sub Module : Facility Approval</B></td>
						<td width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>
						
					</tr>					
					
				</TABLE>	
				
			</DIV>
<!-------------------------------------------------------------------->
					
					<TABLE WIDTH="100%" BGCOLOR="darkblue" >
						<TR>
							
							<TD WIDTH="4%">
								<INPUT TYPE="Button" NAME="but_save"   VALUE="Save"  onClick="beforesubmit();"  class="mainbut"  >
							</TD>

							<TD WIDTH="4%">
								<INPUT TYPE="Button" NAME="but_cancel"   VALUE="Cancel"  onClick="refresh();"  class="mainbut"  > <!--  iFrameWidthHeight() refresh -->
							</TD>
							<TD WIDTH="4%">
								<INPUT TYPE="Button" NAME="but_exit"   VALUE="Exit"  onClick="screen_close();"  class="mainbut"  >
							</TD>
							
						<!--	 <TD WIDTH="20%"><B> Facility Approval </B>-->
							</TD>	
							<TD WIDTH="*%"> &nbsp;
							</TD>
							<TD WIDTH="4%">
								<INPUT TYPE="Button" NAME="but_save"   VALUE="Save"  onClick="beforesubmit();"  class="mainbut"  >
							</TD>

							<TD WIDTH="4%">
								<INPUT TYPE="Button" NAME="but_cancel"   VALUE="Cancel"  onClick="refresh();"  class="mainbut"  > <!--  iFrameWidthHeight() refresh -->
							</TD>
							<TD WIDTH="4%">
								<INPUT TYPE="Button" NAME="but_exit"   VALUE="Exit"  onClick="screen_close();"  class="mainbut"  >
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
								
								
										
								<table id = "FACILITY_APPROVAL_DETAILS"></table>
										<DIV ALIGN="CENTER" id=insdata ></DIV>
								
								
							</TD> <!-- -->
								</tr>
							</table>
						</TD>
					</tr>
					
				</table>
		
		
		   <div id ="DIV_MSG_WINDOW" title ="Facility Approval">
	       <iframe id ="IFRAME_MSG_WINDOW" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Day End Routine">
	       </iframe>
	       </div>

		  <div id ="DIV_MSG_DEAL_TICKET" title ="Deal Ticket">
	       <iframe id ="IFRAME_MSG_DEAL_TICKET" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Deal Ticket">
	       </iframe>
	       </div>

		   <div id = "DIV_AVAILABILITY_DETAILS">
                     
                      <div id = "DIV_FACILITY_DETAILS"></div>

           </div>
		
		
			</FORM>
			<!-- <SCRIPT language1.2="JavaScript" src="validate.js"></SCRIPT> -->
			<SCRIPT language1.2="JavaScript" src="market_rate_sec.js"></SCRIPT>
			<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>
			<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
			
		</body>
	</html>
	
