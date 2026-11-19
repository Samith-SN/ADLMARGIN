--------------------------------------------------------
--  DDL for Procedure DEALADMIN_COMPILE_OBJECTS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DEALADMIN_COMPILE_OBJECTS" 

   -- PROCEDURE    : RECOMPILE INVALID DATABASE OBJECTS
   -- SYSTEM       : DEALNET SYSTEM - DATA MANAGEMENT MODULE
   -- CREATED BY   : V.THILAKESAN.
   -- CREATED ON   : 14/02/2000

  AS


   CURSOR M_FUNCTION IS

      SELECT
         OBJECT_NAME
      FROM
         SYS.DBA_OBJECTS
      WHERE
         OWNER='ADLMT'
         AND
         OBJECT_TYPE='FUNCTION'
         AND
         STATUS='INVALID';

   CURSOR M_PROCEDURE IS

      SELECT
         OBJECT_NAME
      FROM
         SYS.DBA_OBJECTS
      WHERE
         OWNER='ADLMT'
         AND
         OBJECT_TYPE='PROCEDURE'
         AND
         STATUS='INVALID';


   CURSOR M_PACKAGE IS

      SELECT
         OBJECT_NAME
      FROM
         SYS.DBA_OBJECTS
      WHERE
         OWNER='ADLMT'
         AND
         OBJECT_TYPE='PACKAGE'
         AND
         STATUS='INVALID';


  M_OBJECT_NAME     VARCHAR2(128);
  MAIN_CUR          INTEGER;
  IGNORE            INTEGER;
  M_ERR_NUM         INTEGER;
  M_INV_FUNCTION    NUMBER;
  M_INV_PROCEDURE   NUMBER;
  M_INV_PACKAGE     NUMBER;

BEGIN

   MAIN_CUR:=DBMS_SQL.OPEN_CURSOR;

   OPEN  M_FUNCTION;

      LOOP

         FETCH  M_FUNCTION INTO

         M_OBJECT_NAME;

         EXIT WHEN M_FUNCTION%NOTFOUND;

         DBMS_SQL.PARSE(MAIN_CUR,
             'ALTER FUNCTION ADLMARGIN.'|| M_OBJECT_NAME ||
             ' COMPILE',DBMS_SQL.V7);

         IGNORE:=DBMS_SQL.EXECUTE(MAIN_CUR);

      END LOOP;

   CLOSE  M_FUNCTION;


   OPEN  M_PROCEDURE;

      LOOP

         FETCH  M_PROCEDURE INTO

         M_OBJECT_NAME;

         EXIT WHEN M_PROCEDURE%NOTFOUND;

         DBMS_SQL.PARSE(MAIN_CUR,
             'ALTER PROCEDURE ADLMARGIN.'|| M_OBJECT_NAME ||
             ' COMPILE',DBMS_SQL.V7);

         IGNORE:=DBMS_SQL.EXECUTE(MAIN_CUR);


      END LOOP;

  CLOSE  M_PROCEDURE;

  OPEN  M_PACKAGE;

      LOOP

         FETCH  M_PACKAGE INTO

         M_OBJECT_NAME;

         EXIT WHEN M_PACKAGE%NOTFOUND;

         DBMS_SQL.PARSE(MAIN_CUR,
             'ALTER PACKAGE ADLMARGIN.'|| M_OBJECT_NAME ||
             ' COMPILE PACKAGE',DBMS_SQL.V7);

         IGNORE:=DBMS_SQL.EXECUTE(MAIN_CUR);

      END LOOP;

  CLOSE  M_PACKAGE;

  DBMS_SQL.CLOSE_CURSOR(MAIN_CUR);

  /* Outputing result into user */

     SELECT
         COUNT(*) INTO M_INV_FUNCTION
      FROM
         SYS.DBA_OBJECTS
      WHERE
         OWNER='ADLMT'
         AND
         OBJECT_TYPE='FUNCTION'
         AND
         STATUS='INVALID';

      SELECT
         COUNT(*) INTO M_INV_PROCEDURE
      FROM
         SYS.DBA_OBJECTS
      WHERE
         OWNER='ADLMT'
         AND
         OBJECT_TYPE='PROCEDURE'
         AND
         STATUS='INVALID';

      SELECT
         COUNT(*) INTO M_INV_PACKAGE
      FROM
         SYS.DBA_OBJECTS
      WHERE
         OWNER='ADLMT'
         AND
         OBJECT_TYPE='PACKAGE'
         AND
         STATUS='INVALID';

RAISE_APPLICATION_ERROR(-20201,':Inavlid Objects: Functions='||M_INV_FUNCTION||' Procedures='||M_INV_PROCEDURE||' Packages='||M_INV_PACKAGE);

END DEALADMIN_COMPILE_OBJECTS;

/
