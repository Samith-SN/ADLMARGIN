--------------------------------------------------------
--  DDL for Procedure DN_LIMIT_TRN_OVRL_EXPO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_LIMIT_TRN_OVRL_EXPO" 
  (
    M_DEAL_NO               DN_TRN_OUTP_SALE.DEAL_NO%TYPE,
    M_INS_UPS_STATUS		VARCHAR2
   )

   IS

    /* Procedue     : Insert the table (LMT_UTL_OVRL_EXP) with current utilistion //DN_INV_OUTPS_UP_DEAL_SEC
    -- System       : Dealnet system
    -- Created by   : V.Sukathis
    -- Created on   : 06/01/2000	*/

 M_DN_USER                  LMT_UTL_OVRL_TRA.DN_USER%TYPE;
 M_CURRENT_UTILIZATION      LMT_UTL_OVRL_TRA.CURRENT_UTILIZATION%TYPE;
 M_DEAL_INFLOW              LMT_UTL_OVRL_TRA.DEAL_INFLOW%TYPE;
 M_DEAL_OUTFLOW             LMT_UTL_OVRL_TRA.DEAL_OUTFLOW%TYPE;
 M_COUNT					INTEGER;
 M_COUNT_AMOUNT             INTEGER;
 M_ROW_ID					INTEGER;
 M_TENOR                    INTEGER;
 M_COUNT_UTL                INTEGER;
 M_CASH_DEAL_COUNT          INTEGER;


BEGIN

M_DEAL_INFLOW:=0;
M_DEAL_OUTFLOW:=0;
M_CASH_DEAL_COUNT:=0;
M_CURRENT_UTILIZATION:=0;

/*	TO IDENTIFY WHETHER IT IS A BUY OR SALE-outright		*/
IF SUBSTR(M_DEAL_NO,1,2)='OR' THEN
		SELECT COUNT(*) INTO M_COUNT_AMOUNT
		   FROM
				DN_TRN_OUTP_SALE A,
				DN_REF_PORTFOLIO B,
                DN_REF_SECURITY  C
				WHERE
                   C.SECURITY_CODE=A.SECURITY_CODE
                 AND
				    A.DEAL_NO=M_DEAL_NO
				 AND
					B.PORTFOLIO_CODE=A.BUY_PORTFOLIO_CODE
				 AND
					B.PF_TYPE='P'
                 AND
                    TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
                 AND
                    B.OWNED_BY_MBFSL='Y';


					IF ( M_COUNT_AMOUNT > 0) THEN
                         --RAISE_APPLICATION_ERROR(-20201,'11111 '||M_COUNT_AMOUNT);
							SELECT A.COST,(C.MATURITY_DATE-SYSDATE),A.DN_USER INTO M_DEAL_INFLOW,M_TENOR,M_DN_USER
								FROM
								  DN_TRN_OUTP_SALE A,
								  DN_REF_PORTFOLIO B,
                                  DN_REF_SECURITY  C
								WHERE
                                     C.SECURITY_CODE=A.SECURITY_CODE
                                   AND
								     A.DEAL_NO=M_DEAL_NO
								   AND
									  B.PORTFOLIO_CODE=A.BUY_PORTFOLIO_CODE
								   AND
									  B.PF_TYPE='P'
                                   AND
                                      TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
                                   AND
                                   B.OWNED_BY_MBFSL='Y';
                               M_CASH_DEAL_COUNT:=1;
					END IF;
		M_COUNT_AMOUNT:=0;

		SELECT COUNT(*) INTO M_COUNT_AMOUNT
		   FROM
				DN_TRN_OUTP_SALE A,
				DN_REF_PORTFOLIO B,
                DN_REF_SECURITY  C
				WHERE
                   C.SECURITY_CODE=A.SECURITY_CODE
                 AND
				    A.DEAL_NO=M_DEAL_NO
				 AND
					B.PORTFOLIO_CODE=A.SELL_PORTFOLIO_CODE
				 AND
					B.PF_TYPE='P'
                 AND
                    TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
                 AND
                    B.OWNED_BY_MBFSL='Y';
					IF ( M_COUNT_AMOUNT > 0) THEN
                    --RAISE_APPLICATION_ERROR(-20201,'2222 '||M_COUNT_AMOUNT);
						SELECT A.COST,(C.MATURITY_DATE-SYSDATE),A.DN_USER INTO M_DEAL_OUTFLOW,M_TENOR,M_DN_USER
						      FROM
                      				DN_TRN_OUTP_SALE A,
                      				DN_REF_PORTFOLIO B,
                                    DN_REF_SECURITY  C
                      				WHERE
                                         C.SECURITY_CODE=A.SECURITY_CODE
                                     AND
                      				    A.DEAL_NO=M_DEAL_NO
                      				 AND
                      					B.PORTFOLIO_CODE=A.SELL_PORTFOLIO_CODE
                      				 AND
                      					B.PF_TYPE='P'
                                     AND
                                         TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
                                     AND
                                        B.OWNED_BY_MBFSL='Y';
                           M_CASH_DEAL_COUNT:=1;
                    END IF;
--RAISE_APPLICATION_ERROR(-20201,'*** '||M_DEAL_NO||'*** '||M_TENOR);

/*	TO IDENTIFY WHETHER IT IS A BUY OR SALE-repofresh		*/
ELSIF SUBSTR(M_DEAL_NO,1,2)='RF' THEN

		SELECT COUNT(*) INTO M_COUNT_AMOUNT
		   FROM
		      DN_TRN_REPO_FRESH A,
		      DN_REF_PORTFOLIO B
		      --DN_REF_SECURITY  C
			  WHERE
                   -- C.SECURITY_CODE=A.SECURITY_CODE
                  --AND
				    A.DEAL_NO=M_DEAL_NO
				  AND
					B.PORTFOLIO_CODE=A.BORR_PORTFOLIO_CODE
				  AND
					B.PF_TYPE='P'
                  AND
                    TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
                  AND
                    B.OWNED_BY_MBFSL='Y';
					IF ( M_COUNT_AMOUNT > 0) THEN
						SELECT (LEG1_VALUE+A.INT_ACCR),A.TENOR,A.DN_USER INTO M_DEAL_OUTFLOW,M_TENOR,M_DN_USER
							FROM
								DN_TRN_REPO_FRESH A,
								DN_REF_PORTFOLIO B
								--DN_REF_SECURITY  C
                			  WHERE
                                    --C.SECURITY_CODE=A.SECURITY_CODE
                                  --AND
                				    A.DEAL_NO=M_DEAL_NO
                				  AND
                					B.PORTFOLIO_CODE=A.BORR_PORTFOLIO_CODE
                				  AND
                					B.PF_TYPE='P'
                                  AND
                                    TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
                                  AND
                                   B.OWNED_BY_MBFSL='Y';
                            M_CASH_DEAL_COUNT:=1;
					END IF;
--RAISE_APPLICATION_ERROR(-20201,'222 '||'****'||M_TENOR);

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
				     SELECT (LEG1_VALUE+A.INT_ACCR),A.TENOR,A.DN_USER  INTO M_DEAL_INFLOW,M_TENOR,M_DN_USER
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

/*	TO IDENTIFY WHETHER IT IS A BUY OR SALE-reporollover		*/
ELSIF SUBSTR(M_DEAL_NO,1,2)='RR' THEN
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
  				B.PORTFOLIO_CODE=A.BORR_PORTFOLIO_CODE
  			  AND
  				B.PF_TYPE='P'
              AND
                TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
              AND
                B.OWNED_BY_MBFSL='Y';

				  IF (M_COUNT_AMOUNT>0) THEN
						SELECT (LEG1_VALUE+A.INT_ACCR) , A.TENOR , A.DN_USER INTO M_DEAL_OUTFLOW,M_TENOR,M_DN_USER
							FROM
								DN_TRN_REPO_ROLLOVER A,
								DN_REF_PORTFOLIO B
			   	                --DN_REF_SECURITY  C
                			WHERE
                                  --C.SECURITY_CODE=A.SECURITY_CODE
                              --AND
                  				A.DEAL_NO=M_DEAL_NO
                  			  AND
                  				B.PORTFOLIO_CODE=A.BORR_PORTFOLIO_CODE
                  			  AND
                  				B.PF_TYPE='P'
                              AND
                                TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
                              AND
                                B.OWNED_BY_MBFSL='Y';
                       M_CASH_DEAL_COUNT:=1;
                   END IF;

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
						SELECT (LEG1_VALUE+A.INT_ACCR) ,A.TENOR,A.DN_USER INTO M_DEAL_INFLOW,M_TENOR,M_DN_USER
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

/*	TO IDENTIFY WHETHER IT IS A BUY OR SALE-B/L fund		*/
ELSIF SUBSTR(M_DEAL_NO,1,2)='BF' THEN
	  SELECT COUNT(*) INTO M_COUNT_AMOUNT
			FROM
			      DN_TRN_BL_FUND A,
			      DN_REF_PORTFOLIO B
			   	  --DN_REF_SECURITY  C
			WHERE
                  --C.SECURITY_CODE=A.SECURITY_CODE
              --AND
  				A.DEAL_NO=M_DEAL_NO
  			  AND
  				B.PORTFOLIO_CODE=A.BORR_PORTFOLIO_CODE
  			  AND
  				B.PF_TYPE='P'
              AND
                TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
              AND
                B.OWNED_BY_MBFSL='Y';
			  IF (M_COUNT_AMOUNT>0) THEN
					SELECT LEG1_VALUE,A.TENOR,A.DN_USER INTO M_DEAL_OUTFLOW,M_TENOR,M_DN_USER
						FROM
			                 DN_TRN_BL_FUND A,
			                 DN_REF_PORTFOLIO B
			   	             --DN_REF_SECURITY  C
			             WHERE
                            --C.SECURITY_CODE=A.SECURITY_CODE
                        --AND
  				            A.DEAL_NO=M_DEAL_NO
  			            AND
  				            B.PORTFOLIO_CODE=A.BORR_PORTFOLIO_CODE
  			            AND
  				            B.PF_TYPE='P'
                        AND
                            TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
                        AND
                           B.OWNED_BY_MBFSL='Y';
                    M_CASH_DEAL_COUNT:=1;
				END IF;

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
						  SELECT LEG1_VALUE,A.TENOR,A.DN_USER INTO M_DEAL_INFLOW,M_TENOR,M_DN_USER
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


IF (M_CASH_DEAL_COUNT = 1) THEN   -- UTILITY GET UPDATED ONLY INTHE CASE OF CASH DEALS
     IF (M_INS_UPS_STATUS='I') THEN
        SELECT COUNT(*) INTO M_COUNT_UTL
            FROM
                LMT_UTL_OVRL_EXP
            WHERE
                M_TENOR BETWEEN START_DAYS AND END_DAYS ;


        IF (M_COUNT_UTL>0) THEN
          SELECT CURRENT_UTILIZATION INTO M_CURRENT_UTILIZATION
              FROM
                  LMT_UTL_OVRL_EXP
              WHERE
                  M_TENOR BETWEEN START_DAYS AND END_DAYS ;

           UPDATE   LMT_UTL_OVRL_EXP
             SET  BF_UTILIZATION = M_CURRENT_UTILIZATION , --ASSIGNING THE B/F UTILISATION
                  DEAL_INFLOW = M_DEAL_INFLOW ,
                  DEAL_OUTFLOW = M_DEAL_OUTFLOW ,
                  CURRENT_UTILIZATION = (M_CURRENT_UTILIZATION+M_DEAL_INFLOW-M_DEAL_OUTFLOW) ,
                  DN_USER=M_DN_USER
                  WHERE
                     M_TENOR BETWEEN START_DAYS AND END_DAYS ;
 --RAISE_APPLICATION_ERROR(-20201,'333 '||'****'||M_COUNT_UTL ||'****'||M_TENOR||'****'||M_CURRENT_UTILIZATION||'****'||M_DEAL_INFLOW||'****'||M_DEAL_OUTFLOW||'****'||(M_CURRENT_UTILIZATION+M_DEAL_INFLOW-M_DEAL_OUTFLOW));

        ELSIF   (M_COUNT_UTL=0) THEN
--RAISE_APPLICATION_ERROR(-20201,'2222 '||M_DEAL_NO||'*** '||M_TENOR||'*** '||M_CURRENT_UTILIZATION||'*** '||M_DEAL_INFLOW||'*** '||M_DEAL_OUTFLOW);
            INSERT INTO LMT_UTL_OVRL_EXP
            (   LIMIT_TYPE ,
                START_DAYS ,
                END_DAYS ,
                BF_UTILIZATION ,
                DEAL_INFLOW ,
                DEAL_OUTFLOW ,
                CURRENT_UTILIZATION ,
                DN_USER
                 )
                    VALUES
                        ( '03' ,
                          DN_LIMIT_EXPO_FIN_START_DAYS(M_TENOR) ,
                          DN_LIMIT_EXPO_FIN_END_DAYS(M_TENOR) ,
                          0.00 ,
                          M_DEAL_INFLOW ,
                          M_DEAL_OUTFLOW ,
                          (0+ M_DEAL_INFLOW - M_DEAL_OUTFLOW) ,
                          M_DN_USER
                            );
        END IF;
     END IF;

    IF (M_INS_UPS_STATUS='U') THEN
        SELECT COUNT(*) INTO M_COUNT_UTL
            FROM
                LMT_UTL_OVRL_EXP
            WHERE
                M_TENOR BETWEEN START_DAYS AND END_DAYS ;

        IF (M_COUNT_UTL>0) THEN --RECORD EXISTING IN THE UTILITY TABLE
          SELECT CURRENT_UTILIZATION INTO M_CURRENT_UTILIZATION
              FROM
                  LMT_UTL_OVRL_EXP
              WHERE
                  M_TENOR BETWEEN START_DAYS AND END_DAYS ;

           UPDATE   LMT_UTL_OVRL_EXP
             SET  BF_UTILIZATION = M_CURRENT_UTILIZATION , --ASSIGNING THE B/F UTILISATION
                  DEAL_INFLOW = M_DEAL_OUTFLOW ,
                  DEAL_OUTFLOW = M_DEAL_INFLOW ,
                  CURRENT_UTILIZATION = (M_CURRENT_UTILIZATION-M_DEAL_INFLOW+M_DEAL_OUTFLOW),
                  DN_USER=M_DN_USER
                  WHERE
                     M_TENOR BETWEEN START_DAYS AND END_DAYS ;

        ELSIF   (M_COUNT_UTL=0) THEN    --RECORD DOESN'T EXISTING IN THE UTILITY TABLE
            INSERT INTO LMT_UTL_OVRL_EXP
            (   LIMIT_TYPE ,
                START_DAYS ,
                END_DAYS ,
                BF_UTILIZATION ,
                DEAL_INFLOW ,
                DEAL_OUTFLOW ,
                CURRENT_UTILIZATION,
                DN_USER
                 )
                    VALUES
                        ( '03' ,
                          DN_LIMIT_EXPO_FIN_START_DAYS(M_TENOR) ,
                          DN_LIMIT_EXPO_FIN_END_DAYS(M_TENOR) ,
                          0.00 ,
                          M_DEAL_OUTFLOW ,
                          M_DEAL_INFLOW,
                          (0-M_DEAL_INFLOW + M_DEAL_OUTFLOW),
                          M_DN_USER
                            );
        END IF;
     END IF;

--DN_LIMIT_COMPARE_OVRL_EXPO(M_DEAL_NO,DN_LIMIT_EXPO_FIN_START_DAYS(M_TENOR),DN_LIMIT_EXPO_FIN_END_DAYS(M_TENOR));
DN_LIMIT_COMPARE_OVRL_EXPO(1);
END IF;--FOR M_CASH_DEAL_COUNT



--COMMIT ;

END DN_LIMIT_TRN_OVRL_EXPO;

/
