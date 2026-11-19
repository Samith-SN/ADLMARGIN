--------------------------------------------------------
--  DDL for Procedure TAX_OPT_REACT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."TAX_OPT_REACT" 

   (M_TAX_CODE      DN_REF_TAX_RATE.RATE_CODE%TYPE,
    M_USER              varchar

   )

AS

BEGIN


DN_VALIDATE_SAVE_RIGHTS(M_USER,'WD_Tax_Rates');  --added by ashini on 31/10/2005 for sr0509-047

    /* PROCEDURE  -  TO REACTIVATE TAX_RATE TABLE
       SYSTEM     -  DEALNET
       CREATED BY -  UPUL
       CREATED ON -  */

UPDATE DN_REF_TAX_RATE SET
       ACTIVE_STATUS='Y'
WHERE  RATE_CODE=M_TAX_CODE AND ACTIVE_STATUS='N';

COMMIT;

END TAX_OPT_REACT;

/
