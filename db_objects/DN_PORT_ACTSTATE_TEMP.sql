--------------------------------------------------------
--  DDL for Procedure DN_PORT_ACTSTATE_TEMP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_PORT_ACTSTATE_TEMP" 
   (
   M_PORTFOLIO_CODE     DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE
  
   )
AS
M_STATUS VARCHAR(20);

BEGIN
           DELETE FROM DN_REF_PORT_ACTSTATE_TEMP
           WHERE UPPER(PORTFOLIO_CODE) = UPPER(M_PORTFOLIO_CODE);
           
           
           SELECT ACTIVE_STATUS INTO M_STATUS 
           FROM DN_REF_PORTFOLIO 
           WHERE UPPER(PORTFOLIO_CODE) = UPPER(M_PORTFOLIO_CODE);
              
           INSERT INTO DN_REF_PORT_ACTSTATE_TEMP 
           (PORTFOLIO_CODE,ACTIVE_STATUS)
           VALUES
           (M_PORTFOLIO_CODE,M_STATUS);
           
                     
           
 
COMMIT;



END;

/
