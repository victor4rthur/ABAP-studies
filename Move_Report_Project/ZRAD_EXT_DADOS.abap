*&---------------------------------------------------------------------*
*& Report zrad_ext_dados
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrad_ext_dados.

INCLUDE zrad_ext_dados_top.
include zrad_ext_dados_scr.
include zrad_ext_dados_frm.

**********************************************************************
* In�cio da l�gica
**********************************************************************

START-OF-SELECTION.

  DATA: lv_error TYPE boolean. "Declara��o de var para tratametno de erro

  PERFORM f_is_empty. "CHANGING lv_error.
  "CHECK lv_error EQ abap_false.
  PERFORM f_seleciona_dados CHANGING lv_error. "var � alterada caso erro
  CHECK lv_error EQ abap_false.
  PERFORM f_monta_arquivo.
  PERFORM f_download.