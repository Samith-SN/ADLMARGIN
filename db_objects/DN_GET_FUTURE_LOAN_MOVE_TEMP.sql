--------------------------------------------------------
--  DDL for Function DN_GET_FUTURE_LOAN_MOVE_TEMP
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_FUTURE_LOAN_MOVE_TEMP" 
(
 M_PORTFOLIO_CODE         DN_TRN_OUTP_SALE.BUY_PORTFOLIO_CODE%TYPE,
 EFFDATE                  VARCHAR2
)
 RETURN NUMBER
 AS
 M_TOTAL_LOAN_MOVE           NUMBER(18,4):=0;       
 M_PAY_REC_STILL_NOT_APPROVE NUMBER(18,4):=0;
 M_PAY_REC_VALID             NUMBER(18,4):=0;
 M_VALFROMDATE               DATE;
 M_VALTODATE                 DATE;
 M_DATE                      DATE;
 BEGIN


--M_VALFROMDATE := TO_DATE(EFFDATE,'DD-MM-YYYY');
--M_VALTODATE   := TO_DATE(EFFDATE,'DD-MM-YYYY');
M_DATE        := TO_DATE(EFFDATE,'DD-MM-YYYY');

SELECT ROUND(SUM(BALANCE),2) 
INTO M_TOTAL_LOAN_MOVE 
         FROM ( 
                           SELECT '1' PART, A.PORTFOLIO_CODE, A.EFF_VAL_DATE, DECODE (A.TRANSACTION_TYPE,'D', 'DEPOSIT' ) PARTICULARS, 
                            A.CHEQUE_NO, A.TRNAMOUNT CREDIT, 0 DEBITS, A.TRNAMOUNT*-1 BALANCE,PROC_DESC NARRATION 
                            FROM DN_TRN_BO_CAP_DEPOSIT_TEMP A 
                            WHERE A.TRANSACTION_TYPE = 'D' 
                            AND A.PORTFOLIO_CODE     = M_PORTFOLIO_CODE
                            AND CURRENT_STATUS       = 'ENT'
                            AND EFF_VAL_DATE >= M_DATE --remove by waruna 2012-07-13 --add by waruna 2012-08-27 unrealization
                            --AND EFF_VAL_DATE <= M_DATE --remove by waruna 2012-07-13 --add by waruna 2012-08-27 unrealization
                          
                            UNION ALL
                           
                            SELECT '2', A.PORTFOLIO_CODE, A.EFF_VAL_DATE, 
                                  DECODE (A.TRANSACTION_TYPE, 'W', 'WITHDRAWAL') PARTICULARS, 
                                  A.CHEQUE_NO, 0 CREDIT, A.TRNAMOUNT DEBITS, A.TRNAMOUNT BALANCE ,PROC_DESC NARRATION 
                            FROM DN_TRN_BO_CAP_DEPOSIT_TEMP A 
                            WHERE TRANSACTION_TYPE = 'W' 
                            AND A.PORTFOLIO_CODE   = M_PORTFOLIO_CODE
                            AND CURRENT_STATUS     ='ENT'
                            AND EFF_VAL_DATE >= M_DATE--remove by waruna 2012-07-13 --add by waruna 2012-08-27 unrealization
                            --AND EFF_VAL_DATE <= M_DATE--remove by waruna 2012-07-13 --add by waruna 2012-08-27 unrealization
                                                      
                            UNION ALL
                           
                            SELECT '3', B.PORTFOLIO_CODE, B.TRNDATE, 'PAYMENT'||'-'||B.CLIENT_CODE PARTICULARS, 
                                   '' CHEQUENO,0 CREDIT,  B.PAY_AMOUNT DEBIT,B.PAY_AMOUNT BALANCE,B.OTH_COMMENT NARRATION   
                            FROM DN_TRN_BO_SETTL_PAYMENT_TEMP B 
                            WHERE  
                            B.CLIENT_CODE = M_PORTFOLIO_CODE 
                            AND B.APP_STATUS = 'ENT'
                            AND B.GROUP_NET_NO IS NULL 
                            AND B.TRNDATE >= M_DATE --remove by waruna 2012-07-13 --add by waruna 2012-08-27 unrealization
                            --AND B.TRNDATE <= M_DATE --remove by waruna 2012-07-13 --add by waruna 2012-08-27 unrealization
                            
                            UNION ALL
                            
                            SELECT '5', B.FACILITY_NO, B.TRNDATE, 'PAYMENT'||'-'||B.FACILITY_NO PARTICULARS, 
                                   '' CHEQUENO,0 CREDIT,  B.SETTLE_AMOUNT DEBIT,B.SETTLE_AMOUNT BALANCE,''NARRATION   
                            FROM DN_MAS_SETLE_GROUP_NET B 
                            WHERE  
                            B.FACILITY_NO = M_PORTFOLIO_CODE 
                            AND B.APP_STATUS = 'ENT'
                            AND B.TRNDATE >= M_DATE 
                            --AND B.TRNDATE <= M_DATE 
                           
                            UNION ALL
                          
                            SELECT '4', C.PORTFOLIO_CODE, C.TRNDATE, 'RECEIPT'||'-'||C.ID_PORTFOLIO_CODE PARTICULARS, 
                                  ''CHEQUENO, C.REC_AMOUNT CREDIT, 0 DEBIT, C.REC_AMOUNT*-1 BALANCE,OTH_COMMENTS  ---CHAB=NGE  BY WARUNA 2011-01-03
                            FROM DN_TRN_BO_SETTL_RECEIPT_TMP C--DN_TRN_BO_SETTL_RECEIPT_BULK C 
                            WHERE C.SELL_PORTFOLIO_CODE = M_PORTFOLIO_CODE
                            AND APP_STATUS = 'ENT'
                            AND C.GROUP_NET_NO IS NULL 
                            AND REALISED_DATE >= M_DATE --add by waruna 2012-08-27 unrealization
                            --AND REALISED_DATE <= M_DATE --add by waruna 2012-08-27 unrealization
                             
                            UNION ALL  
         
                            SELECT '6', C.FACILITY_NO, C.TRNDATE, 'RECEIPT'||'-'||C.BROKE_CODE PARTICULARS, 
                                  ''CHEQUENO, C.SETTLE_AMOUNT CREDIT, 0 DEBIT, C.SETTLE_AMOUNT*-1 BALANCE,''OTH_COMMENTS  ---CHAB=NGE  BY WARUNA 2011-01-03
                            FROM DN_MAS_RECEIPT_GROUP_NET C--DN_TRN_BO_SETTL_RECEIPT_BULK C 
                            WHERE C.FACILITY_NO = M_PORTFOLIO_CODE
                            AND APP_STATUS = 'ENT'
                            AND C.GROUP_NET_NO IS NULL 
                            AND REALISED_DATE >= M_DATE --add by waruna 2012-08-27 unrealization
                            --AND REALISED_DATE <= M_DATE --add by waruna 2012-08-27 unrealization
                     
                          
                            /* UNION ALL
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
                          */
                          -------- ADD PORTF CHARGES BY WARUNA 2011-01-05--------
                          
                          /* DIRECT SAVE  SO IGNORE
                           UNION ALL
                          
                           SELECT '5', A.PORTFOLIO_CODE, A.TRNDATE, 
                                  DECODE (A.TRANSACTION_TYPE, 'I', 'PORTFOLIO CHARGES') PARTICULARS, 
                                  '' CHEQUE_NO, 0 CREDIT, A.TRNAMOUNT DEBITS, A.TRNAMOUNT BALANCE ,PROC_DESC NARRATION 
                            FROM DN_TRN_BO_PORTF_CHARG A 
                            WHERE TRANSACTION_TYPE = 'I' AND A.PORTFOLIO_CODE=M_PORTFOLIO_CODE AND DOCREFNO LIKE 'PC%'
                            AND TRNDATE>=TO_DATE(M_FROM_DATE,'DD/MM/YYYY') AND TRNDATE <=TO_DATE(M_TO_DATE,'DD/MM/YYYY')
                            
                            UNION ALL
                            
                            SELECT '6', A.PORTFOLIO_CODE, A.TRNDATE, 
                                  DECODE (A.TRANSACTION_TYPE, 'I', 'INTEREST REFUND') PARTICULARS, 
                                  '' CHEQUE_NO,  A.TRNAMOUNT CREDIT, 0 DEBITS, A.TRNAMOUNT*-1 BALANCE ,PROC_DESC NARRATION 
                            FROM DN_TRN_BO_PORTF_CHARG A 
                            WHERE TRANSACTION_TYPE = 'I' AND A.PORTFOLIO_CODE=M_PORTFOLIO_CODE AND DOCREFNO LIKE 'IR%'
                            AND TRNDATE>=TO_DATE(M_FROM_DATE,'DD/MM/YYYY') AND TRNDATE <=TO_DATE(M_TO_DATE,'DD/MM/YYYY')   
                            
                            UNION ALL
                          
                            SELECT '7', A.PORTFOLIO_CODE, A.RECEIVED_DATE, 
                                   'DIVIDENDS' PARTICULARS, 
                                  '' CHEQUE_NO,  NVL(A.TRNAMOUNT,0)-NVL(WITHHOLDING_TAX ,0) CREDIT, 0 DEBITS, (A.TRNAMOUNT-NVL(WITHHOLDING_TAX,0))*-1 BALANCE ,DECODE(PROC_DESC,'DAYENDROUTINE','DIVIDEND INCOME',PROC_DESC) NARRATION 
                            FROM DN_TRN_DIVIDEND_INCOME A 
                            WHERE  A.PORTFOLIO_CODE=M_PORTFOLIO_CODE AND RECEIVED_DATE IS NOT NULL
                            AND RECEIVED_DATE>=TO_DATE(M_FROM_DATE,'DD/MM/YYYY') AND RECEIVED_DATE <=TO_DATE(M_TO_DATE,'DD/MM/YYYY') 
                           
                            UNION ALL
                            
                            SELECT '8', A.PORTFOLIO_CODE, A.TRNDATE, 
                                  DECODE (A.TRANSACTION_TYPE, 'I', 'INTEREST CHARGES') PARTICULARS, 
                                  '' CHEQUE_NO,  0 CREDIT, A.TRNAMOUNT DEBITS, A.TRNAMOUNT BALANCE ,PROC_DESC NARRATION 
                            FROM DN_TRN_BO_PORTF_CHARG A 
                            WHERE TRANSACTION_TYPE = 'I' AND A.PORTFOLIO_CODE=M_PORTFOLIO_CODE AND DOCREFNO LIKE 'IC%'
                            AND TRNDATE>=TO_DATE(M_FROM_DATE,'DD/MM/YYYY') AND TRNDATE <=TO_DATE(M_TO_DATE,'DD/MM/YYYY') 
                             */
                       );

                         
 DBMS_OUTPUT.PUT_LINE('M_TOTAL_LOAN_MOVE= '||M_TOTAL_LOAN_MOVE); 
--M_TOTAL_LOAN_MOVE:=0;
  --RAISE_APPLICATION_ERROR(-20201,'M_TOTAL_LOAN_MOVE='||M_TOTAL_LOAN_MOVE||'**'||M_VALFROMDATE);
 RETURN  NVL(M_TOTAL_LOAN_MOVE,0);

END ; 

/
