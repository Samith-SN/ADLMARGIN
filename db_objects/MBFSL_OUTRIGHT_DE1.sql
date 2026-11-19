--------------------------------------------------------
--  DDL for Procedure MBFSL_OUTRIGHT_DE1
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_OUTRIGHT_DE1" (
    M_DEAL_NO  IN OUT    DN_TRN_OUTP_SALE.DEAL_NO%TYPE,
    M_SELECT_TYPE        CHAR,
    M_USER               VARCHAR,
    M_SCREEN             VARCHAR
    )
AS
BEGIN

DN_VALIDATE_SAVE_RIGHTS(M_USER,M_SCREEN);  --added by ashini on 31/10/2005 for sr0509-047

    --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO);

    -- PROCEDURE  -  TO DELETE OUTRIGHT DETAILS
    -- SYSTEM     -  MBFSL SYSTEM
    -- CREATED BY -  V.THILAKESAN.
    -- CREATED ON -  13/08/1999

    IF M_DEAL_NO IS NOT NULL THEN

       IF M_SELECT_TYPE='SUB1' THEN

          UPDATE DN_TRN_OUTP_SALE
          SET NO_OF_SETTL_MODES=0
          WHERE DEAL_NO=M_DEAL_NO;

          DELETE
          FROM DN_TRN_BROKERAGE
          WHERE
               DEAL_NO = M_DEAL_NO;

          DELETE
          FROM DN_TRN_OUTP_SALE_SETTLE
          WHERE
               DEAL_NO = M_DEAL_NO;

          DELETE
          FROM DN_TRN_OUTP_SALE_SEC
          WHERE
               DEAL_NO = M_DEAL_NO;

       END IF;
       /*
       IF M_SELECT_TYPE='SUB2' THEN
          DELETE
          FROM DN_TRN_OUTP_SALE_SETTLE
          WHERE
               DEAL_NO = M_DEAL_NO;
       END IF;

       DELETE
       FROM DN_TRN_BROKERAGE
       WHERE
            DEAL_NO = M_DEAL_NO;
       */
       COMMIT;

   END IF;
   --If the data type is incorrect then delete the records from the relavent tables

 EXCEPTION
  WHEN OTHERS THEN

    ROLLBACK;

    COMMIT;

    RAISE_APPLICATION_ERROR(-20201,'Cannot delete records, because of related information available in other table.');


END MBFSL_OUTRIGHT_DE1;

/
