--------------------------------------------------------
--  DDL for Function DN_CASH_BALANCE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_CASH_BALANCE" 
( M_PORTFOLIO_CODE IN DN_REF_SECURITY.SECURITY_CODE%TYPE,
  M_VALUE_DATE     VARCHAR2 )
  RETURN VARCHAR2 IS


  M_CASH_BAL            number;

BEGIN

  SELECT SUM(TOT) INTO M_CASH_BAL
  FROM (

  SELECT SUM(DECODE(A.DRCR_STATUS,'CR', A.TRNAMOUNT, A.TRNAMOUNT*-1)) TOT --INTO M_CASH_BAL
  FROM DN_ACC_LICENCEE_GEN_ACCOUNT A
  WHERE ACC_TYPE_CODE='301'
 -- AND (DOCREFNO LIKE 'CD%' OR DOCREFNO LIKE 'CW%') --add or by waruna 2013-03-20
  AND SUBSTR(DOCREFNO,0,2) IN ('CD','CW','OR','RI','PC','IR')
  AND TRNDATE <= TO_DATE(M_VALUE_DATE,'DD/MM/YYYY')
  AND DN_PORTFOLIO_CODE = M_PORTFOLIO_CODE
  --add by waruna 2013-03-20
     UNION ALL

                          SELECT SUM(TRNAMOUNT) TOT
                          FROM DN_TRN_DIVIDEND_INCOME X,
                               DN_REF_PORTFOLIO V
                          WHERE
                          X.PORTFOLIO_CODE = V.PORTFOLIO_CODE
                          AND V.PF_TYPE = 'P'
                          AND V.OWNED_BY_MBFSL='N'
                          AND TO_DATE(TO_CHAR(REALISED_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')<=TO_DATE(M_VALUE_DATE,'DD/MM/YYYY')
                          AND X.PORTFOLIO_CODE = M_PORTFOLIO_CODE

                          GROUP BY X.PORTFOLIO_CODE,V.PF_NAME

                        /*
                        UNION ALL


                        SELECT (SUM(SETTLE_VALUE)-0)*-1 TOT
                          FROM DN_TRN_OUTP_SALE X,
                               DN_TRN_OUTP_SALE_SETTLE_EQUITY Z,
                               DN_REF_PORTFOLIO W,
                               DN_REF_PORTFOLIO V
                          WHERE
                          Z.DEAL_NO= X.DEAL_NO AND
                          X.BUY_PORTFOLIO_CODE= W.PORTFOLIO_CODE AND
                          X.SELL_PORTFOLIO_CODE = V.PORTFOLIO_CODE AND
                          APP_STATUS = 'CONF' AND
                          DN_GET_INSTRUMENT_CAT(INST_TYPE)='EQUITY' AND
                          W.PF_TYPE = 'P'
                          AND W.OWNED_BY_MBFSL='N'
                          AND TO_DATE(TO_CHAR(BUY_SETLE_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')<=TO_DATE(M_VALUE_DATE,'DD/MM/YYYY')
                          AND X.BUY_PORTFOLIO_CODE = M_PORTFOLIO_CODE
                          GROUP BY BUY_PORTFOLIO_CODE,W.PF_NAME

                        UNION ALL

                        SELECT (SUM(0-SETTLE_VALUE))*-1 TOT
                          FROM DN_TRN_OUTP_SALE X,
                               DN_TRN_OUTP_SALE_SETTLE_EQUITY Z,
                               DN_REF_PORTFOLIO W,
                               DN_REF_PORTFOLIO V
                          WHERE
                          Z.DEAL_NO= X.DEAL_NO AND
                          X.SELL_PORTFOLIO_CODE= W.PORTFOLIO_CODE AND
                          X.BUY_PORTFOLIO_CODE = V.PORTFOLIO_CODE AND
                          APP_STATUS = 'CONF' AND
                          DN_GET_INSTRUMENT_CAT(INST_TYPE) = 'EQUITY' AND
                          W.PF_TYPE = 'P' AND W.OWNED_BY_MBFSL='N' AND

                          TO_DATE(TO_CHAR(SELL_SETLE_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')<=TO_DATE(M_VALUE_DATE,'DD/MM/YYYY')
                          AND X.SELL_PORTFOLIO_CODE = M_PORTFOLIO_CODE
                          GROUP BY SELL_PORTFOLIO_CODE,W.PF_NAME
                            --END by waruna 2013-03-20
                            */

                        UNION ALL

                        SELECT SUM(A.TRNAMOUNT)*-1 TOT
                        FROM   DN_ACC_LICENCEE_GEN_ACCOUNT A ,
                               DN_TRN_BO_SETTL_PAYMENT_BULK B ,
                               DN_REF_PORTFOLIO C
                        WHERE  A.DOCREFNO LIKE 'SP%'
                        AND   ACC_TYPE_CODE ='302'
                        AND DRCR_STATUS ='DR'
                        --AND   A.TRNDATE >= TO_DATE('m_valfromdate+"','DD-MM-YYYY')
                        AND A.TRNDATE <= TO_DATE(M_VALUE_DATE,'DD-MM-YYYY')
                        AND A.DOCREFNO = B.PAYMENT_NO
                        AND B.PORTFOLIO_CODE = C.PORTFOLIO_CODE
                        AND B.PORTFOLIO_CODE = M_PORTFOLIO_CODE
                        GROUP BY B.PORTFOLIO_CODE,C.PF_NAME

                        /*UNION ALL   ----------------------------------------------------- REBATE

                        SELECT SUM(A.TRNAMOUNT)*-1 TOT
                        FROM   DN_ACC_LICENCEE_GEN_ACCOUNT A ,
                               DN_TRN_REBATE_PAYMENT B ,
                               DN_REF_PORTFOLIO C
                        WHERE  A.DOCREFNO LIKE 'LP%'
                        AND   ACC_TYPE_CODE ='302'
                        AND DRCR_STATUS ='DR'
                        --AND   A.TRNDATE >= TO_DATE('m_valfromdate+"','DD-MM-YYYY')
                        AND A.TRNDATE <= TO_DATE(M_VALUE_DATE,'DD-MM-YYYY')
                        AND A.DOCREFNO = B.PAYMENT_NO
                        AND B.PORTFOLIO_CODE = C.PORTFOLIO_CODE
                        AND B.ID_PORTFOLIO_CODE = M_PORTFOLIO_CODE
                        GROUP BY B.ID_PORTFOLIO_CODE,C.PF_NAME
                         */
                        UNION ALL

                        SELECT SUM(0-TRNAMOUNT)*-1 TOT
                        FROM    DN_ACC_LICENCEE_GEN_ACCOUNT A ,
                                DN_TRN_BO_SETTL_RECEIPT_BULK B ,
                                DN_REF_PORTFOLIO C
                        WHERE  A.DOCREFNO LIKE 'SR%'
                        AND ACC_TYPE_CODE ='302'
                        AND DRCR_STATUS = 'CR'
                        --AND A.TRNDATE >= TO_DATE('M_VALFROMDATE+"','DD-MM-YYYY')
                        --AND A.TRNDATE <= TO_DATE('M_VALTODATE+"','DD-MM-YYYY')
                        --AND A.TRNDATE >= TO_DATE('M_VALFROMDATE+"','DD-MM-YYYY')
                        AND A.TRNDATE <= TO_DATE(M_VALUE_DATE,'DD-MM-YYYY')
                        AND A.DOCREFNO = B.REC_NO
                        AND B.SELL_PORTFOLIO_CODE = C.PORTFOLIO_CODE
                        AND B.SELL_PORTFOLIO_CODE = M_PORTFOLIO_CODE
                        GROUP BY B.SELL_PORTFOLIO_CODE,C.PF_NAME

                        UNION ALL

                        SELECT SUM(0-TRNAMOUNT)*-1 TOT
                        FROM    DN_ACC_LICENCEE_GEN_ACCOUNT A ,
                                DN_TRN_LOAN_SETTL_RECEIPT B ,
                                DN_REF_PORTFOLIO C
                        WHERE  A.DOCREFNO LIKE 'LR%'
                        AND ACC_TYPE_CODE ='301'
                        AND DRCR_STATUS = 'CR'
                        --AND A.TRNDATE >= TO_DATE('M_VALFROMDATE+"','DD-MM-YYYY')
                        --AND A.TRNDATE <= TO_DATE('M_VALTODATE+"','DD-MM-YYYY')
                        --AND A.TRNDATE >= TO_DATE('M_VALFROMDATE+"','DD-MM-YYYY')
                        AND A.TRNDATE <= TO_DATE(M_VALUE_DATE,'DD-MM-YYYY')
                        AND A.DOCREFNO = B.REC_NO
                        AND B.ID_PORTFOLIO_CODE = C.PORTFOLIO_CODE
                        AND B.ID_PORTFOLIO_CODE = M_PORTFOLIO_CODE
                        GROUP BY B.ID_PORTFOLIO_CODE,C.PF_NAME


                          );


   RETURN NVL(M_CASH_BAL,0) ;

END;

/
