--------------------------------------------------------
--  DDL for Function DN_FIN_BROKERAGE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_BROKERAGE" 
   (
    M_DEAL_NO               DN_TRN_OUTP_SALE.DEAL_NO%TYPE,
    M_BUY_PORTFOLIO_CODE    DN_TRN_OUTP_SALE.BUY_PORTFOLIO_CODE%TYPE
   ) RETURN  REAL

    IS

    -- Function     : Returns BROKERAGE
    -- System       : DEALNET System
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 06/07/1999

 M_RETVAL              NUMBER;

 BEGIN

     SELECT
        NVL(BROK_FEE_AMOUNT,0)
        INTO M_RETVAL
     FROM
        DN_TRN_BROKERAGE
     WHERE
        DEAL_NO=M_DEAL_NO
        AND
        CP_CODE=M_BUY_PORTFOLIO_CODE;

 RETURN ROUND(M_RETVAL,4);

END DN_FIN_BROKERAGE;

/
