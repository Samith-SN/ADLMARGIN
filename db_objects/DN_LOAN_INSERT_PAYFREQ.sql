--------------------------------------------------------
--  DDL for Procedure DN_LOAN_INSERT_PAYFREQ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_LOAN_INSERT_PAYFREQ" 
   (M_FACILITY_NO                  DN_LOAN_SETTL_SCHEDULE.FACILITY_NO%TYPE,
    M_DEAL_NO                      DN_LOAN_SETTL_SCHEDULE.DEAL_NO%TYPE,
    M_START_DATE                   VARCHAR2,
    M_END_DATE                     VARCHAR2,
    M_PAY_FREQ                     VARCHAR2,-- per Year 
    M_RATE                         NUMBER,
    M_LEG1                         NUMBER)
AS


M_SDATE                     DATE;
M_PAYDATE                   DATE;
M_EDATE                     DATE;
M_NUM                       NUMBER;
M_NUM2                      NUMBER;
M_A                         NUMBER;
M_TENOR                     NUMBER;
M_LEG2_VAL                  NUMBER;
M_ARE_RATE                  NUMBER;
M_DUE_AMOUNT                NUMBER;
MRATE                       NUMBER;
M_TOT_PAY_FREQ              NUMBER;
M_NO_OF_MONTHES             NUMBER;
-------------------------------------------------------------------------------------
    --   PROCEDURE  - DATA TAKE-ON   'DELETE THIS'
    --   SYSTEM     - Dealnet
    --   CREATED BY - Lathika.
    --   CREATED ON -
-------------------------------------------------------------------------------------

BEGIN
M_PAYDATE := NULL;





     M_SDATE:= TO_DATE(M_START_DATE,'DD/MM/YYYY');
     M_EDATE:= TO_DATE(M_END_DATE,'DD/MM/YYYY');

     M_TENOR :=   TO_DATE(M_EDATE,'DD-MM-YYYY')- TO_DATE(M_SDATE,'DD-MM-YYYY');
     
      SELECT MONTHS_BETWEEN(TO_DATE(M_EDATE,'DD-MM-YYYY'),TO_DATE(M_SDATE,'DD-MM-YYYY')) AS MONTHS_BETWEEN INTO M_NO_OF_MONTHES
      FROM Dual;
      M_TOT_PAY_FREQ := M_NO_OF_MONTHES/12*M_PAY_FREQ;
      
     SELECT DN_FIN_LEG2_F_LEG1(M_LEG1,M_RATE,M_TENOR,'A365',TO_DATE(M_EDATE,'DD/MM/YYYY'))
     INTO   M_LEG2_VAL
     FROM   DUAL;
     dbms_output.put_line('FV='||M_LEG2_VAL);
     
     MRATE := GET_AER_TO_EFF_INT(M_RATE*100,M_PAY_FREQ)/M_PAY_FREQ/100; --5/100calculate effective rate for the payment period
     dbms_output.put_line('MRATE='||MRATE);
     
     IF (1-POWER((1+MRATE),-M_PAY_FREQ)) <>0 THEN
     
     dbms_output.put_line('M_LEG1='||M_LEG1||'MRATE='||MRATE||'M_TOT_PAY_FREQ='||M_TOT_PAY_FREQ||'M_NO_OF_MONTHES='||M_NO_OF_MONTHES);
     M_DUE_AMOUNT := ROUND(MRATE*M_LEG1/(1-POWER((1+MRATE),-M_TOT_PAY_FREQ)),4);--calculate payment amount theoritical(ordinary anuity )
     dbms_output.put_line('M_DUE_AMOUNT='||M_DUE_AMOUNT);
     END IF; 
     
     
     
     dbms_output.put_line('M_DUE_AMOUNT='||M_DUE_AMOUNT||'M_PAY_FREQ='||M_PAY_FREQ);
  IF M_TOT_PAY_FREQ = '1' THEN
  
      INSERT INTO DN_LOAN_SETTL_SCHEDULE
      (FACILITY_NO,DEAL_NO,FREQ_NO,DUE_DATE,DUE_AMOUNT)
      VALUES
      (M_FACILITY_NO,M_DEAL_NO,1,M_END_DATE,M_LEG2_VAL);
        
 END IF;

  IF  M_PAY_FREQ <>'1' THEN
     M_NUM:=TO_NUMBER(M_PAY_FREQ);
     M_NUM2:=12/M_NUM;
     M_A:=1;--1

      SELECT ADD_MONTHS(M_SDATE,M_NUM2)
      INTO  M_PAYDATE
      FROM DUAL;
      WHILE (M_PAYDATE <= M_EDATE) LOOP -- = 

     

dbms_output.put_line('M_A='||M_A||M_PAYDATE||'_'||M_EDATE);

      INSERT INTO DN_LOAN_SETTL_SCHEDULE
        (FACILITY_NO,DEAL_NO,FREQ_NO,DUE_DATE,DUE_AMOUNT)
      VALUES
        (M_FACILITY_NO,M_DEAL_NO,M_A,M_PAYDATE,M_DUE_AMOUNT);
     M_A:=M_A+1;

      SELECT ADD_MONTHS(M_SDATE,(M_NUM2 * M_A))
      INTO  M_PAYDATE
      FROM DUAL;
   END LOOP;

 END IF;

--COMMIT;

END dn_loan_insert_payfreq; 

/
