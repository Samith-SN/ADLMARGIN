--------------------------------------------------------
--  DDL for Procedure MBFSL_REPOROLLOVER_DE1
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_REPOROLLOVER_DE1" (
    M_DEAL_NO  IN OUT    DN_TRN_REPO_ROLLOVER.DEAL_NO%TYPE,
    M_SELECT_TYPE        CHAR
    )
AS

BEGIN

    --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO);

    -- PROCEDURE  -  TO DELETE REPO ROLLOVER DETAILS
    -- SYSTEM     -  MBFSL SYSTEM
    -- CREATED BY -  V.THILAKESAN.
    -- CREATED ON -  19/08/1999

    IF M_DEAL_NO IS NOT NULL THEN

       IF M_SELECT_TYPE='MAIN' THEN
          UPDATE DN_TRN_REPO_ROLLOVER
          SET NO_OF_SETTL_MODES=0
          WHERE DEAL_NO=M_DEAL_NO;

          DELETE DN_TRN_BROKERAGE
          WHERE
          DEAL_NO=M_DEAL_NO;

          DELETE DN_TRN_REPO_ROLLOVER_SETTLE
          WHERE
          DEAL_NO=M_DEAL_NO;

          DELETE DN_TRN_REPO_ROLLOVER_SERIAL_NO
          WHERE
          DEAL_NO=M_DEAL_NO;

          DELETE DN_TRN_REPO_ROLLOVER_SEC
          WHERE
          DEAL_NO=M_DEAL_NO;

          DELETE DN_TRN_REPO_ROLLOVER_INST
          WHERE
          DEAL_NO=M_DEAL_NO;


       END IF;
       /*
       IF M_SELECT_TYPE='SUB1' THEN
          DELETE
          FROM DN_TRN_REPO_ROLLOVER_SEC
          WHERE
               DEAL_NO = M_DEAL_NO;

          DELETE
          FROM DN_TRN_BROKERAGE
          WHERE
               DEAL_NO = M_DEAL_NO;

       END IF;

       IF M_SELECT_TYPE='SUB2' THEN
          DELETE
          FROM DN_TRN_REPO_ROLLOVER_SETTLE
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


END MBFSL_REPOROLLOVER_DE1;

/
