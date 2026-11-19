--------------------------------------------------------
--  DDL for Function DN_GET_NOMINAL_VALUE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_NOMINAL_VALUE" 
( M_PAR NUMBER,
  M_NOSHARES NUMBER
)Return Real IS

   NOMI NUMBER;


 BEGIN

 SELECT M_PAR*M_NOSHARES  INTO NOMI FROM DUAL;
 RETURN NOMI;

END;

/
