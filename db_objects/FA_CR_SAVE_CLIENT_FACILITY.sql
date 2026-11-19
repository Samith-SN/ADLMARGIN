--------------------------------------------------------
--  DDL for Procedure FA_CR_SAVE_CLIENT_FACILITY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."FA_CR_SAVE_CLIENT_FACILITY" (  
    
    M_FACILITY_NO                       IN OUT DN_REF_PORTFOLIO.PORTFOLIO_CODE % TYPE,                        -- 01
    M_CLIENT_CODE                              DN_REF_PORTFOLIO.CLIENT_CODE % TYPE,                           -- 02
    M_FACILITY_MGR_CODE                        DN_REF_PORTFOLIO.FACILITY_MGR_CODE % TYPE,                     -- 03
    M_FA_PRODUCT_CODE                          DN_REF_PORTFOLIO.FA_PRODUCT_CODE % TYPE,                       -- 04
    M_FEE_PACK_CODE                            DN_REF_PORTFOLIO.FEE_PACK_CODE % TYPE,                         -- 05
    M_CREDIT_LIMIT                             DN_REF_PORTFOLIO.LIMIT % TYPE,      --CREDIT_LIMIT             -- 06
    M_CREDIT_PERIOD                            NUMBER,--DN_REF_PORTFOLIO.CREDIT_PERIOD % TYPE,                -- 07
    M_TOLERANCE_CREDIT_PERIOD                  NUMBER,--DN_REF_PORTFOLIO.TOLERANCE_CREDIT_PERIOD % TYPE,      -- 08
    M_RESERVE_MARGIN                           NUMBER,--DN_REF_PORTFOLIO.RESERVE_MARGIN % TYPE,               -- 09
    M_INT_RATE                                 DN_REF_PORTFOLIO.RATE % TYPE,                                  -- 10
    M_FACILITY_START_DATE                      VARCHAR2,                                                      -- 11
    M_FACILITY_END_DATE                        VARCHAR2,                                                      -- 12
    M_USER                                     DN_REF_PORTFOLIO.ENT_USER % TYPE,                              -- 13
    M_SCREEN_2                                 VARCHAR2,                                                      -- 14
    M_ENTRY_COMMENTS                           VARCHAR2,--DN_REF_PORTFOLIO.ENTRY_COMMENTS % TYPE,             -- 15
    M_CLIENT_ACC_CODE                          DN_REF_PORTFOLIO.ACC_NO % TYPE,                                -- 16
    M_RETENTION                                DN_REF_PORTFOLIO.RETENTION % TYPE,                             -- 17
    M_AVAILABILITY                             DN_REF_PORTFOLIO.USER_TYPE % TYPE,  --AVAILABILITY             -- 18
    M_ESTIMATED_RETURN                         NUMBER,  --DN_REF_PORTFOLIO.ESTIMATED_RETURN % TYPE,           -- 19
    M_COST_ESTIMATION                          NUMBER,  --DN_REF_PORTFOLIO.COST_ESTIMATION % TYPE,            -- 20
    M_COLLECTION_ROUTE_CODE                    NUMBER,  --DN_REF_PORTFOLIO.COLLECTION_ROUTE_CODE % TYPE,      -- 21
    M_DATE_APP_RECEIVED                        VARCHAR2,                                                      -- 22
    M_DATE_OF_INSPECTION                       VARCHAR2,                                                      -- 23
    M_DATE_INFO_COMPLETED                      VARCHAR2,                                                      -- 24
    M_DOC_CHECK_LIST                           DN_REF_PORTFOLIO.DOC_CHECK_LIST % TYPE,                        -- 25
    M_TEMP_FACILITY_NO                         DN_REF_PORTFOLIO.PORTFOLIO_CODE % TYPE,                        -- 26
    M_COLLECTION_OFFICER                       VARCHAR2, --DN_REF_PORTFOLIO.COLLECTION_OFFICER % TYPE,        -- 27
    M_CLIENT_MANAGER                           DN_REF_PORTFOLIO.FACILITY_MGR_CODE % TYPE,                     -- 28
    M_CURRENCY                                 DN_REF_PORTFOLIO.CURRENCY % TYPE,                   -- 29
    M_DEBTOR_CONCENTRATION                     VARCHAR2, -- DN_REF_PORTFOLIO.DEBTOR_CONCENTRATION % TYPE,     -- 30
    M_ADVANCE                                  VARCHAR2, --DN_REF_PORTFOLIO.ADVANCE % TYPE,                   -- 31
    M_COLLECTION_DETAILS                       VARCHAR2, --DN_REF_PORTFOLIO.COLLECTION_DETAILS % TYPE,        -- 32
    M_DISCOUNT_TYPE                            DN_REF_PORTFOLIO.RATE_TYPE % TYPE, --DN_REF_PORTFOLIO.DISCOUNT_TYPE % TYPE,              -- 33
    M_OTHER_COMMENTS                           VARCHAR2, --DN_REF_PORTFOLIO.OTHER_COMMENTS % TYPE,             -- 34
    M_UNREALIZED_CHEQUE_PERC                   VARCHAR2, --DN_REF_PORTFOLIO.UNREALIZED_CHEQUE_PERC % TYPE,     -- 35
    M_TEMP_FACILITY_NO_BENE                    VARCHAR2,                                                       -- 36
    M_TEMP_FACILITY_NO_STAND                   VARCHAR2,                                                       -- 37
    M_TEMP_FACILITY_NO_SIG                     VARCHAR2,                                                       -- 38
    M_REFACT_TYPE                              VARCHAR2, --DN_REF_PORTFOLIO.REFACT_TYPE % TYPE,                -- 39
    M_FLAT_SLAB                                DN_REF_PORTFOLIO.FLAT_SLAB%TYPE,                                -- 40
    M_BASE_TYPE                                VARCHAR2, --DN_REF_PORTFOLIO.BASE_TYPE%TYPE,                    -- 41
    M_PREM_DISC                                VARCHAR2,                                                       -- 42  
    M_EXISTING_FACILITY_NO                     DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE,                           -- 43
    M_OVER_PAID_DISCOUNT                       DN_REF_PORTFOLIO.OVER_PAID_INT_RATE%TYPE,                       -- 44 
    M_NEW_FACILITY_STATUS                      DN_REF_PORTFOLIO.ACTIVE_STATUS%TYPE,--NEW_FACILITY_STATUS       -- 45
    M_RESET_INTERVAL                           NUMBER,--DN_REF_PORTFOLIO.RESET_INTERVAL%TYPE,                  -- 46
    M_RESET_DATE                               VARCHAR2,                                                       -- 47
    M_LOCATION_CODE                            DN_REF_PORTFOLIO.LOCATION_CODE%TYPE,                            -- 48
    M_MKT_EXECUTIVE                            DN_REF_PORTFOLIO.MKT_EXECUTIVE%TYPE,                            -- 49
    M_TEMP_FACILITY_NO_APP                     VARCHAR2,                                                       -- 50
    M_MANAGEMENT_FEE                           DN_REF_PORTFOLIO.MANAGEMENT_FEE%TYPE,                           -- 51
    M_REASSIGN_TYPE                            VARCHAR2,--DN_REF_PORTFOLIO.REASSIGN_TYPE%TYPE,                 -- 52          
    M_REASSIGN_VALUE                           NUMBER,  --DN_REF_PORTFOLIO.REASSIGN_VALUE%TYPE,                -- 53
    M_RANDOM_DISAPP_PER                        NUMBER,  --DN_REF_PORTFOLIO.RANDOM_DISAPP_PER%TYPE,             -- 54
    M_MIN_INVOICE_VALUE                        NUMBER,  --DN_REF_PORTFOLIO.MIN_INVOICE_VALUE%TYPE,             -- 55
    M_MAX_INVOICE_VALUE                        NUMBER,  --DN_REF_PORTFOLIO.MAX_INVOICE_VALUE%TYPE,             -- 56
    M_MAX_DEBTOR_LIMIT                         NUMBER,  --DN_REF_PORTFOLIO.MAX_DEBTOR_LIMIT%TYPE,              -- 57
    M_PREVIOUS_PRODUCT                         VARCHAR2,                                                       -- 58
    M_NEW_PRODUCT                              VARCHAR2,                                                       -- 59
    M_NEW_FACILITY_NO                   IN OUT DN_REF_PORTFOLIO.PORTFOLIO_CODE % TYPE,                         -- 60
    M_AVG_DEBTOR_LIMIT                         NUMBER,--DN_REF_PORTFOLIO.AVG_DEBTOR_LIMIT % TYPE               -- 61
    M_ADV_CODE                                 DN_REF_PORT_ADV.ADV_CODE%TYPE,                                  -- 62
    M_BROKER_CODE                              DN_REF_PORTFOLIO.BROKER_CODE%TYPE,                              -- 63
    M_CDS_ACC_NO                               DN_REF_PORTFOLIO.CDS_ACC_NO%TYPE                                -- 64       
)

AS
    
    M_IMMOVABLE_ASSETS_COUNT                   NUMBER (5);
    M_IMMOVABLE_ASSETS_IMG_PATH                VARCHAR2 (200);
    M_MOVABLE_ASSETS_COUNT                     NUMBER (5);
    M_MOVABLE_ASSETS_IMG_PATH                  VARCHAR2 (200);
    M_GUARANTEE_COUNT                          NUMBER (5);
    M_GUARANTEE_IMG_PATH                       VARCHAR2 (200);
    M_SECURITY_COUNT                           NUMBER (5);
    M_SECURITY_IMG_PATH                        VARCHAR2 (200);
    M_SHARE_COUNT                              NUMBER (5);
    M_SHARE_IMG_PATH                           VARCHAR2 (200);
    M_STOCK_COUNT                              NUMBER (5);
    M_STOCK_IMG_PATH                           VARCHAR2 (200);
    M_DEPOSIT_COUNT                            NUMBER (5);
    M_DEPOSIT_IMG_PATH                         VARCHAR2 (200);
    M_LC_COUNT                                 NUMBER (5);
    M_LC_IMG_PATH                              VARCHAR2 (200);
    M_PN_COUNT                                 NUMBER (5);
    M_PN_IMG_PATH                              VARCHAR2 (200);
    M_MODIFIED_RECORD                          VARCHAR2 (1);
    M_RATE                                     NUMBER(5,2);
    M_PREM_DISC_VALUE                          NUMBER(25,4);
    M_PREFIX                                   VARCHAR2 (3); 
    M_PREFIX_PREVIOUS                          VARCHAR2 (3);
    M_ENTER_USER                               DN_REF_PORTFOLIO.ENT_USER%TYPE;
    M_ENTER_DATE                               DN_REF_PORTFOLIO.CREATED_DATE%TYPE;
    M_SCREEN                                   VARCHAR2(5);
    M_PREVIOUS_FACILITY_NO                     DN_REF_PORTFOLIO.PORTFOLIO_CODE % TYPE;
     
    M_PF_NAME                                  DN_REF_PORTFOLIO.PF_NAME%TYPE;
    M_POSTAL_CODE                              DN_REF_PORTFOLIO.POSTAL_CODE%TYPE;
    M_MBFSL_SECT_CODE                          DN_REF_PORTFOLIO.MBFSL_SECT_CODE%TYPE;
    M_TOT_EXP_LIMIT                            DN_REF_PORTFOLIO.TOT_EXP_LIMIT%TYPE;
    M_PERC_TOT_EXP                             DN_REF_PORTFOLIO.PERC_TOT_EXP%TYPE;
    M_ADD_IDENTIFICATION                       DN_REF_PORTFOLIO.ADD_IDENTIFICATION%TYPE;
    M_ADD_LOCATION                             DN_REF_PORTFOLIO.ADD_LOCATION%TYPE;
    M_ADD_CITY                                 DN_REF_PORTFOLIO.ADD_CITY%TYPE;
    M_LAST_DAILY                               DATE;
    MM_FA_PRODUCT_CODE                         DN_REF_PORTFOLIO.FA_PRODUCT_CODE%TYPE;    
    
    CURSOR M_CURSOR IS
    SELECT *
    FROM   DN_REF_PORTFOLIO
    WHERE  PORTFOLIO_CODE=M_FACILITY_NO
    AND    ACTIVE_STATUS= 'Y';
    
BEGIN
  -- RAISE_APPLICATION_ERROR (-20001,M_MODIFIED_RECORD||'***'); 
   -- AF_CO_VALIDATE_SAVE_RIGHTS('FA_CR_CREATE_CLIENT_FACILITY', M_USER);
    -- RAISE_APPLICATION_ERROR (-20001,M_CDS_ACC_NO||'***'); 
   
   MM_FA_PRODUCT_CODE:='P_MGT';
   
  BEGIN 
    
  SELECT a.FULL_NAME,REGISTERED_ADDRESS1,REGISTERED_ADDRESS2,B.CITY_DESC INTO M_PF_NAME,M_ADD_IDENTIFICATION,M_ADD_LOCATION,M_ADD_CITY
  FROM DN_MAS_CLIENT A ,DN_REF_CITIES B WHERE CLIENT_CODE=M_CLIENT_CODE AND A.CITY_CODE=B.CITY_CODE;
 
   EXCEPTION
   WHEN NO_DATA_FOUND THEN
   
   BEGIN 
     SELECT a.FULL_NAME,'' REGISTERED_ADDRESS1,''  REGISTERED_ADDRESS2,''  CITY_DESC INTO M_PF_NAME,M_ADD_IDENTIFICATION,M_ADD_LOCATION,M_ADD_CITY
     FROM DN_MAS_CLIENT A  WHERE CLIENT_CODE=M_CLIENT_CODE;
    
     EXCEPTION
     WHEN NO_DATA_FOUND THEN
     
      SELECT '' FULL_NAME,'' REGISTERED_ADDRESS1,''  REGISTERED_ADDRESS2,''  CITY_DESC INTO M_PF_NAME,M_ADD_IDENTIFICATION,M_ADD_LOCATION,M_ADD_CITY
       FROM dual;
    END; 
  END;
 
 
 M_MBFSL_SECT_CODE := 'MBSE';
 M_TOT_EXP_LIMIT   := 0; 
 M_PERC_TOT_EXP    := 0;   
 M_POSTAL_CODE     := 99999;
    
    M_SCREEN :=M_SCREEN_2;
  
    IF M_FACILITY_NO IS NULL THEN
    
        SELECT DN_GET_AUTO_MT_NO(M_FACILITY_NO)
        INTO   M_FACILITY_NO
        FROM   DUAL;
        
         --added by ns on 30-11-2010 ---------------
        SELECT A.SHORT_CODE INTO M_PREFIX
        FROM   FA_CO_MAS_PRODUCT A
        WHERE  A.FA_PRODUCT_CODE=MM_FA_PRODUCT_CODE;
        
        --M_FACILITY_NO := 'FC' || M_FACILITY_NO;
      --  M_FACILITY_NO := M_PREFIX || M_FACILITY_NO; --added by ns on 30-11-2010 
         M_FACILITY_NO :=  M_FACILITY_NO; --mod by waruna on 30-11-2010 
    END IF;
    
    M_RATE              :=0;
    M_PREM_DISC_VALUE   :=0;

    IF (M_DISCOUNT_TYPE ='V') THEN
       SELECT RATE INTO M_RATE FROM FA_CO_MAS_RATES WHERE RATE_TYPE = M_BASE_TYPE;
       IF M_PREM_DISC='P' THEN
          M_PREM_DISC_VALUE := M_RATE;
       ELSIF M_PREM_DISC='D' THEN
          M_PREM_DISC_VALUE := -(M_RATE);
       END IF;
    END IF;
    
    IF UPPER(M_SCREEN) = 'EDIT' THEN
        IF (M_PREVIOUS_PRODUCT <> M_NEW_PRODUCT) THEN
        
            SELECT A.SHORT_CODE INTO M_PREFIX
            FROM   FA_CO_MAS_PRODUCT A
            WHERE  A.FA_PRODUCT_CODE=M_NEW_PRODUCT;
            
            SELECT A.SHORT_CODE INTO M_PREFIX_PREVIOUS
            FROM   FA_CO_MAS_PRODUCT A
            WHERE  A.FA_PRODUCT_CODE=M_PREVIOUS_PRODUCT;
            
            M_PREVIOUS_FACILITY_NO := M_FACILITY_NO;
            M_FACILITY_NO := REPLACE(M_FACILITY_NO,M_PREFIX_PREVIOUS,M_PREFIX);
            M_SCREEN := 'NEW';
            
           /* UPDATE  FA_CR_PRO_CLIENT_FACILITY
            SET     FACILITY_STATUS   = 'C',
                    APPROVAL_COMMENTS = 'Facility type edited',
                    APP_USER          = M_USER,
                    APP_DATE          = SYSDATE,
                    MOD_USER          = M_USER,
                    MOD_DATE          = SYSDATE
            WHERE UPPER(FACILITY_NO)  = UPPER(M_PREVIOUS_FACILITY_NO);

            INSERT INTO FA_CR_PRO_APPROVAL_DETAIL
            (CLIENT_CODE,FACILITY_NO,SCREEN_NAME,APPROVAL_DESC,APP_STATUS,APP_COMMENTS,ENT_USER,ENT_DATE)
            VALUES
            (M_CLIENT_CODE,M_PREVIOUS_FACILITY_NO,'FA_CR_CREATE_CLIENT_FACILITY',M_PREVIOUS_FACILITY_NO,'C','Facility type edited',M_USER,SYSDATE);
       */ 
       END IF;
        M_NEW_FACILITY_NO := M_FACILITY_NO;
        
    END IF;
    
    IF UPPER(M_SCREEN) = 'NEW' THEN
    
        INSERT INTO FA_CR_PRO_APPROVAL_DETAIL
        (CLIENT_CODE,FACILITY_NO,SCREEN_NAME,APPROVAL_DESC,APP_STATUS,APP_COMMENTS,ENT_USER,ENT_DATE)
        VALUES
        (M_CLIENT_CODE,M_FACILITY_NO,'FA_CR_CREATE_CLIENT_FACILITY_NEW',M_FACILITY_NO,'N','FACILITY_NEW',M_USER,SYSDATE);
 
  --RAISE_APPLICATION_ERROR (-20001,M_NEW_FACILITY_STATUS||'***');
  
        INSERT INTO DN_REF_PORTFOLIO (
            PORTFOLIO_CODE,
            CLIENT_CODE,
            FACILITY_MGR_CODE,
            FA_PRODUCT_CODE,
            FEE_PACK_CODE,
            LIMIT,--6
            --CREDIT_PERIOD,
            --TOLERANCE_CREDIT_PERIOD,
            --RESERVE_MARGIN,
            RATE,
            FACILITY_START_DATE,
            NEST_REVIEW,
            --FACILITY_STATUS,
            ENT_USER, --10
            CREATED_DATE,
            ENTRY_COMMENTS,
            ACC_NO,
            RETENTION,
            USER_TYPE,
            --ESTIMATED_RETURN,
            --COST_ESTIMATION,
            --COLLECTION_ROUTE_CODE,
            DATE_APP_RECEIVED,
            DATE_OF_INSPECTION,
            DATE_INFO_COMPLETED,
            DOC_CHECK_LIST,
            --COLLECTION_OFFICER,
            CURRENCY,
            --DEBTOR_CONCENTRATION,
            --ADVANCE,
            --COLLECTION_DETAILS,
            RATE_TYPE,
            OTHER_COMMENTS,
            --UNREALIZED_CHEQUE_PERC,
            --REFACT_TYPE,
            FLAT_SLAB,
            --BASE_TYPE,
            --PREM_DISC,
            --EXISTING_FACILITY_NO,
            OVER_PAID_INT_RATE,
            ACTIVE_STATUS,
            RESET_INTERVAL,
            RESET_DATE,
            LOCATION_CODE,
            MKT_EXECUTIVE,
            MANAGEMENT_FEE,
           -- REASSIGN_TYPE,
           -- REASSIGN_VALUE,
           -- RANDOM_DISAPP_PER,
           -- MIN_INVOICE_VALUE,
           -- MAX_INVOICE_VALUE,
           -- MAX_DEBTOR_LIMIT,
           -- PREVIOUS_FACILITY_NO,
           -- AVG_DEBTOR_LIMIT
           
           PF_NAME,
           POSTAL_CODE,
           ADD_IDENTIFICATION,
           ADD_LOCATION,
           ADD_CITY,
           MBFSL_SECT_CODE,
           TOT_EXP_LIMIT,
           PERC_TOT_EXP,
           BROKER_CODE,
           CDS_ACC_NO,
           FACILITY_STATUS  
        )
        VALUES (
            M_FACILITY_NO,
            M_CLIENT_CODE,
            M_FACILITY_MGR_CODE,
            MM_FA_PRODUCT_CODE,
            M_FEE_PACK_CODE,
            M_CREDIT_LIMIT,
            --M_CREDIT_PERIOD,
            --M_TOLERANCE_CREDIT_PERIOD,
            --M_RESERVE_MARGIN,
            M_INT_RATE/100,  --change by waruna 2012-01-4
            TO_DATE(M_FACILITY_START_DATE, 'DD-MM-YYYY'),
            TO_DATE(M_FACILITY_END_DATE, 'DD-MM-YYYY'),
            M_USER,
            --M_USER,
            SYSDATE,
            M_ENTRY_COMMENTS,
            M_CLIENT_ACC_CODE,
            M_RETENTION,
            M_AVAILABILITY,
            --M_ESTIMATED_RETURN,
            --M_COST_ESTIMATION,
            --M_COLLECTION_ROUTE_CODE,
            TO_DATE(M_DATE_APP_RECEIVED, 'DD-MM-YYYY'),
            TO_DATE(M_DATE_OF_INSPECTION, 'DD-MM-YYYY'),
            TO_DATE(M_DATE_INFO_COMPLETED, 'DD-MM-YYYY'),
            M_DOC_CHECK_LIST,
            --M_COLLECTION_OFFICER,
            M_CURRENCY,
            --M_DEBTOR_CONCENTRATION,
            --M_ADVANCE,
            --M_COLLECTION_DETAILS,
            M_DISCOUNT_TYPE,
            M_OTHER_COMMENTS,
           -- M_UNREALIZED_CHEQUE_PERC,
            --M_REFACT_TYPE,
            M_FLAT_SLAB,
            --M_BASE_TYPE,
            --M_PREM_DISC_VALUE,
            --M_EXISTING_FACILITY_NO,
            M_OVER_PAID_DISCOUNT/100,
            'E',--M_NEW_FACILITY_STATUS,
            M_RESET_INTERVAL,
            TO_DATE(M_RESET_DATE,'DD-MM-YYYY'),
            M_LOCATION_CODE,
            M_MKT_EXECUTIVE,
            M_MANAGEMENT_FEE,
           --   M_REASSIGN_TYPE,
           -- M_REASSIGN_VALUE,
           -- M_RANDOM_DISAPP_PER,
           -- M_MIN_INVOICE_VALUE,
           -- M_MAX_INVOICE_VALUE,
           -- M_MAX_DEBTOR_LIMIT,
           -- M_PREVIOUS_FACILITY_NO,
           -- M_AVG_DEBTOR_LIMIT
           M_PF_NAME,
           M_POSTAL_CODE,
           M_ADD_IDENTIFICATION,
           M_ADD_LOCATION,
           M_ADD_CITY,
           M_MBFSL_SECT_CODE,
           M_TOT_EXP_LIMIT,
           M_PERC_TOT_EXP,
           M_BROKER_CODE,
           M_CDS_ACC_NO,
           M_NEW_FACILITY_STATUS 
        );
        DN_PORT_ADV_SAVE(M_FACILITY_NO,M_ADV_CODE, UPPER(M_SCREEN));
        
         /* Add to TEMP For Approval*/
        INSERT INTO DN_REF_PORTFOLIO_TEMP (
        SELECT * FROM DN_REF_PORTFOLIO 
        WHERE PORTFOLIO_CODE = M_FACILITY_NO 
        );
        
        
        --- ADD BY WARUNA --2012-02-01-----------------------
        SELECT A.LAST_DAILY INTO M_LAST_DAILY    FROM DN_SYS_PARAMETER A;
        
        INSERT INTO DN_TEMP_MARGIN_CALL
        (STATUS,SECURITY_CODE,FACE_VAL,MATURITY_DATE,POSITION,PORTFOLIO_CODE,INST_TYPE,MT_PERCENT,REPO_LEG2,PORT_LIMIT)
        VALUES
        ('REP','-',0,M_LAST_DAILY+1,'UPPER' ,M_FACILITY_NO,'-',0,0,M_CREDIT_LIMIT);

        ---END WARUNA --2012-02-01--------------------------
        /* MOVE TEMPORARY DATA IN POPUPS TO PERMERNANT TABLES */
        
        /* IMMOVABLE ASSETS */
       /* 
          INSERT INTO FA_CR_FACILITY_IA_INFO
            SELECT *
            FROM   FA_CR_FACILITY_IA_INFO_TMP
            WHERE  TEMP_FACILITY_NO = M_TEMP_FACILITY_NO;
        
        UPDATE FA_CR_FACILITY_IA_INFO
        SET    FACILITY_NO = M_FACILITY_NO
        WHERE  FACILITY_NO = M_TEMP_FACILITY_NO;

        DELETE FROM FA_CR_FACILITY_IA_INFO_TMP
        WHERE       TEMP_FACILITY_NO = M_TEMP_FACILITY_NO;
        */
        
        /* CHANGE IMAGE PATH IN 'IMMOVABLE ASSETS' */
        /*SELECT COUNT (*)
        INTO   M_IMMOVABLE_ASSETS_COUNT
        FROM   FA_CR_FACILITY_IA_INFO
        WHERE  FACILITY_NO = M_FACILITY_NO;
        
        FOR I IN 1 .. M_IMMOVABLE_ASSETS_COUNT LOOP
            SELECT IMAGE_PATH
            INTO   M_IMMOVABLE_ASSETS_IMG_PATH
            FROM   FA_CR_FACILITY_IA_INFO
            WHERE  FACILITY_NO = M_FACILITY_NO
            AND    IA_NO       = I;
            
            UPDATE FA_CR_FACILITY_IA_INFO
            SET    IMAGE_PATH  = REPLACE (M_IMMOVABLE_ASSETS_IMG_PATH, M_TEMP_FACILITY_NO, M_FACILITY_NO)
            WHERE  FACILITY_NO = M_FACILITY_NO
            AND    IA_NO       = I;
        END LOOP;*/
        /* CHANGE IMAGE PATH IN 'IMMOVABLE ASSETS' - [END] */
        
        /* MOVABLE ASSETS */
        /*INSERT INTO FA_CR_FACILITY_MA_INFO
            SELECT *
            FROM   FA_CR_FACILITY_MA_INFO_TMP
            WHERE  TEMP_FACILITY_NO = M_TEMP_FACILITY_NO;
        
        UPDATE FA_CR_FACILITY_MA_INFO
        SET FACILITY_NO = M_FACILITY_NO
        WHERE  FACILITY_NO = M_TEMP_FACILITY_NO;

        DELETE FROM FA_CR_FACILITY_MA_INFO_TMP
        WHERE       TEMP_FACILITY_NO = M_TEMP_FACILITY_NO;*/
        
        /* CHANGE IMAGE PATH IN 'MOVABLE ASSETS' */
        /*SELECT COUNT (*)
        INTO   M_MOVABLE_ASSETS_COUNT
        FROM   FA_CR_FACILITY_MA_INFO
        WHERE  FACILITY_NO = M_FACILITY_NO;
        
        FOR I IN 1 .. M_MOVABLE_ASSETS_COUNT LOOP
            SELECT IMAGE_PATH
            INTO   M_MOVABLE_ASSETS_IMG_PATH
            FROM   FA_CR_FACILITY_MA_INFO
            WHERE  FACILITY_NO = M_FACILITY_NO AND MA_NO = I;
            
            UPDATE FA_CR_FACILITY_MA_INFO
            SET IMAGE_PATH = REPLACE (
                                M_MOVABLE_ASSETS_IMG_PATH,
                                M_TEMP_FACILITY_NO,
                                M_FACILITY_NO
                            )
            WHERE  FACILITY_NO = M_FACILITY_NO AND MA_NO = I;
        END LOOP;*/
        /* CHANGE IMAGE PATH IN 'MOVABLE ASSETS' - [END] */
        
        /* BANK GUARANTEES */
       /* INSERT INTO FA_CR_FACILITY_BK_GU_INF
            SELECT *
            FROM   FA_CR_FACILITY_BK_GU_INF_TMP
            WHERE  TEMP_FACILITY_NO = M_TEMP_FACILITY_NO;
        
        UPDATE FA_CR_FACILITY_BK_GU_INF
        SET FACILITY_NO = M_FACILITY_NO
        WHERE  FACILITY_NO = M_TEMP_FACILITY_NO;
        
        DELETE FROM FA_CR_FACILITY_BK_GU_INF_TMP
        WHERE       TEMP_FACILITY_NO = M_TEMP_FACILITY_NO;*/
        
        /* CHANGE IMAGE PATH IN 'BANK GUARANTEES' */
        /*SELECT COUNT (*)
        INTO   M_GUARANTEE_COUNT
        FROM   FA_CR_FACILITY_BK_GU_INF
        WHERE  FACILITY_NO = M_FACILITY_NO;
        
        FOR I IN 1 .. M_GUARANTEE_COUNT LOOP
            SELECT IMAGE_PATH
            INTO   M_GUARANTEE_IMG_PATH
            FROM   FA_CR_FACILITY_BK_GU_INF
            WHERE  FACILITY_NO = M_FACILITY_NO AND BANK_GUARANTEE_NO = I;
            
            UPDATE FA_CR_FACILITY_BK_GU_INF
            SET IMAGE_PATH = REPLACE (
                                M_GUARANTEE_IMG_PATH,
                                M_TEMP_FACILITY_NO,
                                M_FACILITY_NO
                            )
            WHERE  FACILITY_NO = M_FACILITY_NO AND BANK_GUARANTEE_NO = I;
        END LOOP;*/
        /* CHANGE IMAGE PATH IN 'BANK GUARANTEES' - [END] */
        
        /* SECURITY CHEQUES */
        /*INSERT INTO FA_CR_FACILITY_SE_CH_INF
            SELECT *
            FROM   FA_CR_FACILITY_SE_CH_INF_TMP
            WHERE  TEMP_FACILITY_NO = M_TEMP_FACILITY_NO;
        
        UPDATE FA_CR_FACILITY_SE_CH_INF
        SET FACILITY_NO = M_FACILITY_NO
        WHERE  FACILITY_NO = M_TEMP_FACILITY_NO;
        
        DELETE FROM FA_CR_FACILITY_SE_CH_INF_TMP
        WHERE       TEMP_FACILITY_NO = M_TEMP_FACILITY_NO;*/
        
        /* CHANGE IMAGE PATH IN 'SECURITY CHEQUES' */
        /*SELECT COUNT (*)
        INTO   M_SECURITY_COUNT
        FROM   FA_CR_FACILITY_SE_CH_INF
        WHERE  FACILITY_NO = M_FACILITY_NO;
        
        FOR I IN 1 .. M_SECURITY_COUNT LOOP
            SELECT IMAGE_PATH
            INTO   M_SECURITY_IMG_PATH
            FROM   FA_CR_FACILITY_SE_CH_INF
            WHERE  FACILITY_NO = M_FACILITY_NO AND SECURITY_CHEQUE_NO = I;
            
            UPDATE FA_CR_FACILITY_SE_CH_INF
            SET IMAGE_PATH = REPLACE (
                                M_SECURITY_IMG_PATH,
                                M_TEMP_FACILITY_NO,
                                M_FACILITY_NO
                            )
            WHERE  FACILITY_NO = M_FACILITY_NO AND SECURITY_CHEQUE_NO = I;
        END LOOP;*/
        /* CHANGE IMAGE PATH IN 'SECURITY CHEQUES' - [END] */
        
        /* SHARES */
       /* INSERT INTO FA_CR_FACILITY_SHARE_INFO
            SELECT *
            FROM   FA_CR_FACILITY_SHARE_INFO_TM
            WHERE  TEMP_FACILITY_NO = M_TEMP_FACILITY_NO;
        
        UPDATE FA_CR_FACILITY_SHARE_INFO
        SET FACILITY_NO = M_FACILITY_NO
        WHERE  FACILITY_NO = M_TEMP_FACILITY_NO;
        
        DELETE FROM FA_CR_FACILITY_SHARE_INFO_TM
        WHERE       TEMP_FACILITY_NO = M_TEMP_FACILITY_NO;*/
        
         /* CHANGE IMAGE PATH IN 'SHARES' */
        /*SELECT COUNT (*)
        INTO   M_SHARE_COUNT
        FROM   FA_CR_FACILITY_SHARE_INFO
        WHERE  FACILITY_NO = M_FACILITY_NO;
        
        FOR I IN 1 .. M_SHARE_COUNT LOOP
            SELECT IMAGE_PATH
            INTO   M_SHARE_IMG_PATH
            FROM   FA_CR_FACILITY_SHARE_INFO
            WHERE  FACILITY_NO = M_FACILITY_NO AND SHARE_NO = I;
            
            UPDATE FA_CR_FACILITY_SHARE_INFO
            SET IMAGE_PATH = REPLACE (
                                M_SHARE_IMG_PATH,
                                M_TEMP_FACILITY_NO,
                                M_FACILITY_NO
                            )
            WHERE  FACILITY_NO = M_FACILITY_NO AND SHARE_NO = I;
        END LOOP;*/
        /* CHANGE IMAGE PATH IN 'SHARES' - [END] */       
        
        /* STOCKS */
       /* INSERT INTO FA_CR_FACILITY_STOCK_INFO
        SELECT *
        FROM   FA_CR_FACILITY_STOCK_INF_TMP
        WHERE  TMP_FACILITY_NO = M_TEMP_FACILITY_NO;

        UPDATE FA_CR_FACILITY_STOCK_INFO
        SET FACILITY_NO = M_FACILITY_NO
        WHERE  FACILITY_NO = M_TEMP_FACILITY_NO;

        DELETE FROM FA_CR_FACILITY_STOCK_INF_TMP
        WHERE       TMP_FACILITY_NO = M_TEMP_FACILITY_NO;*/

        /* CHANGE IMAGE PATH IN 'STOCKS' */
       /* SELECT COUNT (*)
        INTO   M_STOCK_COUNT
        FROM   FA_CR_FACILITY_STOCK_INFO
        WHERE  FACILITY_NO = M_FACILITY_NO;

        FOR I IN 1 .. M_SECURITY_COUNT LOOP
            SELECT IMAGE_PATH
            INTO   M_STOCK_IMG_PATH
            FROM   FA_CR_FACILITY_STOCK_INFO
            WHERE  FACILITY_NO = M_FACILITY_NO AND STOCK_NO = I;

            UPDATE FA_CR_FACILITY_STOCK_INFO
            SET IMAGE_PATH = REPLACE (
                                M_STOCK_IMG_PATH,
                                M_TEMP_FACILITY_NO,
                                M_FACILITY_NO
                            )
            WHERE  FACILITY_NO = M_FACILITY_NO AND STOCK_NO = I;
        END LOOP;*/
        /* CHANGE IMAGE PATH IN 'STOCKS' - [END] */

        /* DEPOSITS */
        /*INSERT INTO FA_CR_FACILITY_DEPO_INF
            SELECT *
            FROM   FA_CR_FACILITY_DEPO_INF_TMP
            WHERE  TEMP_FACILITY_NO = M_TEMP_FACILITY_NO;
        
        UPDATE FA_CR_FACILITY_DEPO_INF
        SET FACILITY_NO = M_FACILITY_NO
        WHERE  FACILITY_NO = M_TEMP_FACILITY_NO;
        
        DELETE FROM FA_CR_FACILITY_DEPO_INF_TMP
        WHERE       TEMP_FACILITY_NO = M_TEMP_FACILITY_NO;*/
        
        /* CHANGE IMAGE PATH IN 'FIXED DEPOSITS' */
        /*SELECT COUNT (*)
        INTO   M_DEPOSIT_COUNT
        FROM   FA_CR_FACILITY_DEPO_INF
        WHERE  FACILITY_NO = M_FACILITY_NO;

        FOR I IN 1 .. M_DEPOSIT_COUNT LOOP
            SELECT IMAGE_PATH
            INTO   M_DEPOSIT_IMG_PATH
            FROM   FA_CR_FACILITY_DEPO_INF
            WHERE  FACILITY_NO = M_FACILITY_NO AND DEPOSIT_NO = I;

            UPDATE FA_CR_FACILITY_DEPO_INF
            SET IMAGE_PATH = REPLACE (
                                M_DEPOSIT_IMG_PATH,
                                M_TEMP_FACILITY_NO,
                                M_FACILITY_NO
                            )
            WHERE  FACILITY_NO = M_FACILITY_NO AND DEPOSIT_NO = I;
        END LOOP;*/
        /* CHANGE IMAGE PATH IN 'FIXED DEPOSITS' - [END] */
        
        /* LETTER OF CREDIT */
       /* INSERT INTO FA_CR_FACILITY_LC_INFO
            SELECT *
            FROM   FA_CR_FACILITY_LC_INFO_TMP
            WHERE  TEMP_FACILITY_NO = M_TEMP_FACILITY_NO;
        
        UPDATE FA_CR_FACILITY_LC_INFO
        SET FACILITY_NO = M_FACILITY_NO
        WHERE  FACILITY_NO = M_TEMP_FACILITY_NO;
        
        DELETE FROM FA_CR_FACILITY_LC_INFO_TMP
        WHERE       TEMP_FACILITY_NO = M_TEMP_FACILITY_NO;*/
        
        /* CHANGE IMAGE PATH IN 'LETTER OF CREDIT' */
       /* SELECT COUNT (*)
        INTO   M_LC_COUNT
        FROM   FA_CR_FACILITY_LC_INFO
        WHERE  FACILITY_NO = M_FACILITY_NO;

        FOR I IN 1 .. M_LC_COUNT LOOP
            SELECT IMAGE_PATH
            INTO   M_LC_IMG_PATH
            FROM   FA_CR_FACILITY_LC_INFO
            WHERE  FACILITY_NO = M_FACILITY_NO AND LC_NO = I;

            UPDATE FA_CR_FACILITY_LC_INFO
            SET IMAGE_PATH = REPLACE (
                                M_LC_IMG_PATH,
                                M_TEMP_FACILITY_NO,
                                M_FACILITY_NO
                            )
            WHERE  FACILITY_NO = M_FACILITY_NO AND LC_NO = I;
        END LOOP;*/
        /* CHANGE IMAGE PATH IN 'LETTER OF CREDIT' - [END] */

        /* PROMISSORY NOTE */
        /*INSERT INTO FA_CR_FACILITY_PRO_NOTE_INFO
        SELECT *
        FROM   FA_CR_FACILITY_PRO_NOTE_TEMP
        WHERE  TEMP_FACILITY_NO = M_TEMP_FACILITY_NO;

        UPDATE FA_CR_FACILITY_PRO_NOTE_INFO
        SET FACILITY_NO = M_FACILITY_NO
        WHERE  FACILITY_NO = M_TEMP_FACILITY_NO;

        DELETE FROM FA_CR_FACILITY_PRO_NOTE_TEMP
        WHERE       TEMP_FACILITY_NO = M_TEMP_FACILITY_NO;
        */
        /* CHANGE IMAGE PATH IN 'PROMISSORY NOTE' */
       /* SELECT COUNT (*)
        INTO   M_PN_COUNT
        FROM   FA_CR_FACILITY_PRO_NOTE_INFO
        WHERE  FACILITY_NO = M_FACILITY_NO;

        FOR I IN 1 .. M_PN_COUNT LOOP
            SELECT IMAGE_PATH
            INTO   M_PN_IMG_PATH
            FROM   FA_CR_FACILITY_PRO_NOTE_INFO
            WHERE  FACILITY_NO = M_FACILITY_NO AND PROMISSORY_NOTE_NO = I;

            UPDATE FA_CR_FACILITY_PRO_NOTE_INFO
            SET IMAGE_PATH = REPLACE (
                                M_PN_IMG_PATH,
                                M_TEMP_FACILITY_NO,
                                M_FACILITY_NO
                            )
            WHERE  FACILITY_NO = M_FACILITY_NO AND PROMISSORY_NOTE_NO = I;
        END LOOP;*/
        /* CHANGE IMAGE PATH IN 'PROMISSORY NOTE' - [END] */
        
        /*BENEFICIARY*/
        /*IF (M_PREVIOUS_PRODUCT IS NULL) THEN

            INSERT INTO FA_CR_PRO_FACILITY_BENEF_BK
            SELECT *
            FROM   FA_CR_PRO_FACILITY_BENEFICIARY
            WHERE  TEMPORARY_FACILITY_NO = M_TEMP_FACILITY_NO_BENE;
        
            UPDATE  FA_CR_PRO_FACILITY_BENEFICIARY
            SET     CLIENT_CODE = M_CLIENT_CODE,
                    FACILITY_NO = M_FACILITY_NO,
                    MOD_USER = M_USER,
                    MOD_DATE = SYSDATE
            WHERE   TEMPORARY_FACILITY_NO = M_TEMP_FACILITY_NO_BENE;
        ELSE
        
            INSERT INTO FA_CR_PRO_FACILITY_BENEF_BK
            SELECT *
            FROM   FA_CR_PRO_FACILITY_BENEFICIARY
            WHERE  FACILITY_NO = M_PREVIOUS_FACILITY_NO;

            UPDATE  FA_CR_PRO_FACILITY_BENEFICIARY
            SET     FACILITY_NO = M_FACILITY_NO,
                    MOD_USER = M_USER,
                    MOD_DATE = SYSDATE
            WHERE   FACILITY_NO = M_PREVIOUS_FACILITY_NO;

        END IF;*/

        /*STANDING ORDER*/
        /*IF (M_PREVIOUS_PRODUCT IS NULL) THEN

            INSERT INTO FA_OP_MAS_STANDING_ORDER_BK
            SELECT *
            FROM   FA_OP_MAS_STANDING_ORDER
            WHERE  TEMPORARY_FACILITY_NO = M_TEMP_FACILITY_NO_STAND;
        
            UPDATE FA_OP_MAS_STANDING_ORDER
            SET CLIENT_CODE = M_CLIENT_CODE,
                FACILITY_NO = M_FACILITY_NO,
                MOD_USER = M_USER,
                MOD_DATE = SYSDATE
            WHERE  TEMPORARY_FACILITY_NO = M_TEMP_FACILITY_NO_STAND;
        ELSE
        
            INSERT INTO FA_OP_MAS_STANDING_ORDER_BK
            SELECT *
            FROM   FA_OP_MAS_STANDING_ORDER
            WHERE  FACILITY_NO = M_PREVIOUS_FACILITY_NO;

            UPDATE FA_OP_MAS_STANDING_ORDER
            SET    FACILITY_NO = M_FACILITY_NO,
                   MOD_USER = M_USER,
                   MOD_DATE = SYSDATE
            WHERE  FACILITY_NO = M_PREVIOUS_FACILITY_NO;
        END IF;*/

        
        /*SIGNATURE UPLOAD*/
       /* 
       IF (M_PREVIOUS_PRODUCT IS NULL) THEN
            INSERT INTO FA_CR_FACT_SIGNATURE_UPLOAD_BK
            SELECT *
            FROM   FA_CR_FACT_SIGNATURE_UPLOAD
            WHERE  TEMPORARY_FACILITY_NO = M_TEMP_FACILITY_NO_SIG;
        
            UPDATE FA_CR_FACT_SIGNATURE_UPLOAD
            SET CLIENT_CODE = M_CLIENT_CODE,
                FACILITY_NO = M_FACILITY_NO,
                MOD_USER = M_USER,
                MOD_DATE = SYSDATE
            WHERE  TEMPORARY_FACILITY_NO = M_TEMP_FACILITY_NO_SIG;
            */
        /* Change Image Path In 'Signature Upload' */

      /*  FOR X IN (
            SELECT SIGNATURE_CODE,IMAGE_PATH
            FROM   FA_CR_FACT_SIGNATURE_UPLOAD
            WHERE  FACILITY_NO = M_FACILITY_NO
            ) LOOP
            UPDATE FA_CR_FACT_SIGNATURE_UPLOAD
            SET IMAGE_PATH = REPLACE (
                                X.IMAGE_PATH,
                                M_TEMP_FACILITY_NO_SIG,
                                M_FACILITY_NO
                            )
            WHERE  SIGNATURE_CODE = X.SIGNATURE_CODE;
        END LOOP;
        
        ELSE
            INSERT INTO FA_CR_FACT_SIGNATURE_UPLOAD_BK
            SELECT *
            FROM   FA_CR_FACT_SIGNATURE_UPLOAD
            WHERE  FACILITY_NO = M_PREVIOUS_FACILITY_NO;

            UPDATE FA_CR_FACT_SIGNATURE_UPLOAD
            SET FACILITY_NO = M_FACILITY_NO,
                MOD_USER = M_USER,
                MOD_DATE = SYSDATE
            WHERE  FACILITY_NO = M_PREVIOUS_FACILITY_NO;
            */
       /* Change Image Path In 'Signature Upload' */

       /* FOR X IN (
            SELECT SIGNATURE_CODE,IMAGE_PATH
            FROM   FA_CR_FACT_SIGNATURE_UPLOAD
            WHERE  FACILITY_NO = M_FACILITY_NO
            ) LOOP
            UPDATE FA_CR_FACT_SIGNATURE_UPLOAD
            SET IMAGE_PATH = REPLACE (
                                X.IMAGE_PATH,
                                M_PREVIOUS_FACILITY_NO,
                                M_FACILITY_NO
                            )
            WHERE  SIGNATURE_CODE = X.SIGNATURE_CODE;
        END LOOP;
        
        END IF;
        */
        /*APPROVAL SHEET UPLOAD*/
        /*INSERT INTO FA_CR_FACT_APP_SHEET_UPLOAD_BK
            SELECT *
            FROM   FA_CR_FACT_APP_SHEET_UPLOAD
            WHERE  TEMPORARY_FACILITY_NO = M_TEMP_FACILITY_NO_APP;

        UPDATE FA_CR_FACT_APP_SHEET_UPLOAD
        SET CLIENT_CODE = M_CLIENT_CODE,
            FACILITY_NO = M_FACILITY_NO,
            MOD_USER = M_USER,
            MOD_DATE = SYSDATE
        WHERE  TEMPORARY_FACILITY_NO = M_TEMP_FACILITY_NO_APP;*/

        /* Change Image Path In 'Approval Sheet Upload' */

        /*FOR X IN (
            SELECT APP_SHEET_CODE,IMAGE_PATH
            FROM   FA_CR_FACT_APP_SHEET_UPLOAD
            WHERE  FACILITY_NO = M_FACILITY_NO
            ) LOOP
            UPDATE FA_CR_FACT_APP_SHEET_UPLOAD
            SET IMAGE_PATH = REPLACE (
                                X.IMAGE_PATH,
                                M_TEMP_FACILITY_NO_APP,
                                M_FACILITY_NO
                            )
            WHERE  APP_SHEET_CODE = X.APP_SHEET_CODE;
        END LOOP;

        */
        /* Added By Samitha Kulatilaka On 2010-10-19 */
        /*FOR X IN (
            SELECT STANDING_ORDER_NO
            FROM   FA_OP_MAS_STANDING_ORDER
            WHERE  TEMPORARY_FACILITY_NO = M_TEMP_FACILITY_NO_STAND
            AND    STANDING_ORDER_STATUS = 'ACTIVATE'
        )
        LOOP
            FA_OP_SAVE_TRN_STANDING_ORDER(X.STANDING_ORDER_NO, M_CLIENT_CODE, M_FACILITY_NO, M_USER, 'NEW');
        END LOOP;
        */
    ELSIF UPPER (M_SCREEN) = 'EDIT' THEN
    
    INSERT INTO FA_CR_PRO_APPROVAL_DETAIL
    (CLIENT_CODE,FACILITY_NO,SCREEN_NAME,APPROVAL_DESC,APP_STATUS,APP_COMMENTS,ENT_USER,ENT_DATE)
    VALUES
    (M_CLIENT_CODE,M_FACILITY_NO,'FA_CR_CREATE_CLIENT_FACILITY_EDIT',M_FACILITY_NO,'E','FACILITY_EDIT',M_USER,SYSDATE);

 
        /*CHANGE STATUS BACK TO N FROM M IN MODIFIED RECORDS*/
        
    --  RAISE_APPLICATION_ERROR(-20201,'M_FACILITY_NO'||M_FACILITY_NO||M_MODIFIED_RECORD);
       
        
        
          --RAISE_APPLICATION_ERROR (-20001,M_MODIFIED_RECORD||'***');
          
       -- IF M_MODIFIED_RECORD <> 'Y' THEN -- UPDATE MAIN TABLE ONLY FOR UNACTIVATED FACILITIES
   IF TRUE THEN  --ALWAYS BACKUP 
          
        INSERT INTO DN_REF_PORTFOLIO_BK
        SELECT *
        FROM   DN_REF_PORTFOLIO
        WHERE  PORTFOLIO_CODE = M_FACILITY_NO;
      
        DN_PORT_ADV_SAVE(M_FACILITY_NO,M_ADV_CODE, UPPER(M_SCREEN));
        
  END IF;
  IF TRUE THEN 
  
        FOR REC IN M_CURSOR LOOP

            INSERT INTO DN_REF_PORTFOLIO_TEMP (
              PORTFOLIO_CODE,
            CLIENT_CODE,
            FACILITY_MGR_CODE,
            FA_PRODUCT_CODE,
            FEE_PACK_CODE,
            LIMIT,
            --CREDIT_PERIOD,
            --TOLERANCE_CREDIT_PERIOD,
            --RESERVE_MARGIN,
            RATE,
            FACILITY_START_DATE,
            NEST_REVIEW,
            --FACILITY_STATUS,
            ENT_USER,
            CREATED_DATE,
            ENTRY_COMMENTS,
            ACC_NO,
            RETENTION,
            USER_TYPE,
            --ESTIMATED_RETURN,
            --COST_ESTIMATION,
            --COLLECTION_ROUTE_CODE,
            DATE_APP_RECEIVED,
            DATE_OF_INSPECTION,
            DATE_INFO_COMPLETED,
            DOC_CHECK_LIST,
            --COLLECTION_OFFICER,
            CURRENCY,
            --DEBTOR_CONCENTRATION,
            --ADVANCE,
            --COLLECTION_DETAILS,
            RATE_TYPE,
            OTHER_COMMENTS,
            --UNREALIZED_CHEQUE_PERC,
            --REFACT_TYPE,
            FLAT_SLAB,
            --BASE_TYPE,
            --PREM_DISC,
            --EXISTING_FACILITY_NO,
            OVER_PAID_INT_RATE,
            ACTIVE_STATUS,
            RESET_INTERVAL,
            RESET_DATE,
            LOCATION_CODE,
            MKT_EXECUTIVE,
            MANAGEMENT_FEE,
           -- REASSIGN_TYPE,
           -- REASSIGN_VALUE,
           -- RANDOM_DISAPP_PER,
           -- MIN_INVOICE_VALUE,
           -- MAX_INVOICE_VALUE,
           -- MAX_DEBTOR_LIMIT,
           -- PREVIOUS_FACILITY_NO,
           -- AVG_DEBTOR_LIMIT
           
           PF_NAME,
           POSTAL_CODE,
           ADD_IDENTIFICATION,
           ADD_LOCATION,
           ADD_CITY,
           MBFSL_SECT_CODE,
           TOT_EXP_LIMIT ,
           PERC_TOT_EXP,
           BROKER_CODE,
           CDS_ACC_NO,
           FACILITY_STATUS
            )
        VALUES (
            M_FACILITY_NO,
            M_CLIENT_CODE,
            M_FACILITY_MGR_CODE,
            M_FA_PRODUCT_CODE,
            M_FEE_PACK_CODE,
            M_CREDIT_LIMIT,
            --M_CREDIT_PERIOD,
            --M_TOLERANCE_CREDIT_PERIOD,
            --M_RESERVE_MARGIN,
            M_INT_RATE/100,
            TO_DATE(M_FACILITY_START_DATE, 'DD-MM-YYYY'),
            TO_DATE(M_FACILITY_END_DATE, 'DD-MM-YYYY'),
             --'N',
            M_USER,
            SYSDATE,
            M_ENTRY_COMMENTS,
            M_CLIENT_ACC_CODE,
            M_RETENTION,
            M_AVAILABILITY,
            --M_ESTIMATED_RETURN,
            --M_COST_ESTIMATION,
            --M_COLLECTION_ROUTE_CODE,
            TO_DATE(M_DATE_APP_RECEIVED, 'DD-MM-YYYY'),
            TO_DATE(M_DATE_OF_INSPECTION, 'DD-MM-YYYY'),
            TO_DATE(M_DATE_INFO_COMPLETED, 'DD-MM-YYYY'),
            M_DOC_CHECK_LIST,
            --M_COLLECTION_OFFICER,
            M_CURRENCY,
            --M_DEBTOR_CONCENTRATION,
            --M_ADVANCE,
            --M_COLLECTION_DETAILS,
            M_DISCOUNT_TYPE,
            M_OTHER_COMMENTS,
           -- M_UNREALIZED_CHEQUE_PERC,
            --M_REFACT_TYPE,
            M_FLAT_SLAB,
            --M_BASE_TYPE,
            --M_PREM_DISC_VALUE,
            --M_EXISTING_FACILITY_NO,
            M_OVER_PAID_DISCOUNT/100,
            'M',
            M_RESET_INTERVAL,
            TO_DATE(M_RESET_DATE,'DD-MM-YYYY'),
            M_LOCATION_CODE,
            M_MKT_EXECUTIVE,
            M_MANAGEMENT_FEE,
           --   M_REASSIGN_TYPE,
           -- M_REASSIGN_VALUE,
           -- M_RANDOM_DISAPP_PER,
           -- M_MIN_INVOICE_VALUE,
           -- M_MAX_INVOICE_VALUE,
           -- M_MAX_DEBTOR_LIMIT,
           -- M_PREVIOUS_FACILITY_NO,
           -- M_AVG_DEBTOR_LIMIT
           
           M_PF_NAME,
           M_POSTAL_CODE,
           M_ADD_IDENTIFICATION,
           M_ADD_LOCATION,
           M_ADD_CITY,
           M_MBFSL_SECT_CODE,
           M_TOT_EXP_LIMIT,
           M_PERC_TOT_EXP,
           M_BROKER_CODE,
           M_CDS_ACC_NO,
           M_NEW_FACILITY_STATUS
        );
        DN_PORT_ADV_SAVE(M_FACILITY_NO,M_ADV_CODE, UPPER(M_SCREEN));
        
            IF M_NEW_FACILITY_STATUS = 'TERMINATED' THEN   -- ADDED BY CS/TJ ON 20/05/2011 FACILITY TERMINATION
              
              UPDATE DN_REF_PORTFOLIO_TEMP
              SET    ACTIVE_STATUS = 'C'
              WHERE  PORTFOLIO_CODE = M_FACILITY_NO;
              
            ELSIF  M_NEW_FACILITY_STATUS = 'DEACTIVATED' THEN
            
               UPDATE DN_REF_PORTFOLIO_TEMP
               SET    ACTIVE_STATUS = 'D'
               WHERE  PORTFOLIO_CODE = M_FACILITY_NO;
            ELSE
               UPDATE DN_REF_PORTFOLIO_TEMP
               SET    ACTIVE_STATUS = 'M'
               WHERE  PORTFOLIO_CODE = M_FACILITY_NO;    
            END IF;
        
        END LOOP;
        END IF;
        
        /* THIRD PARTY GUARANTORS' DETAILS */
   /*     UPDATE FA_CR_BANK_PERSONAL_GUARANTEE
        SET MOD_USER = M_USER,
            MOD_DATE = SYSDATE
        WHERE  FACILITY_NO = M_FACILITY_NO;
        
        INSERT INTO FA_CR_BANK_PERSONAL_GUARANT_BK
            SELECT *
            FROM   FA_CR_BANK_PERSONAL_GUARANTEE
            WHERE  FACILITY_NO = M_FACILITY_NO;
        
        DELETE FROM FA_CR_BANK_PERSONAL_GUARANTEE
        WHERE       FACILITY_NO = M_FACILITY_NO;
*/
        
    END IF;
    
    -- UPDATE COLLECTION AND MANAGER DETAILS FOR RECORDS ENTERED IN CLIENT CREATION
   /* UPDATE FA_CR_PRO_CLIENT
    SET    CLIENT_MANAGER = M_CLIENT_MANAGER,
           MKT_OFFICER    = M_FACILITY_MGR_CODE
    WHERE  CLIENT_CODE    = M_CLIENT_CODE;*/
    
END; 

/
