--------------------------------------------------------
--  DDL for Procedure DN_PORT_ADV_SAVE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_PORT_ADV_SAVE" 
(
M_PORT_CODE       DN_REF_PORT_ADV.PORT_CODE%TYPE,
M_ADV_CODE        DN_REF_PORT_ADV.ADV_CODE%TYPE,
--m_ADV_NAME        DN_REF_ADVISOR.ADV_NAME%TYPE,
M_OPTION          VARCHAR
)

AS
M_BROKER_CODE        VARCHAR(6);
mm_ADV_CODE          DN_REF_PORT_ADV.ADV_CODE%TYPE;
M_COUNT              NUMBER;

BEGIN
--RAISE_APPLICATION_ERROR(-20201,'***RRRRRRRRRRR****'||m_ADV_CODE||m_PORT_CODE||m_OPTION);

    /* PROCEDURE  - TO SAVE NEW ADVISOR NAME
       SYSTEM     - DEALNET --MSB0005
       CREATED BY - SHANHEETHA
       CREATED ON - 12/12/2005 */
       
        

    IF  (M_OPTION = 'NEW')   THEN
   
     
            BEGIN
                SELECT BROKER_CODE INTO M_BROKER_CODE FROM DN_REF_ADVISOR
                WHERE UPPER(ADV_CODE) =UPPER(M_ADV_CODE);

                EXCEPTION WHEN NO_DATA_FOUND THEN
                    m_BROKER_CODE := NULL;

                
            END;

            INSERT INTO DN_REF_PORT_ADV
            (PORT_CODE,ADV_CODE,BROKER_CODE )
            VALUES
            (UPPER(M_PORT_CODE),UPPER(M_ADV_CODE),UPPER(M_BROKER_CODE));
            
      



    ELSE IF (M_OPTION = 'MOD' or M_OPTION = 'EDIT') THEN

      
    
            --SELECT COUNT(UPPER(BROKER_CODE)) INTO M_COUNT FROM DN_REF_ADVISOR
           -- WHERE UPPER(ADV_CODE) =UPPER(M_ADV_CODE);
           
           
                 SELECT COUNT(BROKER_CODE) INTO M_COUNT FROM DN_REF_ADVISOR
                 WHERE UPPER(ADV_CODE) =UPPER(M_ADV_CODE);
                 


            IF  (M_COUNT =1 OR M_COUNT=0) THEN

                BEGIN
                
                    SELECT UPPER(BROKER_CODE) INTO M_BROKER_CODE FROM DN_REF_ADVISOR
                    WHERE UPPER(ADV_CODE) =UPPER(M_ADV_CODE);  -- changed from mm_ADV_CODE to m_ADV_CODE - - By manjula on 24-04-2006 for SRF 06+04-071..

                    EXCEPTION WHEN NO_DATA_FOUND THEN
                    M_BROKER_CODE:=NULL;
                    
                END;
                


                UPDATE DN_REF_PORT_ADV
                SET
                ADV_CODE=UPPER(DECODE(M_ADV_CODE,'-',NULL,M_ADV_CODE)),
                BROKER_CODE=UPPER(M_BROKER_CODE)
                WHERE  UPPER(PORT_CODE)=UPPER(M_PORT_CODE) ;
                
                IF SQL%NOTFOUND THEN

                INSERT INTO DN_REF_PORT_ADV
                (PORT_CODE,ADV_CODE,BROKER_CODE )
                VALUES
                (UPPER(M_PORT_CODE),UPPER(M_ADV_CODE),UPPER(m_BROKER_CODE) ); -- changed from mm_ADV_CODE to m_ADV_CODE - - By manjula on 24-04-2006 for SRF 06+04-071..
                END IF;
                
            ELSIF( M_COUNT >1 ) THEN
                raise_application_error(-20001,'<B>You maped move than one Adviser</B>');
                
            END IF;

            /*
            COMMENTED BY MADHAWA 2012-01-11
            IF SQL%NOTFOUND THEN

                INSERT INTO DN_REF_PORT_ADV
                (PORT_CODE,ADV_CODE,BROKER_CODE )
                VALUES
                (UPPER(M_PORT_CODE),UPPER(M_ADV_CODE),UPPER(m_BROKER_CODE) ); -- changed from mm_ADV_CODE to m_ADV_CODE - - By manjula on 24-04-2006 for SRF 06+04-071..
                END IF;
             */
            END IF;

       
       /*UPDATE DN_REF_PORT_ADV SET
       ADV_CODE=m_ADV_CODE,BROKER_CODE=m_BROKER_CODE
       WHERE  PORT_CODE=m_PORT_CODE ;*/
       
        
  END IF;
  
COMMIT;

END DN_PORT_ADV_SAVE; 

/
