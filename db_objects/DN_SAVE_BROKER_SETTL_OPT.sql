--------------------------------------------------------
--  DDL for Procedure DN_SAVE_BROKER_SETTL_OPT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."DN_SAVE_BROKER_SETTL_OPT" 
(
    M_BROKER_CODE                        IN DN_MAS_BROKER_SETTL_OPTION.PORTFOLIO_CODE % TYPE,
    M_MODE_CODE                           IN DN_MAS_BROKER_SETTL_OPTION.MODE_CODE % TYPE,
    M_TYPE_CODE                           IN DN_MAS_BROKER_SETTL_OPTION.TYPE_CODE % TYPE
)
    
/* 
 * Author                   :   waruna srijayanath
 * Date                     :   2011-10-12
 * 
 * System                   :   ADLMARGIN
 * 
 * Purpose                  :   Save Procedure broker settlement option
 */
    
IS
    
    
BEGIN
    
    DELETE FROM DN_MAS_BROKER_SETTL_OPTION WHERE PORTFOLIO_CODE=M_BROKER_CODE;
    /* Insert A New Row To The Table */
INSERT INTO DN_MAS_BROKER_SETTL_OPTION (
    PORTFOLIO_CODE,
    MODE_CODE,
    TYPE_CODE,
    ENTDATE
)
VALUES (
    M_BROKER_CODE,
    M_MODE_CODE,
    M_TYPE_CODE,
    SYSDATE
);
    
END ;

/
