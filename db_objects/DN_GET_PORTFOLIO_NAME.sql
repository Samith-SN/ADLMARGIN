--------------------------------------------------------
--  DDL for Function DN_GET_PORTFOLIO_NAME
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_PORTFOLIO_NAME" 
( M_PORTFOLIO_CODE IN DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE)
  RETURN VARCHAR2 IS
    -----------------------------------------------------------------------------------------------------------------------
    -- Purpose: This function will return the Portfolio's name for a given Portfolio Code
    -- Created By :
    -- Person      Date           Comments
    -- Siva        20-07-2000
   -----------------------------------------------------------------------------------------------------------------------


  M_NAME            DN_REF_PORTFOLIO.PF_NAME%TYPE;

BEGIN



     SELECT PF_NAME INTO M_NAME FROM DN_REF_PORTFOLIO
     WHERE UPPER(PORTFOLIO_CODE) = UPPER(M_PORTFOLIO_CODE);

    RETURN M_NAME ;
EXCEPTION
   WHEN OTHERS THEN
      -- NULL ; vomment by waruna 2010/10/18
      RETURN nvl(M_NAME,'-');
      
     
END; -- Function WD_GET_PORTFOLIO_NAME 

/
