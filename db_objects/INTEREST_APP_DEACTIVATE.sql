--------------------------------------------------------
--  DDL for Procedure INTEREST_APP_DEACTIVATE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."INTEREST_APP_DEACTIVATE" 
   (M_INT_RATE_BASE_CODE    DN_REF_INTR_BASE.INT_RATE_BASE_CODE%TYPE,
    M_USER                  VARCHAR


   )

AS

BEGIN

   DN_VALIDATE_SAVE_RIGHTS(M_USER,'WD_Interest_Rate_Basis');  --added by ashini on 31/10/2005 for sr0509-047


    /* PROCEDURE  - TO DE ACTIVATE BASE
       SYSTEM     -  DEALNET
       CREATED BY -
       CREATED ON -  */

       UPDATE DN_REF_INTR_BASE SET
                ACTIVE_STATUS='N'
       WHERE UPPER(INT_RATE_BASE_CODE)=UPPER(M_INT_RATE_BASE_CODE);


       UPDATE DN_REF_INTRB_APP_ACT SET
                DEFAULT_STATUS='N',
                APPLICABLE_STATUS='N'
       WHERE UPPER(INT_RATE_BASE_CODE)=UPPER(M_INT_RATE_BASE_CODE);

       UPDATE DN_REF_INTR_BASE_OUTR_POS_INST SET
                DEFAULT_STATUS='N',
                APPLICABLE_STATUS='N'
       WHERE UPPER(INT_RATE_BASE_CODE)=UPPER(M_INT_RATE_BASE_CODE);


       COMMIT;

END INTEREST_APP_DEACTIVATE;

/
