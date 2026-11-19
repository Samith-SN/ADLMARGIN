--------------------------------------------------------
--  DDL for Procedure TRN_RECEIPT_LOAN_SETTLE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."TRN_RECEIPT_LOAN_SETTLE" (
M_LOAN_REC_NO IN OUT     DN_REC_SETLE_LOAN.LOAN_REC_NO%TYPE,
M_DEAL_NO                DN_REC_SETLE_LOAN.DEAL_NO%TYPE,
M_FACILITY_NO            DN_REC_SETLE_LOAN.FACILITY_NO%TYPE,
M_SETTLE_AMOUNT          DN_REC_SETLE_LOAN.SETTLE_AMOUNT%TYPE,
M_SETTLE_MODE            DN_REC_SETLE_LOAN.SETTLE_MODE%TYPE,
M_LIC_BANK_CODE          DN_REC_SETLE_LOAN.LIC_BANK_CODE%TYPE,
M_LIC_ACCNO              DN_REC_SETLE_LOAN.LIC_ACCNO%TYPE,
M_COMMENTS               DN_REC_SETLE_LOAN.COMMENTS%TYPE,
M_USER                   VARCHAR2)
AS
/*
      CREATED BY - DISNAKA JAYASURIYA
      CREATED ON - 2012-02-22
      TO GENERATE LOAN SETTLEMENT RECEIPTS
*/


BEGIN
   SELECT      'LR'
            || TO_CHAR (SYSDATE, 'YY')
            || TO_CHAR (SYSDATE, 'MM')
            || TO_CHAR (SYSDATE, 'DD')
            || '-'
            || LPAD (TO_CHAR (DN_SEQ_LOAN_SETTLE_REC.NEXTVAL), 3, '0')
     INTO   M_LOAN_REC_NO
     FROM   DUAL;


   INSERT INTO DN_REC_SETLE_LOAN (
                                     LOAN_REC_NO,
                                     DEAL_NO,
                                     FACILITY_NO,
                                     SETTLE_AMOUNT,
                                     SETTLE_MODE,
                                     LIC_BANK_CODE,
                                     LIC_ACCNO,
                                     ENTDATE,
                                     DN_USER,
                                     APP_STATUS,
                                     COMMENTS
              )
     VALUES   (
                  M_LOAN_REC_NO, M_DEAL_NO, M_FACILITY_NO, M_SETTLE_AMOUNT,
                  M_SETTLE_MODE, M_LIC_BANK_CODE, M_LIC_ACCNO, SYSDATE,
                  M_USER, 'ENT', M_COMMENTS
              );
              
     INSERT INTO DN_TRN_REPO_SETTLEMENT_BK
     SELECT * FROM DN_TRN_REPO_SETTLEMENT;
     
     UPDATE DN_TRN_REPO_SETTLEMENT
     SET
     RECEIPT_STATUS = 'ENT',
     MOD_USER       = M_USER,
     MOD_DATE       = SYSDATE
     WHERE DEAL_NO = M_DEAL_NO;
     
     
        
END;
/* Formatted on 22-Feb-2012 20:11:54 (QP5 v5.120.811.25008) */ 

/
