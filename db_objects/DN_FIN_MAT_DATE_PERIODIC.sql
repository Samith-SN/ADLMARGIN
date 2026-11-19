--------------------------------------------------------
--  DDL for Function DN_FIN_MAT_DATE_PERIODIC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_MAT_DATE_PERIODIC" 
   (
    M_EFF_VALDATE      DN_TRN_REPO_FRESH.EFF_VALDATE%TYPE,
    M_TENOR            DN_TRN_REPO_FRESH.TENOR%TYPE
   ) RETURN  DATE

    IS

    -- Function     : Returns MATURITY DATE
    -- System       : DEALNET System
    -- Created by   : Lathika
    -- Created on   : 20/sep/2000


 M_RETVAL              DATE;

 BEGIN

    SELECT
       ADD_MONTHS(TO_DATE(TO_CHAR((M_EFF_VALDATE),'DD-MON-YYYY'),'DD-MON-YYYY'),M_TENOR)
       INTO M_RETVAL
    FROM DUAL;

    RETURN M_RETVAL;

END DN_FIN_MAT_DATE_PERIODIC;

/
