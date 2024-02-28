*&---------------------------------------------------------------------*
*&  Include  z_ad_projeto_scr
*&---------------------------------------------------------------------*


**********************************************************************
* Selection Screen
**********************************************************************
SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

SELECTION-SCREEN: SKIP.

PARAMETERS: p_mate   TYPE mseg-matnr,
            p_centro TYPE mseg-werks,
            p_depos  TYPE mseg-lgort,
            p_movim  TYPE mseg-bwart,
            p_receb  TYPE mseg-wempf.

SELECT-OPTIONS: s_date FOR mkpf-budat.

SELECTION-SCREEN: SKIP.

PARAMETERS: p_log AS CHECKBOX USER-COMMAND elog. "O usercommand faz um trigger altomático ao ser clicado

SELECTION-SCREEN: END OF BLOCK b1.

**********************************************************************
*Eventos
**********************************************************************

AT SELECTION-SCREEN OUTPUT.  " Evento de saída da tela de seleção

*  Verify if check button is seleted. if so, the other var can not be changed

  IF p_log = abap_true.

    LOOP AT SCREEN.
      IF screen-name = 'P_MATE'.
        screen-input = '0'.
      ENDIF.

      IF screen-name = 'P_CENTRO'.
        screen-input = '0'.
      ENDIF.

      IF screen-name = 'P_DEPOS'.
        screen-input = '0'.
      ENDIF.

      IF screen-name = 'P_MOVIM'.
        screen-input = '0'.
      ENDIF.

      IF screen-name = 'P_RECEB'.
        screen-input = '0'.
      ENDIF.

      IF screen-name = 'S_DATE-HIGH'. "Select-screen possui duas variáveis High e Low
        screen-input = '0'.
      ENDIF.

      IF screen-name = 'S_DATE-LOW'.
        screen-input = '0'.
      ENDIF.

      MODIFY SCREEN.
    ENDLOOP.
  ENDIF.