--------------------------------------------------------
--  DDL for Procedure MBFSL_REPOROLLOVER_UP1_CDT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_REPOROLLOVER_UP1_CDT" (
    M_DEAL_NO  IN OUT    DN_TRN_REPO_ROLLOVER.DEAL_NO%TYPE,
    M_PRIOR_DEAL_NO      DN_TRN_REPO_ROLLOVER.PRIOR_DEAL_NO%TYPE,
    M_BORROWER_CODE      DN_TRN_REPO_ROLLOVER.BORR_PORTFOLIO_CODE%TYPE,
    M_LENDER_CODE        DN_TRN_REPO_ROLLOVER.LEND_PORTFOLIO_CODE%TYPE,
    M_INSTRUMENT         DN_TRN_REPO_ROLLOVER_INST.INST_TYPE%TYPE,
    M_HAIR_CUT           DN_TRN_REPO_ROLLOVER_INST.RPTRN_HCUT_PER%TYPE,
    M_SECURITY           DN_TRN_REPO_ROLLOVER.SEC_ALW_LENDER%TYPE,
    M_PHYSICAL           DN_TRN_REPO_ROLLOVER.PHYSICAL_DELIVERY%TYPE,
    M_EXCHANGEABILITY    DN_TRN_REPO_ROLLOVER.EXCHANGE_SEC%TYPE,
    M_CURRENCY           DN_TRN_REPO_ROLLOVER.CURR_CODE%TYPE,
    M_B_CODE             CHAR,
    M_VALUE_DATE_TYPE    DN_TRN_REPO_ROLLOVER.EFF_VALDATE_TYPE%TYPE,
    M_VALUE_DATE         CHAR,
    M_YIELD              DN_TRN_REPO_ROLLOVER.YEILD%TYPE,
    M_ON_CALL            DN_TRN_REPO_ROLLOVER.ON_CALL_DEAL%TYPE,
    M_LEG1               DN_TRN_REPO_ROLLOVER.LEG1_VALUE%TYPE,
    M_LEG2               DN_TRN_REPO_ROLLOVER.LEG2_VALUE%TYPE,
    M_MAT_DATE           CHAR,
    M_TENOR              DN_TRN_REPO_ROLLOVER.TENOR%TYPE,
    M_INTEREST           DN_TRN_REPO_ROLLOVER.INT_AMOUNT%TYPE,
    M_PAY_TO_BORR        DN_TRN_REPO_ROLLOVER.PAYMENT_TO_BORR%TYPE,
    M_PAY_TO_LEND        DN_TRN_REPO_ROLLOVER.PAYMENT_TO_LEND%TYPE,
    M_USERNAME           DN_TRN_REPO_ROLLOVER.DN_USER%TYPE,
    M_SELECT_TYPE        CHAR,
    M_DEAL_NUMBER        DN_TRN_REPO_ROLLOVER.DEAL_NO%TYPE,
    M_TYPE               CHAR,
    M_CUST               CHAR,
    M_SCRIPT_STATUS      DN_TRN_REPO_ROLLOVER.SCRIPT_STATUS%TYPE
)

AS

   M_USER            DN_TRN_REPO_ROLLOVER.DN_USER%TYPE;
   M_VAL_DATE        DN_TRN_REPO_ROLLOVER.EFF_VALDATE%TYPE;
   M_MATU_DATE       DN_TRN_REPO_ROLLOVER.MATURITY_DATE%TYPE;
   M_BASIS           DN_TRN_REPO_ROLLOVER.INT_RATE_BASE_CODE%TYPE;
MM_CURRENCY_VALUE  DN_REF_EXCHANGE_RATES.CURRENCY_VALUE%TYPE;--CURRENCY

BEGIN

DN_VALIDATE_SAVE_RIGHTS(M_USERNAME,'WD_Complete_Deal_Ticket'); --added by ashini on 31/10/2005 for sr0509-047


    --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO);

    -- PROCEDURE  -  TO UPDATE REPOS ROLLOVER DETAILS
    -- SYSTEM     -  MBFSL SYSTEM
    -- CREATED BY -  V.THILAKESAN.
    -- CREATED ON -  19/08/1999

    --Format the value date type
    SELECT
      TO_DATE(M_VALUE_DATE,'DD/MM/YYYY')
    INTO
      M_VAL_DATE
    FROM DUAL;
    --Format the maturity date type
    SELECT
      TO_DATE(M_MAT_DATE,'DD/MM/YYYY')
    INTO
      M_MATU_DATE
    FROM DUAL;
    --Select the base code
    SELECT
      INT_RATE_BASE_CODE
    INTO
      M_BASIS
    FROM DN_REF_INTR_BASE
    WHERE INTR_BASE_DESC=M_B_CODE;

 IF M_DEAL_NO IS NOT NULL AND M_SELECT_TYPE='MAIN1' THEN
IF M_CURRENCY<>'SLR' THEN --CURRENCY
------------------------------------------------CURRENCY
SELECT  CURRENCY_VALUE
INTO    MM_CURRENCY_VALUE
FROM    DN_REF_EXCHANGE_RATES
WHERE   CURR_CODE=M_CURRENCY;

/* INSERT INTO DN_TRN_DEAL_CURRENCY
  (DEAL_NO,LEG1_VALUE,LEG2_VALUE,CURR_CODE)
 VALUES
  (M_DEAL_NO,M_LEG1,M_LEG2,M_CURRENCY);*/

  UPDATE DN_TRN_DEAL_CURRENCY
SET    LEG1_VALUE=M_LEG1,
       LEG2_VALUE=M_LEG2,
       CURR_CODE=M_CURRENCY,
       PAYTO_LENDER=M_PAY_TO_LEND,
       PAYTO_BORR=M_PAY_TO_BORR
WHERE  DEAL_NO=M_DEAL_NO;

------------------------------------------------CURRENCY
  IF  M_TYPE='MOD1'   THEN
       UPDATE DN_TRN_REPO_ROLLOVER
       SET PRIOR_DEAL_NO      =M_PRIOR_DEAL_NO,
           BORR_PORTFOLIO_CODE=M_BORROWER_CODE,
           LEND_PORTFOLIO_CODE=M_LENDER_CODE,
           SEC_ALW_LENDER     =M_SECURITY,
           PHYSICAL_DELIVERY  =M_PHYSICAL,
           EXCHANGE_SEC       =M_EXCHANGEABILITY,
           CURR_CODE          =M_CURRENCY,
           INT_RATE_BASE_CODE =M_BASIS,
           EFF_VALDATE_TYPE   =M_VALUE_DATE_TYPE,
           EFF_VALDATE        =M_VAL_DATE,
           YEILD              =M_YIELD,
           ON_CALL_DEAL       =M_ON_CALL,
           LEG1_VALUE         =M_LEG1*MM_CURRENCY_VALUE,--CURRENCY
           LEG2_VALUE         =M_LEG2*MM_CURRENCY_VALUE,--CURRENCY
           MATURITY_DATE      =M_MATU_DATE,
           TENOR              =M_TENOR,
           INT_AMOUNT         =M_INTEREST*MM_CURRENCY_VALUE,--CURRENCY
           PAYMENT_TO_BORR    =M_PAY_TO_BORR*MM_CURRENCY_VALUE,--CURRENCY
           PAYMENT_TO_LEND    =M_PAY_TO_LEND*MM_CURRENCY_VALUE,--CURRENCY
           DN_USER            =M_USERNAME,
           APP_STATUS         ='APPRO2'
       WHERE
           DEAL_NO=M_DEAL_NO AND
           SCRIPT_STATUS=M_SCRIPT_STATUS AND APP_STATUS         ='APPRO2';

     --ADDED FOR TIME LOG MANAGEMENT BY S.YASODHA

            --IF M_TYPE='MOD1' THEN
            INSERT INTO DN_TIME_LOG
            (SUS_REF_NO,
            DN_USER,
            ENT_DATE,
            DESCRIPTION)
            VALUES
            (
             M_DEAL_NO,
             M_USERNAME,
             SYSDATE,
             'COMPLETE DEAL TICKET'
           );
           --*******************************

      --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||'-'||M_PRIOR_DEAL_NO||'-'||M_BORROWER_CODE||'-'||M_LENDER_CODE||'-'||M_SECURITY||'-'||M_PHYSICAL||'-'||M_EXCHANGEABILITY||'-'||M_CURRENCY||'-'||M_BASIS||'-'||M_VALUE_DATE_TYPE||'-'||M_VAL_DATE||'-'||M_YIELD||'-'||M_ON_CALL||'-'||M_LEG1||'-'||M_LEG2||'-'||M_MATU_DATE||'-'||M_TENOR||'-'||M_INTEREST||'-'||M_PAY_TO_BORR||'-'||M_PAY_TO_LEND||'-'||M_USER);

       IF SQL%NOTFOUND THEN
          INSERT INTO DN_TRN_REPO_ROLLOVER
          (DEAL_NO,
           PRIOR_DEAL_NO,
           BORR_PORTFOLIO_CODE,
           LEND_PORTFOLIO_CODE,
           SEC_ALW_LENDER,
           PHYSICAL_DELIVERY,
           EXCHANGE_SEC,
           CURR_CODE,
           INT_RATE_BASE_CODE,
           EFF_VALDATE_TYPE,
           EFF_VALDATE,
           YEILD,
           ON_CALL_DEAL,
           LEG1_VALUE,
           LEG2_VALUE,
           MATURITY_DATE,
           TENOR,
           INT_AMOUNT,
           PAYMENT_TO_BORR,
           PAYMENT_TO_LEND,
           DN_USER,
           APP_STATUS,
           SCRIPT_STATUS)
           VALUES(
             M_DEAL_NO,
             M_PRIOR_DEAL_NO,
             M_BORROWER_CODE,
             M_LENDER_CODE,
             M_SECURITY,
             M_PHYSICAL,
             M_EXCHANGEABILITY,
             M_CURRENCY,
             M_BASIS,
             M_VALUE_DATE_TYPE,
             M_VAL_DATE,
             M_YIELD,
             M_ON_CALL,
             M_LEG1*MM_CURRENCY_VALUE,--CURRENCY
             M_LEG2*MM_CURRENCY_VALUE,--CURRENCY
             M_MATU_DATE,
             M_TENOR,
             M_INTEREST*MM_CURRENCY_VALUE,--CURRENCY
             M_PAY_TO_BORR*MM_CURRENCY_VALUE,--CURRENCY
             M_PAY_TO_LEND*MM_CURRENCY_VALUE,--CURRENCY
             M_USERNAME,
             'APPRO2',
             M_SCRIPT_STATUS);
       END IF;

  ELSE
        UPDATE DN_TRN_REPO_ROLLOVER
       SET PRIOR_DEAL_NO      =M_PRIOR_DEAL_NO,
           BORR_PORTFOLIO_CODE=M_BORROWER_CODE,
           LEND_PORTFOLIO_CODE=M_LENDER_CODE,
           SEC_ALW_LENDER     =M_SECURITY,
           PHYSICAL_DELIVERY  =M_PHYSICAL,
           EXCHANGE_SEC       =M_EXCHANGEABILITY,
           CURR_CODE          =M_CURRENCY,
           INT_RATE_BASE_CODE =M_BASIS,
           EFF_VALDATE_TYPE   =M_VALUE_DATE_TYPE,
           EFF_VALDATE        =M_VAL_DATE,
           YEILD              =M_YIELD,
           ON_CALL_DEAL       =M_ON_CALL,
           LEG1_VALUE         =M_LEG1*MM_CURRENCY_VALUE,--CURRENCY
           LEG2_VALUE         =M_LEG2*MM_CURRENCY_VALUE,--CURRENCY
           MATURITY_DATE      =M_MATU_DATE,
           TENOR              =M_TENOR,
           INT_AMOUNT         =M_INTEREST*MM_CURRENCY_VALUE,--CURRENCY
           PAYMENT_TO_BORR    =M_PAY_TO_BORR*MM_CURRENCY_VALUE,--CURRENCY
           PAYMENT_TO_LEND    =M_PAY_TO_LEND*MM_CURRENCY_VALUE,--CURRENCY
           DN_USER            =M_USERNAME,
           APP_STATUS         ='ENT'
       WHERE
           DEAL_NO=M_DEAL_NO AND
           SCRIPT_STATUS=M_SCRIPT_STATUS;

     --ADDED FOR TIME LOG MANAGEMENT BY S.YASODHA

            INSERT INTO DN_TIME_LOG
            (SUS_REF_NO,
            DN_USER,
            ENT_DATE,
            DESCRIPTION)
            VALUES
            (
             M_DEAL_NO,
             M_USERNAME,
             SYSDATE,
             'MODIFICATION'
           );

--*******************************

      --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||'-'||M_PRIOR_DEAL_NO||'-'||M_BORROWER_CODE||'-'||M_LENDER_CODE||'-'||M_SECURITY||'-'||M_PHYSICAL||'-'||M_EXCHANGEABILITY||'-'||M_CURRENCY||'-'||M_BASIS||'-'||M_VALUE_DATE_TYPE||'-'||M_VAL_DATE||'-'||M_YIELD||'-'||M_ON_CALL||'-'||M_LEG1||'-'||M_LEG2||'-'||M_MATU_DATE||'-'||M_TENOR||'-'||M_INTEREST||'-'||M_PAY_TO_BORR||'-'||M_PAY_TO_LEND||'-'||M_USER);

       IF SQL%NOTFOUND THEN
          INSERT INTO DN_TRN_REPO_ROLLOVER
          (DEAL_NO,
           PRIOR_DEAL_NO,
           BORR_PORTFOLIO_CODE,
           LEND_PORTFOLIO_CODE,
           SEC_ALW_LENDER,
           PHYSICAL_DELIVERY,
           EXCHANGE_SEC,
           CURR_CODE,
           INT_RATE_BASE_CODE,
           EFF_VALDATE_TYPE,
           EFF_VALDATE,
           YEILD,
           ON_CALL_DEAL,
           LEG1_VALUE,
           LEG2_VALUE,
           MATURITY_DATE,
           TENOR,
           INT_AMOUNT,
           PAYMENT_TO_BORR,
           PAYMENT_TO_LEND,
           DN_USER,
           APP_STATUS,
           SCRIPT_STATUS)
           VALUES(
             M_DEAL_NO,
             M_PRIOR_DEAL_NO,
             M_BORROWER_CODE,
             M_LENDER_CODE,
             M_SECURITY,
             M_PHYSICAL,
             M_EXCHANGEABILITY,
             M_CURRENCY,
             M_BASIS,
             M_VALUE_DATE_TYPE,
             M_VAL_DATE,
             M_YIELD,
             M_ON_CALL,
             M_LEG1*MM_CURRENCY_VALUE,--CURRENCY
             M_LEG2*MM_CURRENCY_VALUE,--CURRENCY
             M_MATU_DATE,
             M_TENOR,
             M_INTEREST*MM_CURRENCY_VALUE,--CURRENCY
             M_PAY_TO_BORR*MM_CURRENCY_VALUE,--CURRENCY
             M_PAY_TO_LEND*MM_CURRENCY_VALUE,--CURRENCY
             M_USERNAME,
             'ENT',
             M_SCRIPT_STATUS);
       END IF;
   END IF;













ELSE--CURRENCY
     IF  M_TYPE='MOD1'   THEN
       UPDATE DN_TRN_REPO_ROLLOVER
       SET PRIOR_DEAL_NO      =M_PRIOR_DEAL_NO,
           BORR_PORTFOLIO_CODE=M_BORROWER_CODE,
           LEND_PORTFOLIO_CODE=M_LENDER_CODE,
           SEC_ALW_LENDER     =M_SECURITY,
           PHYSICAL_DELIVERY  =M_PHYSICAL,
           EXCHANGE_SEC       =M_EXCHANGEABILITY,
           CURR_CODE          =M_CURRENCY,
           INT_RATE_BASE_CODE =M_BASIS,
           EFF_VALDATE_TYPE   =M_VALUE_DATE_TYPE,
           EFF_VALDATE        =M_VAL_DATE,
           YEILD              =M_YIELD,
           ON_CALL_DEAL       =M_ON_CALL,
           LEG1_VALUE         =M_LEG1,
           LEG2_VALUE         =M_LEG2,
           MATURITY_DATE      =M_MATU_DATE,
           TENOR              =M_TENOR,
           INT_AMOUNT         =M_INTEREST,
           PAYMENT_TO_BORR    =M_PAY_TO_BORR,
           PAYMENT_TO_LEND    =M_PAY_TO_LEND,
           DN_USER            =M_USERNAME,
           APP_STATUS         ='APPRO2'
       WHERE
           DEAL_NO=M_DEAL_NO AND
           SCRIPT_STATUS=M_SCRIPT_STATUS AND APP_STATUS         ='APPRO2';

     --ADDED FOR TIME LOG MANAGEMENT BY S.YASODHA

            --IF M_TYPE='MOD1' THEN
            INSERT INTO DN_TIME_LOG
            (SUS_REF_NO,
            DN_USER,
            ENT_DATE,
            DESCRIPTION)
            VALUES
            (
             M_DEAL_NO,
             M_USERNAME,
             SYSDATE,
             'COMPLETE DEAL TICKET'
           );
           --*******************************

      --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||'-'||M_PRIOR_DEAL_NO||'-'||M_BORROWER_CODE||'-'||M_LENDER_CODE||'-'||M_SECURITY||'-'||M_PHYSICAL||'-'||M_EXCHANGEABILITY||'-'||M_CURRENCY||'-'||M_BASIS||'-'||M_VALUE_DATE_TYPE||'-'||M_VAL_DATE||'-'||M_YIELD||'-'||M_ON_CALL||'-'||M_LEG1||'-'||M_LEG2||'-'||M_MATU_DATE||'-'||M_TENOR||'-'||M_INTEREST||'-'||M_PAY_TO_BORR||'-'||M_PAY_TO_LEND||'-'||M_USER);

       IF SQL%NOTFOUND THEN
          INSERT INTO DN_TRN_REPO_ROLLOVER
          (DEAL_NO,
           PRIOR_DEAL_NO,
           BORR_PORTFOLIO_CODE,
           LEND_PORTFOLIO_CODE,
           SEC_ALW_LENDER,
           PHYSICAL_DELIVERY,
           EXCHANGE_SEC,
           CURR_CODE,
           INT_RATE_BASE_CODE,
           EFF_VALDATE_TYPE,
           EFF_VALDATE,
           YEILD,
           ON_CALL_DEAL,
           LEG1_VALUE,
           LEG2_VALUE,
           MATURITY_DATE,
           TENOR,
           INT_AMOUNT,
           PAYMENT_TO_BORR,
           PAYMENT_TO_LEND,
           DN_USER,
           APP_STATUS,
           SCRIPT_STATUS)
           VALUES(
             M_DEAL_NO,
             M_PRIOR_DEAL_NO,
             M_BORROWER_CODE,
             M_LENDER_CODE,
             M_SECURITY,
             M_PHYSICAL,
             M_EXCHANGEABILITY,
             M_CURRENCY,
             M_BASIS,
             M_VALUE_DATE_TYPE,
             M_VAL_DATE,
             M_YIELD,
             M_ON_CALL,
             M_LEG1,
             M_LEG2,
             M_MATU_DATE,
             M_TENOR,
             M_INTEREST,
             M_PAY_TO_BORR,
             M_PAY_TO_LEND,
             M_USERNAME,
             'APPRO2',
             M_SCRIPT_STATUS);
       END IF;

  ELSE
        UPDATE DN_TRN_REPO_ROLLOVER
       SET PRIOR_DEAL_NO      =M_PRIOR_DEAL_NO,
           BORR_PORTFOLIO_CODE=M_BORROWER_CODE,
           LEND_PORTFOLIO_CODE=M_LENDER_CODE,
           SEC_ALW_LENDER     =M_SECURITY,
           PHYSICAL_DELIVERY  =M_PHYSICAL,
           EXCHANGE_SEC       =M_EXCHANGEABILITY,
           CURR_CODE          =M_CURRENCY,
           INT_RATE_BASE_CODE =M_BASIS,
           EFF_VALDATE_TYPE   =M_VALUE_DATE_TYPE,
           EFF_VALDATE        =M_VAL_DATE,
           YEILD              =M_YIELD,
           ON_CALL_DEAL       =M_ON_CALL,
           LEG1_VALUE         =M_LEG1,
           LEG2_VALUE         =M_LEG2,
           MATURITY_DATE      =M_MATU_DATE,
           TENOR              =M_TENOR,
           INT_AMOUNT         =M_INTEREST,
           PAYMENT_TO_BORR    =M_PAY_TO_BORR,
           PAYMENT_TO_LEND    =M_PAY_TO_LEND,
           DN_USER            =M_USERNAME,
           APP_STATUS         ='ENT'
       WHERE
           DEAL_NO=M_DEAL_NO AND
           SCRIPT_STATUS=M_SCRIPT_STATUS;

     --ADDED FOR TIME LOG MANAGEMENT BY S.YASODHA

            INSERT INTO DN_TIME_LOG
            (SUS_REF_NO,
            DN_USER,
            ENT_DATE,
            DESCRIPTION)
            VALUES
            (
             M_DEAL_NO,
             M_USERNAME,
             SYSDATE,
             'MODIFICATION'
           );

--*******************************

      --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||'-'||M_PRIOR_DEAL_NO||'-'||M_BORROWER_CODE||'-'||M_LENDER_CODE||'-'||M_SECURITY||'-'||M_PHYSICAL||'-'||M_EXCHANGEABILITY||'-'||M_CURRENCY||'-'||M_BASIS||'-'||M_VALUE_DATE_TYPE||'-'||M_VAL_DATE||'-'||M_YIELD||'-'||M_ON_CALL||'-'||M_LEG1||'-'||M_LEG2||'-'||M_MATU_DATE||'-'||M_TENOR||'-'||M_INTEREST||'-'||M_PAY_TO_BORR||'-'||M_PAY_TO_LEND||'-'||M_USER);

       IF SQL%NOTFOUND THEN
          INSERT INTO DN_TRN_REPO_ROLLOVER
          (DEAL_NO,
           PRIOR_DEAL_NO,
           BORR_PORTFOLIO_CODE,
           LEND_PORTFOLIO_CODE,
           SEC_ALW_LENDER,
           PHYSICAL_DELIVERY,
           EXCHANGE_SEC,
           CURR_CODE,
           INT_RATE_BASE_CODE,
           EFF_VALDATE_TYPE,
           EFF_VALDATE,
           YEILD,
           ON_CALL_DEAL,
           LEG1_VALUE,
           LEG2_VALUE,
           MATURITY_DATE,
           TENOR,
           INT_AMOUNT,
           PAYMENT_TO_BORR,
           PAYMENT_TO_LEND,
           DN_USER,
           APP_STATUS,
           SCRIPT_STATUS)
           VALUES(
             M_DEAL_NO,
             M_PRIOR_DEAL_NO,
             M_BORROWER_CODE,
             M_LENDER_CODE,
             M_SECURITY,
             M_PHYSICAL,
             M_EXCHANGEABILITY,
             M_CURRENCY,
             M_BASIS,
             M_VALUE_DATE_TYPE,
             M_VAL_DATE,
             M_YIELD,
             M_ON_CALL,
             M_LEG1,
             M_LEG2,
             M_MATU_DATE,
             M_TENOR,
             M_INTEREST,
             M_PAY_TO_BORR,
             M_PAY_TO_LEND,
             M_USERNAME,
             'ENT',
             M_SCRIPT_STATUS);
       END IF;
   END IF;
END IF;--CURRENCY
   END IF;
   IF M_DEAL_NO IS NOT NULL AND M_INSTRUMENT<>'NULL' AND M_SELECT_TYPE='MAIN2' THEN
      IF M_INSTRUMENT IS NOT NULL THEN

         ---RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||'-'||M_INSTRUMENT||'-'||M_HAIR_CUT);

         UPDATE DN_TRN_REPO_ROLLOVER_INST
         SET RPTRN_HCUT_PER=M_HAIR_CUT
         WHERE
             DEAL_NO=M_DEAL_NO
             AND
             INST_TYPE=M_INSTRUMENT;
         IF SQL%NOTFOUND THEN
            INSERT INTO DN_TRN_REPO_ROLLOVER_INST
              (DEAL_NO,
               INST_TYPE,
               RPTRN_HCUT_PER)
            VALUES(M_DEAL_NO,
                   M_INSTRUMENT,
                   M_HAIR_CUT);
         END IF;
      END IF;
   END IF;
   COMMIT;
   --If the data type is incorrect then delete the records from the relavent tables

 EXCEPTION
  WHEN OTHERS THEN

    ROLLBACK;

    COMMIT;

    RAISE_APPLICATION_ERROR(-20201,'Cannot update records, because of incorrect data type.');


END MBFSL_REPOROLLOVER_UP1_CDT;

/
