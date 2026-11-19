--------------------------------------------------------
--  DDL for Function DN_RTN_OD_INTEREST_TO_DATE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_RTN_OD_INTEREST_TO_DATE" 
( 
  M_PORTFOLIO_CODE       DN_TRN_PORTF_OD_INTEREST.PORTFOLIO_CODE%TYPE,
  M_TO_DATE              VARCHAR2
)Return Real IS

   -- Created By :Prabash on 10-01-2012
  --   Created USING --ADLMARGIN.DN_GET_OD_ACCRUED_INTEREST-- FUNCTION.
   

   OD_ACCINT NUMBER;
   M_FROM_DATE DATE;
  
 BEGIN
 
   OD_ACCINT:=0;
 
   
   SELECT trunc(TO_date( M_TO_DATE,'dd-mm-yyyy') ,'mm') INTO M_FROM_DATE 
   FROM DUAL;
   
  SELECT  SUM(A.OD_INTEREST) INTO OD_ACCINT      
  FROM DN_TRN_PORTF_OD_INTEREST A
  WHERE PORTFOLIO_CODE =  M_PORTFOLIO_CODE
  AND TRNDATE          >= M_FROM_DATE
  AND TRNDATE          <= TO_DATE(M_TO_DATE,'DD/MM/YYYY')
  ;


  RETURN OD_ACCINT;
  
 EXCEPTION
     WHEN NO_DATA_FOUND THEN
    RETURN 0; 
END;

/
