--------------------------------------------------------
--  DDL for Procedure TRN_SOOUT_DELETE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."TRN_SOOUT_DELETE" 
   (M_DEALNO      DN_TRN_SWAP_OUTRIGHT.DEAL_NO%TYPE
   )
AS


BEGIN

    /* PROCEDURE  -  SWAP OUT DEAL DELETE
       SYSTEM     -  DEALNET
       CREATED BY -  CHARMINDA
       CREATED ON -  03/08/1999 */
--RAISE_APPLICATION_ERROR(-20201,M_DEALNO);

   UPDATE DN_TRN_SWAP_OUTRIGHT SET
         APP_STATUS='CANCEL'
   WHERE M_DEALNO=DEAL_NO;


COMMIT;

END TRN_SOOUT_DELETE;

/
