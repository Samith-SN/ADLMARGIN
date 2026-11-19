--------------------------------------------------------
--  DDL for Procedure DN_USER_REJECT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_USER_REJECT" 
   (
   M_DN_USER            DN_REF_USER.DN_USER%TYPE,
   M_ACTIVE_STATUS      DN_REF_USER.ACTIVE_STATUS%TYPE,
   M_USER               DN_REF_USER.DN_USER%TYPE
   )
AS
CURSOR REF_USER IS
        SELECT  DN_USER, LOC_CODE,SURNAME, OTHER_NAMES, DESIG_CODE,
          SENIOR_LEVEL, A.ACTIVE_STATUS
        FROM DN_REF_USER_BK A 
        WHERE DN_USER=UPPER(M_DN_USER)
        AND A.BK_DATE IN ( SELECT MAX(BK_DATE) FROM DN_REF_USER_BK WHERE DN_USER=UPPER(M_DN_USER)  AND ACTIVE_STATUS IN ('Y','N','T'))
        AND ACTIVE_STATUS IN ('Y','N','T') ; 
        


M_NUMBER VARCHAR(100);
IGNORE            INTEGER;
USER_COUNT    INTEGER;

--------------------------
--------Reject User-------
--------------------------
--------------------------
BEGIN

            DELETE FROM DN_REF_USER_VIEW_ACCESS WHERE  DN_USER=M_DN_USER;
                  
            --DELETE FROM DN_REF_USER WHERE  DN_USER=M_DN_USER;
        
     
     
FOR I IN REF_USER
LOOP            
            UPDATE DN_REF_USER SET
            DN_USER=I.DN_USER, 
            LOC_CODE=I.LOC_CODE,
            SURNAME=I.SURNAME, 
            OTHER_NAMES=I.OTHER_NAMES,
            DESIG_CODE=I.DESIG_CODE,
            SENIOR_LEVEL=I.SENIOR_LEVEL, 
            ACTIVE_STATUS=I.ACTIVE_STATUS
            WHERE DN_USER=UPPER(M_DN_USER);
            --AND A.BK_DATE IN ( SELECT MAX(B.BK_DATE) FROM DN_REF_USER_BK  B GROUP BY DN_USER );    
            
                    
            
            --INSERT INTO DN_REF_USER(DN_USER, LOC_CODE,SURNAME, OTHER_NAMES, DESIG_CODE,
            --      SENIOR_LEVEL, ACTIVE_STATUS)
            --SELECT  DN_USER, LOC_CODE,SURNAME, OTHER_NAMES, DESIG_CODE,
            --  SENIOR_LEVEL, A.ACTIVE_STATUS
            --FROM DN_REF_USER_BK A 
            --WHERE DN_USER=UPPER(M_DN_USER)
            --AND A.BK_DATE IN ( SELECT MAX(B.BK_DATE) FROM DN_REF_USER_BK  B GROUP BY DN_USER )
            --; 
        
 END LOOP;             
              
            INSERT INTO DN_REF_USER_VIEW_ACCESS
            (DN_USER,SCREEN_NAME,SAVE_STATUS,ACCESS_STATUS)
            SELECT DN_USER,SCREEN_NAME,SAVE_STATUS,ACCESS_STATUS
            FROM DN_REF_USER_VIEW_ACCESS_BK WHERE DN_USER=M_DN_USER ;
        
            INSERT INTO DN_DOC_STATUS_LOG( DOC_REF_NO,DOC_TYPE,DOC_STATUS,DN_USER,ENT_DATE,DESCRIPTION)
            VALUES(UPPER(M_DN_USER),'USER','Y',M_USER,SYSDATE,'REJECT USER');


END; 

/
