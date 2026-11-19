--------------------------------------------------------
--  DDL for Function DN_GET_ALLOFACEVAL_OR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_ALLOFACEVAL_OR" 
(
M_SECURITY_CODE          DN_INV_REPO_DEAL_SERIAL_NO.SECURITY_CODE%TYPE,
M_PORTFOLIO_CODE         DN_INV_REPO_DEAL_SERIAL_NO.PORTFOLIO_CODE%TYPE,
M_INST_TYPE              DN_INV_REPO_DEAL_SERIAL_NO.INST_TYPE%TYPE,
M_SCRIPT_STATUS          DN_TRN_REPO_FRESH.SCRIPT_STATUS%TYPE,
M_PASS_DATE              VARCHAR2
)RETURN FLOAT
AS
M_RETURN  FLOAT;
MM_SCRIPT_STATUS          DN_TRN_REPO_FRESH.SCRIPT_STATUS%TYPE;

BEGIN
M_RETURN:=0;

IF M_SCRIPT_STATUS='ALL' THEN
SELECT SUM(R)
INTO   M_RETURN
FROM
(
SELECT A.ALLO_FACE_VALUE R,A.SECURITY_CODE V,A.INST_TYPE W
FROM   DN_INV_OUTPS_DEAL_SERNO_ALLO A--,DN_TRN_REPO_FRESH B
WHERE  A.SECURITY_CODE=M_SECURITY_CODE
       AND A.INST_TYPE=M_INST_TYPE
       AND A.PORTFOLIO_CODE=M_PORTFOLIO_CODE
       AND TO_DATE(TO_CHAR(A.START_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')<=TO_DATE(M_PASS_DATE,'DD-MM-YYYY')
       AND TO_DATE(TO_CHAR(A.END_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')>TO_DATE(M_PASS_DATE,'DD-MM-YYYY')
       AND (TO_DATE(TO_CHAR(A.END_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),A.SERIAL_NO) IN (SELECT  MAX(TO_DATE(TO_CHAR(N.END_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')),N.SERIAL_NO
                                                                 FROM   DN_INV_OUTPS_DEAL_SERNO_ALLO N--,DN_TRN_REPO_FRESH B
                                                                 WHERE  N.SECURITY_CODE=M_SECURITY_CODE
                                                                        AND N.INST_TYPE=M_INST_TYPE
                                                                        AND N.PORTFOLIO_CODE=M_PORTFOLIO_CODE
                                                                        --AND N.DEAL_NO=B.DEAL_NO
                                                                       -- AND B.SCRIPT_STATUS IN (M_SCRIPT_STATUS)
                                                                 GROUP BY  N.SECURITY_CODE,N.INST_TYPE ,N.SERIAL_NO)
      --AND A.DEAL_NO=B.DEAL_NO
      --AND B.SCRIPT_STATUS IN (M_SCRIPT_STATUS)

/*UNION

SELECT A.ALLO_FACE_VALUE R,A.SECURITY_CODE V,A.INST_TYPE W
FROM   DN_INV_OUTPS_DEAL_SERNO_ALLO A--,DN_TRN_REPO_ROLLOVER B
WHERE  A.SECURITY_CODE=M_SECURITY_CODE
       AND A.INST_TYPE=M_INST_TYPE
       AND A.PORTFOLIO_CODE=M_PORTFOLIO_CODE
       AND TO_DATE(TO_CHAR(A.START_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')<=TO_DATE(M_PASS_DATE,'DD-MM-YYYY')
       AND TO_DATE(TO_CHAR(A.END_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')>TO_DATE(M_PASS_DATE,'DD-MM-YYYY')
       AND TO_DATE(TO_CHAR(A.END_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')=(SELECT distinct MAX(TO_DATE(TO_CHAR(N.END_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'))
                                                                 FROM   DN_INV_OUTPS_DEAL_SERNO_ALLO N--,DN_TRN_REPO_ROLLOVER B
                                                                 WHERE  N.SECURITY_CODE=M_SECURITY_CODE
                                                                        AND N.INST_TYPE=M_INST_TYPE
                                                                        AND N.PORTFOLIO_CODE=M_PORTFOLIO_CODE
                                                                      --  AND N.DEAL_NO=B.DEAL_NO
                                                                      --  AND B.SCRIPT_STATUS IN (M_SCRIPT_STATUS)
                                                                 GROUP BY  N.SECURITY_CODE,N.INST_TYPE )
     -- AND A.DEAL_NO=B.DEAL_NO
     -- AND B.SCRIPT_STATUS IN (M_SCRIPT_STATUS)
     */
)GG
GROUP BY GG.W,GG.V ;

ELSE

SELECT SUM(R)
INTO   M_RETURN
FROM
(
SELECT A.DEAL_NO,A.ALLO_FACE_VALUE R,A.SECURITY_CODE V,A.INST_TYPE W
FROM   DN_INV_OUTPS_DEAL_SERNO_ALLO A,DN_TRN_REPO_FRESH B
WHERE  A.SECURITY_CODE=M_SECURITY_CODE
       AND A.INST_TYPE=M_INST_TYPE
       AND A.PORTFOLIO_CODE=M_PORTFOLIO_CODE
       AND TO_DATE(TO_CHAR(A.START_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')<=TO_DATE(M_PASS_DATE,'DD-MM-YYYY')
       AND TO_DATE(TO_CHAR(A.END_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')>TO_DATE(M_PASS_DATE,'DD-MM-YYYY')
       AND (TO_DATE(TO_CHAR(A.END_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),A.SERIAL_NO) IN (SELECT  MAX(TO_DATE(TO_CHAR(N.END_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')),N.SERIAL_NO
                                                                 FROM   DN_INV_OUTPS_DEAL_SERNO_ALLO N,DN_TRN_REPO_FRESH B
                                                                 WHERE  N.SECURITY_CODE=M_SECURITY_CODE
                                                                        AND N.INST_TYPE=M_INST_TYPE
                                                                        AND N.PORTFOLIO_CODE=M_PORTFOLIO_CODE
                                                                        AND N.DEAL_NO=B.DEAL_NO
                                                                        AND B.SCRIPT_STATUS IN (M_SCRIPT_STATUS)
                                                                 GROUP BY  N.SECURITY_CODE,N.INST_TYPE,N.SERIAL_NO )
      AND A.DEAL_NO=B.DEAL_NO
      AND B.SCRIPT_STATUS IN (M_SCRIPT_STATUS)

UNION ALL

SELECT A.DEAL_NO,A.ALLO_FACE_VALUE R,A.SECURITY_CODE V,A.INST_TYPE W
FROM   DN_INV_OUTPS_DEAL_SERNO_ALLO A,DN_TRN_REPO_ROLLOVER B
WHERE  A.SECURITY_CODE=M_SECURITY_CODE
       AND A.INST_TYPE=M_INST_TYPE
       AND A.PORTFOLIO_CODE=M_PORTFOLIO_CODE
       AND TO_DATE(TO_CHAR(A.START_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')<=TO_DATE(M_PASS_DATE,'DD-MM-YYYY')
       AND TO_DATE(TO_CHAR(A.END_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')>TO_DATE(M_PASS_DATE,'DD-MM-YYYY')
       AND (TO_DATE(TO_CHAR(A.END_DATE,'DD-MM-YYYY'),'DD-MM-YYYY'),A.SERIAL_NO) IN (SELECT  MAX(TO_DATE(TO_CHAR(N.END_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')),N.SERIAL_NO
                                                                 FROM   DN_INV_OUTPS_DEAL_SERNO_ALLO N,DN_TRN_REPO_ROLLOVER B
                                                                 WHERE  N.SECURITY_CODE=M_SECURITY_CODE
                                                                        AND N.INST_TYPE=M_INST_TYPE
                                                                        AND N.PORTFOLIO_CODE=M_PORTFOLIO_CODE
                                                                        AND N.DEAL_NO=B.DEAL_NO
                                                                        AND B.SCRIPT_STATUS IN (M_SCRIPT_STATUS)
                                                                 GROUP BY  N.SECURITY_CODE,N.INST_TYPE,N.SERIAL_NO )
      AND A.DEAL_NO=B.DEAL_NO
      AND B.SCRIPT_STATUS IN (M_SCRIPT_STATUS)
)GG
GROUP BY GG.W,GG.V ;
END IF;

RETURN M_RETURN;

END DN_GET_ALLOFACEVAL_OR;

/
