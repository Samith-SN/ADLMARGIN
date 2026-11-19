<HTML>
	<HEAD>
		<TITLE>Margin Trading 
		</TITLE>
		
		<%@page import="net.sasianet.ADLMARGIN.*" %>
		<%	
		/*
		LBMARGIN_MGT_conn_methods1 m_sn_methods = new LBMARGIN_MGT_conn_methods1();
		String m_jsp_client_url=m_sn_methods.jsp_client_url;
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
		*/
		
		ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
			//***************  ADDED BY KANISHKA ON 26/12/2012  *********************//
	
		Object done = (String)session.getValue("logon.isDone");  // marker object
		if (done == null) {
			response.sendRedirect("login.jsp");
			return;
			}
	
	//*************** ADDED BY KANISHKA ON 26/12/2012 [END]  *********************//
		String m_jsp_client_url=m_sn_methods.jsp_client_url;
			
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
			
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/redmond/jquery-ui.css' TYPE=\"text/css\">");
			
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
        out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
		
		%>
		
		
		
		
		
		
	</HEAD>
	<SCRIPT language="JavaScript">
		
// ***********************************************************************************		
// ************* Start New Help ******************************************************	
// ***********************************************************************************	
		
	
	// Bank Help
		
	function deal_ticket(m_strat) {
		
		parent.initmsgDealTicketDrill(500,500);
		
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form2');

		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.Text_Deal;
 		myObject[1]=null;
 		myObject[2]=null;
 		myObject[3]=null;
 		myObject[4]=null;
  
 		var myObject_value=new Array(); //passing values set to this object

		myObject_value[0]=aForm.Text_Deal.value;
		/*myObject_value[1]=aForm.Text_Deal.value;
		myObject_value[2]=aForm.Text_Deal.value;
		myObject_value[3]=aForm.Text_Deal.value;
		myObject_value[4]=aForm.Text_Deal.value;
		myObject_value[5]=aForm.Text_Deal.value;
		myObject_value[6]=aForm.Text_Deal.value;
		myObject_value[7]=aForm.Text_Deal.value;
		myObject_value[8]=aForm.Text_Deal.value;
		myObject_value[9]=aForm.Text_Deal.value;
		myObject_value[10]=aForm.Text_Deal.value;
		myObject_value[11]=aForm.Text_Deal.value;
		myObject_value[12]=aForm.Text_Deal.value;*/
 
 
 		var myObject_type=new Array(); //passing values data type
		
		myObject_type[0]="StringL";
		/*myObject_type[1]="StringL";
		myObject_type[2]="StringL";
		myObject_type[3]="StringL";
		myObject_type[4]="StringL";
		myObject_type[5]="StringL";
		myObject_type[6]="StringL";
		myObject_type[7]="StringL";
		myObject_type[8]="StringL";
		myObject_type[9]="StringL";
		myObject_type[10]="StringL";
		myObject_type[11]="StringL";
		myObject_type[12]="StringL";*/
		
 
 		var qid='1004'; // 2
		var close_fun='close_deal_ticket';
 		var url = 'popup.jsp';
 		var json_text = JSON.stringify(myObject_value, null,0);
 		var json_obj_type_text=JSON.stringify(myObject_type, null,0);
 		var fn_name=arguments.callee.name;
		if(fn_name==undefined){
		re = /^function\s+([^(]+)/;
        fn_name=re.exec(arguments.callee.toString())[1];
		}

       	$.showModalDialog({
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun, //&close_fun='+close_fun,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400,// 500,
		 width: 400,//900,
		 title: 'SasiNet Frame work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); parent.initmsgDealTicketDrill(100,500); } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
		
	}	// End deal_ticket
		
		
	function close_deal_ticket(){
		//alert('fff');
		document.Form2.Text_Deal.text='';
	}	
		
	// Reference No. Help

		

// *********************************************************************************			
// ************ End New Help *******************************************************		
// *********************************************************************************		


		
		
		
		
		
		
	//var pubdealNum=0;
	
	/*function callDealCreation(){
				window.opener.parent.frames[1].beforesubmit_dealTiket(pubdealNum);
				window.close();
	}*/
	
		
	function CheckDeal(Obj){

		obj_dealnum = Obj.value;
		
					if ((obj_dealnum.substring(0,2)=="OR")|| (obj_dealnum.substring(0,2)=="PA")){
						m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bautho_confirm?chksql=confirm_details&m_identity=CONFIRMATION&deal_num="+obj_dealnum;
					}
		            else if((obj_dealnum.substring(0,2)=="OR")|| (obj_dealnum.substring(0,2)=="GO")){
						m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmprint?chksql=confirm_details&m_identity=CONFIRMATION&deal_num="+obj_dealnum;
					}
					 else if ((obj_dealnum.substring(0,2)=="RF")|| (obj_dealnum.substring(0,2)=="GF")){
						m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmrepo?chksql=confirm_details_repo&m_identity=CONFIRMATION&deal_num="+obj_dealnum;
					}
					else if(obj_dealnum.substring(0,2)=="PI"){		
						m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmrepoPI?chksql=confirm_details_repo&m_identity=CONFIRMATION&deal_num="+obj_dealnum;
					}
					else if ((obj_dealnum.substring(0,2)=="RR")|| (obj_dealnum.substring(0,2)=="GR")){
						m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmrepo?chksql=confirm_details_rollover&m_identity=CONFIRMATION&deal_num="+obj_dealnum;
					}
					else if(obj_dealnum.substring(0,2)=="SO"){		
						m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmoutright?chksql=confirm_details_outright&m_identity=CONFIRMATION&deal_num="+obj_dealnum;
					}
					else if(obj_dealnum.substring(0,2)=="BF"){		
						m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmblfund?chksql=confirm_details_blfunds&m_identity=CONFIRMATION&deal_num="+obj_dealnum;
					}
					else if(obj_dealnum.substring(0,2)=="BS"){		
						m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmblfund?chksql=confirm_details_blsecurity&m_identity=CONFIRMATION&deal_num="+obj_dealnum;
					}
					else if(obj_dealnum.substring(0,2)=="SR"){		
						m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmreturnable?chksql=confirm_details_returnable&m_identity=CONFIRMATION&deal_num="+obj_dealnum;
					}
					else if(obj_dealnum.substring(0,2)=="RS"){		
						m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"confirmrepo_setlle?chksql=confirm_details_reposettle&m_identity=CONFIRMATION&deal_num="+obj_dealnum;
					}

				 parent.pop_up_message_2(m_url);
		
		
	}
		
	

		
</SCRIPT>
<body class='body & txt-body' >
   		<FORM NAME="Form2" ID="Form2" METHOD="POST">	
				<INPUT TYPE="Hidden" NAME="hid_help_type"	VALUE="">
			    <INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE=""> 
			    <INPUT TYPE="Hidden" NAME="Hid_dealValue"	VALUE="">

				<TABLE WIDTH="100%"  >
				  <TR>
				    <TD  WIDTH="40%" ><b>Enter The Deal Number</b></TD>
					<TD  WIDTH="30%"><INPUT TYPE="TEXT" NAME="Text_Deal" size="25" class="txt_input6" ></TD>
 				    <!-- <TD  WIDTH="7%"><INPUT TYPE="Button" NAME="Butt_help" VALUE=" ...  "   class="but_input" onClick="helpDeal(document.Form2.Text_Deal)"> </TD> -->
					<TD  WIDTH="7%"><INPUT TYPE="Button" NAME="Butt_help" VALUE=" ...  "   class="but_input" onClick="deal_ticket(0)" > </TD> 
				    <TD  WIDTH="*%"><INPUT TYPE="Button" NAME="Butt_deal" VALUE=" GO "  class="but_input" onClick="CheckDeal(document.Form2.Text_Deal)">   </TD>
				  </TR>
				</TABLE> 
</FORM>
	</body>
<DIV> </DIV>
		<script language="JavaScript1.2" src="validate.js"></SCRIPT>
		<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>
		<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
		
</SCRIPT>
</html>


