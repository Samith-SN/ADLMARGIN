--------------------------------------------------------
--  DDL for Procedure FA_PY_SAVE_MEMO_PAD
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."FA_PY_SAVE_MEMO_PAD" 
(
    M_FACILITY_NO           FA_PY_AVAIL_MEMO_PAD.FACILITY_NO % TYPE,
    M_COMMENT               FA_PY_AVAIL_MEMO_PAD.COMMENTS % TYPE,
    M_USER                  FA_PY_AVAIL_MEMO_PAD.ENT_USER % TYPE
)

AS

/* 
 * Author                   :   Samitha Kulatilaka
 * Date                     :   2010-06-24
 * 
 * System                   :   COMFAC
 * Menu Hierarchy           :   Factoring -> Payment
 * Screen Name              :   
 * Screen URL               :   FA_PY_Client_Payment_Report_display
 * Save Servlet             :   FA_PY_Client_Payment_Report_save
 * Display Name             :   Client Payment Report
 * 
 * Purpose                  :   Save Procedure To Save The Memo Pad In Client Payment Report Screen
 */
 
BEGIN
    
    -- FA_CO_VALIDATE_SAVE_RIGHTS('FA_PY_CLIENT_MANAGER_AVAILABILITY', M_USER, 'NEW');
    
    /* Insert A New Row */
    INSERT INTO FA_PY_AVAIL_MEMO_PAD
    VALUES (
        M_FACILITY_NO,
        M_COMMENT,
        M_USER,
        SYSDATE
    );
    
END;

/
