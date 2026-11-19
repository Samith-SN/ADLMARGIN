<HTML>
	<HEAD>
		<TITLE>HNBB
		</TITLE>
		<%@page import="net.sasianet.lbmargin.*" %>
		<%	
		
	
			
		LBMARGIN2_MGT_conn_methods m_sn_methods = new LBMARGIN2_MGT_conn_methods(session);
		String m_jsp_client_url=m_sn_methods.jsp_client_url;
		
		
        
		//***************  ADDED BY KANISHKA ON 18/12/2012  *********************//
		
		Object done = (String)session.getValue("logon.isDone");  // marker object
		    if (done == null) {
			response.sendRedirect("login.jsp");
            return;
         }
		
		//*************** ADDED BY KANISHKA ON 18/12/2012 [END]  *********************//

	    %>
		
		
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
	<SCRIPT language="JavaScript">
	
			
		$(document).ready(function() {
		     m_grid_height = ($(window).height() - 310);
			 initCal('TXT_START_DATE');
             initCal('TXT_END_DATE');	
			// loadGridDividendIncome();
			
			});
	
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
			 
		
		
		function clearAll(){
			document.Form1.TXT_portfolio.value="";
			document.Form1.TXT_bank_code.value="";
			document.Form1.TXT_ACC_number.value="";
			
			
			document.Form1.TXT_desc.value="";
			document.Form1.TXT_sec.value="";
			document.Form1.Text_sec_name.value="";
			
			document.Form1.TXT_INST.value="";
			document.Form1.TXT_payee.value="";
			document.Form1.TXT_chqno.value="";
			
			
			
			document.Form1.TXT_amount.value="";
			document.Form1.TXT_tax.value="";
			document.Form1.TXT_netAmount.value="";
			
				document.Form1.TXT_VALUE_DATE.value="";
			document.Form1.Text_comment.value="";
		
			
			
			
			
			
		}
	 function dateSelectFunc(dateText, inst) {
               var splitResult = dateText.split('-');
               var instance_id = inst.id;
               var m_last_index_of_underscore = instance_id.lastIndexOf('_');
               var first_part = instance_id.substr(0, m_last_index_of_underscore + 1);
               var second_part = instance_id.substr(m_last_index_of_underscore + 1);
               if (instance_id == "TXT_START_DATE") {
                   document.Form2.TXT_START_DATE_DD.value = splitResult[0];
                   document.Form2.TXT_START_DATE_MM.value = splitResult[1];
                   document.Form2.TXT_START_DATE_YY.value = splitResult[2];
                   document.Form2.TXT_START_DATE_YY.focus();
               }
               else if (instance_id == "TXT_END_DATE") {
                   document.Form2.TXT_END_DATE_DD.value = splitResult[0];
                   document.Form2.TXT_END_DATE_MM.value = splitResult[1];
                   document.Form2.TXT_END_DATE_YY.value = splitResult[2];
                   document.Form2.TXT_END_DATE_YY.focus();
               }
              
    }
		
	function loadGridDividendIncome() {
			 var m_port= document.getElementById("txt_facility_number").value;//Added by prabash on 21-09-2012		
             
			  jQuery('#TABLE_DIVIDEND_DELETE').GridUnload();
               m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=dividend_deletion_grid&port="+m_port+"&start_date="+document.getElementById("TXT_START_DATE_DD").value+"-"+document.getElementById("TXT_START_DATE_MM").value+"-"+document.getElementById("TXT_START_DATE_YY").value+"&end_date="+document.getElementById("TXT_END_DATE_DD").value+"-"+document.getElementById("TXT_END_DATE_MM").value+"-"+document.getElementById("TXT_END_DATE_YY").value+"&deal_no="+document.getElementById("Text_Deal").value+"&security_code="+document.getElementById("txt_security_code").value;
				  jQuery('#TABLE_DIVIDEND_DELETE').jqGrid({
                   url: m_url,
                 //  loadonce: 1,
                   datatype: 'json',
                   colNames: ['Dividend No','Client Manager','Facility Number','Client Name' ,
						      'Security Code','DPS','Gross Amount','Value Date','Paymnet Date','Banking Date','Realization Date',
						     'Company Bank Account','Payee Bank','Payee Account', 'Cheque No','Description','Delete','Comments'],
                   colModel: [
						{name: 'Dividend_No',            index: 'Dividend_No',   	   jsonmap: 'Dividend_No',          sortable: false, align: 'center',  width: 90,   resizable: false,  unformat: unformatData, formatter:cellFomatterDealNo},
						{name: 'Client_Manager',         index: 'Client_Manager',   	jsonmap: 'Client_Manager', 	    sortable: false, align: 'center',  width: 90,   resizable: false,  unformat: unformatData },
						{name: 'Facility_Number',        index: 'Facility_Number',  	jsonmap: 'Facility_Number', 	sortable: false, align: 'center' , width: 90,   resizable: false,  unformat: unformatData },
						{name: 'Client_Name',            index: 'Client_Name',      	jsonmap: 'Client_Name', 		sortable: false, align: 'left',    width: 80,   resizable: true,   unformat: unformatData },
						{name: 'SecurityCode',            index: 'SecurityCode',      	jsonmap: 'SecurityCode', 		sortable: false, align: 'left',    width: 80,   resizable: true,   unformat: unformatData },
					//	{name: 'Beneficiary_Name',       index: 'Beneficiary_Name',     jsonmap: 'Beneficiary_Name', 	sortable: false, align: 'left',    width: 80,   resizable: true,   unformat: unformatData },
						{name: 'DPS',                    index: 'DPS',               	jsonmap: 'DPS',  	            sortable: false, align: 'right',   width: 100,  resizable: false },
						{name: 'Withdrawal_Amount',      index: 'Withdrawal_Amount', 	jsonmap: 'Withdrawal_Amount',  	sortable: false, align: 'right',   width: 100,  resizable: false },
						{name: 'Value_Date',             index: 'Value_Date',       	jsonmap: 'Value_Date',  		sortable: false, align: 'center',  width: 80,   resizable: false,  unformat: unformatData, hidden:true },
						{name: 'Tran_Date',              index: 'Tran_Date',       		jsonmap: 'Tran_Date',    		sortable: false, align: 'center',  width: 80,   resizable: false,  unformat: unformatData, hidden:false },
						{name: 'BankDate',               index: 'BankDate',       		jsonmap: 'BankDate',    		sortable: false, align: 'center',  width: 80,   resizable: false,  unformat: unformatData },
						{name: 'RealizationData',        index: 'RealizationData',      jsonmap: 'RealizationData',  	sortable: false, align: 'center',  width: 100,  resizable: false,  unformat: unformatData },
						//{name: 'Mode',                 index: 'Mode',             	jsonmap: 'Mode',  			    sortable: false, align: 'center',  width: 80,   resizable: false,  unformat: unformatData },
						{name: 'Company_Bank_Account',   index: 'Company_Bank_Account', jsonmap: 'Company_Bank_Account', sortable: false, align: 'center', width: 140,  resizable: false,  unformat: unformatData },
						{name: 'Payee_Bank',             index: 'Payee_Bank',          	jsonmap: 'Payee_Bank', 		     sortable: false, align: 'center', width: 80,   resizable: false,  unformat: unformatData },
						{name: 'Payee_Accounts_No',      index: 'Payee_Accounts_No',    jsonmap: 'Payee_Accounts_No', 	 sortable: false, align: 'left',   width: 100,  resizable: false,  unformat: unformatData },
						{name: 'Cheque_No',              index: 'Cheque_No',            jsonmap: 'Cheque_No', 		     sortable: false, align: 'left',   width: 80,   resizable: false,  unformat: unformatData },
						{name: 'Description',       	 index: 'Description',     		jsonmap: 'Description', 		 sortable: false, align: 'left',   width: 100,  resizable: true,   unformat: unformatData },
						{name: 'Delete',                 index: 'Delete',           	jsonmap: 'Delete', 			     sortable: false, align: 'center', width: 50,   resizable: false,  unformat: unformatData, formatter:checkBoxFmatterPayDelete},
						{name: 'Comments',               index: 'Comments',            	jsonmap: 'Comments', 			 sortable: false, align: 'center', width: 100,  resizable: false,  unformat: unformatData, formatter:cellFomatterPayComment}
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
						 
                         						
					},
					loadComplete : function(){
                        var rec_count=$("#TABLE_DIVIDEND_DELETE").jqGrid('getGridParam',"records");
						
                        document.Form2.hid_count.value=rec_count;
					//	alert(rec_count);
					}
               });
           }	
		
	function cellFomatterDealNo (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='DEALNO"+row_id+"' name='DEALNO"+row_id+"' value='"+cellvalue+"'  /></span>";
                     return texts;
                     } 
		
	function checkBoxFmatterPayDelete(cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='checkbox' id='delete_status_"+rowid+"'  name='delete_status_"+rowid+"' value='on'    />"; //onclick =chk_pay_delete('"+rowid+"'); 
              return link;
		  }	
	function cellFomatterPayComment(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span><input type='text' align='left' style ='text-align: left;'  id='comment_"+row_id+"' name='comment_"+row_id+"' value=''/></span>";
                     return texts;
          }
		
/*	function beforesubmit(Obj)
	{
	document.Form2.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_delete_deal";
	  if(document.Form2.Text_Deal.value!="")
		  {
					 if(confirm("Do you want to delete this?"))
						  {
					      if(confirm("Are you sure?"))
								 {								
					         document.Form2.submit();
						     }		
					    }	
			}				
				   else{
				   alert("Please Enter Deal Number.");
				  }
			}
*/
		
		function beforesubmit()
	{
	
					 if(confirm("Do you want to delete this?"))
						  {
					      if(confirm("Are you sure?"))
							 {		
							 document.Form2.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_delete_deal";		
					         document.Form2.submit();
						     }		
					    }	
							
				  
		}

  function chk_recno(){
	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?reci_no="+document.Form2.Text_recno.value+"&chksql=confirm_reci ";
	window.opener.top.frames[0].document.applets[0].getdata(m_url);
	m_size=window.opener.top.frames[0].document.applets[0].outvec_value.size();
	if (m_size>0) {
		document.Form2.save_but.disabled=false;

	}
	else{
		if (confirm("Invalid Number..Press the OK button if you want a list of Codes or Press the Cancel button to type again")) {
			obtain_report();
    }
		else{
				document.Form2.Text_recno.value="";
			  document.Form2.save_but.disabled=true;

		}
	}	
	}
		
	function unformatData(cellvalue, options, cellobject) {
               return cellvalue;
           }
		
	function CheckDeal(Obj){	  
	 /* if (document.Form2.Text_Deal.value.toUpperCase().substring(0,2) =='BC'){
		  m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?reci_no="+document.Form2.Text_Deal.value.toUpperCase()+"&chksql=bank_charge ";
	    //window.open(m_url);
			document.applets[0].getdata(m_url);
	    m_size=document.applets[0].outvec_value.size();
			//alert(document.applets[0].outvec_value)
		}else{
		  m_size=0;
		} 
		vec_pos=0;
			if(m_size<=0){
			  if (confirm("Need Any Help")){
			    helpDeal(0);
				}else{
				  document.Form2.Text_Deal.value='';
				}
			}
			else {
			
			}*/
		
		 m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?reci_no="+document.Form2.Text_Deal.value.toUpperCase()+"&chksql=chk_dividend_deal";
		 //window.open(m_url);
		 load_interface(m_url,'XML',false);
		 m_size = data_vec.length;
				
			if(m_size<=0){
				if (confirm("Dividend can no delet.Do you need any help ")){
					
					document.Form2.Text_Deal.value="";
					beforesubmit_dealTiket(0);
					
				}else{
					
				   document.Form2.Text_Deal.value="";
				}
	       }
	
	}
	function beforesubmit_dealTiket(Obj) {
	  if (document.Form2.Text_Deal.value=""){
		  helpDeal(0);
		}else{
		  helpDeal(0);
		}
}
 	/*	
	function helpDeal(){
	document.Form2.hid_help_type.value="1";
	m_sql = "m_divi_income";
	m_criteria = document.Form2.Text_Deal.value+"@";
	HelpBox('1','10','2');
	}
	*/
		
		
	//-----------Added by Prabash on 08-05-2012------*	
		
	function	helpDeal(m_strat){
		
			
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form2');
	//alert('dddddd');
		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.Text_Deal;
 	//	myObject[1]=aForm.TXT_ACC_number;
	//	myObject[2]=aForm.Text_sec_name;
 		
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.Text_Deal.value;
 		myObject_value[1]=aForm.Text_Deal.value;

 		var myObject_type=new Array(); //passing values data type
		myObject_type[0]="StringL";
 		myObject_type[1]="StringL";
 	
 		var qid='129';

 		var url = 'popup.jsp';
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
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400, // 500,
		 width: 500, //900,
		 title: 'SasiNet Frame work',
		 scrollable: true,
			
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); if(returnedValue!=null){CheckDeal(this.returnValue);} } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
	}	
		
		
		
	//----------------------------------------**	
		
		
		
		
		

 	function MyDialog(){
	 	this.valout   = new Array(10);
	}		
	
	function HelpBox(Start,End,Hid_No) {
		oBj = new MyDialog();
	  oBj.valout[1]  = " ";
		oBj.valout[2]  = " ";
		oBj.valout[3]  = " ";
		
		popupwin = window.showModalDialog(""+servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_fund_Help_Servlet?class_in="+client_name+"mbfsl_fund_help_select"+
									"&Sql_in="+m_sql+"&Start_in="+Start+
									"&End_in="+End+"&Crit_In="+m_criteria+
									"&Hid_No="+Hid_No+"", oBj,"dialogWidth:25em; dialogHeight:18em; center:yes; status:no");
	 
						
   if(document.Form2.hid_help_type.value=="1"){
			if(oBj.valout[1] !=" "){
				 if(oBj.valout[1] !='Close'){
			 		if(oBj.valout[1]!="Prev"){
							if(oBj.valout[1]!="Next"){
								asign_port_code();
							}
							else{
								Next(oBj.valout[2],oBj.valout[3],Hid_No);
		 						return false;
							} 
	 				}
	 				else{	
						 Prev(oBj.valout[2],oBj.valout[3],Hid_No);
	 				}	
				 }		
				 else{		
	 				document.Form2.Text_Deal.value="";	
				 }		
		}
		else{		
	 	 document.Form2.Text_Deal.value="";	
		}		
  }
}

function Prev(Start,End,Hid_No){
	 HelpBox(Start,End,Hid_No)
}

function Next (Start,End,Hid_No){
	 HelpBox(Start,End,Hid_No)
}
	
function asign_port_code() {
   document.Form2.Text_Deal.value=oBj.valout[2];
	 m_refno=oBj.valout[3];
   m_dealnumber=oBj.valout[4];
	 m_type=oBj.valout[5];	
}
			
	//========================================================END=======nn 05042001========================================================
function myDialogObj() {
		var htmlstr; 
		var returnval1;
}

function  cancel(){
	document.Form2.Text_Deal.value="";		
}			
	function facility_number_help(m_strat)
					{
		    var aForm;    //  aForm =oForm.elements;
		    aForm =  document.getElementById('Form2');
			 
			
		 	var myObject=new Array(); //return values set to this object
		 	myObject[0]=aForm.txt_facility_number;
			myObject[1]=aForm.txt_facility_number_name;
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
		
	function	security_code_help(m_strat){
					
				var aForm;    //  aForm =oForm.elements;
		     	aForm =  document.getElementById('Form2');
			
				var myObject=new Array(); //return values set to this object
		 		myObject[0]=aForm.txt_security_code;
		 		myObject[1]=null;
				myObject[2]=aForm.txt_security_name;
		 		
		 		var myObject_value=new Array(); //passing values set to this object
		 		myObject_value[0]=aForm.txt_security_code.value;
		 		myObject_value[1]=null;
		
		 		var myObject_type=new Array(); //passing values data type
				myObject_type[0]="StringL";
		 		myObject_type[1]=null;	
		
		 		var qid='27';
		
		 		var url = 'popup.jsp';
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
				 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name,
				 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
				 height:400, // 500,
				 width: 500, //900,
				 title: 'SasiNet Frame work',
				 scrollable: true,
					
				 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
	}
</SCRIPT>
</HEAD>		
		
<body >
   		<FORM NAME="Form2" ID="Form2"  METHOD="POST">	
				<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="DELETE_DIV_INC">
				<INPUT TYPE="Hidden" NAME="hid_help_type"	VALUE="">
				<INPUT TYPE="Hidden" NAME="Hid_dealValue"	VALUE="DELETE_DIV_INC">
				<input type = "hidden" id = "hid_count" name = "hid_count" />
			
				
				<!--------------------------------------------------------------->
			<DIV>
			<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
				<tr>
					<td height='7'></td>
				</tr>
				
				<tr height='30' >
					<td  width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
					<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'> <B> Margin Trading - Receipts Management</B></td>
					<td width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>			
				</tr>
						
			</TABLE>			
			</DIV>
		
	
				<TABLE WIDTH="100%" BGCOLOR="darkblue" >
				  <TR>
				   <td width="4%">
							<INPUT TYPE="Button" NAME="calcel_but" VALUE="Save" class="mainbut" onClick="beforesubmit()">
					</td>	
				   <td width="4%">
							<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel" class="mainbut" onClick="cancel()">
					</td>
                    <td width="4%">	
							<INPUT TYPE="Button" NAME="Exit_but" VALUE=" Exit  " class="mainbut" onClick="top.frames[1].location.href='low.jsp'" > 
					</td>
                    <td width="4%">	
							<INPUT TYPE="Hidden" NAME="SAVETYPE" >
					</td>
					<TD WIDTH="*%"> &nbsp; </TD>
					<td width="50%" class="hh1" align="right"><b>Dividend Income Deletion</b></td>
				   <TD> <B><div id='div_lable' align='right' > </div> </B> </TD>	
				</TR>
			
			  </TABLE> 	
				
			<!----------------------------->
			 <TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
			<HR>
				<TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
			<!----------------------------->		
			
			
				<TABLE WIDTH="100%"  border='0' >
				  <TR>
				  <TD  style = "width: 200px;">Dividend Number</TD>
					<TD  ><INPUT class = "txt_input" TYPE="TEXT" NAME="Text_Deal"  ID="Text_Deal" size="25" onblur="CheckDeal(document.Form2.Text_Deal);"></TD>
 				  <TD  style= "width: 20px;"><INPUT TYPE="Button" NAME="Butt_deal" VALUE=" ... "  class="but_input" onClick="beforesubmit_dealTiket(0);" >
					<INPUT TYPE="hidden" NAME="Butt_deal" VALUE=" Delete "  class="but_input" onClick="beforesubmit(document.Form2.Text_Deal);"></TD>
				  <TD  WIDTH="*%"></TD>
				  </TR>
		
				
					<tr>
					                        <td style = "width: 200px;"><div id = "div_txt_facility_number">Facility Number</div></td>
											       <td><input class = "txt_input" type = "text" id = "txt_facility_number" name = "txt_facility_number" maxlength = "15" style = "width: 150px;" />
					                                  </td>
					                                      <td style = "width: 20px;">
					                                         <input class = "but_input" type = "button" id = "BUT_HELP_FACILITY_NUMBER" name = "BUT_HELP_FACILITY_NUMBER" value = "..." onclick="facility_number_help(0);"  />
					                                             <a id = "help_update_client_manager" style = "text-decoration: none; cursor: text;" class = "fancylink iframe" href = ""> </a>
					                                           
					                                    <td style = "width: 200px;"><div id = "txt_facility_number_name">Facility Number</div></td>
					                                <td>
					                             <input class = "txt_input" type = "text" id = "txt_facility_number_name" name = "txt_facility_number_name" style = "width: 250px;" disabled = "disabled" />
					                          </td>
					                      </tr>
					
				 <tr>
                       <td>Security Code</td>
                        <td>
                            <input class="txt_input" type="text" id="txt_security_code" name="txt_security_code" maxlength="15" style="width: 125px;" />
                            
                        </td>
                        <td><input class="but_input" type="button" id="BUT_HELP_SECURITY_CODE" name="BUT_HELP_SECURITY_CODE" value="..." onclick="security_code_help(0);" /></td>
                        <td>Security Name</td>
                        <td>
                            <input class="txt_input" type="text" id="txt_security_name" name="txt_security_name" style="width: 200px;" disabled="disabled" />
                        </td>
                    </tr>
                    		
										 <!------------------------------------->
										
                                                      

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
                                                           <input class = "but_input" type = "button" name = "BUT_SEARCH" id = "BUT_SEARCH" value = "Search" style = "width: 100px;" onclick="loadGridDividendIncome();"/>
                          
                                                           </td>
                                                           <td style = "width: 75px;">
                                                            <!--     <input class = "txt_input" type = "text" id = "TXT_LETTER_REFERENCE_NUMBER" name = "TXT_LETTER_REFERENCE_NUMBER" style = "width: 100px;" maxlength = "50" onblur = "strTrim(this);" disabled = "disabled" />-->
                                                           </td>
                                                       </tr>
                                                   </table>
			</TABLE> 
			<BR><BR>
			
		<div id = "DIV_DIVIDEND_DELETE">
                     <table id = "TABLE_DIVIDEND_DELETE"></table>
                     <div id = "DIV_PAGER_TABLE_DIVIDEND_DELETE"></div>
        </div>
			
			
</FORM>

		
	</body>
<DIV> <script language="JavaScript1.2" src="validate.js"></SCRIPT></DIV>
		<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
		<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT> 
</html>

