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
		
		String m_deal_num = request.getParameter("deal_num");
		String m_deal_num_2;
		
		if( null != m_deal_num && !m_deal_num.equals( "" ) ){
			m_deal_num_2 = m_deal_num;
		}
		else{
			m_deal_num_2 = "not found";
		}
		
		//String m_deal_num = request.getParameter("deal_num");
		
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
	            	height: 400,
	            	width: getW,
	            	close: function() 
					{
						
	            	}
	              }
				 );
           }
		
		
		   function initmsgDealTicketDrill(h,w)
	        {
				
	             $("#DIV_MSG_DEAL_TICKET").dialog(
				
				 {
					
	            	bgiframe: true,
	            	autoOpen: false,
	            	//modal: false,
					modal: true, //to disable the back ground	
	            	height: h,
	            	width: w,
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
					m_grid_height = ($(window).height() - 310);
	 				initmsgDrillDialog();
					initmsgDealTicketDrill(100,500);
					m_grid_height = ($(window).height() - 150);
			   		m_grid_width = ($(window).width() - 0);
				}
			);
			
		
			function chkstartdate(dayobj,monthobj,yearobj) {
				checkMonthLength(dayobj,monthobj,yearobj);		
			}
		
			function screen_close(){
				//top.frames[1].location.href='low.jsp';
				window.close();
			} 		
		

		
		function refresh(){
			top.frames[1].location.href='dn_Outrights_Pre_Confirmation.jsp';
		}
		
		function refresh_2(){
			top.frames[1].location.href='dn_Outrights_Pre_Confirmation.jsp.jsp?deal_num=ORMT1109270002';
		}
		
		function testOnLoad(){
			var obj_dealnum="<%=m_deal_num_2%>";
			
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

				 pop_up_message_2(m_url);
			}
		}

		
		function pop_up_message(row_id){
			 var obj_dealnum = jQuery("#TABLE_AVAILABILITY_DETAILS").jqGrid ("getCell", row_id, 'deal_no'); 
			
             
			
		     if ((obj_dealnum.substring(0,2)=="OR")|| (obj_dealnum.substring(0,2)=="PA")){
				  	 m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bautho_confirm?chksql=confirm_details&m_identity=PRECONFIRM&deal_num="+obj_dealnum;
		     }  
			 else if ((obj_dealnum.substring(0,2)=="OR")|| (obj_dealnum.substring(0,2)=="GO")){
				  	 m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmprint?chksql=confirm_details&m_identity=PRECONFIRM&deal_num="+obj_dealnum;
		     } 
			
			 else if ((obj_dealnum.substring(0,2)=="RF")|| (obj_dealnum.substring(0,2)=="GF")){
				 	  m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmrepo?chksql=confirm_details_repo&m_identity=PRECONFIRM&deal_num="+obj_dealnum;
		  	 }
			 else if(obj_dealnum.substring(0,2)=="PI"){	
				 	m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmrepoPI?chksql=confirm_details_repo&m_identity=PRECONFIRM&deal_num="+obj_dealnum;
		  	 }
		  	 else if ((obj_dealnum.substring(0,2)=="RR")|| (obj_dealnum.substring(0,2)=="GR")){
				 	m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmrepo?chksql=confirm_details_rollover&m_identity=PRECONFIRM&deal_num="+obj_dealnum;
		  	 }
			 else if(obj_dealnum.substring(0,2)=="SO"){	
						m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmoutright?chksql=confirm_details_outright&m_identity=PRECONFIRM&deal_num="+obj_dealnum;
		  	 }
		     else if(obj_dealnum.substring(0,2)=="BF"){	
				 	m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmblfund?chksql=confirm_details_blfunds&m_identity=PRECONFIRM&deal_num="+obj_dealnum;
			 }
			 else if(obj_dealnum.substring(0,2)=="BS"){	
						m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmblfund?chksql=confirm_details_blsecurity&m_identity=PRECONFIRM&deal_num="+obj_dealnum;
			 }
			 else if(obj_dealnum.substring(0,2)=="SR"){	
						m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmreturnable?chksql=confirm_details_returnable&m_identity=PRECONFIRM&deal_num="+obj_dealnum;
			 }
			 else if(obj_dealnum.substring(0,2)=="RS"){	
				 		m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"confirmrepo_setlle?chksql=confirm_details_reposettle&m_identity=PRECONFIRM&deal_num="+obj_dealnum;
			 }
			else if(obj_dealnum.substring(0,2)=="RB"){	
				 		m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"confirmrebate?chksql=confirm_details_rebate&m_identity=PRECONFIRM&deal_num="+obj_dealnum;
			 }
			
			
			 //var m_url = servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmprint?chksql=confirm_details&m_identity=PRECONFIRM&deal_num="+obj_dealnum+" ";
			 
				if ($("#DIV_MSG_WINDOW").dialog("isOpen")) 
				{
            		$("#DIV_MSG_WINDOW").dialog("close");
            	}
            	$("#DIV_MSG_WINDOW").dialog("option", "title", "Generate Confirmation");
            	$("#DIV_MSG_WINDOW").dialog("open");
            	$("#IFRAME_MSG_WINDOW").attr("src",m_url);
            	return false;				
		}
		

		
		// ====================== Adding jason grid Start =====================================
		
		 function fn_view() {   
				
               m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"pre_autho_conf?chksql=confirmation";
					jQuery('#TABLE_AVAILABILITY_DETAILS').jqGrid({
                   url: m_url,
                   loadonce: 1,
                   datatype: 'json',
                   colNames: ['Deal No','Buy/Sell','Security Code','Price Range','No of Shares','Type of Transaction','Order Qualifieres','Time in Force','Dealer','Limit Violations','Details','Save <input type="checkbox"  name="save_cb" value="s" onclick="checkBoxSaveAll(event,this)" />','Reject <input type="checkbox" id="reject_cb"  name="reject_cb" value="r" onclick="checkBoxRejectAll(event,this)" /> ','Party1','Party2','Status'],
                   colModel: [
						{name: 'deal_no',             	index: 'deal_no',   		  jsonmap: 'deal_no',             sortable: false, align: 'Center',  width: 90, resizable: false,   unformat: unformatData , formatter:cellFomatterDealNo},
						{name: 'bl_security',         	index: 'bl_security',   	  jsonmap: 'bl_security', 	      sortable: false, align: 'left',    width: 60,  resizable: false,   unformat: unformatData},
						{name: 'security_code',        	index: 'security_code',  	  jsonmap: 'security_code', 	  sortable: false, align: 'left' ,   width: 80,  resizable: false,   unformat: unformatData},
						{name: 'price_range',        	index: 'price_range',  	      jsonmap: 'price_range', 	      sortable: false, align: 'center' ,  width: 100,  resizable: false,   unformat: unformatData},
						{name: 'face_value',        	index: 'face_value',  	      jsonmap: 'face_value', 	      sortable: false, align: 'right' ,  width: 80,  resizable: false,   unformat: unformatData},
						{name: 'transaction_type',    	index: 'transaction_type',    jsonmap: 'transaction_type', 	  sortable: false, align: 'left' ,   width: 110, resizable: false,   unformat: unformatData},
						{name: 'order_qualifieres',    	index: 'order_qualifieres',   jsonmap: 'order_qualifieres',   sortable: false, align: 'left' ,   width: 100, resizable: false,   unformat: unformatData},
						{name: 'time_in_force',      	index: 'time_in_force',       jsonmap: 'time_in_force', 	  sortable: false, align: 'left' ,   width: 100, resizable: false,   unformat: unformatData},
						//{name: 'face_value',           index: 'face_value',      	  jsonmap: 'face_value', 		  sortable: false, align: 'right',   width: 80,  resizable: true,    unformat: unformatData},
						{name: 'dn_user',               index: 'dn_user',      	      jsonmap: 'dn_user', 		      sortable: false, align: 'left',    width: 70,  resizable: true,    unformat: unformatData},
						{name: 'not_applicable',        index: 'not_applicable',   	  jsonmap: 'not_applicable',  	  sortable: false, align: 'left',    width: 100, resizable: false,   unformat: unformatData , hidden:true },
						//{name: 'ent_date',              index: 'ent_date',       	  jsonmap: 'ent_date',  		  sortable: false, align: 'right',   width: 60,  resizable: false,   unformat: unformatData },
						{name: 'details_but',           index: 'details_but',   	  jsonmap: 'details_but',         sortable: false, align: 'center',  width: 80,  resizable: false,   unformat: unformatData , formatter:cellFomatterDetailsButton},
						{name: 'Save',                  index: 'Save',                jsonmap: 'Approve', 			  sortable: false, align: 'center',  width: 70,  resizable: false,   unformat: unformatData,  formatter:checkBoxFmatterSave,hidden:true},
						{name: 'Reject',                index: 'Reject',   			  jsonmap: 'Reject', 			  sortable: false, align: 'center',  width: 70,  resizable: false,   unformat: unformatData,  formatter:checkBoxFmatterReject,hidden:true},
						{name: 'borr_portfolio_code',   index: 'borr_portfolio_code', jsonmap: 'borr_portfolio_code', sortable: false, align: 'left',    width: 60,  resizable: false,   unformat: unformatData },
						{name: 'lend_portfolio_code',   index: 'lend_portfolio_code', jsonmap: 'lend_portfolio_code', sortable: false, align: 'left',    width: 80,  resizable: false,   unformat: unformatData },
						{name: 'app_status',            index: 'app_status',          jsonmap: 'app_status',          sortable: false, align: 'Center',  width: 80,  resizable: false,   unformat: unformatData }],  
							//{name: 'eff_val_date',          index: 'eff_val_date',        jsonmap: 'eff_val_date',        sortable: false, align: 'center',  width: 110, resizable: false,  unformat: unformatData }],
						
                   mtype: 'GET',
                   rownumbers: true,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
							width: 'auto',
                   hidegrid: false,
                   toolbar: [false, 'top'],
                   caption: 'Confirm Deal Ticket',
				   jsonReader: {repeatitems: false},
                   gridComplete: function() {
						 
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_1').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_2').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_5').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_6_0').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_6').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_7').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_8').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_9').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_9_1').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_10').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_11').css('cursor', 'default');
						
						
					},
					loadComplete : function(){
                        var rec_count=$("#TABLE_CLIENT_PAYMENT_APPROVE").jqGrid('getGridParam',"records");
                        document.Form1.hid_count.value=rec_count;
					}
               });
           }
		
		
		 function cellFomatterDetailsButton(cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span><input type='button' align='center' style ='text-align: center;'  id='m_detail_but_"+row_id+"' name='m_detail_but_"+row_id+"' value='Details' class='mainbut' onclick='pop_up_message("+row_id+")' /></span>";
                     return texts;
         } 
		
		 function checkBoxFmatterSave (cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='checkbox' id='save_"+rowid+"'  name='save_"+rowid+"' value='on'  onclick ='testValue("+rowid+")';     />";  // orTest
			  //var link ="<input type='checkbox' id='save_"+rowid+"'  name='save_"+rowid+"' value='on'  onclick ='orTest()';     />"; 
			  return link;
		 }
		
		 function checkBoxFmatterReject (cellvalue, options, rowObject){
              var rowid=options['rowId'];
	          var link ="<input type='checkbox' id='reject_"+rowid+"'  name='reject_"+rowid+"' value='on'  onclick =''    />"; 
              return link;
		 }

		function cellFomatterDealNo (cellvalue, options, rowObject){
                     var row_id=options['rowId'];
                     var texts = "<span>"+cellvalue+"<input type='hidden' align='right' style ='text-align: right;'  id='DealNo_"+row_id+"' name='DealNo_"+row_id+"' value='"+cellvalue+"'  /></span>";
                     return texts;
        } 


		function unformatData(cellvalue, options, cellobject) {
               return cellvalue;
        }
		
		/*
		function checkBoxSaveAll(e,obj) {
		  e = e||event; 
		  e.stopPropagation? e.stopPropagation() : e.cancelBubble = true;

		  var no_of_rows = jQuery("#TABLE_AVAILABILITY_DETAILS").getDataIDs().length;
			
		  if(obj.checked==true){
				for(i=1; i<=no_of_rows; i++){
					document.getElementById("save_"+i).checked = true;
				}
		  }
			
		}
		*/
		
		function checkBoxSaveAll(e,obj) {
		  	e = e||event; /* get IE event ( not passed ) */
		  	e.stopPropagation? e.stopPropagation() : e.cancelBubble = true;

		  	var no_of_rows = jQuery("#TABLE_AVAILABILITY_DETAILS").getDataIDs().length;
			
		  	if(obj.checked==true){
				for(i=1; i<=no_of_rows; i++){
					document.getElementById("save_"+i).checked = true;
					m_dealnum = jQuery("#TABLE_AVAILABILITY_DETAILS").jqGrid ("getCell", i, 'deal_no'); 
					chk_serial_no(m_dealnum,i);
					chk_security_no(m_dealnum,i);
					chk_scripless(m_dealnum,i);
				}
		  	}
			else if(obj.checked==false){
				for(i=1; i<=no_of_rows; i++){
					document.getElementById("save_"+i).checked = false;
				}
			}
			
		}
		
		function checkBoxRejectAll(e,obj) {
		  	e = e||event; /* get IE event ( not passed ) */
		  	e.stopPropagation? e.stopPropagation() : e.cancelBubble = true;

		  	var no_of_rows = jQuery("#TABLE_AVAILABILITY_DETAILS").getDataIDs().length;
			
		  	if(obj.checked==true){
				for(i=1; i<=no_of_rows; i++){
					document.getElementById("reject_"+i).checked = true;	
				}
		  	}
			else if(obj.checked==false){
				for(i=1; i<=no_of_rows; i++){
					document.getElementById("reject_"+i).checked = false;
				}
			}
			
		}
		
		
		
		// ====================== End Adding grid =============================================
		
		
		function chk_serial_no(m_dealnum,lineno) {
			if((m_dealnum.substring(0,2)=="RF")){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmChk1";
				load_interface(m_url,'XML',false);
			    m_size = data_vec.length;
				
				if (m_size!==0) {	 
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmChk*";
					load_interface(m_url,'XML',false);
			        m_size = data_vec.length;
					
					if (m_size!==0) {	 				
						
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmChk";
						load_interface(m_url,'XML',false);
			            m_size = data_vec.length;
						
						if (m_size ==0) {
							alert(m_dealnum +' Allocate serial numbers prior to  the confirmation'); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:8 --->
							v_check="save_"+lineno;
							v_check_1=document.Form1.elements[v_check];
							//v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:8 --->
						}
						
					}
				}
				
			}	
			//added By Keith on 9-9-2004/9:11 for repo rollover check of serial numbers/physical deleivery
			else if((m_dealnum.substring(0,2)=="RR")){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmSerialchk1RR";
				load_interface(m_url,'XML',false);
			    m_size = data_vec.length;

				if (m_size!==0) {	 				
					
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmSerialChk2RR";
					load_interface(m_url,'XML',false);
			        m_size = data_vec.length;
					
					if (m_size!==0) {	 			 	 								 
						
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmSerialChk3RR";
						load_interface(m_url,'XML',false);
			            m_size = data_vec.length;
						
						if (m_size ==0) {
							alert('Allocate serial numbers prior to  the confirmation'); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:8 --->
							v_check="save_"+lineno;
							v_check_1=document.Form1.elements[v_check];
							//v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:8 --->
						}//end msize3
					}//end msize2
				}//end msize1
			}	//end RR
			
			
			//add by waruna 2011-02-14
			else if((m_dealnum.substring(0,2)=="OR")){
				
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?deal_no="+m_dealnum+"&chksql=deal_chk";
				load_interface(m_url,'XML',false);
			    m_size = data_vec.length;
			//	alert(m_size);
				//if (m_size !=1) { // 24-10-2011
				if (m_size == 0) {
					alert('You can not confirm deal. Settlement Date lower than EOD.'); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:8 --->
					v_check="save_"+lineno;
					v_check_1=document.Form1.elements[v_check];
					v_check_1.checked = false ; 
				}//end msize3
				
				
			}	//end RR
			
		}
		
		
		
		function chk_security_no(m_dealnum,lineno) {
			if((m_dealnum.substring(0,2)=="RF")){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=checkborrrf";//YASOADED
				load_interface(m_url,'XML',false);
			    m_size = data_vec.length;
				if (m_size!==0) {
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmChk2";
					load_interface(m_url,'XML',false);
					m_size = data_vec.length;
					if (m_size!==0) {
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmChk*";
						load_interface(m_url,'XML',false);
						m_size = data_vec.length;
						if (m_size!==0) {	 	
							m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmChk3";
							load_interface(m_url,'XML',false);
							m_size = data_vec.length;
							if (m_size==0) {
								alert(m_dealnum+' Allocate securities prior to  the confirmation'); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:10 --->
								v_check="save_"+lineno;
								v_check_1=document.Form1.elements[v_check];
								//v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:10 --->
							}	
						}
						
					}     
				}
			}
			else if((m_dealnum.substring(0,2)=="OR")){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealno="+m_dealnum+"&chksql=chk_ordeal_curr";	          
				load_interface(m_url,'XML',false);
			    m_size = data_vec.length;
				if(m_size>0){
					alert(m_dealnum+" Please allocate Serial numbers prior to the Confirmation1"); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:10 --->
					v_check="save_"+lineno;
					v_check_1=document.Form1.elements[v_check];  
					v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:10 --->
				}
			}
			else if((m_dealnum.substring(0,2)=="RR")){ //added By Keith on 9-9-2004/9:28 
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=checkborrrr";//YASOADDED
				load_interface(m_url,'XML',false);
			    m_size = data_vec.length;
				if (m_size!==0) {
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmSecurityChk1RR";
					load_interface(m_url,'XML',false);
			        m_size = data_vec.length;
					if (m_size!==0) {
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmSecurityChk2RR";
						load_interface(m_url,'XML',false);
			            m_size = data_vec.length;
						if (m_size!==0) {	 	
							m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=confirmSecurityChk3RR";
							load_interface(m_url,'XML',false);
			    			m_size = data_vec.length;
							if (m_size==0) {
								alert(m_dealnum+' Allocate securities prior to  the confirmation'); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:10 --->
								v_check="save_"+lineno;
								v_check_1=document.Form1.elements[v_check];
								//v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:10 --->
							}	
						}     
					}
				}	
			}//END RR
			
		}
		
		
		
		function chk_scripless(m_dealnum,lineno){//$$##SC
			if(m_dealnum.substring(0,2)=="OR"){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chksc"; 
				load_interface(m_url,'XML',false);
			    m_size = data_vec.length;
				if(m_size>0){
					if((data_vec[0]=="SL")&&(data_vec[1]=="P")){//&&(top.frames[0].document.applets[0].outvec_value.elementAt(2)=="S")
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chksec_tab";
						load_interface(m_url,'XML',false);
						m_size = data_vec.length;
						if(data_vec[0]==0){
							alert(m_dealnum +" Allocate serial numbers prior to the confirmation2"); <!---**commented by inditha FOR VC05-002  on 12-7-2005/11:8 --->
							v_check="save_"+lineno;
							v_check_1=document.Form1.elements[v_check];
							v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:8 --->
						}
					}
				}
			}//OR
			if(m_dealnum.substring(0,2)=="RF"){//$$##SC
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chksc_rf"; 
				load_interface(m_url,'XML',false);
			    m_size = data_vec.length;
				if(m_size>0){
					if((data_vec[0]=="SL")&&(data_vec[1]=="P")){
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chksec_tab_rf";
						load_interface(m_url,'XML',false);
						m_size = data_vec.length;
						if(data_vec[0]==0){
							alert(m_dealnum+ " Allocate serial numbers prior to  the confirmation"); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:9 --->
							v_check="save_"+lineno;
							v_check_1=document.Form1.elements[v_check];
							//v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:9 --->
						}
					}
					else if ((data_vec[0]=="SL")&&(data_vec[1]=="C")){
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chksecurity_tab_rf";
						load_interface(m_url,'XML',false);
						m_size = data_vec.length;
						if(data_vec[0]==0){
							alert(m_dealnum+" Allocate securities prior to  the confirmation");  <!---commented by inditha FOR VC05-002  on 12-7-2005/11:9 --->
							v_check="save_"+lineno;
							v_check_1=document.Form1.elements[v_check];
							//v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:9 --->
						}
						
					}
				}
			}//RF
			//added By Keith on 8-9-2004/11:49 -------------------------------------------------------------------------------------------------
			if(m_dealnum.substring(0,2)=="RR"){
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chkSC_RR"; 
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
				if(m_size>0){
					if((data_vec[0]=="SL")&&(data_vec[1]=="P")){
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chkSERIAL_RR";
						load_interface(m_url,'XML',false);
						m_size = data_vec.length;
						if(data_vec[0]==0){
							alert(m_dealnum+" Allocate serial numbers prior to  the confirmation"); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:9 --->
							v_check="save_"+lineno;
							v_check_1=document.Form1.elements[v_check];
							//v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:9 --->
						}
					}
					else if ((data_vec[0]=="SL")&&(data_vec[1]=="C")){
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?dealrefno="+m_dealnum+"&chksql=chkSECURITY_RR";
						load_interface(m_url,'XML',false);
						m_size = data_vec.length;
						if(data_vec[0]==0){
							alert(m_dealnum+" Allocate securities prior to  the confirmation"); <!---commented by inditha FOR VC05-002  on 12-7-2005/11:9 --->
							v_check="save_"+lineno;
							v_check_1=document.Form1.elements[v_check];
							//v_check_1.checked = false ; <!---commented by inditha FOR VC05-002  on 12-7-2005/11:9 --->
						}
					}
				}
			}//RR
			//------------------end addition----------------------------------------------------------------------------------------------------------
			
		}
		
		
		// ================== starting saving functions ================================
		
		function chk_confirmed_deal() {
			
			var no_of_rows = jQuery("#TABLE_AVAILABILITY_DETAILS").getDataIDs().length;
			document.Form1.Hid_rows.value = no_of_rows;
			
			//for(var r=1;document.Form1.Hid_rows.value>r;r++){
			for(var r=1;r<=document.Form1.Hid_rows.value;r++){
				if(eval("document.Form1.save_"+r+".checked")) {
					var obj_dealnum = jQuery("#TABLE_AVAILABILITY_DETAILS").jqGrid ("getCell", r, 'deal_no'); 
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?deal_num="+obj_dealnum+"&chksql=checked_confirmdeals";
					//top.frames[0].document.applets[0].getdata(m_url);
					load_interface(m_url,'XML',false);
					m_size = data_vec.length;
					if(data_vec[0]=="CONF"){
						
						title="DealNet Generate Confirmation Error Message";
						mess="This deal "+obj_dealnum+" has been already confirmed";
						
						icon=1;
						mods=0;
						makeMsgBox(title,mess,icon,0,0,mods)
						
						return false;
						break;
					}
					else {
						return true;
					}
				}
			}	
		}
		
		
		function beforesubmit() {
			r=1;
			
			//checkbuyersettlementdate2();//--- Added by Shanheetha on 12-07-2006 for VC06-012.
			
			if(chk_confirmed_deal()){
				//alert('save ready');
				var no_of_rows = jQuery("#TABLE_AVAILABILITY_DETAILS").getDataIDs().length;
			    document.Form1.Hid_rows.value = no_of_rows;
				
				unable_checkbox();
				document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_pre_auth_deal"; 
				document.Form1.submit();
			}
			else{
				alert('Please select the records to save');
			}
		}


		// ================== end saving functions =====================================
		
		// ================== starting reject functions ================================
		
		function beforesubmit_reject() {

			r=1;
			document.Form1.Hid_scr_name.value="reject_dealticket";
			if(chk_rejected_deal()){
				unable_checkbox();
				//alert('reject ready');
				document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"bsave_pre_auth_deal"; 
				document.Form1.submit();
			}
		}
		
		function unable_checkbox(){
			
			var no_of_rows = jQuery("#TABLE_AVAILABILITY_DETAILS").getDataIDs().length;
			document.Form1.Hid_rows.value = no_of_rows;
			
			//for(var t=1;document.Form1.Hid_rows.value>t;t++) {
			for(var t=1;t<=document.Form1.Hid_rows.value;t++) {
				m_chk_box="document.Form1.save_"+t;
				m_chk_box.disabled=false;
			}		
		}
		
		
		
		function chk_rejected_deal() {
			
			var no_of_rows = jQuery("#TABLE_AVAILABILITY_DETAILS").getDataIDs().length;
			document.Form1.Hid_rows.value = no_of_rows;
			
			//for(var r=1;document.Form1.Hid_rows.value>r;r++){
			for(var r=1;r<=document.Form1.Hid_rows.value;r++){
				if(eval("document.Form1.reject_"+r+".checked")) {
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvalrepofresh?deal_num="+obj_dealnum+"&chksql=checked_confirmdeals";
					//top.frames[0].document.applets[0].getdata(m_url);
					load_interface(m_url,'XML',false);
					m_size = data_vec.length;
					
					var obj_dealnum = jQuery("#TABLE_AVAILABILITY_DETAILS").jqGrid ("getCell", r, 'deal_no'); 
					
					if(data_vec[0]=="CANCEL"){
						title="DealNet Generate Confirmation Error Message";
						mess="This deal "+obj_dealnum+" has been already rejected";
						
						icon=1;
						mods=0;
						makeMsgBox(title,mess,icon,0,0,mods)
						
						return false;
						break;
					}
					else {
						return true;
					}
				}
			}	
		}
		
		
		function testValue(rowid){
			var dealnum = jQuery("#TABLE_AVAILABILITY_DETAILS").jqGrid ("getCell", rowid, 'deal_no'); 
			chk_serial_no(dealnum,rowid);
			chk_security_no(dealnum,rowid);
			chk_scripless(dealnum,rowid);
		}
		
		function iFrameWidthHeight(){
			m_url = 'pre_auth_dealTiket.jsp';
			
			if ($("#DIV_MSG_DEAL_TICKET").dialog("isOpen")) 
				{
            		$("#DIV_MSG_DEAL_TICKET").dialog("close");
            	}
            	$("#DIV_MSG_DEAL_TICKET").dialog("option", "title", "Deal Ticket");
            	$("#DIV_MSG_DEAL_TICKET").dialog("open");
            	$("#IFRAME_MSG_DEAL_TICKET").attr("src",m_url);
            	return false;
		}

		
		
		// ================== end reject functions =====================================
		
	
		
	</SCRIPT>
	
	<SCRIPT LANGUAGE=VBScript TYPE="text/vbscript">
		Function makeMsgBox(title,mess,icon,buts,defbut,mods)
			butVal = buts + (icon*16) + (defbut*256) + (mods*4096)
			makeMsgBox = MsgBox(mess,butVal,title)  
			
		End Function
		
	</SCRIPT>
	
	
	<!-- <BODY  class='body & txt-body' onload= "add_data()" > -->
		<BODY  class='body & txt-body' onload= "fn_view();testOnLoad();" >
		
		<FORM action="RequestObjectInJSP.jsp" NAME="Form1" ID="Form1" METHOD="POST" >
			
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="confirm_dealticket">
			<INPUT TYPE="Hidden" NAME="Hid_rows" >
			<INPUT TYPE="Hidden" NAME="Hid_dealValue" >
			<INPUT TYPE="Hidden" NAME="hid_chk_status" >
			<input type = "hidden" id = "hid_count" name = "hid_count" />
			
			<DIV>
				<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
					<tr>
						<td height='7'></td>
					</tr>
					
					<tr height='30' >
						<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
						<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Margin Trading - Pre Authorization</B></td>
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
						<TR>
							<!--
							<TD WIDTH="5%">
								<INPUT TYPE="Button" NAME="but_brokerage"   VALUE="Brokerage"  onClick=""  class="mainbut"  >
							</TD>
							
							
							<TD WIDTH="10%"> &nbsp;
							</TD>
							-->
							
							<TD WIDTH="5%">
								<!--<INPUT TYPE="Button" NAME="but_save"   VALUE="Save"  onClick="beforesubmit();"  class="mainbut"  >-->
							</TD>
							
							<TD WIDTH="5%">
								<!--<INPUT TYPE="Button" NAME="but_reject"   VALUE="Reject"  onClick="beforesubmit_reject();"   class="mainbut"  >-->
							</TD>

							<TD WIDTH="5%">
								<INPUT TYPE="Button" NAME="but_cancel"   VALUE="Cancel"  onClick="refresh();"  class="mainbut"  > <!--  iFrameWidthHeight() refresh -->
							</TD>
							
							<TD WIDTH="5%">
								<INPUT TYPE="Button" NAME="but_exit"   VALUE="Exit"  onClick="screen_close();"  class="mainbut"  >
							</TD>
							
							<TD WIDTH="5%">
								<INPUT TYPE="Button" NAME="but_dealticket"   VALUE="Deal Ticket"  onClick="iFrameWidthHeight();" STYLE="{ width: 80px; }"  class="mainbut"  >
							</TD>
							
							<TD WIDTH="*%"> &nbsp;
							</TD>
							
							<TD WIDTH="30%" align='right'><B> Outstanding Deal </B>
							</TD>
							
						</TR>
					</TABLE>
					
					<!----------->
					
					<TABLE WIDTH="100%">
						<tr height='25px;'></tr>
					</TABLE>
					<HR>
					<TABLE WIDTH="100%">
						<tr height='25px;'></tr>
					</TABLE>
					
					<BR>	
					<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0">
						<TR>
							<TD WIDTH="1%"></TD>
							<TD WIDTH="*%"> <!-- -->
								
										<table align='center' width='100%' class='table'>
										<tr> 
										<td width="100%"  height="70%"><div id="data_div"></div></td>
										</tr> 
										</table>
								
								
										
								
										<DIV ALIGN="CENTER" id=insdata ></DIV>
								
								
							</TD> <!-- -->
								</tr>
							</table>
						</TD>
					</tr>
					
				</table>
		
		
		   <div id ="DIV_MSG_WINDOW" title ="Generate Confirmation">
	       <iframe id ="IFRAME_MSG_WINDOW" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Day End Routine">
	       </iframe>
	       </div>
		
		  <div id ="DIV_MSG_DEAL_TICKET" title ="Deal Ticket">
	       <iframe id ="IFRAME_MSG_DEAL_TICKET" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Deal Ticket">
	       </iframe>
	       </div>
		
		   <div id = "DIV_AVAILABILITY_DETAILS">
                     <table id = "TABLE_AVAILABILITY_DETAILS"></table>
                      <div id = "DIV_PAGER_AVAILABILITY_DETAILS"></div>

           </div>
		
		
			</FORM>
			<!-- <SCRIPT language1.2="JavaScript" src="validate.js"></SCRIPT> -->
			<SCRIPT language1.2="JavaScript" src="market_rate_sec.js"></SCRIPT>
			<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>
			<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
			
		</body>
	</html>
	
