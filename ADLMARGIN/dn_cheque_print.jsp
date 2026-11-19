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
		
				var iframe_html_string_1 = '<iframe id = "IFRAME_DRILL_DOWN_1" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Drill Down"></iframe>';	
			 $(document).ready(function() {
               //init_fancybox();
              initDrillDownDialog();
               m_grid_height = ($(window).height() - 310);
               //bind_events();
           });
			
		$(document).ready(function() {
		
			 initCal('TXT_START_DATE');
             initCal('TXT_END_DATE');	
			// loadGridPaymentsPrint();
			
			 });
			
			
			 function loadGridPaymentsPrint() {
              
			   jQuery('#TABLE_CLIENT_PAYMENT_PRINT').GridUnload();
            // m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_reports_payments_new?mdate_from="+document.getElementById("TXT_START_DATE_DD").value+'-'+document.getElementById("TXT_START_DATE_MM").value+'-'+document.getElementById("TXT_START_DATE_YY").value+"&mdate_to="+document.getElementById("TXT_END_DATE_DD").value+'-'+document.getElementById("TXT_END_DATE_MM").value+'-'+document.getElementById("TXT_END_DATE_YY").value+"&client="+sclient.toUpperCase()+"&chksql=mrep_data";  
		       m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"BrokerBulkPaymentsChequePrint?chksql=bulk_payment_print&mode="+document.getElementById("TXT_PRINT_TYPE").value+"&start_date="+document.getElementById("TXT_START_DATE_DD").value+"-"+document.getElementById("TXT_START_DATE_MM").value+"-"+document.getElementById("TXT_START_DATE_YY").value+"&end_date="+document.getElementById("TXT_END_DATE_DD").value+"-"+document.getElementById("TXT_END_DATE_MM").value+"-"+document.getElementById("TXT_END_DATE_YY").value+"&bank="+document.getElementById("TXT_COMPANY_BRANCH_CODE").value+"&com_account="+document.getElementById("TXT_COMPANY_ACCOUNT_NO").value
				  jQuery('#TABLE_CLIENT_PAYMENT_PRINT').jqGrid({
                   url: m_url,
                 //  loadonce: 1,
                   datatype: 'json',
                   colNames: ['Payment No','Client Manager','Fasility Number','Client Name' ,'Beneficiary','Payment Amount','Value Date','Transation Date','Mode', 'Company Bank Account', '1st Signature','2nd Signature','Settlement Mode','Cheque No','Save','Print','Comments',],
                   colModel: [
						{name: 'Payment_No',             index: 'Payment_No',   		jsonmap: 'Payment_No',         sortable: false, align: 'center', width: 90, resizable: false,    unformat: unformatData ,formatter:cellFomatterPaymentNo},//formatter: cellFomatterPaymentsColumn_1,
						{name: 'Client_Manager',         index: 'Client_Manager',   	jsonmap: 'Client_Manager', 	    sortable: false, align: 'center', width: 90, resizable: false,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_1,
						{name: 'Fasility_Number',        index: 'Fasility_Number',  	jsonmap: 'Fasility_Number', 	sortable: false, align: 'center' , width: 90, resizable: false,  unformat: unformatData},
						{name: 'Client_Name',            index: 'Client_Name',      	jsonmap: 'Client_Name', 		sortable: false, align: 'right', width: 80, resizable: true,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_2,
						{name: 'Beneficiary',            index: 'Beneficiary',      	jsonmap: 'Beneficiary', 		sortable: false, align: 'center',  width: 70, resizable: false,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_5,
						{name: 'Payment_Amount',         index: 'Payment_Amount',   	jsonmap: 'Payment_Amount',  	sortable: false, align: 'right',  width: 100, resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_6_0,
						{name: 'Value_Date',             index: 'Value_Date',       	jsonmap: 'Value_Date',  		sortable: false, align: 'right',  width: 60, resizable: false,   unformat: unformatData },//formatter: cellFomatterPaymentsColumn_6,
						{name: 'Tran_Date',              index: 'Tran_Date',       		jsonmap: 'Tran_Date',    		sortable: false, align: 'right',  width: 60, resizable: false,   unformat: unformatData },//formatter: cellFomatterPaymentsColumn_6,
						{name: 'Mode',                   index: 'Mode',             	jsonmap: 'Mode',  			    sortable: false, align: 'center', width: 80,  resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_7, 
						{name: 'Company_Bank_Account',   index: 'Company_Bank_Account', jsonmap: 'Company_Bank_Account', sortable: false, align: 'center', width: 140, resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_8,
						{name: 'First_Signature',        index: 'First_Signature',      jsonmap: 'First_Signature', 			     sortable: false, align: 'center', width: 80, resizable: false,   unformat: unformatData},
						{name: 'Second_Signature',       index: 'Second_Signature',     jsonmap: 'Second_Signature', 			     sortable: false, align: 'center', width: 80, resizable: false,   unformat: unformatData},
						{name: 'Settl_Mode',             index: 'Settl_Mode',          	jsonmap: 'Settl_Mode',  	    sortable: false, align: 'center', width: 120,  resizable: false,  unformat: unformatData },//formatter: cellFomatterPaymentsColumn_7, 
						{name: 'Cheque_No',              index: 'Cheque_No',            jsonmap: 'Cheque_No', 		     sortable: false, align: 'center', width: 80, resizable: false,   unformat: unformatData,  formatter:checkBoxFmatterChequeNo},
						{name: 'Save',                   index: 'Save',           	    jsonmap: 'Save', 			     sortable: false, align: 'center', width: 50, resizable: false,   unformat: unformatData,  formatter:checkBoxFmatterPaySave},
						{name: 'Print',                  index: 'Print',   			    jsonmap: 'Print', 			     sortable: false, align: 'center', width: 50, resizable: false,   unformat: unformatData,  formatter:checkBoxFmatterPayPrint},
						{name: 'Comments',               index: 'Comments',            	jsonmap: 'Comments', 			sortable: false, align: 'center', width: 100,  resizable: false,  unformat: unformatData,   formatter:cellFomatterPayComment}//formatter: cellFomatterPaymentsColumn_9,
					],
							
                   mtype: 'GET',
                   rownumbers: true,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
                   toolbar: [false, 'top'],
                   caption: 'Client Payments',
				   onCellSelect: jq_grid_click_event_broker_pay,				
				   jsonReader: {repeatitems: false},
                   gridComplete: function() {
						 
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
                          
                          
                        
                        
                         //  $('#DIV_NET_AVAILABILITY').text(format_noobject0($('#HID_FINAL_AVAILABILITY').val(), 2, null, 'BRACKETS'));
                           //init_fancybox();
                           //initCal('TXT_VALUE_DATE_' + '1');
                          /* if ((document.Form1.hid_payments_count_new.value == '0') && (m_onload_add_payment_flag == false)) {
                              // addPaymentItem();
                              // m_onload_add_payment_flag = true;
							}*/
                           //get_exchange_rate();
						
						
					},
					loadComplete : function(){
                        var rec_count=$("#TABLE_CLIENT_PAYMENT_PRINT").jqGrid('getGridParam',"records");
                        document.Form1.hid_count.value=rec_count;
					}
               });
           }
		  function cellFomatterPayBeneficiary (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='m_broker_code_"+row_id+"' name='m_broker_code_"+row_id+"' value='"+cellvalue+"'  /></span>";
                     return texts;
                     } 
			
			 function cellFomatterPaymentNo (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='PAYMENTNO"+row_id+"' name='PAYMENTNO"+row_id+"' value='"+cellvalue+"'  /></span>";
                     return texts;
                     } 
		  function cellFomatterPaySettDate(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='m_trndate_"+row_id+"' name='m_trndate_"+row_id+"' value='"+cellvalue+"'  /></span>";
                     return texts;
                     } 	
		function cellFomatterPayClient(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='m_client_code_"+row_id+"' name='m_client_code_"+row_id+"' value='"+cellvalue+"'  /></span>";
                     return texts;
                     } 	
		 function cellFomatterSetlAmount (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span><input type='text' align='right' style ='text-align: right;'  id='m_sett_amount_"+row_id+"' name='m_sett_amount_"+row_id+"' value='"+cellvalue+"' onchange=check_amount('"+row_id+"')  onblur=guaran('"+row_id+"');check_amount('"+row_id+"')  /><input type='hidden' name='m_amount_"+row_id+"' value='"+cellvalue+"'/></span>";
                     return texts;
                     }
	      function checkBoxFmatterPaySave (cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='checkbox' id='save_status_"+rowid+"'  name='save_status_"+rowid+"' value='on'   />"; 
              return link;
		  }
			
			
		 function checkBoxFmatterPayPrint (cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='button' id='print_"+rowid+"'  name='print_"+rowid+"' Value='Print' onclick =cheque_print('"+rowid+"');  />"; 
              return link;
		  }	
			
		function cheque_print(row_num){
			
			var m_ref_no = jQuery("#TABLE_CLIENT_PAYMENT_PRINT").jqGrid ("getCell", row_num, 1); 
		    document.Form1.elements["print_"+row_num].disabled =true;					
			//m_ref_no=document.Form1.elements["Ref_No"+line_no].value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"cheq_printing?chksql=PRINT&vou_no="+m_ref_no			
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
			if(m_size>0){
			  	
				alert(data_vec[0]);
				
			}else{
				alert('Not Printing');
				document.Form1.elements["print_"+row_num].disabled =false;	
				//getlivePrinter();
			}
		}
			
			
			function checkBoxFmatterPayReject (cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='checkbox' id='reject_"+rowid+"'  name='reject_"+rowid+"' value='on'  onclick =validateRej('"+rowid+"');    />"; 
              return link;
		  }
		 function checkBoxFmatterChequeNo(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span><input type='text' align='left' style ='text-align: left;'  id='CHEQUENO_"+row_id+"' name='CHEQUENO_"+row_id+"' value=''/></span>";
                     return texts;
          }	
		 function cellFomatterPayComment(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span><input type='text' align='left' style ='text-align: left;'  id='comment_"+row_id+"' name='comment_"+row_id+"' value=''/></span>";
                     return texts;
          }
		 function cellFomatterPayMode(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span><select name='Hid_Sett_type_"+row_id+"'  ><OPTION VALUE='CHEQUE' SELECTED>PAY ORDER</OPTION><OPTION VALUE='BANK_TRANF'>BANK_TRANF</OPTION></select></span>";
				     return texts;
          }	
			
		  function unformatData(cellvalue, options, cellobject) {
               return cellvalue;
           }
			
         function validateRej(val){
			var str_prinT_object_name='prinT_'+val;
			document.forms[0].elements[str_prinT_object_name].checked = false;
			}
	    function validateSig(val){
			var str_prinT_object_name='reject_'+val;
			document.forms[0].elements[str_prinT_object_name].checked = false;
			}	
			
			
		function fnCancel(){
			document.getElementById("DIV_PAYMENT_PRINT").innerHTML ="<table id = 'TABLE_CLIENT_PAYMENT_PRINT'></table><div id = 'DIV_PAGER_TABLE_CLIENT_PAYMENT_PRINT'></div>";
            loadGridPaymentsAppove();
			}
			
		function fnSave(){
			            document.Form1.Hid_scr_name.value="payment_cheque_print";
						document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_payments_cheque_print";
						document.Form1.submit();
			}
			
			function initCal(m_id) {
                $('#' + m_id).datepicker({
                    dateFormat: 'dd-mm-yy',
                    duration: 'fast',
                    yearRange: '1920:2050',
                    showOn: 'button',
                    buttonImage: '<%= m_jsp_client_url %>/SNET/images/calendar.gif',
                    buttonImageOnly: true,
                    changeMonth: true,
                    changeYear: true,
                    onSelect: function(dateText, inst) {
                        dateSelectFunc(dateText,inst);
                    }
                });
           }
			
			 function initDrillDownDialog(){
               $('#DIV_DRILL_DOWN_1').dialog({ 
                   bgiframe: true,
                   autoOpen: false,
                   modal: false,
                   height: 500,
                   width: getW
               });
					
			 /*      $('#DIV_DRILL_DOWN_2').dialog({
                   bgiframe: true,
                   autoOpen: false,
                   modal: false,
                   height: 500,
                   width: getW
               });	
			$('#DIV_DRILL_DOWN_3').dialog({
                   bgiframe: true,
                   autoOpen: false,
                   modal: false,
                   height: 500,
                   width: getW
               });*/
					
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
			
			function jq_grid_click_event_broker_pay(rowid, iCol, cellcontent) {
					
			
			 var m_selected_row = jQuery('#TABLE_CLIENT_PAYMENT_PRINT').jqGrid('getRowData', rowid);
			 var m_broker_code  = m_selected_row.Beneficiary;
			 var m_facility_no  = m_selected_row.Fasility_Number;
			 var m_payment_no   = m_selected_row.Payment_No;
			 var m_settl_mode   = m_selected_row.Settl_Mode;	
              if (iCol == 13) {
                
				/*var m_to_date = document.Form1.TXT_TODATE.value;
				var m_to_month = document.Form1.TXT_TOMONTH.value;
				var m_to_year = document.Form1.TXT_TOYEAR.value;
				var  m_url=jsp_client_url+"dn_broker_payment_drill_down.jsp?broker_code="+m_broker_code+"&to_date="+m_to_date+"&to_month="+m_to_month+"&to_year="+m_to_year;
						
				  window.open(m_url,'broker_payment_drill_down', 'left = 0, top = 0, toolbar = 0, location = 0, directories = 0, status = 0, menuBar = 0, scrollBars = 1, resizable = 1, width = ' + screen.availWidth + ', height = ' + screen.availWidth);
					*/
					
				if(m_settl_mode=='GROSS' || m_settl_mode=='NET' ){
                           if ($('#DIV_DRILL_DOWN_1').dialog('isOpen')) {
                               $('#DIV_DRILL_DOWN_1').dialog('close');
                           }
                           $('#IFRAME_DRILL_DOWN_1').attr('src', '');
                           $('#IFRAME_DRILL_DOWN_1').remove();
                           $('#DIV_DRILL_DOWN_1').html(iframe_html_string_1);
                           $('#DIV_DRILL_DOWN_1').dialog('option', 'title', 'Drill Down');
                           $('#IFRAME_DRILL_DOWN_1').attr('src', "<%= m_jsp_client_url %>"+"/dn_group_net_payments_drilldown.jsp?chksql=group_net_payment&payment_no="+m_payment_no+"");  
                           $('#DIV_DRILL_DOWN_1').dialog('open'); 
										
				}     			
			
			}	
									
		}
			
			 function dateSelectFunc(dateText, inst) {
               var splitResult = dateText.split('-');
               var instance_id = inst.id;
               var m_last_index_of_underscore = instance_id.lastIndexOf('_');
               var first_part = instance_id.substr(0, m_last_index_of_underscore + 1);
               var second_part = instance_id.substr(m_last_index_of_underscore + 1);
               if (instance_id == "TXT_START_DATE") {
                   document.Form1.TXT_START_DATE_DD.value = splitResult[0];
                   document.Form1.TXT_START_DATE_MM.value = splitResult[1];
                   document.Form1.TXT_START_DATE_YY.value = splitResult[2];
                   document.Form1.TXT_START_DATE_YY.focus();
               }
               else if (instance_id == "TXT_END_DATE") {
                   document.Form1.TXT_END_DATE_DD.value = splitResult[0];
                   document.Form1.TXT_END_DATE_MM.value = splitResult[1];
                   document.Form1.TXT_END_DATE_YY.value = splitResult[2];
                   document.Form1.TXT_END_DATE_YY.focus();
               }
              
           }
			
function compay_bank_account(m_strat)
			{
     var aForm;    //  aForm =oForm.elements;
     aForm =  document.getElementById('Form1');
	 /*  var myObject = new Object();
   	 myObject.firstName = aForm.oFirstName.value;
   	 myObject.lastName = aForm.oLastName.value;
		*/
	
 	var myObject=new Array(); //return values set to this object
 	myObject[0]=aForm.TXT_COMPANY_ACCOUNT_DETAILS;
	myObject[1]=aForm.TXT_COMPANY_BRANCH_CODE;
	myObject[2]=aForm.TXT_COMPANY_ACCOUNT_NO;			

 
  
 	var myObject_value=new Array(); //passing values set to this object
 	myObject_value[0]=aForm.TXT_COMPANY_ACCOUNT_DETAILS.value;
  

 
 
 	var myObject_type=new Array(); //passing values data type
 	myObject_type[0]="StringL";

 
 	var qid='41';
	var hid='2';			
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
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun+'&hid='+hid,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400,// 500,
		 width: 300,//900,
		 title: 'SasiNet Frame Work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
	}
		</script>
 	
 </head>
    
    <body class="body & txt-body">
        <form name="Form1" id="Form1" method="post" >
			 <input type = "hidden" id = "Hid_scr_name" name = "Hid_scr_name" Value="payment_cheque_print" />
			 <input type = "hidden" id = "hid_count" name = "hid_count" />
			<div>		
				<table class="table" border="0" cellpadding="0" cellspacing="0" width="100%">
					<tr>
						<td colspan="2">
							<div>
								<table class="table" align="center" border="0" cellpadding="0" cellspacing="0" width="99%">
									<tr>
										<td height="7"></td>
									</tr>
									
									<tr height="30">
										<td width="13px" style="background-image: url('<%= m_jsp_client_url %>/images/l1.gif'); background-repeat: no repeat;" id="hi1"></td>
										<td style="background-image: url('<%= m_jsp_client_url %>/images/l3.gif'); background-repeat: repeat;" id="hi2" align="left"><b>Margin Trading - Settlement Management</b></td>
										<td width="13px" style="background-image: url('<%= m_jsp_client_url %>/images/l2.gif'); background-repeat: no repeat;"  id="hi3"></td>
									</tr>
									</table>
										
									</div>	
						</td>
									</tr>
										
										<tr>
										<td >
										<div stype='width:800px'>
            <table width="100%" bgcolor="darkblue">
                <tr>
                    
                    <td width="4%">
                        <input class="mainbut" type="button" name="save_but" value="Save" onclick="fnSave();" />
                    </td>
                    <td width="4%">
                        <input class="mainbut" type="button" name="calcel_but" value="Cancel" onclick="fnCancel()" />
                    </td>
                    <td width="4%">
                        <input class="mainbut" type="button" name="Exit_but" value="Exit" onclick="top.frames[1].location.href='low.jsp'" />
                    </td>
					<TD WIDTH="*%"> &nbsp; </TD>

                    <td width="50%" class="hh1" align="right"><b>Cheque Print</b></td>
					                    <td width="4%">
                        <input class="mainbut" type="button" name="save_but" value="Save" onclick="fnSave();" />
                    </td>
                    <td width="4%">
                        <input class="mainbut" type="button" name="calcel_but" value="Cancel" onclick="fnCancel()" />
                    </td>
                    <td width="4%">
                        <input class="mainbut" type="button" name="Exit_but" value="Exit" onclick="top.frames[1].location.href='low.jsp'" />
                    </td>

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
			
			<DIV>
			
				                                                   <table class = "table">
                                                       <tr>
                                                           <td style = "width: 100px">
                                                               <div>Payment Mode</div>
                                                           </td>
                                                           <td style = "width: 175px;">
                                                               <select class = "txt_input" id = "TXT_PRINT_TYPE" name = "TXT_PRINT_TYPE" style = "width: 125px;">
                                                                   <option value = "CHEQUE">Cheques</option>
                                                                    <option value = "PAY_ORDER">Pay Order</option>
                                                                   <option value = "BANK_TRANF">Bank Transfers</option>
                                                                  <!-- <option value = "RTGS">RTGS Transfer</option>-->
                                                                   <option value = "VIEW_ALL">View All</option>
                                                               </select>
                                                           </td>
                                                           <td style = "width: 125px">
                                                               <div>Company Bank Account</div>

                                                           </td>
                                                           <td style = "width: 175px;">
                                                               <input type = "hidden" id = "TXT_COMPANY_BRANCH_CODE" name = "TXT_COMPANY_BRANCH_CODE" value = "" />
                                                               <input type = "hidden" id = "TXT_COMPANY_ACCOUNT_NO" name = "TXT_COMPANY_ACCOUNT_NO" value = "" />
                                                               <input class = "txt_input" type = "text" id = "TXT_COMPANY_ACCOUNT_DETAILS" name = "TXT_COMPANY_ACCOUNT_DETAILS" value = "" style = "width: 150px;"  disabled/>
                                                           </td>
                                                           <td style = "width: 125px;">
                                                               <input class = "but_input" type = "button" id = "BUT_HELP_COMPANY_ACCOUNT_NO" name = "BUT_HELP_COMPANY_ACCOUNT_NO" value = "..." onclick="compay_bank_account(0);"/>
                                                          

                                                           </td>
                                                           <td style = "width: 125px">
                                                               <!--  <div id = "DIV_TXT_NEXT_CHEQUE_NUMBER">Cheque Number</div>-->
                                                           </td>
                                                           <td style = "width: 75px;">
                                                               <!--  <input class = "txt_input" type = "text" id = "TXT_NEXT_CHEQUE_NUMBER" name = "TXT_NEXT_CHEQUE_NUMBER" style = "width: 75px;" maxlength = "6" />-->
                                                           </td>
                                                       </tr>

                                                       <tr>
                                                           <td>
                                                               <div class = "div_input" id = "DIV_TXT_START_DATE">Start Date</div>
                                                           </td>
                                                           <td>
                                                               <input class = "txt_input5" type = "text" name = "TXT_START_DATE_DD" id = "TXT_START_DATE_DD" maxlength = "2" size = "2" />
                                                               <input class = "txt_input5" type = "text" name = "TXT_START_DATE_MM" id = "TXT_START_DATE_MM" maxlength = "2" size = "2" />
                                                               <input class = "txt_input5" type = "text" name = "TXT_START_DATE_YY" id = "TXT_START_DATE_YY" maxlength = "4" size = "4" />

                                                               <input type = "hidden" name = "TXT_START_DATE" id = "TXT_START_DATE" />
                                                           </td>
                                                           <td>
                                                               <div class = "div_input" id = "DIV_TXT_END_DATE">End Date</div>
                                                           </td>
                                                           <td>
                                                               <input class = "txt_input5" type = "text" name = "TXT_END_DATE_DD" id = "TXT_END_DATE_DD" maxlength = "2" size = "2" />
                                                               <input class = "txt_input5" type = "text" name = "TXT_END_DATE_MM" id = "TXT_END_DATE_MM" maxlength = "2" size = "2" />

                                                               <input class = "txt_input5" type = "text" name = "TXT_END_DATE_YY" id = "TXT_END_DATE_YY" maxlength = "4" size = "4" />
                                                               <input type = "hidden" name = "TXT_END_DATE" id = "TXT_END_DATE" />
                                                           </td>
                                                           <td>
                                                               <input class = "but_input" type = "button" name = "BUT_SEARCH" id = "BUT_SEARCH" value = "Search" style = "width: 100px;" onclick="loadGridPaymentsPrint();"/>
                                                           </td>
                                                           <td style = "width: 125px">
                                                             <!--  <div id = "DIV_TXT_LETTER_REFERENCE_NUMBER">Letter Ref. Number</div>-->

                                                           </td>
                                                           <td style = "width: 75px;">
                                                            <!--     <input class = "txt_input" type = "text" id = "TXT_LETTER_REFERENCE_NUMBER" name = "TXT_LETTER_REFERENCE_NUMBER" style = "width: 100px;" maxlength = "50" onblur = "strTrim(this);" disabled = "disabled" />-->
                                                           </td>
                                                       </tr>
                                                   </table>
				
				
			</DIV>	
				
						
			
				
				
			<BR>	
				
	  <div id = "DIV_PAYMENT_PRINT">
                     <table id = "TABLE_CLIENT_PAYMENT_PRINT"></table>
                      <div id = "DIV_PAGER_TABLE_CLIENT_PAYMENT_PRINT"></div>

       </div>
		 <div id = "DIV_DRILL_DOWN_1" title = "">
               <iframe id = "IFRAME_DRILL_DOWN_1" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Invoice Drill Down">
        	  </iframe>
        </div>				
						
        </form>		
	<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
	<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>		
 </body>		
</html>
	
