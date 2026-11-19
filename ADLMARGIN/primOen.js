 var pub_val=0;
function display_select_repo(vl1,vl2){
	m_url_select='dn_primary_auctions_oentry.html';
	m_cus="CUST1";
	m_url=servlet_client_url+":"+client_t3_port+"/bvalprimauction_oentry?chksql=test_val1&cutval="+vl1.value+"&cutval2="+vl2.value;
  popupwin = window.open(m_url,'displayWindow1','left=0,top=130,width=450,height=390,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');					
  popupwin.focus();	
}


function val_NoDenom(val,pos,jnam){
 ab_Denom=val;
 test_Num="Num"+(pos);
 ab_Num=document.Form1.elements[test_Num];
 
 test_entitle="FaceVal"+(pos);
 ab_entitle=document.Form1.elements[test_entitle];
	
 m_tot=Number(ab_Denom) * Number(ab_Num.value);
	
 ab_entitle.value=m_tot;
 m_tot2=Number(jnam) + Number(m_tot);
 document.Form1.Summ.value=m_tot2;
}

