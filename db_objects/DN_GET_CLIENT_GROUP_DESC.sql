--------------------------------------------------------
--  DDL for Function DN_GET_CLIENT_GROUP_DESC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_CLIENT_GROUP_DESC" (
    M_GROUP_CODE                         IN DN_REF_CLIENT_GROUPS.GROUP_CODE % TYPE                      /* 01 */
)

RETURN VARCHAR2

AS
    
    M_GROUP_DESCRIPTION                     DN_REF_CLIENT_GROUPS.GROUP_DESC % TYPE;
    
BEGIN
    
    SELECT A.GROUP_DESC
    INTO   M_GROUP_DESCRIPTION
    FROM   DN_REF_CLIENT_GROUPS A
    WHERE  A.GROUP_CODE = M_GROUP_CODE;
    
    
    RETURN NVL(M_GROUP_DESCRIPTION, '-');
    
END DN_GET_CLIENT_GROUP_DESC;

/
