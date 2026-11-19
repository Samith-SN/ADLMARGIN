--------------------------------------------------------
--  DDL for Function DN_CAL_FACE_VAL
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_CAL_FACE_VAL" 


     ( M_DEAL_NO    DN_INV_OUTPS_DEAL_SEC.DEAL_NO%TYPE
     )

    -- Function     : This returns face value from
    -- System       : DEALNET System
    -- Created by   :
    -- Created on   :
  RETURN  REAL



   IS
	  TOTAL NUMBER:=0;



BEGIN


SELECT SUM(kk.aa) into  total
  from (select face_val aa
       FROM DN_INV_OUTPS_DEAL_SEC
       where   deal_no= M_DEAL_NO
              union all

     select face_val aa
       FROM DN_INV_OUTPS_DEAL_SErial_no
       where   deal_no=M_DEAL_NO
       union all
       select face_val aa
       FROM DN_his_OUTPS_DEAL_SErial_no
       where   deal_no=M_DEAL_NO) kk ;

RETURN TOTAL;

END DN_CAL_FACE_VAL;

/
