var servlet_client_url="https://dev-adlmargin.sasianet.com";
var html_client_url="https://dev-adlmargin.sasianet.com/intranet";
var client_t3_port="8080/myserver/servlet";
var client_name="LBMARGIN_"
			  
			
				
//------------------FIRST LEVEL DRILLDOWNS-------------------------------------------------------------------------------------------//				
function display_trn_v1(m_security,m_maturity,m_date,m_basis,m_inst,m_port,m_deal_type) {
//alert(m_deal_type);
//alert(m_port);
m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'inventory_by_date?mdate='+m_date+'&security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&deal_type='+m_deal_type+'&chksql=detail_trn';
popupwin = window.open(m_url,'displayWindow74','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
popupwin.focus();
}
function display_sec_v1(m_security,m_maturity,m_date,m_basis,m_inst,m_port,m_deal_type) {
//alert(m_deal_type);
//alert(m_port);
m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'inventory_by_date?mdate='+m_date+'&security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&deal_type='+m_deal_type+'&chksql=detail_sec';
popupwin = window.open(m_url,'displayWindow74','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
popupwin.focus();
}
function display_sno_v1(m_security,m_maturity,m_date,m_basis,m_inst,m_port,m_deal_type)	 {
//alert(m_deal_type);
//alert(m_port);
m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'inventory_by_date?mdate='+m_date+'&security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&deal_type='+m_deal_type+'&chksql=detail_sno';
popupwin = window.open(m_url,'displayWindow74','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
popupwin.focus();
}
//------------------SECOND LEVEL DRILLDOWNS-------------------------------------------------------------------------------------------//				
function display_trn(m_port,m_inst,m_date,m_security,m_maturity,m_basis) {
m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'inventory_by_date?mdate='+m_date+'&security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_trn_next';
popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
popupwin.focus();
}
function display_sec(m_port,m_inst,m_date,m_security,m_maturity,m_basis,m_deal_type) {
//alert(m_port);
//alert(m_deal_type);
m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'inventory_by_date?mdate='+m_date+'&security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&deal_type='+m_deal_type+'&chksql=detail_sec_next';
popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
popupwin.focus();
}
function display_sno(m_port,m_inst,m_date,m_security,m_maturity,m_basis,m_deal_type) {
m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'inventory_by_date?mdate='+m_date+'&security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&deal_type='+m_deal_type+'&chksql=detail_sno_next';
popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
popupwin.focus();
}
//--------------THIRD LEVEL DRILLDOWNS--------------------------------------------------------------------------------------------------//
function display_more_outinv(m_portcode,insttype,m_seccode,m_serial_no,m_deal_type) {
m_url_outinv=servlet_client_url+':'+client_t3_port+'/'+client_name+'inventory_by_date?portcode='+m_portcode+'&instrument='+insttype+'&seccode='+m_seccode+'&serial_no='+m_serial_no+'&deal_type='+m_deal_type+'&chksql=moredata_outinv';
popupwin2 = window.open(m_url_outinv,'displayWindow25','left=0,top=0,width=400,height=400,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
popupwin2.focus();
}
//--------------THIRD LEVEL DRILLDOWNS2--------------------------------------------------------------------------------------------------//
//added By Keith on 30-9-2004/12:9 
//serial
function display_more_outinv2(m_port,m_seccode,m_location,m_deal_type,m_date,m_maturity) {
m_url_outinv=servlet_client_url+':'+client_t3_port+'/'+client_name+'inventory_by_date?portcode='+m_port+'&seccode='+m_seccode+'&location='+m_location+'&dealtype='+m_deal_type+'&date='+m_date+'&maturity='+m_maturity+'&chksql=moredata_outinv2';
popupwin2 = window.open(m_url_outinv,'displayWindow25','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
popupwin2.focus();
}
//sec
function display_more_outinvsec2(m_port,m_seccode,m_location,m_deal_type,m_date,m_maturity) {
m_url_outinv=servlet_client_url+':'+client_t3_port+'/'+client_name+'inventory_by_date?portcode='+m_port+'&seccode='+m_seccode+'&location='+m_location+'&dealtype='+m_deal_type+'&date='+m_date+'&maturity='+m_maturity+'&chksql=moredata_outinvsec2';
popupwin2 = window.open(m_url_outinv,'displayWindow25','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
popupwin2.focus();
}
//-------------FOURTH LEVEL DRILLDOWNS--------------------------------------------------------------------------------------------------//
function display_out2O(m_seccode,m_serial_no) {
m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'inventory_by_date?seccode='+m_seccode+'&serial_no='+m_serial_no+'&chksql=detail_data_out';
popupwin = window.open(m_url,'displayWindow3','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
popupwin.focus();
}

//----------------FUNCTIONS NOT IN USE---------------------------------------------------------------------------------------------------//			  
function display_secsum(m_security,m_maturity,m_basis,m_inst,m_port) {
m_url=servlet_client_url+':'+client_t3_port+'/'+client_name+'foffice_inventory?security='+m_security+'&maturity='+m_maturity+'&basis='+m_basis+'&inst='+m_inst+'&port='+m_port+'&chksql=detail_secsum';
popupwin = window.open(m_url,'displayWindow72','left=120,top=175,width=600,height=180,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1');
popupwin.focus();
}
function showm() {
m_write = '<DIV ID="divMenu" STYLE="{font-family: arial; font-size: 8pt; line-height: 11pt; cursor: hand; color: black; background-color: #FFFFE1; padding: 1px; text-align: left; position: absolute; visibility: visible; overflow: hidden; border-style: outset; border-color: black; border-width: 1; width: 70pt; }">'+
'<DIV>Click to go Back</DIV>'+
'</DIV>';
menuu.innerHTML=m_write;
}
function hidem()  {
divMenu.style.visibility = "hidden";        
}
function  display_client_details1() {
}
//---------------------------------------------------------------------------------------------------------------------------------------//
				
				

