--------------------------------------------------------
--  DDL for Function DN_GET_TOTAL_ENT_PAYMENTS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_TOTAL_ENT_PAYMENTS" 
(
 PORT           DN_TRN_OUTP_SALE.BUY_PORTFOLIO_CODE%TYPE--,
 --CP_CODE        DN_TRN_OUTP_SALE.SELL_PORTFOLIO_CODE%TYPE,
 --EFFDATE        varchar2
)
 RETURN number
 AS
 M_TOTAL_PENDING       DN_TRN_BO_SETTL_PAYMENT_TEMP.PAY_AMOUNT%TYPE;


 BEGIN
                SELECT SUM(PAY_AMOUNT) INTO M_TOTAL_PENDING
                FROM DN_TRN_BO_SETTL_PAYMENT_TEMP A
                WHERE A.CLIENT_CODE=PORT -- AND 
                --EFF_VALDATE=TO_DATE(EFFDATE,'DD/MM/YYYY') --AND 
                --ID_PORTFOLIO_CODE=CP_CODE
                AND APP_STATUS='ENT' ;



 RETURN  NVL(M_TOTAL_PENDING,0);

END ;

/
