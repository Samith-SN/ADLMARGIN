  var servlet_client_url="https://dev-adlmargin.sasianet.com";
	var html_client_url="https://dev-adlmargin.sasianet.com/intranet";
  var client_t3_port="8080/myserver/servlet";
	
	function DD(ss){
	qss=ss;
	alert(qss.substr(0,2));
	}

	function display_foffice_rpt(m_deal){
			spcValue="NOV";
			if (m_deal.substring(0,2)=="OR"){
		  	m_url =servlet_client_url+":"+client_t3_port+"/bconfirmprint?chksql=confirm_details&m_identity=VERIFICATION&deal_num="+m_deal+"&spcVal="+spcValue;
				popupwin = window.open(m_url,'displayWindow2','left=50,top=15,width=500,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
        popupwin.focus();
			} 
		  
			else if(m_deal.substring(0,2)=="RF"){	
		 		m_url =servlet_client_url+":"+client_t3_port+"/bconfirmrepo?chksql=confirm_details_repo&m_identity=VERIFICATION&deal_num="+m_deal+"&spcVal="+spcValue;
			  popupwin = window.open(m_url,'displayWindow2','left=50,top=15,width=500,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
        popupwin.focus();
			}
			else if(m_deal.substring(0,2)=="RR"){	
		 		m_url =servlet_client_url+":"+client_t3_port+"/bconfirmrepo?chksql=confirm_details_rollover&m_identity=VERIFICATION&deal_num="+m_deal+"&spcVal="+spcValue;
			  popupwin = window.open(m_url,'displayWindow2','left=50,top=15,width=500,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
        popupwin.focus();
			}
			
			else if(m_deal.substring(0,2)=="SO"){	
		 		m_url =servlet_client_url+":"+client_t3_port+"/bconfirmoutright?chksql=confirm_details_outright&m_identity=VERIFICATION&deal_num="+m_deal+"&spcVal="+spcValue;
			  popupwin = window.open(m_url,'displayWindow2','left=50,top=15,width=500,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
        popupwin.focus();
			}
	    
			else if(m_deal.substring(0,2)=="BF"){	
		 		m_url =servlet_client_url+":"+client_t3_port+"/bconfirmblfund?chksql=confirm_details_blfunds&m_identity=VERIFICATION&deal_num="+m_deal+"&spcVal="+spcValue;
			  popupwin = window.open(m_url,'displayWindow2','left=50,top=15,width=500,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
        popupwin.focus();
			}
	    
			else if(m_deal.substring(0,2)=="BS"){	
		 		m_url =servlet_client_url+":"+client_t3_port+"/bconfirmblfund?chksql=confirm_details_blsecurity&m_identity=VERIFICATION&deal_num="+m_deal+"&spcVal="+spcValue;
			  popupwin = window.open(m_url,'displayWindow2','left=50,top=15,width=500,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
        popupwin.focus();
			}
	    
			else if(m_deal.substring(0,2)=="SR"){	
		 		m_url =servlet_client_url+":"+client_t3_port+"/bconfirmreturnable?chksql=confirm_details_returnable&m_identity=VERIFICATION&deal_num="+m_deal+"&spcVal="+spcValue;
			  popupwin = window.open(m_url,'displayWindow2','left=50,top=15,width=500,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
        popupwin.focus();
			}
	    
			else if(m_deal.substring(0,2)=="RS"){	
		 		m_url =servlet_client_url+":"+client_t3_port+"/confirmrepo_setlle?chksql=confirm_details_reposettle&m_identity=VERIFICATION&deal_num="+m_deal+"&spcVal="+spcValue;
			  popupwin = window.open(m_url,'displayWindow2','left=50,top=15,width=500,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
        popupwin.focus();
		}
		else if(m_deal.substring(0,2)=="IS"){	
		alert("Cannot Drilldown");
		
		}
}

