--------------------------------------------------------
--  DDL for Function DN_GET_CLIENT_ENHANCE_RECEIPT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_CLIENT_ENHANCE_RECEIPT" 
(
  M_FACILITY_NO          DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE ,
  M_AVAIL_TYPE           VARCHAR   
 )
 RETURN NUMBER
 AS
 M_ENHANCE_RECEIPT         NUMBER;
 /*
 || CREATED BY : WARUNA SRI JAYANATH
 || CREATEND OM : LBMARGIN 2012-03-02
 ||
 */
 BEGIN
 

IF M_AVAIL_TYPE ='APPROVED' THEN

  SELECT  NVL(SUM(A.ENHANCED_AMOUNT),0)    INTO M_ENHANCE_RECEIPT
  FROM FA_PY_INCREASE_AVAILABILITY A 
  WHERE 
  TYPE                                = 'DUE_RECEIPT' 
  AND FACILITY_NO                     = M_FACILITY_NO 
 
  AND STATUS                          = 'A' 
  AND (THIS_PAYMENT_INCREASE_STATUS   = 'Y' 
       OR PERMANENT_INCREASE_STATUS   = 'Y'  
       OR THIS_PERIOD_INCREASE_DATE >= (SELECT A.LAST_DAILY 
                                          FROM DN_SYS_PARAMETER A)
         );
 
 ELSIF  M_AVAIL_TYPE ='RECOMMENDED' THEN 
 
   SELECT  NVL(SUM(A.ENHANCED_AMOUNT),0)    INTO M_ENHANCE_RECEIPT
  FROM FA_PY_INCREASE_AVAILABILITY A 
  WHERE 
  TYPE                                = 'DUE_RECEIPT' 
  AND FACILITY_NO                     = M_FACILITY_NO 
 
  AND STATUS                          = 'A' 
  AND (THIS_PAYMENT_INCREASE_STATUS   = 'Y' 
       OR PERMANENT_INCREASE_STATUS   = 'Y'  
       OR THIS_PERIOD_INCREASE_DATE >= (SELECT A.LAST_DAILY 
                                          FROM DN_SYS_PARAMETER A)
         );
   END IF;        
   RETURN  M_ENHANCE_RECEIPT;
   
--A.SECURITY_CODE, A.EXT_SECURITY_CODE,
 END ; 

/
