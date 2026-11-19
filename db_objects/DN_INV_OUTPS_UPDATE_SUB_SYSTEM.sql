--------------------------------------------------------
--  DDL for Procedure DN_INV_OUTPS_UPDATE_SUB_SYSTEM
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_OUTPS_UPDATE_SUB_SYSTEM" 
   (
    M_DEAL_NO      DN_TRN_OUTP_SALE.DEAL_NO%TYPE
   )

   IS

    -- Procedure    : Update outright inventory sub system after confiremation
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 12/07/1999


BEGIN

    DN_INV_OUTPS_UP_DEAL_SEC(M_DEAL_NO);

    DN_INV_OUTPS_UP_SUM_SEC_BUY(M_DEAL_NO);

    DN_INV_OUTPS_UP_SUM_SEC_SELL(M_DEAL_NO);

    DN_INV_OUTPS_UP_SUM_INST_BUY(M_DEAL_NO);

    DN_INV_OUTPS_UP_SUM_INST_SELL(M_DEAL_NO);

    DN_INV_OUTPS_UP_DEAL_SERNO_FO(M_DEAL_NO);

END DN_INV_OUTPS_UPDATE_SUB_SYSTEM;

/
