--------------------------------------------------------
--  DDL for Procedure DN_AUTO_REPOROLLOVER_JOB_SUB1
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_AUTO_REPOROLLOVER_JOB_SUB1" 
(   M_DEAL_NO               DN_TRN_REPO_FRESH.DEAL_NO%TYPE,
    M_INSTRUMENT            DN_TRN_REPO_FRESH_INST.INST_TYPE%TYPE,
    M_HAIR_CUT              DN_TRN_REPO_FRESH_INST.RPTRN_HCUT_PER%TYPE,
    M_LEND_PORTFOLIO_CODE   DN_TRN_REPO_FRESH.LEND_PORTFOLIO_CODE%TYPE,
    M_AMOUNT                DN_TRN_REPO_FRESH.LEG1_VALUE%TYPE,
    M_YIELD                 DN_TRN_REPO_FRESH.YIELD%TYPE
 )
AS
 MVALDATE     VARCHAR2(15);
 M_BRCNT      NUMBER  DEFAULT 0;

BEGIN

SELECT NVL(COUNT(*),0)  INTO M_BRCNT FROM  DN_REF_REPO_RATE WHERE STATUS='Y';
SELECT TO_CHAR(DN_FIN_EFF_VALDATE('TOM'),'DD/MM/YYYY') INTO MVALDATE FROM DUAL;



/*INST TABLE*/
   INSERT INTO DN_TRN_REPO_FRESH_INST
              (DEAL_NO,
               INST_TYPE,
               INV_CODE,
               RPTRN_HCUT_PER)
  VALUES(M_DEAL_NO,
                   M_INSTRUMENT,
                   'RP',--MTYPE,
                   M_HAIR_CUT);
/*SETTLE TABLE*/
   INSERT INTO DN_TRN_REPO_FRESH_SETTLE
                 (DEAL_NO,
  	              SETTLE_MODE,
                  SETTLE_AMOUNT,
                  BORR_PORTFOLIO_CODE,
                  BORR_BRANCH_CODE,
                  BORR_ACC_NO,
                  BORR_SETTLE_COMMENT,
                  LEND_PORTFOLIO_CODE,
                  LEND_BRANCH_CODE,
                  LEND_ACC_NO,
                  LEND_SETTLE_COMMENT
                 )
  VALUES(M_DEAL_NO,
                        'CURR_ACC', 
                        M_AMOUNT,
                        M_LEND_PORTFOLIO_CODE,--'ADLMT',
                        '',
                        '',
                        'Not Applicable',
                         'ADLMT',--M_LEND_PORTFOLIO_CODE,
                        '',
                        '',
                        'Not Applicable');
/*SEC TABLE*/

/*INSERT INTO DN_TRN_REPO_FRESH_SEC
                 (DEAL_NO,
                  INST_TYPE,
                  INV_CODE,
                  SECURITY_CODE,
  	              FACE_VALUE,
                  FVAL_WITH_HAIR_CUT
                 )
                 VALUES(
                      M_DEAL_NO,
                      M_INSTRUMENT,
                      MTYPE,
                      M_SECURITY,
  	                  M_AMOUNT,
                      MHAIRCUTVAL  );--check with nishanfacevalue with haircut

-- SERIAL NO
INSERT INTO DN_TRN_REPO_FRESH_SERIAL_NO
                    (DEAL_NO,
                     INST_TYPE,
                     INV_CODE,
                     SECURITY_CODE,
                     SERIAL_NO,
                     FACE_VALUE,
                     LOCATION)
                 VALUES(M_DEAL_NO,
                     M_INSTRUMENT,
                     MTYPE,
                     M_SECURITY,
                     MSERIAL_NO,
                     M_AMOUNT,
                     'NWSL');*/

END DN_AUTO_REPOROLLOVER_JOB_SUB1;

/
