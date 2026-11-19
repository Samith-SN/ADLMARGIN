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
		
		
	// ***********************************************************************************		
	// ************* Start New Help ******************************************************	
	// ***********************************************************************************			
		
		// ====================================================================================
		
		
		function security_code_help(m_strat) {
			
			var aForm;    //  aForm =oForm.elements;
	     	aForm =  document.getElementById('Form1');
	
			var myObject=new Array(); //return values set to this object
	 		myObject[0]=aForm.TXT_SECURITY_CODE;
	 		myObject[1]=null;
	 		myObject[2]=null;
	 		myObject[3]=null;
	 		myObject[4]=null; 
	  
	 		var myObject_value=new Array(); //passing values set to this object
	
			myObject_value[0]=aForm.TXT_SECURITY_CODE.value;
	        myObject_value[1]=aForm.TXT_SECURITY_CODE.value;
	 		var myObject_type=new Array(); //passing values data type
			
			myObject_type[0]="StringL";
            myObject_type[1]="StringL";
			
	 
	 		var qid='15'; // 2
			var close_fun='close_security_code_help';
	 		var url = 'popup.jsp';
	 		var json_text = JSON.stringify(myObject_value, null,0);
	 		var json_obj_type_text=JSON.stringify(myObject_type, null,0);
	 		var fn_name=arguments.callee.name;
	if(fn_name==undefined){
		re = /^function\s+([^(]+)/;
        fn_name=re.exec(arguments.callee.toString())[1];
		}
	       	$.showModalDialog({
			 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun, //&close_fun='+close_fun,
			 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
			 height:400,// 500,
			 width: 400,//900, // cnanged by udara 22-11-2011
			 title: 'SasiNet Frame work',
			 scrollable: true,
			 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
			});
			
		}	// End security_code_help
			
			
		function close_security_code_help(){
			document.Form1.TXT_SECURITY_CODE.text='';
		}
		
		
		// ==================================================================================
		
		function instrument_type_help(m_strat) {
			
			var aForm;    //  aForm =oForm.elements;
	     	aForm =  document.getElementById('Form1');
	
			var myObject=new Array(); //return values set to this object
	 		myObject[0]=aForm.TXT_INSTRUMENT_TYPE;
	 		myObject[1]=null;
	 		myObject[2]=null;
	 		myObject[3]=null;
	 		myObject[4]=null;
	  
	 		var myObject_value=new Array(); //passing values set to this object
	
			myObject_value[0]=aForm.TXT_INSTRUMENT_TYPE.value;
	        myObject_value[1]=aForm.TXT_INSTRUMENT_TYPE.value;
			
	 		var myObject_type=new Array(); //passing values data type
			
			myObject_type[0]="StringL";
            myObject_type[1]="StringL";
			
	 
	 		var qid='14'; // 2
			var close_fun='close_instrument_type_help';
	 		var url = 'popup.jsp';
	 		var json_text = JSON.stringify(myObject_value, null,0);
	 		var json_obj_type_text=JSON.stringify(myObject_type, null,0);
	 		var fn_name=arguments.callee.name;
	if(fn_name==undefined){
		re = /^function\s+([^(]+)/;
        fn_name=re.exec(arguments.callee.toString())[1];
		}
	       	$.showModalDialog({
			 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun, //&close_fun='+close_fun,
			 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
			 height:400,// 500,
			 width: 400,//900,
			 title: 'SasiNet Frame work',
			 scrollable: true,
			 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
			});
			
		}	// End instrument_type_help
			
			
		function close_instrument_type_help(){
			document.Form1.TXT_INSTRUMENT_TYPE.text='';
		}

			
	
	// *********************************************************************************			
	// ************ End New Help *******************************************************		
	// *********************************************************************************			
		
	
	        function clearIsOpen(){ 
              	isOpen=false; 
            }
	
			var isOpen=false;
		
			$(document).ready
			(				
				function() 
				{
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
			
			  jQuery('#TABLE_SECURITY_APPROVAL').GridUnload('#TABLE_SECURITY_APPROVAL');

			   var security_code   = document.Form1.TXT_SECURITY_CODE.value;
			   var instrument_type = document.Form1.TXT_INSTRUMENT_TYPE.value;

				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"generate_conf?chksql=security_creation_approval&security_code="+security_code+"&instrument_type="+instrument_type;
			
				   jQuery('#TABLE_SECURITY_APPROVAL').jqGrid({
                   url: m_url,
                   loadonce: 1,
                   datatype: 'json',
                   colNames: ['Security Code','Instrument','Maturity Date','Save <input type="checkbox"  name="save_cb" value="s" onclick="checkAll(event,this)" />'],
                   colModel: [
						{name: 'security_code',   index: 'security_code',   jsonmap: 'security_code',     sortable: true, align: 'left',   width: 100, resizable: false,  unformat: unformatData , formatter:cellFomatterSecurityNo},
						{name: 'instrument_type', index: 'instrument_type', jsonmap: 'instrument_type',   sortable: true, align: 'left',   width: 80,  resizable: false,  unformat: unformatData},
						{name: 'maturity_date',   index: 'maturity_date',   jsonmap: 'maturity_date',     sortable: true, align: 'left',   width: 80,  resizable: false,  unformat: unformatData, formatter:cellEffectivedate }, 
						{name: 'Save',            index: 'Save',            jsonmap: 'Save', 			  sortable: false, align: 'center', width: 80,  resizable: false,  unformat: unformatData,  formatter:checkBoxFmatterSave}],
						
						
                   mtype: 'GET',
                   rownumbers: true,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
							width: 'auto',
                   hidegrid: false,
                   toolbar: [false, 'top'],
                   caption: 'Security Creation Approval',
				   jsonReader: {repeatitems: false},
                   gridComplete: function() {
						
					},
					loadComplete : function(){
                        var rec_count=$("#TABLE_SECURITY_APPROVAL").jqGrid('getGridParam',"records");
                        document.Form1.hid_count.value=rec_count;
					}
               });
           }
		
		
		function checkAll(e,obj){
			
			e = e||event; 
		    e.stopPropagation? e.stopPropagation() : e.cancelBubble = true;

		    var no_of_rows = jQuery("#TABLE_SECURITY_APPROVAL").getDataIDs().length;			
			
			if(document.Form1.save_cb.checked==true){
					for(i=1; i<=no_of_rows; i++){ 
						document.getElementById("save_"+i).checked = true;
					} 
			}
			else{
				for(i=1; i<=no_of_rows; i++){ 
						document.getElementById("save_"+i).checked = false;
				} 
			}
			
		}

		
		 function checkBoxFmatterSave (cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='checkbox' id='save_"+rowid+"'  name='save_"+rowid+"' value='on'  onclick ='' />";  
			  return link;
		 }

		function cellFomatterSecurityNo (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='SecurityNo_"+row_id+"' name='SecurityNo_"+row_id+"' value='"+cellvalue+"'  /></span>";
                     return texts;
        } 
		
		function cellEffectivedate (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='EffectiveDate_"+row_id+"' name='EffectiveDate_"+row_id+"' value='"+cellvalue+"'  /></span>";
                     return texts;
        } 


		function unformatData(cellvalue, options, cellobject) {
               return cellvalue;
        }
		
		function saveValues(){
			var no_of_rows = jQuery("#TABLE_SECURITY_APPROVAL").getDataIDs().length;
			document.Form1.hid_count.value = no_of_rows;  
			var flag = "false";
			for(i=1; i<=no_of_rows; i++){ 
				if(document.getElementById("save_"+i).checked == true){
					flag = "true";
					break;
				}					
			} 
			
			if(flag=="false"){
				alert('No securities are selected to approve');
			}
			else{
				if(confirm("Do you want to save ?")){
					document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsavsecurities_approval";
					document.Form1.submit();
				}
			}
		}
		
		
	</SCRIPT>
	
	<BODY  class='body & txt-body' onload= "" >
		
		<FORM NAME="Form1" ID="Form1" METHOD="POST" >

			    <INPUT TYPE="Hidden" NAME="hid_count"	 VALUE="MARKET_VALUE">
			    <INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="Security_creation_approval">
				<INPUT TYPE="Hidden" NAME="hid_help_type"	VALUE="DELETE_DEAL">
				<INPUT TYPE="Hidden" NAME="Hid_dealValue"	VALUE="DELETE_DEAL">
			
			<DIV>
				<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
					<tr>
						<td height='7'></td>
					</tr>
					
					<tr height='30' >
						<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
						<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B> Administration - Security</B></td>
						<td width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>						
					</tr>
					
				</TABLE>	
				
			</DIV>
			<!--------------------------------------------------------------->
			<table class='table' border='0' cellpadding='1' cellspacing='0' width='100%'> 
				<tr>
					<td height='1'></td>
				</tr>
				<tr>									
					<TABLE WIDTH="97%" ALIGN="CENTER" BGCOLOR="darkblue" >
						<TR>							
													
						
							<TD WIDTH="5%"><INPUT TYPE="Button" NAME="Save_but"        VALUE=" &nbsp;Save&nbsp; "  onClick="saveValues();" class="mainbut" ></TD>
							<TD WIDTH="5%"><INPUT TYPE="Button" NAME="Cancel_but"      VALUE=" Cancel"             onClick="top.frames[1].location.href='dn_security_creation_approval.jsp'" class="mainbut" > </TD>
							<TD WIDTH="5%"><INPUT TYPE="Button" NAME="Exit_but"        VALUE=" &nbsp;Exit&nbsp; "  onClick="screen_close()" class="mainbut" ></TD>						
						    <TD align='right'> <B> Security Approval</B> </TD>	
							
						</TR>
					</TABLE>
					
					<HR>
					
					<BR>	
					<!-- <TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0"> -->
					<TABLE WIDTH="97%" ALIGN="CENTER" BGCOLOR="darkblue" border='0' cellpadding='1' cellspacing='0'>
						
						<TR>							
						   <TD WIDTH="12%"> Security Code </TD>							
						   <TD WIDTH="40%"> 
								 <INPUT TYPE="text"   NAME="TXT_SECURITY_CODE"   align="left" size="20"  class="txt_input6 "  maxlength="20" >
						    	 <INPUT TYPE="Button" NAME="BUT_SECURITY_CODE" VALUE="..." onClick="security_code_help(0);" class="mainbut" >
							</TD>
							<TD WIDTH="*%"> &nbsp; </TD>
					    </TR>	
						
						<TR>							
						   <TD WIDTH="12%"> Instrument Type </TD>							
						   <TD WIDTH="40%"> 
								 <INPUT TYPE="text"   NAME="TXT_INSTRUMENT_TYPE"   align="left" size="20"  class="txt_input6 "  maxlength="20" >
						    	 <INPUT TYPE="Button" NAME="BUT_INSTRUMENT_TYPE" VALUE="..." onClick="instrument_type_help(0);" class="mainbut" >
							</TD>
							<TD WIDTH="*%"> &nbsp; </TD>
					    </TR>
						
						<TR>
							<TD WIDTH="12%"> &nbsp; </TD>
							<TD WIDTH="40%"><INPUT TYPE="Button" NAME="search_transactions"  VALUE="Search" onClick="fn_view();" class="mainbut" ></TD>
							<TD WIDTH="*%"> &nbsp; </TD>
						</TR>						
								<TR>
									<TD WIDTH="1%"></TD>
									<TD WIDTH="*%"> <!-- -->
										
												<table align='center' width='100%' class='table'>
												<tr> 
												<td width="100%"  height="70%"><div id="data_div"></div></td>
												</tr> 
												</table>										
										
												<DIV ALIGN="CENTER" id=insdata ></DIV>																		
									</TD> 
								</tr>
							</table>
						</TD>
					</tr>
					
				</table>
		
		  <div id = "DIV_AVAILABILITY_DETAILS">
                     <table id = "TABLE_SECURITY_APPROVAL"></table>
                      <div id = "DIV_PAGER_REVERSAL_DETAILS"></div>
           </div>
	
		
			</FORM>

			<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>
			<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
			
		</body>
	</html>
	
