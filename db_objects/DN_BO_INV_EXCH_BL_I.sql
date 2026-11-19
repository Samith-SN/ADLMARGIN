--------------------------------------------------------
--  DDL for Procedure DN_BO_INV_EXCH_BL_I
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_BO_INV_EXCH_BL_I" 
   (
    M_INV_EXCHG_NO      DN_TRN_BO_INV_EXCHANGE.INV_EXCHG_NO%TYPE,
    M_COUNP_LOCATION    DN_TRN_REPO_FRESH.BORR_PORTFOLIO_CODE%TYPE --ADDED BY SM ON 25/05/2000 TO REMEDY ERRORS IN LOCATION SUBSEQUENT TO AN 'EXCHANGE'
   )

   IS

    -- Procedue     : Update exchange of inventory allocated for BL transactions (hence 'BL_I')
    -- System       : Dealnet system
    -- Created by   : TDS / SM
    -- Created on   : 04/11/1999


--PERFORM A CHECK TO REFER TO THE DEAL NUMBER AND DETERMINE WETHER THE THE PORTFOLIO IS LENDER
--AND WETHER THE SUBSTRING OF THE DEAL NUMBER IS 'RF' OR 'RR'
--TO BE CHECKED AT THE POINT OF CALLING THE PROCEDURE


--FOR INVENTORY ALLOCATED FROM 'OR' INVENTORY--


--WE SHOULD TACKLE ALL INVENTORY TYPES HERE ??
--BECAUSE RECEIPTS AND ISSUES MAY NOT BE FROM THE SAME INVENTORY

  CURSOR  EXCH_ISSUES IS

      SELECT
          A.PORTFOLIO_CODE,
          A.INST_TYPE,
          A.SECURITY_CODE,
          A.ALLO_DEAL_NO,
          A.SERIAL_NO,
          A.FACE_VALUE,
          A.DEAL_NO,
          A.INV_CODE
       FROM
          DN_TRN_BO_INV_EXCHANGE A
       WHERE
          A.INV_EXCHG_NO=M_INV_EXCHG_NO
          AND
          A.TRANS_TYPE='I';


  CURSOR  EXCH_RECEIPTS IS

      SELECT
          A.PORTFOLIO_CODE,
          A.INST_TYPE,
          A.SECURITY_CODE,
          A.ALLO_DEAL_NO,
          A.SERIAL_NO,
          A.FACE_VALUE,
          A.DEAL_NO,
          A.INV_CODE
       FROM
          DN_TRN_BO_INV_EXCHANGE A
       WHERE
          A.INV_EXCHG_NO=M_INV_EXCHG_NO
          AND
          A.TRANS_TYPE='R';


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
M_ALLO_REPO                     DN_INV_REPO_DEAL_SERIAL_NO.ALLO_REPO%TYPE;
M_ALLO_BL                       DN_INV_REPO_DEAL_SERIAL_NO.ALLO_BL%TYPE;
M_FWD_ALLO_REPO                 DN_INV_REPO_DEAL_SERIAL_NO.FWD_ALLO_REPO%TYPE;
M_FWD_ALLO_BL                   DN_INV_REPO_DEAL_SERIAL_NO.FWD_ALLO_BL%TYPE;
M_ALLO_DEAL_NO                  DN_INV_REPO_DEAL_SERIAL_NO.DEAL_NO%TYPE;
M_INV_CODE                      DN_TRN_BO_INV_EXCHANGE.INV_CODE%TYPE;
M_ALLO_TYPE                     DN_INV_REPO_DEAL_SERNO_ALLO.ALLO_TYPE%TYPE;
M_START_DATE                    DN_INV_REPO_DEAL_SERNO_ALLO.START_DATE%TYPE;
M_END_DATE                      DN_INV_REPO_DEAL_SERNO_ALLO.END_DATE%TYPE;
S_RECEIVER_CODE                 DN_INV_SUS_ISSUE_INST.RECEIVER_CODE%TYPE;
S_SENDER_CODE                   DN_INV_SUS_ISSUE_INST.SENDER_CODE%TYPE;
S_EFF_VALDATE                   DN_INV_SUS_ISSUE_INST.EFF_VALDATE%TYPE;
U_INST_TYPE                     DN_INV_REPO_DEAL_SERIAL_NO.INST_TYPE%TYPE;
U_RECEIVER_CODE                 DN_INV_SUS_ISSUE_INST.RECEIVER_CODE%TYPE;
U_SENDER_CODE                   DN_INV_SUS_ISSUE_INST.SENDER_CODE%TYPE;
U_EFF_VALDATE                   DN_INV_SUS_ISSUE_INST.EFF_VALDATE%TYPE;
CURS_UP_INS                     SASIAPLSQLTAB.SEC_SUM;
U_ACT_FACE_VALUE                DN_INV_SUS_ISSUE_INST.ACT_FACE_VALUE%TYPE;


BEGIN

   OPEN EXCH_ISSUES;

   LOOP

      FETCH  EXCH_ISSUES INTO

          M_PORTFOLIO_CODE,
          M_INST_TYPE,
          M_SECURITY_CODE,
          M_ALLO_DEAL_NO,
          M_SERIAL_NO,
          M_FACE_VALUE,
          M_DEAL_NO,
          M_INV_CODE;


      EXIT WHEN EXCH_ISSUES%NOTFOUND;

      M_ALLO_REPO:=0;
      M_ALLO_BL:=0;
      M_FWD_ALLO_REPO:=0;
      M_FWD_ALLO_BL:=0;


      IF SUBSTR(M_ALLO_DEAL_NO,1,2)='BF' THEN
          M_ALLO_TYPE:='BL';

          SELECT EFF_VALDATE,MATURITY_DATE
          INTO M_START_DATE,M_END_DATE
          FROM DN_TRN_BL_FUND
          WHERE DEAL_NO=M_ALLO_DEAL_NO;

          IF M_START_DATE<=SYSDATE THEN
             M_START_DATE:=SYSDATE;

             M_ALLO_REPO:=M_FACE_VALUE;

          ELSE
             M_FWD_ALLO_REPO:=M_FACE_VALUE;

          END IF;


       ELSIF SUBSTR(M_ALLO_DEAL_NO,1,2)='BS' THEN
          M_ALLO_TYPE:='BL';

          SELECT EFF_VALDATE,MATURITY_DATE
          INTO M_START_DATE,M_END_DATE
          FROM DN_TRN_BL_SECURITY
          WHERE DEAL_NO=M_ALLO_DEAL_NO;

          IF M_START_DATE<=SYSDATE THEN
             M_START_DATE:=SYSDATE;

             M_ALLO_REPO:=M_FACE_VALUE;

          ELSE
             M_FWD_ALLO_REPO:=M_FACE_VALUE;

          END IF;

      END IF;

      IF M_INV_CODE='OR' THEN

           INSERT INTO DN_INV_OUTPS_DEAL_SERNO_ALLO
                  (PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,
                   SERIAL_NO,ALLO_TYPE,START_DATE,END_DATE,ALLO_FACE_VALUE,PREV_DEAL_NO)

           VALUES (M_PORTFOLIO_CODE,SYSDATE,M_INST_TYPE,M_SECURITY_CODE,M_ALLO_DEAL_NO,
                   M_SERIAL_NO,M_ALLO_TYPE,M_START_DATE,M_END_DATE,M_FACE_VALUE,M_DEAL_NO);


           UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
           SET ALLO_REPO=ALLO_REPO+M_ALLO_REPO,
                ALLO_BL=ALLO_BL+M_ALLO_BL,
                FWD_ALLO_REPO=FWD_ALLO_REPO+M_FWD_ALLO_REPO,
                FWD_ALLO_BL=FWD_ALLO_BL+M_FWD_ALLO_BL,
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


      ELSIF M_INV_CODE='RP' THEN

           INSERT INTO DN_INV_REPO_DEAL_SERNO_ALLO
                  (PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,
                   SERIAL_NO,ALLO_TYPE,START_DATE,END_DATE,ALLO_FACE_VALUE,PREV_DEAL_NO)

           VALUES (M_PORTFOLIO_CODE,SYSDATE,M_INST_TYPE,M_SECURITY_CODE,M_ALLO_DEAL_NO,
                   M_SERIAL_NO,M_ALLO_TYPE,M_START_DATE,M_END_DATE,M_FACE_VALUE,M_DEAL_NO);


           UPDATE DN_INV_REPO_DEAL_SERIAL_NO
           SET  ALLO_REPO=ALLO_REPO+M_ALLO_REPO,
                ALLO_BL=ALLO_BL+M_ALLO_BL,
                FWD_ALLO_REPO=FWD_ALLO_REPO+M_FWD_ALLO_REPO,
                FWD_ALLO_BL=FWD_ALLO_BL+M_FWD_ALLO_BL,
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


      ELSIF M_INV_CODE='BL' THEN

           INSERT INTO DN_INV_BL_DEAL_SERNO_ALLO
                  (PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,
                   SERIAL_NO,ALLO_TYPE,START_DATE,END_DATE,ALLO_FACE_VALUE,PREV_DEAL_NO)

           VALUES (M_PORTFOLIO_CODE,SYSDATE,M_INST_TYPE,M_SECURITY_CODE,M_ALLO_DEAL_NO,
                   M_SERIAL_NO,M_ALLO_TYPE,M_START_DATE,M_END_DATE,M_FACE_VALUE,M_DEAL_NO);


           UPDATE DN_INV_BL_DEAL_SERIAL_NO
           SET  ALLO_REPO=ALLO_REPO+M_ALLO_REPO,
                ALLO_BL=ALLO_BL+M_ALLO_BL,
                FWD_ALLO_REPO=FWD_ALLO_REPO+M_FWD_ALLO_REPO,
                FWD_ALLO_BL=FWD_ALLO_BL+M_FWD_ALLO_BL,
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

      END IF;

--UPDATING INVENTORY SUSPENSE TABLES FOR ISSUES

           SELECT COUNT(*)
           INTO
               M_COUNT
           FROM DN_INV_SUS_RECEIPT_INST
           WHERE
              DEAL_NO=M_ALLO_DEAL_NO;

           IF M_COUNT>0 THEN

               SELECT MAX(RECEIVER_CODE),MAX(SENDER_CODE),MAX(EFF_VALDATE)
               INTO
               S_RECEIVER_CODE,
               S_SENDER_CODE,
               S_EFF_VALDATE
               FROM DN_INV_SUS_RECEIPT_INST
               WHERE
                  DEAL_NO=M_ALLO_DEAL_NO;

               SELECT COUNT(*) INTO M_COUNT
                 FROM DN_INV_SUS_RECEIPT_INST
                 WHERE
                 DEAL_NO=M_ALLO_DEAL_NO
                 AND
                 INST_TYPE=M_INST_TYPE
                 AND
                 INV_CODE=M_INV_CODE;

                IF M_COUNT=0 THEN

                    INSERT INTO DN_INV_SUS_RECEIPT_INST
                        (DEAL_NO,INST_TYPE,INV_CODE,RECEIVER_CODE,SENDER_CODE,
                         EFF_VALDATE,ACT_FACE_VALUE,INT_SET_FACE_VALUE,INT_BALANCE,
                         REC_FROM_INT_BAL,BAL_TO_BE_RECEIVED,ENT_DATE,LAST_MOD_DATE)
                    VALUES
                        (M_ALLO_DEAL_NO,M_INST_TYPE,M_INV_CODE,S_RECEIVER_CODE,S_SENDER_CODE,
                         S_EFF_VALDATE,M_FACE_VALUE,0,M_FACE_VALUE,0,
                         M_FACE_VALUE,SYSDATE,SYSDATE);

                ELSE
                    UPDATE DN_INV_SUS_RECEIPT_INST
                    SET
                        ACT_FACE_VALUE=ACT_FACE_VALUE+M_FACE_VALUE,
                        INT_BALANCE=INT_BALANCE+M_FACE_VALUE,
                        BAL_TO_BE_RECEIVED=BAL_TO_BE_RECEIVED+M_FACE_VALUE
                    WHERE
                        DEAL_NO=M_ALLO_DEAL_NO
                        AND
                        INST_TYPE=M_INST_TYPE
                        AND
                        INV_CODE=M_INV_CODE;

                END IF;

                 SELECT COUNT(*) INTO M_COUNT
                 FROM DN_INV_SUS_RECEIPT_SEC
                 WHERE
                 DEAL_NO=M_ALLO_DEAL_NO
                 AND
                 INST_TYPE=M_INST_TYPE
                 AND
                 SECURITY_CODE=M_SECURITY_CODE
                 AND
                 INV_CODE=M_INV_CODE;

                IF M_COUNT=0 THEN

                    INSERT INTO DN_INV_SUS_RECEIPT_SEC
                        (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,RECEIVER_CODE,SENDER_CODE,
                         EFF_VALDATE,ACT_FACE_VALUE,INT_SET_FACE_VALUE,INT_BALANCE,
                         REC_FROM_INT_BAL,BAL_TO_BE_RECEIVED,ENT_DATE,LAST_MOD_DATE)
                    VALUES
                        (M_ALLO_DEAL_NO,M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,S_RECEIVER_CODE,S_SENDER_CODE,
                         S_EFF_VALDATE,M_FACE_VALUE,0,M_FACE_VALUE,0,
                         M_FACE_VALUE,SYSDATE,SYSDATE);

                ELSE
                    UPDATE DN_INV_SUS_RECEIPT_SEC
                    SET
                        ACT_FACE_VALUE=ACT_FACE_VALUE+M_FACE_VALUE,
                        INT_BALANCE=INT_BALANCE+M_FACE_VALUE,
                        BAL_TO_BE_RECEIVED=BAL_TO_BE_RECEIVED+M_FACE_VALUE
                    WHERE
                        DEAL_NO=M_ALLO_DEAL_NO
                        AND
                        SECURITY_CODE=M_SECURITY_CODE
                        AND
                        INST_TYPE=M_INST_TYPE
                        AND
                        INV_CODE=M_INV_CODE;

                END IF;

                     INSERT INTO DN_INV_SUS_RECEIPT_SERIAL_NO
                        (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,
                         RECEIVER_CODE,SENDER_CODE,EFF_VALDATE,ACT_FACE_VALUE,
                         INT_SET_FACE_VALUE,INT_BALANCE,REC_FROM_INT_BAL,BAL_TO_BE_RECEIVED,
                         ENT_DATE,LAST_MOD_DATE)
                     VALUES
                        (M_ALLO_DEAL_NO,M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,M_SERIAL_NO,
                         S_RECEIVER_CODE,S_SENDER_CODE,S_EFF_VALDATE,M_FACE_VALUE,
                         0,M_FACE_VALUE,0,M_FACE_VALUE,
                         SYSDATE,SYSDATE);

              END IF;

   END LOOP;

   CLOSE EXCH_ISSUES;


------RECEIPTS

   OPEN EXCH_RECEIPTS;

   LOOP

      FETCH  EXCH_RECEIPTS INTO

          M_PORTFOLIO_CODE,
          M_INST_TYPE,
          M_SECURITY_CODE,
          M_ALLO_DEAL_NO,
          M_SERIAL_NO,
          M_FACE_VALUE,
          M_DEAL_NO,
          M_INV_CODE;


      EXIT WHEN EXCH_RECEIPTS%NOTFOUND;

      M_ALLO_REPO:=0;
      M_ALLO_BL:=0;
      M_FWD_ALLO_REPO:=0;
      M_FWD_ALLO_BL:=0;


      IF SUBSTR(M_ALLO_DEAL_NO,1,2)='BF' THEN
          M_ALLO_TYPE:='BL';

          SELECT EFF_VALDATE,MATURITY_DATE
          INTO M_START_DATE,M_END_DATE
          FROM DN_TRN_BL_FUND
          WHERE DEAL_NO=M_ALLO_DEAL_NO;

          IF M_END_DATE>=SYSDATE THEN
             M_END_DATE:=SYSDATE;

          END IF;

          IF  M_START_DATE<=SYSDATE THEN
              M_ALLO_REPO:=M_FACE_VALUE;

          ELSE
              M_FWD_ALLO_REPO:=M_FACE_VALUE;

          END IF;


       ELSIF SUBSTR(M_ALLO_DEAL_NO,1,2)='BS' THEN
          M_ALLO_TYPE:='BL';

          SELECT EFF_VALDATE,MATURITY_DATE
          INTO M_START_DATE,M_END_DATE
          FROM DN_TRN_BL_SECURITY
          WHERE DEAL_NO=M_ALLO_DEAL_NO;

          IF M_END_DATE>=SYSDATE THEN
             M_END_DATE:=SYSDATE;

          END IF;

          IF  M_START_DATE<=SYSDATE THEN
              M_ALLO_REPO:=M_FACE_VALUE;

          ELSE
              M_FWD_ALLO_REPO:=M_FACE_VALUE;

          END IF;

      END IF;

      IF M_INV_CODE='OR' THEN

           UPDATE DN_INV_OUTPS_DEAL_SERNO_ALLO
           SET END_DATE=M_END_DATE
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

           UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
           SET ALLO_REPO=ALLO_REPO-M_ALLO_REPO,
                ALLO_BL=ALLO_BL-M_ALLO_BL,
                FWD_ALLO_REPO=FWD_ALLO_REPO-M_FWD_ALLO_REPO,
                FWD_ALLO_BL=FWD_ALLO_BL-M_FWD_ALLO_BL,
                LOCATION=M_PORTFOLIO_CODE
           WHERE
                PORTFOLIO_CODE=M_PORTFOLIO_CODE
                AND
                INST_TYPE=M_INST_TYPE
                AND
                SECURITY_CODE=M_SECURITY_CODE
                --AND
                --DEAL_NO=M_DEAL_NO
                AND
                SERIAL_NO=M_SERIAL_NO;


      ELSIF M_INV_CODE='RP' THEN

           UPDATE DN_INV_REPO_DEAL_SERNO_ALLO
           SET END_DATE=M_END_DATE
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

           UPDATE DN_INV_REPO_DEAL_SERIAL_NO
           SET ALLO_REPO=ALLO_REPO-M_ALLO_REPO,
                ALLO_BL=ALLO_BL-M_ALLO_BL,
                FWD_ALLO_REPO=FWD_ALLO_REPO-M_FWD_ALLO_REPO,
                FWD_ALLO_BL=FWD_ALLO_BL-M_FWD_ALLO_BL,
                LOCATION=M_PORTFOLIO_CODE
           WHERE
                PORTFOLIO_CODE=M_PORTFOLIO_CODE
                AND
                INST_TYPE=M_INST_TYPE
                AND
                SECURITY_CODE=M_SECURITY_CODE
                --AND
                --DEAL_NO=M_DEAL_NO
                AND
                SERIAL_NO=M_SERIAL_NO;


      ELSIF M_INV_CODE='BL' THEN

           UPDATE DN_INV_BL_DEAL_SERNO_ALLO
           SET END_DATE=M_END_DATE
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

           UPDATE DN_INV_BL_DEAL_SERIAL_NO
           SET ALLO_REPO=ALLO_REPO-M_ALLO_REPO,
                ALLO_BL=ALLO_BL-M_ALLO_BL,
                FWD_ALLO_REPO=FWD_ALLO_REPO-M_FWD_ALLO_REPO,
                FWD_ALLO_BL=FWD_ALLO_BL-M_FWD_ALLO_BL,
                LOCATION=M_PORTFOLIO_CODE
           WHERE
                PORTFOLIO_CODE=M_PORTFOLIO_CODE
                AND
                INST_TYPE=M_INST_TYPE
                AND
                SECURITY_CODE=M_SECURITY_CODE
                --AND
                --DEAL_NO=M_DEAL_NO
                AND
                SERIAL_NO=M_SERIAL_NO;

      END IF;



--UPDATING TRANSACTION TABLES FOR 'RECEIPTS'--OUTSTANDING


        DELETE DN_INV_SUS_RECEIPT_SERIAL_NO
        WHERE
          DEAL_NO=M_ALLO_DEAL_NO
          AND
          SECURITY_CODE=M_SECURITY_CODE
          AND
          SERIAL_NO=M_SERIAL_NO;


       OPEN CURS_UP_SEC FOR

           SELECT DEAL_NO,INST_TYPE,SECURITY_CODE,INV_CODE,RECEIVER_CODE,SENDER_CODE,
                  ACT_FACE_VALUE
           FROM DN_INV_SUS_RECEIPT_SEC
           WHERE
              DEAL_NO=M_ALLO_DEAL_NO
              AND
              SECURITY_CODE=M_SECURITY_CODE;

       BAL_FACE_VALUE:=M_FACE_VALUE;

       LOOP

           FETCH  CURS_UP_SEC INTO

           U_DEAL_NO,U_INST_TYPE,U_SECURITY_CODE,U_INV_CODE,U_RECEIVER_CODE,U_SENDER_CODE,
           U_ACT_FACE_VALUE;

          EXIT WHEN CURS_UP_SEC%NOTFOUND OR BAL_FACE_VALUE=0;

          IF U_FACE_VALUE<BAL_FACE_VALUE THEN
             UPDATE DN_INV_SUS_RECEIPT_SEC
             SET  ACT_FACE_VALUE=0,
                  INT_SET_FACE_VALUE=0,
                  INT_BALANCE=0,
                  REC_FROM_INT_BAL=0,
                  BAL_TO_BE_RECEIVED=0
             WHERE
                DEAL_NO=U_DEAL_NO
                AND
                SECURITY_CODE=U_SECURITY_CODE
                AND
                INV_CODE=U_INV_CODE;

             BAL_FACE_VALUE:=BAL_FACE_VALUE-U_FACE_VALUE;

          ELSE
             UPDATE DN_INV_SUS_RECEIPT_SEC
             SET  ACT_FACE_VALUE=ACT_FACE_VALUE-BAL_FACE_VALUE,
                  INT_SET_FACE_VALUE=0,
                  INT_BALANCE=INT_BALANCE-BAL_FACE_VALUE,
                  REC_FROM_INT_BAL=0,
                  BAL_TO_BE_RECEIVED=BAL_TO_BE_RECEIVED-BAL_FACE_VALUE

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
           FROM DN_INV_SUS_RECEIPT_INST
           WHERE
              DEAL_NO=M_ALLO_DEAL_NO
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
             UPDATE DN_INV_SUS_RECEIPT_INST
             SET  ACT_FACE_VALUE=0,
                  INT_SET_FACE_VALUE=0,
                  INT_BALANCE=0,
                  REC_FROM_INT_BAL=0,
                  BAL_TO_BE_RECEIVED=0
             WHERE
                DEAL_NO=U_DEAL_NO
                AND
                INST_TYPE=U_INST_TYPE
                AND
                INV_CODE=U_INV_CODE;

             BAL_FACE_VALUE:=BAL_FACE_VALUE-U_FACE_VALUE;

          ELSE
             UPDATE DN_INV_SUS_RECEIPT_INST
             SET  ACT_FACE_VALUE=ACT_FACE_VALUE-BAL_FACE_VALUE,
                  INT_SET_FACE_VALUE=0,
                  INT_BALANCE=INT_BALANCE-BAL_FACE_VALUE,
                  REC_FROM_INT_BAL=0,
                  BAL_TO_BE_RECEIVED=BAL_TO_BE_RECEIVED-BAL_FACE_VALUE

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


END DN_BO_INV_EXCH_BL_I;

/
