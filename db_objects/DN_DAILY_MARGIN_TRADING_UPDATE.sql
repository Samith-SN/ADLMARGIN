--------------------------------------------------------
--  DDL for Procedure DN_DAILY_MARGIN_TRADING_UPDATE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_DAILY_MARGIN_TRADING_UPDATE" 
   (M_DAILY       CHAR,
    M_USERNAME   VARCHAR2
   )
AS

----------------------------------------------------------------------
    --   PROCEDURE  - TO UPDATE THE MARGIN TRADING STATUS ROUTINE DETAILS
    --   SYSTEM     - Dealnet
    --   CREATED BY - S.V.A.
    --   CREATED ON - 05-04-2004
----------------------------------------------------------------------

BEGIN

UPDATE DN_SYS_DAILY_MARGIN_TRADING
SET    LAST_DAILY = TO_DATE(M_DAILY,'DD-MM-YYYY'),
       USERNAME   = M_USERNAME;

IF SQL%NOTFOUND THEN

 INSERT INTO DN_SYS_DAILY_MARGIN_TRADING
 VALUES(TO_DATE(M_DAILY,'DD-MM-YYYY'),M_USERNAME);

END IF;
COMMIT;

END;

/
