        var servlet_client_url="https://dev-adlmargin.sasianet.com";
      	var html_client_url="https://dev-adlmargin.sasianet.com/intranet";
        var client_t3_port="8080/myserver/servlet";
        var client_name="LBMARGIN_"

				//=============================Inventory Listing====================================================================
			
			  function display_out(m_dealno,m_serilalno,m_portcode) {
				m_invtype='O/R'
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'bvalwizard4?invtype='+m_invtype+'&dealno='+m_dealno+'&serilalno='+m_serilalno+'&portcode='+m_portcode+'&chksql=detail_data';
				popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
				
				function display_repo(m_dealno,m_serilalno,m_portcode) {
				m_invtype='R/P'
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'bvalwizard4?invtype='+m_invtype+'&dealno='+m_dealno+'&serilalno='+m_serilalno+'&portcode='+m_portcode+'&chksql=detail_data';
				popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
				
			  function display_bl(m_dealno,m_serilalno,m_portcode) {
				m_invtype='B/L'
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'bvalwizard4?invtype='+m_invtype+'&dealno='+m_dealno+'&serilalno='+m_serilalno+'&portcode='+m_portcode+'&chksql=detail_data';
				popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
			

        //========================================Outrights=========================================================================
				

				function display_out2O(m_seccode,m_serial_no) {
  			m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'bvalwizard7?seccode='+m_seccode+'&serial_no='+m_serial_no+'&chksql=detail_data_out';
				popupwin = window.open(m_url,'displayWindow3','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}

				
				//========================================BL Sec=========================================================================
				

				function display_bl3(m_seccode,m_serial_no) {
  			m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'bvalwizard7?seccode='+m_seccode+'&serial_no='+m_serial_no+'&chksql=detail_data_blsec';
				popupwin = window.open(m_url,'displayWindow3','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}

				
				//=============================repo Fresh====================================================================
			
			  function display_out2(m_serilalno,m_portcode) {
				m_invtype='O/R'
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'bvalwizard7?invtype='+m_invtype+'&serilalno='+m_serilalno+'&portcode='+m_portcode+'&chksql=detail_data';
				popupwin = window.open(m_url,'displayWindow2','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=0,resizable=1');
				popupwin.focus();
				}
				
				function display_repo2(m_serilalno,m_portcode,m_deal) {
				m_invtype='R/P'
				m_urlservlet_client_url+':'+client_t3_port+'/'+client_name+'bvalwizard7?invtype='+m_invtype+'&serilalno='+m_serilalno+'&portcode='+m_portcode+'&deal='+m_deal+'&chksql=detail_data';
				popupwin = window.open(m_url,'displayWindow2','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=0,resizable=1');
				popupwin.focus();
				}
				
			  function display_bl2(m_serilalno,m_portcode) {
				m_invtype='B/L'
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'bvalwizard7?invtype='+m_invtype+'&serilalno='+m_serilalno+'&portcode='+m_portcode+'&chksql=detail_data';
				popupwin = window.open(m_url,'displayWindow2','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=0,resizable=1');
				popupwin.focus();
				}
			
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
