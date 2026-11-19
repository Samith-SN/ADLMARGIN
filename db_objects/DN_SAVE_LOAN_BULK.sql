--------------------------------------------------------
--  DDL for Procedure DN_SAVE_LOAN_BULK
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_SAVE_LOAN_BULK" (
     M_MOD_USER    VARCHAR2,                                                    
     M_SELECT_TYPE VARCHAR2
)

AS

M_COUNT_1    NUMBER;
M_DEAL_NO DN_TEMP_REPO_FRESH.DEAL_NO%type;
M_COUNT_2 NUMBER;
M_COUNT_3 NUMBER;

  CURSOR M_CURSOR IS SELECT DEAL_NO, BORR_PORTFOLIO_CODE, LEND_PORTFOLIO_CODE,
       SEC_ALW_LENDER, PHYSICAL_DELIVERY, EXCHANGE_SEC,
       CURR_CODE, EFF_VALDATE_TYPE, EFF_VALDATE, ON_CALL_DEAL,
       MATURITY_DATE, TENOR, INT_RATE_BASE_CODE, YIELD,
       LEG1_VALUE, LEG2_VALUE, INT_AMOUNT, NO_OF_SETTL_MODES,
       DN_USER, ENT_DATE, APP_STATUS, INT_ACCR,
       CUSTODIAL_STATUS, SCRIPT_STATUS, GROUP_DEALNO,
       GROUP_PORT_TYPE
  FROM DN_TEMP_REPO_FRESH;  


BEGIN

-- FOR THE INSERT TRANSACTION IN TO FA_CO_ACC_UPLOAD_TEMP
 

             
  
 FOR x IN M_CURSOR LOOP
    dbms_output.put_line('**********GOING TO UPLOAD*************'); 
    
 SELECT count(a.portfolio_code) into M_COUNT_2
 FROM dn_ref_portfolio a where a.portfolio_code=X.BORR_PORTFOLIO_CODE;
 
   IF M_COUNT_2=0 THEN
    RAISE_APPLICATION_ERROR(-20201,'****NO BORR_PORTFOLIO_CODE **'||X.BORR_PORTFOLIO_CODE); 
  end if;
  
 SELECT count(a.portfolio_code) into M_COUNT_3
 FROM dn_ref_portfolio a where a.portfolio_code=X.LEND_PORTFOLIO_CODE; 
   
    IF M_COUNT_3=0 THEN
    RAISE_APPLICATION_ERROR(-20201,'****NO LEND_PORTFOLIO_CODE **'||X.LEND_PORTFOLIO_CODE); 
  end if;
   

   
  MBFSL_REPOFRESH_IN1(
    M_DEAL_NO,X.BORR_PORTFOLIO_CODE,X.LEND_PORTFOLIO_CODE,
    'TBILL',--M_INSTRUMENT,
    '12.0000',--M_HAIR_CUT,
    X.SEC_ALW_LENDER,X.PHYSICAL_DELIVERY,
    X.EXCHANGE_SEC,X.CURR_CODE,
    'Act/Act',--M_B_CODE,
    X.EFF_VALDATE_TYPE,--M_VALUE_DATE_TYPE,
    to_char(X.EFF_VALDATE,'DD/MM/YYYY'),X.YIELD,X.ON_CALL_DEAL,X.LEG1_VALUE,X.LEG2_VALUE,
    to_char(X.MATURITY_DATE,'DD/MM/YYYY'),X.TENOR,
    X.INT_AMOUNT,--M_INTEREST,
    M_MOD_USER,'MAIN1',NULL,X.CUSTODIAL_STATUS,X.SCRIPT_STATUS,X.GROUP_PORT_TYPE 
     );
    dbms_output.put_line(M_DEAL_NO);
   
    MBFSL_REPOFRESH_IN1(
    M_DEAL_NO,X.BORR_PORTFOLIO_CODE,X.LEND_PORTFOLIO_CODE,
    'TBILL',--M_INSTRUMENT,
    '12.0000',--M_HAIR_CUT,
    X.SEC_ALW_LENDER,X.PHYSICAL_DELIVERY,
    X.EXCHANGE_SEC,X.CURR_CODE,
    'Act/Act',--M_B_CODE,
    X.EFF_VALDATE_TYPE,--M_VALUE_DATE_TYPE,
    to_char(X.EFF_VALDATE,'DD/MM/YYYY'),X.YIELD,X.ON_CALL_DEAL,X.LEG1_VALUE,X.LEG2_VALUE,
    to_char(X.MATURITY_DATE,'DD/MM/YYYY'),X.TENOR,
    X.INT_AMOUNT,--M_INTEREST,
    M_MOD_USER,'MAIN2',M_DEAL_NO,X.CUSTODIAL_STATUS,X.SCRIPT_STATUS,X.GROUP_PORT_TYPE 
     );

    mbfsl_repofresh_in2(
    M_DEAL_NO,
    '',--M_SECURITY,
    '',--M_ENDORSER,
    '',--M_FACE_VALUE,
    '0000',
    '',--M_SERIAL_NO,
    'RP',--M_INV_CODE1,
    null,--M_PREV_DEAL_NO,
    '1',--M_MODE_NO,
    'CURR_ACC',--M_MODE,
    X.LEG1_VALUE,-- M_AMOUNT,
    '',--M_BORROWER_MODE,
    '',--M_LENDER_MODE,
    '',--M_COMMENT1,
    '',--M_COMMENT2,
    '',--M_BROKER_BORRO,
    '',--M_BROKER_LENDER,
    '',--M_BROKERAGE_BORRO,
    '',--M_BROKERAGE_LEND,
    '',--M_BASE_BORRO,
    '',--M_BASE_LEND,
    0,--M_FEE_BORRO,
    0,--M_FEE_LEND,
    0,--M_AMOUNT_BORRO,
    0,--M_AMOUNT_LEND,
    0,--M_AMT1,
    0,--M_AMT2,
    0,--M_TOTAMOUNT1,
    0,--M_TOTAMOUNT2,
    'SUB1',M_MOD_USER,
    '',--M_PA_SERNO,
    '',--M_PA_INVAMT,
    0,--MM_TOTAMT,
    'SL'--MM_SCRIP_STAT
    );  
     
     
        
    mbfsl_repofresh_in2(
    M_DEAL_NO,
    '',--M_SECURITY,
    '',--M_ENDORSER,
    '',--M_FACE_VALUE,
    '0000',
    '',--M_SERIAL_NO,
    'RP',--M_INV_CODE1,
    null,--M_PREV_DEAL_NO,
    '1',--M_MODE_NO,
    'CURR_ACC',--M_MODE,
    X.LEG1_VALUE,-- M_AMOUNT,
    '',--M_BORROWER_MODE,
    '',--M_LENDER_MODE,
    '',--M_COMMENT1,
    '',--M_COMMENT2,
    '',--M_BROKER_BORRO,
    '',--M_BROKER_LENDER,
    '',--M_BROKERAGE_BORRO,
    '',--M_BROKERAGE_LEND,
    '',--M_BASE_BORRO,
    '',--M_BASE_LEND,
    0,--M_FEE_BORRO,
    0,--M_FEE_LEND,
    0,--M_AMOUNT_BORRO,
    0,--M_AMOUNT_LEND,
    0,--M_AMT1,
    0,--M_AMT2,
    0,--M_TOTAMOUNT1,
    0,--M_TOTAMOUNT2,
    'SUB2',M_MOD_USER,
    '',--M_PA_SERNO,
    '',--M_PA_INVAMT,
    0,--MM_TOTAMT,
    'SL'--MM_SCRIP_STAT
    );  
   
  dbms_output.put_line('end'||M_DEAL_NO);
  ----DN_CHECK_FIGURES_RF(M_DEAL_NO,'');    
  --MBFSL_DEAL_CONFIRMATION(M_DEAL_NO,M_MOD_USER);   //auto conformation    
  ----RAISE_APPLICATION_ERROR(-20201,'******'||X.PORTFOLIO_CODE);
 dbms_output.put_line('Confirm'||M_DEAL_NO);
 
 
 -----*************************accrued interst upload only*******-----------
 /*
 
 MBFSL_REPOSETTLE_IN1(
    M_DEAL_NO ,--DEAL_NO,
    M_DEAL_NO,--PRIOR_DEAL_NO,
    X.BORR_PORTFOLIO_CODE, --M_BCODE,
    X.LEND_PORTFOLIO_CODE,--M_LCODE,
    'SLR',-- M_CURR,
    to_char(X.MATURITY_DATE,'DD/MM/YYYY'),--M_SET_DATE,
    x.TENOR,--M_TENOR,
    '1',--M_SEL_MODES,
    '',--M_SETTLE,
    '',--M_SETAMT ,
    '',--M_BACC,
    '',--M_SACC,
    '',--M_COMM1 ,
    '',--M_COMM2 ,
    'PABCALL' ,--M_USERNAME
    'MAIN1' ,--M_SELECT_TYPE
    null    ,--M_DEAL_NUMBER
    null--GROUP DEALS
    );
    
     MBFSL_REPOSETTLE_IN1(
    M_DEAL_NO ,--DEAL_NO,
    M_DEAL_NO,--PRIOR_DEAL_NO,
    X.BORR_PORTFOLIO_CODE, --M_BCODE,
    X.LEND_PORTFOLIO_CODE,--M_LCODE,
    'SLR',-- M_CURR,
    to_char(X.MATURITY_DATE,'DD/MM/YYYY'),--M_SET_DATE,
    x.TENOR,--M_TENOR,
    '1',--M_SEL_MODES,
    '',--M_SETTLE,
    '',--M_SETAMT ,
    '',--M_BACC,
    '',--M_SACC,
    '',--M_COMM1 ,
    '',--M_COMM2 ,
    'PABCALL' ,--M_USERNAME
    'MAIN2' ,--M_SELECT_TYPE
    null    ,--M_DEAL_NUMBER
    null--GROUP DEALS
    );
    
    
    UPDATE DN_TRN_REPO_SETTLEMENT
       SET APP_STATUS='CONF'
         WHERE
         DEAL_NO=M_DEAL_NO
         AND
         APP_STATUS='ENT';
     */      
  -----*************************end accrued interst upload only*******-----------
  delete from DN_TEMP_REPO_FRESH a where a.borr_portfolio_code =X.BORR_PORTFOLIO_CODE
  and a.lend_portfolio_code=X.LEND_PORTFOLIO_CODE;
 END LOOP;
 --delete from DN_TEMP_REPO_FRESH;
 COMMIT;
 EXCEPTION    
 WHEN OTHERS THEN  -- handles all other errors
 ROLLBACK;
 dbms_output.put_line(SubStr('Error '||TO_CHAR(SQLCODE)||': '||SQLERRM, 1, 255));
 RAISE;

END DN_SAVE_LOAN_BULK;

/
