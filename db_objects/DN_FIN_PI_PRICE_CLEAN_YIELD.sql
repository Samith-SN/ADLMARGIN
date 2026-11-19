--------------------------------------------------------
--  DDL for Function DN_FIN_PI_PRICE_CLEAN_YIELD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_PI_PRICE_CLEAN_YIELD" 
 (
    M_REQ_YIELD           DN_TRN_OUTP_SALE.YIELD%TYPE,
    M_EFF_VALDATE         DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE,
    M_INT_RATE_BASE_CODE  DN_TRN_OUTP_SALE.INT_RATE_BASE_CODE%TYPE,
    M_MATURITY_DATE       DN_TRN_REPO_PERIOD_INT.MATURITY_DATE%TYPE,
    M_COUPON_INT          DN_TRN_REPO_PERIOD_INT.TENOR%TYPE,
    M_FREQUENCY           NUMBER,
    M_SEQNO               VARCHAR2
   )

   RETURN  REAL

   IS

    -- Function     : This returns price for the req.yield (Periodic Interst)
    -- System       : DealNet System
    -- Created by   : V.Thilakesan.
    -- Created on   : 13/03/2000

   M_RETVAL                     NUMBER;
   M_PART1                      NUMBER;
   M_PART2                      NUMBER;
   M_SUB_PART2                  NUMBER;
   M_PART3                      NUMBER;
   M_NO_COUPON_INT_PAY          NUMBER;
   M_ISSUE_DATE                 DN_REF_SECURITY.ISSUE_DATE%TYPE;
   --M_MATURITY_DATE              DN_REF_SECURITY.MATURITY_DATE%TYPE;
   --M_COUPON_INT                 DN_REF_SECURITY.COUPON_INT%TYPE;

   M_SEC_TYPE                   VARCHAR2(2);

   --M_FREQUENCY                  NUMBER;
   M_NEXT_COUPON_DATE           DN_REF_SECURITY.MATURITY_DATE%TYPE;
   M_LAST_COUPON_DATE           DN_REF_SECURITY.MATURITY_DATE%TYPE;
   M_COUPON_INT_PAY             NUMBER;
   M_REDEMPTION                 NUMBER;

   M_DSC                        NUMBER;
   M_E                          NUMBER;
   M_N                          NUMBER;
   M_A                          NUMBER;
   M_K                          NUMBER;
   M_TAY                        NUMBER;
   M_PWI                        NUMBER;
   M_AI                         NUMBER;

BEGIN
    M_REDEMPTION:=100.00;  -- Allways bond face value is this
    M_ISSUE_DATE:=M_EFF_VALDATE;

    IF M_COUPON_INT=0 THEN
       M_SEC_TYPE:='BI'; --TO BE COVERED LATER
    ELSE
       M_SEC_TYPE:='BO';
    END IF ;

    IF M_SEC_TYPE='BI' THEN

       SELECT
         DN_FIN_PI_BILL_CLEAN_YIELD(M_REQ_YIELD,M_EFF_VALDATE,M_INT_RATE_BASE_CODE,M_MATURITY_DATE)
         INTO M_RETVAL
       FROM DUAL;

    ELSIF M_SEC_TYPE='BO' THEN
       --Next coupon date
       SELECT
          MIN(PAY_DATE) INTO  M_NEXT_COUPON_DATE
       FROM
          DN_TRN_REPO_PERIOD_INT_DATES
       WHERE
          SEQNO=M_SEQNO
          AND
          PAY_DATE>=M_EFF_VALDATE;

       --Last coupon date
       SELECT
          MAX(PAY_DATE) INTO  M_LAST_COUPON_DATE
       FROM
          DN_TRN_REPO_PERIOD_INT_DATES
       WHERE
          SEQNO=M_SEQNO
          AND
          PAY_DATE<M_EFF_VALDATE;

          IF M_LAST_COUPON_DATE IS NULL THEN
             --Which is higher
             M_LAST_COUPON_DATE:=M_ISSUE_DATE;
          END IF;
          --DSC
          SELECT
            (M_NEXT_COUPON_DATE-M_EFF_VALDATE)
            INTO M_DSC
          FROM DUAL;

          SELECT
             (M_NEXT_COUPON_DATE-M_LAST_COUPON_DATE)
             INTO M_E
          FROM DUAL;

          SELECT
            (M_EFF_VALDATE-M_LAST_COUPON_DATE)
            INTO M_A
          FROM DUAL;

          SELECT
             COUNT(SEQNO) INTO M_N
          FROM
             DN_TRN_REPO_PERIOD_INT_DATES
          WHERE
             SEQNO=M_SEQNO
             AND
             PAY_DATE>=M_EFF_VALDATE;

         IF M_N=1 THEN
            --Remaining coupon payment is equal to one
            SELECT
               (1+((M_REQ_YIELD/M_FREQUENCY)/M_E)*M_DSC)
                INTO M_TAY
            FROM DUAL;

            SELECT
               ((M_REDEMPTION+(100*(M_COUPON_INT/M_FREQUENCY)))/M_TAY)
               INTO M_PWI
            FROM DUAL;

            SELECT
               (100*(M_COUPON_INT/M_FREQUENCY)*(M_A/M_E))
               INTO M_AI
            FROM DUAL;

            M_RETVAL:=M_PWI-M_AI;

         ELSE

            --Part 1
            SELECT
               (M_REDEMPTION/
               POWER((1+(M_REQ_YIELD/M_FREQUENCY)),(M_N-1+(M_DSC/M_E))))
               INTO M_PART1
            FROM DUAL;

            --Part 2

            M_K         :=1;
            M_PART2     :=0;
            M_SUB_PART2 :=0;

            WHILE M_K<=M_N  LOOP

              SELECT
                 (100*(M_COUPON_INT/M_FREQUENCY))/
                 POWER((1+(M_REQ_YIELD/M_FREQUENCY)),(M_K-1+(M_DSC/M_E)))
                 INTO M_SUB_PART2
              FROM DUAL;

              M_PART2:=M_PART2+M_SUB_PART2;

              M_K:=M_K+1;

           END LOOP;

           --Part 3
           SELECT
              (100*(M_COUPON_INT/M_FREQUENCY)*(M_A/M_E))
              INTO M_PART3
           FROM DUAL;
           --Price
           M_RETVAL:=M_PART1+M_PART2-M_PART3;

        END IF;

    END IF;

    RETURN ROUND(M_RETVAL,4);

END DN_FIN_PI_PRICE_CLEAN_YIELD;

/
