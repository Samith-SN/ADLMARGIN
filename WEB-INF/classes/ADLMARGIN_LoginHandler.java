/********************************************************
*                                                      *
*                                                      *
*       SCREEN NAME  : COMFAC - LOGIN                  *
*       CREATED BY   : DISNAKA JAYASURIYA              *
*       DATE/TIME:   : 25-03-2010                      *
*                                                      *
********************************************************/
import java.io.*; 
import javax.servlet.*; 
import javax.servlet.http.*;import net.sasianet.ADLMARGIN.*; 
import java.sql.*; 
import java.util.*; 
import javax.servlet.http.HttpSession;



public class ADLMARGIN_LoginHandler extends javax.servlet.http.HttpServlet { 
    String reqstr;
    String m_msg;
    ServletOutputStream out = null;
    private String m_userId;
    private String m_password;
    private String m_company;
    private String  m_screen_name;
    private Connection conn;
    CallableStatement callstmt;
    //for collect m_url
    Statement stmt;
    ResultSet rs;
    
    String m_html_client_url;
    String m_servlet_client_url;
    String m_client_t3_port;
    String m_client_name;
    
    public synchronized void service(HttpServletRequest req, HttpServletResponse res)  throws IOException { 
        
        try { 
            //BufferedReader input = new BufferedReader(new InputStreamReader(req.getInputStream()),2000);
            //reqstr = input.readLine(); 
            
            net.sasianet.ADLMARGIN.ADLMARGIN_MGT_conn_methods m_init_methods = new net.sasianet.ADLMARGIN.ADLMARGIN_MGT_conn_methods(); //here no data connection is generated only the intializing of m_schema_name,url path,occures,
            String html_client_home_url   =  m_init_methods.html_client_home_url.trim();
			String jsp_client_url         =  m_init_methods.jsp_client_url.trim();
            String m_class_url            =  m_init_methods.servlet_client_url.trim()+":"+m_init_methods.client_t3_port.trim(); 
            String m_fschema_name         =  m_init_methods.client_name.trim();
            //New for ADLMARGIN
            String m_company_name         =  m_init_methods.company_name.trim();
            
           
            
            net.sasianet.ADLMARGIN.ADLMARGIN_MGT_conn_methods m_sn_methods = new net.sasianet.ADLMARGIN.ADLMARGIN_MGT_conn_methods(); 
            res.setContentType("text/html"); 
            out = res.getOutputStream(); 
            
            m_msg = "'Your login and password are invalid'";
            
            m_screen_name = req.getParameter("screen_name");
            
           // m_userId=(String)m_sn_methods.met_formdata(reqstr,"username"); 
           // m_password=(String)m_sn_methods.met_formdata(reqstr,"password"); 
		   //here @ sign is decoded use the req,getParameter method instead
			 				 
			m_userId=(String)req.getParameter("username"); //use req.getParameter()
            m_password=(String)req.getParameter("password");
			System.out.println("m_screen_name"+m_screen_name+"begin of login handler"+m_userId+"m_password"+m_password);
			
			//when log out process calls this service method these parameters are not set
			//there for might occur errors with nulll pointer exceptions
			//avoid any lines of codes for with above variable in logout situation
	        
						
            //m_company=(String)m_sn_methods.met_formdata(reqstr,"company");
            m_company = m_company_name;
            HttpSession session = req.getSession(true);
            //This section handles the logout process
			
            if (req.getParameter("logout") != null) 
			{
                
              // System.out.println("begin of log out section m_userId "+m_userId+"m_password"+m_password);
                String grouptype = req.getParameter("groupby");
                if (grouptype == null )
				{
                    grouptype = "NEXT_ACTION" ;
                } 
                
                
                Cookie c = new Cookie("DIARY", grouptype);
                c.setMaxAge(365 * 24 * 60 * 60);
                res.addCookie(c);
                                
                //new
                Object done = (String)session.getValue("logon.isDone");  
                if (done != null) 
				{
                    
					
                    net.sasianet.ADLMARGIN.ADLMARGIN_MGT_conn_methods m_sn_methods_logout = new net.sasianet.ADLMARGIN.ADLMARGIN_MGT_conn_methods(session); 
                    conn =m_sn_methods_logout.met_user_validate();
                    String m_schema_name = m_sn_methods_logout.schema_name.trim();
                    
                    
                    String m_log_time = (String)session.getValue("logon.time");
                    m_userId = (String)session.getValue("logon.isDone");
                    
                    
                    
                    callstmt=conn.prepareCall("BEGIN "+m_schema_name+".DN_CO_SAVE_USER_LOGIN(:1,:2,:3,:4,:5,:6,:7); END;");
                    
                    callstmt.setString(1,session.getId().trim());
                    callstmt.setString(2,"CLOSE");
                    callstmt.setString(3,req.getRemoteAddr());
                    callstmt.setString(4,"LOGOUT");
                    callstmt.setString(5,"FA_LOGOUT");
                    callstmt.setString(6,m_log_time);
                    callstmt.setString(7,m_userId);
                    callstmt.execute();
                    callstmt.close();
                    
                    
                    //commented by disnaka on 2010-07-22
                    /*Cookie c = new Cookie("COM_VALID", "");
                    c.setMaxAge( 0 );
                    res.addCookie(c);*/
                    
                    session.invalidate(); //make servlet engine forget the session
                    
                    //add by disnaka on 2010-07-22
                    /*Cookie[] cookies = req.getCookies();
                    if (cookies != null) {
                        for (int i = 0; i < cookies.length; i++) {
                            if (cookies[i].getName().equals("JSESSIONID")) {
                            cookies[i].setMaxAge(0);
                            res.addCookie(cookies[i]);
                            break;
                            }
                        }
                    }*/
                    
                    if(conn!=null)
					{
						try
						{
							conn.close(); 
						}catch(Exception e)
						{
						}
					}
                    
                    out.println("<HTML><HEAD>");
                    out.println("<SCRIPT language='JavaScript'>");
                    //out.println("top.location.href='http://www.comfac.lk/login.jsp';");
                    out.println("top.location.href='"+jsp_client_url+"/login.jsp' ;");
                    out.println("</SCRIPT></HEAD>");
                    out.println("<body onload=''></body>");
                    out.println("</html>");
                    
                    out.flush();  
                    return;
                }
                else
				{
                    out.println("<HTML><HEAD>");
                    out.println("<SCRIPT language='JavaScript'>");
                    out.println("function displaymsg() {");
                    out.println("alert('Your login expired or invalid login' );");
                    out.println("top.location.href='"+jsp_client_url+"/login.jsp?msg=connection_not_created' ;");
                    out.println("}</SCRIPT></HEAD>");
                    out.println("<body onload='displaymsg();'></body>");
                    out.println("</html>");
                    out.flush();
                    return;
                }
            }
            // end of logout section
            
            // This section checks the validity of user
			//System.out.println("m_company"+m_company);
            if (!allowUser(req)) 
			{
                out.println("<HTML><HEAD>");
                out.println("<SCRIPT language='JavaScript'>");
                out.println("function displaymsg() {");
                out.println("alert("+m_msg+");");
                out.println("window.location.href='"+jsp_client_url+"/login.jsp?msg=user_not_allow' ;");
                out.println("}</SCRIPT></HEAD>");
                out.println("<body onload='displaymsg();'></body>");
                out.println("</html>");
                
                out.flush();
                return;
            } else 
			{
                //added by disnaka on 2010-07-22 for check new session
                /*if (!session.isNew()){
                    session.invalidate();
                    session = req.getSession(true);
                }*/
                
                
                
                // Valid login. Make a note in the session object.
                ADLMARGIN_LoginUser log_user = new ADLMARGIN_LoginUser(m_userId,m_company);
                
                
                
                
                
                try {
                    net.sasianet.ADLMARGIN.ADLMARGIN_MGT_conn_methods m_sn_methods_url = new net.sasianet.ADLMARGIN.ADLMARGIN_MGT_conn_methods(); 
                    conn =m_sn_methods_url.met_user_validate(m_company);
                    String m_schema_name = m_sn_methods_url.schema_name.trim();
                    stmt=conn.createStatement();
                    //stmt1=conn.createStatement();
                    
                    
                    
                    //--------------------------------------------------
                    //Adde by Disnaka Jayasuriya to avoid duplicate logins in seperate ip addresses
                    rs= stmt.executeQuery (" SELECT LOGIN_STATUS,CLIENT_IP FROM "+m_schema_name+".CO_CO_PRO_LOGIN_STATUS WHERE UPPER(USER_ID)=UPPER('"+log_user.getUserID()+"') ");
                    
                    String m_login_status="FIRST-LOG";
                    String m_client_ip = "";
                    while(rs.next()){
                        m_login_status = rs.getString(1);
                        m_client_ip = rs.getString(2);
                    }
                    
                    //Commented by Disnaka on 2010-07-27 for temp.Uncomment this
                    /*if (m_login_status.equals("LOG") && !m_client_ip.equals(req.getRemoteAddr()) ){  
                        
                        session.invalidate();
                        out.println("<HTML><HEAD>");
                        out.println("<SCRIPT language='JavaScript'>");
                        out.println("function displaymsg() {");
                        out.println("alert(\"User has already logged in with different IP address.\");");
                        out.println("window.location.href='http://www.comfac.lk/login.jsp';");
                        out.println("}</SCRIPT></HEAD>");
                        out.println("<body onload='displaymsg();'></body>");
                        out.println("</html>");
                        
                        out.flush();
                        return;
                    }*/
                    //-----------------------------------------------------------
                    
                    
                    rs= stmt.executeQuery (
						/*" SELECT A.SCREEN_URL "+
                        " FROM   "+m_schema_name+".CO_CO_MAS_USER_SCREEN A, "+m_schema_name+".FA_CO_MAS_USER_ACCESS B "+
                        " WHERE  UPPER(A.SCREEN_NAME)=UPPER(B.SCREEN_NAME) AND "+
                        " B.ACCESS_STATUS='Y' AND "+
                        " UPPER(B.USER_ID)=UPPER('"+log_user.getUserID()+"') "*/
						
						" SELECT A.DN_SCREEN_URL "+ 
                        " FROM   "+m_schema_name+".DN_REF_SCREEN_URL A, "+m_schema_name+".DN_REF_USER_VIEW_ACCESS B "+
                        " WHERE  UPPER(A.DN_SCREEN_NAME)=UPPER(B.SCREEN_NAME) AND "+
                        " B.SAVE_STATUS='Y' AND "+
                        " UPPER(B.DN_USER)=UPPER('"+log_user.getUserID()+"') "
						
						);
                    
                    int m_index;
                    String m_servlet_name="";
                    
                    while(rs.next())
					{
                        m_servlet_name = rs.getString(1);
                        m_servlet_name = m_fschema_name + m_servlet_name; 
                        m_index = m_servlet_name.lastIndexOf("?");
                        if (m_index !=-1){
                            m_servlet_name = m_servlet_name.substring(0,m_index);
                        }
                        log_user.setUserScreens(m_servlet_name);
                    }
                    
                    
                    session.putValue("logon.isDone", log_user.getUserID());
                    session.putValue("logon.company", log_user.getUserCompany ());
                    session.putValue("logon.screen", log_user.userScreens);
                    //new
                    
                    rs= stmt.executeQuery ("SELECT TO_CHAR(SYSDATE, 'DD-MON-YY HH:MI:SS PM') FROM DUAL");
                    String m_in_time="";
                    while(rs.next()){
                        m_in_time = rs.getString(1);
                    }
                    
                    session.putValue("logon.time", m_in_time);
                    
                  
                    
                    rs= stmt.executeQuery ("SELECT TO_CHAR(LAST_DAILY + 1, 'DD-MON-YYYY') FROM "+m_schema_name+".DN_SYS_PARAMETER ");
                    String m_sys_date="";
                    while(rs.next()){
                        m_sys_date = rs.getString(1);
                    }
                    
                    session.putValue("logon.sysDate", m_sys_date);
                    
                    
                    rs= stmt.executeQuery ("SELECT TO_CHAR(SYSDATE, 'DD-MON-YYYY') FROM DUAL ");
                    String m_cur_date="";
                    while(rs.next()){
                        m_cur_date = rs.getString(1);
                    }
                    
                    session.putValue("logon.curDate", m_cur_date);
                    
                    //Date now = new Date();
                    //String DATE_FORMAT = "dd-mm-yyyy hh:mm:ss";
                    //SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
                    
                    //String strDateNew = sdf.format(now) ;
                    
                    session.putValue("logon.time", m_in_time);
                    // Add new cookie for save session id to avoid browser crashs
                    /*commented by Dianaka on 2010-07-22
                    String sessionid = session.getId().trim();
                    Cookie c = new Cookie("COM_VALID", sessionid);
                    c.setMaxAge( 2 * 24 * 60 * 60 );
                    
                    res.addCookie(c);
                    
                    
                    */
                    //
                    /*Cookie[] cookies = req.getCookies();
                    if (cookies != null) {
                        for (int i = 0; i < cookies.length; i++) {
                            if (cookies[i].getName().equals("JSESSIONID")) {
                            cookies[i].setMaxAge(-1);
                            res.addCookie(cookies[i]);
                            break;
                            }
                        }
                    }*/
                    /* Cookie c1 = new Cookie("JSESSIONID", sessionid);
                    c1.setMaxAge(-1);
                    
                    res.addCookie(c1);//
                    //*/
                    
                    
                    
                    
                    
                    callstmt=conn.prepareCall("BEGIN "+m_schema_name+".DN_CO_SAVE_USER_LOGIN(:1,:2,:3,:4,:5,:6,:7); END;");
                    
                    if (m_login_status.equals("FIRST-LOG"))
					{   
                        
                        callstmt.setString(1,session.getId().trim());
                        callstmt.setString(2,"OPEN");
                        callstmt.setString(3,req.getRemoteAddr());
                        callstmt.setString(4,"LOG");
                        callstmt.setString(5,"FA_LOGIN");
                        callstmt.setString(6,m_in_time);
                        callstmt.setString(7,log_user.getUserID());
                        callstmt.execute();
                        //callstmt.close();
                    }
                    else if (m_login_status.equals("LOG"))
					{  
                        
                        callstmt.setString(1,session.getId().trim());
                        callstmt.setString(2,"CLOSE");
                        callstmt.setString(3,req.getRemoteAddr());
                        callstmt.setString(4,"LOGOUT");
                        callstmt.setString(5,"FA_LOGOUT");
                        callstmt.setString(6,m_in_time);
                        callstmt.setString(7,m_userId);
                        callstmt.execute();
                        //callstmt.close();
                        
                        callstmt.setString(1,session.getId().trim());
                        callstmt.setString(2,"OPEN");
                        callstmt.setString(3,req.getRemoteAddr());
                        callstmt.setString(4,"LOG");
                        callstmt.setString(5,"FA_LOGIN");
                        callstmt.setString(6,m_in_time);
                        callstmt.setString(7,log_user.getUserID());
                        callstmt.execute();
                        
                    }
                    
                    
                    //conn.close();
                }
                catch (Exception e) 
				{
					e.printStackTrace();
                    out.println("Exception in a valid login section"+e.toString());
                }
                
                
                //try {
                //out.println("<HTML><HEAD>");
                //out.println("<SCRIPT language='JavaScript'>");
                
                
                //out.println("window.location.href='http://www.comfac.lk:8443/ADLMARGIN/servlet/ADLMARGIN_AF_CO_Main_Menu';");
                
                //out.println("window.open('http://www.comfac.lk:8443/ADLMARGIN/servlet/ADLMARGIN_AF_CO_Main_Menu','AFS');");
                //Commented by Disnaka Jayasuriya on 2010-11-10
                //out.println("window.open('"+m_class_url+"/"+m_fschema_name+"AF_CO_Main_Menu','AFS');");
                // out.println("window.location.href='"+m_class_url+"/"+m_fschema_name+"AF_CO_Main_Menu';");
                
                
                //} catch (Exception ignored) {
                // }
                
                
                try {
                    String target = (String) session.getValue("login.target");
                    if (target != null) {
                        session.putValue("login.target",null);
                        out.println("<html><head>");
                        out.println("<script language='JavaScript'>");
                        out.println("function redirect() {");
                        out.println("window.location.href='"+target+"'");
                        out.println("window.opener.location.href='"+m_class_url+"/"+m_fschema_name+"MGT_Main_Menu';");
                        out.println("}</script></head>");
                        out.println("<body onload='redirect();'></body>");
                        out.println("</html>");
                        return;
                    }
                    else{
                        out.println("<html><head>");
                        out.println("<script language='JavaScript'>");
                        out.println("function direct() {");
                        out.println("window.location.href='"+m_class_url+"/"+m_fschema_name+"MGT_Main_Menu';");
                        out.println("}</script></head>");
                        out.println("<body onload='direct();'></body>");
                        out.println("</html>");
                        return;
                    }
                    
                }
                catch (Exception ignored) { }
                
                
                
                
                /* try {
                    out.println("<HTML><HEAD>");
                    out.println("<SCRIPT language='JavaScript'>");
                    
                    out.println("window.location.href='"+m_class_url+"/"+m_fschema_name+"MGT_Main_Menu';");
                    //out.println("window.open('http://www.comfac.lk:8443/ADLMARGIN/servlet/ADLMARGIN_MGT_Main_Menu','AFS');");
                    out.println("</SCRIPT></HEAD>");
                    out.println("<body onload=''></body>");
                    out.println("</html>");
                    
                    out.flush();	
                    
                } catch (Exception ignored) {
                }*/
                
                // Couldn't redirect to the target. Redirect to the site's home page.
                
                
                
                /*out.println("<HTML><HEAD>");
                out.println("<SCRIPT language='JavaScript'>");
                out.println("window.location.href='"+jsp_client_url+"/login.jsp' ;");
                out.println("</SCRIPT></HEAD>");
                out.println("<body onload=';'></body>");
                out.println("</html>");
                out.flush();*/
                //res.sendRedirect("http://www.comfac.lk/login_new.htm");
            }
        }
        catch (Exception ex) 
		{
            try
			{
				ex.printStackTrace();
				out.println("Error: loginhandler"+ex.toString());
				
			}catch(Exception e)
			{
				
			}
        }
        finally{
            if(out!=null){try{out.close();  }catch(Exception e){}}
            if(rs!=null){try{rs.close();  }catch(Exception e){}}
            if(stmt!=null){try{stmt.close();  }catch(Exception e){}}
            if( callstmt!=null){try{ callstmt.close();  }catch(Exception e){}}
            if(conn!=null){try{conn.close();  }catch(Exception e){}}
            
        }
    }
    //End  of service method
    
    // This method check login is valid or not . If login is valid it retuns true and otherwise false
    protected boolean allowUser(HttpServletRequest req) throws IOException {
        int count=0;
        String scrname=""; 
        try { 
            
			
            net.sasianet.ADLMARGIN.ADLMARGIN_MGT_conn_methods m_sn_methods = new net.sasianet.ADLMARGIN.ADLMARGIN_MGT_conn_methods();
			//conn = m_sn_methods.met_user_validate(m_company);  commented by madhawa 2011-10-06 replaced with below try to create an account with submitted user name and password
			
			System.out.println("one line before GetValidUserConnection in allow user method"+m_userId.toUpperCase()+"...");
			//conn=m_sn_methods.GetValidUserConnection(m_userId.toUpperCase(),m_password);//added madhawa 2011-10-06
			conn=m_sn_methods.getDirectConnection();
			System.out.println(" mcp inside allow user conn"+conn);
            String m_schema_name = m_sn_methods.schema_name.trim();
            m_html_client_url = m_sn_methods.html_client_url;
            m_servlet_client_url=m_sn_methods.servlet_client_url;
            m_client_t3_port=m_sn_methods.client_t3_port;
            m_client_name=m_sn_methods.client_name;
           
			//System.out.println(" mcp inside allow user conn"+conn);
			
			if(conn!=null) //ADDED 2011-10-06
			{
				
			
				//System.out.println("m_userId.toUpperCase()"+m_userId.toUpperCase());
				//System.out.println("m_password.toUpperCase()"+m_password.toUpperCase());
				//System.out.println("m_screen_name"+m_screen_name);
				//System.out.println("req.getRemoteAddr()"+req.getRemoteAddr());
	            callstmt =	conn.prepareCall( "BEGIN "+m_schema_name+".DN_LOGIN_OK(:1,:2,:3,:4,:5,:6); END;");//AF_CO_LOGIN
	            callstmt.setString(1,m_userId.toUpperCase());
	           // callstmt.setString(2,m_password.toUpperCase());
				callstmt.setString(2,new MGT_encrypt().getSHA256(m_userId.toUpperCase()+m_password));
	            callstmt.registerOutParameter(3,java.sql.Types.INTEGER);
	            callstmt.registerOutParameter(4,java.sql.Types.CHAR);
	            callstmt.setString(5,m_screen_name);
	            callstmt.setString(6,req.getRemoteAddr());
           		// callstmt.setString(7,m_company.toUpperCase());
            	callstmt.execute();
                
            	count   = callstmt.getInt(3);
            	scrname = callstmt.getString(4);
           		callstmt.close();
				//System.out.println("count"+count);	
				
			}
			else
			{
				//handle invalid ORACLE DATA BASE USER
				count=0; //ADDED 2011-10-06
			}

            
            //System.out.println("m_userId.toUpperCase()="+m_userId.toUpperCase()+"**"+m_screen_name+"**count="+count+"**scrname="+scrname);
            
            if (count==1) 
			{
                
                return true; 
            }
            else
            {
                return false;
            }
            
            
        }
        
        
        catch (Exception e) 
		{
			e.printStackTrace();
            System.out.println("Exception MCP in allowUser user Name:"+m_userId.toUpperCase()+"...m_password"+m_password);
            return false;
            
        }finally
		{
            if( callstmt!=null){try{ callstmt.close();  }catch(Exception e){}}
            if(conn!=null){try{conn.close();  }catch(Exception e){}}
        }
        
        
    }
    //End  of method
    
}
//End of class

