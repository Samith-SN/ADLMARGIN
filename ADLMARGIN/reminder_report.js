	var servlet_client_url="https://dev-adlmargin.sasianet.com";
	var html_client_url="https://dev-adlmargin.sasianet.com/intranet";
  var client_t3_port="8080/myserver/servlet";

	
	
	function display_report(m_buyer,m_tot_face,m_type,m_month,m_year){
  if(m_type=='MAT'){
   m_url=servlet_client_url+":"+client_t3_port+"/val_reminder_report?chksql=get_rpt_mat&buyer="+m_buyer+"&tot_face="+m_tot_face+"&month="+m_month+"&year="+m_year;
	 popupwin2=window.open(m_url,'displaywin2','left=0,top=133,width=799,height=380,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
	}
	else{
   m_url=servlet_client_url+":"+client_t3_port+"/val_reminder_report?chksql=get_rpt_cou&buyer="+m_buyer+"&tot_face="+m_tot_face+"&month="+m_month+"&year="+m_year;
	 popupwin2=window.open(m_url,'displaywin2','left=0,top=133,width=799,height=380,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
	}
	}
	
