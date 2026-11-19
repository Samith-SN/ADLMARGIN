--------------------------------------------------------
--  DDL for Procedure MBFSL_SWAP_RETURNABLE_IN2
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_SWAP_RETURNABLE_IN2" (
    M_DEAL_NO  IN OUT    DN_TRN_SWAP_RETURNABLE.DEAL_NO%TYPE,
    M_MODE_NO            DN_TRN_SWAP_RETURNABLE.NO_OF_SETTL_MODES%TYPE,
    M_MODE               DN_TRN_SWAP_RETURNABLE_SETTLE.SETTLE_MODE%TYPE,
    M_AMOUNT             DN_TRN_SWAP_RETURNABLE_SETTLE.SETTLE_AMOUNT%TYPE,
    M_MODE1              DN_TRN_SWAP_RETURNABLE_SETTLE.P1_PORTFOLIO_CODE%TYPE,
    M_MODE2              DN_TRN_SWAP_RETURNABLE_SETTLE.P2_PORTFOLIO_CODE%TYPE,
    M_COMMENT1           DN_TRN_SWAP_RETURNABLE_SETTLE.P1_SETTLE_COMMENT%TYPE,
    M_COMMENT2           DN_TRN_SWAP_RETURNABLE_SETTLE.P2_SETTLE_COMMENT%TYPE,
    M_BROKER1            DN_TRN_BROKERAGE.BROK_CODE%TYPE,
    M_BROKER2            DN_TRN_BROKERAGE.BROK_CODE%TYPE,
    M_BROKERAGE1         DN_TRN_BROKERAGE.BROK_PER%TYPE,
    M_BROKERAGE2         DN_TRN_BROKERAGE.BROK_PER%TYPE,
    M_BASE1              DN_TRN_BROKERAGE.BROK_BASE%TYPE,
    M_BASE2              DN_TRN_BROKERAGE.BROK_BASE%TYPE,
    M_FEE_TYPE1          DN_TRN_BROKERAGE.BROK_FEE_TYPE%TYPE,
    M_FEE_TYPE2          DN_TRN_BROKERAGE.BROK_FEE_TYPE%TYPE,
    M_AMOUNT1            DN_TRN_BROKERAGE.BROK_FEE_AMOUNT%TYPE,
    M_AMOUNT2            DN_TRN_BROKERAGE.BROK_FEE_AMOUNT%TYPE,
    M_AMT1               DN_TRN_BROKERAGE.BROK_GST%TYPE,
    M_AMT2               DN_TRN_BROKERAGE.BROK_GST%TYPE,
    M_TOTAMOUNT1         DN_TRN_BROKERAGE.BROK_TOT_AMT_DUE%TYPE,
    M_TOTAMOUNT2         DN_TRN_BROKERAGE.BROK_TOT_AMT_DUE%TYPE
    )
AS

   M_BCOUNT                NUMBER;
   M_LCOUNT                NUMBER;
   M_P1_PORTFOLIO_CODE   DN_REF_PORTF_SETTLEMENT.PORTFOLIO_CODE%TYPE;
   M_P2_PORTFOLIO_CODE   DN_REF_PORTF_SETTLEMENT.PORTFOLIO_CODE%TYPE;
   M_P1_BRANCH_CODE      DN_REF_PORTF_SETTLEMENT.BRANCH_CODE%TYPE;
   M_P2_BRANCH_CODE      DN_REF_PORTF_SETTLEMENT.BRANCH_CODE%TYPE;

BEGIN

    --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO);

    -- PROCEDURE  -  TO INSERT SWAPS RETURNABLE DETAILS
    -- SYSTEM     -  MBFSL SYSTEM
    -- CREATED BY -  V.THILAKESAN.
    -- CREATED ON -  19/07/1999

    IF M_DEAL_NO IS NOT NULL THEN
       IF M_MODE_NO>0 THEN
          UPDATE DN_TRN_SWAP_RETURNABLE
          SET NO_OF_SETTL_MODES=M_MODE_NO
          WHERE DEAL_NO=M_DEAL_NO;
       END IF;

       --Select P1_PORTFOLIO_CODE details from DN_REF_PORTF_SETTLEMENT
       M_BCOUNT:=0;
       SELECT COUNT(*) INTO M_BCOUNT
       FROM  DN_TRN_SWAP_RETURNABLE A
       WHERE A.DEAL_NO=M_DEAL_NO;
       IF M_BCOUNT>0 THEN
          SELECT A.P1_PORTFOLIO_CODE,A.P2_PORTFOLIO_CODE INTO M_P1_PORTFOLIO_CODE,M_P2_PORTFOLIO_CODE
          FROM  DN_TRN_SWAP_RETURNABLE A
          WHERE A.DEAL_NO=M_DEAL_NO;
       END IF;
       M_BCOUNT:=0;
       SELECT COUNT(*) INTO M_BCOUNT
       FROM  DN_TRN_SWAP_RETURNABLE A,DN_REF_PORTF_SETTLEMENT B
       WHERE A.DEAL_NO=M_DEAL_NO AND A.P1_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_MODE1;
       IF M_BCOUNT>0 THEN
          SELECT B.BRANCH_CODE INTO M_P1_BRANCH_CODE
          FROM  DN_TRN_SWAP_RETURNABLE A,DN_REF_PORTF_SETTLEMENT B
          WHERE A.DEAL_NO=M_DEAL_NO AND A.P1_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_MODE1;
       END IF;

       --Select P2_PORTFOLIO_CODE details from DN_REF_PORTF_SETTLEMENT
       M_LCOUNT:=0;
       SELECT COUNT(*) INTO M_LCOUNT
       FROM  DN_TRN_SWAP_RETURNABLE A,DN_REF_PORTF_SETTLEMENT B
       WHERE A.DEAL_NO=M_DEAL_NO AND A.P2_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_MODE2;
       IF M_LCOUNT>0 THEN
          SELECT B.BRANCH_CODE INTO M_P2_BRANCH_CODE
          FROM  DN_TRN_SWAP_RETURNABLE A,DN_REF_PORTF_SETTLEMENT B
          WHERE A.DEAL_NO=M_DEAL_NO AND A.P2_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_MODE2;
       END IF;

       IF M_MODE IS NOT NULL THEN
          UPDATE DN_TRN_SWAP_RETURNABLE_SETTLE
          SET SETTLE_AMOUNT       =M_AMOUNT,
              P1_PORTFOLIO_CODE   =M_P1_PORTFOLIO_CODE,
              P1_BRANCH_CODE      =M_P1_BRANCH_CODE,
              P1_ACC_NO           =M_MODE1,
              P1_SETTLE_COMMENT   =M_COMMENT1,
              P2_PORTFOLIO_CODE   =M_P2_PORTFOLIO_CODE,
              P2_BRANCH_CODE      =M_P2_BRANCH_CODE,
              P2_ACC_NO           =M_MODE2,
              P2_SETTLE_COMMENT   =M_COMMENT2
          WHERE
              DEAL_NO    =M_DEAL_NO
              AND
              SETTLE_MODE=M_MODE;
          IF SQL%NOTFOUND THEN
             INSERT INTO DN_TRN_SWAP_RETURNABLE_SETTLE
             (DEAL_NO,
              SETTLE_MODE,
              SETTLE_AMOUNT,
              P1_PORTFOLIO_CODE,
              P1_BRANCH_CODE,
              P1_ACC_NO,
              P1_SETTLE_COMMENT,
              P2_PORTFOLIO_CODE,
              P2_BRANCH_CODE,
              P2_ACC_NO,
              P2_SETTLE_COMMENT
             )
              VALUES(M_DEAL_NO,
                     M_MODE,
                     M_AMOUNT,
                     M_P1_PORTFOLIO_CODE,
                     M_P1_BRANCH_CODE,
                     M_MODE1,
                     M_COMMENT1,
                     M_P2_PORTFOLIO_CODE,
                     M_P2_BRANCH_CODE,
                     M_MODE2,
                     M_COMMENT2
              );
          END IF;
       END IF;
       IF M_BROKER1 IS NOT NULL THEN
          UPDATE DN_TRN_BROKERAGE
          SET BROK_CODE       =M_BROKER1,
              BROK_PER        =M_BROKERAGE1,
              BROK_BASE       =M_BASE1,
              BROK_FEE_TYPE   =M_FEE_TYPE1,
              BROK_FEE_AMOUNT =M_AMOUNT1,
              BROK_GST        =M_AMT1,
              BROK_TOT_AMT_DUE=M_TOTAMOUNT1
          WHERE
              DEAL_NO     =M_DEAL_NO
              AND
              CP_CODE=M_P1_PORTFOLIO_CODE;
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
                        M_P1_PORTFOLIO_CODE,
                        M_BROKER1,
                        M_BROKERAGE1,
                        M_BASE1,
                        M_FEE_TYPE1,
                        M_AMOUNT1,
                        M_AMT1,
                        M_TOTAMOUNT1
                 );
             END IF;
         END IF;
         IF M_BROKER2 IS NOT NULL THEN

             UPDATE DN_TRN_BROKERAGE
             SET BROK_CODE     =M_BROKER2,
               BROK_PER        =M_BROKERAGE2,
               BROK_BASE       =M_BASE2,
               BROK_FEE_TYPE   =M_FEE_TYPE2,
               BROK_FEE_AMOUNT =M_AMOUNT2,
               BROK_GST        =M_AMT2,
               BROK_TOT_AMT_DUE=M_TOTAMOUNT2
           WHERE
              DEAL_NO     =M_DEAL_NO
              AND
              CP_CODE=M_P2_PORTFOLIO_CODE;

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
                     M_P2_PORTFOLIO_CODE,
                     M_BROKER2,
                     M_BROKERAGE2,
                     M_BASE2,
                     M_FEE_TYPE2,
                     M_AMOUNT2,
                     M_AMT2,
                     M_TOTAMOUNT2
              );
           END IF;
       END IF;
       COMMIT;
   END IF;
   --If the data type is incorrect then delete the records from the relavent tables

 EXCEPTION
  WHEN OTHERS THEN

    DELETE DN_TRN_BROKERAGE
    WHERE
    DEAL_NO=M_DEAL_NO;

    DELETE DN_TRN_SWAP_RETURNABLE_SETTLE
    WHERE
    DEAL_NO=M_DEAL_NO;

    DELETE DN_TRN_SWAP_RETURNABLE
    WHERE
    DEAL_NO=M_DEAL_NO;

    COMMIT;

    RAISE_APPLICATION_ERROR(-20201,'Data error');

END MBFSL_SWAP_RETURNABLE_IN2;

/
