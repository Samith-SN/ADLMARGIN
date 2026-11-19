--------------------------------------------------------
--  DDL for Procedure DN_RP_PAY_FREQ_ROUTINE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_RP_PAY_FREQ_ROUTINE" 
   (M_LAST_DAILY       DATE
   )
AS

CURSOR DEAL_PFREQ IS
 SELECT DEAL_NO,INT_PAY_FREQ,YEILD * 100,MATURITY_DATE,LEG1_VALUE,EFF_VALDATE,
        BORR_PORTFOLIO_CODE,LEND_PORTFOLIO_CODE
 FROM   DN_TRN_REPO_PERIOD_INT
 WHERE  DEAL_NO IN (SELECT DISTINCT B.DEAL_NO  FROM DN_REF_RP_INST_PAY_FREQ B)
 AND    EFF_VALDATE <=M_LAST_DAILY
 AND    MATURITY_DATE > M_LAST_DAILY --SETTLEMENT --NOT INCLUDED
 AND    APP_STATUS <> 'CANCEL'
 ORDER BY DEAL_NO;

IAMOUNT                     DN_TRN_REPO_PERIOD_INT.LEG1_VALUE%TYPE;
M_END_DATE                  DN_TRN_REPO_PERIOD_INT.MATURITY_DATE%TYPE;
M_DEAL_NO                   DN_TRN_REPO_PERIOD_INT.DEAL_NO%TYPE;
M_PAY_FREQ                  DN_TRN_REPO_PERIOD_INT.INT_PAY_FREQ%TYPE;
M_BORR_PORTFOLIO_CODE       DN_TRN_REPO_PERIOD_INT.BORR_PORTFOLIO_CODE%TYPE;
M_LEND_PORTFOLIO_CODE       DN_TRN_REPO_PERIOD_INT.LEND_PORTFOLIO_CODE%TYPE;
M_RETURN_RATE               NUMBER;
M_FREQ_NO                   DN_REF_RP_INST_PAY_FREQ.FREQ_NO%TYPE;
M_EFF_DATE                  DN_REF_RP_INST_PAY_FREQ.EFF_DATE%TYPE;
M_EFF_DATE2                 DN_REF_RP_INST_PAY_FREQ.EFF_DATE%TYPE;
MSTART_DATE                 DATE;
M_SDATE                     DATE;
M_PI                        NUMBER;
M_PI2                       NUMBER;
IR                          NUMBER;
M_NUM                       NUMBER;
M_COUNT                     NUMBER;
M_MTOT                      NUMBER;
M_ROW                       NUMBER;
M_STATUS                    DN_ACC_SUS_PAYMENT.SUSPENSE_ENTRY_TYPE%TYPE;
M_AMOUNT                    DN_TRN_REPO_PERIOD_INT.LEG1_VALUE%TYPE;
M_AMOUNT2                   DN_TRN_REPO_PERIOD_INT.LEG1_VALUE%TYPE;
M_CURDATE                   DATE;
M_CNT                       NUMBER;

-------------------------------------------------------------------------------------
    --   PROCEDURE  - PERIODIC INTEREST CALCULATION
    --   SYSTEM     - Dealnet
    --   CREATED BY - Lathika.
    --   CREATED ON - 20-08-2000
-------------------------------------------------------------------------------------

BEGIN

IF M_LAST_DAILY IS NOT NULL THEN

OPEN DEAL_PFREQ;

     LOOP
         M_DEAL_NO             :=NULL;
         M_END_DATE            :=NULL;
         MSTART_DATE           :=NULL;
         M_PAY_FREQ            :=0;
         M_RETURN_RATE         :=0;
         M_MTOT                :=0;
         IAMOUNT               :=0;
         M_PI2                 :=0;
         M_BORR_PORTFOLIO_CODE :=NULL;
         M_LEND_PORTFOLIO_CODE :=NULL;
       FETCH
          DEAL_PFREQ
       INTO
          M_DEAL_NO,M_PAY_FREQ,M_RETURN_RATE,M_END_DATE,IAMOUNT,MSTART_DATE,M_BORR_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE;

       EXIT WHEN DEAL_PFREQ%NOTFOUND;

    ----selecting   last interst paid date--------------------
     SELECT  COUNT(*)
      INTO   M_CNT
      FROM DN_REF_RP_INST_PAY_FREQ
      WHERE DEAL_NO=M_DEAL_NO
      AND STATUS='Y'
      AND EFF_DATE=(SELECT MAX(EFF_DATE)
                    FROM DN_REF_RP_INST_PAY_FREQ
                    WHERE DEAL_NO=M_DEAL_NO AND STATUS='Y');

     IF M_CNT >0 THEN

        SELECT FREQ_NO,EFF_DATE
        INTO   M_FREQ_NO,M_EFF_DATE
        FROM DN_REF_RP_INST_PAY_FREQ
        WHERE DEAL_NO=M_DEAL_NO
        AND STATUS='Y'
        AND EFF_DATE=(SELECT MAX(EFF_DATE)
                     FROM DN_REF_RP_INST_PAY_FREQ
                     WHERE DEAL_NO=M_DEAL_NO AND STATUS='Y');

     ELSE
      M_EFF_DATE:=M_SDATE;
      M_FREQ_NO :=0;
     END IF;

    ----selecting   next interst payment date----------------------
     /* SELECT EFF_DATE
      INTO  M_EFF_DATE2
      FROM DN_REF_RP_INST_PAY_FREQ
      WHERE DEAL_NO=M_DEAL_NO
      AND STATUS='N'
      AND EFF_DATE=(SELECT MIN(EFF_DATE)
                    FROM DN_REF_RP_INST_PAY_FREQ
                    WHERE DEAL_NO=M_DEAL_NO AND STATUS='N');*/

    SELECT MIN(EFF_DATE)
    INTO  M_EFF_DATE2
                    FROM DN_REF_RP_INST_PAY_FREQ
                    WHERE DEAL_NO=M_DEAL_NO AND STATUS='N';
   ------ check validity of agreement---------------------------------
   M_CURDATE    :=M_LAST_DAILY + 1;
  IF (M_CURDATE) =M_EFF_DATE2 THEN

   -----FMA freq =1 and period is less than one year ----------------

    IF M_PAY_FREQ = 1 THEN
        M_RETURN_RATE:= M_RETURN_RATE * (M_END_DATE - MSTART_DATE)/ ((MSTART_DATE+ 365)-MSTART_DATE );
    END IF;

   -----End of freq =1 and period is less than one year--------------
   ------interest rate calculation------
        IR:=((M_RETURN_RATE/100)/M_PAY_FREQ);

  ------retrive information from 'breakdown' table-----------------
        M_NUM:=1;
        M_AMOUNT2:=IAMOUNT;
/*
        SELECT  COUNT(*)
        INTO M_COUNT
        FROM WEBDN_TRN_INVEST_BREAKDOWN
        WHERE DEAL_NO=M_DEAL_NO
        AND   FROM_DATE >=M_EFF_DATE
        AND   FROM_DATE <M_EFF_DATE2;

        IF  M_COUNT>0 THEN


            FOR M_NUM IN 1..M_COUNT LOOP

                SELECT P.NUMM,P.FROM_DATE,P.TOT
                INTO  M_ROW,M_SDATE,M_AMOUNT
                FROM
                (SELECT ROWNUM NUMM,FROM_DATE,
                DECODE(ITYPE,'WITHDRAW',(AMOUNT*-1),AMOUNT) TOT
                FROM  WEBDN_TRN_INVEST_BREAKDOWN
                WHERE DEAL_NO=M_DEAL_NO
                AND   FROM_DATE >=M_EFF_DATE
                AND   FROM_DATE <M_EFF_DATE2)P
                WHERE P.NUMM=M_NUM;

                M_AMOUNT2:=M_AMOUNT2+ (M_AMOUNT * -1);
                -------interest calculation for each amount-----
                 M_PI:=(((M_AMOUNT/(M_EFF_DATE2-M_EFF_DATE))*(M_EFF_DATE2-M_SDATE))*IR);

                -------tot amount-----
                M_MTOT:= M_MTOT+M_PI;
           END LOOP;
        -----------end-------------------------
       END IF; */

       --CALCULATION OF INTEREST FOR AMOUNT AS OF BEGINNING OF THE PAYMENT PERIOD
       M_PI2:=((M_AMOUNT2 )*IR);
       M_MTOT:= M_MTOT+M_PI2;
---

    IF M_END_DATE>M_EFF_DATE2  THEN
        M_STATUS:='I'; ---------normal periodic interest payment-----

  /*  ELSIF M_END_DATE=M_EFF_DATE2  THEN

       M_MTOT:=M_MTOT+IAMOUNT;
       M_STATUS:='A'; ---------settlement payment---------------- */

    --END IF;--commented on 14-08-2002 by nirmala
        INSERT INTO DN_ACC_SUS_PAYMENT
            (SUS_REF_NO,
             TOT_SETTLE_AMOUNT,
             INT_BAL_SETTLE_AMOUNT,
             PAY_FROM_INT_BAL_AMT,
             BAL_TO_BE_PAID,
             ENT_DATE,LAST_MOD_DATE,
             SUSPENSE_ENTRY_TYPE,
             PAYER,RECEIVER)
                   VALUES
                    (M_DEAL_NO,
                     M_MTOT,
                     0,0,
                     M_MTOT,
                     M_CURDATE,M_CURDATE,
                     M_STATUS,
                     M_BORR_PORTFOLIO_CODE,
                     M_LEND_PORTFOLIO_CODE);


        UPDATE DN_REF_RP_INST_PAY_FREQ
        SET STATUS='Y'
        WHERE DEAL_NO=M_DEAL_NO
              AND STATUS='N'
              AND EFF_DATE=M_CURDATE;
   END IF;--added on 14-08-2002 by nirmala
   END IF;
  END LOOP;

  CLOSE DEAL_PFREQ;
 END IF;


/*EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO );
*/
--COMMIT;
END DN_RP_PAY_FREQ_ROUTINE;

/
