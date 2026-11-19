--------------------------------------------------------
--  DDL for Function DN_FIN_PRICE_CLEAN_YIELD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_PRICE_CLEAN_YIELD" 

 (
    M_SECURITY_CODE       DN_TRN_OUTP_SALE.SECURITY_CODE%TYPE,
    M_REQ_YIELD           DN_TRN_OUTP_SALE.YIELD%TYPE,
    M_EFF_VALDATE         DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE,
    M_INT_RATE_BASE_CODE  DN_TRN_OUTP_SALE.INT_RATE_BASE_CODE%TYPE

   )

   RETURN  REAL

   IS

    -- Function     : This returns price for the req.yield (Equal with excel function)
    -- System       : DealNet System
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 30/06/1999

   M_RETVAL                     NUMBER;
   M_PART1                      NUMBER;
   M_PART2                      NUMBER;
   M_SUB_PART2                  NUMBER;
   M_PART3                      NUMBER;
   M_NO_COUPON_INT_PAY          NUMBER;
   M_ISSUE_DATE                 DN_REF_SECURITY.ISSUE_DATE%TYPE;
   M_MATURITY_DATE              DN_REF_SECURITY.MATURITY_DATE%TYPE;
   M_COUPON_INT                 DN_REF_SECURITY.COUPON_INT%TYPE;

   M_SEC_TYPE                   VARCHAR2(2);

   M_FREQUENCY                  NUMBER;
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

    SELECT
       ISSUE_DATE,MATURITY_DATE,COUPON_INT
       INTO
       M_ISSUE_DATE,M_MATURITY_DATE,M_COUPON_INT
    FROM
       DN_REF_SECURITY
    WHERE
       SECURITY_CODE=M_SECURITY_CODE;
    IF M_COUPON_INT=0 THEN
       M_SEC_TYPE:='BI';
    ELSE
       M_SEC_TYPE:='BO';
    END IF ;

IF M_SEC_TYPE='BI' THEN

   SELECT
      DN_FIN_BILL_PRICE_CLEAN_YIELD(M_SECURITY_CODE,M_REQ_YIELD,M_EFF_VALDATE,M_INT_RATE_BASE_CODE)
      INTO M_RETVAL
   FROM DUAL;

ELSIF M_SEC_TYPE='BO' THEN

    --M_MATURITY_DATE:=TO_DATE('01-MAR-1999','DD-MON-YYYY');
    --M_COUPON_INT:=.14;

    --DBMS_OUTPUT.PUT_LINE('EVALD  '||TO_CHAR(M_EFF_VALDATE,'DD-MON-YYYY'));

    --No of coupon days per annum

    SELECT
       COUNT(SECURITY_CODE) INTO M_FREQUENCY
    FROM
       DN_REF_SECURITY_INT_PAY_DATES
    WHERE
       SECURITY_CODE=M_SECURITY_CODE
       AND
       INT_PAY_DATE>=M_ISSUE_DATE
       AND
       INT_PAY_DATE<=ADD_MONTHS(M_ISSUE_DATE,12);


      --M_FREQUENCY:=2;
      -- Next coupon date

        SELECT
           MIN(INT_PAY_DATE) INTO  M_NEXT_COUPON_DATE
        FROM
           DN_REF_SECURITY_INT_PAY_DATES
        WHERE
           SECURITY_CODE=M_SECURITY_CODE
           AND
           INT_PAY_DATE>=M_EFF_VALDATE;  --SM--INT_PAY_DATE>M_EFF_VALDAT--SM
        -- Last coupon date

        SELECT
           MAX(INT_PAY_DATE) INTO  M_LAST_COUPON_DATE
        FROM
           DN_REF_SECURITY_INT_PAY_DATES
        WHERE
           SECURITY_CODE=M_SECURITY_CODE
           AND
           INT_PAY_DATE<M_EFF_VALDATE;

        IF M_LAST_COUPON_DATE IS NULL THEN

           ---Which is higher

           M_LAST_COUPON_DATE:=M_ISSUE_DATE;

        END IF;

        --DSC

        SELECT
           (M_NEXT_COUPON_DATE-M_EFF_VALDATE)
           INTO M_DSC
        FROM DUAL;

        --        M_DSC:=73;

        --DBMS_OUTPUT.PUT_LINE('DSC  '||TO_CHAR(M_DSC));

        --E

        SELECT
           (M_NEXT_COUPON_DATE-M_LAST_COUPON_DATE)
           INTO M_E
        FROM DUAL;

       --M_E:=181;

         --DBMS_OUTPUT.PUT_LINE('E  '||TO_CHAR(M_E));

        --A

        SELECT
           (M_EFF_VALDATE-M_LAST_COUPON_DATE)
           INTO M_A
        FROM DUAL;

        -- M_A:=108;
        --N

        SELECT
           COUNT(SECURITY_CODE) INTO M_N
        FROM
           DN_REF_SECURITY_INT_PAY_DATES
        WHERE
           SECURITY_CODE=M_SECURITY_CODE
           AND
           INT_PAY_DATE>=M_EFF_VALDATE; --SM --INT_PAY_DATE>M_EFF_VALDATE-- SM

        --M_N:=1;
        --DBMS_OUTPUT.PUT_LINE('N  '||TO_CHAR(M_N));

  IF M_N=1 THEN

     -- Remaining coupon payment is equal to one

     SELECT
        (1+((M_REQ_YIELD/M_FREQUENCY)/M_E)*M_DSC)
        INTO M_TAY
     FROM DUAL;

        --DBMS_OUTPUT.PUT_LINE('M_TAY  '||TO_CHAR(M_TAY));

     SELECT
        ((M_REDEMPTION+(100*(M_COUPON_INT/M_FREQUENCY)))/M_TAY)
        INTO M_PWI
     FROM DUAL;

             --DBMS_OUTPUT.PUT_LINE('M_PWI  '||TO_CHAR(M_PWI));
     SELECT
        (100*(M_COUPON_INT/M_FREQUENCY)*(M_A/M_E))
        INTO M_AI
     FROM DUAL;

             --DBMS_OUTPUT.PUT_LINE('M_AI  '||TO_CHAR(M_AI));

     M_RETVAL:=M_PWI-M_AI;

  ELSE

      --DBMS_OUTPUT.PUT_LINE('A  '||TO_CHAR(M_A));

      -- Part 1

         SELECT
             (M_REDEMPTION/
             POWER((1+(M_REQ_YIELD/M_FREQUENCY)),(M_N-1+(M_DSC/M_E))))
            INTO M_PART1
         FROM DUAL;

         --DBMS_OUTPUT.PUT_LINE('PART1  '||TO_CHAR(M_PART1));

         -- Part 2

         M_K         :=1;
         M_PART2     :=0;
         M_SUB_PART2 :=0;

         WHILE M_K<=M_N  LOOP

            SELECT
               (100*(M_COUPON_INT/M_FREQUENCY))/
               POWER((1+(M_REQ_YIELD/M_FREQUENCY)),(M_K-1+(M_DSC/M_E)))
               INTO M_SUB_PART2
            FROM DUAL;

            --DBMS_OUTPUT.PUT_LINE('SUB_PART2  '||TO_CHAR(M_SUB_PART2,'999.9999'));

            M_PART2:=M_PART2+M_SUB_PART2;

            --DBMS_OUTPUT.PUT_LINE('PART2  '||TO_CHAR(M_PART2,'999.9999'));

            M_K:=M_K+1;

         END LOOP;

         -- Part 3

         SELECT
            (100*(M_COUPON_INT/M_FREQUENCY)*(M_A/M_E))
            INTO M_PART3
         FROM DUAL;

         --DBMS_OUTPUT.PUT_LINE('PART3  '||TO_CHAR(M_PART3));

          --Price

        M_RETVAL:=M_PART1+M_PART2-M_PART3;

  END IF;

END IF;

RETURN ROUND(M_RETVAL,4);

END DN_FIN_PRICE_CLEAN_YIELD;

/
