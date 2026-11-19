--------------------------------------------------------
--  DDL for Procedure DN_SETTL_REPO_PI_SUSPENSE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_SETTL_REPO_PI_SUSPENSE" 
   (
    M_DEAL_NO      DN_TRN_REPO_PERIOD_INT.DEAL_NO%TYPE
   )

   IS

    -- Procedue     : Update Repo periodic settlement suspense
    -- System       : Dealnet system
    -- Created by   : V.Thilakesan.
    -- Created on   : 02/03/2000

    M_BORR_PORTFOLIO_CODE     DN_TRN_REPO_PERIOD_INT.BORR_PORTFOLIO_CODE%TYPE;
    M_LEND_PORTFOLIO_CODE     DN_TRN_REPO_PERIOD_INT.LEND_PORTFOLIO_CODE%TYPE;
    M_BORR_PF_TYPE            DN_REF_PORTFOLIO.PF_TYPE%TYPE;
    M_LEND_PF_TYPE            DN_REF_PORTFOLIO.PF_TYPE%TYPE;
    M_TOT_VALUE               DN_TRN_REPO_PERIOD_INT.LEG1_VALUE%TYPE;
MM_CURRENCY_SETTLE_AMOUNT  DN_TRN_REPO_PERIOD_INT_SETTLE.CURRENCY_SETTLE_AMOUNT%TYPE;--CURRENCY


BEGIN
MM_CURRENCY_SETTLE_AMOUNT:=NULL;
   SELECT
      A.BORR_PORTFOLIO_CODE,
      A.LEND_PORTFOLIO_CODE,
      B.PF_TYPE,
      C.PF_TYPE
      INTO  M_BORR_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE,
            M_BORR_PF_TYPE,M_LEND_PF_TYPE
   FROM
      DN_TRN_REPO_PERIOD_INT A,
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
      SUM(SETTLE_AMOUNT),SUM(CURRENCY_SETTLE_AMOUNT)--CURRENCY
      INTO M_TOT_VALUE,MM_CURRENCY_SETTLE_AMOUNT--CURRENCY
   FROM
      DN_TRN_REPO_PERIOD_INT_SETTLE
   WHERE
      DEAL_NO=M_DEAL_NO
      AND
      SETTLE_MODE<>'CURR_ACC';

  -- For Lender

     IF M_LEND_PF_TYPE='P' AND M_TOT_VALUE>0 THEN

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
            LAST_MOD_DATE,
            PAY_FROM_INT_BAL_AMT_CURR,--CURRENCY
            BAL_TO_BE_PAID_CURR--CURRENCY
           )
          SELECT
             B.DEAL_NO,
             'D',
             B.BORR_PORTFOLIO_CODE,
             B.LEND_PORTFOLIO_CODE,
             M_TOT_VALUE,
             0,
             0,
             M_TOT_VALUE,
             SYSDATE,
             SYSDATE,
             0,--CURRENCY
             MM_CURRENCY_SETTLE_AMOUNT--CURRENCY
          FROM
             DN_TRN_REPO_PERIOD_INT B
          WHERE
             B.DEAL_NO=M_DEAL_NO;
     END IF;

     IF M_BORR_PF_TYPE='P' AND M_TOT_VALUE>0 THEN

        -- For the Brrower information

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
            LAST_MOD_DATE,
            REC_FROM_INT_BAL_AMT_CURR,--CURRENCY
            BAL_TO_BE_RECEIVED_CURR--CURRENCY
           )
          SELECT
             B.DEAL_NO,
             'D',
             B.BORR_PORTFOLIO_CODE,
             B.LEND_PORTFOLIO_CODE,
             M_TOT_VALUE,
             0,
             0,
             M_TOT_VALUE,
             SYSDATE,
             SYSDATE,
             0,--CURRENCY
             MM_CURRENCY_SETTLE_AMOUNT--CURRENCY
          FROM
             DN_TRN_REPO_PERIOD_INT B
          WHERE
             B.DEAL_NO=M_DEAL_NO;
     END IF;

     IF M_TOT_VALUE>0 THEN

         ----- Linking to accounting sub system
         DN_ACC_LINK_REPO_RF_FO_SETT(M_DEAL_NO,M_TOT_VALUE);

     END IF;
END DN_SETTL_REPO_PI_SUSPENSE;

/
