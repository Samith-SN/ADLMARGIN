--------------------------------------------------------
--  DDL for Function DN_GET_NEW_VALUEDATE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_NEW_VALUEDATE" 


RETURN DATE IS
M_VALUE_DATE  DATE;

MM_VALUE_DATE_INT         DATE;
FOUND1                    NUMBER;
MM_VALUE_DATE             DATE;
FOUND                     NUMBER;
M_COUNT                   NUMBER;

BEGIN


         --PURPOSE    : TO GET THE  VALUE DATE FOR DEALERWISE LIMIT TYPE(OVERALL AMOUNT)
         --CREATED BY : NIRMALA FERNANDO.
         --CREATED ON : 06-03-2001.
         --SYSTEM     : DEALNET.


         SELECT  SYSDATE+1
         INTO    MM_VALUE_DATE
         FROM    DUAL;

     LOOP
          SELECT  COUNT(*)
          INTO    M_COUNT
          FROM    DN_REF_HOLIDAY
          WHERE   HOLIDAY=MM_VALUE_DATE;

           IF (M_COUNT>0) THEN
            MM_VALUE_DATE:=MM_VALUE_DATE+1;
           ELSE
             FOUND:=1;
             M_VALUE_DATE:=MM_VALUE_DATE;
           END IF;

         IF FOUND=1 THEN
          EXIT;
         END IF;
     END LOOP;


         SELECT  M_VALUE_DATE+1
         INTO    MM_VALUE_DATE_INT
         FROM    DUAL;


     LOOP
          SELECT  COUNT(*)
          INTO    M_COUNT
          FROM    DN_REF_HOLIDAY
          WHERE   HOLIDAY=MM_VALUE_DATE_INT;

           IF (M_COUNT>0) THEN
            MM_VALUE_DATE_INT:=MM_VALUE_DATE_INT+1;
           ELSE
             FOUND1:=1;
             M_VALUE_DATE:=MM_VALUE_DATE_INT;
           END IF;

         IF FOUND1=1 THEN
          EXIT;
         END IF;
     END LOOP;


RETURN TO_DATE(TO_CHAR(M_VALUE_DATE,'DD-MM-YYYY'),'DD-MM-YYYY');
END DN_GET_NEW_VALUEDATE;

/
