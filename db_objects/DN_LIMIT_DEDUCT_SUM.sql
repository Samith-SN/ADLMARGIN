--------------------------------------------------------
--  DDL for Function DN_LIMIT_DEDUCT_SUM
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_LIMIT_DEDUCT_SUM" 
(
 M_FACE_VALUE        DN_TRN_OUTP_SALE.FACE_VALUE%TYPE
 )

 RETURN  INTEGER

IS

          -- FUNCTION     : THIS RETURNS THE NEGATIVE VALUE;
          -- SYSTEM       : DEALNET SYSTEM
          -- CREATED BY   : SUKATHIS
          -- CREATED ON   : 26/01/2000

BEGIN

RETURN -M_FACE_VALUE;

END DN_LIMIT_DEDUCT_SUM;

/
