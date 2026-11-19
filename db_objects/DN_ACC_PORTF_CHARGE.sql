--------------------------------------------------------
--  DDL for Procedure DN_ACC_PORTF_CHARGE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_ACC_PORTF_CHARGE" 
(
M_PORTF_CODE           DN_ACC_LICENCEE_GEN_ACCOUNT.PORTFOLIO_CODE%TYPE,
M_DN_PORTF_CODE        DN_ACC_LICENCEE_GEN_ACCOUNT.DN_PORTFOLIO_CODE%TYPE,
M_TRNAMOUNT            DN_ACC_LICENCEE_GEN_ACCOUNT.TRNAMOUNT%TYPE,
M_DN_USER              DN_TRN_BO_CAP_INVEST.DN_USER%TYPE,
M_PROC_DESC            DN_TRN_BO_PORTF_CHARG.PROC_DESC%TYPE,
M_NUMBER        IN OUT VARCHAR,
M_VALDATE              VARCHAR
)
AS



M_DOCREFNO             DN_ACC_LICENCEE_GEN_ACCOUNT.DOCREFNO%TYPE;
M_ACC_SYS_REFNO        DN_ACC_LICENCEE_GEN_ACCOUNT.ACC_SYS_REFNO%TYPE;
BEGIN


DN_VALIDATE_SAVE_RIGHTS(M_DN_USER,'WD_Portf_Charges');  --added by ashini on 31/10/2005 for sr0509-047


    SELECT 'IRMT'||TO_CHAR(SYSDATE,'YY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'--PCMT
            ||LPAD(TO_CHAR(DN_SEQ_PORTF_CHARGE.NEXTVAL),3,'0')
    INTO M_DOCREFNO
    FROM DUAL;

--LICENCEE GEN ACCOUNT--
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
                  (   'GEN',
                      M_DN_PORTF_CODE,
                      TO_DATE(M_VALDATE,'DD-MM-YYYY'),
                      '113',--118 -->113 BY WARUNA 2011-06-20
                      'DR',--'CR' CHANGED ON 22/06/2011 SM/WJ
                      M_TRNAMOUNT,
                      M_DOCREFNO,
                      SYSDATE,
                      M_ACC_SYS_REFNO,
                      'INTEREST REFUND',--PORTFOLIO EXPENSES
                      '301' );

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
                  (   'GEN',
                      M_DN_PORTF_CODE,
                      TO_DATE(M_VALDATE,'DD-MM-YYYY'),
                      '301',
                      'CR',--'DR' CHANGED ON 22/06/2011 SM/WJ
                      M_TRNAMOUNT,
                      M_DOCREFNO,
                      SYSDATE,
                      M_ACC_SYS_REFNO,
                      'INTEREST REFUND',--'PORTFOLIO EXPENSES',
                      '113' ); -->113 BY WARUNA 2011-06-20

--PORTFOLIO GEN ACCOUNT--

    INSERT INTO DN_ACC_PORTF_GEN_ACCOUNT
            (   PORTFOLIO_CODE,
                DN_PORTFOLIO_CODE,
                TRNDATE,
                ACC_TYPE_CODE,
                DRCR_STATUS,
                TRNAMOUNT,
                DOCREFNO,
                ENTDATE,
                PROC_DESC,
                CORR_ACC_No )
                VALUES
                  (   M_PORTF_CODE,
                      M_DN_PORTF_CODE,
                      TO_DATE(M_VALDATE,'DD-MM-YYYY'),
                      '117',
                      'CR',--'DR' CHANGED ON 22/06/2011 SM/WJ
                      M_TRNAMOUNT,
                      M_DOCREFNO,
                      SYSDATE,
                      'INTEREST REFUND',--'PORTFOLIO EXPENSES',
                      '350' );

         INSERT INTO DN_ACC_PORTF_GEN_ACCOUNT
            (   PORTFOLIO_CODE,
                DN_PORTFOLIO_CODE,
                TRNDATE,
                ACC_TYPE_CODE,
                DRCR_STATUS,
                TRNAMOUNT,
                DOCREFNO,
                ENTDATE,
                PROC_DESC,
                CORR_ACC_No)
                VALUES
                  (   M_PORTF_CODE,
                      M_DN_PORTF_CODE,
                      TO_DATE(M_VALDATE,'DD-MM-YYYY'),
                      '350',
                      'DR', --'CR' CHANGED ON 22/06/2011 SM/WJ
                      M_TRNAMOUNT,
                      M_DOCREFNO,
                      SYSDATE,
                      'INTEREST REFUND',--'PORTFOLIO EXPENSES',
                      '117' );

-- TRN TABLE---
       INSERT INTO DN_TRN_BO_PORTF_CHARG
           (  DOCREFNO,
              PORTFOLIO_CODE,
              PROC_DESC,
              TRNAMOUNT,
              DN_USER,
              TRNDATE  )
            VALUES
               (  M_DOCREFNO,
                  M_PORTF_CODE,
                  M_PROC_DESC,
                  M_TRNAMOUNT,
                  M_DN_USER,
                  TO_DATE(M_VALDATE,'DD-MM-YYYY')   );

        M_NUMBER:=M_DOCREFNO;

 --TIME LOG---
         INSERT INTO DN_TIME_LOG_SETTLE
          (DOC_REF_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            ( M_NUMBER,
              M_DN_USER,
              SYSDATE,
              'SETTLEMENT INTEREST REFUND ');--SETTLEMENT PORTFOLIO CHARGES 


COMMIT;

END DN_ACC_PORTF_CHARGE;

/
