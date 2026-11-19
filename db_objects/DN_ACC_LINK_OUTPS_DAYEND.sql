--------------------------------------------------------
--  DDL for Procedure DN_ACC_LINK_OUTPS_DAYEND
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_ACC_LINK_OUTPS_DAYEND" 
   (
    M_PROCESS_DATE  DN_INV_INT_OUTPS_DEAL_SEC.PROCESS_DATE%TYPE
   )

   IS

    -- Procedue     : Link outright transactions to the accounting after the dayend routine
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 17/08/1999

BEGIN

   DN_ACC_A_2_3(M_PROCESS_DATE);

   DN_ACC_A_2_4(M_PROCESS_DATE);

   DN_ACC_A_2_6(M_PROCESS_DATE);

   DN_ACC_A_2_8_1(M_PROCESS_DATE);

   DN_ACC_A_2_8_2(M_PROCESS_DATE);


   DN_ACC_B_2_4(M_PROCESS_DATE);

   DN_ACC_B_2_5(M_PROCESS_DATE);

   DN_ACC_B_2_8(M_PROCESS_DATE);

   DN_ACC_B_2_11_1(M_PROCESS_DATE);

   DN_ACC_B_2_11_2(M_PROCESS_DATE);


END DN_ACC_LINK_OUTPS_DAYEND;

/
