*&---------------------------------------------------------------------*
*& Report zrad_log_alv
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrad_log_alv.

include zrad_log_alv_top.
include zrad_log_alv_scr.
include zrad_log_alv_frm.

**********************************************************************
* Início da lógica
**********************************************************************

START-OF-SELECTION.
  DATA: lv_error TYPE boolean. "variavel para tratar erros

  PERFORM f_is_empty CHANGING lv_error.
  CHECK lv_error EQ abap_false.


  PERFORM f_seleciona_dados CHANGING lv_error. "var é alterada caso erro
  CHECK lv_error EQ abap_false.

  PERFORM f_monta_fieldcat.
  PERFORM f_build_layout.
  PERFORM f_exibe_alv.