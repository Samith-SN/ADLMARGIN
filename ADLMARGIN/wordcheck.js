	var servlet_client_url="https://dev-adlmargin.sasianet.com";
	var html_client_url="https://dev-adlmargin.sasianet.com/intranet";
  var client_t3_port="8443/ADLMARGIN/servlet";
	
	function checklength(inputStr,size,message)
	{
			var m_length=0;
			var m_difference=0;	
		  var m_fulllength="";
			chk_stat=isEmptymessage(inputStr,message);
			//if (!chk_stat && message!="No") {
			if (!chk_stat) 
		{
					m_length=inputStr.value.length;
					if (m_length > size)
				{
							alert(message+" should not be greater than "+ size.toString()+ " characters");
							inputStr.focus();
					}
		  }			
		return true
		}
	
	function format_number(object1,size) 
	{
			 var comsize=20;
			 m_format_1=object1.value;
		 	 if (m_format_1 == null || m_format_1 == "") 
		{
				  alert("Please enter a number");
					object1.focus();				
					return false;
			 }
				m_dot_count=0;
				var chk_brk=false;
				var m_integer="";
				var m_decimal="";
				var m_format="";
				m_minus=false;
				for (var i = 0; i < m_format_1.length; i++) 
		{
					var oneChar = m_format_1.charAt(i)
					if (oneChar==null || oneChar == "" || oneChar == " ") 
					{
						 var k=1;
					}
				  else 
					{	
						 m_format=m_format+oneChar; 		
					}
				}
				for (var i = 0; i < m_format.length; i++) 
		{
				var oneChar = m_format.charAt(i)
				if (oneChar== ".") 
					{
				m_dot_count=m_dot_count+1;
				}
	  		if (oneChar== "-") 
					{
				m_minus=true;
				}
				if (isNaN(oneChar) && oneChar != "," && oneChar != "." && oneChar != "-") 
					{
				alert("You have typed an incorrect charactor as a number");
				chk_brk=true;
				i=m_format.length;
				break;			
				}
				if (!isNaN(oneChar) && m_dot_count==0 ) 
					{
				m_integer=m_integer+oneChar;
				}
				if (m_dot_count>0) 
					{
				m_decimal=m_decimal+oneChar;
				}
				}
				if (chk_brk) 
		{
						object1.value="";
		 				object1.focus();
					 return false;
				}
				if (m_dot_count>1) 
		{
				alert("You have typed more than one decimal separator");
				object1.focus();
				return false;
				}
				m_format=m_integer; 
	
				m_length=m_integer.length;
			 	if (m_length > size)
		{
				alert("The length of the number cannot be more than "+size.toString());
				object1.focus();
				return false;
				}
				var m_formatted="";
				var m_new_str="";
				m_end=m_format.length;
				m_stat_pos=m_end-4;
				var m_last_pos=m_end;
				while (m_stat_pos>=0)	
		{
				  m_chk_str=m_format.substr(m_stat_pos,1);
				  if (m_chk_str!=null) 
					{
				 	 m_add_str=","+m_format.substr(m_stat_pos+1,3);
				 	 m_new_str=m_add_str+m_new_str;
				  }
				  m_last_pos=m_stat_pos;
				  m_stat_pos=m_stat_pos-3;
				}
				
				if (m_decimal == "") 
		{
				 	 m_decimal=".00";
				}
				else if (m_decimal == ".") 
		{
				 	 m_decimal=".00";
				}
				else if (m_decimal == ".0") 
		{
				 	 m_decimal=".00";
				}
				else if (m_decimal == ". 0") 
		{
				 	 m_decimal=".00";
				}
				
				m_new_str=m_format.substr(0,m_last_pos+1)+m_new_str+m_decimal;
	      if (m_minus) 
		{
				 m_new_str="-"+m_new_str;
	      }
	
				var m_left_str="";
				rem_len=16-m_new_str.length;
				while (rem_len>0) 
		{
				  m_left_str=m_left_str+"	";
					rem_len=rem_len-1;
				}
				//object1.value=m_left_str+m_new_str;
				object1.value=m_new_str;
				//return m_new_str;
				return true;
				
				}
	//Additional function
	function format_number2(object1,size) 
	{
			 var comsize=20;
			 m_format_1=object1.value;
		/* 	 if (m_format_1 == null || m_format_1 == "") {
				  alert("Please enter a number");
					object1.focus();				
					return false;
			 }*/
				m_dot_count=0;
				var chk_brk=false;
				var m_integer="";
				var m_decimal="";
				var m_format="";
				m_minus=false;
				for (var i = 0; i < m_format_1.length; i++) 
		{
					var oneChar = m_format_1.charAt(i)
					if (oneChar==null || oneChar == "" || oneChar == " ") 
					{
						 var k=1;
					}
				  else 
					{	
						 m_format=m_format+oneChar; 		
					}
				}
				for (var i = 0; i < m_format.length; i++) 
		{
				var oneChar = m_format.charAt(i)
				if (oneChar== ".") 
					{
				m_dot_count=m_dot_count+1;
				}
	  		if (oneChar== "-") 
					{
				m_minus=true;
				}
				if (isNaN(oneChar) && oneChar != "," && oneChar != "." && oneChar != "-") 
					{
				alert("You have typed an incorrect charactor as a number");
				chk_brk=true;
				i=m_format.length;
				break;			
				}
				if (!isNaN(oneChar) && m_dot_count==0 ) 
					{
				m_integer=m_integer+oneChar;
				}
				if (m_dot_count>0) 
					{
				m_decimal=m_decimal+oneChar;
				}
				}
				if (chk_brk) 
		{
						object1.value="";
		 				object1.focus();
					 return false;
				}
				if (m_dot_count>1) 
		{
				alert("You have typed more than one decimal separator");
				object1.focus();
				return false;
				}
				m_format=m_integer; 
	
				m_length=m_integer.length;
			 	if (m_length > size)
		{
				alert("The length of the number cannot be more than "+size.toString());
				object1.focus();
				return false;
				}
				var m_formatted="";
				var m_new_str="";
				m_end=m_format.length;
				m_stat_pos=m_end-4;
				var m_last_pos=m_end;
				while (m_stat_pos>=0)	
		{
				  m_chk_str=m_format.substr(m_stat_pos,1);
				  if (m_chk_str!=null) 
					{
				 	 m_add_str=","+m_format.substr(m_stat_pos+1,3);
				 	 m_new_str=m_add_str+m_new_str;
				  }
				  m_last_pos=m_stat_pos;
				  m_stat_pos=m_stat_pos-3;
				}
				
				if (m_decimal == "") 
		{
				 	 m_decimal=".0000";
				}
				else if (m_decimal == ".") 
		{
				 	 m_decimal=".0000";
				}
				else if (m_decimal == ".0") 
		{
				 	 m_decimal=".0000";
				}
				else if (m_decimal == ". 0") 
		{
				 	 m_decimal=".0000";
				}
				
				m_new_str=m_format.substr(0,m_last_pos+1)+m_new_str+m_decimal;
	      if (m_minus) 
		{
				 m_new_str="-"+m_new_str;
	      }
	
				var m_left_str="";
				rem_len=16-m_new_str.length;
				while (rem_len>0) 
		{
				  m_left_str=m_left_str+"	";
					rem_len=rem_len-1;
				}
				//object1.value=m_left_str+m_new_str;
				object1.value=m_new_str;
				//return m_new_str;
				return true;
				
				}
	
	
	//To check the number but not to display message
	function isnumberok(object1,size) 
	{
			 m_format_1=object1.value;
		 	 if (m_format_1 == null || m_format_1 == "") 
		{
					return false;
			 }
				m_dot_count=0;
				var m_integer="";
				var m_decimal="";
				var m_format="";
				m_minus=false;
				for (var i = 0; i < m_format_1.length; i++) 
		{
					var oneChar = m_format_1.charAt(i)
					if (oneChar==null || oneChar == "" || oneChar == " ") 
					{
						 var k=1;
					}
				  else 
					{	
						 m_format=m_format+oneChar; 		
					}
				}
				for (var i = 0; i < m_format.length; i++) 
		{
				var oneChar = m_format.charAt(i)
				if (oneChar== ".") 
					{
				m_dot_count=m_dot_count+1;
				}
				if (oneChar== "-") 
					{
				m_minus=true;
				}
	
				if (isNaN(oneChar) && oneChar != "," && oneChar != "." && oneChar != "-") 
					{
				return false;
				}
				if (!isNaN(oneChar) && m_dot_count==0 ) 
					{
				m_integer=m_integer+oneChar;
				}
				if (m_dot_count>0) 
					{
				m_decimal=m_decimal+oneChar;
				}
				}
				if (m_dot_count>1) 
		{
				return false;
				}
				m_format=m_integer; 
	
				m_length=m_integer.length;
			 	if (m_length > size)
		{
				return false;
				}
				return true;
				
				}
	
			
				function format_noobject(value) 
			{
				m_format=value.toString();
				m_dot_count=0;
				var m_integer="";
				var m_decimal="";
				m_minus=false;
				for (var i = 0; i < m_format.length; i++) 
					{
				var oneChar = m_format.charAt(i)
				if (oneChar== ".") 
					{
				m_dot_count=m_dot_count+1;
				}
				if (oneChar== "-") 
					{
				m_minus=true;
				}
	
				if (isNaN(oneChar) && oneChar != "," && oneChar != "." && oneChar != "-") 
					{
				alert("You have typed an incorrect charactor as a number");
				return oneChar
				}
				if (!isNaN(oneChar) && m_dot_count==0 ) 
					{
				m_integer=m_integer+oneChar;
				}
				if (m_dot_count>0) 
					{
				m_decimal=m_decimal+oneChar;
				}
				}
				if (m_dot_count>1) 
					{
				alert("You have typed more than one decimal separator");
				return false
				}
				m_format=m_integer; 
	
				var m_formatted="";
				var m_new_str="";
				m_end=m_format.length;
				m_stat_pos=m_end-4;
				var m_last_pos=m_end;
				while (m_stat_pos>=0)	
					{
				m_chk_str=m_format.substr(m_stat_pos,1);
				if  (m_chk_str!=null)
					{
				m_add_str=","+m_format.substr(m_stat_pos+1,3);
				m_new_str=m_add_str+m_new_str;
				}
				m_last_pos=m_stat_pos;
				m_stat_pos=m_stat_pos-3;
				}
				if (m_decimal == "") 
					{
				 	 m_decimal=".00";
				}
				else if (m_decimal == ".") 
					{
				 	 m_decimal=".00";
				}
				else if (m_decimal == ".0") 
					{
				 	 m_decimal=".00";
				}
				else if (m_decimal == ". 0") 
					{
				 	 m_decimal=".00";
				}
				else 
					{
				   m_decimal=m_decimal.substr(0,3);
				}
	      if (m_decimal.length<3) 
					{
				   m_decimal=m_decimal+"0";
	      }			
	      
				m_new_str=m_format.substr(0,m_last_pos+1)+m_new_str+m_decimal;
	      if (m_minus) 
					{
				 m_new_str="-"+m_new_str;
	      }
				value=m_new_str;
				return value;
				}
				
				
				//with 4 0's
				function format_noobject0(value,passed_decimalsize) 	{
					var decimalsize=4;
				  if (!isNaN(passed_decimalsize)) {
				    decimalsize=passed_decimalsize;
          }
					m_format=value.toString();
					m_dot_count=0;
					var m_integer="";
					var m_decimal="";
					m_minus=false;
					for (var i = 0; i < m_format.length; i++) 
						{
				  		var oneChar = m_format.charAt(i)
				 			if (oneChar== ".") {
								 m_dot_count=m_dot_count+1;
							}
							if (oneChar== "-") {
					 			 m_minus=true;
							}
						  if (isNaN(oneChar) && oneChar != "," && oneChar != "." && oneChar != "-") {
									alert("You have typed an incorrect charactor as a number");
									return oneChar
							}
							if (!isNaN(oneChar) && m_dot_count==0 ) {
									m_integer=m_integer+oneChar;
							}
							if (m_dot_count>0 && oneChar!= ".") {
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
								if  (m_chk_str!=null)	{
										m_add_str=","+m_format.substr(m_stat_pos+1,3);
										m_new_str=m_add_str+m_new_str;
								}
								m_last_pos=m_stat_pos;
								m_stat_pos=m_stat_pos-3;
					}
          
					if (m_decimal.length>decimalsize) {
				  		 m_decimal=m_decimal.substr(0,decimalsize);
          } else {					
		           i=1;
							 bal_length=decimalsize-m_decimal.length;
							 while (i<=bal_length) {
								 m_decimal=m_decimal+"0";
								 i=i+1;
							 }
					}
          m_decimal="."+m_decimal;

					m_new_str=m_format.substr(0,m_last_pos+1)+m_new_str+m_decimal;
	      	
					if (m_minus) {
						 m_new_str="-"+m_new_str;
	  	    }
					value=m_new_str;
					return value;
				}
				
				function unformat_number(object) 
				{
				m_format=object.value;
				var m_number="";
				for (var i = 0; i < m_format.length; i++) 
					{
				var oneChar = m_format.charAt(i)
				if (oneChar != ",")
					{
				m_number=m_number+oneChar;
				}
				}
	 			return m_number;
		 	}
	
			 	function unformat_noobject(value) 
	{
				m_format=value;
				var m_number="";
				for (var i = 0; i < m_format.length; i++) 
						{
				var oneChar = m_format.charAt(i)
				if (oneChar != ",")
					{
				m_number=m_number+oneChar;
				}
				}
	 			return m_number;
		 	}
				
	
			function elsefocus (object)
	{
		 	 object.focus();
		 	}
	
	
	// general purpose function to see if an input value has been entered at all
		function username(username)
	{
		  alert("sas");
			return true
		}
		
		function date(component)
		{
				 now= new Date();
				 component.value=now.getDate();
			return true
		}
	 
		function month(component)
		{
				 now= new Date();
				 component.value=now.getMonth() + 1;
			return true
		}
		function year(component)
		{
				 now= new Date();
				 component.value=1900 + now.getYear();
			return true
		}
	
	function isEmptymessage(inputStr,message) 
	{
		
		
		if (inputStr.value == null || inputStr.value == "") 
		{
			//if (message!="No") { 
			alert(message+" should be entered");
			inputStr.focus();
			//}
			return true;
		}
		return false
	}
	
	function islengthok(inputStr,size)
	{
			var m_length=0;
			var m_difference=0;	
		  var m_fulllength="";
			chk_stat=isEmpty(inputStr);
			if (!chk_stat) 
		{
					m_length=inputStr.value.length;
					if (m_length > size)
				{
						 return false
					}
		  }
			else 
		{
				 return false
			}
		return true
		}
	
	function isEmpty(inputStr) 
	{
		if (inputStr.value == null || inputStr.value == "") 
		{
			return true
		}
		return false
	}
	// general purpose function to see if a suspected numeric input is a positive integer
	function isPosInteger(inputVal) 
	{
		inputStr = inputVal.toString()
		for (var i = 0; i < inputStr.length; i++) 
		{
			var oneChar = inputStr.charAt(i)
			if (oneChar < "0" || oneChar > "9") 
			{
					return false
			}
		}
		return true
	}
	
	function isGreatZero(object) 
	{
		inputStr = unformat_number(object);
		if (inputStr<=0) 
		{
			 return false
		}
		return true
	}
	
	// general purpose function to see if a suspected numeric input is a positive or negative integer
	function isInteger(inputVal) 
	{
		inputStr = inputVal.toString()
		for (var i = 0; i < inputStr.length; i++) 
		{
			var oneChar = inputStr.charAt(i)
			if (i == 0 && oneChar == "-") 
			{
				continue
			}
			if (oneChar < "0" || oneChar > "9") 
			{
				return false
			}
		}
		return true
	}
	// general purpose function to see if a suspected numeric input is a positive or negative number
	function isNumber(inputVal) 
	{
		oneDecimal = false
		inputStr = inputVal.toString()
		for (var i = 0; i < inputStr.length; i++) 
		{
			var oneChar = inputStr.charAt(i)
			if (i == 0 && oneChar == "-") 
			{
				continue
			}
			if (oneChar == "." && !oneDecimal) 
			{
				oneDecimal = true
				continue
			}
			if (oneChar < "0" || oneChar > "9") 
			{
			alert('Please Enter a Number');
			return false
			}
		}
		return true
	}
	
	// check the entered month for too high a value
	function checkMonthLength(c_dd,c_mm,c_yyyy) 
	{
		
		mm=parseInt(c_mm.value);
		dd=parseInt(c_dd.value);
		yyyy=parseInt(c_yyyy.value);
	 	inputyearStr = c_yyyy.value.toString();
		if (inputyearStr.length != 4)
		{
			alert("Please enter year in four digit(YYYY) number format");
			c_yyyy.value="";	
			c_yyyy.focus();
			return false
	 		
		}
			
		if (isNaN(dd)) 
		{
			 alert("Day should be a number");
			 c_dd.focus();
			 c_dd.value="";	
			 return false
	  }
	  else if (dd<1 || dd>31) 
		{
		 	alert("Date must be between 1 and 31");
			 c_dd.focus();
			 c_dd.value="";	
	 		 return false
	
		}
		else if (isNaN(mm)) 
		{
		 alert("Month should be a number");
			 c_mm.focus();
			 c_mm.value="";	
	 		 return false
		
		}
		else if (mm<1 || mm>12) 
		{
		 	alert("Month must be between 1 and 12");
			 c_mm.focus();
			 c_mm.value="";	
	 		 return false
		
		}
		else if (isNaN(yyyy)) 
		{
		 alert("Year should be a number");
		 c_yyyy.value="";
		 c_yyyy.focus();
		 return false
	
		}
		else if (yyyy<1900 || yyyy>3000) 
		{
		 alert("Year should be between 1990 and 3000");
		 c_yyyy.value="";
		 c_yyyy.focus();
		 return false
	
		}
		
		
		var months = new
		Array("","January","February","March","April","May","June","July","August","September","October","November","December")
		if (mm==2) 
		{
		 	checkLeapMonth(c_mm,c_dd,c_yyyy);
		}
		else if ((mm == 4 || mm == 6 || mm == 9 || mm == 11) && dd > 30) 
		{
			alert(months[mm] + " has only 30 days.")
			 c_dd.focus();
			 c_dd.value="";
			 return false
		} 
		else if ( dd > 31) 
		{
				alert(months[mm] + " has only 31 days.")
				 c_dd.focus();
				 c_dd.value="";
				 return false
		}
		else if ( dd < 1) 
		{
				alert("Please check the day.")
				 c_dd.focus();
				 c_dd.value="";
				 return false
		}
	
		return true
	}
	// check the entered February date for too high a value
	function checkLeapMonth(c_mm,c_dd,c_yyyy) 
	{
		mm=parseInt(c_mm.value);
		dd=parseInt(c_dd.value);
		yyyy=parseInt(c_yyyy.value);
	 
		if (yyyy % 4 > 0 && dd > 28) 
		{
			alert("February of " + yyyy + " has only 28 days.")
			 c_dd.focus();
				c_dd.value="";
			return false
		} 
		else if (dd > 29) 
		{
				alert("February of " + yyyy + " has only 29 days.")
				 c_dd.focus();
				 	c_dd.value="";		
				return false
		}
		else if (dd < 1 || dd > 29) 
		{
				alert("Date between 1 and 29.")
				 c_dd.focus();
				 	c_dd.value="";		
				return false
		}
		return true
	}
	
	// check the entered month but do not display message
	function isMonthok(c_dd,c_mm,c_yyyy) 
	{
		
		mm=parseInt(c_mm.value);
		dd=parseInt(c_dd.value);
		yyyy=parseInt(c_yyyy.value);
	 	inputyearStr = c_yyyy.value.toString();
		if (inputyearStr.length != 4)
		{
		   alert("Year should be between 1990 and 3000");
			 c_yyyy.value="";	
			 c_yyyy.focus();
			return false
	 		
		}
		if (isNaN(dd)) 
		{
			 c_dd.focus();
			 c_dd.value="";	
			 return false
		}
	  else if (dd<1 && dd>31) 
		{
		 	alert("Date must be between 1 and 31");
			 c_dd.focus();
			 c_dd.value="";	
	 		 return false
	  }
	  else if (isNaN(mm)) 
		{
			 c_mm.focus();
			 c_mm.value="";	
	 		 return false
		}
		else if (isNaN(yyyy)) 
		{
		 c_yyyy.value="";
		 c_yyyy.focus();
		 return false
		}
		var months = new
		Array("","January","February","March","April","May","June","July","August","September","October","November","December")
		if (mm==2) 
		{
		 	isLeapMonth(c_mm,c_dd,c_yyyy);
		}
		else if ((mm == 4 || mm == 6 || mm == 9 || mm == 11) && dd > 30) 
		{
			 c_dd.focus();
			 c_dd.value="";
			 return false
		} 
		else if (dd > 31) 
		{
				 c_dd.focus();
				 c_dd.value="";
				 return false
		}
		else if (dd < 1) 
		{
				 c_dd.focus();
				 c_dd.value="";
				 return false
		}
		return true
	}
	// check the entered February date for too high a value but do not display message
	function isLeapMonth(c_mm,c_dd,c_yyyy) 
	{
		mm=parseInt(c_mm.value);
		dd=parseInt(c_dd.value);
		yyyy=parseInt(c_yyyy.value);
	 
		if (yyyy % 4 > 0 && dd > 28) 
		{
			 c_dd.focus();
			c_dd.value="";
			return false
		} 
		else if (dd > 29) 
		{
				c_dd.focus();
				c_dd.value="";		
				return false
		}
		else if (dd < 1) 
		{
				c_dd.focus();
				c_dd.value="";		
				return false
		}
		return true
	}
	function wordcheck(inputVal) {
	  TOT_VAL=inputVal.value;
	  //Initialize memory variables
		CAMT="";
		CAMT1="";
		//Store words into memory variables
		ONES="     ONE  TWO  THREEFOUR FIVE SIX  SEVENEIGHTNINE ";
		TEEN="TEN      ELEVEN   TWELVE   THIRTEEN FOURTEEN FIFTEEN  SIXTEEN  SEVENTEENEIGHTEEN NINETEEN ";
		TENS="TWENTY THIRTY FORTY  FIFTY  SIXTY  SEVENTYEIGHTY NINETY";
	  
		//Store whole rupee amount to a string
		M_MIL=space(11-Len(Trim(Str(TOT_VAL,"#######0.00")))) & Trim(Format(TOT_VAL,"#######0.00"));
    M_MILL1=Left(M_MIL,2);
		M_LAKS=Mid(M_MIL,3,9);
		CNUM1=Space(9-Len(Trim(Format(M_LAKS,"#######0.00")))) & Trim(Format(M_LAKS,"#######0.00"));
		CNUM=Left(CNUM1,6);
		//Check millions
		if Mid(M_MILL1,2,1) > " " {
		   //Msgbox Above one million
		   if Mid(M_MILL1,1,1) > " " {
				  //Msgbox Above 10 million
		      if Mid(M_MILL1,1,2) =="10" {
					   CAMT="TEN " & CAMT;
					}		
					else if Mid(M_MILL1,1,2)=="11" {
					   CAMT="ELEVEN " & CAMT;
					}		
					else if Mid(M_MILL1,1,2)=="12" {
					   CAMT="TWELVE " & CAMT;
					}		
					else if Mid(M_MILL1,1,2)=="13" {
					   CAMT="THIRTEEN " & CAMT;
					}		
					else if Mid(M_MILL1,1,2)=="14" {
					   CAMT="FOURTEEN " & CAMT;
					}		
					else if Mid(M_MILL1,1,2)=="15" {
					   CAMT="FIFTEEN " & CAMT;
					}		
					else if Mid(M_MILL1,1,2)=="16" {
					   CAMT="SIXTEEN " & CAMT;
					}		
					else if Mid(M_MILL1,1,2)=="17" {
					   CAMT="SEVENTEEN " & CAMT;
					}		
					else if Mid(M_MILL1,1,2)=="18" {
					   CAMT="EIGHTEEN " & CAMT;
					}		
					else if Mid(M_MILL1,1,2)=="19" {
					   CAMT="NINETEEN " & CAMT;
					}		
					else {
					    //Msgbox Above 20 million
							CAMT=RTrim(Mid(ONES,Val(Mid(M_MILL1,2,1))*5+1,5));
							CAMT=RTrim(Mid(TENS,Val(TENS,Val(Mid(M_MILL1,1,1))*7-13,7)) & " " & CAMT;
					}		
       }
			 else if Mid(M_MILL1,1,1)= " " {
			    //Msgbox below 10 million
					if Mid(M_MILL1,1,2)=" 1" {
					   CAMT="ONE " & CAMT;
				  }			
					else if Mid(M_MILL1,1,2) = " 2" {
					   CAMT="TWO " & CAMT;
					}
					else if Mid(M_MILL1,1,2) = " 3" {
					   CAMT="THREE " & CAMT;
					}
					else if Mid(M_MILL1,1,2) = " 4" {
					   CAMT="FOUR " & CAMT;
					}
					else if Mid(M_MILL1,1,2) = " 5" {
					   CAMT="FIVE " & CAMT;
					}
					else if Mid(M_MILL1,1,2) = " 6" {
					   CAMT="SIX " & CAMT;
					}
					else if Mid(M_MILL1,1,2) = " 7" {
					   CAMT="SEVEN " & CAMT;
					}
					else if Mid(M_MILL1,1,2) = " 8" {
					   CAMT="EIGHT " & CAMT;
					}
					else if Mid(M_MILL1,1,2) = " 9" {
					   CAMT="NINE " & CAMT;
					}
			 }	
			 CAMT=CAMT & " MILLION "	  			
		}
		if Left(CNUM,1) > " " {
		   CAMT=CAMT & RTrim(Mid(ONES,Val(Left(CNUM,1))*5+1,5))+ " HUNDRED ";
		}		
		
		inputStr = inputVal.toString()

