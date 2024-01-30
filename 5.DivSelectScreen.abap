*&---------------------------------------------------------------------*
*& Report Z_AD_AULA6_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ad_aula6_2.

* Definindo a tela de sele��o com tr�s par�metros
SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_valor1(10) TYPE c,     "Valor a dividir
            p_valor2(10) TYPE c.     "Divisor
PARAMETERS: p_valor3(10) TYPE c.
SELECTION-SCREEN: END OF BLOCK b1.

* Evento chamado quando o usu�rio interage com o par�metro p_valor3
AT SELECTION-SCREEN ON p_valor3.

  TRY.
      p_valor3 = p_valor1 / p_valor2.

    CATCH cx_sy_zerodivide INTO DATA(lo_error). "Erro da divis�o por zero que pega a mensagem de erro autom�tica
      MESSAGE lo_error->get_longtext( ) TYPE 'S' DISPLAY LIKE 'E'.

    CATCH cx_sy_conversion_no_number INTO DATA(lo_error2). "Erro da divis�o por letras que pega a mensagem de erro autom�tica
      MESSAGE lo_error2->get_longtext( ) TYPE 'S' DISPLAY LIKE 'E'.

  ENDTRY.

* Evento chamado antes da tela de sele��o ser exibida
AT SELECTION-SCREEN OUTPUT.

  " Verifica se a divis�o foi bem-sucedida (nenhuma exce��o foi capturada)
  IF sy-subrc = 0.
    " Atualiza p_valor3 com o resultado da divis�o
    LOOP AT SCREEN.
      IF screen-name = 'P_VALOR3'.
        screen-input = '0'.   " Desativa a entrada manual para p_valor3
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ENDIF.