var servlet_client_url="https://dev-adlmargin.sasianet.com";
	var html_client_url="https://dev-adlmargin.sasianet.com/intranet";
  var client_t3_port="8080/myserver/servlet";
	//var client_name="E1_";
	        var client_name="LBMARGIN_"

	var default_user="pabcALL";
	
  function details(mdealno){
  //alert("hi");
  //alert("DEAL NO IS"+mdealno);
	//alert(servlet_client_url);

	m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'boffice_checkreports?dealnum='+mdealno+'&chksql=mrep_data8';
	
  popupwin2 = window.open(m_url,'displayWindow3','left=0,top=133,width=900,height=380,toolbar=0,location=0,directories=0,status=0,menuBar=1,scrollBars=1,resizable=1');
  popupwin2.focus();
			
	}
 

  
