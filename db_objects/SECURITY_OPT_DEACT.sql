--------------------------------------------------------
--  DDL for Procedure SECURITY_OPT_DEACT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."SECURITY_OPT_DEACT" 

   (
    m_ISCODE    DN_REF_SECURITY.security_code%TYPE,
    M_USRE       VARCHAR

   )

AS

BEGIN


DN_VALIDATE_SAVE_RIGHTS(M_USRE,'WD_Securities_MT');  --added by ashini on 31/10/2005 for sr0509-047

    /* PROCEDURE  - TO REACTIVATE A SECURITY
       SYSTEM     - DEALNET
       CREATED BY - SUKATHIS
       CREATED ON -  29/JULY/1999*/

--RAISE_APPLICATION_ERROR(-20201,m_ISCODE||' '||m_ESCODE||' '||m_ICODE||' '||m_GCODE||' '||m_ITYPE||' '||m_CSYM||' '||m_iss_day||' '||m_mat_day||' '||m_COUINT||' '||m_CPPA||' '||m_pay_day||''||m_TXT_CRSE||' '||m_AMOISS||' '||m_WAYISS||' '||m_IFP1||' '||m_IFP2||''||m_ONOTE1||' '||m_ONOTE2);
UPDATE DN_REF_SECURITY
        SET active_status='N' WHERE security_code=m_ISCODE;

COMMIT;

END SECURITY_OPT_DEACT;

/
