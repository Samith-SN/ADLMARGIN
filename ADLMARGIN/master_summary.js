function display_moreall(m_portcode,m_inst_code,m_invtype) {
				//m_url='dn_master_wizard_frame1.html'
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'bvalwizard6?port_code='+m_portcode+'&inst_code='+m_inst_code+'&invtype='+m_invtype+'&chksql=data2';
				popupwin = window.open(m_url,'displayWindow1','left=290,top=150,width=275,height=200,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
				
				function display_sno(m_invtype,m_portcode,m_inst_code) {
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'bvalwizard4?invtype='+m_invtype+'&portcode='+m_portcode+'&instype='+m_inst_code+'&chksql=data44';
				popupwin = window.open(m_url,'displayWindow2','left=0,top=75,width=800,height=490,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
				
			  function display_sec(m_invtype,m_portcode,m_inst_code) {
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'bvalwizard3?invtype='+m_invtype+'&portcode='+m_portcode+'&instype='+m_inst_code+'&chksql=data44';
				popupwin = window.open(m_url,'displayWindow2','left=0,top=75,width=800,height=490,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
				
				function display_ins(m_invtype,m_portcode,m_inst_code) {
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'bvalwizard5?invtype='+m_invtype+'&portcode='+m_portcode+'&instype='+m_inst_code+'&chksql=data44';
				popupwin = window.open(m_url,'displayWindow2','left=0,top=75,width=800,height=490,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
				
				function display_more1(m_portcode,m_invtype,m_seccode,m_dealno) {
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'bvalwizard3?invtype='+m_invtype+'&seccode='+m_seccode+'&dealno='+m_dealno+'&portcode='+m_portcode+'&chksql=moredata1';
				popupwin = window.open(m_url,'displayWindow3','left=0,top=0,width=375,height=470,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
				
				function display_more2(m_portcode,m_invtype,m_seccode,m_serialno,m_dealno) {
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'bvalwizard4?invtype='+m_invtype+'&seccode='+m_seccode+'&dealno='+m_dealno+'&serialno='+m_serialno+'&portcode='+m_portcode+'&chksql=moredata1';
				popupwin = window.open(m_url,'displayWindow3','left=0,top=0,width=375,height=470,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
				
				
				function display_more3(m_portcode,m_dealno,seccode,serialno) {
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'bvalwizard5?dealno='+m_dealno+'&seccode='+seccode+'&serialno='+serialno+'&portcode='+m_portcode+'&chksql=moredata';
				popupwin = window.open(m_url,'displayWindow3','left=0,top=0,width=375,height=470,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				//"Width:20em; Height:15em;, scrollbars=Yes, center:yes; menubar=no, resizable=no"
				
				popupwin.focus();
				}
				
				
				function selectscr(){
				if(document.Form1.SCR_TYPE.value=='LI'){
				parent.fset.rows="6%,10%,84%";
				parent.frames[1].location.href='dn_inventory_wizard_frame2.html'
				m_writedata ='<TD WIDTH="50%" STYLE="{color: white ;font: bold 10pt arial;text-align:right;}"'+
				'<B>Inventory - Wizard</B></TD>'; 
				scrname.innerHTML=m_writedata;	
				}
				if(document.Form1.SCR_TYPE.value=='RE'){
				parent.fset.rows="6%,10%,84%";
				parent.frames[1].location.href='dn_inventory_wizard_frame22.html'
				m_writedata ='<TD WIDTH="50%" STYLE="{color: white ;font: bold 10pt arial;text-align:right;}"'+
				'<B>Inventory - Wizard</B></TD>'; 
				scrname.innerHTML=m_writedata;	
				
				}
				if(document.Form1.SCR_TYPE.value=='IS'){
				parent.fset.rows="6%,10%,84%";
				parent.frames[1].location.href='dn_inventory_wizard_frame33.html'
				m_writedata ='<TD WIDTH="50%" STYLE="{color: white ;font: bold 10pt arial;text-align:right;}"'+
				'<B>Inventory - Wizard</B></TD>'; 
				scrname.innerHTML=m_writedata;	
				}
				if(document.Form1.SCR_TYPE.value=='CL'){
				parent.fset.rows="6%,10%,84%";
				parent.frames[1].location.href='dn_inventory_wizard_frame44.html'
				m_writedata ='<TD WIDTH="50%" STYLE="{color: white ;font: bold 10pt arial;text-align:right;}"'+
				'<B>Inventory - Wizard</B></TD>'; 
				scrname.innerHTML=m_writedata;	
				}
				if(document.Form1.SCR_TYPE.value=='DI'){
				parent.fset.rows="6%,10%,84%";
				parent.frames[1].location.href='dn_inventory_wizard_frame55.html'
				m_writedata ='<TD WIDTH="50%" STYLE="{color: white ;font: bold 10pt arial;text-align:right;}"'+
				'<B>Inventory - Wizard</B></TD>'; 
				scrname.innerHTML=m_writedata;	
				}
				if(document.Form1.SCR_TYPE.value=='MS'){
				parent.fset.rows="6%,94%,0%";
				m_url=servlet_client_url+':'+client_t3_port+'/bvalwizard6?&chksql=data';
				parent.frames[1].location.href=m_url;
				}
				}
				
				
				function showm() {
        m_write = '<DIV ID="divMenu" STYLE="{font-family: arial; font-size: 8pt; line-height: 11pt; cursor: hand; color: black; background-color: #FFFFE1; padding: 1px; text-align: left; position: absolute; top: 50px; visibility: visible; overflow: hidden; border-style: outset; border-color: black; border-width: 1; width: 60pt; left: 600px;}">'+
                  '<DIV>Click to go Back</DIV>'+
                  '</DIV>';
				menuu.innerHTML=m_write;
				}
				                  
				function hidem()
				        {
				      divMenu.style.visibility = "hidden";        
        }
