--------------------------------------------------------
--  DDL for Procedure DN_INV_REPO_RR_DEAL_SERNO_FO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_REPO_RR_DEAL_SERNO_FO" 
   (
    M_DEAL_NO      DN_TRN_REPO_ROLLOVER.DEAL_NO%TYPE
   )

   IS

    -- Procedue     : Update Repo rollover inventory - deal-serial number -fo
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 03/08/1999

   CURSOR REPO_SERIAL_NO IS
     SELECT
        A.INST_TYPE,
        A.SECURITY_CODE,
        A.SERIAL_NO,
        A.FACE_VALUE,
        A.LOCATION,
        A.PREV_DEAL_NO,
        A.FACE_VALUE_CURR--CURRENCY
     FROM
        DN_TRN_REPO_ROLLOVER_SERIAL_NO A
     WHERE
        A.DEAL_NO=M_DEAL_NO
        AND
        A.INV_CODE='RP'
        AND
        A.DATA_FROM='FO'
        AND
        A.INV_STATUS='N';

   CURSOR OUTP_SERIAL_NO IS
     SELECT
        A.INST_TYPE,
        A.SECURITY_CODE,
        A.SERIAL_NO,
        A.FACE_VALUE,
        A.LOCATION,
        A.PREV_DEAL_NO,
        A.FACE_VALUE_CURR--CURRENCY
     FROM
        DN_TRN_REPO_ROLLOVER_SERIAL_NO A
     WHERE
        A.DEAL_NO=M_DEAL_NO
        AND
        A.INV_CODE='OR'
        AND
        A.DATA_FROM='FO'
        AND
        A.INV_STATUS='N';

  CURSOR BL_SERIAL_NO IS
     SELECT
        A.INST_TYPE,
        A.SECURITY_CODE,
        A.SERIAL_NO,
        A.FACE_VALUE,
        A.LOCATION,
        A.PREV_DEAL_NO,
        A.FACE_VALUE_CURR--CURRENCY
     FROM
        DN_TRN_REPO_ROLLOVER_SERIAL_NO A
     WHERE
        A.DEAL_NO=M_DEAL_NO
        AND
        A.INV_CODE='BL'
        AND
        A.DATA_FROM='FO'
        AND
        A.INV_STATUS='N';

  M_PREV_DEAL_NO          DN_TRN_REPO_ROLLOVER.DEAL_NO%TYPE;
  M_CURR_DATE             DN_TRN_REPO_ROLLOVER.EFF_VALDATE%TYPE;
  M_EFF_VALDATE           DN_TRN_REPO_ROLLOVER.EFF_VALDATE%TYPE;
  M_MATURITY_DATE         DN_TRN_REPO_ROLLOVER.MATURITY_DATE%TYPE;
  M_INST_TYPE             DN_TRN_REPO_ROLLOVER_SERIAL_NO.INST_TYPE%TYPE;
  M_SECURITY_CODE         DN_TRN_REPO_ROLLOVER_SERIAL_NO.SECURITY_CODE%TYPE;
  M_SERIAL_NO             DN_TRN_REPO_ROLLOVER_SERIAL_NO.SERIAL_NO%TYPE;
  M_LOCATION              DN_TRN_REPO_ROLLOVER_SERIAL_NO.LOCATION%TYPE;
  M_SCRP_FACE_VALUE       DN_TRN_REPO_ROLLOVER_SERIAL_NO.FACE_VALUE%TYPE;
  M_LEND_PORTFOLIO_CODE   DN_TRN_REPO_ROLLOVER.LEND_PORTFOLIO_CODE%TYPE;
  M_BORR_PORTFOLIO_CODE   DN_TRN_REPO_ROLLOVER.BORR_PORTFOLIO_CODE%TYPE;
  M_BORR_PF_TYPE          DN_REF_PORTFOLIO.PF_TYPE%TYPE;
  --ADDED ON 22-08-2001 BY CHAMPIKA
  M_PF_TYPE               DN_REF_PORTFOLIO.PF_TYPE%TYPE;
  M_PRIOR_DEAL_NO         DN_TRN_REPO_ROLLOVER.PRIOR_DEAL_NO%TYPE;
  -------------
  M_SCRP_FACE_VALUE_CURR  DN_TRN_REPO_ROLLOVER_SERIAL_NO.FACE_VALUE%TYPE;--CURRENCY
   M_SCRIPT_STATUS VARCHAR2(2);--$$##SC



BEGIN

------------------------$$##SC----------
 SELECT SCRIPT_STATUS
 INTO   M_SCRIPT_STATUS
 FROM   DN_TRN_REPO_ROLLOVER
 WHERE  DEAL_NO=M_DEAL_NO;
  -----------------------------------------

   SELECT
      TO_DATE(TO_CHAR(SYSDATE,'DD-MON-YYYY'),'DD-MON-YYYY'),
      A.EFF_VALDATE,
      A.LEND_PORTFOLIO_CODE,
      A.BORR_PORTFOLIO_CODE,
      A.MATURITY_DATE,
      B.PF_TYPE
      INTO M_CURR_DATE,M_EFF_VALDATE,
           M_LEND_PORTFOLIO_CODE,M_BORR_PORTFOLIO_CODE,
           M_MATURITY_DATE,M_BORR_PF_TYPE
   FROM
      DN_TRN_REPO_ROLLOVER A,
      DN_REF_PORTFOLIO B
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.BORR_PORTFOLIO_CODE=PORTFOLIO_CODE;

  ----------------------------
  -------- Repo inventory
  ----------------------------
  OPEN REPO_SERIAL_NO;

  LOOP

     FETCH  REPO_SERIAL_NO INTO

     M_INST_TYPE,M_SECURITY_CODE,M_SERIAL_NO,M_SCRP_FACE_VALUE,M_LOCATION,M_PREV_DEAL_NO,M_SCRP_FACE_VALUE_CURR;--CURRENCY

     EXIT WHEN REPO_SERIAL_NO%NOTFOUND;

        IF M_EFF_VALDATE<=M_CURR_DATE  THEN

           -- RAISE_APPLICATION_ERROR(-20201,'M_DEAL_NO '||M_DEAL_NO||'M_INST_TYPE '||M_INST_TYPE||'M_SECURITY_CODE '||M_SECURITY_CODE||'M_SERIAL_NO '||M_SERIAL_NO);

           -- Lender information

           INSERT INTO DN_INV_REPO_DEAL_SERIAL_NO
              (PORTFOLIO_CODE,
               EFF_VALDATE,
               INST_TYPE,
               SECURITY_CODE,
               DEAL_NO,

               SERIAL_NO,
               SCRIP_FACE_VAL,
               FACE_VAL,
               LOCATION,
               RET_DUE_DATE,
               FACE_VAL_CURR,--CURRENCY
                SCRIPT_STATUS--$$##SC
              )

               SELECT
                  A.PORTFOLIO_CODE,
                  A.EFF_VALDATE,
                  A.INST_TYPE,
                  A.SECURITY_CODE,
                  A.DEAL_NO,
                  M_SERIAL_NO,
                  M_SCRP_FACE_VALUE,
                  M_SCRP_FACE_VALUE,
                  --M_LOCATION,
                  DECODE(M_SCRIPT_STATUS,'SL',A.PORTFOLIO_CODE,M_LOCATION),--$$##SC
                  DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,A.SECURITY_CODE),
                  M_SCRP_FACE_VALUE_CURR,--CURRENCY
                  DECODE(M_SCRIPT_STATUS,'SL','SL','SC')--$$##SC
              FROM
                  DN_INV_REPO_DEAL_SEC A
               WHERE
                  A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
                  AND
                  A.EFF_VALDATE=M_EFF_VALDATE
                  AND
                  A.INST_TYPE=M_INST_TYPE
                  AND
                  A.SECURITY_CODE=M_SECURITY_CODE
                  AND
                  A.TRN_TYPE='LN'
                  AND
                  A.DEAL_NO=M_DEAL_NO;

          UPDATE  DN_INV_REPO_DEAL_SEC A
          SET (
              A.FACE_VAL,
              A.FACE_VAL_CURR
              )
              =
              (SELECT
                  A.FACE_VAL-B.FACE_VAL,A.FACE_VAL_CURR-B.FACE_VAL_CURR--CURRENCY
               FROM
                  DN_INV_REPO_DEAL_SERIAL_NO B
               WHERE
                  B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
                  AND
                  B.EFF_VALDATE=A.EFF_VALDATE
                  AND
                  B.INST_TYPE=A.INST_TYPE
                  AND
                  B.SECURITY_CODE=A.SECURITY_CODE
                  AND
                  B.DEAL_NO=A.DEAL_NO
                  AND
                  B.SERIAL_NO=M_SERIAL_NO)
           WHERE
              A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
              AND
              A.EFF_VALDATE=M_EFF_VALDATE
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.SECURITY_CODE=M_SECURITY_CODE
              AND
              A.DEAL_NO=M_DEAL_NO
              AND
              A.TRN_TYPE='LN';

          -- For the Borrower

          -- Serial no allocation from repo inv. of the brrower

        IF M_BORR_PF_TYPE='P' THEN

          INSERT INTO DN_INV_REPO_DEAL_SERNO_ALLO
            (PORTFOLIO_CODE,
             EFF_VALDATE,
             INST_TYPE,
             SECURITY_CODE,
             DEAL_NO,
             SERIAL_NO,
             ALLO_TYPE,
             START_DATE,
             END_DATE,
             ALLO_FACE_VALUE,
             PREV_DEAL_NO
             )
           VALUES
             (M_BORR_PORTFOLIO_CODE,
              M_EFF_VALDATE,
              M_INST_TYPE,
              M_SECURITY_CODE,
              M_DEAL_NO,
              M_SERIAL_NO,
              'RP',
              M_EFF_VALDATE,
              DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,M_SECURITY_CODE),
              M_SCRP_FACE_VALUE,
              M_PREV_DEAL_NO
              );

        UPDATE DN_INV_REPO_DEAL_SERIAL_NO
        SET ALLO_REPO=ALLO_REPO+M_SCRP_FACE_VALUE
        WHERE
           PORTFOLIO_CODE=M_BORR_PORTFOLIO_CODE
           AND
           INST_TYPE=M_INST_TYPE
           AND
           SECURITY_CODE=M_SECURITY_CODE
           AND
           DEAL_NO=M_PREV_DEAL_NO
           AND
           SERIAL_NO=M_SERIAL_NO;

        END IF;

          UPDATE  DN_INV_REPO_DEAL_SEC A
          SET (
              A.ALLO_REPO
              )
              =
              (SELECT
                  A.ALLO_REPO-NVL(B.ALLO_FACE_VALUE,0)
               FROM
                  DN_INV_REPO_DEAL_SERNO_ALLO B
               WHERE
                  B.PORTFOLIO_CODE=M_BORR_PORTFOLIO_CODE
                  AND
                  B.EFF_VALDATE=M_EFF_VALDATE
                  AND
                  B.INST_TYPE=M_INST_TYPE
                  AND
                  B.SECURITY_CODE=M_SECURITY_CODE
                  AND
                  B.DEAL_NO=M_DEAL_NO
                  AND
                  B.SERIAL_NO=M_SERIAL_NO
                  AND
                  B.ALLO_TYPE='RP'
                  AND
                  B.START_DATE=M_EFF_VALDATE
                  AND
                  B.END_DATE=DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,B.SECURITY_CODE)
                  )
           WHERE
              A.PORTFOLIO_CODE=M_BORR_PORTFOLIO_CODE
              AND
              A.EFF_VALDATE=M_EFF_VALDATE
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.SECURITY_CODE=M_SECURITY_CODE
              AND
              A.DEAL_NO=M_DEAL_NO
              AND
              A.TRN_TYPE='BR';

      ELSIF M_EFF_VALDATE>M_CURR_DATE  THEN

         --Lender

           INSERT INTO DN_INV_REPO_DEAL_SERIAL_NO
              (PORTFOLIO_CODE,
               EFF_VALDATE,
               INST_TYPE,
               SECURITY_CODE,
               DEAL_NO,

               SERIAL_NO,
               SCRIP_FACE_VAL,
               FWD_RECEIPT,
               LOCATION,
               RET_DUE_DATE,
               SCRIPT_STATUS,FACE_VAL--$$##SC
              )
               SELECT
                  A.PORTFOLIO_CODE,
                  A.EFF_VALDATE,
                  A.INST_TYPE,
                  A.SECURITY_CODE,
                  A.DEAL_NO,
                  M_SERIAL_NO,
                  M_SCRP_FACE_VALUE,
                  M_SCRP_FACE_VALUE,
                  --M_LOCATION,
                  DECODE(M_SCRIPT_STATUS,'SL',A.PORTFOLIO_CODE,M_LOCATION),--$$##SC
                  DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,A.SECURITY_CODE),
                  DECODE(M_SCRIPT_STATUS,'SL','SL','SC'),M_SCRP_FACE_VALUE--$$##SC
               FROM
                  DN_INV_REPO_DEAL_SEC A
               WHERE
                  A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
                  AND
                  A.EFF_VALDATE=M_EFF_VALDATE
                  AND
                  A.INST_TYPE=M_INST_TYPE
                  AND
                  A.SECURITY_CODE=M_SECURITY_CODE
                  AND
                  A.TRN_TYPE='LN'
                  AND
                  A.DEAL_NO=M_DEAL_NO;


          UPDATE DN_INV_REPO_DEAL_SEC A
          SET A.FWD_RECEIPT=A.FWD_RECEIPT-M_SCRP_FACE_VALUE
          WHERE
              A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
              AND
              A.EFF_VALDATE=M_EFF_VALDATE
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.SECURITY_CODE=M_SECURITY_CODE
              AND
              A.DEAL_NO=M_DEAL_NO
              AND
              A.TRN_TYPE='LN';

         ---For the Borrwer

       IF M_BORR_PF_TYPE='P' THEN

          INSERT INTO DN_INV_REPO_DEAL_SERNO_ALLO
            (PORTFOLIO_CODE,
             EFF_VALDATE,
             INST_TYPE,
             SECURITY_CODE,
             DEAL_NO,
             SERIAL_NO,
             ALLO_TYPE,
             START_DATE,
             END_DATE,
             ALLO_FACE_VALUE,
             PREV_DEAL_NO
             )
           VALUES
             (M_BORR_PORTFOLIO_CODE,
              M_EFF_VALDATE,
              M_INST_TYPE,
              M_SECURITY_CODE,
              M_DEAL_NO,
              M_SERIAL_NO,
              'RP',
              M_EFF_VALDATE,
              DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,M_SECURITY_CODE),
              M_SCRP_FACE_VALUE,
              M_PREV_DEAL_NO
              );

        UPDATE DN_INV_REPO_DEAL_SERIAL_NO
        SET FWD_ALLO_REPO=FWD_ALLO_REPO+M_SCRP_FACE_VALUE
        WHERE
           PORTFOLIO_CODE=M_BORR_PORTFOLIO_CODE
           AND
           INST_TYPE=M_INST_TYPE
           AND
           SECURITY_CODE=M_SECURITY_CODE
           AND
           DEAL_NO=M_PREV_DEAL_NO
           AND
           SERIAL_NO=M_SERIAL_NO;

       END IF;

          UPDATE DN_INV_REPO_DEAL_SEC A
          SET (
              A.FWD_ALLO_REPO
              )
              =
              (SELECT
                  A.FWD_ALLO_REPO-NVL(B.ALLO_FACE_VALUE,0)
               FROM
                  DN_INV_REPO_DEAL_SERNO_ALLO B
               WHERE
                  B.PORTFOLIO_CODE=M_BORR_PORTFOLIO_CODE
                  AND
                  B.EFF_VALDATE=M_EFF_VALDATE
                  AND
                  B.INST_TYPE=M_INST_TYPE
                  AND
                  B.SECURITY_CODE=M_SECURITY_CODE
                  AND
                  B.DEAL_NO=M_DEAL_NO
                  AND
                  B.SERIAL_NO=M_SERIAL_NO
                  AND
                  B.ALLO_TYPE='RP'
                  AND
                  B.START_DATE=M_EFF_VALDATE
                  AND
                  B.END_DATE=DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,B.SECURITY_CODE)
                  )
           WHERE
              A.PORTFOLIO_CODE=M_BORR_PORTFOLIO_CODE
              AND
              A.EFF_VALDATE=M_EFF_VALDATE
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.SECURITY_CODE=M_SECURITY_CODE
              AND
              A.DEAL_NO=M_DEAL_NO
              AND
              A.TRN_TYPE='BR';

    END IF;

         -- Update transaction level

         UPDATE DN_TRN_REPO_ROLLOVER_SERIAL_NO
           SET INV_STATUS='Y1'
         WHERE
            DEAL_NO=M_DEAL_NO
            AND
            INST_TYPE=M_INST_TYPE
            AND
            INV_CODE='RP'
            AND
            SECURITY_CODE=M_SECURITY_CODE
            AND
            SERIAL_NO=M_SERIAL_NO;

     END LOOP;


  ----------------------------
  -------- Outright inventory
  ----------------------------

  OPEN OUTP_SERIAL_NO;

  LOOP

     FETCH  OUTP_SERIAL_NO INTO

     M_INST_TYPE,M_SECURITY_CODE,M_SERIAL_NO,M_SCRP_FACE_VALUE,M_LOCATION,M_PREV_DEAL_NO,M_SCRP_FACE_VALUE_CURR;--CURRENCY

     EXIT WHEN OUTP_SERIAL_NO%NOTFOUND;

        IF M_EFF_VALDATE<=M_CURR_DATE  THEN

           -- RAISE_APPLICATION_ERROR(-20201,'M_DEAL_NO '||M_DEAL_NO||'M_INST_TYPE '||M_INST_TYPE||'M_SECURITY_CODE '||M_SECURITY_CODE||'M_SERIAL_NO '||M_SERIAL_NO);

           -- Lender information

           INSERT INTO DN_INV_REPO_DEAL_SERIAL_NO
              (PORTFOLIO_CODE,
               EFF_VALDATE,
               INST_TYPE,
               SECURITY_CODE,
               DEAL_NO,

               SERIAL_NO,
               SCRIP_FACE_VAL,
               FACE_VAL,
               LOCATION,
               RET_DUE_DATE,
               FACE_VAL_CURR,--CURRENCY
               SCRIPT_STATUS --$$##SC,
              )

               SELECT
                  A.PORTFOLIO_CODE,
                  A.EFF_VALDATE,
                  A.INST_TYPE,
                  A.SECURITY_CODE,
                  A.DEAL_NO,
                  M_SERIAL_NO,
                  M_SCRP_FACE_VALUE,
                  M_SCRP_FACE_VALUE,
                    DECODE(M_SCRIPT_STATUS,'SL',A.PORTFOLIO_CODE,M_LOCATION),--$$##SC,
                  DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,A.SECURITY_CODE),
                  M_SCRP_FACE_VALUE_CURR,--CURRENCY
                  DECODE(M_SCRIPT_STATUS,'SL','SL','SC')--$$##SC
              FROM
                  DN_INV_REPO_DEAL_SEC A
               WHERE
                  A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
                  AND
                  A.EFF_VALDATE=M_EFF_VALDATE
                  AND
                  A.INST_TYPE=M_INST_TYPE
                  AND
                  A.SECURITY_CODE=M_SECURITY_CODE
                  AND
                  A.TRN_TYPE='LN'
                  AND
                  A.DEAL_NO=M_DEAL_NO;

          UPDATE  DN_INV_REPO_DEAL_SEC A
          SET (
              A.FACE_VAL,A.FACE_VAL_CURR--CURRENCY
              )
              =
              (SELECT
                  A.FACE_VAL-B.FACE_VAL,A.FACE_VAL_CURR-B.FACE_VAL_CURR--CURRENCY
               FROM
                  DN_INV_REPO_DEAL_SERIAL_NO B
               WHERE
                  B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
                  AND
                  B.EFF_VALDATE=A.EFF_VALDATE
                  AND
                  B.INST_TYPE=A.INST_TYPE
                  AND
                  B.SECURITY_CODE=A.SECURITY_CODE
                  AND
                  B.DEAL_NO=A.DEAL_NO
                  AND
                  B.SERIAL_NO=M_SERIAL_NO)
           WHERE
              A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
              AND
              A.EFF_VALDATE=M_EFF_VALDATE
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.SECURITY_CODE=M_SECURITY_CODE
              AND
              A.DEAL_NO=M_DEAL_NO
              AND
              A.TRN_TYPE='LN';

        -- For the Borrower

        IF M_BORR_PF_TYPE='P' THEN

          INSERT INTO DN_INV_OUTPS_DEAL_SERNO_ALLO
            (PORTFOLIO_CODE,
             EFF_VALDATE,
             INST_TYPE,
             SECURITY_CODE,
             DEAL_NO,
             SERIAL_NO,
             ALLO_TYPE,
             START_DATE,
             END_DATE,
             ALLO_FACE_VALUE,
             PREV_DEAL_NO
             )
           VALUES
             (M_BORR_PORTFOLIO_CODE,
              M_EFF_VALDATE,
              M_INST_TYPE,
              M_SECURITY_CODE,
              M_DEAL_NO,
              M_SERIAL_NO,
              'RP',
              M_EFF_VALDATE,
              DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,M_SECURITY_CODE),
              M_SCRP_FACE_VALUE,
              M_PREV_DEAL_NO
              );

        UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
        SET ALLO_REPO=ALLO_REPO+M_SCRP_FACE_VALUE
        WHERE
           PORTFOLIO_CODE=M_BORR_PORTFOLIO_CODE
           AND
           INST_TYPE=M_INST_TYPE
           AND
           SECURITY_CODE=M_SECURITY_CODE
           AND
           DEAL_NO=M_PREV_DEAL_NO
           AND
           SERIAL_NO=M_SERIAL_NO;

     END IF;

          UPDATE  DN_INV_OUTPS_DEAL_SEC A
          SET (
              A.ALLO_REPO
              )
              =
              (SELECT
                  A.ALLO_REPO-NVL(B.ALLO_FACE_VALUE,0)
               FROM
                  DN_INV_OUTPS_DEAL_SERNO_ALLO B
               WHERE
                  B.PORTFOLIO_CODE=M_BORR_PORTFOLIO_CODE
                  AND
                  B.EFF_VALDATE=M_EFF_VALDATE
                  AND
                  B.INST_TYPE=M_INST_TYPE
                  AND
                  B.SECURITY_CODE=M_SECURITY_CODE
                  AND
                  B.DEAL_NO=M_DEAL_NO
                  AND
                  B.SERIAL_NO=M_SERIAL_NO
                  AND
                  B.ALLO_TYPE='RP'
                  AND
                  B.START_DATE=M_EFF_VALDATE
                  AND
                  B.END_DATE=DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,B.SECURITY_CODE)
                  )

           WHERE
              A.PORTFOLIO_CODE=M_BORR_PORTFOLIO_CODE
              AND
              A.EFF_VALDATE=M_EFF_VALDATE
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.SECURITY_CODE=M_SECURITY_CODE
              AND
              A.DEAL_NO=M_DEAL_NO
              AND
              A.TRN_TYPE='BR';

      ELSIF M_EFF_VALDATE>M_CURR_DATE  THEN

         --Lender

           INSERT INTO DN_INV_REPO_DEAL_SERIAL_NO
              (PORTFOLIO_CODE,
               EFF_VALDATE,
               INST_TYPE,
               SECURITY_CODE,
               DEAL_NO,
               SERIAL_NO,
               SCRIP_FACE_VAL,
               FWD_RECEIPT,
               LOCATION,
               RET_DUE_DATE,
               FACE_VAL_CURR,--CURRENCY
               SCRIPT_STATUS,FACE_VAL--$$##SC,
              )
               SELECT
                  A.PORTFOLIO_CODE,
                  A.EFF_VALDATE,
                  A.INST_TYPE,
                  A.SECURITY_CODE,
                  A.DEAL_NO,
                  M_SERIAL_NO,
                  M_SCRP_FACE_VALUE,
                  M_SCRP_FACE_VALUE,
                  DECODE(M_SCRIPT_STATUS,'SL',A.PORTFOLIO_CODE,M_LOCATION),--$$##SC,
                  DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,A.SECURITY_CODE),
                  M_SCRP_FACE_VALUE_CURR,--CURRENCY
                  DECODE(M_SCRIPT_STATUS,'SL','SL','SC'),M_SCRP_FACE_VALUE--$$##SC
               FROM
                  DN_INV_REPO_DEAL_SEC A
               WHERE
                  A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
                  AND
                  A.EFF_VALDATE=M_EFF_VALDATE
                  AND
                  A.INST_TYPE=M_INST_TYPE
                  AND
                  A.SECURITY_CODE=M_SECURITY_CODE
                  AND
                  A.TRN_TYPE='LN'
                  AND
                  A.DEAL_NO=M_DEAL_NO;

          UPDATE DN_INV_REPO_DEAL_SEC A
          SET A.FWD_RECEIPT=A.FWD_RECEIPT-M_SCRP_FACE_VALUE
          WHERE
              A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
              AND
              A.EFF_VALDATE=M_EFF_VALDATE
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.SECURITY_CODE=M_SECURITY_CODE
              AND
              A.DEAL_NO=M_DEAL_NO
              AND
              A.TRN_TYPE='LN';

         ---For the Borrwer

         IF M_BORR_PF_TYPE='P' THEN

          INSERT INTO DN_INV_OUTPS_DEAL_SERNO_ALLO
            (PORTFOLIO_CODE,
             EFF_VALDATE,
             INST_TYPE,
             SECURITY_CODE,
             DEAL_NO,
             SERIAL_NO,
             ALLO_TYPE,
             START_DATE,
             END_DATE,
             ALLO_FACE_VALUE,
             PREV_DEAL_NO
             )
           VALUES
             (M_BORR_PORTFOLIO_CODE,
              M_EFF_VALDATE,
              M_INST_TYPE,
              M_SECURITY_CODE,
              M_DEAL_NO,
              M_SERIAL_NO,
              'RP',
              M_EFF_VALDATE,
              DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,M_SECURITY_CODE),
              M_SCRP_FACE_VALUE,
              M_PREV_DEAL_NO
              );

        UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
        SET FWD_ALLO_REPO=FWD_ALLO_REPO+M_SCRP_FACE_VALUE
        WHERE
           PORTFOLIO_CODE=M_BORR_PORTFOLIO_CODE
           AND
           INST_TYPE=M_INST_TYPE
           AND
           SECURITY_CODE=M_SECURITY_CODE
           AND
           DEAL_NO=M_PREV_DEAL_NO
           AND
           SERIAL_NO=M_SERIAL_NO;

       END IF;

          UPDATE DN_INV_OUTPS_DEAL_SEC A
          SET (
              A.FWD_ALLO_REPO
              )
              =
              (SELECT
                  A.FWD_ALLO_REPO-NVL(B.ALLO_FACE_VALUE,0)
               FROM
                  DN_INV_OUTPS_DEAL_SERNO_ALLO B
               WHERE
                  B.PORTFOLIO_CODE=M_BORR_PORTFOLIO_CODE
                  AND
                  B.EFF_VALDATE=M_EFF_VALDATE
                  AND
                  B.INST_TYPE=M_INST_TYPE
                  AND
                  B.SECURITY_CODE=M_SECURITY_CODE
                  AND
                  B.DEAL_NO=M_DEAL_NO
                  AND
                  B.SERIAL_NO=M_SERIAL_NO
                  AND
                  B.ALLO_TYPE='RP'
                  AND
                  B.START_DATE=M_EFF_VALDATE
                  AND
                  B.END_DATE=DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,B.SECURITY_CODE)
                  )
           WHERE
              A.PORTFOLIO_CODE=M_BORR_PORTFOLIO_CODE
              AND
              A.EFF_VALDATE=M_EFF_VALDATE
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.SECURITY_CODE=M_SECURITY_CODE
              AND
              A.DEAL_NO=M_DEAL_NO
              AND
              A.TRN_TYPE='BR';

    END IF;

         -- Update transaction level

         UPDATE DN_TRN_REPO_ROLLOVER_SERIAL_NO
           SET INV_STATUS='Y1'
         WHERE
            DEAL_NO=M_DEAL_NO
            AND
            INST_TYPE=M_INST_TYPE
            AND
            INV_CODE='OR'
            AND
            SECURITY_CODE=M_SECURITY_CODE
            AND
            SERIAL_NO=M_SERIAL_NO;

     END LOOP;
     --ADDED BY CHAMPIKA-------------------------------------------------------------
     --NEW SECTION ADDED ON 22-08-2001 TO COVER REVERSE REPO INVENTORY ALREADY ALLOCATED
     --REPO OR OTHER TRANSACTION, AND THE REVERSE REPO IS ROLLED OVER

     SELECT  PF_TYPE   INTO M_PF_TYPE  FROM  DN_REF_PORTFOLIO
     WHERE  PORTFOLIO_CODE= M_LEND_PORTFOLIO_CODE ;

     IF M_PF_TYPE='P'THEN
       SELECT PRIOR_DEAL_NO INTO M_PRIOR_DEAL_NO FROM  DN_TRN_REPO_ROLLOVER
       WHERE DEAL_NO= M_DEAL_NO ;

       DN_INV_REPO_RR_DEAL_SERNO_FO_1(M_DEAL_NO,M_PRIOR_DEAL_NO,M_LEND_PORTFOLIO_CODE);
     END IF;

--END OF NEW SECTION ADDED ON 22-08-2001-------------------------------------------------


-----------
-- BL Inventory part
------------

  OPEN BL_SERIAL_NO;

  LOOP

     FETCH  BL_SERIAL_NO INTO

     M_INST_TYPE,M_SECURITY_CODE,M_SERIAL_NO,M_SCRP_FACE_VALUE,M_LOCATION,M_PREV_DEAL_NO,M_SCRP_FACE_VALUE_CURR;--CURRENCY

     EXIT WHEN BL_SERIAL_NO%NOTFOUND;

        IF M_EFF_VALDATE<=M_CURR_DATE  THEN

           -- RAISE_APPLICATION_ERROR(-20201,'M_DEAL_NO '||M_DEAL_NO||'M_INST_TYPE '||M_INST_TYPE||'M_SECURITY_CODE '||M_SECURITY_CODE||'M_SERIAL_NO '||M_SERIAL_NO);

           -- Lender information

           INSERT INTO DN_INV_REPO_DEAL_SERIAL_NO
              (PORTFOLIO_CODE,
               EFF_VALDATE,
               INST_TYPE,
               SECURITY_CODE,
               DEAL_NO,

               SERIAL_NO,
               SCRIP_FACE_VAL,
               FACE_VAL,
               LOCATION,
               RET_DUE_DATE,
               FACE_VAL_CURR,--CURRENCY
                SCRIPT_STATUS--$$##SC,
              )

               SELECT
                  A.PORTFOLIO_CODE,
                  A.EFF_VALDATE,
                  A.INST_TYPE,
                  A.SECURITY_CODE,
                  A.DEAL_NO,
                  M_SERIAL_NO,
                  M_SCRP_FACE_VALUE,
                  M_SCRP_FACE_VALUE,
                    DECODE(M_SCRIPT_STATUS,'SL',A.PORTFOLIO_CODE,M_LOCATION),--$$##SC,
                  DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,A.SECURITY_CODE),
                  M_SCRP_FACE_VALUE_CURR,--CURRENCY
                  DECODE(M_SCRIPT_STATUS,'SL','SL','SC')--$$##SC
              FROM
                  DN_INV_REPO_DEAL_SEC A
               WHERE
                  A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
                  AND
                  A.EFF_VALDATE=M_EFF_VALDATE
                  AND
                  A.INST_TYPE=M_INST_TYPE
                  AND
                  A.SECURITY_CODE=M_SECURITY_CODE
                  AND
                  A.TRN_TYPE='LN'
                  AND
                  A.DEAL_NO=M_DEAL_NO;

          UPDATE  DN_INV_REPO_DEAL_SEC A
          SET (
              A.FACE_VAL,A.FACE_VAL_CURR--CURRENCY
              )
              =
              (SELECT
                  A.FACE_VAL-B.FACE_VAL,A.FACE_VAL_CURR-B.FACE_VAL_CURR--CURRENCY
               FROM
                  DN_INV_REPO_DEAL_SERIAL_NO B
               WHERE
                  B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
                  AND
                  B.EFF_VALDATE=A.EFF_VALDATE
                  AND
                  B.INST_TYPE=A.INST_TYPE
                  AND
                  B.SECURITY_CODE=A.SECURITY_CODE
                  AND
                  B.DEAL_NO=A.DEAL_NO
                  AND
                  B.SERIAL_NO=M_SERIAL_NO)
           WHERE
              A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
              AND
              A.EFF_VALDATE=M_EFF_VALDATE
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.SECURITY_CODE=M_SECURITY_CODE
              AND
              A.DEAL_NO=M_DEAL_NO
              AND
              A.TRN_TYPE='LN';

        -- For the Borrower

        IF M_BORR_PF_TYPE='P' THEN

          INSERT INTO DN_INV_BL_DEAL_SERNO_ALLO
            (PORTFOLIO_CODE,
             EFF_VALDATE,
             INST_TYPE,
             SECURITY_CODE,
             DEAL_NO,
             SERIAL_NO,
             ALLO_TYPE,
             START_DATE,
             END_DATE,
             ALLO_FACE_VALUE,
             PREV_DEAL_NO
             )
           VALUES
             (M_BORR_PORTFOLIO_CODE,
              M_EFF_VALDATE,
              M_INST_TYPE,
              M_SECURITY_CODE,
              M_DEAL_NO,
              M_SERIAL_NO,
              'RP',
              M_EFF_VALDATE,
              DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,M_SECURITY_CODE),
              M_SCRP_FACE_VALUE,
              M_PREV_DEAL_NO
              );

        UPDATE DN_INV_BL_DEAL_SERIAL_NO
        SET ALLO_REPO=ALLO_REPO+M_SCRP_FACE_VALUE
        WHERE
           PORTFOLIO_CODE=M_BORR_PORTFOLIO_CODE
           AND
           INST_TYPE=M_INST_TYPE
           AND
           SECURITY_CODE=M_SECURITY_CODE
           AND
           DEAL_NO=M_PREV_DEAL_NO
           AND
           SERIAL_NO=M_SERIAL_NO;

     END IF;

          UPDATE  DN_INV_BL_DEAL_SEC A
          SET (
              A.ALLO_REPO
              )
              =
              (SELECT
                  A.ALLO_REPO-NVL(B.ALLO_FACE_VALUE,0)
               FROM
                  DN_INV_BL_DEAL_SERNO_ALLO B
               WHERE
                  B.PORTFOLIO_CODE=M_BORR_PORTFOLIO_CODE
                  AND
                  B.EFF_VALDATE=M_EFF_VALDATE
                  AND
                  B.INST_TYPE=M_INST_TYPE
                  AND
                  B.SECURITY_CODE=M_SECURITY_CODE
                  AND
                  B.DEAL_NO=M_DEAL_NO
                  AND
                  B.SERIAL_NO=M_SERIAL_NO
                  AND
                  B.ALLO_TYPE='RP'
                  AND
                  B.START_DATE=M_EFF_VALDATE
                  AND
                  B.END_DATE=DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,B.SECURITY_CODE)
                  )

           WHERE
              A.PORTFOLIO_CODE=M_BORR_PORTFOLIO_CODE
              AND
              A.EFF_VALDATE=M_EFF_VALDATE
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.SECURITY_CODE=M_SECURITY_CODE
              AND
              A.DEAL_NO=M_DEAL_NO
              AND
              A.TRN_TYPE='BR';

      ELSIF M_EFF_VALDATE>M_CURR_DATE  THEN

         --Lender

           INSERT INTO DN_INV_REPO_DEAL_SERIAL_NO
              (PORTFOLIO_CODE,
               EFF_VALDATE,
               INST_TYPE,
               SECURITY_CODE,
               DEAL_NO,

               SERIAL_NO,
               SCRIP_FACE_VAL,
               FWD_RECEIPT,
               LOCATION,
               RET_DUE_DATE,
               FACE_VAL_CURR,--CURRENCY
                 SCRIPT_STATUS--$$##SC
              )
               SELECT
                  A.PORTFOLIO_CODE,
                  A.EFF_VALDATE,
                  A.INST_TYPE,
                  A.SECURITY_CODE,
                  A.DEAL_NO,
                  M_SERIAL_NO,
                  M_SCRP_FACE_VALUE,
                  M_SCRP_FACE_VALUE,
                  DECODE(M_SCRIPT_STATUS,'SL',A.PORTFOLIO_CODE,M_LOCATION),--$$##SC
                  DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,A.SECURITY_CODE),
                  M_SCRP_FACE_VALUE_CURR,--CURRENCY
                  DECODE(M_SCRIPT_STATUS,'SL','SL','SC')--$$##SC
               FROM
                  DN_INV_REPO_DEAL_SEC A
               WHERE
                  A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
                  AND
                  A.EFF_VALDATE=M_EFF_VALDATE
                  AND
                  A.INST_TYPE=M_INST_TYPE
                  AND
                  A.SECURITY_CODE=M_SECURITY_CODE
                  AND
                  A.TRN_TYPE='LN'
                  AND
                  A.DEAL_NO=M_DEAL_NO;

          UPDATE DN_INV_REPO_DEAL_SEC A
          SET A.FWD_RECEIPT=A.FWD_RECEIPT-M_SCRP_FACE_VALUE
          WHERE
              A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
              AND
              A.EFF_VALDATE=M_EFF_VALDATE
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.SECURITY_CODE=M_SECURITY_CODE
              AND
              A.DEAL_NO=M_DEAL_NO
              AND
              A.TRN_TYPE='LN';

         ---For the Borrwer

         IF M_BORR_PF_TYPE='P' THEN

          INSERT INTO DN_INV_BL_DEAL_SERNO_ALLO
            (PORTFOLIO_CODE,
             EFF_VALDATE,
             INST_TYPE,
             SECURITY_CODE,
             DEAL_NO,
             SERIAL_NO,
             ALLO_TYPE,
             START_DATE,
             END_DATE,
             ALLO_FACE_VALUE,
             PREV_DEAL_NO
             )
           VALUES
             (M_BORR_PORTFOLIO_CODE,
              M_EFF_VALDATE,
              M_INST_TYPE,
              M_SECURITY_CODE,
              M_DEAL_NO,
              M_SERIAL_NO,
              'RP',
              M_EFF_VALDATE,
              DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,M_SECURITY_CODE),
              M_SCRP_FACE_VALUE,
              M_PREV_DEAL_NO
              );

        UPDATE DN_INV_BL_DEAL_SERIAL_NO
        SET FWD_ALLO_REPO=FWD_ALLO_REPO+M_SCRP_FACE_VALUE
        WHERE
           PORTFOLIO_CODE=M_BORR_PORTFOLIO_CODE
           AND
           INST_TYPE=M_INST_TYPE
           AND
           SECURITY_CODE=M_SECURITY_CODE
           AND
           DEAL_NO=M_PREV_DEAL_NO
           AND
           SERIAL_NO=M_SERIAL_NO;

       END IF;

          UPDATE DN_INV_BL_DEAL_SEC A
          SET (
              A.FWD_ALLO_REPO
              )
              =
              (SELECT
                  A.FWD_ALLO_REPO-NVL(B.ALLO_FACE_VALUE,0)
               FROM
                  DN_INV_OUTPS_DEAL_SERNO_ALLO B
               WHERE
                  B.PORTFOLIO_CODE=M_BORR_PORTFOLIO_CODE
                  AND
                  B.EFF_VALDATE=M_EFF_VALDATE
                  AND
                  B.INST_TYPE=M_INST_TYPE
                  AND
                  B.SECURITY_CODE=M_SECURITY_CODE
                  AND
                  B.DEAL_NO=M_DEAL_NO
                  AND
                  B.SERIAL_NO=M_SERIAL_NO
                  AND
                  B.ALLO_TYPE='RP'
                  AND
                  B.START_DATE=M_EFF_VALDATE
                  AND
                  B.END_DATE=DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,B.SECURITY_CODE)
                  )
           WHERE
              A.PORTFOLIO_CODE=M_BORR_PORTFOLIO_CODE
              AND
              A.EFF_VALDATE=M_EFF_VALDATE
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.SECURITY_CODE=M_SECURITY_CODE
              AND
              A.DEAL_NO=M_DEAL_NO
              AND
              A.TRN_TYPE='BR';

    END IF;

         -- Update transaction level

         UPDATE DN_TRN_REPO_ROLLOVER_SERIAL_NO
           SET INV_STATUS='Y1'
         WHERE
            DEAL_NO=M_DEAL_NO
            AND
            INST_TYPE=M_INST_TYPE
            AND
            INV_CODE='BL'
            AND
            SECURITY_CODE=M_SECURITY_CODE
            AND
            SERIAL_NO=M_SERIAL_NO;

     END LOOP;



END DN_INV_REPO_RR_DEAL_SERNO_FO;

/
