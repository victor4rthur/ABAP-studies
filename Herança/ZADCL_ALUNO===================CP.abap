CLASS zadcl_aluno DEFINITION PUBLIC INHERITING FROM zadcl_pessoa CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS: pagarmensal.

    METHODS: set_matricula IMPORTING i_const_matri           TYPE i.
    METHODS: get_matricula RETURNING VALUE(rv_get_matricula) TYPE char10.

    METHODS: set_curso IMPORTING i_const_curso           TYPE c.
    METHODS: get_curso RETURNING VALUE(rv_get_curso) TYPE char10.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA: matricula TYPE i,
          curso     TYPE c.

ENDCLASS.



CLASS ZADCL_ALUNO IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_ALUNO->GET_CURSO
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_GET_CURSO                   TYPE        CHAR10
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_curso.

    rv_get_curso = me->curso.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_ALUNO->GET_MATRICULA
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_GET_MATRICULA               TYPE        CHAR10
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_matricula.

    rv_get_matricula = me->matricula.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_ALUNO->PAGARMENSAL
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD pagarmensal.

    WRITE: / |Pagando mensalidade.|.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_ALUNO->SET_CURSO
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CONST_CURSO                  TYPE        C
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD set_curso.

    me->curso = i_const_curso.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_ALUNO->SET_MATRICULA
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CONST_MATRI                  TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD set_matricula.

    me->matricula = i_const_matri.

  ENDMETHOD.
ENDCLASS.