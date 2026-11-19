--------------------------------------------------------
--  DDL for Procedure MBFSL_REPOFRESH_IN2
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_REPOFRESH_IN2" (
    M_DEAL_NO  IN OUT    DN_TRN_REPO_FRESH_SEC.DEAL_NO%TYPE,
    M_SECURITY           DN_TRN_REPO_FRESH_SEC.SECURITY_CODE%TYPE,
    M_ENDORSER           DN_TRN_REPO_FRESH_SEC.ENDOSER_CODE%TYPE,
    M_FACE_VALUE         DN_TRN_REPO_FRESH_SEC.FACE_VALUE%TYPE,
    M_HAIR_CUT           DN_TRN_REPO_FRESH_SEC.FVAL_WITH_HAIR_CUT%TYPE,
    M_SERIAL_NO          DN_TRN_REPO_FRESH_SERIAL_NO.SERIAL_NO%TYPE,
    M_INV_CODE1          DN_TRN_REPO_FRESH_INST.INV_CODE%TYPE,
    M_PREV_DEAL_NO       DN_TRN_REPO_FRESH_SERIAL_NO.PREV_DEAL_NO%TYPE,
    M_MODE_NO            DN_TRN_REPO_FRESH.NO_OF_SETTL_MODES%TYPE,
    M_MODE               DN_TRN_REPO_FRESH_SETTLE.SETTLE_MODE%TYPE,
    M_AMOUNT             DN_TRN_REPO_FRESH_SETTLE.SETTLE_AMOUNT%TYPE,
    M_BORROWER_MODE      DN_TRN_REPO_FRESH_SETTLE.BORR_PORTFOLIO_CODE%TYPE,
    M_LENDER_MODE        DN_TRN_REPO_FRESH_SETTLE.LEND_PORTFOLIO_CODE%TYPE,
    M_COMMENT1           DN_TRN_REPO_FRESH_SETTLE.BORR_SETTLE_COMMENT%TYPE,
    M_COMMENT2           DN_TRN_REPO_FRESH_SETTLE.LEND_SETTLE_COMMENT%TYPE,
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
    M_SELECT_TYPE        CHAR,
    M_USERNAME           DN_TRN_REPO_FRESH.DN_USER%TYPE,
    ---------
    M_PA_SERNO           DN_TRN_OUTP_SALE_SEC.SERIAL_NO%TYPE,--$$##SC
    M_PA_INVAMT          DN_TRN_BROKERAGE.BROK_TOT_AMT_DUE%TYPE,--$$##SC
    MM_TOTAMT            DN_TRN_BROKERAGE.BROK_TOT_AMT_DUE%TYPE,--$$##SC
    MM_SCRIP_STAT        VARCHAR--$$##SC
    )
AS

   M_BCOUNT                NUMBER;
   M_LCOUNT                NUMBER;
   M_BORR_PORTFOLIO_CODE   DN_REF_PORTF_SETTLEMENT.PORTFOLIO_CODE%TYPE;
   M_LEND_PORTFOLIO_CODE   DN_REF_PORTF_SETTLEMENT.PORTFOLIO_CODE%TYPE;
   M_BORR_BRANCH_CODE      DN_REF_PORTF_SETTLEMENT.BRANCH_CODE%TYPE;
   M_LEND_BRANCH_CODE      DN_REF_PORTF_SETTLEMENT.BRANCH_CODE%TYPE;
   M_INST_TYPE             DN_TRN_REPO_FRESH_SEC.INST_TYPE%TYPE;
   M_HCUT_PER              DN_TRN_REPO_FRESH_INST.RPTRN_HCUT_PER%TYPE;
   M_INV_CODE              DN_TRN_REPO_FRESH_INST.INV_CODE%TYPE;

   MM_CURRENCY_VALUE       DN_REF_EXCHANGE_RATES.CURRENCY_VALUE%TYPE;--CURRENCY
   M_COUNT_ALL             NUMBER;--CURRENCY
   M_CURR_CODE             DN_TRN_REPO_FRESH.CURR_CODE%TYPE;--CURRENCY
err_num   varchar2(200);
err_msg   varchar2(200);
  M_COUNT3                 NUMBER;--$$##SC

BEGIN

    --RAISE_APPLICATION_ERROR(-20201,M_SELECT_TYPE||' '||M_DEAL_NO||' '||M_SECURITY||' '||M_MODE);

    -- PROCEDURE  -  TO INSERT REPOS FRESH DETAILS
    -- SYSTEM     -  MBFSL SYSTEM
    -- CREATED BY -  V.THILAKESAN.
    -- CREATED ON -  28/06/1999

-----------CURRENCY-----------------------------
SELECT COUNT(*)
INTO   M_COUNT_ALL
FROM   DN_TRN_REPO_FRESH
WHERE  DEAL_NO=M_DEAL_NO;

IF(M_COUNT_ALL>0)THEN
SELECT CURR_CODE
INTO   M_CURR_CODE
FROM   DN_TRN_REPO_FRESH
WHERE  DEAL_NO=M_DEAL_NO;
END IF;
   ---------------CURRENCY----------------------
                  SELECT  CURRENCY_VALUE
                  INTO    MM_CURRENCY_VALUE
                  FROM    DN_REF_EXCHANGE_RATES
                  WHERE   CURR_CODE=M_CURR_CODE;
  ---------------CURRENCY----------------------





    IF M_DEAL_NO IS NOT NULL THEN
       IF M_MODE_NO>0 THEN
          UPDATE DN_TRN_REPO_FRESH
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
       FROM  DN_TRN_REPO_FRESH A
       WHERE A.DEAL_NO=M_DEAL_NO;
       IF M_BCOUNT>0 THEN
          SELECT A.BORR_PORTFOLIO_CODE,A.LEND_PORTFOLIO_CODE INTO M_BORR_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE
          FROM  DN_TRN_REPO_FRESH A
          WHERE A.DEAL_NO=M_DEAL_NO;
       END IF;
       --Select BORR_BRANCH_CODE details from DN_REF_PORTF_SETTLEMENT
       M_BCOUNT:=0;
       SELECT COUNT(*) INTO M_BCOUNT
       FROM  DN_TRN_REPO_FRESH A,DN_REF_PORTF_SETTLEMENT B
       WHERE A.DEAL_NO=M_DEAL_NO AND A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_BORROWER_MODE;
       IF M_BCOUNT>0 THEN
          SELECT B.BRANCH_CODE INTO M_BORR_BRANCH_CODE
          FROM  DN_TRN_REPO_FRESH A,DN_REF_PORTF_SETTLEMENT B
          WHERE A.DEAL_NO=M_DEAL_NO AND A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_BORROWER_MODE;
       END IF;
       --Select LEND_BRANCH_CODE details from DN_REF_PORTF_SETTLEMENT
       M_LCOUNT:=0;
       SELECT COUNT(*) INTO M_LCOUNT
       FROM  DN_TRN_REPO_FRESH A,DN_REF_PORTF_SETTLEMENT B
       WHERE A.DEAL_NO=M_DEAL_NO AND A.LEND_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_LENDER_MODE;
       IF M_LCOUNT>0 THEN
          SELECT B.BRANCH_CODE INTO M_LEND_BRANCH_CODE
          FROM  DN_TRN_REPO_FRESH A,DN_REF_PORTF_SETTLEMENT B
          WHERE A.DEAL_NO=M_DEAL_NO AND A.LEND_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_LENDER_MODE;
       END IF;

       IF  M_SELECT_TYPE='SUB1' AND M_INV_CODE<>'NULL' THEN
           IF M_INV_CODE IS NOT NULL AND M_SECURITY IS NOT NULL THEN

              SELECT INST_TYPE INTO M_INST_TYPE
              FROM DN_REF_SECURITY
              WHERE SECURITY_CODE =M_SECURITY;

              SELECT DISTINCT RPTRN_HCUT_PER INTO M_HCUT_PER
              FROM DN_TRN_REPO_FRESH_INST
              WHERE DEAL_NO = M_DEAL_NO;

              UPDATE DN_TRN_REPO_FRESH_INST
              SET RPTRN_HCUT_PER=M_HCUT_PER
              WHERE
                  DEAL_NO=M_DEAL_NO
                  AND
                  INST_TYPE=M_INST_TYPE
                  AND
                  INV_CODE=M_INV_CODE;

     --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||' '||M_INST_TYPE||' '||M_INV_CODE||' '||M_HCUT_PER);

              IF SQL%NOTFOUND THEN
                 INSERT INTO DN_TRN_REPO_FRESH_INST
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

--RAISE_APPLICATION_ERROR(-20201,'************');

IF(M_CURR_CODE<>'SLR')THEN--CURRENCY
             UPDATE DN_TRN_REPO_FRESH_SEC
              SET ENDOSER_CODE      =M_ENDORSER,
                  FACE_VALUE        =M_FACE_VALUE*MM_CURRENCY_VALUE,--CURRENCY
                  FVAL_WITH_HAIR_CUT=M_HAIR_CUT*MM_CURRENCY_VALUE,--CURRENCY
                  FACE_VALUE_CURR = M_FACE_VALUE--CURRENCY
              WHERE
                 DEAL_NO       =M_DEAL_NO
                 AND
                 INST_TYPE     =M_INST_TYPE
                 AND
                 INV_CODE      =M_INV_CODE
                 AND
                 SECURITY_CODE =M_SECURITY;
--RAISE_APPLICATION_ERROR(-20201,'666666666666666');


              IF SQL%NOTFOUND THEN

                 INSERT INTO DN_TRN_REPO_FRESH_SEC
                 (DEAL_NO,
                  INST_TYPE,
                  INV_CODE,
                  SECURITY_CODE,
                  ENDOSER_CODE,
  	              FACE_VALUE,
                  FVAL_WITH_HAIR_CUT,
                  FACE_VALUE_CURR--CURRENCY
                 )
                 VALUES(
                      M_DEAL_NO,
                      M_INST_TYPE,
                      M_INV_CODE,
                      M_SECURITY,
                      M_ENDORSER,
  	                  M_FACE_VALUE*MM_CURRENCY_VALUE,--CURRENCY
                      M_HAIR_CUT*MM_CURRENCY_VALUE,--CURRENCY
                      M_FACE_VALUE
                 );
                 END IF;
ELSE--CURRENCY
              UPDATE DN_TRN_REPO_FRESH_SEC
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
--RAISE_APPLICATION_ERROR(-20201,'666666666666666');


              IF SQL%NOTFOUND THEN

                 INSERT INTO DN_TRN_REPO_FRESH_SEC
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
--RAISE_APPLICATION_ERROR(-20201,'^^^^^^^^^^^^^^^^');

                END IF;--CURRENCY
              END IF;
           END IF;
       END IF;
       IF  M_SELECT_TYPE='SUB1' THEN
           IF M_SERIAL_NO IS NOT NULL AND M_INV_CODE IS NOT NULL THEN

              SELECT INST_TYPE INTO M_INST_TYPE
              FROM DN_REF_SECURITY
              WHERE SECURITY_CODE =M_SECURITY;

              UPDATE DN_TRN_REPO_FRESH_INST
              SET RPTRN_HCUT_PER=M_HCUT_PER
              WHERE
                  DEAL_NO=M_DEAL_NO
                  AND
                  INST_TYPE=M_INST_TYPE
                  AND
                  INV_CODE=M_INV_CODE;

              IF SQL%NOTFOUND THEN
                 INSERT INTO DN_TRN_REPO_FRESH_INST
                    (DEAL_NO,
                     INST_TYPE,
                     INV_CODE,
                     RPTRN_HCUT_PER)
                 VALUES(M_DEAL_NO,
                     M_INST_TYPE,
                     M_INV_CODE,
                     M_HCUT_PER);
              END IF;
--RAISE_APPLICATION_ERROR(-20201,'777777777777');


IF(M_CURR_CODE<>'SLR')THEN--CURRENCY
 UPDATE DN_TRN_REPO_FRESH_SEC
              SET ENDOSER_CODE      =M_ENDORSER,
                  FACE_VALUE        =M_FACE_VALUE*MM_CURRENCY_VALUE,--CURRENCY
                  FACE_VALUE_CURR   =M_FACE_VALUE
                   --FVAL_WITH_HAIR_CUT=M_HAIR_CUT
              WHERE
                 DEAL_NO       =M_DEAL_NO
                 AND
                 INST_TYPE     =M_INST_TYPE
                 AND
                 INV_CODE      =M_INV_CODE
                 AND
                 SECURITY_CODE =M_SECURITY;
              IF SQL%NOTFOUND THEN
--RAISE_APPLICATION_ERROR(-20201,'222222222222222');
                  INSERT INTO DN_TRN_REPO_FRESH_SEC
                 (DEAL_NO,
                  INST_TYPE,
                  INV_CODE,
                  SECURITY_CODE,
                  ENDOSER_CODE,
  	              FACE_VALUE,
                  FVAL_WITH_HAIR_CUT,
                  FACE_VALUE_CURR--CURRENCY
                 )
                 VALUES(
                      M_DEAL_NO,
                      M_INST_TYPE,
                      M_INV_CODE,
                      M_SECURITY,
                      M_ENDORSER,
  	                  M_FACE_VALUE*MM_CURRENCY_VALUE,--CURRENCY
                      M_HAIR_CUT,
                      M_FACE_VALUE--CURRENCY
                 );
              END IF;
              IF ((MM_SCRIP_STAT='SL') AND (TRIM(M_SERIAL_NO) = TRIM(M_PA_SERNO)))THEN  --$$##SC

                   SELECT  COUNT(*)
                   INTO    M_COUNT3
                   FROM    DN_TRN_REPO_FRESH A,
                           DN_REF_PORTFOLIO B
                   WHERE   A.DEAL_NO=M_DEAL_NO  AND
                           A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE  AND
                           B.PF_TYPE='P'  ;
                   IF(M_COUNT3>0)THEN--SELLER
                       DN_SAVE_ALLO_SL_REPO(M_DEAL_NO,M_SECURITY,M_SERIAL_NO,M_PA_SERNO,M_PA_INVAMT,M_FACE_VALUE,MM_CURRENCY_VALUE,M_USERNAME,MM_TOTAMT,M_CURR_CODE,'NEW');
                   END IF;

              ELSE--$$##SC

              UPDATE DN_TRN_REPO_FRESH_SERIAL_NO
              SET FACE_VALUE=M_FACE_VALUE*MM_CURRENCY_VALUE,--CURRENCY
                  LOCATION=M_BORR_PORTFOLIO_CODE,
                  PREV_DEAL_NO=M_PREV_DEAL_NO,
                  FACE_VALUE_CURR=M_FACE_VALUE--CURRENCY
              WHERE
                  DEAL_NO=M_DEAL_NO
                  AND
                  INST_TYPE=M_INST_TYPE
                  AND
                  INV_CODE=M_INV_CODE
                  AND
                  SECURITY_CODE=M_SECURITY
                  AND
                  SERIAL_NO=M_SERIAL_NO;

              IF SQL%NOTFOUND THEN
                 INSERT INTO DN_TRN_REPO_FRESH_SERIAL_NO
                    (DEAL_NO,
                     INST_TYPE,
                     INV_CODE,
                     SECURITY_CODE,
                     SERIAL_NO,
                     FACE_VALUE,
                     LOCATION,
                     PREV_DEAL_NO,
                     FACE_VALUE_CURR--CURRENCY
                     )
                 VALUES(M_DEAL_NO,
                     M_INST_TYPE,
                     M_INV_CODE,
                     M_SECURITY,
                     M_SERIAL_NO,
                     M_FACE_VALUE*MM_CURRENCY_VALUE,--CURRENCY
                     M_BORR_PORTFOLIO_CODE,
                     M_PREV_DEAL_NO,
                     M_FACE_VALUE--CURRENCY
                     );
              END IF;
              END IF;
ELSE--CURRENCY

              UPDATE DN_TRN_REPO_FRESH_SEC
              SET ENDOSER_CODE      =M_ENDORSER,
                  FACE_VALUE        =M_FACE_VALUE--,
                  --FVAL_WITH_HAIR_CUT=M_HAIR_CUT
              WHERE
                 DEAL_NO       =M_DEAL_NO
                 AND
                 INST_TYPE     =M_INST_TYPE
                 AND
                 INV_CODE      =M_INV_CODE
                 AND
                 SECURITY_CODE =M_SECURITY;
              IF SQL%NOTFOUND THEN
--RAISE_APPLICATION_ERROR(-20201,'222222222222222');
                  INSERT INTO DN_TRN_REPO_FRESH_SEC
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
               IF ((MM_SCRIP_STAT='SL') AND (TRIM(M_SERIAL_NO) = TRIM(M_PA_SERNO)))THEN  --$$##SC

                   SELECT  COUNT(*)
                   INTO    M_COUNT3
                   FROM    DN_TRN_REPO_FRESH A,
                           DN_REF_PORTFOLIO B
                   WHERE   A.DEAL_NO=M_DEAL_NO  AND
                           A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE  AND
                           B.PF_TYPE='P'  ;
--RAISE_APPLICATION_ERROR(-20201,'BB'||M_COUNT3);

                   IF(M_COUNT3>0)THEN--SELLER

                      DN_SAVE_ALLO_SL_REPO(M_DEAL_NO,M_SECURITY,M_SERIAL_NO,M_PA_SERNO,M_PA_INVAMT,M_FACE_VALUE,MM_CURRENCY_VALUE,M_USERNAME,MM_TOTAMT,M_CURR_CODE,'NEW');
                   END IF;

              ELSE--$$##SC

              UPDATE DN_TRN_REPO_FRESH_SERIAL_NO
              SET FACE_VALUE=M_FACE_VALUE,
                  LOCATION=M_BORR_PORTFOLIO_CODE,
                  PREV_DEAL_NO=M_PREV_DEAL_NO
              WHERE
                  DEAL_NO=M_DEAL_NO
                  AND
                  INST_TYPE=M_INST_TYPE
                  AND
                  INV_CODE=M_INV_CODE
                  AND
                  SECURITY_CODE=M_SECURITY
                  AND
                  SERIAL_NO=M_SERIAL_NO;

              IF SQL%NOTFOUND THEN
                 INSERT INTO DN_TRN_REPO_FRESH_SERIAL_NO
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
END IF;--CURRENCY
       END IF;
       IF M_SELECT_TYPE='SUB2' AND M_MODE<>'NULL' THEN
          IF M_MODE IS NOT NULL THEN

               IF(M_CURR_CODE<>'SLR')THEN--CURRENCY

             UPDATE DN_TRN_REPO_FRESH_SETTLE
              SET SETTLE_AMOUNT       =M_AMOUNT*MM_CURRENCY_VALUE,--CURRENCY
                  BORR_PORTFOLIO_CODE =M_BORR_PORTFOLIO_CODE,
                  BORR_BRANCH_CODE    =M_BORR_BRANCH_CODE,
                  BORR_ACC_NO         =M_BORROWER_MODE,
                  BORR_SETTLE_COMMENT =M_COMMENT1,
                  LEND_PORTFOLIO_CODE =M_LEND_PORTFOLIO_CODE,
                  LEND_BRANCH_CODE    =M_LEND_BRANCH_CODE,
                  LEND_ACC_NO         =M_LENDER_MODE,
                  LEND_SETTLE_COMMENT =M_COMMENT2,
                  CURRENCY_SETTLE_AMOUNT=M_AMOUNT--CURRENCY
              WHERE
                  DEAL_NO    =M_DEAL_NO
                  AND
                  SETTLE_MODE=M_MODE;

              IF SQL%NOTFOUND THEN
                 INSERT INTO DN_TRN_REPO_FRESH_SETTLE
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
                  LEND_SETTLE_COMMENT,
                  CURRENCY_SETTLE_AMOUNT--CURRENCY
                 )
                 VALUES(M_DEAL_NO,
                        M_MODE,
                        M_AMOUNT*MM_CURRENCY_VALUE,--CURRENCY
                        M_BORR_PORTFOLIO_CODE,
                        M_BORR_BRANCH_CODE,
                        M_BORROWER_MODE,
                        M_COMMENT1,
                        M_LEND_PORTFOLIO_CODE,
                        M_LEND_BRANCH_CODE,
                        M_LENDER_MODE,
                        M_COMMENT2,
                        M_AMOUNT--CURRENCY
                 );
              END IF;


             ELSE--CURRENCY
             UPDATE DN_TRN_REPO_FRESH_SETTLE
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
                 INSERT INTO DN_TRN_REPO_FRESH_SETTLE
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
            END IF;--CURRENCY

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
 /*IF M_SELECT_TYPE='SUB2' THEN
   DN_CHECK_FIGURES_RF(M_DEAL_NO,'2');
 END IF;/*/


       COMMIT;
   END IF;
   --If the data type is incorrect then delete the records from the relavent tables
EXCEPTION
  WHEN OTHERS THEN
  ROLLBACK;
DELETE DN_TRN_DEAL_CURRENCY
 WHERE
    DEAL_NO=M_DEAL_NO;

 DELETE DN_TRN_REPO_FRESH_SERIAL_NO
    WHERE
    DEAL_NO=M_DEAL_NO;
 DELETE DN_TRN_REPO_FRESH_SEC
    WHERE
    DEAL_NO=M_DEAL_NO;

 DELETE DN_TRN_REPO_FRESH_INST
    WHERE
    DEAL_NO=M_DEAL_NO;

   DELETE DN_TRN_REPO_FRESH
    WHERE
    DEAL_NO=M_DEAL_NO;

   err_num :=  substr(SQLCODE,1,15);
   err_msg := substr(SQLERRM,1,200) ;
  INSERT INTO DN_REF_SEQUENCE_LOG VALUES (M_DEAL_NO,err_num||''||err_msg,'ERROR IN REPOFRESH2',SYSDATE);
  COMMIT;
 RAISE_APPLICATION_ERROR(-20201,SQLCODE||SQLERRM);

/*
 EXCEPTION
  WHEN OTHERS THEN
    DELETE DN_TRN_BROKERAGE
    WHERE
    DEAL_NO=M_DEAL_NO;

    DELETE DN_TRN_REPO_FRESH_SETTLE
    WHERE
    DEAL_NO=M_DEAL_NO;

    DELETE DN_TRN_REPO_FRESH_SERIAL_NO
    WHERE
    DEAL_NO=M_DEAL_NO;

    DELETE DN_TRN_REPO_FRESH_SEC
    WHERE
    DEAL_NO=M_DEAL_NO;

    DELETE DN_TRN_REPO_FRESH_INST
    WHERE
    DEAL_NO=M_DEAL_NO;

    DELETE DN_TRN_REPO_FRESH
    WHERE
    DEAL_NO=M_DEAL_NO;

    COMMIT;

    RAISE_APPLICATION_ERROR(-20201,'Data error');
*/

END MBFSL_REPOFRESH_IN2;

/
