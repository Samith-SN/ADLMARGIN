--------------------------------------------------------
--  DDL for Function DN_FIN_YIELD_NSLTT_F_YIELD_NET
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_YIELD_NSLTT_F_YIELD_NET" 
  (
    M_YIELD_NET         DN_TRN_OUTP_SALE.YIELD%TYPE
    --AS a percentage
   )

   RETURN  REAL

   IS

    -- Function     : Returns yield nsltt
    -- System       : DealNet System
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 02/07/1999

   M_RETVAL                     NUMBER;
   M_RATE                       NUMBER;

BEGIN

   SELECT
     M_YIELD_NET*(1+(SUM(NEW_RATE/100)))
     INTO M_RETVAL
   FROM
      DN_REF_TAX_RATE
   WHERE
      RATE_CODE='NSL' OR RATE_CODE='TT';

RETURN ROUND(M_RETVAL,6);

END DN_FIN_YIELD_NSLTT_F_YIELD_NET;

/
