--------------------------------------------------------
--  DDL for Function DN_CLIENT_PENDING_CASH_FLOW_R
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_CLIENT_PENDING_CASH_FLOW_R" 
     ( M_PORTFOLIO_CODE    DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE,
       M_DATE        VARCHAR
     )

    -- Function     : This returns TOTAL PENDING RECEIPT
    -- System       : DEALNET System
    -- Created by   :
    -- Created on   :K.M.W.S.JAYANATH
  RETURN  REAL



   IS
 TOTAL NUMBER:=0;
 TOTAL_AMOUNT_RECEIVABLE NUMBER:=0;
 TOTAL_AMOUNT_RECEIVED NUMBER:=0;

BEGIN

SELECT NVL(SUM(A.TRNAMOUNT),0) TRNAMOUNT INTO TOTAL_AMOUNT_Receivable
FROM DN_ACC_LICENCEE_GEN_ACCOUNT A, 
DN_REF_PORTFOLIO P, 
DN_TRN_OUTP_SALE S, 
DN_TRN_OUTP_SALE_SETTLE_EQUITY ST 

WHERE ACC_TYPE_CODE=302 
AND DRCR_STATUS='DR' AND DOCREFNO LIKE 'ORMT%' 
AND A.DOCREFNO= S.DEAL_NO 
AND (S.SELL_PORTFOLIO_CODE=P.PORTFOLIO_CODE AND P.PF_TYPE='P') 
and  st.deal_no=s.deal_no 
and  st.buy_setle_date>=to_date('09/10/2010','dd/mm/yyyy')  
and  st.buy_setle_date<=to_date(M_DATE,'dd/mm/yyyy')  
and  st.sell_setle_date>=to_date('09/10/2010','dd/mm/yyyy')  
and  st.sell_setle_date<=to_date(M_DATE,'dd/mm/yyyy') 
and S.SELL_PORTFOLIO_CODE=M_PORTFOLIO_CODE ; --change by waruna 2011-09-15

dbms_output.put_line(' TOTAL_AMOUNT_Receivable='||TOTAL_AMOUNT_Receivable);

SELECT  NVL(SUM(A.REC_AMOUNT),0) REC_AMOUNT INTO TOTAL_AMOUNT_Received
FROM DN_TRN_BO_SETTL_RECEIPT_BULK A 
--/      --       where EFF_VALDATE=to_date('m_valfromdate','dd/mm/yyyy') 
where EFF_VALDATE>=to_date('09/10/2010','dd/mm/yyyy')  
AND EFF_VALDATE<=to_date(M_DATE,'dd/mm/yyyy')
AND A.SELL_PORTFOLIO_CODE=M_PORTFOLIO_CODE 
AND A.REC_STATUS IN('CONF','APPR1','SIG1','SIG2','PRINT')
 ;
dbms_output.put_line(' TOTAL_AMOUNT_Received='||TOTAL_AMOUNT_Received);
TOTAL:=TOTAL_AMOUNT_RECEIVABLE-TOTAL_AMOUNT_RECEIVED;



RETURN TOTAL;

END ; 

/
