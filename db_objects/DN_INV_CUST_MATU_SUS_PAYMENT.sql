--------------------------------------------------------
--  DDL for Procedure DN_INV_CUST_MATU_SUS_PAYMENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_CUST_MATU_SUS_PAYMENT" 
(
 M_PROCESS_DATE    DN_SYS_PARAMETER.LAST_DAILY%TYPE
)

   -- Procedure    : Custodial Deal MATURITY payment suspence
   -- System       : Dealnet system
   -- Created by   : V.Thilakesan.
   -- Created on   : 08/12/1999

  AS


CURSOR GROUP_MATURITY IS

SELECT
       A.DEAL_NO,
       A.CUSTODIAL_CODE,
       B.ISSUER_CODE,
       SUM(A.MATURITY_PAY)
    FROM
       DN_INV_INT_CUST_DEAL_SERNO A,
       DN_REF_SECURITY B
    WHERE
       A.PROCESS_DATE=M_PROCESS_DATE
       AND
       A.MATURITY_PAY>0
       AND
       A.SECURITY_CODE=B.SECURITY_CODE
    GROUP BY
       A.DEAL_NO,
       A.CUSTODIAL_CODE,
       B.ISSUER_CODE;

M_DEAL_NO                    DN_INV_INT_CUST_DEAL_SERNO.DEAL_NO%TYPE;
M_CUSTODIAL_CODE             DN_INV_INT_CUST_DEAL_SERNO.CUSTODIAL_CODE%TYPE;
M_ISSUER_CODE                DN_REF_SECURITY.ISSUER_CODE%TYPE;
M_MATURITY_PAY               DN_INV_INT_CUST_DEAL_SERNO.MATURITY_PAY%TYPE;

BEGIN

        --Serial Number Level

        OPEN GROUP_MATURITY;

        LOOP

           FETCH  GROUP_MATURITY INTO

           M_DEAL_NO,M_CUSTODIAL_CODE,M_ISSUER_CODE,M_MATURITY_PAY;

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
               'CM'||TO_CHAR(M_PROCESS_DATE,'YYYY')||TO_CHAR(M_PROCESS_DATE,'MM')||TO_CHAR(M_PROCESS_DATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_CUS_MATUSUSPAY.NEXTVAL),5,'0'),
               'M',
               M_CUSTODIAL_CODE,
               M_ISSUER_CODE,
               M_MATURITY_PAY,
               0,
               0,
               M_MATURITY_PAY,
               SYSDATE,
               SYSDATE
            FROM DUAL;

    END LOOP;

END DN_INV_CUST_MATU_SUS_PAYMENT;

/
