--------------------------------------------------------
--  DDL for Procedure DN_INV_BL_RS_SUSPENSE_LEND
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_BL_RS_SUSPENSE_LEND" 
   (
    M_DEAL_NO      DN_TRN_REPO_ROLLOVER.DEAL_NO%TYPE
   )

   IS

    -- Procedue     : Update (BL) repo SETTLEMENT inventory - suspense for LENDER
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 19/08/1999

   CURSOR  DELETE_SERIALNO IS
   SELECT
      C.INST_TYPE,
      C.INV_CODE,
      C.SECURITY_CODE,
      C.SERIAL_NO,
      C.FACE_VALUE
   FROM
      DN_TRN_BL_FUND_SERIAL_NO C
   WHERE
      C.DEAL_NO=M_DEAL_NO
      AND
      C.DATA_FROM='FO';

   --------------------------------------------------------
   CURSOR  DELETE_SEC IS
   SELECT
      C.INST_TYPE,
      C.INV_CODE,
      C.SECURITY_CODE,
      C.FACE_VALUE
   FROM
      DN_TRN_BL_FUND_SEC C
   WHERE
      C.DEAL_NO=M_DEAL_NO;


    M_LEND_PORTFOLIO_CODE           DN_TRN_REPO_ROLLOVER.LEND_PORTFOLIO_CODE%TYPE;
    M_BORR_PORTFOLIO_CODE           DN_TRN_REPO_ROLLOVER.BORR_PORTFOLIO_CODE%TYPE;
    M_INST_TYPE                     DN_TRN_REPO_ROLLOVER_SERIAL_NO.INST_TYPE%TYPE;
    M_INV_CODE                      DN_TRN_REPO_ROLLOVER_SERIAL_NO.INV_CODE%TYPE;
    M_SECURITY_CODE                 DN_TRN_REPO_ROLLOVER_SERIAL_NO.SECURITY_CODE%TYPE;
    M_SERIAL_NO                     DN_TRN_REPO_ROLLOVER_SERIAL_NO.SERIAL_NO%TYPE;
    M_FACE_VALUE                    DN_TRN_REPO_ROLLOVER_SERIAL_NO.FACE_VALUE%TYPE;
    M_LEND_PF_TYPE                  DN_REF_PORTFOLIO.PF_TYPE%TYPE;
    M_BORR_PF_TYPE                  DN_REF_PORTFOLIO.PF_TYPE%TYPE;
    M_EFF_VALDATE                   DN_TRN_REPO_ROLLOVER.EFF_VALDATE%TYPE;
    M_DEAL_PHYSICAL_DELIVERY        DN_TRN_REPO_ROLLOVER.PHYSICAL_DELIVERY%TYPE;
    M_INST_COUNT                    NUMBER;
    M_SEC_COUNT                     NUMBER;
    M_SERIAL_NO_COUNT               NUMBER;


BEGIN

     SELECT
        A.LEND_PORTFOLIO_CODE,
        A.BORR_PORTFOLIO_CODE,
        A.EFF_VALDATE, --should be maturity date--inserted by sm on 20-03-2000
        B.PF_TYPE,
        C.PF_TYPE,
        A.PHYSICAL_DELIVERY
       INTO M_LEND_PORTFOLIO_CODE,M_BORR_PORTFOLIO_CODE,
            M_EFF_VALDATE,
            M_LEND_PF_TYPE,M_BORR_PF_TYPE,
            M_DEAL_PHYSICAL_DELIVERY
     FROM
        DN_TRN_BL_FUND A,
        DN_REF_PORTFOLIO B,
        DN_REF_PORTFOLIO C
     WHERE
        A.DEAL_NO=M_DEAL_NO
        AND
        A.LEND_PORTFOLIO_CODE=B.PORTFOLIO_CODE
        AND
        A.BORR_PORTFOLIO_CODE=C.PORTFOLIO_CODE;


        SELECT
           COUNT(*) INTO M_INST_COUNT
        FROM
           DN_TRN_BL_FUND_INST
        WHERE
           DEAL_NO=M_DEAL_NO;

        SELECT
           COUNT(*) INTO M_SEC_COUNT
        FROM
           DN_TRN_BL_FUND_SEC
        WHERE
           DEAL_NO=M_DEAL_NO;

        SELECT
           COUNT(*) INTO M_SERIAL_NO_COUNT
        FROM
           DN_TRN_BL_FUND_SERIAL_NO
        WHERE
           DEAL_NO=M_DEAL_NO;


  IF   M_LEND_PF_TYPE='P'
       AND
       M_INST_COUNT>0
       AND
       M_SEC_COUNT>0
       AND
       M_SERIAL_NO_COUNT>0
       AND
       M_DEAL_PHYSICAL_DELIVERY='Y' THEN

       -- Serial no information is already there

       ----------------------------------------
       ------ For DELETE serial numbers  ------
       ----------------------------------------
  --  RAISE_APPLICATION_ERROR(-20201,'INSIDE');

   -- Lender issues from BL inventory

        OPEN DELETE_SERIALNO;

        LOOP

           FETCH  DELETE_SERIALNO INTO

           M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,M_SERIAL_NO,M_FACE_VALUE;

           EXIT WHEN DELETE_SERIALNO%NOTFOUND;

           UPDATE DN_INV_SUS_ISSUE_INST A
           SET
              A.ACT_FACE_VALUE     =A.ACT_FACE_VALUE+M_FACE_VALUE,
              A.INT_BALANCE        =A.INT_BALANCE+M_FACE_VALUE,
              A.BAL_TO_BE_ISSUED   =A.BAL_TO_BE_ISSUED+M_FACE_VALUE
           WHERE
              A.DEAL_NO=M_DEAL_NO
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.INV_CODE='BL'
              AND
              A.RECEIVER_CODE=M_BORR_PORTFOLIO_CODE
              AND
              A.SENDER_CODE=M_LEND_PORTFOLIO_CODE;

        IF SQL%NOTFOUND THEN

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
         VALUES
            (M_DEAL_NO,
             M_INST_TYPE,
             'BL',
             M_BORR_PORTFOLIO_CODE,
             M_LEND_PORTFOLIO_CODE,
             M_EFF_VALDATE,
             M_FACE_VALUE,
             0,
             M_FACE_VALUE,
             0,
             M_FACE_VALUE,
             SYSDATE,
             SYSDATE
            );

     END IF;

        UPDATE DN_INV_SUS_ISSUE_SEC A
         SET
            A.ACT_FACE_VALUE      =A.ACT_FACE_VALUE+M_FACE_VALUE,
            A.INT_BALANCE         =A.INT_BALANCE+M_FACE_VALUE,
            A.BAL_TO_BE_ISSUED  =A.BAL_TO_BE_ISSUED+M_FACE_VALUE
         WHERE
            A.DEAL_NO=M_DEAL_NO
            AND
            A.INST_TYPE=M_INST_TYPE
            AND
            A.INV_CODE='BL'
            AND
            A.SECURITY_CODE=M_SECURITY_CODE
            AND
            A.RECEIVER_CODE=M_BORR_PORTFOLIO_CODE
            AND
            A.SENDER_CODE=M_LEND_PORTFOLIO_CODE;

        IF SQL%NOTFOUND THEN

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
        VALUES
          (M_DEAL_NO,
           M_INST_TYPE,
           M_SECURITY_CODE,
           'BL',
           M_BORR_PORTFOLIO_CODE,
           M_LEND_PORTFOLIO_CODE,
           M_EFF_VALDATE,
           M_FACE_VALUE,
           0,
           M_FACE_VALUE,
           0,
           M_FACE_VALUE,
           SYSDATE,
           SYSDATE
          );

       END IF;

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
          VALUES
            (M_DEAL_NO,
             M_INST_TYPE,
             M_SECURITY_CODE,
             M_SERIAL_NO,
             M_BORR_PORTFOLIO_CODE,
             M_LEND_PORTFOLIO_CODE,
             M_EFF_VALDATE,
             M_FACE_VALUE,
             0,
             M_FACE_VALUE,
             0,
             M_FACE_VALUE,
             SYSDATE,
             SYSDATE,
             'BL'
            );

      END LOOP;


ELSIF   M_LEND_PF_TYPE='P'
          AND
          M_INST_COUNT>0
          AND
          M_SEC_COUNT>0
          AND
          M_SERIAL_NO_COUNT=0
          AND
          M_DEAL_PHYSICAL_DELIVERY='Y' THEN


        OPEN DELETE_SEC;

        LOOP

           FETCH  DELETE_SEC INTO

           M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,M_FACE_VALUE;

           EXIT WHEN DELETE_SEC%NOTFOUND;

           UPDATE DN_INV_SUS_ISSUE_INST A
           SET
              A.ACT_FACE_VALUE     =A.ACT_FACE_VALUE+M_FACE_VALUE,
              A.INT_BALANCE        =A.INT_BALANCE+M_FACE_VALUE,
              A.BAL_TO_BE_ISSUED =A.BAL_TO_BE_ISSUED+M_FACE_VALUE
           WHERE
              A.DEAL_NO=M_DEAL_NO
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.INV_CODE='BL'
              AND
              A.RECEIVER_CODE=M_BORR_PORTFOLIO_CODE
              AND
              A.SENDER_CODE=M_LEND_PORTFOLIO_CODE;

        IF SQL%NOTFOUND THEN

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
         VALUES
            (M_DEAL_NO,
             M_INST_TYPE,
             'BL',
             M_BORR_PORTFOLIO_CODE,
             M_LEND_PORTFOLIO_CODE,
             M_EFF_VALDATE,
             M_FACE_VALUE,
             0,
             M_FACE_VALUE,
             0,
             M_FACE_VALUE,
             SYSDATE,
             SYSDATE
            );

     END IF;

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
        VALUES
          (M_DEAL_NO,
           M_INST_TYPE,
           M_SECURITY_CODE,
           'BL',
           M_BORR_PORTFOLIO_CODE,
           M_LEND_PORTFOLIO_CODE,
           M_EFF_VALDATE,
           M_FACE_VALUE,
           0,
           M_FACE_VALUE,
           0,
           M_FACE_VALUE,
           SYSDATE,
           SYSDATE
          );

      END LOOP;

      CLOSE DELETE_SEC;

END IF;

END DN_INV_BL_RS_SUSPENSE_LEND;

/
