--------------------------------------------------------
--  DDL for Procedure BROCKERAGE_INVOICING_IN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."BROCKERAGE_INVOICING_IN" (
        --M_INVOICE_NO        IN OUT   DN_TRN_BROKERAGE.INVOICE_NO%TYPE,
        M_DEAL_NO                    DN_TRN_BROKERAGE.DEAL_NO%TYPE
       -- M_REMARK                     DN_TRN_BROKERAGE.REMARK%TYPE,
        --M_SELECT_TYPE                VARCHAR2,
        --M_CP_CODE                    DN_TRN_BROKERAGE.CP_CODE%TYPE,
        --M_INVOICE_NO2                DN_TRN_BROKERAGE.INVOICE_NO%TYPE
)
AS





M_SDATE             DN_TRN_BROKERAGE.INVOICE_DATE%TYPE;
M_INVOICE_NO        DN_TRN_BROKERAGE.INVOICE_NO%TYPE;

 BEGIN
--RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO ||' '||M_REMARK||' '||M_SELECT_TYPE||' '||M_CP_CODE);
--                             OR20001026-011    TEST            MAIN1               NWAM

    /* PROCEDURE  - TO SAVE BROCKERAGE INVOICING SCREEN
       SYSTEM     - DEALNET
       CREATED BY - LATHIKA
       CREATED ON - 14-DEC-1999 */
FOR M  IN (SELECT DEAL_NO,CP_CODE
FROM   DN_TRN_BROKERAGE
WHERE  DEAL_NO=M_DEAL_NO AND
        INVOICE_NO IS NULL AND
        APP_STATUS IS NULL  AND
        INVOICE_STATUS ='N')

LOOP

M_INVOICE_NO:=NULL;

 SELECT
       SYSDATE
   INTO
       M_SDATE
   FROM
       DUAL;

----CHANGE THE SEQUENCE NAME--------------

  --IF M_INVOICE_NO2 IS NULL THEN
       SELECT
         'BI'||TO_CHAR(SYSDATE,'YYYY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_BROKERAGE_FEES_INV.NEXTVAL),3,'0')
       INTO
         M_INVOICE_NO
       FROM
         DUAL;

  --ELSE
   -- M_INVOICE_NO:=M_INVOICE_NO2;

  --END IF;
--RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO ||''||M_CP_CODE);
--IF M_DEAL_NO IS NOT NULL  AND M_SELECT_TYPE='MAIN1' THEN

    UPDATE DN_TRN_BROKERAGE
       SET
       --REMARK           =M_REMARK,
           INVOICE_STATUS   ='N',
           INVOICE_NO       =M_INVOICE_NO,
           INVOICE_DATE     =M_SDATE
      WHERE
           DEAL_NO  =M_DEAL_NO
      AND  CP_CODE  =M.CP_CODE;

     /*INSERT INTO DN_ACC_SUS_RECEIPT
           (SUS_REF_NO,SUSPENSE_ENTRY_TYPE,
            RECEIVER,PAYER,TOT_SETTLE_AMOUNT,
            INT_BAL_SETTLE_AMOUNT,REC_FROM_INT_BAL_AMT,
            BAL_TO_BE_RECEIVED,ENT_DATE,LAST_MOD_DATE)
            SELECT
                 M_INVOICE_NO,'D',
                 BROK_CODE,CP_CODE,BROK_TOT_AMT_DUE,
                 0,0,
                 BROK_TOT_AMT_DUE,M_SDATE,M_SDATE
            FROM
                 DN_TRN_BROKERAGE
            WHERE
                 DEAL_NO  =M_DEAL_NO
            AND  CP_CODE  =M_CP_CODE
            AND  BROK_CODE IN (SELECT DISTINCT  PORTFOLIO_CODE
                               FROM DN_REF_PORTFOLIO
                               WHERE OWNED_BY_MBFSL ='N' );*/

/*---------nirmala
     INSERT INTO DN_ACC_SUS_PAYMENT
           (SUS_REF_NO,SUSPENSE_ENTRY_TYPE,
            RECEIVER,PAYER,
            TOT_SETTLE_AMOUNT,INT_BAL_SETTLE_AMOUNT,
            PAY_FROM_INT_BAL_AMT,BAL_TO_BE_PAID,
            ENT_DATE,LAST_MOD_DATE)
            SELECT
                 M_INVOICE_NO,'D',
                 BROK_CODE,CP_CODE,BROK_TOT_AMT_DUE,
                 0,0,
                 BROK_TOT_AMT_DUE,M_SDATE,M_SDATE
            FROM
                 DN_TRN_BROKERAGE
            WHERE
                 DEAL_NO  =M_DEAL_NO
            AND  CP_CODE  =M_CP_CODE
            AND  BROK_CODE IN (SELECT DISTINCT  PORTFOLIO_CODE
                               FROM DN_REF_PORTFOLIO
                               WHERE OWNED_BY_MBFSL ='N' );

*/

 DN_ACC_F_MAIN(M_INVOICE_NO);
END LOOP;
 --END IF;

 --COMMIT;


END BROCKERAGE_INVOICING_IN;

/
