--------------------------------------------------------
--  DDL for Function DN_GET_MAP_ACC
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_GET_MAP_ACC" 
(
 M_ACC_CODE                dn_acc_account_type_map.acc_type_code%TYPE,
 M_ACC_DR_CR_STATUS        dn_acc_account_type_map.ACC_DR_CR_STATUS%TYPE
 )
 RETURN varchar
 AS
 M_MP_ACC_CODE         dn_acc_account_type_map.map_acc_type_code%TYPE;

/* create by waruna 
    0n 2010-08-11*/
 BEGIN


SELECT map_acc_type_code INTO M_MP_ACC_CODE
  FROM dn_acc_account_type_map a where acc_type_code=M_ACC_CODE AND ACC_DR_CR_STATUS=upper(M_ACC_DR_CR_STATUS);
  
  return M_MP_ACC_CODE;
 END ;

/
