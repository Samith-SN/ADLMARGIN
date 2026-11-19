--------------------------------------------------------
--  DDL for Function DN_GET_TAX_RATE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_TAX_RATE" 
  (
    M_RATE_CODE         DN_REF_TAX_RATE.RATE_CODE%TYPE,
    M_DATE              VARCHAR                
    --AS a percentage
   )

   RETURN  REAL

   IS

    -- Function     : Returns TAX_RATE  
    -- System       : DealNet System
    -- Created by   : K
    -- Created on   : 24/01/2011

   M_RETVAL                     NUMBER;
   M_RATE                       NUMBER;

BEGIN



  SELECT  
  CASE WHEN TO_DATE(M_DATE,'DD-MM-YYYY')>= EFECTIVE_DATE THEN 
                  A.NEW_RATE
                        ELSE A.RATE
                        END AS "SELECT_RATE" INTO M_RATE
              
  FROM DN_REF_TAX_RATE A 
  WHERE RATE_CODE =M_RATE_CODE 
  AND ACTIVE_STATUS='Y';
  


RETURN ROUND(M_RATE,6);

END ; 

/
