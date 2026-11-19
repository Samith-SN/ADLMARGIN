--------------------------------------------------------
--  DDL for Function DN_FIN_PRICE_DIRTY_CLEAN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_PRICE_DIRTY_CLEAN" 

(
    M_SECURITY_CODE       DN_TRN_OUTP_SALE.SECURITY_CODE%TYPE,
    M_EFF_VALDATE         DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE,
    M_CLEAN_PRICE         DN_TRN_OUTP_SALE.PRICE_CLEAN%TYPE

   )

   RETURN  REAL

   IS

    -- Function     : This returns DIRTY price for the CLEAN (Equal with excel function)
    -- System       : DealNet System
    -- Created by   : LATHIKA
    -- Created on   : 06/07/2000

   M_RETVAL                     NUMBER;

BEGIN

   SELECT
      M_CLEAN_PRICE+
      ROUND(DN_FIN_INT_ACCURAL(M_SECURITY_CODE,M_EFF_VALDATE),4)
   INTO M_RETVAL
   FROM DUAL;

   RETURN ROUND(M_RETVAL,4);

END DN_FIN_PRICE_DIRTY_CLEAN;

/
