

	///////ssssssssss
		
		else if (m_chksql.trim().equals("port_lookup4")) {								
						
				String m_portcode = req.getParameter("port_code");
				
				String m_valfromdate = req.getParameter("val_fromdate")+"/"+				       
													 req.getParameter("val_frommonth")+"/"+
													 req.getParameter("val_fromyear");														
				String m_valtodate = req.getParameter("val_todate")+"/"+
													 req.getParameter("val_tomonth")+"/"+
													 req.getParameter("val_toyear");		
														
				out.println("<HTML><head></head>");								
				out.println("<TITLE>Brok Income From Portfolio Details </TITLE>");
				out.println("<BODY LEFTMARGIN='0' TOPMARGIN='0'>");	
				out.println("<FORM NAME='Form1'>");
				out.println("<TABLE BORDER='1' WIDTH='100%' BGCOLOR='white' STYLE='{cursor: hand; font: 9pt arial;}'><B>");				
				//out.println("<TR BGCOLOR='silver' ><TD WIDTH='10%' STYLE='{text-align:center;}'><B><FONT COLOR='black'>Portfolio Code </TD><TD WIDTH='10%' STYLE='{text-align:center;}'><B><FONT COLOR='black' >Client Code </TD><TD WIDTH='50%' STYLE='{text-align:center;}' ><B><FONT COLOR='black' >Name</TD><TD WIDTH='15%' STYLE='{text-align:center;}'><B><FONT COLOR='black'>Debit </TD><TD WIDTH='15%' STYLE='{text-align:center;}'><B><FONT COLOR='black'>Credit</TD></FONT></B></TR>");
				out.println("<TR BGCOLOR='silver' ><TD WIDTH='40%' STYLE='{text-align:center;}'><B><FONT COLOR='black'>Portfolio Code </TD><TD WIDTH='60%' STYLE='{text-align:center;}'><B><FONT COLOR='black' >Deal No </TD><TD WIDTH='60%' STYLE='{text-align:center;}'><B><FONT COLOR='black' >Trn Date </TD><TD WIDTH='60%' STYLE='{text-align:center;}'><B><FONT COLOR='black' >Trn Amount </TD></FONT></B></TR>");

				double xDRTOT=0;
				double xCRTOT=0;	
					
				try {			
						
						rs = stmt.executeQuery ( " SELECT A.DN_PORTFOLIO_CODE ,A.DOCREFNO,A.TRNDATE,A.TRNAMOUNT " +
									 " FROM DEALADMIN.DN_ACC_LICENCEE_GEN_ACCOUNT A,DEALADMIN.DN_REF_PORTFOLIO B "+
									 " WHERE  A.DN_PORTFOLIO_CODE = B.PORTFOLIO_CODE AND  " +
									 //" --A.DN_PORTFOLIO_CODE='BRCP' AND "+
									 " A.PROC_DESC LIKE 'BR%' AND " +
									 " A.DRCR_STATUS = 'CR' AND  " +
									 " A.DN_PORTFOLIO_CODE = '"+m_portcode+"' AND " +
									 "TO_DATE(TO_CHAR(A.ENTDATE,'DD/MM/YYYY'),'DD/MM/YYYY')>= TO_DATE('"+m_valfromdate+"','DD/MM/YYYY') AND "+
									 " TO_DATE(TO_CHAR(A.ENTDATE,'DD/MM/YYYY'),'DD/MM/YYYY')<= TO_DATE('"+m_valtodate+"','DD/MM/YYYY')"); 
					boolean more = rs.next();							
					 //int tot_1 = 0;
					while (more) {
					//out.println("1 "+rs.getString(1));
					 //tot_1 = rs.getString(1);
					//out.println("2 "+rs.getString(2));
					out.println("<TR BGCOLOR='white' >");
					
					//ssssssss

