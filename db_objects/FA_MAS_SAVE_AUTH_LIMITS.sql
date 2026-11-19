--------------------------------------------------------
--  DDL for Procedure FA_MAS_SAVE_AUTH_LIMITS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."FA_MAS_SAVE_AUTH_LIMITS" 
(
    M_USER_ID                           FA_CO_MAS_AUTH_LIMITS.USER_ID % TYPE,
    M_PRODUCT_CODE                      FA_CO_MAS_AUTH_LIMITS.PRODUCT_CODE % TYPE,
    M_AUTH_LIMIT                        FA_CO_MAS_AUTH_LIMITS.AUTH_LIMIT % TYPE,
    M_USER                              FA_CO_MAS_AUTH_LIMITS.ENT_USER % TYPE,
    M_NUM                               INT,
    M_STATUS                            VARCHAR2
)

AS

-- CODE BY THAMALI JAYATUNGA ON 2010.05.24

BEGIN
    
    DN_VALIDATE_SAVE_RIGHTS(M_USER,'WD_Users_Lending_limits');
    
    IF M_NUM = 0 THEN
        
        INSERT INTO FA_CO_MAS_AUTH_LIMITS_BK (
            USER_ID,
            PRODUCT_CODE,
            AUTH_LIMIT,
            ENT_USER,
            ENT_DATE,
            MOD_USER,
            MOD_DATE,
            ACTIVE_STATUS
        )
            SELECT USER_ID,
                   PRODUCT_CODE,
                   AUTH_LIMIT,
                   ENT_USER,
                   ENT_DATE,
                   MOD_USER,
                   MOD_DATE,
                   ACTIVE_STATUS
            FROM   FA_CO_MAS_AUTH_LIMITS
            WHERE UPPER(USER_ID) = UPPER(M_USER_ID);
        
        DELETE FROM FA_CO_MAS_AUTH_LIMITS
        WHERE       UPPER(USER_ID) = UPPER(M_USER_ID);
        
    END IF;
    
    IF M_STATUS = 'TRUE' THEN
        
        INSERT INTO FA_CO_MAS_AUTH_LIMITS (
            USER_ID,
            PRODUCT_CODE,
            AUTH_LIMIT,
            ENT_DATE,
            ENT_USER,
            ACTIVE_STATUS
        )
        VALUES (
            M_USER_ID,
            M_PRODUCT_CODE,
            M_AUTH_LIMIT,
            SYSDATE,
            M_USER,
            'Y'
        );
        
    END IF;
    
END;

/
