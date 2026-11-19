--------------------------------------------------------
--  DDL for Function DN_GET_BANK_NAME
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_BANK_NAME" (
    M_BRANCH_CODE                        IN DN_REF_BANK.BRANCH_CODE % TYPE                              /* 01 */
)

RETURN VARCHAR2

AS
    
    M_BANK_NAME                             DN_REF_BANK.BANK_NAME % TYPE;
    
BEGIN
    
    SELECT A.BANK_NAME
    INTO   M_BANK_NAME
    FROM   DN_REF_BANK A
    WHERE  A.BRANCH_CODE = M_BRANCH_CODE;
    
    
    RETURN NVL(M_BANK_NAME, '-');
    
END DN_GET_BANK_NAME;

/
