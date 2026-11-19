--------------------------------------------------------
--  DDL for Procedure DN_ACC_LINK_BL_DAYEND
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_ACC_LINK_BL_DAYEND" 
   (
    M_PROCESS_DATE  DN_INV_INT_OUTPS_DEAL_SEC.PROCESS_DATE%TYPE
   )

   IS

    -- Procedue     : Link BL transactions to the accounting after the dayend routine
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 20/08/1999

BEGIN

   DN_ACC_A_5_3(M_PROCESS_DATE);

   DN_ACC_A_6_3(M_PROCESS_DATE);

   DN_ACC_A_6_3_X (M_PROCESS_DATE); -- INSERTED ON 04-JAN-2001 BY LATHIKA FOR TAX TRANSFER --

   DN_ACC_B_5_4(M_PROCESS_DATE);

   DN_ACC_B_6_4(M_PROCESS_DATE);


   DN_ACC_A_8_2(M_PROCESS_DATE);

   DN_ACC_B_8_2(M_PROCESS_DATE);

END DN_ACC_LINK_BL_DAYEND;

/
