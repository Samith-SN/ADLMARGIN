--------------------------------------------------------
--  DDL for Procedure MBFSL_OUTRIGHT_IN2_PF
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_OUTRIGHT_IN2_PF" (
    M_DEAL_NO  IN OUT    DN_TRN_OUTP_SALE.DEAL_NO%TYPE,
    M_SECCODE            DN_TRN_OUTP_SALE_SEC.SECURITY_CODE%TYPE,
    M_SENOIDEN           DN_TRN_OUTP_SALE_SEC.SERIAL_NO%TYPE,
    M_FACEVAL            DN_TRN_OUTP_SALE_SEC.FACE_VALUE%TYPE,
    M_SEL_MODES          DN_TRN_OUTP_SALE.NO_OF_SETTL_MODES%TYPE,
    M_SETTLE             DN_TRN_OUTP_SALE_SETTLE.SETTLE_MODE%TYPE,
    M_SETAMO             DN_TRN_OUTP_SALE_SETTLE.SETTLE_AMOUNT%TYPE,
    M_BACC               DN_TRN_OUTP_SALE_SETTLE.BUY_ACC_NO%TYPE,
    M_SACC               DN_TRN_OUTP_SALE_SETTLE.SELL_ACC_NO%TYPE,
    M_BUY_COMMENT        DN_TRN_OUTP_SALE_SETTLE.BUY_SETTLE_COMMENT%TYPE,
    M_SEL_COMMENT        DN_TRN_OUTP_SALE_SETTLE.SELL_SETTLE_COMMENT%TYPE,
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
    M_SELECT_TYPE        CHAR,
    M_DEAL_TYPE          VARCHAR2,
    M_PA_SERNO           DN_TRN_OUTP_SALE_SEC.SERIAL_NO%TYPE,--$$##SC
    M_PA_INVAMT          DN_TRN_BROKERAGE.BROK_TOT_AMT_DUE%TYPE,--$$##SC
    M_DN_USER            DN_TRN_BO_INV_PARTALLO.DN_USER%TYPE,--$$##SC
    MM_TOTAMT            DN_TRN_BROKERAGE.BROK_TOT_AMT_DUE%TYPE,--$$##SC
    MM_SCRIP_STAT        VARCHAR--$$##SC

    )
AS



   M_BCOUNT                NUMBER;
   M_SCOUNT                NUMBER;
   M_BUY_PORTFOLIO_CODE    DN_REF_PORTF_SETTLEMENT.PORTFOLIO_CODE%TYPE;
   M_SELL_PORTFOLIO_CODE   DN_REF_PORTF_SETTLEMENT.PORTFOLIO_CODE%TYPE;
   M_BUY_BRANCH_CODE       DN_REF_PORTF_SETTLEMENT.BRANCH_CODE%TYPE;
   M_SELL_BRANCH_CODE      DN_REF_PORTF_SETTLEMENT.BRANCH_CODE%TYPE;

   MM_CURRENCY_VALUE       DN_REF_EXCHANGE_RATES.CURRENCY_VALUE%TYPE;--CURRENCY
   M_COUNT_ALL             NUMBER;--CURRENCY
   M_COUNT3                NUMBER;--$$##SC
   M_CURR_CODE             DN_TRN_OUTP_SALE.CURR_CODE%TYPE;--CURRENCY
   err_num   varchar2(200);
   err_msg   varchar2(200);
   M_YIELD_TYPE            DN_REF_INSTRUMENT.YIELD_TYPE%TYPE; ---

BEGIN

-----------CURRENCY-----------------------------
SELECT COUNT(*)
INTO   M_COUNT_ALL
FROM   DN_TRN_OUTP_SALE
WHERE  DEAL_NO=M_DEAL_NO;


IF(M_COUNT_ALL>0)THEN--$$##SC
SELECT CURR_CODE,DN_GET_INSTRUMENT_YIELD_TYPE(INST_TYPE)---
INTO   M_CURR_CODE,M_YIELD_TYPE----
FROM   DN_TRN_OUTP_SALE
WHERE  DEAL_NO=M_DEAL_NO;


---------------CURRENCY----------------------
                  SELECT  CURRENCY_VALUE
                  INTO    MM_CURRENCY_VALUE
                  FROM    DN_REF_EXCHANGE_RATES
                  WHERE   CURR_CODE=M_CURR_CODE;

------------ CURRENCY--------------------------------

END IF;--$$##SC



         --RAISE_APPLICATION_ERROR(-20201,MM_SCRIP_STAT);

    -- PROCEDURE  -  TO INSERT OUTRIGHT DETAILS
    -- SYSTEM     -  MBFSL SYSTEM
    -- CREATED BY -  V.THILAKESAN.
    -- CREATED ON -  25/06/1999


    IF M_DEAL_NO IS NOT NULL THEN

       IF M_SEL_MODES>0 THEN
          UPDATE DN_TRN_OUTP_SALE
          SET NO_OF_SETTL_MODES=M_SEL_MODES
          WHERE DEAL_NO=M_DEAL_NO;
       END IF;
       IF  ( M_SELECT_TYPE='SUB1' AND (  (M_SECCODE<>'NULL' AND M_SENOIDEN<>'NULL' ) OR (M_SENOIDEN IS NOT NULL AND M_SECCODE IS NOT NULL) OR (M_SENOIDEN <>'' AND M_SECCODE <>'')))  THEN --

          IF( (M_SECCODE IS NOT NULL AND  M_SENOIDEN IS NOT NULL) OR (M_SECCODE <>'' AND  M_SENOIDEN <>'')) THEN

            IF(M_CURR_CODE<>'SLR')THEN--CURRENCY
            IF (MM_SCRIP_STAT='SL') THEN  --$$##SC

                   SELECT  COUNT(*)
                   INTO    M_COUNT3
                   FROM    DN_TRN_OUTP_SALE A,
                           DN_REF_PORTFOLIO B
                   WHERE   A.DEAL_NO=M_DEAL_NO  AND
                           A.SELL_PORTFOLIO_CODE=B.PORTFOLIO_CODE  AND
                           B.PF_TYPE='P'  ;
                   IF(M_COUNT3>0)THEN--SELLER
                      --ADDED BY SVA ON 14-05-2005
                      IF M_YIELD_TYPE = 'W' THEN
                         --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||'-S11111- '||M_SELECT_TYPE||'-'||M_SECCODE||'-'||M_SENOIDEN);

                      --TEMP CONMMENTED BY NIRMALA ON 08/12/2005 AND ADDED THE NORMALA SL
                 DN_SAVE_ALLO_SCRIPLESS_CALL(M_DEAL_NO,M_SECCODE,M_SENOIDEN,M_PA_SERNO,M_PA_INVAMT,M_FACEVAL,MM_CURRENCY_VALUE,M_DN_USER,MM_TOTAMT,M_CURR_CODE,'NEW');
                    ---------///////////     DN_SAVE_ALLO_SCRIPLESS(M_DEAL_NO,M_SECCODE,M_SENOIDEN,M_PA_SERNO,M_PA_INVAMT,M_FACEVAL,MM_CURRENCY_VALUE,M_DN_USER,MM_TOTAMT,M_CURR_CODE,'NEW');
                         ELSE --END 14-05-2005
                         --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||'-N11111- '||M_SELECT_TYPE||'-'||M_SECCODE||'-'||M_SENOIDEN);
                         DN_SAVE_ALLO_SCRIPLESS(M_DEAL_NO,M_SECCODE,M_SENOIDEN,M_PA_SERNO,M_PA_INVAMT,M_FACEVAL,MM_CURRENCY_VALUE,M_DN_USER,MM_TOTAMT,M_CURR_CODE,'NEW');
                      END IF;

                   END IF;

            ELSE --$$##SC----------PART ALLOCATION
              UPDATE DN_TRN_OUTP_SALE_SEC
              SET FACE_VALUE   = M_FACEVAL*MM_CURRENCY_VALUE,
                  FACE_VALUE_CURR = M_FACEVAL
              WHERE
                 DEAL_NO       =M_DEAL_NO
                 AND
                 SECURITY_CODE =M_SECCODE
                 AND
                 SERIAL_NO     =M_SENOIDEN;

              IF SQL%NOTFOUND THEN
                 INSERT INTO DN_TRN_OUTP_SALE_SEC
                 (DEAL_NO,
  	              SECURITY_CODE,
                  SERIAL_NO,
  	              FACE_VALUE,
                  FACE_VALUE_CURR
                 )
                 VALUES(
                        M_DEAL_NO,
                        M_SECCODE,
                        M_SENOIDEN,
  	                    M_FACEVAL*MM_CURRENCY_VALUE,
                        M_FACEVAL
                 );
              END IF;
             END IF;
            ELSE--CURRENCY

IF (MM_SCRIP_STAT='SL') THEN  --$$##SC

                   SELECT  COUNT(*)
                   INTO    M_COUNT3
                   FROM    DN_TRN_OUTP_SALE A,
                           DN_REF_PORTFOLIO B
                   WHERE   A.DEAL_NO=M_DEAL_NO  AND
                           A.SELL_PORTFOLIO_CODE=B.PORTFOLIO_CODE  AND
                           B.PF_TYPE='P'  ;
                   IF(M_COUNT3>0)THEN--SELLER
                     --ADDED BY SVA ON 14-05-2005
                      IF M_YIELD_TYPE = 'W' THEN
                         --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||'-N22222- '||M_SELECT_TYPE||'-'||M_SECCODE||'-'||M_SENOIDEN);

                       --------------//////////DN_SAVE_ALLO_SCRIPLESS(M_DEAL_NO,M_SECCODE,M_SENOIDEN,M_PA_SERNO,M_PA_INVAMT,M_FACEVAL,MM_CURRENCY_VALUE,M_DN_USER,MM_TOTAMT,M_CURR_CODE,'NEW');
                       DN_SAVE_ALLO_SCRIPLESS_CALL(M_DEAL_NO,M_SECCODE,M_SENOIDEN,M_PA_SERNO,M_PA_INVAMT,M_FACEVAL,MM_CURRENCY_VALUE,M_DN_USER,MM_TOTAMT,M_CURR_CODE,'NEW');


                      ELSE --END 14-05-2005
                         --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||'-S22222- '||M_SELECT_TYPE||'-'||M_SECCODE||'-'||M_SENOIDEN);
                         DN_SAVE_ALLO_SCRIPLESS(M_DEAL_NO,M_SECCODE,M_SENOIDEN,M_PA_SERNO,M_PA_INVAMT,M_FACEVAL,MM_CURRENCY_VALUE,M_DN_USER,MM_TOTAMT,M_CURR_CODE,'NEW');
                      END IF;
                   END IF;

        ELSE ---$$##SC---------PART ALLOCATION
              UPDATE DN_TRN_OUTP_SALE_SEC
              SET FACE_VALUE   = M_FACEVAL
              WHERE
                 DEAL_NO       =M_DEAL_NO
                 AND
                 SECURITY_CODE =M_SECCODE
                 AND
                 SERIAL_NO     =M_SENOIDEN;

              IF SQL%NOTFOUND THEN
                 INSERT INTO DN_TRN_OUTP_SALE_SEC
                 (DEAL_NO,
  	              SECURITY_CODE,
                  SERIAL_NO,
  	              FACE_VALUE
                 )
                 VALUES(
                        M_DEAL_NO,
                        M_SECCODE,
                        M_SENOIDEN,
  	                    M_FACEVAL
                 );
              END IF;
              END IF;-------PART ALLOCATIONS
            END IF;--CURRENCY
          END IF;
          ELSE--ADDED BY SVA ON 14-05-2005
       --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||'-222222222- '||MM_SCRIP_STAT||'-'||M_SECCODE||'-'||M_SENOIDEN);
         IF (MM_SCRIP_STAT='SL') THEN

                   SELECT  COUNT(*)
                   INTO    M_COUNT3
                   FROM    DN_TRN_OUTP_SALE A,
                           DN_REF_PORTFOLIO B
                   WHERE   A.DEAL_NO=M_DEAL_NO  AND
                           A.SELL_PORTFOLIO_CODE=B.PORTFOLIO_CODE  AND
                           B.PF_TYPE='P'  ;
         IF(M_COUNT3>0)THEN--SELLER
           IF M_YIELD_TYPE = 'W' THEN
              --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||'-N333333- '||M_SELECT_TYPE||'-'||M_SECCODE||'-'||M_SENOIDEN);
              DN_SAVE_ALLO_SCRIPLESS_CALL(M_DEAL_NO,M_SECCODE,M_SENOIDEN,M_PA_SERNO,M_PA_INVAMT,M_FACEVAL,MM_CURRENCY_VALUE,M_DN_USER,MM_TOTAMT,M_CURR_CODE,'NEW');
           END IF;
         END IF;--END 14-05-2005
        END IF;
       END IF;--sub1  not null
       --Select BUY_PORTFOLIO_CODE  from DN_REF_PORTF_SETTLEMENT
       M_BCOUNT:=0;
       SELECT COUNT(*) INTO M_BCOUNT
       FROM  DN_TRN_OUTP_SALE A
       WHERE A.DEAL_NO=M_DEAL_NO;

       IF M_BCOUNT>0 THEN
          SELECT A.BUY_PORTFOLIO_CODE INTO M_BUY_PORTFOLIO_CODE
          FROM  DN_TRN_OUTP_SALE A
          WHERE A.DEAL_NO=M_DEAL_NO;
       END IF;

       --Select SEL_PORTFOLIO_CODE from DN_REF_PORTF_SETTLEMENT
       M_SCOUNT:=0;
       SELECT COUNT(*) INTO M_SCOUNT
       FROM  DN_TRN_OUTP_SALE A
       WHERE A.DEAL_NO=M_DEAL_NO;
       IF M_SCOUNT>0 THEN
          SELECT A.SELL_PORTFOLIO_CODE INTO M_SELL_PORTFOLIO_CODE
          FROM  DN_TRN_OUTP_SALE A
          WHERE A.DEAL_NO=M_DEAL_NO;
       END IF;
       --Select BUY_PORTFOLIO_CODE BRANCH CODE details from DN_REF_PORTF_SETTLEMENT
       M_BCOUNT:=0;
       SELECT COUNT(*) INTO M_BCOUNT
       FROM  DN_TRN_OUTP_SALE A,DN_REF_PORTF_SETTLEMENT B
       WHERE A.DEAL_NO=M_DEAL_NO AND A.BUY_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_BACC;

       IF M_BCOUNT>0 THEN
          SELECT B.BRANCH_CODE INTO M_BUY_BRANCH_CODE
          FROM  DN_TRN_OUTP_SALE A,DN_REF_PORTF_SETTLEMENT B
          WHERE A.DEAL_NO=M_DEAL_NO AND A.BUY_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_BACC;
       END IF;

       --Select SELL_PORTFOLIO_CODE BRANCH CODE details from DN_REF_PORTF_SETTLEMENT
       M_SCOUNT:=0;
       SELECT COUNT(*) INTO M_SCOUNT
       FROM  DN_TRN_OUTP_SALE A,DN_REF_PORTF_SETTLEMENT B
       WHERE A.DEAL_NO=M_DEAL_NO AND A.SELL_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_SACC;
       IF M_SCOUNT>0 THEN
          SELECT B.BRANCH_CODE INTO M_SELL_BRANCH_CODE
          FROM  DN_TRN_OUTP_SALE A,DN_REF_PORTF_SETTLEMENT B
          WHERE A.DEAL_NO=M_DEAL_NO AND A.SELL_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND B.ACC_NO=M_SACC;
       END IF;

       IF M_SELECT_TYPE='SUB2' AND M_SETTLE<>'NULL' THEN
          IF M_SETTLE IS NOT NULL THEN
             IF(M_CURR_CODE<>'SLR')THEN--CURRENCY

             UPDATE DN_TRN_OUTP_SALE_SETTLE
             SET SETTLE_AMOUNT      =(SETTLE_AMOUNT+M_SETAMO)*MM_CURRENCY_VALUE,--CURRENCY
                 CURRENCY_SETTLE_AMOUNT = (CURRENCY_SETTLE_AMOUNT+M_SETAMO),--CURRENCY
                 BUY_PORTFOLIO_CODE =M_BUY_PORTFOLIO_CODE,
                 BUY_BRANCH_CODE    =M_BUY_BRANCH_CODE,
                 BUY_ACC_NO         =M_BACC,
                 BUY_SETTLE_COMMENT =M_BUY_COMMENT,
                 SELL_PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE,
                 SELL_BRANCH_CODE   =M_SELL_BRANCH_CODE,
                 SELL_ACC_NO        =M_SACC,
                 SELL_SETTLE_COMMENT=M_SEL_COMMENT
              WHERE
                 DEAL_NO    =M_DEAL_NO
                 AND
                 SETTLE_MODE=M_SETTLE;

              IF SQL%NOTFOUND THEN
                 INSERT INTO DN_TRN_OUTP_SALE_SETTLE
                 (DEAL_NO,
  	              SETTLE_MODE,
                  SETTLE_AMOUNT,
                  CURRENCY_SETTLE_AMOUNT,--CURRENCY
                  BUY_PORTFOLIO_CODE,
                  BUY_BRANCH_CODE,
                  BUY_ACC_NO,
                  BUY_SETTLE_COMMENT,
                  SELL_PORTFOLIO_CODE,
                  SELL_BRANCH_CODE,
                  SELL_ACC_NO,
                  SELL_SETTLE_COMMENT
                 )
                 VALUES(M_DEAL_NO,
                        M_SETTLE,
                        M_SETAMO*MM_CURRENCY_VALUE,--CURRENCY
                        M_SETAMO,--CURRENCY
                        M_BUY_PORTFOLIO_CODE,
                        M_BUY_BRANCH_CODE,
                        M_BACC,
                        M_BUY_COMMENT,
                        M_SELL_PORTFOLIO_CODE,
                        M_SELL_BRANCH_CODE,
                        M_SACC,
                        M_SEL_COMMENT );
              END IF;

             ELSE--CURRENCY
             UPDATE DN_TRN_OUTP_SALE_SETTLE
             SET SETTLE_AMOUNT      =SETTLE_AMOUNT+M_SETAMO,
                 BUY_PORTFOLIO_CODE =M_BUY_PORTFOLIO_CODE,
                 BUY_BRANCH_CODE    =M_BUY_BRANCH_CODE,
                 BUY_ACC_NO         =M_BACC,
                 BUY_SETTLE_COMMENT =M_BUY_COMMENT,
                 SELL_PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE,
                 SELL_BRANCH_CODE   =M_SELL_BRANCH_CODE,
                 SELL_ACC_NO        =M_SACC,
                 SELL_SETTLE_COMMENT=M_SEL_COMMENT
              WHERE
                 DEAL_NO    =M_DEAL_NO
                 AND
                 SETTLE_MODE=M_SETTLE;

              IF SQL%NOTFOUND THEN
                 INSERT INTO DN_TRN_OUTP_SALE_SETTLE
                 (DEAL_NO,
  	              SETTLE_MODE,
                  SETTLE_AMOUNT,
                  BUY_PORTFOLIO_CODE,
                  BUY_BRANCH_CODE,
                  BUY_ACC_NO,
                  BUY_SETTLE_COMMENT,
                  SELL_PORTFOLIO_CODE,
                  SELL_BRANCH_CODE,
                  SELL_ACC_NO,
                  SELL_SETTLE_COMMENT
                 )
                 VALUES(M_DEAL_NO,
                        M_SETTLE,
                        NVL(M_SETAMO,0),
                        M_BUY_PORTFOLIO_CODE,
                        M_BUY_BRANCH_CODE,
                        M_BACC,
                        M_BUY_COMMENT,
                        M_SELL_PORTFOLIO_CODE,
                        M_SELL_BRANCH_CODE,
                        M_SACC,
                        M_SEL_COMMENT );
              END IF;
            END IF;--CURRENCY
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
              CP_CODE=M_BUY_PORTFOLIO_CODE;

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
                        M_BUY_PORTFOLIO_CODE,
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
          SET BROK_CODE      =M_BCODE2,
                 BROK_PER       =M_BRAGE2,
                 BROK_BASE      =M_SEL_BBASE2,
                 BROK_FEE_TYPE  =M_SEL_FEETYPE2,
                 BROK_FEE_AMOUNT=M_FEEAMO2,
                 BROK_GST        =M_VAL2,
                 BROK_TOT_AMT_DUE=M_TOTAMOU2
           WHERE
              DEAL_NO     =M_DEAL_NO
              AND
              CP_CODE=M_SELL_PORTFOLIO_CODE;

           IF SQL%NOTFOUND THEN
    --RAISE_APPLICATION_ERROR(-20201,M_FEEAMO2||' '||M_VAL1);
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
                     M_SELL_PORTFOLIO_CODE,
                     M_BCODE2,
                     M_BRAGE2,
                     M_SEL_BBASE2,
                     M_SEL_FEETYPE2,
                     M_FEEAMO2,
                     M_VAL2,
                     M_TOTAMOU2
              );
           END IF;
       END IF;
       /*SVA ON 30-08-2003 VC-03/058*/
       /*IF  M_SELECT_TYPE='SUB2' AND M_DEAL_TYPE ='DEBT'  THEN
        DN_CHECK_FIGURES_OR(M_DEAL_NO,'2');
       END IF;/*/
       /*30-08-2003 VC-03/058*/
       COMMIT;
   END IF;
   --If the data type is incorrect then delete the records from the relavent tables


/*EXCEPTION
   WHEN OTHERS THEN


    ROLLBACK;

    DELETE DN_TRN_DEAL_CURRENCY
    WHERE
    DEAL_NO=M_DEAL_NO;


    DELETE DN_TRN_OUTP_SALE
    WHERE
    DEAL_NO=M_DEAL_NO;



    err_num :=  substr(SQLCODE,1,15);
   err_msg := substr(SQLERRM,1,200) ;
  INSERT INTO DN_REF_SEQUENCE_LOG VALUES (M_DEAL_NO,err_num||''||err_msg,'ERROR IN OUTRIGHT2',SYSDATE);
  COMMIT;
 RAISE_APPLICATION_ERROR(-20201,SQLCODE||SQLERRM);
*/

END MBFSL_OUTRIGHT_IN2_PF;

/
