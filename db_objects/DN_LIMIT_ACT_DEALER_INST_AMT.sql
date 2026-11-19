--------------------------------------------------------
--  DDL for Procedure DN_LIMIT_ACT_DEALER_INST_AMT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_LIMIT_ACT_DEALER_INST_AMT" 
(
 M_LIMIT_CODE                  LMT_EXC_CURRENT.LIMIT_CODE%TYPE
)
IS

    -- Procedue     : to delete limit codes from lmt_exc_current table when a limit code is activated(approved)
    -- System       : Dealnet system
    -- Created by   : nirmala fernando.
    -- Created on   : 20/03/2001

BEGIN

      DELETE
      FROM   LMT_EXC_CURRENT
      WHERE  (LIMIT_CODE=M_LIMIT_CODE) OR
             (SUBSTR(LIMIT_CODE,(INSTR(LIMIT_CODE,'-',1,5)+1),(LENGTH(LIMIT_CODE)-(INSTR(LIMIT_CODE,'-',1,5))))<
              SUBSTR(M_LIMIT_CODE,(INSTR(M_LIMIT_CODE,'-',1,5)+1),(LENGTH(M_LIMIT_CODE)-(INSTR(M_LIMIT_CODE,'-',1,5))))
              AND LIMIT_CODE LIKE SUBSTR(M_LIMIT_CODE,1,INSTR(M_LIMIT_CODE,'-',1,5))||'%');


      DELETE
      FROM   LMT_EXC_UNCONF
      WHERE  (LIMIT_CODE=M_LIMIT_CODE) OR
             (SUBSTR(LIMIT_CODE,(INSTR(LIMIT_CODE,'-',1,5)+1),(LENGTH(LIMIT_CODE)-(INSTR(LIMIT_CODE,'-',1,5))))<
              SUBSTR(M_LIMIT_CODE,(INSTR(M_LIMIT_CODE,'-',1,5)+1),(LENGTH(M_LIMIT_CODE)-(INSTR(M_LIMIT_CODE,'-',1,5))))
              AND LIMIT_CODE LIKE SUBSTR(M_LIMIT_CODE,1,INSTR(M_LIMIT_CODE,'-',1,5))||'%');


 COMMIT;
 END DN_LIMIT_ACT_DEALER_INST_AMT;

/
