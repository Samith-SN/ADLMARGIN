--------------------------------------------------------
--  DDL for Procedure MBFSL_TRN_SETTLEMENT_CHEQUES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_TRN_SETTLEMENT_CHEQUES" 
   (M_CHEQUE_PAY_NO    IN OUT   DN_TRN_BO_SETTL_CHQ_PAYMENT.CHQ_PAY_NO%TYPE,
    M_AMOUNT                    DN_TRN_BO_SETTL_CHQ_PAYMENT.CHQ_AMOUNT%TYPE,
    M_ACC_NO                    DN_TRN_BO_SETTL_CHQ_PAYMENT.ACC_NO%TYPE,
    M_BRANCH_CODE               DN_TRN_BO_SETTL_CHQ_PAYMENT.BRANCH_CODE%TYPE,
    M_PAYMENT_NO                DN_TRN_BO_SETTL_CHQ_PAYMENT.PAYMENT_NO%TYPE,
    M_PORTFOLIO_CODE            DN_TRN_BO_SETTL_CHQ_PAYMENT.PORTFOLIO_CODE%TYPE,
    M_SUS_REFNO                 DN_TRN_BO_SETTL_CHQ_PAYMENT.SUS_REF_NO%TYPE,
    M_SETTLE_MODE               DN_TRN_BO_SETTL_CHQ_PAYMENT.SETTLE_MODE%TYPE,
    M_CHEQUE_NO                 DN_TRN_BO_SETTL_CHQ_PAYMENT.CHQ_NO%TYPE,
    M_PAY_REF                   DN_TRN_BO_SETTL_CHQ_PAYMENT.PAY_REF_NO%TYPE,
    M_USER                      DN_TRN_BO_SETTL_CHQ_PAYMENT.DN_USER%TYPE,
    M_DUMMY_NO                  DN_TRN_BO_SETTL_CHQ_PAYMENT.CHQ_PAY_NO%TYPE

   )
AS

BEGIN

DN_VALIDATE_SAVE_RIGHTS(M_USER,'WD_Cheques');  --added by ashini on 31/10/2005 for sr0509-047

    /* PROCEDURE  -  SETTLEMENT CHEQUES
       SYSTEM     -  DEALNT
       CREATED BY -  DAYAN.
       CREATED ON -  14/07/1999 */
--RAISE_APPLICATION_ERROR(-20201,M_CHEQUE_PAY_NO||' '||M_AMOUNT||' '||M_ACC_NO||' '||M_BRANCH_CODE||' '||M_PAYMENT_NO ||' '|| M_PORTFOLIO_CODE||' '||M_SUS_REFNO||' '||M_SETTLE_MODE||' '|| M_CHEQUE_NO||' '||M_PAY_REF||' '||M_USER);
---------------------------MODIFIED BY RUWAN LIYANAGE ON 28-08-2001 START     ---------------
    IF M_DUMMY_NO IS  NULL THEN
       SELECT TO_CHAR(SYSDATE,'YY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_SET_CHQ_PAY.NEXTVAL),3,'0') INTO M_CHEQUE_PAY_NO FROM DUAL;
       M_CHEQUE_PAY_NO:='SCMT'||M_CHEQUE_PAY_NO;
    ELSE
       M_CHEQUE_PAY_NO:=M_DUMMY_NO;
   END IF;
----------------------------------------------------END--------------------------------------
    INSERT INTO DN_TRN_BO_SETTL_CHQ_PAYMENT
             (CHQ_PAY_NO,
              PAYMENT_NO,
              PORTFOLIO_CODE,
              SUS_REF_NO,
              SETTLE_MODE,
              BRANCH_CODE,
              ACC_NO,
              CHQ_NO,
              CHQ_AMOUNT,
              PAY_REF_NO,
              DN_USER,
              ENTDATE)
   VALUES
       (M_CHEQUE_PAY_NO,
        M_PAYMENT_NO,
        M_PORTFOLIO_CODE,
        M_SUS_REFNO,
        M_SETTLE_MODE,
        M_BRANCH_CODE,
        M_ACC_NO,
        M_CHEQUE_NO,
        M_AMOUNT,
        M_PAY_REF,
        M_USER ,
        SYSDATE  );


   UPDATE DN_TRN_BO_SETTL_PAYMENT
    SET
        PROCESS_STATUS='Y'
    WHERE
        PAYMENT_NO=M_PAYMENT_NO AND
        PORTFOLIO_CODE= M_PORTFOLIO_CODE AND
        SUS_REF_NO=M_SUS_REFNO AND
        SETTLE_MODE=M_SETTLE_MODE;
        -- ADDED FOR TIME LOG MANAGEMENT BY YASODHA ON 10-09-2000
        INSERT INTO DN_TIME_LOG_SETTLE
          (DOC_REF_NO,
           REL_DEAL_NO,
           REL_SETTL_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            ( M_CHEQUE_PAY_NO,
              M_SUS_REFNO,
              M_PAYMENT_NO ,
              M_USER,
              SYSDATE,
              'SETTLEMENT CHEQUE'
           );

     COMMIT;

    END MBFSL_TRN_SETTLEMENT_CHEQUES;

/
