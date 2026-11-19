--------------------------------------------------------
--  DDL for Function DN_FIN_REPO_FR_INST_FACE_VAL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_REPO_FR_INST_FACE_VAL" 
  (
   M_DEAL_NO          DN_TRN_REPO_FRESH_INST.DEAL_NO%TYPE,
   M_INST_TYPE        DN_TRN_REPO_FRESH_INST.INST_TYPE%TYPE,
   M_INV_CODE         DN_TRN_REPO_FRESH_INST.INV_CODE%TYPE
   )

   RETURN  REAL

   IS

    -- Function     : This returns face value for the repo fresh instrument type
    -- System       : DEALNET System
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 29/07/1999

   M_RETVAL                     NUMBER;
   M_COUNT                      NUMBER;
   M_LEG1_VALUE                 DN_TRN_REPO_FRESH.LEG1_VALUE%TYPE;
   M_TENOR                      DN_TRN_REPO_FRESH.TENOR%TYPE;
   M_RPTRN_HCUT_PER             DN_TRN_REPO_FRESH_INST.RPTRN_HCUT_PER%TYPE;
   M_DENOMINATOR                DN_REF_INTR_BASE.DENOMINATOR%TYPE;



BEGIN

    SELECT
       COUNT(*) INTO M_COUNT
    FROM
       DN_TRN_REPO_FRESH_SEC
    WHERE
       DEAL_NO=M_DEAL_NO;

  IF M_COUNT>0 THEN

     SELECT
        SUM(FACE_VALUE) INTO M_RETVAL
     FROM
        DN_TRN_REPO_FRESH_SEC
     WHERE
        DEAL_NO=M_DEAL_NO
        AND
        INST_TYPE=M_INST_TYPE
        AND
        INV_CODE=M_INV_CODE;
  ELSE

     SELECT
        A.LEG1_VALUE,
        A.TENOR,
        B.RPTRN_HCUT_PER,
        C.DENOMINATOR
        INTO M_LEG1_VALUE,
             M_TENOR,
             M_RPTRN_HCUT_PER,
             M_DENOMINATOR
     FROM
        DN_TRN_REPO_FRESH A,
        DN_TRN_REPO_FRESH_INST B,
        DN_REF_INTR_BASE C
     WHERE
        A.DEAL_NO=M_DEAL_NO
        AND
        A.DEAL_NO=B.DEAL_NO
        AND
        B.INST_TYPE=M_INST_TYPE
        AND
        A.INT_RATE_BASE_CODE=C.INT_RATE_BASE_CODE;

        M_RETVAL:=M_LEG1_VALUE+(((M_LEG1_VALUE*M_RPTRN_HCUT_PER)/M_DENOMINATOR)*M_TENOR);

  END IF;

  RETURN ROUND(M_RETVAL,6);

END DN_FIN_REPO_FR_INST_FACE_VAL;

/
