--------------------------------------------------------
--  DDL for Function DN_GET_CURRENT_AVAILABILITY
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_CURRENT_AVAILABILITY" 
(
M_AVAIL_TYPE                         IN VARCHAR2,                                             /* 01 */
M_FACILITY_NO                        IN DN_REF_PORTFOLIO.PORTFOLIO_CODE % TYPE               /* 02 */
)

/* 
* AUTHOR                   :   WARUNA 
* DATE                     :   2011-12-22
* 
* SYSTEM                   :   LBMARGIN
* 
* PURPOSE                  :   
*/

RETURN NUMBER

AS
M_AVAILABILITY NUMBER;

BEGIN


M_AVAILABILITY := 0;

IF M_AVAIL_TYPE = 'SYSTEM' THEN 

   M_AVAILABILITY := DN_GET_CLIENT_AVAILABILITY(M_FACILITY_NO);

ELSIF M_AVAIL_TYPE = 'RECOMMENDED' THEN 

   M_AVAILABILITY := DN_GET_CLIENT_AVAILABILITY(M_FACILITY_NO);

END IF;


RETURN NVL(M_AVAILABILITY, 0);

END DN_GET_CURRENT_AVAILABILITY; 

/
