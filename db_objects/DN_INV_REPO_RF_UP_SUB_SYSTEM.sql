--------------------------------------------------------
--  DDL for Procedure DN_INV_REPO_RF_UP_SUB_SYSTEM
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_REPO_RF_UP_SUB_SYSTEM" 
   (
    M_DEAL_NO      DN_TRN_REPO_FRESH.DEAL_NO%TYPE
   )

   IS

    -- Procedure    : Update repo fresh inventory sub system after confiremation
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 29/07/1999


BEGIN

     DN_INV_REPO_RF_UP_DEAL_SEC(M_DEAL_NO);

     DN_INV_REPO_RF_DEAL_SERNO_FO(M_DEAL_NO);

END DN_INV_REPO_RF_UP_SUB_SYSTEM;

/
