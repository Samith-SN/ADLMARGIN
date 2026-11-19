--------------------------------------------------------
--  DDL for Procedure DN_INV_BL_RF_UP_SUB_SYSTEM
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_BL_RF_UP_SUB_SYSTEM" 
   (
    M_DEAL_NO      DN_TRN_BL_FUND.DEAL_NO%TYPE
   )

   IS

    -- Procedure    : Update (BL) repo fresh inventory sub system after confiremation
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 19/08/1999

   M_COUNT      NUMBER;

BEGIN

    SELECT
       COUNT(*) INTO M_COUNT
    FROM
       DN_TRN_BL_FUND_SEC
    WHERE
       DEAL_NO=M_DEAL_NO;

    IF M_COUNT>0 THEN

        DN_INV_BL_RF_UP_DEAL_SEC(M_DEAL_NO);

        DN_INV_BL_RF_DEAL_SERNO_FO(M_DEAL_NO);

    END IF;

END DN_INV_BL_RF_UP_SUB_SYSTEM;

/
