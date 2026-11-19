--------------------------------------------------------
--  DDL for Procedure DN_PORTFOLIOS_IN1
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_PORTFOLIOS_IN1" 

   (    M_PORTFOLIO_CODE    IN OUT  DN_REF_PORTFOLIO.PORTFOLIO_CODE%TYPE,
        M_OWNED_BY_MBFSL            DN_REF_PORTFOLIO.OWNED_BY_MBFSL%TYPE,
        M_CP_PORTFOLIO_CODE         DN_REF_PORTFOLIO.CP_PORTFOLIO_CODE%TYPE,
        M_PF_NAME                   DN_REF_PORTFOLIO.PF_NAME%TYPE,
        M_ADD_IDENTIFICATION        DN_REF_PORTFOLIO.ADD_IDENTIFICATION%TYPE,
        M_ADD_LOCATION              DN_REF_PORTFOLIO.ADD_LOCATION%TYPE,
        M_ADD_STREET                DN_REF_PORTFOLIO.ADD_STREET%TYPE,
        M_ADD_CITY                  DN_REF_PORTFOLIO.ADD_CITY%TYPE,
        M_ADD_COUNTRY               DN_REF_PORTFOLIO.ADD_COUNTRY%TYPE,
        M_POSTAL_CODE               DN_REF_PORTFOLIO.POSTAL_CODE%TYPE,
        M_DATE_INC_BIRTH            VARCHAR2,
        M_BUSI_REG_NIC              DN_REF_PORTFOLIO.BUSI_REG_NIC%TYPE,
        M_CATEGORY_ENTITY           DN_REF_PORTFOLIO.CATEGORY_ENTITY%TYPE,
        M_NATURE_OCCUPATION         DN_REF_PORTFOLIO.NATURE_OCCUPATION%TYPE,
        M_MBFSL_SECT_CODE           DN_REF_PORTFOLIO.MBFSL_SECT_CODE%TYPE,
        M_SECT_CODE                 DN_REF_PORTFOLIO.SECT_CODE%TYPE,
        M_NEST_REVIEW               VARCHAR2,
        M_DIRECTOR_NAME             DN_REF_PORTF_DIRECTOR.DIRECTOR_NAME%TYPE,
        M_SELECT_TYPE               CHAR,
        M_AUTHO_NAME                DN_REF_PORTF_AUTHO_SIGN.AUTHO_NAME%TYPE,
        M_CONT_PERSON_              DN_REF_PORTF_CONT_PERSON.CONT_PERSON_%TYPE,
        M_TEL_NO                    DN_REF_PORTF_CONT_TELNO.TEL_NO%TYPE,
        M_FAX_NO                    DN_REF_PORTF_CONT_FAXNO.FAX_NO%TYPE,
        M_EMAIL                     DN_REF_PORTF_CONT_EMAIL.EMAIL%TYPE,
        M_BRANCH_CODE               DN_REF_PORTF_SETTLEMENT.BRANCH_CODE%TYPE,
        M_ACC_NO                    DN_REF_PORTF_SETTLEMENT.ACC_NO%TYPE,
        M_MANAGEMENT_FEE            DN_REF_PORTFOLIO.MANAGEMENT_FEE%TYPE,
        M_PROFIT_SHARING            DN_REF_PORTFOLIO.PROFIT_SHARING%TYPE,
        M_BASE_RATE                 DN_REF_PORTFOLIO.BASE_RATE%TYPE
   )

AS
   M_TOT_EXP_LIMIT       DN_REF_PORTFOLIO.TOT_EXP_LIMIT%TYPE;
   M_PERC_TOT_EXP        DN_REF_PORTFOLIO.PERC_TOT_EXP%TYPE;
   M_CPCODE              DN_REF_PORTFOLIO.CP_PORTFOLIO_CODE%TYPE;

   M_VAL                 DN_REF_PORTF_AUTHO_SIGN.SEQ_NO%TYPE;
   M_NUM                 DN_REF_PORTF_AUTHO_SIGN.SEQ_NO%TYPE;

   M_VALC               DN_REF_PORTF_CONT_PERSON.SEQ_NO%TYPE;
   M_NUMC                DN_REF_PORTF_CONT_PERSON.SEQ_NO%TYPE;

   M_VALT                DN_REF_PORTF_CONT_TELNO.SEQ_NO%TYPE;
   M_NUMT                DN_REF_PORTF_CONT_TELNO.SEQ_NO%TYPE;

   M_VALF                DN_REF_PORTF_CONT_FAXNO.SEQ_NO%TYPE;
   M_NUMF                DN_REF_PORTF_CONT_FAXNO.SEQ_NO%TYPE;

   M_VALE               DN_REF_PORTF_CONT_EMAIL.SEQ_NO%TYPE;
   M_NUME              DN_REF_PORTF_CONT_EMAIL.SEQ_NO%TYPE;
BEGIN
/*RAISE_APPLICATION_ERROR(-20201,M_PORTFOLIO_CODE ||' '||M_OWNED_BY_MBFSL||' '||M_CP_PORTFOLIO_CODE||' '||M_PF_NAME||' '||M_ADD_IDENTIFICATION||' '||M_ADD_LOCATION||' '||M_ADD_STREET||' '||M_ADD_CITY||' '||M_ADD_COUNTRY||' ' ||M_POSTAL_CODE||' '||M_DATE_INC_BIRTH||' '||M_BUSI_REG_NIC||' '||M_CATEGORY_ENTITY||' '||M_NATURE_OCCUPATION ||' '||M_SECT_CODE ||' '||M_MBFSL_SECT_CODE||' '||M_NEST_REVIEW );*/


    /* PROCEDURE  - TO SAVE PORTFOLIOS
       SYSTEM     -  DEALNET
       CREATED BY -
       CREATED ON -  */
 M_VAL:=0;
 M_VALC:=0;M_VALT:=0;M_VALF:=0;M_VALE:=0;
 IF M_CP_PORTFOLIO_CODE  IS NULL THEN
    M_CPCODE:=NULL;
ELSE
   M_CPCODE:=M_CP_PORTFOLIO_CODE;
END IF;

IF M_PORTFOLIO_CODE IS NOT NULL  AND M_SELECT_TYPE='MAIN1' THEN

 UPDATE DN_REF_PORTFOLIO
       SET OWNED_BY_MBFSL        =M_OWNED_BY_MBFSL,
           PF_NAME               =M_PF_NAME,
           CP_PORTFOLIO_CODE     =M_CPCODE,
           ADD_IDENTIFICATION    =M_ADD_IDENTIFICATION,
           ADD_LOCATION          =M_ADD_LOCATION,
           ADD_STREET            =M_ADD_STREET,
           ADD_CITY              =M_ADD_CITY,
           ADD_COUNTRY           =M_ADD_COUNTRY,
           POSTAL_CODE           =M_POSTAL_CODE,
           DATE_INC_BIRTH        =TO_DATE(M_DATE_INC_BIRTH,'DD/MM/YYYY'),
           BUSI_REG_NIC          =M_BUSI_REG_NIC,
           CATEGORY_ENTITY       =M_CATEGORY_ENTITY,
           NATURE_OCCUPATION     =M_NATURE_OCCUPATION,
           MBFSL_SECT_CODE       =M_MBFSL_SECT_CODE,
           SECT_CODE             =M_SECT_CODE,
           NEST_REVIEW           =TO_DATE(M_NEST_REVIEW,'DD/MM/YYYY'),
           ACTIVE_STATUS         ='Y',
           MANAGEMENT_FEE        =NVL(M_MANAGEMENT_FEE,0),
           PROFIT_SHARING        =NVL(M_PROFIT_SHARING,0),
           BASE_RATE             =NVL(M_BASE_RATE,0)
        WHERE
           UPPER(PORTFOLIO_CODE)=UPPER(M_PORTFOLIO_CODE);

      IF SQL%NOTFOUND THEN
/*RAISE_APPLICATION_ERROR(-20201,M_PORTFOLIO_CODE ||' '||M_OWNED_BY_MBFSL||' '||M_CP_PORTFOLIO_CODE||' '||M_PF_NAME||' '||M_ADD_IDENTIFICATION||' '||M_ADD_LOCATION||' '||M_ADD_STREET||' '||M_ADD_CITY||' '||M_ADD_COUNTRY||' ' ||M_POSTAL_CODE||' '||TO_DATE(M_DATE_INC_BIRTH,'DD/MM/YYYY')||' '||M_BUSI_REG_NIC||' '||M_CATEGORY_ENTITY||' '||M_NATURE_OCCUPATION ||' '||M_SECT_CODE ||' '||M_MBFSL_SECT_CODE||' '||TO_DATE(M_NEST_REVIEW,'DD/MM/YYYY')||' '||0||' '||0);*/

     INSERT INTO DN_REF_PORTFOLIO
        (PORTFOLIO_CODE,
         OWNED_BY_MBFSL,
         CP_PORTFOLIO_CODE,
         PF_NAME,
         ADD_IDENTIFICATION,
         ADD_LOCATION,
         ADD_STREET,
         ADD_CITY,
         ADD_COUNTRY,
         POSTAL_CODE,
         DATE_INC_BIRTH,
         BUSI_REG_NIC,
         CATEGORY_ENTITY,
         NATURE_OCCUPATION,
         MBFSL_SECT_CODE,
         SECT_CODE,
         NEST_REVIEW,
         TOT_EXP_LIMIT,
         PERC_TOT_EXP,
         MANAGEMENT_FEE,
         PROFIT_SHARING,
         BASE_RATE
         /*EXP_LIMIT_APPLY_METHOD*/
         /*APPLY_STATUS,
         PF_TYPE,
         ACTIVE_STATUS*/)
         VALUES(
            UPPER(M_PORTFOLIO_CODE),
            M_OWNED_BY_MBFSL,
            M_CPCODE,
            M_PF_NAME,
            M_ADD_IDENTIFICATION,
            M_ADD_LOCATION,
            M_ADD_STREET,
            M_ADD_CITY,
            M_ADD_COUNTRY,
            M_POSTAL_CODE,
            TO_DATE(M_DATE_INC_BIRTH,'DD/MM/YYYY'),
            M_BUSI_REG_NIC,
            M_CATEGORY_ENTITY,
            M_NATURE_OCCUPATION,
            M_MBFSL_SECT_CODE,
            M_SECT_CODE,
            TO_DATE(M_NEST_REVIEW,'DD/MM/YYYY'),
            0,
            0,
            NVL(M_MANAGEMENT_FEE,0),
            NVL(M_PROFIT_SHARING,0),
            NVL(M_BASE_RATE,0)

          );
        END IF;
  END IF;

   IF M_PORTFOLIO_CODE IS NOT NULL AND M_DIRECTOR_NAME<>'NULL' AND M_SELECT_TYPE='MAIN2' THEN
      IF M_DIRECTOR_NAME IS NOT NULL THEN
      UPDATE DN_REF_PORTF_DIRECTOR
         SET DIRECTOR_NAME=M_DIRECTOR_NAME
         WHERE
            PORTFOLIO_CODE=M_PORTFOLIO_CODE
            AND
            DIRECTOR_NAME=M_DIRECTOR_NAME;
      IF SQL%NOTFOUND THEN
            INSERT INTO DN_REF_PORTF_DIRECTOR
              (PORTFOLIO_CODE,
               DIRECTOR_NAME
               )
            VALUES(M_PORTFOLIO_CODE,
                   M_DIRECTOR_NAME
                   );
      END IF;
      END IF;
   END IF;
-------------------------autho-name-----------------------------------------

IF M_PORTFOLIO_CODE IS NOT NULL AND M_AUTHO_NAME<>'NULL' AND M_SELECT_TYPE='MAIN3' THEN

     --Select AUTO NAME COUNT------

   SELECT COUNT(*) INTO M_NUM
        FROM DN_REF_PORTF_AUTHO_SIGN
            WHERE PORTFOLIO_CODE=M_PORTFOLIO_CODE;
    IF M_NUM >0  THEN
         SELECT  MAX(NVL(SEQ_NO,0))
            INTO M_VAL
                FROM DN_REF_PORTF_AUTHO_SIGN
                   WHERE PORTFOLIO_CODE=M_PORTFOLIO_CODE;

                 M_VAL:=M_VAL+1;
      ELSE
            M_VAL:=1;

    END IF;
 -- RAISE_APPLICATION_ERROR(-20201,M_VAL);

      IF M_AUTHO_NAME IS NOT NULL THEN
        UPDATE DN_REF_PORTF_AUTHO_SIGN
         SET AUTHO_NAME=M_AUTHO_NAME,
             SEQ_NO=M_VAL
         WHERE
            PORTFOLIO_CODE=M_PORTFOLIO_CODE
            AND
            AUTHO_NAME=M_AUTHO_NAME;

  IF SQL%NOTFOUND THEN
                     /*MAX(NVL(SEQ_NO,1))*/

            INSERT INTO DN_REF_PORTF_AUTHO_SIGN
              (PORTFOLIO_CODE,
               AUTHO_NAME,
               SEQ_NO
               )
              VALUES(M_PORTFOLIO_CODE,
                   M_AUTHO_NAME,
                   M_VAL
                   );
        END IF;
      END IF;
   END IF;

   ----------------------------cont-person-----------------------------

 IF M_PORTFOLIO_CODE IS NOT NULL AND M_CONT_PERSON_<>'NULL' AND M_SELECT_TYPE='MAIN4' THEN

     --cont-person------

   SELECT COUNT(*) INTO M_NUMC
        FROM DN_REF_PORTF_CONT_PERSON
             WHERE PORTFOLIO_CODE=M_PORTFOLIO_CODE;
    IF M_NUMC >0  THEN
         SELECT  MAX(NVL(SEQ_NO,0))
            INTO M_VALC
                FROM DN_REF_PORTF_CONT_PERSON
                   WHERE PORTFOLIO_CODE=M_PORTFOLIO_CODE;

                 M_VALC:=M_VALC+1;
      ELSE
            M_VALC:=1;

    END IF;
 -- RAISE_APPLICATION_ERROR(-20201,M_VAL1);

      IF M_CONT_PERSON_ IS NOT NULL THEN
       UPDATE DN_REF_PORTF_CONT_PERSON
         SET CONT_PERSON_=M_CONT_PERSON_,
             SEQ_NO=M_VALC
         WHERE
            PORTFOLIO_CODE=M_PORTFOLIO_CODE
            AND
            CONT_PERSON_=M_CONT_PERSON_;



      IF SQL%NOTFOUND THEN

            INSERT INTO DN_REF_PORTF_CONT_PERSON
              (PORTFOLIO_CODE,
               CONT_PERSON_,
               SEQ_NO
               )
              VALUES(M_PORTFOLIO_CODE,
                   M_CONT_PERSON_,
                   M_VALC
                   );
     END IF;
      END IF;
   END IF;
   /*
   TEL_NO,
    SEQ_NO
 FROM DN_REF_PORTF_CONT_TELNO
   */
  -----------------------------telephone---------------------------------------
 IF M_PORTFOLIO_CODE IS NOT NULL AND M_TEL_NO<>'NULL' AND M_SELECT_TYPE='MAIN5' THEN

     --Select telephone COUNT------

   SELECT COUNT(*) INTO M_NUMT
        FROM DN_REF_PORTF_CONT_TELNO
            WHERE PORTFOLIO_CODE=M_PORTFOLIO_CODE;
    IF M_NUMT >0  THEN
         SELECT  MAX(NVL(SEQ_NO,0))
            INTO M_VALT
                FROM DN_REF_PORTF_CONT_TELNO
                   WHERE PORTFOLIO_CODE=M_PORTFOLIO_CODE;

                 M_VALT:=M_VALT+1;
      ELSE
            M_VALT:=1;

    END IF;
 -- RAISE_APPLICATION_ERROR(-20201,M_VAL1);

      IF M_TEL_NO IS NOT NULL THEN
       UPDATE DN_REF_PORTF_CONT_TELNO
         SET TEL_NO=M_TEL_NO,
             SEQ_NO=M_VALT
         WHERE
            PORTFOLIO_CODE=M_PORTFOLIO_CODE
            AND
            TEL_NO=M_TEL_NO;



      IF SQL%NOTFOUND THEN

            INSERT INTO DN_REF_PORTF_CONT_TELNO
              (PORTFOLIO_CODE,
               TEL_NO,
               SEQ_NO
               )
              VALUES(M_PORTFOLIO_CODE,
                   M_TEL_NO,
                   M_VALT
                   );
        END IF;
      END IF;
   END IF;
  /*
  FAX_NO,
    SEQ_NO
 FROM DN_REF_PORTF_CONT_FAXNO
  */
  -------------------------------fax--------------------------------------------
  IF M_PORTFOLIO_CODE IS NOT NULL AND M_FAX_NO<>'NULL' AND M_SELECT_TYPE='MAIN6' THEN

     --Select fax COUNT------

   SELECT COUNT(*) INTO M_NUMF
        FROM DN_REF_PORTF_CONT_FAXNO
             WHERE PORTFOLIO_CODE=M_PORTFOLIO_CODE;
    IF M_NUMF >0  THEN
         SELECT  MAX(NVL(SEQ_NO,0))
            INTO M_VALF
                FROM DN_REF_PORTF_CONT_FAXNO
                   WHERE PORTFOLIO_CODE=M_PORTFOLIO_CODE;

                 M_VALF:=M_VALF+1;
      ELSE
            M_VALF:=1;

    END IF;
 -- RAISE_APPLICATION_ERROR(-20201,M_VAL1);

      IF M_FAX_NO IS NOT NULL THEN
        UPDATE DN_REF_PORTF_CONT_FAXNO
         SET FAX_NO=M_FAX_NO,
             SEQ_NO=M_VALF
         WHERE
            PORTFOLIO_CODE=M_PORTFOLIO_CODE
            AND
            FAX_NO=M_FAX_NO;



       IF SQL%NOTFOUND THEN

            INSERT INTO DN_REF_PORTF_CONT_FAXNO
              (PORTFOLIO_CODE,
               FAX_NO,
               SEQ_NO
               )
              VALUES(M_PORTFOLIO_CODE,
                   M_FAX_NO,
                   M_VALF
                   );
        END IF;
      END IF;
   END IF;

  -------------------------------e-mail---------------------------------------
 IF M_PORTFOLIO_CODE IS NOT NULL AND M_EMAIL<>'NULL' AND M_SELECT_TYPE='MAIN7' THEN

     --Select e-mail--COUNT------

   SELECT COUNT(*) INTO M_NUME
        FROM DN_REF_PORTF_CONT_EMAIL
             WHERE PORTFOLIO_CODE=M_PORTFOLIO_CODE;
    IF M_NUME >0  THEN
         SELECT  MAX(NVL(SEQ_NO,0))
            INTO M_VALE
                FROM DN_REF_PORTF_CONT_EMAIL
                   WHERE PORTFOLIO_CODE=M_PORTFOLIO_CODE;

                 M_VALE:=M_VALE+1;
      ELSE
            M_VALE:=1;

    END IF;
 -- RAISE_APPLICATION_ERROR(-20201,M_VAL1);

      IF M_EMAIL IS NOT NULL THEN
        UPDATE DN_REF_PORTF_CONT_EMAIL
         SET EMAIL=M_EMAIL,
             SEQ_NO=M_VALE
         WHERE
            PORTFOLIO_CODE=M_PORTFOLIO_CODE
            AND
            EMAIL=M_EMAIL;


    IF SQL%NOTFOUND THEN

            INSERT INTO DN_REF_PORTF_CONT_EMAIL
              (PORTFOLIO_CODE,
               EMAIL,
               SEQ_NO
               )
              VALUES(M_PORTFOLIO_CODE,
                   M_EMAIL,
                   M_VALE
                   );
        END IF;
      END IF;
   END IF;
   /*
    BRANCH_CODE,
    ACC_NO,
    FROM DN_REF_PORTF_SETTLEMENT

   */
-----------------------------------SETTLEMENT---OPTIONS-------------
IF M_PORTFOLIO_CODE IS NOT NULL AND M_BRANCH_CODE<>'NULL' AND M_SELECT_TYPE='MAIN8' THEN

      IF M_BRANCH_CODE IS NOT NULL THEN
      UPDATE DN_REF_PORTF_SETTLEMENT
           SET BRANCH_CODE=M_BRANCH_CODE,
               ACC_NO=M_ACC_NO
         WHERE
            PORTFOLIO_CODE=M_PORTFOLIO_CODE
            AND
          BRANCH_CODE=M_BRANCH_CODE;





     IF SQL%NOTFOUND THEN
            INSERT INTO DN_REF_PORTF_SETTLEMENT
              (PORTFOLIO_CODE,
               BRANCH_CODE,
               ACC_NO
               )
            VALUES(M_PORTFOLIO_CODE,
                   M_BRANCH_CODE,
                   M_ACC_NO
                   );
   END IF;
      END IF;
   END IF;


 COMMIT;


END DN_PORTFOLIOS_IN1;

/
