import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;import net.sasianet.ADLMARGIN.*;
import java.sql.*;
//import ADLMARGIN_sn_methods;
import java.util.*;


public class ADLMARGIN_login_name extends javax.servlet.http.HttpServlet {
	
	Connection conn;
	Statement stmt;
	public ResultSet rs;
	public String m_chksql;
	String m_dispno,m_specific_code;
	String m_html_client_url;
	String m_servlet_client_url;
	String m_client_t3_port;
	java.text.NumberFormat nf;
	
	public synchronized void service(HttpServletRequest req, HttpServletResponse
		res)
		throws IOException
	{
		
		try {
			HttpSession session = req.getSession(true);
			ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
			conn = m_sn_methods.met_user_validate(session); 
			stmt = conn.createStatement();
			String m_schema_name = m_sn_methods.schema_name.trim();
			nf = java.text.NumberFormat.getInstance(Locale.US);
			nf.setMinimumFractionDigits(2);
			
			String m_country,m_state,m_city; 
			String m_username="";
			String password="";
			String rights="norights";
			int count=0;
			
			
			res.setStatus(HttpServletResponse.SC_OK);
			res.setContentType("text/xml");
			ServletOutputStream out = res.getOutputStream();
			
			m_chksql = req.getParameter("chksql");
			m_username = m_sn_methods.username;
			
			if (m_chksql.trim().equals("cf_opt")) {
				out.println("<DATA>");
				out.println("<ITEM>");
				out.println("<R1>"+m_username+"</R1>");
				out.println("</ITEM>");
				out.println("</DATA>");
				
			}else if(m_chksql.trim().equals("chk_login_exp")){
				
				rs = stmt.executeQuery (" SELECT ROUND(EXPIRE_DURATION-(TO_DATE(TO_CHAR(SYSDATE,'DD-MON-YYYY'),'DD-MON-YYYY')-A.ENT_DATE),0),REMINDER "+
					" FROM   "+m_schema_name+".DN_REF_PASSWORD_UPDATE A ,"+m_schema_name+".DN_REF_PASSWORD_EXPIRE_DUR B "+
					" WHERE  DN_USER='"+m_username+"' ");
				boolean more = rs.next();
				out.println("<DATA>");
				out.println("<ITEM>");
				if(more) {
					
					out.println("<R1>"+rs.getString(1)+"</R1>");
					out.println("<R2>"+rs.getString(2)+"</R2>");
					
				}else{
					
					out.println("<R1>"+0+"</R1>");
					out.println("<R2>"+0+"</R2>");
				}
				out.println("</ITEM>");	
				out.println("</DATA>");
			}else if(m_chksql.trim().equals("chk_login_lock")){
				
				
				rs = stmt.executeQuery (" SELECT ACTIVE_STATUS "+
					" FROM   "+m_schema_name+".DN_REF_USER A  "+
					" WHERE  DN_USER='"+m_username+"' ");
				boolean more = rs.next();
				out.println("<DATA>");
				out.println("<ITEM>");
				if(more) {
					
					out.println("<R1>"+rs.getString(1)+"</R1>");
					
					
				}else{
					
					out.println("<R1></R1>");
					
				}
				out.println("</ITEM>");	
				out.println("</DATA>");
				
			}else if(m_chksql.trim().equals("get_margin_sys_date")){
				
				
				rs = stmt.executeQuery (" SELECT  TO_CHAR(A.LAST_DAILY+1,'DD | MONTH | YYYY') "+
					" FROM   "+m_schema_name+".DN_SYS_PARAMETER A  "+
					" ");
				boolean more = rs.next();
				out.println("<DATA>");
				out.println("<ITEM>");
				if(more) {
					
					out.println("<R1>"+rs.getString(1)+"</R1>");
					
					
				}else{
					
					out.println("<R1></R1>");
					
				}
				out.println("</ITEM>");	
				out.println("</DATA>");
				
			}else {
				out.println("<DATA>");
				out.println("<ITEM>");
				out.println("<R1>XXXX</R1>");
				out.println("</ITEM>");
				out.println("</DATA>");
			}
			
			out.close();
			conn.close();
			this.destroy();
			
			
		}
		catch (Exception e) {
			try {
				conn.close();
			}	
			catch (Exception eti) {}
			
			ByteArrayOutputStream ostr = new ByteArrayOutputStream();
			e.printStackTrace(new PrintStream(ostr));
			
			ServletOutputStream out = res.getOutputStream();
			out.println(ostr.toString());
			out.close();
			
		}
	}
}
