--------------------------------------------------------
--  DDL for Procedure DN_LIMIT_TRN_OVRL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_LIMIT_TRN_OVRL" 
   (
    M_DEAL_NO     			DN_TRN_OUTP_SALE.DEAL_NO%TYPE,
	M_INS_UPS_STATUS		VARCHAR2
   )

   IS

    -- Procedue     : Insert the table (LMT_UTL_OVRL_TRA) with current utilistion //DN_INV_OUTPS_UP_DEAL_SEC
    -- System       : Dealnet system
    -- Created by   : V.Sukathis
    -- Created on   : 24/12/1999


 M_CURRENT_UTILIZATION      LMT_UTL_OVRL_TRA.CURRENT_UTILIZATION%TYPE;
 M_DEAL_INFLOW              LMT_UTL_OVRL_TRA.DEAL_INFLOW%TYPE;
 M_DEAL_OUTFLOW             LMT_UTL_OVRL_TRA.DEAL_OUTFLOW%TYPE;
 M_COUNT					INTEGER;
 M_COUNT_INFLOW				INTEGER;
 M_COUNT_OUTFLOW			INTEGER;
 M_COUNT_AMOUNT             INTEGER;
 M_TENOR                    INTEGER;
 --M_ROW_ID					INTEGER;
 M_CASH_DEAL_COUNT          INTEGER;
 M_DN_USER                  DN_TRN_OUTP_SALE.DN_USER%TYPE;

BEGIN

--RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||' '||M_INS_UPS_STATUS);
M_DEAL_INFLOW:=0;
M_DEAL_OUTFLOW:=0;
M_CASH_DEAL_COUNT:=0;

--SELECT MAX(ROW_ID) INTO M_ROW_ID FROM LMT_UTL_OVRL_TRA;

SELECT COUNT(*) INTO M_COUNT FROM LMT_UTL_OVRL_TRA ;

IF (M_COUNT=0)THEN
		M_CURRENT_UTILIZATION:=0 ;
ELSE
		SELECT CURRENT_UTILIZATION INTO M_CURRENT_UTILIZATION
			FROM LMT_UTL_OVRL_TRA;
			--WHERE ROW_ID=M_ROW_ID ;
END IF;

--M_ROW_ID:=M_ROW_ID+1;
IF SUBSTR(M_DEAL_NO,1,2)='OR' THEN
/*	TO IDENTIFY WHETHER IT IS A BUY OR SALE		*/
SELECT COUNT(*) INTO M_COUNT_INFLOW
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      B.PORTFOLIO_CODE=A.BUY_PORTFOLIO_CODE
      AND
      B.PF_TYPE='P'
      AND
      B.OWNED_BY_MBFSL='Y'
      AND
      TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY');


       IF (M_COUNT_INFLOW>0) THEN
        M_CASH_DEAL_COUNT:=1;
      	SELECT A.COST,A.DN_USER INTO M_DEAL_INFLOW,M_DN_USER
      	   FROM
      	      DN_TRN_OUTP_SALE A,
      	      DN_REF_PORTFOLIO B
      	   WHERE
      	      A.DEAL_NO=M_DEAL_NO
      	      AND
      	      B.PORTFOLIO_CODE=A.BUY_PORTFOLIO_CODE
      	      AND
      	      B.PF_TYPE='P'
                AND
                B.OWNED_BY_MBFSL='Y'
                AND
                TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY');
      ELSE
      		M_DEAL_INFLOW:=0;
      END IF;


     /*AND
     	 NVL(DN_FIN_BROKERAGE(A.DEAL_NO,A.BUY_PORTFOLIO_CODE),0)>0; */

SELECT COUNT(*) INTO M_COUNT_OUTFLOW
   FROM
      DN_TRN_OUTP_SALE A,
      DN_REF_PORTFOLIO B
   WHERE
      A.DEAL_NO=M_DEAL_NO
      AND
      B.PORTFOLIO_CODE=A.SELL_PORTFOLIO_CODE
      AND
      B.PF_TYPE='P'
      AND
      B.OWNED_BY_MBFSL='Y'
      AND
      TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY');

      IF (M_COUNT_OUTFLOW>0) THEN
        M_CASH_DEAL_COUNT:=1;
      	SELECT A.COST,A.DN_USER INTO M_DEAL_OUTFLOW,M_DN_USER
      	   FROM
      	      DN_TRN_OUTP_SALE A,
      	      DN_REF_PORTFOLIO B
      	   WHERE
      	      A.DEAL_NO=M_DEAL_NO
      	      AND
      	      B.PORTFOLIO_CODE=A.SELL_PORTFOLIO_CODE
      	      AND
      	      B.PF_TYPE='P'
                AND
                B.OWNED_BY_MBFSL='Y'
                AND
                TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY');
      ELSE
      	M_DEAL_OUTFLOW:=0;
      END IF;

--RAISE_APPLICATION_ERROR(-20201,'1111'||M_DEAL_NO||'*****'||M_INS_UPS_STATUS||'*****'||M_COUNT_INFLOW||'*****'||M_DEAL_INFLOW||'*****'||M_COUNT_OUTFLOW||'*****'||M_DEAL_OUTFLOW);
--*******************************************************************************************
ELSIF SUBSTR(M_DEAL_NO,1,2)='RF' THEN

				M_COUNT_AMOUNT:=0;

	SELECT COUNT(*) INTO M_COUNT_AMOUNT
		FROM
			DN_TRN_REPO_FRESH A,
			DN_REF_PORTFOLIO B
		    --DN_REF_SECURITY  C
			WHERE
                --C.SECURITY_CODE=A.SECURITY_CODE
              --AND
				A.DEAL_NO=M_DEAL_NO
			  AND
				B.PORTFOLIO_CODE=A.LEND_PORTFOLIO_CODE
			  AND
				B.PF_TYPE='P'
              AND
                TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
              AND
                B.OWNED_BY_MBFSL='Y';
			     IF ( M_COUNT_AMOUNT > 0) THEN

                     SELECT (LEG1_VALUE+A.INT_ACCR),A.TENOR,A.DN_USER,'0'  INTO M_DEAL_INFLOW,M_TENOR,M_DN_USER,M_DEAL_OUTFLOW
						FROM
							DN_TRN_REPO_FRESH A,
							DN_REF_PORTFOLIO B
							--DN_REF_SECURITY  C
                			WHERE
                                --C.SECURITY_CODE=A.SECURITY_CODE
                              --AND
                				A.DEAL_NO=M_DEAL_NO
                			  AND
                				B.PORTFOLIO_CODE=A.LEND_PORTFOLIO_CODE
                			  AND
                				B.PF_TYPE='P'
                              AND
                                TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
                             AND
                                B.OWNED_BY_MBFSL='Y';
                        M_CASH_DEAL_COUNT:=1;
			     END IF;
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
/*	TO IDENTIFY WHETHER IT IS A BUY OR SALE-reporollover		*/
ELSIF SUBSTR(M_DEAL_NO,1,2)='RR' THEN
	  M_COUNT_AMOUNT:=0;

	  SELECT COUNT(*) INTO M_COUNT_AMOUNT
			FROM
			      DN_TRN_REPO_ROLLOVER A,
			      DN_REF_PORTFOLIO B
			      --DN_REF_SECURITY  C
      			  WHERE
                        --C.SECURITY_CODE=A.SECURITY_CODE
                  --AND
        				A.DEAL_NO=M_DEAL_NO
        		  AND
        				B.PORTFOLIO_CODE=A.LEND_PORTFOLIO_CODE
        		  AND
        				B.PF_TYPE='P'
                  AND
                        TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
                  AND
                        B.OWNED_BY_MBFSL='Y';

				  IF (M_COUNT_AMOUNT>0) THEN
						SELECT (LEG1_VALUE+A.INT_ACCR) ,A.TENOR,A.DN_USER,'0' INTO M_DEAL_INFLOW,M_TENOR,M_DN_USER,M_DEAL_OUTFLOW
							FROM
							  DN_TRN_REPO_ROLLOVER A,
              			      DN_REF_PORTFOLIO B
              			      --DN_REF_SECURITY  C
                    		  WHERE
                                  --C.SECURITY_CODE=A.SECURITY_CODE
                              --AND
                      			  A.DEAL_NO=M_DEAL_NO
                      		  AND
                      			  B.PORTFOLIO_CODE=A.LEND_PORTFOLIO_CODE
                      		  AND
                      			  B.PF_TYPE='P'
                              AND
                                  TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
                              AND
                                   B.OWNED_BY_MBFSL='Y';
                      M_CASH_DEAL_COUNT:=1;
              		END IF;
--@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

/*	TO IDENTIFY WHETHER IT IS A BUY OR SALE-B/L fund		*/
ELSIF SUBSTR(M_DEAL_NO,1,2)='BF' THEN
		M_COUNT_AMOUNT:=0;

			SELECT COUNT(*) INTO M_COUNT_AMOUNT
				   FROM
				      DN_TRN_BL_FUND A,
				      DN_REF_PORTFOLIO B
				   WHERE
				      A.DEAL_NO=M_DEAL_NO
				      AND
				        B.PORTFOLIO_CODE=A.LEND_PORTFOLIO_CODE
				      AND
				        B.PF_TYPE='P'
                      AND
                        TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
                      AND
                        B.OWNED_BY_MBFSL='Y';
					  IF (M_COUNT_AMOUNT>0) THEN
						  SELECT LEG1_VALUE,A.TENOR,A.DN_USER,'0' INTO M_DEAL_INFLOW,M_TENOR,M_DN_USER,M_DEAL_OUTFLOW
								FROM
									DN_TRN_BL_FUND A,
									DN_REF_PORTFOLIO B
								WHERE
									A.DEAL_NO=M_DEAL_NO
									AND
									  B.PORTFOLIO_CODE=A.LEND_PORTFOLIO_CODE
									AND
									  B.PF_TYPE='P'
                                    AND
                                      TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
                                    AND
                                        B.OWNED_BY_MBFSL='Y';
                          M_CASH_DEAL_COUNT:=1;
					 END IF;
END IF;




--*******************************************************************************************

IF (M_CASH_DEAL_COUNT=1) THEN
         IF (M_INS_UPS_STATUS='I') THEN
        		--RAISE_APPLICATION_ERROR(-20201,'WRONG LOOP');

                UPDATE  LMT_UTL_OVRL_TRA
        		      SET   LIMIT_TYPE='01' ,
        					BF_UTILIZATION=M_CURRENT_UTILIZATION ,
        					DEAL_INFLOW=M_DEAL_INFLOW ,
        					DEAL_OUTFLOW=M_DEAL_OUTFLOW ,
        					CURRENT_UTILIZATION=(M_CURRENT_UTILIZATION+M_DEAL_INFLOW-M_DEAL_OUTFLOW),
                            DN_USER=M_DN_USER ;



                IF SQL%NOTFOUND THEN


                      INSERT INTO LMT_UTL_OVRL_TRA
        		    ( LIMIT_TYPE ,
        					BF_UTILIZATION ,
        					DEAL_INFLOW ,
        					DEAL_OUTFLOW ,
        					CURRENT_UTILIZATION,
                            DN_USER
        					 )
        					VALUES
        					    ('01',
        							 M_CURRENT_UTILIZATION ,
        							 M_DEAL_INFLOW,
        							 M_DEAL_OUTFLOW ,
        				             (M_CURRENT_UTILIZATION+M_DEAL_INFLOW-M_DEAL_OUTFLOW),
                                     M_DN_USER
        							 );



                   END IF;
        ELSIF (M_INS_UPS_STATUS='U') THEN



            UPDATE  LMT_UTL_OVRL_TRA
        		      SET   LIMIT_TYPE='01' ,
        					BF_UTILIZATION=M_CURRENT_UTILIZATION ,
        					DEAL_INFLOW=M_DEAL_OUTFLOW ,
        					DEAL_OUTFLOW=M_DEAL_INFLOW ,
        					CURRENT_UTILIZATION=(M_CURRENT_UTILIZATION+M_DEAL_OUTFLOW-M_DEAL_INFLOW),
                            DN_USER=M_DN_USER;
                IF SQL%NOTFOUND THEN
            		INSERT INTO LMT_UTL_OVRL_TRA
            		    ( LIMIT_TYPE ,
            					BF_UTILIZATION ,
            					DEAL_INFLOW ,
            					DEAL_OUTFLOW ,
            					CURRENT_UTILIZATION ,
                                DN_USER
            					 )
            					VALUES
            					    ('01',
            							 M_CURRENT_UTILIZATION ,
            							 M_DEAL_OUTFLOW,
            							 M_DEAL_INFLOW ,
            				            (M_CURRENT_UTILIZATION+M_DEAL_OUTFLOW-M_DEAL_INFLOW),
                                         M_DN_USER
                                         );
                END IF;
  --DN_LIMIT_COMPARE_OVRL (M_DEAL_NO);

       END IF;
 END IF;    ---FOR M_CASH_DEAL_COUNT
/* COMPARE AND IDENTIFY THE ACTUAL AND POSSIBLE VIOLATION 	*/

--COMMIT;
DN_LIMIT_COMPARE_OVRL (M_DEAL_NO);
END DN_LIMIT_TRN_OVRL;

/
