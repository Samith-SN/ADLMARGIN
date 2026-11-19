<HTML> 
	<HEAD>
		<TITLE>DealNet 
		</TITLE>
	<%@page import="net.sasianet.lbmargin.*" %>
		<%	
		
	LBMARGIN2_MGT_conn_methods m_sn_methods = new LBMARGIN2_MGT_conn_methods(session);
		String m_jsp_client_url=m_sn_methods.jsp_client_url;
		
		
        
		//***************  ADDED BY KANISHKA ON 18/12/2012  *********************//
		
		Object done = (String)session.getValue("logon.isDone");  // marker object
		    if (done == null) {
			response.sendRedirect("login.jsp");
            return;
         }
		
		//*************** ADDED BY KANISHKA ON 18/12/2012 [END]  *********************//
			
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/redmond/jquery-ui.css' TYPE=\"text/css\">");
			
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
        out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");

	    %>
		

	<SCRIPT language="JavaScript1.2" >
		
		//****************************************OUTFLOW HELP*******************************
		function account_help() {
			m_portfcode="hh";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=account_lookup";
			document.applets[0].getdata(m_url);
			m_size=document.applets[0].outvec_value.size();
			//alert(m_size);
			vec_pos=0;
			m_row="";
			lineno=1;
			while (vec_pos<m_size) {
				m_acc_no=document.applets[0].outvec_value.elementAt(vec_pos);
				m_bank_name=document.applets[0].outvec_value.elementAt(vec_pos+1);
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
			m_portfcode=ObjVal; 
			m_size="";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=Pf_Blur_new&PF_value="+ObjVal+" ";
			document.applets[0].getdata(m_url);
			m_size=document.applets[0].outvec_value.size();
			if(m_size<=0){
				if (confirm("Invalid Portpolio Code. Press OK For Help")){
					portP_help(m_portfcode);
				}
				else{
					document.Form1.TXT_portfolio.value="";
				}
			}		
		}
		
		
		function Blur_inst(ObjVal)
		{
			m_inst=ObjVal; 
			m_size="";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=inst_Blur_new&PF_value="+ObjVal+" ";
			document.applets[0].getdata(m_url);
			m_size=document.applets[0].outvec_value.size();
			if(m_size<=0){
				if (confirm("Invalid Instrument Type. Press OK For Help")){
					inst_help(m_inst);
				}
				else{
					document.Form1.TXT_INST.value="";
				}
			}		
		}
		
		
		function sectype(objz){		
			m_sectype=objz.value;
			m_sizel="";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?buyer_code="+m_sectype.toUpperCase()+"&inst_num="+document.Form1.TXT_INST.value.toUpperCase()+"&chksql=chksec";
			top.frames[0].document.applets[0].getdata(m_url);
			m_sizel=top.frames[0].document.applets[0].outvec_value.size();
			if (m_sizel<=0) {
				sec_help(objz);
				objz.focus();
			}
			else{
				document.Form1.TXT_sec.value=top.frames[0].document.applets[0].outvec_value.elementAt(0);
			}
		}
		
		function sec_help(obj1) {
			m_secinst=obj1.value;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaloutrights?inst_num="+document.Form1.TXT_INST.value.toUpperCase()+"&chksql=sec_lookup";
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
			vec_pos=0;
			lineno=1;
			m_row="";
			if (m_size>0){
				while (vec_pos<m_size) {
					m_issu_code=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
					m_issu_name=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
					m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+'><B>'+m_issu_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_issu_name+'</B></TD></TR>';
					vec_pos=vec_pos+2;
					lineno=lineno+1;
				}
				m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color: white; font: 9pt arial;}">'+
					'<TR BGCOLOR="darkblue"><TD WIDTH="60%"><B>Security Identification</B></TD>' +
					'<TD WIDTH="40%"><B>Maturity_Date</B></TD></TR>'+
					m_row+
					'</TABLE>'; 
				myDialogObj.htmlstr = m_writedata;
				myDialogObj.returnval = "";
				
				popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
				abc=top.frames[0].document.applets[0].outvec_value.indexOf(myDialogObj.returnval);
				document.Form1.TXT_sec.value=top.frames[0].document.applets[0].outvec_value.elementAt(abc);
				
			}
			else{
				alert('Currently no data available for the selected Instrument type !');
			}
			
		}	
		
		
		
	/*	function inst_help(ObjVal){
			m_portfcode=ObjVal; 
			m_size="";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=inst_help_new&PF_value="+ObjVal+" ";
			document.applets[0].getdata(m_url);
			m_size=document.applets[0].outvec_value.size();				
			
			vec_pos=0;
			lineno=1;
			m_row="";
			while (vec_pos<m_size) {
				m_pfCode =document.applets[0].outvec_value.elementAt(vec_pos);
				m_type   =document.applets[0].outvec_value.elementAt(vec_pos+1);
				m_pf_Name=document.applets[0].outvec_value.elementAt(vec_pos+2);
				//m_trn_amount=document.applets[0].outvec_value.elementAt(vec_pos+3);
				m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+' ALIGN="LEFT" ><B>'+m_pfCode+'</B></TD><TD ID=C2R'+	lineno+' ALIGN="CENTER" ><B>'+m_type+'</B></TD><TD ID=C3R'+	lineno+' ALIGN="LEFT" ><B>'+m_pf_Name+'</B></TD></TR>';																							
				vec_pos=vec_pos+3;
				lineno=lineno+1;
			}
			m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color: white; font: 9pt arial;}">'+            
				'<TR BGCOLOR="darkblue"><TD WIDTH="25%"><B>Instrument Code</B></TD>' +
				'<TD WIDTH="10%" ALIGN="CENTER"><B>Type</B></TD>' +
				'<TD WIDTH="10%"><B>Instrument Name</B></TD>' +
				m_row+
				'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval = "";
			helpvalue="";
			
			popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:30em; dialogHeight:15em; center:yes; resizable:yes; status:no");
			helpvalue= document.applets[0].outvec_value.indexOf(myDialogObj.returnval);
			
			if (helpvalue != 1) {
				document.Form1.TXT_INST.value=document.applets[0].outvec_value.elementAt(helpvalue+0);
			}
			
			else { 
				if (helpvalue==1){
				}
			}
			
		}
		
		
	*/
		
		//---------Added by Prabash on 08-05-2012---------**
		
		function	sec_help(m_strat){
			
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	//alert('dddddd');
		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.TXT_sec;
 		myObject[2]=aForm.Text_sec_name;
	//	myObject[2]=aForm.Text_sec_name;
 		
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.TXT_sec.value;
 		myObject_value[1]=null;

 		var myObject_type=new Array(); //passing values data type
		myObject_type[0]="StringL";	
 		myObject_type[1]=null;
 	
 		var qid='27';

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
		
		
		
		function	inst_help(m_strat){
			
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	//alert('dddddd');
		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.TXT_INST;
 	//	myObject[1]=aForm.Text_inst;
	//	myObject[2]=aForm.Text_sec_name;
 		
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.TXT_INST.value;
 	//	myObject_value[1]=aForm.TXT_portfolio.value;

 		var myObject_type=new Array(); //passing values data type
		myObject_type[0]="StringL";	
 		//myObject_type[1]="StringL";	
 	
 		var qid='125';

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
		
		
	
		
		function	portP_help(m_strat){
			
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	//alert('dddddd');
		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.TXT_portfolio;
 		myObject[1]=aForm.TXT_desc;
	//	myObject[2]=aForm.Text_sec_name;
 		
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.TXT_portfolio.value;
 		myObject_value[1]=aForm.TXT_portfolio.value;
	
 		var myObject_type=new Array(); //passing values data type
		myObject_type[0]="StringL";	
 		myObject_type[1]="StringL";	
 	
 		var qid='124';

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
	

	
	function	payee_bank_help(m_strat){
			
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	//alert('dddddd');out.println(rs.getString(1));
		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.TXT_payee;
 	
 		
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.TXT_payee.value;
 	//	myObject_value[1]=aForm.TXT_sec.value;

 		var myObject_type=new Array(); //passing values data type
		myObject_type[0]="StringL";	
 	//	myObject_type[1]="StringL";	
 	
 		var qid='127';

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
		
		
		
		
		
		
		
	function	bank_help(m_strat){
			
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	//alert('dddddd');
		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.TXT_bank_code;
 		myObject[1]=aForm.TXT_ACC_number;
	//	myObject[2]=aForm.Text_sec_name;
 		
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.TXT_bank_code.value;
 	//	myObject_value[1]=aForm.TXT_sec.value;

 		var myObject_type=new Array(); //passing values data type
		myObject_type[0]="StringL";	
 	//	myObject_type[1]="StringL";	
 	
 		var qid='128';

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
		
		
		
		//------------------------------------------**
		
		
		
		
	/*	function portP_help(ObjVal){
			m_portfcode=ObjVal; 
			m_size="";
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=Pf_help_new&PF_value="+ObjVal+" ";
			document.applets[0].getdata(m_url);
			m_size=document.applets[0].outvec_value.size();				
			
			vec_pos=0;
			lineno=1;
			m_row="";
			while (vec_pos<m_size) {
				m_pfCode =document.applets[0].outvec_value.elementAt(vec_pos);
				m_type   =document.applets[0].outvec_value.elementAt(vec_pos+1);
				m_pf_Name=document.applets[0].outvec_value.elementAt(vec_pos+2);
				//m_trn_amount=document.applets[0].outvec_value.elementAt(vec_pos+3);
				m_cds_no=document.applets[0].outvec_value.elementAt(vec_pos+3);
				m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+' ALIGN="LEFT" ><B>'+m_pfCode+'</B></TD><TD ID=C2R'+	lineno+' ALIGN="CENTER" ><B>'+m_type+'</B></TD><TD ID=C3R'+	lineno+' ALIGN="LEFT" ><B>'+m_pf_Name+'</B></TD><TD ID=C4R'+	lineno+' ALIGN="LEFT" ><B>'+m_cds_no+'</B></TD></TR>';																							
				vec_pos=vec_pos+4;
				lineno=lineno+1;
			}
			m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color: white; font: 9pt arial;}">'+            
				'<TR BGCOLOR="darkblue"><TD WIDTH="15%"><B>Client Code</B></TD>' +
				'<TD WIDTH="10%" ALIGN="CENTER"><B>Type</B></TD>' +
				'<TD WIDTH="25%"><B>Client  Name</B></TD>' +
				'<TD WIDTH="10%"><B>CDS No.</B></TD>' +
				m_row+
				'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval = "";
			helpvalue="";
			
			popupwin = window.showModalDialog(html_client_url+"/help_box2.html",myDialogObj,"dialogWidth:30em; dialogHeight:15em; center:yes; resizable:yes; status:no");
			helpvalue= document.applets[0].outvec_value.indexOf(myDialogObj.returnval);
			
			if (helpvalue != 1) {
				document.Form1.TXT_portfolio.value=document.applets[0].outvec_value.elementAt(helpvalue+0);
			}
			
			else { 
				if (helpvalue==1){
				}
			}
			
		}
		
		*/
		/* function bank_help() {
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=set_opt_help_button&bankcode="+document.Form1.TXT_bank_code.value ;
			document.applets[0].getdata(m_url);
			m_size=document.applets[0].outvec_value.size();
			vec_pos=0;
			m_row="";
			lineno=1;
			while (vec_pos<m_size) {
				m_bank_code=document.applets[0].outvec_value.elementAt(vec_pos);
				m_bank_desc=document.applets[0].outvec_value.elementAt(vec_pos+1); 
				m_row=m_row+'<TR STYLE="{color:black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+',C2R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_bank_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_bank_desc+'</B></TD></TR>';
				vec_pos=vec_pos+2;
				lineno=lineno+1;
			}
			
			m_writedata ='<TABLE BGCOLOR="siler" WIDTH="100%" STYLE="{color: darkblue; font: 9pt sans-serif;}">'+
				'<TR BGCOLOR="silver"><TD WIDTH="30%"><B>Bank Code</B></TD>' +
				'<TD WIDTH="75%"><B>Accounts Number</B></TD></TR>'+
				m_row+
				'</TABLE>'; 
			myDialogObj.htmlstr = m_writedata;
			myDialogObj.returnval1 = "";
			myDialogObj.returnval2 = "";
			helpvalue="";
			popupwin = window.showModalDialog(html_client_url+"/help_box4.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no"); 
			helpvalue= document.applets[0].outvec_value.indexOf(myDialogObj.returnval);
			
			if (helpvalue != 1) {
				document.Form1.TXT_bank_code.value =myDialogObj.returnval1;
				document.Form1.TXT_ACC_number.value=myDialogObj.returnval2;
			}
			
			else { 
				if (helpvalue==1){
				}
			}
			
		}
		*/
		
	/*	function payee_bank_help() {
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=payee_bankacc&bankcode="+document.Form1.TXT_payee.value ;			
			document.applets[0].getdata(m_url);
			m_size=document.applets[0].outvec_value.size();
			vec_pos=0;
			m_row="";
			lineno=1;
			while (vec_pos<m_size) {
				m_bank_code=document.applets[0].outvec_value.elementAt(vec_pos);
				m_bank_desc=document.applets[0].outvec_value.elementAt(vec_pos+1); 
				m_row=m_row+'<TR STYLE="{color:black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+',C2R'+lineno+');><TD ID=C1R'+	lineno+'><B>'+m_bank_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_bank_desc+'</B></TD></TR>';
				vec_pos=vec_pos+2;
				lineno=lineno+1;
			}
			
			m_writedata ='<TABLE BGCOLOR="siler" WIDTH="100%" STYLE="{color: darkblue; font: 9pt sans-serif;}">'+
				'<TR BGCOLOR="silver"><TD WIDTH="30%"><B>Bank Code</B></TD>' +
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
	
	*/
	
		function clearAll(){
			document.Form1.TXT_portfolio.value="";
			document.Form1.TXT_bank_code.value="";
			document.Form1.TXT_ACC_number.value="";
			
			
			document.Form1.TXT_desc.value="";
			document.Form1.TXT_sec.value="";
			document.Form1.Text_sec_name.value="";
			
			document.Form1.TXT_INST.value="";
			document.Form1.TXT_payee.value="";
			document.Form1.TXT_chqno.value="";
			
			
			
			document.Form1.TXT_amount.value="";
			document.Form1.TXT_tax.value="";
			document.Form1.TXT_netAmount.value="";
			
				document.Form1.TXT_VALUE_DATE.value="";
			document.Form1.Text_comment.value="";
		
			
			
			
			
			
		}
		
		function BeforeSave(){
			document.Form1.save_but.disabled=true;
			document.Form1.TXT_bank_code.disabled=false;
			document.Form1.TXT_ACC_number.disabled=false;
			Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsavsett";
			Form1.submit();
			
		}
		
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
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=get_dat";
			
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
			if(m_size>0){	
				
				document.Form1.TXT_DATE.value=data_vec[0].substring(0,2);
				document.Form1.TXT_MONTH.value=data_vec[0].substring(3,5);
				document.Form1.TXT_YEAR.value=data_vec[0].substring(6,10);
			}
			else{
			}
		}
		function obtain_report_before() {
			m_url=html_client_url+'/dn_capitaldeposit_obtain.html';
			popupwin = window.open(m_url,'displayWindow', 'top=200, left=100, width=600, height=200, scrollbars=no, menubar=No, resizable=no, fullscreen=No');
		}
		
		//------pra-------------------------------
		$(document).ready
			(
				
				function() 
				{
					//initDialog();
					initCal('TXT_VALUE_DATE');
                 //   initCal('TXT_END_DATE');
				//	initDialogPOPup();
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
               if (instance_id == "TXT_VALUE_DATE") {
                   document.Form1.TXT_DATE.value = splitResult[0];
                   document.Form1.TXT_MONTH.value = splitResult[1];
                   document.Form1.TXT_YEAR.value = splitResult[2];
                   document.Form1.TXT_YEAR.focus();
               }
           //    else if (instance_id == "TXT_END_DATE") {
           //        document.Form1.TXT_DATE_FROM_PAY.value = splitResult[0];
          //         document.Form1.TXT_MONTH_FROM_PAY.value = splitResult[1];
         //          document.Form1.TXT_YEAR_FROM_PAY.value = splitResult[2];
         //          document.Form1.TXT_YEAR_FROM_PAY.focus();
         //      }
           }
		
		//-------------------------------------
		function chk_recno(){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?bankcode="+document.Form1.TXT_payee.value+"&chksql=payee_bank";
			
			load_interface(m_url,'XML',false);
			m_size = data_vec.length;
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
		
		function formatnum(num1)
		{					
			num1.value=format_noobject(num1.value);
		}
		
		function calNetAmount(num1,num2,num3)
		{					
			num3.value=format_noobject((unformat_noobject(num1.value)-unformat_noobject(num2.value)));
			
		}
		
		function calWithholding(num1)
		{	

		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=tax_rate"; //Added by Prabash on 27-07-2012
		load_interface(m_url,'XML',false);
			m_size = data_vec.length;
		if (m_size>0) {
			document.Form1.TXT_tax.value=format_noobject((unformat_noobject(num1.value)*data_vec[0])/100);
			//	document.Form1.TXT_tax.value=format_noobject((unformat_noobject(num1.value)*10)/100); //comment by Prabash on 27-07-2012
			calNetAmount(num1,document.Form1.TXT_tax,document.Form1.TXT_netAmount);
		}
		}
		
	</SCRIPT>
	</HEAD>
	<BODY  class="body & txt-body" onload="display_dat()" >
		<FORM NAME="Form1" ID="Form1" METHOD="POST" >
			<INPUT TYPE="Hidden" NAME="Hid_ACC_TYPE"	VALUE="DEPOSIT">
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="DIVIDEND_INCOME_NEW">
			<TABLE WIDTH="100%" BGCOLOR="darkblue" >
				
				<!--------------------------------------------------------------->
			<DIV>
			<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
				<tr>
					<td height='7'></td>
				</tr>
				
				<tr height='30' >
					<td  width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
					<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'> <B> Margin Trading - Receipts Management</B></td>
					<td width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>			
				</tr>
				<tr>		
			</TABLE>			
			</DIV>
			<!----------------------------------------------------------->
			<table class='table' border='0' cellpadding='0' cellspacing='0' width='100%'> 
			<tr>
			<td height='1'></td>
			</tr>
			<tr>				
			<!----------------------------------------------------------->	
			<TABLE WIDTH="100%" BGCOLOR="darkblue" >
					<TD WIDTH="6%">	
					<INPUT TYPE="Button" NAME="save_but" VALUE="Save&nbsp; "  class="mainbut"  onClick="BeforeSave()">
					</TD>
								
					<TD WIDTH="6%">				
					<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"  class="mainbut" onClick="clearAll()"> 
					</TD>
								
					<TD WIDTH="6%">				
					<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit&nbsp&nbsp;  "  class="mainbut" onClick="top.frames[1].location.href='low.jsp'"> 
					</TD>
					<TD WIDTH="*%"> &nbsp; </TD>
					<td width="50%" class="hh1" align="right"><b>Dividend Income</b></td>			
					<TD> <B><div id='div_lable' align='right' > </div> </B> </TD>	
				</TD>	
				</TR>
			</TABLE>
										
			<!----------------------------->
			 <TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
			<HR>
				<TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
			<!----------------------------->				
			 <div id="div_add_dividends">	
					
			<BR>
			<TABLE WidTH="80%" BORDER="0" CELLPADDING="1" CELLSPACING="0"  >   	
						
						 	
							<TR>
								<TD WIDTH="1%"></TD>
								<TD WidTH="30%">Facility Codes</TD>
								<TD WidTH="21%"><input class = "txt_input" TYPE="Text" NAME="TXT_portfolio"	ALIGN="LEFT" SIZE=20  OnBlur="Blur_porpolio(document.Form1.TXT_portfolio.value)">
								<INPUT TYPE="button" VALUE=" ... " NAME="BUT_INSTYPE" class="but_input"  OnClick="portP_help(0)" ></TD>

								<TD style = "width:10px;">Description</TD>
								<TD  ><input TYPE="Text" NAME="TXT_desc"	    ALIGN="LEFT" class = "txt_input" SIZE="30" disabled = "disabled"  style = "width: 250px;" ></TD>
							<TD style = "width:230px;"></TD>
							</TR>	
						
							<TR>
									<TD WIDTH="1%"></TD>
									<TD WidTH="30%">Security Code</TD>
									<TD WidTH="21%"><input class = "txt_input" TYPE="Text" NAME="TXT_sec"	ALIGN="LEFT" SIZE=20  OnBlur="sectype(document.Form1.TXT_sec)">
									<INPUT TYPE="button" VALUE=" ... " NAME="BUT_SEC" class="but_input"  OnClick="sec_help(0)" ></TD>
				
									
										<TD style = "width:10px;">Security Name</TD>
									<TD ><input TYPE="Text" NAME="Text_sec_name"	    ALIGN="LEFT" class = "txt_input" SIZE="30" disabled = "disabled"  style = "width: 250px;" ></TD>
									<TD style = "width:230px;">	</TD>
										
							</TR>	
							<TR>
									<TD WIDTH="1%"></TD>
									<TD WidTH="20%">Instrument</TD>
									<TD WidTH="21%"><input class = "txt_input" TYPE="Text" NAME="TXT_INST"	ALIGN="LEFT" SIZE=20  OnBlur="Blur_inst(document.Form1.TXT_INST.value)">
									<INPUT TYPE="button" VALUE=" ... " NAME="BUT_INSTYPE1" class="but_input"  OnClick="inst_help(0)" ></TD>
							</TR>	
								
								

								<TR>
									<TD WIDTH="1%"></TD>
									<TD WidTH="30%">Licensee Bank Code</TD>
									<TD WidTH="21%"><input class = "txt_input" TYPE="Text" NAME="TXT_bank_code"	ALIGN="LEFT" SIZE=20  disabled>
									<INPUT TYPE="button" VALUE=" ... " NAME="BUT_INSTYPE" class="but_input"  OnClick="bank_help(0)"></TD>
								</TR>	

							 	
								<TR>
									<TD WIDTH="1%"></TD>
									<TD WidTH="30%">Licensee  Accounts Number</TD>
									<TD WidTH="21%"><input class = "txt_input" TYPE="Text" NAME="TXT_ACC_number"	ALIGN="LEFT" SIZE=20  disabled></TD>
									<TD WidTH="*%"></TD>
								</TR>	
							
							
								<TR>
									<TD WIDTH="1%"></TD>
									<TD WidTH="30%">Payee Bank Code</TD>
									<TD WidTH="21%"><input class = "txt_input" TYPE="Text" NAME="TXT_payee"	ALIGN="LEFT" SIZE=20 ONBLUR="chk_recno()">
									<INPUT TYPE="button" VALUE=" ... " NAME="BUT_INSTYPE" class="but_input"  OnClick="payee_bank_help(0)"></TD>
								</TR>	
								
								<TR>
									<TD WIDTH="1%"></TD>
									<TD WidTH="30%">Cheque No</TD>
									<TD WidTH="21%"><input class = "txt_input" TYPE="Text" NAME="TXT_chqno"	ALIGN="LEFT" SIZE=20 ></TD>
								</TR>	
						
							
								<TR>
									<TD WIDTH="1%"></TD>
									<TD WidTH="30%">Gross Dividend</TD>
									<TD WidTH="21%"><input class = "txt_input" TYPE="Text" NAME="TXT_amount"	ALIGN="LEFT" SIZE=20  ONBLUR="calWithholding(document.Form1.TXT_amount);formatnum(document.Form1.TXT_amount)" ></TD> <!--//ONBLUR="formatnum(document.Form1.TXT_amount)"-->
								</TR>	

						  	
								<TR>
									<TD WIDTH="1%"></TD>
									<TD WidTH="30%">Withholding Tax</TD>
									<TD WidTH="21%"><input class = "txt_input" TYPE="Text" NAME="TXT_tax"	ALIGN="LEFT" SIZE=20  ONBLUR="calNetAmount(document.Form1.TXT_amount,document.Form1.TXT_tax,document.Form1.TXT_netAmount);formatnum(document.Form1.TXT_tax)" ></TD> <!--//ONBLUR="formatnum(document.Form1.TXT_amount)"-->
								</TR>	
							
							
								<TR>
									<TD WIDTH="1%"></TD>
									<TD WidTH="30%">Net Amount</TD>
									<TD WidTH="21%"><input class = "txt_input" TYPE="Text" NAME="TXT_netAmount"	ALIGN="LEFT" SIZE=20  ONBLUR="formatnum(document.Form1.TXT_tax)" ></TD> <!--//ONBLUR="formatnum(document.Form1.TXT_amount)"-->
								</TR>	

							
								<TD WIDTH="1%"></TD>
								<TD WIDTH="30%">Value Date</TD>
								<TD WIDTH="20%"><INPUT TYPE="Text" NAME="TXT_DATE" SIZE=3 MAXLENGTH=2 class="txt_input5 ">
									<INPUT TYPE="Text" NAME="TXT_MONTH" SIZE=3 MAXLENGTH=2 class="txt_input5 ">
									<INPUT TYPE="Text" NAME="TXT_YEAR" class="txt_input5 " SIZE=4 MAXLENGTH=4 ONBLUR="chkstartdate(document.Form1.TXT_DATE,document.Form1.TXT_MONTH,document.Form1.TXT_YEAR)"> 								
									<input type = "hidden" name = "TXT_VALUE_DATE" id = "TXT_VALUE_DATE" />
									<TD WIDTH="50%"></TD>	
										
								
								<TR>
		  					<TD WIDTH="1%"></TD>
							<TD  style = "width: 150px;">Comment</TD>
										
			 				<TD ><INPUT TYPE="Text" NAME="Text_comment" style = "width: 300px;"	ALIGN="LEFT" SIZE="5" ></TD>					
   							<TR > 
								
								
							</TABLE> 
									
						</FORM>
				<!--		<applet code=mf_datagateway.class width=0 height=0></applet>-->
								<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>	
						<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT> 
					</body>
				</html>
				
