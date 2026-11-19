--------------------------------------------------------
--  DDL for Function DN_GET_PAR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_PAR" 
(
  MSECCODE     DN_REF_SECURITY.SECURITY_CODE%TYPE

)
   Return Real IS
   PAR NUMBER;


BEGIN

  SELECT NVL(PAR_VALUE,0) INTO  PAR FROM
  DN_REF_SECURITY
  WHERE  SECURITY_CODE=MSECCODE ;

  RETURN PAR;

END;

/
