--------------------------------------------------------
--  DDL for Procedure TEST_STRING
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."TEST_STRING" 

/**************************************************************/
/* Procedure   : Control Process for MF System                */
/* System      : MF System                                    */
/* Created By  :                                              */
/* Created On  : 31/08/1999                                   */
/* Modified On :                                              */
/**************************************************************/

-- M_USER_NAME       MLLADMIN.MF_LOG_DAYMONTH_ROUTINE.DAY_USER%TYPE

AS
M_EXECUTE         VARCHAR2(500);
MAIN_CUR          INTEGER;
IGNORE            INTEGER;

 BEGIN

   M_EXECUTE := 'EXP YOHAN/ALL123@DEALNET OWNER=YOHAN GRANTS=N ROWS=Y FILE=D:\YOHAN.DMP LOG=D:\YOHAN.DAT;';--'INSERT INTO TEST_STRING_TAB VALUE(SELECT PORTFOLIO_CODE from DN_REF_PORTFOLIO)';

   EXECUTE IMMEDIATE M_EXECUTE;

/* MAIN_CUR:=DBMS_SQL.OPEN_CURSOR;


   DBMS_SQL.PARSE(MAIN_CUR,
      'GRANT CREATE TALBE '||M_USER_NAME,DBMS_SQL.V7);

   IGNORE:=DBMS_SQL.EXECUTE(MAIN_CUR);

   DBMS_SQL.PARSE(MAIN_CUR,
      'GRANT DROP ANY TALBE '||M_USER_NAME,DBMS_SQL.V7);

   IGNORE:=DBMS_SQL.EXECUTE(MAIN_CUR);


   --M_EXECUTE := 'DROP TABLE MLLADMIN.MF_PRE_DAY_VALID_INVOICE';

   --EXECUTE IMMEDIATE M_EXECUTE;

   M_EXECUTE := 'CREATE TABLE MLLADMIN.TEST1 AS SELECT * from MLLADMIN.MF_TRN_VALID_INVOICE';

   EXECUTE IMMEDIATE M_EXECUTE;



 DBMS_SQL.PARSE(MAIN_CUR,
      'REVOKE CREATE TALBE '||M_USER_NAME,DBMS_SQL.V7);

 DBMS_SQL.PARSE(MAIN_CUR,
      'REVOKE DROP ANY TALBE '||M_USER_NAME,DBMS_SQL.V7);

IGNORE:=DBMS_SQL.EXECUTE(MAIN_CUR);
*/

END ;

/
