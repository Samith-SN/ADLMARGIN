--------------------------------------------------------
--  DDL for Procedure DN_ACC_BANK_CHARGE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_ACC_BANK_CHARGE" 
(
M_PORTF_CODE           DN_ACC_LICENCEE_GEN_ACCOUNT.PORTFOLIO_CODE%TYPE,
M_DN_PORTF_CODE        DN_ACC_LICENCEE_GEN_ACCOUNT.DN_PORTFOLIO_CODE%TYPE,
M_TRNAMOUNT            DN_ACC_LICENCEE_GEN_ACCOUNT.TRNAMOUNT%TYPE,
M_ACC_NO               DN_REF_LICENCEE_SETTLEMENT.ACC_NO%TYPE,
M_TRANSACTION_TYPE     DN_TRN_BO_CAP_INVEST.TRANSACTION_TYPE%TYPE,
M_LICENCEE_BRANCH_CODE DN_TRN_BO_CAP_INVEST.LICENCEE_BRANCH_CODE%TYPE,
M_LICENCEE_ACCOUNT_NO  DN_TRN_BO_CAP_INVEST.LICENEE_ACCOUNT_NO%TYPE,
M_DN_USER              DN_TRN_BO_CAP_INVEST.DN_USER%TYPE,
M_PROC_DESC            DN_TRN_BO_BANK_CHARG.PROC_DESC%TYPE,
M_NUMBER        IN OUT VARCHAR,
M_VALDATE              VARCHAR
)
AS

/* PROCEDURE  - RECORD THE BANK CHARGE
   CREATED BY - SUKATHISVARAN
   CREATED ON - 17/MARCH/2000*/

M_DOCREFNO             DN_ACC_LICENCEE_GEN_ACCOUNT.DOCREFNO%TYPE;
M_ACC_SYS_REFNO        DN_ACC_LICENCEE_GEN_ACCOUNT.ACC_SYS_REFNO%TYPE;
BEGIN


DN_VALIDATE_SAVE_RIGHTS(M_DN_USER,'WD_Bank_Charges');  --added by ashini on 31/10/2005 for sr0509-047


    SELECT 'BCMT'||TO_CHAR(SYSDATE,'YY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'
            ||LPAD(TO_CHAR(DN_SEQ_BANK_CHARGE.NEXTVAL),3,'0')
    INTO M_DOCREFNO
    FROM DUAL;

     SELECT
     ACC_SYS_REFNO
     INTO M_ACC_SYS_REFNO
     FROM DN_REF_LICENCEE_SETTLEMENT
     WHERE BRANCH_CODE=M_LICENCEE_BRANCH_CODE
     AND ACC_NO = M_LICENCEE_ACCOUNT_NO
     AND ACTIVE_STATUS ='Y';


    IF (M_TRANSACTION_TYPE='I') THEN
         INSERT INTO DN_ACC_LICENCEE_GEN_ACCOUNT
            (   PORTFOLIO_CODE,
                DN_PORTFOLIO_CODE,
                TRNDATE,
                ACC_TYPE_CODE,
                DRCR_STATUS,
                TRNAMOUNT,
                DOCREFNO,
                ENTDATE,
                ACC_SYS_REFNO,
                PROC_DESC,
                CORR_ACC_No )
                VALUES
                  (   M_PORTF_CODE,
                      M_DN_PORTF_CODE,
                      TO_DATE(M_VALDATE,'DD-MM-YYYY'),
                      '800',
                      'DR',
                      M_TRNAMOUNT,
                      M_DOCREFNO,
                      SYSDATE,
                      M_ACC_SYS_REFNO,
                      'Bank Charges',
                      '190' );

         INSERT INTO DN_ACC_LICENCEE_GEN_ACCOUNT
            (   PORTFOLIO_CODE,
                DN_PORTFOLIO_CODE,
                TRNDATE,
                ACC_TYPE_CODE,
                DRCR_STATUS,
                TRNAMOUNT,
                DOCREFNO,
                ENTDATE,
                ACC_SYS_REFNO,
                PROC_DESC,
                CORR_ACC_No)
                VALUES
                  (   M_PORTF_CODE,
                      M_DN_PORTF_CODE,
                      TO_DATE(M_VALDATE,'DD-MM-YYYY'),
                      '190',
                      'CR',
                      M_TRNAMOUNT,
                      M_DOCREFNO,
                      SYSDATE,
                      M_ACC_SYS_REFNO,
                      'Bank Charges',
                      '800' );
       INSERT INTO DN_TRN_BO_BANK_CHARG
           (  DOCREFNO,
              PORTFOLIO_CODE,
              TRANSACTION_TYPE,
              PROC_DESC,
              LICENCEE_BRANCH_CODE,
              LICENCEE_ACCOUNT_NO,
              TRNAMOUNT,
              DN_USER,
              TRNDATE  )
            VALUES
               (  M_DOCREFNO,
                  M_PORTF_CODE,
                  M_TRANSACTION_TYPE,
                  M_PROC_DESC,
                  M_LICENCEE_BRANCH_CODE,
                  M_LICENCEE_ACCOUNT_NO,
                  M_TRNAMOUNT,
                  M_DN_USER,
                  TO_DATE(M_VALDATE,'DD-MM-YYYY')   );

        M_NUMBER:=M_DOCREFNO;
         INSERT INTO DN_TIME_LOG_SETTLE
          (DOC_REF_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            ( M_NUMBER,
              M_DN_USER,
              SYSDATE,
              'SETTLEMENT BANK CHARGES ');


     ELSIF (M_TRANSACTION_TYPE='O') THEN
         INSERT INTO DN_ACC_LICENCEE_GEN_ACCOUNT
            (   PORTFOLIO_CODE,
                DN_PORTFOLIO_CODE,
                TRNDATE,
                ACC_TYPE_CODE,
                DRCR_STATUS,
                TRNAMOUNT,
                DOCREFNO,
                ENTDATE,
                ACC_SYS_REFNO,
                PROC_DESC,
                CORR_ACC_No)
                VALUES
                  (   M_PORTF_CODE,
                      M_DN_PORTF_CODE,
                      TO_DATE(M_VALDATE,'DD-MM-YYYY'),
                      '191',
                      'DR',
                      M_TRNAMOUNT,
                      M_DOCREFNO,
                      SYSDATE,
                      M_ACC_SYS_REFNO,
                      'Bank Charges',
                      '800' );


         INSERT INTO DN_ACC_LICENCEE_GEN_ACCOUNT
            (   PORTFOLIO_CODE,
                DN_PORTFOLIO_CODE,
                TRNDATE,
                ACC_TYPE_CODE,
                DRCR_STATUS,
                TRNAMOUNT,
                DOCREFNO,
                ENTDATE,
                ACC_SYS_REFNO,
                PROC_DESC,
                CORR_ACC_No )
                VALUES
                  (   M_PORTF_CODE,
                      M_DN_PORTF_CODE,
                      TO_DATE(M_VALDATE,'DD-MM-YYYY'),
                      '800',
                      'CR',
                      M_TRNAMOUNT,
                      M_DOCREFNO,
                      SYSDATE,
                      M_ACC_SYS_REFNO,
                      'Bank Charges',
                      '190' );
       INSERT INTO DN_TRN_BO_BANK_CHARG
           (  DOCREFNO,
              PORTFOLIO_CODE,
              TRANSACTION_TYPE,
              PROC_DESC,
              LICENCEE_BRANCH_CODE,
              LICENCEE_ACCOUNT_NO,
              TRNAMOUNT,
              DN_USER,
              TRNDATE  )
            VALUES
               (  M_DOCREFNO,
                  M_PORTF_CODE,
                  M_TRANSACTION_TYPE,
                  M_PROC_DESC,
                  M_LICENCEE_BRANCH_CODE,
                  M_LICENCEE_ACCOUNT_NO,
                  M_TRNAMOUNT,
                  M_DN_USER,
                  TO_DATE(M_VALDATE,'DD-MM-YYYY')   );
     M_NUMBER:=M_DOCREFNO;
     INSERT INTO DN_TIME_LOG_SETTLE
          (DOC_REF_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            ( M_NUMBER,
               M_DN_USER,
              SYSDATE,
              'SETTLEMENT BANK CHARGES ');


  END IF;

COMMIT;

END DN_ACC_BANK_CHARGE;

/
