--------------------------------------------------------
--  DDL for Procedure DN_SWAPS_SWAP_I
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_SWAPS_SWAP_I" 
(
M_inv_swap_no IN OUT DN_TRN_BO_INV_SWAP.inv_swap_no%TYPE,  ----
M_PORTFOLIO_CODE     DN_TRN_BO_INV_SWAP.PORTFOLIO_CODE%TYPE,
M_inst_type          DN_TRN_BO_INV_SWAP.inst_type%TYPE,    -----
M_SECURITY_CODE      DN_TRN_BO_INV_SWAP.SECURITY_CODE%TYPE,
M_deal_no            DN_TRN_BO_INV_SWAP.deal_no%TYPE,      -----
M_inv_code           DN_TRN_BO_INV_SWAP.inv_code%TYPE,     ------
M_SERIAL_NO          DN_TRN_BO_INV_SWAP.SERIAL_NO%TYPE,
M_FACE_VALUE         DN_TRN_BO_INV_SWAP.FACE_VALUE%TYPE,
M_DN_USER            DN_TRN_BO_INV_SWAP.DN_USER%TYPE,
M_inv_swap_no2       DN_TRN_BO_INV_SWAP.inv_swap_no%TYPE,
M_STATUS             VARCHAR2
)
AS
  X CHAR;

   /*  PROCEDURE  - DN_SWAPS_SWAP_I  SAVING SWAP-ISSUED
   SYSTEM     - DEALNET
   CREATED BY - SUKATHISVARAN
   CREATED ON - 23/AUGUEST/1999 */



BEGIN

DN_VALIDATE_SAVE_RIGHTS(M_DN_USER,'WD_Swaps'); --added by ashini on 31/10/2005 for sr0509-047

--RAISE_APPLICATION_ERROR(-20201,M_STATUS||' '||M_inv_swap_no||' '||M_PORTFOLIO_CODE||' '||M_inst_type||' '||M_SECURITY_CODE||''||M_deal_no||''||M_inv_code||''||M_SERIAL_NO||''||M_FACE_VALUE||''||M_DN_USER||' '||M_inv_swap_no2);


IF M_INV_SWAP_NO2 IS NULL THEN
    SELECT 'IS'||TO_CHAR(SYSDATE,'YYYY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'
            ||LPAD(TO_CHAR(DN_SEQ_INV_SWAP.NEXTVAL),3,'0')
    INTO M_INV_SWAP_NO
    FROM DUAL;

ELSE
    M_INV_SWAP_NO:=M_INV_SWAP_NO2;

END IF;

INSERT INTO DN_TRN_BO_INV_SWAP
            (INV_SWAP_NO , PORTFOLIO_CODE , inst_type , SECURITY_CODE , deal_no , inv_code ,
             SERIAL_NO ,  TRANS_TYPE,FACE_VALUE,DN_USER)

VALUES      (M_INV_SWAP_NO , M_PORTFOLIO_CODE , M_inst_type , M_SECURITY_CODE , M_deal_no ,
             M_inv_code , M_SERIAL_NO , 'I' , M_FACE_VALUE , M_DN_USER);



IF (M_STATUS='Y') THEN
------------CALLING EXTERNAL PROCEDURES------------

DN_BO_INV_SWAPS_OR(M_INV_SWAP_NO);
DN_BO_INV_SWAPS_RP(M_INV_SWAP_NO);
DN_BO_INV_SWAPS_BL(M_INV_SWAP_NO);

END IF;

/*INSERT INTO DN_TIME_LOG_SETTLE
          (DOC_REF_NO,
           REL_DEAL_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            ( M_INV_SWAP_NO,
              M_deal_no,
              M_DN_USER,
              SYSDATE,
             'INVENTORY SWAP'
           ); */
           ------- ADDED FOR TIME LOG MANAGEMENT -------
      /*INSERT INTO DN_TIME_LOG_SETTLE
           (DOC_REF_NO,
            REL_DEAL_NO,
            DN_USER,
            ENT_DATE,
            DESCRIPTION
        )
      VALUES
             (M_INV_SWAP_NO,
              M_deal_no,
              M_DN_USER,
              SYSDATE ,
              'INVENTORY SWAP'
           );  */
     SELECT COUNT(DOC_REF_NO)
     INTO X
     FROM DN_TIME_LOG_SETTLE
     WHERE DOC_REF_NO=M_INV_SWAP_NO AND REL_DEAL_NO=M_deal_no;
     IF X = '0' THEN
     /*IF X > '1' THEN
     DELETE FROM
        DN_TIME_LOG_SETTLE
     WHERE
        DOC_REF_NO=M_INV_SWAP_NO;*/
      INSERT INTO DN_TIME_LOG_SETTLE
           (DOC_REF_NO,
            REL_DEAL_NO,
            DN_USER,
            ENT_DATE,
            DESCRIPTION
        )
      VALUES
             (M_INV_SWAP_NO,
              M_deal_no,
              M_DN_USER,
              SYSDATE ,
              'INVENTORY SWAP'
           );
END IF;


COMMIT;

END DN_SWAPS_SWAP_I;

/
