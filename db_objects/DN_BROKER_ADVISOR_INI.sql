--------------------------------------------------------
--  DDL for Procedure DN_BROKER_ADVISOR_INI
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_BROKER_ADVISOR_INI" 

   (    M_PORTFOLIO_CODE    DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE,
        M_COUNTER_CODE      DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE,
        M_CONT_PERSON       DN_REF_PORTF_CONT_PERSON.CONT_PERSON_%TYPE,
        M_USER              VARCHAR2
            
   )

AS

    M_NUM INT;

BEGIN

DN_VALIDATE_SAVE_RIGHTS(M_USER,'WD_Portfolios_AddAdvis');  


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


       INSERT INTO DN_REF_PORT_BRO_CON_PERSON
              (PORTFOLIO_CODE,
               COUNTER_CODE,
               CONT_PERSON,
               created_date,
               last_modified
               )
              VALUES(M_PORTFOLIO_CODE,
                   M_COUNTER_CODE,
                   M_CONT_PERSON,
                   SYSDATE,
                   SYSDATE
                   );
      
   ELSE
        INSERT INTO DN_REF_PORT_BRO_CON_PERSON
              (PORTFOLIO_CODE,
               COUNTER_CODE,
               CONT_PERSON,
               created_date,
               last_modified  
               )
              VALUES(M_PORTFOLIO_CODE,
                   M_COUNTER_CODE,
                   M_CONT_PERSON,
                   SYSDATE,
                   SYSDATE
                   );
         END IF;
      END IF;

 COMMIT;

END dn_broker_advisor_ini;

/
