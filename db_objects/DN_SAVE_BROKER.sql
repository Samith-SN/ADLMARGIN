--------------------------------------------------------
--  DDL for Procedure DN_SAVE_BROKER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_SAVE_BROKER" 
(
    M_CLIENT_CODE                    IN OUT DN_MAS_CLIENT.CLIENT_CODE % TYPE,
    M_SCREEN_NAME                        IN VARCHAR2,
    M_ENQUIRY_NO                         IN DN_MAS_CLIENT.ENQUIRY_NO % TYPE,
    M_CLIENT_TYPE                        IN DN_MAS_CLIENT.CLIENT_TYPE % TYPE,
    M_FACTORING_TYPE                     IN DN_MAS_CLIENT.FACTORING_TYPE % TYPE,
    M_FULL_NAME                          IN DN_MAS_CLIENT.FULL_NAME % TYPE,
    M_FULL_NAME_JOINT_HOLDER             IN DN_MAS_CLIENT.FULL_NAME_JOINT_HOLDER % TYPE,
    M_ADDRESS_TYPE                       IN DN_MAS_CLIENT.ADDRESS_TYPE % TYPE,
    M_OWNERSHIP                          IN DN_MAS_CLIENT.OWNERSHIP % TYPE,
    M_ADDRESS_LINE_1                     IN DN_MAS_CLIENT.REGISTERED_ADDRESS1 % TYPE,
    M_ADDRESS_LINE_2                     IN DN_MAS_CLIENT.REGISTERED_ADDRESS2 % TYPE,
    M_CITY                               IN DN_MAS_CLIENT.CITY_CODE % TYPE,
    M_MAP_EXT                            IN VARCHAR2,
    M_PICTURE_EXT                        IN VARCHAR2,
    M_LEGAL_STATUS_OF_BUS                IN DN_MAS_CLIENT.LEGAL_STATUS_OF_BUS % TYPE,
    M_ISSUED_SHARE_CAP                   IN VARCHAR2,
    M_BUS_CERTIFICATE_NO                 IN DN_MAS_CLIENT.BUSINESS_CERTIFICATE_NO % TYPE,
    M_DATE_OF_INCORP                     IN VARCHAR2,
    M_WHT_APPLY                          IN DN_MAS_CLIENT.WITH_HOLDING_TAX % TYPE,
    M_WHT_PERC                           IN VARCHAR2,
    M_WHT_CERT_NO                        IN DN_MAS_CLIENT.WHT_CERT_NO % TYPE,
    M_VAT_REG_NO_CORPORATE               IN DN_MAS_CLIENT.VAT_REG_NO % TYPE,
    M_VAT_REG_DATE_CORPORATE             IN VARCHAR2,
    M_EXT_RATING                         IN DN_MAS_CLIENT.EXT_RATING % TYPE,
    M_RATING_AGENCY                      IN DN_MAS_CLIENT.RATING_AGENCY % TYPE,
    M_RATING_YEAR                        IN DN_MAS_CLIENT.RATING_YEAR % TYPE,
    M_COMMENTS                           IN DN_MAS_CLIENT.COMMENTS % TYPE,
    M_TITLE                              IN DN_MAS_CLIENT.TITLE % TYPE,
    M_SURNAME                            IN DN_MAS_CLIENT.SURNAME % TYPE,
    M_INITIALS                           IN DN_MAS_CLIENT.INITIALS % TYPE,
    M_INITIALS_DETAILS                   IN DN_MAS_CLIENT.OTHER_NAME % TYPE,
    M_GENDER                             IN DN_MAS_CLIENT.GENDER % TYPE,
    M_NATIONALITY                        IN DN_MAS_CLIENT.NATIONALITY % TYPE,
    M_IDENT_TYPE                         IN DN_MAS_CLIENT.IDENT_TYPE % TYPE,
    M_IDENTIFICATION                     IN DN_MAS_CLIENT.IDENTIFICATION % TYPE,
    M_MARITAL_STATUS                     IN DN_MAS_CLIENT.MARITAL_STATUS % TYPE,
    M_DEPENDENTS                         IN DN_MAS_CLIENT.DEPENDENTS % TYPE,
    M_NO_OF_CHILDREN                     IN VARCHAR2,
    M_DATE_OF_BIRTH                      IN VARCHAR2,
    M_OCCUPATION                         IN DN_MAS_CLIENT.OCCUPATION % TYPE,
    M_QUALIFICATION                      IN DN_MAS_CLIENT.QUALIFICATION % TYPE,
    M_EMP_TYPE                           IN DN_MAS_CLIENT.EMP_TYPE % TYPE,
    M_VAT_REG_NO                         IN DN_MAS_CLIENT.VAT_REG_NO % TYPE,
    M_VAT_REG_DATE                       IN VARCHAR2,
    M_USER                               IN DN_MAS_CLIENT.ENT_USER % TYPE,
    M_STATUS                             IN DN_MAS_CLIENT.ACTIVE_STATUS % TYPE,
    M_FOLDER_PATH                        IN VARCHAR2,
    M_TEMP_CLIENT_CODE                   IN VARCHAR2,
    M_CRIB_EXT                           IN VARCHAR2,
    M_BUSI_ADDRESS_TYPE                  IN DN_MAS_CLIENT.BUSI_ADDRESS_TYPE % TYPE,
    M_BUSI_ADDRESS_LINE_1                IN DN_MAS_CLIENT.BUSI_ADDRESS_LINE_1 % TYPE,
    M_BUSI_ADDRESS_LINE_2                IN DN_MAS_CLIENT.BUSI_ADDRESS_LINE_2 % TYPE,
    M_BUSI_CITY                          IN DN_MAS_CLIENT.BUSI_CITY % TYPE,
    M_BUSINESS_REG_LOCATION              IN DN_MAS_CLIENT.BUSINESS_REG_LOCATION % TYPE,
    M_NATURE_OF_BUSINESS                 IN DN_MAS_CLIENT.NATURE_OF_BUSINESS % TYPE,
    M_CLIENT_CATEGORY                    IN DN_MAS_CLIENT.CLIENT_CATEGORY % TYPE,
    M_CLIENT_GROUP                       IN DN_MAS_CLIENT.CLIENT_GROUP % TYPE
)
    
/* 
 * Author                   :   Samitha Kulatilaka
 * Date                     :   2011-10-03
 * 
 * System                   :   ADLMARGIN
 * Menu Hierarchy           :   Administration -> Client Master Sub Module
 * Screen Name              :   WD_Client_Creation
 * Screen URL               :   Client_Creation.jsp
 * Save Servlet             :   Client_Creation_save.class
 * Display Name             :   Client Creation
 * 
 * Purpose                  :   Save Procedure For The Client Creation Screen
 */
    
IS
    
    M_MAP_PATH                          VARCHAR2(200);
    M_PICTURE_PATH                      VARCHAR2(200);
    M_CRIB_PATH                         VARCHAR2(200);
    MM_CLIENT_CATEGORY                  DN_REF_BROKER_CATEGORY.CAT_TYPE_CODE % TYPE;
    MM_JOINT_HOLDER_APPLICABLE          DN_MAS_CLIENT.JOINT_HOLDER_APPLICABLE % TYPE;
    M_BROKER_COUNT                      NUMBER;
BEGIN
    
    IF M_FULL_NAME_JOINT_HOLDER = '' OR M_FULL_NAME_JOINT_HOLDER IS NULL THEN
        
        MM_JOINT_HOLDER_APPLICABLE := 'N';
        
    ELSE
        
        MM_JOINT_HOLDER_APPLICABLE := 'Y';
        
    END IF;
    
    
    /* Set Client Category To Individual If Client Type Is Individual */
    IF M_CLIENT_TYPE = 'I' THEN
    
        SELECT A.CAT_TYPE_CODE
        INTO   MM_CLIENT_CATEGORY
        FROM   DN_REF_BROKER_CATEGORY A
        WHERE  A.ACTIVE_STATUS = 'Y'
        AND    A.DEFAULT_VALUE = 'I';
        
    END IF;
    
    
    IF M_SCREEN_NAME = 'NEW' THEN
        
        /* Generate The Next Sequence Number */
        -- SELECT LPAD(DN_SEQ_CLIENT_CODE.NEXTVAL, 10, '0') -- 17-10-2011
       /*
        SELECT LPAD(DN_SEQ_CLIENT_CODE.NEXTVAL, 6, '0')
        INTO   M_CLIENT_CODE
        FROM   DUAL;
        */
        /* Create The Map Path & The Picture Path */
        IF M_MAP_EXT <> 'NULL' THEN
            M_MAP_PATH := M_FOLDER_PATH || M_CLIENT_CODE || '\' || M_CLIENT_CODE || '-M' || '.' || M_MAP_EXT;
        END IF;
        IF M_PICTURE_EXT <> 'NULL' THEN
            M_PICTURE_PATH := M_FOLDER_PATH || M_CLIENT_CODE || '\' || M_CLIENT_CODE || '-P' || '.' || M_PICTURE_EXT;
        END IF;
        IF M_CRIB_EXT <> 'NULL' THEN
            M_CRIB_PATH := M_FOLDER_PATH || M_CLIENT_CODE || '\' || M_CLIENT_CODE || '-C' || '.' || M_CRIB_EXT;
        END IF;
        
        
        /* Insert A New Row To The Table */
        IF M_CLIENT_TYPE = 'B' THEN
            INSERT INTO DN_MAS_CLIENT (
                ENQUIRY_NO,
                CLIENT_TYPE,
                CLIENT_CODE,
                FACTORING_TYPE,
                FULL_NAME,
                ADDRESS_TYPE,
                OWNERSHIP,
                REGISTERED_ADDRESS1,
                REGISTERED_ADDRESS2,
                CITY_CODE,
                MAP_PATH,
                PICTURE_PATH,
                LEGAL_STATUS_OF_BUS,
                ISSUED_SHARE_CAPITAL,
                BUSINESS_CERTIFICATE_NO,
                DATE_OF_INCORPORATION,
                WITH_HOLDING_TAX,
                WHT_PERCENTAGE,
                WHT_CERT_NO,
                VAT_REG_NO,
                VAT_REG_DATE,
                EXT_RATING,
                RATING_AGENCY,
                RATING_YEAR,
                COMMENTS,
                ACTIVE_STATUS,
                ENT_USER,
                ENT_DATE,
                CRIB_PATH,
                BUSI_ADDRESS_TYPE,
                BUSI_ADDRESS_LINE_1,
                BUSI_ADDRESS_LINE_2,
                BUSI_CITY,
                BUSINESS_REG_LOCATION,
                NATURE_OF_BUSINESS,
                CLIENT_CATEGORY,
                CLIENT_GROUP,
                JOINT_HOLDER_APPLICABLE,
                FULL_NAME_JOINT_HOLDER
            )
            VALUES (
                M_ENQUIRY_NO,
                M_CLIENT_TYPE,
                M_CLIENT_CODE,
                M_FACTORING_TYPE,
                M_FULL_NAME,
                M_ADDRESS_TYPE,
                M_OWNERSHIP,
                M_ADDRESS_LINE_1,
                M_ADDRESS_LINE_2,
                M_CITY,
                M_MAP_PATH,
                M_PICTURE_PATH,
                M_LEGAL_STATUS_OF_BUS,
                TO_NUMBER(M_ISSUED_SHARE_CAP),
                M_BUS_CERTIFICATE_NO,
                TO_DATE(M_DATE_OF_INCORP, 'DD-MM-YYYY'),
                M_WHT_APPLY,
                TO_NUMBER(M_WHT_PERC),
                M_WHT_CERT_NO,
                M_VAT_REG_NO_CORPORATE,
                TO_DATE(M_VAT_REG_DATE_CORPORATE, 'DD-MM-YYYY'),
                M_EXT_RATING,
                M_RATING_AGENCY,
                M_RATING_YEAR,
                M_COMMENTS,
                M_STATUS,
                M_USER,
                SYSDATE,
                M_CRIB_PATH,
                M_BUSI_ADDRESS_TYPE,
                M_BUSI_ADDRESS_LINE_1,
                M_BUSI_ADDRESS_LINE_2,
                M_BUSI_CITY,
                M_BUSINESS_REG_LOCATION,
                M_NATURE_OF_BUSINESS,
                M_CLIENT_CATEGORY,
                M_CLIENT_GROUP,
                MM_JOINT_HOLDER_APPLICABLE,
                M_FULL_NAME_JOINT_HOLDER
            );
           SELECT COUNT(A.PORTFOLIO_CODE) INTO M_BROKER_COUNT 
           FROM DN_REF_PORTFOLIO A 
           WHERE A.PORTFOLIO_CODE= M_CLIENT_CODE 
           AND A.PF_TYPE='C';
        
        IF  M_BROKER_COUNT=0 THEN 
          
         DN_COUNTER_PARTY_IN1 (    M_CLIENT_CODE,--PORTFOLIO_CODE
                                   'N',--OWNED_BY_MBFS
                                   NUll,--CP_PORTFOLIO_CODE
                                   M_FULL_NAME,--PF_NAME
                                   M_ADDRESS_LINE_1, --ADD_IDENTIFICATION
                                   M_ADDRESS_LINE_2,--ADD_LOCATION
                                   NUll ,--ADD_STREET
                                   M_CITY,--ADD_CITY
                                   DN_GET_CITY_DETAILS(M_CITY, 'CITY_CODE', 'COUNTRY_CODE'),--ADD_COUNTRY
                                   '99999',--POSTAL_CODE
                                   TO_DATE(M_DATE_OF_INCORP, 'DD-MM-YYYY'),-- M_DATE_INC_BIRTH   
                                   M_BUS_CERTIFICATE_NO,--BUSI_REG_NIC
                                   NULL,--CATEGORY_ENTITY
                                   M_NATURE_OF_BUSINESS,--NATURE_OCCUPATION
                                   'MBSE',--MBFSL_SECT_CODE,
                                   'UCD',--SECT_CODE,
                                   'Y',--APPLY_STATUS,
                                   NULL,--DIRECTOR_NAME,
                                   'MAIN1',--M_SELECT_TYPE 
                                   NULL,--AUTHO_NAME
                                   NULL,--CONT_PERSON_
                                   NULL,--TEL_NO
                                   NULL,--FAX_NO,
                                   NULL,--EMAIL,
                                   NULL,--BRANCH_CODE,
                                   NULL,--ACC_NO,
                                   'COL',--BRANCH,
                                   'N',--SWIFT_STATUS,-- //modified by inditha 20-7-2004/10:27
                                   NULL,--PLEDG_ACC_NO%TYPE,
                                   M_USER --  M_USER 	
                                    );  
         ELSE 
            INSERT INTO DN_REF_PORTFOLIO_BK
                SELECT A.*
                FROM   DN_REF_PORTFOLIO A
                WHERE  A.PORTFOLIO_CODE = M_CLIENT_CODE;
            
            UPDATE DN_REF_PORTFOLIO A
            SET    A.PF_NAME                = M_FULL_NAME,
                   A.ADD_IDENTIFICATION     = M_ADDRESS_LINE_1,
                   A.ADD_LOCATION           = M_ADDRESS_LINE_2,
                   A.ADD_CITY               = M_CITY,
                   A.ADD_COUNTRY            = DN_GET_CITY_DETAILS(M_CITY, 'CITY_CODE', 'COUNTRY_CODE'),
                   A.POSTAL_CODE            = '99999',--M_CITY,
                   A.DATE_INC_BIRTH         = TO_DATE(M_DATE_OF_BIRTH, 'DD-MM-YYYY'),
                   A.LAST_MODIFIED          = SYSDATE,
                   A.MOD_USER               = M_USER,
                   A.MOD_DATE               = SYSDATE
            WHERE  A.PORTFOLIO_CODE         = M_CLIENT_CODE;
         END IF;                           
                                                     
        ELSIF M_CLIENT_TYPE = 'I' THEN
            INSERT INTO DN_MAS_CLIENT (
                ENQUIRY_NO,
                CLIENT_TYPE,
                CLIENT_CODE,
                FACTORING_TYPE,
                FULL_NAME,
                ADDRESS_TYPE,
                OWNERSHIP,
                REGISTERED_ADDRESS1,
                REGISTERED_ADDRESS2,
                CITY_CODE,
                MAP_PATH,
                PICTURE_PATH,
                TITLE,
                SURNAME,
                INITIALS,
                OTHER_NAME,
                GENDER,
                NATIONALITY,
                IDENT_TYPE,
                IDENTIFICATION,
                MARITAL_STATUS,
                DEPENDENTS,
                NUMBER_OF_CHILDREN,
                DATE_OF_BIRTH,
                OCCUPATION,
                QUALIFICATION,
                EMP_TYPE,
                VAT_REG_NO,
                VAT_REG_DATE,
                ACTIVE_STATUS,
                ENT_USER,
                ENT_DATE,
                CRIB_PATH,
                BUSINESS_REG_LOCATION,
                NATURE_OF_BUSINESS,
                CLIENT_CATEGORY,
                CLIENT_GROUP,
                JOINT_HOLDER_APPLICABLE,
                FULL_NAME_JOINT_HOLDER
            )
            VALUES (
                M_ENQUIRY_NO,
                M_CLIENT_TYPE,
                M_CLIENT_CODE,
                M_FACTORING_TYPE,
                M_FULL_NAME,
                M_ADDRESS_TYPE,
                M_OWNERSHIP,
                M_ADDRESS_LINE_1,
                M_ADDRESS_LINE_2,
                M_CITY,
                M_MAP_PATH,
                M_PICTURE_PATH,
                M_TITLE,
                M_SURNAME,
                M_INITIALS,
                M_INITIALS_DETAILS,
                M_GENDER,
                M_NATIONALITY,
                M_IDENT_TYPE,
                M_IDENTIFICATION,
                M_MARITAL_STATUS,
                M_DEPENDENTS,
                TO_NUMBER(M_NO_OF_CHILDREN),
                TO_DATE(M_DATE_OF_BIRTH, 'DD-MM-YYYY'),
                M_OCCUPATION,
                M_QUALIFICATION,
                M_EMP_TYPE,
                M_VAT_REG_NO,
                TO_DATE(M_VAT_REG_DATE, 'DD-MM-YYYY'),
                M_STATUS,
                M_USER,
                SYSDATE,
                M_CRIB_PATH,
                M_BUSINESS_REG_LOCATION,
                M_NATURE_OF_BUSINESS,
                MM_CLIENT_CATEGORY,
                M_CLIENT_GROUP,
                MM_JOINT_HOLDER_APPLICABLE,
                M_FULL_NAME_JOINT_HOLDER
            );
        END IF;
        
        
    ELSIF M_SCREEN_NAME = 'EDIT' THEN
        
        /* Create The Map Path & The Picture Path */
        IF M_MAP_EXT <> 'NULL' THEN
            M_MAP_PATH := M_FOLDER_PATH || M_CLIENT_CODE || '\' || M_CLIENT_CODE || '-M' || '.' || M_MAP_EXT;
        END IF;
        IF M_PICTURE_EXT <> 'NULL' THEN
            M_PICTURE_PATH := M_FOLDER_PATH || M_CLIENT_CODE || '\' || M_CLIENT_CODE || '-P' || '.' || M_PICTURE_EXT;
        END IF;
        IF M_CRIB_EXT <> 'NULL' THEN
            M_CRIB_PATH := M_FOLDER_PATH || M_CLIENT_CODE || '\' || M_CLIENT_CODE || '-C' || '.' || M_CRIB_EXT;
        END IF;
        
        
        /* Update The Table */
        IF M_CLIENT_TYPE = 'B' THEN
            
            UPDATE DN_MAS_CLIENT A
            SET    ENQUIRY_NO = M_ENQUIRY_NO,
                   CLIENT_TYPE = M_CLIENT_TYPE,
                   CLIENT_CODE = M_CLIENT_CODE,
                   FULL_NAME = M_FULL_NAME,
                   ADDRESS_TYPE = M_ADDRESS_TYPE,
                   OWNERSHIP = M_OWNERSHIP,
                   REGISTERED_ADDRESS1 = M_ADDRESS_LINE_1,
                   REGISTERED_ADDRESS2 = M_ADDRESS_LINE_2,
                   CITY_CODE = M_CITY,
                   MAP_PATH = M_MAP_PATH,
                   PICTURE_PATH = M_PICTURE_PATH,
                   LEGAL_STATUS_OF_BUS = M_LEGAL_STATUS_OF_BUS,
                   ISSUED_SHARE_CAPITAL = TO_NUMBER(M_ISSUED_SHARE_CAP),
                   BUSINESS_CERTIFICATE_NO = M_BUS_CERTIFICATE_NO,
                   DATE_OF_INCORPORATION = TO_DATE(M_DATE_OF_INCORP, 'DD-MM-YYYY'),
                   WITH_HOLDING_TAX = M_WHT_APPLY,
                   WHT_PERCENTAGE = TO_NUMBER(M_WHT_PERC),
                   WHT_CERT_NO = M_WHT_CERT_NO,
                   VAT_REG_NO = M_VAT_REG_NO_CORPORATE,
                   VAT_REG_DATE = TO_DATE(M_VAT_REG_DATE_CORPORATE, 'DD-MM-YYYY'),
                   EXT_RATING = M_EXT_RATING,
                   RATING_AGENCY = M_RATING_AGENCY,
                   RATING_YEAR = M_RATING_YEAR,
                   COMMENTS = M_COMMENTS,
                   TITLE = NULL,
                   SURNAME = NULL,
                   INITIALS = NULL,
                   OTHER_NAME = NULL,
                   GENDER = NULL,
                   NATIONALITY = NULL,
                   IDENT_TYPE = NULL,
                   IDENTIFICATION = NULL,
                   MARITAL_STATUS = NULL,
                   DEPENDENTS = NULL,
                   NUMBER_OF_CHILDREN = NULL,
                   DATE_OF_BIRTH = NULL,
                   OCCUPATION = NULL,
                   QUALIFICATION = NULL,
                   EMP_TYPE = NULL,
                   -- VAT_REG_NO = NULL,
                   -- VAT_REG_DATE = NULL,
                   ACTIVE_STATUS = M_STATUS,
                   MOD_USER = M_USER,
                   MOD_DATE = SYSDATE,
                   CRIB_PATH = M_CRIB_PATH,
                   BUSI_ADDRESS_TYPE = M_BUSI_ADDRESS_TYPE,
                   BUSI_ADDRESS_LINE_1 = M_BUSI_ADDRESS_LINE_1,
                   BUSI_ADDRESS_LINE_2 = M_BUSI_ADDRESS_LINE_2,
                   BUSI_CITY = M_BUSI_CITY,
                   BUSINESS_REG_LOCATION = M_BUSINESS_REG_LOCATION,
                   NATURE_OF_BUSINESS = M_NATURE_OF_BUSINESS,
                   CLIENT_CATEGORY = M_CLIENT_CATEGORY,
                   CLIENT_GROUP = M_CLIENT_GROUP,
                   JOINT_HOLDER_APPLICABLE = MM_JOINT_HOLDER_APPLICABLE,
                   FULL_NAME_JOINT_HOLDER = M_FULL_NAME_JOINT_HOLDER
            WHERE  A.CLIENT_CODE = M_CLIENT_CODE;
            
            
            INSERT INTO DN_REF_PORTFOLIO_BK
                SELECT A.*
                FROM   DN_REF_PORTFOLIO A
                WHERE  A.PORTFOLIO_CODE = M_CLIENT_CODE;
            
            UPDATE DN_REF_PORTFOLIO A
            SET    A.PF_NAME                = M_FULL_NAME,
                   A.ADD_IDENTIFICATION     = M_ADDRESS_LINE_1,
                   A.ADD_LOCATION           = M_ADDRESS_LINE_2,
                   A.ADD_CITY               = M_CITY,
                   A.ADD_COUNTRY            = DN_GET_CITY_DETAILS(M_CITY, 'CITY_CODE', 'COUNTRY_CODE'),
                   A.POSTAL_CODE            = '99999',--M_CITY,
                   A.BUSI_REG_NIC           = M_BUS_CERTIFICATE_NO,
                   A.LAST_MODIFIED          = SYSDATE,
                   A.MOD_USER               = M_USER,
                   A.MOD_DATE               = SYSDATE
            WHERE  A.PORTFOLIO_CODE            = M_CLIENT_CODE;
            
        ELSIF M_CLIENT_TYPE = 'I' THEN
            
            UPDATE DN_MAS_CLIENT A
            SET    ENQUIRY_NO = M_ENQUIRY_NO,
                   CLIENT_TYPE = M_CLIENT_TYPE,
                   CLIENT_CODE = M_CLIENT_CODE,
                   FULL_NAME = M_FULL_NAME,
                   ADDRESS_TYPE = M_ADDRESS_TYPE,
                   OWNERSHIP = M_OWNERSHIP,
                   REGISTERED_ADDRESS1 = M_ADDRESS_LINE_1,
                   REGISTERED_ADDRESS2 = M_ADDRESS_LINE_2,
                   CITY_CODE = M_CITY,
                   MAP_PATH = M_MAP_PATH,
                   PICTURE_PATH = M_PICTURE_PATH,
                   LEGAL_STATUS_OF_BUS = NULL,
                   ISSUED_SHARE_CAPITAL = NULL,
                   BUSINESS_CERTIFICATE_NO = NULL,
                   DATE_OF_INCORPORATION = NULL,
                   WITH_HOLDING_TAX = NULL,
                   WHT_PERCENTAGE = NULL,
                   WHT_CERT_NO = NULL,
                   -- VAT_REG_NO = NULL,
                   -- VAT_REG_DATE = NULL,
                   EXT_RATING = NULL,
                   RATING_AGENCY = NULL,
                   RATING_YEAR = NULL,
                   COMMENTS = NULL,
                   TITLE = M_TITLE,
                   SURNAME = M_SURNAME,
                   INITIALS = M_INITIALS,
                   OTHER_NAME = M_INITIALS_DETAILS,
                   GENDER = M_GENDER,
                   NATIONALITY = M_NATIONALITY,
                   IDENT_TYPE = M_IDENT_TYPE,
                   IDENTIFICATION = M_IDENTIFICATION,
                   MARITAL_STATUS = M_MARITAL_STATUS,
                   DEPENDENTS = M_DEPENDENTS,
                   NUMBER_OF_CHILDREN = TO_NUMBER(M_NO_OF_CHILDREN),
                   DATE_OF_BIRTH = TO_DATE(M_DATE_OF_BIRTH, 'DD-MM-YYYY'),
                   OCCUPATION = M_OCCUPATION,
                   QUALIFICATION = M_QUALIFICATION,
                   EMP_TYPE = M_EMP_TYPE,
                   VAT_REG_NO = M_VAT_REG_NO,
                   VAT_REG_DATE = TO_DATE(M_VAT_REG_DATE, 'DD-MM-YYYY'),
                   ACTIVE_STATUS = M_STATUS,
                   MOD_USER = M_USER,
                   MOD_DATE = SYSDATE,
                   CRIB_PATH = M_CRIB_PATH,
                   BUSINESS_REG_LOCATION = M_BUSINESS_REG_LOCATION,
                   NATURE_OF_BUSINESS = M_NATURE_OF_BUSINESS,
                   CLIENT_CATEGORY =MM_CLIENT_CATEGORY,
                   CLIENT_GROUP = M_CLIENT_GROUP,
                   JOINT_HOLDER_APPLICABLE = MM_JOINT_HOLDER_APPLICABLE,
                   FULL_NAME_JOINT_HOLDER = M_FULL_NAME_JOINT_HOLDER
            WHERE  A.CLIENT_CODE = M_CLIENT_CODE;
            
            
            INSERT INTO DN_REF_PORTFOLIO_BK
                SELECT A.*
                FROM   DN_REF_PORTFOLIO A
                WHERE  A.PORTFOLIO_CODE = M_CLIENT_CODE;
            
            UPDATE DN_REF_PORTFOLIO A
            SET    A.PF_NAME                = M_FULL_NAME,
                   A.ADD_IDENTIFICATION     = M_ADDRESS_LINE_1,
                   A.ADD_LOCATION           = M_ADDRESS_LINE_2,
                   A.ADD_CITY               = M_CITY,
                   A.ADD_COUNTRY            = DN_GET_CITY_DETAILS(M_CITY, 'CITY_CODE', 'COUNTRY_CODE'),
                   A.POSTAL_CODE            = '99999',--M_CITY,
                   A.DATE_INC_BIRTH         = TO_DATE(M_DATE_OF_BIRTH, 'DD-MM-YYYY'),
                   A.LAST_MODIFIED          = SYSDATE,
                   A.MOD_USER               = M_USER,
                   A.MOD_DATE               = SYSDATE
            WHERE  A.PORTFOLIO_CODE         = M_CLIENT_CODE;
            
        END IF;
        
        
        /* Backup And Delete Data In Dynamic Sections */
        /* Contact Persons */
        DELETE FROM DN_MAS_CLIENT_CONT_INFO A
        WHERE       A.CLIENT_CODE = M_CLIENT_CODE;
        
        /* Directors / Partners / Shareholders */
        DELETE FROM DN_MAS_CLIENT_DIRECT_INFO A
        WHERE       A.CLIENT_CODE = M_CLIENT_CODE;
        
        /* Subsidiaries & Associated Companies */
        DELETE FROM DN_MAS_CLIENT_COMPANY_INFO A
        WHERE       A.CLIENT_CODE = M_CLIENT_CODE;
        
        /* Auditors Details */
        DELETE FROM DN_MAS_CLIENT_AUDIT_INFO A
        WHERE       A.CLIENT_CODE = M_CLIENT_CODE;
        
        /* Auditors Details Report */
        DELETE FROM DN_MAS_AUDITOR_DETAILS A
        WHERE       A.CODE = M_CLIENT_CODE;
        
        /* Accounts and Banking Details */
        DELETE FROM DN_MAS_CLIENT_BANKS_INFO A
        WHERE       A.CLIENT_CODE = M_CLIENT_CODE;
        
        /* Details of Credit Facilities */
        DELETE FROM DN_MAS_CLIENT_CRFAC_INFO A
        WHERE       A.CLIENT_CODE = M_CLIENT_CODE;
        
        /* Stock Brokering Accounts */
        DELETE FROM DN_MAS_CLIENT_SB_ACC_INFO A
        WHERE       A.CLIENT_CODE = M_CLIENT_CODE;
        
    END IF;
    
END ;

/
