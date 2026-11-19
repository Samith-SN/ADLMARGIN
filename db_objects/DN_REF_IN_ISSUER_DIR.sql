--------------------------------------------------------
--  DDL for Procedure DN_REF_IN_ISSUER_DIR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_REF_IN_ISSUER_DIR" 

   (M_ISSUER_CODE                 DN_REF_ISSUER_INST_TYPE.ISSUER_CODE%TYPE,
    M_DIRECTOR_NAME               DN_REF_ISSUER_DIRECTOR.DIRECTOR_NAME%TYPE



   )
AS
BEGIN

    /* PROCEDURE  -  TO INSERT ISSUER DIRECTOR DETAILS
       SYSTEM     -  DEALNET
       CREATED BY -  CHARMINDA.
       CREATED ON -  15/06/1999 */

      IF M_DIRECTOR_NAME <> NULL THEN

       INSERT INTO DN_REF_ISSUER_DIRECTOR
              (ISSUER_CODE,
              DIRECTOR_NAME
              )
       VALUES
              (M_ISSUER_CODE,
               M_DIRECTOR_NAME);
       END IF;
       COMMIT;

END DN_REF_IN_ISSUER_DIR; 

/
