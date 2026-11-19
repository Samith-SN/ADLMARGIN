--------------------------------------------------------
--  DDL for Function DN_FIN_INST_LEG2_F_LEG1_RP
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_INST_LEG2_F_LEG1_RP" 
   (
    M_LEG1_VALUE          DN_TRN_REPO_FRESH.LEG1_VALUE%TYPE,
    M_YIELD               DN_TRN_REPO_FRESH.YIELD%TYPE,
    M_INT_PAY_FREQ        DN_TRN_REPO_PERIOD_INT.INT_PAY_FREQ%TYPE

   ) RETURN  REAL

    IS

    -- Function     : Returns COUPON INST from yeild and leg1 value -PERIODIC INTEREST
    -- System       : DEALNET System
    -- Created by   :  LATHIKA
    -- Created on   : 25/08/2000

 M_RETVAL              NUMBER;


 BEGIN

    SELECT
       ((M_LEG1_VALUE*M_YIELD)/M_INT_PAY_FREQ)
       INTO M_RETVAL
    FROM DUAL;

 RETURN ROUND(M_RETVAL,2);

END DN_FIN_INST_LEG2_F_LEG1_RP;

/
