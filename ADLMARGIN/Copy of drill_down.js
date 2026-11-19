	var servlet_client_url="https://dev-adlmargin.sasianet.com";
	var html_client_url="https://dev-adlmargin.sasianet.com";
   var client_t3_port="8080/myserver/servlet";
   var client_name ="LBMARGIN_"; 
	var m_refno=null;
	function display_profit_det(m_acctype,m_acode1,m_acode2,m_acode3,m_acode4,m_from_dd,m_from_mm,m_from_yy,m_to_dd,m_to_mm,m_to_yy) {
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"webrptpro_lost_account_v1?chksql=details"+
																									 "&acctype="+m_acctype+
																									 "&acode1="+m_acode1+
																									 "&acode2="+m_acode2+
																									 "&acode3="+m_acode3+
																									 "&acode4="+m_acode4+
																									 "&from_date="+m_from_dd+
																									 "&from_month="+m_from_mm+
																									 "&from_year="+m_from_yy+
																									 "&to_date="+m_to_dd+
																									 "&to_month="+m_to_mm+
																									 "&to_year="+m_to_yy;
			popupwin3 = window.open(m_url,'displayWindow3','left=100,top=125,width=600,height=350,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
			//popupwin3 = window.open(m_url,'displayWindow3','left=75,top=75,width=650,height=450,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
			popupwin3.focus();
			//alert("1123");
		}	
		
		function display_acc_det(m_acctype,m_acode1,m_acode2,m_acode3,m_acode4,m_from_dd,m_from_mm,m_from_yy,m_to_dd,m_to_mm,m_to_yy) {
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"webrptpro_lost_account_v1?chksql=details"+
																									 "&acctype="+m_acctype+
																									 "&acode1="+m_acode1+
																									 "&acode2="+m_acode2+
																									 "&acode3="+m_acode3+
																									 "&acode4="+m_acode4+
																									 "&from_date="+m_from_dd+
																									 "&from_month="+m_from_mm+
																									 "&from_year="+m_from_yy+
																									 "&to_date="+m_to_dd+
																									 "&to_month="+m_to_mm+
																									 "&to_year="+m_to_yy;
			popupwin3 = window.open(m_url,'displayWindow3','left=100,top=125,width=600,height=350,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
			popupwin3.focus();
		}	
		
		function display_acc_det_1(m_acctype,m_acode1,m_acode2,m_acode3,m_acode4,m_from_dd,m_from_mm,m_from_yy,m_to_dd,m_to_mm,m_to_yy) {
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mllrptpro_lost_account?chksql=details"+
																									 "&acctype="+m_acctype+
																									 "&acode1="+m_acode1+
																									 "&acode2="+m_acode2+
																									 "&acode3="+m_acode3+
																									 "&acode4="+m_acode4+
																									 "&from_date="+m_from_dd+
																									 "&from_month="+m_from_mm+
																									 "&from_year="+m_from_yy+
																									 "&to_date="+m_to_dd+
																									 "&to_month="+m_to_mm+
																									 "&to_year="+m_to_yy;
			popupwin3 = window.open(m_url,'displayWindow3','left=100,top=125,width=600,height=350,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
			//popupwin3 = window.open(m_url,'displayWindow3','left=75,top=75,width=650,height=450,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
			popupwin3.focus();
			//alert("1123");
		}		
	
		function balance_acc_det(m_acctype,m_acode1,m_acode2,m_acode3,m_acode4,m_from_dd,m_from_mm,m_from_yy) {
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"webrptbalance_sheet?chksql=details"+
																									 "&acctype="+m_acctype+
																									 "&acode1="+m_acode1+
																									 "&acode2="+m_acode2+
																									 "&acode3="+m_acode3+
																									 "&acode4="+m_acode4+
																									 "&val_date="+m_from_dd+
																									 "&val_month="+m_from_mm+
																									 "&val_year="+m_from_yy;
			popupwin3 = window.open(m_url,'displayWindow3','left=100,top=125,width=600,height=350,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
			popupwin3.focus();
		}		
		
		function cashflow_acc_det(m_acctype,m_acode1,m_acode2,m_acode3,m_acode4,m_from_dd,m_from_mm,m_from_yy,m_to_dd,m_to_mm,m_to_yy) {
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"webrptcash_flow?chksql=details"+
																									 "&acctype="+m_acctype+
																							    	 "&acode1="+m_acode1+
																									 "&acode2="+m_acode2+
																									 "&acode3="+m_acode3+
																									 "&acode4="+m_acode4+
																									 "&from_date="+m_from_dd+
																									 "&from_month="+m_from_mm+
																									 "&from_year="+m_from_yy+
																									 "&to_date="+m_to_dd+
																									 "&to_month="+m_to_mm+
																									 "&to_year="+m_to_yy;
			popupwin3 = window.open(m_url,'displayWindow3','left=100,top=125,width=600,height=350,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
			popupwin3.focus();
		}		
	
	
		function display_divacc_det(m_acctype,m_acode1,m_acode2,m_acode3,m_acode4,m_from_dd,m_from_mm,m_from_yy,m_to_dd,m_to_mm,m_to_yy) {
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mlldivpro_lost_account?chksql=details"+
																									 "&acctype="+m_acctype+
																									 "&acode1="+m_acode1+
																									 "&acode2="+m_acode2+
																									 "&acode3="+m_acode3+
																									 "&acode4="+m_acode4+
																									 "&from_date="+m_from_dd+
																									 "&from_month="+m_from_mm+
																									 "&from_year="+m_from_yy+
																									 "&to_date="+m_to_dd+
																									 "&to_month="+m_to_mm+
																									 "&to_year="+m_to_yy;
			popupwin3 = window.open(m_url,'displayWindow4','left=100,top=125,width=600,height=350,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
			//popupwin3 = window.open(m_url,'displayWindow3','left=75,top=75,width=650,height=450,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
			popupwin3.focus();
			//alert("1123");
		}		
		
		function display_doc_det(m_acctype,m_docref) {
     //alert("m_acctype,m_docref"+m_acctype+m_docref);
			m_url="";
 //if (m_docref.substring(0,2)=="JE"||(m_docref.substring(0,2)=="VC")||(m_docref.substring(0,2)=="VQ")||(m_docref.substring(0,2)=="RC")||(m_docref.substring(0,2)=="DS")||(m_docref.substring(0,2)=="SP")||(m_docref.substring(0,2)=="BC")||(m_docref.substring(0,2)=="SI")||(m_docref.substring(0,2)=="CI")||(m_docref.substring(0,2)=="SR")) {

      if (m_docref.substring(0,2)=="JE") {
			    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mlldivpro_lost_account?chksql=jedetail"+
																									 "&acctype="+m_acctype+
																									 "&docref="+m_docref;
			}
			else if ((m_docref.substring(0,2)=="VC") ||(m_docref.substring(0,2)=="VQ")) {
			    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mlldivpro_lost_account?chksql=vodetail"+
																									 "&acctype="+m_acctype+
																									 "&docref="+m_docref;
			}
			else if (m_docref.substring(0,2)=="RC") {
			    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mlldivpro_lost_account?chksql=rcdetail"+
																									 "&acctype="+m_acctype+
																									 "&docref="+m_docref;
  		}
		//else if (m_docref.substring(0,2)=="RR") {
		//	    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mlldivpro_lost_account?chksql=retrcdetail"+
		//																							 "&acctype="+m_acctype+
		//																							 "&docref="+m_docref;
  	//   }
		else if (m_docref.substring(0,2)=="DS") {
			    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"mlldivpro_lost_account?chksql=dsdetail"+
																									 "&acctype="+m_acctype+
																									 "&docref="+m_docref;
			}
	
			else if (m_docref.substring(0,2)=="SP") {
			    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"source_document?chksql=doc_refno"+
																									 "&docref="+m_docref;
			}
			else if (m_docref.substring(0,2)=="BC") {
			    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"source_document?chksql=doc_refno"+
																									 "&docref="+m_docref;
			}
			else if (m_docref.substring(0,2)=="SI") {
			    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"source_document?chksql=doc_refno"+
																									 "&docref="+m_docref;
			}
	
			else if (m_docref.substring(0,2)=="CI") {
			    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"source_document?chksql=doc_refno"+
																									 "&docref="+m_docref;
			}
			else if (m_docref.substring(0,2)=="SR") {
			    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"source_document?chksql=doc_refno"+
																									 "&docref="+m_docref;
			}
			else if (m_docref.substring(0,2)=="RR") {
			    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"source_document?chksql=doc_refno"+
																									 "&docref="+m_docref;
			}
			else if (m_docref.substring(0,2)=="BF") {
			    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"source_document?chksql=doc_refno"+
																									 "&docref="+m_docref;
			}
			else if (m_docref.substring(0,2)=="RF") {
			    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"source_document?chksql=doc_refno"+
																									 "&docref="+m_docref;
			}
			else if (m_docref.substring(0,2)=="OR") {
			    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"source_document?chksql=doc_refno"+
																									 "&docref="+m_docref;
			}
			else if (m_docref.substring(0,2)=="BS") {
			    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"source_document?chksql=doc_refno"+
																									 "&docref="+m_docref;
			}
			else if (m_docref.substring(0,2)=="PI") {
			    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"source_document?chksql=doc_refno"+
																									 "&docref="+m_docref;
			}
			else if (m_docref.substring(0,2)=="CS") { 
			    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"source_document?chksql=doc_refno"+
																									 "&docref="+m_docref;
			}
			else if (m_docref.substring(0,2)=="RS") { 
                    
                
			    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"source_document?chksql=doc_refno"+
																									 "&docref="+m_docref;
			}
                //ADD BY INDITHA FOR PAYROLL PROCESS EPF
      else if (m_docref.substring(0,2)=="PR") { 
                    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"payroll_process?chksql=load_payroll_summary_accounts&Docref_no="+m_docref;
      }
			else if (m_docref.substring(0,2)=="GR") { 
                      m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"source_document?chksql=doc_refno"+
																									 "&docref="+m_docref;
      }
			else if (m_docref.substring(0,2)=="IN") { 
                      m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"source_document?chksql=doc_refno"+
																									 "&docref="+m_docref;
      }
	    else if (m_docref.substring(0,2)=="DP") { 
                      m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"source_document?chksql=doc_refno"+
																									 "&docref="+m_docref;
      }
			else if (m_docref.substring(0,2)=="CD") { //deposit
                      m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Fixed_Asset_validation?chksql=deposit"+
																									 "&reci_no="+m_docref;
      }
			else if (m_docref.substring(0,2)=="CW") { //deposit
                      m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"Fixed_Asset_validation?chksql=with"+
																									 "&reci_no="+m_docref;
      }
	    else {
			   alert("Document is not prepared for the selected reference.");
		  }
      if (m_url!="") { 
			  popupwin3 = window.open(m_url,'displayWindow5','left=100,top=125,width=600,height=350,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');	
			  popupwin3.focus();
			}
//}	
}		
	
	
	function display_document(m_acctype,m_docref) {
		  if (m_docref.substring(0,2)=="JE") {
			    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"webrptbalance_sheet?chksql=jedetail"+
																									 "&acctype="+m_acctype+
																									 "&docref="+m_docref;
			}
			else if ((m_docref.substring(0,2)=="VC") ||(m_docref.substring(0,2)=="VQ")) {
			    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"webrptbalance_sheet?chksql=vodetail"+
																									 "&acctype="+m_acctype+
																									 "&docref="+m_docref;
			}
			else if (m_docref.substring(0,2)=="RC") {
			    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"webrptbalance_sheet?chksql=rcdetail"+
																									 "&acctype="+m_acctype+
																									 "&docref="+m_docref;
  		}
			else if (m_docref.substring(0,2)=="DS") {
			    m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"webrptbalance_sheet?chksql=dsdetail"+
																									 "&acctype="+m_acctype+
																									 "&docref="+m_docref;
			}
			else{
		      alert("Underconstruction...........");
		  }
			popupwin3 = window.open(m_url,'displayWindow5','left=100,top=125,width=600,height=350,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
			popupwin3.focus();
		}		

	//*********** Added By Manjula on 13/07/2004-- For the Contract Report --Account Wise ********
		function contract_account_det(m_cont_ref,m_ff_date,m_tt_date,m_type,m_code1,m_code2,m_code3,m_code4) {
		
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"contract_report_acc_wise?chksql=con_details"+
																									 "&con_ref_no="+m_cont_ref+
																									 "&m_from_dt="+m_ff_date+
																									 "&m_to_dt="+m_tt_date+
																									 "&m_a_type="+m_type+
																									 "&m_c1="+m_code1+
																									 "&m_c2="+m_code2+
																									 "&m_c3="+m_code3+
																									 "&m_c4="+m_code4;
																									
			popupwin3 = window.open(m_url,'displayWindow3','left=100,top=125,width=600,height=350,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
			
			popupwin3.focus();
				//window.open(m_url);
		}
		
		function contract_account_det_pl(m_cont_ref,m_ff_date,m_tt_date,m_type,m_code1,m_code2,m_code3,m_code4) {
		
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"contract_report_acc_wise?chksql=con_details_pl"+
																									 "&con_ref_no="+m_cont_ref+
																									 "&m_from_dt="+m_ff_date+
																									 "&m_to_dt="+m_tt_date+
																									 "&m_a_type="+m_type+
																									 "&m_c1="+m_code1+
																									 "&m_c2="+m_code2+
																									 "&m_c3="+m_code3+
																									 "&m_c4="+m_code4;
																									
			popupwin3 = window.open(m_url,'displayWindow3','left=100,top=125,width=600,height=350,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
			
			popupwin3.focus();
				//window.open(m_url);
		}
	
	function contract_account_det_nodate(m_cont_ref,m_ff_date,m_tt_date,m_type,m_code1,m_code2,m_code3,m_code4) {
		
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"contract_report_acc_wise?chksql=con_details_new"+
																									 "&con_ref_no="+m_cont_ref+
																									 "&m_from_dt="+m_ff_date+
																									 "&m_to_dt="+m_tt_date+
																									 "&m_a_type="+m_type+
																									 "&m_c1="+m_code1+
																									 "&m_c2="+m_code2+
																									 "&m_c3="+m_code3+
																									 "&m_c4="+m_code4;
																									
			popupwin3 = window.open(m_url,'displayWindow3','left=100,top=125,width=600,height=350,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
			
			popupwin3.focus();
				//window.open(m_url);
		}
			
	function contract_account_det_nodate_pl(m_cont_ref,m_ff_date,m_tt_date,m_type,m_code1,m_code2,m_code3,m_code4) {
		
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"contract_report_acc_wise?chksql=con_details_new_pl"+
																									 "&con_ref_no="+m_cont_ref+
																									 "&m_from_dt="+m_ff_date+
																									 "&m_to_dt="+m_tt_date+
																									 "&m_a_type="+m_type+
																									 "&m_c1="+m_code1+
																									 "&m_c2="+m_code2+
																									 "&m_c3="+m_code3+
																									 "&m_c4="+m_code4;
																									
			popupwin3 = window.open(m_url,'displayWindow3','left=100,top=125,width=600,height=350,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	
			
			popupwin3.focus();
				//window.open(m_url);
		}
