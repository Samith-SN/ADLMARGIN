--------------------------------------------------------
--  DDL for Procedure DN_INV_ALLO_BL_VAL_MATURITY
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_ALLO_BL_VAL_MATURITY" 
(
 M_PROCESS_DATE    DN_SYS_PARAMETER.LAST_DAILY%TYPE
)

   -- Procedure    : Adjust allocated to BL on maturity date
   -- System       : Dealnet system
   -- Created by   : ITU - D.P. Pubudu Thushara
   -- Created on   : 20/08/1999

  AS

    CURSOR OUTPS_SERNO IS
       SELECT
          PORTFOLIO_CODE,
          INST_TYPE,
          SECURITY_CODE,
          PREV_DEAL_NO,
          SERIAL_NO,
          ALLO_FACE_VALUE
       FROM DN_INV_OUTPS_DEAL_SERNO_ALLO
       WHERE
         END_DATE=M_PROCESS_DATE
         AND
         ALLO_TYPE='BL';

     CURSOR REPO_SERNO IS
       SELECT
          PORTFOLIO_CODE,
          INST_TYPE,
          SECURITY_CODE,
          PREV_DEAL_NO,
          SERIAL_NO,
          ALLO_FACE_VALUE
       FROM DN_INV_REPO_DEAL_SERNO_ALLO
       WHERE
         END_DATE=M_PROCESS_DATE
         AND
         ALLO_TYPE='BL';


    CURSOR BL_SERNO IS
       SELECT
          PORTFOLIO_CODE,
          INST_TYPE,
          SECURITY_CODE,
          PREV_DEAL_NO,
          SERIAL_NO,
          ALLO_FACE_VALUE
       FROM DN_INV_BL_DEAL_SERNO_ALLO
       WHERE
         END_DATE=M_PROCESS_DATE
         AND
         ALLO_TYPE='BL';


    M_PORTFOLIO_CODE   DN_INV_REPO_DEAL_SERNO_ALLO.PORTFOLIO_CODE%TYPE;
    M_INST_TYPE        DN_INV_REPO_DEAL_SERNO_ALLO.INST_TYPE%TYPE;
    M_SECURITY_CODE    DN_INV_REPO_DEAL_SERNO_ALLO.SECURITY_CODE%TYPE;
    M_PREV_DEAL_NO     DN_INV_REPO_DEAL_SERNO_ALLO.PREV_DEAL_NO%TYPE;
    M_SERIAL_NO        DN_INV_REPO_DEAL_SERNO_ALLO.SERIAL_NO%TYPE;
    M_ALLO_FACE_VALUE  DN_INV_REPO_DEAL_SERNO_ALLO.ALLO_FACE_VALUE%TYPE;

BEGIN

      --Repo inventory

      UPDATE DN_INV_REPO_DEAL_INST
      SET ALLO_BL    =0
      WHERE
         RET_DUE_DATE=M_PROCESS_DATE;

      UPDATE DN_INV_REPO_DEAL_SEC
      SET ALLO_BL    =0
      WHERE
         RET_DUE_DATE=M_PROCESS_DATE;

      OPEN REPO_SERNO;

      LOOP

         FETCH  REPO_SERNO INTO

             M_PORTFOLIO_CODE,
             M_INST_TYPE,
             M_SECURITY_CODE,
             M_PREV_DEAL_NO,
             M_SERIAL_NO,
             M_ALLO_FACE_VALUE;

         EXIT WHEN REPO_SERNO%NOTFOUND;

         UPDATE DN_INV_REPO_DEAL_SERIAL_NO
            SET ALLO_BL=ALLO_BL-M_ALLO_FACE_VALUE
         WHERE
            PORTFOLIO_CODE=M_PORTFOLIO_CODE
            AND
            INST_TYPE=M_INST_TYPE
            AND
            SECURITY_CODE=M_SECURITY_CODE
            AND
            DEAL_NO=M_PREV_DEAL_NO
            AND
            SERIAL_NO=M_SERIAL_NO;


      END LOOP;

      -- Outright inventory


      UPDATE DN_INV_OUTPS_DEAL_INST_ALLO
      SET ALLO_BL    =0
      WHERE
         RET_DUE_DATE=M_PROCESS_DATE;

      UPDATE DN_INV_OUTPS_DEAL_SEC
      SET ALLO_BL    =0
      WHERE
         RET_DUE_DATE=M_PROCESS_DATE;

      OPEN OUTPS_SERNO;

      LOOP

         FETCH  OUTPS_SERNO INTO

             M_PORTFOLIO_CODE,
             M_INST_TYPE,
             M_SECURITY_CODE,
             M_PREV_DEAL_NO,
             M_SERIAL_NO,
             M_ALLO_FACE_VALUE;

         EXIT WHEN OUTPS_SERNO%NOTFOUND;

         UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
            SET ALLO_BL=ALLO_BL-M_ALLO_FACE_VALUE
         WHERE
            PORTFOLIO_CODE=M_PORTFOLIO_CODE
            AND
            INST_TYPE=M_INST_TYPE
            AND
            SECURITY_CODE=M_SECURITY_CODE
            AND
            DEAL_NO=M_PREV_DEAL_NO
            AND
            SERIAL_NO=M_SERIAL_NO;


      END LOOP;

      -- B/L Inventory

      UPDATE DN_INV_BL_DEAL_INST
      SET ALLO_BL    =0
      WHERE
         RET_DUE_DATE=M_PROCESS_DATE;

      UPDATE DN_INV_BL_DEAL_SEC
      SET ALLO_BL    =0
      WHERE
         RET_DUE_DATE=M_PROCESS_DATE;

      OPEN BL_SERNO;

      LOOP

         FETCH  BL_SERNO INTO

             M_PORTFOLIO_CODE,
             M_INST_TYPE,
             M_SECURITY_CODE,
             M_PREV_DEAL_NO,
             M_SERIAL_NO,
             M_ALLO_FACE_VALUE;

         EXIT WHEN BL_SERNO%NOTFOUND;

         UPDATE DN_INV_BL_DEAL_SERIAL_NO
            SET ALLO_BL=ALLO_BL-M_ALLO_FACE_VALUE
         WHERE
            PORTFOLIO_CODE=M_PORTFOLIO_CODE
            AND
            INST_TYPE=M_INST_TYPE
            AND
            SECURITY_CODE=M_SECURITY_CODE
            AND
            DEAL_NO=M_PREV_DEAL_NO
            AND
            SERIAL_NO=M_SERIAL_NO;


      END LOOP;

END DN_INV_ALLO_BL_VAL_MATURITY;

/
