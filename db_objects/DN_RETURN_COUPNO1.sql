--------------------------------------------------------
--  DDL for Function DN_RETURN_COUPNO1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_RETURN_COUPNO1" 
(
  M_SECURITY_CODE		DN_REF_SECURITY_INT_PAY_DATES.SECURITY_CODE%TYPE,
  M_DATE                VARCHAR2
)
RETURN NUMBER

AS
M_COUPNO           NUMBER;

-------------------------------------------------------------------------------------
    --   PROCEDURE  - COUPON LETTER -TBONDREPORT
    --   SYSTEM     - DEALNET
    --   CREATED BY - GAYAN.
    --   CREATED ON - 21-03-2001
-------------------------------------------------------------------------------------

BEGIN
   SELECT COUNT(A.INT_PAY_DATE)+1
   INTO M_COUPNO
   FROM DN_REF_SECURITY_INT_PAY_DATES A,
   DN_REF_SECURITY B
   WHERE  A.INT_PAY_DATE < TO_DATE(TO_CHAR(TO_DATE(M_DATE,'DD/MM/YYYY'),'DD-MON-YYYY'),'DD/MON/YY') AND
   A.SECURITY_CODE = B.SECURITY_CODE AND A.SECURITY_CODE=M_SECURITY_CODE
   AND A.SECURITY_CODE
   IN (SELECT C.SECURITY_CODE
   FROM DN_INV_INT_CUST_DEAL_SERNO C
   WHERE  C.INST_TYPE='TBOND');


  RETURN M_COUPNO;

END DN_RETURN_COUPNO1;

/
