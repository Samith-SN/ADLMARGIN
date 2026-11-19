--------------------------------------------------------
--  DDL for Procedure DN_LOAN_AUTO_ALLOCATION_2
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_LOAN_AUTO_ALLOCATION_2" 
(

 M_FROMDATE                VARCHAR2,
 M_TODATE                  VARCHAR2
)

AS

 M_TOTAL_LOAN_MOVE           NUMBER(18,4):=0;
 M_PAY_REC_STILL_NOT_APPROVE NUMBER(18,4):=0;
 M_PAY_REC_VALID             NUMBER(18,4):=0;
 M_VALFROMDATE               DATE;
 M_VALTODATE                 DATE;

 M_RUNIING_TOT               NUMBER;
 M_LOAN_BALANCE           NUMBER;
 M_DN_TEMP_LOAN_GEN_C1      DN_TEMP_LOAN_GENERATION%ROWTYPE;
 M_DN_TEMP_LOAN_GEN_C2      DN_TEMP_LOAN_GENERATION%ROWTYPE;


CURSOR C1 IS

  SELECT *  
  FROM    DN_TEMP_LOAN_GENERATION A
  WHERE   A.TRN_TYPE<>'BUY'
  AND     ALLO_STATUS IS NULL
  FOR UPDATE OF  A.ALLO_STATUS,A.TRANSFERRED_AMOUNT
  ORDER BY PORTFOLIO_CODE,EXECUTE_ORDER ;--NOWAIT



BEGIN

DELETE DN_TEMP_LOAN_DEAL_ALLOCATION;

M_VALFROMDATE := TO_DATE(M_FROMDATE,'DD-MM-YYYY');
M_VALTODATE   := TO_DATE(M_TODATE,'DD-MM-YYYY');


    OPEN C1;
    LOOP
    FETCH C1 INTO M_DN_TEMP_LOAN_GEN_C1;

    IF C1%NOTFOUND THEN
      
      EXIT WHEN C1%NOTFOUND;

    ELSE


             /*
             || CHANGE STATUS IN CURENT ROW AS PROGRESSING (P)
             */



                 DBMS_OUTPUT.PUT_LINE(M_DN_TEMP_LOAN_GEN_C1.PORTFOLIO_CODE||' READY TO COMAIRE '||M_DN_TEMP_LOAN_GEN_C1.TRN_TYPE||'**'||M_RUNIING_TOT||'=**'||NVL(M_DN_TEMP_LOAN_GEN_C1.TOT,0)||'*-*'||NVL(M_DN_TEMP_LOAN_GEN_C1.TRANSFERRED_AMOUNT,0)||'*+*'||NVL(M_DN_TEMP_LOAN_GEN_C1.ALLO_AMOUNT,0));
                 UPDATE DN_TEMP_LOAN_GENERATION
                 SET ALLO_STATUS = 'P'
                 WHERE CURRENT OF C1;
             
                M_RUNIING_TOT :=  NVL(M_DN_TEMP_LOAN_GEN_C1.abstot,0) 
                   - NVL(DN_GET_LOAN_DEAL_ALLO_AMOUNT(M_DN_TEMP_LOAN_GEN_C1.DOCREFNO),0)
                   + NVL(DN_GET_LOAN_DEAL_TRNSF_AMOUNT(M_DN_TEMP_LOAN_GEN_C1.DOCREFNO),0);

      
             IF M_RUNIING_TOT > 0 AND M_DN_TEMP_LOAN_GEN_C1.TOT < 0 THEN


            FOR X IN (
            
                SELECT DEAL_NO,LEG2_VALUE
                FROM   DN_TRN_REPO_FRESH
                WHERE  APP_STATUS = 'CONF'
                AND    ON_CALL_DEAL = 'N'
                ORDER BY  EFF_VALDATE
            
            
            )LOOP 
            
                M_RUNIING_TOT :=  NVL(M_DN_TEMP_LOAN_GEN_C1.abstot,0) 
                   --- NVL(DN_GET_LOAN_DEAL_ALLO_AMOUNT(M_DN_TEMP_LOAN_GEN_C1.DOCREFNO),0)
                   - NVL(DN_GET_LOAN_DEAL_TRNSF_AMOUNT(M_DN_TEMP_LOAN_GEN_C1.DOCREFNO),0);

            
               M_LOAN_BALANCE :=  NVL(X.LEG2_VALUE,0)
                                - NVL(DN_GET_LOAN_DEAL_ALLO_AMOUNT(X.DEAL_NO),0);
                             -- + NVL(DN_GET_LOAN_DEAL_TRNSF_AMOUNT(X.DEAL_NO),0);
                              
                               DBMS_OUTPUT.PUT_LINE('M_LOAN_BALANCE => '||M_LOAN_BALANCE);
                              
                                IF NVL(M_LOAN_BALANCE,0) >= NVL(M_RUNIING_TOT,0) THEN

                                   DBMS_OUTPUT.PUT_LINE('EX 1 ');
                
                
                                              UPDATE DN_TEMP_LOAN_GENERATION
                                              SET ALLO_STATUS = 'U',
                                                  ALLO_AMOUNT =NVL(ALLO_AMOUNT,0)+NVL(M_RUNIING_TOT,0)
                                              WHERE CURRENT OF C1;
                
                                        DN_LOAN_DEAL_ALLOCATION_SAVE(X.DEAL_NO, M_DN_TEMP_LOAN_GEN_C1.DOCREFNO,M_RUNIING_TOT,'Y',M_VALTODATE);
                
                
                                  ELSIF  NVL(M_LOAN_BALANCE,0) < NVL(M_RUNIING_TOT,0)  THEN
                
                                                      UPDATE DN_TEMP_LOAN_GENERATION
                                                                          SET ALLO_STATUS = 'U',
                                                                              ALLO_AMOUNT =NVL(ALLO_AMOUNT,0)+NVL(M_LOAN_BALANCE,0)
                                                                          WHERE CURRENT OF C1;
                                            
                                                     DN_LOAN_DEAL_ALLOCATION_SAVE(X.DEAL_NO, M_DN_TEMP_LOAN_GEN_C1.DOCREFNO,NVL(M_LOAN_BALANCE,0),'Y',M_VALTODATE);
                                            
                                                     
                                            
                                            
                                        ELSE
                                                    dbms_output.put_line('ERROR ');
                                        END IF ;  
                              
                              
                
            
            
            END LOOP;
            
            
               END IF; --   IF M_RUNIING_TOT > 0 AND M_DN_TEMP_LOAN_GEN_C1.TOT < 0 THEN
        
          END IF; 

      END LOOP;
     CLOSE C1;
     
     
COMMIT;


END ;

/
