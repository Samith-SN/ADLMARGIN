--------------------------------------------------------
--  DDL for Procedure DN_ACC_PORTF_FEES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_ACC_PORTF_FEES" 
(
M_PORTF_CODE           DN_ACC_LICENCEE_GEN_ACCOUNT.PORTFOLIO_CODE%TYPE,
M_DN_PORTF_CODE        DN_ACC_LICENCEE_GEN_ACCOUNT.DN_PORTFOLIO_CODE%TYPE,
M_TRNAMOUNT            DN_ACC_LICENCEE_GEN_ACCOUNT.TRNAMOUNT%TYPE,
M_DN_USER              DN_TRN_BO_CAP_INVEST.DN_USER%TYPE,
M_PROC_DESC            DN_TRN_BO_PORTFOLIO_FEES.PROC_DESC%TYPE,
M_NUMBER        IN OUT VARCHAR,
M_VALDATE              VARCHAR
)
AS



M_DOCREFNO             DN_ACC_LICENCEE_GEN_ACCOUNT.DOCREFNO%TYPE;

BEGIN



DN_VALIDATE_SAVE_RIGHTS(M_DN_USER,'WD_Portf_Fees');  --added by ashini on 31/10/2005 for sr0509-047


    SELECT 'PFMT'||TO_CHAR(SYSDATE,'YY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'
            ||LPAD(TO_CHAR(DN_SEQ_PORTF_FEES.NEXTVAL),3,'0')
    INTO M_DOCREFNO
    FROM DUAL;


  INSERT INTO DN_ACC_LICENCEE_GEN_ACCOUNT
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
                  (   'GEN',
                      M_DN_PORTF_CODE,
                      TO_DATE(M_VALDATE,'DD-MM-YYYY'),
                      '111',
                      'CR',
                      M_TRNAMOUNT,
                      M_DOCREFNO,
                      SYSDATE,
                     'PORTFOLIO FEES',
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
                PROC_DESC,
                CORR_ACC_No)
                VALUES
                  (   'GEN',
                      M_DN_PORTF_CODE,
                      TO_DATE(M_VALDATE,'DD-MM-YYYY'),
                      '301',
                      'DR',
                      M_TRNAMOUNT,
                      M_DOCREFNO,
                      SYSDATE,
                      'PORTFOLIO FEES',
                      '111' );

           --PORTFOLIO GEN--
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
                      '110',
                      'DR',
                      M_TRNAMOUNT,
                      M_DOCREFNO,
                      SYSDATE,
                      'PORTFOLIO FEES',
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
                      'CR',
                      M_TRNAMOUNT,
                      M_DOCREFNO,
                      SYSDATE,
                      'PORTFOLIO FEES',
                      '110' );
       INSERT INTO DN_TRN_BO_PORTFOLIO_FEES
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
         INSERT INTO DN_TIME_LOG_SETTLE
          (DOC_REF_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            ( M_NUMBER,
              M_DN_USER,
              SYSDATE,
              'SETTLEMENT PORTFOLIO FEES ');



COMMIT;

END DN_ACC_PORTF_FEES;

/
