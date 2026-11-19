--------------------------------------------------------
--  DDL for Procedure DN_SWAPS_SWAP_R
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_SWAPS_SWAP_R" 
(
M_inv_swap_no IN OUT DN_TRN_BO_INV_SWAP.inv_swap_no%TYPE,
M_PORTFOLIO_CODE     DN_TRN_BO_INV_SWAP.PORTFOLIO_CODE%TYPE,
M_inst_type          DN_TRN_BO_INV_SWAP.inst_type%TYPE,
M_SECURITY_CODE      DN_TRN_BO_INV_SWAP.SECURITY_CODE%TYPE,
M_deal_no            DN_TRN_BO_INV_SWAP.deal_no%TYPE,
M_inv_code           DN_TRN_BO_INV_SWAP.inv_code%TYPE,
M_SERIAL_NO          DN_TRN_BO_INV_SWAP.SERIAL_NO%TYPE,
M_FACE_VALUE         DN_TRN_BO_INV_SWAP.FACE_VALUE%TYPE,
M_DN_USER            DN_TRN_BO_INV_SWAP.DN_USER%TYPE,
M_inv_swap_no2       DN_TRN_BO_INV_SWAP.inv_swap_no%TYPE
)
AS

     /* PROCEDURE  - DN_SWAPS_SWAP_R  SAVING SWAP-RECEIVED
        SYSTEM     - DEALNET
        CREATED BY - SUKATHISVARAN
        CREATED ON - 18/AUGUEST/1999 */

M_deal_no_dump      VARCHAR2(14);

BEGIN


DN_VALIDATE_SAVE_RIGHTS(M_DN_USER,'WD_Swaps'); --added by ashini on 31/10/2005 for sr0509-047

--RAISE_APPLICATION_ERROR(-20201,M_inv_swap_no||' |'||M_PORTFOLIO_CODE||'| '||M_inst_type||'| '||M_SECURITY_CODE||'|'||M_deal_no||'|'||M_inv_code||'|'||M_SERIAL_NO||'|'||M_FACE_VALUE||'|'||M_DN_USER||'| '||M_inv_swap_no2);

IF M_INV_SWAP_NO2 IS NULL THEN
    SELECT 'IS'||TO_CHAR(SYSDATE,'YYYY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'
            ||LPAD(TO_CHAR(DN_SEQ_INV_SWAP.NEXTVAL),3,'0')
    INTO M_INV_SWAP_NO
    FROM DUAL;

ELSE
    M_INV_SWAP_NO:=M_INV_SWAP_NO2;

END IF;



IF M_inv_code='OR' THEN
      M_deal_no_dump:=M_INV_SWAP_NO;
ELSE
    M_deal_no_dump:=M_deal_no;
END IF;


INSERT INTO DN_TRN_BO_INV_SWAP
            (INV_SWAP_NO , PORTFOLIO_CODE , inst_type , SECURITY_CODE , deal_no , inv_code ,
             SERIAL_NO ,  TRANS_TYPE,FACE_VALUE,DN_USER)

VALUES      (M_INV_SWAP_NO , M_PORTFOLIO_CODE , M_inst_type , M_SECURITY_CODE , M_deal_no_dump ,
             M_inv_code , M_SERIAL_NO , 'R' , M_FACE_VALUE , M_DN_USER);

COMMIT;

END DN_SWAPS_SWAP_R;

/
