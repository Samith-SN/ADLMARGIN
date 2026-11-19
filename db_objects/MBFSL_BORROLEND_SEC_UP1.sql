--------------------------------------------------------
--  DDL for Procedure MBFSL_BORROLEND_SEC_UP1
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_BORROLEND_SEC_UP1" (
    M_DEAL_NO  IN OUT      DN_TRN_BL_SECURITY.DEAL_NO%TYPE,
    M_BORR_PORTFOLIO_CODE  DN_TRN_BL_SECURITY.BORR_PORTFOLIO_CODE%TYPE,
    M_LEND_PORTFOLIO_CODE  DN_TRN_BL_SECURITY.LEND_PORTFOLIO_CODE%TYPE,
    M_INSTRUMENT           DN_TRN_BL_SECURITY.INST_TYPE%TYPE,
    M_SECURITY_ID          DN_TRN_BL_SECURITY.SECURITY_CODE%TYPE,
    M_ENDORSER             DN_TRN_BL_SECURITY.ENDOSER_CODE%TYPE,
    M_PHYSICAL             DN_TRN_BL_SECURITY.PHYSICAL_DELIVERY%TYPE,
    M_CURRENCY             DN_TRN_BL_SECURITY.CURR_CODE%TYPE,
   	M_SEL_DATETYPE         DN_TRN_BL_SECURITY.EFF_VALDATE_TYPE%TYPE,
    M_VALUE_DATE           CHAR,
    M_MAT_DATE             CHAR,
    M_TENOR                DN_TRN_BL_SECURITY.TENOR%TYPE,
    M_FACE_VALUE           DN_TRN_BL_SECURITY.FACE_VALUE%TYPE,
    M_RATE_PER_ANN         DN_TRN_BL_SECURITY.FEE_RATE_PER_ANN%TYPE,
    M_FEE_AMOUNT           DN_TRN_BL_SECURITY.FEE_AMOUNT%TYPE,
    M_FDUE_DATE            CHAR,
    M_USERNAME             DN_TRN_BL_SECURITY.DN_USER%TYPE,
    M_DEAL_NUMBER          DN_TRN_BL_SECURITY.DEAL_NO%TYPE
)

AS

   M_USER            DN_TRN_BL_SECURITY.DN_USER%TYPE;
   M_VAL_DATE        DN_TRN_BL_SECURITY.EFF_VALDATE%TYPE;
   M_MATU_DATE       DN_TRN_BL_SECURITY.MATURITY_DATE%TYPE;
   M_DUE_DATE        DN_TRN_BL_SECURITY.FEE_DUE_DATE%TYPE;

BEGIN

    --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO);

    -- PROCEDURE  -  TO INSERT BORROW LEND SECURITIES DETAILS
    -- SYSTEM     -  MBFSL SYSTEM
    -- CREATED BY -  V.THILAKESAN.
    -- CREATED ON -  15/07/1999

    --To select the value date
    --IF M_VALUE_DATE_TYPE<>'UD' THEN
    --   SELECT DN_FIN_EFF_VALDATE(M_VALUE_DATE_TYPE) INTO M_VAL_DATE FROM DUAL;
    --ELSE
       SELECT TO_DATE(M_VALUE_DATE,'DD/MM/YYYY') INTO M_VAL_DATE FROM DUAL;
    --END IF;
    --To format the maturity date
    SELECT
      TO_DATE(M_MAT_DATE,'DD/MM/YYYY')
    INTO
      M_MATU_DATE
    FROM DUAL;
    --To format the fee due date
    SELECT
      TO_DATE(M_FDUE_DATE,'DD/MM/YYYY')
    INTO
      M_DUE_DATE
    FROM DUAL;

    IF M_DEAL_NO IS NOT NULL THEN

          UPDATE DN_TRN_BL_SECURITY
       SET BORR_PORTFOLIO_CODE=M_BORR_PORTFOLIO_CODE,
           LEND_PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE,
           INST_TYPE          =M_INSTRUMENT,
           SECURITY_CODE      =M_SECURITY_ID,
           ENDOSER_CODE       =M_ENDORSER,
           PHYSICAL_DELIVERY  =M_PHYSICAL,
           CURR_CODE          =M_CURRENCY,
           EFF_VALDATE_TYPE   =M_SEL_DATETYPE,
           EFF_VALDATE        =M_VAL_DATE,
           MATURITY_DATE      =M_MATU_DATE,
           TENOR              =M_TENOR,
           FACE_VALUE         =M_FACE_VALUE,
           FEE_RATE_PER_ANN   =M_RATE_PER_ANN,
           FEE_AMOUNT         =M_FEE_AMOUNT,
           FEE_DUE_DATE       =M_DUE_DATE,
           DN_USER            =M_USERNAME,
           APP_STATUS         ='ENT'

       WHERE
           DEAL_NO=M_DEAL_NO;
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

           --********************************************/

                  --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||'-'||M_BORR_PORTFOLIO_CODE||'-'||M_LEND_PORTFOLIO_CODE||'-'||M_SECURITY||'-'||M_PHYSICAL||'-'||M_EXCHANGEABILITY||'-'||M_CURRENCY||'-'||M_BASIS||'-'||M_VALUE_DATE_TYPE||'-'||M_VAL_DATE||'-'||M_YIELD_NET||'-'||M_YIELD_NSL||'-'||M_LEG1||'-'||M_LEG2||'-'||M_MATU_DATE||'-'||M_TENOR||'-'||M_INTEREST||'-'||M_USER);

       IF SQL%NOTFOUND THEN


          INSERT INTO DN_TRN_BL_SECURITY
          (DEAL_NO,
           BORR_PORTFOLIO_CODE,
           LEND_PORTFOLIO_CODE,
           INST_TYPE,
           SECURITY_CODE,
           ENDOSER_CODE,
           PHYSICAL_DELIVERY,
           CURR_CODE,
           EFF_VALDATE_TYPE,
           EFF_VALDATE,
           MATURITY_DATE,
           TENOR,
           FACE_VALUE,
           FEE_RATE_PER_ANN,
           FEE_AMOUNT,
           FEE_DUE_DATE,
           DN_USER,
           APP_STATUS)
           VALUES(
             M_DEAL_NO,
             M_BORR_PORTFOLIO_CODE,
             M_LEND_PORTFOLIO_CODE,
             M_INSTRUMENT,
             M_SECURITY_ID,
             M_ENDORSER,
             M_PHYSICAL,
             M_CURRENCY,
             M_SEL_DATETYPE,
             M_VAL_DATE,
             M_MATU_DATE,
             M_TENOR,
             M_FACE_VALUE,
             M_RATE_PER_ANN,
             M_FEE_AMOUNT,
             M_DUE_DATE,
             M_USERNAME,
             'ENT');
       END IF;

       UPDATE DN_TRN_BL_SECURITY_INST
       SET   INV_CODE='OR'
       WHERE DEAL_NO=M_DEAL_NO
             AND
             INST_TYPE=M_INSTRUMENT
             AND
             INV_CODE='OR';
       IF SQL%NOTFOUND THEN
          INSERT INTO DN_TRN_BL_SECURITY_INST
              (DEAL_NO,
               INST_TYPE
               )
          VALUES(M_DEAL_NO,
                 M_INSTRUMENT
                 );
       END IF;

       UPDATE DN_TRN_BL_SECURITY_SEC
       SET ENDOSER_CODE=M_ENDORSER,
           FACE_VALUE=M_FACE_VALUE
       WHERE DEAL_NO=M_DEAL_NO
             AND
             INST_TYPE=M_INSTRUMENT
             AND
             INV_CODE='OR'
             AND
             SECURITY_CODE=M_SECURITY_ID;
       IF SQL%NOTFOUND THEN
          INSERT INTO DN_TRN_BL_SECURITY_SEC
              (DEAL_NO,
               INST_TYPE,
               SECURITY_CODE,
               ENDOSER_CODE,
               FACE_VALUE
               )
          VALUES(M_DEAL_NO,
                 M_INSTRUMENT,
                 M_SECURITY_ID,
                 M_ENDORSER,
                 M_FACE_VALUE
                 );
       END IF;

   END IF;
   COMMIT;
    --If the data type is incorrect then delete the records from the relavent tables

 EXCEPTION
  WHEN OTHERS THEN

    ROLLBACK;

    COMMIT;

--    RAISE_APPLICATION_ERROR(-20201,	M_SEL_DATETYPE||'-'||M_FACE_VALUE||'-'||M_SECURITY_ID||'Cannot update records, because of incorrect data type.');

END MBFSL_BORROLEND_SEC_UP1;

/
