--------------------------------------------------------
--  DDL for Function DN_PAYMENT_CHQ_OR_LETTER2
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "ADLMARGIN"."DN_PAYMENT_CHQ_OR_LETTER2" 
    (
      M_PAYMENT_NO        DN_TRN_BO_SETTL_PAYMENT.PAYMENT_NO%TYPE,
      M_SETTLE_MODE        DN_TRN_BO_SETTL_PAYMENT.SETTLE_MODE%TYPE
    )
   RETURN  VARCHAR2
    IS

     -- Function      : TO PAY_REF_NO
     -- System       : FCTLAC
     -- Created by   : LATHIKA
     -- Created on   : 22/12/2000

 M_PTYPE       VARCHAR2(30);

  BEGIN

 IF M_SETTLE_MODE = 'CB_CHEQUE' OR M_SETTLE_MODE = 'CHEQUE'  THEN

   SELECT  PAY_REF_NO
   INTO    M_PTYPE
   FROM DN_TRN_BO_SETTL_CHQ_PAYMENT B
   WHERE PAYMENT_NO=M_PAYMENT_NO ;

 ELSIF M_SETTLE_MODE = 'CB_TRANF' OR M_SETTLE_MODE = 'BANK_TRANF'  THEN
    M_PTYPE := 'payrefno';

 END IF;

 RETURN (M_PTYPE);

END DN_PAYMENT_CHQ_OR_LETTER2;

/
