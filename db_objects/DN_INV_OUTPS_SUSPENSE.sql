--------------------------------------------------------
--  DDL for Procedure DN_INV_OUTPS_SUSPENSE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_OUTPS_SUSPENSE" 
   (
    M_DEAL_NO      DN_TRN_OUTP_SALE.DEAL_NO%TYPE
   )

   IS

    -- Procedue     : Update outright inventory - suspense
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 12/07/1999

    M_BUY_PORTFOLIO_CODE      DN_TRN_OUTP_SALE.BUY_PORTFOLIO_CODE%TYPE;
    M_SELL_PORTFOLIO_CODE     DN_TRN_OUTP_SALE.SELL_PORTFOLIO_CODE%TYPE;
    M_BUY_PF_TYPE             DN_REF_PORTFOLIO.PF_TYPE%TYPE;
    M_SELL_PF_TYPE            DN_REF_PORTFOLIO.PF_TYPE%TYPE;
    M_FACE_VALUE              DN_TRN_OUTP_SALE.FACE_VALUE%TYPE;
    M_EFF_VALDATE             DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE;

BEGIN

   SELECT
      A.BUY_PORTFOLIO_CODE,
      A.SELL_PORTFOLIO_CODE,
      A.FACE_VALUE,
      A.EFF_VALDATE,
      B.PF_TYPE,
      C.PF_TYPE
      INTO  M_BUY_PORTFOLIO_CODE,M_SELL_PORTFOLIO_CODE,
            M_FACE_VALUE,M_EFF_VALDATE,
            M_BUY_PF_TYPE,M_SELL_PF_TYPE
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B,
      DN_REF_PORTFOLIO C
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.BUY_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      A.SELL_PORTFOLIO_CODE=C.PORTFOLIO_CODE;

  -- For buyer

     IF M_BUY_PF_TYPE='P' THEN

        INSERT INTO DN_INV_SUS_RECEIPT_INST A
           (A.DEAL_NO,
            A.INST_TYPE,
            A.RECEIVER_CODE,
            A.SENDER_CODE,
            A.EFF_VALDATE,
            A.ACT_FACE_VALUE,
            A.INT_SET_FACE_VALUE,
            A.INT_BALANCE,
            A.REC_FROM_INT_BAL,
            A.BAL_TO_BE_RECEIVED,
            A.ENT_DATE,
            A.LAST_MOD_DATE
            )
          SELECT
             B.DEAL_NO,
             B.INST_TYPE,
             B.BUY_PORTFOLIO_CODE,
             B.SELL_PORTFOLIO_CODE,
             B.EFF_VALDATE,
             B.FACE_VALUE,
             0,
             B.FACE_VALUE,
             0,
             B.FACE_VALUE,
             SYSDATE,
             SYSDATE
          FROM
             DN_TRN_OUTP_SALE B

          WHERE
             B.DEAL_NO=M_DEAL_NO ;

        INSERT INTO DN_INV_SUS_RECEIPT_SEC A
           (A.DEAL_NO,
            A.INST_TYPE,
            A.SECURITY_CODE,
            A.RECEIVER_CODE,
            A.SENDER_CODE,
            A.EFF_VALDATE,
            A.ACT_FACE_VALUE,
            A.INT_SET_FACE_VALUE,
            A.INT_BALANCE,
            A.REC_FROM_INT_BAL,
            A.BAL_TO_BE_RECEIVED,
            A.ENT_DATE,
            A.LAST_MOD_DATE
            )
          SELECT
             B.DEAL_NO,
             B.INST_TYPE,
             B.SECURITY_CODE,
             B.BUY_PORTFOLIO_CODE,
             B.SELL_PORTFOLIO_CODE,
             B.EFF_VALDATE,
             B.FACE_VALUE,
             0,
             B.FACE_VALUE,
             0,
             B.FACE_VALUE,
             SYSDATE,
             SYSDATE
          FROM
             DN_TRN_OUTP_SALE B
          WHERE
             B.DEAL_NO=M_DEAL_NO;

        INSERT INTO DN_INV_SUS_RECEIPT_SERIAL_NO A
           (A.DEAL_NO,
            A.INST_TYPE,
            A.SECURITY_CODE,
            A.SERIAL_NO,
            A.RECEIVER_CODE,
            A.SENDER_CODE,
            A.EFF_VALDATE,
            A.ACT_FACE_VALUE,
            A.INT_SET_FACE_VALUE,
            A.INT_BALANCE,
            A.REC_FROM_INT_BAL,
            A.BAL_TO_BE_RECEIVED,
            A.ENT_DATE,
            A.LAST_MOD_DATE
            )
          SELECT
             B.DEAL_NO,
             D.INST_TYPE,
             C.SECURITY_CODE,
             C.SERIAL_NO,
             B.BUY_PORTFOLIO_CODE,
             B.SELL_PORTFOLIO_CODE,
             B.EFF_VALDATE,
             C.FACE_VALUE,
             0,
             C.FACE_VALUE,
             0,
             C.FACE_VALUE,
             SYSDATE,
             SYSDATE
          FROM
             DN_TRN_OUTP_SALE B,
             DN_TRN_OUTP_SALE_SEC C,
             DN_REF_SECURITY D
          WHERE
             B.DEAL_NO=M_DEAL_NO
             AND
             B.DEAL_NO=C.DEAL_NO
             AND
             B.SECURITY_CODE=D.SECURITY_CODE;
     END IF;

     IF M_SELL_PF_TYPE='P' THEN

        -- For the seller information

       INSERT INTO DN_INV_SUS_ISSUE_INST A
           (A.DEAL_NO,
            A.INST_TYPE,
            A.RECEIVER_CODE,
            A.SENDER_CODE,
            A.EFF_VALDATE,
            A.ACT_FACE_VALUE,
            A.INT_SET_FACE_VALUE,
            A.INT_BALANCE,
            A.ISSUE_FROM_INT_BAL,
            A.BAL_TO_BE_ISSUED,
            A.ENT_DATE,
            A.LAST_MOD_DATE
            )
          SELECT
             B.DEAL_NO,
             B.INST_TYPE,
             B.BUY_PORTFOLIO_CODE,
             B.SELL_PORTFOLIO_CODE,
             B.EFF_VALDATE,
             B.FACE_VALUE,
             0,
             B.FACE_VALUE,
             0,
             B.FACE_VALUE,
             SYSDATE,
             SYSDATE
          FROM
             DN_TRN_OUTP_SALE B
          WHERE
             B.DEAL_NO=M_DEAL_NO
             AND B.SCRIPT_STATUS='SC';--$$##SC

        INSERT INTO DN_INV_SUS_ISSUE_SEC A
           (A.DEAL_NO,
            A.INST_TYPE,
            A.SECURITY_CODE,
            A.RECEIVER_CODE,
            A.SENDER_CODE,
            A.EFF_VALDATE,
            A.ACT_FACE_VALUE,
            A.INT_SET_FACE_VALUE,
            A.INT_BALANCE,
            A.ISSUE_FROM_INT_BAL,
            A.BAL_TO_BE_ISSUED,
            A.ENT_DATE,
            A.LAST_MOD_DATE
            )
          SELECT
             B.DEAL_NO,
             B.INST_TYPE,
             B.SECURITY_CODE,
             B.BUY_PORTFOLIO_CODE,
             B.SELL_PORTFOLIO_CODE,
             B.EFF_VALDATE,
             B.FACE_VALUE,
             0,
             B.FACE_VALUE,
             0,
             B.FACE_VALUE,
             SYSDATE,
             SYSDATE
          FROM
             DN_TRN_OUTP_SALE B
          WHERE
             B.DEAL_NO=M_DEAL_NO
             AND B.SCRIPT_STATUS='SC';--$$##SC

        INSERT INTO DN_INV_SUS_ISSUE_SERIAL_NO A
           (A.DEAL_NO,
            A.INST_TYPE,
            A.SECURITY_CODE,
            A.SERIAL_NO,
            A.RECEIVER_CODE,
            A.SENDER_CODE,
            A.EFF_VALDATE,
            A.ACT_FACE_VALUE,
            A.INT_SET_FACE_VALUE,
            A.INT_BALANCE,
            A.ISSUE_FROM_INT_BAL,
            A.BAL_TO_BE_ISSUED,
            A.ENT_DATE,
            A.LAST_MOD_DATE,
            A.INV_CODE
            )
          SELECT
             B.DEAL_NO,
             D.INST_TYPE,
             C.SECURITY_CODE,
             C.SERIAL_NO,
             B.BUY_PORTFOLIO_CODE,
             B.SELL_PORTFOLIO_CODE,
             B.EFF_VALDATE,
             C.FACE_VALUE,
             0,
             C.FACE_VALUE,
             0,
             C.FACE_VALUE,
             SYSDATE,
             SYSDATE,
             'OR'
          FROM
             DN_TRN_OUTP_SALE B,
             DN_TRN_OUTP_SALE_SEC C,
             DN_REF_SECURITY D
          WHERE
             B.DEAL_NO=M_DEAL_NO
             AND
             B.DEAL_NO=C.DEAL_NO
             AND
             B.SECURITY_CODE=D.SECURITY_CODE  AND B.SCRIPT_STATUS='SC';--$$##SC

     END IF;

END DN_INV_OUTPS_SUSPENSE;

/
