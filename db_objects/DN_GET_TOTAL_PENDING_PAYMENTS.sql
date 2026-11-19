--------------------------------------------------------
--  DDL for Function DN_GET_TOTAL_PENDING_PAYMENTS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_TOTAL_PENDING_PAYMENTS" 
(
 PORT           DN_TRN_OUTP_SALE.BUY_PORTFOLIO_CODE%TYPE,
 CP_CODE        DN_TRN_OUTP_SALE.SELL_PORTFOLIO_CODE%TYPE,
 EFFDATE        varchar2
)
 RETURN number
 AS
 M_TOtal_PENding       dn_trn_bo_settl_payment_temp.PAY_AMOUNT%TYPE;


 BEGIN
                SELECT sum(PAY_AMOUNT) into M_TOtal_PENding
                FROM dn_trn_bo_settl_payment_temp a
                where a.client_code=PORT and 
                EFF_VALDATE=to_date(EFFDATE,'dd/mm/yyyy') and 
                ID_PORTFOLIO_CODE=CP_CODE
                and APP_STATUS='ENT' ;



 RETURN  nvl(M_TOtal_PENding,0);

END DN_GET_TOTAL_PENDING_PAYMENTS;

/
