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
		
		
		
		
		function select_screen(m_type)  {
			
			if( m_type == 'ADD'){
				document.getElementById('div_lable').innerHTML='Locations - New'; //added by Prabash on 24-11-2011
				document.Form1.reset();
				document.Form1.Hid_scr_name.value = 'Location_New';
				document.Form1.Text_help.disabled = true;
				document.Form1.Text_loc_desc.disabled = false;
				document.Form1.Text_address1.disabled = false;
				document.Form1.Text_address2.disabled = false;
				document.Form1.Text_address3.disabled = false;
				document.Form1.Text_address4.disabled = false;
				document.Form1.Text_address5.disabled = false;
				document.Form1.Text_postal_code.disabled = false;
				document.Form1.Text_tele_no1.disabled = false;
				document.Form1.Text_fax_no1.disabled = false;
				document.Form1.Text_email_add1.disabled = false;
				document.Form1.Text_help1.style.display = 'inline';
				document.Form1.Text_more1.style.display = 'inline';
				document.Form1.Text_next1.style.display = 'inline';
				document.Form1.Text_more2.style.display = 'inline';
				document.Form1.Text_next2.style.display = 'inline';
				document.Form1.Text_more3.style.display = 'inline';
				document.Form1.Text_next3.style.display = 'inline';
			}
			
			if( m_type == 'MOD'){
				document.getElementById('div_lable').innerHTML='Locations - Edit'; //added by Prabash on 24-11-2011
				document.Form1.reset();
				document.Form1.Hid_scr_name.value = 'Location_Mod';
				document.Form1.Text_help.disabled = false;
				document.Form1.Text_loc_desc.disabled = false;
				document.Form1.Text_address1.disabled = false;
				document.Form1.Text_address2.disabled = false;
				document.Form1.Text_address3.disabled = false;
				document.Form1.Text_address4.disabled = false;
				document.Form1.Text_address5.disabled = false;
				document.Form1.Text_postal_code.disabled = false;
				document.Form1.Text_tele_no1.disabled = false;
				document.Form1.Text_fax_no1.disabled = false;
				document.Form1.Text_email_add1.disabled = false;
				document.Form1.Text_help1.style.display = 'inline';
				document.Form1.Text_more1.style.display = 'inline';
				document.Form1.Text_next1.style.display = 'inline';
				document.Form1.Text_more2.style.display = 'inline';
				document.Form1.Text_next2.style.display = 'inline';
				document.Form1.Text_more3.style.display = 'inline';
				document.Form1.Text_next3.style.display = 'inline';
			}
			
			if( m_type == 'DEA'){
				document.getElementById('div_lable').innerHTML='Locations - Deactivate'; //added by Prabash on 24-11-2011
				document.Form1.reset();
				document.Form1.Hid_scr_name.value = 'Location_Deactive';
				document.Form1.Text_help.disabled = false;
				document.Form1.Text_loc_desc.disabled = true;
				document.Form1.Text_address1.disabled = true;
				document.Form1.Text_address2.disabled = true;
				document.Form1.Text_address3.disabled = true;
				document.Form1.Text_address4.disabled = true;
				document.Form1.Text_address5.disabled = true;
				document.Form1.Text_postal_code.disabled = true;
				document.Form1.Text_tele_no1.disabled = true;
				document.Form1.Text_fax_no1.disabled = true;
				document.Form1.Text_email_add1.disabled = true;
				document.Form1.Text_help1.style.display = 'none';
				document.Form1.Text_help1.style.display = 'none';
				document.Form1.Text_more1.style.display = 'none';
				document.Form1.Text_next1.style.display = 'none';
				document.Form1.Text_more2.style.display = 'none';
				document.Form1.Text_next2.style.display = 'none';
				document.Form1.Text_more3.style.display = 'none';
				document.Form1.Text_next3.style.display = 'none';
			}
			
			if(m_type == 'REA'){
				document.getElementById('div_lable').innerHTML='Locations - Reactivate'; //added by Prabash on 24-11-2011
				document.Form1.reset();
				document.Form1.Hid_scr_name.value = 'Location_Reactive';
				document.Form1.Text_help.disabled = false;
				document.Form1.Text_loc_desc.disabled = true;
				document.Form1.Text_address1.disabled = true;
				document.Form1.Text_address2.disabled = true;
				document.Form1.Text_address3.disabled = true;
				document.Form1.Text_address4.disabled = true;
				document.Form1.Text_address5.disabled = true;
				document.Form1.Text_postal_code.disabled = true;
				document.Form1.Text_tele_no1.disabled = true;
				document.Form1.Text_fax_no1.disabled = true;
				document.Form1.Text_email_add1.disabled = true;
				document.Form1.Text_help1.style.display = 'none';
				document.Form1.Text_more1.style.display = 'none';
				document.Form1.Text_next1.style.display = 'none';
				document.Form1.Text_more2.style.display = 'none';
				document.Form1.Text_next2.style.display = 'none';
				document.Form1.Text_more3.style.display = 'none';
				document.Form1.Text_next3.style.display = 'none';
				
			}
			
		} 
		
		
		
		
		j=1,k=1,l=1;   
		
		var  fax_status=true,tele_status=true,email_status=true;				
		var  fax_status1=false,email_status1=false;
		
		
		function tele_creation() {
			if(document.Form1.Text_tele_no1.value!="") 
			{
				j=j+1;
				m_writedata ='<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0"> '+
					'<TD WIDTH="25%" >Telephone '+j+' </TD><TD WIDTH="75%"><INPUT CLASS="txt_input6" TYPE="Text" NAME="Text_tele_no'+j+'" SIZE=20 MAXLENGTH="10" ></TD>'+
					'</TABLE>'; 
				document.getElementById('othertele1').innerHTML=document.getElementById('othertele1').innerHTML+m_writedata;
			}
			else {
				alert('Please enter the telephone number');
				document.Form1.Text_tele_no1.focus();
			}		
		}	
		
		function fax_creation(){
			if(document.Form1.Text_fax_no1.value!="") {
				k=k+1;
				m_row="";
				m_writedata ='<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0"> '+
					'<TD WIDTH="25%" >Fax '+k+'</TD><TD WIDTH="75%"><INPUT CLASS="txt_input6" TYPE="Text" NAME="Text_fax_no'+k+'" SIZE=20 MAXLENGTH="10"></TD>'+
					'</TABLE>'; 
				document.getElementById('otherfax1').innerHTML=document.getElementById('otherfax1').innerHTML+m_writedata;
			}
			else {
				alert('Please enter the fax number');
				document.Form1.Text_fax_no1.focus();
			}
		}	
		
		
		function location_help_close(){
			if(document.Form1.Hid_scr_name.value == 'Location_Mod'){
				select_screen('MOD');
			}
			else if(document.Form1.Hid_scr_name.value == 'Location_Deactive'){
				select_screen('DEA');
			}
			else if(document.Form1.Hid_scr_name.value == 'Location_Reactive'){
				select_screen('REA');
			}			
		}
		
		function location_help(m_strat){
			var aForm;    //  aForm =oForm.elements;
			aForm =  document.getElementById('Form1');
			/*  var myObject = new Object();
			myObject.firstName = aForm.oFirstName.value;
			myObject.lastName = aForm.oLastName.value;
			*/
			
			var myObject=new Array(); //return values set to this object
			myObject[0]=aForm.Text_loc_code;
			myObject[1]=aForm.Text_loc_desc;;
			myObject[2]=null;
			myObject[3]=null;
			myObject[4]=null;
			
			var myObject_value=new Array(); //passing values set to this object
			myObject_value[0]=aForm.Text_loc_code.value;
			myObject_value[1]=aForm.Text_loc_code.value;//aForm.oLastName2.value;
			myObject_value[2]=null;
			myObject_value[3]=null;
			myObject_value[4]=null;
			
			
			var myObject_type=new Array(); //passing values data type
			myObject_type[0]="StringL";
			myObject_type[1]="StringL";
			myObject_type[2]=null;
			myObject_type[3]=null;
			myObject_type[4]=null;
			
			var qid='8';
			
			if(document.Form1.Hid_scr_name.value == 'Location_Reactive'){
				qid='9';	
			}
			
			title_name='Locations';
			var url = 'popup.jsp';
			var close_fun='location_help_close';			
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
					width: 500,//900,
					title: 'SasiNet Frame Work',
					scrollable: true,
					onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); 
						if(returnedValue != null){
							chk_location(document.Form1.Text_loc_code);
						}
						if(returnedValue == null){
							location_help_close();
						} 
					} //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
				});
		}
		
		function email_creation(){
			if(document.Form1.Text_email_add1.value)   {
				l=l+1;	   
				m_row="";
				m_writedata ='<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0"> '+
					'<TD WIDTH="25%" >Email Address '+l+' </TD><TD WIDTH="75%"><INPUT CLASS="txt_input6" TYPE="Text" NAME="Text_email_add'+l+'" SIZE="20" MAXLENGTH="50" ></TD>'+
					'</TABLE>'; 
				document.getElementById('otheremail1').innerHTML= document.getElementById('otheremail1').innerHTML+m_writedata;
			}
			else {
				alert('Please enter the E_mail address');
				document.Form1.Text_email_add1.focus();
			}
		}
		
		
		var ajax_status = '';
		
		function chk_location(loc_obj) 	{
			if(loc_obj != ''){
				
				if(document.Form1.Hid_scr_name.value == 'Location_New'){
					
					m_code=loc_obj.value;
					ajax_status = 'location_new_check';
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfslgetdata1?chksql=location&loc_code="+m_code;
					load_interface(m_url, 'XML',false);
					assign_data(data_vec);
				}else if(document.Form1.Hid_scr_name.value == 'Location_Mod' || document.Form1.Hid_scr_name.value == 'Location_Deactive'){
					m_code=loc_obj.value;
					ajax_status = 'location_mod_add';
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfslgetdata1?chksql=mod_location&loc_code="+m_code+"";
					load_interface(m_url, 'XML',false);
					assign_data(data_vec);
				}
				else if(document.Form1.Hid_scr_name.value == 'Location_Reactive'){
					m_code=loc_obj.value;
					ajax_status = 'location_react_add';
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfslgetdata1?chksql=reactive_location&loc_code="+m_code+"";
					load_interface(m_url, 'XML',false);
					assign_data(data_vec);
					
				}
			}
		}
		
		function check_telespaces(object) {
			if(object.value!="")  {	
				m_format=object.value;
				for (var i = 0,j=0; i < m_format.length; i++) {
					var oneChar = m_format.charAt(i)
					if (oneChar==" "){
						j=j+1;
						if(j==1) {
							alert('You cannot have spaces in between'); 
							object.focus();
						}
					}
				}
			}
		}	
		
		function assign_data(data){
			if((ajax_status == 'location_mod_add' || ajax_status == 'location_react_add') && data.length > 0){
				
				document.getElementById('othertele1').innerHTML  = "";
				document.getElementById('otherfax1').innerHTML   = "";
				document.getElementById('otheremail1').innerHTML = "";
				
				//document.Form1.Text_loc_desc.value = data[1];
				if(data[2]!="@") {
					document.Form1.Text_address1.value=data[2];
				}
				else {
					document.Form1.Text_address1.value="";
				}		
				
				if(data[3]!="@") {
					document.Form1.Text_address2.value=data[3];
				}
				else {
					document.Form1.Text_address2.value="";
				}
				
				if(data[4]!="@") {
					document.Form1.Text_address3.value=data[4];
				}
				else{
					document.Form1.Text_address3.value="";
				}	
				
				if(data[5]!="@") {
					document.Form1.Text_address4.value=data[5];
				}
				else {
					document.Form1.Text_address4.value="";
				}			
				if(data[6]!="@")  {
					document.Form1.Text_address5.value=data[6];
				}
				else {
					document.Form1.Text_postal_code.value="";
				}		
				if(data[7]!="@") {
					document.Form1.Text_postal_code.value=data[7];
					document.Form1.Text_postal_desc.value=data[8];
				}
				
				
				
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfslgetdata1?chksql=mod_loc_tel&loc_code="+m_code+"";
				ajax_status = 'location_mod_tel';
				load_interface(m_url, 'XML',false);
				assign_data(data_vec)
			}
			
			else if(ajax_status == 'location_mod_tel') {
				if(data.length > 0){
					document.Form1.Text_tele_no1.value=data[0];
					var p=2;
					var m_size2 = data.length;
					for(var t=1; t<m_size2; t++) {
						m_writedata ='<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0"> '+
							'<TD WIDTH="25%" >Telephone '+p+' </TD><TD WIDTH="75%"><INPUT CLASS="txt_input6" TYPE="Text" NAME="Text_tele_no'+p+'"  VALUE ='+data[t]+' SIZE=20 MAXLENGTH="10"  ONBLUR="check_telespaces(document.Form1.Text_tele_no'+p+')"></TD>'+
						'</TABLE>'; 
						document.getElementById('othertele1').innerHTML = document.getElementById('othertele1').innerHTML+m_writedata;
						p=p+1;
					}	
				}
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfslgetdata1?chksql=mod_loc_fax&loc_code="+m_code+"";
				ajax_status = 'location_mod_fax';
				load_interface(m_url, 'XML',false);
				assign_data(data_vec)
			}
			
			
			else if(ajax_status == 'location_mod_fax'){
				if(data.length > 0){
					document.Form1.Text_fax_no1.value=data[0];
					var p=2;
					var m_size3 = data.length;
					for(var t=1; t< m_size3; t++) {
						m_writedata ='<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0"> '+
							'<TD WIDTH="25%">Fax '+p+' </TD><TD WIDTH="75%"><INPUT CLASS="txt_input6" TYPE="Text" NAME="Text_fax_no'+p+'"  VALUE ='+data[t]+' SIZE=20 MAXLENGTH="10" ONBLUR="check_telespaces(document.Form1.Text_fax_no'+p+')"></TD>'+
						'</TABLE>'; 
						document.getElementById('otherfax1').innerHTML=document.getElementById('otherfax1').innerHTML+m_writedata;
						p=p+1;
					}	
				}
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfslgetdata1?chksql=mod_loc_email&loc_code="+m_code+"";
				ajax_status = 'location_mod_email';
				load_interface(m_url, 'XML',false);
				assign_data(data_vec)
			}
			
			else if(ajax_status == 'location_mod_email' && data.length > 0){
				
				document.Form1.Text_email_add1.value = data[0];
				var p=2;
				var m_size4 = data.length;
				for(var t=1; t<m_size4; t++) {
					m_writedata ='<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0"> '+
						'<TD WIDTH="25%" >Email Address '+p+' </TD><TD WIDTH="75%"><INPUT CLASS="txt_input6" TYPE="Text" NAME="Text_email_add'+p+'"  VALUE ='+data[t]+' SIZE=20 MAXLENGTH="10"  ONBLUR="check_telespaces(document.Form1.Text_email_add'+p+')"></TD>'+
					'</TABLE>'; 
					document.getElementById('otheremail1').innerHTML=document.getElementById('otheremail1').innerHTML+m_writedata;
					p=p+1;
				}	
				
			}
			
			else if(ajax_status == 'location_new_check'){
				if(data.length > 0)  {
					alert('This record already exists');
					document.Form1.Text_loc_code.focus();
				}
				else   {
					document.Form1.Text_loc_desc.focus();
				}	
				
			}
			
		}
		
		function chk_null(desc_obj) {
			if(desc_obj.value=="") {
				alert('Please enter the location description');
				document.Form1.Text_loc_desc.focus();
			}
			else
			{
				document.Form1.Text_address1.focus();
			}
		}	
		
		
		
		function postal_help2(m_strat){
			var aForm;    //  aForm =oForm.elements;
			aForm =  document.getElementById('Form1');
			/*  var myObject = new Object();
			myObject.firstName = aForm.oFirstName.value;
			myObject.lastName = aForm.oLastName.value;
			*/
			
			var myObject=new Array(); //return values set to this object
			myObject[0]=aForm.Text_postal_code;
			myObject[1]=aForm.Text_postal_desc;
			myObject[2]=null;
			myObject[3]=null;
			myObject[4]=null;
			
			var myObject_value=new Array(); //passing values set to this object
			myObject_value[0]=aForm.Text_postal_code.value;
			myObject_value[1]=aForm.Text_postal_code.value;//aForm.oLastName2.value;
			myObject_value[2]=null;
			myObject_value[3]=null;
			myObject_value[4]=null;
			
			
			var myObject_type=new Array(); //passing values data type
			myObject_type[0]="StringL";
			myObject_type[1]="StringL";
			myObject_type[2]=null;
			myObject_type[3]=null;
			myObject_type[4]=null;
			
			var qid='10';
			
			
			title_name='Postal Codes';
			var url = 'popup.jsp';
			var close_fun='postal_help_close';			
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
					width: 500,//900,
					title: 'SasiNet Frame Work',
					scrollable: true,
					onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); 
					if(returnedValue == null){postal_help_close();} 
					} 
				});
		}
		
		
		function view_all_locations(m_strat){
			var aForm;    //  aForm =oForm.elements;
			aForm =  document.getElementById('Form1');
			/*  var myObject = new Object();
			myObject.firstName = aForm.oFirstName.value;
			myObject.lastName = aForm.oLastName.value;
			*/
			
			var myObject=new Array(); //return values set to this object
			myObject[0]=null;
			myObject[1]=null;
			myObject[2]=null;
			myObject[3]=null;
			myObject[4]=null;
			
			var myObject_value=new Array(); //passing values set to this object
			myObject_value[0]=null;
			myObject_value[1]=null;//aForm.oLastName2.value;
			myObject_value[2]=null;
			myObject_value[3]=null;
			myObject_value[4]=null;
			
			
			var myObject_type=new Array(); //passing values data type
			myObject_type[0]=null;
			myObject_type[1]=null;
			myObject_type[2]=null;
			myObject_type[3]=null;
			myObject_type[4]=null;
			
			var qid='13';
			
			
			title_name='All Locations';
			var url = 'popup.jsp';
			var close_fun='view_all_close';			
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
					onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue); 
					if(returnedValue == null){view_all_close();} 
					} 
				});
		}
		
		function view_all_close(){
			
		}
		
		
		function postal_help_close(){
			document.Form1.Text_postal_code.value = '';
			document.Form1.Text_postal_desc.value = '';
		}
		
		
		
		function myDialogObj() {
			var htmlstr; 
			var returnval;
		}
		
		function chk_postal(p_obj)   {
			m_code=p_obj.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfslgetdata1?chksql=postal_code&postal_code="+m_code;
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
			if(m_size==0)   {
				if(confirm("Invalid postal code if you want to see alist of codes click on O.K ")) {
					postal_help();
				}
				else {
					document.Form1.Text_postal_code.focus();
				}	
			}
			else {
				document.Form1.Text_postal_desc.value=top.frames[0].document.applets[0].outvec_value.elementAt(1);
				document.Form1.Text_tele_no1.focus();
			}	 
		}	
		
		function beforesubmit() {
			document.Form1.Hid_tel_count.value=j;
			document.Form1.Hid_fax_count.value=k;
			document.Form1.Hid_email_count.value=l;
			
			if(document.Form1.Text_loc_code.value=="") {
				alert('Please enter the Location Code');
				document.Form1.Text_loc_code.focus();	
				return;
			}
			if(document.Form1.Text_loc_desc=="") {
				alert('Please enter the Location Description'); 
				document.Form1.Text_loc_desc.focus();
				return;
			}		
			
			if(document.Form1.Text_tele_no1.value==""&& document.Form1.Text_fax_no1.value=="" && document.Form1.Text_email_add1.value=="") {
				document.Form1.Hid_main.value="primary_details";
			}		
			
			if(document.Form1.Text_tele_no1.value!="")  {
				document.Form1.Hid_tel_no.value="no_of_tel";
			}
			if(document.Form1.Text_fax_no1.value!="")  {
				document.Form1.Hid_fax_no.value="no_of_fax";
			}
			if(document.Form1.Text_email_add1.value!="")  {
				document.Form1.Hid_email_no.value="no_of_email";
			}
			document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfslserveref1";
			document.Form1.submit();		
		}
		
		function clearAll(){
			top.frames[1].location.href = jsp_client_url + "/frames_location.jsp";
		}
		
	</SCRIPT>
	
	<BODY ONLOAD="select_screen('ADD')"  class='body & txt-body' >
		<FORM NAME="Form1" ID="Form1" METHOD="POST" >
			
			
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	 VALUE="Location_New">
			<INPUT TYPE="Hidden" NAME="Hid_tel_no" VALUE="null">
			<INPUT TYPE="Hidden" NAME="Hid_tel_count">
			<INPUT TYPE="Hidden" NAME="Hid_main" >
			<INPUT TYPE="Hidden" NAME="Hid_fax_no" >
			<INPUT TYPE="Hidden" NAME="Hid_fax_count" >
			<INPUT TYPE="Hidden" NAME="Hid_email_no" >
			<INPUT TYPE="Hidden" NAME="Hid_email_count">
			
			<DIV>
				<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
					<tr>
						<td height='7'></td>
					</tr>
					
					<tr height='30' >
						<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
						<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Administration - System Maintenance</B></td>
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
							
							<TD WIDTH="6%">	
								<INPUT TYPE="Button" NAME="NEW" VALUE="Add"   onClick="select_screen('ADD');"  class="mainbut"  >
							</TD>
							<TD WIDTH="6%">	
								<INPUT TYPE="Button" NAME="MOD" VALUE="Edit"   onClick="select_screen('MOD');" class="mainbut"  >
							</TD>
							<TD WIDTH="6%">	
								<INPUT TYPE="Button" style="width:80px" NAME="DEA" VALUE="Deactivate"   onClick="select_screen('DEA');"  class="mainbut"  >
							</TD>
							<TD WIDTH="6%">	
								<INPUT TYPE="Button" NAME="REA" style="width:80px"  VALUE="Reactivate"   onClick="select_screen('REA');"  class="mainbut"  >
							</TD>
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
							<TD WIDTH="6%">
								<INPUT TYPE="Button" NAME="view_all_but" VALUE="View All"    onClick="view_all_locations(0)" class="mainbut">
								
							</TD>
							
							<!--<TD  WIDTH="50%" class="hh1" align="right">-->
							<!--<B>Locations</B>-->
							<TD> <B><div id='div_lable' align='right' > </div> </B> </TD>				
								
							</TD>					
						</TR>
					</TABLE>
					
					
					<!----------->
					
					<TABLE WIDTH="100%"  >
						<tr height='25px;'></tr>
					</TABLE>
					<HR>
					<TABLE WIDTH="100%"  >
						<tr height='25px;'></tr>
					</TABLE>
					
					<BR>	
					<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
						<TR>
							<TD WIDTH="1%"></TD>
							<TD WIDTH="*%">
								<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0">
									<TR>
										<TD WIDTH="25%" >Location Code </TD>
										<TD WIDTH="75%">
											<INPUT TYPE="Text" NAME="Text_loc_code" class="txt_input6"	ALIGN="LEFT" SIZE="15" MAXLENGTH="6" ONBLUR="chk_location(document.Form1.Text_loc_code)">
											<INPUT TYPE="BUTTON" class='but_input' NAME="Text_help" onclick='location_help(0)' VALUE="Help" Disabled></TD>	
									</TR>	
								</TABLE>
								<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0">
									<TR>
										<TD WIDTH="25%" >Location</TD>
										<TD WIDTH="75%">
											<INPUT	TYPE="Text" NAME="Text_loc_desc" style='width:200px'	class="txt_input6" ALIGN="LEFT" SIZE="30" MAXLENGTH="40" ONCHANGE="chk_null(document.Form1.Text_loc_desc)" ></TD>
									</TR>	
									<TR></TR>
									<TR></TR>
								</TABLE>
								
								<TABLE WIDTH="100%" BORDER="0" style='padding-top:10px;padding-bottom:10px; padding-left:0px'  CELLPADDING="0" CELLSPACING="0" >
									<TR>
										<TD WIDTH="99%"><HR/><B><U>Address</B><HR/></TD>
										</TR>
									</TABLE> 
									
									<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0">
										<TR></TR>
										<TR></TR>
										<TR>	
											<B><TD  WIDTH="25%" >Identification</TD></B>
											<TD  WIDTH="75%"><INPUT	TYPE="Text" class="txt_input6"  style='width:200px'  NAME="Text_address1"	ALIGN="LEFT" SIZE="30" MAXLENGTH="30"></TD>
										</TR>
										<TR>		
											<TD  WIDTH="25%" >Location</TD>
											<TD  WIDTH="75%"><INPUT	TYPE="Text"  class="txt_input6" style='width:200px'  NAME="Text_address2"	ALIGN="LEFT" SIZE="30" MAXLENGTH="30"></TD>
										</TR>
										<TR>
											<TD  WIDTH="25%" >Street Address</TD>
											<TD  WIDTH="75%"><INPUT	TYPE="Text" class="txt_input6" style='width:200px' NAME="Text_address3"	ALIGN="LEFT" SIZE="30" MAXLENGTH="30"></TD>
										</TR>
										<TR>
											<TD  WIDTH="25%" >City</TD>
											<TD  WIDTH="75%"><INPUT	TYPE="Text" class="txt_input6" style='width:200px' NAME="Text_address4"	ALIGN="LEFT" SIZE="30" MAXLENGTH="30"></TD>
										</TR>
										<TR>
											<TD  WIDTH="25%" >Country</TD>
											<TD  WIDTH="75%"><INPUT	TYPE="Text" class="txt_input6"  style='width:200px' NAME="Text_address5"	ALIGN="LEFT" SIZE="30" MAXLENGTH="30"></TD>
										</TR>
										<TR>
											<TD  WIDTH="25%" >Postal Code</TD>
											<TD  WIDTH="75%">
												<INPUT	TYPE="Text" NAME="Text_postal_code" class="txt_input6"	ALIGN="LEFT" SIZE="15" MAXLENGTH="5" ONCHANGE="chk_postal(document.Form1.Text_postal_code)">
												<INPUT TYPE="BUTTON" class='but_input' NAME="Text_help1"  VALUE="Help" onClick="postal_help2(0)">
											</TD>	
										</TR>
										<TR>
											<TD  WIDTH="25%" >Postal Description</TD>
											<TD  WIDTH="75%"><INPUT	TYPE="Text" class="txt_input6" NAME="Text_postal_desc" style='width:200px'	ALIGN="LEFT" SIZE="30" DISABLED></TD>
											
										</TR>
										<TR></TR>
										<TR></TR>
										<TR></TR>
										
									</TABLE> 
									
									<TABLE WIDTH="100%" BORDER="0" style='padding-top:10px;padding-bottom:10px; padding-left:0px' CELLPADDING="0" CELLSPACING="0" >
										<TR>
											<TD WIDTH="99%"><HR/><B><U>Contact Details</U></B><HR/></TD>
											</TR>
										</TABLE> 
										
										<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0"> 
											<TR></TR>
											<TR></TR>
											<TR> 
												<TD WIDTH="25%" >Telephone 1</TD>
												<TD WIDTH="75%">
													<INPUT TYPE="Text"  class="txt_input6"  NAME="Text_tele_no1"	ALIGN="LEFT" SIZE="20" MAXLENGTH="10"  ONBLUR="document.Form1.Text_fax_no1.focus()">
													<INPUT TYPE="BUTTON" class='but_input' NAME="Text_more1"  VALUE="More" onClick="tele_creation()">
													<INPUT TYPE="BUTTON" class='but_input' NAME="Text_next1"  VALUE="Next" onClick="document.Form1.Text_fax_no1.focus()"></TD>	
											</TR>
											
										</TABLE>
										<DIV id=othertele1></DIV>
										<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0"> 
											<TR>	
												<TD WIDTH="25%" >Fax 1</TD>
												<TD WIDTH="75%"><INPUT class="txt_input6"	TYPE="Text" NAME="Text_fax_no1"	ALIGN="LEFT" SIZE="20" MAXLENGTH="10" ONBLUR="document.Form1.Text_email_add1.focus()">
													<INPUT TYPE="BUTTON" class='but_input' NAME="Text_more2" VALUE="More" onClick="fax_creation()">
													<INPUT TYPE="BUTTON" class='but_input' NAME="Text_next2" VALUE="Next" onClick="document.Form1.Text_email_add1.focus()"></TD>	
											</TR>
										</TABLE>
										<DIV id=otherfax1></DIV>
										<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0"> 
											<TR>	
												<TD WIDTH="25%" >Email Address 1 </TD></B>
												<TD WIDTH="75%"><INPUT class="txt_input6"	TYPE="Text" NAME="Text_email_add1"	ALIGN="LEFT" SIZE="20" MAXLENGTH="50">
													<INPUT TYPE="BUTTON" class='but_input'  NAME="Text_more3"  VALUE="More" onClick="email_creation()">
													<INPUT TYPE="BUTTON" class='but_input' NAME="Text_next3"  VALUE="Next" onClick="document.Form1.save_but.focus()"></TD>	
											</TR>
										</TABLE>
										<DIV id=otheremail1></DIV>
									</TD>
								</tr>
							</table>
						</TD>
					</tr>
					
				</table>
			</FORM>
			<script language="JavaScript1.2" SRC="validate.js"></SCRIPT>
			<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
			
		</body>
	</html>
	
