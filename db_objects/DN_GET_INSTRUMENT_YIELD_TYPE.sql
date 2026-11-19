--------------------------------------------------------
--  DDL for Function DN_GET_INSTRUMENT_YIELD_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_INSTRUMENT_YIELD_TYPE" 
   (
    M_INST_TYPE   IN  DN_REF_INSTRUMENT.INST_TYPE%TYPE

   ) RETURN  VARCHAR2


    IS

    -- Function     : Effective value date
    -- System       : Deal Net
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 30/06/1999

M_YIELD_TYPE     DN_REF_INSTRUMENT.YIELD_TYPE%TYPE;

BEGIN


 SELECT YIELD_TYPE
 INTO  M_YIELD_TYPE
 FROM  DN_REF_INSTRUMENT
 WHERE INST_TYPE = M_INST_TYPE;

  RETURN M_YIELD_TYPE;

END ;

/
