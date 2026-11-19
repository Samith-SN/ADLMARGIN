import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import sun.misc.BASE64Decoder; 
////import ADLPMS_sn_methods;
import java.util.*;

import oracle.jdbc.driver.*;

public class ADLPMS_foffice_pf_performance_rpt_equity extends javax.servlet.http.HttpServlet {
	
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
			nf.setMaximumFractionDigits(2);
			
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
							
						
		String		m_from_date = req.getParameter("mdate_from");
		String		m_to_date = req.getParameter("mdate_to");
		String      m_portcode =req.getParameter("portcode");
				out.println("<head><TITLE>DealNet</TITLE></head><HTML><BODY leftmargin='0' topmargin='0'><FORM NAME='Form1' >");
				out.println("<TABLE BORDER='0' WIDTH='850' BGCOLOR='silver' STYLE='{ font: bold 9pt arial;}'></TABLE>");
				out.println("<TABLE BORDER='0' WIDTH='850' BGCOLOR='silver' STYLE='{ font: bold 9pt arial;}'><B></TABLE>");
				out.println("<TABLE BORDER='0' WIDTH='850' BGCOLOR='silver' STYLE='{ font: bold 9pt arial;}'><B>");
				out.println("<TD WIDTH='850' STYLE='{text-align:center;}'><B><FONT COLOR='black'><U>PORTFOLIO REVIEW FROM "+m_from_date+"</U></TD></B></FONT></TABLE>");
				out.println("<TABLE WIDTH='850' BORDER='0' CELLPADDING='0' CELLSPACING='2'></TABLE>");
				out.println("<TABLE WIDTH='850' BORDER='0' CELLPADDING='0' CELLSPACING='2'><BR></TABLE>");
		        out.println("<FONT STYLE='{font: bold 9pt arial}'  ></FONT>");    
				out.println("<TABLE BORDER='1' WIDTH='850' BGCOLOR='white' STYLE='{font: 9pt arial;}'><B>");			
				out.println("<TR BGCOLOR='silver' >");
				out.println("<TD WIDTH='150' STYLE='{text-align:center;}'><B><FONT COLOR='black'>Portfolio Code</TD>");
				out.println("<TD WIDTH='100' STYLE='{text-align:center;}'><B><FONT COLOR='black'>AUM - Opening Bal</TD>");
				out.println("<TD WIDTH='100' STYLE='{text-align:center;}'><B><FONT COLOR='black'>AUM - Closing Bal</TD>");	
			    out.println("<TD WIDTH='100' STYLE='{text-align:center;}'><B><FONT COLOR='black'>Unutilised Cash Bal</TD>");	
				out.println("<TD WIDTH='100' STYLE='{text-align:center;}'><B><FONT COLOR='black'>% Gain / Loss(Direct)</TD>");
			    out.println("<TD WIDTH='100' STYLE='{text-align:center;}'><B><FONT COLOR='black'>% Gain / Loss (p.a) </TD>");
			    out.println("<TD WIDTH='100' STYLE='{text-align:center;}'><B><FONT COLOR='black'>Management Fee</TD>");
				out.println("<TD WIDTH='100' STYLE='{text-align:center;}'><B><FONT COLOR='black'>Incentive Fee</TD>");				
								
				out.println("<TABLE BORDER='1' WIDTH='850' BGCOLOR='white' STYLE='{font: 9pt arial;}'><B>");
			
				double m_tot_gain = 0;
				double m_date_diff = 0;
				rs = stmt.executeQuery ("  SELECT "+
									    "  SUM(NVL(A.GAINLOSS,0)), TO_DATE('"+m_to_date+"','DD/MM/YYYY')-TO_DATE('"+m_from_date+"','DD/MM/YYYY') DATE_DIFF FROM "+m_schema_name+".DN_TRN_MARKET_RATE_EQUITY A"+
										"  WHERE A.PORTFOLIO_CODE LIKE'"+m_portcode+"%' AND TO_DATE(TO_CHAR(VALUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')>=TO_DATE('"+m_from_date+"','DD/MM/YYYY') AND  TO_DATE(TO_CHAR(VALUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')<=TO_DATE('"+m_to_date+"','DD/MM/YYYY')   ");
                boolean more = rs.next(); 
				while (more) {
				m_tot_gain = rs.getDouble(1);
				m_date_diff = rs.getDouble(2);
				more = rs.next();		
				}
				
				
				String sql_2           = ("  SELECT A.PORTFOLIO_CODE,SUM(NVL(A.GAINLOSS,0)),"+m_schema_name+".DN_GET_PORTFOLIO_BANK_BALANCE(A.PORTFOLIO_CODE,'"+m_from_date+"')"+
					                      "  "+//"+m_schema_name+".DN_GET_PORTFOLIO_BANK_BALANCE('"+m_portcode+"','"+m_from_from_date+"')
									      "  FROM "+m_schema_name+".DN_TRN_MARKET_RATE_EQUITY A "+
										  "  WHERE A.PORTFOLIO_CODE LIKE'"+m_portcode+"%' AND  TO_DATE(TO_CHAR(A.VALUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')>=TO_DATE('"+m_from_date+"','DD/MM/YYYY') AND  TO_DATE(TO_CHAR(A.VALUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')<=TO_DATE('"+m_to_date+"','DD/MM/YYYY') GROUP BY A.PORTFOLIO_CODE,"+m_schema_name+".DN_GET_PORTFOLIO_BANK_BALANCE(A.PORTFOLIO_CODE,'"+m_from_date+"')  ORDER BY  PORTFOLIO_CODE ");

				//out.println(sql_2);
				rs = stmt.executeQuery (sql_2);
				more = rs.next(); 
				double m_tot_cash_bal= 0 ;
				double m_tot_mkt_value = 0 ;
				double m_tot_unreal_gl = 0 ;
				boolean flag_1 = false;
				while (more) {
					flag_1 = true;
				 m_tot_cash_bal += rs.getDouble(3);
				 //m_tot_mkt_value  += rs.getDouble(4)*rs.getDouble(5);
				 //m_tot_unreal_gl  += rs.getDouble(8);
					
					out.println("<TR BGCOLOR='white'>");
					out.println("<TD WIDTH='150' STYLE='{cursor: hand; font: 9pt arial; text-align:center;}'  >"+rs.getString(1)+"</TD>");
					out.println("<TD WIDTH='100' STYLE='{cursor: hand; font: 9pt arial; text-align:right;}'  >0</TD>");
					out.println("<TD WIDTH='100' STYLE='{cursor: hand; font: 9pt arial; text-align:right;}'  >0</TD>");
					out.println("<TD WIDTH='100' STYLE='{cursor: hand; font: 9pt arial; text-align:right;}'  >"+nf.format(rs.getDouble(3))+"</TD>");//Unutilised Cash Bal
					out.println("<TD WIDTH='100' STYLE='{cursor: hand; font: 9pt arial; text-align:right;}'  >"+nf.format(rs.getDouble(2)/m_tot_gain*100)+"</TD>");
					out.println("<TD WIDTH='100' STYLE='{cursor: hand; font: 9pt arial; text-align:right;}'   >"+nf.format(rs.getDouble(2)/m_tot_gain*100/m_date_diff*365)+"</TD>");
					out.println("<TD WIDTH='100' STYLE='{cursor: hand; font: 9pt arial; text-align:right;}'  >"+nf.format(rs.getDouble(3))+"</TD>");
					out.println("<TD WIDTH='100' STYLE='{cursor: hand; font: 9pt arial; text-align:right;}'   >"+nf.format(rs.getDouble(3))+"</TD>");
					
					out.println("</TR>");
					more = rs.next();	
				}
				
				    if(flag_1==true){
				    out.println("<TR BGCOLOR='white'>");
				    out.println("<TD  STYLE='{cursor: hand; font: 9pt arial; text-align:center;}' ></TD>");
					out.println("<TD  STYLE='{cursor: hand; font: 9pt arial; text-align:left;}'  ></TD>");
					out.println("<TD  STYLE='{cursor: hand; font: 9pt arial; text-align:right;}'  ></TD>");
					out.println("<TD  STYLE='{cursor: hand; font: 9pt arial; text-align:right;}'  ></TD>");
					out.println("<TD  STYLE='{cursor: hand; font: 9pt arial; text-align:right;}'  ></TD>");
					out.println("<TD  STYLE='{cursor: hand; font: 9pt arial; text-align:right;}'   ><B>"+nf.format(0)+"</TD>");
					out.println("<TD  STYLE='{cursor: hand; font: 9pt arial; text-align:right;}'  ><B>"+nf.format(0)+"</TD>");
					out.println("<TD  STYLE='{cursor: hand; font: 9pt arial; text-align:right;}'   ><B>"+nf.format(0)+"</TD>");
					out.println("</TR>");				
				   }
	          out.println("</TABLE>");
              
			 
	
	
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

