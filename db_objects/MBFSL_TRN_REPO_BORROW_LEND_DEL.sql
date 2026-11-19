--------------------------------------------------------
--  DDL for Procedure MBFSL_TRN_REPO_BORROW_LEND_DEL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_TRN_REPO_BORROW_LEND_DEL" 
   (M_DEALNO           DN_TRN_BL_FUND.DEAL_NO%TYPE,
    M_USER             DN_TRN_BL_FUND.DN_USER%TYPE
   )
AS



BEGIN

    /* PROCEDURE  -  BORROW LEND FUNDS DELETE
       SYSTEM     -  DEALNET
       CREATED BY -  DAYAN
       CREATED ON -  02/08/1999 */
		-- MODIFIED BY -  V.SUKATHIS.
    -- MODIFIED ON -  27/1/2000

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
--***************************************************
	DN_LIMIT_TRN_OVRL_EXPO(M_DEALNO,'U'); -- Modified by Sukathis

   UPDATE DN_TRN_BL_FUND
   SET
         APP_STATUS='CANCEL'
   WHERE M_DEALNO=DEAL_NO;


COMMIT;

END MBFSL_TRN_REPO_BORROW_LEND_DEL;

/
