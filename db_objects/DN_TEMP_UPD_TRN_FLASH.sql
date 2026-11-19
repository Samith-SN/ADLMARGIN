--------------------------------------------------------
--  DDL for Procedure DN_TEMP_UPD_TRN_FLASH
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_TEMP_UPD_TRN_FLASH" 
(
 M_USER_NAME         DN_TEMP_TRN_LIST.USER_NAME%TYPE
)
AS

--M_SECURITY_CODE   DN_REF_SECURITY.SECURITY_CODE %TYPE;

BEGIN

 --CAREATED BY WARUNA SRI JAYANATH 

 
 DELETE FROM DN_TEMP_TRN_LIST; 
 DELETE FROM DN_TEMP_TRN_LIST_FAIL;


END ; 

/
