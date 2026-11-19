--------------------------------------------------------
--  DDL for Procedure MBFSL_REPOFRESH_DE1
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_REPOFRESH_DE1" (
    M_DEAL_NO  IN OUT    DN_TRN_REPO_FRESH.DEAL_NO%TYPE,
    M_SELECT_TYPE        CHAR,
    M_USER               VARCHAR,
    M_SCREEN             VARCHAR

    )
AS

BEGIN

DN_VALIDATE_SAVE_RIGHTS(M_USER,M_SCREEN);  --added by ashini on 31/10/2005 for sr0509-047


    --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO);

    -- PROCEDURE  -  TO DELETE REPOFRESH DETAILS
    -- SYSTEM     -  MBFSL SYSTEM
    -- CREATED BY -  V.THILAKESAN.
    -- CREATED ON -  14/08/1999

    IF M_DEAL_NO IS NOT NULL THEN
       IF M_SELECT_TYPE='MAIN' THEN
          UPDATE DN_TRN_REPO_FRESH
          SET NO_OF_SETTL_MODES=0
          WHERE DEAL_NO=M_DEAL_NO;

          DELETE DN_TRN_BROKERAGE
          WHERE
          DEAL_NO=M_DEAL_NO;

          DELETE DN_TRN_REPO_FRESH_SETTLE
          WHERE
          DEAL_NO=M_DEAL_NO;

          DELETE DN_TRN_REPO_FRESH_SERIAL_NO
          WHERE
          DEAL_NO=M_DEAL_NO;

          DELETE DN_TRN_REPO_FRESH_SEC
          WHERE
          DEAL_NO=M_DEAL_NO;

          DELETE DN_TRN_REPO_FRESH_INST
          WHERE
          DEAL_NO=M_DEAL_NO;

       END IF;
       /*
       IF M_SELECT_TYPE='SUB1' THEN
          DELETE
          FROM DN_TRN_REPO_FRESH_SEC
          WHERE
               DEAL_NO = M_DEAL_NO;

          DELETE
          FROM DN_TRN_BROKERAGE
          WHERE
               DEAL_NO = M_DEAL_NO;

       END IF;

       IF M_SELECT_TYPE='SUB2' THEN
          DELETE
          FROM DN_TRN_REPO_FRESH_SETTLE
          WHERE
               DEAL_NO = M_DEAL_NO;

          DELETE
          FROM DN_TRN_BROKERAGE
          WHERE
               DEAL_NO = M_DEAL_NO;

       END IF;
       */
       COMMIT;

   END IF;
   --If the data type is incorrect then delete the records from the relavent tables

 EXCEPTION
  WHEN OTHERS THEN

    ROLLBACK;

    COMMIT;

    RAISE_APPLICATION_ERROR(-20201,'Cannot delete records, because of related information available in other table.');


END MBFSL_REPOFRESH_DE1;

/
