--------------------------------------------------------
--  DDL for Procedure DN_PORTFOLIOS_IN4
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_PORTFOLIOS_IN4" 

    (   M_PORTFOLIO_CODE     IN OUT       DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE,
        M_ISSUER_GROUP_CODE         DN_REF_PORTF_ALLOW_INSTRUMENT.ISSUER_GROUP_CODE%TYPE,
        M_INST_TYPE                 DN_REF_PORTF_ALLOW_INSTRUMENT.INST_TYPE%TYPE,
        M_MATURITY_FROM             DN_REF_PORTF_ALLOW_INSTRUMENT.MATURITY_FROM%TYPE,

        M_MATURITY_TO               DN_REF_PORTF_ALLOW_INSTRUMENT.MATURITY_TO%TYPE,
        M_PERC_TOT_MIN              DN_REF_PORTF_ALLOW_INSTRUMENT.PERC_TOT_MIN%TYPE,
        M_PERC_TOT_AVG              DN_REF_PORTF_ALLOW_INSTRUMENT.PERC_TOT_AVG%TYPE,
        M_PERC_TOT_MAX              DN_REF_PORTF_ALLOW_INSTRUMENT.PERC_TOT_MAX%TYPE,
        M_SELECT_TYPE               CHAR,
        M_USRE                VARCHAR


   )

AS

BEGIN

DN_VALIDATE_SAVE_RIGHTS(M_USRE,'WD_Portfolios_MT');  --added by ashini on 31/10/2005 for sr0509-047

 --RAISE_APPLICATION_ERROR(-20201,M_PORTFOLIO_CODE||' '||M_ISSUER_GROUP_CODE||' '||M_INST_TYPE||' '||M_MATURITY_FROM||' '||M_MATURITY_TO||' '||M_PERC_TOT_MIN||' '||M_PERC_TOT_AVG||' '||M_PERC_TOT_MAX);

/*RAISE_APPLICATION_ERROR(-20201,M_PORTFOLIO_CODE||' '||M_TOT_EXP_LIMIT||' '|| M_PERC_TOT_EXP||' '||M_EXP_LIMIT_APPLY_METHOD);
*/

    /* PROCEDURE  - TO SAVE INSTRUMENT OPTIONS
       SYSTEM     -  DEALNET
       CREATED BY -
       CREATED ON -  */

IF M_PORTFOLIO_CODE IS NOT NULL AND M_ISSUER_GROUP_CODE<>'NULL' AND M_SELECT_TYPE='FMAIN2' THEN


         UPDATE DN_REF_PORTF_ALLOW_INSTRUMENT
         SET ISSUER_GROUP_CODE=M_ISSUER_GROUP_CODE,
             INST_TYPE        =M_INST_TYPE,
             MATURITY_FROM    =M_MATURITY_FROM,
             MATURITY_TO      =M_MATURITY_TO,
             PERC_TOT_MIN     =M_PERC_TOT_MIN,
             PERC_TOT_AVG     =M_PERC_TOT_AVG,
             PERC_TOT_MAX     =M_PERC_TOT_MAX
         WHERE
            PORTFOLIO_CODE=M_PORTFOLIO_CODE
            AND
            ISSUER_GROUP_CODE=M_ISSUER_GROUP_CODE
            AND
            INST_TYPE=M_INST_TYPE
            AND
            MATURITY_FROM    =M_MATURITY_FROM
            AND
            MATURITY_TO      =M_MATURITY_TO;

         IF SQL%NOTFOUND THEN
            INSERT INTO DN_REF_PORTF_ALLOW_INSTRUMENT
                (PORTFOLIO_CODE,
                ISSUER_GROUP_CODE,
                INST_TYPE,
                MATURITY_FROM,
                MATURITY_TO,
                PERC_TOT_MIN,
                PERC_TOT_AVG,
                PERC_TOT_MAX)
                     VALUES(
                       M_PORTFOLIO_CODE,
                       M_ISSUER_GROUP_CODE,
                       M_INST_TYPE,
                       M_MATURITY_FROM,
                       M_MATURITY_TO,
                       M_PERC_TOT_MIN,
                       M_PERC_TOT_AVG,
                       M_PERC_TOT_MAX
                      );
            END IF;
         END IF;
     COMMIT;


END DN_PORTFOLIOS_IN4;

/
