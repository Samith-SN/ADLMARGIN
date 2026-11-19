--------------------------------------------------------
--  DDL for Procedure DN_PORTFOLIOS_MT_IN1_TEMP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_PORTFOLIOS_MT_IN1_TEMP" 

   (    M_PORTFOLIO_CODE    IN OUT  DN_REF_PORTFOLIO_TEMP_TEMP.PORTFOLIO_CODE%TYPE, --1
        M_OWNED_BY_MBFSL            DN_REF_PORTFOLIO_TEMP.OWNED_BY_MBFSL%TYPE, --2
        M_CP_PORTFOLIO_CODE         DN_REF_PORTFOLIO_TEMP.CP_PORTFOLIO_CODE%TYPE, --3
        M_PF_NAME                   DN_REF_PORTFOLIO_TEMP.PF_NAME%TYPE, --4
        M_ADD_IDENTIFICATION        DN_REF_PORTFOLIO_TEMP.ADD_IDENTIFICATION%TYPE, --5
        M_ADD_LOCATION              DN_REF_PORTFOLIO_TEMP.ADD_LOCATION%TYPE, --6
        M_ADD_STREET                DN_REF_PORTFOLIO_TEMP.ADD_STREET%TYPE, --7
        M_ADD_CITY                  DN_REF_PORTFOLIO_TEMP.ADD_CITY%TYPE, --8
        M_ADD_COUNTRY               DN_REF_PORTFOLIO_TEMP.ADD_COUNTRY%TYPE, --9
        M_POSTAL_CODE               DN_REF_PORTFOLIO_TEMP.POSTAL_CODE%TYPE, --10
        M_DATE_INC_BIRTH            VARCHAR2, --11
        M_BUSI_REG_NIC              DN_REF_PORTFOLIO_TEMP.BUSI_REG_NIC%TYPE, --12
        M_CATEGORY_ENTITY           DN_REF_PORTFOLIO_TEMP.CATEGORY_ENTITY%TYPE, --13
        M_NATURE_OCCUPATION         DN_REF_PORTFOLIO_TEMP.NATURE_OCCUPATION%TYPE, --14
        M_MBFSL_SECT_CODE           DN_REF_PORTFOLIO_TEMP.MBFSL_SECT_CODE%TYPE, --15
        M_SECT_CODE                 DN_REF_PORTFOLIO_TEMP.SECT_CODE%TYPE, --16
        M_NEST_REVIEW               VARCHAR2, --17
        M_DIRECTOR_NAME             DN_REF_PORTF_DIRECTOR_TEMP.DIRECTOR_NAME%TYPE, --18
        M_SELECT_TYPE               CHAR, --19
        M_AUTHO_NAME                DN_REF_PORTF_AUTHO_SIGN_TEMP.AUTHO_NAME%TYPE, --20
        M_CONT_PERSON_              DN_REF_PORTF_CONT_PERSON.CONT_PERSON_%TYPE, --21
        M_TEL_NO                    DN_REF_PORTF_CONT_TELNO.TEL_NO%TYPE, --22
        M_FAX_NO                    DN_REF_PORTF_CONT_FAXNO.FAX_NO%TYPE, --23
        M_EMAIL                     DN_REF_PORTF_CONT_EMAIL.EMAIL%TYPE, -- 24
        M_BRANCH_CODE               DN_REF_PORTF_SETTLEMENT.BRANCH_CODE%TYPE, --25
        M_ACC_NO                    DN_REF_PORTF_SETTLEMENT.ACC_NO%TYPE, --26
        M_RATE                      DN_REF_PORTFOLIO_TEMP.RATE%TYPE, --27
        M_RATE_TYPE                 DN_REF_PORTFOLIO_TEMP.RATE_TYPE%TYPE, -- 28
        M_LIMIT                     DN_REF_PORTFOLIO_TEMP.LIMIT%TYPE, --29
        M_MANAGEMENT_FEE            DN_REF_PORTFOLIO_TEMP.MANAGEMENT_FEE%TYPE, --30
        M_PROFIT_SHARING            DN_REF_PORTFOLIO_TEMP.PROFIT_SHARING%TYPE, --31
        M_BASE_RATE                 DN_REF_PORTFOLIO_TEMP.BASE_RATE%TYPE, --32
        M_CDS_ACC_NO                DN_REF_PORTFOLIO_TEMP.CDS_ACC_NO%TYPE, --33
        M_ACC_NO1                   DN_REF_PORTFOLIO_TEMP.ACC_NO%TYPE,  --  34 added by nilu on 29.09.04 for SRF 0409-071 Account no.
        M_CON_MARGIN_TYPE           CHAR,  --  35  SANJEEWA 2010/07/07 
        M_USRE                      VARCHAR,  --36
        M_SETT_MODE                 DN_REF_PORTF_SETTLEMENT.SETT_MODE%TYPE --37 --add by waruna 2011-06-20

   )

AS
   M_TOT_EXP_LIMIT       DN_REF_PORTFOLIO_TEMP.TOT_EXP_LIMIT%TYPE;
   M_PERC_TOT_EXP        DN_REF_PORTFOLIO_TEMP.PERC_TOT_EXP%TYPE;
   M_CPCODE              DN_REF_PORTFOLIO_TEMP.CP_PORTFOLIO_CODE%TYPE;
   M_VAL                 DN_REF_PORTF_AUTHO_SIGN_TEMP.SEQ_NO%TYPE;
   M_NUM                 DN_REF_PORTF_AUTHO_SIGN_TEMP.SEQ_NO%TYPE;
   M_VALC               DN_REF_PORTF_CONT_PERSON.SEQ_NO%TYPE;
   M_NUMC                DN_REF_PORTF_CONT_PERSON.SEQ_NO%TYPE;
   M_VALT                DN_REF_PORTF_CONT_TELNO.SEQ_NO%TYPE;
   M_NUMT                DN_REF_PORTF_CONT_TELNO.SEQ_NO%TYPE;
   M_VALF                DN_REF_PORTF_CONT_FAXNO.SEQ_NO%TYPE;
   M_NUMF                DN_REF_PORTF_CONT_FAXNO.SEQ_NO%TYPE;
   M_VALE               DN_REF_PORTF_CONT_EMAIL.SEQ_NO%TYPE;
   M_NUME              DN_REF_PORTF_CONT_EMAIL.SEQ_NO%TYPE;

   M_t_DATE DATE;
   M_temp_NEST_REVIEW varchar(20);
BEGIN

DN_VALIDATE_SAVE_RIGHTS(M_USRE,'WD_Portfolios_MT_New');  --added by ashini on 31/10/2005 for sr0509-047

--RAISE_APPLICATION_ERROR(-20201,'******'||M_NEST_REVIEW||'***');

--RAISE_APPLICATION_ERROR(-20201,'M_PORTFOLIO_CODE ='||M_PORTFOLIO_CODE ||'   M_INS_CODE='||M_INS_CODE||'M_INS_RATE'||M_INS_RATE);

    /* PROCEDURE  - TO SAVE PORTFOLIOS
       SYSTEM     -  DEALNET
       CREATED BY -
       CREATED ON -
       MODIFIED ON - 29.09.2004 BY NILU
       PURPOSE - ADDING THE ACCOUNT NO  SRF 0409-071 */

 M_VAL:=0;
 M_VALC:=0;M_VALT:=0;M_VALF:=0;M_VALE:=0;
 IF M_CP_PORTFOLIO_CODE  IS NULL THEN
    M_CPCODE:=NULL;
ELSE
   M_CPCODE:=M_CP_PORTFOLIO_CODE;
END IF;

IF M_PORTFOLIO_CODE IS NOT NULL  AND M_SELECT_TYPE='MAIN1' THEN

 UPDATE DN_REF_PORTFOLIO_TEMP_TEMP--DN_REF_PORTFOLIO_TEMP
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
           --NEST_REVIEW           =TO_DATE(M_NEST_REVIEW,'DD/MM/YYYY'),
           ACTIVE_STATUS         ='M',
           RATE                  =M_RATE/100,
           RATE_TYPE             =M_RATE_TYPE,
           --LIMIT                 =M_LIMIT,
           MANAGEMENT_FEE        =NVL(M_MANAGEMENT_FEE,0),
           PROFIT_SHARING        =NVL(M_PROFIT_SHARING,0),
           BASE_RATE             =NVL(M_BASE_RATE,0),
           CDS_ACC_NO            =M_CDS_ACC_NO,
           ACC_NO                =M_ACC_NO1,  -- ADDED BY NILU ON 29.09.2004 SRF 0409-071
           CON_MARGIN_TYPE       =M_CON_MARGIN_TYPE  --SANJEEWA  2010/07/27
        WHERE
           UPPER(PORTFOLIO_CODE)=UPPER(M_PORTFOLIO_CODE);

      IF SQL%NOTFOUND THEN
 /*
RAISE_APPLICATION_ERROR(-20201,'PORTFOLIO_CODE='||UPPER(M_PORTFOLIO_CODE)||'<BR>'||'OWNED_BY_MBFSL='||M_OWNED_BY_MBFSL||'<BR>'||
         'CP_PORTFOLIO_CODE='||M_CPCODE||'<BR>'||
         'PF_NAME='||M_PF_NAME||'<BR>'||
         'ADD_IDENTIFICATION='||M_ADD_IDENTIFICATION||'<BR>'||
         'ADD_LOCATION='||M_ADD_LOCATION||'<BR>'||
         'ADD_STREET='||M_ADD_STREET||'<BR>'||
         'ADD_CITY='||M_ADD_CITY||'<BR>'||
         'ADD_COUNTRY='||M_ADD_COUNTRY||'<BR>'||
         'POSTAL_CODE='||M_POSTAL_CODE||'<BR>'||
         'DATE_INC_BIRTH='|| TO_DATE(M_DATE_INC_BIRTH,'DD/MM/YYYY')||'<BR>'||
         'BUSI_REG_NIC='||M_BUSI_REG_NIC||'<BR>'||
         'CATEGORY_ENTITY='||M_CATEGORY_ENTITY||'<BR>'||
         'NATURE_OCCUPATION='||M_NATURE_OCCUPATION||'<BR>'||
         'MBFSL_SECT_CODE='||M_MBFSL_SECT_CODE||'<BR>'||
         'SECT_CODE='||M_SECT_CODE||'<BR>'||
         'NEST_REVIEW='||TO_DATE(M_NEST_REVIEW,'DD/MM/YYYY')||'<BR>'||
         'TOT_EXP_LIMIT='||0||'<BR>'||
         'PERC_TOT_EXP='||0||'<BR>'||
         'RATE='|| NVL(M_RATE,0)/100||'<BR>'||
         'RATE_TYPE='||M_RATE_TYPE||'<BR>'||
         'LIMIT='||'0'||'<BR>'||
         'MANAGEMENT_FEE='|| NVL(M_MANAGEMENT_FEE,0)||'<BR>'||
         'PROFIT_SHARING='||NVL(M_PROFIT_SHARING,0)||'<BR>'||
         'BASE_RATE='||NVL(M_BASE_RATE,0)||'<BR>'||
         'CDS_ACC_NO='||M_CDS_ACC_NO||'<BR>'||
         'ACC_NO='||M_ACC_NO1||'<BR>'||
         'CON_MARGIN_TYPE='||M_CON_MARGIN_TYPE||'<BR>'||
         'ACTIVE_STATUS='||'E'||'<BR>'
);
*/

--M_t_DATE:=M_NEST_REVIEW;--TO_DATE( nvl2(trim(M_NEST_REVIEW),M_NEST_REVIEW,to_char(sysdate+366,'DD/MM/YYYY')),'DD/MM/YYYY');
if M_NEST_REVIEW<>'//'then
M_temp_NEST_REVIEW:=M_NEST_REVIEW;
end if;

--RAISE_APPLICATION_ERROR(-20201,'****'||M_NEST_REVIEW  ||'*******');
   --M_PORTFOLIO_CODE:= DN_GET_AUTO_MT_NO(UPPER(M_PORTFOLIO_CODE));--mt no is auto genareted.
     INSERT INTO DN_REF_PORTFOLIO_TEMP
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
         RATE,
         RATE_TYPE,
         LIMIT,
         MANAGEMENT_FEE,
         PROFIT_SHARING,
         BASE_RATE,
         CDS_ACC_NO,
         ACC_NO,            -- ADDED BY NILU ON 29.09.2004 SRF 0409-071
         CON_MARGIN_TYPE   --SANJEEWA  2010/07/27
         /*EXP_LIMIT_APPLY_METHOD*/
         /*APPLY_STATUS,
         PF_TYPE,*/
         ,ACTIVE_STATUS)
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
            TO_DATE(nvl(M_DATE_INC_BIRTH,'01/01/1900'),'DD/MM/YYYY'),
            M_BUSI_REG_NIC,
            M_CATEGORY_ENTITY,
            M_NATURE_OCCUPATION,
            M_MBFSL_SECT_CODE,
            M_SECT_CODE,
        --  TO_DATE('01-01-2011','DD/MM/YYYY'), --
          TO_DATE( nvl2(trim(M_temp_NEST_REVIEW),M_NEST_REVIEW,to_char(sysdate+366,'DD/MM/YYYY')),'DD/MM/YYYY'),--change by waruna M_NEST_REVIEW 2011-04-27
            0,
            0,
            NVL(trim(M_RATE),0)/100,
            M_RATE_TYPE,
            0, -- M_LIMIT,--limit add separate screen 
            NVL(trim(M_MANAGEMENT_FEE),0),
            NVL(trim(M_PROFIT_SHARING),0),
            NVL(trim(M_BASE_RATE),0),
            M_CDS_ACC_NO,
            M_ACC_NO1,  -- ADDED BY NILU ON 29.09.2004 SRF 0409-071
            M_CON_MARGIN_TYPE  --SANJEEWA  2010/07/27
            ,'E'
          );
           INSERT INTO dn_doc_status_log( DOC_REF_NO,DOC_TYPE,DOC_STATUS,DN_USER,ENT_DATE,DESCRIPTION)
           VALUES(UPPER(M_PORTFOLIO_CODE),'ENTER CLIENT','E',M_USRE,SYSDATE,'ENTERED CLIENT');
        ELSE 
           INSERT INTO dn_doc_status_log( DOC_REF_NO,DOC_TYPE,DOC_STATUS,DN_USER,ENT_DATE,DESCRIPTION)
           VALUES(UPPER(M_PORTFOLIO_CODE),'UPDATE CLIENT','M',M_USRE,SYSDATE,'MODIFIED CLIENT');
           
        END IF;
          
  END IF;

   IF M_PORTFOLIO_CODE IS NOT NULL AND M_DIRECTOR_NAME<>'NULL' AND M_SELECT_TYPE='MAIN2' THEN
      IF M_DIRECTOR_NAME IS NOT NULL THEN
      UPDATE DN_REF_PORTF_DIRECTOR_TEMP
         SET DIRECTOR_NAME=M_DIRECTOR_NAME
         WHERE
            PORTFOLIO_CODE=M_PORTFOLIO_CODE
            AND
            DIRECTOR_NAME=M_DIRECTOR_NAME;
      IF SQL%NOTFOUND THEN
            INSERT INTO DN_REF_PORTF_DIRECTOR_TEMP
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
        FROM DN_REF_PORTF_AUTHO_SIGN_TEMP
            WHERE PORTFOLIO_CODE=M_PORTFOLIO_CODE;
    IF M_NUM >0  THEN
         SELECT  MAX(NVL(SEQ_NO,0))
            INTO M_VAL
                FROM DN_REF_PORTF_AUTHO_SIGN_TEMP
                   WHERE PORTFOLIO_CODE=M_PORTFOLIO_CODE;

                 M_VAL:=M_VAL+1;
      ELSE
            M_VAL:=1;

    END IF;
 -- RAISE_APPLICATION_ERROR(-20201,M_VAL);

      IF M_AUTHO_NAME IS NOT NULL THEN
        UPDATE DN_REF_PORTF_AUTHO_SIGN_TEMP
         SET AUTHO_NAME=M_AUTHO_NAME,
             SEQ_NO=M_VAL
         WHERE
            PORTFOLIO_CODE=M_PORTFOLIO_CODE
            AND
            AUTHO_NAME=M_AUTHO_NAME;

  IF SQL%NOTFOUND THEN
                     /*MAX(NVL(SEQ_NO,1))*/

            INSERT INTO DN_REF_PORTF_AUTHO_SIGN_TEMP
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
   
   
    -------------------------------e-mail CC---------------------------------------
 IF M_PORTFOLIO_CODE IS NOT NULL AND M_EMAIL<>'NULL' AND M_SELECT_TYPE='MAIN9' THEN

     --Select e-mail--COUNT------

   SELECT COUNT(*) INTO M_NUME
        FROM DN_REF_PORTF_CONT_EMAILCC
             WHERE PORTFOLIO_CODE=M_PORTFOLIO_CODE;
    IF M_NUME >0  THEN
         SELECT  MAX(NVL(SEQ_NO,0))
            INTO M_VALE
                FROM DN_REF_PORTF_CONT_EMAILCC
                   WHERE PORTFOLIO_CODE=M_PORTFOLIO_CODE;

                 M_VALE:=M_VALE+1;
      ELSE
            M_VALE:=1;

    END IF;
 -- RAISE_APPLICATION_ERROR(-20201,M_VAL1);

      IF M_EMAIL IS NOT NULL THEN
        UPDATE DN_REF_PORTF_CONT_EMAILCC
         SET EMAIL=M_EMAIL,
             SEQ_NO=M_VALE
         WHERE
            PORTFOLIO_CODE=M_PORTFOLIO_CODE
            AND
            EMAIL=M_EMAIL;


    IF SQL%NOTFOUND THEN

            INSERT INTO DN_REF_PORTF_CONT_EMAILCC
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
               ACC_NO=M_ACC_NO,
               SETT_MODE=M_SETT_MODE --add by waruna 2011-06-20
         WHERE
            PORTFOLIO_CODE=M_PORTFOLIO_CODE
            AND
          BRANCH_CODE=M_BRANCH_CODE;

     IF SQL%NOTFOUND THEN
            INSERT INTO DN_REF_PORTF_SETTLEMENT
              (PORTFOLIO_CODE,
               BRANCH_CODE,
               ACC_NO,
               SETT_MODE   ---add by waruna 2011-06-20
               )
            VALUES(M_PORTFOLIO_CODE,
                   M_BRANCH_CODE,
                   M_ACC_NO,
                   M_SETT_MODE ---add by waruna 2011-06-20
                   );
   END IF;
      END IF;
   END IF;
 COMMIT;


END ; 

/
