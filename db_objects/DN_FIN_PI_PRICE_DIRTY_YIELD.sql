--------------------------------------------------------
--  DDL for Function DN_FIN_PI_PRICE_DIRTY_YIELD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_PI_PRICE_DIRTY_YIELD" 
(
    M_REQ_YIELD           DN_TRN_OUTP_SALE.YIELD%TYPE,
    M_EFF_VALDATE         DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE,
    M_INT_RATE_BASE_CODE  DN_TRN_OUTP_SALE.INT_RATE_BASE_CODE%TYPE,
    M_MATURITY_DATE       DN_TRN_REPO_PERIOD_INT.MATURITY_DATE%TYPE,
    M_COUPON_INT          DN_TRN_REPO_PERIOD_INT.TENOR%TYPE,
    M_FREQUENCY           NUMBER,
    M_SEQNO               VARCHAR2
   )

   RETURN  REAL

   IS

    -- Function     : This returns DIRTY price for the req.yield (Periodic Interest)
    -- System       : DealNet System
    -- Created by   : V.Thilakesan.
    -- Created on   : 13/03/2000

   M_RETVAL                     NUMBER;

BEGIN

   SELECT
      DN_FIN_PI_PRICE_CLEAN_YIELD(M_REQ_YIELD,M_EFF_VALDATE,M_INT_RATE_BASE_CODE,M_MATURITY_DATE,M_COUPON_INT,M_FREQUENCY,M_SEQNO)+
      DN_FIN_PI_INT_ACCURAL(M_EFF_VALDATE,M_COUPON_INT,M_SEQNO)
   INTO M_RETVAL
   FROM DUAL;

   RETURN ROUND(M_RETVAL,4);

END DN_FIN_PI_PRICE_DIRTY_YIELD;

/
