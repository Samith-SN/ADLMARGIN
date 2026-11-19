--------------------------------------------------------
--  DDL for Procedure DN_INV_OUTPS_UP_SUM_SEC_SELL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_OUTPS_UP_SUM_SEC_SELL" 
   (
    M_DEAL_NO      DN_TRN_OUTP_SALE.DEAL_NO%TYPE
   )

   IS


    -- Procedure    : Update outright inventory - summery security level - seller
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 09/07/1999

  M_CURR_DATE               DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE;
  M_EFF_VALDATE             DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE;
  M_INST_TYPE               DN_TRN_OUTP_SALE.INST_TYPE%TYPE;
  M_SECURITY_CODE           DN_TRN_OUTP_SALE.SECURITY_CODE%TYPE;
  M_SELL_PORTFOLIO_CODE     DN_TRN_OUTP_SALE.SELL_PORTFOLIO_CODE%TYPE;
  M_MATURITY_DATE           DN_REF_SECURITY.MATURITY_DATE%TYPE;
  M_PREV_DATE               DN_REF_SECURITY.MATURITY_DATE%TYPE;

BEGIN

   SELECT
      TO_DATE(TO_CHAR(SYSDATE,'DD-MON-YYYY'),'DD-MON-YYYY'),
      A.EFF_VALDATE,B.MATURITY_DATE,A.SELL_PORTFOLIO_CODE,
      A.INST_TYPE,A.SECURITY_CODE
      INTO M_CURR_DATE,M_EFF_VALDATE,
           M_MATURITY_DATE,M_SELL_PORTFOLIO_CODE,
           M_INST_TYPE,M_SECURITY_CODE
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_SECURITY B
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      A.SECURITY_CODE=B.SECURITY_CODE;

   IF M_EFF_VALDATE<=M_CURR_DATE  THEN

     UPDATE DN_INV_OUTPS_SUM_SEC A
      SET (A.FACE_VAL
          )
          =
          (SELECT
             A.FACE_VAL      +B.FACE_VAL
           FROM
              DN_INV_OUTPS_DEAL_SEC  B
           WHERE
              B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
              AND
              B.EFF_VALDATE=A.EFF_VALDATE
              AND
              B.INST_TYPE=A.INST_TYPE
              AND
              B.SECURITY_CODE=A.SECURITY_CODE
              AND
              B.DEAL_NO=M_DEAL_NO
              AND
              B.TRN_TYPE='S')

     WHERE
        A.PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
        AND
        A.EFF_VALDATE=M_EFF_VALDATE
        AND
        A.INST_TYPE=M_INST_TYPE
        AND
        A.SECURITY_CODE=M_SECURITY_CODE;

   IF SQL%NOTFOUND THEN

      SELECT
         DN_INV_OUTP_SUM_SEC_PREV_DATE(M_SELL_PORTFOLIO_CODE,M_EFF_VALDATE,M_INST_TYPE,M_SECURITY_CODE)
         INTO M_PREV_DATE
      FROM DUAL;

      INSERT INTO DN_INV_OUTPS_SUM_SEC A
          (A.PORTFOLIO_CODE,
           A.EFF_VALDATE,
           A.INST_TYPE,
           A.SECURITY_CODE,
           A.FACE_VAL,
           A.FWD_SALE,
           A.FWD_PURCHASE
           )

         SELECT
            B.PORTFOLIO_CODE,
            B.EFF_VALDATE,
            B.INST_TYPE,
            B.SECURITY_CODE,
            NVL(C.FACE_VAL,0)+B.FACE_VAL,
            NVL(C.FWD_SALE,0),
            NVL(C.FWD_PURCHASE,0)
         FROM
            DN_INV_OUTPS_DEAL_SEC  B,
            DN_INV_OUTPS_SUM_SEC C
         WHERE
            B.PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
            AND
            B.EFF_VALDATE=M_EFF_VALDATE
            AND
            B.INST_TYPE=M_INST_TYPE
            AND
            B.SECURITY_CODE=M_SECURITY_CODE
            AND
            B.DEAL_NO=M_DEAL_NO
            AND
            B.TRN_TYPE='S'
            AND
            B.PORTFOLIO_CODE=C.PORTFOLIO_CODE(+)
            AND
            B.INST_TYPE=C.INST_TYPE(+)
            AND
            B.SECURITY_CODE=C.SECURITY_CODE(+)
            AND
            C.EFF_VALDATE(+)=M_PREV_DATE;

   END IF;

   -- Update future transaction for the SELLER

     UPDATE DN_INV_OUTPS_SUM_SEC A
      SET (A.FACE_VAL
          )
          =
          (SELECT
             A.FACE_VAL      +B.FACE_VAL
           FROM
              DN_INV_OUTPS_DEAL_SEC  B
           WHERE
              B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
              AND
              B.EFF_VALDATE=M_EFF_VALDATE
              AND
              B.INST_TYPE=A.INST_TYPE
              AND
              B.SECURITY_CODE=A.SECURITY_CODE
              AND
              B.DEAL_NO=M_DEAL_NO
              AND
              B.TRN_TYPE='S')

     WHERE
        A.PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
        AND
        A.EFF_VALDATE>M_EFF_VALDATE
        AND
        A.INST_TYPE=M_INST_TYPE
        AND
        A.SECURITY_CODE=M_SECURITY_CODE
        AND
        A.EFF_VALDATE<M_MATURITY_DATE;


     UPDATE DN_INV_OUTPS_SUM_SEC A
      SET (A.FACE_VAL
          )
          =
          (SELECT
             A.FACE_VAL      +B.FACE_VAL
           FROM
              DN_INV_OUTPS_DEAL_SEC  B
           WHERE
              B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
              AND
              B.EFF_VALDATE=M_EFF_VALDATE
              AND
              B.INST_TYPE=A.INST_TYPE
              AND
              B.SECURITY_CODE=A.SECURITY_CODE
              AND
              B.DEAL_NO=M_DEAL_NO
              AND
              B.TRN_TYPE='S')

     WHERE
        A.PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
        AND
        A.EFF_VALDATE=M_MATURITY_DATE
        AND
        A.INST_TYPE=M_INST_TYPE
        AND
        A.SECURITY_CODE=M_SECURITY_CODE;

     IF SQL%NOTFOUND THEN

        --On maturity date

      INSERT INTO DN_INV_OUTPS_SUM_SEC A
          (A.PORTFOLIO_CODE,
           A.EFF_VALDATE,
           A.INST_TYPE,
           A.SECURITY_CODE,
           A.FACE_VAL
           )
         SELECT
            B.PORTFOLIO_CODE,
            M_MATURITY_DATE,
            B.INST_TYPE,
            B.SECURITY_CODE,
            B.FACE_VAL
         FROM
            DN_INV_OUTPS_DEAL_SEC  B
         WHERE
            B.PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
            AND
            B.EFF_VALDATE=M_EFF_VALDATE
            AND
            B.INST_TYPE=M_INST_TYPE
            AND
            B.SECURITY_CODE=M_SECURITY_CODE
            AND
            B.DEAL_NO=M_DEAL_NO
            AND
            B.TRN_TYPE='S';

     END IF;


   ELSIF M_EFF_VALDATE>M_CURR_DATE  THEN

      -- Buyer on current date

         UPDATE DN_INV_OUTPS_SUM_SEC A
          SET (A.FWD_SALE
              )
              =
              (SELECT
                  A.FWD_SALE+B.FWD_SALE
               FROM
                  DN_INV_OUTPS_DEAL_SEC  B
               WHERE
                  B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
                  AND
                  B.EFF_VALDATE=M_EFF_VALDATE
                  AND
                  B.INST_TYPE=A.INST_TYPE
                  AND
                  B.SECURITY_CODE=A.SECURITY_CODE
                  AND
                  B.DEAL_NO=M_DEAL_NO
                  AND
                  B.TRN_TYPE='S')
         WHERE
            A.PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
            AND
            A.EFF_VALDATE=M_CURR_DATE
            AND
            A.INST_TYPE=M_INST_TYPE
            AND
            A.SECURITY_CODE=M_SECURITY_CODE;

      IF SQL%NOTFOUND THEN

      SELECT
         DN_INV_OUTP_SUM_SEC_PREV_DATE(M_SELL_PORTFOLIO_CODE,M_CURR_DATE,M_INST_TYPE,M_SECURITY_CODE)
         INTO M_PREV_DATE
      FROM DUAL;

      INSERT INTO DN_INV_OUTPS_SUM_SEC A
          (A.PORTFOLIO_CODE,
           A.EFF_VALDATE,
           A.INST_TYPE,
           A.SECURITY_CODE,
           A.FACE_VAL,
           A.FWD_SALE,
           A.FWD_PURCHASE
           )

         SELECT
            B.PORTFOLIO_CODE,
            M_CURR_DATE,
            B.INST_TYPE,
            B.SECURITY_CODE,
            NVL(C.FACE_VAL,0),
            NVL(C.FWD_SALE,0)+B.FWD_SALE,
            NVL(C.FWD_PURCHASE,0)
         FROM
            DN_INV_OUTPS_DEAL_SEC  B,
            DN_INV_OUTPS_SUM_SEC C
         WHERE
            B.PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
            AND
            B.EFF_VALDATE=M_EFF_VALDATE
            AND
            B.INST_TYPE=M_INST_TYPE
            AND
            B.SECURITY_CODE=M_SECURITY_CODE
            AND
            B.DEAL_NO=M_DEAL_NO
            AND
            B.TRN_TYPE='S'
            AND
            B.PORTFOLIO_CODE=C.PORTFOLIO_CODE(+)
            AND
            B.INST_TYPE=C.INST_TYPE(+)
            AND
            B.SECURITY_CODE=C.SECURITY_CODE(+)
            AND
            C.EFF_VALDATE(+)=M_PREV_DATE;

      END IF;

         UPDATE DN_INV_OUTPS_SUM_SEC A
          SET (A.FWD_SALE
              )
              =
              (SELECT
                  A.FWD_SALE+B.FWD_SALE
               FROM
                  DN_INV_OUTPS_DEAL_SEC  B
               WHERE
                  B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
                  AND
                  B.EFF_VALDATE=M_EFF_VALDATE
                  AND
                  B.INST_TYPE=A.INST_TYPE
                  AND
                  B.SECURITY_CODE=A.SECURITY_CODE
                  AND
                  B.DEAL_NO=M_DEAL_NO
                  AND
                  B.TRN_TYPE='S')
         WHERE
            A.PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
            AND
            A.EFF_VALDATE>M_CURR_DATE
            AND
            A.EFF_VALDATE<M_EFF_VALDATE
            AND
            A.INST_TYPE=M_INST_TYPE
            AND
            A.SECURITY_CODE=M_SECURITY_CODE;

       -- face value on effective value date

        UPDATE DN_INV_OUTPS_SUM_SEC A
          SET (A.FACE_VAL
              )
              =
              (SELECT
                  A.FACE_VAL+B.FWD_SALE
               FROM
                  DN_INV_OUTPS_DEAL_SEC  B
               WHERE
                  B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
                  AND
                  B.EFF_VALDATE=M_EFF_VALDATE
                  AND
                  B.INST_TYPE=A.INST_TYPE
                  AND
                  B.SECURITY_CODE=A.SECURITY_CODE
                  AND
                  B.DEAL_NO=M_DEAL_NO
                  AND
                  B.TRN_TYPE='S')
         WHERE
            A.PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
            AND
            A.EFF_VALDATE=M_EFF_VALDATE
            AND
            A.INST_TYPE=M_INST_TYPE
            AND
            A.SECURITY_CODE=M_SECURITY_CODE;

      IF SQL%NOTFOUND THEN

      SELECT
         DN_INV_OUTP_SUM_SEC_PREV_DATE(M_SELL_PORTFOLIO_CODE,M_EFF_VALDATE,M_INST_TYPE,M_SECURITY_CODE)
         INTO M_PREV_DATE
      FROM DUAL;

      INSERT INTO DN_INV_OUTPS_SUM_SEC A
          (A.PORTFOLIO_CODE,
           A.EFF_VALDATE,
           A.INST_TYPE,
           A.SECURITY_CODE,
           A.FACE_VAL,
           A.FWD_SALE,
           A.FWD_PURCHASE
           )

         SELECT
            B.PORTFOLIO_CODE,
            B.EFF_VALDATE,
            B.INST_TYPE,
            B.SECURITY_CODE,
            NVL(C.FACE_VAL,0)+B.FWD_SALE,
            NVL(C.FWD_SALE,0),
            NVL(C.FWD_PURCHASE,0)-B.FWD_SALE
         FROM
            DN_INV_OUTPS_DEAL_SEC  B,
            DN_INV_OUTPS_SUM_SEC C
         WHERE
            B.PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
            AND
            B.EFF_VALDATE=M_EFF_VALDATE
            AND
            B.INST_TYPE=M_INST_TYPE
            AND
            B.SECURITY_CODE=M_SECURITY_CODE
            AND
            B.DEAL_NO=M_DEAL_NO
            AND
            B.TRN_TYPE='S'
            AND
            B.PORTFOLIO_CODE=C.PORTFOLIO_CODE(+)
            AND
            B.INST_TYPE=C.INST_TYPE(+)
            AND
            B.SECURITY_CODE=C.SECURITY_CODE(+)
            AND
            C.EFF_VALDATE(+)=M_PREV_DATE;

      END IF;

    -- face value from effective value date to maturity date

      UPDATE DN_INV_OUTPS_SUM_SEC A
      SET (A.FACE_VAL
          )
          =
          (SELECT
             A.FACE_VAL      +B.FWD_SALE
           FROM
              DN_INV_OUTPS_DEAL_SEC  B
           WHERE
              B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
              AND
              B.EFF_VALDATE=M_EFF_VALDATE
              AND
              B.INST_TYPE=A.INST_TYPE
              AND
              B.SECURITY_CODE=A.SECURITY_CODE
              AND
              B.DEAL_NO=M_DEAL_NO
              AND
              B.TRN_TYPE='S')

     WHERE
        A.PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
        AND
        A.EFF_VALDATE>M_EFF_VALDATE
        AND
        A.INST_TYPE=M_INST_TYPE
        AND
        A.SECURITY_CODE=M_SECURITY_CODE
        AND
        A.EFF_VALDATE<M_MATURITY_DATE;

       -- on maturity date

        UPDATE DN_INV_OUTPS_SUM_SEC A
          SET (A.FACE_VAL
              )
              =
              (SELECT
                  A.FACE_VAL+B.FWD_SALE
               FROM
                  DN_INV_OUTPS_DEAL_SEC  B
               WHERE
                  B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
                  AND
                  B.EFF_VALDATE=M_EFF_VALDATE
                  AND
                  B.INST_TYPE=A.INST_TYPE
                  AND
                  B.SECURITY_CODE=A.SECURITY_CODE
                  AND
                  B.DEAL_NO=M_DEAL_NO
                  AND
                  B.TRN_TYPE='S')
         WHERE
            A.PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
            AND
            A.EFF_VALDATE=M_MATURITY_DATE
            AND
            A.INST_TYPE=M_INST_TYPE
            AND
            A.SECURITY_CODE=M_SECURITY_CODE;

      IF SQL%NOTFOUND THEN

       INSERT INTO DN_INV_OUTPS_SUM_SEC A
          (A.PORTFOLIO_CODE,
           A.EFF_VALDATE,
           A.INST_TYPE,
           A.SECURITY_CODE,
           A.FACE_VAL
           )
         SELECT
            B.PORTFOLIO_CODE,
            M_MATURITY_DATE,
            B.INST_TYPE,
            B.SECURITY_CODE,
            B.FWD_SALE
         FROM
            DN_INV_OUTPS_DEAL_SEC  B
         WHERE
            B.PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
            AND
            B.EFF_VALDATE=M_EFF_VALDATE
            AND
            B.INST_TYPE=M_INST_TYPE
            AND
            B.SECURITY_CODE=M_SECURITY_CODE
            AND
            B.DEAL_NO=M_DEAL_NO
            AND
            B.TRN_TYPE='S';

      END IF;

   END IF;

END DN_INV_OUTPS_UP_SUM_SEC_SELL;

/
