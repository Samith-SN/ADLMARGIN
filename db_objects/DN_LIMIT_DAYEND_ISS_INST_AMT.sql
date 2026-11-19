--------------------------------------------------------
--  DDL for Procedure DN_LIMIT_DAYEND_ISS_INST_AMT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_LIMIT_DAYEND_ISS_INST_AMT" 
(
	M_DATE    	LMT_EXC_CURRENT.VIOLATED_DATE%TYPE
)

AS

    /* Function     : Calculate totall face value at the end of the day and update
					  Transaction and violation tables-FOR OVRL_MATU
    -- System       : DEALNET System
    -- Created by   : V.Sukathisvaran
    -- Created on   : 05/01/2000 */

	    TOTAL					DN_INV_OUTPS_DEAL_SEC.FACE_VAL%TYPE;
		M_LIMIT_CODE       		LMT_STR_OVRL_AMT.LIMIT_CODE%TYPE;
		M_COUNT					NUMBER;
		M_ACTIVATE_COUNT		NUMBER;
		--M_MATURITY_DAY		NUMBER;
        M_START_DAYS			NUMBER;
        M_END_DAYS			    NUMBER;
		M_FACE_VALUE			DN_INV_OUTPS_DEAL_SEC.FACE_VAL%TYPE;
		M_TOT_FACE 				DN_INV_OUTPS_DEAL_SEC.FACE_VAL%TYPE;
        --M_ROW_ID                NUMBER;
        M_AUCTION_TYPE          LMT_UTL_ISSUER_INST_MATU.AUCTION_TYPE%TYPE;
        M_ISSUER_CODE           LMT_UTL_ISSUER_INST_MATU.ISSUER_CODE%TYPE;
        M_ISSUER_LIABILITY_TYPE LMT_UTL_ISSUER_INST_MATU.ISSUER_LIABILITY_TYPE%TYPE;
        M_INST_TYPE             LMT_UTL_ISSUER_INST_MATU.INST_TYPE %TYPE;

CURSOR MYCURSOR IS
  SELECT SUM(COL3),COL4,COL5,COL6,COL7 FROM
  (/********    INVENTORY TABLES    *********************************/
   /*-----------------------------LIABILITY TYPE ISSUER-----------------------------------*/
   SELECT SUM(A.CARR_VAL) "COL3",
          B.ISSUER_CODE  "COL4",
          B.INST_TYPE "COL5",
          'I' "COL6",
          'S' "COL7"
          FROM DN_INV_OUTPS_DEAL_SEC A,
              DN_REF_SECURITY B,
              DN_REF_PORTFOLIO C
          WHERE A.SECURITY_CODE=B.SECURITY_CODE
              AND
                  A.EFF_VALDATE<=M_DATE
              AND
                  B.MATURITY_DATE>M_DATE--
              AND
                  A.TRN_TYPE ='B'
              AND
    	          C.PORTFOLIO_CODE=A.PORTFOLIO_CODE
  	           AND
	              C.PF_TYPE='P'
              AND
                  C.OWNED_BY_MBFSL='Y'
          GROUP BY B.ISSUER_CODE ,
                   B.INST_TYPE

     UNION ALL
   SELECT SUM(A.CARR_VAL) "COL3",
          B.ISSUER_CODE  "COL4",
          B.INST_TYPE "COL5",
          'I' "COL6",
          'S' "COL7"
          FROM DN_INV_OUTPS_DEAL_SEC A,
              DN_REF_SECURITY B,
              DN_REF_PORTFOLIO C
          WHERE A.SECURITY_CODE=B.SECURITY_CODE
              AND
                  A.EFF_VALDATE<=M_DATE
              AND
                  B.MATURITY_DATE>M_DATE--
              AND
                  A.TRN_TYPE ='S'
              AND
    	          C.PORTFOLIO_CODE=A.PORTFOLIO_CODE
  	          AND
	              C.PF_TYPE='P'
              AND
                  C.OWNED_BY_MBFSL='Y'
           GROUP BY
                   B.ISSUER_CODE ,
                   B.INST_TYPE

      UNION ALL
  SELECT  SUM(A.CARR_VAL) "COL3",
          B.ISSUER_CODE  "COL4",
          B.INST_TYPE "COL5",
          'I' "COL6",
          'S' "COL7"
          FROM DN_INV_OUTPS_DEAL_SERIAL_NO A,
			   DN_REF_SECURITY B,
                DN_REF_PORTFOLIO C
		  WHERE A.SECURITY_CODE=B.SECURITY_CODE
               AND
					A.EFF_VALDATE<=M_DATE
               AND
                    B.MATURITY_DATE>M_DATE--
               AND
                   (( A.SERIAL_NO_STATUS='INV')
               OR
                    (TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')>M_DATE) OR (A.SALE_EFF_VALDATE IS NULL))
              AND
    	            C.PORTFOLIO_CODE=A.PORTFOLIO_CODE
  	          AND
	                C.PF_TYPE='P'
              AND
                    C.OWNED_BY_MBFSL='Y'
           GROUP BY
                 B.ISSUER_CODE,
                 B.INST_TYPE
  /* ***********************FROM TRANSACTION TABLES  ************************** */
    UNION ALL
  SELECT  SUM(A.COST) "COL3",
          C.ISSUER_CODE  "COL4",
          C.INST_TYPE "COL5",
          'I' "COL6",
          'S' "COL7"
	   FROM
	      DN_TRN_OUTP_SALE A,
	      DN_REF_PORTFOLIO B,
          DN_REF_SECURITY C
	   WHERE
             A.SECURITY_CODE=C.SECURITY_CODE
          AND
            A.EFF_VALDATE<= M_DATE
          AND A.SECURITY_CODE IN
    		(
    		SELECT SECURITY_CODE FROM DN_REF_SECURITY WHERE  MATURITY_DATE > M_DATE--
    	   	)
          AND
    	      B.PORTFOLIO_CODE=A.BUY_PORTFOLIO_CODE --TO IDENTIFY BUY/SALE
  	      AND
	          B.PF_TYPE='P'
          AND
              B.OWNED_BY_MBFSL='Y'
          AND
              APP_STATUS NOT IN ('CONF','CANCEL')
       GROUP BY
             C.ISSUER_CODE ,
             C.INST_TYPE


      UNION ALL
 SELECT   DN_LIMIT_DEDUCT_SUM(SUM(A.COST)) "COL3",
          C.ISSUER_CODE  "COL4",
          C.INST_TYPE "COL5",
          'I' "COL6",
          'S' "COL7"
	   FROM
	      DN_TRN_OUTP_SALE A,
	      DN_REF_PORTFOLIO B,
          DN_REF_SECURITY C
	   WHERE
            A.SECURITY_CODE=C.SECURITY_CODE
          AND
            A.EFF_VALDATE<= M_DATE
          AND A.SECURITY_CODE IN
    		(
    		SELECT SECURITY_CODE FROM DN_REF_SECURITY WHERE  MATURITY_DATE > M_DATE--
    	   	)
          AND
    	      B.PORTFOLIO_CODE=A.SELL_PORTFOLIO_CODE --TO IDENTIFY BUY/SALE
  	      AND
	          B.PF_TYPE='P'
          AND
              B.OWNED_BY_MBFSL='Y'
          AND
              APP_STATUS NOT IN ('CONF','CANCEL')
      GROUP BY
             C.ISSUER_CODE ,
             C.INST_TYPE

   /*--------------------LIABILITY TYPE GUARANTOR---------------------------------------------*/
UNION ALL
          SELECT SUM(A.CARR_VAL) "COL3",
          B.GUARANTEE_CODE  "COL4",
          B.INST_TYPE "COL5",
          'G' "COL6",
          'S' "COL7"
          FROM DN_INV_OUTPS_DEAL_SEC A,
              DN_REF_SECURITY B,
              DN_REF_PORTFOLIO C
          WHERE B.GUARANTEE_CODE IS NOT NULL AND
                A.SECURITY_CODE=B.SECURITY_CODE
              AND
                  A.EFF_VALDATE<=M_DATE
              AND
                  B.MATURITY_DATE>M_DATE--
              AND
                  A.TRN_TYPE ='B'
              AND
    	          C.PORTFOLIO_CODE=A.PORTFOLIO_CODE
  	           AND
	              C.PF_TYPE='P'
              AND
                  C.OWNED_BY_MBFSL='Y'
              AND
                  B.GUARANTEE_CODE IS NOT NULL
          GROUP BY B.GUARANTEE_CODE ,
                   B.INST_TYPE

     UNION ALL
   SELECT SUM(A.CARR_VAL) "COL3",
          B.GUARANTEE_CODE  "COL4",
          B.INST_TYPE "COL5",
          'G' "COL6",
          'S' "COL7"
          FROM DN_INV_OUTPS_DEAL_SEC A,
              DN_REF_SECURITY B,
              DN_REF_PORTFOLIO C
          WHERE B.GUARANTEE_CODE IS NOT NULL AND A.SECURITY_CODE=B.SECURITY_CODE
              AND
                  A.EFF_VALDATE<=M_DATE
              AND
                  B.MATURITY_DATE>M_DATE--
              AND
                  A.TRN_TYPE ='S'
              AND
    	          C.PORTFOLIO_CODE=A.PORTFOLIO_CODE
  	          AND
	              C.PF_TYPE='P'
              AND
                  C.OWNED_BY_MBFSL='Y'
              AND
                  B.GUARANTEE_CODE IS NOT NULL
           GROUP BY
                   B.GUARANTEE_CODE ,
                   B.INST_TYPE

      UNION ALL
  SELECT  SUM(A.CARR_VAL) "COL3",
          B.GUARANTEE_CODE  "COL4",
          B.INST_TYPE "COL5",
          'G' "COL6",
          'S' "COL7"
          FROM DN_INV_OUTPS_DEAL_SERIAL_NO A,
			   DN_REF_SECURITY B,
                DN_REF_PORTFOLIO C
		  WHERE  B.GUARANTEE_CODE IS NOT NULL AND A.SECURITY_CODE=B.SECURITY_CODE
               AND
					A.EFF_VALDATE<=M_DATE
               AND
                    B.MATURITY_DATE>M_DATE--
               AND
                   (( A.SERIAL_NO_STATUS='INV')
               OR
                    (TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')>M_DATE) OR (A.SALE_EFF_VALDATE IS NULL))
              AND
    	            C.PORTFOLIO_CODE=A.PORTFOLIO_CODE
  	          AND
	                C.PF_TYPE='P'
              AND
                    C.OWNED_BY_MBFSL='Y'
              AND
                  B.GUARANTEE_CODE IS NOT NULL
           GROUP BY
                 B.GUARANTEE_CODE,
                 B.INST_TYPE
  /* ***********************FROM TRANSACTION TABLES  ************************** */
    UNION ALL
  SELECT  SUM(A.COST) "COL3",
          C.GUARANTEE_CODE  "COL4",
          C.INST_TYPE "COL5",
          'G' "COL6",
          'S' "COL7"
	   FROM
	      DN_TRN_OUTP_SALE A,
	      DN_REF_PORTFOLIO B,
          DN_REF_SECURITY C
	   WHERE C.GUARANTEE_CODE IS NOT NULL AND
             A.SECURITY_CODE=C.SECURITY_CODE
          AND
            A.EFF_VALDATE<= M_DATE
          AND A.SECURITY_CODE IN
    		(
    		SELECT SECURITY_CODE FROM DN_REF_SECURITY WHERE  MATURITY_DATE > M_DATE--
    	   	)
          AND
    	      B.PORTFOLIO_CODE=A.BUY_PORTFOLIO_CODE --TO IDENTIFY BUY/SALE
  	      AND
	          B.PF_TYPE='P'
          AND
              B.OWNED_BY_MBFSL='Y'
          AND
              APP_STATUS NOT IN ('CONF','CANCEL')
              AND
                  C.GUARANTEE_CODE IS NOT NULL
       GROUP BY
             C.GUARANTEE_CODE ,
             C.INST_TYPE


      UNION ALL
 SELECT   DN_LIMIT_DEDUCT_SUM(SUM(A.COST)) "COL3",
          C.GUARANTEE_CODE  "COL4",
          C.INST_TYPE "COL5",
          'G' "COL6",
          'S' "COL7"
	   FROM
	      DN_TRN_OUTP_SALE A,
	      DN_REF_PORTFOLIO B,
          DN_REF_SECURITY C
	   WHERE C.GUARANTEE_CODE IS NOT NULL AND
            A.SECURITY_CODE=C.SECURITY_CODE
          AND
            A.EFF_VALDATE<= M_DATE
          AND A.SECURITY_CODE IN
    		(
    		SELECT SECURITY_CODE FROM DN_REF_SECURITY WHERE  MATURITY_DATE > M_DATE--
    	   	)
          AND
    	      B.PORTFOLIO_CODE=A.SELL_PORTFOLIO_CODE --TO IDENTIFY BUY/SALE
  	      AND
	          B.PF_TYPE='P'
          AND
              B.OWNED_BY_MBFSL='Y'
          AND
              APP_STATUS NOT IN ('CONF','CANCEL')
          AND
             C.GUARANTEE_CODE IS NOT NULL
      GROUP BY
             C.GUARANTEE_CODE ,
             C.INST_TYPE


/*----------------------LIABILITY TYPE  - ENDOSER---------------------------------------------*/

  UNION ALL
          SELECT SUM(A.CARR_VAL) "COL3",
          D.ENDOSER_CODE  "COL4",
          B.INST_TYPE "COL5",
          'E' "COL6",
          'S' "COL7"
          FROM DN_INV_OUTPS_DEAL_SEC A,
               DN_REF_SECURITY B,
               DN_REF_PORTFOLIO C,
               DN_TRN_OUTP_SALE D
          WHERE D.ENDOSER_CODE IS NOT NULL AND A.SECURITY_CODE=B.SECURITY_CODE
              AND
                  B.SECURITY_CODE=D.SECURITY_CODE
              AND
                  A.EFF_VALDATE<=M_DATE
              AND
                  B.MATURITY_DATE>M_DATE--
              AND
                  A.TRN_TYPE ='B'
              AND
    	          C.PORTFOLIO_CODE=A.PORTFOLIO_CODE
  	           AND
	              C.PF_TYPE='P'
              AND
                  C.OWNED_BY_MBFSL='Y'
              AND
                  D.ENDOSER_CODE IS NOT NULL
          GROUP BY D.ENDOSER_CODE ,
                   B.INST_TYPE

     UNION ALL
   SELECT SUM(A.CARR_VAL) "COL3",
          D.ENDOSER_CODE  "COL4",
          B.INST_TYPE "COL5",
          'G' "COL6",
          'S' "COL7"
          FROM DN_INV_OUTPS_DEAL_SEC A,
              DN_REF_SECURITY B,
              DN_REF_PORTFOLIO C,
               DN_TRN_OUTP_SALE D
          WHERE D.ENDOSER_CODE IS NOT NULL AND  A.SECURITY_CODE=B.SECURITY_CODE
              AND
                  B.SECURITY_CODE=D.SECURITY_CODE
              AND
                  A.EFF_VALDATE<=M_DATE
              AND
                  B.MATURITY_DATE>M_DATE--
              AND
                  A.TRN_TYPE ='S'
              AND
    	          C.PORTFOLIO_CODE=A.PORTFOLIO_CODE
  	          AND
	              C.PF_TYPE='P'
              AND
                  C.OWNED_BY_MBFSL='Y'
              AND
                  D.ENDOSER_CODE IS NOT NULL
           GROUP BY
                   D.ENDOSER_CODE ,
                   B.INST_TYPE

      UNION ALL
  SELECT  SUM(A.CARR_VAL) "COL3",
          D.ENDOSER_CODE  "COL4",
          B.INST_TYPE "COL5",
          'G' "COL6",
          'S' "COL7"
          FROM DN_INV_OUTPS_DEAL_SERIAL_NO A,
			   DN_REF_SECURITY B,
               DN_REF_PORTFOLIO C,
               DN_TRN_OUTP_SALE D
		  WHERE  D.ENDOSER_CODE IS NOT NULL AND   A.SECURITY_CODE=B.SECURITY_CODE
               AND
                   A.SECURITY_CODE=D.SECURITY_CODE
               AND
				   A.EFF_VALDATE<=M_DATE
               AND
                    B.MATURITY_DATE>M_DATE--
               AND
                   (( A.SERIAL_NO_STATUS='INV')
               OR
                    (TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')>M_DATE) OR (A.SALE_EFF_VALDATE IS NULL))
              AND
    	            C.PORTFOLIO_CODE=A.PORTFOLIO_CODE
  	          AND
	                C.PF_TYPE='P'
              AND
                    C.OWNED_BY_MBFSL='Y'
              AND
                  D.ENDOSER_CODE IS NOT NULL
           GROUP BY
                 D.ENDOSER_CODE,
                 B.INST_TYPE
  /* ***********************FROM TRANSACTION TABLES  ************************** */
    UNION ALL
  SELECT  SUM(A.COST) "COL3",
          A.ENDOSER_CODE  "COL4",
          C.INST_TYPE "COL5",
          'G' "COL6",
          'S' "COL7"
	   FROM
	      DN_TRN_OUTP_SALE A,
	      DN_REF_PORTFOLIO B,
          DN_REF_SECURITY C

	   WHERE A.ENDOSER_CODE IS NOT NULL AND
            A.SECURITY_CODE=C.SECURITY_CODE
          AND
            A.EFF_VALDATE<= M_DATE
          AND A.SECURITY_CODE IN
    		(
    		SELECT SECURITY_CODE FROM DN_REF_SECURITY WHERE  MATURITY_DATE > M_DATE--
    	   	)
          AND
    	      B.PORTFOLIO_CODE=A.BUY_PORTFOLIO_CODE --TO IDENTIFY BUY/SALE
  	      AND
	          B.PF_TYPE='P'
          AND
              B.OWNED_BY_MBFSL='Y'
          AND
              APP_STATUS NOT IN ('CONF','CANCEL')
          AND
              A.ENDOSER_CODE IS NOT NULL
       GROUP BY
             A.ENDOSER_CODE ,
             C.INST_TYPE


      UNION ALL
 SELECT   DN_LIMIT_DEDUCT_SUM(SUM(A.COST)) "COL3",
          A.ENDOSER_CODE  "COL4",
          C.INST_TYPE "COL5",
          'G' "COL6",
          'S' "COL7"
	   FROM
	      DN_TRN_OUTP_SALE A,
	      DN_REF_PORTFOLIO B,
          DN_REF_SECURITY C

	   WHERE A.ENDOSER_CODE IS NOT NULL AND
            A.SECURITY_CODE=C.SECURITY_CODE
          AND
            A.EFF_VALDATE<= M_DATE
          AND A.SECURITY_CODE IN
    		(
    		SELECT SECURITY_CODE FROM DN_REF_SECURITY WHERE  MATURITY_DATE > M_DATE--
    	   	)
          AND
    	      B.PORTFOLIO_CODE=A.SELL_PORTFOLIO_CODE --TO IDENTIFY BUY/SALE
  	      AND
	          B.PF_TYPE='P'
          AND
              B.OWNED_BY_MBFSL='Y'
          AND
              APP_STATUS NOT IN ('CONF','CANCEL')
          AND
             A.ENDOSER_CODE IS NOT NULL
      GROUP BY
             A.ENDOSER_CODE ,
             C.INST_TYPE


/*-------------------------------------------------------------------------------------------*/

       /*UNION ALL
      SELECT
          DN_LIMIT_MATU_FIN_START_DAYS(CEIL(A.MATURITY_DATE-M_DATE)) "COL1",
          DN_LIMIT_MATU_FIN_END_DAYS(CEIL(A.MATURITY_DATE-M_DATE)) "COL2",
          DN_LIMIT_DEDUCT_SUM(SUM(A.LEG1_VALUE+A.INT_ACCR)) "COL3",
          C.ISSUER_CODE  "COL4"
          FROM DN_TRN_REPO_FRESH A,
			   DN_REF_PORTFOLIO B,
               DN_REF_SECURITY C
		  WHERE A.BORR_PORTFOLIO_CODE =B.PORTFOLIO_CODE  --TO IDENTIFY BUY/SALE
	              AND
	                    A.EFF_VALDATE<=M_DATE
		          AND
	                    A.MATURITY_DATE>M_DATE--
		          AND
			            A.APP_STATUS!='CANCEL'
                  AND
	                    B.PF_TYPE='P'
                  AND
                        B.OWNED_BY_MBFSL='Y'
                  AND
                        A.SECURITY_CODE=C.SECURITY_CODE
                  --AND
                        --APP_STATUS NOT IN ('CONF','CANCEL')
          GROUP BY DN_LIMIT_MATU_FIN_START_DAYS(CEIL(A.MATURITY_DATE-M_DATE)),
                   DN_LIMIT_MATU_FIN_END_DAYS(CEIL(A.MATURITY_DATE-M_DATE)),
                   C.ISSUER_CODE
      UNION ALL
       SELECT
          DN_LIMIT_MATU_FIN_START_DAYS(CEIL(A.MATURITY_DATE-M_DATE)) "COL1",
          DN_LIMIT_MATU_FIN_END_DAYS(CEIL(A.MATURITY_DATE-M_DATE)) "COL2",
          SUM(A.LEG1_VALUE+A.INT_ACCR) "COL3",
          C.ISSUER_CODE  "COL4"
          FROM DN_TRN_REPO_FRESH A,
			   DN_REF_PORTFOLIO B,
               DN_REF_SECURITY C
		  WHERE A.LEND_PORTFOLIO_CODE =B.PORTFOLIO_CODE  --TO IDENTIFY BUY/SALE
	              AND
	                    A.EFF_VALDATE<=M_DATE
		          AND
	                    A.MATURITY_DATE>M_DATE--
		          AND
			            A.APP_STATUS!='CANCEL'
                  AND
	                    B.PF_TYPE='P'
                  AND
                        B.OWNED_BY_MBFSL='Y'
                  AND
                        A.SECURITY_CODE=C.SECURITY_CODE
                   --AND
                        --APP_STATUS NOT IN ('CONF','CANCEL')
          GROUP BY DN_LIMIT_MATU_FIN_START_DAYS(CEIL(A.MATURITY_DATE-M_DATE)),
                   DN_LIMIT_MATU_FIN_END_DAYS(CEIL(A.MATURITY_DATE-M_DATE)),
                   C.ISSUER_CODE

      UNION ALL
       SELECT
          DN_LIMIT_MATU_FIN_START_DAYS(CEIL(A.MATURITY_DATE-M_DATE)) "COL1",
          DN_LIMIT_MATU_FIN_END_DAYS(CEIL(A.MATURITY_DATE-M_DATE)) "COL2",
          DN_LIMIT_DEDUCT_SUM(SUM(A.LEG1_VALUE+A.INT_ACCR)) "COL3",
          C.ISSUER_CODE  "COL4"
          FROM DN_TRN_REPO_ROLLOVER A,
			   DN_REF_PORTFOLIO B,
               DN_REF_SECURITY C
		  WHERE A.BORR_PORTFOLIO_CODE =B.PORTFOLIO_CODE  --TO IDENTIFY BUY/SALE
	              AND
	                    A.EFF_VALDATE<=M_DATE
		          AND
	                    A.MATURITY_DATE>M_DATE--
		          AND
			            A.APP_STATUS!='CANCEL'
                  AND
	                    B.PF_TYPE='P'
                  AND
                        B.OWNED_BY_MBFSL='Y'
                  AND
                         A.SECURITY_CODE=C.SECURITY_CODE
                  --AND
                        --APP_STATUS NOT IN ('CONF','CANCEL')
          GROUP BY DN_LIMIT_MATU_FIN_START_DAYS(CEIL(A.MATURITY_DATE-M_DATE)),
                   DN_LIMIT_MATU_FIN_END_DAYS(CEIL(A.MATURITY_DATE-M_DATE)),
                   C.ISSUER_CODE
                   UNION ALL
       SELECT
          DN_LIMIT_MATU_FIN_START_DAYS(CEIL(A.MATURITY_DATE-M_DATE)) "COL1",
          DN_LIMIT_MATU_FIN_END_DAYS(CEIL(A.MATURITY_DATE-M_DATE)) "COL2",
          SUM(A.LEG1_VALUE+A.INT_ACCR) "COL3",
          C.ISSUER_CODE  "COL4"
          FROM DN_TRN_REPO_ROLLOVER A,
			   DN_REF_PORTFOLIO B,
               DN_REF_SECURITY C
		  WHERE A.LEND_PORTFOLIO_CODE =B.PORTFOLIO_CODE  --TO IDENTIFY BUY/SALE
	              AND
	                    A.EFF_VALDATE<=M_DATE
		          AND
	                    A.MATURITY_DATE>M_DATE--
		          AND
			            A.APP_STATUS!='CANCEL'
                  AND
	                    B.PF_TYPE='P'
                  AND
                        B.OWNED_BY_MBFSL='Y'
                  AND
                        A.SECURITY_CODE=C.SECURITY_CODE
                  --AND
                        --APP_STATUS NOT IN ('CONF','CANCEL')
          GROUP BY DN_LIMIT_MATU_FIN_START_DAYS(CEIL(A.MATURITY_DATE-M_DATE)),
                   DN_LIMIT_MATU_FIN_END_DAYS(CEIL(A.MATURITY_DATE-M_DATE)),
                   C.ISSUER_CODE
      UNION ALL
       SELECT
          DN_LIMIT_MATU_FIN_START_DAYS(CEIL(A.MATURITY_DATE-M_DATE)) "COL1",
          DN_LIMIT_MATU_FIN_END_DAYS(CEIL(A.MATURITY_DATE-M_DATE)) "COL2",
          DN_LIMIT_DEDUCT_SUM(SUM(A.LEG1_VALUE)) "COL3",
          C.ISSUER_CODE  "COL4"
          FROM DN_TRN_BL_FUND A,
			   DN_REF_PORTFOLIO B,
               DN_REF_SECURITY C
		  WHERE A.BORR_PORTFOLIO_CODE =B.PORTFOLIO_CODE  --TO IDENTIFY BUY/SALE
	              AND
	                    A.EFF_VALDATE<=M_DATE
		          AND
	                    A.MATURITY_DATE>M_DATE--
		          AND
			            A.APP_STATUS!='CANCEL'
                  AND
	                    B.PF_TYPE='P'
                  AND
                        B.OWNED_BY_MBFSL='Y'
                  AND
                        A.SECURITY_CODE=C.SECURITY_CODE
                  --AND
                        --APP_STATUS NOT IN ('CONF','CANCEL')
          GROUP BY DN_LIMIT_MATU_FIN_START_DAYS(CEIL(A.MATURITY_DATE-M_DATE)),
                   DN_LIMIT_MATU_FIN_END_DAYS(CEIL(A.MATURITY_DATE-M_DATE)),
                   C.ISSUER_CODE

      UNION ALL
       SELECT
          DN_LIMIT_MATU_FIN_START_DAYS(CEIL(A.MATURITY_DATE-M_DATE)) "COL1",
          DN_LIMIT_MATU_FIN_END_DAYS(CEIL(A.MATURITY_DATE-M_DATE)) "COL2",
          SUM(A.LEG1_VALUE) "COL3",
          C.ISSUER_CODE  "COL4"
          FROM DN_TRN_BL_FUND A,
			   DN_REF_PORTFOLIO B,
               DN_REF_SECURITY C
		  WHERE A.LEND_PORTFOLIO_CODE =B.PORTFOLIO_CODE  --TO IDENTIFY BUY/SALE
	              AND
	                    A.EFF_VALDATE<=M_DATE
		          AND
	                    A.MATURITY_DATE>M_DATE--
		          AND
			            A.APP_STATUS!='CANCEL'
                  AND
	                    B.PF_TYPE='P'
                  AND
                        B.OWNED_BY_MBFSL='Y'
                  AND
                        A.SECURITY_CODE=C.SECURITY_CODE
                  --AND
                        --APP_STATUS NOT IN ('CONF','CANCEL')
          GROUP BY DN_LIMIT_MATU_FIN_START_DAYS(CEIL(A.MATURITY_DATE-M_DATE)),
                   DN_LIMIT_MATU_FIN_END_DAYS(CEIL(A.MATURITY_DATE-M_DATE)),
                   C.ISSUER_CODE  */
       )
	GROUP BY COL4,COL5,COL6,COL7;

	BEGIN
        --M_ROW_ID:=1;
		M_TOT_FACE:=0;
		/* 	DELETING THE VIOLATION AND POSSIBLE VIOLATION TABLE	*/
	INSERT INTO LMT_EXC_HIS
		( LIMIT_CODE,
		  VIOLATED_DATE,
		  VIOLATED_BY,
		  ACTIVATED_TYPE,
		  HIS_ACTIVATED_TYPE )
		SELECT
			LIMIT_CODE,
			VIOLATED_DATE,
			VIOLATED_BY,
			ACTIVATED_TYPE,
			ACTIVATED_TYPE
			FROM LMT_EXC_CURRENT WHERE LIMIT_CODE LIKE '04%';

	 --DELETE FROM LMT_EXC_CURRENT WHERE LIMIT_CODE LIKE '05%';
	 --DELETE FROM LMT_EXC_UNCONF WHERE LIMIT_CODE LIKE '05%';
     DELETE FROM LMT_UTL_ISSUER_INST_AMT ;
     --DELETE LMT_UTL_OVRL_EXP;

	OPEN MYCURSOR;
	LOOP
		FETCH MYCURSOR INTO M_FACE_VALUE,M_ISSUER_CODE,M_INST_TYPE,M_ISSUER_LIABILITY_TYPE,M_AUCTION_TYPE;
        EXIT WHEN MYCURSOR%NOTFOUND;
	 ---	THIS TO SELECT RELEVENT LIMIT CODE FROM THE TABLE
		/*	SELECT COUNT(*) INTO M_COUNT FROM LMT_STR_ISSUER_INST_MATU
				WHERE START_DAYS=M_START_DAYS
                AND
                  END_DAYS =M_END_DAYS
				AND
                  M_FACE_VALUE > START_AMOUNT
                AND
                  M_FACE_VALUE <= END_AMOUNT
                AND
                  CONDITION='B'
                AND
                  SUBSTR(LIMIT_CODE,4,4)=M_ISSUER_CODE
                AND
                  INST_TYPE=M_INST_TYPE ;

-- RAISE_APPLICATION_ERROR(-20201,'*** '||M_MATURITY_DAY||'******'||M_FACE_VALUE||'*****'||M_COUNT);
				IF ( M_COUNT>0 ) THEN
					SELECT LIMIT_CODE,AUCTION_TYPE,ISSUER_CODE,ISSUER_LIABILITY_TYPE,INST_TYPE
                    INTO   M_LIMIT_CODE,M_AUCTION_TYPE,M_ISSUER_CODE,M_ISSUER_LIABILITY_TYPE,M_INST_TYPE
                    FROM   LMT_STR_ISSUER_INST_MATU
				    WHERE  START_DAYS=M_START_DAYS
                        AND
                            END_DAYS =M_END_DAYS
				        AND
                            M_FACE_VALUE > START_AMOUNT
                        AND
                            M_FACE_VALUE <= END_AMOUNT
                        AND
                            CONDITION='B'
                        AND
                            SUBSTR(LIMIT_CODE,4,4)=M_ISSUER_CODE
                        AND
                            INST_TYPE=M_INST_TYPE;
				 ELSIF (M_COUNT=0) THEN

                 --INSERT INTO SUK values  (007,8888,'03-00000',M_START_DAYS,M_END_DAYS);
   --RAISE_APPLICATION_ERROR(-20201,'*** ');
						SELECT  LIMIT_CODE,AUCTION_TYPE,ISSUER_CODE,ISSUER_LIABILITY_TYPE,INST_TYPE
                        INTO    M_LIMIT_CODE,M_AUCTION_TYPE,M_ISSUER_CODE,M_ISSUER_LIABILITY_TYPE,M_INST_TYPE
                        FROM    LMT_STR_ISSUER_INST_MATU
				        WHERE   START_DAYS=M_START_DAYS
                            AND
                                END_DAYS =M_END_DAYS
				            AND
                                CONDITION='G';
				 END IF;
				SELECT COUNT(*) INTO M_ACTIVATE_COUNT	FROM LMT_ACT_DETAILS
					WHERE LIMIT_CODE=M_LIMIT_CODE
                    AND
                    ACTIVE_STATUS='Y';

					IF ( M_ACTIVATE_COUNT=0 ) THEN
						UPDATE LMT_EXC_CURRENT
							SET
								LIMIT_CODE=M_LIMIT_CODE ,
								VIOLATED_DATE=M_DATE ,
								VIOLATED_BY='' ,
								ACTIVATED_TYPE='Y'
							 WHERE  LIMIT_CODE = M_LIMIT_CODE ;

								IF  SQL%NOTFOUND THEN
									INSERT INTO LMT_EXC_CURRENT
										( LIMIT_CODE ,
										  VIOLATED_DATE ,
										  VIOLATED_BY ,
										  ACTIVATED_TYPE )
											VALUES
												( M_LIMIT_CODE ,
													M_DATE ,
													'' ,
													'Y' );
								END IF;
					END IF;*/


                    INSERT INTO LMT_UTL_ISSUER_INST_AMT
                       (LIMIT_TYPE,
                          AUCTION_TYPE,
                          ISSUER_CODE,
                          ISSUER_LIABILITY_TYPE,
                          INST_TYPE,
                          BF_UTILIZATION,
                          DEAL_INFLOW,
                          DEAL_OUTFLOW,
                          CURRENT_UTILIZATION,
                          DN_USER
                          )

                          VALUES

                          	( '04' ,
                                 M_AUCTION_TYPE,
                                 M_ISSUER_CODE,
                                 M_ISSUER_LIABILITY_TYPE,
                                 M_INST_TYPE,
                                 M_FACE_VALUE ,
					             '' ,
					             '' ,
				                 M_FACE_VALUE,
                                 ''
					             );



--M_ROW_ID:=M_ROW_ID+1;
DN_LIMIT_COMPARE_ISS_INST_AMT(0,M_ISSUER_CODE,M_INST_TYPE,M_ISSUER_LIABILITY_TYPE);

	END LOOP;
CLOSE MYCURSOR;

END DN_LIMIT_DAYEND_ISS_INST_AMT;

/
