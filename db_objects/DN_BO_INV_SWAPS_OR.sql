--------------------------------------------------------
--  DDL for Procedure DN_BO_INV_SWAPS_OR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_BO_INV_SWAPS_OR" 
   (
    M_INV_SWAP_NO      DN_TRN_BO_INV_SWAP.INV_SWAP_NO%TYPE
   )

   IS
    -- Procedue     : Update swaps of serial numbers in the O/R inventory
    -- System       : Dealnet system
    -- Created by   : TDS / SM
    -- Created on   : 02/11/1999
    -- modified by nirmala ON 03-07-2001

  CURSOR  SWP_ISSUES IS

      SELECT
          A.PORTFOLIO_CODE,
          A.INST_TYPE,
          A.SECURITY_CODE,
          A.DEAL_NO,
          A.SERIAL_NO
       FROM
          DN_INV_OUTPS_DEAL_SERIAL_NO A,
          DN_TRN_BO_INV_SWAP B
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.INV_CODE='OR'
          AND
          B.TRANS_TYPE='I'
          AND
          B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
          AND
          B.INST_TYPE=A.INST_TYPE
          AND
          B.SECURITY_CODE=A.SECURITY_CODE
          AND
          B.DEAL_NO=A.DEAL_NO
          AND
          B.SERIAL_NO=A.SERIAL_NO;


  CURSOR  SWP_RECEIPTS IS

      SELECT DISTINCT
          A.PORTFOLIO_CODE,
          A.INST_TYPE,
          A.SECURITY_CODE,
          C.DEAL_NO,
          C.SERIAL_NO,
          A.LOCATION,
          A.SALE_DEAL_NO,
          A.SERIAL_NO_STATUS,
          A.SALE_EFF_VALDATE,
          A.RET_DUE_DATE,
          C.FACE_VALUE--,
         -- A.EFF_VALDATE---ADDED BY NIRMALA

       FROM
          DN_INV_OUTPS_DEAL_SERIAL_NO A,
          DN_TRN_BO_INV_SWAP B,
          DN_TRN_BO_INV_SWAP C
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.INV_CODE='OR'
          AND
          B.TRANS_TYPE='I'
          AND
          B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
          AND
          B.INST_TYPE=A.INST_TYPE
          AND
          B.SECURITY_CODE=A.SECURITY_CODE
          AND
          B.DEAL_NO=A.DEAL_NO
          AND
          B.SERIAL_NO=A.SERIAL_NO
          AND
          B.INV_SWAP_NO=C.INV_SWAP_NO
          AND
          C.INV_CODE='OR'
          AND
          C.TRANS_TYPE='R';



M_PORTFOLIO_CODE                DN_INV_OUTPS_DEAL_SERIAL_NO.PORTFOLIO_CODE%TYPE;
M_INST_TYPE                     DN_INV_OUTPS_DEAL_SERIAL_NO.INST_TYPE%TYPE;
M_SECURITY_CODE                 DN_INV_OUTPS_DEAL_SERIAL_NO.SECURITY_CODE%TYPE;
M_DEAL_NO                       DN_INV_OUTPS_DEAL_SERIAL_NO.DEAL_NO%TYPE;
M_TOT_FACE_VAL                  DN_INV_OUTPS_DEAL_SERIAL_NO.SCRIP_FACE_VAL%TYPE;
M_TOT_DEAL_YIELD                DN_INV_OUTPS_DEAL_SERIAL_NO.DEAL_YIELD%TYPE;
M_TOT_YIELD_WITH_BROKERAGE      DN_INV_OUTPS_DEAL_SERIAL_NO.YIELD_WITH_BROKERAGE%TYPE;
M_TOT_INITIAL_COST              DN_INV_OUTPS_DEAL_SERIAL_NO.INITIAL_COST%TYPE;
M_TOT_BROKERAGE                 DN_INV_OUTPS_DEAL_SERIAL_NO.BROKERAGE%TYPE;
M_TOT_PRICE_INT_ACCR            DN_INV_OUTPS_DEAL_SERIAL_NO.PRICE_INT_ACCR%TYPE;
M_TOT_CARR_VAL                  DN_INV_OUTPS_DEAL_SERIAL_NO.CARR_VAL%TYPE;
M_TOT_COUP_INT_PURCH            DN_INV_OUTPS_DEAL_SERIAL_NO.COUP_INT_PURCH%TYPE;
M_TOT_COUP_INT_ACCR             DN_INV_OUTPS_DEAL_SERIAL_NO.COUP_INT_ACCR%TYPE;
M_TOT_TOT_COUP_INT              DN_INV_OUTPS_DEAL_SERIAL_NO.TOT_COUP_INT%TYPE;
M_TOT_FWD_SALE                  DN_INV_OUTPS_DEAL_SERIAL_NO.FWD_SALE%TYPE;
M_TOT_FWD_PURCHASE              DN_INV_OUTPS_DEAL_SERIAL_NO.FWD_PURCHASE%TYPE;
M_TOT_ALLO_REPO                 DN_INV_OUTPS_DEAL_SERIAL_NO.ALLO_REPO%TYPE;
M_TOT_ALLO_BL                   DN_INV_OUTPS_DEAL_SERIAL_NO.ALLO_BL%TYPE;
M_TOT_FWD_ALLO_REPO             DN_INV_OUTPS_DEAL_SERIAL_NO.FWD_ALLO_REPO%TYPE;
M_TOT_FWD_ALLO_BL               DN_INV_OUTPS_DEAL_SERIAL_NO.FWD_ALLO_BL%TYPE;
M_SERIAL_NO                     DN_INV_OUTPS_DEAL_SERIAL_NO.SERIAL_NO%TYPE;
M_LOCATION                      DN_INV_OUTPS_DEAL_SERIAL_NO.LOCATION%TYPE;
M_SALE_DEAL_NO                  DN_INV_OUTPS_DEAL_SERIAL_NO.SALE_DEAL_NO%TYPE;
M_SERIAL_NO_STATUS              DN_INV_OUTPS_DEAL_SERIAL_NO.SERIAL_NO_STATUS%TYPE;
M_SALE_EFF_VALDATE              DN_INV_OUTPS_DEAL_SERIAL_NO.SALE_EFF_VALDATE%TYPE;
M_RET_DUE_DATE                  DN_INV_OUTPS_DEAL_SERIAL_NO.RET_DUE_DATE%TYPE;
M_FACE_VALUE                    DN_INV_OUTPS_DEAL_SERIAL_NO.FACE_VAL%TYPE;
M_COUNT                         NUMBER;
SR_INT_RATE_BASE_CODE           DN_TRN_OUTP_SALE.INT_RATE_BASE_CODE%TYPE;--BY NIRMALA
SRTOT_FACE_VAL                  DN_INV_OUTPS_DEAL_SERIAL_NO.FACE_VAL%TYPE;--BY NIRMALA
SRTOT_CARR_VAL                  DN_INV_OUTPS_DEAL_SERIAL_NO.FACE_VAL%TYPE;--BY NIRMALA
M_EFF_VALDATE                   DN_INV_OUTPS_DEAL_SERIAL_NO.EFF_VALDATE%TYPE;--BY NIRMALA
M_SWAP_ENT_DATE                 DATE;--BY NIRMALA

BEGIN


   OPEN SWP_RECEIPTS;

   LOOP

      FETCH  SWP_RECEIPTS INTO

          M_PORTFOLIO_CODE,
          M_INST_TYPE,
          M_SECURITY_CODE,
          M_DEAL_NO,
          M_SERIAL_NO,
          M_LOCATION,
          M_SALE_DEAL_NO,
          M_SERIAL_NO_STATUS,
          M_SALE_EFF_VALDATE,
          M_RET_DUE_DATE,
          M_FACE_VALUE;--,
         -- M_EFF_VALDATE;---ADDED BY NIRMALA


      EXIT WHEN SWP_RECEIPTS%NOTFOUND;
----------------------------------------------------------------------------
---ADDED BY NIRMALA (THE CORRECT WAY OF CALCULATING WEIGHTED AVERAGE YIELD)
-----------------------------------------------------------------------------


        SELECT  NVL(SUM(A.FACE_VAL),0),NVL(SUM(A.CARR_VAL),0),TO_DATE(TO_CHAR(B.ENTDATE,'DD-MON-YYYY'),'DD-MON-YYYY')
        INTO    SRTOT_FACE_VAL,SRTOT_CARR_VAL,M_SWAP_ENT_DATE
        FROM    DN_INV_OUTPS_DEAL_SERIAL_NO A,
                DN_TRN_BO_INV_SWAP B
        WHERE   B.INV_SWAP_NO=M_INV_SWAP_NO  AND
                B.INV_CODE='OR'  AND
                B.TRANS_TYPE='I'  AND
                B.PORTFOLIO_CODE=A.PORTFOLIO_CODE   AND
                B.INST_TYPE=A.INST_TYPE   AND
                B.SECURITY_CODE=A.SECURITY_CODE AND
                B.DEAL_NO=A.DEAL_NO  AND
                B.SERIAL_NO=A.SERIAL_NO AND
               -- A. EFF_VALDATE<=M_EFF_VALDATE AND
                --(A.SALE_EFF_VALDATE IS NULL OR A.SALE_EFF_VALDATE>M_EFF_VALDATE) AND
                A. SECURITY_CODE=M_SECURITY_CODE AND
                A.PORTFOLIO_CODE=M_PORTFOLIO_CODE
       GROUP BY TO_DATE(TO_CHAR(B.ENTDATE,'DD-MON-YYYY'),'DD-MON-YYYY') ;




    /*  SELECT  NVL(SUM(FACE_VAL),0),NVL(SUM(CARR_VAL),0)
     INTO    SRTOT_FACE_VAL,SRTOT_CARR_VAL
     FROM    DN_INV_OUTPS_DEAL_SERIAL_NO
     WHERE   EFF_VALDATE<=M_EFF_VALDATE AND
            (SALE_EFF_VALDATE IS NULL OR SALE_EFF_VALDATE>M_EFF_VALDATE) AND
            SECURITY_CODE=M_SECURITY_CODE AND
            PORTFOLIO_CODE=M_PORTFOLIO_CODE AND
            SCRIP_STATUS='SC' ;*/


          /*  SELECT DISTINCT INT_RATE_BASE_CODE
            INTO   SR_INT_RATE_BASE_CODE
            FROM   DN_TRN_OUTP_SALE
            WHERE  BUY_PORTFOLIO_CODE=M_PORTFOLIO_CODE AND
                   SECURITY_CODE=M_SECURITY_CODE AND
                   DEAL_NO=M_DEAL_NO;*/

----------------------------------------------------------
-----------------------------------------------------------

       SELECT
          SUM(FACE_VAL),
          --(SUM(A.DEAL_YIELD*A.FACE_VAL))/SUM(FACE_VAL),-- BY NIRMALA
          --(SUM(A.YIELD_WITH_BROKERAGE*A.FACE_VAL))/SUM(FACE_VAL),-- BY NIRMALA
          DN_FIN_YIELD_PRICE_CLEAN(M_SECURITY_CODE,((SRTOT_CARR_VAL)/(SRTOT_FACE_VAL))*100,M_SWAP_ENT_DATE,D.INT_RATE_BASE_CODE ), --BY NIRMALA
          DN_FIN_YIELD_PRICE_CLEAN(M_SECURITY_CODE,((SRTOT_CARR_VAL)/(SRTOT_FACE_VAL))*100,M_SWAP_ENT_DATE,D.INT_RATE_BASE_CODE ), --BY NIRMALA
          SUM(A.INITIAL_COST),
          SUM(A.BROKERAGE),
          SUM(A.PRICE_INT_ACCR),
          SUM(A.CARR_VAL),
          SUM(A.COUP_INT_PURCH),
          SUM(A.COUP_INT_ACCR),
          SUM(A.TOT_COUP_INT),
          SUM(A.FWD_SALE),
          SUM(A.FWD_PURCHASE),
          SUM(A.ALLO_REPO),
          SUM(A.ALLO_BL),
          SUM(A.FWD_ALLO_REPO),
          SUM(A.FWD_ALLO_BL),
          D.INT_RATE_BASE_CODE
          INTO
          M_TOT_FACE_VAL,
          M_TOT_DEAL_YIELD,
          M_TOT_YIELD_WITH_BROKERAGE,
          M_TOT_INITIAL_COST,
          M_TOT_BROKERAGE,
          M_TOT_PRICE_INT_ACCR,
          M_TOT_CARR_VAL,
          M_TOT_COUP_INT_PURCH,
          M_TOT_COUP_INT_ACCR,
          M_TOT_TOT_COUP_INT,
          M_TOT_FWD_SALE,
          M_TOT_FWD_PURCHASE,
          M_TOT_ALLO_REPO,
          M_TOT_ALLO_BL,
          M_TOT_FWD_ALLO_REPO,
          M_TOT_FWD_ALLO_BL,
          SR_INT_RATE_BASE_CODE
       FROM
          DN_INV_OUTPS_DEAL_SERIAL_NO A,
          DN_TRN_BO_INV_SWAP B,
          DN_TRN_OUTP_SALE D

       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.INV_CODE='OR'
          AND
          B.TRANS_TYPE='I'
          AND
          B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
          AND
          B.INST_TYPE=A.INST_TYPE
          AND
          B.SECURITY_CODE=A.SECURITY_CODE
          AND
          B.DEAL_NO=A.DEAL_NO
          AND
          B.SERIAL_NO=A.SERIAL_NO
          AND
          B.DEAL_NO=D.DEAL_NO
          GROUP BY D.INT_RATE_BASE_CODE;


       SELECT COUNT(*) INTO M_COUNT
       FROM DN_INV_OUTPS_DEAL_SEC
       WHERE DEAL_NO=M_DEAL_NO ;

       IF M_COUNT=0 THEN

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
            COUP_INT_PURCH ,
            COUP_INT_ACCR ,
            TOT_COUP_INT,
            FWD_SALE,
            FWD_PURCHASE,
            LOCATION,
            ALLO_REPO ,
            ALLO_BL,
            FWD_ALLO_REPO,
            FWD_ALLO_BL,
            RET_DUE_DATE
           )
         SELECT
            M_PORTFOLIO_CODE,
            TO_DATE(TO_CHAR(SYSDATE,'DD-MM-YYYY'),'DD-MM-YYYY'),
            M_INST_TYPE,
            M_SECURITY_CODE,
            'B',
            M_DEAL_NO,
            M_TOT_DEAL_YIELD,
            M_TOT_YIELD_WITH_BROKERAGE,
            0, --CHANGED FROM 'M_FACE_VALUE' BY SM ON 28/12/99
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            M_LOCATION,
            0,
            0,
            0,
            0,
            M_RET_DUE_DATE
         FROM
            DUAL;

       END IF;

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
          COUP_INT_PURCH ,
          COUP_INT_ACCR ,
          TOT_COUP_INT,
          FWD_SALE,
          FWD_PURCHASE,
          LOCATION,
          ALLO_REPO ,
          ALLO_BL,
          FWD_ALLO_REPO,
          FWD_ALLO_BL,
          SALE_DEAL_NO,
          SERIAL_NO_STATUS,
          SALE_EFF_VALDATE,
          RET_DUE_DATE
         )
       SELECT
          M_PORTFOLIO_CODE,
          TO_DATE(TO_CHAR(SYSDATE,'DD-MM-YYYY'),'DD-MM-YYYY'),
          M_INST_TYPE,
          M_SECURITY_CODE,
          M_DEAL_NO,
          M_SERIAL_NO,
          M_TOT_DEAL_YIELD,
          M_TOT_YIELD_WITH_BROKERAGE,
          M_FACE_VALUE,
          M_FACE_VALUE,
          M_TOT_INITIAL_COST*(M_FACE_VALUE/M_TOT_FACE_VAL),
          M_TOT_BROKERAGE*(M_FACE_VALUE/M_TOT_FACE_VAL),
          M_TOT_PRICE_INT_ACCR*(M_FACE_VALUE/M_TOT_FACE_VAL),
          M_TOT_CARR_VAL*(M_FACE_VALUE/M_TOT_FACE_VAL),
          M_TOT_COUP_INT_PURCH*(M_FACE_VALUE/M_TOT_FACE_VAL),
          M_TOT_COUP_INT_ACCR*(M_FACE_VALUE/M_TOT_FACE_VAL),
          M_TOT_TOT_COUP_INT*(M_FACE_VALUE/M_TOT_FACE_VAL),
          M_TOT_FWD_SALE*(M_FACE_VALUE/M_TOT_FACE_VAL),
          M_TOT_FWD_PURCHASE*(M_FACE_VALUE/M_TOT_FACE_VAL),
          M_LOCATION,
          M_TOT_ALLO_REPO*(M_FACE_VALUE/M_TOT_FACE_VAL),
          M_TOT_ALLO_BL*(M_FACE_VALUE/M_TOT_FACE_VAL),
          M_TOT_FWD_ALLO_REPO*(M_FACE_VALUE/M_TOT_FACE_VAL),
          M_TOT_FWD_ALLO_BL*(M_FACE_VALUE/M_TOT_FACE_VAL),
          M_SALE_DEAL_NO,
          M_SERIAL_NO_STATUS,
          M_SALE_EFF_VALDATE,
          M_RET_DUE_DATE
       FROM
          DUAL;


   END LOOP;

   OPEN SWP_ISSUES;

   LOOP

      FETCH  SWP_ISSUES INTO

          M_PORTFOLIO_CODE,
          M_INST_TYPE,
          M_SECURITY_CODE,
          M_DEAL_NO,
          M_SERIAL_NO;


      EXIT WHEN SWP_ISSUES%NOTFOUND;


      UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
      SET SERIAL_NO_STATUS='SWP',
           SALE_EFF_VALDATE=TO_DATE(TO_CHAR(SYSDATE,'DD-MM-YYYY'),'DD-MM-YYYY')
      WHERE
          PORTFOLIO_CODE=M_PORTFOLIO_CODE
          AND
          INST_TYPE=M_INST_TYPE
          AND
          SECURITY_CODE=M_SECURITY_CODE
          AND
          DEAL_NO=M_DEAL_NO
          AND
          SERIAL_NO=M_SERIAL_NO;

   END LOOP;


----INSERT IN TO OUTRIGHT MAIN TRANSACTION TABLE -- INTEREST RATE BASE -- DAY END ROUTINE
----INSERTED BY SM / TDS ON 29/12/1999

          INSERT INTO DN_TRN_OUTP_SALE
          (DEAL_NO,
  	       BUY_PORTFOLIO_CODE,
           SELL_PORTFOLIO_CODE,
  	       INST_TYPE,
	       SECURITY_CODE,
	       ENDOSER_CODE,
	       CURR_CODE,
	       EFF_VALDATE_TYPE,
	       EFF_VALDATE,
	       INT_RATE_BASE_CODE,
	       YIELD,
	       SETTLE_VALUE,
	       PRICE_CLEAN,
	       FACE_VALUE,
	       PRICE_DIRTY,
	       ACC_INT,
	       COST,
           DN_USER,
           APP_STATUS)

          SELECT
           M_INV_SWAP_NO,
  	       BUY_PORTFOLIO_CODE,
           SELL_PORTFOLIO_CODE,
  	       INST_TYPE,
	       SECURITY_CODE,
	       ENDOSER_CODE,
	       CURR_CODE,
	       EFF_VALDATE_TYPE,
	       TO_DATE(TO_CHAR(SYSDATE,'DD-MM-YYYY'),'DD-MM-YYYY'),
	       INT_RATE_BASE_CODE,
	       1,
	       1,
	       1,
	       1,
	       1,
	       1,
	       1,
           DN_USER,
           'CONF'
          FROM
           DN_TRN_OUTP_SALE
          WHERE
           DEAL_NO=M_DEAL_NO;


END DN_BO_INV_SWAPS_OR;

/
