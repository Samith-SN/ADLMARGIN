<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/js/popup.js\"></script>");
	out.println("<link rel=\"stylesheet\" type=\"text/css\"  href=\""+m_jsp_client_url+"/css/ui.jqgrid.css\" />");
	
	
	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/tiny_mce/tiny_mce.js\"></script>");
///	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/js/i18n/grid.locale-en.js\"></script>");
//	out.println("<script type=\"text/javascript\" src=\"" + m_jsp_client_url + "/SNET/jquery/grid/js/jquery.jqGrid.min.js\"></script>");
//	out.println("<link rel=\"stylesheet\" type=\"text/css\" media=\""screen"\"  href=\""+m_jsp_client_url+"/SNET/jquery/grid/themes/redmond/jquery-ui-1.7.1.custom.css' />");
	//out.println("<link rel=\"stylesheet\" type=\"text/css\" media=\""screen"\"  href=\""+m_jsp_client_url+"/SNET/jquery/grid/themes/ui.jqgrid.css' />");

%>
<HTML>
<HEAD>
<TITLE>Mail Merge - Mail Template Configuration</TITLE>
<!--		
<script type="text/javascript" src='http://www.netfac.lk/SNET/jquery/fancybox/jquery-1.4.1.min.js'></script>
<script type="text/javascript" src='http://www.netfac.lk/SNET/jquery/fancybox/jquery.fancybox-1.3.0.pack.js'></script>
<link rel="stylesheet" href='http://www.netfac.lk/SNET/jquery/fancybox/jquery.fancybox-1.3.0.css'type='text/css' media="screen">
<link REL='STYLESHEET' HREF='http://www.netfac.lk/SNET/css/Asset_Financing_System.css' TYPE="text/css">
<link rel="stylesheet" type="text/css" media="screen" href='http://www.netfac.lk/SNET/jquery/grid/themes/redmond/jquery-ui-1.7.1.custom.css' />
<link rel="stylesheet" type="text/css" media="screen" href='http://www.netfac.lk/SNET/jquery/grid/themes/ui.jqgrid.css' />
<script src='http://www.netfac.lk/SNET/jquery/grid/js/i18n/grid.locale-en.js' type="text/javascript"></script>
<script src='http://www.netfac.lk/SNET/jquery/grid/js/jquery.jqGrid.min.js' type="text/javascript"></script>
<script type='text/javascript' src='http://www.netfac.lk/SNET/tiny_mce/tiny_mce.js'></script>
		
-->
		<script type="text/javascript" src="validate_v1.js"></script>
        <script type="text/javascript" src="ajax_data_gateway.js"></script> 
<SCRIPT language="JavaScript">
	
	
var isOpen=false;
function clearIsOpen(){;
   isOpen=false;
}
function init_fancybox() { 
 /*  $("a.fancylink").fancybox({
    'hideOnContentClick': false, 'width':404 , 'height': 328,
    'overlayShow': false, 
    'changeSpeed':0, 'speedIn':200, 'speedOut':200,
    'opacity':true,'onClosed' : clearIsOpen, 'centerOnScroll':true, 'easingIn':'swing', 
    'easingOut':'swing' ,transitionIn:'elastic' ,transitionOut:'elastic',
    'type':'iframe','showCloseButton':false,'enableEscapeButton':false
  });*/
}
$(document).ready(function() { 
  ///init_fancybox();
});
$('a').live('click', function() {
 // init_fancybox();
});
	
/*	
function HelpBox(Start,End,Hid_No,link_id) {
     document.getElementById(link_id).href=servlet_client_url+":"+client_t3_port+"/NETFAC_FA_MAS_Help_Servlet?class_in="+client_name+"FA_MAS_help_select"+
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

function setData(data){
    if(document.Form1.hid_help_type.value=="99"){
			help_update_value_assign_99(data);
	  }
}
	*/
	
	
function help_button_1(m_strat) {
	
if(document.Form1.SCREEN_NAME.value=="EDIT" || document.Form1.SCREEN_NAME.value=="DACT"){	
//----pra

		
	var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	
	var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.TXT_MAIL_CODE;
 		myObject[1]=aForm.TXT_MAIL_DESC;
		myObject[2]=aForm.TXT_MAIL_CAT;
	
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
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);	  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
		
		}
	else{
		
		var aForm;    //  aForm =oForm.elements;
     	aForm =  document.getElementById('Form1');
	
	var myObject=new Array(); //return values set to this object
 		myObject[0]=aForm.TXT_MAIL_CODE;
 		myObject[1]=aForm.TXT_MAIL_DESC;
		myObject[2]=aForm.TXT_MAIL_CAT;
	
	var myObject_value=new Array(); //passing values set to this object
 		myObject_value[0]=aForm.TXT_MAIL_CODE.value;
		myObject_value[1]=null;
		myObject_value[2]=null;
	
 
	
	var myObject_type=new Array(); //passing values data type
 		myObject_type[0]="StringL";
 		myObject_type[1]="StringL";
 		myObject_type[2]=null;

 
 		var qid='133';
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
		 onClose: function(){ var returnedValue = this.returnValue; set_return_value(myObject,returnedValue);	  } //alert(' popup:' + returnedValue); window.parent.set_return_value(myObject,returnedValue);
		});
	
	}
}
	
//-----	
/*	
	
	
   if(!isOpen){
      isOpen=true;
      document.Form1.hid_help_type.value="99";
      m_sql = "m_help_TXT_MAIL_CODE_sql";
      if(document.Form1.SCREEN_NAME.value=="EDIT" || document.Form1.SCREEN_NAME.value=="DACT"){ 
          m_criteria = document.Form1.TXT_MAIL_CODE.value+"@"+"Y@"+"NETFACALL@";
      } 
      else{
        m_criteria = document.Form1.TXT_MAIL_CODE.value+"@"+"N@"+"NETFACALL@";
      }
     HelpBox('1','10','0',link_id);
  }
}   */
	
	
	
function help_update_value_assign_99(data) {
    document.Form1.TXT_MAIL_CODE.value=data.colomn_2;
    document.Form1.TXT_MAIL_DESC.value=data.colomn_3;
    document.Form1.TXT_MAIL_CAT.value=data.colomn_4;
    document.Form1.TXT_TEMP_DOC.value="";
    if (data.colomn_4!="PRE") {
    	document.Form1.TXT_MAIL_CAT.value="OTHER" ;
   }
     tinyMCE.activeEditor.setContent(''); 
    if (document.Form1.TXT_MAIL_CAT.value!="PRE") {
  		m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"FA_CR_get_letter?chkName="+document.Form1.TXT_MAIL_CODE.value+"";
  		load_interface(m_url,'NO');
   }
	            if(document.Form1.TXT_MAIL_CODE.value!=''){
	                assignState('M12');
	                makeRequest(document.Form1.TXT_MAIL_CODE) ;
	            }
}
function clear_fields() {
 	if(document.Form1.hid_help_type.value=="99"){
 		document.Form1.TXT_MAIL_CODE.value='';
 		document.Form1.TXT_MAIL_CODE.focus() ;
 		document.Form1.TXT_MAIL_DESC.value='';
 		document.Form1.TXT_MAIL_CAT.value='';
       document.Form1.TXT_TEMP_DOC.value="";
       tinyMCE.activeEditor.setContent(''); 
 	}
}
tinyMCE.init({
mode : 'textareas',
mode : 'exact',
elements : 'elm1',
width : '100%',
height : '575',
theme : "advanced",
pagebreak_separator : ' <P style="page-break-after: always"></p> ',
skin : 'o2k7',
skin_variant : 'silver',
plugins : "-FiledList,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template,wordcount,advlist",
theme_advanced_buttons1 : "save,newdocument,|,bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,styleselect,formatselect,fontselect,fontsizeselect",
theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,pagebreak,fieldlist,",
theme_advanced_toolbar_location : "top",
theme_advanced_toolbar_align : "left",
theme_advanced_statusbar_location : "bottom",
save_onsavecallback : "save_window",
autosave_ask_before_unload : false,
theme_advanced_resizing : true,
content_css : "css/content.css",
template_external_list_url : "lists/template_list.js",
external_link_list_url : "lists/link_list.js",
external_image_list_url : "lists/image_list.js",
media_external_list_url : "lists/media_list.js",
style_formats : [
{title : 'Bold text', inline : 'b'},
{title : 'Red text', inline : 'span', styles : {color : '#ff0000'}},
{title : 'Red header', block : 'h1', styles : {color : '#ff0000'}},
{title : 'Example 1', inline : 'span', classes : 'example1'},
{title : 'Example 2', inline : 'span', classes : 'example2'},
{title : 'Table styles'},
{title : 'Table row 1', selector : 'tr', classes : 'tablerow1'}
],
template_replace_values : {
username : "Some User",
staffid : "991234"
}
});
var mlb;
tinymce.create('tinymce.plugins.FiledListPlugin', {
createControl: function(n, cm) {
switch (n) {
case 'fieldlist':
  mlb = cm.createListBox('fieldlist', {
title : 'Select a Field',
onselect : function(v) {
setTimeout(function(){tinyMCE.execCommand('mceInsertContent',false,'<b>'+v+'</b>')},500)
}
});
assignState('M15');
makeRequest(document.Form1.TXT_MAIL_CAT) ;
return mlb;
return  null;
}
}
});
tinymce.PluginManager.add('FiledList', tinymce.plugins.FiledListPlugin);
function get_vector(data_vec) {
	
//	alert('hhhhh');
	if(document.Form1.hid_chk_status.value=='M6' && data_vec.length>0){
   	document.Form1.hid_c_status.value="Y";
    }
		    else if(data_vec.length>0 && document.Form1.SCREEN_NAME.value=="NEW" && document.Form1.hid_chk_status.value=='M1'){
				alert('Record already exists.');
               document.Form1.TXT_MAIL_CODE.value="" ; 
               document.Form1.TXT_MAIL_CODE.focus(); 
			}
			else
			if(data_vec.length > 0 && document.Form1.SCREEN_NAME.value!="NEW" && document.Form1.hid_chk_status.value=='M12'){
				set_group_data(data_vec);
			}
			else
			if(data_vec.length > 0 && document.Form1.hid_chk_status.value=='M15'){
			//	alert('fffff');set_function_list(data_vec);
				
			}
}
function makeRequest(obj) {
if((document.Form1.hid_chk_status.value=='M1' && document.Form1.SCREEN_NAME.value!="RACT") && (document.Form1.hid_chk_status.value=='M1' && document.Form1.SCREEN_NAME.value!="NEW"))
m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"AF_MAS_sql_validations?chksql=m_prime_chk_NETFAC_AF_MAS_display_team&data_val="+obj.value+"&ac_status=Y";
else
if(document.Form1.hid_chk_status.value=='M1' && document.Form1.SCREEN_NAME.value =="NEW")
 	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"FA_MM_sql_validations?chksql=m_prime_chk_LBMARGIN_FA_MAS_display_mail_merge&data_val="+obj.value;
else
if(document.Form1.hid_chk_status.value=='M1' && document.Form1.SCREEN_NAME.value=="RACT")
m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"AF_MAS_sql_validations?chksql=m_prime_chk_NETFAC_AF_MAS_display_team&data_val="+obj.value+"&ac_status=N";
else
if(document.Form1.hid_chk_status.value=='M2')
m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"AF_MAS_sql_validations?chksql=m_prime_chk_NETFAC_AF_MAS_display_division&data_val="+obj.value+"&ac_status=Y";
else
  if(document.Form1.hid_chk_status.value=='M12')
     m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"FA_MM_sql_validations?chksql=m_prime_chk_group_det&data_val="+obj.value;
else
  if(document.Form1.hid_chk_status.value=='M15')
			//alert('222222');
     m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"FA_MM_sql_validations?chksql=m_get_function_list&data_val="+obj.value;
	 //alert(m_url);
	// window.open(m_url);
	
	// load_interface(m_url,'XML');
	load_interface(m_url,'XML',false);
	m_size = data_vec.length;
	
	if(m_size>0){	
				
		set_function_list(data_vec);
		
			}
			else{
			}
	
	
}
function assignState(val){ 
document.Form1.hid_chk_status.value=val
}
function validate_data(){
document.getElementById('DIV_TXT_MAIL_CODE').style.color='black';
document.getElementById('DIV_TXT_MAIL_DESC').style.color='black';
document.getElementById('DIV_TXT_MAIL_CAT').style.color='black';
document.getElementById('DIV_TXT_DOC_UPLOAD').style.color='black';
if(document.Form1.TXT_MAIL_CODE.value==""){  
document.getElementById('DIV_TXT_MAIL_CODE').style.color='red';
		alert("Please enter all required fields marked with a '*' on screen."); 
return false;
}
else if(document.Form1.TXT_MAIL_DESC.value==""){  
document.getElementById('DIV_TXT_MAIL_DESC').style.color='red';
		alert("Please enter all required fields marked with a '*' on screen."); 
return false;
}
else if(document.Form1.TXT_MAIL_CAT.value==""){  
document.getElementById('DIV_TXT_MAIL_CAT').style.color='red';
		alert("Please enter all required fields marked with a '*' on screen."); 
return false;
}
else if(document.Form1.TXT_TEMP_DOC.value=="" && document.Form1.TXT_MAIL_CAT.value=="PRE" ){  
document.getElementById('DIV_TXT_DOC_UPLOAD').style.color='red';
		alert("Please enter all required fields marked with a '*' on screen."); 
return false;
}
else{
return true;
}
}
function before_submit(){ 
m_option = document.Form1.hid_status.value;
if(m_option=='New') {
m_sav_msg = 'Are you sure you want to Save?'; 
		}
else if(m_option=='Edit') {
m_sav_msg = 'Are you sure you want to Modify?'; 
		}
else if(m_option=='Deactivate') {
m_sav_msg = 'Are you sure you want to Deactivate?'; 
		}
else if(m_option=='Reactivate') {
m_sav_msg = 'Are you sure you want to Reactivate?'; 
		}
		if(validate_data()){
		if(confirm(m_sav_msg)){ 
		if(validate_data()){
     for (var i=0; i < document.Form1.elements.length; i++ ) {
	//	alert('ssss');
      document.Form1.elements[i].disabled=false;
     }
     document.Form1.elm.value=tinyMCE.get('elm1').getContent()
		document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"FA_MM_save_template";
		document.Form1.submit();	
		}
		}
		}
} 
function clear_window(){	
		if(confirm("Are you sure you want to clear the screen?")){
	//	if(document.Form1.SCREEN_NAME.value=="NEW"){	
			
		location.href='dn_mm_mail_template.jsp'
	//	}
	//		else if(document.Form1.SCREEN_NAME.value=="EDIT"){	
			//	location.href='dn_mm_mail_template.jsp'
			//	load_screen_status("EDIT");
//			}
				
		}
}
function new_window(){	
	location.href='dn_mm_mail_template.jsp'

}


function save_window(){	
before_submit();
}

function load_help_msg() {
    m_help_message = "m_help_msg_Mail_Merge";
    HelpBox_msg(m_help_message);
}
function HelpBox_msg(m_help_message) {
	popupwin = window.showModalDialog(servlet_client_url+":"+client_t3_port+"/"+client_name+"AF_MAS_Help_Msg_Servlet?class_in="+client_name+"AF_MAS_Help_Msg_select"+
  "&help_message_in="+m_help_message);
}
function load_roll_value(m_val){
document.getElementById('help_box').innerHTML=" Configuration  "+m_val;
}

function load_roll_out_value(){
document.getElementById('help_box').innerHTML=" Configuration  "+document.Form1.hid_status.value;
}
function load_screen_status(m_val){
if(m_val=="NEW"){
new_window();
document.Form1.BUT_HELP_MAIN.disabled=true;}
else if(m_val=="HELP"){
load_help_msg();
}
else if(m_val!="EDIT"){
document.Form1.BUT_HELP_MAIN.disabled=false;
document.Form1.TXT_MAIL_DESC.disabled=true;
document.Form1.TXT_MAIL_CAT.disabled=true;
document.Form1.elm1.disabled=true;
}
else{
document.Form1.BUT_HELP_MAIN.disabled=false;}
document.Form1.SCREEN_NAME.value=m_val;
if(m_val=="NEW"){
document.Form1.hid_status.value="New";
}else if(m_val=="EDIT"){
document.Form1.hid_status.value="Edit";
}else if(m_val=="DACT"){
document.Form1.hid_status.value="Deactivate";
}else if(m_val=="RACT"){
document.Form1.hid_status.value="Reactivate";
}else{
document.Form1.hid_status.value="";
}
}
function get_vector_normal(data_vec){
 tinyMCE.activeEditor.setContent(data_vec);
}
 function Close(){
clear_data()	
 }
function init_help_view() { 
 /*  $("a.helpview").fancybox({
    'hideOnContentClick': false, 'width':750 , 'height': 400,
    'overlayShow': true, 
    'changeSpeed':0, 'speedIn':200, 'speedOut':200,
    'opacity':true,'onClosed' : clearIsOpen, 'centerOnScroll':true, 'easingIn':'swing', 
    'easingOut':'swing' ,transitionIn:'elastic' ,transitionOut:'elastic',
    'type':'iframe','showCloseButton':true,'enableEscapeButton':true,'modal':false,'overlayOpacity':0.1
  });*/
}
$(document).ready(function() { 
 // init_help_view();
});
$('a').live('click', function() {
  init_help_view();
}); 
function HelpView(Start,End,Hid_No,link_view_id) {
     document.getElementById(link_view_id).href=servlet_client_url+":"+client_t3_port+"/NETFAC_FA_MAS_View_Help_Servlet?class_in="+client_name+"FA_MAS_View_help_select"+
    "&Sql_in="+m_sql+"&Start_in="+Start+
    "&End_in="+End+"&Crit_In="+m_criteria+
    "&Hid_No="+Hid_No+"&link_id="+link_view_id;
    $("#"+link_view_id).trigger("click");
}
function viewPrev(Start,End,Hid_No,link_view_id){
	HelpView(Start,End,Hid_No,link_view_id);
}
function viewNext (Start,End,Hid_No,link_view_id){
	HelpView(Start,End,Hid_No,link_view_id);
}
function help_view_Check(valout,Hid_No,link_view_id){
	if(valout[1]=="Next"){
		viewNext(valout[2],valout[3],Hid_No,link_view_id);
	} 
	else if(valout[1]=="Prev"){
		viewPrev(valout[2],valout[3],Hid_No,link_view_id);
	}	
}  
function View_all(link_id){
   if(!isOpen){
      isOpen=true;
    m_sql = "m_view_TXT_MAIL_MERGE_sql";
    m_criteria = document.Form1.TXT_MAIL_CODE.value+"@"+"Y@";
    HelpView('1',50,'0',link_id);
   }
}
function selectText(val) {
 if (window.getSelection)  window.getSelection().removeAllRanges();
 else if (document.selection) document.selection.empty();
 if (document.selection) {
    var range = document.body.createTextRange();
    range.moveToElementText(document.getElementById(val));
    range.select();
 }
 else if (window.getSelection) {
    var range = document.createRange();
    range.selectNode(document.getElementById(val));
    window.getSelection().addRange(range);
  }
}
function load_group_list(){
   m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"FA_MM_sql_validations?q=1&chksql=REQ_GROUP_LIST";
jQuery("#USER_GROUPS").jqGrid(
{
url:m_url,
loadonce: 1,
datatype: "xml",
colNames:['User Group','Select'],
colModel:[ {name:'USER_GROUP',index:'USER_GROUP', sortable:false,width:230,align:"left"},
{name:'SELECT',index:'SELECT', width:115, align:"center",sortable:false,formatter:checkboxfmatter}],
rowNum:-1,
gridview: true,
height: 'auto',
gridComplete: function () {
var rec_count=$("#USER_GROUPS").jqGrid('getGridParam',"records");
document.Form1.hid_no_rec.value=rec_count;
},
caption:"User Profile Access Control" 
}
);
}
function checkboxfmatter (cellvalue, options, rowObject)
{
var rowid=rowObject.getAttribute('id');
	 var link ='<input type="checkbox" id="TXT_GROUP_'+cellvalue+'"  name="TXT_GROUP_'+cellvalue+'"  value="'+rowid+'" />'; 
return link;
}
function check_change(row,val) {
  chk="TXT_GROUP_"+row;
   if(document.Form1.elements[chk].checked==false){
    document.Form1.elements[chk].value="N_"+val;
		}
		if(document.Form1.elements[chk].checked==true){
    document.Form1.elements[chk].value="Y_"+val;
		}
}
 function set_group_data(data_vec){
   var count = document.Form1.hid_no_rec.value;
 	 for(var i=1;i<=count;i++){
 	   for(var j=0;j<data_vec.length;j++){
        if(document.getElementById('TXT_GROUP_'+i).value==data_vec[j]){
    	     document.getElementById('TXT_GROUP_'+i).checked=true; 
  	    }
  	  }
  	 }
}
 function set_function_list(data_vec){
   var count = data_vec.length;
 	 for(var i=0;i<count;i=i+2){
   	mlb.add(data_vec[i+1], data_vec[i]);
  	 }
}
</script>
</HEAD>
<BODY class='body & txt-body' leftmargin='0' topmargin='0' marginwidth='0' ONLOAD="load_roll_value('New')">
<FORM NAME='Form1' ID="Form1" method='post' enctype = "multipart/form-data">
<input  type='hidden' value='NEW' name='SCREEN_NAME'> 
<INPUT TYPE='Hidden' NAME='hid_help_type' VALUE="">
<INPUT TYPE='Hidden' NAME='hid_status' VALUE="New">
<INPUT TYPE='Hidden' NAME='hid_chk_status' VALUE="">
<INPUT TYPE='Hidden' NAME='hid_c_status' VALUE="N">
<INPUT TYPE='Hidden' NAME='hid_no_rec' VALUE="0">
			

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
<!--<tr>
<td width='8' valign='top'></td>
<td class='border_wht' valign='top'> 
<table class='table' width='100%' border='0' cellspacing='0' cellpadding='0' height='100%'>
<tr> 
<td height='30' class='pdn_mainHD'><div><span>Asset Financing System Version</span><span style='position:absolute;right:30px;font-size: 12px;'>User : NETFACALL</span> <span  style='position:absolute;right:150px;font-size: 11px;'>System Date: 22-MAY-2012</span><span  style='position:absolute;right:320px;font-size: 11px;'>Current Date: 05-JUN-2012</span></div></td>
</tr>
<tr> 
<td height='1'></td>
</tr>
<tr>
<td>
<table class='table' border='0' cellpadding='0' cellspacing='0' height='100%' width='100%'>   
<tr>
<td height='1'></td>
</tr>
<tr>
<td align='left' class='pdn_txtpos2' style='height: 18px' id='help_box'>Mail Template Configuration </td>
</tr>  -->
<tr>
<td  height='10px' class='pdn_txtpos'>
<table class='table' cellpadding='1' cellspacing='1' border='0'> 
<tr><td width='3%' align='center'><input type="button" class='mainbut' onMouseout='load_roll_out_value();' onMouseOver='load_roll_value("New");' onclick='load_screen_status("NEW")' value="New"></td>
<td width='3%' align='center'><input type="button" class='mainbut' onMouseout='load_roll_out_value();' onMouseOver='load_roll_value("Edit");' onClick='load_screen_status("EDIT")' value="Edit"></td>
<td width='3%' align='center'><input type="button" class='mainbut' onMouseout='load_roll_out_value();' onMouseOver='load_roll_value("Deactivate");' onClick='load_screen_status("DACT")' value="Deactivate"></td>
<td width='3%' align='center'><input type="button" class='mainbut' onMouseout='load_roll_out_value();' onMouseOver='load_roll_value("Reactivate");' onClick='load_screen_status("RACT")' value="Reactivate"></td>
<td width='3%' align='center'><input type="button" class='mainbut' onMouseout='load_roll_out_value();' onMouseOver='load_roll_value("View All");'  onclick="View_all('view_all')" value="View All"><a onClick="View_all('view_all')" style=' text-decoration: none;cursor: text;' id="view_all" class="helpview iframe" href=""></a></td>
<td width='3%'></td>
<td width='3%' align='center'><input type="button" class='mainbut' onMouseout='load_roll_out_value();' onMouseOver='load_roll_value("Save");'  onClick='save_window()' value="Save"></td>
<td width='3%' align='center'><input type="button" class='mainbut' onMouseout='load_roll_out_value();' onMouseOver='load_roll_value("Help");' onClick='load_screen_status("HELP")' value="Help"></td>
<td width='3%' align='center'><input type="button" class='mainbut' onMouseout='load_roll_out_value();' onMouseOver='load_roll_value("Cancel");'  onclick='clear_window()' value="Cancel"></td>
<td width='3%' align='center'><input type=button name=back value="Close" class= mainbut  onClick="location.href='low.jsp'" onMouseOver='load_roll_value("Close");' onmouseout='load_roll_value("Close");'></td>
<TD> <B><div id='help_box' align='right' > </div> </B> </TD>
<td width='*%' align='right' class='div_input'></td></tr>

										
<!--<tr>
<td align='left' class='pdn_txtpos2' style='height: 18px' id='help_box'>Mail Template Configuration </td>
</tr> -->
										
</table>
															
<!----------------------------->
			 <TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
			<HR>
				<TABLE WIDTH="100%"  >
				<tr height='25px;'></tr>
				</TABLE>
<!----------------------------->															
															
															
															
</td></tr><tr>
<td class='line' height='1'><img height='1' src='spacer.gif' width='1' /></td>
</tr><tr>
<td class='pdn_txtpos' height='150' valign='top'>
<br />
<table align='center' width='100%' class='table'>
<tr >
<td width='14%' ><DIV id='DIV_TXT_MAIL_CODE'  class=div_input>Mail Code *</DIV></td>
<td width='40%' ><input class='txt_input' type='text' name='TXT_MAIL_CODE' maxlength='10' size='10' onBlur="assignState('M1'),makeRequest(document.Form1.TXT_MAIL_CODE)">
<input class='but_input' type='button' name='BUT_HELP_MAIN' value="..." onClick="help_button_1(0)" disabled><a onClick="help_button_1('help_temp')" style=' text-decoration: none;cursor: text;' id="help_temp" class="fancylink iframe" href=""></a></td>
<td width='*%'></td>
</tr>
<tr >
<td width='14%' ><DIV id='DIV_TXT_MAIL_DESC'  class=div_input>Letter Description *</DIV></td>
<td width='40%' ><input class='txt_input' type='text' name='TXT_MAIL_DESC' maxlength='50' size='20'></td>
<td width='*%'></td>
</tr>
<tr >
<td width='14%' ><DIV id='DIV_TXT_MAIL_CAT'  class=div_input>Mail Category *</DIV></td>
<td width='40%' ><input class='txt_input' type='text' name='TXT_MAIL_CAT' maxlength='30' size='20'></td>
<td width='*%'></td>
</tr>
<tr >
<td width='14%' ><DIV id='DIV_TXT_DOC_UPLOAD'  class=div_input>Pre - Define Template </DIV></td>
<td width='40%' ><input class = "txt_input" type = "file" name = "TXT_TEMP_DOC" id = "TXT_TEMP_DOC" style = "width: 200;" /></td></td>
<td width='*%'></td>
</tr>
</table>
<br />
<hr />
<br />
<table align='center' width='100%' class='table'>
<tr>
<td width='95%' ><textarea id='elm1' name='elm1' rows='15' cols='80' style='width: 100%' class='txt_input'></textarea></td>
<td width='*%' ><textarea id='elm' name='elm' style='display:none;' rows='100' cols='80' style='width: 80%' class='txt_input'></textarea></td>
</tr>
</table>
<br>
<br />
<br />
<div>
<table id="USER_GROUPS"></table>
</div>
<br />
<table align='center' width='100%'>
<tr>
<td width='100%' class='note'></td>
</tr>
</table>
</form>

</body>
</html>
