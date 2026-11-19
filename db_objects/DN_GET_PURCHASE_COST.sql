--------------------------------------------------------
--  DDL for Function DN_GET_PURCHASE_COST
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_PURCHASE_COST" 
( M_NOSHARES NUMBER,
  M_PRICE NUMBER
)Return Real IS

   NOMI NUMBER;


 BEGIN

 SELECT M_NOSHARES*M_PRICE  INTO NOMI FROM DUAL;
 RETURN NOMI;

END;

/
