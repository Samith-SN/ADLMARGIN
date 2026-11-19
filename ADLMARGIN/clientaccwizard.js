				var servlet_client_url="https://dev-adlmargin.sasianet.com";
				var html_client_url="https://dev-adlmargin.sasianet.com/intranet";
				var client_t3_port="8080/myserver/servlet";
                var client_name="ADLMARGIN_";

// function created by samanthi Ranasinghe 0n 05/03/2001 -->
			function cheque_sum(port,fromdate,todate)
			{
			  //alert(port);
				//alert(fromdate);
				//alert(todate);
			  m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'accvalwizardclientaccount?&port='+port+'&fromdate='+fromdate+'&todate='+todate+'&chksql=port_lookup4';
				//alert(m_url);
				//popupwin = window.open(m_url,'displayWindow72','left=100,top=175,width=900,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			 //	popupwin = window.open(m_url,'displayWindow2','left=0,top=130,width=790,height=390,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');					
				popupwin= window.open(m_url,'displayWindow2','left=0,top=0,width=680,height=250,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');	

				popupwin.focus();
			}


					function  display_client_details1(m_portcode,m_dnportcode)
					 {
						//alert("hai");
					  //alert(m_portcode);
						//alert(m_dnportcode);
						m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'clientaccountledger?portcode='+m_portcode+'&dnportcode='+m_dnportcode+'&chksql=data1';
						//alert(m_url);
						popupwin = window.open(m_url,'displayWindow72','left=100,top=175,width=900,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			 	 	popupwin.focus();
						}
			 	function display_client_details2(m_portcode,m_dnportcode,m_fromdate,m_todate)
					  {
						 //alert("hai");
						// alert(m_portcode);
						 //alert(m_dnportcode);
						 //alert(m_fromdate);
						 //alert(m_todate);	
						 m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'clientaccountledger?portcode='+m_portcode+'&dnportcode='+m_dnportcode+'&fromdate='+m_fromdate+'&todate='+m_todate+'&chksql=data2';
						 //alert(m_url);
						 popupwin = window.open(m_url,'displayWindow72','left=100,top=175,width=900,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			 	 	 popupwin.focus();
						}
						
						function display_client_details3(m_portcode,m_dnportcode,m_fromdate,m_todate)
							{
								//alert("hai");
								//alert(m_portcode);
							 //alert(m_dnportcode);
						 //alert(m_fromdate);
						 //alert(m_todate);	
								m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'clientaccountledger?portcode='+m_portcode+'&dnportcode='+m_dnportcode+'&fromdate='+m_fromdate+'&todate='+m_todate+'&chksql=data2';
							//  alert(m_url);
								popupwin = window.open(m_url,'displayWindow72','left=100,top=175,width=900,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			 	 			popupwin.focus();
								
							}
						
						function display_client_details3_new(m_dnportcode,m_fromdate,m_todate)
							{
								m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'clientaccountledger?portcode=&dnportcode='+m_dnportcode+'&fromdate='+m_fromdate+'&todate='+m_todate+'&chksql=data2_new';
							//  alert(m_url);
								popupwin = window.open(m_url,'displayWindow72','left=100,top=175,width=900,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			 	 			popupwin.focus();
								
							}
							
	//-----------------------new function added for SR0507-001 on 2005-07-06 by janitha----------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
							function display_client_details3_newbal(m_dnportcode,m_fromdate,m_todate)
							{
								m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'clientaccountledger?portcode=&dnportcode='+m_dnportcode+'&fromdate='+m_fromdate+'&todate='+m_todate+'&chksql=data2_newbal';
							//  alert(m_url);
								popupwin = window.open(m_url,'displayWindow72','left=100,top=175,width=900,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			 	 			popupwin.focus();
								
							}


        function display_client_details3_new_v1(m_portcode,m_dnportcode,m_fromdate,m_todate)
                            {
                                m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'clientaccountledger?portcode='+m_portcode+'&dnportcode='+m_dnportcode+'&fromdate='+m_fromdate+'&todate='+m_todate+'&chksql=data2_new_v1';
                                popupwin = window.open(m_url,'displayWindow72','left=100,top=175,width=900,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
                                popupwin.focus();
                            }
														
										function display_client_details3_cpbal(m_dnportcode,m_fromdate,m_todate)
							{
								m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'clientaccountledger?portcode=&dnportcode='+m_dnportcode+'&fromdate='+m_fromdate+'&todate='+m_todate+'&chksql=data2_new_CPbal';
							//  alert(m_url);
								popupwin = window.open(m_url,'displayWindow72','left=100,top=175,width=900,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			 	 			popupwin.focus();
								
							}
											
		   function display_client_details3_cp_v1(m_port,m_dnportcode,m_fromdate,m_todate)
        {
                                m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'acc_client_rpt_bal?portcode='+m_port+'&dnportcode='+m_dnportcode+'&fromdate='+m_fromdate+'&todate='+m_todate+'&chksql=data_client_cp_drill';
                                popupwin = window.open(m_url,'displayWindow72','left=100,top=175,width=900,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
                                popupwin.focus();
       }
										
														
				function display_client_details3_cp_v2(m_port,m_dnportcode,m_fromdate,m_todate)
        {
                                m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'clientaccountledger?portcode='+m_port+'&dnportcode='+m_dnportcode+'&fromdate='+m_fromdate+'&todate='+m_todate+'&chksql=data2_new_CP_v1';
                                popupwin = window.open(m_url,'displayWindow73','left=100,top=175,width=900,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
                                popupwin.focus();
       }
																
														
	//-----------------------------------end of adding for SR0507-001------------------------------------------------------------------------------------------------------------------------------------------------------
	
	
	
							
							function display_client_details3_cp(m_dnportcode,m_fromdate,m_todate)
							{
								m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'clientaccountledger?portcode=&dnportcode='+m_dnportcode+'&fromdate='+m_fromdate+'&todate='+m_todate+'&chksql=data2_new_CP';
							//  alert(m_url);
								popupwin = window.open(m_url,'displayWindow72','left=100,top=175,width=900,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			 	 			popupwin.focus();
								
							}
							function display_client_details3_pf(m_dnportcode,m_fromdate,m_todate)
							{
								m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'clientaccountledger?portcode=&dnportcode='+m_dnportcode+'&fromdate='+m_fromdate+'&todate='+m_todate+'&chksql=data2_new_PF';
							//  alert(m_url);
								popupwin = window.open(m_url,'displayWindow72','left=100,top=175,width=900,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			 	 			popupwin.focus();
								
							}
						function display_portfolio_details3(m_portcode,m_dnportcode,m_fromdate,m_todate)
							{
								//alert("hai");
								//alert(m_portcode);
							 //alert(m_dnportcode);
						 //alert(m_fromdate);
						 //alert(m_todate);	
								m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'clientaccountledger?portcode='+m_portcode+'&dnportcode='+m_dnportcode+'&fromdate='+m_fromdate+'&todate='+m_todate+'&chksql=data2_portfoliio';
							//  alert(m_url);
								popupwin = window.open(m_url,'displayWindow72','left=100,top=175,width=900,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			 	 			popupwin.focus();
								
							}
						function display_portfolio_details3_new(m_dnportcode,m_fromdate,m_todate)
							{
								
								m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'clientaccountledger?portcode=&dnportcode='+m_dnportcode+'&fromdate='+m_fromdate+'&todate='+m_todate+'&chksql=data2_portfoliio_new';
							//  alert(m_url);
								popupwin = window.open(m_url,'displayWindow72','left=100,top=175,width=900,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			 	 			popupwin.focus();
								
							}
						function display_portfolio_details_mt(m_dnportcode,m_fromdate,m_todate,m_portf)
							{
								
								m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'clientaccountledger_mt?portcode='+m_portf+'&dnportcode='+m_dnportcode+'&fromdate='+m_fromdate+'&todate='+m_todate+'&chksql=data2_portfoliio_new';
							//  alert(m_url);
								popupwin = window.open(m_url,'displayWindow72','left=100,top=175,width=900,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			 	 			popupwin.focus();
								
							}
						
						
					 	function  display_client_details4(m_portcode,m_dnportcode)
					 {
						//alert("hai");
					  //alert(m_portcode);
						//alert(m_dnportcode);
						m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'clientaccountledger?portcode='+m_portcode+'&dnportcode='+m_dnportcode+'&chksql=data1';
						//alert(m_url);
						popupwin = window.open(m_url,'displayWindow72','left=100,top=175,width=900,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			 	 	popupwin.focus();
						}	
				
						function display_client_details5(m_portcode,m_dnportcode,m_todate)
								{
							//alert(m_portcode);
							//alert(m_dnportcode);
						 	//alert(m_todate);	
								m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'clientaccountledger?portcode='+m_portcode+'&dnportcode='+m_dnportcode+'&todate='+m_todate+'&chksql=data5';
							//  alert(m_url);
								popupwin = window.open(m_url,'displayWindow72','left=100,top=175,width=900,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			 	 			popupwin.focus();
								}
								
								function display_client_details6(m_portcode,m_dnportcode,m_fromdate)
								{
							//alert(m_portcode);
							//alert(m_dnportcode);
						 	//alert(m_todate);	
								m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'clientaccountledger?portcode='+m_portcode+'&dnportcode='+m_dnportcode+'&fromdate='+m_fromdate+'&chksql=data6';
								//alert(m_url);
								popupwin = window.open(m_url,'displayWindow72','left=100,top=175,width=900,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			 	 		 popupwin.focus();
								}
			 	function display_client_details7(m_portcode,m_dnportcode,m_todate)
								{
							
								m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'clientaccountledger?portcode='+m_portcode+'&dnportcode='+m_dnportcode+'&todate='+m_todate+'&chksql=data5';
								popupwin = window.open(m_url,'displayWindow72','left=100,top=175,width=900,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			 	 			popupwin.focus();
								}
				
						 function display_client_details8(m_portcode,m_dnportcode,m_fromdate)
								{
							//alert(m_portcode);
							//alert(m_dnportcode);
						 	//alert(m_todate);	
								m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'clientaccountledger?portcode='+m_portcode+'&dnportcode='+m_dnportcode+'&fromdate='+m_fromdate+'&chksql=data6';
								//alert(m_url);
								popupwin = window.open(m_url,'displayWindow72','left=100,top=175,width=900,height=800,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
			 	 		 popupwin.focus();
								}
				//=============================Inventory Listing====================================================================
			
			 	 function display_trn(m_port,m_inst,m_date,m_security,m_maturity,m_basis) {
				//alert(m_security);
				//alert(m_maturity);
				//alert(m_basis);
				//alert(m_inst);
				//alert(m_port);
				//alert(m_date);
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory?mdate='+m_date+'&security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_trn';
				//alert(m_url);
				popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
				
				
				function display_trn_v1(m_security,m_maturity,m_date,m_basis,m_inst,m_port) {
				//alert(m_security);
				//alert(m_maturity);
				//alert(m_basis);
				//alert(m_inst);
				//alert(m_port);
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory_v1?mdate='+m_date+'&security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_trn';
				//alert(m_url);
				popupwin = window.open(m_url,'displayWindow74','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
				
			  function display_sec(m_port,m_inst,m_date,m_security,m_maturity,m_basis) {
				//alert(m_security);
				//alert(m_maturity);
				//alert(m_basis);
				//alert(m_inst);
				//alert(m_port);
				//alert(m_date);
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory?mdate='+m_date+'&security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_sec';
				//alert(m_url);
				popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
			  
				function display_sec_v1(m_security,m_maturity,m_date,m_basis,m_inst,m_port) {
				//alert(m_security);
				///alert(m_maturity);
				//alert(m_date);
				//alert(m_basis);
				//alert(m_inst);
				//alert(m_port);
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory_v1?mdate='+m_date+'&security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_sec';
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
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_secsum';
				popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}


			  function display_sno(m_port,m_inst,m_date,m_security,m_maturity,m_basis) {
				//alert(m_security);
				//alert(m_maturity);
				//alert(m_basis);
				//alert(m_inst);
				//alert(m_port);
				 // alert(m_date);
				m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory?mdate='+m_date+'&security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_sno';
				//alert(m_url);				
				popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
				popupwin.focus();
				}
			 
				function display_sno_v1(m_security,m_maturity,m_date,m_basis,m_inst,m_port)
				 {
			 	 	// alert(m_date);
 				 		m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory_v1?mdate='+m_date+'&security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_sno';
						// alert(m_url);
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
