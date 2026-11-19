--------------------------------------------------------
--  DDL for Procedure DN_INVENTORY_EXCHANGE_I_V1_I
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INVENTORY_EXCHANGE_I_V1_I" 
(
M_inv_exchg_no  IN OUT DN_TRN_BO_INV_EXCHANGE.inv_exchg_no%TYPE,   --
--M_exchange_date        DN_TRN_BO_INV_EXCHANGE.exchange_date%TYPE,
M_portfolio_code       DN_TRN_BO_INV_EXCHANGE.portfolio_code%TYPE,
M_deal_no              DN_TRN_BO_INV_EXCHANGE.deal_no%TYPE,
M_inst_type            DN_TRN_BO_INV_EXCHANGE.inst_type%TYPE,
M_security_code        DN_TRN_BO_INV_EXCHANGE.security_code%TYPE,
M_serial_no            DN_TRN_BO_INV_EXCHANGE.serial_no%TYPE,
M_inv_code             DN_TRN_BO_INV_EXCHANGE.inv_code%TYPE,
--M_trans_type           DN_TRN_BO_INV_EXCHANGE.trans_type%TYPE,
M_face_value           DN_TRN_BO_INV_EXCHANGE.face_value%TYPE,
--M_hcut_per             DN_TRN_BO_INV_EXCHANGE.hcut_per%TYPE,
--M_fval_with_hcut       DN_TRN_BO_INV_EXCHANGE.fval_with_hcut%TYPE,
M_dn_user              DN_TRN_BO_INV_EXCHANGE.dn_user%TYPE,
M_allo_deal_no         DN_TRN_BO_INV_EXCHANGE.allo_deal_no%TYPE,
M_inv_exchg_no2        DN_TRN_BO_INV_EXCHANGE.inv_exchg_no%TYPE,
M_STATUS2                 VARCHAR2,
M_PARTALLO_STAT        VARCHAR2 --$$##SC
)

AS

   X NUMBER;
   Y NUMBER;
   err_num   varchar2(200);
err_msg   varchar2(200);

   /*  PROCEDURE  - DN_INVENTORY_EXCHANGE_I SAVING EXCHANGE
   SYSTEM     - DEALNET
   CREATED BY - SUKATHISVARAN
   CREATED ON - 21/SEPTEMBER/1999 */



BEGIN
--RAISE_APPLICATION_ERROR(-20201,'*** '||sysdate||'| '||M_inv_exchg_no||'| '||M_portfolio_code||'| '||M_deal_no||'| '||M_inst_type||'| '||M_security_code||'| '||M_serial_no||'| '||M_inv_code||'|M_face_valueM_face_value '||M_face_value||'| '||M_STATUS2||'| '||M_inv_exchg_no2||'*****');
--RAISE_APPLICATION_ERROR(-20201,'*** '||sysdate||'| '||M_INV_EXCHG_NO||'| '||M_portfolio_code||'| '||M_allo_deal_no||'| '||M_deal_no||'| '||M_security_code||'| '||M_serial_no||'| '||M_inv_code||'| '||M_face_value||'| '||M_STATUS2||'| '||M_inv_exchg_no2||'*****');

--DN_VALIDATE_SAVE_RIGHTS(M_DN_USER,'WD_Exchange');



IF M_inv_exchg_no2 IS NULL THEN
    SELECT 'IX'||TO_CHAR(SYSDATE,'YYYY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'
            ||LPAD(TO_CHAR(DN_SEQ_INV_EXCHANG.NEXTVAL),3,'0')
    INTO M_inv_exchg_no
    FROM DUAL;

ELSE
    M_inv_exchg_no:=M_inv_exchg_no2;

END IF;






--**************************************************************

INSERT INTO DN_TRN_BO_INV_EXCHANGE
            (   inv_exchg_no ,
                exchange_date ,
                portfolio_code ,
                deal_no ,
                inst_type,
                security_code,
                serial_no,
                inv_code,
                trans_type,
                face_value,
                hcut_per,
                fval_with_hcut,
                dn_user,
                allo_deal_no,part_allo_status )

VALUES     (    M_inv_exchg_no,
                sysdate,
                M_portfolio_code,
                M_deal_no ,
                M_inst_type ,
                M_security_code ,
                M_serial_no ,
                M_inv_code ,
                'I',
                M_face_value,
                '10',
                '1100',
                M_dn_user,
                M_allo_deal_no,M_PARTALLO_STAT
           );
--RAISE_APPLICATION_ERROR(-20201,'M_STATUS2*** '||M_STATUS2);
IF (M_STATUS2='Y') THEN
  ------------CALLING MAIN PROCEDURE
  ------------DN_INV_EXCH_BACKEND_MAIN_V1(M_INV_EXCHG_NO,M_DEAL_NO,M_PORTFOLIO_CODE);
    DN_INV_EXCH_BACKEND_MAIN_V1(M_INV_EXCHG_NO,M_allo_deal_no,M_PORTFOLIO_CODE,M_PARTALLO_STAT);--$$##SC
--RAISE_APPLICATION_ERROR(-20201,'*** '||sysdate||'| '||M_INV_EXCHG_NO||'| '||M_portfolio_code||'| '||M_allo_deal_no||'| '||M_deal_no||'| '||M_security_code||'| '||M_serial_no||'| '||M_inv_code||'| '||M_face_value||'| '||M_STATUS2||'| '||M_inv_exchg_no2||'*****');
--RAISE_APPLICATION_ERROR(-20201,'*** '||sysdate||'| '||M_INV_EXCHG_NO||'| '||M_portfolio_code||'| '||M_allo_deal_no||'| '||M_deal_no||'| '||M_security_code||'| '||M_serial_no||'| '||M_inv_code||'| '||M_face_value||'| '||M_STATUS2||'| '||M_inv_exchg_no2||'*****');


END IF;


    --ADDED FOR TIME LOG MANAGEMENT  BY S.YASODHA
      SELECT COUNT(DOC_REF_NO)
      INTO X
      FROM DN_TIME_LOG_SETTLE
      WHERE DOC_REF_NO =M_inv_exchg_no AND REL_DEAL_NO=M_deal_no;
      IF X = '0' THEN
      INSERT INTO DN_TIME_LOG_SETTLE
           (DOC_REF_NO,
            REL_DEAL_NO,
            DN_USER,
            ENT_DATE,
            DESCRIPTION)
            VALUES
            ( M_inv_exchg_no,
              M_deal_no,
              M_dn_user,
              SYSDATE,
              'INVENTORY EXCHANGE');
              END IF;

         SELECT COUNT(DOC_REF_NO)
         INTO Y
         FROM DN_TIME_LOG_SETTLE
         WHERE DOC_REF_NO=M_inv_exchg_no AND REL_DEAL_NO=M_allo_deal_no;
         IF Y='0' THEN
         INSERT INTO DN_TIME_LOG_SETTLE
          (DOC_REF_NO,
           REL_DEAL_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            ( M_inv_exchg_no,
              M_allo_deal_no,
              M_dn_user,
              SYSDATE,
              'INVENTORY EXCHANGE');
         END IF;
    --*********************************************************************************

COMMIT;
/*EXCEPTION
  WHEN OTHERS THEN
   err_num :=  substr(SQLCODE,1,15);
   err_msg := substr(SQLERRM,1,200) ;
  INSERT INTO DN_REF_SEQUENCE_LOG VALUES (M_inv_exchg_no,err_num||''||err_msg,'ERROR IN EXCHANGE',SYSDATE);
  COMMIT;
 RAISE_APPLICATION_ERROR(-20201,SQLCODE||SQLERRM);*/

END DN_INVENTORY_EXCHANGE_I_V1_I ;

/
