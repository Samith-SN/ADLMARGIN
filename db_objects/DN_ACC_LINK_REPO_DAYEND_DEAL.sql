--------------------------------------------------------
--  DDL for Procedure DN_ACC_LINK_REPO_DAYEND_DEAL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_ACC_LINK_REPO_DAYEND_DEAL" 
   (
    M_PROCESS_DATE      DN_INV_INT_OUTPS_DEAL_SEC.PROCESS_DATE%TYPE,
    M_DEAL_NO           DN_TRN_REPO_FRESH.DEAL_NO%TYPE--GET THE DEAL NO
   )

   IS

    -- Procedue     : Link outright transactions to the accounting after the dayend routine
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 17/08/1999
    ------
    --INDITHA 2004-11-22
    --COPIED BY  - KEITH FOR SAMPATH on 2004-11-30 for vc ref 04-266 backdated deals


BEGIN

   DN_ACC_A_3_3_DEAL(M_PROCESS_DATE,M_DEAL_NO);

   DN_ACC_A_4_3_DEAL(M_PROCESS_DATE,M_DEAL_NO);

   DN_ACC_B_3_4_DEAL(M_PROCESS_DATE,M_DEAL_NO);

   DN_ACC_B_4_4_DEAL(M_PROCESS_DATE,M_DEAL_NO);

END DN_ACC_LINK_REPO_DAYEND_DEAL;

/
