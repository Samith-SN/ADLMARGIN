--------------------------------------------------------
--  DDL for Procedure DN_LIMITS_MATURITY_OVRL_EXPO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_LIMITS_MATURITY_OVRL_EXPO" 
(
M_limit_code                LMT_STR_OVRL_EXPO.limit_code%TYPE,
M_start_days                LMT_STR_OVRL_EXPO.start_days%TYPE,
M_end_days                  LMT_STR_OVRL_EXPO.end_days%TYPE,
M_start_amount              LMT_STR_OVRL_EXPO.start_amount%TYPE,
M_end_amount                LMT_STR_OVRL_EXPO.end_amount%TYPE,
M_no_of_app_levels          LMT_STR_OVRL_EXPO.no_of_app_levels%TYPE,
M_condition                 LMT_STR_OVRL_EXPO.condition%TYPE,
M_next_limit_refresh_date   VARCHAR2,
M_limit_warning_level       LMT_STR_OVRL_EXPO.limit_warning_level%TYPE,
M_date_created              VARCHAR2,
M_date_last_modified        VARCHAR2,
M_created_by                LMT_STR_OVRL_EXPO.created_by%TYPE,
M_prevent_trading           LMT_STR_OVRL_EXPO.prevent_trading%TYPE,
M_max_approval_days         LMT_STR_OVRL_EXPO.max_approval_days%TYPE,
M_STATUS                    VARCHAR,
M_LAST                      VARCHAR2
)
AS

/*PROCEDURE  - DN_LIMITS_MATURITY_OVRL_EXPO  SAVING LIMITS/ISSUER TO LMT_STR_OVRL_EXPO table
SYSTEM     - DEALNET
CREATED BY - SUKATHISVARAN
CREATED ON - 16/NOVEMBER/1999 */

M_LAST_DAILY              DN_SYS_PARAMETER.LAST_DAILY%TYPE;

BEGIN

IF (M_STATUS='Y') THEN
    DELETE LMT_UTL_OVRL_EXP;--modified to accomodate changes in the structure
    DELETE LMT_STR_OVRL_EXPO WHERE LIMIT_CODE LIKE '03-%';
        DELETE LMT_ACT_AUTHORITY WHERE LIMIT_CODE LIKE '03-%';
		DELETE LMT_ACT_DETAILS WHERE LIMIT_CODE LIKE '03-%';

END IF;


 INSERT INTO LMT_STR_OVRL_EXPO
              ( limit_code,
                start_days,
                end_days,
                start_amount,
                end_amount,
                no_of_app_levels,
                condition,
                next_limit_refresh_date,
                limit_warning_level,
                date_created,
                date_last_modified,
                created_by,
                prevent_trading,
                max_approval_days   )

     VALUES  (M_limit_code,
              M_start_days,
              M_end_days,
              M_start_amount,
              M_end_amount,
              M_no_of_app_levels,
              M_condition,
              TO_DATE(M_next_limit_refresh_date,'DD/MM/YYYY'),
              M_limit_warning_level,
              TO_DATE(M_date_created,'DD/MM/YYYY'),
              TO_DATE(M_date_last_modified,'DD/MM/YYYY'),
              M_created_by,
              M_prevent_trading,
              M_max_approval_days      );

  --MODIFIED TO ACCOMODATE CHANGES IN THE STRUCTURE
IF (M_LAST='Y') THEN
    --SELECT TO_DATE(TO_CHAR(SYSDATE, 'DD/MON/YYYY '),'DD/MM/YYYY') INTO M_LAST_DAILY FROM DUAL;
    --DN_LIMIT_DAYEND_OVRL_EXPO(M_LAST_DAILY);
    NULL;
END IF;

COMMIT;

END DN_LIMITS_MATURITY_OVRL_EXPO;

/
