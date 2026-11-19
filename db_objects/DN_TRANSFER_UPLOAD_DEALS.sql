--------------------------------------------------------
--  DDL for Procedure DN_TRANSFER_UPLOAD_DEALS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_TRANSFER_UPLOAD_DEALS" 
(
M_USER                   VARCHAR2
)
AS
M_SEC_COUNT              NUMBER;
M_CLIENT_COUNT           NUMBER;
M_LICE_CP                DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE;
M_DEAL_NO                DN_TRN_OUTP_SALE.DEAL_NO%TYPE;
M_SECURITY_CODE          DN_REF_SECURITY.SECURITY_CODE%TYPE;
M_ISSUER_CODE            DN_REF_SECURITY.ISSUER_CODE%TYPE;
M_GUARANTEE_CODE         DN_REF_SECURITY.GUARANTEE_CODE%TYPE;
M_INST_TYPE              DN_REF_SECURITY.INST_TYPE%TYPE;
M_CURR_CODE              DN_REF_SECURITY.CURR_CODE%TYPE;
M_DEAL_NUMBER            DN_TRN_OUTP_SALE.DEAL_NO%TYPE;
M_BUY_SETTEL_DATE        DN_REF_BUY_SELL_SETTELDATES.BUY_SETTEL_DATE%TYPE;
M_SELL_SETTEL_DATE       DN_REF_BUY_SELL_SETTELDATES.SELL_SETTEL_DATE%TYPE;
M_TRN_DATE               DATE;
M_PAR_VALUE              DN_REF_SECURITY.PAR_VALUE%TYPE;
M_ERR_COUNT              NUMBER;


--- DONE BY : MANJULA.
--- ON      : 06-04-2007.
--- FOR     : FCE - CDS_TRANSFER - TRANSFER IN/OUT UPLOAD.

BEGIN
--RAISE_APPLICATION_ERROR(-20201,'inside the procv');
DN_VALIDATE_SAVE_RIGHTS(M_USER,'WD_TRANSFER_UPLOAD');

DELETE FROM DN_TEMP_TRNSFER_UPLOAD_ERR_LOG;


 SELECT DISTINCT TRANSACTION_DATE INTO M_TRN_DATE
 FROM   DN_TEMP_TRANSFER_UPLOAD;


 SELECT BUY_SETTEL_DATE, SELL_SETTEL_DATE
 INTO   M_BUY_SETTEL_DATE, M_SELL_SETTEL_DATE
 FROM   DN_REF_BUY_SELL_SETTELDATES
 WHERE  EFF_VAL_DATE IN (SELECT MAX(EFF_VAL_DATE)  FROM   DN_REF_BUY_SELL_SETTELDATES WHERE EFF_VAL_DATE<=M_TRN_DATE);

FOR X IN (SELECT TO_CHAR(TRANSACTION_DATE,'DD-MM-YYYY') TRN_DATE, /*COMPANY_ID,MAIN_TYPE,SUB_TYPE,*/
          SECURITY_CODE EXT_SECURITY_CODE,
          DN_GET_PORTFOLIO_CODE(CDS_NO) CLIENT,
          QUANTITY,
          PROCESSED_STAT,
          DNUSER,
          DEAL_NO, 
          BROKER,
          PRICE,
          TO_CHAR(DN_FIN_BUYER_SETTLE_DATE(TO_CHAR(TRANSACTION_DATE,'DD-MM-YYYY'),M_BUY_SETTEL_DATE),'DD-MM-YYYY') BUY_SET,
          TO_CHAR(DN_FIN_BUYER_SETTLE_DATE(TO_CHAR(TRANSACTION_DATE,'DD-MM-YYYY'),M_SELL_SETTEL_DATE),'DD-MM-YYYY') SEL_SET
          FROM DN_TEMP_TRANSFER_UPLOAD
          WHERE PROCESSED_STAT='ENT' AND
                DNUSER=M_USER AND DEAL_NO IS NULL 
                --AND TRANSACTION_DESC <> 'CANCEL'--bu waruna 2010-10-26
                ) LOOP

     SELECT COUNT(*)
     INTO   M_SEC_COUNT
     FROM   DN_REF_SECURITY
     WHERE  EXT_SECURITY_CODE = X.EXT_SECURITY_CODE;

     SELECT COUNT(*)
     INTO   M_CLIENT_COUNT
     FROM   DN_REF_PORTFOLIO
     WHERE  PORTFOLIO_CODE = X.CLIENT;

    /* SELECT PORTFOLIO_CODE
     INTO  M_LICE_CP
     FROM  DN_REF_PORTFOLIO
     WHERE PF_TYPE='C' AND OWNED_BY_MBFSL='Y';
     */

----dbms_output.put_line('M_SEC_COUNT=== '||M_SEC_COUNT||'====X.EXT_SECURITY_CODE==='||X.EXT_SECURITY_CODE||'==M_CLIENT_COUNT==='||M_CLIENT_COUNT||'==X.CLIENT===='||X.CLIENT);
IF (M_SEC_COUNT>0) AND (M_CLIENT_COUNT>0) THEN

     SELECT  SECURITY_CODE,ISSUER_CODE,GUARANTEE_CODE,INST_TYPE,CURR_CODE,PAR_VALUE
     INTO    M_SECURITY_CODE,M_ISSUER_CODE,M_GUARANTEE_CODE,M_INST_TYPE,M_CURR_CODE,M_PAR_VALUE
     FROM    DN_REF_SECURITY
     WHERE   EXT_SECURITY_CODE = X.EXT_SECURITY_CODE;


--RAISE_APPLICATION_ERROR(-20201,to_char(X.TRN_DATE,'dd-mm-yyyy'));
----dbms_output.put_line('X.QUANTITY++++ '||X.QUANTITY);

    /*IF (X.QUANTITY<0) THEN-- SALES ---26-08-2010
    ----dbms_output.put_line('---- sales------- ');
    --IF SALES - BUYER PORTFOLIO - FCE (M_LICE_CP)

    MBFSL_OUTRIGHT_IN1(M_DEAL_NO,M_LICE_CP,X.CLIENT,M_INST_TYPE,M_SECURITY_CODE,
                  	   M_GUARANTEE_CODE,M_CURR_CODE,'UD',X.TRN_DATE,
                       'Act/Act',
                       '0',--yeild
                        0, -- settl_val
                        0,--clean
                        -(X.QUANTITY),--face_val
                        0,--dirty
                  	    0, -- M_ACCINT,
                        0,--M_COST,
                        M_USER,
                        M_DEAL_NUMBER,
                        'N',--M_CUST_STAT,
                        'SL',
                        NULL,--M_GDEAL_NUMBER,
                        'EQUTY',--M_DEAL_TYPE,
                        -(X.QUANTITY),--M_NOMALUE,
                        X.BUY_SET,--M_BUY_DATE,
                        X.SEL_SET,--M_SEL_DATE,
                        '1',--M_EXCHANGE_RATE,
                        NULL,--M_PRE_DIS_AMOUNT,
                        'BROKER',--M_INVENTORY_TYPE,
                        NULL--M_CONTRACT_NO
                        );

    MBFSL_OUTRIGHT_IN2(M_DEAL_NO,
                       M_SECURITY_CODE,--M_SECCODE,
                       NULL,--M_SENOIDEN,
                       -(X.QUANTITY),--M_FACEVAL,
                       '1',--M_SEL_MODES,
                       'CHEQUE',--M_SETTLE,
                       '0',--M_SETAMO,
                       NULL,--M_BACC,
                       NULL,--M_SACC,
                       NULL,--M_BUY_COMMENT,
                       NULL,--M_SEL_COMMENT,
                       NULL,--M_BCODE1,
                       NULL,--M_BCODE2,
                       NULL,--M_BRAGE1,
                       NULL,--M_BRAGE2,
                       NULL,--M_SEL_BBASE1,
                       NULL,--M_SEL_BBASE2,
                       NULL,--M_SEL_FEETYPE1,
                       NULL,--M_SEL_FEETYPE2,
                       NULL,--M_FEEAMO1,
                       NULL,--M_FEEAMO2,
                       NULL,--M_VAL1,
                       NULL,--M_VAL2,
                       NULL,--M_TOTAMOU1,
                       NULL,--M_TOTAMOU2,
                       'SUB2',--M_SELECT_TYPE,
                       'EQUTY',--M_DEAL_TYPE,
                       NULL,--M_PA_SERNO,
                       NULL,--M_PA_INVAMT,
                       M_USER,--M_DN_USER,
                       NULL,--MM_TOTAMT,
                       'SL',--MM_SCRIP_STAT,
                       'FCE');--M_PARTICIPANT_ID);




    ELSE --PURCHAES*/---26-08-2010
    --IF PURCHASE - SELLER PORTFOLIO - FCE

----dbms_output.put_line('purchasesss !!!!!!!!!!!!! ');

     MBFSL_OUTRIGHT_IN1(M_DEAL_NO,X.CLIENT,
     X.BROKER,-- M_LICE_CP,
     M_INST_TYPE,M_SECURITY_CODE,
                  	   M_GUARANTEE_CODE,M_CURR_CODE,'UD',X.TRN_DATE,
                       'Act/Act',
                       '0',--yeild
                        0, -- settl_val
                        0,--clean
                        (X.QUANTITY),--face_val
                        0,--dirty
                  	    0, -- M_ACCINT,
                        0,--M_COST,
                        M_USER,
                        M_DEAL_NUMBER,
                        'N',--M_CUST_STAT,
                        'SL',
                        NULL,--M_GDEAL_NUMBER,
                        'EQUTY',--M_DEAL_TYPE,
                        (X.QUANTITY),--M_NOMALUE,
                        X.BUY_SET,--M_BUY_DATE,
                        X.SEL_SET,--M_SEL_DATE,
                        NULL,--'1',--M_EXCHANGE_RATE,
                        --NULL,--M_PRE_DIS_AMOUNT,
                        'BROKER',--M_INVENTORY_TYPE,
                        'WD_TRANSFER_UPLOAD'--NULL--M_CONTRACT_NO
                        );
                        
                        
                        
                        

    MBFSL_OUTRIGHT_IN2(M_DEAL_NO,
                       M_SECURITY_CODE,--M_SECCODE,
                       NULL,--M_SENOIDEN,
                       (X.QUANTITY),--M_FACEVAL,
                       '1',--M_SEL_MODES,
                       'CHEQUE',--M_SETTLE,
                       '0',--M_SETAMO,
                       NULL,--M_BACC,
                       NULL,--M_SACC,
                       NULL,--M_BUY_COMMENT,
                       NULL,--M_SEL_COMMENT,
                       NULL,--M_BCODE1,
                       NULL,--M_BCODE2,
                       NULL,--M_BRAGE1,
                       NULL,--M_BRAGE2,
                       NULL,--M_SEL_BBASE1,
                       NULL,--M_SEL_BBASE2,
                       NULL,--M_SEL_FEETYPE1,
                       NULL,--M_SEL_FEETYPE2,
                       NULL,--M_FEEAMO1,
                       NULL,--M_FEEAMO2,
                       NULL,--M_VAL1,
                       NULL,--M_VAL2,
                       NULL,--M_TOTAMOU1,
                       NULL,--M_TOTAMOU2,
                       'SUB2',--M_SELECT_TYPE,
                       'EQUTY',--M_DEAL_TYPE,
                       NULL,--M_PA_SERNO,
                       NULL,--M_PA_INVAMT,
                       M_USER,--M_DN_USER,
                       NULL,--MM_TOTAMT,
                       'SL'--MM_SCRIP_STAT,
                       );--M_PARTICIPANT_ID);



   -- END IF; ----26-08-2010

DN_CHECK_FIGURES_OR_EQUITY(M_DEAL_NO,'');
----dbms_output.put_line('updateingggggg----- ');

     /* -- commnetd by manjula on 23-04-2007 as the reference number is not a unique number.
     UPDATE DN_TEMP_TRANSFER_UPLOAD
     SET    DEAL_NO          = M_DEAL_NO,
            PROCESSED_STAT   = 'Y'
     WHERE  REFERENCE        = X.REFERENCE ;
     */




    UPDATE DN_TEMP_TRANSFER_UPLOAD
    SET DEAL_NO=M_DEAL_NO,
        PROCESSED_STAT ='ENT'
    WHERE 
    --REFERENCE=X.REFERENCE AND
        SECURITY_CODE=X.EXT_SECURITY_CODE AND
        DN_GET_PORTFOLIO_CODE(CDS_NO) =X.CLIENT AND
        TRANSACTION_DATE=TO_DATE(X.TRN_DATE,'DD-MM-YYYY');

/*-----
TRANSACTION_DATE,SECURITY_CODE, CDS_NO, QUANTITY,
     PROCESSED_STAT, DNUSER, DEAL_NO, BROKER, PRICE
 */    
ELSIF ((M_SEC_COUNT=0) AND  (M_CLIENT_COUNT=0)) THEN

INSERT INTO DN_TEMP_TRNSFER_UPLOAD_ERR_LOG
(ERROR_MSG,CONTRACT_NO,ENT_DATE)
 VALUES
('CLIENT CODE AND THE SECURITY CODE NOT MAPPED -'||X.CLIENT||' - '||X.EXT_SECURITY_CODE,'',SYSDATE) ;

ELSIF ((M_SEC_COUNT=0)) THEN

INSERT INTO DN_TEMP_TRNSFER_UPLOAD_ERR_LOG
(ERROR_MSG,CONTRACT_NO,ENT_DATE)
 VALUES
('SECURITY CODE NOT MAPPED -'||X.EXT_SECURITY_CODE,'',SYSDATE) ;

ELSE

INSERT INTO DN_TEMP_TRNSFER_UPLOAD_ERR_LOG
(ERROR_MSG,CONTRACT_NO,ENT_DATE)
 VALUES
('CLIENT CODE NOT MAPPED -'||X.CLIENT,'',SYSDATE) ;

END IF;


END LOOP;

       
 INSERT INTO DN_TRN_TRANSFER_UPLOAD
 (TRANSACTION_DATE, SECURITY_CODE,CDS_NO,QUANTITY,PROCESSED_STAT, DNUSER, DEAL_NO,BROKER, PRICE,
    GENERATE_DATE, GENERATE_USER )
 ( SELECT TRANSACTION_DATE, SECURITY_CODE, CDS_NO, QUANTITY,  PROCESSED_STAT,  DNUSER, DEAL_NO,BROKER,PRICE,
    SYSDATE,M_USER 
    FROM DN_TEMP_TRANSFER_UPLOAD );


 SELECT COUNT(*)
 INTO M_ERR_COUNT
 FROM DN_TEMP_TRNSFER_UPLOAD_ERR_LOG;

 IF (M_ERR_COUNT>0) THEN
 ROLLBACK;


     
 FOR I IN  (SELECT 
            SECURITY_CODE EXT_SECURITY_CODE,
            CDS_NO CLIENT_CDS
            FROM DN_TEMP_TRANSFER_UPLOAD
            WHERE PROCESSED_STAT='ENT' AND
              DNUSER=M_USER AND DEAL_NO IS NULL AND
             -- TRANSACTION_DESC <> 'CANCEL' AND by waruna 2010-08-26
              (DN_GET_SECURITY_CODE(SECURITY_CODE) IS NULL OR
              DN_GET_PORTFOLIO_CODE(CDS_NO) IS NULL )) LOOP


 INSERT INTO DN_TEMP_TRNSFER_UPLOAD_ERR_LOG(ERROR_MSG,CONTRACT_NO,ENT_DATE)
 VALUES ('CLIENT CODE OR THE SECURITY CODE NOT MAPPED -'||I.CLIENT_CDS ||' - '||I.EXT_SECURITY_CODE,'',SYSDATE) ;


 END LOOP;


 /*ELSE --M_ERR_COUNT
 /*================================================================================================================================================
                                          CONFIRMATION
   ================================================================================================================================================* /
 --------------------------CONFIRM PURCHASES -------------
   FOR J IN (SELECT A.DEAL_NO DEAL_NO
             FROM   DN_TRN_OUTP_SALE A,
                    DN_TRN_TRANSFER_UPLOAD B
             WHERE  APP_STATUS = 'APPRO2'  AND
                    A.DEAL_NO  = B.DEAL_NO AND
                    A.SELL_PORTFOLIO_CODE=M_LICE_CP) LOOP



   MBFSL_DEAL_CONFIRMATION(J.DEAL_NO,M_USER);

   UPDATE DN_TEMP_TRANSFER_UPLOAD
   SET PROCESSED_STAT='CONF'
   WHERE DEAL_NO=J.DEAL_NO;

   END LOOP;


  --------------------------CONFIRM SALES -------------

      FOR K IN (SELECT A.DEAL_NO DEAL_NO,
                A.SECURITY_CODE,
                A.FACE_VALUE,
                A.CURR_CODE
                FROM   DN_TRN_OUTP_SALE A,
                       DN_TRN_TRANSFER_UPLOAD B
                WHERE  APP_STATUS = 'APPRO2'  AND
                       A.DEAL_NO  = B.DEAL_NO AND
                       A.BUY_PORTFOLIO_CODE=M_LICE_CP) LOOP

     DN_SAVE_ALLO_SCRIPLESS_CALL(K.DEAL_NO,K.SECURITY_CODE,NULL,NULL,NULL,K.FACE_VALUE,
                                 NULL,M_USER,NULL,K.CURR_CODE,'NEW');


   MBFSL_DEAL_CONFIRMATION(K.DEAL_NO,M_USER);

   UPDATE DN_TEMP_TRANSFER_UPLOAD
   SET PROCESSED_STAT='CONF'
   WHERE DEAL_NO=K.DEAL_NO;

   END LOOP;*/


 END IF;-------M_ERR_COUNT


END;

/
