--------------------------------------------------------
--  DDL for Function DN_FIN_CLEAN_PRICE_F_COST_FV
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_CLEAN_PRICE_F_COST_FV" 
   (
    M_FACE_VAL            IN      DN_TRN_OUTP_SALE.FACE_VALUE%TYPE,
    M_COST                IN      DN_TRN_OUTP_SALE.COST%TYPE

   )

     RETURN REAL

     IS

    -- Function     : Returns CLEAN PRICE for the given cost
    -- System       : DEALNET System
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 06/07/1999

M_RETVAL     NUMBER;

BEGIN

   SELECT
      (M_COST*100)/M_FACE_VAL
      INTO M_RETVAL
   FROM DUAL;

RETURN M_RETVAL;

END DN_FIN_CLEAN_PRICE_F_COST_FV;

/
