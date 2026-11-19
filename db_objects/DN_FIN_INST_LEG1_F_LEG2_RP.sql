--------------------------------------------------------
--  DDL for Function DN_FIN_INST_LEG1_F_LEG2_RP
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_INST_LEG1_F_LEG2_RP" 
   (
    M_LEG2_VALUE          DN_TRN_REPO_FRESH.LEG1_VALUE%TYPE,
    M_YIELD               DN_TRN_REPO_FRESH.YIELD%TYPE,
    M_TENOR               DN_TRN_REPO_FRESH.TENOR%TYPE,
    M_INT_RATE_BASE_CODE  DN_TRN_REPO_FRESH.INT_RATE_BASE_CODE%TYPE,
    M_EFF_VALDATE         DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE,
    M_INT_PAY_FREQ        DN_TRN_REPO_PERIOD_INT.INT_PAY_FREQ%TYPE
   ) RETURN  REAL

    IS

    -- Function     : Returns LEG1 from leg2 value -periodic interest
    -- System       : DEALNET System
    -- Created by   : Lathika
    -- Created on   : 25/08/2000

 M_RETVAL              NUMBER;
 M_INT_BASE_DATES      NUMBER;

 BEGIN
M_RETVAL:=0;
    SELECT
       DN_FIN_INT_RATE_BASE_DATES(M_INT_RATE_BASE_CODE,M_EFF_VALDATE)
       INTO M_INT_BASE_DATES
    FROM DUAL;

    SELECT
     M_LEG2_VALUE -(M_LEG2_VALUE/(1+(M_YIELD/(M_INT_BASE_DATES*M_INT_PAY_FREQ)*M_TENOR)))
       INTO M_RETVAL
    FROM DUAL;

   -- M_RETVAL:=0;

 RETURN ROUND(M_RETVAL,2);

END DN_FIN_INST_LEG1_F_LEG2_RP;

/
