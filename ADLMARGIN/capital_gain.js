	var servlet_client_url="https://dev-adlmargin.sasianet.com";
	var html_client_url="https://dev-adlmargin.sasianet.com/intranet";
  var client_t3_port="8080/myserver/servlet";
  var client_name="LBMARGIN_";

	
	
	function display_data2(m_deal_obj){
	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"capital_gain_report_main2?deal="+m_deal_obj+"&lic_code="+window.opener.parent.frames[1].document.Form1.TXT_LIC.value+"&port="+window.opener.parent.frames[1].document.Form1.TXT_PORT.value+"&chksql=detail_capgain10";
	popupwin = window.open(m_url,'displayWindow72','left=2,top=157,width=784,height=375,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1');
	popupwin.focus();
	}
	
	function display_data3(m_deal_obj){
	if(window.opener.parent.frames[1].document.Form1.TXT_PORT.value==""){
	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"capital_gain_report_main2?deal="+m_deal_obj+"&mdate_from="+window.opener.parent.frames[1].document.Form1.TXT_DATE_FROM.value+'-'+window.opener.parent.frames[1].document.Form1.TXT_MONTH_FROM.value+'-'+window.opener.parent.frames[1].document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+window.opener.parent.frames[1].document.Form1.TXT_DATE_TO.value+'-'+window.opener.parent.frames[1].document.Form1.TXT_MONTH_TO.value+'-'+window.opener.parent.frames[1].document.Form1.TXT_YEAR_TO.value+"&port=ALL&chksql=detail_capgain";
	}
	else{
	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"capital_gain_report_main2?deal="+m_deal_obj+"&mdate_from="+window.opener.parent.frames[1].document.Form1.TXT_DATE_FROM.value+'-'+window.opener.parent.frames[1].document.Form1.TXT_MONTH_FROM.value+'-'+window.opener.parent.frames[1].document.Form1.TXT_YEAR_FROM.value+"&mdate_to="+window.opener.parent.frames[1].document.Form1.TXT_DATE_TO.value+'-'+window.opener.parent.frames[1].document.Form1.TXT_MONTH_TO.value+'-'+window.opener.parent.frames[1].document.Form1.TXT_YEAR_TO.value+"&port="+window.opener.parent.frames[1].document.Form1.TXT_PORT.value+"&chksql=detail_capgain";
	}
	popupwin = window.open(m_url,'displayWindow72','left=2,top=157,width=784,height=375,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1');
	popupwin.focus();
	}

