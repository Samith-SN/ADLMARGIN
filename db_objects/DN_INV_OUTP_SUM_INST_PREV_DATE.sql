--------------------------------------------------------
--  DDL for Function DN_INV_OUTP_SUM_INST_PREV_DATE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_INV_OUTP_SUM_INST_PREV_DATE" 
  (
    M_PORTFOLIO_CODE     DN_TRN_OUTP_SALE.BUY_PORTFOLIO_CODE%TYPE,
    M_EFF_VALDATE        DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE,
    M_INST_TYPE          DN_TRN_OUTP_SALE.INST_TYPE%TYPE
   )

   RETURN  DATE

   IS

    -- Function     : This returns previous date for the security
    -- System       : DEALNET System
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 09/07/1999

   M_RETVAL              DN_REF_SECURITY.MATURITY_DATE%TYPE;

BEGIN

  SELECT
     MAX(EFF_VALDATE) INTO M_RETVAL
  FROM
     DN_INV_OUTPS_SUM_INS
  WHERE
     PORTFOLIO_CODE=M_PORTFOLIO_CODE
     AND
     EFF_VALDATE<M_EFF_VALDATE
     AND
     INST_TYPE=M_INST_TYPE;

  RETURN M_RETVAL;

END DN_INV_OUTP_SUM_INST_PREV_DATE;

/
