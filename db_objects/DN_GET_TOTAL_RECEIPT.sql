--------------------------------------------------------
--  DDL for Function DN_GET_TOTAL_RECEIPT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_TOTAL_RECEIPT" 
(
 PORT           DN_TRN_OUTP_SALE.BUY_PORTFOLIO_CODE%TYPE,
 CP_CODE        DN_TRN_OUTP_SALE.SELL_PORTFOLIO_CODE%TYPE,
 EFFDATE        varchar2
)
 RETURN number
 AS
 M_TOtal_receipt       DN_ACC_LICENCEE_GEN_ACCOUNT.TRNAMOUNT%TYPE;


 BEGIN
                         
                      SELECT SUM(A.TRNAMOUNT) TRNAMOUNT  into M_TOTAL_RECEIPT
										  
								FROM DN_ACC_LICENCEE_GEN_ACCOUNT A, 
								DN_REF_PORTFOLIO P, 
								DN_TRN_OUTP_SALE S, 
						        DN_TRN_OUTP_SALE_SETTLE_EQUITY st 
						
								WHERE ACC_TYPE_CODE=302 
								AND DRCR_STATUS='DR' AND DOCREFNO LIKE 'ORMT%' 
								AND A.DOCREFNO= S.DEAL_NO 
								AND (S.SELL_PORTFOLIO_CODE=P.PORTFOLIO_CODE AND P.PF_TYPE='P') 
						       and  st.deal_no=s.deal_no 
						       and P.PORTFOLIO_CODE=PORT  
						       and BUY_PORTFOLIO_CODE=CP_CODE
						       
						--      and  st.buy_setle_date=to_date('m_valfromdate','dd/mm/yyyy') 
						--      and  st.sell_setle_date=to_date('m_valfromdate','dd/mm/yyyy') 
						
						 AND  ST.BUY_SETLE_DATE>=TO_DATE(EFFDATE,'DD/MM/YYYY')  
						 AND  ST.BUY_SETLE_DATE<=TO_DATE(EFFDATE,'DD/MM/YYYY')  
						 AND  ST.SELL_SETLE_DATE>=TO_DATE(EFFDATE,'DD/MM/YYYY')  
						 AND  ST.SELL_SETLE_DATE<=TO_DATE(EFFDATE,'DD/MM/YYYY') 
                          
						 GROUP BY S.BUY_PORTFOLIO_CODE,S.SELL_PORTFOLIO_CODE,P.PF_NAME,
                                 A.PORTFOLIO_CODE, A.DN_PORTFOLIO_CODE ,ST.BUY_SETLE_DATE ;
						     
                         
                         
                         
                         
                        



 RETURN  nvl(M_TOtal_receipt,0);

END DN_GET_TOTAL_RECEIPT;

/
