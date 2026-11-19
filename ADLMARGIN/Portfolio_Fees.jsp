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
	
	//****************************************OUTFLOW HELP*******************************
	function Blur_porpolio(ObjVal){
				//alert("jmk");
				m_portfcode=ObjVal; 
				m_size="";
				//alert(ObjVal);
		    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=Pf_Blur_new&PF_value="+ObjVal+" ";
				top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				//alert(m_size); 
					if(m_size<=0){
					if (confirm("Invalid Portpolio Code. Press OK For Help")){
					 portP_help(m_portfcode);
					}
						else{
						 document.Form1.TXT_portfolio.value="";
							}
					}		
	}
	
	function account_help() {
	m_portfcode="hh";
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=account_lookup";
		top.frames[0].document.applets[0].getdata(m_url);
		m_size=top.frames[0].document.applets[0].outvec_value.size();
		//alert(m_size);
	  vec_pos=0;
	 	m_row="";
	  lineno=1;
			 	while (vec_pos<m_size) {
				  	m_acc_no=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
				  	m_bank_name=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
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

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@	
	
	function portP_help(ObjVal){
				m_portfcode=ObjVal; 
				m_size="";
				//alert(ObjVal);
		    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=Pf_help_new&PF_value="+ObjVal+" ";
				
		//window.open(m_url);
		top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				
				//alert(m_size);
				//alert(top.frames[0].document.applets[0].outvec_value.elementAt(0));
		
				vec_pos=0;
				lineno=1;
				m_row="";
							while (vec_pos<m_size) {
								m_pfCode =top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
								m_type   =top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
								m_pf_Name=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2);
								m_CDS_NO=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+3);
								m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+' ALIGN="LEFT" ><B>'+m_pfCode+'</B></TD><TD ID=C2R'+	lineno+' ALIGN="CENTER" ><B>'+m_type+'</B></TD><TD ID=C3R'+	lineno+' ALIGN="LEFT" ><B>'+m_pf_Name+'</B></TD><TD ID=C4R'+	lineno+' ALIGN="LEFT" ><B>'+m_CDS_NO+'</B></TD></TR>';
								vec_pos=vec_pos+4;
								lineno=lineno+1;
							}
				m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color: white; font: 9pt arial;}">'+            
				'<TR BGCOLOR="darkblue"><TD WIDTH="25%"><B>Client Code</B></TD>' +
				'<TD WIDTH="10%" ALIGN="CENTER"><B>Type</B></TD>' +
				'<TD WIDTH="*%"><B>Client Name</B></TD>' +
			    '<TD WIDTH="15%"><B>CDS NO.</B></TD></tr>' +
				m_row+
				'</TABLE>'; 
				myDialogObj.htmlstr = m_writedata;
				myDialogObj.returnval = "";
				helpvalue="";
				
				popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:30em; dialogHeight:15em; center:yes; resizable:yes; status:no");
				helpvalue= top.frames[0].document.applets[0].outvec_value.indexOf(myDialogObj.returnval);
			
			if (helpvalue != 1) {
					document.Form1.TXT_portfolio.value=top.frames[0].document.applets[0].outvec_value.elementAt(helpvalue+0);
			}
					
			 else { 
					 if (helpvalue==1){
						//alert("bank");
							document.Form1.TXT_portfolio.value="";
						}
						}
				
	}
			
	function bank_help() {
	//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=set_opt_help_button&bankcode="+document.Form1.TXT_bank_code.value ;
	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement_help?chksql=set_opt_help_button1";
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
			vec_pos=0;
      m_row="";
		  lineno=1;
			while (vec_pos<m_size) {
			  m_bank_code=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
	  	  m_acc_code=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1); 
			  m_row=m_row+'<TR STYLE="{color:black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+',C2R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_bank_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_acc_code+'</B></TD></TR>';
  	    vec_pos=vec_pos+2;
		    lineno=lineno+1;
			}
			m_writedata ='<TABLE BGCOLOR="siler" WIDTH="100%" STYLE="{color: darkblue; font: 9pt sans-serif;}">'+
		 '<TR BGCOLOR="silver"><TD WIDTH="30%"><B>Bank Code</B></TD>' +
		 '<TD WIDTH="75%"><B>Accounts Number</B></TD></TR>'+
		  m_row+
		 '</TABLE>'; 
		 	//alert(m_writedata);	
			myDialogObj.htmlstr = m_writedata;
		 	myDialogObj.returnval1 = "";
		 	myDialogObj.returnval2 = "";
			helpvalue="";
	   	popupwin = window.showModalDialog(html_client_url+"/help_box4.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no"); 
		  //alert("Return Value"+myDialogObj.returnval1+"/"+myDialogObj.returnval2);
			helpvalue= top.frames[0].document.applets[0].outvec_value.indexOf(myDialogObj.returnval);
			//alert(helpvalue);
			if (helpvalue != 1) {
					document.Form1.TXT_bank_code.value=myDialogObj.returnval1;
					document.Form1.TXT_ACC_number.value=myDialogObj.returnval2;
			}
					
			 else { 
					document.Form1.TXT_bank_code.value="";
					document.Form1.TXT_ACC_number.value="";
						}
			
	}
	
	function clearAll(){
					document.Form1.TXT_portfolio.value="";
					document.Form1.TXT_bank_code.value="";
					document.Form1.TXT_ACC_number.value="";
	}
			
	function BeforeSave(){
		document.Form1.save_but.disabled=true;
		Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsavsett";
		Form1.submit();
	
	}
			
	function myDialogObj() {
		var htmlstr; 
 		var returnval;
		var	returnval1;
		var	returnval2;
  }

function display_dat(){
		  m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=get_dat";

	    top.frames[0].document.applets[0].getdata(m_url);
   	  m_size=top.frames[0].document.applets[0].outvec_value.size();
			if(m_size>0){	
		        document.Form1.TXT_DATE.value=top.frames[0].document.applets[0].outvec_value.elementAt(0).substring(0,2);
		        document.Form1.TXT_MONTH.value=top.frames[0].document.applets[0].outvec_value.elementAt(0).substring(3,5);
		        document.Form1.TXT_YEAR.value=top.frames[0].document.applets[0].outvec_value.elementAt(0).substring(6,10);
      }
      else{
			}
 }
	
 function chkstartdate(dayobj,monthobj,yearobj) {
		    checkMonthLength(dayobj,monthobj,yearobj);		
 }	
//------------------------------------------------------------

	</SCRIPT>
	
	<BODY onload="display_dat()" class='body & txt-body' >
  <FORM NAME="Form1" id="Form1" METHOD="POST" >
	<INPUT TYPE="Hidden" NAME="Hid_ACC_TYPE"	>
	<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="portf_fees_save">
	
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
					<TD WIDTH="40%">	
						<INPUT TYPE="Button" NAME="save_but" VALUE="Save"   class="mainbut"  onClick="BeforeSave()">
						<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"  class="mainbut"  onClick="clearAll()"> 
						<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit"  class="mainbut"  onClick="top.frames[1].location.href='low.html'"> 
				  </TD>
				<TD  WIDTH="*%" >
			</TD>					

			   <TD  WIDTH="38%" ALIGN="RIGHT">
				<B>Porfolio fees</B>
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
				<TD WidTH="20%">Portfolio Codes</TD>
				<TD WidTH="21%"><INPUT TYPE="Text" NAME="TXT_portfolio"	ALIGN="LEFT" SIZE=20  OnBlur="Blur_porpolio(document.Form1.TXT_portfolio.value)"></TD>
				<TD WIDTH="*%"><INPUT TYPE="button" VALUE=" Help " NAME="BUT_INSTYPE"  class="mainbut" OnClick="portP_help(document.Form1.TXT_portfolio.value)" ></TD>
			</TR>	
		</TABLE>	
		

	  <TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0" >
		  <TR>
				<TD WIDTH="1%"></TD>
				<TD WidTH="20%">Description</TD>
				<TD WidTH="79%"><INPUT TYPE="Text" NAME="TXT_desc"	ALIGN="LEFT" SIZE=20 ></TD>
			</TR>	
			
	  <TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0" >
		  <TR>
				<TD WIDTH="1%"></TD>
				<TD WidTH="20%">Amount</TD>
				<TD WidTH="79%"><INPUT TYPE="Text" NAME="TXT_amount"	ALIGN="LEFT" SIZE=20   ></TD>
			</TR>	
		</TABLE>	
		<TABLE WIDTH="100%"BORDER="0" CELLPADDING="1" CELLSPACING="0">
	    	<TD WIDTH="1%"></TD>
				<TD WIDTH="20%" >Value Date</TD>
	 		  <TD WIDTH="79%"><INPUT TYPE="Text" NAME="TXT_DATE" SIZE=3 MAXLENGTH=2>
			                 <INPUT TYPE="Text" NAME="TXT_MONTH" SIZE=3 MAXLENGTH=2>
			                 <INPUT TYPE="Text" NAME="TXT_YEAR" SIZE=4 MAXLENGTH=4 ONBLUR="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR)"> 								
			</TABLE> 	
		</TABLE> 
				</TABLE> 
</FORM> 
   <SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
   <script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT> 
	</body>
</html>

