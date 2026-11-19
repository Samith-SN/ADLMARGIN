--------------------------------------------------------
--  DDL for Procedure PA_CUTOFF_IN1
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."PA_CUTOFF_IN1" (
        M_AUCTION_DATE               VARCHAR2,
        M_INST_TYPE                  PA_AUCTION_DETAILS.INST_TYPE%TYPE,
        M_SECURITY_CODE              PA_AUCTION_DETAILS.SECURITY_CODE%TYPE,
        M_ISSUER_CODE                PA_AUCTION_DETAILS.ISSUER_CODE%TYPE,
        M_PORTFOLIO_CODE             PA_AUCTION_DETAILS.PORTFOLIO_CODE%TYPE,
        M_CUT_OFF_PRICE              PA_AUCTION_DETAILS.CUT_OFF_PRICE%TYPE,
        M_CUT_OFF_PER                PA_AUCTION_DETAILS.CUT_OFF_PER%TYPE,
        M_FACE_VALUE                 PA_AUCTION_DETAILS.FACE_VALUE%TYPE,
        M_COST                       PA_AUCTION_DETAILS.COST%TYPE,
        M_ACC_INT_TOTAL              PA_AUCTION_DETAILS.ACC_INT_TOTAL%TYPE,
        M_ACC_INT_PER100             PA_AUCTION_DETAILS.ACC_INT_PER100%TYPE,
        M_SETTLE_VALUE               PA_AUCTION_DETAILS.SETTLE_VALUE%TYPE,
        M_ENTERED_BY                 VARCHAR2,
        M_SELECT_TYPE                VARCHAR2)

AS
 M_SDATE             PA_AUCTION_DETAILS.ENTERED_DATE%TYPE;

BEGIN

/*RAISE_APPLICATION_ERROR(-20201,M_AUCTION_DATE ||' '||M_INST_TYPE||' '||M_SECURITY_CODE||' '||M_ISSUER_CODE||' '||M_PORTFOLIO_CODE||' '||M_ENTERED_BY||' '||M_SELECT_TYPE);*/


    /* PROCEDURE  - TO SAVE PRIMARY AUCTION CREATION SCREEN
       SYSTEM     -  DEALNET
       CREATED BY -
       CREATED ON -  */



 SELECT
        SYSDATE
       INTO
         M_SDATE
       FROM
         DUAL;


IF M_AUCTION_DATE IS NOT NULL  AND M_SELECT_TYPE='MAIN2' THEN

 UPDATE PA_AUCTION_DETAILS
       SET AUCTION_DATE           =TO_DATE(M_AUCTION_DATE,'DD/MM/YYYY'),
           INST_TYPE              =M_INST_TYPE,
           ISSUER_CODE            =M_ISSUER_CODE,
           SECURITY_CODE          =M_SECURITY_CODE,
           PORTFOLIO_CODE         =M_PORTFOLIO_CODE,
           CUT_OFF_PRICE          =M_CUT_OFF_PRICE,
           CUT_OFF_PER            =M_CUT_OFF_PER,
           FACE_VALUE             =M_FACE_VALUE,
           COST                   =M_COST,
           ACC_INT_TOTAL          =M_ACC_INT_TOTAL,
           ACC_INT_PER100         =M_ACC_INT_PER100,
           SETTLE_VALUE           =M_SETTLE_VALUE,
           ENTERED_BY             =M_ENTERED_BY,
           ENTERED_DATE           =M_SDATE
         WHERE
           AUCTION_DATE    =TO_DATE(M_AUCTION_DATE,'DD/MM/YYYY')  AND
           INST_TYPE       =M_INST_TYPE AND
           ISSUER_CODE     =M_ISSUER_CODE AND
           SECURITY_CODE   =M_SECURITY_CODE AND
           CUT_OFF_PRICE   =M_CUT_OFF_PRICE AND
           PORTFOLIO_CODE  =M_PORTFOLIO_CODE ;

  IF SQL%NOTFOUND THEN

    INSERT INTO PA_AUCTION_DETAILS
        (AUCTION_DATE,
         INST_TYPE,
         ISSUER_CODE,
         SECURITY_CODE,
         PORTFOLIO_CODE,
         CUT_OFF_PRICE,
         CUT_OFF_PER,
         FACE_VALUE,
         COST,
         ACC_INT_TOTAL,
         ACC_INT_PER100,
         SETTLE_VALUE,
         ENTERED_BY,
         ENTERED_DATE)
           VALUES(
             TO_DATE(M_AUCTION_DATE,'DD/MM/YYYY'),
             M_INST_TYPE,
             M_ISSUER_CODE,
             M_SECURITY_CODE,
             M_PORTFOLIO_CODE,
             M_CUT_OFF_PRICE,
             M_CUT_OFF_PER,
             M_FACE_VALUE,
             M_COST,
             M_ACC_INT_TOTAL,
             M_ACC_INT_PER100,
             M_SETTLE_VALUE,
             M_ENTERED_BY,
             M_SDATE
             );
    END IF;
END IF;
COMMIT;

END PA_CUTOFF_IN1;

/
