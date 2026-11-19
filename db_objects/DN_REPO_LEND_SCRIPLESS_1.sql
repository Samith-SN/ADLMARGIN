--------------------------------------------------------
--  DDL for Procedure DN_REPO_LEND_SCRIPLESS_1
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_REPO_LEND_SCRIPLESS_1" 
(
  M_DEALNO           DN_TRN_REPO_FRESH.DEAL_NO%TYPE
)
AS

BEGIN
             /*SELECT SCRIPT_STATUS
             INTO   M_SCRIPT_STATUS
             FROM   DN_TRN_REPO_FRESH
             WHERE  DEAL_NO=M_DEALNO AND APP_STATUS='APPRO2';
        ----------------------------------------------

    IF M_SCRIPT_STATUS='SL' THEN*/

                 DN_REPO_LEND_SCRIPLESS(RTRIM(LTRIM(M_DEALNO)));

             --  END IF;
END DN_REPO_LEND_SCRIPLESS_1;

/
