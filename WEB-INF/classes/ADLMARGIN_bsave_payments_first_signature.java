import java.io.*;
import java.util.*;
import java.lang.*;
import javax.servlet.*;
import javax.servlet.http.*;import net.sasianet.ADLMARGIN.*;
import sun.misc.BASE64Decoder;
import java.sql.*;

import oracle.jdbc.driver.*;
import java.net.*;


public class ADLMARGIN_bsave_payments_first_signature extends HttpServlet {
	
	Connection conn;	
	Statement stmt;
	String m_msg,m_url,mm_url;
	File file1;
	CallableStatement callstmt1;
	ResultSet rs,rs1=null;
	PreparedStatement pstmt,pstmt1 = null;
	
	
	//ResultSet rs,rs1;
	java.text.NumberFormat nf;
	String m_chksql,m_dispno,m_specific_code;
	String reqstr, m_reciept_no;
	String m_funds_due;
	public int k,j;
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@DEFINING URLs######################## 
	String m_username="";
	String m_jsp_client_url;
	String m_servlet_client_url;
	String m_client_t3_port;
	String m_scr_name,mm_entry_type,mm_SelectedPrinter,mm_BankCode,mm_maxentries,mm_dd,mm_mm,mm_yy,mm_amtInWords,mm_approve,mm_payee,mm_FirstSign,mm_SecondSign,mm_Amt,mm_Amount;
	
	//	String m_entry_type;
	//	String m_schema_name;
	//	String m_client_name;
	//	String m_drive ="";
	//	String m_zip_class="";
	
	//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
	
	public void service(HttpServletRequest req, HttpServletResponse res)
		throws IOException
	{
		
		try {
			
			BufferedReader input = new BufferedReader(new InputStreamReader(req.getInputStream()),2000);
			reqstr = input.readLine();
			String m_mat_date,m_val_date;
			
			/* /#########################	TO DISPLAY POSTED DATA FROM HTML PAGE###########################	
			
			PrintStream out4 = new PrintStream(res.getOutputStream());
			out4.println(reqstr);
			
			//************************************************************	*/
			
			//try {
			//
			//m_sn_methods = new ADLMARGIN_sn_methods();
			//conn = m_sn_methods.met_user_validate(req); 
		    HttpSession session = req.getSession(true);//ADLMARGIN_MGT_conn_methods
			ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
			conn = m_sn_methods.met_user_validate(session);
			m_username = m_sn_methods.username;
			m_jsp_client_url = m_sn_methods.jsp_client_url;
			m_servlet_client_url= m_sn_methods.servlet_client_url;
			m_client_t3_port= m_sn_methods.client_t3_port; 
			String m_client_name= m_sn_methods.client_name; 
			m_scr_name=req.getParameter("Hid_scr_name"); 
			String m_schema_name=m_sn_methods.schema_name.trim();
			
			//m_schema_name= m_sn_methods.schema_name;
			//m_client_name= m_sn_methods.client_name;  // to get mbfsl_
			//m_drive      = m_sn_methods.drive;
			//m_zip_class  = m_sn_methods.zip_class;
			//String m_PaidBy =m_sn_methods.company_name;
			String m_PaidBy ="";
			nf = java.text.NumberFormat.getInstance(Locale.US);
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			
			//********************************************************
			
			
			//************************************************************
			//}
			
			PrintStream out2 = new PrintStream(res.getOutputStream());
			stmt = conn.createStatement ();
			PrintStream out = new PrintStream(res.getOutputStream());
			//out.println(m_scr_name+"------");
			///sss
			/*if (m_scr_name.trim().equals("payment_first_sig")){
				
				synchronized(this){  
					
					
					String m_pay_no="";
					String m_pay_status="";
					m_msg = "'Details Save Successfuly'";
					
					//m_url =m_jsp_client_url+"/frames_confirm_dealticket.html";
										
					int m_maxentries =(Integer.parseInt((String)req.getParameter("hid_count")));
					for (int j=1; j<=m_maxentries; j++){
						String m_chkapprove=(String)req.getParameter("signature_"+(Integer.toString(j)));
						String m_chkreject=(String)req.getParameter("reject_"+(Integer.toString(j)));
						if (m_chkapprove!=null && m_chkapprove.equals("on")) {
							
							m_pay_no=(String)req.getParameter("PAYMENTNO"+(Integer.toString(j)));
							m_pay_status="ENT";//(String)req.getParameter("STATUS"+(Integer.toString(j)));
							callstmt1 = conn.prepareCall( "BEGIN "+m_schema_name+"." +"DN_PAYMENTS_FIRST_SIG(?,?,?);END;");
							callstmt1.setString(1,m_pay_no.toUpperCase());
							callstmt1.setString(2,m_pay_status.toUpperCase());
							callstmt1.setString(3,m_username.toUpperCase());
							callstmt1.execute();
							
							if(req.getParameter("comment_"+(Integer.toString(j)))!=null){
							callstmt1 = conn.prepareCall( "BEGIN "+m_schema_name+"." +"DN_PAYMENT_APPROVAL_COMMENT(?,?,?,?,?);END;");
							callstmt1.setString(1,m_pay_no.toUpperCase());
							callstmt1.setString(2,(String)req.getParameter("comment_"+(Integer.toString(j))));
							callstmt1.setString(3,"SIG1");
							callstmt1.setString(4,m_username.toUpperCase());
							callstmt1.setString(5,"PAYMENT_FIRST_SIG");
							
							callstmt1.execute();
						    }
							conn.commit();
							
						}else if (m_chkreject!=null && m_chkreject.equals("on")) {
							m_pay_no=(String)req.getParameter("PAYMENTNO"+(Integer.toString(j)));
							m_pay_status="ENT";//(String)req.getParameter("STATUS"+(Integer.toString(j)));
							callstmt1 = conn.prepareCall( "BEGIN "+m_schema_name+"." +"DN_PAYMENTS_FIRST_SIG_REJECT(?,?,?);END;");
							callstmt1.setString(1,m_pay_no.toUpperCase());
							callstmt1.setString(2,m_pay_status.toUpperCase());
							callstmt1.setString(3,m_username.toUpperCase());
							callstmt1.execute();
							
							if(req.getParameter("comment_"+(Integer.toString(j)))!=null){
							callstmt1 = conn.prepareCall( "BEGIN "+m_schema_name+"." +"DN_PAYMENT_APPROVAL_COMMENT(?,?,?,?,?);END;");
							callstmt1.setString(1,m_pay_no.toUpperCase());
							callstmt1.setString(2,(String)req.getParameter("comment_"+(Integer.toString(j))));
							callstmt1.setString(3,"CANCEL");
							callstmt1.setString(4,m_username.toUpperCase());
							callstmt1.setString(5,"PAYMENT_FIRST_SIG");
							
							callstmt1.execute();
						    }
							conn.commit();
							
						}//on
					}//for loop
					callstmt1.close();
					
					m_url =m_jsp_client_url+"/dn_first_signature.jsp";
						
				}	// end of synchronize
			}
			*/
			
			if (m_scr_name.trim().equals("payment_first_sig")){
				
				synchronized(this){  
					
					
					String m_pay_no="";
					String m_pay_status="";
					m_msg = "'Details Save Successfuly'";
					
					//m_url =m_jsp_client_url+"/frames_confirm_dealticket.html";
					int m_main_maxentries =(Integer.parseInt((String)req.getParameter("hid_count")));
					
				for(int i=1;i<=m_main_maxentries;i++){
					
					if((String)req.getParameter("hid_count_x"+i)!=null){
							
					int m_maxentries =(Integer.parseInt((String)req.getParameter("hid_count_x"+i)));
					String m_table_gid_x      = "tb_pen_"+i+"_x_";
					
					for (int j=1; j<=m_maxentries; j++){
						
						String m_chkapprove=(String)req.getParameter("approve"+m_table_gid_x+(Integer.toString(j)));
						String m_chkreject=(String)req.getParameter("reject"+m_table_gid_x+(Integer.toString(j)));
						
						if (m_chkapprove!=null && m_chkapprove.equals("on")) {
							
							m_pay_no     = (String)req.getParameter("PAYMENTNO"+m_table_gid_x+(Integer.toString(j)));
							m_pay_status = "ENT";//(String)req.getParameter("STATUS"+(Integer.toString(j)));
							
							if(m_pay_no.substring(0,2).equals("SP")||m_pay_no.substring(0,2).equals("GS")){
							//out.println((String)req.getParameter("PAYMENTNO"+m_table_gid_x+(Integer.toString(j))));
							
										callstmt1 = conn.prepareCall( "BEGIN "+m_schema_name+"." +"DN_PAYMENTS_FIRST_SIG(?,?,?);END;");
										callstmt1.setString(1,m_pay_no.toUpperCase());
										callstmt1.setString(2,m_pay_status.toUpperCase());
										callstmt1.setString(3,m_username.toUpperCase());
										callstmt1.execute();
										
										//if(req.getParameter("comment_"+m_table_gid_x+(Integer.toString(j)))!=null){
										callstmt1 = conn.prepareCall( "BEGIN "+m_schema_name+"." +"DN_PAYMENT_APPROVAL_COMMENT(?,?,?,?,?);END;");
										callstmt1.setString(1,m_pay_no.toUpperCase());
										callstmt1.setString(2,(String)req.getParameter("comment"+m_table_gid_x+(Integer.toString(j))));
										callstmt1.setString(3,"SIG1");
										callstmt1.setString(4,m_username.toUpperCase());
										callstmt1.setString(5,"PAYMENT_FIRST_SIG");
										
										callstmt1.execute();
						   // }
						 }else if(m_pay_no.substring(0,2).equals("LP")){
							 
										callstmt1 = conn.prepareCall( "BEGIN "+m_schema_name+"." +"DN_REBATE_PAYMENTS_FIRST_SIG(?,?,?);END;");
										callstmt1.setString(1,m_pay_no.toUpperCase());
										callstmt1.setString(2,m_pay_status.toUpperCase());
										callstmt1.setString(3,m_username.toUpperCase());
										callstmt1.execute();
										
										//if(req.getParameter("comment_"+m_table_gid_x+(Integer.toString(j)))!=null){
										callstmt1 = conn.prepareCall( "BEGIN "+m_schema_name+"." +"DN_PAYMENT_APPROVAL_COMMENT(?,?,?,?,?);END;");
										callstmt1.setString(1,m_pay_no.toUpperCase());
										callstmt1.setString(2,(String)req.getParameter("comment"+m_table_gid_x+(Integer.toString(j))));
										callstmt1.setString(3,"SIG1");
										callstmt1.setString(4,m_username.toUpperCase());
										callstmt1.setString(5,"PAYMENT_FIRST_SIG");	
										
									}else if(m_pay_no.substring(0,2).equals("CW")){
							 
										callstmt1 = conn.prepareCall( "BEGIN "+m_schema_name+"." +"DN_WITHDRAWAL_FIRST_SIG(?,?,?);END;");
										callstmt1.setString(1,m_pay_no.toUpperCase());
										callstmt1.setString(2,m_pay_status.toUpperCase());
										callstmt1.setString(3,m_username.toUpperCase());
										callstmt1.execute();
										
										//if(req.getParameter("comment_"+m_table_gid_x+(Integer.toString(j)))!=null){
										callstmt1 = conn.prepareCall( "BEGIN "+m_schema_name+"." +"DN_PAYMENT_APPROVAL_COMMENT(?,?,?,?,?);END;");
										callstmt1.setString(1,m_pay_no.toUpperCase());
										callstmt1.setString(2,(String)req.getParameter("comment"+m_table_gid_x+(Integer.toString(j))));
										callstmt1.setString(3,"SIG1");
										callstmt1.setString(4,m_username.toUpperCase());
										callstmt1.setString(5,"PAYMENT_FIRST_SIG");	
										
						 }		
							conn.commit();
							
						}else if (m_chkreject!=null && m_chkreject.equals("on")) {
							m_pay_no=(String)req.getParameter("PAYMENTNO"+m_table_gid_x+(Integer.toString(j)));
							m_pay_status="ENT";//(String)req.getParameter("STATUS"+(Integer.toString(j)));
							
							if(m_pay_no.substring(0,2).equals("SP")||m_pay_no.substring(0,2).equals("GS")){
											callstmt1 = conn.prepareCall( "BEGIN "+m_schema_name+"." +"DN_PAYMENTS_FIRST_SIG_REJECT(?,?,?);END;");
											callstmt1.setString(1,m_pay_no.toUpperCase());
											callstmt1.setString(2,m_pay_status.toUpperCase());
											callstmt1.setString(3,m_username.toUpperCase());
											callstmt1.execute();
											
											//if(req.getParameter("comment"+m_table_gid_x+(Integer.toString(j)))!=null){
											callstmt1 = conn.prepareCall( "BEGIN "+m_schema_name+"." +"DN_PAYMENT_APPROVAL_COMMENT(?,?,?,?,?);END;");
											callstmt1.setString(1,m_pay_no.toUpperCase());
											callstmt1.setString(2,(String)req.getParameter("comment"+m_table_gid_x+(Integer.toString(j))));
											callstmt1.setString(3,"CANCEL");
											callstmt1.setString(4,m_username.toUpperCase());
											callstmt1.setString(5,"PAYMENT_FIRST_SIG");
											
											callstmt1.execute();
						    //}
							 }else if(m_pay_no.substring(0,2).equals("LP")){
								
								            callstmt1 = conn.prepareCall( "BEGIN "+m_schema_name+"." +"DN_REBATE_PAY_FIRST_SIG_REJECT(?,?,?);END;");
											callstmt1.setString(1,m_pay_no.toUpperCase());
											callstmt1.setString(2,m_pay_status.toUpperCase());
											callstmt1.setString(3,m_username.toUpperCase());
											callstmt1.execute();
											
											//if(req.getParameter("comment"+m_table_gid_x+(Integer.toString(j)))!=null){
											callstmt1 = conn.prepareCall( "BEGIN "+m_schema_name+"." +"DN_PAYMENT_APPROVAL_COMMENT(?,?,?,?,?);END;");
											callstmt1.setString(1,m_pay_no.toUpperCase());
											callstmt1.setString(2,(String)req.getParameter("comment"+m_table_gid_x+(Integer.toString(j))));
											callstmt1.setString(3,"CANCEL");
											callstmt1.setString(4,m_username.toUpperCase());
											callstmt1.setString(5,"PAYMENT_FIRST_SIG");
											
											callstmt1.execute();
										}else if(m_pay_no.substring(0,2).equals("CW")){
								
								            callstmt1 = conn.prepareCall( "BEGIN "+m_schema_name+"." +"DN_WITHDRAWAL_FIRST_SIG_REJECT(?,?,?);END;");
											callstmt1.setString(1,m_pay_no.toUpperCase());
											callstmt1.setString(2,m_pay_status.toUpperCase());
											callstmt1.setString(3,m_username.toUpperCase());
											callstmt1.execute();
											
											//if(req.getParameter("comment"+m_table_gid_x+(Integer.toString(j)))!=null){
											callstmt1 = conn.prepareCall( "BEGIN "+m_schema_name+"." +"DN_PAYMENT_APPROVAL_COMMENT(?,?,?,?,?);END;");
											callstmt1.setString(1,m_pay_no.toUpperCase());
											callstmt1.setString(2,(String)req.getParameter("comment"+m_table_gid_x+(Integer.toString(j))));
											callstmt1.setString(3,"CANCEL");
											callstmt1.setString(4,m_username.toUpperCase());
											callstmt1.setString(5,"PAYMENT_FIRST_SIG");
											
											callstmt1.execute();
						     }
							conn.commit();
							
						}//on
					}//for loop
				}// if	
				}//i  for loop
					
					
					m_url =m_jsp_client_url+"/dn_first_signature.jsp";
					//m_url =m_jsp_client_url+"/"+req.getParameter("redirect_url"); 
						
				}	// end of synchronize
			}
			
			//-------------------------------------------------------------------------------------------
			
			conn.close();
			this.destroy();
			
			out.println("<HTML><HEAD>");
			out.println("<SCRIPT language='JavaScript'>");
			out.println("function displaymsg() {");
			if (!m_scr_name.trim().equals("Deal_Tiketting")){
				// !m_scr_name.trim().equals("confirm_dealticket") ||    -- upul removed this on 13/03/2000 --
				out.println("alert("+m_msg+");");
			}
			else {
				//out.println("alert("+m_msg+");");
			}
			
			if (m_scr_name.trim().equals("Settlement_Reciepts")) {
				out.println("window.location.href='"+m_servlet_client_url+":"+m_client_t3_port+"/"+m_client_name+"report_settlemgt_receipt_aft?reci_no="+m_reciept_no+"&funds_due="+m_funds_due+"&chksql=confirm_reci'");
			}				
			else {
				out.println("window.location.href='"+m_url+"'");
			}
			if (m_scr_name.trim().equals("DELETE_BLFUNDS1")||m_scr_name.trim().equals("DELETE_REPO")||m_scr_name.trim().equals("Repo_Rollover_Delete")){
				out.println("top.frames[1].window.location.href='"+m_url+"'");
			}
			else {
				out.println("window.location.href='"+m_url+"'");
			}
			if (m_scr_name.trim().equals("SETTLEMENT_CHEQUES")) {//added By Nilu on 28-10-2004/8:19  SRF 0408-058 
				out.println("top.frames[1].window.location.href='"+m_url+"'");
			}
			out.println("}</SCRIPT></HEAD>");
			out.println("<body onload='displaymsg();'></body>");
			out.println("</html>");
			out.flush();
			out.close();			
			
			/*	else{
			out.println("window.location.href='"+m_url+"'");
			} */
			
		}
		catch (Throwable th) {
			PrintStream out = new PrintStream(res.getOutputStream());
			th.printStackTrace(out);
			//out.println(m_rate_code);
			//out.println(m_rate_desc);
			//out.println(m_rate);
			
			out.println("<HTML><HEAD>");
			out.println("<SCRIPT language='JavaScript'>");
			out.println("function displaymsg() {");
			out.println("alert('Error When Saving Record..New Message');");
			out.println("window.history.back();"); 
			out.println("}</SCRIPT></HEAD>");
			out.println("<body onload='displaymsg();'></body>");
			out.println("</html>");
			out.flush();
			out.close();			
			try {
				callstmt1.close();
				conn.close();
			}	
			catch (Exception eti) {}
			ByteArrayOutputStream buf = new ByteArrayOutputStream();
			try {
				PrintStream ps = new PrintStream(buf);
				th.printStackTrace(ps);
				ps.println("Error When Saving Invoice Schedule3");
				ps.flush();
				ps.close();
				
			}
			catch (Exception e) {
				out.println("Error When Saving Invoice Schedule4");
				out.flush();
				out.close();
				try {
					callstmt1.close();
					conn.close();
					this.destroy();
				}	
				catch (Exception eti) {}
				
				ByteArrayOutputStream ostr = new ByteArrayOutputStream();
				e.printStackTrace(new PrintStream(ostr));
				ostr.close();
			}
		}
	}
	
	public String getServletInfo() {
		return getServletInfo();
	}
	
	public ServletConfig retServletConfig() {
		return getServletConfig();
	}
}

