--------------------------------------------------------
--  DDL for Function DN_FIN_PI_YIELD_PRICE_CLEAN
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_PI_YIELD_PRICE_CLEAN" 
   (
    M_CLEAN_PRICE         DN_TRN_OUTP_SALE.PRICE_CLEAN%TYPE,
    M_EFF_VALDATE         DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE,
    M_INT_RATE_BASE_CODE  DN_TRN_OUTP_SALE.INT_RATE_BASE_CODE%TYPE,
    M_MATURITY_DATE       DN_TRN_REPO_PERIOD_INT.MATURITY_DATE%TYPE,
    M_COUPON_INT          DN_TRN_REPO_PERIOD_INT.TENOR%TYPE,
    M_FREQUENCY           NUMBER,
    M_SEQNO               VARCHAR2
   ) RETURN  REAL

    IS

    -- Function     : This returns yield for the given price (periodic interst)
    -- System       : DEALNET System
    -- Created by   : V.Thilakesan.
    -- Created on   : 13/03/2000


   M_RETVAL                     NUMBER;
   M_NO_COUPON_INT_PAY          NUMBER;
   M_SEC_TYPE                   VARCHAR2(2);

   M_INP_PRICE                  NUMBER;
   M_OUT_PRICE                  NUMBER;
   M_OUT_YIELD                  NUMBER;
   --M_COUPON_INT                 NUMBER;
   M_LOOP_COUNT                 NUMBER;

BEGIN

   /* SELECT
       COUPON_INT
       INTO
       M_COUPON_INT
    FROM
       DN_REF_SECURITY
    WHERE
       SECURITY_CODE=M_SECURITY_CODE;
   */

    IF M_COUPON_INT=0 THEN
       M_SEC_TYPE:='BI';
    ELSE
       M_SEC_TYPE:='BO';
    END IF ;

    IF M_SEC_TYPE='BI' THEN

       SELECT
          DN_FIN_PI_BILL_YIELD_CLEAN(M_CLEAN_PRICE,M_EFF_VALDATE,M_INT_RATE_BASE_CODE,M_MATURITY_DATE)
          INTO M_RETVAL
       FROM DUAL;

    ELSIF M_SEC_TYPE='BO' THEN

        -- No of coupon interest days upto maturity

        SELECT
           COUNT(SEQNO) INTO M_NO_COUPON_INT_PAY
        FROM
           DN_TRN_REPO_PERIOD_INT_DATES
        WHERE
           SEQNO=M_SEQNO
           AND
           PAY_DATE>M_EFF_VALDATE;

        --DBMS_OUTPUT.PUT_LINE('DATES  '||TO_CHAR(M_NO_COUPON_INT_PAY));
        IF M_NO_COUPON_INT_PAY>=1 THEN

            M_INP_PRICE:=M_CLEAN_PRICE;

            --DBMS_OUTPUT.PUT_LINE('M_INP_PRICE  '||TO_CHAR(M_INP_PRICE));

            SELECT
               DN_FIN_PI_YIELD_NG1(M_INP_PRICE,M_EFF_VALDATE,M_MATURITY_DATE,M_COUPON_INT,M_FREQUENCY,M_SEQNO)
               INTO M_OUT_YIELD
            FROM DUAL;

            --DBMS_OUTPUT.PUT_LINE('M_OUT_YIELD  '||TO_CHAR(M_OUT_YIELD));

            SELECT
              DN_FIN_PI_PRICE_CLEAN_YIELD(M_OUT_YIELD,M_EFF_VALDATE,M_INT_RATE_BASE_CODE,M_MATURITY_DATE,M_COUPON_INT,M_FREQUENCY,M_SEQNO)
               INTO M_OUT_PRICE
            FROM DUAL;

            --DBMS_OUTPUT.PUT_LINE('M_OUT_PRICE  '||TO_CHAR(M_OUT_PRICE));

          M_LOOP_COUNT:=0;

          WHILE ABS(M_INP_PRICE-M_OUT_PRICE)>0 LOOP

                -- DBMS_OUTPUT.PUT_LINE('START ');

               M_OUT_YIELD:=M_OUT_YIELD-(((M_INP_PRICE-M_OUT_PRICE)/M_INP_PRICE)/3);

               SELECT
                 DN_FIN_PI_PRICE_CLEAN_YIELD(M_OUT_YIELD,M_EFF_VALDATE,M_INT_RATE_BASE_CODE,M_MATURITY_DATE,M_COUPON_INT,M_FREQUENCY,M_SEQNO)
                  INTO M_OUT_PRICE
               FROM DUAL;

               --DBMS_OUTPUT.PUT_LINE('M_LOOP_COUNT  '||TO_CHAR(M_LOOP_COUNT));
               M_LOOP_COUNT:=M_LOOP_COUNT+1;

               IF M_LOOP_COUNT>100 THEN
                  EXIT;
               END IF;

            END LOOP;
            M_RETVAL:=M_OUT_YIELD;

        END IF;

   END IF;

  RETURN ROUND(M_RETVAL,6);


END DN_FIN_PI_YIELD_PRICE_CLEAN;

/
