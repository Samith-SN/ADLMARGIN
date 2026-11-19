--------------------------------------------------------
--  DDL for Procedure DN_INV_CUST_COUPON_PAYMENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_CUST_COUPON_PAYMENT" 
(
 M_PROCESS_DATE    DN_SYS_PARAMETER.LAST_DAILY%TYPE
)

   -- Procedure    : Custodial Deal coupon payment
   -- System       : Dealnet system
   -- Created by   : V.Thilakesa.
   -- Created on   : 31/11/1999

  AS

    CURSOR  SERIAL_NO IS

    SELECT
       C.CUSTODIAL_CODE,
       C.EFF_VALDATE,C.INST_TYPE,
       C.SECURITY_CODE,C.SERIAL_NO,
       C.DEAL_NO,C.FACE_VAL,
       D.COUPON_INT,D.FREQUENCY
    FROM
       DN_INV_CUST_DEAL_SERIAL_NO C,
       DN_REF_SECURITY D
    WHERE
       (C.DIP_WID_EFF_VALDATE IS NULL OR C.DIP_WID_EFF_VALDATE>M_PROCESS_DATE)
       AND
       C.EFF_VALDATE<=M_PROCESS_DATE
       AND
       C.SECURITY_CODE=D.SECURITY_CODE
       AND
       D.SECURITY_CODE
                 IN
                 (SELECT
                     A.SECURITY_CODE
                  FROM
                     DN_REF_SECURITY A,
                     DN_REF_SECURITY_INT_PAY_DATES B
                  WHERE
                     A.COUPON_INT>0
                     AND
                     A.SECURITY_CODE=B.SECURITY_CODE
                     AND
                     B.INT_PAY_DATE=M_PROCESS_DATE
                  );

 M_SECURITY_CODE   DN_REF_SECURITY.SECURITY_CODE%TYPE;
 M_COUPON_INT      DN_REF_SECURITY.COUPON_INT%TYPE;
 M_FREQUENCY       DN_REF_SECURITY.FREQUENCY%TYPE;
 M_CUSTODIAL_CODE  DN_INV_CUST_DEAL_SERIAL_NO.CUSTODIAL_CODE%TYPE;
 M_EFF_VALDATE     DN_INV_CUST_DEAL_SERIAL_NO.EFF_VALDATE%TYPE;
 M_INST_TYPE       DN_INV_CUST_DEAL_SERIAL_NO.INST_TYPE%TYPE;
 M_FACE_VAL        DN_INV_CUST_DEAL_SERIAL_NO.FACE_VAL%TYPE;
 M_DEAL_NO         DN_INV_CUST_DEAL_SERIAL_NO.DEAL_NO%TYPE;
 M_SERIAL_NO       DN_INV_CUST_DEAL_SERIAL_NO.SERIAL_NO%TYPE;

BEGIN

   OPEN SERIAL_NO;

   LOOP

      FETCH  SERIAL_NO INTO

      M_CUSTODIAL_CODE,M_EFF_VALDATE,M_INST_TYPE,
      M_SECURITY_CODE,M_SERIAL_NO,M_DEAL_NO,M_FACE_VAL,
      M_COUPON_INT,M_FREQUENCY;

      EXIT WHEN SERIAL_NO%NOTFOUND;

          -- At serial number level

        UPDATE DN_INV_INT_CUST_DEAL_SERNO
           SET COUP_PAY=(M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY--(modified by Nilu on 13-10-2004 for VCF 04-245 removed ceil)SET COUP_PAY=CEIL((M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY)modified by nirmala on 14-03-2001 by ceiling
        WHERE
           PROCESS_DATE=M_PROCESS_DATE
           AND
           CUSTODIAL_CODE=M_CUSTODIAL_CODE
           AND
           EFF_VALDATE=M_EFF_VALDATE
           AND
           INST_TYPE=M_INST_TYPE
           AND
           SECURITY_CODE=M_SECURITY_CODE
           AND
           SERIAL_NO=M_SERIAL_NO
           AND
           DEAL_NO=M_DEAL_NO;

     IF SQL%NOTFOUND THEN

       INSERT INTO DN_INV_INT_CUST_DEAL_SERNO
          (PROCESS_DATE,CUSTODIAL_CODE,
           EFF_VALDATE,INST_TYPE,
           SECURITY_CODE,
           DEAL_NO,SERIAL_NO,
           SCRIP_FACE_VAL,FACE_VAL,
           COUP_INT_ACCR,
           COUP_PAY,
           SERIAL_NO_STATUS
          )
          SELECT
             M_PROCESS_DATE,CUSTODIAL_CODE,
             EFF_VALDATE,INST_TYPE,
             SECURITY_CODE,
             DEAL_NO,SERIAL_NO,
             SCRIP_FACE_VAL,FACE_VAL,
             (M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY,
             (M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY,--(modified by Nilu on 13-10-2004 for VCF 04-245 removed ceil)CEIL((M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY)modified by nirmala on 14-03-2001 by ceiling
             SERIAL_NO_STATUS
          FROM
             DN_INV_CUST_DEAL_SERIAL_NO
          WHERE
             CUSTODIAL_CODE=M_CUSTODIAL_CODE
             AND
             EFF_VALDATE=M_EFF_VALDATE
             AND
             INST_TYPE=M_INST_TYPE
             AND
             SECURITY_CODE=M_SECURITY_CODE
             AND
             SERIAL_NO=M_SERIAL_NO
             AND
             DEAL_NO=M_DEAL_NO;

   END IF;

END LOOP;

    -------------ADDED BY LATHIKA ON 24/05/2000----------

    DN_ACC_E_2(M_PROCESS_DATE);

    -----------------------------------------------------
END DN_INV_CUST_COUPON_PAYMENT;

/
