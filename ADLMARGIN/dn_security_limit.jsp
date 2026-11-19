<HTML>
	<HEAD>
		<TITLE>Margin Traging</TITLE>
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

		
	
	<SCRIPT language="JavaScript">
		
		var a=1;
		var f=1;
		//var flag_disable;  // --Yohan on 23-06-2006 for VC 06/009
		
		
		
		
		
		
		
		
		
		
		<!----------FIRST HELPBOX OPERATION--------------------------------------------------------------------->		
		function myDialogObj() {
			var htmlstr; 
			var returnval;
		}
		
		function get_data1(){
			
			
			//if (document.Form1.TXT_ISCODE.value!="" && document.Form1.TXT_CLIENT.value!="" &&document.Form1.TXT_ISCODE.value!=" " && document.Form1.TXT_CLIENT.value!=" "){
			
			if (document.Form1.TXT_ISCODE.value!=""  &&document.Form1.TXT_ISCODE.value!=" " ){	
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"securities_restriction?chksql=get_rest_limit_data&sec_code="+document.Form1.TXT_ISCODE.value+"&port_code="+document.Form1.TXT_CLIENT.value;
				//window.open(m_url);
				
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
				
				
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				
				vec_pos=0;
				m_row="";
				lineno=1;
				while (vec_pos<m_size) {
					//m_acc_no=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
					//m_acc_no_refno=parent.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
					//m_acc_no=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
					//document.Form1.Status.value=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
					document.Form1.TXT_ISCODE.value=data_vec[0];
					document.Form1.TXT_CLIENT.value=data_vec[1];
					document.Form1.TXT_Rate.value=data_vec[2];
					
					document.Form1.TXT_DATE_FROM.value=data_vec[3];
					document.Form1.TXT_MONTH_FROM.value=data_vec[4];
					document.Form1.TXT_YEAR_FROM.value=data_vec[5];
					
					vec_pos=vec_pos+6;
					lineno=lineno+1;
				}
				
				
			}		
		}	
		
		/* function view_help1(){
			
			val=(Form1.SCR_TYPE.selectedIndex);
			//alert(val);
			//val=1;
			if (val==0){
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
			}else if(val==1 || val==2){
				
				//bankcode=document.Form1.TXT_ITYPE.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"securities_restriction?chksql=view_mod_help12&sec_code="+document.Form1.TXT_ISCODE.value;
				
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
					
					m_rate=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+2);
					m_value_date=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+3);
					
					m_row=m_row+'<TR STYLE="{color:black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white"  ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_acc_no+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_acc_no_refno+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_rate+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_value_date+'</B></TD></TR>';
					vec_pos=vec_pos+4;
					lineno=lineno+1;
				}
				m_writedata ='<TABLE BGCOLOR="gray" WIDTH="100%" STYLE="{color: darkblue; font: 9pt sans-serif;}">'+
					'<TR BGCOLOR="darkgray"><TD WIDTH="20%"><B>Security Code</B></TD>' +
					'<TD WIDTH="45%"><B>Issuer Name</B></TD><TD WIDTH="15%"><B>Rate</B></TD><TD WIDTH="20%"><B>Value Date</B></TD></TR>'+
					m_row+
					'</TABLE>'; 
				myDialogObj.htmlstr = m_writedata;
				myDialogObj.returnval = "";
				popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
				document.Form1.TXT_ISCODE.value=myDialogObj.returnval
					document.Form1.TXT_ISCODE.focus();
				
			}
			
			
		} */
		
		
		//-------------------------------------------**
		function view_help1(){

			if(document.Form1.SAVETYPE.value=="NEW"){
				sec_help1(0)
		//	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"securities_restriction?chksql=view_mod_help11&sec_code="+document.Form1.TXT_ISCODE.value;	
			}
			else if(document.Form1.SAVETYPE.value=="MOD"){
				sec_help2(0)
		//	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"securities_restriction?chksql=view_mod_help12&sec_code="+document.Form1.TXT_ISCODE.value;	
			}
			else if(document.Form1.SAVETYPE.value=="DEL"){
				sec_help2(0)
		//	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"securities_restriction?chksql=view_mod_help12&sec_code="+document.Form1.TXT_ISCODE.value;	
			}
		}
		//----------------------------------------help1**
		function	sec_help1(m_strat){
			
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	
		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.TXT_ISCODE;
 		myObject[1]==null;
 		
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.TXT_ISCODE.value;
 		myObject_value[1]=null;

 		var myObject_type=new Array(); //passing values data type
		myObject_type[0]="StringL";
 		myObject_type[1]=null;	
 	
 		var qid='33';

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
 		myObject[0]=aForm.TXT_ISCODE;
 		myObject[1]=null;
 		myObject[2]=aForm.TXT_Rate;
		myObject[3]=aForm.TXT_DATE_FROM;
		myObject[4]=aForm.TXT_MONTH_FROM;
		myObject[5]=aForm.TXT_YEAR_FROM;
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.TXT_ISCODE.value;
 		myObject_value[1]=null;

 		var myObject_type=new Array(); //passing values data type
		myObject_type[0]="StringL";
 		myObject_type[1]=null;	
 	
 		var qid='34';

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
			//alert(document.Form1.SAVETYPE.value);
			// alert(parent.Frames[0].document.Form1.SCR_TYPE.options[parent.Frames[0].document.Form1.SCR_TYPE.selectedIndex].VALUE);
			/* remove port by waruna 2011-04-22
			if (document.Form1.TXT_CLIENT.value=="") {
				alert('Please enter Portfolio code');
				document.Form1.TXT_CLIENT.focus();
				portcheck();
			}
			else
			*/	if (document.Form1.TXT_ISCODE.value=="") {
				alert('Please enter security code');
				document.Form1.TXT_ISCODE.focus();
				seccheck();
			}else if (document.Form1.TXT_Rate.value=="") {
				alert('Please enter Rate');
				document.Form1.TXT_Rate.focus();
				
			}
			//*****add Date validation by waruna 2011-04-22
			else if (document.Form1.TXT_YEAR_FROM.value=="") {
				alert('Please enter Date');
				document.Form1.TXT_YEAR_FROM.focus();
				chkstartdate(document.Form1.TXT_DATE_FROM,document.Form1.TXT_MONTH_FROM,document.Form1.TXT_YEAR_FROM);
			}
			
			else {

				document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"securities_restriction?chksql=Sec_limit_save";
				document.Form1.submit();					
			}
		}			
		
		//------- CANCEL AND EXIT OPERATION--------------------------------		
		function	cancelling(){
			Form1.reset();
			//display_sec_opt();
		}
		/*function	display_sec_opt(VAL){
			//alert(parent.frames[0].document.Form1.SCR_TYPE.options[parent.frames[0].document.Form1.SCR_TYPE.selectedIndex].value);
			document.Form1.SAVETYPE.value=document.Form1.SCR_TYPE.options[document.Form1.SCR_TYPE.selectedIndex].value;
			clear_screen();
		}*/
		
		function display_sec_opt(val){
			
			if(val=="new"){
			document.getElementById('div_lable').innerHTML='Security Limit - New'; 
			document.getElementById('SAVETYPE').value="NEW";
			//alert(parent.frames[0].document.Form1.SCR_TYPE.options[parent.frames[0].document.Form1.SCR_TYPE.selectedIndex].value);
			//document.Form1.SAVETYPE.value=Form1.SCR_TYPE.options[document.Form1.SCR_TYPE.selectedIndex].value;
					clear_screen();
			}else if(val=="mod"){
					document.getElementById('div_lable').innerHTML='Security Limit -Edit'; 
					document.getElementById('SAVETYPE').value="MOD";
					clear_screen();
			}else if(val=="del"){
					document.getElementById('div_lable').innerHTML='Security Limit - Delete'; 
					document.getElementById('SAVETYPE').value="DEL";
					clear_screen();
			}
		}
		
		function clear_screen(){
			document.Form1.TXT_Rate.value="";
			document.Form1.TXT_ISCODE.value="";
			document.Form1.TXT_DATE_FROM.value="";
			document.Form1.TXT_MONTH_FROM.value="";
			document.Form1.TXT_YEAR_FROM.value="";
			
		}
		function screenclose(){
			top.frames[1].location='low.jsp';
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
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"accvalwizard?chksql=portfolio_help&port_code="+document.Form1.TXT_CLIENT.value;
			//boffice_reports_clc_1?client_data="+document.Form1.TXT_CLIENT.value+"&chksql=clc_data";
			top.frames[0].document.applets[0].getdata(m_url);
			
			m_size=top.frames[0].document.applets[0].outvec_value.size();
			//alert(top.frames[0].document.applets[0].outvec_value);
			vec_pos=0;
			m_row="";
			lineno=1;
			while (vec_pos <m_size) {
				
				m_port=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
				m_Des=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
				m_row=m_row+'<TR STYLE="{color:black; cursor:hand font: bold 9pt Arial;}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+');><TD ID=C1R'+lineno+'>'+
					'<B>'+m_port+'</B></TD><TD ID=C2R'+lineno+'><B>'+m_Des+'</B></TD></TR>';
				vec_pos=vec_pos+2;
				lineno=lineno+1;
			}
			
			m_writedata ='<TABLE BGCOLOR="gray" WIDTH="100%" STYLE="{color:black; font: bold 9pt Arial;}">'+
				'<TR BGCOLOR="silver"><TD WIDTH="25%"><B>Portfolio Code</B></TD>' +
				'<TD WIDTH="75%"><B>Name</B></TD></TR>'+m_row+
				'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval = "";
			popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:21em; dialogHeight:15em; center:yes; resizable:yes; status:no");
			document.Form1.TXT_CLIENT.value=myDialogObj.returnval;
			document.Form1.TXT_CLIENT.focus();
		}
		
		function portcheck(){
			if (document.Form1.TXT_CLIENT.value!="") {
				m_portcode=document.Form1.TXT_CLIENT.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"securities_restriction?port_code="+m_portcode.toUpperCase()+"&chksql=chk_port";
				top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				if (m_size==0) {
					Client_help(document.Form1.TXT_CLIENT);
					document.Form1.TXT_CLIENT.focus();
				}else{
					document.Form1.TXT_CLIENT.value=top.frames[0].document.applets[0].outvec_value.elementAt(0);
					get_data1();
				}
			}
		}
		
		function seccheck(){
			
			if (document.Form1.TXT_ISCODE.value!="") {
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"securities_restriction?chksql=check_sec&sec_code="+document.Form1.TXT_ISCODE.value;
				
				
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
				
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();

				if (m_size==0) {
					if(document.Form1.SAVETYPE.value=="NEW"){
					document.Form1.TXT_ISCODE.value="";	
					sec_help1(0)		
					}
					else if(document.Form1.SAVETYPE.value=="MOD"){
					document.Form1.TXT_ISCODE.value="";	
					sec_help2(0)
					}
					else if(document.Form1.SAVETYPE.value=="MOD"){
					document.Form1.TXT_ISCODE.value="";	
					sec_help2(0)
					}
					
				}else{
					document.Form1.TXT_ISCODE.value=data_vec[0];
					get_data1();
				}
				get_data1();
			}
			
			
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
                   document.Form1.TXT_TODATE.value = splitResult[0];
                   document.Form1.TXT_TOMONTH.value = splitResult[1];
                   document.Form1.TXT_TOYEAR.value = splitResult[2];
                   document.Form1.TXT_TOYEAR.focus();
               }
              
           }
		//-------------------------------------**
		
		function display_dat(){ 
		  m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=get_dat";
		  load_interface(m_url,'XML',false);
			
			m_size= data_vec.length;
			if(m_size>0){	
		        document.Form1.TXT_DATE_FROM.value=data_vec[0].substring(0,2);
		        document.Form1.TXT_MONTH_FROM.value=data_vec[0].substring(3,5);
		        document.Form1.TXT_YEAR_FROM.value=data_vec[0].substring(6,10);
				
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
		
	</SCRIPT>
	</HEAD>	
	<BODY class="body & txt-body" ONLOAD="display_sec_opt('new'); display_dat();">
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
			<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'> <B> 	Administration - Security</B></td>
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
						<INPUT TYPE="Button" NAME="NEW" VALUE="Add"   onClick="display_sec_opt('new')"  class="mainbut"  >
					</TD>
								
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="MOD" VALUE="Edit" onClick="display_sec_opt('mod')  " class="mainbut"  >
					</TD>
					
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="DEL" VALUE="Delete"   onClick= "display_sec_opt('del')"  class="mainbut"  >
					</TD>				
								
					<TD WIDTH='6%'></TD>	
			
					<TD WIDTH="6%">	
						<INPUT TYPE="Button" NAME="save_but" VALUE="Save"   onClick="beforesubmit()" class="mainbut"  >
					</TD>

					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"   onClick ="clear_screen()"  class="mainbut"> 
					</TD>
								
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit"   onClick="location.href='low.jsp'" class="mainbut"> 
					</TD>
								
					<TD WIDTH="6%">
						<INPUT TYPE="Button" NAME="report_but" VALUE="Enquiry"    onClick="obtain_report_before()" class="mainbut">
					</TD>
								
					
					<!--<TD  WIDTH="50%" class="hh1" align="right">-->
					<!--<B>Security Limit</B>-->
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
				<!-- Client code Remove by waruna 2011-04-21 becouse MR.Nilipul@FCL said no need--> 
				<TR>
					<TD WIDTH="1%"></TD>
					<TD><INPUT TYPE="hidden" NAME="TXT_CLIENT"  ALIGN="LEFT" SIZE=27 MAXLENGTH=19 class="txt_input6" onchange="portcheck()" onblur="portcheck()"> 
					<INPUT TYPE="hidden" NAME="but_CLIENT" value="..."  class="mainbut"  ONCLICK="Client_help()">
					</TD>
				</TR>
	
				<TR>
					<TD WIDTH="1%"></TD>
					<TD WIDTH="16%">Internal Security Code</TD>
					<TD><INPUT TYPE="Text" NAME="TXT_ISCODE" ALIGN="LEFT" SIZE=27 MAXLENGTH=19 class="txt_input6" onchange="seccheck()" onblur="seccheck()">
						<INPUT TYPE="button" VALUE="..." NAME="BUT_ISCODE"  class="mainbut"  onClick="view_help1()"></TD>
					<TD WidTH="25%">
					</TR>
					
					<TR>
						<TD WIDTH="1%"></TD>
						<TD WIDTH="16%"> Rate %</TD>
						<TD>  <INPUT TYPE="Text" NAME="TXT_Rate"	STYLE="{text-align:right;}" class="txt_input6" SIZE=27 MAXLENGTH=7 onBlur=isNaN(document.Form1.TXT_Rate.value)>
						</TD>
						<TD></TD>
					</TR>
					<!--Date adbb by waruna 2011-04-22 -->
					<TR>
						<TD WIDTH="1%"></TD>
						<TD WIDTH="16%">Date</TD>
						<TD><INPUT TYPE="Text" NAME="TXT_DATE_FROM"  SIZE="3"  	class="txt_input5"  MAXLENGTH="2">
							<INPUT	   TYPE="Text" NAME="TXT_MONTH_FROM" SIZE="3" 	class="txt_input5"  MAXLENGTH="2">
							<INPUT	   TYPE="Text" NAME="TXT_YEAR_FROM"  SIZE="5"  	class="txt_input5"  MAXLENGTH="4" ONBLUR="chkstartdate(document.Form1.TXT_DATE_FROM,document.Form1.TXT_MONTH_FROM,document.Form1.TXT_YEAR_FROM)">
						<input type = "hidden" name = "TXT_START_DATE" id = "TXT_START_DATE" />
									
						</TD>
						<TD></TD>
					</TR>
					<!--End Date adbb by waruna 2011-04-22 -->
					
					
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
		
