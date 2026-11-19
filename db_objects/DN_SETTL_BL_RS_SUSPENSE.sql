--------------------------------------------------------
--  DDL for Procedure DN_SETTL_BL_RS_SUSPENSE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_SETTL_BL_RS_SUSPENSE" 
   (
    M_DEAL_NO      DN_TRN_BL_FUND.DEAL_NO%TYPE
   )

   IS

    -- Procedue     : Update (BL) Repo SETTLEMENT settlement suspense
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 19/08/1999

    M_BORR_PORTFOLIO_CODE     DN_TRN_BL_FUND.BORR_PORTFOLIO_CODE%TYPE;
    M_LEND_PORTFOLIO_CODE     DN_TRN_BL_FUND.LEND_PORTFOLIO_CODE%TYPE;
    M_BORR_PF_TYPE            DN_REF_PORTFOLIO.PF_TYPE%TYPE;
    M_LEND_PF_TYPE            DN_REF_PORTFOLIO.PF_TYPE%TYPE;
    M_CURR_ACC_VALUE          DN_TRN_BL_FUND.LEG2_VALUE%TYPE;
    M_DEAL_LEG2_VALUE         DN_TRN_BL_FUND.LEG2_VALUE%TYPE;

BEGIN

   SELECT
      SUM(SETTLE_AMOUNT)
      INTO M_CURR_ACC_VALUE
   FROM
      DN_TRN_BL_FUND_SETTLE
   WHERE
      DEAL_NO=M_DEAL_NO
      AND
      SETTLE_MODE='CURR_ACC';

   IF M_CURR_ACC_VALUE IS NULL THEN

      M_CURR_ACC_VALUE:=0;

  -- END IF; --REMARKED ON 16-05-2001 by NIRMALA (requested by nishan)

   SELECT
      A.BORR_PORTFOLIO_CODE,
      A.LEND_PORTFOLIO_CODE,
      B.PF_TYPE,
      C.PF_TYPE,
      A.LEG2_VALUE
      INTO
         M_BORR_PORTFOLIO_CODE,
         M_LEND_PORTFOLIO_CODE,
         M_BORR_PF_TYPE,
         M_LEND_PF_TYPE,
         M_DEAL_LEG2_VALUE
   FROM
      DN_TRN_BL_FUND A,
      DN_REF_PORTFOLIO B,
      DN_REF_PORTFOLIO C
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      A.LEND_PORTFOLIO_CODE=C.PORTFOLIO_CODE;

  -- Before confiremation they have to specify at least one settlement option

  IF M_DEAL_LEG2_VALUE>M_CURR_ACC_VALUE
     AND
     M_BORR_PF_TYPE='P' THEN

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
          VALUES
            ('S'||M_DEAL_NO,
             'D',
             M_LEND_PORTFOLIO_CODE,
             M_BORR_PORTFOLIO_CODE,
             (M_DEAL_LEG2_VALUE-M_CURR_ACC_VALUE),
             0,
             0,
             (M_DEAL_LEG2_VALUE-M_CURR_ACC_VALUE),
             SYSDATE,
             SYSDATE
            );


      IF M_LEND_PF_TYPE='P' THEN

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
       VALUES
           ('S'||M_DEAL_NO,
            'D',
            M_LEND_PORTFOLIO_CODE,
            M_BORR_PORTFOLIO_CODE,
            (M_DEAL_LEG2_VALUE-M_CURR_ACC_VALUE),
            0,
            0,
            (M_DEAL_LEG2_VALUE-M_CURR_ACC_VALUE),
            SYSDATE,
            SYSDATE
           );

    END IF;



  END IF;

  IF M_DEAL_LEG2_VALUE>M_CURR_ACC_VALUE
     AND
     M_LEND_PF_TYPE='P' THEN

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
          VALUES
            ('S'||M_DEAL_NO,
             'D',
             M_LEND_PORTFOLIO_CODE,
             M_BORR_PORTFOLIO_CODE,
             (M_DEAL_LEG2_VALUE-M_CURR_ACC_VALUE),
             0,
             0,
             (M_DEAL_LEG2_VALUE-M_CURR_ACC_VALUE),
             SYSDATE,
             SYSDATE
            );


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
            LAST_MOD_DATE
           )
       VALUES
          ('S'||M_DEAL_NO,
           'D',
           M_LEND_PORTFOLIO_CODE,
           M_BORR_PORTFOLIO_CODE,
           (M_DEAL_LEG2_VALUE-M_CURR_ACC_VALUE),
           0,
           0,
           (M_DEAL_LEG2_VALUE-M_CURR_ACC_VALUE),
           SYSDATE,
           SYSDATE
          );

     END IF;



  END IF;


  IF (M_DEAL_LEG2_VALUE-M_CURR_ACC_VALUE)>0 THEN

    ------- Linking to accounting sub system
    DN_ACC_LINK_BL_RS_FO_SETT(M_DEAL_NO,(M_DEAL_LEG2_VALUE-M_CURR_ACC_VALUE));

  END IF;
END IF;  --added by nirmala on 16-05-2001(requested by nishan)
END DN_SETTL_BL_RS_SUSPENSE;

/
