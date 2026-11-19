--------------------------------------------------------
--  DDL for Procedure DN_NOPORT_HOLDING_LISTALLALL_E
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_NOPORT_HOLDING_LISTALLALL_E" (
  M_INVTYPE  IN VARCHAR2,
  M_FROMDATE IN VARCHAR2,
  M_TODATE   IN VARCHAR2,
  M_INST     IN VARCHAR2,
    M_SCRIPT_STATUS    IN DN_TRN_OUTP_SALE.SCRIPT_STATUS%TYPE

)
IS


CURSOR  HOLDLST IS
SELECT
       TO_CHAR(AA.EFFVALDATE,'DD-MON-YYYY')X1,AA.DEALNO X2,'BUYSETTLECOMMENT' X3,AA.ISSUER X4,AA.SECURITY X5,AA.OUTPCOST X6,AA.FACEVALUE X7,AA.YEILD X8,
       TO_CHAR(AA.MATURITYDATE,'DD-MON-YYYY')X9,AA.SEC X10,AA.SER X11,AA.PRICEACCR X12,AA.COUPONACCR X13,AA.DN_USER X14,AA.LOCATION X15,AA.INST_TYPE X16,
       AA.COUPON_INT X17,TO_CHAR(BB.WW,'DD-MON-YYYY')X18, EXT_CODE X19,AA.PORTFOLIO_CODE X20

       FROM  (SELECT
                   A.DEAL_NO DEALNO,
                   DN_GET_ISSUER(D.ISSUER_CODE) ISSUER,
                   A.EFF_VALDATE EFFVALDATE,
                   A.SECURITY_CODE SECURITY,
                   A.YIELD_WITH_BROKERAGE YEILD,
                   A.FACE_VAL FACEVALUE,
                   (A.INITIAL_COST+A.BROKERAGE) OUTPCOST,
                   D.MATURITY_DATE MATURITYDATE,
                   A.SECURITY_CODE SEC,
                   A.SERIAL_NO SER,
                   /*DN_GET_OUTRIGHT_P_ACCR_INTR(
                            DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                            A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,B.INT_RATE_BASE_CODE,(A.INITIAL_COST+A.BROKERAGE))PRICEACCR,
                   DN_GET_OUTRIGHT_C_ACCR_INTR(
                            DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                            A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,B.INT_RATE_BASE_CODE)COUPONACCR,
									 */
									 0 PRICEACCR,
                   0 COUPONACCR,

                   B.DN_USER DN_USER,
                   A.LOCATION LOCATION,
                   D.COUPON_INT,
                   A.INST_TYPE INST_TYPE,
                   DN_EXT_SECURITY(A.SECURITY_CODE) EXT_CODE,A.PORTFOLIO_CODE PORTFOLIO_CODE


              FROM DN_INV_OUTPS_DEAL_SERIAL_NO A,
                   DN_TRN_OUTP_SALE B,
                   DN_REF_SECURITY D

             WHERE A.PORTFOLIO_CODE LIKE '%' AND
                   ((TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')>TO_DATE(M_FROMDATE,'DD-MM-YYYY'))OR
                    (A.SALE_EFF_VALDATE IS NULL))AND
                   TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD-MON-YYYY'),'DD-MON-YYYY') <= TO_DATE(M_TODATE,'DD-MM-YYYY')AND
                   A.FACE_VAL_CURR IS NULL AND
                  (A.DEAL_NO=B.DEAL_NO) AND
                  (A.SECURITY_CODE=D.SECURITY_CODE) AND
                  (B.APP_STATUS <> 'CANCEL')AND
                  DN_GET_INSTRUMENT_CAT(A.INST_TYPE) = 'EQUITY' AND
                  TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY') > TO_DATE(M_FROMDATE,'DD-MM-YYYY')AND
                  A.INST_TYPE LIKE '%' AND
                A.SCRIP_STATUS  ='SL'
                AND A.SERIAL_NO_STATUS IN ('INV','SND','SAD','MAT','TRF')

            UNION ALL

            SELECT
                 A.DEAL_NO DEALNO,
                 DN_GET_ISSUER(D.ISSUER_CODE) ISSUER,
                 A.EFF_VALDATE EFFVALDATE,
                 A.SECURITY_CODE SECURITY,
                 A.YIELD_WITH_BROKERAGE YEILD,
                 A.FACE_VAL FACEVALUE,
                (A.INITIAL_COST+A.BROKERAGE) OUTPCOST,
                 D.MATURITY_DATE MATURITYDATE,
                 A.SECURITY_CODE SEC,
                 A.SERIAL_NO SER,
                 /*DN_GET_OUTRIGHT_P_ACCR_INTR(
                     DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                     A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,B.INT_RATE_BASE_CODE,(A.INITIAL_COST+A.BROKERAGE))PRICEACCR,
                 DN_GET_OUTRIGHT_C_ACCR_INTR(
                     DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                     A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,B.INT_RATE_BASE_CODE)COUPONACCR,
                 */
									 0 PRICEACCR,
                   0 COUPONACCR,
									B.DN_USER  DN_USER,
                 A.LOCATION LOCATION,
                 D.COUPON_INT,
                 A.INST_TYPE INST_TYPE,
                   DN_EXT_SECURITY(A.SECURITY_CODE) EXT_CODE,A.PORTFOLIO_CODE PORTFOLIO_CODE


           FROM DN_HIS_OUTPS_DEAL_SERIAL_NO A,
                DN_TRN_OUTP_SALE B,
                DN_REF_SECURITY D

          WHERE A.PORTFOLIO_CODE LIKE '%' AND
                ((TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')>TO_DATE(M_FROMDATE,'DD-MM-YYYY')) OR (A.SALE_EFF_VALDATE IS NULL))AND
                TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD-MON-YYYY'),'DD-MON-YYYY') <= TO_DATE(M_TODATE,'DD-MM-YYYY')AND
                A.FACE_VAL_CURR IS NULL AND
                (A.DEAL_NO=B.DEAL_NO) AND
                (A.SECURITY_CODE=D.SECURITY_CODE)AND
                (B.APP_STATUS <> 'CANCEL')AND
                DN_GET_INSTRUMENT_CAT(A.INST_TYPE) = 'EQUITY' AND
                 TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY') > TO_DATE(M_FROMDATE,'DD-MM-YYYY')AND
                A.INST_TYPE LIKE '%' AND
                A.SCRIP_STATUS ='SL'
                AND A.SERIAL_NO_STATUS IN ('INV','SND','SAD','MAT','TRF')


                UNION ALL
                SELECT
                   A.DEAL_NO DEALNO,
                   DN_GET_ISSUER(D.ISSUER_CODE) ISSUER,
                   A.EFF_VALDATE EFFVALDATE,
                   A.SECURITY_CODE SECURITY,
                   A.YIELD_WITH_BROKERAGE YEILD,
                   A.FACE_VAL FACEVALUE,
                   (A.INITIAL_COST+A.BROKERAGE) OUTPCOST,
                   D.MATURITY_DATE MATURITYDATE,
                   A.SECURITY_CODE SEC,
                   A.SERIAL_NO SER,
                   /*DN_GET_OUTRIGHT_P_ACCR_INTR(
                            DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                            A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,'A365',(A.INITIAL_COST+A.BROKERAGE))PRICEACCR,
                   DN_GET_OUTRIGHT_C_ACCR_INTR(
                            DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                            A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,'A365')COUPONACCR,
                  */
									 0 PRICEACCR,
                   0 COUPONACCR,
									RET_HOLDINGLIST_USER(A.DEAL_NO) DN_USER,
                   A.LOCATION LOCATION,
                   D.COUPON_INT,
                   A.INST_TYPE INST_TYPE,
                   DN_EXT_SECURITY(A.SECURITY_CODE) EXT_CODE,A.PORTFOLIO_CODE PORTFOLIO_CODE


              FROM DN_INV_OUTPS_DEAL_SERIAL_NO A,
                   --DN_TRN_SCRIPLESS_TRANSFERS B,
                   DN_REF_SECURITY D

             WHERE A.PORTFOLIO_CODE LIKE '%' AND
                   ((TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')>TO_DATE(M_FROMDATE,'DD-MM-YYYY'))OR
                    (A.SALE_EFF_VALDATE IS NULL))AND
                   TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD-MON-YYYY'),'DD-MON-YYYY') <= TO_DATE(M_TODATE,'DD-MM-YYYY')AND
                   A.FACE_VAL_CURR IS NULL AND
                  --(A.DEAL_NO=B.DEAL_NO) AND
                  (A.SECURITY_CODE=D.SECURITY_CODE) AND
                  --(B.APP_STATUS <> 'CANCEL')AND
                  DN_GET_INSTRUMENT_CAT(A.INST_TYPE) = 'EQUITY' AND
                  TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY') > TO_DATE(M_FROMDATE,'DD-MM-YYYY')AND
                  A.INST_TYPE LIKE '%' AND
                A.SCRIP_STATUS  ='SL'
                AND A.SERIAL_NO_STATUS IN ('INV','SND','SAD','MAT','TRF')
                 AND A.DEAL_NO LIKE 'TS%'

            UNION ALL

            SELECT
                A.DEAL_NO DEALNO,
                 DN_GET_ISSUER(D.ISSUER_CODE) ISSUER,
                 A.EFF_VALDATE EFFVALDATE,
                 A.SECURITY_CODE SECURITY,
                 A.YIELD_WITH_BROKERAGE YEILD,
                 A.FACE_VAL FACEVALUE,
                (A.INITIAL_COST+A.BROKERAGE) OUTPCOST,
                 D.MATURITY_DATE MATURITYDATE,
                 A.SECURITY_CODE SEC,
                 A.SERIAL_NO SER,
                 /*DN_GET_OUTRIGHT_P_ACCR_INTR(
                     DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                     A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,'A365',(A.INITIAL_COST+A.BROKERAGE))PRICEACCR,
                 DN_GET_OUTRIGHT_C_ACCR_INTR(
                     DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                     A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,'A365')COUPONACCR,
                 */
									 0 PRICEACCR,
                   0 COUPONACCR,
									RET_HOLDINGLIST_USER(A.DEAL_NO) DN_USER,
                 A.LOCATION LOCATION,
                 D.COUPON_INT,
                 A.INST_TYPE INST_TYPE,
                   DN_EXT_SECURITY(A.SECURITY_CODE) EXT_CODE,A.PORTFOLIO_CODE PORTFOLIO_CODE


           FROM DN_HIS_OUTPS_DEAL_SERIAL_NO A,
                --DN_TRN_SCRIPLESS_TRANSFERS B,
                DN_REF_SECURITY D

          WHERE A.PORTFOLIO_CODE LIKE '%' AND
                ((TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')>TO_DATE(M_FROMDATE,'DD-MM-YYYY')) OR (A.SALE_EFF_VALDATE IS NULL))AND
                TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD-MON-YYYY'),'DD-MON-YYYY') <= TO_DATE(M_TODATE,'DD-MM-YYYY')AND
                A.FACE_VAL_CURR IS NULL AND
                --(A.DEAL_NO=B.DEAL_NO) AND
                (A.SECURITY_CODE=D.SECURITY_CODE)AND
               -- (B.APP_STATUS <> 'CANCEL')AND
                DN_GET_INSTRUMENT_CAT(A.INST_TYPE) = 'EQUITY' AND
                  TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY') > TO_DATE(M_FROMDATE,'DD-MM-YYYY')AND
                A.INST_TYPE LIKE '%' AND
                A.SCRIP_STATUS  ='SL'
                AND A.SERIAL_NO_STATUS IN ('INV','SND','SAD','MAT','TRF')
                 AND A.DEAL_NO LIKE 'TS%'

               --FOR  SCRIP --------------
              UNION ALL
              SELECT
                   A.DEAL_NO DEALNO,
                   DN_GET_ISSUER(D.ISSUER_CODE) ISSUER,
                   A.EFF_VALDATE EFFVALDATE,
                   A.SECURITY_CODE SECURITY,
                   A.YIELD_WITH_BROKERAGE YEILD,
                   A.FACE_VAL FACEVALUE,
                   (A.INITIAL_COST+A.BROKERAGE) OUTPCOST,
                   D.MATURITY_DATE MATURITYDATE,
                   A.SECURITY_CODE SEC,
                   A.SERIAL_NO SER,
                   /*DN_GET_OUTRIGHT_P_ACCR_INTR(
                            DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                            A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,B.INT_RATE_BASE_CODE,(A.INITIAL_COST+A.BROKERAGE))PRICEACCR,
                   DN_GET_OUTRIGHT_C_ACCR_INTR(
                            DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                            A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,B.INT_RATE_BASE_CODE)COUPONACCR,
                   */
									 0 PRICEACCR,
                   0 COUPONACCR,
										B.DN_USER DN_USER,
                   A.LOCATION LOCATION,
                   D.COUPON_INT,
                   A.INST_TYPE INST_TYPE,
                   DN_EXT_SECURITY(A.SECURITY_CODE) EXT_CODE,A.PORTFOLIO_CODE PORTFOLIO_CODE


              FROM DN_INV_OUTPS_DEAL_SERIAL_NO A,
                   DN_TRN_OUTP_SALE B,
                   DN_REF_SECURITY D

             WHERE A.PORTFOLIO_CODE LIKE '%' AND
                   ((TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')>TO_DATE(M_FROMDATE,'DD-MM-YYYY'))OR
                    (A.SALE_EFF_VALDATE IS NULL))AND
                   TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD-MON-YYYY'),'DD-MON-YYYY') <= TO_DATE(M_TODATE,'DD-MM-YYYY')AND
                   A.FACE_VAL_CURR IS NULL AND
                  (A.DEAL_NO=B.DEAL_NO) AND
                  (A.SECURITY_CODE=D.SECURITY_CODE) AND
                  (B.APP_STATUS <> 'CANCEL')AND
                  DN_GET_INSTRUMENT_CAT(A.INST_TYPE) = 'EQUITY' AND
                  TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY') > TO_DATE(M_FROMDATE,'DD-MM-YYYY')AND
                  A.INST_TYPE LIKE '%' AND
                A.SCRIP_STATUS = 'SC'
                AND A.SERIAL_NO_STATUS IN ('INV','SND','SAD','MAT','SWP','TRF')
                AND A.DEAL_NO NOT LIKE 'IS%' --ADDED BY NIRMALA ON 17-03-2004


            UNION ALL

            SELECT
                 A.DEAL_NO DEALNO,
                 DN_GET_ISSUER(D.ISSUER_CODE) ISSUER,
                 A.EFF_VALDATE EFFVALDATE,
                 A.SECURITY_CODE SECURITY,
                 A.YIELD_WITH_BROKERAGE YEILD,
                 A.FACE_VAL FACEVALUE,
                (A.INITIAL_COST+A.BROKERAGE) OUTPCOST,
                 D.MATURITY_DATE MATURITYDATE,
                 A.SECURITY_CODE SEC,
                 A.SERIAL_NO SER,
                 /*DN_GET_OUTRIGHT_P_ACCR_INTR(
                     DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                     A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,B.INT_RATE_BASE_CODE,(A.INITIAL_COST+A.BROKERAGE))PRICEACCR,
                 DN_GET_OUTRIGHT_C_ACCR_INTR(
                     DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                     A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,B.INT_RATE_BASE_CODE)COUPONACCR,
                 */
									 0 PRICEACCR,
                   0 COUPONACCR,
										B.DN_USER  DN_USER,
                 A.LOCATION LOCATION,
                 D.COUPON_INT,
                 A.INST_TYPE INST_TYPE,
                   DN_EXT_SECURITY(A.SECURITY_CODE) EXT_CODE,A.PORTFOLIO_CODE PORTFOLIO_CODE


           FROM DN_HIS_OUTPS_DEAL_SERIAL_NO A,
                DN_TRN_OUTP_SALE B,
                DN_REF_SECURITY D

          WHERE A.PORTFOLIO_CODE LIKE '%' AND
                ((TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')>TO_DATE(M_FROMDATE,'DD-MM-YYYY')) OR (A.SALE_EFF_VALDATE IS NULL))AND
                TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD-MON-YYYY'),'DD-MON-YYYY') <= TO_DATE(M_TODATE,'DD-MM-YYYY')AND
                A.FACE_VAL_CURR IS NULL AND
                (A.DEAL_NO=B.DEAL_NO) AND
                (A.SECURITY_CODE=D.SECURITY_CODE)AND
                (B.APP_STATUS <> 'CANCEL')AND
                DN_GET_INSTRUMENT_CAT(A.INST_TYPE) = 'EQUITY' AND
                  TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY') > TO_DATE(M_FROMDATE,'DD-MM-YYYY')AND
                A.INST_TYPE LIKE '%' AND
                A.SCRIP_STATUS  = 'SC'
                AND A.SERIAL_NO_STATUS IN ('INV','SND','SAD','MAT','SWP','TRF')
                AND A.DEAL_NO NOT LIKE 'IS%' --ADDED BY NIRMALA ON 17-03-2004

 -------------------------




             )AA,

     (SELECT    /*+INDEX (DN_TRN_BO_INV_RECEIPT  IDX_DN_TRN_BO_INV_RECEIPT)*/DEAL_NO RR,MAX(ENTDATE)WW
      FROM      DN_TRN_BO_INV_RECEIPT K
      GROUP BY  DEAL_NO )BB

 WHERE AA.DEALNO=BB.RR(+)

 UNION ALL
SELECT   TO_CHAR(AA.EFFVALDATE,'DD-MON-YYYY')X1,AA.DEALNO X2,'BUYSETTLECOMMENT' X3,AA.ISSUER X4,AA.SECURITY X5,AA.OUTPCOST X6,AA.FACEVALUE X7,AA.YEILD X8,
            TO_CHAR(AA.MATURITYDATE,'DD-MON-YYYY') X9,AA.SEC X10,AA.SER X11,AA.PRICEACCR X12,AA.COUPONACCR X13,AA.DN_USER X14,AA.LOCATION X15,AA.INST_TYPE X16,
            AA.COUPON_INT X17,NVL(null,'-')X18, EXT_CODE X19,AA.PORTFOLIO_CODE X20

            FROM  (SELECT  A.DEAL_NO DEALNO,
                           DN_GET_ISSUER(D.ISSUER_CODE) ISSUER,
                           A.EFF_VALDATE EFFVALDATE,
                           A.SECURITY_CODE SECURITY,
                           A.YIELD_WITH_BROKERAGE YEILD,
                           A.FACE_VAL FACEVALUE,
                          (A.INITIAL_COST+A.BROKERAGE) OUTPCOST,
                           D.MATURITY_DATE MATURITYDATE,
                           A.SECURITY_CODE SEC,
                           A.SERIAL_NO SER,
                           /*DN_GET_OUTRIGHT_P_ACCR_INTR(
                               DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                               A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,B.INT_RATE_BASE_CODE,(A.INITIAL_COST+A.BROKERAGE))PRICEACCR,
                           DN_GET_OUTRIGHT_C_ACCR_INTR(
                               DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                               A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,B.INT_RATE_BASE_CODE)COUPONACCR,
                           */
									 0 PRICEACCR,
                   0 COUPONACCR,
														B.DN_USER DN_USER,
                           A.LOCATION LOCATION,
                           D.COUPON_INT,
                           A.INST_TYPE INST_TYPE,
                   DN_EXT_SECURITY(A.SECURITY_CODE) EXT_CODE,A.PORTFOLIO_CODE PORTFOLIO_CODE


                     FROM  DN_INV_OUTPS_DEAL_SERIAL_NO A,
                           DN_TRN_OUTP_SALE B,
                           DN_REF_SECURITY D

                    WHERE  A.PORTFOLIO_CODE LIKE '%' AND
                           ((TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')>TO_DATE(M_FROMDATE,'DD-MM-YYYY'))
                             OR (A.SALE_EFF_VALDATE IS NULL))AND
                           TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD-MON-YYYY'),'DD-MON-YYYY') <= TO_DATE(M_TODATE,'DD-MM-YYYY')AND
                           A.FACE_VAL_CURR IS NULL AND
                           DN_GET_INSTRUMENT_CAT(A.INST_TYPE) = 'EQUITY' AND
                           (A.DEAL_NO=B.DEAL_NO)  AND
                           (A.SECURITY_CODE=D.SECURITY_CODE)AND
                           (B.APP_STATUS <> 'CANCEL')AND
                           TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY') > TO_DATE(M_FROMDATE,'DD-MM-YYYY')AND
                           A.INST_TYPE LIKE '%' AND
                A.SCRIP_STATUS  ='SL'
                AND A.SERIAL_NO_STATUS IN ('INV','SND','SAD','MAT','TRF')

                   UNION ALL

                   SELECT  A.DEAL_NO DEALNO,
                           DN_GET_ISSUER(D.ISSUER_CODE) ISSUER,
                           A.EFF_VALDATE EFFVALDATE,
                           A.SECURITY_CODE SECURITY,
                           A.YIELD_WITH_BROKERAGE YEILD,
                           A.FACE_VAL FACEVALUE,
                          (A.INITIAL_COST+A.BROKERAGE) OUTPCOST,
                           D.MATURITY_DATE MATURITYDATE,
                           A.SECURITY_CODE SEC,
                           A.SERIAL_NO SER,
                           /*DN_GET_OUTRIGHT_P_ACCR_INTR(
                                DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                                A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,B.INT_RATE_BASE_CODE,(A.INITIAL_COST+A.BROKERAGE))PRICEACCR,
                           DN_GET_OUTRIGHT_C_ACCR_INTR(
                                DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                                A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,B.INT_RATE_BASE_CODE)COUPONACCR,
                           */
									 0 PRICEACCR,
                   0 COUPONACCR,B.DN_USER  DN_USER,
                           A.LOCATION LOCATION,
                           D.COUPON_INT,
                           A.INST_TYPE INST_TYPE,
                   DN_EXT_SECURITY(A.SECURITY_CODE) EXT_CODE,A.PORTFOLIO_CODE PORTFOLIO_CODE


                     FROM  DN_HIS_OUTPS_DEAL_SERIAL_NO A,
                           DN_TRN_OUTP_SALE B,
                           DN_REF_SECURITY D

                     WHERE A.PORTFOLIO_CODE LIKE '%' AND
                           ((TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')>TO_DATE(M_FROMDATE,'DD-MM-YYYY')) OR (A.SALE_EFF_VALDATE IS NULL))AND
                           TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD-MON-YYYY'),'DD-MON-YYYY') <= TO_DATE(M_TODATE,'DD-MM-YYYY')AND
                           DN_GET_INSTRUMENT_CAT(A.INST_TYPE) = 'EQUITY' AND
                           A.FACE_VAL_CURR IS NULL  AND
                          (A.DEAL_NO=B.DEAL_NO) AND
                          (A.SECURITY_CODE=D.SECURITY_CODE)AND
                          (B.APP_STATUS <> 'CANCEL')AND
                           TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY') > TO_DATE(M_FROMDATE,'DD-MM-YYYY')AND
                           A.INST_TYPE LIKE '%' AND
                A.SCRIP_STATUS  ='SL'
                AND A.SERIAL_NO_STATUS IN ('INV','SND','SAD','MAT','TRF')

                UNION ALL

                SELECT     A.DEAL_NO DEALNO,
                           DN_GET_ISSUER(D.ISSUER_CODE) ISSUER,
                           A.EFF_VALDATE EFFVALDATE,
                           A.SECURITY_CODE SECURITY,
                           A.YIELD_WITH_BROKERAGE YEILD,
                           A.FACE_VAL FACEVALUE,
                          (A.INITIAL_COST+A.BROKERAGE) OUTPCOST,
                           D.MATURITY_DATE MATURITYDATE,
                           A.SECURITY_CODE SEC,
                           A.SERIAL_NO SER,
                           /*DN_GET_OUTRIGHT_P_ACCR_INTR(
                               DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                               A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,'A365',(A.INITIAL_COST+A.BROKERAGE))PRICEACCR,
                           DN_GET_OUTRIGHT_C_ACCR_INTR(
                               DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                               A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,'A365')COUPONACCR,
                           */
									 0 PRICEACCR,
                   0 COUPONACCR,
										RET_HOLDINGLIST_USER(A.DEAL_NO) DN_USER,
                           A.LOCATION LOCATION,
                           D.COUPON_INT,
                           A.INST_TYPE INST_TYPE,
                   DN_EXT_SECURITY(A.SECURITY_CODE) EXT_CODE,A.PORTFOLIO_CODE PORTFOLIO_CODE


                     FROM  DN_INV_OUTPS_DEAL_SERIAL_NO A,
                           --DN_TRN_SCRIPLESS_TRANSFERS B,
                           DN_REF_SECURITY D

                    WHERE  A.PORTFOLIO_CODE LIKE '%' AND
                           ((TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')>TO_DATE(M_FROMDATE,'DD-MM-YYYY'))
                             OR (A.SALE_EFF_VALDATE IS NULL))AND
                           TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD-MON-YYYY'),'DD-MON-YYYY') <= TO_DATE(M_TODATE,'DD-MM-YYYY')AND
                           A.FACE_VAL_CURR IS NULL AND
                           DN_GET_INSTRUMENT_CAT(A.INST_TYPE) = 'EQUITY' AND
                           --(A.DEAL_NO=B.DEAL_NO)  AND
                           (A.SECURITY_CODE=D.SECURITY_CODE)AND
                          -- (B.APP_STATUS <> 'CANCEL')AND
                           TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY') > TO_DATE(M_FROMDATE,'DD-MM-YYYY')AND
                           A.INST_TYPE LIKE '%' AND
                A.SCRIP_STATUS ='SL'
                AND A.SERIAL_NO_STATUS IN ('INV','SND','SAD','MAT','TRF')
                 AND A.DEAL_NO LIKE 'TS%'

                   UNION ALL

                   SELECT  A.DEAL_NO DEALNO,
                           DN_GET_ISSUER(D.ISSUER_CODE) ISSUER,
                           A.EFF_VALDATE EFFVALDATE,
                           A.SECURITY_CODE SECURITY,
                           A.YIELD_WITH_BROKERAGE YEILD,
                           A.FACE_VAL FACEVALUE,
                          (A.INITIAL_COST+A.BROKERAGE) OUTPCOST,
                           D.MATURITY_DATE MATURITYDATE,
                           A.SECURITY_CODE SEC,
                           A.SERIAL_NO SER,
                           /*DN_GET_OUTRIGHT_P_ACCR_INTR(
                                DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                                A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,'A365',(A.INITIAL_COST+A.BROKERAGE))PRICEACCR,
                           DN_GET_OUTRIGHT_C_ACCR_INTR(
                                DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                                A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,'A365')COUPONACCR,
                           */
									 0 PRICEACCR,
                   0 COUPONACCR,
										RET_HOLDINGLIST_USER(A.DEAL_NO) DN_USER,
                           A.LOCATION LOCATION,
                           D.COUPON_INT,
                           A.INST_TYPE INST_TYPE,
                   DN_EXT_SECURITY(A.SECURITY_CODE) EXT_CODE,A.PORTFOLIO_CODE PORTFOLIO_CODE


                     FROM  DN_HIS_OUTPS_DEAL_SERIAL_NO A,
                           --DN_TRN_SCRIPLESS_TRANSFERS B,
                           DN_REF_SECURITY D

                     WHERE A.PORTFOLIO_CODE LIKE '%' AND
                           ((TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')>TO_DATE(M_FROMDATE,'DD-MM-YYYY')) OR (A.SALE_EFF_VALDATE IS NULL))AND
                           TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD-MON-YYYY'),'DD-MON-YYYY') <= TO_DATE(M_TODATE,'DD-MM-YYYY')AND
                           A.FACE_VAL_CURR IS NULL  AND
                           DN_GET_INSTRUMENT_CAT(A.INST_TYPE) = 'EQUITY' AND
                            --(A.DEAL_NO=B.DEAL_NO) AND
                          (A.SECURITY_CODE=D.SECURITY_CODE)AND
                          --(B.APP_STATUS <> 'CANCEL')AND
                           TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY') > TO_DATE(M_FROMDATE,'DD-MM-YYYY')AND
                           A.INST_TYPE LIKE '%' AND
                A.SCRIP_STATUS  ='SL'
                AND A.SERIAL_NO_STATUS IN ('INV','SND','SAD','MAT','TRF')
                                 AND A.DEAL_NO LIKE 'TS%'

                  -----FOR SCRIP-------------
                  UNION ALL
                  SELECT  A.DEAL_NO DEALNO,
                           DN_GET_ISSUER(D.ISSUER_CODE) ISSUER,
                           A.EFF_VALDATE EFFVALDATE,
                           A.SECURITY_CODE SECURITY,
                           A.YIELD_WITH_BROKERAGE YEILD,
                           A.FACE_VAL FACEVALUE,
                          (A.INITIAL_COST+A.BROKERAGE) OUTPCOST,
                           D.MATURITY_DATE MATURITYDATE,
                           A.SECURITY_CODE SEC,
                           A.SERIAL_NO SER,
                           /*DN_GET_OUTRIGHT_P_ACCR_INTR(
                               DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                               A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,B.INT_RATE_BASE_CODE,(A.INITIAL_COST+A.BROKERAGE))PRICEACCR,
                           DN_GET_OUTRIGHT_C_ACCR_INTR(
                               DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                               A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,B.INT_RATE_BASE_CODE)COUPONACCR,
                           */
									 0 PRICEACCR,
                   0 COUPONACCR,
										B.DN_USER DN_USER,
                           A.LOCATION LOCATION,
                           D.COUPON_INT,
                           A.INST_TYPE INST_TYPE,
                   DN_EXT_SECURITY(A.SECURITY_CODE) EXT_CODE,A.PORTFOLIO_CODE PORTFOLIO_CODE


                     FROM  DN_INV_OUTPS_DEAL_SERIAL_NO A,
                           DN_TRN_OUTP_SALE B,
                           DN_REF_SECURITY D

                    WHERE  A.PORTFOLIO_CODE LIKE '%' AND
                           ((TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')>TO_DATE(M_FROMDATE,'DD-MM-YYYY'))
                             OR (A.SALE_EFF_VALDATE IS NULL))AND
                           TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD-MON-YYYY'),'DD-MON-YYYY') <= TO_DATE(M_TODATE,'DD-MM-YYYY')AND
                           A.FACE_VAL_CURR IS NULL AND
                           DN_GET_INSTRUMENT_CAT(A.INST_TYPE) = 'EQUITY' AND
                           (A.DEAL_NO=B.DEAL_NO)  AND
                           (A.SECURITY_CODE=D.SECURITY_CODE)AND
                           (B.APP_STATUS <> 'CANCEL')AND
                           TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY') > TO_DATE(M_FROMDATE,'DD-MM-YYYY')AND
                           A.INST_TYPE LIKE '%' AND
                A.SCRIP_STATUS  ='SC'
                AND A.SERIAL_NO_STATUS IN ('INV','SND','SAD','MAT','SWP','TRF')

                   UNION ALL

                   SELECT  A.DEAL_NO DEALNO,
                           DN_GET_ISSUER(D.ISSUER_CODE) ISSUER,
                           A.EFF_VALDATE EFFVALDATE,
                           A.SECURITY_CODE SECURITY,
                           A.YIELD_WITH_BROKERAGE YEILD,
                           A.FACE_VAL FACEVALUE,
                          (A.INITIAL_COST+A.BROKERAGE) OUTPCOST,
                           D.MATURITY_DATE MATURITYDATE,
                           A.SECURITY_CODE SEC,
                           A.SERIAL_NO SER,
                           /*DN_GET_OUTRIGHT_P_ACCR_INTR(
                                DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                                A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,B.INT_RATE_BASE_CODE,(A.INITIAL_COST+A.BROKERAGE))PRICEACCR,
                           DN_GET_OUTRIGHT_C_ACCR_INTR(
                                DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - TO_DATE(M_TODATE,'DD-MM-YYYY'))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),TO_DATE(M_TODATE,'DD-MM-YYYY')+1),
                                A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,B.INT_RATE_BASE_CODE)COUPONACCR,
                           */
									 0 PRICEACCR,
                   0 COUPONACCR,
										B.DN_USER  DN_USER,
                           A.LOCATION LOCATION,
                           D.COUPON_INT,
                           A.INST_TYPE INST_TYPE,
                   DN_EXT_SECURITY(A.SECURITY_CODE) EXT_CODE,A.PORTFOLIO_CODE PORTFOLIO_CODE


                     FROM  DN_HIS_OUTPS_DEAL_SERIAL_NO A,
                           DN_TRN_OUTP_SALE B,
                           DN_REF_SECURITY D

                     WHERE A.PORTFOLIO_CODE LIKE '%' AND
                           ((TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')>TO_DATE(M_FROMDATE,'DD-MM-YYYY')) OR (A.SALE_EFF_VALDATE IS NULL))AND
                           TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD-MON-YYYY'),'DD-MON-YYYY') <= TO_DATE(M_TODATE,'DD-MM-YYYY')AND
                           DN_GET_INSTRUMENT_CAT(A.INST_TYPE) = 'EQUITY' AND
                           A.FACE_VAL_CURR IS NULL  AND
                          (A.DEAL_NO=B.DEAL_NO) AND
                          (A.SECURITY_CODE=D.SECURITY_CODE)AND
                          (B.APP_STATUS <> 'CANCEL')AND
                           TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY') > TO_DATE(M_FROMDATE,'DD-MM-YYYY')AND
                           A.INST_TYPE LIKE '%' AND
                A.SCRIP_STATUS   ='SC'
                AND A.SERIAL_NO_STATUS IN ('INV','SND','SAD','MAT','SWP','TRF')


                  --------------------------

                    )AA

 WHERE  AA.DEALNO like 'IS%' ;
BEGIN

  DELETE FROM DN_TEMP_HOLDING_LIST;
  COMMIT;
  --------------------------------------------------------------------

  FOR I IN  HOLDLST
  LOOP

  INSERT INTO DN_TEMP_HOLDING_LIST
      (EFFVALDATE,DEALNO,STAT,ISSUER,SECURITY,OUTPCOST,FACEVALUE,YEILD,MATURITYDATE,
       SEC,SER,PRICEACCR,COUPONACCR,DN_USER,LOCATION,INST_TYPE,COUPON_INT,ENTERDATE,ISIN_CODE,PORTFOLIO_CODE)
  VALUES
      (I.X1,I.X2,I.X3,I.X4,I.X5,I.X6,I.X7,I.X8 ,I.X9,I.X10,I.X11,I.X12,I.X13,I.X14,
       I.X15,I.X16,I.X17,I.X18,I.X19,I.X20);
  COMMIT;

  END LOOP;
END;

/
