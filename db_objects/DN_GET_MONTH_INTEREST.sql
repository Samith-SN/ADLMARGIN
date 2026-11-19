--------------------------------------------------------
--  DDL for Function DN_GET_MONTH_INTEREST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_MONTH_INTEREST" 
(
 M_DATE                  VARCHAR2,
 M_PORTFOLIO_CODE        DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE
 )
 RETURN NUMBER
 AS
 
M_LAST_MONTH_DATE      VARCHAR(100);
M_TMP_FROM_DATE        VARCHAR(100);
M_FIRST_DAY_OF_MONTH   VARCHAR(100);
M_INT_AMOUNT           NUMBER;
 BEGIN


 -- FOR x IN M_CURSOR1 LOOP 
    

   
                       M_LAST_MONTH_DATE:=TO_CHAR(LAST_DAY(TO_DATE(M_DATE,'DD/MM/YYYY')),'DD-MM-YYYY');
                       --  DBMS_OUTPUT.PUT_LINE(X.LAST_MONTH_DATE);
                      
                        SELECT TO_CHAR(TO_DATE('01'||TO_CHAR(TO_DATE(M_LAST_MONTH_DATE,'DD/MM/YYYY'),'/MM/YYYY'),'DD/MM/YYYY'),'DD/MM/YYYY')
					    INTO M_FIRST_DAY_OF_MONTH
                        FROM DUAL; 
                        
           
                       
                        
     DBMS_OUTPUT.PUT_LINE('M_FIRST_DAY_OF_MONTH '||M_FIRST_DAY_OF_MONTH);                   
     DBMS_OUTPUT.PUT_LINE('LAST_MONTH_DATE'||M_LAST_MONTH_DATE);



   
           SELECT NVL(SUM(INT_AMOUNT),0) INTO M_INT_AMOUNT FROM(
           
                         SELECT INT_AMOUNT
                         FROM   DN_TRN_REPO_FRESH A,DN_REF_PORTFOLIO B
                         WHERE  BORR_PORTFOLIO_CODE= B.PORTFOLIO_CODE AND
                                TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') >=  TO_DATE(m_first_day_of_month,'DD/MM/YYYY') AND
                                TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') <=   TO_DATE(M_LAST_MONTH_DATE,'DD/MM/YYYY')  AND
                                TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') >=   TO_DATE('01-10-2010','DD-MM-YYYY') AND
                                BORR_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                                APP_STATUS   = 'CONF'
                         UNION ALL
                         SELECT INT_AMOUNT
                         FROM   DN_TRN_REPO_ROLLOVER A,DN_REF_PORTFOLIO B
                         WHERE  BORR_PORTFOLIO_CODE= B.PORTFOLIO_CODE AND
                                TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') >=   TO_DATE(m_first_day_of_month,'DD/MM/YYYY') AND
                                TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') <=   TO_DATE(M_LAST_MONTH_DATE,'DD/MM/YYYY')  AND
                                TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') >=   TO_DATE('01-10-2010','DD-MM-YYYY') AND
                                BORR_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                               --ON_CALL_DEAL = 'Y' AND
                                APP_STATUS   = 'CONF'
                        -------------------@@@@@@@@@@@@@@@@@@@@@@@@
                        UNION ALL
                        SELECT INT_AMOUNT*-1
                         FROM   DN_TRN_REPO_FRESH A,DN_REF_PORTFOLIO B
                         WHERE  LEND_PORTFOLIO_CODE= B.PORTFOLIO_CODE AND
                                TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') >=  TO_DATE(m_first_day_of_month,'DD/MM/YYYY') AND
                                TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') <=  TO_DATE(M_LAST_MONTH_DATE,'DD/MM/YYYY')   AND
                                TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') >=   TO_DATE('01-10-2010','DD-MM-YYYY') AND
                                LEND_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                                APP_STATUS   = 'CONF'
                         UNION ALL
                         SELECT INT_AMOUNT*-1
                         FROM   DN_TRN_REPO_ROLLOVER A,DN_REF_PORTFOLIO B
                         WHERE  LEND_PORTFOLIO_CODE= B.PORTFOLIO_CODE AND
                                TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') >=   TO_DATE(m_first_day_of_month,'DD/MM/YYYY') AND
                                TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') <=   TO_DATE(M_LAST_MONTH_DATE,'DD/MM/YYYY')  AND
                                TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY') >=   TO_DATE('01-10-2010','DD-MM-YYYY') AND
                                LEND_PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                               --ON_CALL_DEAL = 'Y' AND
                                APP_STATUS   = 'CONF'
                        
                        -------------------@@@@@@@@@@@@@@@@@@@@@@@@
                        
                              
                              );
   
    
   
--RAISE_APPLICATION_ERROR (-20001,'RETURNN INT AMOUNT -------->>>>>>>>>>>>' ||M_INT_AMOUNT);  
 -- END LOOP;  

RETURN M_INT_AMOUNT;
 END ;

/
