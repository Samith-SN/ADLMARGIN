--------------------------------------------------------
--  DDL for Function DN_RETURN_MARKET_RATE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_RETURN_MARKET_RATE" 
(
  M_SEC     DN_TRN_MARKET_RATE_DEBT.SECURITY_CODE%TYPE,
  M_DATE 	VARCHAR2
)
RETURN VARCHAR2

AS
M_DATE1  NUMBER;

BEGIN

--CHANGED BY SVA ON 08-02-2005
--  SELECT MARKET_RATE INTO M_DATE1 FROM DN_TRN_MARKET_RATE_EQUI
--  WHERE SECURITY_CODE=M_SEC AND DN_DATE=TO_DATE(M_DATE,'DD/MM/YYYY');

  SELECT MARKET_RATE INTO M_DATE1
  FROM   DN_TRN_MARKET_RATE_EQUI
  WHERE  SECURITY_CODE=M_SEC AND
        (SECURITY_CODE,TO_DATE(TO_CHAR(DN_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')) IN (SELECT SECURITY_CODE,MAX(DN_DATE)
                                                                                  FROM DN_TRN_MARKET_RATE_EQUI
                                                                                  WHERE SECURITY_CODE=M_SEC AND
                                                                                        TO_DATE(TO_CHAR(DN_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')<=TO_DATE(M_DATE,'DD/MM/YYYY')
                                                                                  GROUP BY SECURITY_CODE);

RETURN M_DATE1;

END DN_RETURN_MARKET_RATE;

/
