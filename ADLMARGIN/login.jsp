<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en-us">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<title>DealNet - Margin Trading </title>
		<link rel="stylesheet" type="text/css" href="css/scubaformcss.css" />
		<script type="text/javascript" src="mainjs.js"></script>
		<script type="text/javascript" src="validate.js"></script>
		
		<script type='text/javascript'>
			 
			document.onkeypress=KeyPress;
			function KeyPress(e)
			{
				var code =(window.event)? event.keyCode : e.which;
				if (code == 13) {
					save_window();
				} 
			}

			
			function save_window(){
				
				if (LoginValidate(document.LogForm)){
					

					document.LogForm.action=""+servlet_client_url+":"+client_t3_port+"/"+client_name+"LoginHandler?screen_name=WD_MT_MAIN";//AF_LOGIN
					document.LogForm.submit();
					
				}
				return;
				
			}
			
			
			function MM_preloadImages() { //v3.0
			var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
			var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
			if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
			}
			function MM_swapImgRestore() { //v3.0
			var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
			}
			function MM_findObj(n, d) { //v4.01
			var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
			d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
			if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
			for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
			if(!x && d.getElementById) x=d.getElementById(n); return x;
			}

			function MM_swapImage() { //v3.0
			var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
			if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
			}
		</script>
		
	</head>
	<body onload="document.LogForm.username.focus()">
		 <table><tr><td height="200px"></td></tr></table>
		<!--Begin Form Container -->
		<div id="container" >
			
			
			<!--<h3>COMFAC LOGIN</h3>-->
			<form name="LogForm" method="post">
				
				<!--Begin Fieldset Container For Login-->
				<fieldset style='text-align:center'>
					<!--<legend>Login</legend>-->
					<div class="reqfield">
						<label id="lbluname" for="username">Username:</label>
						<input name="username" id="username" class="textbox" type="text" title="Enter your username" onFocus="UnameFocus()" onBlur="strTrim(this,null,null,'USERNAME'),this.style.backgroundColor='#ffffff'; this.style.border = '1px solid #acc6db'" maxlength="10" onKeyUp="strTrim(this,null,null,'USERNAME')" onKeyDown="this.style.backgroundColor='#ffffff'" />
					</div>
					<div class="reqfield">
						
						<label id="lblpass" for="password">Password:</label>
						<input name="password" id="password" class="textbox" type="password" title="Enter your password" onFocus="PassWordFocus()" onBlur="this.style.backgroundColor='#ffffff'; this.style.border = '1px solid #acc6db'" onKeyUp="" onKeyDown="this.style.backgroundColor='#ffffff'" />
					</div>
					
					<!-- <div class="reqfield">
						<label id="lblcompany" for="company">Company:</label>
						<select class='cselect' id='company' name="company">
							<option value='CLC' selected >CLC</option>
							<option value='LOLC'>LOLC</option>
						</select>
					</div>
					!-->
					
					<br />
					<br />
					<!--<div style='text-align: center'><input name="Submit" class="submit" value="Login" type="button" onClick="save_window()" /></div>!-->
					<div align="center"><img src="images/Login.jpg" alt="Login to DealNet" width="110" height="35" onclick="save_window()"/></div>
					
				</div>
			</fieldset>
			<!--End Fieldset Container For Login-->
		</form>
	</div>
	
	<!--End Form Container-->
	
	<div align="center">
      <p class="style3"><img src="images/Options_01.jpg" width="26" height="30" /><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image15','','images/SystemUpdate_Over.jpg',1)"><img src="images/SystemUserGuide.jpg" name="Image15" width="112" height="30" border="0" id="Image15" /></a><img src="images/Options_03.jpg" width="21" height="30" /><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image16','','images/OnlineSupport_Over.jpg',1)"><img src="images/OnlineSupport.jpg" name="Image16" width="92" height="30" border="0" id="Image16" /></a><img src="images/Options_03.jpg" width="21" height="30" /><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image17','','images/ContactUs_over.jpg',1)"><img src="images/ContactUs.jpg" name="Image17" width="105" height="30" border="0" id="Image17" /></a><img src="images/Options_03.jpg" width="21" height="30" /><a href="#" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image18','','images/Downloads_Over.jpg',1)"><img src="images/Downloads.jpg" name="Image18" width="66" height="30" border="0" id="Image18" /></a><img src="images/Options_11.jpg" width="28" height="30" /></p>
    </div>
</body>
</html>