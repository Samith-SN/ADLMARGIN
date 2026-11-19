--------------------------------------------------------
--  DDL for Procedure DN_INV_REPO_RS_SUSPENSE_BORR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_REPO_RS_SUSPENSE_BORR" 
   (
    M_DEAL_NO      DN_TRN_REPO_ROLLOVER.DEAL_NO%TYPE
   )

   IS

    -- Procedue     : Update repo SETTLEMENT inventory - suspense for BORR
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 06/08/1999

   CURSOR  DELETE_SERIALNO_RF IS
   SELECT
      C.INST_TYPE,
      C.INV_CODE,
      C.SECURITY_CODE,
      C.SERIAL_NO,
      C.FACE_VALUE
   FROM
      DN_TRN_REPO_SETTLEMENT B,
      DN_TRN_REPO_FRESH_SERIAL_NO C
   WHERE
      B.DEAL_NO=M_DEAL_NO
      AND
      B.PRIOR_DEAL_NO=C.DEAL_NO;

   --THE FOLLOWING WAS REMARKED BY SM ON 23/11/99
   --   AND
   --   C.DATA_FROM='FO';


   CURSOR  DELETE_SERIALNO_RR IS
   SELECT
      C.INST_TYPE,
      C.INV_CODE,
      C.SECURITY_CODE,
      C.SERIAL_NO,
      C.FACE_VALUE
   FROM
      DN_TRN_REPO_SETTLEMENT B,
      DN_TRN_REPO_ROLLOVER_SERIAL_NO C
   WHERE
      B.DEAL_NO=M_DEAL_NO
      AND
      B.PRIOR_DEAL_NO=C.DEAL_NO;

  -- THE FOLLOWING WAS REMARKED BY SM ON 23/11/99
  --    AND
  --    C.DATA_FROM='FO';

CURSOR  DELETE_SERIALNO_PI IS
   SELECT
      C.INST_TYPE,
      C.INV_CODE,
      C.SECURITY_CODE,
      C.SERIAL_NO,
      C.FACE_VALUE
   FROM
      DN_TRN_REPO_SETTLEMENT B,
      DN_TRN_REPO_PERIOD_INT_SERIAL C
   WHERE
      B.DEAL_NO=M_DEAL_NO
      AND
      B.PRIOR_DEAL_NO=C.DEAL_NO;




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


BEGIN

   SELECT
      A.PRIOR_DEAL_NO
      INTO
         M_PRIOR_DEAL_NO
   FROM
      DN_TRN_REPO_SETTLEMENT A
   WHERE
      A.DEAL_NO=M_DEAL_NO;

     IF SUBSTR(M_PRIOR_DEAL_NO,1,2)='RF' THEN

         SELECT
            A.LEND_PORTFOLIO_CODE,
            A.BORR_PORTFOLIO_CODE,
            A.EFF_VALDATE,
            B.PF_TYPE,
            C.PF_TYPE,
            A.PHYSICAL_DELIVERY
           INTO M_LEND_PORTFOLIO_CODE,M_BORR_PORTFOLIO_CODE,
                M_EFF_VALDATE,
                M_LEND_PF_TYPE,M_BORR_PF_TYPE,
                M_PRIOR_DEAL_PHYSICAL_DELIVERY
         FROM
            DN_TRN_REPO_FRESH A,
            DN_REF_PORTFOLIO B,
            DN_REF_PORTFOLIO C
         WHERE
            A.DEAL_NO=M_PRIOR_DEAL_NO
            AND
            A.LEND_PORTFOLIO_CODE=B.PORTFOLIO_CODE
            AND
            A.BORR_PORTFOLIO_CODE=C.PORTFOLIO_CODE;

     ELSIF SUBSTR(M_PRIOR_DEAL_NO,1,2)='RR' THEN

         SELECT
            A.LEND_PORTFOLIO_CODE,
            A.BORR_PORTFOLIO_CODE,
            A.EFF_VALDATE,
            B.PF_TYPE,
            C.PF_TYPE,
            A.PHYSICAL_DELIVERY
           INTO M_LEND_PORTFOLIO_CODE,M_BORR_PORTFOLIO_CODE,
                M_EFF_VALDATE,
                M_LEND_PF_TYPE,M_BORR_PF_TYPE,
                M_PRIOR_DEAL_PHYSICAL_DELIVERY
         FROM
            DN_TRN_REPO_ROLLOVER A,
            DN_REF_PORTFOLIO B,
            DN_REF_PORTFOLIO C
         WHERE
            A.DEAL_NO=M_PRIOR_DEAL_NO
            AND
            A.LEND_PORTFOLIO_CODE=B.PORTFOLIO_CODE
            AND
            A.BORR_PORTFOLIO_CODE=C.PORTFOLIO_CODE;

    ELSIF SUBSTR(M_PRIOR_DEAL_NO,1,2)='PI' THEN

         SELECT
            A.LEND_PORTFOLIO_CODE,
            A.BORR_PORTFOLIO_CODE,
            A.EFF_VALDATE,
            B.PF_TYPE,
            C.PF_TYPE,
            A.PHYSICAL_DELIVERY
           INTO M_LEND_PORTFOLIO_CODE,M_BORR_PORTFOLIO_CODE,
                M_EFF_VALDATE,
                M_LEND_PF_TYPE,M_BORR_PF_TYPE,
                M_PRIOR_DEAL_PHYSICAL_DELIVERY
         FROM
            DN_TRN_REPO_PERIOD_INT A,
            DN_REF_PORTFOLIO B,
            DN_REF_PORTFOLIO C
         WHERE
            A.DEAL_NO=M_PRIOR_DEAL_NO
            AND
            A.LEND_PORTFOLIO_CODE=B.PORTFOLIO_CODE
            AND
            A.BORR_PORTFOLIO_CODE=C.PORTFOLIO_CODE;


     END IF;

  IF   M_BORR_PF_TYPE='P'
       AND
       M_PRIOR_DEAL_PHYSICAL_DELIVERY='Y' THEN

       -- Serial no information is already there

       ----------------------------------------
       ------ For DELETE serial numbers  ------
       ----------------------------------------

        OPEN DELETE_SERIALNO_RF;

        LOOP

           FETCH  DELETE_SERIALNO_RF INTO

           M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,M_SERIAL_NO,M_FACE_VALUE;

           EXIT WHEN DELETE_SERIALNO_RF%NOTFOUND;

           UPDATE DN_INV_SUS_RECEIPT_INST A
           SET
              A.ACT_FACE_VALUE     =A.ACT_FACE_VALUE+M_FACE_VALUE,
              A.INT_BALANCE        =A.INT_BALANCE+M_FACE_VALUE,
              A.BAL_TO_BE_RECEIVED =A.BAL_TO_BE_RECEIVED+M_FACE_VALUE
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

         INSERT INTO DN_INV_SUS_RECEIPT_INST A
           (A.DEAL_NO,
            A.INST_TYPE,
            A.INV_CODE,
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
             SYSDATE
            );

     END IF;

        UPDATE DN_INV_SUS_RECEIPT_SEC A
         SET
            A.ACT_FACE_VALUE      =A.ACT_FACE_VALUE+M_FACE_VALUE,
            A.INT_BALANCE         =A.INT_BALANCE+M_FACE_VALUE,
            A.BAL_TO_BE_RECEIVED  =A.BAL_TO_BE_RECEIVED+M_FACE_VALUE
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

      INSERT INTO DN_INV_SUS_RECEIPT_SEC A
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
          A.REC_FROM_INT_BAL,
          A.BAL_TO_BE_RECEIVED,
          A.ENT_DATE,
          A.LAST_MOD_DATE
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
           SYSDATE
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
            A.INV_CODE
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
             M_INV_CODE
            );

      END LOOP;

      CLOSE DELETE_SERIALNO_RF;

      --Delete from rr

        OPEN DELETE_SERIALNO_RR;

        LOOP

           FETCH  DELETE_SERIALNO_RR INTO

           M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,M_SERIAL_NO,M_FACE_VALUE;

           EXIT WHEN DELETE_SERIALNO_RR%NOTFOUND;

           UPDATE DN_INV_SUS_RECEIPT_INST A
           SET
              A.ACT_FACE_VALUE     =A.ACT_FACE_VALUE+M_FACE_VALUE,
              A.INT_BALANCE        =A.INT_BALANCE+M_FACE_VALUE,
              A.BAL_TO_BE_RECEIVED =A.BAL_TO_BE_RECEIVED+M_FACE_VALUE
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

         INSERT INTO DN_INV_SUS_RECEIPT_INST A
           (A.DEAL_NO,
            A.INST_TYPE,
            A.INV_CODE,
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
             SYSDATE
            );

     END IF;

        UPDATE DN_INV_SUS_RECEIPT_SEC A
         SET
            A.ACT_FACE_VALUE      =A.ACT_FACE_VALUE+M_FACE_VALUE,
            A.INT_BALANCE         =A.INT_BALANCE+M_FACE_VALUE,
            A.BAL_TO_BE_RECEIVED  =A.BAL_TO_BE_RECEIVED+M_FACE_VALUE
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

      INSERT INTO DN_INV_SUS_RECEIPT_SEC A
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
          A.REC_FROM_INT_BAL,
          A.BAL_TO_BE_RECEIVED,
          A.ENT_DATE,
          A.LAST_MOD_DATE
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
           SYSDATE
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
            A.INV_CODE
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
             M_INV_CODE
            );

      END LOOP;

    CLOSE DELETE_SERIALNO_RR;

     OPEN DELETE_SERIALNO_PI;

        LOOP

           FETCH  DELETE_SERIALNO_PI INTO

           M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,M_SERIAL_NO,M_FACE_VALUE;

           EXIT WHEN DELETE_SERIALNO_PI%NOTFOUND;

           UPDATE DN_INV_SUS_RECEIPT_INST A
           SET
              A.ACT_FACE_VALUE     =A.ACT_FACE_VALUE+M_FACE_VALUE,
              A.INT_BALANCE        =A.INT_BALANCE+M_FACE_VALUE,
              A.BAL_TO_BE_RECEIVED =A.BAL_TO_BE_RECEIVED+M_FACE_VALUE
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

         INSERT INTO DN_INV_SUS_RECEIPT_INST A
           (A.DEAL_NO,
            A.INST_TYPE,
            A.INV_CODE,
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
             SYSDATE
            );

     END IF;

        UPDATE DN_INV_SUS_RECEIPT_SEC A
         SET
            A.ACT_FACE_VALUE      =A.ACT_FACE_VALUE+M_FACE_VALUE,
            A.INT_BALANCE         =A.INT_BALANCE+M_FACE_VALUE,
            A.BAL_TO_BE_RECEIVED  =A.BAL_TO_BE_RECEIVED+M_FACE_VALUE
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

      INSERT INTO DN_INV_SUS_RECEIPT_SEC A
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
          A.REC_FROM_INT_BAL,
          A.BAL_TO_BE_RECEIVED,
          A.ENT_DATE,
          A.LAST_MOD_DATE
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
           SYSDATE
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
            A.INV_CODE
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
             M_INV_CODE
            );

      END LOOP;

      CLOSE DELETE_SERIALNO_PI;






END IF;

END DN_INV_REPO_RS_SUSPENSE_BORR;

/
