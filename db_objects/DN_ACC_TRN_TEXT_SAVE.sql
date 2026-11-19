--------------------------------------------------------
--  DDL for Procedure DN_ACC_TRN_TEXT_SAVE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_ACC_TRN_TEXT_SAVE" 
   (M_RUN_DATE                       varchar2,-- DN_ACC_TRN_TEXT.RUNDATE%TYPE,
    M_USER                            DN_ACC_TRN_TEXT.DN_USER%TYPE
  
    )

AS

BEGIN
   /* PROCEDURE  -  DN_ACC_TRN_LOG
   SYSTEM     -  PABC
   CREATED BY -  WARUNA
   CREATED ON -  10/08/2010*/
  
INSERT INTO DN_ACC_TRN_TEXT(PORTFOLIO_CODE ,TRNDATE, ACC_TYPE_CODE,TRNAMOUNT,ENTDATE,PROC_DESC,CORR_ACC_NO,RUNDATE,DN_USER)
  (SELECT a.portfolio_code, a.ww, a.acc_type_code,TO_NUMBER(SUM (trnamount)), a.rr,a.proc_desc, a.corr_acc_no,a.ww,M_USER
        FROM (SELECT   TO_CHAR (entdate, 'DD/MON/YY') rr,
                   TO_CHAR (trndate, 'DD/MON/YY') ww, docrefno,
                   SUM (NVL (DECODE (drcr_status, 'DR', trnamount), 0)) drtot,
                   SUM (NVL (DECODE (drcr_status, 'CR', trnamount), 0)) crtot,
                   trnamount, proc_desc, corr_acc_no, portfolio_code,
                   acc_type_code, dn_get_acc_no (portfolio_code) cif
              FROM dn_acc_licencee_inst_account
             WHERE trnamount <> 0
               AND acc_type_code <> '800'
               AND trndate >= TO_DATE (M_RUN_DATE, 'DD/MM/YYYY')
               AND trndate < TO_DATE (M_RUN_DATE, 'DD/MM/YYYY') + 1
          GROUP BY trndate,
                   docrefno,
                   entdate,
                   proc_desc,
                   corr_acc_no,
                   portfolio_code,
                   acc_type_code,
                   trnamount
          UNION ALL
          SELECT   TO_CHAR (entdate, 'DD/MON/YY') rr,
                   TO_CHAR (trndate, 'DD/MON/YY') ww, docrefno,
                   SUM (NVL (DECODE (drcr_status, 'DR', trnamount), 0)) drtot,
                   SUM (NVL (DECODE (drcr_status, 'CR', trnamount), 0)) crtot,
                   trnamount, proc_desc, corr_acc_no, portfolio_code,
                   acc_type_code, dn_get_acc_no (portfolio_code) cif
              FROM dn_acc_licencee_gen_account
             WHERE trnamount <> 0
               AND acc_type_code <> '800'
               AND trndate >= TO_DATE (M_RUN_DATE, 'DD/MM/YYYY')
               AND trndate < TO_DATE (M_RUN_DATE, 'DD/MM/YYYY') + 1
          GROUP BY trndate,
                   docrefno,
                   entdate,
                   proc_desc,
                   corr_acc_no,
                   portfolio_code,
                   acc_type_code,
                   trnamount
          UNION ALL
          SELECT   TO_CHAR (entdate, 'DD/MON/YY') rr,
                   TO_CHAR (trndate, 'DD/MON/YY') ww, docrefno,
                   SUM (NVL (DECODE (drcr_status, 'DR', trnamount), 0)) drtot,
                   SUM (NVL (DECODE (drcr_status, 'CR', trnamount), 0)) crtot,
                   trnamount, proc_desc, corr_acc_no, portfolio_code,
                   acc_type_code, dn_get_acc_no (portfolio_code) cif
              FROM dn_acc_licencee_gen_account
             WHERE acc_type_code = '800'
               AND trnamount <> 0
               AND trndate >= TO_DATE (M_RUN_DATE, 'DD/MM/YYYY')
               AND trndate < TO_DATE (M_RUN_DATE, 'DD/MM/YYYY') + 1
          GROUP BY trndate,
                   docrefno,
                   entdate,
                   proc_desc,
                   corr_acc_no,
                   portfolio_code,
                   acc_type_code,
                   trnamount) a
      GROUP BY a.rr,
         a.ww,
         a.proc_desc,
         a.corr_acc_no,
         a.portfolio_code,
         a.acc_type_code
      
);


COMMIT;

END DN_ACC_TRN_TEXT_SAVE;

/
