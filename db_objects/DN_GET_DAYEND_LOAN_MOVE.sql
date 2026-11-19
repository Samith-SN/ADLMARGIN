--------------------------------------------------------
--  DDL for Function DN_GET_DAYEND_LOAN_MOVE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_DAYEND_LOAN_MOVE" 
(
 M_PORTFOLIO_CODE         DN_TRN_OUTP_SALE.BUY_PORTFOLIO_CODE%TYPE,
 --CP_CODE                DN_TRN_OUTP_SALE.SELL_PORTFOLIO_CODE%TYPE,
 EFFDATE                  VARCHAR2
)
 RETURN NUMBER
 AS
 M_TOTAL_LOAN_MOVE           NUMBER(18,4):=0;       
 M_PAY_REC_STILL_NOT_APPROVE NUMBER(18,4):=0;
 M_PAY_REC_VALID             NUMBER(18,4):=0;
 M_VALFROMDATE               DATE;
 M_VALTODATE                 DATE;
 BEGIN


M_VALFROMDATE := TO_DATE(EFFDATE,'DD-MM-YYYY');
M_VALTODATE   := TO_DATE(EFFDATE,'DD-MM-YYYY');

SELECT /*DN_PORTFOLIO_CODE,PF_NAME,*/SUM(TOT)/*,SUM(ABSTOT) */ INTO M_TOTAL_LOAN_MOVE
FROM ( 
                SELECT A.DN_PORTFOLIO_CODE,C.PF_NAME, 
                SUM(DECODE(A.DRCR_STATUS,'DR',A.TRNAMOUNT,0))     -SUM(DECODE(A.DRCR_STATUS,'CR',A.TRNAMOUNT,0)) TOT ,  
                ABS(SUM(DECODE(A.DRCR_STATUS,'DR',A.TRNAMOUNT,0)) -SUM(DECODE(A.DRCR_STATUS,'CR',A.TRNAMOUNT,0))) ABSTOT 
                FROM DN_ACC_LICENCEE_GEN_ACCOUNT A, 
                     DN_REF_PORTFOLIO C 
                WHERE
                      A.DN_PORTFOLIO_CODE    = M_PORTFOLIO_CODE
                AND   TRUNC(A.TRNDATE,'DD') >= M_VALFROMDATE 
                AND   TRUNC(A.TRNDATE,'DD') <= M_VALTODATE  
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
                AND V.OWNED_BY_MBFSL           ='N'
                AND TRUNC(RECEIVED_DATE,'DD') >= M_VALFROMDATE
                AND TRUNC(RECEIVED_DATE,'DD') <= M_VALTODATE
                GROUP BY X.PORTFOLIO_CODE,V.PF_NAME 
                
                UNION ALL
                
                
                
                --ADD BY WARUNA 2011-09-28		
                SELECT B.PORTFOLIO_CODE ,C.PF_NAME,SUM(A.TRNAMOUNT)-0 TOT,ABS(SUM(A.TRNAMOUNT)-0) ABSTOT 
                FROM   DN_ACC_LICENCEE_GEN_ACCOUNT A ,DN_TRN_BO_SETTL_PAYMENT_BULK B ,DN_REF_PORTFOLIO C 
                WHERE  A.DOCREFNO     LIKE 'SP%'
                AND   ACC_TYPE_CODE        ='302'
                AND DRCR_STATUS            ='DR' 
                AND B.PORTFOLIO_CODE       = M_PORTFOLIO_CODE              
                AND	TRUNC(A.TRNDATE,'DD') >= M_VALFROMDATE 
                AND TRUNC(A.TRNDATE,'DD') <= M_VALTODATE
                AND A.DOCREFNO=B.PAYMENT_NO
                AND B.PORTFOLIO_CODE       =C.PORTFOLIO_CODE
                GROUP BY B.PORTFOLIO_CODE,C.PF_NAME  
                
                UNION ALL 		
                
                SELECT B.SELL_PORTFOLIO_CODE ,C.PF_NAME,SUM(0-TRNAMOUNT) TOT,ABS(SUM(0-TRNAMOUNT)) ABSTOT 
                FROM    DN_ACC_LICENCEE_GEN_ACCOUNT A , DN_TRN_BO_SETTL_RECEIPT_BULK B , DN_REF_PORTFOLIO C 
                WHERE  A.DOCREFNO           LIKE 'SR%'
                AND   ACC_TYPE_CODE        ='302'
                AND DRCR_STATUS            ='CR' 
                AND B.SELL_PORTFOLIO_CODE  = M_PORTFOLIO_CODE              
                AND TRUNC(A.TRNDATE,'DD') >= M_VALFROMDATE   
                AND TRUNC(A.TRNDATE,'DD') <= M_VALTODATE
                AND A.DOCREFNO=B.REC_NO
                AND B.SELL_PORTFOLIO_CODE = C.PORTFOLIO_CODE
                GROUP BY B.SELL_PORTFOLIO_CODE,C.PF_NAME 		
-- END CASH HOLDING MODIFICATION DONE BY WARUNA 2011-05-20
) GROUP BY DN_PORTFOLIO_CODE,PF_NAME ;



						 
 dbms_output.put_line('M_TOTAL_LOAN_MOVE= '||M_TOTAL_LOAN_MOVE); 
 -- M_TOTAL_LOAN_MOVE:=0;
  --RAISE_APPLICATION_ERROR(-20201,'M_TOTAL_LOAN_MOVE='||M_TOTAL_LOAN_MOVE||'**'||M_VALFROMDATE);
 RETURN  NVL(M_TOTAL_LOAN_MOVE,0);

END ;

/
