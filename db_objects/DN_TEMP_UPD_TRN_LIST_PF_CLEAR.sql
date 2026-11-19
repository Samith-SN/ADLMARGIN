--------------------------------------------------------
--  DDL for Procedure DN_TEMP_UPD_TRN_LIST_PF_CLEAR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_TEMP_UPD_TRN_LIST_PF_CLEAR" 
(
  M_USER_NAME         DN_TEMP_TRN_LIST.USER_NAME%TYPE,
  CLEAR_TYPE          varchar
)
AS


BEGIN

DN_VALIDATE_SAVE_RIGHTS(M_USER_NAME,'WD_Portfolio_Upload');  --added by ashini on 31/10/2005 for sr0509-047


IF CLEAR_TYPE='TEMP' THEN
DELETE FROM  DN_TEMP_TRN_LIST_PF WHERE USER_NAME=M_USER_NAME;
END IF;

COMMIT;
END ;

/
