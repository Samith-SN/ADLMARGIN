--------------------------------------------------------
--  DDL for Function DN_GET_CLIENT_WITHDRAWAL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_CLIENT_WITHDRAWAL" 
     ( M_PORTFOLIO_CODE    DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE,
       M_START_DATE        VARCHAR,
       M_END_DATE          VARCHAR
     )

    -- Function     : This returns TOTAL  RECEIPT  
    -- System       : DEALNET System
    -- Created by   :
    -- Created on   :K.M.W.S.JAYANATH
  RETURN  REAL



   IS
 TOTAL NUMBER:=0;

BEGIN


SELECT SUM(A.TRNAMOUNT) INTO TOTAL  FROM DN_TRN_BO_CAP_DEPOSIT A
WHERE portfolio_code=M_PORTFOLIO_CODE
/*AND  A.TRNDATE<=TO_DATE(M_END_DATE,'DD/MM/YYYY')  
AND A.TRNDATE>=TO_DATE(M_START_DATE,'DD/MM/YYYY')*/
AND  A.EFF_VAL_DATE<=TO_DATE(M_END_DATE,'DD/MM/YYYY')  
AND A.EFF_VAL_DATE>=TO_DATE(M_START_DATE,'DD/MM/YYYY')
and TRANSACTION_TYPE='W'; 


RETURN TOTAL;

END ; 

/
