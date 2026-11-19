--------------------------------------------------------
--  DDL for Procedure DN_PA_DENOM_IN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_PA_DENOM_IN" (
        M_INST_TYPE                  PA_DENOMI_REFERENCE.INST_TYPE%TYPE,
        M_ISSUER_CODE                PA_DENOMI_REFERENCE.ISSUER_CODE%TYPE,
        M_DENOM                      PA_DENOMI_REFERENCE.DENOMINATION%TYPE,
        M_ENTERED_BY                 VARCHAR2,
        M_SELECT_TYPE                VARCHAR2)

AS
 M_SDATE                             PA_DENOMI_REFERENCE.ENTERED_DATE%TYPE;
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

 IF M_INST_TYPE IS NOT NULL  AND M_SELECT_TYPE='MAIN7' THEN

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
COMMIT;

END DN_PA_DENOM_IN;

/
