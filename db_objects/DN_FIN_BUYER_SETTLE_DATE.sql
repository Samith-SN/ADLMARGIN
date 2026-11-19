--------------------------------------------------------
--  DDL for Function DN_FIN_BUYER_SETTLE_DATE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_BUYER_SETTLE_DATE" 
   (
    M_EFF_DATE       VARCHAR2,
    NO_DAYS          NUMBER
   ) RETURN  DATE


IS


M_CURR_DATE       DN_REF_HOLIDAY.HOLIDAY%TYPE;
M_EFF_VALDATE     DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE;

M_COUNT   NUMBER DEFAULT 0;
X         NUMBER DEFAULT 1;--added "1" on 28-05-2004
Y         NUMBER DEFAULT 0;
M_NO_DAYS NUMBER;

BEGIN

SELECT      TO_DATE(M_EFF_DATE,'DD-MM-YYYY') INTO  M_CURR_DATE     FROM DUAL;
--dbms_output.put_line('Value of NO_DAYS='||NO_DAYS);
M_NO_DAYS:=NO_DAYS;

 WHILE X<= M_NO_DAYS LOOP--added "=" on 28-05-2004 ang changed NO_DAYS to M_NO_DAYS

   SELECT   COUNT(*)         INTO M_COUNT
   FROM         DN_REF_HOLIDAY     WHERE         HOLIDAY = M_CURR_DATE+X;
   --dbms_output.put_line('Value of M_COUNT='||M_COUNT);
   --dbms_output.put_line('Value of M_CURR_DATE+X='||to_char(to_date(M_CURR_DATE)+X,'DD-MM-YYYY'));
   IF M_COUNT > 0 THEN
     Y:=Y+1;
     M_NO_DAYS:= M_NO_DAYS+1;
   END IF;
   X:=X+1;
   --dbms_output.put_line('Value of M_NO_DAYS='||M_NO_DAYS);
 END LOOP ;

--dbms_output.put_line('Value of Y='||Y);

   SELECT
        M_CURR_DATE+Y+NO_DAYS
        INTO M_EFF_VALDATE
     FROM DUAL;

--dbms_output.put_line('Value of M_EFF_VALDATE='||M_EFF_VALDATE);

  RETURN M_EFF_VALDATE;

END DN_FIN_BUYER_SETTLE_DATE;

/
