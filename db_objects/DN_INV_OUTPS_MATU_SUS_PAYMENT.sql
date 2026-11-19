--------------------------------------------------------
--  DDL for Procedure DN_INV_OUTPS_MATU_SUS_PAYMENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_OUTPS_MATU_SUS_PAYMENT" 
(
 M_PROCESS_DATE    DN_SYS_PARAMETER.LAST_DAILY%TYPE
)

   -- Procedure    : Outright MATURITY payment suspen
   -- System       : Dealnet system
   -- Created by   : ITU - D.P. Pubudu Thushara
   -- Created on   : 10/08/1999

  AS


CURSOR GROUP_MATURITY IS

SELECT
       A.DEAL_NO,
       A.PORTFOLIO_CODE,
       B.ISSUER_CODE,
       SUM(A.MATURITY_PAY)
    FROM
       DN_INV_INT_OUTPS_DEAL_SERNO A,
       DN_REF_SECURITY B
    WHERE
       A.PROCESS_DATE=M_PROCESS_DATE
       AND
       A.MATURITY_PAY>0
       AND
       A.SECURITY_CODE=B.SECURITY_CODE
    GROUP BY
       A.DEAL_NO,
       A.PORTFOLIO_CODE,
       B.ISSUER_CODE;



M_DEAL_NO                    DN_INV_INT_OUTPS_DEAL_SERNO.DEAL_NO%TYPE;
M_PORTFOLIO_CODE             DN_INV_INT_OUTPS_DEAL_SERNO.PORTFOLIO_CODE%TYPE;
M_ISSUER_CODE                DN_REF_SECURITY.ISSUER_CODE%TYPE;
M_MATURITY_PAY               DN_INV_INT_OUTPS_DEAL_SERNO.MATURITY_PAY%TYPE;




BEGIN

  -- From security level

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
       'MP'||TO_CHAR(M_PROCESS_DATE,'YYYY')||TO_CHAR(M_PROCESS_DATE,'MM')||TO_CHAR(M_PROCESS_DATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_MATU_SUS_PAY.NEXTVAL),5,'0'),
       'M',
       A.PORTFOLIO_CODE,
       B.ISSUER_CODE,
       A.MATURITY_PAY,
       0,
       0,
       A.MATURITY_PAY,
       SYSDATE,
       SYSDATE
    FROM
       DN_INV_INT_OUTPS_DEAL_SEC A,
       DN_REF_SECURITY B
    WHERE
       A.PROCESS_DATE=M_PROCESS_DATE
       AND
       A.MATURITY_PAY>0
       AND
       A.SECURITY_CODE=B.SECURITY_CODE;

--Serial Number Level


        OPEN GROUP_MATURITY;

        LOOP

           FETCH  GROUP_MATURITY INTO

           M_DEAL_NO,M_PORTFOLIO_CODE,M_ISSUER_CODE,M_MATURITY_PAY;

           EXIT WHEN GROUP_MATURITY%NOTFOUND;

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
               'MP'||TO_CHAR(M_PROCESS_DATE,'YYYY')||TO_CHAR(M_PROCESS_DATE,'MM')||TO_CHAR(M_PROCESS_DATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_MATU_SUS_PAY.NEXTVAL),5,'0'),
               'M',
               M_PORTFOLIO_CODE,
               M_ISSUER_CODE,
               M_MATURITY_PAY,
               0,
               0,
               M_MATURITY_PAY,
               SYSDATE,
               SYSDATE
            FROM DUAL;

    END LOOP;

END DN_INV_OUTPS_MATU_SUS_PAYMENT;

/
