--------------------------------------------------------
--  DDL for Procedure MBFSL_REF_LOCATION_DEACTIVE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_REF_LOCATION_DEACTIVE" 
   (M_LOC_CODE         DN_REF_LOCATION.LOC_CODE%TYPE,
    M_USRE             VARCHAR
   )
AS


BEGIN


DN_VALIDATE_SAVE_RIGHTS(M_USRE,'WD_Location');  --added by ashini on 31/10/2005 for sr0509-047

    /* PROCEDURE  -  LOCATION_DEACTIE
       SYSTEM     -  DEALNET
       CREATED BY -  DAYAN
       CREATED ON -  08/09/1999 */
--RAISE_APPLICATION_ERROR(-20201,M_LOC_CODE);

   UPDATE DN_REF_LOCATION
   SET
         ACTIVE_STATUS='N'
   WHERE LOC_CODE=M_LOC_CODE;


COMMIT;

END MBFSL_REF_LOCATION_DEACTIVE;

/
