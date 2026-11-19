  var servlet_client_url="https://dev-adlmargin.sasianet.com";
	var html_client_url="https://dev-adlmargin.sasianet.com/intranet";
  var client_t3_port="8080/myserver/servlet";

	function display_foffice_rpt(m_deal){
			if (m_deal.substring(0,2)=="OR"){
		  	m_url =servlet_client_url+":"+client_t3_port+"/sysmonitor_foffice_rpt1?deal="+m_deal+"&m_identity=VERIFICATION&chksql=foffice_rpt_or";
			  popupwin = window.open(m_url,'displayWindow2','left=50,top=15,width=500,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
        popupwin.focus();
			} 
		  
			else if(m_deal.substring(0,2)=="RF"){	
		 		m_url =servlet_client_url+":"+client_t3_port+"/sysmonitor_foffice_rpt2?deal="+m_deal+"&m_identity=VERIFICATION&chksql=foffice_rpt_rf";
			  popupwin = window.open(m_url,'displayWindow2','left=50,top=15,width=500,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
        popupwin.focus();
			}
			else if(m_deal.substring(0,2)=="RR"){	
		 		m_url =servlet_client_url+":"+client_t3_port+"/sysmonitor_foffice_rpt2?deal="+m_deal+"&m_identity=VERIFICATION&chksql=foffice_rpt_rr";
			  popupwin = window.open(m_url,'displayWindow2','left=50,top=15,width=500,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
        popupwin.focus();
			}
			
			else if(m_deal.substring(0,2)=="SO"){	
		 		m_url =servlet_client_url+":"+client_t3_port+"/sysmonitor_foffice_rpt3?deal="+m_deal+"&m_identity=VERIFICATION&chksql=foffice_rpt_so";
			  popupwin = window.open(m_url,'displayWindow2','left=50,top=15,width=500,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
        popupwin.focus();
			}
	    
			else if(m_deal.substring(0,2)=="BF"){	
		 		m_url =servlet_client_url+":"+client_t3_port+"/sysmonitor_foffice_rpt4?deal="+m_deal+"&m_identity=VERIFICATION&chksql=foffice_rpt_bf";
			  popupwin = window.open(m_url,'displayWindow2','left=50,top=15,width=500,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
        popupwin.focus();
			}
	    
			else if(m_deal.substring(0,2)=="BS"){	
		 		m_url =servlet_client_url+":"+client_t3_port+"/sysmonitor_foffice_rpt4?deal="+m_deal+"&m_identity=VERIFICATION&chksql=foffice_rpt_bs";
			  popupwin = window.open(m_url,'displayWindow2','left=50,top=15,width=500,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
        popupwin.focus();
			}
	    
			else if(m_deal.substring(0,2)=="SR"){	
		 		m_url =servlet_client_url+":"+client_t3_port+"/sysmonitor_foffice_rpt5?deal="+m_deal+"&m_identity=VERIFICATION&chksql=foffice_rpt_sr";
			  popupwin = window.open(m_url,'displayWindow2','left=50,top=15,width=500,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
        popupwin.focus();
			}
	    
			else if(m_deal.substring(0,2)=="RS"){	
		 		m_url =servlet_client_url+":"+client_t3_port+"/sysmonitor_foffice_rpt6?deal="+m_deal+"&m_identity=VERIFICATION&chksql=foffice_rpt_rs";
			  popupwin = window.open(m_url,'displayWindow2','left=50,top=15,width=500,height=500,toolbar=0,location=0,left=150,top=80,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
        popupwin.focus();
		}
		else if(m_deal.substring(0,2)=="IS"){	
		alert("Cannot Drilldown");
		
		}
}

