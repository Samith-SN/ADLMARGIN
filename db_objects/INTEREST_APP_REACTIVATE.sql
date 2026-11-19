--------------------------------------------------------
--  DDL for Procedure INTEREST_APP_REACTIVATE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."INTEREST_APP_REACTIVATE" 
   (M_INT_RATE_BASE_CODE    DN_REF_INTR_BASE.INT_RATE_BASE_CODE%TYPE,
    M_USER                  VARCHAR


   )

AS

BEGIN


   DN_VALIDATE_SAVE_RIGHTS(M_USER,'WD_Interest_Rate_Basis');  --added by ashini on 31/10/2005 for sr0509-047

    /* PROCEDURE  - TO DE RE-ACTIVATE BASE
       SYSTEM     -  DEALNET
       CREATED BY -
       CREATED ON -  */

       UPDATE DN_REF_INTR_BASE SET
                ACTIVE_STATUS='Y'
       WHERE UPPER(INT_RATE_BASE_CODE)=UPPER(M_INT_RATE_BASE_CODE);

       COMMIT;

END INTEREST_APP_REACTIVATE;

/
