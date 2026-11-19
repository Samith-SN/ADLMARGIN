--------------------------------------------------------
--  DDL for Procedure DN_TRANSFER_CONFIRM
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_TRANSFER_CONFIRM" 
(
M_USER                   VARCHAR2
)
AS
M_LICE_CP                DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE;
m_deal      number;
-- DONE BY : MANJULA
-- ON      : 08-02-2007
-- FOR     : FCE - CDS TRANSFER UPLOAD CONFIRMATION

BEGIN
--RAISE_APPLICATION_ERROR(-20201,'INSIDE THE PROCEDURE !!!!!!!');
DN_VALIDATE_SAVE_RIGHTS(M_USER,'WD_Transf_Upload');

     SELECT PORTFOLIO_CODE
     INTO  M_LICE_CP
     FROM  DN_REF_PORTFOLIO
     WHERE PF_TYPE='C' AND OWNED_BY_MBFSL='Y';



FOR J IN (SELECT A.DEAL_NO DEAL_NO
             FROM   DN_TRN_OUTP_SALE A,
                    DN_TRN_TRANSFER_UPLOAD B
             WHERE  APP_STATUS = 'APPRO2'  AND
                    A.DEAL_NO  = B.DEAL_NO AND
                    A.SELL_PORTFOLIO_CODE=M_LICE_CP) LOOP



   MBFSL_DEAL_CONFIRMATION(J.DEAL_NO,M_USER);

   UPDATE DN_TRN_TRANSFER_UPLOAD
   SET PROCESSED_STAT='CONF'
   WHERE DEAL_NO=J.DEAL_NO;

   END LOOP;


  --------------------------CONFIRM SALES -------------

      FOR K IN (SELECT A.DEAL_NO DEAL_NO,
                A.SECURITY_CODE,
                A.FACE_VALUE,
                A.CURR_CODE
                FROM   DN_TRN_OUTP_SALE A,
                       DN_TRN_TRANSFER_UPLOAD B
                WHERE  APP_STATUS = 'APPRO2'  AND
                       A.DEAL_NO  = B.DEAL_NO AND
                       A.BUY_PORTFOLIO_CODE=M_LICE_CP) LOOP

     DN_SAVE_ALLO_SCRIPLESS_CALL(K.DEAL_NO,K.SECURITY_CODE,NULL,NULL,NULL,K.FACE_VALUE,
                                 NULL,M_USER,NULL,K.CURR_CODE,'NEW');


   MBFSL_DEAL_CONFIRMATION(K.DEAL_NO,M_USER);

   UPDATE DN_TRN_TRANSFER_UPLOAD
   SET PROCESSED_STAT='CONF'
   WHERE DEAL_NO=K.DEAL_NO;

   END LOOP;


END;

/
