<!--Created by prabash on 16-09-2011 for LBMARGIN -->
<HTML>
	<HEAD>
		<TITLE>CSAM</TITLE>
		<LINK REL="stylesheet" TYPE="text/css" HREF="mbfsl.css" />
 	
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
	<script language="JavaScript1.2" >
        var s_status=false;
				
				
      function chkstartdate(dayobj,monthobj,yearobj) {
	 		checkMonthLength(dayobj,monthobj,yearobj);		
	  }
  
	  function val_seccode()
		{
		  m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsecurities?chksql=sec_val&sec_code="+document.Form1.Text_sec_code.value;
		  top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
	  	 if (m_size >0) {
				top.frames[0].document.applets[0].outvec_value.elementAt(0);				
		  }			
			else
			{
				sec_help1()
			}
		}	
		
		
	

		function	sec_help1(m_strat){
			var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	 
		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.Text_type;
		document.Form1.Text_type.disabled=true;
 		myObject[1]=aForm.Text_sec_code;
		document.Form1.Text_sec_code.disabled=true;
 		myObject[2]=aForm.Text_inst;
		document.Form1.TXT_DATE_FROM.disabled=true;
 		myObject[3]=aForm.TXT_DATE_FROM;
		document.Form1.TXT_DATE_ENT.disabled=true;
 		myObject[4]=aForm.TXT_DATE_ENT;
		document.Form1.Text_inst.disabled=true;
		myObject[5]=aForm.Text_user;
		document.Form1.Text_user.disabled=true;
		
			
  
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.Text_type.value;
 		myObject_value[1]=null;//aForm.oLastName2.value;
 		
 		
 
 		var myObject_type=new Array(); //passing values data type
 		myObject_type[0]="StringL";
 		myObject_type[1]=null;
 		myObject_type[2]=null;
 		myObject_type[3]=null;
 		myObject_type[4]=null;
 
 		var qid='28';
		var hid='2';
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
		 height:400,// 600,
		 width: 400,//900,
		 title: 'SasiNet Frame work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);	  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
		
		}
	
		
		function myDialogObj() {
				var htmlstr; 
				var returnval1;
				var returnval2;
				var returnval3;
				var returnval4;
				var returnval5;
				var returnval6;
 	 }
		
		function deletion()
		{
		          document.Form1.Text_type.disabled=false;
							document.Form1.Text_sec_code.disabled=false;
							document.Form1.TXT_DATE_FROM.disabled=false;
							document.Form1.TXT_DATE_ENT.disabled=false;
							document.Form1.Text_inst.disabled=false;
							document.Form1.Text_user.disabled=false;
				  			Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsavcorporate";
							Form1.submit();

		}
		
		
		
	
</SCRIPT>
<BODY >
 	<FORM NAME="Form1" ID="Form1" METHOD="POST" >
	  	<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="deletion">
		<DIV>
			<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
				<tr>
				<td height='7'></td>
				</tr>
				<tr height='30' >
				<td  width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
				<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'> <B> Margin Trading - Corporate Actions</B></td>
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
						
		<!-------------------------------------------------------------------->
						
						
			<TABLE WIDTH="100%" BGCOLOR="darkblue" >
				<TR >
					<!--added by prabash on 01-09-2011-->
						
					<!---------------------------------->
							
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="NEW" VALUE="Add&nbsp; "   onClick="location.href='dn_dividends_entry.jsp'"  class="mainbut"  >
					</TD>
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="MOD" VALUE="Modify&nbsp; " onClick="entry_mode('mod') ; cancelling() " class="mainbut"  >
					</TD>
								
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="DEL" VALUE="Delete&nbsp; "   onClick="location.href='dn_deletion_corporate_frame1.jsp'"  class="mainbut"  >
					</TD>	
								
					<TD WIDTH='6%'></TD>	
								
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="save_but" VALUE="Save&nbsp; "   onClick="deletion()" class="mainbut"  >
					</TD>
								
				
						
					
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"   onClick="location.href='dn_deletion_corporate_frame1.jsp'" class="mainbut"> 
				</TD>
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit&nbsp&nbsp;  "   onClick="top.frames[1].location.href='low.html'" class="mainbut"> 
					</TD>
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="report_but" VALUE="Enquiry&nbsp; "    onClick="obtain_report_before()" class="mainbut">
						
					</TD>			
								
								
								
								
								
								
								
								
								
					<TD  WIDTH="50%" class="hh1" align="right">
						<B>	Dividend Deletion</B>
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
			<!---------------------------------->
					
	<table width="100%" border="0" cellpadding="1" cellspacing="0" >
		<TR>
		  <TD WIDTH="1%"></TD>
			<TD  WIDTH="16%" >Security Code</TD>
		 <TD  ><INPUT TYPE="Text" NAME="Text_sec_code" class="txt_input6"	ALIGN="LEFT" SIZE="15" onBlur="val_seccode()">
			 <INPUT TYPE="BUTTON" NAME="sec_help" ONCLICK="sec_help1(0)" class="mainbut"  value="..."></TD>
   </TR>
		
	
		<TR>
		  <TD WIDTH="1%"></TD>
			<TD  WIDTH="16%" >Instrument Code</TD>
			 <TD  ><INPUT TYPE="Text" NAME="Text_inst" class="txt_input6"	ALIGN="LEFT" SIZE="15" ></TD>
   </TR>
		
	
		<TR>
		  <TD WIDTH="1%"></TD>
			<TD  WIDTH="16%" > Type Of Activity</TD>
			 <TD ><INPUT TYPE="Text" NAME="Text_type" class="txt_input6"	ALIGN="LEFT" SIZE="15" ></TD>
   </TR>
		<TR></TR>
		<TR></TR>
	
   		<TR>	
				      <TD WIDTH="1%"></TD>
		  	      <TD WIDTH="16%" >XC Date</TD>
							<TD ><INPUT TYPE="Text" class="txt_input6" NAME="TXT_DATE_FROM" SIZE=15 >
			 			 </TD>
		</TR>
	
   		<TR>	
				      <TD WIDTH="1%"></TD>
		  	      <TD WIDTH="16%" >Entered Date</TD> 
							<TD ><INPUT TYPE="Text" class="txt_input6" NAME="TXT_DATE_ENT" SIZE=15 >
			 			 </TD> 
		</TR>
	 
		<TR>
		  <TD WIDTH="1%"></TD>
			<TD  WIDTH="16%" >User Name Code</TD>
		 <TD  ><INPUT TYPE="Text" NAME="Text_user" class="txt_input6"	ALIGN="LEFT" SIZE="15">
							

   </TR>
		
	</TABLE>
		<BR> <BR>

</TABLE>
</FORM>
	</body>	
  <DIV>
			<SCRIPT language1.2="JavaScript" src="validate.js"></SCRIPT>
			<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
</DIV>

</html>	




