--------------------------------------------------------
--  DDL for Procedure DN_PERIODIC_INTEREST_UP2
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_PERIODIC_INTEREST_UP2" (
    M_DEAL_NO  IN OUT    DN_TRN_REPO_PERIOD_INT_SEC.DEAL_NO%TYPE,
    M_SECURITY           DN_TRN_REPO_PERIOD_INT_SEC.SECURITY_CODE%TYPE,
    M_ENDORSER           DN_TRN_REPO_PERIOD_INT_SEC.ENDOSER_CODE%TYPE,
    M_FACE_VALUE         DN_TRN_REPO_PERIOD_INT_SEC.FACE_VALUE%TYPE,
    M_HAIR_CUT           DN_TRN_REPO_PERIOD_INT_SEC.FVAL_WITH_HAIR_CUT%TYPE,
    M_SERIAL_NO          DN_TRN_REPO_PERIOD_INT_SERIAL.SERIAL_NO%TYPE,
    M_INV_CODE1          DN_TRN_REPO_PERIOD_INT_INST.INV_CODE%TYPE,
    M_PREV_DEAL_NO       DN_TRN_REPO_PERIOD_INT_SERIAL.PREV_DEAL_NO%TYPE,
    M_MODE_NO            DN_TRN_REPO_PERIOD_INT.NO_OF_SETTL_MODES%TYPE,
    M_MODE               DN_TRN_REPO_PERIOD_INT_SETTLE.SETTLE_MODE%TYPE,
    M_AMOUNT             DN_TRN_REPO_PERIOD_INT_SETTLE.SETTLE_AMOUNT%TYPE,
    M_BORROWER_MODE      DN_TRN_REPO_PERIOD_INT_SETTLE.BORR_PORTFOLIO_CODE%TYPE,
    M_LENDER_MODE        DN_TRN_REPO_PERIOD_INT_SETTLE.LEND_PORTFOLIO_CODE%TYPE,
    M_COMMENT1           DN_TRN_REPO_PERIOD_INT_SETTLE.BORR_SETTLE_COMMENT%TYPE,
    M_COMMENT2           DN_TRN_REPO_PERIOD_INT_SETTLE.LEND_SETTLE_COMMENT%TYPE,
    M_BROKER_BORRO       DN_TRN_BROKERAGE.BROK_CODE%TYPE,
    M_BROKER_LENDER      DN_TRN_BROKERAGE.BROK_CODE%TYPE,
    M_BROKERAGE_BORRO    DN_TRN_BROKERAGE.BROK_PER%TYPE,
    M_BROKERAGE_LEND     DN_TRN_BROKERAGE.BROK_PER%TYPE,
    M_BASE_BORRO         DN_TRN_BROKERAGE.BROK_BASE%TYPE,
    M_BASE_LEND          DN_TRN_BROKERAGE.BROK_BASE%TYPE,
    M_FEE_BORRO          DN_TRN_BROKERAGE.BROK_FEE_TYPE%TYPE,
    M_FEE_LEND           DN_TRN_BROKERAGE.BROK_FEE_TYPE%TYPE,
    M_AMOUNT_BORRO       DN_TRN_BROKERAGE.BROK_FEE_AMOUNT%TYPE,
    M_AMOUNT_LEND        DN_TRN_BROKERAGE.BROK_FEE_AMOUNT%TYPE,
    M_AMT1               DN_TRN_BROKERAGE.BROK_GST%TYPE,
    M_AMT2               DN_TRN_BROKERAGE.BROK_GST%TYPE,
    M_TOTAMOUNT1         DN_TRN_BROKERAGE.BROK_TOT_AMT_DUE%TYPE,
    M_TOTAMOUNT2         DN_TRN_BROKERAGE.BROK_TOT_AMT_DUE%TYPE,
    M_SELECT_TYPE        CHAR
    )
AS

   M_BCOUNT                NUMBER;
   M_LCOUNT                NUMBER;
   M_BORR_PORTFOLIO_CODE   DN_REF_PORTF_SETTLEMENT.PORTFOLIO_CODE%TYPE;
   M_LEND_PORTFOLIO_CODE   DN_REF_PORTF_SETTLEMENT.PORTFOLIO_CODE%TYPE;
   M_BORR_BRANCH_CODE      DN_REF_PORTF_SETTLEMENT.BRANCH_CODE%TYPE;
   M_LEND_BRANCH_CODE      DN_REF_PORTF_SETTLEMENT.BRANCH_CODE%TYPE;
   M_INST_TYPE             DN_TRN_REPO_PERIOD_INT_SEC.INST_TYPE%TYPE;
   M_HCUT_PER              DN_TRN_REPO_PERIOD_INT_INST.RPTRN_HCUT_PER%TYPE;
   M_INV_CODE              DN_TRN_REPO_PERIOD_INT_INST.INV_CODE%TYPE;

BEGIN

    --RAISE_APPLICATION_ERROR(-20201,M_SELECT_TYPE||' '||M_DEAL_NO||' '||M_SECURITY||' '||M_MODE);

    -- PROCEDURE  -  TO INSERT REPO PERIOD INTEREST DETAILS
    -- SYSTEM     -  MBFSL SYSTEM
    -- CREATED BY -  V.THILAKESAN.
    -- CREATED ON -  14/04/2000

    IF M_DEAL_NO IS NOT NULL THEN
       IF M_MODE_NO>0 THEN
          UPDATE DN_TRN_REPO_PERIOD_INT
          SET NO_OF_SETTL_MODES=M_MODE_NO
          WHERE DEAL_NO=M_DEAL_NO;
       END IF;
       --Inventory code check
       M_INV_CODE:=NULL;
       IF M_INV_CODE1<>'NULL' THEN
          IF M_INV_CODE1 IS NOT NULL THEN
             IF M_INV_CODE1='O/R' THEN
                M_INV_CODE:='OR';
             ELSIF M_INV_CODE1='B/L' THEN
                M_INV_CODE:='BL';
             ELSIF M_INV_CODE1='R/P' THEN
                M_INV_CODE:='RP';
             ELSE
                M_INV_CODE:=M_INV_CODE1;
             END IF;
          END IF;
       END IF;

       --Select BORR_PORTFOLIO_CODE details from DN_REF_PORTF_SETTLEMENT
       M_BCOUNT:=0;
       SELECT COUNT(*) INTO M_BCOUNT
       FROM  DN_TRN_REPO_PERIOD_INT A
       WHERE A.DEAL_NO=M_DEAL_NO;
       IF M_BCOUNT>0 THEN
          SELECT A.BORR_PORTFOLIO_CODE,A.LEND_PORTFOLIO_CODE INTO M_BORR_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE
          FROM  DN_TRN_REPO_PERIOD_INT A
          WHERE A.DEAL_NO=M_DEAL_NO;
       END IF;
       --Select BORR_BRANCH_CODE details from DN_REF_PORTF_SETTLEMENT
       M_BCOUNT:=0;
       SELECT COUNT(*) INTO M_BCOUNT
       FROM  DN_TRN_REPO_PERIOD_INT A,DN_REF_PORTF_SETTLEMENT B
       WHERE A.DEAL_NO=M_DEAL_NO AND A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_BORROWER_MODE;
       IF M_BCOUNT>0 THEN
          SELECT B.BRANCH_CODE INTO M_BORR_BRANCH_CODE
          FROM  DN_TRN_REPO_PERIOD_INT A,DN_REF_PORTF_SETTLEMENT B
          WHERE A.DEAL_NO=M_DEAL_NO AND A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_BORROWER_MODE;
       END IF;
       --Select LEND_BRANCH_CODE details from DN_REF_PORTF_SETTLEMENT
       M_LCOUNT:=0;
       SELECT COUNT(*) INTO M_LCOUNT
       FROM  DN_TRN_REPO_PERIOD_INT A,DN_REF_PORTF_SETTLEMENT B
       WHERE A.DEAL_NO=M_DEAL_NO AND A.LEND_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_LENDER_MODE;
       IF M_LCOUNT>0 THEN
          SELECT B.BRANCH_CODE INTO M_LEND_BRANCH_CODE
          FROM  DN_TRN_REPO_PERIOD_INT A,DN_REF_PORTF_SETTLEMENT B
          WHERE A.DEAL_NO=M_DEAL_NO AND A.LEND_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_LENDER_MODE;
       END IF;

       IF  M_SELECT_TYPE='SUB1' AND M_INV_CODE<>'NULL' THEN
           IF M_INV_CODE IS NOT NULL AND M_SECURITY IS NOT NULL THEN

              SELECT INST_TYPE INTO M_INST_TYPE
              FROM DN_REF_SECURITY
              WHERE SECURITY_CODE =M_SECURITY;

              SELECT DISTINCT RPTRN_HCUT_PER INTO M_HCUT_PER
              FROM DN_TRN_REPO_PERIOD_INT_INST
              WHERE DEAL_NO = M_DEAL_NO;

              UPDATE DN_TRN_REPO_PERIOD_INT_INST
              SET RPTRN_HCUT_PER=M_HCUT_PER
              WHERE
                  DEAL_NO=M_DEAL_NO
                  AND
                  INST_TYPE=M_INST_TYPE
                  AND
                  INV_CODE=M_INV_CODE;

     --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||' '||M_INST_TYPE||' '||M_INV_CODE||' '||M_HCUT_PER);

              IF SQL%NOTFOUND THEN
                 INSERT INTO DN_TRN_REPO_PERIOD_INT_INST
                    (DEAL_NO,
                     INST_TYPE,
                     INV_CODE,
                     RPTRN_HCUT_PER)
                 VALUES(M_DEAL_NO,
                     M_INST_TYPE,
                     M_INV_CODE,
                     M_HCUT_PER);
              END IF;
           END IF;
       END IF;
       --IF  M_SELECT_TYPE='SUB1' AND M_SECURITY<>'NULL' AND M_ENDORSER<>'NULL' THEN
       IF  M_SELECT_TYPE='SUB1' AND M_SECURITY<>'NULL' THEN
           IF M_SECURITY IS NOT NULL AND M_INV_CODE IS NOT NULL THEN

              SELECT INST_TYPE INTO M_INST_TYPE
              FROM DN_REF_SECURITY
              WHERE SECURITY_CODE =M_SECURITY;

        -- RAISE_APPLICATION_ERROR(-20201,'-'||M_ENDORSER);

          UPDATE DN_TRN_REPO_PERIOD_INT_SEC
              SET ENDOSER_CODE      =M_ENDORSER,
                  FACE_VALUE        =M_FACE_VALUE,
                  FVAL_WITH_HAIR_CUT=M_HAIR_CUT
              WHERE
                 DEAL_NO       =M_DEAL_NO
                 AND
                 INST_TYPE     =M_INST_TYPE
                 AND
                 INV_CODE      =M_INV_CODE
                 AND
                 SECURITY_CODE =M_SECURITY;
              IF SQL%NOTFOUND THEN
                 INSERT INTO DN_TRN_REPO_PERIOD_INT_SEC
                 (DEAL_NO,
                  INST_TYPE,
                  INV_CODE,
                  SECURITY_CODE,
                  ENDOSER_CODE,
  	              FACE_VALUE,
                  FVAL_WITH_HAIR_CUT
                 )
                 VALUES(
                      M_DEAL_NO,
                      M_INST_TYPE,
                      M_INV_CODE,
                      M_SECURITY,
                      M_ENDORSER,
  	                  M_FACE_VALUE,
                      M_HAIR_CUT
                 );
             END IF;
           END IF;
       END IF;
       IF  M_SELECT_TYPE='SUB1' AND M_SECURITY<>'NULL' THEN
           IF M_SERIAL_NO IS NOT NULL AND M_INV_CODE IS NOT NULL THEN

              SELECT INST_TYPE INTO M_INST_TYPE
              FROM DN_REF_SECURITY
              WHERE SECURITY_CODE =M_SECURITY;

              UPDATE DN_TRN_REPO_PERIOD_INT_INST
              SET RPTRN_HCUT_PER=M_HCUT_PER
              WHERE
                  DEAL_NO=M_DEAL_NO
                  AND
                  INST_TYPE=M_INST_TYPE
                  AND
                  INV_CODE=M_INV_CODE;

              IF SQL%NOTFOUND THEN
                 INSERT INTO DN_TRN_REPO_PERIOD_INT_INST
                    (DEAL_NO,
                     INST_TYPE,
                     INV_CODE,
                     RPTRN_HCUT_PER)
                 VALUES(M_DEAL_NO,
                     M_INST_TYPE,
                     M_INV_CODE,
                     M_HCUT_PER);
              END IF;

              UPDATE DN_TRN_REPO_PERIOD_INT_SEC
              SET ENDOSER_CODE      =M_ENDORSER,
                  FACE_VALUE        =M_FACE_VALUE
              WHERE
                 DEAL_NO       =M_DEAL_NO
                 AND
                 INST_TYPE     =M_INST_TYPE
                 AND
                 INV_CODE      =M_INV_CODE
                 AND
                 SECURITY_CODE =M_SECURITY;
              IF SQL%NOTFOUND THEN
                 INSERT INTO DN_TRN_REPO_PERIOD_INT_SEC
                 (DEAL_NO,
                  INST_TYPE,
                  INV_CODE,
                  SECURITY_CODE,
                  ENDOSER_CODE,
  	              FACE_VALUE,
                  FVAL_WITH_HAIR_CUT
                 )
                 VALUES(
                      M_DEAL_NO,
                      M_INST_TYPE,
                      M_INV_CODE,
                      M_SECURITY,
                      M_ENDORSER,
  	                  M_FACE_VALUE,
                      M_HAIR_CUT
                 );
              END IF;

              UPDATE DN_TRN_REPO_PERIOD_INT_SERIAL
              SET FACE_VALUE=M_FACE_VALUE,
                  LOCATION=M_BORR_PORTFOLIO_CODE,
                  PREV_DEAL_NO=M_PREV_DEAL_NO
              WHERE
                  DEAL_NO=M_DEAL_NO
                  AND
                  INST_TYPE=M_INST_TYPE
                  AND
                  SECURITY_CODE=M_SECURITY
                  AND
                  SERIAL_NO=M_SERIAL_NO;

              IF SQL%NOTFOUND THEN
                 INSERT INTO DN_TRN_REPO_PERIOD_INT_SERIAL
                    (DEAL_NO,
                     INST_TYPE,
                     INV_CODE,
                     SECURITY_CODE,
                     SERIAL_NO,
                     FACE_VALUE,
                     LOCATION,
                     PREV_DEAL_NO)
                 VALUES(M_DEAL_NO,
                     M_INST_TYPE,
                     M_INV_CODE,
                     M_SECURITY,
                     M_SERIAL_NO,
                     M_FACE_VALUE,
                     M_BORR_PORTFOLIO_CODE,
                     M_PREV_DEAL_NO);
              END IF;
           END IF;
       END IF;
       IF M_SELECT_TYPE='SUB2' AND M_MODE<>'NULL' THEN
          IF M_MODE IS NOT NULL THEN
             UPDATE DN_TRN_REPO_PERIOD_INT_SETTLE
              SET SETTLE_AMOUNT       =M_AMOUNT,
                  BORR_PORTFOLIO_CODE =M_BORR_PORTFOLIO_CODE,
                  BORR_BRANCH_CODE    =M_BORR_BRANCH_CODE,
                  BORR_ACC_NO         =M_BORROWER_MODE,
                  BORR_SETTLE_COMMENT =M_COMMENT1,
                  LEND_PORTFOLIO_CODE =M_LEND_PORTFOLIO_CODE,
                  LEND_BRANCH_CODE    =M_LEND_BRANCH_CODE,
                  LEND_ACC_NO         =M_LENDER_MODE,
                  LEND_SETTLE_COMMENT =M_COMMENT2
              WHERE
                  DEAL_NO    =M_DEAL_NO
                  AND
                  SETTLE_MODE=M_MODE;

              IF SQL%NOTFOUND THEN
                 INSERT INTO DN_TRN_REPO_PERIOD_INT_SETTLE
                 (DEAL_NO,
  	              SETTLE_MODE,
                  SETTLE_AMOUNT,
                  BORR_PORTFOLIO_CODE,
                  BORR_BRANCH_CODE,
                  BORR_ACC_NO,
                  BORR_SETTLE_COMMENT,
                  LEND_PORTFOLIO_CODE,
                  LEND_BRANCH_CODE,
                  LEND_ACC_NO,
                  LEND_SETTLE_COMMENT
                 )
                 VALUES(M_DEAL_NO,
                        M_MODE,
                        M_AMOUNT,
                        M_BORR_PORTFOLIO_CODE,
                        M_BORR_BRANCH_CODE,
                        M_BORROWER_MODE,
                        M_COMMENT1,
                        M_LEND_PORTFOLIO_CODE,
                        M_LEND_BRANCH_CODE,
                        M_LENDER_MODE,
                        M_COMMENT2
                 );
              END IF;
           END IF;
       END IF;
       IF M_BROKER_BORRO IS NOT NULL THEN
          UPDATE DN_TRN_BROKERAGE
          SET BROK_CODE       =M_BROKER_BORRO,
              BROK_PER        =M_BROKERAGE_BORRO,
              BROK_BASE       =M_BASE_BORRO,
              BROK_FEE_TYPE   =M_FEE_BORRO,
              BROK_FEE_AMOUNT =M_AMOUNT_BORRO,
              BROK_GST        =M_AMT1,
              BROK_TOT_AMT_DUE=M_TOTAMOUNT1
          WHERE
              DEAL_NO     =M_DEAL_NO
              AND
              CP_CODE=M_BORR_PORTFOLIO_CODE;
              IF SQL%NOTFOUND THEN
                 INSERT INTO DN_TRN_BROKERAGE
                 (DEAL_NO,
  	              CP_CODE,
                  BROK_CODE,
                  BROK_PER,
                  BROK_BASE,
                  BROK_FEE_TYPE,
                  BROK_FEE_AMOUNT,
                  BROK_GST,
                  BROK_TOT_AMT_DUE
                 )
                 VALUES(M_DEAL_NO,
                        M_BORR_PORTFOLIO_CODE,
                        M_BROKER_BORRO,
                        M_BROKERAGE_BORRO,
                        M_BASE_BORRO,
                        M_FEE_BORRO,
                        M_AMOUNT_BORRO,
                        M_AMT1,
                        M_TOTAMOUNT1
                 );
             END IF;
         END IF;
         IF M_BROKER_LENDER IS NOT NULL THEN

             UPDATE DN_TRN_BROKERAGE
             SET BROK_CODE     =M_BROKER_LENDER,
               BROK_PER        =M_BROKERAGE_LEND,
               BROK_BASE       =M_BASE_LEND,
               BROK_FEE_TYPE   =M_FEE_LEND,
               BROK_FEE_AMOUNT =M_AMOUNT_LEND,
               BROK_GST        =M_AMT2,
               BROK_TOT_AMT_DUE=M_TOTAMOUNT2
           WHERE
              DEAL_NO     =M_DEAL_NO
              AND
              CP_CODE=M_LEND_PORTFOLIO_CODE;

           IF SQL%NOTFOUND THEN
              INSERT INTO DN_TRN_BROKERAGE
              (DEAL_NO,
  	           CP_CODE,
               BROK_CODE,
               BROK_PER,
               BROK_BASE,
               BROK_FEE_TYPE,
               BROK_FEE_AMOUNT,
               BROK_GST,
               BROK_TOT_AMT_DUE
             )
              VALUES(M_DEAL_NO,
                     M_LEND_PORTFOLIO_CODE,
                     M_BROKER_LENDER,
                     M_BROKERAGE_LEND,
                     M_BASE_LEND,
                     M_FEE_LEND,
                     M_AMOUNT_LEND,
                     M_AMT2,
                     M_TOTAMOUNT2
              );
           END IF;
       END IF;
       COMMIT;
   END IF;
   --If the data type is incorrect then delete the records from the relavent tables
/*
 EXCEPTION
  WHEN OTHERS THEN

    ROLLBACK;

    RAISE_APPLICATION_ERROR(-20201,'Cannot update records, because of incorrect data type.');
*/

END DN_PERIODIC_INTEREST_UP2;

/
