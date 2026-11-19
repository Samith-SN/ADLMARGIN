--------------------------------------------------------
--  DDL for Procedure DN_BO_INV_EXCH_RP_I
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_BO_INV_EXCH_RP_I" 
   (
    M_INV_EXCHG_NO      DN_TRN_BO_INV_EXCHANGE.INV_EXCHG_NO%TYPE,
    M_COUNP_LOCATION    DN_TRN_REPO_FRESH.BORR_PORTFOLIO_CODE%TYPE --ADDED BY SM ON 25/05/2000 TO REMEDY ERRORS IN LOCATION SUBSEQUENT TO AN 'EXCHANGE'
   )

   IS

    -- Procedue     : Update exchange of inventory allocated for Repo transaction (hence 'RP_I')
    -- System       : Dealnet system
    -- Created by   : TDS / SM
    -- Created on   : 04/11/1999


--PERFORM A CHECK TO REFER TO THE DEAL NUMBER AND DETERMINE WETHER THE THE PORTFOLIO IS LENDER
--AND WETHER THE SUBSTRING OF THE DEAL NUMBER IS 'RF' OR 'RR'
--TO BE CHECKED AT THE POINT OF CALLING THE PROCEDURE


--FOR INVENTORY ALLOCATED FROM 'OR' INVENTORY--


--WE SHOULD TACKLE ALL INVENTORY TYPES HERE ??
--BECAUSE RECEIPTS AND ISSUES MAY NOT BE FROM THE SAME INVENTORY

  CURSOR  EXCH_ISSUES IS

      SELECT
          A.PORTFOLIO_CODE,
          A.INST_TYPE,
          A.SECURITY_CODE,
          A.ALLO_DEAL_NO,
          A.SERIAL_NO,
          A.FACE_VALUE,
          A.DEAL_NO,
          A.INV_CODE,
          A.PART_ALLO_STATUS
       FROM
          DN_TRN_BO_INV_EXCHANGE A
       WHERE
          A.INV_EXCHG_NO=M_INV_EXCHG_NO
          AND
          A.TRANS_TYPE='I';


  CURSOR  EXCH_RECEIPTS IS

      SELECT
          A.PORTFOLIO_CODE,
          A.INST_TYPE,
          A.SECURITY_CODE,
          A.ALLO_DEAL_NO,
          A.SERIAL_NO,
          A.FACE_VALUE,
          A.DEAL_NO,
          A.INV_CODE,
          A.PART_ALLO_STATUS----VC UNALLO
       FROM
          DN_TRN_BO_INV_EXCHANGE A
       WHERE
          A.INV_EXCHG_NO=M_INV_EXCHG_NO
          AND
          A.TRANS_TYPE='R';


M_PORTFOLIO_CODE                DN_INV_REPO_DEAL_SERIAL_NO.PORTFOLIO_CODE%TYPE;
M_INST_TYPE                     DN_INV_REPO_DEAL_SERIAL_NO.INST_TYPE%TYPE;
M_SECURITY_CODE                 DN_INV_REPO_DEAL_SERIAL_NO.SECURITY_CODE%TYPE;
M_DEAL_NO                       DN_INV_REPO_DEAL_SERIAL_NO.DEAL_NO%TYPE;
M_SERIAL_NO                     DN_INV_REPO_DEAL_SERIAL_NO.SERIAL_NO%TYPE;
M_LOCATION                      DN_INV_REPO_DEAL_SERIAL_NO.LOCATION%TYPE;
M_RET_DUE_DATE                  DN_INV_REPO_DEAL_SERIAL_NO.RET_DUE_DATE%TYPE;
M_FACE_VALUE                    DN_INV_REPO_DEAL_SERIAL_NO.FACE_VAL%TYPE;
U_DEAL_NO                       DN_INV_REPO_DEAL_SERIAL_NO.DEAL_NO%TYPE;
U_SECURITY_CODE                 DN_INV_REPO_DEAL_SERIAL_NO.SECURITY_CODE%TYPE;
U_INV_CODE                      DN_TRN_REPO_FRESH_SEC.INV_CODE%TYPE;
U_FACE_VALUE                    DN_INV_REPO_DEAL_SERIAL_NO.FACE_VAL%TYPE;
BAL_FACE_VALUE                  DN_INV_REPO_DEAL_SERIAL_NO.FACE_VAL%TYPE;
CURS_UP_SEC                     SASIAPLSQLTAB.SEC_SUM;
M_COUNT                         NUMBER;
M_ALLO_REPO                     DN_INV_REPO_DEAL_SERIAL_NO.ALLO_REPO%TYPE;
M_ALLO_BL                       DN_INV_REPO_DEAL_SERIAL_NO.ALLO_BL%TYPE;
M_FWD_ALLO_REPO                 DN_INV_REPO_DEAL_SERIAL_NO.FWD_ALLO_REPO%TYPE;
M_FWD_ALLO_BL                   DN_INV_REPO_DEAL_SERIAL_NO.FWD_ALLO_BL%TYPE;
M_ALLO_DEAL_NO                  DN_INV_REPO_DEAL_SERIAL_NO.DEAL_NO%TYPE;
M_INV_CODE                      DN_TRN_BO_INV_EXCHANGE.INV_CODE%TYPE;
M_ALLO_TYPE                     DN_INV_REPO_DEAL_SERNO_ALLO.ALLO_TYPE%TYPE;
M_START_DATE                    DN_INV_REPO_DEAL_SERNO_ALLO.START_DATE%TYPE;
M_END_DATE                      DN_INV_REPO_DEAL_SERNO_ALLO.END_DATE%TYPE;
  ---------------------------$$##SC-----------------------------------------
   MNN_SCRIPT_STATUS  VARCHAR2(2);
   M_SWAP_SERNO3                DN_TRN_REPO_FRESH_SERIAL_NO.SERIAL_NO%TYPE;
   M_SWAP_SERNO4                DN_TRN_REPO_FRESH_SERIAL_NO.SERIAL_NO%TYPE;
   MM_SWAP_DEAL                 DN_TRN_REPO_FRESH.DEAL_NO%TYPE;
   M_FACTOR1   NUMBER;
   M_FACTOR2   NUMBER;
   M_PART_ALLO_STATUS  VARCHAR2(1);
   ---------------------------------------------------------------------------
BEGIN


    OPEN EXCH_ISSUES;

   LOOP

      FETCH  EXCH_ISSUES INTO

          M_PORTFOLIO_CODE,
          M_INST_TYPE,
          M_SECURITY_CODE,
          M_ALLO_DEAL_NO,
          M_SERIAL_NO,
          M_FACE_VALUE,
          M_DEAL_NO,
          M_INV_CODE,
          M_PART_ALLO_STATUS;


      EXIT WHEN EXCH_ISSUES%NOTFOUND;

      M_ALLO_REPO:=0;
      M_ALLO_BL:=0;
      M_FWD_ALLO_REPO:=0;
      M_FWD_ALLO_BL:=0;


      IF SUBSTR(M_ALLO_DEAL_NO,1,2)='RF' THEN
          M_ALLO_TYPE:='RP';

          SELECT EFF_VALDATE,MATURITY_DATE
          INTO M_START_DATE,M_END_DATE
          FROM DN_TRN_REPO_FRESH
          WHERE DEAL_NO=M_ALLO_DEAL_NO;

          IF M_START_DATE<=SYSDATE THEN
             M_START_DATE:=SYSDATE;

             M_ALLO_REPO:=M_FACE_VALUE;

          ELSE
             M_FWD_ALLO_REPO:=M_FACE_VALUE;

          END IF;


       ELSIF SUBSTR(M_ALLO_DEAL_NO,1,2)='RR' THEN
          M_ALLO_TYPE:='RP';

          SELECT EFF_VALDATE,MATURITY_DATE
          INTO M_START_DATE,M_END_DATE
          FROM DN_TRN_REPO_ROLLOVER
          WHERE DEAL_NO=M_ALLO_DEAL_NO;

          IF M_START_DATE<=SYSDATE THEN
             M_START_DATE:=SYSDATE;

             M_ALLO_REPO:=M_FACE_VALUE;

          ELSE
             M_FWD_ALLO_REPO:=M_FACE_VALUE;

          END IF;

      ELSIF SUBSTR(M_ALLO_DEAL_NO,1,2)='PI' THEN
          M_ALLO_TYPE:='RP';

          SELECT EFF_VALDATE,MATURITY_DATE
          INTO M_START_DATE,M_END_DATE
          FROM DN_TRN_REPO_PERIOD_INT
          WHERE DEAL_NO=M_ALLO_DEAL_NO;

          IF M_START_DATE<=SYSDATE THEN
             M_START_DATE:=SYSDATE;

             M_ALLO_REPO:=M_FACE_VALUE;

          ELSE
             M_FWD_ALLO_REPO:=M_FACE_VALUE;

          END IF;





      END IF;

      IF M_INV_CODE='OR' THEN
                 IF ((M_PART_ALLO_STATUS='1')AND (SUBSTR(M_SERIAL_NO,1,1)='S')) THEN --$$##SC added by nilu on 19.05.04


             -------------------------------------$$##SC------------------------------------------


               SELECT  'S'||TO_CHAR(SYSDATE,'YYYY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||LPAD(TO_CHAR(DN_SEQ_SCRIPLESS.NEXTVAL),4,'0')--$$##SC
               INTO    M_SWAP_SERNO3
               FROM    DUAL;

SELECT   (SCRIP_FACE_VAL-M_FACE_VALUE)/SCRIP_FACE_VAL , (M_FACE_VALUE)/SCRIP_FACE_VAL
INTO     M_FACTOR1,M_FACTOR2
FROM     DN_INV_OUTPS_DEAL_SERIAL_NO
WHERE    DEAL_NO=M_DEAL_NO AND
         SERIAL_NO =M_SERIAL_NO AND
         --FACE_VAL=MM_FACE_VAL AND
         SECURITY_CODE=M_SECURITY_CODE AND
         SCRIP_STATUS='SL';


                INSERT INTO DN_INV_OUTPS_DEAL_SERIAL_NO
                   (PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,
                    SERIAL_NO,
                    DEAL_YIELD,
                    YIELD_WITH_BROKERAGE,SCRIP_FACE_VAL,FACE_VAL,INITIAL_COST, BROKERAGE, PRICE_INT_ACCR,
                    CARR_VAL,COUP_INT_PURCH,COUP_INT_ACCR,TOT_COUP_INT,FWD_SALE,FWD_PURCHASE,LOCATION,
                    ALLO_REPO,ALLO_BL,FWD_ALLO_REPO,FWD_ALLO_BL,SALE_DEAL_NO,SERIAL_NO_STATUS,
                    SALE_EFF_VALDATE,RET_DUE_DATE,COST_TRANS_STATUS,SCRIP_STATUS,ORG_SERNO)


                SELECT  PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,
                        M_SWAP_SERNO3,DEAL_YIELD,YIELD_WITH_BROKERAGE,SCRIP_FACE_VAL-M_FACE_VALUE,FACE_VAL-M_FACE_VALUE,
                        INITIAL_COST*M_FACTOR1,
                        BROKERAGE*M_FACTOR1,
                        PRICE_INT_ACCR*M_FACTOR1,
                        CARR_VAL*M_FACTOR1,
                        COUP_INT_PURCH*M_FACTOR1,
                        COUP_INT_ACCR*M_FACTOR1,
                        TOT_COUP_INT*M_FACTOR1,
                        FWD_SALE*M_FACTOR1,
                        FWD_PURCHASE*M_FACTOR1,
                        LOCATION,
                        ALLO_REPO*M_FACTOR1,
                        ALLO_BL*M_FACTOR1,
                        FWD_ALLO_REPO*M_FACTOR1,
                        FWD_ALLO_BL*M_FACTOR1,
                        SALE_DEAL_NO,SERIAL_NO_STATUS,
                        SALE_EFF_VALDATE,RET_DUE_DATE,COST_TRANS_STATUS,SCRIP_STATUS,SERIAL_NO
                FROM    DN_INV_OUTPS_DEAL_SERIAL_NO
                WHERE   DEAL_NO=M_DEAL_NO AND
                        SERIAL_NO =M_SERIAL_NO AND
                        --FACE_VAL=MM_FACE_VAL AND
                        SECURITY_CODE=M_SECURITY_CODE AND
                        SCRIP_STATUS='SL';



               SELECT  'S'||TO_CHAR(SYSDATE,'YYYY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||LPAD(TO_CHAR(DN_SEQ_SCRIPLESS.NEXTVAL),4,'0')--$$##SC
               INTO    M_SWAP_SERNO4
               FROM    DUAL;




                INSERT INTO DN_INV_OUTPS_DEAL_SERIAL_NO
                   (PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,
                    SERIAL_NO,
                    DEAL_YIELD,
                    YIELD_WITH_BROKERAGE,SCRIP_FACE_VAL,FACE_VAL,INITIAL_COST, BROKERAGE, PRICE_INT_ACCR,
                    CARR_VAL,COUP_INT_PURCH,COUP_INT_ACCR,TOT_COUP_INT,FWD_SALE,FWD_PURCHASE,LOCATION,
                    ALLO_REPO,ALLO_BL,FWD_ALLO_REPO,FWD_ALLO_BL,SALE_DEAL_NO,SERIAL_NO_STATUS,
                    SALE_EFF_VALDATE,RET_DUE_DATE,COST_TRANS_STATUS,SCRIP_STATUS,ORG_SERNO)


                SELECT  PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,
                        M_SWAP_SERNO4,DEAL_YIELD,YIELD_WITH_BROKERAGE,M_FACE_VALUE,M_FACE_VALUE,
                        INITIAL_COST*M_FACTOR2,
                        BROKERAGE*M_FACTOR2,
                        PRICE_INT_ACCR*M_FACTOR2,
                        CARR_VAL*M_FACTOR2,
                        COUP_INT_PURCH*M_FACTOR2,
                        COUP_INT_ACCR*M_FACTOR2,
                        TOT_COUP_INT*M_FACTOR2,
                        FWD_SALE*M_FACTOR2,
                        FWD_PURCHASE*M_FACTOR2,
                        LOCATION,
                        ALLO_REPO*M_FACTOR2,
                        ALLO_BL*M_FACTOR2,
                        FWD_ALLO_REPO*M_FACTOR2,
                        FWD_ALLO_BL*M_FACTOR2,
                        SALE_DEAL_NO,SERIAL_NO_STATUS,
                        SALE_EFF_VALDATE,RET_DUE_DATE,COST_TRANS_STATUS,SCRIP_STATUS,SERIAL_NO
                FROM    DN_INV_OUTPS_DEAL_SERIAL_NO
                WHERE   DEAL_NO=M_DEAL_NO AND
                        SERIAL_NO =M_SERIAL_NO AND
                        --FACE_VAL=MM_FACE_VAL AND
                        SECURITY_CODE=M_SECURITY_CODE AND
                        SCRIP_STATUS='SL';


           SELECT TO_CHAR(SYSDATE,'YYYY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_SCRIPLESS_SALE.NEXTVAL),3,'0')
           INTO   MM_SWAP_DEAL
           FROM DUAL;
           MM_SWAP_DEAL:='SS'||MM_SWAP_DEAL;


              UPDATE  DN_INV_OUTPS_DEAL_SERIAL_NO
                 SET     SALE_EFF_VALDATE=EFF_VALDATE,
                         SALE_DEAL_NO=MM_SWAP_DEAL,
                         SERIAL_NO_STATUS='SWP'
                 WHERE   DEAL_NO=M_DEAL_NO AND
                         SERIAL_NO =M_SERIAL_NO AND
                         --FACE_VAL=MM_FACE_VAL AND
                         SECURITY_CODE=M_SECURITY_CODE;




          UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
           SET ALLO_REPO=ALLO_REPO+M_ALLO_REPO,
                ALLO_BL=ALLO_BL+M_ALLO_BL,
                FWD_ALLO_REPO=FWD_ALLO_REPO+M_FWD_ALLO_REPO,
                FWD_ALLO_BL=FWD_ALLO_BL+M_FWD_ALLO_BL,
                LOCATION=M_PORTFOLIO_CODE
           WHERE
                PORTFOLIO_CODE=M_PORTFOLIO_CODE
                AND
                INST_TYPE=M_INST_TYPE
                AND
                SECURITY_CODE=M_SECURITY_CODE
                AND
                DEAL_NO=M_DEAL_NO
                AND
                SERIAL_NO=M_SERIAL_NO;


           INSERT INTO DN_INV_OUTPS_DEAL_SERNO_ALLO
                  (PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,
                   SERIAL_NO,ALLO_TYPE,START_DATE,END_DATE,ALLO_FACE_VALUE,PREV_DEAL_NO)

           VALUES (M_PORTFOLIO_CODE,SYSDATE,M_INST_TYPE,M_SECURITY_CODE,M_ALLO_DEAL_NO,
                   M_SWAP_SERNO4,M_ALLO_TYPE,M_START_DATE,M_END_DATE,M_FACE_VALUE,M_DEAL_NO);









         ELSE --$$##SC
           INSERT INTO DN_INV_OUTPS_DEAL_SERNO_ALLO
                  (PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,
                   SERIAL_NO,ALLO_TYPE,START_DATE,END_DATE,ALLO_FACE_VALUE,PREV_DEAL_NO)

           VALUES (M_PORTFOLIO_CODE,SYSDATE,M_INST_TYPE,M_SECURITY_CODE,M_ALLO_DEAL_NO,
                   M_SERIAL_NO,M_ALLO_TYPE,M_START_DATE,M_END_DATE,M_FACE_VALUE,M_DEAL_NO);

           UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
           SET ALLO_REPO=ALLO_REPO+M_ALLO_REPO,
                ALLO_BL=ALLO_BL+M_ALLO_BL,
                FWD_ALLO_REPO=FWD_ALLO_REPO+M_FWD_ALLO_REPO,
                FWD_ALLO_BL=FWD_ALLO_BL+M_FWD_ALLO_BL,
                LOCATION=M_COUNP_LOCATION
           WHERE
                PORTFOLIO_CODE=M_PORTFOLIO_CODE
                AND
                INST_TYPE=M_INST_TYPE
                AND
                SECURITY_CODE=M_SECURITY_CODE
                AND
                DEAL_NO=M_DEAL_NO
                AND
                SERIAL_NO=M_SERIAL_NO;



             SELECT LOCATION INTO M_LOCATION  ---REDUNDANT SELECTION ??? SM 25/05/2000
           FROM DN_INV_OUTPS_DEAL_SERIAL_NO
           WHERE
                PORTFOLIO_CODE=M_PORTFOLIO_CODE
                AND
                INST_TYPE=M_INST_TYPE
                AND
                SECURITY_CODE=M_SECURITY_CODE
                AND
                DEAL_NO=M_DEAL_NO
                AND
                SERIAL_NO=M_SERIAL_NO;

         END IF;--$$##SC








              ELSIF M_INV_CODE='RP' THEN

                   IF ((M_PART_ALLO_STATUS='1')AND (SUBSTR(M_SERIAL_NO,1,1)='S')) THEN--$$##SC added by nilu on 19.05.04


                         SELECT  'S'||TO_CHAR(SYSDATE,'YYYY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||LPAD(TO_CHAR(DN_SEQ_SCRIPLESS.NEXTVAL),4,'0')--$$##SC
               INTO    M_SWAP_SERNO3
               FROM    DUAL;



SELECT   (SCRIP_FACE_VAL-M_FACE_VALUE)/SCRIP_FACE_VAL , M_FACE_VALUE/SCRIP_FACE_VAL
INTO     M_FACTOR1,M_FACTOR2
FROM     DN_INV_REPO_DEAL_SERIAL_NO
 WHERE   DEAL_NO=M_DEAL_NO AND
         SERIAL_NO =M_SERIAL_NO AND
         --FACE_VAL=MM_FACE_VAL AND
         SECURITY_CODE=M_SECURITY_CODE AND
         SCRIPT_STATUS='SL';




                INSERT INTO  DN_INV_REPO_DEAL_SERIAL_NO
                  (PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,SERIAL_NO,SCRIP_FACE_VAL,
                   FACE_VAL,FWD_RECEIPT,LOCATION,ALLO_REPO,ALLO_BL,FWD_ALLO_REPO,FWD_ALLO_BL,RET_DUE_DATE,
                   SCRIPT_STATUS,SWAP_STATUS,ORG_SERNO)

                SELECT
                   PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,M_SWAP_SERNO3,SCRIP_FACE_VAL-M_FACE_VALUE,
                   FACE_VAL-M_FACE_VALUE,FWD_RECEIPT*M_FACTOR1,LOCATION,ALLO_REPO*M_FACTOR1,
                   ALLO_BL*M_FACTOR1,FWD_ALLO_REPO*M_FACTOR1,FWD_ALLO_BL*M_FACTOR1,RET_DUE_DATE,
                   SCRIPT_STATUS,SWAP_STATUS,SERIAL_NO
                FROM  DN_INV_REPO_DEAL_SERIAL_NO
                WHERE  DEAL_NO=M_DEAL_NO AND
                      SERIAL_NO =M_SERIAL_NO AND
                      --FACE_VAL=MM_FACE_VAL AND
                      SECURITY_CODE=M_SECURITY_CODE AND
                      SCRIPT_STATUS='SL';



               SELECT  'S'||TO_CHAR(SYSDATE,'YYYY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||LPAD(TO_CHAR(DN_SEQ_SCRIPLESS.NEXTVAL),4,'0')--$$##SC
               INTO    M_SWAP_SERNO4
               FROM    DUAL;



                 INSERT INTO  DN_INV_REPO_DEAL_SERIAL_NO
                  (PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,SERIAL_NO,SCRIP_FACE_VAL,
                   FACE_VAL,FWD_RECEIPT,LOCATION,ALLO_REPO,ALLO_BL,FWD_ALLO_REPO,FWD_ALLO_BL,RET_DUE_DATE,
                   SCRIPT_STATUS,SWAP_STATUS,ORG_SERNO)

                SELECT
                   PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,M_SWAP_SERNO4,M_FACE_VALUE,
                   M_FACE_VALUE,FWD_RECEIPT*M_FACTOR2,LOCATION,ALLO_REPO*M_FACTOR2,
                   ALLO_BL*M_FACTOR2,FWD_ALLO_REPO*M_FACTOR2,FWD_ALLO_BL*M_FACTOR2,RET_DUE_DATE,
                   SCRIPT_STATUS,SWAP_STATUS,SERIAL_NO
                FROM  DN_INV_REPO_DEAL_SERIAL_NO
                WHERE  DEAL_NO=M_DEAL_NO AND
                      SERIAL_NO =M_SERIAL_NO AND
                      --FACE_VAL=MM_FACE_VAL AND
                      SECURITY_CODE=M_SECURITY_CODE AND
                      SCRIPT_STATUS='SL'  ;



             UPDATE   DN_INV_REPO_DEAL_SERIAL_NO
             SET      SWAP_STATUS='Y',
                      RET_DUE_DATE=EFF_VALDATE,
                      ORG_SERNO='SWP'
             WHERE    DEAL_NO=M_DEAL_NO AND
                      SERIAL_NO =M_SERIAL_NO AND
                      --FACE_VAL=MM_FACE_VAL AND
                      SECURITY_CODE=M_SECURITY_CODE AND
                      SCRIPT_STATUS='SL';


         UPDATE DN_INV_REPO_DEAL_SERIAL_NO
           SET  ALLO_REPO=ALLO_REPO+M_ALLO_REPO,
                ALLO_BL=ALLO_BL+M_ALLO_BL,
                FWD_ALLO_REPO=FWD_ALLO_REPO+M_FWD_ALLO_REPO,
                FWD_ALLO_BL=FWD_ALLO_BL+M_FWD_ALLO_BL,
                LOCATION=M_PORTFOLIO_CODE
           WHERE
                PORTFOLIO_CODE=M_PORTFOLIO_CODE
                AND
                INST_TYPE=M_INST_TYPE
                AND
                SECURITY_CODE=M_SECURITY_CODE
                AND
                DEAL_NO=M_DEAL_NO
                AND
                SERIAL_NO=M_SWAP_SERNO4
                AND
                SCRIPT_STATUS='SL';


           INSERT INTO DN_INV_REPO_DEAL_SERNO_ALLO
                  (PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,
                   SERIAL_NO,ALLO_TYPE,START_DATE,END_DATE,ALLO_FACE_VALUE,PREV_DEAL_NO)

           VALUES (M_PORTFOLIO_CODE,SYSDATE,M_INST_TYPE,M_SECURITY_CODE,M_ALLO_DEAL_NO,
                   M_SWAP_SERNO4,M_ALLO_TYPE,M_START_DATE,M_END_DATE,M_FACE_VALUE,M_DEAL_NO);


          IF SUBSTR(M_DEAL_NO,1,2)='RF' THEN


                INSERT INTO DN_TRN_REPO_FRESH_SERIAL_NO
                    (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,
                     FACE_VALUE,LOCATION,PREV_DEAL_NO,INV_STATUS
                    )
                SELECT M_DEAL_NO,M_INST_TYPE,INV_CODE,--ADDED BY KEITH ON 06-12-2004 FOR VC-REF 04-267 FOR INVENTORY ALLOCATION (PART)
                     M_SECURITY_CODE,M_SWAP_SERNO4,
                     M_FACE_VALUE,
                     M_PORTFOLIO_CODE,PREV_DEAL_NO,INV_STATUS
                FROM   DN_TRN_REPO_FRESH_SERIAL_NO
                WHERE  DEAL_NO=M_DEAL_NO AND SERIAL_NO=M_SERIAL_NO;


                INSERT INTO DN_TRN_REPO_FRESH_SERIAL_NO
                    (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,
                     FACE_VALUE,LOCATION,PREV_DEAL_NO,INV_STATUS

                    )
               SELECT M_DEAL_NO,M_INST_TYPE,INV_CODE,--ADDED BY KEITH ON 06-12-2004 FOR VC-REF 04-267 FOR INVENTORY ALLOCATION (PART)
                     M_SECURITY_CODE,M_SWAP_SERNO3,FACE_VALUE-M_FACE_VALUE,
                     M_PORTFOLIO_CODE,PREV_DEAL_NO,INV_STATUS
                FROM   DN_TRN_REPO_FRESH_SERIAL_NO
                WHERE  DEAL_NO=M_DEAL_NO AND SERIAL_NO=M_SERIAL_NO;



        DELETE FROM DN_TRN_REPO_FRESH_SERIAL_NO
        WHERE  DEAL_NO=M_DEAL_NO AND SERIAL_NO=M_SERIAL_NO;

    ELSE--RR

                 INSERT INTO DN_TRN_REPO_ROLLOVER_SERIAL_NO
                    (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,
                     FACE_VALUE,LOCATION,PREV_DEAL_NO,INV_STATUS
                    )
                 SELECT M_DEAL_NO,M_INST_TYPE,INV_CODE,--ADDED BY KEITH ON 06-12-2004 FOR VC-REF 04-267 FOR INVENTORY ALLOCATION (PART)
                     M_SECURITY_CODE,M_SWAP_SERNO4,
                     M_FACE_VALUE,
                     M_PORTFOLIO_CODE,PREV_DEAL_NO,INV_STATUS
                 FROM   DN_TRN_REPO_ROLLOVER_SERIAL_NO
                 WHERE  DEAL_NO=M_DEAL_NO AND SERIAL_NO=M_SERIAL_NO;


                INSERT INTO DN_TRN_REPO_ROLLOVER_SERIAL_NO
                    (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,
                     FACE_VALUE,LOCATION,PREV_DEAL_NO,INV_STATUS

                    )
               SELECT M_DEAL_NO,M_INST_TYPE,INV_CODE,--ADDED BY KEITH ON 06-12-2004 FOR VC-REF 04-267 FOR INVENTORY ALLOCATION (PART)
                     M_SECURITY_CODE,M_SWAP_SERNO3,FACE_VALUE-M_FACE_VALUE,
                     M_PORTFOLIO_CODE,PREV_DEAL_NO,INV_STATUS
                FROM   DN_TRN_REPO_ROLLOVER_SERIAL_NO
                WHERE  DEAL_NO=M_DEAL_NO AND SERIAL_NO=M_SERIAL_NO;



        DELETE FROM DN_TRN_REPO_ROLLOVER_SERIAL_NO
        WHERE  DEAL_NO=M_DEAL_NO AND SERIAL_NO=M_SERIAL_NO;


   END IF;--RR

               ELSE--$$##SC


              INSERT INTO DN_INV_REPO_DEAL_SERNO_ALLO
                  (PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,
                   SERIAL_NO,ALLO_TYPE,START_DATE,END_DATE,ALLO_FACE_VALUE,PREV_DEAL_NO)

           VALUES (M_PORTFOLIO_CODE,SYSDATE,M_INST_TYPE,M_SECURITY_CODE,M_ALLO_DEAL_NO,
                   M_SERIAL_NO,M_ALLO_TYPE,M_START_DATE,M_END_DATE,M_FACE_VALUE,M_DEAL_NO);
--RAISE_APPLICATION_ERROR(-20201,'*@@@@@* '||M_PORTFOLIO_CODE||'| '||SYSDATE||'| '||M_INST_TYPE||'| '||M_SECURITY_CODE||'| '||M_ALLO_DEAL_NO||'| '||M_SERIAL_NO||'| '||M_ALLO_TYPE||'| '||M_START_DATE||'| '||M_END_DATE||'| '||M_FACE_VALUE||'| '||M_DEAL_NO);

           UPDATE DN_INV_REPO_DEAL_SERIAL_NO
           SET  ALLO_REPO=ALLO_REPO+M_ALLO_REPO,
                ALLO_BL=ALLO_BL+M_ALLO_BL,
                FWD_ALLO_REPO=FWD_ALLO_REPO+M_FWD_ALLO_REPO,
                FWD_ALLO_BL=FWD_ALLO_BL+M_FWD_ALLO_BL,
                LOCATION=M_COUNP_LOCATION
           WHERE
                PORTFOLIO_CODE=M_PORTFOLIO_CODE
                AND
                INST_TYPE=M_INST_TYPE
                AND
                SECURITY_CODE=M_SECURITY_CODE
                AND
                DEAL_NO=M_DEAL_NO
                AND
                SERIAL_NO=M_SERIAL_NO;

           SELECT LOCATION INTO M_LOCATION
           FROM DN_INV_REPO_DEAL_SERIAL_NO
           WHERE
                PORTFOLIO_CODE=M_PORTFOLIO_CODE
                AND
                INST_TYPE=M_INST_TYPE
                AND
                SECURITY_CODE=M_SECURITY_CODE
                AND
                DEAL_NO=M_DEAL_NO
                AND
                SERIAL_NO=M_SERIAL_NO;
      END IF;--$$##SC
      ELSIF M_INV_CODE='BL' THEN

           INSERT INTO DN_INV_BL_DEAL_SERNO_ALLO
                  (PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,
                   SERIAL_NO,ALLO_TYPE,START_DATE,END_DATE,ALLO_FACE_VALUE,PREV_DEAL_NO)

           VALUES (M_PORTFOLIO_CODE,SYSDATE,M_INST_TYPE,M_SECURITY_CODE,M_ALLO_DEAL_NO,
                   M_SERIAL_NO,M_ALLO_TYPE,M_START_DATE,M_END_DATE,M_FACE_VALUE,M_DEAL_NO);


           UPDATE DN_INV_BL_DEAL_SERIAL_NO
           SET  ALLO_REPO=ALLO_REPO+M_ALLO_REPO,
                ALLO_BL=ALLO_BL+M_ALLO_BL,
                FWD_ALLO_REPO=FWD_ALLO_REPO+M_FWD_ALLO_REPO,
                FWD_ALLO_BL=FWD_ALLO_BL+M_FWD_ALLO_BL,
                LOCATION=M_COUNP_LOCATION
           WHERE
                PORTFOLIO_CODE=M_PORTFOLIO_CODE
                AND
                INST_TYPE=M_INST_TYPE
                AND
                SECURITY_CODE=M_SECURITY_CODE
                AND
                DEAL_NO=M_DEAL_NO
                AND
                SERIAL_NO=M_SERIAL_NO;

          SELECT LOCATION INTO M_LOCATION
          FROM DN_INV_BL_DEAL_SERIAL_NO
          WHERE
                PORTFOLIO_CODE=M_PORTFOLIO_CODE
                AND
                INST_TYPE=M_INST_TYPE
                AND
                SECURITY_CODE=M_SECURITY_CODE
                AND
                DEAL_NO=M_DEAL_NO
                AND
                SERIAL_NO=M_SERIAL_NO;

      END IF;


--UPDATING TRANSACTION TABLES FOR ISSUES--

----
      IF SUBSTR(M_ALLO_DEAL_NO,1,2)='RF' THEN

               SELECT COUNT(*) INTO M_COUNT
               FROM DN_TRN_REPO_FRESH_INST
               WHERE
                   DEAL_NO=M_ALLO_DEAL_NO
                   AND
                   INST_TYPE=M_INST_TYPE
                   AND
                   INV_CODE=M_INV_CODE;

              IF M_COUNT=0 THEN

                  INSERT INTO DN_TRN_REPO_FRESH_INST
                      (DEAL_NO,INST_TYPE,INV_CODE,RPTRN_HCUT_PER)
                  VALUES
                      (M_ALLO_DEAL_NO,M_INST_TYPE,M_INV_CODE,'10'); --HAIR CUT HARD CODED !!!

              END IF;

               SELECT COUNT(*) INTO M_COUNT
               FROM DN_TRN_REPO_FRESH_SEC
               WHERE
                   DEAL_NO=M_ALLO_DEAL_NO
                   AND
                   SECURITY_CODE=M_SECURITY_CODE
                   AND
                   INV_CODE=M_INV_CODE;

              IF M_COUNT=0 THEN

                  INSERT INTO DN_TRN_REPO_FRESH_SEC
                      (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,ENDOSER_CODE,FACE_VALUE,
                       FVAL_WITH_HAIR_CUT,INV_STATUS)
                  VALUES
                      (M_ALLO_DEAL_NO,M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,NULL,M_FACE_VALUE,
                       0,'Y');
              ELSE
                   UPDATE DN_TRN_REPO_FRESH_SEC
                   SET FACE_VALUE=FACE_VALUE+M_FACE_VALUE
                   WHERE
                   DEAL_NO=M_ALLO_DEAL_NO
                   AND
                   SECURITY_CODE=M_SECURITY_CODE
                   AND
                   INV_CODE=M_INV_CODE;

              END IF;

--************ start of modification added by nilu on 19.05.04 *******************
IF ((M_PART_ALLO_STATUS='1')AND (SUBSTR(M_SERIAL_NO,1,1)='S')) THEN--$$##SC

                  INSERT INTO DN_TRN_REPO_FRESH_SERIAL_NO
                      (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,
                       FACE_VALUE,INV_STATUS,DATA_FROM,LOCATION,PREV_DEAL_NO)
                  VALUES
                      (M_ALLO_DEAL_NO,M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,
                       DECODE(M_PART_ALLO_STATUS,'1',M_SWAP_SERNO4,M_SERIAL_NO),
                       M_FACE_VALUE,'Y1','BOR',M_COUNP_LOCATION,M_DEAL_NO);
      ELSE

 INSERT INTO DN_TRN_REPO_FRESH_SERIAL_NO
                      (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,
                       FACE_VALUE,INV_STATUS,DATA_FROM,LOCATION,PREV_DEAL_NO)
                  VALUES
                      (M_ALLO_DEAL_NO,M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,
                       M_SERIAL_NO,
                       M_FACE_VALUE,'Y1','BOR',M_COUNP_LOCATION,M_DEAL_NO);

END IF;
--****************** end of modification  ***************************

ELSIF SUBSTR(M_ALLO_DEAL_NO,1,2)='PI' THEN

               SELECT COUNT(*) INTO M_COUNT
               FROM DN_TRN_REPO_PERIOD_INT_INST
               WHERE
                   DEAL_NO=M_ALLO_DEAL_NO
                   AND
                   INST_TYPE=M_INST_TYPE
                   AND
                   INV_CODE=M_INV_CODE;

              IF M_COUNT=0 THEN

                  INSERT INTO DN_TRN_REPO_PERIOD_INT_INST
                      (DEAL_NO,INST_TYPE,INV_CODE,RPTRN_HCUT_PER)
                  VALUES
                      (M_ALLO_DEAL_NO,M_INST_TYPE,M_INV_CODE,'10'); --HAIR CUT HARD CODED !!!

              END IF;

               SELECT COUNT(*) INTO M_COUNT
               FROM DN_TRN_REPO_PERIOD_INT_SEC
               WHERE
                   DEAL_NO=M_ALLO_DEAL_NO
                   AND
                   SECURITY_CODE=M_SECURITY_CODE
                   AND
                   INV_CODE=M_INV_CODE;

              IF M_COUNT=0 THEN

                  INSERT INTO DN_TRN_REPO_PERIOD_INT_SEC
                      (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,ENDOSER_CODE,FACE_VALUE,
                       FVAL_WITH_HAIR_CUT,INV_STATUS)
                  VALUES
                      (M_ALLO_DEAL_NO,M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,NULL,M_FACE_VALUE,
                       0,'Y');
              ELSE
                   UPDATE DN_TRN_REPO_PERIOD_INT_SEC
                   SET FACE_VALUE=FACE_VALUE+M_FACE_VALUE
                   WHERE
                   DEAL_NO=M_ALLO_DEAL_NO
                   AND
                   SECURITY_CODE=M_SECURITY_CODE
                   AND
                   INV_CODE=M_INV_CODE;

              END IF;

--************ start of modification added by nilu on 19.05.04 *******************
IF ((M_PART_ALLO_STATUS='1')AND (SUBSTR(M_SERIAL_NO,1,1)='S')) THEN--$$##SC

                  INSERT INTO DN_TRN_REPO_PERIOD_INT_SERIAL
                      (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,
                       FACE_VALUE,INV_STATUS,DATA_FROM,LOCATION,PREV_DEAL_NO)
                  VALUES
                      (M_ALLO_DEAL_NO,M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,
                       DECODE(M_PART_ALLO_STATUS,'1',M_SWAP_SERNO4,M_SERIAL_NO),
                       M_FACE_VALUE,'Y1','BOR',M_COUNP_LOCATION,M_DEAL_NO);
      ELSE

 INSERT INTO DN_TRN_REPO_PERIOD_INT_SERIAL
                      (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,
                       FACE_VALUE,INV_STATUS,DATA_FROM,LOCATION,PREV_DEAL_NO)
                  VALUES
                      (M_ALLO_DEAL_NO,M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,
                       M_SERIAL_NO,
                       M_FACE_VALUE,'Y1','BOR',M_COUNP_LOCATION,M_DEAL_NO);

END IF;
--****************** end of modification  ***************************


          ELSIF SUBSTR(M_ALLO_DEAL_NO,1,2)='RR' THEN

               SELECT COUNT(*) INTO M_COUNT
               FROM DN_TRN_REPO_ROLLOVER_INST
               WHERE
                   DEAL_NO=M_ALLO_DEAL_NO
                   AND
                   INST_TYPE=M_INST_TYPE
                   AND
                   INV_CODE=M_INV_CODE;

              IF M_COUNT=0 THEN

                  INSERT INTO DN_TRN_REPO_ROLLOVER_INST
                      (DEAL_NO,INST_TYPE,INV_CODE,RPTRN_HCUT_PER)
                  VALUES
                      (M_ALLO_DEAL_NO,M_INST_TYPE,M_INV_CODE,'10');   --HAIR CUT HARD CODED !!!

              END IF;

               SELECT COUNT(*) INTO M_COUNT
               FROM DN_TRN_REPO_ROLLOVER_SEC
               WHERE
                   DEAL_NO=M_ALLO_DEAL_NO
                   AND
                   SECURITY_CODE=M_SECURITY_CODE
                   AND
                   INV_CODE=M_INV_CODE;

              IF M_COUNT=0 THEN

                  INSERT INTO DN_TRN_REPO_ROLLOVER_SEC
                      (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,ENDOSER_CODE,
                       FACE_VALUE,FVAL_WITH_HAIR_CUT,INV_STATUS)
                  VALUES
                      (M_ALLO_DEAL_NO,M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,NULL,
                       M_FACE_VALUE,0,'Y');
              ELSE
                   UPDATE DN_TRN_REPO_ROLLOVER_SEC
                   SET FACE_VALUE=FACE_VALUE+M_FACE_VALUE
                   WHERE
                   DEAL_NO=M_ALLO_DEAL_NO
                   AND
                   SECURITY_CODE=M_SECURITY_CODE
                   AND
                   INV_CODE=M_INV_CODE;

              END IF;

-- ************ start of modification added by nilu on 19.05.04 ****************
IF ((M_PART_ALLO_STATUS='1')AND (SUBSTR(M_SERIAL_NO,1,1)='S')) THEN--$$##SC

                  INSERT INTO DN_TRN_REPO_ROLLOVER_SERIAL_NO
                      (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,
                       FACE_VALUE,INV_STATUS,DATA_FROM,LOCATION,PREV_DEAL_NO)
                  VALUES
                      (M_ALLO_DEAL_NO,M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,
                       DECODE(M_PART_ALLO_STATUS,'1',M_SWAP_SERNO4,M_SERIAL_NO),
                       M_FACE_VALUE,'Y1','BOR',M_COUNP_LOCATION,M_DEAL_NO);

                       ELSE
                  INSERT INTO DN_TRN_REPO_ROLLOVER_SERIAL_NO
                      (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,
                       FACE_VALUE,INV_STATUS,DATA_FROM,LOCATION,PREV_DEAL_NO)
                  VALUES
                      (M_ALLO_DEAL_NO,M_INST_TYPE,M_INV_CODE,M_SECURITY_CODE,
                       M_SERIAL_NO,
                       M_FACE_VALUE,'Y1','BOR',M_COUNP_LOCATION,M_DEAL_NO);
END IF;

-- ********************* end of modification ***************************
--RAISE_APPLICATION_ERROR(-20201,'EEEEEEE'||M_INV_EXCHG_NO||'| '||M_COUNP_LOCATION||' '||M_INV_CODE||' '||M_ALLO_DEAL_NO);

            END IF;

   END LOOP;
/*EXCEPTION
  WHEN OTHERS THEN
--RAISE_APPLICATION_ERROR(-20201,'*** '||M_inv_exchg_no||'| '||M_allo_deal_no||'| '||M_portfolio_code);
               RAISE_APPLICATION_ERROR(-20201,'*** '||M_PORTFOLIO_CODE||'| '||SYSDATE||'| '||M_INST_TYPE||'| '||M_SECURITY_CODE||'| '||M_ALLO_DEAL_NO||'| '||M_SERIAL_NO||'| '||M_ALLO_TYPE||'| '||M_START_DATE||'| '||M_END_DATE||'| '||M_FACE_VALUE||'| '||M_DEAL_NO);

*/

   CLOSE EXCH_ISSUES;


   OPEN EXCH_RECEIPTS;

   LOOP

      FETCH  EXCH_RECEIPTS INTO

          M_PORTFOLIO_CODE,
          M_INST_TYPE,
          M_SECURITY_CODE,
          M_ALLO_DEAL_NO,
          M_SERIAL_NO,
          M_FACE_VALUE,
          M_DEAL_NO,
          M_INV_CODE,
          M_PART_ALLO_STATUS;----VC UNALLO


      EXIT WHEN EXCH_RECEIPTS%NOTFOUND;

      M_ALLO_REPO:=0;
      M_ALLO_BL:=0;
      M_FWD_ALLO_REPO:=0;
      M_FWD_ALLO_BL:=0;


      IF SUBSTR(M_ALLO_DEAL_NO,1,2)='RF' THEN------------
          M_ALLO_TYPE:='RP';

          SELECT EFF_VALDATE,MATURITY_DATE
          INTO M_START_DATE,M_END_DATE
          FROM DN_TRN_REPO_FRESH
          WHERE DEAL_NO=M_ALLO_DEAL_NO;

          IF M_END_DATE>=SYSDATE THEN
             M_END_DATE:=SYSDATE;

          END IF;

          IF  M_START_DATE<=SYSDATE THEN
              M_ALLO_REPO:=M_FACE_VALUE;

          ELSE
              M_FWD_ALLO_REPO:=M_FACE_VALUE;

          END IF;



       ELSIF SUBSTR(M_ALLO_DEAL_NO,1,2)='RR' THEN-------------------
          M_ALLO_TYPE:='RP';

          SELECT EFF_VALDATE,MATURITY_DATE
          INTO M_START_DATE,M_END_DATE
          FROM DN_TRN_REPO_ROLLOVER
          WHERE DEAL_NO=M_ALLO_DEAL_NO;

          IF M_END_DATE>=SYSDATE THEN
             M_END_DATE:=SYSDATE;

          END IF;

          IF  M_START_DATE<=SYSDATE THEN
              M_ALLO_REPO:=M_FACE_VALUE;

          ELSE
              M_FWD_ALLO_REPO:=M_FACE_VALUE;

          END IF;

      END IF;----------------------------------------------

      IF M_INV_CODE='OR' THEN--=======================================
      ----------------------------VC UNALLONEW----------------------------------------------------------
   IF ((M_PART_ALLO_STATUS='1')AND (SUBSTR(M_SERIAL_NO,1,1)='S')) THEN



SELECT   (SCRIP_FACE_VAL-M_FACE_VALUE)/SCRIP_FACE_VAL , (M_FACE_VALUE)/SCRIP_FACE_VAL
INTO     M_FACTOR1,M_FACTOR2
FROM     DN_INV_OUTPS_DEAL_SERIAL_NO
WHERE    DEAL_NO=M_DEAL_NO AND
         SERIAL_NO =M_SERIAL_NO AND
         SECURITY_CODE=M_SECURITY_CODE AND
         SCRIP_STATUS='SL';

   SELECT  'S'||TO_CHAR(SYSDATE,'YYYY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||LPAD(TO_CHAR(DN_SEQ_SCRIPLESS.NEXTVAL),4,'0')--$$##SC
               INTO    M_SWAP_SERNO3
               FROM    DUAL;

                INSERT INTO DN_INV_OUTPS_DEAL_SERIAL_NO
                   (PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,
                    SERIAL_NO,
                    DEAL_YIELD,
                    YIELD_WITH_BROKERAGE,SCRIP_FACE_VAL,FACE_VAL,INITIAL_COST, BROKERAGE, PRICE_INT_ACCR,
                    CARR_VAL,COUP_INT_PURCH,COUP_INT_ACCR,TOT_COUP_INT,FWD_SALE,FWD_PURCHASE,LOCATION,
                    ALLO_REPO,ALLO_BL,FWD_ALLO_REPO,FWD_ALLO_BL,SALE_DEAL_NO,SERIAL_NO_STATUS,
                    SALE_EFF_VALDATE,RET_DUE_DATE,COST_TRANS_STATUS,SCRIP_STATUS,ORG_SERNO)


                SELECT  PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,
                        M_SWAP_SERNO3,DEAL_YIELD,YIELD_WITH_BROKERAGE,SCRIP_FACE_VAL-M_FACE_VALUE,FACE_VAL-M_FACE_VALUE,
                        INITIAL_COST*M_FACTOR1,
                        BROKERAGE*M_FACTOR1,
                        PRICE_INT_ACCR*M_FACTOR1,
                        CARR_VAL*M_FACTOR1,
                        COUP_INT_PURCH*M_FACTOR1,
                        COUP_INT_ACCR*M_FACTOR1,
                        TOT_COUP_INT*M_FACTOR1,
                        FWD_SALE*M_FACTOR1,
                        FWD_PURCHASE*M_FACTOR1,
                        LOCATION,
                        ALLO_REPO*M_FACTOR1,
                        ALLO_BL*M_FACTOR1,
                        FWD_ALLO_REPO*M_FACTOR1,
                        FWD_ALLO_BL*M_FACTOR1,
                        SALE_DEAL_NO,SERIAL_NO_STATUS,
                        SALE_EFF_VALDATE,RET_DUE_DATE,COST_TRANS_STATUS,SCRIP_STATUS,SERIAL_NO
                FROM    DN_INV_OUTPS_DEAL_SERIAL_NO
                WHERE   DEAL_NO=M_DEAL_NO AND
                        SERIAL_NO =M_SERIAL_NO AND
                        SECURITY_CODE=M_SECURITY_CODE AND
                        SCRIP_STATUS='SL';



               SELECT  'S'||TO_CHAR(SYSDATE,'YYYY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||LPAD(TO_CHAR(DN_SEQ_SCRIPLESS.NEXTVAL),4,'0')--$$##SC
               INTO    M_SWAP_SERNO4
               FROM    DUAL;




                INSERT INTO DN_INV_OUTPS_DEAL_SERIAL_NO
                   (PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,
                    SERIAL_NO,
                    DEAL_YIELD,
                    YIELD_WITH_BROKERAGE,SCRIP_FACE_VAL,FACE_VAL,INITIAL_COST, BROKERAGE, PRICE_INT_ACCR,
                    CARR_VAL,COUP_INT_PURCH,COUP_INT_ACCR,TOT_COUP_INT,FWD_SALE,FWD_PURCHASE,LOCATION,
                    ALLO_REPO,ALLO_BL,FWD_ALLO_REPO,FWD_ALLO_BL,SALE_DEAL_NO,SERIAL_NO_STATUS,
                    SALE_EFF_VALDATE,RET_DUE_DATE,COST_TRANS_STATUS,SCRIP_STATUS,ORG_SERNO)


                SELECT  PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,
                        M_SWAP_SERNO4,DEAL_YIELD,YIELD_WITH_BROKERAGE,M_FACE_VALUE,M_FACE_VALUE,
                        INITIAL_COST*M_FACTOR2,
                        BROKERAGE*M_FACTOR2,
                        PRICE_INT_ACCR*M_FACTOR2,
                        CARR_VAL*M_FACTOR2,
                        COUP_INT_PURCH*M_FACTOR2,
                        COUP_INT_ACCR*M_FACTOR2,
                        TOT_COUP_INT*M_FACTOR2,
                        FWD_SALE*M_FACTOR2,
                        FWD_PURCHASE*M_FACTOR2,
                        LOCATION,
                        ALLO_REPO*M_FACTOR2,
                        ALLO_BL*M_FACTOR2,
                        FWD_ALLO_REPO*M_FACTOR2,
                        FWD_ALLO_BL*M_FACTOR2,
                        SALE_DEAL_NO,SERIAL_NO_STATUS,
                        SALE_EFF_VALDATE,RET_DUE_DATE,COST_TRANS_STATUS,SCRIP_STATUS,SERIAL_NO
                FROM    DN_INV_OUTPS_DEAL_SERIAL_NO
                WHERE   DEAL_NO=M_DEAL_NO AND
                        SERIAL_NO =M_SERIAL_NO AND
                        SECURITY_CODE=M_SECURITY_CODE AND
                        SCRIP_STATUS='SL';


           SELECT TO_CHAR(SYSDATE,'YYYY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_SCRIPLESS_SALE.NEXTVAL),3,'0')
           INTO   MM_SWAP_DEAL
           FROM DUAL;
           MM_SWAP_DEAL:='SS'||MM_SWAP_DEAL;


              UPDATE  DN_INV_OUTPS_DEAL_SERIAL_NO
                 SET     SALE_EFF_VALDATE=EFF_VALDATE,
                         SALE_DEAL_NO=MM_SWAP_DEAL,
                         SERIAL_NO_STATUS='SWP'
                 WHERE   DEAL_NO=M_DEAL_NO AND
                         SERIAL_NO =M_SERIAL_NO AND
                         SECURITY_CODE=M_SECURITY_CODE;



                 INSERT INTO DN_INV_OUTPS_DEAL_SERNO_ALLO
                  (PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,
                   SERIAL_NO,ALLO_TYPE,START_DATE,END_DATE,ALLO_FACE_VALUE,PREV_DEAL_NO)

           SELECT PORTFOLIO_CODE,SYSDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,
                   M_SWAP_SERNO3,ALLO_TYPE,SYSDATE,END_DATE,(ALLO_FACE_VALUE-M_FACE_VALUE),PREV_DEAL_NO
        FROM    DN_INV_OUTPS_DEAL_SERNO_ALLO
        WHERE
               PORTFOLIO_CODE=M_PORTFOLIO_CODE
               AND
               INST_TYPE=M_INST_TYPE
               AND
               SECURITY_CODE=M_SECURITY_CODE
               AND
               DEAL_NO=M_ALLO_DEAL_NO
               AND
               SERIAL_NO=M_SERIAL_NO;

     UPDATE DN_INV_OUTPS_DEAL_SERNO_ALLO
           SET END_DATE=SYSDATE
           WHERE
               PORTFOLIO_CODE=M_PORTFOLIO_CODE
               AND
               INST_TYPE=M_INST_TYPE
               AND
               SECURITY_CODE=M_SECURITY_CODE
               AND
               DEAL_NO=M_ALLO_DEAL_NO
               AND
               SERIAL_NO=M_SERIAL_NO;

IF SUBSTR(M_ALLO_DEAL_NO,1,2)='RF' THEN

INSERT INTO DN_TRN_REPO_FRESH_SERIAL_NO
                    (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,
                     FACE_VALUE,LOCATION,PREV_DEAL_NO

                    )
                SELECT DEAL_NO,INST_TYPE,INV_CODE,
                     SECURITY_CODE,M_SWAP_SERNO3,FACE_VALUE-M_FACE_VALUE,
                     M_PORTFOLIO_CODE,PREV_DEAL_NO
                FROM   DN_TRN_REPO_FRESH_SERIAL_NO
                WHERE  DEAL_NO=M_ALLO_DEAL_NO AND SERIAL_NO=M_SERIAL_NO;




 DELETE FROM DN_TRN_REPO_FRESH_SERIAL_NO
        WHERE  DEAL_NO=M_ALLO_DEAL_NO AND SERIAL_NO=M_SERIAL_NO;

ELSIF SUBSTR(M_ALLO_DEAL_NO,1,2)='RR' THEN

INSERT INTO DN_TRN_REPO_ROLLOVER_SERIAL_NO
                    (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,
                     FACE_VALUE,LOCATION,PREV_DEAL_NO
                    )
               SELECT DEAL_NO,INST_TYPE,INV_CODE,
                     SECURITY_CODE,M_SWAP_SERNO3,FACE_VALUE-M_FACE_VALUE,
                     M_PORTFOLIO_CODE,PREV_DEAL_NO
                FROM   DN_TRN_REPO_ROLLOVER_SERIAL_NO
                WHERE  DEAL_NO=M_ALLO_DEAL_NO AND SERIAL_NO=M_SERIAL_NO;




        DELETE FROM DN_TRN_REPO_ROLLOVER_SERIAL_NO
        WHERE  DEAL_NO=M_ALLO_DEAL_NO AND SERIAL_NO=M_SERIAL_NO;


END IF;





       ELSE----VC UNALLONEW

------------------------------------------------------------------------------------------------------------------------------
           UPDATE DN_INV_OUTPS_DEAL_SERNO_ALLO
           SET END_DATE=M_END_DATE
           WHERE
               PORTFOLIO_CODE=M_PORTFOLIO_CODE
               AND
               INST_TYPE=M_INST_TYPE
               AND
               SECURITY_CODE=M_SECURITY_CODE
               AND
               DEAL_NO=M_ALLO_DEAL_NO----VC UNALLO

               AND
               SERIAL_NO=M_SERIAL_NO;

           UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
           SET ALLO_REPO=ALLO_REPO-M_ALLO_REPO,
                ALLO_BL=ALLO_BL-M_ALLO_BL,
                FWD_ALLO_REPO=FWD_ALLO_REPO-M_FWD_ALLO_REPO,
                FWD_ALLO_BL=FWD_ALLO_BL-M_FWD_ALLO_BL,
                LOCATION=M_PORTFOLIO_CODE
           WHERE
                PORTFOLIO_CODE=M_PORTFOLIO_CODE
                AND
                INST_TYPE=M_INST_TYPE
                AND
                SECURITY_CODE=M_SECURITY_CODE
                --AND
                --DEAL_NO=M_DEAL_NO
                AND
                SERIAL_NO=M_SERIAL_NO;

        END IF; ----VC UNALLO


      ELSIF M_INV_CODE='RP' THEN--=======================================

---------------------------------------VC UNALLONEW---------------------------------------------------
     IF ((M_PART_ALLO_STATUS='1')AND (SUBSTR(M_SERIAL_NO,1,1)='S')) THEN


               SELECT  'S'||TO_CHAR(SYSDATE,'YYYY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||LPAD(TO_CHAR(DN_SEQ_SCRIPLESS.NEXTVAL),4,'0')--$$##SC
               INTO    M_SWAP_SERNO3
               FROM    DUAL;



SELECT   (SCRIP_FACE_VAL-M_FACE_VALUE)/SCRIP_FACE_VAL , M_FACE_VALUE/SCRIP_FACE_VAL
INTO     M_FACTOR1,M_FACTOR2
FROM     DN_INV_REPO_DEAL_SERIAL_NO
 WHERE   DEAL_NO=M_DEAL_NO AND
         SERIAL_NO =M_SERIAL_NO AND
         SECURITY_CODE=M_SECURITY_CODE AND
         SCRIPT_STATUS='SL';




                INSERT INTO  DN_INV_REPO_DEAL_SERIAL_NO
                  (PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,SERIAL_NO,SCRIP_FACE_VAL,
                   FACE_VAL,FWD_RECEIPT,LOCATION,ALLO_REPO,ALLO_BL,FWD_ALLO_REPO,FWD_ALLO_BL,RET_DUE_DATE,
                   SCRIPT_STATUS,SWAP_STATUS,ORG_SERNO)

                SELECT
                   PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,M_SWAP_SERNO3,SCRIP_FACE_VAL-M_FACE_VALUE,
                   FACE_VAL-M_FACE_VALUE,FWD_RECEIPT*M_FACTOR1,LOCATION,ALLO_REPO*M_FACTOR1,
                   ALLO_BL*M_FACTOR1,FWD_ALLO_REPO*M_FACTOR1,FWD_ALLO_BL*M_FACTOR1,RET_DUE_DATE,
                   SCRIPT_STATUS,SWAP_STATUS,SERIAL_NO
                FROM  DN_INV_REPO_DEAL_SERIAL_NO
                WHERE  DEAL_NO=M_DEAL_NO AND
                      SERIAL_NO =M_SERIAL_NO AND
                      SECURITY_CODE=M_SECURITY_CODE AND
                      SCRIPT_STATUS='SL';



               SELECT  'S'||TO_CHAR(SYSDATE,'YYYY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||LPAD(TO_CHAR(DN_SEQ_SCRIPLESS.NEXTVAL),4,'0')--$$##SC
               INTO    M_SWAP_SERNO4
               FROM    DUAL;



                 INSERT INTO  DN_INV_REPO_DEAL_SERIAL_NO
                  (PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,SERIAL_NO,SCRIP_FACE_VAL,
                   FACE_VAL,FWD_RECEIPT,LOCATION,ALLO_REPO,ALLO_BL,FWD_ALLO_REPO,FWD_ALLO_BL,RET_DUE_DATE,
                   SCRIPT_STATUS,SWAP_STATUS,ORG_SERNO)

                SELECT
                   PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,M_SWAP_SERNO4,M_FACE_VALUE,
                   M_FACE_VALUE,FWD_RECEIPT*M_FACTOR2,LOCATION,ALLO_REPO*M_FACTOR2,
                   ALLO_BL*M_FACTOR2,FWD_ALLO_REPO*M_FACTOR2,FWD_ALLO_BL*M_FACTOR2,RET_DUE_DATE,
                   SCRIPT_STATUS,SWAP_STATUS,SERIAL_NO
                FROM  DN_INV_REPO_DEAL_SERIAL_NO
                WHERE  DEAL_NO=M_DEAL_NO AND
                      SERIAL_NO =M_SERIAL_NO AND
                      SECURITY_CODE=M_SECURITY_CODE AND
                      SCRIPT_STATUS='SL'  ;



             UPDATE   DN_INV_REPO_DEAL_SERIAL_NO
             SET      SWAP_STATUS='Y',
                      RET_DUE_DATE=EFF_VALDATE,
                      ORG_SERNO='SWP'
             WHERE    DEAL_NO=M_DEAL_NO AND
                      SERIAL_NO =M_SERIAL_NO AND
                      SECURITY_CODE=M_SECURITY_CODE AND
                      SCRIPT_STATUS='SL';





           INSERT INTO DN_INV_REPO_DEAL_SERNO_ALLO
                  (PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,
                   SERIAL_NO,ALLO_TYPE,START_DATE,END_DATE,ALLO_FACE_VALUE,PREV_DEAL_NO)

          SELECT PORTFOLIO_CODE,SYSDATE,INST_TYPE,SECURITY_CODE,DEAL_NO,
                   M_SWAP_SERNO3,ALLO_TYPE,SYSDATE,END_DATE,(ALLO_FACE_VALUE-M_FACE_VALUE),PREV_DEAL_NO
           FROM  DN_INV_REPO_DEAL_SERNO_ALLO
           WHERE  PORTFOLIO_CODE=M_PORTFOLIO_CODE
               AND
               INST_TYPE=M_INST_TYPE
               AND
               SECURITY_CODE=M_SECURITY_CODE
               AND
               DEAL_NO=M_ALLO_DEAL_NO
               AND
               SERIAL_NO=M_SERIAL_NO
               AND
               END_DATE>=SYSDATE
               -------------------------------------------------------------
               AND
               EFF_VALDATE=(SELECT MAX(EFF_VALDATE)
                            FROM DN_INV_REPO_DEAL_SERNO_ALLO
                            WHERE   PORTFOLIO_CODE=M_PORTFOLIO_CODE   AND
                                    INST_TYPE=M_INST_TYPE     AND
                                    SECURITY_CODE=M_SECURITY_CODE    AND
                                    DEAL_NO=M_ALLO_DEAL_NO     AND
                                    SERIAL_NO=M_SERIAL_NO);--ADDED BY NM AND NF ON 01-07-2004 VC TO PREVENT A UNIQUE CONSTRAINT ERROR
               ----------------------------------------------------------------

     UPDATE DN_INV_REPO_DEAL_SERNO_ALLO
           SET END_DATE=SYSDATE
           WHERE
               PORTFOLIO_CODE=M_PORTFOLIO_CODE
               AND
               INST_TYPE=M_INST_TYPE
               AND
               SECURITY_CODE=M_SECURITY_CODE
               AND
               DEAL_NO=M_ALLO_DEAL_NO
               AND
               SERIAL_NO=M_SERIAL_NO
               AND
               END_DATE>=SYSDATE;--ADDED BY NM AND NF ON 01-07-2004 VC TO PREVENT A UNIQUE CONSTRAINT ERROR


          IF SUBSTR(M_DEAL_NO,1,2)='RF' THEN


                INSERT INTO DN_TRN_REPO_FRESH_SERIAL_NO
                    (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,
                     FACE_VALUE,LOCATION
                    )
                 SELECT M_DEAL_NO,M_INST_TYPE,INV_CODE,--ADDED BY KEITH ON 06-12-2004 FOR VC-REF 04-267 FOR INVENTORY ALLOCATION (PART)
                     M_SECURITY_CODE,M_SWAP_SERNO4,FACE_VALUE-M_FACE_VALUE,
                     M_PORTFOLIO_CODE
                FROM   DN_TRN_REPO_FRESH_SERIAL_NO
                WHERE  DEAL_NO=M_DEAL_NO AND SERIAL_NO=M_SERIAL_NO;


                INSERT INTO DN_TRN_REPO_FRESH_SERIAL_NO
                    (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,
                     FACE_VALUE,LOCATION

                    )
                SELECT M_DEAL_NO,M_INST_TYPE,INV_CODE,--ADDED BY KEITH ON 06-12-2004 FOR VC-REF 04-267 FOR INVENTORY ALLOCATION (PART)
                     M_SECURITY_CODE,M_SWAP_SERNO3,FACE_VALUE-M_FACE_VALUE,
                     M_PORTFOLIO_CODE
                FROM   DN_TRN_REPO_FRESH_SERIAL_NO
                WHERE  DEAL_NO=M_DEAL_NO AND SERIAL_NO=M_SERIAL_NO;



        DELETE FROM DN_TRN_REPO_FRESH_SERIAL_NO
        WHERE  DEAL_NO=M_DEAL_NO AND SERIAL_NO=M_SERIAL_NO;
 END IF;
---------------------------------------------------------------------------------
 IF SUBSTR(M_ALLO_DEAL_NO,1,2)='RF' THEN

           INSERT INTO DN_TRN_REPO_FRESH_SERIAL_NO
                    (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,
                     FACE_VALUE,LOCATION,PREV_DEAL_NO

                    )
                SELECT DEAL_NO,INST_TYPE,INV_CODE,
                     SECURITY_CODE,M_SWAP_SERNO3,FACE_VALUE-M_FACE_VALUE,
                     M_PORTFOLIO_CODE,PREV_DEAL_NO
                FROM   DN_TRN_REPO_FRESH_SERIAL_NO
                WHERE  DEAL_NO=M_ALLO_DEAL_NO AND SERIAL_NO=M_SERIAL_NO;


      INSERT INTO DN_TRN_REPO_FRESH_SERIAL_NO
                    (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,
                     FACE_VALUE,LOCATION,PREV_DEAL_NO

                    )
                SELECT DEAL_NO,INST_TYPE,INV_CODE,
                     SECURITY_CODE,M_SWAP_SERNO4,M_FACE_VALUE,
                     M_PORTFOLIO_CODE,PREV_DEAL_NO
                FROM   DN_TRN_REPO_FRESH_SERIAL_NO
                WHERE  DEAL_NO=M_ALLO_DEAL_NO AND SERIAL_NO=M_SERIAL_NO;


 DELETE FROM DN_TRN_REPO_FRESH_SERIAL_NO
        WHERE  DEAL_NO=M_ALLO_DEAL_NO AND SERIAL_NO=M_SERIAL_NO;
END IF;

           IF SUBSTR(M_DEAL_NO,1,2)='RR' THEN


                 INSERT INTO DN_TRN_REPO_ROLLOVER_SERIAL_NO
                    (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,
                     FACE_VALUE,LOCATION
                    )
                 SELECT M_DEAL_NO,M_INST_TYPE,INV_CODE,--ADDED BY KEITH ON 06-12-2004 FOR VC-REF 04-267 FOR INVENTORY ALLOCATION (PART)
                  M_SECURITY_CODE,M_SWAP_SERNO4,FACE_VALUE-M_FACE_VALUE,
                  M_PORTFOLIO_CODE
                  FROM   DN_TRN_REPO_ROLLOVER_SERIAL_NO
                  WHERE  DEAL_NO=M_DEAL_NO AND SERIAL_NO=M_SERIAL_NO;


                INSERT INTO DN_TRN_REPO_ROLLOVER_SERIAL_NO
                    (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,
                     FACE_VALUE,LOCATION

                    )
                SELECT M_DEAL_NO,M_INST_TYPE,INV_CODE,
                     M_SECURITY_CODE,M_SWAP_SERNO3,FACE_VALUE-M_FACE_VALUE,
                     M_PORTFOLIO_CODE
                FROM   DN_TRN_REPO_ROLLOVER_SERIAL_NO
                WHERE  DEAL_NO=M_DEAL_NO AND SERIAL_NO=M_SERIAL_NO;



        DELETE FROM DN_TRN_REPO_ROLLOVER_SERIAL_NO
        WHERE  DEAL_NO=M_DEAL_NO AND SERIAL_NO=M_SERIAL_NO;
END IF;
---------------------------------------
 IF SUBSTR(M_ALLO_DEAL_NO,1,2)='RR' THEN

         INSERT INTO DN_TRN_REPO_ROLLOVER_SERIAL_NO
                    (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,
                     FACE_VALUE,LOCATION,PREV_DEAL_NO
                    )
               SELECT DEAL_NO,INST_TYPE,INV_CODE,
                     SECURITY_CODE,M_SWAP_SERNO3,FACE_VALUE-M_FACE_VALUE,
                     M_PORTFOLIO_CODE,PREV_DEAL_NO
                FROM   DN_TRN_REPO_ROLLOVER_SERIAL_NO
                WHERE  DEAL_NO=M_ALLO_DEAL_NO AND SERIAL_NO=M_SERIAL_NO;


                INSERT INTO DN_TRN_REPO_ROLLOVER_SERIAL_NO
                    (DEAL_NO,INST_TYPE,INV_CODE,SECURITY_CODE,SERIAL_NO,
                     FACE_VALUE,LOCATION,PREV_DEAL_NO

                    )
                SELECT DEAL_NO,M_INST_TYPE,INV_CODE,
                     M_SECURITY_CODE,M_SWAP_SERNO4,M_FACE_VALUE,
                     M_PORTFOLIO_CODE,PREV_DEAL_NO
                FROM   DN_TRN_REPO_ROLLOVER_SERIAL_NO
                WHERE  DEAL_NO=M_ALLO_DEAL_NO AND SERIAL_NO=M_SERIAL_NO;



        DELETE FROM DN_TRN_REPO_ROLLOVER_SERIAL_NO
        WHERE  DEAL_NO=M_ALLO_DEAL_NO AND SERIAL_NO=M_SERIAL_NO;


   END IF;--RR



ELSE--------VC UNALLONEW
-----------------------------------------------------------------------------------------------------


           UPDATE DN_INV_REPO_DEAL_SERNO_ALLO
           SET END_DATE=M_END_DATE
           WHERE
               PORTFOLIO_CODE=M_PORTFOLIO_CODE
               AND
               INST_TYPE=M_INST_TYPE
               AND
               SECURITY_CODE=M_SECURITY_CODE
               AND
               DEAL_NO=M_ALLO_DEAL_NO----VC UNALLO

               AND
               SERIAL_NO=M_SERIAL_NO
               AND
               END_DATE>=SYSDATE;--ADDED BY NM AND NF ON 01-07-2004 VC TO PREVENT A UNIQUE CONSTRAINT ERROR

           UPDATE DN_INV_REPO_DEAL_SERIAL_NO
           SET ALLO_REPO=ALLO_REPO-M_ALLO_REPO,
                ALLO_BL=ALLO_BL-M_ALLO_BL,
                FWD_ALLO_REPO=FWD_ALLO_REPO-M_FWD_ALLO_REPO,
                FWD_ALLO_BL=FWD_ALLO_BL-M_FWD_ALLO_BL,
                LOCATION=M_PORTFOLIO_CODE
           WHERE
                PORTFOLIO_CODE=M_PORTFOLIO_CODE
                AND
                INST_TYPE=M_INST_TYPE
                AND
                SECURITY_CODE=M_SECURITY_CODE
                --AND
                --DEAL_NO=M_DEAL_NO
                AND
                SERIAL_NO=M_SERIAL_NO;

END IF;----------VC UNALLO-----------------------------------------------------
      ELSIF M_INV_CODE='BL' THEN--=======================================

           UPDATE DN_INV_BL_DEAL_SERNO_ALLO
           SET END_DATE=M_END_DATE
           WHERE
               PORTFOLIO_CODE=M_PORTFOLIO_CODE
               AND
               INST_TYPE=M_INST_TYPE
               AND
               SECURITY_CODE=M_SECURITY_CODE
               AND
               DEAL_NO=M_ALLO_DEAL_NO----VC UNALLO
               AND
               SERIAL_NO=M_SERIAL_NO;

           UPDATE DN_INV_BL_DEAL_SERIAL_NO
           SET ALLO_REPO=ALLO_REPO-M_ALLO_REPO,
                ALLO_BL=ALLO_BL-M_ALLO_BL,
                FWD_ALLO_REPO=FWD_ALLO_REPO-M_FWD_ALLO_REPO,
                FWD_ALLO_BL=FWD_ALLO_BL-M_FWD_ALLO_BL,
                LOCATION=M_PORTFOLIO_CODE
           WHERE
                PORTFOLIO_CODE=M_PORTFOLIO_CODE
                AND
                INST_TYPE=M_INST_TYPE
                AND
                SECURITY_CODE=M_SECURITY_CODE
                --AND
                --DEAL_NO=M_DEAL_NO
                AND
                SERIAL_NO=M_SERIAL_NO;

      END IF;

--RAISE_APPLICATION_ERROR(-20201,'########### '||M_INV_EXCHG_NO||'| '||M_COUNP_LOCATION);


--UPDATING TRANSACTION TABLES FOR 'RECEIPTS'--

      IF SUBSTR(M_ALLO_DEAL_NO,1,2)='RF' THEN

        DELETE DN_TRN_REPO_FRESH_SERIAL_NO
        WHERE
          DEAL_NO=M_ALLO_DEAL_NO
          AND
          SECURITY_CODE=M_SECURITY_CODE
          AND
          SERIAL_NO=DECODE(M_PART_ALLO_STATUS,'1',M_SWAP_SERNO4,M_SERIAL_NO);--VC UNALLO

       OPEN CURS_UP_SEC FOR

           SELECT DEAL_NO,SECURITY_CODE,INV_CODE,FACE_VALUE
           FROM DN_TRN_REPO_FRESH_SEC
           WHERE
              DEAL_NO=M_ALLO_DEAL_NO
              AND
              SECURITY_CODE=M_SECURITY_CODE;

       BAL_FACE_VALUE:=M_FACE_VALUE;

       LOOP

           FETCH  CURS_UP_SEC INTO

            U_DEAL_NO,
            U_SECURITY_CODE,
            U_INV_CODE,
            U_FACE_VALUE;

          EXIT WHEN CURS_UP_SEC%NOTFOUND OR BAL_FACE_VALUE=0;

          IF U_FACE_VALUE<BAL_FACE_VALUE THEN
             UPDATE DN_TRN_REPO_FRESH_SEC
             SET  FACE_VALUE=0
             WHERE
                DEAL_NO=U_DEAL_NO
                AND
                SECURITY_CODE=U_SECURITY_CODE
                AND
                INV_CODE=U_INV_CODE;

             BAL_FACE_VALUE:=BAL_FACE_VALUE-U_FACE_VALUE;

          ELSE
             UPDATE DN_TRN_REPO_FRESH_SEC
             SET  FACE_VALUE=FACE_VALUE-BAL_FACE_VALUE
             WHERE
                DEAL_NO=U_DEAL_NO
                AND
                SECURITY_CODE=U_SECURITY_CODE
                AND
                INV_CODE=U_INV_CODE;

             BAL_FACE_VALUE:=0;


          END IF;

       END LOOP;



    ELSIF SUBSTR(M_ALLO_DEAL_NO,1,2)='RR' THEN

        DELETE DN_TRN_REPO_ROLLOVER_SERIAL_NO
        WHERE
          DEAL_NO=M_ALLO_DEAL_NO
          AND
          SECURITY_CODE=M_SECURITY_CODE
          AND
          SERIAL_NO=DECODE(M_PART_ALLO_STATUS,'1',M_SWAP_SERNO4,M_SERIAL_NO);--VC UNALLO

       OPEN CURS_UP_SEC FOR

           SELECT DEAL_NO,SECURITY_CODE,INV_CODE,FACE_VALUE
           FROM DN_TRN_REPO_ROLLOVER_SEC
           WHERE
              DEAL_NO=M_ALLO_DEAL_NO
              AND
              SECURITY_CODE=M_SECURITY_CODE;

       BAL_FACE_VALUE:=M_FACE_VALUE;

       LOOP

           FETCH  CURS_UP_SEC INTO

            U_DEAL_NO,
            U_SECURITY_CODE,
            U_INV_CODE,
            U_FACE_VALUE;

          EXIT WHEN CURS_UP_SEC%NOTFOUND OR BAL_FACE_VALUE=0;

          IF U_FACE_VALUE<BAL_FACE_VALUE THEN
             UPDATE DN_TRN_REPO_ROLLOVER_SEC
             SET  FACE_VALUE=0
             WHERE
                DEAL_NO=U_DEAL_NO
                AND
                SECURITY_CODE=U_SECURITY_CODE
                AND
                INV_CODE=U_INV_CODE;

             BAL_FACE_VALUE:=BAL_FACE_VALUE-U_FACE_VALUE;

          ELSE
             UPDATE DN_TRN_REPO_ROLLOVER_SEC
             SET  FACE_VALUE=FACE_VALUE-BAL_FACE_VALUE
             WHERE
                DEAL_NO=U_DEAL_NO
                AND
                SECURITY_CODE=U_SECURITY_CODE
                AND
                INV_CODE=U_INV_CODE;

             BAL_FACE_VALUE:=0;


          END IF;

       END LOOP;

     END IF;

   END LOOP;


END DN_BO_INV_EXCH_RP_I;

/
