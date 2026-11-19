        var servlet_client_url="https://dev-adlmargin.sasianet.com";
      	var html_client_url="https://dev-adlmargin.sasianet.com/intranet";
        var client_t3_port="8080/myserver/servlet";
				var client_name = "LBMARGIN_";

				//=============================Inventory Listing====================================================================
			
			  function display_trn(m_port,m_inst,m_security,m_maturity,m_basis) {
				//alert(m_security);
				//alert(m_maturity);
				//alert(m_basis);
				//alert(m_inst);
				//alert(m_port);
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory_1?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_trn';
				popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
				
				
				function display_trn_v1(m_security,m_maturity,m_basis,m_inst,m_port) {
				//alert(m_security);
				//alert(m_maturity);
				//alert(m_basis);
				//alert(m_inst);
				//alert(m_port);
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory_v1_1?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_trn';
				popupwin = window.open(m_url,'displayWindow74','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
				
			   function display_sec(m_port,m_inst,m_security,m_maturity,m_basis) {
				//alert(m_security);
				//alert(m_maturity);
				//alert(m_basis);
				//alert(m_inst);
				//alert(m_port);
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory_1?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_sec';
				popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
			  
				function display_sec_v1(m_security,m_maturity,m_basis,m_inst,m_port) {
				//alert(m_security);
				//alert(m_maturity);
				//alert(m_basis);
				//alert(m_inst);
				//alert(m_port);
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory_v1_1?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_sec';
				//alert(m_url);
				popupwin = window.open(m_url,'displayWindow74','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
			  
				function display_secsum(m_security,m_maturity,m_basis,m_inst,m_port) {
				//alert(m_security);
				//alert(m_maturity);
				//alert(m_basis);
				//alert(m_inst);
				//alert(m_port);
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory_1?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_secsum';
				popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}


			  function display_sno(m_port,m_inst,m_security,m_maturity,m_basis) {
				//alert(m_security);
				//alert(m_maturity);
				//alert(m_basis);
				//alert(m_inst);
				//alert(m_port);
				
			   	m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory_1?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_sno';
				popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
			
				
				function display_sno_v1(m_security,m_maturity,m_basis,m_inst,m_port) {//alert("hai");
				//alert(m_security);
				//alert(m_maturity);
				//alert(m_basis);
				//alert(m_inst);
				//alert(m_port);
				//alert(m_date);
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory_v1_1?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_sno';
				//alert(m_url);
				popupwin = window.open(m_url,'displayWindow74','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
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
