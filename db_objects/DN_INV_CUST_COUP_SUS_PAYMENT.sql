--------------------------------------------------------
--  DDL for Procedure DN_INV_CUST_COUP_SUS_PAYMENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_CUST_COUP_SUS_PAYMENT" 
(
 M_PROCESS_DATE    DN_SYS_PARAMETER.LAST_DAILY%TYPE
)

   -- Procedure    : Custodial Deal coupon payment suspence
   -- System       : Dealnet system
   -- Created by   : V.Thilakesan.
   -- Created on   : 08/12/1999

  AS

CURSOR GROUP_COUPON IS

SELECT
       A.DEAL_NO,
       A.CUSTODIAL_CODE,
       B.ISSUER_CODE,
       SUM(A.COUP_PAY)
    FROM
       DN_INV_INT_CUST_DEAL_SERNO A,
       DN_REF_SECURITY B
    WHERE
       A.PROCESS_DATE=M_PROCESS_DATE
       AND
       A.COUP_PAY>0
       AND
       A.SECURITY_CODE=B.SECURITY_CODE
    GROUP BY
       A.DEAL_NO,
       A.CUSTODIAL_CODE,
       B.ISSUER_CODE;



M_DEAL_NO                    DN_INV_INT_CUST_DEAL_SERNO.DEAL_NO%TYPE;
M_CUSTODIAL_CODE             DN_INV_INT_CUST_DEAL_SERNO.CUSTODIAL_CODE%TYPE;
M_ISSUER_CODE                DN_REF_SECURITY.ISSUER_CODE%TYPE;
M_COUP_PAY                   DN_INV_INT_CUST_DEAL_SERNO.COUP_PAY%TYPE;


BEGIN

        --Serial Number Level

        OPEN GROUP_COUPON;

        LOOP

           FETCH  GROUP_COUPON INTO

           M_DEAL_NO,M_CUSTODIAL_CODE,M_ISSUER_CODE,M_COUP_PAY;

           EXIT WHEN GROUP_COUPON%NOTFOUND;

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
               'CC'||TO_CHAR(M_PROCESS_DATE,'YYYY')||TO_CHAR(M_PROCESS_DATE,'MM')||TO_CHAR(M_PROCESS_DATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_CUS_COUPSUSPAY.NEXTVAL),5,'0'),
               'C',
               M_CUSTODIAL_CODE,
               M_ISSUER_CODE,
               M_COUP_PAY,
               0,
               0,
               M_COUP_PAY,
               SYSDATE,
               SYSDATE
            FROM DUAL;

    END LOOP;


END DN_INV_CUST_COUP_SUS_PAYMENT;

/
