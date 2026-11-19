--------------------------------------------------------
--  DDL for Function DN_FIN_TENOR_PERIODIC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_TENOR_PERIODIC" 
   (
    M_EFF_VALDATE         DN_TRN_REPO_FRESH.EFF_VALDATE%TYPE,
    M_MATURITY_DATE       DN_TRN_REPO_FRESH.MATURITY_DATE%TYPE
   ) RETURN  REAL

    IS

    -- Function     : Returns TENOR
    -- System       : DEALNET System
    -- Created by   : Lathika
    -- Created on   : 20/sep/2000

 M_RETVAL              NUMBER;

 BEGIN

    SELECT
       MONTHS_BETWEEN(M_MATURITY_DATE,M_EFF_VALDATE)
       INTO M_RETVAL
    FROM DUAL;

    RETURN M_RETVAL;

END DN_FIN_TENOR_PERIODIC;

/
