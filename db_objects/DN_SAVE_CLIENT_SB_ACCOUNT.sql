--------------------------------------------------------
--  DDL for Procedure DN_SAVE_CLIENT_SB_ACCOUNT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_SAVE_CLIENT_SB_ACCOUNT" 
(
    M_CLIENT_CODE                        IN DN_MAS_CLIENT_SB_ACC_INFO.CLIENT_CODE % TYPE,
    M_SB_ACC_NO                          IN DN_MAS_CLIENT_SB_ACC_INFO.SB_ACC_NO % TYPE,
    M_CDS_ACCOUNT_NO                     IN DN_MAS_CLIENT_SB_ACC_INFO.CDS_ACCOUNT_NO % TYPE,
    M_BROKER_NAME                        IN DN_MAS_CLIENT_SB_ACC_INFO.BROKER_NAME % TYPE,
    M_ADVISOR_NAME                       IN DN_MAS_CLIENT_SB_ACC_INFO.ADVISOR_NAME % TYPE,
    M_USER                               IN DN_MAS_CLIENT_SB_ACC_INFO.ENT_USER % TYPE
)
    
/* 
 * Author                   :   Samitha Kulatilaka
 * Date                     :   2011-10-13
 * 
 * System                   :   ADLMARGIN
 * Menu Hierarchy           :   Administration -> Client Master Sub Module
 * Screen Name              :   WD_Client_Creation
 * Screen URL               :   Client_Creation.jsp
 * Save Servlet             :   Client_Creation_save.class
 * Display Name             :   Client Creation
 * 
 * Purpose                  :   Save Procedure For The Client Creation Screen [Section : Stock Brokering Accounts]
 */
    
IS
    
    
BEGIN
    
    /* Insert A New Row To The Table */
    INSERT INTO DN_MAS_CLIENT_SB_ACC_INFO (
        CLIENT_CODE,
        SB_ACC_NO,
        CDS_ACCOUNT_NO,
        BROKER_NAME,
        ADVISOR_NAME,
        ENT_USER,
        ENT_DATE
    )
    VALUES (
        M_CLIENT_CODE,
        M_SB_ACC_NO,
        M_CDS_ACCOUNT_NO,
        M_BROKER_NAME,
        M_ADVISOR_NAME,
        M_USER,
        SYSDATE
    );
    
END DN_SAVE_CLIENT_SB_ACCOUNT;

/
