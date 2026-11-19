--------------------------------------------------------
--  DDL for Procedure MBFSL_TEMP_REPOFRESH_IN1_DEL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."MBFSL_TEMP_REPOFRESH_IN1_DEL" (
    M_USERNAME           DN_TRN_REPO_FRESH.DN_USER%TYPE
    
  
)

AS



BEGIN

DN_VALIDATE_SAVE_RIGHTS(M_USERNAME,'WD_Repos_Fresh'); --added by ashini on 31/10/2005 for sr0509-047
 -----------------------Select the value date-----------------------------
   
    

         delete from DN_TEMP_REPO_FRESH;
         
        

         



   COMMIT;

  

END mbfsl_temp_repofresh_in1_del;

/
