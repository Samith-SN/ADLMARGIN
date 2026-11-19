--------------------------------------------------------
--  DDL for Procedure TEST_UPDATION_ERRORS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."TEST_UPDATION_ERRORS" (
    M_MODE        IN        VARCHAR2
  )
AS
MDATE      DATE;
BDATE      DATE;

BEGIN

/*----------------CREATED BY LATHIKA ------------
 -----------------ON 23/11/2000      -----------
 ---------TEST PROCEDURE TO CHECK ERRORS--------*/


    --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO);
    IF M_MODE = 'A' THEN
       SELECT  SYSDATE
       INTO    MDATE
       FROM DUAL;

       UPDATE TEST_ERRORS
       SET TYPE = 'C'
       WHERE NAME = 'TEST4';

       SELECT  SYSDATE
       INTO    BDATE
       FROM    DUAL;
       /*
       DELETE TEST_ERRORS
       WHERE NAME = 'TEST2';*/
   END IF;

    IF SQL%NOTFOUND THEN
     INSERT INTO TEST_ERRORS
               (NAME,
                TYPE
                )
                VALUES
               ('TEST4',
                'D'
                );

    END IF;

    COMMIT;
 EXCEPTION
  WHEN OTHERS THEN

    ROLLBACK;

    COMMIT;

    RAISE_APPLICATION_ERROR(-20201,'Cannot update records, because of incorrect data type.');

END TEST_UPDATION_ERRORS;

/
