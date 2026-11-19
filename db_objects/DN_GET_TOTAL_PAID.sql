--------------------------------------------------------
--  DDL for Function DN_GET_TOTAL_PAID
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_TOTAL_PAID" 
(
 PORT           DN_TRN_OUTP_SALE.BUY_PORTFOLIO_CODE%TYPE,
 CP_CODE        DN_TRN_OUTP_SALE.SELL_PORTFOLIO_CODE%TYPE,
 EFFDATE        varchar2
)
 RETURN number
 AS
 M_TOTAL_PAID       DN_TRN_OUTP_SALE.SETTLE_VALUE%TYPE;


 BEGIN
                    SELECT SUM(A.AMOUNT) INTO M_TOTAL_PAID
                    FROM DN_TRN_BO_SETTL_PAYMENT_BULK A ,
                    DN_TRN_BO_SETTL_PAYMENT B 
                    WHERE 
                    B.EFF_VALDATE         = TO_DATE(EFFDATE,'DD/MM/YYYY')
                    AND A.PORTFOLIO_CODE  = PORT 
                    AND DN_PORTFOLIO_CODE = CP_CODE
                    AND B.PAYMENT_NO      = A.PAYMENT_NO
                    AND B.PAY_STATUS IN ('APPR1','CONF','SIG1','SIG2','PRINT') 
                    ;



 RETURN  NVL(M_TOTAL_PAID,0);

END DN_GET_TOTAL_PAID;

/
