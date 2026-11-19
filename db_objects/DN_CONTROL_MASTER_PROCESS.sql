--------------------------------------------------------
--  DDL for Procedure DN_CONTROL_MASTER_PROCESS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_CONTROL_MASTER_PROCESS" 
(
M_LAST_DAILY     DATE,--    DN_SYS_PARAMETER.LAST_DAILY%TYPE,
M_USERNAME   VARCHAR2
)
/**************************************************************/
/* Procedure   : Control Process for DEALNET System           */
/* System      : DEALNET System                               */
/* Created By  : D.P.Pubudu Thushara                          */
/* Created On  : 09/08/1999                                   */
/**************************************************************/

IS
 M_ERR_MSG               VARCHAR2(200);

BEGIN

--   DBMS_OUTPUT.PUT_LINE('Started at '||TO_CHAR(SYSDATE,'DD/MM/YYYY HH:MI:SS'));

   --Outright---------------------------------------------
   -- forward values transfer
   --- TEMP COMMENTED BY MANJULA ON 15-10-2010 TO PROBLEM ON 12-OCT -2010 TRANSACTIONS..
   DN_INV_OUTPS_FWD_VALUE_TRNSFER(M_LAST_DAILY);  --OK


   DN_DAYEND_SCRIPLESS(M_LAST_DAILY);  --FOR SCRIPLESS
   --DN_INV_AMALGAMATE_SERIALNO_SL(M_LAST_DAILY);--$$##SC

     --(A) PROCEDURE WAS HERE AND CHANGED THE POSITION ON 15-07-2004 VC04-200

     -- Coupon Payment
   DN_INV_OUTPS_COUPON_PAYMENT(M_LAST_DAILY); --(B) --OK -- SHIFTED TO THIS POSITION

   -- sale values
   DN_INV_OUTPS_SALE_VALUES(M_LAST_DAILY);  --(A) --OK

   --(C) PROCEDURE WAS HERE AND CHANGED THE POSITION ON 15-07-2004 VC04-200
   --(B) PROCEDURE WAS HERE AND CHANGED THE POSITION ON 15-07-2004 VC04-200

   -- ON 30/01/2000 BY SM
   -- Interest
     DN_INV_OUTPS_INTEREST(M_LAST_DAILY);  --OK

     DN_DAYEND_WEIGHT(M_LAST_DAILY); --ADDED BY SVA ON 04-04-2005 FOR WEIGHTED AVERAGE

     DN_INV_OUTPS_INTR_SL_TRANSFER(M_LAST_DAILY); --(C) --OK

   -- Delayed Allocation
     DN_INV_OUTPS_DEL_ALLO_INTEREST(M_LAST_DAILY);

-- Coupon Payment
--   DN_INV_OUTPS_COUPON_PAYMENT(M_LAST_DAILY);  --OK
--   THIS PROCEDURE WAS SHIFTED UP FROM THIS OPSITION ON 30/01/2000 BY SM TO OVERCOME PROBLEM
--   OF NEGATIVE COUPON CALCULATIONS ON COUPON DATE, IDENTIFIED AT NWAM

   -- Coupon Payment Suspense
   DN_INV_OUTPS_COUP_SUS_PAYMENT(M_LAST_DAILY);  --OK
   -- Maturity Payment
   DN_INV_OUTPS_MATURITY_PAYMENT(M_LAST_DAILY); --OK
   -- Maturiy Payment Suspense
   DN_INV_OUTPS_MATU_SUS_PAYMENT(M_LAST_DAILY);  --OK
   -- History
   DN_INV_OUTPS_HIS_UPDATION(M_LAST_DAILY);    --OK
   -- Link to Accounts
   DN_ACC_LINK_OUTPS_DAYEND(M_LAST_DAILY); 
   ----- TEMP COMMENTED BY MANJULA ON 15-10-2010 TO PROBLEM ON 12-OCT -2010 TRANSACTIONS..


    --Repo General---------------------------------------

   -- Adjust On-Call Deals Carry Forward Values
   DN_TRN_REPO_ONCALL_ADJ(M_LAST_DAILY);
   -- Forward values
   DN_INV_REPO_FWD_VALUE_TRNSFER(M_LAST_DAILY);   --OK
   -- allocated repo values
   DN_INV_ALLO_REPO_VAL_MATURITY(M_LAST_DAILY);  --OK
   -- Interest Accru.
  DN_INV_REPO_DEAL_INT_ACCR(M_LAST_DAILY);  --OK ---- REMOVED ONLY FOR 31-08-2010 TRANSACTIONS - PABC
   -- Link to Accounts
   DN_ACC_LINK_REPO_DAYEND(M_LAST_DAILY);


   --B/L General---------------------------------------
   -- Forward values
  --- TEMP COMMENTED BY MANJULA ON 15-10-2010 TO PROBLEM ON 12-OCT -2010 TRANSACTIONS..
  DN_INV_BL_FWD_VALUE_TRNSFER(M_LAST_DAILY);
   -- allocated repo values
   DN_INV_ALLO_BL_VAL_MATURITY(M_LAST_DAILY);
   -- Interest Accru.
   DN_INV_BL_DEAL_INT_ACCR(M_LAST_DAILY);
   -- Link to Accounts
   DN_ACC_LINK_BL_DAYEND(M_LAST_DAILY); --OK

 --Repo Periodic Interest ----------------------------
   --Interest Calculation
   DN_RP_PAY_FREQ_ROUTINE(M_LAST_DAILY);

   ----Custodial-----------------------------------------
--  DN_INV_CUST_COUPON_PAYMENT(M_LAST_DAILY);  --FOLLOWING PROCEDURES REMARKED BY SM ON 13/06/2000 TO AVOID DUPLICATION AND PENDING NEW PROCEDURE
--  DN_INV_CUST_COUP_SUS_PAYMENT(M_LAST_DAILY);


        -----Maturity------------
--   DN_INV_CUST_MATURITY_PAYMENT(M_LAST_DAILY);
--   DN_INV_CUST_MATU_SUS_PAYMENT(M_LAST_DAILY);

   --DN_MARGIN_CALL_STATUS(TO_CHAR(M_LAST_DAILY,'DD-MM-YYYY'));

    DN_CORPORATE_ACTIONS_SAVE(M_LAST_DAILY,M_USERNAME);

 --- TEMP COMMENTED BY MANJULA ON 15-10-2010 TO PROBLEM ON 12-OCT -2010 TRANSACTIONS..

   UPDATE DN_SYS_PARAMETER
   SET LAST_DAILY=M_LAST_DAILY;        --OK

 --General---------------------------------------------
   -- adjust sequenses
  --DN_CAL_ADJUST_SEQUENCES;  -- COMMENTED BY SVA ON 03-10-2005--OK --TEMP COMMENTED BY SVA ON 03-02-2005

--   DBMS_OUTPUT.PUT_LINE('Stopped at '||TO_CHAR(SYSDATE,'DD/MM/YYYY HH:MI:SS'));

 --COMMIT;
/*
EXCEPTION
 WHEN OTHERS THEN
 M_ERR_MSG:=SUBSTR(SQLERRM,1,200);
 ROLLBACK;

    INSERT INTO DN_SYS_DAYEND_ERROR_LOG
    VALUES (M_LAST_DAILY,
            SUBSTR(M_ERR_MSG,1,200),
            SYSDATE);
    COMMIT;*/
END DN_CONTROL_MASTER_PROCESS; 

/
