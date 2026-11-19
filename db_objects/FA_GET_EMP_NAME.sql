--------------------------------------------------------
--  DDL for Function FA_GET_EMP_NAME
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."FA_GET_EMP_NAME" 
(
    M_USER                               IN dn_ref_user.dn_user % TYPE
)
    
RETURN VARCHAR2
    
AS
    
 
    
    M_EMP_NAME                              VARCHAR2(100);
    
BEGIN
    /*
    SELECT INITCAP(AF_CO_GET_TITLE_DESC(B.TITLE)) || '. ' || INITCAP(B.INITIALS) || ' ' || INITCAP(B.LAST_NAME)
    INTO   M_EMP_NAME
    FROM   CO_CO_MAS_USER A,
           CO_CO_MAS_EMPLOYEE B
    WHERE  UPPER(A.USER_ID) = UPPER(M_USER)
    AND    UPPER(A.EMP_ID)  = UPPER(B.EMP_CODE)
    AND    ROWNUM = 1;
    */
    SELECT  INITCAP(a.surname)|| ' ' ||  INITCAP(a.other_names)
    INTO   M_EMP_NAME
    FROM dn_ref_user a where a.dn_user=M_USER;
    
    RETURN M_EMP_NAME;
    
END;

/
