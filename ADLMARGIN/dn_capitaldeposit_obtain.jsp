<%@page import="net.sasianet.ADLMARGIN.*" %>
<HTML>
	<HEAD>
		<TITLE>Margin Tragiing</TITLE>

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
		
 <SCRIPT language="JavaScript1.2">
 
	function obtain_report(m_strat) {
		
  parent.initmsgDrillEnq(600,500);
		
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form2');
	 /*  var myObject = new Object();
   	 myObject.firstName = aForm.oFirstName.value;
   	 myObject.lastName = aForm.oLastName.value;
		*/
		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.Text_recno;
 		myObject[1]=null;
 		myObject[2]=null;
 		myObject[3]=null;
 		myObject[4]=null;
  
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.Text_recno.value;
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
 
 		var qid='62';
        var hid='9';
		
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
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&hid='+hid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400,// 500,
		 width: 500,//900,
		 title: 'SasiNet Frame work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); parent.initmsgDrillEnq(500,150);aForm.Text_recno.focus();  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
		
    }

// ----------------------------the function create the Scrip objects-------------------------//
function MyDialog(){
 this.valout   = new Array(10);
}			
//----------------------------This Function Is to get The Help Box---------------------------//
 function HelpBox(Start,End,Hid_No) {
		oBj = new MyDialog();
	  oBj.valout[1]  = " ";
		oBj.valout[2]  = " ";
		oBj.valout[3]  = " ";
		oBj.valout[4]  = " ";
		popupwin = window.showModalDialog(""+servlet_client_url+":"+client_t3_port+"/"+client_name+"dn_Help_Servlet_receipt?class_in="+client_name+"dn_help_select_receipt"+
								"&Sql_in="+m_sql+"&Start_in="+Start+
								"&End_in="+End+"&Crit_In="+m_criteria+
								"&Hid_No="+Hid_No+"", oBj,"dialogWidth:25em; dialogHeight:18em; center:yes; status:no");		
	
		
		if(document.Form2.hid_help_type.value=="1"){
		  if(oBj.valout[1] !=" "){
		     if(oBj.valout[1] !='Close'){
			     if(oBj.valout[1]!="Prev"){
				      if(oBj.valout[1]!="Next"){
				        asign_account_no();
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
	         //document.Form1.Text_recno.value="";	
         }		
    }
    else{		
	    //document.Form1.Text_recno.value="";	
    }		
 }
}		
function Prev(Start,End,Hid_No){
	 HelpBox(Start,End,Hid_No)
}
function Next (Start,End,Hid_No){
	 HelpBox(Start,End,Hid_No)
}
//-----------------------asigning returned data-----------------//
function asign_account_no() {
  document.Form2.Text_recno.value=oBj.valout[2];
  m_refno=oBj.valout[3];
  m_dealnumber=oBj.valout[4];
	m_type=oBj.valout[5];
	document.Form2.save_but.disabled=false;
}	

function chk_stat(){
//alert("hi");
	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"report_portf_charges_enq?reci_no="+document.Form2.Text_recno.value+"&refno="+m_refno+"&chksql=deposit ";
	
	popupwin2 = window.open(m_url,'displayWindow3', 'width=650, height=650, scrollbars=yes, menubar=No, resizable=yes, fullscreen=No');
	document.Form2.save_but.disabled=true;
}
	
function chk_recno(){
	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?reci_no="+document.Form2.Text_recno.value+"&chksql=capi_deposit ";
	
	
	
	load_interface(m_url,'XML',false);
	m_size = data_vec.length;
			
	
	if (m_size>0) {
		document.Form2.save_but.disabled=false;
        m_refno=data_vec[0];
	}
	else{
		if (confirm("Invalid Number..Press the OK button if you want a list of Codes or Press the Cancel button to type again")) {
			obtain_report(0);
    }
		else{
				document.Form2.Text_recno.value="";
			    document.Form2.save_but.disabled=true;

		}
	}	
	}
	
	
	</SCRIPT>
</HEAD>			
 <BODY class='body & txt-body' >
  <FORM NAME="Form2" ID="Form2" METHOD="POST">
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="inv_receipts">
		<INPUT TYPE="Hidden" NAME="Hid_client_no"	VALUE="">
		<INPUT TYPE="Hidden" NAME="hid_help_type"	VALUE="" >    
   <TABLE WIDTH="100%" BORDER="0" CELLPADDING="2" CELLSPACING="1">
	  <TR>
		  <TD WIDTH="35%"><B>Capital Deposit Enquiry No</B></TD>
			 <TD ><INPUT TYPE="Text" NAME="Text_recno"	ALIGN="LEFT" SIZE="20" MAXLENGTH="15" ONBLUR="chk_recno()">
	  				<INPUT TYPE="Button" NAME="help_but_recno" VALUE="..."   class="but_input"  onClick="obtain_report(0)"  ></TD>
		   <TD><INPUT 	TYPE="Button" NAME="save_but" VALUE="   GO   "  class="but_input"  onClick= "chk_stat()"  disabled></TD>
		</TR>
  </TABLE>
  </FORM>
  <SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>		
  <script language="JavaScript1.2" SRC="validate.js"></script>
 </body>
</html>


