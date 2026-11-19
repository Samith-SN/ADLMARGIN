--------------------------------------------------------
--  DDL for Procedure DN_INV_CUST_UP_DEAL_SERNO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_CUST_UP_DEAL_SERNO" 
   (
    M_DEAL_NO      DN_TRN_BO_CUSTODIAL_DEAL.DEAL_NO%TYPE
   )

   IS

    -- Procedue     : Update deposit/withdrawel custodial inventory - deal - serial number
    -- System       : Dealnet system
    -- Created by   : V.THILAKESAN.
    -- Created on   : 25/11/1999

   CURSOR CUST_SERIALNO IS
     SELECT
        B.INST_TYPE,
        A.SECURITY_CODE,
        A.SERIAL_NO,
        A.FACE_VALUE
     FROM
        DN_TRN_BO_CUSTODIAL_DEAL_SEC A,
        DN_REF_SECURITY B
     WHERE
        A.DEAL_NO=M_DEAL_NO
        AND
        A.SECURITY_CODE=B.SECURITY_CODE;


  M_CURR_DATE             DN_TRN_BO_CUSTODIAL_DEAL.EFF_VALDATE%TYPE;
  M_EFF_VALDATE           DN_TRN_BO_CUSTODIAL_DEAL.EFF_VALDATE%TYPE;
  M_INST_TYPE             DN_TRN_BO_CUSTODIAL_DEAL.INST_TYPE%TYPE;
  M_SECURITY_CODE         DN_TRN_BO_CUSTODIAL_DEAL_SEC.SECURITY_CODE%TYPE;
  M_SERIAL_NO             DN_TRN_BO_CUSTODIAL_DEAL_SEC.SERIAL_NO%TYPE;
  M_SCRP_FACE_VALUE       DN_TRN_BO_CUSTODIAL_DEAL_SEC.FACE_VALUE%TYPE;
  M_CUSTODIAL_CODE        DN_TRN_BO_CUSTODIAL_DEAL.CUSTODIAL_CODE%TYPE;
  M_DEAL_TYPE             DN_TRN_BO_CUSTODIAL_DEAL.DEAL_TYPE%TYPE;
  M_STATUS                DN_INV_CUST_DEAL_SERIAL_NO.SERIAL_NO_STATUS%TYPE;

BEGIN

   SELECT
      TO_DATE(TO_CHAR(SYSDATE,'DD-MON-YYYY'),'DD-MON-YYYY'),
      EFF_VALDATE,
      CUSTODIAL_CODE,
      DEAL_TYPE
      INTO M_CURR_DATE,M_EFF_VALDATE,M_CUSTODIAL_CODE,M_DEAL_TYPE
   FROM
      DN_TRN_BO_CUSTODIAL_DEAL
   WHERE
      DEAL_NO=M_DEAL_NO;


   IF M_DEAL_TYPE='D' THEN
      M_STATUS:='DEP';
   ELSIF M_DEAL_TYPE='W' THEN
      M_STATUS:='WID';
   END IF;

  OPEN CUST_SERIALNO;

  LOOP

     FETCH  CUST_SERIALNO INTO

            M_INST_TYPE,M_SECURITY_CODE,M_SERIAL_NO,M_SCRP_FACE_VALUE;

     EXIT WHEN CUST_SERIALNO%NOTFOUND;

       -- IF M_EFF_VALDATE<=M_CURR_DATE  THEN
           -- Deposit Information
           IF M_DEAL_TYPE='D' THEN
              INSERT INTO DN_INV_CUST_DEAL_SERIAL_NO
                  (CUSTODIAL_CODE,
                   EFF_VALDATE,
                   INST_TYPE,
                   SECURITY_CODE,
                   DEAL_NO,
                   SERIAL_NO,
                   SCRIP_FACE_VAL,
                   FACE_VAL,
                   SERIAL_NO_STATUS
                  )
               VALUES(
                  M_CUSTODIAL_CODE,
                  M_EFF_VALDATE,
                  M_INST_TYPE,
                  M_SECURITY_CODE,
                  M_DEAL_NO,
                  M_SERIAL_NO,
                  M_SCRP_FACE_VALUE,
                  M_SCRP_FACE_VALUE,
                  M_STATUS
               );
               -- Withdrawel Information
           ELSIF M_DEAL_TYPE='W' THEN
               UPDATE DN_INV_CUST_DEAL_SERIAL_NO
               SET DIP_WID_DEAL_NO    =M_DEAL_NO,
                   SERIAL_NO_STATUS   =M_STATUS,
                   DIP_WID_EFF_VALDATE=M_EFF_VALDATE
               WHERE
                   CUSTODIAL_CODE=M_CUSTODIAL_CODE
                   AND
                   INST_TYPE=M_INST_TYPE
                   AND
                   SECURITY_CODE=M_SECURITY_CODE
                   AND
                   SERIAL_NO=M_SERIAL_NO
                   AND
                   FACE_VAL=M_SCRP_FACE_VALUE
                   AND
                   DIP_WID_DEAL_NO IS NULL
                   AND
                   SERIAL_NO_STATUS='DEP'
                   AND
                   DIP_WID_EFF_VALDATE IS NULL;

              IF SQL%NOTFOUND THEN
                 --ROLLBACK;
                RAISE_APPLICATION_ERROR(-20201,'Data error for '||'DEAL_NO '||M_DEAL_NO||' CUSTODIAL CODE '||M_CUSTODIAL_CODE||' INST_TYPE '||M_INST_TYPE||' SECURITY_CODE '||M_SECURITY_CODE||' SERIAL_NO '||M_SERIAL_NO||' FACE VALUE '||M_SCRP_FACE_VALUE);
              END IF;
           END IF;
     --   END IF;

     END LOOP;

     COMMIT;

END DN_INV_CUST_UP_DEAL_SERNO;

/
