--------------------------------------------------------
--  DDL for Procedure DN_REPOROLL_LEND_SCRIPLESS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_REPOROLL_LEND_SCRIPLESS" 
(
M_DEAL_NO           DN_TRN_REPO_ROLLOVER.DEAL_NO%TYPE--,
--M_USER              DN_TRN_REPO_ROLLOVER.DN_USER%TYPE
)

AS

BEGIN

      --CREATED ON  :11-10-2001
      --CREATED BY  :NIRMALA FERNANDO
      --SYSTEM      :DEALNET(MBFSL)
      --PORCEDURE   :SCRIPLESS SYSTEM REPO ROLLOVER PROCEDURE -WHEN LENDER IS A PORTFOLIO



      -- Updating repo settlement inventory suspense for borrower
      DN_INV_REPO_RS_SUS_BORR_SL(M_DEAL_NO);
      -- Updating repo settlement inventory suspense for Lender
      DN_INV_REPO_RS_SUS_LEND_SL(M_DEAL_NO);

      -- calling the normal repofersh procedure for lender
      --DN_REPO_LEND_SCRIPLESS(M_DEAL_NO);
      DN_REPO_LEND_SCRIPLESS_ROLL(M_DEAL_NO);




END DN_REPOROLL_LEND_SCRIPLESS;

/
