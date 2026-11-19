--------------------------------------------------------
--  DDL for Function DN_FIN_LEG2_F_LEG1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_LEG2_F_LEG1" 
   (
    M_LEG1_VALUE          DN_TRN_REPO_FRESH.LEG1_VALUE%TYPE,
    M_YIELD               DN_TRN_REPO_FRESH.YIELD%TYPE,
    M_TENOR               DN_TRN_REPO_FRESH.TENOR%TYPE,
    M_INT_RATE_BASE_CODE  DN_TRN_REPO_FRESH.INT_RATE_BASE_CODE%TYPE,
    M_EFF_VALDATE         DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE

   ) RETURN  REAL

    IS

    -- Function     : Returns LEG2 from leg1 value
    -- System       : DEALNET System
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 01/07/1999

 M_RETVAL              NUMBER;

 BEGIN

    SELECT
       DN_FIN_INT_AMT_F_LEG1(M_LEG1_VALUE,M_YIELD,M_TENOR,M_INT_RATE_BASE_CODE,M_EFF_VALDATE)+
       M_LEG1_VALUE
       INTO M_RETVAL
    FROM DUAL;

 RETURN ROUND(M_RETVAL,2);

END DN_FIN_LEG2_F_LEG1;

/
