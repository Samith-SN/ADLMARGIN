--------------------------------------------------------
--  DDL for Procedure DN_SETTL_REBATE_RB_SUSPENSE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_SETTL_REBATE_RB_SUSPENSE" 
   (
    M_DEAL_NO      DN_TRN_SETTLEMENT_REBATE.DEAL_NO%TYPE
   )

   IS

    -- Procedue     : Update Repo SETTLEMENT dn_settl_rebate_rb_suspense
    -- System       : Dealnet system
    -- Created by   : K.M.Waruna Sri Jayanath
    -- Created on   : 27-02-2012


    M_BORR_PORTFOLIO_CODE     DN_TRN_SETTLEMENT_REBATE.BORR_PORTFOLIO_CODE%TYPE;
    M_LEND_PORTFOLIO_CODE     DN_TRN_SETTLEMENT_REBATE.LEND_PORTFOLIO_CODE%TYPE;
    M_BORR_PF_TYPE            DN_REF_PORTFOLIO.PF_TYPE%TYPE;
    M_LEND_PF_TYPE            DN_REF_PORTFOLIO.PF_TYPE%TYPE;
    M_PRIOR_DEAL_NO           DN_TRN_SETTLEMENT_REBATE.PRIOR_DEAL_NO%TYPE;
    M_REBATE_AMOUNT           DN_TRN_SETTLEMENT_REBATE.REBATE_AMOUNT%TYPE;
    M_CURR_ACC_VALUE          DN_TRN_SETTLEMENT_REBATE.REBATE_AMOUNT%TYPE;
--MM_CURRENCY_SETTLE_AMOUNT      DN_TRN_SETTLEMENT_REBATE.CURRENCY_SETTLE_AMOUNT%TYPE;--CURRENCY

BEGIN

--MM_CURRENCY_SETTLE_AMOUNT:=NULL;

   SELECT
      A.PRIOR_DEAL_NO
      INTO M_PRIOR_DEAL_NO
   FROM
      DN_TRN_SETTLEMENT_REBATE A
   WHERE
       A.DEAL_NO=M_DEAL_NO;


  
   --------------------------------------------

IF SUBSTR(M_PRIOR_DEAL_NO,1,2)='RS' THEN

--   SELECT
--      SUM(SETTLE_AMOUNT)
--      INTO M_CURR_ACC_VALUE
--   FROM
--      DN_TRN_REPO_FRESH_SETTLE
--   WHERE
--      DEAL_NO=M_PRIOR_DEAL_NO
--      AND
--      SETTLE_MODE='CURR_ACC';

   SELECT
      A.BORR_PORTFOLIO_CODE,
      A.LEND_PORTFOLIO_CODE,
      B.PF_TYPE,
      C.PF_TYPE,
      A.REBATE_AMOUNT
      INTO
         M_BORR_PORTFOLIO_CODE,
         M_LEND_PORTFOLIO_CODE,
         M_BORR_PF_TYPE,
         M_LEND_PF_TYPE,
         M_REBATE_AMOUNT
   FROM
      DN_TRN_SETTLEMENT_REBATE A,
      DN_REF_PORTFOLIO B,
      DN_REF_PORTFOLIO C
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      A.LEND_PORTFOLIO_CODE=C.PORTFOLIO_CODE;

END IF;

  -- Before confiremation they have to specify at least one settlement option

 
      IF M_BORR_PF_TYPE='P' THEN

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
          VALUES
            (M_DEAL_NO,
             'D',
             M_BORR_PORTFOLIO_CODE ,
             M_LEND_PORTFOLIO_CODE,
             (M_REBATE_AMOUNT),
             0,
             0,
             (M_REBATE_AMOUNT),
             SYSDATE,
             SYSDATE,
             0,--CURRENCY
             0-- MM_CURRENCY_SETTLE_AMOUNT--CURRENCY
            );
      END IF;

     /* IF M_LEND_PF_TYPE='P' THEN

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
       VALUES
           (M_DEAL_NO,
            'D',
            M_LEND_PORTFOLIO_CODE,
            M_BORR_PORTFOLIO_CODE,
            (M_PRIOR_DEAL_LEG2_VALUE-M_CURR_ACC_VALUE),
            0,
            0,
            (M_PRIOR_DEAL_LEG2_VALUE-M_CURR_ACC_VALUE),
            SYSDATE,
            SYSDATE,
             0,--CURRENCY
             MM_CURRENCY_SETTLE_AMOUNT--CURRENCY
           );

      END IF;
*/
 



 

END ; 

/
