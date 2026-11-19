--------------------------------------------------------
--  DDL for Procedure INTEREST_BASE_NEW
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."INTEREST_BASE_NEW" 

   (M_INT_RATE_BASE_CODE    DN_REF_INTR_BASE.INT_RATE_BASE_CODE%TYPE,
    M_INTR_BASE_DESC        DN_REF_INTR_BASE.INTR_BASE_DESC%TYPE,
    M_DENOMINATOR           DN_REF_INTR_BASE.DENOMINATOR%TYPE,
    M_USER                  VARCHAR

   )

AS

BEGIN


   DN_VALIDATE_SAVE_RIGHTS(M_USER,'WD_Interest_Rate_Basis');  --added by ashini on 31/10/2005 for sr0509-047

    /* PROCEDURE  - TO SAVE INTEREST BASES
       SYSTEM     -  DEALNET
       CREATED BY -
       CREATED ON -  */


       INSERT INTO DN_REF_INTR_BASE
            (INT_RATE_BASE_CODE,INTR_BASE_DESC,DN_NUMERATOR,DENOMINATOR,ACTIVE_STATUS)
       VALUES
            (M_INT_RATE_BASE_CODE,M_INTR_BASE_DESC,'Act',M_DENOMINATOR,'Y');

COMMIT;

END INTEREST_BASE_NEW;

/
