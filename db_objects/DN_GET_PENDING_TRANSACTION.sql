--------------------------------------------------------
--  DDL for Function DN_GET_PENDING_TRANSACTION
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_PENDING_TRANSACTION" 
(
 M_PORTFOLIO_CODE         DN_TRN_OUTP_SALE.BUY_PORTFOLIO_CODE%TYPE,
 EFFDATE                  VARCHAR2
)
 RETURN NUMBER
 AS

 M_TOTAL_LOAN_MOVE           NUMBER(18,4):=0;
 M_TOTAL_LOAN_MOVE_1           NUMBER(18,4):=0;   
 M_TOTAL_LOAN_MOVE_2           NUMBER(18,4):=0;          
 M_PAY_REC_STILL_NOT_APPROVE NUMBER(18,4):=0;
 M_PAY_REC_VALID             NUMBER(18,4):=0;
 M_VALFROMDATE               DATE;
 M_VALTODATE                 DATE;
 M_DATE                      DATE;


 M_VAL_ENT_PAY               NUMBER;
 BEGIN



M_DATE        := TO_DATE(EFFDATE,'DD-MM-YYYY');

M_VALFROMDATE := TO_DATE(EFFDATE,'DD-MM-YYYY');
M_VALTODATE   := TO_DATE(EFFDATE,'DD-MM-YYYY');



SELECT SUM(TOT) INTO M_TOTAL_LOAN_MOVE_1
FROM ( 
                SELECT A.DN_PORTFOLIO_CODE,C.PF_NAME, 
                SUM(DECODE(A.DRCR_STATUS,'DR',A.TRNAMOUNT,0))     -SUM(DECODE(A.DRCR_STATUS,'CR',A.TRNAMOUNT,0)) TOT ,  
                ABS(SUM(DECODE(A.DRCR_STATUS,'DR',A.TRNAMOUNT,0)) -SUM(DECODE(A.DRCR_STATUS,'CR',A.TRNAMOUNT,0))) ABSTOT 
                FROM DN_ACC_LICENCEE_GEN_ACCOUNT A, 
                     DN_REF_PORTFOLIO C 
                WHERE
                      A.DN_PORTFOLIO_CODE    = M_PORTFOLIO_CODE
                AND   TRUNC(A.TRNDATE,'DD') > TRUNC(M_VALFROMDATE,'DD') 
              
                AND   A.DN_PORTFOLIO_CODE    =  C.PORTFOLIO_CODE 
                AND   DOCREFNO NOT IN (
                              SELECT DEAL_NO 
                              FROM DN_TRN_OUTP_SALE X 
                              WHERE X.DEAL_NO=A.DOCREFNO 
                              AND DN_GET_INSTRUMENT_CAT(INST_TYPE)='EQUITY') 
                   AND  A.ACC_TYPE_CODE IN('301')
                   AND SUBSTR(DOCREFNO,0,2) IN ('CD','CW','OR','RI','PC','IR')  --PC,IR ADD BY WARUNA 2011-05-05
                GROUP BY A.DN_PORTFOLIO_CODE,C.PF_NAME 
                
                UNION ALL
                
                SELECT X.PORTFOLIO_CODE DN_PORTFOLIO_CODE,V.PF_NAME PF_NAME,SUM(-1*TRNAMOUNT) TOT,ABS(SUM(TRNAMOUNT)) ABSTOT 
                FROM DN_TRN_DIVIDEND_INCOME X, 
                DN_REF_PORTFOLIO V 
                WHERE 
                X.PORTFOLIO_CODE               = V.PORTFOLIO_CODE
                AND X.PORTFOLIO_CODE           = M_PORTFOLIO_CODE
                AND V.PF_TYPE                  = 'P' 
                AND V.OWNED_BY_MBFSL           = 'N'
                AND TRUNC(RECEIVED_DATE,'DD') > TRUNC(M_VALFROMDATE,'DD')
                
                GROUP BY X.PORTFOLIO_CODE,V.PF_NAME 
                
                UNION ALL
                
                
                
                --ADD BY WARUNA 2011-09-28      
                SELECT B.PORTFOLIO_CODE ,C.PF_NAME,SUM(A.TRNAMOUNT)-0 TOT,ABS(SUM(A.TRNAMOUNT)-0) ABSTOT 
                FROM   DN_ACC_LICENCEE_GEN_ACCOUNT A ,DN_TRN_BO_SETTL_PAYMENT_BULK B ,DN_REF_PORTFOLIO C 
                WHERE  A.DOCREFNO     LIKE 'SP%'
                AND   ACC_TYPE_CODE        ='302'
                AND DRCR_STATUS            ='DR' 
                AND B.PORTFOLIO_CODE       = M_PORTFOLIO_CODE              
                AND TRUNC(A.TRNDATE,'DD') > TRUNC(M_VALFROMDATE ,'DD')
          
                AND A.DOCREFNO=B.PAYMENT_NO
                AND B.PORTFOLIO_CODE       =C.PORTFOLIO_CODE
                GROUP BY B.PORTFOLIO_CODE,C.PF_NAME  
                
                UNION ALL       
                
                SELECT B.SELL_PORTFOLIO_CODE ,C.PF_NAME,SUM(0-TRNAMOUNT) TOT,ABS(SUM(0-TRNAMOUNT)) ABSTOT 
                FROM  DN_ACC_LICENCEE_GEN_ACCOUNT A , DN_TRN_BO_SETTL_RECEIPT_BULK B , DN_REF_PORTFOLIO C 
                WHERE A.DOCREFNO           LIKE 'SR%'
                AND   ACC_TYPE_CODE        ='302'
                AND DRCR_STATUS            ='CR' 
                AND B.SELL_PORTFOLIO_CODE  = M_PORTFOLIO_CODE              
                AND TRUNC(A.TRNDATE,'DD') > TRUNC(M_VALFROMDATE,'DD')   
                
                AND A.DOCREFNO=B.REC_NO
                AND B.SELL_PORTFOLIO_CODE = C.PORTFOLIO_CODE
                GROUP BY B.SELL_PORTFOLIO_CODE,C.PF_NAME        
-- END CASH HOLDING MODIFICATION DONE BY WARUNA 2011-05-20
) GROUP BY DN_PORTFOLIO_CODE,PF_NAME ;
                         
 DBMS_OUTPUT.PUT_LINE('M_TOTAL_LOAN_MOVE= '||M_TOTAL_LOAN_MOVE); 
M_TOTAL_LOAN_MOVE := M_TOTAL_LOAN_MOVE+NVL(M_TOTAL_LOAN_MOVE_1,0);


SELECT  ROUND(SUM(BALANCE),2) 
INTO M_TOTAL_LOAN_MOVE_2 
         FROM ( 
                           SELECT '1' PART, A.PORTFOLIO_CODE, A.EFF_VAL_DATE, DECODE (A.TRANSACTION_TYPE,'D', 'DEPOSIT' ) PARTICULARS, 
                            A.CHEQUE_NO, A.TRNAMOUNT CREDIT, 0 DEBITS, A.TRNAMOUNT*-1 BALANCE,PROC_DESC NARRATION 
                            FROM DN_TRN_BO_CAP_DEPOSIT_TEMP A 
                            WHERE A.TRANSACTION_TYPE = 'D' 
                            AND A.PORTFOLIO_CODE     = M_PORTFOLIO_CODE
                            AND CURRENT_STATUS       = 'ENT'
                            AND EFF_VAL_DATE > M_DATE 
                           
                          
                            UNION ALL
                           
                            SELECT '2', A.PORTFOLIO_CODE, A.EFF_VAL_DATE, 
                                  DECODE (A.TRANSACTION_TYPE, 'W', 'WITHDRAWAL') PARTICULARS, 
                                  A.CHEQUE_NO, 0 CREDIT, A.TRNAMOUNT DEBITS, A.TRNAMOUNT BALANCE ,PROC_DESC NARRATION 
                            FROM DN_TRN_BO_CAP_DEPOSIT_TEMP A 
                            WHERE TRANSACTION_TYPE = 'W' 
                            AND A.PORTFOLIO_CODE   = M_PORTFOLIO_CODE
                            AND CURRENT_STATUS     ='ENT'
                            AND EFF_VAL_DATE  > M_DATE
                            
                                                      
                            UNION ALL
                           
                            SELECT '3', B.PORTFOLIO_CODE, B.TRNDATE, 'PAYMENT'||'-'||B.CLIENT_CODE PARTICULARS, 
                                   '' CHEQUENO,0 CREDIT,  B.PAY_AMOUNT DEBIT,B.PAY_AMOUNT BALANCE,B.OTH_COMMENT NARRATION   ---CHANDE  B.PAY_AMOUNT BY WARUNA 2011-01-03
                            FROM DN_TRN_BO_SETTL_PAYMENT_TEMP B --,DN_TRN_BO_SETTL_PAYMENT_BULK RR
                            WHERE --B.PAYMENT_NO     = RR.PAYMENT_NO 
                            B.CLIENT_CODE = M_PORTFOLIO_CODE 
                            AND B.APP_STATUS =  'ENT'
                            AND B.TRNDATE > M_DATE 
                          
                           
                            UNION ALL
                          
                            SELECT '4', C.PORTFOLIO_CODE, C.TRNDATE, 'RECEIPT'||'-'||C.ID_PORTFOLIO_CODE PARTICULARS, 
                                  ''CHEQUENO, C.REC_AMOUNT CREDIT, 0 DEBIT, C.REC_AMOUNT*-1 BALANCE,OTH_COMMENTS  ---CHAB=NGE  BY WARUNA 2011-01-03
                            FROM DN_TRN_BO_SETTL_RECEIPT_TMP C--DN_TRN_BO_SETTL_RECEIPT_BULK C 
                            WHERE C.SELL_PORTFOLIO_CODE = M_PORTFOLIO_CODE
                            AND APP_STATUS = 'ENT'
                            AND REALISED_DATE  > M_DATE 
                           
                     
                            
                       );

 M_TOTAL_LOAN_MOVE := M_TOTAL_LOAN_MOVE+NVL(M_TOTAL_LOAN_MOVE_2,0);     
                 
 DBMS_OUTPUT.PUT_LINE('M_TOTAL_LOAN_MOVE= '||M_TOTAL_LOAN_MOVE); 
--M_TOTAL_LOAN_MOVE:=0;
  --RAISE_APPLICATION_ERROR(-20201,'M_TOTAL_LOAN_MOVE='||M_TOTAL_LOAN_MOVE||'**'||M_VALFROMDATE);
 RETURN  NVL(M_TOTAL_LOAN_MOVE,0);

END ; 

/
