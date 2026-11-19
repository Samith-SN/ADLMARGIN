--------------------------------------------------------
--  DDL for Procedure DN_SAVE_CLIENT_COMPANY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_SAVE_CLIENT_COMPANY" 
(
    M_CLIENT_CODE                        IN DN_MAS_CLIENT_COMPANY_INFO.CLIENT_CODE % TYPE,
    M_COMPANY_NO                         IN DN_MAS_CLIENT_COMPANY_INFO.COMPANY_NO % TYPE,
    M_ASSOCIATION                        IN DN_MAS_CLIENT_COMPANY_INFO.ASSOCIATION % TYPE,
    M_COMPANY_NAME                       IN DN_MAS_CLIENT_COMPANY_INFO.COMPANY_NAME % TYPE,
    M_STAKE                              IN DN_MAS_CLIENT_COMPANY_INFO.STAKE % TYPE,
    M_SHARE_VALUE                        IN DN_MAS_CLIENT_COMPANY_INFO.SHARE_VALUE % TYPE,
    M_TELEPHONE_1                        IN DN_MAS_CLIENT_COMPANY_INFO.TELEPHONE_1 % TYPE,
    M_TELEPHONE_2                        IN DN_MAS_CLIENT_COMPANY_INFO.TELEPHONE_2 % TYPE,
    M_MOBILE                             IN DN_MAS_CLIENT_COMPANY_INFO.MOBILE % TYPE,
    M_FAX                                IN DN_MAS_CLIENT_COMPANY_INFO.FAX % TYPE,
    M_EMAIL                              IN DN_MAS_CLIENT_COMPANY_INFO.EMAIL % TYPE,
    M_TITLE                              IN DN_MAS_CLIENT_COMPANY_INFO.TITLE % TYPE,
    M_LAST_NAME                          IN DN_MAS_CLIENT_COMPANY_INFO.LAST_NAME % TYPE,
    M_INITIALS                           IN DN_MAS_CLIENT_COMPANY_INFO.INITIALS % TYPE,
    M_INITIALS_DETAILS                   IN DN_MAS_CLIENT_COMPANY_INFO.INITIALS_DETAILS % TYPE,
    M_BUSINESS_ACTIVITIES                IN DN_MAS_CLIENT_COMPANY_INFO.BUSINESS_ACTIVITIES % TYPE,
    M_COMMENTS                           IN DN_MAS_CLIENT_COMPANY_INFO.COMMENTS % TYPE,
    M_USER                               IN DN_MAS_CLIENT_COMPANY_INFO.ENT_USER % TYPE
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
 * Purpose                  :   Save Procedure For The Client Creation Screen [Section : Subsidiaries & Associated Companies]
 */
    
IS
    
    
BEGIN
    
    /* Insert A New Row To The Table */
    INSERT INTO DN_MAS_CLIENT_COMPANY_INFO (
        CLIENT_CODE,
        COMPANY_NO,
        ASSOCIATION,
        COMPANY_NAME,
        STAKE,
        SHARE_VALUE,
        TELEPHONE_1,
        TELEPHONE_2,
        MOBILE,
        FAX,
        EMAIL,
        TITLE,
        LAST_NAME,
        INITIALS,
        INITIALS_DETAILS,
        BUSINESS_ACTIVITIES,
        COMMENTS,
        ENT_USER,
        ENT_DATE
    )
    VALUES (
        M_CLIENT_CODE,
        M_COMPANY_NO,
        M_ASSOCIATION,
        M_COMPANY_NAME,
        M_STAKE,
        M_SHARE_VALUE,
        M_TELEPHONE_1,
        M_TELEPHONE_2,
        M_MOBILE,
        M_FAX,
        M_EMAIL,
        M_TITLE,
        M_LAST_NAME,
        M_INITIALS,
        M_INITIALS_DETAILS,
        M_BUSINESS_ACTIVITIES,
        M_COMMENTS,
        M_USER,
        SYSDATE
    );
    
END DN_SAVE_CLIENT_COMPANY;

/
