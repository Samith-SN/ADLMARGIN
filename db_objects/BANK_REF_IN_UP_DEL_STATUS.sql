--------------------------------------------------------
--  DDL for Procedure BANK_REF_IN_UP_DEL_STATUS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."BANK_REF_IN_UP_DEL_STATUS" 
(
M_BRCODE       DN_REF_BANK.BRANCH_CODE%TYPE,
M_BRNAME       DN_REF_BANK.BRANCH_NAME%TYPE,
M_BADDR1       DN_REF_BANK.BANK_ADD1%TYPE,
M_BADDR2       DN_REF_BANK.BANK_ADD2%TYPE,
M_BADDR3       DN_REF_BANK.BANK_ADD3%TYPE,
M_BRTPNO       DN_REF_BANK.BRANCH_TELNO%TYPE,
M_ASTATUS      DN_REF_BANK.ACTIVE_STATUS%TYPE,
M_GSTATUS      DN_REF_BANK.GLOBUS_STATUS%TYPE,
M_OPTION 	   NUMBER,
M_USER 		   varchar
)

AS
--M_COUNT INTEGER;
--M_CURRENT DN_REF_BANK.BRANCH_CODE%TYPE;

BEGIN

DN_VALIDATE_SAVE_RIGHTS(M_USER,'WD_Banks');  --added by ashini on 31/10/2005 for sr0509-047


--RAISE_APPLICATION_ERROR(-20201,'****'||M_OPTION);
--DN_VALIDATE_SAVE_RIGHTS(M_USER,'WD_Banks');
-------------CREATE-------------------------------------------------------------------------------------
IF M_OPTION=1 THEN
    INSERT INTO DN_REF_BANK
    (BRANCH_CODE,BRANCH_NAME,BANK_ADD1,BANK_ADD2,BANK_ADD3,BRANCH_TELNO,ACTIVE_STATUS,GLOBUS_STATUS)
    VALUES
     (M_BRCODE,M_BRNAME,M_BADDR1,M_BADDR2,M_BADDR3,M_BRTPNO,M_ASTATUS,M_GSTATUS);

--------------------------------------------------------------------------------------------------------

-------------MODIFY-------------------------------------------------------------------------------------

ELSIF M_OPTION=2 THEN
--RAISE_APPLICATION_ERROR(-20201,'****'||M_BRNAME);
--RAISE_APPLICATION_ERROR(-20201,'****'||M_ASTATUS);

--add data to backup file inditha 2004/6/16



/*INSERT INTO  DN_REF_BANK_BACKUP
	(BRANCH_CODE,BRANCH_NAME,BANK_ADD1,BANK_ADD2,BANK_ADD3,BRANCH_TELNO,ACTIVE_STATUS,GLOBUS_STATUS,
    		DN_USER,DN_DATE,MOD_DATE)
 SELECT
    BRANCH_CODE,BRANCH_NAME,BANK_ADD1,BANK_ADD2,BANK_ADD3,
    BRANCH_TELNO,ACTIVE_STATUS,GLOBUS_STATUS,
		M_USER,DN_DATE,SYSDATE
 FROM DN_REF_BANK
 WHERE UPPER(BRANCH_CODE)=M_BRCODE;*/

--------------------------------------------------



    UPDATE DN_REF_BANK
    SET
    BRANCH_NAME= M_BRNAME,
    BANK_ADD1=M_BADDR1,
    BANK_ADD2=M_BADDR2,
    BANK_ADD3=M_BADDR3,
    BRANCH_TELNO=M_BRTPNO,
    ACTIVE_STATUS=M_ASTATUS,
    GLOBUS_STATUS=M_GSTATUS
    WHERE
    BRANCH_CODE=M_BRCODE;
--RAISE_APPLICATION_ERROR(-20201,'****'||M_OPTION);
----------------------------------------------------------------------------------------------------------

--------------ACTIVATE------------------------------------------------------------------------------------

ELSIF M_OPTION=3 THEN
    UPDATE DN_REF_BANK
    SET
    ACTIVE_STATUS=M_ASTATUS
    WHERE
    BRANCH_CODE=M_BRCODE ;

-----------------------------------------------------------------------------------------------------------

--------------DEACTIVATE-----------------------------------------------------------------------------------
ELSIF M_OPTION=4 THEN
    UPDATE DN_REF_BANK
    SET
    ACTIVE_STATUS=M_ASTATUS
    WHERE
    BRANCH_CODE=M_BRCODE ;

------------------------------------------------------------------------------------------------------------


END IF;

COMMIT;
END;

/
