--------------------------------------------------------
--  DDL for Procedure DN_SETTLE_PRE_TEMP_DELETE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_SETTLE_PRE_TEMP_DELETE" 
   
AS


BEGIN

    /* PROCEDURE  - 
       SYSTEM     -  DEALNET
       CREATED BY -  Waruna
       CREATED ON - 25/11/2011*/
--RAISE_APPLICATION_ERROR(-20201,M_DEALNO);

DELETE FROM DN_SETTLE_PRE_TEMP;

END ;

/
