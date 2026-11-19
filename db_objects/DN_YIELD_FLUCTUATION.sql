--------------------------------------------------------
--  DDL for Procedure DN_YIELD_FLUCTUATION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_YIELD_FLUCTUATION" 
(
M_PROCESS_DATE        DN_SYS_PARAMETER.LAST_DAILY%TYPE
)

IS

          CURSOR MY_CUR_TBOND IS
                      SELECT ERT.X4,ERT.X5 FROM
					  (
                       SELECT A.SECURITY_CODE  X1 ,
                              TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY')X2,
                              SUM(A.FACE_VAL) X3,
                              SUM(A.INITIAL_COST+A.BROKERAGE) X4,
                              --TO_CHAR(SUM((A.INITIAL_COST+A.BROKERAGE)*A.DEAL_YIELD*100)/SUM(A.INITIAL_COST+A.BROKERAGE),'FM999G990D0000') X5,
                              TRUNC(SUM((A.INITIAL_COST+A.BROKERAGE)*A.DEAL_YIELD*100)/SUM(A.INITIAL_COST+A.BROKERAGE),4)X5,
                              ROUND(TO_NUMBER(B.MATURITY_DATE-M_PROCESS_DATE),0) X6

                      FROM    DN_INV_OUTPS_DEAL_SERIAL_NO A,
                              DN_REF_SECURITY B

                      WHERE   A.SECURITY_CODE=B.SECURITY_CODE  AND
					          TO_DATE(TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')>= M_PROCESS_DATE  AND
					          TO_DATE(TO_CHAR(B.ISSUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')<= M_PROCESS_DATE  AND
                              TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')<=M_PROCESS_DATE AND
                              A.FACE_VAL>0 AND
                              --A.PORTFOLIO_CODE='m_port+' AND
						       ((A.SERIAL_NO_STATUS='INV') OR
                               (A.SALE_EFF_VALDATE IS NULL) OR
					           (TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')>M_PROCESS_DATE)  )AND
						      A.INST_TYPE='TBOND'

                      GROUP BY A.SECURITY_CODE,B.MATURITY_DATE

                      UNION ALL

                      SELECT
					       C.SECURITY_CODE X1 ,
                           TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY') X2,
					       SUM(C.FACE_VAL) X3,
                           SUM(C.INITIAL_COST+C.BROKERAGE)X4,
					      -- TO_CHAR(SUM((C.INITIAL_COST+C.BROKERAGE)*C.DEAL_YIELD*100)/SUM(C.INITIAL_COST+C.BROKERAGE),'FM999G990D0000')X5,
                          TRUNC(SUM((C.INITIAL_COST+C.BROKERAGE)*C.DEAL_YIELD*100)/SUM(C.INITIAL_COST+C.BROKERAGE),4)X5,
                          ROUND(TO_NUMBER(B.MATURITY_DATE-M_PROCESS_DATE),0)X6
					  FROM
					        DN_REF_SECURITY B,
					        DN_HIS_OUTPS_DEAL_SERIAL_NO C
					  WHERE
					         C.SECURITY_CODE=B.SECURITY_CODE AND
                             TO_DATE(TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')>= M_PROCESS_DATE  AND
	 			             TO_DATE(TO_CHAR(B.ISSUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')<= M_PROCESS_DATE AND
					         TO_DATE(TO_CHAR(C.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')<=M_PROCESS_DATE AND
					         C.FACE_VAL>0 AND
					         --C.PORTFOLIO_CODE='m_port+' AND
					         ((C.SERIAL_NO_STATUS='INV') OR
                              (C.SALE_EFF_VALDATE IS NULL) OR
					          (TO_DATE(TO_CHAR(C .SALE_EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')>M_PROCESS_DATE)  )AND
						     C.INST_TYPE='TBOND'

                      GROUP BY C.SECURITY_CODE,B.MATURITY_DATE
					 --ORDER BY 1
                      )ERT

                      WHERE ERT.X1 NOT IN
					  (SELECT  T1.sec
					   FROM
          					     (SELECT A.SECURITY_CODE sec,
                                           TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY') mat,
                                           SUM(A.FACE_VAL) a,
                                           SUM(A.INITIAL_COST+A.BROKERAGE) b ,
                                           TO_CHAR(SUM((A.INITIAL_COST+A.BROKERAGE)*A.DEAL_YIELD*100)/SUM(A.INITIAL_COST+A.BROKERAGE),'FM999G990D0000')  yeild,
          					               ROUND(TO_NUMBER(B.MATURITY_DATE-M_PROCESS_DATE),0) days

                                    FROM   DN_INV_OUTPS_DEAL_SERIAL_NO A,
                                           DN_REF_SECURITY B
                                    WHERE  A.SECURITY_CODE=B.SECURITY_CODE  AND
                                           TO_DATE(TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')>= M_PROCESS_DATE  AND
          					               TO_DATE(TO_CHAR(B.ISSUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')<= M_PROCESS_DATE AND
                                           TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')<=M_PROCESS_DATE AND
                                           A.FACE_VAL>0 AND
                                           --A.PORTFOLIO_CODE='m_port+' AND
          					               ((A.SERIAL_NO_STATUS='INV') OR
                                            (A.SALE_EFF_VALDATE IS NULL) OR
          					                (TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')>M_PROCESS_DATE)  )AND
                                           A.INST_TYPE='TBOND'
                                    GROUP BY A.SECURITY_CODE,B.MATURITY_DATE )T1,


                                (SELECT
                                      C.SECURITY_CODE sec,
                                      TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),
                                      SUM(C.FACE_VAL) a,
                                      SUM(C.INITIAL_COST+C.BROKERAGE) b ,
                                      TO_CHAR(SUM((C.INITIAL_COST+C.BROKERAGE)*C.DEAL_YIELD*100)/SUM(C.INITIAL_COST+C.BROKERAGE),'FM999G990D0000') yeild,
                                      ROUND(TO_NUMBER(B.MATURITY_DATE-M_PROCESS_DATE),0)
                                 FROM
                                      DN_REF_SECURITY B,
                                      DN_HIS_OUTPS_DEAL_SERIAL_NO C
                                WHERE
                                     C.SECURITY_CODE=B.SECURITY_CODE  AND
                                     TO_DATE(TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')>= M_PROCESS_DATE  AND
                                     TO_DATE(TO_CHAR(B.ISSUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')<= M_PROCESS_DATE AND
                                     TO_DATE(TO_CHAR(C.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')<=M_PROCESS_DATE AND
                                     C.FACE_VAL>0 AND
                                    --C.PORTFOLIO_CODE='m_port+' AND
                                     ((C.SERIAL_NO_STATUS='INV') OR
                                      (C.SALE_EFF_VALDATE IS NULL) OR
                                      (TO_DATE(TO_CHAR(C .SALE_EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')>M_PROCESS_DATE)  )AND
                                     C.INST_TYPE='TBOND'
                                GROUP BY C.SECURITY_CODE,B.MATURITY_DATE )T2
                          WHERE T1.sec=T2.sec)

  UNION ALL
-------------------------------------------------
  (SELECT
	   --T1.sec,
      -- T1.mat,
	  -- (T1.a+T2.a)faceval,
       (T1.b+T2.b)cost,
	    --TO_CHAR((T1.yeild*T1.b+T2.yeild*T2.b)/(T1.b+T2.b),'FM999G990D0000'),
        TRUNC((T1.yeild*T1.b+T2.yeild*T2.b)/(T1.b+T2.b),4)
       -- T1.days
   FROM
        	  (SELECT
                 A.SECURITY_CODE sec,
                 TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY') mat,
                 SUM(A.FACE_VAL) a,
                 SUM(A.INITIAL_COST+A.BROKERAGE) b ,
                 TO_CHAR(SUM((A.INITIAL_COST+A.BROKERAGE)*A.DEAL_YIELD*100)/SUM(A.INITIAL_COST+A.BROKERAGE),'FM999G990D0000')  yeild,
        	     ROUND(TO_NUMBER(B.MATURITY_DATE-M_PROCESS_DATE),0) days

              FROM    DN_INV_OUTPS_DEAL_SERIAL_NO A,
                      DN_REF_SECURITY B
              WHERE   A.SECURITY_CODE=B.SECURITY_CODE  AND
                      TO_DATE(TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')>= M_PROCESS_DATE  AND
        	          TO_DATE(TO_CHAR(B.ISSUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')<= M_PROCESS_DATE AND
                      TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')<=M_PROCESS_DATE AND
                      A.FACE_VAL>0 AND
                      --A.PORTFOLIO_CODE='m_port+' AND
        	          ((A.SERIAL_NO_STATUS='INV') OR
                       (A.SALE_EFF_VALDATE IS NULL) OR
        	           (TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')>M_PROCESS_DATE)  )AND
        	          A.INST_TYPE='TBOND'
              GROUP BY A.SECURITY_CODE,B.MATURITY_DATE )T1,

                (SELECT
                     C.SECURITY_CODE sec,
                     TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),
                     SUM(C.FACE_VAL) a,
                     SUM(C.INITIAL_COST+C.BROKERAGE) b ,
                     TO_CHAR(SUM((C.INITIAL_COST+C.BROKERAGE)*C.DEAL_YIELD*100)/SUM(C.INITIAL_COST+C.BROKERAGE),'FM999G990D0000') yeild,
                     ROUND(TO_NUMBER(B.MATURITY_DATE-M_PROCESS_DATE),0)
                FROM
                   DN_REF_SECURITY B,
                   DN_HIS_OUTPS_DEAL_SERIAL_NO C
                WHERE
                    C.SECURITY_CODE=B.SECURITY_CODE   AND
                    TO_DATE(TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')>= M_PROCESS_DATE  AND
                    TO_DATE(TO_CHAR(B.ISSUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')<= M_PROCESS_DATE AND
                    TO_DATE(TO_CHAR(C.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')<=M_PROCESS_DATE AND
                    C.FACE_VAL>0 AND
                    --C.PORTFOLIO_CODE='m_port+' AND
                    ((C.SERIAL_NO_STATUS='INV') OR
                     (C.SALE_EFF_VALDATE IS NULL) OR
                     (TO_DATE(TO_CHAR(C .SALE_EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')>M_PROCESS_DATE)  )AND
                    C.INST_TYPE='TBOND'
                GROUP BY C.SECURITY_CODE,B.MATURITY_DATE )T2
    WHERE T1.sec=T2.sec)
	---------------------------------------------------------------
  ORDER BY 2;



   CURSOR MY_CUR_TBILL IS
                 SELECT ERT.X4,ERT.X5 FROM
					  (
                       SELECT A.SECURITY_CODE  X1 ,
                              TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY')X2,
                              SUM(A.FACE_VAL) X3,
                              SUM(A.INITIAL_COST+A.BROKERAGE) X4,
                              --TO_CHAR(SUM((A.INITIAL_COST+A.BROKERAGE)*A.DEAL_YIELD*100)/SUM(A.INITIAL_COST+A.BROKERAGE),'FM999G990D0000') X5,
                              TRUNC(SUM((A.INITIAL_COST+A.BROKERAGE)*A.DEAL_YIELD*100)/SUM(A.INITIAL_COST+A.BROKERAGE),4)X5,
                              ROUND(TO_NUMBER(B.MATURITY_DATE-M_PROCESS_DATE),0) X6

                      FROM    DN_INV_OUTPS_DEAL_SERIAL_NO A,
                              DN_REF_SECURITY B

                      WHERE   A.SECURITY_CODE=B.SECURITY_CODE  AND
					          TO_DATE(TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')>= M_PROCESS_DATE  AND
					          TO_DATE(TO_CHAR(B.ISSUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')<= M_PROCESS_DATE  AND
                              TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')<=M_PROCESS_DATE AND
                              A.FACE_VAL>0 AND
                              --A.PORTFOLIO_CODE='m_port+' AND
						       ((A.SERIAL_NO_STATUS='INV') OR
                               (A.SALE_EFF_VALDATE IS NULL) OR
					           (TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')>M_PROCESS_DATE)  )AND
						      A.INST_TYPE='TBILL'

                      GROUP BY A.SECURITY_CODE,B.MATURITY_DATE

                      UNION ALL

                      SELECT
					       C.SECURITY_CODE X1 ,
                           TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY') X2,
					       SUM(C.FACE_VAL) X3,
                           SUM(C.INITIAL_COST+C.BROKERAGE)X4,
					      -- TO_CHAR(SUM((C.INITIAL_COST+C.BROKERAGE)*C.DEAL_YIELD*100)/SUM(C.INITIAL_COST+C.BROKERAGE),'FM999G990D0000')X5,
                          TRUNC(SUM((C.INITIAL_COST+C.BROKERAGE)*C.DEAL_YIELD*100)/SUM(C.INITIAL_COST+C.BROKERAGE),4)X5,
                          ROUND(TO_NUMBER(B.MATURITY_DATE-M_PROCESS_DATE),0)X6
					  FROM
					        DN_REF_SECURITY B,
					        DN_HIS_OUTPS_DEAL_SERIAL_NO C
					  WHERE
					         C.SECURITY_CODE=B.SECURITY_CODE AND
                             TO_DATE(TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')>= M_PROCESS_DATE  AND
	 			             TO_DATE(TO_CHAR(B.ISSUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')<= M_PROCESS_DATE AND
					         TO_DATE(TO_CHAR(C.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')<=M_PROCESS_DATE AND
					         C.FACE_VAL>0 AND
					         --C.PORTFOLIO_CODE='m_port+' AND
					         ((C.SERIAL_NO_STATUS='INV') OR
                              (C.SALE_EFF_VALDATE IS NULL) OR
					          (TO_DATE(TO_CHAR(C .SALE_EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')>M_PROCESS_DATE)  )AND
						     C.INST_TYPE='TBILL'

                      GROUP BY C.SECURITY_CODE,B.MATURITY_DATE
					 --ORDER BY 1
                      )ERT

                      WHERE ERT.X1 NOT IN
					  (SELECT  T1.sec
					   FROM
          					     (SELECT A.SECURITY_CODE sec,
                                           TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY') mat,
                                           SUM(A.FACE_VAL) a,
                                           SUM(A.INITIAL_COST+A.BROKERAGE) b ,
                                           TO_CHAR(SUM((A.INITIAL_COST+A.BROKERAGE)*A.DEAL_YIELD*100)/SUM(A.INITIAL_COST+A.BROKERAGE),'FM999G990D0000')  yeild,
          					               ROUND(TO_NUMBER(B.MATURITY_DATE-M_PROCESS_DATE),0) days

                                    FROM   DN_INV_OUTPS_DEAL_SERIAL_NO A,
                                           DN_REF_SECURITY B
                                    WHERE  A.SECURITY_CODE=B.SECURITY_CODE  AND
                                           TO_DATE(TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')>= M_PROCESS_DATE  AND
          					               TO_DATE(TO_CHAR(B.ISSUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')<= M_PROCESS_DATE AND
                                           TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')<=M_PROCESS_DATE AND
                                           A.FACE_VAL>0 AND
                                           --A.PORTFOLIO_CODE='m_port+' AND
          					               ((A.SERIAL_NO_STATUS='INV') OR
                                            (A.SALE_EFF_VALDATE IS NULL) OR
          					                (TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')>M_PROCESS_DATE)  )AND
                                           A.INST_TYPE='TBILL'
                                    GROUP BY A.SECURITY_CODE,B.MATURITY_DATE )T1,


                                (SELECT
                                      C.SECURITY_CODE sec,
                                      TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),
                                      SUM(C.FACE_VAL) a,
                                      SUM(C.INITIAL_COST+C.BROKERAGE) b ,
                                      TO_CHAR(SUM((C.INITIAL_COST+C.BROKERAGE)*C.DEAL_YIELD*100)/SUM(C.INITIAL_COST+C.BROKERAGE),'FM999G990D0000') yeild,
                                      ROUND(TO_NUMBER(B.MATURITY_DATE-M_PROCESS_DATE),0)
                                 FROM
                                      DN_REF_SECURITY B,
                                      DN_HIS_OUTPS_DEAL_SERIAL_NO C
                                WHERE
                                     C.SECURITY_CODE=B.SECURITY_CODE  AND
                                     TO_DATE(TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')>= M_PROCESS_DATE  AND
                                     TO_DATE(TO_CHAR(B.ISSUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')<= M_PROCESS_DATE AND
                                     TO_DATE(TO_CHAR(C.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')<=M_PROCESS_DATE AND
                                     C.FACE_VAL>0 AND
                                    --C.PORTFOLIO_CODE='m_port+' AND
                                     ((C.SERIAL_NO_STATUS='INV') OR
                                      (C.SALE_EFF_VALDATE IS NULL) OR
                                      (TO_DATE(TO_CHAR(C .SALE_EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')>M_PROCESS_DATE)  )AND
                                     C.INST_TYPE='TBILL'
                                GROUP BY C.SECURITY_CODE,B.MATURITY_DATE )T2
                          WHERE T1.sec=T2.sec)

  UNION ALL
-------------------------------------------------
  (SELECT
	   --T1.sec,
      -- T1.mat,
	  -- (T1.a+T2.a)faceval,
       (T1.b+T2.b)cost,
	    --TO_CHAR((T1.yeild*T1.b+T2.yeild*T2.b)/(T1.b+T2.b),'FM999G990D0000'),
        TRUNC((T1.yeild*T1.b+T2.yeild*T2.b)/(T1.b+T2.b),4)
       -- T1.days
   FROM
        	  (SELECT
                 A.SECURITY_CODE sec,
                 TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY') mat,
                 SUM(A.FACE_VAL) a,
                 SUM(A.INITIAL_COST+A.BROKERAGE) b ,
                 TO_CHAR(SUM((A.INITIAL_COST+A.BROKERAGE)*A.DEAL_YIELD*100)/SUM(A.INITIAL_COST+A.BROKERAGE),'FM999G990D0000')  yeild,
        	     ROUND(TO_NUMBER(B.MATURITY_DATE-M_PROCESS_DATE),0) days

              FROM    DN_INV_OUTPS_DEAL_SERIAL_NO A,
                      DN_REF_SECURITY B
              WHERE   A.SECURITY_CODE=B.SECURITY_CODE  AND
                      TO_DATE(TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')>= M_PROCESS_DATE  AND
        	          TO_DATE(TO_CHAR(B.ISSUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')<= M_PROCESS_DATE AND
                      TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')<=M_PROCESS_DATE AND
                      A.FACE_VAL>0 AND
                      --A.PORTFOLIO_CODE='m_port+' AND
        	          ((A.SERIAL_NO_STATUS='INV') OR
                       (A.SALE_EFF_VALDATE IS NULL) OR
        	           (TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')>M_PROCESS_DATE)  )AND
        	          A.INST_TYPE='TBILL'
              GROUP BY A.SECURITY_CODE,B.MATURITY_DATE )T1,

                (SELECT
                     C.SECURITY_CODE sec,
                     TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),
                     SUM(C.FACE_VAL) a,
                     SUM(C.INITIAL_COST+C.BROKERAGE) b ,
                     TO_CHAR(SUM((C.INITIAL_COST+C.BROKERAGE)*C.DEAL_YIELD*100)/SUM(C.INITIAL_COST+C.BROKERAGE),'FM999G990D0000') yeild,
                     ROUND(TO_NUMBER(B.MATURITY_DATE-M_PROCESS_DATE),0)
                FROM
                   DN_REF_SECURITY B,
                   DN_HIS_OUTPS_DEAL_SERIAL_NO C
                WHERE
                    C.SECURITY_CODE=B.SECURITY_CODE   AND
                    TO_DATE(TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')>= M_PROCESS_DATE  AND
                    TO_DATE(TO_CHAR(B.ISSUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')<= M_PROCESS_DATE AND
                    TO_DATE(TO_CHAR(C.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')<=M_PROCESS_DATE AND
                    C.FACE_VAL>0 AND
                    --C.PORTFOLIO_CODE='m_port+' AND
                    ((C.SERIAL_NO_STATUS='INV') OR
                     (C.SALE_EFF_VALDATE IS NULL) OR
                     (TO_DATE(TO_CHAR(C .SALE_EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')>M_PROCESS_DATE)  )AND
                    C.INST_TYPE='TBILL'
                GROUP BY C.SECURITY_CODE,B.MATURITY_DATE )T2
    WHERE T1.sec=T2.sec)
	---------------------------------------------------------------
  ORDER BY 2;


       M_REPO_YIELD                        NUMBER;
       M_REVERSE_REPO_YIELD                NUMBER;
       --------------------------------------------
       AA_REPO                             NUMBER;
       AA_REVERSE_REPO                     NUMBER;
       DD_REPO                             NUMBER;
       DD_REVERSE_REPO                     NUMBER;
       COUNT_DD_REPO                       INTEGER;
       COUNT_AA_REPO                       INTEGER;
       COUNT_DD_REPO_REVERSE               INTEGER;
       COUNT_AA_REPO_REVERSE               INTEGER;
       AA_ACCR                             DN_REF_YIELD_FLUCTUATION.TBILL_PRICE_ACCR%TYPE;
       AA_REVERSE_ACCR                     DN_REF_YIELD_FLUCTUATION.TBILL_PRICE_ACCR%TYPE;
       MTBOND_FACEVAL                      DN_REF_YIELD_FLUCTUATION.TBILL_PRICE_ACCR%TYPE;
       MTBOND_PRICE_ACCR                   DN_REF_YIELD_FLUCTUATION.TBILL_PRICE_ACCR%TYPE;
       MTBOND_COUPON_ACCR                  DN_REF_YIELD_FLUCTUATION.TBILL_PRICE_ACCR%TYPE;
       MTBILL_FACEVAL                      DN_REF_YIELD_FLUCTUATION.TBILL_PRICE_ACCR%TYPE;
       MTBILL_PRICE_ACCR                   DN_REF_YIELD_FLUCTUATION.TBILL_PRICE_ACCR%TYPE;


       M_TBILL_YIELD                       DN_REF_YIELD_FLUCTUATION.TBILL_YIELD%TYPE;
       M_TBOND_YIELD                       DN_REF_YIELD_FLUCTUATION.TBILL_YIELD%TYPE;
       MTBI_SECURITY_CODE                  DN_INV_OUTPS_DEAL_SERIAL_NO.SECURITY_CODE%TYPE;
       MTBI_MATURITY_DATE                  DN_REF_SECURITY.MATURITY_DATE%TYPE;
       MTBI_FACE_VAL                       DN_INV_OUTPS_DEAL_SERIAL_NO.FACE_VAL%TYPE;
       MTBI_RR                             DN_REF_YIELD_FLUCTUATION.TBILL_YIELD%TYPE;
       MTBI_NN                             DN_REF_YIELD_FLUCTUATION.TBILL_YIELD%TYPE;
       MTBI_DAYS                           NUMBER;

       MTBO_SECURITY_CODE                  DN_INV_OUTPS_DEAL_SERIAL_NO.SECURITY_CODE%TYPE;
       MTBO_MATURITY_DATE                  DN_REF_SECURITY.MATURITY_DATE%TYPE;
       MTBO_FACE_VAL                       DN_INV_OUTPS_DEAL_SERIAL_NO.FACE_VAL%TYPE;
       MTBO_RR                             DN_REF_YIELD_FLUCTUATION.TBILL_YIELD%TYPE;
       MTBO_NN                             DN_REF_YIELD_FLUCTUATION.TBILL_YIELD%TYPE;
       MTBO_DAYS                           NUMBER;

       M_TBILL_YIELD_LOWER                 DN_REF_YIELD_FLUCTUATION.TBILL_YIELD%TYPE;
       M_TBILL_YIELD_UPPER                 DN_REF_YIELD_FLUCTUATION.TBILL_YIELD%TYPE;
       M_TBOND_YIELD_LOWER                 DN_REF_YIELD_FLUCTUATION.TBILL_YIELD%TYPE;
       M_TBOND_YIELD_UPPER                 DN_REF_YIELD_FLUCTUATION.TBILL_YIELD%TYPE;
       BOND_COST                           NUMBER;
       BILL_COST                           NUMBER;



          -- Procedure   : CALCULATES YIELD FLUCTUATIONS
          -- System      : DEALNET System
          -- Created By  : NIRMALA FERNANDO
          -- Created On  : 07/09/2000
          -- MODIFIED BY : NALIN
          -- MODIFIED ON : 28/06/2001



BEGIN
DD_REPO:=0;
AA_REPO:=0;
AA_REVERSE_REPO:=0;
DD_REVERSE_REPO:=0;
AA_ACCR :=0;
AA_REVERSE_ACCR :=0;
MTBOND_FACEVAL :=0;
MTBOND_PRICE_ACCR :=0;
MTBOND_COUPON_ACCR :=0;
MTBILL_FACEVAL :=0;
MTBILL_PRICE_ACCR :=0;






------------------------------------------ FOR REPOS-----------------------------------------
----------------------------------------------------------------------------------------------

                SELECT COUNT(*)
                INTO COUNT_DD_REPO FROM
                (SELECT NVL(SUM(YEILD * LEG1_VALUE),0) RR
                FROM DN_TRN_REPO_ROLLOVER
                WHERE BORR_PORTFOLIO_CODE IN (SELECT PORTFOLIO_CODE  FROM DN_REF_PORTFOLIO
                                              WHERE OWNED_BY_MBFSL='Y' )
                      AND TO_DATE(TO_CHAR(MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')> M_PROCESS_DATE
                --GROUP BY MATURITY_DATE
                UNION ALL
                SELECT NVL(SUM(YIELD * LEG1_VALUE),0)RR
                FROM DN_TRN_REPO_FRESH
                WHERE BORR_PORTFOLIO_CODE IN (SELECT PORTFOLIO_CODE  FROM DN_REF_PORTFOLIO
                                              WHERE OWNED_BY_MBFSL='Y' )
                      AND TO_DATE(TO_CHAR(MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')> M_PROCESS_DATE
               -- GROUP BY MATURITY_DATE
               )AA;



  IF(COUNT_DD_REPO>0)THEN

               SELECT NVL(SUM(AA.RR),0)
               INTO DD_REPO
               FROM
               (SELECT NVL(SUM(YEILD * LEG1_VALUE),0) RR
                FROM DN_TRN_REPO_ROLLOVER
                WHERE BORR_PORTFOLIO_CODE IN (SELECT PORTFOLIO_CODE  FROM DN_REF_PORTFOLIO
                                              WHERE OWNED_BY_MBFSL='Y' )
                      AND TO_DATE(TO_CHAR(MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')> M_PROCESS_DATE
               -- GROUP BY MATURITY_DATE
                UNION ALL
                SELECT NVL(SUM(YIELD * LEG1_VALUE),0)RR
                FROM DN_TRN_REPO_FRESH
                WHERE BORR_PORTFOLIO_CODE IN (SELECT PORTFOLIO_CODE  FROM DN_REF_PORTFOLIO
                                              WHERE OWNED_BY_MBFSL='Y' )
                      AND TO_DATE(TO_CHAR(MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')> M_PROCESS_DATE
               --GROUP BY MATURITY_DATE
               )AA;

END IF;

                SELECT COUNT(*)
                INTO COUNT_AA_REPO FROM
                (SELECT NVL(SUM(LEG1_VALUE),0) RR, NVL(SUM(INT_ACCR),0)JJ
                FROM DN_TRN_REPO_ROLLOVER
                WHERE BORR_PORTFOLIO_CODE IN (SELECT PORTFOLIO_CODE  FROM DN_REF_PORTFOLIO
                                              WHERE OWNED_BY_MBFSL='Y' )
                      AND TO_DATE(TO_CHAR(MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')> M_PROCESS_DATE
               -- GROUP BY MATURITY_DATE
                UNION ALL
                SELECT NVL(SUM(LEG1_VALUE),0) RR, NVL(SUM(INT_ACCR),0)JJ
                FROM DN_TRN_REPO_FRESH
                WHERE BORR_PORTFOLIO_CODE IN (SELECT PORTFOLIO_CODE  FROM DN_REF_PORTFOLIO
                                              WHERE OWNED_BY_MBFSL='Y' )
                      AND TO_DATE(TO_CHAR(MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')> M_PROCESS_DATE
               -- GROUP BY MATURITY_DATE
               )AA;





IF(COUNT_AA_REPO>0)THEN

                SELECT NVL(SUM(AA.RR),0),NVL(SUM(AA.JJ),0)
                INTO AA_REPO,AA_ACCR
                FROM
                (SELECT NVL(SUM(LEG1_VALUE),0)RR, NVL(SUM(INT_ACCR),0)JJ
                FROM DN_TRN_REPO_ROLLOVER
                WHERE BORR_PORTFOLIO_CODE IN (SELECT PORTFOLIO_CODE  FROM DN_REF_PORTFOLIO
                                              WHERE OWNED_BY_MBFSL='Y' )
                      AND TO_DATE(TO_CHAR(MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')> M_PROCESS_DATE
                --GROUP BY MATURITY_DATE
                UNION ALL
                SELECT NVL(SUM(LEG1_VALUE),0)RR, NVL(SUM(INT_ACCR),0)JJ
                FROM DN_TRN_REPO_FRESH
                WHERE BORR_PORTFOLIO_CODE IN (SELECT PORTFOLIO_CODE  FROM DN_REF_PORTFOLIO
                                              WHERE OWNED_BY_MBFSL='Y' )
                      AND TO_DATE(TO_CHAR(MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')> M_PROCESS_DATE
                --GROUP BY MATURITY_DATE
                )AA;
END IF;

    IF(AA_REPO=0)THEN
    M_REPO_YIELD:=0;
    ELSE
    M_REPO_YIELD :=ROUND(DD_REPO/AA_REPO,6);
    END IF;


--------------------------------------FOR REVERSE REPOS---------------------------------------
----------------------------------------------------------------------------------------------
               SELECT COUNT(*)
               INTO COUNT_DD_REPO_REVERSE
               FROM(SELECT SUM(YEILD * LEG1_VALUE) AA
                FROM DN_TRN_REPO_ROLLOVER
                WHERE LEND_PORTFOLIO_CODE IN (SELECT PORTFOLIO_CODE  FROM DN_REF_PORTFOLIO
                                              WHERE OWNED_BY_MBFSL='Y' )
                      AND TO_DATE(TO_CHAR(MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')> M_PROCESS_DATE
                --GROUP BY MATURITY_DATE
                UNION ALL
                SELECT SUM(YIELD * LEG1_VALUE) AA
                FROM DN_TRN_REPO_FRESH
                WHERE LEND_PORTFOLIO_CODE IN (SELECT PORTFOLIO_CODE  FROM DN_REF_PORTFOLIO
                                              WHERE OWNED_BY_MBFSL='Y' )
                      AND TO_DATE(TO_CHAR(MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')>  M_PROCESS_DATE
               -- GROUP BY MATURITY_DATE
               );

  IF(COUNT_DD_REPO_REVERSE>0)THEN
                SELECT NVL(SUM(XX.AA),0)
                INTO DD_REVERSE_REPO
                FROM(SELECT SUM(YEILD * LEG1_VALUE) AA
                FROM DN_TRN_REPO_ROLLOVER
                WHERE LEND_PORTFOLIO_CODE IN (SELECT PORTFOLIO_CODE  FROM DN_REF_PORTFOLIO
                                              WHERE OWNED_BY_MBFSL='Y' )
                      AND TO_DATE(TO_CHAR(MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')> M_PROCESS_DATE
               -- GROUP BY MATURITY_DATE
                UNION ALL
                SELECT SUM(YIELD * LEG1_VALUE) AA
                FROM DN_TRN_REPO_FRESH
                WHERE LEND_PORTFOLIO_CODE IN (SELECT PORTFOLIO_CODE  FROM DN_REF_PORTFOLIO
                                              WHERE OWNED_BY_MBFSL='Y' )
                      AND TO_DATE(TO_CHAR(MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')>  M_PROCESS_DATE
                --GROUP BY MATURITY_DATE
                )XX;
     END IF;
   ------------------------
    SELECT COUNT(*)
    INTO COUNT_AA_REPO_REVERSE

               FROM(SELECT SUM(LEG1_VALUE) AA, NVL(SUM(INT_ACCR),0)JJ
                FROM DN_TRN_REPO_ROLLOVER
                WHERE LEND_PORTFOLIO_CODE IN (SELECT PORTFOLIO_CODE  FROM DN_REF_PORTFOLIO
                                              WHERE OWNED_BY_MBFSL='Y' )
                      AND TO_DATE(TO_CHAR(MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')> M_PROCESS_DATE
               -- GROUP BY MATURITY_DATE
                UNION ALL
                SELECT SUM(LEG1_VALUE) AA, NVL(SUM(INT_ACCR),0)JJ
                FROM DN_TRN_REPO_FRESH
                WHERE LEND_PORTFOLIO_CODE IN (SELECT PORTFOLIO_CODE  FROM DN_REF_PORTFOLIO
                                              WHERE OWNED_BY_MBFSL='Y' )
                      AND TO_DATE(TO_CHAR(MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')>  M_PROCESS_DATE
                --GROUP BY MATURITY_DATE
                );

     IF(COUNT_AA_REPO_REVERSE>0)THEN
     SELECT NVL(SUM(FF.AA),0),NVL(SUM(FF.JJ),0)
     INTO AA_REVERSE_REPO,AA_REVERSE_ACCR
                FROM(SELECT SUM(LEG1_VALUE) AA, NVL(SUM(INT_ACCR),0)JJ
                FROM DN_TRN_REPO_ROLLOVER
                WHERE LEND_PORTFOLIO_CODE IN (SELECT PORTFOLIO_CODE  FROM DN_REF_PORTFOLIO
                                              WHERE OWNED_BY_MBFSL='Y' )
                      AND TO_DATE(TO_CHAR(MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')> M_PROCESS_DATE
               -- GROUP BY MATURITY_DATE
                UNION ALL
                SELECT SUM(LEG1_VALUE) AA, NVL(SUM(INT_ACCR),0)JJ
                FROM DN_TRN_REPO_FRESH
                WHERE LEND_PORTFOLIO_CODE IN (SELECT PORTFOLIO_CODE  FROM DN_REF_PORTFOLIO
                                              WHERE OWNED_BY_MBFSL='Y' )
                      AND TO_DATE(TO_CHAR(MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')>  M_PROCESS_DATE
               -- GROUP BY MATURITY_DATE
               )FF;
     END IF;
             IF(AA_REVERSE_REPO=0)THEN
             M_REVERSE_REPO_YIELD:=0;
             ELSE
             M_REVERSE_REPO_YIELD :=ROUND(DD_REVERSE_REPO/AA_REVERSE_REPO,6);
             END IF;




             IF ((M_REPO_YIELD= 0 )OR ( M_REPO_YIELD IS NULL)) THEN
                    M_REPO_YIELD:=0;
             END IF;

             IF ((M_REVERSE_REPO_YIELD= 0 )OR ( M_REVERSE_REPO_YIELD IS NULL)) THEN
                    M_REVERSE_REPO_YIELD:=0;
             END IF;


      INSERT INTO DN_REF_YIELD_FLUCTUATION
                 (PROCESS_DATE,REPO_YIELD,REVERSE_REPO_YIELD,REPO_AMOUNT,REVERSE_REPO_AMOUNT,REPO_INTR,REVERSE_REPO_INTR,
                  TBOND_FACE_VALUE,TBOND_PRICE_ACCR,TBOND_COUPON_ACCR,
                  TBILL_FACE_VALUE,TBILL_PRICE_ACCR,TBOND_YIELD,TBILL_YIELD)
      VALUES
                 (M_PROCESS_DATE,M_REPO_YIELD,M_REVERSE_REPO_YIELD,AA_REPO,AA_REVERSE_REPO,AA_ACCR,AA_REVERSE_ACCR,0,0,0,0,0,0,0);


--COMMIT;

---------------------------------------- FOR TBONDS------------------------------------------
---------------------------------------------------------------------------------------------
 SELECT
      NVL(SUM(A.FACE_VAL),0),
      NVL(SUM(DN_GET_OUTRIGHT_P_ACCR_INTR(
          DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - (M_PROCESS_DATE))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),(M_PROCESS_DATE)+1),
          A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,B.INT_RATE_BASE_CODE,(A.INITIAL_COST+A.BROKERAGE))),0)PRICEACCR,

      NVL(SUM(DN_GET_OUTRIGHT_C_ACCR_INTR(
          DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - (M_PROCESS_DATE))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),(M_PROCESS_DATE)+1),
          A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,B.INT_RATE_BASE_CODE)),0)COUPONACCR,

      NVL(SUM(A.INITIAL_COST),0) INITCOST
 INTO  MTBOND_FACEVAL,MTBOND_PRICE_ACCR,MTBOND_COUPON_ACCR,BOND_COST

 FROM  DN_INV_OUTPS_DEAL_SERIAL_NO A,
       DN_TRN_OUTP_SALE B,
       DN_REF_SECURITY D
 WHERE A.INST_TYPE ='TBOND'
       AND (A.DEAL_NO=B.DEAL_NO)
       AND (A.SECURITY_CODE=D.SECURITY_CODE)
       AND (B.APP_STATUS <> 'CANCEL')
       AND ((TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')>(M_PROCESS_DATE))
            OR (A.SALE_EFF_VALDATE IS NULL))
       AND TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD-MON-YYYY'),'DD-MON-YYYY') <= (M_PROCESS_DATE)
       AND TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY') > (M_PROCESS_DATE)
 --GROUP BY M_PROCESS_DATE
 ;

     UPDATE  DN_REF_YIELD_FLUCTUATION
     SET     TBOND_FACE_VALUE=MTBOND_FACEVAL,
             TBOND_PRICE_ACCR=MTBOND_PRICE_ACCR,
             TBOND_COUPON_ACCR=MTBOND_COUPON_ACCR,
             BOND_INI_COST=BOND_COST
     WHERE   PROCESS_DATE=M_PROCESS_DATE;

     IF SQL%NOTFOUND THEN
      INSERT INTO DN_REF_YIELD_FLUCTUATION
                 (PROCESS_DATE,REPO_YIELD,REVERSE_REPO_YIELD,REPO_AMOUNT,REVERSE_REPO_AMOUNT,REPO_INTR,REVERSE_REPO_INTR,
                  TBOND_FACE_VALUE,TBOND_PRICE_ACCR,TBOND_COUPON_ACCR,
                  TBILL_FACE_VALUE,TBILL_PRICE_ACCR,TBOND_YIELD,TBILL_YIELD,BOND_INI_COST)
      VALUES
                 (M_PROCESS_DATE,0,0,0,0,0,0,MTBOND_FACEVAL,MTBOND_PRICE_ACCR,MTBOND_COUPON_ACCR,
                  0,0,0,0,BOND_COST);


     END IF;

--COMMIT;

---------------------------------------- FOR TBILLS------------------------------------------
---------------------------------------------------------------------------------------------
 SELECT
      NVL(SUM(A.FACE_VAL),0),
      NVL(SUM(DN_GET_OUTRIGHT_P_ACCR_INTR(
          DECODE(SIGN((TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY') - (M_PROCESS_DATE))),-1,TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),(M_PROCESS_DATE)+1),
          A.EFF_VALDATE,A.FACE_VAL,A.SECURITY_CODE,A.YIELD_WITH_BROKERAGE,B.INT_RATE_BASE_CODE,(A.INITIAL_COST+A.BROKERAGE))),0)PRICEACCR,
     NVL(SUM(A.INITIAL_COST),0) INITCOST

 INTO  MTBILL_FACEVAL,MTBILL_PRICE_ACCR,BILL_COST
 FROM  DN_INV_OUTPS_DEAL_SERIAL_NO A,
       DN_TRN_OUTP_SALE B,
       DN_REF_SECURITY D
 WHERE A.INST_TYPE ='TBILL'
       AND (A.DEAL_NO=B.DEAL_NO)
       AND (A.SECURITY_CODE=D.SECURITY_CODE)
       AND (B.APP_STATUS <> 'CANCEL')
       AND ((TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')>(M_PROCESS_DATE))
            OR (A.SALE_EFF_VALDATE IS NULL))
       AND TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD-MON-YYYY'),'DD-MON-YYYY') <= (M_PROCESS_DATE)
       AND TO_DATE(TO_CHAR(D.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY') > (M_PROCESS_DATE)
 --GROUP BY M_PROCESS_DATE
 ;

     UPDATE  DN_REF_YIELD_FLUCTUATION
     SET     TBILL_FACE_VALUE=MTBILL_FACEVAL,
             TBILL_PRICE_ACCR=MTBILL_PRICE_ACCR,
             BILL_INI_COST=BILL_COST
     WHERE PROCESS_DATE=M_PROCESS_DATE;

     IF SQL%NOTFOUND THEN
      INSERT INTO DN_REF_YIELD_FLUCTUATION
                 (PROCESS_DATE,REPO_YIELD,REVERSE_REPO_YIELD,REPO_AMOUNT,REVERSE_REPO_AMOUNT,REPO_INTR,REVERSE_REPO_INTR,
                  TBOND_FACE_VALUE,TBOND_PRICE_ACCR,TBOND_COUPON_ACCR,
                  TBILL_FACE_VALUE,TBILL_PRICE_ACCR,TBOND_YIELD,TBILL_YIELD,BILL_INI_COST)
      VALUES
                 (M_PROCESS_DATE,0,0,0,0,0,0,0,0,0,MTBILL_FACEVAL,MTBILL_PRICE_ACCR,0,0,BILL_COST);
     END IF;


----------------------------------------------------------------------------------------------
 M_TBOND_YIELD:=0;
 M_TBOND_YIELD_UPPER:=0;
 M_TBOND_YIELD_LOWER:=0;
 OPEN MY_CUR_TBOND;
 LOOP
 FETCH  MY_CUR_TBOND INTO
        MTBO_RR, MTBO_NN ;
 EXIT WHEN MY_CUR_TBOND%NOTFOUND;

   M_TBOND_YIELD_UPPER:=M_TBOND_YIELD_UPPER+(NVL(MTBO_RR,0)*NVL(MTBO_NN,0));
   M_TBOND_YIELD_LOWER:=M_TBOND_YIELD_LOWER+NVL(MTBO_RR,0);

 END LOOP;

  IF(M_TBOND_YIELD_LOWER=0)THEN
    M_TBOND_YIELD:=0;
  ELSE
    M_TBOND_YIELD:=M_TBOND_YIELD_UPPER/M_TBOND_YIELD_LOWER ;
  END IF;

 CLOSE MY_CUR_TBOND;
 ---------------------------------------------------------------------------------------------
 M_TBILL_YIELD:=0;
 M_TBILL_YIELD_UPPER:=0;
 M_TBILL_YIELD_LOWER:=0;

 OPEN MY_CUR_TBILL;
 LOOP
 FETCH  MY_CUR_TBILL INTO
        MTBI_RR, MTBI_NN ;
 EXIT WHEN MY_CUR_TBILL%NOTFOUND;

   M_TBILL_YIELD_UPPER:=M_TBILL_YIELD_UPPER+(NVL(MTBI_RR,0)*NVL(MTBI_NN,0));
   M_TBILL_YIELD_LOWER:=M_TBILL_YIELD_LOWER+NVL(MTBI_RR,0);

 END LOOP;
  IF(M_TBILL_YIELD_LOWER=0)THEN
    M_TBILL_YIELD:=0;
  ELSE
    M_TBILL_YIELD:=M_TBILL_YIELD_UPPER/M_TBILL_YIELD_LOWER ;
  END IF;

 CLOSE MY_CUR_TBILL;
----------------------------------------------------------------------------------------------
     UPDATE  DN_REF_YIELD_FLUCTUATION
     SET     TBOND_YIELD=M_TBOND_YIELD,
             TBILL_YIELD=M_TBILL_YIELD
     WHERE   PROCESS_DATE=M_PROCESS_DATE;

     IF SQL%NOTFOUND THEN
      INSERT INTO DN_REF_YIELD_FLUCTUATION
                 (PROCESS_DATE,REPO_YIELD,REVERSE_REPO_YIELD,REPO_AMOUNT,REVERSE_REPO_AMOUNT,REPO_INTR,REVERSE_REPO_INTR,
                  TBOND_FACE_VALUE,TBOND_PRICE_ACCR,TBOND_COUPON_ACCR,
                  TBILL_FACE_VALUE,TBILL_PRICE_ACCR,TBOND_YIELD,TBILL_YIELD)
      VALUES
                 (M_PROCESS_DATE,0,0,0,0,0,0,0,0,0,0,0,M_TBOND_YIELD,M_TBILL_YIELD);
     END IF;


COMMIT;

END DN_YIELD_FLUCTUATION;

/
