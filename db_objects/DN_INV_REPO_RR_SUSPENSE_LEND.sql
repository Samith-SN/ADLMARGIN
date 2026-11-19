--------------------------------------------------------
--  DDL for Procedure DN_INV_REPO_RR_SUSPENSE_LEND
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_REPO_RR_SUSPENSE_LEND" 
   (
    M_DEAL_NO      DN_TRN_REPO_ROLLOVER.DEAL_NO%TYPE
   )

   IS

    -- Procedue     : Update repo rollover inventory - suspense for LENDER
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 04/08/1999

   CURSOR  SAME_SERIALNO IS
    SELECT
       C.INST_TYPE,
       C.INV_CODE,
       C.SECURITY_CODE,
       C.SERIAL_NO,
       C.FACE_VALUE,
       C.FACE_VALUE_CURR--CURRENCY
    FROM
       DN_TRN_REPO_ROLLOVER B,
       DN_TRN_REPO_ROLLOVER_SERIAL_NO C
    WHERE
       B.DEAL_NO=M_DEAL_NO
       AND
       B.DEAL_NO=C.DEAL_NO
       AND
       B.PRIOR_DEAL_NO||C.INST_TYPE||C.INV_CODE||C.SECURITY_CODE||C.SERIAL_NO
       IN
         (
          SELECT
             D.DEAL_NO||D.INST_TYPE||D.INV_CODE||D.SECURITY_CODE||D.SERIAL_NO
          FROM
             DN_TRN_REPO_FRESH_SERIAL_NO D
          WHERE
             D.DEAL_NO=B.PRIOR_DEAL_NO
          UNION ALL
          SELECT
             E.DEAL_NO||E.INST_TYPE||E.INV_CODE||E.SECURITY_CODE||E.SERIAL_NO
          FROM
             DN_TRN_REPO_ROLLOVER_SERIAL_NO E
          WHERE
             E.DEAL_NO=B.PRIOR_DEAL_NO
         );

   CURSOR  NEW_SERIALNO IS
    SELECT
       C.INST_TYPE,
       C.INV_CODE,
       C.SECURITY_CODE,
       C.SERIAL_NO,
       C.FACE_VALUE,
       C.FACE_VALUE_CURR--CURRENCY
      FROM
       DN_TRN_REPO_ROLLOVER B,
       DN_TRN_REPO_ROLLOVER_SERIAL_NO C
    WHERE
       B.DEAL_NO=M_DEAL_NO
       AND
       B.DEAL_NO=C.DEAL_NO
       AND
       B.PRIOR_DEAL_NO||C.INST_TYPE||C.INV_CODE||C.SECURITY_CODE||C.SERIAL_NO
       NOT IN
         (
          SELECT
             D.DEAL_NO||D.INST_TYPE||D.INV_CODE||D.SECURITY_CODE||D.SERIAL_NO
          FROM
             DN_TRN_REPO_FRESH_SERIAL_NO D
          WHERE
             D.DEAL_NO=B.PRIOR_DEAL_NO
          UNION ALL
          SELECT
             E.DEAL_NO||E.INST_TYPE||E.INV_CODE||E.SECURITY_CODE||E.SERIAL_NO
          FROM
             DN_TRN_REPO_ROLLOVER_SERIAL_NO E
          WHERE
             E.DEAL_NO=B.PRIOR_DEAL_NO
         );

   CURSOR  DELETE_SERIALNO_RF IS
   SELECT
      C.INST_TYPE,
      C.INV_CODE,
      C.SECURITY_CODE,
      C.SERIAL_NO,
      C.FACE_VALUE,
      C.FACE_VALUE_CURR--CURRENCY
   FROM
      DN_TRN_REPO_ROLLOVER B,
      DN_TRN_REPO_FRESH_SERIAL_NO C
   WHERE
      B.DEAL_NO=M_DEAL_NO
      AND
      B.PRIOR_DEAL_NO=C.DEAL_NO
      AND
      C.DEAL_NO||C.INST_TYPE||C.INV_CODE||C.SECURITY_CODE||C.SERIAL_NO
      NOT IN
        (SELECT
            C.DEAL_NO||D.INST_TYPE||D.INV_CODE||D.SECURITY_CODE||D.SERIAL_NO
         FROM
            DN_TRN_REPO_ROLLOVER_SERIAL_NO D
         WHERE
            D.DEAL_NO=M_DEAL_NO);

   CURSOR  DELETE_SERIALNO_RR IS
   SELECT
      C.INST_TYPE,
      C.INV_CODE,
      C.SECURITY_CODE,
      C.SERIAL_NO,
      C.FACE_VALUE,
      C.FACE_VALUE_CURR--CURRENCY
   FROM
      DN_TRN_REPO_ROLLOVER B,
      DN_TRN_REPO_ROLLOVER_SERIAL_NO C
   WHERE
      B.DEAL_NO=M_DEAL_NO
      AND
      B.PRIOR_DEAL_NO=C.DEAL_NO
      AND
      C.DEAL_NO||C.INST_TYPE||C.INV_CODE||C.SECURITY_CODE||C.SERIAL_NO
      NOT IN
      (SELECT
          C.DEAL_NO||D.INST_TYPE||D.INV_CODE||D.SECURITY_CODE||D.SERIAL_NO
       FROM
          DN_TRN_REPO_ROLLOVER_SERIAL_NO D
       WHERE
          D.DEAL_NO=M_DEAL_NO);

   --------------------------------------------------------------
   CURSOR  SAME_SEC IS
    SELECT
       C.INST_TYPE,
       C.INV_CODE,
       C.SECURITY_CODE,
       C.FACE_VALUE,
       C.FACE_VALUE_CURR--CURRENCY
    FROM
       DN_TRN_REPO_ROLLOVER B,
       DN_TRN_REPO_ROLLOVER_SEC C
    WHERE
       B.DEAL_NO=M_DEAL_NO
       AND
       B.DEAL_NO=C.DEAL_NO
       AND
       B.PRIOR_DEAL_NO||C.INST_TYPE||C.INV_CODE||C.SECURITY_CODE
       IN
         (
          SELECT
             D.DEAL_NO||D.INST_TYPE||D.INV_CODE||D.SECURITY_CODE
          FROM
             DN_TRN_REPO_FRESH_SEC D
          WHERE
             D.DEAL_NO=B.PRIOR_DEAL_NO
          UNION ALL
          SELECT
             E.DEAL_NO||E.INST_TYPE||E.INV_CODE||E.SECURITY_CODE
          FROM
             DN_TRN_REPO_ROLLOVER_SEC E
          WHERE
             E.DEAL_NO=B.PRIOR_DEAL_NO
         );

   CURSOR  NEW_SEC IS
    SELECT
       C.INST_TYPE,
       C.INV_CODE,
       C.SECURITY_CODE,
       C.FACE_VALUE,
       C.FACE_VALUE_CURR--CURRENCY
      FROM
       DN_TRN_REPO_ROLLOVER B,
       DN_TRN_REPO_ROLLOVER_SEC C
    WHERE
       B.DEAL_NO=M_DEAL_NO
       AND
       B.DEAL_NO=C.DEAL_NO
       AND
       B.PRIOR_DEAL_NO||C.INST_TYPE||C.INV_CODE||C.SECURITY_CODE
       NOT IN
         (
          SELECT
             D.DEAL_NO||D.INST_TYPE||D.INV_CODE||D.SECURITY_CODE
          FROM
             DN_TRN_REPO_FRESH_SEC D
          WHERE
             D.DEAL_NO=B.PRIOR_DEAL_NO
          UNION ALL
          SELECT
             E.DEAL_NO||E.INST_TYPE||E.INV_CODE||E.SECURITY_CODE
          FROM
             DN_TRN_REPO_ROLLOVER_SEC E
          WHERE
             E.DEAL_NO=B.PRIOR_DEAL_NO
         );

   CURSOR  DELETE_SEC_RF IS
   SELECT
      C.INST_TYPE,
      C.INV_CODE,
      C.SECURITY_CODE,
      C.FACE_VALUE,
       C.FACE_VALUE_CURR--CURRENCY
   FROM
      DN_TRN_REPO_ROLLOVER B,
      DN_TRN_REPO_FRESH_SEC C
   WHERE
      B.DEAL_NO=M_DEAL_NO
      AND
      B.PRIOR_DEAL_NO=C.DEAL_NO
      AND
      C.DEAL_NO||C.INST_TYPE||C.INV_CODE||C.SECURITY_CODE
      NOT IN
        (SELECT
            C.DEAL_NO||D.INST_TYPE||D.INV_CODE||D.SECURITY_CODE
         FROM
            DN_TRN_REPO_ROLLOVER_SEC D
         WHERE
            D.DEAL_NO=M_DEAL_NO);

   CURSOR  DELETE_SEC_RR IS
   SELECT
      C.INST_TYPE,
      C.INV_CODE,
      C.SECURITY_CODE,
      C.FACE_VALUE,
       C.FACE_VALUE_CURR--CURRENCY
   FROM
      DN_TRN_REPO_ROLLOVER B,
      DN_TRN_REPO_ROLLOVER_SEC C
   WHERE
      B.DEAL_NO=M_DEAL_NO
      AND
      B.PRIOR_DEAL_NO=C.DEAL_NO
      AND
      C.DEAL_NO||C.INST_TYPE||C.INV_CODE||C.SECURITY_CODE
      NOT IN
      (SELECT
          C.DEAL_NO||D.INST_TYPE||D.INV_CODE||D.SECURITY_CODE
       FROM
          DN_TRN_REPO_ROLLOVER_SEC D
       WHERE
          D.DEAL_NO=M_DEAL_NO);
    --------------------------------------------------------------

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
    M_PRIOR_DEAL_PHYSICAL_DELIVERY  DN_TRN_REPO_ROLLOVER.PHYSICAL_DELIVERY%TYPE;
    M_PRIOR_DEAL_NO                 DN_TRN_REPO_ROLLOVER.PRIOR_DEAL_NO%TYPE;
    M_INST_COUNT                    NUMBER;
    M_SEC_COUNT                     NUMBER;
    M_SERIAL_NO_COUNT               NUMBER;
    M_FACE_VALUE_CURR                    DN_TRN_REPO_ROLLOVER_SERIAL_NO.FACE_VALUE%TYPE;--CURRENCY

BEGIN

   SELECT
      COUNT(*) INTO M_INST_COUNT
   FROM
      DN_TRN_REPO_ROLLOVER_INST
   WHERE
      DEAL_NO=M_DEAL_NO;

   SELECT
      COUNT(*) INTO M_SEC_COUNT
   FROM
      DN_TRN_REPO_ROLLOVER_SEC
   WHERE
      DEAL_NO=M_DEAL_NO;

   SELECT
      COUNT(*) INTO M_SERIAL_NO_COUNT
   FROM
      DN_TRN_REPO_ROLLOVER_SERIAL_NO
   WHERE
      DEAL_NO=M_DEAL_NO;

   SELECT
      A.LEND_PORTFOLIO_CODE,
      A.BORR_PORTFOLIO_CODE,
      A.EFF_VALDATE,
      B.PF_TYPE,
      C.PF_TYPE,
      A.PHYSICAL_DELIVERY,
      A.PRIOR_DEAL_NO

      INTO  M_LEND_PORTFOLIO_CODE,M_BORR_PORTFOLIO_CODE,
            M_EFF_VALDATE,
            M_LEND_PF_TYPE,M_BORR_PF_TYPE,
            M_DEAL_PHYSICAL_DELIVERY,
            M_PRIOR_DEAL_NO
   FROM
      DN_TRN_REPO_ROLLOVER A,
      DN_REF_PORTFOLIO B,
      DN_REF_PORTFOLIO C
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.LEND_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      A.BORR_PORTFOLIO_CODE=C.PORTFOLIO_CODE;

     IF SUBSTR(M_PRIOR_DEAL_NO,1,2)='RF' THEN

        SELECT
           PHYSICAL_DELIVERY
           INTO
           M_PRIOR_DEAL_PHYSICAL_DELIVERY
        FROM
           DN_TRN_REPO_FRESH
        WHERE
           DEAL_NO=M_PRIOR_DEAL_NO;

     ELSIF SUBSTR(M_PRIOR_DEAL_NO,1,2)='RR' THEN

        SELECT
           PHYSICAL_DELIVERY
           INTO
           M_PRIOR_DEAL_PHYSICAL_DELIVERY
        FROM
           DN_TRN_REPO_ROLLOVER
        WHERE
           DEAL_NO=M_PRIOR_DEAL_NO;

     END IF;

  IF M_LEND_PF_TYPE='P'
       AND
       M_INST_COUNT>0
       AND
       M_SEC_COUNT>0
       AND
       M_SERIAL_NO_COUNT>0 THEN

       -- Serial no information is already there

         IF M_PRIOR_DEAL_PHYSICAL_DELIVERY='N' AND  M_DEAL_PHYSICAL_DELIVERY='Y' THEN

           --------------------------------------
           ------ For same serial numbers  ------
           --------------------------------------

          OPEN SAME_SERIALNO;

          LOOP

             FETCH  SAME_SERIALNO INTO

             M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,M_SERIAL_NO,M_FACE_VALUE,M_FACE_VALUE_CURR;--CURRENCY

             EXIT WHEN SAME_SERIALNO%NOTFOUND;

             UPDATE DN_INV_SUS_RECEIPT_INST A
                SET
                   A.ACT_FACE_VALUE    =A.ACT_FACE_VALUE+M_FACE_VALUE,
                   A.INT_BALANCE       =A.INT_BALANCE+M_FACE_VALUE,
                   A.BAL_TO_BE_RECEIVED=A.BAL_TO_BE_RECEIVED+M_FACE_VALUE,
                   A.BAL_TO_BE_RECEIVED_CURR=A.BAL_TO_BE_RECEIVED_CURR+M_FACE_VALUE_CURR--CURRENCY
             WHERE
                A.DEAL_NO=M_DEAL_NO
                AND
                A.INST_TYPE=M_INST_TYPE
                AND
                A.INV_CODE=M_INV_CODE --'RP' HARD CODED -- TO BE CHANGED TO 'M_INV_CODE'
                AND
                A.RECEIVER_CODE=M_LEND_PORTFOLIO_CODE
                AND
                A.SENDER_CODE=M_BORR_PORTFOLIO_CODE;

            IF SQL%NOTFOUND THEN

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
                 A.INV_CODE,
                 A.REC_FROM_INT_BAL_CURR,--CURRENCY
                 A.BAL_TO_BE_RECEIVED_CURR--CURRENCY
                 )
              VALUES
                (M_DEAL_NO,
                 M_INST_TYPE,
                 M_LEND_PORTFOLIO_CODE,
                 M_BORR_PORTFOLIO_CODE,
                 M_EFF_VALDATE,
                 M_FACE_VALUE,
                 0,
                 M_FACE_VALUE,
                 0,
                 M_FACE_VALUE,
                 SYSDATE,
                 SYSDATE,
                 M_INV_CODE, --'RP' HARD CODED -- TO BE CHANGED TO 'M_INV_CODE'
                 0,--CURRENCY
                 M_FACE_VALUE_CURR--CURRENCY
                );

            END IF;

            UPDATE DN_INV_SUS_RECEIPT_SEC A
                SET
                   A.ACT_FACE_VALUE    =A.ACT_FACE_VALUE+M_FACE_VALUE,
                   A.INT_BALANCE       =A.INT_BALANCE+M_FACE_VALUE,
                   A.BAL_TO_BE_RECEIVED=A.BAL_TO_BE_RECEIVED+M_FACE_VALUE,
                   A.BAL_TO_BE_RECEIVED_CURR=A.BAL_TO_BE_RECEIVED_CURR+M_FACE_VALUE_CURR--CURRENCY

             WHERE
                A.DEAL_NO=M_DEAL_NO
                AND
                A.INST_TYPE=M_INST_TYPE
                AND
                A.INV_CODE=M_INV_CODE --'RP' HARD CODED -- TO BE CHANGED TO 'M_INV_CODE'
                AND
                A.SECURITY_CODE=M_SECURITY_CODE
                AND
                A.RECEIVER_CODE=M_LEND_PORTFOLIO_CODE
                AND
                A.SENDER_CODE=M_BORR_PORTFOLIO_CODE;

         IF SQL%NOTFOUND  THEN

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
                A.INV_CODE,
                A.REC_FROM_INT_BAL_CURR,--CURRENCY
                A.BAL_TO_BE_RECEIVED_CURR--CURRENCY
                )
             VALUES
                (M_DEAL_NO,
                 M_INST_TYPE,
                 M_SECURITY_CODE,
                 M_LEND_PORTFOLIO_CODE,
                 M_BORR_PORTFOLIO_CODE,
                 M_EFF_VALDATE,
                 M_FACE_VALUE,
                 0,
                 M_FACE_VALUE,
                 0,
                 M_FACE_VALUE,
                 SYSDATE,
                 SYSDATE,
                 M_INV_CODE, --'RP' HARD CODED -- TO BE CHANGED TO 'M_INV_CODE'
                 0,--CURRENCY
                 M_FACE_VALUE_CURR--CURRENCY
                );
           END IF;

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
              A.INV_CODE,
                A.REC_FROM_INT_BAL_CURR,--CURRENCY
                A.BAL_TO_BE_RECEIVED_CURR--CURRENCY

              )
           VALUES
              (M_DEAL_NO,
               M_INST_TYPE,
               M_SECURITY_CODE,
               M_SERIAL_NO,
               M_LEND_PORTFOLIO_CODE,
               M_BORR_PORTFOLIO_CODE,
               M_EFF_VALDATE,
               M_FACE_VALUE,
               0,
               M_FACE_VALUE,
               0,
               M_FACE_VALUE,
               SYSDATE,
               SYSDATE,
               M_INV_CODE , --'RP' HARD CODED -- TO BE CHANGED TO 'M_INV_CODE'
                 0,--CURRENCY
                 M_FACE_VALUE_CURR--CURRENCY

              );

       END LOOP;

       CLOSE SAME_SERIALNO;

     ELSIF M_PRIOR_DEAL_PHYSICAL_DELIVERY='Y' AND  M_DEAL_PHYSICAL_DELIVERY='N' THEN

        --------------------------------------
        ------ For same serial numbers  ------
        --------------------------------------

        OPEN SAME_SERIALNO;

        LOOP

           FETCH  SAME_SERIALNO INTO

           M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,M_SERIAL_NO,M_FACE_VALUE,M_FACE_VALUE_CURR;--CURRENCY

           EXIT WHEN SAME_SERIALNO%NOTFOUND;


           UPDATE DN_INV_SUS_ISSUE_INST A
           SET
              A.ACT_FACE_VALUE    =A.ACT_FACE_VALUE+M_FACE_VALUE,
              A.INT_BALANCE       =A.INT_BALANCE+M_FACE_VALUE,
              A.BAL_TO_BE_ISSUED  =A.BAL_TO_BE_ISSUED+M_FACE_VALUE,
              A.BAL_TO_BE_ISSUED_CURR  =A.BAL_TO_BE_ISSUED_CURR+M_FACE_VALUE_CURR--CURRENCY
           WHERE
              A.DEAL_NO=M_DEAL_NO
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.INV_CODE=M_INV_CODE
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
                A.LAST_MOD_DATE,
                A.ISSUE_FROM_INT_BAL_CURR,--CURRENCY
                A.BAL_TO_BE_ISSUED_CURR--CURRENCY
               )
            VALUES
              (M_DEAL_NO,
               M_INST_TYPE,
               M_INV_CODE,
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
               0,--CURRENCY
                 M_FACE_VALUE_CURR--CURRENCY
              );

       END IF;

       UPDATE DN_INV_SUS_ISSUE_SEC A
       SET
          A.ACT_FACE_VALUE    =A.ACT_FACE_VALUE+M_FACE_VALUE,
          A.INT_BALANCE       =A.INT_BALANCE+M_FACE_VALUE,
          A.BAL_TO_BE_ISSUED  =A.BAL_TO_BE_ISSUED+M_FACE_VALUE,
              A.BAL_TO_BE_ISSUED_CURR  =A.BAL_TO_BE_ISSUED_CURR+M_FACE_VALUE_CURR--CURRENCY

       WHERE
          A.DEAL_NO=M_DEAL_NO
          AND
          A.INST_TYPE=M_INST_TYPE
          AND
          A.INV_CODE=M_INV_CODE
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
            A.LAST_MOD_DATE,
            A.ISSUE_FROM_INT_BAL_CURR,--CURRENCY
            A.BAL_TO_BE_ISSUED_CURR--CURRENCY
            )
          VALUES
            (M_DEAL_NO,
             M_INST_TYPE,
             M_SECURITY_CODE,
             M_INV_CODE,
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
             0,--CURRENCY
                 M_FACE_VALUE_CURR--CURRENCY

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
            A.INV_CODE,
            A.ISSUE_FROM_INT_BAL_CURR,--CURRENCY
            A.BAL_TO_BE_ISSUED_CURR--CURRENCY
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
             M_INV_CODE,
             0,--CURRENCY
             M_FACE_VALUE_CURR--CURRENCY
            );

       END LOOP;

       CLOSE SAME_SERIALNO;

     ELSIF M_PRIOR_DEAL_PHYSICAL_DELIVERY='Y' AND  M_DEAL_PHYSICAL_DELIVERY='Y' THEN

         --------------------------------------
         ------ For NEW serial numbers  -------
         --------------------------------------

          OPEN NEW_SERIALNO;

          LOOP

             FETCH  NEW_SERIALNO INTO

             M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,M_SERIAL_NO,M_FACE_VALUE,M_FACE_VALUE_CURR;--CURRENCY

             EXIT WHEN NEW_SERIALNO%NOTFOUND;

             UPDATE DN_INV_SUS_RECEIPT_INST A
                SET
                   A.ACT_FACE_VALUE    =A.ACT_FACE_VALUE+M_FACE_VALUE,
                   A.INT_BALANCE       =A.INT_BALANCE+M_FACE_VALUE,
                   A.BAL_TO_BE_RECEIVED=A.BAL_TO_BE_RECEIVED+M_FACE_VALUE,
              A.BAL_TO_BE_RECEIVED_CURR  =A.BAL_TO_BE_RECEIVED_CURR+M_FACE_VALUE_CURR--CURRENCY

             WHERE
                A.DEAL_NO=M_DEAL_NO
                AND
                A.INST_TYPE=M_INST_TYPE
                AND
                A.INV_CODE=M_INV_CODE --'RP' HARD CODED -- TO BE CHANGED TO 'M_INV_CODE'
                AND
                A.RECEIVER_CODE=M_LEND_PORTFOLIO_CODE
                AND
                A.SENDER_CODE=M_BORR_PORTFOLIO_CODE;

           IF SQL%NOTFOUND THEN

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
               A.INV_CODE,
                A.REC_FROM_INT_BAL_CURR,--CURRENCY
                A.BAL_TO_BE_RECEIVED_CURR--CURRENCY
               )
            VALUES
              (M_DEAL_NO,
               M_INST_TYPE,
               M_LEND_PORTFOLIO_CODE,
               M_BORR_PORTFOLIO_CODE,
               M_EFF_VALDATE,
               M_FACE_VALUE,
               0,
               M_FACE_VALUE,
               0,
               M_FACE_VALUE,
               SYSDATE,
               SYSDATE,
               M_INV_CODE, --'RP' HARD CODED -- TO BE CHANGED TO 'M_INV_CODE'
                0,--CURRENCY
                 M_FACE_VALUE_CURR--CURRENCY
              );
         END IF;

             UPDATE DN_INV_SUS_RECEIPT_SEC A
                SET
                   A.ACT_FACE_VALUE    =A.ACT_FACE_VALUE+M_FACE_VALUE,
                   A.INT_BALANCE       =A.INT_BALANCE+M_FACE_VALUE,
                   A.BAL_TO_BE_RECEIVED=A.BAL_TO_BE_RECEIVED+M_FACE_VALUE,
              A.BAL_TO_BE_RECEIVED_CURR  =A.BAL_TO_BE_RECEIVED_CURR+M_FACE_VALUE_CURR--CURRENCY

             WHERE
                A.DEAL_NO=M_DEAL_NO
                AND
                A.INST_TYPE=M_INST_TYPE
                AND
                A.INV_CODE=M_INV_CODE --'RP' HARD CODED -- TO BE CHANGED TO 'M_INV_CODE'
                AND
                A.SECURITY_CODE=M_SECURITY_CODE
                AND
                A.RECEIVER_CODE=M_LEND_PORTFOLIO_CODE
                AND
                A.SENDER_CODE=M_BORR_PORTFOLIO_CODE;

         IF SQL%NOTFOUND THEN

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
              A.INV_CODE,
                A.REC_FROM_INT_BAL_CURR,--CURRENCY
                A.BAL_TO_BE_RECEIVED_CURR--CURRENCY
              )
           VALUES
              (M_DEAL_NO,
               M_INST_TYPE,
               M_SECURITY_CODE,
               M_LEND_PORTFOLIO_CODE,
               M_BORR_PORTFOLIO_CODE,
               M_EFF_VALDATE,
               M_FACE_VALUE,
               0,
               M_FACE_VALUE,
               0,
               M_FACE_VALUE,
               SYSDATE,
               SYSDATE,
               M_INV_CODE, --'RP' HARD CODED -- TO BE CHANGED TO 'M_INV_CODE'
               0,--CURRENCY
                 M_FACE_VALUE_CURR--CURRENCY
              );

         END IF;

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
              A.INV_CODE,
                A.REC_FROM_INT_BAL_CURR,--CURRENCY
                A.BAL_TO_BE_RECEIVED_CURR--CURRENCY
              )
           VALUES
              (M_DEAL_NO,
               M_INST_TYPE,
               M_SECURITY_CODE,
               M_SERIAL_NO,
               M_LEND_PORTFOLIO_CODE,
               M_BORR_PORTFOLIO_CODE,
               M_EFF_VALDATE,
               M_FACE_VALUE,
               0,
               M_FACE_VALUE,
               0,
               M_FACE_VALUE,
               SYSDATE,
               SYSDATE,
               M_INV_CODE ,--'RP' HARD CODED -- TO BE CHANGED TO 'M_INV_CODE'
               0,--CURRENCY
                 M_FACE_VALUE_CURR--CURRENCY
              );

       END LOOP;

       CLOSE NEW_SERIALNO;

       ----------------------------------------
       ------ For DELETE serial numbers  ------
       ----------------------------------------

        OPEN DELETE_SERIALNO_RF;

        LOOP

           FETCH  DELETE_SERIALNO_RF INTO

           M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,M_SERIAL_NO,M_FACE_VALUE,M_FACE_VALUE_CURR;--CURRENCY

           EXIT WHEN DELETE_SERIALNO_RF%NOTFOUND;

           UPDATE DN_INV_SUS_ISSUE_INST A
           SET
              A.ACT_FACE_VALUE    =A.ACT_FACE_VALUE+M_FACE_VALUE,
              A.INT_BALANCE       =A.INT_BALANCE+M_FACE_VALUE,
              A.BAL_TO_BE_ISSUED  =A.BAL_TO_BE_ISSUED+M_FACE_VALUE,
              A.BAL_TO_BE_ISSUED_CURR  =A.BAL_TO_BE_ISSUED_CURR+M_FACE_VALUE_CURR--CURRENCY

           WHERE
              A.DEAL_NO=M_PRIOR_DEAL_NO
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.INV_CODE=M_INV_CODE
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
            A.LAST_MOD_DATE,
            A.ISSUE_FROM_INT_BAL_CURR,--CURRENCY
            A.BAL_TO_BE_ISSUED_CURR--CURRENCY
           )
         VALUES
            (M_PRIOR_DEAL_NO,
             M_INST_TYPE,
             M_INV_CODE,
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
             0,--CURRENCY
                 M_FACE_VALUE_CURR--CURRENCY

            );

     END IF;

        UPDATE DN_INV_SUS_ISSUE_SEC A
         SET
            A.ACT_FACE_VALUE    =A.ACT_FACE_VALUE+M_FACE_VALUE,
            A.INT_BALANCE       =A.INT_BALANCE+M_FACE_VALUE,
            A.BAL_TO_BE_ISSUED  =A.BAL_TO_BE_ISSUED+M_FACE_VALUE,
              A.BAL_TO_BE_ISSUED_CURR  =A.BAL_TO_BE_ISSUED_CURR+M_FACE_VALUE_CURR--CURRENCY
         WHERE
            A.DEAL_NO=M_PRIOR_DEAL_NO
            AND
            A.INST_TYPE=M_INST_TYPE
            AND
            A.INV_CODE=M_INV_CODE
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
          A.LAST_MOD_DATE,
            A.ISSUE_FROM_INT_BAL_CURR,--CURRENCY
            A.BAL_TO_BE_ISSUED_CURR--CURRENCY
          )
        VALUES
          (M_PRIOR_DEAL_NO,
           M_INST_TYPE,
           M_SECURITY_CODE,
           M_INV_CODE,
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
           0,--CURRENCY
           M_FACE_VALUE_CURR--CURRENCY

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
            A.INV_CODE,
            A.ISSUE_FROM_INT_BAL_CURR,--CURRENCY
            A.BAL_TO_BE_ISSUED_CURR--CURRENCY

            )
          VALUES
            (M_PRIOR_DEAL_NO,
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
             M_INV_CODE,
             0,--CURRENCY
                 M_FACE_VALUE_CURR--CURRENCY
            );


      END LOOP;

      CLOSE DELETE_SERIALNO_RF;

      --Delete from rr

       OPEN DELETE_SERIALNO_RR;

        LOOP

           FETCH  DELETE_SERIALNO_RR INTO

           M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,M_SERIAL_NO,M_FACE_VALUE,M_FACE_VALUE_CURR;--CURRENCY

           EXIT WHEN DELETE_SERIALNO_RR%NOTFOUND;

           UPDATE DN_INV_SUS_ISSUE_INST A
           SET
              A.ACT_FACE_VALUE    =A.ACT_FACE_VALUE+M_FACE_VALUE,
              A.INT_BALANCE       =A.INT_BALANCE+M_FACE_VALUE,
              A.BAL_TO_BE_ISSUED  =A.BAL_TO_BE_ISSUED+M_FACE_VALUE,
              A.BAL_TO_BE_ISSUED_CURR  =A.BAL_TO_BE_ISSUED_CURR+M_FACE_VALUE_CURR--CURRENCY

           WHERE
              A.DEAL_NO=M_PRIOR_DEAL_NO
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.INV_CODE=M_INV_CODE
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
            A.LAST_MOD_DATE,
            A.ISSUE_FROM_INT_BAL_CURR,--CURRENCY
            A.BAL_TO_BE_ISSUED_CURR--CURRENCY
           )
         VALUES
            (M_PRIOR_DEAL_NO,
             M_INST_TYPE,
             M_INV_CODE,
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
             0,--CURRENCY
                 M_FACE_VALUE_CURR--CURRENCY

            );

     END IF;

        UPDATE DN_INV_SUS_ISSUE_SEC A
         SET
            A.ACT_FACE_VALUE    =A.ACT_FACE_VALUE+M_FACE_VALUE,
            A.INT_BALANCE       =A.INT_BALANCE+M_FACE_VALUE,
            A.BAL_TO_BE_ISSUED  =A.BAL_TO_BE_ISSUED+M_FACE_VALUE,
              A.BAL_TO_BE_ISSUED_CURR  =A.BAL_TO_BE_ISSUED_CURR+M_FACE_VALUE_CURR--CURRENCY

         WHERE
            A.DEAL_NO=M_PRIOR_DEAL_NO
            AND
            A.INST_TYPE=M_INST_TYPE
            AND
            A.INV_CODE=M_INV_CODE
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
          A.LAST_MOD_DATE,
            A.ISSUE_FROM_INT_BAL_CURR,--CURRENCY
            A.BAL_TO_BE_ISSUED_CURR--CURRENCY
          )
        VALUES
          (M_PRIOR_DEAL_NO,
           M_INST_TYPE,
           M_SECURITY_CODE,
           M_INV_CODE,
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
           0,--CURRENCY
                 M_FACE_VALUE_CURR--CURRENCY

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
            A.INV_CODE,
            A.ISSUE_FROM_INT_BAL_CURR,--CURRENCY
            A.BAL_TO_BE_ISSUED_CURR--CURRENCY
            )
          VALUES
            (M_PRIOR_DEAL_NO,
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
             M_INV_CODE,
             0,--CURRENCY
             M_FACE_VALUE_CURR--CURRENCY
            );

      END LOOP;

      CLOSE DELETE_SERIALNO_RR;

   END IF;


  ELSIF M_LEND_PF_TYPE='P'
          AND
          M_INST_COUNT>0
          AND
          M_SEC_COUNT>0
          AND
          M_SERIAL_NO_COUNT=0 THEN

          -- Serial no information is not there - details only upto security level

           IF M_PRIOR_DEAL_PHYSICAL_DELIVERY='N' AND  M_DEAL_PHYSICAL_DELIVERY='Y' THEN

           ----------------------------------
           ------ For same SECURITIES  ------
           ----------------------------------

          OPEN SAME_SEC;

          LOOP

             FETCH  SAME_SEC INTO

             M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,M_FACE_VALUE,M_FACE_VALUE_CURR;--CURRENCY

             EXIT WHEN SAME_SEC%NOTFOUND;

             UPDATE DN_INV_SUS_RECEIPT_INST A
                SET
                   A.ACT_FACE_VALUE    =A.ACT_FACE_VALUE+M_FACE_VALUE,
                   A.INT_BALANCE       =A.INT_BALANCE+M_FACE_VALUE,
                   A.BAL_TO_BE_RECEIVED=A.BAL_TO_BE_RECEIVED+M_FACE_VALUE,
              A.BAL_TO_BE_RECEIVED_CURR  =A.BAL_TO_BE_RECEIVED_CURR+M_FACE_VALUE_CURR--CURRENCY

             WHERE
                A.DEAL_NO=M_DEAL_NO
                AND
                A.INST_TYPE=M_INST_TYPE
                AND
                A.INV_CODE=M_INV_CODE --'RP' HARD CODED -- TO BE CHANGED TO 'M_INV_CODE'
                AND
                A.RECEIVER_CODE=M_LEND_PORTFOLIO_CODE
                AND
                A.SENDER_CODE=M_BORR_PORTFOLIO_CODE;

            IF SQL%NOTFOUND THEN

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
                 A.INV_CODE,
                A.REC_FROM_INT_BAL_CURR,--CURRENCY
                A.BAL_TO_BE_RECEIVED_CURR--CURRENCY

                 )
              VALUES
                (M_DEAL_NO,
                 M_INST_TYPE,
                 M_LEND_PORTFOLIO_CODE,
                 M_BORR_PORTFOLIO_CODE,
                 M_EFF_VALDATE,
                 M_FACE_VALUE,
                 0,
                 M_FACE_VALUE,
                 0,
                 M_FACE_VALUE,
                 SYSDATE,
                 SYSDATE,
                 M_INV_CODE, --'RP' HARD CODED -- TO BE CHANGED TO 'M_INV_CODE'
                 0,--CURRENCY
                 M_FACE_VALUE_CURR--CURRENCY
                );

            END IF;

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
                A.INV_CODE,
                A.REC_FROM_INT_BAL_CURR,--CURRENCY
                A.BAL_TO_BE_RECEIVED_CURR--CURRENCY
                )
             VALUES
                (M_DEAL_NO,
                 M_INST_TYPE,
                 M_SECURITY_CODE,
                 M_LEND_PORTFOLIO_CODE,
                 M_BORR_PORTFOLIO_CODE,
                 M_EFF_VALDATE,
                 M_FACE_VALUE,
                 0,
                 M_FACE_VALUE,
                 0,
                 M_FACE_VALUE,
                 SYSDATE,
                 SYSDATE,
                 M_INV_CODE, --'RP' HARD CODED -- TO BE CHANGED TO 'M_INV_CODE'
                 0,--CURRENCY
                 M_FACE_VALUE_CURR--CURRENCY
                );

          END LOOP;

          CLOSE NEW_SEC;

     ELSIF M_PRIOR_DEAL_PHYSICAL_DELIVERY='Y' AND  M_DEAL_PHYSICAL_DELIVERY='N' THEN

       ----------------------------------
       ------ For same SECURITIES  ------
       ----------------------------------

      OPEN SAME_SEC;

      LOOP

         FETCH  SAME_SEC INTO

         M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,M_FACE_VALUE,M_FACE_VALUE_CURR;--CURRENCY


         EXIT WHEN SAME_SEC%NOTFOUND;

         UPDATE  DN_INV_SUS_ISSUE_INST A
            SET
               A.ACT_FACE_VALUE    =A.ACT_FACE_VALUE+M_FACE_VALUE,
               A.INT_BALANCE       =A.INT_BALANCE+M_FACE_VALUE,
               A.BAL_TO_BE_ISSUED  =A.BAL_TO_BE_ISSUED+M_FACE_VALUE,
              A.BAL_TO_BE_ISSUED_CURR  =A.BAL_TO_BE_ISSUED_CURR+M_FACE_VALUE_CURR--CURRENCY

         WHERE
            A.DEAL_NO=M_DEAL_NO
            AND
            A.INST_TYPE=M_INST_TYPE
            AND
            A.INV_CODE=M_INV_CODE
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
              A.LAST_MOD_DATE,
            A.ISSUE_FROM_INT_BAL_CURR,--CURRENCY
            A.BAL_TO_BE_ISSUED_CURR--CURRENCY
             )
            VALUES
              (M_DEAL_NO,
               M_INST_TYPE,
               M_INV_CODE,
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
               0,--CURRENCY
                 M_FACE_VALUE_CURR--CURRENCY
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
            A.LAST_MOD_DATE,
            A.ISSUE_FROM_INT_BAL_CURR,--CURRENCY
            A.BAL_TO_BE_ISSUED_CURR--CURRENCY
            )
          VALUES
            (M_DEAL_NO,
             M_INST_TYPE,
             M_SECURITY_CODE,
             M_INV_CODE,
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
             0,--CURRENCY
                 M_FACE_VALUE_CURR--CURRENCY
            );

       END LOOP;

       CLOSE SAME_SEC;


     ELSIF M_PRIOR_DEAL_PHYSICAL_DELIVERY='Y' AND  M_DEAL_PHYSICAL_DELIVERY='Y' THEN

         ----------------------------------
         ------ For NEW SECURITIES  -------
         ----------------------------------

          OPEN NEW_SEC;

          LOOP

             FETCH  NEW_SEC INTO

             M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,M_FACE_VALUE,M_FACE_VALUE_CURR;--CURRENCY

             EXIT WHEN NEW_SEC%NOTFOUND;

             UPDATE DN_INV_SUS_RECEIPT_INST A
                SET
                   A.ACT_FACE_VALUE    =A.ACT_FACE_VALUE+M_FACE_VALUE,
                   A.INT_BALANCE       =A.INT_BALANCE+M_FACE_VALUE,
                   A.BAL_TO_BE_RECEIVED=A.BAL_TO_BE_RECEIVED+M_FACE_VALUE,
              A.BAL_TO_BE_RECEIVED_CURR  =A.BAL_TO_BE_RECEIVED_CURR+M_FACE_VALUE_CURR--CURRENCY

             WHERE
                A.DEAL_NO=M_DEAL_NO
                AND
                A.INST_TYPE=M_INST_TYPE
                AND
                A.INV_CODE=M_INV_CODE --'RP' HARD CODED -- TO BE CHANGED TO 'M_INV_CODE'
                AND
                A.RECEIVER_CODE=M_LEND_PORTFOLIO_CODE
                AND
                A.SENDER_CODE=M_BORR_PORTFOLIO_CODE;

            IF SQL%NOTFOUND THEN

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
                 A.INV_CODE,
                A.REC_FROM_INT_BAL_CURR,--CURRENCY
                A.BAL_TO_BE_RECEIVED_CURR--CURRENCY
                 )
              VALUES
                (M_DEAL_NO,
                 M_INST_TYPE,
                 M_LEND_PORTFOLIO_CODE,
                 M_BORR_PORTFOLIO_CODE,
                 M_EFF_VALDATE,
                 M_FACE_VALUE,
                 0,
                 M_FACE_VALUE,
                 0,
                 M_FACE_VALUE,
                 SYSDATE,
                 SYSDATE,
                 M_INV_CODE, --'RP' HARD CODED -- TO BE CHANGED TO 'M_INV_CODE'
                 0,--CURRENCY
                 M_FACE_VALUE_CURR--CURRENCY
                );

            END IF;

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
              A.INV_CODE,
                A.REC_FROM_INT_BAL_CURR,--CURRENCY
                A.BAL_TO_BE_RECEIVED_CURR--CURRENCY
              )
           VALUES
              (M_DEAL_NO,
               M_INST_TYPE,
               M_SECURITY_CODE,
               M_LEND_PORTFOLIO_CODE,
               M_BORR_PORTFOLIO_CODE,
               M_EFF_VALDATE,
               M_FACE_VALUE,
               0,
               M_FACE_VALUE,
               0,
               M_FACE_VALUE,
               SYSDATE,
               SYSDATE,
               M_INV_CODE ,--'RP' HARD CODED -- TO BE CHANGED TO 'M_INV_CODE'
               0,--CURRENCY
                 M_FACE_VALUE_CURR--CURRENCY
              );

       END LOOP;

       CLOSE NEW_SEC;


       ----------------------------
       ------ For DELETE SEC. ------
       ----------------------------

      OPEN DELETE_SEC_RF;

      LOOP

         FETCH  DELETE_SEC_RF INTO

         M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,M_FACE_VALUE,M_FACE_VALUE_CURR;--CURRENCY


         EXIT WHEN DELETE_SEC_RF%NOTFOUND;

         UPDATE  DN_INV_SUS_ISSUE_INST A
            SET
               A.ACT_FACE_VALUE    =A.ACT_FACE_VALUE+M_FACE_VALUE,
               A.INT_BALANCE       =A.INT_BALANCE+M_FACE_VALUE,
               A.BAL_TO_BE_ISSUED  =A.BAL_TO_BE_ISSUED+M_FACE_VALUE,
              A.BAL_TO_BE_ISSUED_CURR  =A.BAL_TO_BE_ISSUED_CURR+M_FACE_VALUE_CURR--CURRENCY
         WHERE
            A.DEAL_NO=M_PRIOR_DEAL_NO
            AND
            A.INST_TYPE=M_INST_TYPE
            AND
            A.INV_CODE=M_INV_CODE
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
              A.LAST_MOD_DATE,
            A.ISSUE_FROM_INT_BAL_CURR,--CURRENCY
            A.BAL_TO_BE_ISSUED_CURR--CURRENCY
             )
            VALUES
              (M_PRIOR_DEAL_NO,
               M_INST_TYPE,
               M_INV_CODE,
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
               0,--CURRENCY
                 M_FACE_VALUE_CURR--CURRENCY

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
            A.LAST_MOD_DATE,
            A.ISSUE_FROM_INT_BAL_CURR,--CURRENCY
            A.BAL_TO_BE_ISSUED_CURR--CURRENCY
            )
          VALUES
            (M_PRIOR_DEAL_NO,
             M_INST_TYPE,
             M_SECURITY_CODE,
             M_INV_CODE,
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
             0,--CURRENCY
                 M_FACE_VALUE_CURR--CURRENCY
            );

       END LOOP;

       CLOSE DELETE_SEC_RF;

      OPEN DELETE_SEC_RR;

      LOOP

         FETCH  DELETE_SEC_RR INTO

         M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,M_FACE_VALUE,M_FACE_VALUE_CURR;--CURRENCY


         EXIT WHEN DELETE_SEC_RR%NOTFOUND;

         UPDATE  DN_INV_SUS_ISSUE_INST A
            SET
               A.ACT_FACE_VALUE    =A.ACT_FACE_VALUE+M_FACE_VALUE,
               A.INT_BALANCE       =A.INT_BALANCE+M_FACE_VALUE,
               A.BAL_TO_BE_ISSUED  =A.BAL_TO_BE_ISSUED+M_FACE_VALUE,
              A.BAL_TO_BE_ISSUED_CURR  =A.BAL_TO_BE_ISSUED_CURR+M_FACE_VALUE_CURR--CURRENCY

         WHERE
            A.DEAL_NO=M_PRIOR_DEAL_NO
            AND
            A.INST_TYPE=M_INST_TYPE
            AND
            A.INV_CODE=M_INV_CODE
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
              A.LAST_MOD_DATE,
            A.ISSUE_FROM_INT_BAL_CURR,--CURRENCY
            A.BAL_TO_BE_ISSUED_CURR--CURRENCY
             )
            VALUES
              (M_PRIOR_DEAL_NO,
               M_INST_TYPE,
               M_INV_CODE,
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
               0,--CURRENCY
                 M_FACE_VALUE_CURR--CURRENCY
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
            A.LAST_MOD_DATE,
            A.ISSUE_FROM_INT_BAL_CURR,--CURRENCY
            A.BAL_TO_BE_ISSUED_CURR--CURRENCY
            )
          VALUES
            (M_PRIOR_DEAL_NO,
             M_INST_TYPE,
             M_SECURITY_CODE,
             M_INV_CODE,
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
             0,--CURRENCY
                 M_FACE_VALUE_CURR--CURRENCY
            );

       END LOOP;

       CLOSE DELETE_SEC_RR;

   END IF;

END IF;

END DN_INV_REPO_RR_SUSPENSE_LEND;

/
