--------------------------------------------------------
--  DDL for Procedure INSTRUMENT_OPT_DEACT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."INSTRUMENT_OPT_DEACT" 


   (M_INS_CODE    DN_REF_INSTRUMENT.INST_TYPE%TYPE,
    M_USRE                  VARCHAR

   )

AS

BEGIN

DN_VALIDATE_SAVE_RIGHTS(M_USRE,'WD_Instrument_Types_MT');  --added by ashini on 31/10/2005 for sr0509-047


    /* PROCEDURE  - TO MODIFY INSTRUMENT OPTIONS
       SYSTEM     -  DEALNET
       CREATED BY -
       CREATED ON -  */

UPDATE DN_REF_INSTRUMENT SET
       ACTIVE_STATUS='N'
WHERE  UPPER(INST_TYPE)=UPPER(M_INS_CODE);

COMMIT;

END INSTRUMENT_OPT_DEACT;

/
