CLASS zadcl_bank_account DEFINITION
  PUBLIC CREATE PUBLIC .

  PUBLIC SECTION.
    " Chama a interface usada
    INTERFACES: zad_i_bank.

    " Métodos auxiliares
    METHODS constructor  IMPORTING !i_const_saldo         TYPE saldo !i_const_status TYPE boolean .
    METHODS set_numconta.
    METHODS get_numconta RETURNING VALUE(rv_get_numconta) TYPE i .
    METHODS set_tipo     IMPORTING !i_const_tipo          TYPE char2 .
    METHODS get_tipo     RETURNING VALUE(rv_get_tipo)     TYPE char2 .
    METHODS set_dono     IMPORTING !i_const_dono          TYPE c .
    METHODS get_dono     RETURNING VALUE(rv_get_dono)     TYPE char20 .
    METHODS set_saldo    IMPORTING !i_saldo               TYPE netwr .
    METHODS get_saldo    RETURNING VALUE(rv_get_saldo)    TYPE netwr .
    METHODS set_status   IMPORTING !i_status              TYPE boolean .
    METHODS get_status   RETURNING VALUE(rv_get_status)   TYPE boolean .


  PROTECTED SECTION.
  PRIVATE SECTION.

    "Os atributos ficam privados
    DATA: dono     TYPE char20,
          saldo    TYPE netwr,
          status   TYPE boolean,
          tipo     TYPE char2,
          numconta TYPE i.

ENDCLASS.

CLASS zadcl_bank_account IMPLEMENTATION.

  METHOD zad_i_bank~atutable.
    "Passar os dados dos setters and getters para a work area
    DATA: w_dados TYPE ztad_bank.

    w_dados-zmandt = sy-mandt.
    w_dados-zaccid = me->get_numconta( ).
    w_dados-zdonoc = me->get_dono(  ).
    w_dados-zsaldo = me->get_saldo(  ).
    w_dados-zstatu = me->get_status(  ).
    w_dados-ztipoc = me->get_tipo(  ).

    "Atualize a tabela tranparente
    MODIFY ztad_bank FROM w_dados.


    IF sy-subrc EQ 0.
      "Se não deu erro modifique
      COMMIT WORK.
    ENDIF.

  ENDMETHOD.

  METHOD zad_i_bank~abrirconta.

    " Open an account with an initial balance based on the account type
    me->set_dono( nome ).
    me->set_tipo( tipodeconta ).
    me->set_numconta(  ).
    me->set_status( abap_true ).


    IF tipo EQ 'CC'.
      " Checking account: initial balance of 50
      me->set_saldo( 50 ).
    ELSEIF tipo EQ 'CP'.
      " Savings account: initial balance of 150
      me->set_saldo( 150 ).
    ELSE.
      MESSAGE 'Selecione um tipo válido.' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.

    me->zad_i_bank~atutable(  ).

  ENDMETHOD.



  METHOD constructor.

    " Initialize account properties
    me->saldo = 0.
    me->status = abap_false.

  ENDMETHOD.


  METHOD zad_i_bank~depositar.

    " Deposit money into the account if it's open
    IF status EQ abap_true.
      me->set_saldo( me->get_saldo(  ) + valor ).
    ELSE.
      MESSAGE 'Impossível depositar'  TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.

  ENDMETHOD.


  METHOD zad_i_bank~fecharconta.

    " Close the account if conditions are met
    IF saldo > 0.
      MESSAGE 'Não é possível fechar conta com saldo.' TYPE 'S' DISPLAY LIKE 'E'.
    ELSEIF saldo < 0.
      MESSAGE 'Não é possível fechar conta em débito.' TYPE 'S' DISPLAY LIKE 'E'.
    ELSE.
      " Account is closed successfully
      me->set_status( abap_false ).
    ENDIF.

  ENDMETHOD.


  METHOD get_dono.

    " Get account owner
    rv_get_dono = me->dono.

  ENDMETHOD.


  METHOD get_numconta.

    " Get account number
    rv_get_numconta = me->numconta.

  ENDMETHOD.


  METHOD get_saldo.

    " Get account balance
    rv_get_saldo = me->saldo.

  ENDMETHOD.


  METHOD get_status.

    " Get account status
    rv_get_status = me->status.

  ENDMETHOD.


  METHOD get_tipo.

    " Get account type
    rv_get_tipo = me->tipo.

  ENDMETHOD.


  METHOD zad_i_bank~pagarmensal.

    DATA: v TYPE netwr.

    " Pay monthly fee based on the account type
    IF me->tipo EQ 'CC'.
      v = 12.
    ELSEIF me->tipo EQ 'CP'.
      v = 20.
    ENDIF.

    IF status EQ abap_true.
      IF me->saldo > v.
        " Deduct the monthly fee
        me->set_saldo( me->get_saldo(  ) - v ).
      ELSE.
        MESSAGE 'Saldo insuficiente.'  TYPE 'S' DISPLAY LIKE 'E'.
      ENDIF.
    ELSE.
      MESSAGE 'Conta Fechada.'  TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.

  ENDMETHOD.


  METHOD zad_i_bank~sacar.

    " Withdraw money from the account if it's open and has sufficient balance
    IF status EQ abap_true.
      IF me->saldo > 0.
        IF valorsaque <= me->saldo.
          " Perform the withdrawal
          me->set_saldo( me->get_saldo(  ) - valorsaque ).
        ELSE.
          MESSAGE 'Saldo insuficiente.'  TYPE 'S' DISPLAY LIKE 'E'.
        ENDIF.
      ELSE.
        MESSAGE 'Conta vazia.'  TYPE 'S' DISPLAY LIKE 'E'.
      ENDIF.
    ELSE.
      MESSAGE 'Conta Fechada.'  TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.

  ENDMETHOD.


  METHOD set_dono.

    " Set account owner
    me->dono = i_const_dono.

  ENDMETHOD.


  METHOD set_numconta.


" Conte a quantidade de índices na tabela transparente.
" Se tiver vazia atribua o número 1
    DATA: num_itens TYPE i.

    SELECT COUNT( * )
    INTO num_itens
    FROM ztad_bank.
    IF  num_itens EQ 0.
      me->numconta = 1.
    ELSE.
      me->numconta = num_itens + 1.
    ENDIF.

  ENDMETHOD.


  METHOD  set_saldo.

    " Set account balance
    me->saldo = i_saldo.

  ENDMETHOD.


  METHOD set_status.

    " Set account status
    me->status = i_status.

  ENDMETHOD.


  METHOD set_tipo.

    " Set account type
    me->tipo = i_const_tipo.

  ENDMETHOD.
ENDCLASS.