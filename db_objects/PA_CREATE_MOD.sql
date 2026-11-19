--------------------------------------------------------
--  DDL for Procedure PA_CREATE_MOD
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."PA_CREATE_MOD" (
        M_AUCTION_DATE               VARCHAR2,
        M_INST_TYPE                  PA_AUCTION_REFERENCE.INST_TYPE%TYPE,
        M_SECURITY_CODE              PA_AUCTION_REFERENCE.SECURITY_CODE%TYPE,
        M_ISSUER_CODE                PA_AUCTION_REFERENCE.ISSUER_CODE%TYPE,
        M_PORTFOLIO_CODE             PA_AUCTION_REFERENCE.PORTFOLIO_CODE%TYPE,
        M_ENTERED_BY                 VARCHAR2,
        M_SELECT_TYPE                VARCHAR2)

AS

 BEGIN

/*RAISE_APPLICATION_ERROR(-20201,M_AUCTION_DATE ||' '||M_INST_TYPE||' '||M_SECURITY_CODE||' '||M_ISSUER_CODE||' '||M_PORTFOLIO_CODE||' '||M_ENTERED_BY||' '||M_SELECT_TYPE);*/


    /* PROCEDURE  - TO SAVE PRIMARY AUCTION CREATION SCREEN
       SYSTEM     -  DEALNET
       CREATED BY -
       CREATED ON -  */


 IF M_AUCTION_DATE IS NOT NULL  AND M_SELECT_TYPE='MAIN4' THEN

      UPDATE PA_AUCTION_REFERENCE
         SET ACTIVE_STATUS          ='N'
       WHERE
            AUCTION_DATE    =TO_DATE(M_AUCTION_DATE,'DD/MM/YYYY')  AND
            INST_TYPE       =M_INST_TYPE AND
            ISSUER_CODE     =M_ISSUER_CODE AND
            SECURITY_CODE   =M_SECURITY_CODE AND
            PORTFOLIO_CODE  =M_PORTFOLIO_CODE ;


           INSERT INTO DN_TIME_LOG
          (DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            (
              M_ENTERED_BY,
              SYSDATE,
              'DELETION');


 END IF;
COMMIT;

END PA_CREATE_MOD;

/
