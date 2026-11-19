--------------------------------------------------------
--  DDL for Procedure PA_OENTRY_IN1
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."PA_OENTRY_IN1" (
      M_REF_NO              IN OUT PA_BID_ENTRY.REF_NO%TYPE,
      M_AUCTION_DATE               VARCHAR2,
      M_INST_TYPE                  PA_BID_ENTRY.INST_TYPE%TYPE,
      M_ISSUER_CODE                PA_BID_ENTRY.ISSUER_CODE%TYPE,
      M_SECURITY_CODE              PA_BID_ENTRY.SECURITY_CODE%TYPE,
      M_PORTFOLIO_CODE             PA_BID_ENTRY.PORTFOLIO_CODE%TYPE,
      M_BIDDER_CODE                PA_BID_ENTRY.BIDDER_CODE%TYPE,
      M_GUARANTED                  PA_BID_ENTRY.GUARANTED%TYPE,

      M_CLIENT_INT_RATE_BASE_CODE  PA_BID_ENTRY.CLIENT_INT_RATE_BASE_CODE%TYPE,
      M_CLIENT_YIELD               PA_BID_ENTRY.CLIENT_YIELD%TYPE,
      M_CLIENT_PRICE_CLEAN         PA_BID_ENTRY.CLIENT_PRICE_CLEAN%TYPE,
      M_CLIENT_PRICE_DIRTY         PA_BID_ENTRY.CLIENT_PRICE_DIRTY%TYPE,
      M_CLIENT_FACE_VALUE          PA_BID_ENTRY.CLIENT_FACE_VALUE%TYPE,
      M_CLIENT_COST                PA_BID_ENTRY.CLIENT_COST%TYPE,

      M_CLIENT_ACC_INT             PA_BID_ENTRY.CLIENT_ACC_INT%TYPE,
      M_CLIENT_SETTLE_VALUE        PA_BID_ENTRY.CLIENT_SETTLE_VALUE%TYPE,
      M_BID_INT_RATE_BASE_CODE     PA_BID_ENTRY.BID_INT_RATE_BASE_CODE%TYPE,
      M_BID_PRICE_CLEAN            PA_BID_ENTRY.BID_PRICE_CLEAN%TYPE,
      M_BID_PRICE_DIRTY            PA_BID_ENTRY.BID_PRICE_DIRTY%TYPE,

      M_BID_YIELD                  PA_BID_ENTRY.BID_YIELD%TYPE,
      M_BID_FACE_VALUE             PA_BID_ENTRY.BID_FACE_VALUE%TYPE,
      M_BID_COST                   PA_BID_ENTRY.BID_COST%TYPE,
      M_BID_ACC_INT                PA_BID_ENTRY.BID_ACC_INT%TYPE,
      M_BID_SETTLE_VALUE           PA_BID_ENTRY.BID_SETTLE_VALUE%TYPE,
      M_DENOMI_STATUS              PA_BID_ENTRY.DENOMI_STATUS%TYPE,
      M_ENTERED_BY                 VARCHAR2,
      M_SELECT_TYPE                VARCHAR2)

AS
 M_DEAL_NUMBER             PA_BID_ENTRY.REF_NO%TYPE;
 M_SDATE                   PA_BID_ENTRY.ENTERED_DATE%TYPE;
 M_AUC                     DATE;


 BEGIN


--RAISE_APPLICATION_ERROR(-20201,M_AUCTION_DATE ||' '||M_INST_TYPE||' '||M_ISSUER_CODE||' '||M_SECURITY_CODE||' '||M_PORTFOLIO_CODE||' '||M_BIDDER_CODE||' '||M_GUARANTED ***||' '||M_ADD_CITY||' '||M_ADD_COUNTRY||' ' ||M_POSTAL_CODE||' '||M_DATE_INC_BIRTH||' '||M_BUSI_REG_NIC||' '||M_CATEGORY_ENTITY||' '||M_NATURE_OCCUPATION ||' '||M_SECT_CODE ||' '||M_MBFSL_SECT_CODE||' '||M_NEST_REVIEW );*/


    /* PROCEDURE  - TO SAVE PRIMARY_AUCTION/ORDER ENTRY SCREEN
       SYSTEM     -  DEALNET
       CREATED BY -
       CREATED ON -  */

 SELECT
     SYSDATE
  INTO
     M_SDATE
  FROM
     DUAL;

  IF M_REF_NO IS NULL THEN
       SELECT
         'PA'||TO_CHAR(SYSDATE,'YYYY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_PA_ORDER_ENTRY.NEXTVAL),3,'0')
       INTO
         M_REF_NO
       FROM
         DUAL;

   END IF;

M_AUC :=TO_DATE(M_AUCTION_DATE,'DD/MM/YYYY');


IF M_REF_NO IS NOT NULL  AND M_SELECT_TYPE='MAIN1' THEN
  UPDATE PA_BID_ENTRY
       SET REF_NO                       =M_REF_NO,
           AUCTION_DATE                 =TO_DATE(M_AUCTION_DATE,'DD/MM/YYYY'),
           INST_TYPE                    =M_INST_TYPE,
           ISSUER_CODE                  =M_ISSUER_CODE,
           SECURITY_CODE                =M_SECURITY_CODE,
           PORTFOLIO_CODE               =M_PORTFOLIO_CODE,
           BIDDER_CODE                  =M_BIDDER_CODE,
           GUARANTED                    =M_GUARANTED,

           CLIENT_INT_RATE_BASE_CODE    =M_CLIENT_INT_RATE_BASE_CODE,
           CLIENT_YIELD                 =M_CLIENT_YIELD,
           CLIENT_PRICE_CLEAN           =M_CLIENT_PRICE_CLEAN,
           CLIENT_PRICE_DIRTY           =M_CLIENT_PRICE_DIRTY,
           CLIENT_FACE_VALUE            =M_CLIENT_FACE_VALUE,
           CLIENT_COST                  =M_CLIENT_COST,

           CLIENT_ACC_INT               =M_CLIENT_ACC_INT,
           CLIENT_SETTLE_VALUE          =M_CLIENT_SETTLE_VALUE,
           BID_INT_RATE_BASE_CODE       =M_BID_INT_RATE_BASE_CODE,
           BID_PRICE_CLEAN              =M_BID_PRICE_CLEAN,
           BID_PRICE_DIRTY              =M_BID_PRICE_DIRTY,

           BID_YIELD                    =M_BID_YIELD,
           BID_FACE_VALUE               =M_BID_FACE_VALUE,
           BID_COST                     =M_BID_COST,
           BID_ACC_INT                  =M_BID_ACC_INT,
           BID_SETTLE_VALUE             =M_BID_SETTLE_VALUE,
           DENOMI_STATUS                =M_DENOMI_STATUS,
           ENTERED_BY                   =M_ENTERED_BY,
           ENTERED_DATE                 =M_SDATE
           WHERE
           REF_NO=M_REF_NO;

   IF SQL%NOTFOUND THEN
 --RAISE_APPLICATION_ERROR(-20201,M_REF_NO ||' '||M_BIDDER_CODE||' '||M_CLIENT_INT_RATE_BASE_CODE||' '||M_CLIENT_YIELD||' '||M_CLIENT_PRICE_CLEAN||''||M_CLIENT_PRICE_DIRTY);

      INSERT INTO PA_BID_ENTRY
        (REF_NO,
         AUCTION_DATE,
         INST_TYPE,
         ISSUER_CODE,
         SECURITY_CODE,
         PORTFOLIO_CODE,
         BIDDER_CODE,
         GUARANTED,

         CLIENT_INT_RATE_BASE_CODE,
         CLIENT_YIELD,
         CLIENT_PRICE_CLEAN,
         CLIENT_PRICE_DIRTY,
         CLIENT_FACE_VALUE,
         CLIENT_COST,

         CLIENT_ACC_INT,
         CLIENT_SETTLE_VALUE,
         BID_INT_RATE_BASE_CODE,
         BID_PRICE_CLEAN,
         BID_PRICE_DIRTY,

         BID_YIELD,
         BID_FACE_VALUE,
         BID_COST,
         BID_ACC_INT,
         BID_SETTLE_VALUE,
         ALLO_STATUS,
         DENOMI_STATUS,
         ENTERED_BY,
         ENTERED_DATE)
         VALUES(
            M_REF_NO,
            TO_DATE(M_AUCTION_DATE,'DD/MM/YYYY'),
            M_INST_TYPE,
            M_ISSUER_CODE,
            M_SECURITY_CODE,
            M_PORTFOLIO_CODE,
            M_BIDDER_CODE,
            M_GUARANTED,

            M_CLIENT_INT_RATE_BASE_CODE,
            M_CLIENT_YIELD,
            M_CLIENT_PRICE_CLEAN,
            M_CLIENT_PRICE_DIRTY,
            M_CLIENT_FACE_VALUE,
            M_CLIENT_COST,

            M_CLIENT_ACC_INT,
            M_CLIENT_SETTLE_VALUE,
            M_BID_INT_RATE_BASE_CODE,
            M_BID_PRICE_CLEAN,
            M_BID_PRICE_DIRTY,
            M_BID_YIELD,
            M_BID_FACE_VALUE,
            M_BID_COST,
            M_BID_ACC_INT,
            M_BID_SETTLE_VALUE,
            'ENT',
            M_DENOMI_STATUS,
            M_ENTERED_BY,
            M_SDATE
         );

        END IF;
 END IF;

IF M_REF_NO IS NOT NULL  AND M_SELECT_TYPE='MAIN2' THEN
--RAISE_APPLICATION_ERROR(-20201,M_REF_NO ||' '||M_AUC||' '||M_INST_TYPE||' '||M_ISSUER_CODE||' '||M_SECURITY_CODE||''||M_PORTFOLIO_CODE);
  UPDATE PA_BID_ENTRY
       SET AUCTION_DATE                 =TO_DATE(M_AUCTION_DATE,'DD/MM/YYYY'),
           INST_TYPE                    =M_INST_TYPE,
           ISSUER_CODE                  =M_ISSUER_CODE,
           SECURITY_CODE                =M_SECURITY_CODE,
           PORTFOLIO_CODE               =M_PORTFOLIO_CODE,
           BIDDER_CODE                  =M_BIDDER_CODE,
           GUARANTED                    =M_GUARANTED,
           CLIENT_INT_RATE_BASE_CODE    =M_CLIENT_INT_RATE_BASE_CODE,
           CLIENT_YIELD                 =M_CLIENT_YIELD,
           CLIENT_PRICE_CLEAN           =M_CLIENT_PRICE_CLEAN,
           CLIENT_PRICE_DIRTY           =M_CLIENT_PRICE_DIRTY,
           CLIENT_FACE_VALUE            =M_CLIENT_FACE_VALUE,
           CLIENT_COST                  =M_CLIENT_COST,
           CLIENT_ACC_INT               =M_CLIENT_ACC_INT,
           CLIENT_SETTLE_VALUE          =M_CLIENT_SETTLE_VALUE,
           BID_INT_RATE_BASE_CODE       =M_BID_INT_RATE_BASE_CODE,
           BID_PRICE_CLEAN              =M_BID_PRICE_CLEAN,
           BID_PRICE_DIRTY              =M_BID_PRICE_DIRTY,
           BID_YIELD                    =M_BID_YIELD,
           BID_FACE_VALUE               =M_BID_FACE_VALUE,
           BID_COST                     =M_BID_COST,
           BID_ACC_INT                  =M_BID_ACC_INT,
           BID_SETTLE_VALUE             =M_BID_SETTLE_VALUE,
           DENOMI_STATUS                =M_DENOMI_STATUS,
           ENTERED_BY                   =M_ENTERED_BY ,
           ENTERED_DATE                 =M_SDATE
           WHERE
           REF_NO=M_REF_NO;
       END IF;

  COMMIT;

END PA_OENTRY_IN1;

/
