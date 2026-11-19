--------------------------------------------------------
--  DDL for Procedure DN_INV_BL_RF_DEAL_SERNO_FO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_BL_RF_DEAL_SERNO_FO" 
   (
    M_DEAL_NO      DN_TRN_BL_FUND.DEAL_NO%TYPE
   )

   IS

    -- Procedue     : Update (BL) Repo fresh inventory - deal-serial number -fo
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 19/08/1999


   CURSOR REPO_SERIAL_NO IS
     SELECT
        A.INST_TYPE,
        A.SECURITY_CODE,
        A.SERIAL_NO,
        A.FACE_VALUE,
        A.LOCATION,
        A.PREV_DEAL_NO
     FROM
        DN_TRN_BL_FUND_SERIAL_NO A
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
        A.PREV_DEAL_NO
     FROM
        DN_TRN_BL_FUND_SERIAL_NO A
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
        A.PREV_DEAL_NO
     FROM
        DN_TRN_BL_FUND_SERIAL_NO A
     WHERE
        A.DEAL_NO=M_DEAL_NO
        AND
        A.INV_CODE='BL'
        AND
        A.DATA_FROM='FO'
        AND
        A.INV_STATUS='N';

  M_PREV_DEAL_NO          DN_TRN_BL_FUND.DEAL_NO%TYPE;
  M_CURR_DATE             DN_TRN_BL_FUND.EFF_VALDATE%TYPE;
  M_EFF_VALDATE           DN_TRN_BL_FUND.EFF_VALDATE%TYPE;
  M_MATURITY_DATE         DN_TRN_BL_FUND.MATURITY_DATE%TYPE;
  M_INST_TYPE             DN_TRN_BL_FUND_SERIAL_NO.INST_TYPE%TYPE;
  M_SECURITY_CODE         DN_TRN_BL_FUND_SERIAL_NO.SECURITY_CODE%TYPE;
  M_SERIAL_NO             DN_TRN_BL_FUND_SERIAL_NO.SERIAL_NO%TYPE;
  M_LOCATION              DN_TRN_BL_FUND_SERIAL_NO.LOCATION%TYPE;
  M_SCRP_FACE_VALUE       DN_TRN_BL_FUND_SERIAL_NO.FACE_VALUE%TYPE;
  M_LEND_PORTFOLIO_CODE   DN_TRN_BL_FUND.LEND_PORTFOLIO_CODE%TYPE;
  M_BORR_PORTFOLIO_CODE   DN_TRN_BL_FUND.BORR_PORTFOLIO_CODE%TYPE;
  M_BORR_PF_TYPE          DN_REF_PORTFOLIO.PF_TYPE%TYPE;

BEGIN

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
      DN_TRN_BL_FUND A,
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

     M_INST_TYPE,M_SECURITY_CODE,M_SERIAL_NO,M_SCRP_FACE_VALUE,M_LOCATION,M_PREV_DEAL_NO;

     EXIT WHEN REPO_SERIAL_NO%NOTFOUND;

        IF M_EFF_VALDATE<=M_CURR_DATE  THEN

           -- RAISE_APPLICATION_ERROR(-20201,'M_DEAL_NO '||M_DEAL_NO||'M_INST_TYPE '||M_INST_TYPE||'M_SECURITY_CODE '||M_SECURITY_CODE||'M_SERIAL_NO '||M_SERIAL_NO);

           -- Lender information

           INSERT INTO DN_INV_BL_DEAL_SERIAL_NO
              (PORTFOLIO_CODE,
               EFF_VALDATE,
               INST_TYPE,
               SECURITY_CODE,
               DEAL_NO,

               SERIAL_NO,
               SCRIP_FACE_VAL,
               FACE_VAL,
               LOCATION,
               RET_DUE_DATE
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
                  M_LOCATION,
                  DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,A.SECURITY_CODE)
              FROM
                  DN_INV_BL_DEAL_SEC A
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

          UPDATE  DN_INV_BL_DEAL_SEC A
          SET (
              A.FACE_VAL
              )
              =
              (SELECT
                  A.FACE_VAL-B.FACE_VAL
               FROM
                  DN_INV_BL_DEAL_SERIAL_NO B
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
              'BL',
              M_EFF_VALDATE,
              DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,M_SECURITY_CODE),
              M_SCRP_FACE_VALUE,
              M_PREV_DEAL_NO
              );

        UPDATE DN_INV_REPO_DEAL_SERIAL_NO
        SET ALLO_BL=ALLO_BL+M_SCRP_FACE_VALUE
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
              A.ALLO_BL
              )
              =
              (SELECT
                  A.ALLO_BL-NVL(B.ALLO_FACE_VALUE,0)
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
                  B.ALLO_TYPE='BL'
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

           INSERT INTO DN_INV_BL_DEAL_SERIAL_NO
              (PORTFOLIO_CODE,
               EFF_VALDATE,
               INST_TYPE,
               SECURITY_CODE,
               DEAL_NO,

               SERIAL_NO,
               SCRIP_FACE_VAL,
               FWD_RECEIPT,
               LOCATION,
               RET_DUE_DATE
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
                  M_LOCATION,
                  DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,A.SECURITY_CODE)
               FROM
                  DN_INV_BL_DEAL_SEC A
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
              'LN',
              M_EFF_VALDATE,
              DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,M_SECURITY_CODE),
              M_SCRP_FACE_VALUE,
              M_PREV_DEAL_NO
              );

        UPDATE DN_INV_REPO_DEAL_SERIAL_NO
          SET FWD_ALLO_BL=FWD_ALLO_BL+M_SCRP_FACE_VALUE
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
              A.FWD_ALLO_BL
              )
              =
              (SELECT
                  A.FWD_ALLO_BL-NVL(B.ALLO_FACE_VALUE,0)
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
                  B.ALLO_TYPE='BL'
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

         UPDATE DN_TRN_BL_FUND_SERIAL_NO
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

     M_INST_TYPE,M_SECURITY_CODE,M_SERIAL_NO,M_SCRP_FACE_VALUE,M_LOCATION,M_PREV_DEAL_NO;

     EXIT WHEN OUTP_SERIAL_NO%NOTFOUND;

        IF M_EFF_VALDATE<=M_CURR_DATE  THEN

           -- RAISE_APPLICATION_ERROR(-20201,'M_DEAL_NO '||M_DEAL_NO||'M_INST_TYPE '||M_INST_TYPE||'M_SECURITY_CODE '||M_SECURITY_CODE||'M_SERIAL_NO '||M_SERIAL_NO);

           -- Lender information

           INSERT INTO DN_INV_BL_DEAL_SERIAL_NO
              (PORTFOLIO_CODE,
               EFF_VALDATE,
               INST_TYPE,
               SECURITY_CODE,
               DEAL_NO,

               SERIAL_NO,
               SCRIP_FACE_VAL,
               FACE_VAL,
               LOCATION,
               RET_DUE_DATE
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
                  M_LOCATION,
                  DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,A.SECURITY_CODE)
              FROM
                  DN_INV_BL_DEAL_SEC A
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

          UPDATE  DN_INV_BL_DEAL_SEC A
          SET (
              A.FACE_VAL
              )
              =
              (SELECT
                  A.FACE_VAL-B.FACE_VAL
               FROM
                  DN_INV_BL_DEAL_SERIAL_NO B
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
              'BL',
              M_EFF_VALDATE,
              DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,M_SECURITY_CODE),
              M_SCRP_FACE_VALUE,
              M_PREV_DEAL_NO
              );

          UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
            SET ALLO_BL=ALLO_BL+M_SCRP_FACE_VALUE
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

--        RAISE_APPLICATION_ERROR(-20201,'M_DEAL_NO '||M_DEAL_NO||'M_INST_TYPE '||M_INST_TYPE||'M_SECURITY_CODE '||M_SECURITY_CODE||'M_SERIAL_NO '||M_SERIAL_NO);


          UPDATE  DN_INV_OUTPS_DEAL_SEC A
          SET (
              A.ALLO_BL
              )
              =
              (SELECT
                  A.ALLO_BL-NVL(B.ALLO_FACE_VALUE,0)
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
                  B.ALLO_TYPE='BL'
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

           INSERT INTO DN_INV_BL_DEAL_SERIAL_NO
              (PORTFOLIO_CODE,
               EFF_VALDATE,
               INST_TYPE,
               SECURITY_CODE,
               DEAL_NO,

               SERIAL_NO,
               SCRIP_FACE_VAL,
               FWD_RECEIPT,
               LOCATION,
               RET_DUE_DATE
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
                  M_LOCATION,
                  DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,A.SECURITY_CODE)
               FROM
                  DN_INV_BL_DEAL_SEC A
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

          UPDATE DN_INV_BL_DEAL_SEC A
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
              'BL',
              M_EFF_VALDATE,
              DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,M_SECURITY_CODE),
              M_SCRP_FACE_VALUE,
              M_PREV_DEAL_NO
              );

          UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
            SET FWD_ALLO_BL=FWD_ALLO_BL+M_SCRP_FACE_VALUE
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
              A.FWD_ALLO_BL
              )
              =
             (SELECT
                  A.FWD_ALLO_BL-NVL(B.ALLO_FACE_VALUE,0)
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
                  B.ALLO_TYPE='BL'
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

         UPDATE DN_TRN_BL_FUND_SERIAL_NO
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

-----------
-- BL Inventory part
------------

  OPEN BL_SERIAL_NO;

  LOOP

     FETCH  BL_SERIAL_NO INTO

     M_INST_TYPE,M_SECURITY_CODE,M_SERIAL_NO,M_SCRP_FACE_VALUE,M_LOCATION,M_PREV_DEAL_NO;

     EXIT WHEN BL_SERIAL_NO%NOTFOUND;

        IF M_EFF_VALDATE<=M_CURR_DATE  THEN

           -- RAISE_APPLICATION_ERROR(-20201,'M_DEAL_NO '||M_DEAL_NO||'M_INST_TYPE '||M_INST_TYPE||'M_SECURITY_CODE '||M_SECURITY_CODE||'M_SERIAL_NO '||M_SERIAL_NO);

           -- Lender information

           INSERT INTO DN_INV_BL_DEAL_SERIAL_NO
              (PORTFOLIO_CODE,
               EFF_VALDATE,
               INST_TYPE,
               SECURITY_CODE,
               DEAL_NO,

               SERIAL_NO,
               SCRIP_FACE_VAL,
               FACE_VAL,
               LOCATION,
               RET_DUE_DATE
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
                  M_LOCATION,
                  DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,A.SECURITY_CODE)
              FROM
                  DN_INV_BL_DEAL_SEC A
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

          UPDATE  DN_INV_BL_DEAL_SEC A
          SET (
              A.FACE_VAL
              )
              =
              (SELECT
                  A.FACE_VAL-B.FACE_VAL
               FROM
                  DN_INV_BL_DEAL_SERIAL_NO B
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
              'BL',
              M_EFF_VALDATE,
              DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,M_SECURITY_CODE),
              M_SCRP_FACE_VALUE,
              M_PREV_DEAL_NO
              );

          UPDATE DN_INV_BL_DEAL_SERIAL_NO
            SET ALLO_BL=ALLO_BL+M_SCRP_FACE_VALUE
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

--        RAISE_APPLICATION_ERROR(-20201,'M_DEAL_NO '||M_DEAL_NO||'M_INST_TYPE '||M_INST_TYPE||'M_SECURITY_CODE '||M_SECURITY_CODE||'M_SERIAL_NO '||M_SERIAL_NO);


          UPDATE  DN_INV_BL_DEAL_SEC A
          SET (
              A.ALLO_BL
              )
              =
              (SELECT
                  A.ALLO_BL-NVL(B.ALLO_FACE_VALUE,0)
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
                  B.ALLO_TYPE='BL'
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

           INSERT INTO DN_INV_BL_DEAL_SERIAL_NO
              (PORTFOLIO_CODE,
               EFF_VALDATE,
               INST_TYPE,
               SECURITY_CODE,
               DEAL_NO,

               SERIAL_NO,
               SCRIP_FACE_VAL,
               FWD_RECEIPT,
               LOCATION,
               RET_DUE_DATE
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
                  M_LOCATION,
                  DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,A.SECURITY_CODE)
               FROM
                  DN_INV_BL_DEAL_SEC A
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

          UPDATE DN_INV_BL_DEAL_SEC A
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
              'BL',
              M_EFF_VALDATE,
              DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,M_SECURITY_CODE),
              M_SCRP_FACE_VALUE,
              M_PREV_DEAL_NO
              );

          UPDATE DN_INV_BL_DEAL_SERIAL_NO
            SET FWD_ALLO_BL=FWD_ALLO_BL+M_SCRP_FACE_VALUE
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
              A.FWD_ALLO_BL
              )
              =
             (SELECT
                  A.FWD_ALLO_BL-NVL(B.ALLO_FACE_VALUE,0)
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
                  B.ALLO_TYPE='BL'
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

         UPDATE DN_TRN_BL_FUND_SERIAL_NO
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


END DN_INV_BL_RF_DEAL_SERNO_FO;

/
