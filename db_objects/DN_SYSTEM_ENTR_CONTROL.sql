--------------------------------------------------------
--  DDL for Function DN_SYSTEM_ENTR_CONTROL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_SYSTEM_ENTR_CONTROL" 
   (
    M_DATE    VARCHAR2
 
   ) RETURN  VARCHAR2

    IS

    -- Function     : Entering  data is not  possible 
    -- System       : LBMARGIN
    -- Created by   : K.G Prabash
    -- Created on   : 08-05-2013
    
  M_RESULT                      VARCHAR2(5); 
  M_DAY_END_DATE                DN_SYS_PARAMETER.LAST_DAILY%TYPE;
  M_DAILY_MARGIN_DATE           DN_SYS_DAILY_MARGIN_TRADING.LAST_DAILY%TYPE;
  M_VAL_DATE                    DATE;

 BEGIN

    SELECT
       TO_DATE(TO_CHAR(LAST_DAILY,'DD-MM-YYYY'),'DD-MM-YYYY') INTO M_DAY_END_DATE
    FROM
       DN_SYS_PARAMETER;
       
   
       
    SELECT
      TO_DATE(TO_CHAR(LAST_DAILY,'DD-MM-YYYY'),'DD-MM-YYYY')  INTO M_DAILY_MARGIN_DATE
    FROM
       DN_SYS_DAILY_MARGIN_TRADING   ;

    M_VAL_DATE:=TO_DATE(M_DATE,'DD-MM-YYYY');
    
-- raise_application_error(-20001,'**'||M_VAL_DATE||'**'||M_DAY_END_DATE||'**'||M_DAILY_MARGIN_DATE||'**');  

    M_RESULT:='NO';
        
    IF M_VAL_DATE <= M_DAY_END_DATE THEN

    M_RESULT:='YES';
    
    end if;
    
    IF M_VAL_DATE <= M_DAILY_MARGIN_DATE THEN

    M_RESULT:='YES';

    
    END IF;
    
-- raise_application_error(-20001,'**'||M_RESULT||'**');  
 RETURN M_RESULT;

END dn_System_entr_Control; 

/
