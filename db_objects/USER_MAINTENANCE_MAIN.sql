--------------------------------------------------------
--  DDL for Procedure USER_MAINTENANCE_MAIN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."USER_MAINTENANCE_MAIN" 
  ( M_SCRNAME                       VARCHAR2,
    M_DN_USER                       DN_REF_USER.DN_USER%TYPE,
    M_PASSWORD                      VARCHAR2,
    M_SURNAME                       DN_REF_USER.SURNAME%TYPE,
    M_OTHER_NAMES                   DN_REF_USER.OTHER_NAMES%TYPE,
    M_LOC_CODE                      DN_REF_USER.LOC_CODE%TYPE,
    M_DESIG_CODE                    DN_REF_USER.DESIG_CODE%TYPE,
    M_SENIOR_LEVEL                  DN_REF_USER.SENIOR_LEVEL%TYPE,
    M_CHAPSS                        VARCHAR2,
    M_USER                          VARCHAR2
  )
  AS

     MAIN_CUR          INTEGER;
     IGNORE            INTEGER;
     



           -- PROCEDURE    : TO SAVE NEW USERS AND PASSWORD
           -- SYSTEM       : BOND INDEX SYSTEM
           -- CREATED BY   : NIRMALA FERNANDO
           -- CREATED ON   : 12/02/2001

   BEGIN

   DN_VALIDATE_SAVE_RIGHTS(M_USER,'WD_Users');  --added by ashini on 31/10/2005 for sr0509-047

   --RAISE_APPLICATION_ERROR(-20201,M_CHE_APP);

  ----------------------------------------------crate password----------------------------------------
    MAIN_CUR:=DBMS_SQL.OPEN_CURSOR;

    IF M_SCRNAME='ADD' THEN
    
          
          --DBMS_SQL.PARSE(MAIN_CUR,
          --     'CREATE USER '||UPPER(M_DN_USER)||' IDENTIFIED BY '||UPPER(M_PASSWORD)||
          --     ' DEFAULT TABLESPACE ADLMARGIN  PROFILE DEFAULT',DBMS_SQL.V7);
          --     IGNORE:=DBMS_SQL.EXECUTE(MAIN_CUR);
          -- COMMENTED ABOVE AND ADD BELOW MADHAWA 2011-10-05 TO SUPPORT SPECIAL CHARACTERS IN ORACLE PASSWORDS
          DBMS_SQL.PARSE(MAIN_CUR,
               'CREATE USER '||UPPER(M_DN_USER)||' IDENTIFIED BY '||UPPER(M_PASSWORD)||
               ' DEFAULT TABLESPACE ADLMARGIN  PROFILE DEFAULT',DBMS_SQL.V7);
               IGNORE:=DBMS_SQL.EXECUTE(MAIN_CUR);

          DBMS_SQL.PARSE(MAIN_CUR,
               'GRANT CONNECT TO '||M_DN_USER,DBMS_SQL.V7);
               IGNORE:=DBMS_SQL.EXECUTE(MAIN_CUR);

          DBMS_SQL.PARSE(MAIN_CUR,
                    'GRANT ADLMARGIN_MAIN,ADLMARGIN_ALL TO '||UPPER(M_DN_USER),DBMS_SQL.V7);
                    IGNORE:=DBMS_SQL.EXECUTE(MAIN_CUR);

          ----ADD BY INDITHA 2005-6-14
            UPDATE DN_REF_PASSWORD_UPDATE
            SET    ENT_DATE = SYSDATE
            WHERE  DN_USER  = UPPER(M_DN_USER) ;

            IF SQL%NOTFOUND THEN

                INSERT INTO  DN_REF_PASSWORD_UPDATE ( DN_USER , ENT_DATE)
                VALUES(UPPER(M_DN_USER),SYSDATE);

            END IF;
            --------------

    END IF;

------------------------------------------update or insert a user-------------------------------------------------------

  IF M_SCRNAME='ADD' OR M_SCRNAME='MOD' OR M_SCRNAME='REA' THEN
    
       --bk add by waruna 2010-12-31
         insert into dn_ref_user_bk(dn_user, loc_code,surname, other_names, desig_code,
              senior_level, active_status,bk_user,BK_date)
         SELECT  dn_user, loc_code,surname, other_names, desig_code,
          senior_level, a.active_status,M_USER,sysdate
         FROM dn_ref_user a where dn_user=UPPER(M_DN_USER);
    --RAISE_APPLICATION_ERROR(-20201,'**'||M_CHAPSS||'***');
     IF M_CHAPSS='CHA' THEN
         SYS.DBMS_SQL.PARSE(MAIN_CUR,
         'ALTER USER '||UPPER(M_DN_USER)||' IDENTIFIED BY '||UPPER(M_PASSWORD),DBMS_SQL.V7);
         IGNORE:=SYS.DBMS_SQL.EXECUTE(MAIN_CUR);
     END IF;

         UPDATE DN_REF_USER
         SET    DN_USER=M_DN_USER,
                SURNAME=M_SURNAME,
                OTHER_NAMES=M_OTHER_NAMES,
                LOC_CODE=M_LOC_CODE,
                DESIG_CODE=M_DESIG_CODE,
                ACTIVE_STATUS = 'Y',-- ADDED BY  CHANDANA ON THE 16.10.2006 VC06/020 
                SENIOR_LEVEL=M_SENIOR_LEVEL
         WHERE  UPPER(DN_USER)=UPPER(M_DN_USER);

             IF SQL%NOTFOUND THEN
               INSERT INTO DN_REF_USER
                   (DN_USER,SURNAME,OTHER_NAMES,LOC_CODE,DESIG_CODE,SENIOR_LEVEL)
                VALUES
                   (UPPER(M_DN_USER),UPPER(M_SURNAME),M_OTHER_NAMES,M_LOC_CODE,M_DESIG_CODE,M_SENIOR_LEVEL);
             END IF;
             
             
             
       -- ADDED BY  CHANDANA ON THE 16.10.2006 VC06/020           
        ELSIF      M_SCRNAME='DEA' THEN
       
         --bk add by waruna 2010-12-31
         insert into dn_ref_user_bk(dn_user, loc_code,surname, other_names, desig_code,
              senior_level, active_status,bk_user,BK_date)
         SELECT  dn_user, loc_code,surname, other_names, desig_code,
          senior_level, a.active_status,M_USER,sysdate
         FROM dn_ref_user a where dn_user=UPPER(M_DN_USER);
       
         UPDATE DN_REF_USER
         SET   ACTIVE_STATUS = 'N'
         WHERE  DN_USER=UPPER(M_DN_USER);
       -- END BY  CHANDANA ON THE 16.10.2006 VC06/020 
       
       -- Added by Udara on 23-05-2011
       ELSIF      M_SCRNAME='UTE' THEN
       
            insert into dn_ref_user_bk(dn_user, loc_code,surname, other_names, desig_code,
              senior_level, active_status,bk_user,BK_date)
            SELECT  dn_user, loc_code,surname, other_names, desig_code,
            senior_level, a.active_status,M_USER,sysdate
            FROM dn_ref_user a where dn_user=UPPER(M_DN_USER);
            
            UPDATE DN_REF_USER
            SET   ACTIVE_STATUS = 'C'
            WHERE  DN_USER=UPPER(M_DN_USER);
       
       -- End by Udara on 23-05-2011
             
             
  END IF;

------------------------------------------------------------------------------------------------------------
 
-----------------------------------Overide method by waruna For Dual Autho 2010-12-28-----------------------------------------------------------
  
 IF M_SCRNAME='ADD' and UPPER(M_DN_USER)<>'LBMGTALL'  then
 
         UPDATE DN_REF_USER
         SET    ACTIVE_STATUS = 'E'
         WHERE  DN_USER=UPPER(M_DN_USER);
         
 INSERT INTO dn_doc_status_log( DOC_REF_NO,DOC_TYPE,DOC_STATUS,DN_USER,ENT_DATE,DESCRIPTION)
 VALUES(UPPER(M_DN_USER),'USER','E',M_USER,SYSDATE,'ENTER USER');

 
  ELSIF M_SCRNAME='MOD' and UPPER(M_DN_USER)<>'LBMGTALL' then
  
     UPDATE DN_REF_USER
     SET    ACTIVE_STATUS = 'M'
     WHERE  DN_USER=UPPER(M_DN_USER);
  

  
 INSERT INTO dn_doc_status_log( DOC_REF_NO,DOC_TYPE,DOC_STATUS,DN_USER,ENT_DATE,DESCRIPTION)
 VALUES(UPPER(M_DN_USER),'USER','M',M_USER,SYSDATE,'MODIFY USER');
  
  
  
  
  
  ELSIF M_SCRNAME='REA' and UPPER(M_DN_USER)<>'LBMGTALL' THEN
    

         UPDATE DN_REF_USER
         SET    ACTIVE_STATUS = 'A'
         WHERE  DN_USER=UPPER(M_DN_USER);
         
 INSERT INTO dn_doc_status_log( DOC_REF_NO,DOC_TYPE,DOC_STATUS,DN_USER,ENT_DATE,DESCRIPTION)
 VALUES(UPPER(M_DN_USER),'USER','A',M_USER,SYSDATE,'REACTIVE USER');
                  
   ELSIF M_SCRNAME='DEA' and UPPER(M_DN_USER)<>'LBMGTALL' THEN
         UPDATE DN_REF_USER
         SET   ACTIVE_STATUS = 'D'
         WHERE  DN_USER=UPPER(M_DN_USER);
         
 INSERT INTO dn_doc_status_log( DOC_REF_NO,DOC_TYPE,DOC_STATUS,DN_USER,ENT_DATE,DESCRIPTION)
 VALUES(UPPER(M_DN_USER),'USER','D',M_USER,SYSDATE,'DEACTIVE USER');
 
 
 -- Added by Udara on 23-05-2011
 ELSIF M_SCRNAME='UTE' and UPPER(M_DN_USER)<>'LBMGTALL' THEN
         UPDATE DN_REF_USER
         SET   ACTIVE_STATUS = 'C'
         WHERE  DN_USER=UPPER(M_DN_USER);
         
 INSERT INTO dn_doc_status_log( DOC_REF_NO,DOC_TYPE,DOC_STATUS,DN_USER,ENT_DATE,DESCRIPTION)
 VALUES(UPPER(M_DN_USER),'USER','C',M_USER,SYSDATE,'TERMINATE USER TEMP');
 
 -- End by Udara on 23-05-2011
               
  END IF;
 
 
------------------------------------------------------------------------------------------------------------ 
 
 
 COMMIT;
 END USER_MAINTENANCE_MAIN;

/*PROCEDURE NWAM.USER_MAINTENANCE_MAIN
  ( M_SCRNAME                       VARCHAR2,
    M_DN_USER                       DN_REF_USER.DN_USER%TYPE,
    M_PASSWORD                      VARCHAR2,
    M_SURNAME                       DN_REF_USER.SURNAME%TYPE,
    M_OTHER_NAMES                   DN_REF_USER.OTHER_NAMES%TYPE,
    M_LOC_CODE                      DN_REF_USER.LOC_CODE%TYPE,
    M_DESIG_CODE                    DN_REF_USER.DESIG_CODE%TYPE,
    M_SENIOR_LEVEL                  DN_REF_USER.SENIOR_LEVEL%TYPE,
    M_CHAPSS                        VARCHAR2
  )

   -- PROCEDURE    : NEW USER PASSWORD
   -- SYSTEM       : DEALNET SYSTEM
   -- CREATED BY   : CHARMINDA
   -- CREATED ON   : 17/08/1999

   -- MODIFIED ON  : 18/08/1999 BY D.P. PUBUDU THUSHARA

  AS
   MAIN_CUR          INTEGER;
   IGNORE            INTEGER;

  BEGIN

  --RAISE_APPLICATION_ERROR(-20201,M_SCRNAME);

  ----------------------------------------------crate password----------------------------------------
   MAIN_CUR:=DBMS_SQL.OPEN_CURSOR;

 IF M_SCRNAME='ADD' THEN



 DBMS_SQL.PARSE(MAIN_CUR,
      'CREATE USER '||UPPER(M_DN_USER)||' IDENTIFIED BY '||UPPER(M_PASSWORD)||
      ' DEFAULT TABLESPACE DEALADMIN TEMPORARY TABLESPACE DEALADMIN PROFILE DEFAULT',DBMS_SQL.V7);
   IGNORE:=DBMS_SQL.EXECUTE(MAIN_CUR);

   DBMS_SQL.PARSE(MAIN_CUR,
      'GRANT CONNECT TO '||M_DN_USER,DBMS_SQL.V7);

   IGNORE:=DBMS_SQL.EXECUTE(MAIN_CUR);


  DBMS_SQL.PARSE(MAIN_CUR,
      'GRANT WD_DN_MAIN TO '||M_DN_USER,DBMS_SQL.V7);

   IGNORE:=DBMS_SQL.EXECUTE(MAIN_CUR);


END IF;



------------------------------------------update or insert a user-------------------------------------------------------

IF M_SCRNAME='ADD' OR M_SCRNAME='MOD' OR M_SCRNAME='REA' THEN

   IF M_CHAPSS='CHA' THEN
      SYS.DBMS_SQL.PARSE(MAIN_CUR,
     'ALTER USER '||UPPER(M_DN_USER)||' IDENTIFIED BY '||UPPER(M_PASSWORD),DBMS_SQL.V7);

     IGNORE:=SYS.DBMS_SQL.EXECUTE(MAIN_CUR);


   END IF;

   UPDATE DN_REF_USER SET
      DN_USER=M_DN_USER,
      SURNAME=M_SURNAME,
      OTHER_NAMES=M_OTHER_NAMES,
      LOC_CODE=M_LOC_CODE,
      DESIG_CODE=M_DESIG_CODE,
      SENIOR_LEVEL=M_SENIOR_LEVEL

   WHERE DN_USER=UPPER(M_DN_USER);

   IF SQL%NOTFOUND THEN

   INSERT INTO DN_REF_USER
        (DN_USER,
         SURNAME,
         OTHER_NAMES,
         LOC_CODE,
         DESIG_CODE,
         SENIOR_LEVEL)
        VALUES
        (UPPER(M_DN_USER),
         UPPER(M_SURNAME),
         M_OTHER_NAMES,
         M_LOC_CODE,
         M_DESIG_CODE,
         M_SENIOR_LEVEL);
 END IF;
 END IF;

------------------------------------------------------------------------------------------------------------


 COMMIT;

END USER_MAINTENANCE_MAIN;*/

/
