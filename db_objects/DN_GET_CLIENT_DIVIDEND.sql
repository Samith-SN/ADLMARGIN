--------------------------------------------------------
--  DDL for Function DN_GET_CLIENT_DIVIDEND
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_CLIENT_DIVIDEND" 
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



SELECT SUM(A.TRNAMOUNT) INTO TOTAL  FROM dn_trn_dividend_income A
WHERE PORTFOLIO_CODE=M_PORTFOLIO_CODE
AND  A.TRNDATE<=TO_DATE(M_END_DATE,'DD/MM/YYYY')  
AND A.TRNDATE>=TO_DATE(M_START_DATE,'DD/MM/YYYY')
; 


RETURN TOTAL;

END ;

/
