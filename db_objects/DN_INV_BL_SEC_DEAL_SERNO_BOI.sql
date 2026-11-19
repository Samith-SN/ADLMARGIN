--------------------------------------------------------
--  DDL for Procedure DN_INV_BL_SEC_DEAL_SERNO_BOI
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_BL_SEC_DEAL_SERNO_BOI" 
   (
    M_DEAL_NO            DN_TRN_BO_INV_ISSUE.DEAL_NO%TYPE,
    M_INST_TYPE          DN_TRN_BO_INV_ISSUE.INST_TYPE%TYPE,
    M_SECURITY_CODE      DN_TRN_BO_INV_ISSUE.SECURITY_CODE%TYPE,
    M_SERIAL_NO          DN_TRN_BO_INV_ISSUE.SERIAL_NO%TYPE,
    M_SCRP_FACE_VALUE    DN_TRN_BL_SECURITY_SERIAL_NO.FACE_VALUE%TYPE,
    M_INV_CODE           DN_TRN_BO_INV_ISSUE.INV_CODE%TYPE,
    M_LOCATION           DN_TRN_REPO_FRESH.LEND_PORTFOLIO_CODE%TYPE

   )

   IS

    -- Procedue     : Update (BL) SEC. inventory - deal-serial number - BOI
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 24/08/1999
    -- Modified on  : 01/09/1999

  M_INV_STATUS            DN_TRN_BL_SECURITY_SERIAL_NO.INV_STATUS%TYPE;
  M_EFF_VALDATE           DN_TRN_BL_SECURITY.EFF_VALDATE%TYPE;
  M_LEND_PORTFOLIO_CODE   DN_TRN_BL_SECURITY.LEND_PORTFOLIO_CODE%TYPE;
  M_BORR_PORTFOLIO_CODE   DN_TRN_BL_SECURITY.BORR_PORTFOLIO_CODE%TYPE;
  M_MATURITY_DATE         DN_TRN_BL_SECURITY.MATURITY_DATE%TYPE;
  M_COUNT                 NUMBER; --Temp

BEGIN

   SELECT
      EFF_VALDATE,
      LEND_PORTFOLIO_CODE,BORR_PORTFOLIO_CODE,MATURITY_DATE
      INTO M_EFF_VALDATE,M_LEND_PORTFOLIO_CODE,
           M_BORR_PORTFOLIO_CODE,M_MATURITY_DATE
   FROM
      DN_TRN_BL_SECURITY
   WHERE
      DEAL_NO=M_DEAL_NO;

   SELECT
      INV_STATUS
      INTO M_INV_STATUS
   FROM
      DN_TRN_BL_SECURITY_SERIAL_NO
   WHERE
      DEAL_NO=M_DEAL_NO
      AND
      INST_TYPE=M_INST_TYPE
--      AND
--      INV_CODE=M_INV_CODE
      AND
      SECURITY_CODE=M_SECURITY_CODE
      AND
      SERIAL_NO=M_SERIAL_NO;

   IF M_INV_CODE='RP' THEN

       UPDATE DN_INV_REPO_DEAL_SERIAL_NO A
          SET A.LOCATION=M_LOCATION
       WHERE
          A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
          AND
          A.INST_TYPE=M_INST_TYPE
          AND
          A.SECURITY_CODE=M_SECURITY_CODE
          AND
          A.DEAL_NO=(SELECT
                        C.PREV_DEAL_NO
                     FROM
                        DN_INV_REPO_DEAL_SERNO_ALLO C
                     WHERE
                        C.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
                        AND
                        C.EFF_VALDATE=M_EFF_VALDATE
                        AND
                        C.INST_TYPE=M_INST_TYPE
                        AND
                        C.SECURITY_CODE=M_SECURITY_CODE
                        AND
                        C.DEAL_NO=M_DEAL_NO
                        AND
                        C.SERIAL_NO=M_SERIAL_NO
                        AND
                        C.ALLO_TYPE='BL'
                        AND
                        C.START_DATE=M_EFF_VALDATE
                        AND
                        C.END_DATE=DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,C.SECURITY_CODE))
          AND
          A.SERIAL_NO=M_SERIAL_NO;

   ELSIF  M_INV_CODE='OR' THEN

       UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO A
          SET A.LOCATION=M_LOCATION
       WHERE
          A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
          AND
          A.INST_TYPE=M_INST_TYPE
          AND
          A.SECURITY_CODE=M_SECURITY_CODE
          AND
          A.DEAL_NO=(SELECT
                        C.PREV_DEAL_NO
                     FROM
                        DN_INV_OUTPS_DEAL_SERNO_ALLO C
                     WHERE
                        C.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
                        AND
                        C.EFF_VALDATE=M_EFF_VALDATE
                        AND
                        C.INST_TYPE=M_INST_TYPE
                        AND
                        C.SECURITY_CODE=M_SECURITY_CODE
                        AND
                        C.DEAL_NO=M_DEAL_NO
                        AND
                        C.SERIAL_NO=M_SERIAL_NO
                        AND
                        C.ALLO_TYPE='BL'
                        AND
                        C.START_DATE=M_EFF_VALDATE
                        AND
                        C.END_DATE=DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,C.SECURITY_CODE))
          AND
          A.SERIAL_NO=M_SERIAL_NO;

   ELSIF  M_INV_CODE='BL' THEN

       UPDATE DN_INV_BL_DEAL_SERIAL_NO A
          SET A.LOCATION=M_LOCATION
       WHERE
          A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
          AND
          A.INST_TYPE=M_INST_TYPE
          AND
          A.SECURITY_CODE=M_SECURITY_CODE
          AND
          A.DEAL_NO=(SELECT
                        C.PREV_DEAL_NO
                     FROM
                        DN_INV_BL_DEAL_SERNO_ALLO C
                     WHERE
                        C.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
                        AND
                        C.EFF_VALDATE=M_EFF_VALDATE
                        AND
                        C.INST_TYPE=M_INST_TYPE
                        AND
                        C.SECURITY_CODE=M_SECURITY_CODE
                        AND
                        C.DEAL_NO=M_DEAL_NO
                        AND
                        C.SERIAL_NO=M_SERIAL_NO
                        AND
                        C.ALLO_TYPE='BL'
                        AND
                        C.START_DATE=M_EFF_VALDATE
                        AND
                        C.END_DATE=DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,C.SECURITY_CODE))
          AND
          A.SERIAL_NO=M_SERIAL_NO;


   END IF;

 IF M_INV_STATUS='N' THEN

    UPDATE DN_TRN_BL_SECURITY_SERIAL_NO
       SET INV_STATUS='Y1'
    WHERE
       DEAL_NO=M_DEAL_NO
       AND
       INST_TYPE=M_INST_TYPE
       AND
       SECURITY_CODE=M_SECURITY_CODE
       AND
       SERIAL_NO=M_SERIAL_NO
       AND
       FACE_VALUE=M_SCRP_FACE_VALUE
       AND
       INV_STATUS='N';


 ELSIF M_INV_STATUS='Y1' THEN

    UPDATE DN_TRN_BL_SECURITY_SERIAL_NO
       SET INV_STATUS='Y2'
    WHERE
       DEAL_NO=M_DEAL_NO
       AND
       INST_TYPE=M_INST_TYPE
       AND
       SECURITY_CODE=M_SECURITY_CODE
       AND
       SERIAL_NO=M_SERIAL_NO
       AND
       FACE_VALUE=M_SCRP_FACE_VALUE
       AND
       INV_STATUS='Y1';

  ELSIF  M_INV_STATUS='Y2' THEN

    UPDATE DN_TRN_BL_SECURITY_SERIAL_NO
       SET INV_STATUS='Y3'
    WHERE
       DEAL_NO=M_DEAL_NO
       AND
       INST_TYPE=M_INST_TYPE
       AND
       SECURITY_CODE=M_SECURITY_CODE
       AND
       SERIAL_NO=M_SERIAL_NO
       AND
       FACE_VALUE=M_SCRP_FACE_VALUE
       AND
       INV_STATUS='Y2';

 END IF;

END DN_INV_BL_SEC_DEAL_SERNO_BOI;

/
