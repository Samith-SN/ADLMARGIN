--------------------------------------------------------
--  DDL for Procedure DN_INV_CUST_DEAL_FEES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_CUST_DEAL_FEES" 
   (
    M_DEAL_NO   IN OUT      DN_TRN_BO_CUSTODIAL_FEES.CUS_FEE_REF_NO%TYPE,
    M_GST_AM                DN_TRN_BO_CUSTODIAL_FEES.GST_AMOUNT%TYPE,
    M_GROSS_AMOUNT          DN_TRN_BO_CUSTODIAL_FEES.GROSS_AMOUNT%TYPE
   )

   IS

    -- Procedue     : insert a custodial deal in to invoicing table
    -- System       : Dealnet system
    -- Created by   : Lathika
    -- Created on   : 10/01/2000

  M_CUSTODIAL_CODE        DN_TRN_BO_CUSTODIAL_DEAL.CUSTODIAL_CODE%TYPE;
  M_FACE_VALUE            DN_TRN_BO_CUSTODIAL_DEAL.FACE_VALUE%TYPE;
  M_FEE_AMOUNT            DN_TRN_BO_CUSTODIAL_DEAL.FEE_AMOUNT%TYPE;
  M_RATE                  DN_TRN_BO_CUSTODIAL_FEES.FEE_RATE%TYPE;
  M_GST                   DN_REF_TAX_RATE.RATE%TYPE;
  M_GST_AMOUNT2           DN_TRN_BO_CUSTODIAL_FEES.GST_AMOUNT%TYPE;

BEGIN

IF M_DEAL_NO IS NOT NULL THEN
M_RATE:= 0;
--M_GST_AMOUNT2 :=100;
 SELECT
      CUSTODIAL_CODE,NVL(FEE_AMOUNT,0),NVL(FACE_VALUE,0)
   INTO
      M_CUSTODIAL_CODE,M_FEE_AMOUNT,M_FACE_VALUE
   FROM
      DN_TRN_BO_CUSTODIAL_DEAL
   WHERE
      DEAL_NO=M_DEAL_NO;

M_RATE:=(M_FEE_AMOUNT * 100 )/M_FACE_VALUE ;

--RAISE_APPLICATION_ERROR(-20201,M_GST||''||M_DEAL_NO||''||M_FACE_VALUE||''||M_FACE_VALUE2||''||M_GST_AMOUNT2||''||M_GST_AM||''||M_GROSS_AMOUNT);

  INSERT INTO DN_TRN_BO_CUSTODIAL_FEES
        (CUS_FEE_REF_NO,
         PORTFOLIO_CODE,
         FEE_AMOUNT,
         GST_AMOUNT,
         GROSS_AMOUNT,
         FEE_RATE,
         FEE_BASE)
           VALUES(
             M_DEAL_NO,
             M_CUSTODIAL_CODE,
             M_FEE_AMOUNT,
             M_GST_AM,
             M_GROSS_AMOUNT,
             M_RATE,
             M_FACE_VALUE
             );

 END IF;

 COMMIT;

END DN_INV_CUST_DEAL_FEES;

/
