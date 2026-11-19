--------------------------------------------------------
--  DDL for Function DN_GEN_SAVE_ORDER_NO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GEN_SAVE_ORDER_NO" 


  RETURN VARCHAR IS

  M_SAVE_ORDER_NUM         VARCHAR2(15);
  
BEGIN
        
                 
        SELECT TO_CHAR(SYSDATE,'YY')||TO_CHAR(SYSDATE,'MM')||TO_CHAR(SYSDATE,'DD')||'-'||LPAD(TO_CHAR(DN_SEQ_PAY_ENT_ORDER.NEXTVAL),4,'0') INTO M_SAVE_ORDER_NUM
        FROM DUAL;
       
        
       
        RETURN M_SAVE_ORDER_NUM ;
        
       
END; 

/
