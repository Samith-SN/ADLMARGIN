--------------------------------------------------------
--  DDL for Procedure DN_LOAN_AUTO_ALLOCATION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_LOAN_AUTO_ALLOCATION" 
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
 M_RUNIING_SUB_TOT           NUMBER;
 M_DN_TEMP_LOAN_GEN_C1      DN_TEMP_LOAN_GENERATION%ROWTYPE;
 M_DN_TEMP_LOAN_GEN_C2      DN_TEMP_LOAN_GENERATION%ROWTYPE;

CURSOR C1 IS
SELECT *  FROM DN_TEMP_LOAN_GENERATION A
  WHERE A.TRN_TYPE<>'BUY'
  AND ALLO_STATUS IS NULL
  FOR UPDATE OF  A.ALLO_STATUS,A.TRANSFERRED_AMOUNT
  ORDER BY PORTFOLIO_CODE,EXECUTE_ORDER ;--NOWAIT


 CURSOR C2(M_TRN_TYPE_C2           DN_TEMP_LOAN_GENERATION.TRN_TYPE%TYPE,
           M_PORTFOLIO_CODE_C2     DN_TEMP_LOAN_GENERATION.PORTFOLIO_CODE%TYPE )
         IS  SELECT *
             FROM DN_TEMP_LOAN_GENERATION a
             WHERE A.TRN_TYPE   = M_TRN_TYPE_C2
             AND PORTFOLIO_CODE = M_PORTFOLIO_CODE_C2
             AND ALLO_STATUS IS NULL
             FOR UPDATE OF  TRANSFERRED_AMOUNT,ALLO_AMOUNT,ALLO_STATUS ;


 BEGIN
 dbms_output.put_line('gg');

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
---------------------------------------------------------------------------------------------------
/*
||
|| WITHDRAWAL
||
*/



    IF M_DN_TEMP_LOAN_GEN_C1.TRN_TYPE ='CW' THEN  -- C1--> CW  allo ,C2--> -CD
    /*
    ||
    || WITHDRAWAL  --> DEPOSIT
    ||
     */

    OPEN  C2('CD',M_DN_TEMP_LOAN_GEN_C1.PORTFOLIO_CODE);
    LOOP

    DBMS_OUTPUT.PUT_LINE('*****CD LOOP');
    FETCH C2 INTO M_DN_TEMP_LOAN_GEN_C2;
     DBMS_OUTPUT.PUT_LINE('*****CD LOOP 2');

   -- M_RUNIING_TOT:= NVL(M_DN_TEMP_LOAN_GEN_C1.TOT,0)-NVL(M_DN_TEMP_LOAN_GEN_C1.TRANSFERRED_AMOUNT,0)+NVL(M_DN_TEMP_LOAN_GEN_C1.ALLO_AMOUNT,0);
   M_RUNIING_TOT :=  NVL(M_DN_TEMP_LOAN_GEN_C1.TOT,0)
                   + NVL(DN_GET_LOAN_DEAL_ALLO_AMOUNT(M_DN_TEMP_LOAN_GEN_C1.DOCREFNO),0)
                   - NVL(DN_GET_LOAN_DEAL_TRNSF_AMOUNT(M_DN_TEMP_LOAN_GEN_C1.DOCREFNO),0);
    IF C2%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('*****CD LOOP NOT FOUND');
        EXIT WHEN C2%NOTFOUND;
    ELSE



        DBMS_OUTPUT.PUT_LINE('1 FOUND '||M_DN_TEMP_LOAN_GEN_C2.TRN_TYPE||'**'||M_RUNIING_TOT||'>'||M_DN_TEMP_LOAN_GEN_C2.TOT||'+'||NVL(M_DN_TEMP_LOAN_GEN_C2.ALLO_AMOUNT,0)||'-'||NVL(M_DN_TEMP_LOAN_GEN_C2.ALLO_AMOUNT,0));

           M_RUNIING_SUB_TOT :=  NVL(M_DN_TEMP_LOAN_GEN_C2.TOT,0)
                              + NVL(DN_GET_LOAN_DEAL_ALLO_AMOUNT(M_DN_TEMP_LOAN_GEN_C2.DOCREFNO),0)
                              - NVL(DN_GET_LOAN_DEAL_TRNSF_AMOUNT(M_DN_TEMP_LOAN_GEN_C2.DOCREFNO),0);
       DBMS_OUTPUT.PUT_LINE('1 FOUND '|| NVL(M_RUNIING_TOT,0)||'**'||NVL(M_RUNIING_SUB_TOT,0));
         IF NVL(M_RUNIING_TOT,0)+NVL(M_RUNIING_SUB_TOT,0)<=0 THEN

             DBMS_OUTPUT.PUT_LINE('EX 1 ');

                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET ALLO_STATUS = 'A',
                                  ALLO_AMOUNT =NVL(ALLO_AMOUNT,0)+NVL(M_RUNIING_TOT,0)
                              WHERE CURRENT OF C2;

                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET ALLO_STATUS = 'U',
                                  TRANSFERRED_AMOUNT =NVL(TRANSFERRED_AMOUNT,0)+NVL(M_RUNIING_TOT,0)
                              WHERE CURRENT OF C1;

         DN_LOAN_DEAL_ALLOCATION_SAVE(M_DN_TEMP_LOAN_GEN_C2.DOCREFNO, M_DN_TEMP_LOAN_GEN_C1.DOCREFNO,M_RUNIING_TOT,'Y',M_VALTODATE);


         ELSIF  M_RUNIING_TOT+M_RUNIING_SUB_TOT> 0 THEN

         DBMS_OUTPUT.PUT_LINE('EX 2');

        /*                     UPDATE DN_TEMP_LOAN_GENERATION
                              SET ALLO_STATUS = 'A',
                                  ALLO_AMOUNT =NVL(ALLO_AMOUNT,0)+NVL(M_RUNIING_SUB_TOT,0)-NVL(M_RUNIING_TOT,0)
                              WHERE CURRENT OF C2;

                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET ALLO_STATUS = 'U',
                                  TRANSFERRED_AMOUNT =NVL(TRANSFERRED_AMOUNT,0)+NVL(M_DN_TEMP_LOAN_GEN_C2.TOT,0)+NVL(M_DN_TEMP_LOAN_GEN_C2.ALLO_AMOUNT,0)
                              WHERE CURRENT OF C1;

         DN_LOAN_DEAL_ALLOCATION_SAVE(M_DN_TEMP_LOAN_GEN_C2.DOCREFNO, M_DN_TEMP_LOAN_GEN_C1.DOCREFNO,NVL(M_RUNIING_SUB_TOT,0)-NVL(M_RUNIING_TOT,0),'Y');
        */
         IF ABS(M_RUNIING_TOT) >ABS(M_RUNIING_SUB_TOT) THEN

         DBMS_OUTPUT.PUT_LINE('EX 2.1');
                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET ALLO_STATUS = 'A',
                                  ALLO_AMOUNT =NVL(ALLO_AMOUNT,0)+NVL(M_RUNIING_SUB_TOT,0)*(-1)
                              WHERE CURRENT OF C2;

                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET ALLO_STATUS = 'U',
                                  TRANSFERRED_AMOUNT =NVL(TRANSFERRED_AMOUNT,0)+NVL(M_RUNIING_SUB_TOT,0)*(-1)
                              WHERE CURRENT OF C1;

         DN_LOAN_DEAL_ALLOCATION_SAVE(M_DN_TEMP_LOAN_GEN_C2.DOCREFNO, M_DN_TEMP_LOAN_GEN_C1.DOCREFNO,NVL(M_RUNIING_SUB_TOT,0)*(-1),'Y',M_VALTODATE);



         ELSE
         DBMS_OUTPUT.PUT_LINE('EX 2.2');
                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET ALLO_STATUS = 'A',
                                  ALLO_AMOUNT =NVL(ALLO_AMOUNT,0)+NVL(M_RUNIING_SUB_TOT,0)
                              WHERE CURRENT OF C2;

                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET ALLO_STATUS = 'U',
                                  TRANSFERRED_AMOUNT =NVL(TRANSFERRED_AMOUNT,0)+NVL(M_RUNIING_SUB_TOT,0)
                              WHERE CURRENT OF C1;

         DN_LOAN_DEAL_ALLOCATION_SAVE(M_DN_TEMP_LOAN_GEN_C2.DOCREFNO, M_DN_TEMP_LOAN_GEN_C1.DOCREFNO,NVL(M_RUNIING_SUB_TOT,0)-NVL(M_RUNIING_TOT,0),'Y',M_VALTODATE);

         END IF;


        ELSE
        dbms_output.put_line('ERROR ');
         END IF ;

   END IF ;







   END LOOP;
   CLOSE C2;


   /*
    ||
    || WITHDRAWAL  --> SALES
    ||
     */
   OPEN  C2('SELL',M_DN_TEMP_LOAN_GEN_C1.PORTFOLIO_CODE);
    LOOP
    DBMS_OUTPUT.PUT_LINE('*****SELL LOOP');
    FETCH C2 INTO M_DN_TEMP_LOAN_GEN_C2;

   -- M_RUNIING_TOT:= NVL(M_DN_TEMP_LOAN_GEN_C1.TOT,0)-NVL(M_DN_TEMP_LOAN_GEN_C1.TRANSFERRED_AMOUNT,0)+NVL(M_DN_TEMP_LOAN_GEN_C1.ALLO_AMOUNT,0);
   M_RUNIING_TOT :=  NVL(M_DN_TEMP_LOAN_GEN_C1.TOT,0)
                   + NVL(DN_GET_LOAN_DEAL_ALLO_AMOUNT(M_DN_TEMP_LOAN_GEN_C1.DOCREFNO),0)
                   - NVL(DN_GET_LOAN_DEAL_TRNSF_AMOUNT(M_DN_TEMP_LOAN_GEN_C1.DOCREFNO),0);
    IF C2%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('*****');
        EXIT WHEN C2%NOTFOUND;
    ELSE



        DBMS_OUTPUT.PUT_LINE('2 FOUND '||M_DN_TEMP_LOAN_GEN_C2.TRN_TYPE||'**'||M_RUNIING_TOT||'>'||M_DN_TEMP_LOAN_GEN_C2.TOT||'+'||NVL(M_DN_TEMP_LOAN_GEN_C2.ALLO_AMOUNT,0)||'-'||NVL(M_DN_TEMP_LOAN_GEN_C2.ALLO_AMOUNT,0));

           M_RUNIING_SUB_TOT :=  NVL(M_DN_TEMP_LOAN_GEN_C2.TOT,0)
                              + NVL(DN_GET_LOAN_DEAL_ALLO_AMOUNT(M_DN_TEMP_LOAN_GEN_C2.DOCREFNO),0)
                              - NVL(DN_GET_LOAN_DEAL_TRNSF_AMOUNT(M_DN_TEMP_LOAN_GEN_C2.DOCREFNO),0);

         IF M_RUNIING_TOT+M_RUNIING_SUB_TOT<=0 THEN

             DBMS_OUTPUT.PUT_LINE('EX 1 ');

                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET ALLO_STATUS = 'A',
                                  ALLO_AMOUNT =NVL(ALLO_AMOUNT,0)+NVL(M_RUNIING_TOT,0)
                              WHERE CURRENT OF C2;

                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET ALLO_STATUS = 'U',
                                  TRANSFERRED_AMOUNT =NVL(TRANSFERRED_AMOUNT,0)+NVL(M_RUNIING_TOT,0)
                              WHERE CURRENT OF C1;

         DN_LOAN_DEAL_ALLOCATION_SAVE(M_DN_TEMP_LOAN_GEN_C2.DOCREFNO, M_DN_TEMP_LOAN_GEN_C1.DOCREFNO,M_RUNIING_TOT,'Y',M_VALTODATE);


         ELSIF  M_RUNIING_TOT+M_RUNIING_SUB_TOT> 0 THEN

         IF ABS(M_RUNIING_TOT) >ABS(M_RUNIING_SUB_TOT) THEN

         DBMS_OUTPUT.PUT_LINE('EX 2.1');
                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET ALLO_STATUS = 'A',
                                  ALLO_AMOUNT =NVL(ALLO_AMOUNT,0)+NVL(M_RUNIING_SUB_TOT,0)*(-1)
                              WHERE CURRENT OF C2;

                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET ALLO_STATUS = 'U',
                                  TRANSFERRED_AMOUNT =NVL(TRANSFERRED_AMOUNT,0)+NVL(M_RUNIING_SUB_TOT,0)*(-1)
                              WHERE CURRENT OF C1;

         DN_LOAN_DEAL_ALLOCATION_SAVE(M_DN_TEMP_LOAN_GEN_C2.DOCREFNO, M_DN_TEMP_LOAN_GEN_C1.DOCREFNO,NVL(M_RUNIING_SUB_TOT,0)*(-1),'Y',M_VALTODATE);



         ELSE
         DBMS_OUTPUT.PUT_LINE('EX 2.2');
                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET ALLO_STATUS = 'A',
                                  ALLO_AMOUNT =NVL(ALLO_AMOUNT,0)+NVL(M_RUNIING_SUB_TOT,0)
                              WHERE CURRENT OF C2;

                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET ALLO_STATUS = 'U',
                                  TRANSFERRED_AMOUNT =NVL(TRANSFERRED_AMOUNT,0)+NVL(M_RUNIING_SUB_TOT,0)
                              WHERE CURRENT OF C1;

         DN_LOAN_DEAL_ALLOCATION_SAVE(M_DN_TEMP_LOAN_GEN_C2.DOCREFNO, M_DN_TEMP_LOAN_GEN_C1.DOCREFNO,NVL(M_RUNIING_SUB_TOT,0)-NVL(M_RUNIING_TOT,0),'Y',M_VALTODATE);

         END IF; ELSE
        dbms_output.put_line('ERROR ');
         END IF ;

   END IF ;





   END LOOP;
   CLOSE C2;

   END IF;   /*
             ||
             || END WITHDRAWAL
             ||
             */


 ---------------------------------------------------------------------------------------------------

     /*
    ||
    || DEPOSIT
    ||
     */
    IF M_DN_TEMP_LOAN_GEN_C1.TRN_TYPE ='CD' THEN  -- C1--> CD ,C2--> BUY
    /*
    ||
    || DEPOSIT  --> BUY
    ||
     */

    OPEN  C2('BUY',M_DN_TEMP_LOAN_GEN_C1.PORTFOLIO_CODE);
    LOOP
    FETCH C2 INTO M_DN_TEMP_LOAN_GEN_C2;

   -- M_RUNIING_TOT:= NVL(M_DN_TEMP_LOAN_GEN_C1.TOT,0)-NVL(M_DN_TEMP_LOAN_GEN_C1.TRANSFERRED_AMOUNT,0)+NVL(M_DN_TEMP_LOAN_GEN_C1.ALLO_AMOUNT,0);
   M_RUNIING_TOT :=  NVL(M_DN_TEMP_LOAN_GEN_C1.TOT,0)
                   + NVL(DN_GET_LOAN_DEAL_ALLO_AMOUNT(M_DN_TEMP_LOAN_GEN_C1.DOCREFNO),0)
                   - NVL(DN_GET_LOAN_DEAL_TRNSF_AMOUNT(M_DN_TEMP_LOAN_GEN_C1.DOCREFNO),0);
    IF C2%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('*****');
        EXIT WHEN C2%NOTFOUND;
    ELSE




           M_RUNIING_SUB_TOT :=  NVL(M_DN_TEMP_LOAN_GEN_C2.TOT,0)
                              + NVL(DN_GET_LOAN_DEAL_ALLO_AMOUNT(M_DN_TEMP_LOAN_GEN_C2.DOCREFNO),0)
                              - NVL(DN_GET_LOAN_DEAL_TRNSF_AMOUNT(M_DN_TEMP_LOAN_GEN_C2.DOCREFNO),0);

           DBMS_OUTPUT.PUT_LINE('3 FOUND '||M_DN_TEMP_LOAN_GEN_C2.TRN_TYPE||'*DEPOSIT*'||M_RUNIING_TOT||'*BUY*'||M_RUNIING_SUB_TOT);

         IF M_RUNIING_TOT+M_RUNIING_SUB_TOT>=0 THEN

             DBMS_OUTPUT.PUT_LINE('EX 1 ');

                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET --ALLO_STATUS = 'A',
                                  ALLO_AMOUNT =NVL(ALLO_AMOUNT,0)+NVL(M_RUNIING_TOT,0)
                              WHERE CURRENT OF C2;

                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET --ALLO_STATUS = 'U',
                                  TRANSFERRED_AMOUNT =NVL(TRANSFERRED_AMOUNT,0)+NVL(M_RUNIING_TOT,0)
                              WHERE CURRENT OF C1;

         DN_LOAN_DEAL_ALLOCATION_SAVE(M_DN_TEMP_LOAN_GEN_C2.DOCREFNO, M_DN_TEMP_LOAN_GEN_C1.DOCREFNO,M_RUNIING_TOT,'Y',M_VALTODATE);


         ELSIF  M_RUNIING_TOT+M_RUNIING_SUB_TOT< 0 THEN

         IF ABS(M_RUNIING_TOT)>=ABS(M_RUNIING_SUB_TOT) THEN
            DBMS_OUTPUT.PUT_LINE('EX 2.1');
                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET --ALLO_STATUS = 'A',
                                  ALLO_AMOUNT =NVL(ALLO_AMOUNT,0)+NVL(M_RUNIING_SUB_TOT,0)*(-1)
                              WHERE CURRENT OF C2;

                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET --ALLO_STATUS = 'U',
                                  TRANSFERRED_AMOUNT =NVL(TRANSFERRED_AMOUNT,0)+NVL(M_RUNIING_SUB_TOT,0)*(-1)
                              WHERE CURRENT OF C1;

              DN_LOAN_DEAL_ALLOCATION_SAVE(M_DN_TEMP_LOAN_GEN_C2.DOCREFNO, M_DN_TEMP_LOAN_GEN_C1.DOCREFNO,NVL(M_RUNIING_SUB_TOT,0)*(-1),'Y',M_VALTODATE);

             ELSE
                 DBMS_OUTPUT.PUT_LINE('EX 2.2');
                           UPDATE DN_TEMP_LOAN_GENERATION
                              SET --ALLO_STATUS = 'A',
                                  ALLO_AMOUNT =NVL(ALLO_AMOUNT,0)+NVL(M_RUNIING_SUB_TOT,0)*(-1)
                              WHERE CURRENT OF C2;

                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET --ALLO_STATUS = 'U',
                                  TRANSFERRED_AMOUNT =NVL(TRANSFERRED_AMOUNT,0)+NVL(M_RUNIING_SUB_TOT,0)*(-1)
                              WHERE CURRENT OF C1;

                      DN_LOAN_DEAL_ALLOCATION_SAVE(M_DN_TEMP_LOAN_GEN_C2.DOCREFNO, M_DN_TEMP_LOAN_GEN_C1.DOCREFNO,NVL(M_RUNIING_SUB_TOT,0)*(-1),'Y',M_VALTODATE);

             END IF;


        ELSE
        dbms_output.put_line('ERROR ');
         END IF ;

   END IF ;








   END LOOP;
   CLOSE C2;

  END IF;
    /*
    ||
    || END DEPOSIT
    ||
     */
    --------------------------------------------------------------------------------------------------------------


   /*
    ||
    || SALE
    ||
     */
    IF M_DN_TEMP_LOAN_GEN_C1.TRN_TYPE ='SELL' THEN  -- C1--> SELL ,C2--> BUY
     /*
    ||
    || SALE  --> BUY
    ||
     */

    OPEN  C2('BUY',M_DN_TEMP_LOAN_GEN_C1.PORTFOLIO_CODE);
    LOOP
    FETCH C2 INTO M_DN_TEMP_LOAN_GEN_C2;

   -- M_RUNIING_TOT:= NVL(M_DN_TEMP_LOAN_GEN_C1.TOT,0)-NVL(M_DN_TEMP_LOAN_GEN_C1.TRANSFERRED_AMOUNT,0)+NVL(M_DN_TEMP_LOAN_GEN_C1.ALLO_AMOUNT,0);
   M_RUNIING_TOT :=  NVL(M_DN_TEMP_LOAN_GEN_C1.TOT,0)
                   + NVL(DN_GET_LOAN_DEAL_ALLO_AMOUNT(M_DN_TEMP_LOAN_GEN_C1.DOCREFNO),0)
                   - NVL(DN_GET_LOAN_DEAL_TRNSF_AMOUNT(M_DN_TEMP_LOAN_GEN_C1.DOCREFNO),0);
    IF C2%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('*h****');
        EXIT WHEN C2%NOTFOUND;
    ELSE




           M_RUNIING_SUB_TOT :=  NVL(M_DN_TEMP_LOAN_GEN_C2.TOT,0)
                              + NVL(DN_GET_LOAN_DEAL_ALLO_AMOUNT(M_DN_TEMP_LOAN_GEN_C2.DOCREFNO),0)
                              - NVL(DN_GET_LOAN_DEAL_TRNSF_AMOUNT(M_DN_TEMP_LOAN_GEN_C2.DOCREFNO),0);

        DBMS_OUTPUT.PUT_LINE('4 FOUND '||M_DN_TEMP_LOAN_GEN_C2.TRN_TYPE||'**SALE **'||M_RUNIING_TOT||'=>'||M_DN_TEMP_LOAN_GEN_C1.DOCREFNO||'**'||'**BUY'||M_RUNIING_SUB_TOT||'=>'||M_DN_TEMP_LOAN_GEN_C2.DOCREFNO);
         IF M_RUNIING_TOT+M_RUNIING_SUB_TOT>=0 THEN

             DBMS_OUTPUT.PUT_LINE('EX 1 ');

                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET --ALLO_STATUS = 'A',
                                  ALLO_AMOUNT =NVL(ALLO_AMOUNT,0)+NVL(M_RUNIING_TOT,0)
                              WHERE CURRENT OF C2;

                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET --ALLO_STATUS = 'U',
                                  TRANSFERRED_AMOUNT =NVL(TRANSFERRED_AMOUNT,0)+NVL(M_RUNIING_TOT,0)
                              WHERE CURRENT OF C1;

         DN_LOAN_DEAL_ALLOCATION_SAVE(M_DN_TEMP_LOAN_GEN_C2.DOCREFNO, M_DN_TEMP_LOAN_GEN_C1.DOCREFNO,M_RUNIING_TOT,'Y',M_VALTODATE);


         ELSIF  M_RUNIING_TOT+M_RUNIING_SUB_TOT< 0 THEN

         DBMS_OUTPUT.PUT_LINE('EX 2');
          -- RAISE_APPLICATION_ERROR(-20201,'******'||M_RUNIING_TOT||'**'||M_RUNIING_SUB_TOT);
              IF ABS(M_RUNIING_TOT)>=ABS(M_RUNIING_SUB_TOT) THEN
            DBMS_OUTPUT.PUT_LINE('EX 2.1');
           -- RAISE_APPLICATION_ERROR(-20201,'******');
                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET --ALLO_STATUS = 'A',
                                  ALLO_AMOUNT =NVL(ALLO_AMOUNT,0)+NVL(M_RUNIING_SUB_TOT,0)*(-1)
                              WHERE CURRENT OF C2;

                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET --ALLO_STATUS = 'U',
                                  TRANSFERRED_AMOUNT =NVL(TRANSFERRED_AMOUNT,0)+NVL(M_RUNIING_SUB_TOT,0)*(-1)
                              WHERE CURRENT OF C1;

              DN_LOAN_DEAL_ALLOCATION_SAVE(M_DN_TEMP_LOAN_GEN_C2.DOCREFNO, M_DN_TEMP_LOAN_GEN_C1.DOCREFNO,NVL(M_RUNIING_SUB_TOT,0)*(-1),'Y',M_VALTODATE);

             ELSE
               -- com by waruna 2012-03-14
                DBMS_OUTPUT.PUT_LINE('EX 2.2');
                           --RAISE_APPLICATION_ERROR(-20201,'******');
                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET --ALLO_STATUS = 'A',
                                  ALLO_AMOUNT =NVL(ALLO_AMOUNT,0)+NVL(M_RUNIING_SUB_TOT,0)*(-1)
                              WHERE CURRENT OF C2;

                              UPDATE DN_TEMP_LOAN_GENERATION
                              SET --ALLO_STATUS = 'U',
                                  TRANSFERRED_AMOUNT =NVL(TRANSFERRED_AMOUNT,0)+NVL(M_RUNIING_SUB_TOT,0)*(-1)
                              WHERE CURRENT OF C1;

                      DN_LOAN_DEAL_ALLOCATION_SAVE(M_DN_TEMP_LOAN_GEN_C2.DOCREFNO, M_DN_TEMP_LOAN_GEN_C1.DOCREFNO,NVL(M_RUNIING_SUB_TOT,0)*(-1),'Y',M_VALTODATE);


                  dbms_output.put_line('');


             END IF;


        ELSE
        dbms_output.put_line('ERROR ');
         END IF ;






    END IF;



   END LOOP;
   CLOSE C2;
   END IF ;
    /*
    ||
    || END SALE
    ||
     */

             UPDATE DN_TEMP_LOAN_GENERATION
             SET ALLO_STATUS = 'C'
             WHERE CURRENT OF C1;



    END IF;

    END LOOP;

    --------------------------------------------------------------------------------------------------------------


   CLOSE C1;
COMMIT;

END ;

/
