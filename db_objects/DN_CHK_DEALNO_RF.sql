--------------------------------------------------------
--  DDL for Function DN_CHK_DEALNO_RF
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_CHK_DEALNO_RF" 
(
 M_DEAL_NO         DN_TRN_REPO_FRESH.DEAL_NO%TYPE
)
RETURN VARCHAR2
IS
M_COUNT1           NUMBER;
BEGIN

   SELECT COUNT(*)
   INTO   M_COUNT1
   FROM   DN_TRN_REPO_SETTLEMENT
   WHERE  APP_STATUS<>'CANCEL' AND
          PRIOR_DEAL_NO=M_DEAL_NO;

  IF M_COUNT1>0  THEN
   RETURN 'Y';
  ELSE
   RETURN 'N';
  END IF;

END DN_CHK_DEALNO_RF;

/
