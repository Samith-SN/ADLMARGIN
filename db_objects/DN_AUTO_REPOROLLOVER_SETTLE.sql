--------------------------------------------------------
--  DDL for Procedure DN_AUTO_REPOROLLOVER_SETTLE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_AUTO_REPOROLLOVER_SETTLE" 
(
     M_DEAL_NO               DN_TRN_REPO_SETTLEMENT_SETTLE.DEAL_NO%TYPE,
     M_SETTLE                DN_TRN_REPO_SETTLEMENT_SETTLE.SETTLE_MODE%TYPE,
     M_SETAMT                DN_TRN_REPO_SETTLEMENT_SETTLE.SETTLE_AMOUNT%TYPE,
     M_BCODE                 DN_TRN_REPO_SETTLEMENT_SETTLE.LEND_PORTFOLIO_CODE%TYPE,
     M_BORR_BRANCH_CODE      DN_TRN_REPO_SETTLEMENT_SETTLE.LEND_BRANCH_CODE%TYPE,
     M_BACC                  DN_TRN_REPO_SETTLEMENT_SETTLE.LEND_ACC_NO%TYPE,
     M_COMM1                 DN_TRN_REPO_SETTLEMENT_SETTLE.LEND_SETTLE_COMMENT%TYPE,
     M_LCODE                 DN_TRN_REPO_SETTLEMENT_SETTLE.LEND_PORTFOLIO_CODE%TYPE,
     M_LEND_BRANCH_CODE      DN_TRN_REPO_SETTLEMENT_SETTLE.LEND_BRANCH_CODE%TYPE,
     M_SACC                  DN_TRN_REPO_SETTLEMENT_SETTLE.LEND_ACC_NO%TYPE,
     M_COMM2                 DN_TRN_REPO_SETTLEMENT_SETTLE.LEND_SETTLE_COMMENT%TYPE,
     M_CURR                  DN_TRN_REPO_SETTLEMENT.CURR_CODE%TYPE,
     MM_CURRENCY_VALUE       DN_REF_EXCHANGE_RATES.CURRENCY_VALUE%TYPE

 )

AS

 --MSERIAL_NO   DN_REF_REPO_RATE.SERIAL_NO%TYPE;
 --M_SECURITY   DN_REF_REPO_RATE.SEC_CODE%TYPE;
 --MTYPE        DN_REF_REPO_RATE.INV_TYPE%TYPE;
 MVALDATE     VARCHAR2(15);
 MHAIRCUTVAL  DN_TRN_REPO_FRESH_SEC.FVAL_WITH_HAIR_CUT%TYPE;
 M_BRCNT       NUMBER  DEFAULT 0;
 err_num      VARCHAR2(250);
 err_msg      VARCHAR2(250);


BEGIN

IF M_CURR<>'SLR' THEN --CURRENCY
        UPDATE DN_TRN_REPO_SETTLEMENT_SETTLE
         SET SETTLE_AMOUNT       =M_SETAMT*MM_CURRENCY_VALUE,--CURRENCY
             BORR_PORTFOLIO_CODE =M_BCODE,
             BORR_BRANCH_CODE    =M_BORR_BRANCH_CODE,
             BORR_ACC_NO         =M_BACC,
             BORR_SETTLE_COMMENT =M_COMM1,
             LEND_PORTFOLIO_CODE =M_LCODE,
             LEND_BRANCH_CODE    =M_LEND_BRANCH_CODE,
             LEND_ACC_NO         =M_SACC,
             LEND_SETTLE_COMMENT =M_COMM2,
             CURRENCY_SETTLE_AMOUNT=M_SETAMT--CURRENCY
         WHERE
             DEAL_NO    =M_DEAL_NO
             AND
             SETTLE_MODE=M_SETTLE;

             IF SQL%NOTFOUND THEN
                INSERT INTO DN_TRN_REPO_SETTLEMENT_SETTLE
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
                 LEND_SETTLE_COMMENT,
                 CURRENCY_SETTLE_AMOUNT--CURRENCY
                )
                VALUES(M_DEAL_NO,
                       M_SETTLE,
                       M_SETAMT*MM_CURRENCY_VALUE,--CURRENCY
                       M_BCODE,
                       M_BORR_BRANCH_CODE,
                       M_BACC,
                       M_COMM1,
                       M_LCODE,
                       M_LEND_BRANCH_CODE,
                       M_SACC,
                       M_COMM2,
                       M_SETAMT--CURRENCY
                );
             END IF;

          ELSE --CURRENCY
         UPDATE DN_TRN_REPO_SETTLEMENT_SETTLE
         SET SETTLE_AMOUNT       =M_SETAMT,
             BORR_PORTFOLIO_CODE =M_BCODE,
             BORR_BRANCH_CODE    =M_BORR_BRANCH_CODE,
             BORR_ACC_NO         =M_BACC,
             BORR_SETTLE_COMMENT =M_COMM1,
             LEND_PORTFOLIO_CODE =M_LCODE,
             LEND_BRANCH_CODE    =M_LEND_BRANCH_CODE,
             LEND_ACC_NO         =M_SACC,
             LEND_SETTLE_COMMENT =M_COMM2
         WHERE
             DEAL_NO    =M_DEAL_NO
             AND
             SETTLE_MODE=M_SETTLE;


--RAISE_APPLICATION_ERROR(-20201,'M_DEAL_NO'||M_DEAL_NO||'M_SETTLE'||M_SETTLE||'M_SETAMT'||M_SETAMT||'M_BCODE'||M_BCODE||'M_BORR_BRANCH_CODE'||M_BORR_BRANCH_CODE||'M_BACC'||M_BACC||'M_COMM1'||M_COMM1||'M_LCODE'||M_LCODE||''||  M_LEND_BRANCH_CODE||'M_SACC'||M_SACC||'M_COMM2'||M_COMM2);

             IF SQL%NOTFOUND THEN
                INSERT INTO DN_TRN_REPO_SETTLEMENT_SETTLE
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
                       M_SETTLE,
                       M_SETAMT,
                       M_BCODE,
                       M_BORR_BRANCH_CODE,
                       M_BACC,
                       M_COMM1,
                       M_LCODE,
                       M_LEND_BRANCH_CODE,
                       M_SACC,
                       M_COMM2
                );
             END IF;

      END IF;--CURRENCY

   COMMIT;

    --If the data type is incorrect then delete the records from the relavent tables
EXCEPTION
  WHEN OTHERS THEN
  ROLLBACK;
   err_num :=  substr(SQLCODE,1,15);
   err_msg := substr(SQLERRM,1,200) ;
  INSERT INTO DN_REF_SEQUENCE_LOG VALUES (M_DEAL_NO,err_num||''||err_msg,'ERROR IN REPOSETTLEMENT',SYSDATE);
  COMMIT;
 RAISE_APPLICATION_ERROR(-20201,SQLCODE||SQLERRM);


END DN_AUTO_REPOROLLOVER_SETTLE;

/
