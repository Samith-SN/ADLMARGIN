var m_arrdata = new Array();
var passing_vals = new Array();

var repo_pass_vals = new Array();
var select_info;


//------------------------------GETTING DEAL DETAILS--------------------------------------------------------------------------------------------------------------------------------------------

function preconfirm_report(obj_dealnum){
//alert(obj_dealnum);
	var m_dealnum="";
   if ((obj_dealnum.substring(0,2)=="OR")|| (obj_dealnum.substring(0,2)=="GO")){
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

		popupwin = window.open(m_url,'displayWindow2','left=50,top=50,width=500,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
     popupwin.focus();
  }   

function display_details(buyer_name,seller_name,sec_code,val_date,ent_date){ //added By Keith on 7-10-2004/13:43 FOR SN-REF 0409-071 -1PRE CONFIRMATION
	m_url =servlet_client_url+':'+client_t3_port+'/'+client_name+'mvaldeal?buyer_name='+buyer_name+'&seller_name='+seller_name+'&sec_code='+sec_code+'&val_date='+val_date+'&ent_dt='+ent_date+'&chksql=display_deal_details';
	popupwin = window.open(m_url,'displayWindow1','left=50,top=50,width=700,height=200,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
  popupwin.focus();

}


function display_preconfir_details(buyer_name,seller_name,val_date,sell_date){   //added By Manjula on 28/12/2004 FOR SRF 0412-012
	//alert("sec_code"+sec_code);
	m_url =servlet_client_url+':'+client_t3_port+'/'+client_name+'mvaldeal?buyer_name='+buyer_name+'&seller_name='+seller_name+'&val_date='+val_date+'&sell_date='+sell_date+'&chksql=deal_detail_drill';
	popupwin = window.open(m_url,'displayWindow1','left=50,top=50,width=700,height=200,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
  popupwin.focus();

}

function display_preconfir_report(buyer_name,seller_name,val_date,sell_date){   //added By Manjula on 28/12/2004 FOR SRF 0412-012
	//alert("sec_code"+sec_code);
	m_url =servlet_client_url+':'+client_t3_port+'/'+client_name+'mvaldeal?buyer_name='+buyer_name+'&seller_name='+seller_name+'&val_date='+val_date+'&sell_date='+sell_date+'&chksql=display_report';
	popupwin = window.open(m_url,'displayWindow1','left=50,top=50,width=700,height=200,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
  popupwin.focus();

}


function display_ent_cap_diposit_report(saved_no,portfolio){   //added By Manjula on 28/12/2004 FOR SRF 0412-012
	//alert("sec_code"+sec_code);
	m_url =servlet_client_url+':'+client_t3_port+'/'+client_name+'report_portf_charges_save?reci_no='+saved_no+'&port='+portfolio+'&chksql=deposit_temp';
	popupwin = window.open(m_url,'displayWindow1','left=50,top=50,width=700,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
    popupwin.focus();

}


function display_ent_cap_withdr_report(saved_no,portfolio){   //added By Manjula on 28/12/2004 FOR SRF 0412-012
	//alert("sec_code"+sec_code);
	m_url =servlet_client_url+':'+client_t3_port+'/'+client_name+'report_portf_charges_save?reci_no='+saved_no+'&port='+portfolio+'&chksql=with_temp';
	popupwin = window.open(m_url,'displayWindow1','left=50,top=50,width=700,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
    popupwin.focus();

}

function display_client_details_report(portfolio,status){   //added By Manjula on 28/12/2004 FOR SRF 0412-012
	//alert("sec_code"+sec_code);
	m_url =servlet_client_url+':'+client_t3_port+'/'+client_name+'report_portf_charges_save?status='+status+'&port='+portfolio+'&chksql=client_details';
	popupwin = window.open(m_url,'displayWindow1','left=50,top=50,width=700,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
    popupwin.focus();

}

function display_user_details_report(username,status){   //added By Manjula on 28/12/2004 FOR SRF 0412-012
	//alert("sec_code"+sec_code);
	m_url =servlet_client_url+':'+client_t3_port+'/'+client_name+'report_portf_charges_save?status='+status+'&username='+username+'&chksql=user_details';
	popupwin = window.open(m_url,'displayWindow1','left=50,top=50,width=700,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
    popupwin.focus();

}


function display_pending_payment_report(paymentsno,status){   //added By Manjula on 28/12/2004 FOR SRF 0412-012
	//alert("sec_code"+sec_code);
	m_url =servlet_client_url+':'+client_t3_port+'/'+client_name+'report_portf_charges_save?status='+status+'&paymentsno='+paymentsno+'&chksql=pending_payment_details';
	popupwin = window.open(m_url,'displayWindow1','left=50,top=50,width=700,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
    popupwin.focus();

}
