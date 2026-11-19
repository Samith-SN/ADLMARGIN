	var servlet_client_url="https://dev-adlmargin.sasianet.com";
	var html_client_url="https://dev-adlmargin.sasianet.com/intranet";
  var client_t3_port="8080/myserver/servlet";
	var client_name="LBMARGIN_";
	var default_user="MBFSL";

		
		
		var rarrayone=new Array();
		var rarraytwo=new Array();
		var rarraythree=new Array();
		var rarrayfour=new Array();
		var rarrayfive=new Array();
		var rarraysix=new Array();
		var rarrayseven=new Array();
		
		
			
			  function display_trn(m_port,m_inst,m_security,m_maturity,m_basis) {
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_trn';
				popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
				
				
				function display_trn_v1(m_security,m_maturity,m_basis,m_inst,m_port,m_sysdate) {
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory_v1?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&deal_type=SC&mdate='+m_sysdate+'&chksql=detail_trn';
				popupwin = window.open(m_url,'displayWindow74','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
				
			  function display_sec(m_port,m_inst,m_security,m_maturity,m_basis) {
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_sec';
				popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
			  
				function display_sec_v1(m_security,m_maturity,m_basis,m_inst,m_port,m_sysdate) {
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory_v1?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&mdate='+m_sysdate+'&chksql=detail_sec';
				popupwin = window.open(m_url,'displayWindow74','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
			  
				function display_secsum(m_security,m_maturity,m_basis,m_inst,m_port) {
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_secsum';
				popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}


			  function display_sno(m_port,m_inst,m_security,m_maturity,m_basis) {
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_sno';
				popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
			 
				function display_sno_v1(m_security,m_maturity,m_basis,m_inst,m_port,m_sysdate) {
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory_v1?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&mdate='+m_sysdate+'&deal_type=SC&chksql=detail_sno';
				popupwin = window.open(m_url,'displayWindow74','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}

				
				function showm() {
        m_write = '<DIV ID="divMenu" STYLE="{font-family: arial; font-size: 8pt; line-height: 11pt; cursor: hand; color: black; background-color: #FFFFE1; padding: 1px; text-align: left; position: absolute; visibility: visible; overflow: hidden; border-style: outset; border-color: black; border-width: 1; width: 70pt; }">'+
                  '<DIV>Click to go Back</DIV>'+
                  '</DIV>';
				menuu.innerHTML=m_write;
				}
				                  
				function hidem()    {
				 divMenu.style.visibility = "hidden";        
        }				

		function chk_outr(mmm){
		}						
		
		function chk_outv(nnn){
		}
		
		function chk_outw(sss){
		}
		
		function before_submit(){
			
			for (var i=0; i < document.Form1.elements.length; i++ ) {
					document.Form1.elements[i].disabled=false;
			}
				 document.Form1.Hid_stat_ser.value=parent.frames[1].document.Form1.Hid_status_ser.value;
				 document.Form1.Hid_stat_sec.value=parent.frames[1].document.Form1.Hid_status_sec.value;
				 document.Form1.Hid_stat_trn.value=parent.frames[1].document.Form1.Hid_status_trn.value;
				 document.Form1.Hid_port.value=parent.frames[1].document.Form1.Hid_port.value;
				 document.Form1.Hid_inst.value=parent.frames[1].document.Form1.Hid_inst.value;
				 document.Form1.Hid_todate.value=parent.frames[1].document.Form1.Hid_today.value;
         document.Form1.Hid_def.value=parent.frames[1].document.Form1.Hid_line_r.value;
				 def= parent.frames[1].document.Form1.Hid_line_r.value;
				 for(r=1;r<def;r++){
							rarrayone[r-1]=eval("parent.frames[1].R"+r+"C1.innerText");
							rarraytwo[r-1]=eval("parent.frames[1].R"+r+"C2.innerText");
							rarraythree[r-1]=eval("parent.frames[1].R"+r+"C3.innerText");
							rarrayfour[r-1]=eval("parent.frames[1].R"+r+"C4.innerText");
							rarrayfive[r-1]=eval("parent.frames[1].R"+r+"C5.innerText");
							rarraysix[r-1]=eval("parent.frames[1].R"+r+"C6.innerText");
							rarrayseven[r-1]=(parent.frames[1].document.Form1.elements["TXT_ITYPE_SER_"+r+""]).value;
						}
			
			       m_hid_input="";
			         for(r=1;r<def;r++){
			             m_hid_input='<TABLE><TR><TD><INPUT TYPE="Hidden" NAME=rarrayone'+r+'		VALUE='+rarrayone[r-1]+'>'+
																					    '<INPUT TYPE="Hidden" NAME=rarraytwo'+r+'		VALUE='+rarraytwo[r-1]+'>'+
																					    '<INPUT TYPE="Hidden" NAME=rarraythree'+r+' VALUE='+rarraythree[r-1]+'>'+
																					    '<INPUT TYPE="Hidden" NAME=rarrayfour'+r+'	VALUE='+rarrayfour[r-1]+'>'+
																					    '<INPUT TYPE="Hidden" NAME=rarrayfive'+r+'	VALUE='+rarrayfive[r-1]+'>'+
																					    '<INPUT TYPE="Hidden" NAME=rarraysix'+r+'	  VALUE='+rarraysix[r-1]+'>'+
																					    '<INPUT TYPE="Hidden" NAME=rarrayseven'+r+'	VALUE='+rarrayseven[r-1]+'></TD></TR></TABLE>';
														      insdata.innerHTML=insdata.innerHTML+m_hid_input;
						  }
					
					
						Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"sav_senanaly";
					  Form1.submit();
					  top.opener.parent.frames[1].document.Form1.TXT_PCODE.value="";
						top.opener.parent.frames[1].document.Form1.TXT_ITYPE.value="";
            document.Form1.save_but.disabled=true;				
				}
				
		
				
