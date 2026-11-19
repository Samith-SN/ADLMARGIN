--------------------------------------------------------
--  DDL for Procedure DN_CUSTODIAL_PROCESS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_CUSTODIAL_PROCESS" 
(
M_LAST_DAILY1           VARCHAR2
)

/**************************************************************/
/* Procedure   : Custodial Control Process for DEALNET System */
/* System      : DEALNET System                               */
/* Created By  : nirmala fernando                             */
/* Created On  : 10/07/2000                                   */
/**************************************************************/
IS
    M_LAST_DAILY           DN_SYS_PARAMETER_CUSTODIAL.LAST_CUSTODIAL_DATE%TYPE;

BEGIN
--RAISE_APPLICATION_ERROR(-20201,'HELLO'||' '||M_LAST_DAILY);
  M_LAST_DAILY:=TO_DATE(M_LAST_DAILY1,'DD-MM-YYYY');
    DN_CHECK_CONDITIONS_START(M_LAST_DAILY);
-------------------------------------------------------------------------------------------
   --Custodial - Coupon--
  DN_INV_CUST_COUPON_PAYMENT(M_LAST_DAILY);
  DN_INV_CUST_COUP_SUS_PAYMENT(M_LAST_DAILY);


  --Custodial - Maturity--
   DN_INV_CUST_MATURITY_PAYMENT(M_LAST_DAILY);
   DN_INV_CUST_MATU_SUS_PAYMENT(M_LAST_DAILY);

---------------------------------------------------------------------------------------------

   UPDATE DN_SYS_PARAMETER_CUSTODIAL
   SET LAST_CUSTODIAL_DATE=M_LAST_DAILY;

--     DN_CHECK_CONDITIONS_END(M_LAST_DAILY);

   COMMIT;

END DN_CUSTODIAL_PROCESS;

/
