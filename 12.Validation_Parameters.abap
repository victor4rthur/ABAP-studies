*&---------------------------------------------------------------------*
*& Report z_ad_aula9
*&---------------------------------------------------------------------*
*& Valida se o parameter foi inserido e se existe.
*&---------------------------------------------------------------------*
REPORT z_ad_aula9.


TABLES: ekko,
        mara.

*DATA: t_mara_valid  TYPE TABLE OF mara.        "Tabela criada para valida��o dos dados
*DATA: wa_mara_valid TYPE mara.                 "Work �rea para ser usada em conjuto com a tabela acima

DATA: v_erro TYPE c.                            "Vari�vel para indicar erros

CONSTANTS: c_x TYPE c VALUE 'X'.                "Constante com o valor de X

PARAMETERS: p_matnr TYPE mara-matnr,            "Par�metro de entrada com base no campo MATNR da MARA
            p_mtart TYPE mara-mtart.
CLEAR: v_erro.                                  "Limpa valores de v_erro caso possuam alguma sujeira em execu��o anterior


*-----------------------------------------------------------------------------*
* In�cio do programa
*-----------------------------------------------------------------------------*
PERFORM f_valida_dados .

*-----------------------------------------------------------------------------*
* S� continua o processamento se n�o foi encontrado nenhum erro nas valida��es
*-----------------------------------------------------------------------------*
CHECK v_erro IS INITIAL.

FORM f_valida_dados .

*--------------------------------------------------------------------*
* Verifica se o Parameter est� preenchido
*--------------------------------------------------------------------*
  IF p_matnr IS NOT INITIAL.                      "Sempre verificar se o campo est� preenchido

    SELECT SINGLE *                               "Requer todos os campos chave estejam no Where
      FROM mara
      INTO mara                                   "Estrutura criada no Tables
      WHERE matnr EQ p_matnr.

*--------------------------------------------------------------------*
* Valida se o conte�do foi encontrado, se n�o, exibir mensagem de erro
*--------------------------------------------------------------------*
    IF sy-subrc NE 0.
      MESSAGE TEXT-001 TYPE 'S' DISPLAY LIKE 'E'. "Material n�o encontrado para essa sele��o
      v_erro = c_x.
    ENDIF.

  ENDIF.

  IF p_mtart IS NOT INITIAL.

    SELECT SINGLE mtart
    FROM mara
    INTO mara-mtart
    WHERE mtart EQ p_mtart.

    IF sy-subrc NE 0.
      MESSAGE TEXT-002 TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.
  ENDIF.
ENDFORM .