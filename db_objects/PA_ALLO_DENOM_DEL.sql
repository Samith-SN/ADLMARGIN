--------------------------------------------------------
--  DDL for Procedure PA_ALLO_DENOM_DEL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."PA_ALLO_DENOM_DEL" (
        M_REF_NO                     PA_BID_ENTRY_DENOMI.REF_NO%TYPE
        )
 AS

 BEGIN

/*RAISE_APPLICATION_ERROR(-20201,M_AUCTION_DATE ||' '||M_INST_TYPE||' '||M_SECURITY_CODE||' '||M_ISSUER_CODE||' '||M_PORTFOLIO_CODE||' '||M_ENTERED_BY||' '||M_SELECT_TYPE);*/


    /* PROCEDURE  - TO DELETE PRIMARY AUCTION ORDER ENTRY-DENOMINATIONS
       SYSTEM     - DEALNET
       CREATED BY - LATHIKA
       CREATED ON - 02-05-2001 */

DELETE PA_BID_ENTRY_DENOMI
WHERE REF_NO =M_REF_NO ;

COMMIT;

END PA_ALLO_DENOM_DEL;

/
