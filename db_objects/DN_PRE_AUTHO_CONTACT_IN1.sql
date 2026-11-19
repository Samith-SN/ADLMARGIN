--------------------------------------------------------
--  DDL for Procedure DN_PRE_AUTHO_CONTACT_IN1
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_PRE_AUTHO_CONTACT_IN1" 
(
    M_DEAL_NO   IN OUT    DN_TRN_OUTP_PRE_AUTHO_CONTACT.DEAL_NO%TYPE,
    M_CONTACT_PARTY      DN_TRN_OUTP_PRE_AUTHO_CONTACT.CONTACT_PARTY%TYPE,
    M_CONTACT_TYPE       DN_TRN_OUTP_PRE_AUTHO_CONTACT.CONTACT_TYPE%TYPE,
    M_CONTACT_NO         DN_TRN_OUTP_PRE_AUTHO_CONTACT.CONTACT_NO%TYPE

)

AS


BEGIN

--RAISE_APPLICATION_ERROR(-20201,'M_SETVAL********************'||M_SETVAL);
--DN_VALIDATE_SAVE_RIGHTS(M_USERNAME,M_SCREEN); 


    -- PROCEDURE  -  DN_PRE_AUTHO_CONTACT_IN1
    -- SYSTEM     -  ADLMARGIN SYSTEM
    -- CREATED BY -  K.M. WARUNA SRI JAYANATH
    -- CREATED ON -  22/03/2012
   
    
   -- M_USER:=M_USERNAME;

INSERT INTO DN_TRN_OUTP_PRE_AUTHO_CONTACT
          (DEAL_NO,
           CONTACT_PARTY,
           CONTACT_TYPE,
           CONTACT_NO
          )
          VALUES(
           M_DEAL_NO,
           M_CONTACT_PARTY,
           M_CONTACT_TYPE,
           M_CONTACT_NO
          );
         
         
END ; 

/
