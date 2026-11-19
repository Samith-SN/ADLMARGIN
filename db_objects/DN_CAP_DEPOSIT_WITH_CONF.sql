--------------------------------------------------------
--  DDL for Procedure DN_CAP_DEPOSIT_WITH_CONF
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_CAP_DEPOSIT_WITH_CONF" 
   (
   M_docrefno           DN_TRN_BO_CAP_DEPOSIT_TEMP.docrefno%TYPE,
   M_transaction_type   DN_TRN_BO_CAP_DEPOSIT_TEMP.transaction_type%TYPE,
   M_USER               DN_TRN_REPO_FRESH.DN_USER%TYPE
   )
AS
M_NUMBER varchar(100);


CURSOR M_CURSOR IS SELECT A.DOCREFNO, A.PORTFOLIO_CODE, A.TRANSACTION_TYPE,
        A.PROC_DESC,
       A.LICENCEE_BRANCH_CODE, A.LICENEE_ACCOUNT_NO, A.TRNAMOUNT,
       A.DN_USER, A.TRNDATE, A.RECON_STATUS, A.RECON_DATE, A.RECON_BY,
       TO_CHAR(A.EFF_VAL_DATE,'DD/MM/YYYY') EFF_VAL_DATE , A.REALISED_DATE,
        A.PAYEE_BANK, A.CHEQUE_NO,
       A.LAST_CHANEGE_USER, A.LAST_CHANEGE_DATE, A.CURRENT_STATUS,
       A.BANK_DATE, A.TRN_TYPE,A.TRN_MODE
       FROM DN_TRN_BO_CAP_DEPOSIT_TEMP A
   WHERE DOCREFNO = M_DOCREFNO AND CURRENT_STATUS='ENT';

BEGIN

   

IF M_transaction_type='DEPOSIT' THEN

FOR x IN M_CURSOR LOOP 


   DN_ACC_CAPITAL_DEPOSIT_NEW_2(X.DOCREFNO,X.PORTFOLIO_CODE ,X.PORTFOLIO_CODE,X.TRNAMOUNT,
                              '',--M_ACC_NO
                              X.LICENCEE_BRANCH_CODE,X.LICENEE_ACCOUNT_NO,
                              M_USER,X.PROC_DESC,
                              X.EFF_VAL_DATE,
                              M_NUMBER,--M_NUMBER
                              X.PAYEE_BANK,X.CHEQUE_NO,
                              X.BANK_DATE, X.TRN_TYPE,X.TRN_MODE
                              );

END LOOP; 

elsif M_transaction_type='WITHDRAWAL' THEN
FOR x IN M_CURSOR LOOP 
    DN_ACC_CAPITAL_WITHDRAWAL_NEW(x.docrefno,x.portfolio_code,x.portfolio_code,x.trnamount,
                              '' ,--M_ACC_NO
                              x.licencee_branch_code,x.licenee_account_no,
                              M_USER,x.proc_desc,x.eff_val_date,
                              M_NUMBER,--M_NUMBER,
                             x.cheque_no );
END LOOP; 
end if;


COMMIT;



END ; 

/
