--------------------------------------------------------
--  DDL for Procedure DN_REF_IN_ISSUER_RATE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_REF_IN_ISSUER_RATE" 

   (M_ISSUER_CODE                 DN_REF_PRIMARY_ISSUER.ISSUER_CODE%TYPE,
    M_RAT_DESC                    DN_REF_ISSUER_CR_RATING.RAT_DESC%TYPE
    )
AS
    T_COUNT1        NUMBER;
    INCT            INTEGER;

BEGIN

    /* PROCEDURE  -  TO INSERT ISSUER RATE DETAILS
       SYSTEM     -  DEALNET
       CREATED BY -  CHARMINDA.
       CREATED ON -  15/06/1999 */

      T_COUNT1:=0;

         SELECT COUNT(*) INTO T_COUNT1 FROM DN_REF_ISSUER_CR_RATING
         WHERE  ISSUER_CODE=M_ISSUER_CODE;

     IF T_COUNT1=0 THEN

        INSERT INTO DN_REF_ISSUER_CR_RATING
              (ISSUER_CODE,
              RAT_DESC,
              SEQ_NO
              )
        VALUES
              (M_ISSUER_CODE,
               M_RAT_DESC,
               '1'
               );
      ELSE
         SELECT MAX(SEQ_NO)+1 INTO INCT FROM DN_REF_ISSUER_CR_RATING;


        INSERT INTO DN_REF_ISSUER_CR_RATING
              (ISSUER_CODE,
              RAT_DESC,
              SEQ_NO
              )
        VALUES
              (M_ISSUER_CODE,
               M_RAT_DESC,
               INCT
               );
      END IF;



               COMMIT;

END DN_REF_IN_ISSUER_RATE;

/
