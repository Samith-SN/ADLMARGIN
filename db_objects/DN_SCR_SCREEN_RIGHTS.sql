--------------------------------------------------------
--  DDL for Function DN_SCR_SCREEN_RIGHTS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_SCR_SCREEN_RIGHTS" 
  (
    M_DN_USER        DN_REF_USER_VIEW_ACCESS.DN_USER%TYPE,
    M_SCREEN_NAME    DN_REF_USER_VIEW_ACCESS.SCREEN_NAME%TYPE
   )

   RETURN  REAL

   IS

    -- Function     : USER RIGHTS
    -- System       : DEALNET System
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 19/08/1999

   M_RETVAL                     NUMBER;

BEGIN

    M_RETVAL:=0;

    SELECT
       COUNT(F.GRANTEE) INTO M_RETVAL
    FROM
       SYS.DBA_ROLE_PRIVS F
    WHERE
       F.GRANTEE=M_DN_USER
       AND
       F.GRANTED_ROLE=UPPER(M_SCREEN_NAME);

  RETURN NVL(M_RETVAL,0);

END DN_SCR_SCREEN_RIGHTS;

/
