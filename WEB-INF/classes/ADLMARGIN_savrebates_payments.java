import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;import net.sasianet.ADLMARGIN.*;
import sun.misc.BASE64Decoder;
import java.sql.*;
//import ADLMARGIN_sn_methods;
import oracle.jdbc.driver.*;


public class ADLMARGIN_savrebates_payments extends HttpServlet {
	
	Connection conn;	
	File file1;
	CallableStatement callstmt1;
	//ADLMARGIN_sn_methods m_sn_methods;
	String reqstr,m_deal_no,m_msg;
	ResultSet rs,rs1  = null;
	Statement stmt;
    int m_maxentries1,m_maxentries2,m_maxentries3;
	
	String m_country,m_state,m_city; 
	String username   = "";
    String m_username = "";
	String password   = "";
	String rights     = "norights";
	int count         = 0;
    double m_tunor,m_modes,m_amount;
	
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@DEFINING URLs######################## 
	String m_html_client_url;
	String m_jsp_client_url;
	String m_servlet_client_url;
	String m_client_t3_port;
	//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
	
	
	public void service(HttpServletRequest req, HttpServletResponse res)
		throws IOException
	{
		try {
			
			/*ADLMARGIN_sn_methods m_sn_methods = new ADLMARGIN_sn_methods();
            conn = m_sn_methods.met_user_validate(req);*/
			HttpSession session = req.getSession(true);//ADLMARGIN_MGT_conn_methods
			ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
			conn = m_sn_methods.met_user_validate(session);
			
		    stmt = conn.createStatement ();
			m_username = m_sn_methods.username;
			m_html_client_url = m_sn_methods.html_client_url;
			m_jsp_client_url = m_sn_methods.jsp_client_url;
		    m_servlet_client_url= m_sn_methods.servlet_client_url;
			m_client_t3_port= m_sn_methods.client_t3_port; 
			String m_schema_name=m_sn_methods.schema_name.trim();
			username=m_username;
			
			//conn =
			//  DriverManager.getConnection("jdbc:oracle:oci7:@MLL",username,password);
			BufferedReader input = new BufferedReader(new InputStreamReader(req.getInputStream()),2000);
			
			reqstr = input.readLine();
			//m_sn_methods = new SAMP_sn_methods();
			String m_mat_date,m_rebate_date;
			String M_SCR_NAME;
			PrintStream out1 = new PrintStream(res.getOutputStream());
			
	    M_SCR_NAME=(String)req.getParameter("SCR_NAME"); 
		//out1.println("***"+M_SCR_NAME+"****");	
			
	  
		if (M_SCR_NAME.equals("REBATEGRID")) {
			synchronized(this){
			    String  m_sq_save_order ="";
				
				callstmt1 = conn.prepareCall( "BEGIN "+m_schema_name+".TRN_SETTLE_REBATE_PAYMENTS(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);END;");//?,?,?,?
				int m_maxentries =(Integer.parseInt((String)req.getParameter("hid_count")));
					    rs   = stmt.executeQuery("SELECT TO_CHAR(SYSDATE,'YY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_PAY_ENT_ORDER.NEXTVAL),3,'0')  FROM DUAL"	);		
					boolean more = rs.next();	
					while(more){
						m_sq_save_order = rs.getString(1);
					   	more            = rs.next();
					} 
				
				for (int j=1; j<m_maxentries; j++){
				 
					    String m_chkapprove         = (String)req.getParameter("save_status_"+(Integer.toString(j)));
					    if (m_chkapprove!=null && m_chkapprove.equals("on")) {
						
													String m_deal_no="";
													if (m_deal_no=="") {
													callstmt1.registerOutParameter(1,java.sql.Types.CHAR);
													}
													else {
													callstmt1.setString(1,m_deal_no);
													}
													callstmt1.setString(2, "GEN");
													callstmt1.setString(3,  "D");
													callstmt1.setString(4,(String)req.getParameter("deal_no_"+(Integer.toString(j))));
													callstmt1.setString(5,(String)req.getParameter("facility_no_"+(Integer.toString(j)))); 
													/*m_rebate_date = 
													req.getParameter("Text_rebates_new_date1")+"/"+
													req.getParameter("Text_rebates_new_month1")+"/"+
													req.getParameter("Text_rebates_new_year1");*/
													callstmt1.setString(6,(String)req.getParameter("sett_type_"+(Integer.toString(j))));
													callstmt1.setDouble(7,Double.parseDouble((String)req.getParameter("settle_amount_"+(Integer.toString(j)))));
													
													
													String m_branch         = (String)req.getParameter("account_no_"+(Integer.toString(j))).substring(0,req.getParameter("account_no_"+(Integer.toString(j))).lastIndexOf("@"));
					                                String m_account        = (String)req.getParameter("account_no_"+(Integer.toString(j))).substring(req.getParameter("account_no_"+(Integer.toString(j))).lastIndexOf("@")+1);
						
						
													callstmt1.setString(8,m_branch);
													callstmt1.setString(9,m_account); 
													
													callstmt1.setString(10,username); 
													callstmt1.setString(11,(String)req.getParameter("rebate_date_"+(Integer.toString(j)))); 
													callstmt1.setString(12,null); 
													callstmt1.setString(13,(String)req.getParameter("comment_"+(Integer.toString(j))));
													callstmt1.setString(14,"ENTER");
													callstmt1.setString(15,(String)req.getParameter("deal_no_"+(Integer.toString(j))));
													callstmt1.setString(16,m_sq_save_order);
													
													String m_trn_date = 
													req.getParameter("TXT_FROMDATE")+"/"+
													req.getParameter("TXT_FROMMONTH")+"/"+
													req.getParameter("TXT_FROMYEAR");
													callstmt1.setString(17,m_trn_date);
													
													
													callstmt1.execute();
													if (m_deal_no.equals("")) {
													m_deal_no = callstmt1.getString(1);
												}
												
										}
				
				}
								
			     m_msg = "Deal is deleted successfully.";
			  }
			}
			
			
			
			//try {
				PrintStream out = new PrintStream(res.getOutputStream());
				out.println("<HTML><HEAD>");
				out.println("<SCRIPT language='JavaScript'>");
				out.println("function displaymsg() {");
				//out.println("parent.frames[0].document.applets[0].saveinnerhtml('');");
				//out.println("parent.location.href='http://www.srilanka.sasianet.lk/mbfsl/dn_fullsettle_frame1.html'");
				if (M_SCR_NAME.equals("DEL")) {
				out.println("alert('"+m_msg+"');");
				out.println("location.href='"+m_jsp_client_url+"/dn_rebate_payment.jsp'");
				}
				else if (M_SCR_NAME.equals("MAIN") || M_SCR_NAME.equals("REBATEGRID") ) {
				out.println("alert('"+m_msg+"');");
				out.println("location.href='"+m_jsp_client_url+"/dn_rebate_payment.jsp'");
				}
				//out.println("alert('Details Saved Successfully.');");
				out.println("}</SCRIPT></HEAD>");
				out.println("<body onload='displaymsg();'></body>");
				out.println("</html>");
				out.flush();
		  /*}
			catch (java.io.FileNotFoundException eio) {
				PrintStream out = new PrintStream(res.getOutputStream());
				out.println(reqstr);
				out.println("Error When Saving Details.");
				out.flush();
			}*/
			
		}
		catch (Throwable th) {
			PrintStream out = new PrintStream(res.getOutputStream());
			th.printStackTrace(out);
			
			out.println("<HTML><HEAD>");
			out.println("<SCRIPT language='JavaScript'>");
			out.println("function displaymsg() {");
			out.println("alert('Error When Saving Details.');");
			out.println("}</SCRIPT></HEAD>");
			out.println("</html>");
			out.flush();
			try {
				callstmt1.close();
				conn.close();
			}	
			catch (Exception eti) {}
			ByteArrayOutputStream buf = new ByteArrayOutputStream();
			try {
				PrintStream ps = new PrintStream(buf);
				th.printStackTrace(ps);
				out.println(reqstr);
				ps.println("Error When Saving Details.");
			  ps.flush();
				
			}
			catch (Exception e) {
				out.println(reqstr);
				out.println("Error When Saving Details.");
			  out.flush();
				try {
					callstmt1.close();
					conn.close();
				}	
				catch (Exception eti) {}
				
				ByteArrayOutputStream ostr = new ByteArrayOutputStream();
				e.printStackTrace(new PrintStream(ostr));
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

