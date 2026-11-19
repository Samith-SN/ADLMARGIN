--------------------------------------------------------
--  DDL for Procedure DN_LIMIT_POSSI_OUTRIGHT_MODI
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_LIMIT_POSSI_OUTRIGHT_MODI" 
(
    M_DATE                          DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE,
    M_DEAL_NO                       DN_TRN_OUTP_SALE.DEAL_NO%TYPE,
    M_BUY_PORTFOLIO_CODE            DN_TRN_OUTP_SALE.BUY_PORTFOLIO_CODE%TYPE,
    M_SELL_PORTFOLIO_CODE           DN_TRN_OUTP_SALE.SELL_PORTFOLIO_CODE%TYPE,
    M_FACE_VALUE                    DN_TRN_OUTP_SALE.FACE_VALUE%TYPE,
    M_SECURITY_CODE				    DN_TRN_OUTP_SALE.SECURITY_CODE%TYPE,
    CUR_LIMIT_DETAILS        IN OUT DN_PACKAGE_OUTRIGHT.LIMIT_DETAILS
)
AS
    /*        Procedue     : USED TO IDENTIFY POSSIBLE VIOLATION FOR OUTRIGHT-MODIFICATION TRADING
              System       : Dealnet system
              Created by   : V.Sukathis
              Created on   : 25/02/2000	    */

    M_INFLOW            DN_TRN_OUTP_SALE.FACE_VALUE%TYPE;
    M_OUTFLOW           DN_TRN_OUTP_SALE.FACE_VALUE%TYPE;
    M_INFLOW_MODI       DN_TRN_OUTP_SALE.FACE_VALUE%TYPE;
    M_OUTFLOW_MODI      DN_TRN_OUTP_SALE.FACE_VALUE%TYPE;
    M_TENOR             NUMBER;
    M_TENOR_MODI        NUMBER;
    M_COUNT_INFLOW      NUMBER;
    M_COUNT_OUTFLOW     NUMBER;
    M_COUNT_UTI         NUMBER;
    M_COUNT             NUMBER;
    M_END_AMOUNT        NUMBER;
    M_CURRENT_UTI_OVRL  DN_TRN_OUTP_SALE.FACE_VALUE%TYPE;
    M_CURRENT_UTI_MATU  DN_TRN_OUTP_SALE.FACE_VALUE%TYPE;
    M_CURRENT_UTI_EXPO  DN_TRN_OUTP_SALE.FACE_VALUE%TYPE;
    CHK_LIMIT_CODE      VARCHAR2(1);
    M_CONDITION         VARCHAR2(1);
    M_LIMIT_CODE        LMT_ACT_DETAILS.LIMIT_CODE%TYPE;
    M_DATE_TO_CHAR      VARCHAR2(10);
    M_SYSDATE_TO_CHAR   VARCHAR2(10);


BEGIN
--RAISE_APPLICATION_ERROR(-20201,'2222******** ');
    M_INFLOW:=0;
    M_OUTFLOW:=0;
    M_INFLOW_MODI:=0;
    M_OUTFLOW_MODI:=0;

    SELECT TO_CHAR(M_DATE,'DD/MM/YYYY') INTO M_DATE_TO_CHAR FROM DUAL;
    SELECT TO_CHAR(SYSDATE,'DD/MM/YYYY') INTO M_SYSDATE_TO_CHAR FROM DUAL;

    --TO CONSIDER ONYL CASH TRANSACTION
    IF (M_DATE_TO_CHAR=M_SYSDATE_TO_CHAR) THEN
        SELECT COUNT(*) INTO M_COUNT_INFLOW
      	   FROM
      	      DN_REF_PORTFOLIO B
      	   WHERE
      	      B.PORTFOLIO_CODE=M_BUY_PORTFOLIO_CODE
      	      AND
      	      B.PF_TYPE='P'
              AND
              B.OWNED_BY_MBFSL='Y';
              IF (M_COUNT_INFLOW>0) THEN
                M_INFLOW:=M_FACE_VALUE;
                SELECT (MATURITY_DATE-TO_DATE(TO_CHAR(SYSDATE,'DD/MON/YYYY'),'DD/MM/YYYY'))
                INTO
                    M_TENOR
                FROM
                    DN_REF_SECURITY
                WHERE
                    SECURITY_CODE=
                    ( SELECT SECURITY_CODE FROM DN_TRN_OUTP_SALE
                      WHERE DEAL_NO=M_DEAL_NO );
              END IF;

        SELECT COUNT(*) INTO M_COUNT_OUTFLOW
      	   FROM
      	      DN_REF_PORTFOLIO B
      	   WHERE
      	      B.PORTFOLIO_CODE=M_SELL_PORTFOLIO_CODE
      	      AND
      	      B.PF_TYPE='P'
              AND
              B.OWNED_BY_MBFSL='Y';
              IF (M_COUNT_OUTFLOW>0) THEN
                M_OUTFLOW:=M_FACE_VALUE;
                SELECT (MATURITY_DATE-TO_DATE(TO_CHAR(SYSDATE,'DD/MON/YYYY'),'DD/MM/YYYY'))
                INTO
                    M_TENOR
                FROM
                    DN_REF_SECURITY
                WHERE
                    SECURITY_CODE=
                    ( SELECT SECURITY_CODE FROM DN_TRN_OUTP_SALE
                      WHERE DEAL_NO=M_DEAL_NO );
              END IF;
     END IF;


    SELECT COUNT(*) INTO M_COUNT_INFLOW
  	   FROM
  	      DN_TRN_OUTP_SALE A,
          DN_REF_PORTFOLIO B
  	   WHERE
  	      A.DEAL_NO=M_DEAL_NO
          AND
          B.PORTFOLIO_CODE=A.BUY_PORTFOLIO_CODE
  	      AND
  	      B.PF_TYPE='P'
          AND
          B.OWNED_BY_MBFSL='Y'
          AND
          TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY');
          IF (M_COUNT_INFLOW>0) THEN
            SELECT
                 FACE_VALUE INTO M_INFLOW_MODI
  	        FROM
  	             DN_TRN_OUTP_SALE A
  	        WHERE
  	             A.DEAL_NO=M_DEAL_NO;
          END IF;

    SELECT COUNT(*) INTO M_COUNT_OUTFLOW
  	   FROM
  	      DN_TRN_OUTP_SALE A,
          DN_REF_PORTFOLIO B
  	   WHERE
  	      A.DEAL_NO=M_DEAL_NO
          AND
          B.PORTFOLIO_CODE=A.SELL_PORTFOLIO_CODE
  	      AND
  	      B.PF_TYPE='P'
          AND
          B.OWNED_BY_MBFSL='Y'
          AND
          TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY');
          IF (M_COUNT_INFLOW>0) THEN
            SELECT
                 FACE_VALUE INTO M_OUTFLOW_MODI
  	        FROM
  	             DN_TRN_OUTP_SALE A
  	        WHERE
  	             A.DEAL_NO=M_DEAL_NO;
          END IF;

    SELECT (MATURITY_DATE-TO_DATE(TO_CHAR(SYSDATE,'DD/MON/YYYY'),'DD/MM/YYYY')) INTO M_TENOR_MODI
        FROM DN_REF_SECURITY WHERE SECURITY_CODE=M_SECURITY_CODE;

--    OVERALL TRADING

    SELECT COUNT(*) INTO M_COUNT_UTI
      FROM LMT_UTL_OVRL_TRA;
        IF (M_COUNT_UTI>0) THEN
          	SELECT CURRENT_UTILIZATION INTO M_CURRENT_UTI_OVRL
          		FROM LMT_UTL_OVRL_TRA;
        ELSE
            M_CURRENT_UTI_OVRL:=0;
        END IF;
    M_CURRENT_UTI_OVRL:=(M_CURRENT_UTI_OVRL+M_INFLOW-M_OUTFLOW-M_INFLOW_MODI+M_OUTFLOW_MODI);

    IF (M_CURRENT_UTI_OVRL>0) THEN
        SELECT COUNT(*) INTO M_COUNT FROM LMT_ACT_DETAILS
        WHERE LIMIT_TYPE='01' AND ACTIVE_STATUS='Y';
        IF (M_COUNT>0)THEN
            SELECT MAX(LIMIT_CODE) INTO M_LIMIT_CODE
            FROM LMT_ACT_DETAILS
            WHERE LIMIT_TYPE='01'
            AND ACTIVE_STATUS='Y';

            CHK_LIMIT_CODE:='Y';
        ELSE
            SELECT MIN(LIMIT_CODE) INTO M_LIMIT_CODE FROM LMT_STR_OVRL_AMT;
            CHK_LIMIT_CODE:='N';
        END IF;

        IF (CHK_LIMIT_CODE='Y') THEN
            SELECT CONDITION INTO M_CONDITION FROM LMT_STR_OVRL_AMT
            WHERE LIMIT_CODE=M_LIMIT_CODE;
            IF (M_CONDITION='B') THEN
                SELECT END_AMOUNT INTO M_END_AMOUNT FROM LMT_STR_OVRL_AMT
                WHERE LIMIT_CODE=M_LIMIT_CODE;
                IF (M_CURRENT_UTI_OVRL>M_END_AMOUNT)THEN
                    INSERT INTO LMT_POSSIBLE_OUTRIGHT
                    (LIMIT_CODE,
                     START_DAYS,
                     END_DAYS,START_AMOUNT,
                     END_AMOUNT,
                     CURRENT_UTILIZATION)
                     SELECT DISTINCT
                        LIMIT_CODE,
                        0,
                        0,
                        START_AMOUNT,
                        END_AMOUNT,
                        M_CURRENT_UTI_OVRL
                        FROM LMT_STR_OVRL_AMT  WHERE LIMIT_CODE=M_LIMIT_CODE;
                END IF;
            END IF;

        ELSIF (CHK_LIMIT_CODE='N') THEN
              INSERT INTO LMT_POSSIBLE_OUTRIGHT
              (LIMIT_CODE,
               START_DAYS,
               END_DAYS,
               START_AMOUNT,
               END_AMOUNT,
               CURRENT_UTILIZATION)
                      SELECT DISTINCT
                        LIMIT_CODE,
                        0,
                        0,
                        START_AMOUNT,
                        END_AMOUNT,
                        M_CURRENT_UTI_OVRL
                        FROM LMT_STR_OVRL_AMT WHERE LIMIT_CODE=M_LIMIT_CODE;
        END IF;
    END IF;
  --    OVERALL MATURITY

    SELECT COUNT(*) INTO M_COUNT_UTI
        FROM LMT_UTL_OVRL_MAT
        WHERE M_TENOR BETWEEN START_DAYS AND END_DAYS;
        IF (M_COUNT_UTI>0) THEN
          	SELECT CURRENT_UTILIZATION INTO M_CURRENT_UTI_MATU
          		FROM LMT_UTL_OVRL_MAT
                WHERE M_TENOR BETWEEN START_DAYS AND END_DAYS;
        ELSE
            M_CURRENT_UTI_MATU:=0;
        END IF;
     M_CURRENT_UTI_MATU:=(M_CURRENT_UTI_MATU+M_INFLOW-M_OUTFLOW);

     IF (M_CURRENT_UTI_MATU>0) THEN
        SELECT COUNT(*) INTO M_COUNT FROM LMT_ACT_DETAILS
            WHERE LIMIT_TYPE='02'
            AND ACTIVE_STATUS='Y'
            AND LIMIT_CODE IN
            ( SELECT LIMIT_CODE FROM LMT_STR_OVRL_MATU WHERE
              M_TENOR BETWEEN START_DAYS
              AND END_DAYS );
            IF (M_COUNT>0)THEN
                SELECT MAX(LIMIT_CODE) INTO M_LIMIT_CODE
                  FROM LMT_ACT_DETAILS
                  WHERE LIMIT_TYPE='02'
                  AND ACTIVE_STATUS='Y'
                  AND LIMIT_CODE IN
                  ( SELECT LIMIT_CODE FROM LMT_STR_OVRL_MATU
                    WHERE M_TENOR BETWEEN START_DAYS AND END_DAYS );

                CHK_LIMIT_CODE:='Y';
            ELSE
                SELECT MIN(LIMIT_CODE) INTO M_LIMIT_CODE
                  FROM LMT_STR_OVRL_MATU
                  WHERE M_TENOR BETWEEN START_DAYS AND END_DAYS;

                CHK_LIMIT_CODE:='N';
            END IF;

            IF (CHK_LIMIT_CODE='Y') THEN
                SELECT CONDITION INTO M_CONDITION FROM LMT_STR_OVRL_MATU
                WHERE LIMIT_CODE=M_LIMIT_CODE;
                IF (M_CONDITION='B') THEN
                    SELECT END_AMOUNT INTO M_END_AMOUNT FROM LMT_STR_OVRL_MATU
                    WHERE LIMIT_CODE=M_LIMIT_CODE;
                    IF (M_CURRENT_UTI_MATU>M_END_AMOUNT)THEN
                        INSERT INTO LMT_POSSIBLE_OUTRIGHT
                        (LIMIT_CODE,
                         START_DAYS,
                         END_DAYS,
                         START_AMOUNT,
                         END_AMOUNT,
                         CURRENT_UTILIZATION)
                          SELECT DISTINCT
                            LIMIT_CODE,
                            DN_LIMIT_MATU_FIN_START_DAYS(M_TENOR),
                            DN_LIMIT_MATU_FIN_END_DAYS(M_TENOR),
                            START_AMOUNT,
                            END_AMOUNT,
                            M_CURRENT_UTI_MATU
                            FROM LMT_STR_OVRL_MATU WHERE LIMIT_CODE=M_LIMIT_CODE;
                    END IF;
                --IF M_CONDITION='G' NO VIOLATION
                END IF;

            ELSIF (CHK_LIMIT_CODE='N') THEN
                  INSERT INTO LMT_POSSIBLE_OUTRIGHT
                  (LIMIT_CODE,
                   START_DAYS,
                   END_DAYS,
                   START_AMOUNT,
                   END_AMOUNT,
                   CURRENT_UTILIZATION)
                          SELECT DISTINCT
                            LIMIT_CODE,
                            DN_LIMIT_MATU_FIN_START_DAYS(M_TENOR),
                            DN_LIMIT_MATU_FIN_END_DAYS(M_TENOR),
                            START_AMOUNT,
                            END_AMOUNT,
                            M_CURRENT_UTI_MATU
                            FROM LMT_STR_OVRL_AMT WHERE LIMIT_CODE=M_LIMIT_CODE;
            END IF;
     END IF;
 --    OVERALL EXPOSURE

  SELECT COUNT(*) INTO M_COUNT_UTI
        FROM LMT_UTL_OVRL_EXP
        WHERE M_TENOR BETWEEN START_DAYS AND END_DAYS;
        IF (M_COUNT_UTI>0) THEN
          	SELECT CURRENT_UTILIZATION INTO M_CURRENT_UTI_EXPO
          		FROM LMT_UTL_OVRL_EXP
                WHERE M_TENOR BETWEEN START_DAYS AND END_DAYS;
        ELSE
            M_CURRENT_UTI_EXPO:=0;
        END IF;

        M_CURRENT_UTI_EXPO:=(M_CURRENT_UTI_EXPO+M_INFLOW-M_OUTFLOW);

     IF (M_CURRENT_UTI_EXPO>0) THEN
        SELECT COUNT(*) INTO M_COUNT FROM LMT_ACT_DETAILS
            WHERE LIMIT_TYPE='03'
            AND ACTIVE_STATUS='Y'
            AND LIMIT_CODE IN
            ( SELECT LIMIT_CODE FROM LMT_STR_OVRL_EXPO WHERE
              M_TENOR BETWEEN START_DAYS
              AND END_DAYS );
            IF (M_COUNT>0)THEN
                SELECT MAX(LIMIT_CODE) INTO M_LIMIT_CODE
                  FROM LMT_ACT_DETAILS
                  WHERE LIMIT_TYPE='03'
                  AND ACTIVE_STATUS='Y'
                  AND LIMIT_CODE IN
                  ( SELECT LIMIT_CODE FROM LMT_STR_OVRL_EXPO
                    WHERE M_TENOR BETWEEN START_DAYS AND END_DAYS );

                CHK_LIMIT_CODE:='Y';
            ELSE
                SELECT MIN(LIMIT_CODE) INTO M_LIMIT_CODE
                  FROM LMT_STR_OVRL_EXPO
                  WHERE M_TENOR BETWEEN START_DAYS AND END_DAYS;

                CHK_LIMIT_CODE:='N';
            END IF;

            IF (CHK_LIMIT_CODE='Y') THEN
                SELECT CONDITION INTO M_CONDITION FROM LMT_STR_OVRL_EXPO
                WHERE LIMIT_CODE=M_LIMIT_CODE;
                IF (M_CONDITION='B') THEN
                    SELECT END_AMOUNT INTO M_END_AMOUNT FROM LMT_STR_OVRL_EXPO
                    WHERE LIMIT_CODE=M_LIMIT_CODE;
                    IF (M_CURRENT_UTI_MATU>M_END_AMOUNT)THEN
                        INSERT INTO LMT_POSSIBLE_OUTRIGHT
                        (LIMIT_CODE,
                         START_DAYS,
                         END_DAYS,
                         START_AMOUNT,
                         END_AMOUNT,
                         CURRENT_UTILIZATION)
                          SELECT DISTINCT
                            LIMIT_CODE,
                            DN_LIMIT_EXPO_FIN_START_DAYS(M_TENOR),
                            DN_LIMIT_EXPO_FIN_END_DAYS(M_TENOR),
                            START_AMOUNT,
                            END_AMOUNT,
                            M_CURRENT_UTI_EXPO
                            FROM LMT_STR_OVRL_EXPO WHERE LIMIT_CODE=M_LIMIT_CODE;
                    END IF;
                --IF M_CONDITION='G' NO VIOLATION
                END IF;

            ELSIF (CHK_LIMIT_CODE='N') THEN
                  INSERT INTO LMT_POSSIBLE_OUTRIGHT
                  (LIMIT_CODE,
                   START_DAYS,
                   END_DAYS,
                   START_AMOUNT,
                   END_AMOUNT,
                   CURRENT_UTILIZATION)
                          SELECT DISTINCT
                            LIMIT_CODE,
                            DN_LIMIT_EXPO_FIN_START_DAYS(M_TENOR),
                            DN_LIMIT_EXPO_FIN_END_DAYS(M_TENOR),
                            START_AMOUNT,
                            END_AMOUNT,
                            M_CURRENT_UTI_EXPO
                            FROM LMT_STR_OVRL_EXPO WHERE LIMIT_CODE=M_LIMIT_CODE;
            END IF;
     END IF;












OPEN CUR_LIMIT_DETAILS FOR
SELECT
  LIMIT_CODE,
  START_DAYS,
  END_DAYS,
  START_AMOUNT,
  END_AMOUNT,
  CURRENT_UTILIZATION
  FROM LMT_POSSIBLE_OUTRIGHT ORDER BY LIMIT_CODE;

DELETE LMT_POSSIBLE_OUTRIGHT;
--TRUNCATE TABLE LMT_POSSIBLE_OUTRIGHT;
COMMIT;

END DN_LIMIT_POSSI_OUTRIGHT_MODI;

/
