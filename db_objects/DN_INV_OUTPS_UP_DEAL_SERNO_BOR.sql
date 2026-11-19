--------------------------------------------------------
--  DDL for Procedure DN_INV_OUTPS_UP_DEAL_SERNO_BOR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_OUTPS_UP_DEAL_SERNO_BOR" 
   (
    M_DEAL_NO            DN_TRN_BO_INV_RECEIPT.DEAL_NO%TYPE,
    M_INST_TYPE          DN_TRN_BO_INV_RECEIPT.INST_TYPE%TYPE,
    M_SECURITY_CODE      DN_TRN_BO_INV_RECEIPT.SECURITY_CODE%TYPE,
    M_SERIAL_NO          DN_TRN_BO_INV_RECEIPT.SERIAL_NO%TYPE,
    M_SCRP_FACE_VALUE    DN_TRN_OUTP_SALE_SEC.FACE_VALUE%TYPE,
    M_CURR_CODE          DN_REF_EXCHANGE_RATES.CURR_CODE%TYPE--,--CURRENCY
    --M_PREV_BAL           DN_TRN_BO_INV_RECEIPT.FACE_VALUE%TYPE--CURRENCY
   )

   IS

    -- Procedue     : Update outright inventory - deal-serial number - BOR
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 15/07/1999

  M_CURR_DATE             DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE;
  M_EFF_VALDATE           DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE;
  M_DATA_FROM             DN_TRN_OUTP_SALE_SEC.DATA_FROM%TYPE;
  M_INV_STATUS            DN_TRN_OUTP_SALE_SEC.INV_STATUS%TYPE;
  M_BUY_PORTFOLIO_CODE    DN_TRN_OUTP_SALE.BUY_PORTFOLIO_CODE%TYPE;
  M_SELL_PORTFOLIO_CODE   DN_TRN_OUTP_SALE.SELL_PORTFOLIO_CODE%TYPE;
  M_COUNT                 NUMBER;
  M_COUNT1                NUMBER;


BEGIN

-- RAISE_APPLICATION_ERROR(-20201,'M_DEAL_NO '||M_DEAL_NO||'M_INST_TYPE '||M_INST_TYPE||'M_SECURITY_CODE '||M_SECURITY_CODE||'M_SERIAL_NO '||M_SERIAL_NO||' M_SCRP_FACE_VALUE'||TO_CHAR(M_SCRP_FACE_VALUE));

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

   SELECT
      DATA_FROM,
      INV_STATUS
      INTO M_DATA_FROM,M_INV_STATUS
   FROM
      DN_TRN_OUTP_SALE_SEC
   WHERE
      DEAL_NO=M_DEAL_NO
      AND
      SECURITY_CODE=M_SECURITY_CODE
      AND
      SERIAL_NO=M_SERIAL_NO;

  IF M_EFF_VALDATE<=M_CURR_DATE  THEN

     -- RAISE_APPLICATION_ERROR(-20201,'M_DEAL_NO '||M_DEAL_NO||'M_INST_TYPE '||M_INST_TYPE||'M_SECURITY_CODE '||M_SECURITY_CODE||'M_SERIAL_NO '||M_SERIAL_NO);

     -- buyer information

  IF M_DATA_FROM='BOR' OR M_DATA_FROM='BOI' THEN

      -----------// ADDED ON 22/09/2000   //------------

      SELECT COUNT(*)
      INTO   M_COUNT
      FROM   DN_INV_OUTPS_DEAL_SERIAL_NO A
      WHERE  A.PORTFOLIO_CODE = M_BUY_PORTFOLIO_CODE
      AND    A.INST_TYPE      = M_INST_TYPE
      AND    A.SECURITY_CODE  = M_SECURITY_CODE
      AND    A.DEAL_NO        = M_DEAL_NO
      AND    A.SERIAL_NO      = M_SERIAL_NO;

    IF M_COUNT>0 THEN
      UPDATE  DN_INV_OUTPS_DEAL_SERIAL_NO A
      SET    A.LOCATION       = M_BUY_PORTFOLIO_CODE
      WHERE  A.PORTFOLIO_CODE = M_BUY_PORTFOLIO_CODE
      AND    A.INST_TYPE      = M_INST_TYPE
      AND    A.SECURITY_CODE  = M_SECURITY_CODE
      AND    A.DEAL_NO        = M_DEAL_NO
      AND    A.SERIAL_NO      = M_SERIAL_NO;

    ELSIF M_COUNT=0 THEN

        IF(M_CURR_CODE<>'SLR')THEN--CURRENCY
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
            A.FACE_VAL*(M_SCRP_FACE_VALUE/A.FACE_VAL_CURR),--CURRENCY
            A.FACE_VAL*(M_SCRP_FACE_VALUE/A.FACE_VAL_CURR),--CURRENCY

            ((A.INITIAL_COST/A.FACE_VAL_CURR)*M_SCRP_FACE_VALUE),--CURRENCY
            ((A.BROKERAGE/A.FACE_VAL_CURR)*M_SCRP_FACE_VALUE),
            ((A.PRICE_INT_ACCR/A.FACE_VAL_CURR)*M_SCRP_FACE_VALUE),--0,
            ((A.INITIAL_COST/A.FACE_VAL_CURR)*M_SCRP_FACE_VALUE)+((A.BROKERAGE/A.FACE_VAL_CURR)*M_SCRP_FACE_VALUE)+((A.PRICE_INT_ACCR/A.FACE_VAL_CURR)*M_SCRP_FACE_VALUE),
            ((A.COUP_INT_PURCH/A.FACE_VAL_CURR)*M_SCRP_FACE_VALUE),

            ((A.COUP_INT_ACCR/A.FACE_VAL_CURR)*M_SCRP_FACE_VALUE),--0,
            ((A.COUP_INT_PURCH/A.FACE_VAL_CURR)*M_SCRP_FACE_VALUE)+((A.COUP_INT_ACCR/A.FACE_VAL_CURR)*M_SCRP_FACE_VALUE),
            M_BUY_PORTFOLIO_CODE,
            M_SCRP_FACE_VALUE--CURRENCY

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
        ELSE--CURRENCY
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
            M_SCRP_FACE_VALUE,

            ((A.INITIAL_COST/A.FACE_VAL)*M_SCRP_FACE_VALUE),
            ((A.BROKERAGE/A.FACE_VAL)*M_SCRP_FACE_VALUE),
            ((A.PRICE_INT_ACCR/A.FACE_VAL)*M_SCRP_FACE_VALUE),--0,
            ((A.INITIAL_COST/A.FACE_VAL)*M_SCRP_FACE_VALUE)+((A.BROKERAGE/A.FACE_VAL)*M_SCRP_FACE_VALUE)+((A.PRICE_INT_ACCR/A.FACE_VAL)*M_SCRP_FACE_VALUE),
            ((A.COUP_INT_PURCH/A.FACE_VAL)*M_SCRP_FACE_VALUE),

            ((A.COUP_INT_ACCR/A.FACE_VAL)*M_SCRP_FACE_VALUE),--0,
            ((A.COUP_INT_PURCH/A.FACE_VAL)*M_SCRP_FACE_VALUE)+((A.COUP_INT_ACCR/A.FACE_VAL)*M_SCRP_FACE_VALUE),
            M_BUY_PORTFOLIO_CODE
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
          A.TOT_COUP_INT
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
              A.TOT_COUP_INT-B.TOT_COUP_INT
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

      END IF;--CURRENCY
    END IF;

      -----------// 22/09/2000  END //------------

-- ELSIF M_DATA_FROM='FO' AND M_INV_STATUS='Y1' THEN
       ELSIF M_DATA_FROM='FO'  THEN

      --       RAISE_APPLICATION_ERROR(-20201,'M_DEAL_NO '||M_DEAL_NO||'M_INST_TYPE '||M_INST_TYPE||'M_SECURITY_CODE '||M_SECURITY_CODE||'M_SERIAL_NO '||M_SERIAL_NO||' M_SCRP_FACE_VALUE'||TO_CHAR(M_SCRP_FACE_VALUE));


            UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
              SET LOCATION        =M_BUY_PORTFOLIO_CODE
           WHERE
              PORTFOLIO_CODE=M_BUY_PORTFOLIO_CODE
              AND
              EFF_VALDATE=M_EFF_VALDATE
              AND
              INST_TYPE=M_INST_TYPE
              AND
              SECURITY_CODE=M_SECURITY_CODE
              AND
              DEAL_NO=M_DEAL_NO
              AND
              SERIAL_NO=M_SERIAL_NO;

        END IF;


 ELSIF M_EFF_VALDATE>M_CURR_DATE  THEN

    --Buyer


    ----THE FOLLOWING SECTION ADDED AND THE BALANCE REMARKED BY SM ON 23/11/99

     IF M_DATA_FROM='BOR' OR M_DATA_FROM='BOI' THEN

      -----------// ADDED ON 22/09/2000   //------------

      SELECT COUNT(*)
      INTO   M_COUNT1
      FROM   DN_INV_OUTPS_DEAL_SERIAL_NO A
      WHERE  A.PORTFOLIO_CODE = M_BUY_PORTFOLIO_CODE
      AND    A.INST_TYPE      = M_INST_TYPE
      AND    A.SECURITY_CODE  = M_SECURITY_CODE
      AND    A.DEAL_NO        = M_DEAL_NO
      AND    A.SERIAL_NO      = M_SERIAL_NO;

     IF M_COUNT1>0 THEN
      UPDATE  DN_INV_OUTPS_DEAL_SERIAL_NO A
      SET    A.LOCATION       = M_BUY_PORTFOLIO_CODE
      WHERE  A.PORTFOLIO_CODE = M_BUY_PORTFOLIO_CODE
      AND    A.INST_TYPE      = M_INST_TYPE
      AND    A.SECURITY_CODE  = M_SECURITY_CODE
      AND    A.DEAL_NO        = M_DEAL_NO
      AND    A.SERIAL_NO      = M_SERIAL_NO;


    ELSIF M_COUNT1=0 THEN
      IF(M_CURR_CODE<>'SLR')THEN--CURRENCY
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
            A.FACE_VAL_CURR--CURRENCY
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
              0,-- VC 0307/047 ON 01-09-2003 --A.FWD_PURCHASE-B.FACE_VAL,
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


      ELSE--CURRENCY
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
            M_SCRP_FACE_VALUE,

            ((A.INITIAL_COST/A.FACE_VAL)*M_SCRP_FACE_VALUE),
            ((A.BROKERAGE/A.FACE_VAL)*M_SCRP_FACE_VALUE),
            0,
            ((A.INITIAL_COST/A.FACE_VAL)*M_SCRP_FACE_VALUE)+((A.BROKERAGE/A.FACE_VAL)*M_SCRP_FACE_VALUE),
            ((A.COUP_INT_PURCH/A.FACE_VAL)*M_SCRP_FACE_VALUE),

            0,
            ((A.COUP_INT_PURCH/A.FACE_VAL)*M_SCRP_FACE_VALUE),
            M_SCRP_FACE_VALUE,
            M_BUY_PORTFOLIO_CODE
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
          A.FWD_PURCHASE
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
              0-- VC 0307/047 ON 01-09-2003 --A.FWD_PURCHASE-B.FACE_VAL
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
END IF;--CURRENCY
   END IF;
      -----------// 22/09/2000  END //------------

/*
     IF M_DATA_FROM='BOR' THEN

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

-----THE ABOVE SECTION WAS MODIFIED BY SM ON 23/11/99

--    ELSIF M_DATA_FROM='FO' AND M_INV_STATUS='Y1' THEN
    ELSIF M_DATA_FROM='FO' THEN

       UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
          SET LOCATION        =M_BUY_PORTFOLIO_CODE
       WHERE
          PORTFOLIO_CODE=M_BUY_PORTFOLIO_CODE
          AND
          EFF_VALDATE=M_EFF_VALDATE
          AND
          INST_TYPE=M_INST_TYPE
          AND
          SECURITY_CODE=M_SECURITY_CODE
          AND
          DEAL_NO=M_DEAL_NO
          AND
          SERIAL_NO=M_SERIAL_NO;

    END IF;

END IF;

--    RAISE_APPLICATION_ERROR(-20201,'M_DEAL_NO '||M_DEAL_NO||'M_INST_TYPE '||M_INST_TYPE||'M_SECURITY_CODE '||M_SECURITY_CODE||'M_SERIAL_NO '||M_SERIAL_NO||' INV_STATUS '||M_INV_STATUS);

 IF M_INV_STATUS='N' THEN

    UPDATE DN_TRN_OUTP_SALE_SEC
       SET INV_STATUS='Y1'
    WHERE
       DEAL_NO=M_DEAL_NO
       AND
       SECURITY_CODE=M_SECURITY_CODE
       AND
       SERIAL_NO=M_SERIAL_NO
       AND
       FACE_VALUE=M_SCRP_FACE_VALUE
       AND
       INV_STATUS='N';


 ELSIF M_INV_STATUS='Y1' THEN

    UPDATE DN_TRN_OUTP_SALE_SEC
       SET INV_STATUS='Y2'
    WHERE
       DEAL_NO=M_DEAL_NO
       AND
       SECURITY_CODE=M_SECURITY_CODE
       AND
       SERIAL_NO=M_SERIAL_NO
       AND
       FACE_VALUE=M_SCRP_FACE_VALUE
       AND
       INV_STATUS='Y1';

  ELSIF  M_INV_STATUS='Y2' THEN

    UPDATE DN_TRN_OUTP_SALE_SEC
       SET INV_STATUS='Y3'
    WHERE
       DEAL_NO=M_DEAL_NO
       AND
       SECURITY_CODE=M_SECURITY_CODE
       AND
       SERIAL_NO=M_SERIAL_NO
       AND
       FACE_VALUE=M_SCRP_FACE_VALUE
       AND
       INV_STATUS='Y2';

 END IF;

END DN_INV_OUTPS_UP_DEAL_SERNO_BOR;

/
