<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Calendar" %>
<%@page import="java.util.Date" %>
<%@page import="net.sasianet.ADLMARGIN.*" %>
<%
	ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
	String m_jsp_client_url = m_sn_methods.jsp_client_url;
	//***************  ADDED BY KANISHKA ON 26/12/2012  *********************//
	
		Object done = (String)session.getValue("logon.isDone");  // marker object
		if (done == null) {
			response.sendRedirect("login.jsp");
			return;
			}
	
	//*************** ADDED BY KANISHKA ON 26/12/2012 [END]  *********************//
	
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
<html>
	<head>
		<title>Margin Trading</title>	
		<script type="text/javascript" src="<%= m_jsp_client_url %>/js/jquery.min.js"></script>
		<script type="text/javascript" src="<%= m_jsp_client_url %>/js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="<%= m_jsp_client_url %>/js/json2.js"></script> 
		<script type="text/javascript" src="<%= m_jsp_client_url %>/js/popup.js"></script>
		<script type="text/javascript" src="<%= m_jsp_client_url %>/SNET/jquery/grid/4.1/js/i18n/grid.locale-en.js"></script>
		<script type="text/javascript" src="<%= m_jsp_client_url %>/SNET/jquery/grid/4.1/js/jquery.jqGrid.min.js"></script>
		<script type="text/javascript" src="validate_v1.js"></script>
		<script type="text/javascript" src="ajax_data_gateway.js"></script> 
		
		<link rel="stylesheet" type="text/css" href="<%= m_jsp_client_url %>/css/Asset_Financing_System.css" />
		<link rel="stylesheet" type="text/css" href="<%= m_jsp_client_url %>/css/redmond/jquery-ui.css" />
		<link rel="stylesheet" type="text/css" href="<%= m_jsp_client_url %>/css/ui.jqgrid.css" />
		
		
		<script type="text/javascript">
			var iframe_html_string = '<iframe id = "IFRAME_DRILL_DOWN" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Drill Down"></iframe>';
			var iframe_html_string_2 = '<iframe id = "IFRAME_DRILL_DOWN_2" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Drill Down"></iframe>';
			
				$(document).ready(function() 
				{
					//init_fancybox();
					initDrillDownDialog();
					initmsgDrillDialog();
					initmsgDrillDialog();
					m_grid_height = ($(window).height() - 310);
					m_grid_width = ($(window).width() - 0);
					//bind_events();
				});
			
			
			
			function initDrillDownDialog(){
				$('#DIV_DRILL_DOWN').dialog({
						bgiframe: true,
						autoOpen: false,
						modal: false,
						height: 500,
						width: getW
					});
				$('#DIV_DRILL_DOWN_2').dialog({
						bgiframe: true,
						autoOpen: false,
						modal: false,
						height: 500,
						width: getW
					});
			}	
			
			// Added by Udara on 07-10-2011
			
			function pop_up_message(m_url){					
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
						height: 300,
						width: getW,
						close: function() 
						{
							
						}
					}
				);
			}
			
			
			// End by Udara on 07-10-2011
			
			
			
			function fn_view(){
				
				var m_client_code= document.getElementById("txt_client_code").value;
				var m_client_manager= document.getElementById("TXT_CLIENT_MANAGER").value;
				var m_port= document.getElementById("txt_facility_number").value;
				var m_broker_code= document.getElementById("txt_broker_code").value;		
				
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"availability_rpt?chksql=availability_rpt&port="+m_port+"&client_code="+m_client_code+"&client_manager="+m_client_manager+"&broker_code="+m_broker_code;
				//window.open(m_url);
				jQuery('#TABLE_AVAILABILITY_DETAILS').GridUnload();		
				jQuery('#TABLE_AVAILABILITY_DETAILS').jqGrid({
						url: m_url,
						loadonce: 1,
						datatype: 'json',
						/*colNames:[
							'Client Name',
							'Facility Number',
							'CDS Account No', 
							'Broker Code',
							'Advisor Code',
							'Approved Loan Limit',
							'Portfolio-Market Value',
							'Company Valuation',
							'Purchasing Power',
							'Margin-Market Value',
							'Margin-Valaution',
							'Pending Payments',
							'Loan Balance',
							'Future Loan Balance'
						],*/
						colNames:[
							'Client Name',
							'Facility Number',
							/*
							'CDS Account No', 
							'Broker Code',
							'Advisor Code',
							*/
							'Approved Limit',
							'Portfolio-MKT Value',
							'Company Valuation',
							'Purchasing Power',
							'Margin-MKT Value',
							'Margin-Valuation',
							'Resale Balance',
							'Pending Payments',
							'Future Payments',
							'CDS Account No', 
							'Broker Code',
							'Advisor Code'
						],
						colModel:[
							//{name:'id',          		      index:'id',                      width:55   },
							{name:'Client_Name' ,		      index:'Client_Name',             width:90   }, 
							{name:'Facility_Number',   	      index:'Facility_Number',         width:100  },
							/*{name:'CDS_Account_No', 	      index:'CDS_Account_No',          width:100,  align:"left"},
							{name:'Broker_Code',    	      index:'Broker_Code',             width:80,  align:"left"},
							{name:'Advisor_Code',  			  index:'Advisor_Code',            width:80,  align:"left"},*/
							{name:'Approved_Loan_Limit',      index:'Approved_Loan_Limit',     width:100,  align:"right", formatter:cellFomatterNumberPointer,unformat: unformatData2,  sortable:true,  sorttype: 'float'},
							{name:'Portfolio_Market_Value',   index:'Portfolio_Market_Value',  width:120,  align:"right", formatter:cellFomatterNumberPointer,unformat: unformatData2,  sortable:true,  sorttype: 'float'},
							{name:'Company_Valuation',        index:'Company_Valuation',       width:120,  align:"right", formatter:cellFomatterNumberPointer,unformat: unformatData2,  sortable:true,  sorttype: 'float'},
							{name:'Purchasing_Power',         index:'Purchasing_Power',        width:120,  align:"right", formatter:cellFomatterNumberPurchasingPower,unformat: unformatData2,  sortable:true,  sorttype: 'float'},
							{name:'Margin_Market_Value',      index:'Margin_Market_Value',     width:120,  align:"right", formatter:cellFomatterNumberMarketValue,unformat: unformatData2,  sortable:true,  sorttype: 'float'},
							{name:'Margin_Valaution',         index:'Margin_Valaution',        width:110,  align:"right", formatter:cellFomatterNumberMarketValue,unformat: unformatData2,  sortable:true,  sorttype: 'float'},
							
							{name:'Loan_Balance',             index:'Loan_Balance',            width:90,  align:"right", formatter:cellFomatterNumberPointer,unformat: unformatData2,  sortable:true,   sorttype: 'float'},
							
							{name:'Pending_Payments',         index:'Pending_Payments',        width:110,  align:"right", formatter:cellFomatterPendingPayments,unformat: unformatData2,sortable:true,  sorttype: 'float'},
							{name:'Future_Loan_Balance',      index:'Future_Loan_Balance',     width:100,  align:"right", formatter:cellFomatterNumberPointer,unformat: unformatData2,  sortable:true,  sorttype: 'float'},
							
						    {name:'CDS_Account_No', 	      index:'CDS_Account_No',          width:100,  align:"left"},
							{name:'Broker_Code',    	      index:'Broker_Code',             width:80,  align:"left"},
							{name:'Advisor_Code',  			  index:'Advisor_Code',            width:80,  align:"left"}
						], 
						// rowNum:10, 
						//rowList:[10,20,30],
						pager: '#DIV_PAGER_AVAILABILITY_DETAILS',
						rownumbers: true,
						// rowNum: 100000,
						rowTotal: 100000,
						rowList: [20, 30, 50, 100, 100000],
						viewrecords: true,
						gridview: true,
						height: m_grid_height,
						footerrow: true,
						userDataOnFooter: true,
						hidegrid: false,
						// forceFit: true,
						sortname: 'Facility_Number',
						sortorder: 'DESC',
						onCellSelect: jq_grid_click_event,
						gridComplete: function() {
							$('[title="Total"] > div').css({
									'text-align' : 'left',
									'cursor' : 'default'
								});
						},
						
						caption: 'Client Facilities'
						
						
						
					});
				
				jQuery("#TABLE_AVAILABILITY_DETAILS").jqGrid('navGrid','#DIV_PAGER_AVAILABILITY_DETAILS',{edit:false,add:false,del:false});
				
				// add custom button to export the data to excel
				jQuery("#TABLE_AVAILABILITY_DETAILS").jqGrid('navButtonAdd','#DIV_PAGER_AVAILABILITY_DETAILS',{
						caption:"Excel",
						onClickButton : function () { 
							
							//jQuery("#TABLE_AVAILABILITY_DETAILS").jqGrid('excelExport',{ url: m_url })	
							// jQuery("#TABLE_AVAILABILITY_DETAILS").jqGrid('excelExport',{tag:'pdf', url:m_url})	
							//jQuery("#TABLE_AVAILABILITY_DETAILS").excelExport();\
							//alert('hhi');
							//jQuery("#TABLE_AVAILABILITY_DETAILS").excelExport({tag:'pdf', url:m_url});
							//jQuery("#TABLE_AVAILABILITY_DETAILS").jqGrid('excelExport',{tag:'excel', url:m_url});
							jQuery("#TABLE_AVAILABILITY_DETAILS").jqGridExport({
									imptype: 'json'
									
								});
							
							
							
						} 
						
					});
				
				
			}
			
			function cellFomatterNumberPointer(cellvalue, options, rowObject) {
				cellvalue = format_noobject00(cellvalue, 2, null, 'BRACKETS');
				cellvalue = '<div style = "cursor: pointer;">' + cellvalue + '</div>';
				return cellvalue;
			}
			
			
			function cellFomatterNumberPurchasingPower(cellvalue, options, rowObject) {
				
				if(unformat_noobject(cellvalue)<0){ 
					
					cellvalue = format_noobject00(cellvalue, 2, null, 'BRACKETS');
					cellvalue = '<div style = "cursor: pointer;"><font style = "color: red;" >' + cellvalue + '</font></div>';
				}else{
					cellvalue = format_noobject00(cellvalue, 2, null, 'BRACKETS');
					cellvalue = '<div style = "cursor: pointer;">' + cellvalue + '</div>';
				}
				
				return cellvalue;
			}
			
			
			function cellFomatterNumberMarketValue(cellvalue, options, rowObject) {
				
				if(unformat_noobject(cellvalue)>50){
					cellvalue = format_noobject00(cellvalue, 2, null, 'BRACKETS');
					cellvalue = '<div style = "cursor: pointer;"><font style = "color: red;" >' + cellvalue + '%</font></div>';
				}else{
					cellvalue = format_noobject00(cellvalue, 2, null, 'BRACKETS');
					cellvalue = '<div style = "cursor: pointer;">' + cellvalue + '%</div>';
				}
				
				return cellvalue;
			}			
			
			// Added below formatter by Udara
			function cellFomatterPendingPayments(cellvalue, options, rowObject) {
				var row_id=options['rowId'];
				cellvalue = format_noobject00(cellvalue, 2, null, 'BRACKETS');
				cellvalue = '<div style = "cursor: pointer;"><lable onclick="test_function('+row_id+');" >' + cellvalue + '</lable></div>';
				return cellvalue;
			}
			
			function test_function(rowid){
				var m_selected_row = jQuery('#TABLE_AVAILABILITY_DETAILS').jqGrid('getRowData', rowid);
				var m_facility_no =  m_selected_row.Facility_Number;
				pop_up_message('https://dev-adlmargin.sasianet.com:8443/ADLMARGIN/LBMARGIN/'+'dn_pending_payments_drilldown.jsp?facility='+m_facility_no);
			}
			
			
			
			function unformatData2(cellvalue, options, cellobject) {
				return cellvalue;
			}			
			
			function jq_grid_click_event(rowid, iCol, cellcontent) {
				//alert(rowid+"--"+iCol+"---"+cellcontent);	
				
				var m_selected_row = jQuery('#TABLE_AVAILABILITY_DETAILS').jqGrid('getRowData', rowid);
				var m_facility_no =  m_selected_row.Facility_Number;
				//ROW REDURE FROM 3 7-->4 ,8-->5 ETC.
				if((iCol == 4)||(iCol == 5)){//Approved Loan Limit
					
					if ($('#DIV_DRILL_DOWN').dialog('isOpen')) {
						$('#DIV_DRILL_DOWN').dialog('close');
					}
					$('#IFRAME_DRILL_DOWN').attr('src', '');
					$('#IFRAME_DRILL_DOWN').remove();
					$('#DIV_DRILL_DOWN').html(iframe_html_string);
					$('#DIV_DRILL_DOWN').dialog('option', 'title', 'Drill Down');
					$('#IFRAME_DRILL_DOWN').attr('src', "<%= m_jsp_client_url %>"+"/dn_portfolio_market_value_drildown.jsp?chksql=portfolio_market_value&facility_no="+m_facility_no+"");
					$('#DIV_DRILL_DOWN').dialog('open');
					
				}
				
				
				if((iCol == 6)){//purchasing power
					
					var  m_url=jsp_client_url+"Client_Availability_display.jsp?chksql=availability_rpt&facility_no="+m_facility_no+"";
					window.open(m_url,'client_payment_report', 'left = 0, top = 0, toolbar = 0, location = 0, directories = 0, status = 0, menuBar = 0, scrollBars = 1, resizable = 1, width = ' + screen.availWidth + ', height = ' + screen.availWidth);
				}	
				if((iCol == 11)){//Future Loan Balance
					
					if ($('#DIV_DRILL_DOWN').dialog('isOpen')) {
						$('#DIV_DRILL_DOWN').dialog('close');
					}
					$('#IFRAME_DRILL_DOWN').attr('src', '');
					$('#IFRAME_DRILL_DOWN').remove();
					$('#DIV_DRILL_DOWN').html(iframe_html_string);
					$('#DIV_DRILL_DOWN').dialog('option', 'title', 'Drill Down');
					$('#IFRAME_DRILL_DOWN').attr('src', "<%= m_jsp_client_url %>"+"/dn_future_loan_balance_drildown.jsp?chksql=future_loan_balance_details_month&facility_no="+m_facility_no+"");
					$('#DIV_DRILL_DOWN').dialog('open');
					
				}	
			}
			
			
			function showPurchaseDrill2(transaction_date,facility_no){		
				if ($('#DIV_DRILL_DOWN_2').dialog('isOpen')) {
					$('#DIV_DRILL_DOWN_2').dialog('close');
				}
				$('#IFRAME_DRILL_DOWN_2').attr('src', '');
				$('#IFRAME_DRILL_DOWN_2').remove();
				$('#DIV_DRILL_DOWN_2').html(iframe_html_string_2);
				$('#DIV_DRILL_DOWN_2').dialog('option', 'title', 'Drill Down');
				
				$('#IFRAME_DRILL_DOWN_2').attr('src', "<%= m_jsp_client_url %>"+"/dn_parchase_drildown_2.jsp?chksql=parchase_details_settle_date&facility_no="+facility_no+"&start_date=" + transaction_date + "&end_date=" + transaction_date);
				$('#DIV_DRILL_DOWN_2').dialog('open');	
			}
			
			function showSaleDrill2(transaction_date,facility_no){	
				
				if ($('#DIV_DRILL_DOWN_2').dialog('isOpen')) {
					$('#DIV_DRILL_DOWN_2').dialog('close');
				}
				$('#IFRAME_DRILL_DOWN_2').attr('src', '');
				$('#IFRAME_DRILL_DOWN_2').remove();
				$('#DIV_DRILL_DOWN_2').html(iframe_html_string_2);
				$('#DIV_DRILL_DOWN_2').dialog('option', 'title', 'Drill Down');
				
				$('#IFRAME_DRILL_DOWN_2').attr('src', "<%= m_jsp_client_url %>"+"/dn_sale_drildown_2.jsp?chksql=sale_details_settle_date&facility_no="+facility_no+"&start_date=" + transaction_date + "&end_date=" + transaction_date);
				$('#DIV_DRILL_DOWN_2').dialog('open');	
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
				myObject_value[1]=aForm.txt_client_code.value;;//aForm.oLastName2.value;
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
			
			function fnCancel(){
				document.getElementById("DIV_AVAILABILITY_DETAILS").innerHTML ="<table id = 'TABLE_AVAILABILITY_DETAILS'></table> <div id = 'DIV_PAGER_AVAILABILITY_DETAILS'></div>";
				document.getElementById("TXT_CLIENT_MANAGER").value="";
				document.getElementById("TXT_CLIENT_MANAGER_NAME").value="";
				
				document.getElementById("txt_client_code").value="";
				document.getElementById("txt_client_full_name").value="";
				
				document.getElementById("txt_facility_number").value="";
				document.getElementById("txt_facility_number_name").value="";
				
				document.getElementById("txt_broker_code").value="";
				document.getElementById("txt_broker_full_name").value="";
			}
			
			
			function close_portP_help(){
				
			}
		</script>
		
	</head>
	
	<body class="body & txt-body">
		<form name="Form1" id="Form1" >
			<div>
				<table class="table" align="center" border="0" cellpadding="0" cellspacing="0" width="99%">
					<tr>
						<td height="7"></td>
					</tr>
					
					<tr height="30">
						<td width="13px" style="background-image: url('<%= m_jsp_client_url %>/images/l1.gif'); background-repeat: no repeat;" id="hi1"></td>
						<td style="background-image: url('<%= m_jsp_client_url %>/images/l3.gif'); background-repeat: repeat;" id="hi2" align="left"><b>Administration - Settlement Management</b></td>
						<td width="13px" style="background-image: url('<%= m_jsp_client_url %>/images/l2.gif'); background-repeat: no repeat;"  id="hi3"></td>
					</tr>
				</table>
				
				
			</div>	
			
			<div>		
				
				<table class="table" border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td height="1"></td>
					</tr>
				</table>
				
			</div>	
			
			<div>
				<table width="100%" bgcolor="darkblue">
					<tr>
						<td width="6%">
							<input class="mainbut" type="button" name="calcel_but" value="Cancel" onclick="fnCancel();" />
						</td>
						<td width="6%">
							<input class="mainbut" type="button" name="Exit_but" value="Exit" onclick="top.frames[1].location.href='low.jsp';" />
						</td>
						<td width="6%">
							<!-- <input class="mainbut" type="button" name="report_but" value="Enquiry" onclick="obtain_report_before();" />-->
						</td>
						<TD WIDTH="*%"> &nbsp; </TD>
						<td width="50%" class="hh1" align="right"><b>Margin Trading Status Report</b></td><!--Availability -->
					</tr>
				</table>
			</div>
			<DIV>	
				<table width="100%">
					<tr height="25px;"></tr>
				</table>
				<hr />
				
				<table width="100%">
					<tr height="25px;"></tr>
				</table>
				<br /> 
			</DIV>	
			
			
			
			
			<table border = "0" cellpadding="1" cellspacing="0">
				
				
				<tr> 
					
					<td style = "width: 200px;"><div id = "DIV_TXT_CLIENT_MANAGER">Client Manager Code</div></td>
					<td><input class = "txt_input" type = "text" id = "TXT_CLIENT_MANAGER" name = "TXT_CLIENT_MANAGER" maxlength = "15" style = "width: 125px;" ONBLUR="client_manager_code_help(0);" />
					</td>
					<td style = "width: 60px;">
						<input class = "but_input" type = "button" id = "BUT_HELP_CLIENT_MANAGER_MAIN" name = "BUT_HELP_CLIENT_MANAGER_MAIN" value = "..." onclick="client_manager_code_help(0);" />
						<td style = "width: 120px;">
							<input class = "but_input" type = "button" id = "BUT_VIEW_ALL" name = "BUT_VIEW_ALL" value = "View All" style = "width: 80px;" onclick="fn_view();"/>
						</td>
						<td style = "width: 200px;"><div id = "DIV_TXT_CLIENT_MANAGER_NAME">Client Manager Name</div></td>
						<td>
							<input class = "txt_input" type = "text" id = "TXT_CLIENT_MANAGER_NAME" name = "TXT_CLIENT_MANAGER_NAME" style = "width: 250px;" disabled = "disabled" />
						</td>
					</tr>
					
					
					<tr>
						<td style = "width: 200px;"><div id = "div_txt_client_code">Client Code</div></td>
						<td><input class = "txt_input" type = "text" id = "txt_client_code" name = "txt_client_code" maxlength = "250" style = "width: 125px;" ONBLUR="client_code_help(0);"/></td>
						<td style = "width: 60px;"><input class = "but_input" type = "button" id = "but_help_client_code_main" name = "but_help_client_code_main" value = "..."  onclick="client_code_help(0);"/>
						</td>
						<td style = "width: 120px;"></td>
						<td style = "width: 200px;"><div id = "div_txt_client_full_name">Client Full Name</div></td>
						<td><input class = "txt_input" type = "text" id = "txt_client_full_name" name = "txt_client_full_name" style = "width: 250px;" disabled = "disabled" /></td>
					</tr>
					
					<tr>
						<td style = "width: 200px;"><div id = "div_txt_facility_number">Facility Number</div></td>
						<td><input class = "txt_input" type = "text" id = "txt_facility_number" name = "txt_facility_number" maxlength = "15" style = "width: 125px;"  ONBLUR="facility_number_help(0);" />
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
							<td><input class = "txt_input" type = "text" id = "txt_broker_code" name = "txt_broker_code" maxlength = "15" style = "width: 125px;" ONBLUR="broker_code_help(0);" />
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
						
						<div id = "DIV_AVAILABILITY_DETAILS">
							<table id = "TABLE_AVAILABILITY_DETAILS"></table>
							<div id = "DIV_PAGER_AVAILABILITY_DETAILS"></div>
						</div>
						<div id ="DIV_MSG_WINDOW" title ="Pending Payments">
							<iframe id ="IFRAME_MSG_WINDOW" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Day End Routine">
							</iframe>
						</div>   				
						<div id = "DIV_DRILL_DOWN" title = "">
							<iframe id = "IFRAME_DRILL_DOWN" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Invoice Drill Down">
							</iframe>
						</div>
						<div id = "DIV_DRILL_DOWN_2" title = "">
							<iframe id = "IFRAME_DRILL_DOWN_2" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Invoice Drill Down">
							</iframe>
						</div>				
						
					</form>		
					
				</body>		
			</html>
			
