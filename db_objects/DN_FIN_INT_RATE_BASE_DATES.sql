--------------------------------------------------------
--  DDL for Function DN_FIN_INT_RATE_BASE_DATES
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_INT_RATE_BASE_DATES" 
   (
    M_INT_RATE_BASE_CODE  DN_TRN_REPO_FRESH.INT_RATE_BASE_CODE%TYPE,
    M_EFF_VALDATE      DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE

   ) RETURN  REAL

    IS

    -- Function     : Returns interest rate base dates
    -- System       : DEALNET System
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 01/07/1999

 M_DENOMINATOR         NUMBER;

 BEGIN

    IF M_INT_RATE_BASE_CODE='AA' THEN

       SELECT
          ADD_MONTHS(M_EFF_VALDATE,12)-M_EFF_VALDATE
          INTO M_DENOMINATOR
       FROM DUAL;

    ELSE

       SELECT
          TO_NUMBER(DENOMINATOR) INTO M_DENOMINATOR
       FROM
          DN_REF_INTR_BASE
       WHERE
          INT_RATE_BASE_CODE=M_INT_RATE_BASE_CODE;

    END IF;

 RETURN M_DENOMINATOR;

END DN_FIN_INT_RATE_BASE_DATES;

/
