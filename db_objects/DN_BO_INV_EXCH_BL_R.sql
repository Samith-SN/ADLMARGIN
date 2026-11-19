--------------------------------------------------------
--  DDL for Procedure DN_BO_INV_EXCH_BL_R
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_BO_INV_EXCH_BL_R" 
   (
    M_INV_EXCHG_NO      DN_TRN_BO_INV_EXCHANGE.INV_EXCHG_NO%TYPE,
    M_COUNP_LOCATION    DN_TRN_REPO_FRESH.BORR_PORTFOLIO_CODE%TYPE --ADDED BY SM ON 25/05/2000 TO REMEDY ERRORS IN LOCATION SUBSEQUENT TO AN 'EXCHANGE'
   )

   IS

    -- Procedue     : Update exchange of inventory from the B/L inventory (hence 'BL_R')
    -- System       : Dealnet system
    -- Created by   : TDS / SM
    -- Created on   : 03/11/1999


--PERFORM A CHECK TO REFER TO THE DEAL NUMBER AND DETERMINE WETHER THE THE PORTFOLIO IS
--FUNDS LENDER OR SECURITES BORROWER
--AND WETHER THE SUBSTRING OF THE DEAL NUMBER IS 'BL' OR 'BS'

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
          DN_INV_BL_DEAL_SERIAL_NO A,
          DN_TRN_BO_INV_EXCHANGE B
       WHERE
          B.INV_EXCHG_NO=M_INV_EXCHG_NO
          AND
          B.INV_CODE='BL'
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
          C.INV_CODE='BL'
          AND
          C.TRANS_TYPE='R';


M_PORTFOLIO_CODE                DN_INV_BL_DEAL_SERIAL_NO.PORTFOLIO_CODE%TYPE;
M_INST_TYPE                     DN_INV_BL_DEAL_SERIAL_NO.INST_TYPE%TYPE;
M_SECURITY_CODE                 DN_INV_BL_DEAL_SERIAL_NO.SECURITY_CODE%TYPE;
M_DEAL_NO                       DN_INV_BL_DEAL_SERIAL_NO.DEAL_NO%TYPE;
M_SERIAL_NO                     DN_INV_BL_DEAL_SERIAL_NO.SERIAL_NO%TYPE;
M_LOCATION                      DN_INV_BL_DEAL_SERIAL_NO.LOCATION%TYPE;
M_RET_DUE_DATE                  DN_INV_BL_DEAL_SERIAL_NO.RET_DUE_DATE%TYPE;
M_FACE_VALUE                    DN_INV_BL_DEAL_SERIAL_NO.FACE_VAL%TYPE;
U_DEAL_NO                       DN_INV_BL_DEAL_SERIAL_NO.DEAL_NO%TYPE;
U_SECURITY_CODE                 DN_INV_REPO_DEAL_SERIAL_NO.SECURITY_CODE%TYPE;
U_INV_CODE                      DN_TRN_REPO_FRESH_SEC.INV_CODE%TYPE;
BAL_FACE_VALUE                  DN_INV_BL_DEAL_SERIAL_NO.FACE_VAL%TYPE;
CURS_UP_SEC                     SASIAPLSQLTAB.SEC_SUM;
CURS_UP_INS                     SASIAPLSQLTAB.SEC_SUM;
M_COUNT                         NUMBER;
U_RECEIVER_CODE                 DN_INV_SUS_ISSUE_INST.RECEIVER_CODE%TYPE;
U_SENDER_CODE                   DN_INV_SUS_ISSUE_INST.SENDER_CODE%TYPE;
S_RECEIVER_CODE                 DN_INV_SUS_ISSUE_INST.RECEIVER_CODE%TYPE;
S_SENDER_CODE                   DN_INV_SUS_ISSUE_INST.SENDER_CODE%TYPE;
U_EFF_VALDATE                   DN_INV_SUS_ISSUE_INST.EFF_VALDATE%TYPE;
S_EFF_VALDATE                   DN_INV_SUS_ISSUE_INST.EFF_VALDATE%TYPE;
U_INST_TYPE                     DN_INV_SUS_ISSUE_INST.INST_TYPE%TYPE;
U_FACE_VALUE                    DN_INV_SUS_ISSUE_INST.ACT_FACE_VALUE%TYPE;
U_ACT_FACE_VALUE                DN_INV_SUS_ISSUE_INST.ACT_FACE_VALUE%TYPE;


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


      UPDATE DN_INV_BL_DEAL_SERIAL_NO
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


        DELETE DN_INV_SUS_ISSUE_SERIAL_NO
        WHERE
          DEAL_NO=M_DEAL_NO
          AND
          SECURITY_CODE=M_SECURITY_CODE
          AND
          SERIAL_NO=M_SERIAL_NO;



       OPEN CURS_UP_SEC FOR

           SELECT DEAL_NO,INST_TYPE,SECURITY_CODE,INV_CODE,RECEIVER_CODE,SENDER_CODE,
                  ACT_FACE_VALUE
           FROM DN_INV_SUS_ISSUE_SEC
           WHERE
              DEAL_NO=M_DEAL_NO
              AND
              SECURITY_CODE=M_SECURITY_CODE;

       BAL_FACE_VALUE:=M_FACE_VALUE;

       LOOP

           FETCH  CURS_UP_SEC INTO

           U_DEAL_NO,U_INST_TYPE,U_SECURITY_CODE,U_INV_CODE,U_RECEIVER_CODE,U_SENDER_CODE,
           U_ACT_FACE_VALUE;

          EXIT WHEN CURS_UP_SEC%NOTFOUND OR BAL_FACE_VALUE=0;

          IF U_FACE_VALUE<BAL_FACE_VALUE THEN
             UPDATE DN_INV_SUS_ISSUE_SEC
             SET  ACT_FACE_VALUE=0,
                  INT_SET_FACE_VALUE=0,
                  INT_BALANCE=0,
                  ISSUE_FROM_INT_BAL=0,
                  BAL_TO_BE_ISSUED=0
             WHERE
                DEAL_NO=U_DEAL_NO
                AND
                SECURITY_CODE=U_SECURITY_CODE
                AND
                INV_CODE=U_INV_CODE;

             BAL_FACE_VALUE:=BAL_FACE_VALUE-U_FACE_VALUE;

          ELSE
             UPDATE DN_INV_SUS_ISSUE_SEC
             SET  ACT_FACE_VALUE=ACT_FACE_VALUE-BAL_FACE_VALUE,
                  INT_SET_FACE_VALUE=0,
                  INT_BALANCE=INT_BALANCE-BAL_FACE_VALUE,
                  ISSUE_FROM_INT_BAL=0,
                  BAL_TO_BE_ISSUED=BAL_TO_BE_ISSUED-BAL_FACE_VALUE

             WHERE
                DEAL_NO=U_DEAL_NO
                AND
                SECURITY_CODE=U_SECURITY_CODE
                AND
                INV_CODE=U_INV_CODE;

             BAL_FACE_VALUE:=0;


          END IF;

       END LOOP;


       OPEN CURS_UP_INS FOR

           SELECT DEAL_NO,INST_TYPE,INV_CODE,RECEIVER_CODE,SENDER_CODE,
                  ACT_FACE_VALUE,EFF_VALDATE
           FROM DN_INV_SUS_ISSUE_INST
           WHERE
              DEAL_NO=M_DEAL_NO
              AND
              INST_TYPE=M_INST_TYPE;

       BAL_FACE_VALUE:=M_FACE_VALUE;

       LOOP

           FETCH  CURS_UP_INS INTO

           U_DEAL_NO,U_INST_TYPE,U_INV_CODE,U_RECEIVER_CODE,U_SENDER_CODE,
           U_ACT_FACE_VALUE,U_EFF_VALDATE;

          EXIT WHEN CURS_UP_INS%NOTFOUND OR BAL_FACE_VALUE=0;
          S_RECEIVER_CODE:=U_RECEIVER_CODE;
          S_SENDER_CODE:=U_SENDER_CODE;
          S_EFF_VALDATE:=U_EFF_VALDATE;

          IF U_FACE_VALUE<BAL_FACE_VALUE THEN
             UPDATE DN_INV_SUS_ISSUE_INST
             SET  ACT_FACE_VALUE=0,
                  INT_SET_FACE_VALUE=0,
                  INT_BALANCE=0,
                  ISSUE_FROM_INT_BAL=0,
                  BAL_TO_BE_ISSUED=0
             WHERE
                DEAL_NO=U_DEAL_NO
                AND
                INST_TYPE=U_INST_TYPE
                AND
                INV_CODE=U_INV_CODE;

             BAL_FACE_VALUE:=BAL_FACE_VALUE-U_FACE_VALUE;

          ELSE
             UPDATE DN_INV_SUS_ISSUE_INST
             SET  ACT_FACE_VALUE=ACT_FACE_VALUE-BAL_FACE_VALUE,
                  INT_SET_FACE_VALUE=0,
                  INT_BALANCE=INT_BALANCE-BAL_FACE_VALUE,
                  ISSUE_FROM_INT_BAL=0,
                  BAL_TO_BE_ISSUED=BAL_TO_BE_ISSUED-BAL_FACE_VALUE

             WHERE
                DEAL_NO=U_DEAL_NO
                AND
                INST_TYPE=U_INST_TYPE
                AND
                INV_CODE=U_INV_CODE;

             BAL_FACE_VALUE:=0;


          END IF;

       END LOOP;

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

       SELECT
          M_PORTFOLIO_CODE,
          MAX(A.RET_DUE_DATE)
       INTO
          M_LOCATION,
          M_RET_DUE_DATE
       FROM
          DN_INV_BL_DEAL_SERIAL_NO A
       WHERE
          A.DEAL_NO=M_DEAL_NO;


       INSERT INTO DN_INV_BL_DEAL_SERIAL_NO
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
          RET_DUE_DATE
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
          M_RET_DUE_DATE
       FROM
          DUAL;


           SELECT COUNT(*)
           INTO
               M_COUNT
           FROM DN_INV_SUS_ISSUE_INST
           WHERE
              DEAL_NO=M_DEAL_NO;

           IF M_COUNT>0 THEN

               SELECT COUNT(*) INTO M_COUNT
               FROM DN_INV_SUS_ISSUE_INST
               WHERE
                   DEAL_NO=M_DEAL_NO
                   AND
                   INST_TYPE=M_INST_TYPE
                   AND
                   INV_CODE='BL';

              IF M_COUNT=0 THEN

                  INSERT INTO DN_INV_SUS_ISSUE_INST
                      (DEAL_NO,INST_TYPE,INV_CODE,RECEIVER_CODE,SENDER_CODE,EFF_VALDATE,
                       ACT_FACE_VALUE,INT_SET_FACE_VALUE,INT_BALANCE,ISSUE_FROM_INT_BAL,
                       BAL_TO_BE_ISSUED,ENT_DATE,LAST_MOD_DATE)
                  VALUES
                      (M_DEAL_NO,M_INST_TYPE,'BL',S_RECEIVER_CODE,S_SENDER_CODE,S_EFF_VALDATE,
                       M_FACE_VALUE,0,M_FACE_VALUE,0,
                       M_FACE_VALUE,SYSDATE,SYSDATE);

              ELSE
                  UPDATE DN_INV_SUS_ISSUE_INST
                  SET
                      ACT_FACE_VALUE=ACT_FACE_VALUE+M_FACE_VALUE,
                      INT_BALANCE=INT_BALANCE+M_FACE_VALUE,
                      BAL_TO_BE_ISSUED=BAL_TO_BE_ISSUED+M_FACE_VALUE
                  WHERE
                      DEAL_NO=M_DEAL_NO
                      AND
                      INST_TYPE=M_INST_TYPE
                      AND
                      INV_CODE='BL';

              END IF;

               SELECT COUNT(*) INTO M_COUNT
               FROM DN_INV_SUS_ISSUE_SEC
               WHERE
                   DEAL_NO=M_DEAL_NO
                   AND
                   INST_TYPE=M_INST_TYPE
                   AND
                   SECURITY_CODE=M_SECURITY_CODE
                   AND
                   INV_CODE='BL';

              IF M_COUNT=0 THEN

                  INSERT INTO DN_INV_SUS_ISSUE_SEC
                      (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,RECEIVER_CODE,SENDER_CODE,
                       EFF_VALDATE,ACT_FACE_VALUE,INT_SET_FACE_VALUE,INT_BALANCE,ISSUE_FROM_INT_BAL,
                       BAL_TO_BE_ISSUED,ENT_DATE,LAST_MOD_DATE)
                  VALUES
                      (M_DEAL_NO,M_INST_TYPE,'BL',M_SECURITY_CODE,S_RECEIVER_CODE,S_SENDER_CODE,
                       S_EFF_VALDATE,M_FACE_VALUE,0,M_FACE_VALUE,0,
                       M_FACE_VALUE,SYSDATE,SYSDATE);

              ELSE
                  UPDATE DN_INV_SUS_ISSUE_SEC
                  SET
                      ACT_FACE_VALUE=ACT_FACE_VALUE+M_FACE_VALUE,
                      INT_BALANCE=INT_BALANCE+M_FACE_VALUE,
                      BAL_TO_BE_ISSUED=BAL_TO_BE_ISSUED+M_FACE_VALUE
                  WHERE
                      DEAL_NO=M_DEAL_NO
                      AND
                      SECURITY_CODE=M_SECURITY_CODE
                      AND
                      INST_TYPE=M_INST_TYPE
                      AND
                      INV_CODE='BL';

              END IF;

                   INSERT INTO DN_INV_SUS_ISSUE_SERIAL_NO
                      (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,RECEIVER_CODE,SENDER_CODE,
                       EFF_VALDATE,ACT_FACE_VALUE,INT_SET_FACE_VALUE,INT_BALANCE,ISSUE_FROM_INT_BAL,
                       BAL_TO_BE_ISSUED,ENT_DATE,LAST_MOD_DATE)
                   VALUES
                      (M_DEAL_NO,M_INST_TYPE,'BL',M_SECURITY_CODE,M_SERIAL_NO,S_RECEIVER_CODE,S_SENDER_CODE,
                       S_EFF_VALDATE,M_FACE_VALUE,0,M_FACE_VALUE,0,
                       M_FACE_VALUE,SYSDATE,SYSDATE);

           END IF;

   END LOOP;


END DN_BO_INV_EXCH_BL_R;

/
