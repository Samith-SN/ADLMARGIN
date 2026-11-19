--------------------------------------------------------
--  DDL for Procedure DN_LIMIT_COMPARE_ISS_INST_AMT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_LIMIT_COMPARE_ISS_INST_AMT" 
   (
		M_FOR_POSSIBLE            NUMBER,
        M_IGE_CODE                LMT_UTL_ISSUER_INST_AMT.ISSUER_CODE%TYPE,
        MM_INST_TYPE              LMT_UTL_ISSUER_INST_AMT.INST_TYPE %TYPE,
        M_LIA_TYPE                LMT_UTL_ISSUER_INST_AMT.ISSUER_LIABILITY_TYPE%TYPE
   )

   IS
            MN_COUNT      NUMBER;
    -- Procedue     : Compare actuals with allowed to identify the violations and possible violation
    -- System       : Dealnet system
    -- Created by   :
    -- Created on   : 29/11/1999

       CURSOR MYCURSOR IS


            SELECT  CURRENT_UTILIZATION,DN_USER,ISSUER_CODE,INST_TYPE,ISSUER_LIABILITY_TYPE
            FROM LMT_UTL_ISSUER_INST_AMT
            WHERE  ISSUER_CODE =M_IGE_CODE AND
                   INST_TYPE=MM_INST_TYPE AND
                  ISSUER_LIABILITY_TYPE=M_LIA_TYPE;


        M_CURRENT_UTILIZATION		LMT_UTL_ISSUER_INST_AMT.CURRENT_UTILIZATION%TYPE;
   		M_COUNT						NUMBER;
		M_LIMIT_CODE				LMT_STR_OVRL_AMT.LIMIT_CODE%TYPE;
		M_ACTIVE_STATUS				VARCHAR2(1);
		M_ACTIVE_COUNT				NUMBER;
		M_DN_USER					DN_TRN_OUTP_SALE.DN_USER%TYPE;
		M_POSSIBLE_STATUS			VARCHAR2(1);
		M_END_AMOUNT				LMT_STR_OVRL_AMT.END_AMOUNT%TYPE;
		M_LIMIT_WARNING_LEVEL		NUMBER;
        M_COUNT_UTILIZATION			NUMBER;
        M_LIMIT_CODE_MIN            LMT_STR_OVRL_AMT.LIMIT_CODE%TYPE;
        M_COUNT_LIMIT_CODE_MIN      NUMBER;
        M_AUCTION_TYPE              LMT_UTL_ISSUER_INST_AMT.AUCTION_TYPE%TYPE;
        M_ISSUER_CODE               LMT_UTL_ISSUER_INST_AMT.ISSUER_CODE%TYPE;
        M_ISSUER_LIABILITY_TYPE     LMT_UTL_ISSUER_INST_AMT.ISSUER_LIABILITY_TYPE%TYPE;
        M_INST_TYPE                 LMT_UTL_ISSUER_INST_AMT.INST_TYPE %TYPE;
        MM_COUNT_EXCEED              NUMBER;


	BEGIN
        --  DBMS_OUTPUT.PUT_LINE('INSIDE COMPARISON PROCEDURE');
       DELETE FROM LMT_EXC_CURRENT WHERE LIMIT_CODE LIKE (('04'||'-'||M_IGE_CODE||'-S-'||M_LIA_TYPE||'-'||MM_INST_TYPE)||'%');
     -- DELETE FROM LMT_EXC_UNCONF WHERE LIMIT_CODE LIKE '04%';
      DELETE FROM LMT_EXC_UNCONF WHERE LIMIT_CODE LIKE (('04'||'-'||M_IGE_CODE||'-S-'||M_LIA_TYPE||'-'||MM_INST_TYPE)||'%');







            OPEN MYCURSOR;
        LOOP
    		FETCH MYCURSOR INTO M_CURRENT_UTILIZATION,M_DN_USER,M_ISSUER_CODE,M_INST_TYPE,M_ISSUER_LIABILITY_TYPE;
            EXIT WHEN MYCURSOR%NOTFOUND;

/*RAISE_APPLICATION_ERROR(-20201,'^^^^^^^^^^^'||'M_CURRENT_UTILIZATION=='||M_CURRENT_UTILIZATION||
                                'M_DN_USER=='||M_DN_USER||
                                'M_ISSUER_CODE=='||M_ISSUER_CODE||
                                'M_INST_TYPE=='||M_INST_TYPE||
                                'M_ISSUER_LIABILITY_TYPE=='||M_ISSUER_LIABILITY_TYPE||
                                'M_FOR_POSSIBLE=='||M_FOR_POSSIBLE||
                                'M_IGE_CODE=='||M_IGE_CODE||
                                'MM_INST_TYPE=='||MM_INST_TYPE||
                                'M_LIA_TYPE=='||M_LIA_TYPE); */




 IF ( M_CURRENT_UTILIZATION IS NOT NULL AND M_CURRENT_UTILIZATION>0 ) THEN



                        SELECT COUNT(*)
                    INTO   MN_COUNT
                    FROM   LMT_STR_ISSUER_INST_AMT
                    WHERE  ISSUER_CODE=M_ISSUER_CODE AND
                           INST_TYPE=M_INST_TYPE AND
                           ISSUER_LIABILITY_TYPE=M_ISSUER_LIABILITY_TYPE ;

        IF(MN_COUNT>0) THEN


       /*SELECT  COUNT(*)
     INTO    M_COUNT_UTILIZATION
     FROM    LMT_UTL_ISSUER_INST_AMT;

          IF (M_COUNT_UTILIZATION>0) THEN
            	SELECT CURRENT_UTILIZATION
                INTO   M_CURRENT_UTILIZATION
          		FROM   LMT_UTL_ISSUER_INST_AMT;
          ELSE
               M_CURRENT_UTILIZATION:=NULL;
          END IF;
      IF ( M_CURRENT_UTILIZATION IS NOT NULL AND M_CURRENT_UTILIZATION>0 ) THEN*/


        SELECT COUNT(*)
        INTO M_COUNT
        FROM LMT_STR_ISSUER_INST_AMT
    	WHERE   M_CURRENT_UTILIZATION > START_AMOUNT
                AND M_CURRENT_UTILIZATION <=END_AMOUNT
                AND CONDITION='B'
               -- AND SUBSTR(LIMIT_CODE,4,4) = M_ISSUER_CODE
                AND ISSUER_CODE=M_ISSUER_CODE
                AND INST_TYPE=M_INST_TYPE
                AND ISSUER_LIABILITY_TYPE=M_ISSUER_LIABILITY_TYPE;
/*RAISE_APPLICATION_ERROR(-20201,'M_COUNT===>'||M_COUNT||
                               'M_CURRENT_UTILIZATION===>'||M_CURRENT_UTILIZATION||
                               'M_ISSUER_CODE===>'||M_ISSUER_CODE||
                               'M_INST_TYPE===>'||M_INST_TYPE||
                               'M_ISSUER_LIABILITY_TYPE===>'||M_ISSUER_LIABILITY_TYPE||
                               'M_IGE_CODE===>'||M_IGE_CODE);
*/

               IF (M_COUNT>0) THEN
    	    	SELECT LIMIT_CODE
                INTO M_LIMIT_CODE
                FROM LMT_STR_ISSUER_INST_AMT
    			WHERE  M_CURRENT_UTILIZATION > START_AMOUNT
                       AND M_CURRENT_UTILIZATION <=END_AMOUNT
                       AND CONDITION='B'
                     --  AND SUBSTR(LIMIT_CODE,4,4) = M_ISSUER_CODE
                       AND ISSUER_CODE=M_ISSUER_CODE
                       AND INST_TYPE=M_INST_TYPE
                       AND ISSUER_LIABILITY_TYPE = M_ISSUER_LIABILITY_TYPE ;

                M_POSSIBLE_STATUS:='T' ;
--DBMS_OUTPUT.PUT_LINE(M_COUNT||M_CURRENT_UTILIZATION||M_ISSUER_CODE||M_INST_TYPE||M_ISSUER_LIABILITY_TYPE);

    	     ELSE

--DBMS_OUTPUT.PUT_LINE(''||M_COUNT||M_CURRENT_UTILIZATION||M_ISSUER_CODE||M_INST_TYPE||M_ISSUER_LIABILITY_TYPE);
                  SELECT LIMIT_CODE
                 INTO M_LIMIT_CODE
                 FROM LMT_STR_ISSUER_INST_AMT
    			 WHERE  CONDITION='G'
                 AND ISSUER_CODE=M_ISSUER_CODE
                 AND INST_TYPE=M_INST_TYPE
                 AND ISSUER_LIABILITY_TYPE = M_ISSUER_LIABILITY_TYPE ;



                 M_POSSIBLE_STATUS:='F' ;


    	     END IF;
             SELECT COUNT(*)
             INTO M_ACTIVE_COUNT
             FROM LMT_ACT_DETAILS
             WHERE LIMIT_CODE=M_LIMIT_CODE
                   AND ACTIVE_STATUS='Y' ;

					IF ( M_ACTIVE_COUNT > 0 ) THEN
						M_ACTIVE_STATUS:='Y';
					ELSE
						M_ACTIVE_STATUS:='N';
					END IF;

      	IF ( M_ACTIVE_STATUS ='N' ) THEN  /* THERE IS A VIOLATION.INSERT VIOLATION */
    	       --SELECTING  LIMIT_CODE
                SELECT COUNT(*)
                INTO M_COUNT_LIMIT_CODE_MIN
                FROM LMT_ACT_DETAILS A,
                     LMT_STR_ISSUER_INST_AMT B
                WHERE    A.ACTIVE_STATUS='Y'
                         AND SUBSTR(A.LIMIT_CODE,4,(INSTR(A.LIMIT_CODE,'-',1,2)-4))=M_ISSUER_CODE
                         AND A.LIMIT_TYPE='04'
                         AND B.ISSUER_CODE=M_ISSUER_CODE
                         AND B.INST_TYPE=M_INST_TYPE
                         AND B.ISSUER_LIABILITY_TYPE=M_ISSUER_LIABILITY_TYPE;


                      IF (M_COUNT_LIMIT_CODE_MIN>0) THEN

                            SELECT DISTINCT LIMIT_CODE
                          INTO M_LIMIT_CODE_MIN
                          FROM LMT_STR_ISSUER_INST_AMT
                          WHERE  INST_TYPE=M_INST_TYPE
                                 AND ISSUER_CODE=M_ISSUER_CODE
                                 AND ISSUER_LIABILITY_TYPE=M_ISSUER_LIABILITY_TYPE
                                 AND START_AMOUNT=(
                                          SELECT MAX(B.START_AMOUNT)
                                          FROM LMT_ACT_DETAILS A,LMT_STR_ISSUER_INST_AMT B
                                          WHERE A.LIMIT_CODE=B.LIMIT_CODE
                                                AND SUBSTR(A.LIMIT_CODE,4,(INSTR(A.LIMIT_CODE,'-',1,2)-4))=M_ISSUER_CODE
                                                AND A.ACTIVE_STATUS='Y'
                                                AND B.ISSUER_CODE=M_ISSUER_CODE
                                                 AND B.INST_TYPE=M_INST_TYPE
                                                 AND B.ISSUER_LIABILITY_TYPE=M_ISSUER_LIABILITY_TYPE);



                             /* SELECT MAX(LIMIT_CODE) INTO M_LIMIT_CODE_MIN
                        FROM LMT_ACT_DETAILS
                        WHERE  ACTIVE_STATUS='Y'
                        AND LIMIT_TYPE='04';*/
                     ELSE
                    --IF NO LIMIT CODE WAS ACTIVATED
                    --M_LIMIT_CODE_MIN:='04-%-0001';

                          SELECT  LIMIT_CODE
                          INTO    M_LIMIT_CODE_MIN
                          FROM    LMT_STR_ISSUER_INST_AMT
                          WHERE   INST_TYPE=M_INST_TYPE
                                  AND ISSUER_CODE=M_ISSUER_CODE
                                  AND ISSUER_LIABILITY_TYPE=M_ISSUER_LIABILITY_TYPE
                                  AND START_AMOUNT=0;
                    END IF;

                                  SELECT COUNT(*)
                                   INTO  MM_COUNT_EXCEED
                                   FROM  LMT_EXC_CURRENT
                                   WHERE  LIMIT_CODE=M_LIMIT_CODE_MIN;

                                   IF(MM_COUNT_EXCEED=0)THEN
                                       INSERT INTO LMT_EXC_CURRENT
    			                       	   ( LIMIT_CODE, VIOLATED_DATE, VIOLATED_BY, ACTIVATED_TYPE )
                              			  VALUES (M_LIMIT_CODE_MIN , SYSDATE , M_DN_USER ,'Y') ;
                                    END IF;

                /*INSERT INTO LMT_EXC_UNCONF
    				( LIMIT_CODE, VIOLATED_DATE, VIOLATED_BY, ACTIVATED_TYPE )
    				VALUES (M_LIMIT_CODE_MIN , SYSDATE , M_DN_USER ,'Y') ;*/
                         IF (M_FOR_POSSIBLE=1) THEN
                                 INSERT INTO LMT_EXC_UNCONF
                                      ( LIMIT_CODE , VIOLATED_DATE , VIOLATED_BY , ACTIVATED_TYPE )
                                  VALUES(M_LIMIT_CODE_MIN , SYSDATE , M_DN_USER , 'Y');
                         END IF;


        ELSIF ( M_ACTIVE_STATUS ='Y' ) THEN  	/*	SUCH LIMIT IS ACTIVATED	*/
              NULL;
    	END IF ;
 END IF;
 END IF;
 END LOOP;
 CLOSE MYCURSOR;
            --RAISE_APPLICATION_ERROR(-20201,'@@@@'||' '||M_DN_USER);
            --COMMIT;
 END DN_LIMIT_COMPARE_ISS_INST_AMT;

/
