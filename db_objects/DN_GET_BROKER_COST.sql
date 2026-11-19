--------------------------------------------------------
--  DDL for Function DN_GET_BROKER_COST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_BROKER_COST" 
 (
   M_PURCHASE       DN_TRN_OUTP_SALE.PURCHASE_COST%TYPE
 )
   RETURN  REAL
IS

   M_RETVAL           NUMBER;
   Y                  NUMBER;
   M_CDS              NUMBER;
   M_BROKER           NUMBER;

BEGIN

  
/* change by waruna 2012-06-29
IF (M_PURCHASE*(0.03/100))>5 THEN
     M_CDS :=M_PURCHASE*(0.03/100);
  ELSE
     M_CDS :=5;
  END IF;

  IF (M_PURCHASE*(1.00/100))>10 THEN
     M_BROKER :=M_PURCHASE*(1.00/100);
  ELSE
     M_BROKER :=10;
  END IF;

 SELECT  NVL((0.395/100)*M_PURCHASE,0)+NVL(M_BROKER,0)+NVL(M_CDS,0) INTO  M_RETVAL FROM DUAL;
*/
 SELECT  NVL((1.12/100)*M_PURCHASE,0) INTO  M_RETVAL FROM DUAL;

RETURN ROUND(M_RETVAL,2);
END DN_GET_BROKER_COST; 

/
