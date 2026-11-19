--------------------------------------------------------
--  DDL for Procedure DN_SAVE_CLIENT_DIRECTOR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_SAVE_CLIENT_DIRECTOR" 
(
    M_CLIENT_CODE                        IN DN_MAS_CLIENT_DIRECT_INFO.CLIENT_CODE % TYPE,
    M_DIRECTOR_NO                        IN DN_MAS_CLIENT_DIRECT_INFO.DIRECTOR_NO % TYPE,
    M_TITLE                              IN DN_MAS_CLIENT_DIRECT_INFO.TITLE % TYPE,
    M_LAST_NAME                          IN DN_MAS_CLIENT_DIRECT_INFO.LAST_NAME % TYPE,
    M_INITIALS                           IN DN_MAS_CLIENT_DIRECT_INFO.INITIALS % TYPE,
    M_INITIALS_DETAILS                   IN DN_MAS_CLIENT_DIRECT_INFO.INITIALS_DETAILS % TYPE,
    M_POSITION                           IN DN_MAS_CLIENT_DIRECT_INFO.POSITION % TYPE,
    M_NIC                                IN DN_MAS_CLIENT_DIRECT_INFO.NIC % TYPE,
    M_ADDRESS_TYPE                       IN DN_MAS_CLIENT_DIRECT_INFO.ADDRESS_TYPE % TYPE,
    M_OWNERSHIP                          IN DN_MAS_CLIENT_DIRECT_INFO.OWNERSHIP % TYPE,
    M_ADDRESS_LINE_1                     IN DN_MAS_CLIENT_DIRECT_INFO.ADDRESS_LINE_1 % TYPE,
    M_ADDRESS_LINE_2                     IN DN_MAS_CLIENT_DIRECT_INFO.ADDRESS_LINE_2 % TYPE,
    M_CITY                               IN DN_MAS_CLIENT_DIRECT_INFO.CITY % TYPE,
    M_STAKE                              IN DN_MAS_CLIENT_DIRECT_INFO.STAKE % TYPE,
    M_NUMBER_OF_SHARES                   IN DN_MAS_CLIENT_DIRECT_INFO.NUMBER_OF_SHARES % TYPE,
    M_SHARE_VALUE                        IN DN_MAS_CLIENT_DIRECT_INFO.SHARE_VALUE % TYPE,
    M_GUARANTOR_STATUS                   IN DN_MAS_CLIENT_DIRECT_INFO.GUARANTOR_STATUS % TYPE,
    M_SIGNATORIES                        IN DN_MAS_CLIENT_DIRECT_INFO.SIGNATORIES % TYPE,
    M_COMMENTS                           IN DN_MAS_CLIENT_DIRECT_INFO.COMMENTS % TYPE,
    M_TELEPHONE_1                        IN DN_MAS_CLIENT_DIRECT_INFO.TELEPHONE_1 % TYPE,
    M_TELEPHONE_2                        IN DN_MAS_CLIENT_DIRECT_INFO.TELEPHONE_2 % TYPE,
    M_MOBILE                             IN DN_MAS_CLIENT_DIRECT_INFO.MOBILE % TYPE,
    M_FAX                                IN DN_MAS_CLIENT_DIRECT_INFO.FAX % TYPE,
    M_EMAIL                              IN DN_MAS_CLIENT_DIRECT_INFO.EMAIL % TYPE,
    M_USER                               IN DN_MAS_CLIENT_DIRECT_INFO.ENT_USER % TYPE
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
 * Purpose                  :   Save Procedure For The Client Creation Screen [Section : Directors / Partners / Shareholders]
 */
    
IS
    
    
BEGIN
    
    /* Insert A New Row To The Table */
    INSERT INTO DN_MAS_CLIENT_DIRECT_INFO (
        CLIENT_CODE,
        DIRECTOR_NO,
        TITLE,
        LAST_NAME,
        INITIALS,
        INITIALS_DETAILS,
        POSITION,
        NIC,
        ADDRESS_TYPE,
        OWNERSHIP,
        ADDRESS_LINE_1,
        ADDRESS_LINE_2,
        CITY,
        STAKE,
        NUMBER_OF_SHARES,
        SHARE_VALUE,
        GUARANTOR_STATUS,
        SIGNATORIES,
        COMMENTS,
        ENT_USER,
        ENT_DATE,
        TELEPHONE_1,
        TELEPHONE_2,
        MOBILE,
        FAX,
        EMAIL
    )
    VALUES (
        M_CLIENT_CODE,
        M_DIRECTOR_NO,
        M_TITLE,
        M_LAST_NAME,
        M_INITIALS,
        M_INITIALS_DETAILS,
        M_POSITION,
        M_NIC,
        M_ADDRESS_TYPE,
        M_OWNERSHIP,
        M_ADDRESS_LINE_1,
        M_ADDRESS_LINE_2,
        M_CITY,
        M_STAKE,
        M_NUMBER_OF_SHARES,
        M_SHARE_VALUE,
        M_GUARANTOR_STATUS,
        M_SIGNATORIES,
        M_COMMENTS,
        M_USER,
        SYSDATE,
        M_TELEPHONE_1,
        M_TELEPHONE_2,
        M_MOBILE,
        M_FAX,
        M_EMAIL
    );
    
END DN_SAVE_CLIENT_DIRECTOR;

/
