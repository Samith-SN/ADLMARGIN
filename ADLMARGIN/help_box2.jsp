<html>
<head>
		
		
<title>Margin Trading </title>
<script language="JavaScript1.2">
	function displaydata() {
		helpdata.innerHTML=window.dialogArguments.htmlstr;
	}
	
	function close_help_new(id,id1) {
		window.dialogArguments.returnval= id.innerText;
		window.dialogArguments.returnval1= id1.innerText;
		window.close();
	}
	function close_help_new2(id,id1,id2) {
		window.dialogArguments.returnval= id.innerText;
		window.dialogArguments.returnval1= id1.innerText;
		window.dialogArguments.returnval2= id2.innerText;
		window.close();
	}
	
	function close_help_new3(id,id1,id2,id3) {
		window.dialogArguments.returnval= id.innerText;
		window.dialogArguments.returnval1= id1.innerText;
		window.dialogArguments.returnval2= id2.innerText;
		window.dialogArguments.returnval3 =id3.innerText;
		window.close();
	}
	
	
	function close_help_new10(id1,id2,id3,id4,id5,id6,id7,id8,id9,id10,id11) {
		window.dialogArguments.returnval1= id1.innerText;
		window.dialogArguments.returnval2= id2.innerText;
		window.dialogArguments.returnval3 =id3.innerText;
		window.dialogArguments.returnval4= id4.innerText;
		window.dialogArguments.returnval5= id5.innerText;
		window.dialogArguments.returnval6= id6.innerText;
		window.dialogArguments.returnval7= id7.innerText;
		window.dialogArguments.returnval8= id8.innerText;
		window.dialogArguments.returnval9= id9.innerText;
		window.dialogArguments.returnval10= id10.innerText;
		window.dialogArguments.returnval11= id11.innerText;
		
		window.close();
	}
	
	function close_help_delete(id1,id2,id3,id4,id5,id6) {
		window.dialogArguments.returnval1= id1.innerText;
		window.dialogArguments.returnval2= id2.innerText;
		window.dialogArguments.returnval3 =id3.innerText;
		window.dialogArguments.returnval4= id4.innerText;
		window.dialogArguments.returnval5= id5.innerText;
		window.dialogArguments.returnval6= id6.innerText;
		window.close();
	}
	
	
	function close_help(id) {
		window.dialogArguments.returnval= id.innerText;
		window.close();
	}
	function mouseover_setings(id) {
		id.style.color="white";
		id.style.background="darkblue";
	}
	function mouseout_setings(id) {
		id.style.color="black";
		id.style.background="white";
	}
</SCRIPT>


</head>
<body onLoad="displaydata()">
<DIV ID=helpdata>
</DIV>
</body>
</html>

