        var servlet_client_url="https://dev-adlmargin.sasianet.com";
      	var html_client_url="https://dev-adlmargin.sasianet.com/intranet";
        var client_t3_port="8080/myserver/servlet";
				  var client_name="LBMARGIN_"

				//=============================Inventory Listing====================================================================

			  function display_out(m_trans_no,m_payment_no,m_port,m_mode) {
					m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'report_settlemgt_transfer_aft?reci_no='+m_trans_no+'&paymentno='+m_payment_no+'&port='+m_port+'&mode='+m_mode+'&chksql=confirm_reci';
					        popupwin2 = window.open(m_url,'displayWindow3', 'width=650, height=650, scrollbars=yes, menubar=No, resizable=no, fullscreen=No');
							//popupwin = window.open(m_url,'displayWindow72','left=50,top=175,width=700,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				      popupwin.focus();
				}

				
				
				
				
				
				
				function get_transno(m_trans_no) {
				//m_firsttwo=m_ref.substring(0,2);
				/*if (m_firsttwo=="OR"){
					m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'mbfsl_reports_payments_1?deal='+m_ref+'&type='+m_type+'&settle='+m_settle+'&chksql=detail_data_or';
        }
				else if (m_firsttwo=="BF"){
					m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'mbfsl_reports_payments_1?deal='+m_ref+'&type='+m_type+'&settle='+m_settle+'&chksql=detail_data_bf';
        }
				else if (m_firsttwo=="BS"){
					m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'mbfsl_reports_payments_1?deal='+m_ref+'&type='+m_type+'&settle='+m_settle+'&chksql=detail_data_bs';
        }
				else if (m_firsttwo=="RF"){
					m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'mbfsl_reports_payments_1?deal='+m_ref+'&type='+m_type+'&settle='+m_settle+'&chksql=detail_data_rf';
        }
				else if (m_firsttwo=="RR"){
					m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'mbfsl_reports_payments_1?deal='+m_ref+'&type='+m_type+'&settle='+m_settle+'&chksql=detail_data_rr';
        }
				else if (m_firsttwo=="RS"){
					m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'mbfsl_reports_payments_1?deal='+m_ref+'&type='+m_type+'&settle='+m_settle+'&chksql=detail_data_rs';
        }*/
			//out.println("window.location.href='"+m_servlet_client_url+":"+m_client_t3_port+"/report_settlemgt_transfer_aft?reci_no="+m_trans_no+"&chksql=confirm_reci'");
				
					//m_url=servlet_client_url+':'+client_t3_port+'/report_settlemgt_transfer_aft?reci_no='+m_trans_no+'&chksql=confirm_reci';
					m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'bconfirm_settle_transfer_help?reci_no='+m_trans_no+'&chksql=mrep_data';
				
				//m_url=servlet_client_url+':'+client_t3_port+'/mbfsl_reports_receipts_1?deal='+m_deal+'&instr='+m_instr+'&sec='+m_sec+'&face='+m_face+'&chksql=detail_data';
				//popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=700,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin = window.open(m_url,'displayWindow72','left=50,top=175,width=700,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
					//popupwin2 = window.open(m_url,'displayWindow3', 'width=650, height=650, scrollbars=yes, menubar=No, resizable=no, fullscreen=No');
				popupwin.focus();
				}
					//popupwin2 = window.open(m_url,'displayWindow3', 'width=650, height=650, scrollbars=yes, menubar=No, resizable=no, fullscreen=No');

				//============================================Display BACK image========================================================
				
				
				function showm() {
        m_write = '<DIV ID="divMenu" STYLE="{font-family: arial; font-size: 8pt; line-height: 11pt; cursor: hand; color: black; background-color: #FFFFE1; padding: 1px; text-align: left; position: absolute; visibility: visible; overflow: hidden; border-style: outset; border-color: black; border-width: 1; width: 70pt; }">'+
                  '<DIV>Click to go Back</DIV>'+
                  '</DIV>';
				menuu.innerHTML=m_write;
				}
				                  
				function hidem()
				        {
				      divMenu.style.visibility = "hidden";        
        }
