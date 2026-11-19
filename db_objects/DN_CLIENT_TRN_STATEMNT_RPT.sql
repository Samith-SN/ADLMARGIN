--------------------------------------------------------
--  DDL for Procedure DN_CLIENT_TRN_STATEMNT_RPT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_CLIENT_TRN_STATEMNT_RPT" (
     M_PORTFOLIO_CODE   DN_REF_PORTFOLIO.PORTFOLIO_CODE%type,
     M_USER      VARCHAR2,                                                    
     m_FROM_DATE VARCHAR2,
     M_TO_DATE   VARCHAR2
)

AS

M_TMP_FROM_DATE        VARCHAR(100);
M_TMP_TO_DATE          VARCHAR(100); --ADD BY WARUNA 2011-05-13
M_FIRST_DAY_OF_MONTH   VARCHAR(100);
M_COUNT_1    NUMBER;
INT_AMOUNT   NUMBER;
M_LAST_DAILY DATE;

 /*
 CREATED BY - K.M.WARUNA  SRI JAYANATH
  CREATED ON - 2011-11-09
  SYSTEM     - LBMARGIN
*/

/*
  CURSOR M_CURSOR IS SELECT PORTFOLIO_CODE, PF_TYPE, PF_NAME, ADD_IDENTIFICATION,
       ADD_LOCATION,ADD_STREET, ADD_CITY, ADD_COUNTRY,POSTAL_CODE, DATE_INC_BIRTH, BUSI_REG_NIC,
       CATEGORY_ENTITY, NATURE_OCCUPATION, SECT_CODE,MBFSL_SECT_CODE,NEST_REVIEW, TOT_EXP_LIMIT, 
       PERC_TOT_EXP, APPLY_STATUS,CP_PORTFOLIO_CODE, OWNED_BY_MBFSL, ACTIVE_STATUS,EXP_LIMIT_APPLY_METHOD,
       BRANCH, RATE, RATE_TYPE, LIMIT,USER_TYPE, MARGIN_CALL_STATUS, TEMP_MARGIN_CALL_STATUS,MANAGEMENT_FEE, 
       PROFIT_SHARING, BASE_RATE, PA_STATUS,CDS_ACC_NO, SWIFT_STATUS, ACC_NO, SWIFT_CLIENT,BIC_CODE, 
       PLEDG_ACC_NO, CON_MARGIN_TYPE, DN_USER,EMAIL FROM DN_REF_PORTFOLIO_TEMP;  
*/
/*
CURSOR M_CURSOR1 IS  select  to_char(last_month_date,'DD/MM/YYYY') last_month_date  from (
SELECT last_day(TO_DATE(m_FROM_DATE, 'DD/MM/YYYY') - 1 + rownum) AS last_month_date
FROM all_objects
WHERE TO_DATE(m_FROM_DATE, 'DD/MM/YYYY') - 1 + rownum <= TO_DATE(M_TO_DATE, 'dd/mm/YYYY')
)group by last_month_date;*/

--COMMENT ABOVE ADD MODIFY VERSION BY WARUNA 2011-05-30
CURSOR M_CURSOR1 IS SELECT DISTINCT TO_CHAR(LAST_MONTH_DATE,'DD/MM/YYYY')  LAST_MONTH_DATE FROM ( 
SELECT  LAST_DAY(ADD_MONTHS(TO_DATE(M_FROM_DATE, 'DD/MM/YYYY'),LEVEL-1))LAST_MONTH_DATE
FROM DUAL CONNECT BY LEVEL<=(SELECT MONTHS_BETWEEN(TO_DATE(M_TO_DATE,'DD-MM-YYYY'),
TO_DATE(M_FROM_DATE,'DD-MM-YYYY')) +1MONTHS FROM DUAL)
) WHERE LAST_MONTH_DATE>= TO_DATE(M_FROM_DATE, 'DD/MM/YYYY') AND LAST_MONTH_DATE<=LAST_DAY(TO_DATE(M_TO_DATE,'DD-MM-YYYY'));


BEGIN
--RAISE_APPLICATION_ERROR(-20201,'******'||M_PORTFOLIO_CODE||M_USER||m_FROM_DATE||M_TO_DATE);

 
delete DN_TRN_STATEMENT_TMP_RPT where DN_USER=M_USER;
  /*           
  
 FOR x IN M_CURSOR LOOP 
     
   DN_PORTFOLIOS_MT_IN1(
       X.PORTFOLIO_CODE,X.OWNED_BY_MBFSL,X.CP_PORTFOLIO_CODE,       
        X.PF_NAME,X.ADD_IDENTIFICATION,X.ADD_LOCATION,X.ADD_STREET,X.ADD_CITY,                
        X.ADD_COUNTRY, X.POSTAL_CODE,TO_CHAR(X.DATE_INC_BIRTH,'DD/MM/YYYY'),X.BUSI_REG_NIC,X.CATEGORY_ENTITY,          
        X.NATURE_OCCUPATION,X.MBFSL_SECT_CODE,X.SECT_CODE,TO_CHAR(X.NEST_REVIEW,'DD/MM/YYYY'),
        NULL,--X.DIRECTOR_NAME,
        M_SELECT_TYPE,--X.SELECT_TYPE,              
        NULL,--X.AUTHO_NAME,
        NULL,--X.CONT_PERSON_,
        NULL,--X.TEL_NO,
        NULL,--X.FAX_NO,
        X.EMAIL,--X.EMAIL,
        NULL,--X.BRANCH_CODE,
        X.ACC_NO,                    
        X.RATE,X.RATE_TYPE,X.LIMIT,X.MANAGEMENT_FEE,X.PROFIT_SHARING,X.BASE_RATE,X.CDS_ACC_NO,X.ACC_NO,                   
        X.CON_MARGIN_TYPE,X.DN_USER                     
     ); 
     

 --RAISE_APPLICATION_ERROR(-20201,'******'||X.PORTFOLIO_CODE);
 END LOOP;
   
  */ 
--  delete from DN_REF_PORTFOLIO_TEMP;
        
INSERT INTO DN_TRN_STATEMENT_TMP_RPT 
          (PART, PORTFOLIO_CODE, EFF_VAL_DATE, PARTICULARS, CHEQUE_NO, CREDIT, DEBITS, BALANCE,
           RUNDATE, DN_USER,NARRATION)
          (
         SELECT   PART,PORTFOLIO_CODE,EFF_VAL_DATE,PARTICULARS,nvl(CHEQUE_NO,'-'),ROUND(CREDIT,2),ROUND(DEBITS,2),ROUND(BALANCE,2) ,sysdate,M_USER,NARRATION
         FROM ( 
                           SELECT '1' PART, A.PORTFOLIO_CODE, A.EFF_VAL_DATE, DECODE (A.TRANSACTION_TYPE,'D', 'DEPOSIT' ) PARTICULARS, 
                            A.CHEQUE_NO, A.TRNAMOUNT CREDIT, 0 DEBITS, A.TRNAMOUNT*-1 BALANCE,PROC_DESC NARRATION 
                            FROM DN_TRN_BO_CAP_DEPOSIT A 
                            WHERE A.TRANSACTION_TYPE = 'D' AND A.PORTFOLIO_CODE=M_PORTFOLIO_CODE AND  APP_STATUS IN ('APPR1','CONF','SIG1','SIG2','PRINT') --ADD APP STATUS BU WARUNA 2012-05-04
                            AND EFF_VAL_DATE>=to_date(m_FROM_DATE,'DD/MM/YYYY') AND EFF_VAL_DATE <=to_date(M_TO_DATE,'DD/MM/YYYY') 
                          
                            UNION all
                           
                            SELECT '2', A.PORTFOLIO_CODE, A.EFF_VAL_DATE, 
                                  DECODE (A.TRANSACTION_TYPE, 'W', 'WITHDRAWAL') PARTICULARS, 
                                  A.CHEQUE_NO, 0 CREDIT, A.TRNAMOUNT DEBITS, A.TRNAMOUNT BALANCE ,PROC_DESC NARRATION 
                            FROM DN_TRN_BO_CAP_DEPOSIT A 
                            WHERE TRANSACTION_TYPE = 'W' AND A.PORTFOLIO_CODE=M_PORTFOLIO_CODE AND  APP_STATUS IN ('APPR1','CONF','SIG1','SIG2','PRINT') --ADD APP STATUS BU WARUNA 2012-05-04 
                            AND EFF_VAL_DATE>=to_date(m_FROM_DATE,'DD/MM/YYYY') AND EFF_VAL_DATE <=to_date(M_TO_DATE,'DD/MM/YYYY') 
                                                      
                             /*UNION ALL
                           
                           SELECT '3', B.PORTFOLIO_CODE, B.TRNDATE, 'PAYMENT'||'-'||RR.DN_PORTFOLIO_CODE PARTICULARS, 
                                   '' CHEQUENO,0 CREDIT,  B.PAY_AMOUNT DEBIT,B.PAY_AMOUNT BALANCE,B.OTH_COMMENT NARRATION   ---chande  B.PAY_AMOUNT by waruna 2011-01-03
                            FROM DN_TRN_BO_SETTL_PAYMENT B ,DN_TRN_BO_SETTL_PAYMENT_BULK RR WHERE 
                            B.PAYMENT_NO=RR.PAYMENT_NO AND  RR.PORTFOLIO_CODE=M_PORTFOLIO_CODE AND B.PAY_STATUS IN ('APPR1','CONF','SIG1','SIG2','PRINT') 
                            AND B.TRNDATE>=to_date(m_FROM_DATE,'DD/MM/YYYY') AND B.TRNDATE <=to_date(M_TO_DATE,'DD/MM/YYYY') 
                           
                            UNION ALL
                          
                            SELECT '4', C.PORTFOLIO_CODE, C.TRNDATE, 'RECEIPT'||'-'||C.ID_PORTFOLIO_CODE PARTICULARS, 
                                  ''CHEQUENO, C.REC_AMOUNT CREDIT, 0 DEBIT, C.REC_AMOUNT*-1 BALANCE,OTH_COMMENTS  ---chab=nge  by waruna 2011-01-03
                            FROM DN_TRN_BO_SETTL_RECEIPT_BULK C WHERE C.SELL_PORTFOLIO_CODE=M_PORTFOLIO_CODE
                            AND REC_STATUS IN ('APPR1','CONF','SIG1','SIG2','PRINT')  
                            AND TRNDATE>=to_date(m_FROM_DATE,'DD/MM/YYYY') AND TRNDATE <=to_date(M_TO_DATE,'DD/MM/YYYY') 
                     */
                          
                             UNION ALL
                             SELECT '3',A.BUY_PORTFOLIO_CODE,B.BUY_SETLE_DATE,'PURCHASES'||'-'||A.SELL_PORTFOLIO_CODE PARTICULARS,''CHEQUENO,0 CREDIT,
                                    SETTLE_VALUE DEBIT,SETTLE_VALUE BALANCE ,'-' NARRATION
                             FROM   DN_TRN_OUTP_SALE A,
                                   DN_TRN_OUTP_SALE_SETTLE_EQUITY B
                                   ,DN_TRN_OUTP_SALE_SETTLE C
                            WHERE  A.DEAL_NO = B.DEAL_NO AND
                                   A.DEAL_NO = C.DEAL_NO(+) AND
                                   A.BUY_PORTFOLIO_CODE= M_PORTFOLIO_CODE AND  APP_STATUS='CONF'AND
                                   BUY_SETLE_DATE  >= TO_DATE(M_FROM_DATE,'DD-MM-YYYY') AND
                                   BUY_SETLE_DATE  <= TO_DATE(M_TO_DATE,'DD-MM-YYYY') AND
                                   SETTLE_VALUE <>0
                                   
                           UNION ALL
                            SELECT '4',A.SELL_PORTFOLIO_CODE,B.SELL_SETLE_DATE,'SALES'||'-'||A.BUY_PORTFOLIO_CODE PARTICULARS,''CHEQUENO,SETTLE_VALUE CREDIT,
                                    0 DEBIT,SETTLE_VALUE*-1 BALANCE ,'-' NARRATION
                            FROM   DN_TRN_OUTP_SALE A,
                                   DN_TRN_OUTP_SALE_SETTLE_EQUITY B
                                 ,DN_TRN_OUTP_SALE_SETTLE C
                            WHERE  A.DEAL_NO = B.DEAL_NO AND
                                  A.DEAL_NO = C.DEAL_NO(+) AND
                                   A.SELL_PORTFOLIO_CODE= M_PORTFOLIO_CODE AND
                                   APP_STATUS='CONF'AND
                                   SELL_SETLE_DATE >= TO_DATE(M_FROM_DATE,'DD-MM-YYYY') AND
                                   SELL_SETLE_DATE <= TO_DATE(M_TO_DATE,'DD-MM-YYYY')  AND 
                                   SETTLE_VALUE <>0
                         
                          -------- add portf charges by waruna 2011-01-05--------
                          UNION ALL
                          
                          SELECT '5', A.PORTFOLIO_CODE, A.TRNDATE, 
                                  DECODE (A.TRANSACTION_TYPE, 'I', 'PORTFOLIO CHARGES') PARTICULARS, 
                                  '' CHEQUE_NO, 0 CREDIT, A.TRNAMOUNT DEBITS, A.TRNAMOUNT BALANCE ,PROC_DESC NARRATION 
                            FROM DN_TRN_BO_PORTF_CHARG A 
                            WHERE TRANSACTION_TYPE = 'I' AND A.PORTFOLIO_CODE=M_PORTFOLIO_CODE AND DOCREFNO LIKE 'PC%'
                            AND TRNDATE>=to_date(m_FROM_DATE,'DD/MM/YYYY') AND TRNDATE <=to_date(M_TO_DATE,'DD/MM/YYYY')
                            
                            UNION ALL
                            
                            SELECT '6', A.PORTFOLIO_CODE, A.TRNDATE, 
                                  DECODE (A.TRANSACTION_TYPE, 'I', 'INTEREST REFUND') PARTICULARS, 
                                  '' CHEQUE_NO,  A.TRNAMOUNT CREDIT, 0 DEBITS, A.TRNAMOUNT*-1 BALANCE ,PROC_DESC NARRATION 
                            FROM DN_TRN_BO_PORTF_CHARG A 
                            WHERE TRANSACTION_TYPE = 'I' AND A.PORTFOLIO_CODE=M_PORTFOLIO_CODE AND DOCREFNO LIKE 'IR%'
                            AND TRNDATE>=to_date(m_FROM_DATE,'DD/MM/YYYY') AND TRNDATE <=to_date(M_TO_DATE,'DD/MM/YYYY')   
  
                            UNION ALL
                          
                            SELECT '7', A.PORTFOLIO_CODE, A.RECEIVED_DATE, 
                                   'DIVIDENDS' PARTICULARS, 
                                  '' CHEQUE_NO,  nvl(A.TRNAMOUNT,0)-nvl(WITHHOLDING_TAX ,0) CREDIT, 0 DEBITS, (A.TRNAMOUNT-nvl(WITHHOLDING_TAX,0))*-1 BALANCE ,decode(PROC_DESC,'DAYENDROUTINE','Dividend Income',PROC_DESC) NARRATION 
                            FROM DN_TRN_DIVIDEND_INCOME A 
                            WHERE  A.PORTFOLIO_CODE=M_PORTFOLIO_CODE AND RECEIVED_DATE IS NOT NULL
                            AND RECEIVED_DATE>=to_date(m_FROM_DATE,'DD/MM/YYYY') AND RECEIVED_DATE <=to_date(M_TO_DATE,'DD/MM/YYYY') 
                           
                            UNION ALL
                            
                            SELECT '8', A.PORTFOLIO_CODE, A.TRNDATE, 
                                  DECODE (A.TRANSACTION_TYPE, 'I', 'INTEREST CHARGES') PARTICULARS, 
                                  '' CHEQUE_NO,  0 CREDIT, A.TRNAMOUNT DEBITS, A.TRNAMOUNT BALANCE ,PROC_DESC NARRATION 
                            FROM DN_TRN_BO_PORTF_CHARG A 
                            WHERE TRANSACTION_TYPE = 'I' AND A.PORTFOLIO_CODE=M_PORTFOLIO_CODE AND DOCREFNO LIKE 'IC%'
                            AND TRNDATE>=to_date(m_FROM_DATE,'DD/MM/YYYY') AND TRNDATE <=to_date(M_TO_DATE,'DD/MM/YYYY') 
                    
                       )
                    
                      
                    
                     );
        
        
   
  FOR x IN M_CURSOR1 LOOP 
    

   DBMS_OUTPUT.PUT_LINE(X.LAST_MONTH_DATE);
  IF TO_DATE(X.LAST_MONTH_DATE,'DD/MM/YYYY')  IS NOT NULL 
     AND TO_DATE( X.LAST_MONTH_DATE,'DD/MM/YYYY') >= TO_DATE(M_FROM_DATE,'DD/MM/YYYY') 
     THEN
     
                       --  dbms_output.put_line(x.last_month_date);
                      
                        SELECT TO_CHAR(TO_DATE('01'||TO_CHAR(TO_DATE(X.LAST_MONTH_DATE,'DD/MM/YYYY'),'/MM/YYYY'),'DD/MM/YYYY') ,'DD/MM/YYYY')
                        INTO M_FIRST_DAY_OF_MONTH
                        FROM DUAL; 
                        
           
                        IF TO_DATE(M_FROM_DATE,'DD/MM/YYYY')>TO_DATE(M_FIRST_DAY_OF_MONTH,'DD/MM/YYYY') THEN
                        M_TMP_FROM_DATE:=M_FIRST_DAY_OF_MONTH;--M_FROM_DATE;
                        --  dbms_output.put_line(m_tmp_from_date);
                        ELSE
                        M_TMP_FROM_DATE:=M_FIRST_DAY_OF_MONTH;
                          --dbms_output.put_line(m_tmp_from_date);
                        end if;
                        
                        ------------add by waruna 2011-05-13---------------
                                               
                        SELECT LAST_DAILY INTO M_LAST_DAILY
                        FROM DN_SYS_PARAMETER ;
                        
                        IF LEAST(M_LAST_DAILY,TO_DATE(M_TO_DATE,'DD/MM/YYYY'))<TO_DATE(X.LAST_MONTH_DATE,'DD/MM/YYYY') THEN
                        
                        M_TMP_TO_DATE:=TO_CHAR(LEAST(M_LAST_DAILY,TO_DATE(M_TO_DATE,'DD/MM/YYYY')),'DD/MM/YYYY');
                        ELSE
                        M_TMP_TO_DATE:=X.LAST_MONTH_DATE;
                        END IF;
                        ----------- end bu waruna 2011-05-13--------------------
     --dbms_output.put_line('m_first_day_of_month '||m_tmp_from_date);                   
     --dbms_output.put_line('last_month_date'||x.last_month_date);

     dbms_output.put_line('m_tmp_from_date '||m_tmp_from_date);                   
    dbms_output.put_line('m_tmp_to_date'||m_tmp_to_date);
IF TO_DATE( M_TMP_TO_DATE,'DD/MM/YYYY') <= TO_DATE(M_TO_DATE,'DD/MM/YYYY')  THEN

     INSERT INTO DN_TRN_STATEMENT_TMP_RPT 
          (PART, PORTFOLIO_CODE, EFF_VAL_DATE, PARTICULARS, CHEQUE_NO, CREDIT, DEBITS, BALANCE,
           RUNDATE, DN_USER)
          (
             SELECT '5' PART,M_PORTFOLIO_CODE,to_date(m_tmp_to_date,'dd/mm/yyyy'),'INTEREST','' CHEQUE_NO,0 CREDIT, nvl(SUM(INT_AMOUNT),0) DEBITS,nvl(SUM(INT_AMOUNT),0) BALANCE,sysdate,M_USER
                       FROM (
                         SELECT INT_AMOUNT
                         FROM   DN_TRN_REPO_FRESH A,DN_REF_PORTFOLIO B
                         WHERE  BORR_PORTFOLIO_CODE= B.PORTFOLIO_CODE AND
                                EFF_VALDATE >=  TO_DATE(m_tmp_from_date,'DD/MM/YYYY') AND
                                EFF_VALDATE <=   TO_DATE(m_tmp_to_date,'DD/MM/YYYY')  AND
                                BORR_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                                APP_STATUS   = 'CONF'
                         UNION ALL
                         SELECT INT_AMOUNT
                         FROM   DN_TRN_REPO_ROLLOVER A,DN_REF_PORTFOLIO B
                         WHERE  BORR_PORTFOLIO_CODE= B.PORTFOLIO_CODE AND
                                EFF_VALDATE >=   TO_DATE(m_tmp_from_date,'DD/MM/YYYY') AND
                                EFF_VALDATE <=   TO_DATE(m_tmp_to_date,'DD/MM/YYYY')  AND
                                BORR_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                               --ON_CALL_DEAL = 'Y' AND
                                APP_STATUS   = 'CONF'
                        -------------------@@@@@@@@@@@@@@@@@@@@@@@@
                        UNION ALL
                        SELECT INT_AMOUNT*-1
                         FROM   DN_TRN_REPO_FRESH A,DN_REF_PORTFOLIO B
                         WHERE  LEND_PORTFOLIO_CODE= B.PORTFOLIO_CODE AND
                                EFF_VALDATE >=  TO_DATE(m_tmp_from_date,'DD/MM/YYYY') AND
                                EFF_VALDATE <=  TO_DATE(m_tmp_to_date,'DD/MM/YYYY')   AND
                                LEND_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                                APP_STATUS   = 'CONF'
                         UNION ALL
                         SELECT INT_AMOUNT*-1
                         FROM   DN_TRN_REPO_ROLLOVER A,DN_REF_PORTFOLIO B
                         WHERE  LEND_PORTFOLIO_CODE= B.PORTFOLIO_CODE AND
                                EFF_VALDATE >=   TO_DATE(m_tmp_from_date,'DD/MM/YYYY') AND
                               EFF_VALDATE <=   TO_DATE(m_tmp_to_date,'DD/MM/YYYY')  AND
                                LEND_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                               --ON_CALL_DEAL = 'Y' AND
                                APP_STATUS   = 'CONF'
                        
                        -------------------@@@@@@@@@@@@@@@@@@@@@@@@
                              )  
                              
                              );
         /* -----Added by Prabash on 17-01-2012------**
          INSERT INTO DN_TRN_STATEMENT_TMP_RPT 
          (PART, PORTFOLIO_CODE, EFF_VAL_DATE, PARTICULARS, CHEQUE_NO, CREDIT, DEBITS, BALANCE,
           RUNDATE, DN_USER)
                        (
             SELECT '9' PART,M_PORTFOLIO_CODE,TO_DATE(M_TMP_TO_DATE,'DD/MM/YYYY'),'ODI_AMOUNT','' CHEQUE_NO,0 CREDIT,NVL(SUM(ODI_AMOUNT),0)DEBITS, NVL(SUM(ODI_AMOUNT),0)BALANCE,SYSDATE,M_USER
                       FROM (
                         SELECT DN_GET_OD_ACCRUED_INTEREST(B.PORTFOLIO_CODE,TO_DATE(M_FROM_DATE,'DD-MM-YYYY'),TO_DATE(M_TO_DATE,'DD-MM-YYYY')) ODI_AMOUNT
                         FROM   DN_TRN_REPO_FRESH A,DN_REF_PORTFOLIO B
                         WHERE  BORR_PORTFOLIO_CODE= B.PORTFOLIO_CODE AND
                                EFF_VALDATE >=  TO_DATE(M_TMP_FROM_DATE,'DD/MM/YYYY') AND
                                EFF_VALDATE <=   TO_DATE(M_TMP_TO_DATE,'DD/MM/YYYY')  AND
                                BORR_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                                APP_STATUS   = 'CONF'
                        
                              )  
                              
                              );
        -----Added by Prabash on 17-01-2012------**
        */
         -----Added by Waruna 2012-04-26-----**
          INSERT INTO DN_TRN_STATEMENT_TMP_RPT 
          (PART, PORTFOLIO_CODE, EFF_VAL_DATE, PARTICULARS, CHEQUE_NO, CREDIT, DEBITS, BALANCE,
           RUNDATE, DN_USER)
                        (
             SELECT '9' PART,M_PORTFOLIO_CODE,TO_DATE(M_TMP_TO_DATE,'DD/MM/YYYY'),'ODI_AMOUNT','' CHEQUE_NO,0 CREDIT,NVL(SUM(ODI_AMOUNT),0)DEBITS, NVL(SUM(ODI_AMOUNT),0)BALANCE,SYSDATE,M_USER
                       FROM (
                         SELECT DN_GET_OD_ACCRUED_INTEREST(M_PORTFOLIO_CODE,TO_DATE(M_TMP_FROM_DATE,'DD-MM-YYYY'),TO_DATE(M_TMP_TO_DATE,'DD-MM-YYYY')) ODI_AMOUNT
                         from dual
                              )  
                              
                              );
        -----Added by Waruna on 2012-04-262------**
                              
                              
   
     END IF ;     
  END IF ;  
   
  END LOOP;     
        
   
        
        
        
             
  
    COMMIT;

END DN_CLIENT_TRN_STATEMNT_RPT; 

/
