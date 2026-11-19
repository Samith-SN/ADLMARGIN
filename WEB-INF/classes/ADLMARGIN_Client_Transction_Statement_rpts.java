
//==========================================================================================================================================			
//----------------Done by Manjula on 06-09-2004 For Sales Ledger Report & Purchase Ledger Reports ( BO--> Reports )--- SRF 0409-012---------
//==========================================================================================================================================

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;import net.sasianet.ADLMARGIN.*;
import java.sql.*;
import sun.misc.BASE64Decoder; 

//import ADLMARGIN_sn_methods;
import java.util.*;

import oracle.jdbc.driver.*;

public class ADLMARGIN_Client_Transction_Statement_rpts extends javax.servlet.http.HttpServlet {
	
	Connection conn;
	Statement stmt;
	CallableStatement callstmt1;
	//
	java.text.NumberFormat nf,nf4;
	public String check_sql,m_username;
	public ResultSet rs,rs1,rs2,rs3,rs4,rs5;
	public String m_chksql,m_value_date,m_sys_date,m_seller,m_buyer;
	public double m_cr_total,m_dr_total,m_balance_total;
	PrintWriter log=null;
	public synchronized void service(HttpServletRequest req, HttpServletResponse
		res)
		throws IOException
	{
		
		try {
			
			//************************************************************	
			
			HttpSession session = req.getSession(true);//ADLMARGIN_MGT_conn_methods
			ADLMARGIN_MGT_conn_methods m_sn_methods = new ADLMARGIN_MGT_conn_methods(session);
			//	conn = m_sn_methods.met_user_validate(session);
			String m_jsp_client_url   =  m_sn_methods.jsp_client_url;
			
			
			
			Object done = (String)session.getValue("logon.isDone");  // marker object
			ServletOutputStream out = res.getOutputStream();
			if (done == null) {
				out.println("<html><head>");
				out.println("<script language='JavaScript'>");
				out.println("function displaymsg() {");
				out.println("alert('Your login expired or invalid login');");
				out.println("window.location.href='"+m_jsp_client_url+"/login.jsp' ;");
				out.println("}</script></head>");
				out.println("<body onload='displaymsg();'></body>");
				out.println("</html>");
				out.flush();
				return;
			}
			
			
			
			conn = m_sn_methods.met_user_validate(session);
			String m_schema_name=m_sn_methods.schema_name.trim();
			m_username=m_sn_methods.username;
			
			
			
			String m_servlet_client_url=m_sn_methods.servlet_client_url;  //"https://dev-adlmargin.sasianet.com";
			String m_client_t3_port=m_sn_methods.client_t3_port;
			String m_client_name=m_sn_methods.client_name;
			//************************************************************
			
			
			
			nf = java.text.NumberFormat.getInstance(Locale.US);
			nf.setMinimumFractionDigits(2);
			
			nf4 = java.text.NumberFormat.getInstance(Locale.US);
			nf4.setMinimumFractionDigits(4);
			
			res.setStatus(HttpServletResponse.SC_OK);
			res.setContentType("text/html");
			//ServletOutputStream out = res.getOutputStream();
			
			//=========================================================================================================================			
			
			m_chksql = req.getParameter("chksql");
			stmt = conn.createStatement ();
			
			if (m_chksql.trim().equals("idle")) {
				out.println("idle");
			}
			
			else if(m_chksql.trim().equals("chk_portMIS")){
				res.setContentType("text/xml");
				String m_pcode = req.getParameter("port");
				
				rs = stmt.executeQuery 
					(" SELECT PORTFOLIO_CODE "+
					" FROM   "+m_schema_name+".DN_REF_PORTFOLIO "+
					// " WHERE  PORTFOLIO_CODE=UPPER('"+m_pcode+"') AND  PF_TYPE='P' AND ACTIVE_STATUS='Y' "); // commented by udara 27-05-2011
					" WHERE  PORTFOLIO_CODE=UPPER('"+m_pcode+"') AND  PF_TYPE='P' AND ACTIVE_STATUS IN ('Y','C','T','M') "); // added by udara 27-05-2011 // 'M' IS ADDED BY MADHAWA
				
				boolean more = rs.next(); 
				out.println("<DATA>");
				while (more) 
				{ 
					out.println("<ITEM>");
					out.println("<R1>"+rs.getString(1)+"</R1>");
					out.println("</ITEM>");
					more = rs.next();
					
				}
				out.println("</DATA>");
			}
			else if(m_chksql.trim().equals("chk_port")){
				//res.setContentType("text/xml");
				String m_pcode = req.getParameter("port");
				
				rs = stmt.executeQuery 
					(" SELECT PORTFOLIO_CODE "+
					" FROM   "+m_schema_name+".DN_REF_PORTFOLIO "+
					// " WHERE  PORTFOLIO_CODE=UPPER('"+m_pcode+"') AND  PF_TYPE='P' AND ACTIVE_STATUS='Y' "); // commented by udara 27-05-2011
					" WHERE  PORTFOLIO_CODE=UPPER('"+m_pcode+"') AND  PF_TYPE='P' AND ACTIVE_STATUS IN ('Y','C','T') "); // added by udara 27-05-2011 // 'M' IS ADDED BY MADHAWA
				
				boolean more = rs.next(); 
				//out.println("<DATA>");
				while (more) 
				{ 
					//out.println("<ITEM>");
					//out.println("<R1>"+rs.getString(1)+"</R1>");
					//out.println("</ITEM>");
					out.println(rs.getString(1));
					more = rs.next();
					
					
				}
				//out.println("</DATA>");
			}
			
			else if (m_chksql.trim().equals("portfolio_help")) {
				String m_ins_code= new String();
				m_ins_code = req.getParameter("portfolio_code");
				
				rs = stmt.executeQuery("SELECT PORTFOLIO_CODE,PF_NAME,CDS_ACC_NO   "+
					//"FROM  "+m_schema_name+".DN_REF_PORTFOLIO,"+
					"FROM  "+m_schema_name+".DN_REF_PORTFOLIO "+//add by waruna 
					"WHERE (PORTFOLIO_CODE LIKE UPPER('%"+m_ins_code+"%') OR  CDS_ACC_NO LIKE UPPER('%"+m_ins_code+"%') OR "+ //mod by waruna added By Keith on 14-10-2004/9:5 % and Upper() for like command
					"UPPER(PF_NAME) LIKE UPPER('%"+m_ins_code+"%')) AND  "+
					// "ACTIVE_STATUS='Y' AND  PF_TYPE='P'  "+ // commented by udara on 27-05-2011
					"ACTIVE_STATUS IN ('Y','C','T') AND  PF_TYPE='P'  "+ // added by udara on 27-05-2011
					"AND BRANCH LIKE ("+m_schema_name+".DN_GET_USER_LOCATION('"+m_username+"')) "+
					"UNION  "+	
					"SELECT PORTFOLIO_CODE , PF_NAME,CDS_ACC_NO " +//mod by waruna 
					"FROM  "+m_schema_name+".DN_REF_PORTFOLIO " +
					"WHERE PORTFOLIO_CODE='ADLMT' "+
					"GROUP BY  PF_NAME, PORTFOLIO_CODE,CDS_ACC_NO ");
				
				boolean more = rs.next();
				while (more) 
				{
					out.println(rs.getString(1));
					out.println(rs.getString(2));
					out.println(rs.getString(3));
					more = rs.next();
				}
			}
			
			//---------------------------------------------- STATEMENT OF RECEIVABLES FROM AND PAYABLES TO BROKERS  ---------------------------------------------------		
			
			else if (m_chksql.trim().equals("display_report")) {
				
				m_cr_total=0.00;
				m_dr_total=0.00;
				m_balance_total=0.00;
				
				String m_mdate_from = req.getParameter("mdate_from");
				String m_mdate_to = req.getParameter("mdate_to");
				String client_code=req.getParameter("client");
				
				String m_emailadd_string="";
				String eol = System.getProperty("line.separator");
				
				rs = stmt.executeQuery("SELECT A.EMAIL  FROM "+m_schema_name+".DN_REF_PORTF_CONT_EMAIL A WHERE PORTFOLIO_CODE='"+client_code+"'");
				boolean moreemail=rs.next();
				while(moreemail){
					
					if(m_emailadd_string!=""){
						m_emailadd_string=m_emailadd_string+",";
					}	
					m_emailadd_string=m_emailadd_string+rs.getString(1);	
					
					
					moreemail=rs.next();
				}
				
				
				
				String m_MsgBody="";
				String m_MsgBody_text="";
				String m_SendMsgBody="";
				
				m_MsgBody =("<head><TITLE> CLIENT STATEMENT   </TITLE></head><HTML><BODY leftmargin='0' topmargin='0'>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				
				
				
				
				m_MsgBody=("<SCRIPT language='JavaScript1.2'>");
				//m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody=("function emailsend(){");
				//m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody=("Form1.method='POST'");											
				//m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody=("Form1.action='"+m_servlet_client_url+":"+m_client_t3_port+"/"+m_client_name+"Send_Client_Email_Servlet_Tran';");
				///m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody=("Form1.submit();");
				//m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				
				
				m_MsgBody=("}");
				//m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody=("</SCRIPT>");
				//m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				
				
				
				String m_run_date_from="";
				String m_run_date_to="";
				rs = stmt.executeQuery (" SELECT TO_CHAR(TO_DATE('"+m_mdate_from+"','DD-MM-YYYY'),'DD-MON-YYYY'),TO_CHAR(TO_DATE('"+m_mdate_to+"','DD-MM-YYYY'),'DD-MON-YYYY')  FROM DUAL");
				if(rs.next()){
					m_run_date_from  = rs.getString(1);
					m_run_date_to  = rs.getString(2);
				}
				
				
				
				m_MsgBody =("<FORM NAME='Form1'><TABLE BORDER='0' WIDTH='1700' BGCOLOR='silver' STYLE='{ font: bold 9pt arial;}'></TABLE>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				
				
				out.println("<TABLE BORDER='0' WIDTH='100%' BGCOLOR='#dfeffc' STYLE='{font: 10pt arial;text-align:left;}'>");
				out.println("<TR ><TD width='20%' rowspan='2'><INPUT TYPE='BUTTON' NAME='but_call' value='Send Email' STYLE='{cursor:hand; color: #FFFFFF; font: bold 10pt arial;height:60;border-style: outset;background-color:  #2E6E9E; }' ONCLICK='emailsend()'></TD><TD width='10%' >To:</TD><TD width='70%' ><INPUT TYPE='Text' NAME='TXT_TO' Value='"+m_emailadd_string+"' SIZE=70 MAXLENGTH=300></TD></TR>");
				out.println("<TD width='10%' >Subject:</TD><TD width='70%' ><INPUT TYPE='Text' NAME='TXT_SUBJECT' VALUE='CLIENT STATEMENT FROM "+m_run_date_from+" TO "+m_run_date_to+"' SIZE=70 MAXLENGTH=50></TD></TR>");
				out.println("</TABLE>");
				
				
				
				rs2=stmt.executeQuery ("SELECT TO_CHAR(sysdate,'dd/mm/yyyy'),'01'||Substr(to_CHAR(to_date('"+m_mdate_to+"','DD/MM/YYYY'),'DD/MM/YYYY'),3,10) from dual");
				
				//m_MsgBody =("<DIV STYLE='{position:absolute; top:40; left:0 cursor: hand;}'>");
				m_MsgBody =("<BR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<BR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				boolean more2 = rs2.next();
				m_sys_date=rs2.getString(1);
				//m_mdate_from=rs2.getString(2);
				rs1 = stmt.executeQuery (
					"SELECT PORTFOLIO_CODE,PF_NAME,CDS_ACC_NO,NVL(ACC_NO,'-') "+
					"FROM  "+m_schema_name+".DN_REF_PORTFOLIO "+//add by waruna 
					"WHERE PORTFOLIO_CODE = UPPER('"+client_code+"') "+ //mod by waruna added By Keith on 14-10-2004/9:5 % and Upper() for like command
					" " );
				
				
				
				
				m_MsgBody =("<TABLE BORDER='0' WIDTH='1000' BGCOLOR='white' STYLE='{ font: 10pt arial;}'>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody_text=m_MsgBody_text+paddingString(m_sys_date, 25,' ', false)+eol;
				
				m_MsgBody =("<TR><TD align='left' STYLE='{text-align:left; font: 9pt arial;}'><FONT COLOR='black'>Date : "+m_sys_date+"</TD></FONT></TR> ");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody_text=m_MsgBody_text+paddingString(" ", 50,' ', false)+paddingString("Adl Capital Ltd.",100,' ', false)+" "+eol;
				m_MsgBody =("<TR><TD align='center' STYLE='{text-align:center;}'><B><FONT COLOR='black'>Adl Capital Ltd.</TD></TR></B></FONT>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody_text=m_MsgBody_text+paddingString(" ", 30,' ', false)+paddingString(" No.82-2/1, Bauddaloka Mawatha,Colombo 04.",100,' ', false)+" "+eol;
				m_MsgBody =("<TR><TD align='center' STYLE='{text-align:center;}'><FONT COLOR='black'> No.82-2/1, Bauddaloka Mawatha,Colombo 04.</TD></TR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody_text=m_MsgBody_text+paddingString(" ", 15,' ', false)+paddingString(" Tel:+94 11 7394270 Fax:+94 11 7394276 E Mail: adlmargin@adlcapital.com Web: www.adlcapital.com",100,' ', false)+" "+eol;
				m_MsgBody =("<TR><TD align='center' STYLE='{text-align:center;}'><FONT COLOR='black'>Tel:+94 11 7394270 Fax:+94 11 7394276 E Mail: adlmargin@adlcapital.com Web: www.adlcapital.com</TD></TR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody_text=m_MsgBody_text+paddingString(" ", 40,' ', false)+paddingString("          MARGIN TRADING",100,' ', false)+" "+eol;
				m_MsgBody =("<TR><TD align='center' STYLE='{text-align:center;}'><FONT COLOR='black'>MARGIN TRADING</TD></TR></FONT>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody_text=m_MsgBody_text+paddingString(" ", 32,' ', false)+paddingString("CLIENT STATEMENT FROM "+m_mdate_from+" TO "+m_mdate_to,100,' ', false)+" "+eol+eol+eol+eol;
				m_MsgBody =("<TR><TD align='center'  STYLE='{text-align:center;}'><B><FONT COLOR='black'> CLIENT STATEMENT FROM "+m_mdate_from+" TO "+m_mdate_to+"</TD></B></FONT></TR></TABLE>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<BR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				boolean more1 = rs1.next();
				while (more1) {
					m_MsgBody =("<TABLE BORDER='0' WIDTH='1000' BGCOLOR='white' STYLE='{font: 9pt arial;}'><B>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody =("<TR BGCOLOR='white' >");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody_text=m_MsgBody_text+paddingString("Margin Trading Account No:", 28,' ', false)+paddingString(rs1.getString(1),50,' ', false)+" "+eol;
					m_MsgBody =("<TD WIDTH='100' STYLE='{text-align:left;}'><FONT COLOR='black'>Margin Trading Account No </TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody =("<TD WIDTH='150' align='left'  STYLE='{text-align:left;}'><FONT COLOR='black'>: "+rs1.getString(1)+"</TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:center;}'><FONT COLOR='black' ></TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:center;}'><FONT COLOR='black'> </TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody =("</TR>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody =("<TR BGCOLOR='white' >");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					
					m_MsgBody_text=m_MsgBody_text+paddingString("Client Name              :", 28,' ', false)+paddingString(rs1.getString(2),50,' ', false)+" "+eol;
					m_MsgBody =("<TD WIDTH='100'  align='left'   STYLE='{text-align:left;}'><FONT COLOR='black'>Client Name </TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody =("<TD WIDTH='150' align='left'  STYLE='{text-align:left;}'><FONT COLOR='black'>: "+rs1.getString(2)+"</TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:center;}'><B><FONT COLOR='black' ></TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:center;}'><B><FONT COLOR='black'> </TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody =("</TR>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody =("<TR BGCOLOR='white' >");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					
					m_MsgBody_text=m_MsgBody_text+paddingString("Client CDs No.           :", 28,' ', false)+paddingString(rs1.getString(3),50,' ', false)+" "+eol+eol+eol+eol;
					
					
					m_MsgBody =("<TD WIDTH='100' align='left'  STYLE='{text-align:left;}'><FONT COLOR='black'>Client CDs No.</TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody =("<TD WIDTH='150' align='left'  STYLE='{text-align:left;}'><FONT COLOR='black'>:"+rs1.getString(3)+"</TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:center;}'><B><FONT COLOR='black' ></TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:center;}'><B><FONT COLOR='black'> </TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody =("</TR>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody =("</B></TABLE>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					more1= rs1.next();		
					
				}
				
				m_MsgBody =("<BR><BR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				
				
				
				m_MsgBody =("<TABLE BORDER='0' WIDTH='1000' BGCOLOR='white' STYLE='{font: 9pt arial;}'><B>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				
				
				
				
				
				m_MsgBody =("<TR BGCOLOR='white' >");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='100'  align='center'  STYLE='{text-align:center;}'><B><FONT COLOR='black'></TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='150'  align='Left'  STYLE='{text-align:Left;}'><B><FONT COLOR='black'></TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				
				m_MsgBody =("<TD WIDTH='150' align='Left'  STYLE='{text-align:Left;}'><B><FONT COLOR='black'></TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				
				m_MsgBody =("<TD WIDTH='150'  align='center'  STYLE='{text-align:center;}'><B><FONT COLOR='black' ></TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='150' align='Right'   STYLE='{text-align:Right;}'><B><FONT COLOR='black'></TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				
				
				m_MsgBody =("<TD WIDTH='150'  align='Right'  STYLE='{text-align:Right;}'><B><FONT COLOR='black'></TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='150' align='Right'  STYLE='{text-align:Right;}'><B><FONT COLOR='black'></TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				/*
				m_MsgBody =("<TD WIDTH='150' align='center'  STYLE='{text-align:center;}'><B><FONT COLOR='black'>Narration</TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				*/
				m_MsgBody =("</TR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				//*********************************************
				
				
				m_MsgBody_text=m_MsgBody_text+paddingString("Date", 11,' ', false)+paddingString("Particulars ",20,' ', false)+" "+paddingString("Narration",50,' ', false)+" "+paddingString("Cheque No",9,' ', false)+" ";
				m_MsgBody_text=m_MsgBody_text+paddingString("Credits(Rs)", 15,' ', true)+" "+paddingString("Debits(Rs)", 15,' ', true)+" ";
				m_MsgBody_text=m_MsgBody_text+paddingString("Balance(Rs)", 18,' ', true)+eol;
				
				m_MsgBody =("<TR BGCOLOR='white' >");
				
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='100'  align='center'  STYLE='{text-align:center;}'><B><FONT COLOR='black'>Date</TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='150'  align='Left'  STYLE='{text-align:Left;}'><B><FONT COLOR='black'>Particulars</TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				
				m_MsgBody =("<TD WIDTH='150' align='Left'  STYLE='{text-align:Left;}'><B><FONT COLOR='black'>Narration</TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				
				m_MsgBody =("<TD WIDTH='150'  align='center'  STYLE='{text-align:center;}'><B><FONT COLOR='black' >Cheque No</TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='150' align='Right'   STYLE='{text-align:Right;}'><B><FONT COLOR='black'>Credits(Rs)</TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				
				
				m_MsgBody =("<TD WIDTH='150'  align='Right'  STYLE='{text-align:Right;}'><B><FONT COLOR='black'>Debits(Rs)</TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='150' align='Right'  STYLE='{text-align:Right;}'><B><FONT COLOR='black'>Balance(Rs)</TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				/*
				m_MsgBody =("<TD WIDTH='150' align='center'  STYLE='{text-align:center;}'><B><FONT COLOR='black'>Narration</TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				*/
				m_MsgBody =("</TR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				//m_MsgBody =("</B></TABLE>");				
				//m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				//out.println(m_MsgBody);
				
				//m_MsgBody =("<TABLE BORDER='0' WIDTH='1000' BGCOLOR='white' STYLE='{font: 9pt arial;}'>");
				//m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				//out.println(m_MsgBody);
				//m_MsgBody =("<TR><TD WIDTH='100'></TD><TD WIDTH='150'></TD><TD WIDTH='150'></TD><TD WIDTH='150'></TD></TR>");
				//m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				//out.println(m_MsgBody);
				/*
				rs3=stmt.executeQuery("SELECT TO_CHAR(EFF_VALDATE,'DD-MON-YY'), "+//DD-MON-YYYY Changed as DD-MON-YY by Shanheetha on 19-05-2006 for SR0605-054.
					" NVL(BROKER,'-'), "+
					" NVL(DESCRIPTION,'-'), "+
					" TO_CHAR(SETT_DATE,'DD/MM/YYYY'), "+//DD-MON-YYYY Changed as DD-MON-YY by Shanheetha on 19-05-2006 for SR0605-054.
					" NVL(SUM(VALUE),0), "+
					" NVL(SUM(CLIENT_BALANCE),0), "+
					" NVL(TENOR,0), "+
					" NVL(INTEREST,0), "+
					" "+m_schema_name+".DN_MOVEMENT_PREV_MONTH_INTREST('"+m_mdate_to+"','"+client_code+"') "+
					" FROM "+m_schema_name+".DN_TEMP_MOVEMENT_REPORT "+
					" WHERE USER_NAME='"+m_username+"' "+
					" GROUP BY SETT_DATE,BROKER,DESCRIPTION,EFF_VALDATE,TENOR,INTEREST "+
					" ORDER BY SETT_DATE,DESCRIPTION    ");*/
				
				
				rs3=stmt.executeQuery(
					"SELECT to_char(TO_date('"+m_mdate_from+"','DD-MM-YYYY'),'DD-MM-YYYY'), "+//DD-MON-YYYY Changed as DD-MON-YY by Shanheetha on 19-05-2006 for SR0605-054.
					""+m_schema_name+".DN_GET_OPENING_BALANCE_BF('"+m_mdate_from+"','"+client_code+"')*-1 "+
					"FROM DUAL");
				
				boolean more3 = rs3.next();
				if(more3){
					m_MsgBody_text=m_MsgBody_text+paddingString(rs3.getString(1), 11,' ', false)+paddingString("Balance B/F ",20,' ', false)+" "+paddingString(" ",50,' ', false)+" "+paddingString(" ",9,' ', false)+" ";
					m_MsgBody_text=m_MsgBody_text+paddingString(" ", 15,' ', true)+" "+paddingString(" ", 15,' ', true)+" ";
					
					
					m_MsgBody =("<TR BGCOLOR='white' >");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody =("<TD WIDTH='100' align='center'  STYLE='{text-align:center;}'><FONT COLOR='black'>"+rs3.getString(1) +"</TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody =("<TD WIDTH='150' align='left'  STYLE='{text-align:left;}'><FONT COLOR='black'>Balance B/F </TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					
					m_MsgBody =("<TD WIDTH='150' align='center'  STYLE='{text-align:center;}'><B><FONT COLOR='black'></TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					
					m_MsgBody =("<TD WIDTH='150' align='center'  STYLE='{text-align:center;}'><FONT COLOR='black'></TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody =("<TD WIDTH='150' align='right'  STYLE='{text-align:right;}'><FONT COLOR='black'></TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody =("<TD WIDTH='150' align='center'  STYLE='{text-align:center;}'><FONT COLOR='black'></TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					
					if(rs3.getDouble(2)>=0){
						m_MsgBody_text=m_MsgBody_text+paddingString(nf.format(rs3.getDouble(2))+"", 18,' ', true)+eol;
						m_MsgBody =("<TD WIDTH='150' align='right'  STYLE='{text-align:right;}'><FONT COLOR='black'>"+nf.format(rs3.getDouble(2))+"</TD>");
						m_SendMsgBody=m_SendMsgBody+m_MsgBody;
						out.println(m_MsgBody);
					}else{
						m_MsgBody_text=m_MsgBody_text+paddingString("("+nf.format(rs3.getDouble(2)*-1)+")", 18,' ', true)+eol;
						m_MsgBody =("<TD WIDTH='150' align='right'  STYLE='{text-align:right;}'><FONT COLOR='black'>("+nf.format(rs3.getDouble(2)*-1)+")</TD>");
						m_SendMsgBody=m_SendMsgBody+m_MsgBody;
						out.println(m_MsgBody);
					}
					/*	m_MsgBody =("<TD WIDTH='150' align='center'  STYLE='{text-align:center;}'><B><FONT COLOR='black'></TD>");
						m_SendMsgBody=m_SendMsgBody+m_MsgBody;
						out.println(m_MsgBody);
						*/
					m_MsgBody =("</TR>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_balance_total=m_balance_total+rs3.getDouble(2);
					more3 = rs3.next();		
				}
				
				String 	m_curr="SLR";
				/*String sql=(" "+
					" SELECT   PART,PORTFOLIO_CODE,to_char(EFF_VAL_DATE,'DD/MM/YYYY'),PARTICULARS,nvl(CHEQUE_NO,'-'),ROUND(CREDIT,2),ROUND(DEBITS,2),ROUND(BALANCE,2) "+
					" FROM ( "+
					"  "+
					" SELECT '1' PART, A.PORTFOLIO_CODE, A.EFF_VAL_DATE, DECODE (A.TRANSACTION_TYPE,'D', 'DEPOSIT' ) PARTICULARS, "+
					"        A.CHEQUE_NO, A.TRNAMOUNT CREDIT, 0 DEBITS, A.TRNAMOUNT*-1 BALANCE "+
					"        FROM "+m_schema_name+".DN_TRN_BO_CAP_DEPOSIT A "+
					"        WHERE A.TRANSACTION_TYPE = 'D' AND A.PORTFOLIO_CODE='"+client_code+"' "+
					"        AND EFF_VAL_DATE>=to_date('"+m_mdate_from+"','DD/MM/YYYY') AND EFF_VAL_DATE <=to_date('"+m_mdate_to+"','DD/MM/YYYY') "+
					"      "+
					"        UNION "+
					"       SELECT '2', A.PORTFOLIO_CODE, A.EFF_VAL_DATE, "+
					"              DECODE (A.TRANSACTION_TYPE, 'W', 'WITHDRAWAL') PARTICULARS, "+
					"              A.CHEQUE_NO, 0 CREDIT, A.TRNAMOUNT DEBITS, A.TRNAMOUNT BALANCE "+
					"        FROM "+m_schema_name+".DN_TRN_BO_CAP_DEPOSIT A "+
					"        WHERE TRANSACTION_TYPE = 'W' AND A.PORTFOLIO_CODE='"+client_code+"' "+
					"        AND EFF_VAL_DATE>=to_date('"+m_mdate_from+"','DD/MM/YYYY') AND EFF_VAL_DATE <=to_date('"+m_mdate_to+"','DD/MM/YYYY') "+
					"        UNION "+
					"       SELECT '3', B.PORTFOLIO_CODE, B.EFF_VALDATE, 'PAYMENT'||'-'||RR.DN_PORTFOLIO_CODE PARTICULARS, "+
					"              '' CHEQUENO,0 CREDIT,  B.PAY_AMOUNT DEBIT,B.PAY_AMOUNT BALANCE "+ //chande  B.PAY_AMOUNT by waruna 2011-01-03
					"       FROM "+m_schema_name+".DN_TRN_BO_SETTL_PAYMENT B ,"+m_schema_name+".DN_TRN_BO_SETTL_PAYMENT_BULK RR WHERE "+
					"       B.PAYMENT_NO=RR.PAYMENT_NO AND  RR.PORTFOLIO_CODE='"+client_code+"' "+
					"        AND B.EFF_VALDATE>=to_date('"+m_mdate_from+"','DD/MM/YYYY') AND B.EFF_VALDATE <=to_date('"+m_mdate_to+"','DD/MM/YYYY') "+
					"       UNION "+
					"       SELECT '4', C.PORTFOLIO_CODE, C.EFF_VALDATE, 'RECEIPT'||'-'||C.ID_PORTFOLIO_CODE PARTICULARS, "+
					"            ''CHEQUENO, C.REC_AMOUNT CREDIT, 0 DEBIT, C.REC_AMOUNT BALANCE "+ //chande by waruna 2011-01-03
					"       FROM "+m_schema_name+".DN_TRN_BO_SETTL_RECEIPT_BULK C WHERE C.SELL_PORTFOLIO_CODE='"+client_code+"' " +
					"        AND EFF_VALDATE>=to_date('"+m_mdate_from+"','DD/MM/YYYY') AND EFF_VALDATE <=to_date('"+m_mdate_to+"','DD/MM/YYYY') "+
					//---------------------------------interest ---------------------------------------------------------------
					" UNION ALL "+
					" SELECT DISTINCT '5',"+
					" A.BORR_PORTFOLIO_CODE,A.EFF_VALDATE,'INTEREST' PARTICULARS,'' chequeno,0 CREDIT,"+  //" "+m_schema_name+".RETURN_PF_NAME(A.BORR_PORTFOLIO_CODE),"+
					" "+m_schema_name+".RETURN_ACCRUED_INTEREST(A.DEAL_NO,'"+m_mdate_to+"') INEREST"+
					" ,"+m_schema_name+".RETURN_ACCRUED_INTEREST(A.DEAL_NO,'"+m_mdate_to+"') "+
					" FROM "+m_schema_name+".DN_TRN_REPO_FRESH A, "+
					" "+m_schema_name+".DN_REF_PORTFOLIO B, "+
					" "+m_schema_name+".DN_REF_PORTFOLIO Z ,"+
					" "+m_schema_name+".DN_TRN_REPO_FRESH_INST C "+
					" WHERE TO_DATE(TO_CHAR(A.MATURITY_DATE,'DD/MM/YYYY'),'DD/MM/YYYY') > TO_DATE('"+m_mdate_from+"','DD/MM/YYYY') "+
					" AND TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY') <= TO_DATE('"+m_mdate_to+"','DD/MM/YYYY') "+
					" AND APP_STATUS='CONF' "+
					" AND A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE "+
					" AND A.LEND_PORTFOLIO_CODE=Z.PORTFOLIO_CODE "+
					//" AND B.OWNED_BY_MBFSL='Y' "+
					" AND A.DEAL_NO=C.DEAL_NO(+) "+
					" AND A.BORR_PORTFOLIO_CODE = '"+client_code+"' " +//added By Nilu on 2-9-2004/10:6 
					" AND Z.BRANCH LIKE ("+m_schema_name+".DN_GET_USER_LOCATION('"+m_username+"')) "+
					" AND A.CURR_CODE = '"+m_curr+"' "+ //CURRENCY
					//" GROUP BY A.DEAL_NO,A.BORR_PORTFOLIO_CODE "+
					
					" UNION ALL "+
					
					" SELECT DISTINCT '5', "+
					" A.BORR_PORTFOLIO_CODE,A.EFF_VALDATE,'INTEREST' PARTICULARS,'' chequeno,0 CREDIT, "+
					" "+m_schema_name+".RETURN_ACCRUED_INTEREST(A.DEAL_NO,'"+m_mdate_to+"') "+
					" ,"+m_schema_name+".RETURN_ACCRUED_INTEREST(A.DEAL_NO,'"+m_mdate_to+"') "+
					
					" FROM "+m_schema_name+".DN_TRN_REPO_ROLLOVER A, "+
					" "+m_schema_name+".DN_REF_PORTFOLIO B, "+
					" "+m_schema_name+".DN_REF_PORTFOLIO Z ,"+
					" "+m_schema_name+".DN_TRN_REPO_ROLLOVER_INST C "+
					" WHERE TO_DATE(TO_CHAR(A.MATURITY_DATE,'DD/MM/YYYY'),'DD/MM/YYYY') > TO_DATE('"+m_mdate_from+"','DD/MM/YYYY') "+
					" AND TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY') <= TO_DATE('"+m_mdate_to+"','DD/MM/YYYY') "+
					" AND APP_STATUS='CONF' "+
					" AND A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE "+
					" AND A.LEND_PORTFOLIO_CODE=Z.PORTFOLIO_CODE "+
					//" AND B.OWNED_BY_MBFSL='Y' "+
					" AND A.DEAL_NO=C.DEAL_NO(+) "+
					" AND A.BORR_PORTFOLIO_CODE =  '"+client_code+"' " + //added By Nilu on 2-9-2004/10:6 
					" AND Z.BRANCH LIKE ("+m_schema_name+".DN_GET_USER_LOCATION('"+m_username+"')) "+
					" AND A.CURR_CODE = '"+m_curr+"' "+ //CURRENCY
					//" GROUP BY A.DEAL_NO,A.BORR_PORTFOLIO_CODE "+
					
					" UNION ALL "+
					
					" SELECT DISTINCT '5',"+
					" A.BORR_PORTFOLIO_CODE,A.EFF_VALDATE,'INTEREST' PARTICULARS,'' chequeno,0 CREDIT,  "+
					" "+m_schema_name+".RETURN_ACCRUED_INTEREST(A.DEAL_NO,'"+m_mdate_to+"') "+
					" ,"+m_schema_name+".RETURN_ACCRUED_INTEREST(A.DEAL_NO,'"+m_mdate_to+"') "+
					
					" FROM "+m_schema_name+".DN_TRN_REPO_PERIOD_INT A, "+
					" "+m_schema_name+".DN_REF_PORTFOLIO B, "+
					" "+m_schema_name+".DN_REF_PORTFOLIO Z, "+
					" "+m_schema_name+".DN_TRN_REPO_PERIOD_INT_INST C "+
					" WHERE TO_DATE(TO_CHAR(A.MATURITY_DATE,'DD/MM/YYYY'),'DD/MM/YYYY') > TO_DATE('"+m_mdate_from+"','DD/MM/YYYY') "+
					" AND TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY') <= TO_DATE('"+m_mdate_to+"','DD/MM/YYYY') "+
					" AND APP_STATUS='CONF' "+
					" AND A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE "+
					" AND A.LEND_PORTFOLIO_CODE=Z.PORTFOLIO_CODE "+
					//" AND B.OWNED_BY_MBFSL='Y' "+
					" AND A.DEAL_NO=C.DEAL_NO(+) "+
					" AND A.BORR_PORTFOLIO_CODE = '"+client_code+"' "+//added By Nilu on 2-9-2004/10:6 
					" AND Z.BRANCH LIKE ("+m_schema_name+".DN_GET_USER_LOCATION('"+m_username+"')) "+
					" AND A.CURR_CODE = '"+m_curr+"' "+ //CURRENCY
					//" GROUP BY A.DEAL_NO,A.BORR_PORTFOLIO_CODE "+
					" "+
					//------end interest	
					" ) "+
					//"       ORDER BY PART, EFF_VAL_DATE "+
					"       ORDER BY EFF_VAL_DATE,PART "+
					" ");
				
				*/
				String m_is_last_date="NO";
				String sql2="SELECT 'YES' From Dual where last_day(to_date('"+m_mdate_to+"','dd-mm-yyyy'))=to_date('"+m_mdate_to+"','dd-mm-yyyy')";
				rs2 = stmt.executeQuery (sql2);
				more2 = rs2.next();
				if(more2){
					m_is_last_date=rs2.getString(1);
				}
				
				String m_last_month_end_date="";
				
				String sql3=(
					
					" select to_char(min (dates),'dd-mm-yyyy') from( "+
					" SELECT to_date('01'||to_char(to_date('"+m_mdate_to+"','dd-mm-yyyy'),'-mm-yyyy'),'dd-mm-yyyy') -1  dates "+
					" From Dual where last_day(to_date('"+m_mdate_to+"','dd-mm-yyyy'))>to_date('"+m_mdate_to+"','dd-mm-yyyy') "+
					" union  "+
					" SELECT last_day(to_date('"+m_mdate_to+"','dd-mm-yyyy')) dates " +
					" From Dual where last_day(to_date('"+m_mdate_to+"','dd-mm-yyyy'))=to_date('"+m_mdate_to+"','dd-mm-yyyy')"+
					" )"
					);
				
				rs2 = stmt.executeQuery (sql3);
				more2 = rs2.next();
				if(more2){
					m_last_month_end_date=rs2.getString(1);
				}
				
				String flag1="";
				String sql4=("SELECT 'YES' From Dual where to_date('"+m_last_month_end_date+"','dd-mm-yyyy')>to_date('"+m_mdate_from+"','dd-mm-yyyy')");
				rs2 = stmt.executeQuery (sql4);
				more2 = rs2.next();
				if(more2){
					flag1=rs2.getString(1);
				}
				
				/*	String sql=(" "+
						" SELECT   PART,PORTFOLIO_CODE,to_char(EFF_VAL_DATE,'DD/MM/YYYY'),PARTICULARS,nvl(CHEQUE_NO,'-'),ROUND(CREDIT,2),ROUND(DEBITS,2),ROUND(BALANCE,2) "+
						" FROM ( "+
						"  "+
						" SELECT '1' PART, A.PORTFOLIO_CODE, A.EFF_VAL_DATE, DECODE (A.TRANSACTION_TYPE,'D', 'DEPOSIT' ) PARTICULARS, "+
						"        A.CHEQUE_NO, A.TRNAMOUNT CREDIT, 0 DEBITS, A.TRNAMOUNT*-1 BALANCE "+
						"        FROM "+m_schema_name+".DN_TRN_BO_CAP_DEPOSIT A "+
						"        WHERE A.TRANSACTION_TYPE = 'D' AND A.PORTFOLIO_CODE='"+client_code+"' "+
						"        AND EFF_VAL_DATE>=to_date('"+m_mdate_from+"','DD/MM/YYYY') AND EFF_VAL_DATE <=to_date('"+m_mdate_to+"','DD/MM/YYYY') "+
						"      "+
						"        UNION "+
						"       SELECT '2', A.PORTFOLIO_CODE, A.EFF_VAL_DATE, "+
						"              DECODE (A.TRANSACTION_TYPE, 'W', 'WITHDRAWAL') PARTICULARS, "+
						"              A.CHEQUE_NO, 0 CREDIT, A.TRNAMOUNT DEBITS, A.TRNAMOUNT BALANCE "+
						"        FROM "+m_schema_name+".DN_TRN_BO_CAP_DEPOSIT A "+
						"        WHERE TRANSACTION_TYPE = 'W' AND A.PORTFOLIO_CODE='"+client_code+"' "+
						"        AND EFF_VAL_DATE>=to_date('"+m_mdate_from+"','DD/MM/YYYY') AND EFF_VAL_DATE <=to_date('"+m_mdate_to+"','DD/MM/YYYY') "+
						"        UNION "+
						"       SELECT '3', B.PORTFOLIO_CODE, B.EFF_VALDATE, 'PAYMENT'||'-'||RR.DN_PORTFOLIO_CODE PARTICULARS, "+
						"              '' CHEQUENO,0 CREDIT,  B.PAY_AMOUNT DEBIT,B.PAY_AMOUNT BALANCE "+ //chande  B.PAY_AMOUNT by waruna 2011-01-03
						"       FROM "+m_schema_name+".DN_TRN_BO_SETTL_PAYMENT B ,"+m_schema_name+".DN_TRN_BO_SETTL_PAYMENT_BULK RR WHERE "+
						"       B.PAYMENT_NO=RR.PAYMENT_NO AND  RR.PORTFOLIO_CODE='"+client_code+"' "+
						"        AND B.EFF_VALDATE>=to_date('"+m_mdate_from+"','DD/MM/YYYY') AND B.EFF_VALDATE <=to_date('"+m_mdate_to+"','DD/MM/YYYY') "+
						"       UNION "+
						"       SELECT '4', C.PORTFOLIO_CODE, C.EFF_VALDATE, 'RECEIPT'||'-'||C.ID_PORTFOLIO_CODE PARTICULARS, "+
						"            ''CHEQUENO, C.REC_AMOUNT CREDIT, 0 DEBIT, C.REC_AMOUNT BALANCE "+ //chande by waruna 2011-01-03
						"       FROM "+m_schema_name+".DN_TRN_BO_SETTL_RECEIPT_BULK C WHERE C.SELL_PORTFOLIO_CODE='"+client_code+"' " +
						"        AND EFF_VALDATE>=to_date('"+m_mdate_from+"','DD/MM/YYYY') AND EFF_VALDATE <=to_date('"+m_mdate_to+"','DD/MM/YYYY') "+
						//---------------------------------interest ---------------------------------------------------------------
						" UNION ALL "+
						
						" SELECT PART, BORR_PORTFOLIO_CODE,last_day(to_date('"+m_last_month_end_date+"','dd/mm/yyyy')) EFF_VALDATE,PARTICULARS,chequeno,sum(CREDIT),sum(INEREST),sum(BALANCE) FROM( "+//add by waruna 2011-12-03
						" SELECT DISTINCT '5' PART,"+
						" A.BORR_PORTFOLIO_CODE,A.EFF_VALDATE,'INTEREST' PARTICULARS,'' chequeno,0 CREDIT,"+  //" "+m_schema_name+".RETURN_PF_NAME(A.BORR_PORTFOLIO_CODE),"+
						" "+m_schema_name+".RETURN_ACCRUED_INTEREST(A.DEAL_NO,'"+m_last_month_end_date+"') INEREST"+
						" ,"+m_schema_name+".RETURN_ACCRUED_INTEREST(A.DEAL_NO,'"+m_last_month_end_date+"') BALANCE "+
						" FROM "+m_schema_name+".DN_TRN_REPO_FRESH A, "+
						" "+m_schema_name+".DN_REF_PORTFOLIO B, "+
						" "+m_schema_name+".DN_REF_PORTFOLIO Z ,"+
						" "+m_schema_name+".DN_TRN_REPO_FRESH_INST C "+
						" WHERE TO_DATE(TO_CHAR(A.MATURITY_DATE,'DD/MM/YYYY'),'DD/MM/YYYY') > TO_DATE('"+m_mdate_from+"','DD/MM/YYYY') "+
						" AND TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY') <= TO_DATE('"+m_last_month_end_date+"','DD/MM/YYYY') "+
						" AND APP_STATUS='CONF' "+
						" AND A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE "+
						" AND A.LEND_PORTFOLIO_CODE=Z.PORTFOLIO_CODE "+
						//" AND B.OWNED_BY_MBFSL='Y' "+
						" AND A.DEAL_NO=C.DEAL_NO(+) "+
						" AND A.BORR_PORTFOLIO_CODE = '"+client_code+"' " +//added By Nilu on 2-9-2004/10:6 
						" AND Z.BRANCH LIKE ("+m_schema_name+".DN_GET_USER_LOCATION('"+m_username+"')) "+
						" AND A.CURR_CODE = '"+m_curr+"' "+ //CURRENCY
						//" GROUP BY A.DEAL_NO,A.BORR_PORTFOLIO_CODE "+
						
						" UNION ALL "+
						
						" SELECT DISTINCT '5', "+
						" A.BORR_PORTFOLIO_CODE,A.EFF_VALDATE,'INTEREST' PARTICULARS,'' chequeno,0 CREDIT, "+
						" "+m_schema_name+".RETURN_ACCRUED_INTEREST(A.DEAL_NO,'"+m_last_month_end_date+"') "+
						" ,"+m_schema_name+".RETURN_ACCRUED_INTEREST(A.DEAL_NO,'"+m_last_month_end_date+"') "+
						
						" FROM "+m_schema_name+".DN_TRN_REPO_ROLLOVER A, "+
						" "+m_schema_name+".DN_REF_PORTFOLIO B, "+
						" "+m_schema_name+".DN_REF_PORTFOLIO Z ,"+
						" "+m_schema_name+".DN_TRN_REPO_ROLLOVER_INST C "+
						" WHERE TO_DATE(TO_CHAR(A.MATURITY_DATE,'DD/MM/YYYY'),'DD/MM/YYYY') > TO_DATE('"+m_mdate_from+"','DD/MM/YYYY') "+
						" AND TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY') <= TO_DATE('"+m_last_month_end_date+"','DD/MM/YYYY') "+
						" AND APP_STATUS='CONF' "+
						" AND A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE "+
						" AND A.LEND_PORTFOLIO_CODE=Z.PORTFOLIO_CODE "+
						//" AND B.OWNED_BY_MBFSL='Y' "+
						" AND A.DEAL_NO=C.DEAL_NO(+) "+
						" AND A.BORR_PORTFOLIO_CODE =  '"+client_code+"' " + //added By Nilu on 2-9-2004/10:6 
						" AND Z.BRANCH LIKE ("+m_schema_name+".DN_GET_USER_LOCATION('"+m_username+"')) "+
						" AND A.CURR_CODE = '"+m_curr+"' "+ //CURRENCY
						//" GROUP BY A.DEAL_NO,A.BORR_PORTFOLIO_CODE "+
						
						" UNION ALL "+
						
						" SELECT DISTINCT '5',"+
						" A.BORR_PORTFOLIO_CODE,A.EFF_VALDATE,'INTEREST' PARTICULARS,'' chequeno,0 CREDIT,  "+
						" "+m_schema_name+".RETURN_ACCRUED_INTEREST(A.DEAL_NO,'"+m_last_month_end_date+"') "+
						" ,"+m_schema_name+".RETURN_ACCRUED_INTEREST(A.DEAL_NO,'"+m_last_month_end_date+"') "+
						
						" FROM "+m_schema_name+".DN_TRN_REPO_PERIOD_INT A, "+
						" "+m_schema_name+".DN_REF_PORTFOLIO B, "+
						" "+m_schema_name+".DN_REF_PORTFOLIO Z, "+
						" "+m_schema_name+".DN_TRN_REPO_PERIOD_INT_INST C "+
						" WHERE TO_DATE(TO_CHAR(A.MATURITY_DATE,'DD/MM/YYYY'),'DD/MM/YYYY') > TO_DATE('"+m_mdate_from+"','DD/MM/YYYY') "+
						" AND TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY') <= TO_DATE('"+m_last_month_end_date+"','DD/MM/YYYY') "+
						" AND APP_STATUS='CONF' "+
						" AND A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE "+
						" AND A.LEND_PORTFOLIO_CODE=Z.PORTFOLIO_CODE "+
						//" AND B.OWNED_BY_MBFSL='Y' "+
						" AND A.DEAL_NO=C.DEAL_NO(+) "+
						" AND A.BORR_PORTFOLIO_CODE = '"+client_code+"' "+//added By Nilu on 2-9-2004/10:6 
						" AND Z.BRANCH LIKE ("+m_schema_name+".DN_GET_USER_LOCATION('"+m_username+"')) "+
						" AND A.CURR_CODE = '"+m_curr+"' "+ //CURRENCY
						//" GROUP BY A.DEAL_NO,A.BORR_PORTFOLIO_CODE "+
						" "+
						" ) GROUP BY PART, BORR_PORTFOLIO_CODE ,PARTICULARS,CHEQUENO "+ //add by waruna 2011-12-03
						//------end interest	
						" ) "+
						//"       ORDER BY PART, EFF_VAL_DATE "+
						"       ORDER BY EFF_VAL_DATE,PART "+
						" ");*/
				//out.println(sql);
				
				
				
				
				callstmt1= conn.prepareCall( "BEGIN "+m_schema_name+".DN_CLIENT_TRN_STATEMNT_RPT (?,?,?,?); END;");
				callstmt1.setString(1,client_code);
				callstmt1.setString(2,m_username);
				callstmt1.setString(3,m_mdate_from);
				callstmt1.setString(4,m_mdate_to);
				callstmt1.execute();
				callstmt1.close();
				
				//Commnted by thamali 2012.01.26
				/*String sql=("SELECT A.PART, A.PORTFOLIO_CODE, TO_CHAR(A.EFF_VAL_DATE,'DD-MM-YYYY') EFF_VAL_DATES, A.PARTICULARS,NVL(A.CHEQUE_NO,'-') CHEQUE_NO, sum(A.CREDIT), sum(A.DEBITS), sum(A.BALANCE),nvl(A.NARRATION,'-') NARRATION ,A.EFF_VAL_DATE"+
					" FROM "+m_schema_name+".DN_TRN_STATEMENT_TMP_RPT a where a.dn_user='"+m_username+"' "+
					" GROUP BY  PART,PORTFOLIO_CODE,EFF_VAL_DATE,PARTICULARS,CHEQUE_NO,NARRATION "+
					" order by A.EFF_VAL_DATE");*/
				
				// added by thamali 2012.01.26
				String sql=("SELECT * FROM( SELECT A.PART, A.PORTFOLIO_CODE, TO_CHAR(A.EFF_VAL_DATE,'DD-MM-YYYY') EFF_VAL_DATES, A.PARTICULARS,NVL(A.CHEQUE_NO,'-') CHEQUE_NO, sum(A.CREDIT), sum(A.DEBITS), sum(A.BALANCE),nvl(A.NARRATION,'-') NARRATION ,A.EFF_VAL_DATE"+
					" FROM "+m_schema_name+".DN_TRN_STATEMENT_TMP_RPT a where a.dn_user='"+m_username+"' AND  PART NOT IN ('3','4') "+
					" GROUP BY  PART,PORTFOLIO_CODE,EFF_VAL_DATE,PARTICULARS,CHEQUE_NO,NARRATION "+
					" union SELECT A.PART, A.PORTFOLIO_CODE, TO_CHAR(A.EFF_VAL_DATE,'DD-MM-YYYY') EFF_VAL_DATES, A.PARTICULARS,NVL(A.CHEQUE_NO,'-') CHEQUE_NO, A.CREDIT, A.DEBITS, A.BALANCE,nvl(A.NARRATION,'-') NARRATION ,A.EFF_VAL_DATE"+
					" FROM "+m_schema_name+".DN_TRN_STATEMENT_TMP_RPT a where a.dn_user='"+m_username+"' AND  PART  IN ('3','4') ) x "+
					" order by x.EFF_VAL_DATE");

				
				double m_cr_total_int=0;
				double m_dr_total_int=0;
				String m_date_int="";
				double Balancefig_int=0;
				
				rs = stmt.executeQuery (sql);
				//out.println(sql);
				boolean more = rs.next();
				
				
				
				
				while (more) {
					String Balancefig="";	
					m_MsgBody_text=m_MsgBody_text+paddingString(rs.getString(3), 11,' ', false)+paddingString(rs.getString(4),20,' ', false)+" "+paddingString(rs.getString(9),50,' ', false)+" "+paddingString(rs.getString(5),9,' ', false)+" ";
					
					//if(!rs.getString(1).equals("5")){
					m_MsgBody =("<TR BGCOLOR='white' STYLE='{ font:  9pt arial;}'  >");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody =("<TD WIDTH='100'  align='center'  STYLE='{text-align:center;}'><FONT COLOR='black'>"+rs.getString(3) +"</TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					m_MsgBody =("<TD WIDTH='150' align='left'  STYLE='{text-align:left;}'><FONT COLOR='black'>"+rs.getString(4)+" </TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					
					m_MsgBody =("<TD WIDTH='150' align='LEFT'  STYLE='{text-align:LEFT;}'><FONT COLOR='black'>"+rs.getString(9) +"</TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					
					m_MsgBody =("<TD WIDTH='150' align='center'  STYLE='{text-align:center;}'><FONT COLOR='black' >"+rs.getString(5)+"</TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					/*
					if(rs.getDouble(6)>=0){
						m_MsgBody =("<TD WIDTH='150' align='right'  STYLE='{text-align:right;}'><FONT COLOR='black'>"+nf.format(rs.getDouble(6))+" </TD>");
						m_SendMsgBody=m_SendMsgBody+m_MsgBody;
						out.println(m_MsgBody);
					}else{
						m_MsgBody =("<TD WIDTH='150' align='right'  STYLE='{text-align:right;}'><FONT COLOR='black'>("+nf.format(rs.getDouble(6)*-1)+") </TD>");
						m_SendMsgBody=m_SendMsgBody+m_MsgBody;
						out.println(m_MsgBody);
						
					}
					//DR
					if(rs.getDouble(7)>=0){
						m_MsgBody =("<TD WIDTH='150' align='right'  STYLE='{text-align:right;}'><FONT COLOR='black'>"+nf.format(rs.getDouble(7))+"</TD>");
						m_SendMsgBody=m_SendMsgBody+m_MsgBody;
						out.println(m_MsgBody);
					}else{
						
						m_MsgBody =("<TD WIDTH='150' align='right' STYLE='{text-align:right;}'><FONT COLOR='black'>("+nf.format(rs.getDouble(7)*-1)+")</TD>");
						m_SendMsgBody=m_SendMsgBody+m_MsgBody;
						out.println(m_MsgBody);
					}
					*/
					
					
					
					
					
					//modify by waruna 2011-01-10
					if(rs.getDouble(8)>=0){
						
						m_MsgBody_text=m_MsgBody_text+paddingString("0", 15,' ', true)+" "+paddingString(nf.format(rs.getDouble(8))+"", 15,' ', true)+" ";
						
						m_MsgBody =("<TD WIDTH='150' align='right'  STYLE='{text-align:right;}'><FONT COLOR='black'>0</TD>");
						m_SendMsgBody=m_SendMsgBody+m_MsgBody;
						out.println(m_MsgBody);
						
						m_MsgBody =("<TD WIDTH='150' align='right'  STYLE='{text-align:right;}'><FONT COLOR='black'>"+nf.format(rs.getDouble(8))+" </TD>");
						m_SendMsgBody=m_SendMsgBody+m_MsgBody;
						out.println(m_MsgBody);
						m_dr_total=m_dr_total+rs.getDouble(8)*-1;
						
					}else{
						m_MsgBody_text=m_MsgBody_text+paddingString(nf.format(rs.getDouble(8)*-1)+"", 15,' ', true)+" "+paddingString("0", 15,' ', true)+" ";
						m_MsgBody =("<TD WIDTH='150' align='right'  STYLE='{text-align:right;}'><FONT COLOR='black'>"+nf.format(rs.getDouble(8)*-1)+" </TD>");
						m_SendMsgBody=m_SendMsgBody+m_MsgBody;
						out.println(m_MsgBody);
						
						m_MsgBody =("<TD WIDTH='150' align='right'  STYLE='{text-align:right;}'><FONT COLOR='black'>0</TD>");
						m_SendMsgBody=m_SendMsgBody+m_MsgBody;
						out.println(m_MsgBody);
						
						m_cr_total=m_cr_total+rs.getDouble(8);
					}
					
					
					
					
					
					m_balance_total=m_balance_total	+rs.getDouble(6)-rs.getDouble(7);
					
					//m_cr_total=m_cr_total+rs.getDouble(6);
					//m_dr_total=m_dr_total+rs.getDouble(7);
					if(m_balance_total<0){
						
						Balancefig="("+nf.format(m_balance_total*-1)+")";
					}else{
						Balancefig=nf.format(m_balance_total);
					}
					//char new_line=' \\n ';
					//String eol = System.getProperty("line.separator");
					String end_line="#";
					
					m_MsgBody_text=m_MsgBody_text+paddingString(Balancefig, 18,' ', true)+eol;
					m_MsgBody =("<TD WIDTH='150' align='right' STYLE='{text-align:right;}'><FONT COLOR='black'>"+Balancefig+"</TD>");					
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					/*
					m_MsgBody =("<TD WIDTH='150' align='LEFT'  STYLE='{text-align:LEFT;}'><FONT COLOR='black'>"+rs.getString(9) +"</TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					*/
					m_MsgBody =("</TR>"); 
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					
					
					/*}else{

						//if(rs.getString(1).equals("5") && m_is_last_date.equals("YES")){
						if(rs.getString(1).equals("5") ){	
					//if(rs.getString(1).equals("5") && flag1.equals("YES")){	
						while(more && rs.getString(1).equals("5")){
								m_date_int=rs.getString(3);
								m_balance_total=m_balance_total	+rs.getDouble(8);
								m_cr_total_int=m_cr_total_int+rs.getDouble(6);
								m_dr_total_int=m_dr_total_int+rs.getDouble(7);
								Balancefig_int=Balancefig_int+rs.getDouble(8);
								more = rs.next();
							}
							
							m_MsgBody =("<TR BGCOLOR='white' >");
							m_SendMsgBody=m_SendMsgBody+m_MsgBody;
							out.println(m_MsgBody);
							m_MsgBody =("<TD WIDTH='100' STYLE='{text-align:center;}'><B><FONT COLOR='black'>"+m_date_int +"</TD>");
							m_SendMsgBody=m_SendMsgBody+m_MsgBody;
							out.println(m_MsgBody);
							m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:left;}'><B><FONT COLOR='black'>"+"INTEREST"+" </TD>");
							m_SendMsgBody=m_SendMsgBody+m_MsgBody;
							out.println(m_MsgBody);
							m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:right;}'><B><FONT COLOR='black' >"+"-"+"</TD>");
							m_SendMsgBody=m_SendMsgBody+m_MsgBody;
							out.println(m_MsgBody);
							m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:right;}'><B><FONT COLOR='black'>"+nf.format(m_cr_total_int)+" </TD>");
							m_SendMsgBody=m_SendMsgBody+m_MsgBody;
							out.println(m_MsgBody);
							m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:right;}'><B><FONT COLOR='black'>"+nf.format(m_dr_total_int)+"</TD>");
							m_SendMsgBody=m_SendMsgBody+m_MsgBody;
							out.println(m_MsgBody);
							if(Balancefig_int<0){
								
								Balancefig="("+nf.format((Balancefig_int*-1))+")";
							}else{
								Balancefig=nf.format(Balancefig_int);
							}
							m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:right;}'><B><FONT COLOR='black'>"+Balancefig+"</TD>");					
							m_SendMsgBody=m_SendMsgBody+m_MsgBody;
							out.println(m_MsgBody);
							m_MsgBody =("</TR>"); 
							m_SendMsgBody=m_SendMsgBody+m_MsgBody;
							out.println(m_MsgBody);
							
							m_cr_total=m_cr_total+m_cr_total_int;
							m_dr_total=m_dr_total+m_dr_total_int;							
						}
						
						
					}	
					
					*/
					//m_balance_total=m_balance_total	+rs.getDouble(8);
					//m_cr_total=m_cr_total+rs.getDouble(6);
					//m_dr_total=m_dr_total+rs.getDouble(7);
					
					
					
					more = rs.next();		
					//m_gr_sales=m_gr_sales+m_sal_tot;
					
				}
				
				
				//-------------Start total value-----------------------------------------------------------------------
				
				//m_MsgBody =("<TABLE BORDER='0' WIDTH='1000' BGCOLOR='white' STYLE='{font: 9pt arial;}'><B>");//comment by waruna 2010-01-12
				//m_SendMsgBody=m_SendMsgBody+m_MsgBody;//comment by waruna 2010-01-12
				//out.println(m_MsgBody);//comment by waruna 2010-01-12
				m_MsgBody_text=m_MsgBody_text+paddingString(" ", 11,' ', false)+paddingString(" ",20,' ', false)+" "+paddingString(" ",50,' ', false)+" "+paddingString(" ",9,' ', false)+" ";
				m_MsgBody_text=m_MsgBody_text+paddingString("---------------", 15,' ', true)+" "+paddingString("---------------", 15,' ', true)+" ";
				m_MsgBody_text=m_MsgBody_text+paddingString("", 18,' ', true)+eol;
				
				
				
				
				
				
				
				m_MsgBody =("<TR BGCOLOR='white' >");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='100' STYLE='{text-align:left;}'><B><FONT COLOR='black'></TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='150' align='Left'  STYLE='{text-align:Left;}'><B><FONT COLOR='black'></TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				
				m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:left;}'><B><FONT COLOR='black'></TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:center;}'><B><FONT COLOR='black' ></TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:right;}'><B><FONT COLOR='black'>------------------------------</TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:right;}'><B><FONT COLOR='black'>------------------------------</TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:right;}'><B><FONT COLOR='black'></TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("</TR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TR BGCOLOR='white' >");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='100' STYLE='{text-align:left;}'><B><FONT COLOR='black'> </TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='150' align='Left'  STYLE='{text-align:Left;}'><B><FONT COLOR='black'></TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:left;}'><B><FONT COLOR='black'>Total</TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:center;}'><B><FONT COLOR='black' ></TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				
				
				
				m_MsgBody_text=m_MsgBody_text+paddingString(" ", 11,' ', false)+paddingString("Total",20,' ', false)+" "+paddingString(" ",50,' ', false)+" "+paddingString(" ",9,' ', false)+" ";
				
				
				
				
				
				if(m_cr_total<=0){
					m_MsgBody_text=m_MsgBody_text+paddingString(nf.format(m_cr_total*-1)+"", 15,' ', true)+" ";
					m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:right;}'><B><FONT COLOR='black'>"+nf.format(m_cr_total*-1)+"</TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					
					
				}else{
					m_MsgBody_text=m_MsgBody_text+paddingString("("+nf.format(m_cr_total)+")", 15,' ', true)+" ";
					m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:right;}'><B><FONT COLOR='black'>("+nf.format(m_cr_total)+")</TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
				}
				
				
				
				if(m_dr_total<=0){
					m_MsgBody_text=m_MsgBody_text+paddingString(nf.format(m_dr_total*-1)+"", 15,' ', true)+" ";
					
					m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:right;}'><B><FONT COLOR='black' >"+nf.format(m_dr_total*-1)+"</TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
				}else{
					m_MsgBody_text=m_MsgBody_text+paddingString("("+nf.format(m_dr_total)+")", 15,' ', true)+" ";
					
					m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:right;}'><B><FONT COLOR='black' >("+nf.format(m_dr_total)+")</TD>");
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					
				}
				
				
				if(m_balance_total>=0){
					
					m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:right;}'><B><FONT COLOR='black'></TD>");//nf.format(m_balance_total)
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
				}else{
					m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:right;}'><B><FONT COLOR='black'></TD>");//("+nf.format(m_balance_total*-1)+")
					m_SendMsgBody=m_SendMsgBody+m_MsgBody;
					out.println(m_MsgBody);
					
					
				}
				m_MsgBody_text=m_MsgBody_text+paddingString("", 18,' ', true)+eol;
				
				
				m_MsgBody_text=m_MsgBody_text+paddingString(" ", 11,' ', false)+paddingString(" ",20,' ', false)+" "+paddingString(" ",50,' ', false)+" "+paddingString(" ",9,' ', false)+" ";
				m_MsgBody_text=m_MsgBody_text+paddingString("===============", 15,' ', true)+" "+paddingString("===============", 15,' ', true)+" ";
				m_MsgBody_text=m_MsgBody_text+paddingString("", 18,' ', true)+eol;
				
				m_MsgBody =("</TR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TR BGCOLOR='white' >");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='100' STYLE='{text-align:left;}'><B><FONT COLOR='black'></TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='150' align='Left'  STYLE='{text-align:Left;}'><B><FONT COLOR='black'></TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:left;}'><B><FONT COLOR='black'></TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:center;}'><B><FONT COLOR='black' ></TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:right;}'><B><FONT COLOR='black'>=================</TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:right;}'><B><FONT COLOR='black'>=================</TD>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='150' STYLE='{text-align:right;}'><B><FONT COLOR='black'></TD>");//=================
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("</TR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("</B></TABLE>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				
				
				//-------------end total value-----------------------------------------------------------------------
				m_MsgBody =("<TR BGCOLOR='white'>");// for the last record
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				/*out.println("<TR><TD>    <TD><TD>");
				out.println("<TD WIDTH='100' STYLE='{font: 9pt arial; text-align:right;}'>_______________________</TD></TR>");
				out.println("<TR><TD>    <TD><TD>");
				out.println("<TD WIDTH='150' STYLE='{font: 9pt arial; text-align:right;}'>"+nf.format(m_sal_tot)+"</TD></TR>");
				out.println("<TR><TD>    <TD><TD>");
				out.println("<TD WIDTH='100' STYLE='{font: 9pt arial; text-align:right;}'>=======================</TD></TR>");
				
				out.println("<TR BGCOLOR='white'>");
				out.println("<TR><TD><TD><TD>");
				out.println("<TD WIDTH='100' STYLE='{font: 9pt arial; text-align:right;}'>_______________________</TD></TR>");
				out.println("<TR><TD><TD>");
				out.println("<TD WIDTH='150' STYLE='{font: 9pt arial; text-align:left;}'><B> Total Sales </B></TD>");
				out.println("<TD WIDTH='150' STYLE='{font: 9pt arial; text-align:right;}'>"+nf.format(m_gr_sales)+"</TD></TR>");
				out.println("<TR><TD><TD><TD>");
				out.println("<TD WIDTH='100' STYLE='{font: 9pt arial; text-align:right;}'>=======================</TD></TR>");*/
				m_MsgBody =("</TR></TABLE>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				
				m_MsgBody =("<BR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<BR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<BR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TABLE BORDER='0' WIDTH='1000' BGCOLOR='white' STYLE='{ font: 10pt arial;}'>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='500' STYLE='{font: 9pt arial; text-align:left;}'><B></B></TD></TR>");//Adl Capital Ltd.
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TR><TD><TD><TD><TD><TD></TR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TR><TD><TD><TD><TD><TD></TR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TR><TD><TD><TD><TD><TD></TR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TR><TD><TD><TD><TD><TD></TR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TR><TD><TD><TD><TD><TD></TR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TR><TD><TD><TD><TD><TD></TR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TR><TD><TD><TD><TD><TD></TR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TR><TD><TD><TD><TD><TD></TR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TR>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("<TD WIDTH='500' STYLE='{font: 9pt arial; text-align:left;}'></TD></TR>");//Authorized Signatory
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("</TR></TABLE>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				
				//out.println("</DIV>");
				
				//DIV TAG FOR Scrolling Rows (LEFT & RIGHT) AREA TABLE
				//out.println("<DIV STYLE='position: absolute; top: 0; left: 0; width:1700; height: 34'></DIV>");
				
				//DIV TAG FOR Scrolling Columns (UP & DOWN ) AREA TABLE
				//out.println("<DIV STYLE='position: absolute; top: 0; left: 0; width:1700; height: 34'>");
				
				
				// DIV TAG FOR Scrolling Header (UP - DOWN  & LEFT - RIGHT) AREA TABLE
				//out.println("<DIV STYLE='position: absolute; top: 0; left: 0; height: 34'></DIV>");
				m_MsgBody =("</TABLE>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				
				m_MsgBody_text=m_MsgBody_text+eol+eol+eol+"Please note this is a computer generated statement. Please let us know within 7 days of receipt of any discrepancies.";
				m_MsgBody =("<font STYLE='{ font: bold 9pt arial;}' ><B>Please note this is a computer generated statement. Please let us know within 7 days of receipt of any discrepancies.</B></font>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				
				
				m_SendMsgBody=m_SendMsgBody+"<BR><BR><BR><BR><BR>"+"</FORM>"+"</BODY>"+""+"</HTML>";
				//m_MsgBody=("<INPUT TYPE='Text' NAME='TXT_MESSEGE' value=\""+m_SendMsgBody+"\" ");
				//m_MsgBody=("<textarea style='display:none;' NAME='TXT_MESSEGE'>"+m_SendMsgBody+"</textarea> ");remove by waruna 2011-01-12
				
				m_MsgBody=("<font size='7' face='COURIER' ><textarea  style='display:none;' NAME='TXT_MESSEGE'>"+m_MsgBody_text+"</textarea></font> ");//this going to body
				out.println(m_MsgBody);
				m_MsgBody=("<font size='7' face='COURIER' ><textarea style='display:none;' NAME='TXT_MESSEGE2'>"+m_MsgBody_text+"</textarea></font> ");//this going to attach as text
				out.println(m_MsgBody);
				m_MsgBody=("<BR><BR><BR>");
				out.println(m_MsgBody);
				m_MsgBody=("</FORM>");
				out.println(m_MsgBody);
				
				//add by waruna 2011-01-10
				ResultSet rs_rpt_date = stmt.executeQuery ("SELECT TO_CHAR(SYSDATE,'DD-MM-YYYY HH24:MI:SS') FROM DUAL");
				String rpt_run_date="";
				boolean more_rpt_date=rs_rpt_date.next();
				if(more_rpt_date){
					rpt_run_date=rs_rpt_date.getString(1);
				}
				out.println("<TABLE BORDER='0' WIDTH='100' BGCOLOR='white' STYLE='{ font: bold 9pt arial;}'>");
				out.println("<TR><TD>BO - 020 </TD></TR>");
				out.println("<TR><TD>"+m_username+"</TD></TR>");
				out.println("<TR><TD>"+rpt_run_date+" </TD></TR>");
				out.println("</TABLE>");
				
				
				m_MsgBody =("<SCRIPT language1.2='JavaScript' src='"+m_jsp_client_url+"/float_5.js'></SCRIPT>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				m_MsgBody =("</BODY></HTML>");
				m_SendMsgBody=m_SendMsgBody+m_MsgBody;
				out.println(m_MsgBody);
				
				
				
				String mfilename="D:\\SasiaNet_Products\\Dealnet\\TXT_GEN\\ADLMARGIN\\"+m_sys_date;
				String mbank_code_trim="";
				String mbank_code_trim_new="";
				
				//File dir = new File(mfilename);
				
				//dir.mkdirs();
				File dir = new File(mfilename);
				if(!dir.isDirectory()){
					dir.mkdirs();
				}
				
				
				/*new FileOutputStream(mfilename+"\\Bank_Trns-"+m_cdate+".txt");
					String logFile =mfilename+"\\Bank_Trns-"+m_cdate+".txt";
				
				*/	
				new FileOutputStream(mfilename+"\\"+client_code+".txt");
				String logFile =mfilename+"\\"+client_code+".txt";	
				log = new PrintWriter(new FileWriter(logFile, true), true);
				
				log.println(m_MsgBody_text);
				log.close();
				
				
				
				
				
				
				
			}
			
			//=========================================================================================================================			
			
			
			else {
				out.println("Undefined");
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
	
	
	
	public String paddingString(String s, int n, char c, boolean paddingLeft) {
		if (s == null) {
			return s;
		}
		int add = n - s.length(); // may overflow int size... should not be a problem in real life
		if(add <= 0){
			return s;
		}
		StringBuffer str = new StringBuffer(s);
		char[] ch = new char[add];
		Arrays.fill(ch, c);
		if(paddingLeft){
			str.insert(0, ch);
		} else {
			str.append(ch);
		}
		return str.toString();
	}
}
