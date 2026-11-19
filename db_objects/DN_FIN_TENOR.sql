--------------------------------------------------------
--  DDL for Function DN_FIN_TENOR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_TENOR" 
   (
    M_EFF_VALDATE         DN_TRN_REPO_FRESH.EFF_VALDATE%TYPE,
    M_MATURITY_DATE       DN_TRN_REPO_FRESH.MATURITY_DATE%TYPE
   ) RETURN  REAL

    IS

    -- Function     : Returns TENOR
    -- System       : DEALNET System
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 01/07/1999

 M_RETVAL              NUMBER;

 BEGIN

    SELECT
       (M_MATURITY_DATE-M_EFF_VALDATE)
       INTO M_RETVAL
    FROM DUAL;

    RETURN M_RETVAL;

END DN_FIN_TENOR;

/
