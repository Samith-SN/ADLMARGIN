--------------------------------------------------------
--  DDL for Procedure CURRENCIES_OPT_DEACT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."CURRENCIES_OPT_DEACT" 

   (M_CURR_CODE      DN_REF_CURRENCY.CURR_CODE%TYPE
   )

AS

BEGIN

    /* PROCEDURE  -  TO MODIFY CURRENCIES TABLE
       SYSTEM     -  DEALNET
       CREATED BY -  UPUL
       CREATED ON -  */

UPDATE DN_REF_CURRENCY SET
       ACTIVE_STATUS='N'
WHERE  CURR_CODE=M_CURR_CODE AND DEFAULT_STATUS<>'Y';

COMMIT;

END CURRENCIES_OPT_DEACT;

/
