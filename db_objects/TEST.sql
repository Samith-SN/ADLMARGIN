--------------------------------------------------------
--  DDL for Procedure TEST
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."TEST" (
     M_MOD_USER    VARCHAR2
)

AS

M_COUNT_1    NUMBER;

  CURSOR M_CURSOR IS SELECT a.deal_no
  FROM dn_trn_outp_sale a where a.app_status='ENT';
  


BEGIN

-- FOR THE INSERT TRANSACTION IN TO FA_CO_ACC_UPLOAD_TEMP
 

             
  
 FOR x IN M_CURSOR LOOP 
     
  ---------------- DN_DEAL_DELETION(x.deal_no,'PABCALL');
    MBFSL_DEAL_CONFIRMATION(x.deal_no,'PABCALL');
     --;
                       
 --RAISE_APPLICATION_ERROR(-20201,'******'||X.PORTFOLIO_CODE);
 END LOOP;
   
   
  
             
  
    COMMIT;

END test;

/
