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
	
	String m_facility_no = request.getParameter("facility_no");
	String m_chksql      = request.getParameter("chksql");
	String m_start_date  = request.getParameter("start_date");
	String m_end_date    = request.getParameter("end_date");
	
	
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
			 loadGridSales() ;			
           });
			
		$(document).ready(function() {
		
			loadGridSales();
			
			 });
		
		function fn_veiwall(){
			fnCancel();
			loadGridSales();
		}	
			
			 function loadGridSales() {
            
		   var m_start_date  = '<%=m_start_date%>';
		   var m_end_date    = '<%=m_end_date%>';
		   var m_facility_no = '<%=m_facility_no%>';
		   var m_chksql        = '<%=m_chksql%>';	
					
               m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"sale_drill_details?chksql="+m_chksql+"&facility_no="+m_facility_no+"&start_date="+m_start_date+"&end_date="+m_end_date+"";
					
					
					jQuery('#TABLE_CLIENT_SALES').GridUnload();
					jQuery('#TABLE_CLIENT_SALES').jqGrid({
                    url: m_url,
                   //loadonce: 1,
                   datatype: 'json',
                   colNames: ['Transaction Date','Settlement Amount','Settlement_Date'],
                   colModel: [
						{name: 'Transaction_Date',         index: 'Transaction_Date',   jsonmap: 'Transaction_Date',       sortable: false, align: 'center', width: 100, resizable: false,    unformat: unformatData },//formatter: cellFomatterPaymentsColumn_1,
						{name: 'Settlement_Amount',        index: 'Settlement_Amount',   jsonmap: 'Settlement_Amount', 	   sortable: false, align: 'right', width: 100, resizable: false,   unformat: unformatData},//formatter: cellFomatterPaymentsColumn_1,
						{name: 'Settlement_Date',          index: 'Settlement_Date',  	jsonmap: 'Settlement_Date', 	   sortable: false, align: 'center' , width: 100, resizable: false,  unformat: unformatData},
					     ],
                   mtype: 'GET',
                   rownumbers: true,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
                   toolbar: [false, 'top'],
                   caption: 'Sales',
				   jsonReader: {repeatitems: false},
				   footerrow: true,
				   userDataOnFooter: true,
				   onCellSelect: jq_grid_click_event_sale,			
                   gridComplete: function() {
						 
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_1').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_2').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_5').css('cursor', 'default');
                          
                          
                          
                        
                        
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
                        var rec_count=$("#TABLE_CLIENT_SALES").jqGrid('getGridParam',"records");
                        document.Form1.hid_count.value=rec_count;
					}
               });
           }
			 function jq_grid_click_event_sale(rowid, iCol, cellcontent) {
			
				var m_selected_row     = jQuery('#TABLE_CLIENT_SALES').jqGrid('getRowData', rowid);
				var transaction_date = m_selected_row.Transaction_Date;
				var settlement_date  = m_selected_row.Settlement_Date;
				
				if(iCol==2){
					parent.showSaleDrill2(transaction_date);
								
				}
				
				
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
	          var link ="<input type='checkbox' id='save_status_"+rowid+"'  name='save_status_"+rowid+"' value='Y'  onclick =guaran('"+rowid+"');check_amount('"+rowid+"');    onchange=guaran('"+rowid+"');check_amount('"+rowid+"')  />"; 
              return link;
		  }
			function checkBoxFmatterPaySignature (cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='checkbox' id='signature_"+rowid+"'  name='signature_"+rowid+"' value='on'  onclick =validateSig('"+rowid+"');     />"; 
              return link;
		  }
			function checkBoxFmatterPayReject (cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='checkbox' id='reject_"+rowid+"'  name='reject_"+rowid+"' value='on'  onclick =validateRej('"+rowid+"');    />"; 
              return link;
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
			var str_signature_object_name='signature_'+val;
			document.forms[0].elements[str_signature_object_name].checked = false;
			}
	    function validateSig(val){
			var str_signature_object_name='reject_'+val;
			document.forms[0].elements[str_signature_object_name].checked = false;
			}	
			
			
		function fnCancel(){
			document.getElementById("DIV_PAYMENT_SIGNATURE").innerHTML ="<table id = 'TABLE_CLIENT_SALES'></table><div id = 'DIV_PAGER_TABLE_CLIENT_SALES'></div>";
          document.getElementById("txt_client_code").value="";
		  document.getElementById("TXT_CLIENT_MANAGER").value="";
		  document.getElementById("txt_facility_number").value="";
		  document.getElementById("txt_broker_code").value="";
		
		  document.getElementById("txt_facility_number_name").value="";
		  document.getElementById("TXT_CLIENT_MANAGER_NAME").value="";
		  document.getElementById("txt_facility_number").value="";
		  document.getElementById("txt_broker_full_name").value=""; 
		  loadGridSales();
			}
			
		function fnSave(){
			            document.Form1.Hid_scr_name.value="payment_first_sig";
						document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_payments_first_signature";
						document.Form1.submit();
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
		</script>
 	
 </head>
    
    <body class="body & txt-body">
        <form name="Form1" id="Form1" >
			 <input type = "hidden" id = "Hid_scr_name" name = "Hid_scr_name" Value="payment_first_sig" />
			 <input type = "hidden" id = "hid_count" name = "hid_count" />
		     
		
				
            <table width="100%">
                <tr height="25px;"></tr>
            </table>
             <br /> 
		    </DIV>	
				
			<!--	
			<table border = "0">
				
					
					<tr>
                          <td style = "width: 200px;"><div id = "DIV_TXT_CLIENT_MANAGER">Client Manager Code</div></td>
						       <td><input class = "txt_input" type = "text" id = "TXT_CLIENT_MANAGER" name = "TXT_CLIENT_MANAGER" maxlength = "15" style = "width: 125px;" />
                                  </td>
                                      <td style = "width: 60px;">
                                         <input class = "but_input" type = "button" id = "BUT_HELP_CLIENT_MANAGER_MAIN" name = "BUT_HELP_CLIENT_MANAGER_MAIN" value = "..." onclick="client_manager_code_help(0);" />
                                             <td style = "width: 120px;">
                                           
                                        </td>
                                    <td style = "width: 200px;"><div id = "DIV_TXT_CLIENT_MANAGER_NAME">Client Manager Name</div></td>
                                <td>
                             <input class = "txt_input" type = "text" id = "TXT_CLIENT_MANAGER_NAME" name = "TXT_CLIENT_MANAGER_NAME" style = "width: 250px;" disabled = "disabled" />
                          </td>
                      </tr>
					
					
					<tr>
                         <td style = "width: 200px;"><div id = "div_txt_client_code">Client Code</div></td>
                              <td><input class = "txt_input" type = "text" id = "txt_client_code" name = "txt_client_code" maxlength = "250" style = "width: 125px;" /></td>
                                  <td style = "width: 60px;"><input class = "but_input" type = "button" id = "but_help_client_code_main" name = "but_help_client_code_main" value = "..."  onclick="client_code_help(0)"/>
                                       </td>
                                       <td style = "width: 120px;"></td>
                               <td style = "width: 200px;"><div id = "div_txt_client_full_name">client full name</div></td>
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
							
			-->
				
			<table border = "0">
				
					
					<tr>
                          <td style = "width: 200px;"><div id = "DIV_TXT_FACILITY_NO">Facility No :</div></td>
						       <td><div id="DIV_FACILITY_NO" ><%=m_facility_no%></div>
                                  </td>
                                      <td style = "width: 260px;"> </td>
                                         <td style = "width: 120px;">
                                      </td>
                                    <td style = "width: 100px;"></td>
                                <td>
                             
                          </td>
                      </tr>
					
					
					<tr>
                         <td style = "width: 200px;"><div id = "DIV_TXT_CLIENT_CODE_LB">Period : </div></td>
                              <td> <div id = "DIV_CLIENT_CODE">from <%=m_start_date%> to <%=m_end_date%> </div></td>
                                  <td style = "width: 260px;">
                                       </td>
                                    <td style = "width: 120px;"></td>
                               <td style = "width: 100px;"></div></td>
                           <td></td>
                     </tr>
					  
				                              
                                                 
               </table>	
					
			<BR>	
				
	  <div id = "DIV_PAYMENT_SIGNATURE">
                     <table id = "TABLE_CLIENT_SALES"></table>
                      <div id = "DIV_PAGER_TABLE_CLIENT_SALES"></div>

       </div>
						
						
        </form>		
			
 </body>		
</html>
	