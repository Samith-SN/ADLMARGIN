//Option Id is 2.0  
//This File was created by SVA on 17-05-2006 
//COMFAC Common Connection
package net.sasianet.ADLMARGIN;

import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import oracle.jdbc.driver.*;
import java.sql.*;
import sun.misc.BASE64Decoder;
import java.text.DecimalFormat;

import java.util.logging.Level;
import java.util.logging.Logger;

public class ADLMARGIN_MGT_conn_methods  
{
	//java.text.NumberFormat nf;
	Connection out_conn;
	Connection out_lbspecific_con;
	
	public String html_client_url="https://dev-adlmargin.sasianet.com";
	public String html_intranet_url="https://dev-adlmargin.sasianet.com/Intranet";
	public String html_client_home_url="https://dev-adlmargin.sasianet.com";
	public String servlet_client_url="https://dev-adlmargin.sasianet.com";
	public String jsp_client_url="https://dev-adlmargin.sasianet.com:8443/ADLMARGIN/ADLMARGIN";
	//will be blank in future
	public String m_company_schema="";
	public String client_name="ADLMARGIN_";
	public String client_t3_port="8443/ADLMARGIN/servlet";
	//
	public String username;
	//public String password;
	//
	public String company_name="SNET";
	//New for NETFAC
	//String company_code="CLC";
	
	public String schema_name="no-schema";
	//String schema_name="COMFAC";
	
	public String bg_color1   = "#A3B2CC";
	public String bg_color2   = "white";
	public String fo_color1   = "black";
	public String fo_color2   = "black";
	public String header_name = "Margin Trading  Version 1.0.0";
	
	
	//Added by Disnaka on 2010-09-20 (CHANGE THIS VARIABLE VALUES ACCORDING TO SCHEMA NAME)
	
	//String drive ="C:\\";
	//String zip_class="D:\\Oracle\\Ora81\\jdbc\\lib\\classes111.zip;";
	public String file_upload_path             = "D:\\SasiaNet_Products\\DealNet\\ADLMARGIN\\UPLOAD\\";
	public String file_upload_path_img         = "D:\\SasiaNet_Products\\DealNet\\ADLMARGIN\\HOME\\";
	public String file_upload_path_mail_merge  = "D:\\SasiaNet_Products\\DealNet\\ADLMARGIN\\UPLOAD\\MAIL_MERGE\\docs";
	//String schema_name                = "no-schema";
	public String schema_name_1                = "ADLMARGIN";
	String schema_name_2                = "";  
	//////////Added By Disnaka Jayasuriya on 2010-03-23 for change m_company_schema value
	//private String connectionString   = "jdbc:oracle:thin:@147.120.20.1:1521:DEALNET";
	private String connectionString     = "jdbc:oracle:thin:@sasianet-rds1.cxmig8g4ori3.ap-southeast-1.rds.amazonaws.com:1521:NETASSET";
	private String passClc              = "EIGHTITENGPW82";
	private String passLolc             = "";
	
	private String CAMConnectionString  = "jdbc:oracle:thin:@147.120.20.1:1521:SNPDDB";
	private String CAMScheama           = "LBCAM";
	private String passCAM              = "EIGHTITENGPW82";
	
	private String db_ip                = "";
	private String db_port              = "";
	private String pw                   = "";
	private String db_name              = "";
	private String db_user_name			= "";
	
	public ADLMARGIN_MGT_conn_methods(HttpSession session)
	{   
		
		//file_upload_path="D:\\SasiaNet_Products\\NetAsset\\COMFAC\\";
		//LoginUser log_user = (LoginUser) session.getValue("logon.isDone");
		try
		{
			
			String m_username = (String) session.getValue("logon.isDone");
			username          = m_username.toUpperCase();
			String m_company  = (String) session.getValue("logon.company");
			company_name      = m_company.toUpperCase();
			
			String m_sys_date = (String) session.getValue("logon.sysDate");
			String m_cur_date = (String) session.getValue("logon.curDate");
			
			
			//if (company_name.equals("CLC")){
			if (username!=null || username!="")
			{
				
				m_company_schema = company_name;
				html_client_url  = html_client_url+"/"+m_company_schema;
				schema_name      = schema_name_1;
				
				
				header_name="<div><span>Margin Trading System Version 1.0.0</span><span style='position:absolute;right:30px;font-size: 12px;'>User : "+username+"</span> <span  style='position:absolute;right:150px;font-size: 11px;'>System Date: "+m_sys_date+"</span><span  style='position:absolute;right:320px;font-size: 11px;'>Current Date: "+m_cur_date+"</span></div>";
				
			}
			//}
			/*else if (company_name.equals("LOLC")){
				if (username!=null || username!=""){
					m_company_schema=company_name;
					html_client_url=html_client_url+"/"+m_company_schema;
					schema_name=schema_name_2;
				}
				
			}*/
		}
		catch(Exception e)
		{
			e.printStackTrace();
			System.out.println("Mcp username"+username+"company_name"+company_name);
		}	
		
	}	
	public ADLMARGIN_MGT_conn_methods()
	{
		db_ip                = "sasianet-rds1.cxmig8g4ori3.ap-southeast-1.rds.amazonaws.com";
		db_port              = "1521";
		pw                   = "EIGHTITENGPW82";
		db_name              = "NETASSET";
		db_user_name		= "ADLMARGIN";
		schema_name  		=schema_name_1;
	}	
	
	
	public String getCamSchema()
	{
		return  CAMScheama;
		
	}	
	
	public ADLMARGIN_MGT_conn_methods(String user,String company)
	{
		try
		{	
			username=user.toUpperCase();
			company_name=company.toUpperCase();
			
			
			//if (company_name.equals("CLC")){
			if (username!=null || username!="")
			{
				m_company_schema=company_name;
				html_client_url=html_client_url+"/"+m_company_schema;
				schema_name=schema_name_1;
			}
			//}
			/*else if (company_name.equals("LOLC")){
				if (username!=null || username!=""){
					m_company_schema=company_name;
					html_client_url=html_client_url+"/"+m_company_schema;
					schema_name=schema_name_2;
				}
				
			}*/
		}catch(Exception e)
		{
			e.printStackTrace();
		}	
		
	}	
	
	/////
	/////////////////ADDED ON 18-04-2007 /////////////////////////////////////////////////
	
	public String format_text_area_string(String m_string){
		
		String m_temp="";
		String m_char="";
		
		int i=m_string.indexOf("%0D%0A");
		
		if(i==-1){
			m_char=m_string;
		}
		
		m_temp=m_string;
		while(i!=-1){
			m_char=m_temp.substring(0,i)+" "+m_temp.substring(i+6,m_temp.length());
			m_temp=m_char;
			i=m_temp.indexOf("%0D%0A");
		}
		
		return m_char;
	}
	////////////////////END/////////////////////////////////
	
	/* Following method will read posted valued from a html form */
	public String met_formdata(String reqstr,String objectname) {
		
		String curr_str = "";
		try {
			if (reqstr.indexOf(objectname)>-1) {
				int m_lenobject=0;
				int m_reqpos=0;			
				int m_curr_pos=0;
				if(reqstr.indexOf(objectname)==0){
					
					m_lenobject  = (objectname.length());
					m_reqpos     = reqstr.indexOf(objectname+"=")+m_lenobject+1;
					m_curr_pos   = m_reqpos;
					
				} 
				else{
					m_lenobject   = (objectname.length()+1);
					
					if (reqstr.indexOf("&"+objectname+"=")!=-1){
						//m_reqpos = reqstr.indexOf("&"+objectname)+m_lenobject+1; 
						m_reqpos   = reqstr.indexOf("&"+objectname+"=")+m_lenobject+1; 
						m_curr_pos = m_reqpos;
					}else{
						m_reqpos   = reqstr.length();					
						m_curr_pos = m_reqpos; 	
					}
				}
				
				//------------------
				/*		int m_lenobject = (objectname.length());
                        int m_reqpos = reqstr.indexOf(objectname)+m_lenobject+1;
                        int m_curr_pos = m_reqpos;
                        */	
				
				while (m_curr_pos<=reqstr.length()-1 && (reqstr.substring(m_curr_pos,m_curr_pos+1)).compareTo("&")!=0) {
					curr_str = curr_str + reqstr.substring(m_curr_pos,m_curr_pos+1);
					m_curr_pos = m_curr_pos+1;
				}
				
				//while (m_curr_pos<=reqstr.length()-1 && (reqstr.substring(m_curr_pos,m_curr_pos+1)).compareTo("&")!=0) {
				//    curr_str = curr_str + reqstr.substring(m_curr_pos,m_curr_pos+1);
				//	m_curr_pos = m_curr_pos+1;
				//}
				
				
				/*Replace all + chars with spaces as when spaces are sent it gets convered to +*/
				curr_str = curr_str.replace('+',' ');
				/*Routine to check and replace escape characters with the coresponding correct charachers*/
				Vector escape_str  = new Vector();
				escape_str.addElement("%7E");
				escape_str.addElement("%21");
				escape_str.addElement("%23");
				escape_str.addElement("%24");
				escape_str.addElement("%25");
				escape_str.addElement("%5E");
				escape_str.addElement("%26");
				escape_str.addElement("%28");
				escape_str.addElement("%29");
				escape_str.addElement("%60");
				escape_str.addElement("%3D");
				escape_str.addElement("%7B");
				escape_str.addElement("%7D");
				escape_str.addElement("%7C");
				escape_str.addElement("%5B");
				escape_str.addElement("%5D");
				escape_str.addElement("%3A");
				escape_str.addElement("%22");
				escape_str.addElement("%3B");
				escape_str.addElement("%27");
				escape_str.addElement("%3C");
				escape_str.addElement("%3E");
				escape_str.addElement("%3F");
				escape_str.addElement("%2C");
				escape_str.addElement("%20");
				escape_str.addElement("%2F");
				escape_str.addElement("%5C");
				escape_str.addElement("%2B");
				escape_str.addElement("%92");//added by nuwan de silva
				escape_str.addElement("%96");//added by nuwan de silva
				//escape_str.addElement("%09");
				Vector correct_str  = new Vector();
				correct_str.addElement("~");
				correct_str.addElement("!");
				correct_str.addElement("#");
				correct_str.addElement("$");
				correct_str.addElement("%");
				correct_str.addElement("^");
				correct_str.addElement("&");
				correct_str.addElement("(");
				correct_str.addElement(")");
				correct_str.addElement("`");
				correct_str.addElement("=");
				correct_str.addElement("{");
				correct_str.addElement("}");
				correct_str.addElement("|");
				correct_str.addElement("[");
				correct_str.addElement("]");
				correct_str.addElement(":");
				char dubchar[] = {'"'};
				String m_dubstr=new String(dubchar);
				correct_str.addElement(m_dubstr);
				correct_str.addElement(";");
				correct_str.addElement("'");
				correct_str.addElement("<");
				correct_str.addElement(">");
				correct_str.addElement("?");
				correct_str.addElement(",");
				correct_str.addElement(" ");
				correct_str.addElement("/");
				correct_str.addElement("/");
				correct_str.addElement("+");
				correct_str.addElement("'"); //added by nuwan de silva
				correct_str.addElement("-"); //added by nuwan de silva
				//correct_str.addElement("");
				int i=0;
				int pos,escape_pos;
				String chk_str,rep_str;
				while (i<curr_str.length()) {
					if ((curr_str.substring(i,i+1)).equals("%")) {
						chk_str=curr_str.substring(i,i+3);
						escape_pos=escape_str.indexOf(chk_str);
						if (escape_pos>=0) {
							rep_str=(String)correct_str.elementAt(escape_pos);
							curr_str=curr_str.substring(0,i)+rep_str+curr_str.substring(i+3);	
						}
					}    
					i=i+1;
				}
			}//------
		}
		
		catch (Exception ex) {
			
			System.out.println(ex.toString());	
		} 
		
		return curr_str;
		
	}
	
	public String met_unformat_number(String numstr) {
		
		String m_number="";
		for (int i = 0; i < numstr.length(); i++) {
			String oneChar = numstr.substring(i,i+1);
			if (!oneChar.equals(",")) {
				m_number=m_number+oneChar;
			}
		}
		//return nf.format(numstr);
		return m_number;
		
	}
	
	public String XPosition(int x)
	{
		int i;
		String m_space="";
		for(i=0; i<x; i++)
		{
			m_space=m_space+" ";
		}
		return m_space;
		
	}	
	
	
	public String YPosition(int y)
	{
		int i;
		String m_space="";
		for(i=0; i<y; i++)
		{
			m_space=m_space+"\n";
		}
		return m_space;
		
	}	
	
	public String Add_Space(int count1)
	{
		int i;
		String m_space="";
		for(i=0; i<count1; i++)
		{
			m_space=m_space+" ";
		}
		return m_space; 
	}
	
	
	
	/*public String numbersToChar(String obj){
        
        Object[] ar_ones  = new Object[10];
        Object[] ar_tens  = new Object[10];
        Object[] ar_teens = new Object[10];
        
        ar_ones[0]        = "";
        ar_ones[1]        = "One";
        ar_ones[2]        = "Two"; 
        ar_ones[3]		  =	"Three";
        ar_ones[4]        = "Four";
        ar_ones[5]        = "Five";
        ar_ones[6]        = "Six"; 
        ar_ones[7]		  =	"Seven";
        ar_ones[8]        = "Eight";
        ar_ones[9]        = "Nine";
        
        ar_tens[0]        = "";
        ar_tens[1]        = "Ten";
        ar_tens[2]        = "Twenty"; 
        ar_tens[3]		  =	"Thirty";
        ar_tens[4]        = "Forty";
        ar_tens[5]        = "Fifty";
        ar_tens[6]        = "Sixty"; 
        ar_tens[7]		  =	"Seventy";
        ar_tens[8]        = "Eighty";
        ar_tens[9]        = "Ninety";
        
        ar_teens[0]        = "";
        ar_teens[1]        = "Eleven";
        ar_teens[2]        = "Twelve"; 
        ar_teens[3]		   = "Thirteen";
        ar_teens[4]        = "Fourteen";
        ar_teens[5]        = "Fifteen";
        ar_teens[6]        = "Sixteen"; 
        ar_teens[7]		   = "Seventeen";
        ar_teens[8]        = "Eighteen";
        ar_teens[9]        = "Nineteen";
        
        String m_value;
        String m_cents="";
        
        String m_full_str="";
        String m_digit="0";
        int m_length=obj.length();
        m_value=obj.toString();
        int m_dot=obj.indexOf(".");
        if (m_dot!= -1 ) {
            m_cents=obj.substring(m_dot+1,m_length);
            int num = m_cents.length();
            if (num==1) {
                m_cents=m_cents+"0";
            }
            else if (m_cents.length()==2) {
                m_cents=m_cents+"00";
            }
            m_length=m_value.substring(0,m_dot).length();
            m_value=obj.substring(0,m_dot);
        }
        
        
        for (int j=1 ; j<= 15-m_length; j++) {
            m_value="0"+m_value;
        }
        int m_cnt=15-m_length;
        for (int i=m_cnt; i<=14; i++) {
            
            m_digit = m_value.substring(m_cnt,m_cnt+1);
            
            if ((m_cnt)==3) {  // 100,000,000,000
                if (!m_digit.equals("0")) {
                    if ((m_value.substring(m_cnt+1,m_cnt+2).equals("0")) && (m_value.substring(m_cnt+2,m_cnt+3).equals("0"))) { 
                        m_full_str=m_full_str+ar_ones[Integer.parseInt(m_digit)]+" Hundred Billion ";
                        m_cnt+=2;
                        i+=2;
                    }
                    else {
                        m_full_str=m_full_str+ar_ones[Integer.parseInt(m_digit)]+" Hundred ";
                    }
                }
            }
            
            else if (m_cnt==4) {  // 10,000,000,000
                if (!m_digit.equals("0")) {
                    if ((m_value.substring(m_cnt,m_cnt+1).equals("1")) && (m_value.substring(m_cnt+1,m_cnt+2).equals("0"))) { 
                        m_full_str=m_full_str+ar_teens[Integer.parseInt(m_value.substring(m_cnt+1,m_cnt+2))]+" Billion ";
                        m_cnt+=1;
                        i+=1;
                    }
                    else if ( Integer.parseInt(m_value.substring(m_cnt+1,m_cnt+2))==0) { 
                        m_full_str=m_full_str+ar_tens[Integer.parseInt(m_digit)]+" Billion ";
                    }
                    
                    else {
                        m_full_str=m_full_str+ar_tens[Integer.parseInt(m_digit)]+" ";
                    }
                }
            }
            
            else if (m_cnt==5) {  // 1,000,000,000
                if (!m_digit.equals("0")) {
                    m_full_str=m_full_str+ar_ones[Integer.parseInt(m_digit)]+" Billion ";
                }
            }
            
            
            else if ((m_cnt)==6) {  // 100,000,000
                if (!m_digit.equals("0")) {
                    if ((m_value.substring(m_cnt+1,m_cnt+2).equals("0")) && (m_value.substring(m_cnt+2,m_cnt+3).equals("0"))) { 
                        m_full_str=m_full_str+ar_ones[Integer.parseInt(m_digit)]+" Hundred Million ";
                        m_cnt+=2;
                        i+=2;
                    }
                    else {
                        m_full_str=m_full_str+ar_ones[Integer.parseInt(m_digit)]+" Hundred ";
                    }
                }
            }
            
            else if (m_cnt==7) {  // 10,000,000
                if (!m_digit.equals("0")) {
                    if ((m_value.substring(m_cnt,m_cnt+1).equals("1")) && (m_value.substring(m_cnt+1,m_cnt+2).equals("0"))) { 
                        m_full_str=m_full_str+ar_teens[Integer.parseInt(m_value.substring(m_cnt+1,m_cnt+2))]+" Million ";
                        m_cnt+=1;
                        i+=1;
                    }
                    else if ( Integer.parseInt(m_value.substring(m_cnt+1,m_cnt+2))==0) { 
                        m_full_str=m_full_str+ar_tens[Integer.parseInt(m_digit)]+" Million ";
                        m_cnt+=1;
                        i+=1;
                    }
                    else {
                        m_full_str=m_full_str+ar_tens[Integer.parseInt(m_digit)]+" ";
                    }
                }
            }
            
            else if ((m_cnt)==8) {  // 1,000,000
                if (!m_digit.equals("0")) {
                    m_full_str=m_full_str+ar_ones[Integer.parseInt(m_digit)]+" Million ";
                }
            }
            
            else if ((m_cnt)==9) {  // 100,000
                if (!m_digit.equals("0")) {
                    if ((Integer.parseInt(m_value.substring(m_cnt+1,m_cnt+2))==0) && (Integer.parseInt(m_value.substring(m_cnt+2,m_cnt+3))==0)) {
                        m_full_str=m_full_str+ar_ones[Integer.parseInt(m_digit)]+" Hundred Thousand ";
                        m_cnt+=2;
                        i+=2;
                    }
                    else {						
                        m_full_str=m_full_str+ar_ones[Integer.parseInt(m_digit)]+" Hundred ";
                    }
                }
            }
            
            else if ((m_cnt)==10) {  // 10,000
                if (!m_digit.equals("0")) {
                    if (Integer.parseInt(m_value.substring(m_cnt+1,m_cnt+2))==0) { 
                        m_full_str=m_full_str+ar_tens[Integer.parseInt(m_digit)]+" Thousand ";
                        m_cnt+=1;
                        i+=1;
                        //m_cnt+=2;
                    }
                    else if ((m_digit.equals("1")) && (!m_value.substring(m_cnt+1,m_cnt+2).equals("0"))) { 
                        m_full_str=m_full_str+ar_teens[Integer.parseInt(m_value.substring(m_cnt+1,m_cnt+2))]+" Thousand ";
                        m_cnt+=1;
                        i+=1;
                    }
                    else {						
                        m_full_str=m_full_str+ar_tens[Integer.parseInt(m_digit)]+" ";
                    }
                }
            }
            
            else if ((m_cnt)==11) {  
                if (!m_digit.equals("0")) {
                    m_full_str=m_full_str+ar_ones[Integer.parseInt(m_digit)]+" Thousand ";
                }
            }
            
            else if ((m_cnt)==12) {  
                if (!m_digit.equals("0")) {
                    m_full_str=m_full_str+ar_ones[Integer.parseInt(m_digit)]+" Hundred ";
                }
            }
            
            else if ((m_cnt)==13) {  
                if (!m_digit.equals("0")) {
                    if ((m_digit.equals("1")) && (!m_value.substring(m_cnt+1,m_cnt+2).equals("0"))) {
                        m_full_str=m_full_str+ar_teens[Integer.parseInt(m_value.substring(m_cnt+1,m_cnt+2))]+" ";
                        m_cnt+=1;
                        i+=1;
                    }
                    else {
                        m_full_str=m_full_str+ar_tens[Integer.parseInt(m_digit)]+" ";
                    }
                }
            }
            
            else if ((m_cnt)==14) {  
                if (!m_digit.equals("0")) {
                    m_full_str=m_full_str+ar_ones[Integer.parseInt(m_digit)]+" ";
                }
            }
            
            m_cnt++;
        }
        
        
        m_cnt=0;
        if (!m_cents.equals("")){
            for (int i=m_cnt; i<=1; i++) {			
                m_digit = m_cents.substring(m_cnt,m_cnt+1);
                if ((m_cnt)==0) {  // 10
                    if (!m_digit.equals("0")) {
                        if ((m_digit.equals("1")) && (!m_cents.substring(m_cnt+1,m_cnt+2).equals("0"))) {
                            if(!m_full_str.toString().equals(""))
                            {
                                m_full_str=m_full_str+"and "+ar_teens[Integer.parseInt(m_cents.substring(m_cnt+1,m_cnt+2))]+"";
                            }
                            else 
                            {
                                m_full_str=ar_teens[Integer.parseInt(m_cents.substring(m_cnt+1,m_cnt+2))]+"";
                            }
                            m_cnt+=1;
                        }
                        else {
                            m_full_str=m_full_str+"and "+ar_tens[Integer.parseInt(m_digit)]+"";
                        }
                    }
                }
                
                else if ((m_cnt)==1) {  // 1
                    if (!m_digit.equals("0")) {
                        if (m_cents.substring(m_cnt-1,m_cnt).equals("0")) {
                            if(!m_full_str.toString().equals(""))
                            {
                                m_full_str=m_full_str+"and "+ar_ones[Integer.parseInt(m_digit)]+"";						
                            }
                            else
                            {
                                m_full_str=ar_ones[Integer.parseInt(m_digit)]+"";		
                            }
                        }
                        else {
                            m_full_str=m_full_str+ar_ones[Integer.parseInt(m_digit)]+"";	
                        }
                    }
                }
                
                
                m_cnt++;
                if (m_cnt>1){
                    //m_full_str=m_full_str +" cents ";
                }
                
            }
        }
        
        return m_full_str.toString();
        
    }*/
	
	//--------------------------added by Thamali jayatunga on 2011.02.22---------------------
	private static final String[] tensNames = {
		"",
		" Ten",
		" Twenty",
		" Thirty",
		" Forty",
		" Fifty",
		" Sixty",
		" Seventy",
		" Eighty",
		" Ninety"
	};
	private static final String[] numNames = {
		"",
		" One",
		" Two",
		" Three",
		" Four",
		" Five",
		" Six",
		" Seven",
		" Eight",
		" Nine",
		" Ten",
		" Eleven",
		" Twelve",
		" Thirteen",
		" Fourteen",
		" Fifteen",
		" Sixteen",
		" Seventeen",
		" Eighteen",
		" Nineteen"
	};
	
	public static String convert(long number) {
		
		
		// 0 to 999 999 999 999
		if (number == 0) {
			return "Zero";
		}
		
		String snumber = Long.toString(number);
		
		
		// pad with "0"
		String mask = "000000000000";
		DecimalFormat df = new DecimalFormat(mask);
		snumber = df.format(number);
		
		// XXXnnnnnnnnn
		int billions = Integer.parseInt(snumber.substring(0, 3));
		// nnnXXXnnnnnn
		int millions = Integer.parseInt(snumber.substring(3, 6));
		// nnnnnnXXXnnn
		int hundredThousands = Integer.parseInt(snumber.substring(6, 9));
		// nnnnnnnnnXXX
		int thousands = Integer.parseInt(snumber.substring(9, 12));
		
		String tradBillions;
		switch (billions) {
		case 0:
			tradBillions = "";
			break;
		case 1:
			tradBillions = convertLessThanOneThousand(billions) + " Billion ";
			break;
		default:
			tradBillions = convertLessThanOneThousand(billions) + " Billion ";
		}
		String result = tradBillions;
		
		String tradMillions;
		switch (millions) {
		case 0:
			tradMillions = "";
			break;
		case 1:
			tradMillions = convertLessThanOneThousand(millions) + " Million ";
			break;
		default:
			tradMillions = convertLessThanOneThousand(millions) + " Million ";
		}
		result = result + tradMillions;
		
		String tradHundredThousands;
		switch (hundredThousands) {
		case 0:
			tradHundredThousands = "";
			break;
		case 1:
			tradHundredThousands = "One Thousand ";
			break;
		default:
			tradHundredThousands = convertLessThanOneThousand(hundredThousands) + " Thousand ";
		}
		result = result + tradHundredThousands;
		
		String tradThousand;
		tradThousand = convertLessThanOneThousand(thousands);
		result = result + tradThousand;
		
		// remove extra spaces!
		return result.replaceAll("^\\s+", "").replaceAll("\\b\\s{2,}\\b", " ");
	}
	
	private static String convertLessThanOneThousand(int number) {
		String soFar;
		
		if (number % 100 < 20) {
			soFar = numNames[number % 100];
			number /= 100;
		} else {
			soFar = numNames[number % 10];
			number /= 10;
			
			soFar = tensNames[number % 10] + soFar;
			number /= 10;
		}
		if (number == 0) {
			return soFar;
		}
		return numNames[number] + " Hundred" + soFar;
	}
	
	public String numbersToChar(String obj) {
		
		
		String m_value = "";
		String m_cents = "00";
		String numberinWords = "";
		int num = 0;
		int m_dot = -1;
		int m_length = 0;
		long decimal_amount = 0L;
		int cent = 0;
		
		m_length = obj.length();
		m_value = obj.toString();
		m_dot = obj.indexOf(".");
		
		
		if (m_dot != -1) {
			
			m_cents = obj.substring(m_dot + 1, m_length);            //m_cents = obj.substring(m_dot + 1);
			num = m_cents.length();
			m_length = m_value.substring(0, m_dot).length();
			m_value = obj.substring(0, m_dot);
			cent = Integer.parseInt(m_cents);
			
			
			
		}
		
		
		decimal_amount = Long.parseLong(m_value);
		
		
		if (cent != 0) {
			numberinWords = ADLMARGIN_MGT_conn_methods.convert(decimal_amount) + " and " + ADLMARGIN_MGT_conn_methods.convert(cent) + "  cents";
			
			
		} else if (cent == 0) {
			numberinWords = ADLMARGIN_MGT_conn_methods.convert(decimal_amount);
		}
		
		return numberinWords;
	}
	
	//------------------------------------------------
	
	
	//--------------------------------------------------------------------------------------------------------//
	//*************************************************CREATING A	NEW METHOD FOR USER AUTHORIZATION*******	
	
	//optional methos - not required
	public Connection met_user_validate(HttpSession session) 
	{	
		try {
			
			//LoginUser log_user = (LoginUser) session.getValue("logon.isDone");
			//This is not required you can get company name and user name from the crated object
			String m_username = (String) session.getValue("logon.isDone");
			username=m_username.toUpperCase();
			String m_company = (String) session.getValue("logon.company");
			company_name=m_company.toUpperCase();
			
			//here added by  madhawa a note -------------------
			//------------use the session password and create the new connection if the session password will not makes a connection invalidate teh session
			//------------then will create a  logon.isDone will be null any servelet call this method then invalidates the session then can redirect to invalid login page
			
			//if (company_name.equals("CLC")){
			if (username!=null || username!="")
			{
				Class.forName("oracle.jdbc.driver.OracleDriver");
				out_conn = DriverManager.getConnection(connectionString,schema_name_1,passClc);
				schema_name=schema_name_1;
			}
			//System.out.println("met_user_validate(session) connection"+out_conn);
			//}
			/*else if (company_name.equals("LOLC")){
                if (username!=null || username!=""){
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    //out_conn = DriverManager.getConnection("jdbc:oracle:thin:@147.120.20.1:1521:DEALNET","COMFAC","COMFAC123");
                    out_conn = DriverManager.getConnection(connectionString,schema_name_2,passLolc);
                    schema_name=schema_name_2;
                }
                
            }*/
			
			
		}	
		catch (Exception e) 
		{
			
			try 
			{
				e.printStackTrace();
				System.out.println("username"+username+"company_name"+company_name);
				/*ServletOutputStream out = res.getOutputStream();
                    ByteArrayOutputStream ostr = new ByteArrayOutputStream();
                    e.printStackTrace(new PrintStream(ostr));
                    out.println(ostr.toString());
                out.close();	*/	
			}
			catch (Exception e1) 
			{
				
			}
		}
		return out_conn;		
	}
	
	public Connection met_user_validate() {	
		try {
			
			//LoginUser log_user = (LoginUser) session.getValue("logon.isDone");
			
			// if (company_name.equals("CLC")){
			if (username!=null || username!=""){
				Class.forName("oracle.jdbc.driver.OracleDriver");
				out_conn = DriverManager.getConnection(connectionString,schema_name_1,passClc);
				schema_name=schema_name_1;
			}
			//System.out.println("met_user_validate"+out_conn);
			// }
			/*else if (company_name.equals("LOLC")){
                if (username!=null || username!=""){
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    //out_conn = DriverManager.getConnection("jdbc:oracle:thin:@147.120.20.1:1521:DEALNET","COMFAC","COMFAC123");
                    out_conn = DriverManager.getConnection(connectionString,schema_name_2,passLolc);
                    schema_name=schema_name_2;
                }
                
            }*/
			
			
		}	
		catch (Exception e) 
		{
			try 
			{
				e.printStackTrace();
				/*ServletOutputStream out = res.getOutputStream();
                    ByteArrayOutputStream ostr = new ByteArrayOutputStream();
                    e.printStackTrace(new PrintStream(ostr));
                    out.println(ostr.toString());
                out.close();	*/	
			}
			catch (Exception e1) 
			{
				
			}
		}
		return out_conn;		
	}
	public Connection met_user_validate(String com) {	
		try {
			
			
			
			company_name=com.toUpperCase();
			
			//if (company_name.equals("CLC")){
			
			Class.forName("oracle.jdbc.driver.OracleDriver");
			out_conn = DriverManager.getConnection(connectionString,schema_name_1,passClc);
			schema_name=schema_name_1;
			//}
			/*else if (company_name.equals("LOLC")){
                Class.forName("oracle.jdbc.driver.OracleDriver");
                out_conn = DriverManager.getConnection(connectionString,schema_name_2,passLolc);
                schema_name=schema_name_2;
                
                
            }*/
			
			
		}	
		catch (Exception e) {
			try 
			{
				e.printStackTrace();
			}
			catch (Exception e1) {
			}
		}
		return out_conn;		
	}
	
	//2011-10-06 added by madhawa 
	public Connection GetValidUserConnection(String possibleUser,String possiblePwd)
	{
		
		out_lbspecific_con=null;
		
		try
		{
			String copy_possiblePwd="\""+possiblePwd+"\"";//support for Special characters 2011-10-07 enclosed the pwd with ""
			//if(possibleUser,possiblePwd)
			if(possibleUser!=null&&possiblePwd!=null&&possibleUser!=""&&possiblePwd!=null&&possiblePwd!="")
			{
				
				Class.forName("oracle.jdbc.driver.OracleDriver");
				//out_lbspecific_con=DriverManager.getConnection(connectionString,possibleUser,possiblePwd); 2011-10-07
				
				//out_lbspecific_con=DriverManager.getConnection(connectionString,possibleUser,copy_possiblePwd); //added for above 2011-10-07
				out_lbspecific_con=DriverManager.getConnection(connectionString,possibleUser,possiblePwd); 
				schema_name=schema_name_1; //user name and password are invalid so cant create a acount
				
				
			}
			else
			{
				System.out.println("if clause failure at GetValidUserConnection -->___ "+possibleUser+"___"+possiblePwd);
			}	
			
		}
		catch(Exception e)
		{
			out_lbspecific_con=null;
			e.printStackTrace();
			System.out.println("MCP GetValidUserConnection --> "+e.toString()+"possiblePwd >>.. "+possiblePwd+"  possibleUser ..> "+possibleUser);
		}	
		
		
		return out_lbspecific_con;
	}	
	//2011-10-06 end added by madhawa 
	
	public Connection getDirectConnection(){
		
		Connection out_conn = null;
		String     connectionString = null;
		
		//System.out.println(db_port);
		
		try {  
			
			connectionString = "jdbc:oracle:thin:@"+this.db_ip+":"+db_port+":"+this.db_name+""; 
			Class.forName("oracle.jdbc.driver.OracleDriver");
			out_conn = DriverManager.getConnection(connectionString,db_user_name,pw);
			
		} catch (Exception ex) {
			
			Logger.getLogger(ADLMARGIN_MGT_conn_methods.class.getName()).log(Level.SEVERE, null, ex);
			System.out.println("MGT_MGT_conn_methods :: met_user_validate "+ex );
		}
		
		return out_conn;
		
	}
	
	//this method is use for get the connection for client access module
	public Connection getCAMConnection() {	
		try {
			
			if (username!=null || username!=""){ //check this conditions ??????doubtfull
				Class.forName("oracle.jdbc.driver.OracleDriver");
				out_conn = DriverManager.getConnection(CAMConnectionString,CAMScheama,passCAM);
				schema_name = CAMScheama;
			}
		}	
		catch (Exception e) {
			try {
				
			}
			catch (Exception e1) {
			}
		}
		return out_conn;		
	}
	
}




