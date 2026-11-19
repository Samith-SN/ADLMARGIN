--------------------------------------------------------
--  DDL for Function DN_GET_PORTFOLIO_NAME_FOR_CHQ
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_PORTFOLIO_NAME_FOR_CHQ" 
( M_PAYMENT_NO IN DN_TRN_BO_SETTL_PAYMENT.PAYMENT_NO%TYPE)
  RETURN VARCHAR2 IS
    -----------------------------------------------------------------------------------------------------------------------
    -- Purpose: This function will return the Portfolio's name for a payment number
    -- Created By : ashini
    --       Date           for sr0604-082
    --       27-04-2006
   -----------------------------------------------------------------------------------------------------------------------

  M_NAME                    DN_REF_PORTFOLIO.PF_NAME%TYPE;
  M_COUNT                   NUMBER;
  M_PORTFOLIO_CODE          DN_TRN_BO_SETTL_PAYMENT_BULK.PORTFOLIO_CODE%TYPE;
  M_DN_PORTFOLIO_CODE       DN_TRN_BO_SETTL_PAYMENT_BULK.DN_PORTFOLIO_CODE%TYPE;
  M_PNAME                   DN_REF_PORTFOLIO.PF_NAME%TYPE;
  M_DNNAME                  DN_REF_PORTFOLIO.PF_NAME%TYPE;



BEGIN
   SELECT COUNT(*) INTO M_COUNT
   FROM  DN_TRN_BO_SETTL_PAYMENT_BULK
   WHERE PAYMENT_NO=M_PAYMENT_NO;


IF M_COUNT > 0 THEN


 SELECT PORTFOLIO_CODE, DN_PORTFOLIO_CODE INTO M_PORTFOLIO_CODE,M_DN_PORTFOLIO_CODE
 FROM   DN_TRN_BO_SETTL_PAYMENT_BULK
 WHERE  PAYMENT_NO=M_PAYMENT_NO ;

 --RAISE_APPLICATION_ERROR(-20201,'M_PORTFOLIO_CODE---' ||M_PORTFOLIO_CODE||'M_DN_PORTFOLIO_CODE---' ||M_DN_PORTFOLIO_CODE);
 SELECT PF_NAME INTO M_PNAME FROM DN_REF_PORTFOLIO
 WHERE PORTFOLIO_CODE = M_PORTFOLIO_CODE;


 SELECT PF_NAME INTO M_DNNAME FROM DN_REF_PORTFOLIO
 WHERE PORTFOLIO_CODE = M_DN_PORTFOLIO_CODE;

 SELECT M_DNNAME||' '||'O/A'||' '||M_PNAME INTO  M_NAME
 FROM   DUAL;


ELSIF M_COUNT = 0 THEN
     SELECT PF_NAME INTO M_NAME FROM DN_REF_PORTFOLIO
     WHERE PORTFOLIO_CODE = M_PORTFOLIO_CODE;


END IF;



RETURN NVL(M_NAME,' ') ;


END; -- Function WD_GET_PORTFOLIO_NAME

/
