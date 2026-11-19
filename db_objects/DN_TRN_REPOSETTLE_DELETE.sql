--------------------------------------------------------
--  DDL for Procedure DN_TRN_REPOSETTLE_DELETE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_TRN_REPOSETTLE_DELETE" 
   (M_DEALNO      DN_TRN_REPO_SETTLEMENT.DEAL_NO%TYPE,
    M_USER   DN_TRN_REPO_SETTLEMENT.DN_USER%TYPE
   )
AS

BEGIN

    /* PROCEDURE  -  REPOSETTLE DEAL DELETE
       SYSTEM     -  DEALNET
       CREATED BY -  V.THILAKESAN.
       CREATED ON -  27/04/2000
     */

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
--****************************************************

     UPDATE DN_TRN_REPO_SETTLEMENT
     SET APP_STATUS='CANCEL',
         PRIOR_DEAL_NO=M_DEALNO
     WHERE DEAL_NO=M_DEALNO;

     COMMIT;

END DN_TRN_REPOSETTLE_DELETE;

/
