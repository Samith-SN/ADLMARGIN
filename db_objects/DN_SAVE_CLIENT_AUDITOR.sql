--------------------------------------------------------
--  DDL for Procedure DN_SAVE_CLIENT_AUDITOR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_SAVE_CLIENT_AUDITOR" 
(
    M_CLIENT_CODE                        IN DN_MAS_CLIENT_AUDIT_INFO.CLIENT_CODE % TYPE,
    M_AUDITOR_NO                         IN DN_MAS_CLIENT_AUDIT_INFO.AUDITOR_NO % TYPE,
    M_TITLE                              IN DN_MAS_CLIENT_AUDIT_INFO.TITLE % TYPE,
    M_LAST_NAME                          IN DN_MAS_CLIENT_AUDIT_INFO.LAST_NAME % TYPE,
    M_INITIALS                           IN DN_MAS_CLIENT_AUDIT_INFO.INITIALS % TYPE,
    M_INITIALS_DETAILS                   IN DN_MAS_CLIENT_AUDIT_INFO.INITIALS_DETAILS % TYPE,
    M_ADDRESS_TYPE                       IN DN_MAS_CLIENT_AUDIT_INFO.ADDRESS_TYPE % TYPE,
    M_OWNERSHIP                          IN DN_MAS_CLIENT_AUDIT_INFO.OWNERSHIP % TYPE,
    M_ADDRESS_LINE_1                     IN DN_MAS_CLIENT_AUDIT_INFO.ADDRESS_LINE_1 % TYPE,
    M_ADDRESS_LINE_2                     IN DN_MAS_CLIENT_AUDIT_INFO.ADDRESS_LINE_2 % TYPE,
    M_CITY                               IN DN_MAS_CLIENT_AUDIT_INFO.CITY % TYPE,
    M_TELEPHONE_1                        IN DN_MAS_CLIENT_AUDIT_INFO.TELEPHONE_1 % TYPE,
    M_TELEPHONE_2                        IN DN_MAS_CLIENT_AUDIT_INFO.TELEPHONE_2 % TYPE,
    M_MOBILE                             IN DN_MAS_CLIENT_AUDIT_INFO.MOBILE % TYPE,
    M_FAX                                IN DN_MAS_CLIENT_AUDIT_INFO.FAX % TYPE,
    M_EMAIL                              IN DN_MAS_CLIENT_AUDIT_INFO.EMAIL % TYPE,
    M_RELATIONSHIP                       IN DN_MAS_CLIENT_AUDIT_INFO.RELATIONSHIP % TYPE,
    M_REFERENCE                          IN DN_MAS_CLIENT_AUDIT_INFO.REFERENCE % TYPE,
    M_REFERENCE_PATH                     IN DN_MAS_CLIENT_AUDIT_INFO.REFERENCE_PATH % TYPE,
    M_COMPANY_NAME                       IN DN_MAS_CLIENT_AUDIT_INFO.COMPANY_NAME % TYPE,
    M_USER                               IN DN_MAS_CLIENT_AUDIT_INFO.ENT_USER % TYPE
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
 * Purpose                  :   Save Procedure For The Client Creation Screen [Section : Financial Details]
 */
    
IS
    
    
BEGIN
    
    /* Insert A New Row To The Table */
    INSERT INTO DN_MAS_CLIENT_AUDIT_INFO (
        CLIENT_CODE,
        AUDITOR_NO,
        TITLE,
        LAST_NAME,
        INITIALS,
        INITIALS_DETAILS,
        ADDRESS_TYPE,
        OWNERSHIP,
        ADDRESS_LINE_1,
        ADDRESS_LINE_2,
        CITY,
        TELEPHONE_1,
        TELEPHONE_2,
        MOBILE,
        FAX,
        EMAIL,
        RELATIONSHIP,
        REFERENCE,
        REFERENCE_PATH,
        COMPANY_NAME,
        ENT_USER,
        ENT_DATE
    )
    VALUES (
        M_CLIENT_CODE,
        M_AUDITOR_NO,
        M_TITLE,
        M_LAST_NAME,
        M_INITIALS,
        M_INITIALS_DETAILS,
        M_ADDRESS_TYPE,
        M_OWNERSHIP,
        M_ADDRESS_LINE_1,
        M_ADDRESS_LINE_2,
        M_CITY,
        M_TELEPHONE_1,
        M_TELEPHONE_2,
        M_MOBILE,
        M_FAX,
        M_EMAIL,
        M_RELATIONSHIP,
        M_REFERENCE,
        M_REFERENCE_PATH,
        M_COMPANY_NAME,
        M_USER,
        SYSDATE
    );
    
END DN_SAVE_CLIENT_AUDITOR;

/
