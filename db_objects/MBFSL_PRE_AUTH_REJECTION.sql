--------------------------------------------------------
--  DDL for Procedure MBFSL_PRE_AUTH_REJECTION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_PRE_AUTH_REJECTION" (
   m_dealno   DN_TRN_OUTP_PRE_AUTHO.deal_no%TYPE,
   m_user     DN_TRN_OUTP_PRE_AUTHO.dn_user%TYPE
)
AS
   m_type               VARCHAR2 (4);
   m_count              NUMBER;
   m_script_status      CHAR (2);
   m_inst_cat           dn_ref_instrument.inst_cat%TYPE;
   m_curr_code          dn_trn_repo_fresh.curr_code%TYPE;          --CURRENCY
   nn_script_status     DN_TRN_OUTP_PRE_AUTHO.script_status%TYPE;         --$$##SC
   nn_pf_type           dn_ref_portfolio.pf_type%TYPE;               --$$##SC
   nn_yield_type        dn_ref_instrument.yield_type%TYPE;           --$$##SC
   m_clean              NUMBER;
   m_dirty              NUMBER;
   m_nominal            NUMBER;
   m_type1              VARCHAR2 (10);
   m_custodial_status   VARCHAR2 (1);

   m_effval_date        DATE;

--ADDED BY SVA ON 04-04-2005 FOR WEIGHTED AVERAGE
   m_last_daily         DATE;
   m_eff_valdate        DN_TRN_OUTP_PRE_AUTHO.eff_valdate%TYPE;
   nn_portfolio_code    DN_TRN_OUTP_PRE_AUTHO.buy_portfolio_code%TYPE;
   nn_security_code     DN_TRN_OUTP_PRE_AUTHO.security_code%TYPE;

   m_maturity_date      DATE;
   mm_maturity_date     DATE;
   m_last_daily1        DATE;

BEGIN
   /* PROCEDURE  -  DEAL CONFIRMATION
      SYSTEM     -  DEALNET
      CREATED BY -  Susitha
      CREATED ON -  23/05/2011
       */
  IF SUBSTR (m_dealno, 1, 2) = 'PA'
   THEN
      


      SELECT COUNT (*)
        INTO m_count
        FROM DN_TRN_OUTP_PRE_AUTHO
       WHERE deal_no = m_dealno AND app_status = 'CANCEL';

      IF (m_count = 0)
      THEN
       
         
        
         UPDATE DN_TRN_OUTP_PRE_AUTHO
            SET app_status = 'CANCEL'
          WHERE m_dealno = deal_no;

          INSERT INTO DN_DOC_STATUS_LOG( DOC_REF_NO,DOC_TYPE,DOC_STATUS,DN_USER,ENT_DATE,DESCRIPTION)
           VALUES(m_dealno,'DEALS BULK REJECT','CANCEL',M_USER,SYSDATE,'DEALS BULK REJECT');
                                                      
              

     
      ELSE
         raise_application_error (-20201, 'ALREADY REJECTED');
      END IF;
  
      END IF;
  
  
 
END ; 

/
