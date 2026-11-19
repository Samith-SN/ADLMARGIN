--------------------------------------------------------
--  DDL for Function DN_GET_OD_ACCRUED_INTEREST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_OD_ACCRUED_INTEREST" 
( 
  M_PORTFOLIO_CODE       DN_TRN_PORTF_OD_INTEREST.PORTFOLIO_CODE%TYPE,
  M_FROM_DATE            DATE,
  M_TO_DATE              DATE
)Return Real IS
 -----------------------------------------------------------------------------------------------------------------------
    --
    -- Purpose: This function will return the Accured Interest Amount
    --
    -- Created By :
    -- Person      Date           Comments
    -- Siva        05-01-2012
    -- ---------   ----------     -------------------------------------------
   -----------------------------------------------------------------------------------------------------------------------

   OD_ACCINT NUMBER;
  
 BEGIN
 
   OD_ACCINT:=0;
   
  SELECT  SUM(A.OD_INTEREST) INTO OD_ACCINT      
  FROM DN_TRN_PORTF_OD_INTEREST A
  WHERE PORTFOLIO_CODE =  M_PORTFOLIO_CODE
  AND TRNDATE          >= M_FROM_DATE
  AND TRNDATE          <= M_TO_DATE
  ;


  RETURN OD_ACCINT;
  
 EXCEPTION
     WHEN NO_DATA_FOUND THEN
    RETURN 0; 
END;

/
