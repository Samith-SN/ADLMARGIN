--------------------------------------------------------
--  DDL for Function GET_DEFAULT_AMOUNT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."GET_DEFAULT_AMOUNT" 
(
M_PORTFOLIO_CODE          DN_TRN_REPO_FRESH.BORR_PORTFOLIO_CODE%TYPE,
M_DATE    VARCHAR

)


RETURN NUMBER
IS

M_DEFAULT_AMOUNT   NUMBER;


BEGIN

/*
SELECT SUM(NVL(DUE_AMOUNT,0))  INTO M_DEFAULT_AMOUNT FROM (

SELECT  (DUE_AMOUNT-DECODE(DUE_AMOUNT,0,0,INT_AMOUNT)) DUE_AMOUNT, B.DUE_DATE FROM DN_TRN_REPO_FRESH A,
              DN_LOAN_SETTL_SCHEDULE B--,
             -- DN_TRN_LOAN_SETTL_RECEIPT C
              
WHERE NVL(A.ORG_DEAL_NO,'-') = B.DEAL_NO 
AND A.MATURITY_DATE = B.DUE_DATE
AND A.APP_STATUS='CONF'
--AND C.REC_STATUS IN ('CONF')
--AND A.BORR_PORTFOLIO_CODE =C.ID_PORTFOLIO_CODE(+)
--AND A.MATURITY_DATE = C.DUE_DATE(+)
AND A.BORR_PORTFOLIO_CODE = M_PORTFOLIO_CODE

 UNION ALL 
 
SELECT  REC_AMOUNT*-1,DUE_DATE  FROM  DN_TRN_LOAN_SETTL_RECEIPT C
WHERE  C.REC_STATUS IN ('CONF')  
AND  C.ID_PORTFOLIO_CODE = M_PORTFOLIO_CODE


UNION ALL 

SELECT (DUE_AMOUNT-DECODE(DUE_AMOUNT,0,0,INT_AMOUNT))  DUE_AMOUNT,  B.DUE_DATE
FROM DN_TRN_REPO_ROLLOVER A,
     DN_LOAN_SETTL_SCHEDULE B--,
     --DN_TRN_LOAN_SETTL_RECEIPT C
WHERE NVL(A.ORG_DEAL_NO,'-') = B.DEAL_NO 
AND A.MATURITY_DATE = B.DUE_DATE
AND A.APP_STATUS='CONF'
--AND C.REC_STATUS IN ('CONF')
--AND A.BORR_PORTFOLIO_CODE = C.ID_PORTFOLIO_CODE(+)
--AND A.MATURITY_DATE = C.DUE_DATE(+)
AND A.BORR_PORTFOLIO_CODE = M_PORTFOLIO_CODE

) WHERE DUE_DATE < TO_DATE(M_DATE,'DD/MM/YYYY');
*/ 


                                
   
   
   
                                   SELECT SUM(DUE_AMOUNT_WITHOUT_INT-RECEIPT_WITHOUT_INT) INTO M_DEFAULT_AMOUNT  FROM (
                                  
                                   SELECT BORR_PORTFOLIO_CODE,DUE_AMOUNT-INT_AMOUNT DUE_AMOUNT_WITHOUT_INT,
                                   
                                    CASE  WHEN REC_AMOUNT <> 0   THEN
                                    REC_AMOUNT-INT_AMOUNT
                                    ELSE 
                                     REC_AMOUNT
                                    END AS "RECEIPT_WITHOUT_INT"
                                    ,  DUE_DATE
                                   FROM (
                                   SELECT AA.BORR_PORTFOLIO_CODE,DUE_AMOUNT, INT_AMOUNT ,NVL(CC.REC_AMOUNT,0) REC_AMOUNT,AA.DUE_DATE  FROM  
                                   
                                   (SELECT  A.BORR_PORTFOLIO_CODE, DUE_AMOUNT , INT_AMOUNT , B.DUE_DATE 
                                    FROM  DN_TRN_REPO_FRESH A, 
                                     DN_LOAN_SETTL_SCHEDULE B 
                                   WHERE NVL(A.ORG_DEAL_NO,'-') = B.DEAL_NO  
                                   AND A.MATURITY_DATE = B.DUE_DATE 
                                   AND A.APP_STATUS='CONF' 
                                
                                   UNION ALL  
                                
                                   SELECT  A.BORR_PORTFOLIO_CODE,DUE_AMOUNT,INT_AMOUNT, B.DUE_DATE 
                                    FROM  DN_TRN_REPO_ROLLOVER A, 
                                     DN_LOAN_SETTL_SCHEDULE B 
                                   WHERE NVL(A.ORG_DEAL_NO,'-') = B.DEAL_NO  
                                   AND A.MATURITY_DATE = B.DUE_DATE 
                                   AND A.APP_STATUS='CONF' 
                                   
                                    ) AA, 
                                
                                   ( SELECT ID_PORTFOLIO_CODE,SUM(REC_AMOUNT) REC_AMOUNT,DUE_DATE FROM  DN_TRN_LOAN_SETTL_RECEIPT C 
                                     WHERE C.REC_STATUS IN ('CONF') 
                                     --AND TRN_DATE <= TO_DATE('m_mdate_to','DD/MM/YYYY') 
                                     GROUP BY ID_PORTFOLIO_CODE,DUE_DATE 
                                 
                                    ) CC 
                                    WHERE   
                                    AA.BORR_PORTFOLIO_CODE =CC.ID_PORTFOLIO_CODE(+) 
                                    AND AA.DUE_DATE = CC.DUE_DATE(+) 
                                    AND AA.BORR_PORTFOLIO_CODE = M_PORTFOLIO_CODE 
                                    AND AA.DUE_DATE <  TO_DATE(M_DATE,'DD/MM/YYYY')  
                                 
                                   -- GROUP BY AA.BORR_PORTFOLIO_CODE 
                                  )
                                 
                               );
                            
                            


RETURN M_DEFAULT_AMOUNT ;

EXCEPTION WHEN NO_DATA_FOUND THEN

RETURN 0;

END; 

/
