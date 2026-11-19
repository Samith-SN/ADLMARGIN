--------------------------------------------------------
--  DDL for Procedure DN_TRANS_SCRIPLESS_COMM
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_TRANS_SCRIPLESS_COMM" 
(
M_TRANS_NO           DN_INV_OUTPS_DEAL_SERIAL_NO.DEAL_NO%TYPE
)
AS

BEGIN

    --PURPOSE     : TO COMMIT DATA FROM  SCRIPLESS SYSTEM TRANSFERES
    --CREATED ON  : 06-06-2001.
    --CREATED BY  : NIRMALA FERNANDO.
    --SYSTEM      : DEALNET.






COMMIT;
END DN_TRANS_SCRIPLESS_COMM;

/
