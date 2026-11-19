--------------------------------------------------------
--  DDL for Function DN_FIN_MATURITY_DATE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_MATURITY_DATE" 
   (
    M_EFF_VALDATE      DN_TRN_REPO_FRESH.EFF_VALDATE%TYPE,
    M_TENOR            DN_TRN_REPO_FRESH.TENOR%TYPE
   ) RETURN  DATE

    IS

    -- Function     : Returns maturity date
    -- System       : DEALNET System
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 01/07/1999

 M_RETVAL              DATE;

 BEGIN

    SELECT
       TO_DATE(TO_CHAR((M_EFF_VALDATE+M_TENOR),'DD-MON-YYYY'),'DD-MON-YYYY')
       INTO M_RETVAL
    FROM DUAL;

    RETURN M_RETVAL;

END DN_FIN_MATURITY_DATE;

/
