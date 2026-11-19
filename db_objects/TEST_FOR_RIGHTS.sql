--------------------------------------------------------
--  DDL for Procedure TEST_FOR_RIGHTS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."TEST_FOR_RIGHTS" 
(
M_EFF_DATE      VARCHAR2
)
AS

/* PROCEDURE  - G_1 Transfers between MBFSL Bank Accounts
   CREATED BY - SUKATHISVARAN
   CREATED ON - 20/MARCH/2000*/

M_TRNDATE         date;

BEGIN
    SELECT sysdate
    into   M_TRNDATE
    from   dual;




END ;

/
