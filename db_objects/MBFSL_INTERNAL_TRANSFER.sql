--------------------------------------------------------
--  DDL for Procedure MBFSL_INTERNAL_TRANSFER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_INTERNAL_TRANSFER" 

   (M_INT_TRANS_NO    IN OUT  DN_TRN_BO_SETTL_INT_TRANSFER.INT_TRANS_NO%TYPE,
    M_INF_BCODE               DN_TRN_BO_SETTL_INT_TRANSFER.INF_BRANCH_CODE%TYPE,
    M_INF_ACCNO               DN_TRN_BO_SETTL_INT_TRANSFER.INF_ACC_NO%TYPE,
    M_OUTF_BCODE              DN_TRN_BO_SETTL_INT_TRANSFER.OUTF_BRANCH_CODE%TYPE,
    M_OUTF_ACCNO              DN_TRN_BO_SETTL_INT_TRANSFER.OUTF_ACC_NO%TYPE,
    M_TRANS_AMT               DN_TRN_BO_SETTL_INT_TRANSFER.TRANS_AMOUNT%TYPE,
    M_TRANS_METHOD            DN_TRN_BO_SETTL_INT_TRANSFER.TRANS_METHOD%TYPE,
    M_TRANS_COMMENT           DN_TRN_BO_SETTL_INT_TRANSFER.TRANS_COMMENT%TYPE,
    M_USER                    DN_TRN_BO_SETTL_INT_TRANSFER.DN_USER%TYPE,
    M_DUMMY_NO                DN_TRN_BO_SETTL_INT_TRANSFER.INT_TRANS_NO%TYPE,
    M_PORTFOLIO_CODE          DN_TRN_BO_SETTL_INT_TRANSFER.PORTFOLIO_CODE%TYPE,
    M_EFF_DATE                VARCHAR2
   )

AS
BEGIN


DN_VALIDATE_SAVE_RIGHTS(M_USER,'WD_Internal_Transfers');  --added by ashini on 31/10/2005 for sr0509-047

--RAISE_APPLICATION_ERROR(-20201,M_INT_TRANS_NO||'****'|| M_INF_BCODE ||'****'||M_INF_ACCNO||'****'||M_OUTF_BCODE||'****'|| M_OUTF_ACCNO||'****'||M_TRANS_AMT||'****'||M_TRANS_METHOD||'****'||M_TRANS_COMMENT||'****'||M_USER||'****'||M_DUMMY_NO||'****'||M_PORTFOLIO_CODE||'****');
  --                                               ****7010-020           ****222              ****7010-001       ****222333              ****100             ****CHEQUE              ****TESTING                 ****DNALL   ****                ****AAA**** ORA-06512:
    /* PROCEDURE  -  SETTLEMENT INTERNAL TRANFER
       SYSTEM     -  DEALNT
       CREATED BY -  DAYAN.
       CREATED ON -  13/09/1999 */

    IF M_DUMMY_NO IS NULL THEN
       SELECT TO_CHAR(SYSDATE,'YY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_SET_INT_TRN_TRNSLET.NEXTVAL),3,'0') INTO M_INT_TRANS_NO FROM DUAL;
       M_INT_TRANS_NO:='SIMT'||M_INT_TRANS_NO;
    ELSE
       M_INT_TRANS_NO:=M_DUMMY_NO;
    END IF;

   INSERT INTO DN_TRN_BO_SETTL_INT_TRANSFER
              (INT_TRANS_NO,
               INF_BRANCH_CODE,
               INF_ACC_NO,
               OUTF_BRANCH_CODE,
               OUTF_ACC_NO,
               TRANS_AMOUNT,
               TRANS_METHOD,
               TRANS_COMMENT,
               DN_USER,
               ENT_DATE,
               PORTFOLIO_CODE,
               EFF_VAL_DATE)
   VALUES
        (M_INT_TRANS_NO,
         M_INF_BCODE,
         M_INF_ACCNO ,
         M_OUTF_BCODE,
         M_OUTF_ACCNO,
         M_TRANS_AMT,
         M_TRANS_METHOD,
         M_TRANS_COMMENT,
         M_USER,
         SYSDATE,
         M_PORTFOLIO_CODE,
         TO_DATE(M_EFF_DATE,'DD/MM/YYYY') );

    DN_ACC_G_1(M_INT_TRANS_NO,M_EFF_DATE);


             INSERT INTO DN_TIME_LOG_SETTLE
          (DOC_REF_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            ( M_INT_TRANS_NO,
              M_USER,
              SYSDATE,
              'SETTLEMENT INT TRANSFER ');

   COMMIT;

    END MBFSL_INTERNAL_TRANSFER;

/
