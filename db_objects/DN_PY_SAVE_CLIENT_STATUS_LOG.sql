--------------------------------------------------------
--  DDL for Procedure DN_PY_SAVE_CLIENT_STATUS_LOG
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_PY_SAVE_CLIENT_STATUS_LOG" 
(
     M_DOCREFNO                      IN DN_PAY_CLIENT_STATUS_LOG.DOCREFNO % TYPE,
     M_PAYMENT_NO                    IN DN_PAY_CLIENT_STATUS_LOG.PAYMENT_NO % TYPE,
     M_PAYMENT_REF_NO                IN DN_PAY_CLIENT_STATUS_LOG.PAYMENT_REF_NO % TYPE,
     M_PAYMENT_AMOUNT                IN DN_PAY_CLIENT_STATUS_LOG.PAYMENT_AMOUNT % TYPE,
     M_RECEIPT_AMOUNT                IN DN_PAY_CLIENT_STATUS_LOG.RECEIPT_AMOUNT % TYPE,
     M_DUE_PAYMENT_AMOUNT            IN DN_PAY_CLIENT_STATUS_LOG.DUE_PAYMENT_AMOUNT % TYPE,
     M_PAY_AMOUNT                    IN DN_PAY_CLIENT_STATUS_LOG.PAY_AMOUNT % TYPE,
     M_PAYMENT_DATE                  VARCHAR,
     M_FACILITY_NO                   IN DN_PAY_CLIENT_STATUS_LOG.FACILITY_NO % TYPE,
     M_USER                          IN DN_PAY_CLIENT_STATUS_LOG.APP_USER % TYPE,
     M_SAVE_EVENT                    IN DN_PAY_CLIENT_STATUS_LOG.SAVE_EVENT% TYPE
)
    
/* 
 * AUTHOR                   :   WARUNA SRI JAYANATH
 * DATE                     :   2011-01-21
 * 
 * SYSTEM                   :   NETFAC
 * MENU HIERARCHY           :   FACTORING -> PAYMENT
 * SCREEN NAME              :   FA_PY_PAYMENT_CONFIRMATION
 * SCREEN URL               :   FA_PY_PAYMENT_CONFIRMATION_DISPLAY
 * SAVE SERVLET             :   FA_PY_PAYMENT_CONFIRMATION_SAVE
 * DISPLAY NAME             :   PAYMENT CONFIRMATION
 * 
 * PURPOSE                  :   SAVE PROCEDURE TO SAVE THE PAYMENT VOUCHER DETAILS
 */
    
AS

    MM_PAY_DATE    DATE;
    M_LAST_DAILY   DATE;
    MM_START_DATE_0                         VARCHAR2(10);
    MM_START_DATE_1                         VARCHAR2(10);
    MM_START_DATE_2                         VARCHAR2(10);
    MM_START_DATE_3                         VARCHAR2(10);
    MM_START_DATE_4                         VARCHAR2(10);
    MM_START_DATE_5                         VARCHAR2(10);
    MM_START_DATE_6                         VARCHAR2(10);
    
    MM_END_DATE_0                           VARCHAR2(10);
    MM_END_DATE_1                           VARCHAR2(10);
    MM_END_DATE_2                           VARCHAR2(10);
    MM_END_DATE_3                           VARCHAR2(10);
    MM_END_DATE_4                           VARCHAR2(10);
    MM_END_DATE_5                           VARCHAR2(10);
    MM_END_DATE_6                           VARCHAR2(10);
    MM_END_DATE_7                           VARCHAR2(10);
    
    MM_TODAY                                VARCHAR2(10);


M_SEC_LIMIT                                 NUMBER(25,4):=0;
M_APPROVE_LOAN_LIMIT                        NUMBER(25,4):=0;
M_LOAN_BALANCE                              NUMBER(25,4):=0;
M_PORT_MARKET_VALUE                         NUMBER(25,4):=0;
M_COMPANY_VALUATION                         NUMBER(25,4):=0; 
M_PENDING_PAYMENTS                          NUMBER(25,4):=0;
M_FUTURE_PAYMENTS                           NUMBER(25,4):=0;
M_PENDING_RECEIPTS                          NUMBER(25,4):=0;
M_FUTURE_RECEIPTS                           NUMBER(25,4):=0;
M_FUTURE_LOAN_BALANCE                       NUMBER(25,4):=0;
M_MARGIN_MARKET_VALUE                       NUMBER(25,4):=0;
M_MARGIN_VALAUTION                          NUMBER(25,4):=0;
M_FUTURE_MARGIN_MARKET_VALUE                NUMBER(25,4):=0;
M_FUTURE_MARGIN_VALAUTION                   NUMBER(25,4):=0;
M_PENDING_TRANSACTION                       NUMBER(25,4):=0;

M_CURRENT_AVAILABILITY_REC              FA_PY_INCR_AVAIL_STA_SUMMERY.CURRENT_AVAILABILITY_REC%TYPE; 
M_CURRENT_AVAILABILITY_APP              FA_PY_INCR_AVAIL_STA_SUMMERY.CURRENT_AVAILABILITY_APP%TYPE;
M_VALUATION_ENHANCE_AMOUNT_REC          FA_PY_INCR_AVAIL_STA_SUMMERY.VALUATION_ENHANCE_AMOUNT_REC%TYPE;
M_VALUATION_ENHANCE_AMOUNT_APP          FA_PY_INCR_AVAIL_STA_SUMMERY.VALUATION_ENHANCE_AMOUNT_APP%TYPE;
M_CONCEN_ADJ_AMOUNT_REC                 FA_PY_INCR_AVAIL_STA_SUMMERY.CONCEN_ADJ_AMOUNT_REC%TYPE;
M_CONCEN_ADJ_AMOUNT_APP                 FA_PY_INCR_AVAIL_STA_SUMMERY.CONCEN_ADJ_AMOUNT_APP%TYPE;
M_DUE_REC_AMOUNT_REC                    FA_PY_INCR_AVAIL_STA_SUMMERY.DUE_REC_AMOUNT_REC%TYPE;
M_DUE_REC_AMOUNT_APP                    FA_PY_INCR_AVAIL_STA_SUMMERY.DUE_REC_AMOUNT_APP%TYPE;
M_COUNT                                 NUMBER;

    BEGIN
    
    /*SELECT A.PAY_DATE,
           A.FACILITY_NO
     INTO   MM_PAY_DATE,
           MM_FACILITY_NO
    FROM   FA_OP_PRO_CLIENT_PAYMENTS A
    WHERE  A.PAYMENT_CODE = M_PAYMENT_CODE;*/
    
    SELECT LAST_DAILY 
    INTO M_LAST_DAILY
    FROM  DN_SYS_PARAMETER;
    
    
    MM_START_DATE_0             := TO_CHAR(TRUNC(M_LAST_DAILY+1, 'MM'), 'DD-MM-YYYY');
    MM_START_DATE_1             := TO_CHAR(TRUNC(ADD_MONTHS(M_LAST_DAILY+1, -1), 'MM'), 'DD-MM-YYYY');
    MM_START_DATE_2             := TO_CHAR(TRUNC(ADD_MONTHS(M_LAST_DAILY+1, -2), 'MM'), 'DD-MM-YYYY');
    MM_START_DATE_3             := TO_CHAR(TRUNC(ADD_MONTHS(M_LAST_DAILY+1, -3), 'MM'), 'DD-MM-YYYY');
    MM_START_DATE_4             := TO_CHAR(TRUNC(ADD_MONTHS(M_LAST_DAILY+1, -4), 'MM'), 'DD-MM-YYYY');
    MM_START_DATE_5             := TO_CHAR(TRUNC(ADD_MONTHS(M_LAST_DAILY+1, -5), 'MM'), 'DD-MM-YYYY');
    MM_START_DATE_6             := TO_CHAR(TRUNC(ADD_MONTHS(M_LAST_DAILY+1, -6), 'MM'), 'DD-MM-YYYY');
    
    MM_END_DATE_0               := TO_CHAR(LAST_DAY(TRUNC(M_LAST_DAILY+1, 'MM')), 'DD-MM-YYYY');
    MM_END_DATE_1               := TO_CHAR(LAST_DAY(TRUNC(ADD_MONTHS(M_LAST_DAILY+1, -1), 'MM')), 'DD-MM-YYYY');
    MM_END_DATE_2               := TO_CHAR(LAST_DAY(TRUNC(ADD_MONTHS(M_LAST_DAILY+1, -2), 'MM')), 'DD-MM-YYYY');
    MM_END_DATE_3               := TO_CHAR(LAST_DAY(TRUNC(ADD_MONTHS(M_LAST_DAILY+1, -3), 'MM')), 'DD-MM-YYYY');
    MM_END_DATE_4               := TO_CHAR(LAST_DAY(TRUNC(ADD_MONTHS(M_LAST_DAILY+1, -4), 'MM')), 'DD-MM-YYYY');
    MM_END_DATE_5               := TO_CHAR(LAST_DAY(TRUNC(ADD_MONTHS(M_LAST_DAILY+1, -5), 'MM')), 'DD-MM-YYYY');
    MM_END_DATE_6               := TO_CHAR(LAST_DAY(TRUNC(ADD_MONTHS(M_LAST_DAILY+1, -6), 'MM')), 'DD-MM-YYYY');
    MM_END_DATE_7               := TO_CHAR(LAST_DAY(TRUNC(ADD_MONTHS(M_LAST_DAILY+1, -7), 'MM')), 'DD-MM-YYYY');
    
    MM_TODAY                    := TO_CHAR(M_LAST_DAILY+1, 'DD-MM-YYYY');
    
SELECT COUNT(*) INTO M_COUNT 
FROM DN_PAY_CLIENT_STATUS_LOG 
WHERE DOCREFNO = M_DOCREFNO
AND   SAVE_EVENT = M_SAVE_EVENT
AND   FACILITY_NO = M_FACILITY_NO;  
 
IF M_COUNT = 0 THEN    

BEGIN 
    




    
SELECT   
SUM(A.SEC_LIMIT), 
A.PORT_LIMIT,  
A.REPO_LEG2 + NVL(DN_GET_DAYEND_LOAN_MOVE(A.PORTFOLIO_CODE,MM_TODAY),0) + NVL(DN_GET_DAYEND_LOAN_MOVE_TEMP(A.PORTFOLIO_CODE,MM_TODAY),0)+
NVL(DN_GET_FUTURE_LOAN_MOVE(A.PORTFOLIO_CODE,TO_CHAR(M_LAST_DAILY+1,'DD/MM/YYYY')),0)+NVL(DN_GET_FUTURE_LOAN_MOVE_TEMP(A.PORTFOLIO_CODE,TO_CHAR(M_LAST_DAILY+1,'DD/MM/YYYY')),0) LOAN,   
SUM(NVL(A.FACE_VAL,0)* NVL(A.MARKET_RATE,0)) 
,SUM(NVL(A.FACE_VAL,0)* NVL(A.MARKET_RATE,0)*NVL(DN_GET_LICENCE_MT_PERCENT(A.SECURITY_CODE),0)/100)*2, 
--,DN_CLIENT_PENDING_CASH_FLOW_P(A.PORTFOLIO_CODE,'M_MDATE_LAST_DAILY')-DN_CLIENT_PENDING_CASH_FLOW_R(A.PORTFOLIO_CODE,'M_MDATE_LAST_DAILY') ,--14
 DN_CLIENT_PENDING_CASH_FLOW_P(A.PORTFOLIO_CODE,TO_CHAR(M_LAST_DAILY,'DD/MM/YYYY'))-
               (SELECT NVL(SUM(PAY_AMOUNT),0)
                FROM DN_TRN_BO_SETTL_PAYMENT_TEMP A
                WHERE A.CLIENT_CODE = M_FACILITY_NO
                AND TRUNC(EFF_VALDATE,'DD') <= M_LAST_DAILY  
                AND APP_STATUS IN('ENT')),--PENDING_PAYMENTS               
 DN_CLIENT_PEND_CASH_FLOW_P_1(A.PORTFOLIO_CODE,TO_CHAR(M_LAST_DAILY+1,'DD/MM/YYYY'),TO_CHAR(DN_FIN_BUYER_SETTLE_DATE(TO_CHAR(M_LAST_DAILY,'DD/MM/YYYY'),4),'DD/MM/YYYY'))
 -(SELECT NVL(SUM(PAY_AMOUNT),0)
                FROM DN_TRN_BO_SETTL_PAYMENT_TEMP A
                WHERE A.CLIENT_CODE = M_FACILITY_NO
                AND TRUNC(EFF_VALDATE,'DD') >= M_LAST_DAILY+1  
                AND APP_STATUS IN('ENT')) ,--future_payments                ,
 DN_CLIENT_PENDING_CASH_FLOW_R(A.PORTFOLIO_CODE,TO_CHAR(M_LAST_DAILY,'DD/MM/YYYY'))-
               (SELECT NVL(SUM(REC_AMOUNT),0)
               FROM DN_TRN_BO_SETTL_RECEIPT_TMP A
               WHERE A.SELL_PORTFOLIO_CODE = M_FACILITY_NO
               AND TRUNC(EFF_VALDATE,'DD') <= M_LAST_DAILY 
               AND APP_STATUS IN('ENT')
 
 ) ,--PENDING_RECEIPTS,
 DN_CLIENT_PEND_CASH_FLOW_R_1(A.PORTFOLIO_CODE,TO_CHAR(M_LAST_DAILY+1,'DD/MM/YYYY'),TO_CHAR(DN_FIN_BUYER_SETTLE_DATE(TO_CHAR(M_LAST_DAILY,'DD/MM/YYYY'),4),'DD/MM/YYYY'))
 - (SELECT NVL(SUM(REC_AMOUNT),0)
               FROM DN_TRN_BO_SETTL_RECEIPT_TMP A
               WHERE A.SELL_PORTFOLIO_CODE = M_FACILITY_NO
               AND TRUNC(EFF_VALDATE,'DD') >= M_LAST_DAILY+1  
               AND APP_STATUS IN('ENT')
 
 ),               
DN_GET_PENDING_TRANSACTION(A.PORTFOLIO_CODE,TO_CHAR(M_LAST_DAILY+1,'DD/MM/YYYY'))  

INTO 
M_SEC_LIMIT,
M_APPROVE_LOAN_LIMIT,
M_LOAN_BALANCE,
M_PORT_MARKET_VALUE ,
M_COMPANY_VALUATION,
M_PENDING_PAYMENTS ,
M_FUTURE_PAYMENTS ,
M_PENDING_RECEIPTS ,
M_FUTURE_RECEIPTS, 
M_PENDING_TRANSACTION
 

FROM DN_TEMP_MARGIN_CALL A,  DN_REF_PORTFOLIO B 
WHERE A.PORTFOLIO_CODE = M_FACILITY_NO
AND A.PORTFOLIO_CODE = B.PORTFOLIO_CODE 
AND A.PORTFOLIO_CODE <> 'LBMT'
GROUP BY A.PORTFOLIO_CODE,A.PORT_LIMIT,A.REPO_LEG2;

M_FUTURE_LOAN_BALANCE := NVL(M_LOAN_BALANCE,0)+NVL(M_PENDING_PAYMENTS,0)+NVL(M_FUTURE_PAYMENTS,0)-NVL(M_PENDING_RECEIPTS,0)-NVL(M_FUTURE_RECEIPTS,0);


IF(M_PORT_MARKET_VALUE!=0) THEN

                     --M_MARGIN_MARKET_VALUE:= (M_LOAN_BALANCE + M_FUTURE_LOAN_BALANCE + M_PENDING_PAYMENTS) / M_PORT_MARKET_VALUE ;
                      M_MARGIN_MARKET_VALUE:= (M_LOAN_BALANCE) / M_PORT_MARKET_VALUE ;
                     
END IF;

IF(M_COMPANY_VALUATION!=0) THEN 
        
                     --M_MARGIN_VALAUTION := (M_LOAN_BALANCE + M_FUTURE_LOAN_BALANCE + M_PENDING_PAYMENTS) / M_COMPANY_VALUATION ;
                       M_MARGIN_VALAUTION := (M_LOAN_BALANCE) / M_COMPANY_VALUATION;
END IF ;

IF(M_PORT_MARKET_VALUE!=0) THEN

                    -- M_FUTURE_MARGIN_MARKET_VALUE:= (M_LOAN_BALANCE + M_FUTURE_LOAN_BALANCE + M_PENDING_PAYMENTS) / M_PORT_MARKET_VALUE ;
                       M_FUTURE_MARGIN_MARKET_VALUE:= (M_FUTURE_LOAN_BALANCE ) / M_PORT_MARKET_VALUE ;
END IF;

IF(M_COMPANY_VALUATION!=0) THEN         
                     --M_FUTURE_MARGIN_VALAUTION := (M_LOAN_BALANCE + M_FUTURE_LOAN_BALANCE + M_PENDING_PAYMENTS) / M_COMPANY_VALUATION ;
                     
                        M_FUTURE_MARGIN_VALAUTION := (M_FUTURE_LOAN_BALANCE ) / M_COMPANY_VALUATION ;
END IF ;
   
    
 EXCEPTION
   WHEN NO_DATA_FOUND THEN
     dbms_output.put_line('No data found ');
 END;  
 
                              BEGIN 
                                  
                              SELECT A.CURRENT_AVAILABILITY_REC,  A.CURRENT_AVAILABILITY_APP ,
                              A.VALUATION_ENHANCE_AMOUNT_REC,    A.VALUATION_ENHANCE_AMOUNT_APP, 
                              A.CONCEN_ADJ_AMOUNT_REC, A.CONCEN_ADJ_AMOUNT_APP, 
                              A.DUE_REC_AMOUNT_REC, A.DUE_REC_AMOUNT_APP INTO M_CURRENT_AVAILABILITY_REC,M_CURRENT_AVAILABILITY_APP,
                              M_VALUATION_ENHANCE_AMOUNT_REC,M_VALUATION_ENHANCE_AMOUNT_APP,
                              M_CONCEN_ADJ_AMOUNT_REC,M_CONCEN_ADJ_AMOUNT_APP,
                              M_DUE_REC_AMOUNT_REC,M_DUE_REC_AMOUNT_APP
                              FROM FA_PY_INCR_AVAIL_STA_SUMMERY A  WHERE 
                              --SAVE_ORDER_NO   = '' 
                              PAY_NO          = M_PAYMENT_NO
                              AND FACILITY_NO = M_FACILITY_NO
                              AND SAVE_EVENT  = M_SAVE_EVENT
                              AND ROWNUM='1' ;
                       EXCEPTION
                       WHEN NO_DATA_FOUND THEN
                       dbms_output.put_line('No data found ');
                       END;
    
    INSERT INTO DN_PAY_CLIENT_STATUS_LOG(DOCREFNO,PAYMENT_NO,PAYMENT_REF_NO,PAYMENT_AMOUNT,RECEIPT_AMOUNT,
    DUE_PAYMENT_AMOUNT,PAY_AMOUNT,PAYMENT_DATE,FACILITY_NO,APP_USER,
    sp_opening_balance_0           ,
    sp_opening_balance_1           ,
    sp_opening_balance_2           ,
    sp_opening_balance_3           ,
    sp_opening_balance_4           ,
    sp_opening_balance_5           ,
    sp_opening_balance_6           ,
    sp_parchases_0                 ,
    sp_parchases_1                 ,
    sp_parchases_2                 ,
    sp_parchases_3                 ,
    sp_parchases_4                 ,
    sp_parchases_5                 ,
    sp_parchases_6                 ,
    sp_sales_0                     ,
    sp_sales_1                     ,
    sp_sales_2                     ,
    sp_sales_3                     ,
    sp_sales_4                     ,
    sp_sales_5                     ,
    sp_sales_6                     ,
    sp_brokerage_0                 ,
    sp_brokerage_1                 ,
    sp_brokerage_2                 ,
    sp_brokerage_3                 ,
    sp_brokerage_4                 ,
    sp_brokerage_5                 ,
    sp_brokerage_6                 ,
    sp_market_value_diff_0         ,
    sp_market_value_diff_1         ,
    sp_market_value_diff_2         ,
    sp_market_value_diff_3         ,
    sp_market_value_diff_4         ,
    sp_market_value_diff_5         ,
    sp_market_value_diff_6         ,
    
    sp_closing_balance_0          ,
    sp_closing_balance_1           ,
    sp_closing_balance_2           , 
    sp_closing_balance_3           ,
    sp_closing_balance_4           ,
    sp_closing_balance_5           ,
    sp_closing_balance_6           ,
    
    lb_opening_balance_0           ,
    lb_opening_balance_1           ,
    lb_opening_balance_2           ,
    lb_opening_balance_3           ,
    lb_opening_balance_4           ,
    lb_opening_balance_5           ,
    lb_opening_balance_6           ,
    lb_payments_0                  ,
    lb_payments_1                  ,
    lb_payments_2                  ,
    lb_payments_3                  ,
    lb_payments_4                  ,
    lb_payments_5                  ,
    lb_payments_6                  ,
    lb_receipts_0                  ,
    lb_receipts_1                  ,
    lb_receipts_2                  ,
    lb_receipts_3                  ,
    lb_receipts_4                  ,
    lb_receipts_5                  ,
    lb_receipts_6                  ,
    lb_dividends_0                 ,
    lb_dividends_1                 ,
    lb_dividends_2                 ,
    lb_dividends_3                 ,
    lb_dividends_4                 ,
    lb_dividends_5                 ,
    lb_dividends_6                 ,
    lb_cap_deposit_0               ,
    lb_cap_deposit_1               ,
    lb_cap_deposit_2               ,
    lb_cap_deposit_3               ,
    lb_cap_deposit_4               ,
    lb_cap_deposit_5               ,
    lb_cap_deposit_6               ,
    lb_cap_withdrawal_0            ,
    lb_cap_withdrawal_1            ,
    lb_cap_withdrawal_2            ,
    lb_cap_withdrawal_3            ,
    lb_cap_withdrawal_4            ,
    lb_cap_withdrawal_5            ,
    lb_cap_withdrawal_6            ,
    lb_interest_0                  ,
    lb_interest_1                  ,
    lb_interest_2                  ,
    lb_interest_3                  ,
    lb_interest_4                  ,
    lb_interest_5                  ,
    lb_interest_6                  ,
    lb_od_interest_0               ,
    lb_od_interest_1               ,
    lb_od_interest_2               ,
    lb_od_interest_3               ,
    lb_od_interest_4               ,
    lb_od_interest_5               ,
    lb_od_interest_6               ,
    loan_balance                   ,
    pending_payments               ,
    future_payments                ,
    pending_receipts               ,
    future_receipts                ,
    future_loan_balance            ,
    approved_limit                 ,
    market_valuation               ,
    company_valuation              ,
    market_current_margin_ratio    ,
    company_current_margin_ratio   ,
    market_future_margin_ratio     ,
    company_future_margin_ratio    ,
    
    current_availability_rec,
    current_availability_app, 
    valuation_enhance_amount_rec,
    valuation_enhance_amount_app,
    concen_adj_amount_rec,
    concen_adj_amount_app,
    due_rec_amount_rec,
    due_rec_amount_app,
    PAYMENT_AVAILABILITY,
    SAVE_EVENT,   
    PAYMENT_SPORT_MARGIN,
    PAYMENT_SPORT_MARGIN_MKT,
    PENDING_TRANSACTION
    )
    VALUES(M_DOCREFNO,M_PAYMENT_NO,M_PAYMENT_REF_NO,M_PAYMENT_AMOUNT,M_RECEIPT_AMOUNT,
    M_DUE_PAYMENT_AMOUNT,M_PAY_AMOUNT,M_LAST_DAILY+1/*TO_DATE(M_PAYMENT_DATE,'DD-MM-YYYY')*/,M_FACILITY_NO,M_USER,
    DN_GET_OPENING_BALANCE_PF(MM_START_DATE_0,M_FACILITY_NO), --sp_opening_balance_0           
    DN_GET_OPENING_BALANCE_PF(MM_START_DATE_1,M_FACILITY_NO),--   sp_opening_balance_1           ,
    DN_GET_OPENING_BALANCE_PF(MM_START_DATE_2,M_FACILITY_NO),--  sp_opening_balance_2           ,
    DN_GET_OPENING_BALANCE_PF(MM_START_DATE_3,M_FACILITY_NO),--  sp_opening_balance_3           ,
    DN_GET_OPENING_BALANCE_PF(MM_START_DATE_4,M_FACILITY_NO),--  sp_opening_balance_4           ,
    DN_GET_OPENING_BALANCE_PF(MM_START_DATE_5,M_FACILITY_NO),--  sp_opening_balance_5           ,
    DN_GET_OPENING_BALANCE_PF(MM_START_DATE_6,M_FACILITY_NO),--  sp_opening_balance_6           ,
    
    DN_GET_CLIENT_PURCHASE(M_FACILITY_NO,MM_START_DATE_0,MM_TODAY),--sp_parchases_0                 ,
    DN_GET_CLIENT_PURCHASE(M_FACILITY_NO,MM_START_DATE_1,MM_END_DATE_1),--sp_parchases_1                 ,
    DN_GET_CLIENT_PURCHASE(M_FACILITY_NO,MM_START_DATE_2,MM_END_DATE_2),--- sp_parchases_2                 ,
    DN_GET_CLIENT_PURCHASE(M_FACILITY_NO,MM_START_DATE_3,MM_END_DATE_3),---sp_parchases_3                 ,
    DN_GET_CLIENT_PURCHASE(M_FACILITY_NO,MM_START_DATE_4,MM_END_DATE_4),---sp_parchases_4                 ,
    DN_GET_CLIENT_PURCHASE(M_FACILITY_NO,MM_START_DATE_5,MM_END_DATE_5),---sp_parchases_5                 ,
    DN_GET_CLIENT_PURCHASE(M_FACILITY_NO,MM_START_DATE_6,MM_END_DATE_6),---sp_parchases_6                 ,
    
    DN_GET_CLIENT_SALE(M_FACILITY_NO,MM_START_DATE_0,MM_TODAY),--sp_sales_0                     ,
    DN_GET_CLIENT_SALE(M_FACILITY_NO,MM_START_DATE_1,MM_END_DATE_1),--sp_sales_1                     ,
    DN_GET_CLIENT_SALE(M_FACILITY_NO,MM_START_DATE_2,MM_END_DATE_2),--sp_sales_2                     ,
    DN_GET_CLIENT_SALE(M_FACILITY_NO,MM_START_DATE_3,MM_END_DATE_3),--sp_sales_3                     ,
    DN_GET_CLIENT_SALE(M_FACILITY_NO,MM_START_DATE_4,MM_END_DATE_4),--sp_sales_4                     ,
    DN_GET_CLIENT_SALE(M_FACILITY_NO,MM_START_DATE_5,MM_END_DATE_5),--sp_sales_5                     ,
    DN_GET_CLIENT_SALE(M_FACILITY_NO,MM_START_DATE_6,MM_END_DATE_6),--sp_sales_6                     ,
    
    DN_GET_CLIENT_BROKERAGE(M_FACILITY_NO,MM_START_DATE_0,MM_TODAY),--sp_brokerage_0                 ,
    DN_GET_CLIENT_BROKERAGE(M_FACILITY_NO,MM_START_DATE_1,MM_END_DATE_1),--sp_brokerage_1                 ,
    DN_GET_CLIENT_BROKERAGE(M_FACILITY_NO,MM_START_DATE_2,MM_END_DATE_2),--sp_brokerage_2                 ,
    DN_GET_CLIENT_BROKERAGE(M_FACILITY_NO,MM_START_DATE_3,MM_END_DATE_3),--sp_brokerage_3                 ,
    DN_GET_CLIENT_BROKERAGE(M_FACILITY_NO,MM_START_DATE_4,MM_END_DATE_4),--sp_brokerage_4                 ,
    DN_GET_CLIENT_BROKERAGE(M_FACILITY_NO,MM_START_DATE_5,MM_END_DATE_5),--sp_brokerage_5                 ,
    DN_GET_CLIENT_BROKERAGE(M_FACILITY_NO,MM_START_DATE_6,MM_END_DATE_6),--sp_brokerage_6                 ,
    
    0 ,--sp_market_value_diff_0         ,
    0,--sp_market_value_diff_1         ,
     0 ,--sp_market_value_diff_2         ,
     0 ,--sp_market_value_diff_3         ,
     0 ,--sp_market_value_diff_4         ,
     0 ,--sp_market_value_diff_5         ,
     0 ,--sp_market_value_diff_6         ,
     
     DN_GET_OPENING_BALANCE_PF(MM_TODAY,M_FACILITY_NO), -- sp_closing_balance_0          ,
     DN_GET_OPENING_BALANCE_PF(MM_START_DATE_0,M_FACILITY_NO), -- sp_closing_balance_1           ,
     DN_GET_OPENING_BALANCE_PF(MM_START_DATE_1,M_FACILITY_NO), --sp_closing_balance_2           , 
     DN_GET_OPENING_BALANCE_PF(MM_START_DATE_2,M_FACILITY_NO), --sp_closing_balance_3           ,
     DN_GET_OPENING_BALANCE_PF(MM_START_DATE_3,M_FACILITY_NO), --sp_closing_balance_4           ,
     DN_GET_OPENING_BALANCE_PF(MM_START_DATE_4,M_FACILITY_NO), --sp_closing_balance_5           ,
     DN_GET_OPENING_BALANCE_PF(MM_START_DATE_5,M_FACILITY_NO), --sp_closing_balance_6           ,
    
    DN_GET_OPENING_BALANCE_BF(MM_START_DATE_0,M_FACILITY_NO), --lb_opening_balance_0           
    DN_GET_OPENING_BALANCE_BF(MM_START_DATE_1,M_FACILITY_NO),--   lb_opening_balance_1           ,
    DN_GET_OPENING_BALANCE_BF(MM_START_DATE_2,M_FACILITY_NO),--  lb_opening_balance_2           ,
    DN_GET_OPENING_BALANCE_BF(MM_START_DATE_3,M_FACILITY_NO),--  lb_opening_balance_3           ,
    DN_GET_OPENING_BALANCE_BF(MM_START_DATE_4,M_FACILITY_NO),--  lb_opening_balance_4           ,
    DN_GET_OPENING_BALANCE_BF(MM_START_DATE_5,M_FACILITY_NO),--  lb_opening_balance_5           ,
    DN_GET_OPENING_BALANCE_BF(MM_START_DATE_6,M_FACILITY_NO),--  lb_opening_balance_6           ,
    
    DN_GET_CLIENT_PAYMENT(M_FACILITY_NO,MM_START_DATE_0,MM_TODAY),--lb_PAYMENT_0                 ,
    DN_GET_CLIENT_PAYMENT(M_FACILITY_NO,MM_START_DATE_1,MM_END_DATE_1),--lb_PAYMENT_1            ,
    DN_GET_CLIENT_PAYMENT(M_FACILITY_NO,MM_START_DATE_2,MM_END_DATE_2),--- lb_PAYMENT_2          ,
    DN_GET_CLIENT_PAYMENT(M_FACILITY_NO,MM_START_DATE_3,MM_END_DATE_3),---lb_PAYMENT_3           ,
    DN_GET_CLIENT_PAYMENT(M_FACILITY_NO,MM_START_DATE_4,MM_END_DATE_4),---lb_PAYMENT4            ,
    DN_GET_CLIENT_PAYMENT(M_FACILITY_NO,MM_START_DATE_5,MM_END_DATE_5),---lb_PAYMENT_5           ,
    DN_GET_CLIENT_PAYMENT(M_FACILITY_NO,MM_START_DATE_6,MM_END_DATE_6),---lb_PAYMENT_6           ,
    
    DN_GET_CLIENT_RECEIPT(M_FACILITY_NO,MM_START_DATE_0,MM_TODAY),--lb_RECEIPT_0                 ,
    DN_GET_CLIENT_RECEIPT(M_FACILITY_NO,MM_START_DATE_1,MM_END_DATE_1),--lb_RECEIPT_1                     ,
    DN_GET_CLIENT_RECEIPT(M_FACILITY_NO,MM_START_DATE_2,MM_END_DATE_2),--lb_RECEIPT_2                     ,
    DN_GET_CLIENT_RECEIPT(M_FACILITY_NO,MM_START_DATE_3,MM_END_DATE_3),--lb_RECEIPT_3                     ,
    DN_GET_CLIENT_RECEIPT(M_FACILITY_NO,MM_START_DATE_4,MM_END_DATE_4),--lb_RECEIPT_4                     ,
    DN_GET_CLIENT_RECEIPT(M_FACILITY_NO,MM_START_DATE_5,MM_END_DATE_5),--lb_RECEIPT_5                     ,
    DN_GET_CLIENT_RECEIPT(M_FACILITY_NO,MM_START_DATE_6,MM_END_DATE_6),--lb_RECEIPT_6                     ,
    
    
    
    DN_GET_CLIENT_DIVIDEND(M_FACILITY_NO,MM_START_DATE_0,MM_TODAY),--lb_dividends_0                     ,
    DN_GET_CLIENT_DIVIDEND(M_FACILITY_NO,MM_START_DATE_1,MM_END_DATE_1),--lb_dividends_1                     ,
    DN_GET_CLIENT_DIVIDEND(M_FACILITY_NO,MM_START_DATE_2,MM_END_DATE_2),--lb_dividends_2                     ,
    DN_GET_CLIENT_DIVIDEND(M_FACILITY_NO,MM_START_DATE_3,MM_END_DATE_3),--llb_dividends_3                     ,
    DN_GET_CLIENT_DIVIDEND(M_FACILITY_NO,MM_START_DATE_4,MM_END_DATE_4),--lb_dividends_4                     ,
    DN_GET_CLIENT_DIVIDEND(M_FACILITY_NO,MM_START_DATE_5,MM_END_DATE_5),--lb_dividends_5                     ,
    DN_GET_CLIENT_DIVIDEND(M_FACILITY_NO,MM_START_DATE_6,MM_END_DATE_6),--lb_dividends_6                     ,
    
     
    DN_GET_CLIENT_DEPOSIT(M_FACILITY_NO,MM_START_DATE_0,MM_TODAY),--lb_cap_deposit_0                     ,
    DN_GET_CLIENT_DEPOSIT(M_FACILITY_NO,MM_START_DATE_1,MM_END_DATE_1),--lb_cap_deposit_1                     ,
    DN_GET_CLIENT_DEPOSIT(M_FACILITY_NO,MM_START_DATE_2,MM_END_DATE_2),--lb_cap_deposit_2                     ,
    DN_GET_CLIENT_DEPOSIT(M_FACILITY_NO,MM_START_DATE_3,MM_END_DATE_3),--lb_cap_deposit_3                    ,
    DN_GET_CLIENT_DEPOSIT(M_FACILITY_NO,MM_START_DATE_4,MM_END_DATE_4),--lb_cap_deposit_4                     ,
    DN_GET_CLIENT_DEPOSIT(M_FACILITY_NO,MM_START_DATE_5,MM_END_DATE_5),--lb_cap_deposit_5                     ,
    DN_GET_CLIENT_DEPOSIT(M_FACILITY_NO,MM_START_DATE_6,MM_END_DATE_6),--lb_cap_deposit_6                     ,
    
    
    DN_GET_CLIENT_WITHDRAWAL(M_FACILITY_NO,MM_START_DATE_0,MM_TODAY),--lb_cap_withdrawal_0                        ,
    DN_GET_CLIENT_WITHDRAWAL(M_FACILITY_NO,MM_START_DATE_1,MM_END_DATE_1),--lb_cap_withdrawal_1                     ,
    DN_GET_CLIENT_WITHDRAWAL(M_FACILITY_NO,MM_START_DATE_2,MM_END_DATE_2),--lb_cap_withdrawal_2                     ,
    DN_GET_CLIENT_WITHDRAWAL(M_FACILITY_NO,MM_START_DATE_3,MM_END_DATE_3),--lb_cap_withdrawal_3                    ,
    DN_GET_CLIENT_WITHDRAWAL(M_FACILITY_NO,MM_START_DATE_4,MM_END_DATE_4),--lb_cap_withdrawal_4                     ,
    DN_GET_CLIENT_WITHDRAWAL(M_FACILITY_NO,MM_START_DATE_5,MM_END_DATE_5),--lb_cap_withdrawal_5                     ,
    DN_GET_CLIENT_WITHDRAWAL(M_FACILITY_NO,MM_START_DATE_6,MM_END_DATE_6),--lb_cap_withdrawal_6                     ,
    
    
    DN_GET_MONTH_INTEREST(MM_START_DATE_0,M_FACILITY_NO), --lb_interest_0           
    DN_GET_MONTH_INTEREST(MM_START_DATE_1,M_FACILITY_NO),--   lb_interest_1           ,
    DN_GET_MONTH_INTEREST(MM_START_DATE_2,M_FACILITY_NO),--  lb_interest_2           ,
    DN_GET_MONTH_INTEREST(MM_START_DATE_3,M_FACILITY_NO),--  lb_interest_3           ,
    DN_GET_MONTH_INTEREST(MM_START_DATE_4,M_FACILITY_NO),--  lb_interest_4           ,
    DN_GET_MONTH_INTEREST(MM_START_DATE_5,M_FACILITY_NO),--  lb_interest_5           ,
    DN_GET_MONTH_INTEREST(MM_START_DATE_6,M_FACILITY_NO),--  lb_interest_6           ,
    
    
    /*DN_GET_OD_ACCRUED_INTEREST(M_FACILITY_NO,MM_START_DATE_0,MM_TODAY),--lb_od_interest_0                     ,
    DN_GET_OD_ACCRUED_INTEREST(M_FACILITY_NO,MM_START_DATE_1,MM_END_DATE_1),--lb_od_interest_1                     ,
    DN_GET_OD_ACCRUED_INTEREST(M_FACILITY_NO,MM_START_DATE_2,MM_END_DATE_2),--lb_od_interest_2                     ,
    DN_GET_OD_ACCRUED_INTEREST(M_FACILITY_NO,MM_START_DATE_3,MM_END_DATE_3),--lb_od_interest_3                     ,
    DN_GET_OD_ACCRUED_INTEREST(M_FACILITY_NO,MM_START_DATE_4,MM_END_DATE_4),--lb_od_interest_4                     ,
    DN_GET_OD_ACCRUED_INTEREST(M_FACILITY_NO,MM_START_DATE_5,MM_END_DATE_5),--lb_od_interest_5                     ,
    DN_GET_OD_ACCRUED_INTEREST(M_FACILITY_NO,MM_START_DATE_6,MM_END_DATE_6),--lb_od_interest_6                     ,*/
    DN_GET_OD_ACCRUED_INTEREST(M_FACILITY_NO,TO_DATE(MM_START_DATE_0,'DD/MM/YYYY'),TO_DATE(MM_TODAY,'DD/MM/YYYY')),--lb_od_interest_0                     ,
    DN_GET_OD_ACCRUED_INTEREST(M_FACILITY_NO,TO_DATE(MM_START_DATE_1,'DD/MM/YYYY'),TO_DATE(MM_END_DATE_1,'DD/MM/YYYY')),--lb_od_interest_1                     ,
    DN_GET_OD_ACCRUED_INTEREST(M_FACILITY_NO,TO_DATE(MM_START_DATE_2,'DD/MM/YYYY'),TO_DATE(MM_END_DATE_2,'DD/MM/YYYY')),--lb_od_interest_2                     ,
    DN_GET_OD_ACCRUED_INTEREST(M_FACILITY_NO,TO_DATE(MM_START_DATE_3,'DD/MM/YYYY'),TO_DATE(MM_END_DATE_3,'DD/MM/YYYY')),--lb_od_interest_3                     ,
    DN_GET_OD_ACCRUED_INTEREST(M_FACILITY_NO,TO_DATE(MM_START_DATE_4,'DD/MM/YYYY'),TO_DATE(MM_END_DATE_4,'DD/MM/YYYY')),--lb_od_interest_4                     ,
    DN_GET_OD_ACCRUED_INTEREST(M_FACILITY_NO,TO_DATE(MM_START_DATE_5,'DD/MM/YYYY'),TO_DATE(MM_END_DATE_5,'DD/MM/YYYY')),--lb_od_interest_5                     ,
    DN_GET_OD_ACCRUED_INTEREST(M_FACILITY_NO,TO_DATE(MM_START_DATE_6,'DD/MM/YYYY'),TO_DATE(MM_END_DATE_6,'DD/MM/YYYY')),--lb_od_interest_6                     ,
   
    
  
    M_LOAN_BALANCE ,--loan_balance                   ,
    M_PENDING_PAYMENTS,--pending_payments               ,
    M_FUTURE_PAYMENTS,--future_payments                ,
    M_PENDING_RECEIPTS,--pending_receipts               ,
    M_FUTURE_RECEIPTS ,--future_receipts                ,
    M_FUTURE_LOAN_BALANCE,--future_loan_balance            ,
    M_APPROVE_LOAN_LIMIT ,--approved_limit                 ,
    M_PORT_MARKET_VALUE ,--market_valuation               ,
    M_COMPANY_VALUATION ,--company_valuation              ,
    M_MARGIN_MARKET_VALUE ,--market_current_margin_ratio    ,
    M_MARGIN_VALAUTION ,--company_current_margin_ratio   ,
    M_FUTURE_MARGIN_MARKET_VALUE ,-- market_future_margin_ratio     ,
    M_FUTURE_MARGIN_VALAUTION, --company_future_margin_ratio   
    
    M_CURRENT_AVAILABILITY_REC,
    M_CURRENT_AVAILABILITY_APP, 
    M_VALUATION_ENHANCE_AMOUNT_REC,
    M_VALUATION_ENHANCE_AMOUNT_APP,
    M_CONCEN_ADJ_AMOUNT_REC,
    M_CONCEN_ADJ_AMOUNT_APP,
    M_DUE_REC_AMOUNT_REC,
    M_DUE_REC_AMOUNT_APP,
    DN_GET_CLIENT_AVAILABILITY(M_FACILITY_NO),
    M_SAVE_EVENT,
    DN_GET_MARGIN_FACTOR_SPOT(M_FACILITY_NO),
    DN_GET_MARGIN_FACTOR_SPOT_MKT(M_FACILITY_NO),
    M_PENDING_TRANSACTION
    );
    
    
END IF;
 COMMIT;
    
END ; 

/
