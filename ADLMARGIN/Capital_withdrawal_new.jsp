	<HTML> 
		<HEAD>
			<TITLE>Margin Trading 
			</TITLE>
			
		
			<%@page import="net.sasianet.ADLMARGIN.*" %>
	
		<%	
		ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods();
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
			
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
        out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
	    %>

	<SCRIPT language="JavaScript1.2" >
	$(document).ready(function() {
		
			 initCal('VAL_TXT_DATE');
            // initCal('BANK_TXT_DATE');
			// initCal('CHEQUE_REALIZATION_TXT_DATE');
			// loadGridPaymentsPrint();
			 initmsgDrillDialog();
			 initmsgDrillEnq(getW,150);	
			 });
		
		
		
		function initCal(m_id) {
                $('#' + m_id).datepicker({
                    dateFormat: 'dd-mm-yy',
                    duration: 'fast',
                    yearRange: '1920:2050',
                    showOn: 'button',
                    buttonImage: 'https://dev-adlmargin.sasianet.com:8443/ADLMARGIN/LBMARGIN/SNET/images/calendar.gif',
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
               if (instance_id == "VAL_TXT_DATE") {
                   document.Form1.TXT_DATE.value = splitResult[0];
                   document.Form1.TXT_MONTH.value = splitResult[1];
                   document.Form1.TXT_YEAR.value = splitResult[2];
                   document.Form1.TXT_YEAR.focus();
               }
             /*  else if (instance_id == "BANK_TXT_DATE") {
                   document.Form1.BANK_TXT_DAY.value = splitResult[0];
                   document.Form1.BANK_TXT_MONTH.value = splitResult[1];
                   document.Form1.BANK_TXT_YEAR.value = splitResult[2];
                   document.Form1.BANK_TXT_YEAR.focus();
				}else if (instance_id == "CHEQUE_REALIZATION_TXT_DATE") {
                   document.Form1.CHEQUE_REALIZATION_TXT_DAY.value = splitResult[0];
                   document.Form1.CHEQUE_REALIZATION_TXT_MONTH.value = splitResult[1];
                   document.Form1.CHEQUE_REALIZATION_TXT_YEAR.value = splitResult[2];
                   document.Form1.CHEQUE_REALIZATION_TXT_YEAR.focus();
               }*/
              
           }

	function Blur_porpolio(ObjVal){
				m_portfcode=ObjVal; 
				m_size="";
		    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=Pf_Blur_new&PF_value="+ObjVal+" ";
				
				
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
		
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
					
		
		if(m_size<=0){
					if (confirm("Invalid Portpolio Code. Press OK For Help")){
					portP_help(0);
					document.Form1.TXT_portfolio.value="";
					
					}
						else{
						 document.Form1.TXT_portfolio.value="";
							}
					}	else{
					pf_name.innerHTML=top.frames[0].document.applets[0].outvec_value.elementAt(2); 
					document.Form1.TXT_portfolio.disabled=true;
						get_availability();	//added by prabash on 24-09-2012
					}
	}
	
	
	function portP_help(m_strat)
	{
     var Form1;    
     Form1 =  document.getElementById('Form1');
 	var myObject=new Array(); //return values set to this object
 	myObject[0]=Form1.TXT_portfolio;
	 myObject[1]=null;
 	myObject[2]=null;
 	myObject[3]=null;
 	myObject[4]=null;
  
 	var myObject_value=new Array(); //passing values set to this object
 	myObject_value[0]=Form1.TXT_portfolio.value;
 	myObject_value[1]=Form1.TXT_portfolio.value
 	myObject_value[2]=null;
 	myObject_value[3]=null;
 	myObject_value[4]=null;
 
 
 	var myObject_type=new Array(); //passing values data type
 	myObject_type[0]="StringL";
 	myObject_type[1]="StringL";
 	myObject_type[2]=null;
 	myObject_type[3]=null;
 	myObject_type[4]=null;
 
 	var qid='4';

 	var url = 'popup.jsp';
 	var json_text = JSON.stringify(myObject_value, null,0);
 	var json_obj_type_text=JSON.stringify(myObject_type, null,0);
 	var fn_name=arguments.callee.name;
		if(fn_name==undefined){
		re = /^function\s+([^(]+)/;
        fn_name=re.exec(arguments.callee.toString())[1];
		}
       	$.showModalDialog({
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400,// 500,
		 width: 600,//900,
		 title: 'SasiNet Frame work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);if(returnedValue != null){ get_availability();}	   } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
	}
	
	//---------comment by prabash on 05-08-2011------**
	/*	function portP_help_mod(){
			m_portfcode=""; 
			m_size="";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=Pf_help_with_mod";
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();				
			
			vec_pos=0;
			lineno=1;
			m_row="";
			while (vec_pos<m_size) {
				
				m_doc_ref =top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
				m_pf_code =top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
				m_pf_name   =top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2);
				m_CDS_NO=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+3);
				
				m_desc=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+4);
				m_branch_code=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+5);
				m_acc_no=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+6);
				m_pay_bank_code=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+7);
				
				m_chk_no=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+8);
				m_trn_amount=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+9);
				m_eff_val_date=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+10);
				
				m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help_new10(C1R'+lineno+',C2R'+lineno+',C3R'+lineno+',C4R'+lineno+',C5R'+lineno+',C6R'+lineno+',C7R'+lineno+',C8R'+lineno+',C9R'+lineno+',C10R'+lineno+',C11R'+lineno+'); ><TD ID=C1R'+	lineno+' ALIGN="LEFT" ><B>'+m_doc_ref+'</B></TD><TD ID=C2R'+	lineno+' ALIGN="CENTER" ><B>'+m_pf_code+'</B></TD><TD ID=C3R'+	lineno+' ALIGN="LEFT" ><B>'+m_pf_name+'</B></TD><TD ID=C4R'+	lineno+' ALIGN="LEFT" ><B>'+m_CDS_NO+'</B></TD>'+
					'<TD ID=C5R'+	lineno+' ALIGN="LEFT" WIDTH="0%" style="display:none" ><B>'+m_desc+'</B></TD>'+
					'<TD ID=C6R'+	lineno+' ALIGN="LEFT" style="display:none"><B>'+m_branch_code+'</B></TD>'+
					'<TD ID=C7R'+	lineno+' ALIGN="LEFT" style="display:none"><B>'+m_acc_no+'</B></TD>'+
					'<TD ID=C8R'+	lineno+' ALIGN="LEFT" style="display:none" ><B>'+m_pay_bank_code+'</B></TD>'+
					'<TD ID=C9R'+	lineno+' ALIGN="LEFT" ><B>'+m_chk_no+'</B></TD>'+
					'<TD ID=C10R'+	lineno+' ALIGN="RIGHT" ><B>'+format_noobject(m_trn_amount)+'</B></TD>'+
					'<TD ID=C11R'+	lineno+' ALIGN="LEFT" ><B>'+m_eff_val_date+'</B></TD></TR>';
				vec_pos=vec_pos+11;
				lineno=lineno+1;
			}
			m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color: white; font: 9pt arial;}">'+            
				'<TR BGCOLOR="darkblue">' +
				'<TD WIDTH="15%"><B>Reference No.</B></TD>'+
				'<TD WIDTH="5%"><B>Client Code</B></TD>'+
				'<TD WIDTH="25%" ALIGN="CENTER"><B>Client Name</B></TD>' +
				'<TD WIDTH="10%"><B>CDS No</B></TD>' +
				
				'<TD WIDTH="0%" style="display:none"><B>Description</B></TD>' +
				'<TD WIDTH="0%" style="display:none"><B>Licencee Bank Code</B></TD>' +
				'<TD WIDTH="0%" style="display:none"><B>Licencee Accounts No.</B></TD>' +
				'<TD WIDTH="0%" style="display:none"><B>Payee Bank Code</B></TD>' +
				
				'<TD WIDTH="10%"><B>Cheque No</B></TD>' +
				'<TD WIDTH="15%"><B>Amount</B></TD>' +
				'<TD WIDTH="15%"><B>Value Date</B></TD></TR>' +
				m_row+
				'</TABLE>'; //style="background-color: #07B133; color: #ffffff;	visibility: hidden;" 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval1 = "";
			myDialogObj.returnval2 = "";
			myDialogObj.returnval3 = "";
			myDialogObj.returnval4 = "";
			myDialogObj.returnval5 = "";
			myDialogObj.returnval6 = "";
			myDialogObj.returnval7 = "";
			myDialogObj.returnval8 = "";
			myDialogObj.returnval9 = "";
			myDialogObj.returnval10 = "";
			myDialogObj.returnval11 = "";
			
			
			helpvalue="";
			
			popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:50em; dialogHeight:15em; center:yes; resizable:yes; status:no");
			helpvalue= top.frames[0].document.applets[0].outvec_value.indexOf(myDialogObj.returnval1);
			
			if (helpvalue != 1) {
				document.Form1.HID_DOC_REF_NO.value=top.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+0);
				document.Form1.TXT_portfolio.value=top.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+1);
				pf_name.innerHTML=top.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+2);
				//document.Form1.TXT_portfolio.value=top.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+4);
				document.Form1.TXT_desc.value=top.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+4);
				document.Form1.TXT_bank_code.value=top.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+5);
				document.Form1.TXT_ACC_number.value=top.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+6);
				//document.Form1.TXT_payee.value=top.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+7);
				document.Form1.TXT_chqno.value=top.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+8);
				document.Form1.TXT_amount.value=top.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+9);
				document.Form1.TXT_DATE.value=top.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+10).substring(0,2);
				document.Form1.TXT_MONTH.value=top.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+10).substring(3,5);
				document.Form1.TXT_YEAR.value=top.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+10).substring(6,10);
			1
				
			//01-01-2011	
			}
			
			else { 
				if (helpvalue==1){
				}
			}
			
		}
		
		*/
		//---------------------------------------------------**
		//---------------------------------------------------**
		function portP_help_mod(m_strat){
				var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	 /*  var myObject = new Object();
   	 myObject.firstName = aForm.oFirstName.value;
   	 myObject.lastName = aForm.oLastName.value;
		*/
		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.HID_DOC_REF_NO;
 		myObject[1]=aForm.TXT_portfolio;
 		myObject[2]=aForm.TXT_desc;
 		myObject[3]=null;
 		myObject[4]=null;
		myObject[5]=aForm.TXT_bank_code;
 		myObject[6]=aForm.TXT_ACC_number;
 		myObject[7]=aForm.TXT_payee;
 		myObject[8]=aForm.TXT_chqno;
 		myObject[9]=aForm.TXT_amount;
		myObject[10]=aForm.TXT_DATE;
		myObject[11]=aForm.TXT_MONTH;
		myObject[12]=aForm.TXT_YEAR;
		
  
  
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=null;
 		
		
 
 		
 
 
 		var myObject_type=new Array(); //passing values data type
 		myObject_type[0]=null;
 		myObject_type[1]="StringL";
 		myObject_type[2]="StringL";
 		myObject_type[3]=null;
 		myObject_type[4]=null;
		myObject_type[5]="StringL";
 		myObject_type[6]="StringL";
 		myObject_type[7]="StringL";
 		myObject_type[8]="StringL";
 		myObject_type[9]="StringL";
		myObject_type[10]="StringL";
		myObject_type[11]="StringL";
 		myObject_type[12]="StringL";
 		var qid='7';
		var hid='3';	
     
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
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&hid='+hid,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400,// 500,
		 width: 700,//900,
		 title: 'SasiNet',		  
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);if(returnedValue != null){ get_availability();}	   } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
		}
	//---------------------------------------------------**
		
	  function checkmargintradingdate(dayobj,monthobj,yearobj) {
            buy_sett_date=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
		//	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buy_sett_date="+buy_sett_date+"&chksql=chk_margin_trading_date_with_value_date";
		  	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buy_sett_date="+buy_sett_date+"&chksql=chk_buy_sett_date_check"; //chk_buy_sett_date
			load_interface(m_url,'XML',false);
		    m_size= data_vec.length;

          document.Form1.HID_BUY_SETT_DATE.value=data_vec[0];
				
     if(document.Form1.HID_BUY_SETT_DATE.value=="YES"){
     //alert("Value Date should be greater than Last Margin Trading Routine Date. Please Re-Enter the Value Date!");
		alert("Value Date is not greater than Last Day End Routine Date or daily margin trading date , Please Re-Enter the Value Date !.");		
			dayobj.value=" ";	monthobj.value=" ";yearobj.value=" ";dayobj.focus();
     }
		 else{
      }
    }
	
			
		
	function bank_help_single(){
			var data_vec= "";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=set_opt_help_button&bankcode="+document.Form1.TXT_bank_code.value ;
		    load_interface(m_url,'XML',false);
			m_size=data_vec.length;
			vec_pos=0;
			m_row="";
			lineno=1;
			if(m_size==2) {
				document.Form1.TXT_bank_code.value=data_vec[0];
				document.Form1.TXT_ACC_number.value=data_vec[1]; 
				
			}
			
		}
		
			function bank_help(m_strat) {
			var aForm;    
     	aForm =  document.getElementById('Form1');
		var myObject=new Array(); 
 		myObject[0]=aForm.TXT_bank_code;
 		myObject[1]=aForm.TXT_ACC_number;
 		myObject[2]=null;
 		myObject[3]=null;
 		myObject[4]=null;
  
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.TXT_bank_code.value;
 		myObject_value[1]=aForm.TXT_ACC_number.value;
 		myObject_value[2]=null;
 		myObject_value[3]=null;
 		myObject_value[4]=null;
 
 
 		var myObject_type=new Array();
 		myObject_type[0]="StringL";
 		myObject_type[1]=null;
 		myObject_type[2]=null;
 		myObject_type[3]=null;
 		myObject_type[4]=null;
 
 		var qid='2';

 		var url = 'popup.jsp';
 		var json_text = JSON.stringify(myObject_value, null,0);
 		var json_obj_type_text=JSON.stringify(myObject_type, null,0);
 		var fn_name=arguments.callee.name;
			if(fn_name==undefined){
		re = /^function\s+([^(]+)/;
        fn_name=re.exec(arguments.callee.toString())[1];
		}	
       	$.showModalDialog({
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400,// 500,
		 width: 400,//900,
		 title: 'SasiNet Frame work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
	}

	
	function clearAll(){
					document.Form1.TXT_portfolio.value="";
					document.Form1.TXT_bank_code.value="";
					document.Form1.TXT_ACC_number.value="";
		            document.Form1.TXT_chqno.value="";
			        document.Form1.TXT_desc.value="";
			        //document.Form1.TXT_payee.value="";
			        document.Form1.TXT_amount.value="";
					document.Form1.TXT_portfolio.disabled=false;
					document.Form1.TXT_DATE.value=data_vec[0].substring(0,2);
		        	document.Form1.TXT_MONTH.value=data_vec[0].substring(3,5);
		        	document.Form1.TXT_YEAR.value=data_vec[0].substring(6,10);
				
						
	}
	
	
	function checkbuyersettlementdate(dayobj,monthobj,yearobj) {
      		buy_sett_date=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buy_sett_date="+buy_sett_date+"&chksql=chk_buy_sett_date_22";//CHAGE BY WARUNA 2011-02-14
		  	load_interface(m_url,'XML',false);
		  	var data_vec= "";
			m_size= data_vec.length;

     		document.Form1.HID_BUY_SETT_DATE.value=data_vec[0];
				
     		if(document.Form1.HID_BUY_SETT_DATE.value=="YES"){
     			alert("Value Date is not greater than Last Day End Routine Date, Please Re-Enter the Value Date !.");
		 		dayobj.value=" ";	monthobj.value=" ";yearobj.value=" ";dayobj.focus();
     		}
    }
	
	function obtain_report_before() { //to be done
		 m_url=jsp_client_url+'/dn_capitalwith_obtain.jsp';
		 //popupwin = window.open(m_url,'displayWindow', 'top=200, left=100, width=600, height=200, scrollbars=no, menubar=No, resizable=no, fullscreen=No');
	    pop_up_message_3(m_url);
	}
		
	/*function BeforeSave(){ // to be done
	
		dayobj=document.Form1.TXT_DATE;
		monthobj=document.Form1.TXT_MONTH;
		yearobj=document.Form1.TXT_YEAR;
		unformat(document.Form1.TXT_amount);
  		buy_sett_date=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buy_sett_date="+buy_sett_date+"&chksql=chk_buy_sett_date";
  		top.frames[0].document.applets[0].getdata(m_url);
  		m_size=top.frames[0].document.applets[0].outvec_value.size();

  		document.Form1.HID_BUY_SETT_DATE.value=top.frames[0].document.applets[0].outvec_value.elementAt(0);
			
  		if(document.Form1.HID_BUY_SETT_DATE.value=="YES"){
  			alert("Value Date is not greater than Last Day End Routine Date, Please Re-Enter the Value Date !.");
			dayobj.value=" ";	monthobj.value=" ";yearobj.value=" ";dayobj.focus();
  		}
		else{
			document.Form1.TXT_portfolio.disabled=false;
			document.Form1.save_but.disabled=true;
			document.Form1.TXT_bank_code.disabled=false;
			document.Form1.TXT_ACC_number.disabled=false;
		
		 	dayobj=document.Form1.TXT_DATE;
	   		monthobj=document.Form1.TXT_MONTH;
	   		yearobj=document.Form1.TXT_YEAR;
		 	buy_sett_date=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
		 	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buy_sett_date="+buy_sett_date+"&chksql=chk_margin_trading_date_with_value_date";
     		top.frames[0].document.applets[0].getdata(m_url);
     		m_size=top.frames[0].document.applets[0].outvec_value.size();

     		document.Form1.HID_BUY_SETT_DATE.value=top.frames[0].document.applets[0].outvec_value.elementAt(0);
				
     		if(document.Form1.HID_BUY_SETT_DATE.value=="NO"){
     			alert("Value Date should be greater than Last Margin Trading Routine Date. Please Re-Enter the Value Date!");
		 		dayobj.value=" ";	monthobj.value=" ";yearobj.value=" ";dayobj.focus();
     		}
		 	else{
		 		Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsavsett_temp";
     		}
			Form1.submit();
		}
	}*/
		//-------added by prabash on0509-2011-----------**
		function BeforeSave(){ // to be done
		/* remove for adlmargin by waruna 2013-02-14	
		if( document.Form1.TXT_amount.value > document.Form1.TXT_availability.value){
			alert('Amount must be less than the bank balance');
			//return false; 
			
		}*/
	
		dayobj=document.Form1.TXT_DATE;
		monthobj=document.Form1.TXT_MONTH;
		yearobj=document.Form1.TXT_YEAR;
		unformat(document.Form1.TXT_amount);
			
  		buy_sett_date=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buy_sett_date="+buy_sett_date+"&chksql=chk_buy_sett_date_check"; //chk_buy_sett_date
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
				
				document.Form1.HID_BUY_SETT_DATE.value=data_vec[0];
				
				if(document.Form1.HID_BUY_SETT_DATE.value=="YES"){
				//	alert("Value Date is not greater than Last Day End Routine Date, Please Re-Enter the Value Date !.");
					alert("Value Date is not greater than Last Day End Routine Date or daily margin trading date , Please Re-Enter the Value Date !.");	
					dayobj.value=" ";	monthobj.value=" ";yearobj.value=" ";dayobj.focus();
  		}
		else{
		
		/*	document.Form1.TXT_portfolio.disabled=false;
			document.Form1.save_but.disabled=true;
			document.Form1.TXT_bank_code.disabled=false;
			document.Form1.TXT_ACC_number.disabled=false;
		
		 	dayobj=document.Form1.TXT_DATE;
	   		monthobj=document.Form1.TXT_MONTH;
	   		yearobj=document.Form1.TXT_YEAR;
		 	buy_sett_date=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
		 	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buy_sett_date="+buy_sett_date+"&chksql=chk_margin_trading_date_with_value_date";
     		load_interface(m_url,'XML',false);
			m_size = data_vec.length;
     		document.Form1.HID_BUY_SETT_DATE.value=data_vec[0];
				
     		if(document.Form1.HID_BUY_SETT_DATE.value=="NO"){
     			alert("Value Date should be greater than Last Margin Trading Routine Date. Please Re-Enter the Value Date!");
		 		dayobj.value=" ";	monthobj.value=" ";yearobj.value=" ";dayobj.focus();
     		}
		 	else{
			*/		
					
		 		Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsavsett_temp";
     		}
			for(var i = 0; i < document.Form1.elements.length; i++) {
					document.Form1.elements[i].disabled = false;
					
					if(document.Form1.elements[i].type == 'text' ||  document.Form1.elements[i].type == 'hidden'){
						document.Form1.elements[i].value = unformat_noobject(document.Form1.elements[i].value); 
					}
					
				}
				
			Form1.submit();
	//	}
	}
		//--------**
			
		function myDialogObj() { //thamali
			var htmlstr; 
	 		var returnval;
			var	returnval1;
			var	returnval2;
  		}
	
		function chkstartdate(dayobj,monthobj,yearobj) { //thamali
		    checkMonthLength(dayobj,monthobj,yearobj);		
		}

		function format(obj){ //thamali
		obj.value=format_noobject(obj.value);
		
		}
		function unformat(obj){ //thamali
		obj.value=unformat_noobject(obj.value);
		
		}
		
		
		function display_dat(){ //thamali
		  m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=get_dat";
		  load_interface(m_url,'XML',false);
			
			m_size= data_vec.length;
			if(m_size>0){	
		        document.Form1.TXT_DATE.value=data_vec[0].substring(0,2);
		        document.Form1.TXT_MONTH.value=data_vec[0].substring(3,5);
		        document.Form1.TXT_YEAR.value=data_vec[0].substring(6,10);
            }
			
			<% if(request.getParameter("reci_no")!=null){ 
			   out.println("if(true){");
			     }else{
			   out.println("if(false){");
			   }
			
			%>
			m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"report_portf_charges_save?reci_no=<%=request.getParameter("reci_no")%>&port=<%=request.getParameter("port")%>&chksql=with_temp";
			pop_up_message_2(m_url);	
			<% 
			 out.println("}");
			
		%>
			
        }
		
		function display_sec_opt(m_val){ 
				
			 if(m_val=="new"){
				clearAll();
				document.Form1.Hid_scr_name.value='cap_deposit_with';
				
			}
			else if(m_val=="mod"){
				clearAll();
				document.Form1.Hid_scr_name.value='cap_deposit_with_mod';
				
			}
			else if(m_val=="del"){
				clearAll();
				document.Form1.Hid_scr_name.value='cap_deposit_with_del';
			}
			else{
				alert('Please Select Add/Modify/Delete');
			}
		}	
		
		
		function portP_help_new(){ 
			
			if(document.Form1.Hid_scr_name.value=="cap_deposit_with"){
			portP_help(0);
			
			}
			else if (document.Form1.Hid_scr_name.value=="cap_deposit_with_mod"){
				portP_help_mod(0);
				
			}
			else if (document.Form1.Hid_scr_name.value=="cap_deposit_with_del"){
				portP_help_mod(0);
			}
			else{
				alert('Please Select Add/Modify/Delete');
			}
		}
		
		function initmsgDrillDialog() {
				
	             $("#DIV_MSG_WINDOW").dialog(				
				 {
					
	            	bgiframe: true,
	            	autoOpen: false,
	            	//modal: false,
					modal: true, //to disable the back ground	
	            	height: 400,
	            	width: getW,
	            	close: function() {	}
	              }
				 );
			}
		
		function initmsgDrillEnq(val_with,val_hight) {
				
	             $("#DIV_MSG_WINDOW2").dialog(				
				 {
					
	            	bgiframe: true,
	            	autoOpen: false,
	            	//modal: false,
					modal: true, //to disable the back ground	
	            	height: val_hight,
	            	width:val_with, 
	            	close: function() {	}
	              }
				 );
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
		
			function pop_up_message_2(m_url){					
				if ($("#DIV_MSG_WINDOW").dialog("isOpen")) 
				{
            		$("#DIV_MSG_WINDOW").dialog("close");
            	}
            	$("#DIV_MSG_WINDOW").dialog("option", "title", "Receipt");
            	$("#DIV_MSG_WINDOW").dialog("open");
            	$("#IFRAME_MSG_WINDOW").attr("src",m_url);
            	return false;
				
			}
		function pop_up_message_3(m_url){					
				if ($("#DIV_MSG_WINDOW2").dialog("isOpen")) 
				{
            		$("#DIV_MSG_WINDOW2").dialog("close");
            	}
            	$("#DIV_MSG_WINDOW2").dialog("option", "title", "Enquiry");
            	$("#DIV_MSG_WINDOW2").dialog("open");
            	$("#IFRAME_MSG_WINDOW2").attr("src",m_url);
            	return false;
				
			}
		
	//added by prabash on 24-09-2012------	
		function get_availability(){
		
		  m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=get_avail_spot_maket_margin&faciliti_no="+document.Form1.TXT_portfolio.value+"";
		  load_interface(m_url,'XML',false);
			//alert(m_size);
			m_size= data_vec.length;
			if(m_size>0){	
		        //document.Form1.TXT_availability.value        = format_noobject(data_vec[0]);
		   //     document.Form1.TXT_spot_margins.value        = format_noobject(data_vec[1]);
		   //     document.Form1.TXT_spot_margins_market.value = format_noobject(data_vec[2]);
				
				
            }
		}
	//-----------------------------------	
	</SCRIPT>
	</HEAD>
 <BODY onload="display_dat()" class='body & txt-body'>
  <FORM NAME="Form1" ID="Form1" METHOD="POST" >
	<INPUT TYPE="Hidden" NAME="Hid_ACC_TYPE"	VALUE="WITHDRAW">
	<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="cap_deposit_with">
	<INPUT TYPE="Hidden" NAME="HID_BUY_SETT_DATE" VALUE="" >
	<INPUT TYPE="Hidden" NAME="HID_DOC_REF_NO" VALUE="" >
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
		<!--------------------------------------------------------------->
			<table class='table' border='0' cellpadding='0' cellspacing='0' width='100%'> 
			<tr>
			<td height='1'></td>
			</tr>
			<tr>				
					
		<!-------------------------------------------------------------------->
	
	<TABLE WIDTH="100%" BGCOLOR="darkblue" >
					<TR >
					<!--added by prabash on 01-09-2011-->
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="NEW" VALUE="Add"   onClick="display_sec_opt('new');"  class="mainbut"  >
					</TD>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="MOD" VALUE="Edit"   onClick="display_sec_opt('mod');" class="mainbut"  >
					</TD>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="DEL" VALUE="Delete"   onClick="display_sec_opt('del');"  class="mainbut"  >
					</TD>
					<TD WIDTH='6%'></TD>		
					<!---------------------------------->
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="save_but" VALUE="Save"    class="mainbut" onClick="BeforeSave()">
					</TD>
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"       class="mainbut" onClick="clearAll()"> 
					</TD>
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit"  class="mainbut" onClick="top.frames[1].location.href='low.jsp'"> 
					</TD>
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="report_but" VALUE="Enquiry"    class="mainbut" onClick="obtain_report_before()">
				  </TD>
			   <TD WIDTH="38%" class="hh1" align="right">
				<B>Capital Withdrawal</B>
			</TD>					
		</TR>
		</TABLE> 	
		
		
			    <TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
			<HR>
				<TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
		
		
  <BR>	
  <TABLE WidTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0"  >   					
	 <TD WidTH="1%">
	 <TD WidTH="99%">
		
									
									
								
									
	  <TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0" >
		  <TR>
				<TD WIDTH="1%"></TD>
				<TD WidTH="30%">Facility No</TD>
				<TD WidTH="30%"><INPUT TYPE="Text" NAME="TXT_portfolio"	TABINDEX=1  ALIGN="LEFT" SIZE=20  class="txt_input6" OnBlur="Blur_porpolio(document.Form1.TXT_portfolio.value)">
				<INPUT TYPE="button" VALUE=" ... " NAME="BUT_INSTYPE"  class="but_input" OnClick="portP_help_new()" >
				<div id=pf_name></div></TD>
											
				<!--added by Prabash on 24-09-2012-->
				<TD WidTH="1%" ></TD>
				<TD WidTH="20%" ><!--Availability--></TD>
				<TD WidTH="20%" ><!--<INPUT TYPE="Text" NAME="TXT_availability"	TABINDEX=-1  style="text-align: right;" SIZE=20  class="txt_input6" disabled >--></TD>
				<TD WidTH="20%" ></TD>
				<TD WidTH="10%" ></TD>	
				<!---------------------------------->
											
			</TR>	
		</TABLE>	
		

	  <TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0" >
		  <TR>
				<TD WIDTH="1%"></TD>
				<TD WidTH="30%">Description</TD>
				<TD WidTH="69%"><INPUT TYPE="Text" NAME="TXT_desc" TABINDEX=2 	ALIGN="LEFT" SIZE=20  maxlength="50" class="txt_input6" onBlur="bank_help_single();"  ></TD><!-- ADD MAX LENGTH BY WARUNA 2011-05-09-->
			</TR>	
			
	  <TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0" >
		  <TR>
				<TD WIDTH="1%"></TD>
				<TD WidTH="30%">Licencee Bank Code</TD>
				<TD WidTH="*%"><INPUT TYPE="Text" NAME="TXT_bank_code"	ALIGN="LEFT" SIZE=20  class="txt_input6" disabled>
				<INPUT TYPE="button" VALUE=" ... " NAME="BUT_INSTYPE"  class="but_input" OnClick="bank_help(0)"></TD>
			</TR>	
		</TABLE>	
			
	  <TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0" >
		  <TR>
				<TD WIDTH="1%"></TD>
				<TD WidTH="30%">Licencee Accounts Number</TD>
				<TD WidTH="21%"><INPUT TYPE="Text" NAME="TXT_ACC_number"	ALIGN="LEFT" SIZE=20 class="txt_input6" disabled></TD>
				<TD WidTH="*%"></TD>
			</TR>	
		</TABLE>	
		
					<TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0">
	    	<TD WIDTH="1%"></TD>
				<TD WIDTH="30%" >Value Date</TD>
	 		  <TD WIDTH="20%"><INPUT TYPE="Text" NAME="TXT_DATE" SIZE=3 MAXLENGTH=2 class="txt_input5">
			                 <INPUT TYPE="Text" NAME="TXT_MONTH" SIZE=3 MAXLENGTH=2 class="txt_input5">
			                <!-- <INPUT TYPE="Text" NAME="TXT_YEAR" SIZE=4 MAXLENGTH=4 class="txt_input5" ONBLUR="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR);checkbuyersettlementdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR);checkmargintradingdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR);"> -->								
				            <INPUT TYPE="Text" NAME="TXT_YEAR" SIZE=4 MAXLENGTH=4 class="txt_input5" ONBLUR="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR);checkmargintradingdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR);"> 	
							<input type = "hidden" name = "VAL_TXT_DATE" id = "VAL_TXT_DATE" />
				<TD WIDTH="50%"></TD>	
			</TABLE> 			
	  <TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0" >
		  <TR>
				<TD WIDTH="1%"></TD>
				<TD WidTH="30%">Amount</TD>
				<TD WidTH="69%"><INPUT TYPE="Text" NAME="TXT_amount"	TABINDEX=3   ONBLUR="format(document.Form1.TXT_amount)" ALIGN="LEFT" SIZE=20   class="txt_input6"></TD> 
			</TR>	
		</TABLE>	

		<TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0" >
			 <TR>
				<TD WIDTH="1%"></TD>
				<TD WidTH="30%">Cheque No</TD>
				<TD WidTH="69%"><INPUT TYPE="Text" NAME="TXT_chqno"	TABINDEX=4  ALIGN="LEFT" SIZE=20 class="txt_input6"></TD>
			</TR>	
			</TABLE>	
		</TABLE> 
 </TABLE> 
									
	   <div id ="DIV_MSG_WINDOW" title ="Receipt">
	       <iframe id ="IFRAME_MSG_WINDOW" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Day End Routine">
	       </iframe>
	       </div>
			
		   <div id ="DIV_MSG_WINDOW2" title ="Enquriy">
	       <iframe id ="IFRAME_MSG_WINDOW2" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Day End Routine">
	       </iframe>
	    </div>	
									
</FORM>
	<!--<applet code=mf_datagateway.class width=0 height=0></applet>-->
   <SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
   <script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT> 
	</body>
</html>


