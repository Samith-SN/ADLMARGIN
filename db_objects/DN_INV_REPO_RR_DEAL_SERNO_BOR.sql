--------------------------------------------------------
--  DDL for Procedure DN_INV_REPO_RR_DEAL_SERNO_BOR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_REPO_RR_DEAL_SERNO_BOR" 
   (
    M_DEAL_NO            DN_TRN_BO_INV_RECEIPT.DEAL_NO%TYPE,
    M_INST_TYPE          DN_TRN_BO_INV_RECEIPT.INST_TYPE%TYPE,
    M_SECURITY_CODE      DN_TRN_BO_INV_RECEIPT.SECURITY_CODE%TYPE,
    M_SERIAL_NO          DN_TRN_BO_INV_RECEIPT.SERIAL_NO%TYPE,
    M_SCRP_FACE_VALUE    DN_TRN_BO_INV_RECEIPT.FACE_VALUE%TYPE,
    M_INV_CODE           DN_TRN_BO_INV_RECEIPT.INV_CODE%TYPE,
    M_LOCATION           DN_TRN_REPO_FRESH.LEND_PORTFOLIO_CODE%TYPE,
    M_CURR_CODE          DN_REF_EXCHANGE_RATES.CURR_CODE%TYPE--CURRENCY

   )


   IS

    -- Procedue     : Update REPO ROLLOVER inventory - deal-serial number - BOR
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 02/08/1999

  M_CURR_DATE             DN_TRN_REPO_ROLLOVER.EFF_VALDATE%TYPE;
  M_EFF_VALDATE           DN_TRN_REPO_ROLLOVER.EFF_VALDATE%TYPE;
  M_MATURITY_DATE         DN_TRN_REPO_ROLLOVER.MATURITY_DATE%TYPE;
  M_DATA_FROM             DN_TRN_REPO_ROLLOVER_SERIAL_NO.DATA_FROM%TYPE;
  M_INV_STATUS            DN_TRN_REPO_ROLLOVER_SERIAL_NO.INV_STATUS%TYPE;
  M_LEND_PORTFOLIO_CODE   DN_TRN_REPO_ROLLOVER.LEND_PORTFOLIO_CODE%TYPE;
  M_BORR_PORTFOLIO_CODE   DN_TRN_REPO_ROLLOVER.BORR_PORTFOLIO_CODE%TYPE;
  M_COUNT                 NUMBER;
  M_COUNT1                NUMBER;

BEGIN

-- RAISE_APPLICATION_ERROR(-20201,'M_DEAL_NO '||M_DEAL_NO||'M_INST_TYPE '||M_INST_TYPE||'M_SECURITY_CODE '||M_SECURITY_CODE||'M_SERIAL_NO '||M_SERIAL_NO||' M_SCRP_FACE_VALUE'||TO_CHAR(M_SCRP_FACE_VALUE));

   SELECT
      TO_DATE(TO_CHAR(SYSDATE,'DD-MON-YYYY'),'DD-MON-YYYY'),
      EFF_VALDATE,
      LEND_PORTFOLIO_CODE,
      BORR_PORTFOLIO_CODE,M_MATURITY_DATE
      INTO M_CURR_DATE,M_EFF_VALDATE,
           M_LEND_PORTFOLIO_CODE,M_BORR_PORTFOLIO_CODE,M_MATURITY_DATE
   FROM
      DN_TRN_REPO_ROLLOVER
   WHERE
      DEAL_NO=M_DEAL_NO;

   SELECT
      DATA_FROM,
      INV_STATUS
      INTO M_DATA_FROM,M_INV_STATUS
   FROM
      DN_TRN_REPO_ROLLOVER_SERIAL_NO
   WHERE
      DEAL_NO=M_DEAL_NO
      AND
      INST_TYPE=M_INST_TYPE
      AND
      SECURITY_CODE=M_SECURITY_CODE
      AND
      SERIAL_NO=M_SERIAL_NO;


  IF M_DATA_FROM='BOR' OR M_DATA_FROM='BOI' THEN

------------add a count.----NM-----22-SEP-2000-------
--if COUNT <>0 then

   IF M_EFF_VALDATE<=M_CURR_DATE  THEN

           -- RAISE_APPLICATION_ERROR(-20201,'M_DEAL_NO '||M_DEAL_NO||'M_INST_TYPE '||M_INST_TYPE||'M_SECURITY_CODE '||M_SECURITY_CODE||'M_SERIAL_NO '||M_SERIAL_NO);

           -- Lender information

      -----------// ADDED ON 22/09/2000   //------------

     SELECT COUNT(*)
     INTO   M_COUNT
     FROM DN_INV_REPO_DEAL_SERIAL_NO A
     WHERE
      A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
      AND
      A.INST_TYPE=M_INST_TYPE
      AND
      A.SECURITY_CODE=M_SECURITY_CODE
      AND
      A.DEAL_NO=M_DEAL_NO
      AND
      A.SERIAL_NO=M_SERIAL_NO;

     IF M_COUNT=0 THEN
          IF(M_CURR_CODE<>'SLR')THEN--CURRENCY
              INSERT INTO DN_INV_REPO_DEAL_SERIAL_NO
              (PORTFOLIO_CODE,
               EFF_VALDATE,
               INST_TYPE,
               SECURITY_CODE,
               DEAL_NO,

               SERIAL_NO,
               SCRIP_FACE_VAL,
               FACE_VAL,
               LOCATION,
               RET_DUE_DATE,
               FACE_VAL_CURR--CURRENCY
              )

               SELECT
                  A.PORTFOLIO_CODE,
                  A.EFF_VALDATE,
                  A.INST_TYPE,
                  A.SECURITY_CODE,
                  A.DEAL_NO,
                  M_SERIAL_NO,
                  A.FACE_VAL*(M_SCRP_FACE_VALUE/A.FACE_VAL_CURR),--CURRENCY
                  A.FACE_VAL*(M_SCRP_FACE_VALUE/A.FACE_VAL_CURR),--CURRENCY
                  M_LOCATION,
                  DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,A.SECURITY_CODE),
                  M_SCRP_FACE_VALUE--CURRENCY
              FROM
                  DN_INV_REPO_DEAL_SEC A
               WHERE
                  A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
                  AND
                  A.EFF_VALDATE=M_EFF_VALDATE
                  AND
                  A.INST_TYPE=M_INST_TYPE
                  AND
                  A.SECURITY_CODE=M_SECURITY_CODE
                  AND
                  A.TRN_TYPE='LN'
                  AND
                  A.DEAL_NO=M_DEAL_NO;


          UPDATE  DN_INV_REPO_DEAL_SEC A
          SET (
              A.FACE_VAL,
              A.FACE_VAL_CURR
              )
              =
              (SELECT
                  A.FACE_VAL-B.FACE_VAL,
                  A.FACE_VAL_CURR-B.FACE_VAL_CURR
               FROM
                  DN_INV_REPO_DEAL_SERIAL_NO B
               WHERE
                  B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
                  AND
                  B.EFF_VALDATE=A.EFF_VALDATE
                  AND
                  B.INST_TYPE=A.INST_TYPE
                  AND
                  B.SECURITY_CODE=A.SECURITY_CODE
                  AND
                  B.DEAL_NO=A.DEAL_NO
                  AND
                  B.SERIAL_NO=M_SERIAL_NO)
           WHERE
              A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
              AND
              A.EFF_VALDATE=M_EFF_VALDATE
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.SECURITY_CODE=M_SECURITY_CODE
              AND
              A.DEAL_NO=M_DEAL_NO
              AND
              A.TRN_TYPE='LN';
          ELSE--CURRENCY

             INSERT INTO DN_INV_REPO_DEAL_SERIAL_NO
              (PORTFOLIO_CODE,
               EFF_VALDATE,
               INST_TYPE,
               SECURITY_CODE,
               DEAL_NO,

               SERIAL_NO,
               SCRIP_FACE_VAL,
               FACE_VAL,
               LOCATION,
               RET_DUE_DATE
              )

               SELECT
                  A.PORTFOLIO_CODE,
                  A.EFF_VALDATE,
                  A.INST_TYPE,
                  A.SECURITY_CODE,
                  A.DEAL_NO,
                  M_SERIAL_NO,
                  M_SCRP_FACE_VALUE,
                  M_SCRP_FACE_VALUE,
                  M_LOCATION,
                  DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,A.SECURITY_CODE)
              FROM
                  DN_INV_REPO_DEAL_SEC A
               WHERE
                  A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
                  AND
                  A.EFF_VALDATE=M_EFF_VALDATE
                  AND
                  A.INST_TYPE=M_INST_TYPE
                  AND
                  A.SECURITY_CODE=M_SECURITY_CODE
                  AND
                  A.TRN_TYPE='LN'
                  AND
                  A.DEAL_NO=M_DEAL_NO;


          UPDATE  DN_INV_REPO_DEAL_SEC A
          SET (
              A.FACE_VAL
              )
              =
              (SELECT
                  A.FACE_VAL-B.FACE_VAL
               FROM
                  DN_INV_REPO_DEAL_SERIAL_NO B
               WHERE
                  B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
                  AND
                  B.EFF_VALDATE=A.EFF_VALDATE
                  AND
                  B.INST_TYPE=A.INST_TYPE
                  AND
                  B.SECURITY_CODE=A.SECURITY_CODE
                  AND
                  B.DEAL_NO=A.DEAL_NO
                  AND
                  B.SERIAL_NO=M_SERIAL_NO)
           WHERE
              A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
              AND
              A.EFF_VALDATE=M_EFF_VALDATE
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.SECURITY_CODE=M_SECURITY_CODE
              AND
              A.DEAL_NO=M_DEAL_NO
              AND
              A.TRN_TYPE='LN';
        END IF;--CURRENCY
        END IF;

      -----------// 22/09/2000  END OF //------------
      ELSIF M_EFF_VALDATE>M_CURR_DATE  THEN

         --Lender

         -----------// ADDED ON 22/09/2000   //------------

     SELECT COUNT(*)
     INTO   M_COUNT1
     FROM DN_INV_REPO_DEAL_SERIAL_NO A
     WHERE
      A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
      AND
      A.INST_TYPE=M_INST_TYPE
      AND
      A.SECURITY_CODE=M_SECURITY_CODE
      AND
      A.DEAL_NO=M_DEAL_NO
      AND
      A.SERIAL_NO=M_SERIAL_NO;

IF M_COUNT1=0 THEN
   IF(M_CURR_CODE<>'SLR')THEN--CURRENCY
             INSERT INTO DN_INV_REPO_DEAL_SERIAL_NO
              (PORTFOLIO_CODE,
               EFF_VALDATE,
               INST_TYPE,
               SECURITY_CODE,
               DEAL_NO,

               SERIAL_NO,
               SCRIP_FACE_VAL,
               FWD_RECEIPT,
               LOCATION,
               RET_DUE_DATE,
               FACE_VAL_CURR--CURRENCY
              )
               SELECT
                  A.PORTFOLIO_CODE,
                  A.EFF_VALDATE,
                  A.INST_TYPE,
                  A.SECURITY_CODE,
                  A.DEAL_NO,
                  M_SERIAL_NO,
                  A.FACE_VAL*(M_SCRP_FACE_VALUE/A.FACE_VAL_CURR),--CURRENCY
                  M_SCRP_FACE_VALUE*(M_SCRP_FACE_VALUE/A.FACE_VAL_CURR),--CURRENCY
                  M_LOCATION,
                  DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,A.SECURITY_CODE),
                  M_SCRP_FACE_VALUE--CURRENCY
               FROM
                  DN_INV_REPO_DEAL_SEC A
               WHERE
                  A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
                  AND
                  A.EFF_VALDATE=M_EFF_VALDATE
                  AND
                  A.INST_TYPE=M_INST_TYPE
                  AND
                  A.SECURITY_CODE=M_SECURITY_CODE
                  AND
                  A.TRN_TYPE='LN'
                  AND
                  A.DEAL_NO=M_DEAL_NO;


        /*  UPDATE DN_INV_REPO_DEAL_SEC A
          SET A.FWD_RECEIPT=A.FWD_RECEIPT-(A.FACE_VAL*(M_SCRP_FACE_VALUE/A.FACE_VAL_CURR))--CURRENCY
          WHERE
              A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
              AND
              A.EFF_VALDATE=M_EFF_VALDATE
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.SECURITY_CODE=M_SECURITY_CODE
              AND
              A.DEAL_NO=M_DEAL_NO
              AND
              A.TRN_TYPE='LN';*/


   ELSE--CURRENCY
            INSERT INTO DN_INV_REPO_DEAL_SERIAL_NO
              (PORTFOLIO_CODE,
               EFF_VALDATE,
               INST_TYPE,
               SECURITY_CODE,
               DEAL_NO,

               SERIAL_NO,
               SCRIP_FACE_VAL,
               FWD_RECEIPT,
               LOCATION,
               RET_DUE_DATE
              )
               SELECT
                  A.PORTFOLIO_CODE,
                  A.EFF_VALDATE,
                  A.INST_TYPE,
                  A.SECURITY_CODE,
                  A.DEAL_NO,
                  M_SERIAL_NO,
                  M_SCRP_FACE_VALUE,
                  M_SCRP_FACE_VALUE,
                  M_LOCATION,
                  DN_FIN_RET_DUE_DATE(M_MATURITY_DATE,A.SECURITY_CODE)
               FROM
                  DN_INV_REPO_DEAL_SEC A
               WHERE
                  A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
                  AND
                  A.EFF_VALDATE=M_EFF_VALDATE
                  AND
                  A.INST_TYPE=M_INST_TYPE
                  AND
                  A.SECURITY_CODE=M_SECURITY_CODE
                  AND
                  A.TRN_TYPE='LN'
                  AND
                  A.DEAL_NO=M_DEAL_NO;


          UPDATE DN_INV_REPO_DEAL_SEC A
          SET A.FWD_RECEIPT=A.FWD_RECEIPT-M_SCRP_FACE_VALUE
          WHERE
              A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
              AND
              A.EFF_VALDATE=M_EFF_VALDATE
              AND
              A.INST_TYPE=M_INST_TYPE
              AND
              A.SECURITY_CODE=M_SECURITY_CODE
              AND
              A.DEAL_NO=M_DEAL_NO
              AND
              A.TRN_TYPE='LN';
        END IF;--CURRENCY
        END IF;

        -----------// 22/09/2000 END //----------
    END IF;

ELSIF M_DATA_FROM='FO' THEN

   UPDATE DN_INV_REPO_DEAL_SERIAL_NO A
      SET A.LOCATION=M_LOCATION
   WHERE
      A.PORTFOLIO_CODE=M_LEND_PORTFOLIO_CODE
      AND
      A.EFF_VALDATE=M_EFF_VALDATE
      AND
      A.INST_TYPE=M_INST_TYPE
      AND
      A.SECURITY_CODE=M_SECURITY_CODE
      AND
      A.DEAL_NO=M_DEAL_NO
      AND
      A.SERIAL_NO=M_SERIAL_NO;

END IF;

-- RAISE_APPLICATION_ERROR(-20201,'M_DEAL_NO '||M_DEAL_NO||'M_INST_TYPE '||M_INST_TYPE||'M_SECURITY_CODE '||M_SECURITY_CODE||'M_SERIAL_NO '||M_SERIAL_NO||' INV_STATUS '||M_INV_STATUS);
IF(M_CURR_CODE<>'SLR')THEN--CURRENCY

 IF M_INV_STATUS='N' THEN
      UPDATE DN_TRN_REPO_ROLLOVER_SERIAL_NO
       SET INV_STATUS='Y1'
    WHERE
       DEAL_NO=M_DEAL_NO
       AND
       INST_TYPE=M_INST_TYPE
       AND
       SECURITY_CODE=M_SECURITY_CODE
       AND
       SERIAL_NO=M_SERIAL_NO
       AND
       FACE_VALUE_CURR=M_SCRP_FACE_VALUE--CURRENCY
       AND
       INV_STATUS='N';


 ELSIF M_INV_STATUS='Y1' THEN

    UPDATE DN_TRN_REPO_ROLLOVER_SERIAL_NO
       SET INV_STATUS='Y2'
    WHERE
       DEAL_NO=M_DEAL_NO
       AND
       INST_TYPE=M_INST_TYPE
       AND
       SECURITY_CODE=M_SECURITY_CODE
       AND
       SERIAL_NO=M_SERIAL_NO
       AND
       FACE_VALUE_CURR=M_SCRP_FACE_VALUE--CURRENCY
       AND
       INV_STATUS='Y1';

  ELSIF  M_INV_STATUS='Y2' THEN

    UPDATE DN_TRN_REPO_ROLLOVER_SERIAL_NO
       SET INV_STATUS='Y3'
    WHERE
       DEAL_NO=M_DEAL_NO
       AND
       INST_TYPE=M_INST_TYPE
       AND
       SECURITY_CODE=M_SECURITY_CODE
       AND
       SERIAL_NO=M_SERIAL_NO
       AND
       FACE_VALUE_CURR=M_SCRP_FACE_VALUE--CURRENCY
       AND
       INV_STATUS='Y2';

   END IF;
 ELSE--CURRENCY

 IF M_INV_STATUS='N' THEN

      UPDATE DN_TRN_REPO_ROLLOVER_SERIAL_NO
       SET INV_STATUS='Y1'
    WHERE
       DEAL_NO=M_DEAL_NO
       AND
       INST_TYPE=M_INST_TYPE
       AND
       SECURITY_CODE=M_SECURITY_CODE
       AND
       SERIAL_NO=M_SERIAL_NO
       AND
       FACE_VALUE=M_SCRP_FACE_VALUE
       AND
       INV_STATUS='N';


 ELSIF M_INV_STATUS='Y1' THEN

    UPDATE DN_TRN_REPO_ROLLOVER_SERIAL_NO
       SET INV_STATUS='Y2'
    WHERE
       DEAL_NO=M_DEAL_NO
       AND
       INST_TYPE=M_INST_TYPE
       AND
       SECURITY_CODE=M_SECURITY_CODE
       AND
       SERIAL_NO=M_SERIAL_NO
       AND
       FACE_VALUE=M_SCRP_FACE_VALUE
       AND
       INV_STATUS='Y1';

  ELSIF  M_INV_STATUS='Y2' THEN

    UPDATE DN_TRN_REPO_ROLLOVER_SERIAL_NO
       SET INV_STATUS='Y3'
    WHERE
       DEAL_NO=M_DEAL_NO
       AND
       INST_TYPE=M_INST_TYPE
       AND
       SECURITY_CODE=M_SECURITY_CODE
       AND
       SERIAL_NO=M_SERIAL_NO
       AND
       FACE_VALUE=M_SCRP_FACE_VALUE
       AND
       INV_STATUS='Y2';

   END IF;
 END IF;--CURRENCY
END DN_INV_REPO_RR_DEAL_SERNO_BOR;

/
