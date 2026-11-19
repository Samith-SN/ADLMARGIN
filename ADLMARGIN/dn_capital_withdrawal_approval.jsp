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
			
			 $(document).ready(function() {
               //init_fancybox();
               //initDrillDownDialog()
               m_grid_height = ($(window).height() - 310);
               //bind_events();
           });
			
		$(document).ready(function() {
		
			 initCal('TXT_START_DATE');
             initCal('TXT_END_DATE');	
				
			 initmsgDrillDialog(600,700); // added by udara on 13-01-2012
				
			// loadGridPaymentsPrint();
			
			 });
			
			
		// added by udara on 13-01-2012
		function pop_up_message(withdraw_no,facility_no){

			m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"report_portf_charges_save?chksql=with_temp&port="+facility_no+"&reci_no="+withdraw_no;
						if ($("#DIV_MSG_WINDOW").dialog("isOpen")) 
						{
		            		$("#DIV_MSG_WINDOW").dialog("close");
		            	}
		            	$("#DIV_MSG_WINDOW").dialog("option", "title", "Capital Withdrawal Approval");
		            	$("#DIV_MSG_WINDOW").dialog("open");
		            	$("#IFRAME_MSG_WINDOW").attr("src",m_url);
		            	return false;	
			
			
			
		}
	
			
			function initmsgDrillDialog(h,w)
	        {
				
	             $("#DIV_MSG_WINDOW").dialog(
				
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
			
			
		// end by udara on 13-01-2012
			
			
			
			 function loadGridPaymentsPrint() {
             
			 jQuery('#TABLE_CLIENT_PAYMENT_DELETE').GridUnload();
               m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Client_Withdrawal_Approval?chksql=withdrawal_approval&mode="+document.getElementById("TXT_WITHDRAWAL_TYPE").value+"&start_date="+document.getElementById("TXT_START_DATE_DD").value+"-"+document.getElementById("TXT_START_DATE_MM").value+"-"+document.getElementById("TXT_START_DATE_YY").value+"&end_date="+document.getElementById("TXT_END_DATE_DD").value+"-"+document.getElementById("TXT_END_DATE_MM").value+"-"+document.getElementById("TXT_END_DATE_YY").value+"&withdrawal_no="+document.getElementById("TXT_WITHDRAWAL_NUMBER").value;
				  jQuery('#TABLE_CLIENT_PAYMENT_DELETE').jqGrid({
                   url: m_url,
                 //  loadonce: 1,
                   datatype: 'json',
                   colNames: ['Withdrawal No','Client Manager','Facility Number','Client Name' ,'Withdrawal Amount','Value Date','Transation Date','Company Bank Account','Payee Bank', 'Cheque No','Save','Reject','Comments','Description'],
                   colModel: [
						{name: 'Withdrawal_No',             index: 'Withdrawal_No',   		jsonmap: 'Withdrawal_No',         sortable: false, align: 'center', width: 90, resizable: false,    unformat: unformatData ,formatter:cellFomatterWithdrawalNo},//formatter: cellFomatterWithdrawalsColumn_1,
						{name: 'Client_Manager',         index: 'Client_Manager',   	jsonmap: 'Client_Manager', 	    sortable: false, align: 'center', width: 90, resizable: false,   unformat: unformatData},//formatter: cellFomatterWithdrawalsColumn_1,
						{name: 'Fasility_Number',        index: 'Fasility_Number',  	jsonmap: 'Fasility_Number', 	sortable: false, align: 'center' , width: 90, resizable: false,  unformat: unformatData, formatter:cellFomatterFacilityNo },
						{name: 'Client_Name',            index: 'Client_Name',      	jsonmap: 'Client_Name', 		sortable: false, align: 'left', width: 80, resizable: true,   unformat: unformatData},//formatter: cellFomatterWithdrawalsColumn_2,
						//{name: 'Beneficiary',          index: 'Beneficiary',      	jsonmap: 'Beneficiary', 		sortable: false, align: 'center',  width: 70, resizable: false,   unformat: unformatData},//formatter: cellFomatterWithdrawalsColumn_5,
						{name: 'Withdrawal_Amount',         index: 'Withdrawal_Amount', jsonmap: 'Withdrawal_Amount',  	        sortable: false, align: 'right',  width: 100, resizable: false },//formatter: cellFomatterWithdrawalsColumn_6_0,
						{name: 'Value_Date',             index: 'Value_Date',       	jsonmap: 'Value_Date',  		sortable: false, align: 'center',  width: 80, resizable: false,   unformat: unformatData },//formatter: cellFomatterWithdrawalsColumn_6,
						{name: 'Tran_Date',              index: 'Tran_Date',       		jsonmap: 'Tran_Date',    		sortable: false, align: 'center',  width: 80, resizable: false,   unformat: unformatData },//formatter: cellFomatterWithdrawalsColumn_6,
						//{name: 'Mode',                 index: 'Mode',             	jsonmap: 'Mode',  			    sortable: false, align: 'center', width: 80,  resizable: false,  unformat: unformatData },//formatter: cellFomatterWithdrawalsColumn_7, 
						{name: 'Company_Bank_Account',   index: 'Company_Bank_Account', jsonmap: 'Company_Bank_Account', sortable: false, align: 'center', width: 140, resizable: false,  unformat: unformatData },//formatter: cellFomatterWithdrawalsColumn_8,
						{name: 'Payee_Bank',             index: 'Payee_Bank',          jsonmap: 'Payee_Bank', 		     sortable: false, align: 'center', width: 80, resizable: false,   unformat: unformatData},
					    {name: 'Cheque_No',              index: 'Cheque_No',            jsonmap: 'Cheque_No', 		     sortable: false, align: 'center', width: 80, resizable: false,   unformat: unformatData},
						{name: 'Save',                   index: 'Save',           	    jsonmap: 'Save', 			     sortable: false, align: 'center', width: 50, resizable: false,   unformat: unformatData,  formatter:checkBoxFmatterPaySave},
						{name: 'Reject',                 index: 'Reject',           	jsonmap: 'Reject', 			     sortable: false, align: 'center', width: 50, resizable: false,   unformat: unformatData,  formatter:checkBoxFmatterPayReject},
						{name: 'Comments',               index: 'Comments',            	jsonmap: 'Comments', 			 sortable: false, align: 'center', width: 100,  resizable: false,  unformat: unformatData,   formatter:cellFomatterPayComment},//formatter: cellFomatterWithdrawalsColumn_9,
						{name: 'Description',        	 index: 'Description',  		jsonmap: 'Description', 	     sortable: false, align: 'center' , width: 90, resizable: true,  unformat: unformatData} // added by udara on 12-01-2012
					],
							
                   mtype: 'GET',
                   rownumbers: true,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
                   toolbar: [false, 'top'],
                   caption: 'Client Withdrawals',
				   jsonReader: {repeatitems: false},
                   gridComplete: function() {
						 
                           $('#jqgh_ACTUAL_WITHDRAWAL_COLUMN_1').css('cursor', 'default');
                           $('#jqgh_ACTUAL_WITHDRAWAL_COLUMN_2').css('cursor', 'default');
                           $('#jqgh_ACTUAL_WITHDRAWAL_COLUMN_5').css('cursor', 'default');
                           $('#jqgh_ACTUAL_WITHDRAWAL_COLUMN_6_0').css('cursor', 'default');
                           $('#jqgh_ACTUAL_WITHDRAWAL_COLUMN_6').css('cursor', 'default');
                           $('#jqgh_ACTUAL_WITHDRAWAL_COLUMN_7').css('cursor', 'default');
                           $('#jqgh_ACTUAL_WITHDRAWAL_COLUMN_8').css('cursor', 'default');
                           $('#jqgh_ACTUAL_WITHDRAWAL_COLUMN_9').css('cursor', 'default');
                           $('#jqgh_ACTUAL_WITHDRAWAL_COLUMN_9_1').css('cursor', 'default');
                           $('#jqgh_ACTUAL_WITHDRAWAL_COLUMN_10').css('cursor', 'default');
                           $('#jqgh_ACTUAL_WITHDRAWAL_COLUMN_11').css('cursor', 'default');
                          
                          
                        
                        
                         //  $('#DIV_NET_AVAILABILITY').text(format_noobject0($('#HID_FINAL_AVAILABILITY').val(), 2, null, 'BRACKETS'));
                           //init_fancybox();
                           //initCal('TXT_VALUE_DATE_' + '1');
                          /* if ((document.Form1.hid_payments_count_new.value == '0') && (m_onload_add_payment_flag == false)) {
                              // addWithdrawalItem();
                              // m_onload_add_payment_flag = true;
							}*/
                           //get_exchange_rate();
						
						
					},
					loadComplete : function(){
                        var rec_count=$("#TABLE_CLIENT_PAYMENT_DELETE").jqGrid('getGridParam',"records");
                        document.Form1.hid_count.value=rec_count;
					}
               });
           }
		  function cellFomatterPayBeneficiary (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='m_broker_code_"+row_id+"' name='m_broker_code_"+row_id+"' value='"+cellvalue+"'  /></span>";
                     return texts;
                     } 
			
			// commented by udara on 13-01-2012
			/*
			 function cellFomatterWithdrawalNo (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='WITHDRAWALNO"+row_id+"' name='WITHDRAWALNO"+row_id+"' value='"+cellvalue+"'  /></span>";
                     return texts;
                     }
			*/
			
			// added by udara on 13-01-2012
			function cellFomatterWithdrawalNo(cellvalue, options, rowObject){
              var rowid=options['rowId'];
              var link = "<div id='div_withdraw_no' onclick='load_details("+rowid+");' style='cursor: pointer;'  >"+cellvalue+"</div><input type='hidden' align='right' style ='text-align: right;'  id='WITHDRAWALNO"+rowid+"' name='WITHDRAWALNO"+rowid+"' value='"+cellvalue+"' />";
				return link;
		    }
			
			function cellFomatterFacilityNo(cellvalue, options, rowObject){
				var row_id=options['rowId'];
                var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='FACILITY_NO_D"+row_id+"' name='FACILITY_NO_D"+row_id+"' value='"+cellvalue+"'  /></span>";
                return texts;
			}
			
			
			
			function load_details(row_id){
				var withdrawal_no = document.getElementById('WITHDRAWALNO'+row_id).value;
				var facility_no   = document.getElementById('FACILITY_NO_D'+row_id).value;
				//alert(withdrawal_no+'   '+facility_no);
				pop_up_message(withdrawal_no,facility_no);
			}
			
			// end by udara on 13-01-2012
			
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
			

	      function checkBoxFmatterPaySave(cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='checkbox' id='save_status_"+rowid+"'  name='save_status_"+rowid+"' value='on'  onclick =chk_with_save('"+rowid+"');   />"; 
              return link;
		  }
		 function checkBoxFmatterPayReject (cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='checkbox' id='reject_status_"+rowid+"'  name='reject_status_"+rowid+"' value='on'  onclick =chk_with_rej('"+rowid+"');    />"; 
              return link;
		  }	
	
			
		function chk_with_save(row_num){
			
		var m_ref_no = jQuery("#TABLE_CLIENT_PAYMENT_DELETE").jqGrid ("getCell", row_num, 1);
		    //document.Form1.elements["cancel_status_"+row_num].checked=false;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Client_Withdrawal_Approval?chksql=withdrawal_approval_check&vou_no="+m_ref_no
			
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
			
			if(m_size>0){
			  	
				if(data_vec[0]==0){
				document.Form1.elements["save_status_"+row_num].checked  =false;	
				alert('Transation Date must be lower than EOD');
				
				}else{
				//document.Form1.elements["cancel_status_"+row_num].Selected =true;	
				}
				
			
			}
			
			validateSave(row_num);
		}
			
		function chk_with_rej(row_num){
			
		var m_ref_no = jQuery("#TABLE_CLIENT_PAYMENT_DELETE").jqGrid ("getCell", row_num, 1);
		    //document.Form1.elements["cancel_status_"+row_num].checked=false;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Client_Withdrawal_Approval?chksql=withdrawal_approval_check&vou_no="+m_ref_no
			
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
			
			if(m_size>0){
			  	
				if(data_vec[0]==0){
				//document.Form1.elements["reject_status_"+row_num].checked  =false;	
				//alert('Transation Date must be lower than EOD');
				
				}else{
				//document.Form1.elements["cancel_status_"+row_num].Selected =true;	
				}
				
			
			}
			
			validateRej(row_num);
		}	
			
		function validateRej(val){
			var str_signature_object_name='save_status_'+val;
			document.forms[0].elements[str_signature_object_name].checked = false;
			}
	    function validateSave(val){
			var str_signature_object_name='reject_status_'+val;
			document.forms[0].elements[str_signature_object_name].checked = false;
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
			
        
			
			
		function fnCancel(){
			document.getElementById("DIV_PAYMENT_PRINT").innerHTML ="<table id = 'TABLE_CLIENT_PAYMENT_DELETE'></table><div id = 'DIV_PAGER_TABLE_CLIENT_PAYMENT_DELETE'></div>";
            loadGridPaymentsAppove();
			}
			
		function fnSave(){
			            document.Form1.Hid_scr_name.value="withdrawal_approval";
						document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_capital_withdrawal_approval";
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
			
	function help_withdrawal_number(m_strat)
			{
     var aForm;    //  aForm =oForm.elements;
     aForm =  document.getElementById('Form1');
	 /*  var myObject = new Object();
   	 myObject.firstName = aForm.oFirstName.value;
   	 myObject.lastName = aForm.oLastName.value;
		*/
	
 	var myObject=new Array(); //return values set to this object
 	myObject[0]=aForm.TXT_WITHDRAWAL_NUMBER;
	myObject[1]=null;
	myObject[2]=null;			

 
  
 	var myObject_value=new Array(); //passing values set to this object
 	myObject_value[0]=aForm.TXT_WITHDRAWAL_NUMBER.value;
  

 
 
 	var myObject_type=new Array(); //passing values data type
 	myObject_type[0]="StringL";

 
 	var qid='51';
	var hid='0';			
    title_name='Help';
 	var url = 'popup.jsp';
	var close_fun='close_help_withdrawal_number';			
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
		 width: 900,//900,
		 title: 'SasiNet Frame Work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
			}
			
			function close_help_withdrawal_number(){
			
			
			}
			
			
		</script>
 	
 </head>
    
    <body class="body & txt-body">
        <form name="Form1" id="Form1" >
			 <input type = "hidden" id = "Hid_scr_name" name = "Hid_scr_name" Value="withdrawal_approval" />
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

                    <td width="50%" class="hh1" align="right"><b>Capital Withdrawal Approval</b></td>
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
                                                               <div>Withdrawal Number</div>
                                                           </td>
                                                           <td style = "width: 175px;">
                                                               <input class = "txt_input" type = "text" id = "TXT_WITHDRAWAL_NUMBER" name = "TXT_WITHDRAWAL_NUMBER" value = "" style = "width: 150px;"  />
                                                           </td>
                                                           <td style = "width: 125px">
                                                            <input class = "but_input" type = "button" id = "BUT_HELP_PAYMENT_NUMBER" name = "BUT_HELP_PAYMENT_NUMBER" value = "..." onclick="help_withdrawal_number(0);"/>

                                                           </td>
                                                           <td style = "width: 100px;">Withdrawal Mode
                                                            </td>
                                                           <td style = "width: 150px;">
                                                             <select class = "txt_input" id = "TXT_WITHDRAWAL_TYPE" name = "TXT_WITHDRAWAL_TYPE" style = "width: 125px;">
                                                                   <option value = "W">Withdrawal</option>
                                                                  
                                                               </select>
                                                          

                                                           </td>
                                                           <td style = "width: 125px">
                                                            
                                                           </td>
                                                           <td style = "width: 75px;">
                                                            
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
                                                           <td style = "width: 125px">
                                                             <!--  <div id = "DIV_TXT_LETTER_REFERENCE_NUMBER">Letter Ref. Number</div>-->
                                                           <input class = "but_input" type = "button" name = "BUT_SEARCH" id = "BUT_SEARCH" value = "Search" style = "width: 100px;" onclick="loadGridPaymentsPrint();"/>
                          
                                                           </td>
                                                           <td style = "width: 75px;">
                                                            <!--     <input class = "txt_input" type = "text" id = "TXT_LETTER_REFERENCE_NUMBER" name = "TXT_LETTER_REFERENCE_NUMBER" style = "width: 100px;" maxlength = "50" onblur = "strTrim(this);" disabled = "disabled" />-->
                                                           </td>
                                                       </tr>
                                                   </table>
				
				
			</DIV>	
				
						
			
				
				
			<BR>	
				
	  <div id = "DIV_PAYMENT_PRINT">
                     <table id = "TABLE_CLIENT_PAYMENT_DELETE"></table>
                      <div id = "DIV_PAGER_TABLE_CLIENT_PAYMENT_DELETE"></div>

       </div>
							
		<!-- Added by Udara on 13-01-2012  -->
		<div id ="DIV_MSG_WINDOW" title ="Generate Confirmation">
	    <iframe id ="IFRAME_MSG_WINDOW" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Day End Routine">
	    </iframe>
	    </div>
		<!-- End by Udara on 13-01-2012  -->					
							
						
						
        </form>		
	<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
	<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>		
 </body>		
</html>
	
