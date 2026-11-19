--------------------------------------------------------
--  DDL for Procedure DN_INVENTORY_MODI_REPO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_INVENTORY_MODI_REPO" 
(
M_portfolio_code    DN_INV_REPO_DEAL_SERIAL_NO.portfolio_code%TYPE,
M_eff_valdate       VARCHAR2,
M_inst_type         DN_INV_REPO_DEAL_SERIAL_NO.inst_type%TYPE,
M_security_code     DN_INV_REPO_DEAL_SERIAL_NO.security_code%TYPE,
M_deal_no           DN_INV_REPO_DEAL_SERIAL_NO.deal_no%TYPE,
M_serial_no         DN_INV_REPO_DEAL_SERIAL_NO.serial_no%TYPE,
M_serial_no2        DN_INV_REPO_DEAL_SERIAL_NO.serial_no%TYPE
)
AS

   /*  PROCEDURE  - DN_INVENTORY_MODI_REPO SAVING INVENTORY MODIFICATION--REPO
       SYSTEM     - DEALNET
       CREATED BY - SUKATHISVARAN
       CREATED ON - 31/AUGUEST/1999  */

BEGIN
--RAISE_APPLICATION_ERROR(-20201,M_PORTFOLIO_CODE||' '||M_eff_valdate||' '||M_inst_type||''||M_security_code||' '||M_deal_no||' '||M_serial_no||' '||M_serial_no2);

UPDATE DN_INV_REPO_DEAL_SERIAL_NO SET serial_no=M_serial_no2
WHERE portfolio_code=M_portfolio_code and eff_valdate=TO_DATE(M_eff_valdate,'DD-MON-YYYY')
      and inst_type=M_inst_type  and security_code=M_security_code and deal_no=M_deal_no and
      serial_no=M_serial_no ;

COMMIT;

END DN_INVENTORY_MODI_REPO;

/
