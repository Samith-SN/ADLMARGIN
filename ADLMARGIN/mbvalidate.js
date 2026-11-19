function checklength(inputStr,size,message){
		var m_length=0;
		var m_difference=0;	
	  var m_fulllength="";
		chk_stat=isEmptymessage(inputStr,message);
		//if (!chk_stat && message!="No") {
		if (!chk_stat) {
				m_length=inputStr.value.length;
				if (m_length > size){
						alert(message+" should not be greater than "+ size.toString()+ " characters");
						inputStr.focus();
				}
	  }			
	return true
	}

function format_number(object1,size) {
		 var comsize=20;
		 m_format_1=object1.value;
	 	 if (m_format_1 == null || m_format_1 == "") {
			  alert("Please enter a number");
				object1.focus();				
				return false;
		 }
			m_dot_count=0;
			var chk_brk=false;
			var m_integer="";
			var m_decimal="";
			var m_format="";
			for (var i = 0; i < m_format_1.length; i++) {
				var oneChar = m_format_1.charAt(i)
				if (oneChar==null || oneChar == "" || oneChar == " ") {
					 var k=1;
				}
			  else {	
					 m_format=m_format+oneChar; 		
				}
			}
			for (var i = 0; i < m_format.length; i++) {
			var oneChar = m_format.charAt(i)
			if (oneChar== ".") {
			m_dot_count=m_dot_count+1;
			}
			if (isNaN(oneChar) && oneChar != "," && oneChar != ".") {
			alert("You have typed an incorrect charactor as a number");
			chk_brk=true;
			i=m_format.length;
			break;			
			}
			if (!isNaN(oneChar) && m_dot_count==0 ) {
			m_integer=m_integer+oneChar;
			}
			if (m_dot_count>0) {
			m_decimal=m_decimal+oneChar;
			}
			}
			if (chk_brk) {
					object1.value="";
	 				object1.focus();
				 return false;
			}
			if (m_dot_count>1) {
			alert("You have typed more than one decimal separator");
			object1.focus();
			return false;
			}
			m_format=m_integer; 

			m_length=m_integer.length;
		 	if (m_length > size){
			alert("The length of the number cannot be more than "+size.toString());
			object1.focus();
			return false;
			}
			var m_formatted="";
			var m_new_str="";
			m_end=m_format.length;
			m_stat_pos=m_end-4;
			var m_last_pos=m_end;
			while (m_stat_pos>=0)	{
			  m_chk_str=m_format.substr(m_stat_pos,1);
			  if (m_chk_str!=null) {
			 	 m_add_str=","+m_format.substr(m_stat_pos+1,3);
			 	 m_new_str=m_add_str+m_new_str;
			  }
			  m_last_pos=m_stat_pos;
			  m_stat_pos=m_stat_pos-3;
			}
			
			if (m_decimal == "") {
			 	 m_decimal="";
			}
			else if (m_decimal == ".") {
			 	 m_decimal="";
			}
			else if (m_decimal == ".0") {
			 	 m_decimal="";
			}
			else if (m_decimal == ". 0") {
			 	 m_decimal="";
			}
			
			m_new_str=m_format.substr(0,m_last_pos+1)+m_new_str+m_decimal;

			var m_left_str="";
			rem_len=16-m_new_str.length;
			while (rem_len>0) {
			  m_left_str=m_left_str+"	";
				rem_len=rem_len-1;
			}
			//object1.value=m_left_str+m_new_str;
			object1.value=m_new_str;
			//return m_new_str;
			return true;
			
			}
//To check the number but not to display message
function isnumberok(object1,size) {
		 m_format_1=object1.value;
	 	 if (m_format_1 == null || m_format_1 == "") {
				return false;
		 }
			m_dot_count=0;
			var m_integer="";
			var m_decimal="";
			var m_format="";

			for (var i = 0; i < m_format_1.length; i++) {
				var oneChar = m_format_1.charAt(i)
				if (oneChar==null || oneChar == "" || oneChar == " ") {
					 var k=1;
				}
			  else {	
					 m_format=m_format+oneChar; 		
				}
			}
			for (var i = 0; i < m_format.length; i++) {
			var oneChar = m_format.charAt(i)
			if (oneChar== ".") {
			m_dot_count=m_dot_count+1;
			}
			if (isNaN(oneChar) && oneChar != "," && oneChar != ".") {
			return false;
			}
			if (!isNaN(oneChar) && m_dot_count==0 ) {
			m_integer=m_integer+oneChar;
			}
			if (m_dot_count>0) {
			m_decimal=m_decimal+oneChar;
			}
			}
			if (m_dot_count>1) {
			return false;
			}
			m_format=m_integer; 

			m_length=m_integer.length;
		 	if (m_length > size){
			return false;
			}
			return true;
			
			}

		
			function format_noobject(value) {
			m_format=value.toString();
			m_dot_count=0;
			var m_integer="";
			var m_decimal="";
			for (var i = 0; i < m_format.length; i++) {
			var oneChar = m_format.charAt(i)
			if (oneChar== ".") {
			m_dot_count=m_dot_count+1;
			}
			if (isNaN(oneChar) && oneChar != "," && oneChar != ".") {
			alert("You have typed an incorrect charactor as a number");
			return false
			}
			if (!isNaN(oneChar) && m_dot_count==0 ) {
			m_integer=m_integer+oneChar;
			}
			if (m_dot_count>0) {
			m_decimal=m_decimal+oneChar;
			}
			}
			if (m_dot_count>1) {
			alert("You have typed more than one decimal separator");
			return false
			}
			m_format=m_integer; 

			var m_formatted="";
			var m_new_str="";
			m_end=m_format.length;
			m_stat_pos=m_end-4;
			var m_last_pos=m_end;
			while (m_stat_pos>=0)	{
			m_chk_str=m_format.substr(m_stat_pos,1);
			if  (m_chk_str!=null){
			m_add_str=","+m_format.substr(m_stat_pos+1,3);
			m_new_str=m_add_str+m_new_str;
			}
			m_last_pos=m_stat_pos;
			m_stat_pos=m_stat_pos-3;
			}
			if (m_decimal == "") {
			 	 m_decimal=".00";
			}
			else if (m_decimal == ".") {
			 	 m_decimal=".00";
			}
			else if (m_decimal == ".0") {
			 	 m_decimal=".00";
			}
			else if (m_decimal == ". 0") {
			 	 m_decimal=".00";
			}
			m_new_str=m_format.substr(0,m_last_pos+1)+m_new_str+m_decimal;
			value=m_new_str;
			return value;
			}
		
			function unformat_number(object) {
			m_format=object.value;
			var m_number="";
			for (var i = 0; i < m_format.length; i++) {
			var oneChar = m_format.charAt(i)
			if (oneChar != ","){
			m_number=m_number+oneChar;
			}
			}
 			return m_number;
	 	}

		 	function unformat_noobject(value) {
			m_format=value;
			var m_number="";
			for (var i = 0; i < m_format.length; i++) {
			var oneChar = m_format.charAt(i)
			if (oneChar != ","){
			m_number=m_number+oneChar;
			}
			}
 			return m_number;
	 	}
			

		function elsefocus (object){
	 	 object.focus();
	 	}


// general purpose function to see if an input value has been entered at all
	function username(username){
	  alert("sas");
		return true
	}
	
	function date(component){
			 now= new Date();
			 component.value=now.getDate();
		return true
	}
 
	function month(component){
			 now= new Date();
			 component.value=now.getMonth() + 1;
		return true
	}
	function year(component){
			 now= new Date();
			 component.value=1900 + now.getYear();
		return true
	}

function isEmptymessage(inputStr,message) {
	
	
	if (inputStr.value == null || inputStr.value == "") {
		//if (message!="No") { 
		alert(message+" should be entered");
		inputStr.focus();
		//}
		return true;
	}
	return false
}

function islengthok(inputStr,size){
		var m_length=0;
		var m_difference=0;	
	  var m_fulllength="";
		chk_stat=isEmpty(inputStr);
		if (!chk_stat) {
				m_length=inputStr.value.length;
				if (m_length > size){
					 return false
				}
	  }
		else {
			 return false
		}
	return true
	}

function isEmpty(inputStr) {
	if (inputStr.value == null || inputStr.value == "") {
		return true
	}
	return false
}
// general purpose function to see if a suspected numeric input is a positive integer
function isPosInteger(inputVal) {
	inputStr = inputVal.toString()
	for (var i = 0; i < inputStr.length; i++) {
		var oneChar = inputStr.charAt(i)
		if (oneChar < "0" || oneChar > "9") {
				return false
		}
	}
	return true
}

function isGreatZero(object) {
	inputStr = unformat_number(object);
	if (inputStr<=0) {
		 return false
	}
	return true
}

// general purpose function to see if a suspected numeric input is a positive or negative integer
function isInteger(inputVal) {
	inputStr = inputVal.toString()
	for (var i = 0; i < inputStr.length; i++) {
		var oneChar = inputStr.charAt(i)
		if (i == 0 && oneChar == "-") {
			continue
		}
		if (oneChar < "0" || oneChar > "9") {
			return false
		}
	}
	return true
}
// general purpose function to see if a suspected numeric input is a positive or negative number
function isNumber(inputVal) {
	oneDecimal = false
	inputStr = inputVal.toString()
	for (var i = 0; i < inputStr.length; i++) {
		var oneChar = inputStr.charAt(i)
		if (i == 0 && oneChar == "-") {
			continue
		}
		if (oneChar == "." && !oneDecimal) {
			oneDecimal = true
			continue
		}
		if (oneChar < "0" || oneChar > "9") {
			return false
		}
	}
	return true
}

// check the entered month for too high a value
function checkMonthLength(c_dd,c_mm,c_yyyy) {
	
	mm=parseInt(c_mm.value);
	dd=parseInt(c_dd.value);
	yyyy=parseInt(c_yyyy.value);
 	inputyearStr = c_yyyy.value.toString();
	if (inputyearStr.length != 4){
		alert("Please enter year in four digit(YYYY) number format");
		c_yyyy.focus();
		return false
 		
	}
		
	if (isNaN(dd)) {
		 alert("Day should be a number");
		 c_dd.focus();
		 c_dd.value="";	
		 return false
  }
  else if (dd<1 || dd>31) {
	 	alert("Date must be between 1 and 31");
		 c_dd.focus();
		 c_dd.value="";	
 		 return false

	}
	else if (isNaN(mm)) {
	 alert("Month should be a number");
		 c_mm.focus();
		 c_mm.value="";	
 		 return false
	
	}
	else if (mm<1 || mm>12) {
	 	alert("Month must be between 1 and 12");
		 c_mm.focus();
		 c_mm.value="";	
 		 return false
	
	}
	else if (isNaN(yyyy)) {
	 alert("Year should be a number");
	 c_yyyy.value="";
	 c_yyyy.focus();
	 return false

	}
	else if (yyyy<1900 || yyyy>3000) {
	 alert("Year should be between 1990 and 3000");
	 c_yyyy.value="";
	 c_yyyy.focus();
	 return false

	}
	
	
	var months = new
	Array("","January","February","March","April","May","June","July","August","September","October","November","December")
	if (mm==2) {
	 	checkLeapMonth(c_mm,c_dd,c_yyyy);
	}
	else if ((mm == 4 || mm == 6 || mm == 9 || mm == 11) && dd > 30) {
		alert(months[mm] + " has only 30 days.")
		 c_dd.focus();
		 c_dd.value="";
		 return false
	} 
	else if ( dd > 31) {
			alert(months[mm] + " has only 31 days.")
			 c_dd.focus();
			 c_dd.value="";
			 return false
	}
	else if ( dd < 1) {
			alert("Please check the day.")
			 c_dd.focus();
			 c_dd.value="";
			 return false
	}

	return true
}
// check the entered February date for too high a value
function checkLeapMonth(c_mm,c_dd,c_yyyy) {
	mm=parseInt(c_mm.value);
	dd=parseInt(c_dd.value);
	yyyy=parseInt(c_yyyy.value);
 
	if (yyyy % 4 > 0 && dd > 28) {
		alert("February of " + yyyy + " has only 28 days.")
		 c_dd.focus();
			c_dd.value="";
		return false
	} 
	else if (dd > 29) {
			alert("February of " + yyyy + " has only 29 days.")
			 c_dd.focus();
			 	c_dd.value="";		
			return false
	}
	else if (dd < 1 || dd > 29) {
			alert("Date between 1 and 29.")
			 c_dd.focus();
			 	c_dd.value="";		
			return false
	}
	return true
}

// check the entered month but do not display message
function isMonthok(c_dd,c_mm,c_yyyy) {
	
	mm=parseInt(c_mm.value);
	dd=parseInt(c_dd.value);
	yyyy=parseInt(c_yyyy.value);
 	inputyearStr = c_yyyy.value.toString();
	if (inputyearStr.length != 4){
		c_yyyy.focus();
		return false
 		
	}
	if (isNaN(dd)) {
		 c_dd.focus();
		 c_dd.value="";	
		 return false
	}
  else if (dd<1 && dd>31) {
	 	alert("Date must be between 1 and 31");
		 c_dd.focus();
		 c_dd.value="";	
 		 return false
  }
  else if (isNaN(mm)) {
		 c_mm.focus();
		 c_mm.value="";	
 		 return false
	}
	else if (isNaN(yyyy)) {
	 c_yyyy.value="";
	 c_yyyy.focus();
	 return false
	}
	var months = new
	Array("","January","February","March","April","May","June","July","August","September","October","November","December")
	if (mm==2) {
	 	isLeapMonth(c_mm,c_dd,c_yyyy);
	}
	else if ((mm == 4 || mm == 6 || mm == 9 || mm == 11) && dd > 30) {
		 c_dd.focus();
		 c_dd.value="";
		 return false
	} 
	else if (dd > 31) {
			 c_dd.focus();
			 c_dd.value="";
			 return false
	}
	else if (dd < 1) {
			 c_dd.focus();
			 c_dd.value="";
			 return false
	}
	return true
}
// check the entered February date for too high a value but do not display message
function isLeapMonth(c_mm,c_dd,c_yyyy) {
	mm=parseInt(c_mm.value);
	dd=parseInt(c_dd.value);
	yyyy=parseInt(c_yyyy.value);
 
	if (yyyy % 4 > 0 && dd > 28) {
		 c_dd.focus();
		c_dd.value="";
		return false
	} 
	else if (dd > 29) {
			c_dd.focus();
			c_dd.value="";		
			return false
	}
	else if (dd < 1) {
			c_dd.focus();
			c_dd.value="";		
			return false
	}

	return true
}


