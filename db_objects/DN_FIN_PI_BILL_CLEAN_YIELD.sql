--------------------------------------------------------
--  DDL for Function DN_FIN_PI_BILL_CLEAN_YIELD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_PI_BILL_CLEAN_YIELD" 
  (
    M_REQ_YIELD           DN_TRN_OUTP_SALE.YIELD%TYPE,
    M_EFF_VALDATE         DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE,
    M_INT_RATE_BASE_CODE  DN_TRN_OUTP_SALE.INT_RATE_BASE_CODE%TYPE,
    M_MATURITY_DATE       DN_REF_SECURITY.MATURITY_DATE%TYPE
   )

   RETURN  REAL

   IS

    -- Function     : This returns BILL price for the req.yield
    -- System       : DEALNET System
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 30/06/1999

   M_RETVAL                     NUMBER;
  ---M_MATURITY_DATE              DN_REF_SECURITY.MATURITY_DATE%TYPE;
   M_NO_DAYS_PER_YEAR           NUMBER;
   M_NO_DAYS_UPTO_MATURITY      NUMBER;
   M_FACE_VALUE                 NUMBER;
   M_TAY                        NUMBER;

BEGIN

    M_FACE_VALUE   :=100.00;  -- Allways bILL face value is this
--    M_NO_DAYS_PER_YEAR :=364;

    SELECT
       DECODE(DENOMINATOR,'Act',(ADD_MONTHS(M_EFF_VALDATE,12)-M_EFF_VALDATE),DENOMINATOR)
       INTO M_NO_DAYS_PER_YEAR
    FROM
       DN_REF_INTR_BASE
    WHERE
       INT_RATE_BASE_CODE=M_INT_RATE_BASE_CODE;

   /* SELECT
       MATURITY_DATE
       INTO
       M_MATURITY_DATE
    FROM
       DN_REF_SECURITY
    WHERE
       SECURITY_CODE=M_SECURITY_CODE;
    */
--    DBMS_OUTPUT.PUT_LINE('EVALD  '||TO_CHAR(M_EFF_VALDATE,'DD-MON-YYYY'));

      SELECT
         (M_MATURITY_DATE-M_EFF_VALDATE)
         INTO M_NO_DAYS_UPTO_MATURITY
      FROM DUAL;

--    DBMS_OUTPUT.PUT_LINE('DAYUPTOMAT  '||TO_CHAR(M_NO_DAYS_UPTO_MATURITY ));

      --Tay

      M_TAY:=M_REQ_YIELD/M_NO_DAYS_PER_YEAR*M_NO_DAYS_UPTO_MATURITY;

--     DBMS_OUTPUT.PUT_LINE('TAY  '||TO_CHAR(M_TAY));

     M_RETVAL:=(M_FACE_VALUE/(1+M_TAY));

  RETURN ROUND(M_RETVAL,6);

END DN_FIN_PI_BILL_CLEAN_YIELD;

/
