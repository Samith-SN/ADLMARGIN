--------------------------------------------------------
--  DDL for Procedure MBFSL_REPOSETTLE_DE1
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_REPOSETTLE_DE1" (
    M_DEAL_NO  IN OUT    DN_TRN_REPO_SETTLEMENT.DEAL_NO%TYPE
    )
AS

BEGIN

    --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO);

    -- PROCEDURE  -  TO DELETE REPO FULL SETTLEMENT
    -- SYSTEM     -  MBFSL SYSTEM
    -- CREATED BY -  V.THILAKESAN.
    -- CREATED ON -  26/11/1999

    IF M_DEAL_NO IS NOT NULL THEN
       --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||' '||M_SELECT_TYPE||' '||M_SECCODE||' '||M_SENOIDEN);
       UPDATE DN_TRN_REPO_SETTLEMENT
       SET NO_OF_SETTL_MODES=0
       WHERE DEAL_NO=M_DEAL_NO;

       DELETE
       FROM DN_TRN_REPO_SETTLEMENT_SETTLE
       WHERE
            DEAL_NO = M_DEAL_NO;

       COMMIT;

   END IF;
   --If the data type is incorrect then delete the records from the relavent tables

 EXCEPTION
  WHEN OTHERS THEN

    ROLLBACK;

    COMMIT;

    RAISE_APPLICATION_ERROR(-20201,'Cannot delete records, because of related information available in other table.');


END MBFSL_REPOSETTLE_DE1;

/
