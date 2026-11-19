--------------------------------------------------------
--  DDL for Procedure DN_ACC_CAPITAL_DEPOSIT_TEMP_2
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_ACC_CAPITAL_DEPOSIT_TEMP_2" 
(
M_PORTF_CODE           DN_ACC_LICENCEE_GEN_ACCOUNT.PORTFOLIO_CODE%TYPE,
M_DN_PORTF_CODE        DN_ACC_LICENCEE_GEN_ACCOUNT.DN_PORTFOLIO_CODE%TYPE,
M_TRNAMOUNT            DN_ACC_LICENCEE_GEN_ACCOUNT.TRNAMOUNT%TYPE,
M_ACC_NO               DN_REF_LICENCEE_SETTLEMENT.ACC_NO%TYPE,
M_LICENCEE_BRANCH_CODE DN_TRN_BO_CAP_INVEST.LICENCEE_BRANCH_CODE%TYPE,
M_LICENCEE_ACCOUNT_NO  DN_TRN_BO_CAP_INVEST.LICENEE_ACCOUNT_NO%TYPE,
M_DN_USER              DN_TRN_BO_CAP_INVEST.DN_USER%TYPE,
M_PROC_DESC            DN_TRN_BO_CAP_INVEST.PROC_DESC%TYPE,
M_EFF_DATE             VARCHAR2,
M_NUMBER        IN OUT VARCHAR,
M_PAYEE_BANK           VARCHAR2,
M_CHEQUE_NO            VARCHAR2,
SCR_NAME               VARCHAR2,
MM_DOCREFNO            DN_TRN_BO_CAP_INVEST.DOCREFNO%TYPE,
--ADD BY WARUNA 2011-10-04-----
M_TRN_TYPE             DN_TRN_BO_CAP_DEPOSIT_TEMP.TRN_TYPE%TYPE,
M_TRN_MODE             DN_TRN_BO_CAP_DEPOSIT_TEMP.TRN_MODE%TYPE,
M_BANK_DATE            VARCHAR2
--END ADD BY WARUNA 2011-10-04-----
)
AS


M_DOCREFNO             DN_TRN_BO_CAP_INVEST.DOCREFNO%TYPE;
M_ACC_SYS_REFNO        DN_ACC_LICENCEE_GEN_ACCOUNT.ACC_SYS_REFNO%TYPE;
M_COUNT                NUMBER;

BEGIN

--raise_application_error(-20001,M_LICENCEE_BRANCH_CODE||'**'||M_LICENCEE_ACCOUNT_NO||'**'||SCR_NAME);
DN_VALIDATE_SAVE_RIGHTS(M_DN_USER,'WD_Capital_Deposit_New');  --added by ashini on 31/10/2005 for sr0509-047

IF  SCR_NAME='ENT' THEN
--SELECT 'CD'||TO_CHAR(SYSDATE,'YYYY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_CAPITAL_DEPOSIT.NEXTVAL),3,'0')
SELECT 'CDMT'||TO_CHAR(SYSDATE,'YY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_CAPITAL_DEPOSIT.NEXTVAL),3,'0')
INTO M_DOCREFNO    FROM DUAL;

 SELECT
 ACC_SYS_REFNO
 INTO M_ACC_SYS_REFNO
 FROM  DN_REF_LICENCEE_SETTLEMENT
 WHERE BRANCH_CODE=M_LICENCEE_BRANCH_CODE
 AND   ACC_NO = M_LICENCEE_ACCOUNT_NO
 AND   ACTIVE_STATUS ='Y';

 INSERT INTO DN_TRN_BO_CAP_DEPOSIT_TEMP
               (  DOCREFNO,
                  PORTFOLIO_CODE,
                  TRANSACTION_TYPE,
                  PROC_DESC,
                  LICENCEE_BRANCH_CODE,
                  LICENEE_ACCOUNT_NO,
                  TRNAMOUNT,
                  DN_USER,
                  TRNDATE,
                  EFF_VAL_DATE,PAYEE_BANK,CHEQUE_NO,
                  LAST_CHANEGE_USER,

                  TRN_TYPE,
                  TRN_MODE,
                  SAVE_ORDER_NO
                      )
                VALUES
                   (  M_DOCREFNO,
                      M_PORTF_CODE,
                      'D',
                      M_PROC_DESC,
                      M_LICENCEE_BRANCH_CODE,
                      M_LICENCEE_ACCOUNT_NO,
                      M_TRNAMOUNT,
                      M_DN_USER,
                      SYSDATE,
                      TO_DATE(M_EFF_DATE,'DD/MM/YYYY'),
                      M_PAYEE_BANK,
                      M_CHEQUE_NO,
                      M_DN_USER,
                      M_TRN_TYPE,
                      M_TRN_MODE,
                      DN_GEN_SAVE_ORDER_NO
                       );
    -- raise_application_error(-20001,M_BANK_DATE);

     IF(M_BANK_DATE<>'--') THEN
      UPDATE DN_TRN_BO_CAP_DEPOSIT_TEMP
      SET BANK_DATE=TO_DATE(M_BANK_DATE,'DD/MM/YYYY')
      WHERE DOCREFNO=M_DOCREFNO;
     END IF;
   --remove becz no need to temp by waruna 2010-12-23
   --DN_ACC_B_2_3(M_PORTF_CODE,M_DN_PORTF_CODE,TO_DATE(M_EFF_DATE,'DD/MM/YYYY'),M_TRNAMOUNT,M_DOCREFNO,M_ACC_SYS_REFNO) ;



--remove becz no need to temp by waruna 2010-12-23
   /*   INSERT INTO DN_TIME_LOG_SETTLE
          (DOC_REF_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            ( M_DOCREFNO,
              M_DN_USER,
              SYSDATE,
            'PORTFOLIO CAPITAL DEPOSIT');*/
M_NUMBER:=M_DOCREFNO;

 INSERT INTO dn_doc_status_log( DOC_REF_NO,DOC_TYPE,DOC_STATUS,DN_USER,ENT_DATE,DESCRIPTION)
 VALUES(M_DOCREFNO,'CAPITAL_DEPOSIT','ENT',M_DN_USER,SYSDATE,'ENTER CAPITAL DEPOSIT');

ELSIF SCR_NAME='MOD' THEN

    SELECT COUNT(DOCREFNO) INTO M_COUNT
            FROM DN_TRN_BO_CAP_DEPOSIT_TEMP
            WHERE DOCREFNO=MM_DOCREFNO
            AND CURRENT_STATUS='ENT';

            IF M_COUNT=0 THEN
                UPDATE DN_TRN_BO_CAP_DEPOSIT_TEMP
                SET  PORTFOLIO_CODE       = M_PORTF_CODE,
                     PROC_DESC            = M_PROC_DESC,
                     LICENCEE_BRANCH_CODE = M_LICENCEE_BRANCH_CODE,
                     LICENEE_ACCOUNT_NO = M_LICENCEE_ACCOUNT_NO,
                     TRNAMOUNT          = M_TRNAMOUNT,
                     --DN_USER= M_DN_USER,
                     TRNDATE           = SYSDATE,
                     EFF_VAL_DATE      = TO_DATE(M_EFF_DATE,'DD/MM/YYYY'),
                     PAYEE_BANK        = M_PAYEE_BANK,
                     CHEQUE_NO         = M_CHEQUE_NO,
                     LAST_CHANEGE_USER = M_DN_USER,
                     LAST_CHANEGE_DATE = SYSDATE,

                     TRN_TYPE = M_TRN_TYPE,
                     TRN_MODE = M_TRN_MODE

                     WHERE DOCREFNO = MM_DOCREFNO
                     AND CURRENT_STATUS = 'ENT' ;

                IF(M_BANK_DATE<>'--') THEN

                UPDATE DN_TRN_BO_CAP_DEPOSIT_TEMP
                SET BANK_DATE  = TO_DATE(M_BANK_DATE,'DD/MM/YYYY')
                WHERE DOCREFNO = M_DOCREFNO
                AND CURRENT_STATUS = 'ENT';

                END IF;

            M_NUMBER:=M_DOCREFNO;
            ELSE
            RAISE_APPLICATION_ERROR(-20201,'<B>'||MM_DOCREFNO||' Can not Modify</B>');
            END IF;

 INSERT INTO dn_doc_status_log( DOC_REF_NO,DOC_TYPE,DOC_STATUS,DN_USER,ENT_DATE,DESCRIPTION)
 VALUES(MM_DOCREFNO,'CAPITAL_DEPOSIT','MOD',M_DN_USER,SYSDATE,'MODIFY CAPITAL DEPOSIT');

ELSIF SCR_NAME='DEL' THEN

            SELECT COUNT(DOCREFNO) INTO M_COUNT
            FROM DN_TRN_BO_CAP_DEPOSIT_TEMP
            WHERE DOCREFNO=MM_DOCREFNO
            AND CURRENT_STATUS='ENT' ;

            IF M_COUNT=0 THEN

            DELETE FROM  DN_TRN_BO_CAP_DEPOSIT_TEMP
             WHERE DOCREFNO=MM_DOCREFNO
             AND CURRENT_STATUS='ENT';

            INSERT INTO dn_doc_status_log( DOC_REF_NO,DOC_TYPE,DOC_STATUS,DN_USER,ENT_DATE,DESCRIPTION)
            VALUES(MM_DOCREFNO,'CAPITAL_DEPOSIT','DEL',M_DN_USER,SYSDATE,'DELETE CAPITAL DEPOSIT');
            M_NUMBER:=M_DOCREFNO;
            ELSE
            RAISE_APPLICATION_ERROR(-20201,'<B>'||MM_DOCREFNO||' Can not Delete</B>');
            END IF;

ELSE
 RAISE_APPLICATION_ERROR(-20201,'<B>'||'Application Erorr'||' </B>');
END IF;


COMMIT;

END ;

/
