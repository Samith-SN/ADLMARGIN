--------------------------------------------------------
--  DDL for Procedure MBFSL_BORROLEND_SEC_DE1
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_BORROLEND_SEC_DE1" (
    M_DEAL_NO  IN OUT    DN_TRN_BL_SECURITY.DEAL_NO%TYPE,
    M_SELECT_TYPE        CHAR
    )
AS
    M_USERNAME      DN_TRN_BL_SECURITY.DN_USER%TYPE;
BEGIN

    --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO);

    -- PROCEDURE  -  TO BORROW LEND SECURITY DETAILS
    -- SYSTEM     -  MBFSL SYSTEM
    -- CREATED BY -  V.THILAKESAN.
    -- CREATED ON -  01/09/1999

    IF M_DEAL_NO IS NOT NULL THEN
       IF M_SELECT_TYPE='MAIN' THEN
          UPDATE DN_TRN_BL_SECURITY
          SET NO_OF_SETTL_MODES=0
          WHERE DEAL_NO=M_DEAL_NO;

          DELETE DN_TRN_BROKERAGE
          WHERE
          DEAL_NO=M_DEAL_NO;

          DELETE DN_TRN_BL_SECURITY_SETTLE
          WHERE
          DEAL_NO=M_DEAL_NO;

          DELETE DN_TRN_BL_SECURITY_SERIAL_NO
          WHERE
          DEAL_NO=M_DEAL_NO;

          DELETE DN_TRN_BL_SECURITY_SEC
          WHERE
          DEAL_NO=M_DEAL_NO;

          DELETE DN_TRN_BL_SECURITY_INST
          WHERE
          DEAL_NO=M_DEAL_NO;

          --ADDED FOR TIME LOG MANAGEMENT BY S.YASODHA
          SELECT DN_USER  INTO M_USERNAME FROM  DN_TRN_BL_SECURITY
          WHERE DEAL_NO=M_DEAL_NO;
          INSERT INTO DN_TIME_LOG
           (SUS_REF_NO,
            DN_USER,
            ENT_DATE,
            DESCRIPTION)
          VALUES
            (
             M_DEAL_NO,
             M_USERNAME,
             SYSDATE,
             'MODIFICATION '
             );
          COMMIT;

       END IF;

   END IF;
   --If the data type is incorrect then delete the records from the relavent tables

 EXCEPTION
  WHEN OTHERS THEN

    ROLLBACK;

    COMMIT;

    RAISE_APPLICATION_ERROR(-20201,'Cannot delete records, because of related information available in other table.');


END MBFSL_BORROLEND_SEC_DE1;

/
