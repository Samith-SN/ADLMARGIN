--------------------------------------------------------
--  DDL for Procedure MBFSL_BORROLEND_IN1
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_BORROLEND_IN1" (
    M_DEAL_NO  IN OUT      DN_TRN_BL_FUND.DEAL_NO%TYPE,
    M_BORR_PORTFOLIO_CODE  DN_TRN_BL_FUND.BORR_PORTFOLIO_CODE%TYPE,
    M_LEND_PORTFOLIO_CODE  DN_TRN_BL_FUND.LEND_PORTFOLIO_CODE%TYPE,
    M_CURRENCY             DN_TRN_BL_FUND.CURR_CODE%TYPE,
    M_YIELD_NET            DN_TRN_BL_FUND.YEILD_PER_NET%TYPE,
    M_VALUE_DATE_TYPE      DN_TRN_BL_FUND.EFF_VALDATE_TYPE%TYPE,
    M_VALUE_DATE           CHAR,
    M_YIELD_NSL            DN_TRN_BL_FUND.YEILD_PER_NSLTT%TYPE,
    M_MAT_DATE             CHAR,
    M_LEG1                 DN_TRN_BL_FUND.LEG1_VALUE%TYPE,
    M_LEG2                 DN_TRN_BL_FUND.LEG2_VALUE%TYPE,
    M_TENOR                DN_TRN_BL_FUND.TENOR%TYPE,
    M_B_CODE               CHAR,
    M_INTEREST             DN_TRN_BL_FUND.INT_AMOUNT%TYPE,
    M_INSTRUMENT           DN_TRN_BL_FUND_INST.INST_TYPE%TYPE,
    M_HAIR_CUT             DN_TRN_BL_FUND_INST.RPTRN_HCUT_PER%TYPE,
    M_SECURITY             DN_TRN_BL_FUND.SEC_ALW_LENDER%TYPE,
    M_PHYSICAL             DN_TRN_BL_FUND.PHYSICAL_DELIVERY%TYPE,
    M_EXCHANGEABILITY      DN_TRN_BL_FUND.EXCHANGE_SEC%TYPE,
    M_SECURITY_ID          DN_TRN_BL_FUND_SEC.SECURITY_CODE%TYPE,
    M_ENDORSER             DN_TRN_BL_FUND_SEC.ENDOSER_CODE%TYPE,
    M_FACE_VALUE           DN_TRN_BL_FUND_SEC.FACE_VALUE%TYPE,
    M_HAIR_CUT_VAL         DN_TRN_BL_FUND_SEC.FVAL_WITH_HAIR_CUT%TYPE,
    M_SERIAL_NO            DN_TRN_BL_FUND_SERIAL_NO.SERIAL_NO%TYPE,
    M_INV_CODE1            CHAR,
    M_PREV_DEAL_NO         DN_TRN_BL_FUND_SERIAL_NO.PREV_DEAL_NO%TYPE,
    M_USERNAME             DN_TRN_BL_FUND.DN_USER%TYPE,
    M_SELECT_TYPE          CHAR,
    M_DEAL_NUMBER          DN_TRN_BL_FUND.DEAL_NO%TYPE
)
AS

   M_USER            DN_TRN_BL_FUND.DN_USER%TYPE;
   M_VAL_DATE        DN_TRN_BL_FUND.EFF_VALDATE%TYPE;
   M_MATU_DATE       DN_TRN_BL_FUND.MATURITY_DATE%TYPE;
   M_BASIS           DN_TRN_BL_FUND.INT_RATE_BASE_CODE%TYPE;
   M_INST_TYPE       DN_TRN_BL_FUND_INST.INST_TYPE%TYPE;
   M_HCUT_PER        DN_TRN_BL_FUND_INST.RPTRN_HCUT_PER%TYPE;
   M_INV_CODE        DN_TRN_BL_FUND_INST.INV_CODE%TYPE;
   MM_CURRENCY_VALUE  DN_REF_EXCHANGE_RATES.CURRENCY_VALUE%TYPE;--CURRENCY

BEGIN

    --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO);

    -- PROCEDURE  -  TO INSERT BORROW LEND FUNDS DETAILS
    -- SYSTEM     -  MBFSL SYSTEM
    -- CREATED BY -  V.THILAKESAN.
    -- CREATED ON -  14/07/1999
    -- MODIFIED BY -  V.SUKATHIS. TO ACTIVAT LIMITS PROCEDURES
    -- MODIFIED ON -  27/1/2000

    IF SUBSTR(M_USERNAME,1,1)=' ' OR M_USERNAME IS NULL THEN
       M_USER:='Un Identify';
    ELSE
       M_USER:=M_USERNAME;
    END IF;
    --To select the value date
    IF SUBSTR(M_VALUE_DATE_TYPE,1,2)<>'UD' THEN
       SELECT DN_FIN_EFF_VALDATE(M_VALUE_DATE_TYPE) INTO M_VAL_DATE FROM DUAL;
    ELSE
       SELECT TO_DATE(M_VALUE_DATE,'DD/MM/YYYY') INTO M_VAL_DATE FROM DUAL;
    END IF;

    --To select the maturity date
    SELECT
      TO_DATE(M_MAT_DATE,'DD/MM/YYYY')
    INTO
      M_MATU_DATE
    FROM DUAL;
    --To select the base code
    SELECT
      INT_RATE_BASE_CODE
    INTO
      M_BASIS
    FROM DN_REF_INTR_BASE
    WHERE INTR_BASE_DESC=M_B_CODE;
    --Creating new sequence
    IF M_DEAL_NUMBER IS NULL THEN
       SELECT TO_CHAR(SYSDATE,'YYYY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_BL_FUND.NEXTVAL),3,'0') INTO M_DEAL_NO FROM DUAL;
       M_DEAL_NO:=  'BF'||M_DEAL_NO;
    ELSE
       M_DEAL_NO:=M_DEAL_NUMBER;
    END IF;

    IF M_DEAL_NO IS NOT NULL AND M_SELECT_TYPE='MAIN1' THEN
IF M_CURRENCY<>'SLR' THEN --CURRENCY
------------------------------------------------CURRENCY
SELECT  CURRENCY_VALUE
INTO    MM_CURRENCY_VALUE
FROM    DN_REF_EXCHANGE_RATES
WHERE   CURR_CODE=M_CURRENCY;

 INSERT INTO DN_TRN_DEAL_CURRENCY
  (DEAL_NO,LEG1_VALUE,LEG2_VALUE,CURR_CODE)
 VALUES
  (M_DEAL_NO,M_LEG1,M_LEG2,M_CURRENCY);
------------------------------------------------CURRENCY
UPDATE DN_TRN_BL_FUND
       SET BORR_PORTFOLIO_CODE=M_BORR_PORTFOLIO_CODE,
           LEND_PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE,
           SEC_ALW_LENDER     =M_SECURITY,
           PHYSICAL_DELIVERY  =M_PHYSICAL,
           EXCHANGE_SEC       =M_EXCHANGEABILITY,
           CURR_CODE          =M_CURRENCY,
           EFF_VALDATE_TYPE   =M_VALUE_DATE_TYPE,
           EFF_VALDATE        =M_VAL_DATE,
           MATURITY_DATE      =M_MATU_DATE,
           TENOR              =M_TENOR,
           INT_RATE_BASE_CODE =M_BASIS,
           YEILD_PER_NET      =M_YIELD_NET,
           YEILD_PER_NSLTT    =M_YIELD_NSL,
           LEG1_VALUE         =M_LEG1*MM_CURRENCY_VALUE,--CURRENCY
           LEG2_VALUE         =M_LEG2*MM_CURRENCY_VALUE,--CURRENCY
           INT_AMOUNT         =M_INTEREST*MM_CURRENCY_VALUE,--CURRENCY
           DN_USER            =M_USER
       WHERE
           DEAL_NO=M_DEAL_NO
           AND
           APP_STATUS='ENT';

       --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||'-'||M_BORR_PORTFOLIO_CODE||'-'||M_LEND_PORTFOLIO_CODE||'-'||M_SECURITY||'-'||M_PHYSICAL||'-'||M_EXCHANGEABILITY||'-'||M_CURRENCY||'-'||M_BASIS||'-'||M_VALUE_DATE_TYPE||'-'||M_VAL_DATE||'-'||M_YIELD_NET||'-'||M_YIELD_NSL||'-'||M_LEG1||'-'||M_LEG2||'-'||M_MATU_DATE||'-'||M_TENOR||'-'||M_INTEREST||'-'||M_USER);

       IF SQL%NOTFOUND THEN
          INSERT INTO DN_TRN_BL_FUND
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
           YEILD_PER_NET,
           YEILD_PER_NSLTT,
           LEG1_VALUE,
           LEG2_VALUE,
           MATURITY_DATE,
           TENOR,
           INT_AMOUNT,
           DN_USER)
           VALUES(
             M_DEAL_NO,
             M_BORR_PORTFOLIO_CODE,
             M_LEND_PORTFOLIO_CODE,
             M_SECURITY,
             M_PHYSICAL,
             M_EXCHANGEABILITY,
             M_CURRENCY,
             M_BASIS,
             M_VALUE_DATE_TYPE,
             M_VAL_DATE,
             M_YIELD_NET,
             M_YIELD_NSL,
             M_LEG1*MM_CURRENCY_VALUE,--CURRENCY
             M_LEG2*MM_CURRENCY_VALUE,--CURRENCY
             M_MATU_DATE,
             M_TENOR,
             M_INTEREST*MM_CURRENCY_VALUE,--CURRENCY
             M_USER
             );
            --ADDED FOR TIME LOG MANAGEMENT BY S.YASODHA
                INSERT INTO DN_TIME_LOG
          (SUS_REF_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            (
              M_DEAL_NO,
              M_USER,
              SYSDATE,
              'ENTERED'
           );
           --******************************
       END IF;



ELSE --CURRENCY
       UPDATE DN_TRN_BL_FUND
       SET BORR_PORTFOLIO_CODE=M_BORR_PORTFOLIO_CODE,
           LEND_PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE,
           SEC_ALW_LENDER     =M_SECURITY,
           PHYSICAL_DELIVERY  =M_PHYSICAL,
           EXCHANGE_SEC       =M_EXCHANGEABILITY,
           CURR_CODE          =M_CURRENCY,
           EFF_VALDATE_TYPE   =M_VALUE_DATE_TYPE,
           EFF_VALDATE        =M_VAL_DATE,
           MATURITY_DATE      =M_MATU_DATE,
           TENOR              =M_TENOR,
           INT_RATE_BASE_CODE =M_BASIS,
           YEILD_PER_NET      =M_YIELD_NET,
           YEILD_PER_NSLTT    =M_YIELD_NSL,
           LEG1_VALUE         =M_LEG1,
           LEG2_VALUE         =M_LEG2,
           INT_AMOUNT         =M_INTEREST,
           DN_USER            =M_USER
       WHERE
           DEAL_NO=M_DEAL_NO
           AND
           APP_STATUS='ENT';

       --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||'-'||M_BORR_PORTFOLIO_CODE||'-'||M_LEND_PORTFOLIO_CODE||'-'||M_SECURITY||'-'||M_PHYSICAL||'-'||M_EXCHANGEABILITY||'-'||M_CURRENCY||'-'||M_BASIS||'-'||M_VALUE_DATE_TYPE||'-'||M_VAL_DATE||'-'||M_YIELD_NET||'-'||M_YIELD_NSL||'-'||M_LEG1||'-'||M_LEG2||'-'||M_MATU_DATE||'-'||M_TENOR||'-'||M_INTEREST||'-'||M_USER);

       IF SQL%NOTFOUND THEN
          INSERT INTO DN_TRN_BL_FUND
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
           YEILD_PER_NET,
           YEILD_PER_NSLTT,
           LEG1_VALUE,
           LEG2_VALUE,
           MATURITY_DATE,
           TENOR,
           INT_AMOUNT,
           DN_USER)
           VALUES(
             M_DEAL_NO,
             M_BORR_PORTFOLIO_CODE,
             M_LEND_PORTFOLIO_CODE,
             M_SECURITY,
             M_PHYSICAL,
             M_EXCHANGEABILITY,
             M_CURRENCY,
             M_BASIS,
             M_VALUE_DATE_TYPE,
             M_VAL_DATE,
             M_YIELD_NET,
             M_YIELD_NSL,
             M_LEG1,
             M_LEG2,
             M_MATU_DATE,
             M_TENOR,
             M_INTEREST,
             M_USER
             );
            --ADDED FOR TIME LOG MANAGEMENT BY S.YASODHA
                INSERT INTO DN_TIME_LOG
          (SUS_REF_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            (
              M_DEAL_NO,
              M_USER,
              SYSDATE,
              'ENTERED'
           );
           --******************************
       END IF;
       END IF;--CURRENCY
        DN_LIMIT_TRN_OVRL_EXPO(M_DEAL_NO,'I');-- Modified by Sukathis
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

   IF M_DEAL_NO IS NOT NULL AND M_INSTRUMENT<>'NULL' AND M_SELECT_TYPE='MAIN2' THEN
      --IF M_INSTRUMENT IS NOT NULL AND M_INV_CODE IS NOT NULL THEN
      IF M_INSTRUMENT IS NOT NULL THEN

         UPDATE DN_TRN_BL_FUND_INST
         SET RPTRN_HCUT_PER=M_HAIR_CUT
         WHERE
             DEAL_NO=M_DEAL_NO
             AND
             INST_TYPE=M_INSTRUMENT;

         IF SQL%NOTFOUND THEN
             INSERT INTO DN_TRN_BL_FUND_INST
               (DEAL_NO,
                INST_TYPE,
                RPTRN_HCUT_PER)
             VALUES(M_DEAL_NO,
                    M_INSTRUMENT,
                    M_HAIR_CUT);
         END IF;
      END IF;
   END IF;
   IF M_DEAL_NO IS NOT NULL AND M_SECURITY_ID<>'NULL' AND M_FACE_VALUE>0 AND M_SELECT_TYPE='MAIN3' THEN
      IF M_SECURITY_ID IS NOT NULL AND M_INV_CODE IS NOT NULL THEN

     --RAISE_APPLICATION_ERROR(-20201,M_SECURITY_ID);

         SELECT INST_TYPE INTO M_INST_TYPE
         FROM DN_REF_SECURITY
         WHERE SECURITY_CODE =M_SECURITY_ID;

         SELECT MAX(RPTRN_HCUT_PER) INTO M_HCUT_PER
         FROM DN_TRN_BL_FUND_INST
         WHERE DEAL_NO=M_DEAL_NO;

         UPDATE DN_TRN_BL_FUND_INST
         SET RPTRN_HCUT_PER=M_HCUT_PER
         WHERE
             DEAL_NO=M_DEAL_NO
             AND
             INST_TYPE=M_INST_TYPE
             AND
             INV_CODE=M_INV_CODE;

         IF SQL%NOTFOUND THEN
             INSERT INTO DN_TRN_BL_FUND_INST
               (DEAL_NO,
                INST_TYPE,
                INV_CODE,
                RPTRN_HCUT_PER)
             VALUES(M_DEAL_NO,
                    M_INST_TYPE,
                    M_INV_CODE,
                    M_HCUT_PER);
         END IF;

         UPDATE DN_TRN_BL_FUND_SEC
         SET ENDOSER_CODE      =M_ENDORSER,
             FACE_VALUE        =M_FACE_VALUE,
             FVAL_WITH_HAIR_CUT=M_HAIR_CUT_VAL
         WHERE
             DEAL_NO       =M_DEAL_NO
             AND
             INST_TYPE     =M_INST_TYPE
             AND
             INV_CODE      =M_INV_CODE
             AND
             SECURITY_CODE =M_SECURITY_ID;
         IF SQL%NOTFOUND THEN
            INSERT INTO DN_TRN_BL_FUND_SEC
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
                   M_SECURITY_ID,
                   M_ENDORSER,
                   M_FACE_VALUE,
                   M_HAIR_CUT_VAL
            );
         END IF;
      END IF;
   END IF;
   IF M_DEAL_NO IS NOT NULL AND M_SELECT_TYPE='MAIN3' THEN
      IF M_SERIAL_NO IS NOT NULL AND M_INV_CODE IS NOT NULL THEN

         SELECT INST_TYPE INTO M_INST_TYPE
         FROM DN_REF_SECURITY
         WHERE SECURITY_CODE =M_SECURITY_ID;

         SELECT DISTINCT RPTRN_HCUT_PER INTO M_HCUT_PER
         FROM DN_TRN_BL_FUND_INST
         WHERE DEAL_NO = M_DEAL_NO;

         UPDATE DN_TRN_BL_FUND_INST
         SET RPTRN_HCUT_PER=M_HCUT_PER
         WHERE
             DEAL_NO=M_DEAL_NO
             AND
             INST_TYPE=M_INST_TYPE
             AND
             INV_CODE=M_INV_CODE;

         IF SQL%NOTFOUND THEN
             INSERT INTO DN_TRN_BL_FUND_INST
               (DEAL_NO,
                INST_TYPE,
                INV_CODE,
                RPTRN_HCUT_PER)
             VALUES(M_DEAL_NO,
                    M_INST_TYPE,
                    M_INV_CODE,
                    M_HCUT_PER);
         END IF;

         UPDATE DN_TRN_BL_FUND_SEC
         SET ENDOSER_CODE      =M_ENDORSER,
             FACE_VALUE        =M_FACE_VALUE--,
             --FVAL_WITH_HAIR_CUT=M_HAIR_CUT_VAL
         WHERE
             DEAL_NO       =M_DEAL_NO
             AND
             INST_TYPE     =M_INST_TYPE
             AND
             INV_CODE      =M_INV_CODE
             AND
             SECURITY_CODE =M_SECURITY_ID;
         IF SQL%NOTFOUND THEN
            INSERT INTO DN_TRN_BL_FUND_SEC
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
                   M_SECURITY_ID,
                   M_ENDORSER,
                   M_FACE_VALUE,
                   M_HAIR_CUT_VAL
            );
         END IF;

         UPDATE DN_TRN_BL_FUND_SERIAL_NO
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
             SECURITY_CODE=M_SECURITY_ID
             AND
             SERIAL_NO=M_SERIAL_NO;

         IF SQL%NOTFOUND THEN
            INSERT INTO DN_TRN_BL_FUND_SERIAL_NO
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
                   M_SECURITY_ID,
                   M_SERIAL_NO,
                   M_FACE_VALUE,
                   M_BORR_PORTFOLIO_CODE,
                   M_PREV_DEAL_NO);
         END IF;
      END IF;
   END IF;

   COMMIT;
    --If the data type is incorrect then delete the records from the relavent tables

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

END MBFSL_BORROLEND_IN1;

/
