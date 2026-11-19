--------------------------------------------------------
--  DDL for Procedure WD_FIND_LICINST_TOTAL_TRANAMT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."WD_FIND_LICINST_TOTAL_TRANAMT" 
AS

           --PURPOSE     : TO GET DETAILS FROM LICE_INST_ACCOUNT TABLE
           --CREATED BY  : RUWAN LIYANAGE
           --CREATED ON  : 26-03-2001
           --SYSTEM      : DEALNET

CURSOR MY_CUR IS
   SELECT NVL(SUM(A.TRNAMOUNT),0),A.DOCREFNO
   FROM   DN_ACC_LICENCEE_INST_ACCOUNT A
   WHERE  A.ACC_TYPE_CODE IN ('001','101') AND
          A.DRCR_STATUS='DR' AND
          A.DOCREFNO IN (SELECT BBB.DD
                         FROM
                           (SELECT    Z.DEAL_NO DD
                            FROM      DN_INV_OUTPS_DEAL_SEC Z
                            GROUP BY  Z.DEAL_NO
                         UNION
                            SELECT    Z.DEAL_NO DD
                            FROM      DN_HIS_OUTPS_DEAL_SERIAL_NO Z
                            GROUP BY  Z.DEAL_NO
                         UNION
                            SELECT    Z.DEAL_NO DD
                            FROM      DN_INV_OUTPS_DEAL_SERIAL_NO Z
                            GROUP BY  Z.DEAL_NO )BBB)
   GROUP BY A.DOCREFNO ;


M_TRNAMT                 DN_ACC_LICENCEE_INST_ACCOUNT.TRNAMOUNT%TYPE;
M_DOCREFNO               DN_ACC_LICENCEE_INST_ACCOUNT.DOCREFNO%TYPE;
MM_DEAL_NO               DN_ACC_LICENCEE_INST_ACCOUNT.DOCREFNO%TYPE;
MM_TRNAMT                DN_ACC_LICENCEE_INST_ACCOUNT.TRNAMOUNT%TYPE;
M_COUNT                  NUMBER;


BEGIN

  DELETE FROM DN_TEMP_INST_DETAILS;
  OPEN MY_CUR;
  LOOP
    FETCH MY_CUR INTO M_TRNAMT,M_DOCREFNO;
  EXIT WHEN  MY_CUR%NOTFOUND;

        SELECT COUNT(*)
        INTO   M_COUNT
        FROM
               (SELECT BBB.DD FFF,NVL(SUM(BBB.EE),0) GGG
                FROM
                  (SELECT Z.DEAL_NO DD,(SUM(INITIAL_COST)+SUM(PRICE_INT_ACCR)+SUM(TOT_COUP_INT)) EE
                   FROM   DN_INV_OUTPS_DEAL_SEC Z
                   WHERE  Z.DEAL_NO=M_DOCREFNO
                   GROUP BY Z.DEAL_NO
                   UNION ALL
                   SELECT Z.DEAL_NO DD,(SUM(INITIAL_COST)+SUM(PRICE_INT_ACCR)+SUM(TOT_COUP_INT)) EE
                   FROM   DN_HIS_OUTPS_DEAL_SERIAL_NO Z
                   WHERE Z.DEAL_NO=M_DOCREFNO
                   GROUP BY Z.DEAL_NO
                   UNION ALL
                   SELECT Z.DEAL_NO DD,(SUM(INITIAL_COST)+SUM(PRICE_INT_ACCR)+SUM(TOT_COUP_INT)) EE
                   FROM   DN_INV_OUTPS_DEAL_SERIAL_NO Z
                   WHERE Z.DEAL_NO=M_DOCREFNO
                   GROUP BY Z.DEAL_NO)BBB
                GROUP BY  BBB.DD )L
        WHERE (L.GGG)<>M_TRNAMT  AND
               L.FFF=M_DOCREFNO;


    IF(M_COUNT>0)THEN
          SELECT  L.FFF,L.GGG
          INTO    MM_DEAL_NO,MM_TRNAMT
          FROM
               (SELECT BBB.DD FFF,NVL(SUM(BBB.EE),0) GGG
                FROM
                 (SELECT   Z.DEAL_NO DD,(SUM(INITIAL_COST)+SUM(PRICE_INT_ACCR)+SUM(TOT_COUP_INT)) EE
                  FROM     DN_INV_OUTPS_DEAL_SEC Z
                  WHERE    Z.DEAL_NO=M_DOCREFNO
                  GROUP BY Z.DEAL_NO
                  UNION
                  SELECT Z.DEAL_NO DD,(SUM(INITIAL_COST)+SUM(PRICE_INT_ACCR)+SUM(TOT_COUP_INT)) EE
                  FROM   DN_HIS_OUTPS_DEAL_SERIAL_NO Z
                  WHERE Z.DEAL_NO=M_DOCREFNO
                  GROUP BY Z.DEAL_NO
                  UNION
                  SELECT Z.DEAL_NO DD,(SUM(INITIAL_COST)+SUM(PRICE_INT_ACCR)+SUM(TOT_COUP_INT)) EE
                  FROM   DN_INV_OUTPS_DEAL_SERIAL_NO Z
                  WHERE Z.DEAL_NO=M_DOCREFNO
                  GROUP BY Z.DEAL_NO)BBB
               GROUP BY  BBB.DD )L
         WHERE (L.GGG)<>M_TRNAMT  AND
               L.FFF=M_DOCREFNO;


  INSERT INTO DN_TEMP_INST_DETAILS
  (DEAL_NO,TRNAMT_INST,TRNAMT_OTH)
  VALUES
  (M_DOCREFNO,M_TRNAMT,MM_TRNAMT);

   END IF;

END LOOP;
CLOSE MY_CUR;
COMMIT;
END WD_FIND_LICINST_TOTAL_TRANAMT ;

/
