--------------------------------------------------------
--  DDL for Procedure MBFSL_SWAP_OUTRIGHT_IN2
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_SWAP_OUTRIGHT_IN2" (
    M_DEAL_NO  IN OUT    DN_TRN_SWAP_OUTRIGHT.DEAL_NO%TYPE,
    M_SECCODE1           DN_TRN_SWAP_OUTRIGHT_SEC.SECURITY_CODE%TYPE,
    M_SENOIDEN1          DN_TRN_SWAP_OUTRIGHT_SEC.SERIAL_NO%TYPE,
	M_FACEVAL1           DN_TRN_SWAP_OUTRIGHT_SEC.FACE_VALUE%TYPE,
    M_SECCODE2           DN_TRN_SWAP_OUTRIGHT_SEC.SECURITY_CODE%TYPE,
    M_SENOIDEN2          DN_TRN_SWAP_OUTRIGHT_SEC.SERIAL_NO%TYPE,
	M_FACEVAL2           DN_TRN_SWAP_OUTRIGHT_SEC.FACE_VALUE%TYPE,
    M_SEL_MODES          DN_TRN_SWAP_OUTRIGHT.NO_OF_SETTL_MODES%TYPE,
    M_SETTLE             DN_TRN_SWAP_OUTRIGHT_SETTLE.SETTLE_MODE%TYPE,
    M_SETAMO             DN_TRN_SWAP_OUTRIGHT_SETTLE.SETTLE_AMOUNT%TYPE,
    M_P1_ACC             DN_TRN_SWAP_OUTRIGHT_SETTLE.P1_ACC_NO%TYPE,
    M_P2_ACC             DN_TRN_SWAP_OUTRIGHT_SETTLE.P2_ACC_NO%TYPE,
    M_P1_COMMENT         DN_TRN_SWAP_OUTRIGHT_SETTLE.P1_SETTLE_COMMENT%TYPE,
    M_P2_COMMENT         DN_TRN_SWAP_OUTRIGHT_SETTLE.P2_SETTLE_COMMENT%TYPE,
    M_BCODE1             DN_TRN_BROKERAGE.BROK_CODE%TYPE,
    M_BCODE2             DN_TRN_BROKERAGE.BROK_CODE%TYPE,
    M_BRAGE1             DN_TRN_BROKERAGE.BROK_PER%TYPE,
    M_BRAGE2             DN_TRN_BROKERAGE.BROK_PER%TYPE,
    M_SEL_BBASE1         DN_TRN_BROKERAGE.BROK_BASE%TYPE,
    M_SEL_BBASE2         DN_TRN_BROKERAGE.BROK_BASE%TYPE,
    M_SEL_FEETYPE1       DN_TRN_BROKERAGE.BROK_FEE_TYPE%TYPE,
    M_SEL_FEETYPE2       DN_TRN_BROKERAGE.BROK_FEE_TYPE%TYPE,
    M_FEEAMO1            DN_TRN_BROKERAGE.BROK_FEE_AMOUNT%TYPE,
    M_FEEAMO2            DN_TRN_BROKERAGE.BROK_FEE_AMOUNT%TYPE,
    M_VAL1               DN_TRN_BROKERAGE.BROK_GST%TYPE,
    M_VAL2               DN_TRN_BROKERAGE.BROK_GST%TYPE,
    M_TOTAMOU1           DN_TRN_BROKERAGE.BROK_TOT_AMT_DUE%TYPE,
    M_TOTAMOU2           DN_TRN_BROKERAGE.BROK_TOT_AMT_DUE%TYPE,
    M_SELECT_TYPE        CHAR
    )
AS

   M_BCOUNT                NUMBER;
   M_SCOUNT                NUMBER;
   M_P1_PORTFOLIO_CODE     DN_REF_PORTF_SETTLEMENT.PORTFOLIO_CODE%TYPE;
   M_P2_PORTFOLIO_CODE     DN_REF_PORTF_SETTLEMENT.PORTFOLIO_CODE%TYPE;
   M_P1_BRANCH_CODE        DN_REF_PORTF_SETTLEMENT.BRANCH_CODE%TYPE;
   M_P2_BRANCH_CODE        DN_REF_PORTF_SETTLEMENT.BRANCH_CODE%TYPE;

BEGIN

    --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO);

    -- PROCEDURE  -  TO INSERT SWAPS OUTRIGHT DETAILS
    -- SYSTEM     -  MBFSL SYSTEM
    -- CREATED BY -  V.THILAKESAN.
    -- CREATED ON -  16/07/1999

    IF M_DEAL_NO IS NOT NULL THEN
       IF M_SEL_MODES>0 THEN
          UPDATE DN_TRN_SWAP_OUTRIGHT
          SET NO_OF_SETTL_MODES=M_SEL_MODES
          WHERE DEAL_NO=M_DEAL_NO;
       END IF;
       --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||' '||M_SELECT_TYPE||' '||M_SECCODE||' '||M_SENOIDEN);

       IF  M_SELECT_TYPE='SUB1' AND M_SECCODE1<>'NULL' AND M_SENOIDEN1<>'NULL' THEN
           IF M_SECCODE1 IS NOT NULL AND  M_SENOIDEN1 IS NOT NULL THEN
              UPDATE DN_TRN_SWAP_OUTRIGHT_SEC
              SET FACE_VALUE   = M_FACEVAL1
              WHERE
                 DEAL_NO       =M_DEAL_NO
                 AND
                 SECURITY_CODE =M_SECCODE1
                 AND
                 SERIAL_NO     =M_SENOIDEN1;

              IF SQL%NOTFOUND THEN
                 INSERT INTO DN_TRN_SWAP_OUTRIGHT_SEC
                 (DEAL_NO,
  	              SECURITY_CODE,
                  SERIAL_NO,
  	              FACE_VALUE
                 )
                 VALUES(
                        M_DEAL_NO,
                        M_SECCODE1,
                        M_SENOIDEN1,
  	                    M_FACEVAL1
                 );
              END IF;
          END IF;
       END IF;
        IF  M_SELECT_TYPE='SUB2' AND M_SECCODE2<>'NULL' AND M_SENOIDEN2<>'NULL' THEN
           IF M_SECCODE2 IS NOT NULL AND  M_SENOIDEN2 IS NOT NULL THEN
              UPDATE DN_TRN_SWAP_OUTRIGHT_SEC
              SET FACE_VALUE   = M_FACEVAL2
              WHERE
                 DEAL_NO       =M_DEAL_NO
                 AND
                 SECURITY_CODE =M_SECCODE2
                 AND
                 SERIAL_NO     =M_SENOIDEN2;

              IF SQL%NOTFOUND THEN
                 INSERT INTO DN_TRN_SWAP_OUTRIGHT_SEC
                 (DEAL_NO,
  	              SECURITY_CODE,
                  SERIAL_NO,
  	              FACE_VALUE
                 )
                 VALUES(
                        M_DEAL_NO,
                        M_SECCODE2,
                        M_SENOIDEN2,
  	                    M_FACEVAL2
                 );
              END IF;
          END IF;
       END IF;

       --Select PORTFOLIO_CODE  from DN_REF_PORTF_SETTLEMENT
       M_BCOUNT:=0;
       SELECT COUNT(*) INTO M_BCOUNT
       FROM  DN_TRN_SWAP_OUTRIGHT A
       WHERE A.DEAL_NO=M_DEAL_NO;

       IF M_BCOUNT>0 THEN
          SELECT A.P1_PORTFOLIO_CODE,A.P2_PORTFOLIO_CODE INTO M_P1_PORTFOLIO_CODE,M_P2_PORTFOLIO_CODE
          FROM  DN_TRN_SWAP_OUTRIGHT A
          WHERE A.DEAL_NO=M_DEAL_NO;
       END IF;

       --Select BUY_PORTFOLIO_CODE BRANCH CODE details from DN_REF_PORTF_SETTLEMENT
       M_BCOUNT:=0;
       SELECT COUNT(*) INTO M_BCOUNT
       FROM  DN_TRN_SWAP_OUTRIGHT A,DN_REF_PORTF_SETTLEMENT B
       WHERE A.DEAL_NO=M_DEAL_NO AND A.P1_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_P1_ACC;

       IF M_BCOUNT>0 THEN
          SELECT B.BRANCH_CODE INTO M_P1_BRANCH_CODE
          FROM  DN_TRN_SWAP_OUTRIGHT A,DN_REF_PORTF_SETTLEMENT B
          WHERE A.DEAL_NO=M_DEAL_NO AND A.P1_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_P1_ACC;
       END IF;

       --Select SELL_PORTFOLIO_CODE BRANCH CODE details from DN_REF_PORTF_SETTLEMENT
       M_SCOUNT:=0;
       SELECT COUNT(*) INTO M_SCOUNT
       FROM  DN_TRN_SWAP_OUTRIGHT A,DN_REF_PORTF_SETTLEMENT B
       WHERE A.DEAL_NO=M_DEAL_NO AND A.P2_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_P2_ACC;
       IF M_SCOUNT>0 THEN
          SELECT B.BRANCH_CODE INTO M_P2_BRANCH_CODE
          FROM  DN_TRN_SWAP_OUTRIGHT A,DN_REF_PORTF_SETTLEMENT B
          WHERE A.DEAL_NO=M_DEAL_NO AND A.P2_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_P2_ACC;
       END IF;

       IF M_SELECT_TYPE='SUB3' AND M_SETTLE<>'NULL' THEN
          IF M_SETTLE IS NOT NULL THEN

             UPDATE DN_TRN_SWAP_OUTRIGHT_SETTLE
             SET SETTLE_AMOUNT     =M_SETAMO,
                 P1_PORTFOLIO_CODE =M_P1_PORTFOLIO_CODE,
                 P1_BRANCH_CODE    =M_P1_BRANCH_CODE,
                 P1_ACC_NO         =M_P1_ACC,
                 P1_SETTLE_COMMENT =M_P1_COMMENT,
                 P2_PORTFOLIO_CODE =M_P2_PORTFOLIO_CODE,
                 P2_BRANCH_CODE    =M_P2_BRANCH_CODE,
                 P2_ACC_NO         =M_P2_ACC,
                 P2_SETTLE_COMMENT =M_P2_COMMENT
              WHERE
                 DEAL_NO    =M_DEAL_NO
                 AND
                 SETTLE_MODE=M_SETTLE;

              IF SQL%NOTFOUND THEN
                 INSERT INTO DN_TRN_SWAP_OUTRIGHT_SETTLE
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
                        M_SETTLE,
                        M_SETAMO,
                        M_P1_PORTFOLIO_CODE,
                        M_P1_BRANCH_CODE,
                        M_P1_ACC,
                        M_P1_COMMENT,
                        M_P2_PORTFOLIO_CODE,
                        M_P2_BRANCH_CODE,
                        M_P2_ACC,
                        M_P2_COMMENT
                 );
              END IF;
           END IF;
       END IF;
       --M_BUY_PORTFOLIO_CODE||M_SELL_PORTFOLIO_CODE
       IF M_BCODE1 IS NOT NULL THEN
          UPDATE DN_TRN_BROKERAGE
          SET BROK_CODE       =M_BCODE1,
              BROK_PER        =M_BRAGE1,
              BROK_BASE       =M_SEL_BBASE1,
              BROK_FEE_TYPE   =M_SEL_FEETYPE1,
              BROK_FEE_AMOUNT =M_FEEAMO1,
              BROK_GST        =M_VAL1,
              BROK_TOT_AMT_DUE=M_TOTAMOU1
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
                        M_BCODE1,
                        M_BRAGE1,
                        M_SEL_BBASE1,
                        M_SEL_FEETYPE1,
                        M_FEEAMO1,
                        M_VAL1,
                        M_TOTAMOU1
                 );
             END IF;
       END IF;
       IF M_BCODE2 IS NOT NULL THEN

          UPDATE DN_TRN_BROKERAGE
          SET BROK_CODE       =M_BCODE2,
              BROK_PER        =M_BRAGE2,
              BROK_BASE       =M_SEL_BBASE2,
              BROK_FEE_TYPE   =M_SEL_FEETYPE2,
              BROK_FEE_AMOUNT =M_FEEAMO2,
              BROK_GST        =M_VAL2,
              BROK_TOT_AMT_DUE=M_TOTAMOU2
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
                     M_BCODE2,
                     M_BRAGE2,
                     M_SEL_BBASE2,
                     M_SEL_FEETYPE2,
                     M_FEEAMO2,
                     M_VAL1,
                     M_TOTAMOU1
              );
           END IF;
       END IF;
       COMMIT;
   END IF;

 EXCEPTION
  WHEN OTHERS THEN
   --If the data type is incorrect then delete the records from the relavent tables

   DELETE DN_TRN_BROKERAGE
   WHERE
   DEAL_NO=M_DEAL_NO;

   DELETE DN_TRN_SWAP_OUTRIGHT_SETTLE
   WHERE
   DEAL_NO=M_DEAL_NO;

   DELETE DN_TRN_SWAP_OUTRIGHT_SEC
   WHERE
   DEAL_NO=M_DEAL_NO;

   DELETE DN_TRN_SWAP_OUTRIGHT
   WHERE
   DEAL_NO=M_DEAL_NO;

    COMMIT;

    RAISE_APPLICATION_ERROR(-20201,'Data error');


END MBFSL_SWAP_OUTRIGHT_IN2;

/
