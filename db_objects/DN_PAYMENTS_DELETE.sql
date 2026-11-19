--------------------------------------------------------
--  DDL for Procedure DN_PAYMENTS_DELETE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_PAYMENTS_DELETE" 
   (
   M_PAYMENT_NO     dn_trn_bo_settl_payment.PAYMENT_NO%TYPE,
   M_ACTIVE_STATUS      DN_REF_PORTFOLIO.ACTIVE_STATUS%TYPE,
   M_USER               DN_DOC_STATUS_LOG.DN_USER%TYPE
   )
AS
M_NUMBER VARCHAR(100);

CURSOR M_CURSOR IS SELECT a.payment_no, a.portfolio_code, a.sus_ref_no, a.settle_mode,
                    a.entry_type, a.id_portfolio_code, a.pay_amount,
                    a.lic_branch_code, a.lic_acc_no, a.payee_branch_code,
                    a.payee_acc_no, a.process_status, a.dn_user, a.entdate,
                    a.recon_status, a.recon_date, a.recon_by, a.eff_valdate,
                    a.realised_date, a.payee_name, a.pay_amount_curr,
                    a.pay_advice_status, a.oth_comment, a.trndate, a.client_code,
                    a.dn_mod_user, a.moddate, a.app_status
                    FROM dn_trn_bo_settl_payment_temp a 
                    where app_status='ENT' 
                    and a.payment_no=trim(M_PAYMENT_NO);

BEGIN

--RAISE_APPLICATION_ERROR(-20201,'PAYMENT INVALID='||M_PAYMENT_NO||'**');
  
  
   if M_ACTIVE_STATUS='ENT' then
           
         FOR x IN M_CURSOR LOOP 
       --RAISE_APPLICATION_ERROR(-20201,'PAYMENT INVALID='||DN_GET_TOTAL_PAYMENT(X.client_code,x.id_portfolio_code,to_char(x.eff_valdate,'dd/mm/yyyy')) ||' ' ||DN_GET_TOTAL_PAID(X.client_code,x.id_portfolio_code,to_char(x.eff_valdate,'dd/mm/yyyy')) ||' '||DN_GET_TOTAL_PENDING_PAYMENTS(X.client_code,x.id_portfolio_code,to_char(x.eff_valdate,'dd/mm/yyyy')));
        --if(DN_GET_TOTAL_PAYMENT(X.client_code,x.id_portfolio_code,to_char(x.eff_valdate,'dd/mm/yyyy'))>=  DN_GET_TOTAL_PAID(X.client_code,x.id_portfolio_code,to_char(x.eff_valdate,'dd/mm/yyyy')) +DN_GET_TOTAL_PENDING_PAYMENTS(X.client_code,x.id_portfolio_code,to_char(x.eff_valdate,'dd/mm/yyyy'))) then
       
         /* TRN_SETTLE_PAYMENTS_ALL_BULK(x.payment_no,x.client_code,'CACC',--x.ENTRY_TYPE,
          x.ID_PORTFOLIO_CODE,x.SETTLE_MODE,x.PAY_AMOUNT,x.LIC_BRANCH_CODE,x.LIC_ACC_NO,x.DN_USER,
          to_char(x.eff_valdate,'dd/mm/yyyy'),x.PAYMENT_NO,x.oth_comment,'D',x.SUS_REF_NO);
          */
          update DN_TRN_BO_SETTL_PAYMENT_TEMP a
          set  a.app_status='DEL',
          a.dn_mod_user=M_USER,
          a.moddate=sysdate
          where a.payment_no=  x.payment_no;
           
        
           INSERT INTO DN_DOC_STATUS_LOG( DOC_REF_NO,DOC_TYPE,DOC_STATUS,DN_USER,ENT_DATE,DESCRIPTION)
           VALUES(M_PAYMENT_NO,'PAYMNET BULK DELETE','DEL',M_USER,SYSDATE,'PAYMNET BULK DELETE-'||M_ACTIVE_STATUS);
          
         --  else
         --    RAISE_APPLICATION_ERROR(-20201,'You can not Reject  ='||M_PAYMENT_NO);
            
         --  end if;
           
         END LOOP;    
  
       END IF;      

COMMIT;



END DN_PAYMENTS_DELETE;

/
