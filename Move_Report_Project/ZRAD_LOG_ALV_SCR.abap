*&---------------------------------------------------------------------*
*&  Include  zrad_log_alv_scr
*&---------------------------------------------------------------------*



**********************************************************************
* Tela de Seleção
**********************************************************************

SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECTION-SCREEN: SKIP.

PARAMETERS: p_user   TYPE sy-uname,
            p_date   TYPE sy-datum,
            p_time   TYPE sy-uzeit,
            p_mate   TYPE mseg-matnr,
            p_centro TYPE mseg-werks,
            p_depos  TYPE mseg-lgort,
            p_movim  TYPE mseg-bwart,
            p_receb  TYPE mseg-wempf.

SELECTION-SCREEN: SKIP.
SELECTION-SCREEN: END OF BLOCK b1.