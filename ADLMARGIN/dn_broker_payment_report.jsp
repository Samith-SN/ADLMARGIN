<html>
    <head>
	<title>Margin Trading</title>	
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

		//--------
			out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
			out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/redmond/jquery-ui.css' TYPE=\"text/css\">");
			out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/blue/style.css' TYPE=\"text/css\">");
			
			//out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/SNET/jquery/grid/themes/blue/jquery-ui-1.7.1.custom.css' TYPE=\"text/css\">");
			out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/SNET/jquery/grid/4.1/themes/ui.jqgrid.css' TYPE=\"text/css\">");
			
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
			
			
			//out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.tablesorter.js\"></script>");	
			
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/i18n/grid.locale-en.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/jquery.jqGrid.min.js\"></script>");
			
	    %> 
		<SCRIPT language="JavaScript"> 	     
		var m_sql = "";
		var m_criteria="";
		var m_curr_help="";
		var m_valid=true;
		
		function myDialogObj() {
			var htmlstr; 
			var returnval;
	 	}


		function chkstartdate(dayobj,monthobj,yearobj) {
	     checkMonthLength(dayobj,monthobj,yearobj);		
	  }
		
		//
			
		function displaydata(){  
			sclient  = new String(document.Form1.TXT_CLIENT.value);	
			if ((sclient.length == 0)||(sclient == " ")){
			sclient="ALL";
			}
			
		/*
		if (document.Form1.TXT_CLIENT.value == ''){
					alert("Please Enter the Portfolio Code");
				}
			else{*/
				if(((document.Form1.TXT_DATE_FROM.value)&&(document.Form1.TXT_MONTH_FROM.value)&&(document.Form1.TXT_YEAR_FROM.value)&&(document.Form1.TXT_DATE_TO.value)&&(document.Form1.TXT_MONTH_TO.value)&&(document.Form1.TXT_YEAR_TO.value))!=""){	
				
				//loadGridBrokerPayment();	
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_reports_collection?mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&client="+sclient.toUpperCase()+"&chksql=mrep_data";
	    		    popupwin2 = window.open(m_url,'displayWindow2','left=133,top=133,width=700,height=380,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
		 			popupwin2.focus();
					}
					 else{
						alert("Please Enter the Date Range !...");
					}
			//}			
		}	
			
			
			
			
			
			
			
			
	/*
	function Client_help(){
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_reports_TransactionLst?chksql=portfolio_help&portfolio_code="+document.Form1.TXT_CLIENT.value;
			//boffice_reports_clc_1?client_data="+document.Form1.TXT_CLIENT.value+"&chksql=clc_data";
			top.frames[0].document.applets[0].getdata(m_url);
			m_size=top.frames[0].document.applets[0].outvec_value.size();
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
	*/
	
	function MyDialog(){
	 	 this.valout   = new Array(10);
	 		}		
		
		 function Client_help(m_strat){
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	
		var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.TXT_CLIENT;
 		myObject[1]=aForm.null;
 		myObject[2]=aForm.null;
				
 		var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.TXT_CLIENT.value;
 		

 		var myObject_type=new Array(); //passing values data type
		myObject_type[0]="StringL";	
 		
 	
 	
 		var qid='71';

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
	 
				
       
		
		function HelpBox(Start,End,Hid_No) {
		oBj = new MyDialog();
	  	oBj.valout[1]  = " ";
		oBj.valout[2]  = " ";
		oBj.valout[3]  = " ";
		popupwin = window.showModalDialog(""+servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_fund_Help_Servlet?class_in="+client_name+"mbfsl_fund_help_select"+
									"&Sql_in="+m_sql+"&Start_in="+Start+
									"&End_in="+End+"&Crit_In="+m_criteria+
									"&Hid_No="+Hid_No+"", oBj,"dialogWidth:25em; dialogHeight:18em; center:yes;  status:no");
									
	
	
if(document.Form1.hid_help_type.value=="1"){
		  if(oBj.valout[1] !=" "){
		     if(oBj.valout[1] !='Close'){
			     if(oBj.valout[1]!="Prev"){
				      if(oBj.valout[1]!="Next"){
				      // alert("uu");
								asign_port_code();
		          }
		          else{//alert("HI");
							     //alert("hi"+oBj.valout[2]+"hi"+oBj.valout[3]);
		            Next(oBj.valout[2],oBj.valout[3],Hid_No);
		 	          return false;
		          } 
	         }
	         else{
		         Prev(oBj.valout[2],oBj.valout[3],Hid_No);
	         }	
         }		
         else{	
	         document.Form1.TXT_CLIENT.value="";	
         }		
    }
    else{		
	    document.Form1.TXT_CLIENT.value="";	
    }		
 }

	}
	
function Prev(Start,End,Hid_No){
	 HelpBox(Start,End,Hid_No)
}
function Next (Start,End,Hid_No){
	 HelpBox(Start,End,Hid_No)
}
	
	function asign_port_code() {	
	 document.Form1.TXT_CLIENT.value=oBj.valout[2];
	}
			

	/* function loadGridBrokerPayment() {
			
              
			    jQuery('#TABLE_BROKER_PAYMENT').GridUnload();
              m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_reports_collection?mdate_from="+document.Form1.TXT_DATE_FROM.value+'-'+document.Form1.TXT_MONTH_FROM.value+'-'+document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+document.Form1.TXT_DATE_TO.value+'-'+document.Form1.TXT_MONTH_TO.value+'-'+document.Form1.TXT_YEAR_TO.value+"&client="+sclient.toUpperCase()+"&chksql=mrep_data";
				
			jQuery('#TABLE_BROKER_PAYMENT').jqGrid({
                   url: m_url,
							
                 //  loadonce: 1,
                   datatype: 'json',
                   colNames: ['MT No.','Client Name','Broker name','Settl. Amount','Receipt Mode' ,'Cheque No/Transfer No','Branch Code','Value Date', ],
                   colModel: [
						{name: 'SELL_PORTFOLIO_CODE',             				index: 'SELL_PORTFOLIO_CODE',   						jsonmap: 'SELL_PORTFOLIO_CODE',         			sortable: false, align: 'center', width: 90, resizable: 	false,    	unformat: unformatData},
						{name: 'LBMARGIN.RETURN_PF_NAME(SELL_PORTFOLIO_CODE)',  index: 'LBMARGIN.RETURN_PF_NAME(SELL_PORTFOLIO_CODE)',  jsonmap: 'LBMARGIN.RETURN_PF_NAME(SELL_PORTFOLIO_CODE)', 	    	sortable: false, align: 'center', width: 90, resizable: 	false,   	unformat: unformatData},//formatter: cellFomatterPaymentsColumn_1,
						{name: 'XX',        									index: 'XX',  											jsonmap: 'XX', 			sortable: false, align: 'center' , width: 90, resizable: 	false,  	unformat: unformatData},
						{name: 'Settl._Amount',         index: 'Settl._Amount',      	jsonmap: 'Settl._Amount', 			sortable: false, align: 'right', width: 80, resizable: 		true,   	unformat: unformatData},//formatter: cellFomatterPaymentsColumn_2,
						{name: 'Receipt_Mode',          index: 'Receipt_Mode',      	jsonmap: 'Receipt_Mode', 			sortable: false, align: 'center',  width: 70, resizable: 	false,   	unformat: unformatData},//formatter: cellFomatterPaymentsColumn_5,
						{name: 'Cheque No/Transfer_No', index: 'Cheque No/Transfer_No', jsonmap: 'Cheque No/Transfer_No',	sortable: false, align: 'right',  width: 100, resizable: 	false,  	unformat: unformatData },//formatter: cellFomatterPaymentsColumn_6_0,
						{name: 'Branch_Code',           index: 'Branch_Code',    		jsonmap: 'Branch_Code',  			sortable: false, align: 'right',  width: 60, resizable: 	false,   	unformat: unformatData },//formatter: cellFomatterPaymentsColumn_6,
						{name: 'Value_Date',            index: 'Value_Date',   			jsonmap: 'Value_Date',    			sortable: false, align: 'right',  width: 60, resizable: 	false,   	unformat: unformatData },//formatter: cellFomatterPaymentsColumn_6,
						
					],
							
                   mtype: 'GET',
                   rownumbers: true,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
                   toolbar: [false, 'top'],
                   caption: 'broker payment',
				   jsonReader: {repeatitems: false},
                   gridComplete: function() {
					
					alert(  $('#jqgh_ACTUAL_PAYMENTS_COLUMN_1'));	 
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_1').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_2').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_3').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_4').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_5').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_6').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_7').css('cursor', 'default');
                           $('#jqgh_ACTUAL_PAYMENTS_COLUMN_8').css('cursor', 'default');
                          
                          
                        
                        
                         //  $('#DIV_NET_AVAILABILITY').text(format_noobject0($('#HID_FINAL_AVAILABILITY').val(), 2, null, 'BRACKETS'));
                           //init_fancybox();
                           //initCal('TXT_VALUE_DATE_' + '1');
                          // if ((document.Form1.hid_payments_count_new.value == '0') && (m_onload_add_payment_flag == false)) {
                              // addPaymentItem();
                              // m_onload_add_payment_flag = true;
						//	}
                           //get_exchange_rate();
						
						
					},
					loadComplete : function(){
						
                        var rec_count=$("#TABLE_BROKER_PAYMENT").jqGrid('getGridParam',"records");
                        document.Form1.hid_count.value=rec_count;
					}
               });
}*/
	
			 function unformatData(cellvalue, options, cellobject) {
               return cellvalue;
           }
			//--------------------------------------------------------------	
			
			$(document).ready
			(
				
				function() 
				{
					//initDialog();
					initCal('TXT_START_DATE');
                    initCal('TXT_END_DATE');
					initDialogPOPup();
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
                   document.Form1.TXT_DATE_TO.value = splitResult[0];
                   document.Form1.TXT_MONTH_TO.value = splitResult[1];
                   document.Form1.TXT_YEAR_TO.value = splitResult[2];
                   document.Form1.TXT_YEAR_TO.focus();
               }
              
           }
			
			function show_drill(url) 
			{
				//window.open(url);
				if ($("#DIV_DAILY_MARG_ACTIVITY").dialog("isOpen")) 
				{
					$("#DIV_DAILY_MARG_ACTIVITY").dialog("close");
				}
				
				$("#DIV_DAILY_MARG_ACTIVITY").empty();
				$("#DIV_DAILY_MARG_ACTIVITY").html('<iframe id ="DIV_DAILY_MARG_IFRAME_ACTIVITY" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Daily Margin Trading Activity">');
				
				
				$("#DIV_DAILY_MARG_ACTIVITY").dialog("option", "title", "Detail ");
				$("#DIV_DAILY_MARG_IFRAME_ACTIVITY").attr("src",url);
				$("#DIV_DAILY_MARG_ACTIVITY").dialog("open");
				return false;
			}
			//--------------------------------------------------------------	
			
			function initDialogPOPup()
			{
				
				$("#DIV_DAILY_MARG_ACTIVITY").dialog(
					
					{
						
						bgiframe: true,
						autoOpen: false,
						//modal: false,
						modal: true, //to disable the back ground	
						height: 500,
						width: getW,
						close: function() 
						{
							
						}
					}
				);
			}
			
			function getW() 
			{
				var w = 0;
				if (window.document.innerWidth > w) 
				{
					w = window.document.innerWidth;
				}
				if (window.document.documentElement.clientWidth > w) 
				{
					w = window.document.documentElement.clientWidth;
				}
				return (w - 100);
			}
			//----------------------------------------------------
			function close_iframe(iframe_id)
			{
				$(iframe_id).dialog("close"); 
				
			}
			
			function cancelling(){
			document.Form1.TXT_CLIENT.value="";
			document.Form1.TXT_DATE_FROM.value="";
			document.Form1.TXT_MONTH_FROM.value="";
			document.Form1.TXT_YEAR_FROM.value="";
			document.Form1.TXT_DATE_TO.value="";
			document.Form1.TXT_MONTH_TO.value="";
			document.Form1.TXT_YEAR_TO.value="";
			}
			
			function display_dat(){ //thamali
		  m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalsettlement?chksql=get_dat";
		  load_interface(m_url,'XML',false);
			
			m_size= data_vec.length;
			if(m_size>0){	
		        document.Form1.TXT_DATE_FROM.value=data_vec[0].substring(0,2);
		        document.Form1.TXT_MONTH_FROM.value=data_vec[0].substring(3,5);
		        document.Form1.TXT_YEAR_FROM.value=data_vec[0].substring(6,10);
				document.Form1.TXT_DATE_TO.value=data_vec[0].substring(0,2);
		        document.Form1.TXT_MONTH_TO.value=data_vec[0].substring(3,5);
		        document.Form1.TXT_YEAR_TO.value=data_vec[0].substring(6,10);
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
	<BODY onload="display_dat()">
		<FORM NAME="Form1"ID="Form1" METHOD="POST" >
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="reveryfication">
			<INPUT TYPE="Hidden" NAME="hid_help_type" ALIGN="RIGHT" SIZE=2 >
			<!--------------------------------->
			 <div>
                <table class="table" align="center" border="0" cellpadding="0" cellspacing="0" width="99%">
                    <tr>
                        <td height="7"></td>
                    </tr>
                    
                    <tr height="30">
                        <td width="13px" style="background-image: url('<%= m_jsp_client_url %>/images/l1.gif'); background-repeat: no repeat;" id="hi1"></td>
                        <td style="background-image: url('<%= m_jsp_client_url %>/images/l3.gif'); background-repeat: repeat;" id="hi2" align="left"><b>Margin Trading - Settlement Management</b></td>
                        <td width="13px" style="background-image: url('<%= m_jsp_client_url %>/images/l2.gif'); background-repeat: no repeat;"  id="hi3"></td>
                    </tr>
                </table>
					
					
            </div>	
				
			<div>		
				
				<table class="table" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td height="1"></td>
                </tr>
            </table>
					
			</div>	
				
            <div>
            <table width="100%" bgcolor="darkblue">
                <tr>
                    
                    <!--<td width="6%">
                        <INPUT TYPE="Hidden"  class="mainbut" type="button" name="save_but" value="Save" onclick="fnSave();" />
                    </td>-->
                    <td width="6%">
                        <input class="mainbut" type="button" name="calcel_but" value="Cancel" onclick="cancelling()" />
                    </td>
                    <td width="6%">
                        <input class="mainbut" type="button" name="Exit_but" value="Exit" onclick="top.frames[1].location.href='low.jsp'" />
                    </td>
                    <td width="6%">
                       <!-- <input class="mainbut" type="button" name="report_but" value="Enquiry" onclick="obtain_report_before();" />-->
                    </td>
					<TD WIDTH="*%"> &nbsp; </TD>

                    <td width="50%" class="hh1" align="right"><b>Broker Payment Report</b></td>
                </tr>
            </table>
			</div>
			<DIV>	
            <table width="100%">
                <tr height="25px;"></tr>
            </table>
            <hr />
				
            <table width="100%">
                <tr height="25px;"></tr>
            </table>
             <br /> 
		    </DIV>
			<!--------------------------------->	
				
			<table width="70%" border="0" cellpadding="1" cellspacing="0" >					
		    <TR>
							
							
				<TD  WIDTH="1%" ></TD>
				<TD  WIDTH="15%" >Broker Code</TD>

				<TD ><INPUT TYPE="Text" class="txt_input6"  NAME="TXT_CLIENT" ID="TXT_CLIENT" SIZE=10  >
			        <INPUT TYPE="BUTTON" NAME="but_CLIENT" value="..."  class = "but_input" ONCLICK="Client_help(0)"> 								
			        </TD> 		
							
      				<TR>
				<TD  WIDTH="1%" ></TD>
						<TD WIDTH="15%" >From Date</TD>  
						
							<TD><INPUT TYPE="Text" NAME="TXT_DATE_FROM"  ID="TXT_DATE_FROM"   SIZE="3"  class="txt_input5" MAXLENGTH="2"> 
								<INPUT 	   TYPE="Text" NAME="TXT_MONTH_FROM" ID="TXT_MONTH_FROM"  SIZE="3" class="txt_input5" MAXLENGTH="2">
								<INPUT 	   TYPE="Text" NAME="TXT_YEAR_FROM"  ID="TXT_YEAR_FROM"   SIZE="5"  class="txt_input5" MAXLENGTH="4" ONBLUR="chkstartdate(document.Form1.TXT_DATE_FROM,document.Form1.TXT_MONTH_FROM,document.Form1.TXT_YEAR_FROM)">
								<input type = "hidden" name = "TXT_START_DATE" id = "TXT_START_DATE" />
			        </TD> 
							
						<TD WIDTH="15%" >To Date</TD>  
							<TD><INPUT TYPE="Text" NAME="TXT_DATE_TO"  ID="TXT_DATE_TO"   SIZE ="3"  class="txt_input5" MAXLENGTH="2">
								<INPUT 	   TYPE="Text" NAME="TXT_MONTH_TO" ID="TXT_MONTH_TO"  SIZE ="3"  class="txt_input5" MAXLENGTH="2">
								<INPUT 	   TYPE="Text" NAME="TXT_YEAR_TO"  ID="TXT_YEAR_TO"   SIZE ="5"  class="txt_input5" MAXLENGTH="4" ONBLUR="chkstartdate(document.Form1.TXT_DATE_TO,document.Form1.TXT_MONTH_TO,document.Form1.TXT_YEAR_TO);ChkValidity(document.Form1.TXT_DATE_TO,document.Form1.TXT_MONTH_TO,document.Form1.TXT_YEAR_TO,document.Form1.TXT_DATE_FROM,document.Form1.TXT_MONTH_FROM,document.Form1.TXT_YEAR_FROM);">
								<input type = "hidden" name = "TXT_END_DATE" id = "TXT_END_DATE" />
			    
							
								
								
							
					    <!--TD WIDTH="6%"><INPUT TYPE="button" VALUE=" GO " NAME="BUT_BCODE" ONCLICK="displaydata()" STYLE="{cursor:hand; color: green; font: bold 8pt arial;}"></TD-->
						<!--	<TD  align="absmiddle"><img STYLE="{cursor:hand;}" src='go.gif' ONCLICK="displaydata()"></TD>-->
						
                             <input class = "but_input" type = "button" name = "BUT_SEARCH" id = "BUT_SEARCH" value = "GO"  onclick="displaydata();"/>
                        </td>		
								
								
							</TR> 
							</TABLE>
					
						<TABLE width="100%" BORDER="0" CELLPADDING="2" CELLSPACING="1" STYLE="{color: black; font: 10pt sans-serif;}">
						</TABLE>
						<INPUT TYPE="Hidden" NAME="Hid_rows" >
						<DIV id=clientmgr></DIV>
						
					</TD>
				</TD>
			</TABLE> 
		
			<div id = "BROKER_PAYMENT">
                     <table id = "TABLE_BROKER_PAYMENT"></table>
                      <div id = "DIV_PAGER_TABLE_BROKER_PAYMENT"></div>

       </div>				
		
		</FORM>
	
	
				<!--	<DIV ID ="TABLE_BROKER_PAYMENT" TITLE ="BROKER_PAYMENT">
						<IFRAME ID ="DIV_TABLE_BROKER_PAYMENT" WIDTH = "100%" HEIGHT = "100%" MARGINWIDTH = "0" MARGINHEIGHT = "0" FRAMEBORDER = "0" SCROLLING = "AUTO" TITLE = "DAILY MARGIN TRADING ACTIVITY">
						</IFRAME>
					</DIV> -->
					
	</BODY>
	<DIV>
		<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>
	<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>	
	</DIV>
	</html>
		
