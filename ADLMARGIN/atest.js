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
		//var servlet_client_url="https://dev-adlmargin.sasianet.com";
		//var html_client_url="https://dev-adlmargin.sasianet.com/intranet";
	  //var client_t3_port="8080/myserver/servlet";

    // -----------------------------------------------------------------------
	// 	Conditional global event-handlers
	// -----------------------------------------------------------------------

	function document_click()
	{
		if ("clsNavBarItemShown" != window.event.srcElement.className && null != eMenuShown) HideMenu();
	}

	function subdocument_click()
	{
		  	parent.frames[0].document.all["divMenu1"].style.visibility = "hidden";
      	parent.frames[0].document.all["divMenu2"].style.visibility = "hidden";
      	parent.frames[0].document.all["divMenu3"].style.visibility = "hidden";
      	parent.frames[0].document.all["divMenu4"].style.visibility = "hidden";
        parent.frames[0].document.all["divMenu5"].style.visibility = "hidden";
		    parent.frames[0].document.all["divMenu2_1"].style.visibility = "hidden";
	      parent.frames[0].document.all["divMenu3_1"].style.visibility = "hidden";
	      parent.frames[0].document.all["divMenu3_2"].style.visibility = "hidden";
	      parent.frames[0].document.all["divMenu3_3"].style.visibility = "hidden";
	      parent.frames[0].document.all["divMenu3_4"].style.visibility = "hidden";
	      parent.frames[0].document.all["divMenu3_6"].style.visibility = "hidden";
		  	parent.frames[0].document.all["divMenu3_6_1"].style.visibility = "hidden";
      //eTOPbar = parent.frames[0].document.all["tblNavBar"];
      //window.parent.frames[0].document.event.srcElement;
      //eTOPbar.TD.clsNavBarItem;  
			//eTOPbar = parent.frames[0].document.all["eNavBarItemShown"];
			//eTOPbar.style.color = "lightgrey";
			//eTOPbar.style.background = "darkblue";
  		//var eSrc = FindTD(document.captureEvents(Event.CLICK),eTOPbar);
			//eTOPbar = "clsNavBarItem";
	}

	function document_keypress()
	{
		if ("27" == window.event.keyCode && null != eMenuShown) HideMenu();
	}

	function window_blur()
	{
		if (null != eMenuShown) HideMenu();
	}

	// -----------------------------------------------------------------------
	// 	Cache/Uncache functions to store and bind if menu shown
	// -----------------------------------------------------------------------

	function CacheAndBind()
	{
		window.CachedClick = document.onclick;
		window.CachedKeypress = document.onkeypress;
		window.CachedBlur = window.onblur;
		document.onclick = document_click;
		document.onkeypress = document_keypress;
		window.onblur = window_blur;
	}

	function UncacheAndRebind()
	{
		document.onclick = window.CachedClick;
		document.onkeypress = window.CachedKeypress;
		window.onblur = window.CachedBlur;
	}

	// -----------------------------------------------------------------------
	// 	HideMenu and ShowMenu functions
	// -----------------------------------------------------------------------

	function HideMenu()
	{
	    parent.mainframe.rows="37,*";
			parent.frames[0].document.all["divMenu2_1"].style.visibility = "hidden";
      parent.frames[0].document.all["divMenu3_1"].style.visibility = "hidden";
			parent.frames[0].document.all["divMenu3_2"].style.visibility = "hidden";
			parent.frames[0].document.all["divMenu3_3"].style.visibility = "hidden";
			parent.frames[0].document.all["divMenu3_4"].style.visibility = "hidden";
			parent.frames[0].document.all["divMenu3_6"].style.visibility = "hidden";
			parent.frames[0].document.all["divMenu3_6_1"].style.visibility = "hidden";

		
    eMenuShown.style.visibility = "hidden";
		eMenuShown = null;
		eNavBarItemShown.className = "clsNavBarItem";
		eNavBarItemShown = null;
		UncacheAndRebind();
	}

	function ShowMenu(eSrc)
	{
    parent.mainframe.rows="100%,*";
    eMenuShown = null;
		eMenuShown = parent.frames[0].document.all["divMenu" + eSrc.expItemNum];
    //alert(eMenuShown);
		if (eMenuShown == null) {
			eMenuShown = parent.frames[0].document.all["divMenu" + eSrc.expItemNum];
		}
    eNavBarItemShown = eSrc;
		eNavBarItemShown.className = "clsNavBarItemShown";
		if (null != eMenuShown) eMenuShown.style.visibility = "visible";
		//eSubMenuShown=parent.frames[1].document.all["divMenu3_1"];
    //eSubMenuShown.style.visibility = "visible";
    CacheAndBind();
	}

	function ShowSubMenu(div_sub_menu_name,m_top,m_left,m_width)
	{
		esubSrc = window.event.srcElement;
		if (oldesubSrc!=null) {
		  oldesubSrc.className = "";
		}
		oldesubSrc=esubSrc;
    esubSrc.className = "clsMenuItemOver";
    //Hide all sub menus
		parent.frames[0].document.all["divMenu2_1"].style.visibility = "hidden";
		parent.frames[0].document.all["divMenu3_1"].style.visibility = "hidden";
		parent.frames[0].document.all["divMenu3_2"].style.visibility = "hidden";
		parent.frames[0].document.all["divMenu3_3"].style.visibility = "hidden";
		parent.frames[0].document.all["divMenu3_4"].style.visibility = "hidden";
		parent.frames[0].document.all["divMenu3_6"].style.visibility = "hidden";
		parent.frames[0].document.all["divMenu3_6_1"].style.visibility = "hidden";
 		parent.frames[0].document.all["divMenu4_1"].style.visibility = "hidden";

		//Display required sub menu
		eSubMenuShown=parent.frames[0].document.all[div_sub_menu_name];
		eSubMenuShown.style.top=m_top; 
        eSubMenuShown.style.left=m_left; 
		eSubMenuShown.style.width=m_width;
        eSubMenuShown.style.visibility = "visible";
    //eSrc.className = "clsMenuItemOver";

	}
	function ShowSubMenu1(div_sub_menu_name,m_top,m_left,m_width)
	{
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
    //eSrc.className = "clsMenuItemOver";

	}

	function HideSubMenu(div_sub_menu_name)
	{
    eSubMenuShown=parent.frames[0].document.all[div_sub_menu_name];
    eSubMenuShown.style.visibility = "hidden";
	}

	// -----------------------------------------------------------------------
	// 	FindTD function used in NavBar event-handlers to determine TD ancestor
	// -----------------------------------------------------------------------

	function FindTD(eSrc,eContainer)
	{
		while (eContainer.contains(eSrc))
		{
			if ("TD" == eSrc.tagName) return eSrc;
			eSrc = eSrc.parentElement;
		}
		return false;
	}

	// -----------------------------------------------------------------------
	// 	NavBar event-handlers (bound below)
	// -----------------------------------------------------------------------

	function NavBar_mouseover(eContainer)
	{
		var eSrc = FindTD(window.event.srcElement,eContainer);
		if (FindTD(window.event.fromElement,eContainer) != eSrc)
		{
			if ("clsNavBarItem" == eSrc.className)
			{
				eSrc.className = "clsNavBarItemOver";
				if (null != eMenuShown)
				{
					HideMenu();
					ShowMenu(eSrc);
				}
			}
		}
	}

	function NavBar_mouseout(eContainer)
	{
		var eSrc = FindTD(window.event.srcElement,eContainer);
		if (FindTD(window.event.toElement,eContainer) != eSrc)
		{
			if ("clsNavBarItemOver" == eSrc.className) eSrc.className = "clsNavBarItem";
		}
	}

	function NavBar_click(eContainer)
	{
		window.event.cancelBubble = true;
		var eSrc = FindTD(window.event.srcElement,eContainer);
		if ("clsNavBarItemOver" == eSrc.className)
		{
			if (null != eMenuShown) HideMenu();
			ShowMenu(eSrc);
		}
		else if ("clsNavBarItemShown" == eSrc.className)
		{
			if (null != eMenuShown) HideMenu();
			eSrc.className = "clsNavBarItemOver";
		}
	}

	// -----------------------------------------------------------------------
	// 	HackURL function used in Menu_click to create unique c-frame frameset in Menu_click
	// -----------------------------------------------------------------------

	function HackURL(sURL)
	{
		var dDate = new Date().getTime();
		var sFrameURL = sURL.substring(0,sURL.indexOf("#"));
		var sHash = sURL.substring(sURL.indexOf("#"));
		if ("" != sFrameURL)
		{
			if (-1 < location.protocol.indexOf("file:")) return sHash.substring(1);
			else return sFrameURL + "?" + dDate + sHash;
		}
		else return sURL;
	}

	// -----------------------------------------------------------------------
	// 	Menu event-handlers (bound inline at time of menu creation)
	// -----------------------------------------------------------------------

	function Menu_hover()
	{
    var chk_menus=parent.frames[1].document.all["divMenu3_1"];
		parent.frames[0].document.all["divMenu2_1"].style.visibility = "hidden";
    parent.frames[0].document.all["divMenu3_1"].style.visibility = "hidden";
		parent.frames[0].document.all["divMenu3_2"].style.visibility = "hidden";
		parent.frames[0].document.all["divMenu3_3"].style.visibility = "hidden";
		parent.frames[0].document.all["divMenu3_4"].style.visibility = "hidden";
		parent.frames[0].document.all["divMenu3_6"].style.visibility = "hidden";
		parent.frames[0].document.all["divMenu3_6_1"].style.visibility = "hidden";
 		parent.frames[0].document.all["divMenu4_1"].style.visibility = "hidden";

		var eSrc = window.event.srcElement;
    if ("clsMenu" != eSrc.className) eSrc.className = ("" == eSrc.className ? "clsMenuItemOver" : "");
	}

function SubMenu_hout(div_sub_menu_name)
	{
	  
		var eSrc = window.event.srcElement;
	  eSrc.className = "";
    eSubMenuShown=parent.frames[1].document.all[div_sub_menu_name];
    //eSubMenuShown.style.visibility = "hidden";
	}

  function SubMenu1_hout(div_sub_menu_name)
	{
		var eSrc = window.event.srcElement;
	  eSrc.className = "";
  }

  function SubMenu1_hover()
	{
		if (esub1Src!=null) {
	    esub1Src.className = "";
		}
    esubSrc.className = "clsMenuItemOver";
		var eSrc = window.event.srcElement;
	  eSrc.className = "clsMenuItemOver";
		parent.frames[0].document.all["divMenu3_6_1"].style.visibility = "hidden";
	}

 function SubMenu2_hout(div_sub_menu_name)
	{
		var eSrc = window.event.srcElement;
	  eSrc.className = "";
}

  function SubMenu2_hover()
	{
    esub1Src.className = "clsMenuItemOver";
		var eSrc = window.event.srcElement;
	  eSrc.className = "clsMenuItemOver";
		
	}       

	function Menu_click()
	{ 
		if (null != eMenuShown) HideMenu();
		parent.frames[1].location.href = HackURL(window.event.srcElement.expURL);
	}
  //'<DIV expURL="'+client_url+'/mbfsl_repo_fresh_deals.html">Repos - Fresh </DIV>'+
	
	function add_menus() {
	
    document.write('<DIV ID="divMenu1" CLASS="clsMenu" ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();">'+
		  '<DIV expURL=":/login?screen_name=WD_Outrights">Outrights</DIV>'+
			//'<DIV expURL=":/login?screen_name=WD_Repos_Fresh">Repos - Fresh </DIV>'+
			
			'<DIV expURL=":/login?screen_name=WD_Repos_Fresh">Repos - Fresh</DIV>'+
			
			//'<DIV expURL=:/login?screen_name=WD_Repos_Fresh">Repos - Fresh </DIV>'+
			
			'<DIV expURL=":/login?screen_name=WD_Repos_Periodic_Interest">Repos - Periodic Interest</DIV>'+
		 			//'<DIV expURL=":/login?screen_name=WD_Repos_Fresh">Repos - Rollover </DIV>'+
       // '<DIV expURL="https://dev-adlmargin.sasianet.com/intranet/mbfsl_rollover.html">Repos - Rollover </DIV>'+

			'<DIV expURL=":/login?screen_name=WD_Repos_Rollover">Repos - Rollover</DIV>'+
			'<DIV expURL=":/login?screen_name=WD_Repos_Full_Settlement">Repos - Full Settlement</DIV>'+
		  '<DIV expURL=":/login?screen_name=WD_Borrow_Lend_Funds">Borrow / Lend - Funds</DIV>'+
		  '<DIV expURL=":/login?screen_name=WD_Borrow_Lend_Securities">Borrow / Lend - Securities</DIV>'+
		 //'<DIV expURL=":/login?screen_name=WD_Securities_Swaps_Returnable">Securities Swaps - Returnable</DIV>'+
		 //'<DIV expURL=":/login?screen_name=WD_Securities_Swaps_Outrights">Securities Swaps - Outright</DIV>'+
		  '<DIV expURL=":/login?screen_name=WD_Primary_Auctions">Primary Auctions</DIV>'+
		  '<DIV expURL="https://dev-adlmargin.sasianet.com/intranet/dn_Foffice_wizard.html">Reports</DIV>'+
    '</DIV>');  
    document.write('<DIV ID="divMenu2" CLASS="clsMenu">'+																																																			
		  '<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Deal_Verification">Deal Verification</DIV>'+
		  //'<DIV ONMOUSEOUT=SubMenu_hout("divMenu2_1"); ONMOUSEOVER=ShowSubMenu("divMenu2_1","58","240","100"); ONCLICK=ShowSubMenu("divMenu2_1"); expURL=":/login?screen_name=WD_dn_Middleoff_deallevel1">Deal Approval<img src="darrow.gif" width=12 height=11 border=0 hspace=20></DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu_hout("divMenu2_1"); ONMOUSEOVER=ShowSubMenu("divMenu2_1","58","240","100"); ONCLICK=ShowSubMenu("divMenu2_1"); expURL="">Deal Approval<img src="darrow.gif" width=12 height=11 border=0 hspace=20></DIV>'+
			'<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Limits_Monitoring">Limits Monitoring</DIV>'+
		  '<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();"  expURL=":/login?screen_name=WD_Limit_Enhancements">Limit Enhancements</DIV>'+
      '</DIV>');
	  // expURL=":/login?screen_name=WD_dn_custodial_deals"
    document.write('<DIV ID="divMenu3" CLASS="clsMenu" >'+   
		  '<DIV ONMOUSEOUT=SubMenu_hout("divMenu3_1"); ONMOUSEOVER=ShowSubMenu("divMenu3_1","38","363","150"); ONCLICK=ShowSubMenu("divMenu3_1");>Deal Confirmations</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu_hout("divMenu3_2"); ONMOUSEOVER=ShowSubMenu("divMenu3_2","58","363","150"); ONCLICK=ShowSubMenu("divMenu3_2");>Inventory Management</DIV>'+
      '<DIV ONMOUSEOUT=SubMenu_hout("divMenu3_3"); ONMOUSEOVER=ShowSubMenu("divMenu3_3","75","363","150"); ONCLICK=ShowSubMenu("divMenu3_3");" expURL="">Settlement Management</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu_hout("divMenu3_4"); ONMOUSEOVER=ShowSubMenu("divMenu3_4","95","363","150"); ONCLICK=ShowSubMenu("divMenu3_4");">Custodial Services Deals</DIV>'+
		  '<DIV ONMOUSEOUT="Menu_hover();" ONMOUSEOVER="Menu_hover();" ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Portfolio_fees_Invoicing">Client Fees Invoicing</DIV>'+
      '<DIV ONMOUSEOUT=SubMenu_hout("divMenu3_6"); ONMOUSEOVER=ShowSubMenu("divMenu3_6","135","363","150"); ONCLICK=ShowSubMenu("divMenu3_6");" expURL="">System Maintenance</DIV>'+
      '<DIV id="iimage"><img src="t-arrow.gif" width=7 height=109 border=0></DIV>'+
			'<DIV ONMOUSEOUT="Menu_hover();" ONMOUSEOVER="Menu_hover();" ONCLICK="Menu_click();" expURL="https://dev-adlmargin.sasianet.com/intranet/dn_Boffice_wizard.html">Reports</DIV>'+
	'</DIV>');	
   
		
		
		/*document.write('<DIV ID="divMenu4" CLASS="clsMenu" ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();">'+
		  '<DIV expURL=":/login?screen_name=WD_General_Ledger">General Ledger</DIV>'+
		  '<DIV expURL=":/login?screen_name=WD_Portfolio_Ledger">Client Ledger</DIV>'+
		  '<DIV expURL=":/login?screen_name=WD_Custodial_Ledger">Custodial Ledger</DIV>'+
      '<DIV expURL=":/login?screen_name=WD_Client_Ledger">Client Accounts</DIV>'+
		  //'<DIV expURL="https://dev-adlmargin.sasianet.com/intranet/dn_client_payment_frame_main.html">Payments Details</DIV>'+
		 	//'<DIV expURL="https://dev-adlmargin.sasianet.com/intranet/dn_client_receipt_frame_main.html">Receipts Details</DIV>'+
			'<DIV expURL=":/login?screen_name=WD_Client_Payment">Payment Details</DIV>'+
      '<DIV expURL=":/login?screen_name=WD_Client_Receipt">Receipt Details</DIV>'+
      '<DIV expURL=":/login?screen_name=WD_Backdated_Trn">Backdated Transactions</DIV>'+
			//'<DIV expURL="">Inventory</DIV>'+
			'<DIV expURL=":/login?screen_name=WD_Day_End">Day End Routine</DIV>'+
			'<DIV expURL="month_routine.html">Month End Routine</DIV>'+
			'<DIV expURL="year_routine.html">Year End Routine</DIV>'+
			'<DIV expURL="capital_gain_main.html">Capital Gain</DIV>'+
	'</DIV>');*/		
		
   //*************************************************************************************************
   ///////////////////////// 
		document.write('<DIV ID="divMenu4" CLASS="clsMenu">'+																																																			
		  '<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_General_Ledger">General Ledger</DIV>'+
		  '<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Portfolio_Ledger">Client Ledger</DIV>'+
		  '<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Custodial_Ledger">Custodial Ledger</DIV>'+
		  '<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Portfolio_Ledger">Client Ledger</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu_hout("divMenu4_1"); ONMOUSEOVER=ShowSubMenu("divMenu4_1","116","436","130"); ONCLICK=ShowSubMenu("divMenu4_1");>Accounting Reports&nbsp;&nbsp;&nbsp;&nbsp;<img src="darrow.gif" width=12 height=11 border=0 hspace=0></DIV>'+
		  '<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Day_End">Day End Routine</DIV>'+
		  '<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();"  expURL="month_routine.html">Month End Routine</DIV>'+
		  '<DIV ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();"  expURL="year_routine.html">Year End Routine</DIV>'+
     	//'<DIV ONMOUSEOUT=SubMenu_hout("divMenu4_1"); ONMOUSEOVER=ShowSubMenu("divMenu4_1","135","363","130"); ONCLICK=ShowSubMenu("divMenu4_1");>Accounting Reports<img src="darrow.gif" width=12 height=11 border=0 hspace=1></DIV>'+
			'</DIV>');
  
	////////////////////////////
	//*************************************************************************************************        
    document.write('<DIV ID="divMenu5" CLASS="clsMenu" ONMOUSEOVER="Menu_hover();" ONMOUSEOUT="Menu_hover();" ONCLICK="Menu_click();">'+
		  '<DIV expURL=":/login?screen_name=WD_Front_Office">Front Office</DIV>'+
		  '<DIV expURL=":/login?screen_name=WD_Middle_Office">Middle Office</DIV>'+
		  '<DIV expURL=":/login?screen_name=WD_Back_Office">Back Office</DIV>'+
		  '<DIV expURL=":/login?screen_name=WD_Accounting">Accounting</DIV>'+
		  '<DIV expURL=":/login?screen_name=WD_System_Configuration">System Configuration</DIV>'+
		//	'<DIV expURL="https://dev-adlmargin.sasianet.com/intranet/Unauthorized Login_frame_main.html">Unauthorized Login</DIV>'+
    '</DIV>');
    //Sub Menus
	  document.write('<DIV ID="divMenu2_1" CLASS="clsMenu1">'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu2_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Deal_Approval_Level_1">Level 1</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu2_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Deal_Approval_Level_2">Level 2</DIV>'+
    '</DIV>');
		
    document.write('<DIV ID="divMenu3_1" CLASS="clsMenu1">'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Complete_Deal_Ticket">Complete Deal Ticket</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Genarate_Confirmation">Generate Confirmation</DIV>'+
    '</DIV>');
    document.write('<DIV ID="divMenu3_2" CLASS="clsMenu1">'+
      '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_2"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Listing">Listing</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_2"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Inv_Receipts">Receipts</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_2"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Issues">Issues</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_2"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Swaps">Swaps</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_2"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Modification">Modification</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_2"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Exchange">Exchange</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_2"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Location_Change">Location Change</DIV>'+
    '</DIV>');
			
    document.write('<DIV ID="divMenu3_3" CLASS="clsMenu1">'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Receipts">Receipts</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Payments">Payments</DIV>'+
		   '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Deposits">Deposits</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Cheques">Cheques</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Transfer_Letters">Transfer Letters</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Internal_Transfers">Internal Transfers</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Bank_Charges">Bank Charges</DIV>'+
			'<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_3"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Capital_Invest">Capital Investments</DIV>'+
   '</DIV>');
    document.write('<DIV ID="divMenu3_4" CLASS="clsMenu1">'+
    '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_4"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Deal">Deal</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_4"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Invoicing">Invoicing</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_4"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Customer_Maintenance">Customer Maintenance</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_4"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="process_main.html">Process</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_4"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="cust_report_main.html">Report</DIV>'+
		'</DIV>');
		
    document.write('<DIV ID="divMenu3_6" CLASS="clsMenu1">'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Location">Location</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Users">Users</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Instrument_Types">Instrument Types</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Issuers">Issuers</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Interest_Rate_Basis">Interest Rate Bases</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Securities">Securities</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Holidays">Holidays</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Portfolios">Clients</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Counter_Parties">Counter Parties</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Currencies">Currencies</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Settlement_Options">Settlement Options</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu3_6"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Tax_Rates">Tax Rates</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu_hout("divMenu3_6_1"); ONMOUSEOVER=ShowSubMenu1("divMenu3_6_1","211","511","150");>Limits&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="darrow.gif" width=12 height=11 border=0></DIV>'+
    '</DIV>');

    document.write('<DIV ID="divMenu3_6_1" CLASS="clsMenu2">'+
		  '<DIV ONMOUSEOUT=SubMenu2_hout("divMenu6_6"); ONMOUSEOVER=SubMenu2_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Overall_Trading">Overall Trading</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu2_hout("divMenu6_6"); ONMOUSEOVER=SubMenu2_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Maturity_Bands">Maturity Bands</DIV>'+
          '<DIV ONMOUSEOUT=SubMenu2_hout("divMenu6_6"); ONMOUSEOVER=SubMenu2_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Exposure">Exposure</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu2_hout("divMenu6_6"); ONMOUSEOVER=SubMenu2_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Cut_Lost">Cut-Loss</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu2_hout("divMenu6_6"); ONMOUSEOVER=SubMenu2_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Primary_auction_own">Primary auction (own)</DIV>'+
          '<DIV ONMOUSEOUT=SubMenu2_hout("divMenu6_6"); ONMOUSEOVER=SubMenu2_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Primary_auction_ext">Primary auction (ext)</DIV>'+
          '<DIV ONMOUSEOUT=SubMenu2_hout("divMenu6_6"); ONMOUSEOVER=SubMenu2_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Issuer">Issuer</DIV>'+
          //'<DIV ONMOUSEOUT=SubMenu2_hout("divMenu6_6"); ONMOUSEOVER=SubMenu2_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Gurantor">Guarantor</DIV>'+
		  //'<DIV ONMOUSEOUT=SubMenu2_hout("divMenu6_6"); ONMOUSEOVER=SubMenu2_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Endorser">Endorser</DIV>'+		
		  '<DIV ONMOUSEOUT=SubMenu2_hout("divMenu6_6"); ONMOUSEOVER=SubMenu2_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Dealerwise">Dealerwise</DIV>'+			
		  '<DIV ONMOUSEOUT=SubMenu2_hout("divMenu6_6"); ONMOUSEOVER=SubMenu2_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Single_Client">Single Client</DIV>'+			
    '</DIV>');
    
		
		
		//**************************************************************************************************
		////////////////////////////////
			  document.write('<DIV ID="divMenu4_1" CLASS="clsMenu1">'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu4_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Client_Ledger">Client Accounts</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu4_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Backdated_Trn">Backdated Deals</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu4_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Client_Payment">Payment Details</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu4_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL=":/login?screen_name=WD_Client_Receipt">Receipt Details</DIV>'+
		  '<DIV ONMOUSEOUT=SubMenu1_hout("divMenu4_1"); ONMOUSEOVER=SubMenu1_hover(); ONCLICK="Menu_click();" expURL="capital_gain_main.html">Capital Gain</DIV>'+
     	'</DIV>');
   ////////////////////////////////
	//***************************************************************************************************	
		
		
		
		
		}

	// -----------------------------------------------------------------------
	// 	NavBar event binding
	// -----------------------------------------------------------------------
  add_menus();

	if ("object" == typeof(tblNavBar))
	{
		tblNavBar.onmouseover = new Function("NavBar_mouseover(this);");
		tblNavBar.onmouseout = new Function("NavBar_mouseout(this);");
		tblNavBar.onselectstart = new Function("return false;");
		tblNavBar.onclick = new Function("NavBar_click(this);");
	}
	else
	parent.frames[1].document.onclick = new Function("subdocument_click(this);");


