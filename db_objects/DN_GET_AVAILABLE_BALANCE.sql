--------------------------------------------------------
--  DDL for Function DN_GET_AVAILABLE_BALANCE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_AVAILABLE_BALANCE" 
(
M_DATE                  VARCHAR2,
M_PORTFOLIO_CODE        DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE,
M_USER                  DN_REF_USER.DN_USER%TYPE
 
 
 )
 RETURN VARCHAR2--NUMBER
 AS
 M_PF_TYPE          DN_REF_PORTFOLIO.PF_TYPE%TYPE;
 M_DATE_FROM        varchar(20);
 M_MAT_DATE_REPO    DATE;
 M_AMOUNT           NUMBER;
 M_COUNT            NUMBER;
 M_DUM_INT1  NUMBER;
  
 M_CLIENT_INITIAL_BALANCE NUMBER;
 M_CLIENT_RUN_BALANCE NUMBER;
 M_CLIENT_TOT_BALANCE NUMBER;
 M_UTILIZED_BALANCE NUMBER;
 M_INTEREST_INCOME NUMBER;
 M_CR_LIMIT NUMBER;
 M_UTILIZED_MARGING NUMBER;
  
 M_TOTAL_PROTFOLIO NUMBER;
 M_RATE NUMBER;
 M_AVAILABLE_BALANCE NUMBER;
 BEGIN
 M_dum_int1:=0;
 m_total_protfolio:=0;
 
  SELECT '01-'||TO_CHAR(TO_DATE(M_DATE,'DD-MM-YYYY'),'MM-YYYY')  into M_DATE_FROM
  FROM DUAL;
 
 --DN_RPT_MOVEMENT_REPORT (M_DATE_FROM,M_DATE,M_PORTFOLIO_CODE,M_USer); 
 --DN_RPT_CLIENT_PORTFOLIO_POS1(M_DATE,M_PORTFOLIO_CODE,M_USer);

           SELECT   SUM(NVL(VALUE,0)) VALUE INTO M_CLIENT_INITIAL_BALANCE
                     FROM DN_TEMP_MOVEMENT_REPORT
                     
                 WHERE --USER_NAME='PABCALL' AND
                     DESCRIPTION ='Balance' 
                --   ORDER BY SETT_DATE,DESCRIPTION 
                     ;
                     
                SELECT  SUM(decode(DESCRIPTION,'Sell',NVL(VALUE*-1,0),'Dividends',NVL(VALUE*-1,0),'Receipts', NVL(VALUE*-1,0),NVL(VALUE,0)   )    ) VALUE INTO M_CLIENT_RUN_BALANCE
                 FROM DN_TEMP_MOVEMENT_REPORT  WHERE 
                  DESCRIPTION in('Sell','Buy','Dividends','Payment','Receipts')
                 AND USER_NAME=M_USer ;    
                 
M_CLIENT_TOT_BALANCE:=M_CLIENT_INITIAL_BALANCE+M_CLIENT_RUN_BALANCE;
    
        
        
                
                SELECT SUM(nvl(INT_AMT,0)) INTO M_INTEREST_INCOME FROM( 
                     SELECT DEAL_NO,SUM(INT_AMOUNT) INT_AMT 
                     FROM DN_TRN_REPO_FRESH 
                     WHERE APP_STATUS='CONF' AND EFF_VALDATE>=TO_DATE(M_DATE_FROM,'DD-MM-YYYY') AND EFF_VALDATE<=TO_DATE(M_DATE,'DD-MM-YYYY') 
                     AND BORR_PORTFOLIO_CODE=M_PORTFOLIO_CODE GROUP BY DEAL_NO 
                     UNION 
                     SELECT DEAL_NO,SUM(INT_AMOUNT) INT_AMT 
                     FROM DN_TRN_REPO_ROLLOVER 
                     WHERE APP_STATUS='CONF' AND EFF_VALDATE>=TO_DATE(M_DATE_FROM,'DD-MM-YYYY') AND EFF_VALDATE<=TO_DATE(M_DATE,'DD-MM-YYYY') 
                     AND BORR_PORTFOLIO_CODE=M_PORTFOLIO_CODE GROUP BY DEAL_NO 
                     UNION 
                     SELECT DEAL_NO,SUM(-1*INT_AMOUNT) INT_AMT 
                     FROM DN_TRN_REPO_FRESH 
                     WHERE APP_STATUS='CONF' AND EFF_VALDATE>=TO_DATE(M_DATE_FROM,'DD-MM-YYYY') AND EFF_VALDATE<=TO_DATE(M_DATE,'DD-MM-YYYY') 
                     AND LEND_PORTFOLIO_CODE=M_PORTFOLIO_CODE GROUP BY DEAL_NO 
                     UNION 
                     SELECT DEAL_NO,SUM(-1*INT_AMOUNT) INT_AMT 
                     FROM DN_TRN_REPO_ROLLOVER 
                     WHERE APP_STATUS='CONF' AND EFF_VALDATE>=TO_DATE(M_DATE_FROM,'DD-MM-YYYY') AND EFF_VALDATE<=TO_DATE(M_DATE,'DD-MM-YYYY') 
                     AND LEND_PORTFOLIO_CODE=M_PORTFOLIO_CODE GROUP BY DEAL_NO 
                     );
            
                
                m_utilized_balance := M_CLIENT_TOT_BALANCE+m_interest_income;
                
 -- dbms_output.put_line('M_CLIENT_TOT_BALANCE'||M_CLIENT_TOT_BALANCE);
 
 -- dbms_output.put_line('m_utilized_balance'||m_utilized_balance);
 
 
 
 SELECT NVL(LIMIT,0) into m_cr_limit
                     FROM  DN_REF_PORTFOLIO 
                     WHERE PORTFOLIO_CODE=M_PORTFOLIO_CODE;
                    
 -- dbms_output.put_line('m_cr_limit'||m_cr_limit);
            
SELECT  SUM(nvl(MARKET_VALUE,0)) INTO m_total_protfolio FROM DN_TEMP_CLIENT_PORTF_POS1 
 WHERE PORTFOLIO_CODE=M_PORTFOLIO_CODE AND USER_NAME=M_USer  ;  
                                                                
            
                if m_total_protfolio>0 then
                    m_utilized_marging := (m_utilized_balance/m_total_protfolio)*100;
                else 
                    m_utilized_marging := 0.00;
                end if;
 
 
  SELECT --PF_NAME,DECODE(NVL(ADD_IDENTIFICATION,'-'),'-',' ',ADD_IDENTIFICATION),
                --  DECODE(NVL(ADD_LOCATION,'-'),'-',' ',ADD_LOCATION),
                --  DECODE(NVL(ADD_STREET,'-'),'-',' ',ADD_STREET),
                --  DECODE(NVL(ADD_CITY,'-'),'-',' ',ADD_CITY),
                --  DECODE(NVL(ADD_COUNTRY,'-'),'-',' ',ADD_COUNTRY),
                --  DECODE(NVL(POSTAL_CODE,'-'),'-',' ',POSTAL_CODE),
                --  DECODE(NVL(CDS_ACC_NO,'-'),'-',' ',CDS_ACC_NO),NVL(LIMIT,0), 
                     RATE  INTO M_RATE
                     FROM  DN_REF_PORTFOLIO 
                     WHERE PORTFOLIO_CODE=M_PORTFOLIO_CODE;
 
 
 
 
  dbms_output.put_line('m_utilized_marging'||m_utilized_marging);
  dbms_output.put_line('m_total_protfolio'||m_total_protfolio);
  
            m_total_protfolio:=nvl(m_total_protfolio,0);
            m_utilized_balance:=nvl(m_utilized_balance,0);
            M_cr_limit:=nvl(M_cr_limit,0);
            
                if m_utilized_marging >=50 then
                    /*
                    if (m_total_protfolio/2)>M_RATE then
                    m_available_balance :=M_RATE-m_utilized_balance;
                    dbms_output.put_line('m_available_balance1'||m_available_balance);          
                    else
                        m_available_balance := m_total_protfolio/2-m_utilized_balance;
                         dbms_output.put_line('m_available_balance2'||m_available_balance); 
                    end if;
                          */
                m_available_balance:=0;
                else 
                    -- dbms_output.put_line(m_total_protfolio||'%'||m_utilized_balance||'%'||M_cr_limit);   
                     
                    if ((((m_total_protfolio/2)-m_utilized_balance)*2) < (M_cr_limit - m_utilized_balance)) then
                        m_available_balance := ((m_total_protfolio/2)-m_utilized_balance)*2;
                        --dbms_output.put_line('m_available_balance3'||m_available_balance);    
                    else 
                        m_available_balance := M_cr_limit - m_utilized_balance;
                          --dbms_output.put_line('m_available_balance4'||m_available_balance);  
                    end if;
                end if;


 RETURN round( nvl(m_available_balance,0),3)||'@'||nvl(m_utilized_marging,0);

 END DN_GET_AVAILABLE_BALANCE;

/
