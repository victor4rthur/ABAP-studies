CLASS zadcl_pessoa DEFINITION
  PUBLIC
  ABSTRACT "Não gera objetos
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS fazeraniv FINAL. " Não pode ser sobrescrito

    METHODS set_nome IMPORTING i_const_nome         TYPE char20.
    METHODS get_nome RETURNING VALUE(rv_get_nome)   TYPE char20.

    METHODS set_idade IMPORTING i_const_idade       TYPE i.
    METHODS get_idade RETURNING VALUE(rv_get_idade) TYPE i.

    METHODS set_sexo IMPORTING i_const_sexo         TYPE c.
    METHODS get_sexo RETURNING VALUE(rv_get_sexo)   TYPE char10.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA: nome  TYPE char20,
          idade TYPE i,
          sexo  TYPE c.

ENDCLASS.



CLASS ZADCL_PESSOA IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_PESSOA->FAZERANIV
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD fazeraniv.

    me->set_idade( get_idade( ) + 1 ).

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_PESSOA->GET_IDADE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_GET_IDADE                   TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_idade.
    rv_get_idade = me->idade.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_PESSOA->GET_NOME
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_GET_NOME                    TYPE        CHAR20
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_nome.
    rv_get_nome = me->nome.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_PESSOA->GET_SEXO
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_GET_SEXO                    TYPE        CHAR10
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_sexo.
    rv_get_sexo = me->sexo.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_PESSOA->SET_IDADE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CONST_IDADE                  TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD set_idade.
    me->idade = i_const_idade.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_PESSOA->SET_NOME
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CONST_NOME                   TYPE        CHAR20
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD set_nome.
    me->nome = i_const_nome.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_PESSOA->SET_SEXO
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CONST_SEXO                   TYPE        C
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD set_sexo.
    me->sexo = i_const_sexo.
  ENDMETHOD.
ENDCLASS.