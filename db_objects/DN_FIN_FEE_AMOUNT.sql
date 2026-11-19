--------------------------------------------------------
--  DDL for Function DN_FIN_FEE_AMOUNT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_FEE_AMOUNT" 
   (
    M_FACE_VALUE          DN_TRN_BL_SECURITY.FACE_VALUE%TYPE,
    M_FEE_RATE_PER_ANN    DN_TRN_BL_SECURITY.FEE_RATE_PER_ANN%TYPE,
    --As a percentage
    M_TENOR               DN_TRN_BL_SECURITY.TENOR%TYPE

   ) RETURN  REAL

    IS

    -- Function     : Returns FEE AMOUNT
    -- System       : DEALNET System
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 02/07/1999

 M_RETVAL              NUMBER;

 BEGIN

     SELECT
        (M_FACE_VALUE*M_FEE_RATE_PER_ANN*(M_TENOR/365))
        INTO M_RETVAL
     FROM DUAL;

 RETURN ROUND(M_RETVAL,6);

END DN_FIN_FEE_AMOUNT;

/
