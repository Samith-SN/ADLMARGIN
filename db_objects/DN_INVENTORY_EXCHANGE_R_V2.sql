--------------------------------------------------------
--  DDL for Procedure DN_INVENTORY_EXCHANGE_R_V2
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INVENTORY_EXCHANGE_R_V2" 
(
M_INV_EXCHG_NO  IN OUT DN_TRN_BO_INV_EXCHANGE.inv_exchg_no%TYPE,   --

--M_INV_EXCHG_NO         DN_TRN_BO_INV_EXCHANGE.INV_EXCHG_NO%TYPE,
  --M_EXCHANGE_DATE        DN_TRN_BO_INV_EXCHANGE.EXCHANGE_DATE%TYPE,
M_PORTFOLIO_CODE       DN_TRN_BO_INV_EXCHANGE.PORTFOLIO_CODE%TYPE,
M_DEAL_NO              DN_TRN_BO_INV_EXCHANGE.DEAL_NO%TYPE,
M_INST_TYPE            DN_TRN_BO_INV_EXCHANGE.INST_TYPE%TYPE,
M_SECURITY_CODE        DN_TRN_BO_INV_EXCHANGE.SECURITY_CODE%TYPE,
M_SERIAL_NO            DN_TRN_BO_INV_EXCHANGE.SERIAL_NO%TYPE,
M_INV_CODE             DN_TRN_BO_INV_EXCHANGE.INV_CODE%TYPE,
    --M_TRANS_TYPE           DN_TRN_BO_INV_EXCHANGE.TRANS_TYPE%TYPE,
M_FACE_VALUE           DN_TRN_BO_INV_EXCHANGE.FACE_VALUE%TYPE,
    --M_HCUT_PER             DN_TRN_BO_INV_EXCHANGE.HCUT_PER%TYPE,
    --M_FVAL_WITH_HCUT       DN_TRN_BO_INV_EXCHANGE.FVAL_WITH_HCUT%TYPE,
M_DN_USER              DN_TRN_BO_INV_EXCHANGE.DN_USER%TYPE,
--M_INV_EXCHG_NO2        DN_TRN_BO_INV_EXCHANGE.INV_EXCHG_NO%TYPE
M_STATUS               VARCHAR2,
M_inv_exchg_no2        DN_TRN_BO_INV_EXCHANGE.inv_exchg_no%TYPE,
M_E_inv_exchg_no2         VARCHAR2

)

AS


   /*  PROCEDURE  - DN_INVENTORY_EXCHANGE_R  SAVING EXCHANGE
   SYSTEM     - DEALNET
   CREATED BY - SUKATHISVARAN
   CREATED ON - 21/SEPTEMBER/1999 */

BEGIN
IF M_E_inv_exchg_no2 = 'YES' THEN
IF M_inv_exchg_no2 IS NULL THEN
    SELECT 'IX'||TO_CHAR(SYSDATE,'YYYY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'
            ||LPAD(TO_CHAR(DN_SEQ_INV_EXCHANG.NEXTVAL),3,'0')
    INTO M_INV_EXCHG_NO
    FROM DUAL;

ELSE
    M_INV_EXCHG_NO:=M_inv_exchg_no2;

END IF;
--RAISE_APPLICATION_ERROR(-20201,'*** '||M_E_inv_exchg_no2||'| '||M_INV_EXCHG_NO||'| '||M_PORTFOLIO_CODE||'| '||M_DEAL_NO||'| '||M_INST_TYPE||'| '||M_SECURITY_CODE||'| '||M_SERIAL_NO||'| '||M_INV_CODE||'| '||M_FACE_VALUE||'| '||M_DN_USER||'| '||M_INV_EXCHG_NO2||'*****');

END IF;



/*IF M_INV_EXCHG_NO2 IS NULL THEN
    SELECT 'IX'||TO_CHAR(SYSDATE,'YYYY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'
            ||LPAD(TO_CHAR(DN_SEQ_INV_EXCHANG.NEXTVAL),3,'0')
    INTO M_INV_EXCHG_NO
    FROM DUAL;

ELSE
    M_INV_EXCHG_NO:=M_INV_EXCHG_NO2;

END IF;*/
--RAISE_APPLICATION_ERROR(-20201,'*** '||SYSDATE||'| '||M_INV_EXCHG_NO||'| '||M_PORTFOLIO_CODE||'| '||M_DEAL_NO||'| '||M_INST_TYPE||'| '||M_SECURITY_CODE||'| '||M_SERIAL_NO||'| '||M_INV_CODE||'| '||M_FACE_VALUE||'| '||M_DN_USER||'| '||M_INV_EXCHG_NO2||'*****');

INSERT INTO DN_TRN_BO_INV_EXCHANGE
            (   INV_EXCHG_NO ,
                EXCHANGE_DATE ,
                PORTFOLIO_CODE ,
                DEAL_NO ,
                INST_TYPE,
                SECURITY_CODE,
                SERIAL_NO,
                INV_CODE,
                TRANS_TYPE,
                FACE_VALUE,
                HCUT_PER,
                FVAL_WITH_HCUT,
                DN_USER,
                ALLO_DEAL_NO    )

VALUES     (    M_INV_EXCHG_NO,
                SYSDATE,
                M_PORTFOLIO_CODE,
                M_DEAL_NO ,
                M_INST_TYPE ,
                M_SECURITY_CODE ,
                M_SERIAL_NO ,
                M_INV_CODE ,
                'R',
                M_FACE_VALUE,
                '10',
                '1100',
                M_DN_USER,
                M_DEAL_NO     );


IF (M_STATUS='Y') THEN

    ------------CALLING MAIN PROCEDURE
    DN_INV_EXCH_BACKEND_MAIN(M_INV_EXCHG_NO,M_DEAL_NO,M_PORTFOLIO_CODE);
END IF;


COMMIT;

END DN_INVENTORY_EXCHANGE_R_V2 ;

/
