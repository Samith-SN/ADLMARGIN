// -----------------------------------------------------------------------
// 	NAVIGATION FOR MENUBAR AND MENUITEMS
// -----------------------------------------------------------------------
// -----------------------------------------------------------------------
// 	Global variables to track menu state
// -----------------------------------------------------------------------
var eNavBarItemShown = null;
var eMenuShown = null;
var esubSrc = null;
var esub1Src = null;
var oldesubSrc = null;
var oldesub1Src = null;
// -----------------------------------------------------------------------
// 	Conditional global event-handlers
// -----------------------------------------------------------------------

function document_click()	{
	if ("clsNavBarItemShown" != window.event.srcElement.className && null != eMenuShown) HideMenu();
}

function subdocument_click(){
	parent.frames[0].document.all["divMenu1"].style.visibility   = "hidden";
	//parent.frames[0].document.all["divMenu2"].style.visibility   = "hidden";
	parent.frames[0].document.all["divMenu3"].style.visibility   = "hidden";
	parent.frames[0].document.all["divMenu4"].style.visibility   = "hidden";
	parent.frames[0].document.all["divMenu5"].style.visibility   = "hidden";
	//parent.frames[0].document.all["divMenu2_1"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_1"].style.visibility = "hidden";
	//parent.frames[0].document.all["divMenu3_2"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_3"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_4"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_6"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_6_1"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu6_1"].style.visibility   = "hidden";
	parent.frames[0].document.all["divMenu3_6_2"].style.visibility = "hidden";
	
}

function document_keypress()	{
	if ("27" == window.event.keyCode && null != eMenuShown) HideMenu();
}

function window_blur()	{
	if (null != eMenuShown) HideMenu();
}

// -----------------------------------------------------------------------
// 	Cache/Uncache functions to store and bind if menu shown
// -----------------------------------------------------------------------

function CacheAndBind()	{
	window.CachedClick = document.onclick;
	window.CachedKeypress = document.onkeypress;
	window.CachedBlur = window.onblur;
	document.onclick = document_click;
	document.onkeypress = document_keypress;
	window.onblur = window_blur;
}

function UncacheAndRebind()	{
	document.onclick = window.CachedClick;
	document.onkeypress = window.CachedKeypress;
	window.onblur = window.CachedBlur;
}
// -----------------------------------------------------------------------
// 	HideMenu and ShowMenu functions
// -----------------------------------------------------------------------
function HideMenu()	{
	parent.mainframe.rows="37,*";
	//parent.frames[0].document.all["divMenu2_1"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_1"].style.visibility = "hidden";
	//parent.frames[0].document.all["divMenu3_2"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_3"].style.visibility = "hidden";
	//parent.frames[0].document.all["divMenu3_4"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_6"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_6_1"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_6_2"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu6_1"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu4_1"].style.visibility = "hidden";
	
	eMenuShown.style.visibility = "hidden";
	eMenuShown = null;
	eNavBarItemShown.className = "clsNavBarItem";
	eNavBarItemShown = null;
	UncacheAndRebind();
}
function ShowMenu(eSrc)	{
	parent.mainframe.rows="100%,*";
	eMenuShown = null;
	eMenuShown = parent.frames[0].document.all["divMenu" + eSrc.expItemNum];
	if (eMenuShown == null) {
		eMenuShown = parent.frames[0].document.all["divMenu" + eSrc.expItemNum];
	}
	eNavBarItemShown = eSrc;
	eNavBarItemShown.className = "clsNavBarItemShown";
	if (null != eMenuShown) eMenuShown.style.visibility = "visible";
	CacheAndBind();
}
function ShowSubMenu(div_sub_menu_name,m_top,m_left,m_width){
	esubSrc = window.event.srcElement;
	if (oldesubSrc!=null) {
		oldesubSrc.className = "";
	}
	oldesubSrc=esubSrc;
	esubSrc.className = "clsMenuItemOver";
	//Hide all sub menus
	//parent.frames[0].document.all["divMenu2_1"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_1"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_12"].style.visibility = "hidden";
	//parent.frames[0].document.all["divMenu3_2"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_3"].style.visibility = "hidden";
	//parent.frames[0].document.all["divMenu3_4"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_6"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_6_1"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_6_2"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu4_1"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu6_1"].style.visibility = "hidden";
	//Display required sub menu
	eSubMenuShown=parent.frames[0].document.all[div_sub_menu_name];
	eSubMenuShown.style.top=m_top; 
	eSubMenuShown.style.left=m_left; 
	eSubMenuShown.style.width=m_width;
	eSubMenuShown.style.visibility = "visible";
	
}
function ShowSubMenu1(div_sub_menu_name,m_top,m_left,m_width)	{
	esub1Src = window.event.srcElement;
	if (oldesub1Src!=null) {
		oldesub1Src.className = "";
	}
	oldesub1Src=esub1Src;
	esub1Src.className = "clsMenuItemOver";
	//Hide all sub menus
	//Display required sub menu
	eSubMenuShown=parent.frames[0].document.all[div_sub_menu_name];
	eSubMenuShown.style.top=m_top; 
	eSubMenuShown.style.left=m_left; 
	eSubMenuShown.style.width=m_width;
	eSubMenuShown.style.visibility = "visible";
}

function HideSubMenu(div_sub_menu_name)	{
	eSubMenuShown=parent.frames[0].document.all[div_sub_menu_name];
	eSubMenuShown.style.visibility = "hidden";
}
// -----------------------------------------------------------------------
// 	FindTD function used in NavBar event-handlers to determine TD ancestor
// -----------------------------------------------------------------------
function FindTD(eSrc,eContainer){
	while (eContainer.contains(eSrc))	{
		if ("TD" == eSrc.tagName) return eSrc;
		eSrc = eSrc.parentElement;
	}
	return false;
}
// -----------------------------------------------------------------------
// 	NavBar event-handlers (bound below)
// -----------------------------------------------------------------------
function NavBar_mouseover(eContainer)	{
	var eSrc = FindTD(window.event.srcElement,eContainer);
	if (FindTD(window.event.fromElement,eContainer) != eSrc){
		if ("clsNavBarItem" == eSrc.className){
			eSrc.className = "clsNavBarItemOver";
			if (null != eMenuShown)	{
				HideMenu();
				ShowMenu(eSrc);
			}
		}
	}
}
function NavBar_mouseout(eContainer)	{
	var eSrc = FindTD(window.event.srcElement,eContainer);
	if (FindTD(window.event.toElement,eContainer) != eSrc)	{
		if ("clsNavBarItemOver" == eSrc.className) eSrc.className = "clsNavBarItem";
	}
}
function NavBar_click(eContainer)	{
	window.event.cancelBubble = true;
	var eSrc = FindTD(window.event.srcElement,eContainer);
	if ("clsNavBarItemOver" == eSrc.className){
		if (null != eMenuShown) HideMenu();
		ShowMenu(eSrc);
	}
	else if ("clsNavBarItemShown" == eSrc.className){
		if (null != eMenuShown) HideMenu();
		eSrc.className = "clsNavBarItemOver";
	}
}
// -----------------------------------------------------------------------
// 	HackURL function used in Menu_click to create unique c-frame frameset in Menu_click
// -----------------------------------------------------------------------
function HackURL(sURL)	{
	var dDate = new Date().getTime();
	var sFrameURL = sURL.substring(0,sURL.indexOf("#"));
	var sHash = sURL.substring(sURL.indexOf("#"));
	if ("" != sFrameURL)		{
		if (-1 < location.protocol.indexOf("file:")) return sHash.substring(1);
		else return sFrameURL + "?" + dDate + sHash;
	}
	else return sURL;
}
// -----------------------------------------------------------------------
// 	Menu event-handlers (bound inline at time of menu creation)
// -----------------------------------------------------------------------
function Menu_hover()	{
	var chk_menus=parent.frames[1].document.all["divMenu3_1"];
	//parent.frames[0].document.all["divMenu2_1"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_1"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_12"].style.visibility = "hidden";
	//parent.frames[0].document.all["divMenu3_2"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_3"].style.visibility = "hidden";
	//parent.frames[0].document.all["divMenu3_4"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_6"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_6_1"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_6_2"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu4_1"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu6_1"].style.visibility = "hidden";
	
	var eSrc = window.event.srcElement;
	if ("clsMenu" != eSrc.className) eSrc.className = ("" == eSrc.className ? "clsMenuItemOver" : "");
}

function SubMenu_hout(div_sub_menu_name){
	var eSrc = window.event.srcElement;
	eSrc.className = "";
	eSubMenuShown=parent.frames[1].document.all[div_sub_menu_name];
}

function SubMenu1_hout(div_sub_menu_name)	{
	var eSrc = window.event.srcElement;
	eSrc.className = "";
}
function SubMenu1_hover()	{
	if (esub1Src!=null) {
		esub1Src.className = "";
	}
	esubSrc.className = "clsMenuItemOver";
	var eSrc = window.event.srcElement;
	eSrc.className = "clsMenuItemOver";
	parent.frames[0].document.all["divMenu3_6_1"].style.visibility = "hidden";
	parent.frames[0].document.all["divMenu3_6_2"].style.visibility = "hidden";
}
function SubMenu2_hout(div_sub_menu_name)	{
	var eSrc = window.event.srcElement;
	eSrc.className = "";
}
function SubMenu2_hover()	{
	esub1Src.className = "clsMenuItemOver";
	var eSrc = window.event.srcElement;
	eSrc.className = "clsMenuItemOver";
	
}       
function Menu_click()	{ 
	if (null != eMenuShown) HideMenu();
	parent.frames[1].location.href = HackURL(window.event.srcElement.expURL);
}

function add_menus() {
	document.write('<DIV ID="divMenu1" CLASS="clsMenu" ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();">'+
		'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Outrights">Transaction Input</DIV>'+   //SANJEEWA 2010/07/20
			//'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Outrights_New">Outrights New</DIV>'+  //SANJEEWA 2010/07/20
			'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Repos_Fresh">Loan Generation</DIV>'+     //SANJEEWA 2010/07/20
			'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_loan_upload">Loan Upload</DIV>'+     //SANJEEWA 2010/07/20
			//'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Repos_Periodic_Interest">Repos - Periodic Interest</DIV>'+
			//'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Repos_Rollover">Repos - Rollover</DIV>'+ //SANJEEWA 2010/07/20
			//'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Repos_Full_Settlement">Repos - Full Settlement</DIV>'+  //SANJEEWA 2010/07/20
			//'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Borrow_Lend_Funds">Borrow / Lend - Funds</DIV>'+
			//'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Borrow_Lend_Securities">Borrow / Lend - Securities</DIV>'+
			
			//'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Rate_Change">Rate Change Routine</DIV>'+
			//'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Month_End_Routine">Monthly Intrest Acrual</DIV>'+//Income Capitalization Routine
			//'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Primary_Auctions">Primary Auctions</DIV>'+
			'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_FRONT_REPORTS">Reports</DIV>'+
			//'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_InterestCapitalization">Management Fee Routine</DIV>'+
			'</DIV>');  
	
	//document.write('<DIV ID="divMenu2" CLASS="clsMenu">'+		//-Added by ashini for sr0603-093 on 29-03-2006--->																																												
	//'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Deal_Verification">Deal Verification</DIV>'+ //-Added by ashini for sr0603-093 on 29-03-2006--->	  //SANJEEWA 2010/07/21
	//'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Deal_Approval_Level_2">Deal Verification - 2 </DIV>'+ //added by ashini on 24/04/2006 for sr0604-064	//SANJEEWA 2010/07/21
	//'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL="dn_backoff_pre_verification.html">Deal Verification - 2</DIV>'+  //added by ashini on 24/04/2006 for sr0604-064	
	//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="dn_backoff_pre_verification.html">Deal Verification - 2</DIV>'+  //added by ashini on 24/04/2006 for sr0604-064
	
	//'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Deal_Approval_Level_2">Deal Approval</DIV>'+
	//'<DIV ONMOUSEOUT=SubMenu_hout("divMenu2_1"); ONMOUSEOVER=ShowSubMenu("divMenu2_1","58","240","100"); ONCLICK=ShowSubMenu("divMenu2_1"); expURL="">Deal Approval<img src="darrow.gif" width=12 height=11 border=0 hspace=20></DIV>'+
	//'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Limits_Monitoring">Limits Monitoring</DIV>'+
	//'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();"  expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Limit_Enhancements">Limit Enhancements</DIV>'+
	//'</DIV>');
	
	document.write('<DIV ID="divMenu3" CLASS="clsMenu" >'+   
		'<DIV ONMOUSEOUT=SubMenu_hout("divMenu3_1"); ONMOUSEOVER=ShowSubMenu("divMenu3_1","38","278","150"); ONCLICK=ShowSubMenu("divMenu3_1");>Deal Confirmations&nbsp;&nbsp;&nbsp;&nbsp;<img src="darrow.gif" width=12 height=11 border=0 hspace=0></DIV>'+
			'<DIV ONMOUSEOUT=SubMenu_hout("divMenu3_12"); ONMOUSEOVER=ShowSubMenu("divMenu3_12","58","278","250"); ONCLICK=ShowSubMenu("divMenu3_12");>System Confirmations&nbsp;&nbsp;&nbsp;&nbsp;<img src="darrow.gif" width=12 height=11 border=0 hspace=0></DIV>'+	
			//'<DIV ONMOUSEOUT=SubMenu_hout("divMenu3_2"); ONMOUSEOVER=ShowSubMenu("divMenu3_2","58","278","150"); ONCLICK=ShowSubMenu("divMenu3_2");>Inventory Management</DIV>'+   //SANJEEWA 2010/07/21
			'<DIV ONMOUSEOUT=SubMenu_hout("divMenu3_3"); ONMOUSEOVER=ShowSubMenu("divMenu3_3","78","278","200"); ONCLICK=ShowSubMenu("divMenu3_3"); expURL="">Settlement Management&nbsp;&nbsp;&nbsp;&nbsp;<img src="darrow.gif" width=12 height=11 border=0 hspace=0></DIV>'+
			//'<DIV ONMOUSEOUT=SubMenu_hout("divMenu3_4"); ONMOUSEOVER=ShowSubMenu("divMenu3_4","95","363","150"); ONCLICK=ShowSubMenu("divMenu3_4");>Custodial Services Deals</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu_hout("divMenu3_6"); ONMOUSEOVER=ShowSubMenu("divMenu3_6","50","278","170"); ONCLICK=ShowSubMenu("divMenu3_6"); expURL="">System Maintenance&nbsp;&nbsp;&nbsp;&nbsp;<img src="darrow.gif" width=12 height=11 border=0 hspace=0></DIV>'+		
			//'<DIV id="iimage"><img src="t-arrow_new.gif"   border=0></DIV>'+
			'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_AutoRollover">Daily Margin Trading Activities</DIV>'+
			'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Corporate_Actions">Corporate Actions</DIV>'+			
			'<DIV ONMOUSEOUT="Menu_hover();" ONMOUSEOVER="Menu_hover();" ONCLICK="Menu_click();"expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_BACK_REPORTS">Reports</DIV>'+
			'</DIV>');	
	
	document.write('<DIV ID="divMenu4" CLASS="clsMenu">'+																																																			
		'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_General_Ledger">General Ledger</DIV>'+
			//'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Custodial_Ledger">Custodial Ledger</DIV>'+
			//'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Portfolio_Ledger">Client Ledger</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu_hout("divMenu4_1"); ONMOUSEOVER=ShowSubMenu("divMenu4_1","58","366","130"); ONCLICK=ShowSubMenu("divMenu4_1");>Accounting Reports&nbsp;&nbsp;&nbsp;&nbsp;<img src="darrow.gif" width=12 height=11 border=0 hspace=0></DIV>'+
			'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Day_End">Day End Routine</DIV>'+
			//'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();"  expURL="month_routine.html">Month End Routine</DIV>'+
			//'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();"  expURL="year_routine.html">Year End Routine</DIV>'+
			//'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Acc_Summary">Accounts Summary</DIV>'+
			//'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Adj_Entries">Adjustment Entries</DIV>'+
			//inditha 2004/5/24
			//'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_dnetj_entries">Journal Entries</DIV>'+
			'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_MARKET_RATE">Market Rate Routine</DIV>'+
			'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_FUND_TRANSFER_TEXT_FILE">Fund Transfer Text File</DIV>'+ //add by waruna 2010-08-06
			'</DIV>');
	
	document.write('<DIV ID="divMenu5" CLASS="clsMenu" ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();">'+
		'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Front_Office">Front Office</DIV>'+
			//'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Middle_Office">Middle Office</DIV>'+
			'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Back_Office">Back Office</DIV>'+
			//added by ashini on 08-06-2005-----------------
			//'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL="dn_maintenance_users_lock.html">Activation of Locked User</DIV>'+
			//     '<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_UNLOCK_USER">Activation of Locked User</DIV>'+
			'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_UNLOCK_USER">Activation of Locked User</DIV>'+
			
			//-----------------end- 03-06-2005--------------
			
			
			//'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Accounting">Accounting</DIV>'+
			//'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_System_Configuration">System Configuration</DIV>'+
			//	'<DIV expURL="http://www.pabc.lk/intranet/dn_Boffice_checkwizard.html">Daily Check Reports</DIV>'+//remove by waruna request from pabc 2010-12-14  
			'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Deal_Deletion">Deal Deletion</DIV>'+
			'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Pay_Rec_Deletion">Receipt-Payment Deletion</DIV>'+
			'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_BankCharge_Deletion">Bank Charges Deletion</DIV>'+
			'<DIV expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Cap_DepWith_Del">Capital Deposits/Withdrawal Deletion</DIV>'+
			'</DIV>');
	
	document.write('<DIV ID="divMenu6" CLASS="clsMenu" >'+   				
		
		'<DIV ONMOUSEOUT=SubMenu_hout("divMenu6_1"); ONMOUSEOVER=ShowSubMenu("divMenu6_1","34","518","170"); ONCLICK=ShowSubMenu("divMenu6_1");>Settlements&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="darrow.gif" width=12 height=11 border=0 hspace=0></DIV>'+
			//'<DIV ONMOUSEOUT=SubMenu_hout("divMenu6_2"); ONMOUSEOVER=SubMenu1_hover();ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Income_Cap">Income Capitalization Routine</DIV>'+
			//'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();"  expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Income_Cap">Income Capitalization Routine</DIV>'+
			'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();"  expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Port_Accounting">Accounting</DIV>'+
			//'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();"  expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Portfolio_Ledger">Client Accounts</DIV>'+
			//'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();"  expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_port_acc">Client Accounts</DIV>'+
			'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();"  expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_port_acc_new">Margin Trading Accounts</DIV>'+
			'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();"  expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Brok_Pay_Rec">Amounts Receivable from/Payable to brokerage</DIV>'+
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu4_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Brok_Pay_Rec">Amounts Receivable from/Payable to brokerage</DIV>'+
			
			
			
			
			//'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();"  expURL="dn_potfolioacc_ledger_wizard.html">Client Accounts</DIV>'+
			//'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();"  expURL="dn_portfolioacc_ledger.html">Client Accounts New</DIV>'+
			
			'</DIV>');		
	//Sub Menus
	//document.write('<DIV ID="divMenu2_1" CLASS="clsMenu1">'+
	//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu2_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Deal_Approval_Level_1">Level 1</DIV>'+
	//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu2_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Deal_Approval_Level_2">Level 2</DIV>'+
	//'</DIV>');
	
	document.write('<DIV ID="divMenu3_1" CLASS="clsMenu1">'+
		'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Complete_Deal_Ticket">Complete Deal Ticket</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Pre_Confirmation_New">Pre Confirmation</DIV>'+ //added By Keith on 6-10-2004/14:14 
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Genarate_Confirmation">Generate Confirmation</DIV>'+  //commented by ashini on 24/04/2006 for sr0604-064
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Portfolio_Confirmation">Portfolio Confirmation</DIV>'+  //add by waruna 2010-12-22
			//'<DIV  ONMOUSEOUT=SubMenu1_hout("divMenu3_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();"  expURL="http://www.pabc.lk/intranet/frames_confirm_dealticket.html">Generate Confirmation</DIV>'+
			'</DIV>');
	
	
	document.write('<DIV ID="divMenu3_12" CLASS="clsMenu1">'+
		'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_12"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Cap_Deposit_With_Confirmation">Capital Deposit/Withdrawal Confirmation</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_12"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Cleint_Confirmation">Client Confirmation</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_12"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Client_Limit_Confirmation">Client Limit Confirmation</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_12"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_User_Confirmation">User Confirmation</DIV>'+
			
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_12"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Paymets_Confirmation">Payments Confirmation</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_12"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Receipts_Confirmation">Receipts Confirmation</DIV>'+
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_12"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Pre_Confirmation_New">Pre Confirmation</DIV>'+ //added By Keith on 6-10-2004/14:14 
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_12"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Genarate_Confirmation">Generate Confirmation</DIV>'+  //commented by ashini on 24/04/2006 for sr0604-064
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_12"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Portfolio_Confirmation">Portfolio Confirmation</DIV>'+  //add by waruna 2010-12-22
			//'<DIV  ONMOUSEOUT=SubMenu1_hout("divMenu3_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();"  expURL="http://www.pabc.lk/intranet/frames_confirm_dealticket.html">Generate Confirmation</DIV>'+
			'</DIV>');
	
	
	//document.write('<DIV ID="divMenu3_2" CLASS="clsMenu1">'+
	//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_2"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Listing">Listing</DIV>'+   //SANJEEWA 2010/07/20
	//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_2"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Inv_Receipts">Receipts</DIV>'+   //SANJEEWA 2010/07/20
	//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_2"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Issues">Issues</DIV>'+  //SANJEEWA 2010/07/20
	//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_2"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Swaps">Swaps</DIV>'+    //SANJEEWA 2010/07/20
	//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_2"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Modification">Modification</DIV>'+
	//'<DIV ONMOUSEOUTMOUSEOUT=SubMenu1_hout("divMenu3_2"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Exchange">Exchange</DIV>'+  //SANJEEWA 2010/07/20
	//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_2"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Location_Change">Location Change</DIV>'+   //SANJEEWA 2010/07/20
	//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_2"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Scripless_Trans">Scripless Transfers</DIV>'+ // --scripless  //SANJEEWA 2010/07/20
	//'</DIV>');
	
	document.write('<DIV ID="divMenu3_3" CLASS="clsMenu1">'+
		'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Receipts">Receipts</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Payments">Payments</DIV>'+
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Deposits">Deposits</DIV>'+   //SANJEEWA 2010/07/20
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Cheque_App">Cheque Approval</DIV>'+	
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Cheques">Cheques</DIV>'+
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Transfer_Letters">Transfer Letters</DIV>'+     //SANJEEWA 2010/07/20
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_PaymentAdvice">Payment Advice</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Internal_Transfers">Internal Transfers</DIV>'+ 
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Bank_Charges">Bank Charges</DIV>'+        //SANJEEWA 2010/07/20
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Capital_Invest">Capital Investments</DIV>'+  //SANJEEWA 2010/07/20
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Divi_Income">Dividend Income</DIV>'+      //SANJEEWA 2010/07/20
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Sale_Rights">Sale Of Rights</DIV>'+      //SANJEEWA 2010/07/20
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Divi_Income_Deletion">Dividend Income/Sale Of Rights Deletion</DIV>'+     //SANJEEWA 2010/07/20			
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Payments_Bulk">Broker Payments</DIV>'+ //commented by ashini for sr0605-019			
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Payments_Bulk">Broker Payments - Daily </DIV>'+	 //added by ashini for sr0605-019				
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Payments_Bulk_HB">Broker Payments - Held Back </DIV>'+	 //added by ashini for sr0605-019				
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Receipt_Bulk">Broker Receipts - Daily </DIV>'+	 //added by waruna 2010-10-25	
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Payments_All_Bulk">Broker Payments - All </DIV>'+	 //added by waruna 2011-01-20	
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Receipt_All_Bulk">Broker Receipts - All</DIV>'+	 //added by waruna  2011-01-20	
			
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Divi_Income">Dividend Income - Direct Entry</DIV>'+	 //added by waruna  2011-01-20	
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Divi_Receive">Dividend Receivable (from Corporate Actions)</DIV>'+	 //added by waruna  2011-01-20	
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Divi_Income_Deletion">Dividend Income/Sale Of Rights Deletion</DIV>'+	 //added by waruna  2011-01-20	
			'</DIV>');
	
	document.write('<DIV ID="divMenu3_4" CLASS="clsMenu1">'+
		'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_4"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Deal">Deal</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_4"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Scripless_Cust">Custodial - Scripless</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_4"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Invoicing">Invoicing</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_4"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Customer_Maintenance">Customer Maintenance</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_4"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="process_main.html">Process</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_4"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="cust_report_main.html">Report</DIV>'+
			'</DIV>');
	
	
	document.write('<DIV ID="divMenu3_6" CLASS="clsMenu1">'+
		'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Location">Location</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Users">Users</DIV>'+
			//-------added by ashini hewage on 27-05-2005---
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="dn_Expire_Duration.html">Password Expiry Interval</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Pw_Expiry">Password Expiry Interval</DIV>'+
			
			//----------end ----27-05-2005------------------
			
			
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Instrument_Types">Instrument Types</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Instrument_Types_MT">Instrument Types-MT</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Instrumentrates">Instrument Rates</DIV>'+
			
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Issuers">Issuers</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Interest_Rate_Basis">Interest Rate Bases</DIV>'+
			
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Repo_Rate">Repo Rate</DIV>'+//added by ashini on 19/10/2005
			
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="mbfsl_repo_rate.html">Repo Rate</DIV>'+//added by ashini on 19/10/2005
			
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Securities">Securities</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Securities_MT">Securities - MT</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Holidays">Holidays</DIV>'+
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Portfolios">Clients</DIV>'+
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Portfolios_MT">Clients-MT</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Portfolios_MT_New">Clients - MT</DIV>'+//Clients-MT New
				'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Client_Limit_MT">Client Limit</DIV>'+ //add by waruna 2010-12-28
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Portfolios_AddAdvis">Clients - Add Advisors</DIV>'+     //SANJEEWA 2010/07/27
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Portfolio_Rates">Client Rates</DIV>'+
			
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Margin_Call">Client Reactivation - MT</DIV>'+
			
			// ------------ added by nilu on 12.07.04 for the VCf 04-119-----------
			
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Banks">Banks</DIV>'+
			
			//---------------- end of modification by nilu --------------------------
			
			// This was commented by Nilu on  29-9-2004/9:35 for SRF 0409-071 
			//	'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Name_On_Cheque">Name On Cheque</DIV>'+
			
			
			'<DIV ONMOUSEOUT=SubMenu2_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Cheque_Parameters">Cheque Parameters</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu2_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Printer_Parameters">Printer Parameters</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Counter_Parties">Brokers</DIV>'+
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Currencies">Currencies</DIV>'+
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Exchangerates">Exchange Rates</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Settlement_Options">Settlement Options</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Tax_Rates">Tax Rates</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_REPO_DATA">Reference Info - MT</DIV>'+				//Repo Template
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_SEC_RATE_ENTRY">Security Market Rates</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_SEC_RATE_ENTRY_NEW">Security Market Rates New</DIV>'+ //add by waruna 2010-08-04
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Transaction_Upload">Transaction Upload</DIV>'+
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Portfolio_Upload">Portfolio Upload</DIV>'+
			//'<DIV ONMOUSEOUT=SubMenu_hout("divMenu3_6_11"); ONMOUSEOVER=ShowSubMenu("divMenu3_6_11","500","428","150"); ONCLICK=ShowSubMenu("divMenu3_6_11"); expURL="">System Maintenance&nbsp;&nbsp;&nbsp;&nbsp;<img src="darrow.gif" width=12 height=11 border=0 hspace=0></DIV>'+	//add by waruna 2010-12-22
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Broker_Mapping">Broker Mapping</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_M_Advisor">Advisor</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_MAP_ACCOUNTS">Map Accounts</DIV>'+
			
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_CLIENT_DATA_CAP">Client Data Upload</DIV>'+
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_TRANSFER_UPLOAD">Transfer Upload</DIV>'+
		
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=ShowSubMenu1("divMenu3_6_2","550","440","230"); ONCLICK=ShowSubMenu("divMenu3_6_2");>Upload&nbsp;&nbsp;&nbsp;&nbsp;<img src="darrow.gif" width=12 height=11 border=0 hspace=0></DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Client_Balance_Text_File">Client Balance Text File</DIV>'+
			'</DIV>');
	
	
	
	document.write('<DIV ID="divMenu3_6_2" CLASS="clsMenu1">'+
		    '<DIV ONMOUSEOUT=SubMenu2_hout("divMenu3_6_2"); ONMOUSEOVER=SubMenu2_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Transaction_Upload">Transaction</DIV>'+//Transaction Upload
			'<DIV ONMOUSEOUT=SubMenu2_hout("divMenu3_6_2"); ONMOUSEOVER=SubMenu2_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Portfolio_Upload">Portfolio</DIV>'+//Portfolio Upload
		    '<DIV ONMOUSEOUT=SubMenu2_hout("divMenu3_6_2"); ONMOUSEOVER=SubMenu2_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_CLIENT_DATA_CAP">Client Data</DIV>'+//Client Data Upload
			'<DIV ONMOUSEOUT=SubMenu2_hout("divMenu3_6_2"); ONMOUSEOVER=SubMenu2_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_TRANSFER_UPLOAD">Transfer</DIV>'+//Transfer Upload
			
			'</DIV>');
	
	document.write('<DIV ID="divMenu3_6_1" CLASS="clsMenu2">'+
		    '<DIV ONMOUSEOUT=SubMenu2_hout("divMenu6_6"); ONMOUSEOVER=SubMenu2_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Overall_Trading">Overall Trading</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu2_hout("divMenu6_6"); ONMOUSEOVER=SubMenu2_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Maturity_Bands">Maturity Bands</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu2_hout("divMenu6_6"); ONMOUSEOVER=SubMenu2_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Exposure">Exposure</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu2_hout("divMenu6_6"); ONMOUSEOVER=SubMenu2_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Issuer">Issuer</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu2_hout("divMenu6_6"); ONMOUSEOVER=SubMenu2_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Dealerwise">Dealerwise</DIV>'+			
			'</DIV>');
	
	document.write(	'<DIV ID="divMenu4_1" CLASS="clsMenu1">'+
		//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu4_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Client_Ledger">Client Accounts</DIV>'+
		//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu4_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Client_Ledger2">Client Accounts 2</DIV>'+
		'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu4_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Backdated_Trn">Backdated Deals</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu4_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Client_Payment">Payment Details</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu4_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Client_Receipt">Receipt Details</DIV>'+
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu4_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Brokerage_Trn">Brokerage</DIV>'+
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu4_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="capital_gain_main.html">Capital Gain</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu4_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Capital_Gain">Capital Gain</DIV>'+
			
			//------------------------commented by janitha for SR0507-001--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
			
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu4_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Client_Account_New">Client Accounts - Total</DIV>'+
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu4_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Client_Account_Net">Client Accounts - Net</DIV>'+//
			
			
			//-----------------------end of commenting for SR0507-001---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			
			
			//------------------------------------------------------------------------added by janitha for SR0507-001-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 		
			
			// '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu4_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Client_Account_Bal">Client Balances - All</DIV>'+ //remove by waruna request from pabc 2010-12-14    //added by janitha for Sr0507-001 on 2005-07-04
			//  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu4_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Client_Account_TP">Client Balances - 3rd Parties Only</DIV>'+ //remove by waruna request from pabc 2010-12-14      //added by janitha for Sr0507-001 on 2005-07-04
			
			//-------------------------------------------------------------------------end of adding for SR0507-001----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		
			
			//  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu4_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Client_Account_Port">Client Accounts - Portfolio</DIV>'+////remove by waruna request from pabc 2010-12-14  
			
			
			'</DIV>');
	
	document.write('<DIV ID="divMenu6_1" CLASS="clsMenu1">'+			
		//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu6_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Capital_Deposit">Capital Deposit</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu6_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Capital_Deposit_New">Capital Deposit</DIV>'+
			//'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu6_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Capital_Withdraw">Capital Withdrawal</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu6_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Capital_Withdraw_New">Capital Withdrawal</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu6_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Capital_Withdraw_Special">Capital Withdrawal Special</DIV>'+ // Added by S.Shanheetha on 24-11-2005
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu6_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Interest_Receipt">Interest Receipt</DIV>'+  // Added by Manjula on 15-09-2004 for SR 0409-037
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu6_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Portf_Charges">Interest Refund</DIV>'+//Margin Trading Charges ..change by waruna guide by riyad
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu6_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="'+servlet_client_url+':'+client_t3_port+'/'+client_name+'login?screen_name=WD_Portf_Fees">Margin Trading Fees</DIV>'+	
			'</DIV>');
}
// -----------------------------------------------------------------------
// 	NavBar event binding
// -----------------------------------------------------------------------
add_menus();
if ("object" == typeof(tblNavBar))	{
	tblNavBar.onmouseover = new Function("NavBar_mouseover(this);");
	tblNavBar.onmouseout = new Function("NavBar_mouseout(this);");
	tblNavBar.onselectstart = new Function("return false;");
	tblNavBar.onclick = new Function("NavBar_click(this);");
}
else
	parent.frames[1].document.onclick = new Function("subdocument_click(this);");

