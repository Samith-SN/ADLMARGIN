import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import sun.misc.BASE64Decoder; 
////import ADLPMS_sn_methods;
import java.util.*;

import oracle.jdbc.driver.*;

public class ADLPMS_foffice_pf_review_rpt_equity extends javax.servlet.http.HttpServlet {
	
	Connection conn;
	Statement stmt,stmt3;
	CallableStatement callstmt;
	ADLPMS_sn_methods m_sn_methods;
	java.text.NumberFormat nf,nf1;
	public String check_sql,base_rate,m_port,m_inst,mmm_dat;
	public ResultSet rs,rs1,rs2,rs3,rs4,rs5,rs10,rs11;
	public String m_chksql,m_buyer_code,m_instype,m_instnum,m_end,m_b_code,m_value_date,m_maturity,last_yeild,last_yeild1;
	public String m_security_ser,m_maturity_ser,m_faceval_ser,m_cost_ser,m_yield_ser,today;
	public String  m_security_sec,m_maturity_sec,m_faceval_sec,m_cost_sec,m_yield_sec;
  public String  m_security_trn,m_maturity_trn,m_faceval_trn,m_cost_trn,m_yield_trn;

	public synchronized void service(HttpServletRequest req, HttpServletResponse
		res)
		throws IOException
	{
		
		try {
			
			//************************************************************	
				//************************************************************	
			ADLPMS_sn_methods m_sn_methods = new ADLPMS_sn_methods();
      conn = m_sn_methods.met_user_validate(req); 
			String m_schema_name = m_sn_methods.schema_name.trim();
			String m_html_client_url=m_sn_methods.html_client_url;
			//************************************************************
			
			
			
			nf = java.text.NumberFormat.getInstance(Locale.US);
			nf.setMinimumFractionDigits(2);
			
			nf1 = java.text.NumberFormat.getInstance(Locale.US);
			nf1.setMinimumFractionDigits(4);
			
			res.setStatus(HttpServletResponse.SC_OK);
			res.setContentType("text/html");
			ServletOutputStream out = res.getOutputStream();
			
			m_chksql = req.getParameter("chksql");
			stmt = conn.createStatement ();
			

			
			
			if (m_chksql.trim().equals("idle")) {
				out.println("idle");
			}
			else if (m_chksql.trim().equals("mrep_data")) {
							
						
		String		m_date = req.getParameter("mdate_from");
		String      m_portcode =req.getParameter("portcode");
				out.println("<head><TITLE>DealNet</TITLE></head><HTML><BODY leftmargin='0' topmargin='0'><FORM NAME='Form1' >");
				out.println("<TABLE BORDER='0' WIDTH='1100' BGCOLOR='silver' STYLE='{ font: bold 9pt arial;}'></TABLE>");
				out.println("<TABLE BORDER='0' WIDTH='1100' BGCOLOR='silver' STYLE='{ font: bold 9pt arial;}'><B></TABLE>");
				out.println("<TABLE BORDER='0' WIDTH='1100' BGCOLOR='silver' STYLE='{ font: bold 9pt arial;}'><B>");
				out.println("<TD WIDTH='1100' STYLE='{text-align:center;}'><B><FONT COLOR='black'><U>PORTFOLIO REVIEW AS OF "+m_date+"</U></TD></B></FONT></TABLE>");
				out.println("<TABLE WIDTH='1100' BORDER='0' CELLPADDING='0' CELLSPACING='2'></TABLE>");
				out.println("<TABLE WIDTH='1100' BORDER='0' CELLPADDING='0' CELLSPACING='2'><BR></TABLE>");
				out.println("<TABLE BORDER='1' WIDTH='1100' BGCOLOR='white' STYLE='{font: 9pt arial;}'><B>");			
				out.println("<TR BGCOLOR='silver' >");
				//out.println("<TD WIDTH='150' STYLE='{text-align:center;}'><B><FONT COLOR='black'>Portfolio Code</TD>");
				//out.println("<TD WIDTH='150' STYLE='{text-align:center;}'><B><FONT COLOR='black'>Instrument Type</TD>");
				out.println("<TD WIDTH='150' STYLE='{text-align:center;}'><B><FONT COLOR='black'>Symbol</TD>");	
			    out.println("<TD WIDTH='150' STYLE='{text-align:center;}'><B><FONT COLOR='black'>Short Description</TD>");	
				out.println("<TD WIDTH='100' STYLE='{text-align:center;}'><B><FONT COLOR='black'>Owned</TD>");			
				out.println("<TD WIDTH='100' STYLE='{text-align:center;}'><B><FONT COLOR='black'>Avg. Cost</TD>");
				out.println("<TD WIDTH='100' STYLE='{text-align:center;}'><B><FONT COLOR='black'>Mkt. Price</TD>");
				out.println("<TD WIDTH='100' STYLE='{text-align:center;}'><B><FONT COLOR='black'>Cost Basis</TD>");
				out.println("<TD WIDTH='100' STYLE='{text-align:center;}'><B><FONT COLOR='black'>Mkt. Value </TD>");
				out.println("<TD WIDTH='100' STYLE='{text-align:center;}'><B><FONT COLOR='black'>Unrealized G/L</TD>");
			    out.println("<TD WIDTH='100' STYLE='{text-align:center;}'><B><FONT COLOR='black'>% G/L</TD>");
			    out.println("<TD WIDTH='100' STYLE='{text-align:center;}'><B><FONT COLOR='black'>% Holding</TD>");
				//out.println("<TD WIDTH='100' STYLE='{text-align:center;}'><B><FONT COLOR='black'>Value Date</TD>");				
				//out.println("<TD WIDTH='100' STYLE='{text-align:center;}'><B><FONT COLOR='black'>Ent: Date</TD></TR></TABLE>");				
				out.println("<TABLE BORDER='1' WIDTH='1100' BGCOLOR='white' STYLE='{font: 9pt arial;}'><B>");
			
				double m_tot_cost = 0;
				rs = stmt.executeQuery ("  SELECT "+
									    "  SUM(COST)  FROM "+m_schema_name+".DN_TRN_MARKET_RATE_EQUITY "+
										"  WHERE PORTFOLIO_CODE='"+m_portcode+"' AND  TO_DATE(TO_CHAR(VALUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')>=TO_DATE('"+m_date+"','DD/MM/YYYY')   ");
                boolean more = rs.next(); 
				while (more) {
				m_tot_cost = rs.getDouble(1);
				more = rs.next();		
				}
				
				
				rs = stmt.executeQuery ("  SELECT PORTFOLIO_CODE,INST_TYPE,SECURITY_CODE,MARKET_RATE, "+
									    "  NO_SHARES, PRICE_SHARE, COST, NVL(GAINLOSS,0), TO_CHAR(VALUE_DATE,'DD-MON-YYYY'), TO_CHAR(ENTDATE,'DD-MON-YYYY'),"+m_schema_name+".DN_GET_ISSUER_NAME(B.ISSUER_CODE)  FROM "+m_schema_name+".DN_TRN_MARKET_RATE_EQUITY A,"+m_schema_name+".DN_REF_SECURITY B "+
										"  WHERE A.SECURITY_CODE = B.SECURITY_CODE AND PORTFOLIO_CODE='"+m_portcode+"' AND  TO_DATE(TO_CHAR(VALUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')>=TO_DATE('"+m_date+"','DD/MM/YYYY')   ");

				more = rs.next(); 
				while (more) {
					
				
					out.println("<TR BGCOLOR='white'>");
					//out.println("<TD WIDTH='150' STYLE='{cursor: hand; font: 9pt arial; text-align:center;}'  >"+rs.getString(1)+"</TD>");
					//out.println("<TD WIDTH='150' STYLE='{cursor: hand; font: 9pt arial; text-align:center;}'  >"+rs.getString(2)+"</TD>");
					out.println("<TD WIDTH='150' STYLE='{cursor: hand; font: 9pt arial; text-align:center;}'  >"+rs.getString(3)+"</TD>");
					out.println("<TD WIDTH='150' STYLE='{cursor: hand; font: 9pt arial; text-align:left;}'  >"+rs.getString(11)+"</TD>");
					out.println("<TD WIDTH='100' STYLE='{cursor: hand; font: 9pt arial; text-align:right;}'   >"+rs.getInt(5)+"</TD>");
					out.println("<TD WIDTH='100' STYLE='{cursor: hand; font: 9pt arial; text-align:right;}'   >"+nf.format(rs.getDouble(7)/rs.getInt(5))+"</TD>");
					out.println("<TD WIDTH='100' STYLE='{cursor: hand; font: 9pt arial; text-align:right;}'  >"+nf.format(rs.getDouble(4))+"</TD>");
					out.println("<TD WIDTH='100' STYLE='{cursor: hand; font: 9pt arial; text-align:right;}'   >"+nf.format(rs.getDouble(7))+"</TD>");
					out.println("<TD WIDTH='100' STYLE='{cursor: hand; font: 9pt arial; text-align:right;}'  >"+nf.format(rs.getDouble(4)*rs.getDouble(5))+"</TD>");
					out.println("<TD WIDTH='100' STYLE='{cursor: hand; font: 9pt arial; text-align:right;}'   >"+nf.format(rs.getDouble(8))+"</TD>");
				    out.println("<TD WIDTH='100' STYLE='{cursor: hand; font: 9pt arial; text-align:right;}'   >"+nf.format(rs.getDouble(8)/rs.getDouble(7)*100)+"</TD>");
				    out.println("<TD WIDTH='100' STYLE='{cursor: hand; font: 9pt arial; text-align:right;}'   >"+nf.format(rs.getDouble(7)/m_tot_cost*100)+"</TD>");
					//out.println("<TD WIDTH='100' STYLE='{cursor: hand; font: 9pt arial; text-align:center;}'   >"+rs.getString(9)+"</TD>");					
					//out.println("<TD WIDTH='100' STYLE='{cursor: hand; font: 9pt arial; text-align:center;}'   >"+rs.getString(10)+"</TD></TR>");					
					more = rs.next();	
				}
				
	 


			}
			
			else {
				out.println("Undefined123");
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

