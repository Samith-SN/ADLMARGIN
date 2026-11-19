--------------------------------------------------------
--  DDL for Procedure DN_INV_REPO_PI_SUSPENSE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_REPO_PI_SUSPENSE" 
   (
    M_DEAL_NO      DN_TRN_REPO_PERIOD_INT.DEAL_NO%TYPE
   )

   AS

    -- Procedue     : Update Repo periodic Interst inventory - suspense
    -- System       : Dealnet system
    -- Created by   : V.Thilakesan.
    -- Created on   : 02/03/2000

    M_LEND_PORTFOLIO_CODE     DN_TRN_REPO_PERIOD_INT.LEND_PORTFOLIO_CODE%TYPE;
    M_BORR_PORTFOLIO_CODE     DN_TRN_REPO_PERIOD_INT.BORR_PORTFOLIO_CODE%TYPE;
    M_LEND_PF_TYPE            DN_REF_PORTFOLIO.PF_TYPE%TYPE;
    M_BORR_PF_TYPE            DN_REF_PORTFOLIO.PF_TYPE%TYPE;
    M_EFF_VALDATE             DN_TRN_REPO_PERIOD_INT.EFF_VALDATE%TYPE;
    M_PHYSICAL_DELIVERY       DN_TRN_REPO_PERIOD_INT.PHYSICAL_DELIVERY%TYPE;
    M_INST_COUNT              NUMBER;
    M_SEC_COUNT               NUMBER;
    M_SERIAL_NO_COUNT         NUMBER;


BEGIN

   SELECT
      COUNT(*) INTO M_INST_COUNT
   FROM
      DN_TRN_REPO_PERIOD_INT_INST
   WHERE
      DEAL_NO=M_DEAL_NO;

   SELECT
      COUNT(*) INTO M_SEC_COUNT
   FROM
      DN_TRN_REPO_PERIOD_INT_SEC
   WHERE
      DEAL_NO=M_DEAL_NO;

   SELECT
      COUNT(*) INTO M_SERIAL_NO_COUNT
   FROM
      DN_TRN_REPO_PERIOD_INT_SERIAL
   WHERE
      DEAL_NO=M_DEAL_NO;

   SELECT
      A.LEND_PORTFOLIO_CODE,
      A.BORR_PORTFOLIO_CODE,
      A.EFF_VALDATE,
      B.PF_TYPE,
      C.PF_TYPE,
      A.PHYSICAL_DELIVERY
      INTO  M_LEND_PORTFOLIO_CODE,M_BORR_PORTFOLIO_CODE,
            M_EFF_VALDATE,
            M_LEND_PF_TYPE,M_BORR_PF_TYPE,
            M_PHYSICAL_DELIVERY
   FROM
      DN_TRN_REPO_PERIOD_INT A,
      DN_REF_PORTFOLIO B,
      DN_REF_PORTFOLIO C
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.LEND_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      A.BORR_PORTFOLIO_CODE=C.PORTFOLIO_CODE;

 IF M_PHYSICAL_DELIVERY='Y' THEN

    -- For Lender (Receiver of security)

     IF M_LEND_PF_TYPE='P'
        AND
        M_INST_COUNT>0
        AND
        M_SEC_COUNT>0
        AND
        M_SERIAL_NO_COUNT>0 THEN

        -- Serial no information is already there

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
            A.LAST_MOD_DATE,
            A.INV_CODE
            )
          SELECT
             B.DEAL_NO,
             C.INST_TYPE,
             B.LEND_PORTFOLIO_CODE,
             B.BORR_PORTFOLIO_CODE,
             B.EFF_VALDATE,
             SUM(C.FACE_VALUE),
             0,
             SUM(C.FACE_VALUE),
             0,
             SUM(C.FACE_VALUE),
             SYSDATE,
             SYSDATE,
             'RP'
          FROM
             DN_TRN_REPO_PERIOD_INT B,
             DN_TRN_REPO_PERIOD_INT_SERIAL C
          WHERE
             B.DEAL_NO=M_DEAL_NO
             AND
             B.DEAL_NO=C.DEAL_NO
         GROUP BY  B.DEAL_NO,
                   C.INST_TYPE,
                   B.LEND_PORTFOLIO_CODE,
                   B.BORR_PORTFOLIO_CODE,
                   B.EFF_VALDATE;


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
            A.LAST_MOD_DATE,
            A.INV_CODE
            )
          SELECT
             B.DEAL_NO,
             C.INST_TYPE,
             C.SECURITY_CODE,
             B.LEND_PORTFOLIO_CODE,
             B.BORR_PORTFOLIO_CODE,
             B.EFF_VALDATE,
             SUM(C.FACE_VALUE),
             0,
             SUM(C.FACE_VALUE),
             0,
             SUM(C.FACE_VALUE),
             SYSDATE,
             SYSDATE,
             'RP'
          FROM
             DN_TRN_REPO_PERIOD_INT B,
             DN_TRN_REPO_PERIOD_INT_SERIAL C
          WHERE
             B.DEAL_NO=M_DEAL_NO
             AND
             B.DEAL_NO=C.DEAL_NO
         GROUP BY  B.DEAL_NO,
                   C.INST_TYPE,
                   C.SECURITY_CODE,
                   B.LEND_PORTFOLIO_CODE,
                   B.BORR_PORTFOLIO_CODE,
                   B.EFF_VALDATE;

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
            A.LAST_MOD_DATE,
            A.INV_CODE
            )
          SELECT
             B.DEAL_NO,
             C.INST_TYPE,
             C.SECURITY_CODE,
             C.SERIAL_NO,
             B.LEND_PORTFOLIO_CODE,
             B.BORR_PORTFOLIO_CODE,
             B.EFF_VALDATE,
             C.FACE_VALUE,
             0,
             C.FACE_VALUE,
             0,
             C.FACE_VALUE,
             SYSDATE,
             SYSDATE,
             'RP'
          FROM
             DN_TRN_REPO_PERIOD_INT B,
             DN_TRN_REPO_PERIOD_INT_SERIAL C
          WHERE
             B.DEAL_NO=M_DEAL_NO
             AND
             B.DEAL_NO=C.DEAL_NO;

     ELSIF M_LEND_PF_TYPE='P'
        AND
        M_INST_COUNT>0
        AND
        M_SEC_COUNT>0
        AND
        M_SERIAL_NO_COUNT=0 THEN

        -- Upto security information only

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
            A.LAST_MOD_DATE,
            A.INV_CODE
            )
          SELECT
             B.DEAL_NO,
             C.INST_TYPE,
             B.LEND_PORTFOLIO_CODE,
             B.BORR_PORTFOLIO_CODE,
             B.EFF_VALDATE,
             SUM(C.FACE_VALUE),
             0,
             SUM(C.FACE_VALUE),
             0,
             SUM(C.FACE_VALUE),
             SYSDATE,
             SYSDATE,
             'RP'
          FROM
             DN_TRN_REPO_PERIOD_INT B,
             DN_TRN_REPO_PERIOD_INT_SEC C
          WHERE
             B.DEAL_NO=M_DEAL_NO
             AND
             B.DEAL_NO=C.DEAL_NO
         GROUP BY  B.DEAL_NO,
                   C.INST_TYPE,
                   B.LEND_PORTFOLIO_CODE,
                   B.BORR_PORTFOLIO_CODE,
                   B.EFF_VALDATE;

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
            A.LAST_MOD_DATE,
            A.INV_CODE
            )
          SELECT
             B.DEAL_NO,
             C.INST_TYPE,
             C.SECURITY_CODE,
             B.LEND_PORTFOLIO_CODE,
             B.BORR_PORTFOLIO_CODE,
             B.EFF_VALDATE,
             C.FACE_VALUE,
             0,
             C.FACE_VALUE,
             0,
             C.FACE_VALUE,
             SYSDATE,
             SYSDATE,
             'RP'
          FROM
             DN_TRN_REPO_PERIOD_INT B,
             DN_TRN_REPO_PERIOD_INT_SEC C
          WHERE
             B.DEAL_NO=M_DEAL_NO
             AND
             B.DEAL_NO=C.DEAL_NO;

     END IF;

     IF M_BORR_PF_TYPE='P' THEN

        -- For the Borrower information (Issuer of the security)
        -- Serial no information is already there

       INSERT INTO DN_INV_SUS_ISSUE_INST A
           (A.DEAL_NO,
            A.INST_TYPE,
            A.INV_CODE,
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
             D.INST_TYPE,
             C.INV_CODE,
             B.LEND_PORTFOLIO_CODE,
             B.BORR_PORTFOLIO_CODE,
             B.EFF_VALDATE,
             SUM(C.FACE_VALUE),
             0,
             SUM(C.FACE_VALUE),
             0,
             SUM(C.FACE_VALUE),
             SYSDATE,
             SYSDATE
          FROM
             DN_TRN_REPO_PERIOD_INT B,
             DN_TRN_REPO_PERIOD_INT_SERIAL C,
             DN_REF_SECURITY D
          WHERE
             B.DEAL_NO=M_DEAL_NO
             AND
             B.DEAL_NO=C.DEAL_NO
             AND
             C.SECURITY_CODE=D.SECURITY_CODE
         GROUP BY  B.DEAL_NO,
                   D.INST_TYPE,
                   C.INV_CODE,
                   B.LEND_PORTFOLIO_CODE,
                   B.BORR_PORTFOLIO_CODE,
                   B.EFF_VALDATE;

        INSERT INTO DN_INV_SUS_ISSUE_SEC A
           (A.DEAL_NO,
            A.INST_TYPE,
            A.SECURITY_CODE,
            A.INV_CODE,
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
             D.INST_TYPE,
             C.SECURITY_CODE,
             C.INV_CODE,
             B.LEND_PORTFOLIO_CODE,
             B.BORR_PORTFOLIO_CODE,
             B.EFF_VALDATE,
             SUM(C.FACE_VALUE),
             0,
             SUM(C.FACE_VALUE),
             0,
             SUM(C.FACE_VALUE),
             SYSDATE,
             SYSDATE
          FROM
             DN_TRN_REPO_PERIOD_INT B,
             DN_TRN_REPO_PERIOD_INT_SERIAL C,
             DN_REF_SECURITY D
          WHERE
             B.DEAL_NO=M_DEAL_NO
             AND
             B.DEAL_NO=C.DEAL_NO
             AND
             C.SECURITY_CODE=D.SECURITY_CODE
         GROUP BY  B.DEAL_NO,
                   D.INST_TYPE,
                   C.SECURITY_CODE,
                   C.INV_CODE,
                   B.LEND_PORTFOLIO_CODE,
                   B.BORR_PORTFOLIO_CODE,
                   B.EFF_VALDATE;

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
             B.LEND_PORTFOLIO_CODE,
             B.BORR_PORTFOLIO_CODE,
             B.EFF_VALDATE,
             C.FACE_VALUE,
             0,
             C.FACE_VALUE,
             0,
             C.FACE_VALUE,
             SYSDATE,
             SYSDATE,
             C.INV_CODE
          FROM
             DN_TRN_REPO_PERIOD_INT B,
             DN_TRN_REPO_PERIOD_INT_SERIAL C,
             DN_REF_SECURITY D
          WHERE
             B.DEAL_NO=M_DEAL_NO
             AND
             B.DEAL_NO=C.DEAL_NO
             AND
             C.SECURITY_CODE=D.SECURITY_CODE;

     END IF;

 END IF;
--  EXCEPTION
 -- WHEN OTHERS THEN

--RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO);


END DN_INV_REPO_PI_SUSPENSE;

/
