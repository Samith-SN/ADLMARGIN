--------------------------------------------------------
--  DDL for Procedure DN_ACC_LINK_REPO_DAYEND
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_ACC_LINK_REPO_DAYEND" 
   (
    M_PROCESS_DATE  DN_INV_INT_OUTPS_DEAL_SEC.PROCESS_DATE%TYPE
   )

   IS

    -- Procedue     : Link outright transactions to the accounting after the dayend routine
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 17/08/1999

BEGIN

   DN_ACC_A_3_3(M_PROCESS_DATE);

   DN_ACC_A_4_3(M_PROCESS_DATE);

   DN_ACC_B_3_4(M_PROCESS_DATE);

   DN_ACC_B_4_4(M_PROCESS_DATE);

END DN_ACC_LINK_REPO_DAYEND;

/
