--------------------------------------------------------
--  DDL for Procedure DN_LIMIT_COMPARE_OVRL_EXPO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_LIMIT_COMPARE_OVRL_EXPO" 
	(
        M_FOR_POSSIBLE               NUMBER
    )

   IS

    -- Procedue     : Compare actuals with allowed to identify the violations and possible violation
    -- System       : Dealnet system
    -- Created by   : V.Sukathis
    -- Created on   : 03/02/2000

    CURSOR MYCURSOR IS
        SELECT START_DAYS , END_DAYS , CURRENT_UTILIZATION , DN_USER
        FROM LMT_UTL_OVRL_EXP;


	M_LIMIT_CODE				LMT_STR_OVRL_AMT.LIMIT_CODE%TYPE;
	M_DN_USER					DN_TRN_OUTP_SALE.DN_USER%TYPE;
	M_POSSIBLE_STATUS			VARCHAR2(1);
    M_CURRENT_UTILIZATION       LMT_STR_OVRL_AMT.END_AMOUNT%TYPE;
    M_COUNT_LIMIT_CODE          NUMBER;
    M_COUNT_ACTIVE_STATUS       NUMBER;
    M_POSSIBLE_AMOUNT           LMT_STR_OVRL_AMT.END_AMOUNT%TYPE;
    M_START_DAYS                NUMBER;
    M_END_DAYS                  NUMBER;
    M_END_AMOUNT                LMT_STR_OVRL_AMT.END_AMOUNT%TYPE;
    M_LIMIT_WARNING_LEVEL       NUMBER;
    M_COUNT_MAX                 NUMBER;
    M_COUNT_MIN                 NUMBER;
    M_LIMIT_CODE_MAX			LMT_STR_OVRL_AMT.LIMIT_CODE%TYPE;
    M_LIMIT_CODE_MIN			LMT_STR_OVRL_AMT.LIMIT_CODE%TYPE;


	BEGIN

    DELETE FROM LMT_EXC_CURRENT WHERE LIMIT_CODE LIKE '03%';
    DELETE FROM LMT_EXC_UNCONF WHERE LIMIT_CODE LIKE '03%';



    OPEN MYCURSOR;
        LOOP
    		FETCH MYCURSOR INTO M_START_DAYS,M_END_DAYS,M_CURRENT_UTILIZATION,M_DN_USER;
            EXIT WHEN MYCURSOR%NOTFOUND;
    IF (M_CURRENT_UTILIZATION>0) THEN   --DELETE LATER
            --************  PICKING THE LIMIT CODE  *******************----
                SELECT COUNT(*) INTO M_COUNT_LIMIT_CODE FROM LMT_STR_OVRL_EXPO
                    WHERE START_DAYS=M_START_DAYS
                    AND END_DAYS=M_END_DAYS
                    AND M_CURRENT_UTILIZATION>=START_AMOUNT AND M_CURRENT_UTILIZATION<END_AMOUNT
                    AND CONDITION='B';

                    IF (M_COUNT_LIMIT_CODE>0) THEN
                      SELECT LIMIT_CODE INTO M_LIMIT_CODE FROM LMT_STR_OVRL_EXPO
                          WHERE START_DAYS=M_START_DAYS
                          AND END_DAYS=M_END_DAYS
                          AND M_CURRENT_UTILIZATION>=START_AMOUNT AND M_CURRENT_UTILIZATION<END_AMOUNT
                          AND CONDITION='B';
                          M_POSSIBLE_STATUS:='T';
                     ELSIF (M_COUNT_LIMIT_CODE=0) THEN
                        SELECT LIMIT_CODE INTO M_LIMIT_CODE FROM LMT_STR_OVRL_EXPO
                          WHERE START_DAYS=M_START_DAYS
                          AND END_DAYS=M_END_DAYS
                          AND M_CURRENT_UTILIZATION>=START_AMOUNT
                          AND CONDITION='G';
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
                              FROM LMT_ACT_DETAILS A,LMT_STR_OVRL_EXPO B
                              WHERE B.START_DAYS=M_START_DAYS
                              AND B.END_DAYS=M_END_DAYS
                              AND A.LIMIT_CODE=B.LIMIT_CODE
                              AND A.ACTIVE_STATUS='Y';  --)
                              --AND B.END_AMOUNT<= M_CURRENT_UTILIZATION );
                               IF (M_COUNT_MIN>0) THEN
                                 SELECT DISTINCT LIMIT_CODE INTO M_LIMIT_CODE_MIN
                                  FROM LMT_STR_OVRL_EXPO
                                  WHERE START_DAYS=M_START_DAYS
                                  AND END_DAYS=M_END_DAYS
                                  AND START_AMOUNT=(
                                  SELECT MAX(B.START_AMOUNT)
                                    FROM LMT_ACT_DETAILS A,LMT_STR_OVRL_EXPO B
                                    WHERE B.START_DAYS=M_START_DAYS
                                    AND B.END_DAYS=M_END_DAYS
                                    AND A.LIMIT_CODE=B.LIMIT_CODE
                                    AND A.ACTIVE_STATUS='Y');
                                    --AND B.END_AMOUNT<= M_CURRENT_UTILIZATION );
                                      /*SELECT A.LIMIT_CODE INTO M_LIMIT_CODE_MIN
                                    FROM LMT_ACT_DETAILS A,LMT_STR_OVRL_EXPO B
                                    WHERE B.START_DAYS=M_START_DAYS
                                      AND B.END_DAYS=M_END_DAYS
                                      AND A.ACTIVE_STATUS='Y'
                                      AND MAX(END_AMOUNT) <= M_CURRENT_UTILIZATION
                                      AND A.LIMIT_CODE=B.LIMIT_CODE;*/
                                 INSERT INTO LMT_EXC_CURRENT
                                    ( LIMIT_CODE , VIOLATED_DATE , VIOLATED_BY , ACTIVATED_TYPE )
                                    VALUES(M_LIMIT_CODE_MIN , SYSDATE , M_DN_USER , 'Y');
                                 IF (M_FOR_POSSIBLE=1) THEN
                                 INSERT INTO LMT_EXC_UNCONF
                                    ( LIMIT_CODE , VIOLATED_DATE , VIOLATED_BY , ACTIVATED_TYPE )
                                    VALUES(M_LIMIT_CODE_MIN , SYSDATE , M_DN_USER , 'Y');
                                 END IF;
                               ELSIF (M_COUNT_MIN=0) THEN
                                 SELECT  LIMIT_CODE INTO M_LIMIT_CODE_MIN
                                    FROM LMT_STR_OVRL_EXPO
                                    WHERE START_DAYS=M_START_DAYS
                                    AND END_DAYS=M_END_DAYS
                                    AND START_AMOUNT=0;

                                  INSERT INTO LMT_EXC_CURRENT
                                    ( LIMIT_CODE , VIOLATED_DATE , VIOLATED_BY , ACTIVATED_TYPE )
                                    VALUES(M_LIMIT_CODE_MIN , SYSDATE , M_DN_USER , 'Y');
                                  IF (M_FOR_POSSIBLE=1) THEN
                                  INSERT INTO LMT_EXC_UNCONF
                                    ( LIMIT_CODE , VIOLATED_DATE , VIOLATED_BY , ACTIVATED_TYPE )
                                    VALUES(M_LIMIT_CODE_MIN , SYSDATE , M_DN_USER , 'Y');
                                  END IF;
                               END IF;

                   END IF;
   END IF;  --DELETE LATER
        END LOOP;
 CLOSE MYCURSOR;

END DN_LIMIT_COMPARE_OVRL_EXPO;

/
