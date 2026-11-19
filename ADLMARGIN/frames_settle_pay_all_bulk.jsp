<%@page import="net.sasianet.ADLMARGIN.*" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Calendar" %>
<%@page import="java.util.Date" %>


<html>
	<head>
		<TITLE>Margin Trading </TITLE>
		<LINK REL="stylesheet" TYPE="text/css" HREF="" />
		
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
			
			//out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/SNET/jquery/grid/themes/blue/jquery-ui-1.7.1.custom.css' TYPE=\"text/css\">");
			out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/SNET/jquery/grid/4.1/themes/ui.jqgrid.css' TYPE=\"text/css\">");
			
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
			
			
			//out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.tablesorter.js\"></script>");	
			
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/i18n/grid.locale-en.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/jquery.jqGrid.min.js\"></script>");		
			
			
			
			Calendar calendar = Calendar.getInstance();
			
			String system_day   = Integer.toString(calendar.get(Calendar.DATE));
			String system_month = Integer.toString(calendar.get(Calendar.MONTH) + 1);
			String system_year  = Integer.toString(calendar.get(Calendar.YEAR));
			
			if (calendar.get(Calendar.DATE) < 10) {
				system_day = "0" + calendar.get(Calendar.DATE);
			}
			if (calendar.get(Calendar.MONTH) + 1 < 10) {
				system_month = "0" + (calendar.get(Calendar.MONTH) + 1);
			}
		%>
		
		
		
		<!-- header - edit "Data/yourHtmlHeader" to customize -->
		<!-- contents - edit "EventHandlers/Html file/onCreate" to customize -->
		
		
		<script>
			var m_grid_height=0;
			var m_grid_width=0;
			//--------------------------------------	
			
			$(document).ready(function() {
					// init_fancybox();
					//initDrillDownDialog()
					//call_frame();	
					m_grid_height = ($(window).height() - 200);
					m_grid_width = ($(window).width() - 0);
					initCal('VAL_TXT_DATE');		
					//bind_events();
				});
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
			//--------------------------------------
			
			function call_frame(){
				m_grid_height = ($(window).height() - 200);
				m_grid_width = ($(window).width() - 0);
				if(document.Form1.TXT_FROMDATE.value!="" && document.Form1.TXT_FROMMONTH.value!="" && document.Form1.TXT_FROMYEAR.value!=""){
					
					/* parent.frames[1].location.href=""+servlet_client_url+":"+client_t3_port+"/"+client_name+"BrokerBulkPaymentsAll?chksql=Bulk_payments"+
														"&val_fromdate="+document.Form1.TXT_FROMDATE.value+
																					"&val_frommonth="+document.Form1.TXT_FROMMONTH.value+
																					"&val_fromyear="+document.Form1.TXT_FROMYEAR.value;*/
					m_url=""+servlet_client_url+":"+client_t3_port+"/"+client_name+"BrokerBulkPaymentsAll?chksql=Bulk_payments"+
						"&val_fromdate="+document.Form1.TXT_FROMDATE.value+
						"&val_frommonth="+document.Form1.TXT_FROMMONTH.value+
						"&val_fromyear="+document.Form1.TXT_FROMYEAR.value+
						"&txt_facility_number="+document.Form1.txt_facility_number.value+
						"&txt_client_code="+document.Form1.txt_client_code.value+
						"&TXT_CLIENT_MANAGER="+document.Form1.TXT_CLIENT_MANAGER.value+
						"&txt_broker_code="+document.Form1.txt_broker_code.value
												
						;
					load_interface(m_url,'NO',false);	
					var newcontent = document.getElementById("data_div2");
					newcontent.innerHTML = data_vec_no;
					
					/*jQuery("#myTable").jqGrid({ 
							//url: 'server.php?q=tree', 
							//treedatatype: "xml",
							//mtype: "POST", 
							//colNames:["id","Account","Acc Num", "Debit", "Credit","Balance"],
							//colModel:[ {name:'id',index:'id', width:1,hidden:true,key:true}, {name:'name',index:'name', width:180}, {name:'num',index:'acc_num', width:80, align:"center"}, {name:'debit',index:'debit', width:80, align:"right"}, {name:'credit',index:'credit', width:80,align:"right"}, {name:'balance',index:'balance', width:80,align:"right"} ],
							height:'auto',
							//pager : "#ptreegrid",
							//treeGrid: true, 
							ExpandColumn :'name', caption: "Treegrid example" });
					*/
					
					tableToGrid("#myTable");
					jQuery("#myTable").setCaption('Payments'); 
					//jQuery("#myTable").setGridParam({rownumbers:true}).trigger("reloadGrid");//,rowTotal: 100000, rowList: [20, 30, 50, 100, 100000]}
					jQuery("#myTable").setGridHeight(m_grid_height);
					jQuery("#myTable").setGridWidth(m_grid_width);
					
					//jQuery("#myTable").setGridWidth(100%);
					//jQuery("#myTable").setGridParam({...}).hideCol("somecol").trigger("reloadGrid");
					
					
				}else{
					alert("Please enter Date and continue.");
				}
			}	
			
			function get_vector_normal(m_data){
				//var newcontent = document.getElementById("data_div2");
				//   newcontent.innerHTML = m_data;
			}
			
			function guaran(line){ 
				if(document.Form1.elements["save_status_"+line].checked==true){ 
					document.Form1.elements["save_status_"+line].value='Y'; 
				}else{
					document.Form1.elements["save_status_"+line].value='N'; 
				}
			}	
			
			function isNumber(sText) { 
				if (sText=='') return false;
				var ValidChars = ',-0123456789.';
				var IsNumber=true;
				var Char;
				var dotCnt = 0;
				for (i = 0; i < sText.length && IsNumber == true; i++)
				{
					Char = sText.charAt(i);
					if (Char=='.') dotCnt = dotCnt +1;
					if (ValidChars.indexOf(Char) == -1 || dotCnt>1)
					{
						IsNumber = false;
					}
				}
				return IsNumber;
			}
			function check_amount(line){
				if(parseFloat(document.Form1.elements["m_sett_amount_"+line].value)>parseFloat(document.Form1.elements["m_amount_"+line].value)){ 
					document.Form1.elements["save_status_"+line].value='N'; 
					document.Form1.elements["save_status_"+line].checked=false 
					alert('Amount should not be grater than '+document.Form1.elements["m_amount_"+line].value+'.'); 
					document.Form1.elements["save_status_"+line].checked=false 
					
				}
				
				else if(isNumber(unformat_noobject(document.Form1.elements["m_sett_amount_"+line].value))==false){ 
					document.Form1.elements["save_status_"+line].value='N'; 
					document.Form1.elements["save_status_"+line].checked=false
					alert('Please Enter Numerics for The Net Amount'); 
				}
				
				else if(parseFloat(unformat_noobject(document.Form1.elements["m_sett_amount_"+line].value))>parseFloat(document.Form1.elements["m_amount_"+line].value)){ 
					document.Form1.elements["save_status_"+line].value='N'; 
					document.Form1.elements["save_status_"+line].checked=false
					alert('Please Enter Less Amount'); 
				}else{
					
					
				}
			}	
			
			function chk_margin_factor(line){
				
			}	
			
			
			function beforesubmit(){
				
				//----------------------------------------------**	
			dayobj=document.Form1.TXT_FROMDATE;
			monthobj=document.Form1.TXT_FROMMONTH;
			yearobj=document.Form1.TXT_FROMYEAR;
		//	unformat(document.Form1.TXT_amount);
			
			buy_sett_date=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buy_sett_date="+buy_sett_date+"&chksql=chk_buy_sett_date_check";//-change by Prabash on 08-05-2013--chk_buy_sett_date
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
			
			
			document.Form1.HID_BUY_SETT_DATE.value=data_vec[0];
			//	alert(document.Form1.HID_BUY_SETT_DATE.value);
			
			if(document.Form1.HID_BUY_SETT_DATE.value=="YES"){
			//	alert("Value Date is not greater than Last Day End Routine Date, Please Re-Enter the Value Date !.");
				alert("Value Date is not greater than Last Day End Routine Date or daily margin trading date , Please Re-Enter the Value Date !.");
				dayobj.value=" ";	monthobj.value=" ";yearobj.value=" ";dayobj.focus();
			}
			//---------------------------------------------**	
			else{
				
				
				if(document.Form1.Hid_scr_name.value=="Broker_Payment"){
					document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"save_BulkPaymentsAll?chksql=Broker_Payment";
					document.Form1.submit();
				}else if(document.Form1.Hid_scr_name.value=="Bulk_payments_del"){ 
					document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_payments_confirmation?chksql=Bulk_payments_del";
					document.Form1.submit();	
				}else if(document.Form1.Hid_scr_name.value=="Bulk_payments_mod"){ 
					document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_payments_confirmation?chksql=Bulk_payments_del";
					document.Form1.submit();	
				}
				
			}
				
				
			}
			
			function chkstartdate(dayobj,monthobj,yearobj) {
				if (checkMonthLength(dayobj,monthobj,yearobj)) {
				}
			}	
			//add by waruna 2011-02-23 
			function display_pay_opt(val){
				
				
				if (val=='ADD'){
					document.Form1.Hid_scr_name.value="Broker_Payment";
					var newcontent = document.getElementById("data_div2");
					newcontent.innerHTML = "";
					//alert('dd');
					document.Form1.save_but.disabled=false;
					document.Form1.save_but2.disabled=false;
					document.Form1.go_but.disabled=false;
					document.Form1.TXT_FROMYEAR.disabled=false;
					document.Form1.TXT_FROMMONTH.disabled=false;
					document.Form1.TXT_FROMDATE.disabled=false;
					
					document.Form1.TXT_CLIENT_MANAGER.disabled=false;
					document.Form1.BUT_HELP_CLIENT_MANAGER_MAIN.disabled=false;
					document.Form1.txt_client_code.disabled=false;
					document.Form1.but_help_client_code_main.disabled=false;
					document.Form1.txt_facility_number.disabled=false;
					document.Form1.BUT_HELP_FACILITY_NUMBER.disabled=false;
					document.Form1.txt_broker_code.disabled=false;
					document.Form1.BUT_HELP_CLIENT_MANAGER_MAIN.disabled=false;
					
				}else if (val=='DEL'){
					
					document.Form1.Hid_scr_name.value="Bulk_payments_del";
					var newcontent = document.getElementById("data_div2");
					newcontent.innerHTML = "";
					
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"BrokerBulkPaymentsAll?chksql=Bulk_payments_del";
					load_interface(m_url,'NO',false);	
					var newcontent = document.getElementById("data_div2");
					newcontent.innerHTML = data_vec_no;
					
					tableToGrid("#myTable_del");
					jQuery("#myTable_del").setCaption('Payments'); 
					jQuery("#myTable_del").setGridHeight(m_grid_height);
					jQuery("#myTable_del").setGridWidth(m_grid_width);
					document.Form1.save_but.disabled=false;
					document.Form1.save_but2.disabled=false;
					
					document.Form1.TXT_CLIENT_MANAGER.disabled=false;
					document.Form1.BUT_HELP_CLIENT_MANAGER_MAIN.disabled=false;
					document.Form1.txt_client_code.disabled=false;
					document.Form1.but_help_client_code_main.disabled=false;
					document.Form1.txt_facility_number.disabled=false;
					document.Form1.BUT_HELP_FACILITY_NUMBER.disabled=false;
					document.Form1.txt_broker_code.disabled=false;
					document.Form1.BUT_HELP_CLIENT_MANAGER_MAIN.disabled=false;
					
				}else if (val=='MOD'){
					
					/* document.Form1.Hid_scr_name.value="Bulk_payments_mod";
						var newcontent = document.getElementById("data_div2");
						newcontent.innerHTML = "";
					
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"BrokerBulkPaymentsAll?chksql=Bulk_payments_del";
						load_interface(m_url,'NO',false);	
						var newcontent = document.getElementById("data_div2");
						newcontent.innerHTML = data_vec_no;
				
					tableToGrid("#myTable_mod");
					jQuery("#myTable_mod").setCaption('Payments'); 
					jQuery("#myTable_mod").setGridHeight(m_grid_height);
					jQuery("#myTable_mod").setGridWidth(m_grid_width);
					document.Form1.save_but.disabled=false;
					*/
					
				}
				
				
			}
			function fnDiableOnload(){
				
				document.Form1.save_but.disabled=true;
				document.Form1.save_but2.disabled=true;
				document.Form1.go_but.disabled=true;
				document.Form1.TXT_FROMYEAR.disabled=true;
				document.Form1.TXT_FROMMONTH.disabled=true;
				document.Form1.TXT_FROMDATE.disabled=true;
				
				
				document.Form1.TXT_CLIENT_MANAGER.disabled=true;
				document.Form1.BUT_HELP_CLIENT_MANAGER_MAIN.disabled=true;
				document.Form1.txt_client_code.disabled=true;
				document.Form1.but_help_client_code_main.disabled=true;
				document.Form1.txt_facility_number.disabled=true;
				document.Form1.BUT_HELP_FACILITY_NUMBER.disabled=true;
				document.Form1.txt_broker_code.disabled=true;
				document.Form1.BUT_HELP_CLIENT_MANAGER_MAIN.disabled=true;
				
			}	
			
			function dateSelectFunc(dateText, inst) {
				var splitResult = dateText.split('-');
				var instance_id = inst.id;
				var m_last_index_of_underscore = instance_id.lastIndexOf('_');
				var first_part = instance_id.substr(0, m_last_index_of_underscore + 1);
				var second_part = instance_id.substr(m_last_index_of_underscore + 1);
				if (instance_id == "VAL_TXT_DATE") {
					document.Form1.TXT_FROMDATE.value = splitResult[0];
					document.Form1.TXT_FROMMONTH.value = splitResult[1];
					document.Form1.TXT_FROMYEAR.value = splitResult[2];
					document.Form1.TXT_FROMYEAR.focus();
				}
				
				
			}
			function facility_number_help(m_strat)
			{
				var aForm;    //  aForm =oForm.elements;
				aForm =  document.getElementById('Form1');
				/*  var myObject = new Object();
				myObject.firstName = aForm.oFirstName.value;
				myObject.lastName = aForm.oLastName.value;
				*/
				
				var myObject=new Array(); //return values set to this object
				myObject[0]=aForm.txt_facility_number;
				myObject[1]=null;
				myObject[2]=null;
				myObject[3]=null;
				myObject[4]=null;
				
				var myObject_value=new Array(); //passing values set to this object
				myObject_value[0]=aForm.txt_facility_number.value;
				myObject_value[1]=aForm.txt_facility_number.value;//aForm.oLastName2.value;
				myObject_value[2]=null;
				myObject_value[3]=null;
				myObject_value[4]=null;
				
				
				var myObject_type=new Array(); //passing values data type
				myObject_type[0]="StringL";
				myObject_type[1]="StringL";
				myObject_type[2]=null;
				myObject_type[3]=null;
				myObject_type[4]=null;
				
				var qid='1';
				title_name='Help';
				var url = 'popup.jsp';
				var close_fun='close_portP_help';			
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
						url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
						dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
						height:400,// 500,
						width: 600,//900,
						title: 'SasiNet Frame Work',
						scrollable: true,
						onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
					});
			}
			
			
			function broker_code_help(m_strat)
			{
				var aForm;    //  aForm =oForm.elements;
				aForm =  document.getElementById('Form1');
				/*  var myObject = new Object();
				myObject.firstName = aForm.oFirstName.value;
				myObject.lastName = aForm.oLastName.value;
				*/
				
				var myObject=new Array(); //return values set to this object
				myObject[0]=aForm.txt_broker_code;
				myObject[1]=aForm.txt_broker_full_name;
				myObject[2]=null;
				myObject[3]=null;
				myObject[4]=null;
				
				var myObject_value=new Array(); //passing values set to this object
				myObject_value[0]=aForm.txt_broker_code.value;
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
				
				var qid='80';
				title_name='Help';
				var url = 'popup.jsp';
				var close_fun='close_portP_help';			
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
						url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
						dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
						height:400,// 500,
						width: 600,//900,
						title: 'SasiNet Frame Work',
						scrollable: true,
						onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
					});
			}
			
			
			function client_code_help(m_strat)
			{
				var aForm;    //  aForm =oForm.elements;
				aForm =  document.getElementById('Form1');
				/*  var myObject = new Object();
				myObject.firstName = aForm.oFirstName.value;
				myObject.lastName = aForm.oLastName.value;
				*/
				
				var myObject=new Array(); //return values set to this object
				myObject[0]=aForm.txt_client_code;
				myObject[1]=aForm.txt_client_full_name;
				myObject[2]=null;
				myObject[3]=null;
				myObject[4]=null;
				
				var myObject_value=new Array(); //passing values set to this object
				myObject_value[0]=aForm.txt_client_code.value;
				myObject_value[1]=aForm.txt_client_code.value;//aForm.oLastName2.value;
				myObject_value[2]=null;
				myObject_value[3]=null;
				myObject_value[4]=null;
				
				
				var myObject_type=new Array(); //passing values data type
				myObject_type[0]="StringL";
				myObject_type[1]="StringL";
				myObject_type[2]=null;
				myObject_type[3]=null;
				myObject_type[4]=null;
				
				var qid='79';
				title_name='Help';
				var url = 'popup.jsp';
				var close_fun='close_portP_help';			
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
						url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
						dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
						height:400,// 500,
						width: 600,//900,
						title: 'SasiNet Frame Work',
						scrollable: true,
						onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
					});
			}		
			
			function client_manager_code_help(m_strat)
			{
				var aForm;    //  aForm =oForm.elements;
				aForm =  document.getElementById('Form1');
				/*  var myObject = new Object();
				myObject.firstName = aForm.oFirstName.value;
				myObject.lastName = aForm.oLastName.value;
				*/
				
				var myObject=new Array(); //return values set to this object
				myObject[0]=aForm.TXT_CLIENT_MANAGER;
				myObject[1]=aForm.TXT_CLIENT_MANAGER_NAME;
				myObject[2]=null;
				myObject[3]=null;
				myObject[4]=null;
				
				var myObject_value=new Array(); //passing values set to this object
				myObject_value[0]=aForm.TXT_CLIENT_MANAGER.value;
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
				
				var qid='78';
				title_name='Help';
				var url = 'popup.jsp';
				var close_fun='close_portP_help';			
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
						url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
						dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
						height:400,// 500,
						width: 600,//900,
						title: 'SasiNet Frame Work',
						scrollable: true,
						onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
					});
			}		
			
			
			function chk_screen(){
			
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=get_pay_screen_status";	
		load_interface(m_url,'XML',false);
		
		m_size = data_vec.length;
		
			if(m_size>0){
			  if(data_vec[0]>0){
				
					if(confirm(data_vec[1] +'  is proceeding with the payment!!!! do you want to clear the data  and go ahead??')){
					
					   m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=payment_clear";	
		               load_interface(m_url,'XML',false);	
						
					}else{
					top.frames[1].location.href='low.jsp';
					}
				
				}
				
			}
		}
		</script>
	</head>
	
	<BODY class='body & txt-body' onload="chk_screen();fnDiableOnload();">
		<FORM NAME="Form1" ID="Form1">
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="Broker_Payment">
			<INPUT TYPE="Hidden" NAME="HID_BUY_SETT_DATE" VALUE="" >
			<!-----Added by Prabash on 06-09-2011-----------------------------  -->
			<DIV>
				<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
					<tr>
						<td height='7'></td>
					</tr>
					
					<tr height='30' >
						<td  width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
						<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Margin Trading - Settlement Management</B></td>
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
						<TD WIDTH="4%">	
						<INPUT TYPE="Button" NAME="ADD" VALUE="Add"   onClick= "display_pay_opt('ADD')" class="mainbut"  >
					</TD>
						<TD WIDTH="4%">	
						<INPUT TYPE="Button" NAME="DEL" VALUE="Delete"   onClick="display_pay_opt('DEL')"  class="mainbut"  >
					</TD>
						<!---------------------------------->
						<TD WIDTH="4%">	
						<INPUT TYPE="Button" NAME="save_but"  ID="save_but" VALUE="Save&nbsp; "   onClick="beforesubmit()" class="mainbut" disabled=true   >
					</TD>
						
						<TD WIDTH="4%">
						<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"   onClick="document.Form1.save_but.disabled=false;document.Form1.save_but2.disabled=false;top.frames[1].location.href='frames_settle_pay_all_bulk.jsp'" class="mainbut"> 
					</TD>
						<TD WIDTH="4%">
						<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit"   onClick="top.frames[1].location.href='low.html'" class="mainbut"> 
					</TD>
						<TD WIDTH="4%">
						<INPUT TYPE="Button" NAME="report_but" VALUE="Enquiry"    onClick="obtain_report_before()" class="mainbut">
						
					</TD>
						<TD  WIDTH="50%" class="hh1" align="right">
						<B>Broker Payments All</B>
					</TD>
					<TD WIDTH="4%">	
						<INPUT TYPE="Button" NAME="save_but2"  ID="save_but2" VALUE="Save&nbsp; "   onClick="beforesubmit()" class="mainbut" disabled=true   >
					</TD>
						
						<TD WIDTH="4%">
						<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"   onClick="document.Form1.save_but.disabled=false;document.Form1.save_but2.disabled=false;top.frames[1].location.href='frames_settle_pay_all_bulk.jsp'" class="mainbut"> 
					</TD>
						<TD WIDTH="4%">
						<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit"   onClick="top.frames[1].location.href='low.html'" class="mainbut"> 
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
						<br>
						<div id="date_div">	
						
						
						
						<!--</TABLE>	
						
						<TABLE WIDTH="*%"BORDER="0" CELLPADDING="0" CELLSPACING="0">
						<TD WIDTH="1%"></TD>
						<TD WIDTH="30%" >Date</TD>
						<TD WIDTH="35%"><INPUT TYPE="Text" NAME="TXT_FROMDATE" SIZE=3 MAXLENGTH=2 class="txt_input5" VALUE="<%=system_day%>">
						<INPUT TYPE="Text" NAME="TXT_FROMMONTH" SIZE=3 MAXLENGTH=2 class="txt_input5"  VALUE="<%=system_month%>" >
						<INPUT TYPE="Text" NAME="TXT_FROMYEAR" SIZE=4 MAXLENGTH=4 class="txt_input5" ONBLUR="chkstartdate(document.Form1.TXT_FROMDATE,document.Form1.TXT_FROMMONTH,document.Form1.TXT_FROMYEAR)" VALUE="<%=system_year%>" >
						<INPUT TYPE = "HIDDEN" NAME = "VAL_TXT_DATE" ID = "VAL_TXT_DATE" />
						<INPUT TYPE="Button" NAME="go_but" VALUE=" &nbsp;Go&nbsp; " onClick="call_frame()" class="mainbut" > 
						<TD WIDTH="50%"></TD>	
					</TABLE> 	
						
						
					</div>	
						
						
					</TABLE>-->
						
						
						<table border = "0">
						
						
						<tr>
						<td style = "width: 200px;"><div id = "DIV_TXT_CLIENT_MANAGER">Date</div></td>
						<td COLSPAN= '2'>
						<INPUT TYPE="Text" NAME="TXT_FROMDATE" SIZE=3 MAXLENGTH=2 class="txt_input5" VALUE="<%=system_day%>">
						<INPUT TYPE="Text" NAME="TXT_FROMMONTH" SIZE=3 MAXLENGTH=2 class="txt_input5"  VALUE="<%=system_month%>" >
						<INPUT TYPE="Text" NAME="TXT_FROMYEAR" SIZE=4 MAXLENGTH=4 class="txt_input5" ONBLUR="chkstartdate(document.Form1.TXT_FROMDATE,document.Form1.TXT_FROMMONTH,document.Form1.TXT_FROMYEAR)" VALUE="<%=system_year%>" >
						<INPUT TYPE = "HIDDEN" NAME = "VAL_TXT_DATE" ID = "VAL_TXT_DATE" />
					</td>
						<td style = "width: 60px;">
						
						<td style = "width: 120px;">
						<!-- <input class = "but_input" type = "button" id = "BUT_VIEW_ALL" name = "BUT_VIEW_ALL" value = "View All" style = "width: 80px;" onclick="fn_view();"/>-->
						<INPUT TYPE="Button" NAME="go_but" VALUE=" &nbsp;View&nbsp; " onClick="call_frame()" class="mainbut" >
					</td>
						<td style = "width: 200px;"></td>
						<td>
						
					</td>
					</tr>
						
						
						<tr>
						<td style = "width: 200px;"><div id = "DIV_TXT_CLIENT_MANAGER">Client Manager Code</div></td>
						<td><input class = "txt_input" type = "text" id = "TXT_CLIENT_MANAGER" name = "TXT_CLIENT_MANAGER" maxlength = "15" style = "width: 125px;" />
					</td>
						<td style = "width: 60px;">
						<input class = "but_input" type = "button" id = "BUT_HELP_CLIENT_MANAGER_MAIN" name = "BUT_HELP_CLIENT_MANAGER_MAIN" value = "..." onclick="client_manager_code_help(0);" />
						<td style = "width: 120px;">
						<!-- <input class = "but_input" type = "button" id = "BUT_VIEW_ALL" name = "BUT_VIEW_ALL" value = "View All" style = "width: 80px;" onclick="fn_view();"/>-->
					</td>
						<td style = "width: 200px;"><div id = "DIV_TXT_CLIENT_MANAGER_NAME">Client Manager Name</div></td>
						<td>
						<input class = "txt_input" type = "text" id = "TXT_CLIENT_MANAGER_NAME" name = "TXT_CLIENT_MANAGER_NAME" style = "width: 250px;" disabled = "disabled" />
					</td>
					</tr>
						
						
						<tr>
						<td style = "width: 200px;"><div id = "div_txt_client_code">Client Code</div></td>
						<td><input class = "txt_input" type = "text" id = "txt_client_code" name = "txt_client_code" maxlength = "250" style = "width: 125px;" /></td>
						<td style = "width: 60px;"><input class = "but_input" type = "button" id = "but_help_client_code_main" name = "but_help_client_code_main" value = "..."  onclick="client_code_help(0);"/>
					</td>
						<td style = "width: 120px;"></td>
						<td style = "width: 200px;"><div id = "div_txt_client_full_name">Client Full Name</div></td>
						<td><input class = "txt_input" type = "text" id = "txt_client_full_name" name = "txt_client_full_name" style = "width: 250px;" disabled = "disabled" /></td>
					</tr>
						
						<tr>
						<td style = "width: 200px;"><div id = "div_txt_facility_number">Facility Number</div></td>
						<td><input class = "txt_input" type = "text" id = "txt_facility_number" name = "txt_facility_number" maxlength = "15" style = "width: 125px;" />
					</td>
						<td style = "width: 60px;">
						<input class = "but_input" type = "button" id = "BUT_HELP_FACILITY_NUMBER" name = "BUT_HELP_FACILITY_NUMBER" value = "..." onclick="facility_number_help(0);"  />
						<a id = "help_update_client_manager" style = "text-decoration: none; cursor: text;" class = "fancylink iframe" href = ""> </a>
						<td style = "width: 120px;">
						
					</td>
						<td style = "width: 200px;"><div id = "txt_facility_number_name">Facility Number</div></td>
						<td>
						<input class = "txt_input" type = "text" id = "txt_facility_number_name" name = "txt_facility_number_name" style = "width: 250px;" disabled = "disabled" />
					</td>
					</tr>
						
						<tr>
						<td style = "width: 200px;"><div id = "div_txt_broker_code">Broker Code</div></td>
						<td><input class = "txt_input" type = "text" id = "txt_broker_code" name = "txt_broker_code" maxlength = "15" style = "width: 125px;" />
					</td>
						<td style = "width: 60px;">
						<input class = "but_input" type = "button" id = "BUT_HELP_CLIENT_MANAGER_MAIN" name = "BUT_HELP_CLIENT_MANAGER_MAIN" value = "..." onclick="broker_code_help(0);" />
						
						<td style = "width: 120px;">
						
					</td>
						<td style = "width: 200px;"><div id = "txt_broker_full_name">Broker Full Name</div></td>
						<td>
						<input class = "txt_input" type = "text" id = "txt_broker_full_name" name = "txt_broker_full_name" style = "width: 250px;" disabled = "disabled" />
					</td>
					</tr>                               
						
					</table>	
						
						
						<BR>
						
						<BR>
						<BR>		
						
						
						<table align='center' width='100%' class='table'>
						<tr> 
						<td width="100%"  height="70%"><div id="data_div2"></div></td>
					</tr> 
					</table>
						
					</FORM>
						<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>	
						<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>
					</body>
					</html>
						
