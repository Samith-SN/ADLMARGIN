--------------------------------------------------------
--  DDL for Procedure DN_INV_REPO_DEAL_INT_ACCR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_REPO_DEAL_INT_ACCR" 
(
 M_PROCESS_DATE    DN_SYS_PARAMETER.LAST_DAILY%TYPE
)

   -- Procedure    : Calculate interest acc. from repo deal
   -- System       : Dealnet system
   -- Created by   : ITU - D.P. Pubudu Thushara
   -- Created on   : 11/08/1999
   -- Modified By  : V.Thilakesan.
   -- Modified on  : 09/03/2000

  AS

  CURSOR INT_RF_DEAL IS
     SELECT
        A.DEAL_NO,
        A.BORR_PORTFOLIO_CODE,
        A.LEND_PORTFOLIO_CODE,
        (M_PROCESS_DATE-A.EFF_VALDATE)+1,
        A.LEG1_VALUE,
        A.YIELD,
        A.INT_ACCR,
        DECODE(B.DENOMINATOR,'Act',(ADD_MONTHS(EFF_VALDATE,12)-EFF_VALDATE),B.DENOMINATOR),
        A.MATURITY_DATE,---*
        A.LEG2_VALUE---*
     FROM
        DN_TRN_REPO_FRESH A,
        DN_REF_INTR_BASE B
     WHERE
        A.EFF_VALDATE<=M_PROCESS_DATE
        AND
        A.MATURITY_DATE>M_PROCESS_DATE
        AND
        A.APP_STATUS='CONF'
        AND
        A.INT_RATE_BASE_CODE=B.INT_RATE_BASE_CODE;

  CURSOR INT_RR_DEAL IS
      SELECT
        A.DEAL_NO,
        A.BORR_PORTFOLIO_CODE,
        A.LEND_PORTFOLIO_CODE,
        (M_PROCESS_DATE-A.EFF_VALDATE)+1,
        A.LEG1_VALUE,
        A.YEILD,
        A.INT_ACCR,
        DECODE(B.DENOMINATOR,'Act',(ADD_MONTHS(EFF_VALDATE,12)-EFF_VALDATE),B.DENOMINATOR),
        A.MATURITY_DATE,---*
        A.LEG2_VALUE---*
     FROM
        DN_TRN_REPO_ROLLOVER A,
        DN_REF_INTR_BASE B
     WHERE
        A.EFF_VALDATE<=M_PROCESS_DATE
        AND
        A.MATURITY_DATE>M_PROCESS_DATE
        AND
        A.APP_STATUS='CONF'
        AND
        A.INT_RATE_BASE_CODE=B.INT_RATE_BASE_CODE;

  CURSOR INT_PI_DEAL IS
      SELECT
        A.DEAL_NO,
        A.BORR_PORTFOLIO_CODE,
        A.LEND_PORTFOLIO_CODE,
        (M_PROCESS_DATE-A.EFF_VALDATE)+1,
        A.LEG1_VALUE,
        A.YEILD,
        A.INT_ACCR,
        DECODE(B.DENOMINATOR,'Act',(ADD_MONTHS(EFF_VALDATE,12)-EFF_VALDATE),B.DENOMINATOR),
        A.MATURITY_DATE,---*
        A.LEG2_VALUE---*
     FROM
        DN_TRN_REPO_PERIOD_INT A,
        DN_REF_INTR_BASE B
     WHERE
        A.EFF_VALDATE<=M_PROCESS_DATE
        AND
        A.MATURITY_DATE>M_PROCESS_DATE
        AND
        A.APP_STATUS='CONF'
        AND
        A.INT_RATE_BASE_CODE=B.INT_RATE_BASE_CODE;


   M_DEAL_NO              DN_TRN_REPO_FRESH.DEAL_NO%TYPE;
   M_BORR_PORTFOLIO_CODE  DN_TRN_REPO_FRESH.BORR_PORTFOLIO_CODE%TYPE;
   M_LEND_PORTFOLIO_CODE  DN_TRN_REPO_FRESH.LEND_PORTFOLIO_CODE%TYPE;
   M_DATE_DIFF            NUMBER;
   M_LEG1_VALUE           DN_TRN_REPO_FRESH.LEG1_VALUE%TYPE;
   M_YEILD                DN_TRN_REPO_FRESH.YIELD%TYPE;
   M_INT_ACCR             DN_TRN_REPO_FRESH.INT_ACCR%TYPE;
   M_DENOMINATOR          DN_REF_INTR_BASE.DENOMINATOR%TYPE;
    M_DIFF                 DN_TRN_REPO_FRESH.LEG1_VALUE%TYPE;---*
   M_VALUE1               DN_TRN_REPO_FRESH.LEG1_VALUE%TYPE;---*
   M_VALUE2               DN_TRN_REPO_FRESH.LEG1_VALUE%TYPE;---*
   MM_NEW_VALUE           DN_TRN_REPO_FRESH.LEG1_VALUE%TYPE;---*
   M_LEG2_VALUE           DN_TRN_REPO_FRESH.LEG1_VALUE%TYPE;---*
 M_MATURITY_DATE        DATE;


BEGIN

   OPEN INT_RF_DEAL;

   LOOP

      FETCH  INT_RF_DEAL INTO

      M_DEAL_NO, M_BORR_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE,
      M_DATE_DIFF, M_LEG1_VALUE, M_YEILD, M_INT_ACCR, M_DENOMINATOR,M_MATURITY_DATE,M_LEG2_VALUE;

      EXIT WHEN INT_RF_DEAL%NOTFOUND;


      --IF ((((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF)-M_INT_ACCR)>0 THEN
      --2004/05/19 inditha
       --------------**----------------------
      M_DIFF := M_LEG2_VALUE-M_LEG1_VALUE;--C
      M_VALUE1:=(((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF);--A
      M_VALUE2:=M_INT_ACCR;--B

      IF ( (TO_DATE(TO_CHAR(M_MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')-1) = ( TO_DATE(TO_CHAR(M_PROCESS_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')))THEN

      --IF ABS(M_VALUE1 - M_DIFF)>10 THEN
      IF ABS(M_VALUE1 - M_DIFF)>5000 THEN --change by waruna 2013-07-25
       RAISE_APPLICATION_ERROR(-20201,'****'||'1THERE IS A PROBLEM IN THE INTEREST CALCULATION IN WD_INV_REPO_DEAL_INT_ACCR.');
      ELSE
      MM_NEW_VALUE :=M_DIFF-M_VALUE2;

      -----------**------------------
   --   IF ((((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF)-M_INT_ACCR)<>0 THEN
IF MM_NEW_VALUE <>0 THEN
          INSERT INTO DN_INV_INT_REPO_DEAL
            (PROCESS_DATE,
             DEAL_NO,
             BORR_PORTFOLIO_CODE,
             LEND_PORTFOLIO_CODE,
             INT_ACCR
             )
            VALUES
            (M_PROCESS_DATE,
             M_DEAL_NO,
             M_BORR_PORTFOLIO_CODE,
             M_LEND_PORTFOLIO_CODE,
--             ROUND(((((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF)-M_INT_ACCR),2) -- Rounded By Nilu on 08-11-04 for VCF 04-255
             ROUND(MM_NEW_VALUE,2) -- Rounded By Nilu on 08-11-04 for VCF 04-255
              );

          UPDATE DN_TRN_REPO_FRESH
--           SET INT_ACCR=ROUND(INT_ACCR+((((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF)-M_INT_ACCR),2) -- Rounded By Nilu on 08-11-04 for VCF 04-255
           SET INT_ACCR=ROUND(INT_ACCR+(MM_NEW_VALUE),2) -- Rounded By Nilu on 08-11-04 for VCF 04-255
           WHERE
             DEAL_NO=M_DEAL_NO;

      END IF;
 END IF;
ELSE

--     IF ((((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF)-M_INT_ACCR)<>0 THEN
IF (M_VALUE1-M_VALUE2) <> 0 THEN
          INSERT INTO DN_INV_INT_REPO_DEAL
            (PROCESS_DATE,
             DEAL_NO,
             BORR_PORTFOLIO_CODE,
             LEND_PORTFOLIO_CODE,
             INT_ACCR
             )
            VALUES
            (M_PROCESS_DATE,
             M_DEAL_NO,
             M_BORR_PORTFOLIO_CODE,
             M_LEND_PORTFOLIO_CODE,
--             ROUND(((((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF)-M_INT_ACCR),2) -- Rounded By Nilu on 08-11-04 for VCF 04-255
             ROUND((M_VALUE1-M_VALUE2),2) -- Rounded By Nilu on 08-11-04 for VCF 04-255
             );

          UPDATE DN_TRN_REPO_FRESH
--           SET INT_ACCR=ROUND(INT_ACCR+((((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF)-M_INT_ACCR),2) -- Rounded By Nilu on 08-11-04 for VCF 04-255
     SET INT_ACCR=ROUND((INT_ACCR+(M_VALUE1-M_VALUE2)),2) -- Rounded By Nilu on 08-11-04 for VCF 04-255
           WHERE
             DEAL_NO=M_DEAL_NO;

END IF;
      END IF;

    END LOOP;

   OPEN INT_RR_DEAL;

   LOOP

      FETCH  INT_RR_DEAL INTO

      M_DEAL_NO, M_BORR_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE,
      M_DATE_DIFF, M_LEG1_VALUE, M_YEILD, M_INT_ACCR, M_DENOMINATOR,M_MATURITY_DATE,M_LEG2_VALUE;

      EXIT WHEN INT_RR_DEAL%NOTFOUND;


         --IF ((((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF)-M_INT_ACCR)>0 THEN
         --2004/05/19 inditha

          --------------**----------------------
      M_DIFF := M_LEG2_VALUE-M_LEG1_VALUE;--C
      M_VALUE1:=(((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF);--A
      M_VALUE2:=M_INT_ACCR;--B

      IF ( (TO_DATE(TO_CHAR(M_MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')-1) = ( TO_DATE(TO_CHAR(M_PROCESS_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')))THEN

      --IF ABS(M_VALUE1 - M_DIFF)>10 THEN
       IF ABS(M_VALUE1 - M_DIFF)>5000 THEN        --change by waruna 2013-07-25
       RAISE_APPLICATION_ERROR(-20201,'****'||'THERE IS A PROBLEM IN THE INTEREST CALCULATION IN WD_INV_REPO_DEAL_INT_ACCR.');
      ELSE
      MM_NEW_VALUE :=M_DIFF-M_VALUE2;

      -----------**------------------
-- IF ((((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF)-M_INT_ACCR)<>0 THEN
IF MM_NEW_VALUE <> 0 THEN
            INSERT INTO DN_INV_INT_REPO_DEAL
              (PROCESS_DATE,
               DEAL_NO,
               BORR_PORTFOLIO_CODE,
               LEND_PORTFOLIO_CODE,
               INT_ACCR
               )
              VALUES
              (M_PROCESS_DATE,
               M_DEAL_NO,
               M_BORR_PORTFOLIO_CODE,
               M_LEND_PORTFOLIO_CODE,
--               ROUND(((((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF)-M_INT_ACCR),2)-- Rounded By Nilu on 08-11-04 for VCF 04-255
               ROUND(MM_NEW_VALUE,2)-- Rounded By Nilu on 08-11-04 for VCF 04-255
                );

            UPDATE DN_TRN_REPO_ROLLOVER
--             SET INT_ACCR=ROUND(INT_ACCR+((((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF)-M_INT_ACCR),2)-- Rounded By Nilu on 08-11-04 for VCF 04-255
             SET INT_ACCR=ROUND(INT_ACCR+(MM_NEW_VALUE),2)-- Rounded By Nilu on 08-11-04 for VCF 04-255
             WHERE
               DEAL_NO=M_DEAL_NO;

       END IF; END IF;
         ELSE
--         IF ((((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF)-M_INT_ACCR)<>0 THEN
IF (M_VALUE1-M_VALUE2) <> 0 THEN

            INSERT INTO DN_INV_INT_REPO_DEAL
              (PROCESS_DATE,
               DEAL_NO,
               BORR_PORTFOLIO_CODE,
               LEND_PORTFOLIO_CODE,
               INT_ACCR
               )
              VALUES
              (M_PROCESS_DATE,
               M_DEAL_NO,
               M_BORR_PORTFOLIO_CODE,
               M_LEND_PORTFOLIO_CODE,
--               ROUND(((((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF)-M_INT_ACCR),2)-- Rounded By Nilu on 08-11-04 for VCF 04-255
               ROUND((M_VALUE1-M_VALUE2),2)-- Rounded By Nilu on 08-11-04 for VCF 04-255
                );

            UPDATE DN_TRN_REPO_ROLLOVER
--             SET INT_ACCR=ROUND(INT_ACCR+((((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF)-M_INT_ACCR),2)-- Rounded By Nilu on 08-11-04 for VCF 04-255
             SET INT_ACCR=ROUND((INT_ACCR+(M_VALUE1-M_VALUE2)),2)-- Rounded By Nilu on 08-11-04 for VCF 04-255
             WHERE
               DEAL_NO=M_DEAL_NO;

       END IF;
  END IF;
  END LOOP;

  OPEN INT_PI_DEAL;

   LOOP

      FETCH  INT_PI_DEAL INTO

      M_DEAL_NO, M_BORR_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE,
      M_DATE_DIFF, M_LEG1_VALUE, M_YEILD, M_INT_ACCR, M_DENOMINATOR,M_MATURITY_DATE,M_LEG2_VALUE;

      EXIT WHEN INT_PI_DEAL%NOTFOUND;


 --------------**----------------------
      M_DIFF := M_LEG2_VALUE-M_LEG1_VALUE;--C
      M_VALUE1:=(((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF);--A
      M_VALUE2:=M_INT_ACCR;--B

      IF ( (TO_DATE(TO_CHAR(M_MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')-1) = ( TO_DATE(TO_CHAR(M_PROCESS_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')))THEN

      --IF ABS(M_VALUE1 - M_DIFF)>10 THEN
        IF ABS(M_VALUE1 - M_DIFF)>5000 THEN  --change by waruna 2013-07-25
       RAISE_APPLICATION_ERROR(-20201,'****'||'THERE IS A PROBLEM IN THE INTEREST CALCULATION IN WD_INV_REPO_DEAL_INT_ACCR.');
      ELSE
      MM_NEW_VALUE :=M_DIFF-M_VALUE2;

      -----------**------------------

--         IF ((((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF)-M_INT_ACCR)>0 THEN
IF MM_NEW_VALUE > 0  THEN
            INSERT INTO DN_INV_INT_REPO_DEAL
              (PROCESS_DATE,
               DEAL_NO,
               BORR_PORTFOLIO_CODE,
               LEND_PORTFOLIO_CODE,
               INT_ACCR
               )
              VALUES
              (M_PROCESS_DATE,
               M_DEAL_NO,
               M_BORR_PORTFOLIO_CODE,
               M_LEND_PORTFOLIO_CODE,
--               ((((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF)-M_INT_ACCR)
               MM_NEW_VALUE
                );

            UPDATE DN_TRN_REPO_PERIOD_INT
--             SET INT_ACCR=INT_ACCR+((((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF)-M_INT_ACCR)
             SET INT_ACCR=INT_ACCR+MM_NEW_VALUE
             WHERE
               DEAL_NO=M_DEAL_NO;

       END IF; END IF;

ELSE
--IF ((((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF)-M_INT_ACCR)>0 THEN
IF (M_VALUE1-M_VALUE2) > 0 THEN

            INSERT INTO DN_INV_INT_REPO_DEAL
              (PROCESS_DATE,
               DEAL_NO,
               BORR_PORTFOLIO_CODE,
               LEND_PORTFOLIO_CODE,
               INT_ACCR
               )
              VALUES
              (M_PROCESS_DATE,
               M_DEAL_NO,
               M_BORR_PORTFOLIO_CODE,
               M_LEND_PORTFOLIO_CODE,
--               ((((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF)-M_INT_ACCR)
               (M_VALUE1-M_VALUE2)
                );

            UPDATE DN_TRN_REPO_PERIOD_INT
--             SET INT_ACCR=INT_ACCR+((((M_LEG1_VALUE*M_YEILD)/M_DENOMINATOR)*M_DATE_DIFF)-M_INT_ACCR)
             SET INT_ACCR=INT_ACCR+(M_VALUE1-M_VALUE2)
             WHERE
               DEAL_NO=M_DEAL_NO;

       END IF;
END IF;



  END LOOP;


END DN_INV_REPO_DEAL_INT_ACCR;

/
