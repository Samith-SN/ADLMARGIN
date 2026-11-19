--------------------------------------------------------
--  DDL for Procedure DN_PORTFOLIOS_IN5
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_PORTFOLIOS_IN5" 

    (   M_PORTFOLIO_CODE   IN OUT   DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE,
        M_ACTIVITY_CODE             DN_REF_PORTF_ALLOW_ACTIVITY.ACTIVITY_CODE%TYPE,
        M_INST_TYPE                 DN_REF_PORTF_ALLOW_ACTIVITY.INST_TYPE%TYPE,
        M_USRE                VARCHAR


    )

AS
M_A_CODE1             DN_REF_PORTF_ALLOW_ACTIVITY.ACTIVITY_CODE%TYPE;
Y                     NUMBER;
Z                     NUMBER;
H                     NUMBER;
F                     NUMBER;

BEGIN

DN_VALIDATE_SAVE_RIGHTS(M_USRE,'WD_Portfolios_MT');  --added by ashini on 31/10/2005 for sr0509-047

--RAISE_APPLICATION_ERROR(-20201,M_PORTFOLIO_CODE||' '||M_ACTIVITY_CODE||' '||M_INST_TYPE);

    /* PROCEDURE  - TO SAVE INSTRUMENT OPTIONS
       SYSTEM     -  DEALNET
       CREATED BY -
       CREATED ON -  */

IF M_PORTFOLIO_CODE IS NOT NULL AND M_ACTIVITY_CODE<>'NULL' THEN

   IF(M_ACTIVITY_CODE='OUT') THEN
     FOR Y IN 1..2 LOOP

       IF(Y=1) THEN
         M_A_CODE1 :='OUTS';

         UPDATE DN_REF_PORTF_ALLOW_ACTIVITY
            SET  INST_TYPE       =M_INST_TYPE
                WHERE PORTFOLIO_CODE    =M_PORTFOLIO_CODE
                  AND  ACTIVITY_CODE    ='OUTS'
                  AND   INST_TYPE       =M_INST_TYPE;

        IF SQL%NOTFOUND THEN
            INSERT INTO DN_REF_PORTF_ALLOW_ACTIVITY
                (PORTFOLIO_CODE,
                ACTIVITY_CODE,
                INST_TYPE)
                     VALUES(
                       M_PORTFOLIO_CODE,
                       'OUTS',
                       M_INST_TYPE
                       );
       END IF;

      ELSE
       M_A_CODE1:='OUTP';

           UPDATE DN_REF_PORTF_ALLOW_ACTIVITY
            SET INST_TYPE       =M_INST_TYPE
                WHERE PORTFOLIO_CODE    =M_PORTFOLIO_CODE
                  AND  ACTIVITY_CODE    ='OUTP'
                  AND   INST_TYPE       =M_INST_TYPE;

        IF SQL%NOTFOUND THEN
            INSERT INTO DN_REF_PORTF_ALLOW_ACTIVITY
                (PORTFOLIO_CODE,
                ACTIVITY_CODE,
                INST_TYPE)
                     VALUES(
                       M_PORTFOLIO_CODE,
                       'OUTP',
                       M_INST_TYPE
                       );
        END IF;
      END IF;
    END LOOP;
  END IF;
----------------------
IF(M_ACTIVITY_CODE='BLF') THEN
   FOR Z IN 1..2 LOOP
      IF(Z=1) THEN
        M_A_CODE1:='BF';

          UPDATE DN_REF_PORTF_ALLOW_ACTIVITY
            SET ACTIVITY_CODE   =M_ACTIVITY_CODE,
                INST_TYPE       =M_INST_TYPE
                WHERE PORTFOLIO_CODE    =M_PORTFOLIO_CODE
                  AND  ACTIVITY_CODE    =M_A_CODE1
                  AND   INST_TYPE       =M_INST_TYPE;

           IF SQL%NOTFOUND THEN
      	         INSERT INTO DN_REF_PORTF_ALLOW_ACTIVITY
                (PORTFOLIO_CODE,
                ACTIVITY_CODE,
                INST_TYPE)
                     VALUES(
                       M_PORTFOLIO_CODE,
                       'BF',
                       M_INST_TYPE
                       );
         END IF;

   ELSE
    M_A_CODE1:='LF';

         UPDATE DN_REF_PORTF_ALLOW_ACTIVITY
            SET ACTIVITY_CODE   =M_ACTIVITY_CODE,
                INST_TYPE       =M_INST_TYPE
                WHERE PORTFOLIO_CODE    =M_PORTFOLIO_CODE
                  AND  ACTIVITY_CODE    =M_A_CODE1
                  AND   INST_TYPE       =M_INST_TYPE;

        IF SQL%NOTFOUND THEN
            INSERT INTO DN_REF_PORTF_ALLOW_ACTIVITY
                (PORTFOLIO_CODE,
                ACTIVITY_CODE,
                INST_TYPE)
                     VALUES(
                       M_PORTFOLIO_CODE,
                       'LF',
                       M_INST_TYPE
                       );
        END IF;

     END IF;
   END LOOP;
 END IF;
-------------------------------------------
----------------------
IF(M_ACTIVITY_CODE='BLS')THEN
	FOR H IN 1..2 LOOP
      IF(H=1) THEN
        M_A_CODE1:='BS';

        UPDATE DN_REF_PORTF_ALLOW_ACTIVITY
            SET ACTIVITY_CODE   =M_ACTIVITY_CODE,
                INST_TYPE       =M_INST_TYPE
                WHERE PORTFOLIO_CODE    =M_PORTFOLIO_CODE
                  AND  ACTIVITY_CODE    =M_A_CODE1
                  AND   INST_TYPE       =M_INST_TYPE;

        IF SQL%NOTFOUND THEN
         INSERT INTO DN_REF_PORTF_ALLOW_ACTIVITY
                (PORTFOLIO_CODE,
                ACTIVITY_CODE,
                INST_TYPE)
                     VALUES(
                       M_PORTFOLIO_CODE,
                       'BS',
                       M_INST_TYPE
                       );
        END IF;

   ELSE
   M_A_CODE1:='LS';
          UPDATE DN_REF_PORTF_ALLOW_ACTIVITY
            SET ACTIVITY_CODE   =M_ACTIVITY_CODE,
                INST_TYPE       =M_INST_TYPE
                WHERE PORTFOLIO_CODE    =M_PORTFOLIO_CODE
                  AND  ACTIVITY_CODE    =M_A_CODE1
                  AND   INST_TYPE       =M_INST_TYPE;

        IF SQL%NOTFOUND THEN

          INSERT INTO DN_REF_PORTF_ALLOW_ACTIVITY
                (PORTFOLIO_CODE,
                ACTIVITY_CODE,
                INST_TYPE)
                     VALUES(
                       M_PORTFOLIO_CODE,
                       'LS',
                       M_INST_TYPE
                       );
            END IF;
   END IF;
 END LOOP;
END IF;

-----------------------------------------------------------------------

IF(M_ACTIVITY_CODE='REP')THEN
	FOR F IN 1..8 LOOP
      IF(F=1) THEN

        UPDATE DN_REF_PORTF_ALLOW_ACTIVITY
            SET ACTIVITY_CODE   =M_ACTIVITY_CODE,
                INST_TYPE       =M_INST_TYPE
                WHERE PORTFOLIO_CODE    =M_PORTFOLIO_CODE
                  AND  ACTIVITY_CODE    ='REPP'
                  AND   INST_TYPE       =M_INST_TYPE;

        IF SQL%NOTFOUND THEN
         INSERT INTO DN_REF_PORTF_ALLOW_ACTIVITY
                (PORTFOLIO_CODE,
                ACTIVITY_CODE,
                INST_TYPE)
                     VALUES(
                       M_PORTFOLIO_CODE,
                       'REPP',
                       M_INST_TYPE
                       );

        END IF;
   ELSIF(F=2) THEN
        UPDATE DN_REF_PORTF_ALLOW_ACTIVITY
            SET ACTIVITY_CODE   =M_ACTIVITY_CODE,
                INST_TYPE       =M_INST_TYPE
                WHERE PORTFOLIO_CODE    =M_PORTFOLIO_CODE
                  AND  ACTIVITY_CODE    ='REPR'
                  AND   INST_TYPE       =M_INST_TYPE;

        IF SQL%NOTFOUND THEN
                  INSERT INTO DN_REF_PORTF_ALLOW_ACTIVITY
                (PORTFOLIO_CODE,
                ACTIVITY_CODE,
                INST_TYPE)
                     VALUES(
                       M_PORTFOLIO_CODE,
                       'REPR',
                       M_INST_TYPE
                       );
        END IF;

   ELSIF(F=3) THEN

      UPDATE DN_REF_PORTF_ALLOW_ACTIVITY
            SET ACTIVITY_CODE   =M_ACTIVITY_CODE,
                INST_TYPE       =M_INST_TYPE
                WHERE PORTFOLIO_CODE    =M_PORTFOLIO_CODE
                  AND  ACTIVITY_CODE    ='REPS'
                  AND   INST_TYPE       =M_INST_TYPE;

        IF SQL%NOTFOUND THEN
          INSERT INTO DN_REF_PORTF_ALLOW_ACTIVITY
                (PORTFOLIO_CODE,
                ACTIVITY_CODE,
                INST_TYPE)
                     VALUES(
                       M_PORTFOLIO_CODE,
                       'REPS',
                       M_INST_TYPE
                       );
         END IF;

    ELSIF(F=4) THEN

         UPDATE DN_REF_PORTF_ALLOW_ACTIVITY
            SET ACTIVITY_CODE   =M_ACTIVITY_CODE,
                INST_TYPE       =M_INST_TYPE
                WHERE PORTFOLIO_CODE    =M_PORTFOLIO_CODE
                  AND  ACTIVITY_CODE    ='RREPF'
                  AND   INST_TYPE       =M_INST_TYPE;

        IF SQL%NOTFOUND THEN
          INSERT INTO DN_REF_PORTF_ALLOW_ACTIVITY
                (PORTFOLIO_CODE,
                ACTIVITY_CODE,
                INST_TYPE)
                     VALUES(
                       M_PORTFOLIO_CODE,
                       'RREPF',
                       M_INST_TYPE
                       );
        END IF;

    ELSIF(F=5) THEN
        UPDATE DN_REF_PORTF_ALLOW_ACTIVITY
            SET ACTIVITY_CODE   =M_ACTIVITY_CODE,
                INST_TYPE       =M_INST_TYPE
                WHERE PORTFOLIO_CODE    =M_PORTFOLIO_CODE
                  AND  ACTIVITY_CODE    ='RREPP'
                  AND   INST_TYPE       =M_INST_TYPE;

        IF SQL%NOTFOUND THEN
          INSERT INTO DN_REF_PORTF_ALLOW_ACTIVITY
                (PORTFOLIO_CODE,
                ACTIVITY_CODE,
                INST_TYPE)
                     VALUES(
                       M_PORTFOLIO_CODE,
                       'RREPP',
                       M_INST_TYPE
                       );
        END IF;
	 ELSIF(F=6) THEN
         UPDATE DN_REF_PORTF_ALLOW_ACTIVITY
            SET ACTIVITY_CODE   =M_ACTIVITY_CODE,
                INST_TYPE       =M_INST_TYPE
                WHERE PORTFOLIO_CODE    =M_PORTFOLIO_CODE
                  AND  ACTIVITY_CODE    ='RREPS'
                  AND   INST_TYPE       =M_INST_TYPE;

        IF SQL%NOTFOUND THEN
          INSERT INTO DN_REF_PORTF_ALLOW_ACTIVITY
                (PORTFOLIO_CODE,
                ACTIVITY_CODE,
                INST_TYPE)
                     VALUES(
                       M_PORTFOLIO_CODE,
                       'RREPS',
                       M_INST_TYPE
                       );
         END IF;

      ELSIF(F=7) THEN
          UPDATE DN_REF_PORTF_ALLOW_ACTIVITY
            SET ACTIVITY_CODE   =M_ACTIVITY_CODE,
                INST_TYPE       =M_INST_TYPE
                WHERE PORTFOLIO_CODE    =M_PORTFOLIO_CODE
                  AND  ACTIVITY_CODE    ='RREPR'
                  AND   INST_TYPE       =M_INST_TYPE;

        IF SQL%NOTFOUND THEN
          INSERT INTO DN_REF_PORTF_ALLOW_ACTIVITY
                (PORTFOLIO_CODE,
                ACTIVITY_CODE,
                INST_TYPE)
                     VALUES(
                       M_PORTFOLIO_CODE,
                       'RREPR',
                       M_INST_TYPE
                       );
         END IF;

       ELSIF(F=8) THEN
        UPDATE DN_REF_PORTF_ALLOW_ACTIVITY
            SET ACTIVITY_CODE   =M_ACTIVITY_CODE,
                INST_TYPE       =M_INST_TYPE
                WHERE PORTFOLIO_CODE    =M_PORTFOLIO_CODE
                  AND  ACTIVITY_CODE    ='REPF'
                  AND   INST_TYPE       =M_INST_TYPE;

        IF SQL%NOTFOUND THEN
          INSERT INTO DN_REF_PORTF_ALLOW_ACTIVITY
                (PORTFOLIO_CODE,
                ACTIVITY_CODE,
                INST_TYPE)
                     VALUES(
                       M_PORTFOLIO_CODE,
                       'REPF',
                       M_INST_TYPE
                       );
          END IF;
       END IF;
    END LOOP;
  END IF;
END IF;
   --------------------------------------------------------------------

   -- IF M_INST_TYPE IS NOT NULL THEN

    /*     UPDATE DN_REF_PORTF_ALLOW_ACTIVITY
         SET ACTIVITY_CODE    =M_ACTIVITY_CODE,
            INST_TYPE         =M_INST_TYPE
            WHERE
            PORTFOLIO_CODE =M_PORTFOLIO_CODE
            AND
            INST_TYPE      =M_INST_TYPE
            AND
            ACTIVITY_CODE  =M_ACTIVITY_CODE;

--RAISE_APPLICATION_ERROR(-20201,M_PORTFOLIO_CODE||' '||M_ACTIVITY_CODE||' '||M_INST_TYPE);

         IF SQL%NOTFOUND THEN
            INSERT INTO DN_REF_PORTF_ALLOW_ACTIVITY
                (PORTFOLIO_CODE,
                ACTIVITY_CODE,
                INST_TYPE)
                     VALUES(
                       M_PORTFOLIO_CODE,
                       M_ACTIVITY_CODE,
                       M_INST_TYPE
                       );

      END IF;*/
    --END IF;


   COMMIT;


END DN_PORTFOLIOS_IN5;

/
