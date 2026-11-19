--------------------------------------------------------
--  DDL for Procedure DN_ACC_TRN_TEXT_MAP_SAVE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_ACC_TRN_TEXT_MAP_SAVE" 
   (
   
   M_TRN_REF                               DN_ACC_TRN_TEXT_MAP.TRN_REF%TYPE ,
   M_ACC_TYPE_CODE_MAP                     DN_ACC_TRN_TEXT_MAP.ACC_TYPE_CODE_MAP%TYPE   ,
   M_CURRENCY                              DN_ACC_TRN_TEXT_MAP.CURRENCY%TYPE ,
   M_TRNAMOUNT                             DN_ACC_TRN_TEXT_MAP.TRNAMOUNT%TYPE ,
   M_TRNDATE                               VARCHAR2,--DN_ACC_TRN_TEXT_MAP.TRNDATE%TYPE  ,
   M_CORR_ACC_NO_MAP                       DN_ACC_TRN_TEXT_MAP.CORR_ACC_NO_MAP%TYPE ,
   M_CIF_NO                                DN_ACC_TRN_TEXT_MAP.CIF_NO%TYPE,
   M_PROC_DESC                             DN_ACC_TRN_TEXT_MAP.PROC_DESC%TYPE,
   M_BRNACH                                DN_ACC_TRN_TEXT_MAP.BRNACH%TYPE,
   M_RUNDATE                               VARCHAR2,--DN_ACC_TRN_TEXT_MAP.RUNDATE%TYPE,
   M_USER                                  DN_ACC_TRN_TEXT_MAP.DN_USER%TYPE
     
    )

AS

BEGIN
   /* PROCEDURE  -  DN_ACC_TRN_TEXT_MAP_SAVE
   SYSTEM     -  PABC
   CREATED BY -  waruna
   CREATED ON -  11/08/2010*/
   


        INSERT INTO DN_ACC_TRN_TEXT_MAP
         (TRN_REF,ACC_TYPE_CODE_MAP,CURRENCY,TRNAMOUNT,TRNDATE,CORR_ACC_NO_MAP,CIF_NO,
          PROC_DESC,BRNACH,RUNDATE,DN_USER)
        VALUES
        (M_TRN_REF,M_ACC_TYPE_CODE_MAP,M_CURRENCY,M_TRNAMOUNT,To_Date(M_TRNDATE,'DD/MM/YYYY'),M_CORR_ACC_NO_MAP,
         M_CIF_NO,M_PROC_DESC,M_BRNACH,To_Date(M_RUNDATE,'DD/MM/YYYY'),M_USER);

              

END DN_ACC_TRN_TEXT_MAP_SAVE;

/
