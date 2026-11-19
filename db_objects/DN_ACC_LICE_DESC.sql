--------------------------------------------------------
--  DDL for Function DN_ACC_LICE_DESC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_ACC_LICE_DESC" 
    (
      M_ACC_TYPE_CODE    DN_ACC_ACCOUNT_TYPE.ACC_TYPE_CODE%TYPE
    )
   RETURN  VARCHAR2
    IS

    -- Function     : TO RETURN ACC_TYPE_DESC
    -- System       : DEALNET
    -- Created by   : LATHIKA
    -- Created on   : 17/01/2000

 M_ACC_TYPE_DESC    DN_ACC_ACCOUNT_TYPE.ACC_TYPE_DESC%TYPE;

  BEGIN

 SELECT ACC_TYPE_DESC
 INTO M_ACC_TYPE_DESC
 FROM DN_ACC_ACCOUNT_TYPE
 WHERE ACC_TYPE_CODE=M_ACC_TYPE_CODE;

 RETURN SUBSTR(M_ACC_TYPE_DESC,1,40);

END DN_ACC_LICE_DESC;

/
