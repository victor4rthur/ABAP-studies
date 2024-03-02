*&---------------------------------------------------------------------*
*&  Include  zrad_ext_dados_scr
*&---------------------------------------------------------------------*


**********************************************************************
* Tela de Seleção
**********************************************************************

SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECTION-SCREEN: SKIP.

SELECT-OPTIONS: s_mate   FOR mseg-matnr,
                s_centro FOR mseg-werks,
                s_depos  FOR mseg-lgort,
                s_movim  FOR mseg-bwart,
                s_receb  FOR mseg-wempf,
                s_date   FOR mkpf-budat.

PARAMETERS: p_down TYPE string.

SELECTION-SCREEN: SKIP.
SELECTION-SCREEN: END OF BLOCK b1.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_down.

  cl_gui_frontend_services=>directory_browse( "permite apenas escolha da pasta
*  EXPORTING
*    window_title         =     " Title of Browsing Window
*    initial_folder       =     " Start Browsing Here
    CHANGING
      selected_folder      =  p_down   " Folder Selected By User
    EXCEPTIONS
      cntl_error           = 1
      error_no_gui         = 2
      not_supported_by_gui = 3
      OTHERS               = 4
  ).
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.