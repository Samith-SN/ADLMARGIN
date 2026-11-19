--------------------------------------------------------
--  DDL for Procedure DN_PORTF_INST_RATES_TEMP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_PORTF_INST_RATES_TEMP" 
(
M_PORTFOLIO_CODE            DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE, --1
M_INS_CODE                  DN_REF_PF_INST_RATES_temp.INSTRUMENT_CODE%TYPE, -- 2
M_INS_RATE                  DN_REF_PF_INST_RATES_temp.INSTRUMENT_RATE%TYPE, --3
M_CHANGE                    VARCHAR2
)
AS

M_COUNT                     NUMBER;

------------------------------------------------------------------------------------------------------------------------
--CREATED BY KEITH TO SAVE THE INSTRUMENT RATES FOR A SPECIFIC PORTFOLIO
--ADDED BY KEITH FOR SN-REF 0409-071 PORTFOLIOS INS RATES
--CREATED DATE 05.10.2004
------------------------------------------------------------------------------------------------------------------------

BEGIN
--RAISE_APPLICATION_ERROR(-20201,'******'||M_CHANGE);
--INSERTING PART-----------------------------------
IF M_CHANGE='ADD' THEN
            INSERT INTO DN_REF_PF_INST_RATES_temp
              (PORTFOLIO_CODE,
               INSTRUMENT_CODE,
               INSTRUMENT_RATE
               )
            VALUES(UPPER(M_PORTFOLIO_CODE),
                   M_INS_CODE,
                   M_INS_RATE
                   );

---------------------------------------------------
--MODIFYING PART-----------------------------------
ELSIF M_CHANGE='MOD' THEN
    SELECT COUNT(INSTRUMENT_CODE) INTO M_COUNT
    FROM DN_REF_PF_INST_RATES_temp
    WHERE PORTFOLIO_CODE=UPPER(M_PORTFOLIO_CODE)
    AND INSTRUMENT_CODE=M_INS_CODE;
    IF M_COUNT=0 THEN
    INSERT INTO DN_REF_PF_INST_RATES_temp
              (PORTFOLIO_CODE,
               INSTRUMENT_CODE,
               INSTRUMENT_RATE
               )
            VALUES(UPPER(M_PORTFOLIO_CODE),
                   M_INS_CODE,
                   M_INS_RATE
                   );
    ELSE
    UPDATE DN_REF_PF_INST_RATES_temp
    SET PORTFOLIO_CODE=UPPER(M_PORTFOLIO_CODE),
               INSTRUMENT_CODE=M_INS_CODE,
               INSTRUMENT_RATE=M_INS_RATE
    WHERE
        PORTFOLIO_CODE=UPPER(M_PORTFOLIO_CODE)
        AND INSTRUMENT_CODE=M_INS_CODE;
    END IF;
END IF;
---------------------------------------------------
COMMIT;
END;

/
