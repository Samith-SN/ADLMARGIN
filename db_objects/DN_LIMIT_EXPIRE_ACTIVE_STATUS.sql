--------------------------------------------------------
--  DDL for Procedure DN_LIMIT_EXPIRE_ACTIVE_STATUS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_LIMIT_EXPIRE_ACTIVE_STATUS" 
   (
		M_DATE    LMT_ACT_DETAILS.VALID_DATE_FROM%TYPE
   )

   IS

    -- Procedue     : AFTER THE EXPIRATION OF VALID PERIOD THE ACTIVE STATUS WILL BECOME 'E'
    -- System       : Dealnet system
    -- Created by   : V.Sukathis
    -- Created on   : 07/02/2000

    BEGIN

    UPDATE LMT_ACT_DETAILS
    SET ACTIVE_STATUS='E'
    WHERE VALID_DATE_FROM>M_DATE OR  VALID_DATE_TO<M_DATE;

COMMIT;

END DN_LIMIT_EXPIRE_ACTIVE_STATUS;

/
