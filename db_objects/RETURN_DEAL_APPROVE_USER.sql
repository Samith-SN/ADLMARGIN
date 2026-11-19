--------------------------------------------------------
--  DDL for Function RETURN_DEAL_APPROVE_USER
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."RETURN_DEAL_APPROVE_USER" 
(
 m_sus_ref_no         dn_time_log.sus_ref_no%TYPE,
 m_description        dn_time_log.description%TYPE
)
RETURN VARCHAR
AS
M_dn_user               dn_time_log.dn_user%TYPE;


BEGIN



SELECT  a.dn_user INTO M_dn_user
FROM dn_time_log a where sus_ref_no=m_sus_ref_no
and description=m_description;





--dbms_output.put_line('M_CDS_ACC_NO '||M_CDS_ACC_NO);

RETURN nvl(M_dn_user,'-');
END;

/
