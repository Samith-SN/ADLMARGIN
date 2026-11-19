--------------------------------------------------------
--  DDL for Procedure DN_INV_OUTPS_COUPON_PAYMENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_OUTPS_COUPON_PAYMENT" 
(
 M_PROCESS_DATE    DN_SYS_PARAMETER.LAST_DAILY%TYPE
)

   -- Procedure    : Outright coupon payment
   -- System       : Dealnet system
   -- Created by   : ITU - D.P. Pubudu Thushara
   -- Created on   : 10/08/1999

  AS

    CURSOR  SECURITY IS

    SELECT
       C.PORTFOLIO_CODE,
       C.EFF_VALDATE, C.INST_TYPE,
       C.SECURITY_CODE,C.TRN_TYPE,
       C.DEAL_NO,C.FACE_VAL,
       D.COUPON_INT,D.FREQUENCY
    FROM
       DN_INV_OUTPS_DEAL_SEC C,
       DN_REF_SECURITY D
    WHERE
       C.TRN_TYPE='B'
       AND
       C.EFF_VALDATE<M_PROCESS_DATE
       AND
       C.FACE_VAL>0
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

    CURSOR  SERIAL_NO IS

    SELECT
       C.PORTFOLIO_CODE,
       C.EFF_VALDATE, C.INST_TYPE,
       C.SECURITY_CODE,C.SERIAL_NO,
       C.DEAL_NO,C.FACE_VAL,
       D.COUPON_INT,D.FREQUENCY
    FROM
       DN_INV_OUTPS_DEAL_SERIAL_NO C,
       DN_REF_SECURITY D
    WHERE
       (C.SALE_EFF_VALDATE IS NULL OR C.SALE_EFF_VALDATE>=M_PROCESS_DATE)
       AND
       C.EFF_VALDATE<M_PROCESS_DATE
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
 M_PORTFOLIO_CODE  DN_INV_OUTPS_DEAL_SEC.PORTFOLIO_CODE%TYPE;
 M_EFF_VALDATE     DN_INV_OUTPS_DEAL_SEC.EFF_VALDATE%TYPE;
 M_INST_TYPE       DN_INV_OUTPS_DEAL_SEC.INST_TYPE%TYPE;
 M_FACE_VAL        DN_INV_OUTPS_DEAL_SEC.FACE_VAL%TYPE;
 M_TRN_TYPE        DN_INV_OUTPS_DEAL_SEC.TRN_TYPE%TYPE;
 M_DEAL_NO         DN_INV_OUTPS_DEAL_SEC.DEAL_NO%TYPE;
 M_SERIAL_NO       DN_INV_OUTPS_DEAL_SERIAL_NO.SERIAL_NO%TYPE;

BEGIN


   OPEN SECURITY;

   LOOP

      FETCH  SECURITY INTO

      M_PORTFOLIO_CODE,M_EFF_VALDATE,M_INST_TYPE,
      M_SECURITY_CODE,M_TRN_TYPE,M_DEAL_NO,M_FACE_VAL,
      M_COUPON_INT,M_FREQUENCY;

      EXIT WHEN SECURITY%NOTFOUND;

        --At security level

        UPDATE DN_INV_INT_OUTPS_DEAL_SEC
           SET COUP_PAY=(M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY,--(modified by Nilu on 13-10-2004 removed ceil VCF 04-245)SET COUP_PAY=CEIL((M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY)--modified by nirmala on 14-03-2001 by ceiling
               COUP_INT= (((M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY)-((M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY))--(modified by Nilu on 13-10-2004 removed ceil VCF 04-245)COUP_INT= ((CEIL((M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY))-((M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY))--added by nirmala on 14-03-2001
        WHERE
           PROCESS_DATE=M_PROCESS_DATE
           AND
           PORTFOLIO_CODE=M_PORTFOLIO_CODE
           AND
           EFF_VALDATE=M_EFF_VALDATE
           AND
           INST_TYPE=M_INST_TYPE
           AND
           SECURITY_CODE=M_SECURITY_CODE
           AND
           TRN_TYPE=M_TRN_TYPE
           AND
           DEAL_NO=M_DEAL_NO;

      IF SQL%NOTFOUND THEN

        INSERT INTO DN_INV_INT_OUTPS_DEAL_SEC
          (PROCESS_DATE, PORTFOLIO_CODE,
           EFF_VALDATE, INST_TYPE,
           SECURITY_CODE, TRN_TYPE,
           DEAL_NO, DEAL_YIELD,
           YIELD_WITH_BROKERAGE, FACE_VAL,
           CARR_VAL, COUP_INT_ACCR,
           COUP_PAY,COUP_INT
          )
          SELECT
           M_PROCESS_DATE,PORTFOLIO_CODE,
           EFF_VALDATE, INST_TYPE,
           SECURITY_CODE, TRN_TYPE,
           DEAL_NO, DEAL_YIELD,
           YIELD_WITH_BROKERAGE, FACE_VAL,
           CARR_VAL, COUP_INT_ACCR,
           (M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY,--(modified by Nilu on 13-10-2004 removed ceil VCF 04-245)CEIL((M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY)--modified by nirmala on 14-03-2001 by ceiling
           (((M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY)-((M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY))--(modified by Nilu on 13-10-2004 removed ceil VCF 04-245)((CEIL((M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY))-((M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY))--added by nirmala on 14-03-2001
        FROM
            DN_INV_OUTPS_DEAL_SEC
         WHERE
            PORTFOLIO_CODE=M_PORTFOLIO_CODE
            AND
            EFF_VALDATE=M_EFF_VALDATE
            AND
            INST_TYPE=M_INST_TYPE
            AND
            SECURITY_CODE=M_SECURITY_CODE
            AND
            TRN_TYPE=M_TRN_TYPE
            AND
            DEAL_NO=M_DEAL_NO;

     END IF;

    UPDATE DN_INV_OUTPS_DEAL_SEC A
       SET COUP_INT_PURCH=0,
           COUP_INT_ACCR=0,
           TOT_COUP_INT=0
    WHERE
       PORTFOLIO_CODE=M_PORTFOLIO_CODE
       AND
       EFF_VALDATE=M_EFF_VALDATE
       AND
       INST_TYPE=M_INST_TYPE
       AND
       SECURITY_CODE=M_SECURITY_CODE
       AND
       TRN_TYPE=M_TRN_TYPE
       AND
       DEAL_NO=M_DEAL_NO;

   END LOOP;

   OPEN SERIAL_NO;

   LOOP

      FETCH  SERIAL_NO INTO

      M_PORTFOLIO_CODE,M_EFF_VALDATE,M_INST_TYPE,
      M_SECURITY_CODE,M_SERIAL_NO,M_DEAL_NO,M_FACE_VAL,
      M_COUPON_INT,M_FREQUENCY;

      EXIT WHEN SERIAL_NO%NOTFOUND;

          -- At serial number level

        UPDATE DN_INV_INT_OUTPS_DEAL_SERNO
           SET COUP_PAY=(M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY,--(modified by Nilu on 13-10-2004 removed ceil VCF 04-245)SET COUP_PAY=CEIL((M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY)--modified by nirmala on 14-03-2001 by ceiling
               COUP_INT=(((M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY)-((M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY))--(modified by Nilu on 13-10-2004 removed ceil VCF 04-245) COUP_INT=((CEIL((M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY))-((M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY))--added by nirmala on 14-03-2001
           WHERE
           PROCESS_DATE=M_PROCESS_DATE
           AND
           PORTFOLIO_CODE=M_PORTFOLIO_CODE
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

       INSERT INTO DN_INV_INT_OUTPS_DEAL_SERNO
          (PROCESS_DATE, PORTFOLIO_CODE,
           EFF_VALDATE, INST_TYPE,
           SECURITY_CODE,
           DEAL_NO,SERIAL_NO,
           DEAL_YIELD,YIELD_WITH_BROKERAGE,
           SCRIP_FACE_VAL,FACE_VAL,
           CARR_VAL, COUP_INT_ACCR,
           COUP_PAY,COUP_INT,
           SERIAL_NO_STATUS
          )
          SELECT
             M_PROCESS_DATE,PORTFOLIO_CODE,
             EFF_VALDATE, INST_TYPE,
             SECURITY_CODE,
             DEAL_NO,SERIAL_NO,
             DEAL_YIELD,YIELD_WITH_BROKERAGE,
             SCRIP_FACE_VAL,FACE_VAL,
             CARR_VAL, COUP_INT_ACCR,
             (M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY,--(modified by Nilu on 13-10-2004 removed ceil VCF 04-245)CEIL((M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY)--modified by nirmala on 14-03-2001 by ceiling
             (((M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY)-((M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY)),--(modified by Nilu on 13-10-2004 removed ceil VCF 04-245)((CEIL((M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY))-((M_FACE_VAL*M_COUPON_INT)/M_FREQUENCY))--added by nirmala on 14-03-2001
             SERIAL_NO_STATUS
          FROM
             DN_INV_OUTPS_DEAL_SERIAL_NO
          WHERE
             PORTFOLIO_CODE=M_PORTFOLIO_CODE
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

    UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO A
       SET COUP_INT_PURCH=0,
           COUP_INT_ACCR=0,
           TOT_COUP_INT=0
    WHERE
       PORTFOLIO_CODE=M_PORTFOLIO_CODE
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

END LOOP;


END DN_INV_OUTPS_COUPON_PAYMENT;

/
