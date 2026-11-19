<%@page import="net.sasianet.ADLMARGIN.*" %>
	<%			
		ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
		String m_jsp_client_url=m_sn_methods.jsp_client_url;
		
			//***************  ADDED BY KANISHKA ON 26/12/2012  *********************//
	
		Object done = (String)session.getValue("logon.isDone");  // marker object
		if (done == null) {
			response.sendRedirect("login.jsp");
			return;
			}
	
	//*************** ADDED BY KANISHKA ON 26/12/2012 [END]  *********************//
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
		/*out.println("       <script src='"+m_jsp_client_url+"/SNET/jquery/grid/ui/minified/ui.draggable.min.js' type=\"text/javascript\"></script>");
        out.println("       <script src='"+m_jsp_client_url+"/SNET/jquery/grid/ui/minified/ui.resizable.min.js' type=\"text/javascript\"></script>");
        out.println("       <script src='"+m_jsp_client_url+"/SNET/jquery/grid/ui/minified/ui.dialog.min.js' type=\"text/javascript\"></script>");
		out.println("       <script src='"+m_jsp_client_url+"/js/jquery-1.6.2.min.js' type=\"text/javascript\"></script>");
 		*/
	%>

<HTML>
	<HEAD>
		<TITLE></TITLE>	
		
		<!--<LINK REL="stylesheet" TYPE="text/css" HREF="navbar.css/">-->
	

	</HEAD>	
	<%

		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/Asset_Financing_System.css' TYPE=\"text/css\">");
		out.println("<link REL='STYLESHEET' HREF='" + m_jsp_client_url + "/css/redmond/jquery-ui.css' TYPE=\"text/css\">");
		out.println("       <script src='"+m_jsp_client_url+"/js/jquery.min.js' type=\"text/javascript\"></script>");
		out.println("       <script src='"+m_jsp_client_url+"/js/jquery-ui.min.js' type=\"text/javascript\"></script>");


	%>	
<SCRIPT language="JavaScript1.2">
var m_currdate1;
var m_nextdate1;
var m_currdate;
var m_nextdate; 


function default_actions() {	
		setInterval("set_timer_actions()", 120000);
}			
		
		
function set_timer_actions() {	
	m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?chksql=idle";
	//top.frames[0].document.applets[0].getdata(m_url);
	load_interface(m_url,'XML',false);
}

	
		
function dis_copying(){ 
        m_url_rout=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?ndate="+m_nextdate1+"&chksql=chk_equity";
	//window.open(m_url_rout);
				//top.frames[0].document.applets[0].getdata(m_url_rout);
	            load_interface(m_url_rout,'XML',false);	
			   // m_size=top.frames[0].document.applets[0].outvec_value.size();
	              m_size=data_vec.length;
			  //alert(top.frames[0].document.applets[0].outvec_value.elementAt(0));
				if (m_size > 0)
				{
				 alert("There are incomplete transactions.Complete them before running the day end routine")
				}
				else
				{   
				  m_url_rout=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?ndate="+m_nextdate1+"&chksql=chk_margin_status";
				 // window.open(m_url_rout);
					//top.frames[0].document.applets[0].getdata(m_url_rout);
					load_interface(m_url_rout,'XML',false);		
			        //m_size=top.frames[0].document.applets[0].outvec_value.size();
					m_size=data_vec.length;
			   
					//if(m_size>0){ --temp commented
					    /* 
					    ----------------------------2011-09-19 REPLACED WITH show_dayend()-------------------------------- 
					    m_url="<%=m_jsp_client_url%>/Daily_Routine_gif.jsp"; 
						popupwin = window.open(m_url,'popupwin','left=290,top=250,width=330,height=165,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=0,resizable=1');
						popupwin.focus();
						----------------------------2011-09-19 REPLACED WITH show_dayend()--------------------------------
						*/
						
					    show_dayend(); //added 2011-09-19
				  	    timerID = setTimeout("Deal_proc()",2000);
					/*
					temp commented
					  }else{
					  document.Form1.Text_ndd.disabled=true;
						document.Form1.Text_nmm.disabled=true;
						document.Form1.Text_nyy.disabled=true;
					  alert("Daily Margin Trading Activities are pending please complete them before running the day end routine.")
					}*/
					//temp commented
				}		
	 	}  
			
function Deal_proc(){     
	  data="";
	  m_url_rout=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?ndate="+m_nextdate1+"&chksql=exe_dayend";
		//top.frames[0].document.applets[0].getdata(m_url_rout);
	    load_interface(m_url_rout,'XML',false);	 
	    //m_size=top.frames[0].document.applets[0].outvec_value.size();
	     m_size=data_vec.length;
	  //alert(top.frames[0].document.applets[0].outvec_value.elementAt(0));
		//if(top.frames[0].document.applets[0].outvec_value.elementAt(0)=="ok"){
	   if( data_vec[0]=="ok")
	   {
	  	 // popupwin.close(); //commented 2011-09-19 since adding iframes for the GIF file
			 //*close the iframe when day end is completed
		     if ($("#DIV_DAY_END_ROUTINE").dialog("isOpen")) 
			 {
            		$("#DIV_DAY_END_ROUTINE").dialog("close");
             }	
	  	// window.location.href=html_client_url+"/dn_suc_msg.jsp";
	
		  window.location.href=<%="\""+m_jsp_client_url+"\""%>+"/dn_suc_msg.jsp";		
		   	
	  }
	  else
	 {
		alert("An Error Occured While Processing the Day End "+data_vec[0]);
	  	// popupwin.close(); //commented 2011-09-19 since adding iframes for the GIF file
		//*close the iframe when day end is completed //repleced the pop up window close by here
		   if ($("#DIV_DAY_END_ROUTINE").dialog("isOpen")) 
		   {
        		$("#DIV_DAY_END_ROUTINE").dialog("close");
				
           }		
	  	for (var i=0; m_size>i;i++) 
		{
	  	 //data=data+top.frames[0].document.applets[0].outvec_value.elementAt(i);
		   data=data+data_vec[i];		
	  	}	
 	 	window.location.href=<%="\""+m_jsp_client_url+"\""%>+"/Daily_Routine.jsp";
 	 }
}
	
	
	//============== Added By Manjula on 14/07/2004 VC 04-162=================

function proceed_check()
{


      m_nextdate11=document.Form1.Text_ndd.value+'-'+document.Form1.Text_nmm.value+'-'+document.Form1.Text_nyy.value;
	  //alert(m_nextdate11);
	  m_url_vali=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?ndate="+m_nextdate11+"&chksql=validate_new";
      //top.frames[0].document.applets[0].getdata( m_url_vali);
	  load_interface(m_url_vali,'XML',false);
	  //m_size1val=top.frames[0].document.applets[0].outvec_value.size();
	  m_size1val=data_vec.length;
	  daily_mgt_pro_chk= data_vec[0];
	  Holiday_chk= data_vec[1];
	  tran_chk= data_vec[2];
	  
	   //-------add by waruna 2011-05-04------
	   m_url_vali=servlet_client_url+":"+client_t3_port+"/"+client_name+"auto_reporollover1?val_fromdate="+m_nextdate11+"&val_todate="+m_nextdate11+"&chksql=chk_auto_repo"; 
	   //window.open(m_url_vali);
	   //top.frames[0].document.applets[0].getdata( m_url_vali);
	   load_interface(m_url_vali,'XML',false);
	   //loan_exists= top.frames[0].document.applets[0].outvec_value.elementAt(0);
		loan_exists= data_vec[0];
	
	
	//alert(top.frames[0].document.applets[0].outvec_value.elementAt(0));
	  //alert(top.frames[0].document.applets[0].outvec_value.elementAt(1));
	  //alert(top.frames[0].document.applets[0].outvec_value.elementAt(2));
	//if mgt not run && not Holiday && LOAN_EXISTS
	
	//alert(loan_exists);

	 if(daily_mgt_pro_chk==0 && Holiday_chk==0 && loan_exists=='LOAN_EXISTS'){
	 alert("Please Run Margin Trading Routine");
	   // goingToProce(); 
	 }
	 // if not holiday && trn not exsists
	else  if(Holiday_chk==0 && tran_chk==0){ //comment the else keyword part//test comment 2011-09-16
	 
	    for(i=0;i<9;i++){
		 if(!confirm("Do You want to Proceed.."))
		  break;
		}
		
		if(confirm("Do You want to Proceed.."))
	     { goingToProce();
		 }
	 
	 }
	 //if holiday && trn exists
	 else if(Holiday_chk>0 && tran_chk>0){
	     if(confirm("Holiday! Do You want to Proceed.."))
	       {
	          goingToProce();
	       }
	}
	 else{
	      if(confirm("Do You want to Proceed"))
	        {
		   goingToProce();
		   }
	  
	 
	 }
	 
	 
	 
	 
	  
	


}


function goingToProce(){
 m_nextdate11=document.Form1.Text_ndd.value+'-'+document.Form1.Text_nmm.value+'-'+document.Form1.Text_nyy.value;

	    m_url_rout=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?ndate="+m_nextdate11+"&chksql=chk_foll_day";
		
	    m_url_rout1=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?ndate1="+m_nextdate11+"&chksql=show_deals_foll_day";
		//top.frames[0].document.applets[0].getdata(m_url_rout);
	    load_interface(m_url_rout,'XML',false);
		//m_size1=top.frames[0].document.applets[0].outvec_value.size();
	    m_size1=data_vec.length;
		
		if(m_size1 > 0){ 
		
              if (!confirm('There are deals which mature tomorrow and whose securities have been allocated to various other repos.To view the deals press Cancel or else Continue to proceed with Day End Routine'))
                {
					 	    document.Form1.Text_ndd.disabled=false;
							document.Form1.Text_nmm.disabled=false;
							document.Form1.Text_nyy.disabled=false;					
					  /*
					  COMMENTED 2011-09-19 ADDED IFRAME
				      popupwin2 = window.open( m_url_rout1,'displayWindow2','left=180,top=165,width=418,height=200,toolbar=0,location=0,directories=0,status=1,menuBar=1,scrollBars=1,resizable=1');
				      popupwin2.focus();
					  COMMENTED 2011-09-19 ADDED IFRAME
					 */
					  show_popup1(m_url_rout1);
					
		       }		
               else
			    {
			       proceed()
			    }	
			
		}
		else
		{
		proceed()
        }
}


//============== End Here == Manjula VC 04-162 == 14/07/2004 ===========================
	

function proceed(){
m_status="";

m_currdate1=document.Form1.Text_cdd.value+'-'+document.Form1.Text_cmm.value+'-'+document.Form1.Text_cyy.value;
 m_nextdate1=document.Form1.Text_ndd.value+'-'+document.Form1.Text_nmm.value+'-'+document.Form1.Text_nyy.value;

// m_currdate=new Date(document.Form1.Text_cyy.value,document.Form1.Text_cmm.value,document.Form1.Text_cdd.value);
// m_nextdate=new Date(document.Form1.Text_nyy.value,document.Form1.Text_nmm.value,document.Form1.Text_ndd.value);
  
	/////////added by sva on 01-02-2006///////////////////////////////////////////	
 m_url_rout=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?cdate="+m_currdate1+"&ndate="+m_nextdate1+"&chksql=chk_fdate";
 //top.frames[0].document.applets[0].getdata(m_url_rout);
 load_interface(m_url_rout,'XML',false);	
 //m_size=top.frames[0].document.applets[0].outvec_value.size();
 	m_size=data_vec.length;
 if(m_size>0){ 	
   //m_status= top.frames[0].document.applets[0].outvec_value.elementAt(0);
	 m_status= data_vec[0];	
 }	
 //////////////////////////////////////////////	

	
	
	//if(m_currdate<m_nextdate){
	 if(m_status=="NO"){	//changed by sva on 01-02-2006//

	 	  m_url_rout=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?ndate="+m_nextdate1+"&chksql=chk_holiday";
	 	  //top.frames[0].document.applets[0].getdata(m_url_rout);
		    load_interface(m_url_rout,'XML',false);	
			//m_size=top.frames[0].document.applets[0].outvec_value.size();
			  m_size=data_vec.length;
			//alert("hiliday");
			//window.open(m_url_rout);
			//alert(m_size);
			if(m_size>0){ 
				 if (confirm('Are you sure ! Today is '+m_currdate1+'..Press the OK button if you want to process the Day End Routine for '+m_nextdate1+' (Holiday) or Press the Cancel button to Exit')) {
			 	 document.Form1.Text_ndd.disabled=false;
					document.Form1.Text_nmm.disabled=false;
					document.Form1.Text_nyy.disabled=false;
				    //commented by sva on 07-02-2005 
						//if (confirm("Are you sure ? have you run the custodial process if needed ")) {
						
						//ADDED BY SVA ON 07-02-2005 
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?mdate="+document.Form1.Text_ndd.value+"-"+document.Form1.Text_nmm.value+"-"+document.Form1.Text_nyy.value+"&chksql=chkratesequity";
						//top.frames[0].document.applets[0].getdata(m_url);
						load_interface(m_url,'XML',false);	
						//m_size=top.frames[0].document.applets[0].outvec_value.size();  
						m_size=data_vec.length;  
					    	//if (top.frames[0].document.applets[0].outvec_value.elementAt(0) > 0) {  
								   dis_copying();
								/*}
								else
								{
												alert("PLEASE ENTER THE MARKET RATES FOR EQUITY AS AT "+document.Form1.Text_ndd.value+"-"+document.Form1.Text_nmm.value+"-"+document.Form1.Text_nyy.value )
								
								}*/
           //END
					    
				    /*}
						else{
						 top.frames[1].location.href='low.html';
						}*/
						//end
					} 
				 else{
			  	       //top.frames[1].location.href='low.html';
						window.location.href='<%=m_jsp_client_url%>/low.jsp';
				 }   
			}
			else{
			//alert("disavl");
				document.Form1.BUT_BCODE.disabled=true;
			}
 }
 else {
	document.Form1.Text_ndd.disabled=false;
	document.Form1.Text_nmm.disabled=false;
	document.Form1.Text_nyy.disabled=false;
	 //commented by sva on 07-02-2005 
	 //if (confirm("Are you sure ? have you run the custodial process if needed ")) {
	   //ADDED BY SVA ON 07-02-2005 
						m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?mdate="+document.Form1.Text_ndd.value+"-"+document.Form1.Text_nmm.value+"-"+document.Form1.Text_nyy.value+"&chksql=chkratesequity";
						//top.frames[0].document.applets[0].getdata(m_url);
						load_interface(m_url,'XML',false);	
						//m_size=top.frames[0].document.applets[0].outvec_value.size();  
						m_size=data_vec.length;  
					    	//if (top.frames[0].document.applets[0].outvec_value.elementAt(0) > 0) {  
								   dis_copying();
								/*}
								else
								{
												alert("PLEASE ENTER THE MARKET RATES FOR EQUITY AS AT "+document.Form1.Text_ndd.value+"-"+document.Form1.Text_nmm.value+"-"+document.Form1.Text_nyy.value )
								
								} */
								//end
	 /*}
	 else{
		 top.frames[1].location.href='low.html';
	 }*/
	 //end 
}
}
/*function proceed(){
 m_currdate1=document.Form1.Text_cdd.value+'-'+document.Form1.Text_cmm.value+'-'+document.Form1.Text_cyy.value;
 m_nextdate1=document.Form1.Text_ndd.value+'-'+document.Form1.Text_nmm.value+'-'+document.Form1.Text_nyy.value;

 m_currdate=new Date(document.Form1.Text_cyy.value,document.Form1.Text_cmm.value,document.Form1.Text_cdd.value);
 m_nextdate=new Date(document.Form1.Text_nyy.value,document.Form1.Text_nmm.value,document.Form1.Text_ndd.value);
 if(m_currdate<m_nextdate){
	if (confirm('Are you sure ! Today is '+m_currdate1+'..Press the OK button if you want to process the Day End Routine for '+m_nextdate1+' or Press the Cancel button to Exit')) {
		document.Form1.Text_ndd.disabled=false;
		document.Form1.Text_nmm.disabled=false;
		document.Form1.Text_nyy.disabled=false;
		dis_copying();
			} 
	else{
		top.frames[1].location.href='low.html';
	}   
 }
 else {
	document.Form1.Text_ndd.disabled=false;
	document.Form1.Text_nmm.disabled=false;
	document.Form1.Text_nyy.disabled=false;
	dis_copying();
}
}*/
function get_date() {   
	m_urls=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?chksql=get_sysdate";
	//top.frames[0].document.applets[0].getdata(m_urls);
	load_interface(m_urls,'XML',false);
	
	m_size=data_vec.length;

	if(m_size>0)
	{	
		document.Form1.Text_cdd.value=data_vec[0];
		document.Form1.Text_cmm.value=data_vec[1];
		document.Form1.Text_cyy.value=data_vec[2];
		document.Form1.Text_cdd.disabled=true;
		document.Form1.Text_cmm.disabled=true;
		document.Form1.Text_cyy.disabled=true;
	}	
	
}



 function display_last(){
		m_urld=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?chksql=chk_lastdate";
		//top.frames[0].document.applets[0].getdata(m_urld);
		load_interface(m_urld,'XML',false);
		//m_size=top.frames[0].document.applets[0].outvec_value.size(); 
		m_size=data_vec.length;
		if (m_size>0) {  
				document.Form1.Text_ldd.value=data_vec[0];
				document.Form1.Text_lmm.value=data_vec[1];
				document.Form1.Text_lyy.value=data_vec[2];
			    document.Form1.Text_ldd.disabled=true;
				document.Form1.Text_lmm.disabled=true;
				document.Form1.Text_lyy.disabled=true;
		}
		else{
		}
}

/* comment by waruna 2011-03-24 seems duplicat fucntion
 function chk_confirm(){
		
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?chksql=chk_confirm_deal1";
	    top.frames[0].document.applets[0].getdata(m_url);
		m_size=top.frames[0].document.applets[0].outvec_value.size();        
		if (m_size>0) { 
		m_url5=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?chksql=chk_confirm_deal";
		popupwin2 = window.open(m_url5,'displayWindow2','left=180,top=165,width=418,height=200,toolbar=0,location=0,directories=0,status=1,menuBar=1,scrollBars=1,resizable=1');
		popupwin2.focus();
		document.Form1.BUT_BCODE.disabled=true;
	  }
		else{
		document.Form1.BUT_BCODE.disabled=false;
		}
		}
	*/
	
	
	
	function display_next(){
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?chksql=get_nextdate";
		//top.frames[0].document.applets[0].getdata(m_urln);
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;        
		if (m_size>0) {  
				document.Form1.Text_ndd.value=data_vec[0];
				document.Form1.Text_nmm.value=data_vec[1];
				document.Form1.Text_nyy.value=data_vec[2];
			  	document.Form1.Text_ndd.disabled=true;
				document.Form1.Text_nmm.disabled=true;
				document.Form1.Text_nyy.disabled=true;
		}
		else{
		}
}





function beforesubmit() {
document.Form1.action=servlet_client_url+":"+client_t3_port+"/"+client_name+"mfsavday_rout";
 document.Form1.submit(); 
}							
	
<!---------------- Added by S.Shanheetha on 01-03-2007 for SR0702-077 --------------->

 		function chk_confirm(){
		
		//------------------add by waruna 2011-03-24------------------
		document.Form1.BUT_BCODE.disabled=true;
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?chksql=chk_confirm_deal2";
		//window.open(m_url);
		//top.frames[0].document.applets[0].getdata(m_url);
		load_interface(m_url,'XML',false);
		m_size=data_vec.length; 
		if (m_size>0) { 
			if(data_vec[0]>0){
			document.Form1.BUT_BCODE.disabled=true; //test comment 2011-09-09
			alert('Please Confirm Deal/s Before Run the Day End Routine');
			}else{
			document.Form1.BUT_BCODE.disabled=false;
			}
		}else{
		document.Form1.BUT_BCODE.disabled=false;
		}
		//------------------END add by waruna 2011-03-24------------------
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?chksql=chk_confirm_deal1";
		//top.frames[0].document.applets[0].getdata(m_url);
		load_interface(m_url,'XML',false);
		m_size=data_vec.length;         
		if (m_size>0) { 
		m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?chksql=chk_confirm_deal";
		/*
		//2011-09-19 commented
		popupwin2 = window.open(m_url,'displayWindow2','left=180,top=165,width=418,height=200,toolbar=0,location=0,directories=0,status=1,menuBar=1,scrollBars=1,resizable=1');
		popupwin2.focus();
		
		*/	
		show_popup2(m_url);	
			
		document.Form1.BUT_BCODE.disabled=true; //test comment 2011-09-16 and enabled
			
	   
		}
		else{
		//document.Form1.BUT_BCODE.disabled=false;
		}
		 chk_facilityapp(); //added by Prabash on 20-05-2013 		
		}
	
	//added by Prabash on 20-05-2013--------------**
		function chk_facilityapp(){
			//alert('ggggggggg');
			document.Form1.BUT_BCODE.disabled=true;
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?chksql=chk_app_facility";
			//window.open(m_url);
			//top.frames[0].document.applets[0].getdata(m_url);
			load_interface(m_url,'XML',false);
			m_size=data_vec.length; 
			if (m_size>0) { 
				if(data_vec[0]>0){
					document.Form1.BUT_BCODE.disabled=true; //test comment 2011-09-09
					alert('Please Approve Facility /s Before Run the Day End Routine');
				}else{
					document.Form1.BUT_BCODE.disabled=false;
				}
			}else{
				document.Form1.BUT_BCODE.disabled=false;
			}
			
			m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?chksql=chk_app_facility1";
			//	window.open(m_url);
			//top.frames[0].document.applets[0].getdata(m_url);
			load_interface(m_url,'XML',false);
			m_size=data_vec.length;         
			if (m_size>0) { 
				m_url=servlet_client_url+":"+client_t3_port+"/"+client_name+"dnvalday_rout?chksql=chk_app_facility2";
				/*
				//2011-09-19 commented
				popupwin2 = window.open(m_url,'displayWindow2','left=180,top=165,width=418,height=200,toolbar=0,location=0,directories=0,status=1,menuBar=1,scrollBars=1,resizable=1');
				popupwin2.focus();
				
				*/	
				show_popup3(m_url);	
				
				document.Form1.BUT_BCODE.disabled=true; //test comment 2011-09-16 and enabled
				
			}
			
			
			
			else{
				//document.Form1.BUT_BCODE.disabled=false;
			}
			
		}
		//--------------------------------------------**
	
	
	
	       function initdayendDrillDialog()
	       {
				
             $("#DIV_DAY_END_ROUTINE").dialog(
			
			 {
				
            	bgiframe: true,
            	autoOpen: false,
            	//modal: false,
				modal: true, //to disable the back ground	
            	height: 300,
            	width: getW,
            	close: function() 
				{
					
            	}
              }
			 );
           }	
	
		   function initdayendpopup1dialog()
	       {
				
             $("#DIV_DAY_END_POUP1").dialog(
			
			 {
				
            	bgiframe: true,
            	autoOpen: false,
            	//modal: false,
				modal: true, //to disable the back ground	
            	height: 600,
            	width: getW,
            	close: function() 
				{
					
            	}
              }
			 );
           }
	
		   function initdayendpopup2dialog()
	       {
				
             $("#DIV_DAY_END_POUP2").dialog(
			
			 {
				
            	bgiframe: true,
            	autoOpen: false,
            	//modal: false,
				modal: true, //to disable the back ground	
            	height: 600,
            	width: getW,
            	close: function() 
				{
					
            	}
              }
			 );
           }
		
			
	
	        function getW() {
            var w = 0;
            if (window.document.innerWidth > w) {
            w = window.document.innerWidth;
            }
            if (window.document.documentElement.clientWidth > w) {
            w = window.document.documentElement.clientWidth;
            }
            return (w - 100);
			}
	
	        function clearIsOpen()
			{ 
              isOpen=false; 
            }
	
			var isOpen=false;
	

			function show_dayend() 
	        { 
            	if ($("#DIV_DAY_END_ROUTINE").dialog("isOpen")) 
				{
            		$("#DIV_DAY_END_ROUTINE").dialog("close");
            	}
            	$("#DIV_DAY_END_ROUTINE").dialog("option", "title", "Day End Routine");
            	$("#DIV_DAY_END_ROUTINE").dialog("open");
				m_url="<%=m_jsp_client_url%>/Daily_Routine_gif.jsp";
            	$("#IFRAME_DAY_END_ROUTINE").attr("src",m_url);
            	return false;
            }
	
	
			function show_popup1(m_url) 
	        { 
            	if ($("#DIV_DAY_END_POUP1").dialog("isOpen")) 
				{
            		$("#DIV_DAY_END_POUP1").dialog("close");
            	}
            	$("#DIV_DAY_END_POUP1").dialog("option", "title", "Day End Routine");
            	$("#DIV_DAY_END_POUP1").dialog("open");
				//m_url="<%=m_jsp_client_url%>/Daily_Routine_gif.jsp"; COMMENTED 2011-09-19
            	$("#IFRAME_DIV_DAY_END_POUP1").attr("src",m_url);
            	return false;
            }
		
			function show_popup2(m_url) 
	        { 
				
            	if ($("#DIV_DAY_END_POUP2").dialog("isOpen")) 
				{
            		$("#DIV_DAY_END_POUP2").dialog("close");
            	}
            	$("#DIV_DAY_END_POUP2").dialog("option", "title", "Day End Routine");
            	$("#DIV_DAY_END_POUP2").dialog("open");
				//m_url="<%=m_jsp_client_url%>/Daily_Routine_gif.jsp"; COMMENTED 2011-09-19
            	$("#IFRAME_DIV_DAY_END_POUP2").attr("src",m_url);
            	return false;
            }
	
	//added by Prabash on 30-05-2013--------------------**
		function show_popup3(m_url) 
		{ 
			
			if ($("#DIV_DAY_END_POUP3").dialog("isOpen")) 
			{
				$("#DIV_DAY_END_POUP3").dialog("close");
			}
			$("#DIV_DAY_END_POUP3").dialog("option", "title", "Day End Routine");
			$("#DIV_DAY_END_POUP3").dialog("open");
			//m_url="<%=m_jsp_client_url%>/Daily_Routine_gif.jsp"; COMMENTED 2011-09-19
			$("#IFRAME_DIV_DAY_END_POUP3").attr("src",m_url);
			return false;
		}
		//-------------------------------------------------**
	
			//added by 2011-09-16
			$(document).ready
			(
				
				function() 
				{
	 				initdayendDrillDialog();
					initdayendpopup1dialog();
					initdayendpopup2dialog();
				}
			);		

	
<!---------------------- End --------------------------------------------------------> 	
		function  exit()
		{
			window.location.href='<%=m_jsp_client_url%>/low.jsp';
			
		}		
	
		
</SCRIPT>
<BODY ONLOAD="default_actions();get_date(),display_last(),display_next(),chk_confirm()"> <!--Added chk_confirm() by S.Shanheetha on 01-03-2007 for SR0702-077 --> 
	<FORM NAME="Form1" METHOD="POST" ><!--,chk_confirm()-->
	<TABLE WidTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" STYLE="{color: black; font: bold 9pt arial;}">							
	<TR>			
	<TD WidTH="1%"></TD>				
	<TD WidTH="99%"><!-- ***** -->
						
						
		<TABLE WIDTH="100%" BORDER="0" CELLPADDING="0" CELLSPACING="0" STYLE="{color: black; font: bold 9pt arial;}" >
		        <tr>
					<td height='7'></td>
				</tr>
							<TR HEIGHT="30">		
						<td  width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l1.gif');background-repeat:no repeat;" id='hi1'></td>
						<td  style ="background-image:url('<%=m_jsp_client_url%>/images/l3.gif');background-repeat:repeat;" id='hi2' align='left'><B>Margin Trading - Day End Routine</B></td>
						<td width='13' style ="background-image:url('<%=m_jsp_client_url%>/images/l2.gif');background-repeat:no repeat;"  id='hi3'></td>
			</TR>
		</TABLE>		

		<TABLE WIDTH="100%" BORDER="0" BGCOLOR="darkblue" STYLE="{border-style: none;}">
			  <TR >
					<TD WIDTH="70%"></TD>
					<TD WIDTH="8%" >
							<INPUT TYPE="Button" NAME="Exit_but" VALUE=" &nbsp;Exit&nbsp;  " CLASS="mainbut"  onClick="exit()"> <!-- STYLE="{cursor:hand; color: black; font: bold 9pt arial;border-style: outset;background-color: darkgray; }" -->
					</TD>			 
					<TD WIDTH="22%"  WIDTH="100%" ALIGN = "RIGHT">
							 	<DIV ID="display_name"><B>Day End Routine</B> </DIV>
					</TD>	  				
			  </TR>              
		</TABLE>
					<HR>

		<BR>
		<TABLE WIDTH="100%" BORDER="0" CELLPADDING="1" CELLSPACING="0">
			<TR>	
				<TD WIDTH="30%">Current Date</TD>
				<TD WIDTH="25%">
								    <INPUT	TYPE="Text" NAME="Text_cdd"	ALIGN="LEFT" SIZE="2"  MAXLENGTH="2" class="txt_input5">
									<INPUT  TYPE="text" NAME="Text_cmm"	ALIGN="LEFT" SIZE="2"  MAXLENGTH="2" class="txt_input5">
									<INPUT TYPE="text" NAME="Text_cyy"	ALIGN="LEFT" SIZE="4"  MAXLENGTH="4" class="txt_input5" ONBLUR="checkMonthLength(Text_date_dd,Text_date_mm,Text_date_yy)" >
				</TD>
				<TD WIDTH="5%"></TD>				
				<TD WIDTH="*%">
				</TD>					
			</TR>
			<TR>	        
				 <TD WIDTH="30%" >Last Day End Processed</TD>
			     <TD WIDTH="25%">
					<INPUT	TYPE="Text" NAME="Text_ldd"	ALIGN="LEFT" SIZE="2"  MAXLENGTH="2" class="txt_input5">
					<INPUT TYPE="text" NAME="Text_lmm"	ALIGN="LEFT" SIZE="2"  MAXLENGTH="2" class="txt_input5" >
					<INPUT TYPE="text" NAME="Text_lyy"	ALIGN="LEFT" SIZE="4"  MAXLENGTH="4" class="txt_input5" ONBLUR="checkMonthLength(Text_date_dd,Text_date_mm,Text_date_yy)" >
				 </TD>
				 <TD WIDTH="5%"></TD>				
				 <TD WIDTH="*%">
				 </TD>					
			</TR>
 			<TR>	
				 <TD WIDTH="30%">To be Processed</TD>
		     	 <TD WIDTH="25%">
								 <INPUT	TYPE="Text" NAME="Text_ndd"	ALIGN="LEFT" SIZE="2"  MAXLENGTH="2" class="txt_input5" >
								 <INPUT TYPE="text" NAME="Text_nmm"	ALIGN="LEFT" SIZE="2"  MAXLENGTH="2" class="txt_input5">
								 <INPUT TYPE="text" NAME="Text_nyy"	ALIGN="LEFT" SIZE="4"  MAXLENGTH="4" class="txt_input5" ONBLUR="checkMonthLength(Text_date_dd,Text_date_mm,Text_date_yy)" >
				 </TD>
				 <TD WIDTH="5%"></TD>				
				 <TD WIDTH="*%">
								 <INPUT TYPE="button" 	ALIGN="LEFT" VALUE="Proceed" NAME="BUT_BCODE" CLASS="mainbut" ONCLICK="proceed_check()" STYLE="{cursor:hand; }">
				 </TD>
			 </TR>
		</TABLE>
						
						
	</TD><!-- ---   -->
	</TR>
    </TABLE> 
			
	  <div id ="DIV_DAY_END_ROUTINE" title ="Day End Routine">
      <iframe id ="IFRAME_DAY_END_ROUTINE" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Day End Routine">
      </iframe>
      </div>
			
	  <div id ="DIV_DAY_END_POUP2" title ="Day End Routine">
      <iframe id ="IFRAME_DIV_DAY_END_POUP2" width = "100%" height = "100%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Day End Routine">
      </iframe>
      </div>
			
	  <div id ="DIV_DAY_END_POUP3" title ="Day End Routine">
	  <iframe id ="IFRAME_DIV_DAY_END_POUP3" width = "100%" height = "50%" marginWidth = "0" marginHeight = "0" frameBorder = "0" scrolling = "auto" title = "Day End Routine">
	  </iframe>
	  </div>		
			
	 		
		
			
	  		
            
	
		<DIV id="disp_copy" STYLE="{cursor: default; position: absolute; left: 360px; top: 360px; visibility: visible; overflow: hidden;}"></DIV>
    </FORM>
	<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>
	<SCRIPT language="JavaScript1.2" SRC="ajax_data_gateway.js"></SCRIPT>	
</body>
</html>
