--------------------------------------------------------
--  DDL for Procedure DN_SETL_DATA_CLEAR_TEMP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_SETL_DATA_CLEAR_TEMP" 

AS

BEGIN
    /*
    CREATED BY - K .M. WARUNA SRI JAYANATH
    SYSTEM     - 2011-11-09
    SYSTEM     - ADLMARGIN
               - CLEARE ALL TEMPARY PAYMENT RECEIPT ENTERD BY "DN_SETL_DATA_ADD_TEMP" 
    */

    DELETE FROM  DN_SETTLE_PRE_TEMP;
         

END ;

/
