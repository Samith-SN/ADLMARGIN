<%@page import="net.sasianet.ADLMARGIN.*" %>
<HTML> 
	<HEAD>
		<TITLE>Margin Trading 
		</TITLE>
		<LINK REL="stylesheet" TYPE="text/css" HREF="" />
	
		
	</HEAD>
	
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
			
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
        out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
		
		
			
	    %>
	
	<SCRIPT language="JavaScript1.2" >
		
		
		$(document).ready(function() {
		
			 initCal('VAL_TXT_DATE');
             initCal('BANK_TXT_DATE');
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
                    buttonImage: '<%=m_jsp_client_url%>/SNET/images/calendar.gif',
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
               else if (instance_id == "BANK_TXT_DATE") {
                   document.Form1.BANK_TXT_DAY.value = splitResult[0];
                   document.Form1.BANK_TXT_MONTH.value = splitResult[1];
                   document.Form1.BANK_TXT_YEAR.value = splitResult[2];
                   document.Form1.BANK_TXT_YEAR.focus();
				}/*else if (instance_id == "CHEQUE_REALIZATION_TXT_DATE") {
                   document.Form1.CHEQUE_REALIZATION_TXT_DAY.value = splitResult[0];
                   document.Form1.CHEQUE_REALIZATION_TXT_MONTH.value = splitResult[1];
                   document.Form1.CHEQUE_REALIZATION_TXT_YEAR.value = splitResult[2];
                   document.Form1.CHEQUE_REALIZATION_TXT_YEAR.focus();
               }*/
              
           }
		
		
		//****************************************OUTFLOW HELP*******************************
		function account_help() {
			m_portfcode="hh";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=account_lookup";
			 top.frames[0].document.applets[0].getdata(m_url);
			m_size= top.frames[0].document.applets[0].outvec_value.size();
			//alert(m_size);
			vec_pos=0;
			m_row="";
			lineno=1;
			while (vec_pos<m_size) {
				m_acc_no= top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
				m_bank_name= top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
				m_row=m_row+'<TR STYLE="{color:black; cursor:hand font: bold 8pt Arial;}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_acc_no+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_bank_name+'</B></TD></TR>';
				vec_pos=vec_pos+2;
				lineno=lineno+1;
			}
			m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color:black; font: bold 8pt Arial;}>'+
				'<TR BGCOLOR="silver"><TD WIDTH="40%"><B>Account  Number</B></TD>' +
				'<TD WIDTH="60%"><B>Bank  Branch Name</B></TD></TR>'+
				m_row+
				'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval = "";
			
			popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
			account_obj .value=myDialogObj.returnval;
			account_obj .focus();
		}
		
		//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@	
		function Blur_porpolio(ObjVal){
			//alert("jmk");
			m_portfcode=ObjVal; 
			m_size="";
			//alert(ObjVal);
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=Pf_Blur_new&PF_value="+ObjVal+" ";
			
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
			
		//	 top.frames[0].document.applets[0].getdata(m_url);
		//	m_size= top.frames[0].document.applets[0].outvec_value.size();
			//alert(m_size); 
			if(m_size<=0){
				if (confirm("Invalid Portpolio Code. Press OK For Help")){
					portP_help(0);
					document.Form1.TXT_portfolio.value="";
					
					
				}
				else{
					document.Form1.TXT_portfolio.value="";
				}
			}else{
				pf_name.innerHTML= top.frames[0].document.applets[0].outvec_value.elementAt(2);
			}
		}
		
	
		
		//---------------------- Added by S.Shanheetha on 07-06-2007 ----- --------------------------------
		
		function checkmargintradingdate(dayobj,monthobj,yearobj) {
			buy_sett_date=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
			
			//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buy_sett_date="+buy_sett_date+"&chksql=chk_margin_trading_date_with_value_date";
			  m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buy_sett_date="+buy_sett_date+"&chksql=chk_buy_sett_date_check"; //chk_buy_sett_date			
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
			
			document.Form1.HID_BUY_SETT_DATE.value=data_vec[0];
			
			if(document.Form1.HID_BUY_SETT_DATE.value=="YES"){
			//	alert("Value Date should be greater than Last Margin Trading Routine Date. Please Re-Enter the Value Date!");
				alert("Value Date is not greater than Last Day End Routine Date or daily margin trading date , Please Re-Enter the Value Date !.");	
				dayobj.value=" ";	monthobj.value=" ";yearobj.value=" ";dayobj.focus();
			}
			else{
				
			}
		}	
		
		function checkbankingdate(dayobj,monthobj,yearobj) {
			buy_sett_date=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
			
		  //m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buy_sett_date="+buy_sett_date+"&chksql=chk_margin_trading_date_with_value_date";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buy_sett_date="+buy_sett_date+"&chksql=chk_buy_sett_date_check"; //chk_buy_sett_date						
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
			
			document.Form1.HID_BUY_SETT_DATE.value=data_vec[0];
			
			if(document.Form1.HID_BUY_SETT_DATE.value=="YES"){
			//	alert("	Banking Date should be greater than Last Margin Trading Routine Date. Please Re-Enter the 	Banking Date!");
				alert("Value Date is not greater than Last Day End Routine Date or daily margin trading date , Please Re-Enter the Value Date !.");	
				dayobj.value=" ";	monthobj.value=" ";yearobj.value=" ";dayobj.focus();
			}
			else{
				
			}
		}	
		
		
		
		function checkRealizationdate(dayobj,monthobj,yearobj) {
			buy_sett_date=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
			
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buy_sett_date="+buy_sett_date+"&chksql=chk_margin_trading_date_with_value_date";
						
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
			
			document.Form1.HID_BUY_SETT_DATE.value=data_vec[0];
			
			if(document.Form1.HID_BUY_SETT_DATE.value=="YES"){
				alert("	Realization Date should be greater than Last Margin Trading Routine Date. Please Re-Enter the 	Realization Date!");
				dayobj.value=" ";	monthobj.value=" ";yearobj.value=" ";dayobj.focus();
			}
			else{
				
			}
		}
		//----------------------- End of Modifications on 07-06-2007 -----------------------------------
		
	
		
		/*-- comment by prabash on 31-08-2011-----------------------**
		
		function portP_help(ObjVal){
			m_portfcode=ObjVal; 
			m_size="";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=Pf_help_new&PF_value="+ObjVal+" ";
			//window.open(m_url);		
			// top.frames[0].document.applets[0].getdata(m_url);
			//m_size= top.frames[0].document.applets[0].outvec_value.size();
			
			load_interface(m_url,'XML',false);
		    m_size=data_vec.length;
			
			vec_pos=0;
			lineno=1;
			m_row="";
			while (vec_pos<m_size) {
				m_pfCode = data_vec[vec_pos];    //top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
				m_type   = data_vec[vec_pos+1];  //top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
				m_pf_Name= data_vec[vec_pos+2];//top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2);
				//m_trn_amount=document.applets[0].outvec_value.elementAt(vec_pos+3);
				m_CDS_NO= data_vec[vec_pos+3];//top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+3);
				m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+' ALIGN="LEFT" ><B>'+m_pfCode+'</B></TD><TD ID=C2R'+	lineno+' ALIGN="CENTER" ><B>'+m_type+'</B></TD><TD ID=C3R'+	lineno+' ALIGN="LEFT" ><B>'+m_pf_Name+'</B></TD><TD ID=C4R'+	lineno+' ALIGN="LEFT" ><B>'+m_CDS_NO+'</B></TD></TR>';																							
				vec_pos=vec_pos+4;
				lineno=lineno+1;
			}
			m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color: white; font: 9pt arial;}">'+            
				'<TR BGCOLOR="darkblue"><TD WIDTH="25%"><B>Client Code</B></TD>' +
				'<TD WIDTH="10%" ALIGN="CENTER"><B>Type</B></TD>' +
				'<TD WIDTH="50%"><B>Client Name</B></TD>' +
				'<TD WIDTH="15%"><B>CDS NO.</B></TD></tr>' +
				m_row+
				'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval = "";
			var helpvalue="";
			
			popupwin = window.showModalDialog("<%=m_jsp_client_url%>/help_box2.jsp",myDialogObj,"dialogWidth:30em; dialogHeight:15em; center:yes; resizable:yes; status:no");
			helpvalue=  top.frames[0].document.applets[0].outvec_value.indexOf(myDialogObj.returnval);
			
			if (helpvalue != 1) {
				document.Form1.TXT_portfolio.value= top.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+0);
				pf_name.innerHTML= top.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+2);
			}
			
			else { 
				if (helpvalue==1){
				}
			}
			
		}
		
	*/  //----------------------------------------------------------**
	//--------added by ---Prabash on 31-08-2011---------------------**
	function portP_help(m_strat)
			{
     var aForm;    //  aForm =oForm.elements;
     aForm =  document.getElementById('Form1');
	 /*  var myObject = new Object();
   	 myObject.firstName = aForm.oFirstName.value;
   	 myObject.lastName = aForm.oLastName.value;
		*/
	
 	var myObject=new Array(); //return values set to this object
 	myObject[0]=aForm.TXT_portfolio;
	myObject[1]=aForm.TXT_client_name;
 	myObject[2]=null;
 	myObject[3]=null;
 	myObject[4]=null;
  
 	var myObject_value=new Array(); //passing values set to this object
 	myObject_value[0]=aForm.TXT_portfolio.value;
 	myObject_value[1]=aForm.TXT_portfolio.value;//aForm.oLastName2.value;
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
		
		//--------------------------------------------**
		
		/*----------comment by prabash on 31-08-31-----------**
		function portP_help_mod(){
			m_portfcode=""; 
			m_size="";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=Pf_help_dip_mod";
			//window.open(m_url);		
			 top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();				
			
			vec_pos=0;
			lineno=1;
			m_row="";
			while (vec_pos<m_size) {
				
				m_doc_ref =top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
				m_pf_code =top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
				m_pf_name   =top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2);
				//m_trn_amount=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+3);
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
				document.Form1.TXT_payee.value=top.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+7);
				document.Form1.TXT_chqno.value=top.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+8);
				document.Form1.TXT_amount.value=top.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+9);
				document.Form1.TXT_DATE.value=top.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+10).substring(0,2);
				document.Form1.TXT_MONTH.value=top.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+10).substring(3,5);
				document.Form1.TXT_YEAR.value=top.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+10).substring(6,10);
				
				//01-01-2011	
			}
			
			else { 
				if (helpvalue==1){
				}
			}
			
		}
		
		*/   //----------------------------------------------**
		
		//----------added by prabash o 31-08-2011------------**
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
 		myObject[2]=aForm.TXT_client_name;
 		myObject[3]=null;
		myObject[4]=null;
 		myObject[5]=null;	
		myObject[6]=aForm.TXT_bank_code;
 		myObject[7]=aForm.TXT_ACC_number;
 		myObject[8]=aForm.TXT_payee;
 		myObject[9]=aForm.TXT_chqno;
 		myObject[10]=aForm.TXT_amount;
		myObject[11]=aForm.TXT_DATE;
		myObject[12]=aForm.TXT_MONTH;
		myObject[13]=aForm.TXT_YEAR;
		myObject[14]=aForm.TXT_desc;
		
		myObject[15]=aForm.BANK_TXT_DAY;
		myObject[16]=aForm.BANK_TXT_MONTH;
		myObject[17]=aForm.BANK_TXT_YEAR;	
        myObject[18]=aForm.TXT_CAP_TYPE;
		myObject[19]=aForm.TXT_CAP_MODE;
  
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
 		var qid='5';
		var hid='9';	
     
 		var url = 'popup.jsp';
 		var json_text = JSON.stringify(myObject_value, null,0);
 		var json_obj_type_text=JSON.stringify(myObject_type, null,0);
 		//var fn_name=arguments.callee.name;
		var fn_name=arguments.callee.name;
			
		if(fn_name==undefined){
		re = /^function\s+([^(]+)/;
        fn_name=re.exec(arguments.callee.toString())[1];
		}	
					
       	$.showModalDialog({
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&hid='+hid,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400,// 500,
		 width: 700,//900,
		 title: 'SasiNet',		  
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
	}
			
		//---------------------------------------------------**
		function bank_help_single(){
			
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=set_opt_help_button&bankcode="+document.Form1.TXT_bank_code.value ;
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			
			
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
			
			//alert(m_size);
			lineno=1;
			if(m_size==2) {
				document.Form1.TXT_bank_code.value=data_vec[0];
				document.Form1.TXT_ACC_number.value=data_vec[1]; 
				
			}
		}
		
	/*-------comment by prabash on 31-08-2011---------------------**
		function bank_help() {
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=set_opt_help_button&bankcode="+document.Form1.TXT_bank_code.value ;
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
			vec_pos=0;
			m_row="";
			lineno=1;
			while (vec_pos<m_size) {
				m_bank_code=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
				m_bank_desc=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1); 
				m_row=m_row+'<TR STYLE="{color:black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+',C2R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_bank_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_bank_desc+'</B></TD></TR>';
				vec_pos=vec_pos+2;
				lineno=lineno+1;
			}
			
			m_writedata ='<TABLE BGCOLOR="siler" WIDTH="100%" STYLE="{color: darkblue; font: 9pt sans-serif;}">'+
				'<TR BGCOLOR="silver"><TD WIDTH="20%"><B>Bank Code</B></TD>' +
				'<TD WIDTH="75%"><B>Accounts Number</B></TD></TR>'+
				m_row+
				'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval1 = "";
			myDialogObj.returnval2 = "";
			helpvalue="";
			popupwin = window.showModalDialog(html_client_url+"/help_box4.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no"); 
			helpvalue= top.frames[0].document.applets[0].outvec_value.indexOf(myDialogObj.returnval);
			
			if (helpvalue != 1) {
				document.Form1.TXT_bank_code.value =myDialogObj.returnval1;
				document.Form1.TXT_ACC_number.value=myDialogObj.returnval2;
			}
			
			else { 
				if (helpvalue==1){
				}
			}
			
		}
		*/ //-----------------------------------------------------**
		
		//------- aded by prabash on  31-08-2011----------------------------**
		
		function bank_help(m_strat) {
			var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	 /*  var myObject = new Object();
   	 myObject.firstName = aForm.oFirstName.value;
   	 myObject.lastName = aForm.oLastName.value;
		*/
		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.TXT_bank_code;
 		myObject[1]=aForm.TXT_ACC_number;
 		myObject[2]=null;
 		myObject[3]=null;
 		myObject[4]=null;
  
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.TXT_bank_code.value;
 		myObject_value[1]=aForm.TXT_ACC_number.value;//aForm.oLastName2.value;
 		myObject_value[2]=null;
 		myObject_value[3]=null;
 		myObject_value[4]=null;
 
 
 		var myObject_type=new Array(); //passing values data type
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
			
		//JSON.parse(str) 
		//alert(json_text);
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
		//--------------------------------------------------**
			
	
		
		function payee_bank_help_single() {
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=payee_bankacc&bankcode="+document.Form1.TXT_payee.value ;			
			
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
			
			if(m_size=2){
				
				document.Form1.TXT_payee.value=data_vec[0];
				
				
			}	
			
		}
		
		/* ----------- comment by prabash on 31-08-2011---------------**
		function payee_bank_help() {
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=payee_bankacc&bankcode="+document.Form1.TXT_payee.value ;			
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
			vec_pos=0;
			m_row="";
			lineno=1;
			//window.open(m_url);
			while (vec_pos<m_size) {
				m_bank_code=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
				m_bank_desc=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1); 
				m_row=m_row+'<TR STYLE="{color:black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+',C2R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_bank_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_bank_desc+'</B></TD></TR>';
				vec_pos=vec_pos+2;
				lineno=lineno+1;
			}
			
			m_writedata ='<TABLE BGCOLOR="siler" WIDTH="100%" STYLE="{color: darkblue; font: 9pt sans-serif;}">'+
				'<TR BGCOLOR="silver"><TD WIDTH="20%"><B>Bank Code</B></TD>' +
				'<TD WIDTH="75%"><B>Branch Name</B></TD></TR>'+
				m_row+
				'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval1 = "";
			//myDialogObj.returnval2 = "";
			helpvalue="";
			popupwin = window.showModalDialog(html_client_url+"/help_box4.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no"); 			
			document.Form1.TXT_payee.value =myDialogObj.returnval1;
		}
		*/    //-----------------------------------------------**
		
		// added by prabash on 31-08-2011----------------------**
		function payee_bank_help(m_strat) {
			var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	 /*  var myObject = new Object();
   	 myObject.firstName = aForm.oFirstName.value;
   	 myObject.lastName = aForm.oLastName.value;
		*/
		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.TXT_payee;
 		myObject[1]=null;
 		myObject[2]=null;
 		myObject[3]=null;
 		myObject[4]=null;
  
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.TXT_payee.value;
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
 
 		var qid='3';

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
		 height:400,// 500,
		 width: 400,//900,
		 title: 'SasiNet Frame work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
		}
		//-----------------------------------------------------------**
		
		function clearAll(){
			document.Form1.TXT_portfolio.value="";
			document.Form1.TXT_bank_code.value="";
			document.Form1.TXT_ACC_number.value="";
			document.Form1.TXT_chqno.value="";
			document.Form1.TXT_desc.value="";
			document.Form1.TXT_payee.value="";
			document.Form1.TXT_amount.value="";
		     document.Form1.TXT_client_name.value="";	
			document.Form1.TXT_DATE.value= "";
			document.Form1.TXT_MONTH.value= "";
			document.Form1.TXT_YEAR.value= "";
			
			document.Form1.BANK_TXT_DAY.value= "";
			document.Form1.BANK_TXT_MONTH.value= "";
			document.Form1.BANK_TXT_YEAR.value= "";
			
			//pf_name.innerHTML="";
		}
		
		/*---------------
		function BeforeSave(){
		
			
			// Added by Shanheetha on 07-07-2006 - SR0607-017 
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
				
				
				
				//   End on 07-07-2006 
				
				
				document.Form1.save_but.disabled=true;
				document.Form1.TXT_bank_code.disabled=false;
				document.Form1.TXT_ACC_number.disabled=false;
				
				//--------------- Added by S.Shanheetha on 07-06-2007 -----------------
				
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
				
				//---------------- End of Modifications on 07-06-2007 -------------------------
				
				
				
				
				Form1.submit();
				
			} // Added by Shanheetha on 07-07-2006 - SR0607-017 
		}
		*/      //---------------
		
		//----------PRABASH----------------------------
		function BeforeSave(){
			
			
			dayobj=document.Form1.TXT_DATE;
			monthobj=document.Form1.TXT_MONTH;
			yearobj=document.Form1.TXT_YEAR;
			unformat(document.Form1.TXT_amount);
			
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
			else{
				
			/*	
				
			
				
				
				document.Form1.save_but.disabled=true;
				document.Form1.TXT_bank_code.disabled=false;
				document.Form1.TXT_ACC_number.disabled=false;
				
				//--------------- Added by S.Shanheetha on 07-06-2007 -----------------
				
				dayobj=document.Form1.TXT_DATE;
				monthobj=document.Form1.TXT_MONTH;
				yearobj=document.Form1.TXT_YEAR;
				buy_sett_date=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
				//alert(1111);
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buy_sett_date="+buy_sett_date+"&chksql=chk_margin_trading_date_with_value_date";
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
				
			//	alert(2222);
				document.Form1.HID_BUY_SETT_DATE.value=data_vec[0];
				
			//	alert(document.Form1.HID_BUY_SETT_DATE.value);
				if(document.Form1.HID_BUY_SETT_DATE.value=="NO"){
					alert("Value Date should be greater than Last Margin Trading Routine Date. Please Re-Enter the Value Date!");
					dayobj.value=" ";	monthobj.value=" ";yearobj.value=" ";dayobj.focus();
				}
				else{
				
				
				*/
					//alert(3333);
					Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsavsett_temp";
				
				}

//---------------- End of Modifications on 07-06-2007 -------------------------


				for(var i = 0; i < document.Form1.elements.length; i++) {
					document.Form1.elements[i].disabled = false;
					
					if(document.Form1.elements[i].type == 'text' ||  document.Form1.elements[i].type == 'hidden'){
						document.Form1.elements[i].value = unformat_noobject(document.Form1.elements[i].value); 
					}
					
				}
				
				
				Form1.submit();
				
		//	} /* Added by Shanheetha on 07-07-2006 - SR0607-017 */
		}
		//-------------------------------------------------------------------------*
		/* ============= Added by Shanheetha on 07-07-2006 for SR0607-017 ============================================================= */
		function checkbuyersettlementdate(dayobj,monthobj,yearobj) {
			buy_sett_date=dayobj.value+'/'+monthobj.value+'/'+yearobj.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buy_sett_date="+buy_sett_date+"&chksql=chk_buy_sett_date_22";//CHANGE BY WARUNA 2011-02-14 chk_buy_sett_date
			load_interface(m_url,'XML',false);
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			m_size = data_vec.length;
			
			document.Form1.HID_BUY_SETT_DATE.value=data_vec[0];
			
			if(document.Form1.HID_BUY_SETT_DATE.value=="YES"){
				alert("Value Date is not greater than Last Day End Routine Date, Please Re-Enter the Value Date !.");
				dayobj.value=" ";	monthobj.value=" ";yearobj.value=" ";dayobj.focus();
			}
			else{
				
			}
		}
		/* ==================== End for SR0607-017 ================================================================================ */
		
		
		
		
		function myDialogObj() {
			var htmlstr; 
			var returnval;
			var	returnval1;
			var	returnval2;
		}
		
		function chkstartdate(dayobj,monthobj,yearobj) {
			checkMonthLength(dayobj,monthobj,yearobj);		
		}
		
		function display_dat(){
		//	alert( data_vec.length);	
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=get_dat";
			//window.open(m_url);
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
			
			if(m_size>0){	
				/*document.Form1.TXT_DATE.value= top.frames[0].document.applets[0].outvec_value.elementAt(0).substring(0,2);
				document.Form1.TXT_MONTH.value= top.frames[0].document.applets[0].outvec_value.elementAt(0).substring(3,5);
				document.Form1.TXT_YEAR.value= top.frames[0].document.applets[0].outvec_value.elementAt(0).substring(6,10);
				*/
				document.Form1.TXT_DATE.value= data_vec[0].substring(0,2);
				document.Form1.TXT_MONTH.value= data_vec[0].substring(3,5);
				document.Form1.TXT_YEAR.value= data_vec[0].substring(6,10);
			}
			else{
			}
			
			<% if(request.getParameter("reci_no")!=null){ 
			   out.println("if(true){");
			     }else{
			   out.println("if(false){");
			   }
			
			%>
			m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"report_portf_charges_save?reci_no=<%=request.getParameter("reci_no")%>&port=<%=request.getParameter("port")%>&chksql=deposit_temp";
			pop_up_message_2(m_url);	
			<% 
			 out.println("}");
			
		%>
		}
		
		
			
		
		
		function obtain_report_before() {
			m_url=jsp_client_url+'/dn_capitaldeposit_obtain.jsp';
			//popupwin = window.open(m_url,'displayWindow', 'top=200, left=100, width=600, height=200, scrollbars=no, menubar=No, resizable=no, fullscreen=No');
		   pop_up_message_3(m_url)
		
		}
		
		function chk_recno(){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?bankcode="+document.Form1.TXT_payee.value+"&chksql=payee_bank";
			
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
			
			//top.frames[0].document.applets[0].getdata(m_url);
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			
			if (m_size>0) {
				document.Form1.TXT_payee.value=data_vec[0]
			}
			else{
				if (confirm("Invalid Number..Press the OK button if you want a list of Codes or Press the Cancel button to type again")) {
					payee_bank_help(0);
				}
				else{
					document.Form1.TXT_payee.value="";
				}
			}	
		}
		function format(obj){
			obj.value=format_noobject(obj.value);
			
		}
		function unformat(obj){
			obj.value=unformat_noobject(obj.value);
			
		}
		
		function display_sec_opt(m_val){
			
			//document.Form1.SAVETYPE.value=parent.frames[0].document.Form1.SCR_TYPE.options[parent.frames[0].document.Form1.SCR_TYPE.selectedIndex].value;
		//	if(document.Form1.SCR_TYPE.options[document.Form1.SCR_TYPE.selectedIndex].value=='NEW'){
				clearAll();
			  if(m_val=="new"){	
			//	alert('44');
			    document.Form1.Hid_scr_name.value='cap_deposit_save';
			//	alert(document.Form1.Hid_scr_name.value);	
				}
			else if(m_val=="mod"){ 
			//	alert('45');
			   clearAll();
				document.Form1.Hid_scr_name.value='cap_deposit_mod';
				//alert(document.Form1.Hid_scr_name.value);
			  }
			else if(m_val=="del"){ 
			//	alert('46');
			   clearAll();
				document.Form1.Hid_scr_name.value='cap_deposit_del';
				//alert(document.Form1.Hid_scr_name.value);
			  }
			else{
				alert('Please Select Add/Modify/Delete');
			}

		}	
		
		
		function portP_help_new(){
		
			
			if(document.Form1.Hid_scr_name.value=="cap_deposit_save"){
			//	alert('55');
			//	portP_help(document.Form1.TXT_portfolio.value);
				portP_help(0);
				
			}else if (document.Form1.Hid_scr_name.value=="cap_deposit_mod"){
			//	alert('56');
				portP_help_mod(0);
				
			}else if (document.Form1.Hid_scr_name.value=="cap_deposit_del"){
			//	alert('57');
				portP_help_mod(0);
			}else{
				alert('Please Select Add/Modify/Delete');
			}
		}
		function close_portP_help(){
		//alert('fff');
		}
//--test function comment by prabash on 31-08-2011--------------**		
/*		
function test3(m_strat) 
{
     var aForm;    //  aForm =oForm.elements;
     aForm =  document.getElementById('Form1');
  // var myObject = new Object();
 //   myObject.firstName = aForm.oFirstName.value;
  //  myObject.lastName = aForm.oLastName.value;

 var myObject=new Array(); //return values set to this object
 myObject[0]=aForm.TXT_portfolio;
 myObject[1]=null;
 myObject[2]=null;
 myObject[3]=null;
 myObject[4]=null;
  
 var myObject_value=new Array(); //passing values set to this object
 myObject_value[0]=aForm.TXT_portfolio.value;
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
 
 var qid='1';

 var url = 'popup.jsp';
 var json_text = JSON.stringify(myObject_value, null,0);
 var json_obj_type_text=JSON.stringify(myObject_type, null,0);
 var fn_name=arguments.callee.name;
//JSON.parse(str) 
//alert(json_text);
       	$.showModalDialog({
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400,// 500,
		 width: 500,//900,
		 title: 'SasiNet Frame work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
	});
}
*/  //-------------------------------------------------------**
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
		function changeReceiptMode(){
	
		    if(document.getElementById('TXT_CAP_MODE').value=='CHEQUE'){
			  document.getElementById('div_value_date').innerHTML='Cheque Realization Date';
			  document.getElementById('div_banking_date').style.visibility = 'visible';	
			  document.getElementById('div_txt_banking_date').style.visibility = 'visible';	
			}else{
			  document.getElementById('div_value_date').innerHTML='Value Date';
			  document.getElementById('div_banking_date').style.visibility = 'hidden';	
			  document.getElementById('div_txt_banking_date').style.visibility = 'hidden';	
			}
			
		}
		
	</SCRIPT>
	
	<BODY onload="display_dat();" class='body & txt-body' >
		<FORM NAME="Form1" ID="Form1" METHOD="POST" >
			<INPUT TYPE="Hidden" NAME="Hid_ACC_TYPE"	VALUE="DEPOSIT">
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="cap_deposit_save">
			<INPUT TYPE="Hidden" NAME="HID_BUY_SETT_DATE" VALUE="" >
			<INPUT TYPE="Hidden" NAME="HID_DOC_REF_NO" VALUE="" >
			
			<DIV>
			<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
				<tr>
			<td height='7'></td>
			</tr>
				
			<tr height='30' >
			<td  width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
			<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Margin Trading - Receipt Management</B></td>
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
						<INPUT TYPE="Button" NAME="save_but" VALUE="Save"   onClick="BeforeSave()" class="mainbut"  >
					</TD>
					
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"   onClick="clearAll()" class="mainbut"> 
				</TD>
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit"   onClick="top.frames[1].location.href='low.jsp'" class="mainbut"> 
					</TD>
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="report_but" VALUE="Enquiry"    onClick="obtain_report_before()" class="mainbut">
						
					</TD>
					<TD  WIDTH="50%" class="hh1" align="right">
						<B>Capital Deposit</B>
					</TD>					
				</TR>
			</TABLE>
						<!--prabash-->
						
						<!----------->
			
			    <TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
			<HR>
				<TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
			
			<BR>	
			<TABLE WidTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0"  >   					
				<tr>
					<TD WidTH="1%">
						<TD WidTH="*%">
										
										
							<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
		  <TR>
									<TD WIDTH="1%"></TD>
									<TD WidTH="20%">Receipt Type</TD>			
									<td>
                                                               <select class = "txt_input" id = "TXT_CAP_TYPE" name = "TXT_CAP_TYPE" style = "width: 125px;">
                                                                   <option value = "001">Interest Payment</option>
                                                                    <option value = "002">Initial Deposit</option>
                                                                   <option value = "003" selected >Client Deposit</option>
                                                                   <option value = "004">Initial Charges</option>
                                                                   <option value = "005">Documentation Fees</option>
													               <option value = "006">Cheque Return Settlement</option>
                                                               </select>
                                   </td>
								  <TD WIDTH="1%">&nbsp;</TD>
								 <TD WIDTH="20%">&nbsp;</TD>
								 <TD WIDTH="20%">&nbsp;</TD>					
												
			</TR>	
		
									
									

		  <TR>
				<TD WIDTH="1%"></TD>
									<TD WidTH="20%">Receipt Mode</TD>
												
									<td WIDTH="20%">
                                                               <select class = "txt_input" id = "TXT_CAP_MODE" name = "TXT_CAP_MODE" style = "width: 125px;" onchange="changeReceiptMode()">
                                                                    <option value = "CASH">Cash</option>
														            <option value = "CHEQUE" SELECTED >Cheques</option>
                                                                    <option value = "PAY_ORDER">Pay Order</option>
                                                                    <option value = "BANK_TRANF">Bank Transfers</option>
                                                                  <!-- <option value = "RTGS">RTGS Transfer</option>-->
                                                                 
                                                              </select>
                                     </td>
									<TD WIDTH="1%">&nbsp;</TD>
									<TD WIDTH="20%">&nbsp;</TD>
								    <TD WIDTH="20%">&nbsp;</TD>			
										
												
			</TR>	
					
							
							
								<TR>
									<TD WIDTH="1%">&nbsp;</TD>
									<TD WidTH="10%">Facility Codes</TD>
									<TD WidTH="30%" align="Left"><INPUT TYPE="Text" NAME="TXT_portfolio"	ALIGN="LEFT" SIZE=20 TABINDEX=1 OnBlur="Blur_porpolio(document.Form1.TXT_portfolio.value)" class="txt_input6" >
										<INPUT TYPE="button" VALUE=" ... " NAME="BUT_INSTYPE"   OnClick="portP_help_new()" class="but_input"><!--portP_help(document.Form1.TXT_portfolio.value) -->
									</TD>
									<TD WIDTH="1%">&nbsp;</TD>
									<TD WidTH="20%" align="left" >Client Name</TD>			
									<TD WIDTH="20%"><INPUT TYPE="Text" NAME="TXT_client_name"	ALIGN="LEFT" SIZE=20 TABINDEX=1  class="txt_input6" disabled >	</TD>	
									<TD WIDTH="10%"></TD>
											</TR>	
								
							
							<!-- <TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0" STYLE="{color: black; font: bold 10pt arial;}">
							<TR>
							<TD WIDTH="1%"></TD>
							<TD WidTH="20%">Transaction Type</TD>
							<TD WidTH="69%"><SELECT NAME ="TXT_acc_type" >
							<OPTION VALUE="D" >Deposit</option> 
							<OPTION VALUE="W" SELECTED>Withdrawal</option>
							</SELECT></TD> 
							</TR>	
							</TABLE>	-->
							
							
								<TR>
									<TD WIDTH="1%">&nbsp;</TD>
									<TD WidTH="10%">Description</TD>
									<TD WidTH="30%"><INPUT TYPE="Text" NAME="TXT_desc"	ALIGN="LEFT" SIZE=20 TABINDEX=2   maxlength="50" onBlur='bank_help_single();payee_bank_help_single();' class="txt_input6"  ></TD><!-- ADD MAX LENGTH BY WARUNA 2011-05-09-->
								</TR>	
								
							
									<TR>
										<TD WIDTH="1%"></TD>
										<TD WidTH="20%">Licencee Bank Code</TD>
										<TD WidTH="30%"><INPUT TYPE="Text" NAME="TXT_bank_code"	ALIGN="LEFT" SIZE=20  disabled class="txt_input6"  ><!--/TD>
										<TD WIDTH="*%"-->
											<INPUT TYPE="button" VALUE=" ... " NAME="BUT_INSTYPE"   OnClick="bank_help(0)" class="but_input" ></TD>
								
										<TD WIDTH="1%">&nbsp;</TD>
										<TD WidTH="20%"  align="left"  >Licencee Accounts Number</TD>
										<TD WidTH="21%"><INPUT TYPE="Text" NAME="TXT_ACC_number"	ALIGN="LEFT" SIZE=20  disabled class="txt_input6" ></TD>
										<TD WidTH="20%"></TD>
									</TR>	
									
							
									<TR>
										<TD WIDTH="1%">&nbsp;</TD>
										<TD WidTH="20%">Payee Bank Code</TD>
										<TD WidTH="30%"><INPUT TYPE="Text" NAME="TXT_payee"	ALIGN="LEFT" SIZE=20 ONBLUR="chk_recno()" class="txt_input6" ><!--/TD>
										<TD WIDTH="*%"-->
											<INPUT TYPE="button" VALUE=" ... " NAME="BUT_INSTYPE"   OnClick="payee_bank_help(0)" class="but_input" ></TD>
									    <TD WIDTH="1%">&nbsp;</TD>
									</TR>	
								
								
									<TR>
										<TD WIDTH="1%">&nbsp;</TD>
										<TD WidTH="20%">Cheque No</TD>
										<TD WidTH="30%"><INPUT TYPE="Text" NAME="TXT_chqno"	ALIGN="LEFT" TABINDEX=3 SIZE=20 class="txt_input6"  ></TD>
									    <TD WIDTH="1%">&nbsp;</TD>
									</TR>	
								
									<TR>
										<TD WIDTH="1%"></TD>
										<TD WidTH="20%">Amount</TD>
										<TD WidTH="30%"><INPUT TYPE="Text" NAME="TXT_amount"	 TABINDEX=4 ALIGN="RIGHT" SIZE=20  ONBLUR="format(document.Form1.TXT_amount)" class="txt_input7"  ></TD>
                                        <TD WIDTH="1%">&nbsp;</TD>									
									</TR>	
								
									<TD WIDTH="1%">&nbsp;</TD>
									<TD WIDTH="20%"><DIV id='div_value_date'>Cheque Realization Date</DIV><!--Value Date--></TD>
									<TD WIDTH="30%"><INPUT TYPE="Text" NAME="TXT_DATE" SIZE=3 MAXLENGTH=2 class="txt_input5" >
										<INPUT TYPE="Text" NAME="TXT_MONTH" SIZE=3 MAXLENGTH=2 class="txt_input5 ">
									<!--<INPUT TYPE="Text" NAME="TXT_YEAR" SIZE=4 MAXLENGTH=4 ONBLUR="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR);checkbuyersettlementdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR);checkmargintradingdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR);" class="txt_input5" > -->								
										<INPUT TYPE="Text" NAME="TXT_YEAR" SIZE=4 MAXLENGTH=4 ONBLUR="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR);checkmargintradingdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR);" class="txt_input5" > 
										
									<input type = "hidden" name = "VAL_TXT_DATE" id = "VAL_TXT_DATE" />
									<TD WIDTH="1%">&nbsp;</TD>	
											
																
										</tr>
											
									</TR>	
								
									<TD WIDTH="1%">&nbsp;</TD>
									<TD WIDTH="20%"><DIV id='div_banking_date'>Banking Date</DIV></TD>
									<TD WIDTH="30%">
										<DIV id='div_txt_banking_date'>	
										<INPUT TYPE="Text" NAME="BANK_TXT_DAY"  SIZE=3 MAXLENGTH=2 class="txt_input5" >
										<INPUT TYPE="Text" NAME="BANK_TXT_MONTH" SIZE=3 MAXLENGTH=2 class="txt_input5 ">
										<INPUT TYPE="Text" NAME="BANK_TXT_YEAR"  SIZE=4 MAXLENGTH=4 ONBLUR="chkstartdate(document.Form1.BANK_TXT_DAY,document.Form1.BANK_TXT_MONTH,document.Form1.BANK_TXT_YEAR);checkbankingdate(document.Form1.BANK_TXT_DAY,document.Form1.BANK_TXT_MONTH,document.Form1.BANK_TXT_YEAR);" class="txt_input5" > 								
										<input type = "hidden" name = "BANK_TXT_DATE" id = "BANK_TXT_DATE" />
										</DIV>	
									<TD WIDTH="1%">&nbsp;</TD>	
									<TD WIDTH="20%"><!--Cheque Realization Date--></TD>
									<TD WIDTH="30%">
										<!--<INPUT TYPE="Text" NAME="CHEQUE_REALIZATION_TXT_DAY" SIZE=3 MAXLENGTH=2 class="txt_input5" >
										<INPUT TYPE="Text" NAME="CHEQUE_REALIZATION_TXT_MONTH" SIZE=3 MAXLENGTH=2 class="txt_input5 ">
										<INPUT TYPE="Text" NAME="CHEQUE_REALIZATION_TXT_YEAR" SIZE=4 MAXLENGTH=4 ONBLUR="chkstartdate(document.Form1.CHEQUE_REALIZATION_TXT_DAY,document.Form1.CHEQUE_REALIZATION_TXT_MONTH,document.Form1.CHEQUE_REALIZATION_TXT_YEAR);checkRealizationdate(document.Form1.CHEQUE_REALIZATION_TXT_DAY,document.Form1.CHEQUE_REALIZATION_TXT_MONTH,document.Form1.CHEQUE_REALIZATION_TXT_YEAR);" class="txt_input5" > 								
										<input type = "hidden" name = "CHEQUE_REALIZATION_TXT_DATE" id = "CHEQUE_REALIZATION_TXT_DATE" />	
										-->	
											</TD>			
										</tr>		
					
								</TABLE><!--prabash-->
									
			
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
			
