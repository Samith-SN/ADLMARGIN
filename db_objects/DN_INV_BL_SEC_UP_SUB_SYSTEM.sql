--------------------------------------------------------
--  DDL for Procedure DN_INV_BL_SEC_UP_SUB_SYSTEM
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_BL_SEC_UP_SUB_SYSTEM" 
   (
    M_DEAL_NO      DN_TRN_BL_FUND.DEAL_NO%TYPE
   )

   IS

    -- Procedure    : Update (BL) Sec. inventory sub system after confiremation
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 24/08/1999

   M_COUNT      NUMBER;

BEGIN


    DN_INV_BL_SEC_UP_DEAL_SEC(M_DEAL_NO);

    DN_INV_BL_SEC_DEAL_SERNO_FO(M_DEAL_NO);


END DN_INV_BL_SEC_UP_SUB_SYSTEM;

/
