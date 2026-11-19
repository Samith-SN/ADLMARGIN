--------------------------------------------------------
--  DDL for Function DN_GET_ACC_NO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_ACC_NO" 
(
 M_PORTFOLIO_CODE        DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE
 )
 RETURN VARCHAR2
 AS
 M_ACC_NO      DN_REF_PORTFOLIO.ACC_NO%TYPE;

 BEGIN
   SELECT NVL(ACC_NO,'-')
   INTO   M_ACC_NO
   FROM   DN_REF_PORTFOLIO
   WHERE  PORTFOLIO_CODE=M_PORTFOLIO_CODE;

   RETURN  M_ACC_NO;

 END DN_GET_ACC_NO;

/
