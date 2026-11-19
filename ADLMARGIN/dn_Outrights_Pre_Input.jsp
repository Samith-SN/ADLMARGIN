<HTML>
	<HEAD>
		<TITLE>Margin Trading 
		</TITLE>
		
	            </HEAD>
<%@page import="net.sasianet.ADLMARGIN.*" %> 
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.Statement" %>
	
	<%	
	Connection connection;
	Statement statement;
	ResultSet resultSet;
	String sql;
	
	
	String sysdate="";
		   session             = request.getSession(true);
			
		ADLMARGIN_MGT_conn_methods m_sn_methods1 = new ADLMARGIN_MGT_conn_methods(session);
		String m_html_client_url = m_sn_methods1.html_client_url;
		String m_schema_name     = m_sn_methods1.schema_name.trim();
		String m_client_name     = m_sn_methods1.client_name;
			connection           = m_sn_methods1.met_user_validate();
		Object done = (String)session.getValue("logon.isDone"); // marker object
		if (done == null) {
			out.println("<html><head>");
			out.println("<script language='JavaScript'>");
			out.println("function displaymsg() {");
			out.println("alert('Your login expired or invalid');");
			out.println("window.location.href='"+m_html_client_url+"/login.htm';");
			out.println("}</script></head>");
			out.println("<body onload='displaymsg();'></body>");
			out.println("</html>");
			out.flush();
			return;
		}
		
		ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
		String m_jsp_client_url=m_sn_methods.jsp_client_url;
		
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/redmond/jquery-ui.css' TYPE=\"text/css\">");
		
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
		
		/* Get The Sysdate */
	sql = " " +
		"   SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY') SYSTEM_DATE " +
		"   FROM   DUAL " +
		" ";
	
	statement = connection.createStatement();
	resultSet = statement.executeQuery(sql);
	while (resultSet.next()) {
		sysdate = resultSet.getString("SYSTEM_DATE");
	}
	resultSet.close();
	statement.close();
		
	%>
	<SCRIPT language="JavaScript">
		var m_user="";
		
		a=1;
		b=1;
		c=1;	
		var cal_status=false;
		var iframe_html_string = '<iframe id = "IFRAME_DRILL_DOWN" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Drill Down"></iframe>';
		
		
		
		
		

  $(document).ready(function() 
				{
					initCal('VAL_TXT_DATE');
					initCal('VAL_TXT_DATE_2');
					initCal('VAL_TXT_REBATES_DATE_2');
					initDrillDownDialog();
					//initmsgDrillDialog();
					//initmsgDrillDialog();
					m_grid_height = ($(window).height() - 310);
					m_grid_width = ($(window).width() - 0);
					//bind_events();
				});	
		
	function initDrillDownDialog(){
				$('#DIV_MSG_WINDOW').dialog({
						bgiframe: true,
						autoOpen: false,
						modal: false,
						height: 500,
						width: getW
					});
				$('#DIV_DRILL_DOWN_2').dialog({
						bgiframe: true,
						autoOpen: false,
						modal: false,
						height: 500,
						width: getW
					});
			}	
			
			function pop_up_message(m_url){					
				if ($("#DIV_MSG_WINDOW").dialog("isOpen")) 
				{
					$("#DIV_MSG_WINDOW").dialog("close");
				}
				$("#DIV_MSG_WINDOW").dialog("option", "title", "Details");
				$("#DIV_MSG_WINDOW").dialog("open");
				$("#IFRAME_MSG_WINDOW").attr("src",m_url);
				//alert(m_url);
				return false;
				
			}
		
			
			
			function hide_image(){
				$("#DIV_MSG_WINDOW").dialog("close");
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
			
			function clearIsOpen()
			{ 
				isOpen=false; 
			}
			
			var isOpen=false;
			
			function initmsgDrillDialog()
			{
				
				$("#DIV_MSG_WINDOW").dialog(
					
					{
						
						bgiframe: true,
						autoOpen: false,
						//modal: false,
						modal: true, //to disable the back ground	
						height: 300,
						width: getW,
						close: function() 
						{
							
						}
					}
				);
			}	
		
	function clearAll(){
		
	    top.frames[1].location.href='dn_Outrights_Pre_Input.jsp';
	}	
		
	function enquiry(){
		
		document.Form1.save_but.disabled = true;
		document.Form1.Text_deal_ref.disabled =false;
		
		var m_deal_no=prompt("Please enter Deal Reference ","");
		if (m_deal_no!=null && m_deal_no!=""){
			document.Form1.Text_deal_ref.value=m_deal_no;	
		}
       	dealrefrs_help(0);
		}	
	
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
                   document.Form1.Text_chq_date1.value = splitResult[0];
                   document.Form1.Text_chq_month1.value = splitResult[1];
                   document.Form1.Text_chq_year1.value = splitResult[2];
                   document.Form1.Text_chq_year1.focus();
               }
			  if (instance_id == "VAL_TXT_DATE_2") {
                   document.Form1.Text_new_date1.value = splitResult[0];
                   document.Form1.Text_new_month1.value = splitResult[1];
                   document.Form1.Text_new_year1.value = splitResult[2];
                   document.Form1.Text_new_year1.focus();
               }
			 if (instance_id == "VAL_TXT_REBATES_DATE_2") {
                   document.Form1.Text_rebates_new_date1.value  = splitResult[0];
                   document.Form1.Text_rebates_new_month1.value = splitResult[1];
                   document.Form1.Text_rebates_new_year1.value  = splitResult[2];
                   document.Form1.Text_rebates_new_year1.focus();
               }
		}	
		
		function security_ident_help1(m_strat){
			//val=(document.Form1.SCR_TYPE.selectedIndex);
			//val=(document.Form1.Hid_scr_name2.value);
				var aForm;    //  aForm =oForm.elements;
     				aForm =  document.getElementById('Form1');
	
                var myObject    = new Array(); //return values set to this object
 					myObject[0] = aForm.txt_security_ident;
					myObject[1] = null;
 					myObject[2] = null;
  
 				var myObject_value     = new Array(); //passing values set to this object
 					myObject_value[0]  = aForm.txt_security_ident.value;
					myObject_value[1]  = aForm.txt_security_ident.value;
 	
 
 
 				var myObject_type = new Array(); //passing values data type
 					myObject_type[0]  = "StringL";
 					myObject_type[1]  = "StringL";
            
 				var qid        = '15';
    				title_name = 'Help';
 				var url        = 'popup.jsp';
				var close_fun  = 'close_security_ident_help1';			
 				var json_text  = JSON.stringify(myObject_value, null,0);
 				var json_obj_type_text = JSON.stringify(myObject_type, null,0);
 				var fn_name    = arguments.callee.name;
					//JSON.parse(str) 
					//alert(json_text);
       				$.showModalDialog({
					url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
				 	dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
					height:400,// 500,
					width: 600,//900,
		 			title: 'SasiNet Frame Work',
		 			scrollable: true,
		 			onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});

			
			
	}
	function close_security_ident_help1(){
	
	}	
	function clinet_help1(m_strat){
		
	            var aForm;    //  aForm =oForm.elements;
     				aForm =  document.getElementById('Form1');
	
                var myObject    = new Array(); //return values set to this object
 					myObject[0] = aForm.txt_client;
					myObject[1] = null;
 					myObject[2] = aForm.txt_client_cds;
		            myObject[3] = aForm.div_clinet_name;
		            myObject[4] = aForm.txt_broker; 
		            myObject[5] = aForm.txt_advisor;
                    myObject[6] = aForm.txt_advisor_code; 
		
		            myObject[7]  = aForm.txt_broker_tel; 
		            myObject[8]  = null; 
		            myObject[9]  = null; 
		            myObject[10] = aForm.txt_broker_email; 
		            myObject[11] = aForm.txt_broker_fax; 
		            //myObject[12] = aForm.txt_broker_fax; 
 				var myObject_value     = new Array(); //passing values set to this object
 					myObject_value[0]  = aForm.txt_client.value;
					myObject_value[1]  = aForm.txt_client.value;
 	                myObject_value[2]  = aForm.txt_client.value;
					myObject_value[3]  = aForm.txt_client.value;
 
 
 				var myObject_type = new Array(); //passing values data type
 					myObject_type[0]  = "StringL";
 				    myObject_type[1]  = "StringL";
                    myObject_type[2]  = "StringL";
		            myObject_type[3]  = "StringL";
		
 				var qid        = '1003';
		        var hid        = '5';
    				title_name = 'Help';
 				var url        = 'popup.jsp';
				var close_fun  = 'close_security_ident_help1';			
 				var json_text  = JSON.stringify(myObject_value, null,0);
 				var json_obj_type_text = JSON.stringify(myObject_type, null,0);
 				var fn_name    = arguments.callee.name;
					//JSON.parse(str) 
					//alert(json_text);
       				$.showModalDialog({
					url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&hid='+hid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&close_fun='+close_fun,
				 	dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
					height:400,// 500,
					width: 800,//900,
		 			title: 'SasiNet Frame Work',
		 			scrollable: true,
		 			onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); 
							if(returnedValue!=null){
								mod_display6();
								get_facility_details(new String(returnedValue[1]));
							} } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
		
	}	
		
		function select_screen(val){
		
			if(val=='os_order'){
				
			var m_facility_no = document.getElementById('Form1').txt_client.value;
			var  m_url  =jsp_client_url+"/veiw_os_order.jsp?chksql=os_order&facility_no="+m_facility_no+"";
				 window.open(m_url,'client_payment_report', 'left = 0, top = 0, toolbar = 0, location = 0, directories = 0, status = 0, menuBar = 0, scrollBars = 1, resizable = 1, width = ' + screen.availWidth + ', height = ' + screen.availWidth);
			
				
			}else if(val=='order_history'){
			   
			var  m_facility_no = document.getElementById('Form1').txt_client.value;
			var  m_url  =jsp_client_url+"/veiw_os_history.jsp?chksql=order_history&facility_no="+m_facility_no+"";
				 window.open(m_url,'client_payment_report', 'left = 0, top = 0, toolbar = 0, location = 0, directories = 0, status = 0, menuBar = 0, scrollBars = 1, resizable = 1, width = ' + screen.availWidth + ', height = ' + screen.availWidth);
				
				
			}
			
			
		}
		
		function beforesubmit(){
		
		   
			if(validate_submit()){
			for (var i=0; i < document.Form1.elements.length; i++ ) {
					document.Form1.elements[i].disabled=false;
					
					if(  document.Form1.elements[i].type == 'text'){
					 document.Form1.elements[i].value = unformat_noobject(document.Form1.elements[i].value); 
					}
					 
					
					
				}
			
		    document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"fsavpre_autho";
		    document.Form1.submit();
			
			}		
			
		}
		
		function validate_submit(){
		
			if(document.getElementById('Form1').txt_client.value==''){
			    
				alert('Please enter Client');
				return false;
				
			}else if(document.getElementById('Form1').txt_security_ident.value==''){
			   
				alert('Please enter Security Identification');
				return false;
			
			}
			else if(document.getElementById('Form1').txt_price_min.value=='' || document.getElementById('Form1').txt_price_min.value=='Min' || document.getElementById('Form1').txt_price_max.value=='' || document.getElementById('Form1').txt_price_max.value=='Max'){
			   
				alert('Please enter Price Range');
				return false;
			
			}else if(document.getElementById('Form1').txt_no_of_shares.value==''){
			   
				alert('Please enter No of Shares');
				return false;
			
			}else if(parseFloat(unformat_noobject(document.getElementById('Form1').txt_price_min.value))>parseFloat(unformat_noobject(document.getElementById('Form1').txt_price_max.value))){
				
				document.getElementById('txt_price_max').disabled=false; 
			    alert('Max price should be greater than or equal  Min');
				return false;
			}else if(parseFloat(unformat_noobject(document.getElementById('Form1').txt_client_un_util_amount.value))<parseFloat(unformat_noobject(document.getElementById('Form1').txt_brokerage_max.value))){
			  
				
			  alert('Max Value With Brokerage should be lower than or equal  Un-Utilized Amount');	
			  return false;
			}
			
			
			
			else{
			 return true;
			}
			
		}
		
		function clear_text(obj){
		  obj.value="";	
		}
		
		
		<!----------------------------mod-display-------------------------------------------->
		function mod_display6() {
			
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bval_advise?chksql=adv_email&advcode="+document.Form1.txt_advisor_code.value;
			//window.open(m_url);
			load_interface(m_url,'XML',false);
			m_size7 = data_vec.length;
		
			var j=0;
			var p=0;
			var m_writedata = "";
			
			//document.getElementById()
			   Email1.innerHTML="";
			
			
			if (m_size7 >0) {
			m_writedata += "<table width='1025' border='0' cellpadding='0' cellspacing='0'>";
				
				while(p<m_size7) { 
					j=j+1;
								   
				   m_writedata+= "<tr>";						
                   m_writedata+= "   <td width='20' >&nbsp;</td>";
                   m_writedata+= "    <td><table cellspacing='0' cellpadding='0'>";
                   m_writedata+= "     <td width='200' >Advisor E-mail "+j+"</td>";
                   m_writedata+= "     </table></td>";
                   m_writedata+= "     <td >";
                   m_writedata+= "       <INPUT TYPE='Text' NAME='TXT_MAIL"+j+"'	class='txt_input6' ALIGN='LEFT' VALUE="+data_vec[p]+">";
                   m_writedata+= "     </td>";
                   m_writedata+= "     <td width='140'>&nbsp;</td>";
                   m_writedata+= "     <td width='140'>&nbsp;</td>";
                   m_writedata+= "     <td width='150'>&nbsp;</td>";
                   m_writedata+= "     <td width='300'>&nbsp;</td>";
                   m_writedata+= "    </tr>";
					
					p=p+1;
								
					document.Form1.Hid_adv_email_nam.value=j;
				}
				m_writedata += "</table>";
				Email1.innerHTML+=m_writedata;
			}	
		}
		
		function cal_brokerage(){
		
	     var form   =	 document.getElementById('Form1');	 
		 var m_price_min  = unformat_noobject(form.txt_price_min.value);
		 var m_price_max  = unformat_noobject(form.txt_price_max.value);
		 var m_no_of_share = unformat_noobject(form.txt_no_of_shares.value);	
			
		 if(m_price_min=='' || m_price_max=='' ){
			alert('Please enter Price Range');
			return;	
			}
		 else if(m_no_of_share==''){
				
			alert('Please enter No of Shares'); 	
			return;	
		}	
		
		 var m_min_value_with_brokerage = 	parseFloat(unformat_noobject(get_broker(m_no_of_share*m_price_min)))+parseFloat(m_no_of_share*m_price_min);
			
		  form.txt_brokerage_min.value = format_noobject(m_min_value_with_brokerage);	
		  form.txt_brokerage_max.value = format_noobject(parseFloat(unformat_noobject(get_broker(m_no_of_share*m_price_max)))+parseFloat(m_no_of_share*m_price_max));
		  get_tot_trn_amount();	
					
	}
		
	 function get_broker(purchase_cost) {
			
		var m_purchase_cost = unformat_noobject(purchase_cost);
					
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?m_purchase_cost="+m_purchase_cost+"&chksql=get_broker_cost";					
		//window.open(m_url);
		load_interface(m_url,'XML',false);
		
		return format_noobject(data_vec[0]);
	   }
	
	function get_facility_details(facility_no){
		
		var m_facility_no = facility_no;
		var form   =	 document.getElementById('Form1');	
			
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalpreautho?facility_no="+m_facility_no+"&chksql=get_facility_details";					
		//window.open(m_url);
		load_interface(m_url,'XML',false);
		m_size = data_vec.length;
			
		if(m_size>0){	
		
				  
		 form.txt_client_limit_cash.value  = format_noobject(data_vec[0]);
		 form.txt_client_limit_share.value = format_noobject(data_vec[1]);
		 form.txt_client_util_amount.value = format_noobject(data_vec[2]);
		 form.txt_client_int_rate.value    = format_noobject(data_vec[3]);
		 form.txt_client_un_util_amount.value =  format_noobject((data_vec[1]-data_vec[2])/0.5);	//format_noobject(Math.min(data_vec[0],data_vec[1])-data_vec[2]);	
		 form.txt_tot_trn_amount_min.value = "0";
		 form.txt_tot_trn_amount_max.value = "0";	
		 form.Hid_val_date.value      = data_vec[4];
		 form.Hid_day_of_year.value   = data_vec[5];	
		 }	
			
	   }
		
	function loadReason(){
		
		      document.getElementById('div_lb_reason').style.visibility='hidden';
              document.getElementById('div_ob_reason').style.visibility='hidden';
			
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalpreautho?chksql=load_reason";
				//window.open(m_url);
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
				
				if(m_size>0){
					
					var m_int_reason_len=parseInt(data_vec.length);
				
					var m_count=0;
					for(m_count=0;m_count<parseInt(m_int_reason_len);){
						
					   var select = document.getElementById("cmb_reason");
					   select.options[select.options.length] = new Option(data_vec[m_count+1],data_vec[m_count]);
                        
						m_count=m_count+2;
					}
					
				}
			}	
		
	   function get_tot_trn_amount(){
		
		var form   =	 document.getElementById('Form1');
		var m_price_min = unformat_noobject(form.txt_price_min.value);
		var m_price_max = unformat_noobject(form.txt_price_max.value);
	    var m_no_of_share = unformat_noobject(form.txt_no_of_shares.value);	
		var m_leg1_min  =  unformat_noobject( form.txt_brokerage_min.value);
		var m_leg1_max  =  unformat_noobject( form.txt_brokerage_max.value);		
		var m_tenor     =  form.Hid_day_of_year.value;
		var m_yield     =  unformat_noobject(form.txt_client_int_rate.value) /100;  
		var m_base      =  'AA';			
		 form.txt_tot_trn_amount_min.value = calculate_leg2(m_leg1_min,m_tenor,m_yield,m_base, form.Hid_val_date.value)	;
		 form.txt_tot_trn_amount_max.value = calculate_leg2(m_leg1_max,m_tenor,m_yield,m_base, form.Hid_val_date.value)	;	
		}	
		
		
		function calculate_leg2(leg1,tenor,yield,basis,valdate){
			
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?chksql=calculateleg2&leg1="+leg1+"&yield="+yield+"&tenor="+tenor+"&basis="+basis+"&val_date="+valdate;
			//window.open(m_url);
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;
			
			return data_vec[0];
			
			
			
		} 
		
		function change_buy_sell(){
			
			 var m_trn_t  = "";
			
			
			if(document.getElementById('rdb_buy').checked) {
              m_trn_t = 'BUY';
			}else if(document.getElementById('rdb_sell').checked) {
              m_trn_t = 'SELL';
            }

			
			
			if(m_trn_t=='SELL'){
			  document.getElementById('div_lb_reason').style.visibility='visible';
              document.getElementById('div_ob_reason').style.visibility='visible';
			}else{
			  document.getElementById('div_lb_reason').style.visibility='hidden';
              document.getElementById('div_ob_reason').style.visibility='hidden';
			}
		     
		
		}
		
		
		
	</SCRIPT>
	
	<BODY class='body & txt-body'  onload="select_screen('ADD');loadReason();">
		<FORM  NAME="Form1" ID="Form1" METHOD="POST" >			
			<INPUT TYPE="Hidden" NAME="SCR_NAME"	VALUE="MAIN" >
			<INPUT TYPE="Hidden" NAME="hid_help_type">	
			<INPUT TYPE="Hidden" NAME="hid_eff_validate">	
			<INPUT TYPE="Hidden" NAME="Text_basis_code">	
			<INPUT TYPE="Hidden" NAME="Text_interest">	
			<INPUT TYPE="Hidden" NAME="Hid_but_type">	
			<INPUT TYPE="Hidden" NAME="Hid_PRI_DEAL_no">	
		    <INPUT TYPE="Hidden" NAME="txt_instype" VALUE = "SHARE">
			<INPUT TYPE="Hidden" NAME="hid_date"    VALUE = "<%=sysdate.substring(0,2)%>">	
			<INPUT TYPE="Hidden" NAME="hid_month"   VALUE = "<%=sysdate.substring(3,5)%>">	
			<INPUT TYPE="Hidden" NAME="hid_year"    VALUE = "<%=sysdate.substring(6,10)%>">
			<INPUT TYPE="Hidden" NAME="hid_script"  VALUE = "SL">
			<INPUT TYPE="Hidden" NAME="Hid_adv_email_nam"  VALUE = "0">
			<INPUT TYPE="Hidden" NAME="Hid_val_date"  VALUE = "">
			<INPUT TYPE="Hidden" NAME="Hid_day_of_year"  VALUE = "">
		
			
			
				<DIV>
				<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
					<tr>
						<td height='7'></td>
					</tr>
					
					<tr height='30' >
						<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
						<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Margin Trading - Data Entry</B></td>
						<td width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>
						
					</tr>
					
					
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
							
							<!--<TD WIDTH="6%">	
							<INPUT TYPE="Button" NAME="NEW" VALUE="Add"   onClick="select_screen('ADD');"  class="mainbut"  >
							</TD>
							
							<TD WIDTH="6%">	
								<INPUT TYPE="Button" NAME="MOD" VALUE="Edit"   onClick="select_screen('MOD');" class="mainbut"  >
							</TD>-->
							<TD WIDTH="6%">	
								<INPUT TYPE="Button" style="width:80px" NAME="INQ" VALUE="O/S Orders"   onClick="select_screen('os_order');" size='10' class="mainbut"  >
							</TD>
							<TD WIDTH="6%">	
								<INPUT TYPE="Button" style="width:80px" NAME="INQ" VALUE="Order History"   onClick="select_screen('order_history');" size='15'  class="mainbut"  >
							</TD>
							
							<!--<TD WIDTH="6%">	
								<INPUT TYPE="Button" NAME="REA" style="width:80px"  VALUE="Delete"   onClick="select_screen('DEL');"  class="mainbut"  >
							</TD>-->
							<TD WIDTH='6%'>&nbsp;&nbsp;&nbsp;&nbsp;</TD>		
							<TD WIDTH='6%'>&nbsp;&nbsp;&nbsp;&nbsp;</TD>	
							<!---------------------------------->
							<TD WIDTH="6%">	
								<INPUT TYPE="Button" NAME="save_but" VALUE="Save"   onClick="beforesubmit()" class="mainbut"  >
							</TD>
							
							<TD WIDTH="6%">
								<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"   onClick="clearAll()" class="mainbut"> 
							</TD>
							<TD WIDTH="6%">
								<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit"   onClick="top.frames[1].location.href='low.jsp'" class="mainbut"> 
							</TD>
							
							<TD  WIDTH="50%" class="hh1" align="right">
								<B><DIV id="div_lable">Pre Authorization Entry</DIV> </B>
							</TD>					
						</TR>
					</TABLE>
					
					
					<!----------->
					
					<TABLE WIDTH="100%"  >
						<tr ></tr>
					</TABLE>
					<HR>
					<TABLE WIDTH="100%"  >
						<tr ></tr>
					</TABLE>
			  <table width="1029" border="0" cellpadding="0" cellspacing="1">
                      <tr>
                        <td width="24">&nbsp;</td>
                        <td width="133">&nbsp;</td>
                        <td width="144">&nbsp;</td>
                        <td width="144">&nbsp;</td>
                        <td width="127">&nbsp;</td>
                        <td width="152">&nbsp;</td>
                        <td width="305">&nbsp;</td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td><table cellspacing="0" cellpadding="0">
  <td width="64">Client</td>
                        </table></td>
                        <td>
                          <input name="txt_client" type="text" class="txt_input6" id="txt_client" onblur="clinet_help1(0);" >
                      </td>
                        <td><INPUT TYPE="button" VALUE="..." NAME="BUTISCODE"  class="but_input" onClick="clinet_help1(0);" ></td>
                        <td>Client CDS </td>
                        <td>
                          <input name="txt_client_cds" type="text" class="txt_input6" id="txt_client_cds" disabled="true" >
                        </td>
                        <td><input  name="div_clinet_name" id="div_clinet_name" class="txt_input6" size="40" disabled="true" > </td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td>Broker</td>
                        <td>
                          <input name="txt_broker" type="text" class="txt_input6" id="txt_broker" disabled="true"  >
                       </td>
                        <td>&nbsp;</td>
                        <td>Advisor</td>
                        <td>
                          <input name="txt_advisor" type="text" class="txt_input6" id="txt_advisor"  disabled="true"><input name="txt_advisor_code" type="hidden" class="txt_input6" id="txt_advisor_code" >
                       </td>
                        <td><div id='div_txt_advisor'> </div></td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td>Broker E-mail</td>
                        <td>
                          <input name="txt_broker_email" type="text" class="txt_input6" id="txt_broker_email" disabled="true" >
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td><table cellspacing="0" cellpadding="0">
  <td width="112">Broker Fax</td>
                        </table></td>
                        <td>
                          <input name="txt_broker_fax" type="text" class="txt_input6" id="txt_broker_fax" disabled="true" >
                       </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
						
                      <tr>
                        <td>&nbsp;</td>
                        <td><table cellspacing="0" cellpadding="0">
                        <td width="110">Broker Telephone</td>
                        </table></td>
                        <td>
                          <input name="txt_broker_tel" type="text" class="txt_input6" id="txt_broker_tel" disabled="true" >
                       </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
						
					  <tr>	
						<td colspan="7" >	
					   <DIV id=Email1> </DIV>
						</td>	
					  </tr>	
						
                      <tr>
							
                        <td>&nbsp;</td>
                        <td>Security Identification</td>
                        <td>
                          <input name="txt_security_ident" type="text" class="txt_input6" id="txt_security_ident" onblur="security_ident_help1(0);" >
                        </td>
                        <td><INPUT TYPE="button" VALUE="..." NAME="BUTISCODE"  class="but_input" onClick="security_ident_help1(0);" ></TD></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td>Buy/Sell</td>
                        <td colspan="2">
                          <input name="rdb_buy_sell" id="rdb_buy" type="radio" value="BUY" class="txt_input6" checked onChange="change_buy_sell();" >
Buy 
                          <input name="rdb_buy_sell" id="rdb_sell" type="radio" value="SELL" class="txt_input6" onChange="change_buy_sell();" >
Sell                        
                        </td>
                        <td><!--Funds Available--></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td><strong>Order Information</strong></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td>Type of Transaction</td>
                        <td colspan="2"> 
                          <input name="rdb_trnasaction_type" type="radio" value="1" checked class="txt_input6">
                        Limit Orders
                        <input name="rdb_trnasaction_type" type="radio" value="2" class="txt_input6">
                        Market Orders                       </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td>Order Qualifieres</td>
                        <td>
                          <select name="cmb_order_qualifiers" class="txt_input6" id="cmb_order_qualifiers">
                            <option value="0">No Qualifiers</option>
                            <option value="1" selected>Fill or Kill</option>
                            <option value="2">Immediate or Cancel</option>
                          </select>
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td>Time in Force</td>
                        <td>
                          <select name="cmb_time_in_force" class="txt_input6" id="cmb_time_in_force" >
                            <option value="0" selected>Day Order</option>
                            <option value="1">Good till Day</option>
                            <option value="A">Good till Cancel</option>
                          </select>
                       </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td>Price Range</td>
                        <td colspan="2">
                          <input name="txt_price_min" type="text" class="txt_input7" id="txt_price_min" value="Min" size="15" onclick="clear_text(document.getElementById('txt_price_min'));"  onblur="format_number(document.getElementById('txt_price_min'),10);this.disabled=true;" maxlength="10" >
                          -

                          <input name="txt_price_max" type="text" class="txt_input7" id="txt_price_max" value="Max" size="15" onclick="clear_text(document.getElementById('txt_price_max'));" onblur="format_number(document.getElementById('txt_price_max'),10);this.disabled=true;" maxlength="10" >
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>&nbsp;</td>
                        <td><table cellspacing="0" cellpadding="0">
  <td width="134">No of Shares</td>
                        </table></td>
                        <td>
                          <input name="txt_no_of_shares" type="text" class="txt_input7" id="txt_no_of_shares" onblur="cal_brokerage();" onblur="format_number(document.getElementById('txt_no_of_shares'),10);" maxlength="10" >
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
					
					 <tr>
                        <td>&nbsp;</td>
                        <td>Value With Brokerage</td>
                        <td colspan="2">
                          <input name="txt_brokerage_min" type="text" class="txt_input7" id="txt_brokerage_min" value="Min" size="15" onclick="clear_text(document.getElementById('txt_brokerage_min'));" onblur="format_number(document.getElementById('txt_brokerage_min'),10);" maxlength="10" disabled="true"  >
                          -

                          <input name="txt_brokerage_max" type="text" class="txt_input7" id="txt_brokerage_max" value="Max" size="15" onclick="clear_text(document.getElementById('txt_brokerage_max'));" onblur="format_number(document.getElementById('txt_brokerage_max'),10);" maxlength="10" disabled="true"  >
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
					
					 <tr>
                        <td>&nbsp;</td>
                        <td><DIV id='div_lb_reason'>Reason</DIV></td>
                        <td colspan="2">
						   <DIV id='div_ob_reason'>
                           <select name="cmb_reason" class="txt_input6" id="cmb_reason">
                            <option value="R0006">NA</option>
                            <!--<option value="1" selected>Margin Call</option>
                            <option value="2">Murabaha Matured</option>
							<option value="3">Client Request</option>
							<option value="4">Management Decision</option>
							<option value="5">Other</option>-->		
                          </select>
						  </DIV>	
                          </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
					
                      <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
					<!-- ---------------------------------------Facility Information---------------------------------------------------- -->
					 <tr>
                        <td>&nbsp;</td>
                        <td><strong>Facility Information</strong></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
					
					   <tr>
                        <td>&nbsp;</td>
                        <td>Client Limit : Cash</td>
                        <td colspan="2"> 
                        <input name="txt_client_limit_cash" type="text" class="txt_input7" id="txt_client_limit_cash" onblur="format_number(document.getElementById('txt_client_limit_cash'),10)"; maxlength="10" disabled="true"  >
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
					
					   <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: Share</td>
                        <td colspan="2"> 
                        <input name="txt_client_limit_share" type="text" class="txt_input7" id="txt_client_limit_share" onblur="format_number(document.getElementById('txt_client_limit_share'),10)"; maxlength="10" disabled="true"  >
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
					
					 <tr>
                        <td>&nbsp;</td>
                        <td>Utilized Amount</td>
                        <td colspan="2"> 
                        <input name="txt_client_util_amount" type="text" class="txt_input7" id="txt_client_util_amount" onblur="format_number(document.getElementById('txt_client_util_amount'),10)"; maxlength="10" disabled="true"  >
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
					
					 <tr>
                        <td>&nbsp;</td>
                        <td>Un-Utilized Amount</td>
                        <td colspan="2"> 
                        <input name="txt_client_un_util_amount" type="text" class="txt_input7" id="txt_client_un_util_amount"  onblur="format_number(document.getElementById('txt_client_un_util_amount'),10)"; maxlength="10" disabled="true"  >
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
					
					 <tr>
                        <td>&nbsp;</td>
                        <td>Mark-Up%</td>
                        <td colspan="2" > 
                        <input name="txt_client_int_rate" type="text" class="txt_input7" id="txt_client_int_rate" onblur="format_number(document.getElementById('txt_client_int_rate'),10)"; maxlength="10" disabled="true"  >
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
					
					<tr>
                        <td>&nbsp;</td>
                        <td>Value of Transaction (Inclusive of Mark-up)</td>
                        <td colspan="2"> 
                        <input name="txt_tot_trn_amount_min" type="text" class="txt_input7" id="txt_tot_trn_amount_min" onblur="format_number(document.getElementById('txt_tot_trn_amount_min'),10)"; maxlength="10"  disabled="true"  >-
						<input name="txt_tot_trn_amount_max" type="text" class="txt_input7" id="txt_tot_trn_amount_max" onblur="format_number(document.getElementById('txt_tot_trn_amount_max'),10)"; maxlength="10"  disabled="true"  >	
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
					<!-- ---------------------------------------------------------------------------------------------------------------- -->
					
                      <tr>
                        <td>&nbsp;</td>
                        <td><table cellspacing="0" cellpadding="0">
  <td width="137">&nbsp;</td>
                        </table></td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                    </table>
	<tr><BR>
			  
			
			  
			
						  
				      <div id ="DIV_MSG_WINDOW" title ="Details">
							  <iframe id ="IFRAME_MSG_WINDOW" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Day End Routine">
							  </iframe>
					  </div>
    </BODY>
			<DIV>
				<script language="JavaScript1.2" src="validate_v1.js"></SCRIPT>
				<script language="JavaScript1.2" src="repo_rollover.js"></SCRIPT>
				<SCRIPT language1.2="JavaScript" src="Deal_confirm.js"></SCRIPT>
				<SCRIPT language="JavaScript" type='text/javascript' SRC="ajax_data_gateway.js"></SCRIPT>		
			</DIV>
		</HTML>
		
