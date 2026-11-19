--------------------------------------------------------
--  DDL for Procedure DN_INV_REPO_FWD_VALUE_TRNSFER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_REPO_FWD_VALUE_TRNSFER" 
(
 M_PROCESS_DATE    DN_SYS_PARAMETER.LAST_DAILY%TYPE
)

   -- Procedure    : Transfer forward values to relevant places on eff_valdate
   -- System       : Dealnet system
   -- Created by   : ITU - D.P. Pubudu Thushara
   -- Created on   : 11/08/1999
   -- Modified on  : 03/09/1999

  AS

BEGIN

   ----------- For all repo transactions -------------

   UPDATE DN_INV_REPO_DEAL_SERIAL_NO
      SET FACE_VAL     =FWD_RECEIPT,
          FWD_RECEIPT  =0
   WHERE
      EFF_VALDATE=M_PROCESS_DATE
      AND
      FWD_RECEIPT>0;

   UPDATE DN_INV_REPO_DEAL_SEC
      SET FACE_VAL     =FWD_RECEIPT,
          FWD_RECEIPT  =0
   WHERE
      EFF_VALDATE=M_PROCESS_DATE
      AND
      FWD_RECEIPT>0;


   UPDATE DN_INV_REPO_DEAL_INST
      SET FACE_VAL     =FWD_RECEIPT,
          FWD_RECEIPT  =0
   WHERE
      EFF_VALDATE=M_PROCESS_DATE
      AND
      FWD_RECEIPT>0;


   --------- Allocation informations from repo inventory ----------

    UPDATE DN_INV_REPO_DEAL_INST
    SET ALLO_REPO    =ALLO_REPO+FWD_ALLO_REPO,
        FWD_ALLO_REPO=0,
        ALLO_BL      =FWD_ALLO_BL+FWD_ALLO_BL,
        FWD_ALLO_BL  =0
    WHERE
       EFF_VALDATE=M_PROCESS_DATE
       AND
       (FWD_ALLO_REPO>0 OR FWD_ALLO_BL>0);


    UPDATE DN_INV_REPO_DEAL_SEC
    SET ALLO_REPO    =ALLO_REPO+FWD_ALLO_REPO,
        FWD_ALLO_REPO=0,
        ALLO_BL      =FWD_ALLO_BL+FWD_ALLO_BL,
        FWD_ALLO_BL  =0
    WHERE
       EFF_VALDATE=M_PROCESS_DATE
       AND
       (FWD_ALLO_REPO>0 OR FWD_ALLO_BL>0);


    UPDATE DN_INV_REPO_DEAL_SERIAL_NO
    SET ALLO_REPO    =ALLO_REPO+FWD_ALLO_REPO,
        FWD_ALLO_REPO=0,
        ALLO_BL      =FWD_ALLO_BL+FWD_ALLO_BL,
        FWD_ALLO_BL  =0
    WHERE
       EFF_VALDATE=M_PROCESS_DATE
       AND
       (FWD_ALLO_REPO>0 OR FWD_ALLO_BL>0);


END DN_INV_REPO_FWD_VALUE_TRNSFER;

/
