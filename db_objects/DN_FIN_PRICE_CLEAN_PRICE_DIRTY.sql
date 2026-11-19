--------------------------------------------------------
--  DDL for Function DN_FIN_PRICE_CLEAN_PRICE_DIRTY
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_PRICE_CLEAN_PRICE_DIRTY" 
  (
    M_SECURITY_CODE       DN_TRN_OUTP_SALE.SECURITY_CODE%TYPE,
    M_DIRTY_PRICE         DN_TRN_OUTP_SALE.PRICE_CLEAN%TYPE,
    M_EFF_VALDATE         DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE,
    M_INT_RATE_BASE_CODE  DN_TRN_OUTP_SALE.INT_RATE_BASE_CODE%TYPE
   )

   RETURN  REAL

   IS

    -- Function     : This returns YEILD for the req.yield (Equal with excel function)
    -- System       : DealNet System
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 30/06/1999

   M_RETVAL                     NUMBER;
   M_CLEAN_PRICE                NUMBER;

BEGIN

  SELECT
    M_DIRTY_PRICE-DN_FIN_INT_ACCURAL(M_SECURITY_CODE,M_EFF_VALDATE)
   INTO M_RETVAL
  FROM DUAL;

   RETURN ROUND(M_RETVAL,6);

END DN_FIN_PRICE_CLEAN_PRICE_DIRTY;

/
