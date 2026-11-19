--------------------------------------------------------
--  DDL for Procedure YIELD_FLUCTUATION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."YIELD_FLUCTUATION" 
(
M_PROCESS_DATE        DN_SYS_PARAMETER.LAST_DAILY%TYPE
)

IS
       M_REPO_YIELD                        NUMBER;
       M_REVERSE_REPO_YIELD                NUMBER;


          -- Procedure   : CALCULATES YIELD FLUCTUATIONS
          -- System      : DEALNET System
          -- Created By  : NIRMALA FERNANDO
          -- Created On  : 07/09/2000



BEGIN

------------------------------------------ FOR REPOS-----------------------------------------
    SELECT ROUND(SUM(AA),6)
    INTO M_REPO_YIELD
                FROM
               (SELECT ROUND(SUM(YEILD * LEG1_VALUE)/SUM(LEG1_VALUE),6) AA
                FROM DN_TRN_REPO_ROLLOVER
                WHERE BORR_PORTFOLIO_CODE IN (SELECT PORTFOLIO_CODE  FROM DN_REF_PORTFOLIO
                                              WHERE OWNED_BY_MBFSL='Y' )
                      AND TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')= M_PROCESS_DATE
                GROUP BY EFF_VALDATE
                UNION ALL
                SELECT ROUND(SUM(YIELD * LEG1_VALUE)/SUM(LEG1_VALUE),6) AA
                FROM DN_TRN_REPO_FRESH
                WHERE BORR_PORTFOLIO_CODE IN (SELECT PORTFOLIO_CODE  FROM DN_REF_PORTFOLIO
                                              WHERE OWNED_BY_MBFSL='Y' )
                      AND TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')= M_PROCESS_DATE
                GROUP BY EFF_VALDATE) ;
--------------------------------------FOR REVERSE REPOS---------------------------------------
    SELECT ROUND(SUM(AA),6)
    INTO M_REVERSE_REPO_YIELD
                FROM
               (SELECT ROUND(SUM(YEILD * LEG1_VALUE)/SUM(LEG1_VALUE),6) AA
                FROM DN_TRN_REPO_ROLLOVER
                WHERE LEND_PORTFOLIO_CODE IN (SELECT PORTFOLIO_CODE  FROM DN_REF_PORTFOLIO
                                              WHERE OWNED_BY_MBFSL='Y' )
                      AND TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')= M_PROCESS_DATE
                GROUP BY EFF_VALDATE
                UNION ALL
                SELECT ROUND(SUM(YIELD * LEG1_VALUE)/SUM(LEG1_VALUE),6) AA
                FROM DN_TRN_REPO_FRESH
                WHERE LEND_PORTFOLIO_CODE IN (SELECT PORTFOLIO_CODE  FROM DN_REF_PORTFOLIO
                                              WHERE OWNED_BY_MBFSL='Y' )
                      AND TO_DATE(TO_CHAR(EFF_VALDATE,'DD-MM-YYYY'),'DD-MM-YYYY')= M_PROCESS_DATE
                GROUP BY EFF_VALDATE);

     INSERT INTO DN_REF_YIELD_FLUCTUATION
                 (PROCESS_DATE,REPO_YIELD,REVERSE_REPO_YIELD)
     VALUES
                 (M_PROCESS_DATE,M_REPO_YIELD,M_REVERSE_REPO_YIELD);



COMMIT;

END YIELD_FLUCTUATION;

/
