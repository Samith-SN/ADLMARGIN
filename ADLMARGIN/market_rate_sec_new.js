	var servlet_client_url="https://dev-adlmargin.sasianet.com";
	var html_client_url="https://dev-adlmargin.sasianet.com/intranet";
  var client_t3_port="8080/myserver/servlet";
	var client_name="ADLMARGIN_";


		
		
		
		
		
	var rarrayone=new Array();
	var rarraytwo=new Array();
	var rarraythree=new Array();
	
				
			 function before_submit_Equity(){
			
			for (var i=0; i < document.Form1.elements.length; i++ ) {
					document.Form1.elements[i].disabled=false;
			}

     document.Form1.Hid_def.value=parent.frames[1].document.Form1.Hid_line_r.value;
			
					
				def= parent.frames[1].document.Form1.Hid_line_r.value;
				flag="yes";
				
				for(r=1;r<def;r++){
							rarrayone[r-1]=eval("parent.frames[1].R"+r+"C2.innerText");
							rarraytwo[r-1]=(parent.frames[1].document.Form1.elements["TEXT_ENT_DATE_"+r+""]).value;							
							rarraythree[r-1]=(parent.frames[1].document.Form1.elements["TXT_ITYPE_SER_"+r+""]).value;
							if (rarraythree[r-1] == "" || rarraythree[r-1] == " ")
							{
							  alert("Please Enter the Market Price for all Securities and Continue to Save.");
								r=def+1;
								flag="no";
							}
						}
			     
			       m_hid_input="";
			         for(r=1;r<def;r++){
								
								
			             m_hid_input='<TABLE><TR><TD><INPUT TYPE="Hidden" NAME=rarrayone'+r+'		VALUE='+rarrayone[r-1]+'>'+
																					    '<INPUT TYPE="Hidden" NAME=rarraytwo'+r+'	  VALUE='+rarraytwo[r-1]+'>'+
																					    '<INPUT TYPE="Hidden" NAME=rarraythree'+r+'	VALUE='+rarraythree[r-1]+'></TD></TR></TABLE>';
														      insdata.innerHTML=insdata.innerHTML+m_hid_input;
																
						  }
							if (flag== "yes" )
							{
						//alert(document.Form1.Hid_def.value);	
						Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"sav_marketvalue_equity_new";
					  Form1.submit();
            document.Form1.save_but.disabled=true;				
						}
				}
				
	//**************************************************************************************************			
		
				
		function before_submit_Debt(){
		

				


			
			for (var i=0; i < document.Form1.elements.length; i++ ) {
					document.Form1.elements[i].disabled=false;
			}

     document.Form1.Hid_def.value=parent.frames[1].document.Form1.Hid_line_r.value;
			flag1="yes";
					
				def= parent.frames[1].document.Form1.Hid_line_r.value;
				
				for(r=1;r<def;r++){
							rarrayone[r-1]=eval("parent.frames[1].R"+r+"C2.innerText");
							rarraytwo[r-1]=(parent.frames[1].document.Form1.elements["TEXT_ENT_DATE_"+r+""]).value;							
							rarraythree[r-1]=(parent.frames[1].document.Form1.elements["TXT_ITYPE_SER_"+r+""]).value;
							if (rarraythree[r-1] == "" || rarraythree[r-1] == " ")
							{
							  alert("Please Enter the Market Price for all Securities and Continue to Save.");
								r=def+1;
								flag1="no";
							}
						}
			
			       m_hid_input="";
			         for(r=1;r<def;r++){
			             m_hid_input='<TABLE><TR><TD><INPUT TYPE="Hidden" NAME=rarrayone'+r+'		VALUE='+rarrayone[r-1]+'>'+
																					    '<INPUT TYPE="Hidden" NAME=rarraytwo'+r+'	  VALUE='+rarraytwo[r-1]+'>'+
																					    '<INPUT TYPE="Hidden" NAME=rarraythree'+r+'	VALUE='+rarraythree[r-1]+'></TD></TR></TABLE>';
														      insdata.innerHTML=insdata.innerHTML+m_hid_input;
						  }
							if (flag1== "yes" )
							{
						Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"sav_marketvalue_debt_new";
					  Form1.submit();
            document.Form1.save_but.disabled=true;				
						}
									
				}
				
	//**************************************************************************************************			
		
				
