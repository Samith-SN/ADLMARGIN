--------------------------------------------------------
--  DDL for Procedure DN_INV_BL_FWD_VALUE_TRNSFER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_BL_FWD_VALUE_TRNSFER" 
(
 M_PROCESS_DATE    DN_SYS_PARAMETER.LAST_DAILY%TYPE
)

   -- Procedure    : Transfer forward values to relevant places on eff_valdate
   -- System       : Dealnet system
   -- Created by   : ITU - D.P. Pubudu Thushara
   -- Created on   : 20/08/1999

  AS

BEGIN

   ----------- For all repo transactions -------------

   UPDATE DN_INV_BL_DEAL_SERIAL_NO
      SET FACE_VAL     =FWD_RECEIPT,
          FWD_RECEIPT  =0
   WHERE
      EFF_VALDATE=M_PROCESS_DATE;

   UPDATE DN_INV_BL_DEAL_SEC
      SET FACE_VAL     =FWD_RECEIPT,
          FWD_RECEIPT  =0
   WHERE
      EFF_VALDATE=M_PROCESS_DATE;

   UPDATE DN_INV_BL_DEAL_INST
      SET FACE_VAL     =FWD_RECEIPT,
          FWD_RECEIPT  =0
   WHERE
      EFF_VALDATE=M_PROCESS_DATE;

   --------- Allocation informations from B/L inventory ----------

    UPDATE DN_INV_BL_DEAL_INST
    SET ALLO_REPO    =ALLO_REPO+FWD_ALLO_REPO,
        FWD_ALLO_REPO=0,
        ALLO_BL      =FWD_ALLO_BL+FWD_ALLO_BL,
        FWD_ALLO_BL  =0
    WHERE
       EFF_VALDATE=M_PROCESS_DATE;


    UPDATE DN_INV_BL_DEAL_SEC
    SET ALLO_REPO    =ALLO_REPO+FWD_ALLO_REPO,
        FWD_ALLO_REPO=0,
        ALLO_BL      =FWD_ALLO_BL+FWD_ALLO_BL,
        FWD_ALLO_BL  =0
    WHERE
       EFF_VALDATE=M_PROCESS_DATE;


    UPDATE DN_INV_BL_DEAL_SERIAL_NO
    SET ALLO_REPO    =ALLO_REPO+FWD_ALLO_REPO,
        FWD_ALLO_REPO=0,
        ALLO_BL      =FWD_ALLO_BL+FWD_ALLO_BL,
        FWD_ALLO_BL  =0
    WHERE
       EFF_VALDATE=M_PROCESS_DATE;

END DN_INV_BL_FWD_VALUE_TRNSFER;

/
