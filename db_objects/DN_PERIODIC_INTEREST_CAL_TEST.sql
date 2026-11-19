--------------------------------------------------------
--  DDL for Procedure DN_PERIODIC_INTEREST_CAL_TEST
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_PERIODIC_INTEREST_CAL_TEST" 
   (
    M_EFF_VALDATE       DN_TRN_REPO_PERIOD_INT_DATES.PAY_DATE%TYPE
   )

   IS

    -- Procedue     : Periodic Interest payment dates test
    -- System       : Dealnet system
    -- Created by   : V.Thilakesan.
    -- Created on   : 13/03/2000

   M_INT_DATE      DN_REF_SECURITY.MATURITY_DATE%TYPE;
   M_INT_CAL_DAYS NUMBER;
   M_INT_BASE_DAYS NUMBER;
   M_COUNT         NUMBER;
   M_LEG2_VALUE    NUMBER;
   M_INTERST       NUMBER;
   M_SEQNO         VARCHAR2(10);

BEGIN
    --Generating a sequence no
  SELECT 'PI'||'-'||LPAD(TO_CHAR(DN_SEQ_PERIODIC_SERNO.NEXTVAL),7,'0') INTO M_SEQNO FROM DUAL;

  M_INT_DATE:=M_EFF_VALDATE;
  M_COUNT:=1;

  WHILE M_INT_DATE<ADD_MONTHS(M_EFF_VALDATE,12) LOOP


       INSERT INTO DN_TRN_REPO_PERIOD_INT_DATES
       (SEQNO,PAY_DATE)
       VALUES(M_SEQNO,ADD_MONTHS(M_EFF_VALDATE,M_COUNT));

       SELECT ADD_MONTHS(M_EFF_VALDATE,M_COUNT) INTO M_INT_DATE FROM DUAL;

       M_COUNT:=M_COUNT+1;

       COMMIT;

 END LOOP;

END DN_PERIODIC_INTEREST_CAL_TEST;

/
