--------------------------------------------------------
--  DDL for Procedure CS_FEES_INVOICING_IN2
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."CS_FEES_INVOICING_IN2" (
        M_INVOICE_NO        IN OUT   DN_TRN_BO_CUSTODIAL_FEES.INVOICE_NO%TYPE,
        M_REMARK                     DN_TRN_BO_CUSTODIAL_FEES.REMARK%TYPE,
        M_FEE_AMOUNT                 DN_TRN_BO_CUSTODIAL_FEES.FEE_AMOUNT%TYPE,
        M_GST_AMOUNT                 DN_TRN_BO_CUSTODIAL_FEES.GST_AMOUNT%TYPE,
        M_GROSS_AMOUNT               DN_TRN_BO_CUSTODIAL_FEES.GROSS_AMOUNT%TYPE,
        M_PORTFOLIO_CODE             DN_TRN_BO_CUSTODIAL_FEES.PORTFOLIO_CODE%TYPE,
        M_FEE_RATE                   DN_TRN_BO_CUSTODIAL_FEES.FEE_RATE%TYPE,
        M_FEE_BASE                   DN_TRN_BO_CUSTODIAL_FEES.FEE_BASE%TYPE,
        M_SELECT_TYPE                VARCHAR2,
        M_INVOICE_NO2                DN_TRN_BO_CUSTODIAL_FEES.INVOICE_NO%TYPE)

AS

M_SDATE             DN_TRN_BO_CUSTODIAL_FEES.INVOICE_DATE%TYPE;


 BEGIN

/*RAISE_APPLICATION_ERROR(-20201,M_PORTFOLIO_CODE ||' '||M_OWNED_BY_MBFSL||' '||M_CP_PORTFOLIO_CODE||' '||M_PF_NAME||' '||M_ADD_IDENTIFICATION||' '||M_ADD_LOCATION||' '||M_ADD_STREET||' '||M_ADD_CITY||' '||M_ADD_COUNTRY||' ' ||M_POSTAL_CODE||' '||M_DATE_INC_BIRTH||' '||M_BUSI_REG_NIC||' '||M_CATEGORY_ENTITY||' '||M_NATURE_OCCUPATION ||' '||M_SECT_CODE ||' '||M_MBFSL_SECT_CODE||' '||M_NEST_REVIEW );*/


    /* PROCEDURE  - TO SAVE CUSTODIAL FEES INVOICING SCREEN  PORTFOLIOS FEES INVOICING SCREEN
       SYSTEM     - DEALNET
       CREATED BY - LATHIKA
       CREATED ON - 13-DEC-1999 */

--M_INVOICE_NO:=NULL;

 SELECT
       SYSDATE
   INTO
       M_SDATE
   FROM
       DUAL;

IF M_FEE_AMOUNT IS NOT NULL  AND M_SELECT_TYPE='MAIN2' THEN
  IF M_INVOICE_NO2 IS NULL THEN
       SELECT
         'CI'||TO_CHAR(SYSDATE,'YYYY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_CUST_FEES_INV.NEXTVAL),3,'0')
       INTO
         M_INVOICE_NO
       FROM
         DUAL;
 ELSE
    M_INVOICE_NO:=M_INVOICE_NO2;

  END IF;

      INSERT INTO DN_TRN_BO_CUSTODIAL_FEES
        (CUS_FEE_REF_NO,
         PORTFOLIO_CODE,
         FEE_AMOUNT,
         GST_AMOUNT,
         GROSS_AMOUNT,
         REMARK,
         FEE_RATE,
         FEE_BASE,
         INVOICE_STATUS,
         INVOICE_NO,
         INVOICE_DATE)
           VALUES(
             M_INVOICE_NO,
             M_PORTFOLIO_CODE,
             M_FEE_AMOUNT,
             M_GST_AMOUNT,
             M_GROSS_AMOUNT,
             M_REMARK,
             M_FEE_RATE,
             M_FEE_BASE,
             'Y',
             M_INVOICE_NO,
             M_SDATE
            );

    END IF;

   IF M_FEE_AMOUNT IS NOT NULL  AND M_SELECT_TYPE='MAIN3' THEN
    IF M_INVOICE_NO2 IS NULL THEN
       SELECT
         'PI'||TO_CHAR(SYSDATE,'YYYY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_PORT_FEES_INV.NEXTVAL),3,'0')
       INTO
         M_INVOICE_NO
       FROM
         DUAL;
    ELSE
     M_INVOICE_NO:=M_INVOICE_NO2;

   END IF;

      INSERT INTO DN_TRN_BO_CUSTODIAL_FEES
        (CUS_FEE_REF_NO,
         PORTFOLIO_CODE,
         FEE_AMOUNT,
         GST_AMOUNT,
         GROSS_AMOUNT,
         REMARK,
         FEE_RATE,
         FEE_BASE,
         INVOICE_STATUS,
         INVOICE_NO,
         INVOICE_DATE)
           VALUES(
             M_INVOICE_NO,
             M_PORTFOLIO_CODE,
             M_FEE_AMOUNT,
             M_GST_AMOUNT,
             M_GROSS_AMOUNT,
             M_REMARK,
             M_FEE_RATE,
             M_FEE_BASE,
             'Y',
             M_INVOICE_NO,
             M_SDATE
            );

     END IF;
--MAIN3
 COMMIT;


END CS_FEES_INVOICING_IN2;

/
