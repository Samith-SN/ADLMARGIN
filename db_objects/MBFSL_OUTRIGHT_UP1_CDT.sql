--------------------------------------------------------
--  DDL for Procedure MBFSL_OUTRIGHT_UP1_CDT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_OUTRIGHT_UP1_CDT" (
    M_DEAL_NO  IN OUT    DN_TRN_OUTP_SALE.DEAL_NO%TYPE,
  	M_BCODE              DN_TRN_OUTP_SALE.BUY_PORTFOLIO_CODE%TYPE,
    M_SCODE              DN_TRN_OUTP_SALE.SELL_PORTFOLIO_CODE%TYPE,
  	M_INSTYPE            DN_TRN_OUTP_SALE.INST_TYPE%TYPE,
	M_SECIDEN            DN_TRN_OUTP_SALE.SECURITY_CODE%TYPE,
	M_ENCODE             DN_TRN_OUTP_SALE.ENDOSER_CODE%TYPE,
	M_CURR               DN_TRN_OUTP_SALE.CURR_CODE%TYPE,
	M_SEL_DATETYPE       DN_TRN_OUTP_SALE.EFF_VALDATE_TYPE%TYPE,
	M_V_DATE             CHAR,
	M_B_CODE             CHAR,
	M_YIELD              DN_TRN_OUTP_SALE.YIELD%TYPE,
	M_SETVAL             DN_TRN_OUTP_SALE.SETTLE_VALUE%TYPE,
	M_CLEAN              DN_TRN_OUTP_SALE.PRICE_CLEAN%TYPE,
	M_FACEVAL            DN_TRN_OUTP_SALE.FACE_VALUE%TYPE,
	M_DIRTY              DN_TRN_OUTP_SALE.PRICE_DIRTY%TYPE,
	M_ACCINT             DN_TRN_OUTP_SALE.ACC_INT%TYPE,
	M_COST               DN_TRN_OUTP_SALE.COST%TYPE,
    M_USERNAME           DN_TRN_OUTP_SALE.DN_USER%TYPE,
    M_DEAL_NUMBER        DN_TRN_OUTP_SALE.DEAL_NO%TYPE,
    M_SCRIPT_STAT        DN_TRN_OUTP_SALE.SCRIPT_STATUS%TYPE,
    M_DEAL_TYPE          VARCHAR2,
    M_NOMALUE            DN_TRN_OUTP_SALE.NOMINAL_VALUE%TYPE,
    M_BUY_DATE           VARCHAR2,
    M_SEL_DATE           VARCHAR2

)

AS

   M_USER             DN_TRN_OUTP_SALE.DN_USER%TYPE;
   M_VAL_DATE         DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE;
   M_BASIS            DN_TRN_OUTP_SALE.INT_RATE_BASE_CODE%TYPE;
MM_CURRENCY_VALUE  DN_REF_EXCHANGE_RATES.CURRENCY_VALUE%TYPE;--CURRENCY

BEGIN


DN_VALIDATE_SAVE_RIGHTS(M_USERNAME,'WD_Complete_Deal_Ticket'); --added by ashini on 31/10/2005 for sr0509-047

IF M_DEAL_TYPE = 'DEBT'  THEN ----------------------------------------------1


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
       SELECT TO_DATE(M_V_DATE,'DD/MM/YYYY') INTO M_VAL_DATE FROM DUAL;
    SELECT
      INT_RATE_BASE_CODE
    INTO
      M_BASIS
    FROM DN_REF_INTR_BASE
    WHERE INTR_BASE_DESC=M_B_CODE;
IF M_DEAL_NO IS NOT NULL THEN


IF M_CURR<>'SLR' THEN --CURRENCY
------------------------------------------------CURRENCY
SELECT  CURRENCY_VALUE
INTO    MM_CURRENCY_VALUE
FROM    DN_REF_EXCHANGE_RATES
WHERE   CURR_CODE=M_CURR;



UPDATE DN_TRN_DEAL_CURRENCY
SET    LEG1_VALUE=M_COST,
       LEG2_VALUE=M_FACEVAL,
       CURR_CODE=M_CURR,
       ACC_INT=M_ACCINT
WHERE  DEAL_NO=M_DEAL_NO;

------------------------------------------------CURRENCY
 UPDATE DN_TRN_OUTP_SALE
       SET BUY_PORTFOLIO_CODE =M_BCODE,
           SELL_PORTFOLIO_CODE=M_SCODE,
  	       INST_TYPE          =M_INSTYPE,
	       SECURITY_CODE      =M_SECIDEN,
	       ENDOSER_CODE       =M_ENCODE,
	       CURR_CODE          =M_CURR,
	       EFF_VALDATE_TYPE   =M_SEL_DATETYPE,
	       EFF_VALDATE        =M_VAL_DATE,
	       INT_RATE_BASE_CODE =M_BASIS,
	       YIELD              =M_YIELD/100,   -- Modified by Pubudu
	       SETTLE_VALUE       =M_SETVAL,
	       PRICE_CLEAN        =M_CLEAN,
	       FACE_VALUE         =M_FACEVAL*MM_CURRENCY_VALUE,--CURRENCY
	       PRICE_DIRTY        =M_DIRTY,
	       ACC_INT            =M_ACCINT*MM_CURRENCY_VALUE,--CURRENCY
	       COST               =M_COST*MM_CURRENCY_VALUE,--CURRENCY
           DN_USER            =M_USERNAME,
           APP_STATUS         ='APPRO2',
           SCRIPT_STATUS      =M_SCRIPT_STAT
       WHERE
           DEAL_NO=M_DEAL_NO AND APP_STATUS ='APPRO2';

       IF SQL%NOTFOUND THEN
          INSERT INTO DN_TRN_OUTP_SALE
          (DEAL_NO,
  	       BUY_PORTFOLIO_CODE,
           SELL_PORTFOLIO_CODE,
  	       INST_TYPE,
	       SECURITY_CODE,
	       ENDOSER_CODE,
	       CURR_CODE,
	       EFF_VALDATE_TYPE,
	       EFF_VALDATE,
	       INT_RATE_BASE_CODE,
	       YIELD,
	       SETTLE_VALUE,
	       PRICE_CLEAN,
	       FACE_VALUE,
	       PRICE_DIRTY,
	       ACC_INT,
	       COST,
           DN_USER,
           APP_STATUS,
           SCRIPT_STATUS--SCRIPTLESS
           )
          VALUES(
           M_DEAL_NO,
  	       M_BCODE,
           M_SCODE,
  	       M_INSTYPE,
	       M_SECIDEN,
	       M_ENCODE,
	       M_CURR,
	       M_SEL_DATETYPE,
	       M_VAL_DATE,
	       M_BASIS,
	       M_YIELD/100,  -- Modified by Pubudu
	       M_SETVAL,
	       M_CLEAN,
	       M_FACEVAL*MM_CURRENCY_VALUE,--CURRENCY
	       M_DIRTY,
	       M_ACCINT*MM_CURRENCY_VALUE,--CURRENCY
	       M_COST*MM_CURRENCY_VALUE,--CURRENCY
           M_USERNAME,
           'ENT',
           M_SCRIPT_STAT --SCRIPTLESS
           );
       END IF;




ELSE --CURRENCY
       UPDATE DN_TRN_OUTP_SALE
       SET BUY_PORTFOLIO_CODE =M_BCODE,
           SELL_PORTFOLIO_CODE=M_SCODE,
  	       INST_TYPE          =M_INSTYPE,
	       SECURITY_CODE      =M_SECIDEN,
	       ENDOSER_CODE       =M_ENCODE,
	       CURR_CODE          =M_CURR,
	       EFF_VALDATE_TYPE   =M_SEL_DATETYPE,
	       EFF_VALDATE        =M_VAL_DATE,
	       INT_RATE_BASE_CODE =M_BASIS,
	       YIELD              =M_YIELD/100,   -- Modified by Pubudu
	       SETTLE_VALUE       =M_SETVAL,
	       PRICE_CLEAN        =M_CLEAN,
	       FACE_VALUE         =M_FACEVAL,
	       PRICE_DIRTY        =M_DIRTY,
	       ACC_INT            =M_ACCINT,
	       COST               =M_COST,
           DN_USER            =M_USERNAME,
           APP_STATUS         ='APPRO2',
           SCRIPT_STATUS      =M_SCRIPT_STAT,--SCRIPTLESS
            NOMINAL_VALUE      = M_NOMALUE,
           PURCHASE_COST      = M_FACEVAL* M_CLEAN   ,
           BROKER_COST        =M_COST
       WHERE
           DEAL_NO=M_DEAL_NO AND APP_STATUS ='APPRO2';

       IF SQL%NOTFOUND THEN
          INSERT INTO DN_TRN_OUTP_SALE
          (DEAL_NO,
  	       BUY_PORTFOLIO_CODE,
           SELL_PORTFOLIO_CODE,
  	       INST_TYPE,
	       SECURITY_CODE,
	       ENDOSER_CODE,
	       CURR_CODE,
	       EFF_VALDATE_TYPE,
	       EFF_VALDATE,
	       INT_RATE_BASE_CODE,
	       YIELD,
	       SETTLE_VALUE,
	       PRICE_CLEAN,
	       FACE_VALUE,
	       PRICE_DIRTY,
	       ACC_INT,
	       COST,
           DN_USER,
           APP_STATUS,
           SCRIPT_STATUS--SCRIPTLESS
           )
          VALUES(
           M_DEAL_NO,
  	       M_BCODE,
           M_SCODE,
  	       M_INSTYPE,
	       M_SECIDEN,
	       M_ENCODE,
	       M_CURR,
	       M_SEL_DATETYPE,
	       M_VAL_DATE,
	       M_BASIS,
	       M_YIELD/100,  -- Modified by Pubudu
	       M_SETVAL,
	       M_CLEAN,
	       M_FACEVAL,
	       M_DIRTY,
	       M_ACCINT,
	       M_COST,
           M_USERNAME,
           'ENT',
           M_SCRIPT_STAT --SCRIPTLESS
           );
       END IF;
      END IF;--CURRENCY

         COMMIT;
   END IF;
ELSE        -----------------------------------------------------------1


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
SELECT TO_DATE(M_V_DATE,'DD/MM/YYYY') INTO M_VAL_DATE FROM DUAL;
IF M_DEAL_NO IS NOT NULL THEN


IF M_CURR<>'SLR' THEN --CURRENCY
------------------------------------------------CURRENCY
SELECT  CURRENCY_VALUE
INTO    MM_CURRENCY_VALUE
FROM    DN_REF_EXCHANGE_RATES
WHERE   CURR_CODE=M_CURR;



UPDATE DN_TRN_DEAL_CURRENCY
SET    LEG1_VALUE=M_COST,
       LEG2_VALUE=M_FACEVAL,
       CURR_CODE=M_CURR,
       ACC_INT=M_ACCINT
WHERE  DEAL_NO=M_DEAL_NO;

UPDATE DN_TRN_OUTP_SALE
       SET BUY_PORTFOLIO_CODE =M_BCODE,
           SELL_PORTFOLIO_CODE=M_SCODE,
  	       INST_TYPE          =M_INSTYPE,
	       SECURITY_CODE      =M_SECIDEN,
	       ENDOSER_CODE       =M_ENCODE,
	       CURR_CODE          =M_CURR,
	       EFF_VALDATE_TYPE   ='UD',
	       EFF_VALDATE        =M_VAL_DATE,
	       INT_RATE_BASE_CODE ='A365',
	       YIELD              =0,   -- Modified by Pubudu
	       SETTLE_VALUE       =M_SETVAL,--0,--CHANGED BY SARANGA ON 29-06-2004
	       PRICE_CLEAN        =M_CLEAN,
	       FACE_VALUE         =M_FACEVAL*MM_CURRENCY_VALUE,--CURRENCY
	       PRICE_DIRTY        =M_DIRTY,
	       ACC_INT            =0,--CURRENCY
	       COST               =M_SETVAL,--0,--CURRENCY--CHANGED BY SARANGA ON 29-06-2004
           DN_USER            =M_USERNAME,
           APP_STATUS         ='APPRO2',
           SCRIPT_STATUS      =M_SCRIPT_STAT--SCRIPTLESS
       WHERE
           DEAL_NO=M_DEAL_NO AND APP_STATUS ='APPRO2';

 IF SQL%NOTFOUND THEN
          INSERT INTO DN_TRN_OUTP_SALE
          (DEAL_NO,
  	       BUY_PORTFOLIO_CODE,
           SELL_PORTFOLIO_CODE,
  	       INST_TYPE,
	       SECURITY_CODE,
	       ENDOSER_CODE,
	       CURR_CODE,
	       EFF_VALDATE_TYPE,
	       EFF_VALDATE,
	       INT_RATE_BASE_CODE,
	       YIELD,
	       SETTLE_VALUE,
	       PRICE_CLEAN,
	       FACE_VALUE,
	       PRICE_DIRTY,
	       ACC_INT,
	       COST,
           DN_USER,
           APP_STATUS,
           SCRIPT_STATUS,--SCRIPTLESS
           NOMINAL_VALUE,
           PURCHASE_COST,
           BROKER_COST--SCRIPTLESS
           )
          VALUES(
           M_DEAL_NO,
  	       M_BCODE,
           M_SCODE,
  	       M_INSTYPE,
	       M_SECIDEN,
	       M_ENCODE,
	         'SLR',
	       'UD',
	       M_VAL_DATE,
	       'A365',
	       0,  -- Modified by Pubudu
	       M_SETVAL,--CHANGED BY SARANGA ON 29-06-2004
	       M_CLEAN,
	       M_FACEVAL*MM_CURRENCY_VALUE,--CURRENCY
	       M_DIRTY,
	       0,--CURRENCY
	       M_SETVAL,--0,--CURRENCY--CHANGED BY SARANGA ON 29-06-2004
           M_USERNAME,
          'ENT',
           M_SCRIPT_STAT,
           M_NOMALUE,
           M_FACEVAL* M_CLEAN  ,
           M_COST
           );
       END IF;



ELSE
---RAISE_APPLICATION_ERROR(-20001,'FACE_VALUE - '||M_FACEVAL ||' SETTLE_VALUE - '||M_SETVAL);
UPDATE DN_TRN_OUTP_SALE
       SET BUY_PORTFOLIO_CODE =M_BCODE,
           SELL_PORTFOLIO_CODE=M_SCODE,
  	       INST_TYPE          =M_INSTYPE,
	       SECURITY_CODE      =M_SECIDEN,
	       ENDOSER_CODE       =M_ENCODE,
	       EFF_VALDATE_TYPE   ='UD',
	       EFF_VALDATE        =M_VAL_DATE,
	       INT_RATE_BASE_CODE ='A365',
	       YIELD              =0,   -- Modified by Pubudu
	       SETTLE_VALUE       =M_SETVAL,--0,--CHANGED BY SARANGA ON 29-06-2004
	       PRICE_CLEAN        =M_CLEAN,
	       FACE_VALUE         =M_FACEVAL,
	       PRICE_DIRTY        =M_DIRTY,
	       ACC_INT            =0,--CURRENCY
	       COST               =M_SETVAL,--0,--CURRENCY--CHANGED BY SARANGA ON 29-06-2004
           DN_USER            =M_USERNAME,
           APP_STATUS         ='APPRO2',
           SCRIPT_STATUS      =M_SCRIPT_STAT--SCRIPTLESS
       WHERE
           DEAL_NO=M_DEAL_NO AND APP_STATUS ='APPRO2';

       IF SQL%NOTFOUND THEN
          INSERT INTO DN_TRN_OUTP_SALE
          (DEAL_NO,
  	       BUY_PORTFOLIO_CODE,
           SELL_PORTFOLIO_CODE,
  	       INST_TYPE,
	       SECURITY_CODE,
	       ENDOSER_CODE,
	       CURR_CODE,
	       EFF_VALDATE_TYPE,
	       EFF_VALDATE,
	       INT_RATE_BASE_CODE,
	       YIELD,
	       SETTLE_VALUE,
	       PRICE_CLEAN,
	       FACE_VALUE,
	       PRICE_DIRTY,
	       ACC_INT,
	       COST,
           DN_USER,
           APP_STATUS,
           SCRIPT_STATUS,--SCRIPTLESS
           NOMINAL_VALUE,
           PURCHASE_COST,
           BROKER_COST--SCRIPTLESS
           )
          VALUES(
           M_DEAL_NO,
  	       M_BCODE,
           M_SCODE,
  	       M_INSTYPE,
	       M_SECIDEN,
	       M_ENCODE,
	       M_CURR,
	       M_SEL_DATETYPE,
	       M_VAL_DATE,
	       0,
	       0,  -- Modified by Pubudu
	       M_SETVAL,--0,--CHANGED BY SARANGA ON 29-06-2004
	       M_CLEAN,
	       M_FACEVAL,
	       M_DIRTY,
	       0,
	       M_SETVAL,--0,--CHANGED BY SARANGA ON 29-06-2004
           M_USERNAME,
           'ENT',
           M_SCRIPT_STAT ,
           M_NOMALUE,
           M_FACEVAL* M_CLEAN  ,
           M_COST     --SCRIPTLESS
           );

      END IF;--CURRENCY

END IF;
END IF;

MBFSL_OUTRIGHT_EQUITY_SET_MOD(M_DEAL_NO,M_BUY_DATE,M_SEL_DATE);


END IF;    -----------------------------------------------------------1


 /*
 EXCEPTION
  WHEN OTHERS THEN

    ROLLBACK;

    COMMIT;

    RAISE_APPLICATION_ERROR(-20201,'Cannot update records, because of incorrect data type.');
*/

END MBFSL_OUTRIGHT_UP1_CDT;

/
