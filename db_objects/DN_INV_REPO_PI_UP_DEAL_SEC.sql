--------------------------------------------------------
--  DDL for Procedure DN_INV_REPO_PI_UP_DEAL_SEC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_REPO_PI_UP_DEAL_SEC" 
   (
    M_DEAL_NO      DN_TRN_REPO_PERIOD_INT.DEAL_NO%TYPE
   )

   IS

    -- Procedue     : Update repo periodic inventory - deal security
    -- System       : Dealnet system
    -- Created by   : V.Thilakesan
    -- Created on   : 02/03/2000

CURSOR REPO_PI_SEC IS
   SELECT
      A.INST_TYPE,
      A.SECURITY_CODE,
      A.FACE_VALUE,
      DN_FIN_RET_DUE_DATE(B.MATURITY_DATE,A.SECURITY_CODE)
   FROM
      DN_TRN_REPO_PERIOD_INT_SEC A,
      DN_TRN_REPO_PERIOD_INT B
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.INV_CODE='RP'
      AND
      A.INV_STATUS='N'
      AND
      A.DEAL_NO=B.DEAL_NO;

CURSOR OUTP_PI_SEC IS
   SELECT
      A.INST_TYPE,
      A.SECURITY_CODE,
      A.FACE_VALUE,
      DN_FIN_RET_DUE_DATE(B.MATURITY_DATE,A.SECURITY_CODE)
   FROM
      DN_TRN_REPO_PERIOD_INT_SEC A,
      DN_TRN_REPO_PERIOD_INT B
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.INV_CODE='OR'
      AND
      A.INV_STATUS='N'
      AND
      A.DEAL_NO=B.DEAL_NO;

CURSOR BL_PI_SEC IS
   SELECT
      A.INST_TYPE,
      A.SECURITY_CODE,
      A.FACE_VALUE,
      DN_FIN_RET_DUE_DATE(B.MATURITY_DATE,A.SECURITY_CODE)
   FROM
      DN_TRN_REPO_PERIOD_INT_SEC A,
      DN_TRN_REPO_PERIOD_INT B
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.INV_CODE='BL'
      AND
      A.INV_STATUS='N'
      AND
      A.DEAL_NO=B.DEAL_NO;


  M_CURR_DATE            DN_TRN_REPO_PERIOD_INT.EFF_VALDATE%TYPE;
  M_LEND_PORTFOLIO_CODE  DN_TRN_REPO_PERIOD_INT.LEND_PORTFOLIO_CODE%TYPE;
  M_EFF_VALDATE          DN_TRN_REPO_PERIOD_INT.EFF_VALDATE%TYPE;
  M_INST_TYPE            DN_TRN_REPO_PERIOD_INT_SEC.INST_TYPE%TYPE;
  M_SECURITY_CODE        DN_TRN_REPO_PERIOD_INT_SEC.SECURITY_CODE%TYPE;
  M_FACE_VALUE           DN_TRN_REPO_PERIOD_INT_SEC.FACE_VALUE%TYPE;
  M_RET_DUE_DATE         DN_INV_REPO_DEAL_SEC.RET_DUE_DATE%TYPE;


BEGIN


   SELECT
      TO_DATE(TO_CHAR(SYSDATE,'DD-MON-YYYY'),'DD-MON-YYYY'),
      EFF_VALDATE,LEND_PORTFOLIO_CODE
      INTO M_CURR_DATE,M_EFF_VALDATE,M_LEND_PORTFOLIO_CODE
   FROM
      DN_TRN_REPO_PERIOD_INT
   WHERE
      DEAL_NO=M_DEAL_NO;


  -- Update repo periodic inventory

  OPEN REPO_PI_SEC;

  LOOP

     FETCH  REPO_PI_SEC INTO

     M_INST_TYPE,M_SECURITY_CODE,M_FACE_VALUE,M_RET_DUE_DATE;

     EXIT WHEN REPO_PI_SEC%NOTFOUND;
     IF M_EFF_VALDATE<=M_CURR_DATE  THEN

       INSERT INTO DN_INV_REPO_DEAL_SEC
          (PORTFOLIO_CODE,
           EFF_VALDATE,
           INST_TYPE,
           SECURITY_CODE,
           TRN_TYPE,

           DEAL_NO,
           ALLO_REPO,
           LOCATION,
           RET_DUE_DATE
          )
       SELECT
          A.BORR_PORTFOLIO_CODE,
          A.EFF_VALDATE,
          M_INST_TYPE,
          M_SECURITY_CODE,
          'BR',

          A.DEAL_NO,
          M_FACE_VALUE,
          DECODE(A.SEC_ALW_LENDER,'Y',A.LEND_PORTFOLIO_CODE,A.BORR_PORTFOLIO_CODE),
          M_RET_DUE_DATE
       FROM
          DN_TRN_REPO_PERIOD_INT A,
          DN_REF_PORTFOLIO B
       WHERE
          A.DEAL_NO=M_DEAL_NO
          AND
          A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE
          AND
          B.PF_TYPE='P';

      -- Lender information

      INSERT INTO DN_INV_REPO_DEAL_SEC
          (PORTFOLIO_CODE,
           EFF_VALDATE,
           INST_TYPE,
           SECURITY_CODE,
           TRN_TYPE,

           DEAL_NO,
           FACE_VAL,
           LOCATION,
           RET_DUE_DATE
          )
       SELECT
          A.LEND_PORTFOLIO_CODE,
          A.EFF_VALDATE,
          M_INST_TYPE,
          M_SECURITY_CODE,
          'LN',

          A.DEAL_NO,
          M_FACE_VALUE,
          DECODE(A.SEC_ALW_LENDER,'Y',A.LEND_PORTFOLIO_CODE,A.BORR_PORTFOLIO_CODE),
          M_RET_DUE_DATE
       FROM
          DN_TRN_REPO_PERIOD_INT A,
          DN_REF_PORTFOLIO B
       WHERE
          A.DEAL_NO=M_DEAL_NO
          AND
          A.LEND_PORTFOLIO_CODE=B.PORTFOLIO_CODE
          AND
          B.PF_TYPE='P';

   ELSIF M_EFF_VALDATE>M_CURR_DATE  THEN

        -- Borrower information (issuer of the security)

       INSERT INTO DN_INV_REPO_DEAL_SEC
          (PORTFOLIO_CODE,
           EFF_VALDATE,
           INST_TYPE,
           SECURITY_CODE,
           TRN_TYPE,

           DEAL_NO,
           FWD_ALLO_REPO,
           LOCATION,
           RET_DUE_DATE
          )
       SELECT
          A.BORR_PORTFOLIO_CODE,
          A.EFF_VALDATE,
          M_INST_TYPE,
          M_SECURITY_CODE,
          'BR',

          A.DEAL_NO,
          M_FACE_VALUE,
          DECODE(A.SEC_ALW_LENDER,'Y',A.LEND_PORTFOLIO_CODE,A.BORR_PORTFOLIO_CODE),
          M_RET_DUE_DATE
       FROM
          DN_TRN_REPO_PERIOD_INT A,
          DN_REF_PORTFOLIO B
       WHERE
          A.DEAL_NO=M_DEAL_NO
          AND
          A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE
          AND
          B.PF_TYPE='P';

      -- Lender information

      INSERT INTO DN_INV_REPO_DEAL_SEC
          (PORTFOLIO_CODE,
           EFF_VALDATE,
           INST_TYPE,
           SECURITY_CODE,
           TRN_TYPE,

           DEAL_NO,
           FWD_RECEIPT,
           LOCATION,
           RET_DUE_DATE

          )
       SELECT
          A.LEND_PORTFOLIO_CODE,
          A.EFF_VALDATE,
          M_INST_TYPE,
          M_SECURITY_CODE,
          'LN',

          A.DEAL_NO,
          M_FACE_VALUE,
          DECODE(A.SEC_ALW_LENDER,'Y',A.LEND_PORTFOLIO_CODE,A.BORR_PORTFOLIO_CODE),
          M_RET_DUE_DATE
       FROM
          DN_TRN_REPO_PERIOD_INT A,
          DN_REF_PORTFOLIO B
       WHERE
          A.DEAL_NO=M_DEAL_NO
          AND
          A.LEND_PORTFOLIO_CODE=B.PORTFOLIO_CODE
          AND
          B.PF_TYPE='P';

   END IF;

       UPDATE DN_TRN_REPO_PERIOD_INT_SEC
          SET INV_STATUS='Y'
       WHERE
          DEAL_NO=M_DEAL_NO
          AND
          INST_TYPE=M_INST_TYPE
          AND
          INV_CODE='RP'
          AND
          SECURITY_CODE=SECURITY_CODE;


  END LOOP;

  -- Update Outright inventory

  OPEN OUTP_PI_SEC;

  LOOP

     FETCH  OUTP_PI_SEC INTO

     M_INST_TYPE,M_SECURITY_CODE,M_FACE_VALUE,M_RET_DUE_DATE;

     EXIT WHEN OUTP_PI_SEC%NOTFOUND;
     IF M_EFF_VALDATE<=M_CURR_DATE  THEN

        -- Borrower information (issuer of the security)

       INSERT INTO DN_INV_OUTPS_DEAL_SEC
          (PORTFOLIO_CODE,
           EFF_VALDATE,
           INST_TYPE,
           SECURITY_CODE,
           TRN_TYPE,

           DEAL_NO,
           ALLO_REPO,
           LOCATION,
           RET_DUE_DATE
          )

       SELECT
          A.BORR_PORTFOLIO_CODE,
          A.EFF_VALDATE,
          M_INST_TYPE,
          M_SECURITY_CODE,
          'BR',

          A.DEAL_NO,
          M_FACE_VALUE,
          DECODE(A.SEC_ALW_LENDER,'Y',A.LEND_PORTFOLIO_CODE,A.BORR_PORTFOLIO_CODE),
          M_RET_DUE_DATE
       FROM
          DN_TRN_REPO_PERIOD_INT A,
          DN_REF_PORTFOLIO B
       WHERE
          A.DEAL_NO=M_DEAL_NO
          AND
          A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE
          AND
          B.PF_TYPE='P';
--RAISE_APPLICATION_ERROR(-20201,M_EFF_VALDATE||'   '||M_CURR_DATE);

      -- Lender information

      UPDATE DN_INV_REPO_DEAL_SEC
         SET FACE_VAL=FACE_VAL+M_FACE_VALUE
      WHERE
          PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
          AND
          EFF_VALDATE=M_EFF_VALDATE
          AND
          INST_TYPE=M_INST_TYPE
          AND
          SECURITY_CODE=M_SECURITY_CODE
          AND
          DEAL_NO=M_DEAL_NO;

      IF SQL%NOTFOUND THEN

         INSERT INTO DN_INV_REPO_DEAL_SEC
            (PORTFOLIO_CODE,
             EFF_VALDATE,
             INST_TYPE,
             SECURITY_CODE,
             TRN_TYPE,

             DEAL_NO,
             FACE_VAL,
             LOCATION,
             RET_DUE_DATE
            )
         SELECT
            A.LEND_PORTFOLIO_CODE,
            A.EFF_VALDATE,
            M_INST_TYPE,
            M_SECURITY_CODE,
            'LN',

            A.DEAL_NO,
            M_FACE_VALUE,
            DECODE(A.SEC_ALW_LENDER,'Y',A.LEND_PORTFOLIO_CODE,A.BORR_PORTFOLIO_CODE),
            M_RET_DUE_DATE
         FROM
            DN_TRN_REPO_PERIOD_INT A,
            DN_REF_PORTFOLIO B
         WHERE
            A.DEAL_NO=M_DEAL_NO
            AND
            A.LEND_PORTFOLIO_CODE=B.PORTFOLIO_CODE
            AND
            B.PF_TYPE='P';

     END IF;

   ELSIF M_EFF_VALDATE>M_CURR_DATE  THEN

        -- Borrower information (issuer of the security)

       INSERT INTO DN_INV_OUTPS_DEAL_SEC
          (PORTFOLIO_CODE,
           EFF_VALDATE,
           INST_TYPE,
           SECURITY_CODE,
           TRN_TYPE,

           DEAL_NO,
           FWD_ALLO_REPO,
           LOCATION,
           RET_DUE_DATE
          )
       SELECT
          A.BORR_PORTFOLIO_CODE,
          A.EFF_VALDATE,
          M_INST_TYPE,
          M_SECURITY_CODE,
          'BR',

          A.DEAL_NO,
          M_FACE_VALUE,
          DECODE(A.SEC_ALW_LENDER,'Y',A.LEND_PORTFOLIO_CODE,A.BORR_PORTFOLIO_CODE),
          M_RET_DUE_DATE
       FROM
          DN_TRN_REPO_PERIOD_INT A,
          DN_REF_PORTFOLIO B
       WHERE
          A.DEAL_NO=M_DEAL_NO
          AND
          A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE
          AND
          B.PF_TYPE='P';

      -- Lender information


        UPDATE DN_INV_REPO_DEAL_SEC
           SET FWD_RECEIPT=FWD_RECEIPT+M_FACE_VALUE
        WHERE
            PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
            AND
            EFF_VALDATE=M_EFF_VALDATE
            AND
            INST_TYPE=M_INST_TYPE
            AND
            SECURITY_CODE=M_SECURITY_CODE
            AND
            DEAL_NO=M_DEAL_NO;

      IF SQL%NOTFOUND THEN

        INSERT INTO DN_INV_REPO_DEAL_SEC
            (PORTFOLIO_CODE,
             EFF_VALDATE,
             INST_TYPE,
             SECURITY_CODE,
             TRN_TYPE,

             DEAL_NO,
             FWD_RECEIPT,
             LOCATION,
             RET_DUE_DATE
            )
         SELECT
            A.LEND_PORTFOLIO_CODE,
            A.EFF_VALDATE,
            M_INST_TYPE,
            M_SECURITY_CODE,
            'LN',

            A.DEAL_NO,
            M_FACE_VALUE,
            DECODE(A.SEC_ALW_LENDER,'Y',A.LEND_PORTFOLIO_CODE,A.BORR_PORTFOLIO_CODE),
            M_RET_DUE_DATE
         FROM
            DN_TRN_REPO_PERIOD_INT A,
            DN_REF_PORTFOLIO B
         WHERE
            A.DEAL_NO=M_DEAL_NO
            AND
            A.LEND_PORTFOLIO_CODE=B.PORTFOLIO_CODE
            AND
            B.PF_TYPE='P';

     END IF;


  END IF;


     UPDATE DN_TRN_REPO_PERIOD_INT_SEC
          SET INV_STATUS='Y'
       WHERE
          DEAL_NO=M_DEAL_NO
          AND
          INST_TYPE=M_INST_TYPE
          AND
          INV_CODE='OR'
          AND
          SECURITY_CODE=SECURITY_CODE;


  END LOOP;

-----------
-- BL Inventory part
------------

  OPEN BL_PI_SEC;

  LOOP

     FETCH  BL_PI_SEC INTO

     M_INST_TYPE,M_SECURITY_CODE,M_FACE_VALUE,M_RET_DUE_DATE;

     EXIT WHEN BL_PI_SEC%NOTFOUND;

     IF M_EFF_VALDATE<=M_CURR_DATE  THEN

        -- Borrower information (issuer of the security)

       INSERT INTO DN_INV_BL_DEAL_SEC
          (PORTFOLIO_CODE,
           EFF_VALDATE,
           INST_TYPE,
           SECURITY_CODE,
           TRN_TYPE,

           DEAL_NO,
           ALLO_REPO,
           LOCATION,
           RET_DUE_DATE
          )

       SELECT
          A.BORR_PORTFOLIO_CODE,
          A.EFF_VALDATE,
          M_INST_TYPE,
          M_SECURITY_CODE,
          'BR',

          A.DEAL_NO,
          M_FACE_VALUE,
          DECODE(A.SEC_ALW_LENDER,'Y',A.LEND_PORTFOLIO_CODE,A.BORR_PORTFOLIO_CODE),
          M_RET_DUE_DATE
       FROM
          DN_TRN_REPO_PERIOD_INT A,
          DN_REF_PORTFOLIO B
       WHERE
          A.DEAL_NO=M_DEAL_NO
          AND
          A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE
          AND
          B.PF_TYPE='P';

      -- Lender information


      UPDATE DN_INV_REPO_DEAL_SEC
          SET FACE_VAL=FACE_VAL+M_FACE_VALUE
      WHERE
          PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
          AND
          EFF_VALDATE=M_EFF_VALDATE
          AND
          INST_TYPE=M_INST_TYPE
          AND
          SECURITY_CODE=M_SECURITY_CODE
          AND
          DEAL_NO=M_DEAL_NO;

      IF SQL%NOTFOUND THEN


      INSERT INTO DN_INV_REPO_DEAL_SEC
          (PORTFOLIO_CODE,
           EFF_VALDATE,
           INST_TYPE,
           SECURITY_CODE,
           TRN_TYPE,

           DEAL_NO,
           FACE_VAL,
           LOCATION,
           RET_DUE_DATE
          )
       SELECT
          A.LEND_PORTFOLIO_CODE,
          A.EFF_VALDATE,
          M_INST_TYPE,
          M_SECURITY_CODE,
          'LN',

          A.DEAL_NO,
          M_FACE_VALUE,
          DECODE(A.SEC_ALW_LENDER,'Y',A.LEND_PORTFOLIO_CODE,A.BORR_PORTFOLIO_CODE),
          M_RET_DUE_DATE
       FROM
          DN_TRN_REPO_PERIOD_INT A,
          DN_REF_PORTFOLIO B
       WHERE
          A.DEAL_NO=M_DEAL_NO
          AND
          A.LEND_PORTFOLIO_CODE=B.PORTFOLIO_CODE
          AND
          B.PF_TYPE='P';

     END IF;

   ELSIF M_EFF_VALDATE>M_CURR_DATE  THEN

        -- Borrower information (issuer of the security)

       INSERT INTO DN_INV_BL_DEAL_SEC
          (PORTFOLIO_CODE,
           EFF_VALDATE,
           INST_TYPE,
           SECURITY_CODE,
           TRN_TYPE,

           DEAL_NO,
           FWD_ALLO_REPO,
           LOCATION,
           RET_DUE_DATE
          )
       SELECT
          A.BORR_PORTFOLIO_CODE,
          A.EFF_VALDATE,
          M_INST_TYPE,
          M_SECURITY_CODE,
          'BR',

          A.DEAL_NO,
          M_FACE_VALUE,
          DECODE(A.SEC_ALW_LENDER,'Y',A.LEND_PORTFOLIO_CODE,A.BORR_PORTFOLIO_CODE),
          M_RET_DUE_DATE
       FROM
          DN_TRN_REPO_PERIOD_INT A,
          DN_REF_PORTFOLIO B
       WHERE
          A.DEAL_NO=M_DEAL_NO
          AND
          A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE
          AND
          B.PF_TYPE='P';

      -- Lender information

        UPDATE DN_INV_REPO_DEAL_SEC
           SET FWD_RECEIPT=FWD_RECEIPT+M_FACE_VALUE
        WHERE
            PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
            AND
            EFF_VALDATE=M_EFF_VALDATE
            AND
            INST_TYPE=M_INST_TYPE
            AND
            SECURITY_CODE=M_SECURITY_CODE
            AND
            DEAL_NO=M_DEAL_NO;

      IF SQL%NOTFOUND THEN


      INSERT INTO DN_INV_REPO_DEAL_SEC
          (PORTFOLIO_CODE,
           EFF_VALDATE,
           INST_TYPE,
           SECURITY_CODE,
           TRN_TYPE,

           DEAL_NO,
           FWD_RECEIPT,
           LOCATION,
           RET_DUE_DATE
          )
       SELECT
          A.LEND_PORTFOLIO_CODE,
          A.EFF_VALDATE,
          M_INST_TYPE,
          M_SECURITY_CODE,
          'LN',

          A.DEAL_NO,
          M_FACE_VALUE,
          DECODE(A.SEC_ALW_LENDER,'Y',A.LEND_PORTFOLIO_CODE,A.BORR_PORTFOLIO_CODE),
          M_RET_DUE_DATE
       FROM
          DN_TRN_REPO_PERIOD_INT A,
          DN_REF_PORTFOLIO B
       WHERE
          A.DEAL_NO=M_DEAL_NO
          AND
          A.LEND_PORTFOLIO_CODE=B.PORTFOLIO_CODE
          AND
          B.PF_TYPE='P';

    END IF;

   END IF;


     UPDATE DN_TRN_REPO_PERIOD_INT_SEC
          SET INV_STATUS='Y'
       WHERE
          DEAL_NO=M_DEAL_NO
          AND
          INST_TYPE=M_INST_TYPE
          AND
          INV_CODE='BL'
          AND
          SECURITY_CODE=SECURITY_CODE;


  END LOOP;

END DN_INV_REPO_PI_UP_DEAL_SEC;

/
