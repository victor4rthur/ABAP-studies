INTERFACE zad_i_bank
  PUBLIC .

"Lista os métodos que podem ser usados em classes
  METHODS abrirconta   IMPORTING !tipodeconta  TYPE char2 !nome    TYPE char50.
  METHODS fecharconta .
  METHODS depositar    IMPORTING !valor        TYPE netwr .
  METHODS sacar        IMPORTING !valorsaque   TYPE netwr .
  METHODS pagarmensal .
  methods atuTable .

ENDINTERFACE.