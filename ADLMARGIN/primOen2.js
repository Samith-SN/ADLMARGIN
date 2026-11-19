 var pub_val=0;
 var test_fval=-1;
function display_select_repo2(vl1,vl2,vl3){
	m_url_select='dn_primary_auctions_oentry.html';
	m_url=servlet_client_url+":"+client_t3_port+"/bvalprimauction_oentry?chksql=test_val3&cutval="+vl1.value+"&cutval2="+vl2.value+"&cutval3="+vl3.value;
	popupwin = window.open(m_url,'displayWindow3','left=0,top=130,width=450,height=390,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');					
	popupwin.focus();	
}

function test(){
    alert("&&");
    pos=1;
		test_Num="Num"+(pos);
    ab_Num=document.Form1.elements[test_Num];	
    ab_Num=10;
}		
//function cal_Denom(val,fval,pos){
function cal_Denom(fval,pos){
	 ab_fval=fval;
	 
	 test_Den="Den"+(pos);
	 ab_Den=document.Form1.elements[test_Den];	
				
	 test_Num="Num"+(pos);
	 ab_Num=document.Form1.elements[test_Num];	
	
	 test_entitle="FaceVal"+(pos);
	 ab_entitle=document.Form1.elements[test_entitle];
		
	 if(test_fval==-1){
	   test_fval=ab_fval;
   }
		
	 if(ab_Den.value > test_fval){
		 ab_Num.vaue="";
		 ab_entitle.value="";	
	 }	
	 else{
		M_amount=int(test_fval/ab_Den.value);
		ab_Num.vaue=M_amount;
		M_tot=Number(M_amount)*Number(ab_Den.value);
		ab_entitle.value=M_tot;	
		test_fval=test_fval-ab_entitle;
	 }
		pos=pos+1;
}	 
	
	




