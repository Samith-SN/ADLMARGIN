--------------------------------------------------------
--  DDL for Procedure DN_DIV_INCOME_DELETION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_DIV_INCOME_DELETION" 
(M_DEAL_NO     DN_TRN_REPO_FRESH.DEAL_NO%TYPE,
 M_USER        DN_TIME_LOG.DN_USER%TYPE
 )

AS

ERR_NUM             VARCHAR2(200);
ERR_MSG             VARCHAR2(200);

BEGIN

--RAISE_APPLICATION_ERROR(-20001,'****'||M_DEAL_NO||'****'||M_USER||'****');

DN_VALIDATE_SAVE_RIGHTS(M_USER,'WD_Divi_Income_Deletion');  --added by ashini on 31/10/2005 for sr0509-047
--VC 05/040--------------------
DELETE DN_ACC_PORTF_GEN_ACCOUNT WHERE DOCREFNO =M_DEAL_NO;
DELETE DN_ACC_PORTF_INST_ACCOUNT WHERE DOCREFNO =M_DEAL_NO;
--END--------------------
DELETE DN_ACC_LICENCEE_GEN_ACCOUNT WHERE DOCREFNO =M_DEAL_NO;
DELETE DN_TRN_DIVIDEND_INCOME WHERE DOCREFNO =M_DEAL_NO;

INSERT INTO DN_TIME_LOG
           (SUS_REF_NO,
            DN_USER,
            ENT_DATE,
            DESCRIPTION)
           VALUES
            (
              M_DEAL_NO,
              M_USER,
              SYSDATE,
              'DIVIDEND INCOME DELETE '
             );


COMMIT;


--------EXCEPTION
EXCEPTION WHEN OTHERS THEN
ROLLBACK;
   ERR_NUM :=  substr(SQLCODE,1,15);
   ERR_MSG :=  substr(SQLERRM,1,200) ;
   RAISE_APPLICATION_ERROR(-20201,SQLCODE||SQLERRM);

END ; 

/
