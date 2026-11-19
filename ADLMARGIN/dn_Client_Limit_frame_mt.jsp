<HTML>
	<HEAD>
	<TITLE>Margin Traging</TITLE>
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

	<SCRIPT language="JavaScript">
		
		var a=1;
		var f=1;
		//var flag_disable;  // --Yohan on 23-06-2006 for VC 06/009
		
		
		
		
		
		
		
		
		
		
		<!----------FIRST HELPBOX OPERATION--------------------------------------------------------------------->		
		function myDialogObj() {
			var htmlstr; 
			var returnval;
			var returnval1;
			
			
		}
		
		function unformatnum(obj)
		{
			
			obj.value = unformat_noobject(obj.value);
		}
		
		function get_data1(){
			
			
			if (document.Form1.TXT_ISCODE.value!="" && document.Form1.TXT_CLIENT.value!="" &&document.Form1.TXT_ISCODE.value!=" " && document.Form1.TXT_CLIENT.value!=" "){
				
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"securities_restriction?chksql=get_rest_limit_data&sec_code="+document.Form1.TXT_ISCODE.value+"&port_code="+document.Form1.TXT_CLIENT.value;
				//window.open(m_url);
				top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				vec_pos=0;
				m_row="";
				lineno=1;
				while (vec_pos<m_size) {
					//m_acc_no=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
					//m_acc_no_refno=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
					//m_acc_no=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
					//document.Form1.Status.value=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
					document.Form1.TXT_ISCODE.value=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+0);
					document.Form1.TXT_CLIENT.value=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
					document.Form1.TXT_Rate.value=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2);
					vec_pos=vec_pos+3;
					lineno=lineno+1;
				}
				
				
			}		
		}	
		
		function view_help1(){
			
			//val=(parent.frames[0].Form1.SCR_TYPE.selectedIndex);
			val=1;
			if (val==1){
				//bankcode=document.Form1.TXT_ITYPE.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"securities_restriction?chksql=view_mod_help11&sec_code="+document.Form1.TXT_ISCODE.value;
				
				//window.open(m_url);
				top.frames[0].document.applets[0].getdata(m_url);
				//m_size=parent.frames[0].document.applets[0].outvec_value.size();
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				vec_pos=0;
				m_row="";
				lineno=1;
				while (vec_pos<m_size) {
					//m_acc_no=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
					//m_acc_no_refno=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
					m_acc_no=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
					m_acc_no_refno=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
					m_row=m_row+'<TR STYLE="{color:black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white"  ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_acc_no+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_acc_no_refno+'</B></TD></TR>';
					vec_pos=vec_pos+2;
					lineno=lineno+1;
				}
				m_writedata ='<TABLE BGCOLOR="gray" WIDTH="100%" STYLE="{color: darkblue; font: 9pt sans-serif;}">'+
					'<TR BGCOLOR="darkgray"><TD WIDTH="15%"><B>Security Code</B></TD>' +
					'<TD WIDTH="85%"><B>Issuer Name</B></TD></TR>'+
					m_row+
					'</TABLE>'; 
				myDialogObj.htmlstr = m_writedata;
				myDialogObj.returnval = "";
				popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
				document.Form1.TXT_ISCODE.value=myDialogObj.returnval
					document.Form1.TXT_ISCODE.focus();
				
			}
			
			
		}		
		
		
		<!---------PAYMENTDATE BOX OPERATION--------------------------------------------------------------------->		
		function 	Payment_date(obj_date,obj_month,obj_year){
			if (checkMonthLength(obj_date,obj_month,obj_year)){
				iss_day = new Date(document.Form1.Text_iss_year1.value,document.Form1.Text_iss_month1.value,document.Form1.Text_iss_date1.value);
				matt_day = new Date(document.Form1.Text_mat_year1.value,document.Form1.Text_mat_month1.value,document.Form1.Text_mat_date1.value);
				pay_day=  new Date(document.Form1.Text_pay_year1.value,document.Form1.Text_pay_month1.value,document.Form1.Text_pay_date1.value);
				if (iss_day>=pay_day){
					alert('Interest payment date does not comply with issue date.Please check it');
				}	
				if (pay_day>matt_day){
					alert('Interest payment date does not comply with maturity date.Please check it');
				}	
				
			}	
		}
		
		<!-------CONVERSION TO  DECIMALS--------------------------------------------------------------------->			
		
		function	format_interest(obj_int) {
			obj_int.value=format_noobject0(obj_int.value);
		}		
		
		
		function	format_In_Issue(obj_int) {
			obj_int.value=format_noobject(obj_int.value);
		}
		
		function format_Weighted_Average(obj_int) {
			obj_int.value=format_noobject0(obj_int.value);
		}	
		
		
		<!------- FORM SUBMITION--------------------------------------------------------------------------------->			
		
		function beforesubmit(){
			
			unformatnum(document.Form1.TXT_LIMIT);
			
			
			// alert(parent.Frames[0].document.Form1.SCR_TYPE.options[parent.Frames[0].document.Form1.SCR_TYPE.selectedIndex].VALUE);
			chkstartdate(document.Form1.TXT_DATE_FROM,document.Form1.TXT_MONTH_FROM,document.Form1.TXT_YEAR_FROM);
			if (document.Form1.TXT_CLIENT.value=="") {
				alert('Please enter Facility No');
				document.Form1.TXT_CLIENT.focus();
				portcheck();
			}
			else if (document.Form1.TXT_LIMIT.value=="") {
				alert('Please enter Limit');
				//document.Form1.TXT_ISCODE.focus();
				//seccheck();
			}
			else if (document.Form1.TXT_DATE_FROM.value=="" ||document.Form1.TXT_MONTH_FROM.value==""||document.Form1.TXT_YEAR_FROM.value=="") {
				alert('Please enter Rate Effective Date');
				//document.Form1.TXT_ISCODE.focus();
				//seccheck();
			}
			else {
				
						
				document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"client_limit_save?chksql=Sec_limit_save";
				document.Form1.submit();					
			}
		}			
		
		//------- CANCEL AND EXIT OPERATION--------------------------------		
		function	cancelling(){
			Form1.reset();
			//display_sec_opt();
		}
		
		function entry_mode(val){
			
			if(val=="new"){
				document.getElementById('div_lable').innerHTML='Client Limit - NEW'; 
		    //    document.getElementById('div_scr_status').innerHTML = 'Add';	
				document.getElementById('SAVETYPE').value="NEW";
			//alert(parent.frames[0].document.Form1.SCR_TYPE.options[parent.frames[0].document.Form1.SCR_TYPE.selectedIndex].value);
			//document.Form1.SAVETYPE.value=Form1.SCR_TYPE.options[document.Form1.SCR_TYPE.selectedIndex].value;
					clear();
			}else if(val=="mod"){
					document.getElementById('div_lable').innerHTML='Client Limit - Edit'; 
				//  document.getElementById('div_scr_status').innerHTML = 'Modify';	
					document.getElementById('SAVETYPE').value="MOD";
					clear();
			}else if(val=="del"){
					document.getElementById('div_lable').innerHTML='Client Limit - Delete'; 
				//    document.getElementById('div_scr_status').innerHTML = 'Delete';	
					document.getElementById('SAVETYPE').value="DEL";
					clear();
			}
		}
		
		
		function screenclose(){
			top.frames[1].location=(html_client_url+'/low.html');
		}
		function checkkey(e){
			if(e.keyCode==32){
				alert("You are not allowed to enter space!!.");
				e.keyCode=0;
			}
		}	
		
		
		function chkstartdate(dayobj,monthobj,yearobj) {
			checkMonthLength(dayobj,monthobj,yearobj);		
		}		
		
		function Client_help(){

			if(document.Form1.SAVETYPE.value=="NEW"){
				sec_help1(0)
				//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalclient?chksql=portf_code_help_limit&port_code="+document.Form1.TXT_CLIENT.value;
			}
			else if(document.Form1.SAVETYPE.value=="MOD"){
				sec_help2(0)
				//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalclient?chksql=portf_code_help_limit_mod&port_code="+document.Form1.TXT_CLIENT.value;
			}
			else if(document.Form1.SAVETYPE.value=="DEL"){
				sec_help3(0)
				//m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalclient?chksql=portf_code_help_limit_del&port_code="+document.Form1.TXT_CLIENT.value;
			}
		}

	function clear2(){
	clear();
	}
		
		function clear(){
			document.Form1.TXT_CLIENT.value="";
			document.Form1.TXT_LIMIT.value="";
			document.Form1.TXT_RATE.value="";
			document.Form1.TXT_DATE_FROM.value="";
			document.Form1.TXT_MONTH_FROM.value="";
			document.Form1.TXT_YEAR_FROM.value="";
						
		}
		function portcheck(){
			if (document.Form1.TXT_CLIENT.value!="") {
				m_portcode=document.Form1.TXT_CLIENT.value;
				
				if(document.Form1.SAVETYPE.value=="NEW"){
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalclient?port_code="+m_portcode.toUpperCase()+"&chksql=portf_code_help_limit_chk";
				}
				else if(document.Form1.SAVETYPE.value=="MOD"){
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalclient?port_code="+m_portcode.toUpperCase()+"&chksql=portf_code_help_limit_chk_mod";
				}
				else if(document.Form1.SAVETYPE.value=="DEL"){
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalclient?port_code="+m_portcode.toUpperCase()+"&chksql=portf_code_help_limit_chk_del";
					
				}
				
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
				
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				if (m_size==0) {
					
					if(document.Form1.SAVETYPE.value=="NEW"){
					document.Form1.TXT_CLIENT.value="";	
					sec_help1(0)		
					}
					else if(document.Form1.SAVETYPE.value=="MOD"){
					document.Form1.TXT_CLIENT.value="";	
					sec_help2(0)
					}
					else if(document.Form1.SAVETYPE.value=="DEL"){
					document.Form1.TXT_CLIENT.value="";	
					sec_help3(0)
					}		
		
				}
					
					else{
					document.Form1.TXT_CLIENT.value=data_vec[0];
						
					//get_data1();
				}
			}
		}
		//----------------------------------------help1**
		function	sec_help1(m_strat){
			
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	
		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.TXT_CLIENT;
 		myObject[1]=null;
 		myObject[2]=aForm.TXT_LIMIT;
		myObject[3]=aForm.TXT_RATE;
		myObject[4]=null;
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.TXT_CLIENT.value;
 		myObject_value[1]=null;

 		var myObject_type=new Array(); //passing values data type
		myObject_type[0]="StringL";
 		myObject_type[1]=null;	
 	
 		var qid='30';

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
		//----------------------------------------------**
		
		//----------------------------------------help2**
		function	sec_help2(m_strat){
			
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	
		var myObject=new Array(); //return values set to this object
		
 		myObject[0]=aForm.TXT_CLIENT;
 		myObject[1]=null;	
 		myObject[2]=aForm.TXT_LIMIT;
		myObject[3]=aForm.TXT_RATE;
		myObject[4]=null;	
		myObject[5]=aForm.TXT_DATE_FROM;
		myObject[6]=aForm.TXT_MONTH_FROM;
		myObject[7]=aForm.TXT_YEAR_FROM;	
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.TXT_CLIENT.value;
 		myObject_value[1]=null;	

 		var myObject_type=new Array(); //passing values data type
		myObject_type[0]="StringL";
 		myObject_type[1]=null;	
 	
 		var qid='31';
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
			
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&hid='+hid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
				
		 height:400, // 500,
		 width: 500, //900,
		 title: 'SasiNet Frame work',
		 scrollable: true,
			
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
	}
		//----------------------------------------------**
		//----------------------------------------help3**
		function	sec_help3(m_strat){
			
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	
		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.TXT_CLIENT;
 		myObject[1]=null;	
 		myObject[2]=aForm.TXT_LIMIT;
		myObject[3]=aForm.TXT_RATE;
		myObject[4]=null;	
		myObject[5]=aForm.TXT_DATE_FROM;
		myObject[6]=aForm.TXT_MONTH_FROM;
		myObject[7]=aForm.TXT_YEAR_FROM;	
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.TXT_CLIENT.value;
 		myObject_value[1]=null;

 		var myObject_type=new Array(); //passing values data type
		myObject_type[0]="StringL";
 		myObject_type[1]=null;	
 	
 		var qid='32';
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
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&hid='+hid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400, // 500,
		 width: 500, //900,
		 title: 'SasiNet Frame work',
		 scrollable: true,
			
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
	}
		//----------------------------------------------**
		
		function seccheck(){
			if (document.Form1.TXT_ISCODE.value!="") {
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"securities_restriction?chksql=check_sec&sec_code="+document.Form1.TXT_ISCODE.value;
				top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				if (m_size==0) {
					view_help1(document.Form1.TXT_ISCODE);
					document.Form1.TXT_ISCODE.focus();
				}else{
					document.Form1.TXT_ISCODE.value=top.frames[0].document.applets[0].outvec_value.elementAt(0);
					get_data1();
				}
			}
		}
		
		
		
		function display_dat(){
		//	alert( data_vec.length);
			document.getElementById('div_lable').innerHTML='Client Limit - New'; 
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=get_dat";
			//window.open(m_url);
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
			
			if(m_size>0){	
				/*document.Form1.TXT_DATE.value= top.frames[0].document.applets[0].outvec_value.elementAt(0).substring(0,2);
				document.Form1.TXT_MONTH.value= top.frames[0].document.applets[0].outvec_value.elementAt(0).substring(3,5);
				document.Form1.TXT_YEAR.value= top.frames[0].document.applets[0].outvec_value.elementAt(0).substring(6,10);
				*/
				document.Form1.TXT_DATE_FROM.value= data_vec[0].substring(0,2);
				document.Form1.TXT_MONTH_FROM.value= data_vec[0].substring(3,5);
				document.Form1.TXT_YEAR_FROM.value= data_vec[0].substring(6,10);
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
		
		//----------------------Calander---------------**
		$(document).ready
			(
				
				function() 
				{
					//initDialog();
					initCal('TXT_START_DATE');
                    initCal('TXT_END_DATE');
					//initDialogPOPup();
				}
			);
			
			
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
               if (instance_id == "TXT_START_DATE") {
                   document.Form1.TXT_DATE_FROM.value = splitResult[0];
                   document.Form1.TXT_MONTH_FROM.value = splitResult[1];
                   document.Form1.TXT_YEAR_FROM.value = splitResult[2];
                   document.Form1.TXT_YEAR_FROM.focus();
               }
               else if (instance_id == "TXT_END_DATE") {
                   document.Form1.TXT_RDATE_FROM.value = splitResult[0];
                   document.Form1.TXT_RMONTH_FROM.value = splitResult[1];
                   document.Form1.TXT_RYEAR_FROM.value = splitResult[2];
                   document.Form1.TXT_RYEAR_FROM.focus();
               }
              
           }
		//-------------------------------------**
		function ratecheck(){
		
		var rate =document.Form1.TXT_RATE.value;
			rate =unformat_noobject(document.Form1.TXT_RATE.value);
			
			if(rate>100){
			alert("Rate is grater than 100%");
			document.Form1.TXT_RATE.value=0;
			document.Form1.save_but.disabled=true;	
			}
			else if(rate<0){
			alert("Rate is lower than 0%");
			document.Form1.TXT_RATE.value=0;
			document.Form1.save_but.disabled=true;		
			}
			else{
			document.Form1.save_but.disabled=false;	
			}
			
		}
		function obtain_report_before()
		{
		    document.Form1.save_but.disabled=true;	
			sec_help2(0);
		}
		
	</SCRIPT>
	</HEAD>	
	<BODY class="body & txt-body" onload="display_dat();" ><!-- ONLOAD="display_sec_opt()"-->
		<!--<BODY ONLOAD="display_sec_opt()"> -->
		
		<FORM NAME="Form1" ID="Form1" METHOD="POST"  >
			<INPUT TYPE="Hidden" NAME="Hid_scr_name" VALUE="" >
			<INPUT TYPE="Hidden" NAME="Hid_inst_cat" VALUE="" >
			<INPUT TYPE="Hidden" NAME="SAVETYPE" ID="SAVETYPE" VALUE="NEW">
			
			<!---------------------------------->				
		<DIV>
			<TABLE class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
			
			<tr>
			<td height='7'></td>
			</tr>
				
			<tr height='30' >
			<td  width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
			<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'> <B> 	Administration - Client Master Sub Module</B></td>
		<!--	<td  width='50px' style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='right'><B> <DIV ID="div_scr_status" NAME="div_scr_status" ></DIV></B></td>-->
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
	    <!---------------------------------------------------------------->		
						
	
						
		<!-------------------------------------------------------------------->			
			<TABLE WIDTH="100%" BGCOLOR="darkblue" >
				<TR >
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="NEW" VALUE="Add"   onClick="entry_mode('new'); display_dat();"  class="mainbut"  >
					</TD>
								
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="MOD" VALUE="Edit" onClick="entry_mode('mod')  " class="mainbut"  >
					</TD>
					
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="DEL" VALUE="Delete"   onClick= "entry_mode('del')"  class="mainbut"  >
					</TD>				
								
					<TD WIDTH='6%'></TD>	
			
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="save_but" VALUE="Save"   onClick="beforesubmit()" class="mainbut"  >
					</TD>

					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"   onClick ="clear2()"  class="mainbut"> 
					</TD>
								
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit"   onClick="location.href='low.jsp'" class="mainbut"> 
					</TD>
								
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="report_but" VALUE="Enquiry"    onClick="obtain_report_before()" class="mainbut">
					</TD>

					<!--<TD  WIDTH="50%" class="hh1" align="right">-->
					<!--<B>	Client Limit</B>-->
					<TD> <B><div id='div_lable' align='right' > </div> </B> </TD>								
									
					</TD>					
				</TR>
			</TABLE>
						
			<!---------------------------->
			 <TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
			</TABLE>
			<HR>
			<TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
			</TABLE>
			<!----------------------------->
						
			<table width="100%" border="0" cellpadding="1" cellspacing="0" >
			<TR>
					<TD WIDTH="1%"></TD>
					<TD  WIDTH="16%">Facility No</TD>
					<TD><INPUT TYPE="Text" NAME="TXT_CLIENT"  ALIGN="LEFT" SIZE=27 MAXLENGTH=19 class="txt_input6"  onchange="portcheck()" onblur="portcheck()"> 
					<INPUT TYPE="BUTTON" NAME="but_CLIENT" value="..." class="mainbut" ONCLICK="Client_help()">
					</TD>	
				</TR>
							
				<TR>
					<TD WIDTH="1%"></TD>
					<TD  WIDTH="16%">Client Limit</TD>
					<TD><INPUT TYPE="Text" NAME="TXT_LIMIT" ALIGN="RIGHT" class="txt_input7" SIZE=27 MAXLENGTH=19 ><!-- onchange="seccheck()" onblur="seccheck()"-->
					</TD>
					
					<TD WidTH="25%">
					</TR>
					
				<TR>
						<TD WIDTH="1%"></TD>
						<TD  WIDTH="16%">Rate % </TD>
						<TD><INPUT TYPE="Text" NAME="TXT_RATE" ALIGN="RIGHT" class="txt_input7" SIZE=27 MAXLENGTH=19 onblur="ratecheck();" ><!-- onchange="seccheck()" onblur="seccheck()"-->
							<!--<INPUT TYPE="button" VALUE="Help" NAME="BUT_ISCODE" STYLE="{color: black; font: bold 8pt arial;}" onClick="view_help1()">--></TD>
						<TD WidTH="25%">
						</TR>
						
						<TR>
							<TD WIDTH="1%"></TD>
							<TD WIDTH="16%">Rate Effective Date</TD>
							<TD><INPUT TYPE="Text" NAME="TXT_DATE_FROM"  SIZE="3" MAXLENGTH="2" class="txt_input5" >
								<INPUT 	   TYPE="Text" NAME="TXT_MONTH_FROM" SIZE="3" MAXLENGTH="2" class="txt_input5" >
								<INPUT 	   TYPE="Text" NAME="TXT_YEAR_FROM"  SIZE="5" MAXLENGTH="4" class="txt_input5" ONBLUR="chkstartdate(document.Form1.TXT_DATE_FROM,document.Form1.TXT_MONTH_FROM,document.Form1.TXT_YEAR_FROM)">
							<input type = "hidden" name = "TXT_START_DATE" id = "TXT_START_DATE" /> </TD>
							</TD>
							<TD></TD>
						</TR>
						
						
					</TABLE>
					
					
					
					
					
					
				</TD>
			</TD>
		</TABLE>
	</TABLE>
	</FORM>
	<!--SCRIPT LANGUAGE="JavaScript" SRC="http://www.srilanka.sasianet.lk/home/mbfsl.js"></SCRIPT--> 
	<SCRIPT language1.2="JavaScript" src="validate_v1.js"></SCRIPT>
	<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
</BODY>
		</HTML>
		
