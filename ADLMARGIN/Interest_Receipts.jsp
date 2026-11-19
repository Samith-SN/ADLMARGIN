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
			
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
        out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
			
	    %>
	
	
	<SCRIPT language="JavaScript1.2" >
	
	function myDialogObj() {
		var htmlstr; 
 		var returnval;
		var	returnval1;
		var	returnval2;
  	}


// ***********************************************************************************		
// ************* Start New Help ******************************************************	
// ***********************************************************************************	

	// Portfolio Help
		
	function portP_help(m_strat){
		
	    var aForm;    //  aForm =oForm.elements;		
	    aForm = document.getElementById('Form1');
		
	 	var myObject=new Array(); //return values set to this object
	 	myObject[0]=aForm.TXT_portfolio;
		myObject[1]=null;
		myObject[2]=null;
		myObject[3]=null;
	  
	 	var myObject_value=new Array(); //passing values set to this object
	 	myObject_value[0]=aForm.TXT_portfolio.value;
		myObject_value[1]=aForm.TXT_portfolio.value;
		myObject_value[2]=null;
		myObject_value[3]=null;
	 
	 	var myObject_type=new Array(); //passing values data type
	 	myObject_type[0]="StringL";
		myObject_type[1]="StringL";
		myObject_type[2]=null;
		myObject_type[3]=null;
	 
	 	var qid='11';
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
		
	} // End portP_help
		
	
	// Bank Help
		
	function bank_help(m_strat) {
		
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');

		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.TXT_bank_code;
 		myObject[1]=aForm.TXT_lice_acc_no;
 		myObject[2]=null;
 		myObject[3]=null;
 		myObject[4]=null;
  
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.TXT_bank_code.value;
 		myObject_value[1]=aForm.TXT_lice_acc_no.value;//aForm.oLastName2.value;
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

       	$.showModalDialog({
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400,// 500,
		 width: 400,//900,
		 title: 'SasiNet Frame work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
		
	}	// End bank_help
		
		
	// Reference No. Help
		
	function ref_no_help(m_strat){
		
	    var aForm;    //  aForm =oForm.elements;		
	    aForm = document.getElementById('Form1');
		
	 	var myObject=new Array(); //return values set to this object
	 	myObject[0]=aForm.TXT_ref_no;
		myObject[1]=aForm.TXT_amount;
		myObject[1]=aForm.Hid_amount;
	  
	 	var myObject_value=new Array(); //passing values set to this object
	 	myObject_value[0]=aForm.TXT_ref_no.value;
		myObject_value[1]=aForm.TXT_ref_no.value;
	 
	 	var myObject_type=new Array(); //passing values data type
	 	myObject_type[0]="StringL";
		myObject_type[1]="StringL";
	 
	 	var qid='12';
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
		
	} // End ref_no_help
		
		
	function close_portP_help(){
		//alert('fff');
	}
		

// *********************************************************************************			
// ************ End New Help *******************************************************		
// *********************************************************************************	
		
		
		
		
		
		
		

//********************************************** Reference Number Help ( On Blur & On Click ) **************************************************************************
	
	function Blur_ref_no(ObjVal1,ObjVal2){
				
				m_ref_no=ObjVal1; 
				m_port=ObjVal2;
				m_size="";
			
		    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=Ref_Blur&REF_value="+m_ref_no+"&PORT_value="+m_port+" ";
				//alert(m_url);
				top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
					if(m_size<=0){
							if (confirm("Invalid Reference Number. Press OK For Help")){
							 ref_no_help(m_ref_no,m_port);
							}
							else{
							document.Form1.TXT_ref_no.value="";
							}
					}		
	}
	
	/*
	function ref_no_help(ObjVal1,ObjVal2){
				m_ref_no=ObjVal1;
				m_port=ObjVal2;
				m_size="";
		    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=ref_no_help&REF_value="+m_ref_no+"&PORT_value="+m_port+" " ;
				top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
			 //	alert(top.frames[0].document.applets[0].outvec_value);
				vec_pos=0;
				lineno=1;
				m_row="";
							while (vec_pos<m_size) {
								m_ref_no =top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
								m_amount =top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
								m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help_new(C1R'+lineno+',C2R'+lineno+'); ><TD ID=C1R'+	lineno+' ALIGN="LEFT" ><B>'+m_ref_no+'</B></TD><TD ID=C2R'+	lineno+' ALIGN="CENTER" ><B>'+m_amount+'</B></TD></TR>';																							
								vec_pos=vec_pos+2;
								lineno=lineno+1;

							}
				m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color: white; font: 9pt arial;}">'+            
				'<TR BGCOLOR="darkblue"><TD WIDTH="25%"><B>Reference Number</B></TD>' +
				'<TD WIDTH="10%" ALIGN="CENTER"><B>Balance to be paid</B></TD>' +
				m_row+
				'</TABLE>'; 
				myDialogObj.htmlstr = m_writedata;
				myDialogObj.returnval = "";
				myDialogObj.returnval1 = "";
				
				popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:15em; dialogHeight:15em; center:yes; resizable:yes; status:no");
					document.Form1.TXT_ref_no.value=myDialogObj.returnval;
					document.Form1.TXT_amount.value=myDialogObj.returnval1;
					document.Form1.Hid_amount.value=myDialogObj.returnval1;
					//alert(document.Form1.Hid_amount.value)
	}
	*/
	
//********************************************** End of Reference  Number Help *************************************************************************************************
	
	function clearAll(){
					document.Form1.TXT_portfolio.value="";
					document.Form1.TXT_bank_code.value="";
					document.Form1.TXT_lice_acc_no.value="";
					document.Form1.TXT_ref_no.value="";
					document.Form1.TXT_amount.value="";
					document.Form1.TXT_pay_bank_code.value="";	
					document.Form1.TXT_acc_no.value="";
					document.Form1.TXT_chqno.value="";	
	}
			
function BeforeSave(){
if(document.Form1.TXT_portfolio.value=="" ||document.Form1.TXT_bank_code.value=="" ||document.Form1.TXT_lice_acc_no.value=="" ||document.Form1.TXT_ref_no.value=="" ||document.Form1.TXT_amount.value==""||document.Form1.TXT_pay_bank_code.value==""||document.Form1.TXT_acc_no.value==""||document.Form1.TXT_chqno.value==""){
	alert(" Required fields should be filled.");
	}else {
	document.Form1.save_but.disabled=true;
	document.Form1.TXT_bank_code.disabled=false;
	document.Form1.TXT_lice_acc_no.disabled=false;
	//document.Form1.Hid_mm_amt.value=document.Form1.TXT_amount.value;
	//alert
	Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"save_int_recipts";
	Form1.submit();
	}
}			
	
function chkstartdate(dayobj,monthobj,yearobj) {
checkMonthLength(dayobj,monthobj,yearobj);		
}


//****************************************** Validating the amount *********************************************************

function chk_validity(){
ent_amt=parseFloat(document.Form1.TXT_amount.value);
paid_amt=parseFloat(document.Form1.Hid_amount.value);
		if (ent_amt>paid_amt){
		alert("Pay amount should be less than "+paid_amt+" ");
		document.Form1.TXT_amount.value="";
		document.Form1.TXT_amount.focus();
		}
}

//****************************************** End of validating the amount **************************************************
	
	
//****************************************** Display System Date ************************************************************

	function display_dat(){	
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=get_dat";
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
			
			if(m_size>0){	
				document.Form1.TXT_DATE.value= data_vec[0].substring(0,2);
				document.Form1.TXT_MONTH.value= data_vec[0].substring(3,5);
				document.Form1.TXT_YEAR.value= data_vec[0].substring(6,10);
			}
			else{
			}
				
	}
		
//***************************************** End of disp date function ************************************************************	
	
/*	
function obtain_report_before() {
		 m_url=html_client_url+'/dn_capitalwith_obtain.html';
		 popupwin = window.open(m_url,'displayWindow', 'top=200, left=100, width=600, height=200, scrollbars=no, menubar=No, resizable=no, fullscreen=No');
}*/
		
	
		
		
		
		
		
	
	</SCRIPT>
	
	<BODY onload="display_dat()" >
    <FORM NAME="Form1" ID="Form1" METHOD="POST" >
	<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="interest_receipts" >
	<INPUT TYPE="Hidden" NAME="Hid_mm_amt"		VALUE="" >
	<INPUT TYPE="Hidden" NAME="Hid_amount"		VALUE="" >
			
		<!--	
	<TABLE WIDTH="100%" BGCOLOR="darkblue" >
					<TR BGCOLOR="darkblue">
					<TD WIDTH="40%">	
						<INPUT TYPE="Button" NAME="save_but" VALUE="Save&nbsp; "   class="mainbut" onClick="BeforeSave()">
						<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"  class="mainbut" onClick="clearAll()"> 
						<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit&nbsp&nbsp;  "  class="mainbut" onClick="top.frames[1].location.href='low.html'"> 
				  </TD>
			        <TD width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" WIDTH="38%">
				    <td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Interest Receipts</B></td>
					<td width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>	
			   </TD>					
		     </TR>
	</TABLE> 
			-->
			
		   <DIV>
			<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
				<tr>
			<td height='7'></td>
			</tr>
				
			<tr height='30' >
			<td  width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
			<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Administration - Portfolio Management</B></td>
			<td width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>
						
			</tr>
			
			<tr>
						
			</TABLE>	
					
			</DIV>
				
				<TABLE WIDTH="100%" BGCOLOR="darkblue" >
					<TR>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="save_but"   VALUE="Save "   class="mainbut" onClick="BeforeSave()">
					</TD>
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"  class="mainbut" onClick="clearAll()"> 
					</TD>
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="Exit_but"   VALUE="Exit"    class="mainbut" onClick="top.frames[1].location.href='low.html'"> 
				    </TD>
						
					<TD  WIDTH="80%" class="hh1" align="right">
						<B>Interest Receipt</B>
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
  

	  <TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
		   <TR>
				<TD WIDTH="1%"></TD>
				<TD WidTH="30%">Portfolio Code</TD>
				<TD WidTH="30%"><INPUT TYPE="Text" NAME="TXT_portfolio"	ALIGN="LEFT" SIZE=20  OnBlur="portP_help(0)" class="txt_input6" >
								<!-- <INPUT TYPE="button" VALUE="..." NAME="BUT_port" class="but_input"  OnClick="portP_help(document.Form1.TXT_portfolio.value)" > -->
								<INPUT TYPE="button" VALUE="..." NAME="BUT_port" class="but_input"  OnClick="portP_help(0)" >
				</TD>
				<TD WIDTH="*%" ></TD>
			</TR>	
	  </TABLE>	

	  <TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
		  <TR>
				<TD WIDTH="1%"></TD>
				<TD WidTH="30%">Licencee Bank Code</TD>
				<TD WidTH="30%"><INPUT TYPE="Text" NAME="TXT_bank_code"	ALIGN="LEFT" SIZE=20 class="txt_input6" disabled>
								<INPUT TYPE="button" VALUE="..." NAME="BUT_port" class="but_input"  OnClick="bank_help(0)"  >
				</TD>
				<TD WIDTH="*%" ></TD>
			</TR>	
	  </TABLE>	
			
	  <TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
		  <TR>
				<TD WIDTH="1%"></TD>
				<TD WidTH="30%">Licencee Account Number</TD>
				<TD WidTH="30%"><INPUT TYPE="Text" NAME="TXT_lice_acc_no"	ALIGN="LEFT" SIZE=20 class="txt_input6"  disabled></TD>
				<TD WidTH="*%"></TD>
			</TR>	
	   </TABLE>	
		
	   <TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
		  <TR>
				<TD WIDTH="1%"></TD>
				<TD WidTH="30%">Reference Number </TD>
				<TD WidTH="30%"><INPUT TYPE="Text" NAME="TXT_ref_no"	ALIGN="LEFT" SIZE=20 onblur="Blur_ref_no(document.Form1.TXT_ref_no.value,document.Form1.TXT_portfolio.value)" class="txt_input6" >
								<!-- <INPUT TYPE="button" VALUE="..." NAME="BUT_ref_no" class="but_input"  OnClick="ref_no_help(document.Form1.TXT_ref_no.value,document.Form1.TXT_portfolio.value)"> -->
							    <INPUT TYPE="button" VALUE="..." NAME="BUT_ref_no" class="but_input"  OnClick="ref_no_help(0)">
				</TD>
				<TD WIDTH="*%" ></TD>
			</TR>	
		</TABLE>
	 
		<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
		   <TR>
				<TD WIDTH="1%"></TD>
				<TD WidTH="30%">Amount</TD>
				<TD WidTH="30%"><INPUT TYPE="Text" NAME="TXT_amount"	ALIGN="LEFT" SIZE=20  onblur ="chk_validity()" class="txt_input6" ></TD>
				<TD WIDTH="*%"></TD>
			</TR>	
		</TABLE>	
		
		<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
			<TR>
	    	    <TD WIDTH="1%"></TD>
				<TD WIDTH="30%" >Value Date</TD>
	 		    <TD WIDTH="30%"><INPUT TYPE="Text" NAME="TXT_DATE" SIZE=3 MAXLENGTH=2 class="txt_input5" >
			                 <INPUT TYPE="Text" NAME="TXT_MONTH" SIZE=3 MAXLENGTH=2 class="txt_input5" >
			                 <INPUT TYPE="Text" NAME="TXT_YEAR"  SIZE=4 MAXLENGTH=4 class="txt_input5" ONBLUR="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR)"> 								
				</TD>
				<TD WIDTH="*%"></TD>
			</TR>
		</TABLE> 			

		<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
		 <TR>
		    <TD WIDTH="1%"></TD>
			<TD WIDTH="30%" >Settlement Mode</TD>
			<TD WIDTH="30%" SIZE=20 ><SELECT  NAME="opt_settl_mode" ONBLUR="" class="txt_input6" >
											<OPTION VALUE="CB_CHEQUE" SELECTED>CB_CHEQUE</OPTION>
											<OPTION VALUE="CB_TRANF" >CB_TRANF</OPTION>
											<OPTION VALUE="BANK_TRANF" >BANK_TRANF</OPTION>
											<OPTION VALUE="CHEQUE" >CHEQUE</OPTION>
											<OPTION VALUE="CASH" >CASH</OPTION>
											<OPTION VALUE="CURR_ACC">CURR_ACC</OPTION></SELECT> 
			</TD>
			<TD WIDTH="*%"></TD>	
		 </TR>
		</TABLE>
		
		<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
		  <TR>
				<TD WIDTH="1%"></TD>
				<TD WidTH="30%">Payer Bank Code</TD>
				<TD WidTH="30%"><INPUT TYPE="Text" NAME="TXT_pay_bank_code"	ALIGN="LEFT" SIZE=20 class="txt_input6"  ></TD>
				<TD WIDTH="*%"></TD>
		  </TR>	
		</TABLE>
		
		<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
		  <TR>
				<TD WIDTH="1%"></TD>
				<TD WidTH="30%">Account Number</TD>
				<TD WidTH="30%"><INPUT TYPE="Text" NAME="TXT_acc_no"	ALIGN="LEFT" SIZE=20 class="txt_input6"  ></TD>
				<TD WIDTH="*%"></TD>
		  </TR>	
		</TABLE>
		
		<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
			<TR>
				<TD WIDTH="1%"></TD>
				<TD WidTH="30%">Cheque No</TD>
				<TD WidTH="30%"><INPUT TYPE="Text" NAME="TXT_chqno"	ALIGN="LEFT" SIZE=20 class="txt_input6" ></TD>
				<TD WIDTH="*%"></TD>
			</TR>	
		</TABLE>
				
				
		<!-- </TABLE>  -->
</FORM>
	<!--applet code=mf_datagateway.class width=0 height=0></applet>-->
	<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT> 
   <script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT> 
	</body>
</html>

