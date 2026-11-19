	function checkcorrectdate(c_dd,c_mm,c_yyyy) 
	{
		
		mm=c_mm;
		dd=c_dd;
	  yyyy=parseInt(c_yyyy);
	 	inputyearStr = c_yyyy.toString();
		if (inputyearStr.length != 4)
		{
			return false
	 		
		}
			
		if (isNaN(dd)) 
		{
			 return false
	  }
	  else if (dd<1 || dd>31) 
		{
	 		 return false
	
		}
		else if (isNaN(mm)) 
		{
	 		 return false
		
		}
		else if (mm<1 || mm>12) 
		{
		// 	alert("Month must be between 1 and 12");
	 		 return false
		
		}
		else if (isNaN(yyyy)) 
		{
		// alert("Year should be a number");
		 return false
	
		}
		else if (yyyy<1900 || yyyy>3000) 
		{
		// alert("Year should be between 1990 and 3000");
		 return false
	
		}
		
		
		var months = new
		Array("","January","February","March","April","May","June","July","August","September","October","November","December")
		if (mm==2) 
		{
		 //	checkLeapMonth(c_mm,c_dd,c_yyyy);
		//***************************************checking february*************************
		mm=parseInt(c_mm);
		dd=parseInt(c_dd);
		yyyy=parseInt(c_yyyy);
	 
						if (yyyy % 4 > 0 && dd > 28) 
						{
							return false
						} 
						else if (dd > 29) 
						{
							//	alert("February of " + yyyy + " has only 29 days.")
								return false
						}
						else if (dd < 1 || dd > 29) 
						{
								return false
						}
						else {
								return true
            }
 //************************************************************
		}
		else if ((mm == 4 || mm == 6 || mm == 9 || mm == 11) && dd > 30) 
		{
			if(mm=="04"){	
			// alert(months[04] + " has only 30 days.")
			}
			else if(mm=="06"){
						// alert(months[06] + " has only 30 days.")
			}
			else if(mm=="09"){
					//	 alert(months[09] + " has only 30 days.")
			}
			else if(mm=="11"){
						// alert(months[11] + " has only 30 days.")
			}
      else {
			 //  alert("selcted month has only 30 days");
			}		
			 return false
		} 
		else if ( dd > 31) 
		{
				 return false
		}
		else if ( dd < 1) 
		{
				 return false
		}
	
		return true
	}
