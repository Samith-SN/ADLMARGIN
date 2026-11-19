--------------------------------------------------------
--  DDL for Procedure PA_DENOM_IN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."PA_DENOM_IN" (
        M_INST_TYPE                  PA_DENOMI_REFERENCE.INST_TYPE%TYPE,
        M_ISSUER_CODE                PA_DENOMI_REFERENCE.ISSUER_CODE%TYPE,
        M_DENOM                      PA_DENOMI_REFERENCE.DENOMINATION%TYPE,
        M_ENTERED_BY                 VARCHAR2,
        M_SELECT_TYPE                VARCHAR2)

AS
 M_SDATE                             PA_DENOMI_REFERENCE.ENTERED_DATE%TYPE;
 BEGIN

/*RAISE_APPLICATION_ERROR(-20201,M_AUCTION_DATE ||' '||M_INST_TYPE||' '||M_SECURITY_CODE||' '||M_ISSUER_CODE||' '||M_PORTFOLIO_CODE||' '||M_ENTERED_BY||' '||M_SELECT_TYPE);*/


    /* PROCEDURE  - TO SAVE PRIMARY AUCTION DENOMINATIONS
       SYSTEM     - DEALNET
       CREATED BY - LATHIKA
       CREATED ON - 23/11/1999 */
 SELECT
        SYSDATE
       INTO
         M_SDATE
       FROM
         DUAL;

---adding new denominations-----------
 IF M_DENOM IS NOT NULL  AND M_SELECT_TYPE='MAIN' THEN
    UPDATE PA_DENOMI_REFERENCE
       SET DENOMINATION    =M_DENOM
    WHERE
         INST_TYPE       =M_INST_TYPE AND
         ISSUER_CODE     =M_ISSUER_CODE AND
         DENOMINATION    =M_DENOM  ;

   IF SQL%NOTFOUND THEN

      INSERT INTO PA_DENOMI_REFERENCE
        (INST_TYPE,
         ISSUER_CODE,
         DENOMINATION,
         ACTIVE_STATUS,
         ENTERED_BY,
         ENTERED_DATE)
           VALUES(
             M_INST_TYPE,
             M_ISSUER_CODE,
             M_DENOM,
             'Y',
             M_ENTERED_BY,
             M_SDATE
             );
    END IF;
 END IF;

 ----modify denominations---------------------
IF M_DENOM IS NOT NULL  AND M_SELECT_TYPE='MAIN2' THEN
  IF M_DENOM > 0 THEN
   UPDATE PA_DENOMI_REFERENCE
      SET ACTIVE_STATUS   ='Y' ,
          DENOMINATION    =M_DENOM
    WHERE
         INST_TYPE       =M_INST_TYPE AND
         ISSUER_CODE     =M_ISSUER_CODE AND
         DENOMINATION    =M_DENOM  ;

   IF SQL%NOTFOUND THEN

      INSERT INTO PA_DENOMI_REFERENCE
        (INST_TYPE,
         ISSUER_CODE,
         DENOMINATION,
         ACTIVE_STATUS,
         ENTERED_BY,
         ENTERED_DATE)
           VALUES(
             M_INST_TYPE,
             M_ISSUER_CODE,
             M_DENOM,
             'Y',
             M_ENTERED_BY,
             M_SDATE
             );
    END IF;
  END IF;-- M_DENOM >0
 END IF;

------------delete denominations--------------
 IF M_DENOM IS NOT NULL  AND M_SELECT_TYPE='MAIN3' THEN
    UPDATE PA_DENOMI_REFERENCE
    SET  ACTIVE_STATUS   ='N'
    WHERE
         INST_TYPE       =M_INST_TYPE AND
         ISSUER_CODE     =M_ISSUER_CODE AND
         ACTIVE_STATUS   ='Y' AND
         DENOMINATION    =M_DENOM  ;
 END IF;
--RAISE_APPLICATION_ERROR(-20201,M_ISSUER_CODE ||' '||M_INST_TYPE||''||M_DENOM);

------------delete denominations-(all records)-------------

IF M_DENOM IS NOT NULL  AND M_SELECT_TYPE='MAIN4' THEN
    UPDATE PA_DENOMI_REFERENCE
    SET  ACTIVE_STATUS   ='N'
    WHERE
         INST_TYPE       =M_INST_TYPE AND
         ISSUER_CODE     =M_ISSUER_CODE AND
         ACTIVE_STATUS   ='Y' ;

 END IF;
COMMIT;

END PA_DENOM_IN;

/
