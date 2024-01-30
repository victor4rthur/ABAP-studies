*&---------------------------------------------------------------------*
*& Report Z_AD_AULA5_4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ad_aula5_4.

TABLES: kna1.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECTION-SCREEN SKIP.
PARAMETERS: r_local  RADIOBUTTON GROUP rad1 USER-COMMAND flg, "Local
            r_server RADIOBUTTON GROUP rad1 DEFAULT 'X'. "Server
SELECTION-SCREEN SKIP.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
PARAMETERS: p_local  LIKE rlgrap-filename DEFAULT 'C:\'.
PARAMETERS: p_server LIKE rlgrap-filename DEFAULT '/default'.
SELECTION-SCREEN END OF BLOCK b2.
SELECTION-SCREEN SKIP.


SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-003.
SELECT-OPTIONS: s_kunnr FOR kna1-kunnr, "Customer Number 1
                s_land1 FOR kna1-land1. "Country Key
SELECTION-SCREEN END OF BLOCK b3.
SELECTION-SCREEN SKIP.

SELECTION-SCREEN END OF BLOCK b1.

INITIALIZATION.

  p_local = 'Teste de preenchimento antes da tela.'.

AT SELECTION-SCREEN OUTPUT. " Evento de saída da tela de seleção

*  Check if ratio button is seleted
*  Local
  IF r_local = 'X'.
    LOOP AT SCREEN.
      IF "screen-name = 'P_LOCAL'. " OR
        screen-name = '%_P_LOCAL_%_APP_%-TEXT'.
        screen-invisible = '0'.
        screen-input = '1'.
        MODIFY SCREEN.
      ELSEIF screen-name = 'P_SERVER'. " OR
        screen-name = '%_P_SERVER_%_APP_%-TEXT'.
        screen-invisible = '1'.
        screen-output = '0'.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.

*SERVER
  ELSE.
    LOOP AT SCREEN.
      IF screen-name = 'P_SERVER' OR
         screen-name = '%_P_SERVER_%_APP_%-TEXT'.
        screen-invisible = '0'.
        screen-input = '0'.
        MODIFY SCREEN.
      ELSEIF screen-name = 'P_LOCAL' OR
             screen-name = '%_P_LOCAL_%_APP_%-TEXT' OR
             screen-name = '%_S_KUNNR_%_APP_%-TEXT' OR
             screen-name = '%_S_KUNNR_%_APP_%-OPTI_PUSH' OR
             screen-name = 'S_KUNNR-LOW' OR
             screen-name = '%_S_KUNNR_%_APP_%-TO_TEXT' OR
             screen-name = 'S_KUNNR-HIGH' OR
             screen-name = '%_S_KUNNR_%_APP_%-VALU_PUSH'.       .
        screen-invisible = '1'.
        screen-input = '0'.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ENDIF.

START-OF-SELECTION.
  WRITE:'Fim do programa'.