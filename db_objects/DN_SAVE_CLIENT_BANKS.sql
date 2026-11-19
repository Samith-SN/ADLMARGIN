--------------------------------------------------------
--  DDL for Procedure DN_SAVE_CLIENT_BANKS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_SAVE_CLIENT_BANKS" 
(
    M_CLIENT_CODE                        IN DN_MAS_CLIENT_BANKS_INFO.CLIENT_CODE % TYPE,
    M_BANK_NO                            IN DN_MAS_CLIENT_BANKS_INFO.BANK_NO % TYPE,
    M_BRANCH                             IN DN_MAS_CLIENT_BANKS_INFO.BRANCH % TYPE,
    M_ACCOUNT_TYPE                       IN DN_MAS_CLIENT_BANKS_INFO.ACCOUNT_TYPE % TYPE,
    M_ACCOUNT_NO                         IN DN_MAS_CLIENT_BANKS_INFO.ACCOUNT_NO % TYPE,
    M_ACCOUNT_NAME                       IN DN_MAS_CLIENT_BANKS_INFO.ACCOUNT_NAME % TYPE,
    M_START_DATE                         IN VARCHAR2,
    M_TELEPHONE                          IN DN_MAS_CLIENT_BANKS_INFO.TELEPHONE % TYPE,
    M_FAX                                IN DN_MAS_CLIENT_BANKS_INFO.FAX % TYPE,
    M_REFERENCE                          IN DN_MAS_CLIENT_BANKS_INFO.REFERENCE % TYPE,
    M_RELATION                           IN DN_MAS_CLIENT_BANKS_INFO.RELATION % TYPE,
    M_PERFORMANCE_PATH                   IN DN_MAS_CLIENT_BANKS_INFO.PERFORMANCE_PATH % TYPE,
    M_COMMENTS                           IN DN_MAS_CLIENT_BANKS_INFO.COMMENTS % TYPE,
    M_USER                               IN DN_MAS_CLIENT_BANKS_INFO.ENT_USER % TYPE
)
    
/* 
 * Author                   :   Samitha Kulatilaka
 * Date                     :   2011-10-12
 * 
 * System                   :   ADLMARGIN
 * Menu Hierarchy           :   Administration -> Client Master Sub Module
 * Screen Name              :   WD_Client_Creation
 * Screen URL               :   Client_Creation.jsp
 * Save Servlet             :   Client_Creation_save.class
 * Display Name             :   Client Creation
 * 
 * Purpose                  :   Save Procedure For The Client Creation Screen [Section : Accounts and Banking Details]
 */
    
IS
    
    
BEGIN
    
    /* Insert A New Row To The Table */
    INSERT INTO DN_MAS_CLIENT_BANKS_INFO (
        CLIENT_CODE,
        BANK_NO,
        BRANCH,
        ACCOUNT_TYPE,
        ACCOUNT_NO,
        ACCOUNT_NAME,
        START_DATE,
        TELEPHONE,
        FAX,
        REFERENCE,
        RELATION,
        PERFORMANCE_PATH,
        COMMENTS,
        ENT_USER,
        ENT_DATE
    )
    VALUES (
        M_CLIENT_CODE,
        M_BANK_NO,
        M_BRANCH,
        M_ACCOUNT_TYPE,
        M_ACCOUNT_NO,
        M_ACCOUNT_NAME,
        TO_DATE(M_START_DATE, 'DD-MM-YYYY'),
        M_TELEPHONE,
        M_FAX,
        M_REFERENCE,
        M_RELATION,
        M_PERFORMANCE_PATH,
        M_COMMENTS,
        M_USER,
        SYSDATE
    );
    
END DN_SAVE_CLIENT_BANKS;

/
