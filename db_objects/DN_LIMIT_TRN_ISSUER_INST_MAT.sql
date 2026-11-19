--------------------------------------------------------
--  DDL for Procedure DN_LIMIT_TRN_ISSUER_INST_MAT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_LIMIT_TRN_ISSUER_INST_MAT" 
   (
    M_DEAL_NO     			DN_TRN_OUTP_SALE.DEAL_NO%TYPE,
    M_INS_UPS_STATUS		VARCHAR2
   )

   IS

    -- Procedue     : Insert the table (LMT_UTL_ISSUER_INST_AMT) with current utilistion //
    -- System       : Dealnet system
    -- Created by   : nirmala fernando
    -- Created on   : 29/11/2000


 M_CURRENT_UTILIZATION_I      LMT_UTL_ISSUER_INST_MATU.CURRENT_UTILIZATION%TYPE;
 M_CURRENT_UTILIZATION_G      LMT_UTL_ISSUER_INST_MATU.CURRENT_UTILIZATION%TYPE;
 M_CURRENT_UTILIZATION_E      LMT_UTL_ISSUER_INST_MATU.CURRENT_UTILIZATION%TYPE;
 M_CURRENT_UTILIZATION     LMT_UTL_ISSUER_INST_MATU.CURRENT_UTILIZATION%TYPE;
 M_DEAL_INFLOW              LMT_UTL_ISSUER_INST_MATU.DEAL_INFLOW%TYPE;
 M_DEAL_OUTFLOW             LMT_UTL_ISSUER_INST_MATU.DEAL_OUTFLOW%TYPE;
 M_COUNT_I					INTEGER;
 M_COUNT_G					INTEGER;
 M_COUNT_E					INTEGER;
 M_COUNT_UTL                INTEGER;
 M_COUNT_INFLOW				INTEGER;
 M_COUNT_OUTFLOW			INTEGER;
 M_COUNT_AMOUNT             INTEGER;
 M_TENOR                    INTEGER;
 --M_ROW_ID					INTEGER;
 M_CASH_DEAL_COUNT          INTEGER;
 M_DN_USER                  DN_TRN_OUTP_SALE.DN_USER%TYPE;
 M_ISSUER_CODE              LMT_UTL_ISSUER_INST_MATU.ISSUER_CODE%TYPE;
 M_INST_TYPE                LMT_UTL_ISSUER_INST_MATU.INST_TYPE%TYPE;
 M_AUCTION_TYPE             LMT_UTL_ISSUER_INST_MATU.AUCTION_TYPE%TYPE;
 M_ISSUER_LIA_TYPE          LMT_UTL_ISSUER_INST_MATU.ISSUER_LIABILITY_TYPE%TYPE;

 MI_ISSUER_CODE             LMT_UTL_ISSUER_INST_MATU.ISSUER_CODE%TYPE;
 MI_GUARANTEE_CODE          LMT_UTL_ISSUER_INST_MATU.ISSUER_CODE%TYPE;
 MI_ENDOSER_CODE            LMT_UTL_ISSUER_INST_MATU.ISSUER_CODE%TYPE;
 MO_ISSUER_CODE             LMT_UTL_ISSUER_INST_MATU.ISSUER_CODE%TYPE;
 MO_GUARANTEE_CODE          LMT_UTL_ISSUER_INST_MATU.ISSUER_CODE%TYPE;
 MO_ENDOSER_CODE            LMT_UTL_ISSUER_INST_MATU.ISSUER_CODE%TYPE;
 M_GUARANTEE_CODE          LMT_UTL_ISSUER_INST_MATU.ISSUER_CODE%TYPE;
 M_ENDOSER_CODE            LMT_UTL_ISSUER_INST_MATU.ISSUER_CODE%TYPE;
 MM_COUNT9_IN              NUMBER;
 MM_COUNT9_OUT            NUMBER;
COUNT_MO_ISSUER            NUMBER;
COUNT_MI_ISSUER            NUMBER;
COUNT_MO_ENDOSER           NUMBER;
COUNT_MI_ENDOSER           NUMBER;
COUNT_MO_GUARANTEE            NUMBER;
COUNT_MI_GUARANTEE            NUMBER;
 STAT_MO_ISSUER             CHAR;
 STAT_MI_ISSUER             CHAR;
 STAT_MO_GUARANTEE             CHAR;
 STAT_MI_GUARANTEE             CHAR;
 STAT_MO_ENDOSER             CHAR;
 STAT_MI_ENDOSER             CHAR;


BEGIN

	M_DEAL_INFLOW:=0;
	M_DEAL_OUTFLOW:=0;
	M_CASH_DEAL_COUNT:=0;
STAT_MO_ISSUER:='N';
STAT_MI_ISSUER:='N';
STAT_MO_GUARANTEE:='N';
STAT_MI_GUARANTEE:='N';
STAT_MO_ENDOSER:='N';
STAT_MI_ENDOSER:='N';


--------------------------------------------------------------------------------------
	    --M_ROW_ID:=M_ROW_ID+1;
            SELECT COUNT(*)
			INTO   MM_COUNT9_IN
			FROM
			      DN_TRN_OUTP_SALE A,
			      DN_REF_PORTFOLIO B,
			      DN_REF_SECURITY C
            WHERE
			      A.DEAL_NO=M_DEAL_NO
			      AND
			      B.PORTFOLIO_CODE=A.BUY_PORTFOLIO_CODE
			      AND
			      B.PF_TYPE='P'
			      AND
			      B.OWNED_BY_MBFSL='Y'
			      AND
			      TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
			      AND
			      C.SECURITY_CODE =A.SECURITY_CODE;



            IF(MM_COUNT9_IN >0)THEN
            SELECT NVL(C.ISSUER_CODE,' '),NVL(C.GUARANTEE_CODE,' '),NVL(A.ENDOSER_CODE,' ')
			INTO   MI_ISSUER_CODE,MI_GUARANTEE_CODE,MI_ENDOSER_CODE
			FROM
			      DN_TRN_OUTP_SALE A,
			      DN_REF_PORTFOLIO B,
			      DN_REF_SECURITY C
            WHERE
			      A.DEAL_NO=M_DEAL_NO
			      AND
			      B.PORTFOLIO_CODE=A.BUY_PORTFOLIO_CODE
			      AND
			      B.PF_TYPE='P'
			      AND
			      B.OWNED_BY_MBFSL='Y'
			      AND
			      TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
			      AND
			      C.SECURITY_CODE =A.SECURITY_CODE;

           END IF;





  SELECT COUNT(*)
			INTO   MM_COUNT9_OUT
			FROM
			      DN_TRN_OUTP_SALE K,
			      DN_REF_PORTFOLIO P,
			      DN_REF_SECURITY L
            WHERE
                  K.DEAL_NO=M_DEAL_NO
			      AND
			      P.PORTFOLIO_CODE=K.SELL_PORTFOLIO_CODE
			      AND
			      P.PF_TYPE='P'
			      AND
			      P.OWNED_BY_MBFSL='Y'
			      AND
			      TO_CHAR(K.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
			      AND
			      L.SECURITY_CODE =K.SECURITY_CODE;




            IF(MM_COUNT9_OUT >0)THEN
            SELECT NVL(L.ISSUER_CODE,' '),NVL(L.GUARANTEE_CODE,' '),NVL(K.ENDOSER_CODE,' ')
			INTO   MO_ISSUER_CODE,MO_GUARANTEE_CODE,MO_ENDOSER_CODE
			FROM
                  DN_TRN_OUTP_SALE K,
			      DN_REF_PORTFOLIO P,
			      DN_REF_SECURITY L
            WHERE
                  K.DEAL_NO=M_DEAL_NO
			      AND
			      P.PORTFOLIO_CODE=K.SELL_PORTFOLIO_CODE
			      AND
			      P.PF_TYPE='P'
			      AND
			      P.OWNED_BY_MBFSL='Y'
			      AND
			      TO_CHAR(K.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
			      AND
			      L.SECURITY_CODE =K.SECURITY_CODE;


            END IF;



IF((MI_ISSUER_CODE  <>' ')OR( MO_ISSUER_CODE <>' ') ) THEN

/*--------------TO IDENTIFY WHETHER IT IS A BUY OR SALE--------*/
IF SUBSTR(M_DEAL_NO,1,2)='OR' THEN
    IF(MI_ISSUER_CODE  <>' ')THEN

          SELECT COUNT(*)
          INTO  COUNT_MI_ISSUER
          FROM  LMT_STR_ISSUER_INST_MATU
          WHERE ISSUER_CODE=MI_ISSUER_CODE;
                IF(COUNT_MI_ISSUER>0)THEN
                   STAT_MI_ISSUER:='Y';
                END IF;




          	SELECT COUNT(*)
			INTO M_COUNT_INFLOW
			FROM
			      DN_TRN_OUTP_SALE A,
			      DN_REF_PORTFOLIO B,
			      DN_REF_SECURITY C
			WHERE
			      A.DEAL_NO=M_DEAL_NO
			      AND
			      B.PORTFOLIO_CODE=A.BUY_PORTFOLIO_CODE
			      AND
			      B.PF_TYPE='P'
			      AND
			      B.OWNED_BY_MBFSL='Y'
			      AND
			      TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
			      AND
			      C.SECURITY_CODE =A.SECURITY_CODE;


					       IF (M_COUNT_INFLOW>0) THEN
					         M_CASH_DEAL_COUNT:=1;
					      	 SELECT A.COST,A.DN_USER,C.ISSUER_CODE,C.INST_TYPE,(C.MATURITY_DATE-SYSDATE)
					         INTO   M_DEAL_INFLOW,M_DN_USER,M_ISSUER_CODE,M_INST_TYPE,M_TENOR
					      	 FROM
					      	        DN_TRN_OUTP_SALE A,
					      	        DN_REF_PORTFOLIO B,
					                DN_REF_SECURITY C
					      	 WHERE
					      	        A.DEAL_NO=M_DEAL_NO
					      	        AND
					      	        B.PORTFOLIO_CODE=A.BUY_PORTFOLIO_CODE
					      	        AND
					      	        B.PF_TYPE='P'
					                AND
					                B.OWNED_BY_MBFSL='Y'
					                AND
					                TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
					                AND
					                C.SECURITY_CODE =A.SECURITY_CODE;

					       ELSE
					      		M_DEAL_INFLOW:=0;
					       END IF;
                 END IF;



                IF( MO_ISSUER_CODE <>' ')THEN

 SELECT COUNT(*)
          INTO  COUNT_MO_ISSUER
          FROM  LMT_STR_ISSUER_INST_MATU
          WHERE ISSUER_CODE=MO_ISSUER_CODE;
                IF(COUNT_MO_ISSUER>0)THEN
                   STAT_MO_ISSUER:='Y';
                END IF;


            SELECT COUNT(*) INTO M_COUNT_OUTFLOW
			FROM
			      DN_TRN_OUTP_SALE A,
			      DN_REF_PORTFOLIO B,
			      DN_REF_SECURITY C
			WHERE
			      A.DEAL_NO=M_DEAL_NO
			      AND
			      B.PORTFOLIO_CODE=A.SELL_PORTFOLIO_CODE
			      AND
			      B.PF_TYPE='P'
			      AND
			      B.OWNED_BY_MBFSL='Y'
			      AND
			      TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
			      AND
			      C.SECURITY_CODE =A.SECURITY_CODE;


                    	     IF (M_COUNT_OUTFLOW>0) THEN
					           M_CASH_DEAL_COUNT:=1;

                               SELECT A.COST,A.DN_USER,C.ISSUER_CODE,C.INST_TYPE,(C.MATURITY_DATE-SYSDATE)
					           INTO M_DEAL_OUTFLOW,M_DN_USER,M_ISSUER_CODE,M_INST_TYPE,M_TENOR
					      	   FROM
					      	       DN_TRN_OUTP_SALE A,
					      	       DN_REF_PORTFOLIO B,
					               DN_REF_SECURITY C
					      	   WHERE
					      	      A.DEAL_NO=M_DEAL_NO
					      	      AND
					      	      B.PORTFOLIO_CODE=A.SELL_PORTFOLIO_CODE
					      	      AND
					      	      B.PF_TYPE='P'
					              AND
					              B.OWNED_BY_MBFSL='Y'
					              AND
					              TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
					              AND
					              C.SECURITY_CODE =A.SECURITY_CODE;

					       ELSE
					       	 M_DEAL_OUTFLOW:=0;
					       END IF;
                END IF;
			          --RAISE_APPLICATION_ERROR(-20201,'1111'||M_DEAL_NO||'*****'||M_INS_UPS_STATUS||'*****'||M_COUNT_INFLOW||'*****'||M_DEAL_INFLOW||'*****'||M_COUNT_OUTFLOW||'*****'||M_DEAL_OUTFLOW);
END IF;
--******************************************************************************************
--******************************************************************************************

/*	SELECT COUNT(*)
        INTO M_COUNT_I
        FROM LMT_UTL_ISSUER_INST_MATU
        WHERE ISSUER_CODE=M_ISSUER_CODE ;

        IF (M_COUNT_I=0)THEN
		  M_CURRENT_UTILIZATION_I:=0 ;
		ELSE
			SELECT   CURRENT_UTILIZATION
		    INTO     M_CURRENT_UTILIZATION_I
			FROM     LMT_UTL_ISSUER_INST_MATU
            WHERE ISSUER_CODE=M_ISSUER_CODE ;
		END IF;*/





IF (M_CASH_DEAL_COUNT=1) THEN
 IF((STAT_MO_ISSUER='Y')OR(STAT_MI_ISSUER='Y'))THEN


   IF (M_INS_UPS_STATUS='I') THEN

            SELECT COUNT(*)
            INTO   M_COUNT_UTL
            FROM   LMT_UTL_ISSUER_INST_MATU
            WHERE  M_TENOR BETWEEN START_DAYS AND END_DAYS
                   AND ISSUER_CODE=M_ISSUER_CODE
                   AND INST_TYPE=M_INST_TYPE
                   AND ISSUER_LIABILITY_TYPE='I';


            IF (M_COUNT_UTL>0) THEN
                 SELECT CURRENT_UTILIZATION
                 INTO   M_CURRENT_UTILIZATION
                 FROM   LMT_UTL_ISSUER_INST_MATU
                 WHERE  M_TENOR BETWEEN START_DAYS AND END_DAYS
                        AND ISSUER_CODE=M_ISSUER_CODE
                        AND INST_TYPE=M_INST_TYPE
                        AND ISSUER_LIABILITY_TYPE='I';


                     UPDATE LMT_UTL_ISSUER_INST_MATU
                     SET    --LIMIT_TYPE='04' ,
                            --AUCTION_TYPE=M_AUCTION_TYPE,
                            --ISSUER_CODE=M_ISSUER_CODE,
                            --ISSUER_LIABILITY_TYPE=M_ISSUER_LIA_TYPE,
                            --INST_TYPE=M_INST_TYPE,
                            BF_UTILIZATION=M_CURRENT_UTILIZATION,
                            DEAL_INFLOW=M_DEAL_INFLOW,
                            DEAL_OUTFLOW=M_DEAL_OUTFLOW,
                            CURRENT_UTILIZATION=(M_CURRENT_UTILIZATION+M_DEAL_INFLOW-M_DEAL_OUTFLOW),
                            DN_USER=M_DN_USER
                     WHERE  M_TENOR BETWEEN START_DAYS AND END_DAYS
                            AND ISSUER_CODE=M_ISSUER_CODE
                            AND INST_TYPE=M_INST_TYPE
                            AND ISSUER_LIABILITY_TYPE='I'
                            AND LIMIT_TYPE='05'
                            AND AUCTION_TYPE='S';

 --RAISE_APPLICATION_ERROR(-20201,'333 '||'****'||M_COUNT_UTL ||'****'||M_TENOR||'****'||M_CURRENT_UTILIZATION||'****'||M_DEAL_INFLOW||'****'||M_DEAL_OUTFLOW||'****'||(M_CURRENT_UTILIZATION+M_DEAL_INFLOW-M_DEAL_OUTFLOW));

           ELSIF (M_COUNT_UTL=0) THEN
--RAISE_APPLICATION_ERROR(-20201,'2222 '||M_DEAL_NO||'*** '||M_TENOR||'*** '||M_CURRENT_UTILIZATION||'*** '||M_DEAL_INFLOW||'*** '||M_DEAL_OUTFLOW);
                INSERT INTO LMT_UTL_ISSUER_INST_MATU
                            (LIMIT_TYPE,
                                  AUCTION_TYPE,
                                  ISSUER_CODE,
                                  ISSUER_LIABILITY_TYPE,
                                  INST_TYPE,
                                  BF_UTILIZATION,
                                  DEAL_INFLOW,
                                  DEAL_OUTFLOW,
                                  CURRENT_UTILIZATION,
                                  DN_USER ,
                                  START_DAYS,
                                  END_DAYS )
                     VALUES ('05',
                                  'S',
                                  M_ISSUER_CODE,
                                  'I',
                                  M_INST_TYPE,
                                  0.00,
                                  M_DEAL_INFLOW,
                                  M_DEAL_OUTFLOW,
                                  (0+M_DEAL_INFLOW-M_DEAL_OUTFLOW),
                                  M_DN_USER ,
                                  DN_LIMIT_ISS_M_FIN_START_DAYS(M_TENOR,M_ISSUER_CODE,'I',M_INST_TYPE),
                                  DN_LIMIT_ISS_MAT_FIN_END_DAYS(M_TENOR,M_ISSUER_CODE,'I',M_INST_TYPE));

          END IF;
   END IF;

   IF (M_INS_UPS_STATUS='U') THEN
           SELECT COUNT(*)
           INTO M_COUNT_UTL
           FROM LMT_UTL_ISSUER_INST_MATU
           WHERE  M_TENOR BETWEEN START_DAYS AND END_DAYS
                  AND ISSUER_CODE=M_ISSUER_CODE
                  AND INST_TYPE=M_INST_TYPE
                  AND ISSUER_LIABILITY_TYPE='I';


             IF (M_COUNT_UTL>0) THEN --RECORD EXISTING IN THE UTILITY TABLE
                  SELECT  CURRENT_UTILIZATION
                  INTO    M_CURRENT_UTILIZATION
                  FROM    LMT_UTL_ISSUER_INST_MATU
                  WHERE   M_TENOR BETWEEN START_DAYS AND END_DAYS
                          AND ISSUER_CODE=M_ISSUER_CODE
                          AND INST_TYPE=M_INST_TYPE
                          AND ISSUER_LIABILITY_TYPE='I';


                      UPDATE LMT_UTL_ISSUER_INST_MATU
                      SET    --LIMIT_TYPE='04' ,
                             --AUCTION_TYPE=M_AUCTION_TYPE,
                             --ISSUER_CODE=M_ISSUER_CODE,
                             -- ISSUER_LIABILITY_TYPE=M_ISSUER_LIA_TYPE,
                             -- INST_TYPE=M_INST_TYPE,
                             BF_UTILIZATION=M_CURRENT_UTILIZATION,
                             DEAL_INFLOW=M_DEAL_OUTFLOW,
                             DEAL_OUTFLOW=M_DEAL_INFLOW,
                             CURRENT_UTILIZATION=(M_CURRENT_UTILIZATION-M_DEAL_INFLOW+M_DEAL_OUTFLOW),
                             DN_USER=M_DN_USER
                     WHERE   M_TENOR BETWEEN START_DAYS AND END_DAYS
                             AND ISSUER_CODE=M_ISSUER_CODE
                             AND INST_TYPE=M_INST_TYPE
                             AND ISSUER_LIABILITY_TYPE='I'
                             AND LIMIT_TYPE='05'
                             AND AUCTION_TYPE='S';


            ELSIF (M_COUNT_UTL=0) THEN    --RECORD DOESN'T EXISTING IN THE UTILITY TABLE

                INSERT INTO LMT_UTL_ISSUER_INST_MATU
                        (   LIMIT_TYPE,
                                  AUCTION_TYPE,
                                  ISSUER_CODE,
                                  ISSUER_LIABILITY_TYPE,
                                  INST_TYPE,
                                  BF_UTILIZATION,
                                  DEAL_INFLOW,
                                  DEAL_OUTFLOW,
                                  CURRENT_UTILIZATION,
                                  DN_USER ,
                                  START_DAYS,
                                  END_DAYS )
                VALUES (   '05',
                                  'S',
                                  M_ISSUER_CODE,
                                  'I',
                                  M_INST_TYPE,
                                  0.00,
                                  M_DEAL_OUTFLOW,
                                  M_DEAL_INFLOW,
                                  (0-M_DEAL_INFLOW+M_DEAL_OUTFLOW),
                                  M_DN_USER ,
                                  DN_LIMIT_ISS_M_FIN_START_DAYS(M_TENOR,M_ISSUER_CODE,'I',M_INST_TYPE),
                                  DN_LIMIT_ISS_MAT_FIN_END_DAYS(M_TENOR,M_ISSUER_CODE,'I',M_INST_TYPE));


          END IF;
   END IF;

/*------COMPARE AND IDENTIFY THE ACTUAL AND POSSIBLE VIOLATION----*/
-------------------------------
DN_LIMIT_COMPARE_TRA_ISSUE_MAT (1,M_ISSUER_CODE,M_INST_TYPE,'I');
--------------------------------
/*-----------------------------------------------------------*/


END IF;
END IF;---FOR M_CASH_DEAL_COUNT

END IF;--FOR LIABILITY TYPE 'ISSUER'

--////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////
IF((MI_GUARANTEE_CODE <>' ') OR(MO_GUARANTEE_CODE<>' ')  ) THEN
/*--------------TO IDENTIFY WHETHER IT IS A BUY OR SALE--------*/
IF SUBSTR(M_DEAL_NO,1,2)='OR' THEN
       IF(MI_GUARANTEE_CODE <>' ')THEN

 SELECT COUNT(*)
          INTO  COUNT_MI_GUARANTEE
          FROM  LMT_STR_ISSUER_INST_MATU
          WHERE ISSUER_CODE=MI_GUARANTEE_CODE;
                IF(COUNT_MI_GUARANTEE>0)THEN
                   STAT_MI_GUARANTEE:='Y';
                END IF;



            SELECT COUNT(*)
			INTO M_COUNT_INFLOW
			FROM
			      DN_TRN_OUTP_SALE A,
			      DN_REF_PORTFOLIO B,
			      DN_REF_SECURITY C
			WHERE
			      A.DEAL_NO=M_DEAL_NO
			      AND
			      B.PORTFOLIO_CODE=A.BUY_PORTFOLIO_CODE
			      AND
			      B.PF_TYPE='P'
			      AND
			      B.OWNED_BY_MBFSL='Y'
			      AND
			      TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
			      AND
			      C.SECURITY_CODE =A.SECURITY_CODE;


					       IF (M_COUNT_INFLOW>0) THEN
					         M_CASH_DEAL_COUNT:=1;
					      	 SELECT A.COST,A.DN_USER,C.GUARANTEE_CODE,C.INST_TYPE,(C.MATURITY_DATE-SYSDATE)
					         INTO   M_DEAL_INFLOW,M_DN_USER,M_GUARANTEE_CODE,M_INST_TYPE,M_TENOR
					      	 FROM
					      	        DN_TRN_OUTP_SALE A,
					      	        DN_REF_PORTFOLIO B,
					                DN_REF_SECURITY C
					      	 WHERE
					      	        A.DEAL_NO=M_DEAL_NO
					      	        AND
					      	        B.PORTFOLIO_CODE=A.BUY_PORTFOLIO_CODE
					      	        AND
					      	        B.PF_TYPE='P'
					                AND
					                B.OWNED_BY_MBFSL='Y'
					                AND
					                TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
					                AND
					                C.SECURITY_CODE =A.SECURITY_CODE;
					       ELSE
					      		M_DEAL_INFLOW:=0;
					       END IF;
                 END IF;
            IF(MO_GUARANTEE_CODE <>' ') THEN

 SELECT COUNT(*)
          INTO  COUNT_MO_GUARANTEE
          FROM  LMT_STR_ISSUER_INST_MATU
          WHERE ISSUER_CODE=MO_GUARANTEE_CODE;
                IF(COUNT_MO_GUARANTEE>0)THEN
                   STAT_MO_GUARANTEE:='Y';
                END IF;





            SELECT COUNT(*) INTO M_COUNT_OUTFLOW
			FROM
			      DN_TRN_OUTP_SALE A,
			      DN_REF_PORTFOLIO B,
			      DN_REF_SECURITY C
			WHERE
			      A.DEAL_NO=M_DEAL_NO
			      AND
			      B.PORTFOLIO_CODE=A.SELL_PORTFOLIO_CODE
			      AND
			      B.PF_TYPE='P'
			      AND
			      B.OWNED_BY_MBFSL='Y'
			      AND
			      TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
			      AND
			      C.SECURITY_CODE =A.SECURITY_CODE;

					        IF (M_COUNT_OUTFLOW>0) THEN
					           M_CASH_DEAL_COUNT:=1;

                               SELECT A.COST,A.DN_USER,C.GUARANTEE_CODE,C.INST_TYPE,(C.MATURITY_DATE-SYSDATE)
					           INTO M_DEAL_OUTFLOW,M_DN_USER,M_GUARANTEE_CODE,M_INST_TYPE,M_TENOR
					      	   FROM
					      	       DN_TRN_OUTP_SALE A,
					      	       DN_REF_PORTFOLIO B,
					               DN_REF_SECURITY C
					      	   WHERE
					      	      A.DEAL_NO=M_DEAL_NO
					      	      AND
					      	      B.PORTFOLIO_CODE=A.SELL_PORTFOLIO_CODE
					      	      AND
					      	      B.PF_TYPE='P'
					              AND
					              B.OWNED_BY_MBFSL='Y'
					              AND
					              TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
					              AND
					              C.SECURITY_CODE =A.SECURITY_CODE;
					       ELSE
					       	 M_DEAL_OUTFLOW:=0;
					       END IF;
        END IF;
END IF;
--******************************************************************************************
--******************************************************************************************

/*	SELECT COUNT(*)
        INTO M_COUNT_G
        FROM LMT_UTL_ISSUER_INST_MATU
        WHERE ISSUER_CODE=M_GUARANTEE_CODE ;

        IF (M_COUNT_G=0)THEN
		  M_CURRENT_UTILIZATION_G:=0 ;
		ELSE
			SELECT   CURRENT_UTILIZATION
		    INTO     M_CURRENT_UTILIZATION_G
			FROM     LMT_UTL_ISSUER_INST_MATU
            WHERE    ISSUER_CODE=M_GUARANTEE_CODE ;
		END IF;*/


IF (M_CASH_DEAL_COUNT=1) THEN
 IF((STAT_MO_GUARANTEE='Y')OR(STAT_MI_GUARANTEE='Y'))THEN

   IF (M_INS_UPS_STATUS='I') THEN


            SELECT COUNT(*)
            INTO   M_COUNT_UTL
            FROM   LMT_UTL_ISSUER_INST_MATU
            WHERE  M_TENOR BETWEEN START_DAYS AND END_DAYS
                   AND ISSUER_CODE=M_GUARANTEE_CODE
                   AND INST_TYPE=M_INST_TYPE
                   AND ISSUER_LIABILITY_TYPE='G';


            IF (M_COUNT_UTL>0) THEN
                 SELECT CURRENT_UTILIZATION
                 INTO   M_CURRENT_UTILIZATION
                 FROM   LMT_UTL_ISSUER_INST_MATU
                 WHERE  M_TENOR BETWEEN START_DAYS AND END_DAYS
                        AND ISSUER_CODE=M_GUARANTEE_CODE
                        AND INST_TYPE=M_INST_TYPE
                        AND ISSUER_LIABILITY_TYPE='G';



                     UPDATE LMT_UTL_ISSUER_INST_MATU
                     SET    --LIMIT_TYPE='04' ,
                            --AUCTION_TYPE=M_AUCTION_TYPE,
                            --ISSUER_CODE=M_ISSUER_CODE,
                            --ISSUER_LIABILITY_TYPE=M_ISSUER_LIA_TYPE,
                            --INST_TYPE=M_INST_TYPE,
                            BF_UTILIZATION=M_CURRENT_UTILIZATION,
                            DEAL_INFLOW=M_DEAL_INFLOW,
                            DEAL_OUTFLOW=M_DEAL_OUTFLOW,
                            CURRENT_UTILIZATION=(M_CURRENT_UTILIZATION+M_DEAL_INFLOW-M_DEAL_OUTFLOW),
                            DN_USER=M_DN_USER
                     WHERE  M_TENOR BETWEEN START_DAYS AND END_DAYS
                            AND ISSUER_CODE=M_GUARANTEE_CODE
                            AND INST_TYPE=M_INST_TYPE
                            AND ISSUER_LIABILITY_TYPE='G'
                            AND LIMIT_TYPE='05'
                            AND AUCTION_TYPE='S';


 --RAISE_APPLICATION_ERROR(-20201,'333 '||'****'||M_COUNT_UTL ||'****'||M_TENOR||'****'||M_CURRENT_UTILIZATION||'****'||M_DEAL_INFLOW||'****'||M_DEAL_OUTFLOW||'****'||(M_CURRENT_UTILIZATION+M_DEAL_INFLOW-M_DEAL_OUTFLOW));

           ELSIF (M_COUNT_UTL=0) THEN
--RAISE_APPLICATION_ERROR(-20201,'2222 '||M_DEAL_NO||'*** '||M_TENOR||'*** '||M_CURRENT_UTILIZATION||'*** '||M_DEAL_INFLOW||'*** '||M_DEAL_OUTFLOW);
                INSERT INTO LMT_UTL_ISSUER_INST_MATU
                            (LIMIT_TYPE,
                                  AUCTION_TYPE,
                                  ISSUER_CODE,
                                  ISSUER_LIABILITY_TYPE,
                                  INST_TYPE,
                                  BF_UTILIZATION,
                                  DEAL_INFLOW,
                                  DEAL_OUTFLOW,
                                  CURRENT_UTILIZATION,
                                  DN_USER ,
                                  START_DAYS,
                                  END_DAYS )
                     VALUES ('05',
                                  'S',
                                  M_GUARANTEE_CODE,
                                  'G',
                                  M_INST_TYPE,
                                  0.00,
                                  M_DEAL_INFLOW,
                                  M_DEAL_OUTFLOW,
                                  (0+M_DEAL_INFLOW-M_DEAL_OUTFLOW),
                                  M_DN_USER ,
                                  DN_LIMIT_ISS_M_FIN_START_DAYS(M_TENOR,M_GUARANTEE_CODE,'G',M_INST_TYPE),
                                  DN_LIMIT_ISS_MAT_FIN_END_DAYS(M_TENOR,M_GUARANTEE_CODE,'G',M_INST_TYPE));




          END IF;
   END IF;

   IF (M_INS_UPS_STATUS='U') THEN
           SELECT COUNT(*)
           INTO M_COUNT_UTL
           FROM LMT_UTL_ISSUER_INST_MATU
           WHERE  M_TENOR BETWEEN START_DAYS AND END_DAYS
                  AND ISSUER_CODE=M_GUARANTEE_CODE
                  AND INST_TYPE=M_INST_TYPE
                  AND ISSUER_LIABILITY_TYPE='G';


             IF (M_COUNT_UTL>0) THEN --RECORD EXISTING IN THE UTILITY TABLE
                  SELECT  CURRENT_UTILIZATION
                  INTO    M_CURRENT_UTILIZATION
                  FROM    LMT_UTL_ISSUER_INST_MATU
                  WHERE   M_TENOR BETWEEN START_DAYS AND END_DAYS
                          AND ISSUER_CODE=M_GUARANTEE_CODE
                          AND INST_TYPE=M_INST_TYPE
                          AND ISSUER_LIABILITY_TYPE='G';



                      UPDATE LMT_UTL_ISSUER_INST_MATU
                      SET    --LIMIT_TYPE='04' ,
                             --AUCTION_TYPE=M_AUCTION_TYPE,
                             --ISSUER_CODE=M_ISSUER_CODE,
                             -- ISSUER_LIABILITY_TYPE=M_ISSUER_LIA_TYPE,
                             -- INST_TYPE=M_INST_TYPE,
                             BF_UTILIZATION=M_CURRENT_UTILIZATION,
                             DEAL_INFLOW=M_DEAL_OUTFLOW,
                             DEAL_OUTFLOW=M_DEAL_INFLOW,
                             CURRENT_UTILIZATION=(M_CURRENT_UTILIZATION-M_DEAL_INFLOW+M_DEAL_OUTFLOW),
                             DN_USER=M_DN_USER
                     WHERE   M_TENOR BETWEEN START_DAYS AND END_DAYS
                             AND ISSUER_CODE=M_GUARANTEE_CODE
                             AND INST_TYPE=M_INST_TYPE
                             AND ISSUER_LIABILITY_TYPE='G'
                            AND LIMIT_TYPE='05'
                            AND AUCTION_TYPE='S';


            ELSIF (M_COUNT_UTL=0) THEN    --RECORD DOESN'T EXISTING IN THE UTILITY TABLE

                INSERT INTO LMT_UTL_ISSUER_INST_MATU
                        (   LIMIT_TYPE,
                                  AUCTION_TYPE,
                                  ISSUER_CODE,
                                  ISSUER_LIABILITY_TYPE,
                                  INST_TYPE,
                                  BF_UTILIZATION,
                                  DEAL_INFLOW,
                                  DEAL_OUTFLOW,
                                  CURRENT_UTILIZATION,
                                  DN_USER ,
                                  START_DAYS,
                                  END_DAYS )
                VALUES (   '05',
                                  'S',
                                  M_GUARANTEE_CODE,
                                  'G',
                                  M_INST_TYPE,
                                  0.00,
                                  M_DEAL_OUTFLOW,
                                  M_DEAL_INFLOW,
                                  (0-M_DEAL_INFLOW+M_DEAL_OUTFLOW),
                                  M_DN_USER ,
                                  DN_LIMIT_ISS_M_FIN_START_DAYS(M_TENOR,M_GUARANTEE_CODE,'G',M_INST_TYPE),
                                  DN_LIMIT_ISS_MAT_FIN_END_DAYS(M_TENOR,M_GUARANTEE_CODE,'G',M_INST_TYPE));


          END IF;
   END IF;
/*------COMPARE AND IDENTIFY THE ACTUAL AND POSSIBLE VIOLATION----*/
-------------------------------
DN_LIMIT_COMPARE_TRA_ISSUE_MAT (1,M_GUARANTEE_CODE,M_INST_TYPE,'G');
--------------------------------
/*-----------------------------------------------------------*/

END IF;
END IF;---FOR M_CASH_DEAL_COUNT

END IF;--FOR LIABILITY TYPE 'GUARANTOR'

--////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////
IF((MI_ENDOSER_CODE  <> ' ') OR (MO_ENDOSER_CODE  <> ' ')  ) THEN
/*--------------TO IDENTIFY WHETHER IT IS A BUY OR SALE--------*/
IF SUBSTR(M_DEAL_NO,1,2)='OR' THEN
       IF (MI_ENDOSER_CODE  <> ' ') THEN

          SELECT COUNT(*)
          INTO  COUNT_MI_ENDOSER
          FROM  LMT_STR_ISSUER_INST_MATU
          WHERE ISSUER_CODE=MI_ENDOSER_CODE;
                IF(COUNT_MI_ENDOSER>0)THEN
                   STAT_MI_ENDOSER:='Y';
                END IF;


            SELECT COUNT(*)
			INTO M_COUNT_INFLOW
			FROM
			      DN_TRN_OUTP_SALE A,
			      DN_REF_PORTFOLIO B,
			      DN_REF_SECURITY C
			WHERE
			      A.DEAL_NO=M_DEAL_NO
			      AND
			      B.PORTFOLIO_CODE=A.BUY_PORTFOLIO_CODE
			      AND
			      B.PF_TYPE='P'
			      AND
			      B.OWNED_BY_MBFSL='Y'
			      AND
			      TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
			      AND
			      C.SECURITY_CODE =A.SECURITY_CODE;


					       IF (M_COUNT_INFLOW>0) THEN
					         M_CASH_DEAL_COUNT:=1;
					      	 SELECT A.COST,A.DN_USER,A.ENDOSER_CODE,C.INST_TYPE,(C.MATURITY_DATE-SYSDATE)
					         INTO   M_DEAL_INFLOW,M_DN_USER,M_ENDOSER_CODE,M_INST_TYPE,M_TENOR
					      	 FROM
					      	        DN_TRN_OUTP_SALE A,
					      	        DN_REF_PORTFOLIO B,
					                DN_REF_SECURITY C
					      	 WHERE
					      	        A.DEAL_NO=M_DEAL_NO
					      	        AND
					      	        B.PORTFOLIO_CODE=A.BUY_PORTFOLIO_CODE
					      	        AND
					      	        B.PF_TYPE='P'
					                AND
					                B.OWNED_BY_MBFSL='Y'
					                AND
					                TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
					                AND
					                C.SECURITY_CODE =A.SECURITY_CODE;
					       ELSE
					      		M_DEAL_INFLOW:=0;
					       END IF;
                  END IF;
            IF (MI_ENDOSER_CODE  <> ' ') THEN

          SELECT COUNT(*)
          INTO  COUNT_MO_ENDOSER
          FROM  LMT_STR_ISSUER_INST_MATU
          WHERE ISSUER_CODE=MO_ENDOSER_CODE;
                IF(COUNT_MO_ENDOSER>0)THEN
                   STAT_MO_ENDOSER:='Y';
                END IF;



            SELECT COUNT(*) INTO M_COUNT_OUTFLOW
			FROM
			      DN_TRN_OUTP_SALE A,
			      DN_REF_PORTFOLIO B,
			      DN_REF_SECURITY C
			WHERE
			      A.DEAL_NO=M_DEAL_NO
			      AND
			      B.PORTFOLIO_CODE=A.SELL_PORTFOLIO_CODE
			      AND
			      B.PF_TYPE='P'
			      AND
			      B.OWNED_BY_MBFSL='Y'
			      AND
			      TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
			      AND
			      C.SECURITY_CODE =A.SECURITY_CODE;

					        IF (M_COUNT_OUTFLOW>0) THEN
					           M_CASH_DEAL_COUNT:=1;

                               SELECT A.COST,A.DN_USER,A.ENDOSER_CODE,C.INST_TYPE,(C.MATURITY_DATE-SYSDATE)
					           INTO M_DEAL_OUTFLOW,M_DN_USER,M_ENDOSER_CODE,M_INST_TYPE,M_TENOR
					      	   FROM
					      	       DN_TRN_OUTP_SALE A,
					      	       DN_REF_PORTFOLIO B,
					               DN_REF_SECURITY C
					      	   WHERE
					      	      A.DEAL_NO=M_DEAL_NO
					      	      AND
					      	      B.PORTFOLIO_CODE=A.SELL_PORTFOLIO_CODE
					      	      AND
					      	      B.PF_TYPE='P'
					              AND
					              B.OWNED_BY_MBFSL='Y'
					              AND
					              TO_CHAR(A.EFF_VALDATE,'DD/MM/YYYY')=TO_CHAR(SYSDATE,'DD/MM/YYYY')
					              AND
					              C.SECURITY_CODE =A.SECURITY_CODE;
					       ELSE
					       	 M_DEAL_OUTFLOW:=0;
					       END IF;
                     END IF;
			          --RAISE_APPLICATION_ERROR(-20201,'1111'||M_DEAL_NO||'*****'||M_INS_UPS_STATUS||'*****'||M_COUNT_INFLOW||'*****'||M_DEAL_INFLOW||'*****'||M_COUNT_OUTFLOW||'*****'||M_DEAL_OUTFLOW);
END IF;
--******************************************************************************************
--******************************************************************************************

     /*   SELECT COUNT(*)
        INTO M_COUNT_E
        FROM LMT_UTL_ISSUER_INST_MATU
        WHERE ISSUER_CODE=M_ENDOSER_CODE ;

        IF (M_COUNT_E=0)THEN
		  M_CURRENT_UTILIZATION_E:=0 ;
		ELSE
			SELECT   CURRENT_UTILIZATION
		    INTO     M_CURRENT_UTILIZATION_E
			FROM     LMT_UTL_ISSUER_INST_MATU
            WHERE    ISSUER_CODE=M_ENDOSER_CODE ;
		END IF;*/




IF (M_CASH_DEAL_COUNT=1) THEN
 IF((STAT_MO_ENDOSER='Y')OR(STAT_MI_ENDOSER='Y'))THEN

   IF (M_INS_UPS_STATUS='I') THEN


            SELECT COUNT(*)
            INTO   M_COUNT_UTL
            FROM   LMT_UTL_ISSUER_INST_MATU
            WHERE  M_TENOR BETWEEN START_DAYS AND END_DAYS
                   AND ISSUER_CODE=M_ENDOSER_CODE
                   AND INST_TYPE=M_INST_TYPE
                   AND ISSUER_LIABILITY_TYPE='E';


            IF (M_COUNT_UTL>0) THEN
                 SELECT CURRENT_UTILIZATION
                 INTO   M_CURRENT_UTILIZATION
                 FROM   LMT_UTL_ISSUER_INST_MATU
                 WHERE  M_TENOR BETWEEN START_DAYS AND END_DAYS
                        AND ISSUER_CODE=M_ENDOSER_CODE
                        AND INST_TYPE=M_INST_TYPE
                        AND ISSUER_LIABILITY_TYPE = 'E'  ;



                     UPDATE LMT_UTL_ISSUER_INST_MATU
                     SET    --LIMIT_TYPE='04' ,
                            --AUCTION_TYPE=M_AUCTION_TYPE,
                            --ISSUER_CODE=M_ISSUER_CODE,
                            --ISSUER_LIABILITY_TYPE=M_ISSUER_LIA_TYPE,
                            --INST_TYPE=M_INST_TYPE,
                            BF_UTILIZATION=M_CURRENT_UTILIZATION,
                            DEAL_INFLOW=M_DEAL_INFLOW,
                            DEAL_OUTFLOW=M_DEAL_OUTFLOW,
                            CURRENT_UTILIZATION=(M_CURRENT_UTILIZATION+M_DEAL_INFLOW-M_DEAL_OUTFLOW),
                            DN_USER=M_DN_USER
                     WHERE  M_TENOR BETWEEN START_DAYS AND END_DAYS
                            AND ISSUER_CODE=M_ENDOSER_CODE
                            AND INST_TYPE=M_INST_TYPE
                            AND ISSUER_LIABILITY_TYPE='E'
                            AND LIMIT_TYPE='05'
                            AND AUCTION_TYPE='S';


 --RAISE_APPLICATION_ERROR(-20201,'333 '||'****'||M_COUNT_UTL ||'****'||M_TENOR||'****'||M_CURRENT_UTILIZATION||'****'||M_DEAL_INFLOW||'****'||M_DEAL_OUTFLOW||'****'||(M_CURRENT_UTILIZATION+M_DEAL_INFLOW-M_DEAL_OUTFLOW));

           ELSIF (M_COUNT_UTL=0) THEN
--RAISE_APPLICATION_ERROR(-20201,'2222 '||M_DEAL_NO||'*** '||M_TENOR||'*** '||M_CURRENT_UTILIZATION||'*** '||M_DEAL_INFLOW||'*** '||M_DEAL_OUTFLOW);

                INSERT INTO LMT_UTL_ISSUER_INST_MATU
                            (LIMIT_TYPE,
                                  AUCTION_TYPE,
                                  ISSUER_CODE,
                                  ISSUER_LIABILITY_TYPE,
                                  INST_TYPE,
                                  BF_UTILIZATION,
                                  DEAL_INFLOW,
                                  DEAL_OUTFLOW,
                                  CURRENT_UTILIZATION,
                                  DN_USER ,
                                  START_DAYS,
                                  END_DAYS )
                     VALUES ('05',
                                  'S',
                                  M_ENDOSER_CODE,
                                  'E',
                                  M_INST_TYPE,
                                  0.00,
                                  M_DEAL_INFLOW,
                                  M_DEAL_OUTFLOW,
                                  (0+M_DEAL_INFLOW-M_DEAL_OUTFLOW),
                                  M_DN_USER ,
                                  DN_LIMIT_ISS_M_FIN_START_DAYS(M_TENOR,M_ENDOSER_CODE,'E',M_INST_TYPE),
                                  DN_LIMIT_ISS_MAT_FIN_END_DAYS(M_TENOR,M_ENDOSER_CODE,'E',M_INST_TYPE));

          END IF;
   END IF;

   IF (M_INS_UPS_STATUS='U') THEN
           SELECT COUNT(*)
           INTO M_COUNT_UTL
           FROM LMT_UTL_ISSUER_INST_MATU
           WHERE  M_TENOR BETWEEN START_DAYS AND END_DAYS
                  AND ISSUER_CODE=M_ENDOSER_CODE
                  AND INST_TYPE=M_INST_TYPE
                  AND ISSUER_LIABILITY_TYPE='E';


             IF (M_COUNT_UTL>0) THEN --RECORD EXISTING IN THE UTILITY TABLE
                  SELECT  CURRENT_UTILIZATION
                  INTO    M_CURRENT_UTILIZATION
                  FROM    LMT_UTL_ISSUER_INST_MATU
                  WHERE   M_TENOR BETWEEN START_DAYS AND END_DAYS
                          AND ISSUER_CODE=M_ENDOSER_CODE
                          AND INST_TYPE=M_INST_TYPE
                          AND ISSUER_LIABILITY_TYPE='E';
                          --AND SUBSTR(LIMIT_CODE,4,4) = M_ISSUER_CODE;


                      UPDATE LMT_UTL_ISSUER_INST_MATU
                      SET    --LIMIT_TYPE='04' ,
                             --AUCTION_TYPE=M_AUCTION_TYPE,
                             --ISSUER_CODE=M_ISSUER_CODE,
                             -- ISSUER_LIABILITY_TYPE=M_ISSUER_LIA_TYPE,
                             -- INST_TYPE=M_INST_TYPE,
                             BF_UTILIZATION=M_CURRENT_UTILIZATION,
                             DEAL_INFLOW=M_DEAL_OUTFLOW,
                             DEAL_OUTFLOW=M_DEAL_INFLOW,
                             CURRENT_UTILIZATION=(M_CURRENT_UTILIZATION-M_DEAL_INFLOW+M_DEAL_OUTFLOW),
                             DN_USER=M_DN_USER
                     WHERE   M_TENOR BETWEEN START_DAYS AND END_DAYS
                             AND ISSUER_CODE=M_ENDOSER_CODE
                             AND INST_TYPE=M_INST_TYPE
                             AND ISSUER_LIABILITY_TYPE='E'
                             AND LIMIT_TYPE='05'
                             AND AUCTION_TYPE='S';
                             --AND SUBSTR(LIMIT_CODE,4,4) = M_ISSUER_CODE;

            ELSIF (M_COUNT_UTL=0) THEN    --RECORD DOESN'T EXISTING IN THE UTILITY TABLE

                INSERT INTO LMT_UTL_ISSUER_INST_MATU
                        (   LIMIT_TYPE,
                                  AUCTION_TYPE,
                                  ISSUER_CODE,
                                  ISSUER_LIABILITY_TYPE,
                                  INST_TYPE,
                                  BF_UTILIZATION,
                                  DEAL_INFLOW,
                                  DEAL_OUTFLOW,
                                  CURRENT_UTILIZATION,
                                  DN_USER ,
                                  START_DAYS,
                                  END_DAYS )
                VALUES (   '05',
                                  'S',
                                  M_ENDOSER_CODE,
                                  'E',
                                  M_INST_TYPE,
                                  0.00,
                                  M_DEAL_OUTFLOW,
                                  M_DEAL_INFLOW,
                                  (0-M_DEAL_INFLOW+M_DEAL_OUTFLOW),
                                  M_DN_USER ,
                                  DN_LIMIT_ISS_M_FIN_START_DAYS(M_TENOR,M_ENDOSER_CODE,'E',M_INST_TYPE),
                                  DN_LIMIT_ISS_MAT_FIN_END_DAYS(M_TENOR,M_ENDOSER_CODE,'E',M_INST_TYPE));



          END IF;
   END IF;

/*------COMPARE AND IDENTIFY THE ACTUAL AND POSSIBLE VIOLATION----*/
-------------------------------
DN_LIMIT_COMPARE_TRA_ISSUE_MAT (1,M_GUARANTEE_CODE,M_INST_TYPE,'E');
--------------------------------
/*-----------------------------------------------------------*/

END IF;
END IF;---FOR M_CASH_DEAL_COUNT
--COMMIT;
END IF;--FOR LIABILITY TYPE 'ENDOSER'
END DN_LIMIT_TRN_ISSUER_INST_MAT;

/
