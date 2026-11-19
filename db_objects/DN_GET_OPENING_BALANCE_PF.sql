--------------------------------------------------------
--  DDL for Function DN_GET_OPENING_BALANCE_PF
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_OPENING_BALANCE_PF" 
(
 M_DATE                  VARCHAR2,
 M_PORTFOLIO_CODE        DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE
 )
 RETURN NUMBER
 AS
 

 MM_DATE     VARCHAR2(10);
 M_AMOUNT    NUMBER(18,4);
 --to get client pf balance



 BEGIN

M_AMOUNT := 0;
/*
SELECT LAST_DAILY ,least(LAST_DAILY ,to_date(M_DATE,'dd/mm/yyyy')) 
INTO M_LAST_DAILY,M_LDATE FROM DN_SYS_PARAMETER;
-- RAISE_APPLICATION_ERROR (-20001,M_PORTFOLIO_CODE);
SELECT SUM(FACE_VAL*MARKET_RATE)  INTO M_AMOUNT
FROM DN_REP_MARGIN_CALL A
WHERE PORTFOLIO_CODE=UPPER(M_PORTFOLIO_CODE)
AND TRN_DATE=M_LDATE;
*/

SELECT TO_CHAR(TO_DATE(M_DATE,'DD/MM/YYYY')-1,'DD/MM/YYYY') INTO MM_DATE FROM DUAL ;

SELECT SUM(MARKET_VLAUE) INTO M_AMOUNT  FROM (

SELECT RETURN_MARKET_VAL(X1,MM_DATE)*X3 MARKET_VLAUE FROM (
----------------------------------------------------------------------------------------------------

SELECT JK.X1,JK.X2,JK.X3,JK.X4,JK.X5,JK.X6,JK.X7,JK.X8,'UPPER' X9,JK.X10,JK.X11,JK.X12,JK.X13,JK.X14

 FROM
     (SELECT  A.SECURITY_CODE X1 ,TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY')X2,SUM(A.FACE_VAL)X3,
              SUM(A.INITIAL_COST+A.BROKERAGE)X4,
              DECODE(SUM(A.INITIAL_COST+A.BROKERAGE),0,0,SUM((A.INITIAL_COST+A.BROKERAGE)*A.DEAL_YIELD*100)/SUM(A.INITIAL_COST+A.BROKERAGE)) X5,
              ROUND(TO_NUMBER(B.MATURITY_DATE-TO_DATE(MM_DATE,'DD/MM/YYYY')),0)X6,
              DN_GET_COUPON_RATE(B.SECURITY_CODE)X7,
              TO_DATE(B.MATURITY_DATE,'DD-MON-YYYY')X8,PORTFOLIO_CODE X10,--
              SUM(A.PRICE_INT_ACCR) X11,
              SUM(A.TOT_COUP_INT) X12,
              SUM(A.CARR_VAL) X13,
              DN_GET_OR_SELLER(A.DEAL_NO) X14
      FROM    DN_INV_OUTPS_DEAL_SERIAL_NO A,
              DN_REF_SECURITY B
      WHERE   A.PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
              A.EFF_VALDATE   <= TO_DATE(MM_DATE,'DD/MM/YYYY') AND
              A.INST_TYPE LIKE '%' AND--=M_INST_TYPE AND
              A.SECURITY_CODE = B.SECURITY_CODE  AND
              (A.SERIAL_NO_STATUS = 'INV' OR ( A.SALE_EFF_VALDATE IS NULL) OR
                  (A.SALE_EFF_VALDATE>TO_DATE(MM_DATE,'DD/MM/YYYY'))  )AND
              B.MATURITY_DATE>= TO_DATE(MM_DATE,'DD/MM/YYYY')  AND
              B.ISSUE_DATE<= TO_DATE(MM_DATE,'DD/MM/YYYY') AND
              A.FACE_VAL>0 AND
              A.FACE_VAL_CURR IS NULL  AND
              A.SCRIP_STATUS LIKE '%'
    GROUP BY  A.PORTFOLIO_CODE,A.SECURITY_CODE,B.MATURITY_DATE,DN_GET_COUPON_RATE(B.SECURITY_CODE),
              DN_GET_OR_SELLER(A.DEAL_NO)

      UNION

      SELECT   C.SECURITY_CODE X1 ,TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),
               SUM(C.FACE_VAL),SUM(C.INITIAL_COST+C.BROKERAGE),
               DECODE(SUM(C.INITIAL_COST+C.BROKERAGE),0,0,SUM((C.INITIAL_COST+C.BROKERAGE)*C.DEAL_YIELD*100)/SUM(C.INITIAL_COST+C.BROKERAGE)),
               ROUND(TO_NUMBER(B.MATURITY_DATE-TO_DATE(MM_DATE,'DD/MM/YYYY')),0),DN_GET_COUPON_RATE(B.SECURITY_CODE)  ,TO_DATE(B.MATURITY_DATE,'DD-MON-YYYY'),C.PORTFOLIO_CODE,--
               SUM(C.PRICE_INT_ACCR) X11,
              SUM(C.TOT_COUP_INT) X12,
              SUM(C.CARR_VAL) X13,
              DN_GET_OR_SELLER(C.DEAL_NO) X14

         FROM  DN_REF_SECURITY B,
               DN_HIS_OUTPS_DEAL_SERIAL_NO C
      WHERE    C.PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
               C.EFF_VALDATE<=TO_DATE(MM_DATE,'DD/MM/YYYY') AND
               C.INST_TYPE LIKE '%' AND--=M_INST_TYPE AND
               C.SECURITY_CODE=B.SECURITY_CODE  AND
               (C.SERIAL_NO_STATUS='INV' OR ( C.SALE_EFF_VALDATE IS NULL) OR
                  (C.SALE_EFF_VALDATE>TO_DATE(MM_DATE,'DD/MM/YYYY'))  )AND
               B.MATURITY_DATE>= TO_DATE(MM_DATE,'DD/MM/YYYY')  AND
               B.ISSUE_DATE<= TO_DATE(MM_DATE,'DD/MM/YYYY') AND
               C.FACE_VAL>0 AND
               C.FACE_VAL_CURR IS NULL AND
               C.SCRIP_STATUS LIKE '%'
    GROUP BY   C.PORTFOLIO_CODE,C.SECURITY_CODE,B.MATURITY_DATE,DN_GET_COUPON_RATE(B.SECURITY_CODE),
              DN_GET_OR_SELLER(C.DEAL_NO)
    ) JK where JK.X1 NOT IN (
                            --######################################################################################
                                                    SELECT T1.sec X1
                                                    FROM
                                                         (SELECT  A.SECURITY_CODE sec,TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY') mat,SUM(A.FACE_VAL) a,SUM(A.INITIAL_COST+A.BROKERAGE) b ,DECODE(SUM(A.INITIAL_COST+A.BROKERAGE),0,0,SUM((A.INITIAL_COST+A.BROKERAGE)*A.DEAL_YIELD*100)/SUM(A.INITIAL_COST+A.BROKERAGE))  yeild,
                                                                  ROUND(TO_NUMBER(B.MATURITY_DATE-TO_DATE(MM_DATE,'DD/MM/YYYY')),0) days,DN_GET_COUPON_RATE(B.SECURITY_CODE)rate,
                                                                  DN_GET_OR_SELLER(A.DEAL_NO) X14
                                                       FROM    DN_INV_OUTPS_DEAL_SERIAL_NO A,DN_REF_SECURITY B

                                                       WHERE   A.PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                                                               A.EFF_VALDATE<=TO_DATE(MM_DATE,'DD/MM/YYYY') AND
                                                               A.INST_TYPE LIKE '%'  AND
                                                               A.SECURITY_CODE=B.SECURITY_CODE  AND
                                                               (A.SERIAL_NO_STATUS='INV' OR ( A.SALE_EFF_VALDATE IS NULL) OR
                                                                  (A.SALE_EFF_VALDATE>TO_DATE(MM_DATE,'DD/MM/YYYY')))AND
                                                               B.MATURITY_DATE>= TO_DATE(MM_DATE,'DD/MM/YYYY')  AND
                                                               B.ISSUE_DATE<= TO_DATE(MM_DATE,'DD/MM/YYYY') AND
                                                               A.FACE_VAL>0 AND
                                                               A.FACE_VAL_CURR IS NULL  AND
                                                               A.SCRIP_STATUS LIKE '%'
                                                   GROUP BY    A.PORTFOLIO_CODE,A.SECURITY_CODE,B.MATURITY_DATE,DN_GET_COUPON_RATE(B.SECURITY_CODE),
                                                          DN_GET_OR_SELLER(A.DEAL_NO)
                                                    )T1,

                                                       (SELECT  C.SECURITY_CODE sec,TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),
                                                                SUM(C.FACE_VAL) a,SUM(C.INITIAL_COST+C.BROKERAGE) b ,
                                                                DECODE(SUM(C.INITIAL_COST+C.BROKERAGE),0,0,SUM((C.INITIAL_COST+C.BROKERAGE)*C.DEAL_YIELD*100)/SUM(C.INITIAL_COST+C.BROKERAGE)) yeild,
                                                                ROUND(TO_NUMBER(B.MATURITY_DATE-TO_DATE(MM_DATE,'DD/MM/YYYY')),0),DN_GET_COUPON_RATE(B.SECURITY_CODE)rate
                                                        FROM    DN_REF_SECURITY B,
                                                                DN_HIS_OUTPS_DEAL_SERIAL_NO C

                                                        WHERE  C.PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                                                               TO_DATE(TO_CHAR(C.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')<=TO_DATE(MM_DATE,'DD/MM/YYYY') AND
                                                               C.INST_TYPE LIKE '%' AND--=M_INST_TYPE  AND
                                                               C.SECURITY_CODE=B.SECURITY_CODE   AND
                                                               (C.SERIAL_NO_STATUS='INV' OR ( C.SALE_EFF_VALDATE IS NULL) OR
                                                                 (C .SALE_EFF_VALDATE>TO_DATE(MM_DATE,'DD/MM/YYYY'))  )AND
                                                               B.MATURITY_DATE>= TO_DATE(MM_DATE,'DD/MM/YYYY')  AND
                                                               B.ISSUE_DATE<= TO_DATE(MM_DATE,'DD/MM/YYYY') AND
                                                               C.FACE_VAL>0 AND
                                                               C.FACE_VAL_CURR IS NULL AND
                                                               C.SCRIP_STATUS LIKE '%'
                                                   GROUP BY    C.PORTFOLIO_CODE,C.SECURITY_CODE,B.MATURITY_DATE,DN_GET_COUPON_RATE(B.SECURITY_CODE)  )T2
                                                WHERE T1.sec=T2.sec
                            --######################################################################################
                            )

UNION
 SELECT JK.X1,JK.X2,JK.X3,JK.X4,JK.X5,JK.X6,JK.X7,JK.X8,'LOWER' X9,JK.X10,JK.X11,JK.X12,JK.X13,JK.X14
 FROM
    (SELECT T1.sec X1 ,T1.mat X2,
            (T1.a+T2.a) X3 ,--faceval,
            (T1.b+T2.b) X4 ,--cost,
            DECODE((T1.b+T2.b),0,0,(T1.yeild*T1.b+T2.yeild*T2.b)/(T1.b+T2.b) ) X5,
            T1.days X6,
            T1.rate X7,
            T1.mat2 X8,
            T1.port X10,
            T1.X11 X11,
            T1.X12 X12,
            T1.X13 X13,
            T1.X14 X14

     FROM  (SELECT  A.SECURITY_CODE sec,TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY') mat,SUM(A.FACE_VAL) a,SUM(A.INITIAL_COST+A.BROKERAGE) b ,DECODE(SUM(A.INITIAL_COST+A.BROKERAGE),0,0,SUM((A.INITIAL_COST+A.BROKERAGE)*A.DEAL_YIELD*100)/SUM(A.INITIAL_COST+A.BROKERAGE))  yeild,
                    ROUND(TO_NUMBER(B.MATURITY_DATE-TO_DATE(MM_DATE,'DD/MM/YYYY')),0) days,DN_GET_COUPON_RATE(B.SECURITY_CODE)rate,TO_DATE(B.MATURITY_DATE,'DD-MON-YYYY') mat2,PORTFOLIO_CODE port,
                    SUM(A.PRICE_INT_ACCR) X11,
              SUM(A.TOT_COUP_INT) X12,
              SUM(A.CARR_VAL) X13,
              DN_GET_OR_SELLER(A.DEAL_NO) X14

            FROM    DN_INV_OUTPS_DEAL_SERIAL_NO A,
                    DN_REF_SECURITY B
           WHERE    A.PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                    TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')<=TO_DATE(MM_DATE,'DD/MM/YYYY') AND
                    A.INST_TYPE LIKE '%' AND--=M_INST_TYPE AND
                    A.SECURITY_CODE=B.SECURITY_CODE  AND
                    (A.SERIAL_NO_STATUS='INV' OR ( A.SALE_EFF_VALDATE IS NULL) OR
                      (A.SALE_EFF_VALDATE>TO_DATE(MM_DATE,'DD/MM/YYYY')))AND
                    B.MATURITY_DATE>= TO_DATE(MM_DATE,'DD/MM/YYYY')  AND
                    B.ISSUE_DATE<= TO_DATE(MM_DATE,'DD/MM/YYYY') AND
                    A.FACE_VAL>0 AND
                    A.FACE_VAL_CURR IS NULL  AND
                    A.SCRIP_STATUS LIKE '%'
        GROUP BY    A.PORTFOLIO_CODE,A.SECURITY_CODE,B.MATURITY_DATE,DN_GET_COUPON_RATE(B.SECURITY_CODE),
              DN_GET_OR_SELLER(A.DEAL_NO)
        )T1,

        (SELECT     C.SECURITY_CODE sec,TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),
                    SUM(C.FACE_VAL) a,SUM(C.INITIAL_COST+C.BROKERAGE) b ,
                    DECODE(SUM(C.INITIAL_COST+C.BROKERAGE),0,0,SUM((C.INITIAL_COST+C.BROKERAGE)*C.DEAL_YIELD*100)/SUM(C.INITIAL_COST+C.BROKERAGE)) yeild,
                    ROUND(TO_NUMBER(B.MATURITY_DATE-TO_DATE(MM_DATE,'DD/MM/YYYY')),0),DN_GET_COUPON_RATE(B.SECURITY_CODE)rate ,TO_DATE(B.MATURITY_DATE,'DD-MON-YYYY')  mat2,PORTFOLIO_CODE port,
                    SUM(C.PRICE_INT_ACCR) X11,
              SUM(C.TOT_COUP_INT) X12,
              SUM(C.CARR_VAL) X13
            FROM    DN_REF_SECURITY B,
                    DN_HIS_OUTPS_DEAL_SERIAL_NO C
           WHERE    C.PORTFOLIO_CODE = M_PORTFOLIO_CODE AND
                    TO_DATE(TO_CHAR(C.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')<=TO_DATE(MM_DATE,'DD/MM/YYYY') AND
                    C.INST_TYPE LIKE '%' AND--=M_INST_TYPE  AND
                    C.SECURITY_CODE=B.SECURITY_CODE   AND
                    (C.SERIAL_NO_STATUS='INV' OR ( C.SALE_EFF_VALDATE IS NULL) OR
                      (C.SALE_EFF_VALDATE>TO_DATE(MM_DATE,'DD/MM/YYYY'))  )AND
                    B.MATURITY_DATE>= TO_DATE(MM_DATE,'DD/MM/YYYY')  AND
                    B.ISSUE_DATE<= TO_DATE(MM_DATE,'DD/MM/YYYY') AND
                    C.FACE_VAL>0 AND
                    C.FACE_VAL_CURR IS NULL  AND C.SCRIP_STATUS LIKE '%'
          GROUP BY  C.PORTFOLIO_CODE,C.SECURITY_CODE,B.MATURITY_DATE,DN_GET_COUPON_RATE(B.SECURITY_CODE)  )T2

    WHERE T1.sec=T2.sec)JK





-------------------------------------------------------------------------------------------------
 ) 
);


RETURN  NVL(M_AMOUNT,0);



 END ; 

/
