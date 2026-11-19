--------------------------------------------------------
--  DDL for Procedure FA_CR_FACILITY_SEC_DET_SAVE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "ADLMARGIN"."FA_CR_FACILITY_SEC_DET_SAVE" 
(
    M_FACILITY_NO                   dn_facility_sec_det_inf.FACILITY_NO % TYPE,
    M_CATEGORY                      dn_facility_sec_det_inf.CATEGORY % TYPE,
    M_COLL_AMOUNT                   VARCHAR2,
    M_FORCE_SAL_VAL                 VARCHAR2,
    M_AMT_CONSIDERED                VARCHAR2,
    M_AMT_CONS_PERC                 VARCHAR2,
    M_USER                          dn_facility_sec_det_inf.ENT_USER % TYPE,
    M_SECURITY_TYPE                 dn_facility_sec_det_inf.SECURITY_TYPE % TYPE
)

IS

BEGIN
   
/* 
 * Author                   :   Thamali Jayatunga
 * Date                     :   2010-03-19
 */
    

    /* Insert A New Row To The Table */
    INSERT INTO dn_facility_sec_det_inf
    (
        FACILITY_NO,
        CATEGORY,
        COLL_AMOUNT,
        FORCE_SAL_VAL,
        AMT_CONSIDERED,
        AMT_CONS_PERC,
        ENT_USER,
        ENT_DATE,
        SECURITY_TYPE
    )
    VALUES
    (
        M_FACILITY_NO,
        M_CATEGORY,
        TO_NUMBER(M_COLL_AMOUNT),
        TO_NUMBER(M_FORCE_SAL_VAL),
        TO_NUMBER(M_AMT_CONSIDERED),
        TO_NUMBER(M_AMT_CONS_PERC),
        M_USER,
        SYSDATE,
        M_SECURITY_TYPE
    );
    
END;

/
