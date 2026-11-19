--------------------------------------------------------
--  DDL for Procedure DN_SETL_DATA_ADD_TEMP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_SETL_DATA_ADD_TEMP" 

   (
     M_FACILITI_NO         DN_SETTLE_PRE_TEMP.FACILITI_NO%TYPE,
     M_BROKER_CODE         DN_SETTLE_PRE_TEMP.BROKER_CODE%TYPE, 
     M_CLIENT_CODE         DN_REF_PORTFOLIO.CLIENT_CODE%TYPE, 
     M_FACILITY_MGR_CODE   DN_REF_PORTFOLIO.FACILITY_MGR_CODE%TYPE,
     M_FROM_DATE           VARCHAR,
     M_TO_DATE             VARCHAR,
     M_USER                DN_SETTLE_PRE_TEMP.USER_NAME%TYPE
   )

AS
EXC_PAY                BOOLEAN;
EXC_REC                BOOLEAN;
M_TIMESTAMP            TIMESTAMP ;
MM_FACILITI_NO         DN_SETTLE_PRE_TEMP.FACILITI_NO%TYPE;
MM_BROKER_CODE         DN_SETTLE_PRE_TEMP.BROKER_CODE%TYPE; 
MM_CLIENT_CODE         DN_REF_PORTFOLIO.CLIENT_CODE%TYPE;
MM_FACILITY_MGR_CODE   DN_REF_PORTFOLIO.FACILITY_MGR_CODE%TYPE;
MM_FROM_DATE           VARCHAR(10);
MM_TO_DATE             VARCHAR(10);
MM_TO_DATE_T3          VARCHAR(10);
MM_TO_DATE_T2          VARCHAR(10);
BEGIN

    /* PROCEDURE  -  DN_SETL_DATA_ADD_TEMP
                     ADD PENDING PAYMENT, RECEIPT TO TEMPERY TABLE
       SCREEN     -  Settlement Management ->   Broker Payments
       SYSTEM     -  LBMARGIN
       CREATED BY -  WARUNA SRI JAYANATH
       CREATED ON -  2011-11-09*/


EXC_PAY:=TRUE;
EXC_REC:=TRUE;

MM_FACILITI_NO       := M_FACILITI_NO;
MM_BROKER_CODE       := M_BROKER_CODE;
MM_CLIENT_CODE       := M_CLIENT_CODE;
MM_FACILITY_MGR_CODE := M_FACILITY_MGR_CODE;



IF M_FROM_DATE IS NULL THEN
MM_FROM_DATE:='10/01/2011';
ELSE 
MM_FROM_DATE:=M_FROM_DATE;
END IF;


IF M_TO_DATE  IS NULL THEN
SELECT TO_CHAR(A.LAST_DAILY+1,'DD/MM/YYYY') INTO  MM_TO_DATE  FROM DN_SYS_PARAMETER A;
ELSE
MM_TO_DATE:=M_TO_DATE;
END IF;

IF M_BROKER_CODE  IS NULL OR TRIM(UPPER(M_BROKER_CODE)) = 'NULL' THEN
MM_BROKER_CODE:='%';
ELSE
MM_BROKER_CODE:=M_BROKER_CODE;
END IF;

IF M_CLIENT_CODE  IS NULL OR TRIM(UPPER(M_CLIENT_CODE)) = 'NULL' THEN
MM_CLIENT_CODE:='%';
ELSE
MM_CLIENT_CODE:=M_CLIENT_CODE;
END IF;

IF M_FACILITI_NO  IS NULL OR TRIM(UPPER(M_FACILITI_NO)) = 'NULL' THEN
MM_FACILITI_NO:='%';
ELSE
MM_FACILITI_NO:=M_FACILITI_NO;
END IF;


IF M_FACILITY_MGR_CODE  IS NULL OR TRIM(UPPER(M_FACILITY_MGR_CODE)) = 'NULL'  THEN

MM_FACILITY_MGR_CODE:='%';
ELSE
MM_FACILITY_MGR_CODE:=M_FACILITY_MGR_CODE;
END IF;

MM_TO_DATE_T3 := TO_CHAR(DN_FIN_BUYER_SETTLE_DATE(MM_TO_DATE,2),'DD/MM/YYYY');
MM_TO_DATE_T2 := TO_CHAR(DN_FIN_BUYER_SETTLE_DATE(MM_TO_DATE,1),'DD/MM/YYYY');

--RAISE_APPLICATION_ERROR(-20201,MM_CLIENT_CODE||'**'||M_CLIENT_CODE||'******'||MM_FACILITY_MGR_CODE||'***'||M_FACILITY_MGR_CODE);

--RAISE_APPLICATION_ERROR(-20201,MM_FACILITI_NO||'****'||MM_FROM_DATE||'**'||MM_TO_DATE||MM_BROKER_CODE||MM_CLIENT_CODE||MM_FACILITY_MGR_CODE);
  DELETE FROM DN_SETTLE_PRE_TEMP;

  SELECT SYSTIMESTAMP INTO M_TIMESTAMP FROM DUAL;
  
  IF EXC_PAY=TRUE THEN
  
       
                INSERT INTO DN_SETTLE_PRE_TEMP(
                SETTL_TYPE, FACILITI_NO,BROKER_CODE, TRNAMOUNT,
                SETTLE_AMOUNT, PENDING_AMOUNT, NET_AMOUNT,
                BUY_SETLE_DATE, SEL_SETLE_DATE, USER_NAME,EXE_DATE) (
                  
                SELECT 'PAY',
                        A.BUY_PORTFOLIO_CODE,
                        A.SELL_PORTFOLIO_CODE,
                        A.TRNAMOUNT,
                        A.SETTLE_AMOUNT,
                        A.PENDING_PAYMENT ,
                        A.NET_AMOUNT,
                        BUY_SETLE_DATE,
                        A.SETLE_DATE,
                        M_USER,
                        SYSTIMESTAMP
                FROM( 
              
                SELECT GEN.BUY_PORTFOLIO_CODE ,
                GEN.SELL_PORTFOLIO_CODE, 
                SUM(GEN.TRNAMOUNT) TRNAMOUNT ,
                SUM(NVL(REC.REC_AMOUNT,0)) SETTLE_AMOUNT, 
                SUM(TRNAMOUNT-NVL(REC.REC_AMOUNT,0))-DN_GET_TOTAL_PENDING_PAYMENTS(GEN.BUY_PORTFOLIO_CODE,GEN.SELL_PORTFOLIO_CODE,TO_CHAR(GEN.BUY_SETLE_DATE,'DD/MM/YYYY')) NET_AMOUNT , 
                GEN.BUY_SETLE_DATE BUY_SETLE_DATE,
                GEN.BUY_SETLE_DATE SETLE_DATE , 
                DN_GET_TOTAL_PENDING_PAYMENTS(GEN.BUY_PORTFOLIO_CODE,GEN.SELL_PORTFOLIO_CODE,TO_CHAR(GEN.BUY_SETLE_DATE,'DD/MM/YYYY')) PENDING_PAYMENT
                 FROM (
                
                SELECT S.BUY_PORTFOLIO_CODE,
                S.SELL_PORTFOLIO_CODE,
                A.PORTFOLIO_CODE, 
                A.DN_PORTFOLIO_CODE,  
                SUM(A.TRNAMOUNT) TRNAMOUNT ,
                ST.BUY_SETLE_DATE  
                FROM DN_ACC_LICENCEE_GEN_ACCOUNT A, 
                DN_REF_PORTFOLIO P, 
                DN_TRN_OUTP_SALE S, 
                DN_TRN_OUTP_SALE_SETTLE_EQUITY ST, 
                DN_REF_PORTFOLIO W 
                
                WHERE ACC_TYPE_CODE=302 
                AND DRCR_STATUS='CR'
                AND DOCREFNO LIKE 'ORMT%' 
                AND A.DOCREFNO= S.DEAL_NO 
                AND (S.SELL_PORTFOLIO_CODE=P.PORTFOLIO_CODE AND P.PF_TYPE='C') 
                AND  ST.DEAL_NO=S.DEAL_NO 
                AND S.BUY_PORTFOLIO_CODE  LIKE MM_FACILITI_NO 
                AND S.SELL_PORTFOLIO_CODE LIKE MM_BROKER_CODE 
                AND NVL(W.CLIENT_CODE,'-') LIKE MM_CLIENT_CODE 
                AND NVL(W.FACILITY_MGR_CODE,'-') LIKE  MM_FACILITY_MGR_CODE 
                AND W.PORTFOLIO_CODE=S.BUY_PORTFOLIO_CODE 
                
                AND  ST.BUY_SETLE_DATE>=TO_DATE(MM_FROM_DATE,'DD/MM/YYYY')  
                AND  ST.BUY_SETLE_DATE<=TO_DATE(MM_TO_DATE,'DD/MM/YYYY')  
                AND  ST.SELL_SETLE_DATE>=TO_DATE(MM_FROM_DATE,'DD/MM/YYYY')  
                AND  ST.SELL_SETLE_DATE<=TO_DATE(MM_TO_DATE,'DD/MM/YYYY')  
                GROUP BY S.BUY_PORTFOLIO_CODE,
                         S.SELL_PORTFOLIO_CODE,
                         A.PORTFOLIO_CODE,
                         A.DN_PORTFOLIO_CODE,
                         ST.BUY_SETLE_DATE 
                 ) GEN, 
                
                (SELECT 
                   A.PORTFOLIO_CODE,
                   A.DN_PORTFOLIO_CODE,
                   SUM(A.AMOUNT) REC_AMOUNT,
                   A.EFF_VALDATE  
                FROM  DN_TRN_BO_SETTL_PAYMENT_BULK A,--DN_TRN_BO_SETTL_PAYMENT_BULK 
                DN_REF_PORTFOLIO W ,
                DN_TRN_BO_SETTL_PAYMENT B
                
                WHERE 
                W.PORTFOLIO_CODE=A.PORTFOLIO_CODE 
                AND A.PAYMENT_NO      = B.PAYMENT_NO
                AND B.PAY_STATUS      IN ('APPR1','CONF','SIG1','SIG2','PRINT')
                AND A.EFF_VALDATE       >= TO_DATE(MM_FROM_DATE,'DD/MM/YYYY')  
                AND A.EFF_VALDATE       <= TO_DATE(MM_TO_DATE,'DD/MM/YYYY')  
                AND  A.PORTFOLIO_CODE    LIKE  MM_FACILITI_NO
                AND  A.DN_PORTFOLIO_CODE LIKE  MM_BROKER_CODE 
                AND NVL(W.CLIENT_CODE,'-')        LIKE  MM_CLIENT_CODE 
                AND NVL(W.FACILITY_MGR_CODE,'-')  LIKE  MM_FACILITY_MGR_CODE
               
                
                GROUP BY A.PORTFOLIO_CODE,DN_PORTFOLIO_CODE ,A.EFF_VALDATE 
                ) REC  
                
                WHERE 
                GEN.SELL_PORTFOLIO_CODE=REC.DN_PORTFOLIO_CODE(+) AND 
                GEN.BUY_PORTFOLIO_CODE=REC.PORTFOLIO_CODE(+) 
                AND GEN.BUY_SETLE_DATE=REC.EFF_VALDATE(+) 
                
                GROUP BY  GEN.SELL_PORTFOLIO_CODE,
                GEN.BUY_PORTFOLIO_CODE,
                --GEN.PF_NAME,
                GEN.BUY_SETLE_DATE 
                ORDER BY GEN.BUY_PORTFOLIO_CODE,
                GEN.SELL_PORTFOLIO_CODE,
                GEN.BUY_SETLE_DATE 
                ) A WHERE A.NET_AMOUNT <>0
                -- ORDER BY BUY_SETLE_DATE DESC,SELL_PORTFOLIO_CODE,A.NET_AMOUNT DESC 
               );--END INSERT
  
  
----------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------- IF DEAL AMOUT 20M THEN 15% SHOULD PAY TO BROKER T+1-----------------------------------------------------------
 INSERT INTO DN_SETTLE_PRE_TEMP(
                SETTL_TYPE, FACILITI_NO,BROKER_CODE, 
                TRNAMOUNT,
                SETTLE_AMOUNT, PENDING_AMOUNT, NET_AMOUNT,
                BUY_SETLE_DATE, SEL_SETLE_DATE, USER_NAME,EXE_DATE) (
                SELECT * FROM (   
                SELECT 'PAY',
                        A.BUY_PORTFOLIO_CODE,
                        A.SELL_PORTFOLIO_CODE,
                        A.TRNAMOUNT,
                        /*CASE WHEN TRNAMOUNT > 2000000 THEN
                        -TRNAMOUNT*15/100
                        ELSE 0
                        END AS "TRNAMOUNT",*/
                        
                        A.SETTLE_AMOUNT,
                        A.PENDING_PAYMENT ,
                        
                       -- A.NET_AMOUNT,
                        
                        CASE WHEN A.TRNAMOUNT > 20000000 THEN
                        
                       A.TRNAMOUNT*15/100-PENDING_PAYMENT-A.SETTLE_AMOUNT
                       
                        ELSE 0
                        END AS "NET_AMOUNT",
                        
                        BUY_SETLE_DATE,
                        A.SETLE_DATE,
                        M_USER,
                        SYSTIMESTAMP
                FROM( 
              
              
               
                SELECT GEN.BUY_PORTFOLIO_CODE ,
                GEN.SELL_PORTFOLIO_CODE, 
                SUM(GEN.TRNAMOUNT) TRNAMOUNT ,
                SUM(NVL(REC.REC_AMOUNT,0)) SETTLE_AMOUNT, 
                SUM(TRNAMOUNT-NVL(REC.REC_AMOUNT,0))-DN_GET_TOTAL_PENDING_PAYMENTS(GEN.BUY_PORTFOLIO_CODE,GEN.SELL_PORTFOLIO_CODE,TO_CHAR(GEN.BUY_SETLE_DATE,'DD/MM/YYYY')) NET_AMOUNT , 
                GEN.BUY_SETLE_DATE BUY_SETLE_DATE,
                GEN.BUY_SETLE_DATE SETLE_DATE , 
                DN_GET_TOTAL_PENDING_PAYMENTS(GEN.BUY_PORTFOLIO_CODE,GEN.SELL_PORTFOLIO_CODE,TO_CHAR(GEN.BUY_SETLE_DATE,'DD/MM/YYYY')) PENDING_PAYMENT
                 FROM (
                
                SELECT S.BUY_PORTFOLIO_CODE,
                S.SELL_PORTFOLIO_CODE,
                A.PORTFOLIO_CODE, 
                A.DN_PORTFOLIO_CODE,  
                SUM(A.TRNAMOUNT) TRNAMOUNT ,
                ST.BUY_SETLE_DATE  
                FROM DN_ACC_LICENCEE_GEN_ACCOUNT A, 
                DN_REF_PORTFOLIO P, 
                DN_TRN_OUTP_SALE S, 
                DN_TRN_OUTP_SALE_SETTLE_EQUITY ST, 
                DN_REF_PORTFOLIO W 
                
                WHERE ACC_TYPE_CODE=302 
                AND DRCR_STATUS='CR'
                
                AND DOCREFNO LIKE 'ORMT%' 
                AND A.DOCREFNO= S.DEAL_NO 
                AND (S.SELL_PORTFOLIO_CODE=P.PORTFOLIO_CODE AND P.PF_TYPE='C') 
                AND  ST.DEAL_NO=S.DEAL_NO 
                AND S.BUY_PORTFOLIO_CODE  LIKE MM_FACILITI_NO 
                AND S.SELL_PORTFOLIO_CODE LIKE MM_BROKER_CODE 
                AND NVL(W.CLIENT_CODE,'-') LIKE MM_CLIENT_CODE 
                AND NVL(W.FACILITY_MGR_CODE,'-') LIKE  MM_FACILITY_MGR_CODE 
                AND W.PORTFOLIO_CODE=S.BUY_PORTFOLIO_CODE 
                
                AND  ST.BUY_SETLE_DATE>=TO_DATE(MM_TO_DATE_T3,'DD/MM/YYYY')  
                AND  ST.BUY_SETLE_DATE<=TO_DATE(MM_TO_DATE_T3,'DD/MM/YYYY')  
                AND  ST.SELL_SETLE_DATE>=TO_DATE(MM_TO_DATE_T3,'DD/MM/YYYY')  
                AND  ST.SELL_SETLE_DATE<=TO_DATE(MM_TO_DATE_T3,'DD/MM/YYYY')  
                GROUP BY S.BUY_PORTFOLIO_CODE,
                         S.SELL_PORTFOLIO_CODE,
                         A.PORTFOLIO_CODE,
                         A.DN_PORTFOLIO_CODE,
                         ST.BUY_SETLE_DATE 
                 ) GEN, 
                
                (SELECT 
                   A.PORTFOLIO_CODE,
                   A.DN_PORTFOLIO_CODE,
                   SUM(A.AMOUNT) REC_AMOUNT,
                   A.EFF_VALDATE  
                FROM  DN_TRN_BO_SETTL_PAYMENT_BULK A,--DN_TRN_BO_SETTL_PAYMENT_BULK 
                DN_REF_PORTFOLIO W ,
                DN_TRN_BO_SETTL_PAYMENT B
                
                WHERE 
                W.PORTFOLIO_CODE=A.PORTFOLIO_CODE 
                AND A.PAYMENT_NO      = B.PAYMENT_NO
                AND B.PAY_STATUS      IN ('APPR1','CONF','SIG1','SIG2','PRINT')
                AND A.EFF_VALDATE       >= TO_DATE(MM_TO_DATE_T3,'DD/MM/YYYY')  
                AND A.EFF_VALDATE       <= TO_DATE(MM_TO_DATE_T3,'DD/MM/YYYY')  
                AND  A.PORTFOLIO_CODE    LIKE  MM_FACILITI_NO
                AND  A.DN_PORTFOLIO_CODE LIKE  MM_BROKER_CODE 
                AND NVL(W.CLIENT_CODE,'-')        LIKE  MM_CLIENT_CODE
                AND NVL(W.FACILITY_MGR_CODE,'-')  LIKE  MM_FACILITY_MGR_CODE 
               
                
                GROUP BY A.PORTFOLIO_CODE,DN_PORTFOLIO_CODE ,A.EFF_VALDATE 
                  
                ) REC  
                
                WHERE 
                GEN.SELL_PORTFOLIO_CODE=REC.DN_PORTFOLIO_CODE(+) AND 
                GEN.BUY_PORTFOLIO_CODE=REC.PORTFOLIO_CODE(+) 
                AND GEN.BUY_SETLE_DATE=REC.EFF_VALDATE(+) 
                
                GROUP BY  GEN.SELL_PORTFOLIO_CODE,
                GEN.BUY_PORTFOLIO_CODE,
                --GEN.PF_NAME,
                GEN.BUY_SETLE_DATE 
                ORDER BY GEN.BUY_PORTFOLIO_CODE,
                GEN.SELL_PORTFOLIO_CODE,
                GEN.BUY_SETLE_DATE 
                ) A WHERE A.NET_AMOUNT <>0
               ) A WHERE A.NET_AMOUNT <>0 
                -- ORDER BY BUY_SETLE_DATE DESC,SELL_PORTFOLIO_CODE,A.NET_AMOUNT DESC 
               );--END INSERT  
               
----------------------------------------[END]--- IF DEAL AMOUT 20M THEN 15% SHOULD PAY TO BROKER T+1-----------------------------------------------------------  
----------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------  

----------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------- IF DEAL AMOUT 20M THEN 15% SHOULD PAY TO BROKER T+2-----------------------------------------------------------
 INSERT INTO DN_SETTLE_PRE_TEMP(
                SETTL_TYPE, FACILITI_NO,BROKER_CODE, 
                TRNAMOUNT,
                SETTLE_AMOUNT, PENDING_AMOUNT, NET_AMOUNT,
                BUY_SETLE_DATE, SEL_SETLE_DATE, USER_NAME,EXE_DATE) (
                SELECT * FROM (  
                SELECT 'PAY',
                        A.BUY_PORTFOLIO_CODE,
                        A.SELL_PORTFOLIO_CODE,
                        A.TRNAMOUNT,
                        /*CASE WHEN TRNAMOUNT > 2000000 THEN
                        -TRNAMOUNT*15/100
                        ELSE 0
                        END AS "TRNAMOUNT",*/
                        
                        A.SETTLE_AMOUNT,
                        A.PENDING_PAYMENT ,
                        
                       -- A.NET_AMOUNT,
                        
                        CASE WHEN A.TRNAMOUNT > 20000000 THEN
                                        
                           CASE WHEN A.TRNAMOUNT*15/100 > PENDING_PAYMENT + A.SETTLE_AMOUNT THEN
                        
                            A.TRNAMOUNT*15/100 - PENDING_PAYMENT - A.SETTLE_AMOUNT
                        
                            ELSE 0
                            
                          END
                         
                        ELSE 0
                        
                        END AS "NET_AMOUNT",
                        
                        BUY_SETLE_DATE,
                        A.SETLE_DATE,
                        M_USER,
                        SYSTIMESTAMP
                FROM( 
              
              
               
                SELECT GEN.BUY_PORTFOLIO_CODE ,
                GEN.SELL_PORTFOLIO_CODE, 
                SUM(GEN.TRNAMOUNT) TRNAMOUNT ,
                SUM(NVL(REC.REC_AMOUNT,0)) SETTLE_AMOUNT, 
                SUM(TRNAMOUNT-NVL(REC.REC_AMOUNT,0))-DN_GET_TOTAL_PENDING_PAYMENTS(GEN.BUY_PORTFOLIO_CODE,GEN.SELL_PORTFOLIO_CODE,TO_CHAR(GEN.BUY_SETLE_DATE,'DD/MM/YYYY')) NET_AMOUNT , 
                GEN.BUY_SETLE_DATE BUY_SETLE_DATE,
                GEN.BUY_SETLE_DATE SETLE_DATE , 
                DN_GET_TOTAL_PENDING_PAYMENTS(GEN.BUY_PORTFOLIO_CODE,GEN.SELL_PORTFOLIO_CODE,TO_CHAR(GEN.BUY_SETLE_DATE,'DD/MM/YYYY')) PENDING_PAYMENT
                 FROM (
                
                SELECT S.BUY_PORTFOLIO_CODE,
                S.SELL_PORTFOLIO_CODE,
                A.PORTFOLIO_CODE, 
                A.DN_PORTFOLIO_CODE,  
                SUM(A.TRNAMOUNT) TRNAMOUNT ,
                ST.BUY_SETLE_DATE  
                FROM DN_ACC_LICENCEE_GEN_ACCOUNT A, 
                DN_REF_PORTFOLIO P, 
                DN_TRN_OUTP_SALE S, 
                DN_TRN_OUTP_SALE_SETTLE_EQUITY ST, 
                DN_REF_PORTFOLIO W 
                
                WHERE ACC_TYPE_CODE=302 
                AND DRCR_STATUS='CR'
                
                AND DOCREFNO LIKE 'ORMT%' 
                AND A.DOCREFNO= S.DEAL_NO 
                AND (S.SELL_PORTFOLIO_CODE=P.PORTFOLIO_CODE AND P.PF_TYPE='C') 
                AND  ST.DEAL_NO=S.DEAL_NO 
                AND S.BUY_PORTFOLIO_CODE  LIKE MM_FACILITI_NO 
                AND S.SELL_PORTFOLIO_CODE LIKE MM_BROKER_CODE 
                AND NVL(W.CLIENT_CODE,'-') LIKE MM_CLIENT_CODE
                AND NVL(W.FACILITY_MGR_CODE,'-') LIKE  MM_FACILITY_MGR_CODE
                AND W.PORTFOLIO_CODE=S.BUY_PORTFOLIO_CODE 
                
                AND  ST.BUY_SETLE_DATE>=TO_DATE(MM_TO_DATE_T2,'DD/MM/YYYY')  
                AND  ST.BUY_SETLE_DATE<=TO_DATE(MM_TO_DATE_T2,'DD/MM/YYYY')  
                AND  ST.SELL_SETLE_DATE>=TO_DATE(MM_TO_DATE_T2,'DD/MM/YYYY')  
                AND  ST.SELL_SETLE_DATE<=TO_DATE(MM_TO_DATE_T2,'DD/MM/YYYY')  
                GROUP BY S.BUY_PORTFOLIO_CODE,
                         S.SELL_PORTFOLIO_CODE,
                         A.PORTFOLIO_CODE,
                         A.DN_PORTFOLIO_CODE,
                         ST.BUY_SETLE_DATE 
                 ) GEN, 
                
                (SELECT 
                   A.PORTFOLIO_CODE,
                   A.DN_PORTFOLIO_CODE,
                   SUM(A.AMOUNT) REC_AMOUNT,
                   A.EFF_VALDATE  
                FROM  DN_TRN_BO_SETTL_PAYMENT_BULK A,--DN_TRN_BO_SETTL_PAYMENT_BULK 
                DN_REF_PORTFOLIO W ,
                DN_TRN_BO_SETTL_PAYMENT B
                
                WHERE 
                W.PORTFOLIO_CODE=A.PORTFOLIO_CODE 
                AND A.PAYMENT_NO      = B.PAYMENT_NO
                AND B.PAY_STATUS      IN ('APPR1','CONF','SIG1','SIG2','PRINT')
                AND A.EFF_VALDATE       >= TO_DATE(MM_TO_DATE_T2,'DD/MM/YYYY')  
                AND A.EFF_VALDATE       <= TO_DATE(MM_TO_DATE_T2,'DD/MM/YYYY')  
                AND  A.PORTFOLIO_CODE    LIKE  MM_FACILITI_NO
                AND  A.DN_PORTFOLIO_CODE LIKE  MM_BROKER_CODE 
                AND NVL(W.CLIENT_CODE,'-')        LIKE  MM_CLIENT_CODE 
                AND NVL(W.FACILITY_MGR_CODE,'-')  LIKE  MM_FACILITY_MGR_CODE 
               
                
                GROUP BY A.PORTFOLIO_CODE,DN_PORTFOLIO_CODE ,A.EFF_VALDATE 
                  
                ) REC  
                
                WHERE 
                GEN.SELL_PORTFOLIO_CODE=REC.DN_PORTFOLIO_CODE(+) AND 
                GEN.BUY_PORTFOLIO_CODE=REC.PORTFOLIO_CODE(+) 
                AND GEN.BUY_SETLE_DATE=REC.EFF_VALDATE(+) 
                
                GROUP BY  GEN.SELL_PORTFOLIO_CODE,
                GEN.BUY_PORTFOLIO_CODE,
                --GEN.PF_NAME,
                GEN.BUY_SETLE_DATE 
                ORDER BY GEN.BUY_PORTFOLIO_CODE,
                GEN.SELL_PORTFOLIO_CODE,
                GEN.BUY_SETLE_DATE 
                 ) A WHERE A.NET_AMOUNT <>0
                ) A WHERE A.NET_AMOUNT <>0
               );
               
----------------------------------------[END]--- IF DEAL AMOUT 20M THEN 15% SHOULD PAY TO BROKER T+2-----------------------------------------------------------  
----------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------  


  END IF ;
  
  
  
  
  IF EXC_REC=TRUE THEN
    INSERT INTO DN_SETTLE_PRE_TEMP(
                SETTL_TYPE, FACILITI_NO,BROKER_CODE, TRNAMOUNT,
                SETTLE_AMOUNT, PENDING_AMOUNT, NET_AMOUNT,
                BUY_SETLE_DATE, SEL_SETLE_DATE, USER_NAME,EXE_DATE) (
  
         SELECT               'REC',
                              A.SELL_PORTFOLIO_CODE,  
                              A.BUY_PORTFOLIO_CODE,  
                              A.TRNAMOUNT,  
                              A.SETTLE_AMOUNT, 
                              A.PENDING_RECEIPTS ,  
                              A.NET_AMOUNT,  
                              A.BUY_SETLE_DATE,  
                              A.SETLE_DATE,  
                              M_USER,
                              SYSTIMESTAMP
                       FROM (  
                           SELECT GEN.SELL_PORTFOLIO_CODE,  
                                  GEN.BUY_PORTFOLIO_CODE,  
                                  SUM(GEN.TRNAMOUNT) TRNAMOUNT,  
                                  SUM(NVL(REC.REC_AMOUNT, 0)) SETTLE_AMOUNT,  
                                  SUM(TRNAMOUNT - NVL(REC.REC_AMOUNT, 0)) -   DN_GET_TOTAL_PENDING_RECEIPTS(GEN.SELL_PORTFOLIO_CODE, GEN.BUY_PORTFOLIO_CODE, TO_CHAR(GEN.BUY_SETLE_DATE, 'DD/MM/YYYY')) NET_AMOUNT,  
                                  GEN.BUY_SETLE_DATE BUY_SETLE_DATE,  
                                  GEN.BUY_SETLE_DATE SETLE_DATE,   /* ADD BY WARUNA 2011-01-10 */
                                  DN_GET_TOTAL_PENDING_RECEIPTS(GEN.SELL_PORTFOLIO_CODE, GEN.BUY_PORTFOLIO_CODE, TO_CHAR(GEN.BUY_SETLE_DATE, 'DD/MM/YYYY')) PENDING_RECEIPTS  
                           FROM (  
                               SELECT S.BUY_PORTFOLIO_CODE,  
                                      S.SELL_PORTFOLIO_CODE,  
                                      A.PORTFOLIO_CODE,  
                                      A.DN_PORTFOLIO_CODE,  
                                      SUM(A.TRNAMOUNT) TRNAMOUNT,  
                                      ST.BUY_SETLE_DATE  
                               FROM     DN_ACC_LICENCEE_GEN_ACCOUNT A,  
                                        DN_REF_PORTFOLIO P,  
                                        DN_TRN_OUTP_SALE S,  
                                        DN_TRN_OUTP_SALE_SETTLE_EQUITY ST ,
                                        DN_REF_PORTFOLIO W  
                               WHERE  ACC_TYPE_CODE = 302  
                               AND    DRCR_STATUS = 'DR'  
                               AND    DOCREFNO LIKE 'ORMT%'  
                               AND    A.DOCREFNO = S.DEAL_NO  
                               AND   (S.SELL_PORTFOLIO_CODE = P.PORTFOLIO_CODE AND  P.PF_TYPE='P' )  
                               AND    ST.DEAL_NO = S.DEAL_NO 
                               AND S.BUY_PORTFOLIO_CODE  LIKE MM_BROKER_CODE 
                               AND S.SELL_PORTFOLIO_CODE LIKE MM_FACILITI_NO 
                               AND NVL(W.CLIENT_CODE,'-') LIKE MM_CLIENT_CODE
                               AND NVL(W.FACILITY_MGR_CODE,'-') LIKE  MM_FACILITY_MGR_CODE 
                               AND W.PORTFOLIO_CODE=S.SELL_PORTFOLIO_CODE 
                                
                               AND    ST.BUY_SETLE_DATE >= TO_DATE(MM_FROM_DATE, 'DD/MM/YYYY')  
                               AND    ST.BUY_SETLE_DATE <= TO_DATE(MM_TO_DATE, 'DD/MM/YYYY')  
                               AND    ST.SELL_SETLE_DATE >= TO_DATE(MM_FROM_DATE, 'DD/MM/YYYY')    
                               AND    ST.SELL_SETLE_DATE <= TO_DATE(MM_TO_DATE, 'DD/MM/YYYY')  
                               
                               
                               
                               GROUP BY S.BUY_PORTFOLIO_CODE,  
                                        S.SELL_PORTFOLIO_CODE,  
                                        P.PF_NAME,  
                                        A.PORTFOLIO_CODE,  
                                        A.DN_PORTFOLIO_CODE,  
                                        ST.BUY_SETLE_DATE  
                           ) GEN,  
                           (  
                               SELECT   
                                      A.SELL_PORTFOLIO_CODE,  
                                      A.ID_PORTFOLIO_CODE,  
                                      SUM(A.REC_AMOUNT) REC_AMOUNT,  
                                      EFF_VALDATE  
                               FROM   DN_TRN_BO_SETTL_RECEIPT_BULK A  ,DN_REF_PORTFOLIO W 
 
                               WHERE  A.SELL_PORTFOLIO_CODE=W.PORTFOLIO_CODE
                               AND    REC_STATUS  IN ('APPR1','CONF','SIG1','SIG2','PRINT')
                               AND    EFF_VALDATE >= TO_DATE(MM_FROM_DATE, 'DD/MM/YYYY')  
                               AND    EFF_VALDATE <= TO_DATE(MM_TO_DATE, 'DD/MM/YYYY') 
                               AND    W.PORTFOLIO_CODE         LIKE  MM_FACILITI_NO 
                               AND    A.ID_PORTFOLIO_CODE      LIKE  MM_BROKER_CODE 
                               AND    NVL(W.CLIENT_CODE,'-')        LIKE  MM_CLIENT_CODE 
                               AND    NVL(W.FACILITY_MGR_CODE,'-')  LIKE  MM_FACILITY_MGR_CODE 
                               GROUP BY SELL_PORTFOLIO_CODE,  
                                        ID_PORTFOLIO_CODE,  
                                        EFF_VALDATE  
                           ) REC  
                           WHERE  

                                 GEN.SELL_PORTFOLIO_CODE = REC.SELL_PORTFOLIO_CODE(+)  
                           AND   GEN.BUY_PORTFOLIO_CODE = REC.ID_PORTFOLIO_CODE(+)  
                           AND   GEN.BUY_SETLE_DATE = REC.EFF_VALDATE(+)  
                           GROUP BY GEN.SELL_PORTFOLIO_CODE,  
                                    GEN.BUY_PORTFOLIO_CODE,  
                                    GEN.BUY_SETLE_DATE  
                           ORDER BY GEN.BUY_PORTFOLIO_CODE,  
                                    GEN.SELL_PORTFOLIO_CODE,  
                                    GEN.BUY_SETLE_DATE  
                       ) A  
                       WHERE  NET_AMOUNT <> 0  
                     --- ORDER BY BUY_SETLE_DATE DESC,BUY_PORTFOLIO_CODE,NET_AMOUNT DESC
                     );--END INSERT
  END IF ;   
  
  
--COMMIT;

END ; 

/
