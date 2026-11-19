--------------------------------------------------------
--  DDL for Procedure DN_LIMITS_DEALER_HOL_PERIOD
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_LIMITS_DEALER_HOL_PERIOD" 
(
M_limit_code                LMT_STR_DEALER_INST_HOL_PERIOD.limit_code%TYPE,
M_auction_type              LMT_STR_DEALER_INST_HOL_PERIOD.auction_type%TYPE,
M_dealer_code               LMT_STR_DEALER_INST_HOL_PERIOD.dealer_code%TYPE,
M_inst_type                 LMT_STR_DEALER_INST_HOL_PERIOD.inst_type%TYPE,
M_start_days                LMT_STR_DEALER_INST_HOL_PERIOD.start_days%TYPE,
M_end_days                  LMT_STR_DEALER_INST_HOL_PERIOD.end_days%TYPE,
M_no_of_app_levels          LMT_STR_DEALER_INST_HOL_PERIOD.no_of_app_levels%TYPE,
M_condition                 LMT_STR_DEALER_INST_HOL_PERIOD.condition%TYPE,
M_next_limit_refresh_date   VARCHAR2,
M_limit_warning_level       LMT_STR_DEALER_INST_HOL_PERIOD.limit_warning_level%TYPE,
M_date_created              VARCHAR2,
M_date_last_modified        VARCHAR2,
M_created_by                LMT_STR_DEALER_INST_HOL_PERIOD.created_by%TYPE,
M_prevent_trading           LMT_STR_DEALER_INST_HOL_PERIOD.prevent_trading%TYPE,
M_max_approval_days         LMT_STR_DEALER_INST_HOL_PERIOD.max_approval_days%TYPE,
M_STATUS                    VARCHAR
)
AS

/*PROCEDURE  - DN_LIMITS_DEALER_HOL_PERIOD SAVING LIMITS/ISSUER TO LMT_STR_DEALER_INST_HOL_PERIOD table
SYSTEM     - DEALNET
CREATED BY - SUKATHISVARAN
CREATED ON - 10/NOVEMBER/1999 */

BEGIN

/*RAISE_APPLICATION_ERROR(-20201,M_limit_code||' '||M_auction_type||' '||M_issuer_code||' '||M_issuer_liability_type||
                            ' '||M_inst_type||' '||M_start_amount||' '||M_end_amount||' '||M_no_of_app_levels||
                            ' '||M_condition||' '||M_next_limit_refresh_date||' '||M_limit_warning_level||' '||M_date_created||
                            ' '||M_date_last_modified||' '||M_created_by||' '||M_prevent_trading||' '||M_max_approval_days);
*/

IF (M_STATUS='Y') THEN
    DELETE LMT_STR_DEALER_INST_HOL_PERIOD ;--WHERE LIMIT_CODE LIKE '10-%';
END IF;

 INSERT INTO LMT_STR_DEALER_INST_HOL_PERIOD
              ( limit_code,
                auction_type,
                dealer_code,
                inst_type,
                start_days,
                end_days,
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
              M_auction_type,
              M_dealer_code,
              M_inst_type,
              M_start_days,
              M_end_days,
              M_no_of_app_levels,
              M_condition,
              TO_DATE(M_next_limit_refresh_date,'DD/MM/YYYY'),
              M_limit_warning_level,
              TO_DATE(M_date_created,'DD/MM/YYYY'),
              TO_DATE(M_date_last_modified,'DD/MM/YYYY'),
              M_created_by,
              M_prevent_trading,
              M_max_approval_days      );

COMMIT;

END DN_LIMITS_DEALER_HOL_PERIOD;

/
