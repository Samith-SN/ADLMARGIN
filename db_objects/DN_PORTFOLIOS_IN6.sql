--------------------------------------------------------
--  DDL for Procedure DN_PORTFOLIOS_IN6
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_PORTFOLIOS_IN6" 

    (   M_PORTFOLIO_CODE IN OUT     DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE,
        M_ISSUER_CODE               DN_REF_PORTF_ALLOW_CORPORATE.ISSUER_CODE%TYPE,
        M_USRE                      VARCHAR

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

IF M_PORTFOLIO_CODE IS NOT NULL AND M_ISSUER_CODE<>'NULL'  THEN
    --IF M_INST_TYPE IS NOT NULL THEN
 --RAISE_APPLICATION_ERROR(-20201,M_PORTFOLIO_CODE||' '||M_ISSUER_CODE);

         UPDATE DN_REF_PORTF_ALLOW_CORPORATE
         SET ISSUER_CODE     =M_ISSUER_CODE
            WHERE
            PORTFOLIO_CODE   =M_PORTFOLIO_CODE
            AND
            ISSUER_CODE     =M_ISSUER_CODE;

         IF SQL%NOTFOUND THEN
            INSERT INTO DN_REF_PORTF_ALLOW_CORPORATE
                (PORTFOLIO_CODE,
                ISSUER_CODE)
                     VALUES(
                       M_PORTFOLIO_CODE,
                       M_ISSUER_CODE
                       );
          END IF;
      END IF;
 --   END IF;
   COMMIT;


END DN_PORTFOLIOS_IN6;

/
