--------------------------------------------------------
--  DDL for Procedure SECURITY_OPT_MODI
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."SECURITY_OPT_MODI" 

   (
    m_ISCODE    DN_REF_SECURITY.security_code%TYPE,
    m_ESCODE    DN_REF_SECURITY.ext_security_code%TYPE,
	m_ICODE     DN_REF_SECURITY.issuer_code%TYPE,
	m_GCODE     DN_REF_SECURITY.guarantee_code%TYPE,
	m_ITYPE     DN_REF_SECURITY.inst_type%TYPE,
	m_CSYM      DN_REF_SECURITY.curr_code%TYPE,
	m_iss_day   VARCHAR2,
    m_mat_day   VARCHAR2,
	m_COUINT    DN_REF_SECURITY.coupon_int%TYPE,
	m_CPPA      DN_REF_SECURITY.frequency%TYPE,
	m_pay_day   VARCHAR2,
	m_TXT_CRSE  DN_REF_SECURITY.credit_rating%TYPE,
	m_AMOISS    DN_REF_SECURITY.amount_issue%TYPE,
	m_WAYISS    DN_REF_SECURITY.wavg_y_issue%TYPE,
	m_IFP1      DN_REF_SECURITY.prospectus_l1%TYPE,
	m_IFP2      DN_REF_SECURITY.prospectus_l2%TYPE,
	m_ONOTE1    DN_REF_SECURITY.other_notes_l1%TYPE,
	m_ONOTE2    DN_REF_SECURITY.other_notes_l2%TYPE,
    M_INST_CAT  DN_REF_INSTRUMENT.INST_CAT%TYPE
   )


AS
m_paydate       DN_REF_SECURITY.first_int_pay_date%TYPE;
m_GCODE_RE      DN_REF_SECURITY.guarantee_code%TYPE;
m_TXT_CRSE_RE   DN_REF_SECURITY.credit_rating%TYPE;
m_IFP1_RE       DN_REF_SECURITY.prospectus_l1%TYPE;
m_IFP2_RE       DN_REF_SECURITY.prospectus_l2%TYPE;
m_ONOTE1_RE     DN_REF_SECURITY.other_notes_l1%TYPE;
m_ONOTE2_RE     DN_REF_SECURITY.other_notes_l2%TYPE;
M_COUINT2       DN_REF_SECURITY.COUPON_INT%TYPE;
BEGIN

     IF m_pay_day='01/01/1900' THEN
        m_paydate:=NULL;
     ELSE
        SELECT
            TO_DATE(m_pay_day,'DD/MM/YYYY') INTO m_paydate
        FROM DUAL;
     END IF;

     IF m_GCODE='N/A' THEN
        m_GCODE_RE:=NULL;
     ELSE
        m_GCODE_RE:=m_GCODE;
     END IF;

      IF m_TXT_CRSE='N/A' THEN
        m_TXT_CRSE_RE:=NULL;
     ELSE
        m_TXT_CRSE_RE:=m_TXT_CRSE;
     END IF;

      IF m_IFP1='N/A' THEN
        m_IFP1_RE:=NULL;
     ELSE
        m_IFP1_RE:=m_IFP1;
     END IF;

      IF m_IFP2='N/A' THEN
        m_IFP2_RE:=NULL;
     ELSE
        m_IFP2_RE:=m_IFP2;
     END IF;

      IF m_ONOTE1='N/A' THEN
        m_ONOTE1_RE:=NULL;
     ELSE
        m_ONOTE1_RE:=m_ONOTE1;
     END IF;

      IF m_ONOTE2='N/A' THEN
        m_ONOTE2_RE:=NULL;
     ELSE
        m_ONOTE2_RE:=m_ONOTE2;
     END IF;

SELECT M_COUINT/100 INTO M_COUINT2 FROM DUAL;

    /* PROCEDURE  - TO MODIFY AN EXISTING SECURITY
       SYSTEM     - DEALNET
       CREATED BY - SUKATHIS
       CREATED ON -  29/JULY/1999*/

-- RAISE_APPLICATION_ERROR(-20201,m_ISCODE||' '||m_ESCODE||' '||m_ICODE||' '||m_GCODE||' '||m_ITYPE||' '||m_CSYM||' '||m_iss_day||' '||m_mat_day||' '||m_COUINT||' '||m_CPPA||' '||m_pay_day||''||m_TXT_CRSE||' '||m_AMOISS||' '||m_WAYISS||' '||m_IFP1||' '||m_IFP2||''||m_ONOTE1||' '||m_ONOTE2);
UPDATE DN_REF_SECURITY
       SET  ext_security_code=m_ESCODE,issuer_code=m_ICODE,guarantee_code=m_GCODE_RE,
            inst_type=m_ITYPE,curr_code=m_CSYM,issue_date=TO_DATE(m_iss_day,'DD/MM/YYYY'),
            maturity_date=TO_DATE(m_mat_day,'DD/MM/YYYY'),coupon_int=m_COUINT2,
            frequency=m_CPPA,first_int_pay_date=m_paydate,
            credit_rating=m_TXT_CRSE_RE,amount_issue=m_AMOISS,wavg_y_issue=m_WAYISS,
            prospectus_l1=m_IFP1_RE,prospectus_l2=m_IFP2_RE,other_notes_l1=m_ONOTE1_RE,
            other_notes_l2=m_ONOTE2_RE
           WHERE security_code=m_ISCODE;

IF UPPER(M_INST_CAT)='DEBT'  THEN
DN_SECURITY_INT_PAY_DATES(m_ISCODE,m_CPPA);
END IF;

COMMIT;

END SECURITY_OPT_MODI;

/
