--------------------------------------------------------
--  DDL for Function DN_EXT_SECURITY
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_EXT_SECURITY" 
( M_SEC IN DN_REF_SECURITY.SECURITY_CODE%TYPE)
  RETURN VARCHAR2 IS


  M_EXT            DN_REF_SECURITY.EXT_SECURITY_CODE%TYPE;

BEGIN

     SELECT EXT_SECURITY_CODE INTO M_EXT FROM DN_REF_SECURITY
     WHERE SECURITY_CODE = M_SEC;

    RETURN M_EXT ;

END; -- Function dn_GET_ISSUER

/
