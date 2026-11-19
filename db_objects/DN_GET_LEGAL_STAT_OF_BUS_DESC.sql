--------------------------------------------------------
--  DDL for Function DN_GET_LEGAL_STAT_OF_BUS_DESC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_LEGAL_STAT_OF_BUS_DESC" (
    M_ENTITY_CODE                        IN DN_REF_LEGAL_ENTITIES.ENTITY_CODE % TYPE                    /* 01 */
)

RETURN VARCHAR2

AS
    
    M_ENTITY_DESCRIPTION                    DN_REF_LEGAL_ENTITIES.DESCRIPTION % TYPE;
    
BEGIN
    
    SELECT A.DESCRIPTION
    INTO   M_ENTITY_DESCRIPTION
    FROM   DN_REF_LEGAL_ENTITIES A
    WHERE  A.ENTITY_CODE = M_ENTITY_CODE;
    
    
    RETURN NVL(M_ENTITY_DESCRIPTION, '-');
    
END DN_GET_LEGAL_STAT_OF_BUS_DESC;

/
