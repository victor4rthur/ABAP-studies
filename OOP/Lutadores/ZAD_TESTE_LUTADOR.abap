*&---------------------------------------------------------------------*
*& Report zad_teste_lutador
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zad_teste_lutador.

*Creating an internal table to create the pool of fighters
TYPES: BEGIN OF ty_tab,
         lut TYPE REF TO zadcl_lutador,
       END OF ty_tab.

DATA: itab   TYPE TABLE OF ty_tab,
      w_itab TYPE ty_tab.

"Instanciando os objetos na tabela interna
w_itab-lut = NEW zadcl_lutador(
    i_no_const = 'Pretty Boy'
    i_na_const = 'Francês'
    i_id_const = 31
    i_al_const = '1.75'
    i_pe_const = '68.9'
    i_vi_const = 11
    i_de_const = 3
    i_em_const = 1
).
APPEND w_itab TO itab.
CLEAR w_itab.

w_itab-lut = NEW zadcl_lutador(
    i_no_const = 'PutScript'
    i_na_const = 'Brasileiro'
    i_id_const = 29
    i_al_const = '1.68'
    i_pe_const = '57.8'
    i_vi_const = 14
    i_de_const = 2
    i_em_const = 3
).
APPEND w_itab TO itab.
CLEAR w_itab.

w_itab-lut = NEW zadcl_lutador(
    i_no_const = 'SnapShadow'
    i_na_const = 'EUA'
    i_id_const = 35
    i_al_const = '1.65'
    i_pe_const = '80.9'
    i_vi_const = 12
    i_de_const = 2
    i_em_const = 1
).
APPEND w_itab TO itab.
CLEAR w_itab.

w_itab-lut = NEW zadcl_lutador(
    i_no_const = 'DeadCode'
    i_na_const = 'Austrália'
    i_id_const = 28
    i_al_const = '1.93'
    i_pe_const = '81.6'
    i_vi_const = 13
    i_de_const = 0
    i_em_const = 2
).
APPEND w_itab TO itab.
CLEAR w_itab.

w_itab-lut = NEW zadcl_lutador(
    i_no_const = 'UfoCobol'
    i_na_const = 'Português'
    i_id_const = 37
    i_al_const = '1.70'
    i_pe_const = '119.3'
    i_vi_const = 5
    i_de_const = 4
    i_em_const = 3
).
APPEND w_itab TO itab.
CLEAR w_itab.

w_itab-lut = NEW zadcl_lutador(
    i_no_const = 'NerdArt'
    i_na_const = 'Japonês'
    i_id_const = 30
    i_al_const = '1.81'
    i_pe_const = '105.7'
    i_vi_const = 12
    i_de_const = 2
    i_em_const = 4
).
APPEND w_itab TO itab.
CLEAR w_itab.

DATA(uec01) = NEW zadcl_luta( ).
uec01->marcarluta(
  EXPORTING
    lutador1 = itab[ 1 ]-lut
    lutador2 = itab[ 2 ]-lut
).

IF sy-subrc EQ 0.
  uec01->lutar( ).

ENDIF.