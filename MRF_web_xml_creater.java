/*
Extract Zip File With Subdirectories Using Command Line Argument Example.
This Java example shows how to extract a zip file and create required
sub-directories using Java ZipInputStream class.

Improment done by Waruna Sri Jayanath 2014-09-27

*/

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipInputStream;


import java.io.*;
import java.util.*;
import java.lang.String;



public class MRF_web_xml_creater {
	
	static String m_path="D:\\SasiaNet_Products\\Tomcat 9_New\\webapps\\ADLMARGIN\\WEB-INF\\classes";   
	//static String m_path="Y:\\Tomcat 9.0\\webapps\\dpmcp\\WEB-INF\\classes";   
	static String m_dfilename ="D:\\SasiaNet_Products\\Tomcat 9_New\\webapps\\ADLMARGIN\\WEB-INF\\web.xml"; 
	//static String m_dfilename ="Y:\\Tomcat 9.0\\webapps\\dpmcp\\WEB-INF\\web.xml"; 
	
	
	public static void main(String[] args) {
		
		PrintWriter log=null;
		
		
		
		StringBuffer buffer = new StringBuffer();
		
		File f1=new File(m_path);
		
		
		
		
		File[] flist;
		flist=f1.listFiles();
		
		
		String m_file_name;
		String m_file_name_org;
		String m_file_path="";
		String m_file_extension="";
		
		//String[] temp = new String[2];
		
		String cmd="";
		
		/*System.out.println("********************************************");
		System.out.println("Directory "+m_path+" *.java");
		System.out.println("Compling with "+m_cmd);
		System.out.println("classpath "+m_classpath);
		System.out.println("********************************************");*/
		
		int j=1;
		
		try{
			
			
			buffer.append("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\r\n");
			buffer.append("<web-app xmlns=\"http://java.sun.com/xml/ns/javaee\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\r\n");
			buffer.append("\txsi:schemaLocation=\"http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd\"\r\n");
			buffer.append("\tversion=\"3.0\" metadata-complete=\"true\">\r\n");
			
			buffer.append("\t<display-name>SASIANET</display-name>\r\n");
			buffer.append("\t<description>");
			buffer.append("SASIANET");
			buffer.append("</description>\r\n");
			
			showFolderRecursively(f1,buffer) ;
			
			/*buffer.append("\t<filter>\r\n");
			buffer.append("\t	<filter-name>loginFilter</filter-name>\r\n");
			buffer.append("\t	<filter-class>net.sasianet.almgt.LoginFilter</filter-class>\r\n");
			buffer.append("\t	</filter>\r\n");
			buffer.append("\t	<filter-mapping>\r\n");
			buffer.append("\t	<filter-name>loginFilter</filter-name>\r\n");
			buffer.append("\t	<url-pattern>/almgt/*</url-pattern>\r\n");
			buffer.append("\t</filter-mapping>\r\n");*/
					
			/*buffer.append("\t<filter>\r\n");
			buffer.append("\t	<filter-name>cORSFilter</filter-name>\r\n");
			buffer.append("\t	<filter-class>net.sasianet.SNTMV01.CORSFilter</filter-class>\r\n");
			buffer.append("\t	</filter>\r\n");
			buffer.append("\t	<filter-mapping>\r\n");
			buffer.append("\t	<filter-name>cORSFilter</filter-name>\r\n");
			buffer.append("\t	<url-pattern>/DPMCP/*</url-pattern>\r\n");
			buffer.append("\t</filter-mapping>\r\n");		
			*/		
					//java.io.FileOutputStream error_file=new java.io.FileOutputStream(m_error_log);
					/*
					for(int i=0;i<flist.length;i++){
						
						if(flist[i].isFile()){
							m_file_path=flist[i].getAbsolutePath();
							m_file_name=flist[i].getName();
							m_file_extension=m_file_name.substring(m_file_name.length()-5);
						
						
							m_file_name_org = m_file_name.substring(0,m_file_name.lastIndexOf("."));  
							
							
							
							if(m_file_extension.toLowerCase().equals("class")){
								
								buffer.append("\t<servlet>\n");
								buffer.append("\t\t<servlet-name>");
								buffer.append(m_file_name_org);
								buffer.append("</servlet-name>\n");
								buffer.append("\t\t<servlet-class>");
								buffer.append(m_file_name_org);
								buffer.append("</servlet-class>\n");
								buffer.append("\t</servlet>\n");
								
								--buffer.append("<servlet-mapping>");
								--buffer.append("<servlet-name>");
								--buffer.append(m_file_name);
								--buffer.append("</servlet-name>");
								--buffer.append("<url-pattern>/servlet/");
								--buffer.append(m_file_name);
								--buffer.append("</url-pattern>");
								--buffer.append("</servlet-mapping>");
								
								//	System.out.println("m_file_name"+m_file_name);
							}
						}
						
						
						
							} */
				
				/*
				for(int i=0;i<flist.length;i++){
					if(flist[i].isFile()){
						m_file_path=flist[i].getAbsolutePath();
						m_file_name=flist[i].getName();
						m_file_extension=m_file_name.substring(m_file_name.length()-5);
						
						
						m_file_name_org = m_file_name.substring(0,m_file_name.lastIndexOf("."));  
						
						
						if(m_file_extension.toLowerCase().equals("class")){
							
							--buffer.append("<servlet>");
							--buffer.append("<servlet-name>");
							--buffer.append(m_file_name);
							--buffer.append("</servlet-name>");
							--buffer.append("<servlet-class>");
							--buffer.append(m_file_name);
							--buffer.append("</servlet-class>");
							--buffer.append("</servlet>");
							
							buffer.append("\t<servlet-mapping>\n");
							buffer.append("\t\t<servlet-name>");
							buffer.append(m_file_name_org);
							buffer.append("</servlet-name>\n");
							buffer.append("\t\t<url-pattern>/servlet/");
							buffer.append(m_file_name_org);
							buffer.append("</url-pattern>\n");
							buffer.append("\t</servlet-mapping>\n");
							
							//	System.out.println("m_file_name"+m_file_name);
						}
					}
					}*/
				
				
				buffer.append("</web-app>");
			File xmlFile = new File(m_dfilename);	
			xmlFile.createNewFile();
			FileOutputStream fos = new FileOutputStream(xmlFile);
			Writer out = new OutputStreamWriter(fos, "UTF8");
			out.write(buffer.toString());
			out.flush();
			out.close();
			fos.close();
			
		}
		catch(Exception e){
			
			System.out.println("Error>>"+e.toString());
			e.printStackTrace();
		}
		
	}
	
	
	private static void showFolderRecursively(File root ,	StringBuffer buffer ) {
		
		System.out.println(root.getAbsolutePath());
		
		String m_absolute_path_name = root.getAbsolutePath();
		int m_root_path_name_legnth = m_absolute_path_name.length(); 
		String m_file_name_org = "";
		String m_file_extension = "";
		String m_file_name = "";
		String m_class_name = "";
		String m_class_name_tmp = "";
		String m_url_pattern = "";
		String m_url_pattern_tmp = "";
		String m_file_extention = "";
		int    m_file_extention_legnth = 0;
		
		File[] files = root.listFiles();
		for (File file : files) {
			if ( file.isFile() ) {
				
				
				m_file_name = file.getName();
				
				System.out.println("shalitha "+m_file_name);
					m_file_name_org = m_file_name.substring(0,m_file_name.lastIndexOf("."));  
				m_file_extention = m_file_name.substring(m_file_name.lastIndexOf(".")); 
				
				m_file_extention_legnth = m_file_extention.length();	
				
				
				
				System.out.println(m_file_name+" *"+m_file_name_org+" *"+m_file_extention);
				
				m_class_name_tmp = (file.getAbsolutePath().substring(m_path.length()+1).toString()).replace("\\",".");
				m_class_name =  m_class_name_tmp.substring(0,m_class_name_tmp.length()-m_file_extention_legnth); 
				
				
				m_url_pattern_tmp =  (file.getAbsolutePath().substring(m_path.length()+1).toString()).replace("\\","/");
				m_url_pattern =  m_url_pattern_tmp.substring(0,m_url_pattern_tmp.length() - m_file_extention_legnth); 
				
				
				
				if(m_file_extention.toLowerCase().equals(".class")){
					
					
					
					buffer.append("\t<servlet>\r\n");
					buffer.append("\t\t<servlet-name>");
					buffer.append(m_file_name_org);
					buffer.append("</servlet-name>\r\n");
					buffer.append("\t\t<servlet-class>");
					buffer.append(m_class_name);
					buffer.append("</servlet-class>\r\n");
					buffer.append("\t</servlet>\r\n");
					
					buffer.append("\t<servlet-mapping>\r\n");
					buffer.append("\t\t<servlet-name>");
					buffer.append(m_file_name_org);
					buffer.append("</servlet-name>\r\n");
					buffer.append("\t\t<url-pattern>/servlet/");
					buffer.append(m_url_pattern);
					buffer.append("</url-pattern>\r\n");
					buffer.append("\t</servlet-mapping>\r\n");
					
				}
				
				
			} else {
				showFolderRecursively(file,buffer);
			}
		}
	}
}





