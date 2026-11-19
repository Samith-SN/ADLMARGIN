--------------------------------------------------------
--  DDL for Function DN_GET_CITY_DETAILS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_CITY_DETAILS" (
    M_CODE                               IN VARCHAR2,                           /* 01 */
    M_SEND_TYPE                          IN VARCHAR2,                           /* 02 */
    M_RETURN_TYPE                        IN VARCHAR2                            /* 03 */
)

RETURN VARCHAR2

AS
    
    MM_RETURN_VALUE                         VARCHAR2(200);
    
BEGIN
    
    IF M_SEND_TYPE = 'CITY_CODE' THEN
        
        IF M_RETURN_TYPE = 'CITY_NAME' THEN
            
            SELECT A.CITY_DESC
            INTO   MM_RETURN_VALUE
            FROM   DN_REF_CITIES A
            WHERE  A.CITY_CODE = M_CODE;
            
        ELSIF M_RETURN_TYPE = 'DISTRICT_CODE' THEN
            
            SELECT A.DISTRICT_CODE
            INTO   MM_RETURN_VALUE
            FROM   DN_REF_CITIES A
            WHERE  A.CITY_CODE = M_CODE;
            
        ELSIF M_RETURN_TYPE = 'DISTRICT_NAME' THEN
            
            SELECT B.DISTRICT_DESC
            INTO   MM_RETURN_VALUE
            FROM   DN_REF_CITIES A,
                   DN_REF_DISTRICTS B
            WHERE  A.DISTRICT_CODE = B.DISTRICT_CODE
            AND    A.CITY_CODE = M_CODE;
            
        ELSIF M_RETURN_TYPE = 'PROVINCE_CODE' THEN
            
            SELECT B.PROVINCE_CODE
            INTO   MM_RETURN_VALUE
            FROM   DN_REF_CITIES A,
                   DN_REF_DISTRICTS B
            WHERE  A.DISTRICT_CODE = B.DISTRICT_CODE
            AND    A.CITY_CODE = M_CODE;
            
        ELSIF M_RETURN_TYPE = 'PROVINCE_NAME' THEN
            
            SELECT C.PROVINCE_DESC
            INTO   MM_RETURN_VALUE
            FROM   DN_REF_CITIES A,
                   DN_REF_DISTRICTS B,
                   DN_REF_PROVINCES C
            WHERE  A.DISTRICT_CODE = B.DISTRICT_CODE
            AND    B.PROVINCE_CODE = C.PROVINCE_CODE
            AND    A.CITY_CODE = M_CODE;
            
        ELSIF M_RETURN_TYPE = 'COUNTRY_CODE' THEN
            
            SELECT C.COUNTRY_CODE
            INTO   MM_RETURN_VALUE
            FROM   DN_REF_CITIES A,
                   DN_REF_DISTRICTS B,
                   DN_REF_PROVINCES C
            WHERE  A.DISTRICT_CODE = B.DISTRICT_CODE
            AND    B.PROVINCE_CODE = C.PROVINCE_CODE
            AND    A.CITY_CODE = M_CODE;
            
        ELSIF M_RETURN_TYPE = 'COUNTRY_NAME' THEN
            
            SELECT D.COUNTRY_DESC
            INTO   MM_RETURN_VALUE
            FROM   DN_REF_CITIES A,
                   DN_REF_DISTRICTS B,
                   DN_REF_PROVINCES C,
                   DN_REF_COUNTRIES D
            WHERE  A.DISTRICT_CODE = B.DISTRICT_CODE
            AND    B.PROVINCE_CODE = C.PROVINCE_CODE
            AND    C.COUNTRY_CODE = D.COUNTRY_CODE
            AND    A.CITY_CODE = M_CODE;
            
        END IF;
        
    END IF;
    
    
    RETURN NVL(MM_RETURN_VALUE, '-');
    
END DN_GET_CITY_DETAILS;

/
