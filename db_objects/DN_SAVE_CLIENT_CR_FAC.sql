--------------------------------------------------------
--  DDL for Procedure DN_SAVE_CLIENT_CR_FAC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_SAVE_CLIENT_CR_FAC" 
(
    M_CLIENT_CODE                        IN DN_MAS_CLIENT_CRFAC_INFO.CLIENT_CODE % TYPE,
    M_CR_FAC_NO                          IN DN_MAS_CLIENT_CRFAC_INFO.CR_FAC_NO % TYPE,
    M_INST_NAME                          IN DN_MAS_CLIENT_CRFAC_INFO.INST_NAME % TYPE,
    M_TITLE                              IN DN_MAS_CLIENT_CRFAC_INFO.TITLE % TYPE,
    M_LAST_NAME                          IN DN_MAS_CLIENT_CRFAC_INFO.LAST_NAME % TYPE,
    M_INITIALS                           IN DN_MAS_CLIENT_CRFAC_INFO.INITIALS % TYPE,
    M_INITIALS_DET                       IN DN_MAS_CLIENT_CRFAC_INFO.INITIALS_DET % TYPE,
    M_ADDRESS_TYPE                       IN DN_MAS_CLIENT_CRFAC_INFO.ADDRESS_TYPE % TYPE,
    M_OWNERSHIP                          IN DN_MAS_CLIENT_CRFAC_INFO.OWNERSHIP % TYPE,
    M_ADDRESS_LINE_1                     IN DN_MAS_CLIENT_CRFAC_INFO.ADDRESS_LINE_1 % TYPE,
    M_ADDRESS_LINE_2                     IN DN_MAS_CLIENT_CRFAC_INFO.ADDRESS_LINE_2 % TYPE,
    M_CITY                               IN DN_MAS_CLIENT_CRFAC_INFO.CITY % TYPE,
    M_FACILITY_TYPE                      IN DN_MAS_CLIENT_CRFAC_INFO.FACILITY_TYPE % TYPE,
    M_EQUIP_SEC                          IN DN_MAS_CLIENT_CRFAC_INFO.EQUIP_SEC % TYPE,
    M_APR_AMOUNT                         IN DN_MAS_CLIENT_CRFAC_INFO.APR_AMOUNT % TYPE,
    M_MONTHLY_RENTAL                     IN DN_MAS_CLIENT_CRFAC_INFO.MONTHLY_RENTAL % TYPE,
    M_PERIOD                             IN DN_MAS_CLIENT_CRFAC_INFO.PERIOD % TYPE,
    M_BAL_PAYABLE                        IN DN_MAS_CLIENT_CRFAC_INFO.BAL_PAYABLE % TYPE,
    M_BALANCE                            IN DN_MAS_CLIENT_CRFAC_INFO.BALANCE % TYPE,
    M_COMMENTS                           IN DN_MAS_CLIENT_CRFAC_INFO.COMMENTS % TYPE,
    M_USER                               IN DN_MAS_CLIENT_CRFAC_INFO.ENT_USER % TYPE
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
 * Purpose                  :   Save Procedure For The Client Creation Screen [Section : Details of Credit Facilities]
 */
    
IS
    
    
BEGIN
    
    /* Insert A New Row To The Table */
    INSERT INTO DN_MAS_CLIENT_CRFAC_INFO (
        CLIENT_CODE,
        CR_FAC_NO,
        INST_NAME,
        TITLE,
        LAST_NAME,
        INITIALS,
        INITIALS_DET,
        ADDRESS_TYPE,
        OWNERSHIP,
        ADDRESS_LINE_1,
        ADDRESS_LINE_2,
        CITY,
        FACILITY_TYPE,
        EQUIP_SEC,
        APR_AMOUNT,
        MONTHLY_RENTAL,
        PERIOD,
        BAL_PAYABLE,
        BALANCE,
        COMMENTS,
        ENT_USER,
        ENT_DATE
    )
    VALUES (
        M_CLIENT_CODE,
        M_CR_FAC_NO,
        M_INST_NAME,
        M_TITLE,
        M_LAST_NAME,
        M_INITIALS,
        M_INITIALS_DET,
        M_ADDRESS_TYPE,
        M_OWNERSHIP,
        M_ADDRESS_LINE_1,
        M_ADDRESS_LINE_2,
        M_CITY,
        M_FACILITY_TYPE,
        M_EQUIP_SEC,
        M_APR_AMOUNT,
        M_MONTHLY_RENTAL,
        M_PERIOD,
        M_BAL_PAYABLE,
        M_BALANCE,
        M_COMMENTS,
        M_USER,
        SYSDATE
    );
    
END DN_SAVE_CLIENT_CR_FAC;

/
