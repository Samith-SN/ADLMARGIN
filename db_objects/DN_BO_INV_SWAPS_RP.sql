--------------------------------------------------------
--  DDL for Procedure DN_BO_INV_SWAPS_RP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_BO_INV_SWAPS_RP" 
   (
    M_INV_SWAP_NO      DN_TRN_BO_INV_SWAP.INV_SWAP_NO%TYPE
   )

   IS

    -- Procedue     : Update swaps of serial numbers in the R/P inventory
    -- System       : Dealnet system
    -- Created by   : TDS / SM
    -- Created on   : 02/11/1999

  CURSOR  SWP_ISSUES IS

      SELECT
          A.PORTFOLIO_CODE,
          A.INST_TYPE,
          A.SECURITY_CODE,
          A.DEAL_NO,
          A.SERIAL_NO
       FROM
          DN_INV_REPO_DEAL_SERIAL_NO A,
          DN_TRN_BO_INV_SWAP B
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.INV_CODE='RP'
          AND
          B.TRANS_TYPE='I'
          AND
          B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
          AND
          B.INST_TYPE=A.INST_TYPE
          AND
          B.SECURITY_CODE=A.SECURITY_CODE
          AND
          B.DEAL_NO=A.DEAL_NO
          AND
          B.SERIAL_NO=A.SERIAL_NO;


  CURSOR  SWP_RECEIPTS IS

      SELECT DISTINCT
          A.PORTFOLIO_CODE,
          A.INST_TYPE,
          A.SECURITY_CODE,
          C.DEAL_NO,
          C.SERIAL_NO,
          A.LOCATION,
          A.RET_DUE_DATE,
          C.FACE_VALUE
       FROM
          DN_INV_REPO_DEAL_SERIAL_NO A,
          DN_TRN_BO_INV_SWAP B,
          DN_TRN_BO_INV_SWAP C
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.INV_CODE='RP'
          AND
          B.TRANS_TYPE='I'
          AND
          B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
          AND
          B.INST_TYPE=A.INST_TYPE
          AND
          B.SECURITY_CODE=A.SECURITY_CODE
          AND
          B.DEAL_NO=A.DEAL_NO
          AND
          B.SERIAL_NO=A.SERIAL_NO
          AND
          B.INV_SWAP_NO=C.INV_SWAP_NO
          AND
          C.INV_CODE='RP'
          AND
          C.TRANS_TYPE='R';


M_PORTFOLIO_CODE                DN_INV_BL_DEAL_SERIAL_NO.PORTFOLIO_CODE%TYPE;
M_INST_TYPE                     DN_INV_BL_DEAL_SERIAL_NO.INST_TYPE%TYPE;
M_SECURITY_CODE                 DN_INV_BL_DEAL_SERIAL_NO.SECURITY_CODE%TYPE;
M_DEAL_NO                       DN_INV_BL_DEAL_SERIAL_NO.DEAL_NO%TYPE;
M_TOT_FACE_VAL                  DN_INV_BL_DEAL_SERIAL_NO.SCRIP_FACE_VAL%TYPE;
M_TOT_FWD_RECEIPT               DN_INV_BL_DEAL_SERIAL_NO.FWD_RECEIPT%TYPE;
M_TOT_ALLO_REPO                 DN_INV_BL_DEAL_SERIAL_NO.ALLO_REPO%TYPE;
M_TOT_ALLO_BL                   DN_INV_BL_DEAL_SERIAL_NO.ALLO_BL%TYPE;
M_TOT_FWD_ALLO_REPO             DN_INV_BL_DEAL_SERIAL_NO.FWD_ALLO_REPO%TYPE;
M_TOT_FWD_ALLO_BL               DN_INV_BL_DEAL_SERIAL_NO.FWD_ALLO_BL%TYPE;
M_SERIAL_NO                     DN_INV_BL_DEAL_SERIAL_NO.SERIAL_NO%TYPE;
M_LOCATION                      DN_INV_BL_DEAL_SERIAL_NO.LOCATION%TYPE;
M_RET_DUE_DATE                  DN_INV_BL_DEAL_SERIAL_NO.RET_DUE_DATE%TYPE;
M_FACE_VALUE                    DN_INV_BL_DEAL_SERIAL_NO.FACE_VAL%TYPE;

BEGIN


   OPEN SWP_RECEIPTS;

   LOOP

      FETCH  SWP_RECEIPTS INTO

          M_PORTFOLIO_CODE,
          M_INST_TYPE,
          M_SECURITY_CODE,
          M_DEAL_NO,
          M_SERIAL_NO,
          M_LOCATION,
          M_RET_DUE_DATE,
          M_FACE_VALUE;


      EXIT WHEN SWP_RECEIPTS%NOTFOUND;

       SELECT
          SUM(FACE_VAL),
          SUM(A.FWD_RECEIPT),
          SUM(A.ALLO_REPO),
          SUM(A.ALLO_BL),
          SUM(A.FWD_ALLO_REPO),
          SUM(A.FWD_ALLO_BL)
          INTO
          M_TOT_FACE_VAL,
          M_TOT_FWD_RECEIPT,
          M_TOT_ALLO_REPO,
          M_TOT_ALLO_BL,
          M_TOT_FWD_ALLO_REPO,
          M_TOT_FWD_ALLO_BL
       FROM
          DN_INV_REPO_DEAL_SERIAL_NO A,
          DN_TRN_BO_INV_SWAP B
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.INV_CODE='RP'
          AND
          B.TRANS_TYPE='I'
          AND
          B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
          AND
          B.INST_TYPE=A.INST_TYPE
          AND
          B.SECURITY_CODE=A.SECURITY_CODE
          AND
          B.DEAL_NO=A.DEAL_NO
          AND
          B.SERIAL_NO=A.SERIAL_NO;


      INSERT INTO DN_INV_REPO_DEAL_SERIAL_NO
         (PORTFOLIO_CODE,
          EFF_VALDATE,
          INST_TYPE,
          SECURITY_CODE,
          DEAL_NO,
          SERIAL_NO,
          SCRIP_FACE_VAL,
          FACE_VAL,
          FWD_RECEIPT,
          LOCATION,
          ALLO_REPO ,
          ALLO_BL,
          FWD_ALLO_REPO,
          FWD_ALLO_BL,
          RET_DUE_DATE
         )
       SELECT
          M_PORTFOLIO_CODE,
          SYSDATE,
          M_INST_TYPE,
          M_SECURITY_CODE,
          M_DEAL_NO,
          M_SERIAL_NO,
          M_FACE_VALUE,
          M_FACE_VALUE,
          M_TOT_FWD_RECEIPT*(M_FACE_VALUE/M_TOT_FACE_VAL),
          M_LOCATION,
          M_TOT_ALLO_REPO*(M_FACE_VALUE/M_TOT_FACE_VAL),
          M_TOT_ALLO_BL*(M_FACE_VALUE/M_TOT_FACE_VAL),
          M_TOT_FWD_ALLO_REPO*(M_FACE_VALUE/M_TOT_FACE_VAL),
          M_TOT_FWD_ALLO_BL*(M_FACE_VALUE/M_TOT_FACE_VAL),
          M_RET_DUE_DATE
       FROM
          DUAL;


   END LOOP;

   OPEN SWP_ISSUES;

   LOOP

      FETCH  SWP_ISSUES INTO

          M_PORTFOLIO_CODE,
          M_INST_TYPE,
          M_SECURITY_CODE,
          M_DEAL_NO,
          M_SERIAL_NO;


      EXIT WHEN SWP_ISSUES%NOTFOUND;


      UPDATE DN_INV_REPO_DEAL_SERIAL_NO
      SET RET_DUE_DATE=SYSDATE
      WHERE
          PORTFOLIO_CODE=M_PORTFOLIO_CODE
          AND
          INST_TYPE=M_INST_TYPE
          AND
          SECURITY_CODE=M_SECURITY_CODE
          AND
          DEAL_NO=M_DEAL_NO
          AND
          SERIAL_NO=M_SERIAL_NO;

   END LOOP;


END DN_BO_INV_SWAPS_RP;

/
