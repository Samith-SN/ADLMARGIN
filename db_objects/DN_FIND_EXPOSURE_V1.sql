--------------------------------------------------------
--  DDL for Procedure DN_FIND_EXPOSURE_V1
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_FIND_EXPOSURE_V1" 
(
 M_DATE         	   VARCHAR2--,--LMT_EXC_CURRENT.VIOLATED_DATE%TYPE,
 --EXP_LIST    IN OUT    EXPOSURE_PKG.EXPOSURE_LIST

)
AS

        --CREATED BY  : NIRMALA FERNANDO.
        --CREATED ON  : 28-MAR-2001.
        --SYSTEM      : FCAM DEALNET.
        --PURPOSE     : TO DISPLAY THE EXPOSURE REPORT.

    CURSOR MY_CUR IS
       SELECT    START_DAYS,END_DAYS
       FROM      LMT_STR_OVRL_EXPO
       GROUP BY  START_DAYS,END_DAYS
       ORDER BY  START_DAYS ;

    CURSOR LMT_CUR IS
            SELECT NIR.AA,NIR.BB,NIR.CC,NIR.DD,NIR.EE FROM
(SELECT   B.LIMIT_CODE AA,A.START_DAYS BB,A.END_DAYS CC,C.START_AMOUNT DD,C.END_AMOUNT EE
            FROM     DN_TEMP_EXPOSURE A,
                     LMT_STR_AUTHORITY B,
                     LMT_STR_OVRL_EXPO C
            WHERE    A.START_DAYS=C.START_DAYS AND
                     A.END_DAYS=C.END_DAYS AND
                     C.LIMIT_CODE=B.LIMIT_CODE AND
                     ((C.START_AMOUNT<=A.EXPBAND AND
                     C.END_AMOUNT >=A.EXPBAND))
           GROUP BY  B.LIMIT_CODE,A.START_DAYS,A.END_DAYS,C.START_AMOUNT,C.END_AMOUNT

UNION
SELECT   B.LIMIT_CODE AA,A.START_DAYS BB,A.END_DAYS CC,C.START_AMOUNT DD,C.END_AMOUNT EE
            FROM     DN_TEMP_EXPOSURE A,
                     LMT_STR_AUTHORITY B,
                     LMT_STR_OVRL_EXPO C
            WHERE    A.START_DAYS=C.START_DAYS AND
                     A.END_DAYS=C.END_DAYS AND
                     C.LIMIT_CODE=B.LIMIT_CODE AND
                     ((C.START_AMOUNT<=A.EXPBAND AND
                     C.END_AMOUNT IS NULL))
           GROUP BY  B.LIMIT_CODE,A.START_DAYS,A.END_DAYS,C.START_AMOUNT,C.END_AMOUNT)NIR

          ORDER BY  NIR.BB ASC;



   CURSOR CUMM_CUR IS
        SELECT   ROUND(AMOUNT_INV), ROUND(AMOUNT_RR), ROUND(AMOUNT_R),START_DAYS
        FROM   DN_TEMP_EXPOSURE
        ORDER BY START_DAYS DESC;

  CURSOR USER_CUR IS
     SELECT B.DN_USER,A.LIMIT_CODE
     FROM   DN_TEMP_EXPOSURE A,LMT_STR_AUTHORITY B
     WHERE  A.LIMIT_CODE=B.LIMIT_CODE;

M_COUNT_TAB     NUMBER;
M_COUNT_TAB1    NUMBER;
M_COUNT_TAB2    NUMBER;
M_START         NUMBER;
M_END           NUMBER;
M_AMOUNT        NUMBER;
M_WAVG          NUMBER;
M_WDAYS         NUMBER;
M_DESC          CHAR(2);
M_START_INV     NUMBER;
M_END_INV       NUMBER;
M_AMOUNT_INV    NUMBER;
M_WAVG_INV      NUMBER;
M_WDAYS_INV     NUMBER;
M_DESC_INV      CHAR(2);

M_START_RR      NUMBER;
M_END_RR        NUMBER;
M_AMOUNT_RR     NUMBER;
M_WAVG_RR       NUMBER;
M_WDAYS_RR      NUMBER;
M_DESC_RR       CHAR(2);

M_START_R       NUMBER;
M_END_R         NUMBER;
M_AMOUNT_R      NUMBER;
M_WAVG_R        NUMBER;
M_WDAYS_R       NUMBER;
M_DESC_R        CHAR(2);
MM_MAXDAYS      NUMBER;

V_AMOUNT_INV    NUMBER;
V_AMOUNT_RR     NUMBER;
V_AMOUNT_R      NUMBER;
V_START_DAYS    NUMBER;
VTOT_AMT        NUMBER;
VS_TOT_AMT      NUMBER;

UU_DN_USER       DN_TEMP_EXPOSURE.DN_USER%TYPE;
UU_LIMIT_CODE    DN_TEMP_EXPOSURE.LIMIT_CODE%TYPE;
RN_LIMIT_CODE    DN_TEMP_EXPOSURE.LIMIT_CODE%TYPE;
RN_START_DAYS    DN_TEMP_EXPOSURE.START_DAYS%TYPE;
RN_END_DAYS      DN_TEMP_EXPOSURE.END_DAYS%TYPE;
RN_START_AMOUNT  DN_TEMP_EXPOSURE.START_AMOUNT%TYPE;
RN_END_AMOUNT    DN_TEMP_EXPOSURE.END_AMOUNT%TYPE;


   BEGIN
    VTOT_AMT :=0;

       DELETE DN_TEMP_EXPOSURE;


       SELECT    MAX(END_DAYS)
       INTO      MM_MAXDAYS
       FROM      LMT_STR_OVRL_EXPO;


       OPEN MY_CUR;
   LOOP
          M_START :=0;
          M_END :=0;
          M_AMOUNT :=0;
          M_WAVG :=0;
          M_WDAYS :=0;

     FETCH MY_CUR INTO M_START,M_END;
   EXIT WHEN MY_CUR%NOTFOUND;


--RAISE_APPLICATION_ERROR(-20201,'M_START'||' '||M_START||' '||'M_END'||' '||M_END);




      SELECT COUNT(*)
      INTO M_COUNT_TAB
       FROM
         (SELECT
          M_START "COL1",
          M_END "COL2",
          SUM(A.CARR_VAL) "COL3",
          SUM(A.YIELD_WITH_BROKERAGE*100*A.CARR_VAL) "COL4",
          SUM(A.CARR_VAL*CEIL(B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')))"COL5",
          'IN' "COL6"
          FROM DN_INV_OUTPS_DEAL_SEC A,
               DN_REF_SECURITY B,
               DN_REF_PORTFOLIO C
          WHERE A.SECURITY_CODE=B.SECURITY_CODE AND
                A.EFF_VALDATE<=TO_DATE(M_DATE,'DD/MM/YYYY') AND
                B.MATURITY_DATE>TO_DATE(M_DATE,'DD/MM/YYYY')  AND
                A.TRN_TYPE ='B' AND
    	        C.PORTFOLIO_CODE=A.PORTFOLIO_CODE AND
	            C.PF_TYPE='P'  AND
                C.OWNED_BY_MBFSL='Y' AND
                B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END AND
                A.FACE_VAL<>0


     UNION ALL
       SELECT
          M_START "COL1",
          M_END "COL2",
          SUM(A.CARR_VAL) "COL3",
          SUM(A.YIELD_WITH_BROKERAGE*100*A.CARR_VAL) "COL4",
          SUM(A.CARR_VAL*CEIL(B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')))"COL5",
          'IN' "COL6"
          FROM DN_INV_OUTPS_DEAL_SEC A,
              DN_REF_SECURITY B,
              DN_REF_PORTFOLIO C
          WHERE A.SECURITY_CODE=B.SECURITY_CODE
              AND
                  A.EFF_VALDATE<=TO_DATE(M_DATE,'DD/MM/YYYY')
              AND
                  B.MATURITY_DATE>TO_DATE(M_DATE,'DD/MM/YYYY')
              AND
                  A.TRN_TYPE ='S'
              AND
    	          C.PORTFOLIO_CODE=A.PORTFOLIO_CODE
  	          AND
	              C.PF_TYPE='P'
              AND
                  C.OWNED_BY_MBFSL='Y' AND
                   B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END AND
                A.FACE_VAL<>0





      UNION ALL
       SELECT
          M_START "COL1",
          M_END "COL2",
          SUM(A.CARR_VAL) "COL3",
          SUM(A.YIELD_WITH_BROKERAGE*100*A.CARR_VAL) "COL4",
          SUM(A.CARR_VAL*CEIL(B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')))"COL5",
          'IN' "COL6"
          FROM DN_INV_OUTPS_DEAL_SERIAL_NO A,
			   DN_REF_SECURITY B,
                DN_REF_PORTFOLIO C
		  WHERE A.SECURITY_CODE=B.SECURITY_CODE
               AND
					A.EFF_VALDATE<=TO_DATE(M_DATE,'DD/MM/YYYY')
               AND
                    B.MATURITY_DATE>TO_DATE(M_DATE,'DD/MM/YYYY')--
               AND
                   (( A.SERIAL_NO_STATUS='INV')
               OR
                    (TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')>TO_DATE(M_DATE,'DD/MM/YYYY')) OR (A.SALE_EFF_VALDATE IS NULL))
              AND
    	            C.PORTFOLIO_CODE=A.PORTFOLIO_CODE
  	          AND
	                C.PF_TYPE='P'
              AND
                    C.OWNED_BY_MBFSL='Y'AND
                   B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END


     UNION ALL
       SELECT
          M_START "COL1",
          M_END "COL2",
          SUM(A.CARR_VAL) "COL3",
          SUM(A.YIELD_WITH_BROKERAGE*100*A.CARR_VAL) "COL4",
          SUM(A.CARR_VAL*CEIL(B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')))"COL5",
          'IN' "COL6"
          FROM DN_HIS_OUTPS_DEAL_SERIAL_NO A,
			   DN_REF_SECURITY B,
                DN_REF_PORTFOLIO C
		  WHERE A.SECURITY_CODE=B.SECURITY_CODE
               AND
					A.EFF_VALDATE<=TO_DATE(M_DATE,'DD/MM/YYYY')
               AND
                    B.MATURITY_DATE>TO_DATE(M_DATE,'DD/MM/YYYY')--
               AND
                   ((TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')>TO_DATE(M_DATE,'DD/MM/YYYY')) OR (A.SALE_EFF_VALDATE IS NULL))
              AND
    	            C.PORTFOLIO_CODE=A.PORTFOLIO_CODE
  	          AND
	                C.PF_TYPE='P'
              AND
                    C.OWNED_BY_MBFSL='Y'AND
                   B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END
  /* ***********************FROM TRANSACTION TABLES  ************************** */
    UNION ALL
       SELECT  M_START "COL1",
         M_END "COL2",
          SUM(A.COST) "COL3",
          SUM(A.YIELD*100*A.COST) "COL4",
          SUM(A.COST*CEIL(C.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')))"COL5",
          'IN' "COL6"
	   FROM
	      DN_TRN_OUTP_SALE A,
	      DN_REF_PORTFOLIO B,
          DN_REF_SECURITY C
	   WHERE
             A.SECURITY_CODE=C.SECURITY_CODE
          AND
            A.EFF_VALDATE<= TO_DATE(M_DATE,'DD/MM/YYYY')
          AND A.SECURITY_CODE IN
    		(
    		SELECT SECURITY_CODE FROM DN_REF_SECURITY WHERE  MATURITY_DATE > TO_DATE(M_DATE,'DD/MM/YYYY')--
    	   	)
          AND
    	      B.PORTFOLIO_CODE=A.BUY_PORTFOLIO_CODE
  	      AND
	          B.PF_TYPE='P'
          AND
              B.OWNED_BY_MBFSL='Y'
          AND
              APP_STATUS NOT IN ('CONF','CANCEL')AND
                   C.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                C.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END


      UNION ALL
       SELECT  M_START "COL1",
         M_END "COL2",
          DN_LIMIT_DEDUCT_SUM(SUM(A.COST)) "COL3",
          SUM(A.YIELD*100*DN_LIMIT_DEDUCT_SUM(A.COST))"COL4",
          SUM(A.COST*CEIL(C.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')))"COL5",
          'IN' "COL6"
	   FROM
	      DN_TRN_OUTP_SALE A,
	      DN_REF_PORTFOLIO B,
          DN_REF_SECURITY C
	   WHERE
            A.SECURITY_CODE=C.SECURITY_CODE
          AND
            A.EFF_VALDATE<= TO_DATE(M_DATE,'DD/MM/YYYY')
          AND A.SECURITY_CODE IN
    		(
    		SELECT SECURITY_CODE FROM DN_REF_SECURITY WHERE  MATURITY_DATE > TO_DATE(M_DATE,'DD/MM/YYYY')--
    	   	)
          AND
    	      B.PORTFOLIO_CODE=A.SELL_PORTFOLIO_CODE
  	      AND
	          B.PF_TYPE='P'
          AND
              B.OWNED_BY_MBFSL='Y'
          AND
              APP_STATUS NOT IN ('CONF','CANCEL')AND
                   C.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                C.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END
      )TAB
      GROUP BY TAB.COL1,TAB.COL2,TAB.COL6;

      IF(M_COUNT_TAB>0)THEN

      SELECT TAB.COL1,TAB.COL2,SUM(TAB.COL3),DECODE(SUM(TAB.COL3),0,0,(SUM(TAB.COL4)/SUM(TAB.COL3))),DECODE(SUM(TAB.COL3),0,0,(SUM(TAB.COL5)/SUM(TAB.COL3))),TAB.COL6
      INTO M_START_INV,M_END_INV,M_AMOUNT_INV,M_WAVG_INV,M_WDAYS_INV,M_DESC_INV
       FROM
         (SELECT
          M_START "COL1",
          M_END "COL2",
          SUM(A.CARR_VAL) "COL3",
          SUM(A.YIELD_WITH_BROKERAGE*100*A.CARR_VAL)"COL4",
          SUM(A.CARR_VAL*CEIL(B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')))"COL5",
          'IN' "COL6"
          FROM DN_INV_OUTPS_DEAL_SEC A,
               DN_REF_SECURITY B,
               DN_REF_PORTFOLIO C
          WHERE A.SECURITY_CODE=B.SECURITY_CODE AND
                A.EFF_VALDATE<=TO_DATE(M_DATE,'DD/MM/YYYY') AND
                B.MATURITY_DATE>TO_DATE(M_DATE,'DD/MM/YYYY')  AND
                A.TRN_TYPE ='B' AND
    	        C.PORTFOLIO_CODE=A.PORTFOLIO_CODE AND
	            C.PF_TYPE='P'  AND
                C.OWNED_BY_MBFSL='Y' AND
                B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END AND
                A.FACE_VAL<>0



        -- GROUP BY M_START,M_END


     UNION ALL
       SELECT
          M_START "COL1",
          M_END "COL2",
          SUM(A.CARR_VAL) "COL3",
          SUM(A.YIELD_WITH_BROKERAGE*100*A.CARR_VAL)"COL4",
          SUM(A.CARR_VAL*CEIL(B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')))"COL5",
          'IN' "COL6"
          FROM DN_INV_OUTPS_DEAL_SEC A,
              DN_REF_SECURITY B,
              DN_REF_PORTFOLIO C
          WHERE A.SECURITY_CODE=B.SECURITY_CODE
              AND
                  A.EFF_VALDATE<=TO_DATE(M_DATE,'DD/MM/YYYY')
              AND
                  B.MATURITY_DATE>TO_DATE(M_DATE,'DD/MM/YYYY')--
              AND
                  A.TRN_TYPE ='S'
              AND
    	          C.PORTFOLIO_CODE=A.PORTFOLIO_CODE
  	          AND
	              C.PF_TYPE='P'
              AND
                  C.OWNED_BY_MBFSL='Y' AND
                   B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END AND
                A.FACE_VAL<>0






      UNION ALL
       SELECT
          M_START "COL1",
          M_END "COL2",
          SUM(A.CARR_VAL) "COL3",
          SUM(A.YIELD_WITH_BROKERAGE*100*A.CARR_VAL)"COL4",
          SUM(A.CARR_VAL*CEIL(B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')))"COL5",
          'IN' "COL6"
          FROM DN_INV_OUTPS_DEAL_SERIAL_NO A,
			   DN_REF_SECURITY B,
                DN_REF_PORTFOLIO C
		  WHERE A.SECURITY_CODE=B.SECURITY_CODE
               AND
					A.EFF_VALDATE<=TO_DATE(M_DATE,'DD/MM/YYYY')
               AND
                    B.MATURITY_DATE>TO_DATE(M_DATE,'DD/MM/YYYY')--
               AND
                   (( A.SERIAL_NO_STATUS='INV')
               OR
                    (TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')>TO_DATE(M_DATE,'DD/MM/YYYY')) OR (A.SALE_EFF_VALDATE IS NULL))
              AND
    	            C.PORTFOLIO_CODE=A.PORTFOLIO_CODE
  	          AND
	                C.PF_TYPE='P'
              AND
                    C.OWNED_BY_MBFSL='Y'AND
                   B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END


     UNION ALL
       SELECT
          M_START "COL1",
          M_END "COL2",
          SUM(A.CARR_VAL) "COL3",
          SUM(A.YIELD_WITH_BROKERAGE*100*A.CARR_VAL)"COL4",
          SUM(A.CARR_VAL*CEIL(B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')))"COL5",
          'IN' "COL6"
          FROM DN_HIS_OUTPS_DEAL_SERIAL_NO A,
			   DN_REF_SECURITY B,
                DN_REF_PORTFOLIO C
		  WHERE A.SECURITY_CODE=B.SECURITY_CODE
               AND
					A.EFF_VALDATE<=TO_DATE(M_DATE,'DD/MM/YYYY')
               AND
                    B.MATURITY_DATE>TO_DATE(M_DATE,'DD/MM/YYYY')--
               AND
                   ((TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')>TO_DATE(M_DATE,'DD/MM/YYYY')) OR (A.SALE_EFF_VALDATE IS NULL))
              AND
    	            C.PORTFOLIO_CODE=A.PORTFOLIO_CODE
  	          AND
	                C.PF_TYPE='P'
              AND
                    C.OWNED_BY_MBFSL='Y'AND
                   B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                B.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END
  /* ***********************FROM TRANSACTION TABLES  ************************** */
    UNION ALL
       SELECT  M_START "COL1",
         M_END "COL2",
          SUM(A.COST) "COL3",
          SUM(A.YIELD*100*A.COST) "COL4",
          SUM(A.COST*CEIL(C.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')))  "COL5",
           'IN' "COL6"
	   FROM
	      DN_TRN_OUTP_SALE A,
	      DN_REF_PORTFOLIO B,
          DN_REF_SECURITY C
	   WHERE
             A.SECURITY_CODE=C.SECURITY_CODE
          AND
            A.EFF_VALDATE<= TO_DATE(M_DATE,'DD/MM/YYYY')
          AND A.SECURITY_CODE IN
    		(
    		SELECT SECURITY_CODE FROM DN_REF_SECURITY WHERE  MATURITY_DATE > TO_DATE(M_DATE,'DD/MM/YYYY')--
    	   	)
          AND
    	      B.PORTFOLIO_CODE=A.BUY_PORTFOLIO_CODE
  	      AND
	          B.PF_TYPE='P'
          AND
              B.OWNED_BY_MBFSL='Y'
          AND
              APP_STATUS NOT IN ('CONF','CANCEL')AND
                   C.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                C.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END


      UNION ALL
       SELECT  M_START "COL1",
         M_END "COL2",
          DN_LIMIT_DEDUCT_SUM(SUM(A.COST)) "COL3",
          SUM(A.YIELD*100*DN_LIMIT_DEDUCT_SUM(A.COST)) "COL4",
          SUM(A.COST*CEIL(C.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY'))) "COL5",
            'IN' "COL6"
	   FROM
	      DN_TRN_OUTP_SALE A,
	      DN_REF_PORTFOLIO B,
          DN_REF_SECURITY C
	   WHERE
            A.SECURITY_CODE=C.SECURITY_CODE
          AND
            A.EFF_VALDATE<= TO_DATE(M_DATE,'DD/MM/YYYY')
          AND A.SECURITY_CODE IN
    		(
    		SELECT SECURITY_CODE FROM DN_REF_SECURITY WHERE  MATURITY_DATE > TO_DATE(M_DATE,'DD/MM/YYYY')--
    	   	)
          AND
    	      B.PORTFOLIO_CODE=A.SELL_PORTFOLIO_CODE
  	      AND
	          B.PF_TYPE='P'
          AND
              B.OWNED_BY_MBFSL='Y'
          AND
              APP_STATUS NOT IN ('CONF','CANCEL')AND
                   C.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                C.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END
      )TAB
      GROUP BY TAB.COL1,TAB.COL2,TAB.COL6;

              UPDATE  DN_TEMP_EXPOSURE
             SET  AMOUNT_INV=M_AMOUNT_INV,
                  WAVG_INV=M_WAVG_INV,
                  WDAYS_INV=M_WDAYS_INV ,
                  DESCRIPTION_INV=M_DESC_INV
             WHERE START_DAYS=M_START_INV AND
                   END_DAYS=M_END_INV;




        IF SQL%NOTFOUND THEN

                INSERT INTO DN_TEMP_EXPOSURE
                  (START_DAYS,END_DAYS,AMOUNT_INV,WAVG_INV,WDAYS_INV,DESCRIPTION_INV)
                VALUES
                  (M_START_INV,M_END_INV,M_AMOUNT_INV,M_WAVG_INV,M_WDAYS_INV,M_DESC_INV);

        END IF;

END IF;
-------------------------------
---------------------------------
--------------------------------
---------------------------
 SELECT COUNT(*)
    INTO  M_COUNT_TAB1
       FROM
         (
       SELECT
          M_START "COL1",
          M_END "COL2",
          SUM(A.LEG1_VALUE+A.INT_ACCR) "COL3",
          SUM(A.YIELD*100*(A.LEG1_VALUE+A.INT_ACCR)) "COL4",
          SUM((A.LEG1_VALUE+A.INT_ACCR)* CEIL(A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY'))) "COL5",
           'RE' "COL6"

          FROM DN_TRN_REPO_FRESH A,
			   DN_REF_PORTFOLIO B
		  WHERE A.BORR_PORTFOLIO_CODE =B.PORTFOLIO_CODE
	              AND
	                    A.EFF_VALDATE<=TO_DATE(M_DATE,'DD/MM/YYYY')
		          AND
	                    A.MATURITY_DATE>TO_DATE(M_DATE,'DD/MM/YYYY')--
		          AND
			            A.APP_STATUS!='CANCEL'
                  AND
	                    B.PF_TYPE='P'
                  AND
                        B.OWNED_BY_MBFSL='Y'AND
                   A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END

UNION ALL
       SELECT
          M_START "COL1",
          M_END "COL2",
          SUM(A.LEG1_VALUE+A.INT_ACCR) "COL3",
          SUM(A.YEILD*100*(A.LEG1_VALUE+A.INT_ACCR))"COL4",
          SUM((A.LEG1_VALUE+A.INT_ACCR)*CEIL(A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')))  "COL5",
            'RE' "COL6"
          FROM DN_TRN_REPO_ROLLOVER A,
			   DN_REF_PORTFOLIO B
		  WHERE A.BORR_PORTFOLIO_CODE =B.PORTFOLIO_CODE
	              AND
	                    A.EFF_VALDATE<=TO_DATE(M_DATE,'DD/MM/YYYY')
		          AND
	                    A.MATURITY_DATE>TO_DATE(M_DATE,'DD/MM/YYYY')--
		          AND
			            A.APP_STATUS!='CANCEL'
                  AND
	                    B.PF_TYPE='P'
                  AND
                        B.OWNED_BY_MBFSL='Y'AND
                   A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END

            UNION ALL
       SELECT
          M_START "COL1",
          M_END "COL2",
          SUM(A.LEG1_VALUE) "COL3",
          SUM(A.YEILD_PER_NET*100*(A.LEG1_VALUE+A.INT_ACCR))  "COL4",
          SUM((A.LEG1_VALUE+A.INT_ACCR)*CEIL(A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY'))) "COL5",
            'RE' "COL6"
          FROM DN_TRN_BL_FUND A,
			   DN_REF_PORTFOLIO B
		  WHERE A.BORR_PORTFOLIO_CODE =B.PORTFOLIO_CODE
	              AND
	                    A.EFF_VALDATE<=TO_DATE(M_DATE,'DD/MM/YYYY')
		          AND
	                    A.MATURITY_DATE>TO_DATE(M_DATE,'DD/MM/YYYY')--
		          AND
			            A.APP_STATUS!='CANCEL'
                  AND
	                    B.PF_TYPE='P'
                  AND
                        B.OWNED_BY_MBFSL='Y'AND
                   A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END
         )TAB1
          GROUP BY TAB1.COL1,TAB1.COL2,TAB1.COL6;

IF(M_COUNT_TAB1>0)THEN

    SELECT TAB1.COL1,TAB1.COL2,SUM(TAB1.COL3),DECODE(SUM(TAB1.COL3),0,0,(SUM(TAB1.COL4)/SUM(TAB1.COL3))),DECODE(SUM(TAB1.COL3),0,0,(SUM(TAB1.COL5)/SUM(TAB1.COL3))),TAB1.COL6
    INTO  M_START_R,M_END_R,M_AMOUNT_R,M_WAVG_R,M_WDAYS_R,M_DESC_R
       FROM
         (
       SELECT
          M_START "COL1",
          M_END "COL2",
          SUM(A.LEG1_VALUE+A.INT_ACCR) "COL3",
          SUM(A.YIELD*100*(A.LEG1_VALUE+A.INT_ACCR))"COL4",
          SUM((A.LEG1_VALUE+A.INT_ACCR)*CEIL(A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY'))) "COL5",
           'RE' "COL6"

          FROM DN_TRN_REPO_FRESH A,
			   DN_REF_PORTFOLIO B
		  WHERE A.BORR_PORTFOLIO_CODE =B.PORTFOLIO_CODE
	              AND
	                    A.EFF_VALDATE<=TO_DATE(M_DATE,'DD/MM/YYYY')
		          AND
	                    A.MATURITY_DATE>TO_DATE(M_DATE,'DD/MM/YYYY')--
		          AND
			            A.APP_STATUS!='CANCEL'
                  AND
	                    B.PF_TYPE='P'
                  AND
                        B.OWNED_BY_MBFSL='Y'AND
                   A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END

UNION ALL
       SELECT
          M_START "COL1",
          M_END "COL2",
          SUM(A.LEG1_VALUE+A.INT_ACCR) "COL3",
          SUM(A.YEILD*100*(A.LEG1_VALUE+A.INT_ACCR))"COL4",
          SUM((A.LEG1_VALUE+A.INT_ACCR)*CEIL(A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY'))) "COL5",
           'RE' "COL6"
          FROM DN_TRN_REPO_ROLLOVER A,
			   DN_REF_PORTFOLIO B
		  WHERE A.BORR_PORTFOLIO_CODE =B.PORTFOLIO_CODE
	              AND
	                    A.EFF_VALDATE<=TO_DATE(M_DATE,'DD/MM/YYYY')
		          AND
	                    A.MATURITY_DATE>TO_DATE(M_DATE,'DD/MM/YYYY')--
		          AND
			            A.APP_STATUS!='CANCEL'
                  AND
	                    B.PF_TYPE='P'
                  AND
                        B.OWNED_BY_MBFSL='Y'AND
                   A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END

            UNION ALL
       SELECT
          M_START "COL1",
          M_END "COL2",
          SUM(A.LEG1_VALUE) "COL3",
          SUM(A.YEILD_PER_NET*100*(A.LEG1_VALUE+A.INT_ACCR)) "COL4",
          SUM((A.LEG1_VALUE+A.INT_ACCR)*CEIL(A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY'))) "COL5",
           'RE' "COL6"
          FROM DN_TRN_BL_FUND A,
			   DN_REF_PORTFOLIO B
		  WHERE A.BORR_PORTFOLIO_CODE =B.PORTFOLIO_CODE
	              AND
	                    A.EFF_VALDATE<=TO_DATE(M_DATE,'DD/MM/YYYY')
		          AND
	                    A.MATURITY_DATE>TO_DATE(M_DATE,'DD/MM/YYYY')--
		          AND
			            A.APP_STATUS!='CANCEL'
                  AND
	                    B.PF_TYPE='P'
                  AND
                        B.OWNED_BY_MBFSL='Y'AND
                   A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END
          )TAB1
          GROUP BY TAB1.COL1,TAB1.COL2,TAB1.COL6;

             UPDATE  DN_TEMP_EXPOSURE
             SET  AMOUNT_R=M_AMOUNT_R,
                  WAVG_R=M_WAVG_R,
                  WDAYS_R=M_WDAYS_R ,
                  DESCRIPTION_R=M_DESC_R
             WHERE START_DAYS=M_START_R AND
                   END_DAYS=M_END_R;

        IF SQL%NOTFOUND THEN

                 INSERT INTO DN_TEMP_EXPOSURE
                  (START_DAYS,END_DAYS,AMOUNT_R,WAVG_R,WDAYS_R,DESCRIPTION_R)
                VALUES
                  (M_START_R,M_END_R,M_AMOUNT_R,M_WAVG_R,M_WDAYS_R,M_DESC_R);
        END IF;

END IF;

---------------------------------------
---------------------------------------
--------------------------------------
-----------------------------------------
----------------------------------------
-----------------------------------------
SELECT COUNT(*)
      INTO M_COUNT_TAB2
       FROM
         (
       SELECT
          M_START "COL1",
          M_END "COL2",
          SUM(A.LEG1_VALUE+A.INT_ACCR) "COL3",
          SUM(A.YIELD*100*(A.LEG1_VALUE+A.INT_ACCR)) "COL4",
          SUM((A.LEG1_VALUE+A.INT_ACCR)*CEIL(A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')))  "COL5",
            'RR' "COL6"


          FROM DN_TRN_REPO_FRESH A,
			   DN_REF_PORTFOLIO B
		  WHERE A.LEND_PORTFOLIO_CODE =B.PORTFOLIO_CODE
	              AND
	                    A.EFF_VALDATE<=TO_DATE(M_DATE,'DD/MM/YYYY')
		          AND
	                    A.MATURITY_DATE>TO_DATE(M_DATE,'DD/MM/YYYY')--
		          AND
			            A.APP_STATUS!='CANCEL'
                  AND
	                    B.PF_TYPE='P'
                  AND
                        B.OWNED_BY_MBFSL='Y'AND
                   A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END


        UNION ALL
       SELECT
          M_START "COL1",
          M_END "COL2",
          SUM(A.LEG1_VALUE+A.INT_ACCR) "COL3",
          SUM(YEILD*100*(A.LEG1_VALUE+A.INT_ACCR))  "COL4",
          SUM((A.LEG1_VALUE+A.INT_ACCR)*CEIL(A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')))  "COL5",
            'RR' "COL6"

          FROM DN_TRN_REPO_ROLLOVER A,
			   DN_REF_PORTFOLIO B
		  WHERE A.LEND_PORTFOLIO_CODE =B.PORTFOLIO_CODE
	              AND
	                    A.EFF_VALDATE<=TO_DATE(M_DATE,'DD/MM/YYYY')
		          AND
	                    A.MATURITY_DATE>TO_DATE(M_DATE,'DD/MM/YYYY')
		          AND
			            A.APP_STATUS!='CANCEL'
                  AND
	                    B.PF_TYPE='P'
                  AND
                        B.OWNED_BY_MBFSL='Y'AND
                   A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END

      UNION ALL
       SELECT
          M_START "COL1",
          M_END "COL2",
          SUM(A.LEG1_VALUE) "COL3",
           SUM(A.YEILD_PER_NET*100*(A.LEG1_VALUE+A.INT_ACCR))  "COL4",
            SUM((A.LEG1_VALUE+A.INT_ACCR)*CEIL(A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY'))) "COL5",
            'RR' "COL6"
          FROM DN_TRN_BL_FUND A,
			   DN_REF_PORTFOLIO B
		  WHERE A.LEND_PORTFOLIO_CODE =B.PORTFOLIO_CODE
	              AND
	                    A.EFF_VALDATE<=TO_DATE(M_DATE,'DD/MM/YYYY')
		          AND
	                    A.MATURITY_DATE>TO_DATE(M_DATE,'DD/MM/YYYY')--
		          AND
			            A.APP_STATUS!='CANCEL'
                  AND
	                    B.PF_TYPE='P'
                  AND
                        B.OWNED_BY_MBFSL='Y'AND
                   A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END
           )TAB2
          GROUP BY TAB2.COL1,TAB2.COL2,TAB2.COL6;


IF(M_COUNT_TAB2>0)THEN
          SELECT TAB2.COL1,TAB2.COL2,SUM(TAB2.COL3),DECODE(SUM(TAB2.COL3),0,0,(SUM(TAB2.COL4)/SUM(TAB2.COL3))),DECODE(SUM(TAB2.COL3),0,0,(SUM(TAB2.COL5)/SUM(TAB2.COL3))),TAB2.COL6
      INTO M_START_RR,M_END_RR,M_AMOUNT_RR,M_WAVG_RR,M_WDAYS_RR,M_DESC_RR
       FROM
         (
       SELECT
          M_START "COL1",
          M_END "COL2",
          SUM(A.LEG1_VALUE+A.INT_ACCR) "COL3",
          SUM(A.YIELD*100*(A.LEG1_VALUE+A.INT_ACCR)) "COL4",
           SUM((A.LEG1_VALUE+A.INT_ACCR)*CEIL(A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')))  "COL5",
            'RR' "COL6"


          FROM DN_TRN_REPO_FRESH A,
			   DN_REF_PORTFOLIO B
		  WHERE A.LEND_PORTFOLIO_CODE =B.PORTFOLIO_CODE
	              AND
	                    A.EFF_VALDATE<=TO_DATE(M_DATE,'DD/MM/YYYY')
		          AND
	                    A.MATURITY_DATE>TO_DATE(M_DATE,'DD/MM/YYYY')--
		          AND
			            A.APP_STATUS!='CANCEL'
                  AND
	                    B.PF_TYPE='P'
                  AND
                        B.OWNED_BY_MBFSL='Y'AND
                   A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END

        UNION ALL
       SELECT
          M_START "COL1",
          M_END "COL2",
          SUM(A.LEG1_VALUE+A.INT_ACCR) "COL3",
          SUM(YEILD*100*(A.LEG1_VALUE+A.INT_ACCR)) "COL4",
          SUM((A.LEG1_VALUE+A.INT_ACCR)*CEIL(A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')))  "COL5",
            'RR' "COL6"

          FROM DN_TRN_REPO_ROLLOVER A,
			   DN_REF_PORTFOLIO B
		  WHERE A.LEND_PORTFOLIO_CODE =B.PORTFOLIO_CODE
	              AND
	                    A.EFF_VALDATE<=TO_DATE(M_DATE,'DD/MM/YYYY')
		          AND
	                    A.MATURITY_DATE>TO_DATE(M_DATE,'DD/MM/YYYY')--
		          AND
			            A.APP_STATUS!='CANCEL'
                  AND
	                    B.PF_TYPE='P'
                  AND
                        B.OWNED_BY_MBFSL='Y'AND
                   A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END

      UNION ALL
       SELECT
          M_START "COL1",
          M_END "COL2",
          SUM(A.LEG1_VALUE) "COL3",
           SUM(A.YEILD_PER_NET*100*(A.LEG1_VALUE+A.INT_ACCR))  "COL4",
           SUM((A.LEG1_VALUE+A.INT_ACCR)*CEIL(A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY'))) "COL5",
            'RR' "COL6"
          FROM DN_TRN_BL_FUND A,
			   DN_REF_PORTFOLIO B
		  WHERE A.LEND_PORTFOLIO_CODE =B.PORTFOLIO_CODE
	              AND
	                    A.EFF_VALDATE<=TO_DATE(M_DATE,'DD/MM/YYYY')
		          AND
	                    A.MATURITY_DATE>TO_DATE(M_DATE,'DD/MM/YYYY')
		          AND
			            A.APP_STATUS!='CANCEL'
                  AND
	                    B.PF_TYPE='P'
                  AND
                        B.OWNED_BY_MBFSL='Y'AND
                   A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')>=M_START AND
                A.MATURITY_DATE-TO_DATE(M_DATE,'DD/MM/YYYY')<=M_END

          )TAB2
          GROUP BY TAB2.COL1,TAB2.COL2,TAB2.COL6;

              UPDATE  DN_TEMP_EXPOSURE
             SET  AMOUNT_RR=M_AMOUNT_RR,
                  WAVG_RR=M_WAVG_RR,
                  WDAYS_RR=M_WDAYS_RR ,
                  DESCRIPTION_RR=M_DESC_RR
             WHERE START_DAYS=M_START_RR AND
                   END_DAYS=M_END_RR;




        IF SQL%NOTFOUND THEN

                  INSERT INTO DN_TEMP_EXPOSURE
                  (START_DAYS,END_DAYS,AMOUNT_RR,WAVG_RR,WDAYS_RR,DESCRIPTION_RR)
                VALUES
                  ( M_START_RR,M_END_RR,M_AMOUNT_RR,M_WAVG_RR,M_WDAYS_RR,M_DESC_RR);

         END IF;
END IF;
    END LOOP;
    COMMIT;
     CLOSE MY_CUR;


OPEN CUMM_CUR;
 LOOP
     FETCH CUMM_CUR INTO  V_AMOUNT_INV,V_AMOUNT_RR, V_AMOUNT_R,V_START_DAYS;
 EXIT WHEN CUMM_CUR%NOTFOUND;

   VTOT_AMT:=NVL(VTOT_AMT,0)+((NVL(V_AMOUNT_INV,0)+NVL(V_AMOUNT_RR,0))-NVL(V_AMOUNT_R,0));
   VS_TOT_AMT:=((NVL(V_AMOUNT_INV,0)+NVL(V_AMOUNT_RR,0))-NVL(V_AMOUNT_R,0));

   UPDATE  DN_TEMP_EXPOSURE
   SET     CUMM_TOTAL=VTOT_AMT,
           EXPBAND=VS_TOT_AMT
   WHERE   START_DAYS=V_START_DAYS;

END LOOP;
CLOSE CUMM_CUR;
COMMIT;

OPEN LMT_CUR;
LOOP
FETCH LMT_CUR INTO RN_LIMIT_CODE,RN_START_DAYS,RN_END_DAYS,RN_START_AMOUNT,RN_END_AMOUNT;
EXIT WHEN LMT_CUR%NOTFOUND;
--IF(RN_END_AMOUNT IS NULL)THEN
--RN_START_AMOUNT:='';
--END IF;

   UPDATE  DN_TEMP_EXPOSURE
   SET     LIMIT_CODE=RN_LIMIT_CODE,
           START_AMOUNT=RN_START_AMOUNT,
           END_AMOUNT=RN_END_AMOUNT

   WHERE   START_DAYS=RN_START_DAYS AND
           END_DAYS=RN_END_DAYS;


END LOOP;
CLOSE LMT_CUR;
COMMIT;



OPEN USER_CUR;
LOOP
FETCH USER_CUR INTO UU_DN_USER,UU_LIMIT_CODE;
EXIT WHEN USER_CUR%NOTFOUND;

   UPDATE  DN_TEMP_EXPOSURE
   SET     DN_USER=UU_DN_USER||','||DN_USER
   WHERE   LIMIT_CODE=UU_LIMIT_CODE;


END LOOP;
CLOSE USER_CUR;
COMMIT;





      /*  OPEN EXP_LIST FOR
        SELECT START_DAYS,END_DAYS,
               ROUND(AMOUNT_INV),--3
               ROUND(WAVG_INV,2),ROUND(NVL(WDAYS_INV,0)),DESCRIPTION_INV,
               ROUND(AMOUNT_RR),--7
               ROUND(WAVG_RR,2),ROUND(NVL(WDAYS_RR,0)),
               DESCRIPTION_RR,
               ROUND(AMOUNT_R),--11
               ROUND(WAVG_R,2),
               ROUND(NVL(WDAYS_R,0)),DESCRIPTION_R,
               CUMM_TOTAL,--15
               NVL(START_AMOUNT,-99),--16
               NVL(END_AMOUNT,-99),--17
               NVL(DN_USER,'-')--18
        FROM   DN_TEMP_EXPOSURE
        ORDER BY START_DAYS ASC;*/


       END DN_FIND_EXPOSURE_V1;

/
