--------------------------------------------------------
--  DDL for Procedure DN_ACC_JOURNAL_ENTRIES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_ACC_JOURNAL_ENTRIES" 
(
  M_DAY                      VARCHAR,--DAY
  M_MONTH                    VARCHAR,--MONTH
  M_YEAR                     VARCHAR,--YEAR
  M_DRCR                     DN_ACC_LICENCEE_GEN_ACCOUNT.DRCR_STATUS%TYPE,--CR/DR
  M_PORTCODE                 DN_ACC_LICENCEE_GEN_ACCOUNT.PORTFOLIO_CODE%TYPE,--PORTF CODE
  M_DNPORTCODE               VARCHAR,--DN PORT CODE/INS TYPE
  M_ACCNO                    DN_ACC_LICENCEE_GEN_ACCOUNT.ACC_TYPE_CODE%TYPE,--ACC TYPE CODE
  M_AMOUNT                   DN_ACC_LICENCEE_GEN_ACCOUNT.TRNAMOUNT%TYPE,--TRANS AMOUNT
  M_DEALNO                   DN_ACC_LICENCEE_GEN_ACCOUNT.DOCREFNO%TYPE,--DEAL NO
  M_CRACCNO                  DN_ACC_LICENCEE_GEN_ACCOUNT.CORR_ACC_NO%TYPE,--COR. ACC NO
  M_TABLENAME                VARCHAR,--TABLE FOR SAVE
  M_OPTION                   NUMBER,--OPTION NO
  M_USERNAME                 DN_TIME_LOG.DN_USER%TYPE,--SCREEN USER NAME
  M_ACSYSREF                 DN_ACC_LICENCEE_GEN_ACCOUNT.ACC_SYS_REFNO%TYPE--FOR THE ACC_SYS_REF_NO ADDED BY NILU ON 09.06.04 FOR VC 04/168
)
AS

M_SYSDATE  DN_ACC_LICENCEE_GEN_ACCOUNT.ENTDATE%TYPE;--SYSTEM DATE
M_VALDATE  DN_ACC_LICENCEE_GEN_ACCOUNT.TRNDATE%TYPE;--TRANS. DATE


BEGIN

SELECT TO_DATE(M_DAY||'-'||M_MONTH||'-'||M_YEAR,'DD-MM-YYYY') INTO M_VALDATE FROM DUAL;

SELECT TO_DATE(sysdate,'DD-MM-YYYY') INTO M_SYSDATE FROM DUAL;


    /*CREATE RECORDS*/
    IF M_OPTION=1 THEN

        --INSERT DATA TO DN_ACC_LICENCEE_GEN_ACCOUNT
        IF(M_TABLENAME='LG') THEN
            INSERT INTO DN_ACC_LICENCEE_GEN_ACCOUNT (
                        PORTFOLIO_CODE,
                        DN_PORTFOLIO_CODE,
                        TRNDATE,
                        ACC_TYPE_CODE,
                        DRCR_STATUS,
                        TRNAMOUNT,
                        DOCREFNO,
                        ENTDATE,
                        ACC_SYS_REFNO,
                        PROC_DESC,
                        CORR_ACC_NO)
             VALUES(
                        M_PORTCODE,
                        M_DNPORTCODE,
                        M_VALDATE,
                        M_ACCNO,
                        M_DRCR,
                        M_AMOUNT,
                        M_DEALNO,
                        M_SYSDATE,
                        M_ACSYSREF,--ADDED BY NILU FOR THE ACC SYS REF NO VC 04/168 ON 14.06.04
                        'DEAL JOURNAL ENTRIES',
                        M_CRACCNO );

           ELSIF(M_TABLENAME='LI') THEN
                  INSERT INTO DN_ACC_LICENCEE_INST_ACCOUNT
                    (
                        PORTFOLIO_CODE,
                        INST_TYPE,
                        TRNDATE,
                        ACC_TYPE_CODE,
                        DRCR_STATUS,
                        TRNAMOUNT,
                        DOCREFNO,
                        ENTDATE,
                        PROC_DESC,
                        CORR_ACC_NO
                     )
                     VALUES
                     (
                        M_PORTCODE,
                        M_DNPORTCODE,
                        M_VALDATE,
                        M_ACCNO,
                        M_DRCR,
                        M_AMOUNT,
                        M_DEALNO,
                        M_SYSDATE,
                        'DEAL JOURNAL ENTRIES',
                        M_CRACCNO
                     );

           ELSIF(M_TABLENAME='PG') THEN
                INSERT INTO DN_ACC_PORTF_GEN_ACCOUNT
                    (
                        PORTFOLIO_CODE,
                        DN_PORTFOLIO_CODE,
                        TRNDATE,
                        ACC_TYPE_CODE,
                        DRCR_STATUS,
                        TRNAMOUNT,
                        DOCREFNO,
                        ENTDATE,
                        PROC_DESC,
                        CORR_ACC_NO
                     )
                     VALUES
                     (
                        M_PORTCODE,
                        M_DNPORTCODE,
                        M_VALDATE,
                        M_ACCNO,
                        M_DRCR,
                        M_AMOUNT,
                        M_DEALNO,
                        M_SYSDATE,
                        'DEAL JOURNAL ENTRIES',
                        M_CRACCNO
                     );
           ELSIF(M_TABLENAME='PI') THEN
                INSERT INTO DN_ACC_PORTF_INST_ACCOUNT
                     (
                        PORTFOLIO_CODE,
                        INST_TYPE,
                        TRNDATE,
                        ACC_TYPE_CODE,
                        DRCR_STATUS,
                        TRNAMOUNT,
                        DOCREFNO,
                        ENTDATE,
                        PROC_DESC,
                        CORR_ACC_NO
                      )
                      VALUES
                      (
                        M_PORTCODE,
                        M_DNPORTCODE,
                        M_VALDATE,
                        M_ACCNO,
                        M_DRCR,
                        M_AMOUNT,
                        M_DEALNO,
                        M_SYSDATE,
                        'DEAL JOURNAL ENTRIES',
                        M_CRACCNO
                       );
           END IF;

       --ADD DN_TIME_LOG ENTRY
       ELSIF M_OPTION=4 THEN
                 INSERT INTO DN_TIME_LOG
                 (
                    SUS_REF_NO,
                    DN_USER,
                    ENT_DATE,
                    DESCRIPTION
                 )
                 VALUES
                 (
                    M_DEALNO,
                    M_USERNAME,
                    M_SYSDATE,
                    'JOURNAL ENTRY'
                  );
       END IF;

COMMIT;

END;

/
