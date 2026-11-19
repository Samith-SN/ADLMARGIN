--------------------------------------------------------
--  DDL for Procedure DN_TRANS_SCRIP_SCRIPLESS2
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_TRANS_SCRIP_SCRIPLESS2" 
(
M_TRANS_NO         IN OUT       DN_INV_OUTPS_DEAL_SERIAL_NO.DEAL_NO%TYPE,
M_PORTFOLIO_CODE                DN_INV_OUTPS_DEAL_SERIAL_NO.PORTFOLIO_CODE%TYPE,
M_SECURITY_CODE                 DN_INV_OUTPS_DEAL_SERIAL_NO.SECURITY_CODE%TYPE,
--M_WA_YIELD                    DN_INV_OUTPS_DEAL_SERIAL_NO.DEAL_YIELD%TYPE,
--M_TR_FACE_VAL                 DN_INV_OUTPS_DEAL_SERIAL_NO.FACE_VAL%TYPE,
M_SERIAL_NO                     DN_INV_OUTPS_DEAL_SERIAL_NO.SERIAL_NO%TYPE,
M_USER                          DN_TRN_SCRIPLESS_TRANSFERS.DN_USER%TYPE,
M_INST_TYPE                     DN_INV_OUTPS_DEAL_SERIAL_NO.INST_TYPE%TYPE,
M_YIELD_WITH_BROKERAGE          DN_INV_OUTPS_DEAL_SERIAL_NO.YIELD_WITH_BROKERAGE%TYPE,
M_FACE_VAL                      DN_INV_OUTPS_DEAL_SERIAL_NO.FACE_VAL%TYPE,
M_TRANS_NO2                     DN_INV_OUTPS_DEAL_SERIAL_NO.DEAL_NO%TYPE

)

AS
err_num   varchar2(200);
err_msg   varchar2(200);
M_DEAL_NO                       DN_INV_OUTPS_DEAL_SERIAL_NO.DEAL_NO%TYPE;
BEGIN
            ---PURPOSE     : TO SAVE SCRIP TO SCRIPLESS TRANSFERS.
            ---CREATED ON  : 29-05-2001.
            ---CREATED BY  : NIRMALA FERNANDO.
            ---SYSTEM      : DEALNET.
--DN_VALIDATE_SAVE_RIGHTS(M_USER,'WD_Scripless_Trans');

            IF M_TRANS_NO2 IS NULL THEN
                      SELECT 'TS'||TO_CHAR(SYSDATE,'YYYY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'
                              ||LPAD(TO_CHAR(DN_SEQ_TRANS_SCRIP.NEXTVAL),3,'0')
                      INTO M_TRANS_NO
                      FROM DUAL;

                  INSERT INTO DN_INV_OUTPS_DEAL_SEC
                    (PORTFOLIO_CODE,EFF_VALDATE,INST_TYPE,SECURITY_CODE,TRN_TYPE,
                     DEAL_NO,DEAL_YIELD,YIELD_WITH_BROKERAGE,FACE_VAL,INITIAL_COST,
                     BROKERAGE,PRICE_INT_ACCR,CARR_VAL,COUP_INT_PURCH,COUP_INT_ACCR,
                     TOT_COUP_INT,FWD_SALE,FWD_PURCHASE,LOCATION,SCRIP_STATUS)

                  VALUES(M_PORTFOLIO_CODE,SYSDATE,M_INST_TYPE,M_SECURITY_CODE,'B',
                          M_TRANS_NO,0,
                          0,0,0,
                          0,0,0,0,0,0,0,0,
                          M_PORTFOLIO_CODE,
                         'SL');
             ELSE
                 M_TRANS_NO:=M_TRANS_NO2;
             END IF;



             UPDATE DN_INV_OUTPS_DEAL_SERIAL_NO
             SET    SERIAL_NO_STATUS='TRF' ,
                    SALE_EFF_VALDATE=SYSDATE,
                    SALE_DEAL_NO=M_TRANS_NO
             WHERE  PORTFOLIO_CODE=M_PORTFOLIO_CODE AND
                    SERIAL_NO=M_SERIAL_NO AND
                    SECURITY_CODE=M_SECURITY_CODE AND
                    SCRIP_STATUS='SC' AND
                    INST_TYPE=M_INST_TYPE AND
                    YIELD_WITH_BROKERAGE=M_YIELD_WITH_BROKERAGE AND
                    FACE_VAL=M_FACE_VAL;

              SELECT DEAL_NO
              INTO   M_DEAL_NO
              FROM   DN_INV_OUTPS_DEAL_SERIAL_NO
              WHERE  PORTFOLIO_CODE=M_PORTFOLIO_CODE AND
                     SERIAL_NO=M_SERIAL_NO AND
                     SECURITY_CODE=M_SECURITY_CODE AND
                     SCRIP_STATUS='SC' AND
                     INST_TYPE=M_INST_TYPE AND
                     YIELD_WITH_BROKERAGE=M_YIELD_WITH_BROKERAGE AND
                     FACE_VAL=M_FACE_VAL /*AND
                     ALLO_REPO=0 AND
                     ALLO_BL=0*/;



              INSERT INTO DN_TRN_SCRIPLESS_TRANSFERS
                 (INV_TRANS_NO,PORTFOLIO_CODE,SECURITY_CODE,DEAL_NO,SERIAL_NO,
                  TRANS_TYPE,FACE_VALUE,DN_USER,ENTDATE,INV_CODE,INST_TYPE)
               VALUES
                 (M_TRANS_NO,M_PORTFOLIO_CODE,M_SECURITY_CODE,M_DEAL_NO,M_SERIAL_NO,'I',M_FACE_VAL,M_USER,SYSDATE,'SC',M_INST_TYPE);







EXCEPTION
  WHEN OTHERS THEN
   err_num :=  substr(SQLCODE,1,15);
   err_msg := substr(SQLERRM,1,200) ;
  INSERT INTO DN_REF_SEQUENCE_LOG VALUES (M_TRANS_NO,err_num||''||err_msg,'ERROR',SYSDATE);
  COMMIT;
 RAISE_APPLICATION_ERROR(-20201,SQLCODE||SQLERRM);
END DN_TRANS_SCRIP_SCRIPLESS2;

/
