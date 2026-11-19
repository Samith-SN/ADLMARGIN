--------------------------------------------------------
--  DDL for Function DN_GET_OPENING_BALANCE_BF
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_OPENING_BALANCE_BF" 
(
 M_DATE                  VARCHAR2,
 M_PORTFOLIO_CODE        DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE
 )
 RETURN NUMBER
 AS
 M_PF_TYPE          DN_REF_PORTFOLIO.PF_TYPE%TYPE;
 M_MAT_DATE_REPO    DATE;
 M_MAT_DATE_SETE    DATE;
 M_MAT_DATE_SETE1   DATE;
 M_AMOUNT           NUMBER;
 
 
M_INT_AMOUNT             NUMBER;
M_INT_AMOUNT_LAST_MONTH  NUMBER;
M_LAST_MONTH_LAST_DAY    DATE;
M_COUNT                  NUMBER;
M_COUNT_DEAL             NUMBER;
M_EFF_VALDATE            DATE;
M_DEAL_NO                DN_TRN_REPO_FRESH.DEAL_NO%TYPE;
IS_FIRST_OF_MONTH        VARCHAR(25);

M_LEG1_VALUE            DN_TRN_REPO_FRESH.LEG1_VALUE%TYPE;
M_LEG2_VALUE            DN_TRN_REPO_FRESH.LEG2_VALUE%TYPE;
M_BORR_PORTFOLIO_CODE   DN_TRN_REPO_FRESH.BORR_PORTFOLIO_CODE%TYPE;
M_LEND_PORTFOLIO_CODE   DN_TRN_REPO_FRESH.LEND_PORTFOLIO_CODE%TYPE;
 BEGIN


M_INT_AMOUNT_LAST_MONTH := 0;

SELECT Count(*)
INTO   M_COUNT
FROM
(
SELECT BORR_PORTFOLIO_CODE 
FROM   DN_TRN_REPO_FRESH
WHERE  BORR_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
       TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') <   TO_DATE(M_DATE,'DD-MM-YYYY') AND
       TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') >=   TO_DATE('08-10-2010','DD-MM-YYYY') AND
       APP_STATUS    = 'CONF'
UNION ALL

SELECT LEND_PORTFOLIO_CODE 
FROM   DN_TRN_REPO_FRESH
WHERE  LEND_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
       TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') <   TO_DATE(M_DATE,'DD-MM-YYYY') AND
       TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') >=   TO_DATE('08-10-2010','DD-MM-YYYY') AND
       APP_STATUS    = 'CONF'
       
UNION ALL
SELECT BORR_PORTFOLIO_CODE 
FROM   DN_TRN_REPO_ROLLOVER
WHERE  BORR_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
       TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') <   TO_DATE(M_DATE,'DD-MM-YYYY') AND
       TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') >=   TO_DATE('08-10-2010','DD-MM-YYYY') AND
       APP_STATUS    = 'CONF'
   UNION ALL
SELECT LEND_PORTFOLIO_CODE 
FROM   DN_TRN_REPO_ROLLOVER
WHERE  LEND_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
       TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') <   TO_DATE(M_DATE,'DD-MM-YYYY') AND
       TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') >=   TO_DATE('08-10-2010','DD-MM-YYYY') AND
       APP_STATUS    = 'CONF'
       );
       
if M_COUNT>0 then
                        dbms_output.put_line('Data Found .........');
                        
                        M_AMOUNT :=0;
                        
                        
                        SELECT MAX(EFF_VALDATE)
                        INTO   M_EFF_VALDATE
                        FROM
                        (
                        SELECT EFF_VALDATE 
                        FROM   DN_TRN_REPO_FRESH
                        WHERE  BORR_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                               TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') <   TO_DATE(M_DATE,'DD-MM-YYYY') AND
                               TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') >=   TO_DATE('08-10-2010','DD-MM-YYYY') AND
                               APP_STATUS    = 'CONF'
                        UNION ALL
                        
                        SELECT EFF_VALDATE 
                        FROM   DN_TRN_REPO_FRESH
                        WHERE  LEND_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                               TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') <   TO_DATE(M_DATE,'DD-MM-YYYY') AND
                               TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') >=   TO_DATE('08-10-2010','DD-MM-YYYY') AND
                               APP_STATUS    = 'CONF'
                               
                        UNION ALL
                        SELECT EFF_VALDATE 
                        FROM   DN_TRN_REPO_ROLLOVER
                        WHERE  BORR_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                               TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') <   TO_DATE(M_DATE,'DD-MM-YYYY') AND
                               TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') >=   TO_DATE('08-10-2010','DD-MM-YYYY') AND
                               APP_STATUS    = 'CONF'
                        UNION ALL
                        SELECT EFF_VALDATE 
                        FROM   DN_TRN_REPO_ROLLOVER
                        WHERE  LEND_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                               TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') <   TO_DATE(M_DATE,'DD-MM-YYYY') AND
                               TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') >=   TO_DATE('08-10-2010','DD-MM-YYYY') AND
                               APP_STATUS    = 'CONF'
                               );

                          dbms_output.put_line('select MAX MATURITY DATE is '||M_EFF_VALDATE);
                          
                          
                          
                          
                        SELECT Count(DEAL_NO)
                        INTO   M_COUNT_DEAL
                        FROM
                        (
                        SELECT DEAL_NO 
                        FROM   DN_TRN_REPO_FRESH
                        WHERE  BORR_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                               TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')  =   M_EFF_VALDATE AND
                               APP_STATUS    = 'CONF'
                        UNION ALL
                        
                        SELECT DEAL_NO 
                        FROM   DN_TRN_REPO_FRESH
                        WHERE  LEND_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                               TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')  =   M_EFF_VALDATE AND
                               APP_STATUS    = 'CONF'
                               
                        UNION ALL
                        SELECT DEAL_NO 
                        FROM   DN_TRN_REPO_ROLLOVER
                        WHERE  BORR_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                               TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')  = M_EFF_VALDATE AND
                               APP_STATUS    = 'CONF'
                        UNION ALL
                        SELECT DEAL_NO 
                        FROM   DN_TRN_REPO_ROLLOVER
                        WHERE  LEND_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                               TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')  =  M_EFF_VALDATE AND
                               APP_STATUS    = 'CONF'
                               );
                       dbms_output.put_line('No of Deals '||M_COUNT_DEAL);
                          
                          
                        IF M_COUNT_DEAL=1 THEN 
                          
                          
                                              
                                            SELECT DEAL_NO
                                            INTO   M_DEAL_NO
                                            FROM
                                            (
                                            SELECT DEAL_NO 
                                            FROM   DN_TRN_REPO_FRESH
                                            WHERE  BORR_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                                                   TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')  =   M_EFF_VALDATE AND
                                                   APP_STATUS    = 'CONF'
                                            UNION ALL
                                            
                                            SELECT DEAL_NO 
                                            FROM   DN_TRN_REPO_FRESH
                                            WHERE  LEND_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                                                   TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')  =   M_EFF_VALDATE AND
                                                   APP_STATUS    = 'CONF'
                                                   
                                            UNION ALL
                                            SELECT DEAL_NO 
                                            FROM   DN_TRN_REPO_ROLLOVER
                                            WHERE  BORR_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                                                   TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')  = M_EFF_VALDATE AND
                                                   APP_STATUS    = 'CONF'
                                            UNION ALL
                                            SELECT DEAL_NO 
                                            FROM   DN_TRN_REPO_ROLLOVER
                                            WHERE  LEND_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                                                   TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')  =  M_EFF_VALDATE AND
                                                   APP_STATUS    = 'CONF'
                                                   );
                                              
                                              dbms_output.put_line('Select a Deal ='||M_DEAL_NO);
                           
                                              
                                              IF SUBSTR(M_DEAL_NO,0,2)='RF' THEN 
                                              dbms_output.put_line(' Deal '||M_DEAL_NO||' is repo fresh');
                                                    --*****************************************************************************************--
                                                  
                                                    SELECT DEAL_NO,LEG1_VALUE,LEG2_VALUE,BORR_PORTFOLIO_CODE,LEND_PORTFOLIO_CODE
                                                    INTO   M_DEAL_NO,M_LEG1_VALUE,M_LEG2_VALUE,M_BORR_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE
                                                    FROM   DN_TRN_REPO_FRESH
                                                    WHERE  DEAL_NO = M_DEAL_NO AND
                                                    --TO_DATE(TO_CHAR(MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')  =   M_MAX_MATURITY_DATE AND
                                                    APP_STATUS    = 'CONF';
                                                     
                                                    M_AMOUNT:=M_AMOUNT+M_LEG1_VALUE;
                                                  
                                                    SELECT count(nvl('FIRST_OF_MONTH','- ')) INTO IS_FIRST_OF_MONTH FROM DUAL WHERE to_date('01'||to_char(to_date(M_DATE,'dd/mm/yyyy'),'/mm/yyyy'),'dd/mm/yyyy')=TO_DATE(M_DATE,'DD/MM/YYYY');
                                                  
                                                    IF  IS_FIRST_OF_MONTH >0 THEN 
                                                    
                                                        SELECT ADD_MONTHS(LAST_DAY(M_EFF_VALDATE),0) INTO M_LAST_MONTH_LAST_DAY FROM DUAL; 
                                                         M_INT_AMOUNT_LAST_MONTH := DN_GET_MONTH_INTEREST(TO_CHAR(M_LAST_MONTH_LAST_DAY,'DD-MM-YYYY'),M_PORTFOLIO_CODE)+NVL(DN_GET_OD_ACCRUED_INTEREST(M_PORTFOLIO_CODE,TRUNC(M_LAST_MONTH_LAST_DAY, 'MONTH'),M_LAST_MONTH_LAST_DAY),0);--NEED TO WRITE A FUNTION  --add OD INTEREST BY WARUNA 2012-01-06                                  
                                                                       -- M_AMOUNT := M_AMOUNT-M_INT_AMOUNT_LAST_MONTH;
                                                                   DBMS_OUTPUT.PUT_LINE('ADD LAST MONTH INTERST ='||M_INT_AMOUNT_LAST_MONTH);
                                                    END IF ;
                                                    
                                                    IF  M_LEND_PORTFOLIO_CODE=M_PORTFOLIO_CODE THEN 
                                                        M_AMOUNT      := M_AMOUNT-M_INT_AMOUNT_LAST_MONTH;
                                                        M_AMOUNT:=M_AMOUNT*-1;
                                                    ELSE 
                                                        M_AMOUNT      := M_AMOUNT+M_INT_AMOUNT_LAST_MONTH;
                                                        M_AMOUNT:=M_AMOUNT;
                                                    END IF;
                                                    --******************************************************************************************--
                                                    
                                              ELSIF SUBSTR(M_DEAL_NO,0,2)='RR' THEN 
                                               dbms_output.put_line(' Deal '||M_DEAL_NO||' is Rollover');
                                               --*--***********************************************************************************--*--
                                                  SELECT DEAL_NO,LEG1_VALUE,LEG2_VALUE,BORR_PORTFOLIO_CODE,LEND_PORTFOLIO_CODE
                                                  INTO   M_DEAL_NO,M_LEG1_VALUE,M_LEG2_VALUE,M_BORR_PORTFOLIO_CODE,M_LEND_PORTFOLIO_CODE
                                                  FROM   DN_TRN_REPO_ROLLOVER
                                                  WHERE  DEAL_NO = M_DEAL_NO AND
                                                 -- MATURITY_DATE =  M_MAX_MATURITY_DATE AND
                                                  APP_STATUS    = 'CONF';
                                              
                                                   M_AMOUNT:=M_AMOUNT+M_LEG1_VALUE;
                                                 
                                                    SELECT count(nvl('FIRST_OF_MONRTYH','-')) INTO IS_FIRST_OF_MONTH FROM DUAL WHERE to_date('01'||to_char(to_date(M_DATE,'dd/mm/yyyy'),'/mm/yyyy'),'dd/mm/yyyy')=TO_DATE(M_DATE,'DD/MM/YYYY');
--                                                  RAISE_APPLICATION_ERROR (-20001,'IS_FIRST_OF_MONTH --->>>' ||IS_FIRST_OF_MONTH);
                                                  
                                                    IF   IS_FIRST_OF_MONTH>0 THEN 
                                                         SELECT ADD_MONTHS(LAST_DAY(M_EFF_VALDATE),0) INTO M_LAST_MONTH_LAST_DAY FROM DUAL; 
                                                         M_INT_AMOUNT_LAST_MONTH := DN_GET_MONTH_INTEREST(TO_CHAR(M_LAST_MONTH_LAST_DAY,'DD-MM-YYYY'),M_PORTFOLIO_CODE) + NVL(DN_GET_OD_ACCRUED_INTEREST(M_PORTFOLIO_CODE,TRUNC(M_LAST_MONTH_LAST_DAY, 'MONTH'),M_LAST_MONTH_LAST_DAY),0);--NEED TO WRITE A FUNTION    --add OD Interest by waruna 2012-01-06                                
                                                      --             M_AMOUNT      := M_AMOUNT+M_INT_AMOUNT_LAST_MONTH;
                                                                   dbms_output.put_line('Add last Month Interst -'||M_INT_AMOUNT_LAST_MONTH);
                                                    END IF;
                                                    
                                                    
                                                    IF  M_LEND_PORTFOLIO_CODE=M_PORTFOLIO_CODE THEN 
                                                        M_AMOUNT      := M_AMOUNT-M_INT_AMOUNT_LAST_MONTH;
                                                        M_AMOUNT:=M_AMOUNT*-1;
                                                    ELSE 
                                                        M_AMOUNT      := M_AMOUNT+M_INT_AMOUNT_LAST_MONTH;
                                                        M_AMOUNT:=M_AMOUNT;
                                                    END IF;
                                              
                                                 --*--***********************************************************************************--*--
                                              ELSE
                                              dbms_output.put_line('CAN NOT IDENTIFY DEAL so calculation fail');
                                              END IF;
                                              
                                              
                          
                          ELSIF M_COUNT_DEAL=0 THEN 
                              DBMS_OUTPUT.PUT_LINE('THERE ARE NO DEALS SO CALCULATION FAIL');
                          ELSE
                             DBMS_OUTPUT.PUT_LINE('THERE ARE '||M_COUNT_DEAL||'DEALS SO CALCULATION FAIL');
                          END IF;


 ELSE
      dbms_output.put_line('No Data Found So Amount is Zero ');
      M_AMOUNT :=0;---No any records in repo and rollover table 
 END IF;

   RETURN  M_AMOUNT;

 END DN_GET_OPENING_BALANCE_BF; 

/
