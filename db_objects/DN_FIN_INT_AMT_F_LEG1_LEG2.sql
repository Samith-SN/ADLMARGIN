--------------------------------------------------------
--  DDL for Function DN_FIN_INT_AMT_F_LEG1_LEG2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_INT_AMT_F_LEG1_LEG2" 
   (
    M_LEG1_VALUE          DN_TRN_REPO_FRESH.LEG1_VALUE%TYPE,
    M_LEG2_VALUE          DN_TRN_REPO_FRESH.LEG2_VALUE%TYPE,
    M_TENOR               DN_TRN_REPO_FRESH.TENOR%TYPE,
    M_INT_RATE_BASE_CODE  DN_TRN_REPO_FRESH.INT_RATE_BASE_CODE%TYPE

   ) RETURN  REAL

    IS

    -- Function     : Returns INT AMT from leg2 value,leg1 value
    -- System       : DEALNET System
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 01/07/1999

 M_RETVAL              NUMBER;

 BEGIN

    SELECT
       M_LEG2_VALUE-M_LEG1_VALUE
       INTO M_RETVAL
    FROM DUAL;

 RETURN M_RETVAL;

END DN_FIN_INT_AMT_F_LEG1_LEG2;

/
