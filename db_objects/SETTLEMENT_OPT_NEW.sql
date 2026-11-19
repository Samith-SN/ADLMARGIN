--------------------------------------------------------
--  DDL for Procedure SETTLEMENT_OPT_NEW
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."SETTLEMENT_OPT_NEW" 
   (m_BRANCH_CODE       DN_REF_LICENCEE_SETTLEMENT.BRANCH_CODE%TYPE,
    m_ACC_NO            DN_REF_LICENCEE_SETTLEMENT.ACC_NO%TYPE,
    m_ACC_SYS_REFNO     DN_REF_LICENCEE_SETTLEMENT.ACC_SYS_REFNO%TYPE,
    M_USER              varchar
    )
AS
BEGIN

DN_VALIDATE_SAVE_RIGHTS(M_USER,'WD_Settlement_Options');  --added by ashini on 31/10/2005 for sr0509-047


    /* PROCEDURE  - TO MODIFY LICENCEE SETTLEMENT FILE
       SYSTEM     - DEALNET
       CREATED BY - UPUL
       CREATED ON - 07/14/1999 */
INSERT INTO DN_REF_LICENCEE_SETTLEMENT
            (BRANCH_CODE,ACC_NO, ACC_SYS_REFNO)
       VALUES
            (M_BRANCH_CODE,M_ACC_NO, M_ACC_SYS_REFNO);
COMMIT;
END SETTLEMENT_OPT_NEW;

/
