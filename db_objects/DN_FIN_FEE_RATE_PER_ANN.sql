--------------------------------------------------------
--  DDL for Function DN_FIN_FEE_RATE_PER_ANN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_FEE_RATE_PER_ANN" 
   (
    M_FACE_VALUE          DN_TRN_BL_SECURITY.FACE_VALUE%TYPE,
    M_FEE_AMOUNT          DN_TRN_BL_SECURITY.FEE_AMOUNT%TYPE,
    M_TENOR               DN_TRN_BL_SECURITY.TENOR%TYPE

   ) RETURN  REAL

    IS

    -- Function     : Returns FEE RATE
    -- System       : DEALNET System
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 02/07/1999

 M_RETVAL              NUMBER;

 BEGIN

     SELECT
        (M_FEE_AMOUNT*365)/(M_FACE_VALUE*M_TENOR)
        INTO M_RETVAL
     FROM DUAL;

 RETURN ROUND(M_RETVAL,6);

END DN_FIN_FEE_RATE_PER_ANN;

/
