import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;import net.sasianet.ADLMARGIN.*;
import sun.misc.BASE64Decoder;
import java.sql.*;
//import ADLMARGIN_sn_methods;
//import oracle.jdbc.driver.*;

public class ADLMARGIN_fsavpre_autho extends HttpServlet {
	Connection conn;
	Statement stmt;
	File file1;
	CallableStatement callstmt1, callstmt2,callstmt3;
	
	String reqstr;
	String m_deal_no;
	int m_maxentries1;
	int m_maxentries2;
	String m_country,m_state,m_city,s; 
	String username="";
	String m_username="";
	String password="";
	String rights="norights";
	String M_SCR_NAME,dirty,basis,yield,setval,par,cost;
	
	
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@DEFINING URLs######################## 
	String m_jsp_client_url;
	String m_servlet_client_url;
	String m_client_t3_port;
	//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
	
	
	int count;
	int m_count;
	double m_yield;
	double m_clean;
	double m_faceval;
	double m_dirty;
	double m_accint;
	double m_cost;
	double m_setamo;
	double m_feeamo1;
	double m_feeamo2;
	double m_val1;
	double m_val2;
	double m_totamou1;
	double m_totamou2;
	public void service(HttpServletRequest req, HttpServletResponse res)
		
		throws IOException
	{
		try {
			
			//
			//conn = m_sn_methods.met_user_validate(req); 
			ServletOutputStream out88 = res.getOutputStream();	
		
		HttpSession session = req.getSession(true);
		ADLMARGIN_MGT_conn_methods m_sn_methods1 = new ADLMARGIN_MGT_conn_methods();
		String m_jsp_client_url = m_sn_methods1.jsp_client_url;
		Object done = (String)session.getValue("logon.isDone"); // marker object
			if (done == null) {
				out88.println("<html><head>");
				out88.println("<script language='JavaScript'>");
				out88.println("function displaymsg() {");
				out88.println("alert('Your login expired or invalid');");
				out88.println("window.location.href='"+m_jsp_client_url+"/login.htm';");
				out88.println("}</script></head>");
				out88.println("<body onload='displaymsg();'></body>");
				out88.println("</html>");
				out88.flush();
				return;
			}
			ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
			conn = m_sn_methods.met_user_validate(session);
			
			m_username = m_sn_methods.username;
			m_jsp_client_url = m_sn_methods.jsp_client_url;
			m_servlet_client_url= m_sn_methods.servlet_client_url;
			m_client_t3_port= m_sn_methods.client_t3_port; 
			String m_client_name=m_sn_methods.client_name;
			String m_schema_name=m_sn_methods.schema_name.trim();	
			BufferedReader input = new BufferedReader(new InputStreamReader(req.getInputStream()),2000);
			//ServletOutputStream out88 = res.getOutputStream();
						
			
			reqstr = input.readLine();
			M_SCR_NAME        = (String)m_sn_methods.met_formdata(reqstr, "SCR_NAME");
				
					
			
			if (M_SCR_NAME.equals("MAIN")) {
										
				
				String m_txt_bcode= "";
				String m_txt_scode= "";
				
				String m_facility_code = (String)m_sn_methods.met_formdata(reqstr, "txt_client");
				String m_broker_code   = (String)m_sn_methods.met_formdata(reqstr, "txt_broker");
				String m_buy_sell      = (String)m_sn_methods.met_formdata(reqstr, "rdb_buy_sell");
				
				if(m_buy_sell.equals("BUY")){
				 
				   m_txt_bcode = m_facility_code;
				   m_txt_scode = m_broker_code;	
			    
			    }else{ //
				   m_txt_bcode = m_broker_code;
				   m_txt_scode = m_facility_code;	
				}
				
			    PrintStream out = new PrintStream(res.getOutputStream());
				out.println(" "+m_facility_code+" "+m_broker_code+" "+m_buy_sell);
				out.flush();
				
					callstmt1 = conn.prepareCall("BEGIN "+m_schema_name+".DN_PRE_AUTHO_IN1(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);END;");// ,? scripless
					m_deal_no="";
					if (m_deal_no=="") {
						callstmt1.registerOutParameter(1,java.sql.Types.CHAR);
					}else{
						callstmt1.setString(1,m_deal_no);
					}					
					callstmt1.setString(2, m_txt_bcode);
					callstmt1.setString(3, m_txt_scode);
					callstmt1.setString(4, (String)m_sn_methods.met_formdata(reqstr, "txt_instype"));
					callstmt1.setString(5, (String)m_sn_methods.met_formdata(reqstr, "txt_security_ident"));
					callstmt1.setString(6, (String)m_sn_methods.met_formdata(reqstr, "TXT_ENCODE"));
					callstmt1.setString(7, "SLR");
					
					callstmt1.setString(8, (String)m_sn_methods.met_formdata(reqstr, "hid_valdate"));
					String string = m_sn_methods.met_formdata(reqstr, "hid_date") + "/" +
						m_sn_methods.met_formdata(reqstr, "hid_month") + "/" +
						m_sn_methods.met_formdata(reqstr, "hid_year");
					 callstmt1.setString(9, string);
						
					
						
						callstmt1.setString(10, "0");
						callstmt1.setString(11, "0");
						callstmt1.setString(12, "0");//TXT_TOT_COST
						callstmt1.setString(13, m_sn_methods.met_unformat_number((String)m_sn_methods.met_formdata(reqstr, "TXT_CLEAN")));	//Price per share			
						callstmt1.setString(14, m_sn_methods.met_unformat_number((String)m_sn_methods.met_formdata(reqstr, "txt_no_of_shares")));//No of shares
						callstmt1.setString(15, m_sn_methods.met_unformat_number((String)m_sn_methods.met_formdata(reqstr, "TXT_CLEAN")));
						callstmt1.setString(16, "0");//TXT_PAR
						callstmt1.setString(17, "0");//TXT_BROKER_COST
						callstmt1.setString(18, m_username);	
						callstmt1.setString(19, m_deal_no);
						callstmt1.setString(20,(String)m_sn_methods.met_formdata(reqstr, "cust_stat"));
						callstmt1.setString(21,(String)m_sn_methods.met_formdata(reqstr, "HID_SCRIPT"));
						callstmt1.setString(22, "");
						callstmt1.setString(23, "EQUITY");					
						callstmt1.setString(24,  m_sn_methods.met_unformat_number((String)m_sn_methods.met_formdata(reqstr, "TXT_NOMINAL")));
						String buystring = m_sn_methods.met_formdata(reqstr, "TXT_BDATE") + "/" +
							m_sn_methods.met_formdata(reqstr, "TXT_BMONTH") + "/" +
							m_sn_methods.met_formdata(reqstr, "TXT_BYEAR");
						callstmt1.setString(25, buystring);
						String sellstring = m_sn_methods.met_formdata(reqstr, "TXT_SDATE") + "/" +
							m_sn_methods.met_formdata(reqstr, "TXT_SMONTH") + "/" +
							m_sn_methods.met_formdata(reqstr, "TXT_SYEAR");
						callstmt1.setString(26, sellstring);	
						callstmt1.setString(27,(String)m_sn_methods.met_formdata(reqstr, "TXT_contract"));//--scripless
								
					
						callstmt1.setString(28, m_sn_methods.met_unformat_number((String)m_sn_methods.met_formdata(reqstr, "SEL_DEALTYPE")));//added by sva on 23-03-2005 inventory  
						callstmt1.setString(29,"WD_OUTRIGHTS_PRE_INPUT");			

				//	callstmt1.setString(28,(String)m_sn_methods.met_formdata(reqstr, "swift_stat")); // Added by Manjula on 20-07-04 -for swift status--VC of PCTF 0406-051
					callstmt1.execute();
					if (m_deal_no.equals("")){
						m_deal_no = callstmt1.getString(1);
			   	}					
					
				
			}
		   		
			
			try {
			
				try {	callstmt1.close(); conn.close();}catch (Exception eio) {}
				
				 if (M_SCR_NAME.equals("MAIN")) {
					
					
					PrintStream out = new PrintStream(res.getOutputStream());
					out.println("<HTML><HEAD>");
					out.println("<SCRIPT language='JavaScript'>");
					
					out.println("function displaymsg() {");
					out.println("alert('Details Saved Successfully. Ref No-"+m_deal_no+"' );");
					out.println("window.location.href='"+m_jsp_client_url+"/DN_Outrights_Pre_Input.jsp'");
					out.println("}</SCRIPT></HEAD>");
					out.println("<body onload='displaymsg();'></body>");
					out.println("</html>");
					out.flush();
				}		
			}
			catch (java.io.FileNotFoundException eio) {
				PrintStream out = new PrintStream(res.getOutputStream());
				out.println(reqstr);
				out.println("Error When Saving Details.");
				out.flush();
			}
			
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

