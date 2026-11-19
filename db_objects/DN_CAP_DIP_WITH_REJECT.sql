--------------------------------------------------------
--  DDL for Procedure DN_CAP_DIP_WITH_REJECT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_CAP_DIP_WITH_REJECT" 
   (
   M_docrefno           DN_TRN_BO_CAP_DEPOSIT_TEMP.docrefno%TYPE,
   M_TRANSACTION_TYPE   DN_TRN_BO_CAP_DEPOSIT_TEMP.transaction_type%TYPE,
   M_USER               DN_TRN_REPO_FRESH.DN_USER%TYPE
   )
AS
M_NUMBER VARCHAR(100);

CURSOR M_CURSOR IS SELECT a.docrefno, a.portfolio_code, a.transaction_type, a.proc_desc,
       a.licencee_branch_code, a.licenee_account_no, a.trnamount,
       a.dn_user, a.trndate, a.recon_status, a.recon_date, a.recon_by,
       to_char(a.eff_val_date,'dd/mm/yyyy') eff_val_date , a.realised_date, a.payee_bank, a.cheque_no,
       a.last_chanege_user, a.last_chanege_date, a.current_status from DN_TRN_BO_CAP_DEPOSIT_temp a
   where docrefno = M_docrefno and current_status='ENT';

BEGIN

--RAISE_APPLICATION_ERROR(-20201,'PAYMENT INVALID='||M_docrefno||'**');
  
  
 --  if M_TRANSACTION_TYPE='ENT' then
           
         FOR x IN M_CURSOR LOOP 
       --RAISE_APPLICATION_ERROR(-20201,'PAYMENT INVALID='||DN_GET_TOTAL_PAYMENT(X.client_code,x.id_portfolio_code,to_char(x.eff_valdate,'dd/mm/yyyy')) ||' ' ||DN_GET_TOTAL_PAID(X.client_code,x.id_portfolio_code,to_char(x.eff_valdate,'dd/mm/yyyy')) ||' '||DN_GET_TOTAL_PENDING_PAYMENTS(X.client_code,x.id_portfolio_code,to_char(x.eff_valdate,'dd/mm/yyyy')));
        --if(DN_GET_TOTAL_PAYMENT(X.client_code,x.id_portfolio_code,to_char(x.eff_valdate,'dd/mm/yyyy'))>=  DN_GET_TOTAL_PAID(X.client_code,x.id_portfolio_code,to_char(x.eff_valdate,'dd/mm/yyyy')) +DN_GET_TOTAL_PENDING_PAYMENTS(X.client_code,x.id_portfolio_code,to_char(x.eff_valdate,'dd/mm/yyyy'))) then
       
         /* TRN_SETTLE_PAYMENTS_ALL_BULK(x.payment_no,x.client_code,'CACC',--x.ENTRY_TYPE,
          x.ID_PORTFOLIO_CODE,x.SETTLE_MODE,x.PAY_AMOUNT,x.LIC_BRANCH_CODE,x.LIC_ACC_NO,x.DN_USER,
          to_char(x.eff_valdate,'dd/mm/yyyy'),x.PAYMENT_NO,x.oth_comment,'D',x.SUS_REF_NO);
          */
          update DN_TRN_BO_CAP_DEPOSIT_TEMP a
          set  a.CURRENT_STATUS='REJ',
          a.LAST_CHANEGE_USER=M_USER,
          a.LAST_CHANEGE_DATE=sysdate
          where a.DOCREFNO=  x.docrefno;
           
        
           INSERT INTO DN_DOC_STATUS_LOG( DOC_REF_NO,DOC_TYPE,DOC_STATUS,DN_USER,ENT_DATE,DESCRIPTION)
           VALUES(M_docrefno,'CAPITAL DEPOSIT/WITHDRAWAL BULK REJECT','REJ',M_USER,SYSDATE,'CAPITAL DEPOSIT/WITHDRAWAL BULK REJECT');
          
         --  else
         --    RAISE_APPLICATION_ERROR(-20201,'You can not Reject  ='||M_PAYMENT_NO);
            
         --  end if;
           
         END LOOP;    
  
      -- END IF;      

COMMIT;



END ;

/
