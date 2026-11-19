--------------------------------------------------------
--  DDL for Procedure MBFSL_OUTRIGHT_IN1_PF
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_OUTRIGHT_IN1_PF" 
(
    M_DEAL_NO  IN OUT    DN_TRN_OUTP_SALE.DEAL_NO%TYPE,
  	M_BCODE              DN_TRN_OUTP_SALE.BUY_PORTFOLIO_CODE%TYPE,
    M_SCODE              DN_TRN_OUTP_SALE.SELL_PORTFOLIO_CODE%TYPE,--
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
    M_CUST_STAT          CHAR,--added by nirmala
    M_SCRIPT_STAT        DN_TRN_OUTP_SALE.SCRIPT_STATUS%TYPE,
    M_GDEAL_NUMBER       DN_TRN_OUTP_SALE.DEAL_NO%TYPE,
    M_DEAL_TYPE          VARCHAR2,
    M_NOMALUE            DN_TRN_OUTP_SALE.NOMINAL_VALUE%TYPE,
    M_BUY_DATE           VARCHAR2,
    M_SEL_DATE           VARCHAR2,
    M_CONTRACT_NO        DN_TRN_OUTP_SALE.CONTRACT_NO%TYPE,
    M_INVENTORY_TYPE     DN_TRN_OUTP_SALE.INVENTORY_TYPE%TYPE,--ADDED BY SVA ON 23-03-2005 FOR CUSTODIAN INVENTORY
    M_SCREEN             VARCHAR2
   -- M_SWIFT_STAT         DN_TRN_OUTP_SALE.SWIFT_STATUS%TYPE--added by Manjula on 20-07-2004 VC of PCTF NO 0406-051

)

AS

   M_USER             DN_TRN_OUTP_SALE.DN_USER%TYPE;
   M_VAL_DATE         DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE;
   M_BASIS            DN_TRN_OUTP_SALE.INT_RATE_BASE_CODE%TYPE;
   M_TENOR            NUMBER;
   MM_CURRENCY_VALUE  DN_REF_EXCHANGE_RATES.CURRENCY_VALUE%TYPE;--CURRENCY
   err_num   varchar2(200);
   err_msg   varchar2(200);
   M_COST2              DN_TRN_OUTP_SALE.COST%TYPE;

BEGIN

--RAISE_APPLICATION_ERROR(-20201,'M_SETVAL********************'||M_SETVAL);


DN_VALIDATE_SAVE_RIGHTS(M_USERNAME,M_SCREEN); --added by ashini on 31/10/2005 for sr0509-047


    -- PROCEDURE  -  TO INSERT OUTRIGHT DETAILS
    -- SYSTEM     -  MBFSL SYSTEM
    -- CREATED BY -  V.THILAKESAN.
    -- CREATED ON -  25/06/1999
    -- MODIFIED BY -  V.SUKATHIS. TO ACTIVAT LIMITS PROCEDURES
    -- MODIFIED ON -  17/1/2000

--     RAISE_APPLICATION_ERROR(-20201,'M_USERNAME'||M_USERNAME||'M_SEL_DATETYPE'||M_SEL_DATETYPE||'M_B_CODE'||M_B_CODE);
 --RAISE_APPLICATION_ERROR(-20201,'M_SETVAL********************'||M_SETVAL);
--add by waruna 2010-12-22

IF M_COST IS NULL THEN
M_COST2:=0;
else
M_COST2:=M_COST;
END IF;
  
IF M_DEAL_TYPE = 'DEBT'  THEN ---------------------1

    IF SUBSTR(M_USERNAME,1,1)=' ' OR M_USERNAME IS NULL THEN ------------------2
       M_USER:='Un Identify';
    ELSE
       M_USER:=M_USERNAME;
    END IF;                                              ------------------2

    IF M_SEL_DATETYPE<>'UD' THEN                         ------------------3
       SELECT DN_FIN_EFF_VALDATE(M_SEL_DATETYPE) INTO M_VAL_DATE FROM DUAL;
    ELSE
       SELECT TO_DATE(M_V_DATE,'DD/MM/YYYY') INTO M_VAL_DATE FROM DUAL;
    END IF;                                             ------------------3
    --Select then Base code
    SELECT
      INT_RATE_BASE_CODE
    INTO
      M_BASIS
    FROM DN_REF_INTR_BASE
    WHERE INTR_BASE_DESC=M_B_CODE;

    --Creating new sequence
    IF M_DEAL_NUMBER IS NULL THEN          ------------------4
       --SELECT TO_CHAR(SYSDATE,'YY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_OUTRIGHT.NEXTVAL),3,'0') INTO M_DEAL_NO FROM DUAL;
       SELECT TO_CHAR(SYSDATE,'YY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||LPAD(TO_CHAR(DN_SEQ_OUTRIGHT.NEXTVAL),4,'0') INTO M_DEAL_NO FROM DUAL;
       M_DEAL_NO:=  'ORMT'||M_DEAL_NO;
    ELSE
       M_DEAL_NO:=M_DEAL_NUMBER;
    END IF;                               ------------------4




IF M_DEAL_NO IS NOT NULL THEN          ------------------5

IF M_CURR<>'SLR' THEN --CURRENCY       ------------------6
------------------------------------------------CURRENCY
SELECT  CURRENCY_VALUE
INTO    MM_CURRENCY_VALUE
FROM    DN_REF_EXCHANGE_RATES
WHERE   CURR_CODE=M_CURR;

 INSERT INTO DN_TRN_DEAL_CURRENCY
  (DEAL_NO,LEG1_VALUE,LEG2_VALUE,CURR_CODE,ACC_INT)
 VALUES
  (M_DEAL_NO,M_COST,M_FACEVAL,M_CURR,M_ACCINT);
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
	       SETTLE_VALUE       =M_SETVAL*MM_CURRENCY_VALUE, --CURRENCY
	       PRICE_CLEAN        =M_CLEAN,
	       FACE_VALUE         =M_FACEVAL*MM_CURRENCY_VALUE,--CURRENCY
	       PRICE_DIRTY        =M_DIRTY,
	       ACC_INT            =M_ACCINT*MM_CURRENCY_VALUE, --CURRENCY
	       COST               =M_COST2*MM_CURRENCY_VALUE,   --CURRENCY
           DN_USER            =M_USER,
           CUSTODIAL_STATUS   =M_CUST_STAT,
           SCRIPT_STATUS      =M_SCRIPT_STAT, --$$##SC--scriptless
           CONTRACT_NO        =M_CONTRACT_NO,
           INVENTORY_TYPE     =M_INVENTORY_TYPE--ADDED BY SVA ON 23-03-2005 FOR CUSTODIAN INVENTORY
          -- SWIFT_STATUS       =M_SWIFT_STAT -- added by Manjula  on 20-07-2004 VC of PCTF-0406-051
       WHERE
           DEAL_NO=M_DEAL_NO
           AND
           APP_STATUS='PF-ENT';--APPRO2 - ENT Changed  by ashini for sr0603-093 on 29-03-2006


       IF SQL%NOTFOUND THEN          ------------------7
         IF (SUBSTR(M_DEAL_NUMBER,1,2)='GO')THEN     ------------------8
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
           CUSTODIAL_STATUS,
          SCRIPT_STATUS ,--$$##SC --scriptless
          GROUP_DEALNO,
          APP_STATUS,
          CONTRACT_NO,
          INVENTORY_TYPE     --ADDED BY SVA ON 23-03-2005 FOR CUSTODIAN INVENTORY
          --SWIFT_STATUS -- ADDED BY MANJULA ON 20-07-2004 VC of PCTF 0406-051
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
	       M_YIELD/100,    -- Modified by Pubudu
	       M_SETVAL*MM_CURRENCY_VALUE,--CURRENCY
	       M_CLEAN,
	       M_FACEVAL*MM_CURRENCY_VALUE,--CURRENCY
	       M_DIRTY,
	       M_ACCINT*MM_CURRENCY_VALUE,--CURRENCY
	       M_COST2*MM_CURRENCY_VALUE,--CURRENCY
           M_USER,
           M_CUST_STAT,
           M_SCRIPT_STAT,--scriptless
           M_GDEAL_NUMBER,
           'CANCEL',
           M_CONTRACT_NO,
           M_INVENTORY_TYPE--ADDED BY SVA ON 23-03-2005 FOR CUSTODIAN INVENTORY

           --M_SWIFT_STAT  -- ADDED BY MANJULA ON 19-07-2004 VC of PCTF 0406-051
           );

           UPDATE DN_TRN_OUTP_SALE
           SET    GROUP_PORT_TYPE=(SELECT DECODE(A.BUY_PORTFOLIO_CODE,'GROUP','B','S')
                                  FROM   DN_TRN_OUTP_SALE A
                                 WHERE   DEAL_NO=M_DEAL_NO)
           WHERE  GROUP_DEALNO=M_DEAL_NO;


         ELSE   ------------------8

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
           CUSTODIAL_STATUS,
          SCRIPT_STATUS,  --scriptless
          GROUP_DEALNO,
          CONTRACT_NO,
          INVENTORY_TYPE     --ADDED BY SVA ON 23-03-2005 FOR CUSTODIAN INVENTORY
         -- SWIFT_STATUS -- ADDED BY MANJULA ON 20-07-2004 VC of PCTF 0406-051
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
	       M_YIELD/100,    -- Modified by Pubudu
	       M_SETVAL*MM_CURRENCY_VALUE,--CURRENCY
	       M_CLEAN,
	       M_FACEVAL*MM_CURRENCY_VALUE,--CURRENCY
	       M_DIRTY,
	       M_ACCINT*MM_CURRENCY_VALUE,--CURRENCY
	       M_COST2*MM_CURRENCY_VALUE,--CURRENCY
           M_USER,
           M_CUST_STAT,
           M_SCRIPT_STAT,--scriptless
           M_GDEAL_NUMBER,
           M_CONTRACT_NO,
           M_INVENTORY_TYPE--ADDED BY SVA ON 23-03-2005 FOR CUSTODIAN INVENTORY
           --M_SWIFT_STAT  -- ADDED BY MANJULA ON 20-07-2004 VC of PCTF 0406-051
           );
        END IF;--GROUP DEAL          ------------------8


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



       END IF;  ------------------7








ELSE --CURRENCY   ------------------6
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
	       COST               =M_COST2,
           DN_USER            =M_USER,
           CUSTODIAL_STATUS   =M_CUST_STAT,
           SCRIPT_STATUS      =M_SCRIPT_STAT, --scriptless
           CONTRACT_NO        =M_CONTRACT_NO,
           INVENTORY_TYPE     =M_INVENTORY_TYPE--ADDED BY SVA ON 23-03-2005 FOR CUSTODIAN INVENTORY
          -- SWIFT_STATUS       =M_SWIFT_STAT -- added by Manjula  on 20-07-2004 VC of PCTF 0406-051
       WHERE
           DEAL_NO=M_DEAL_NO
           AND
           APP_STATUS='PF-ENT'; --APPRO2 - ENT Changed  by ashini for sr0603-093 on 29-03-2006




       IF SQL%NOTFOUND THEN   ------------------9
        IF (SUBSTR(M_DEAL_NUMBER,1,2)='GO')THEN   ------------------10
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
           CUSTODIAL_STATUS,
          SCRIPT_STATUS,  --scriptless
          GROUP_DEALNO,
          APP_STATUS,
          CONTRACT_NO,
          INVENTORY_TYPE     --ADDED BY SVA ON 23-03-2005 FOR CUSTODIAN INVENTORY
         -- SWIFT_STATUS  -- added by Manjula  on 19-07-2004 VC of PCTF 0406-051
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
	       M_YIELD/100,    -- Modified by Pubudu
	       M_SETVAL,
	       M_CLEAN,
	       M_FACEVAL,
	       M_DIRTY,
	       M_ACCINT,
	       M_COST2,
           M_USER,
           M_CUST_STAT,
           M_SCRIPT_STAT,--scriptless
           M_GDEAL_NUMBER,
           'CANCEL',
           M_CONTRACT_NO,
           M_INVENTORY_TYPE--ADDED BY SVA ON 23-03-2005 FOR CUSTODIAN INVENTORY
           --M_SWIFT_STAT  -- added by Manjula  on 19-07-2004 VC of PCTF 0406-051
           );

           UPDATE DN_TRN_OUTP_SALE
           SET    GROUP_PORT_TYPE=(SELECT DECODE(A.BUY_PORTFOLIO_CODE,'GROUP','B','S')
                                  FROM   DN_TRN_OUTP_SALE A
                                 WHERE   DEAL_NO=M_DEAL_NO)
           WHERE  GROUP_DEALNO=M_DEAL_NO;
        ELSE  ------------------10
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
           CUSTODIAL_STATUS,
          SCRIPT_STATUS,  --scriptless
          GROUP_DEALNO,
          CONTRACT_NO,
          INVENTORY_TYPE     --ADDED BY SVA ON 23-03-2005 FOR CUSTODIAN INVENTORY
        --  SWIFT_STATUS  -- added by Manjula  on 19-07-2004 VC of PCTF 0406-051
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
	       M_YIELD/100,    -- Modified by Pubudu
	       M_SETVAL,
	       M_CLEAN,
	       M_FACEVAL,
	       M_DIRTY,
	       M_ACCINT,
	       M_COST2,
           M_USER,
           M_CUST_STAT,
           M_SCRIPT_STAT,--scriptless
           M_GDEAL_NUMBER,
           M_CONTRACT_NO,
           M_INVENTORY_TYPE--ADDED BY SVA ON 23-03-2005 FOR CUSTODIAN INVENTORY
           --M_SWIFT_STAT  -- added by Manjula  on 20-07-2004 VC of PCTF 0406-051
           );
           END IF;--GROUP DEALS  ------------------10

        --***************ADDED FOR TIME LOG REQUIREMRNT  BY S.YASODHA****************
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



        END IF;  ------------------9

END IF;    ------------------10

--DN_CHECK_FIGURES_OR(M_DEAL_NO,'1');

END IF;  ------------------6







ELSE               ---------------------1



       M_USER:=M_USERNAME;

--RAISE_APPLICATION_ERROR(-20201,'M_USER***********'||M_USER);
    IF M_DEAL_NUMBER IS NULL THEN   ---------------------11
      -- SELECT TO_CHAR(SYSDATE,'YY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_OUTRIGHT.NEXTVAL),3,'0') INTO M_DEAL_NO FROM DUAL;
        SELECT TO_CHAR(SYSDATE,'YY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||LPAD(TO_CHAR(DN_SEQ_OUTRIGHT.NEXTVAL),4,'0') INTO M_DEAL_NO FROM DUAL;
       M_DEAL_NO:=  'ORMT'||M_DEAL_NO;
      -- RAISE_APPLICATION_ERROR(-20201,'M_DEAL_NO***********'||M_DEAL_NO);
    ELSE  ---------------------11
       M_DEAL_NO:=M_DEAL_NUMBER;
    END IF;  ---------------------11

    SELECT TO_DATE(M_V_DATE,'DD/MM/YYYY') INTO M_VAL_DATE FROM DUAL;
   -- RAISE_APPLICATION_ERROR(-20201,'M_VAL_DATE***********'||M_VAL_DATE);
    IF M_CURR<>'SLR' THEN --CURRENCY   ---------------------12

     SELECT  CURRENCY_VALUE  INTO    MM_CURRENCY_VALUE
     FROM    DN_REF_EXCHANGE_RATES WHERE   CURR_CODE=M_CURR;

     INSERT INTO DN_TRN_DEAL_CURRENCY
     (DEAL_NO,LEG1_VALUE,LEG2_VALUE,CURR_CODE,ACC_INT)
      VALUES
     (M_DEAL_NO,M_COST2,M_FACEVAL,M_CURR,M_ACCINT);


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
	         YIELD              =0,
	         SETTLE_VALUE       =M_SETVAL*MM_CURRENCY_VALUE,--((M_FACEVAL* M_CLEAN)+M_COST),--CHANGED BY SARANGA ON 25-06-2004
	         PRICE_CLEAN        =M_CLEAN,
	         FACE_VALUE         =M_FACEVAL*MM_CURRENCY_VALUE,
	         PRICE_DIRTY        =M_DIRTY,
	         ACC_INT            =0,
	         COST               =M_SETVAL*MM_CURRENCY_VALUE,--((M_FACEVAL* M_CLEAN)+M_COST),--CHANGED BY SARANGA ON 28-06-2004 ---0, --CHANGED BY SM ON 19/12/2003
             DN_USER            = M_USER,
             CUSTODIAL_STATUS   = M_CUST_STAT,
             SCRIPT_STATUS      = M_SCRIPT_STAT ,
             NOMINAL_VALUE      = M_NOMALUE,
             PURCHASE_COST      = M_FACEVAL* M_CLEAN   ,
             BROKER_COST        = M_COST2,
             CONTRACT_NO        = M_CONTRACT_NO,
             INVENTORY_TYPE     =M_INVENTORY_TYPE--ADDED BY SVA ON 23-03-2005 FOR CUSTODIAN INVENTORY
            -- SWIFT_STATUS       =M_SWIFT_STAT -- added by Manjula  on 20-07-2004 VC of PCTF 0406-051
        WHERE
           DEAL_NO=M_DEAL_NO
           AND
           APP_STATUS='PF-ENT'; --APPRO2 - ENT Changed  by ashini for sr0603-093 on 29-03-2006
   IF SQL%NOTFOUND THEN  ---------------------13

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
           CUSTODIAL_STATUS,
           SCRIPT_STATUS,  --scriptless
           GROUP_DEALNO,
           NOMINAL_VALUE,
           PURCHASE_COST,
           BROKER_COST,
           CONTRACT_NO,
          INVENTORY_TYPE     --ADDED BY SVA ON 23-03-2005 FOR CUSTODIAN INVENTORY
          -- SWIFT_STATUS  -- added by Manjula  on 20-07-2004 VC of PCTF 0406-051
          )
          VALUES(
           M_DEAL_NO,
  	       M_BCODE,
           M_SCODE,
  	       M_INSTYPE,
	       M_SECIDEN,
	       M_ENCODE,
	       M_CURR,
	       'UD',
	       M_VAL_DATE,
	       'A365',
	       0 ,
	       M_SETVAL,--((M_FACEVAL* M_CLEAN)+M_COST),
	       M_CLEAN,
	       M_FACEVAL*MM_CURRENCY_VALUE,
	       M_DIRTY,
	       M_ACCINT*MM_CURRENCY_VALUE,--CURRENCY
	       M_COST2*MM_CURRENCY_VALUE,--CURRENCY ---???MIGHT NEED TO CHANGE
           M_USER,
           M_CUST_STAT,
           M_SCRIPT_STAT,--scriptless
           M_GDEAL_NUMBER,
           M_NOMALUE,
           M_FACEVAL* M_CLEAN   ,
           M_COST2,
           M_CONTRACT_NO,
           M_INVENTORY_TYPE--ADDED BY SVA ON 23-03-2005 FOR CUSTODIAN INVENTORY
          -- M_SWIFT_STAT  -- ADDED BY MANJULA ON 20-07-2004 VC of PCTF 0406-051
           );


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

        END IF;  ---------------------13





ELSE  ----------    2
--RAISE_APPLICATION_ERROR(-20201,'M_SETVAL - '||M_SETVAL ||' - M_FACEVAL - '||M_FACEVAL);
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
	       YIELD              =0,
	       SETTLE_VALUE       =M_SETVAL,--((M_FACEVAL* M_CLEAN)+M_COST),--CHANGED BY SARANGA ON 25-06-2004
	       PRICE_CLEAN        =M_CLEAN,
	       FACE_VALUE         =M_FACEVAL,
	       PRICE_DIRTY        =M_DIRTY,
	       ACC_INT            =0,
	       COST               =M_SETVAL,--((M_FACEVAL* M_CLEAN)+M_COST),--CHANGED BY SARANGA ON 28-06-2004  ---0, --CHANGED BY SM ON 19/12/2003
           DN_USER            =M_USER,
           CUSTODIAL_STATUS   =M_CUST_STAT,
           SCRIPT_STATUS      =M_SCRIPT_STAT ,
           NOMINAL_VALUE      = M_NOMALUE,
           PURCHASE_COST      = M_FACEVAL* M_CLEAN   ,
           BROKER_COST        = M_COST2,
           CONTRACT_NO        = M_CONTRACT_NO,
           INVENTORY_TYPE     =M_INVENTORY_TYPE--ADDED BY SVA ON 23-03-2005 FOR CUSTODIAN INVENTORY
         --  SWIFT_STATUS       =M_SWIFT_STAT -- added by Manjula  on 20-07-2004 VC of PCTF 0406-051
       WHERE
           DEAL_NO=M_DEAL_NO
           AND
           APP_STATUS='PF-ENT';  --APPRO2 - ENT Changed  by ashini for sr0603-093 on 29-03-2006


                  IF SQL%NOTFOUND THEN  ---------------------13

--RAISE_APPLICATION_ERROR(-20201,'M_FACEVAL*********'||M_FACEVAL||'M_DIRTY'||M_DIRTY||'M_CLEAN'||M_CLEAN||'M_COST'||M_COST);

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
           CUSTODIAL_STATUS,
          SCRIPT_STATUS,  --scriptless
          GROUP_DEALNO,
           NOMINAL_VALUE,
           PURCHASE_COST,
           BROKER_COST,
           CONTRACT_NO,
          INVENTORY_TYPE     --ADDED BY SVA ON 23-03-2005 FOR CUSTODIAN INVENTORY
         --  SWIFT_STATUS  -- added by Manjula  on 20-07-2004 VC of PCTF 0406-051
          )
          VALUES(
           M_DEAL_NO,
  	       M_BCODE,
           M_SCODE,
  	       M_INSTYPE,
	       M_SECIDEN,
	       M_ENCODE,
	       M_CURR,
	       'UD',
	       M_VAL_DATE,
	       'A365',
	       0,    -- Modified by Pubudu
	       NVL(M_SETVAL,0),--((M_FACEVAL* M_CLEAN)+M_COST),--CHANGED BY SARANGA ON 25-06-2004
	       NVL(M_CLEAN,0),
	       M_FACEVAL,
	       NVL(M_DIRTY,0),
	       0,
	       NVL(M_SETVAL,0),--((M_FACEVAL* M_CLEAN)+M_COST), --CHANGED BY SARANGA ON 28-06-2004 ---0, --CHANGED BY SM ON 19/12/2003  -- 0,
           M_USER,
           M_CUST_STAT,
           M_SCRIPT_STAT,--scriptless
           M_GDEAL_NUMBER,
           M_NOMALUE,
           M_FACEVAL* M_CLEAN   ,
           M_COST2,
           M_CONTRACT_NO,
           M_INVENTORY_TYPE--ADDED BY SVA ON 23-03-2005 FOR CUSTODIAN INVENTORY
         --  M_SWIFT_STAT  -- ADDED BY MANJULA ON 20-07-2004 VC of PCTF 0406-051
           );
           END IF;--GROUP DEALS  ---------------------13
        --***************ADDED FOR TIME LOG REQUIREMRNT  BY S.YASODHA****************
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




END IF;   ---------------------12

MBFSL_OUTRIGHT_EQUITY_SETTLE(M_DEAL_NO,M_BUY_DATE,M_SEL_DATE);
IF  M_DEAL_TYPE = 'EQUITY_COR' THEN

UPDATE DN_TRN_OUTP_SALE SET  NO_OF_SETTL_MODES = 1  WHERE DEAL_NO=M_DEAL_NO;

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
                        'CASH',
                        M_CLEAN*M_FACEVAL,--CURRENCY
                        0,
                        M_BCODE,
                        '',
                        '',
                        '',
                        M_SCODE,
                        '',
                        '',
                        '' );

END IF;



END IF   ; ---------------------1

COMMIT;





/*
EXCEPTION
  WHEN OTHERS THEN
   ROLLBACK;

   err_num :=  substr(SQLCODE,1,15);
   err_msg := substr(SQLERRM,1,200) ;
  INSERT INTO DN_REF_SEQUENCE_LOG VALUES (M_DEAL_NO,err_num||''||err_msg,'ERROR IN OUTRIGHT1',SYSDATE);
  COMMIT;
 RAISE_APPLICATION_ERROR(-20201,SQLCODE||SQLERRM);


*/

END MBFSL_OUTRIGHT_IN1_PF;

/
