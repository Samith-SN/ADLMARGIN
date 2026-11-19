--------------------------------------------------------
--  DDL for Procedure DN_AUTO_REPOROLLOVER_REPO_JOB
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_AUTO_REPOROLLOVER_REPO_JOB" 
(   M_DEAL_NO               DN_TRN_REPO_ROLLOVER.DEAL_NO%TYPE,
    M_INSTRUMENT            DN_TRN_REPO_ROLLOVER_INST.INST_TYPE%TYPE,
    M_HAIR_CUT              DN_TRN_REPO_ROLLOVER_INST.RPTRN_HCUT_PER%TYPE,
    M_LEND_PORTFOLIO_CODE   DN_TRN_REPO_ROLLOVER.LEND_PORTFOLIO_CODE%TYPE,
    M_AMOUNT                DN_TRN_REPO_ROLLOVER.LEG1_VALUE%TYPE,
    --M_LOC_CODE              DN_REF_REPO_RATE.LOC_CODE%TYPE,
    M_YIELD                 DN_TRN_REPO_ROLLOVER.YEILD%TYPE


 )

AS


 --MSERIAL_NO    DN_REF_REPO_DATA.SERIAL_NO%TYPE;
 --M_SECURITY    DN_REF_REPO_DATA.SEC_CODE%TYPE;
 --MTYPE         DN_REF_REPO_DATA.INV_TYPE%TYPE;
 MVALDATE      VARCHAR2(15);
 MHAIRCUTVAL   DN_TRN_REPO_ROLLOVER_SEC.FVAL_WITH_HAIR_CUT%TYPE;
 M_BRCNT       NUMBER  DEFAULT 0;
 M_COUNT       NUMBER;

BEGIN

/*SELECT NVL(COUNT(*),0)  INTO M_BRCNT FROM  DN_REF_REPO_DATA WHERE LOC_CODE=M_LOC_CODE;

IF M_BRCNT = 1 THEN

SELECT     SERIAL_NO,INV_TYPE,SEC_CODE
INTO       MSERIAL_NO,MTYPE,M_SECURITY
FROM       DN_REF_REPO_DATA WHERE LOC_CODE=M_LOC_CODE;

ELSE

MTYPE:='RP';

END IF;
*/
SELECT TO_CHAR(DN_FIN_EFF_VALDATE('TOM'),'DD/MM/YYYY') INTO MVALDATE FROM DUAL;
--RAISE_APPLICATION_ERROR(-20201,'MVALDATE**********'||MVALDATE||'M_SECURITY'||M_SECURITY||'M_YIELD'||M_YIELD);

--SELECT DN_FIN_PRICE_CLEAN_YIELD(M_SECURITY,M_YIELD,TO_DATE(MVALDATE,'DD/MM/YYYY'),'A365') INTO  MHAIRCUTVAL FROM DUAL;

/*INST TABLE*/
--dbms_output.put_line('Value of DN_TRN_REPO_ROLLOVER_INST=333');

 SELECT COUNT(*)
 INTO   M_COUNT
 FROM   DN_TRN_REPO_ROLLOVER_INST
 WHERE  DEAL_NO =M_DEAL_NO AND
        M_INSTRUMENT=M_INSTRUMENT AND
        INV_CODE = 'RP';

 IF M_COUNT =0 THEN
    INSERT INTO DN_TRN_REPO_ROLLOVER_INST
              (DEAL_NO,
               INST_TYPE,
               INV_CODE,
               RPTRN_HCUT_PER)
  VALUES(M_DEAL_NO,
                   M_INSTRUMENT,
                   'RP',--MTYPE,
                   M_HAIR_CUT);
 END IF;
/*SETTLE TABLE*/
  --dbms_output.put_line('Value of DN_TRN_REPO_ROLLOVER_INST=444');
 INSERT INTO DN_TRN_REPO_ROLLOVER_SETTLE
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
                        M_LEND_PORTFOLIO_CODE, --'ADLMT',
                        '',
                        '',
                        'Not Applicable',
                        'ADLMT',--M_LEND_PORTFOLIO_CODE,
                        '',
                        '',
                        'Not Applicable');
/*SEC TABLE*/

/*INSERT INTO DN_TRN_REPO_ROLLOVER_SEC
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

INSERT INTO DN_TRN_REPO_ROLLOVER_SERIAL_NO
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
                     'NWSL');
*/
END DN_AUTO_REPOROLLOVER_REPO_JOB;

/
