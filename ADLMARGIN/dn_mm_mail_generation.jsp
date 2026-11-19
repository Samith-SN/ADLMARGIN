<%@page import="net.sasianet.ADLMARGIN.*" %>
<%	
	
	 ADLMARGIN_MGT_conn_methods m_sn_methods = new  ADLMARGIN_MGT_conn_methods(session);
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
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/i18n/grid.locale-en.js\"></script>");
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/4.1/js/jquery.jqGrid.min.js\"></script>");
	out.println("<link rel=\"stylesheet\" type=\"text/css\" href=\""+m_jsp_client_url+"/css/ui.jqgrid.css\" />");
	
	//--
	
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/tiny_mce/tiny_mce.js\"></script>");
//	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET2/jquery/grid/js/i18n/grid.locale-en.js\"></script>");
//	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET2/jquery/grid/js/jquery.jqGrid.min.js\"></script>");
//	out.println("<link rel=\"stylesheet\" type=\"text/css\" media=\""screen"\"  href=\""+m_jsp_client_url+"/SNET2/jquery/grid/themes/redmond/jquery-ui-1.7.1.custom.css' />");
//	out.println("<link rel=\"stylesheet\" type=\"text/css\" media=\""screen"\"  href=\""+m_jsp_client_url+"/SNET2/jquery/grid/themes/ui.jqgrid.css' />");
	
	
	
//	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/fancybox/jquery-1.4.1.min.js'></script>");
//	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/fancybox/jquery.fancybox-1.3.0.pack.js'></script>");
//	out.println("<link rel="stylesheet" href='" + m_jsp_client_url + "/SNET/jquery/fancybox/jquery.fancybox-1.3.0.css'type='text/css' media="screen">");
//	out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/SNET/css/Asset_Financing_System.css' TYPE="text/css">");
//	out.println("<link rel="stylesheet" type="text/css" media="screen" href='" + m_jsp_client_url + "/SNET/jquery/grid/themes/redmond/jquery-ui-1.7.1.custom.css' />");
//	out.println("<link rel="stylesheet" type="text/css" media="screen" href='" + m_jsp_client_url + "/SNET/jquery/grid/themes/ui.jqgrid.css' />");
//	out.println("<script src=\" " + m_jsp_client_url + "/SNET/jquery/grid/js/i18n/grid.locale-en.js' type=\"text/javascript\"></script>");
//	out.println("<script src=\"" + m_jsp_client_url + "/SNET/jquery/grid/js/jquery.jqGrid.min.js' type=\"text/javascript\"></script>");
	//--
	
	
%>
<HTML>
<HEAD>
<TITLE>Factoring - Manual Mail Generation</TITLE>
<!--		
<script type="text/javascript" src='http://www.netfac.lk/SNET/jquery/fancybox/jquery-1.4.1.min.js'></script>
<script type="text/javascript" src='http://www.netfac.lk/SNET/jquery/fancybox/jquery.fancybox-1.3.0.pack.js'></script>
<link rel="stylesheet" href='http://www.netfac.lk/SNET/jquery/fancybox/jquery.fancybox-1.3.0.css'type='text/css' media="screen">
<link REL='STYLESHEET' HREF='http://www.netfac.lk/SNET/css/Asset_Financing_System.css' TYPE="text/css">
<link rel="stylesheet" type="text/css" media="screen" href='http://www.netfac.lk/SNET/jquery/grid/themes/redmond/jquery-ui-1.7.1.custom.css' />
<link rel="stylesheet" type="text/css" media="screen" href='http://www.netfac.lk/SNET/jquery/grid/themes/ui.jqgrid.css' />
<script src='http://www.netfac.lk/SNET/jquery/grid/js/i18n/grid.locale-en.js' type="text/javascript"></script>
<script src='http://www.netfac.lk/SNET/jquery/grid/js/jquery.jqGrid.min.js' type="text/javascript"></script>
		
-->		 
		 <script type="text/javascript" src="validate.js"></script>
		 <script type="text/javascript" src="ajax_data_gateway.js"></script> 
		 <script type="text/javascript" src="factoring_drill_down.js"></script> 
		
<SCRIPT language="JavaScript">

var isOpen=false;
function clearIsOpen(){;
   isOpen=false;
}
function init_fancybox() { 
   $("a.fancylink").fancybox({
    'hideOnContentClick': false, 'width':404 , 'height': 328,
    'overlayShow': false, 
    'changeSpeed':0, 'speedIn':200, 'speedOut':200,
    'opacity':true,'onClosed' : clearIsOpen, 'centerOnScroll':true, 'easingIn':'swing', 
    'easingOut':'swing' ,transitionIn:'elastic' ,transitionOut:'elastic',
    'type':'iframe','showCloseButton':false,'enableEscapeButton':false
  });
}
$(document).ready(function() {
	//	alert('00000');
 // init_fancybox();
  load_facility_list()
});
$('a').live('click', function() {
 // init_fancybox();
}); 
function HelpBox(Start,End,Hid_No,link_id) {
     document.getElementById(link_id).href=servlet_client_url+":"+client_t3_port+"/NETFAC_FA_MAS_Help_Servlet?class_in="+client_name+"FA_OP_help_select"+
    "&Sql_in="+m_sql+"&Start_in="+Start+
    "&End_in="+End+"&Crit_In="+m_criteria+
    "&Hid_No="+Hid_No+"&link_id="+link_id;
    $("#"+link_id).trigger("click");
}
function helpCheck(valout,Hid_No,link_id){
	if(valout[1]=="Next"){
		Next(valout[2],valout[3],Hid_No,link_id);
	} 
	else if(valout[1]=="Prev"){
		Prev(valout[2],valout[3],Hid_No,link_id);
	}	
}  
function help_close(){
   $.fancybox.close();
}
function Prev(Start,End,Hid_No,link_id){
	HelpBox(Start,End,Hid_No,link_id);
}
function Next (Start,End,Hid_No,link_id){
	HelpBox(Start,End,Hid_No,link_id);
}

function help_update_facility(m_strat) {

	
var aForm;    //  aForm =oForm.elements;
aForm =  document.getElementById('Form1');	
	
var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.TXT_FACILITY_NO;
 		myObject[1]=aForm.hid_client_no;
		myObject[2]=aForm.hid_client_name;
	
	var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.TXT_FACILITY_NO.value;
		myObject_value[1]=null;
		myObject_value[2]=null;
	
 
	
	var myObject_type=new Array(); //passing values data type
 		myObject_type[0]="StringL";
 		myObject_type[1]="StringL";
 		myObject_type[2]=null;

 
 		var qid='134';
		var hid='';
 		var url = 'popup.jsp';
 		var json_text = JSON.stringify(myObject_value, null,0);
 		var json_obj_type_text=JSON.stringify(myObject_type, null,0);
 		var fn_name=arguments.callee.name;
		if(fn_name==undefined){
		re = /^function\s+([^(]+)/;
        fn_name=re.exec(arguments.callee.toString())[1];
		}
	
       	$.showModalDialog({
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&hid='+hid,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400,// 600,
		 width: 500,//900,
		 title: 'SasiNet Frame work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);add_to_facility_grid();	  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
		
		}	
	
	
 /*  if(!isOpen){
      isOpen=true;
 	document.Form1.hid_help_type.value="1";
 	m_sql = "m_help_DIV_TXT_CLIENT_LEGAL_LETTER_sql";
 	m_criteria = document.Form1.TXT_FACILITY_NO.value+"@";
 HelpBox('1','10','0',link_id);
}
}
*/	
	
function help_update_mailcode(m_strat) {
	
var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	
	var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.TXT_MAIL_CODE;
 	//	myObject[1]=aForm.TXT_MAIL_DESC;
	//	myObject[2]=aForm.TXT_MAIL_CAT;
	
	
	var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.TXT_MAIL_CODE.value;
		myObject_value[1]=null;
		myObject_value[2]=null;
	
 
	
	var myObject_type=new Array(); //passing values data type
 		myObject_type[0]="StringL";
 		myObject_type[1]="StringL";
 		myObject_type[2]=null;

 
 		var qid='132';
		var hid='';
 		var url = 'popup.jsp';
 		var json_text = JSON.stringify(myObject_value, null,0);
 		var json_obj_type_text=JSON.stringify(myObject_type, null,0);
 		var fn_name=arguments.callee.name;
		if(fn_name==undefined){
		re = /^function\s+([^(]+)/;
        fn_name=re.exec(arguments.callee.toString())[1];
		}
	
       	$.showModalDialog({
		 url: url+'?par='+json_text+'&type='+json_obj_type_text+'&qid='+qid+'&show=10'+'&start='+m_strat+'&fn_name='+fn_name+'&hid='+hid,
		 dialogArguments: myObject_value, //dialogArguments: 'www.waruna.com', //dialogArguments: myObject,
		 height:400,// 600,
		 width: 500,//900,
		 title: 'SasiNet Frame work',
		 scrollable: true,
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);   } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		
		});
	
	}	
	
	
/*	
   if(!isOpen){
      isOpen=true;
 	document.Form1.hid_help_type.value="2";
 	m_sql = "m_help_TXT_MAIL_CODE_sql";
    m_criteria = document.Form1.TXT_MAIL_CODE.value+"@"+"Y@"+"NETFACALL@";
 HelpBox('1','10','0',link_id);
}
} */
function setData(data){
    if(document.Form1.hid_help_type.value=="1"){
			help_value_assign_1(data);
	  }
    if(document.Form1.hid_help_type.value=="2"){
			help_value_assign_2(data);
	  }
}
function help_value_assign_1(data) {
		document.Form1.TXT_FACILITY_NO.value=data.colomn_2;
		document.Form1.hid_client_no.value=data.colomn_3;
		document.Form1.hid_client_name.value=data.colomn_4;
		add_to_facility_grid(document.Form1.TXT_FACILITY_NO,document.Form1.hid_client_no,document.Form1.hid_client_name)
}
function help_value_assign_2(data) {
		document.Form1.TXT_MAIL_CODE.value=data.colomn_2;
}
function clear_fields() {
if(document.Form1.hid_help_type.value=="1"){
		document.Form1.TXT_FACILITY_NO.value="";
}
if(document.Form1.hid_help_type.value=="2"){
		document.Form1.TXT_MAIL_CODE.value="";
}
}
function load_facility_list(){
//	alert('11111');
	


	
jQuery("#CLIENT_FACILITY").jqGrid(
{
datatype: "local",
colNames:['&nbsp','Facility Code','Client Code','Client Name'],
	
colModel:[ {name:'CHECK',index:'CHECK', sortable:false,width:60,align:"center",formatter:checkboxfmatter},
{name:'FACILITY',index:'FACILITY', width:120, align:"left",sortable:true,formatter:facility_no_fmatter,unformat:unformatFacility},
{name:'CLIENT',index:'CLIENT', width:120, align:"left",sortable:true},
{name:'NAME',index:'NAME', width:150, align:"left",sortable:true}],
rownumbers:true,
gridview: true,
height: 'auto',
gridComplete: function () {
}
}
);
}
	
function unformatFacility ( cellvalue, options, cellobject)
{
return cellvalue;
}
function facility_no_fmatter (cellvalue, options, rowObject)
{
	 var link ='<a style=\'cursor:pointer\' onclick=\'show_facility("'+cellvalue+'")\'>'+cellvalue+'</a>'; 
    return link;
}
function checkboxfmatter (cellvalue, options, rowObject)
{
	 var link ='<input type="checkbox" name="TXT_FACILITY_TYPE_'+cellvalue+'" onclick="check_value(\''+cellvalue+'\')" value="'+cellvalue+'" />'; 
return link;
}
function checkedOne ()
	
{
	//alert('ggg');
var ids = jQuery("#CLIENT_FACILITY").jqGrid('getDataIDs')
var count = 0 ;
 		for (var i = 0; i < ids.length; i++) {
 			var ret = jQuery("#CLIENT_FACILITY").jqGrid('getRowData',ids[i]);
  			if (document.Form1.elements["TXT_FACILITY_TYPE_"+ret.FACILITY].checked == true) {
  				count++
 		        }
 		}
  			if (count > 0) {
  				return true;
 		        } else {
  				return false;
              }
}

function add_to_facility_grid() {
	
var facilityCode=document.Form1.TXT_FACILITY_NO.value;	
var clientNo=Form1.hid_client_no.value;	
var clientName=Form1.hid_client_name.value;		
var facility_status=1;
		//alert( facilityCode+'***'+clientNo+'***'+clientName);
	
if(facilityCode.value==""){
alert('Select Facility Code; Use Help');
		document.Form1.TXT_FACILITY_NO.value="";
		document.Form1.hid_client_no.value="";
		document.Form1.hid_client_name.value="";
facility_status=0;
}
else if(facilityCode.value!=""){
//alert('ggggggff');
var rec_count=$("#CLIENT_FACILITY").jqGrid('getGridParam',"records");
var ids = jQuery("#CLIENT_FACILITY").jqGrid('getDataIDs')



//	alert(rec_count+'--'+ids.length+'**');	
for (var i = 0; i < ids.length; i++) {



	
//alert( 'aaa'+facility_status);

//var cont = $('#CLIENT_FACILITY').getCell(FACILITY, 'MyCol');
//var ret = getCellValue(cont);	
	
var ret = jQuery("#CLIENT_FACILITY").jqGrid('getRowData',ids[i]);
//alert( 'hhh'+ret.FACILITY);	
if(facilityCode==ret.FACILITY){

alert('Facility Code Already Exist');
		document.Form1.TXT_FACILITY_NO.value="";
		document.Form1.hid_client_no.value="";
		document.Form1.hid_client_name.value="";
facility_status=0;
break;
}
}
}
if(facility_status==1){
	//alert( 'bbb'+facility_status);
//	alert( facilityCode+'**2*'+clientNo+'**2*'+clientName);
var facility = new Array();
	
facility['CHECK'] = facilityCode;
facility['FACILITY'] = facilityCode;
facility['CLIENT'] = clientNo;
facility['NAME'] = clientName;
	
//	alert( 'test'+facility['CHECK'] );

var newData = [{"CHECK":facilityCode, "FACILITY": facilityCode,"CLIENT":clientNo,"NAME":clientName }];
	
var grid = jQuery("#CLIENT_FACILITY");

	for (i=0;i<newData.length;i++) {
               grid.jqGrid('addRowData', newData.length+i, newData[newData.length-i-1], "first");
            }


		document.Form1.TXT_FACILITY_NO.value="";
		document.Form1.hid_client_no.value="";
		document.Form1.hid_client_name.value="";
}
}
function load_help_msg() {
    m_help_message = "m_help_msg_MAIL_GENERATION";
    HelpBox_msg(m_help_message);
}
function HelpBox_msg(m_help_message) {
	popupwin = window.showModalDialog(servlet_client_url+":"+client_t3_port+"/"+client_name+"AF_MAS_Help_Msg_Servlet?class_in="+client_name+"AF_MAS_Help_Msg_select"+
  "&help_message_in="+m_help_message);
}
function load_roll_value(m_val){
	document.getElementById('help_box').innerHTML="Manual Mail Generation - "+m_val;
}
function load_roll_out_value(){
	document.getElementById('help_box').innerHTML="Manual Mail Generation ";
}
function load_screen_status(m_val){
if(m_val=="HELP"){
load_help_msg();
}
}
function clear_window(){	
		if(confirm("Are you sure you want to clear the screen?")){ 
		location.href='dn_mm_mail_generation.jsp'	
	//	window.location.href='http://www.netfac.lk:8080/myserver/servlet/NETFAC_FA_MM_mail_generation';
		}
}
function check_value(val) {
    var ret = jQuery("#CLIENT_FACILITY").jqGrid('getRowData',val);
for (i=0; i<document.Form1.elements.length; i++) { 
 	el = document.Form1.elements[i];
 	if (el.type=="checkbox" && el.name.indexOf("TXT_FACILITY_TYPE_")!=-1){
        el.checked=false;
   }
}
 	    document.Form1.elements["TXT_FACILITY_TYPE_"+val].checked=true;
		document.Form1.hid_txt_facility_no.value=ret.FACILITY;
}
function Generate_Letter(val) {
	//alert(document.Form1.TXT_SHOW_PREVIEW.checked+'---'+document.Form1.TXT_MAIL_CODE.value+'--');
if(document.Form1.TXT_SHOW_PREVIEW.checked==true && document.Form1.TXT_MAIL_CODE.value!="" && checkedOne()){
	
if(val=="generate"){

	m_url = "http://"+servlet_client_url+":8080/myserver/servlet/ADLMARGIN_FA_CR_create_document?facility_no="+document.Form1.hid_txt_facility_no.value+"&letter_code="+document.Form1.TXT_MAIL_CODE.value+"&print=TRUE&generate=TRUE";
 popupwin=window.open(m_url,'displayWindow2','left=110,top=110,width=750,height=300,toolbar=0,location=0,center:yes,direction=0,menuBar=1,status=0,scrollbars=1,resizable=1');
}
else{

	m_url = "http://"+servlet_client_url+":8080/myserver/servlet/ADLMARGIN_FA_CR_create_document?facility_no="+document.Form1.hid_txt_facility_no.value+"&letter_code="+document.Form1.TXT_MAIL_CODE.value+"&print=TRUE&generate=FALSE";
 popupwin=window.open(m_url,'displayWindow2','left=110,top=110,width=750,height=300,toolbar=0,location=0,center:yes,direction=0,menuBar=1,status=0,scrollbars=1,resizable=1');
}
}
}
</script>
</HEAD>
<BODY class='body & txt-body' leftmargin='0' topmargin='0' marginwidth='0' ONLOAD="load_lock(),load_roll_value('New')" >
<FORM NAME='Form1'  ID="Form1" method='post'>
<input  type='hidden' value='NEW' name='SCREEN_NAME'/> 
<INPUT TYPE='Hidden' NAME='hid_help_type' VALUE=""/>
<INPUT TYPE='Hidden' NAME='hid_status' VALUE="New"/>
<INPUT TYPE='Hidden' NAME='hid_chk_status' VALUE=""/>
<INPUT TYPE='Hidden' NAME='hid_client_no' VALUE=""/>
<INPUT TYPE='Hidden' NAME='hid_client_name' VALUE=""/>
<INPUT TYPE='Hidden' NAME='hid_txt_facility_no' VALUE=""/>
			
			
<!--------------------------------------------------------------->
			<DIV>
			<table class='table'  align='center' border='0' cellpadding='0' cellspacing='0' width='99%'> 
				<tr>
					<td height='7'></td>
				</tr>
				
				<tr height='30' >
					<td  width='13px' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
					<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'> <B> Margin Trading - Mail Merge</B></td>
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
			
			
<table width='100%' class=table border='0' cellspacing='0' cellpadding='0'>
<!--
<tr>
<td width='8' valign='top'></td>
<td class='border_wht' valign='top'> 
<table class='table' width='100%' border='0' cellspacing='0' cellpadding='0' height='100%'>
<tr> 
<td height='30' class='pdn_mainHD'><div><span>Asset Financing System Version</span><span style='position:absolute;right:30px;font-size: 12px;'>User : NETFACALL</span> <span  style='position:absolute;right:150px;font-size: 11px;'>System Date: 22-MAY-2012</span><span  style='position:absolute;right:320px;font-size: 11px;'>Current Date: 05-JUN-2012</span></div></td>
</tr>
<tr> 
<td style='height: 1px'></td>
</tr>
<tr>
<td>
<table class='table' border='0' cellpadding='0' cellspacing='0' height='100%' width='100%'>   
<tr>
<td style='height: 1px'></td>
</tr>
<tr>
<td align='left' class='pdn_txtpos2' style='height: 18px' id='help_box'>Factoring - Manual Mail Generation</td>
</tr>
													-->
<tr>
<td  height='10px' class='pdn_txtpos'>
<table class='table' cellpadding='2' cellspacing='2' border='0'> 
<td width='6%' align='center'><input type="button" class='mainbut' onMouseout='load_roll_out_value();' onMouseOver='load_roll_value("Save");'  onClick='Generate_Letter("generate")' value="Save"></td>
<td width='6%' align='center'><input type="button" class='mainbut' onMouseout='load_roll_out_value();' onMouseOver='load_roll_value("Cancel");'  onclick='clear_window()' value="Cancel"></td>
<td width='8%'></td>
<td width='6%' align='center'><input type="button" class='mainbut' onMouseout='load_roll_out_value();' onMouseOver='load_roll_value("Help");' onClick='load_screen_status("HELP")' value="Help"></td>
<td width='6%' align='center'><input type=button name=back value="Close" class=mainbut onClick="location.href='low.jsp'" onMouseOver='load_roll_value("Close");' onmouseout='load_roll_value("Close");'></td>
<TD> <B><div id='help_box' align='right' > </div> </B> </TD>										
<td width='*%' align='right' class='div_input'></td></tr>
</table>
</td></tr><tr>
<td class='line' height='1'></td>
</tr><tr>
<td class='pdn_txtpos' height='150' valign='top'>
<br />
								
								
								
<table align='center' width='100%' border="0" class='table'>
<tr >
<td width='20%' ><DIV id='DIV_TXT_FACILITY_CODE'  class=div_input>Facility Code* </DIV></td>
<td width='40%' ><input class='txt_input' type='text' name='TXT_FACILITY_NO' maxlength='100' size='50' onblur="help_update_facility(0)" >
<input class='but_input' type='button' name='BUT_HELP_MAIN' value="..." onClick="help_update_facility(0)" ><a onClick="help_update_facility('help_facility')" style=' text-decoration: none;cursor: text;' id="help_facility" class="fancylink iframe" href=""></a></td>
<td width='*%'></td>
</tr>
</table>
<br />
<table align='center' width='100%' border="0"class='table'>
<tr>
<td valign="top" width='50%'>
<table id="CLIENT_FACILITY"></table>
</td>
</tr>
</table>
<br />
<table align='center' width='100%' border="0" class='table'>
<tr >
<td width='20%' ><DIV id='DIV_TXT_MAIL_CODE'  class=div_input>Mail Code* </DIV></td>
<td width='40%' ><input class='txt_input' type='text' name='TXT_MAIL_CODE' maxlength='100' size='50' onblur="help_update_mailcode(0)">
<input class='but_input' type='button' name='BUT_HELP_MAIN' value="..." onClick="help_update_mailcode(0)" ><a onClick="help_update_mailcode('help_mailcode')" style=' text-decoration: none;cursor: text;' id="help_mailcode" class="fancylink iframe" href=""></a></td>
<td width='*%'></td>
</tr>
<tr >
<td width='10%' ><DIV id='DIV_TXT_SHOW_PREVIEW'  class=div_input>Show Preview </DIV></td>
<td width='40%' ><input type='checkbox' name='TXT_SHOW_PREVIEW' onclick="Generate_Letter('preview')" ></td>
<td width='*%'></td>
</tr>
</table>
<br>
<table align='center' width='100%'>
<tr>
<td width='100%' class='note'></td>
</tr>
</table>
</form>
	
</body>
</html>
