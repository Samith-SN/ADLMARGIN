--------------------------------------------------------
--  DDL for Procedure DN_INV_OUTPS_COUP_SUS_PAYMENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_OUTPS_COUP_SUS_PAYMENT" 
(
 M_PROCESS_DATE    DN_SYS_PARAMETER.LAST_DAILY%TYPE
)

   -- Procedure    : Outright coupon payment suspen
   -- System       : Dealnet system
   -- Created by   : ITU - D.P. Pubudu Thushara
   -- Created on   : 10/08/1999

  AS



CURSOR GROUP_COUPON IS

SELECT
       A.DEAL_NO,
       A.PORTFOLIO_CODE,
       B.ISSUER_CODE,
       SUM(A.COUP_PAY)
    FROM
       DN_INV_INT_OUTPS_DEAL_SERNO A,
       DN_REF_SECURITY B
    WHERE
       A.PROCESS_DATE=M_PROCESS_DATE
       AND
       A.COUP_PAY>0
       AND
       A.SECURITY_CODE=B.SECURITY_CODE
    GROUP BY
       A.DEAL_NO,
       A.PORTFOLIO_CODE,
       B.ISSUER_CODE;



M_DEAL_NO                    DN_INV_INT_OUTPS_DEAL_SERNO.DEAL_NO%TYPE;
M_PORTFOLIO_CODE             DN_INV_INT_OUTPS_DEAL_SERNO.PORTFOLIO_CODE%TYPE;
M_ISSUER_CODE                DN_REF_SECURITY.ISSUER_CODE%TYPE;
M_COUP_PAY                   DN_INV_INT_OUTPS_DEAL_SERNO.COUP_PAY%TYPE;
M_COUNT                      NUMBER;

BEGIN
dbms_output.put_line('Value of M_PROCESS_DATE='||M_PROCESS_DATE);
  -- From security level

SELECT
   COUNT(*) INTO M_COUNT
    FROM
       DN_INV_INT_OUTPS_DEAL_SEC A,
       DN_REF_SECURITY B
    WHERE
       A.PROCESS_DATE=M_PROCESS_DATE
       AND
       A.COUP_PAY>0
       AND
       A.SECURITY_CODE=B.SECURITY_CODE;
dbms_output.put_line('Value of M_COUNT='||M_COUNT);

   INSERT INTO DN_ACC_SUS_RECEIPT
      (SUS_REF_NO,
       SUSPENSE_ENTRY_TYPE,
       RECEIVER,
       PAYER,
       TOT_SETTLE_AMOUNT,
       INT_BAL_SETTLE_AMOUNT,
       REC_FROM_INT_BAL_AMT,
       BAL_TO_BE_RECEIVED,
       ENT_DATE,
       LAST_MOD_DATE
      )
    SELECT
       'CP'||TO_CHAR(M_PROCESS_DATE,'YYYY')||TO_CHAR(M_PROCESS_DATE,'MM')||TO_CHAR(M_PROCESS_DATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_COUP_SUS_PAY.NEXTVAL),5,'0'),
       'C',
       A.PORTFOLIO_CODE,
       B.ISSUER_CODE,
       A.COUP_PAY,
       0,
       0,
       A.COUP_PAY,
       SYSDATE,
       SYSDATE
    FROM
       DN_INV_INT_OUTPS_DEAL_SEC A,
       DN_REF_SECURITY B
    WHERE
       A.PROCESS_DATE=M_PROCESS_DATE
       AND
       A.COUP_PAY>0
       AND
       A.SECURITY_CODE=B.SECURITY_CODE;


--Serial Number Level

        OPEN GROUP_COUPON;

        LOOP

           FETCH  GROUP_COUPON INTO

           M_DEAL_NO,M_PORTFOLIO_CODE,M_ISSUER_CODE,M_COUP_PAY;

           EXIT WHEN GROUP_COUPON%NOTFOUND;
           dbms_output.put_line('2222Value of M_DEAL_NO='||M_DEAL_NO);
           INSERT INTO DN_ACC_SUS_RECEIPT
              (SUS_REF_NO,
               SUSPENSE_ENTRY_TYPE,
               RECEIVER,
               PAYER,
               TOT_SETTLE_AMOUNT,
               INT_BAL_SETTLE_AMOUNT,
               REC_FROM_INT_BAL_AMT,
               BAL_TO_BE_RECEIVED,
               ENT_DATE,
               LAST_MOD_DATE
              )
            SELECT
               'CP'||TO_CHAR(M_PROCESS_DATE,'YYYY')||TO_CHAR(M_PROCESS_DATE,'MM')||TO_CHAR(M_PROCESS_DATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_COUP_SUS_PAY.NEXTVAL),5,'0'),
               'C',
               M_PORTFOLIO_CODE,
               M_ISSUER_CODE,
               M_COUP_PAY,
               0,
               0,
               M_COUP_PAY,
               SYSDATE,
               SYSDATE
            FROM DUAL;

    END LOOP;


END DN_INV_OUTPS_COUP_SUS_PAYMENT;

/
