<%@page import="net.sasianet.ADLMARGIN.*" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Calendar" %>
<%@page import="java.util.Date" %>
<HTML>
	<HEAD>
		<TITLE>Margin Traging</TITLE>
		
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
			
			//out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/SNET/jquery/grid/themes/blue/jquery-ui-1.7.1.custom.css' TYPE=\"text/css\">");
			out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/SNET/jquery/grid/4.1/themes/ui.jqgrid.css' TYPE=\"text/css\">");
			
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.min.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery-ui.min.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/json2.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
			
			
			//out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/jquery.tablesorter.js\"></script>");	
			
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/i18n/grid.locale-en.js\"></script>");
			out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/jquery.jqGrid.min.js\"></script>");
			
			
			


			
			
			
			Calendar calendar = Calendar.getInstance();
			
			String system_day   = Integer.toString(calendar.get(Calendar.DATE));
			String system_month = Integer.toString(calendar.get(Calendar.MONTH) + 1);
			String system_year  = Integer.toString(calendar.get(Calendar.YEAR));
			
			if (calendar.get(Calendar.DATE) < 10) {
				system_day = "0" + calendar.get(Calendar.DATE);
			}
			if (calendar.get(Calendar.MONTH) + 1 < 10) {
				system_month = "0" + (calendar.get(Calendar.MONTH) + 1);
			}
		%>	
		
		<SCRIPT language="JavaScript">
			var very;		
			m_count=100;
			function display_more(m_portcode,m_acc_typecode,m_option) {	
				m_start=1;
				m_end=100;
				mm_portcode=m_portcode;
				mm_acc_typecode=m_acc_typecode;
				mm_fromdate="";
				mm_todate="";
				mm_option=m_option;
				m1_url= servlet_client_url+':'+client_t3_port+'/'+client_name+'accval_tb?chksql=moredata&mm_start='+m_start+'&mm_end='+m_end+'&portcode='+m_portcode+'&acctypecode='+m_acc_typecode+'&option='+m_option+'';
				popupwin2 = window.open(m1_url,'displayWindow2','left=0,top=0,width=680,height=250,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
				popupwin2.focus();		
			}
			
			
			
			function display_more_date(m_portcode,m_acc_typecode,m_fromdate,m_todate,m_option) {			
				m_start=1;
				m_end=100;
				mm_portcode=m_portcode;
				mm_acc_typecode=m_acc_typecode;
				mm_fromdate=m_fromdate;
				mm_todate=m_todate;
				mm_option=m_option;
				
				//----------------------------------	
				
				var m1_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'accval_tb?chksql=moredata&mm_start='+m_start+'&mm_end='+m_end+'&portcode='+m_portcode+'&acctypecode='+m_acc_typecode+'&selec_fromdate='+m_fromdate+'&selec_todate='+m_todate+'&option='+m_option+'';
				//popupwin2 = window.open(m1_url,'displayWindow2','left=0,top=0,width=680,height=250,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
				//popupwin2.focus();		
				//	alert(m1_url);
				show_drill(m1_url);//2011-09-21
				//--------------------------------	
				//--------------------------------
				//if(m_size==0){
				//ml_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'accval_tb?chksql=moredata&mm_start='+m_start+'&mm_end='+m_end+'&portcode='+m_portcode+'&acctypecode='+m_acc_typecode+'&selec_fromdate='+m_fromdate+'&selec_todate='+m_todate+'&option='+m_option+'';	
				//show_drill(ml_url);//2011-09-21
				//	}
				//else{
				//		alert("Date should be lessthan day end routine date+1");
				//	}	
				//-----------------------------	
				
			}
			
			function myDialogObj() {
				var htmlstr;
				var returnval;
			}				
			
			
			function displaydata(port,from_date,from_month,from_year,to_date,to_month,to_year){									
				if(to_year=="" && from_year=="" && port!=="" ){				 					
					m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+"accvalwizard?chksql=data1&port_code="+port.toUpperCase();
					popupwin = window.open(m_url,'displayWindow1','left=0,top=130,width=790,height=390,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');					
				//	popupwin.focus();		
				}
				//-----------------------
				else if(to_year!=="" && port=="" && from_year!=="" ){											
					m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+"accvalwizard?chksql=data2&val_fromdate="+from_date+"&val_frommonth="+from_month+"&val_fromyear="+from_year+"&val_todate="+to_date+"&val_tomonth="+to_month+"&val_toyear="+to_year;
					popupwin = window.open(m_url,'displayWindow1','left=0,top=130,width=790,height=390,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');					
				//	popupwin.focus();		
				}
				//--------------------------
				else if(to_year!=="" && port!=="" && from_year!=="" ){										
					m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+"accvalwizard?chksql=data3&port_code="+port.toUpperCase()+"&val_fromdate="+from_date+"&val_frommonth="+from_month+"&val_fromyear="+from_year+"&val_todate="+to_date+"&val_tomonth="+to_month+"&val_toyear="+to_year;
					popupwin = window.open(m_url,'displayWindow1','left=0,top=130,width=790,height=390,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');					
				//	popupwin.focus();		
				}
				//-------------------------
				else if(port=="" && to_year=="" && from_year =="" ){	
					m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+"accvalwizard?chksql=data4";
					popupwin = window.open(m_url,'displayWindow1','left=0,top=130,width=790,height=390,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');				
					//popupwin.focus();		
				}					
				else if(port=="" && from_year=="" && to_year!=="" ){					
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"accvalwizard?chksql=data5&val_todate="+to_date+"&val_tomonth="+to_month+"&val_toyear="+to_year;					
					popupwin = window.open(m_url,'displayWindow1','left=0,top=130,width=790,height=390,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');					
				//	popupwin.focus();		
				}
				else if(port=="" && from_year!=="" && to_year=="" ){		
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"accvalwizard?chksql=data6&val_fromdate="+from_date+"&val_frommonth="+from_month+"&val_fromyear="+from_year;				
					popupwin = window.open(m_url,'displayWindow1','left=0,top=130,width=790,height=390,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');					
				//	popupwin.focus();		
				}
				else if(port!=="" && from_year=="" && to_year!=="" ){					
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"accvalwizard?chksql=data7&port_code="+port.toUpperCase()+"&val_todate="+to_date+"&val_tomonth="+to_month+"&val_toyear="+to_year;					
					popupwin = window.open(m_url,'displayWindow1','left=0,top=130,width=790,height=390,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');					
				//	popupwin.focus();		
				}				
				else if(port!=="" && from_year!=="" && to_year=="" ){					
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"accvalwizard?chksql=data8&port_code="+port.toUpperCase()+"&val_fromdate="+from_date+"&val_frommonth="+from_month+"&val_fromyear="+from_year;				
					popupwin = window.open(m_url,'displayWindow1','left=0,top=130,width=790,height=390,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');					
				//	popupwin.focus();		
				}						
			}
			
			function chkstartdate(dayobj,monthobj,yearobj) {
				if (checkMonthLength(dayobj,monthobj,yearobj)) {
					
				}
			}
			///function created by Samanthi Ranasinghe on 14/03/2001
			
			function chkstartdate2(dayobj,monthobj,yearobj) {
				if (checkMonthLength(dayobj,monthobj,yearobj)) {
					
					displaydata1();
					
				}
			}
			////function created by Samanthi Ranasinghe on 14/03/2001
			function displaydata1()
			{	
				to_date=document.Form1.TXT_TODATE.value;
				to_month=document.Form1.TXT_TOMONTH.value;
				to_year=document.Form1.TXT_TOYEAR.value;
				m_date=to_date+"-"+to_month+"-"+to_year;
				
				// m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"acc_balance_sheetval1?chksql=chk_date1&m_date="+m_date+ " " ;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"display_trial_date?chksql=chk_date1&m_date="+m_date ;
				
				load_interface(m_url,'XML',false);
				m_size = data_vec.length;
				//top.frames[0].document.applets[0].getdata(m_url);
				//m_size=top.frames[0].document.applets[0].outvec_value.size();
				//alert(top.frames[0].document.applets[0].outvec_value);
				//if ( top.frames[0].document.applets[0].outvec_value.elementAt(0) <=0 )
				if ( m_size == 0 )
				{
					//dis_copying();
					displaydata(document.Form1.TXT_PCODE.value,document.Form1.TXT_FROMDATE.value,document.Form1.TXT_FROMMONTH.value,document.Form1.TXT_FROMYEAR.value,document.Form1.TXT_TODATE.value,document.Form1.TXT_TOMONTH.value,document.Form1.TXT_TOYEAR.value)
				}
				else
				{
					if (confirm("'To Date' should not be Greater than Last 'Day End Routine Date' ..Do You wish to Continue?") )
					{
						
						displaydata(document.Form1.TXT_PCODE.value,document.Form1.TXT_FROMDATE.value,document.Form1.TXT_FROMMONTH.value,document.Form1.TXT_FROMYEAR.value,document.Form1.TXT_TODATE.value,document.Form1.TXT_TOMONTH.value,document.Form1.TXT_TOYEAR.value)
					}
					
				}
			}
			
			
			
			///SSS
			function portcheck(objx){
				if (objx.value!="") {
					m_portcode=objx.value;
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"accvalwizard?port_code="+m_portcode.toUpperCase()+"&chksql=chkport";
					top.frames[0].document.applets[0].getdata(m_url);
					m_size=top.frames[0].document.applets[0].outvec_value.size();
					if (m_size==0) {
						port_help(objx);
						objx.focus();
					}
				}
			}
			
			function port_help(obj1) {
				m_portcode=obj1.value;
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"accvalwizard?port_code="+m_portcode.toUpperCase()+"&chksql=port_lookup_acc";
				top.frames[0].document.applets[0].getdata(m_url);
				m_size=top.frames[0].document.applets[0].outvec_value.size();
				vec_pos=0;
				lineno=1;
				m_row="";
				while (vec_pos<m_size) {
					m_issu_code=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos);
					m_issu_name=top.frames[0].document.applets[0].outvec_value.elementAt(vec_pos+1);
					m_row=m_row+'<TR STYLE="{color: black; cursor:hand}" ID=LINE'+	lineno+' BGCOLOR="white" ONMOUSEOVER=mouseover_setings(LINE'+lineno+'); ONMOUSEOUT=mouseout_setings(LINE'+lineno+'); onClick=close_help(C1R'+lineno+'); ><TD ID=C1R'+	lineno+'><B>'+m_issu_code+'</B></TD><TD ID=C2R'+	lineno+'><B>'+m_issu_name+'</B></TD></TR>';
					vec_pos=vec_pos+2;
					lineno=lineno+1;
				}
				
				m_writedata ='<TABLE BGCOLOR="silver" WIDTH="100%" STYLE="{color: white; font: 9pt arial;}">'+
					'<TR BGCOLOR="darkblue"><TD WIDTH="30%"><B>Portfolio Code</B></TD>' +
					'<TD WIDTH="70%"><B>Portfolio Name</B></TD></TR>'+
					m_row+
					'</TABLE>'; 
				myDialogObj.htmlstr = m_writedata;
				myDialogObj.returnval = "";
				
				popupwin = window.showModalDialog("help_box2.html",myDialogObj,"dialogWidth:20em; dialogHeight:15em; center:yes; resizable:yes; status:no");
				obj1.value=myDialogObj.returnval;
				obj1.focus();			
			}	
			
			function instcheck(objx){
				if (objx.value!="") {
					m_portcode=objx.value;
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalwizard?inst_code="+m_portcode.toUpperCase()+"&chksql=chkinst";
					top.frames[0].document.applets[0].getdata(m_url);
					m_size=top.frames[0].document.applets[0].outvec_value.size();
					if (m_size==0) {
						inst_help(objx);
						objx.focus();
					}
				}
			}			
			
			function saveall(){
				if((mm_fromdate!="")&&(mm_todate!="")){				
					m_portcode=mm_portcode;
					m_acc_typecode=mm_acc_typecode;
					m_fromdate=mm_fromdate;
					m_todate=mm_todate;
					m_option=mm_option;
					alert("Open the file mbfsl_server\\Dealnet\\Mbfsl_Trial_Details\\"+m_acc_typecode+"\\Drill_down-"+m_acc_typecode+" to Print");
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"tb_text?portcode="+m_portcode+"&acctypecode="+m_acc_typecode+"&selec_fromdate="+m_fromdate+"&selec_todate="+m_todate+"&option="+m_option;
					top.frames[0].document.applets[0].getdata(m_url);
				}
				if((mm_fromdate=="")&&(mm_todate!="")){
					m_portcode=mm_portcode;
					m_acc_typecode=mm_acc_typecode;
					//m_fromdate=mm_fromdate;
					m_todate=mm_todate;
					m_option=mm_option;
					alert("Open the file mbfsl_server\\Dealnet\\Mbfsl_Trial_Details\\"+m_acc_typecode+"\\Drill_down-"+m_acc_typecode+" to Print");
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"tb_text?portcode="+m_portcode+"&acctypecode="+m_acc_typecode+"&selec_todate="+m_todate+"&option="+m_option;
					top.frames[0].document.applets[0].getdata(m_url);
				}
				if((mm_fromdate!="")&&(mm_todate=="")){
					m_portcode=mm_portcode;
					m_acc_typecode=mm_acc_typecode;
					m_fromdate=mm_fromdate;
					//m_todate=mm_todate;
					m_option=mm_option;
					alert("Open the file mbfsl_server\\Dealnet\\Mbfsl_Trial_Details\\"+m_acc_typecode+"\\Drill_down-"+m_acc_typecode+" to Print");
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"tb_text?portcode="+m_portcode+"&acctypecode="+m_acc_typecode+"&selec_fromdate="+m_fromdate+"&option="+m_option;
					top.frames[0].document.applets[0].getdata(m_url);
				}
				if((mm_fromdate=="")&&(mm_todate=="")){
					m_portcode=mm_portcode;
					m_acc_typecode=mm_acc_typecode;
					//m_fromdate=mm_fromdate;
					//m_todate=mm_todate;
					m_option=mm_option;
					alert("Open the file mbfsl_server\\Dealnet\\Mbfsl_Trial_Details\\"+m_acc_typecode+"\\Drill_down-"+m_acc_typecode+" to Print");
					m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"tb_text?portcode="+m_portcode+"&acctypecode="+m_acc_typecode+"&option="+m_option;
					top.frames[0].document.applets[0].getdata(m_url);
				}
			}
			
			function default_actions() {	
				setInterval("set_timer_actions()", 120000);
			}			
			
			
			function set_timer_actions() {	
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bvalwizard?chksql=idle";
				top.frames[0].document.applets[0].getdata(m_url);
			}	
			
			function previous() {	
				m_start=parseInt(m_start)- parseInt(100);
				m_end=parseInt(m_end)- parseInt(100);
				m_portcode=mm_portcode;
				m_acc_typecode=mm_acc_typecode;
				m_fromdate=mm_fromdate;
				m_todate=mm_todate;
				m_option=mm_option;
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'accval_tb?chksql=moredata&mm_start='+m_start+'&mm_end='+m_end+'&portcode='+m_portcode+'&acctypecode='+m_acc_typecode+'&selec_fromdate='+m_fromdate+'&selec_todate='+m_todate+'&option='+m_option;
				popupwin2 = window.open(m_url,'displayWindow2','left=0,top=0,width=680,height=250,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
				popupwin2.focus();		
			}
			
			
			function next() {	
				m_start=parseInt(m_end)+parseInt(1);
				m_end=parseInt(m_start)+parseInt(99);
				m_portcode=mm_portcode;
				m_acc_typecode=mm_acc_typecode;
				m_fromdate=mm_fromdate;
				m_todate=mm_todate;
				m_option=mm_option;
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'accval_tb?chksql=moredata&mm_start='+m_start+'&mm_end='+m_end+'&portcode='+m_portcode+'&acctypecode='+m_acc_typecode+'&selec_fromdate='+m_fromdate+'&selec_todate='+m_todate+'&option='+m_option;
				popupwin2 = window.open(m_url,'displayWindow2','left=0,top=0,width=680,height=250,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
				popupwin2.focus();		
			}
			//------------------------------Prabash------------------------------**
			function call_frame(){
				
				m_grid_height = ($(window).height() - 200);
				m_grid_width = ($(window).width() - 0);
				if(document.Form1.TXT_FROMDATE.value!="" && document.Form1.TXT_FROMMONTH.value!="" && document.Form1.TXT_FROMYEAR.value!=""){
					
					/* parent.frames[1].location.href=""+servlet_client_url+":"+client_t3_port+"/"+client_name+"BrokerBulkPaymentsAll?chksql=Bulk_payments"+
														"&val_fromdate="+document.Form1.TXT_FROMDATE.value+
																					"&val_frommonth="+document.Form1.TXT_FROMMONTH.value+
																					"&val_fromyear="+document.Form1.TXT_FROMYEAR.value;*/
					
					
					
					m_url=""+servlet_client_url+":"+client_t3_port+"/"+client_name+"accvalwizard?chksql=data2"+
						//	alert('123');
						"&val_fromdate="+document.Form1.TXT_FROMDATE.value+
						"&val_frommonth="+document.Form1.TXT_FROMMONTH.value+
						"&val_fromyear="+document.Form1.TXT_FROMYEAR.value+
						"&val_todate="+document.Form1.TXT_TODATE.value+
						"&val_tomonth="+document.Form1.TXT_TOMONTH.value+
						"&val_toyear="+document.Form1.TXT_TOYEAR.value;
					
					load_interface(m_url,'NO',false);	
					var newcontent = document.getElementById("data_div2");
					newcontent.innerHTML = data_vec_no;
					//   alert(data_vec_no);
					/*jQuery("#myTable").jqGrid({ 
							//url: 'server.php?q=tree', 
							//treedatatype: "xml",
							//mtype: "POST", 
							//colNames:["id","Account","Acc Num", "Debit", "Credit","Balance"],
							//colModel:[ {name:'id',index:'id', width:1,hidden:true,key:true}, {name:'name',index:'name', width:180}, {name:'num',index:'acc_num', width:80, align:"center"}, {name:'debit',index:'debit', width:80, align:"right"}, {name:'credit',index:'credit', width:80,align:"right"}, {name:'balance',index:'balance', width:80,align:"right"} ],
							height:'auto',
							//pager : "#ptreegrid",
							//treeGrid: true, 
							ExpandColumn :'name', caption: "Treegrid example" });
					*/
					
					tableToGrid("#myTable");
					jQuery("#myTable").setCaption('Trial Balance'); 
					//	jQuery("#myTable").setCaption('Trial Balance For The Period From' '"+document.Form1.TXT_FROMDATE.value+"''-''"+document.Form1.TXT_FROMMONTH.value+"''-''"+document.Form1.TXT_FROMYEAR.value+"' 'To');
					//jQuery("#myTable").setGridParam({footerrow: true}).trigger("reloadGrid");//,rowTotal: 100000, rowList: [20, 30, 50, 100, 100000]
					jQuery("#myTable").setGridHeight(m_grid_height);
					jQuery("#myTable").setGridWidth(m_grid_width);
					


					//jQuery("#myTable").setGridWidth(100%);
					//jQuery("#myTable").setGridParam({...}).hideCol("somecol").trigger("reloadGrid");
					
					
				}
				else{
					alert("Please enter Date and continue.");
				}
				
			}	
			//-------------------------------------------------------------	
			function get_vector_normal(m_data){
				var newcontent = document.getElementById("data_div2");
				   newcontent.innerHTML = m_data;
			}
			//--------------------------------------------------------------	
			
			$(document).ready
			(
				
				function() 
				{
					//initDialog();
					initDialogPOPup();
				}
			);
			
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
			//prabash on 03-10-2011-----------------------------------------------------------
			 function loadGridReceiptsAppove() {
               jQuery('#TABLE_CLIENT_RECEIPT_APPROVE').GridUnload();
              
					m_url=""+servlet_client_url+":"+client_t3_port+"/"+client_name+"accvalwizard?chksql=data2"+
						//	alert('123');
						"&val_fromdate="+document.Form1.TXT_FROMDATE.value+
						"&val_frommonth="+document.Form1.TXT_FROMMONTH.value+
						"&val_fromyear="+document.Form1.TXT_FROMYEAR.value+
						"&val_todate="+document.Form1.TXT_TODATE.value+
						"&val_tomonth="+document.Form1.TXT_TOMONTH.value+
						"&val_toyear="+document.Form1.TXT_TOYEAR.value;
					
					jQuery('#TABLE_CLIENT_RECEIPT_APPROVE').jqGrid({
                   url: m_url,
                   //loadonce: 1,
                   datatype: 'json',
                   colNames: ['Section','Portfolio Code','Account Type Code','Description','Debit','Credit'],
                   colModel: [
						{name: 'Section',              index: 'Section',        	jsonmap: 'Section',       hidden:true  ,    sortable: false, align: 'center', width: 100, resizable: false,   unformat: unformatData },//formatter: cellFomatterReceiptsColumn_1,
						{name: 'Portfolio_Code',       index: 'Portfolio_Code',   	jsonmap: 'Portfolio_Code',      sortable: false, align: 'center', width: 100, resizable: false,   unformat: unformatData },//formatter: cellFomatterReceiptsColumn_1,
						{name: 'Account_Type_Code',    index: 'Account_Type_Code',  jsonmap: 'Account_Type_Code', 	sortable: false, align: 'center',  width: 110, resizable: false,  unformat: unformatData },//formatter: cellFomatterReceiptsColumn_5,
						{name: 'Description',          index: 'Description',        jsonmap: 'Description', 		sortable: false, align: 'left', width: 300,  resizable: false,  unformat: unformatData },//formatter: cellFomatterReceiptsColumn_9,
						{name: 'Debit',                index: 'Debit',           	jsonmap: 'Debit', 				sortable: false, align: 'right', width: 100, resizable: false,   unformat: unformatData},
						{name: 'Credit',               index: 'Credit',   			jsonmap: 'Credit', 			    sortable: false, align: 'right', width: 100, resizable: false,   unformat: unformatData}],
                   mtype: 'GET',
                   rownumbers: true,
                   rowNum: -1,
                   gridview: true,
                   height: 'auto',
                   hidegrid: false,
                   toolbar: [false, 'top'],
                   caption: 'Trial Balance',
				   footerrow: true,
				   userDataOnFooter: true,				
				   onCellSelect: jq_grid_click_event,	 		
				   jsonReader: {repeatitems: false},
                   gridComplete: function() {
						 
                           $('#jqgh_ACTUAL_ReceiptS_COLUMN_1').css('cursor', 'default');
                           $('#jqgh_ACTUAL_ReceiptS_COLUMN_2').css('cursor', 'default');
                           $('#jqgh_ACTUAL_ReceiptS_COLUMN_3').css('cursor', 'default');
                           $('#jqgh_ACTUAL_ReceiptS_COLUMN_4').css('cursor', 'default');
                           $('#jqgh_ACTUAL_ReceiptS_COLUMN_5').css('cursor', 'default');
                          
                          
                        
                        
                         //  $('#DIV_NET_AVAILABILITY').text(format_noobject0($('#HID_FINAL_AVAILABILITY').val(), 2, null, 'BRACKETS'));
                           //init_fancybox();
                           //initCal('TXT_VALUE_DATE_' + '1');
                          /* if ((document.Form1.hid_receipts_count_new.value == '0') && (m_onload_add_receipt_flag == false)) {
                              // addReceiptItem();
                              // m_onload_add_receipt_flag = true;
							}*/
                           //get_exchange_rate();
						
						
					},
					loadComplete : function(){
                        var rec_count=$("#TABLE_CLIENT_RECEIPT_APPROVE").jqGrid('getGridParam',"records");
                        document.Form1.hid_count.value=rec_count;
					}
               });
           }
			//--------------------------------------------------------------------------------
			 function unformatData(cellvalue, options, cellobject) {
               return cellvalue;
           }
			
			
			function  jq_grid_click_event(rowid, iCol, cellcontent) {
				
					var	val_fromdate=document.Form1.TXT_FROMDATE.value;
					var	val_frommonth=document.Form1.TXT_FROMMONTH.value;
					var	val_fromyear=document.Form1.TXT_FROMYEAR.value;
					var	val_todate=document.Form1.TXT_TODATE.value;
					var	val_tomonth=document.Form1.TXT_TOMONTH.value;
					var	val_toyear=document.Form1.TXT_TOYEAR.value;
				
					var m_valfromdate = val_fromdate+'/'+val_frommonth+'/'+val_fromyear;
					var m_valtodate   = val_todate+'/'+val_tomonth+'/'+val_toyear;
				//	var m_valfromdate  = document.Form1.TXT_FROMDATE.value"/"document.Form1.TXT_FROMDATE.value+"/"document.Form1.TXT_FROMYEAR.value;
					
					var m_selected_row     = jQuery('#TABLE_CLIENT_RECEIPT_APPROVE').jqGrid('getRowData', rowid);
                     var Portfolio_Code     =  m_selected_row.Portfolio_Code;
				 	 var Account_Type_Code 	=  m_selected_row.Account_Type_Code;
				     var Section            =  m_selected_row.Section;
                  
				if(iCol == 4){
					
					if(Section=='1'){
					display_more_date(Portfolio_Code,Account_Type_Code,m_valfromdate,m_valtodate,'data2');
					}else{
					display_more_date(Portfolio_Code,Account_Type_Code,m_valfromdate,m_valtodate,'data22');
					}			  
				}
				else if(iCol == 5){
				
			   if(Section=='1'){	
				display_more_date(Portfolio_Code,Account_Type_Code,m_valfromdate,m_valtodate,'data2');
			   }else{
			    display_more_date(Portfolio_Code,Account_Type_Code,m_valfromdate,m_valtodate,'data22');
		     	}	
				
			 }
			
			}
			function disable_but(){
			
			document.Form1.BUT_BCODE.disabled=true;	
			}
			
			function clear2(){
				
			 jQuery('#TABLE_CLIENT_RECEIPT_APPROVE').GridUnload();
		        document.Form1.TXT_FROMDATE.value="";
				document.Form1.TXT_FROMMONTH.value="";
				document.Form1.TXT_FROMYEAR.value="";
				document.Form1.TXT_TODATE.value="";
				document.Form1.TXT_TOMONTH.value="";
				document.Form1.TXT_TOYEAR.value="";	
				
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
                   document.Form1.TXT_FROMDATE.value = splitResult[0];
                   document.Form1.TXT_FROMMONTH.value = splitResult[1];
                   document.Form1.TXT_FROMYEAR.value = splitResult[2];
                   document.Form1.TXT_FROMYEAR.focus();
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
		        document.Form1.TXT_FROMDATE.value=data_vec[0].substring(0,2);
		        document.Form1.TXT_FROMMONTH.value=data_vec[0].substring(3,5);
		        document.Form1.TXT_FROMYEAR.value=data_vec[0].substring(6,10);
				document.Form1.TXT_TODATE.value=data_vec[0].substring(0,2);
		        document.Form1.TXT_TOMONTH.value=data_vec[0].substring(3,5);
		        document.Form1.TXT_TOYEAR.value=data_vec[0].substring(6,10);
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
	<BODY class="body & txt-body" ONLOAD="disable_but(); display_dat();">
		<FORM NAME="Form1" ID="Form1">
			<INPUT TYPE="Hidden" NAME="Hid_scr_name"	VALUE="reveryfication">
			<INPUT TYPE="Hidden" NAME="hid_count"	VALUE="0">
		
			<DIV>
				<TABLE class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
					
					<tr>
						<td height='7'></td>
					</tr>
					
					<tr height='30' >
						<td  width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
						<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'> <B> 	Margin Trading  - Accounting</B></td>
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
									<!--<INPUT TYPE="Button" NAME="NEW" VALUE="Add&nbsp; "   onClick="entry_mode('new')"  class="mainbut"  >-->
								</TD>
								
								<TD WIDTH="6%">	
								<!--	<INPUT TYPE="Button" NAME="MOD" VALUE="Modify&nbsp; " onClick="entry_mode('mod')  " class="mainbut"  >-->
								</TD>
								
								<TD WIDTH="6%">	
									<!--<INPUT TYPE="Button" NAME="DEL" VALUE="Delete&nbsp; "   onClick= "entry_mode('del')"  class="mainbut"  >-->
								</TD>				
								
								<TD WIDTH='6%'></TD>	
								
								<TD WIDTH="6%">	
									<!--<INPUT TYPE="Button" NAME="save_but" VALUE="Save&nbsp; "   onClick="beforesubmit()" class="mainbut"  >-->
								</TD>
								
								<TD WIDTH="6%">
									<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"   onClick ="clear2(); display_dat();"  class="mainbut"> 
								</TD>
								
								<TD WIDTH="6%">
									<INPUT TYPE="Button" NAME="Exit_but" VALUE="Exit"   onClick="location.href='low.jsp'" class="mainbut"> 
								</TD>
								
								<TD WIDTH="6%">
									<!--<INPUT TYPE="Button" NAME="report_but" VALUE="Enquiry&nbsp; "    onClick="obtain_report_before()" class="mainbut"> -->
								</TD>
								
								<TD  WIDTH="50%" class="hh1" align="right">
									<B>Trial Balance</B>
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
						
						<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0" >
							
							<TR>
								<TD WIDTH="1%"></TD>

								<TD WIDTH="20%">Portfolio Code</TD>
								<!--<TD WIDTH="20%"><INPUT TYPE="Text" NAME="TXT_PCODE"  VALUE="ADLMT" ONBLUR="portcheck(document.Form1.TXT_PCODE)" ALIGN="LEFT" SIZE=15 MAXLENGTH=10 > -->
								<TD WIDTH="40%"><INPUT TYPE="Text" NAME="TXT_PCODE"  VALUE="ADLMT" class="txt_input6" ALIGN="LEFT" SIZE=15 MAXLENGTH=10 > 
									<INPUT TYPE="button" VALUE="..." NAME="BUT_BCODE" ID="BUT_BCODE" class="mainbut" ></TD>
								<!-- ONCLICK="port_help(document.Form1.TXT_PCODE)"-->
								
								<TD></TD>
							</TR><TR><TD WIDTH="1%"></TD>
		
								<TD >From </TD>
								<TD WIDTH="20%"><INPUT TYPE="Text" NAME="TXT_FROMDATE"  class="txt_input5"  SIZE=3 MAXLENGTH=2   />
												<INPUT TYPE="Text" NAME="TXT_FROMMONTH" class="txt_input5"  SIZE=3 MAXLENGTH=2   />
												<INPUT TYPE="Text" NAME="TXT_FROMYEAR"  class="txt_input5"  SIZE=5 MAXLENGTH=4	 ONBLUR="chkstartdate(document.Form1.TXT_FROMDATE,document.Form1.TXT_FROMMONTH,document.Form1.TXT_FROMYEAR)" />							
							<input type = "hidden" name = "TXT_START_DATE" id = "TXT_START_DATE" /></TD>
								
								
									<TD>To </TD>
									<TD><INPUT TYPE="Text" NAME="TXT_TODATE"  class="txt_input5" SIZE=3 MAXLENGTH=2  />
										<INPUT	   TYPE="Text" NAME="TXT_TOMONTH" class="txt_input5" SIZE=3 MAXLENGTH=2  />
										<INPUT	   TYPE="Text" NAME="TXT_TOYEAR"  class="txt_input5" SIZE=5 MAXLENGTH=4     ONBLUR="chkstartdate2(document.Form1.TXT_TODATE,document.Form1.TXT_TOMONTH,document.Form1.TXT_TOYEAR)">
										<input type = "hidden" name = "TXT_END_DATE" id = "TXT_END_DATE" />
										
										<!-- <INPUT TYPE="button" VALUE=" GO " NAME="BUT_BCODE" class="mainbut" ONCLICK="displaydata(document.Form1.TXT_PCODE.value,document.Form1.TXT_FROMDATE.value,document.Form1.TXT_FROMMONTH.value,document.Form1.TXT_FROMYEAR.value,document.Form1.TXT_TODATE.value,document.Form1.TXT_TOMONTH.value,document.Form1.TXT_TOYEAR.value)" ></TD>	-->		
										<INPUT TYPE="button" VALUE=" GO " NAME="BUT_BCODE" class="mainbut" ONCLICK= "loadGridReceiptsAppove()" ></TD>
									
								</TR>
							</TABLE>	
							
							<TABLE width="100%" BORDER="0" CELLPADDING="2" CELLSPACING="1" STYLE="{color: yellow; font: bold 10pt sans-serif;}">
								<tr>
									<td>
										<INPUT TYPE="Hidden" NAME="Hid_rows" >
										<DIV id=clientmgr></DIV>						
									</td>
								</tr>
							</TABLE> 
						</TABLE> 
						<!----------------------------------------------->	
						<BR>
						<BR>		
						
						
						<table align='center' width='90%' class='table'>
							<tr> 
								<td ALIGN='CENTER'> 
									
									<div id = "DIV_Receipt_APPROVE">
                                          <table id = "TABLE_CLIENT_RECEIPT_APPROVE"></table>
                                          <div id = "DIV_PAGER_TABLE_CLIENT_RECEIPT_APPROVE"></div>

                                     </div> 
								</td>
							</tr> 
						</table>			
						<!----------------------------------------------->	
					</FORM>
					
					<DIV ID ="DIV_DAILY_MARG_ACTIVITY" TITLE ="DAILY MARGIN TRADING ACTIVITY">
						<IFRAME ID ="DIV_DAILY_MARG_IFRAME_ACTIVITY" WIDTH = "100%" HEIGHT = "100%" MARGINWIDTH = "0" MARGINHEIGHT = "0" FRAMEBORDER = "0" SCROLLING = "AUTO" TITLE = "DAILY MARGIN TRADING ACTIVITY">
						</IFRAME>
					</DIV>
					
					<!--
						<div id ="DIV_DAILY_MARG_ACTIVITY_POPUP" >
						<iframe id ="DIV_DAILY_MARG_IFRAME_ACTIVITY_POPUP" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Daily Margin Trading Activity">
						</iframe>
					</div>
					-->
					<!----------------------------------------------->	
					
				</BODY>
				<DIV>
					<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>	
					<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>	
					
				</DIV>
			</html>
			
