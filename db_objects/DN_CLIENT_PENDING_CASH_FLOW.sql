--------------------------------------------------------
--  DDL for Function DN_CLIENT_PENDING_CASH_FLOW
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_CLIENT_PENDING_CASH_FLOW" 
     ( M_PORTFOLIO_CODE    DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE,
       M_DATE        VARCHAR
     )

    -- Function     : This returns TOTAL PENDING CASH FLOW
    -- System       : DEALNET System
    -- Created by   :
    -- Created on   :K.M.W.S.JAYANATH
  RETURN  REAL



   IS
 TOTAL NUMBER:=0;


BEGIN

SELECT DN_CLIENT_PENDING_CASH_FLOW_P(M_PORTFOLIO_CODE,M_DATE)-
       DN_CLIENT_PENDING_CASH_FLOW_R(M_PORTFOLIO_CODE,M_DATE) INTO TOTAL
 FROM DUAL;


RETURN TOTAL;

END ;

/
