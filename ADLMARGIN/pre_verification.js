var m_arrdata = new Array();
var passing_vals = new Array();

var repo_pass_vals = new Array();
var select_info;


//------------------------------GETTING DEAL DETAILS--------------------------------------------------------------------------------------------------------------------------------------------

function preconfirm_report(obj_dealnum){
//alert(obj_dealnum);
	var m_dealnum="";
  var spcValue="";

   if (obj_dealnum.substring(0,2)=="OR"){
		  	m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmprint?chksql=confirm_details&m_identity=VERIFICATION&deal_num="+obj_dealnum+"&spcVal="+spcValue;
      } 
		  else if(obj_dealnum.substring(0,2)=="RF"){	
		 		m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmrepo?chksql=confirm_details_repo&m_identity=VERIFICATION&deal_num="+obj_dealnum+"&spcVal="+spcValue;
  	  }
		  else if(obj_dealnum.substring(0,2)=="RR"){	
		 		m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmrepo?chksql=confirm_details_rollover&m_identity=VERIFICATION&deal_num="+obj_dealnum+"&spcVal="+spcValue;
  	  }
			else if(obj_dealnum.substring(0,2)=="SO"){	
		 		m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmoutright?chksql=confirm_details_outright&m_identity=VERIFICATION&deal_num="+obj_dealnum+"&spcVal="+spcValue;
  	  }
	    else if(obj_dealnum.substring(0,2)=="BF"){	
		 		m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmblfund?chksql=confirm_details_blfunds&m_identity=VERIFICATION&deal_num="+obj_dealnum+"&spcVal="+spcValue;
	    }
	    else if(obj_dealnum.substring(0,2)=="BS"){	
		 		m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmblfund?chksql=confirm_details_blsecurity&m_identity=VERIFICATION&deal_num="+obj_dealnum+"&spcVal="+spcValue;
	    }
	    else if(obj_dealnum.substring(0,2)=="SR"){	
		 		m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmreturnable?chksql=confirm_details_returnable&m_identity=VERIFICATION&deal_num="+obj_dealnum+"&spcVal="+spcValue;
	    }
	    else if(obj_dealnum.substring(0,2)=="RS"){	
		 		m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"confirmrepo_setlle?chksql=confirm_details_reposettle&m_identity=VERIFICATION&deal_num="+obj_dealnum+"&spcVal="+spcValue;
	    }
			else if(obj_dealnum.substring(0,2)=="PI"){	
		 		m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmrepoPI?chksql=confirm_details_repo&m_identity=VERIFICATION&deal_num="+obj_dealnum+"&spcVal="+spcValue;
	    }

		popupwin = window.open(m_url,'displayWindow2','left=50,top=50,width=500,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
     popupwin.focus();
  }   

function display_details(buyer_name,seller_name,sec_code,val_date,ent_date){ 
	m_url =servlet_client_url+':'+client_t3_port+'/'+client_name+'mvaldeal?buyer_name='+buyer_name+'&seller_name='+seller_name+'&sec_code='+sec_code+'&val_date='+val_date+'&ent_dt='+ent_date+'&chksql=display_deal_verify_details';
	popupwin = window.open(m_url,'displayWindow1','left=50,top=50,width=700,height=200,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
  popupwin.focus();

}


function display_preverify_details(buyer_name,seller_name,val_date,sell_date){
	//alert("buyer_name"+buyer_name);
	//alert("seller_name"+seller_name);
	//alert("val_date"+val_date);
	m_url =servlet_client_url+':'+client_t3_port+'/'+client_name+'mvaldeal?buyer_name='+buyer_name+'&seller_name='+seller_name+'&val_date='+val_date+'&sell_date='+sell_date+'&chksql=deal_detail_drill_pre_veryfy';
	popupwin = window.open(m_url,'displayWindow1','left=50,top=50,width=700,height=200,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
  popupwin.focus();

}

function display_preconfir_report(buyer_name,seller_name,val_date,sell_date){  
	//alert("sec_code"+sec_code);
	m_url =servlet_client_url+':'+client_t3_port+'/'+client_name+'mvaldeal?buyer_name='+buyer_name+'&seller_name='+seller_name+'&val_date='+val_date+'&sell_date='+sell_date+'&chksql=display_report_veryfy';
	popupwin = window.open(m_url,'displayWindow1','left=50,top=50,width=700,height=200,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
  popupwin.focus();

}

