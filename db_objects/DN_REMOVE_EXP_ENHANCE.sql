--------------------------------------------------------
--  DDL for Procedure DN_REMOVE_EXP_ENHANCE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_REMOVE_EXP_ENHANCE" 
(
 M_PROCESS_DATE    DN_SYS_PARAMETER.LAST_DAILY%TYPE
)

   -- Procedure    : Remove exp enahancement
   -- System       : Dealnet system
   -- Created by   : K.M.Waruna Sri Jayanath
   -- Created on   : 04/01/2012
   -- Modified By  : K.M.Waruna Sri Jayanath
   -- Modified on  : 04/01/2012

  AS
 


BEGIN


  DELETE FA_PY_INCREASE_AVAILABILITY A  
  WHERE THIS_PAYMENT_INCREASE_STATUS='Y';
  
  
  DELETE  FA_PY_INCREASE_AVAILABILITY A  
  WHERE THIS_PERIOD_INCREASE_STATUS='Y' 
  AND THIS_PERIOD_INCREASE_DATE<=M_PROCESS_DATE;
   
  
  


END; 

/
