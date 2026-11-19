--------------------------------------------------------
--  DDL for Procedure DN_LIMIT_COMP_DEALER_INST_AMT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_LIMIT_COMP_DEALER_INST_AMT" 
(
 M_FOR_POSSIBLE               NUMBER,
 M_DEALER                     LMT_UTL_DEALER_INST_AMT.DEALER_CODE%TYPE,
 MM_TRADE_TYPE               LMT_UTL_DEALER_INST_AMT.TRADE_TYPE%TYPE

)
IS

    -- Procedue     : Compare actuals with allowed to identify the violations and possible violations.
    -- System       : Dealnet system
    -- Created by   : nirmala fernando.
    -- Created on   : 06/03/2001

 CURSOR MYCURSOR IS
        SELECT  CURRENT_UTILIZATION,DN_USER,DEALER_CODE,INST_TYPE,TRADE_TYPE
        FROM    LMT_UTL_DEALER_INST_AMT
        WHERE   DEALER_CODE=M_DEALER AND
                TRADE_TYPE=MM_TRADE_TYPE ;


        M_CURRENT_UTILIZATION		LMT_UTL_OVRL_TRA.CURRENT_UTILIZATION%TYPE;
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
        M_DEALER_CODE               LMT_UTL_DEALER_INST_AMT.DEALER_CODE%TYPE;
        --M_ISSUER_LIABILITY_TYPE     LMT_UTL_ISSUER_INST_AMT.ISSUER_LIABILITY_TYPE%TYPE;
        M_INST_TYPE                 LMT_UTL_ISSUER_INST_AMT.INST_TYPE %TYPE;
        M_TRADE_TYPE                 LMT_UTL_DEALER_INST_AMT.TRADE_TYPE %TYPE;
        MM_COUNT_EXCEED               NUMBER;
        MN_COUNT                     NUMBER;
BEGIN

      DELETE
      FROM   LMT_EXC_CURRENT
      WHERE  LIMIT_CODE LIKE (('08'||'-'||M_DEALER||'-S-ALL'||MM_TRADE_TYPE)||'%') ;

--SELECT SUBSTR('ABCD',(LENGTH('ABCD')-1),(LENGTH('ABCD'))) FROM DUAL

      DELETE
      FROM   LMT_EXC_UNCONF
      WHERE  LIMIT_CODE LIKE (('08'||'-'||M_DEALER||'-S-ALL'||MM_TRADE_TYPE)||'%') ;

--LIMIT_CODE LIKE ((C.LIMIT_TYPE||'-'||C.DEALER_CODE||'-S-ALL')||'%')



OPEN MYCURSOR;
LOOP
    FETCH MYCURSOR
    INTO  M_CURRENT_UTILIZATION,M_DN_USER,M_DEALER_CODE,M_INST_TYPE,M_TRADE_TYPE;
EXIT WHEN MYCURSOR%NOTFOUND;

  IF(M_CURRENT_UTILIZATION IS NOT NULL AND M_CURRENT_UTILIZATION>0)THEN

                    SELECT COUNT(*)
                    INTO   MN_COUNT
                    FROM   LMT_STR_DEALER_INST_OVRL_AMT
                    WHERE   DEALER_CODE=M_DEALER_CODE AND
                            TRADE_TYPE=M_TRADE_TYPE ;

        IF(MN_COUNT>0) THEN



        SELECT COUNT(*)
        INTO   M_COUNT
        FROM   LMT_STR_DEALER_INST_OVRL_AMT
    	WHERE  M_CURRENT_UTILIZATION > START_AMOUNT AND
               M_CURRENT_UTILIZATION <=END_AMOUNT AND
               CONDITION='B' AND
               --SUBSTR(LIMIT_CODE,4,4) = M_DEALER_CODE AND
               DEALER_CODE=M_DEALER_CODE AND
               INST_TYPE=M_INST_TYPE AND
               TRADE_TYPE=M_TRADE_TYPE ;

    	     IF (M_COUNT>0) THEN
                M_POSSIBLE_STATUS:='T' ;
                SELECT LIMIT_CODE
                INTO   M_LIMIT_CODE
                FROM   LMT_STR_DEALER_INST_OVRL_AMT
    			WHERE  M_CURRENT_UTILIZATION>START_AMOUNT AND
                       M_CURRENT_UTILIZATION<=END_AMOUNT  AND
                       CONDITION='B' AND
                       --SUBSTR(LIMIT_CODE,4,4)=M_DEALER_CODE AND
                       DEALER_CODE=M_DEALER_CODE AND
                       INST_TYPE=M_INST_TYPE AND
                       TRADE_TYPE=M_TRADE_TYPE;
     	     ELSE
                M_POSSIBLE_STATUS:='F' ;
                SELECT LIMIT_CODE
                INTO   M_LIMIT_CODE
                FROM   LMT_STR_DEALER_INST_OVRL_AMT
    			WHERE  CONDITION='G' AND
                       DEALER_CODE=M_DEALER_CODE AND
                       INST_TYPE=M_INST_TYPE AND
                       TRADE_TYPE=M_TRADE_TYPE ;
    	     END IF;


     SELECT COUNT(*)
     INTO   M_ACTIVE_COUNT
     FROM   LMT_ACT_DETAILS
     WHERE  LIMIT_CODE=M_LIMIT_CODE AND
            ACTIVE_STATUS='Y' ;

					IF(M_ACTIVE_COUNT>0)THEN
						M_ACTIVE_STATUS:='Y';
					ELSE
						M_ACTIVE_STATUS:='N';
					END IF;


      	  IF(M_ACTIVE_STATUS='N')THEN  /* THERE IS A VIOLATION.INSERT VIOLATION */
    	        SELECT COUNT(*)
                INTO   M_COUNT_LIMIT_CODE_MIN
                FROM   LMT_ACT_DETAILS A,
                       LMT_STR_DEALER_INST_OVRL_AMT B
                WHERE  A.ACTIVE_STATUS='Y' AND
                       A.LIMIT_TYPE='08' AND
                       B.DEALER_CODE=M_DEALER_CODE AND
                       B.INST_TYPE=M_INST_TYPE AND
                       B.TRADE_TYPE=M_TRADE_TYPE;

                    IF(M_COUNT_LIMIT_CODE_MIN>0)THEN
                          SELECT DISTINCT LIMIT_CODE
                          INTO   M_LIMIT_CODE_MIN
                          FROM   LMT_STR_DEALER_INST_OVRL_AMT
                          WHERE  INST_TYPE=M_INST_TYPE AND
                                 DEALER_CODE=M_DEALER_CODE AND
                                 TRADE_TYPE=M_TRADE_TYPE AND
                                 START_AMOUNT=(SELECT MAX(B.START_AMOUNT)
                                               FROM   LMT_ACT_DETAILS A,
                                                      LMT_STR_DEALER_INST_OVRL_AMT B
                                               WHERE  A.LIMIT_CODE=B.LIMIT_CODE AND
                                                      A.ACTIVE_STATUS='Y' AND
                                                      B.DEALER_CODE=M_DEALER_CODE AND
                                                      B.INST_TYPE=M_INST_TYPE AND
                                                      B.TRADE_TYPE=M_TRADE_TYPE);
                     ELSE   --IF NO LIMIT CODE WAS ACTIVATED
                         SELECT  LIMIT_CODE
                         INTO    M_LIMIT_CODE_MIN
                         FROM    LMT_STR_DEALER_INST_OVRL_AMT
                         WHERE   INST_TYPE=M_INST_TYPE AND
                                 DEALER_CODE=M_DEALER_CODE AND
                                 START_AMOUNT=0 AND
                                 TRADE_TYPE=M_TRADE_TYPE;
                     END IF;

                     SELECT COUNT(*)
                     INTO MM_COUNT_EXCEED
                     FROM LMT_EXC_CURRENT
                     WHERE LIMIT_CODE=M_LIMIT_CODE_MIN  AND
                           VIOLATED_BY=M_DN_USER;

                     IF (MM_COUNT_EXCEED=0)THEN

                     INSERT INTO LMT_EXC_CURRENT
    				        (LIMIT_CODE,VIOLATED_DATE,VIOLATED_BY,ACTIVATED_TYPE)
    			     VALUES
                            (M_LIMIT_CODE_MIN,SYSDATE,M_DN_USER ,'Y') ;
                     END IF;
                     /*INSERT INTO LMT_EXC_UNCONF
    				        (LIMIT_CODE,VIOLATED_DATE,VIOLATED_BY,ACTIVATED_TYPE)
    				  VALUES
                            (M_LIMIT_CODE_MIN,SYSDATE,M_DN_USER,'Y') ;
                     */

                         IF (M_FOR_POSSIBLE=1) THEN
                            INSERT INTO LMT_EXC_UNCONF
                               (LIMIT_CODE,VIOLATED_DATE,VIOLATED_BY,ACTIVATED_TYPE)
                            VALUES
                               (M_LIMIT_CODE_MIN,SYSDATE,M_DN_USER,'Y');
                         END IF;


       ELSIF(M_ACTIVE_STATUS='Y')THEN /*SUCH LIMIT IS ACTIVATED	*/
          NULL;
       END IF ;
END IF;
 END IF;
 END LOOP;
 CLOSE MYCURSOR;
 END DN_LIMIT_COMP_DEALER_INST_AMT;

/
