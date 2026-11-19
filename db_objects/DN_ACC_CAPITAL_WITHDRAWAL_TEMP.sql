--------------------------------------------------------
--  DDL for Procedure DN_ACC_CAPITAL_WITHDRAWAL_TEMP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_ACC_CAPITAL_WITHDRAWAL_TEMP" 
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
M_CHEQUE_NO            VARCHAR2,
SCR_NAME               VARCHAR2,
MM_DOCREFNO            DN_TRN_BO_CAP_INVEST.DOCREFNO%TYPE

)
AS


M_DOCREFNO             DN_TRN_BO_CAP_INVEST.DOCREFNO%TYPE;
M_ACC_SYS_REFNO        DN_ACC_LICENCEE_GEN_ACCOUNT.ACC_SYS_REFNO%TYPE;
M_COUNT                NUMBER;
BEGIN

DN_VALIDATE_SAVE_RIGHTS(M_DN_USER,'WD_Capital_Withdraw_New');  --added by ashini on 31/10/2005 for sr0509-047

IF  SCR_NAME='ENT' THEN
SELECT 'CWMT'||TO_CHAR(SYSDATE,'YY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_CAPITAL_WITHDRAW.NEXTVAL),3,'0')
INTO M_DOCREFNO    FROM DUAL;

 SELECT
 ACC_SYS_REFNO
 INTO M_ACC_SYS_REFNO
 FROM DN_REF_LICENCEE_SETTLEMENT
 WHERE BRANCH_CODE=M_LICENCEE_BRANCH_CODE
 AND ACC_NO = M_LICENCEE_ACCOUNT_NO
 AND ACTIVE_STATUS ='Y';

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
                  EFF_VAL_DATE,CHEQUE_NO,
                  LAST_CHANEGE_USER,
                  SAVE_ORDER_NO )
                VALUES
                   (  M_DOCREFNO,
                      M_PORTF_CODE,
                      'W',
                      M_PROC_DESC,
                      M_LICENCEE_BRANCH_CODE,
                      M_LICENCEE_ACCOUNT_NO,
                      M_TRNAMOUNT,
                      M_DN_USER,
                      SYSDATE,
                      TO_DATE(M_EFF_DATE,'DD/MM/YYYY'),
                      M_CHEQUE_NO,
                      M_DN_USER,
                      DN_GEN_SAVE_ORDER_NO --ADD BY WARUNA 2012-05-04
                       );
   --remove by waruna 2010-12-23 no need to temp
   --DN_ACC_B_2_7(M_PORTF_CODE,M_DN_PORTF_CODE,TO_DATE(M_EFF_DATE,'DD/MM/YYYY'),M_TRNAMOUNT,M_DOCREFNO,M_ACC_SYS_REFNO) ;



 --remove by waruna 2010-12-23 no need to temp
   /*        INSERT INTO DN_TIME_LOG_SETTLE
          (DOC_REF_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            ( M_DOCREFNO,
              M_DN_USER,
              SYSDATE,
              'PORTFOLIO CAPITAL WITHDRAWAL');
     */         
              
M_NUMBER :=M_DOCREFNO;

INSERT INTO dn_doc_status_log( DOC_REF_NO,DOC_TYPE,DOC_STATUS,DN_USER,ENT_DATE,DESCRIPTION)
VALUES(M_DOCREFNO,'CAPITAL_WITHDRAWAL','ENT',M_DN_USER,SYSDATE,'ENTER CAPITAL WITHDRAWAL');

ELSIF SCR_NAME='MOD' THEN
   
    SELECT COUNT(DOCREFNO) INTO M_COUNT
            FROM DN_TRN_BO_CAP_DEPOSIT_TEMP 
            WHERE DOCREFNO=MM_DOCREFNO AND
            (CURRENT_STATUS='ENT');
            
            IF M_COUNT = 1 THEN
            
                UPDATE DN_TRN_BO_CAP_DEPOSIT_TEMP
                SET  PORTFOLIO_CODE=M_PORTF_CODE,
                     PROC_DESC= M_PROC_DESC,       
                     LICENCEE_BRANCH_CODE=M_LICENCEE_BRANCH_CODE,
                     LICENEE_ACCOUNT_NO=M_LICENCEE_ACCOUNT_NO,
                     TRNAMOUNT=M_TRNAMOUNT,
                    -- DN_USER= M_DN_USER,     
                     TRNDATE =SYSDATE,
                     EFF_VAL_DATE=TO_DATE(M_EFF_DATE,'DD/MM/YYYY'),
                     --PAYEE_BANK=M_PAYEE_BANK,
                     CHEQUE_NO=M_CHEQUE_NO,
                     LAST_CHANEGE_USER=M_DN_USER,
                     LAST_CHANEGE_DATE=SYSDATE
                     WHERE DOCREFNO=MM_DOCREFNO 
                     AND CURRENT_STATUS='ENT' ;
                     
            M_NUMBER:=M_DOCREFNO; 
                    
            ELSE
            RAISE_APPLICATION_ERROR(-20201,'<B>'||MM_DOCREFNO||' CAN NOT MODIFY</B>');
            END IF;

 INSERT INTO DN_DOC_STATUS_LOG( DOC_REF_NO,DOC_TYPE,DOC_STATUS,DN_USER,ENT_DATE,DESCRIPTION)
 VALUES(MM_DOCREFNO,'CAPITAL_WITHDRAWAL','MOD',M_DN_USER,SYSDATE,'MODIFY CAPITAL WITHDRAWAL');

ELSIF SCR_NAME='DEL' THEN

            SELECT COUNT(DOCREFNO) INTO M_COUNT
            FROM DN_TRN_BO_CAP_DEPOSIT_TEMP 
            WHERE DOCREFNO     = MM_DOCREFNO
            AND  CURRENT_STATUS='ENT';
            
            IF M_COUNT = 0 THEN
            
             DELETE FROM  DN_TRN_BO_CAP_DEPOSIT_TEMP 
             WHERE DOCREFNO      =MM_DOCREFNO 
             AND  CURRENT_STATUS ='ENT' ;
             
           M_NUMBER:=M_DOCREFNO; 
           
            INSERT INTO dn_doc_status_log( DOC_REF_NO,DOC_TYPE,DOC_STATUS,DN_USER,ENT_DATE,DESCRIPTION)
            VALUES(MM_DOCREFNO,'CAPITAL_WITHDRAWAL','DEL',M_DN_USER,SYSDATE,'DELETE CAPITAL WITHDRAWAL');
            
            
            ELSE
            RAISE_APPLICATION_ERROR(-20201,'<B>'||MM_DOCREFNO||' Can not Delete</B>');
            END IF;

ELSE
 RAISE_APPLICATION_ERROR(-20201,'<B>'||'Application Erorr'||' </B>');
END IF;
 

COMMIT;

END DN_ACC_CAPITAL_WITHDRAWAL_TEMP; 

/
