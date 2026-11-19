--------------------------------------------------------
--  DDL for Procedure TRN_BLSEC_DELETE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."TRN_BLSEC_DELETE" 
   (M_DEALNO      DN_TRN_BL_SECURITY.DEAL_NO%TYPE,
    M_USER  DN_TRN_BL_SECURITY.DN_USER%TYPE
   )
AS


BEGIN

    /* PROCEDURE  -  B/L SECURITY DEAL DELETE
       SYSTEM     -  DEALNET
       CREATED BY -  CHARMINDA
       CREATED ON -  03/08/1999 */
--RAISE_APPLICATION_ERROR(-20201,M_DEALNO);

 --ADDED FOR TIME LOG MANAGEMENT BY S.YASODHA
     INSERT INTO DN_TIME_LOG
           (SUS_REF_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            (
              M_DEALNO,
              M_USER,
              SYSDATE,
              'DELETION'
           );
--*********************************************

   UPDATE DN_TRN_BL_SECURITY SET
         APP_STATUS='CANCEL'
   WHERE M_DEALNO=DEAL_NO;


COMMIT;

END TRN_BLSEC_DELETE;

/
