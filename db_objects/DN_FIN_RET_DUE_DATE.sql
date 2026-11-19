--------------------------------------------------------
--  DDL for Function DN_FIN_RET_DUE_DATE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_RET_DUE_DATE" 
   (
    M_MATURITY_DATE    DN_TRN_REPO_FRESH.MATURITY_DATE%TYPE,
    M_SECURITY_CODE    DN_TRN_REPO_FRESH_SEC.SECURITY_CODE%TYPE
   ) RETURN  DATE

    IS

    -- Function     : Returns to be returned due date
    -- System       : DEALNET System
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 31/07/1999

 M_RETVAL               DN_TRN_REPO_FRESH.MATURITY_DATE%TYPE;
 M_SEC_MATURITY_DATE    DN_TRN_REPO_FRESH.MATURITY_DATE%TYPE;

 BEGIN

    SELECT
       MATURITY_DATE INTO M_SEC_MATURITY_DATE
    FROM
       DN_REF_SECURITY
    WHERE
       SECURITY_CODE=M_SECURITY_CODE;

    IF M_MATURITY_DATE<M_SEC_MATURITY_DATE THEN

       M_RETVAL:=M_MATURITY_DATE;

    ELSE

       M_RETVAL:=M_SEC_MATURITY_DATE;

    END IF;


 RETURN M_RETVAL;

END DN_FIN_RET_DUE_DATE;

/
