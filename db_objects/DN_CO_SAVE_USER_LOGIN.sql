--------------------------------------------------------
--  DDL for Procedure DN_CO_SAVE_USER_LOGIN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_CO_SAVE_USER_LOGIN" 
(
M_SESSION_ID 		           VARCHAR2,
M_SESSION_STATUS               VARCHAR2,
M_CLIENT_IP	                   VARCHAR2,
M_LOGIN_STATUS 		           VARCHAR2,
M_SCREEN_NAME 		           VARCHAR2,
M_IN_TIME 		               VARCHAR2,
M_USER 		                   VARCHAR2
)


 AS
/*
ID       : 1.29 LOGIN PROCESS
PROCEDURE: FA_CO_SAVE_USER_LOGIN
SYSTEM   : COMFAC
NAME     : DISNAKA JAYASURIYA
DATE/TIME: 2010-04-19
*/



BEGIN

--AF_CO_VALIDATE_SAVE_RIGHTS('AF_AD_TEAM',M_USER);

IF UPPER(M_SCREEN_NAME)='FA_LOGIN' THEN --NEW
--ADD NEW RECORDS TO TABLE
    INSERT INTO CO_CO_PRO_LOGIN_STATUS(
        USER_ID,          
        SESSION_ID,                   
        LOGIN,                        
        --LOGOUT,                       
        SESSION_STATUS,                 
        CLIENT_IP,                      
        LOGIN_STATUS   
    )                
    VALUES(
        UPPER(M_USER),
        M_SESSION_ID,
        TO_DATE(M_IN_TIME,'DD-MON-YY HH:MI:SS PM'),
        M_SESSION_STATUS,
        M_CLIENT_IP,
        M_LOGIN_STATUS
    );   



ELSIF UPPER(M_SCREEN_NAME)='FA_LOGOUT' THEN 


    --UPDATE RECORDS TO TABLE
    UPDATE CO_CO_PRO_LOGIN_STATUS
    SET                                         
        LOGOUT=SYSDATE,                       
        SESSION_STATUS=M_SESSION_STATUS,                                      
        LOGIN_STATUS=M_LOGIN_STATUS
          
    WHERE USER_ID=UPPER(M_USER); --AND LOGIN=TO_DATE(M_IN_TIME,'DD-MON-YY HH:MI:SS PM') AND CLIENT_IP=M_CLIENT_IP;


    INSERT INTO CO_CO_PRO_LOGIN_STATUS_BK
    (
        USER_ID,          
        SESSION_ID,                   
        LOGIN,                        
        LOGOUT,                       
        SESSION_STATUS,                 
        CLIENT_IP,                      
        LOGIN_STATUS   
        
    )
    SELECT 
        USER_ID,          
        SESSION_ID,                   
        LOGIN,                        
        LOGOUT,                       
        SESSION_STATUS,                 
        CLIENT_IP,                      
        LOGIN_STATUS 
        
    FROM CO_CO_PRO_LOGIN_STATUS
    WHERE UPPER(USER_ID)=UPPER(M_USER);
 
    
    DELETE FROM CO_CO_PRO_LOGIN_STATUS
    WHERE USER_ID=UPPER(M_USER);
    
    
END IF;


END;

/
