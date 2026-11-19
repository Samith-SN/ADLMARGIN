--------------------------------------------------------
--  DDL for Procedure DN_OR_INVENTORY_RPT_DRILL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_OR_INVENTORY_RPT_DRILL" 
(
M_SCRIP_STATUS              DN_INV_OUTPS_DEAL_SERIAL_NO.SCRIP_STATUS%TYPE,
M_PORTFOLIO_CODE            DN_INV_OUTPS_DEAL_SERIAL_NO.PORTFOLIO_CODE%TYPE,
M_INST_TYPE                 DN_INV_OUTPS_DEAL_SERIAL_NO.INST_TYPE%TYPE,
M_SECURITY_CODE             DN_INV_OUTPS_DEAL_SERIAL_NO.SECURITY_CODE%TYPE,
M_PASS_DATE                 VARCHAR2
)
 AS
 --CREATED BY : NIRMALA
 --CREATED ON :25-02-2004

 CURSOR SERIAL_NO IS
 SELECT JK.X1,JK.X2,JK.X3,JK.X4,JK.X5,JK.X6,JK.X7,JK.X8,JK.X9,'UPPER' X10
 FROM
     (SELECT  A.PORTFOLIO_CODE X1,
              A.INST_TYPE X2,
              A.SECURITY_CODE X3,
              A.DEAL_NO X4,
              TO_CHAR(A.EFF_VALDATE,'DD-MM-YYYY') X5,
              A.FACE_VAL X6,
              TO_CHAR(A.RET_DUE_DATE,'DD-MM-YYYY')X7,
              A.RET_DUE_DATE X8,
              A.SERIAL_NO X9
      FROM    DN_INV_OUTPS_DEAL_SERIAL_NO A,
              DN_REF_SECURITY B
      WHERE   A.PORTFOLIO_CODE=M_PORTFOLIO_CODE AND
              TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')<=TO_DATE(M_PASS_DATE,'DD/MM/YYYY') AND
              A.SECURITY_CODE=B.SECURITY_CODE  AND
              (A.SERIAL_NO_STATUS='INV' OR ( A.SALE_EFF_VALDATE IS NULL) OR
	              (TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')>TO_DATE(M_PASS_DATE,'DD/MM/YYYY'))  )AND
	          TO_DATE(TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')>= TO_DATE(M_PASS_DATE,'DD/MM/YYYY')  AND
	          TO_DATE(TO_CHAR(B.ISSUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')<= TO_DATE(M_PASS_DATE,'DD/MM/YYYY') AND
              A.FACE_VAL>0 AND
              A.FACE_VAL_CURR IS NULL  AND
              A.SCRIP_STATUS=M_SCRIP_STATUS AND
              A.SECURITY_CODE=M_SECURITY_CODE AND
              A.INST_TYPE=M_INST_TYPE


      UNION

      SELECT  A.PORTFOLIO_CODE X1,
              A.INST_TYPE X2,
              A.SECURITY_CODE X3,
              A.DEAL_NO X4,
              TO_CHAR(A.EFF_VALDATE,'DD-MM-YYYY') X5,
              A.FACE_VAL X6,
              TO_CHAR(A.RET_DUE_DATE,'DD-MM-YYYY')X7,
              A.RET_DUE_DATE X8,
              A.SERIAL_NO X9

         FROM  DN_REF_SECURITY B,
               DN_HIS_OUTPS_DEAL_SERIAL_NO A
      WHERE    A.PORTFOLIO_CODE=M_PORTFOLIO_CODE AND
               TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')<=TO_DATE(M_PASS_DATE,'DD/MM/YYYY') AND
               A.SECURITY_CODE=B.SECURITY_CODE  AND
               (A.SERIAL_NO_STATUS='INV' OR ( A.SALE_EFF_VALDATE IS NULL) OR
			      (TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')>TO_DATE(M_PASS_DATE,'DD/MM/YYYY'))  )AND
			   TO_DATE(TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')>= TO_DATE(M_PASS_DATE,'DD/MM/YYYY')  AND
	 		   TO_DATE(TO_CHAR(B.ISSUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')<= TO_DATE(M_PASS_DATE,'DD/MM/YYYY') AND
			   A.FACE_VAL>0 AND
			   A.FACE_VAL_CURR IS NULL AND
               A.SCRIP_STATUS=M_SCRIP_STATUS AND
              A.SECURITY_CODE=M_SECURITY_CODE AND
              A.INST_TYPE=M_INST_TYPE


	) JK

UNION
 SELECT JK.X1,JK.X2,JK.X3,JK.X4,JK.X5,JK.X6,JK.X7,JK.X8 X8,JK.X9 X9,'LOWER' X10
 FROM
    (SELECT T1.X1 X1 ,T1.X2 X2,
            T1.X3 X3 ,
            T1.X4 X4 ,
            T1.X5 X5,
            (T1.X6+T2.X6)X6,
            T1.X7 X7,
            T1.X8,
            T1.X9

     FROM  (SELECT  A.PORTFOLIO_CODE X1,
                    A.INST_TYPE X2,
                    A.SECURITY_CODE X3,
                    A.DEAL_NO X4,
                    TO_CHAR(A.EFF_VALDATE,'DD-MM-YYYY') X5,
                    A.FACE_VAL X6,
                    TO_CHAR(A.RET_DUE_DATE,'DD-MM-YYYY')X7,
                    A.RET_DUE_DATE X8,
                    A.SERIAL_NO X9

            FROM    DN_INV_OUTPS_DEAL_SERIAL_NO A,
                    DN_REF_SECURITY B
           WHERE    A.PORTFOLIO_CODE=M_PORTFOLIO_CODE AND
                    TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')<=TO_DATE(M_PASS_DATE,'DD/MM/YYYY') AND
                    A.SECURITY_CODE=B.SECURITY_CODE  AND
                    (A.SERIAL_NO_STATUS='INV' OR ( A.SALE_EFF_VALDATE IS NULL) OR
	                  (TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')>TO_DATE(M_PASS_DATE,'DD/MM/YYYY')))AND
                    TO_DATE(TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')>= TO_DATE(M_PASS_DATE,'DD/MM/YYYY')  AND
                    TO_DATE(TO_CHAR(B.ISSUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')<= TO_DATE(M_PASS_DATE,'DD/MM/YYYY') AND
                    A.FACE_VAL>0 AND
                    A.FACE_VAL_CURR IS NULL  AND
                    A.SCRIP_STATUS=M_SCRIP_STATUS AND
                    A.SECURITY_CODE=M_SECURITY_CODE AND
                    A.INST_TYPE=M_INST_TYPE)T1,

        (SELECT     A.PORTFOLIO_CODE X1,
                    A.INST_TYPE X2,
                    A.SECURITY_CODE X3,
                    A.DEAL_NO X4,
                    TO_CHAR(A.EFF_VALDATE,'DD-MM-YYYY') X5,
                    A.FACE_VAL X6,
                    TO_CHAR(A.RET_DUE_DATE,'DD-MM-YYYY')X7,
                    A.RET_DUE_DATE X8,
                    A.SERIAL_NO X9

            FROM    DN_REF_SECURITY B,
                    DN_HIS_OUTPS_DEAL_SERIAL_NO A
           WHERE    A.PORTFOLIO_CODE=M_PORTFOLIO_CODE AND
                    TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')<=TO_DATE(M_PASS_DATE,'DD/MM/YYYY') AND
                    A.SECURITY_CODE=B.SECURITY_CODE   AND
                    (A.SERIAL_NO_STATUS='INV' OR ( A.SALE_EFF_VALDATE IS NULL) OR
                      (TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')>TO_DATE(M_PASS_DATE,'DD/MM/YYYY'))  )AND
                    TO_DATE(TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')>= TO_DATE(M_PASS_DATE,'DD/MM/YYYY')  AND
                    TO_DATE(TO_CHAR(B.ISSUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')<= TO_DATE(M_PASS_DATE,'DD/MM/YYYY') AND
                    A.FACE_VAL>0 AND
                    A.FACE_VAL_CURR IS NULL  AND A.SCRIP_STATUS=M_SCRIP_STATUS AND
                      A.SECURITY_CODE=M_SECURITY_CODE AND
                    A.INST_TYPE=M_INST_TYPE)T2

    WHERE T1.X1=T2.X1 AND
          T1.X2=T2.X2 AND
          T1.X3=T2.X3
    )JK;


-------------------------------------------------------------------------

CURSOR UNWANTED_RECS IS
      SELECT T1.X3 X1
        FROM
	         (SELECT   /*A.PORTFOLIO_CODE X1,
                       A.INST_TYPE X2,*/
                       A.SECURITY_CODE X3/*,
                       A.DEAL_NO X4,
                       TO_CHAR(A.EFF_VALDATE,'DD-MM-YYYY') X5,
                       A.FACE_VAL X6,
                       TO_CHAR(A.RET_DUE_DATE,'DD-MM-YYYY') X7,
                       A.RET_DUE_DATE  X8,
                       A.SERIAL_NO X9*/

           FROM    DN_INV_OUTPS_DEAL_SERIAL_NO A,DN_REF_SECURITY B

           WHERE   A.PORTFOLIO_CODE=M_PORTFOLIO_CODE AND
                   TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')<=TO_DATE(M_PASS_DATE,'DD/MM/YYYY') AND
                   A.SECURITY_CODE=B.SECURITY_CODE  AND
                   (A.SERIAL_NO_STATUS='INV' OR ( A.SALE_EFF_VALDATE IS NULL) OR
	                  (TO_DATE(TO_CHAR(A.SALE_EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')>TO_DATE(M_PASS_DATE,'DD/MM/YYYY')))AND
                   TO_DATE(TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')>= TO_DATE(M_PASS_DATE,'DD/MM/YYYY')  AND
                   TO_DATE(TO_CHAR(B.ISSUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')<= TO_DATE(M_PASS_DATE,'DD/MM/YYYY') AND
                   A.FACE_VAL>0 AND
                   A.FACE_VAL_CURR IS NULL  AND
                   A.SCRIP_STATUS=M_SCRIP_STATUS AND
                   A.SECURITY_CODE=M_SECURITY_CODE AND
                   A.INST_TYPE=M_INST_TYPE)T1,

           (SELECT     /*A.PORTFOLIO_CODE X1,
                       A.INST_TYPE X2,*/
                       A.SECURITY_CODE X3/*,
                       A.DEAL_NO X4,
                       TO_CHAR(A.EFF_VALDATE,'DD-MM-YYYY')X5,
                       A.FACE_VAL X6,
                       TO_CHAR(A.RET_DUE_DATE,'DD-MM-YYYY') X7,
                       A.RET_DUE_DATE X8,
                       A.SERIAL_NO X9*/
            FROM    DN_REF_SECURITY B,
                    DN_HIS_OUTPS_DEAL_SERIAL_NO A

            WHERE  A.PORTFOLIO_CODE=M_PORTFOLIO_CODE AND
                   TO_DATE(TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')<=TO_DATE(M_PASS_DATE,'DD/MM/YYYY') AND
                   A.SECURITY_CODE=B.SECURITY_CODE   AND
                   (A.SERIAL_NO_STATUS='INV' OR ( A.SALE_EFF_VALDATE IS NULL) OR
                     (TO_DATE(TO_CHAR(A .SALE_EFF_VALDATE,'DD/MM/YYYY'),'DD/MM/YYYY')>TO_DATE(M_PASS_DATE,'DD/MM/YYYY'))  )AND
                   TO_DATE(TO_CHAR(B.MATURITY_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')>= TO_DATE(M_PASS_DATE,'DD/MM/YYYY')  AND
                   TO_DATE(TO_CHAR(B.ISSUE_DATE,'DD-MON-YYYY'),'DD-MON-YYYY')<= TO_DATE(M_PASS_DATE,'DD/MM/YYYY') AND
                   A.FACE_VAL>0 AND
                   A.FACE_VAL_CURR IS NULL AND
                   A.SCRIP_STATUS=M_SCRIP_STATUS AND
                   A.SECURITY_CODE=M_SECURITY_CODE AND
                   A.INST_TYPE=M_INST_TYPE)T2
    WHERE T1.X3=T2.X3;


 BEGIN
  DELETE FROM DN_TEMP_OR_INVENTORY_DRILL;
  COMMIT;
  --------------------------------------------------------------------

  FOR I IN  SERIAL_NO
  LOOP

  INSERT INTO DN_TEMP_OR_INVENTORY_DRILL
  (PORTFOLIO_CODE,INST_TYPE,SECURITY_CODE,DEAL_NO,VALUEDATE,FACE_VAL,RET_DUE_DATE,SERIAL_NO)
  VALUES
  (I.X1,I.X2,I.X3,I.X4,I.X5,I.X6,I.X7,I.X9);
  COMMIT;

  END LOOP;
  --========================================
  FOR R IN  UNWANTED_RECS
  LOOP

  DELETE FROM DN_TEMP_OR_INVENTORY_DRILL
  WHERE  SECURITY_CODE=R.X1 AND
         POSITION='UPPER';

  COMMIT;

  END LOOP;
  END DN_OR_INVENTORY_RPT_DRILL;
/*CREATE TABLE DN_TEMP_OR_INVENTORY_DRILL
 (
   PORTFOLIO_CODE             VARCHAR2(6),
   INST_TYPE                  VARCHAR2(5) ,
   SECURITY_CODE              VARCHAR2(19),
   DEAL_NO                    VARCHAR2(14),
   VALUEDATE                  VARCHAR2(10),
   FACE_VAL                   NUMBER,
   RET_DUE_DATE               VARCHAR2(10),
   SERIAL_NO                  VARCHAR2(20)
   POSITION                   VARCHAR2(5)
 )

*/


-- End of DDL script for DN_OR_INVENTORY_RPT

/
