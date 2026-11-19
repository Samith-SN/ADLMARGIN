--------------------------------------------------------
--  DDL for Procedure CURRENCIES_OPT_REACT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."CURRENCIES_OPT_REACT" 

   (M_CURR_CODE      DN_REF_CURRENCY.CURR_CODE%TYPE
   )

AS

BEGIN

    /* PROCEDURE  -  TO MODIFY CURRENCIES TABLE
       SYSTEM     -  DEALNET
       CREATED BY -  UPUL
       CREATED ON -  */

UPDATE DN_REF_CURRENCY SET
       ACTIVE_STATUS='Y'
WHERE  CURR_CODE=M_CURR_CODE;

COMMIT;

END CURRENCIES_OPT_REACT;

/
