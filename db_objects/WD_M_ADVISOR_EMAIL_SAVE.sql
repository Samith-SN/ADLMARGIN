--------------------------------------------------------
--  DDL for Procedure WD_M_ADVISOR_EMAIL_SAVE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."WD_M_ADVISOR_EMAIL_SAVE" 

   (M_ADV_CODE           IN OUT  DN_REF_ADVISOR.ADV_CODE%TYPE,
    M_EMAIL              varchar,--DN_REF_ADV_CONT_EMAIL.EMAIL%TYPE
    M_SELECT_TYPE        varchar
    )

AS
    M_FULL_DATE_DOB_D    DN_REF_ADVISOR.ADV_DOB%TYPE;
    M_NUME NUMBER;
    M_VALE NUMBER;
BEGIN

    /* PROCEDURE  - TO add new advisor details
       SYSTEM     - DEALNET
       CREATED BY - nirmala
       CREATED ON - 07/14/1999 */



 -------------------------------e-mail---------------------------------------
     --Select e-mail--COUNT------
  IF M_ADV_CODE IS NULL THEN 
          
       SELECT LPAD(TO_CHAR(DN_SEQ_ADVISOR_CODE.NEXTVAL),8,'0') INTO M_ADV_CODE FROM DUAL;
       M_ADV_CODE:=  'ADV-'||M_ADV_CODE;
       END IF;   
     
if M_SELECT_TYPE='SAVE' then

   SELECT COUNT(*) INTO M_NUME
        FROM DN_REF_ADV_CONT_EMAIL
             WHERE ADV_CODE=M_ADV_CODE;
             
    IF M_NUME >0  THEN
         SELECT  MAX(NVL(SEQ_NO,0))  INTO M_VALE
         FROM DN_REF_ADV_CONT_EMAIL
         WHERE ADV_CODE=M_ADV_CODE;

          M_VALE:=M_VALE+1;
      ELSE
          M_VALE:=1;

    END IF;
 -- RAISE_APPLICATION_ERROR(-20201,M_VAL1);

      IF M_EMAIL IS NOT NULL THEN
        UPDATE DN_REF_ADV_CONT_EMAIL
         SET EMAIL=M_EMAIL,
             SEQ_NO=M_VALE
         WHERE
            ADV_CODE=M_ADV_CODE
            AND
            EMAIL=M_EMAIL;


    IF SQL%NOTFOUND THEN

            INSERT INTO DN_REF_ADV_CONT_EMAIL
              (ADV_CODE,
               EMAIL,
               SEQ_NO
               )
              VALUES(M_ADV_CODE,
                   M_EMAIL,
                   M_VALE
                   );
        END IF;
      END IF;
      
  ELSIF M_SELECT_TYPE='DELETE' THEN
  DELETE  FROM DN_REF_ADV_CONT_EMAIL WHERE ADV_CODE=M_ADV_CODE;    
  END IF;
  
 
   

  
COMMIT;
END ;

/
