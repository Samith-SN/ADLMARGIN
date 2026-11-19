--------------------------------------------------------
--  DDL for Function DN_GET_AVAIL_RECOMMENDED_PER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_AVAIL_RECOMMENDED_PER" 
(
 M_security_code        DN_REF_SECURITY.security_code%TYPE
 )
 RETURN number
 AS
 M_MT_PERCENT      number;

 BEGIN

   SELECT  a.MT_PERCENT  INTO   M_MT_PERCENT
   FROM DN_REF_SECURITY a where a.security_code=M_security_code;
   RETURN  M_MT_PERCENT;
--a.security_code, a.ext_security_code,
 END ;

/
