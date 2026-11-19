--------------------------------------------------------
--  DDL for Procedure DN_UPDAT_TAB_TEMP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_UPDAT_TAB_TEMP" 
 AS

CURSOR  MY_CUR IS
   SELECT DOCREFNO
   FROM DN_TRN_BO_CAP_INVEST;

      M_DOCREFNO                   DN_TRN_BO_CAP_INVEST.DOCREFNO%TYPE;
      M_TRNDATE                    DATE;
      M_EFF_VAL_DATE               DATE;

 BEGIN

OPEN MY_CUR ;
   LOOP
      M_DOCREFNO := NULL;
      FETCH  MY_CUR INTO
             M_DOCREFNO;

      EXIT WHEN MY_CUR%NOTFOUND;


 SELECT
        DOCREFNO,TRNDATE,EFF_VAL_DATE
 INTO
        M_DOCREFNO,M_TRNDATE,M_EFF_VAL_DATE
 FROM   DN_TRN_BO_CAP_INVEST
 WHERE  DOCREFNO=M_DOCREFNO;


 UPDATE   DN_TRN_BO_CAP_INVEST
 SET      EFF_VAL_DATE=M_TRNDATE
 WHERE    DOCREFNO=M_DOCREFNO;

---------------------------------------------------------------------------------------
END LOOP;
--COMMIT;
END  DN_UPDAT_TAB_TEMP;

/
