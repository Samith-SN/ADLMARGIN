import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;import net.sasianet.ADLMARGIN.*;
import java.sql.*;
import sun.misc.BASE64Decoder; 
//import ADLMARGIN_sn_methods;
import java.util.*;

import oracle.jdbc.driver.*;

public class ADLMARGIN_sec_mgt_loan_details extends javax.servlet.http.HttpServlet {
	
	Connection conn;
	Statement stmt;
	CallableStatement callstmt1; 
	
	java.text.NumberFormat nf;
	public String check_sql,m_username;
	public ResultSet rs,rs1,rs2,rs3;
	public String m_chksql,m_buyer_code,m_instype,m_instnum,m_end,m_b_code,m_value_date,m_maturity,m_firsttwo,m_p_dealno;
	public String[] ARRAY_SET1 = new String[10];
	public synchronized void service(HttpServletRequest req, HttpServletResponse
		res)
		throws IOException
	{
		
		try {
			
			//************************************************************	
			//
			//conn = m_sn_methods.met_user_validate(req); 
			
			HttpSession session = req.getSession(true);
			ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
			conn = m_sn_methods.met_user_validate(session); 
			
			m_username=m_sn_methods.username;
			String m_schema_name=m_sn_methods.schema_name.trim();
			String m_html_client_url=m_sn_methods.html_client_url;
			String m_jsp_client_url=m_sn_methods.jsp_client_url;
			//************************************************************
			
			
			
			nf = java.text.NumberFormat.getInstance(Locale.US);
			nf.setMinimumFractionDigits(2);
			
			
			res.setStatus(HttpServletResponse.SC_OK);
			res.setContentType("text/html");
			ServletOutputStream out = res.getOutputStream();
			
			m_chksql = req.getParameter("chksql");
			//out.println(m_chksql);
			stmt = conn.createStatement ();
			if (m_chksql.trim().equals("idle")) {
				out.println("idle");
			}
			
			
			 if (m_chksql.trim().equals("display_report")) {
				
				
				
				String m_mdate_from = req.getParameter("mdate_from");
				String m_mdate_to = req.getParameter("mdate_to");
				String m_facility_no = req.getParameter("facility_no");
				String sql = "";
				out.println("<HTML><head><TITLE>DETAILS ON CUSTOMERS'S MARGIN ACCOUNT TOP 10</TITLE>");
				out.println("<STYLE STYLE=\"TEXT/CSS\" >");
				out.println("#BaseTable ");
				out.println("{ ");
				out.println("border-collapse:collapse; ");
				out.println("} ");
				
				out.println("#BaseTable td");
				out.println("{ ");
				out.println("   border:1px solid #2E6E9E; ");
				out.println("text-align:left; ");
				out.println("height:25px; ");
				out.println("} ");
				
				out.println("#BaseTable2 td");
				out.println("{ ");
				out.println("   border:1px solid #2E6E9E; ");
				out.println("   font: bold 9pt arial;  ");
				//out.println(" 	color:#2E6E9E; ");
				out.println("	text-align:left; ");
				out.println("} ");
				
				out.println("#BaseTable th");
				out.println("{ ");
				out.println(" border:1px solid #2E6E9E; ");
				out.println(" padding-bottom:7.4px; ");
				out.println(" background-color:#dfeffc; ");
				out.println("   font: bold 9pt arial;  ");
				out.println("} ");
				out.println(" #specialtr td,tr");
				out.println("{ ");
				out.println("  border-style:none; ");
				//out.println("  border-width:0px; ");
				out.println("} ");
				out.println("</STYLE>");
				out.println("</head><BODY leftmargin='0' topmargin='0'><FORM NAME='Form1'><TABLE BORDER='0' WIDTH='1150' BGCOLOR='silver' STYLE='{ font: bold 9pt arial;}'></TABLE>");
				out.println("<TABLE BORDER='0' WIDTH='1150' BGCOLOR='silver' STYLE='{ font: bold 9pt arial;}'><B></TABLE>");
				//NIRMALA
				
								
							
				 out.println("<TABLE BORDER='0' WIDTH='1000' BGCOLOR='white' STYLE='{ font: 10pt arial;}'>");
				out.println("<TR><TD align='left' STYLE='{text-align:left; font: 9pt arial;}'><FONT COLOR='black'></TD></FONT></TR> ");
				out.println("<TR><TD align='center' STYLE='{text-align:center;}'><B><FONT COLOR='black'>Adl Equities Ltd.</TD></TR></B></FONT>"); // Adl Capital Ltd  change as Adl Equities Ltd  by Prabash on15-05-2012
				out.println("<TR><TD align='center' STYLE='{text-align:center;}'><FONT COLOR='black'> No.82-2/1, Bauddaloka Mawatha,Colombo 04.</TD></TR>");
				out.println("<TR><TD align='center' STYLE='{text-align:center;}'><FONT COLOR='black'>Tel:+94 11 7394270 Fax:+94 11 7394276 E Mail: adlmargin@adlcapital.com Web: www.adlcapital.com</TD></TR>");
				out.println("<TR><TD align='center'  STYLE='{text-align:center;}'><FONT COLOR='black'>"+m_mdate_to+"</TD></FONT></TR>");
				out.println("<TR><TD align='center'  STYLE='{text-align:center;}'><B><FONT COLOR='black'>DETAILS ON CUSTOMERS'S MARGIN ACCOUNT TOP 10</TD></B></FONT></TR></TABLE>");
				
				out.println("<BR>");
				
							
				 
				
		
					sql= ("  "+
					" SELECT ROWNUM ROW_NUM ,CDS_ACC_NO,PF_NAME,REPO_LEG2,CASH_BALANCE,SEC_VAL,OTHER FROM ( "+
					" SELECT B.CDS_ACC_NO,B.PF_NAME,A.REPO_LEG2,"+m_schema_name+".DN_CASH_BALANCE(A.PORTFOLIO_CODE,TO_CHAR(A.TRN_DATE ,'DD/MM/YYYY')) CASH_BALANCE, "+
					" SUM(FACE_VAL*NVL(MARKET_RATE,0)) SEC_VAL,SUM(0) OTHER "+
					" FROM "+m_schema_name+".DN_REP_MARGIN_CALL A,"+m_schema_name+".DN_REF_PORTFOLIO B "+
					" WHERE A.PORTFOLIO_CODE =B.PORTFOLIO_CODE "+
					" AND REPO_LEG2 IS NOT NULL "+
					" AND A.TRN_DATE =TO_DATE('"+m_mdate_to+"','DD/MM/YYYY') AND ROWNUM<11 "+
					" GROUP BY B.CDS_ACC_NO,B.PF_NAME,A.REPO_LEG2,"+m_schema_name+".DN_UNUTILIZED_CASH(A.PORTFOLIO_CODE,TO_CHAR(A.TRN_DATE ,'DD/MM/YYYY')) "+
					" ORDER BY REPO_LEG2 DESC "+
					" )   "+
					"");
				
		       out.println(sql);
				rs = stmt.executeQuery (sql);
				
				
				out.println("<TABLE BORDER='0' id='BaseTable' WIDTH='1150'  STYLE='{font: 9pt arial;}'>");						
				
				out.println("<TR >");
				out.println("<TH WIDTH='50' STYLE='{text-align:center;}' rowspan='2'><B><FONT COLOR='black'  >No.</TH>");
				out.println("<TH WIDTH='100' STYLE='{text-align:center;}' rowspan='2'><B><FONT COLOR='black' >Custormer Identification No</TH>");
				out.println("<TH WIDTH='200' STYLE='{text-align:center;}' rowspan='2'><B><FONT COLOR='black' >Custormer Name</TH>");
				out.println("<TH WIDTH='150' STYLE='{text-align:center;}' rowspan='2'><B><FONT COLOR='black'  >Margin Loan Amount (Rs)</TH>");
				out.println("<TH WIDTH='150' STYLE='{text-align:center;}' colspan='4' ><B><FONT COLOR='black' >Collateral (Rs)</TH>");
				out.println("</TR >");
				
				out.println("<TR >");
									
				
				out.println("<TH WIDTH='150' STYLE='{text-align:center;}'><B><FONT COLOR='black' >Cash Balance</TH>");
				out.println("<TH WIDTH='150' STYLE='{text-align:center;}'><B><FONT COLOR='black' >Securities</TH>");
				out.println("<TH WIDTH='100' STYLE='{text-align:center;}' ><B><FONT COLOR='black'>Other</TH>");
				out.println("<TH WIDTH='150' STYLE='{text-align:center;}' ><B><FONT COLOR='black'>Total</TH>");
				out.println("</TR >");
				
				
				boolean  more = rs.next();
			
				while (more) {
					
					
					out.println("<TR >");
					out.println("<TD   STYLE='{font: 9pt arial; text-align:LEFT;}'>"+rs.getString(1)+"</TD>");//name
					out.println("<TD   STYLE='{font: 9pt arial; text-align:LEFT;}'>"+rs.getString(2)+"</TD>");//BORR_PORTFOLIO_CODE
					out.println("<TD   STYLE='{font: 9pt arial; text-align:LEFT;}'>"+rs.getString(3)+"</TD>");
					
					out.println("<TD  STYLE='{font: 9pt arial; text-align:right;}'>"+nf.format(rs.getDouble(4))+"</TD>");
					out.println("<TD  STYLE='{font: 9pt arial; text-align:right;}'>"+nf.format(rs.getDouble(5))+"</TD>");
										
					out.println("<TD  STYLE='{font: 9pt arial; text-align:right;}'>"+nf.format(rs.getDouble(6))+"</TD>");
					out.println("<TD  STYLE='{font: 9pt arial; text-align:right;}'>"+nf.format(rs.getDouble(7))+"</TD>");
					out.println("<TD  STYLE='{font: 9pt arial; text-align:right;}'>"+nf.format(rs.getDouble(5)+rs.getDouble(6)+rs.getDouble(7))+"</TD>");
					
					out.println("</TR>");
					more = rs.next();	
				}
				out.println("</TABLE>");
				out.println("<BR>");
				out.println("<BR>");
				//add by waruna 2011-01-10
				ResultSet rs_rpt_date = stmt.executeQuery ("SELECT TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS') FROM DUAL");
				String rpt_run_date="";
				boolean more_rpt_date=rs_rpt_date.next();
				if(more_rpt_date){
					rpt_run_date=rs_rpt_date.getString(1);
				}
				out.println("<TABLE BORDER='0' WIDTH='100' BGCOLOR='white' STYLE='{ font: bold 9pt arial;}'>");
				out.println("<TR><TD>SEC- 001 </TD></TR>");
				out.println("<TR><TD>"+m_username+"</TD></TR>");
				out.println("<TR><TD>"+rpt_run_date+" </TD></TR>");
				out.println("</TABLE>");
				
				out.println("<SCRIPT language1.2='JavaScript' src='"+m_jsp_client_url+"/foffice_report_new.js'></SCRIPT>");
				
				out.println("</TABLE>");
				
				
				
				
				//javascript file(float_1.js) takes the DIV tags found in this HTML and
				//does the appropriate positionning & moving.
				out.println("<SCRIPT language1.2='JavaScript' src='"+m_jsp_client_url+"/float_1.js'></SCRIPT>");
				out.println("</BODY></HTML>");
				
				
			}								
			//=========================================================================================================================			
			else {
				out.println("Undefined"+m_chksql); 
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
