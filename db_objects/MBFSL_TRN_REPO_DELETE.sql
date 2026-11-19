--------------------------------------------------------
--  DDL for Procedure MBFSL_TRN_REPO_DELETE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_TRN_REPO_DELETE" 
   (M_DEALNO           DN_TRN_REPO_FRESH.DEAL_NO%TYPE,
    M_USER            DN_TRN_REPO_FRESH.DN_USER%TYPE
   )
AS


BEGIN

DN_VALIDATE_SAVE_RIGHTS(M_USER,'WD_Repos_Fresh'); --added by ashini on 31/10/2005 for sr0509-047

    /* PROCEDURE  -  REPO FRESH DEAL_DELETE
       SYSTEM     -  DEALNET
       CREATED BY -  DAYAN
       CREATED ON -  23/07/1999 */
		-- MODIFIED BY -  V.SUKATHIS.
    -- MODIFIED ON -  27/1/2000


--RAISE_APPLICATION_ERROR(-20201,M_DEALNO);

--***************ADDED FOR TIME LOG REQUIREMRNT  BY S.YASODHA****************
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
----*******************************

--DN_LIMIT_TRN_OVRL_EXPO(M_DEALNO,'U'); -- Modified by Sukathis
            /*DN_LIMIT_TRN_OVRL_MATU(M_DEALNO,'U');--ADD BY DAYAN TO RUN TRANSACTION PROCEDURE
            DN_LIMIT_TRN_OVRL(M_DEALNO,'U');-- Modified by Sukathis
            DN_LIMIT_TRN_OVRL_EXPO(M_DEALNO,'U');-- Modified by Sukathis
            DN_LIMIT_TRN_ISSUER_INST_AMT(M_DEALNO,'U');--added by nirmala
            DN_LIMIT_TRN_ISSUER_INST_MAT(M_DEALNO,'U');--added by nirmala
            DN_LIMIT_TRN_ISS_HOL_PERIOD(M_DEALNO,'U');--added by nirmala
*/
            --DN_LIMIT_TRN_DEALER_INST_AMT(M_DEALNO,'U');--added by nirmala


 IF (SUBSTR(M_DEALNO,1,2)='GF')THEN

    UPDATE DN_TRN_REPO_FRESH
   SET    APP_STATUS='CANCEL'
   WHERE  GROUP_DEALNO=M_DEALNO;


 ELSE

   UPDATE DN_TRN_REPO_FRESH
   SET
         APP_STATUS='CANCEL'
   WHERE M_DEALNO=DEAL_NO;

END IF;

COMMIT;

END MBFSL_TRN_REPO_DELETE;

/
