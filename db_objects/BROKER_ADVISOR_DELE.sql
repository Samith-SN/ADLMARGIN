--------------------------------------------------------
--  DDL for Procedure BROKER_ADVISOR_DELE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."BROKER_ADVISOR_DELE" 

   (
   M_PORTFOLIO_CODE   DN_REF_PORT_BRO_CON_PERSON.PORTFOLIO_CODE%TYPE, 
   M_COUNTER_CODE  DN_REF_PORT_BRO_CON_PERSON.COUNTER_CODE%TYPE,
   M_CONT_PERSON  DN_REF_PORT_BRO_CON_PERSON.CONT_PERSON%TYPE,
   M_USRE  VARCHAR
 )

AS

 M_NUM INT;

BEGIN

DN_VALIDATE_SAVE_RIGHTS(M_USRE,'WD_Portfolios_AddAdvis');  

 IF M_PORTFOLIO_CODE IS NOT NULL AND M_COUNTER_CODE<>'NULL' AND M_CONT_PERSON<>'NULL' THEN

   SELECT COUNT(*) INTO M_NUM
        FROM DN_REF_PORT_BRO_CON_PERSON
            WHERE
            PORTFOLIO_CODE=M_PORTFOLIO_CODE
            AND
            COUNTER_CODE=M_COUNTER_CODE
            AND
            CONT_PERSON=M_CONT_PERSON;

    IF M_NUM > 0  THEN
        
         INSERT INTO dn_ref_port_bro_con_person_bk
              (PORTFOLIO_CODE,
               COUNTER_CODE,
               CONT_PERSON  
               )
   SELECT PORTFOLIO_CODE, COUNTER_CODE, CONT_PERSON
        FROM DN_REF_PORT_BRO_CON_PERSON
            WHERE
            PORTFOLIO_CODE=M_PORTFOLIO_CODE
            AND
            COUNTER_CODE=M_COUNTER_CODE
            AND
            CONT_PERSON=M_CONT_PERSON;
            
         
         DELETE FROM DN_REF_PORT_BRO_CON_PERSON
         WHERE
            PORTFOLIO_CODE=M_PORTFOLIO_CODE
            AND
            COUNTER_CODE=M_COUNTER_CODE
            AND
            CONT_PERSON=M_CONT_PERSON;
        END IF;
      END IF;
COMMIT;
END BROKER_ADVISOR_dele;

/
