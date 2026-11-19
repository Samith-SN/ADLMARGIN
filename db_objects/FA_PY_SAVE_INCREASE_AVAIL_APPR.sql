--------------------------------------------------------
--  DDL for Procedure FA_PY_SAVE_INCREASE_AVAIL_APPR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."FA_PY_SAVE_INCREASE_AVAIL_APPR" 
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
    ENHANCE_RECEIPT_LAST                    NUMBER;
    M_PERCENTAGE_APP_LAST                   NUMBER;
BEGIN
    
   
    
    
    IF M_TYPE = 'COMPANY_VALUATION' THEN
    
     IF M_THIS_PAYMENT_INCREASE_STATUS='Y' OR
        M_THIS_PERIOD_INCREASE_STATUS='Y'OR 
        M_PERMANENT_INCREASE_STATUS ='Y' THEN
     
     M_PERCENTAGE_APP_LAST :=  DN_GET_CLIENT_LICENCE_MT_PERC(M_SECURITY_CODE,M_FACILITY_NO,'APPROVED');
     
                                     UPDATE FA_PY_INCREASE_AVAILABILITY 
                                     SET   THIS_PAYMENT_INCREASE_STATUS = M_THIS_PAYMENT_INCREASE_STATUS,
                                           THIS_PERIOD_INCREASE_STATUS  = M_THIS_PERIOD_INCREASE_STATUS,
                                           THIS_PERIOD_INCREASE_DATE    = M_THIS_PERIOD_INCREASE_DATE,
                                           PERMANENT_INCREASE_STATUS    = M_PERMANENT_INCREASE_STATUS,
                                           COMMENTS                     = M_COMMENTS,
                                           STATUS                       = 'A',
                                           PERCENTAGE_REC               = M_PERCENTAGE_REC,
                                           PERCENTAGE_APP               = M_PERCENTAGE_APP,
                                           ENHANCED_AMOUNT              = M_ENHANCED_AMOUNT,
                                           MOD_USER                     = M_USER,
                                           MOD_DATE                     = SYSDATE,
                                           PERCENTAGE_APP_LAST          = M_PERCENTAGE_APP_LAST
                                     WHERE FACILITY_NO   = M_FACILITY_NO
                                     AND   SECURITY_CODE = M_SECURITY_CODE
                                     AND   TYPE          = 'COMPANY_VALUATION'
                                     AND   STATUS        = 'A'
                                     ;
   
   
   
   
   
                                        IF SQL%NOTFOUND THEN
                                       
                                        INSERT INTO FA_PY_INCREASE_AVAILABILITY(TYPE,
                                        FACILITY_NO,
                                        SECURITY_CODE,
                                        THIS_PAYMENT_INCREASE_STATUS,
                                        THIS_PERIOD_INCREASE_STATUS,
                                        THIS_PERIOD_INCREASE_DATE,
                                        PERMANENT_INCREASE_STATUS,
                                        COMMENTS,
                                        STATUS,
                                        ENT_USER,
                                        ENT_DATE,
                                        PERCENTAGE_REC,
                                        ENHANCED_AMOUNT,
                                        PERCENTAGE_APP,
                                        PERCENTAGE_APP_LAST 
                                        )
                                        VALUES (M_TYPE,
                                        M_FACILITY_NO,
                                        M_SECURITY_CODE,
                                        NVL(M_THIS_PAYMENT_INCREASE_STATUS,'N'),
                                        NVL(M_THIS_PERIOD_INCREASE_STATUS,'N'),
                                        M_THIS_PERIOD_INCREASE_DATE,
                                        NVL(M_PERMANENT_INCREASE_STATUS,'N'),
                                        M_COMMENTS,'A',
                                        M_USER,
                                        SYSDATE,
                                        M_PERCENTAGE_REC,
                                        M_ENHANCED_AMOUNT, 
                                        M_PERCENTAGE_APP,
                                        M_PERCENTAGE_APP_LAST
                                        );
                                                                              
                                         
                                        
                                        END IF;       
                                        
                                          DELETE FA_PY_INCREASE_AVAILABILITY
                                          WHERE FACILITY_NO   = M_FACILITY_NO
                                          AND   SECURITY_CODE = M_SECURITY_CODE
                                          AND   TYPE          = 'COMPANY_VALUATION'
                                          AND   STATUS        = 'E';
      END IF;       
      
    ELSIF M_TYPE = 'CONCENTRATION_ADJ' THEN
   
     IF M_THIS_PAYMENT_INCREASE_STATUS='Y' OR
        M_THIS_PERIOD_INCREASE_STATUS='Y'OR 
        M_PERMANENT_INCREASE_STATUS ='Y' THEN
        
        M_PERCENTAGE_APP_LAST:= DN_GET_CLIENT_CONCENT_PERCENT(M_SECURITY_CODE,M_FACILITY_NO,'APPROVED');
                                     UPDATE FA_PY_INCREASE_AVAILABILITY 
                                     SET   THIS_PAYMENT_INCREASE_STATUS = M_THIS_PAYMENT_INCREASE_STATUS,
                                           THIS_PERIOD_INCREASE_STATUS  = M_THIS_PERIOD_INCREASE_STATUS,
                                           THIS_PERIOD_INCREASE_DATE    = M_THIS_PERIOD_INCREASE_DATE,
                                           PERMANENT_INCREASE_STATUS    = M_PERMANENT_INCREASE_STATUS,
                                           COMMENTS                     = M_COMMENTS,
                                           STATUS                       = 'A',
                                           PERCENTAGE_REC               = M_PERCENTAGE_REC,
                                           PERCENTAGE_APP               = M_PERCENTAGE_APP,
                                           ENHANCED_AMOUNT              = M_ENHANCED_AMOUNT,
                                           MOD_USER                     = M_USER,
                                           MOD_DATE                     = SYSDATE,
                                           PERCENTAGE_APP_LAST          = M_PERCENTAGE_APP_LAST
                                     WHERE FACILITY_NO   = M_FACILITY_NO
                                     AND   SECURITY_CODE = M_SECURITY_CODE
                                     AND   TYPE          = 'CONCENTRATION_ADJ'
                                     AND   STATUS        = 'A'
                                     ;
                                    
                                    IF SQL%NOTFOUND THEN
                                    INSERT INTO FA_PY_INCREASE_AVAILABILITY(TYPE,
                                    FACILITY_NO,
                                    SECURITY_CODE,
                                    THIS_PAYMENT_INCREASE_STATUS,
                                    THIS_PERIOD_INCREASE_STATUS,
                                    THIS_PERIOD_INCREASE_DATE,
                                    PERMANENT_INCREASE_STATUS,
                                    COMMENTS,
                                    STATUS,
                                    ENT_USER,
                                    ENT_DATE,
                                    PERCENTAGE_REC,
                                    ENHANCED_AMOUNT,
                                    PERCENTAGE_APP,
                                    PERCENTAGE_APP_LAST
                                    )
                                    VALUES (M_TYPE,
                                    M_FACILITY_NO,
                                    M_SECURITY_CODE,
                                    NVL(M_THIS_PAYMENT_INCREASE_STATUS,'N'),
                                    NVL(M_THIS_PERIOD_INCREASE_STATUS,'N'),
                                    M_THIS_PERIOD_INCREASE_DATE,
                                    NVL(M_PERMANENT_INCREASE_STATUS,'N'),
                                    M_COMMENTS,'A',
                                    M_USER,
                                    SYSDATE,
                                    M_PERCENTAGE_REC,
                                    M_ENHANCED_AMOUNT,
                                    M_PERCENTAGE_APP ,
                                    M_PERCENTAGE_APP_LAST
                                    );
                                                
                                         
                                    
                                    END IF; 
                                    
                                    
                                     DELETE FA_PY_INCREASE_AVAILABILITY
                                          WHERE FACILITY_NO   = M_FACILITY_NO
                                          AND   SECURITY_CODE = M_SECURITY_CODE
                                          AND   TYPE          = 'CONCENTRATION_ADJ'
                                          AND   STATUS        = 'E';
                                       
    END IF;
   ELSIF M_TYPE = 'DUE_RECEIPT' THEN
   
       IF M_THIS_PAYMENT_INCREASE_STATUS='Y' OR
        M_THIS_PERIOD_INCREASE_STATUS='Y'OR 
        M_PERMANENT_INCREASE_STATUS ='Y' THEN 
        
         ENHANCE_RECEIPT_LAST :=DN_GET_CLIENT_ENHANCE_RECEIPT(M_FACILITY_NO,'APPROVED');
        
                                     UPDATE FA_PY_INCREASE_AVAILABILITY 
                                     SET   THIS_PAYMENT_INCREASE_STATUS = M_THIS_PAYMENT_INCREASE_STATUS,
                                           THIS_PERIOD_INCREASE_STATUS  = M_THIS_PERIOD_INCREASE_STATUS,
                                           THIS_PERIOD_INCREASE_DATE    = M_THIS_PERIOD_INCREASE_DATE,
                                           PERMANENT_INCREASE_STATUS    = M_PERMANENT_INCREASE_STATUS,
                                           COMMENTS                     = M_COMMENTS,
                                           STATUS                       = 'A',
                                           PERCENTAGE_REC               = M_PERCENTAGE_REC,
                                           PERCENTAGE_APP               = M_PERCENTAGE_APP,
                                           ENHANCED_AMOUNT              = M_ENHANCED_AMOUNT,
                                           MOD_USER                     = M_USER,
                                           MOD_DATE                     = SYSDATE,
                                           APPROVED_AMOUNT              = M_APPROVED_AMOUNT,
                                           APPROVED_AMOUNT_LAST         = ENHANCE_RECEIPT_LAST
                                     WHERE FACILITY_NO   = M_FACILITY_NO
                                     --AND   SECURITY_CODE = M_SECURITY_CODE
                                     AND   TYPE          = 'DUE_RECEIPT'
                                     AND   STATUS        = 'A';
                                        
                                        IF SQL%NOTFOUND THEN
                                        INSERT INTO FA_PY_INCREASE_AVAILABILITY(TYPE,
                                        FACILITY_NO,
                                        SECURITY_CODE,
                                        THIS_PAYMENT_INCREASE_STATUS,
                                        THIS_PERIOD_INCREASE_STATUS,
                                        THIS_PERIOD_INCREASE_DATE,
                                        PERMANENT_INCREASE_STATUS,
                                        COMMENTS,
                                        STATUS,
                                        ENT_USER,
                                        ENT_DATE,
                                        PERCENTAGE_REC,
                                        ENHANCED_AMOUNT,
                                        EFF_VALDATE,
                                        
                                        RECOMMENDED_AMOUNT ,
                                        APPROVED_AMOUNT,
                                        APPROVED_AMOUNT_LAST
                                        )
                                        VALUES (M_TYPE,
                                        M_FACILITY_NO,
                                        M_SECURITY_CODE,
                                        NVL(M_THIS_PAYMENT_INCREASE_STATUS,'N'),
                                        NVL(M_THIS_PERIOD_INCREASE_STATUS,'N'),
                                        M_THIS_PERIOD_INCREASE_DATE,
                                        NVL(M_PERMANENT_INCREASE_STATUS,'N'),
                                        M_COMMENTS,'A',
                                        M_USER,
                                        SYSDATE,
                                        M_PERCENTAGE_REC,
                                        M_ENHANCED_AMOUNT,
                                        M_EFF_VALDATE,
                                        M_RECOMMENDED_AMOUNT,
                                        M_APPROVED_AMOUNT ,
                                        ENHANCE_RECEIPT_LAST
                                        );
                                        
                                        
                                         
                                        
                                        END IF;    
    
                                          DELETE FA_PY_INCREASE_AVAILABILITY
                                          WHERE FACILITY_NO   = M_FACILITY_NO
                                          AND   TYPE          = 'DUE_RECEIPT'
                                          AND   STATUS        = 'E';
    
    END IF;
    
    END IF;

    
END ; 

/
