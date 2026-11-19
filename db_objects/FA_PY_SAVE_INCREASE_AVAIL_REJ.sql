--------------------------------------------------------
--  DDL for Procedure FA_PY_SAVE_INCREASE_AVAIL_REJ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."FA_PY_SAVE_INCREASE_AVAIL_REJ" 
(
    M_TYPE                               IN FA_PY_INCREASE_AVAILABILITY.TYPE % TYPE,
    M_FACILITY_NO                        IN FA_PY_INCREASE_AVAILABILITY.FACILITY_NO % TYPE,
    M_SECURITY_CODE                      IN FA_PY_INCREASE_AVAILABILITY.SECURITY_CODE % TYPE,
    M_BALANCE_AMOUNT                     IN FA_PY_INCREASE_AVAILABILITY.BALANCE_AMOUNT % TYPE,
    M_RECOMMENDED_AMOUNT                 IN FA_PY_INCREASE_AVAILABILITY.RECOMMENDED_AMOUNT % TYPE,
    M_THIS_PAYMENT_INCREASE_STATUS       IN FA_PY_INCREASE_AVAILABILITY.THIS_PAYMENT_INCREASE_STATUS % TYPE,
    M_THIS_PERIOD_INCREASE_STATUS        IN FA_PY_INCREASE_AVAILABILITY.THIS_PERIOD_INCREASE_STATUS % TYPE,
    M_THIS_PERIOD_INCREASE_DATE          IN FA_PY_INCREASE_AVAILABILITY.THIS_PERIOD_INCREASE_DATE % TYPE,
    M_PERMANENT_INCREASE_STATUS          IN FA_PY_INCREASE_AVAILABILITY.PERMANENT_INCREASE_STATUS % TYPE,
    M_COMMENTS                           IN FA_PY_INCREASE_AVAILABILITY.COMMENTS % TYPE,
    M_CREDIT_LIMIT_REC                   IN FA_PY_INCREASE_AVAILABILITY.CREDIT_LIMIT_REC % TYPE,
    M_PERCENTAGE_REC                     IN FA_PY_INCREASE_AVAILABILITY.PERCENTAGE_REC % TYPE,
    M_ENHANCED_AMOUNT                    IN FA_PY_INCREASE_AVAILABILITY.ENHANCED_AMOUNT  % TYPE,
    M_EFF_VALDATE                        IN FA_PY_INCREASE_AVAILABILITY.EFF_VALDATE  % TYPE,
    M_USER                               IN FA_PY_INCREASE_AVAILABILITY.ENT_USER % TYPE,
    M_PERCENTAGE_APP                     IN FA_PY_INCREASE_AVAILABILITY.PERCENTAGE_APP  % TYPE,
    M_APPROVED_AMOUNT                    IN FA_PY_INCREASE_AVAILABILITY.APPROVED_AMOUNT % TYPE
)

/* 
 * Author                   :   Waruna Sri Jayanath
 * Date                     :   2012-01-11
 * 
 * System                   :   LBMARGIN
 * Menu Hierarchy           :   MARGINtrading -> Payment
 * Screen Name              :   FA_PY_INCREASE_AVAILABILITY
 * Screen URL               :   FA_PY_Increase_Availability_display
 * Save Servlet             :   FA_PY_Increase_Availability_save
 * Display Name             :   Increase Availability
 * 
 * Purpose                  :   Save Procedure To Save An Increase In Availability
 */

AS
    
    MM_COUNT                                NUMBER(1);
    
   
BEGIN
    
 --RAISE_APPLICATION_ERROR(-20201,M_TYPE);
    
    IF M_TYPE = 'COMPANY_VALUATION' THEN
    
    
                                        
                                          DELETE FA_PY_INCREASE_AVAILABILITY
                                          WHERE FACILITY_NO   = M_FACILITY_NO
                                          AND   SECURITY_CODE = M_SECURITY_CODE
                                          AND   TYPE          = 'COMPANY_VALUATION'
                                          AND   STATUS        = 'E';
                                        
                                         
       
      
    ELSIF M_TYPE = 'CONCENTRATION_ADJ' THEN
   
      
                                    
                                          DELETE FA_PY_INCREASE_AVAILABILITY
                                          WHERE FACILITY_NO   = M_FACILITY_NO
                                          AND   SECURITY_CODE = M_SECURITY_CODE
                                          AND   TYPE          = 'CONCENTRATION_ADJ'
                                          AND   STATUS        = 'E';
                                    
  
   ELSIF M_TYPE = 'DUE_RECEIPT' THEN
   
      
                                        
                                          DELETE FA_PY_INCREASE_AVAILABILITY
                                          WHERE FACILITY_NO   = M_FACILITY_NO
                                          AND   TYPE          = 'DUE_RECEIPT'
                                          AND   STATUS        = 'E';
                                        
                                   
    
    END IF;

    
END ; 

/
