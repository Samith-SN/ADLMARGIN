--------------------------------------------------------
--  DDL for Function DN_GET_SETTLE_DATE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_SETTLE_DATE" 
(
 M_DEAL_NO         DN_TRN_REPO_SETTLEMENT.DEAL_NO%TYPE
)
RETURN VARCHAR2
IS
M_SETTLE_DATE           VARCHAR2(20);
BEGIN

   SELECT NVL(TO_CHAR(SETTLE_DATE,'DD-MM-YYYY'),'-')
   INTO   M_SETTLE_DATE
   FROM   DN_TRN_REPO_SETTLEMENT
   WHERE  DEAL_NO = M_DEAL_NO;

  
   RETURN M_SETTLE_DATE;
 
  
END; 

/
