--------------------------------------------------------
--  DDL for Procedure DN_INV_OUTPS_UP_DEAL_SEC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_OUTPS_UP_DEAL_SEC" 
   (
    M_DEAL_NO      DN_TRN_OUTP_SALE.DEAL_NO%TYPE
   )

   IS

    -- Procedue     : Update outright inventory - deal security
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 05/07/1999

M_CURR_DATE         DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE;
M_EFF_VALDATE       DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE;
M_CURR_CODE      DN_TRN_OUTP_SALE.CURR_CODE%TYPE;
M_SCRIPT_STATUS     DN_TRN_OUTP_SALE.SCRIPT_STATUS%TYPE;--$$##SC
MSELL_PF_TYPE       DN_REF_PORTFOLIO.PF_TYPE%TYPE;
MBUY_PF_TYPE        DN_REF_PORTFOLIO.PF_TYPE%TYPE;
BEGIN

   SELECT
      TO_DATE(TO_CHAR(SYSDATE,'DD-MON-YYYY'),'DD-MON-YYYY'),
      EFF_VALDATE,CURR_CODE
      INTO M_CURR_DATE,M_EFF_VALDATE,M_CURR_CODE--CURRENCY
   FROM
      DN_TRN_OUTP_SALE
   WHERE
      DEAL_NO=M_DEAL_NO;

   -------------------------------------
   -- Deal Security level information --
   -------------------------------------
IF (M_CURR_CODE<>'SLR') THEN

   IF M_EFF_VALDATE<=M_CURR_DATE  THEN
   -- buyer information


    INSERT INTO DN_INV_OUTPS_DEAL_SEC
      (PORTFOLIO_CODE,
       EFF_VALDATE,
       INST_TYPE,
       SECURITY_CODE,
       TRN_TYPE,

       DEAL_NO,
       DEAL_YIELD,
       YIELD_WITH_BROKERAGE,
       FACE_VAL,
       INITIAL_COST,

       BROKERAGE,
       PRICE_INT_ACCR,
       CARR_VAL,
       COUP_INT_PURCH,
       COUP_INT_ACCR,

       TOT_COUP_INT,
       FWD_SALE,
       FWD_PURCHASE,
       LOCATION,
       FACE_VAL_CURR--CURRENCY
      )
   SELECT
      A.BUY_PORTFOLIO_CODE,
      A.EFF_VALDATE,
      A.INST_TYPE,
      A.SECURITY_CODE,
      'B',

      A.DEAL_NO,
      A.YIELD,
      DN_FIN_YIELD_PRICE_CLEAN(A.SECURITY_CODE,
                                         DN_FIN_CLEAN_PRICE_F_COST_FV(A.FACE_VALUE,
                                                                                (A.COST+NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0))),
                                         A.EFF_VALDATE,A.INT_RATE_BASE_CODE),
      A.FACE_VALUE,
      A.COST,

      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0),
      0,
      A.COST+NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0),
      A.ACC_INT,
      0,

      A.ACC_INT,
      0,
      0,
      A.SELL_PORTFOLIO_CODE,
      C.LEG2_VALUE--CURRENCY
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B,
      DN_TRN_DEAL_CURRENCY C

   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.DEAL_NO=C.DEAL_NO--CURRENCY
      AND
      A.BUY_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      B.PF_TYPE='P'
      AND
      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0)>0;


   INSERT INTO DN_INV_OUTPS_DEAL_SEC
      (PORTFOLIO_CODE,
       EFF_VALDATE,
       INST_TYPE,
       SECURITY_CODE,
       TRN_TYPE,

       DEAL_NO,
       DEAL_YIELD,
       YIELD_WITH_BROKERAGE,
       FACE_VAL,
       INITIAL_COST,

       BROKERAGE,
       PRICE_INT_ACCR,
       CARR_VAL,
       COUP_INT_PURCH,
       COUP_INT_ACCR,

       TOT_COUP_INT,
       FWD_SALE,
       FWD_PURCHASE,
       LOCATION,
       FACE_VAL_CURR--CURRENCY
      )
   SELECT
      A.BUY_PORTFOLIO_CODE,
      A.EFF_VALDATE,
      A.INST_TYPE,
      A.SECURITY_CODE,
      'B',

      A.DEAL_NO,
      A.YIELD,
      A.YIELD,
      A.FACE_VALUE,
      A.COST,

      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0),
      0,
      A.COST+NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0),
      A.ACC_INT,
      0,

      A.ACC_INT,
      0,
      0,
      A.SELL_PORTFOLIO_CODE,
      C.LEG2_VALUE--CURRENCY
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B,
      DN_TRN_DEAL_CURRENCY C--CURRENCY
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.DEAL_NO=C.DEAL_NO--CURRENCY
      AND
      A.BUY_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      B.PF_TYPE='P'
      AND
      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0)=0;

   -- Seller information
   INSERT INTO DN_INV_OUTPS_DEAL_SEC
      (PORTFOLIO_CODE,
       EFF_VALDATE,
       INST_TYPE,
       SECURITY_CODE,
       TRN_TYPE,

       DEAL_NO,
       DEAL_YIELD,
       YIELD_WITH_BROKERAGE,
       FACE_VAL,
       FWD_SALE,
       LOCATION,
       FACE_VAL_CURR--CURRENCY
      )
   SELECT
      A.SELL_PORTFOLIO_CODE,
      A.EFF_VALDATE,
      A.INST_TYPE,
      A.SECURITY_CODE,
      'S',

      A.DEAL_NO,
      A.YIELD,
      DN_FIN_YIELD_PRICE_CLEAN(A.SECURITY_CODE,
                                         DN_FIN_CLEAN_PRICE_F_COST_FV(A.FACE_VALUE,
                                                                                (A.COST+NVL(DN_FIN_BROKERAGE(A.DEAL_NO,
                                                                                                                       A.SELL_PORTFOLIO_CODE),0))),
                                         A.EFF_VALDATE,A.INT_RATE_BASE_CODE),
      A.FACE_VALUE*(-1),
      0,
      A.SELL_PORTFOLIO_CODE,
      C.LEG2_VALUE*(-1)--CURRENCY
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B,
      DN_TRN_DEAL_CURRENCY C--CURRENCY
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.DEAL_NO=C.DEAL_NO--CURRENCY
      AND
      A.SELL_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      B.PF_TYPE='P'
      AND
      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0)>0;

    INSERT INTO DN_INV_OUTPS_DEAL_SEC
      (PORTFOLIO_CODE,
       EFF_VALDATE,
       INST_TYPE,
       SECURITY_CODE,
       TRN_TYPE,

       DEAL_NO,
       DEAL_YIELD,
       YIELD_WITH_BROKERAGE,
       FACE_VAL,
       FWD_SALE,
       LOCATION,
       FACE_VAL_CURR--CURRENCY
      )
   SELECT
      A.SELL_PORTFOLIO_CODE,
      A.EFF_VALDATE,
      A.INST_TYPE,
      A.SECURITY_CODE,
      'S',

      A.DEAL_NO,
      A.YIELD,
      A.YIELD,
      A.FACE_VALUE*(-1),
      0,
      A.SELL_PORTFOLIO_CODE,
      C.LEG2_VALUE*(-1)--CURRENCY
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B,
      DN_TRN_DEAL_CURRENCY C--CURRENCY
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.DEAL_NO=C.DEAL_NO--CURRENCY
      AND
      A.SELL_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      B.PF_TYPE='P'
      AND
      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0)=0;


   ELSIF M_EFF_VALDATE>M_CURR_DATE  THEN

      --Buyer

--THE FOLLOWING INSERT SHOULD INCLUDE ALL INSERTS WHERE EFFECTIVE VAL DATE IS LESS THAN OR
--EQUAL TO CURRENT DATE EXCEPT FACE VALUE FOR THE BUYER
--SM 22/11/99


--THE FOLOWING SECTION WAS ADDED BY SM ON 22/11/99 --------------------------
       INSERT INTO DN_INV_OUTPS_DEAL_SEC
      (PORTFOLIO_CODE,
       EFF_VALDATE,
       INST_TYPE,
       SECURITY_CODE,
       TRN_TYPE,

       DEAL_NO,
       DEAL_YIELD,
       YIELD_WITH_BROKERAGE,
       FACE_VAL,
       INITIAL_COST,

       BROKERAGE,
       PRICE_INT_ACCR,
       CARR_VAL,
       COUP_INT_PURCH,
       COUP_INT_ACCR,

       TOT_COUP_INT,
       FWD_SALE,
       FWD_PURCHASE,
       LOCATION,
       FACE_VAL_CURR--CURRENCY
      )
   SELECT
      A.BUY_PORTFOLIO_CODE,
      A.EFF_VALDATE,
      A.INST_TYPE,
      A.SECURITY_CODE,
      'B',

      A.DEAL_NO,
      A.YIELD,
      DN_FIN_YIELD_PRICE_CLEAN(A.SECURITY_CODE,
                                         DN_FIN_CLEAN_PRICE_F_COST_FV(A.FACE_VALUE,
                                                                                (A.COST+NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0))),
                                         A.EFF_VALDATE,A.INT_RATE_BASE_CODE),
      A.FACE_VALUE,  --CHANGED FROM '0' TO 'A.FACE_VALUE' BY SM ON 15-01-2000
      A.COST,

      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0),
      0,
      A.COST+NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0),
      A.ACC_INT,
      0,

      A.ACC_INT,
      0,
      0,  --VC 0307/047 on 01-09-2003---COMMENT - CONSIDERING "0"--A.FACE_VALUE--DONE

      A.SELL_PORTFOLIO_CODE,
      C.LEG2_VALUE--*(-1)--CURRENCY
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B,
      DN_TRN_DEAL_CURRENCY C--CURRENCY
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.DEAL_NO=C.DEAL_NO--CURRENCY
      AND
      A.BUY_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      B.PF_TYPE='P'
      AND
      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0)>0;

   INSERT INTO DN_INV_OUTPS_DEAL_SEC
      (PORTFOLIO_CODE,
       EFF_VALDATE,
       INST_TYPE,
       SECURITY_CODE,
       TRN_TYPE,

       DEAL_NO,
       DEAL_YIELD,
       YIELD_WITH_BROKERAGE,
       FACE_VAL,
       INITIAL_COST,

       BROKERAGE,
       PRICE_INT_ACCR,
       CARR_VAL,
       COUP_INT_PURCH,
       COUP_INT_ACCR,

       TOT_COUP_INT,
       FWD_SALE,
       FWD_PURCHASE,
       LOCATION,
       FACE_VAL_CURR--CURRENCY
      )
   SELECT
      A.BUY_PORTFOLIO_CODE,
      A.EFF_VALDATE,
      A.INST_TYPE,
      A.SECURITY_CODE,
      'B',

      A.DEAL_NO,
      A.YIELD,
      A.YIELD,
      A.FACE_VALUE,
      A.COST,

      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0),
      0,
      A.COST+NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0),
      A.ACC_INT,
      0,

      A.ACC_INT,
      0,
      0, --VC 0307/047 on 01-09-2003---COMMENT - CONSIDERING "0"--A.FACE_VALUE--DONE--
      A.SELL_PORTFOLIO_CODE,
      C.LEG2_VALUE--*(-1)--CURRENCY
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B,
      DN_TRN_DEAL_CURRENCY C--CURRENCY
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.DEAL_NO=C.DEAL_NO--CURRENCY
      AND
      A.BUY_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      B.PF_TYPE='P'
      AND
      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0)=0;

--THE ABOVE SECTION WAS ADDED BY SM ON 22/11/99---------------------------


--THE FOLLOWING SECTION WAS REMARKED BY SM ON 22/11/99--------------------
/*

   INSERT INTO DN_INV_OUTPS_DEAL_SEC
      (PORTFOLIO_CODE,
       EFF_VALDATE,
       INST_TYPE,
       SECURITY_CODE,
       TRN_TYPE,

       DEAL_NO,
       DEAL_YIELD,
       YIELD_WITH_BROKERAGE,
       FACE_VAL,

       FWD_PURCHASE,
       LOCATION
      )
   SELECT
      A.BUY_PORTFOLIO_CODE,
      A.EFF_VALDATE,
      A.INST_TYPE,
      A.SECURITY_CODE,
      'B',

      A.DEAL_NO,
      A.YIELD,
      DN_FIN_YIELD_PRICE_CLEAN(A.SECURITY_CODE,
                                         DN_FIN_CLEAN_PRICE_F_COST_FV(
                                                                                A.FACE_VALUE,
                                                                                (A.COST+NVL(DN_FIN_BROKERAGE(A.DEAL_NO,                                                                                                                       A.BUY_PORTFOLIO_CODE),0))),
                                         A.EFF_VALDATE,A.INT_RATE_BASE_CODE),
      0,--a.face_value,

      A.FACE_VALUE,
      A.SELL_PORTFOLIO_CODE
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.BUY_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      B.PF_TYPE='P'
      AND
      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0)>0;

      INSERT INTO DN_INV_OUTPS_DEAL_SEC
      (PORTFOLIO_CODE,
       EFF_VALDATE,
       INST_TYPE,
       SECURITY_CODE,
       TRN_TYPE,

       DEAL_NO,
       DEAL_YIELD,
       YIELD_WITH_BROKERAGE,
       FACE_VAL,

       FWD_PURCHASE,
       LOCATION
      )
   SELECT
      A.BUY_PORTFOLIO_CODE,
      A.EFF_VALDATE,
      A.INST_TYPE,
      A.SECURITY_CODE,
      'B',

      A.DEAL_NO,
      A.YIELD,
      A.YIELD,
      0,--a.face_value,

      A.FACE_VALUE,
      A.SELL_PORTFOLIO_CODE
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.BUY_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      B.PF_TYPE='P'
      AND
      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0)=0;

*/ --REMARKED BY SM ON 22/11/99-------------------------------------------

      --Seller

   INSERT INTO DN_INV_OUTPS_DEAL_SEC
      (PORTFOLIO_CODE,
       EFF_VALDATE,
       INST_TYPE,
       SECURITY_CODE,
       TRN_TYPE,

       DEAL_NO,
       DEAL_YIELD,
       YIELD_WITH_BROKERAGE,
       FACE_VAL,
       FWD_SALE,
       LOCATION,
       FACE_VAL_CURR--CURRENCY
      )
   SELECT
      A.SELL_PORTFOLIO_CODE,
      A.EFF_VALDATE,
      A.INST_TYPE,
      A.SECURITY_CODE,
      'S',

      A.DEAL_NO,
      A.YIELD,
      DN_FIN_YIELD_PRICE_CLEAN(A.SECURITY_CODE,
                                         DN_FIN_CLEAN_PRICE_F_COST_FV(A.FACE_VALUE,
                                                                                (A.COST+NVL(DN_FIN_BROKERAGE(A.DEAL_NO,
                                                                                                                       A.SELL_PORTFOLIO_CODE),0))),
                                         A.EFF_VALDATE,A.INT_RATE_BASE_CODE),
      A.FACE_VALUE*(-1),--VC 0307/047 on 01-09-2003---COMMENT - CONSIDERING "0"--A.FACE_VALUE--DONE
      0,--VC 0307/047 on 01-09-2003---COMMENT - CONSIDERING "0"--A.FACE_VALUE--DONE
      /*0,
      A.FACE_VALUE,*/
      A.SELL_PORTFOLIO_CODE,
      C.LEG2_VALUE--*(-1)--CURRENCY
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B,
      DN_TRN_DEAL_CURRENCY C--CURRENCY
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.DEAL_NO=C.DEAL_NO--CURRENCY
      AND
      A.SELL_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      B.PF_TYPE='P'
      AND
      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0)>0;

   INSERT INTO DN_INV_OUTPS_DEAL_SEC
      (PORTFOLIO_CODE,
       EFF_VALDATE,
       INST_TYPE,
       SECURITY_CODE,
       TRN_TYPE,

       DEAL_NO,
       DEAL_YIELD,
       YIELD_WITH_BROKERAGE,
       FACE_VAL,
       FWD_SALE,
       LOCATION,
       FACE_VAL_CURR--CURRENCY
      )
   SELECT
      A.SELL_PORTFOLIO_CODE,
      A.EFF_VALDATE,
      A.INST_TYPE,
      A.SECURITY_CODE,
      'S',

      A.DEAL_NO,
      A.YIELD,
      A.YIELD,
      A.FACE_VALUE*(-1),--0,--VC 0307/047 on 01-09-2003---COMMENT - CONSIDERING "0"--A.FACE_VALUE--DONE
      0,--A.FACE_VALUE,--VC 0307/047 on 01-09-2003---COMMENT - CONSIDERING "0"--A.FACE_VALUE--DONE
      A.SELL_PORTFOLIO_CODE,
      C.LEG2_VALUE--*(-1)--CURRENCY
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B,
      DN_TRN_DEAL_CURRENCY C--CURRENCY
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.DEAL_NO=C.DEAL_NO--CURRENCY
      AND
      A.SELL_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      B.PF_TYPE='P'
      AND
      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0)=0;

   END IF;

  ELSE--CURRENCY
--=============================================================================================
--=============================================================================================
--=============================================================================================
--=============================================================================================
--=============================================================================================
--=============================================================================================

     IF M_EFF_VALDATE<=M_CURR_DATE  THEN
   -- buyer information


    INSERT INTO DN_INV_OUTPS_DEAL_SEC
      (PORTFOLIO_CODE,
       EFF_VALDATE,
       INST_TYPE,
       SECURITY_CODE,
       TRN_TYPE,

       DEAL_NO,
       DEAL_YIELD,
       YIELD_WITH_BROKERAGE,
       FACE_VAL,
       INITIAL_COST,

       BROKERAGE,
       PRICE_INT_ACCR,
       CARR_VAL,
       COUP_INT_PURCH,
       COUP_INT_ACCR,

       TOT_COUP_INT,
       FWD_SALE,
       FWD_PURCHASE,
       LOCATION
      )
   SELECT
      A.BUY_PORTFOLIO_CODE,
      A.EFF_VALDATE,
      A.INST_TYPE,
      A.SECURITY_CODE,
      'B',

      A.DEAL_NO,
      A.YIELD,
      DN_FIN_YIELD_PRICE_CLEAN(A.SECURITY_CODE,
                                         DN_FIN_CLEAN_PRICE_F_COST_FV(A.FACE_VALUE,
                                                                                (A.COST+NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0))),
                                         A.EFF_VALDATE,A.INT_RATE_BASE_CODE),
      A.FACE_VALUE,
      A.COST,

      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0),
      0,
      A.COST+NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0),
      A.ACC_INT,
      0,

      A.ACC_INT,
      0,
      0,
      A.SELL_PORTFOLIO_CODE
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B

   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.BUY_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      B.PF_TYPE='P'
      AND
      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0)>0;


   INSERT INTO DN_INV_OUTPS_DEAL_SEC
      (PORTFOLIO_CODE,
       EFF_VALDATE,
       INST_TYPE,
       SECURITY_CODE,
       TRN_TYPE,

       DEAL_NO,
       DEAL_YIELD,
       YIELD_WITH_BROKERAGE,
       FACE_VAL,
       INITIAL_COST,

       BROKERAGE,
       PRICE_INT_ACCR,
       CARR_VAL,
       COUP_INT_PURCH,
       COUP_INT_ACCR,

       TOT_COUP_INT,
       FWD_SALE,
       FWD_PURCHASE,
       LOCATION
      )
   SELECT
      A.BUY_PORTFOLIO_CODE,
      A.EFF_VALDATE,
      A.INST_TYPE,
      A.SECURITY_CODE,
      'B',

      A.DEAL_NO,
      A.YIELD,
      A.YIELD,
      A.FACE_VALUE,
      A.COST,

      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0),
      0,
      A.COST+NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0),
      A.ACC_INT,
      0,

      A.ACC_INT,
      0,
      0,
      A.SELL_PORTFOLIO_CODE
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.BUY_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      B.PF_TYPE='P'
      AND
      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0)=0;

   -- Seller information
   INSERT INTO DN_INV_OUTPS_DEAL_SEC
      (PORTFOLIO_CODE,
       EFF_VALDATE,
       INST_TYPE,
       SECURITY_CODE,
       TRN_TYPE,

       DEAL_NO,
       DEAL_YIELD,
       YIELD_WITH_BROKERAGE,
       FACE_VAL,
       FWD_SALE,
       LOCATION
      )
   SELECT
      A.SELL_PORTFOLIO_CODE,
      A.EFF_VALDATE,
      A.INST_TYPE,
      A.SECURITY_CODE,
      'S',

      A.DEAL_NO,
      A.YIELD,
      DN_FIN_YIELD_PRICE_CLEAN(A.SECURITY_CODE,
                                         DN_FIN_CLEAN_PRICE_F_COST_FV(A.FACE_VALUE,
                                                                                (A.COST+NVL(DN_FIN_BROKERAGE(A.DEAL_NO,
                                                                                                                       A.SELL_PORTFOLIO_CODE),0))),
                                         A.EFF_VALDATE,A.INT_RATE_BASE_CODE),
      A.FACE_VALUE*(-1),
      0,
      A.SELL_PORTFOLIO_CODE
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B
   WHERE
      A.DEAL_NO=M_DEAL_NO

      AND
      A.SELL_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      B.PF_TYPE='P'
      AND
      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0)>0;

    INSERT INTO DN_INV_OUTPS_DEAL_SEC
      (PORTFOLIO_CODE,
       EFF_VALDATE,
       INST_TYPE,
       SECURITY_CODE,
       TRN_TYPE,

       DEAL_NO,
       DEAL_YIELD,
       YIELD_WITH_BROKERAGE,
       FACE_VAL,
       FWD_SALE,
       LOCATION
      )
   SELECT
      A.SELL_PORTFOLIO_CODE,
      A.EFF_VALDATE,
      A.INST_TYPE,
      A.SECURITY_CODE,
      'S',

      A.DEAL_NO,
      A.YIELD,
      A.YIELD,
      A.FACE_VALUE*(-1),
      0,
      A.SELL_PORTFOLIO_CODE
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B
   WHERE
      A.DEAL_NO=M_DEAL_NO

      AND
      A.SELL_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      B.PF_TYPE='P'
      AND
      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0)=0;


   ELSIF M_EFF_VALDATE>M_CURR_DATE  THEN

      --Buyer

--THE FOLLOWING INSERT SHOULD INCLUDE ALL INSERTS WHERE EFFECTIVE VAL DATE IS LESS THAN OR
--EQUAL TO CURRENT DATE EXCEPT FACE VALUE FOR THE BUYER
--SM 22/11/99


--THE FOLOWING SECTION WAS ADDED BY SM ON 22/11/99 --------------------------
       INSERT INTO DN_INV_OUTPS_DEAL_SEC
      (PORTFOLIO_CODE,
       EFF_VALDATE,
       INST_TYPE,
       SECURITY_CODE,
       TRN_TYPE,

       DEAL_NO,
       DEAL_YIELD,
       YIELD_WITH_BROKERAGE,
       FACE_VAL,
       INITIAL_COST,

       BROKERAGE,
       PRICE_INT_ACCR,
       CARR_VAL,
       COUP_INT_PURCH,
       COUP_INT_ACCR,

       TOT_COUP_INT,
       FWD_SALE,
       FWD_PURCHASE,
       LOCATION
      )
   SELECT
      A.BUY_PORTFOLIO_CODE,
      A.EFF_VALDATE,
      A.INST_TYPE,
      A.SECURITY_CODE,
      'B',

      A.DEAL_NO,
      A.YIELD,
      DN_FIN_YIELD_PRICE_CLEAN(A.SECURITY_CODE,
                                         DN_FIN_CLEAN_PRICE_F_COST_FV(A.FACE_VALUE,
                                                                                (A.COST+NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0))),
                                         A.EFF_VALDATE,A.INT_RATE_BASE_CODE),
      A.FACE_VALUE,  --CHANGED FROM '0' TO 'A.FACE_VALUE' BY SM ON 15-01-2000
      A.COST,

      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0),
      0,
      A.COST+NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0),
      A.ACC_INT,
      0,

      A.ACC_INT,
      0,
      0,--VC 0307/047 on 01-09-2003---COMMENT - CONSIDERING "0"--A.FACE_VALUE--DONE
      A.SELL_PORTFOLIO_CODE
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B
   WHERE
      A.DEAL_NO=M_DEAL_NO

      AND
      A.BUY_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      B.PF_TYPE='P'
      AND
      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0)>0;

   INSERT INTO DN_INV_OUTPS_DEAL_SEC
      (PORTFOLIO_CODE,
       EFF_VALDATE,
       INST_TYPE,
       SECURITY_CODE,
       TRN_TYPE,

       DEAL_NO,
       DEAL_YIELD,
       YIELD_WITH_BROKERAGE,
       FACE_VAL,
       INITIAL_COST,

       BROKERAGE,
       PRICE_INT_ACCR,
       CARR_VAL,
       COUP_INT_PURCH,
       COUP_INT_ACCR,

       TOT_COUP_INT,
       FWD_SALE,
       FWD_PURCHASE,
       LOCATION
      )
   SELECT
      A.BUY_PORTFOLIO_CODE,
      A.EFF_VALDATE,
      A.INST_TYPE,
      A.SECURITY_CODE,
      'B',

      A.DEAL_NO,
      A.YIELD,
      A.YIELD,
      A.FACE_VALUE,
      A.COST,

      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0),
      0,
      A.COST+NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0),
      A.ACC_INT,
      0,

      A.ACC_INT,
      0,
      0,--VC 0307/047 on 01-09-2003---COMMENT - CONSIDERING "0"--A.FACE_VALUE--DONE
      A.SELL_PORTFOLIO_CODE
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B
   WHERE
      A.DEAL_NO=M_DEAL_NO

      AND
      A.BUY_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      B.PF_TYPE='P'
      AND
      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0)=0;

--THE ABOVE SECTION WAS ADDED BY SM ON 22/11/99---------------------------


--THE FOLLOWING SECTION WAS REMARKED BY SM ON 22/11/99--------------------
/*

   INSERT INTO DN_INV_OUTPS_DEAL_SEC
      (PORTFOLIO_CODE,
       EFF_VALDATE,
       INST_TYPE,
       SECURITY_CODE,
       TRN_TYPE,

       DEAL_NO,
       DEAL_YIELD,
       YIELD_WITH_BROKERAGE,
       FACE_VAL,

       FWD_PURCHASE,
       LOCATION
      )
   SELECT
      A.BUY_PORTFOLIO_CODE,
      A.EFF_VALDATE,
      A.INST_TYPE,
      A.SECURITY_CODE,
      'B',

      A.DEAL_NO,
      A.YIELD,
      DN_FIN_YIELD_PRICE_CLEAN(A.SECURITY_CODE,
                                         DN_FIN_CLEAN_PRICE_F_COST_FV(
                                                                                A.FACE_VALUE,
                                                                                (A.COST+NVL(DN_FIN_BROKERAGE(A.DEAL_NO,                                                                                                                       A.BUY_PORTFOLIO_CODE),0))),
                                         A.EFF_VALDATE,A.INT_RATE_BASE_CODE),
      0,--a.face_value,

      A.FACE_VALUE,
      A.SELL_PORTFOLIO_CODE
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.BUY_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      B.PF_TYPE='P'
      AND
      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0)>0;

      INSERT INTO DN_INV_OUTPS_DEAL_SEC
      (PORTFOLIO_CODE,
       EFF_VALDATE,
       INST_TYPE,
       SECURITY_CODE,
       TRN_TYPE,

       DEAL_NO,
       DEAL_YIELD,
       YIELD_WITH_BROKERAGE,
       FACE_VAL,

       FWD_PURCHASE,
       LOCATION
      )
   SELECT
      A.BUY_PORTFOLIO_CODE,
      A.EFF_VALDATE,
      A.INST_TYPE,
      A.SECURITY_CODE,
      'B',

      A.DEAL_NO,
      A.YIELD,
      A.YIELD,
      0,--a.face_value,

      A.FACE_VALUE,
      A.SELL_PORTFOLIO_CODE
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.BUY_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      B.PF_TYPE='P'
      AND
      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0)=0;

*/ --REMARKED BY SM ON 22/11/99-------------------------------------------

      --Seller

   INSERT INTO DN_INV_OUTPS_DEAL_SEC
      (PORTFOLIO_CODE,
       EFF_VALDATE,
       INST_TYPE,
       SECURITY_CODE,
       TRN_TYPE,

       DEAL_NO,
       DEAL_YIELD,
       YIELD_WITH_BROKERAGE,
       FACE_VAL,
       FWD_SALE,
       LOCATION
      )
   SELECT
      A.SELL_PORTFOLIO_CODE,
      A.EFF_VALDATE,
      A.INST_TYPE,
      A.SECURITY_CODE,
      'S',

      A.DEAL_NO,
      A.YIELD,
      DN_FIN_YIELD_PRICE_CLEAN(A.SECURITY_CODE,
                                         DN_FIN_CLEAN_PRICE_F_COST_FV(A.FACE_VALUE,
                                                                                (A.COST+NVL(DN_FIN_BROKERAGE(A.DEAL_NO,
                                                                                                                       A.SELL_PORTFOLIO_CODE),0))),
                                         A.EFF_VALDATE,A.INT_RATE_BASE_CODE),
      A.FACE_VALUE*(-1),--VC 0307/047 on 01-09-2003---COMMENT - CONSIDERING "0"--A.FACE_VALUE--DONE
      0,--VC 0307/047 on 01-09-2003---COMMENT - CONSIDERING "0"--A.FACE_VALUE--DONE
      A.SELL_PORTFOLIO_CODE
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B
   WHERE
      A.DEAL_NO=M_DEAL_NO

      AND
      A.SELL_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      B.PF_TYPE='P'
      AND
      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0)>0;

   INSERT INTO DN_INV_OUTPS_DEAL_SEC
      (PORTFOLIO_CODE,
       EFF_VALDATE,
       INST_TYPE,
       SECURITY_CODE,
       TRN_TYPE,

       DEAL_NO,
       DEAL_YIELD,
       YIELD_WITH_BROKERAGE,
       FACE_VAL,
       FWD_SALE,
       LOCATION
      )
   SELECT
      A.SELL_PORTFOLIO_CODE,
      A.EFF_VALDATE,
      A.INST_TYPE,
      A.SECURITY_CODE,
      'S',

      A.DEAL_NO,
      A.YIELD,
      A.YIELD,
      A.FACE_VALUE*(-1),--VC 0307/047 on 01-09-2003---COMMENT - CONSIDERING "0"--A.FACE_VALUE--DONE
      0,--VC 0307/047 on 01-09-2003---COMMENT - CONSIDERING "0"--A.FACE_VALUE--DONE
      A.SELL_PORTFOLIO_CODE
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B
   WHERE
      A.DEAL_NO=M_DEAL_NO

      AND
      A.SELL_PORTFOLIO_CODE=B.PORTFOLIO_CODE
      AND
      B.PF_TYPE='P'
      AND
      NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0)=0;

   END IF;

-----------$$##SC--------------------
SELECT A.SCRIPT_STATUS,B.PF_TYPE,C.PF_TYPE
INTO   M_SCRIPT_STATUS,MSELL_PF_TYPE,MBUY_PF_TYPE
FROM   DN_TRN_OUTP_SALE A,DN_REF_PORTFOLIO B, DN_REF_PORTFOLIO C
WHERE  A.DEAL_NO=M_DEAL_NO AND
       A.SELL_PORTFOLIO_CODE=B.PORTFOLIO_CODE AND
       A.BUY_PORTFOLIO_CODE=C.PORTFOLIO_CODE;

IF(M_SCRIPT_STATUS='SL' AND MSELL_PF_TYPE= 'P' AND MBUY_PF_TYPE ='P')THEN

UPDATE DN_INV_OUTPS_DEAL_SEC
SET    SCRIP_STATUS='SL'
WHERE  DEAL_NO = M_DEAL_NO;


END IF;
-------------------------------------
  END IF;--CURRENCY
--COMMIT;
END DN_INV_OUTPS_UP_DEAL_SEC;

/
