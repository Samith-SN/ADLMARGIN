--------------------------------------------------------
--  DDL for Function DN_CLIENT_FUTURE_CASH_FLOW
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_CLIENT_FUTURE_CASH_FLOW" 
     ( M_PORTFOLIO_CODE    DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE,
        M_FROMDATE      VARCHAR,
        M_TODATE        VARCHAR
        
     )

    -- Function     : This returns TOTAL PENDING CASH FLOW
    -- System       : DEALNET System
    -- Created by   :
    -- Created on   :K.M.W.S.JAYANATH
  RETURN  REAL



   IS
 TOTAL NUMBER:=0;


BEGIN

SELECT DN_CLIENT_PEND_CASH_FLOW_P_1(M_PORTFOLIO_CODE,M_FROMDATE,M_TODATE)-
       DN_CLIENT_PEND_CASH_FLOW_R_1(M_PORTFOLIO_CODE,M_FROMDATE,M_TODATE) INTO TOTAL
 FROM DUAL;


RETURN TOTAL;

END ;

/
