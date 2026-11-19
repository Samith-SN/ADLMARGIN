--------------------------------------------------------
--  DDL for Procedure MBFSL_PRE_AUTH_CONFIRMATION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_PRE_AUTH_CONFIRMATION" 
   (
   M_DEALNO           DN_TRN_OUTP_PRE_AUTHO.DEAL_NO%TYPE,
   M_USER             DN_TRN_OUTP_PRE_AUTHO.DN_USER%TYPE

   )
AS

M_TYPE            VARCHAR2(4);
M_COUNT           NUMBER;





BEGIN

    /* PROCEDURE  -  DEAL CONFIRMATION
       SYSTEM     -  DEALNET
       CREATED BY -  DAYAN
       CREATED ON -  08/07/1999
       ADDED CODE FOR TIME LOG MANAGEMENT  BY -  S.YASODHA
       MODIFIED ON 02-08-2000*/

IF SUBSTR(M_DEALNO,1,2)='PA' THEN


  SELECT  COUNT(*)
  INTO    M_COUNT
  FROM    DN_TRN_OUTP_PRE_AUTHO
  WHERE   DEAL_NO=M_DEALNO AND
          APP_STATUS='CONF';

 IF  (M_COUNT=0)  THEN

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

       UPDATE DN_TRN_OUTP_PRE_AUTHO SET
           APP_STATUS='CONF'
       WHERE M_DEALNO=DEAL_NO;

      
       ELSE
          RAISE_APPLICATION_ERROR(-20201,'ALREADY CONFIRMED');
       END IF;

END IF;

END ; 

/
