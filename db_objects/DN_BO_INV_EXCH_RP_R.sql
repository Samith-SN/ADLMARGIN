--------------------------------------------------------
--  DDL for Procedure DN_BO_INV_EXCH_RP_R
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_BO_INV_EXCH_RP_R" 
  (
    M_INV_EXCHG_NO      DN_TRN_BO_INV_EXCHANGE.INV_EXCHG_NO%TYPE,
    M_COUNP_LOCATION    DN_TRN_REPO_FRESH.BORR_PORTFOLIO_CODE%TYPE --ADDED BY SM ON 25/05/2000 TO REMEDY ERRORS IN LOCATION SUBSEQUENT TO AN 'EXCHANGE'
   )

   IS

    -- Procedue     : Update exchange of inventory from the R/P inventory (hence 'RP_R')
    -- System       : Dealnet system
    -- Created by   : TDS / SM
    -- Created on   : 03/11/1999


--PERFORM A CHECK TO REFER TO THE DEAL NUMBER AND DETERMINE WETHER THE THE PORTFOLIO IS LENDER
--AND WETHER THE SUBSTRING OF THE DEAL NUMBER IS 'RF' OR 'RR'
--TO BE CHECKED AT THE POINT OF CALLING THE PROCEDURE



  CURSOR  EXCH_ISSUES IS

      SELECT
          A.PORTFOLIO_CODE,
          A.INST_TYPE,
          A.SECURITY_CODE,
          A.DEAL_NO,
          A.SERIAL_NO,
          A.FACE_VAL
       FROM
          DN_INV_REPO_DEAL_SERIAL_NO A,
          DN_TRN_BO_INV_EXCHANGE B
       WHERE
          B.INV_EXCHG_NO=M_INV_EXCHG_NO
          AND
          B.INV_CODE='RP'
          AND
          B.TRANS_TYPE='I'
          AND
          B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
          AND
          B.INST_TYPE=A.INST_TYPE
          AND
          B.SECURITY_CODE=A.SECURITY_CODE
          AND
          B.DEAL_NO=A.DEAL_NO
          AND
          B.SERIAL_NO=A.SERIAL_NO;


  CURSOR  EXCH_RECEIPTS IS

      SELECT
          C.PORTFOLIO_CODE,
          C.INST_TYPE,
          C.SECURITY_CODE,
          C.DEAL_NO,
          C.SERIAL_NO,
          C.FACE_VALUE
       FROM
          DN_TRN_BO_INV_EXCHANGE C
       WHERE
          C.INV_EXCHG_NO=M_INV_EXCHG_NO
          AND
          C.INV_CODE='RP'
          AND
          C.TRANS_TYPE='R';


M_PORTFOLIO_CODE                DN_INV_REPO_DEAL_SERIAL_NO.PORTFOLIO_CODE%TYPE;
M_INST_TYPE                     DN_INV_REPO_DEAL_SERIAL_NO.INST_TYPE%TYPE;
M_SECURITY_CODE                 DN_INV_REPO_DEAL_SERIAL_NO.SECURITY_CODE%TYPE;
M_DEAL_NO                       DN_INV_REPO_DEAL_SERIAL_NO.DEAL_NO%TYPE;
M_SERIAL_NO                     DN_INV_REPO_DEAL_SERIAL_NO.SERIAL_NO%TYPE;
M_LOCATION                      DN_INV_REPO_DEAL_SERIAL_NO.LOCATION%TYPE;
M_RET_DUE_DATE                  DN_INV_REPO_DEAL_SERIAL_NO.RET_DUE_DATE%TYPE;
M_FACE_VALUE                    DN_INV_REPO_DEAL_SERIAL_NO.FACE_VAL%TYPE;
U_DEAL_NO                       DN_INV_REPO_DEAL_SERIAL_NO.DEAL_NO%TYPE;
U_SECURITY_CODE                 DN_INV_REPO_DEAL_SERIAL_NO.SECURITY_CODE%TYPE;
U_INV_CODE                      DN_TRN_REPO_FRESH_SEC.INV_CODE%TYPE;
U_FACE_VALUE                    DN_INV_REPO_DEAL_SERIAL_NO.FACE_VAL%TYPE;
BAL_FACE_VALUE                  DN_INV_REPO_DEAL_SERIAL_NO.FACE_VAL%TYPE;
CURS_UP_SEC                     SASIAPLSQLTAB.SEC_SUM;
M_COUNT                         NUMBER;
M_SCRIPT_STATUS                 DN_INV_REPO_DEAL_SERIAL_NO.SCRIPT_STATUS%TYPE;--$$##SC
M_LEND_PORTFOLIO_CODE           DN_INV_REPO_DEAL_SERIAL_NO.PORTFOLIO_CODE%TYPE;---VC BY KEITH ON 13-07-2004

BEGIN

   OPEN EXCH_ISSUES;

   LOOP

      FETCH  EXCH_ISSUES INTO

          M_PORTFOLIO_CODE,
          M_INST_TYPE,
          M_SECURITY_CODE,
          M_DEAL_NO,
          M_SERIAL_NO,
          M_FACE_VALUE;


      EXIT WHEN EXCH_ISSUES%NOTFOUND;


      UPDATE DN_INV_REPO_DEAL_SERIAL_NO
      SET RET_DUE_DATE=SYSDATE,
          LOCATION=M_COUNP_LOCATION
      WHERE
          PORTFOLIO_CODE=M_PORTFOLIO_CODE
          AND
          INST_TYPE=M_INST_TYPE
          AND
          SECURITY_CODE=M_SECURITY_CODE
          AND
          DEAL_NO=M_DEAL_NO
          AND
          SERIAL_NO=M_SERIAL_NO;


     IF SUBSTR(M_DEAL_NO,1,2)='RF' THEN

        DELETE DN_TRN_REPO_FRESH_SERIAL_NO
        WHERE
          DEAL_NO=M_DEAL_NO
          AND
          SECURITY_CODE=M_SECURITY_CODE
          AND
          SERIAL_NO=M_SERIAL_NO;

       OPEN CURS_UP_SEC FOR

           SELECT DEAL_NO,SECURITY_CODE,INV_CODE,FACE_VALUE
           FROM DN_TRN_REPO_FRESH_SEC
           WHERE
              DEAL_NO=M_DEAL_NO
              AND
              SECURITY_CODE=M_SECURITY_CODE;

       BAL_FACE_VALUE:=M_FACE_VALUE;

       LOOP

           FETCH  CURS_UP_SEC INTO

            U_DEAL_NO,
            U_SECURITY_CODE,
            U_INV_CODE,
            U_FACE_VALUE;

          EXIT WHEN CURS_UP_SEC%NOTFOUND OR BAL_FACE_VALUE=0;

          IF U_FACE_VALUE<BAL_FACE_VALUE THEN
             UPDATE DN_TRN_REPO_FRESH_SEC
             SET  FACE_VALUE=0
             WHERE
                DEAL_NO=U_DEAL_NO
                AND
                SECURITY_CODE=U_SECURITY_CODE
                AND
                INV_CODE=U_INV_CODE;

             BAL_FACE_VALUE:=BAL_FACE_VALUE-U_FACE_VALUE;

          ELSE
             UPDATE DN_TRN_REPO_FRESH_SEC
             SET  FACE_VALUE=FACE_VALUE-BAL_FACE_VALUE
             WHERE
                DEAL_NO=U_DEAL_NO
                AND
                SECURITY_CODE=U_SECURITY_CODE
                AND
                INV_CODE=U_INV_CODE;

             BAL_FACE_VALUE:=0;


          END IF;

       END LOOP;


    ELSIF SUBSTR(M_DEAL_NO,1,2)='RR' THEN

        DELETE DN_TRN_REPO_ROLLOVER_SERIAL_NO
        WHERE
          DEAL_NO=M_DEAL_NO
          AND
          SECURITY_CODE=M_SECURITY_CODE
          AND
          SERIAL_NO=M_SERIAL_NO;

       OPEN CURS_UP_SEC FOR

           SELECT DEAL_NO,SECURITY_CODE,INV_CODE,FACE_VALUE
           FROM DN_TRN_REPO_ROLLOVER_SEC
           WHERE
              DEAL_NO=M_DEAL_NO
              AND
              SECURITY_CODE=M_SECURITY_CODE;

       BAL_FACE_VALUE:=M_FACE_VALUE;

       LOOP

           FETCH  CURS_UP_SEC INTO

            U_DEAL_NO,
            U_SECURITY_CODE,
            U_INV_CODE,
            U_FACE_VALUE;

          EXIT WHEN CURS_UP_SEC%NOTFOUND OR BAL_FACE_VALUE=0;

          IF U_FACE_VALUE<BAL_FACE_VALUE THEN
             UPDATE DN_TRN_REPO_ROLLOVER_SEC
             SET  FACE_VALUE=0
             WHERE
                DEAL_NO=U_DEAL_NO
                AND
                SECURITY_CODE=U_SECURITY_CODE
                AND
                INV_CODE=U_INV_CODE;

             BAL_FACE_VALUE:=BAL_FACE_VALUE-U_FACE_VALUE;

          ELSE
             UPDATE DN_TRN_REPO_ROLLOVER_SEC
             SET  FACE_VALUE=FACE_VALUE-BAL_FACE_VALUE
             WHERE
                DEAL_NO=U_DEAL_NO
                AND
                SECURITY_CODE=U_SECURITY_CODE
                AND
                INV_CODE=U_INV_CODE;

             BAL_FACE_VALUE:=0;


          END IF;

       END LOOP;

     END IF;

   END LOOP;


   OPEN EXCH_RECEIPTS;

   LOOP

      FETCH  EXCH_RECEIPTS INTO

          M_PORTFOLIO_CODE,
          M_INST_TYPE,
          M_SECURITY_CODE,
          M_DEAL_NO,
          M_SERIAL_NO,
          M_FACE_VALUE;


      EXIT WHEN EXCH_RECEIPTS%NOTFOUND;


       M_LOCATION:=M_PORTFOLIO_CODE;
       /*SELECT
          M_PORTFOLIO_CODE--MAX(A.LOCATION),
          --MAX(A.RET_DUE_DATE)
       INTO
          M_LOCATION
          --M_RET_DUE_DATE
       FROM
          DN_INV_REPO_DEAL_SERIAL_NO A
       WHERE
          A.DEAL_NO=M_DEAL_NO;*/

       IF SUBSTR(M_DEAL_NO,1,2)='RF' THEN

           SELECT
          MATURITY_DATE,SCRIPT_STATUS,LEND_PORTFOLIO_CODE---VC BY KEITH ON 13-07-2004
         INTO
          M_RET_DUE_DATE,M_SCRIPT_STATUS,M_LEND_PORTFOLIO_CODE--$$##SC---VC BY KEITH ON 13-07-2004
         FROM
          DN_TRN_REPO_FRESH A
         WHERE
          A.DEAL_NO=M_DEAL_NO;

       ELSIF SUBSTR(M_DEAL_NO,1,2)='RR' THEN

        SELECT
          MATURITY_DATE,SCRIPT_STATUS,LEND_PORTFOLIO_CODE---VC BY KEITH ON 13-07-2004
         INTO
          M_RET_DUE_DATE,M_SCRIPT_STATUS,M_LEND_PORTFOLIO_CODE--$$##SC---VC BY KEITH ON 13-07-2004
         FROM
          DN_TRN_REPO_ROLLOVER A
         WHERE
          A.DEAL_NO=M_DEAL_NO;

       END IF;

       INSERT INTO DN_INV_REPO_DEAL_SERIAL_NO
         (PORTFOLIO_CODE,
          EFF_VALDATE,
          INST_TYPE,
          SECURITY_CODE,
          DEAL_NO,
          SERIAL_NO,
          SCRIP_FACE_VAL,
          FACE_VAL,
          FWD_RECEIPT,
          LOCATION,
          ALLO_REPO ,
          ALLO_BL,
          FWD_ALLO_REPO,
          FWD_ALLO_BL,
          RET_DUE_DATE,
          SCRIPT_STATUS--$$##SC
         )
       SELECT
          M_PORTFOLIO_CODE,
          SYSDATE,
          M_INST_TYPE,
          M_SECURITY_CODE,
          M_DEAL_NO,
          M_SERIAL_NO,
          M_FACE_VALUE,
          M_FACE_VALUE,
          0.00,                                 --M_TOT_FWD_RECEIPT*(M_FACE_VALUE/M_TOT_FACE_VAL),
          M_LOCATION,
          0.00,                                 --M_TOT_ALLO_REPO*(M_FACE_VALUE/M_TOT_FACE_VAL),
          0.00,                                 --M_TOT_ALLO_BL*(M_FACE_VALUE/M_TOT_FACE_VAL),
          0.00,                                 --M_TOT_FWD_ALLO_REPO*(M_FACE_VALUE/M_TOT_FACE_VAL),
          0.00,                                 --M_TOT_FWD_ALLO_BL*(M_FACE_VALUE/M_TOT_FACE_VAL),
          M_RET_DUE_DATE,
          M_SCRIPT_STATUS--$$##SC
       FROM
          DUAL;


      IF SUBSTR(M_DEAL_NO,1,2)='RF' THEN

               SELECT COUNT(*) INTO M_COUNT
               FROM DN_TRN_REPO_FRESH_INST
               WHERE
                   DEAL_NO=M_DEAL_NO
                   AND
                   INST_TYPE=M_INST_TYPE
                   AND
                   INV_CODE=DECODE(M_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE,'RP','OR');---VC BY KEITH ON 13-07-2004

              IF M_COUNT=0 THEN

                  INSERT INTO DN_TRN_REPO_FRESH_INST
                      (DEAL_NO,INST_TYPE,INV_CODE,RPTRN_HCUT_PER)
                  VALUES
                      (M_DEAL_NO,M_INST_TYPE,DECODE(M_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE,'RP','OR'),'10');---VC BY KEITH ON 13-07-2004

              END IF;

               SELECT COUNT(*) INTO M_COUNT
               FROM DN_TRN_REPO_FRESH_SEC
               WHERE
                   DEAL_NO=M_DEAL_NO
                   AND
                   SECURITY_CODE=M_SECURITY_CODE
                   AND
                   INV_CODE=DECODE(M_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE,'RP','OR');---VC BY KEITH ON 13-07-2004

              IF M_COUNT=0 THEN

                  INSERT INTO DN_TRN_REPO_FRESH_SEC
                      (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,ENDOSER_CODE,FACE_VALUE,FVAL_WITH_HAIR_CUT,INV_STATUS)
                  VALUES
                      (M_DEAL_NO,M_INST_TYPE,DECODE(M_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE,'RP','OR'),M_SECURITY_CODE,NULL,M_FACE_VALUE,0,'Y');---VC BY KEITH ON 13-07-2004
              ELSE
                   UPDATE DN_TRN_REPO_FRESH_SEC
                   SET FACE_VALUE=FACE_VALUE+M_FACE_VALUE
                   WHERE
                   DEAL_NO=M_DEAL_NO
                   AND
                   SECURITY_CODE=M_SECURITY_CODE
                   AND
                   INV_CODE=DECODE(M_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE,'RP','OR');---VC BY KEITH ON 13-07-2004

              END IF;

                  INSERT INTO DN_TRN_REPO_FRESH_SERIAL_NO
                      (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,FACE_VALUE,
                       INV_STATUS,DATA_FROM,LOCATION,PREV_DEAL_NO)
                  VALUES
                      (M_DEAL_NO,M_INST_TYPE,DECODE(M_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE,'RP','OR'),---VC BY KEITH ON 13-07-2004
                      M_SECURITY_CODE,M_SERIAL_NO,M_FACE_VALUE,
                     'Y1','BOR',M_LOCATION,NULL);


           ELSIF SUBSTR(M_DEAL_NO,1,2)='RR' THEN

               SELECT COUNT(*) INTO M_COUNT
               FROM DN_TRN_REPO_ROLLOVER_INST
               WHERE
                   DEAL_NO=M_DEAL_NO
                   AND
                   INST_TYPE=M_INST_TYPE
                   AND
                   INV_CODE=DECODE(M_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE,'RP','OR');---VC BY KEITH ON 13-07-2004

              IF M_COUNT=0 THEN

                  INSERT INTO DN_TRN_REPO_ROLLOVER_INST
                      (DEAL_NO,INST_TYPE,INV_CODE,RPTRN_HCUT_PER)
                  VALUES
                      (M_DEAL_NO,M_INST_TYPE,DECODE(M_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE,'RP','OR'),'10');---VC BY KEITH ON 13-07-2004

              END IF;

               SELECT COUNT(*) INTO M_COUNT
               FROM DN_TRN_REPO_ROLLOVER_SEC
               WHERE
                   DEAL_NO=M_DEAL_NO
                   AND
                   SECURITY_CODE=M_SECURITY_CODE
                   AND
                   INV_CODE=DECODE(M_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE,'RP','OR');---VC BY KEITH ON 13-07-2004

              IF M_COUNT=0 THEN

                  INSERT INTO DN_TRN_REPO_ROLLOVER_SEC
                      (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,ENDOSER_CODE,FACE_VALUE,FVAL_WITH_HAIR_CUT,INV_STATUS)
                  VALUES
                      (M_DEAL_NO,M_INST_TYPE,DECODE(M_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE,'RP','OR'),---VC BY KEITH ON 13-07-2004
                      M_SECURITY_CODE,NULL,M_FACE_VALUE,0,'Y');
              ELSE
                   UPDATE DN_TRN_REPO_ROLLOVER_SEC
                   SET FACE_VALUE=FACE_VALUE+M_FACE_VALUE
                   WHERE
                   DEAL_NO=M_DEAL_NO
                   AND
                   SECURITY_CODE=M_SECURITY_CODE
                   AND
                   INV_CODE=DECODE(M_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE,'RP','OR');---VC BY KEITH ON 13-07-2004

              END IF;

                  INSERT INTO DN_TRN_REPO_ROLLOVER_SERIAL_NO
                      (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,FACE_VALUE,
                       INV_STATUS,DATA_FROM,LOCATION,PREV_DEAL_NO)
                  VALUES
                      (M_DEAL_NO,M_INST_TYPE,DECODE(M_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE,'RP','OR'),---VC BY KEITH ON 13-07-2004
                      M_SECURITY_CODE,M_SERIAL_NO,M_FACE_VALUE,
                     'Y1','BOR',M_LOCATION,NULL);

           END IF;

   END LOOP;


END DN_BO_INV_EXCH_RP_R;

/
