*&---------------------------------------------------------------------*
*& Report z_ad_projeto
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ad_projeto.

include z_ad_projeto_top. "Tops
include z_ad_projeto_scr. "Tela
include z_ad_projeto_frm. "Forms

**********************************************************************
* Início da lógica
**********************************************************************

START-OF-SELECTION.


  IF p_log = abap_true. "if is checked call the other program

    CALL TRANSACTION 'ZAD_LOG' WITH AUTHORITY-CHECK.

  ELSE.

    PERFORM f_is_empty CHANGING lv_error. "Verifica se algum campo foi inserido
    CHECK lv_error EQ abap_false.

    PERFORM f_mate_matches CHANGING lv_error.
    CHECK lv_error EQ abap_false.

    PERFORM f_centro_matches CHANGING lv_error.
    CHECK lv_error EQ abap_false.

    PERFORM f_depos_matches CHANGING lv_error.
    CHECK lv_error EQ abap_false.

    PERFORM f_movim_matches CHANGING lv_error.
    CHECK lv_error EQ abap_false.

    PERFORM f_receb_matches CHANGING lv_error.
    CHECK lv_error EQ abap_false.

    PERFORM f_is_recent CHANGING lv_error. "verifica se o range possui até 24 meses.
    CHECK lv_error EQ abap_false.

    PERFORM f_seleciona_dados CHANGING lv_error.
    CHECK lv_error EQ abap_false.

    PERFORM f_log CHANGING lv_error.
    CHECK lv_error EQ abap_false.

    PERFORM f_extra_dados.

    PERFORM f_monta_fieldcat.
    PERFORM f_build_layout.
    PERFORM f_exibe_alv.

  ENDIF.