--------------------------------------------------------
--  DDL for Procedure TRN_OUTRIGHT_DELETE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."TRN_OUTRIGHT_DELETE" 
   (M_DEALNO      DN_TRN_OUTP_SALE.DEAL_NO%TYPE,
    M_USER        DN_TRN_OUTP_SALE.DN_USER%TYPE,
    M_SCREEN      VARCHAR2  --added by ashini on 31/10/2005 for sr0509-047
   )
AS
   M_VAL_DATE_PR         DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE;
   M_FACEVAL_PR       DN_TRN_OUTP_SALE.FACE_VALUE%TYPE;


BEGIN

DN_VALIDATE_SAVE_RIGHTS(M_USER,M_SCREEN);  --added by ashini on 31/10/2005 for sr0509-047


----***************ADDED FOR TIME LOG REQUIREMRNT  BY S.YASODHA****************
   INSERT INTO DN_TIME_LOG
           (SUS_REF_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            (
              M_DEALNO,
              M_USER,
              SYSDATE,
              'DELETION'
           );



    /* PROCEDURE  -  OUTRIGHT DEAL DELETE
       SYSTEM     -  DEALNET
       CREATED BY -  CHARMINDA
       CREATED ON -  23/07/1999
			 MODIFIED BY-  SUKATHIS
       MODIFIED ON - 17/01/2000
   */
--RAISE_APPLICATION_ERROR(-20201,M_DEALNO);

/*DN_LIMIT_TRN_OVRL(M_DEALNO,'U'); -- Modified by Sukathis
DN_LIMIT_TRN_OVRL_EXPO(M_DEALNO,'U'); -- Modified by Sukathis
DN_LIMIT_TRN_OVRL_MATU(M_DEALNO,'U');
DN_LIMIT_TRN_ISSUER_INST_AMT(M_DEALNO,'U');--added by nirmala
DN_LIMIT_TRN_ISSUER_INST_MAT(M_DEALNO,'U');--added by nirmala
DN_LIMIT_TRN_ISS_HOL_PERIOD(M_DEALNO,'U');--added by nirmala
DN_LIMIT_TRN_DEALER_INST_AMT(M_DEALNO,'U');--added by nirmala

*/


/*##################################### added by dayan   #################################################################*/
  /* SELECT EFF_VALDATE,FACE_VALUE INTO M_VAL_DATE_PR,M_FACEVAL_PR
   FROM DN_TRN_OUTP_SALE
   WHERE DEAL_NO=M_DEALNO ;*/
   --DN_LIMIT_TRN_OVRL_MATU(M_DEALNO ,'C');-- this is relevant to OVERALL MATURITY BAND
 IF (SUBSTR(M_DEALNO,1,2)='GO')THEN


   UPDATE DN_TRN_OUTP_SALE
   SET    APP_STATUS='CANCEL'
   WHERE  GROUP_DEALNO=M_DEALNO;


 ELSE
   UPDATE DN_TRN_OUTP_SALE SET
         APP_STATUS='CANCEL'
   WHERE M_DEALNO=DEAL_NO;

END IF;
COMMIT;

END TRN_OUTRIGHT_DELETE;

/
