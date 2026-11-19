--------------------------------------------------------
--  DDL for Function DN_GET_NOT_HIT_VALID_PAYMENTS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_NOT_HIT_VALID_PAYMENTS" 
(
 PORT                  DN_TRN_OUTP_SALE.BUY_PORTFOLIO_CODE%TYPE,
 --CP_CODE             DN_TRN_OUTP_SALE.SELL_PORTFOLIO_CODE%TYPE,
 EFFDATE               VARCHAR2
)
 RETURN NUMBER
 AS
 M_TOTAL_PENDING       DN_TRN_BO_SETTL_PAYMENT_TEMP.PAY_AMOUNT%TYPE;


 BEGIN
                
                SELECT SUM(PAY_AMOUNT) INTO M_TOTAL_PENDING
                FROM  DN_TRN_BO_SETTL_PAYMENT_TEMP A
                WHERE A.CLIENT_CODE =  PORT  AND 
                      TRNDATE       <= TO_DATE(EFFDATE,'DD/MM/YYYY') --AND 
                --ID_PORTFOLIO_CODE=CP_CODE
                AND APP_STATUS IN('APPR1','APPR2','CONF','SIG1','SIG2','PRINT') ;



 RETURN  NVL(M_TOTAL_PENDING,0);

END ;

/
