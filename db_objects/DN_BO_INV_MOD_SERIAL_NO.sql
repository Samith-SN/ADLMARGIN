--------------------------------------------------------
--  DDL for Procedure DN_BO_INV_MOD_SERIAL_NO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_BO_INV_MOD_SERIAL_NO" 
   (
    M_INV_MODI_NO      DN_TRN_BO_INV_MODIFY_SERIAL_NO.INV_MODI_NO%TYPE
   )

   IS

    -- Procedue     : Update new serial number in the inventory
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 09/09/1999

   M_PORTFOLIO_CODE    DN_TRN_BO_INV_MODIFY_SERIAL_NO.PORTFOLIO_CODE%TYPE;
   M_INST_TYPE         DN_TRN_BO_INV_MODIFY_SERIAL_NO.INST_TYPE%TYPE;
   M_SECURITY_CODE     DN_TRN_BO_INV_MODIFY_SERIAL_NO.SECURITY_CODE%TYPE;
   M_DEAL_NO           DN_TRN_BO_INV_MODIFY_SERIAL_NO.DEAL_NO%TYPE;
   M_OLD_SERIAL_NO     DN_TRN_BO_INV_MODIFY_SERIAL_NO.OLD_SERIAL_NO%TYPE;
   M_NEW_SERIAL_NO     DN_TRN_BO_INV_MODIFY_SERIAL_NO.NEW_SERIAL_NO%TYPE;
   M_FACE_VALUE        DN_TRN_BO_INV_MODIFY_SERIAL_NO.FACE_VALUE%TYPE;
   M_INV_CODE          DN_TRN_BO_INV_MODIFY_SERIAL_NO.INV_CODE%TYPE;

BEGIN

   SELECT
      PORTFOLIO_CODE,INST_TYPE,SECURITY_CODE,
      DEAL_NO,OLD_SERIAL_NO,NEW_SERIAL_NO,INV_CODE,FACE_VALUE
      INTO
         M_PORTFOLIO_CODE,M_INST_TYPE,M_SECURITY_CODE,
         M_DEAL_NO,M_OLD_SERIAL_NO,M_NEW_SERIAL_NO,M_INV_CODE,M_FACE_VALUE
   FROM
      DN_TRN_BO_INV_MODIFY_SERIAL_NO
   WHERE
      INV_MODI_NO=M_INV_MODI_NO;

   IF M_INV_CODE='OR' THEN

      INSERT INTO DN_INV_OUTPS_DEAL_SERIAL_NO
         (PORTFOLIO_CODE,
          EFF_VALDATE,
          INST_TYPE,
          SECURITY_CODE,
          DEAL_NO,
          SERIAL_NO,
          DEAL_YIELD,
          YIELD_WITH_BROKERAGE,
          SCRIP_FACE_VAL,
          FACE_VAL,
          INITIAL_COST,
          BROKERAGE,
          PRICE_INT_ACCR,
          CARR_VAL,
          COUP_INT_PURCH ,
          COUP_INT_ACCR ,
          TOT_COUP_INT,
          FWD_SALE,
          FWD_PURCHASE,
          LOCATION,
          ALLO_REPO ,
          ALLO_BL,
          FWD_ALLO_REPO,
          FWD_ALLO_BL,
          SALE_DEAL_NO,
          SERIAL_NO_STATUS,
          SALE_EFF_VALDATE,
          RET_DUE_DATE
         )
       SELECT
          PORTFOLIO_CODE,
          EFF_VALDATE,
          INST_TYPE,
          SECURITY_CODE,
          DEAL_NO,
          M_NEW_SERIAL_NO,
          DEAL_YIELD,
          YIELD_WITH_BROKERAGE,
          SCRIP_FACE_VAL,
          FACE_VAL,
          INITIAL_COST,
          BROKERAGE,
          PRICE_INT_ACCR,
          CARR_VAL,
          COUP_INT_PURCH,
          COUP_INT_ACCR,
          TOT_COUP_INT,
          FWD_SALE,
          FWD_PURCHASE,
          LOCATION,
          ALLO_REPO,
          ALLO_BL,
          FWD_ALLO_REPO,
          FWD_ALLO_BL,
          SALE_DEAL_NO,
          SERIAL_NO_STATUS,
          SALE_EFF_VALDATE,
          RET_DUE_DATE
       FROM
          DN_INV_OUTPS_DEAL_SERIAL_NO
       WHERE
          PORTFOLIO_CODE=M_PORTFOLIO_CODE
          AND
          INST_TYPE=M_INST_TYPE
          AND
          SECURITY_CODE=M_SECURITY_CODE
          AND
          DEAL_NO=M_DEAL_NO
          AND
          SERIAL_NO=M_OLD_SERIAL_NO
          AND
          FACE_VAL=M_FACE_VALUE;

      INSERT INTO  DN_INV_OUTPS_DEAL_SERNO_ALLO
         (PORTFOLIO_CODE,
          EFF_VALDATE,
          INST_TYPE,
          SECURITY_CODE,
          DEAL_NO ,
          SERIAL_NO,
          ALLO_TYPE,
          START_DATE,
          END_DATE,
          ALLO_FACE_VALUE,
          PREV_DEAL_NO
         )
      SELECT
         PORTFOLIO_CODE,
         EFF_VALDATE,
         INST_TYPE,
         SECURITY_CODE,
         DEAL_NO ,
         M_NEW_SERIAL_NO,
         ALLO_TYPE,
         START_DATE,
         END_DATE,
         ALLO_FACE_VALUE,
         PREV_DEAL_NO
      FROM
         DN_INV_OUTPS_DEAL_SERNO_ALLO
      WHERE
         PORTFOLIO_CODE=M_PORTFOLIO_CODE
         AND
         INST_TYPE=M_INST_TYPE
         AND
         SECURITY_CODE=M_SECURITY_CODE
         AND
         PREV_DEAL_NO=M_DEAL_NO
         AND
         SERIAL_NO=M_OLD_SERIAL_NO;

      DELETE  DN_INV_OUTPS_DEAL_SERNO_ALLO
      WHERE
         PORTFOLIO_CODE=M_PORTFOLIO_CODE
         AND
         INST_TYPE=M_INST_TYPE
         AND
         SECURITY_CODE=M_SECURITY_CODE
         AND
         PREV_DEAL_NO=M_DEAL_NO
         AND
         SERIAL_NO=M_OLD_SERIAL_NO;


       DELETE DN_INV_OUTPS_DEAL_SERIAL_NO
       WHERE
          PORTFOLIO_CODE=M_PORTFOLIO_CODE
          AND
          INST_TYPE=M_INST_TYPE
          AND
          SECURITY_CODE=M_SECURITY_CODE
          AND
          DEAL_NO=M_DEAL_NO
          AND
          SERIAL_NO=M_OLD_SERIAL_NO
          AND
          FACE_VAL=M_FACE_VALUE;

       UPDATE DN_INV_INT_OUTPS_DEAL_SERNO
       SET SERIAL_NO=M_NEW_SERIAL_NO
       WHERE
          PORTFOLIO_CODE=M_PORTFOLIO_CODE
          AND
          INST_TYPE=M_INST_TYPE
          AND
          SECURITY_CODE=M_SECURITY_CODE
          AND
          DEAL_NO=M_DEAL_NO
          AND
          SERIAL_NO=M_OLD_SERIAL_NO
          AND
          FACE_VAL=M_FACE_VALUE;

      UPDATE DN_INV_SUS_ISSUE_SERIAL_NO
        SET SERIAL_NO=M_NEW_SERIAL_NO
      WHERE
        INST_TYPE=M_INST_TYPE
        AND
        INV_CODE=M_INV_CODE
        AND
        SECURITY_CODE=M_SECURITY_CODE
        AND
        DEAL_NO=M_DEAL_NO
        AND
        SERIAL_NO=M_OLD_SERIAL_NO
        AND
        ACT_FACE_VALUE=M_FACE_VALUE;

      UPDATE DN_INV_SUS_RECEIPT_SERIAL_NO
        SET SERIAL_NO=M_NEW_SERIAL_NO
      WHERE
        INST_TYPE=M_INST_TYPE
        AND
        INV_CODE=M_INV_CODE
        AND
        SECURITY_CODE=M_SECURITY_CODE
        AND
        DEAL_NO=M_DEAL_NO
        AND
        SERIAL_NO=M_OLD_SERIAL_NO
        AND
        ACT_FACE_VALUE=M_FACE_VALUE;

   ELSIF  M_INV_CODE='RP' THEN

     INSERT INTO DN_INV_REPO_DEAL_SERIAL_NO
        (PORTFOLIO_CODE,
         EFF_VALDATE ,
         INST_TYPE ,
         SECURITY_CODE ,
         DEAL_NO ,
         SERIAL_NO,
         SCRIP_FACE_VAL,
         FACE_VAL,
         FWD_RECEIPT,
         LOCATION,
         ALLO_REPO,
         ALLO_BL,
         FWD_ALLO_REPO,
         FWD_ALLO_BL ,
         RET_DUE_DATE
        )
     SELECT
        PORTFOLIO_CODE,
        EFF_VALDATE ,
        INST_TYPE ,
        SECURITY_CODE ,
        DEAL_NO ,
        M_NEW_SERIAL_NO,
        SCRIP_FACE_VAL,
        FACE_VAL,
        FWD_RECEIPT,
        LOCATION,
        ALLO_REPO,
        ALLO_BL,
        FWD_ALLO_REPO,
        FWD_ALLO_BL ,
        RET_DUE_DATE
     FROM
        DN_INV_REPO_DEAL_SERIAL_NO
     WHERE
        PORTFOLIO_CODE=M_PORTFOLIO_CODE
        AND
        INST_TYPE=M_INST_TYPE
        AND
        SECURITY_CODE=M_SECURITY_CODE
        AND
        DEAL_NO=M_DEAL_NO
        AND
        SERIAL_NO=M_OLD_SERIAL_NO
        AND
        FACE_VAL=M_FACE_VALUE;


      INSERT INTO  DN_INV_REPO_DEAL_SERNO_ALLO
         (PORTFOLIO_CODE,
          EFF_VALDATE,
          INST_TYPE,
          SECURITY_CODE,
          DEAL_NO ,
          SERIAL_NO,
          ALLO_TYPE,
          START_DATE,
          END_DATE,
          ALLO_FACE_VALUE,
          PREV_DEAL_NO
         )
      SELECT
         PORTFOLIO_CODE,
         EFF_VALDATE,
         INST_TYPE,
         SECURITY_CODE,
         DEAL_NO ,
         M_NEW_SERIAL_NO,
         ALLO_TYPE,
         START_DATE,
         END_DATE,
         ALLO_FACE_VALUE,
         PREV_DEAL_NO
      FROM
         DN_INV_REPO_DEAL_SERNO_ALLO
      WHERE
         PORTFOLIO_CODE=M_PORTFOLIO_CODE
         AND
         INST_TYPE=M_INST_TYPE
         AND
         SECURITY_CODE=M_SECURITY_CODE
         AND
         PREV_DEAL_NO=M_DEAL_NO
         AND
         SERIAL_NO=M_OLD_SERIAL_NO;

      DELETE  DN_INV_REPO_DEAL_SERNO_ALLO
      WHERE
         PORTFOLIO_CODE=M_PORTFOLIO_CODE
         AND
         INST_TYPE=M_INST_TYPE
         AND
         SECURITY_CODE=M_SECURITY_CODE
         AND
         PREV_DEAL_NO=M_DEAL_NO
         AND
         SERIAL_NO=M_OLD_SERIAL_NO;


       DELETE DN_INV_REPO_DEAL_SERIAL_NO
       WHERE
          PORTFOLIO_CODE=M_PORTFOLIO_CODE
          AND
          INST_TYPE=M_INST_TYPE
          AND
          SECURITY_CODE=M_SECURITY_CODE
          AND
          DEAL_NO=M_DEAL_NO
          AND
          SERIAL_NO=M_OLD_SERIAL_NO
          AND
          FACE_VAL=M_FACE_VALUE;

      UPDATE DN_INV_SUS_ISSUE_SERIAL_NO
        SET SERIAL_NO=M_NEW_SERIAL_NO
      WHERE
        INST_TYPE=M_INST_TYPE
        AND
        INV_CODE=M_INV_CODE
        AND
        SECURITY_CODE=M_SECURITY_CODE
        AND
        DEAL_NO=M_DEAL_NO
        AND
        SERIAL_NO=M_OLD_SERIAL_NO
        AND
        ACT_FACE_VALUE=M_FACE_VALUE;

      UPDATE DN_INV_SUS_RECEIPT_SERIAL_NO
        SET SERIAL_NO=M_NEW_SERIAL_NO
      WHERE
        INST_TYPE=M_INST_TYPE
        AND
        INV_CODE=M_INV_CODE
        AND
        SECURITY_CODE=M_SECURITY_CODE
        AND
        DEAL_NO=M_DEAL_NO
        AND
        SERIAL_NO=M_OLD_SERIAL_NO
        AND
        ACT_FACE_VALUE=M_FACE_VALUE;

   ELSIF M_INV_CODE='BL' THEN

      INSERT INTO DN_INV_BL_DEAL_SERIAL_NO
        (PORTFOLIO_CODE,
         EFF_VALDATE ,
         INST_TYPE ,
         SECURITY_CODE ,
         DEAL_NO ,
         SERIAL_NO,
         SCRIP_FACE_VAL,
         FACE_VAL,
         FWD_RECEIPT,
         LOCATION,
         ALLO_REPO,
         ALLO_BL,
         FWD_ALLO_REPO,
         FWD_ALLO_BL ,
         RET_DUE_DATE
        )
     SELECT
        PORTFOLIO_CODE,
        EFF_VALDATE ,
        INST_TYPE ,
        SECURITY_CODE ,
        DEAL_NO ,
        M_NEW_SERIAL_NO,
        SCRIP_FACE_VAL,
        FACE_VAL,
        FWD_RECEIPT,
        LOCATION,
        ALLO_REPO,
        ALLO_BL,
        FWD_ALLO_REPO,
        FWD_ALLO_BL ,
        RET_DUE_DATE
     FROM
        DN_INV_BL_DEAL_SERIAL_NO
     WHERE
        PORTFOLIO_CODE=M_PORTFOLIO_CODE
        AND
        INST_TYPE=M_INST_TYPE
        AND
        SECURITY_CODE=M_SECURITY_CODE
        AND
        DEAL_NO=M_DEAL_NO
        AND
        SERIAL_NO=M_OLD_SERIAL_NO
        AND
        FACE_VAL=M_FACE_VALUE;


      INSERT INTO  DN_INV_BL_DEAL_SERNO_ALLO
         (PORTFOLIO_CODE,
          EFF_VALDATE,
          INST_TYPE,
          SECURITY_CODE,
          DEAL_NO ,
          SERIAL_NO,
          ALLO_TYPE,
          START_DATE,
          END_DATE,
          ALLO_FACE_VALUE,
          PREV_DEAL_NO
         )
      SELECT
         PORTFOLIO_CODE,
         EFF_VALDATE,
         INST_TYPE,
         SECURITY_CODE,
         DEAL_NO ,
         M_NEW_SERIAL_NO,
         ALLO_TYPE,
         START_DATE,
         END_DATE,
         ALLO_FACE_VALUE,
         PREV_DEAL_NO
      FROM
         DN_INV_BL_DEAL_SERNO_ALLO
      WHERE
         PORTFOLIO_CODE=M_PORTFOLIO_CODE
         AND
         INST_TYPE=M_INST_TYPE
         AND
         SECURITY_CODE=M_SECURITY_CODE
         AND
         PREV_DEAL_NO=M_DEAL_NO
         AND
         SERIAL_NO=M_OLD_SERIAL_NO;

      DELETE  DN_INV_BL_DEAL_SERNO_ALLO
      WHERE
         PORTFOLIO_CODE=M_PORTFOLIO_CODE
         AND
         INST_TYPE=M_INST_TYPE
         AND
         SECURITY_CODE=M_SECURITY_CODE
         AND
         PREV_DEAL_NO=M_DEAL_NO
         AND
         SERIAL_NO=M_OLD_SERIAL_NO;


       DELETE DN_INV_BL_DEAL_SERIAL_NO
       WHERE
          PORTFOLIO_CODE=M_PORTFOLIO_CODE
          AND
          INST_TYPE=M_INST_TYPE
          AND
          SECURITY_CODE=M_SECURITY_CODE
          AND
          DEAL_NO=M_DEAL_NO
          AND
          SERIAL_NO=M_OLD_SERIAL_NO
          AND
          FACE_VAL=M_FACE_VALUE;

      UPDATE DN_INV_SUS_ISSUE_SERIAL_NO
        SET SERIAL_NO=M_NEW_SERIAL_NO
      WHERE
        INST_TYPE=M_INST_TYPE
        AND
        INV_CODE=M_INV_CODE
        AND
        SECURITY_CODE=M_SECURITY_CODE
        AND
        DEAL_NO=M_DEAL_NO
        AND
        SERIAL_NO=M_OLD_SERIAL_NO
        AND
        ACT_FACE_VALUE=M_FACE_VALUE;

      UPDATE DN_INV_SUS_RECEIPT_SERIAL_NO
        SET SERIAL_NO=M_NEW_SERIAL_NO
      WHERE
        INST_TYPE=M_INST_TYPE
        AND
        INV_CODE=M_INV_CODE
        AND
        SECURITY_CODE=M_SECURITY_CODE
        AND
        DEAL_NO=M_DEAL_NO
        AND
        SERIAL_NO=M_OLD_SERIAL_NO
        AND
        ACT_FACE_VALUE=M_FACE_VALUE;

   END IF;


END DN_BO_INV_MOD_SERIAL_NO;

/
