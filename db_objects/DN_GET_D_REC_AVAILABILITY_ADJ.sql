--------------------------------------------------------
--  DDL for Function DN_GET_D_REC_AVAILABILITY_ADJ
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_D_REC_AVAILABILITY_ADJ" 
(
M_AVAIL_TYPE                         IN VARCHAR2,                                             /* 01 */
M_FACILITY_NO                        IN DN_REF_PORTFOLIO.PORTFOLIO_CODE % TYPE               /* 02 */
)

/* 
* AUTHOR                   :   WARUNA 
* DATE                     :   2011-12-22
* 
* SYSTEM                   :   ADLMARGIN
* 
* PURPOSE                  :   
*/

RETURN NUMBER

AS
M_AVAILABILITY NUMBER;

BEGIN


IF M_AVAIL_TYPE = 'SYSTEM' THEN 

   M_AVAILABILITY := 0;

ELSIF M_AVAIL_TYPE = 'RECOMMENDED' THEN 

     
  SELECT SUM(ENHANCED_AMOUNT) INTO M_AVAILABILITY
  FROM FA_PY_INCREASE_AVAILABILITY A WHERE
  FACILITY_NO = M_FACILITY_NO 
  AND STATUS = 'A' 
  AND TYPE ='DUE_RECEIPT'
  AND (THIS_PAYMENT_INCREASE_STATUS = 'Y' OR
       THIS_PERIOD_INCREASE_STATUS = 'Y'  OR 
       PERMANENT_INCREASE_STATUS ='Y');

END IF;



RETURN NVL(M_AVAILABILITY, 0);

END ;

/
