/*
				//=============================Inventory Listing====================================================================
			
			  function display_out(m_security,m_maturity,m_basis,m_inst,m_port) {
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_data';
				popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
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
				
				*/
				
	var servlet_client_url="https://dev-adlmargin.sasianet.com";
	var html_client_url="https://dev-adlmargin.sasianet.com/intranet";
	var client_t3_port="8080/myserver/servlet";
	        var client_name="LBMARGIN_"

	//var client_name="C1_";
	//var default_user="DN";
				
				
				//=============================Inventory Listing====================================================================
			
			  function display_trn(m_port,m_inst,m_security,m_maturity,m_basis) {
				//alert(m_security);
				//alert(m_maturity);
				//alert(m_basis);
				//alert(m_inst);
				//alert(m_port);
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_trn';
				popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
				
				
				function display_trn_v1(m_security,m_maturity,m_basis,m_inst,m_port) {
				//alert(m_security);
				//alert(m_maturity);
				//alert(m_basis);
				//alert(m_inst);
				//alert(m_port);
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory_v1?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_trn';
				popupwin = window.open(m_url,'displayWindow74','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
				
			  function display_sec(m_port,m_inst,m_security,m_maturity,m_basis) {
				//alert(m_security);
				//alert(m_maturity);
				//alert(m_basis);
				//alert(m_inst);
				//alert(m_port);
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_sec';
				popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
			  
				function display_sec_v1(m_security,m_maturity,m_basis,m_inst,m_port) {
				//alert(m_security);
				//alert(m_maturity);
				//alert(m_basis);
				//alert(m_inst);
				//alert(m_port);
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory_v1?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_sec';
				popupwin = window.open(m_url,'displayWindow74','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
			  
				function display_secsum(m_security,m_maturity,m_basis,m_inst,m_port) {
				//alert(m_security);
				//alert(m_maturity);
				//alert(m_basis);
				//alert(m_inst);
				//alert(m_port);
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_secsum';
				popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}


			  function display_sno(m_port,m_inst,m_security,m_maturity,m_basis) {
				//alert(m_security);
				//alert(m_maturity);
				//alert(m_basis);
				//alert(m_inst);
				//alert(m_port);
				
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_sno';
				popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
			 
				function display_sno_v1(m_security,m_maturity,m_basis,m_inst,m_port) {
				//alert(m_security);
				//alert(m_maturity);
				//alert(m_basis);
				//alert(m_inst);
				//alert(m_port);
				
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory_v1?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_sno';
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
				
				function before_submit(){
			for (var i=0; i < document.Form1.elements.length; i++ ) {
					document.Form1.elements[i].disabled=false;
			}
				
					top.opener.parent.frames[1].document.Form1.TXT_PORT.value="";
					top.opener.parent.frames[1].document.Form1.TXT_DATE_TO.value="";
					top.opener.parent.frames[1].document.Form1.TXT_MONTH_TO.value="";
					top.opener.parent.frames[1].document.Form1.TXT_YEAR_TO.value="";
					top.opener.parent.frames[1].document.Form1.TXT_DATE_FROM.value="";
					top.opener.parent.frames[1].document.Form1.TXT_MONTH_FROM.value="";
					top.opener.parent.frames[1].document.Form1.TXT_YEAR_FROM.value="";
						//alert("ttt");
					//	alert(parent.frames[1].Hid_close.value);
						document.Form1.hid_close.value=parent.frames[1].Hid_close.value;
						//document.Form1.hid_PORT.value=document.Form1.TXT_OPEN.value;
						Form1.action=servlet_client_url+":"+client_t3_port+"/sav_cashflow";
					  Form1.submit();
				}
		
