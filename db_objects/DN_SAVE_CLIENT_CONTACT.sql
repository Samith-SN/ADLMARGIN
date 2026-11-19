--------------------------------------------------------
--  DDL for Procedure DN_SAVE_CLIENT_CONTACT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_SAVE_CLIENT_CONTACT" 
( 
    M_CLIENT_CODE                        IN DN_MAS_CLIENT_CONT_INFO.CLIENT_CODE % TYPE,
    M_CONTACT_PER_NO                     IN DN_MAS_CLIENT_CONT_INFO.CONTACT_PER_NO % TYPE,
    M_TITLE                              IN DN_MAS_CLIENT_CONT_INFO.TITLE % TYPE,
    M_LAST_NAME                          IN DN_MAS_CLIENT_CONT_INFO.LAST_NAME % TYPE,
    M_INITIALS                           IN DN_MAS_CLIENT_CONT_INFO.INITIALS % TYPE,
    M_INITIALS_DETAILS                   IN DN_MAS_CLIENT_CONT_INFO.INITIALS_DETAILS % TYPE,
    M_DESIGNATION                        IN DN_MAS_CLIENT_CONT_INFO.DESIGNATION % TYPE,
    M_TELEPHONE_1                        IN DN_MAS_CLIENT_CONT_INFO.TELEPHONE_1 % TYPE,
    M_TELEPHONE_2                        IN DN_MAS_CLIENT_CONT_INFO.TELEPHONE_2 % TYPE,
    M_MOBILE                             IN DN_MAS_CLIENT_CONT_INFO.MOBILE % TYPE,
    M_FAX                                IN DN_MAS_CLIENT_CONT_INFO.FAX % TYPE,
    M_EMAIL                              IN DN_MAS_CLIENT_CONT_INFO.EMAIL % TYPE,
    M_DEFAULT_STATUS                     IN DN_MAS_CLIENT_CONT_INFO.DEFAULT_STATUS % TYPE,
    M_ADDRESS_TYPE                       IN DN_MAS_CLIENT_CONT_INFO.ADDRESS_TYPE % TYPE,
    M_ADDRESS_LINE_1                     IN DN_MAS_CLIENT_CONT_INFO.ADDRESS_LINE_1 % TYPE,
    M_ADDRESS_LINE_2                     IN DN_MAS_CLIENT_CONT_INFO.ADDRESS_LINE_2 % TYPE,
    M_CITY                               IN DN_MAS_CLIENT_CONT_INFO.CITY % TYPE,
    M_USER                               IN DN_MAS_CLIENT_CONT_INFO.ENT_USER % TYPE
)
    
/* 
 * Author                   :   Samitha Kulatilaka
 * Date                     :   2011-10-10
 * 
 * System                   :   LBMARGIN
 * Menu Hierarchy           :   Administration -> Client Master Sub Module
 * Screen Name              :   WD_Client_Creation
 * Screen URL               :   Client_Creation.jsp
 * Save Servlet             :   Client_Creation_save.class
 * Display Name             :   Client Creation
 * 
 * Purpose                  :   Save Procedure For The Client Creation Screen [Section : Contact Persons]
 */
    
IS
    
    M_DEFAULT_STATUS_VALUE                  DN_MAS_CLIENT_CONT_INFO.DEFAULT_STATUS % TYPE;
    
BEGIN
    
    /* Set The Default Status of The Contact */
    IF M_DEFAULT_STATUS = 'Y' THEN
        M_DEFAULT_STATUS_VALUE := 'Y';
    ELSE                                        -- M_DEFAULT_STATUS = ''
        M_DEFAULT_STATUS_VALUE := 'N';
    END IF;
    
    /* Insert A New Row To The Table */
    INSERT INTO DN_MAS_CLIENT_CONT_INFO (
        CLIENT_CODE,
        CONTACT_PER_NO,
        TITLE,
        LAST_NAME,
        INITIALS,
        INITIALS_DETAILS,
        DESIGNATION,
        TELEPHONE_1,
        TELEPHONE_2,
        MOBILE,
        FAX,
        EMAIL,
        DEFAULT_STATUS,
        ENT_USER,
        ENT_DATE,
        ADDRESS_TYPE,
        ADDRESS_LINE_1,
        ADDRESS_LINE_2,
        CITY
    )
    VALUES (
        M_CLIENT_CODE,
        M_CONTACT_PER_NO,
        M_TITLE,
        M_LAST_NAME,
        M_INITIALS,
        M_INITIALS_DETAILS,
        M_DESIGNATION,
        M_TELEPHONE_1,
        M_TELEPHONE_2,
        M_MOBILE,
        M_FAX,
        M_EMAIL,
        M_DEFAULT_STATUS_VALUE,
        M_USER,
        SYSDATE,
        M_ADDRESS_TYPE,
        M_ADDRESS_LINE_1,
        M_ADDRESS_LINE_2,
        M_CITY
    );
    
    INSERT INTO DN_REF_PORTF_CONT_EMAIL(PORTFOLIO_CODE,EMAIL,SEQ_NO)
    (SELECT PORTFOLIO_CODE,M_EMAIL,'1'  
    FROM DN_REF_PORTFOLIO B 
    WHERE CLIENT_CODE = M_CLIENT_CODE );
    
END DN_SAVE_CLIENT_CONTACT; 

/
