--------------------------------------------------------
--  DDL for Function DN_FIN_FACE_VAL_FROM_COST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_FACE_VAL_FROM_COST" 
   (
    M_SECURITY_CODE       IN      DN_TRN_OUTP_SALE.SECURITY_CODE%TYPE,
    M_CLEAN_PRICE         IN      DN_TRN_OUTP_SALE.PRICE_CLEAN%TYPE,
    M_COST                IN      DN_TRN_OUTP_SALE.COST%TYPE

   )

     RETURN REAL

     IS

    -- Function     : Returns Face Value for the given cost
    -- System       : DEALNET System
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 01/07/1999

M_RETVAL     NUMBER;

BEGIN

   SELECT
      (M_COST*100)/M_CLEAN_PRICE
      INTO M_RETVAL
   FROM DUAL;

RETURN ROUND(M_RETVAL,0);

END DN_FIN_FACE_VAL_FROM_COST;

/
