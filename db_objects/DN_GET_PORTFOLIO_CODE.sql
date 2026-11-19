--------------------------------------------------------
--  DDL for Function DN_GET_PORTFOLIO_CODE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_PORTFOLIO_CODE" 
(
    M_CDS_ACC_NO  IN DN_REF_PORTFOLIO.CDS_ACC_NO%TYPE
)

  RETURN VARCHAR2

  IS
   ---------------------------------------------------------
    -- Purpose      : GET THE PORTFOLIO CODE USING CDS ACCOUNT NO
    -- Created By   : SVA
    -- Date         : 11-05-2005  ----------------------------------------------------------

M_PORTFOLIO_CODE  DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE;

BEGIN
    -- if M_CDS_ACC_NO='000005401LC' Then
     
     --M_PORTFOLIO_CODE:='MT078';
     
     --ELSE
     
     SELECT PORTFOLIO_CODE
     INTO   M_PORTFOLIO_CODE
     FROM   DN_REF_PORTFOLIO
     WHERE  CDS_ACC_NO = M_CDS_ACC_NO;
     --END if; 
     RETURN M_PORTFOLIO_CODE;

END;

/
