--------------------------------------------------------
--  DDL for Procedure DN_TRN_DEAL_COMMENTS_IN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_TRN_DEAL_COMMENTS_IN" (
    M_DEAL_NO            DN_TRN_DEAL_COMMENTS.DEAL_NO%TYPE,
    M_COMMENT1           DN_TRN_DEAL_COMMENTS.COMMENT1%TYPE,
    M_COMMENT2           DN_TRN_DEAL_COMMENTS.COMMENT2%TYPE,
    M_COMMENT3           DN_TRN_DEAL_COMMENTS.COMMENT3%TYPE,
    M_STATUS             DN_TRN_DEAL_COMMENTS.STATUS%TYPE,
    M_USERNAME           DN_TRN_DEAL_COMMENTS.DN_USER%TYPE
)

AS


BEGIN

    --RAISE_APPLICATION_ERROR(-20201,M_DEAL_NO||'-'||M_COMMENT1||'-'||M_STATUS||'-'||M_USERNAME);

    -- PROCEDURE  -  TO INSERT DEAL COMMENTS
    -- SYSTEM     -  MBFSL SYSTEM
    -- CREATED BY -  V.THILAKESAN.
    -- CREATED ON -  05/05/2000
    IF M_DEAL_NO IS NOT NULL AND M_COMMENT1 IS NOT NULL THEN

       UPDATE  DN_TRN_DEAL_COMMENTS
       SET COMMENT1=M_COMMENT1,
           COMMENT2=M_COMMENT2,
           COMMENT3=M_COMMENT3,
           STATUS=M_STATUS,
           DN_USER=M_USERNAME,
           ENT_DATE=SYSDATE
       WHERE
           DEAL_NO=M_DEAL_NO
           AND
           STATUS=M_STATUS;
       IF SQL%NOTFOUND THEN

          INSERT INTO DN_TRN_DEAL_COMMENTS
            (DEAL_NO,
             COMMENT1,
             COMMENT2,
             COMMENT3,
             STATUS,
             DN_USER,
             ENT_DATE
             )
             VALUES(
               M_DEAL_NO,
               M_COMMENT1,
               M_COMMENT2,
               M_COMMENT3,
               M_STATUS,
               M_USERNAME,
               SYSDATE
               );
      END IF;
      COMMIT;
   END IF;
   --If the data type is incorrect then delete the records from the relavent tables
/*
EXCEPTION
 WHEN OTHERS THEN

    DELETE DN_TRN_DEAL_COMMENTS
    WHERE
    DEAL_NO=M_DEAL_NO;

    COMMIT;

    -- RAISE_APPLICATION_ERROR(-20201,'Data error');
    */
END DN_TRN_DEAL_COMMENTS_IN;

/
