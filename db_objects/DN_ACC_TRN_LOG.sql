--------------------------------------------------------
--  DDL for Procedure DN_ACC_TRN_LOG
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_ACC_TRN_LOG" 
   (M_RUN_DATE                        varchar2,
    M_USER                            DN_ACC_MAP_LOG.DN_USER%TYPE
  
    )

AS

BEGIN
   /* PROCEDURE  -  DN_ACC_TRN_LOG
   SYSTEM     -  PABC
   CREATED BY -  WARUNA
   CREATED ON -  10/08/2010*/
  
INSERT INTO DN_ACC_MAP_LOG(RUN_DATE,DN_USER) VALUES( to_DATE(M_RUN_DATE,'DD/MM/YYYY'),M_USER);
COMMIT;
END DN_ACC_TRN_LOG;

/
