--------------------------------------------------------
--  DDL for Function DN_GET_ISSUER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_ISSUER" 
( M_ISSUER_GROUP_CODE IN DN_REF_PRIMARY_ISSUER.ISSUER_CODE%TYPE)
  RETURN VARCHAR2 IS
    -----------------------------------------------------------------------------------------------------------------------
    -- Purpose: This function will return the Issuer's Description for a given Issuer Code
    -- Created By :
    -- Person      Date           Comments
    -- Siva        14-09-2000
   -----------------------------------------------------------------------------------------------------------------------


  M_NAME            DN_REF_PRIMARY_ISSUER.ISSUER_NAME%TYPE;

BEGIN

     SELECT ISSUER_NAME INTO M_NAME FROM DN_REF_PRIMARY_ISSUER
     WHERE ISSUER_CODE = M_ISSUER_GROUP_CODE;

    RETURN M_NAME ;

END; -- Function dn_GET_ISSUER

/
