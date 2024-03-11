class ZADCL_LUTADOR definition
  public
  create public .

public section.

  interfaces ZI_AD_LUTADOR .

*Metodos Auxiliares
  methods CONSTRUCTOR
    importing
      !I_NO_CONST type CHAR20
      !I_NA_CONST type CHAR10
      !I_ID_CONST type I
      !I_AL_CONST type Z_AD_PESO
      !I_PE_CONST type Z_AD_PESO
      !I_VI_CONST type I
      !I_DE_CONST type I
      !I_EM_CONST type I .
  methods SET_NOME
    importing
      !I_NO type C .
  methods GET_NOME
    returning
      value(RV_GET_NOME) type CHAR20 .
  methods SET_NACIONALIDADE
    importing
      !I_NA type C .
  methods GET_NACIONALIDADE
    returning
      value(RV_GET_NACIONALIDADE) type CHAR10 .
  methods SET_IDADE
    importing
      !I_ID type I .
  methods GET_IDADE
    returning
      value(RV_GET_IDADE) type I .
  methods SET_ALTURA
    importing
      !I_AL type Z_AD_PESO .
  methods GET_ALTURA
    returning
      value(RV_GET_ALTURA) type Z_AD_PESO .
  methods SET_PESO
    importing
      !I_PE type Z_AD_PESO .
  methods GET_PESO
    returning
      value(RV_GET_PESO) type Z_AD_PESO .
  methods GET_CATEGORIA
    returning
      value(RV_GET_CATEGORIA) type CHAR10 .
  methods SET_VITORIAS
    importing
      !I_VI type I .
  methods GET_VITORIAS
    returning
      value(RV_GET_VITORIAS) type I .
  methods SET_DERROTAS
    importing
      !I_DE type I .
  methods GET_DERROTAS
    returning
      value(RV_GET_DERROTAS) type I .
  methods SET_EMPATES
    importing
      !I_EM type I .
  methods GET_EMPATES
    returning
      value(RV_GET_EMPATES) type I .
  PROTECTED SECTION.
  PRIVATE SECTION.

*Este método está privado pois o próprio sistema está alterando-o
    METHODS set_categoria.
*Declarar atributos em privado (encapsulamento)

    DATA: nome          TYPE char20,
          nacionalidade TYPE char10,
          idade         TYPE i,
          altura        TYPE p DECIMALS 2,
          peso          TYPE p DECIMALS 2,
          categoria     TYPE char10,
          vitorias      TYPE i,
          derrotas      TYPE i,
          empates       TYPE i.

ENDCLASS.



CLASS ZADCL_LUTADOR IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_NO_CONST                     TYPE        CHAR20
* | [--->] I_NA_CONST                     TYPE        CHAR10
* | [--->] I_ID_CONST                     TYPE        I
* | [--->] I_AL_CONST                     TYPE        Z_AD_PESO
* | [--->] I_PE_CONST                     TYPE        Z_AD_PESO
* | [--->] I_VI_CONST                     TYPE        I
* | [--->] I_DE_CONST                     TYPE        I
* | [--->] I_EM_CONST                     TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD CONSTRUCTOR.

    me->nome          = i_no_const.
    me->nacionalidade = i_na_const.
    me->idade         = i_id_const.
    me->altura        = i_al_const.
    "me->peso          = i_pe_const.
    set_peso( i_pe = i_pe_const ) .
    me->vitorias      = i_vi_const.
    me->derrotas      = i_de_const.
    me->empates       = i_em_const.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->GET_ALTURA
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_GET_ALTURA                  TYPE        Z_AD_PESO
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GET_ALTURA.

    rv_get_altura = me->altura.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->GET_CATEGORIA
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_GET_CATEGORIA               TYPE        CHAR10
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GET_CATEGORIA.

    rv_get_categoria = me->categoria.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->GET_DERROTAS
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_GET_DERROTAS                TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GET_DERROTAS.

    rv_get_derrotas = me->derrotas.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->GET_EMPATES
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_GET_EMPATES                 TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GET_EMPATES.

    rv_get_empates = me->empates.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->GET_IDADE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_GET_IDADE                   TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GET_IDADE.

    rv_get_idade = me->idade.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->GET_NACIONALIDADE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_GET_NACIONALIDADE           TYPE        CHAR10
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GET_NACIONALIDADE.

    rv_get_nacionalidade = me->nacionalidade.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->GET_NOME
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_GET_NOME                    TYPE        CHAR20
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GET_NOME.

    rv_get_nome = me->nome.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->GET_PESO
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_GET_PESO                    TYPE        Z_AD_PESO
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GET_PESO.

    rv_get_peso = me->peso.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->GET_VITORIAS
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RV_GET_VITORIAS                TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD GET_VITORIAS.

    rv_get_vitorias = me->vitorias.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->SET_ALTURA
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_AL                           TYPE        Z_AD_PESO
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD SET_ALTURA.

    me->altura = i_al.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZADCL_LUTADOR->SET_CATEGORIA
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD SET_CATEGORIA.

    IF me->peso < '52.2'.
      me->categoria = 'Invalido'.

    ELSEIF me->peso <= '70.3'.
      me->categoria = 'Leve'.

    ELSEIF me->peso <= '83.9'.
      me->categoria = 'Média'.

    ELSEIF me->peso <= '120.2'.
      me->categoria = 'Pesado'.

    ELSE.
      me->categoria = 'Invalido'.
    ENDIF.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->SET_DERROTAS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_DE                           TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD SET_DERROTAS.

    me->derrotas = i_de.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->SET_EMPATES
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_EM                           TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD SET_EMPATES.

    me->empates = i_em.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->SET_IDADE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ID                           TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD SET_IDADE.

    me->nacionalidade = i_id.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->SET_NACIONALIDADE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_NA                           TYPE        C
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD SET_NACIONALIDADE.

    me->nacionalidade = i_na.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->SET_NOME
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_NO                           TYPE        C
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD SET_NOME.

    me->nome = i_no.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->SET_PESO
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PE                           TYPE        Z_AD_PESO
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD SET_PESO.

    me->peso = i_pe.

    me->set_categoria( ).

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->SET_VITORIAS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_VI                           TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD SET_VITORIAS.

    me->vitorias = i_vi.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->ZI_AD_LUTADOR~APRESENTAR
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD ZI_AD_LUTADOR~APRESENTAR.

    Write: | Lutador: { me->get_nome(  ) }. |,
           | Origem: { me->get_nacionalidade(  ) }. |,
           | { me->get_idade( ) } anos. |,
           | { me->get_altura( ) } de altura. |,
           | Pesando: { me->get_peso( ) }. |,
           | Com { me->get_vitorias(  ) } vitótias, |,
           | Apenas { me->get_derrotas(  ) } e |,
           | Somando { me->get_empates(  ) } empates. |.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->ZI_AD_LUTADOR~EMPATARLUTA
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD ZI_AD_LUTADOR~EMPATARLUTA.

 me->set_empates( get_empates( ) + 1 ).

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->ZI_AD_LUTADOR~GANHARLUTA
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD ZI_AD_LUTADOR~GANHARLUTA.

    me->set_vitorias( get_vitorias( ) + 1 ).

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->ZI_AD_LUTADOR~PERDERLUTA
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD ZI_AD_LUTADOR~PERDERLUTA.

    me->set_derrotas( get_derrotas( ) - 1 ).

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZADCL_LUTADOR->ZI_AD_LUTADOR~STATUS
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD ZI_AD_LUTADOR~STATUS.

    Write: | { me->get_nome(  ) }. |,
           | É um peso { get_categoria(  ) }. |.

  ENDMETHOD.
ENDCLASS.