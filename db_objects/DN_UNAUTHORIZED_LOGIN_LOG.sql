--------------------------------------------------------
--  DDL for Procedure DN_UNAUTHORIZED_LOGIN_LOG
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_UNAUTHORIZED_LOGIN_LOG" 
(
 M_USER                 VARCHAR2,
 M_SCRNAME              DN_REF_SCREEN_URL.DN_SCREEN_NAME%TYPE,
 M_CLIENT_IP            VARCHAR2

)

  -- PROCEDURE    : TRACK DN_UNAUTHORIZED_LOGIN
  -- SYSTEM       : DEALNET SYSTEM
  -- CREATED BY   : LATHIKA
  -- CREATED ON   : 05/10/2000

 AS
M_NUM              NUMBER ;

BEGIN

 M_NUM :=   0;

 IF M_NUM = 0   THEN

  UPDATE DN_UNAUTHORIZED_LOGIN
  SET    USER_NAME   = M_USER
  WHERE  USER_NAME   = M_USER
  AND    TO_CHAR(ENT_DATE,'DD-MON-YYYY:HH24:MI:SS')   IN (SELECT
                                                            TO_CHAR(SYSDATE,'DD-MON-YYYY:HH24:MI:SS')
                                                          FROM DUAL)
  AND     SCREEN_NAME =M_SCRNAME;

 IF SQL%NOTFOUND THEN

 INSERT INTO DN_UNAUTHORIZED_LOGIN
        (USER_NAME,
         ENT_DATE,
         SCREEN_NAME,
         CLIENT_IP)
 VALUES (M_USER,
         SYSDATE,
         M_SCRNAME,
         M_CLIENT_IP);

END IF;

END IF;
--COMMIT;

END DN_UNAUTHORIZED_LOGIN_LOG;


/*GRANT EXECUTE ON DN_UNAUTHORIZED_LOGIN TO connect
/
*/
-- End of DDL script for DN_LOGIN_OK

/
