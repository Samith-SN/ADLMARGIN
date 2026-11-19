--------------------------------------------------------
--  DDL for Procedure PA_CREATE_IN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."PA_CREATE_IN" (
        M_AUCTION_DATE               VARCHAR2,
        M_INST_TYPE                  PA_AUCTION_REFERENCE.INST_TYPE%TYPE,
        M_SECURITY_CODE              PA_AUCTION_REFERENCE.SECURITY_CODE%TYPE,
        M_ISSUER_CODE                PA_AUCTION_REFERENCE.ISSUER_CODE%TYPE,
        M_PORTFOLIO_CODE             PA_AUCTION_REFERENCE.PORTFOLIO_CODE%TYPE,
        M_BID_INT_RATE_BASE_CODE     PA_AUCTION_REFERENCE.BID_INT_RATE_BASE_CODE%TYPE,
        M_SELLER_CODE                PA_AUCTION_REFERENCE.SELLER_CODE%TYPE,
        M_ENTERED_BY                 VARCHAR2,
        M_SELECT_TYPE                VARCHAR2)

AS

M_SDATE             PA_AUCTION_REFERENCE.ENTERED_DATE%TYPE;


 BEGIN

/*RAISE_APPLICATION_ERROR(-20201,M_PORTFOLIO_CODE ||' '||M_OWNED_BY_MBFSL||' '||M_CP_PORTFOLIO_CODE||' '||M_PF_NAME||' '||M_ADD_IDENTIFICATION||' '||M_ADD_LOCATION||' '||M_ADD_STREET||' '||M_ADD_CITY||' '||M_ADD_COUNTRY||' ' ||M_POSTAL_CODE||' '||M_DATE_INC_BIRTH||' '||M_BUSI_REG_NIC||' '||M_CATEGORY_ENTITY||' '||M_NATURE_OCCUPATION ||' '||M_SECT_CODE ||' '||M_MBFSL_SECT_CODE||' '||M_NEST_REVIEW );*/


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

IF M_AUCTION_DATE IS NOT NULL  AND M_SELECT_TYPE='MAIN1' THEN

 UPDATE PA_AUCTION_REFERENCE
       SET AUCTION_DATE           =TO_DATE(M_AUCTION_DATE,'DD/MM/YYYY'),
           INST_TYPE              =M_INST_TYPE,
           ISSUER_CODE            =M_ISSUER_CODE,
           SECURITY_CODE          =M_SECURITY_CODE,
           PORTFOLIO_CODE         =M_PORTFOLIO_CODE,
           BID_INT_RATE_BASE_CODE =M_BID_INT_RATE_BASE_CODE,
           SELLER_CODE            =M_SELLER_CODE,
           ENTERED_BY             =M_ENTERED_BY,
           ENTERED_DATE           =M_SDATE
     WHERE
           AUCTION_DATE    =TO_DATE(M_AUCTION_DATE,'DD/MM/YYYY')  AND
           INST_TYPE       =M_INST_TYPE AND
           ISSUER_CODE     =M_ISSUER_CODE AND
           SECURITY_CODE   =M_SECURITY_CODE AND
           PORTFOLIO_CODE  =M_PORTFOLIO_CODE ;

   IF SQL%NOTFOUND THEN
     INSERT INTO PA_AUCTION_REFERENCE
        (AUCTION_DATE,
         INST_TYPE,
         ISSUER_CODE,
         SECURITY_CODE,
         PORTFOLIO_CODE,
         BID_INT_RATE_BASE_CODE,
         SELLER_CODE,
         AUCTION_STATUS,
         ACTIVE_STATUS,
         ENTERED_BY,
         ENTERED_DATE)
           VALUES(
             TO_DATE(M_AUCTION_DATE,'DD/MM/YYYY'),
             M_INST_TYPE,
             M_ISSUER_CODE,
             M_SECURITY_CODE,
             M_PORTFOLIO_CODE,
             M_BID_INT_RATE_BASE_CODE,
             M_SELLER_CODE,
             'P',
             'Y',
             M_ENTERED_BY,
             M_SDATE

           );

           INSERT INTO DN_TIME_LOG
          (DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            (
              M_ENTERED_BY,
              M_SDATE,
              'ENTERED'
           );



    END IF;
 END IF;

IF M_AUCTION_DATE IS NOT NULL  AND M_SELECT_TYPE='MAIN2' THEN

  UPDATE PA_AUCTION_REFERENCE
       SET AUCTION_DATE           =TO_DATE(M_AUCTION_DATE,'DD/MM/YYYY'),
           INST_TYPE              =M_INST_TYPE,
           ISSUER_CODE            =M_ISSUER_CODE,
           SECURITY_CODE          =M_SECURITY_CODE,
           PORTFOLIO_CODE         =M_PORTFOLIO_CODE,
           BID_INT_RATE_BASE_CODE =M_BID_INT_RATE_BASE_CODE,
           SELLER_CODE            =M_SELLER_CODE,
           ENTERED_BY             =M_ENTERED_BY,
           ENTERED_DATE           =M_SDATE
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
              M_SDATE,
              'MODIFICATION'
           );
 END IF;

 COMMIT;


END PA_CREATE_IN;

/
