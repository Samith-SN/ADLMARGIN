--------------------------------------------------------
--  DDL for Procedure DN_BO_INV_SWAPS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_BO_INV_SWAPS" 
   (
    M_INV_SWAP_NO      DN_TRN_BO_INV_SWAP.INV_SWAP_NO%TYPE
   )

   IS

    -- Procedue     : Update swaps of serial numbers in the inventory
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 10/09/1999



--to be checked and refined
--to be checked and refined




M_R_NO               NUMBER;
M_I_NO               NUMBER;
M_NEW_SERIAL_NO      DN_INV_INT_OUTPS_DEAL_SERNO.SERIAL_NO%TYPE;
M_OLD_SERIAL_NO      DN_INV_INT_OUTPS_DEAL_SERNO.SERIAL_NO%TYPE;
M_PORTFOLIO_CODE     DN_INV_INT_OUTPS_DEAL_SERNO.PORTFOLIO_CODE%TYPE;
M_INST_TYPE          DN_INV_INT_OUTPS_DEAL_SERNO.INST_TYPE%TYPE;
M_SECURITY_CODE      DN_INV_INT_OUTPS_DEAL_SERNO.SECURITY_CODE%TYPE;
M_DEAL_NO            DN_INV_INT_OUTPS_DEAL_SERNO.DEAL_NO%TYPE;
M_FACE_VALUE         DN_INV_INT_OUTPS_DEAL_SERNO.FACE_VAL%TYPE;

BEGIN


   SELECT
      COUNT(*) INTO M_R_NO
   FROM
      DN_TRN_BO_INV_SWAP B
   WHERE
      B.INV_SWAP_NO=M_INV_SWAP_NO
      AND
      B.INV_CODE='OR'
      AND
      B.TRANS_TYPE='R';

   SELECT
      COUNT(*) INTO M_I_NO
   FROM
      DN_TRN_BO_INV_SWAP B
   WHERE
      B.INV_SWAP_NO=M_INV_SWAP_NO
      AND
      B.INV_CODE='OR'
      AND
      B.TRANS_TYPE='I';

   IF M_I_NO=1 AND M_R_NO=1 THEN

       SELECT
          SERIAL_NO INTO M_NEW_SERIAL_NO
       FROM
          DN_TRN_BO_INV_SWAP B
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.INV_CODE='OR'
          AND
          B.TRANS_TYPE='R';

       SELECT
          SERIAL_NO INTO M_OLD_SERIAL_NO
       FROM
          DN_TRN_BO_INV_SWAP B
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.INV_CODE='OR'
          AND
          B.TRANS_TYPE='I';


      INSERT INTO DN_INV_OUTPS_DEAL_SERIAL_NO
         (PORTFOLIO_CODE,
          EFF_VALDATE,
          INST_TYPE,
          SECURITY_CODE,
          DEAL_NO,
          SERIAL_NO,
          DEAL_YIELD,
          YIELD_WITH_BROKERAGE,
          SCRIP_FACE_VAL,
          FACE_VAL,
          INITIAL_COST,
          BROKERAGE,
          PRICE_INT_ACCR,
          CARR_VAL,
          COUP_INT_PURCH ,
          COUP_INT_ACCR ,
          TOT_COUP_INT,
          FWD_SALE,
          FWD_PURCHASE,
          LOCATION,
          ALLO_REPO ,
          ALLO_BL,
          FWD_ALLO_REPO,
          FWD_ALLO_BL,
          SALE_DEAL_NO,
          SERIAL_NO_STATUS,
          SALE_EFF_VALDATE,
          RET_DUE_DATE
         )
       SELECT
          A.PORTFOLIO_CODE,
          A.EFF_VALDATE,
          A.INST_TYPE,
          A.SECURITY_CODE,
          A.DEAL_NO,
          B.SERIAL_NO,
          A.DEAL_YIELD,
          A.YIELD_WITH_BROKERAGE,
          B.FACE_VALUE,
          A.FACE_VAL,
          A.INITIAL_COST,
          A.BROKERAGE,
          A.PRICE_INT_ACCR,
          A.CARR_VAL,
          A.COUP_INT_PURCH,
          A.COUP_INT_ACCR,
          A.TOT_COUP_INT,
          A.FWD_SALE,
          A.FWD_PURCHASE,
          A.LOCATION,
          A.ALLO_REPO,
          A.ALLO_BL,
          A.FWD_ALLO_REPO,
          A.FWD_ALLO_BL,
          A.SALE_DEAL_NO,
          A.SERIAL_NO_STATUS,
          A.SALE_EFF_VALDATE,
          A.RET_DUE_DATE
       FROM
          DN_INV_OUTPS_DEAL_SERIAL_NO A,
          DN_TRN_BO_INV_SWAP B
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
          AND
          B.INST_TYPE=A.INST_TYPE
          AND
          B.SECURITY_CODE=A.SECURITY_CODE
          AND
          B.DEAL_NO=A.DEAL_NO
          AND
          B.INV_CODE='OR'
          AND
          B.TRANS_TYPE='R'
          AND
          A.SERIAL_NO=M_OLD_SERIAL_NO;

      INSERT INTO  DN_INV_OUTPS_DEAL_SERNO_ALLO
         (PORTFOLIO_CODE,
          EFF_VALDATE,
          INST_TYPE,
          SECURITY_CODE,
          DEAL_NO ,
          SERIAL_NO,
          ALLO_TYPE,
          START_DATE,
          END_DATE,
          ALLO_FACE_VALUE,
          PREV_DEAL_NO
         )
      SELECT
         A.PORTFOLIO_CODE,
         A.EFF_VALDATE,
         A.INST_TYPE,
         A.SECURITY_CODE,
         A.DEAL_NO ,
         B.SERIAL_NO,
         A.ALLO_TYPE,
         A.START_DATE,
         A.END_DATE,
         A.ALLO_FACE_VALUE,
         A.PREV_DEAL_NO
      FROM
         DN_INV_OUTPS_DEAL_SERNO_ALLO A,
         DN_TRN_BO_INV_SWAP B
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
          AND
          B.INST_TYPE=A.INST_TYPE
          AND
          B.SECURITY_CODE=A.SECURITY_CODE
          AND
          B.DEAL_NO=A.PREV_DEAL_NO
          AND
          B.INV_CODE='OR'
          AND
          B.TRANS_TYPE='R'
          AND
          A.SERIAL_NO=M_OLD_SERIAL_NO;

      DELETE DN_INV_OUTPS_DEAL_SERNO_ALLO
      WHERE
         PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||PREV_DEAL_NO||SERIAL_NO
         IN
         (SELECT
             PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||DEAL_NO||SERIAL_NO
          FROM
             DN_TRN_BO_INV_SWAP B
          WHERE
             B.INV_SWAP_NO=M_INV_SWAP_NO
             AND
             B.INV_CODE='OR'
             AND
             B.TRANS_TYPE='I');

       DELETE DN_INV_OUTPS_DEAL_SERIAL_NO
       WHERE
          PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||DEAL_NO||SERIAL_NO
          IN
          (SELECT
              PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||DEAL_NO||SERIAL_NO
           FROM
              DN_TRN_BO_INV_SWAP B
           WHERE
              B.INV_SWAP_NO=M_INV_SWAP_NO
              AND
              B.INV_CODE='OR'
              AND
              B.TRANS_TYPE='I');

       SELECT
          SERIAL_NO,PORTFOLIO_CODE,INST_TYPE,SECURITY_CODE,DEAL_NO
          INTO M_OLD_SERIAL_NO,M_PORTFOLIO_CODE,M_INST_TYPE,M_SECURITY_CODE,M_DEAL_NO
       FROM
          DN_TRN_BO_INV_SWAP B
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.INV_CODE='OR'
          AND
          B.TRANS_TYPE='I';


       UPDATE DN_INV_INT_OUTPS_DEAL_SERNO
       SET SERIAL_NO=M_NEW_SERIAL_NO
       WHERE
          PORTFOLIO_CODE=M_PORTFOLIO_CODE
          AND
          INST_TYPE=M_INST_TYPE
          AND
          SECURITY_CODE=M_SECURITY_CODE
          AND
          DEAL_NO=M_DEAL_NO
          AND
          SERIAL_NO=M_OLD_SERIAL_NO;

  END IF;



   SELECT
      COUNT(*) INTO M_R_NO
   FROM
      DN_TRN_BO_INV_SWAP B
   WHERE
      B.INV_SWAP_NO=M_INV_SWAP_NO
      AND
      B.INV_CODE='RP'
      AND
      B.TRANS_TYPE='R';

   SELECT
      COUNT(*) INTO M_I_NO
   FROM
      DN_TRN_BO_INV_SWAP B
   WHERE
      B.INV_SWAP_NO=M_INV_SWAP_NO
      AND
      B.INV_CODE='RP'
      AND
      B.TRANS_TYPE='I';

   IF M_I_NO=1 AND M_R_NO=1 THEN

       SELECT
          SERIAL_NO INTO M_NEW_SERIAL_NO
       FROM
          DN_TRN_BO_INV_SWAP B
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.INV_CODE='OR'
          AND
          B.TRANS_TYPE='R';

       SELECT
          SERIAL_NO INTO M_OLD_SERIAL_NO
       FROM
          DN_TRN_BO_INV_SWAP B
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.INV_CODE='OR'
          AND
          B.TRANS_TYPE='I';

      INSERT INTO DN_INV_REPO_DEAL_SERIAL_NO
         (PORTFOLIO_CODE,
          EFF_VALDATE,
          INST_TYPE,
          SECURITY_CODE,
          DEAL_NO,
          SERIAL_NO,
          SCRIP_FACE_VAL,
          FACE_VAL,
          FWD_RECEIPT,
          LOCATION,
          ALLO_REPO ,
          ALLO_BL,
          FWD_ALLO_REPO,
          FWD_ALLO_BL,
          RET_DUE_DATE
         )
       SELECT
          A.PORTFOLIO_CODE,
          A.EFF_VALDATE,
          A.INST_TYPE,
          A.SECURITY_CODE,
          A.DEAL_NO,
          B.SERIAL_NO,
          B.FACE_VALUE,
          A.FACE_VAL,
          A.FWD_RECEIPT,
          A.LOCATION,
          A.ALLO_REPO,
          A.ALLO_BL,
          A.FWD_ALLO_REPO,
          A.FWD_ALLO_BL,
          A.RET_DUE_DATE
       FROM
          DN_INV_REPO_DEAL_SERIAL_NO A,
          DN_TRN_BO_INV_SWAP B
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
          AND
          B.INST_TYPE=A.INST_TYPE
          AND
          B.SECURITY_CODE=A.SECURITY_CODE
          AND
          B.DEAL_NO=A.DEAL_NO
          AND
          B.INV_CODE='RP'
          AND
          B.TRANS_TYPE='R'
          AND
          A.SERIAL_NO=M_OLD_SERIAL_NO;

      INSERT INTO  DN_INV_REPO_DEAL_SERNO_ALLO
         (PORTFOLIO_CODE,
          EFF_VALDATE,
          INST_TYPE,
          SECURITY_CODE,
          DEAL_NO ,
          SERIAL_NO,
          ALLO_TYPE,
          START_DATE,
          END_DATE,
          ALLO_FACE_VALUE,
          PREV_DEAL_NO
         )
      SELECT
         A.PORTFOLIO_CODE,
         A.EFF_VALDATE,
         A.INST_TYPE,
         A.SECURITY_CODE,
         A.DEAL_NO ,
         B.SERIAL_NO,
         A.ALLO_TYPE,
         A.START_DATE,
         A.END_DATE,
         A.ALLO_FACE_VALUE,
         A.PREV_DEAL_NO
      FROM
         DN_INV_REPO_DEAL_SERNO_ALLO A,
         DN_TRN_BO_INV_SWAP B
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
          AND
          B.INST_TYPE=A.INST_TYPE
          AND
          B.SECURITY_CODE=A.SECURITY_CODE
          AND
          B.DEAL_NO=A.PREV_DEAL_NO
          AND
          B.INV_CODE='RP'
          AND
          B.TRANS_TYPE='R'
          AND
          A.SERIAL_NO=M_OLD_SERIAL_NO;


      DELETE DN_INV_REPO_DEAL_SERNO_ALLO
      WHERE
         PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||PREV_DEAL_NO||SERIAL_NO
         IN
         (SELECT
             PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||DEAL_NO||SERIAL_NO
          FROM
             DN_TRN_BO_INV_SWAP B
          WHERE
             B.INV_SWAP_NO=M_INV_SWAP_NO
             AND
             B.INV_CODE='RP'
             AND
             B.TRANS_TYPE='I');

       DELETE DN_INV_REPO_DEAL_SERIAL_NO
       WHERE
          PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||DEAL_NO||SERIAL_NO
          IN
          (SELECT
              PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||DEAL_NO||SERIAL_NO
           FROM
              DN_TRN_BO_INV_SWAP B
           WHERE
              B.INV_SWAP_NO=M_INV_SWAP_NO
              AND
              B.INV_CODE='RP'
              AND
              B.TRANS_TYPE='I');
  END IF;

   SELECT
      COUNT(*) INTO M_R_NO
   FROM
      DN_TRN_BO_INV_SWAP B
   WHERE
      B.INV_SWAP_NO=M_INV_SWAP_NO
      AND
      B.INV_CODE='BL'
      AND
      B.TRANS_TYPE='R';

   SELECT
      COUNT(*) INTO M_I_NO
   FROM
      DN_TRN_BO_INV_SWAP B
   WHERE
      B.INV_SWAP_NO=M_INV_SWAP_NO
      AND
      B.INV_CODE='BL'
      AND
      B.TRANS_TYPE='I';

   IF M_I_NO=1 AND M_R_NO=1 THEN

       SELECT
          SERIAL_NO INTO M_NEW_SERIAL_NO
       FROM
          DN_TRN_BO_INV_SWAP B
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.INV_CODE='OR'
          AND
          B.TRANS_TYPE='R';

       SELECT
          SERIAL_NO INTO M_OLD_SERIAL_NO
       FROM
          DN_TRN_BO_INV_SWAP B
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.INV_CODE='OR'
          AND
          B.TRANS_TYPE='I';

      INSERT INTO DN_INV_BL_DEAL_SERIAL_NO
         (PORTFOLIO_CODE,
          EFF_VALDATE,
          INST_TYPE,
          SECURITY_CODE,
          DEAL_NO,
          SERIAL_NO,
          SCRIP_FACE_VAL,
          FACE_VAL,
          FWD_RECEIPT,
          LOCATION,
          ALLO_REPO ,
          ALLO_BL,
          FWD_ALLO_REPO,
          FWD_ALLO_BL,
          RET_DUE_DATE
         )
       SELECT
          A.PORTFOLIO_CODE,
          A.EFF_VALDATE,
          A.INST_TYPE,
          A.SECURITY_CODE,
          A.DEAL_NO,
          B.SERIAL_NO,
          B.FACE_VALUE,
          A.FACE_VAL,
          A.FWD_RECEIPT,
          A.LOCATION,
          A.ALLO_REPO,
          A.ALLO_BL,
          A.FWD_ALLO_REPO,
          A.FWD_ALLO_BL,
          A.RET_DUE_DATE
       FROM
          DN_INV_BL_DEAL_SERIAL_NO A,
          DN_TRN_BO_INV_SWAP B
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
          AND
          B.INST_TYPE=A.INST_TYPE
          AND
          B.SECURITY_CODE=A.SECURITY_CODE
          AND
          B.DEAL_NO=A.DEAL_NO
          AND
          B.INV_CODE='BL'
          AND
          B.TRANS_TYPE='R'
          AND
          A.SERIAL_NO=M_OLD_SERIAL_NO;

      INSERT INTO  DN_INV_BL_DEAL_SERNO_ALLO
         (PORTFOLIO_CODE,
          EFF_VALDATE,
          INST_TYPE,
          SECURITY_CODE,
          DEAL_NO ,
          SERIAL_NO,
          ALLO_TYPE,
          START_DATE,
          END_DATE,
          ALLO_FACE_VALUE,
          PREV_DEAL_NO
         )
      SELECT
         A.PORTFOLIO_CODE,
         A.EFF_VALDATE,
         A.INST_TYPE,
         A.SECURITY_CODE,
         A.DEAL_NO ,
         B.SERIAL_NO,
         A.ALLO_TYPE,
         A.START_DATE,
         A.END_DATE,
         A.ALLO_FACE_VALUE,
         A.PREV_DEAL_NO
      FROM
         DN_INV_BL_DEAL_SERNO_ALLO A,
         DN_TRN_BO_INV_SWAP B
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
          AND
          B.INST_TYPE=A.INST_TYPE
          AND
          B.SECURITY_CODE=A.SECURITY_CODE
          AND
          B.DEAL_NO=A.PREV_DEAL_NO
          AND
          B.INV_CODE='BL'
          AND
          B.TRANS_TYPE='R'
          AND
          A.SERIAL_NO=M_OLD_SERIAL_NO;


      DELETE DN_INV_BL_DEAL_SERNO_ALLO
      WHERE
         PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||PREV_DEAL_NO||SERIAL_NO
         IN
         (SELECT
             PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||DEAL_NO||SERIAL_NO
          FROM
             DN_TRN_BO_INV_SWAP B
          WHERE
             B.INV_SWAP_NO=M_INV_SWAP_NO
             AND
             B.INV_CODE='BL'
             AND
             B.TRANS_TYPE='I');

       DELETE DN_INV_BL_DEAL_SERIAL_NO
       WHERE
          PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||DEAL_NO||SERIAL_NO
          IN
          (SELECT
              PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||DEAL_NO||SERIAL_NO
           FROM
              DN_TRN_BO_INV_SWAP B
           WHERE
              B.INV_SWAP_NO=M_INV_SWAP_NO
              AND
              B.INV_CODE='BL'
              AND
              B.TRANS_TYPE='I');
  END IF;


  M_R_NO:=0;
  M_I_NO:=0;

   SELECT
      COUNT(*) INTO M_R_NO
   FROM
      DN_TRN_BO_INV_SWAP B
   WHERE
      B.INV_SWAP_NO=M_INV_SWAP_NO
      AND
      B.INV_CODE='OR'
      AND
      B.TRANS_TYPE='R';

   SELECT
      COUNT(*) INTO M_I_NO
   FROM
      DN_TRN_BO_INV_SWAP B
   WHERE
      B.INV_SWAP_NO=M_INV_SWAP_NO
      AND
      B.INV_CODE='OR'
      AND
      B.TRANS_TYPE='I';

   IF M_I_NO>1 AND M_R_NO=1 THEN

      SELECT
         SERIAL_NO,FACE_VALUE
         INTO M_NEW_SERIAL_NO,M_FACE_VALUE
      FROM
         DN_TRN_BO_INV_SWAP B
      WHERE
         B.INV_SWAP_NO=M_INV_SWAP_NO
         AND
         B.INV_CODE='OR'
         AND
         B.TRANS_TYPE='R';

      INSERT INTO DN_INV_OUTPS_DEAL_SERIAL_NO
         (PORTFOLIO_CODE,
          EFF_VALDATE,
          INST_TYPE,
          SECURITY_CODE,
          DEAL_NO,
          SERIAL_NO,
          DEAL_YIELD,
          YIELD_WITH_BROKERAGE,
          SCRIP_FACE_VAL,
          FACE_VAL,
          INITIAL_COST,
          BROKERAGE,
          PRICE_INT_ACCR,
          CARR_VAL,
          COUP_INT_PURCH,
          COUP_INT_ACCR,
          TOT_COUP_INT,
          FWD_SALE,
          FWD_PURCHASE,
          LOCATION,
          ALLO_REPO,
          ALLO_BL,
          FWD_ALLO_REPO,
          FWD_ALLO_BL,
          SALE_DEAL_NO,
          SERIAL_NO_STATUS,
          SALE_EFF_VALDATE,
          RET_DUE_DATE
         )
       SELECT
          A.PORTFOLIO_CODE,
          A.EFF_VALDATE,
          A.INST_TYPE,
          A.SECURITY_CODE,
          A.DEAL_NO,
          M_NEW_SERIAL_NO,
          MAX(A.DEAL_YIELD),
          MAX(A.YIELD_WITH_BROKERAGE),
          M_FACE_VALUE,
          SUM(A.FACE_VAL),
          SUM(A.INITIAL_COST),
          SUM(A.BROKERAGE),
          SUM(A.PRICE_INT_ACCR),
          SUM(A.CARR_VAL),
          SUM(A.COUP_INT_PURCH),
          SUM(A.COUP_INT_ACCR),
          SUM(A.TOT_COUP_INT),
          SUM(A.FWD_SALE),
          SUM(A.FWD_PURCHASE),
          MAX(A.LOCATION),
          SUM(A.ALLO_REPO),
          SUM(A.ALLO_BL),
          SUM(A.FWD_ALLO_REPO),
          SUM(A.FWD_ALLO_BL),
          MAX(A.SALE_DEAL_NO),
          MAX(A.SERIAL_NO_STATUS),
          MAX(A.SALE_EFF_VALDATE),
          MAX(A.RET_DUE_DATE)
       FROM
          DN_INV_OUTPS_DEAL_SERIAL_NO A,
          DN_TRN_BO_INV_SWAP B
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
          AND
          B.INST_TYPE=A.INST_TYPE
          AND
          B.SECURITY_CODE=A.SECURITY_CODE
          AND
          B.DEAL_NO=A.DEAL_NO
          AND
          B.SERIAL_NO=A.SERIAL_NO
          AND
          B.INV_CODE='OR'
          AND
          B.TRANS_TYPE='I'
      GROUP BY A.PORTFOLIO_CODE,
          A.EFF_VALDATE,
          A.INST_TYPE,
          A.SECURITY_CODE,A.DEAL_NO;

      INSERT INTO  DN_INV_OUTPS_DEAL_SERNO_ALLO
         (PORTFOLIO_CODE,
          EFF_VALDATE,
          INST_TYPE,
          SECURITY_CODE,
          DEAL_NO ,
          SERIAL_NO,
          ALLO_TYPE,
          START_DATE,
          END_DATE,
          ALLO_FACE_VALUE,
          PREV_DEAL_NO
         )
      SELECT
         A.PORTFOLIO_CODE,
         A.EFF_VALDATE,
         A.INST_TYPE,
         A.SECURITY_CODE,
         A.DEAL_NO ,
         M_NEW_SERIAL_NO,
         MAX(A.ALLO_TYPE),
         MAX(A.START_DATE),
         MAX(A.END_DATE),
         SUM(A.ALLO_FACE_VALUE),
         MAX(A.PREV_DEAL_NO)
      FROM
         DN_INV_OUTPS_DEAL_SERNO_ALLO A,
         DN_TRN_BO_INV_SWAP B
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
          AND
          B.INST_TYPE=A.INST_TYPE
          AND
          B.SECURITY_CODE=A.SECURITY_CODE
          AND
          B.DEAL_NO=A.PREV_DEAL_NO
          AND
          B.INV_CODE='OR'
          AND
          B.TRANS_TYPE='I'
      GROUP BY A.PORTFOLIO_CODE,
          A.EFF_VALDATE,
          A.INST_TYPE,
          A.SECURITY_CODE,A.DEAL_NO;



      DELETE DN_INV_OUTPS_DEAL_SERNO_ALLO
      WHERE
         PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||PREV_DEAL_NO||SERIAL_NO
         IN
         (SELECT
             PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||DEAL_NO||SERIAL_NO
          FROM
             DN_TRN_BO_INV_SWAP B
          WHERE
             B.INV_SWAP_NO=M_INV_SWAP_NO
             AND
             B.INV_CODE='OR'
             AND
             B.TRANS_TYPE='I');

       DELETE DN_INV_OUTPS_DEAL_SERIAL_NO
       WHERE
          PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||DEAL_NO||SERIAL_NO
          IN
          (SELECT
              PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||DEAL_NO||SERIAL_NO
           FROM
              DN_TRN_BO_INV_SWAP B
           WHERE
              B.INV_SWAP_NO=M_INV_SWAP_NO
              AND
              B.INV_CODE='OR'
              AND
              B.TRANS_TYPE='I');


       UPDATE DN_INV_INT_OUTPS_DEAL_SERNO C
       SET SERIAL_NO=(SELECT
                         SERIAL_NO
                      FROM
                         DN_TRN_BO_INV_SWAP B
                      WHERE
                        B.INV_SWAP_NO=M_INV_SWAP_NO
                        AND
                        B.INV_CODE='OR'
                        AND
                        B.TRANS_TYPE='I'
                        AND
                        C.PORTFOLIO_CODE=B.PORTFOLIO_CODE
                        AND
                        C.INST_TYPE=B.INST_TYPE
                        AND
                        C.SECURITY_CODE=B.SECURITY_CODE
                        AND
                        C.DEAL_NO=B.DEAL_NO)
       WHERE
          PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||DEAL_NO||SERIAL_NO
          IN
          (SELECT
              PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||DEAL_NO||SERIAL_NO
           FROM
              DN_TRN_BO_INV_SWAP B
           WHERE
              B.INV_SWAP_NO=M_INV_SWAP_NO
              AND
              B.INV_CODE='OR'
              AND
              B.TRANS_TYPE='I');



  END IF;

   SELECT
      COUNT(*) INTO M_R_NO
   FROM
      DN_TRN_BO_INV_SWAP B
   WHERE
      B.INV_SWAP_NO=M_INV_SWAP_NO
      AND
      B.INV_CODE='RP'
      AND
      B.TRANS_TYPE='R';

   SELECT
      COUNT(*) INTO M_I_NO
   FROM
      DN_TRN_BO_INV_SWAP B
   WHERE
      B.INV_SWAP_NO=M_INV_SWAP_NO
      AND
      B.INV_CODE='RP'
      AND
      B.TRANS_TYPE='I';

   IF M_I_NO>1 AND M_R_NO=1 THEN

      SELECT
         SERIAL_NO,FACE_VALUE
         INTO M_NEW_SERIAL_NO,M_FACE_VALUE
      FROM
         DN_TRN_BO_INV_SWAP B
      WHERE
         B.INV_SWAP_NO=M_INV_SWAP_NO
         AND
         B.INV_CODE='RP'
         AND
         B.TRANS_TYPE='R';

      INSERT INTO DN_INV_REPO_DEAL_SERIAL_NO
         (PORTFOLIO_CODE,
          EFF_VALDATE,
          INST_TYPE,
          SECURITY_CODE,
          DEAL_NO,
          SERIAL_NO,
          SCRIP_FACE_VAL,
          FACE_VAL,
          FWD_RECEIPT,
          LOCATION,
          ALLO_REPO,
          ALLO_BL,
          FWD_ALLO_REPO,
          FWD_ALLO_BL,
          RET_DUE_DATE
         )
       SELECT
          A.PORTFOLIO_CODE,
          A.EFF_VALDATE,
          A.INST_TYPE,
          A.SECURITY_CODE,
          A.DEAL_NO,
          M_NEW_SERIAL_NO,
          M_FACE_VALUE,
          SUM(A.FACE_VAL),
          SUM(A.FWD_RECEIPT),
          MAX(A.LOCATION),
          SUM(A.ALLO_REPO),
          SUM(A.ALLO_BL),
          SUM(A.FWD_ALLO_REPO),
          SUM(A.FWD_ALLO_BL),
          MAX(A.RET_DUE_DATE)
       FROM
          DN_INV_REPO_DEAL_SERIAL_NO A,
          DN_TRN_BO_INV_SWAP B
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
          AND
          B.INST_TYPE=A.INST_TYPE
          AND
          B.SECURITY_CODE=A.SECURITY_CODE
          AND
          B.DEAL_NO=A.DEAL_NO
          AND
          B.SERIAL_NO=A.SERIAL_NO
          AND
          B.INV_CODE='RP'
          AND
          B.TRANS_TYPE='I'
      GROUP BY A.PORTFOLIO_CODE,
          A.EFF_VALDATE,
          A.INST_TYPE,
          A.SECURITY_CODE,A.DEAL_NO;

      INSERT INTO  DN_INV_REPO_DEAL_SERNO_ALLO
         (PORTFOLIO_CODE,
          EFF_VALDATE,
          INST_TYPE,
          SECURITY_CODE,
          DEAL_NO ,
          SERIAL_NO,
          ALLO_TYPE,
          START_DATE,
          END_DATE,
          ALLO_FACE_VALUE,
          PREV_DEAL_NO
         )
      SELECT
         A.PORTFOLIO_CODE,
         A.EFF_VALDATE,
         A.INST_TYPE,
         A.SECURITY_CODE,
         A.DEAL_NO ,
         M_NEW_SERIAL_NO,
         MAX(A.ALLO_TYPE),
         MAX(A.START_DATE),
         MAX(A.END_DATE),
         SUM(A.ALLO_FACE_VALUE),
         MAX(A.PREV_DEAL_NO)
      FROM
         DN_INV_REPO_DEAL_SERNO_ALLO A,
         DN_TRN_BO_INV_SWAP B
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
          AND
          B.INST_TYPE=A.INST_TYPE
          AND
          B.SECURITY_CODE=A.SECURITY_CODE
          AND
          B.DEAL_NO=A.PREV_DEAL_NO
          AND
          B.INV_CODE='RP'
          AND
          B.TRANS_TYPE='I'
      GROUP BY A.PORTFOLIO_CODE,
          A.EFF_VALDATE,
          A.INST_TYPE,
          A.SECURITY_CODE,A.DEAL_NO;



      DELETE DN_INV_REPO_DEAL_SERNO_ALLO
      WHERE
         PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||PREV_DEAL_NO||SERIAL_NO
         IN
         (SELECT
             PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||DEAL_NO||SERIAL_NO
          FROM
             DN_TRN_BO_INV_SWAP B
          WHERE
             B.INV_SWAP_NO=M_INV_SWAP_NO
             AND
             B.INV_CODE='RP'
             AND
             B.TRANS_TYPE='I');

       DELETE DN_INV_REPO_DEAL_SERIAL_NO
       WHERE
          PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||DEAL_NO||SERIAL_NO
          IN
          (SELECT
              PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||DEAL_NO||SERIAL_NO
           FROM
              DN_TRN_BO_INV_SWAP B
           WHERE
              B.INV_SWAP_NO=M_INV_SWAP_NO
              AND
              B.INV_CODE='RP'
              AND
              B.TRANS_TYPE='I');
  END IF;


   SELECT
      COUNT(*) INTO M_R_NO
   FROM
      DN_TRN_BO_INV_SWAP B
   WHERE
      B.INV_SWAP_NO=M_INV_SWAP_NO
      AND
      B.INV_CODE='BL'
      AND
      B.TRANS_TYPE='R';

   SELECT
      COUNT(*) INTO M_I_NO
   FROM
      DN_TRN_BO_INV_SWAP B
   WHERE
      B.INV_SWAP_NO=M_INV_SWAP_NO
      AND
      B.INV_CODE='BL'
      AND
      B.TRANS_TYPE='I';

   IF M_I_NO>1 AND M_R_NO=1 THEN

      SELECT
         SERIAL_NO,FACE_VALUE
         INTO M_NEW_SERIAL_NO,M_FACE_VALUE
      FROM
         DN_TRN_BO_INV_SWAP B
      WHERE
         B.INV_SWAP_NO=M_INV_SWAP_NO
         AND
         B.INV_CODE='BL'
         AND
         B.TRANS_TYPE='R';

      INSERT INTO DN_INV_BL_DEAL_SERIAL_NO
         (PORTFOLIO_CODE,
          EFF_VALDATE,
          INST_TYPE,
          SECURITY_CODE,
          DEAL_NO,
          SERIAL_NO,
          SCRIP_FACE_VAL,
          FACE_VAL,
          FWD_RECEIPT,
          LOCATION,
          ALLO_REPO,
          ALLO_BL,
          FWD_ALLO_REPO,
          FWD_ALLO_BL,
          RET_DUE_DATE
         )
       SELECT
          A.PORTFOLIO_CODE,
          A.EFF_VALDATE,
          A.INST_TYPE,
          A.SECURITY_CODE,
          A.DEAL_NO,
          M_NEW_SERIAL_NO,
          M_FACE_VALUE,
          SUM(A.FACE_VAL),
          SUM(A.FWD_RECEIPT),
          MAX(A.LOCATION),
          SUM(A.ALLO_REPO),
          SUM(A.ALLO_BL),
          SUM(A.FWD_ALLO_REPO),
          SUM(A.FWD_ALLO_BL),
          MAX(A.RET_DUE_DATE)
       FROM
          DN_INV_BL_DEAL_SERIAL_NO A,
          DN_TRN_BO_INV_SWAP B
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
          AND
          B.INST_TYPE=A.INST_TYPE
          AND
          B.SECURITY_CODE=A.SECURITY_CODE
          AND
          B.DEAL_NO=A.DEAL_NO
          AND
          B.SERIAL_NO=A.SERIAL_NO
          AND
          B.INV_CODE='BL'
          AND
          B.TRANS_TYPE='I'
      GROUP BY A.PORTFOLIO_CODE,
          A.EFF_VALDATE,
          A.INST_TYPE,
          A.SECURITY_CODE,A.DEAL_NO;

      INSERT INTO  DN_INV_BL_DEAL_SERNO_ALLO
         (PORTFOLIO_CODE,
          EFF_VALDATE,
          INST_TYPE,
          SECURITY_CODE,
          DEAL_NO ,
          SERIAL_NO,
          ALLO_TYPE,
          START_DATE,
          END_DATE,
          ALLO_FACE_VALUE,
          PREV_DEAL_NO
         )
      SELECT
         A.PORTFOLIO_CODE,
         A.EFF_VALDATE,
         A.INST_TYPE,
         A.SECURITY_CODE,
         A.DEAL_NO ,
         M_NEW_SERIAL_NO,
         MAX(A.ALLO_TYPE),
         MAX(A.START_DATE),
         MAX(A.END_DATE),
         SUM(A.ALLO_FACE_VALUE),
         MAX(A.PREV_DEAL_NO)
      FROM
         DN_INV_OUTPS_DEAL_SERNO_ALLO A,
         DN_TRN_BO_INV_SWAP B
       WHERE
          B.INV_SWAP_NO=M_INV_SWAP_NO
          AND
          B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
          AND
          B.INST_TYPE=A.INST_TYPE
          AND
          B.SECURITY_CODE=A.SECURITY_CODE
          AND
          B.DEAL_NO=A.PREV_DEAL_NO
          AND
          B.INV_CODE='BL'
          AND
          B.TRANS_TYPE='I'
      GROUP BY A.PORTFOLIO_CODE,
          A.EFF_VALDATE,
          A.INST_TYPE,
          A.SECURITY_CODE,A.DEAL_NO;



      DELETE DN_INV_BL_DEAL_SERNO_ALLO
      WHERE
         PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||PREV_DEAL_NO||SERIAL_NO
         IN
         (SELECT
             PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||DEAL_NO||SERIAL_NO
          FROM
             DN_TRN_BO_INV_SWAP B
          WHERE
             B.INV_SWAP_NO=M_INV_SWAP_NO
             AND
             B.INV_CODE='BL'
             AND
             B.TRANS_TYPE='I');

       DELETE DN_INV_BL_DEAL_SERIAL_NO
       WHERE
          PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||DEAL_NO||SERIAL_NO
          IN
          (SELECT
              PORTFOLIO_CODE||INST_TYPE||SECURITY_CODE||DEAL_NO||SERIAL_NO
           FROM
              DN_TRN_BO_INV_SWAP B
           WHERE
              B.INV_SWAP_NO=M_INV_SWAP_NO
              AND
              B.INV_CODE='BL'
              AND
              B.TRANS_TYPE='I');

 END IF;

END DN_BO_INV_SWAPS;

/
