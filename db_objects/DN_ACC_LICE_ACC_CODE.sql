--------------------------------------------------------
--  DDL for Function DN_ACC_LICE_ACC_CODE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_ACC_LICE_ACC_CODE" 
    (
      M_ACC_CODE1        DN_ACC_LICEN_INST_GEN_SUM.ACC_TYPE_CODE%TYPE,
      M_ACC_CODE2        DN_ACC_LICEN_INST_GEN_HIS.ACC_TYPE_CODE%TYPE
    )
   RETURN  VARCHAR2
    IS

    -- Function     : TO RETURN ACC_TYPE_CODE
    -- System       : DEALNET
    -- Created by   : LATHIKA
    -- Created on   : 24/01/2000

 M_ACC_TYPE_CODE       DN_ACC_LICEN_INST_GEN_SUM.ACC_TYPE_CODE%TYPE;

  BEGIN

 IF M_ACC_CODE1 IS NOT NULL THEN
    M_ACC_TYPE_CODE:= M_ACC_CODE1;
 ELSIF M_ACC_CODE2 IS NOT NULL THEN
    M_ACC_TYPE_CODE:= M_ACC_CODE2;
 END IF;

 RETURN SUBSTR(M_ACC_TYPE_CODE,1,3);

END DN_ACC_LICE_ACC_CODE;

/
