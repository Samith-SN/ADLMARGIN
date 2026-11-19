--------------------------------------------------------
--  DDL for Procedure DN_SETTL_BL_SEC_RF_SUSPENSE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_SETTL_BL_SEC_RF_SUSPENSE" 
   (
    M_DEAL_NO      DN_TRN_BL_SECURITY.DEAL_NO%TYPE
   )

   IS

    -- Procedue     : Update (B/L) SEC. Repo fresh settlement suspense
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 24/08/1999

    M_BORR_PORTFOLIO_CODE     DN_TRN_BL_SECURITY.BORR_PORTFOLIO_CODE%TYPE;
    M_LEND_PORTFOLIO_CODE     DN_TRN_BL_SECURITY.LEND_PORTFOLIO_CODE%TYPE;
    M_BORR_PF_TYPE            DN_REF_PORTFOLIO.PF_TYPE%TYPE;
    M_LEND_PF_TYPE            DN_REF_PORTFOLIO.PF_TYPE%TYPE;
    M_TOT_VALUE               DN_TRN_BL_SECURITY.FEE_AMOUNT%TYPE;


BEGIN

   SELECT
      A.BORR_PORTFOLIO_CODE,
      A.LEND_PORTFOLIO_CODE,
      B.PF_TYPE,
      C.PF_TYPE
      INTO  M_BORR_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE,
            M_BORR_PF_TYPE,M_LEND_PF_TYPE
   FROM
      DN_TRN_BL_SECURITY A,
      DN_REF_PORTFOLIO B,
      DN_REF_PORTFOLIO C
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      A.LEND_PORTFOLIO_CODE=C.PORTFOLIO_CODE;

  -- Before confiremation they have to specify at least one settlement option

   SELECT
      SUM(SETTLE_AMOUNT)
      INTO M_TOT_VALUE
   FROM
      DN_TRN_BL_SECURITY_SETTLE
   WHERE
      DEAL_NO=M_DEAL_NO
      AND
      SETTLE_MODE<>'CURR_ACC';

    IF M_TOT_VALUE IS NULL THEN

       M_TOT_VALUE:=0;

    END IF;

  -- For BORR

     IF M_BORR_PF_TYPE='P' AND  M_TOT_VALUE>0 THEN

        INSERT INTO DN_ACC_SUS_PAYMENT
           (SUS_REF_NO,
            SUSPENSE_ENTRY_TYPE,
            RECEIVER,
            PAYER,
            TOT_SETTLE_AMOUNT,
            INT_BAL_SETTLE_AMOUNT,
            PAY_FROM_INT_BAL_AMT,
            BAL_TO_BE_PAID,
            ENT_DATE,
            LAST_MOD_DATE
           )
          SELECT
             B.DEAL_NO,
             'D',
             B.LEND_PORTFOLIO_CODE,
             B.BORR_PORTFOLIO_CODE,
             M_TOT_VALUE,
             0,
             0,
             M_TOT_VALUE,
             SYSDATE,
             SYSDATE
          FROM
             DN_TRN_BL_SECURITY B
          WHERE
             B.DEAL_NO=M_DEAL_NO;
     END IF;

     IF M_LEND_PF_TYPE='P' AND M_TOT_VALUE>0 THEN

        -- For the LEND. information

        INSERT INTO DN_ACC_SUS_RECEIPT
           (SUS_REF_NO,
            SUSPENSE_ENTRY_TYPE,
            RECEIVER,
            PAYER,
            TOT_SETTLE_AMOUNT,
            INT_BAL_SETTLE_AMOUNT,
            REC_FROM_INT_BAL_AMT,
            BAL_TO_BE_RECEIVED,
            ENT_DATE,
            LAST_MOD_DATE
           )
          SELECT
             B.DEAL_NO,
             'D',
             B.LEND_PORTFOLIO_CODE,
             B.BORR_PORTFOLIO_CODE,
             M_TOT_VALUE,
             0,
             0,
             M_TOT_VALUE,
             SYSDATE,
             SYSDATE
          FROM
             DN_TRN_BL_SECURITY B
          WHERE
             B.DEAL_NO=M_DEAL_NO;
     END IF;

 IF  M_TOT_VALUE>0 THEN

      ------- Linking to accounting sub system
      DN_ACC_LINK_BL_SEC_FO_SETT(M_DEAL_NO,M_TOT_VALUE);

   END IF;

END DN_SETTL_BL_SEC_RF_SUSPENSE;

/
