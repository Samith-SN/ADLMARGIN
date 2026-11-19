--------------------------------------------------------
--  DDL for Procedure DN_PORTFOLIOS_IN7
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_PORTFOLIOS_IN7" 

    (   M_PORTFOLIO_CODE   IN OUT     DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE,
        M_CP_PORTFOLIO_CODE           DN_REF_PORTF_ALLOW_CP.CP_PORTFOLIO_CODE%TYPE,
        M_USRE                        VARCHAR

      --  M_SELECT_TYPE               CHAR
    )

AS

BEGIN

DN_VALIDATE_SAVE_RIGHTS(M_USRE,'WD_Portfolios_MT');  --added by ashini on 31/10/2005 for sr0509-047


/*RAISE_APPLICATION_ERROR(-20201,M_PORTFOLIO_CODE||' '||M_ACTIVITY_CODE||' '||M_INST_TYPE);*/

    /* PROCEDURE  - TO SAVE INSTRUMENT OPTIONS
       SYSTEM     -  DEALNET
       CREATED BY -
       CREATED ON -  */

IF M_PORTFOLIO_CODE IS NOT NULL AND M_CP_PORTFOLIO_CODE<>'NULL'  THEN
    --IF M_INST_TYPE IS NOT NULL THEN

         UPDATE DN_REF_PORTF_ALLOW_CP
         SET CP_PORTFOLIO_CODE =M_CP_PORTFOLIO_CODE
            WHERE
            PORTFOLIO_CODE     =M_PORTFOLIO_CODE
            AND
            CP_PORTFOLIO_CODE  =M_CP_PORTFOLIO_CODE;

         IF SQL%NOTFOUND THEN
            INSERT INTO DN_REF_PORTF_ALLOW_CP
                (PORTFOLIO_CODE,
                CP_PORTFOLIO_CODE)
                     VALUES(
                       M_PORTFOLIO_CODE,
                       M_CP_PORTFOLIO_CODE
                       );
          END IF;
      END IF;
 --   END IF;
   COMMIT;


END DN_PORTFOLIOS_IN7;

/
