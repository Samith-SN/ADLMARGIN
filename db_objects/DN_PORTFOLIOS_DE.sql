--------------------------------------------------------
--  DDL for Procedure DN_PORTFOLIOS_DE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_PORTFOLIOS_DE" 

   (    M_PORTFOLIO_CODE      DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE,
        M_USRE                      VARCHAR


   )

AS

BEGIN


DN_VALIDATE_SAVE_RIGHTS(M_USRE,'WD_Portfolios_MT');  --added by ashini on 31/10/2005 for sr0509-047

/*RAISE_APPLICATION_ERROR(-20201,M_PORTFOLIO_CODE ||' '||M_OWNED_BY_MBFSL||' '||M_CP_PORTFOLIO_CODE||' '||M_PF_NAME||' '||M_ADD_IDENTIFICATION||' '||M_ADD_LOCATION||' '||M_ADD_STREET||' '||M_ADD_CITY||' '||M_ADD_COUNTRY||' ' ||M_POSTAL_CODE||' '||M_DATE_INC_BIRTH||' '||M_BUSI_REG_NIC||' '||M_CATEGORY_ENTITY||' '||M_NATURE_OCCUPATION ||' '||M_SECT_CODE ||' '||M_MBFSL_SECT_CODE||' '||M_NEST_REVIEW );*/


    /* PROCEDURE  - TO DEACTIVATE PORFOLIO CODE
                  - TO DEACTIVATE COUNTER PARTY CODE
                  - TO DEACTIVATE CUSTODIAL CODE
       SYSTEM     -  DEALNET
       CREATED BY -
       CREATED ON -  */

IF M_PORTFOLIO_CODE IS NOT NULL  THEN

 UPDATE DN_REF_PORTFOLIO
       SET ACTIVE_STATUS      ='N'
        WHERE
           PORTFOLIO_CODE=M_PORTFOLIO_CODE
           AND
           ACTIVE_STATUS ='Y';


  END IF;


 COMMIT;


END DN_PORTFOLIOS_DE;

/
