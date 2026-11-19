--------------------------------------------------------
--  DDL for Procedure DN_INV_OUTPS_UP_DEAL_SERNO_BOI
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INV_OUTPS_UP_DEAL_SERNO_BOI" 
   (
    M_DEAL_NO            DN_TRN_BO_INV_ISSUE.DEAL_NO%TYPE,
    M_INST_TYPE          DN_TRN_BO_INV_ISSUE.INST_TYPE%TYPE,
    M_SECURITY_CODE      DN_TRN_BO_INV_ISSUE.SECURITY_CODE%TYPE,
    M_SERIAL_NO          DN_TRN_BO_INV_ISSUE.SERIAL_NO%TYPE,
    M_SCRP_FACE_VALUE    DN_TRN_OUTP_SALE_SEC.FACE_VALUE%TYPE,
    M_CURR_CODE               DN_REF_EXCHANGE_RATES.CURR_CODE%TYPE--,--CURRENCY
   )

   IS

    -- Procedue     : Update outright inventory - deal-serial number - BOI
    -- System       : Dealnet system
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 15/07/1999

  M_CURR_DATE             DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE;
  M_EFF_VALDATE           DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE;
  M_DATA_FROM             DN_TRN_OUTP_SALE_SEC.DATA_FROM%TYPE;
  M_INV_STATUS            DN_TRN_OUTP_SALE_SEC.INV_STATUS%TYPE;
  M_BUY_PORTFOLIO_CODE    DN_TRN_OUTP_SALE.BUY_PORTFOLIO_CODE%TYPE;
  M_SELL_PORTFOLIO_CODE   DN_TRN_OUTP_SALE.SELL_PORTFOLIO_CODE%TYPE;
  M_CURR_LEG2_VALUE       DN_TRN_DEAL_CURRENCY.LEG2_VALUE%TYPE;--CURRENCY
  M_COUNT                 NUMBER;

BEGIN

   SELECT
      TO_DATE(TO_CHAR(SYSDATE,'DD-MON-YYYY'),'DD-MON-YYYY'),
      A.EFF_VALDATE,
      A.BUY_PORTFOLIO_CODE,
      A.SELL_PORTFOLIO_CODE
      INTO M_CURR_DATE,M_EFF_VALDATE,
           M_BUY_PORTFOLIO_CODE,M_SELL_PORTFOLIO_CODE
   FROM
      DN_TRN_OUTP_SALE A
   WHERE
      A.DEAL_NO=M_DEAL_NO ;

   SELECT
      DATA_FROM,
      INV_STATUS
      INTO M_DATA_FROM,M_INV_STATUS
   FROM
      DN_TRN_OUTP_SALE_SEC
   WHERE
      DEAL_NO=M_DEAL_NO
      AND
      SECURITY_CODE=M_SECURITY_CODE
      AND
      SERIAL_NO=M_SERIAL_NO;

    IF M_DATA_FROM='BOI' OR M_DATA_FROM='BOR' THEN

--    RAISE_APPLICATION_ERROR(-20201,'M_DEAL_NO '||M_DEAL_NO||'M_INST_TYPE '||M_INST_TYPE||'M_SECURITY_CODE '||M_SECURITY_CODE||'M_SERIAL_NO '||M_SERIAL_NO);

     /* IF(M_CURR_CODE<>'SLR')THEN--CURRENCY

         UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
           SET SALE_DEAL_NO=M_DEAL_NO,
               SALE_EFF_VALDATE=M_EFF_VALDATE,
               SERIAL_NO_STATUS='SAD',
               LOCATION        =M_BUY_PORTFOLIO_CODE
        WHERE
           PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
           AND
           INST_TYPE     =M_INST_TYPE
           AND
           SECURITY_CODE =M_SECURITY_CODE
           AND
           SERIAL_NO     =M_SERIAL_NO
           AND
           FACE_VAL_CURR=M_SCRP_FACE_VALUE --CURRENCY
           AND
           SALE_DEAL_NO  IS NULL
           AND
           SERIAL_NO_STATUS='INV'
           AND
           SALE_EFF_VALDATE IS NULL;
      ELSE--CURRENCY

        UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
           SET SALE_DEAL_NO=M_DEAL_NO,
               SALE_EFF_VALDATE=M_EFF_VALDATE,
               SERIAL_NO_STATUS='SAD',
               LOCATION        =M_BUY_PORTFOLIO_CODE
        WHERE
           PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
           AND
           INST_TYPE     =M_INST_TYPE
           AND
           SECURITY_CODE =M_SECURITY_CODE
           AND
           SERIAL_NO     =M_SERIAL_NO
           AND
           SCRIP_FACE_VAL=M_SCRP_FACE_VALUE
           AND
           SALE_DEAL_NO  IS NULL
           AND
           SERIAL_NO_STATUS='INV'
           AND
           SALE_EFF_VALDATE IS NULL;
END IF;--CURRENCY*/
           IF M_EFF_VALDATE<=M_CURR_DATE  THEN

               ---For the seller  only for new bo serial no

                UPDATE  DN_INV_OUTPS_DEAL_SEC A
                SET (
                    A.FACE_VAL,
                    A.FACE_VAL_CURR--CURRENCY
                    )
                    =
                    (SELECT
                        A.FACE_VAL+B.FACE_VAL,
                        A.FACE_VAL_CURR+B.FACE_VAL_CURR--CURRENCY
                     FROM
                        DN_INV_OUTPS_DEAL_SERIAL_NO B
                     WHERE
                        B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
                        AND
--                        B.EFF_VALDATE=A.EFF_VALDATE
--                        AND
                        B.INST_TYPE=A.INST_TYPE
                        AND
                        B.SECURITY_CODE=A.SECURITY_CODE
--                        AND
--                        B.DEAL_NO=A.DEAL_NO
                        AND
                        B.SERIAL_NO=M_SERIAL_NO
                        AND
                        B.SERIAL_NO_STATUS='INV')--ADDED ON 01-02-2002 BY NIRMALA TO AVOID THE PARTIALLY SAVING OF ISSUES
                 WHERE
                    A.PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
                    AND
                    A.EFF_VALDATE=M_EFF_VALDATE
                    AND
                    A.INST_TYPE=M_INST_TYPE
                    AND
                    A.SECURITY_CODE=M_SECURITY_CODE
                    AND
                    A.DEAL_NO=M_DEAL_NO
                    AND
                    A.TRN_TYPE='S';



-------------------- VC 0307/047 ON 01-09-2003 ---------------
-----THE FOLLOWING SECTION WAS ADDED BY SM ON 14/07/2003

        SELECT COUNT(*)
               INTO M_COUNT
        FROM DN_INV_OUTPS_DEAL_SERIAL_NO B,DN_INV_OUTPS_DEAL_SEC A
              WHERE
                        B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
                        AND
--                        B.EFF_VALDATE=A.EFF_VALDATE
--                        AND
                        B.INST_TYPE=A.INST_TYPE
                        AND
                        B.SECURITY_CODE=A.SECURITY_CODE
--                        AND
--                        B.DEAL_NO=A.DEAL_NO
                        AND
                        B.SERIAL_NO=M_SERIAL_NO
                        AND
                        A.FWD_SALE>=M_SCRP_FACE_VALUE --'=' ADDED ON 25/07/2003 BY SM
                        AND
                         A.PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
                    AND
                    A.EFF_VALDATE=M_EFF_VALDATE
                    AND
                    A.INST_TYPE=M_INST_TYPE
                    AND
                    A.SECURITY_CODE=M_SECURITY_CODE
                    AND
                    A.DEAL_NO=M_DEAL_NO
                    AND
                    A.TRN_TYPE='S';

IF M_COUNT >0 THEN
                UPDATE  DN_INV_OUTPS_DEAL_SEC A
                SET (
                    A.FWD_SALE  ---COMMENT ADDED BY SM ON 25/07/2003 - CONSIDERING "0"
                    )
                    = ( SELECT 0 FROM DUAL);

--REMARKED ON 25/07/2003
/*
                     (SELECT
                        NVL(A.FWD_SALE,0)+NVL(B.FACE_VAL,0) -- CHANGED FROM "B.FWD_SALE" TO "B.FACE_VAL" ON 14/07/2003 BY SM
                     FROM
                        DN_INV_OUTPS_DEAL_SERIAL_NO B
                     WHERE
                        B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
                        AND
--                        B.EFF_VALDATE=A.EFF_VALDATE
--                        AND
                        B.INST_TYPE=A.INST_TYPE
                        AND
                        B.SECURITY_CODE=A.SECURITY_CODE
--                        AND
--                        B.DEAL_NO=A.DEAL_NO
                        AND
                        B.SERIAL_NO=M_SERIAL_NO
                        AND
                        A.FWD_SALE>=M_SCRP_FACE_VALUE)
                 WHERE
                    A.PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
                    AND
                    A.EFF_VALDATE=M_EFF_VALDATE
                    AND
                    A.INST_TYPE=M_INST_TYPE
                    AND
                    A.SECURITY_CODE=M_SECURITY_CODE
                    AND
                    A.DEAL_NO=M_DEAL_NO
                    AND
                    A.TRN_TYPE='S';
*/

----END OF REMARK ON 25/07/2003
END IF;

-----END OF NEW ADDITION BY SM ON 14/07/2003

-------------------- VC 0307/047 ON 01-09-2003 ---------------



           ELSIF M_EFF_VALDATE>M_CURR_DATE  THEN


                UPDATE  DN_INV_OUTPS_DEAL_SEC A
                SET (
                    A.FACE_VAL  -- VC 0307/047 ON 01-09-2003 -- ---CONSIDERING "0" --CHANGED FROM A.FWD_SALE TO A.FACE_VAL
                    )
                    =
                    (SELECT
                         NVL(A.FACE_VAL,0)+NVL(B.FACE_VAL,0) -- VC 0307/047 ON 01-09-2003 -- -- CHANGED FROM "B.FWD_SALE" TO "B.FACE_VAL"   A.FWD_SALE-B.FWD_SALE
                    FROM
                        DN_INV_OUTPS_DEAL_SERIAL_NO B
                     WHERE
                        B.PORTFOLIO_CODE=A.PORTFOLIO_CODE
                        AND
--                        B.EFF_VALDATE=A.EFF_VALDATE
--                        AND
                        B.INST_TYPE=A.INST_TYPE
                        AND
                        B.SECURITY_CODE=A.SECURITY_CODE
--                        AND
--                        B.DEAL_NO=A.DEAL_NO
                        AND
                        B.SERIAL_NO=M_SERIAL_NO
                        AND
                        B.SERIAL_NO_STATUS='INV')--VC03/094
                 WHERE
                    A.PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
                    AND
                    A.EFF_VALDATE=M_EFF_VALDATE
                    AND
                    A.INST_TYPE=M_INST_TYPE
                    AND
                    A.SECURITY_CODE=M_SECURITY_CODE
                    AND
                    A.DEAL_NO=M_DEAL_NO
                    AND
                    A.TRN_TYPE='S';

           END IF;
IF(M_CURR_CODE<>'SLR')THEN--CURRENCY

         UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
           SET SALE_DEAL_NO=M_DEAL_NO,
               SALE_EFF_VALDATE=M_EFF_VALDATE,
               SERIAL_NO_STATUS='SAD',
               LOCATION        =M_BUY_PORTFOLIO_CODE
        WHERE
           PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
           AND
           INST_TYPE     =M_INST_TYPE
           AND
           SECURITY_CODE =M_SECURITY_CODE
           AND
           SERIAL_NO     =M_SERIAL_NO
           AND
           FACE_VAL_CURR=M_SCRP_FACE_VALUE --CURRENCY
           AND
           SALE_DEAL_NO  IS NULL
           AND
           SERIAL_NO_STATUS='INV'
           AND
           SALE_EFF_VALDATE IS NULL;
      ELSE--CURRENCY

        UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
           SET SALE_DEAL_NO=M_DEAL_NO,
               SALE_EFF_VALDATE=M_EFF_VALDATE,
               SERIAL_NO_STATUS='SAD',
               LOCATION        =M_BUY_PORTFOLIO_CODE
        WHERE
           PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
           AND
           INST_TYPE     =M_INST_TYPE
           AND
           SECURITY_CODE =M_SECURITY_CODE
           AND
           SERIAL_NO     =M_SERIAL_NO
           AND
           SCRIP_FACE_VAL=M_SCRP_FACE_VALUE
           AND
           SALE_DEAL_NO  IS NULL
           AND
           SERIAL_NO_STATUS='INV'
           AND
           SALE_EFF_VALDATE IS NULL;
END IF;--CURRENCY
--    ELSIF M_DATA_FROM='FO' AND M_INV_STATUS='Y1' THEN
    ELSIF M_DATA_FROM='FO' THEN

 IF M_CURR_CODE <>'SLR' THEN--CURRENCY
       UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
           SET SERIAL_NO_STATUS='SAD',
               LOCATION        =M_BUY_PORTFOLIO_CODE
        WHERE
           PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
           AND
           INST_TYPE     =M_INST_TYPE
           AND
           SECURITY_CODE =M_SECURITY_CODE
           AND
           SERIAL_NO     =M_SERIAL_NO
           AND
           SALE_DEAL_NO     =M_DEAL_NO
           AND
           FACE_VAL_CURR=M_SCRP_FACE_VALUE;--CURRENCY

 ELSE--CURRENCY

        UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
           SET SERIAL_NO_STATUS='SAD',
               LOCATION        =M_BUY_PORTFOLIO_CODE
        WHERE
           PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
           AND
           INST_TYPE     =M_INST_TYPE
           AND
           SECURITY_CODE =M_SECURITY_CODE
           AND
           SERIAL_NO     =M_SERIAL_NO
           AND
           SALE_DEAL_NO     =M_DEAL_NO
           AND
           SCRIP_FACE_VAL=M_SCRP_FACE_VALUE;
    END IF;--CURRENCY
    END IF;


 IF (M_CURR_CODE <>'SLR') THEN--CURRENCY
    IF M_INV_STATUS='N' THEN

    UPDATE DN_TRN_OUTP_SALE_SEC
       SET INV_STATUS='Y1'
    WHERE
       DEAL_NO=M_DEAL_NO
       AND
       SECURITY_CODE=M_SECURITY_CODE
       AND
       SERIAL_NO=M_SERIAL_NO
       AND
       FACE_VALUE_CURR=M_SCRP_FACE_VALUE--CURRENCY
       AND
       INV_STATUS='N';


 ELSIF M_INV_STATUS='Y1' THEN

    UPDATE DN_TRN_OUTP_SALE_SEC
       SET INV_STATUS='Y2'
    WHERE
       DEAL_NO=M_DEAL_NO
       AND
       SECURITY_CODE=M_SECURITY_CODE
       AND
       SERIAL_NO=M_SERIAL_NO
       AND
       FACE_VALUE_CURR=M_SCRP_FACE_VALUE--CURRENCY
       AND
       INV_STATUS='Y1';

  ELSIF  M_INV_STATUS='Y2' THEN

    UPDATE DN_TRN_OUTP_SALE_SEC
       SET INV_STATUS='Y3'
    WHERE
       DEAL_NO=M_DEAL_NO
       AND
       SECURITY_CODE=M_SECURITY_CODE
       AND
       SERIAL_NO=M_SERIAL_NO
       AND
       FACE_VALUE_CURR=M_SCRP_FACE_VALUE----CURRENCY
       AND
       INV_STATUS='Y2';

 END IF;

 ELSE--CURRENCY

 IF M_INV_STATUS='N' THEN

    UPDATE DN_TRN_OUTP_SALE_SEC
       SET INV_STATUS='Y1'
    WHERE
       DEAL_NO=M_DEAL_NO
       AND
       SECURITY_CODE=M_SECURITY_CODE
       AND
       SERIAL_NO=M_SERIAL_NO
       AND
       FACE_VALUE=M_SCRP_FACE_VALUE
       AND
       INV_STATUS='N';


 ELSIF M_INV_STATUS='Y1' THEN

    UPDATE DN_TRN_OUTP_SALE_SEC
       SET INV_STATUS='Y2'
    WHERE
       DEAL_NO=M_DEAL_NO
       AND
       SECURITY_CODE=M_SECURITY_CODE
       AND
       SERIAL_NO=M_SERIAL_NO
       AND
       FACE_VALUE=M_SCRP_FACE_VALUE
       AND
       INV_STATUS='Y1';

  ELSIF  M_INV_STATUS='Y2' THEN

    UPDATE DN_TRN_OUTP_SALE_SEC
       SET INV_STATUS='Y3'
    WHERE
       DEAL_NO=M_DEAL_NO
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

END DN_INV_OUTPS_UP_DEAL_SERNO_BOI;

/
