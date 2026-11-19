--------------------------------------------------------
--  DDL for Procedure DN_RP_INST_INSERT_PAYFREQ
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_RP_INST_INSERT_PAYFREQ" 
   (M_DEAL_NO                      DN_TRN_REPO_PERIOD_INT.DEAL_NO%TYPE,
    M_START_DATE                   VARCHAR2,
    M_END_DATE                     VARCHAR2,
    M_PAY_FREQ                     VARCHAR2)
AS


M_SDATE                     DATE;
M_PAYDATE                   DATE;
M_EDATE                     DATE;
M_NUM                       NUMBER;
M_NUM2                      NUMBER;
M_A                         NUMBER;
-------------------------------------------------------------------------------------
    --   PROCEDURE  - DATA TAKE-ON   'DELETE THIS'
    --   SYSTEM     - Dealnet
    --   CREATED BY - Lathika.
    --   CREATED ON -
-------------------------------------------------------------------------------------

BEGIN
M_PAYDATE := NULL;

     M_SDATE:= TO_DATE(M_START_DATE,'DD/MM/YYYY');
     M_EDATE:= TO_DATE(M_END_DATE,'DD/MM/YYYY');

        INSERT INTO DN_REF_RP_INST_PAY_FREQ
               (DEAL_NO,FREQ_NO,EFF_DATE,STATUS)
        SELECT DEAL_NO,'1',M_EDATE,'N'
        FROM   DN_TRN_REPO_PERIOD_INT
        WHERE  INT_PAY_FREQ  = M_PAY_FREQ
        AND    DEAL_NO       = M_DEAL_NO;

  IF  M_PAY_FREQ <>'1' THEN
     M_NUM:=TO_NUMBER(M_PAY_FREQ);
     M_NUM2:=12/M_NUM;
     M_A:=1;

      SELECT ADD_MONTHS(M_SDATE,M_NUM2)
      INTO  M_PAYDATE
      FROM DUAL;
    WHILE (M_PAYDATE < M_EDATE) LOOP

      M_A:=M_A+1;



      INSERT INTO DN_REF_RP_INST_PAY_FREQ
        (DEAL_NO,FREQ_NO,EFF_DATE,STATUS)
      VALUES
        (M_DEAL_NO,TO_CHAR(M_A),M_PAYDATE,'N' );


      SELECT ADD_MONTHS(M_SDATE,(M_NUM2 * M_A))
      INTO  M_PAYDATE
      FROM DUAL;
   END LOOP;

 END IF;

--COMMIT;

END DN_RP_INST_INSERT_PAYFREQ;

/
