--------------------------------------------------------
--  DDL for Function DN_GET_ACCRUED_INTEREST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_ACCRUED_INTEREST" 
( M_LEG1VALUE NUMBER,
  M_YIELD NUMBER,
  M_BASIS VARCHAR2,
  M_ENDDATE VARCHAR2,
  M_EFFVALDATE VARCHAR2
)Return Real IS
 -----------------------------------------------------------------------------------------------------------------------
    --
    -- Purpose: This function will return the Accured Interest Amount
    --
    -- Created By :
    -- Person      Date           Comments
    -- Siva        04-08-2000
    -- ---------   ----------     -------------------------------------------
   -----------------------------------------------------------------------------------------------------------------------

   ACCINT NUMBER;
   DAYS   NUMBER;
   AADAYS NUMBER;
 BEGIN
  SELECT (TO_DATE(M_ENDDATE,'DD-MM-YYYY')-TO_DATE(M_EFFVALDATE,'DD-MM-YYYY')) INTO DAYS FROM DUAL;
  IF M_BASIS='A364' THEN
        ACCINT:=((M_LEG1VALUE*(M_YIELD/100))/364)*DAYS;
  ELSIF M_BASIS='A365' THEN
        ACCINT:=((M_LEG1VALUE*(M_YIELD/100))/365)*DAYS;
  ELSIF M_BASIS='AA' THEN
  SELECT (ADD_MONTHS(TO_DATE(M_EFFVALDATE,'DD-MM-YYYY'),12)-TO_DATE(M_EFFVALDATE,'DD-MM-YYYY')) INTO AADAYS FROM DUAL;
        ACCINT:=(M_LEG1VALUE*(M_YIELD/100)/AADAYS)*DAYS;
  END IF;
  IF ACCINT IS NULL THEN
     ACCINT:=0;
  END IF;

  RETURN ACCINT;
/*  EXCEPTION
   WHEN OTHERS THEN
       RETURN 0;*/
END; -- Function WD_GET_ACCRUED_INTEREST

/
