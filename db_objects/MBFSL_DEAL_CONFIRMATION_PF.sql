--------------------------------------------------------
--  DDL for Procedure MBFSL_DEAL_CONFIRMATION_PF
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_DEAL_CONFIRMATION_PF" 
   (
   M_DEALNO           DN_TRN_REPO_FRESH.DEAL_NO%TYPE,
   M_USER            DN_TRN_REPO_FRESH.DN_USER%TYPE

   )
AS

M_TYPE            VARCHAR2(4);
M_COUNT           NUMBER;
M_SCRIPT_STATUS   CHAR(2);
M_INST_CAT        DN_REF_INSTRUMENT.INST_CAT%TYPE;
M_CURR_CODE          DN_TRN_REPO_FRESH.CURR_CODE%TYPE;--CURRENCY
NN_SCRIPT_STATUS     DN_TRN_OUTP_SALE.SCRIPT_STATUS%TYPE;--$$##SC
NN_PF_TYPE           DN_REF_PORTFOLIO.PF_TYPE%TYPE;--$$##SC
NN_YIELD_TYPE        DN_REF_INSTRUMENT.YIELD_TYPE%TYPE;--$$##SC
M_CLEAN   NUMBER;
M_DIRTY   NUMBER;
M_NOMINAL NUMBER;
M_TYPE1    VARCHAR2(10);
M_CUSTODIAL_STATUS      VARCHAR2(1);-----$$##SWIFT-- ADDED BY MANJULA ON 26-07-2004
/*********ADDED BY KEITH 2004-12-02 VCREF-04-266 FOR BACKDATED DEALS**********/
M_EFFVAL_DATE      DATE;
/*******************/
--ADDED BY SVA ON 04-04-2005 FOR WEIGHTED AVERAGE
M_LAST_DAILY       DATE;
M_EFF_VALDATE        DN_TRN_OUTP_SALE.EFF_VALDATE%TYPE;
NN_PORTFOLIO_CODE    DN_TRN_OUTP_SALE.BUY_PORTFOLIO_CODE%TYPE;
NN_SECURITY_CODE     DN_TRN_OUTP_SALE.SECURITY_CODE%TYPE;

-------- ADDED BY S.SHANHEETHA ON 11-10-2007 FOR VC07-009 -----------
M_MATURITY_DATE      DATE;
MM_MATURITY_DATE     DATE;
M_LAST_DAILY1        DATE;
--------------- END ON 11-10-2007 -----------------------------------

BEGIN

    /* PROCEDURE  -  DEAL CONFIRMATION
       SYSTEM     -  DEALNET
       CREATED BY -  DAYAN
       CREATED ON -  08/07/1999
       ADDED CODE FOR TIME LOG MANAGEMENT  BY -  S.YASODHA
       MODIFIED ON 02-08-2000*/
IF SUBSTR(M_DEALNO,1,2)='OR' THEN
  --RAISE_APPLICATION_error(-20001,'M_DEALNO'||M_DEALNO);
       SELECT INST_CAT
       INTO   M_INST_CAT
       FROM   DN_TRN_OUTP_SALE A,
              DN_REF_INSTRUMENT B
       WHERE  DEAL_NO=M_DEALNO AND A.INST_TYPE=B.INST_TYPE;

 IF M_INST_CAT = 'EQUITY' THEN
   DN_CHECK_OR_CONF_EQUITY(M_DEALNO,'1');--added on 16-03-2004 by SARANGA
 ELSE
   DN_CHECK_FIGURES_OR_CONF(M_DEALNO,'1');--added on 23-02-2004 by nirmala
 END IF;
 ---------------currency---------------------------------------
     SELECT CURR_CODE
       INTO   M_CURR_CODE
       FROM   DN_TRN_OUTP_SALE
       WHERE  DEAL_NO=M_DEALNO;
----------------------------------------------
  SELECT  COUNT(*)
  INTO    M_COUNT
  FROM    DN_TRN_OUTP_SALE
  WHERE   DEAL_NO=M_DEALNO AND
          APP_STATUS='CONF';

         IF  (M_COUNT=0)  THEN

         ------------FOR SCRIPLESS-------------------
           SELECT SCRIPT_STATUS,CUSTODIAL_STATUS   INTO   M_SCRIPT_STATUS,M_CUSTODIAL_STATUS  ----------$$##SWIFT  ---added by Manjula on 26-07-2004
           FROM   DN_TRN_OUTP_SALE
             WHERE  DEAL_NO=M_DEALNO AND APP_STATUS='PF-ENT'; ---  'APPRO2'; COMMENT BY WJ ON 23/07/2010
 
         SELECT A.SCRIPT_STATUS ,B.PF_TYPE,C.YIELD_TYPE,A.BUY_PORTFOLIO_CODE,A.SECURITY_CODE,EFF_VALDATE --ADDED BY SVA ON 04-04-2005 FOR WEIGHTED AVERAGE A.BUY_PORTFOLIO_CODE,A.SECURITY_CODE,EFF_VALDATE
         INTO   NN_SCRIPT_STATUS,NN_PF_TYPE,NN_YIELD_TYPE,NN_PORTFOLIO_CODE,NN_SECURITY_CODE,M_EFF_VALDATE --ADDED BY SVA ON 04-04-2005 FOR WEIGHTED AVERAGE NN_PORTFOLIO_CODE,NN_SECURITY_CODE,M_EFF_VALDATE
         FROM  DN_TRN_OUTP_SALE A,
		       DN_REF_PORTFOLIO B,
	           DN_REF_INSTRUMENT C
	     WHERE  A.DEAL_NO=M_DEALNO   AND
	           A.SELL_PORTFOLIO_CODE= B.PORTFOLIO_CODE AND
	           A.INST_TYPE=C.INST_TYPE;
     ----------------------------------------------



       INSERT INTO DN_TIME_LOG
           (SUS_REF_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            (
              M_DEALNO,
              M_USER,
              SYSDATE,
              'CONFIRMATION'
           );

       UPDATE DN_TRN_OUTP_SALE SET
           APP_STATUS='CONF'
       WHERE M_DEALNO=DEAL_NO;

       ------------------------------------------------------
       -- Added by Pubudu Thushara on 12/07/1999
        IF ((M_SCRIPT_STATUS='SC') OR (NN_SCRIPT_STATUS='SL' AND NN_PF_TYPE='P' /*AND NN_YIELD_TYPE='S'*/)  ) THEN --COMMENTED BY SVA ON 18-04-2005 FOR INVENTORY ALLOCATION PROBLEM  --$$##SC
           -- Updating outright inventory sub system
          DN_INV_OUTPS_UPDATE_SUB_SYSTEM(M_DEALNO);

          --- Updating outright inventory suspense
        /*--remove by waruna 2010-12-22
          IF (M_SCRIPT_STATUS='SC') THEN -- ADDED THIS CONDISION FOR INVENTORY ALLOCATION PROBLEM
              DN_INV_OUTPS_SUSPENSE(M_DEALNO);
          END IF;
          */
   /*----------------------CURRENCY------------------------
     IF (M_CURR_CODE<>'SLR')THEN
         -- Updating outright inventory suspense
          DN_INV_OUTPS_SUSPENSE_CURR(M_DEALNO);
      ELSE
         -- Updating outright inventory suspense
          DN_INV_OUTPS_SUSPENSE(M_DEALNO);
      END IF;
   ----------------------CURRENCY------------------------*/
       ELSE ----------SCRIPLESS

        -----ADDED BY YASODHA   ON 30-03-2004
          SELECT INST_CAT INTO M_TYPE1 FROM DN_REF_INSTRUMENT
          WHERE INST_TYPE  = (SELECT INST_TYPE FROM DN_TRN_OUTP_SALE
          WHERE DEAL_NO=M_DEALNO);

          SELECT PRICE_CLEAN,PRICE_DIRTY,NOMINAL_VALUE INTO
          M_CLEAN ,M_DIRTY,M_NOMINAL FROM
          DN_TRN_OUTP_SALE    WHERE DEAL_NO=M_DEALNO;

          -- RAISE_APPLICATION_ERROR(-20201,M_TYPE1||''||M_CLEAN||''||M_DIRTY||''||M_NOMINAL);

          IF M_TYPE1 = 'EQUITY' AND  M_CLEAN =0 AND M_DIRTY =0 AND M_NOMINAL=0 THEN

             DN_INV_OUTPS_SCRIPLESS(M_DEALNO,M_USER);
             --NOT DONE THE vc04-244 BUT REMARKED ON 05/10/2004
             --DN_INV_OUTPS_SCRIPLESS_EQUITY(M_DEALNO,M_USER);
          ELSE

             DN_INV_OUTPS_SCRIPLESS(M_DEALNO,M_USER);
          END IF;
         -----ADDED BY YASODHA


       END IF;-------SCRIPLESS
      -- BROCKERAGE_INVOICING_IN(M_DEALNO);--remove by waruna 2010-12-22
      -- Updating outright settlement suspence
       --DN_SETTL_OUTPS_SUSPENSE(M_DEALNO);-- commented on 29-08-2005 BY SVA/SM only for FCLMGT

       -- Updating outright accounting system after confiremation
       --DN_ACC_LINK_OUTPS_CONF(M_DEALNO);--remove by waruna 2010-12-22
    ----------------------CURRENCY------------------------
       IF (M_SCRIPT_STATUS='SL'AND M_CUSTODIAL_STATUS='Y' ) THEN --$$##SC --Custodial Status -- Added By MANJULA ON 26-07-2004
--       NULL;
        DN_SL_AUTO_CUSTODIAL(M_DEALNO,M_USER); --TEMP COMMENTED 16/12/2003
       END IF;
       ---------------------------------------
     ----------------------CURRENCY------------------------
      /* IF (M_CURR_CODE<>'SLR')THEN
       DN_EXCHG_GAINLOSS_OUTRIGHT(M_DEALNO,M_CURR_CODE);
      END IF;*/
      ----------------------CURRENCY------------------------

      --ADDED BY SVA ON 04-04-2005 FOR WEIGHTED AVERAGE
      IF NN_YIELD_TYPE='W' THEN
        SELECT LAST_DAILY INTO M_LAST_DAILY FROM DN_SYS_PARAMETER;
        IF M_EFF_VALDATE<M_LAST_DAILY THEN
        DN_INV_OUTPS_INTEREST_WEIGHT(M_LAST_DAILY,NN_PORTFOLIO_CODE,NN_SECURITY_CODE);
        END IF;
        DN_WEIGHTED_AVERAGE(M_LAST_DAILY,NN_PORTFOLIO_CODE,NN_SECURITY_CODE);
        DN_INV_OUTPS_INTEREST_WEIGHT(M_LAST_DAILY,NN_PORTFOLIO_CODE,NN_SECURITY_CODE);
      END IF;
      --END OF 04-04-2005

       ELSE
          RAISE_APPLICATION_ERROR(-20201,'ALREADY CONFIRMED');
       END IF;

ELSIF SUBSTR(M_DEALNO,1,2)='BF' THEN
  SELECT  COUNT(*)
  INTO    M_COUNT
  FROM    DN_TRN_BL_FUND
  WHERE   DEAL_NO=M_DEALNO AND
          APP_STATUS='CONF';

       IF  M_COUNT=0  THEN

          INSERT INTO DN_TIME_LOG
           (SUS_REF_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            (
              M_DEALNO,
              M_USER,
              SYSDATE,
              'CONFIRMATION'
           );
       UPDATE DN_TRN_BL_FUND SET
          APP_STATUS='CONF'
       WHERE M_DEALNO=DEAL_NO;

       ------------------------------------------------------
       -- Added by Pubudu Thushara on 19/08/1999

       -- Updating (BL) inventory sub system
       DN_INV_BL_RF_UP_SUB_SYSTEM(M_DEALNO); --OK

       -- Updating (BL) inventory suspense
       --DN_INV_BL_RF_SUSPENSE(M_DEALNO);  --OK--remove by waruna 2010-12-22

       -- Updating (BL) settlement suspence
     -- DN_SETTL_BL_RF_SUSPENSE(M_DEALNO); --OK--remove by waruna 2010-12-22

      -- Updating (BL) accounting system after confiremation
    --  DN_ACC_LINK_BL_RF_CONF(M_DEALNO); --OK--remove by waruna 2010-12-22
      ------------------------------------------------------

      ------------------------------------------------------
      -- Added by Pubudu Thushara on 19/08/1999

      -- Updating (BL) inventory suspense for borrower
      DN_INV_BL_RS_SUSPENSE_BORR(M_DEALNO);  --OK

      -- Updating (BL) inventory suspense for Lender
      DN_INV_BL_RS_SUSPENSE_LEND(M_DEALNO);  --OK

      -- Updating (BL) settlement suspence
      DN_SETTL_BL_RS_SUSPENSE(M_DEALNO);   --OK
 BROCKERAGE_INVOICING_IN(M_DEALNO);
      -------------------------------------------------------
      ELSE
        RAISE_APPLICATION_ERROR(-20201,'ALREADY CONFIRMED');
      END IF;
 
ELSIF SUBSTR(M_DEALNO,1,2)='BS' THEN
  SELECT  COUNT(*)
  INTO    M_COUNT
  FROM    DN_TRN_BL_SECURITY
  WHERE   DEAL_NO=M_DEALNO AND
          APP_STATUS='CONF';

     IF  M_COUNT=0  THEN


       INSERT INTO DN_TIME_LOG
           (SUS_REF_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            (
              M_DEALNO,
              M_USER,
              SYSDATE,
              'CONFIRMATION'
           );

      UPDATE DN_TRN_BL_SECURITY SET
          APP_STATUS='CONF'
      WHERE M_DEALNO=DEAL_NO;

      ------------------------------------------------------
      -- Added by Pubudu Thushara on 24/08/1999

      -- Updating (BL) inventory sub system
      DN_INV_BL_SEC_UP_SUB_SYSTEM(M_DEALNO);  --OK

      -- Updating (BL) inventory suspense
     -- DN_INV_BL_SEC_SUSPENSE(M_DEALNO);  --OK--remove by waruna 2010-12-22

      -- Updating (BL) settlement suspence
      --DN_SETTL_BL_SEC_RF_SUSPENSE(M_DEALNO); --OK--remove by waruna 2010-12-22
     ---  BROCKERAGE_INVOICING_IN(M_DEALNO);--remove by waruna 2010-12-22
      -- Updating (BL) accounting system after confiremation
      --DN_ACC_LINK_BL_SEC_RF_CONF(M_DEALNO);--remove by waruna 2010-12-22
      ------------------------------------------------------
      ELSE
        RAISE_APPLICATION_ERROR(-20201,'ALREADY CONFIRMED');
      END IF;




ELSIF SUBSTR(M_DEALNO,1,2)='RF' THEN

 DN_CHECK_FIGURES_RF_CONF(M_DEALNO,'1');--added on 23-02-2004 by nirmala
 DN_CHECK_SERIAL_ALLO_STATUS(M_DEALNO);--ADD BY INDITHA 2005-7-25 VC05-012

  SELECT  COUNT(*)
  INTO    M_COUNT
  FROM    DN_TRN_REPO_FRESH
  WHERE   DEAL_NO=M_DEALNO AND
          APP_STATUS='CONF';

       IF  M_COUNT=0  THEN
--RAISE_APPLICATION_ERROR(-20201,'ALREADY CONFIRMED2'||M_DEALNO);
      ------------FOR SCRIPLESS-------------------
             SELECT A.SCRIPT_STATUS,B.PF_TYPE--$$##SC
             INTO   M_SCRIPT_STATUS,NN_PF_TYPE
             FROM   DN_TRN_REPO_FRESH A,
		            DN_REF_PORTFOLIO B
             WHERE  A.DEAL_NO=M_DEALNO AND
                    A.APP_STATUS='PF-ENT' AND  ---  'APPRO2'; COMMENT BY WJ ON 23/07/2010
                    A.LEND_PORTFOLIO_CODE= B.PORTFOLIO_CODE ;
       ----------------------------------------------



       INSERT INTO DN_TIME_LOG
           (SUS_REF_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            (
              M_DEALNO,
              M_USER,
              SYSDATE,
              'CONFIRMATION'
           );

       UPDATE DN_TRN_REPO_FRESH SET
            APP_STATUS='CONF'
       WHERE M_DEALNO=DEAL_NO;

       ------------------------------------------------------
       -- Added by Pubudu Thushara on 28/07/1999

       -- Updating Repo Fresh inventory sub system
    DN_INV_REPO_RF_UP_SUB_SYSTEM(M_DEALNO);

          -- Updating Repo Fresh inventory suspense
   --  DN_INV_REPO_RF_SUSPENSE(M_DEALNO); --remove by waruna 2010-12-22

       -- Updating Repo fresh settlement suspence
      --DN_SETTL_REPO_RF_SUSPENSE(M_DEALNO);--commente on 29-08-2005 by sva/sm only for FCLMGT
 --BROCKERAGE_INVOICING_IN(M_DEALNO);--remove by waruna 2010-12-22
       -- Updating Repo fresh accounting system after confiremation
    -- DN_ACC_LINK_REPO_RF_CONF(M_DEALNO);--remove by waruna 2010-12-22 

          ----------SCRIPTLESS----------------------
               IF (M_SCRIPT_STATUS='SL' AND  NN_PF_TYPE='P') THEN --$$##SC
                 --DN_REPO_FRESH_SCRIPLESS(RTRIM(LTRIM(M_DEALNO)),M_USER);
                      DN_REPO_LEND_SCRIPLESS(RTRIM(LTRIM(M_DEALNO)));
                    --DN_REPO_LEND_SCRIPLESS(RTRIM(LTRIM(M_DEALNO)));

             END IF;

/*********ADDED BY KEITH 2004-12-02 VCREF-04-266  FOR BACKDATED DEALS**********/
            SELECT EFF_VALDATE
            INTO   M_EFFVAL_DATE
            FROM   DN_TRN_REPO_FRESH
            WHERE  DEAL_NO=M_DEALNO;

            SELECT LAST_DAILY
            INTO   M_LAST_DAILY
            FROM   DN_SYS_PARAMETER;
            
            --------------------------------ADDED BY S.SHANHEETHA ON 11-10-2007 FOR VC07-009----------------
            SELECT  TO_DATE(TO_CHAR(MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')-1
            INTO   M_MATURITY_DATE
            FROM   DN_TRN_REPO_FRESH 
            WHERE  DEAL_NO=M_DEALNO;
            
            SELECT TO_DATE(TO_CHAR(LAST_DAILY,'DD-MM-YYYY'),'DD-MM-YYYY')
            INTO   M_LAST_DAILY1
            FROM   DN_SYS_PARAMETER;
            -----------------------END MODIFICATION DONE BY  S.SHANHEETHA ON 11-10-2007 FOR VC07-009---------

           ------------ COMMENTED BY S.SHANHEETHA ON 16-10-2007 FOR VC07-009 --------------------------
          /*  IF M_EFFVAL_DATE<M_LAST_DAILY THEN
                --DN_INVREPODEAL_INTACCR_CONF(M_DEALNO);commented by keith on 09-12-2004
                NULL;
            END IF; */
            
           ---- ADDED BY S.SHANHEETHA ON 11-10-2007 FOR VC07-009------------
          --  IF ((M_MATURITY_DATE) <= M_LAST_DAILY1) THEN  --remove by waruna 2010-12-22
                   -- RAISE_APPLICATION_ERROR(-20201,'CONDITION SATISFIED');

               -- DN_INV_REPO_DEAL_INT_ACCR_BD(M_MATURITY_DATE,M_DEALNO);--CALL TO INT. CALCU. PROCEDURE--remove by waruna 2010-12-22
               -- DN_ACC_LINK_REPO_DAYEND_DEAL(M_MATURITY_DATE,M_DEALNO);--Link outright transactions to the accounting after the dayend routine--remove by waruna 2010-12-22
            --END IF;--remove by waruna 2010-12-22
            -----------------------END MODIFICATION DONE BY S.SHANHEETHA ON 11-10-2007 FOR VC07-009---------    
            
/*******************************************************/
         ELSE
          RAISE_APPLICATION_ERROR(-20201,'ALREADY CONFIRMED');
       END IF;

ELSIF SUBSTR(M_DEALNO,1,2)='PI' THEN



     INSERT INTO DN_TIME_LOG
           (SUS_REF_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            (
              M_DEALNO,
              M_USER,
              SYSDATE,
              'CONFIRMATION'
           );
       UPDATE DN_TRN_REPO_PERIOD_INT SET
           APP_STATUS='CONF'
       WHERE M_DEALNO=DEAL_NO;


   ------------------------------------------------------
       -- Added by LATHIKA on 29/09/2000

       -- Updating PI inventory sub system
       DN_INV_REPO_PI_UP_SUB_SYSTEM(M_DEALNO);

       -- Updating PI inventory suspense
     --- DN_INV_REPO_PI_SUSPENSE(M_DEALNO);--remove by waruna 2010-12-22

       -- Updating PI settlement suspence
 --     DN_SETTL_REPO_PI_SUSPENSE(M_DEALNO);--remove by waruna 2010-12-22
 --BROCKERAGE_INVOICING_IN(M_DEALNO);--remove by waruna 2010-12-22
       -- Updating PI accounting system after confiremation
      --DN_ACC_LINK_REPO_PI_CONF(M_DEALNO);--remove by waruna 2010-12-22
       ------------------------------------------------------


ELSIF SUBSTR(M_DEALNO,1,2)='RR' THEN
 DN_CHECK_FIGURES_RR_CONF(M_DEALNO,'1');--added on 23-02-2004 by nirmala
 DN_CHECK_SERIAL_ALLO_STATUS(M_DEALNO);--ADD BY INDITHA 2005-7-25 VC05-012

 SELECT  COUNT(*)
  INTO    M_COUNT
  FROM    DN_TRN_REPO_ROLLOVER
  WHERE   DEAL_NO=M_DEALNO AND
          APP_STATUS='CONF';

       IF  M_COUNT=0  THEN
    ------------FOR SCRIPLESS-------------------
             SELECT SCRIPT_STATUS
             INTO   M_SCRIPT_STATUS
             FROM   DN_TRN_REPO_ROLLOVER
             WHERE  DEAL_NO=M_DEALNO AND APP_STATUS='PF-ENT'; --APPRO2 -- WJ 
        ----------------------------------------------

       INSERT INTO DN_TIME_LOG
           (SUS_REF_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            (
              M_DEALNO,
              M_USER,
              SYSDATE,
              'CONFIRMATION'
           );

       UPDATE DN_TRN_REPO_ROLLOVER SET
            APP_STATUS='CONF'
       WHERE M_DEALNO=DEAL_NO;

       ------------------------------------------------------
       -- Added by Pubudu Thushara on 03/08/1999

       -- Updating Repo rollover inventory sub system
       DN_INV_REPO_RR_UP_SUB_SYSTEM(M_DEALNO);

       -- Updating repo rollover inventory suspense for borrower
       DN_INV_REPO_RR_SUSPENSE_BORR(M_DEALNO);

       -- Updating repo rollover inventory suspense for Lender
       DN_INV_REPO_RR_SUSPENSE_LEND(M_DEALNO);
 BROCKERAGE_INVOICING_IN(M_DEALNO);
       -- Updating repo rollover settlement suspence

      ------------------------------------------------------
     ----------------------CURRENCY------------------------
     ------------------------------------------------------
      SELECT CURR_CODE
      INTO   M_CURR_CODE
      FROM   DN_TRN_REPO_ROLLOVER
      WHERE  DEAL_NO=M_DEALNO;
     --COMMENTED ON 29-08-2005 BY SVA /SM ONLY FOR FCLMGT
     /*
      IF (M_CURR_CODE<>'SLR')THEN
       DN_SETTL_REPO_RR_SUSPENSE_CURR(M_DEALNO);
      ELSE
       DN_SETTL_REPO_RR_SUSPENSE(M_DEALNO);
      END IF;
     */
     --END OF COMMENT
       -- Updating Repo rollover accounting system after confiremation
       -- DN_ACC_LINK_REPO_RR_CONF(M_DEALNO);----remove by waruna 2010-12-22

          ----------SCRIPTLESS----------------------
               IF M_SCRIPT_STATUS='SL' THEN
                 DN_REPO_ROLLOVER_SCRIPLESS(RTRIM(LTRIM(M_DEALNO)),M_USER);
                 --DN_REPO_LEND_SCRIPLESS(RTRIM(LTRIM(M_DEALNO)));

               END IF;

     ----------CURRENCY--------------------------------------
      IF (M_CURR_CODE<>'SLR')THEN
       DN_EXCHG_GAINLOSS_ROLLOVER(M_DEALNO,M_CURR_CODE);
      END IF;

     ----------------------CURRENCY------------------------
    /*********ADDED BY KEITH 2004-12-02 VCREF-04-266 FOR BACKDATED DEALS**********/
            SELECT EFF_VALDATE
            INTO   M_EFFVAL_DATE
            FROM   DN_TRN_REPO_ROLLOVER
            WHERE  DEAL_NO=M_DEALNO;

            SELECT LAST_DAILY
            INTO   M_LAST_DAILY
            FROM   DN_SYS_PARAMETER;
            
            --------------------------------ADDED BY SHANHEETHA ON 11-10-2007 FOR VC07-099----------------
            SELECT TO_DATE(TO_CHAR(MATURITY_DATE,'DD-MM-YYYY'),'DD-MM-YYYY')-1  
            INTO   M_MATURITY_DATE
            FROM   DN_TRN_REPO_ROLLOVER 
            WHERE  DEAL_NO=M_DEALNO;
            
            SELECT TO_DATE(TO_CHAR(LAST_DAILY,'DD-MM-YYYY'),'DD-MM-YYYY')
            INTO   M_LAST_DAILY1
            FROM   DN_SYS_PARAMETER;
            -----------------------END MODIFICATION DONE BY SHANHEETHA ON 11-10-2007 FOR VC07-099--    

           ------------ COMMENTED BY S.SHNAHEETHA ON 16-10-2007 FOR VC07-009 -----------
          /*  IF M_EFFVAL_DATE<M_LAST_DAILY THEN
                --DN_INVREPODEAL_INTACCR_CONF(M_DEALNO);commented by keith on 09-12-2004
                NULL;
            END IF; */
            
          --ADDED BY SHANHEETHA ON 11-10-2007 FOR VC07-009 --------
            --IF ((M_MATURITY_DATE) <= M_LAST_DAILY1) THEN  --remove by waruna 2010-12-22
                   -- RAISE_APPLICATION_ERROR(-20201,'CONDITION SATISFIED');

             --   DN_INV_REPO_DEAL_INT_ACCR_BD(M_MATURITY_DATE,M_DEALNO);--CALL TO INT. CALCU. PROCEDURE--remove by waruna 2010-12-22
              --  DN_ACC_LINK_REPO_DAYEND_DEAL(M_MATURITY_DATE,M_DEALNO);--Link outright transactions to the accounting after the dayend routine--remove by waruna 2010-12-22
           -- END IF;--remove by waruna 2010-12-22
           -----------------------END MODIFICATION DONE BY SHANHEETHA ON 11-10-2007 FOR VC07-009---------    
            
    /*******************************************************/

      ELSE
         RAISE_APPLICATION_ERROR(-20201,'ALREADY CONFIRMED');
       END IF;
       ------------------------------------------------------

ELSIF SUBSTR(M_DEALNO,1,2)='RS' THEN
 DN_CHECK_FIGURES_RS_CONF(M_DEALNO,'1');--added on 23-02-2004 by nirmala

  SELECT  COUNT(*)
  INTO    M_COUNT
  FROM    DN_TRN_REPO_SETTLEMENT
  WHERE   DEAL_NO=M_DEALNO AND
          APP_STATUS='CONF';

       IF  M_COUNT=0  THEN


       INSERT INTO DN_TIME_LOG
           (SUS_REF_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            (
              M_DEALNO,
              M_USER,
              SYSDATE,
              'CONFIRMATION'
           );

      UPDATE DN_TRN_REPO_SETTLEMENT SET
           APP_STATUS='CONF'
      WHERE M_DEALNO=DEAL_NO;

      ------------------------------------------------------
      -- Added by Pubudu Thushara on 06/08/1999

      -- Updating repo settlement inventory suspense for borrower
      DN_INV_REPO_RS_SUSPENSE_BORR(M_DEALNO);

      -- Updating repo settlement inventory suspense for Lender
      DN_INV_REPO_RS_SUSPENSE_LEND(M_DEALNO);
 BROCKERAGE_INVOICING_IN(M_DEALNO);
     ------------------------------------------------------
     ----------------------CURRENCY------------------------
     ------------------------------------------------------
      SELECT CURR_CODE
      INTO   M_CURR_CODE
      FROM   DN_TRN_REPO_SETTLEMENT
      WHERE  DEAL_NO=M_DEALNO;
      --COMMENTED ON 29-08-2005 BY SVA/SM ONLY FOR FCLMGT
      /*
      IF (M_CURR_CODE<>'SLR')THEN
          -- Updating repo settlement settlement suspence
          DN_SETTL_REPO_RS_SUSPENSE_CURR(M_DEALNO);--CURRENCY
       ELSE
           -- Updating repo settlement settlement suspence
           DN_SETTL_REPO_RS_SUSPENSE(M_DEALNO);
       END IF;
       */
       -- END OF COMMENT
     ------------------------------------------------------
     ----------------------CURRENCY------------------------
     ------------------------------------------------------


      -- Updating allo-repo
      DN_UPDATE_ALLO_REPO(M_DEALNO);--************************8
      -------------------------------------------------------
      IF (M_CURR_CODE<>'SLR')THEN
        DN_EXCHG_GAINLOSS_SETTLE(M_DEALNO,M_CURR_CODE);--CURRENCY
      END IF;
     ------------------------------------------------------------




      ELSE
        RAISE_APPLICATION_ERROR(-20201,'ALREADY CONFIRMED');
      END IF;
ELSIF SUBSTR(M_DEALNO,1,2)='SO' THEN

     INSERT INTO DN_TIME_LOG
           (SUS_REF_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            (
              M_DEALNO,
              M_USER,
              SYSDATE,
              'CONFIRMATION'
           );

   UPDATE DN_TRN_SWAP_OUTRIGHT SET
          APP_STATUS='CONF'
   WHERE M_DEALNO=DEAL_NO;

ELSIF SUBSTR(M_DEALNO,1,2)='SR' THEN

     INSERT INTO DN_TIME_LOG
           (SUS_REF_NO,
           DN_USER,
           ENT_DATE,
           DESCRIPTION)
           VALUES
            (
              M_DEALNO,
              M_USER,
              SYSDATE,
              'CONFIRMATION'
           );

   UPDATE DN_TRN_SWAP_RETURNABLE SET
          APP_STATUS='CONF'
   WHERE M_DEALNO=DEAL_NO;

END IF;
---Modified on 29-02-2000 by Lathika---------
--Update DN_TRN_BROKERAGE---to----APP_STATUS='CONF'---------

   UPDATE DN_TRN_BROKERAGE SET
          APP_STATUS='CONF'
   WHERE M_DEALNO=DEAL_NO;
DN_DEAL_CONFIRMATION_CHECKS(M_DEALNO);
COMMIT;

END MBFSL_DEAL_CONFIRMATION_PF;

/
