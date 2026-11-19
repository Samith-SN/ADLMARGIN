--------------------------------------------------------
--  DDL for Function DN_GET_FACILITY_ADVISER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_FACILITY_ADVISER" (
    M_PORT_CODE          DN_REF_PORT_ADV.PORT_CODE %TYPE                           
)

RETURN VARCHAR2

AS
    
    M_ADV_CODE           DN_REF_PORT_ADV.ADV_CODE % TYPE;
    
BEGIN
    
    SELECT A.ADV_CODE
    INTO   M_ADV_CODE
    FROM   DN_REF_PORT_ADV A
    WHERE  A.PORT_CODE = M_PORT_CODE;
    
    
    RETURN NVL(M_ADV_CODE, '-');
    
END;

/
