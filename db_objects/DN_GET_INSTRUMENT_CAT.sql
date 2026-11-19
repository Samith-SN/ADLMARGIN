--------------------------------------------------------
--  DDL for Function DN_GET_INSTRUMENT_CAT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_INSTRUMENT_CAT" 
   (
    M_INST_TYPE   IN  DN_REF_INSTRUMENT.INST_TYPE%TYPE

   ) RETURN  VARCHAR2


    IS

    -- Function     : Effective value date
    -- System       : Deal Net
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 30/06/1999

M_INST_CAT     DN_REF_INSTRUMENT.INST_CAT%TYPE;

BEGIN


 SELECT INST_CAT
 INTO  M_INST_CAT
 FROM  DN_REF_INSTRUMENT
 WHERE INST_TYPE = M_INST_TYPE;

  RETURN M_INST_CAT;

END ;

/
