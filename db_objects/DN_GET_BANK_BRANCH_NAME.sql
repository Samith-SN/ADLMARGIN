--------------------------------------------------------
--  DDL for Function DN_GET_BANK_BRANCH_NAME
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_BANK_BRANCH_NAME" (
    M_BRANCH_CODE                        IN DN_REF_BANK.BRANCH_CODE % TYPE                              /* 01 */
)

RETURN VARCHAR2

AS
    
    M_BRANCH_NAME                           DN_REF_BANK.BRANCH_NAME % TYPE;
    
BEGIN
    
    SELECT A.BRANCH_NAME
    INTO   M_BRANCH_NAME
    FROM   DN_REF_BANK A
    WHERE  A.BRANCH_CODE = M_BRANCH_CODE;
    
    
    RETURN NVL(M_BRANCH_NAME, '-');
    
END DN_GET_BANK_BRANCH_NAME;

/
