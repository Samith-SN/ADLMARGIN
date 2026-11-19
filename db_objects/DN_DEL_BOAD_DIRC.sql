--------------------------------------------------------
--  DDL for Procedure DN_DEL_BOAD_DIRC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_DEL_BOAD_DIRC" 
   ( m_pf_code IN DN_REF_PORTF_DIRECTOR.portfolio_code%type
    )
   IS

BEGIN
  DELETE DN_REF_PORTF_DIRECTOR WHERE PORTFOLIO_CODE=m_pf_code;
END; -- Procedure

/
