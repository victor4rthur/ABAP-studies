CLASS zadcl_bolsista DEFINITION PUBLIC INHERITING FROM zadcl_aluno CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      renovarbolsa,
      pagarmensal REDEFINITION.


    METHODS: set_bolsa IMPORTING i_const_bolsa TYPE i.
    METHODS: get_bolsa RETURNING VALUE(rv_get_bolsa) TYPE i.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA: bolsa TYPE i.

ENDCLASS.



CLASS ZADCL_BOLSISTA IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_BOLSISTA->GET_BOLSA
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_GET_BOLSA                   TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_bolsa.

    rv_get_bolsa = me->bolsa.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_BOLSISTA->PAGARMENSAL
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD pagarmensal.

    WRITE: / |Isento da mensalidade.|.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_BOLSISTA->RENOVARBOLSA
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD renovarbolsa.

    WRITE: / |Bolsa renovada.|.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_BOLSISTA->SET_BOLSA
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CONST_BOLSA                  TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD set_bolsa.

    me->bolsa = i_const_bolsa.

  ENDMETHOD.
ENDCLASS.