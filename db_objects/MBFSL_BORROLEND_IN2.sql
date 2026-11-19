--------------------------------------------------------
--  DDL for Procedure MBFSL_BORROLEND_IN2
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_BORROLEND_IN2" (
    M_DEAL_NO  IN OUT    DN_TRN_BL_FUND_SETTLE.DEAL_NO%TYPE,
    M_MODE_NO            DN_TRN_BL_FUND.NO_OF_SETTL_MODES%TYPE,
    M_MODE               DN_TRN_BL_FUND_SETTLE.SETTLE_MODE%TYPE,
    M_AMOUNT             DN_TRN_BL_FUND_SETTLE.SETTLE_AMOUNT%TYPE,
    M_BORROWER_MODE      DN_TRN_BL_FUND_SETTLE.BORR_PORTFOLIO_CODE%TYPE,
    M_LENDER_MODE        DN_TRN_BL_FUND_SETTLE.LEND_PORTFOLIO_CODE%TYPE,
    M_COMMENT1           DN_TRN_BL_FUND_SETTLE.BORR_SETTLE_COMMENT%TYPE,
    M_COMMENT2           DN_TRN_BL_FUND_SETTLE.LEND_SETTLE_COMMENT%TYPE,
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
    M_TOTAMOUNT2         DN_TRN_BROKERAGE.BROK_TOT_AMT_DUE%TYPE
    )

AS

   M_BCOUNT                NUMBER;
   M_LCOUNT                NUMBER;
   M_BORR_PORTFOLIO_CODE   DN_REF_PORTF_SETTLEMENT.PORTFOLIO_CODE%TYPE;
   M_LEND_PORTFOLIO_CODE   DN_REF_PORTF_SETTLEMENT.PORTFOLIO_CODE%TYPE;
   M_BORR_BRANCH_CODE      DN_REF_PORTF_SETTLEMENT.BRANCH_CODE%TYPE;
   M_LEND_BRANCH_CODE      DN_REF_PORTF_SETTLEMENT.BRANCH_CODE%TYPE;

   MM_CURRENCY_VALUE       DN_REF_EXCHANGE_RATES.CURRENCY_VALUE%TYPE;--CURRENCY
   M_COUNT_ALL             NUMBER;--CURRENCY
   M_CURR_CODE             DN_TRN_BL_FUND.CURR_CODE%TYPE;--CURRENCY

BEGIN

    --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO);
    --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||'-'||M_MODE_NO||'-'||M_MODE||'-'||M_AMOUNT||'-'||M_BORROWER_MODE||'-'||M_LENDER_MODE||'-'||M_COMMENT1||'-'||M_COMMENT2);

    -- PROCEDURE  -  TO INSERT BORROW LEND FUNDS DETAILS
    -- SYSTEM     -  MBFSL SYSTEM
    -- CREATED BY -  V.THILAKESAN.
    -- CREATED ON -  14/07/1999
-----------CURRENCY-----------------------------
SELECT COUNT(*)
INTO   M_COUNT_ALL
FROM   DN_TRN_BL_FUND
WHERE  DEAL_NO=M_DEAL_NO;

IF(M_COUNT_ALL>0)THEN
SELECT CURR_CODE
INTO   M_CURR_CODE
FROM   DN_TRN_BL_FUND
WHERE  DEAL_NO=M_DEAL_NO;
END IF;
------------ CURRENCY--------------------------------



    IF M_DEAL_NO IS NOT NULL THEN
       IF M_MODE_NO>0 THEN
          UPDATE DN_TRN_BL_FUND
          SET NO_OF_SETTL_MODES=M_MODE_NO
          WHERE DEAL_NO=M_DEAL_NO;
       END IF;

       --Select BUY_PORTFOLIO_CODE details from DN_REF_PORTF_SETTLEMENT
       M_BCOUNT:=0;
       SELECT COUNT(*) INTO M_BCOUNT
       FROM  DN_TRN_BL_FUND A
       WHERE A.DEAL_NO=M_DEAL_NO;
       IF M_BCOUNT>0 THEN
          SELECT A.BORR_PORTFOLIO_CODE,A.LEND_PORTFOLIO_CODE INTO M_BORR_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE
          FROM  DN_TRN_BL_FUND A
          WHERE A.DEAL_NO=M_DEAL_NO;
       END IF;
       M_BCOUNT:=0;
       SELECT COUNT(*) INTO M_BCOUNT
       FROM  DN_TRN_BL_FUND A,DN_REF_PORTF_SETTLEMENT B
       WHERE A.DEAL_NO=M_DEAL_NO AND A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_BORROWER_MODE;
       IF M_BCOUNT>0 THEN
          SELECT B.BRANCH_CODE INTO M_BORR_BRANCH_CODE
          FROM  DN_TRN_BL_FUND A,DN_REF_PORTF_SETTLEMENT B
          WHERE A.DEAL_NO=M_DEAL_NO AND A.BORR_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_BORROWER_MODE;
       END IF;

       --Select SEL_PORTFOLIO_CODE details from DN_REF_PORTF_SETTLEMENT
       M_LCOUNT:=0;
       SELECT COUNT(*) INTO M_LCOUNT
       FROM  DN_TRN_BL_FUND A,DN_REF_PORTF_SETTLEMENT B
       WHERE A.DEAL_NO=M_DEAL_NO AND A.LEND_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_LENDER_MODE;
       IF M_LCOUNT>0 THEN
          SELECT B.BRANCH_CODE INTO M_LEND_BRANCH_CODE
          FROM  DN_TRN_BL_FUND A,DN_REF_PORTF_SETTLEMENT B
          WHERE A.DEAL_NO=M_DEAL_NO AND A.LEND_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_LENDER_MODE;
       END IF;

       IF M_MODE<>'NULL' THEN
          IF M_MODE IS NOT NULL THEN

               IF(M_CURR_CODE<>'SLR')THEN--CURRENCY
                  ---------------CURRENCY----------------------
                  SELECT  CURRENCY_VALUE
                  INTO    MM_CURRENCY_VALUE
                  FROM    DN_REF_EXCHANGE_RATES
                  WHERE   CURR_CODE=M_CURR_CODE;
                 ---------------CURRENCY----------------------
               UPDATE DN_TRN_BL_FUND_SETTLE
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

     --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||' '||M_MODE||' '||M_AMOUNT||' '||M_BORR_PORTFOLIO_CODE||' '||M_BORR_BRANCH_CODE||' '||M_BORROWER_MODE||' '||M_COMMENT1||' '||M_LEND_PORTFOLIO_CODE||' '||M_LEND_BRANCH_CODE||' '||M_LENDER_MODE||' '||M_COMMENT2);
                                 --   BF19990811-006 CB_CHEQUE 12 COUNT1 7010-401 4545445 ERAGE MBSL1 HID_REF_NO=BF19990811-006 ERAGE ORA-06512: at
             IF SQL%NOTFOUND THEN
                INSERT INTO DN_TRN_BL_FUND_SETTLE
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
                       M_COMMENT2,M_AMOUNT--CURRENCY
                );
             END IF;


              ELSE--CURRENCY
               UPDATE DN_TRN_BL_FUND_SETTLE
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

     --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||' '||M_MODE||' '||M_AMOUNT||' '||M_BORR_PORTFOLIO_CODE||' '||M_BORR_BRANCH_CODE||' '||M_BORROWER_MODE||' '||M_COMMENT1||' '||M_LEND_PORTFOLIO_CODE||' '||M_LEND_BRANCH_CODE||' '||M_LENDER_MODE||' '||M_COMMENT2);
                                 --   BF19990811-006 CB_CHEQUE 12 COUNT1 7010-401 4545445 ERAGE MBSL1 HID_REF_NO=BF19990811-006 ERAGE ORA-06512: at
             IF SQL%NOTFOUND THEN
                INSERT INTO DN_TRN_BL_FUND_SETTLE
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
       COMMIT;
   END IF;
   --If the data type is incorrect then delete the records from the relavent tables
/*
 EXCEPTION
  WHEN OTHERS THEN

    DELETE DN_TRN_BROKERAGE
    WHERE
    DEAL_NO=M_DEAL_NO;

    DELETE DN_TRN_BL_FUND_SERIAL_NO
    WHERE
    DEAL_NO=M_DEAL_NO;

    DELETE DN_TRN_BL_FUND_SETTLE
    WHERE
    DEAL_NO=M_DEAL_NO;

    DELETE DN_TRN_BL_FUND_SEC
    WHERE
    DEAL_NO=M_DEAL_NO;

    DELETE DN_TRN_BL_FUND_INST
    WHERE
    DEAL_NO=M_DEAL_NO;

    DELETE DN_TRN_BL_FUND
    WHERE
    DEAL_NO=M_DEAL_NO;

    COMMIT;

    RAISE_APPLICATION_ERROR(-20201,'Data error');
*/
END MBFSL_BORROLEND_IN2;

/
