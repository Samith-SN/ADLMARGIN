--------------------------------------------------------
--  DDL for Procedure TRN_RECEIPT_GROUP_NET_TOP_TMP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."TRN_RECEIPT_GROUP_NET_TOP_TMP" 

   (M_GROUP_NET_NO       IN OUT   DN_MAS_SETLE_GROUP_NET.GROUP_NET_NO%TYPE,
    M_GROUP_NET_MODE              DN_MAS_SETLE_GROUP_NET.GROUP_NET_MODE%TYPE,
    M_GROUP_AMOUNT                DN_MAS_SETLE_GROUP_NET.SETTLE_AMOUNT%TYPE,
    M_NET_AMOUNT                  DN_MAS_SETLE_GROUP_NET.SETTLE_AMOUNT%TYPE,
    M_BROKE                       DN_MAS_SETLE_GROUP_NET.BROKE_CODE%TYPE,
    M_FACILITY_NO                 DN_MAS_SETLE_GROUP_NET.FACILITY_NO%TYPE,
    M_CLIENT_CODE        VARCHAR,
    M_CLIENT_MANAGER     VARCHAR,--8
    M_SETTLE_MODE                 DN_MAS_SETLE_GROUP_NET.SETTLE_MODE%TYPE,
    M_LIC_BANK_CODE               DN_MAS_SETLE_GROUP_NET.LIC_BANK_CODE%TYPE,
    M_LIC_ACCNO                   DN_MAS_SETLE_GROUP_NET.LIC_ACCNO%TYPE,
    M_TO_DATE            VARCHAR,
    M_FROM_DATE          VARCHAR,
    M_TRN_DATE           VARCHAR,
    M_USER               VARCHAR,
    M_SAVE_ORDER_NO      VARCHAR,
    
    M_CHEQUE_NO          DN_MAS_SETLE_GROUP_NET.CHEQUE_NO%TYPE,    --add by waruna 2012-02-03
    M_BRANCH_CODE         DN_MAS_SETLE_GROUP_NET.BRANCH_CODE%TYPE,  --add by waruna 2012-02-03
    M_BANKING_DATE       VARCHAR, --add by waruna 2012-02-03
    M_REALISED_DATE      VARCHAR --add by waruna 2012-02-03
    )
AS

/*
      CREATED BY - K. M. WARUNA SRI JAYANATH
      CREATED ON - 2011-11-09
      SYSTEM     - LBMARGIN
                 - PROCESE 
                    - GROSS PAYMENT
                    - NET PAYMENT
                    - INDIVIDUAL PAYMENT 
*/

M_TOTAL_PAID      NUMBER;
TOTAL_PENDING     NUMBER;
M_DUMMY_COUNT     NUMBER;
M_GROUP_NET_SEQNO DN_MAS_SETLE_GROUP_NET.GROUP_NET_NO%TYPE;
M_PAY_NO          DN_TRN_BO_SETTL_PAYMENT.PAYMENT_NO%TYPE;
MM_FACILITY_NO    VARCHAR(10);
MM_FROM_DATE      VARCHAR(10);
MM_SETTLE_AMOUNT  DN_MAS_SETLE_GROUP_NET.SETTLE_AMOUNT%TYPE;

M_REC_NO          DN_TRN_BO_SETTL_RECEIPT_BULK.REC_NO%TYPE;
M_VAL_TRN_AMOUNT  NUMBER;

BEGIN

IF M_FACILITY_NO IS NULL THEN
  MM_FACILITY_NO := '%%';
ELSE
  MM_FACILITY_NO := M_FACILITY_NO;
END IF;

IF M_FROM_DATE IS NULL THEN
   MM_FROM_DATE := TO_DATE('01-01-2011','DD-MM-YYYY');
ELSE
   MM_FROM_DATE := M_FROM_DATE;
END IF;

IF M_GROUP_NET_MODE = 'GROUP' THEN
  MM_SETTLE_AMOUNT := M_GROUP_AMOUNT;
ELSIF M_GROUP_NET_MODE = 'NET' THEN
  MM_SETTLE_AMOUNT := M_NET_AMOUNT;
ELSIF M_GROUP_NET_MODE = 'INV' THEN
  MM_SETTLE_AMOUNT := M_GROUP_AMOUNT;
ELSE
  RAISE_APPLICATION_ERROR(-20201,'M_GROUP_NET_MODE ERROR');
END IF; 

M_VAL_TRN_AMOUNT := 0;
M_GROUP_NET_NO   := NULL;
--RAISE_APPLICATION_ERROR(-20201,M_GROUP_NET_MODE||'**M_GROUP_AMOUNT**'||M_GROUP_AMOUNT||'**M_NET_AMOUNT**'||M_NET_AMOUNT||MM_FACILITY_NO);

              IF M_GROUP_NET_MODE = 'GROUP' OR M_GROUP_NET_MODE = 'NET'  THEN
              
                 SELECT 'GRMT'||TO_CHAR(SYSDATE,'YY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_GROUP_NET_REC.NEXTVAL),3,'0') INTO M_GROUP_NET_SEQNO FROM DUAL;
                 M_GROUP_NET_NO:=M_GROUP_NET_SEQNO;
              
                
                 INSERT INTO DN_MAS_RECEIPT_GROUP_NET(GROUP_NET_NO,GROUP_NET_MODE,SETTLE_AMOUNT,BROKE_CODE,FACILITY_NO,SETTLE_MODE,LIC_BANK_CODE,LIC_ACCNO,TRNDATE,ENTDATE,DN_USER,APP_STATUS)
                 VALUES(M_GROUP_NET_SEQNO,M_GROUP_NET_MODE,MM_SETTLE_AMOUNT,M_BROKE,M_FACILITY_NO,M_SETTLE_MODE,M_LIC_BANK_CODE,M_LIC_ACCNO,TO_DATE(M_TRN_DATE,'DD-MM-YYYY'),SYSDATE,M_USER,'ENT');
       
              END IF;
        SELECT COUNT(*) INTO M_DUMMY_COUNT FROM DN_SETTLE_PRE_TEMP;
   --  RAISE_APPLICATION_ERROR(-20201,'***temp table count**'||M_DUMMY_COUNT||'***'||M_BROKE||'**'||M_USER||MM_FACILITY_NO||'***'||MM_FROM_DATE||'***'||M_TO_DATE||'@@@');
                 FOR X IN ( 
                /* SELECT A.SETTL_TYPE, A.FACILITI_NO, A.BROKER_CODE, A.TRNAMOUNT,
                        A.SETTLE_AMOUNT, A.PENDING_AMOUNT, A.NET_AMOUNT,
                        A.BUY_SETLE_DATE, A.SEL_SETLE_DATE, A.USER_NAME, A.EXE_DATE
                 FROM   DN_SETTLE_PRE_TEMP A 
                 WHERE A.USER_NAME      = M_USER
                 AND   A.SEL_SETLE_DATE >= TO_DATE(MM_FROM_DATE,'DD/MM/YYYY')
                 AND   A.SEL_SETLE_DATE <= TO_DATE(M_TO_DATE,'DD/MM/YYYY')
                 AND   A.BROKER_CODE    = M_BROKE
                 AND   A.FACILITI_NO LIKE MM_FACILITY_NO
                 AND   A.NET_AMOUNT>0*/
                 
                 SELECT  FACILITI_NO,BROKER_CODE ,SUM(NET_AMOUNT_REC) NET_AMOUNT_REC,SUM(NET_AMOUNT_PAY) NET_AMOUNT_PAY,BUY_SETLE_DATE,SEL_SETLE_DATE 
                 FROM (
                 
                 SELECT  A.FACILITI_NO, A.BROKER_CODE,A.NET_AMOUNT NET_AMOUNT_REC , 0 NET_AMOUNT_PAY,
                        A.BUY_SETLE_DATE, A.SEL_SETLE_DATE
                                
                 FROM   DN_SETTLE_PRE_TEMP A 
                 WHERE A.USER_NAME      = M_USER
                 AND   A.SEL_SETLE_DATE >= TO_DATE(MM_FROM_DATE,'DD/MM/YYYY')
                 AND   A.SEL_SETLE_DATE <= TO_DATE(M_TO_DATE,'DD/MM/YYYY')
                 AND   A.BROKER_CODE    = M_BROKE
                 AND   A.FACILITI_NO LIKE MM_FACILITY_NO
                 AND   A.SETTL_TYPE='REC'
                 AND   A.NET_AMOUNT>0
                 UNION ALL                 
                 SELECT  A.FACILITI_NO, A.BROKER_CODE, 0  NET_AMOUNT_REC ,A.NET_AMOUNT NET_AMOUNT_PAY,
                         A.BUY_SETLE_DATE, A.SEL_SETLE_DATE
                 FROM   DN_SETTLE_PRE_TEMP A 
                 WHERE A.USER_NAME      = M_USER
                 AND   A.SEL_SETLE_DATE >= TO_DATE(MM_FROM_DATE,'DD/MM/YYYY')
                 AND   A.SEL_SETLE_DATE <= TO_DATE(M_TO_DATE,'DD/MM/YYYY')
                 AND   A.BROKER_CODE    = M_BROKE
                 AND   A.FACILITI_NO LIKE MM_FACILITY_NO
                 AND SETTL_TYPE='PAY'
                 AND   A.NET_AMOUNT>0
                 
                 ) GROUP BY FACILITI_NO,BROKER_CODE,BUY_SETLE_DATE,SEL_SETLE_DATE
                                
                 ) LOOP
            --  RAISE_APPLICATION_ERROR(-20201,'***temp table count**'||M_DUMMY_COUNT||'***'||X.SETTL_TYPE);
           IF  X.NET_AMOUNT_REC > 0 THEN -- IF X.SETTL_TYPE='REC' THEN 
          
                            
              IF  M_GROUP_NET_MODE = 'INV' THEN
                
                /*M_PAY_NO:=NULL;
                TRN_GROUP_PAYMENTS_BULK_TMP (M_PAY_NO,
                X.FACILITI_NO,'CACC',X.BROKER_CODE,           
                M_SETTLE_MODE, --SETTLE_MODE
                M_GROUP_AMOUNT,--X.NET_AMOUNT,--PAY_AMOUNT
                M_LIC_BANK_CODE,
                M_LIC_ACCNO,
                M_USER,
                TO_CHAR(X.SEL_SETLE_DATE,'DD/MM/YYYY'),
                M_PAY_NO,
                '',--OTH_COMMENT 
                'D',
                M_GROUP_NET_NO
                );*/
                
                  M_REC_NO := NULL;
                  TRN_GROUP_RECIEPTS_BULK_TMP (M_REC_NO,
                  'GEN', -- PORTFOLIO_CODE
                  'CACC',-- SUSPENSE_ENTRY_TYPE
                  X.BROKER_CODE, -- SUS_REF_NO
                  X.BROKER_CODE, -- ID_PORTFOLIO_CODE,
                  M_SETTLE_MODE, -- SETTLE_MODE
                  M_GROUP_AMOUNT,  -- REC_AMOUNT
                  '-', -- PAYER_BRANCH_CODE
                  '-', -- PAYER_ACC_NO
                  '-', -- PAYER_REF
                  NULL,--OTH_COMMENTS
                  M_LIC_BANK_CODE,--BRANCH_CODE
                  M_LIC_ACCNO,--ACC_NO
                  'CRD',--STATUS,
                  M_USER,
                  TO_CHAR(X.SEL_SETLE_DATE,'DD/MM/YYYY'),-- M_EFF_VALDATE 
                  M_REC_NO,--REC_NO
                  X.FACILITI_NO,
                  M_GROUP_NET_NO,
                  M_SAVE_ORDER_NO,
                  M_TRN_DATE,
                  M_CHEQUE_NO,
                  M_BANKING_DATE,
                  M_REALISED_DATE
                  );
                
                M_VAL_TRN_AMOUNT := M_VAL_TRN_AMOUNT+M_GROUP_AMOUNT;
                M_GROUP_NET_NO   := M_REC_NO;
                END IF;
                   
                IF M_GROUP_NET_MODE = 'GROUP'    THEN
               
                /*
                M_PAY_NO:=NULL;
                TRN_GROUP_PAYMENTS_BULK_TMP (M_PAY_NO,
                X.FACILITI_NO,'CACC',X.BROKER_CODE,           
                M_SETTLE_MODE, --SETTLE_MODE
                X.NET_AMOUNT_PAY, -- LEAST(M_GROUP_AMOUNT,X.NET_AMOUNT_PAY),--X.NET_AMOUNT,--PAY_AMOUNT ??????
                M_LIC_BANK_CODE,
                M_LIC_ACCNO,
                M_USER,
                TO_CHAR(X.SEL_SETLE_DATE,'DD/MM/YYYY'),
                M_PAY_NO,
                '',--OTH_COMMENT 
                'D',
                M_GROUP_NET_NO
                );*/
                
                M_REC_NO := NULL;
                  TRN_GROUP_RECIEPTS_BULK_TMP (M_REC_NO,
                  'GEN', -- PORTFOLIO_CODE
                  'CACC',-- SUSPENSE_ENTRY_TYPE
                  X.BROKER_CODE, -- SUS_REF_NO
                  X.BROKER_CODE, -- ID_PORTFOLIO_CODE,
                  M_SETTLE_MODE, -- SETTLE_MODE
                  X.NET_AMOUNT_REC,  -- REC_AMOUNT
                  '-', -- PAYER_BRANCH_CODE
                  '-', -- PAYER_ACC_NO
                  '-', -- PAYER_REF
                  NULL,--OTH_COMMENTS
                  M_LIC_BANK_CODE,--BRANCH_CODE
                  M_LIC_ACCNO,--ACC_NO
                  'CRD',--STATUS,
                  M_USER,
                  TO_CHAR(X.SEL_SETLE_DATE,'DD/MM/YYYY'),-- M_EFF_VALDATE 
                  M_REC_NO,--REC_NO
                  X.FACILITI_NO,
                  M_GROUP_NET_NO,
                  M_SAVE_ORDER_NO,
                  M_TRN_DATE,
                  M_CHEQUE_NO,
                  M_BANKING_DATE,
                  M_REALISED_DATE
                  );
                
                M_VAL_TRN_AMOUNT:=M_VAL_TRN_AMOUNT+X.NET_AMOUNT_REC;--LEAST(M_GROUP_AMOUNT,X.NET_AMOUNT_PAY)--X.NET_AMOUNT; ????
                
                END IF;   
              
                IF  M_GROUP_NET_MODE = 'NET'  AND X.NET_AMOUNT_REC -X.NET_AMOUNT_PAY>0   THEN
              --   RAISE_APPLICATION_ERROR(-20201,'*'||M_GROUP_NET_MODE||'---'|| X.NET_AMOUNT_REC||'--'||X.NET_AMOUNT_PAY);         
                /*M_PAY_NO:=NULL;
                TRN_GROUP_PAYMENTS_BULK_TMP (M_PAY_NO,
                X.FACILITI_NO,'CACC',X.BROKER_CODE,           
                M_SETTLE_MODE, --SETTLE_MODE
                X.NET_AMOUNT_PAY,--PAY_AMOUNT
                M_LIC_BANK_CODE,
                M_LIC_ACCNO,
                M_USER,
                TO_CHAR(X.SEL_SETLE_DATE,'DD/MM/YYYY'),
                M_PAY_NO,
                '',--OTH_COMMENT 
                'D',
                M_GROUP_NET_NO
                );*/
                
                  M_REC_NO := NULL;
                  TRN_GROUP_RECIEPTS_BULK_TMP (M_REC_NO,
                  'GEN', -- PORTFOLIO_CODE
                  'CACC',-- SUSPENSE_ENTRY_TYPE
                  X.BROKER_CODE, -- SUS_REF_NO
                  X.BROKER_CODE, -- ID_PORTFOLIO_CODE,
                  M_SETTLE_MODE, -- SETTLE_MODE
                  X.NET_AMOUNT_REC,  -- REC_AMOUNT
                  '-', -- PAYER_BRANCH_CODE
                  '-', -- PAYER_ACC_NO
                  '-', -- PAYER_REF
                  NULL,--OTH_COMMENTS
                  M_LIC_BANK_CODE,--BRANCH_CODE
                  M_LIC_ACCNO,--ACC_NO
                  'CRD',--STATUS,
                  M_USER,
                  TO_CHAR(X.SEL_SETLE_DATE,'DD/MM/YYYY'),-- M_EFF_VALDATE 
                  M_REC_NO,--REC_NO
                  X.FACILITI_NO,
                  M_GROUP_NET_NO,
                  M_SAVE_ORDER_NO,
                  M_TRN_DATE,
                  M_CHEQUE_NO,
                  M_BANKING_DATE,
                  M_REALISED_DATE
                  
                  
                  );
                M_VAL_TRN_AMOUNT:=M_VAL_TRN_AMOUNT+X.NET_AMOUNT_REC;
                
                
                
                --M_PAY_NO:=NULL;
                
                /*TRN_NET_PAYMENTS_NET_TMP (M_PAY_NO,
                X.FACILITI_NO,'CACC',X.BROKER_CODE,           
                M_SETTLE_MODE, --SETTLE_MODE
                X.NET_AMOUNT_PAY- X.NET_AMOUNT_REC,--X.NET_AMOUNT,--PAY_AMOUNT ??????
                M_LIC_BANK_CODE,
                M_LIC_ACCNO,
                M_USER,
                TO_CHAR(X.SEL_SETLE_DATE,'DD/MM/YYYY'),
                M_PAY_NO,
                '',--OTH_COMMENT 
                'D',
                M_GROUP_NET_NO
                );*/
                
                  --M_REC_NO := NULL;
                  TRN_NET_RECIEPTS_NET_TMP (M_REC_NO,
                  'GEN', -- PORTFOLIO_CODE
                  'CACC',-- SUSPENSE_ENTRY_TYPE
                  X.BROKER_CODE, -- SUS_REF_NO
                  X.BROKER_CODE, -- ID_PORTFOLIO_CODE,
                  M_SETTLE_MODE, -- SETTLE_MODE
                  X.NET_AMOUNT_REC-X.NET_AMOUNT_PAY,  -- REC_AMOUNT
                  '-', -- PAYER_BRANCH_CODE
                  '-', -- PAYER_ACC_NO
                  '-', -- PAYER_REF
                  NULL,--OTH_COMMENTS
                  M_LIC_BANK_CODE,--BRANCH_CODE
                  M_LIC_ACCNO,--ACC_NO
                  'CRD',--STATUS,
                  M_USER,
                  TO_CHAR(X.SEL_SETLE_DATE,'DD/MM/YYYY'),-- M_EFF_VALDATE 
                  M_REC_NO,--REC_NO
                  X.FACILITI_NO,
                  M_GROUP_NET_NO,
                  M_SAVE_ORDER_NO,
                  M_TRN_DATE
                  );
                
                
                END IF; --NET IF
                
               END IF;-- END PAY IF
 -------------------------------------PAYMENT --------------------------------------------------------                
                IF M_GROUP_NET_MODE = 'NET' THEN
            
                
                IF  X.NET_AMOUNT_REC > 0 AND X.NET_AMOUNT_REC -X.NET_AMOUNT_PAY>0   THEN ---- IF X.SETTL_TYPE = 'REC' THEN 
            
            
             
                  
                  /*M_REC_NO := NULL;
                  TRN_GROUP_RECIEPTS_BULK_TMP (M_REC_NO,
                  'GEN', -- PORTFOLIO_CODE
                  'CACC',-- SUSPENSE_ENTRY_TYPE
                  X.BROKER_CODE, -- SUS_REF_NO
                  X.BROKER_CODE, -- ID_PORTFOLIO_CODE,
                  M_SETTLE_MODE, -- SETTLE_MODE
                  X.NET_AMOUNT_REC,  -- REC_AMOUNT
                  '-', -- PAYER_BRANCH_CODE
                  '-', -- PAYER_ACC_NO
                  '-', -- PAYER_REF
                  NULL,--OTH_COMMENTS
                  M_LIC_BANK_CODE,--BRANCH_CODE
                  M_LIC_ACCNO,--ACC_NO
                  'CRD',--STATUS,
                  M_USER,
                  TO_CHAR(X.SEL_SETLE_DATE,'DD/MM/YYYY'),-- M_EFF_VALDATE 
                  M_REC_NO,--REC_NO
                  X.FACILITI_NO,
                  M_GROUP_NET_NO
                  );*/
                --RAISE_APPLICATION_ERROR(-20201,'***temp table count**'||M_DUMMY_COUNT||'***'||X.NET_AMOUNT_PAY);  
                M_PAY_NO:=NULL;
                TRN_GROUP_PAYMENTS_BULK_TMP (M_PAY_NO,
                X.FACILITI_NO,'CACC',X.BROKER_CODE,           
                M_SETTLE_MODE, --SETTLE_MODE
                X.NET_AMOUNT_PAY, -- LEAST(M_GROUP_AMOUNT,X.NET_AMOUNT_PAY),--X.NET_AMOUNT,--PAY_AMOUNT ??????
                M_LIC_BANK_CODE,
                M_LIC_ACCNO,
                M_USER,
                TO_CHAR(X.SEL_SETLE_DATE,'DD/MM/YYYY'),
                M_PAY_NO,
                '',--OTH_COMMENT 
                'D',
                M_GROUP_NET_NO,
                M_SAVE_ORDER_NO,
                M_TRN_DATE
                );
                  
                  M_VAL_TRN_AMOUNT:=M_VAL_TRN_AMOUNT-X.NET_AMOUNT_PAY;
                  
                  END IF;-- REC if
                  
                  
                   IF  X.NET_AMOUNT_REC > 0 AND X.NET_AMOUNT_REC -X.NET_AMOUNT_PAY< 0   THEN ---- IF X.SETTL_TYPE = 'PAY' THEN 
            
            
             
                  
                 /* M_REC_NO := NULL;
                  TRN_NET_RECIEPTS_NET_TMP (M_REC_NO,
                  'GEN', -- PORTFOLIO_CODE
                  'CACC',-- SUSPENSE_ENTRY_TYPE
                  X.BROKER_CODE, -- SUS_REF_NO
                  X.BROKER_CODE, -- ID_PORTFOLIO_CODE,
                  M_SETTLE_MODE, -- SETTLE_MODE
                  X.NET_AMOUNT_REC-X.NET_AMOUNT_PAY,  -- REC_AMOUNT
                  '-', -- PAYER_BRANCH_CODE
                  '-', -- PAYER_ACC_NO
                  '-', -- PAYER_REF
                  NULL,--OTH_COMMENTS
                  M_LIC_BANK_CODE,--BRANCH_CODE
                  M_LIC_ACCNO,--ACC_NO
                  'CRD',--STATUS,
                  M_USER,
                  TO_CHAR(X.SEL_SETLE_DATE,'DD/MM/YYYY'),-- M_EFF_VALDATE 
                  M_REC_NO,--REC_NO
                  X.FACILITI_NO,
                  M_GROUP_NET_NO
                  );*/
                  
                  
                TRN_NET_PAYMENTS_NET_TMP (M_PAY_NO,
                X.FACILITI_NO,'CACC',X.BROKER_CODE,           
                M_SETTLE_MODE, --SETTLE_MODE
                X.NET_AMOUNT_PAY- X.NET_AMOUNT_REC,--X.NET_AMOUNT,--PAY_AMOUNT ??????
                M_LIC_BANK_CODE,
                M_LIC_ACCNO,
                M_USER,
                TO_CHAR(X.SEL_SETLE_DATE,'DD/MM/YYYY'),
                M_PAY_NO,
                '',--OTH_COMMENT 
                'D',
                M_GROUP_NET_NO,
                M_SAVE_ORDER_NO,
                M_TRN_DATE
                );
                  
                 --  M_REC_NO := NULL;
                  /*TRN_GROUP_RECIEPTS_BULK_TMP (M_REC_NO,
                  'GEN', -- PORTFOLIO_CODE
                  'CACC',-- SUSPENSE_ENTRY_TYPE
                  X.BROKER_CODE, -- SUS_REF_NO
                  X.BROKER_CODE, -- ID_PORTFOLIO_CODE,
                  M_SETTLE_MODE, -- SETTLE_MODE
                  X.NET_AMOUNT_REC,  -- REC_AMOUNT
                  '-', -- PAYER_BRANCH_CODE
                  '-', -- PAYER_ACC_NO
                  '-', -- PAYER_REF
                  NULL,--OTH_COMMENTS
                  M_LIC_BANK_CODE,--BRANCH_CODE
                  M_LIC_ACCNO,--ACC_NO
                  'CRD',--STATUS,
                  M_USER,
                  TO_CHAR(X.SEL_SETLE_DATE,'DD/MM/YYYY'),-- M_EFF_VALDATE 
                  M_REC_NO,--REC_NO
                  X.FACILITI_NO,
                  M_GROUP_NET_NO
                  );*/
                  M_PAY_NO:=NULL;
                TRN_GROUP_PAYMENTS_BULK_TMP (M_PAY_NO,
                X.FACILITI_NO,'CACC',X.BROKER_CODE,           
                M_SETTLE_MODE, --SETTLE_MODE
                X.NET_AMOUNT_PAY, -- LEAST(M_GROUP_AMOUNT,X.NET_AMOUNT_PAY),--X.NET_AMOUNT,--PAY_AMOUNT ??????
                M_LIC_BANK_CODE,
                M_LIC_ACCNO,
                M_USER,
                TO_CHAR(X.SEL_SETLE_DATE,'DD/MM/YYYY'),
                M_PAY_NO,
                '',--OTH_COMMENT 
                'D',
                M_GROUP_NET_NO,
                M_SAVE_ORDER_NO,
                M_TRN_DATE
                );
                  
                  
                  M_VAL_TRN_AMOUNT:=M_VAL_TRN_AMOUNT-X.NET_AMOUNT_PAY;
                  END IF;
                    
                    
                    
                END IF;--NET IF
                  
             END LOOP;
    --RAISE_APPLICATION_ERROR(-20201,'DATA MISMATCH..EXPECTED:= '||MM_SETTLE_AMOUNT||' EXCUTE:= '||M_VAL_TRN_AMOUNT);            
    IF(MM_SETTLE_AMOUNT<>M_VAL_TRN_AMOUNT)   THEN
    
     RAISE_APPLICATION_ERROR(-20201,'DATA MISMATCH..EXPECTED:= '||MM_SETTLE_AMOUNT||' EXCUTE:= '||M_VAL_TRN_AMOUNT);
     
    END IF;

--DELETE FROM DN_SETTLE_PRE_TEMP;  --comment by waruna 2012-02-01

END ; 

/
