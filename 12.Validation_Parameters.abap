*&---------------------------------------------------------------------*
*& Report z_ad_aula9
*&---------------------------------------------------------------------*
*& Valida se o parameter foi inserido e se existe.
*&---------------------------------------------------------------------*
REPORT z_ad_aula9.


TABLES: ekko,
        mara.

*DATA: t_mara_valid  TYPE TABLE OF mara.        "Tabela criada para validação dos dados
*DATA: wa_mara_valid TYPE mara.                 "Work área para ser usada em conjuto com a tabela acima

DATA: v_erro TYPE c.                            "Variável para indicar erros

CONSTANTS: c_x TYPE c VALUE 'X'.                "Constante com o valor de X

PARAMETERS: p_matnr TYPE mara-matnr,            "Parâmetro de entrada com base no campo MATNR da MARA
            p_mtart TYPE mara-mtart.
CLEAR: v_erro.                                  "Limpa valores de v_erro caso possuam alguma sujeira em execução anterior


*-----------------------------------------------------------------------------*
* Início do programa
*-----------------------------------------------------------------------------*
PERFORM f_valida_dados .

*-----------------------------------------------------------------------------*
* Só continua o processamento se não foi encontrado nenhum erro nas validações
*-----------------------------------------------------------------------------*
CHECK v_erro IS INITIAL.

FORM f_valida_dados .

*--------------------------------------------------------------------*
* Verifica se o Parameter está preenchido
*--------------------------------------------------------------------*
  IF p_matnr IS NOT INITIAL.                      "Sempre verificar se o campo está preenchido

    SELECT SINGLE *                               "Requer todos os campos chave estejam no Where
      FROM mara
      INTO mara                                   "Estrutura criada no Tables
      WHERE matnr EQ p_matnr.

*--------------------------------------------------------------------*
* Valida se o conteúdo foi encontrado, se não, exibir mensagem de erro
*--------------------------------------------------------------------*
    IF sy-subrc NE 0.
      MESSAGE TEXT-001 TYPE 'S' DISPLAY LIKE 'E'. "Material não encontrado para essa seleção
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