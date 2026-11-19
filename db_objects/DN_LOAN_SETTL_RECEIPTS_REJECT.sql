--------------------------------------------------------
--  DDL for Procedure DN_LOAN_SETTL_RECEIPTS_REJECT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_LOAN_SETTL_RECEIPTS_REJECT" 
   (
   M_REC_NO             DN_TRN_BO_SETTL_RECEIPT.REC_NO%TYPE,
   M_ACTIVE_STATUS      DN_REF_PORTFOLIO.ACTIVE_STATUS%TYPE,
   M_USER               DN_DOC_STATUS_LOG.DN_USER%TYPE
   )
AS
M_NUMBER VARCHAR(100);

                  
M_GROUP_NET_COUNT    NUMBER;
M_GROUP_NET_MODE    DN_MAS_SETLE_GROUP_NET.GROUP_NET_MODE%TYPE;


BEGIN


 
IF M_ACTIVE_STATUS='ENT' then
           

          
              UPDATE DN_TRN_LOAN_SETTL_RECEIPT A
              SET  A.REC_STATUS = 'REJ'
              WHERE A.REC_STATUS =  'ENT' AND REC_NO = M_REC_NO;
                                        
                              
        
           INSERT INTO DN_DOC_STATUS_LOG( DOC_REF_NO,DOC_TYPE,DOC_STATUS,DN_USER,ENT_DATE,DESCRIPTION)
           VALUES(M_rec_no,'LOAN SETTL RECEIPTS REJECT','REJ',M_USER,SYSDATE,'LOAN SETTL RECEIPTS REJECT-'||M_ACTIVE_STATUS);
   

END IF;




END ; 

/
