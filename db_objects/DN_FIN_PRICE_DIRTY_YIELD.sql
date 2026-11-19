--------------------------------------------------------
--  DDL for Function DN_FIN_PRICE_DIRTY_YIELD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_PRICE_DIRTY_YIELD" 

(
    M_SECURITY_CODE       DN_TRN_OUTP_SALE.SECURITY_CODE%TYPE,
    M_REQ_YIELD           DN_TRN_OUTP_SALE.YIELD%TYPE,
    M_EFF_VALDATE         DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE,
    M_INT_RATE_BASE_CODE  DN_TRN_OUTP_SALE.INT_RATE_BASE_CODE%TYPE

   )

   RETURN  REAL

   IS

    -- Function     : This returns DIRTY price for the req.yield (Equal with excel function)
    -- System       : DealNet System
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 30/06/1999

   M_RETVAL                     NUMBER;

BEGIN

   SELECT
      DN_FIN_PRICE_CLEAN_YIELD(M_SECURITY_CODE,M_REQ_YIELD,M_EFF_VALDATE,M_INT_RATE_BASE_CODE)+
      DN_FIN_INT_ACCURAL(M_SECURITY_CODE,M_EFF_VALDATE)
   INTO M_RETVAL
   FROM DUAL;

   RETURN ROUND(M_RETVAL,4);

END DN_FIN_PRICE_DIRTY_YIELD;

/
