--------------------------------------------------------
--  DDL for Procedure DN_PERIODIC_INTEREST_UP1
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_PERIODIC_INTEREST_UP1" (
    M_DEAL_NO  IN OUT    DN_TRN_REPO_PERIOD_INT.DEAL_NO%TYPE,
    M_BORROWER_CODE      DN_TRN_REPO_PERIOD_INT.BORR_PORTFOLIO_CODE%TYPE,
    M_LENDER_CODE        DN_TRN_REPO_PERIOD_INT.LEND_PORTFOLIO_CODE%TYPE,
    M_INSTRUMENT         DN_TRN_REPO_PERIOD_INT_INST.INST_TYPE%TYPE,
    M_HAIR_CUT           DN_TRN_REPO_PERIOD_INT_INST.RPTRN_HCUT_PER%TYPE,
    M_SECURITY           DN_TRN_REPO_PERIOD_INT.SEC_ALW_LENDER%TYPE,
    M_PHYSICAL           DN_TRN_REPO_PERIOD_INT.PHYSICAL_DELIVERY%TYPE,
    M_EXCHANGEABILITY    DN_TRN_REPO_PERIOD_INT.EXCHANGE_SEC%TYPE,
    M_CURRENCY           DN_TRN_REPO_PERIOD_INT.CURR_CODE%TYPE,
    M_B_CODE             CHAR,
    M_VALUE_DATE_TYPE    DN_TRN_REPO_PERIOD_INT.EFF_VALDATE_TYPE%TYPE,
    M_VALUE_DATE         CHAR,
    M_YIELD              DN_TRN_REPO_PERIOD_INT.YEILD%TYPE,
    M_LEG1               DN_TRN_REPO_PERIOD_INT.LEG1_VALUE%TYPE,
    M_LEG2               DN_TRN_REPO_PERIOD_INT.LEG2_VALUE%TYPE,
    M_MAT_DATE           CHAR,
    M_TENOR              DN_TRN_REPO_PERIOD_INT.TENOR%TYPE,
    M_PAY_FREQ           DN_TRN_REPO_PERIOD_INT.INT_PAY_FREQ%TYPE,
   -- M_PAY_RATE           DN_TRN_REPO_PERIOD_INT.INT_PAY_RATE%TYPE,
   -- M_CAP_AMOUNT         DN_TRN_REPO_PERIOD_INT.CHG_IN_CAP_AMOUNT%TYPE,
    M_USERNAME           DN_TRN_REPO_PERIOD_INT.DN_USER%TYPE,
    M_SELECT_TYPE        CHAR,
    M_DEAL_NUMBER        DN_TRN_REPO_PERIOD_INT.DEAL_NO%TYPE
)

AS

   M_USER            DN_TRN_REPO_PERIOD_INT.DN_USER%TYPE;
   M_VAL_DATE        DN_TRN_REPO_PERIOD_INT.EFF_VALDATE%TYPE;
   M_MATU_DATE       DN_TRN_REPO_PERIOD_INT.MATURITY_DATE%TYPE;
   M_BASIS           DN_TRN_REPO_PERIOD_INT.INT_RATE_BASE_CODE%TYPE;
MM_CURRENCY_VALUE  DN_REF_EXCHANGE_RATES.CURRENCY_VALUE%TYPE;--CURRENCY
BEGIN

    --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO);

    -- PROCEDURE  -  TO UPDATE REPO PERIOD INTEREST DETAILS
    -- SYSTEM     -  MBFSL SYSTEM
    -- CREATED BY -  V.THILAKESAN.
    -- CREATED ON -  14/04/2000


    --Select the value date
   /* IF M_VALUE_DATE_TYPE<>'UD' THEN
       SELECT DN_FIN_EFF_VALDATE(M_VALUE_DATE_TYPE) INTO M_VAL_DATE FROM DUAL;
    ELSE*/
       SELECT TO_DATE(M_VALUE_DATE,'DD/MM/YYYY') INTO M_VAL_DATE FROM DUAL;
    --END IF;
    --Select the maturity date
    SELECT TO_DATE(M_MAT_DATE,'DD/MM/YYYY') INTO M_MATU_DATE FROM DUAL;
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
       CURR_CODE=M_CURRENCY
WHERE  DEAL_NO=M_DEAL_NO;

------------------------------------------------CURRENCY
UPDATE DN_TRN_REPO_PERIOD_INT
       SET BORR_PORTFOLIO_CODE=M_BORROWER_CODE,
           LEND_PORTFOLIO_CODE=M_LENDER_CODE,
           SEC_ALW_LENDER     =M_SECURITY,
           PHYSICAL_DELIVERY  =M_PHYSICAL,
           EXCHANGE_SEC       =M_EXCHANGEABILITY,
           CURR_CODE          =M_CURRENCY,
           INT_RATE_BASE_CODE =M_BASIS,
           EFF_VALDATE_TYPE   =M_VALUE_DATE_TYPE,
           EFF_VALDATE        =M_VAL_DATE,
           YEILD              =M_YIELD,
           LEG1_VALUE         =M_LEG1*MM_CURRENCY_VALUE,--CURRENCY
           LEG2_VALUE         =M_LEG2*MM_CURRENCY_VALUE,--CURRENCY,
           MATURITY_DATE      =M_MATU_DATE,
           TENOR              =M_TENOR,
         --  INT_PAY_RATE       =M_PAY_RATE,
           INT_PAY_FREQ       =M_PAY_FREQ,
         -- CHG_IN_CAP_AMOUNT  =M_CAP_AMOUNT,
           DN_USER            =M_USERNAME,
           APP_STATUS         ='ENT'
       WHERE
           DEAL_NO=M_DEAL_NO;

       IF SQL%NOTFOUND THEN
          INSERT INTO DN_TRN_REPO_PERIOD_INT
          (DEAL_NO,
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
           LEG1_VALUE,
           LEG2_VALUE,
           MATURITY_DATE,
           TENOR,
          -- INT_PAY_RATE,
           INT_PAY_FREQ,
         --  CHG_IN_CAP_AMOUNT,
           DN_USER,
           APP_STATUS)
           VALUES(
             M_DEAL_NO,
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
             M_LEG1*MM_CURRENCY_VALUE,--CURRENCY,
             M_LEG2*MM_CURRENCY_VALUE,--CURRENCY,
             M_MATU_DATE,
             M_TENOR,
            -- M_PAY_RATE,
             M_PAY_FREQ,
           --  M_CAP_AMOUNT,
             M_USERNAME,
             'ENT');
       END IF;



ELSE --CURRENCY
       UPDATE DN_TRN_REPO_PERIOD_INT
       SET BORR_PORTFOLIO_CODE=M_BORROWER_CODE,
           LEND_PORTFOLIO_CODE=M_LENDER_CODE,
           SEC_ALW_LENDER     =M_SECURITY,
           PHYSICAL_DELIVERY  =M_PHYSICAL,
           EXCHANGE_SEC       =M_EXCHANGEABILITY,
           CURR_CODE          =M_CURRENCY,
           INT_RATE_BASE_CODE =M_BASIS,
           EFF_VALDATE_TYPE   =M_VALUE_DATE_TYPE,
           EFF_VALDATE        =M_VAL_DATE,
           YEILD              =M_YIELD,
           LEG1_VALUE         =M_LEG1,
           LEG2_VALUE         =M_LEG2,
           MATURITY_DATE      =M_MATU_DATE,
           TENOR              =M_TENOR,
         --  INT_PAY_RATE       =M_PAY_RATE,
           INT_PAY_FREQ       =M_PAY_FREQ,
         -- CHG_IN_CAP_AMOUNT  =M_CAP_AMOUNT,
           DN_USER            =M_USERNAME,
           APP_STATUS         ='ENT'
       WHERE
           DEAL_NO=M_DEAL_NO;

       IF SQL%NOTFOUND THEN
          INSERT INTO DN_TRN_REPO_PERIOD_INT
          (DEAL_NO,
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
           LEG1_VALUE,
           LEG2_VALUE,
           MATURITY_DATE,
           TENOR,
          -- INT_PAY_RATE,
           INT_PAY_FREQ,
         --  CHG_IN_CAP_AMOUNT,
           DN_USER,
           APP_STATUS)
           VALUES(
             M_DEAL_NO,
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
             M_LEG1,
             M_LEG2,
             M_MATU_DATE,
             M_TENOR,
            -- M_PAY_RATE,
             M_PAY_FREQ,
           --  M_CAP_AMOUNT,
             M_USERNAME,
             'ENT');
       END IF;
END IF;--CURRENCY
        DELETE DN_REF_RP_INST_PAY_FREQ
        WHERE DEAL_NO = M_DEAL_NO;

       DN_RP_INST_INSERT_PAYFREQ(M_DEAL_NO,TO_CHAR(M_VAL_DATE,'DD/MM/YYYY'),TO_CHAR(M_MATU_DATE,'DD/MM/YYYY'),M_PAY_FREQ);
  -----------   --------------------------  -------
   END IF;
   IF M_DEAL_NO IS NOT NULL AND M_INSTRUMENT<>'NULL' AND M_SELECT_TYPE='MAIN2' THEN
      IF M_INSTRUMENT IS NOT NULL THEN
         UPDATE DN_TRN_REPO_PERIOD_INT_INST
         SET RPTRN_HCUT_PER=M_HAIR_CUT
         WHERE
            DEAL_NO=M_DEAL_NO
            AND
            INST_TYPE=M_INSTRUMENT;

         IF SQL%NOTFOUND THEN
            INSERT INTO DN_TRN_REPO_PERIOD_INT_INST
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

    --RAISE_APPLICATION_ERROR(-20201,'Cannot update records, because of incorrect data type.');

END DN_PERIODIC_INTEREST_UP1;

/
