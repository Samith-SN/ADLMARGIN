--------------------------------------------------------
--  DDL for Procedure DN_PORT_REJ_TEMP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_PORT_REJ_TEMP" 
(
M_PORTFOLIO_CODE            DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE


)

IS

-- PROCEDUE     : SECURITIES 
-- SYSTEM       : DEALNET SYSTEM
-- CREATED BY   : Susitha Janaka
-- CREATED ON   : 2011-06-01



BEGIN

            DELETE DN_REF_PORTFOLIO_RJTMP
            WHERE PORTFOLIO_CODE = M_PORTFOLIO_CODE;

INSERT INTO DN_REF_PORTFOLIO_RJTMP
                  (PORTFOLIO_CODE, PF_TYPE, PF_NAME, ADD_IDENTIFICATION,
                   ADD_LOCATION, ADD_STREET, ADD_CITY, ADD_COUNTRY,
                   POSTAL_CODE, DATE_INC_BIRTH, BUSI_REG_NIC,
                   CATEGORY_ENTITY, NATURE_OCCUPATION, SECT_CODE,
                   MBFSL_SECT_CODE, CREATED_DATE, LAST_MODIFIED, NEST_REVIEW,
                   TOT_EXP_LIMIT, PERC_TOT_EXP, APPLY_STATUS,
                   CP_PORTFOLIO_CODE, OWNED_BY_MBFSL, ACTIVE_STATUS,
                   EXP_LIMIT_APPLY_METHOD, BRANCH, RATE, RATE_TYPE, LIMIT,
                   USER_TYPE, MARGIN_CALL_STATUS, TEMP_MARGIN_CALL_STATUS,
                   MANAGEMENT_FEE, PROFIT_SHARING, BASE_RATE, PA_STATUS,
                   CDS_ACC_NO, SWIFT_STATUS, ACC_NO, SWIFT_CLIENT, BIC_CODE,
                   PLEDG_ACC_NO, CON_MARGIN_TYPE)
         SELECT A.PORTFOLIO_CODE, A.PF_TYPE, A.PF_NAME, A.ADD_IDENTIFICATION,
                A.ADD_LOCATION, A.ADD_STREET, A.ADD_CITY, A.ADD_COUNTRY,
                A.POSTAL_CODE, A.DATE_INC_BIRTH, A.BUSI_REG_NIC,
                A.CATEGORY_ENTITY, A.NATURE_OCCUPATION, A.SECT_CODE,
                A.MBFSL_SECT_CODE, A.CREATED_DATE, A.LAST_MODIFIED,
                A.NEST_REVIEW, A.TOT_EXP_LIMIT, A.PERC_TOT_EXP,
                A.APPLY_STATUS, A.CP_PORTFOLIO_CODE, A.OWNED_BY_MBFSL,
                A.ACTIVE_STATUS, A.EXP_LIMIT_APPLY_METHOD, A.BRANCH, A.RATE,
                A.RATE_TYPE, A.LIMIT, A.USER_TYPE, A.MARGIN_CALL_STATUS,
                A.TEMP_MARGIN_CALL_STATUS, A.MANAGEMENT_FEE,
                A.PROFIT_SHARING, A.BASE_RATE, A.PA_STATUS, A.CDS_ACC_NO,
                A.SWIFT_STATUS, A.ACC_NO, A.SWIFT_CLIENT, A.BIC_CODE,
                A.PLEDG_ACC_NO, A.CON_MARGIN_TYPE
           FROM DN_REF_PORTFOLIO A
          WHERE UPPER (PORTFOLIO_CODE) = UPPER (M_PORTFOLIO_CODE);


----------------------------------------------------------------------------
         DELETE FROM DN_REF_PORTF_DIRECTOR_RJTMP
               WHERE PORTFOLIO_CODE = M_PORTFOLIO_CODE;

         INSERT INTO DN_REF_PORTF_DIRECTOR_RJTMP
                     (PORTFOLIO_CODE, DIRECTOR_NAME)
            SELECT A.PORTFOLIO_CODE, A.DIRECTOR_NAME
              FROM DN_REF_PORTF_DIRECTOR A
             WHERE PORTFOLIO_CODE = M_PORTFOLIO_CODE;

----------------------------------------------------------------------------
         DELETE FROM DN_REF_PORTF_AUTHO_SIGN_RJTMP
               WHERE PORTFOLIO_CODE = M_PORTFOLIO_CODE;

         INSERT INTO DN_REF_PORTF_AUTHO_SIGN_RJTMP
                     (PORTFOLIO_CODE, AUTHO_NAME, SEQ_NO)
            SELECT A.PORTFOLIO_CODE, A.AUTHO_NAME, A.SEQ_NO
              FROM DN_REF_PORTF_AUTHO_SIGN A
             WHERE PORTFOLIO_CODE = M_PORTFOLIO_CODE;


---------------------------------------------------------------------------
         DELETE FROM DN_REF_PORTF_CONT_TELNO_RJTMP
               WHERE PORTFOLIO_CODE = M_PORTFOLIO_CODE;

         INSERT INTO DN_REF_PORTF_CONT_TELNO_RJTMP
                     (PORTFOLIO_CODE, TEL_NO, SEQ_NO)
            SELECT A.PORTFOLIO_CODE, A.TEL_NO, A.SEQ_NO
              FROM DN_REF_PORTF_CONT_TELNO A
             WHERE PORTFOLIO_CODE = M_PORTFOLIO_CODE;


---------------------------------------------------------------------------
         DELETE FROM DN_REF_PORTF_CONT_FAXNO_RJTMP
               WHERE PORTFOLIO_CODE = M_PORTFOLIO_CODE;

         INSERT INTO DN_REF_PORTF_CONT_FAXNO_RJTMP
                     (PORTFOLIO_CODE, FAX_NO, SEQ_NO)
            SELECT A.PORTFOLIO_CODE, A.FAX_NO, A.SEQ_NO
              FROM DN_REF_PORTF_CONT_FAXNO A
             WHERE PORTFOLIO_CODE = M_PORTFOLIO_CODE;
             
---------------------------------------------------------------------------
         DELETE FROM DN_REF_PORTF_CONT_EMAIL_RJTMP
               WHERE PORTFOLIO_CODE = M_PORTFOLIO_CODE;

         INSERT INTO DN_REF_PORTF_CONT_EMAIL_RJTMP
                     (PORTFOLIO_CODE, EMAIL, SEQ_NO)
            SELECT A.PORTFOLIO_CODE, A.EMAIL, A.SEQ_NO
              FROM DN_REF_PORTF_CONT_EMAIL A
             WHERE PORTFOLIO_CODE = M_PORTFOLIO_CODE;
             
---------------------------------------------------------------------------
         DELETE FROM DN_REF_PORTF_SETTLEMENT_RJTMP
               WHERE PORTFOLIO_CODE = M_PORTFOLIO_CODE;

         INSERT INTO DN_REF_PORTF_SETTLEMENT_RJTMP
                     (PORTFOLIO_CODE, BRANCH_CODE, ACC_NO, ACTIVE_STATUS,SETT_MODE)
            SELECT A.PORTFOLIO_CODE, A.BRANCH_CODE, A.ACC_NO,
                   A.ACTIVE_STATUS,SETT_MODE
              FROM DN_REF_PORTF_SETTLEMENT A
             WHERE PORTFOLIO_CODE = M_PORTFOLIO_CODE;             
             
---------------------------------------------------------------------------
        DELETE FROM DN_REF_PORT_ADV_RJTMP
               WHERE PORT_CODE = M_PORTFOLIO_CODE;

         INSERT INTO DN_REF_PORT_ADV_RJTMP
                     (PORT_CODE, ADV_CODE, BROKER_CODE)
            SELECT A.PORT_CODE, A.ADV_CODE, A.BROKER_CODE
              FROM DN_REF_PORT_ADV A
             WHERE PORT_CODE = M_PORTFOLIO_CODE; 
      
---------------------------------------------------------------------------

        DELETE FROM DN_REF_PORTFOLIO_INST_RATRTMP
               WHERE PORTFOLIO_CODE = M_PORTFOLIO_CODE;

         INSERT INTO DN_REF_PORTFOLIO_INST_RATRTMP
                     (PORTFOLIO_CODE, INSTRUMENT_CODE, INSTRUMENT_RATE)
            SELECT A.PORTFOLIO_CODE, A.INSTRUMENT_CODE, A.INSTRUMENT_RATE
              FROM DN_REF_PORTFOLIO_INST_RATES A
             WHERE PORTFOLIO_CODE = M_PORTFOLIO_CODE; 

------------------------Added 30-06-2011------------------------------------
         DELETE FROM DN_REF_PORTF_CONT_EMLC_RJTMP
               WHERE PORTFOLIO_CODE = M_PORTFOLIO_CODE;

            INSERT INTO DN_REF_PORTF_CONT_EMLC_RJTMP
                   (PORTFOLIO_CODE,EMAIL,SEQ_NO)
            SELECT A.PORTFOLIO_CODE, A.EMAIL, A.SEQ_NO
              FROM DN_REF_PORTF_CONT_EMAILCC A
             WHERE PORTFOLIO_CODE = M_PORTFOLIO_CODE;             
             
---------------------------------------------------------------------------------
      

COMMIT;



END DN_PORT_REJ_TEMP;

/
