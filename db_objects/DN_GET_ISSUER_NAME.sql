--------------------------------------------------------
--  DDL for Function DN_GET_ISSUER_NAME
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_ISSUER_NAME" 
( M_SECURITY_CODE IN DN_REF_SECURITY.ISSUER_CODE%TYPE)
  RETURN VARCHAR2 IS
    -----------------------------------------------------------------------------------------------------------------------
    -- Purpose: This function will return the Issuer's Description for a given Security Code
    -- Created By:  Keith on 23-09-2004
    -- Person:      Date
    -- System:      fclmgt
    -----------------------------------------------------------------------------------------------------------------------


  M_NAME            DN_REF_PRIMARY_ISSUER.ISSUER_NAME%TYPE;

BEGIN
dbms_output.put_line(' M_SECURITY_CODE----'||M_SECURITY_CODE);
--RAISE_APPLICATION_ERROR (-20201,'M_SECURITY_CODE'||M_SECURITY_CODE); --ABAN-N-0000
     
   BEGIN
     
     SELECT C.ISSUER_NAME INTO M_NAME
     FROM
     DN_REF_SECURITY B,
     DN_REF_PRIMARY_ISSUER C
     WHERE
     (B.SECURITY_CODE = M_SECURITY_CODE OR B.EXT_SECURITY_CODE = M_SECURITY_CODE)
     AND B.ISSUER_CODE = C.ISSUER_CODE AND ROWNUM = 1
     AND B.ACTIVE_STATUS = 'Y'; --ADD BY WARUNA 2013-01-15
     
     RETURN INITCAP(UPPER(M_NAME)) ;
     
     EXCEPTION  --ADD BY WARUNA 2013-01-15
       WHEN NO_DATA_FOUND THEN 
     
      RETURN '-' ;
     
     END;

END;

/
