--------------------------------------------------------
--  DDL for Procedure DN_PAYMENTS_REJECT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_PAYMENTS_REJECT" 
   (
   M_PAYMENT_NO        DN_TRN_BO_SETTL_PAYMENT.PAYMENT_NO%TYPE,
   M_ACTIVE_STATUS      DN_REF_PORTFOLIO.ACTIVE_STATUS%TYPE,
   M_USER               DN_DOC_STATUS_LOG.DN_USER%TYPE
   )
AS
M_NUMBER VARCHAR(100);

/*CURSOR M_CURSOR IS SELECT a.payment_no, a.portfolio_code, a.sus_ref_no, a.settle_mode,
                    a.entry_type, a.id_portfolio_code, a.pay_amount,
                    a.lic_branch_code, a.lic_acc_no, a.payee_branch_code,
                    a.payee_acc_no, a.process_status, a.dn_user, a.entdate,
                    a.recon_status, a.recon_date, a.recon_by, a.eff_valdate,
                    a.realised_date, a.payee_name, a.pay_amount_curr,
                    a.pay_advice_status, a.oth_comment, a.trndate, a.client_code,
                    a.dn_mod_user, a.moddate, a.app_status
                    FROM dn_trn_bo_settl_payment_temp a 
                    where app_status='ENT' 
                    and a.payment_no=trim(M_PAYMENT_NO);*/
                    
                    
CURSOR M_CURSOR(MM_PAYMENT_NO DN_TRN_BO_SETTL_PAYMENT_TEMP.PAYMENT_NO%TYPE) IS -- INF=DIVIDUAL PAYMENT
                    SELECT A.PAYMENT_NO, A.PORTFOLIO_CODE, A.SUS_REF_NO, A.SETTLE_MODE,
                    A.ENTRY_TYPE, A.ID_PORTFOLIO_CODE, A.PAY_AMOUNT,
                    A.LIC_BRANCH_CODE, A.LIC_ACC_NO, A.PAYEE_BRANCH_CODE,
                    A.PAYEE_ACC_NO, A.PROCESS_STATUS, A.DN_USER, A.ENTDATE,
                    A.RECON_STATUS, A.RECON_DATE, A.RECON_BY, A.EFF_VALDATE,
                    A.REALISED_DATE, A.PAYEE_NAME, A.PAY_AMOUNT_CURR,
                    A.PAY_ADVICE_STATUS, A.OTH_COMMENT, A.TRNDATE,  A.CLIENT_CODE,
                   -- A.DN_MOD_USER, A.MODDATE, A.APP_STATUS
                    A.GROUP_NET_NO
                    FROM DN_TRN_BO_SETTL_PAYMENT_TEMP A--, DN_TRN_BO_SETTL_PAYMENT_BULK B 
                    WHERE APP_STATUS='ENT' 
                    AND A.PAYMENT_NO=TRIM(MM_PAYMENT_NO)
                    --AND A.PAYMENT_NO= B.PAYMENT_NO
                    AND GROUP_NET_NO IS NULL
               
                    ;
                    
CURSOR M_CURSOR_2(M_GROUP_NET_NO DN_TRN_BO_SETTL_PAYMENT_TEMP.GROUP_NET_NO%TYPE)  
IS (  
  SELECT PAYMENT_NO ,'PAYMENT' SETTLE_TYPE FROM
  DN_TRN_BO_SETTL_PAYMENT_TEMP 
  WHERE GROUP_NET_NO = M_GROUP_NET_NO
  AND APP_STATUS='ENT'

 UNION ALL

 SELECT A.REC_NO ,'RECEIPT' SETTLE_TYPE
 FROM   DN_TRN_BO_SETTL_RECEIPT_TMP A
 WHERE GROUP_NET_NO = M_GROUP_NET_NO
 AND APP_STATUS='ENT'
 
  ) ;   
 
CURSOR M_CURSOR_3(M_REC_NO  DN_TRN_BO_NET_RECEIPT_TMP.REC_NO%TYPE) IS       SELECT A.REC_NO, A.SUS_REF_NO, A.SETTLE_MODE, A.PAYER_BRANCH_CODE,
                            A.PAYER_ACC_NO, A.PAYER_REF, A.PORTFOLIO_CODE,
                            A.SUSPENSE_ENTRY_TYPE, A.ID_PORTFOLIO_CODE, A.REC_AMOUNT,
                            A.OTH_COMMENTS, A.BRANCH_CODE, A.ACC_NO, A.STATUS, A.DN_USER,
                            A.ENTDATE, A.RECON_STATUS, A.RECON_DATE, A.RECON_BY,
                            A.EFF_VALDATE, A.REALISED_DATE, A.REC_AMOUNT_CURR,
                            A.EXCHANGE_GAIN_LOSS, A.SELL_PORTFOLIO_CODE, A.TRNDATE
                            FROM DN_TRN_BO_SETTL_RECEIPT_TMP A --DN_TRN_BO_NET_RECEIPT_TMP A 2012-8-14 
                            WHERE APP_STATUS = 'ENT'  --APP_STATUS
                            AND A.REC_NO     = M_REC_NO
                            AND A.GROUP_NET_NO IS NOT NULL
                            
                            ;  
                
CURSOR M_CURSOR_4(MM_PAYMENT_NO DN_TRN_BO_SETTL_PAYMENT_TEMP.PAYMENT_NO%TYPE) IS  -- GROUP OR NET SETTELEMET
                  
                    
                    SELECT A.PAYMENT_NO, A.PORTFOLIO_CODE, A.SUS_REF_NO, A.SETTLE_MODE,
                    A.ENTRY_TYPE, A.ID_PORTFOLIO_CODE, A.PAY_AMOUNT,
                    A.LIC_BRANCH_CODE, A.LIC_ACC_NO, A.PAYEE_BRANCH_CODE,
                    A.PAYEE_ACC_NO, A.PROCESS_STATUS, A.DN_USER, A.ENTDATE,
                    A.RECON_STATUS, A.RECON_DATE, A.RECON_BY, A.EFF_VALDATE,
                    A.REALISED_DATE, A.PAYEE_NAME, A.PAY_AMOUNT_CURR,
                    A.PAY_ADVICE_STATUS, A.OTH_COMMENT, A.TRNDATE, A.CLIENT_CODE,
                  --  A.DN_MOD_USER, A.MODDATE, A.APP_STATUS,
                    A.GROUP_NET_NO
                    FROM DN_TRN_BO_SETTL_PAYMENT_TEMP A--, DN_TRN_BO_SETTL_PAYMENT_BULK B 
                    WHERE APP_STATUS='ENT' 
                    AND A.PAYMENT_NO=TRIM(MM_PAYMENT_NO)
                    --AND A.PAYMENT_NO= B.PAYMENT_NO
                    AND GROUP_NET_NO IS NOT NULL
                    ;
                    
M_GROUP_NET_COUNT    NUMBER;
M_GROUP_NET_MODE    DN_MAS_SETLE_GROUP_NET.GROUP_NET_MODE%TYPE;

BEGIN


  
  
   /*if M_ACTIVE_STATUS='ENT' then
           
         FOR x IN M_CURSOR LOOP 
      
          update DN_TRN_BO_SETTL_PAYMENT_TEMP a
          set  a.app_status='REJ',
          a.dn_mod_user=M_USER,
          a.moddate=sysdate
          where a.payment_no=  x.payment_no;
           
        
           INSERT INTO DN_DOC_STATUS_LOG( DOC_REF_NO,DOC_TYPE,DOC_STATUS,DN_USER,ENT_DATE,DESCRIPTION)
           VALUES(M_PAYMENT_NO,'PAYMNET BULK REJECT','REJ',M_USER,SYSDATE,'PAYMNET BULK REJECT-'||M_ACTIVE_STATUS);
          
       
           
         END LOOP;    
  
       END IF;  */
       
                 
IF M_ACTIVE_STATUS='ENT' THEN
  
  
  SELECT COUNT(A.GROUP_NET_MODE)
  INTO M_GROUP_NET_COUNT
  FROM DN_MAS_SETLE_GROUP_NET A 
  WHERE A.GROUP_NET_NO = M_PAYMENT_NO; 
  
  IF M_GROUP_NET_COUNT > 0 THEN 
  
  SELECT A.GROUP_NET_MODE 
  INTO M_GROUP_NET_MODE
  FROM DN_MAS_SETLE_GROUP_NET A 
  WHERE A.GROUP_NET_NO = M_PAYMENT_NO; 
  
  UPDATE DN_MAS_SETLE_GROUP_NET
  SET APP_STATUS     = 'REJ'
  WHERE GROUP_NET_NO = M_PAYMENT_NO;
   
  
  END IF;
  
  
    

 
  IF M_GROUP_NET_COUNT = 0 THEN  -- NOT A GROSS OR NET SETTLEMENT
            
       FOR X IN M_CURSOR(M_PAYMENT_NO) LOOP 
         --  RAISE_APPLICATION_ERROR(-20201,'PAYMENT INVALID='||M_PAYMENT_NO||'**'||M_GROUP_NET_COUNT); 
        EXIT WHEN M_CURSOR%NOTFOUND;
       
      
       
          UPDATE DN_TRN_BO_SETTL_PAYMENT_TEMP A
          SET  A.APP_STATUS = 'REJ',
          A.DN_MOD_USER     = M_USER,
          A.MODDATE         = SYSDATE
          WHERE A.PAYMENT_NO =X.PAYMENT_NO;
          
          UPDATE DN_TRN_BO_SETTL_PAYMENT A
           SET    A.PAY_STATUS = 'REJ'
           WHERE A.PAYMENT_NO =X.PAYMENT_NO;
          
          UPDATE DN_TRN_BO_NET_PAYMENT_TEMP A
          SET  A.APP_STATUS  = 'REJ',
          A.DN_MOD_USER      = M_USER,
          A.MODDATE          = SYSDATE
          WHERE A.PAYMENT_NO = X.PAYMENT_NO;
           
        
           INSERT INTO DN_DOC_STATUS_LOG( DOC_REF_NO,DOC_TYPE,DOC_STATUS,DN_USER,ENT_DATE,DESCRIPTION)
           VALUES(M_PAYMENT_NO,'PAYMNET BULK REJECT','REJ',M_USER,SYSDATE,'PAYMNET BULK REJECT-'||M_ACTIVE_STATUS);
          
          
           
         END LOOP;    


ELSIF(M_GROUP_NET_COUNT > 0 ) THEN     ----[END] NOT A GROSS OR NET SETTLEMENT 
   
 FOR Y IN M_CURSOR_2(M_PAYMENT_NO) LOOP 
           
    EXIT WHEN M_CURSOR_2%NOTFOUND;
    
        
        -- RAISE_APPLICATION_ERROR(-20201,'YOU CAN NOT CONFIRM  ='||Y.PAYMENT_NO);
         
      IF Y.SETTLE_TYPE='PAYMENT' THEN -- PAYMENTS
      --  RAISE_APPLICATION_ERROR(-20201,'YOU CAN NOT CONFIRM  ='||Y.PAYMENT_NO);          
        FOR X IN M_CURSOR_4(Y.PAYMENT_NO) LOOP   --GOING TO SETTEL NET PAYMENT OR GROSS PAYMENT
     
       -- RAISE_APPLICATION_ERROR(-20201,'YOU CAN NOT CONFIRM  ='||X.PAYMENT_NO);
            
        EXIT WHEN M_CURSOR_4%NOTFOUND;
       
    
         -- RAISE_APPLICATION_ERROR(-20201,'YOU CAN NOT CONFIRM  ='||X.PAYMENT_NO);
          UPDATE DN_TRN_BO_SETTL_PAYMENT_TEMP A
          SET  A.APP_STATUS = 'REJ',
          A.DN_MOD_USER     = M_USER,
          A.MODDATE         = SYSDATE
          WHERE A.PAYMENT_NO =X.PAYMENT_NO;
          
           UPDATE DN_TRN_BO_SETTL_PAYMENT A
           SET    A.PAY_STATUS = 'REJ'
           WHERE A.PAYMENT_NO =X.PAYMENT_NO;
          
          
          UPDATE DN_TRN_BO_NET_PAYMENT_TEMP A
          SET  A.APP_STATUS  = 'REJ',
          A.DN_MOD_USER      = M_USER,
          A.MODDATE          = SYSDATE
          WHERE A.PAYMENT_NO = X.PAYMENT_NO;
           
        
           INSERT INTO DN_DOC_STATUS_LOG( DOC_REF_NO,DOC_TYPE,DOC_STATUS,DN_USER,ENT_DATE,DESCRIPTION)
           VALUES(X.PAYMENT_NO,'PAYMNET BULK REJECT','REJ',M_USER,SYSDATE,'PAYMNET BULK REJECT-'||M_ACTIVE_STATUS);
          
          
           
         END LOOP;
  
   ELSIF Y.SETTLE_TYPE='RECEIPT' THEN  --[END] PAYMENT        
   
   FOR xy IN M_CURSOR_3(Y.PAYMENT_NO) LOOP 
   EXIT WHEN M_CURSOR_3%NOTFOUND;
         
         
     
          
              UPDATE DN_TRN_BO_SETTL_RECEIPT_TMP A
              SET  A.APP_STATUS = 'REJ',
              A.DN_MOD_USER  = M_USER,
              A.MODDATE      = SYSDATE
              WHERE A.REC_NO =  xy.REC_NO;
                                        
              UPDATE DN_TRN_BO_NET_RECEIPT_TMP A
              SET  A.APP_STATUS = 'REJ',
              A.DN_MOD_USER  = M_USER,
              A.MODDATE      = SYSDATE
              WHERE A.REC_NO =  xy.REC_NO;
              
                              
                        
        
           INSERT INTO DN_DOC_STATUS_LOG( DOC_REF_NO,DOC_TYPE,DOC_STATUS,DN_USER,ENT_DATE,DESCRIPTION)
           VALUES(XY.REC_NO ,'PAYMNET BULK REJECT','REJ',M_USER,SYSDATE,'PAYMNET BULK REJECT-'||M_ACTIVE_STATUS);
         
         END LOOP;
         
    END IF;--[END] RECEIPT    
    
      END LOOP; 
  
END IF;  

            
END IF; --[END] NOT A GROSS OR NET SETTLEMENT    

COMMIT;



END DN_PAYMENTS_REJECT; 

/
