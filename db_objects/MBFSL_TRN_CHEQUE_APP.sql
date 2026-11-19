--------------------------------------------------------
--  DDL for Procedure MBFSL_TRN_CHEQUE_APP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_TRN_CHEQUE_APP" 
   (
    M_PAYMENT_NO                DN_TRN_BO_SETTL_PAYMENT.PAYMENT_NO%TYPE,
    M_SUS_REFNO                 DN_TRN_BO_SETTL_PAYMENT.SUS_REF_NO%TYPE,
    M_SETTLE_MODE               DN_TRN_BO_SETTL_PAYMENT.SETTLE_MODE%TYPE,
    M_PAY_NAME                  DN_TRN_BO_SETTL_PAYMENT.PAYEE_NAME%TYPE,
    M_USER                      VARCHAR
   )
AS

BEGIN


DN_VALIDATE_SAVE_RIGHTS(M_USER,'WD_Cheque_App');  --added by ashini on 31/10/2005 for sr0509-047

    /* PROCEDURE  -  SETTLEMENT CHEQUES
       SYSTEM     -  DEALNT
       CREATED BY -  S.V.A.
       CREATED ON -  06-04-2001 */
--RAISE_APPLICATION_ERROR(-20201,M_CHEQUE_PAY_NO||' '||M_AMOUNT||' '||M_ACC_NO||' '||M_BRANCH_CODE||' '||M_PAYMENT_NO ||' '|| M_PORTFOLIO_CODE||' '||M_SUS_REFNO||' '||M_SETTLE_MODE||' '|| M_CHEQUE_NO||' '||M_PAY_REF||' '||M_USER);

   UPDATE DN_TRN_BO_SETTL_PAYMENT
    SET
        PROCESS_STATUS = 'A',
        PAYEE_NAME     = M_PAY_NAME
    WHERE
        PAYMENT_NO=M_PAYMENT_NO AND
        SUS_REF_NO=M_SUS_REFNO AND
        SETTLE_MODE=M_SETTLE_MODE;



     COMMIT;
END MBFSL_TRN_CHEQUE_APP;

/
