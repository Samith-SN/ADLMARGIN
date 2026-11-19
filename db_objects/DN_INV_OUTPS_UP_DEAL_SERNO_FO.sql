--------------------------------------------------------
--  DDL for Procedure DN_INV_OUTPS_UP_DEAL_SERNO_FO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_OUTPS_UP_DEAL_SERNO_FO" 
   (
    M_DEAL_NO      DN_TRN_OUTP_SALE.DEAL_NO%TYPE
   )

   IS

    -- Procedue     : Update outright inventory - deal-serial number -FO
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 07/07/1999

   CURSOR OUTP_SERIALNO IS
     SELECT
        B.INST_TYPE,
        A.SECURITY_CODE,
        A.SERIAL_NO,
        A.FACE_VALUE,
        A.DATA_FROM,
        A.INV_STATUS,
        A.FACE_VALUE_CURR--CURRENCY
     FROM
        DN_TRN_OUTP_SALE_SEC A,
        DN_REF_SECURITY B
     WHERE
        A.DEAL_NO=M_DEAL_NO
        AND
        A.SECURITY_CODE=B.SECURITY_CODE
        AND
        A.DATA_FROM='FO'
        AND
        A.INV_STATUS='N';


  M_CURR_DATE             DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE;
  M_EFF_VALDATE           DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE;
  M_INST_TYPE             DN_TRN_OUTP_SALE.INST_TYPE%TYPE;
  M_SECURITY_CODE         DN_TRN_OUTP_SALE_SEC.SECURITY_CODE%TYPE;
  M_SERIAL_NO             DN_TRN_OUTP_SALE_SEC.SERIAL_NO%TYPE;
  M_SCRP_FACE_VALUE       DN_TRN_OUTP_SALE_SEC.FACE_VALUE%TYPE;
  M_DATA_FROM             DN_TRN_OUTP_SALE_SEC.DATA_FROM%TYPE;
  M_INV_STATUS            DN_TRN_OUTP_SALE_SEC.INV_STATUS%TYPE;
  M_BUY_PORTFOLIO_CODE    DN_TRN_OUTP_SALE.BUY_PORTFOLIO_CODE%TYPE;
  M_SELL_PORTFOLIO_CODE   DN_TRN_OUTP_SALE.SELL_PORTFOLIO_CODE%TYPE;
  M_COUNT_ALL             NUMBER;
  M_SCRP_FACE_VALUE_CURR  DN_TRN_OUTP_SALE_SEC.FACE_VALUE%TYPE;--CURRENCY
   M_SCRIPT_STATUS     DN_TRN_OUTP_SALE.SCRIPT_STATUS%TYPE;--$$##SC
MSELL_PF_TYPE       DN_REF_PORTFOLIO.PF_TYPE%TYPE;
MBUY_PF_TYPE        DN_REF_PORTFOLIO.PF_TYPE%TYPE;

BEGIN

---------CURRENCY-----------------------------------------
 SELECT COUNT(*)
 INTO   M_COUNT_ALL
 FROM   DN_TRN_DEAL_CURRENCY
 WHERE  DEAL_NO=M_DEAL_NO;






   SELECT
      TO_DATE(TO_CHAR(SYSDATE,'DD-MON-YYYY'),'DD-MON-YYYY'),
      EFF_VALDATE,
      BUY_PORTFOLIO_CODE,
      SELL_PORTFOLIO_CODE
      INTO M_CURR_DATE,M_EFF_VALDATE,
           M_BUY_PORTFOLIO_CODE,M_SELL_PORTFOLIO_CODE
   FROM
      DN_TRN_OUTP_SALE
   WHERE
      DEAL_NO=M_DEAL_NO;

  OPEN OUTP_SERIALNO;

  LOOP

     FETCH  OUTP_SERIALNO INTO

     M_INST_TYPE,M_SECURITY_CODE,M_SERIAL_NO,M_SCRP_FACE_VALUE,M_DATA_FROM,M_INV_STATUS,M_SCRP_FACE_VALUE_CURR;--CURRENCY

     EXIT WHEN OUTP_SERIALNO%NOTFOUND;

        IF M_EFF_VALDATE<=M_CURR_DATE  THEN

         -- RAISE_APPLICATION_ERROR(-20201,'M_DEAL_NO '||M_DEAL_NO||'M_INST_TYPE '||M_INST_TYPE||'M_SECURITY_CODE '||M_SECURITY_CODE||'M_SERIAL_NO '||M_SERIAL_NO);

           -- buyer information

               INSERT INTO DN_INV_OUTPS_DEAL_SERIAL_NO
                  (PORTFOLIO_CODE,
                   EFF_VALDATE,
                   INST_TYPE,
                   SECURITY_CODE,
                   DEAL_NO,

                   SERIAL_NO,
                   DEAL_YIELD,
                   YIELD_WITH_BROKERAGE,
                   SCRIP_FACE_VAL,
                   FACE_VAL,

                   INITIAL_COST,
                   BROKERAGE,
                   PRICE_INT_ACCR,
                   CARR_VAL,
                   COUP_INT_PURCH,

                   COUP_INT_ACCR,
                   TOT_COUP_INT,
                   LOCATION,
                   FACE_VAL_CURR--CURRENCY
                  )
               SELECT
                  A.PORTFOLIO_CODE,
                  A.EFF_VALDATE,
                  A.INST_TYPE,
                  A.SECURITY_CODE,
                  A.DEAL_NO,

                  M_SERIAL_NO,
                  A.DEAL_YIELD,
                  A.YIELD_WITH_BROKERAGE,
                  M_SCRP_FACE_VALUE,
                  M_SCRP_FACE_VALUE,

                  ((A.INITIAL_COST/A.FACE_VAL)*M_SCRP_FACE_VALUE),
                  ((A.BROKERAGE/A.FACE_VAL)*M_SCRP_FACE_VALUE),
                  0,
                  ((A.INITIAL_COST/A.FACE_VAL)*M_SCRP_FACE_VALUE)+((A.BROKERAGE/A.FACE_VAL)*M_SCRP_FACE_VALUE),
                  ((A.COUP_INT_PURCH/A.FACE_VAL)*M_SCRP_FACE_VALUE),

                  0,
                  ((A.COUP_INT_PURCH/A.FACE_VAL)*M_SCRP_FACE_VALUE),
                  A.LOCATION,
                   M_SCRP_FACE_VALUE_CURR--CURRENCY
               FROM
                  DN_INV_OUTPS_DEAL_SEC A

               WHERE
                  A.PORTFOLIO_CODE=M_BUY_PORTFOLIO_CODE
                  AND
                  A.EFF_VALDATE=M_EFF_VALDATE
                  AND
                  A.INST_TYPE=M_INST_TYPE
                  AND
                  A.SECURITY_CODE=M_SECURITY_CODE
                  AND
                  A.TRN_TYPE='B'
                  AND
                  A.DEAL_NO=M_DEAL_NO;

          UPDATE  DN_INV_OUTPS_DEAL_SEC A
          SET (
              A.FACE_VAL,
              A.INITIAL_COST,
              A.BROKERAGE,
              A.PRICE_INT_ACCR,
              A.CARR_VAL,
              A.COUP_INT_PURCH,
              A.COUP_INT_ACCR,
              A.TOT_COUP_INT,
              A.FACE_VAL_CURR--CURRENCY
              )
              =
              (SELECT
                  A.FACE_VAL-B.FACE_VAL,
                  A.INITIAL_COST-B.INITIAL_COST,
                  A.BROKERAGE-B.BROKERAGE,
                  A.PRICE_INT_ACCR-B.PRICE_INT_ACCR,
                  A.CARR_VAL-B.CARR_VAL,
                  A.COUP_INT_PURCH-B.COUP_INT_PURCH,
                  A.COUP_INT_ACCR-B.COUP_INT_ACCR,
                  A.TOT_COUP_INT-B.TOT_COUP_INT,
                  A.FACE_VAL_CURR-B.FACE_VAL_CURR--CURRENCY
               FROM
                  DN_INV_OUTPS_DEAL_SERIAL_NO B
               WHERE
                  B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
                  AND
                  B.EFF_VALDATE=A.EFF_VALDATE
                  AND
                  B.INST_TYPE=A.INST_TYPE
                  AND
                  B.SECURITY_CODE=A.SECURITY_CODE
                  AND
                  B.DEAL_NO=A.DEAL_NO
                  AND
                  B.SERIAL_NO=M_SERIAL_NO)
           WHERE
              A.PORTFOLIO_CODE=M_BUY_PORTFOLIO_CODE
              AND
              A.EFF_VALDATE=M_EFF_VALDATE
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.SECURITY_CODE=M_SECURITY_CODE
              AND
              A.DEAL_NO=M_DEAL_NO
              AND
              A.TRN_TYPE='B';

        ---For the seller
--//////////////////////////////////////////////////
          IF (M_COUNT_ALL > 0) THEN--CURRENCY
           UPDATE  DN_INV_OUTPS_DEAL_SEC
           SET     FACE_VAL=FACE_VAL+M_SCRP_FACE_VALUE,
                   FACE_VAL_CURR=FACE_VAL_CURR+M_SCRP_FACE_VALUE_CURR--CURRENCY
           WHERE
              PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
              AND
              EFF_VALDATE=M_EFF_VALDATE
              AND
              INST_TYPE=M_INST_TYPE
              AND
              SECURITY_CODE=M_SECURITY_CODE
              AND
              DEAL_NO=M_DEAL_NO
              AND
              TRN_TYPE='S';

          ELSE--CURRENCY


          UPDATE  DN_INV_OUTPS_DEAL_SEC A
          SET (
              A.FACE_VAL,
              A.FACE_VAL_CURR--CURRENCY
              )
              =
              (SELECT
                  A.FACE_VAL+NVL(B.FACE_VAL,0),
                  A.FACE_VAL_CURR+NVL(B.FACE_VAL_CURR,0)--CURRENCY
               FROM
                  DN_INV_OUTPS_DEAL_SERIAL_NO B
               WHERE
                  B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
                  AND
        --          B.EFF_VALDATE=A.EFF_VALDATE
        --          AND
                  B.INST_TYPE=A.INST_TYPE
                  AND
                  B.SECURITY_CODE=A.SECURITY_CODE
                  AND
        --          B.DEAL_NO=A.DEAL_NO
        --          AND
--THE FOLLOWING SECTION WAS ADDED BY SM ON 12-01-2000 TO OVERCOME MULTIPLE VALUES FROM BEING
--RETURNED FOR A SINGLE ROW SUB QUERRY
                 B.SERIAL_NO=M_SERIAL_NO
                 AND
                 B.SALE_DEAL_NO  IS NULL
                 AND
                 B.SERIAL_NO_STATUS='INV'
                 AND
                 B.SALE_EFF_VALDATE IS NULL)


           WHERE
              A.PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
              AND
              A.EFF_VALDATE=M_EFF_VALDATE
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.SECURITY_CODE=M_SECURITY_CODE
              AND
              A.DEAL_NO=M_DEAL_NO
              AND
              A.TRN_TYPE='S';
           END IF;--CURRENCY

      ELSIF M_EFF_VALDATE>M_CURR_DATE  THEN

         --Buyer
--THE FOLLOWING SECTION WAS ADDED BY SM ON 15-01-2000---------------------------------
        INSERT INTO DN_INV_OUTPS_DEAL_SERIAL_NO
           (PORTFOLIO_CODE,
            EFF_VALDATE,
            INST_TYPE,
            SECURITY_CODE,
            DEAL_NO,
            SERIAL_NO,
            DEAL_YIELD,
            YIELD_WITH_BROKERAGE,
            SCRIP_FACE_VAL,
            FACE_VAL,
            INITIAL_COST,
            BROKERAGE,
            PRICE_INT_ACCR,
            CARR_VAL,
            COUP_INT_PURCH,
            COUP_INT_ACCR,
            TOT_COUP_INT,
            FWD_PURCHASE,
            LOCATION,
            FACE_VAL_CURR--CURRENCY
           )
         SELECT
            A.PORTFOLIO_CODE,
            A.EFF_VALDATE,
            A.INST_TYPE,
            A.SECURITY_CODE,
            A.DEAL_NO,

            M_SERIAL_NO,
            A.DEAL_YIELD,
            A.YIELD_WITH_BROKERAGE,
            M_SCRP_FACE_VALUE,
            M_SCRP_FACE_VALUE,

            ((A.INITIAL_COST/A.FACE_VAL)*M_SCRP_FACE_VALUE),
            ((A.BROKERAGE/A.FACE_VAL)*M_SCRP_FACE_VALUE),
            0,
            ((A.INITIAL_COST/A.FACE_VAL)*M_SCRP_FACE_VALUE)+((A.BROKERAGE/A.FACE_VAL)*M_SCRP_FACE_VALUE),
            ((A.COUP_INT_PURCH/A.FACE_VAL)*M_SCRP_FACE_VALUE),

            0,
            ((A.COUP_INT_PURCH/A.FACE_VAL)*M_SCRP_FACE_VALUE),
            M_SCRP_FACE_VALUE,
            M_BUY_PORTFOLIO_CODE,
            M_SCRP_FACE_VALUE_CURR--CURRENCY
         FROM
            DN_INV_OUTPS_DEAL_SEC A
         WHERE
            A.PORTFOLIO_CODE=M_BUY_PORTFOLIO_CODE
            AND
            A.EFF_VALDATE=M_EFF_VALDATE
            AND
            A.INST_TYPE=M_INST_TYPE
            AND
            A.SECURITY_CODE=M_SECURITY_CODE
            AND
            A.TRN_TYPE='B'
            AND
            A.DEAL_NO=M_DEAL_NO;

--THE ABOVE SECTION WAS ADDED BY SM ON 15-01-2000---------------------------------------


--FOLLOWING SECTION WAS REMARKED BY SM ON 15-01-2000----

/*
           INSERT INTO DN_INV_OUTPS_DEAL_SERIAL_NO
                (PORTFOLIO_CODE,
                 EFF_VALDATE,
                 INST_TYPE,
                 SECURITY_CODE,
                 DEAL_NO,

                 SERIAL_NO,
                 DEAL_YIELD,
                 YIELD_WITH_BROKERAGE,
                 FWD_PURCHASE,
                 LOCATION
                )
             SELECT
                A.PORTFOLIO_CODE,
                A.EFF_VALDATE,
                A.INST_TYPE,
                A.SECURITY_CODE,
                A.DEAL_NO,

                M_SERIAL_NO,
                A.DEAL_YIELD,
                A.YIELD_WITH_BROKERAGE,
                M_SCRP_FACE_VALUE,
                A.LOCATION
             FROM
                DN_INV_OUTPS_DEAL_SEC A
             WHERE
                A.PORTFOLIO_CODE=M_BUY_PORTFOLIO_CODE
                AND
                A.EFF_VALDATE=M_EFF_VALDATE
                AND
                A.INST_TYPE=M_INST_TYPE
                AND
                A.SECURITY_CODE=M_SECURITY_CODE
                AND
                A.TRN_TYPE='B'
                AND
                A.DEAL_NO=M_DEAL_NO;
*/

--THE ABOVE SECTION WAS REMARKED BY SM ON 15-01-2000------------------

--FOLLOWING SECTION TO BE REVIEWED  -- SM 15-01-2000

---------------------------NEW PROCEDURE BELOW----------------------------------

      UPDATE  DN_INV_OUTPS_DEAL_SEC A
      SET (
          A.FACE_VAL,
          A.INITIAL_COST,
          A.BROKERAGE,
          A.PRICE_INT_ACCR,
          A.CARR_VAL,
          A.COUP_INT_PURCH,
          A.COUP_INT_ACCR,
          A.TOT_COUP_INT,
          A.FWD_PURCHASE,
          A.FACE_VAL_CURR--CURRENCY
          )
          =
          (SELECT
              A.FACE_VAL-B.FACE_VAL,
              A.INITIAL_COST-B.INITIAL_COST,
              A.BROKERAGE-B.BROKERAGE,
              A.PRICE_INT_ACCR-B.PRICE_INT_ACCR,
              A.CARR_VAL-B.CARR_VAL,
              A.COUP_INT_PURCH-B.COUP_INT_PURCH,
              A.COUP_INT_ACCR-B.COUP_INT_ACCR,
              A.TOT_COUP_INT-B.TOT_COUP_INT,
              A.FWD_PURCHASE-B.FACE_VAL,
              A.FACE_VAL_CURR-B.FACE_VAL_CURR--CURRENCY
           FROM
              DN_INV_OUTPS_DEAL_SERIAL_NO B
           WHERE
              B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
              AND
              B.EFF_VALDATE=A.EFF_VALDATE
              AND
              B.INST_TYPE=A.INST_TYPE
              AND
              B.SECURITY_CODE=A.SECURITY_CODE
              AND
              B.DEAL_NO=A.DEAL_NO
              AND
              B.SERIAL_NO=M_SERIAL_NO)
       WHERE
          A.PORTFOLIO_CODE=M_BUY_PORTFOLIO_CODE
          AND
          A.EFF_VALDATE=M_EFF_VALDATE
          AND
          A.INST_TYPE=M_INST_TYPE
          AND
          A.SECURITY_CODE=M_SECURITY_CODE
          AND
          A.DEAL_NO=M_DEAL_NO
          AND
          A.TRN_TYPE='B';


---------------------------NEW PROCEDURE ABOVE----------------------------------
/* --THE FOLLOWING SECTION WAS REMARKED BY SM ON 15-01-2000--

          UPDATE DN_INV_OUTPS_DEAL_SEC A
          SET A.FWD_PURCHASE=A.FWD_PURCHASE-M_SCRP_FACE_VALUE
          WHERE
              A.PORTFOLIO_CODE=M_BUY_PORTFOLIO_CODE
              AND
              A.EFF_VALDATE=M_EFF_VALDATE
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.SECURITY_CODE=M_SECURITY_CODE
              AND
              A.DEAL_NO=M_DEAL_NO
              AND
              A.TRN_TYPE='B';

*/


 IF M_COUNT_ALL >0 THEN--CURRENCY
 NULL;
 ELSE--CURRENCY
              ---For the seller
          UPDATE  DN_INV_OUTPS_DEAL_SEC A
          SET (
              A.FWD_SALE,
              A.FACE_VAL ---- ADDED BY ASHINI ON 18-05-2006 FOR VC06-007
              )
              =
              (SELECT
                  A.FWD_SALE-NVL(B.FWD_SALE,0),
                  A.FACE_VAL+NVL(B.FACE_VAL,0) ---- ADDED BY ASHINI ON 18-05-2006 FOR VC06-007

               FROM
                  DN_INV_OUTPS_DEAL_SERIAL_NO B
               WHERE
                  B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
                  AND
--                  B.EFF_VALDATE=A.EFF_VALDATE
--                  AND
                  B.INST_TYPE=A.INST_TYPE
                  AND
                  B.SECURITY_CODE=A.SECURITY_CODE
                  AND
--                  B.DEAL_NO=A.DEAL_NO
--                  AND
                  B.SERIAL_NO=M_SERIAL_NO
                  AND
                 B.SERIAL_NO_STATUS='INV')--VC03/094
           WHERE
              A.PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
              AND
              A.EFF_VALDATE=M_EFF_VALDATE
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.SECURITY_CODE=M_SECURITY_CODE
              AND
              A.DEAL_NO=M_DEAL_NO
              AND
              A.TRN_TYPE='S';


END IF;---CURRENCY

       END IF;

--THE ABOVE SECTION TO BE REVIEWED  -- SM 15-01-2000

   -- Update sale information - only for exisiting record
    -- Validation check is  to be done
 IF M_COUNT_ALL >0 THEN--CURRENCY
      UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
         SET SALE_DEAL_NO=M_DEAL_NO,
             SALE_EFF_VALDATE=M_EFF_VALDATE,
             SERIAL_NO_STATUS='SND'
      WHERE
         PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
         AND
         INST_TYPE     =M_INST_TYPE
         AND
         SECURITY_CODE =M_SECURITY_CODE
         AND
         SERIAL_NO     =M_SERIAL_NO
         AND
         FACE_VAL_CURR=M_SCRP_FACE_VALUE_CURR
         AND
         SALE_DEAL_NO  IS NULL
         AND
         SERIAL_NO_STATUS='INV'
         AND
         SALE_EFF_VALDATE IS NULL;
 ELSE--CURRENCY
      UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
         SET SALE_DEAL_NO=M_DEAL_NO,
             SALE_EFF_VALDATE=M_EFF_VALDATE,
             SERIAL_NO_STATUS='SND'
      WHERE
         PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
         AND
         INST_TYPE     =M_INST_TYPE
         AND
         SECURITY_CODE =M_SECURITY_CODE
         AND
         SERIAL_NO     =M_SERIAL_NO
         AND
         SCRIP_FACE_VAL=M_SCRP_FACE_VALUE
         AND
         SALE_DEAL_NO  IS NULL
         AND
         SERIAL_NO_STATUS='INV'
         AND
         SALE_EFF_VALDATE IS NULL;
END IF;--CURRENCY
         -- Update transaction level

         UPDATE DN_TRN_OUTP_SALE_SEC
           SET INV_STATUS='Y1'
         WHERE
            DEAL_NO=M_DEAL_NO
            AND
            SECURITY_CODE=M_SECURITY_CODE
            AND
            SERIAL_NO=M_SERIAL_NO;

     END LOOP;

      -----------$$##SC--------------------
SELECT A.SCRIPT_STATUS,B.PF_TYPE,C.PF_TYPE
INTO   M_SCRIPT_STATUS,MSELL_PF_TYPE,MBUY_PF_TYPE
FROM   DN_TRN_OUTP_SALE A,DN_REF_PORTFOLIO B, DN_REF_PORTFOLIO C
WHERE  A.DEAL_NO=M_DEAL_NO AND
       A.SELL_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND
       A.BUY_PORTFOLIO_CODE=C.PORTFOLIO_CODE;

IF(M_SCRIPT_STATUS='SL' AND MSELL_PF_TYPE= 'P' AND MBUY_PF_TYPE ='P')THEN

UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
SET    SCRIP_STATUS='SL',
       LOCATION    =M_BUY_PORTFOLIO_CODE --ADDED BY SM,NM ON 01-10-2004  VC04-244
WHERE  DEAL_NO = M_DEAL_NO;

END IF;
-------------------------------------
--***SCRIPLESS

END DN_INV_OUTPS_UP_DEAL_SERNO_FO;

/
