--------------------------------------------------------
--  DDL for Procedure DN_LMT_COMPARE_ISS_HOL_PERIOD
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_LMT_COMPARE_ISS_HOL_PERIOD" 
	(
       M_FOR_POSSIBLE            NUMBER,
        M_IGE_CODE                LMT_UTL_ISSUER_INST_HOL_PERIOD.ISSUER_CODE%TYPE,
        MM_INST_TYPE              LMT_UTL_ISSUER_INST_HOL_PERIOD.INST_TYPE%TYPE,
        M_LIA_TYPE                 VARCHAR2
    )

   IS

    -- Procedue     : Compare actuals with allowed to identify the violations and possible violation
    --                -(LMT_STR_ISSUER_INST_HOL_PERIOD)
    -- System       : Dealnet system
    -- Created by   : nirmala
    -- Created on   : 05/12/2000

    CURSOR MYCURSOR IS

        SELECT TENOR,/*START_DAYS,END_DAYS,*/CURRENT_UTILIZATION,DN_USER,ISSUER_CODE,INST_TYPE,ISSUER_LIABILITY_TYPE
        FROM LMT_UTL_ISSUER_INST_HOL_PERIOD
        WHERE   ISSUER_CODE =M_IGE_CODE AND
                ISSUER_LIABILITY_TYPE=M_LIA_TYPE AND
                INST_TYPE=MM_INST_TYPE AND
                TENOR>=0;


	M_LIMIT_CODE				LMT_STR_ISSUER_INST_HOL_PERIOD.LIMIT_CODE%TYPE;
	M_DN_USER					DN_TRN_OUTP_SALE.DN_USER%TYPE;
	M_POSSIBLE_STATUS			VARCHAR2(1);
    M_CURRENT_UTILIZATION       LMT_UTL_ISSUER_INST_HOL_PERIOD.CURRENT_UTILIZATION%TYPE;
    M_COUNT_LIMIT_CODE          NUMBER;
    M_COUNT_ACTIVE_STATUS       NUMBER;
    --M_POSSIBLE_AMOUNT           LMT_STR_ISSUER_INST_HOL_PERIOD.END_AMOUNT%TYPE;
    M_START_DAYS                NUMBER;
    M_END_DAYS                  NUMBER;
    --M_END_AMOUNT                LMT_STR_ISSUER_INST_HOL_PERIOD.END_AMOUNT%TYPE;
    M_LIMIT_WARNING_LEVEL       NUMBER;
    M_COUNT_MAX                 NUMBER;
    M_COUNT_MIN                 NUMBER;
    M_LIMIT_CODE_MAX			LMT_STR_ISSUER_INST_HOL_PERIOD.LIMIT_CODE%TYPE;
    M_LIMIT_CODE_MIN			LMT_STR_ISSUER_INST_HOL_PERIOD.LIMIT_CODE%TYPE;
    M_AUCTION_TYPE              LMT_UTL_ISSUER_INST_HOL_PERIOD.AUCTION_TYPE%TYPE;
    M_ISSUER_CODE               LMT_UTL_ISSUER_INST_HOL_PERIOD.ISSUER_CODE%TYPE;
    M_ISSUER_LIABILITY_TYPE     LMT_UTL_ISSUER_INST_HOL_PERIOD.ISSUER_LIABILITY_TYPE%TYPE;
    M_INST_TYPE                 LMT_UTL_ISSUER_INST_HOL_PERIOD.INST_TYPE %TYPE;
    MN_COUNT                   NUMBER;
    MM_TENOR                     NUMBER;
    MM_COUNT_EXCEED              NUMBER;
   MM_COUNT_EXCEED_2            NUMBER;
    BEGIN

    DELETE FROM LMT_EXC_CURRENT WHERE LIMIT_CODE LIKE (('06'||'-'||M_IGE_CODE||'-S-'||M_LIA_TYPE||'-'||MM_INST_TYPE)||'%');
    DELETE FROM LMT_EXC_UNCONF WHERE LIMIT_CODE LIKE (('06'||'-'||M_IGE_CODE||'-S-'||M_LIA_TYPE||'-'||MM_INST_TYPE)||'%');



    OPEN MYCURSOR;
        LOOP
    		FETCH MYCURSOR INTO MM_TENOR,/*M_START_DAYS,M_END_DAYS,*/M_CURRENT_UTILIZATION,M_DN_USER,M_ISSUER_CODE,M_INST_TYPE,M_ISSUER_LIABILITY_TYPE;
            EXIT WHEN MYCURSOR%NOTFOUND;
    IF (M_CURRENT_UTILIZATION>0) THEN   --DELETE LATER


                    SELECT COUNT(*)
                    INTO   MN_COUNT
                    FROM   LMT_STR_ISSUER_INST_HOL_PERIOD
                    WHERE  ISSUER_CODE=M_ISSUER_CODE AND
                           ISSUER_LIABILITY_TYPE=M_ISSUER_LIABILITY_TYPE AND
                           INST_TYPE=M_INST_TYPE ;


        IF(MN_COUNT>0) THEN


                --************  PICKING THE LIMIT CODE  *******************----


                  SELECT COUNT(*) INTO M_COUNT_LIMIT_CODE FROM LMT_STR_ISSUER_INST_HOL_PERIOD
                    WHERE --START_DAYS=M_START_DAYS
                    --AND END_DAYS=M_END_DAYS
                  --  AND M_CURRENT_UTILIZATION>=START_AMOUNT
                 --    AND M_CURRENT_UTILIZATION<END_AMOUNT
                     START_DAYS<=MM_TENOR AND END_DAYS>MM_TENOR
                     AND CONDITION='B'
                    AND ISSUER_CODE=M_ISSUER_CODE
                  --  AND SUBSTR(LIMIT_CODE,4,4) = M_ISSUER_CODE
                    AND INST_TYPE=M_INST_TYPE
                    AND ISSUER_LIABILITY_TYPE=M_ISSUER_LIABILITY_TYPE;

                    IF (M_COUNT_LIMIT_CODE>0) THEN
                      SELECT LIMIT_CODE INTO M_LIMIT_CODE FROM LMT_STR_ISSUER_INST_HOL_PERIOD
                          WHERE --START_DAYS=M_START_DAYS
                          --AND END_DAYS=M_END_DAYS
                         -- AND M_CURRENT_UTILIZATION>=START_AMOUNT
                         -- AND M_CURRENT_UTILIZATION<END_AMOUNT
                           START_DAYS<=MM_TENOR AND END_DAYS>MM_TENOR
                           AND CONDITION='B'
                          AND ISSUER_CODE=M_ISSUER_CODE
                         -- AND SUBSTR(LIMIT_CODE,4,4) = M_ISSUER_CODE
                          AND INST_TYPE=M_INST_TYPE
                          AND ISSUER_LIABILITY_TYPE=M_ISSUER_LIABILITY_TYPE;
                          M_POSSIBLE_STATUS:='T';

                      ELSIF (M_COUNT_LIMIT_CODE=0) THEN

                         SELECT LIMIT_CODE INTO M_LIMIT_CODE FROM LMT_STR_ISSUER_INST_HOL_PERIOD
                          WHERE --START_DAYS=M_START_DAYS
                          --AND END_DAYS=M_END_DAYS
                         -- AND M_CURRENT_UTILIZATION>=START_AMOUNT
                         START_DAYS<=MM_TENOR
                          AND CONDITION='G'
                          AND ISSUER_CODE=M_ISSUER_CODE
                        --  AND SUBSTR(LIMIT_CODE,4,4) = M_ISSUER_CODE
                          AND  INST_TYPE=M_INST_TYPE
                          AND ISSUER_LIABILITY_TYPE=M_ISSUER_LIABILITY_TYPE;
                          M_POSSIBLE_STATUS:='F';


                      END IF;

           --******************    CHECKING THE ACTIVE STATUS  ***************--
                    SELECT COUNT(*) INTO M_COUNT_ACTIVE_STATUS FROM LMT_ACT_DETAILS
                        WHERE LIMIT_CODE=M_LIMIT_CODE AND ACTIVE_STATUS='Y';

                    IF  (M_COUNT_ACTIVE_STATUS>0) THEN
           --******************   NO VIOLATION BUT POSSIBLE VIOLATION CAN HAPPEN  ***************--
                         NULL;
                   ELSE
                   -- **********THERE IS A ACTUAL VIOLATION **********-----------

                   --#####################  START OF AFTER THRECENT REQUIREMENT##############################################------
--RAISE_APPLICATION_ERROR(-20201,'****'||M_START_DAYS||'****'||M_END_DAYS||'****'||M_CURRENT_UTILIZATION);
                        SELECT COUNT(*) INTO M_COUNT_MIN
                            --FROM LMT_STR_OVRL_EXPO
                            --WHERE START_DAYS=M_START_DAYS
                            --AND END_DAYS=M_END_DAYS
                            --AND END_AMOUNT=(
                              --SELECT MAX(B.END_AMOUNT)
                              FROM LMT_ACT_DETAILS A,
                                   LMT_STR_ISSUER_INST_HOL_PERIOD B
                              WHERE --B.START_DAYS=M_START_DAYS
                              --AND B.END_DAYS=M_END_DAYS
                               --  START_DAYS<=MM_TENOR AND END_DAYS>MM_TENOR
                              --AND
                              A.LIMIT_CODE=B.LIMIT_CODE
                              AND A.ACTIVE_STATUS='Y'
                              AND SUBSTR(A.LIMIT_CODE,4,(INSTR(A.LIMIT_CODE,'-',1,2)-4))=M_ISSUER_CODE

                              AND B.ISSUER_CODE=M_ISSUER_CODE
                              --AND SUBSTR(B.LIMIT_CODE,4,4) = M_ISSUER_CODE
                              AND B.INST_TYPE=M_INST_TYPE
                              AND B.ISSUER_LIABILITY_TYPE=M_ISSUER_LIABILITY_TYPE ;  --)
                              --AND B.END_AMOUNT<= M_CURRENT_UTILIZATION );
--DBMS_OUTPUT.PUT_LINE('###########'||'M_COUNT_MIN==>'||M_COUNT_MIN||'M_ISSUER_CODE==>'||M_ISSUER_CODE||'M_INST_TYPE==>'||M_INST_TYPE||'M_ISSUER_LIABILITY_TYPE==>'||M_ISSUER_LIABILITY_TYPE);

                                 IF (M_COUNT_MIN>0) THEN

                                 SELECT DISTINCT LIMIT_CODE INTO M_LIMIT_CODE_MIN
                                  FROM LMT_STR_ISSUER_INST_HOL_PERIOD
                                  WHERE --START_DAYS=M_START_DAYS
                                  --AND END_DAYS=M_END_DAYS
                                  --START_DAYS<=MM_TENOR AND END_DAYS>MM_TENOR
                                   --AND
                                    INST_TYPE=M_INST_TYPE
                                  AND ISSUER_CODE=M_ISSUER_CODE
                                 --  AND SUBSTR(LIMIT_CODE,4,4) = M_ISSUER_CODE
                                   AND ISSUER_LIABILITY_TYPE=M_ISSUER_LIABILITY_TYPE
                                  AND START_DAYS=(
                                  SELECT MAX(B.START_DAYS)
                                    FROM LMT_ACT_DETAILS A,LMT_STR_ISSUER_INST_HOL_PERIOD B
                                    WHERE-- B.START_DAYS=M_START_DAYS
                                   -- AND B.END_DAYS=M_END_DAYS
                                    --START_DAYS<=MM_TENOR AND END_DAYS>MM_TENOR
                                   -- AND
                                    A.LIMIT_CODE=B.LIMIT_CODE
                                    AND A.ACTIVE_STATUS='Y'
                                    AND SUBSTR(A.LIMIT_CODE,4,(INSTR(A.LIMIT_CODE,'-',1,2)-4))=M_ISSUER_CODE

                                    AND B.ISSUER_CODE=M_ISSUER_CODE
                                --    AND SUBSTR(B.LIMIT_CODE,4,4) = M_ISSUER_CODE
                                    AND B.INST_TYPE=M_INST_TYPE
                                    AND B.ISSUER_LIABILITY_TYPE=M_ISSUER_LIABILITY_TYPE);
                                    --AND B.END_AMOUNT<= M_CURRENT_UTILIZATION );
                                      /*SELECT A.LIMIT_CODE INTO M_LIMIT_CODE_MIN
                                    FROM LMT_ACT_DETAILS A,LMT_STR_OVRL_EXPO B
                                    WHERE B.START_DAYS=M_START_DAYS
                                      AND B.END_DAYS=M_END_DAYS
                                      AND A.ACTIVE_STATUS='Y'
                                      AND MAX(END_AMOUNT) <= M_CURRENT_UTILIZATION
                                      AND A.LIMIT_CODE=B.LIMIT_CODE;*/

                                   SELECT COUNT(*)
                                   INTO  MM_COUNT_EXCEED
                                   FROM  LMT_EXC_CURRENT
                                   WHERE  LIMIT_CODE=M_LIMIT_CODE_MIN;

                                   IF(MM_COUNT_EXCEED=0)THEN
                                       INSERT INTO LMT_EXC_CURRENT
                                       ( LIMIT_CODE , VIOLATED_DATE , VIOLATED_BY , ACTIVATED_TYPE )
                                       VALUES(M_LIMIT_CODE_MIN ,SYSDATE , M_DN_USER , 'Y');
                                    END IF;

                                 IF (M_FOR_POSSIBLE=1) THEN


                                   INSERT INTO LMT_EXC_UNCONF
                                    ( LIMIT_CODE , VIOLATED_DATE , VIOLATED_BY , ACTIVATED_TYPE )
                                    VALUES(M_LIMIT_CODE_MIN , SYSDATE , M_DN_USER , 'Y');
                                 END IF;




                                   ELSIF (M_COUNT_MIN=0) THEN

--DBMS_OUTPUT.PUT_LINE('*********');

                                   SELECT  LIMIT_CODE INTO M_LIMIT_CODE_MIN
                                    FROM LMT_STR_ISSUER_INST_HOL_PERIOD
                                    WHERE  --START_DAYS=M_START_DAYS
                                   -- AND END_DAYS=M_END_DAYS
                                     --START_DAYS<=MM_TENOR AND END_DAYS>MM_TENOR
                                     --AND
                                     ISSUER_CODE=M_ISSUER_CODE
                                   -- AND SUBSTR(LIMIT_CODE,4,4) = M_ISSUER_CODE
                                    AND INST_TYPE=M_INST_TYPE
                                    AND ISSUER_LIABILITY_TYPE=M_ISSUER_LIABILITY_TYPE
                                    AND START_DAYS=0;

                                    SELECT COUNT(*)
                                   INTO  MM_COUNT_EXCEED_2
                                   FROM  LMT_EXC_CURRENT
                                   WHERE  LIMIT_CODE=M_LIMIT_CODE_MIN;

                                IF(MM_COUNT_EXCEED_2=0)THEN
                                     INSERT INTO LMT_EXC_CURRENT
                                    ( LIMIT_CODE , VIOLATED_DATE , VIOLATED_BY , ACTIVATED_TYPE )
                                    VALUES(M_LIMIT_CODE_MIN ,SYSDATE , M_DN_USER , 'Y');

                                 END IF;









                                  IF (M_FOR_POSSIBLE=1) THEN
                                  INSERT INTO LMT_EXC_UNCONF
                                    ( LIMIT_CODE , VIOLATED_DATE , VIOLATED_BY , ACTIVATED_TYPE )
                                    VALUES(M_LIMIT_CODE_MIN , SYSDATE , M_DN_USER , 'Y');
                                  END IF;
                               END IF;

                   END IF;
    END IF;
    END IF;  --DELETE LATER
        END LOOP;
 CLOSE MYCURSOR;

END DN_LMT_COMPARE_ISS_HOL_PERIOD;

/
