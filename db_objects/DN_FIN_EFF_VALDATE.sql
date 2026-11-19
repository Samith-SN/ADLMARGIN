--------------------------------------------------------
--  DDL for Function DN_FIN_EFF_VALDATE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_FIN_EFF_VALDATE" 
   (
    M_VALDATE_TYPE   IN  DN_TRN_OUTP_SALE.EFF_VALDATE_TYPE%TYPE

   ) RETURN  DATE


    IS

    -- Function     : Effective value date
    -- System       : Deal Net
    -- Created by   : D.P. Pubudu Thushara
    -- Created on   : 30/06/1999


M_NEXT_HOLIDAY    DN_REF_HOLIDAY.HOLIDAY%TYPE;
M_CURR_DATE       DN_REF_HOLIDAY.HOLIDAY%TYPE;
M_EFF_VALDATE     DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE;

BEGIN


  IF M_VALDATE_TYPE='CASH' THEN

     SELECT
        TO_DATE(TO_CHAR(SYSDATE,'DD-MON-YYYY'),'DD-MON-YYYY')
        INTO M_EFF_VALDATE
     FROM DUAL;

  ELSIF M_VALDATE_TYPE='TOM' THEN

     SELECT
        TO_DATE(TO_CHAR(SYSDATE,'DD-MON-YYYY'),'DD-MON-YYYY')
        INTO M_CURR_DATE
     FROM DUAL;

     SELECT
        MIN(HOLIDAY)
        INTO M_NEXT_HOLIDAY
     FROM
        DN_REF_HOLIDAY
     WHERE
        HOLIDAY>M_CURR_DATE;

     WHILE M_NEXT_HOLIDAY-M_CURR_DATE=1 LOOP

        SELECT
           M_NEXT_HOLIDAY
           INTO M_CURR_DATE
        FROM DUAL;

        SELECT
           MIN(HOLIDAY)
           INTO M_NEXT_HOLIDAY
        FROM
           DN_REF_HOLIDAY
        WHERE
           HOLIDAY>M_CURR_DATE;

     END LOOP;

     SELECT
        M_CURR_DATE+1
        INTO M_EFF_VALDATE
     FROM DUAL;

  ELSIF M_VALDATE_TYPE='SPOT' THEN
     SELECT
        TO_DATE(TO_CHAR(SYSDATE,'DD-MON-YYYY'),'DD-MON-YYYY')
        INTO M_CURR_DATE
     FROM DUAL;

     SELECT
        MIN(HOLIDAY)
        INTO M_NEXT_HOLIDAY
     FROM
        DN_REF_HOLIDAY
     WHERE
        HOLIDAY>M_CURR_DATE;

     WHILE M_NEXT_HOLIDAY-M_CURR_DATE=1 LOOP

        SELECT
           M_NEXT_HOLIDAY
           INTO M_CURR_DATE
        FROM DUAL;

        SELECT
           MIN(HOLIDAY)
           INTO M_NEXT_HOLIDAY
        FROM
           DN_REF_HOLIDAY
        WHERE
           HOLIDAY>M_CURR_DATE;

     END LOOP;

     SELECT
        M_CURR_DATE+1
        INTO M_CURR_DATE -- Effective value date for the TOM
     FROM DUAL;

     SELECT
        MIN(HOLIDAY)
        INTO M_NEXT_HOLIDAY
     FROM
        DN_REF_HOLIDAY
     WHERE
        HOLIDAY>M_CURR_DATE;

     WHILE M_NEXT_HOLIDAY-M_CURR_DATE=1 LOOP

        SELECT
           M_NEXT_HOLIDAY
           INTO M_CURR_DATE
        FROM DUAL;

        SELECT
           MIN(HOLIDAY)
           INTO M_NEXT_HOLIDAY
        FROM
           DN_REF_HOLIDAY
        WHERE
           HOLIDAY>M_CURR_DATE;

     END LOOP;

     SELECT
        M_CURR_DATE+1
        INTO M_EFF_VALDATE
     FROM DUAL;

  END IF;

  RETURN M_EFF_VALDATE;

END DN_FIN_EFF_VALDATE;

/
