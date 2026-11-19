--------------------------------------------------------
--  DDL for Procedure DEAL_APPROLEVEL1
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DEAL_APPROLEVEL1" 

   (M_DEALNO          DN_TRN_REPO_FRESH.DEAL_NO%TYPE,
    M_USER            DN_TRN_REPO_FRESH.DN_USER%TYPE

   )
AS

M_TYPE          VARCHAR2(2);

BEGIN

    /* PROCEDURE   -  DEAL REAPPRO1FICATION
       SYSTEM      -  DEALNT
       CREATED BY  -  CHARMINDA.
       CREATED ON  -  07/07/1999
       ADDED CODE FOR TIME LOG MANAGEMENT  BY -  S.YASODHA
       MODIFIED ON -  01-08-2000*/


IF SUBSTR(M_DEALNO,1,2)='BF' THEN
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
              'APPROVAL1'
           );

   UPDATE DN_TRN_BL_FUND SET
          APP_STATUS='APPRO1'
   WHERE M_DEALNO=DEAL_NO AND APP_STATUS='VERI';

ELSIF SUBSTR(M_DEALNO,1,2)='BS' THEN

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
              'APPROVAL1'
           );

   UPDATE DN_TRN_BL_SECURITY SET
          APP_STATUS='APPRO1'
   WHERE M_DEALNO=DEAL_NO AND APP_STATUS='VERI';

ELSIF SUBSTR(M_DEALNO,1,2)='OR' THEN


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
              'APPROVAL1'
           );

   UPDATE DN_TRN_OUTP_SALE SET
          APP_STATUS='APPRO1'
   WHERE M_DEALNO=DEAL_NO AND APP_STATUS='VERI';

ELSIF SUBSTR(M_DEALNO,1,2)='RF' THEN


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
              'APPROVAL1'
           );

   UPDATE DN_TRN_REPO_FRESH SET
          APP_STATUS='APPRO1'
   WHERE M_DEALNO=DEAL_NO AND APP_STATUS='VERI';

ELSIF SUBSTR(M_DEALNO,1,2)='PI' THEN


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
              'APPROVAL1'
           );

   UPDATE DN_TRN_REPO_PERIOD_INT SET
          APP_STATUS='APPRO1'
   WHERE M_DEALNO=DEAL_NO AND APP_STATUS='VERI';

ELSIF SUBSTR(M_DEALNO,1,2)='RR' THEN


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
              'APPROVAL1'
           );

   UPDATE DN_TRN_REPO_ROLLOVER SET
          APP_STATUS='APPRO1'
   WHERE M_DEALNO=DEAL_NO AND APP_STATUS='VERI';

ELSIF SUBSTR(M_DEALNO,1,2)='RS' THEN

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
              'APPROVAL1'
           );

   UPDATE DN_TRN_REPO_SETTLEMENT SET
          APP_STATUS='APPRO1'
   WHERE M_DEALNO=DEAL_NO AND APP_STATUS='VERI';

ELSIF SUBSTR(M_DEALNO,1,2)='SO' THEN

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
              'APPROVAL1'
           );

   UPDATE DN_TRN_SWAP_OUTRIGHT SET
          APP_STATUS='APPRO1'
   WHERE M_DEALNO=DEAL_NO AND APP_STATUS='VERI';

ELSIF SUBSTR(M_DEALNO,1,2)='SR' THEN


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
              'APPROVAL1'
           );

   UPDATE DN_TRN_SWAP_RETURNABLE SET
          APP_STATUS='APPRO1'
   WHERE M_DEALNO=DEAL_NO AND APP_STATUS='VERI';


END IF;

COMMIT;

END DEAL_APPROLEVEL1;

/
