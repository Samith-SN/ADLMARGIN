--------------------------------------------------------
--  DDL for Procedure DN_AUTO_REPOROLLOVER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_AUTO_REPOROLLOVER" 
 (
  M_PORT_CODE          DN_TRN_BO_SETTL_RECEIPT.PORTFOLIO_CODE%TYPE,
  M_ID_PORTCODE        DN_TRN_BO_SETTL_RECEIPT.ID_PORTFOLIO_CODE%TYPE,
  MM_AMT_NEW           DN_TRN_REPO_ROLLOVER.LEG1_VALUE%TYPE,
  M_USER               DN_TRN_BO_SETTL_RECEIPT.DN_USER%TYPE,
  M_E_VAL_DATE         VARCHAR2,
  M_CR_DR_STATUS_NEW   VARCHAR2,

  M_BROKER_CODE        DN_TRN_REPO_DETAILS.BROKER_CODE%TYPE,
  M_SECURITY_CODE      DN_TRN_REPO_DETAILS.SECURITY_CODE%TYPE,
  M_PRICE              DN_TRN_REPO_DETAILS.PRICE%TYPE,
  M_SETTL_PAY_FRQ      DN_TRN_REPO_DETAILS.SETTL_PAY_FRQ%TYPE
 )
 IS

 MM_AMT             DN_TRN_REPO_ROLLOVER.LEG1_VALUE%TYPE;
 M_CR_DR_STATUS     VARCHAR2(2);
 MDEAL_NO           VARCHAR2(14);
 MMDEAL_NO           VARCHAR2(14);
 M_CNT_FRESH        NUMBER  DEFAULT 0;
 M_CNT_REPO         NUMBER  DEFAULT 0;
 M_CNT_REPO_ERR     NUMBER  DEFAULT 0;
 M_CNT_FRESH_ERR    NUMBER  DEFAULT 0;
 M_TENOR            NUMBER  DEFAULT 0;
 MAT_DATE           VARCHAR2(15);
 LEG2_VAL           NUMBER (18,2);
 INT_AMT            NUMBER (18,2);
 MPRIOR_NO          VARCHAR2(14);
 MLEG1              NUMBER (18,2);
 MLEG2              NUMBER (18,2);
 M_BRANCH           VARCHAR2(30);
 MRATE              DN_REF_PORTFOLIO.RATE%TYPE;
 MINST_TYPE         DN_REF_REPO_RATE.INST_TYPE%TYPE:='TBOND';
 MHAIRCUT           DN_REF_REPO_RATE.HAIRCUT%TYPE:=0;
 M_BRCNT            NUMBER  DEFAULT 0;
 M_CANCEL           NUMBER  DEFAULT 0;
 M_CANCEL_R         NUMBER  DEFAULT 0;
 MREPO_CANCEL       NUMBER  DEFAULT 0;
 MREPO_CANCEL_R     NUMBER  DEFAULT 0;
 M_SETTLE           NUMBER  DEFAULT 0;
 DEALCAN            VARCHAR2(14);
 DEALCAN_PRIOR      VARCHAR2(14); --ADDED SM 21-10-2010
 MBORR              DN_TRN_REPO_FRESH.BORR_PORTFOLIO_CODE%TYPE;
 MCURR_CODE         DN_TRN_REPO_FRESH.CURR_CODE%TYPE;
 M_BACC             DN_TRN_REPO_SETTLEMENT_SETTLE.BORR_ACC_NO%TYPE;
 M_SACC             DN_TRN_REPO_SETTLEMENT_SETTLE.LEND_ACC_NO%TYPE;
 M_COMM1            DN_TRN_REPO_SETTLEMENT_SETTLE.BORR_SETTLE_COMMENT%TYPE;
 M_COMM2            DN_TRN_REPO_SETTLEMENT_SETTLE.LEND_SETTLE_COMMENT%TYPE;
 M_DEAL_NUMBER      DN_TRN_REPO_SETTLEMENT.DEAL_NO%TYPE;
 M_RATE             DN_REF_PORTFOLIO.RATE%TYPE;
 M_RATE_TYPE        DN_REF_PORTFOLIO.RATE_TYPE%TYPE;
 M_LIMIT            DN_REF_PORTFOLIO.LIMIT%TYPE;
 M_SUM_INT          DN_TRN_REPO_ROLLOVER.INT_AMOUNT%TYPE;
 MREPO_SUM_INT      DN_TRN_REPO_ROLLOVER.INT_AMOUNT%TYPE;
 MREPO_CNT_FRESH_ERR NUMBER;
 MREPO_CNT_REPO_ERR  NUMBER;
 MREPORATE           NUMBER;
 MREPO_HAIRCUT       NUMBER;
 MREPO_CNT_FRESH     NUMBER DEFAULT 0;
 MREPO_CNT_REPO      NUMBER DEFAULT 0;
 M_OD_INT            NUMBER;
 M_DAY_LOAN          BOOLEAN;
 M_START_DATE        VARCHAR2(10);
 M_END_DATE          VARCHAR2(10);
 M_FRQ_PER_YEAR      NUMBER DEFAULT 0;


    M_SDATE                     DATE;
    M_PAYDATE                   DATE;
    M_EDATE                     DATE;
    M_NUM                       NUMBER;
    M_NUM2                      NUMBER;
    M_A                         NUMBER;
    M_TOT_TENOR                 NUMBER;
    M_LEG2_VAL                  NUMBER;
    M_ARE_RATE                  NUMBER;
    M_DUE_AMOUNT                NUMBER;

    M_TOT_PAY_FREQ              NUMBER;
    M_NO_OF_MONTHES             NUMBER;
    M_EFF_RATE                  NUMBER;
    M_E_VAL_DATE_1              VARCHAR2(15);
    M_ORG_DEAL_NO               VARCHAR2(14);
    M_LAST_DEAL_NO              VARCHAR2(14);
    M_LAST_LEG2                 NUMBER;
BEGIN
MCURR_CODE:='SLR';
M_DAY_LOAN:=FALSE;


/*THROW AN ERROR IF ALREADY A ROLLOLVER OR REPO FRESH DONE FOR THE CLIENT FOR THAT DAY AND CONFIRMED */
 /* remove by waruna 2012-02-15
 SELECT COUNT(A.DEAL_NO)
 INTO   M_CNT_FRESH_ERR
 FROM   DN_TRN_REPO_FRESH  A
 WHERE  A.BORR_PORTFOLIO_CODE=M_ID_PORTCODE AND
        A.ON_CALL_DEAL = 'Y' AND A.APP_STATUS ='CONF' AND
        TO_DATE(TO_CHAR(A.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') > TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY') ;

 IF  M_CNT_FRESH_ERR > 0 THEN
   RAISE_APPLICATION_ERROR(-20201,'AN ON-CALL REPO FRESH DEAL ALREADY EXISTS FOR -'||''||M_ID_PORTCODE||' - PLEASE CONTACT YOUR SYSTEMS ADMINSTRATOR ');
 END IF;


 SELECT COUNT(A.DEAL_NO)
 INTO   M_CNT_REPO_ERR
 FROM   DN_TRN_REPO_ROLLOVER  A
 WHERE  A.BORR_PORTFOLIO_CODE=M_ID_PORTCODE AND
        A.ON_CALL_DEAL = 'Y' AND A.APP_STATUS ='CONF' AND
        TO_DATE(TO_CHAR(A.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') > TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY') ;

 IF  M_CNT_REPO_ERR > 0 THEN
   RAISE_APPLICATION_ERROR(-20201,'AN ON-CALL REPO ROLLOVER DEAL ALREADY EXISTS FOR -'||''||M_ID_PORTCODE||' - PLEASE CONTACT YOUR SYSTEMS ADMINSTRATOR ');
 END IF;

--=================================================FOR REPOS=====================================================

 SELECT COUNT(A.DEAL_NO)
 INTO   MREPO_CNT_FRESH_ERR
 FROM   DN_TRN_REPO_FRESH  A
 WHERE  A.LEND_PORTFOLIO_CODE=M_ID_PORTCODE AND
        A.ON_CALL_DEAL = 'Y' AND A.APP_STATUS ='CONF' AND
        TO_DATE(TO_CHAR(A.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')> TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY') ;

 IF  MREPO_CNT_FRESH_ERR > 0 THEN
   RAISE_APPLICATION_ERROR(-20201,'AN ON-CALL REPO FRESH DEAL ALREADY EXISTS FOR -'||''||M_ID_PORTCODE||' - PLEASE CONTACT YOUR SYSTEMS ADMINSTRATOR ');
 END IF;

 SELECT COUNT(A.DEAL_NO)
 INTO   MREPO_CNT_REPO_ERR
 FROM   DN_TRN_REPO_ROLLOVER  A
 WHERE  A.LEND_PORTFOLIO_CODE=M_ID_PORTCODE AND
        A.ON_CALL_DEAL = 'Y' AND A.APP_STATUS ='CONF' AND
        TO_DATE(TO_CHAR(A.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') > TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY') ;

 IF  MREPO_CNT_REPO_ERR > 0 THEN
   RAISE_APPLICATION_ERROR(-20201,'AN ON-CALL REPO ROLLOVER DEAL ALREADY EXISTS FOR -'||''||M_ID_PORTCODE||' - PLEASE CONTACT YOUR SYSTEMS ADMINSTRATOR ');
 END IF;*/
--=============================================END=========================================================================
M_START_DATE := M_E_VAL_DATE;

SELECT RATE,RATE_TYPE,LIMIT
INTO   M_RATE,M_RATE_TYPE,M_LIMIT
FROM   DN_REF_PORTFOLIO
WHERE  PORTFOLIO_CODE =  M_ID_PORTCODE;

IF M_RATE_TYPE IS NOT NULL THEN
 SELECT NVL(COUNT(*),0)
 INTO   M_BRCNT
 FROM   DN_REF_INSTRUMENT
 WHERE  ACTIVE_STATUS='Y' AND
        INST_TYPE=M_RATE_TYPE;

   IF M_BRCNT  =1 THEN
    SELECT NVL(BASE_INTEREST_RATE,0)/100,INST_TYPE
    INTO   MRATE,MINST_TYPE
    FROM   DN_REF_INSTRUMENT
    WHERE  ACTIVE_STATUS='Y' AND
           INST_TYPE=M_RATE_TYPE;

    MINST_TYPE := M_RATE_TYPE;
    MRATE      := NVL(M_RATE,0)+NVL(MRATE,0);
   ELSE
    MINST_TYPE := 'TBILL';
    MRATE      := NVL(M_RATE,0);
   END IF;
ELSE
 MINST_TYPE := 'TBILL';
 MHAIRCUT   := 0.00;
 MRATE      := M_RATE;
END IF;

--==================================================FOR REPOS=========================================================
 SELECT RATE,HAIRCUT--,VALUE_DATE
 INTO   MREPORATE,MREPO_HAIRCUT
 FROM   DN_REF_MT_REPO_RATE
 WHERE  STATUS='Y' AND  VALUE_DATE= (SELECT MAX(VALUE_DATE)
                                     FROM   DN_REF_MT_REPO_RATE
                                     WHERE  STATUS='Y'  AND VALUE_DATE<=TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY')) ;
--=====================================================================================================================
--REVERSE REPO RF COUNT
 /*SELECT COUNT(A.DEAL_NO)
 INTO   M_CNT_FRESH
 FROM   DN_TRN_REPO_FRESH  A
 WHERE  A.BORR_PORTFOLIO_CODE=M_ID_PORTCODE AND
        A.ON_CALL_DEAL = 'Y' AND A.APP_STATUS ='CONF' AND
        TO_DATE(TO_CHAR(A.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') = TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY') AND
        A.DEAL_NO NOT IN (SELECT PRIOR_DEAL_NO
                          FROM   DN_TRN_REPO_ROLLOVER
                          WHERE  PRIOR_DEAL_NO= A.DEAL_NO) AND
        A.DEAL_NO NOT IN (SELECT PRIOR_DEAL_NO
                          FROM   DN_TRN_REPO_SETTLEMENT
                          WHERE  PRIOR_DEAL_NO= A.DEAL_NO)

                           ;
*/
--REVERSE REPO RR COUNT
 /*SELECT COUNT(A.DEAL_NO)
 INTO   M_CNT_REPO
 FROM   DN_TRN_REPO_ROLLOVER A
 WHERE  A.BORR_PORTFOLIO_CODE=M_ID_PORTCODE AND
        A.ON_CALL_DEAL = 'Y' AND A.APP_STATUS ='CONF' AND
        TO_DATE(TO_CHAR(A.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') = TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY') AND
        A.DEAL_NO NOT IN (SELECT PRIOR_DEAL_NO
                          FROM   DN_TRN_REPO_ROLLOVER
                          WHERE  PRIOR_DEAL_NO= A.DEAL_NO) AND
        A.DEAL_NO NOT IN (SELECT PRIOR_DEAL_NO
                          FROM   DN_TRN_REPO_SETTLEMENT
                          WHERE  PRIOR_DEAL_NO= A.DEAL_NO)  ;*/

--====================================================FOR REPOS=====================================================
/*
-- REPO RF COUNT
 SELECT COUNT(A.DEAL_NO)
 INTO   MREPO_CNT_FRESH
 FROM   DN_TRN_REPO_FRESH  A
 WHERE  A.LEND_PORTFOLIO_CODE=M_ID_PORTCODE AND
        A.ON_CALL_DEAL = 'Y' AND A.APP_STATUS ='CONF' AND
        TO_DATE(TO_CHAR(A.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') = TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY') AND
        A.DEAL_NO NOT IN (SELECT PRIOR_DEAL_NO
                          FROM   DN_TRN_REPO_ROLLOVER
                          WHERE  PRIOR_DEAL_NO= A.DEAL_NO) AND
        A.DEAL_NO NOT IN (SELECT PRIOR_DEAL_NO
                          FROM   DN_TRN_REPO_SETTLEMENT
                          WHERE  PRIOR_DEAL_NO= A.DEAL_NO)  ;
-- REPO RR COUNT
 SELECT COUNT(A.DEAL_NO)
 INTO   MREPO_CNT_REPO
 FROM   DN_TRN_REPO_ROLLOVER A
 WHERE  A.LEND_PORTFOLIO_CODE=M_ID_PORTCODE AND
        A.ON_CALL_DEAL = 'Y' AND A.APP_STATUS ='CONF' AND
        TO_DATE(TO_CHAR(A.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') = TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY') AND
        A.DEAL_NO NOT IN (SELECT PRIOR_DEAL_NO
                          FROM   DN_TRN_REPO_ROLLOVER
                          WHERE  PRIOR_DEAL_NO= A.DEAL_NO) AND
        A.DEAL_NO NOT IN (SELECT PRIOR_DEAL_NO
                          FROM   DN_TRN_REPO_SETTLEMENT
                          WHERE  PRIOR_DEAL_NO= A.DEAL_NO)  ;
  */
--=======================================================================================================================
--ADJUSTING THE PASING AMOUNT AND DRCR_STATUS ACCORDING TO INTEREST

 IF FALSE THEN --TO_CHAR(TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY'),'DD')='01'
      --REVERSE REPO
      SELECT NVL(SUM(INT_AMOUNT),0)
      INTO   M_SUM_INT
      FROM(
      SELECT INT_AMOUNT
      FROM   DN_TRN_REPO_FRESH
      WHERE  BORR_PORTFOLIO_CODE = M_ID_PORTCODE AND
             MATURITY_DATE >  ADD_MONTHS(TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY'),-1) AND
             MATURITY_DATE <= TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY') AND
             APP_STATUS    = 'CONF'
      UNION ALL
      SELECT NVL(INT_AMOUNT,0)
      FROM   DN_TRN_REPO_ROLLOVER
      WHERE  BORR_PORTFOLIO_CODE = M_ID_PORTCODE AND
             MATURITY_DATE >  ADD_MONTHS(TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY'),-1) AND
             MATURITY_DATE <= TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY') AND
             APP_STATUS    = 'CONF');

      --REPO
      SELECT NVL(SUM(INT_AMOUNT),0)
      INTO   MREPO_SUM_INT
      FROM(
      SELECT INT_AMOUNT
      FROM   DN_TRN_REPO_FRESH
      WHERE  LEND_PORTFOLIO_CODE = M_ID_PORTCODE AND
             MATURITY_DATE >  ADD_MONTHS(TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY'),-1) AND
             MATURITY_DATE <= TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY') AND
             APP_STATUS    = 'CONF'
      UNION ALL
      SELECT NVL(INT_AMOUNT,0)
      FROM   DN_TRN_REPO_ROLLOVER
      WHERE  LEND_PORTFOLIO_CODE = M_ID_PORTCODE AND
             MATURITY_DATE >  ADD_MONTHS(TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY'),-1) AND
             MATURITY_DATE <= TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY') AND
             APP_STATUS    = 'CONF');

M_OD_INT  := NVL(DN_GET_OD_ACCRUED_INTEREST(M_ID_PORTCODE, ADD_MONTHS(TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY'),-1),TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY')-1),0);--add by waruna 2012-01-06
M_SUM_INT := M_SUM_INT+M_OD_INT;-- add by waruna 2012-01-06

  MREPO_SUM_INT :=0;
  M_SUM_INT     :=0;

    IF MREPO_SUM_INT > M_SUM_INT  THEN --(CR>DR) CR

       IF M_CR_DR_STATUS_NEW='CR' THEN
         M_CR_DR_STATUS:='CR';
         MM_AMT:=MM_AMT_NEW+ (MREPO_SUM_INT-M_SUM_INT);
       ELSE  --'DR'
         IF MM_AMT_NEW >= (MREPO_SUM_INT-M_SUM_INT) THEN
           M_CR_DR_STATUS:='DR';
           MM_AMT:=MM_AMT_NEW - (MREPO_SUM_INT-M_SUM_INT);
         ELSE
           M_CR_DR_STATUS:='CR';
           MM_AMT:=(MREPO_SUM_INT-M_SUM_INT)-MM_AMT_NEW ;
         END IF;
       END IF;

    ELSE  --MREPO_SUM_INT <= M_SUM_INT --(CR<=DR) DR

        IF M_CR_DR_STATUS_NEW='DR' THEN
         M_CR_DR_STATUS:='DR';
         MM_AMT:=MM_AMT_NEW+ (M_SUM_INT-MREPO_SUM_INT);
        ELSE  --'CR'
         IF MM_AMT_NEW > (M_SUM_INT-MREPO_SUM_INT) THEN
           M_CR_DR_STATUS:='CR';
           MM_AMT:=MM_AMT_NEW - (M_SUM_INT-MREPO_SUM_INT);
         ELSE
           M_CR_DR_STATUS:='DR';
           MM_AMT:=(M_SUM_INT-MREPO_SUM_INT)-MM_AMT_NEW ;
         END IF;
       END IF;

    END IF;
 ELSE
 MM_AMT:=MM_AMT_NEW;
 M_CR_DR_STATUS:=M_CR_DR_STATUS_NEW;
 END IF;
--MM_AMT:=NVL(MM_AMT,0);

--dbms_output.put_line('M_CR_DR_STATUS---'||M_CR_DR_STATUS||' M_CNT_FRESH--'||M_CNT_FRESH||' M_CNT_REPO-- '||M_CNT_REPO||' MREPO_CNT_FRESH--'||MREPO_CNT_FRESH ||' MREPO_CNT_REPO--'||MREPO_CNT_REPO);
--RAISE_APPLICATION_ERROR(-20201,'****''M_CR_DR_STATUS---'||M_CR_DR_STATUS||' M_CNT_FRESH--'||M_CNT_FRESH||' M_CNT_REPO-- '||M_CNT_REPO||' MREPO_CNT_FRESH--'||MREPO_CNT_FRESH ||' MREPO_CNT_REPO--'||MREPO_CNT_REPO);
--======================================================================================================================
-------------------------------------------------------------------------------------------------------------------------
--*********************************************DR**************************************************************************88
--*********************************************DR***********************************************************************
--*********************************************DR***********************************************************************
--*********************************************DR***********************************************************************
------------------------------------------------------------------------------------------------------------------------
IF  M_CR_DR_STATUS = 'DR' THEN

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

 IF M_CNT_FRESH = 0 AND M_CNT_REPO =0 AND MREPO_CNT_FRESH = 0 AND MREPO_CNT_REPO =0 THEN
 --------------------------------------------------------------------------

 /*
 SELECT TO_CHAR(TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY')+1 ,'DD-MM-YYYY')
 INTO   MAT_DATE
 FROM   DUAL;

 SELECT TO_CHAR(ADD_MONTHS (TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY') , 12),'DD-MM-YYYY')
 INTO M_END_DATE
 FROM DUAL;



 M_TENOR :=   TO_DATE(MAT_DATE,'DD-MM-YYYY')- TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY');
 SELECT DN_FIN_LEG2_F_LEG1(MM_AMT,MRATE,M_TENOR,'A365',TO_DATE(MAT_DATE,'DD/MM/YYYY'))
 INTO   LEG2_VAL
 FROM   DUAL;
 SELECT LEG2_VAL-MM_AMT
 INTO   INT_AMT
 FROM   DUAL;
---------------------------------------------------------------------------

--REVERSE REPO
 MBFSL_REPOFRESH_IN1(MDEAL_NO,M_ID_PORTCODE,'ADLMT',MINST_TYPE,MHAIRCUT,'N','N','Y',
                     'SLR','Act/365','UD',M_E_VAL_DATE,MRATE,'Y',MM_AMT,LEG2_VAL,MAT_DATE, --14 = Y->N --N--Y
                     M_TENOR,INT_AMT,M_USER,'MAIN1',MDEAL_NO,'N','SC',NULL);

 UPDATE DN_TRN_REPO_FRESH
 SET ORG_DEAL_NO = MDEAL_NO
 WHERE DEAL_NO = MDEAL_NO;


 DN_AUTO_REPOROLLOVER_JOB_SUB1(MDEAL_NO,MINST_TYPE,MHAIRCUT,M_ID_PORTCODE,MM_AMT,MRATE);

  INSERT INTO DN_TRN_REPO_DETAILS (DEAL_NO, BROKER_CODE, SECURITY_CODE,PRICE,SETTL_PAY_FRQ,START_DATE,END_DATE)
  VALUES(MDEAL_NO, M_BROKER_CODE, M_SECURITY_CODE, M_PRICE,M_SETTL_PAY_FRQ,TO_DATE(M_START_DATE,'DD/MM/YYYY'),TO_DATE(M_END_DATE,'DD/MM/YYYY'));


   SELECT FRQ_PER_YEAR  INTO M_FRQ_PER_YEAR
   FROM DN_REF_SETT_PAY_FREQUENCY
   WHERE FRQ_ID = M_SETTL_PAY_FRQ;

   DN_LOAN_INSERT_PAYFREQ(M_ID_PORTCODE,MDEAL_NO, M_START_DATE,M_END_DATE,M_FRQ_PER_YEAR,M_RATE,MM_AMT);
   */
 M_E_VAL_DATE_1 := M_E_VAL_DATE;
 SELECT TO_CHAR(ADD_MONTHS (TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY') , 12),'DD-MM-YYYY')
 INTO M_END_DATE
 FROM DUAL;

 SELECT FRQ_PER_YEAR  INTO M_FRQ_PER_YEAR
 FROM DN_REF_SETT_PAY_FREQUENCY
 WHERE FRQ_ID = M_SETTL_PAY_FRQ;



     M_SDATE:= TO_DATE(M_START_DATE,'DD/MM/YYYY');
     M_EDATE:= TO_DATE(M_END_DATE,'DD/MM/YYYY');

     M_TOT_TENOR :=   TO_DATE(M_EDATE,'DD-MM-YYYY')- TO_DATE(M_SDATE,'DD-MM-YYYY');

      SELECT MONTHS_BETWEEN(TO_DATE(M_EDATE,'DD-MM-YYYY'),TO_DATE(M_SDATE,'DD-MM-YYYY')) AS MONTHS_BETWEEN INTO M_NO_OF_MONTHES
      FROM Dual;
      M_TOT_PAY_FREQ := M_NO_OF_MONTHES/12*M_FRQ_PER_YEAR;

     /*SELECT DN_FIN_LEG2_F_LEG1(M_LEG1,M_RATE,M_TOT_TENOR,'A365',TO_DATE(M_EDATE,'DD/MM/YYYY'))
     INTO   M_LEG2_VAL
     FROM   DUAL;*/
     dbms_output.put_line('FV='||M_LEG2_VAL);

     M_EFF_RATE := M_RATE;--GET_AER_TO_EFF_INT(M_RATE*100,M_FRQ_PER_YEAR)/100; --calculate effective rate for the payment period

     dbms_output.put_line('M_EFF_RATE='||M_EFF_RATE);

     IF (1-POWER((1+M_EFF_RATE/M_FRQ_PER_YEAR),-M_FRQ_PER_YEAR)) <>0 AND M_FRQ_PER_YEAR > 0 THEN

    -- dbms_output.put_line('M_LEG1='||M_LEG1||'M_EFF_RATE='||M_EFF_RATE||'M_TOT_PAY_FREQ='||M_TOT_PAY_FREQ||'M_NO_OF_MONTHES='||M_NO_OF_MONTHES);
     M_DUE_AMOUNT := ROUND(M_EFF_RATE/M_FRQ_PER_YEAR*MM_AMT/(1-POWER((1+M_EFF_RATE/M_FRQ_PER_YEAR),-M_TOT_PAY_FREQ)),2);--calculate payment amount theoritical(ordinary anuity )
     dbms_output.put_line('M_DUE_AMOUNT='||M_DUE_AMOUNT);
     END IF;



    -- dbms_output.put_line('M_DUE_AMOUNT='||M_DUE_AMOUNT||'M_PAY_FREQ='||M_PAY_FREQ);
  IF M_TOT_PAY_FREQ = '1' THEN

         SELECT TO_CHAR(ADD_MONTHS (TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY') , 12*M_TOT_PAY_FREQ),'DD-MM-YYYY')
         INTO   MAT_DATE
         FROM   DUAL;

         SELECT TO_CHAR(ADD_MONTHS (TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY') , 12),'DD-MM-YYYY')
         INTO M_END_DATE
         FROM DUAL;

         M_TENOR :=   TO_DATE(MAT_DATE,'DD-MM-YYYY')- TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY');

         SELECT DN_FIN_LEG2_F_LEG1(MM_AMT,M_EFF_RATE,M_TENOR,'A365',TO_DATE(MAT_DATE,'DD/MM/YYYY'))
         INTO   LEG2_VAL
         FROM   DUAL;

         SELECT LEG2_VAL-MM_AMT
         INTO   INT_AMT
         FROM   DUAL;

      MBFSL_REPOFRESH_IN1(MDEAL_NO,M_ID_PORTCODE,'ADLMT',MINST_TYPE,MHAIRCUT,'N','N','Y',
                     'SLR','Act/365','UD',M_E_VAL_DATE,M_EFF_RATE,'N',MM_AMT,LEG2_VAL,MAT_DATE, --14 = Y->N --N--Y
                     M_TENOR,INT_AMT,M_USER,'MAIN1',MDEAL_NO,'N','SC',NULL);

      UPDATE DN_TRN_REPO_FRESH
      SET ORG_DEAL_NO = MDEAL_NO
      WHERE DEAL_NO = MDEAL_NO;

      M_ORG_DEAL_NO:=MDEAL_NO;

      DN_AUTO_REPOROLLOVER_JOB_SUB1(MDEAL_NO,MINST_TYPE,MHAIRCUT,M_ID_PORTCODE,MM_AMT,MRATE);

      INSERT INTO DN_TRN_REPO_DETAILS (DEAL_NO, BROKER_CODE, SECURITY_CODE,PRICE,SETTL_PAY_FRQ,START_DATE,END_DATE,NOMINAL_RATE)
      VALUES(MDEAL_NO, M_BROKER_CODE, M_SECURITY_CODE, M_PRICE,M_SETTL_PAY_FRQ,TO_DATE(M_START_DATE,'DD/MM/YYYY'),TO_DATE(M_END_DATE,'DD/MM/YYYY'),M_RATE);

      INSERT INTO DN_LOAN_SETTL_SCHEDULE
      (FACILITY_NO,DEAL_NO,FREQ_NO,DUE_DATE,DUE_AMOUNT)
      VALUES
      (M_ID_PORTCODE,M_ORG_DEAL_NO,1,TO_DATE(M_END_DATE,'DD/MM/YYYY'),LEG2_VAL); --M_LEG2_VAL-->LEG2_VAL CHANGE BY WARUNA 2013-01-18

 END IF;

  IF  M_FRQ_PER_YEAR <>'1' and M_FRQ_PER_YEAR > 0 THEN

      M_NUM:=TO_NUMBER(M_FRQ_PER_YEAR);
      M_NUM2:=12/M_NUM;
      M_A:=1;--1

      SELECT ADD_MONTHS(M_SDATE,M_NUM2)
      INTO  M_PAYDATE
      FROM DUAL;
      WHILE (M_PAYDATE <= M_EDATE) LOOP -- =




                                      dbms_output.put_line('M_A='||M_A||M_PAYDATE||'_'||M_EDATE);
                                      MDEAL_NO := NULL;

                                      IF M_A = 1 THEN

                                         SELECT TO_CHAR(M_PAYDATE,'DD-MM-YYYY')
                                         INTO   MAT_DATE
                                         FROM   DUAL;

                                         M_TENOR :=   TO_DATE(MAT_DATE,'DD-MM-YYYY')- TO_DATE(M_E_VAL_DATE_1,'DD-MM-YYYY');
                                         --RAISE_APPLICATION_ERROR(-20201,'MM_AMT='||MM_AMT||'M_EFF_RATE='
                                         SELECT DN_FIN_LEG2_F_LEG1(MM_AMT,M_EFF_RATE,M_TENOR,'A365',TO_DATE(MAT_DATE,'DD/MM/YYYY'))
                                         INTO   LEG2_VAL
                                         FROM   DUAL;

                                         SELECT LEG2_VAL-MM_AMT
                                         INTO   INT_AMT
                                         FROM   DUAL;

                                      MBFSL_REPOFRESH_IN1(MDEAL_NO,M_ID_PORTCODE,'ADLMT',MINST_TYPE,MHAIRCUT,'N','N','Y',
                                                     'SLR','Act/365','UD',M_E_VAL_DATE_1,M_EFF_RATE,'N',MM_AMT,LEG2_VAL,MAT_DATE, --14 = Y->N --N--Y
                                                     M_TENOR,INT_AMT,M_USER,'MAIN1',MDEAL_NO,'N','SC',NULL);

                                      UPDATE DN_TRN_REPO_FRESH
                                      SET ORG_DEAL_NO = MDEAL_NO
                                      WHERE DEAL_NO = MDEAL_NO;

                                      M_ORG_DEAL_NO:=MDEAL_NO;
                                      M_LAST_DEAL_NO:= MDEAL_NO;
                                      DN_AUTO_REPOROLLOVER_JOB_SUB1(MDEAL_NO,MINST_TYPE,MHAIRCUT,M_ID_PORTCODE,MM_AMT,MRATE);

                                      INSERT INTO DN_TRN_REPO_DETAILS (DEAL_NO, BROKER_CODE, SECURITY_CODE,PRICE,SETTL_PAY_FRQ,START_DATE,END_DATE,NOMINAL_RATE)
                                      VALUES(MDEAL_NO, M_BROKER_CODE, M_SECURITY_CODE, M_PRICE,M_SETTL_PAY_FRQ,TO_DATE(M_START_DATE,'DD/MM/YYYY'),TO_DATE(M_END_DATE,'DD/MM/YYYY'),M_RATE);

                                      ELSE

                                        -----------------------------------------
                                         SELECT TO_CHAR(M_PAYDATE,'DD-MM-YYYY')
                                         INTO   MAT_DATE
                                         FROM   DUAL;


                                           SELECT NVL(SUM(LEG2_VALUE),0)
                                                      INTO   M_LAST_LEG2
                                                      FROM(
                                                      SELECT LEG2_VALUE
                                                      FROM   DN_TRN_REPO_FRESH
                                                      WHERE  BORR_PORTFOLIO_CODE = M_ID_PORTCODE AND
                                                             DEAL_NO = M_LAST_DEAL_NO


                                                      UNION ALL
                                                      SELECT LEG2_VALUE
                                                      FROM   DN_TRN_REPO_ROLLOVER
                                                      WHERE  BORR_PORTFOLIO_CODE = M_ID_PORTCODE AND
                                                              DEAL_NO = M_LAST_DEAL_NO
                                                             );
                                                -----


                                         M_TENOR :=   TO_DATE(MAT_DATE,'DD-MM-YYYY')- TO_DATE(M_E_VAL_DATE_1,'DD-MM-YYYY');

                                         SELECT DN_FIN_LEG2_F_LEG1((M_LAST_LEG2-M_DUE_AMOUNT),M_EFF_RATE,M_TENOR,'A365',TO_DATE(MAT_DATE,'DD/MM/YYYY'))
                                         INTO   LEG2_VAL
                                         FROM   DUAL;

                                         SELECT LEG2_VAL-(M_LAST_LEG2-M_DUE_AMOUNT)
                                         INTO   INT_AMT
                                         FROM   DUAL;

                                         IF TO_DATE(M_END_DATE,'DD/MM/YYYY') = TO_DATE(MAT_DATE,'DD/MM/YYYY') THEN

                                              LEG2_VAL := M_DUE_AMOUNT;
                                              INT_AMT  := LEG2_VAL - (M_LAST_LEG2-M_DUE_AMOUNT);

                                         END IF;
                                         ----------------------------------------
                                          --REPO
                                          MBFSL_REPOROLLOVER_IN1(MDEAL_NO,M_LAST_DEAL_NO,M_ID_PORTCODE,'ADLMT',MINST_TYPE,MHAIRCUT,
                                                                'N','N','Y','SLR','Act/365','UD',M_E_VAL_DATE_1,M_EFF_RATE,'N',--15
                                                                (M_LAST_LEG2-M_DUE_AMOUNT),LEG2_VAL,MAT_DATE,M_TENOR,INT_AMT,0,M_DUE_AMOUNT,M_USER,--P TO B
                                                                'MAIN1',MDEAL_NO,'N','SC',NULL);

                                          M_LAST_DEAL_NO := MDEAL_NO;
                                          DN_AUTO_REPOROLLOVER_REPO_JOB(MDEAL_NO,MINST_TYPE,MHAIRCUT,M_ID_PORTCODE,M_DUE_AMOUNT,0);

                                           UPDATE DN_TRN_REPO_ROLLOVER
                                           SET ORG_DEAL_NO = M_ORG_DEAL_NO
                                           WHERE DEAL_NO = MDEAL_NO;

                                      END IF;

                                      INSERT INTO DN_LOAN_SETTL_SCHEDULE
                                        (FACILITY_NO,DEAL_NO,FREQ_NO,DUE_DATE,DUE_AMOUNT)
                                      VALUES
                                     (M_ID_PORTCODE,M_ORG_DEAL_NO,M_A,M_PAYDATE,M_DUE_AMOUNT);

     M_E_VAL_DATE_1:=TO_CHAR(M_PAYDATE,'DD/MM/YYYY');
     M_A:=M_A+1;

      SELECT ADD_MONTHS(M_SDATE,(M_NUM2 * M_A))
      INTO  M_PAYDATE
      FROM DUAL;
   END LOOP;

 END IF;






IF  M_FRQ_PER_YEAR < 0 THEN

      M_NUM:=TO_NUMBER(M_FRQ_PER_YEAR);
      M_NUM2:=12/M_NUM;
      M_A:=1;--1

      SELECT M_SDATE - M_FRQ_PER_YEAR
      INTO  M_PAYDATE
      FROM DUAL;
      
      M_EDATE := M_PAYDATE;
      
      WHILE (M_PAYDATE <= M_EDATE) LOOP -- =




                                      dbms_output.put_line('M_A='||M_A||M_PAYDATE||'_'||M_EDATE);
                                      MDEAL_NO := NULL;

                                      IF M_A = 1 THEN

                                         SELECT TO_CHAR(M_PAYDATE,'DD-MM-YYYY')
                                         INTO   MAT_DATE
                                         FROM   DUAL;

                                         M_TENOR :=   TO_DATE(MAT_DATE,'DD-MM-YYYY')- TO_DATE(M_E_VAL_DATE_1,'DD-MM-YYYY');
                                         --RAISE_APPLICATION_ERROR(-20201,'MM_AMT='||MM_AMT||'M_EFF_RATE='
                                         SELECT DN_FIN_LEG2_F_LEG1(MM_AMT,M_EFF_RATE,M_TENOR,'A365',TO_DATE(MAT_DATE,'DD/MM/YYYY'))
                                         INTO   LEG2_VAL
                                         FROM   DUAL;
                                         
                                         M_DUE_AMOUNT := LEG2_VAL;

                                         SELECT LEG2_VAL-MM_AMT
                                         INTO   INT_AMT
                                         FROM   DUAL;

                                      MBFSL_REPOFRESH_IN1(MDEAL_NO,M_ID_PORTCODE,'ADLMT',MINST_TYPE,MHAIRCUT,'N','N','Y',
                                                     'SLR','Act/365','UD',M_E_VAL_DATE_1,M_EFF_RATE,'N',MM_AMT,LEG2_VAL,MAT_DATE, --14 = Y->N --N--Y
                                                     M_TENOR,INT_AMT,M_USER,'MAIN1',MDEAL_NO,'N','SC',NULL);

                                      UPDATE DN_TRN_REPO_FRESH
                                      SET ORG_DEAL_NO = MDEAL_NO
                                      WHERE DEAL_NO = MDEAL_NO;

                                      M_ORG_DEAL_NO:=MDEAL_NO;
                                      M_LAST_DEAL_NO:= MDEAL_NO;
                                      DN_AUTO_REPOROLLOVER_JOB_SUB1(MDEAL_NO,MINST_TYPE,MHAIRCUT,M_ID_PORTCODE,MM_AMT,MRATE);

                                      INSERT INTO DN_TRN_REPO_DETAILS (DEAL_NO, BROKER_CODE, SECURITY_CODE,PRICE,SETTL_PAY_FRQ,START_DATE,END_DATE,NOMINAL_RATE)
                                      VALUES(MDEAL_NO, M_BROKER_CODE, M_SECURITY_CODE, M_PRICE,M_SETTL_PAY_FRQ,TO_DATE(M_START_DATE,'DD/MM/YYYY'),TO_DATE(M_END_DATE,'DD/MM/YYYY'),M_RATE);

                                      ELSE

                                        -----------------------------------------
                                         SELECT TO_CHAR(M_PAYDATE,'DD-MM-YYYY')
                                         INTO   MAT_DATE
                                         FROM   DUAL;


                                           SELECT NVL(SUM(LEG2_VALUE),0)
                                                      INTO   M_LAST_LEG2
                                                      FROM(
                                                      SELECT LEG2_VALUE
                                                      FROM   DN_TRN_REPO_FRESH
                                                      WHERE  BORR_PORTFOLIO_CODE = M_ID_PORTCODE AND
                                                             DEAL_NO = M_LAST_DEAL_NO


                                                      UNION ALL
                                                      SELECT LEG2_VALUE
                                                      FROM   DN_TRN_REPO_ROLLOVER
                                                      WHERE  BORR_PORTFOLIO_CODE = M_ID_PORTCODE AND
                                                              DEAL_NO = M_LAST_DEAL_NO
                                                             );
                                                -----


                                         M_TENOR :=   TO_DATE(MAT_DATE,'DD-MM-YYYY')- TO_DATE(M_E_VAL_DATE_1,'DD-MM-YYYY');

                                         SELECT DN_FIN_LEG2_F_LEG1((M_LAST_LEG2-M_DUE_AMOUNT),M_EFF_RATE,M_TENOR,'A365',TO_DATE(MAT_DATE,'DD/MM/YYYY'))
                                         INTO   LEG2_VAL
                                         FROM   DUAL;

                                         SELECT LEG2_VAL-(M_LAST_LEG2-M_DUE_AMOUNT)
                                         INTO   INT_AMT
                                         FROM   DUAL;

                                         IF TO_DATE(M_END_DATE,'DD/MM/YYYY') = TO_DATE(MAT_DATE,'DD/MM/YYYY') THEN

                                              LEG2_VAL := M_DUE_AMOUNT;
                                              INT_AMT  := LEG2_VAL - (M_LAST_LEG2-M_DUE_AMOUNT);

                                         END IF;
                                         ----------------------------------------
                                          --REPO
                                          MBFSL_REPOROLLOVER_IN1(MDEAL_NO,M_LAST_DEAL_NO,M_ID_PORTCODE,'ADLMT',MINST_TYPE,MHAIRCUT,
                                                                'N','N','Y','SLR','Act/365','UD',M_E_VAL_DATE_1,M_EFF_RATE,'N',--15
                                                                (M_LAST_LEG2-M_DUE_AMOUNT),LEG2_VAL,MAT_DATE,M_TENOR,INT_AMT,0,M_DUE_AMOUNT,M_USER,--P TO B
                                                                'MAIN1',MDEAL_NO,'N','SC',NULL);

                                          M_LAST_DEAL_NO := MDEAL_NO;
                                          DN_AUTO_REPOROLLOVER_REPO_JOB(MDEAL_NO,MINST_TYPE,MHAIRCUT,M_ID_PORTCODE,M_DUE_AMOUNT,0);

                                           UPDATE DN_TRN_REPO_ROLLOVER
                                           SET ORG_DEAL_NO = M_ORG_DEAL_NO
                                           WHERE DEAL_NO = MDEAL_NO;

                                      END IF;

                                      INSERT INTO DN_LOAN_SETTL_SCHEDULE
                                        (FACILITY_NO,DEAL_NO,FREQ_NO,DUE_DATE,DUE_AMOUNT)
                                      VALUES
                                     (M_ID_PORTCODE,M_ORG_DEAL_NO,M_A,M_PAYDATE,M_DUE_AMOUNT);

     M_E_VAL_DATE_1:=TO_CHAR(M_PAYDATE,'DD/MM/YYYY');
     M_A:=M_A+1;

      SELECT M_SDATE - M_FRQ_PER_YEAR * M_A
      INTO  M_PAYDATE
      FROM DUAL;
   END LOOP;

 END IF;






--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

END IF; ---END IF OF 'MREPO_CNT_REPO > 0'

END IF; -- DR
-------------------------------------------------------------------------------------------------------------------------
--*********************************************CR**************************************************************************88
--*********************************************CR***********************************************************************
--*********************************************CR***********************************************************************
--*********************************************CR***********************************************************************
------------------------------------------------------------------------------------------------------------------------




INSERT INTO DN_REF_RETAIL_CLIENTS_LOG(CLIENT_CODE,RUN_DATE,STATUS)
VALUES (M_ID_PORTCODE,TO_DATE(M_E_VAL_DATE,'DD-MM-YYYY-HH-MI-SS'),'RUN');

--COMMIT;

END DN_AUTO_REPOROLLOVER;

/
