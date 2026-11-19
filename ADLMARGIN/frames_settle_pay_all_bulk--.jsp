<html>
	<head>
	
	<!-- header - edit "Data/yourHtmlHeader" to customize -->
	<!-- contents - edit "EventHandlers/Html file/onCreate" to customize -->
	<meta name="generator" content="ModelWorks IDE">
	
	<title>BUTTONS</title>
  <script>
	 function call_frame(){
		if(document.Form2.TXT_FROMDATE.value!="" && document.Form2.TXT_FROMMONTH.value!="" && document.Form2.TXT_FROMYEAR.value!=""){
		 parent.frames[1].location.href=""+servlet_client_url+":"+client_t3_port+"/"+client_name+"BrokerBulkPaymentsAll?chksql=Bulk_payments"+
			                              "&val_fromdate="+document.Form2.TXT_FROMDATE.value+
																		"&val_frommonth="+document.Form2.TXT_FROMMONTH.value+
																		"&val_fromyear="+document.Form2.TXT_FROMYEAR.value;
		}else{
		  alert("Please enter Date and continue.");
		}
	 }	
		
	 function chkstartdate(dayobj,monthobj,yearobj) {
			if (checkMonthLength(dayobj,monthobj,yearobj)) {
			}
	 }	
	//add by waruna 2011-02-23 
	 function display_pay_opt(){
			val=(document.Form2.Text_option.value);
				 
			if (val=='ADD'){
			        document.getElementById('date_div').style.visibility = 'visible';
					parent.document.body.rows = "20%,*";
					parent.frames[1].location.href=html_client_url+"/blank.html";
			}
			else if (val=='DEl'){
			//parent.fset.rows="6%,15%";
			//parent.document.body.cols = "*,5%";
			parent.document.body.rows = "6%,*";
			document.getElementById('date_div').style.visibility = 'hidden';
			parent.frames[1].location.href=html_client_url+"/mbfsl_delete_payments.html";;
			}
			
			
			}
			
			
	 
	</script>
	</head>
<BODY	BGCOLOR="SILVER" >
<FORM NAME="Form2">
<TABLE WIDTH="100%" BGCOLOR="darkblue" >
				<TR BGCOLOR="darkblue">
					<TD WIDTH="28%">
					<!--add by waruna 2011-02-23-->
					<SELECT NAME="Text_option" STYLE="{color: black; font: bold 10pt arial;}" onChange="display_pay_opt()">
										<OPTION VALUE="ADD" SELECTED>Add Payments</option> 
										<OPTION VALUE="DEl" >Delete Payments</option> 
							
					</SELECT>
					<!--end add by waruna 2011-02-23-->
					</TD>
				    <TD WIDTH="46%">	
					<INPUT TYPE="Button" NAME="save_but"   VALUE="Save&nbsp; " STYLE="{cursor:hand; color: black; font: bold 10pt arial;border-style: outset; background-color: darkgray;}" onClick="document.Form2.save_but.disabled=true;parent.frames[1].beforesubmit()">
					<INPUT TYPE="Button" NAME="calcel_but" VALUE="Cancel"      STYLE="{cursor:hand; color: black; font: bold 10pt arial;border-style: outset;background-color: darkgray; }" onClick="document.Form2.save_but.disabled=false;top.frames[1].location.href='frames_settle_pay_all_bulk.html'">
					<INPUT TYPE="Button" NAME="Exit_but"   VALUE="    Exit   " STYLE="{cursor:hand; color: black; font: bold 10pt arial;border-style: outset;background-color: darkgray; }"  onClick="top.frames[1].location.href='low.html'"> 
			  </TD>
		<TD STYLE="{color: white ;font: bold 10pt arial;text-align:right;}" WIDTH="32%">
			<B>Settlement Management - Broker Payments All</B>
		</TD>					
	</TR>
	</TABLE> 
	<br>
	<div id="date_div">	
	<TABLE WIDTH="100%"BORDER="0" CELLPADDING="2" CELLSPACING="2" STYLE="{color: black; font: bold 9pt arial;}">
		<TR>
		  <TD WIDTH="1%"></TD>
			<TD WIDTH="10%" STYLE="{color: black; font: bold 9pt arial;}">Date </TD>
			<TD WIDTH="50%"><INPUT TYPE="Text" NAME="TXT_FROMDATE" SIZE=3 MAXLENGTH=2 ><INPUT
				TYPE="Text" NAME="TXT_FROMMONTH" SIZE=3 MAXLENGTH=2 ><INPUT
				TYPE="Text" NAME="TXT_FROMYEAR" SIZE=5 MAXLENGTH=4	ONBLUR="chkstartdate(document.Form2.TXT_FROMDATE,document.Form2.TXT_FROMMONTH,document.Form2.TXT_FROMYEAR)">
			  <INPUT TYPE="Button" NAME="go_but" VALUE=" &nbsp;Go&nbsp; " onClick="call_frame()" STYLE="{cursor:hand; color: black; font: bold 10pt arial;border-style: outset;background-color: darkgray; }" > 	
			</TD>								
			<TD WIDTH="*%"></TD>	
		</TR>
	</TABLE>
    </div>	
	<script language="JavaScript1.2" SRC="validate_v1.js"></SCRIPT>

 </FORM>
	</body>
</html>

