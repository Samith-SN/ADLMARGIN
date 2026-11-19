--------------------------------------------------------
--  DDL for Procedure DN_SAVE_PRINTER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_SAVE_PRINTER" 
  (
    M_PRINTER         DN_REF_PRINTER.P_NAME%TYPE,
    M_SE_NAME         DN_REF_PRINTER.NORMAL_SHARED_NAME%TYPE,
    M_NO_NAME         DN_REF_PRINTER.SERVER_SHARED_NAME%TYPE,
    M_P_TYPE          DN_REF_PRINTER.P_TYPE%TYPE,
    M_USER 		       varchar

   )

AS

    M_SDATE      DATE;
    M_EDATE      DATE;
BEGIN

DN_VALIDATE_SAVE_RIGHTS(M_USER,'WD_Printer_Parameters');  --added by ashini on 31/10/2005 for sr0509-047


    /* PROCEDURE  - TO SAVE PRINTERS
       SYSTEM     - WEBACCOUNTS
       CREATED BY - S.V.A.
       CREATED ON - 23/02/2001 */
  --RAISE_APPLICATION_ERROR(-20201,M_PRINTER||' '||M_SE_NAME||' '||M_NO_NAME);


       UPDATE
             DN_REF_PRINTER
       SET   NORMAL_SHARED_NAME  =M_NO_NAME,
             SERVER_SHARED_NAME  =M_SE_NAME,
             ACTIVE_STATUS       ='Y'
       WHERE P_NAME = M_PRINTER;

      IF SQL%NOTFOUND THEN

             INSERT INTO DN_REF_PRINTER
               (P_NAME,NORMAL_SHARED_NAME,SERVER_SHARED_NAME,ACTIVE_STATUS,P_TYPE)
             VALUES(M_PRINTER,M_NO_NAME,M_SE_NAME,'Y',UPPER(M_P_TYPE));



       END IF;

   COMMIT;

END DN_SAVE_PRINTER;

/
