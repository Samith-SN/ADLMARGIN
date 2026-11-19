--------------------------------------------------------
--  DDL for Procedure FA_PY_CLEAR_INCREASE_AVAIL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."FA_PY_CLEAR_INCREASE_AVAIL" 
(
  M_FACILITY_NO    FA_PY_INCREASE_AVAILABILITY.FACILITY_NO%TYPE
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
 * Purpose                  :   
 */

AS
    
    MM_COUNT                                NUMBER(1);
    
   
BEGIN
    
   
    
      

DELETE FROM FA_PY_INCREASE_AVAILABILITY 
WHERE TYPE='DUE_RECEIPT' 
AND  FACILITY_NO   = M_FACILITY_NO
AND  THIS_PAYMENT_INCREASE_STATUS='Y'
AND   STATUS        = 'A';
    

    
END ; 

/
