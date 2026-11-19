--------------------------------------------------------
--  DDL for Procedure HOLIDAY_OPT_MODI
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."HOLIDAY_OPT_MODI" 

   (M_DAY       VARCHAR2,
    M_DESC      DN_REF_HOLIDAY.HOLIDAY_DESC%TYPE,
    M_USRE      VARCHAR

    )

AS

BEGIN

DN_VALIDATE_SAVE_RIGHTS(M_USRE,'WD_Holidays');  --added by ashini on 31/10/2005 for sr0509-047

--RAISE_APPLICATION_ERROR(-20201,M_DAY||' '||M_DESC);

    /* PROCEDURE  - TO SAVE NEW HOLIDAY
       SYSTEM     - DEALNET
       CREATED BY - SUKATHIS
       CREATED ON -  13/JULY/1999*/

UPDATE DN_REF_HOLIDAY
SET HOLIDAY_DESC=M_DESC
WHERE HOLIDAY=TO_DATE(M_DAY,'DD/MM/YYYY');

COMMIT;
END HOLIDAY_OPT_MODI;

/
