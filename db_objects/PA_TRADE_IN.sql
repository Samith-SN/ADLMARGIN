--------------------------------------------------------
--  DDL for Procedure PA_TRADE_IN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."PA_TRADE_IN" (
      M_REF_NO                IN OUT PA_BID_ALLO.REF_NO%TYPE,
      M_INST_TYPE                    PA_DENOMI_REFERENCE.INST_TYPE%TYPE,
      M_ISSUER_CODE                  PA_DENOMI_REFERENCE.ISSUER_CODE%TYPE,
      M_CLIENT_FACE_VALUE            PA_BID_ALLO.CLIENT_FACE_VALUE%TYPE,
      M_CLIENT_COST                  PA_BID_ALLO.CLIENT_COST%TYPE,
      M_CLIENT_ACC_INT               PA_BID_ALLO.CLIENT_ACC_INT%TYPE,
      M_CLIENT_SETTLE_VALUE          PA_BID_ALLO.CLIENT_SETTLE_VALUE%TYPE,
      M_ENTERED_BY                   VARCHAR2,
      M_SELECT_TYPE                  VARCHAR2)

AS
   CURSOR REF_DETAIL IS
     SELECT
          DENOMINATION
     FROM
          PA_DENOMI_REFERENCE
     WHERE
          INST_TYPE       =M_INST_TYPE AND
          ISSUER_CODE     =M_ISSUER_CODE AND
          ACTIVE_STATUS   = 'Y'
     ORDER BY DENOMINATION DESC ;

  M_DEAL_NUMBER             PA_BID_ALLO.REF_NO%TYPE;
  M_SDATE                   PA_BID_ALLO.ENTERED_DATE%TYPE;
  M_FVAL                    PA_BID_ALLO.CLIENT_FACE_VALUE%TYPE;
  M_CFVAL                   PA_BID_ENTRY.CLIENT_FACE_VALUE%TYPE;
  M_DSTAUS                  PA_BID_ENTRY.DENOMI_STATUS%TYPE;
  M_TOT                     PA_BID_ENTRY_DENOMI.FACE_VALUE%TYPE;
  M_DMOD                    PA_BID_ENTRY.DENOMI_MOD%TYPE;
  M_AUC                     DATE;
  MM_DENOMINATION           PA_BID_ENTRY_DENOMI.DENOMINATION%TYPE;
  M_NUM                     PA_BID_ENTRY_DENOMI.DENOMI_NUMBER%TYPE;
  M_SELECT_NAME             PA_BID_ALLO.REF_NO%TYPE;

 BEGIN


--RAISE_APPLICATION_ERROR(-20201,M_AUCTION_DATE ||' '||M_INST_TYPE||' '||M_ISSUER_CODE||' '||M_SECURITY_CODE||' '||M_PORTFOLIO_CODE||' '||M_BIDDER_CODE||' '||M_GUARANTED ***||' '||M_ADD_CITY||' '||M_ADD_COUNTRY||' ' ||M_POSTAL_CODE||' '||M_DATE_INC_BIRTH||' '||M_BUSI_REG_NIC||' '||M_CATEGORY_ENTITY||' '||M_NATURE_OCCUPATION ||' '||M_SECT_CODE ||' '||M_MBFSL_SECT_CODE||' '||M_NEST_REVIEW );*/


    /* PROCEDURE  - TO SAVE PRIMARY_AUCTION/TRADE ALLOCATION SCREEN
       SYSTEM     - DEALNET
       CREATED BY - LATHIKA
       CREATED ON - 10-11-1999 */

 SELECT
     SYSDATE
  INTO
     M_SDATE
  FROM
     DUAL;

--INSERT RECORDS INTO PA_BID_ALLO TABLE ---
IF M_REF_NO IS NOT NULL  AND M_SELECT_TYPE='MAIN' THEN
 M_SELECT_NAME:= 'MAIN3';

 UPDATE PA_BID_ALLO
       SET REF_NO                       =M_REF_NO,
           CLIENT_FACE_VALUE            =M_CLIENT_FACE_VALUE,
           CLIENT_COST                  =M_CLIENT_COST,
           CLIENT_ACC_INT               =M_CLIENT_ACC_INT,
           CLIENT_SETTLE_VALUE          =M_CLIENT_SETTLE_VALUE,
           ENTERED_BY                   =M_ENTERED_BY,
           ENTERED_DATE                 =M_SDATE
     WHERE REF_NO                       =M_REF_NO;

 IF SQL%NOTFOUND THEN
    INSERT INTO PA_BID_ALLO
        (REF_NO,
         CLIENT_FACE_VALUE,
         CLIENT_COST,
         CLIENT_ACC_INT,
         CLIENT_SETTLE_VALUE,
         ENTERED_BY,
         ENTERED_DATE)
           VALUES(
             M_REF_NO,
             M_CLIENT_FACE_VALUE,
             M_CLIENT_COST,
             M_CLIENT_ACC_INT,
             M_CLIENT_SETTLE_VALUE,
             M_ENTERED_BY,
             M_SDATE);
   END IF;

   IF M_REF_NO IS NOT NULL  AND M_SELECT_NAME='MAIN3' THEN

   SELECT
      CLIENT_FACE_VALUE,DENOMI_STATUS
   INTO
      M_CFVAL,M_DSTAUS
   FROM
      PA_BID_ENTRY
   WHERE REF_NO =M_REF_NO;

  IF  M_CLIENT_FACE_VALUE<>M_CFVAL THEN  ---[0]
      M_FVAL := M_CLIENT_FACE_VALUE;

    DELETE FROM PA_BID_ENTRY_DENOMI
        WHERE  REF_NO=M_REF_NO;

    OPEN REF_DETAIL;

        LOOP
           MM_DENOMINATION:=NULL;

           FETCH REF_DETAIL INTO MM_DENOMINATION;

           EXIT WHEN REF_DETAIL%NOTFOUND;

           IF M_FVAL >= MM_DENOMINATION  THEN     ---[1]
              M_NUM := FLOOR(M_FVAL/MM_DENOMINATION);
              M_TOT := MM_DENOMINATION * M_NUM;
              M_FVAL:= M_FVAL - M_TOT;

          INSERT INTO PA_BID_ENTRY_DENOMI
                 (REF_NO,
                  INST_TYPE,
                  ISSUER_CODE,
                  DENOMINATION,
                  DENOMI_NUMBER,
                  FACE_VALUE)
                   VALUES(
                     M_REF_NO,
                     M_INST_TYPE,
                     M_ISSUER_CODE,
                     MM_DENOMINATION,
                     M_NUM,
                     M_TOT);
          END IF;   ----//[1]
       END LOOP;

       IF  M_DSTAUS <> 'MIN' THEN  ----[2]
        M_DMOD:= 'Y';
        M_DSTAUS:='MIN';
       ELSE
        M_DMOD :=NULL;
       END IF;                     ----//[2]

    END IF;       ----- //[0]

    /*IF  M_DSTAUS <> 'MIN' THEN  ----[2]
        M_DMOD:= 'Y';
        M_DSTAUS:='MIN';
    ELSE
        M_DMOD :=NULL;
    END IF;                     ----//[2]
*/
    UPDATE PA_BID_ENTRY
       SET REF_NO                       =M_REF_NO,
           CLIENT_FACE_VALUE            =M_CLIENT_FACE_VALUE,
           CLIENT_COST                  =M_CLIENT_COST,
           CLIENT_ACC_INT               =M_CLIENT_ACC_INT,
           CLIENT_SETTLE_VALUE          =M_CLIENT_SETTLE_VALUE,
           ALLO_STATUS                  ='ALLO',
           DENOMI_STATUS                =M_DSTAUS,
           ENTERED_BY                   =M_ENTERED_BY,
           ENTERED_DATE                 =M_SDATE,
           DENOMI_MOD                   =M_DMOD
           WHERE
           REF_NO=M_REF_NO;

   END IF;
END IF;

/*IF M_REF_NO IS NOT NULL  AND M_SELECT_TYPE='MAIN2' AND M_CLIENT_FACE_VALUE<>0 THEN
 M_FVAL := M_CLIENT_FACE_VALUE;

DELETE FROM PA_BID_ENTRY_DENOMI
        WHERE  REF_NO=M_REF_NO;

 OPEN REF_DETAIL;

        LOOP
           MM_DENOMINATION:=NULL;

           FETCH REF_DETAIL INTO MM_DENOMINATION;

           EXIT WHEN REF_DETAIL%NOTFOUND;

           IF M_FVAL >= MM_DENOMINATION  THEN
              M_NUM := FLOOR(M_FVAL/MM_DENOMINATION);
              M_TOT := MM_DENOMINATION * M_NUM;
              M_FVAL:= M_FVAL - M_TOT;

--RAISE_APPLICATION_ERROR(-20201,M_NUM ||' '||M_TOT||' '||M_FVAL);
          INSERT INTO PA_BID_ENTRY_DENOMI
                 (REF_NO,
                  INST_TYPE,
                  ISSUER_CODE,
                  DENOMINATION,
                  DENOMI_NUMBER,
                  FACE_VALUE)
                   VALUES(
                     M_REF_NO,
                     M_INST_TYPE,
                     M_ISSUER_CODE,
                     MM_DENOMINATION,
                     M_NUM,
                     M_TOT);
         END IF;

      END LOOP;


END IF; */

  COMMIT;

END PA_TRADE_IN;

/
