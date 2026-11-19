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
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/blue/style.css' TYPE=\"text/css\">");
		
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");	
		
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/SNET/jquery/grid/4.1/themes/ui.jqgrid.css' TYPE=\"text/css\">");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/i18n/grid.locale-en.js\"></script>");
		out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/jquery.jqGrid.min.js\"></script>");		
	%>
	
	<SCRIPT language="JavaScript1.2" >
		
		
	// ***********************************************************************************		
	// ************* Start New Help ******************************************************	
	// ***********************************************************************************	
			
		function deal_no_help(m_strat) {
			
			var aForm;    //  aForm =oForm.elements;
	     	aForm =  document.getElementById('Form1');
	
			var myObject=new Array(); //return values set to this object
	 		myObject[0]=aForm.TXT_DEAL_NO;
	 		myObject[1]=null;
	 		myObject[2]=null;
	 		myObject[3]=null;
	 		myObject[4]=null;
	  
	 		var myObject_value=new Array(); //passing values set to this object
	
			myObject_value[0]=aForm.TXT_DEAL_NO.value;
			myObject_value[1]=aForm.TXT_DEAL_NO.value;
			myObject_value[2]=aForm.TXT_DEAL_NO.value;
			myObject_value[3]=aForm.TXT_DEAL_NO.value;
			myObject_value[4]=aForm.TXT_DEAL_NO.value;
			myObject_value[5]=aForm.TXT_DEAL_NO.value;
			myObject_value[6]=aForm.TXT_DEAL_NO.value;
			myObject_value[7]=aForm.TXT_DEAL_NO.value;
			myObject_value[8]=aForm.TXT_DEAL_NO.value;
			myObject_value[9]=aForm.TXT_DEAL_NO.value;
			myObject_value[10]=aForm.TXT_DEAL_NO.value;
			myObject_value[11]=aForm.TXT_DEAL_NO.value;
			myObject_value[12]=aForm.TXT_DEAL_NO.value;
	 
	 
	 		var myObject_type=new Array(); //passing values data type
			
			myObject_type[0]="StringL";
			myObject_type[1]="StringL";
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
			myObject_type[12]="StringL";
			
	 
	 		var qid='53'; // 2
			var close_fun='close_deal_no_help';
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
			 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
			});
			
		}	// End deal_no_help
			
			
		function close_deal_no_help(){
			document.Form1.TXT_DEAL_NO.text='';
		}	
		
		
		// ====================================================================================
		
		
		function facility_no_help(m_strat) {
			
			var aForm;    //  aForm =oForm.elements;
	     	aForm =  document.getElementById('Form1');
	
			var myObject=new Array(); //return values set to this object
	 		myObject[0]=aForm.TXT_FAC_NO;
	 		myObject[1]=null;
	 		myObject[2]=null;
	 		myObject[3]=null;
	 		myObject[4]=null;
	  
	 		var myObject_value=new Array(); //passing values set to this object
	
			myObject_value[0]=aForm.TXT_FAC_NO.value;
	 
	 		var myObject_type=new Array(); //passing values data type
			
			myObject_type[0]="StringL";

			
	 
	 		var qid='54'; // 2
			var close_fun='close_facility_no_help';
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
			 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
			});
			
		}	// End facility_no_help
			
			
		function close_facility_no_help(){
			document.Form1.TXT_FAC_NO.text='';
		}
		
		
		// ==================================================================================
		
		function broker_no_help(m_strat) {
			
			var aForm;    //  aForm =oForm.elements;
	     	aForm =  document.getElementById('Form1');
	
			var myObject=new Array(); //return values set to this object
	 		myObject[0]=aForm.TXT_BROKER_NO;
	 		myObject[1]=null;
	 		myObject[2]=null;
	 		myObject[3]=null;
	 		myObject[4]=null;
	  
	 		var myObject_value=new Array(); //passing values set to this object
	
			myObject_value[0]=aForm.TXT_BROKER_NO.value;
	 
	 		var myObject_type=new Array(); //passing values data type
			
			myObject_type[0]="StringL";

			
	 
	 		var qid='55'; // 2
			var close_fun='close_broker_no_help';
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
			 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
			});
			
		}	// End broker_no_help
			
			
		function close_broker_no_help(){
			document.Form1.TXT_BROKER_NO.text='';
		}

	
			
	
	// *********************************************************************************			
	// ************ End New Help *******************************************************		
	// *********************************************************************************			
		
		   function pop_up_message(m_url){					
				if ($("#DIV_MSG_WINDOW").dialog("isOpen")) 
				{
            		$("#DIV_MSG_WINDOW").dialog("close");
            	}
            	$("#DIV_MSG_WINDOW").dialog("option", "title", "Transaction Reversals");
            	$("#DIV_MSG_WINDOW").dialog("open");
            	$("#IFRAME_MSG_WINDOW").attr("src",m_url);
            	return false;				
			}
		
		   function pop_up_message_2(row_id){	
				
				var obj_dealnum = jQuery("#TABLE_REVERSAL_DETAILS").jqGrid ("getCell", row_id, 'deal_no'); 
				var m_url = '';
				
				if(obj_dealnum!='not found'){
			
				    if ((obj_dealnum.substring(0,2)=="OR")|| (obj_dealnum.substring(0,2)=="GO")){
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
					
				}
				
				if ($("#DIV_MSG_WINDOW").dialog("isOpen")) 
				{
            		$("#DIV_MSG_WINDOW").dialog("close");
            	}
            	$("#DIV_MSG_WINDOW").dialog("option", "title", "Transaction Reversals");
            	$("#DIV_MSG_WINDOW").dialog("open");
            	$("#IFRAME_MSG_WINDOW").attr("src",m_url);
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
	
	        function clearIsOpen(){ 
              	isOpen=false; 
            }
	
			var isOpen=false;
		
			function initmsgDrillDialog(){				
	             $("#DIV_MSG_WINDOW").dialog(				
				 {					
	            	bgiframe: true,
	            	autoOpen: false,
	            	//modal: false,
					modal: true, //to disable the back ground	
	            	//height: 300,
	            	//width: getW,
					height: 500,
	            	width: 800,
	            	close: function() 
					{
						
	            	}
	              }
				 );
           }
		
			$(document).ready
			(				
				function() 
				{
					initCal("TRANS_FROM_DATE");
					initCal("TRANS_TO_DATE");
	 				initmsgDrillDialog();
					m_grid_height = ($(window).height() - 150);
			   		m_grid_width = ($(window).width() - 0);
				}
			);
			
		
			function chkstartdate(dayobj,monthobj,yearobj) {
				checkMonthLength(dayobj,monthobj,yearobj);		
			}
		
			function screen_close(){
				top.frames[1].location.href='low.jsp';
			} 

			function load_date(){
				
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'inventory_by_date_location?chksql=chk_sysdate'; 	
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;

 				if(m_size>0){ 
					document.Form1.TXT_FROM_DATE.value  = data_vec[0];
			  		document.Form1.TXT_FROM_MONTH.value = data_vec[1]; 						 
			  		document.Form1.TXT_FROM_YEAR.value  = data_vec[2];	
					document.Form1.TXT_TO_DATE.value  = data_vec[0];
			  		document.Form1.TXT_TO_MONTH.value = data_vec[1]; 						 
			  		document.Form1.TXT_TO_YEAR.value  = data_vec[2];
						
					document.Form1.TRANS_FROM_DATE.value = data_vec[0]+'-'+data_vec[1]+'-'+data_vec[2];
					document.Form1.TRANS_TO_DATE.value   = data_vec[0]+'-'+data_vec[1]+'-'+data_vec[2];
						
				}	
	
			}
		
		function initCal(inst){
			$("#"+inst).datepicker({dateFormat:'dd-mm-yy',duration: 'fast',yearRange: '1920:2050',showOn: 'button',buttonImage: 'https://dev-adlmargin.sasianet.com:8443/ADLMARGIN/LBMARGIN/SNET/images/calendar.gif',buttonImageOnly: true,changeMonth: true,changeYear: true,onSelect: function(dateText, inst){dateSelectFunc(dateText,inst);}});
		}
		
		function dateSelectFunc(dateText, inst){
			
			var splitResult = dateText.split('-');
			var instance_id = inst.id;
			var m_last_index_of_underscore = instance_id.lastIndexOf('_');
			var first_part = instance_id.substr(0, m_last_index_of_underscore + 1);
			var second_part = instance_id.substr(m_last_index_of_underscore + 1);
			
			if (inst.id=="TRANS_FROM_DATE"){
				document.Form1.TXT_FROM_DATE.value=splitResult[0];
				document.Form1.TXT_FROM_MONTH.value=splitResult[1];
				document.Form1.TXT_FROM_YEAR.value=splitResult[2];
				document.Form1.TRANS_FROM_DATE.value = splitResult[0]+'-'+splitResult[1]+'-'+splitResult[2];
				document.Form1.TXT_FROM_DATE.focus();
			}
			
			if (inst.id=="TRANS_TO_DATE"){
				document.Form1.TXT_TO_DATE.value=splitResult[0];
				document.Form1.TXT_TO_MONTH.value=splitResult[1];
				document.Form1.TXT_TO_YEAR.value=splitResult[2];
				document.Form1.TRANS_TO_DATE.value = splitResult[0]+'-'+splitResult[1]+'-'+splitResult[2];
				document.Form1.TXT_TO_DATE.focus();
			}
		}
		
		function fn_view() { 
			
			  jQuery('#TABLE_REVERSAL_DETAILS').GridUnload('#TABLE_REVERSAL_DETAILS');
			
			   var from_date = document.Form1.TXT_FROM_DATE.value+'-'+document.Form1.TXT_FROM_MONTH.value+'-'+document.Form1.TXT_FROM_YEAR.value;
			   var to_date = document.Form1.TXT_TO_DATE.value+'-'+document.Form1.TXT_TO_MONTH.value+'-'+document.Form1.TXT_TO_YEAR.value;
			   var deal_no = document.Form1.TXT_DEAL_NO.value;
			   var facility_code = document.Form1.TXT_FAC_NO.value;
			   var broker_code = document.Form1.TXT_BROKER_NO.value;
			
               //m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"generate_conf?chksql=transaction_reversal";
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"generate_conf?chksql=transaction_reversal&deal_no="+deal_no+"&facility_code="+facility_code+"&broker_code="+broker_code+"&from_date="+from_date+"&to_date="+to_date;
			
				   jQuery('#TABLE_REVERSAL_DETAILS').jqGrid({
                   url: m_url,
                   loadonce: 1,
                   datatype: 'json',
                   colNames: ['Deal No','BL Security','Amount','Dealer','Limit Violations','Details','Save <input type="checkbox"  name="save_cb" value="s" onclick="validateDealChkBoxAll(event,this)" />','Facility','Broker','Effective Date'],
                   colModel: [
						{name: 'deal_no',             	index: 'deal_no',   		  jsonmap: 'deal_no',             sortable: false, align: 'left',   width: 100, resizable: false,  unformat: unformatData , formatter:cellFomatterDealNo},
						{name: 'bl_security',         	index: 'bl_security',   	  jsonmap: 'bl_security', 	      sortable: false, align: 'left',   width: 80,  resizable: false,  unformat: unformatData},
						{name: 'face_value',        	index: 'face_value',  	      jsonmap: 'face_value', 	      sortable: false, align: 'right' , width: 80,  resizable: false,  unformat: unformatData},
						{name: 'dn_user',               index: 'dn_user',      	      jsonmap: 'dn_user', 		      sortable: false, align: 'left',   width: 50,  resizable: false,  unformat: unformatData},
						{name: 'not_applicable',        index: 'not_applicable',   	  jsonmap: 'not_applicable',  	  sortable: false, align: 'left',   width: 100, resizable: false,  unformat: unformatData },
						{name: 'details_but',           index: 'details_but',   	  jsonmap: 'details_but',         sortable: false, align: 'center', width: 80,  resizable: false,  unformat: unformatData , formatter:cellFomatterDetailsButton},
						{name: 'Save',                  index: 'Save',                jsonmap: 'Approve', 			  sortable: false, align: 'center', width: 80,  resizable: false,  unformat: unformatData,  formatter:checkBoxFmatterSave},
						{name: 'borr_portfolio_code',   index: 'borr_portfolio_code', jsonmap: 'borr_portfolio_code', sortable: false, align: 'left',   width: 60,  resizable: false,  unformat: unformatData },
						{name: 'lend_portfolio_code',   index: 'lend_portfolio_code', jsonmap: 'lend_portfolio_code', sortable: false, align: 'left',   width: 80,  resizable: false,  unformat: unformatData }, 
						{name: 'eff_val_date',          index: 'eff_val_date',        jsonmap: 'eff_val_date',        sortable: false, align: 'left',   width: 80,  resizable: false,  unformat: unformatData, formatter:cellEffectivedate }], 
						
                   mtype: 'GET',
                   rownumbers: true,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
							width: 'auto',
                   hidegrid: false,
                   toolbar: [false, 'top'],
                   caption: 'Transaction Reversals',
				   jsonReader: {repeatitems: false},
                   gridComplete: function() {
						
					},
					loadComplete : function(){
                        var rec_count=$("#TABLE_REVERSAL_DETAILS").jqGrid('getGridParam',"records");
                        document.Form1.hid_count.value=rec_count;
					}
               });
           }
		
		function validateDealChkBox(row_id){
			
			if(document.getElementById("save_"+row_id).checked == true){
				
					var deal_no = document.getElementById("DealNo_"+row_id).value;
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?chksql=chkDealNumber&dealCode="+deal_no+" ";	
					load_interface(m_url,'XML',false);
					m_size = data_vec.length;
					
					if(m_size<=0){
						alert('Deal No.'+deal_no+' cannot be reversed');
						document.getElementById("save_"+row_id).checked = false;
					}
					else{
						
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?chksql=deal_chk&deal_no="+deal_no+" ";
						window.open(m_url)
						load_interface(m_url,'XML',false);
						m_size = data_vec.length;
						
						if((m_size==1 && deal_no.substring(0,2)=='OR')|| deal_no.substring(0,2)!='OR'){
							document.getElementById("save_"+row_id).checked = true;
						}
						else{
							alert('Deal No.'+deal_no+' cannot be reversed');
							document.getElementById("save_"+row_id).checked = false;
						}
						
					}
			} // main if
			else {
				document.getElementById("save_"+row_id).checked = false;
			} // main else if
			
		}
		
		
		function validateDealChkBoxAll(e,obj){
			
			e = e||event; 
		    e.stopPropagation? e.stopPropagation() : e.cancelBubble = true;

		    var no_of_rows = jQuery("#TABLE_REVERSAL_DETAILS").getDataIDs().length;			
			
			if(document.Form1.save_cb.checked==true){
					for(i=1; i<=no_of_rows; i++){ //start for
						document.getElementById("save_"+i).checked = true;
						validateDealChkBox(i);
						validatedates(i);
					} // end for
			}
			else{
				for(i=1; i<=no_of_rows; i++){ //start for
						document.getElementById("save_"+i).checked = false;
				} // end for
			}
			
		}
		
		function beforesubmit(){
			
			var no_of_rows = jQuery("#TABLE_REVERSAL_DETAILS").getDataIDs().length;	
			document.Form1.hid_count.value = no_of_rows;
			
			var flag = "false";
			for(i=1; i<=no_of_rows; i++){ 
				if(document.getElementById("save_"+i).checked == true){
					flag = "true";
					break;
				}
			}
			
			if(flag=="true"){			
				if(confirm("Are you sure?")){
					document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_delete_deal";
					document.Form1.submit();
					//alert('Sure');
				}
			}
			else{
				alert('No items to reverse');
			}

		}
		
		
		function validatedates(row_id){
			
			var eff_value_date = document.getElementById("EffectiveDate_"+row_id).value;
			var deal_no = document.getElementById("DealNo_"+row_id).value;
			
			if(document.getElementById("save_"+row_id).checked == true){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?chksql=validate_dayend_date&eff_value_date="+eff_value_date+" ";
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
				
				if((m_size>0) && (data_vec[0]=='YES') ){
					document.getElementById("save_"+row_id).checked = true;
				}
				else{
					alert('Deal No. '+deal_no+' cannot be deleted, as the day end is run');
					document.getElementById("save_"+row_id).checked = false;
				}
			}
			else{
				document.getElementById("save_"+row_id).checked = false;
			}
				
		}
		
		
		
		
		function cellFomatterDetailsButton(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span><input type='button' align='center' style ='text-align: center;'  id='m_detail_but_"+row_id+"' name='m_detail_but_"+row_id+"' value='Details' class='mainbut' onclick='pop_up_message_2("+row_id+")' /></span>";
                     return texts;
         } 
		
		 function checkBoxFmatterSave (cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='checkbox' id='save_"+rowid+"'  name='save_"+rowid+"' value='on'  onclick ='validateDealChkBox("+rowid+"); validatedates("+rowid+"); ' />";  
			  return link;
		 }

		function cellFomatterDealNo (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='DealNo_"+row_id+"' name='DealNo_"+row_id+"' value='"+cellvalue+"'  /></span>";
                     return texts;
        } 
		
		function cellEffectivedate (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='EffectiveDate_"+row_id+"' name='EffectiveDate_"+row_id+"' value='"+cellvalue+"'  /></span>";
                     return texts;
        } 


		function unformatData(cellvalue, options, cellobject) {
               return cellvalue;
        }
		
		function checkDate(){
			
				var from_date = document.Form1.TXT_FROM_DATE.value+'-'+document.Form1.TXT_FROM_MONTH.value+'-'+document.Form1.TXT_FROM_YEAR.value;
				var to_date   = document.Form1.TXT_TO_DATE.value+'-'+document.Form1.TXT_TO_MONTH.value+'-'+document.Form1.TXT_TO_YEAR.value;
			
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'inventory_by_date_location?chksql=get_date_gap&from_date='+from_date+'&to_date='+to_date; 	
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;

 				if(m_size>0){ 
					fn_view();	
				}
			    else if(m_size<0){
					alert('To Date cannot be Less Than From Date');
				}
				else if(m_size==0){
					fn_view();
				}
		}
		
		
	</SCRIPT>
	
	<BODY  class='body & txt-body' onload= "load_date();" >
		
		<FORM NAME="Form1" ID="Form1" METHOD="POST" >

			    <INPUT TYPE="Hidden" NAME="hid_count"	 VALUE="MARKET_VALUE">
			    <INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="REVERSE_DEAL">
				<INPUT TYPE="Hidden" NAME="hid_help_type"	VALUE="REVERSE_DEAL">
				<INPUT TYPE="Hidden" NAME="Hid_dealValue"	VALUE="REVERSE_DEAL">
			
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
					<TABLE WIDTH="97%" ALIGN="CENTER" BGCOLOR="darkblue" >
						<TR>							
							<TD WIDTH="5%"><INPUT TYPE="Button" NAME="Save_but"        VALUE=" &nbsp;Save&nbsp; "  onClick="beforesubmit();" class="mainbut" ></TD>
							<TD WIDTH="5%"><INPUT TYPE="Button" NAME="Cancel_but"      VALUE=" Cancel"             onClick="top.frames[1].location.href='dn_data_entry_tran_reversal.jsp'" class="mainbut" > </TD>
							<TD WIDTH="5%"><INPUT TYPE="Button" NAME="Exit_but"        VALUE=" &nbsp;Exit&nbsp; "  onClick="screen_close()" class="mainbut" ></TD>
							<TD WIDTH="*%"> &nbsp; </TD>
							<TD WIDTH="25%" align='right'> <b> <div id="m_table"> Transaction Reversals </div></b></TD>							
						</TR>
					</TABLE>
					
					<HR>
					
					<BR>	
					<!-- <TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0"> -->
					<TABLE WIDTH="97%" ALIGN="CENTER" BGCOLOR="darkblue" BORDER="0" CELLPADDING="1" CELLSPACING="0">
						
						<TR>							
						   <TD WIDTH="10%"> Deal No </TD>							
						   <TD WIDTH="40%"> 
								 <INPUT TYPE="text"   NAME="TXT_DEAL_NO"   align="left" size="20"  class="txt_input6 "  maxlength="20" >
						    	 <INPUT TYPE="Button" NAME="BUT_DEAL_NO" VALUE="..." onClick="deal_no_help(0)" class="mainbut" >
							</TD>
							<TD WIDTH="*%"> &nbsp; </TD>
					    </TR>	
						
						<TR>							
						   <TD WIDTH="10%"> Facility Code </TD>							
						   <TD WIDTH="40%"> 
								 <INPUT TYPE="text"   NAME="TXT_FAC_NO"   align="left" size="20"  class="txt_input6 "  maxlength="20" >
						    	 <INPUT TYPE="Button" NAME="BUT_FAC_NO" VALUE="..." onClick="facility_no_help(0)" class="mainbut" >
							</TD>
							<TD WIDTH="*%"> &nbsp; </TD>
					    </TR>
						
						<TR>							
						   <TD WIDTH="10%"> Broker Code </TD>							
						   <TD WIDTH="40%"> 
								 <INPUT TYPE="text"   NAME="TXT_BROKER_NO"   align="left" size="20"  class="txt_input6 "  maxlength="20" >
						    	 <INPUT TYPE="Button" NAME="BUT_BROKER_NO" VALUE="..." onClick="broker_no_help(0)" class="mainbut" >
							</TD>
							<TD WIDTH="*%"> &nbsp; </TD>
					    </TR>

						
						<TR>							
						   <TD WIDTH="10%"> From Date </TD>
							<!--
						   <TD WIDTH="40%"> 
								 <INPUT TYPE="text" NAME="TXT_FROM_DATE"   align="left" size="3"  class="txt_input5 "  maxlength="2" >
								 <INPUT TYPE="text" NAME="TXT_FROM_MONTH"  align="left" size="3"  class="txt_input5 "  maxlength="2" > 
								 <INPUT TYPE="text" NAME="TXT_FROM_YEAR"   align="left" size="4"  class="txt_input5 "  maxlength="4"  ONBLUR="chkstartdate(document.Form1.TXT_FROM_DATE,document.Form1.TXT_FROM_MONTH,document.Form1.TXT_FROM_YEAR)" >
						    </TD>
							-->

							<td width="40%">
							<input class="txt_input5" type="text" name="TXT_FROM_DATE"  maxlength="2"  size="2" value="" onblur = "checkMonthLength1(document.Form1.elements['TXT_FROM_DATE'], document.Form1.elements['TXT_FROM_MONTH'], document.Form1.elements['TXT_FROM_YEAR'], document.Form1.elements['TRANS_FROM_DATE'], 'D', 'N'); 			checkTwoDates(document.Form1.elements['TXT_FROM_DATE'], document.Form1.elements['TXT_FROM_MONTH'], document.Form1.elements['TXT_FROM_YEAR'],  document.Form1.elements['TRANS_FROM_DATE'], document.Form1.elements['TXT_TO_DATE'], document.Form1.elements['TXT_TO_MONTH'], document.Form1.elements['TXT_TO_YEAR'], document.Form1.elements['TRANS_TO_DATE'], 1, this, 'D', '<=', 'To Date' , 'From Date');" />
							<input class="txt_input5" type="text" name="TXT_FROM_MONTH" maxlength="2"  size="2" value="" onblur = "checkMonthLength1(document.Form1.elements['TXT_FROM_DATE'], document.Form1.elements['TXT_FROM_MONTH'], document.Form1.elements['TXT_FROM_YEAR'], document.Form1.elements['TRANS_FROM_DATE'], 'M', 'N'); 			checkTwoDates(document.Form1.elements['TXT_FROM_DATE'], document.Form1.elements['TXT_FROM_MONTH'], document.Form1.elements['TXT_FROM_YEAR'],  document.Form1.elements['TRANS_FROM_DATE'], document.Form1.elements['TXT_TO_DATE'], document.Form1.elements['TXT_TO_MONTH'], document.Form1.elements['TXT_TO_YEAR'], document.Form1.elements['TRANS_TO_DATE'], 1, this, 'M', '<=', 'To Date' , 'From Date');" />
							<input class="txt_input5" type="text" name="TXT_FROM_YEAR"  maxlength="4"  size="4" value="" onblur = "checkMonthLength1(document.Form1.elements['TXT_FROM_DATE'], document.Form1.elements['TXT_FROM_MONTH'], document.Form1.elements['TXT_FROM_YEAR'], document.Form1.elements['TRANS_FROM_DATE'], 'Y', 'N'); 			checkTwoDates(document.Form1.elements['TXT_FROM_DATE'], document.Form1.elements['TXT_FROM_MONTH'], document.Form1.elements['TXT_FROM_YEAR'],  document.Form1.elements['TRANS_FROM_DATE'], document.Form1.elements['TXT_TO_DATE'], document.Form1.elements['TXT_TO_MONTH'], document.Form1.elements['TXT_TO_YEAR'], document.Form1.elements['TRANS_TO_DATE'], 1, this, 'Y', '<=', 'To Date' , 'From Date');" />
							<input type="hidden" name="TRANS_FROM_DATE" id="TRANS_FROM_DATE" value="" />
							</td>
							
							<TD WIDTH="*%"> &nbsp; </TD>
					    </TR>
						
						<TR>	
							<TD WIDTH="10%"> To Date </TD>
							<!--
						    <TD WIDTH="40%"> 
								 <INPUT TYPE="text" NAME="TXT_TO_DATE"	 align="left" size="3"  class="txt_input5 "  maxlength="2" >
								 <INPUT TYPE="text" NAME="TXT_TO_MONTH"  align="left" size="3"  class="txt_input5 "  maxlength="2" > 
								 <INPUT TYPE="text" NAME="TXT_TO_YEAR"	 align="left" size="4"  class="txt_input5 "  maxlength="4"  ONBLUR="chkstartdate(document.Form1.TXT_TO_DATE,document.Form1.TXT_TO_MONTH,document.Form1.TXT_TO_YEAR)" >
						    </TD>
							-->
							
							<td width="40%">
							<input class="txt_input5" type="text" name="TXT_TO_DATE" maxlength="2"  size="2" value="" onblur = "checkMonthLength1(document.Form1.elements['TXT_TO_DATE'], document.Form1.elements['TXT_TO_MONTH'], document.Form1.elements['TXT_TO_YEAR'], document.Form1.elements['TRANS_TO_DATE'], 'D', 'N'); 		checkTwoDates(document.Form1.elements['TXT_FROM_DATE'], document.Form1.elements['TXT_FROM_MONTH'], document.Form1.elements['TXT_FROM_YEAR'],  document.Form1.elements['TRANS_FROM_DATE'], document.Form1.elements['TXT_TO_DATE'], document.Form1.elements['TXT_TO_MONTH'], document.Form1.elements['TXT_TO_YEAR'], document.Form1.elements['TRANS_TO_DATE'], 1, document.Form1.elements['TXT_FROM_DATE'], 'D', '<=', 'To Date' , 'From Date');" />
							<input class="txt_input5" type="text" name="TXT_TO_MONTH" maxlength="2" size="2" value="" onblur = "checkMonthLength1(document.Form1.elements['TXT_TO_DATE'], document.Form1.elements['TXT_TO_MONTH'], document.Form1.elements['TXT_TO_YEAR'], document.Form1.elements['TRANS_TO_DATE'], 'M', 'N'); 		checkTwoDates(document.Form1.elements['TXT_FROM_DATE'], document.Form1.elements['TXT_FROM_MONTH'], document.Form1.elements['TXT_FROM_YEAR'],  document.Form1.elements['TRANS_FROM_DATE'], document.Form1.elements['TXT_TO_DATE'], document.Form1.elements['TXT_TO_MONTH'], document.Form1.elements['TXT_TO_YEAR'], document.Form1.elements['TRANS_TO_DATE'], 1, document.Form1.elements['TXT_FROM_MONTH'], 'M', '<=', 'To Date' , 'From Date');" />
							<input class="txt_input5" type="text" name="TXT_TO_YEAR" maxlength="4"  size="4" value="" onblur = "checkMonthLength1(document.Form1.elements['TXT_TO_DATE'], document.Form1.elements['TXT_TO_MONTH'], document.Form1.elements['TXT_TO_YEAR'], document.Form1.elements['TRANS_TO_DATE'], 'Y', 'N'); 		checkTwoDates(document.Form1.elements['TXT_FROM_DATE'], document.Form1.elements['TXT_FROM_MONTH'], document.Form1.elements['TXT_FROM_YEAR'],  document.Form1.elements['TRANS_FROM_DATE'], document.Form1.elements['TXT_TO_DATE'], document.Form1.elements['TXT_TO_MONTH'], document.Form1.elements['TXT_TO_YEAR'], document.Form1.elements['TRANS_TO_DATE'], 1, document.Form1.elements['TXT_FROM_YEAR'], 'Y', '<=', 'To Date' , 'From Date');" />
							<input type="hidden" name="TRANS_TO_DATE" id="TRANS_TO_DATE" value="" />
							</td>
							
							
							<TD WIDTH="*%"> &nbsp; </TD>
					    </TR>
						
						<TR>
							<TD WIDTH="10%"> &nbsp; </TD>
							<TD WIDTH="40%"><INPUT TYPE="Button" NAME="search_transactions"  VALUE="Search" onClick="checkDate();" class="mainbut" ></TD>  <!-- fn_view -->
							<TD WIDTH="*%"> &nbsp; </TD>
						</TR>						
								<TR>
									<TD WIDTH="1%"></TD>
									<TD WIDTH="*%"> <!-- -->
										
												<table align='center' width='100%' class='table'>
												<tr> 
												<td width="100%"  height="70%"><div id="data_div"></div></td>
												</tr> 
												</table>										
										
												<DIV ALIGN="CENTER" id=insdata ></DIV>																		
									</TD> 
								</tr>
							</table>
						</TD>
					</tr>
					
				</table>
		
		  <div id = "DIV_AVAILABILITY_DETAILS">
                     <table id = "TABLE_REVERSAL_DETAILS"></table>
                      <div id = "DIV_PAGER_REVERSAL_DETAILS"></div>
           </div>
		
		   <div id ="DIV_MSG_WINDOW" title ="Transaction Reversals">
	       <iframe id ="IFRAME_MSG_WINDOW" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Day End Routine">
	       </iframe>
	       </div>		
		
			</FORM>
			<!-- <SCRIPT language1.2="JavaScript" src="validate.js"></SCRIPT> -->
			<SCRIPT language1.2="JavaScript" src="market_rate_sec.js"></SCRIPT>
			<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>
			<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
			<script type="text/javascript" src="validate.js"></script>
		</body>
	</html>
	
