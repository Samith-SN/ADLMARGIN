--------------------------------------------------------
--  DDL for Function DN_TEST_YIELD_NG1
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_TEST_YIELD_NG1" 
   (
    M_SECURITY_CODE    DN_TRN_OUTP_SALE.SECURITY_CODE%TYPE,
    M_CLEAN_PRICE      DN_TRN_OUTP_SALE.PRICE_CLEAN%TYPE,
    M_EFF_VALDATE      DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE

   ) RETURN  REAL

    IS

    -- Function     : This returns bond yield for the given price
    -- System       : DEALNET System
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 30/06/1999


   M_RETVAL                     NUMBER;
   M_NO_COUPON_INT_PAY          NUMBER;
   M_ISSUE_DATE                 DN_REF_SECURITY.ISSUE_DATE%TYPE;
   M_MATURITY_DATE              DN_REF_SECURITY.MATURITY_DATE%TYPE;
   M_COUPON_INT                 DN_REF_SECURITY.COUPON_INT%TYPE;
   M_NO_DAYS_P_ANN              NUMBER;
   M_NEXT_COUPON_DATE           DN_REF_SECURITY.MATURITY_DATE%TYPE;
   M_LAST_COUPON_DATE           DN_REF_SECURITY.MATURITY_DATE%TYPE;
   M_COUPON_INT_PAY             NUMBER;
   M_BOND_FACE_VALUE            NUMBER;
   M_REQ_YIELD_P_ANN            NUMBER;
   M_PRESENT_VAL_COU_INT_PAY    NUMBER;
   M_DISC_TO_NEXT_PAY_DATE      NUMBER;
   M_FACTOR_OF_DAYS             NUMBER;
   M_PRESENT_VAL_INT_COUPON     NUMBER;
   M_PRESENT_VAL_MATURITY_PROC  NUMBER;
   M_ESTIMATE1_PRICE            NUMBER;
   M_ESTIMATE2_PRICE            NUMBER;
   M_ESTIMATE_PRICE_DIFF        NUMBER;
   M_YIELD_DIFF                 NUMBER;
   M_CHG_PRICE_UNIT_YIELD       NUMBER;
   M_PRICE_EST1_PRICE_DIFF      NUMBER;
   M_ADJ_EST1_YIELD             NUMBER;
   M_NO_DAYS_INT_ACCRUAL        NUMBER;
   M_INT_ADJ                    NUMBER;
   M_ADJ_BID_PRICE              NUMBER;

BEGIN

  M_BOND_FACE_VALUE:=100.00;  -- Allways bond face value is this

  SELECT
     ISSUE_DATE,MATURITY_DATE,COUPON_INT
     INTO
     M_ISSUE_DATE,M_MATURITY_DATE,M_COUPON_INT
  FROM
     DN_REF_SECURITY
  WHERE
     SECURITY_CODE=M_SECURITY_CODE;

--   M_MATURITY_DATE:=TO_DATE('01-MAR-1999','DD-MON-YYYY');
--   M_COUPON_INT:=.14;

  -- DBMS_OUTPUT.PUT_LINE('EVALD  '||TO_CHAR(M_EFF_VALDATE,'DD-MON-YYYY'));

  --No of coupon days per annum

  SELECT
     COUNT(SECURITY_CODE) INTO M_NO_DAYS_P_ANN
  FROM
     DN_REF_SECURITY_INT_PAY_DATES
  WHERE
     SECURITY_CODE=M_SECURITY_CODE
     AND
     INT_PAY_DATE>=M_ISSUE_DATE
     AND
     INT_PAY_DATE<=ADD_MONTHS(M_ISSUE_DATE,12);

-- M_NO_DAYS_P_ANN:=2;

-- Next coupon date

  SELECT
     MIN(INT_PAY_DATE) INTO  M_NEXT_COUPON_DATE
  FROM
     DN_REF_SECURITY_INT_PAY_DATES
  WHERE
     SECURITY_CODE=M_SECURITY_CODE
     AND
     INT_PAY_DATE>M_EFF_VALDATE;

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

  -- No of coupon interest days upto maturity

  SELECT
     COUNT(SECURITY_CODE) INTO M_NO_COUPON_INT_PAY
  FROM
     DN_REF_SECURITY_INT_PAY_DATES
  WHERE
     SECURITY_CODE=M_SECURITY_CODE
     AND
     INT_PAY_DATE>M_EFF_VALDATE;

  IF M_NO_COUPON_INT_PAY>=1 THEN

      -- Factors of days remaining to initial ....

      SELECT
         (M_NEXT_COUPON_DATE-M_EFF_VALDATE)/
         (M_NEXT_COUPON_DATE-M_LAST_COUPON_DATE)
         INTO M_FACTOR_OF_DAYS
      FROM DUAL;

      -- Coupon interest payment

      M_COUPON_INT_PAY:=(M_COUPON_INT*M_BOND_FACE_VALUE)/M_NO_DAYS_P_ANN;

      /************************* INTEREST ACCURAL *****************************/

        IF M_EFF_VALDATE>M_ISSUE_DATE THEN

           M_NO_DAYS_INT_ACCRUAL:=M_EFF_VALDATE-M_LAST_COUPON_DATE;

           --M_INT_ADJ:=((M_BOND_FACE_VALUE*M_COUPON_INT)/365)*M_NO_DAYS_INT_ACCRUAL;


           M_INT_ADJ:=(((M_BOND_FACE_VALUE*M_COUPON_INT)/M_NO_DAYS_P_ANN))/(M_NEXT_COUPON_DATE-M_LAST_COUPON_DATE)*M_NO_DAYS_INT_ACCRUAL;

           M_ADJ_BID_PRICE:=M_CLEAN_PRICE+M_INT_ADJ;

        ELSE

          M_ADJ_BID_PRICE:=M_CLEAN_PRICE;

        END IF;

      /************************* ESTIMATE 1 ******************************/

          -- Required rate per period

          M_REQ_YIELD_P_ANN:= ((M_COUPON_INT-0.0001)/M_NO_DAYS_P_ANN);

          IF M_NO_COUPON_INT_PAY>=2 THEN

          -- Present value of coupon interest payments

            SELECT
              M_COUPON_INT_PAY*
              ((1-(1/POWER((1+M_REQ_YIELD_P_ANN),M_NO_COUPON_INT_PAY-1)))/
              M_REQ_YIELD_P_ANN)
              INTO M_PRESENT_VAL_COU_INT_PAY
            FROM DUAL;

          -- Discounted to next payment date

           SELECT
              M_PRESENT_VAL_COU_INT_PAY*
              (1/POWER((1+M_REQ_YIELD_P_ANN),M_FACTOR_OF_DAYS))
              INTO M_DISC_TO_NEXT_PAY_DATE
           FROM DUAL;

        ELSE

           M_PRESENT_VAL_COU_INT_PAY:=0;
           M_DISC_TO_NEXT_PAY_DATE:=0;

        END IF;

         -- Present value of initial coupon

          SELECT
             M_COUPON_INT_PAY*
             (1/(POWER((1+M_REQ_YIELD_P_ANN),M_FACTOR_OF_DAYS)))
             INTO M_PRESENT_VAL_INT_COUPON
          FROM DUAL;

        -- Present value of maturity proceeds

          SELECT
            M_BOND_FACE_VALUE*
            (1/((POWER((1+M_REQ_YIELD_P_ANN),M_NO_COUPON_INT_PAY-1))*
            (POWER((1+M_REQ_YIELD_P_ANN),M_FACTOR_OF_DAYS))))
            INTO M_PRESENT_VAL_MATURITY_PROC
          FROM DUAL;

        -- Price of bond
            SELECT
               --M_PRESENT_VAL_COU_INT_PAY+
               M_DISC_TO_NEXT_PAY_DATE+
               M_PRESENT_VAL_INT_COUPON +
               M_PRESENT_VAL_MATURITY_PROC
            INTO M_ESTIMATE1_PRICE
            FROM DUAL;

      /************************* ESTIMATE 2 ******************************/

          M_REQ_YIELD_P_ANN           :=0.00;
          M_PRESENT_VAL_COU_INT_PAY   :=0.00;
          M_DISC_TO_NEXT_PAY_DATE     :=0.00;
          M_PRESENT_VAL_INT_COUPON    :=0.00;
          M_PRESENT_VAL_MATURITY_PROC :=0.00;

          -- Required rate per period

          M_REQ_YIELD_P_ANN:= ((M_COUPON_INT+0.0001)/M_NO_DAYS_P_ANN);


         IF M_NO_COUPON_INT_PAY>=2 THEN

           -- Present value of coupon interest payments

           SELECT
              M_COUPON_INT_PAY*
              ((1-(1/POWER((1+M_REQ_YIELD_P_ANN),M_NO_COUPON_INT_PAY-1)))/
              M_REQ_YIELD_P_ANN)
             INTO M_PRESENT_VAL_COU_INT_PAY
            FROM DUAL;

          -- Discounted to next payment date

           SELECT
              M_PRESENT_VAL_COU_INT_PAY*
              (1/POWER((1+M_REQ_YIELD_P_ANN),M_FACTOR_OF_DAYS))
              INTO M_DISC_TO_NEXT_PAY_DATE
           FROM DUAL;

        ELSE

           M_PRESENT_VAL_COU_INT_PAY:=0;
           M_DISC_TO_NEXT_PAY_DATE  :=0;

        END IF;

        -- Present value of initial coupon

          SELECT
             M_COUPON_INT_PAY*
             (1/(POWER((1+M_REQ_YIELD_P_ANN),M_FACTOR_OF_DAYS)))
             INTO M_PRESENT_VAL_INT_COUPON
          FROM DUAL;

        -- Present value of maturity proceeds

          SELECT
            M_BOND_FACE_VALUE*
            (1/((POWER((1+M_REQ_YIELD_P_ANN),M_NO_COUPON_INT_PAY-1))*
            (POWER((1+M_REQ_YIELD_P_ANN),M_FACTOR_OF_DAYS))))
            INTO M_PRESENT_VAL_MATURITY_PROC
          FROM DUAL;

        -- Price of bond

            SELECT
               --M_PRESENT_VAL_COU_INT_PAY+
               M_DISC_TO_NEXT_PAY_DATE+
               M_PRESENT_VAL_INT_COUPON +
               M_PRESENT_VAL_MATURITY_PROC
            INTO M_ESTIMATE2_PRICE
            FROM DUAL;

      M_ESTIMATE_PRICE_DIFF:=M_ESTIMATE2_PRICE-M_ESTIMATE1_PRICE;

      M_YIELD_DIFF :=((M_COUPON_INT+0.0001)/M_NO_DAYS_P_ANN)-((M_COUPON_INT-0.0001)/M_NO_DAYS_P_ANN);

      M_CHG_PRICE_UNIT_YIELD:= ((M_ESTIMATE_PRICE_DIFF/M_YIELD_DIFF)/100);   --To be checked

      M_PRICE_EST1_PRICE_DIFF:=M_ADJ_BID_PRICE-M_ESTIMATE1_PRICE;

      M_ADJ_EST1_YIELD:=((M_COUPON_INT-0.0001)/M_NO_DAYS_P_ANN)+
                        ((M_PRICE_EST1_PRICE_DIFF/M_CHG_PRICE_UNIT_YIELD)/100);

      M_RETVAL:=M_ADJ_EST1_YIELD*M_NO_DAYS_P_ANN;

  END IF;

  RETURN M_RETVAL;

END DN_TEST_YIELD_NG1;

/
