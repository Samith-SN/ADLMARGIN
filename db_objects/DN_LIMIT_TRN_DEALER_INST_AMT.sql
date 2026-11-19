--------------------------------------------------------
--  DDL for Procedure DN_LIMIT_TRN_DEALER_INST_AMT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_LIMIT_TRN_DEALER_INST_AMT" 
   (
    M_DEAL_NO     			DN_TRN_OUTP_SALE.DEAL_NO%TYPE,
    M_INS_UPS_STATUS		VARCHAR2
    )

   IS

    -- Procedue     : Insert into the table (LMT_UTL_DEALER_INST_AMT) with current utilistion //
    -- System       : Dealnet system.
    -- Created by   : nirmala fernando.
    -- Created on   : 06/03/2001.


 M_CURRENT_UTILIZATION      LMT_UTL_DEALER_INST_AMT.CURRENT_UTILIZATION%TYPE;
 M_DEAL_INFLOW              LMT_UTL_DEALER_INST_AMT.DEAL_INFLOW%TYPE;
 M_DEAL_OUTFLOW             LMT_UTL_DEALER_INST_AMT.DEAL_OUTFLOW%TYPE;
 M_COUNT					INTEGER;
 M_COUNT_OUTFLOW		    INTEGER;
 M_COUNT_INFLOW		        INTEGER;
 M_COUNT_AMOUNT             INTEGER;
 M_TENOR                    INTEGER;
 --M_ROW_ID					INTEGER;
 M_CASH_DEAL_COUNT          INTEGER;
 M_DN_USER                  DN_TRN_OUTP_SALE.DN_USER%TYPE;
 M_DEALER_CODE              LMT_UTL_DEALER_INST_AMT.DEALER_CODE%TYPE;
 M_AUCTION_TYPE             LMT_UTL_DEALER_INST_AMT.AUCTION_TYPE%TYPE;
 M_INST_TYPE                LMT_UTL_DEALER_INST_AMT.INST_TYPE%TYPE;
 --M_ISSUER_LIA_TYPE        LMT_UTL_DEALER_INST_AMT.ISSUER_LIABILITY_TYPE%TYPE;
 MI_ISSUER_CODE             LMT_UTL_DEALER_INST_AMT.DEALER_CODE%TYPE;
 MI_GUARANTEE_CODE          LMT_UTL_DEALER_INST_AMT.DEALER_CODE%TYPE;
 MI_ENDOSER_CODE            LMT_UTL_DEALER_INST_AMT.DEALER_CODE%TYPE;
 MO_ISSUER_CODE             LMT_UTL_DEALER_INST_AMT.DEALER_CODE%TYPE;
 MO_GUARANTEE_CODE          LMT_UTL_DEALER_INST_AMT.DEALER_CODE%TYPE;
 MO_ENDOSER_CODE            LMT_UTL_DEALER_INST_AMT.DEALER_CODE%TYPE;
 M_GUARANTEE_CODE           LMT_UTL_DEALER_INST_AMT.DEALER_CODE%TYPE;
 M_ENDOSER_CODE             LMT_UTL_DEALER_INST_AMT.DEALER_CODE%TYPE;
 MM_COUNT9                  NUMBER;
 M_NEW_SYSDATE              DATE;
 M_TRADE_TYPE               LMT_UTL_DEALER_INST_AMT.TRADE_TYPE%TYPE;
 M_COUNT_DEALER             INTEGER;
BEGIN

	M_DEAL_INFLOW:=0;
	M_DEAL_OUTFLOW:=0;
	M_CASH_DEAL_COUNT:=0;


              SELECT COUNT(*)
              INTO   M_COUNT_DEALER
              FROM   DN_TIME_LOG
              WHERE  SUS_REF_NO=M_DEAL_NO AND
                     DESCRIPTION='ENTERED';

              IF(M_COUNT_DEALER>0)THEN

              SELECT DN_USER
              INTO   M_DEALER_CODE
              FROM   DN_TIME_LOG
              WHERE  SUS_REF_NO=M_DEAL_NO AND
                     DESCRIPTION='ENTERED';


            END IF;



  SELECT DN_GET_NEW_VALUEDATE
  INTO   M_NEW_SYSDATE
  FROM   DUAL;
--RAISE_APPLICATION_ERROR(-20201,'************'||M_NEW_SYSDATE);
-----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
IF SUBSTR(M_DEAL_NO,1,2)='OR' THEN
     M_DEAL_INFLOW:=0;
     SELECT COUNT(*)
     INTO   M_COUNT_INFLOW
     FROM
     (SELECT A.COST AAA,A.DN_USER BBB,'SP' CCC
	  FROM   DN_TRN_OUTP_SALE A,
			 DN_REF_PORTFOLIO B
	  WHERE  A.DEAL_NO=M_DEAL_NO  AND
			 B.PORTFOLIO_CODE=A.BUY_PORTFOLIO_CODE    AND
			 B.PF_TYPE='P' AND
			 B.OWNED_BY_MBFSL='Y' AND
			 A.EFF_VALDATE<=M_NEW_SYSDATE
     UNION
     SELECT A.COST AAA,A.DN_USER BBB,'FO' CCC
	 FROM   DN_TRN_OUTP_SALE A,
			DN_REF_PORTFOLIO B
	 WHERE  A.DEAL_NO=M_DEAL_NO  AND
			B.PORTFOLIO_CODE=A.BUY_PORTFOLIO_CODE  AND
			B.PF_TYPE='P' AND
			B.OWNED_BY_MBFSL='Y' AND
			A.EFF_VALDATE>M_NEW_SYSDATE)RRR ;



                             IF (M_COUNT_INFLOW>0) THEN
					           M_CASH_DEAL_COUNT:=1;

                             SELECT RRR.AAA,RRR.BBB,RRR.CCC
                             INTO   M_DEAL_INFLOW,M_DN_USER,M_TRADE_TYPE
                             FROM
                             (SELECT A.COST AAA,A.DN_USER BBB,'SP' CCC
					       	  FROM   DN_TRN_OUTP_SALE A,
					      	         DN_REF_PORTFOLIO B
					      	  WHERE  A.DEAL_NO=M_DEAL_NO  AND
					      	         B.PORTFOLIO_CODE=A.BUY_PORTFOLIO_CODE  AND
					      	         B.PF_TYPE='P' AND
					                 B.OWNED_BY_MBFSL='Y' AND
					                 A.EFF_VALDATE<=M_NEW_SYSDATE
                             UNION
                             SELECT A.COST AAA,A.DN_USER BBB,'FO' CCC
					       	 FROM   DN_TRN_OUTP_SALE A,
					      	        DN_REF_PORTFOLIO B
					      	 WHERE  A.DEAL_NO=M_DEAL_NO  AND
					      	        B.PORTFOLIO_CODE=A.BUY_PORTFOLIO_CODE AND
					      	        B.PF_TYPE='P' AND
					                B.OWNED_BY_MBFSL='Y' AND
					                A.EFF_VALDATE>M_NEW_SYSDATE)RRR ;

					       ELSE
					      		M_DEAL_INFLOW:=0;
					       END IF;

                               M_DEAL_OUTFLOW:=0;
                               SELECT COUNT(*)
                               INTO   M_COUNT_OUTFLOW
                               FROM
                               (SELECT A.COST AAA,A.DN_USER BBB,'SP' CCC
					            FROM   DN_TRN_OUTP_SALE A,
					      	          DN_REF_PORTFOLIO B
					      	   WHERE  A.DEAL_NO=M_DEAL_NO  AND
					      	          B.PORTFOLIO_CODE=A.SELL_PORTFOLIO_CODE   AND
					      	          B.PF_TYPE='P' AND
					                  B.OWNED_BY_MBFSL='Y' AND
					                  A.EFF_VALDATE<=M_NEW_SYSDATE
                               UNION
                               SELECT A.COST AAA,A.DN_USER BBB,'FO' CCC
					           FROM   DN_TRN_OUTP_SALE A,
					      	          DN_REF_PORTFOLIO B
					      	   WHERE  A.DEAL_NO=M_DEAL_NO  AND
					      	          B.PORTFOLIO_CODE=A.SELL_PORTFOLIO_CODE   AND
					      	          B.PF_TYPE='P' AND
					                  B.OWNED_BY_MBFSL='Y' AND
					                  A.EFF_VALDATE>M_NEW_SYSDATE)RRR;


					        IF (M_COUNT_OUTFLOW>0) THEN
					           M_CASH_DEAL_COUNT:=1;
                               SELECT RRR.AAA,RRR.BBB,RRR.CCC
                               INTO   M_DEAL_OUTFLOW,M_DN_USER,M_TRADE_TYPE
                               FROM
                               (SELECT A.COST AAA,A.DN_USER BBB,'SP' CCC
					            FROM   DN_TRN_OUTP_SALE A,
					      	          DN_REF_PORTFOLIO B
					      	   WHERE  A.DEAL_NO=M_DEAL_NO  AND
					      	          B.PORTFOLIO_CODE=A.SELL_PORTFOLIO_CODE   AND
					      	          B.PF_TYPE='P' AND
					                  B.OWNED_BY_MBFSL='Y' AND
					                  A.EFF_VALDATE<=M_NEW_SYSDATE
                               UNION
                               SELECT A.COST AAA,A.DN_USER BBB,'FO' CCC
					           FROM   DN_TRN_OUTP_SALE A,
					      	          DN_REF_PORTFOLIO B
					      	   WHERE  A.DEAL_NO=M_DEAL_NO  AND
					      	          B.PORTFOLIO_CODE=A.SELL_PORTFOLIO_CODE   AND
					      	          B.PF_TYPE='P' AND
					                  B.OWNED_BY_MBFSL='Y' AND
					                  A.EFF_VALDATE>M_NEW_SYSDATE)RRR;

					       ELSE
					       	 M_DEAL_OUTFLOW:=0;
					       END IF;



----------------------------------------------------------------------------------------------
ELSIF SUBSTR(M_DEAL_NO,1,2)='RF' THEN

	   M_COUNT_AMOUNT:=0;
                      SELECT COUNT(*)
                      INTO   M_COUNT_AMOUNT
                      FROM
                     (SELECT (LEG1_VALUE+A.INT_ACCR)AAA,A.TENOR BBB,A.DN_USER CCC,'0' DDD,'SP' EEE
                     FROM	 DN_TRN_REPO_FRESH A,
							 DN_REF_PORTFOLIO B
					 WHERE   A.DEAL_NO=M_DEAL_NO AND
                			 B.PORTFOLIO_CODE=A.LEND_PORTFOLIO_CODE  AND
                		     B.PF_TYPE='P' AND
                             A.EFF_VALDATE<=M_NEW_SYSDATE AND
                             B.OWNED_BY_MBFSL='Y'
                     UNION
                     SELECT (LEG1_VALUE+A.INT_ACCR)AAA,A.TENOR BBB,A.DN_USER CCC,'0' DDD,'FO' EEE
                     FROM	 DN_TRN_REPO_FRESH A,
							 DN_REF_PORTFOLIO B
					 WHERE   A.DEAL_NO=M_DEAL_NO AND
                			 B.PORTFOLIO_CODE=A.LEND_PORTFOLIO_CODE  AND
                		     B.PF_TYPE='P' AND
                             A.EFF_VALDATE>M_NEW_SYSDATE AND
                             B.OWNED_BY_MBFSL='Y')RRR  ;



                  IF(M_COUNT_AMOUNT>0)THEN
                     M_CASH_DEAL_COUNT:=1;
                      SELECT RRR.AAA,RRR.BBB,RRR.CCC,RRR.DDD,RRR.EEE
                      INTO   M_DEAL_INFLOW,M_TENOR,M_DN_USER,M_DEAL_OUTFLOW,M_TRADE_TYPE
                      FROM
                     (SELECT (LEG1_VALUE+A.INT_ACCR)AAA,A.TENOR BBB,A.DN_USER CCC,'0' DDD,'SP' EEE
                      FROM	 DN_TRN_REPO_FRESH A,
							 DN_REF_PORTFOLIO B
					 WHERE   A.DEAL_NO=M_DEAL_NO AND
                			 B.PORTFOLIO_CODE=A.LEND_PORTFOLIO_CODE  AND
                		     B.PF_TYPE='P' AND
                             A.EFF_VALDATE<=M_NEW_SYSDATE AND
                             B.OWNED_BY_MBFSL='Y'
                     UNION
                     SELECT (LEG1_VALUE+A.INT_ACCR)AAA,A.TENOR BBB,A.DN_USER CCC,'0' DDD,'FO' EEE
                     FROM	 DN_TRN_REPO_FRESH A,
							 DN_REF_PORTFOLIO B
					 WHERE   A.DEAL_NO=M_DEAL_NO AND
                			 B.PORTFOLIO_CODE=A.LEND_PORTFOLIO_CODE  AND
                		     B.PF_TYPE='P' AND
                             A.EFF_VALDATE>M_NEW_SYSDATE AND
                             B.OWNED_BY_MBFSL='Y')RRR ;
			      END IF;


----------------------------------------------------------------------------------------------
ELSIF SUBSTR(M_DEAL_NO,1,2)='RR' THEN
	  M_COUNT_AMOUNT:=0;
	                     SELECT COUNT(*)
                         INTO    M_COUNT_AMOUNT
                         FROM
                        (SELECT (LEG1_VALUE+A.INT_ACCR)AAA,A.TENOR BBB,A.DN_USER CCC,'0' DDD,'SP' EEE
                         FROM    DN_TRN_REPO_ROLLOVER A,
              			        DN_REF_PORTFOLIO B
              		    WHERE   A.DEAL_NO=M_DEAL_NO  AND
                      			B.PORTFOLIO_CODE=A.LEND_PORTFOLIO_CODE  AND
                      			B.PF_TYPE='P' AND
                                A.EFF_VALDATE<=M_NEW_SYSDATE  AND
                                B.OWNED_BY_MBFSL='Y'
                        UNION
                        SELECT (LEG1_VALUE+A.INT_ACCR)AAA,A.TENOR BBB,A.DN_USER CCC,'0' DDD,'FO' EEE
                       	FROM    DN_TRN_REPO_ROLLOVER A,
              			        DN_REF_PORTFOLIO B
              		    WHERE   A.DEAL_NO=M_DEAL_NO  AND
                      			B.PORTFOLIO_CODE=A.LEND_PORTFOLIO_CODE  AND
                      			B.PF_TYPE='P' AND
                                A.EFF_VALDATE>M_NEW_SYSDATE  AND
                                B.OWNED_BY_MBFSL='Y')RRR;



                  IF (M_COUNT_AMOUNT>0) THEN
                        M_CASH_DEAL_COUNT:=1;
                         SELECT RRR.AAA,RRR.BBB,RRR.CCC,RRR.DDD,RRR.EEE
                         INTO    M_DEAL_INFLOW,M_TENOR,M_DN_USER,M_DEAL_OUTFLOW,M_TRADE_TYPE
                         FROM
                        (SELECT (LEG1_VALUE+A.INT_ACCR)AAA,A.TENOR BBB,A.DN_USER CCC,'0' DDD,'SP' EEE
                         FROM    DN_TRN_REPO_ROLLOVER A,
              			        DN_REF_PORTFOLIO B
              		    WHERE   A.DEAL_NO=M_DEAL_NO  AND
                      			B.PORTFOLIO_CODE=A.LEND_PORTFOLIO_CODE  AND
                      			B.PF_TYPE='P' AND
                                A.EFF_VALDATE<=M_NEW_SYSDATE  AND
                                B.OWNED_BY_MBFSL='Y'
                        UNION
                        SELECT (LEG1_VALUE+A.INT_ACCR)AAA,A.TENOR BBB,A.DN_USER CCC,'0' DDD,'FO' EEE
                       	FROM    DN_TRN_REPO_ROLLOVER A,
              			        DN_REF_PORTFOLIO B
              		    WHERE   A.DEAL_NO=M_DEAL_NO  AND
                      			B.PORTFOLIO_CODE=A.LEND_PORTFOLIO_CODE  AND
                      			B.PF_TYPE='P' AND
                                A.EFF_VALDATE>M_NEW_SYSDATE  AND
                                B.OWNED_BY_MBFSL='Y')RRR;
                 END IF;




-----------------------------------------------------------------------------------------------------
ELSIF  SUBSTR(M_DEAL_NO,1,2)='BF' THEN
		 M_COUNT_AMOUNT:=0;
 		                   SELECT COUNT(*)
                           INTO   M_COUNT_AMOUNT
                           FROM
                          (SELECT LEG1_VALUE AAA,A.TENOR BBB,A.DN_USER CCC,'0' DDD,'SP' EEE
						  FROM   DN_TRN_BL_FUND A,
								 DN_REF_PORTFOLIO B
						  WHERE  A.DEAL_NO=M_DEAL_NO AND
								 B.PORTFOLIO_CODE=A.LEND_PORTFOLIO_CODE AND
								 B.PF_TYPE='P' AND
                                 A.EFF_VALDATE<=M_NEW_SYSDATE AND
                                 B.OWNED_BY_MBFSL='Y'
                         UNION
                          SELECT LEG1_VALUE AAA,A.TENOR BBB,A.DN_USER CCC,'0' DDD,'FO' EEE
						  FROM   DN_TRN_BL_FUND A,
								 DN_REF_PORTFOLIO B
						  WHERE  A.DEAL_NO=M_DEAL_NO AND
								 B.PORTFOLIO_CODE=A.LEND_PORTFOLIO_CODE AND
								 B.PF_TYPE='P' AND
                                 A.EFF_VALDATE>M_NEW_SYSDATE AND
                                 B.OWNED_BY_MBFSL='Y' ) RRR;


                        IF (M_COUNT_AMOUNT>0) THEN
                          M_CASH_DEAL_COUNT:=1;
                          SELECT RRR.AAA,RRR.BBB,RRR.CCC,RRR.DDD,RRR.EEE
                          INTO   M_DEAL_INFLOW,M_TENOR,M_DN_USER,M_DEAL_OUTFLOW,M_TRADE_TYPE
                          FROM
                          (SELECT LEG1_VALUE AAA,A.TENOR BBB,A.DN_USER CCC,'0' DDD,'SP' EEE
						  FROM   DN_TRN_BL_FUND A,
								 DN_REF_PORTFOLIO B
						  WHERE  A.DEAL_NO=M_DEAL_NO AND
								 B.PORTFOLIO_CODE=A.LEND_PORTFOLIO_CODE AND
								 B.PF_TYPE='P' AND
                                 A.EFF_VALDATE<=M_NEW_SYSDATE AND
                                 B.OWNED_BY_MBFSL='Y'
                         UNION
                          SELECT LEG1_VALUE AAA,A.TENOR BBB,A.DN_USER CCC,'0' DDD,'FO' EEE
						  FROM   DN_TRN_BL_FUND A,
								 DN_REF_PORTFOLIO B
						  WHERE  A.DEAL_NO=M_DEAL_NO AND
								 B.PORTFOLIO_CODE=A.LEND_PORTFOLIO_CODE AND
								 B.PF_TYPE='P' AND
                                 A.EFF_VALDATE>M_NEW_SYSDATE AND
                                 B.OWNED_BY_MBFSL='Y' ) RRR;
					 END IF;


END IF;
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------



    SELECT COUNT(*)
    INTO   M_COUNT
    FROM   LMT_UTL_DEALER_INST_AMT
    WHERE  DEALER_CODE=M_DEALER_CODE  AND
           TRADE_TYPE=M_TRADE_TYPE ;

		  IF (M_COUNT=0)THEN
		    M_CURRENT_UTILIZATION:=0 ;
		  ELSE
			SELECT   MAX(CURRENT_UTILIZATION)
		    INTO     M_CURRENT_UTILIZATION
			FROM     LMT_UTL_DEALER_INST_AMT
            WHERE    DEALER_CODE=M_DEALER_CODE  AND
                     TRADE_TYPE=M_TRADE_TYPE;
		  END IF;

IF (M_CASH_DEAL_COUNT=1) THEN
    IF (M_INS_UPS_STATUS='I') THEN
 --DBMS_OUTPUT.PUT_LINE('nirmala@@@@@@@@@'||'M_CURRENT_UTILIZATION'||M_CURRENT_UTILIZATION||'M_DEAL_INFLOW'||M_DEAL_INFLOW||'M_DEAL_OUTFLOW'||M_DEAL_OUTFLOW);
           UPDATE LMT_UTL_DEALER_INST_AMT
           SET    BF_UTILIZATION=M_CURRENT_UTILIZATION,
                  DEAL_INFLOW=M_DEAL_INFLOW,
                  DEAL_OUTFLOW=M_DEAL_OUTFLOW,
                  CURRENT_UTILIZATION=(M_CURRENT_UTILIZATION+M_DEAL_INFLOW-M_DEAL_OUTFLOW),
                  DN_USER=M_DN_USER
          WHERE   LIMIT_TYPE='08' AND
                  AUCTION_TYPE='S' AND
                  INST_TYPE='ALL' AND
                  DEALER_CODE=M_DEALER_CODE AND
                  TRADE_TYPE=M_TRADE_TYPE;

            IF SQL%NOTFOUND THEN
               INSERT INTO LMT_UTL_DEALER_INST_AMT
               (LIMIT_TYPE,
                AUCTION_TYPE,
                DEALER_CODE,
                INST_TYPE,
                BF_UTILIZATION,
                DEAL_INFLOW,
                DEAL_OUTFLOW,
                CURRENT_UTILIZATION,
                DN_USER,
                TRADE_TYPE)
              VALUES
               ('08',
                'S',
                M_DEALER_CODE,
                'ALL',
                M_CURRENT_UTILIZATION,
                M_DEAL_INFLOW,
                M_DEAL_OUTFLOW,
                (M_CURRENT_UTILIZATION+M_DEAL_INFLOW-M_DEAL_OUTFLOW),
                M_DN_USER,
                M_TRADE_TYPE);
           END IF;

   ELSIF (M_INS_UPS_STATUS='U') THEN

           UPDATE LMT_UTL_DEALER_INST_AMT
           SET    BF_UTILIZATION=M_CURRENT_UTILIZATION,
                  DEAL_INFLOW=M_DEAL_OUTFLOW,
                  DEAL_OUTFLOW=M_DEAL_INFLOW,
                  CURRENT_UTILIZATION=(M_CURRENT_UTILIZATION+M_DEAL_OUTFLOW-M_DEAL_INFLOW),
                  DN_USER=M_DN_USER
           WHERE  TRADE_TYPE=M_TRADE_TYPE  AND
                  INST_TYPE='ALL' AND
                  LIMIT_TYPE='08' AND
                  AUCTION_TYPE='S' AND
                  DEALER_CODE=M_DEALER_CODE;

           IF SQL%NOTFOUND THEN
              INSERT INTO LMT_UTL_DEALER_INST_AMT
              (LIMIT_TYPE,
               AUCTION_TYPE,
               DEALER_CODE,
               INST_TYPE,
               BF_UTILIZATION,
               DEAL_INFLOW,
               DEAL_OUTFLOW,
               CURRENT_UTILIZATION,
               DN_USER,
               TRADE_TYPE)
              VALUES
              ('08',
               'S',
               M_DEALER_CODE,
               'ALL',
               M_CURRENT_UTILIZATION,
               M_DEAL_OUTFLOW,
               M_DEAL_INFLOW,
               (M_CURRENT_UTILIZATION+M_DEAL_OUTFLOW-M_DEAL_INFLOW),
               M_DN_USER,
               M_TRADE_TYPE );
          END IF;
    END IF;--FOR M_INS_UPS_STATUS
 END IF;---FOR M_CASH_DEAL_COUNT

/*-------------------COMPARE AND IDENTIFY THE ACTUAL AND POSSIBLE VIOLATION------------------*/
      --------------------------------
      --------------------------------
      DN_LIMIT_COMP_DEALER_INST_AMT(1,M_DEALER_CODE,M_TRADE_TYPE);
      --------------------------------
      --------------------------------
/*--------------------------------------------------------------------------------------------*/

END DN_LIMIT_TRN_DEALER_INST_AMT;

/
