--------------------------------------------------------
--  DDL for Function DN_GET_CONCENTRATION_PERCENT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_CONCENTRATION_PERCENT" 
(
 M_security_code        DN_REF_SECURITY.security_code%TYPE
 )
 RETURN number
 AS
 M_Concentration_percent      number;

 BEGIN

   SELECT  a.CONCENTRATION_PERCENT  INTO   M_Concentration_percent
   FROM DN_REF_SECURITY a where a.security_code=M_security_code;
   RETURN  M_Concentration_percent;
--a.security_code, a.ext_security_code,
 END ;

/
