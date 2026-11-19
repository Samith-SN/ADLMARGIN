--------------------------------------------------------
--  DDL for Function FA_GET_EMP_NAME_2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."FA_GET_EMP_NAME_2" 
(
    M_USER                              varchar2
)
    
RETURN VARCHAR2
    
AS
    
    /* 
     * CODE BY DISNAKA FOR COMFAC FACTORING 2010-06-18
     * MODIFIED BY SAMITHA FOR COMFAC FACTORING 2010-10-08
     */
    
    M_EMP_NAME                           VARCHAR2(100);
    M_COUNT                              NUMBER;
BEGIN
    
    /*SELECT INITCAP(AF_CO_GET_TITLE_DESC(B.TITLE)) || '. ' || INITCAP(NVL(B.NAME_DENOTED_BY_INITIALS, ' ')) || ' ' || INITCAP(B.LAST_NAME)
    INTO   M_EMP_NAME
    FROM   CO_CO_MAS_USER A,
           CO_CO_MAS_EMPLOYEE B
    WHERE  UPPER(A.USER_ID) = UPPER(M_USER)
    AND    UPPER(A.EMP_ID)  = UPPER(B.EMP_CODE)
    AND    ROWNUM = 1;
    */
   
    SELECT  COUNT(*) INTO M_COUNT
    FROM DN_REF_USER A WHERE DN_USER=M_USER;
    
    IF M_COUNT>0 THEN 
    
    SELECT  INITCAP(A.SURNAME)||' '||INITCAP(A.OTHER_NAMES) INTO M_EMP_NAME
    FROM DN_REF_USER A WHERE DN_USER=M_USER;
   
    ELSE
    M_EMP_NAME := 'Not Implement';
   
    END IF;
    RETURN M_EMP_NAME;
    
END;

/
