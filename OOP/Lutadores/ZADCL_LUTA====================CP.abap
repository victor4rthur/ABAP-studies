CLASS zadcl_luta DEFINITION
  PUBLIC CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS: marcarluta importing lutador1 TYPE REF TO zadcl_lutador
                                  lutador2 TYPE REF TO zadcl_lutador,
      lutar.

    METHODS: set_desafiado IMPORTING i_dd TYPE REF TO zadcl_lutador.
    METHODS: get_desafiado RETURNING VALUE(rv_get_desafiado) TYPE REF TO zadcl_lutador.

    METHODS: set_desafiante IMPORTING i_df TYPE REF TO zadcl_lutador.
    METHODS: get_desafiante RETURNING VALUE(rv_get_desafiante) TYPE REF TO zadcl_lutador.

  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA: desafiado  TYPE REF TO zadcl_lutador,
          desafiante TYPE REF TO zadcl_lutador,
          rounds     TYPE i,
          aprovada   TYPE boolean.
ENDCLASS.



CLASS ZADCL_LUTA IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTA->GET_DESAFIADO
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_GET_DESAFIADO               TYPE REF TO ZADCL_LUTADOR
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_desafiado.

    rv_get_desafiado = me->desafiado.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTA->GET_DESAFIANTE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_GET_DESAFIANTE              TYPE REF TO ZADCL_LUTADOR
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_desafiante.

    rv_get_desafiante = me->desafiante.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTA->LUTAR
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD lutar.

    IF aprovada = abap_true.
      desafiado->zi_ad_lutador~apresentar(  ).
      desafiante->zi_ad_lutador~apresentar(  ).

      DATA: lv_random TYPE i.

      CALL FUNCTION 'QF05_RANDOM_INTEGER'
        EXPORTING
          ran_int_min = 0
          ran_int_max = 2
        IMPORTING
          ran_int     = lv_random.

      CASE lv_random.
        WHEN 0.
          Write: / |A luta empatou.|.
          desafiado->zi_ad_lutador~empatarluta(  ).
          desafiante->zi_ad_lutador~empatarluta(  ).

        WHEN 1.
          write: / |O lutador { me->get_desafiado( )->get_nome( ) } venceu.|.
          desafiado->zi_ad_lutador~ganharluta(  ).
          desafiante->zi_ad_lutador~perderluta(  ).
        WHEN 2.
        write: / |O lutador { me->get_desafiante( )->get_nome( ) } venceu.|.
          desafiado->zi_ad_lutador~perderluta(  ).
          desafiante->zi_ad_lutador~ganharluta(  ).

      ENDCASE.


    ELSE.

      MESSAGE 'Luta não aprovada.' TYPE 'E' DISPLAY LIKE 'S'.

    ENDIF.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTA->MARCARLUTA
* +-------------------------------------------------------------------------------------------------+
* | [--->] LUTADOR1                       TYPE REF TO ZADCL_LUTADOR
* | [--->] LUTADOR2                       TYPE REF TO ZADCL_LUTADOR
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD marcarluta.



    IF lutador1->get_categoria(  ) EQ lutador2->get_categoria(  ) AND lutador1 NE lutador2.
      aprovada = abap_true.
      desafiado = lutador1.
      desafiante = lutador2.
    ELSE.
      aprovada = abap_false.
      CLEAR desafiado.
      CLEAR desafiante.
      MESSAGE 'Os lutadores são de tegorias diferentes' TYPE 'E' DISPLAY LIKE 'S'.

    ENDIF.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTA->SET_DESAFIADO
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_DD                           TYPE REF TO ZADCL_LUTADOR
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD set_desafiado.

    me->desafiado = i_dd.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTA->SET_DESAFIANTE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_DF                           TYPE REF TO ZADCL_LUTADOR
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD set_desafiante.

    me->desafiante = i_df.

  ENDMETHOD.
ENDCLASS.