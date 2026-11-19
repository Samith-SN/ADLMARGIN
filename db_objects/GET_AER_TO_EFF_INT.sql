--------------------------------------------------------
--  DDL for Function GET_AER_TO_EFF_INT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."GET_AER_TO_EFF_INT" 

(
   M_YEILD              NUMBER,
   M_FREQUENCY          NUMBER


)
     RETURN  NUMBER
    IS


   M_INTREST     NUMBER;
   M_AER         NUMBER;

BEGIN
/*
SELECT  ROUND(((POWER((1+(M_YEILD/100)/M_FREQUENCY),M_FREQUENCY) -1)*100),4)       
INTO M_AER
FROM DUAL;
*/
M_AER:=M_YEILD;

--SELECT  ROUND(( EXP((LN((M_AER)/100+1)/M_FREQUENCY)+ LN(M_FREQUENCY)) - M_FREQUENCY )*100,4) 
SELECT ( EXP((LN((M_AER)/100+1)/M_FREQUENCY)+ LN(M_FREQUENCY)) - M_FREQUENCY )*100
INTO M_INTREST
FROM DUAL;


RETURN M_INTREST ;

END ; 

/
