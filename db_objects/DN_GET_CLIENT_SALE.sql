--------------------------------------------------------
--  DDL for Function DN_GET_CLIENT_SALE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_CLIENT_SALE" 
     ( M_PORTFOLIO_CODE    DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE,
       M_START_DATE        VARCHAR,
       M_END_DATE          VARCHAR
     )

    -- Function     : This returns DN_GET_CLIENT_SALE
    -- System       : DEALNET System
    -- Created by   :
    -- Created on   :K.M.W.S.JAYANATH
  RETURN  REAL



   IS
 TOTAL NUMBER:=0;


BEGIN

--SELECT NVL(SUM(S.SETTLE_VALUE),0) TRNAMOUNT INTO TOTAL --CHANGE AND ADD BELOW BY WARUNA 2011-12-19
SELECT NVL(SUM(S.PURCHASE_COST),0) TRNAMOUNT INTO TOTAL
FROM 
DN_TRN_OUTP_SALE S
WHERE 
EFF_VALDATE>=to_date(M_START_DATE,'dd/mm/yyyy') 
and  EFF_VALDATE<=to_date(M_END_DATE,'dd/mm/yyyy')  
and  S.SELL_PORTFOLIO_CODE=M_PORTFOLIO_CODE 
and  s.app_status='CONF'
;



RETURN TOTAL;

END ;

/
