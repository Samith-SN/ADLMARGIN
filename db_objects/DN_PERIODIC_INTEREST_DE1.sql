--------------------------------------------------------
--  DDL for Procedure DN_PERIODIC_INTEREST_DE1
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_PERIODIC_INTEREST_DE1" (
    M_DEAL_NO  IN OUT    DN_TRN_REPO_PERIOD_INT.DEAL_NO%TYPE,
    M_SELECT_TYPE        CHAR
    )
AS

BEGIN

    --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO);

    -- PROCEDURE  -  TO DELETE REPO PERIODIC INTEREST DETAILS
    -- SYSTEM     -  MBFSL SYSTEM
    -- CREATED BY -  V.THILAKESAN.
    -- CREATED ON -  14/04/2000

    IF M_DEAL_NO IS NOT NULL THEN
       IF M_SELECT_TYPE='MAIN' THEN
          UPDATE DN_TRN_REPO_PERIOD_INT
          SET NO_OF_SETTL_MODES=0
          WHERE DEAL_NO=M_DEAL_NO;

          DELETE DN_TRN_BROKERAGE
          WHERE
          DEAL_NO=M_DEAL_NO;

          DELETE DN_TRN_REPO_PERIOD_INT_SETTLE
          WHERE
          DEAL_NO=M_DEAL_NO;

          DELETE DN_TRN_REPO_PERIOD_INT_SERIAL
          WHERE
          DEAL_NO=M_DEAL_NO;

          DELETE DN_TRN_REPO_PERIOD_INT_SEC
          WHERE
          DEAL_NO=M_DEAL_NO;

          DELETE DN_TRN_REPO_PERIOD_INT_INST
          WHERE
          DEAL_NO=M_DEAL_NO;

       END IF;
       COMMIT;

   END IF;
   --If the data type is incorrect then delete the records from the relavent tables

 EXCEPTION
  WHEN OTHERS THEN

    ROLLBACK;

    COMMIT;

    RAISE_APPLICATION_ERROR(-20201,'Cannot delete records, because of related information available in other table.');


END DN_PERIODIC_INTEREST_DE1;

/
