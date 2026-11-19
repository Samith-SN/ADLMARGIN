var m_arrdata = new Array();
var passing_vals = new Array();

var repo_pass_vals = new Array();
var select_info;

//RF19991104-012
//------------------------------GETTING DEAL DETAILS--------------------------------------------------------------------------------------------------------------------------------------------

function verification_report(obj_dealnum){
	var m_dealnum="";
	var spcValue="";
	//------- upul add this '+"&spcVal="+spcValue;' for each end of the followings on 13/03/2000 --//		
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


			popupwin = window.open(m_url,'displayWindow2','left=50,top=15,width=500,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
      popupwin.focus();
}

function comments_report(obj_dealnum,obj_type){
	var m_dealnum="";
	var spcValue="";
	var m_type="";
	m_type=obj_type;
	//alert(m_type);
	if (obj_dealnum.substring(0,2)=="OR") {
     m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmprint?chksql=comments_details&m_identity="+obj_type+"&deal_num="+obj_dealnum+"&spcVal="+spcValue;
  }
	else if(obj_dealnum.substring(0,2)=="RF") {	
     m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmrepo?chksql=comments_details&m_identity="+obj_type+"&deal_num="+obj_dealnum+"&spcVal="+spcValue;
	}
  else if(obj_dealnum.substring(0,2)=="RR"){	
 		m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmrepo?chksql=comments_details&m_identity="+obj_type+"&deal_num="+obj_dealnum+"&spcVal="+spcValue;
  }
	else if(obj_dealnum.substring(0,2)=="SO"){	
 		m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmoutright?chksql=comments_details&m_identity="+obj_type+"&deal_num="+obj_dealnum+"&spcVal="+spcValue;
  }
  else if(obj_dealnum.substring(0,2)=="BF"){	
 		m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmblfund?chksql=comments_details&m_identity="+obj_type+"&deal_num="+obj_dealnum+"&spcVal="+spcValue;
  }
  else if(obj_dealnum.substring(0,2)=="BS"){	
 		m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmblfund?chksql=comments_details&m_identity="+obj_type+"&deal_num="+obj_dealnum+"&spcVal="+spcValue;
  }
  else if(obj_dealnum.substring(0,2)=="SR"){	
 		m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"bconfirmreturnable?chksql=comments_details&m_identity="+obj_type+"&deal_num="+obj_dealnum+"&spcVal="+spcValue;
  }
  else if(obj_dealnum.substring(0,2)=="RS"){	
 		m_url =servlet_client_url+":"+client_t3_port+"/"+client_name+"confirmrepo_setlle?chksql=comments_details&m_identity="+obj_type+"&deal_num="+obj_dealnum+"&spcVal="+spcValue;
  }
	
	
	popupwin = window.open(m_url,'displayWindow3','left=50,top=15,width=500,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
  popupwin.focus();
}

function comments_save(obj_dealnum,obj_com1,obj_com2,obj_com3) {
	  //m_url=servlet_client_url+":"+client_t3_port+"/fvaldealcomm?chksql=comsave&status=VERIFY&dealno="+obj_dealnum+"&comm1="+obj_comm1.value+"&comm2="+obj_comm2.value+"&comm3="+obj_comm3.value;
	  //location.href=m_url;
	  document.Form2.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"fvaldealcomm?chksql=comsave&status=VERIFY&dealno="+obj_dealnum+"&comm1="+obj_comm1.value+"&comm2="+obj_comm2.value+"&comm3="+obj_comm3.value;
		document.Form2.submit();	
		//document.applets[0].getdata(m_url);
    //if (document.applets[0].outvec_value.elementAt(0)=="ok") {
		//   alert("Comments save Successfully");
    //}
		
}
function beforesubmit2(){
  //alert(document.Form2.HID_DEAL_NO.value);
   //alert(document.Form2.Text_comm1.value);
  //alert(document.Form2.Text_comm2.value);
  //alert(document.Form2.Text_comm3.value);
	alert("Deal Comments Save !!");
 	Form2.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"fsavdealcomm";
	Form2.submit();
}

 //for time log report
 function status_help(dealno)
		  {
			
			 m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mbfsl_reports_timelog?deal_refno="+dealno+"&chksql=disprep";
			 popupwin2 = window.open(m_url,'displayWindow2','left=0,top=190 ,width=700,height=300,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
			 popupwin2.focus();
		 } 	
